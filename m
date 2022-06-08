Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B685542A15
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jun 2022 10:57:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233235AbiFHI4w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jun 2022 04:56:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232844AbiFHI4K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jun 2022 04:56:10 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 261E43CE26A;
        Wed,  8 Jun 2022 01:17:01 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id gc3-20020a17090b310300b001e33092c737so17663214pjb.3;
        Wed, 08 Jun 2022 01:17:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=uXWd6WbC1oEIWUajb+rsLU01lmMR9fnUGGnxnBKpIQQ=;
        b=CrD/NH4RFJBD+dFkyRvfIoI2Ja9h/UOBGE/OBRHYSbXf14a2qYBv3ZeRQFR1BSJXxD
         zVJC9dnM1wIKokvTQLIlCtkqg/nG2X1fagE9I7Y0zdHJ+LVFrKqFyBoPAsnYjSek0PS+
         V7bV/OtulILSoS4T3BBrHMnJbzuyZdwLWrN5+abiWsi95evQsYPchdas5n4ONtHh+tPl
         GAQkpB91JT1ew/+sjDEoXvEWI/YtNXk4NZKRUMzOovEpDgGINnS4t/Lute56NrhCdKrL
         JoYHkR/ai8058vv4W6rvN8qtft0c7YCtgQpQg6vm4nBU42rNBrBlXcl6ad2mJXaK4XVl
         VWqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=uXWd6WbC1oEIWUajb+rsLU01lmMR9fnUGGnxnBKpIQQ=;
        b=4TS8Y1aHEls/j5WXPZke+7pa8cJbRuWTCWt0MT3XlpmHInsFkxvXusqg9ahepgxiNf
         COfhTjTZt1KhIyVGEYceTXRQNaFt1wdaoE6QXEcvSxBNVJq4eYSf2NbK+nv8aqSzG+Od
         LdvEfUQN6s+WH5SvJ4WaiSlSOReNb4Dt9CcbwjbjHKA0PzGSJAQYk0tmZJogyVy1Pt+w
         EI8Pv+m/xCr8UnJ9bWkv11XsqsPRuakWgctgLeCfAw3hR1RLceWDNhvMcnpLRWhqztU5
         eqUcdJD8gjVX7Ea3KrDtp1hylJvISPUFR7yODydFXvc0i7lMa9pPcfnJuDCD9y2usdso
         rzAQ==
X-Gm-Message-State: AOAM530hSJlNetaPkiYZbUw/xPyt3nX0wv/ZWFR3ZIOjuFijsOcCAvsK
        ww7WYe6R9hTflsFVLIihiOw=
X-Google-Smtp-Source: ABdhPJzCy4C7RNLq89pgAEoLgAgwWAPUJQYu2aDD1XEwAXjvT6qdvzjsF+lWhAs7QQ8H0X68EbTUdw==
X-Received: by 2002:a17:902:c651:b0:164:127:cdfd with SMTP id s17-20020a170902c65100b001640127cdfdmr33739845pls.154.1654676220368;
        Wed, 08 Jun 2022 01:17:00 -0700 (PDT)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id q12-20020a056a00150c00b0050dc762818dsm4514177pfu.103.2022.06.08.01.16.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jun 2022 01:16:59 -0700 (PDT)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     bcm-kernel-feedback-list@broadcom.com,
        William Zhang <william.zhang@broadcom.com>,
        Linux ARM List <linux-arm-kernel@lists.infradead.org>
Cc:     florian.fainelli@broadcom.com, dan.beygelman@broadcom.com,
        joel.peshkin@broadcom.com, philippe.reynes@softathome.com,
        kursad.oney@broadcom.com, tomer.yacoby@broadcom.com,
        samyon.furman@broadcom.com, anand.gore@broadcom.com,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] arm64: dts: add dts files for bcmbca SoC bcm4912
Date:   Wed,  8 Jun 2022 01:16:58 -0700
Message-Id: <20220608081658.1450367-1-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220528005654.13809-3-william.zhang@broadcom.com>
References: <20220528005654.13809-1-william.zhang@broadcom.com> <20220528005654.13809-3-william.zhang@broadcom.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 27 May 2022 17:56:52 -0700, William Zhang <william.zhang@broadcom.com> wrote:
> Add dts for ARMv8 based broadband SoC BCM4912. bcm4912.dtsi is the
> SoC description dts header and bcm94912.dts is a simple dts file for
> Broadcom BCM94912 Reference board that only enable the UART port.
> 
> Signed-off-by: William Zhang <william.zhang@broadcom.com>
> ---

Applied to https://github.com/Broadcom/stblinux/commits/devicetree-arm64/next, thanks!
--
Florian
