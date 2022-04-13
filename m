Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C77C5002CB
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Apr 2022 01:50:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238901AbiDMXwQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Apr 2022 19:52:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbiDMXwK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 19:52:10 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7104C3CFCB
        for <linux-kernel@vger.kernel.org>; Wed, 13 Apr 2022 16:49:46 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id bg24so3551667pjb.1
        for <linux-kernel@vger.kernel.org>; Wed, 13 Apr 2022 16:49:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2D/qBXdrk7ZXIoBr7a89aPIY20fw/HMXa9aQEJud9fA=;
        b=B7ESQlFRcLSjm8ncxhQggA9eJW5n7dvus1LsemSYq3h/tA9JxUM1Cx1h0ey5iqPVCI
         ZsZCrosRxaOY+V59K161xjtvovm6aGW3EiGFEWhxkY5Y6XLqOaZtJPSsK4HobbJxhGdt
         iyleaYOVVFHkevCL1Yju5RVzS6AYe3T1v9g5hY8kltHmgq8zKWsLE5vuEJbAXdWb44pa
         maDHPgfb68vMVKEBHNnAerhnt2lpqF6d2tN0j7XYCujfIirsjqCSVjRxtLr8KBk5d1OO
         EaEZ20LCJN9aTS55PmhJnsHnq+jG2VppDayu9XrUPDxrvfTx7IUwcRMukUTOajp41QS5
         UyWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2D/qBXdrk7ZXIoBr7a89aPIY20fw/HMXa9aQEJud9fA=;
        b=Oqe66Oqt8LQjMoZNgZfskOdohik50s/40zd6HCOKhS4PxDWz20gQ4+sDomR/wy14ut
         9+eft9Zb6TlIJQyLE6iNK3s1duLcfzxX2qhHKCPzlhVQcmITVNpOAduf+U/M+J7MPdwT
         jN926cVfbhVdW8FPBHeysZmPK6Rv6dyChKGDsgXNqMHcTsl95kf6B88LFx0K/Mf8sgI9
         iWw5DWLtMGK1GTdY9H0vgWcrf2eeBUi117QM/vvbtph7lgL6qhHtKwPJBIe8VHfbRddb
         ByaYTJOeyZ2JqTgf5kaYWjotf+xtyR6x+Y85kkkI+ZnPSBSTo/Z496kB77DhobhIwpMD
         6+8g==
X-Gm-Message-State: AOAM530Bkti7mDuGNBbNkDOWj63xRn9ip0JuKkX8l2fWbcqlr/3NS3pe
        ZjWZloaeCuhZc+HLG8l9D4Q=
X-Google-Smtp-Source: ABdhPJw2/u+79k8T6MV5jVby/X54BZPOWhnaBZkt9mTSf5shL9wGn4GDop9TwgAt5kPH+f8l8MvdFg==
X-Received: by 2002:a17:90b:4c43:b0:1cb:bc2c:ad4a with SMTP id np3-20020a17090b4c4300b001cbbc2cad4amr675144pjb.230.1649893785961;
        Wed, 13 Apr 2022 16:49:45 -0700 (PDT)
Received: from octofox.hsd1.ca.comcast.net ([2601:641:400:e00:389b:6ba3:7cbd:d8d])
        by smtp.gmail.com with ESMTPSA id d20-20020a056a00199400b005060849909esm197075pfl.176.2022.04.13.16.49.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Apr 2022 16:49:45 -0700 (PDT)
From:   Max Filippov <jcmvbkbc@gmail.com>
To:     linux-xtensa@linux-xtensa.org
Cc:     Chris Zankel <chris@zankel.net>, linux-kernel@vger.kernel.org,
        Max Filippov <jcmvbkbc@gmail.com>
Subject: [PATCH 0/3] xtensa: allow handling protection faults in noMMU
Date:   Wed, 13 Apr 2022 16:49:27 -0700
Message-Id: <20220413234930.1212335-1-jcmvbkbc@gmail.com>
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

most xtensa cores have some sort of memory protection mechanism, even
those without full MMU. This series separates protection fault handling
from the CONFIG_MMU setting and allows noMMU configurations to also
do it. This improves userspace behavior in case of errors such as
passing NULL pointer to a syscall that expects a valid memory pointer:
instead of killing the process the kernel is now able to return -EINVAL
from a syscall.

Max Filippov (3):
  xtensa: move asid_cache from fault.c to mmu.c
  xtensa: extract vmalloc_fault code into a function
  xtensa: noMMU: allow handling protection faults

 arch/xtensa/Kconfig        |  11 ++++
 arch/xtensa/kernel/traps.c |  20 +++----
 arch/xtensa/mm/Makefile    |   3 +-
 arch/xtensa/mm/fault.c     | 112 +++++++++++++++++++------------------
 arch/xtensa/mm/mmu.c       |   2 +
 5 files changed, 83 insertions(+), 65 deletions(-)

-- 
2.30.2

