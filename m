Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B3C352C3F9
	for <lists+linux-kernel@lfdr.de>; Wed, 18 May 2022 22:07:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242304AbiERUCG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 May 2022 16:02:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242284AbiERUCF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 May 2022 16:02:05 -0400
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A1F814CDF4;
        Wed, 18 May 2022 13:02:04 -0700 (PDT)
Received: by mail-pg1-x532.google.com with SMTP id z3so1603536pgn.4;
        Wed, 18 May 2022 13:02:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=uqfL2s98jH1KESGEpAYrkz2to9znSXHw/vJwfe+b5DQ=;
        b=YPVYxFEAxbX9obB0FWsDGjJXZ/xxu0R1tZCQ++6jkOoiO9v559/ECYd0+e/O2SnKIk
         DbDtz5cgKxPzpnH+uyTvilV8s6IbwTs4inX3uNdgLPM27TDRwtSHqzOkWpM4ch8gryT6
         AndZRKGF8eXDvaO0E1zoLXJPNO6Ebt5P/rxP9ZuAXcMrgVMTjvDJF86e5CEcHX8KrPw/
         zt7qqK+70VExBruwYUmRAm7vJNPaBCZEsnDJLYVUSF6gdpChcgPc4WS0zJ2AW2KogD1E
         d1OEEibKD/Kdsl7l97xR9MOMSbaCdf0VI39+UCXcEtWW6z7FeXiHJvzIqe/8nYP79cFt
         BP4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=uqfL2s98jH1KESGEpAYrkz2to9znSXHw/vJwfe+b5DQ=;
        b=2En9iPS6t7TBhlgS9QdWKz15xTbMhNLwmlgY0Ted32tLEvC26Z6CToQIHWTP3njExN
         6hg5JD3JYAoHQtA4qvWIiRyyr+uoTNgaHHGygfdBlolygesCK8NKLuf2iqaDr/tWQMzI
         YP+uem6eR7xcEjRx1mkLsC9oOV9IZsnYCtmLtYrO4YgPKNRz1+I0WJEjY6aeSgZbKbh8
         DchQnSUf1+ZOHWbpqzshYsffUYEzNdDqMjngiHsl0/8momU717xw/Ctx6lOiArvy1L1X
         NKtI8rLR/Tn8wiEylyufH9UcNeZYmJgRTNuDrMouwTFrPaYgWBB10yztzMyXuS+/mcpv
         TYyg==
X-Gm-Message-State: AOAM5337I5O/aV2yXATZHhUIuyX5fi3VtDlYBgcp2AJTXhuWojSJknCJ
        LuDOp2TKzu3qhagOHVEevL0=
X-Google-Smtp-Source: ABdhPJyr9iaeXPnDbGCFTOGnkaD+p+nR2I1pLBS5V7XERkYPJllYvgGbkhSs6RXFm2TYStgbhdRVbQ==
X-Received: by 2002:a65:6919:0:b0:3f6:111c:42d0 with SMTP id s25-20020a656919000000b003f6111c42d0mr881634pgq.449.1652904123979;
        Wed, 18 May 2022 13:02:03 -0700 (PDT)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id e11-20020a17090a9a8b00b001df4c27e5a5sm3961678pjp.35.2022.05.18.13.02.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 May 2022 13:02:03 -0700 (PDT)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     bcm-kernel-feedback-list@broadcom.com,
        Anand Gore <anand.gore@broadcom.com>,
        linux-arm-kernel@lists.infradead.org
Cc:     dan.beygelman@broadcom.com, joel.peshkin@broadcom.com,
        florian.fainelli@broadcom.com, kursad.oney@broadcom.com,
        William Zhang <william.zhang@broadcom.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Olof Johansson <olof@lixom.net>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, soc@kernel.org
Subject: Re: [PATCH 1/3] ARM: dts: add dts files for bcmbca soc 63178
Date:   Wed, 18 May 2022 13:02:01 -0700
Message-Id: <20220518200201.323063-1-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220516103801.1.If6875f219ec3c728983c6aec498ef67b43cef8b7@changeid>
References: <20220516173808.1391482-1-anand.gore@broadcom.com> <20220516103801.1.If6875f219ec3c728983c6aec498ef67b43cef8b7@changeid>
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

On Mon, 16 May 2022 10:38:06 -0700, Anand Gore <anand.gore@broadcom.com> wrote:
> Add dts for ARMv7 based broadband SoC BCM63178. bcm63178.dtsi is the
> SoC description dts header and bcm963178.dts is a simple dts file for
> Broadcom BCM963178 Reference board that only enable the UART port.
> 
> Signed-off-by: Anand Gore <anand.gore@broadcom.com>
> ---

Applied to https://github.com/Broadcom/stblinux/commits/devicetree/next, thanks!
--
Florian
