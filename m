Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C74B4CE986
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Mar 2022 07:45:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232999AbiCFGqR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Mar 2022 01:46:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231496AbiCFGqP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Mar 2022 01:46:15 -0500
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EF0B5520E;
        Sat,  5 Mar 2022 22:45:23 -0800 (PST)
Received: by mail-pf1-x435.google.com with SMTP id p8so11116165pfh.8;
        Sat, 05 Mar 2022 22:45:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=y17NxRIyAZ0QbQh8HrJFU8tqK+/ZOu5SO1Yl2JzX3sE=;
        b=dMIstqJ/q4smhGApxPpkCzFLpM0TFtDMP1bJHsILasMeddSesq3Cmm+DZv9oWnPTVU
         ZLnbNiJ4e+rvKN5aRog6ykEbmf59X5R9YLwt2QiTIg2GKyETyLccL/tcXK8enSk6TG1M
         YBbebz2oBtiVXdRYV8ATjjzkwLPwrKfzCNebH/GCJVAVmE851mqWR5SUkieEXJQ6hC0m
         0JKv/WICjxNH5UUObbIAKmO/qESh2RNKV6nXrc6CFAYMzuBRyJanoNeKjJaXUp6puRsb
         jmNwKlVLGzyOqVODbmev8lL+By+QZFXlH16J4NnGvjeojHj2Y3xsAUQ5A3x3yGE9Ee6F
         bITg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=y17NxRIyAZ0QbQh8HrJFU8tqK+/ZOu5SO1Yl2JzX3sE=;
        b=eawUMecd5yegU33VQ385dLBAM7O/fhqyW2lSP/TCLdPNX+4H2ly4ALq6ZI2lfqxuQ/
         +lW9umZzE/NAQ7prZiFUSoPj6wsNm69ibNut9lGFMaJ15Ye7A3rtRLlEwp/y0zKUxsDG
         wXjaRwEuD9/bBGOSRwFUFcF4TfV9AoYFM1u4mIBvZd6Gwwdq7SysxZVOC1ku8oNh/FFK
         1YViWiW8Vy1SLwwbNk6ehZg7p4eQZfOAEGgq3BYHGX9GYp67ve/sVXgbkJsGkhGCLASB
         MrkT0dAaSSBCsWLmnSwxxSbFVvU1znaMKuTjVcP7pQOcuaZ261tCe0eSN5NQId43gF1K
         52bQ==
X-Gm-Message-State: AOAM531+aLC2Ti7ri0iJNf3vwvPItM1bR3gOMZYameFAIWHvcpHJlfcH
        HlcgkGR8j040wpP4rVwJBTA=
X-Google-Smtp-Source: ABdhPJyW7sA5A2y8aHP1+G+dmwlasq7FW8LB/j07ubqGhUzv26cDWtaG+dyWY8q9dLFOqb12uOwwkw==
X-Received: by 2002:a62:be1a:0:b0:4f4:c50:4209 with SMTP id l26-20020a62be1a000000b004f40c504209mr7158090pff.64.1646549122248;
        Sat, 05 Mar 2022 22:45:22 -0800 (PST)
Received: from octofox.hsd1.ca.comcast.net ([2601:641:401:1d20:dcdb:d868:b18f:a9a8])
        by smtp.gmail.com with ESMTPSA id 132-20020a62168a000000b004f40e8b3133sm12229047pfw.188.2022.03.05.22.45.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Mar 2022 22:45:21 -0800 (PST)
From:   Max Filippov <jcmvbkbc@gmail.com>
To:     linux-xtensa@linux-xtensa.org
Cc:     Chris Zankel <chris@zankel.net>, linux-kernel@vger.kernel.org,
        Kees Cook <keescook@chromium.org>,
        linux-hardening@vger.kernel.org, Max Filippov <jcmvbkbc@gmail.com>
Subject: [PATCH 0/2] xtensa: fix pt_regs to cover user exception frame
Date:   Sat,  5 Mar 2022 22:44:33 -0800
Message-Id: <20220306064435.256328-1-jcmvbkbc@gmail.com>
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

this series updates xtensa struct pt_regs so that it covers the whole
user exception frame fixing kernel build issue visible in the current
linux-next.

Max Filippov (2):
  xtensa: rename PT_SIZE to PT_KERNEL_SIZE
  xtensa: use XCHAL_NUM_AREGS as pt_regs::areg size

 arch/xtensa/include/asm/ptrace.h |  7 +++----
 arch/xtensa/kernel/asm-offsets.c |  2 +-
 arch/xtensa/kernel/entry.S       | 14 +++++++-------
 arch/xtensa/kernel/process.c     | 10 ----------
 arch/xtensa/kernel/vectors.S     |  4 ++--
 5 files changed, 13 insertions(+), 24 deletions(-)

-- 
2.30.2

