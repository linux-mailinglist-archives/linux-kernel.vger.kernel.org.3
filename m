Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 228B152C3FB
	for <lists+linux-kernel@lfdr.de>; Wed, 18 May 2022 22:07:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242321AbiERUF4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 May 2022 16:05:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242255AbiERUFi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 May 2022 16:05:38 -0400
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D4782375D6;
        Wed, 18 May 2022 13:05:37 -0700 (PDT)
Received: by mail-pg1-x529.google.com with SMTP id c22so3119996pgu.2;
        Wed, 18 May 2022 13:05:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Ie6//PKI4vEbifJSMkR9IdP5mmsD732TRL7ezM/MMjo=;
        b=QTRTeZ269gswQzb/sXYF8SAOH0Km2b5a9kLicyCiKQZMaadytImpeFRFInsFWjPrGp
         DQp1hxjyhXx8zf0f7CtwbbzQsUhFAuRN83dVDR19b9yDFpJ5eCg0SP7K02jt5XtnlppP
         RRu0QqT9zf9rSNmaRP/rmICdiXgzd0aXc31ipWhfybNMumV+JUbKOR1qkJ/9HwR8xmSh
         8g8iaJ2jCpVe9OcGigXWhazzvQb/L6boXwr5HDxuUOE0+M5+mBMX/Y8P9k1+EZFTyMg4
         aJngDksKa5+DUHxBnXN5Td1I3bR8nIUW4ZWVew881Gdz1C8uI6W93JOQDSS6+R+eYcuR
         dgmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Ie6//PKI4vEbifJSMkR9IdP5mmsD732TRL7ezM/MMjo=;
        b=luJnNJXRG/MgWgyYMyDFyCLIvGUWvHY4kRNfW24foNl0jzsv0xA5t6EgUZE9MsjqJ5
         tBrMC4eOWsoDNbOYNlbFPwhK3eunHKskIBMLXfCtA0pjZZY/FgXM8Bq3i9fohkxg6QDH
         Z5DaQkgNBRDwRPAbVNzGVlR7twQgziiGGhSeMiZdGi0eyxFYuzdxuFIx2ifY+IH3XKSY
         GmO1d4duI/EPyIFXt1FriJExdpdZ8BouZ0My5aTJgBtdHITNBFpSsz7Kbdldzm7K/DPT
         6wsiHNLJjlQgeg397ZkftIvOzNP0v0CqxJHxIV+KG+jNFj2Ozb1V9HKno1oKN6yFVzze
         Przw==
X-Gm-Message-State: AOAM530T+sIKSw++49O8HmyQvljkgapHpfY+x+aSxS50vPZMyKZeuRQO
        iM655V+MLkOmc+GU+ILu4DU=
X-Google-Smtp-Source: ABdhPJz7qCw0u15FlIJilkaFKOgw15TwJz3N3UvNNbHRcuvUakyBQO7cv0/FKWsaP+rJB1J2KXQeTA==
X-Received: by 2002:a05:6a00:198b:b0:518:375b:531d with SMTP id d11-20020a056a00198b00b00518375b531dmr1190495pfl.82.1652904336920;
        Wed, 18 May 2022 13:05:36 -0700 (PDT)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id gt13-20020a17090af2cd00b001df4b919937sm4026000pjb.16.2022.05.18.13.05.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 May 2022 13:05:36 -0700 (PDT)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     bcm-kernel-feedback-list@broadcom.com,
        William Zhang <william.zhang@broadcom.com>,
        Linux ARM List <linux-arm-kernel@lists.infradead.org>
Cc:     kursad.oney@broadcom.com, florian.fainelli@broadcom.com,
        joel.peshkin@broadcom.com, tomer.yacoby@broadcom.com,
        samyon.furman@broadcom.com, philippe.reynes@softathome.com,
        anand.gore@broadcom.com, dan.beygelman@broadcom.com,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Nicolas Saenz Julienne <nsaenz@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Stefan Wahren <stefan.wahren@i2se.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/5] arm64: dts: add dts files for bcmbca soc 63158
Date:   Wed, 18 May 2022 13:05:34 -0700
Message-Id: <20220518200534.324242-1-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220514232800.24653-4-william.zhang@broadcom.com>
References: <20220514232800.24653-1-william.zhang@broadcom.com> <20220514232800.24653-4-william.zhang@broadcom.com>
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

On Sat, 14 May 2022 16:27:58 -0700, William Zhang <william.zhang@broadcom.com> wrote:
> Add dts for ARMv8 based broadband SoC BCM63158. bcm63158.dtsi is the
> SoC description dts header and bcm963158.dts is a simple dts file for
> Broadcom BCM963158 Reference board that only enable the UART port.
> 
> Signed-off-by: William Zhang <william.zhang@broadcom.com>
> ---

Applied to https://github.com/Broadcom/stblinux/commits/devicetree-arm64/next, thanks!
--
Florian
