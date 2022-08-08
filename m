Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0E7A58C611
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Aug 2022 12:06:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241995AbiHHKGs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Aug 2022 06:06:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242343AbiHHKGl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Aug 2022 06:06:41 -0400
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A234F1181F
        for <linux-kernel@vger.kernel.org>; Mon,  8 Aug 2022 03:06:39 -0700 (PDT)
Received: by mail-lj1-x235.google.com with SMTP id u6so3915647ljk.8
        for <linux-kernel@vger.kernel.org>; Mon, 08 Aug 2022 03:06:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=xExDiNzjvGBll5feAm0Ok3SGRkY16fJNcNgVa/ZsGBE=;
        b=ZxzB+3TWHIpp03eJsvBmQF0soM6WE6/h9mOuVY5YwaywLSb++ifpadlqFMqHLoQaWx
         sd4ONtxOcsopifncmI2Ob5Ii7MaB0UzQ2nvrBnM5fL8oprx9Zvd5AQfCNCZthMvWYW0d
         IgEJWdSolyp6SzIF+nkf2EIKNczi0NXQvvVdoDIy0Z4wD/R/bZSlGYm69PA2A4x2Kj/E
         OeKgayfIH1adOpZX6HJzhxqMh18jzlthAFJri6eqc2LPh60JjwVW8n2KRn/ghZwADE+r
         +0DXNiMlhgdkRL9uslU9r2Hwu0bLWbSLNQVoFtdS7AjwuXqhOOxU8eAocBdsm9otb9/v
         o3QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=xExDiNzjvGBll5feAm0Ok3SGRkY16fJNcNgVa/ZsGBE=;
        b=g5a9BysyCaGVBL8gwPYwYA8vAoJSDftWS4cCGFk3kYHbPIxdkt8QATDJekMumg2Z0H
         lQTYVLk2F99OQ4tEQj8WNbot8znKAHSNwTy07njCvfKk/y+mZNB7C1P4bWKrnS/mCzr8
         cl3F+gidWqo31QUqGsiOFD4ouynk4oGCH508i/uJc7b83wl3966Qf/bx2A+Yni4gdGK7
         5Pya4FPNjiQB5bLXPD2vX3DuS1cZLbtDCy6fYttT7eTPyRK43JwKMKW2mshhVRS2IJge
         rWxesM3W4YprwxXXbxDSRpwymXfr563BClZzLtE2T9LYtYiGBkF3ajk4iKYuasDznOlT
         8pIA==
X-Gm-Message-State: ACgBeo2zoTur4Cwy0+QCcA7pnl1zATrWq2tqp2HS1ojUrZf01KrwjYe9
        S8n4FQ5AXIhN5awgi0x/Nqqabw==
X-Google-Smtp-Source: AA6agR5BilwKjCFIxYE12w0n9Stop3c/u3GrsZnVpvJ4nwU3UWR/eGrc0BlOKb0oG0HRjnEIaetx0g==
X-Received: by 2002:a2e:b949:0:b0:25e:795e:fb11 with SMTP id 9-20020a2eb949000000b0025e795efb11mr4806867ljs.163.1659953198069;
        Mon, 08 Aug 2022 03:06:38 -0700 (PDT)
Received: from [192.168.1.39] ([83.146.140.105])
        by smtp.gmail.com with ESMTPSA id u11-20020a2eb80b000000b0025e434e1e6bsm1325095ljo.31.2022.08.08.03.06.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Aug 2022 03:06:37 -0700 (PDT)
Message-ID: <b0cb8e8b-8793-a781-77d8-a56cadbb7696@linaro.org>
Date:   Mon, 8 Aug 2022 13:06:35 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH 21/28] mfd: max14577: Remove #ifdef guards for PM related
 functions
Content-Language: en-US
To:     Paul Cercueil <paul@crapouillou.net>,
        Lee Jones <lee.jones@linaro.org>
Cc:     linux-kernel@vger.kernel.org, Chanwoo Choi <cw00.choi@samsung.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
References: <20220807145247.46107-1-paul@crapouillou.net>
 <20220807145247.46107-22-paul@crapouillou.net>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220807145247.46107-22-paul@crapouillou.net>
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

On 07/08/2022 17:52, Paul Cercueil wrote:
> Use the new DEFINE_SIMPLE_DEV_PM_OPS() and pm_sleep_ptr() macros
> to handle the .suspend/.resume callbacks.
> 
> These macros allow the suspend and resume functions to be automatically
> dropped by the compiler when CONFIG_SUSPEND is disabled, without having
> to use #ifdef guards.
> 
> The advantage is then that these functions are now always compiled
> independently of any Kconfig option, and thanks to that bugs and
> regressions are easier to catch.
> 
> Signed-off-by: Paul Cercueil <paul@crapouillou.net>
> Cc: Chanwoo Choi <cw00.choi@samsung.com>
> Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>

With dropped Bartlomiej:

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


Best regards,
Krzysztof
