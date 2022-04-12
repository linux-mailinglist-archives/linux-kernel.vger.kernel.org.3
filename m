Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB9484FCE52
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Apr 2022 06:56:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347184AbiDLE6f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Apr 2022 00:58:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347035AbiDLE6d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Apr 2022 00:58:33 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6865F11C14
        for <linux-kernel@vger.kernel.org>; Mon, 11 Apr 2022 21:56:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EE2F0617E4
        for <linux-kernel@vger.kernel.org>; Tue, 12 Apr 2022 04:56:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D03D7C385A1;
        Tue, 12 Apr 2022 04:56:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1649739375;
        bh=m6VSt+/v92P1Zg4jzcDGMViyz4qsqAMT7JU7EYUuzrw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XBsvbAIF0QEh7W6YUXlTe15h0Z8iar99m1/jK+vE1MRBUmrj0RIvjCPobYTf1BFOd
         s0bgHJKvz5h/MNww7jnZf5XH0Od3r2VIQTtYRWudOz8l7gD1cc8Xw0qEWqUGArCKIl
         ITWIyqvUQr4j1ChMzkPezdF/PC+SmZdieWIkK5Eg=
Date:   Tue, 12 Apr 2022 06:56:12 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Jaehee Park <jhpark1013@gmail.com>
Cc:     Johan Hovold <johan@kernel.org>, Alex Elder <elder@kernel.org>,
        greybus-dev@lists.linaro.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org, outreachy@lists.linux.dev
Subject: Re: [PATCH] staging: greybus: replace zero-element array with
 flexible-array
Message-ID: <YlUGbFs8oNikJCcv@kroah.com>
References: <20220411211411.GA2796005@jaehee-ThinkPad-X1-Extreme>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220411211411.GA2796005@jaehee-ThinkPad-X1-Extreme>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 11, 2022 at 05:14:11PM -0400, Jaehee Park wrote:
> Zero-length and one-element arrays are deprecated. Flexible-array
> members should be used instead. Flexible-array members are
> recommended because this is the way the kernel expects dynamically
> sized trailing elements to be declared.
> Refer to Documentation/process/deprecated.rst.
> 
> Change the zero-length array, buf, in the struct 
> gb_usb_hub_control_response to a flexible array. And add wLength as a 
> member of the struct so that the struct is not a zero-sized struct.
> 
> Issue found by flexible_array coccinelle script.
> 
> Signed-off-by: Jaehee Park <jhpark1013@gmail.com>
> ---
> 
> I have a question for the authors: 
> I saw a fixme comment in the hub_control function in usb.c:
> / FIXME: handle unspecified lengths /
> 
> I was wondering why this comment was left there?
> 
> In this patch, I'm using this struct:
> 
> struct gb_usb_hub_control_response {
>     __le16 wLength;
>     u8 buf[];
> };
> 
> And instead of using response_size, I'm doing this:
> 
> struct gb_usb_hub_control_response *response;
> And using sizeof(*response) as the input to gb_operation_create.
> 
> Would the flexible array address the handling of unspecified lengths 
> issue (in the fixme comment)?

No, you can not change the format of the data on the bus without also
changing the firmware in the device and usually the specification as
well.

>  drivers/staging/greybus/usb.c | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/staging/greybus/usb.c b/drivers/staging/greybus/usb.c
> index 8e9d9d59a357..d0b2422401df 100644
> --- a/drivers/staging/greybus/usb.c
> +++ b/drivers/staging/greybus/usb.c
> @@ -27,7 +27,8 @@ struct gb_usb_hub_control_request {
>  };
>  
>  struct gb_usb_hub_control_response {
> -	u8 buf[0];
> +	__le16 wLength;
> +	u8 buf[];

What is wrong with buf[0] here?

You can fix this in other ways if you really understand the difference
between [0] and [] in C.  Please look at many of the other conversions
if you wish to do this.

thanks,

greg k-h
