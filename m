Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0250E527772
	for <lists+linux-kernel@lfdr.de>; Sun, 15 May 2022 14:42:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236665AbiEOMmM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 May 2022 08:42:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234838AbiEOMmJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 May 2022 08:42:09 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10F5E1208F
        for <linux-kernel@vger.kernel.org>; Sun, 15 May 2022 05:42:09 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id f10so45150pjs.3
        for <linux-kernel@vger.kernel.org>; Sun, 15 May 2022 05:42:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=AVFRHlzGX/WRPz6rMiRYI/Ib3vqoWaqc8BQYvZ/LSIw=;
        b=GdwFTCPfiO7U9zosXxBYcmAhFZEaMxvG4SFgMUw0AhuFegMc2OQ1Xwr5VDAyHE1+J4
         4VNF81weFqaGZIrQm8Ee6tApJwzn7N3atSaPeZop5agNoThRnLzfvoz5JXBMPG1SOghp
         DGEcGxEgnBY8LVTZtiQ8c0Ixix2KZqYdiBQrcoH5stOW+UhNYay8I5QDbcJmfQkQBC8h
         XYBsRGvVJlLbTAml3ooN9rZsrzGu+EETood1emxQvigTV1O0x/b9Sj6rWqW1MyU7anUU
         WKZt8+Bcoubs3Jki51/L77N/m10WeSOPZ0MHxzv3u/bk13EMIZEd7QbzBMGOJSXyNlAK
         sctg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=AVFRHlzGX/WRPz6rMiRYI/Ib3vqoWaqc8BQYvZ/LSIw=;
        b=Plre6ohiLPGAi8Ai0EA2Uubu4fnvCV2u+xNI4y4kWdtk8GFgK3nhDX7U7bWbn2tGyK
         Sz7oLSBiJx5u2G9jant3l5+7d+ccqoZzXGFYYQh2BgTwBuiUS3aJFnS46bywlwY8pIFZ
         4PLWgNHjf4E1Ic5x4DGywhyJOK+Rn2TMClNLAyBtE9YJHG8VIGH3djsI1GmQrDtI1PLS
         MbBzN0GG7GvSnjkkZoCepVMLjY7v9TkHgGtmq2jKyQB8KjGSQ76OuSFdPc/qFjOpBP63
         AKEMwmnL8FXUe81jbLoW266ma5IHmozkXlqKMtLML+cPlwuXhYEQwLpkigyu1vDza8iU
         eDSA==
X-Gm-Message-State: AOAM533cYw0mO9fIgeuz4pOUYGJTu4zglnbTAarCz1aH/dS+V+KAy6jT
        ddsESwbZywGpAk9d/RN1wjkJ08gEYx8=
X-Google-Smtp-Source: ABdhPJyttjmNeeyG93To3spB1iaqBDuusIqIkyuFaa7RIV56YC49oI0C1AkgwgnzdhnM5CYiJPEOow==
X-Received: by 2002:a17:90b:1d92:b0:1dc:3f14:f8d0 with SMTP id pf18-20020a17090b1d9200b001dc3f14f8d0mr14391431pjb.7.1652618528030;
        Sun, 15 May 2022 05:42:08 -0700 (PDT)
Received: from localhost ([2409:10:24a0:4700:e8ad:216a:2a9d:6d0c])
        by smtp.gmail.com with ESMTPSA id j11-20020a056a00174b00b0050dc76281bfsm4948797pfc.153.2022.05.15.05.42.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 May 2022 05:42:07 -0700 (PDT)
From:   Stafford Horne <shorne@gmail.com>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Openrisc <openrisc@lists.librecores.org>,
        Stafford Horne <shorne@gmail.com>
Subject: [PATCH 00/13] OpenIRSC misc cleanups for 5.19
Date:   Sun, 15 May 2022 21:41:45 +0900
Message-Id: <20220515124158.3167452-1-shorne@gmail.com>
X-Mailer: git-send-email 2.31.1
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

This is a collection of misc cleanups I have accumulated when working on some
recent OpenRISC projects.

The patch themes:
 - Sparse warning cleanups
 - Removal of dead code
 - Emergency debug fixups in head.S
 - Support for gcc machine instruction flags
 - defconfig updates for litex

I have tested these patches when verifying the glibc port by running the glibc
test suite.

Stafford Horne (13):
  openrisc: Add gcc machine instruction flag configuration
  openrisc: Cleanup emergency print handling
  openrisc: Add support for liteuart emergency printing
  openrisc: Add syscall details to emergency syscall debugging
  openrisc: Pretty print show_registers memory dumps
  openrisc: Update litex defconfig to support glibc userland
  openrisc/traps: Declare file scope symbols as static
  openrisc/traps: Remove die_if_kernel function
  openrisc/traps: Declare unhandled_exception for asmlinkage
  openrisc/time: Fix symbol scope warnings
  openrisc/delay: Add include to fix symbol not declared warning
  openrisc/fault: Fix symbol scope warnings
  openrisc: Remove unused IMMU tlb workardound

 arch/openrisc/Kconfig                     |  53 ++++
 arch/openrisc/Makefile                    |  17 +
 arch/openrisc/configs/or1klitex_defconfig |  33 ++
 arch/openrisc/kernel/entry.S              |  20 +-
 arch/openrisc/kernel/head.S               | 368 ++++++----------------
 arch/openrisc/kernel/time.c               |   3 +-
 arch/openrisc/kernel/traps.c              |  63 ++--
 arch/openrisc/lib/delay.c                 |   1 +
 arch/openrisc/mm/fault.c                  |   4 +-
 9 files changed, 255 insertions(+), 307 deletions(-)

-- 
2.31.1

