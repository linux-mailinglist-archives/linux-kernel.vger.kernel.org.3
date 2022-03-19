Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 718924DEA8E
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Mar 2022 21:13:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244084AbiCSUOc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Mar 2022 16:14:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244082AbiCSUO0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Mar 2022 16:14:26 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8F242DF7
        for <linux-kernel@vger.kernel.org>; Sat, 19 Mar 2022 13:13:04 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id w4so9608980ply.13
        for <linux-kernel@vger.kernel.org>; Sat, 19 Mar 2022 13:13:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=CK1GNmHaBv0qQSqFE9QfXEu8p+Y5BCjQtKKbNgK9AKk=;
        b=FkzdPyzttNzdFFm9Y2x2Zg/Bvd3QvrWlH1K7CFy1kABM7oVSRl1gGB5wzdzJ1KYuG3
         nVGj0uwelWTsgVIclThf3/+VPRMmbq3FoMQnAFJhgVe08Ix0SSG0Bog6rlxUEBk+Ibz0
         gA+NpfoNJe5AqEh9mc+tr4jb3X91csrWgaB7ZjEYFUnFywlw8nyTB8qr16OBT+M7hD0E
         821y4mb2kN/ft3xSbNMXA6fqCF3IqOMDzk5bCseXzjvYS8ufom7klbhR5SLzYIz92cN9
         8HKlLLigrU905Sl7NZ6wngs9IEl6N/P9DOAUBYB4nxyucAVDL+piPF+t0QNDvU9msUbc
         Mnxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=CK1GNmHaBv0qQSqFE9QfXEu8p+Y5BCjQtKKbNgK9AKk=;
        b=OtAfdiqe5kuWEvexbX6qvGXtNUxNt08+PHloT+zQ4IH7SygGwwNqO5rbk96zugEyIi
         AFjDtmJ8d36xnIQwq2E2ckTf6AHRjctNOqzpGxK24xdn1SeNTo6Z1n1JJ3gSklq/WRqn
         Qn5QFF7k0C+dHRIizcxHba8wcAYIjftEpJ5gU4Z9FQQoXKhGHLxpPKW2WDMJLLtXk4Z9
         UMUxd+XFOtzgZkYPmwd5DM5JQi/+lauPZSkwgWCaQ+/eeeDgR2pcdtaAfA4/XAL/1hZ+
         9BK34l+HTdgcfxnhKYOcmGbDO/EuKlRyZ6LcsD3trKOMleoEt2SopKO2ewIegTvBDy84
         Gmzg==
X-Gm-Message-State: AOAM531igN0XWuwWGDRlG4AuTilIM2w/6fFqsfeoll4SHU38k98vRRhT
        qTsyFM5hv5LeqF6FAj+Yt2U=
X-Google-Smtp-Source: ABdhPJwBrduYugWxMBvxsNnsENJ20uy8o1+XRE9r/nZyEPEXAilsIv8w7M21nWEEc4gt4BQP46IvhA==
X-Received: by 2002:a17:90b:180b:b0:1bf:27c5:2c51 with SMTP id lw11-20020a17090b180b00b001bf27c52c51mr18224894pjb.142.1647720784149;
        Sat, 19 Mar 2022 13:13:04 -0700 (PDT)
Received: from octofox.hsd1.ca.comcast.net ([2601:641:401:1d20:951a:ad0c:e44c:ff47])
        by smtp.gmail.com with ESMTPSA id y8-20020a17090aa40800b001c6ccb2c395sm3367418pjp.9.2022.03.19.13.13.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Mar 2022 13:13:03 -0700 (PDT)
From:   Max Filippov <jcmvbkbc@gmail.com>
To:     linux-xtensa@linux-xtensa.org
Cc:     Chris Zankel <chris@zankel.net>, linux-kernel@vger.kernel.org,
        Max Filippov <jcmvbkbc@gmail.com>
Subject: [PATCH] xtensa: rearrange NMI exit path
Date:   Sat, 19 Mar 2022 13:12:54 -0700
Message-Id: <20220319201254.3006707-1-jcmvbkbc@gmail.com>
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

NMI exit path to userspace should neither check TIF_DB_DISABLED nor call
check_tlb_sanity because NMI shouldn't touch anything related to
userspace. Drop kernel/userspace check in NMI exit path.

Signed-off-by: Max Filippov <jcmvbkbc@gmail.com>
---
 arch/xtensa/kernel/entry.S | 13 ++++---------
 1 file changed, 4 insertions(+), 9 deletions(-)

diff --git a/arch/xtensa/kernel/entry.S b/arch/xtensa/kernel/entry.S
index 77a7c8da3ff5..8d671898d582 100644
--- a/arch/xtensa/kernel/entry.S
+++ b/arch/xtensa/kernel/entry.S
@@ -488,9 +488,10 @@ KABI_W	or	a3, a3, a2
 common_exception_return:
 
 #if XTENSA_FAKE_NMI
-	l32i	a2, a1, PT_EXCCAUSE
-	movi	a3, EXCCAUSE_MAPPED_NMI
-	beq	a2, a3, .LNMIexit
+	l32i	abi_tmp0, a1, PT_EXCCAUSE
+	movi	abi_tmp1, EXCCAUSE_MAPPED_NMI
+	l32i	abi_saved1, a1, PT_PS
+	beq	abi_tmp0, abi_tmp1, 4f
 #endif
 1:
 	irq_save a2, a3
@@ -550,12 +551,6 @@ common_exception_return:
 	j	4f
 #endif
 
-#if XTENSA_FAKE_NMI
-.LNMIexit:
-	l32i	abi_saved1, a1, PT_PS
-	_bbci.l	abi_saved1, PS_UM_BIT, 4f
-#endif
-
 5:
 #ifdef CONFIG_HAVE_HW_BREAKPOINT
 	_bbci.l	a4, TIF_DB_DISABLED, 7f
-- 
2.30.2

