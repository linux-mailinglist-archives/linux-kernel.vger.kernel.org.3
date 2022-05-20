Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC22D52EB73
	for <lists+linux-kernel@lfdr.de>; Fri, 20 May 2022 14:03:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348953AbiETMC7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 May 2022 08:02:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348969AbiETMCo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 May 2022 08:02:44 -0400
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2417B14A25B
        for <linux-kernel@vger.kernel.org>; Fri, 20 May 2022 05:02:42 -0700 (PDT)
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com [209.85.208.69])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 30EB23F1F9
        for <linux-kernel@vger.kernel.org>; Fri, 20 May 2022 12:02:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1653048160;
        bh=SOKFND/5FeQvd5cQ7sqJ+/KtvRpaDx5IOMydsT+KqBo=;
        h=From:To:Cc:Subject:Date:Message-Id:MIME-Version;
        b=bvLQzVA1IL0HWcqpMpagK4+5cQ+FdVUFjcWaUUB3jzrmsk6J3zV1M9pthYYM+URYD
         dVjI5wPrZeSyZi4hSOTzd9T1m/RzqcIBdDMp0tpAoGjIfb2N1yVaO48m7O2eGp9RFl
         NY+bFRogAwnERTffhPkgrNgSUKNK3rqbH2kiCDXI1abr6v3KNKPLiu5f5vjJgGeW2T
         FwEbDIdgL1+SDL7fFQnQymWTprxwxMT65uqZTLFeruc8Ao5tTVO/YPPGOCdBakOw37
         gZgcB9hkU6lPBoE46LrCGOAfjMfE0SK5wx3Rd4q4Od9lG4999WuEYeeNICvScgg8j9
         YD6At0XJixWOw==
Received: by mail-ed1-f69.google.com with SMTP id u1-20020aa7d981000000b0042acd1f2253so5530266eds.4
        for <linux-kernel@vger.kernel.org>; Fri, 20 May 2022 05:02:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=SOKFND/5FeQvd5cQ7sqJ+/KtvRpaDx5IOMydsT+KqBo=;
        b=w8yjm0ggZ02VRyOyGJrNNu1OAPF51uRZ/xypyVjzsfOgX/AuuUzCZ+yiRtKhAlHUzV
         SvtcrOjM0Ylu8KI5/i9KF1s04BNhquuMEtdWnVlSKI9wfmIi63dfC9+8sTNzid9DjNK7
         pc+Ryb6Oa+5qn2q+TFjgumcL7yGvWMM/Dk2Ueg+xnt33K0B0pJfeiFZ1bNUp11wK815Y
         x20OZiyFYxlI63SMI17ADIZwZkzl/gjLgah4kgcw+3azXCYnj5Av8xm7FeOMNvPYyM7X
         osSoRe9GKk5xgvoi6R1Ys+xUC2CWYZqEQMB+aTPdnzmmlYt5kMOmX5AHVI7anfJG05mm
         KR6A==
X-Gm-Message-State: AOAM533URDArCCrS3++nuPGNEdK/OT3S8N8qAfkhJSJifssavXDte8Nh
        Fukknp89XBDjcTCvcYS6HmR8wN5lzWAWkOhETPC2IaIg8lIYivgLtOG24bV1iPJ9u4DVNWHSzu/
        M3kNL6i019iZN7DsbPUEhZbDe1LxX/zh2H0HnpVyjIA==
X-Received: by 2002:a17:906:6a1b:b0:6f4:a9b8:e027 with SMTP id qw27-20020a1709066a1b00b006f4a9b8e027mr8470922ejc.222.1653048156597;
        Fri, 20 May 2022 05:02:36 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxLBhZtS2l7rKcQpRTvVrgQN0WEu69u4UF18Vcfyzmc60qHzg6vYZFA3fGd9KrMJqNRMGXu3Q==
X-Received: by 2002:a17:906:6a1b:b0:6f4:a9b8:e027 with SMTP id qw27-20020a1709066a1b00b006f4a9b8e027mr8470909ejc.222.1653048156437;
        Fri, 20 May 2022 05:02:36 -0700 (PDT)
Received: from gollum.fritz.box ([194.191.244.86])
        by smtp.gmail.com with ESMTPSA id fg22-20020a1709069c5600b006feb002a620sm560042ejc.1.2022.05.20.05.02.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 May 2022 05:02:35 -0700 (PDT)
From:   Juerg Haefliger <juerg.haefliger@canonical.com>
X-Google-Original-From: Juerg Haefliger <juergh@canonical.com>
To:     paul.walmsley@sifive.com, palmer@dabbelt.com,
        aou@eecs.berkeley.edu, linux-riscv@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org,
        Juerg Haefliger <juergh@canonical.com>
Subject: [PATCH 0/3] riscv: Kconfig: Style cleanups
Date:   Fri, 20 May 2022 14:02:29 +0200
Message-Id: <20220520120232.148310-1-juergh@canonical.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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

While at it:
  - Add trailing comments to endif/endmenu statements for better
    readability.

Juerg Haefliger (3):
  riscv: Kconfig: Fix indentation and add comments
  riscv: Kconfig.erratas: Add comments
  riscv: Kconfig.socs: Add comments

 arch/riscv/Kconfig         | 19 +++++++++----------
 arch/riscv/Kconfig.erratas |  2 +-
 arch/riscv/Kconfig.socs    |  4 ++--
 3 files changed, 12 insertions(+), 13 deletions(-)

-- 
2.32.0

