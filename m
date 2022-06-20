Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37C54551FBF
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jun 2022 17:07:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242824AbiFTPGu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jun 2022 11:06:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242374AbiFTPGU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jun 2022 11:06:20 -0400
Received: from smtp1.axis.com (smtp1.axis.com [195.60.68.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 071D4100E;
        Mon, 20 Jun 2022 07:43:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; q=dns/txt; s=axis-central1; t=1655736219;
  x=1687272219;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=Na3GHwh2nPIlcEioUu2L4Q9Qk2l1gWyv/bLyqBui10c=;
  b=a3j1NuVif+KCfAl5geHnr21ipGQbuWuSPp8uuXwGnlUIX8r8db8NqC7s
   WBm4+pPbPUmroALH5cjuORJLZ0rtWSQana0N04Ef34DlUqMSQ8cu1XXZc
   HMYXpak+gyqbVnAgL/36TArkSNS/o+oH7VJdCr+nisE2/AjjmccQ893nm
   +LVmzJSB2seAJObTdTejeWGgQuPDqU+maVx0kMmP4GwN7XKSF2r/DC7Jf
   ZfkUhL/jMa74DfNl4yxw7fUV5j4kuB9x+6Gtx0O7yl180jCQaGALCoZwL
   b+Kl6UK3ND2oaqymSkfPBPcy5A2X+Gj2fW7PY9UAVfOQ59kenYPm7LI/Z
   w==;
Date:   Mon, 20 Jun 2022 16:42:31 +0200
From:   Vincent Whitchurch <vincent.whitchurch@axis.com>
To:     <rafael.j.wysocki@intel.com>, <jic23@kernel.org>
CC:     <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-iio@vger.kernel.org>
Subject: PM runtime_error handling missing in many drivers?
Message-ID: <20220620144231.GA23345@axis.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Many drivers do something like the following to resume their hardware
before performing some hardware access when user space ask for it:

	ret = pm_runtime_resume_and_get(dev);
	if (ret)
		return ret;

But if the ->runtime_resume() callback fails, then the
power.runtime_error is set and any further attempts to use
pm_runtime_resume_and_get() will fail, as documented in
Documentation/power/runtime_pm.rst.

This means that if a driver sees an error even once from, say, an I2C
transaction in its ->runtime_resume() callback, then the driver will
permanently stop to work.  My guess is that this is *not* the behaviour
intended by driver writers.  I would expect that the driver re-attempts
to access the hardware the next time user space tries to use the device,
so that the driver is resilient against temporary failures.

I noticed this with drivers/iio/light/vcnl4000.c.

During a read of iio:device0/in_illuminance_raw, an error is injected
into the I2C transaction (the dump_stack() indicates the location) and
the I2C transaction fails:

[110190.730000][   T27] rpm_resume: 0-0009 flags-4 cnt-1  dep-0  auto-1 p-0 irq-0 child-0
[110190.730000][   T27] i2c_write: i2c-0 #0 a=009 f=0000 l=3 [00-00-00]
[110778.040000][   T27] i2c_result: i2c-0 n=1 ret=0
[110778.040000][   T27] CPU: 0 PID: 27 Comm: python3 Not tainted 5.19.0-rc3+ #71
[110778.040000][   T27] Stack:
[110778.040000][   T27]  60a27dc6 60a27dc6 688af710 61085fc0
[110778.040000][   T27]  61085f90 60a27dc6 60069bf0 00000001
[110778.040000][   T27]  688af750 60905626 609055b3 61085fe0
[110778.040000][   T27] Call Trace:
[110778.040000][   T27]  [<608d05dc>] show_stack.cold+0x166/0x2a7
[110778.040000][   T27]  [<60905626>] dump_stack_lvl+0x73/0x92
[110778.040000][   T27]  [<6090566e>] dump_stack+0x29/0x31
[110778.040000][   T27]  [<6092463e>] __i2c_transfer.cold+0x28/0x49
[110778.040000][   T27]  [<607445dd>] i2c_smbus_xfer_emulated+0x28d/0xc60
[110778.040000][   T27]  [<607452c2>] __i2c_smbus_xfer+0x312/0x8e0
[110778.040000][   T27]  [<60745a40>] i2c_smbus_xfer+0x1b0/0x2e0
[110778.040000][   T27]  [<60745e76>] i2c_smbus_write_word_data+0x46/0x60
[110778.040000][   T27]  [<68968755>] vcnl4200_set_power_state+0x45/0x160 [vcnl4000]
[110778.040000][   T27]  [<689680ee>] vcnl4000_runtime_resume+0x2e/0x40 [vcnl4000]
[110778.040000][   T27]  [<606d262f>] __rpm_callback+0x5f/0x3e0
[110778.040000][   T27]  [<606d2b44>] rpm_callback+0x194/0x1e0
[110778.040000][   T27]  [<606d48fb>] rpm_resume+0xd5b/0x11d0
[110778.040000][   T27]  [<606d5a77>] __pm_runtime_resume+0xb7/0x120
[110778.040000][   T27]  [<68969903>] vcnl4000_set_pm_runtime_state.isra.0+0x43/0x1f0 [vcnl4000]
[110778.040000][   T27]  [<68969b36>] vcnl4000_read_raw+0x86/0x250 [vcnl4000]
[110778.040000][   T27]  [<607794fd>] iio_read_channel_info+0x10d/0x130
[110778.040000][   T27]  [<60698553>] dev_attr_show+0x23/0x80
[110778.040000][   T27]  [<60441174>] sysfs_kf_seq_show+0x144/0x2d0
[110778.040000][   T27]  [<6043ce9e>] kernfs_seq_show+0x2e/0x40
[110778.040000][   T27]  [<6033fe40>] seq_read_iter+0x310/0xb20
[110778.040000][   T27]  [<6043e0ea>] kernfs_fop_read_iter+0x2da/0x520
[110778.040000][   T27]  [<602cd46e>] new_sync_read+0x1ae/0x2f0
[110778.040000][   T27]  [<602d1e84>] vfs_read+0x344/0x4a0
[110778.040000][   T27]  [<602d2885>] ksys_read+0xb5/0x270
[110778.040000][   T27]  [<602d2a63>] sys_read+0x23/0x30
[110778.040000][   T27]  [<60051aea>] handle_syscall+0x1ba/0x250
[110778.040000][   T27]  [<6006be9b>] userspace+0x3bb/0x600
[110778.040000][   T27]  [<60047c8b>] fork_handler+0xcb/0xe0
[110778.040000][   T27] rpm_idle: i2c-0 flags-5 cnt-0  dep-0  auto-1 p-0 irq-0 child-0
[110778.040000][   T27] rpm_return_int: rpm_idle+0x250/0x970:i2c-0 ret=-11
[110778.040000][   T27] rpm_return_int: rpm_resume+0x24d/0x11d0:0-0009 ret=-5

The above is OK, the read of the file naturally fails since
pm_runtime_resume_and_get() fails.  But all further reads of the file
from user space fail even before getting to any register access, due to
the behaviour described above.

[110778.050000][   T27] rpm_resume: 0-0009 flags-4 cnt-1  dep-0  auto-1 p-0 irq-0 child-0
[110778.050000][   T27] rpm_return_int: rpm_resume+0x24d/0x11d0:0-0009 ret=-22

The following patch fixes the issue on vcnl4000, but is this the right
fix?  And, unless I'm missing something, there are dozens of drivers
with the same problem.

diff --git a/drivers/iio/light/vcnl4000.c b/drivers/iio/light/vcnl4000.c
index e02e92bc2928..082b8969fe2f 100644
--- a/drivers/iio/light/vcnl4000.c
+++ b/drivers/iio/light/vcnl4000.c
@@ -414,6 +414,8 @@ static int vcnl4000_set_pm_runtime_state(struct vcnl4000_data *data, bool on)
 
 	if (on) {
 		ret = pm_runtime_resume_and_get(dev);
+		if (ret)
+			pm_runtime_set_suspended(dev);
 	} else {
 		pm_runtime_mark_last_busy(dev);
 		ret = pm_runtime_put_autosuspend(dev);
