Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B036A5429DF
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jun 2022 10:53:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232389AbiFHIwd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jun 2022 04:52:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232505AbiFHIv5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jun 2022 04:51:57 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99C8A26A926;
        Wed,  8 Jun 2022 01:09:21 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id h1so16965661plf.11;
        Wed, 08 Jun 2022 01:09:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wzCO2PHgpPzaCVBVfWdrrgnry8jUU6uemsouKbLB4Pc=;
        b=kPTykBE3ERcs7XgModDK/vMFZHXgn8br/ljamm2UtAtie5/HYQ5y7diDf8ds42B06m
         xMN7sBQ5vJhuyosrGLubGqgaFtggMbK1UtZAoJPbvOkn9tNFr+jAwJmLaFVfnZ9Iehwh
         yCd5jHtWUjMTC//CoNqgNMsOpYu47NRQOOoODVgqHQhwZPabgstDwKW7MCVw/UMSllwQ
         T0e56yNmXH3ns+T9gZUiPge5WDMr6CfTmbF182AbnbyoXSgc9lerKFCkD5AvA05BmPmQ
         kkFu/VewHjANXX4XgZSnvO+OAGpuU7Hm6gl1YS3YVmj5o46YvCUNeR3dIQ4QNOs/68Dz
         Aqrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wzCO2PHgpPzaCVBVfWdrrgnry8jUU6uemsouKbLB4Pc=;
        b=zDsRGiv0lXAwv8dbvVxodiVKxaFc97LKBsUczOjZVtSLFA3FrF52e4KETf/bWNfJUL
         kUvXpCJWpHuKn+EPM+TjolRGSfUtV3UNXALTL6zsauLu4hK1vjERSb8WjHMoVa9nE9Xy
         uU0VIN9sUq/o4EhLLq0gb0VGZ6AqZwXQ+rplnuvdVREoZDkcuAiGT5AsNvVE4PEHWOiJ
         giKnWQ3jvzYKO6oWXSN0e6eU0z1DP01Jkb8gjNKHUwdy0ZakTbbSHuI3vJoVhPuRF1pD
         EJ7M5gh59fmq7Fk5GkFdBKlajlEhMOlBCxPwvxQ08Q5nSXY0guLav8UvgM+G7z2H/A0C
         UT2w==
X-Gm-Message-State: AOAM533bWsggDvPrek4f9Tgy7irsTpoc/yQ7VMX8wjgiJPV6hEXGYvLE
        VHrQ7M7XqAhDbYjzcSuHFwE=
X-Google-Smtp-Source: ABdhPJwy7w1/KLYXns+KpuB2zm2khovi9eQl2y3X3BbPGCbRCANZ/itnaL9+SU6NpnPv35n7LVPfvQ==
X-Received: by 2002:a17:90b:1101:b0:1e8:5df5:b2ac with SMTP id gi1-20020a17090b110100b001e85df5b2acmr22164892pjb.239.1654675760849;
        Wed, 08 Jun 2022 01:09:20 -0700 (PDT)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id t18-20020a170902e85200b0015e8d4eb1c8sm14008098plg.18.2022.06.08.01.09.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jun 2022 01:09:20 -0700 (PDT)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     bcm-kernel-feedback-list@broadcom.com,
        William Zhang <william.zhang@broadcom.com>,
        Linux ARM List <linux-arm-kernel@lists.infradead.org>
Cc:     joel.peshkin@broadcom.com, tomer.yacoby@broadcom.com,
        kursad.oney@broadcom.com, philippe.reynes@softathome.com,
        dan.beygelman@broadcom.com, samyon.furman@broadcom.com,
        anand.gore@broadcom.com, florian.fainelli@broadcom.com,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Nicolas Saenz Julienne <nsaenz@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Stefan Wahren <stefan.wahren@i2se.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/5] arm64: dts: add dts files for bcmbca soc 63158
Date:   Wed,  8 Jun 2022 01:09:18 -0700
Message-Id: <20220608080918.1448974-1-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220601225654.18519-4-william.zhang@broadcom.com>
References: <20220601225654.18519-1-william.zhang@broadcom.com> <20220601225654.18519-4-william.zhang@broadcom.com>
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

On Wed,  1 Jun 2022 15:56:51 -0700, William Zhang <william.zhang@broadcom.com> wrote:
> Add dts for ARMv8 based broadband SoC BCM63158. bcm63158.dtsi is the
> SoC description dts header and bcm963158.dts is a simple dts file for
> Broadcom BCM963158 Reference board that only enable the UART port.
> 
> Signed-off-by: William Zhang <william.zhang@broadcom.com>
> 
> ---

Applied to https://github.com/Broadcom/stblinux/commits/devicetree-arm64/next, thanks!
--
Florian
