Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB76D50C46A
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Apr 2022 01:12:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232671AbiDVW27 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 18:28:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233036AbiDVW1b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 18:27:31 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54E391D4A7F
        for <linux-kernel@vger.kernel.org>; Fri, 22 Apr 2022 14:20:29 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id u15so10123975ple.4
        for <linux-kernel@vger.kernel.org>; Fri, 22 Apr 2022 14:20:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=YaHav3vVq09jDpMHq72VxhwIZFd3QWfZ+ZYCkVqa4z4=;
        b=PmHSzsUMtbcCNs9U6+ajBShbLsVM5Hxy4qnQTXDD9cNh74C667bVvuuDaOVLU9L50f
         wBeVS0uHkWX+diNJz6TUNQd50m+RXpyrxqkVFIy6ldbSqoEBTjGJyHgcqzParOpqHlNa
         GYxN2emNvQgFtjpncHHaC4RVEJYkr8VQqkqsigjxONyHnF/303qCZOXyDfnL7lD7SCzk
         cWL9Fkn4+5Y/VyXq1CS+bdpC+hlQbkbWVrAp8LJU1tHZ+nz1tTnW+szQGhhzgF0qk5Of
         RmAiNMf6sEkpHDW9GCZm2BAEKYEoiaa/uwp4s+K1C3L6tJVzjBafzJL/KPdNigJMsA1/
         4oxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YaHav3vVq09jDpMHq72VxhwIZFd3QWfZ+ZYCkVqa4z4=;
        b=qMME8yChLKp+4SRKy5PdDs8dTBgA/ToXc0T/8Gn6KNPOdN0wid2ja9pBOHSFzJ4TS+
         58XlT60P8Z9b6YbA255gamF80ZJoJg9fG+C+vNzEdpqjGmB7D+bHlVagK058xPPZWRyj
         rKlSv6SaexO63Mz66cwuxEGJT4Iqc50MVro+d0yvqOmTMTl5AWEUVDEx5pU6JSoBT26X
         y6srBxsh1+VMz5G56DxvX+zYHBTnLCYtIVAOMCq3O0YQWFUm9jsxn6E6TMJPKkz1fLA5
         UrW57AEpl7mnn45G8yHYKkL/ZrD09cIgiHwQaVD9KFVUet7Jv8A/+ozvJaS7vUIN3YfU
         mjiw==
X-Gm-Message-State: AOAM530c1+CIlajjhZhuvk/BFZpf5Np0RmHGOc7H4gME2E6MQww/U8o3
        LL/S5LnbA4Lc8JldxUsWT80=
X-Google-Smtp-Source: ABdhPJwypI5YWuFKDgg1r9ImBrkIiUIt816SXTLbCjwrFDchL1QFIePyxc4voAHl9Oa5uTgUlpGYvw==
X-Received: by 2002:a17:90a:9416:b0:1ca:9cff:7877 with SMTP id r22-20020a17090a941600b001ca9cff7877mr18232491pjo.141.1650662428765;
        Fri, 22 Apr 2022 14:20:28 -0700 (PDT)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id a11-20020a63cd4b000000b00378b9167493sm3062877pgj.52.2022.04.22.14.20.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Apr 2022 14:20:28 -0700 (PDT)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     bcm-kernel-feedback-list@broadcom.com,
        William Zhang <william.zhang@broadcom.com>,
        linux-arm-kernel@lists.infradead.org
Cc:     Kursad Oney <kursad.oney@broadcom.com>,
        Joel Peshkin <joel.peshkin@broadcom.com>,
        Anand Gore <anand.gore@broadcom.com>,
        Dan Beygelman <dan.beygelman@broadcom.com>,
        Florian Fainelli <florian.fainelli@broadcom.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Dmitry Osipenko <digetx@gmail.com>,
        Joel Stanley <joel@jms.id.au>,
        Russell King <linux@armlinux.org.uk>,
        Stephan Gerhold <stephan@gerhold.net>,
        Thierry Reding <treding@nvidia.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 5/5] ARM: multi_v7_defconfig: enable CONFIG_ARCH_BCMBCA in armv7 defconfig
Date:   Fri, 22 Apr 2022 14:20:26 -0700
Message-Id: <20220422212026.2030627-1-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220413192645.7067-6-william.zhang@broadcom.com>
References: <20220413192645.7067-1-william.zhang@broadcom.com> <20220413192645.7067-6-william.zhang@broadcom.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 13 Apr 2022 12:26:45 -0700, William Zhang <william.zhang@broadcom.com> wrote:
> Enable CONFIG_ARCH_BCMBCA in multi_v7_defconfig. This config can be
> used to build a basic kernel for BCM47622 booting to console.
> 
> Signed-off-by: William Zhang <william.zhang@broadcom.com>
> 
> ---

Applied to https://github.com/Broadcom/stblinux/commits/defconfig/next, thanks!
--
Florian
