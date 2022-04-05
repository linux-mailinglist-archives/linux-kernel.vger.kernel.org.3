Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B83584F5130
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 04:30:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1845351AbiDFByV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Apr 2022 21:54:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1446406AbiDEPof (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 11:44:35 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AB42F55F0
        for <linux-kernel@vger.kernel.org>; Tue,  5 Apr 2022 07:15:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EAB3560AF3
        for <linux-kernel@vger.kernel.org>; Tue,  5 Apr 2022 14:15:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 065EEC385A1;
        Tue,  5 Apr 2022 14:15:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1649168111;
        bh=9snd2J+IFOny+x+vO6FjBRT2ONIjM/C5Zx5DF6aGf3Q=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=it+8FRw91Co+V+C46WDIbd4XicXEtbW66WkyVLbmmeKIfLREQlcs4iN8815gsav5W
         WJsq9j51Kv2NZvE+OcGaQVfQ3bjVN5yMH58fDTzPEQmcRn3iSfR10Rb0iicccG6CMh
         VbKyQ4L5eBRkEuX7BLifd/ZtECVTnuUR6wuTk9j0=
Date:   Tue, 5 Apr 2022 16:15:08 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     xkernel.wang@foxmail.com
Cc:     Larry.Finger@lwfinger.net, florian.c.schilhabel@googlemail.com,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: rtl8712: fix a potential memory leak in
 r871xu_drv_init()
Message-ID: <YkxO7HPTsF4CvPe6@kroah.com>
References: <tencent_B8048C592777830380A23A7C4409F9DF1305@qq.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <tencent_B8048C592777830380A23A7C4409F9DF1305@qq.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 05, 2022 at 12:43:07PM +0800, xkernel.wang@foxmail.com wrote:
> From: Xiaoke Wang <xkernel.wang@foxmail.com>
> 
> In r871xu_drv_init(), if r8712_init_drv_sw() fails, then the memory
> allocated by r8712_alloc_io_queue() in r8712_usb_dvobj_init() is not
> properly released as there is no action will be performed by
> r8712_usb_dvobj_deinit().
> To properly release it, we should call r8712_free_io_queue() in
> r8712_usb_dvobj_deinit().
> 
> Besides, in r871xu_dev_remove(), r8712_usb_dvobj_deinit() will be called
> by r871x_dev_unload() under condition `padapter->bup` and
> r8712_free_io_queue() is called by r8712_free_drv_sw().
> However, r8712_usb_dvobj_deinit() does not rely on `padapter->bup` and
> calling r8712_free_io_queue() in r8712_free_drv_sw() is negative for
> better understading the code.
> So I move r8712_usb_dvobj_deinit() into r871xu_dev_remove(), and remove
> r8712_free_io_queue() from r8712_free_drv_sw().
> 
> Signed-off-by: Xiaoke Wang <xkernel.wang@foxmail.com>
> ---
>  drivers/staging/rtl8712/os_intfs.c | 1 -
>  drivers/staging/rtl8712/usb_intf.c | 6 +++---
>  2 files changed, 3 insertions(+), 4 deletions(-)

I've applied this patch, but dropped all of your other pending ones.
Please fix up the remaining ones like this and resend.

thanks,

greg k-h
