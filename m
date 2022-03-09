Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E754C4D3D08
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Mar 2022 23:34:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238721AbiCIWfj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Mar 2022 17:35:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232123AbiCIWff (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 17:35:35 -0500
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45B0D121685
        for <linux-kernel@vger.kernel.org>; Wed,  9 Mar 2022 14:34:36 -0800 (PST)
Received: by mail-pj1-x102a.google.com with SMTP id mr24-20020a17090b239800b001bf0a375440so6579745pjb.4
        for <linux-kernel@vger.kernel.org>; Wed, 09 Mar 2022 14:34:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=tMU467rrw5B4GgqHVrBqQgG0awnkf1H4waFcw+54Qfs=;
        b=I3Nfwgycb/IomXQmFphimGbry58YN720G829IoBZ3KFtgIGJbl1mkVR+qlumos6Evk
         nJ1ucWtSqicRfT8+XA7bbxi7ZoBR8RR8RaPjgLSiem8unUdQjxDzufYMYM2HTYselFDr
         yGo7+UISn3B5WUqZ2qJyAs483RmGyL6i9xDCIcCsHi74Fxt5lH2I5rT6IwVlE4WOWbjl
         aPVJT2MIE/+6Rl5Mkf0SBLSafUX7/vEvHMLgT+8Ufm6pVSKwpqeE3e/eXur3As0mmtjv
         xEJSVjV9eQ0xGZ2Ah4IaIqhL4xcn7TjK/YBuHj56sUW5rKCrfdmvLoF+CyjvhxAOjaPE
         kwOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=tMU467rrw5B4GgqHVrBqQgG0awnkf1H4waFcw+54Qfs=;
        b=mhBKOcnLUesVx2OXf0xrPeDLS+0/Zr2sMJsFxKPbcdmPZG3ovmOEyR33+/vaQGKaAB
         luvdoWic+i/r/WJ/JxT/S2Q/yFgeprv3qjNJ3WOQTf+4tqCBF4cllmIIikgbd/eSkYgX
         n0tKYvZ03iLJDotPwLOpwSGMwGasVtutXVHzMhCN9POwECbqMOT3Xj3D6z3J7X6CYmkk
         jQZowYPmFgXYjBwk+WQKuLyjW8ADRG1gz35746MlZDNH4ZbcoHWTorrwaAvD30fmmO0n
         GmrW4vNstmLj4WOVFSe7YtFFteu5IBqmiB2BAR/7oFKsLKT9IwxdwBvTTGbxsBu8ewM3
         eqSg==
X-Gm-Message-State: AOAM531f6evt+3RhrHvwEufUzwTN4V0Qzsf9GuO5AeA7NeUvmhjJ03XY
        PRE4k2nu45pua6tbheOwvIU=
X-Google-Smtp-Source: ABdhPJyTzmDlvu37sHDEjGfAfT58PTS/WG2UaaLDCVitwWNLna9Da4bCA4oEN/GH666AH5H5jAcseg==
X-Received: by 2002:a17:90b:2092:b0:1be:e373:2ed9 with SMTP id hb18-20020a17090b209200b001bee3732ed9mr1786157pjb.128.1646865275691;
        Wed, 09 Mar 2022 14:34:35 -0800 (PST)
Received: from octofox.hsd1.ca.comcast.net ([2601:641:401:1d20:6f34:be93:349a:f478])
        by smtp.gmail.com with ESMTPSA id e14-20020a056a001a8e00b004f75cf1ab6csm3476477pfv.206.2022.03.09.14.34.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Mar 2022 14:34:34 -0800 (PST)
From:   Max Filippov <jcmvbkbc@gmail.com>
To:     linux-xtensa@linux-xtensa.org
Cc:     Chris Zankel <chris@zankel.net>, linux-kernel@vger.kernel.org,
        Max Filippov <jcmvbkbc@gmail.com>
Subject: [PATCH 0/2] xtensa: don't link with libgcc
Date:   Wed,  9 Mar 2022 14:34:16 -0800
Message-Id: <20220309223418.1253242-1-jcmvbkbc@gmail.com>
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

this series removes xtensa kernel dependency on the libgcc by providing
assembly sources for optimized compiler support functions and using
generic implementations for the rest.

Max Filippov (2):
  xtensa: add helpers for division, remainder and shifts
  xtensa: don't link with libgcc

 arch/xtensa/Kconfig                |   3 +
 arch/xtensa/Makefile               |   6 +-
 arch/xtensa/include/asm/asmmacro.h |  34 ++++++++
 arch/xtensa/kernel/xtensa_ksyms.c  |  14 ---
 arch/xtensa/lib/Makefile           |   2 +
 arch/xtensa/lib/ashldi3.S          |  28 ++++++
 arch/xtensa/lib/ashrdi3.S          |  28 ++++++
 arch/xtensa/lib/divsi3.S           |  74 ++++++++++++++++
 arch/xtensa/lib/lshrdi3.S          |  28 ++++++
 arch/xtensa/lib/modsi3.S           |  87 +++++++++++++++++++
 arch/xtensa/lib/mulsi3.S           | 133 +++++++++++++++++++++++++++++
 arch/xtensa/lib/udivsi3.S          |  68 +++++++++++++++
 arch/xtensa/lib/umodsi3.S          |  57 +++++++++++++
 13 files changed, 543 insertions(+), 19 deletions(-)
 create mode 100644 arch/xtensa/lib/ashldi3.S
 create mode 100644 arch/xtensa/lib/ashrdi3.S
 create mode 100644 arch/xtensa/lib/divsi3.S
 create mode 100644 arch/xtensa/lib/lshrdi3.S
 create mode 100644 arch/xtensa/lib/modsi3.S
 create mode 100644 arch/xtensa/lib/mulsi3.S
 create mode 100644 arch/xtensa/lib/udivsi3.S
 create mode 100644 arch/xtensa/lib/umodsi3.S

-- 
2.30.2

