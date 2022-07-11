Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56DFC56D2DF
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jul 2022 04:11:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229621AbiGKCLK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Jul 2022 22:11:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229547AbiGKCLI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Jul 2022 22:11:08 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B2F415A17;
        Sun, 10 Jul 2022 19:11:08 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id a15so3604076pfv.13;
        Sun, 10 Jul 2022 19:11:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=IOB7LUfK2ArEnxzZc6VQCujpQO6wQ7pgwukyaC7VM8w=;
        b=DbDwSUC5nuYZDLaxAL0ua5al1x5Z9rDVbpWPLunNQX5odLuZKF4myq09fxv+Ky7INh
         +kSxDt47/xbjweYgIhMtg+FUkxGBzYGCdDpx8R/Hk1cO1lXxRGWj7tPDmh2x3esbsPB0
         ohYceH8yzUpb7KJ7BszGZJSBe8Trms82912WspPaTmeVTJ9KTckI+Xzq7+AQks2Iz9J9
         K7Q7Gkaylcr3kvvCRQVws1tUzvnCUuPXhx8VPobGFrGDIERL/8+t+omYKfUVY9LyvtMa
         sMMfhpYP5Oaq+tW7YbKczoUyWH+CXJjGCsmum8p1x5DHE2J/41H7c59uKUra+CMYs9Cm
         Af/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=IOB7LUfK2ArEnxzZc6VQCujpQO6wQ7pgwukyaC7VM8w=;
        b=jP7+CAuIMxnuIZ6wX/GeZCUcJFlE6qrQCGiy70rDw3rJgRhQY8RNXdL/4G8Cn55IL6
         nigxMlIyU3Q4tsBzbIRlUM0jvNznYWDsVL6mcBTVkrRpPqp7KV5f0yeCZop3sBXL3pSe
         2feGJA/r8RG37JX85aK5vz79EtkcS5oQgCSecuU9oqj5qDOWebottehnyX85sN59MjLz
         OhNhlSAzjFNmYXSeercKXsnGGh4dAH0KL8taLOroR93lEIaUJuVWzld53dwOI6YDYQxZ
         zBA4B8woI4aAoEB5mB8oE+g43XOgkNC9cwRiepRJpJDCDkwt5dSHabF2se3saAS885p+
         UjMw==
X-Gm-Message-State: AJIora+AbB4blJh5NGgS0VTYFfAiAv6+LuprkIf3sQQ7sb15r+sih9cc
        M5XAqmbJZ1T62xQH05Pz6SU=
X-Google-Smtp-Source: AGRyM1vaIJeKmR+fOpZNH6MhQPYhGsU1BIndikZtkti+QZaJIU9uT2at5X35Q9fDHz0lFluwb3QHpA==
X-Received: by 2002:a63:5421:0:b0:412:7fb5:d69b with SMTP id i33-20020a635421000000b004127fb5d69bmr14266257pgb.454.1657505467473;
        Sun, 10 Jul 2022 19:11:07 -0700 (PDT)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id d8-20020a17090a7bc800b001efa332d365sm3431922pjl.33.2022.07.10.19.11.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Jul 2022 19:11:06 -0700 (PDT)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     bcm-kernel-feedback-list@broadcom.com,
        William Zhang <william.zhang@broadcom.com>,
        Linux ARM List <linux-arm-kernel@lists.infradead.org>
Cc:     anand.gore@broadcom.com, dan.beygelman@broadcom.com,
        kursad.oney@broadcom.com, joel.peshkin@broadcom.com,
        Andre Przywara <andre.przywara@arm.com>,
        Cai Huoqing <cai.huoqing@linux.dev>,
        Conor Dooley <conor.dooley@microchip.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Matt Mackall <mpm@selenic.com>,
        Sunil Goutham <sgoutham@marvell.com>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RESEND PATCH 3/8] hwrng: bcm2835: bcmbca: Replace ARCH_BCM_63XX with ARCH_BCMBCA
Date:   Sun, 10 Jul 2022 19:11:04 -0700
Message-Id: <20220711021104.3289657-1-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220707065800.261269-3-william.zhang@broadcom.com>
References: <20220707065800.261269-1-william.zhang@broadcom.com> <20220707065800.261269-3-william.zhang@broadcom.com>
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

On Wed,  6 Jul 2022 23:57:54 -0700, William Zhang <william.zhang@broadcom.com> wrote:
> Prepare for the BCM63138 ARCH_BCM_63XX migration to ARCH_BCMBCA. Make
> HW_RANDOM_BCM2835 depending on ARCH_BCMBCA.
> 
> Signed-off-by: William Zhang <william.zhang@broadcom.com>
> ---

Applied to https://github.com/Broadcom/stblinux/commits/drivers/next, thanks!
--
Florian
