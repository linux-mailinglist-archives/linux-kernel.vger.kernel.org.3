Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6136C572960
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 00:35:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233471AbiGLWfH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jul 2022 18:35:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229693AbiGLWfG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 18:35:06 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC79CC3AEE;
        Tue, 12 Jul 2022 15:35:04 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id g16-20020a17090a7d1000b001ea9f820449so608382pjl.5;
        Tue, 12 Jul 2022 15:35:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=72J7TCt8+zxMrSHffLMPTA0BXv+7mgfFyxy0hmazDXY=;
        b=OyB8mtybFPMIy1/hqXY+UCkeFlzb4YKwlbOnHk3mDQB0jlMi2c6KP+wFF+s7LmXEww
         HvZKytNi6U4alFk7wNpUEpm9hw3WwEhp3ek6vGqV4WM7+2IhLcpQvwivZCoM7MUegEYl
         bEpvzzKOm+QhLdZXOxeHIIm5rkEgBwjd4NN1fzpLP784OY/Z+q9GrGB7/gONuq0z7glc
         meYawaEJOqbpQoZrd5glcknlBN7GaYkXtd2RAVT3scemww49v9M1VPxx08MbiUoG4vfm
         cQVjga6tKrXaAxFcKmA1QcWTpi1jkQot7qTvUxpbyMl6HBmr0tB13nbCNUqlKZLBp9o5
         yXBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=72J7TCt8+zxMrSHffLMPTA0BXv+7mgfFyxy0hmazDXY=;
        b=zv2kMf+lMyGihirYvgHJaD1pFpii9M7Xp4z1QPiJf49rrmiVRsJ8+AJEjSWj9B2L06
         ZkQ73XhhGXIyT0TkGz7ypbKNbIA/BkfgAXloWWOIf50ok/Y4g+iClr2YLovYLU1/9FuG
         AR+GuXtreJDx2W1XGF9FNIypUrjg58SvrIz1Jac9lB7Jtmr9scqTZf60jOdAWIxWYCkl
         Eavv8OHFaDXcQjVrOObuvnKCArQKs6bhmXvtSf76PLn+h1K+qb0dHrFCF/pvwj9WFHKo
         FJQhWcH8g8TK7ed8Og/RBSBMRT+Ci/GZ62wx9/YCkgmEZxfMy9kNoWulwQ7AmxM/hhNt
         f/cg==
X-Gm-Message-State: AJIora9ZJJ7w+MjU3qligUcChoS+tDgUBlBsUswQ+1Tt8LmtdiDB+hT5
        DdpVvi9Hm4nzeP1HAA3u1IHotqWlxyU=
X-Google-Smtp-Source: AGRyM1tCBhP5yfWPibLu4jTYbnGFOi1qxc7mhwNzjwP3PADQBoc/nKuga9RFb3fiVUz6MHiDHeBnBA==
X-Received: by 2002:a17:90b:3a84:b0:1f0:56d5:4600 with SMTP id om4-20020a17090b3a8400b001f056d54600mr6892308pjb.162.1657665304119;
        Tue, 12 Jul 2022 15:35:04 -0700 (PDT)
Received: from google.com ([2620:15c:202:201:a31e:fcfb:1279:f5f8])
        by smtp.gmail.com with ESMTPSA id z1-20020aa79901000000b0050dc7628171sm7306772pff.75.2022.07.12.15.35.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Jul 2022 15:35:03 -0700 (PDT)
Date:   Tue, 12 Jul 2022 15:35:00 -0700
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        Nergi Rahardi <nergi@google.com>,
        "Daniel J . Ogorchock" <djogorchock@gmail.com>
Subject: Re: [PATCH] HID: nintendo: Add missing array termination
Message-ID: <Ys33FIuNEsyZw8EF@google.com>
References: <20220712221705.1847793-1-linux@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220712221705.1847793-1-linux@roeck-us.net>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 12, 2022 at 03:17:05PM -0700, Guenter Roeck wrote:
> joycon_dpad_inputs_jc[] is unterminated. This may result in odd warnings
> such as
> 
> input: input_set_capability: invalid code 3077588140 for type 1
> 
> or in kernel crashes in nintendo_hid_probe(). Terminate the array to fix
> the problem.
> 
> Fixes: 2af16c1f846bd ("HID: nintendo: add nintendo switch controller driver")
> Cc: Daniel J. Ogorchock <djogorchock@gmail.com>
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>

Reviewed-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>

I'd recommend tagging stable on this one.

> ---
>  drivers/hid/hid-nintendo.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/hid/hid-nintendo.c b/drivers/hid/hid-nintendo.c
> index 2204de889739..4b1173957c17 100644
> --- a/drivers/hid/hid-nintendo.c
> +++ b/drivers/hid/hid-nintendo.c
> @@ -1586,6 +1586,7 @@ static const unsigned int joycon_button_inputs_r[] = {
>  /* We report joy-con d-pad inputs as buttons and pro controller as a hat. */
>  static const unsigned int joycon_dpad_inputs_jc[] = {
>  	BTN_DPAD_UP, BTN_DPAD_DOWN, BTN_DPAD_LEFT, BTN_DPAD_RIGHT,
> +	0 /* 0 signals end of array */
>  };
>  
>  static int joycon_input_create(struct joycon_ctlr *ctlr)
> -- 
> 2.35.1
> 

Thanks.

-- 
Dmitry
