Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0A6350EB20
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 23:12:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245705AbiDYVOj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 17:14:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244126AbiDYVOc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 17:14:32 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51B237CDFA
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 14:11:24 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id w1so28465732lfa.4
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 14:11:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=oQazfOAFrQddDPrpYfYQVsnloceCr9NIRYCe8QuCQ6s=;
        b=I+UA4zwpy8anE+yetM6ogFnNuFOQr1aWPNEBZ/cAEPjewlmNGZt/BvuRoWneB6JHpE
         2tfBsAH1/w6JbVK55BfytJtNPDSsbJzbZhdA8KuTTsmJSJQJhmTExgq4Uo0wjX+ZnGfD
         8+C43OZp5XDttcVdchpA4kibuxAXLR2yNCyotKEuLazqnqmtNRCCAiKf2Ooc/Zx/N9bH
         yFvmgdixnX2T9q1xr3aadTeeFQWIAblmN5hR6i56qPLXuE6XeGFfxprumpnq7THNtfv8
         230F0/RiXKeyO4bziFdZoxCK2P4zoxDC000QpDQrgGL/Vb1RscArwMstMuLNkQztbq5Q
         id3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=oQazfOAFrQddDPrpYfYQVsnloceCr9NIRYCe8QuCQ6s=;
        b=OUZNyIMNJgV47Svml8q84Y78JqZq1CBRblz7z0qHye6qm/cNLvyMTba9rhCDX6oiw1
         4drf0JRFax3yqS5M9ZLUOYVJDo8dvF8iQwSoiHGu1NqQ5uIcLKny8yq6PTERWxKmJC+o
         wud4CyHf/WHUvSQpQrxpxv69JSUJ5wqTYM9RNaRSeF75ewW4FXC04koKc0DI2bAeCLtf
         jvMOqMG7NBIm4Y+ht6U/yl9LDIOqOTUwE8mGRLwpU7GpNowBpKWOi+CZJe7Rr8KD1mOW
         OxP63g8GGZybGxTkQSmejMtaFg8wLclnaFt4FMHxjXD/3wGn7L61hnNDlKNfODy80XM7
         guRA==
X-Gm-Message-State: AOAM533wMaFpZOqyqyxop5ZGRWPmGVSZgShbpI90BTlDJhoaUSTz7zNg
        rpjBXB+hlUTdh/NCvFxyo8CpeA==
X-Google-Smtp-Source: ABdhPJxcbZtDpr6V9JljEso0M9prK9fOVpFL2+y5PMRZrGKtbo0TOW4NnBVy18JV5UzWakkQ9T4FGQ==
X-Received: by 2002:a05:6512:2828:b0:471:9ef6:f5bf with SMTP id cf40-20020a056512282800b004719ef6f5bfmr14342161lfb.122.1650921082135;
        Mon, 25 Apr 2022 14:11:22 -0700 (PDT)
Received: from [192.168.1.211] ([37.153.55.125])
        by smtp.gmail.com with ESMTPSA id b11-20020a19670b000000b0044a385058acsm1522183lfc.187.2022.04.25.14.11.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Apr 2022 14:11:21 -0700 (PDT)
Message-ID: <1564e2b1-e205-aa44-6a30-38a5160b0ec3@linaro.org>
Date:   Tue, 26 Apr 2022 00:11:20 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH] drm/msm/hdmi: fix error check return value of
 irq_of_parse_and_map()
Content-Language: en-GB
To:     Stephen Boyd <swboyd@chromium.org>, cgel.zte@gmail.com,
        quic_abhinavk@quicinc.com, sean@poorly.run
Cc:     robdclark@gmail.com, airlied@linux.ie, daniel@ffwll.ch,
        angelogioacchino.delregno@collabora.com,
        daniel.thompson@linaro.org, linmq006@gmail.com,
        christophe.jaillet@wanadoo.fr, lv.ruyi@zte.com.cn,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Zeal Robot <zealci@zte.com.cn>
References: <20220425091831.3500487-1-lv.ruyi@zte.com.cn>
 <CAE-0n53xBM+n__eKKGaCuB+3Ea4O+rNk2PUQbD2bjW3JS7YJBA@mail.gmail.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <CAE-0n53xBM+n__eKKGaCuB+3Ea4O+rNk2PUQbD2bjW3JS7YJBA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25/04/2022 23:11, Stephen Boyd wrote:
> Quoting cgel.zte@gmail.com (2022-04-25 02:18:31)
>> From: Lv Ruyi <lv.ruyi@zte.com.cn>
>>
>> The irq_of_parse_and_map() function returns 0 on failure, and does not
>> return a negative value anyhow, so never enter this conditional branch.
>>
>> Fixes: f6a8eaca0ea1 ("drm/msm/mdp5: use irqdomains")
>> Reported-by: Zeal Robot <zealci@zte.com.cn>
>> Signed-off-by: Lv Ruyi <lv.ruyi@zte.com.cn>
>> ---
> 
> This one fixes a commit that moved away from platform APIs!

The change was introduced in 2014 in the commit f6a8eaca0ea1 
("drm/msm/mdp5: use irqdomains"). I can suspect that at that time 
platform irq code wasn't fully compatible with IRQ domains.

> Reviewed-by: Stephen Boyd <swboyd@chromium.org>


-- 
With best wishes
Dmitry
