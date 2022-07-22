Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71CE557DA92
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jul 2022 09:03:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234288AbiGVHD3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jul 2022 03:03:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229505AbiGVHDZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jul 2022 03:03:25 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BACB78C8FB;
        Fri, 22 Jul 2022 00:03:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3991B62166;
        Fri, 22 Jul 2022 07:03:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 390DFC341C6;
        Fri, 22 Jul 2022 07:03:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1658473403;
        bh=U+bwqGe/Uw+KLlP9rXlbt0HuOPEaJCOOpylTNHgxmTw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nkU94rp+y6V9eXdp0MUFhbx9hSZrGjRzCl3D2/Wb+7Dg9wtjTy27lmFtz+W+cUmpR
         fOt4F2R2kmE1+N2Cv/wrHRmgenaiZ07ouQqWMZjfZcCSl93YszgTOPUDZVQi8ZLxMn
         Oc9jogXOCUOi1zgmO/vbaI1Evpq2RJYw7Sqv257o=
Date:   Fri, 22 Jul 2022 09:03:20 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Yan Xinyu <sdlyyxy@bupt.edu.cn>
Cc:     johan@kernel.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] USB: serial: usb_wwan: replace DTR/RTS magic numbers
 with macros
Message-ID: <YtpLuJPUT8DXZUTx@kroah.com>
References: <20220721155257.631793-1-sdlyyxy@bupt.edu.cn>
 <YtmYWbRtbNvph6lF@kroah.com>
 <6C016E08-5348-45EB-98BE-84F4BE3BA417@bupt.edu.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6C016E08-5348-45EB-98BE-84F4BE3BA417@bupt.edu.cn>
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 22, 2022 at 10:40:51AM +0800, Yan Xinyu wrote:
> > On Jul 22, 2022, at 02:18, Greg KH <gregkh@linuxfoundation.org> wrote:
> > 
> > On Thu, Jul 21, 2022 at 11:52:57PM +0800, Yan Xinyu wrote:
> >> The usb_wwan_send_setup function generates DTR/RTS signals in compliance
> >> with CDC ACM standard. This patch changes magic numbers in this function
> >> to equivalent macros.
> >> 
> >> Signed-off-by: Yan Xinyu <sdlyyxy@bupt.edu.cn>
> >> ---
> >> v1->v2:
> >> * Fix Signed-off-by name.
> >> ---
> >> drivers/usb/serial/usb_wwan.c | 13 +++++++++----
> >> 1 file changed, 9 insertions(+), 4 deletions(-)
> >> 
> >> diff --git a/drivers/usb/serial/usb_wwan.c b/drivers/usb/serial/usb_wwan.c
> >> index dab38b63eaf7..a6bd6144702d 100644
> >> --- a/drivers/usb/serial/usb_wwan.c
> >> +++ b/drivers/usb/serial/usb_wwan.c
> >> @@ -29,10 +29,14 @@
> >> #include <linux/bitops.h>
> >> #include <linux/uaccess.h>
> >> #include <linux/usb.h>
> >> +#include <linux/usb/cdc.h>
> >> #include <linux/usb/serial.h>
> >> #include <linux/serial.h>
> >> #include "usb-wwan.h"
> >> 
> >> +#define ACM_CTRL_DTR 0x01
> >> +#define ACM_CTRL_RTS 0x02
> > 
> > Why are these not in the cdc.h file already?
> 
> These are defined in the drivers/usb/class/cdc-acm.h file. Is it safe
> to include it?

Yes, of course!
