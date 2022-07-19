Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA60A5795E9
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 11:16:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236731AbiGSJQS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jul 2022 05:16:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234384AbiGSJQQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 05:16:16 -0400
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8744E192A9
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jul 2022 02:16:15 -0700 (PDT)
Received: by mail-lj1-x229.google.com with SMTP id u15so16612936lji.10
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jul 2022 02:16:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=EiPIlo7Vs9DiAdVRyUDYHpIazmfJsBIl7QHLBcvn4ws=;
        b=hM+2WuSbikErcQCOyaqBuoFCnyPuxWNYo2/OMPttH7Y+o88vMjcPOOVYbMmyYshBoC
         0Zd0smGcJAQi+FWY5zER6o4dtm2BcBXLViOZAsX8cMDsfyFjLCun/gcf2YfnvaWOu8+4
         gAaOfvj+DZKGqN0AU3gu/5I6Sh4TCcmM4l3I/98FBFhBYRq9fwjh+ayXkfuH1btdPbFh
         hzdb8EH68P8mQkg15y2/ULYK1FffxEWB5nzdqnnNb/6oU8me87tFyH4/iTHA16nvIzSH
         7sKeLscjXs42YoBmS/DBQHkZ1z9CS9qRJ7DVHA/yMS0Kg3LQ5eGKzAdUy7b9Y3UBd6Cf
         g5eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=EiPIlo7Vs9DiAdVRyUDYHpIazmfJsBIl7QHLBcvn4ws=;
        b=s8pxMpzgO2SDOVTrl7JCMvYQkUqiC+wAjStN5K6JFQepsutcBC0gp9xV4N6FNM/N05
         zmkkjn1QiO37vVicc64J6RZlW/dLf6as2k0R/xhLwl8LtIw4Fx5Rul+Qwxvourbt9X7G
         ND6QQPwW0mymTTFEQyMcT4jSwiD8/Kf53Gyqf93wmBFWfIWNHeP+RmkaWQ6KoFNYThug
         ehAh/SNYObjKLq2EjBoJyPERyM+Kap0omAT+jkGLNQCag7t8qj18fMoR6DvbaSDFPCiN
         9Z3ThIwkcs6iKFH4wAZ/UzVWbFgnthsAIf3xhCyftvbli+h/I5EQMiPE44IDP1QylS+E
         B0SQ==
X-Gm-Message-State: AJIora8OorWmRfENoRQNJ3hE5Hkp6Ln6WagbAj4sHe8OmbSh20t5xlG6
        QGNR3Omr3j4O36ZaCN57sjwQhGoByaPtybf0
X-Google-Smtp-Source: AGRyM1txHvTPBz/ixiFNirvCteHCwgqLtyp+MG5YZV/K19suXdDeTkonWbQZ05h4gzqVViTBzrj3JA==
X-Received: by 2002:a2e:87d9:0:b0:25d:88e1:d710 with SMTP id v25-20020a2e87d9000000b0025d88e1d710mr14162688ljj.361.1658222173596;
        Tue, 19 Jul 2022 02:16:13 -0700 (PDT)
Received: from krzk-bin.. (89-162-31-138.fiber.signal.no. [89.162.31.138])
        by smtp.gmail.com with ESMTPSA id c23-20020a2e9497000000b0025d520648d1sm2549062ljh.43.2022.07.19.02.16.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Jul 2022 02:16:13 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     linux-kernel@vger.kernel.org, windhl@126.com
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH v2 1/2] memory: of: Fix refcount leak bug in of_get_ddr_timings()
Date:   Tue, 19 Jul 2022 11:16:11 +0200
Message-Id: <165822216749.37301.12699502568759184723.b4-ty@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220719085640.1210583-1-windhl@126.com>
References: <20220719085640.1210583-1-windhl@126.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 19 Jul 2022 16:56:39 +0800, Liang He wrote:
> We should add the of_node_put() when breaking out of
> for_each_child_of_node() as it will automatically increase
> and decrease the refcount.
> 
> 

Applied, thanks!

[1/2] memory: of: Fix refcount leak bug in of_get_ddr_timings()
      https://git.kernel.org/krzk/linux-mem-ctrl/c/b54af20531018c2bb7181ba2f511327b3c9f1cef
[2/2] memory: of: Fix refcount leak bug in of_lpddr3_get_ddr_timings()
      https://git.kernel.org/krzk/linux-mem-ctrl/c/2f1b3550a152baa8287ee95586f0385410a5296b

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
