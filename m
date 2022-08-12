Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13F23590E61
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Aug 2022 11:47:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238082AbiHLJrz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Aug 2022 05:47:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236803AbiHLJrx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Aug 2022 05:47:53 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CF93A5C5D
        for <linux-kernel@vger.kernel.org>; Fri, 12 Aug 2022 02:47:52 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id c17so648583lfb.3
        for <linux-kernel@vger.kernel.org>; Fri, 12 Aug 2022 02:47:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=R575C1qhTHoSbi+3zD4RrbyhHb3virAcspXTDvQnKy4=;
        b=JSxzpeNWLiRQSjxYlGfMrQtjKLO8g8dzulwQExNLFeDwD4tVqoHkk8P5XG1Findb/G
         0AdZXA7FJ4cXF/xqOg/eNsJt5VyLRdYKYniCzXpYeknBCzZGu3xM+UtHeCJj9Y+z/Rr1
         ty0/9msxB8WzbQGrXdX1FtEom9AXtYzN48Udp9d3NXwJQiYPmUzQOOfO7Tuk3iaC0/BY
         Z6F+EURDhtSHHrX4dKWijogHbw7+LQI55Tp465P4AXe5bBKTvwOMY6sw3yA6xLMbuD4l
         SsCYyA7stKTmpe/b4tXi5uBiLCeGc3jLmOKNZxsocpQQzxnobb39ANKxmr6fXN6cJRCk
         GNXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=R575C1qhTHoSbi+3zD4RrbyhHb3virAcspXTDvQnKy4=;
        b=7Sy98+ekzNUsoYMe6Ea5Mdy/Mur02GqFt9k0IaSh+BqoGVJd8ZpureVqamuc6eSS7x
         sB8WxJ1VkOrxC3m1pxJ9RX38nNxTIrXTXttL+LvN/geHH/QUgnCb8v9VOz4fy8PYPHy6
         NTTCgHKKSxX/S80B02IJ3aSHvfXLa8+YMNJjHRQ/6mhEMPz3QiRu4SUfW53W4R2sGe5/
         EghhhWtLAuwSYyW/0T/FLNk2vJaP7B/TaruxlUthuINebjLzOF46Xhq/roVP0TQHRuxx
         RTqlJeHTThP0Xp3zCzZUP8SUfmW7ReOoYkgFSLO3T3hEUoV2PI34Vfpr+/STP7JjAZPf
         Kd/A==
X-Gm-Message-State: ACgBeo2+txaM+07BoPQUmelYvJ5PHfXfJ36CZ2u5Tdn5gMFALCttLrLS
        ff7CqwS0kJB6SrmqpR8NbiX3irw6NRtqmQje
X-Google-Smtp-Source: AA6agR5/2t+Z5sXLTq/FW0vwRSzdGa6Lmy3xVzBDbS50S1sEDvE57meU4TbXikGJPucThSN+EvX0ig==
X-Received: by 2002:ac2:47f1:0:b0:48a:ea6e:b8fd with SMTP id b17-20020ac247f1000000b0048aea6eb8fdmr968658lfp.26.1660297671829;
        Fri, 12 Aug 2022 02:47:51 -0700 (PDT)
Received: from [192.168.1.39] ([83.146.140.105])
        by smtp.gmail.com with ESMTPSA id u17-20020a056512041100b0047f7419de4asm153741lfk.180.2022.08.12.02.47.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Aug 2022 02:47:50 -0700 (PDT)
Message-ID: <bac57cb8-6d3f-63b0-f504-eb65956d6422@linaro.org>
Date:   Fri, 12 Aug 2022 12:47:46 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH v2 5/9] clk: samsung: exynos850: Implement CMU_AUD domain
Content-Language: en-US
To:     Sam Protsenko <semen.protsenko@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>
Cc:     Alim Akhtar <alim.akhtar@samsung.com>,
        Chanho Park <chanho61.park@samsung.com>,
        David Virag <virag.david003@gmail.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Tomasz Figa <tomasz.figa@gmail.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org
References: <20220809113323.29965-1-semen.protsenko@linaro.org>
 <20220809113323.29965-6-semen.protsenko@linaro.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220809113323.29965-6-semen.protsenko@linaro.org>
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

On 09/08/2022 14:33, Sam Protsenko wrote:
> CMU_AUD clock domain provides clocks for ABOX IP-core (audio subsystem).
> According to Exynos850 TRM, CMU_AUD generates Cortex-A32 clock, bus
> clock and audio clocks for BLK_AUD.
> 
> This patch adds next clocks:
>   - bus clocks in CMU_TOP needed for CMU_AUD
>   - all internal CMU_AUD clocks
>   - leaf clocks for Cortex-A32, Speedy FM, UAIF0..UAIF6 (Unified Audio
>     Interface), CNT (counter), ABOX IP-core, ASB (Asynchronous Bridge),
>     DAP (Debug Access Port), I2S Codec MCLK, D_TZPC (TrustZone
>     Protection Controller), GPIO, PPMU (Platform Performance Monitoring
>     Unit), SysMMU, SysReg and WDT
> 
> ABOX clock was marked as CLK_IGNORE_UNUSED, as system hangs on boot
> otherwise. Once ABOX driver is implemented, maybe it can be handled
> there instead.
> 
> Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>
> ---
> Changes in v2:
>   - (none)
> 
>  drivers/clk/samsung/clk-exynos850.c | 302 ++++++++++++++++++++++++++++
>  1 file changed, 302 insertions(+)


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


Best regards,
Krzysztof
