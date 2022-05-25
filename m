Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26DB653464C
	for <lists+linux-kernel@lfdr.de>; Thu, 26 May 2022 00:17:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244277AbiEYWRD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 May 2022 18:17:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231497AbiEYWRB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 May 2022 18:17:01 -0400
X-Greylist: delayed 801 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 25 May 2022 15:16:58 PDT
Received: from mail.cybernetics.com (mail.cybernetics.com [173.71.130.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F955674F2
        for <linux-kernel@vger.kernel.org>; Wed, 25 May 2022 15:16:58 -0700 (PDT)
X-ASG-Debug-ID: 1653516215-1cf43917f331a700001-xx1T2L
Received: from cybernetics.com ([10.10.4.126]) by mail.cybernetics.com with ESMTP id Rknskv3T8OKRxMlK; Wed, 25 May 2022 18:03:35 -0400 (EDT)
X-Barracuda-Envelope-From: tonyb@cybernetics.com
X-ASG-Whitelist: Client
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=cybernetics.com; s=mail;
        bh=sU13TqLXk+7AWmq6eJY05xWo8ZNDJZzve3vZq00wJGg=;
        h=Content-Transfer-Encoding:Content-Type:Subject:From:Cc:To:Content-Language:
        MIME-Version:Date:Message-ID; b=P1xnIcbk190Gr/tZ1Jma2N3n4rRPkF12HxtF9jXVvhoK1
        EOWI0EtKUVPl18rB9UyY1mfuL1RHCE8CqJ1NkjuZnLQnfeVJPtbND7s9FHZ1i6BHvvsv1/9axaFCL
        xinaOiGWA6nZXUaX0mCn9tV+UrqCPqTC8UYp2Bt/EhA4Pb2Yg=
Received: from [10.157.2.224] (HELO [192.168.200.1])
  by cybernetics.com (CommuniGate Pro SMTP 7.1.1)
  with ESMTPS id 11817808; Wed, 25 May 2022 18:03:35 -0400
Message-ID: <baef87c3-5dad-3b47-44c1-6914bfc90108@cybernetics.com>
Date:   Wed, 25 May 2022 18:03:34 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Content-Language: en-US
To:     Saurav Kashyap <skashyap@marvell.com>,
        Nilesh Javali <njavali@marvell.com>,
        GR-QLogic-Storage-Upstream@marvell.com
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        regressions@lists.linux.dev
From:   Tony Battersby <tonyb@cybernetics.com>
Subject: [REGRESSION] qla2xxx: tape drive not removed after unplug FC cable
Content-Type: text/plain; charset=UTF-8
X-ASG-Orig-Subj: [REGRESSION] qla2xxx: tape drive not removed after unplug FC cable
Content-Transfer-Encoding: 8bit
X-Barracuda-Connect: UNKNOWN[10.10.4.126]
X-Barracuda-Start-Time: 1653516215
X-Barracuda-URL: https://10.10.4.122:443/cgi-mod/mark.cgi
X-Barracuda-BRTS-Status: 1
X-Virus-Scanned: by bsmtpd at cybernetics.com
X-Barracuda-Scan-Msg-Size: 2149
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

#regzbot introduced: 44c57f205876

I have several different QLogic FC HBAs (8, 16, 32 Gbps) and several
different FC LTO tape drives (IBM Ultrium 8 & 9).  When I plug in the FC
cable, the tape drive shows up as a SCSI device as expected.  With older
kernels, when I unplug the FC cable, the tape drive SCSI device would
disappear after about 30 seconds.  But with newer kernels (including
5.18), when I unplug the FC cable, the tape drive SCSI device never
disappears.  I have bisected the change in behavior to the following
commit in kernel 5.15:

44c57f205876 ("scsi: qla2xxx: Changes to support FCP2 Target")

This commit has been backported to various -stable kernels, so they are
also affected.

When testing with two different tape drives:
1) Plug FC cable into tape drive A.  Tape drive A shows up as a SCSI device.
2) Unplug FC cable; wait 60 seconds.  Tape drive A does not disappear.
3) Plug FC cable into tape drive B.  Tape drive A disappears 30 seconds
later, but tape drive B does not show up.
4) Unplug FC cable and plug it back into tape drive B.  Tape drive B
shows up as a SCSI device.

So I can actually make a tape drive disappear by plugging the cable into
a different tape drive, but then I have to reseat the cable again to
make the new tape drive show up.

lspci -n
83:00.0 0c04: 1077:2031 (rev 02)
83:00.1 0c04: 1077:2031 (rev 02)

When plugging in cable:
qla2xxx [0000:83:00.1]-500a:7: LOOP UP detected (8 Gbps).

When unplugging cable with old kernel:
qla2xxx [0000:83:00.1]-500b:7: LOOP DOWN detected (2 7 0 0).
rport-7:0-2: blocked FC remote port time out: removing target and saving binding

When unplugging cable with new kernel:
qla2xxx [0000:83:00.1]-500b:7: LOOP DOWN detected (2 7 0 0).

/sys/class/fc_remote_ports/rport-*/
dev_loss_tmo: 30
supported_classes: Class 3
port_state: Online
(port_state remains Online even when FC cable unplugged)

/proc/scsi/scsi
Host: scsi7 Channel: 00 Id: 01 Lun: 00
  Vendor: IBM      Model: ULTRIUM-HH8      Rev: K4K1
  Type:   Sequential-Access                ANSI  SCSI revision: 06

Tony Battersby
Cybernetics

