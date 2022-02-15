Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D482A4B79F0
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 22:50:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241898AbiBOVuG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 16:50:06 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:47184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235764AbiBOVuD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 16:50:03 -0500
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 122ECD5DEE;
        Tue, 15 Feb 2022 13:49:53 -0800 (PST)
Received: by mail-lf1-x12b.google.com with SMTP id p22so178498lfu.5;
        Tue, 15 Feb 2022 13:49:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=nVOc+WtGt9M92xR6YqeYiWL9ZGefjURnpi4PPff1eNE=;
        b=nIVz5kH3Ir2dOdYoW1eJf+OcDxjmaZlWEwoFVBedQngH9lCh96VtuYWLw9x0Vkjlwn
         m/ZtTS6eNS+F/1LUHpvR+r5T/FvtKaifaFq2v+d1xXP16+KwfroIvfSDeBKA6FaAVxA+
         johnyiXHxbbgIphI+QAHesBLja3CdtWHI7YIRwvQnhLvgJgskQtN9nFjlObZb2uAVg+Z
         AT5HrSPYiJ8oJgxs01e2CBCtEeBLyVsl+QlEmaGT0YHa8SIQtYKI0OnCx8V4jfyYqCnr
         r9bKXZG7m66iqpdGAVIUOsnKXPT+ycD/EkW/EsCv7cJ2mk2CHKHGA0Df7QQVk2kn5xps
         UtPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=nVOc+WtGt9M92xR6YqeYiWL9ZGefjURnpi4PPff1eNE=;
        b=OnJVaKG3fdF4/Wz0AYtVUwyZzxjL3C8qj52v5JdTyuYVqgOLWwMmV5PUV8sHwZ3BF7
         quBp5Gly4x7SkCF+kY5RQ34AyF8rz8gfocn2cAo0JERvxtnGC4/BZzDZdasM4rwhNBVs
         5UNJkZ8FeavsQUBIFY+Xu5miASlvEXi1aLM2hVuwuclr+Nu9aPPlzKbqEtyvi0yI0MmS
         qUhEdpAJhzn3f+E6/uOVXl5NNQT81tOnmstXjl8rVp/Qp2T2/cCFBPCNhUYwAGj7xl+T
         pSzBjKPWEdQFOvsUMoVqQJZPSQ9lZvEbbp+IBDufC8aj4qHKJyTwpUjq6LZWgiNkysNN
         tHDw==
X-Gm-Message-State: AOAM530TUzgdxhUG5x34bedQUNYZ4z/G62OqZigDxTmpHUcB85Iau7w6
        pYPjKVaP7FKcMb05wOxlZ4Y=
X-Google-Smtp-Source: ABdhPJxAVLf4fs8AL+OfizHakAeVAC1vYUuYg498WhaVN9bvHWSKOyDreVBXJhKizCLoIctLHX4JEw==
X-Received: by 2002:a05:6512:4d1:: with SMTP id w17mr796008lfq.391.1644961791454;
        Tue, 15 Feb 2022 13:49:51 -0800 (PST)
Received: from [192.168.2.145] (109-252-138-165.dynamic.spd-mgts.ru. [109.252.138.165])
        by smtp.googlemail.com with ESMTPSA id t12sm4574312ljj.118.2022.02.15.13.49.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Feb 2022 13:49:51 -0800 (PST)
Message-ID: <dd7d0ebd-7bd8-9f2e-e212-5b597ec729d5@gmail.com>
Date:   Wed, 16 Feb 2022 00:49:50 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v2] PM: domains: Prevent power off for parent unless child
 is in deepest state
Content-Language: en-US
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>, linux-pm@vger.kernel.org
Cc:     Kevin Hilman <khilman@kernel.org>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Dong Aisheng <aisheng.dong@nxp.com>,
        linux-kernel@vger.kernel.org
References: <20220204101657.233723-1-ulf.hansson@linaro.org>
From:   Dmitry Osipenko <digetx@gmail.com>
In-Reply-To: <20220204101657.233723-1-ulf.hansson@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

04.02.2022 13:16, Ulf Hansson пишет:
> A PM domain managed by genpd may support multiple idlestates. During
> genpd_power_off() a genpd governor may be asked to select one of the
> idlestates based upon the dev PM QoS constraints, for example.
> 
> However, there is a problem with the behaviour around this in genpd. More
> precisely, a parent-domain is allowed to be powered off, no matter of what
> idlestate that has been selected for the child-domain.
> 
> So far, we have not received any reports about errors from the current
> behaviour. However, there is an STMicro platform that is being worked on,
> which can't cope with this.

Could you please provide some technical info about why STMicro platform
can't cope with that?
