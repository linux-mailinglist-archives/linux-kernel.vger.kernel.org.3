Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 13A2249D1D5
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jan 2022 19:36:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232349AbiAZSgm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jan 2022 13:36:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230424AbiAZSgk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jan 2022 13:36:40 -0500
Received: from mail-qv1-xf2a.google.com (mail-qv1-xf2a.google.com [IPv6:2607:f8b0:4864:20::f2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BC40C06161C
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jan 2022 10:36:40 -0800 (PST)
Received: by mail-qv1-xf2a.google.com with SMTP id i19so597497qvx.12
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jan 2022 10:36:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=a4jxpLDSedySyiIRtZviJmX3NEbTJyD67N5MQRypTW4=;
        b=h4xkZoFvH7iJDfUXQm8znpFEc6PC4s+tPROBi0jwbzFdezVF74R3DKaPnWdHLdOtoc
         vlMKDt3P48E110Jh7Anz+LurpmyWB0G52b6QQ1EaRtDaL1nhcqg04hES0HdEtmqvBxSJ
         2c799pa2UtMjpZlRATILhE8KJyjmZVH7VQ05PDArfwetmSwAPYO7mXnQwony0pjCCny0
         tu9U2t0OfPWoqAaMSdCnCUm9uVOrJUVtaqVD+7Wk3buw+IBNSO+FAr7Zq8CukabBp7+w
         hEC4Mf98vxoxOlZNSig54sbYNmpaKk1uEfetnfov5Ttpc29zRvWDY1Q5Wuv8bWglzYHb
         EMKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=a4jxpLDSedySyiIRtZviJmX3NEbTJyD67N5MQRypTW4=;
        b=wzVDIIEBTSu/akbojzLIh21TxsXLfO69eX/xxPtsbJjeyYZvJyb4GdDEVJyhjR793M
         l2fL09lbnB3hWy/lqx69NEcWn6eRvb9jG2luCQndTjTGMeUGig46Y+BeWbdWseayVjCo
         Ww20EI54t3FuIvnkWTmbefZ72MiFcY4RPIexI9Qu0jLfNdYUSKrHj6Bav+hQC1n3IycC
         S9t48reAPWEltzHvfWYN6xEXKEVsxymYLS5bsa/MvFzgVAFSm+iaHkQfN6xllm9P7bjE
         v/JfAvRX1jZzNHeS1KEUP400QVeJ5Z/OOyZuE71ShhheXMBRH6c39c+UzHZpvMHlcmxb
         aaeQ==
X-Gm-Message-State: AOAM533rYy1JHmfQBHW5xeYwpTPqFhaJlXva+0Hvb0bkljJ2zEQIUjzb
        2p9emKSF7EA4N78fvgMS5VshXA==
X-Google-Smtp-Source: ABdhPJz5AdoQSF76RU52VZ6gwOZf8Oqw8CGR3SV0rJAznxxoLsdi7kYebbkAsr0hK4EkKj/v6JtwEQ==
X-Received: by 2002:a05:6214:4014:: with SMTP id kd20mr12158585qvb.84.1643222199674;
        Wed, 26 Jan 2022 10:36:39 -0800 (PST)
Received: from soleen.c.googlers.com.com (189.216.85.34.bc.googleusercontent.com. [34.85.216.189])
        by smtp.gmail.com with ESMTPSA id h9sm26226qkp.75.2022.01.26.10.36.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jan 2022 10:36:39 -0800 (PST)
From:   Pasha Tatashin <pasha.tatashin@soleen.com>
To:     pasha.tatashin@soleen.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, akpm@linux-foundation.org, rientjes@google.com,
        pjt@google.com, weixugc@google.com, gthelen@google.com,
        mingo@redhat.com, will@kernel.org, rppt@kernel.org,
        dave.hansen@linux.intel.com, hpa@zytor.com,
        aneesh.kumar@linux.ibm.com, jirislaby@kernel.org,
        songmuchun@bytedance.com, qydwhotmail@gmail.com, hughd@google.com,
        ziy@nvidia.com, anshuman.khandual@arm.com
Subject: [PATCH v4 0/4] page table check fixes and cleanups
Date:   Wed, 26 Jan 2022 18:36:33 +0000
Message-Id: <20220126183637.1840960-1-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.35.0.rc0.227.g00780c9af4-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changelog:
v4:	- Addressed review comments from David Rientjes
	- Added Acks.
v3:	- Resolved a regression introduced in previous version, where
	  page collapse in khugepaged would cause crash on boot.
	- Addressed comments from Anshuman Khandual regarding commit
	  log.
v2:	- Addressed simplification comments from Wei Xu
	- Added Review-by/Tested-by's from Zi Yan and Wei Xu


Two fixes:

  mm/debug_vm_pgtable: remove pte entry from the page table
	- remove a pte entry from the page table at the end of
	  debug_vm_pgtable pte test

  mm/khugepaged: unify collapse pmd clear, flush and free
  mm/page_table_check: check entries at pmd levels
	- check pmd level in page_table_check for PTE regular entries
	  prior to freeing.
	  repro.c: https://gist.github.com/soleen/fdcd501d5df103976245fe84e9535087
	  config: https://gist.github.com/soleen/8a56f923c2fea9ce9c75b4e2517d4162
	  qemu_script: https://gist.github.com/soleen/f4be4795826b7ab1a51ae659582e179c
	  base image:
	  https://storage.googleapis.com/syzkaller/wheezy.img
	  https://storage.googleapis.com/syzkaller/wheezy.img.key

Small cleanup:
  mm/page_table_check: use unsigned long for page counters and cleanup

Previous versions:
v1: https://lore.kernel.org/all/20220120042513.1648831-1-pasha.tatashin@soleen.com
v2: https://lore.kernel.org/all/20220120191250.2671557-1-pasha.tatashin@soleen.com
v3: https://lore.kernel.org/all/20220126060514.1574935-1-pasha.tatashin@soleen.com

Pasha Tatashin (4):
  mm/debug_vm_pgtable: remove pte entry from the page table
  mm/page_table_check: use unsigned long for page counters and cleanup
  mm/khugepaged: unify collapse pmd clear, flush and free
  mm/page_table_check: check entries at pmd levels

 include/linux/page_table_check.h | 18 ++++++++++
 mm/debug_vm_pgtable.c            |  2 ++
 mm/khugepaged.c                  | 37 ++++++++++++---------
 mm/page_table_check.c            | 56 ++++++++++++++++----------------
 4 files changed, 69 insertions(+), 44 deletions(-)

-- 
2.35.0.rc0.227.g00780c9af4-goog

