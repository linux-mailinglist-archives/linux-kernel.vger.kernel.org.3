Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD5835720AC
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 18:21:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234295AbiGLQVQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jul 2022 12:21:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233997AbiGLQVM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 12:21:12 -0400
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2B94BA15D
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 09:21:11 -0700 (PDT)
Received: by mail-lj1-x22e.google.com with SMTP id c15so10516785ljr.0
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 09:21:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=e+eczaOZHX4TeLEoVuGZvZlc3YvFcSUgKh0OSE0sknQ=;
        b=lhhk7gHDxF++IOnhQqIAX8/FBtvR6oMIoA0r5phxQR/M5KWtbVwj2k4EydEVtu/pIo
         4w9XiIHP2kJ7Y1eHZzAg0f2k89RXidZkf9B65KcvuI/kIPD9t7L+DnaCt8J3qlvWxGmn
         2qGYQNUUFSJUuXXCuU1xPAFs3gz+4JQgHwdPAA06qjYa75mq4n0ZurQNoxUfbPQoPR2h
         Vvl4uRdviZwYFMFsnwRtgRNP7CjW+XWWwnlhW8BWddEcI+LIkrs8ZlrE5ruTZps3US15
         u67OhpdDCmO7BrpVt7+ZICSqDCN3OcoqT8ApozWGNmd4iY12CJMhYRI1SMbUi2bahh/m
         qfQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=e+eczaOZHX4TeLEoVuGZvZlc3YvFcSUgKh0OSE0sknQ=;
        b=ALA/AvfRMQFrRI38SJRMVFV+mpkH+plud7qU3vD1sNiD8vYkfHF27GOlgE4aJf8lSm
         oB+tGRcoVEUL6zZqUI1B9MlcN8fGeSkuFh2y8srrSOwEXj4jkAAsHQvdT8GbXuPw0E8c
         6zBlmbr5WPRxFua+3cA4htwqVMhrMp1bS8NNaNT8nFax/Y8OSNOOnh30ywM7KOQ7A/kU
         /YtBCPlE40O3R4JojwpQd92WbXSngfmjywivlodKnJJVt3dzW2RQp6c4doyBpGJNkYyJ
         i2qJt0n2DL3mKkcXPS0UGJLc2shfrJSWNCfKZPV4YvPYwpoJi8TunYa8ikUAfquDRT7j
         0rXg==
X-Gm-Message-State: AJIora8GiXKiXrsaE5Kf/8Aiz7uaH/V4+0FyMltjJhzWLMUngGkKiSuI
        bf5IPHJhnc2HEfAhsMzuPPwft6EraaNvgEJH
X-Google-Smtp-Source: AGRyM1uy5fRThCPAxo7NecWcdrhI0zdxdkzkxnBuoPdolEFSHJ0KXlb0BgjGw3e9yXOCH9xpzIrJ2A==
X-Received: by 2002:a05:651c:1a0e:b0:25b:baac:f415 with SMTP id by14-20020a05651c1a0e00b0025bbaacf415mr13791659ljb.480.1657642870175;
        Tue, 12 Jul 2022 09:21:10 -0700 (PDT)
Received: from [10.0.0.8] (fwa5da9-171.bb.online.no. [88.93.169.171])
        by smtp.gmail.com with ESMTPSA id s19-20020a056512215300b004855224ead0sm2262352lfr.158.2022.07.12.09.21.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Jul 2022 09:21:09 -0700 (PDT)
Message-ID: <8fccb0fd-a7ea-dc2c-5604-eef3c93f0397@linaro.org>
Date:   Tue, 12 Jul 2022 18:21:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v2 3/7] iommu/exynos: Set correct dma mask for SysMMU v5+
Content-Language: en-US
To:     Sam Protsenko <semen.protsenko@linaro.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>
Cc:     Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Janghyuck Kim <janghyuck.kim@samsung.com>,
        Cho KyongHo <pullip.cho@samsung.com>,
        Daniel Mentz <danielmentz@google.com>,
        David Virag <virag.david003@gmail.com>,
        Sumit Semwal <sumit.semwal@linaro.org>, iommu@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220710230603.13526-1-semen.protsenko@linaro.org>
 <20220710230603.13526-4-semen.protsenko@linaro.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220710230603.13526-4-semen.protsenko@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/07/2022 01:05, Sam Protsenko wrote:
> SysMMU v5+ supports 36 bit physical address space. Set corresponding DMA
> mask to avoid falling back to SWTLBIO usage in dma_map_single() because
> of failed dma_capable() check.
> 
> The original code for this fix was suggested by Marek.
> 
> Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>
> Co-developed-by: Marek Szyprowski <m.szyprowski@samsung.com>
> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>


Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


Best regards,
Krzysztof
