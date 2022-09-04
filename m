Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73B825AC4DC
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Sep 2022 16:57:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234406AbiIDO4u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Sep 2022 10:56:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229783AbiIDO4p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Sep 2022 10:56:45 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6ED30357F9;
        Sun,  4 Sep 2022 07:56:41 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id p7so9936202lfu.3;
        Sun, 04 Sep 2022 07:56:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=fC3lh2YMOyHrManyFcmY7+Wx+z/ZpVeqWfU4+YdqBv4=;
        b=jWJ6WZaSrU9FfU2y0hsSVm6LyRs2Cu3lKLTVy/RIID88varEs+jkY7d1VruP3yuqf2
         mAjDDF9c1emAj8wh4Hyp2XPYob1i8GENIbDMHmBUriGC36YJARdCRPS2cE54QgvHWznw
         7mVrjAuI624Hp7e0UVmNr0mL9qJn4nh9sWzYQt3L7xdBxIrnipBwRYnPG8/RwEwyz6Xn
         1QH/Kv8YTC29XXLg6OmzqXsCbT1mNRAPKxYBrnaAEKHCIgdgBnT+aXqsbCZi0VC0x/cA
         mU8MXo4zaMwPyA4tYjptrWZoG66L8WfMu+HaYxEwAFKSSBPvKsti/VtABlRtYWul9Orn
         HeVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=fC3lh2YMOyHrManyFcmY7+Wx+z/ZpVeqWfU4+YdqBv4=;
        b=lm/FenI7xuLLkt45qkSe8Adj603HTyf/lmvPbkgRT55BHaveSyAelxbbApcVtU3kCA
         9nmKhkYxdH+VIh9jNhbnqAuoGN5+7jE8DrHjOEZ+L6DZxV9eV4RdJWAzBwvKYfz2JmN6
         wsVFyVQAMadz0QhZW5SQiU1NN1P9GKDlQFxFowOdM7s/uvojcnbIvXO190IMMVwYwONF
         vbqjMISrx9t/X90APtgs4Z4It9IJjqmSiU1repef9oKBcAFxLU66U9nFFxOIhuW8hf8j
         BiehbLpGRtEZsCMhG+YGMHMRosGqDj0ZgC7t8YhLz/SyZKHlBNKmmik5jNs5jlnXeUOy
         BS7g==
X-Gm-Message-State: ACgBeo2rgUoid5ScXFeDsoNlmebuivBVhj8dsDGwQ2L50Y9mglmhc/Sf
        T91biup1/J30f6pEuzjsZH0=
X-Google-Smtp-Source: AA6agR61c8An6mbrNZfhfHKEubyxAYbejF29KvnHLmiAlYpPv9/3q/F9sPfNQEADHmqOVrKU4YEokg==
X-Received: by 2002:a05:6512:4002:b0:494:5dc9:b2fe with SMTP id br2-20020a056512400200b004945dc9b2femr11247598lfb.687.1662303399672;
        Sun, 04 Sep 2022 07:56:39 -0700 (PDT)
Received: from [192.168.2.145] ([109.252.119.13])
        by smtp.googlemail.com with ESMTPSA id m13-20020ac2428d000000b00492eeabd6f8sm933897lfh.52.2022.09.04.07.56.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 04 Sep 2022 07:56:39 -0700 (PDT)
Message-ID: <7294f049-f58f-6ca8-6315-ad062d775bcf@gmail.com>
Date:   Sun, 4 Sep 2022 17:56:37 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH v17 02/10] video/hdmi: Add audio_infoframe packing for DP
Content-Language: en-US
To:     Bo-Chen Chen <rex-bc.chen@mediatek.com>, chunkuang.hu@kernel.org,
        p.zabel@pengutronix.de, daniel@ffwll.ch, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, mripard@kernel.org,
        tzimmermann@suse.de, matthias.bgg@gmail.com, deller@gmx.de,
        airlied@linux.ie
Cc:     devicetree@vger.kernel.org, linux-fbdev@vger.kernel.org,
        granquet@baylibre.com, jitao.shi@mediatek.com,
        liangxu.xu@mediatek.com, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, msp@baylibre.com,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        linux-mediatek@lists.infradead.org, wenst@chromium.org,
        linux-arm-kernel@lists.infradead.org,
        angelogioacchino.delregno@collabora.com
References: <20220901044149.16782-1-rex-bc.chen@mediatek.com>
 <20220901044149.16782-3-rex-bc.chen@mediatek.com>
From:   Dmitry Osipenko <digetx@gmail.com>
In-Reply-To: <20220901044149.16782-3-rex-bc.chen@mediatek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

01.09.2022 07:41, Bo-Chen Chen пишет:
> diff --git a/include/drm/display/drm_dp.h b/include/drm/display/drm_dp.h
> index 9e3aff7e68bb..6c0871164771 100644
> --- a/include/drm/display/drm_dp.h
> +++ b/include/drm/display/drm_dp.h
> @@ -1536,6 +1536,8 @@ enum drm_dp_phy {
>  #define DP_SDP_VSC_EXT_CEA		0x21 /* DP 1.4 */
>  /* 0x80+ CEA-861 infoframe types */
>  
> +#define DP_SDP_AUDIO_INFOFRAME_HB2	0x1b

Is there any good reason why this is not grouped with the rest of the
DP_SDP_* defines above?
