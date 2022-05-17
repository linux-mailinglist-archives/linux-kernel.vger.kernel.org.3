Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF6B8529FC1
	for <lists+linux-kernel@lfdr.de>; Tue, 17 May 2022 12:49:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344622AbiEQKsi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 May 2022 06:48:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244894AbiEQKpK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 May 2022 06:45:10 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49E6D326D7
        for <linux-kernel@vger.kernel.org>; Tue, 17 May 2022 03:45:09 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id k26so2399196wms.1
        for <linux-kernel@vger.kernel.org>; Tue, 17 May 2022 03:45:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=NFw8Ijg8sMBiPh1wpuDsVjM9V1UC65bp4/9nHH1DnNw=;
        b=bZyZnczu9kXL7CaM1OEydco+Bx2UiuBb6JjKg3p63R+zyYNF2kIgpjZNHUDTKgLaRj
         nQCtf0FvHcSArkv8fh+9LkFHKwRiLIiWDvNk3xkxmyCdPeGQqoW5E75TGQzj2SNTcp7e
         qZioXCjblkUC4T2VZnJaPLVHd5A25uGZC/M1RVq4503tJzR2oM9pmHir76ULMBSqrUpe
         pr0CwACByQwIyWiOpFMoJ6gpH/0uK1hS1dsG//IA1ER3WU5z04U7pdyoQJJ+QbolwShU
         E4/QC4cFpX4Qy8nG8r0oVVIag+YRR+U8bFeMFX4XqSJ3BOGa3FFb06yPXldQ0/75TLKF
         /JPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=NFw8Ijg8sMBiPh1wpuDsVjM9V1UC65bp4/9nHH1DnNw=;
        b=nlurWCPZTzllqVlJNdhBkA8EX83cOHdGnWerYADyhPLKVbd8Ydu6x6/yK85ZB2ynEV
         JOGicbwJQ9oEpJbyua7AYKpdk6T23Qo7PVVrCmNbMwe73cpZLE6qeoOi+0KrGyO0REnP
         1rG2OQ3RsWQd5IOwgjas9g+eRSTMuCwPGQlHEH822sJvul+EpbIxv0Y5symM+G2UALSe
         bZdlRbPxQF3Ntp2mnEPdT8nqIwVEBNM9vljumlqEdNqpOLCqF3urfy4EinXVNCPVU5Zu
         /w/p3EKoTVLJR59Kk+knP6icNs56nvnU9Qu2q1gm+ISP/y9D5csVF+scjNeaifzz24zw
         IlOQ==
X-Gm-Message-State: AOAM531HW0LccHY7QVDj7xpAhUB3ia2RwW/4Rip5PCkGTR9EVU/ntWUS
        2QnOjFrZ2wHXTwfPBI51upE=
X-Google-Smtp-Source: ABdhPJydl/8uv8g7gEdazrh9E2zyOqnxpqVsFoRL1ME0pKLa7R1RE38SEDCqS4EerY4OBA6arxxm7g==
X-Received: by 2002:a05:600c:1c0e:b0:394:66af:ef0f with SMTP id j14-20020a05600c1c0e00b0039466afef0fmr30752373wms.48.1652784307733;
        Tue, 17 May 2022 03:45:07 -0700 (PDT)
Received: from octofox.metropolis ([178.134.210.144])
        by smtp.gmail.com with ESMTPSA id r5-20020adfbb05000000b0020d00174eabsm8612218wrg.94.2022.05.17.03.45.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 May 2022 03:45:07 -0700 (PDT)
From:   Max Filippov <jcmvbkbc@gmail.com>
To:     linux-xtensa@linux-xtensa.org
Cc:     Chris Zankel <chris@zankel.net>, linux-kernel@vger.kernel.org,
        Max Filippov <jcmvbkbc@gmail.com>
Subject: [PATCH v3 0/3] xtensa: add division by zero exception handler
Date:   Tue, 17 May 2022 03:44:55 -0700
Message-Id: <20220517104458.257799-1-jcmvbkbc@gmail.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        FROM_LOCAL_NOVOWEL,HK_RANDOM_ENVFROM,HK_RANDOM_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

this series adds handlers for hardware and artificial division by zero
exceptions and improves call0 ABI probing in the presence of unrelated
illegal instructions.

Changes v2->v3:

- simplify artificial division by 0 handler

Changes v1->v2:

- split ABI probing improvement from the artificial division by 0
- don't limit artificial division by 0 pattern detection to
  configurations without HW division opcodes, do it always

Max Filippov (3):
  xtensa: add trap handler for division by zero
  xtensa: support artificial division by 0 exception
  xtensa: improve call0 ABI probing

 arch/xtensa/include/asm/thread_info.h |  4 +++
 arch/xtensa/kernel/asm-offsets.c      |  3 ++
 arch/xtensa/kernel/entry.S            |  5 ++++
 arch/xtensa/kernel/traps.c            | 43 ++++++++++++++++++++++++++-
 4 files changed, 54 insertions(+), 1 deletion(-)

-- 
2.30.2

