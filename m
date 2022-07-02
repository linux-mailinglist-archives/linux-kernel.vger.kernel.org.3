Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3834D563FED
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Jul 2022 13:52:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232222AbiGBLtW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Jul 2022 07:49:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229592AbiGBLtU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Jul 2022 07:49:20 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0D0B312082
        for <linux-kernel@vger.kernel.org>; Sat,  2 Jul 2022 04:49:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1656762559;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3QljAW1wpF5LQ6Lppj4LbpD/NKcPDm0Kt2W7p8Nse1Y=;
        b=UFMTu9ACPN2ZUNQLOzOzdFYCwFIKHwHN0LCLv54quqUDlqH6clvJlaC/327B1VX8z4zyW0
        3BpVTT+LYz44mG0Eg3rgznyVMcbDD5X4OyxXfPr4MV06hMC16P7bh2wGD14/G7TvzqLxE8
        M2ZJKn3Psab3pVfSV6tiTf0/3XySD4o=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-62-erWnFTAIMJmTIGGH_cjj8w-1; Sat, 02 Jul 2022 07:49:18 -0400
X-MC-Unique: erWnFTAIMJmTIGGH_cjj8w-1
Received: by mail-wm1-f72.google.com with SMTP id v8-20020a05600c214800b003a1819451b1so2641008wml.7
        for <linux-kernel@vger.kernel.org>; Sat, 02 Jul 2022 04:49:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=3QljAW1wpF5LQ6Lppj4LbpD/NKcPDm0Kt2W7p8Nse1Y=;
        b=yFFByxnfmmEmfppUBcwj33wOYSvPftxOe6VoJaEH5wR1gXfpeQQcXONUGCIa6iLOWw
         Cc85wdWE/48nXceaUBMNyUWJEk7Dmb+2eE6gKvyWjor746bRdGrTMtWN5XiUjmQWyU8f
         eYQeK1mJOVM6bpCRNM5US7wMAY2WJyAd+vvrgwfqLLUdOc3iJP8Bf2kSIiGY0ltEO5dD
         I6M36TbhXaIuGCdV9GBGe8/SpFSPjx3SFHL7J7bwnlLHhPThA89xmgPmRJECLu5Po3RT
         i+Q6D7KiASKzumuX6BHRewjpeyaYJr1AtuwYYCkja8YC9Xvn62VXWLO6AEYr080QgmOj
         UgNQ==
X-Gm-Message-State: AJIora8lZRkd6JtUVAqdWsG1K4ZayR+Gkh78pYsLcsd7zV3pY4rH3vc1
        3zIaGGGS6TgEjlzlbUU4xLgwtYNohhn1kReOOZTVVNxtCPaI/zyK8I0qOJczG6wsfMkg+1dv/hq
        DbbYJ4wXPtplWaVtAjHYF6Ssu
X-Received: by 2002:a1c:f607:0:b0:3a0:3dc9:c4db with SMTP id w7-20020a1cf607000000b003a03dc9c4dbmr23130323wmc.30.1656762556859;
        Sat, 02 Jul 2022 04:49:16 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1uL6HCPra+ZwxL9odjC4yxV6gp1l0uanbnl1D0jTwoMGNi5QU3bPL4RKfaaq5orx/y4BlNXNw==
X-Received: by 2002:a1c:f607:0:b0:3a0:3dc9:c4db with SMTP id w7-20020a1cf607000000b003a03dc9c4dbmr23130289wmc.30.1656762556606;
        Sat, 02 Jul 2022 04:49:16 -0700 (PDT)
Received: from [192.168.1.129] (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id m17-20020adfe0d1000000b0021b866397a7sm25369955wri.1.2022.07.02.04.49.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 02 Jul 2022 04:49:16 -0700 (PDT)
Message-ID: <a32a8720-f2e3-c80e-3ece-4822e9088254@redhat.com>
Date:   Sat, 2 Jul 2022 13:49:14 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v3 7/9] drm: selftest: convert drm_framebuffer selftest to
 KUnit
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
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20220630004611.114441-1-maira.canal@usp.br>
 <20220630004611.114441-8-maira.canal@usp.br>
From:   Javier Martinez Canillas <javierm@redhat.com>
In-Reply-To: <20220630004611.114441-8-maira.canal@usp.br>
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
> DRM framebuffer selftest to the KUnit API.
> 
> Acked-by: Daniel Latypov <dlatypov@google.com>
> Tested-by: David Gow <davidgow@google.com>
> Signed-off-by: Maíra Canal <maira.canal@usp.br>
> ---

Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>

-- 
Best regards,

Javier Martinez Canillas
Linux Engineering
Red Hat

