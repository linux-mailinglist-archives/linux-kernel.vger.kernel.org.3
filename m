Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EAB765720A3
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 18:19:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233981AbiGLQTR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jul 2022 12:19:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234357AbiGLQTM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 12:19:12 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB26BBE6A3
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 09:19:10 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id y11so8252637lfs.6
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 09:19:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=uJ9dVi90hK+YLTAhE7H/lF4J6uUbmiWH1N0eWZR3ZwA=;
        b=TTsXZieu32r3wAaawionSAU7zpQZb8eC0dCJ0JhkT+ecFFSbVnbKVkFmXYyw1029m2
         1GR6KJ4SPcmGBcdCugUqdzSuiNXVea9CTYsurcpyvnfKcrCP7dSeuna0fEgPg5N5WJpD
         hoPACOrCuHbt3ZcML4hZ20i24O19ZQr24EAH14GvGBlggtLW+lL1HkwjutpMHinCzuj5
         iN4Lls3rZp95yjTD9gF2Le10PFvVzjWghz8ngg9LNvxKb8q9hVejhorDbYGxej2kIjIs
         fgoS9+T0y/ecsMzfml0R8/b8EhS/ku/nwBqiBlm0Q7x2mdRB8R2ZT/bhEPUavPo1s4Td
         P02w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=uJ9dVi90hK+YLTAhE7H/lF4J6uUbmiWH1N0eWZR3ZwA=;
        b=GsLt4kyWc7gUpOGplA4mqMelN2O+re2+y61BOL0/fGwrJnSUmXyGYk2m2halv9exrl
         XCx6NmOIJAbjiW7ADRHRrNRrdeQHbveCSacbikMiTClWPlTPEhLknicECNw5wYrI/ECF
         m68d4r17zfeDbX5bB/vSTMbGZRdDQn/4DIr+n3Z1nQ4NoNjdHeI+dfnyCnsHyTFzGvxm
         2uVJk4ZS2lJgGYLQVFMAegrvJWXlcjNXA6pGtwHPEbYHsBm7DjYQuSzwGvl4Ll2LWsxV
         /T6gGaO/FOmO8VtM5H4grTXaxis1q3vFpPh+5I886YVrzueItPZHuLY3YmJIrD1+tJt7
         8K2w==
X-Gm-Message-State: AJIora/Ron/NZJ4lrNdyrqgEUe5cdfGNswZhVnRsukAeZ6Ftud9rpa4r
        9Qe6Ws2zYKBpyGBvvRB7UYMGqQ==
X-Google-Smtp-Source: AGRyM1uGiF4reCluBJM1q38YblixcNGVUMf8QXzKeopoBX/HMPUAtrhZDOIADX//FSe4WDjod3mUAw==
X-Received: by 2002:a05:6512:682:b0:489:16b3:14e1 with SMTP id t2-20020a056512068200b0048916b314e1mr16035039lfe.132.1657642749316;
        Tue, 12 Jul 2022 09:19:09 -0700 (PDT)
Received: from [10.0.0.8] (fwa5da9-171.bb.online.no. [88.93.169.171])
        by smtp.gmail.com with ESMTPSA id k13-20020ac257cd000000b00489db767c89sm1552945lfo.271.2022.07.12.09.19.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Jul 2022 09:19:08 -0700 (PDT)
Message-ID: <257c64a7-db27-301c-f724-f8c771092466@linaro.org>
Date:   Tue, 12 Jul 2022 18:19:05 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v2 1/7] iommu/exynos: Reuse SysMMU constants for page size
 and order
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
 <20220710230603.13526-2-semen.protsenko@linaro.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220710230603.13526-2-semen.protsenko@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/07/2022 01:05, Sam Protsenko wrote:
> Using SZ_4K in context of SysMMU driver is better than using PAGE_SIZE,
> as PAGE_SIZE might have different value on different platforms. Though
> it would be even better to use more specific constants, already existing
> in SysMMU driver. Make the code more strict by using SPAGE_ORDER and
> SPAGE_SIZE constants.
> 
> It also makes sense, as __sysmmu_tlb_invalidate_entry() also uses
> SPAGE_* constants for further calculations with num_inv param, so it's
> logical that num_inv should be previously calculated using also SPAGE_*
> values.
> 
> Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


Best regards,
Krzysztof
