Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB17C4B6E52
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 15:07:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238515AbiBOOHR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 09:07:17 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:33758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238508AbiBOOHP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 09:07:15 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C916F6A39D;
        Tue, 15 Feb 2022 06:07:05 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 63D986175E;
        Tue, 15 Feb 2022 14:07:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65811C340ED;
        Tue, 15 Feb 2022 14:07:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1644934024;
        bh=npFLVpEh73ePajA6yVLxydXgeScMGNmeCsTfKW2ZvBw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=J6f7RqcCqaIWC2zar2P4aZoHHUpVYwvbbNCkvhUI+Bk2qaObnXF1hnRPqH/Kb3zaM
         2/+FUF26wif66N77ZP6bDQSU511RTeSQYm5P/xN+E90Rd/5uNwWs7xi3BT/CN5AKi3
         FVr+s7ByYLfSG0sh+f/1TeGis2dKA341gf4nnyN8=
Date:   Tue, 15 Feb 2022 15:07:02 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     3090101217@zju.edu.cn
Cc:     balbi@kernel.org, jleng@ambarella.com,
        laurent.pinchart@ideasonboard.com, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org
Subject: Re: [PATCH v2] usb: gadget: f_uvc: fix superspeedplus transfer
Message-ID: <Yguzht2JJtF+8N76@kroah.com>
References: <Ygow+EB1P84VflBb@kroah.com>
 <20220215021647.4316-1-3090101217@zju.edu.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220215021647.4316-1-3090101217@zju.edu.cn>
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 15, 2022 at 10:16:47AM +0800, 3090101217@zju.edu.cn wrote:
> From: Jing Leng <jleng@ambarella.com>
> 
> UVC driver doesn't set ssp_descriptors in struct usb_function,
> If UVC uses superspeedplus UDC (e.g. cdnsp), when
> config_ep_by_speed_and_alt is called, the g->speed is
> USB_SPEED_SUPER_PLUS, and f->ssp_descriptors is NULL,
> So kernel will access NULL pointer of speed_desc.
> 
> Call trace:
>  config_ep_by_speed_and_alt+0x3c/0x2a0 [libcomposite]
>  uvc_function_set_alt+0xd4/0x2e8 [usb_f_uvc]
>  set_config.constprop.0+0x154/0x3a0 [libcomposite]
>  composite_setup+0x314/0xb44 [libcomposite]
>  configfs_composite_setup+0x84/0xb0 [libcomposite]
>  cdnsp_ep0_std_request+0x25c/0x470 [cdns3]
>  cdnsp_setup_analyze+0x94/0x25c [cdns3]
>  cdnsp_handle_event+0xe8/0x23c [cdns3]
>  cdnsp_thread_irq_handler+0x58/0xe8 [cdns3]
>  irq_thread_fn+0x2c/0xa0
>  irq_thread+0x164/0x280
>  kthread+0x128/0x134
>  ret_from_fork+0x10/0x40

What does "call trace" here mean?  Is this an error?  Something else?

> 
> Signed-off-by: Jing Leng <jleng@ambarella.com>
> ---
>  drivers/usb/gadget/function/f_uvc.c | 14 ++++++++++++--
>  1 file changed, 12 insertions(+), 2 deletions(-)

You did not read the information that my bot told you to read, for how
to properly version your patches :(

Please go back and do so when you resend all of them.

Also this is not a patch series?  Why not?

thanks,

greg k-h
