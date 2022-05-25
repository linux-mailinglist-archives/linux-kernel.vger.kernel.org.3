Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 322DA533DE6
	for <lists+linux-kernel@lfdr.de>; Wed, 25 May 2022 15:32:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244381AbiEYNc1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 May 2022 09:32:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244393AbiEYNcV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 May 2022 09:32:21 -0400
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC9123153F
        for <linux-kernel@vger.kernel.org>; Wed, 25 May 2022 06:32:18 -0700 (PDT)
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com [209.85.218.70])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 811333F21C
        for <linux-kernel@vger.kernel.org>; Wed, 25 May 2022 13:32:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1653485537;
        bh=ZRE/xjf4kV0EJRIL215c8+TgNS1veuQ4gHsEdQ6ToXc=;
        h=From:To:Cc:Subject:Date:Message-Id:MIME-Version;
        b=TrCyqAY2GDvE2Q6v7NAA/dOeg22GN35p1FfoR3R72chIotSeXnI32nYyOFQkIQxCi
         qoJ6fAhVzt0cBnKRRCP4I7crWRPo0ktzFRt6UqCOFGN5A4pWu9UDc1egX83563+h6+
         uXxgnE+IUGPxas2LwQvCfnjAH09x/OxCUJqStjdeTFI/6+XRZ3KI/TvIX4qLJh/YxN
         YZCZlYcrpXVg2aYkq8Hdj7GGF8+588NTlZAROcfuVzi7vHTeNxsgK7lIZ3qzFCiT5V
         WrwIGmW2jzer1LvafWkitcYX8YeofmkUjYFgjpRkOBst9P6B6FBR4IVKYnAA/h5A6A
         C75AlVrlCZthw==
Received: by mail-ej1-f70.google.com with SMTP id l2-20020a170906078200b006fed42bfeacso4609810ejc.16
        for <linux-kernel@vger.kernel.org>; Wed, 25 May 2022 06:32:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ZRE/xjf4kV0EJRIL215c8+TgNS1veuQ4gHsEdQ6ToXc=;
        b=IZk10Q6fOGWOd1iXNwdpXyAAqh2TC3hAs3itY8Vakqs8GfRnrPlpv9fcuce+5xhXJA
         T8zrwPTM9ejtx7t1FXHGewCaRKwoBF+jYSZ9Dsz4fj1vXr1668K98mrdp4k41BsYuECA
         3KnPWKMZ+2pFGo3dwT6M2LFq8Oc/Bgmv6PbDvXohY67/saSAthYVSiMTSoEPm3bFbM/c
         oHjL7Ej2EtCWLU4sp+PIymEcKxceUt5CKpyw4NO2KuPjofdcj9lao4W3ubMd2Sx2O61W
         sJRGnBe29/3KA8mnTXoNq0GMBjvbcn3JgxpKGlC5GirL46IZTzfm+FZTZuEjNABm6q0D
         //Qg==
X-Gm-Message-State: AOAM531/WkEB+YNjTSXwAk9UOZzGaVewmQWp6oWSeaOJB319LssNd0dQ
        VMWlaL5zODZfWXBk2mq/Ym5bPjuW9APKJ4Zcl9AdgPIVmtJRkfvRx4kBUfqvdcg6oxHwp8OyzVU
        9gzzqnVSONyYi4JcnYZaG+ygsLmlCl4EWHFIouNiNLg==
X-Received: by 2002:a17:907:94c6:b0:6fe:d71a:b721 with SMTP id dn6-20020a17090794c600b006fed71ab721mr14651456ejc.313.1653485530189;
        Wed, 25 May 2022 06:32:10 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxnsfjCBKkmtr5LMUS6n+385YUgy2Yz4Yyop8rYp4aJMuiNlAHDptixVhGvP/sCipMsblqhhA==
X-Received: by 2002:a17:907:94c6:b0:6fe:d71a:b721 with SMTP id dn6-20020a17090794c600b006fed71ab721mr14651192ejc.313.1653485526675;
        Wed, 25 May 2022 06:32:06 -0700 (PDT)
Received: from gollum.fritz.box ([194.191.244.86])
        by smtp.gmail.com with ESMTPSA id d8-20020a17090694c800b006fe9209a9edsm3723388ejy.128.2022.05.25.06.32.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 May 2022 06:32:06 -0700 (PDT)
From:   Juerg Haefliger <juerg.haefliger@canonical.com>
To:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com
Cc:     linux-kernel@vger.kernel.org,
        Juerg Haefliger <juerg.haefliger@canonical.com>
Subject: [PATCH 0/2] x86: Kconfig: Style cleanups
Date:   Wed, 25 May 2022 15:32:01 +0200
Message-Id: <20220525133203.52463-1-juerg.haefliger@canonical.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The majority of the Kconfig files use a single tab for basic indentation
and a single tab followed by two whitespaces for help text indentation.
Fix the lines that don't follow this convention.

While at it, add missing trailing endif comments.

Juerg Haefliger (2):
  x86: Kconfig: Fix indentation and add endif comments
  x86: Kconfig.debug: Fix indentation

 arch/x86/Kconfig       | 101 ++++++++++++++++++++---------------------
 arch/x86/Kconfig.debug |  29 ++++++------
 2 files changed, 63 insertions(+), 67 deletions(-)

-- 
2.32.0

