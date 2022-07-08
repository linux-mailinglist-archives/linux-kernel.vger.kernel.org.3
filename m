Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8756056C215
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Jul 2022 01:12:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239885AbiGHT33 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jul 2022 15:29:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239813AbiGHT2q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jul 2022 15:28:46 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 391D4248D9
        for <linux-kernel@vger.kernel.org>; Fri,  8 Jul 2022 12:28:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1657308516;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=x1DAicwEAPXBRBMe3z1xdAg47wBYVrbByTqaE+qHnm8=;
        b=WoYx4/IUSp/Xz5ON3UXG7AHNt7zUshD6+AesLMGbAmEhoBXxwv1RUC7dESICrq1BnwyL7V
        rRK9rDQH0YchL+292/jRWAZVDjSFNmiWeYvSMUC8m3y66F0T96pg+oCtOwYUml+KdjgYaH
        gC7EKG7+gtTdW83YAo+4UNZ1vJXC568=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-2-8ePKhVXDPLGzXnam0E9sGA-1; Fri, 08 Jul 2022 15:28:35 -0400
X-MC-Unique: 8ePKhVXDPLGzXnam0E9sGA-1
Received: by mail-ed1-f69.google.com with SMTP id q18-20020a056402519200b004358ce90d97so16455151edd.4
        for <linux-kernel@vger.kernel.org>; Fri, 08 Jul 2022 12:28:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=x1DAicwEAPXBRBMe3z1xdAg47wBYVrbByTqaE+qHnm8=;
        b=RLGjhhrAyQgv9RrsJ64qDCrcf+i8IZN002KLNvhFOl10uu/EA0CVXzL7R/xjXflONp
         xTaj/Upy+vSh/rJdD4PA0Trg2rUth7fssKscHWonfN1aWcqgZn8xpSQ3bQNq5Ol+fauD
         kgR37ScUqtYRJdvfj+2ETgE0bgVHlz307IIN3Wl9AtuTEj5pG9Ok0amyOhgeP/5THCVk
         My27/qKySvwqyBE/HW/BB8fK6HtLD7WT8fN6gcrkBW0gYdKbxHZSNvaCrQGdCCtfsnju
         tGaT6p1434CEwURS5PIp3dZWjX7mFzDhHv5V2DewMXaV+2aRXp9Je5bDMMa7y4coUDcg
         H3ZA==
X-Gm-Message-State: AJIora/YrHCPl0D2xC3P3ZdMjkLH5JK6kqCctti04axgM+KCnbi1IiY1
        DsoPI8HVzGC9Fj+GLdnYRaCvNu2VRAuGKnbWFmM8/wdZO1AuCAlHDvd9k+mbea0GFl7cb9QCfAX
        WxZk64jXNeVjll1I5Qbd24eD6
X-Received: by 2002:a17:907:86ac:b0:72a:fc15:98cf with SMTP id qa44-20020a17090786ac00b0072afc1598cfmr5087112ejc.474.1657308513962;
        Fri, 08 Jul 2022 12:28:33 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1tkr+qWhrSzebZjZZfUfQqb4WSOleYalB7Ps0X+jp4B93iKsB3HUIVAIpQMdnYN+LbhqwjjIg==
X-Received: by 2002:a17:907:86ac:b0:72a:fc15:98cf with SMTP id qa44-20020a17090786ac00b0072afc1598cfmr5087099ejc.474.1657308513789;
        Fri, 08 Jul 2022 12:28:33 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c1e:bf00:d69d:5353:dba5:ee81? (2001-1c00-0c1e-bf00-d69d-5353-dba5-ee81.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:d69d:5353:dba5:ee81])
        by smtp.gmail.com with ESMTPSA id h17-20020a1709060f5100b00705cdfec71esm20550294ejj.7.2022.07.08.12.28.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 08 Jul 2022 12:28:33 -0700 (PDT)
Message-ID: <b7d937bc-d7c3-6f7a-047c-fc6e5756a5a0@redhat.com>
Date:   Fri, 8 Jul 2022 21:28:32 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH 1/5] drm/modes: parse_cmdline: Handle empty mode name part
Content-Language: en-US
To:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        linux-m68k@vger.kernel.org, linux-kernel@vger.kernel.org
References: <cover.1657301107.git.geert@linux-m68k.org>
 <64e2e9b14c26df28908789374253fd12072c26c2.1657301107.git.geert@linux-m68k.org>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <64e2e9b14c26df28908789374253fd12072c26c2.1657301107.git.geert@linux-m68k.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Geert,

On 7/8/22 20:21, Geert Uytterhoeven wrote:
> If no mode name part was specified, mode_end is zero, and the "ret ==
> mode_end" check does the wrong thing.
> 
> Fix this by checking for a non-zero return value instead.

Which is wrong to do, since now if you have e.g. a mode list
with:

"dblntsc",
"dblntsc-ff"

in there and the cmdline contains "dblntsc-ff" then you
will already stop with a (wrong!) match at "dblntsc".

> While at it, skip all named mode handling when mode_end is zero, as it
> is futile.

AFAICT, this is actually what needs to be done to fix this, while keeping
the ret == mode_end check.

Regards,

Hans


> 
> Fixes: 7b1cce760afe38b4 ("drm/modes: parse_cmdline: Allow specifying stand-alone options")
> Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
> ---
>  drivers/gpu/drm/drm_modes.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/drm_modes.c b/drivers/gpu/drm/drm_modes.c
> index 14b746f7ba975954..30a7be97707bfb16 100644
> --- a/drivers/gpu/drm/drm_modes.c
> +++ b/drivers/gpu/drm/drm_modes.c
> @@ -1823,9 +1823,9 @@ bool drm_mode_parse_command_line_for_connector(const char *mode_option,
>  	}
>  
>  	/* First check for a named mode */
> -	for (i = 0; i < ARRAY_SIZE(drm_named_modes_whitelist); i++) {
> +	for (i = 0; mode_end && i < ARRAY_SIZE(drm_named_modes_whitelist); i++) {
>  		ret = str_has_prefix(name, drm_named_modes_whitelist[i]);
> -		if (ret == mode_end) {
> +		if (ret) {
>  			if (refresh_ptr)
>  				return false; /* named + refresh is invalid */
>  

