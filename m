Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB893563FCA
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Jul 2022 13:41:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231897AbiGBLkt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Jul 2022 07:40:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbiGBLkr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Jul 2022 07:40:47 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 44D6ADFE3
        for <linux-kernel@vger.kernel.org>; Sat,  2 Jul 2022 04:40:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1656762045;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=N1gV0SWQGG0jtxPst9R8skJs6pB6sIXEtXSGdtyycaY=;
        b=ixAtNuJT8SMpwArHqie7Ww8NC6UX6jTOyylfbvcpI6vbeTTyVhye7bHhTshaPzYxxdZ24s
        8ztKHYBtzi0wTZbMaq1jEXIQWDz1a8k+2FJ+jjeWq/kFrH1iv6UvWthCQK+1P3qITvLsAk
        eCzrunq5Si4MngdKPPWnVPrWX+ANsys=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-622-Sk-v8XqWOzGFwWMehkdcCQ-1; Sat, 02 Jul 2022 07:40:43 -0400
X-MC-Unique: Sk-v8XqWOzGFwWMehkdcCQ-1
Received: by mail-wm1-f70.google.com with SMTP id be8-20020a05600c1e8800b003a069fe18ffso4376540wmb.9
        for <linux-kernel@vger.kernel.org>; Sat, 02 Jul 2022 04:40:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=N1gV0SWQGG0jtxPst9R8skJs6pB6sIXEtXSGdtyycaY=;
        b=2F0fLxdSJTbEhIytwtozqxR8ulKMA/DQapUW2UHidke0uMsS0lsrBeKzWKKORE/Xa/
         aKlph5f3NYn6/CM2obNEOGMyY2zLOssER5CfBnnYzuwZBaM020vThODOji2um5b35eb8
         hzigPa36gOj1rcrZGZZGBKFN3rkeQloDJTTm+W42izHJHUzKgWHxcDHyHpDd9PNLfWlg
         8YpZqH66CULgMtZlkGqk0knCWhE1nNkqJ5tcveoYV6ekXGYMOjJsXqMqYKzuTY22Csqm
         u8jLGrOf5BIzD9D1nACmcg/1JyqQq9sbHQLY+YzI1VLxurnhCIhzACWE2sHvfWWZMtXa
         oESw==
X-Gm-Message-State: AJIora+zJ4OA6xxdVP5B8o+jLkGCP0UNiu6Y/yfTqzoaxAFR4R/A2RPH
        pMyKb+/jjTHT/aBrMrwmS7X+wTKwJqaBI/6rUpbFOggwF0QK1lZtiFrYRLCDxKJRcJdj9gzqJsd
        dpnv39NTa9hWVU+qRn6J2gf2v
X-Received: by 2002:a5d:65c3:0:b0:21b:bca9:83b1 with SMTP id e3-20020a5d65c3000000b0021bbca983b1mr17978548wrw.568.1656762042558;
        Sat, 02 Jul 2022 04:40:42 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1smlbPjXQrVerb4/3Ymo2Qf1Ug72Ro6TTlgsuyqWW26iQT6fsK+QD8Wszhjm8qWkLiad+LSYA==
X-Received: by 2002:a5d:65c3:0:b0:21b:bca9:83b1 with SMTP id e3-20020a5d65c3000000b0021bbca983b1mr17978529wrw.568.1656762042322;
        Sat, 02 Jul 2022 04:40:42 -0700 (PDT)
Received: from [192.168.1.129] (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id e20-20020a5d5954000000b0020fcaba73bcsm25124017wri.104.2022.07.02.04.40.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 02 Jul 2022 04:40:41 -0700 (PDT)
Message-ID: <05f5a0a0-5583-29cb-5406-77d24987d39f@redhat.com>
Date:   Sat, 2 Jul 2022 13:40:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v3 2/9] drm: selftest: convert drm_cmdline_parser selftest
 to KUnit
Content-Language: en-US
To:     =?UTF-8?Q?Ma=c3=adra_Canal?= <maira.canal@usp.br>,
        Isabella Basso <isabbasso@riseup.net>, magalilemes00@gmail.com,
        tales.aparecida@gmail.com, mwen@igalia.com, andrealmeid@riseup.net,
        siqueirajordao@riseup.net, Trevor Woerner <twoerner@gmail.com>,
        leandro.ribeiro@collabora.com, n@nfraprado.net,
        Daniel Vetter <daniel@ffwll.ch>,
        Shuah Khan <skhan@linuxfoundation.org>,
        David Airlie <airlied@linux.ie>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        michal.winiarski@intel.com,
        =?UTF-8?B?Sm9zw6kgRXhww7NzaXRv?= <jose.exposito89@gmail.com>,
        David Gow <davidgow@google.com>,
        Daniel Latypov <dlatypov@google.com>, brendanhiggins@google.com
Cc:     kunit-dev@googlegroups.com, linux-kselftest@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Arthur Grillo <arthur.grillo@usp.br>
References: <20220630004611.114441-1-maira.canal@usp.br>
 <20220630004611.114441-3-maira.canal@usp.br>
From:   Javier Martinez Canillas <javierm@redhat.com>
In-Reply-To: <20220630004611.114441-3-maira.canal@usp.br>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/30/22 02:46, Maíra Canal wrote:
> Considering the current adoption of the KUnit framework, convert the
> DRM cmdline parser selftest to the KUnit API.
> 
> Acked-by: Daniel Latypov <dlatypov@google.com>
> Tested-by: David Gow <davidgow@google.com>
> Co-developed-by: Arthur Grillo <arthur.grillo@usp.br>
> Signed-off-by: Arthur Grillo <arthur.grillo@usp.br>
> Signed-off-by: Maíra Canal <maira.canal@usp.br>
> ---

Same comment for patch #1 apply to all the others. I think you need
to change the order of these.

[...]

> diff --git a/drivers/gpu/drm/tests/drm_cmdline_parser_test.c b/drivers/gpu/drm/tests/drm_cmdline_parser_test.c
> new file mode 100644
> index 000000000000..ca7669350c64
> --- /dev/null
> +++ b/drivers/gpu/drm/tests/drm_cmdline_parser_test.c
> @@ -0,0 +1,1078 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (c) 2019 Bootlin

I believe is fair for you to add your Copyright here too since the test
changed considerably when ported to the KUnit framework API. Same for
the other tests.

> + */
> +
> +#include <kunit/test.h>

Please add a blank line here. And this also applies to all other tests.

> +#include <drm/drm_connector.h>
> +#include <drm/drm_modes.h>
> +

Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>

-- 
Best regards,

Javier Martinez Canillas
Linux Engineering
Red Hat

