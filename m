Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E8DA5743CA
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jul 2022 06:40:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237742AbiGNEkN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jul 2022 00:40:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237871AbiGNEji (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jul 2022 00:39:38 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3B83286CE
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jul 2022 21:27:43 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id o3-20020a17090a744300b001ef8f7f3dddso1428439pjk.3
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jul 2022 21:27:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1zxZAoy64GdtsJQOfRGCbNc3VQnUKxrndVlWjexAZME=;
        b=i9qANYhdJ1TDqpr/gQ/fVixRIYA9nY9RltKyOvwVt1eIqD1isphbX/CIUFZkepe7tq
         uvYGafyIEefyU/FNiJkE1cCTNzcjJB8ZfyhKwgCpRsxd8R+kF9/fgd1j3A9DbI6FNq7t
         QWY6olDoQnYpCMY1cdHbhEpZluSWMLZLcQUGFiLit+NFxE0L3Fkx/E1mmMxOCc3jtyxR
         kUe1E01oD2cdHPtbaJhkkAdICDWlev2XRTc1DOSMM5LVKZzZJQMHCOFeqfYtk9lNAhp8
         /vlX5YWS5vR7B+Ted7ceDxS/JgDHbPsL9xnkShSWWutLp+csYXnaixd4DaO8RWh+1vb7
         KdiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1zxZAoy64GdtsJQOfRGCbNc3VQnUKxrndVlWjexAZME=;
        b=lWHji+oUQMOBOW7yw0bYB++4Zt9b86O67IRyK9M5Mu+p0l1kKMD/e2BpeyDxnnSF9/
         1zzelpfgx5vwoDNxtaVvpU3CUXWVcDZDFUhjpdBjzRO0nMej3qXCE8Mdt5HcWPOvpkrs
         NnBoADjFDmf1nOUsahzjNo+S3tO7+LDXX5RjLj23S9MMXO7UW0YRUcyQSPzXis9YykOv
         Npy3zx5OClWOwtLyrjQalP/xZXULUuKYKibpNhBp6ro5Mkqi7uYztwOjWO2weG0dxQRL
         BFcxIWgNyFz4nS4BNxKJQx3b7ZLc3E8ZXjas2XuhspSeU5MO8AlcSRxJocDjBfYTxfSN
         cSaQ==
X-Gm-Message-State: AJIora8ZlvKNx3hfHFQECLC7zOgBMfwZFvPbnIHhXh4YcVjFxZDs/BwM
        KmsCgEX2pryO6X7gLFtQYj2kA7WmRqA=
X-Google-Smtp-Source: AGRyM1vf5Tts11shJZnxVMR8ji9kdGEwP6T7fHyzDKH5EteBhIdecA66VKgsMU6CVeYNJ13Te0y9CA==
X-Received: by 2002:a17:90b:4d85:b0:1ef:9fd2:b789 with SMTP id oj5-20020a17090b4d8500b001ef9fd2b789mr14006208pjb.196.1657772863079;
        Wed, 13 Jul 2022 21:27:43 -0700 (PDT)
Received: from localhost ([2409:10:24a0:4700:e8ad:216a:2a9d:6d0c])
        by smtp.gmail.com with ESMTPSA id z26-20020aa7959a000000b00528bd940390sm396538pfj.153.2022.07.13.21.27.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Jul 2022 21:27:42 -0700 (PDT)
From:   Stafford Horne <shorne@gmail.com>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Openrisc <openrisc@lists.librecores.org>,
        Stafford Horne <shorne@gmail.com>
Subject: [PATCH v2 0/2] OpenRISC support for virt platform with PCI
Date:   Thu, 14 Jul 2022 13:27:33 +0900
Message-Id: <20220714042736.2133067-1-shorne@gmail.com>
X-Mailer: git-send-email 2.36.1
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

Hello,

This is a set of kernel patches which I have been using to support the new QEMU
virt platform [1].  The virt platform supports PCI hence I have a patch here to
add PCI support to OpenRISC.

A defconfig is also included which turns on drivers supported devices include
virt network cards and the goldfish RTC.

[1] https://github.com/stffrdhrn/qemu/tree/or1k-virt-3

Changes since v1:

 - Remove PIO support as suggest by Arnd

Stafford Horne (2):
  openrisc: Add pci bus support
  openrisc: Add virt defconfig

 arch/openrisc/Kconfig                |   7 +-
 arch/openrisc/configs/virt_defconfig | 108 +++++++++++++++++++++++++++
 arch/openrisc/include/asm/Kbuild     |   1 +
 arch/openrisc/include/asm/io.h       |   2 +-
 arch/openrisc/include/asm/pci.h      |  36 +++++++++
 5 files changed, 150 insertions(+), 4 deletions(-)
 create mode 100644 arch/openrisc/configs/virt_defconfig
 create mode 100644 arch/openrisc/include/asm/pci.h

-- 
2.36.1

