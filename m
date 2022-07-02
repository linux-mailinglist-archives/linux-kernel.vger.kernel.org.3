Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 286C4563FE6
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Jul 2022 13:52:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232195AbiGBLtA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Jul 2022 07:49:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229592AbiGBLs7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Jul 2022 07:48:59 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C3DB812082
        for <linux-kernel@vger.kernel.org>; Sat,  2 Jul 2022 04:48:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1656762537;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kBzEfGWVygyiM8W1L6ivraoo44EoMnZSdZ7RWUgjnqY=;
        b=g3JAbkomZPLx8vst9ye1bafNMitfBXaPUYd23QzMkhTNYMHMMHWHiXx5rCmYlDgdPzQM/d
        GhrLjvqrT6edxlvyiCIEEmB4BuRcYUydSjMKA4fwRfwHXzjg40qqr3fTABwFKeOkY9jG5+
        XAiXm/SaNI5NBsekP+N9p744TmPQg5I=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-37-4eco-nPYOoGIZQmwvT58tA-1; Sat, 02 Jul 2022 07:48:56 -0400
X-MC-Unique: 4eco-nPYOoGIZQmwvT58tA-1
Received: by mail-wm1-f72.google.com with SMTP id be8-20020a05600c1e8800b003a069fe18ffso4383529wmb.9
        for <linux-kernel@vger.kernel.org>; Sat, 02 Jul 2022 04:48:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=kBzEfGWVygyiM8W1L6ivraoo44EoMnZSdZ7RWUgjnqY=;
        b=v9miPi2eFOpsuei3sEm0K6nQFW2jcvZTHFN3kmWPyGBni+rGzpf2L4HtMgOJos8IZw
         etlpHiIn92ph3rFrx4Ao7Ad9Yg3uop6dgHISdUEKd1jiccNU3mfWXrnt/Xct8Xgj6Sbu
         SdfA2dkgPsiSzcV/aKDfr0UVT2JGzIoXM1PVOhX/md+BLhxSh7DyIuzBkYIG3F4y8JPV
         /MCXmdN09vkNjmpb+knu31XfyGCHrb8ZMo1ekUoCVLnLbbIxcduECB9jFdeAp361zRfZ
         hj+0AwvXh8AmcRRn4XbFnJrtCVLt13HdJF9V77LSd+89vIo1LW0526bfHrx1cba96gJp
         kl1A==
X-Gm-Message-State: AJIora8/vfAadwV6FP0xva9UMDKxugZaYgJ6E5QiD4OuiOZzvBTqEivZ
        lb3yzRz9XqqX9TvYedIXENDeDNiMie4x1Bjmp/Omwc9bEnxSgmBwEyH/kAukVX1JFHKgEDxjHmQ
        m0L6esOvnevKbC/dRKyDCapGJ
X-Received: by 2002:a05:600c:4fc8:b0:3a1:987c:82d4 with SMTP id o8-20020a05600c4fc800b003a1987c82d4mr1515592wmq.26.1656762535554;
        Sat, 02 Jul 2022 04:48:55 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1swi8yT8lpV7nvJfPgVektW9uU61vfUOnnidEB+Xc2gOSrZeoWzU44iyITMmphx0FKxo3RADw==
X-Received: by 2002:a05:600c:4fc8:b0:3a1:987c:82d4 with SMTP id o8-20020a05600c4fc800b003a1987c82d4mr1515575wmq.26.1656762535333;
        Sat, 02 Jul 2022 04:48:55 -0700 (PDT)
Received: from [192.168.1.129] (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id e3-20020adfef03000000b0021bbd525b8esm25724496wro.45.2022.07.02.04.48.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 02 Jul 2022 04:48:54 -0700 (PDT)
Message-ID: <5e612797-3506-527c-46c5-cae9045c69e4@redhat.com>
Date:   Sat, 2 Jul 2022 13:48:53 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v3 6/9] drm: selftest: convert drm_dp_mst_helper selftest
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
        Rubens Gomes Neto <rubens.gomes.neto@usp.br>
References: <20220630004611.114441-1-maira.canal@usp.br>
 <20220630004611.114441-7-maira.canal@usp.br>
From:   Javier Martinez Canillas <javierm@redhat.com>
In-Reply-To: <20220630004611.114441-7-maira.canal@usp.br>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/30/22 02:46, Maíra Canal wrote:
> Considering the current adoption of the KUnit framework, convert the
> DRM DP MST helper selftest to the KUnit API.
> 
> Acked-by: Daniel Latypov <dlatypov@google.com>
> Tested-by: David Gow <davidgow@google.com>
> Co-developed-by: Rubens Gomes Neto <rubens.gomes.neto@usp.br>
> Signed-off-by: Rubens Gomes Neto <rubens.gomes.neto@usp.br>
> Signed-off-by: Maíra Canal <maira.canal@usp.br>
> ---

Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>

-- 
Best regards,

Javier Martinez Canillas
Linux Engineering
Red Hat

