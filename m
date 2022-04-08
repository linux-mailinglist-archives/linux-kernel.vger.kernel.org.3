Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A29CB4F90AD
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Apr 2022 10:23:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231679AbiDHIZ3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Apr 2022 04:25:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231201AbiDHIZX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Apr 2022 04:25:23 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6D52D3888
        for <linux-kernel@vger.kernel.org>; Fri,  8 Apr 2022 01:23:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1649406197;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FUcwtvoATPKcbLJbMiymueRtIS1H2mxW0mqljwxnCkI=;
        b=LkzHLKiSjR9le31eBSloJQ89QdTv8FyvWhznQaC+EGXIIS/tCJPuyxCQ+MpoT3WybJzoS0
        WffVdHqXnpO19iwt/W312k9MZFDSj1hQ6L6JKIQ+HkMOs9xFddET3j4X+yGRxd90GG13n8
        qz/D1lM4y1/4qVV2ebwuwgskPqH/ZrQ=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-12-9zCOkBeqPo23XMKztqALHw-1; Fri, 08 Apr 2022 04:23:16 -0400
X-MC-Unique: 9zCOkBeqPo23XMKztqALHw-1
Received: by mail-wr1-f71.google.com with SMTP id j18-20020adfa552000000b002060a011303so1992092wrb.14
        for <linux-kernel@vger.kernel.org>; Fri, 08 Apr 2022 01:23:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=FUcwtvoATPKcbLJbMiymueRtIS1H2mxW0mqljwxnCkI=;
        b=3CwtGaoOLDLakaTcyt/oAq8SsUcTuzC9MECWbadylgs28ujO53/lYk35LxWZIAX5CT
         pB02d+H/zaM+iFvTGw1uCkIAnS34bNthPmRlOl/nPaA//jn/wNN0KhlElDvU/gveCvAh
         gnoEN1YzU6oE01+vGP7Sf5Grnkw/gRJ2ZliDTw2ZD1yaqJFMIB6bhWOvZZEFMZEQzieF
         BQLtKkzsmP4oGgZp4JyJ3XtgkZWews+4+cOryTU+SEIyrb4FNrNaiIFMk9ub+n8ZQ6RW
         GuHR9cx5GsNelQsM10sLMN7VJaZMc5KYuI9wMKLoQXV8wPaWoAb6ea/kVWdx3Lh7AIsw
         +nLA==
X-Gm-Message-State: AOAM531Seo3FK6MiBvm4Q9ijFGitizdvTRejnhJGL4BQXTPXUe/6DRp4
        poSIFuIg3C1LTy+yxcTwi/Pkkk3e2l4rI+zwRJ6IFYTzrefPPUoHb6m0qU/Qwg1P9h2yBY3OD7j
        Rog6DPdhV0f8p9LT0RKIi8fp0
X-Received: by 2002:a05:600c:218f:b0:38e:9e76:d3d4 with SMTP id e15-20020a05600c218f00b0038e9e76d3d4mr2736726wme.53.1649406195145;
        Fri, 08 Apr 2022 01:23:15 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx8JHzx8H7yOzKjvWesVxprpjTwS5/70usS+SbIiXVLP90ZSgvc+nVUJsdy9HtKMZxtFTJa3g==
X-Received: by 2002:a05:600c:218f:b0:38e:9e76:d3d4 with SMTP id e15-20020a05600c218f00b0038e9e76d3d4mr2736712wme.53.1649406194920;
        Fri, 08 Apr 2022 01:23:14 -0700 (PDT)
Received: from [192.168.1.102] ([92.176.231.205])
        by smtp.gmail.com with ESMTPSA id 3-20020a5d47a3000000b0020412ba45f6sm22799702wrb.8.2022.04.08.01.23.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 08 Apr 2022 01:23:14 -0700 (PDT)
Message-ID: <67634336-4711-d643-03d3-d2514af55917@redhat.com>
Date:   Fri, 8 Apr 2022 10:23:12 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH 4/5] drm/solomon: Move device info from ssd130x-i2c to the
 core driver
Content-Language: en-US
To:     Neil Armstrong <narmstrong@baylibre.com>,
        linux-kernel@vger.kernel.org
Cc:     Chen-Yu Tsai <wens@kernel.org>, David Airlie <airlied@linux.ie>,
        dri-devel@lists.freedesktop.org, Mark Brown <broonie@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
References: <20220407200205.28838-1-javierm@redhat.com>
 <20220407200205.28838-5-javierm@redhat.com>
 <58e38622-a041-3e5c-3dca-fa95cd5f59be@baylibre.com>
From:   Javier Martinez Canillas <javierm@redhat.com>
In-Reply-To: <58e38622-a041-3e5c-3dca-fa95cd5f59be@baylibre.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Neil,

Thanks for your feedback.

On 4/8/22 09:49, Neil Armstrong wrote:

[snip]

>>   
>> +static struct ssd130x_deviceinfo ssd130x_variants[] =  {
>> +	{
>> +		.default_vcomh = 0x40,
>> +		.default_dclk_div = 1,
>> +		.default_dclk_frq = 5,
>> +		.page_mode_only = 1,
>> +	},
> 
> Why not [SH1106_ID] = {
> 
> and later:
> 
> if (variant < NR_SSD130X_VARIANTS)
> 	ssd130x->device_info = ssd130x_variants[variant];
> 
> instead of less efficient ssd13x_variant_to_info ?
>

Indeed. I'll change that in v2.

-- 
Best regards,

Javier Martinez Canillas
Linux Engineering
Red Hat

