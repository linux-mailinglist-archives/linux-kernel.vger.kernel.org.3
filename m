Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F10E54A788F
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Feb 2022 20:13:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346893AbiBBTNx convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 2 Feb 2022 14:13:53 -0500
Received: from mta-06-3.privateemail.com ([198.54.127.59]:54211 "EHLO
        MTA-06-3.privateemail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230442AbiBBTNv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Feb 2022 14:13:51 -0500
Received: from mta-06.privateemail.com (localhost [127.0.0.1])
        by mta-06.privateemail.com (Postfix) with ESMTP id C211018000BB;
        Wed,  2 Feb 2022 14:13:50 -0500 (EST)
Received: from smtpclient.apple (unknown [10.20.151.192])
        by mta-06.privateemail.com (Postfix) with ESMTPA id C3FB318000B3;
        Wed,  2 Feb 2022 14:13:48 -0500 (EST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 15.0 \(3693.60.0.1.1\))
Subject: Re: [PATCHv3] habanalabs: fix potential spectre v1 gadgets
From:   Jordy Zomer <jordy@pwning.systems>
In-Reply-To: <20220202191104.3526448-1-jordy@pwning.systems>
Date:   Wed, 2 Feb 2022 20:13:46 +0100
Cc:     Oded Gabbay <ogabbay@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ofir Bitton <obitton@habana.ai>,
        Dani Liberman <dliberman@habana.ai>,
        Yuri Nudelman <ynudelman@habana.ai>,
        Sagiv Ozeri <sozeri@habana.ai>, Koby Elbaz <kelbaz@habana.ai>,
        farah kassabri <fkassabri@habana.ai>
Content-Transfer-Encoding: 8BIT
Message-Id: <EC712491-2563-4822-A54B-244638EB656E@pwning.systems>
References: <YfrVOylHQYqjiWJ5@kroah.com>
 <20220202191104.3526448-1-jordy@pwning.systems>
To:     linux-kernel@vger.kernel.org
X-Mailer: Apple Mail (2.3693.60.0.1.1)
X-Virus-Scanned: ClamAV using ClamSMTP
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sorry! Removed the message and hope the line-wrapping is correct now :)

> On 2 Feb 2022, at 20:11, Jordy Zomer <jordy@pwning.systems> wrote:
> 
> It appears like nr could be a Spectre v1 gadget as it's supplied by a
> user and used as an array index. Prevent the contents of kernel memory
> being leaked  to userspace via speculative execution by using
> array_index_nospec.
> 
> Signed-off-by: Jordy Zomer <jordy@pwning.systems>
> 
> ---
> Changes v1 -> v2: Added the correct offsets
> Changes v2 -> v3: Fixed line-wrapping
> ---
> drivers/misc/habanalabs/common/habanalabs_ioctl.c | 3 +++
> 1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/misc/habanalabs/common/habanalabs_ioctl.c b/drivers/misc/habanalabs/common/habanalabs_ioctl.c
> index 3ba3a8ffda3e..c1cdf712a10d 100644
> --- a/drivers/misc/habanalabs/common/habanalabs_ioctl.c
> +++ b/drivers/misc/habanalabs/common/habanalabs_ioctl.c
> @@ -14,6 +14,7 @@
> #include <linux/fs.h>
> #include <linux/uaccess.h>
> #include <linux/slab.h>
> +#include <linux/nospec.h>
> 
> static u32 hl_debug_struct_size[HL_DEBUG_OP_TIMESTAMP + 1] = {
> 	[HL_DEBUG_OP_ETR] = sizeof(struct hl_debug_params_etr),
> @@ -849,6 +850,7 @@ long hl_ioctl(struct file *filep, unsigned int cmd, unsigned long arg)
> 	}
> 
> 	if ((nr >= HL_COMMAND_START) && (nr < HL_COMMAND_END)) {
> +		nr = array_index_nospec(nr, HL_COMMAND_END);
> 		ioctl = &hl_ioctls[nr];
> 	} else {
> 		dev_err(hdev->dev, "invalid ioctl: pid=%d, nr=0x%02x\n",
> @@ -872,6 +874,7 @@ long hl_ioctl_control(struct file *filep, unsigned int cmd, unsigned long arg)
> 	}
> 
> 	if (nr == _IOC_NR(HL_IOCTL_INFO)) {
> +		nr = array_index_nospec(nr, _IOC_NR(HL_IOCTL_INFO)+1);
> 		ioctl = &hl_ioctls_control[nr];
> 	} else {
> 		dev_err(hdev->dev_ctrl, "invalid ioctl: pid=%d, nr=0x%02x\n",
> -- 
> 2.27.0
> 

