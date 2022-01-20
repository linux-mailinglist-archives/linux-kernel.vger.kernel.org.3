Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C86349466A
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jan 2022 05:27:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358463AbiATEZS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jan 2022 23:25:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358455AbiATEZR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jan 2022 23:25:17 -0500
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com [IPv6:2607:f8b0:4864:20::733])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3474FC061574
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jan 2022 20:25:17 -0800 (PST)
Received: by mail-qk1-x733.google.com with SMTP id d11so5074225qkj.12
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jan 2022 20:25:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=KaPKpkE+NUZcXeTKIXr2Mnojuzo73Hat0EIRCUdPF9k=;
        b=dwohxivkrETs1vxp7Yak9azruSMiVSj+cVNsfPqp4adBisOVxzwCeDN4SfQu9Z67mB
         BBxY6zETfXXKIsv3+UQFKk4lvlVUrxNKzpDqYpqB1N9SmQxBuNIM2LgaX+3z+WGEILZY
         dR88dPBLPEpIkAWCwOw6RRyKo7/BcONTw4Y4F8ixDUQKHAkvYFVcYrfk8URfniBuBkPP
         6TIhF/3WfItwoX5917sRd9EcNkHyKku80Hf7k5Cj6PYgpb4sNToMtCZBY+ID6nTr407k
         0Auzi+JVuFGw8g2CnK3NKpCwDuKDai8G2bdRAKQo/lCiv51g0NDq9Sk4GrSvJlhrQ3yg
         Nd/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=KaPKpkE+NUZcXeTKIXr2Mnojuzo73Hat0EIRCUdPF9k=;
        b=DswC+9mQ4BsFlK/18KjSKAihYQ8XUT1pKT52eXTSYSJ5IpHLWWHtL61R+rwY7XtNQ+
         wiYoZEscWBP4hzTrNR170PgG+Ebnzx8VtjaIo9MRUG1S3VTEgV7hmqdkDasEtB+iVV8i
         b6mojIkQBh8a0c/Z4ZelHKvumUDhyvoL/0jRfs3DLTiaJVQlUhuKV5qht+HiwTM8xzp4
         1H3gcVgNaL38JDOeSdUrjaJ7z6rwqApc+xnfJHNUEdLFXKNk86yYyJeLtcfFgRXpoetL
         uF4ScfdyeKzFKMr793E7iLLsKv2QRxJ4u5ECTsZ5YMr4N6bYPid9cBRCw0LfVIDe5ysg
         g8QA==
X-Gm-Message-State: AOAM532SrB4wk/wdOrpdlCdJL0zi+O0Gm5J7tXL4SQ1nJED+DVc6GKy1
        obClTHCoUQiNMMWnGUdWGeO45w==
X-Google-Smtp-Source: ABdhPJxhxy/bAom7rYxKqHlW4qlVEweOMLw73JqhmfVuLg2rSFS+24sE98FKjGXZ1I6/8DbmWREL8A==
X-Received: by 2002:a05:620a:1a99:: with SMTP id bl25mr19970281qkb.529.1642652716239;
        Wed, 19 Jan 2022 20:25:16 -0800 (PST)
Received: from soleen.c.googlers.com.com (189.216.85.34.bc.googleusercontent.com. [34.85.216.189])
        by smtp.gmail.com with ESMTPSA id n22sm927228qka.46.2022.01.19.20.25.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Jan 2022 20:25:15 -0800 (PST)
From:   Pasha Tatashin <pasha.tatashin@soleen.com>
To:     pasha.tatashin@soleen.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, akpm@linux-foundation.org, rientjes@google.com,
        pjt@google.com, weixugc@google.com, gthelen@google.com,
        mingo@redhat.com, will@kernel.org, rppt@kernel.org,
        dave.hansen@linux.intel.com, hpa@zytor.com,
        aneesh.kumar@linux.ibm.com, jirislaby@kernel.org,
        songmuchun@bytedance.com, qydwhotmail@gmail.com, hughd@google.com,
        ziy@nvidia.com, anshuman.khandual@arm.com
Subject: [PATCH 0/3] page table check fixes and cleanups
Date:   Thu, 20 Jan 2022 04:25:10 +0000
Message-Id: <20220120042513.1648831-1-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.34.1.703.g22d0c6ccf7-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Two fixes:

  mm/debug_vm_pgtable: remove pte entry from the page table
	- remove a pte entry from the page table at the end of debug_vm_pgtable pte test

  mm/page_table_check: check entries at pud and pmd levels
	- check pmd and pud levels in page_table_check for regular entries not only for
	  huge pages when entries are replaced or cleared.
	  repro.c: https://gist.github.com/soleen/fdcd501d5df103976245fe84e9535087
	  config: https://gist.github.com/soleen/8a56f923c2fea9ce9c75b4e2517d4162
	  qemu_script: https://gist.github.com/soleen/f4be4795826b7ab1a51ae659582e179c
	  base image:
	  https://storage.googleapis.com/syzkaller/wheezy.img
	  https://storage.googleapis.com/syzkaller/wheezy.img.key

Small cleanup:
  mm/page_table_check: use unsigned long for page counters

Pasha Tatashin (3):
  mm/debug_vm_pgtable: remove pte entry from the page table
  mm/page_table_check: check entries at pud and pmd levels
  mm/page_table_check: use unsigned long for page counters

 mm/debug_vm_pgtable.c |  1 +
 mm/page_table_check.c | 60 ++++++++++++++++++++++++++++++++++++++++---
 2 files changed, 57 insertions(+), 4 deletions(-)

-- 
2.34.1.703.g22d0c6ccf7-goog

