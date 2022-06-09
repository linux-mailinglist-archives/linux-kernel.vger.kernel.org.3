Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47BBB5445A6
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jun 2022 10:26:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240466AbiFIIYd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jun 2022 04:24:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229583AbiFIIYa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 04:24:30 -0400
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85BCC1285EF
        for <linux-kernel@vger.kernel.org>; Thu,  9 Jun 2022 01:24:29 -0700 (PDT)
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com [209.85.218.69])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 0EA443F1EE
        for <linux-kernel@vger.kernel.org>; Thu,  9 Jun 2022 08:24:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1654763068;
        bh=Ej7MHp6szfum25ZZbPC/is2Fiy22+A3o4874paFglCQ=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=UNnXSwqAlwAqBtur3xsxSJTkGxuA/4lX/oeK5JCwfWl+juO3LRxEzTF++MUwGd+9q
         cTbmnZzyNvzlcQntd/KOCeNiROdaTzK6V9/nknisOYwxqw4hbLYITNTbX127/ucH4K
         Ja39L1OUIEFYBFSG5+Th1HsSNnxAM2bRnJgMTjkl6rGmt6vckS81VP61zhgpQ0P298
         fquGfL9WYcG5ZaMvcXyPSmZBWlayy1XvkwcR0DJgob21HS6X5Fa/sWC0FMDcBvG4ok
         4d8YkYtrmzggeR9diWMNclgsCrpTTvxbFm/Z+DEFaK0oAcdO0eO90oDVJaWt1DZnKr
         EGlJlt3+lcvYA==
Received: by mail-ej1-f69.google.com with SMTP id gr1-20020a170906e2c100b006fefea3ec0aso10566411ejb.14
        for <linux-kernel@vger.kernel.org>; Thu, 09 Jun 2022 01:24:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Ej7MHp6szfum25ZZbPC/is2Fiy22+A3o4874paFglCQ=;
        b=UtLAjqoikfJaRhd7u1zEzHgMHl2q9d1/C431j4COMuj5FrwEjHvnD856xya7akIRsa
         JJqWm275HqW399H8Ydie6GspjGA631g1ESDu6IhbkGK/GoKO+CAYJkCZKnl/M5pCyAi9
         RjrKqWC01kItI3EjbSBUjsvdHbrV3IX+kvUjZSiSZAAGxQwQ84MSW8e5fpfvaVKvERWh
         qOkc3LYG7HwDYyWYqjpP4ag4jXz24VKcp4i63as19KsuT7XmVuPYrGFimaq1OnW4gfVZ
         QaggE6fgNtk9mhDH8vuBoFkylPGqsCCCSRxmdrvGk1qNXzbrCyWY1J6VOW73Ld81rlBs
         ec0w==
X-Gm-Message-State: AOAM5326fjYS33S+wPprG0EGwtQdAA5p197H+Km800BNDLOc5IYjG7vD
        GeoF07mWQYAaKKDp/SZC4YDrvfFHMGn5VW2p19xKFoQSgTJ+wjPdCPjBMH5/jyRsU8XYpLYcma4
        paxv/bMP/JUuRbjYJrq++yZQNT0RxiH50oU6u7msNEw==
X-Received: by 2002:aa7:dcc4:0:b0:42d:c666:62b5 with SMTP id w4-20020aa7dcc4000000b0042dc66662b5mr44905183edu.206.1654763067586;
        Thu, 09 Jun 2022 01:24:27 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyu9Sf/BKYFBfqgQU54mvPSdUFw3OdRIuggAHyJ6DOVWjhoG6MjHK5fpN+rTN/vuK1hmeJLZw==
X-Received: by 2002:aa7:dcc4:0:b0:42d:c666:62b5 with SMTP id w4-20020aa7dcc4000000b0042dc66662b5mr44905170edu.206.1654763067432;
        Thu, 09 Jun 2022 01:24:27 -0700 (PDT)
Received: from gollum.fritz.box ([194.191.244.86])
        by smtp.gmail.com with ESMTPSA id v9-20020a170906380900b00711d546f8a8sm4664834ejc.139.2022.06.09.01.24.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jun 2022 01:24:26 -0700 (PDT)
From:   Juerg Haefliger <juerg.haefliger@canonical.com>
To:     krzysztof.kozlowski@linaro.org, linux@armlinux.org.uk,
        alim.akhtar@samsung.com, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Juerg Haefliger <juerg.haefliger@canonical.com>
Subject: [PATCH 0/3 v3] ARM: s3c: Kconfig: Style cleanups
Date:   Thu,  9 Jun 2022 10:21:51 +0200
Message-Id: <20220609082154.115301-1-juerg.haefliger@canonical.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <63eabd40-761e-3b4e-c1be-43a12516e1b0@linaro.org>
References: <63eabd40-761e-3b4e-c1be-43a12516e1b0@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The majority of the Kconfig files use a single tab for basic indentation
and a single tab followed by two whitespaces for help text indentation.
Fix the lines that don't follow this convention.

While at it, add missing trailing comments to endif statements and replace
tabs before comments with whitespaces (which seems to be more common).

v3:
  - Match sob and author email addresses.
  - Rebase to next-20220609.
v2 (patch 2 only):
  - Mention additional changes in the commit message.

Juerg Haefliger (3):
  ARM: s3c: Kconfig: Fix indentation
  ARM: s3c: Kconfig.s3c24xx: Fix indentation and replace some tabs
  ARM: s3c: Kconfig.s3c64xx: Fix indentation

 arch/arm/mach-s3c/Kconfig         | 14 +++++++-------
 arch/arm/mach-s3c/Kconfig.s3c24xx | 26 ++++++++++++--------------
 arch/arm/mach-s3c/Kconfig.s3c64xx | 16 ++++++++--------
 3 files changed, 27 insertions(+), 29 deletions(-)

-- 
2.32.0

