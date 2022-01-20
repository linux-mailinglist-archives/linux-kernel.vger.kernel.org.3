Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3EC374954A5
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jan 2022 20:12:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346931AbiATTMz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jan 2022 14:12:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236860AbiATTMy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jan 2022 14:12:54 -0500
Received: from mail-qv1-xf2f.google.com (mail-qv1-xf2f.google.com [IPv6:2607:f8b0:4864:20::f2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35946C061574
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jan 2022 11:12:54 -0800 (PST)
Received: by mail-qv1-xf2f.google.com with SMTP id a8so7853348qvx.2
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jan 2022 11:12:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+EgbhL0QXzaRI6Frm3YKj5DjZTpZr/+/A1d1JYV5hSw=;
        b=a0sQBqXi0PYnQvnn82gkCKA+KHt5mTJoxw1QADjCAKf8cw8DPdAtlaECBfUTMprFgj
         M3ks0TWjQMWwRnCAXebtTidM4B2n3YdKmsO5SJ30Y/LJlJFugOMrQlMF/mbXWgdkMl76
         7mTMevDufyLk9RacPwTqwaGApWAKy+EfkcN3oZK2n1bBK7jTFAHLExEl04bHG83V2d9l
         ts8ghoCsraNRHLZqQXGJjOIb1oRm40wUH1TOb/8Iv6xhkD0pAZdMxbe0N/lMEkTXE8QV
         yqvJDerwINQooXXvYXrIee7AdbguRKztsazSp/e6JSHahq/XkFVqBwcYFxAQADZ16ZWD
         c2dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+EgbhL0QXzaRI6Frm3YKj5DjZTpZr/+/A1d1JYV5hSw=;
        b=gmAeGRDfB37j869agqq1i/O5v5u+dzTJPkrupD5M6BPwaDak95xflzLJbdVHIyfFgB
         0JRz+DKrhKogU0pWWalJ7w3FHSJ/jJy3XfOcYoL3ZlUqlkjFR8OEEmE4uRDJodUjX7Z2
         oF/RaU5CQdg+5G9rTjyzfrNRb/xsEdUEsKS9iIj5R8EgttmWF4JJJj/3VdgEes0OfzN6
         JSoqNlkWZG4WCsWsfFF4oWWoxkpEtfuyDMIX/eUEiDGbgnXdXPv3nm+OSodW34D5MH2m
         Yv6RhViInRfR7BHlG56uBk3sGX1eG48UhtTu+/CsqEbWvxz+ZoDQykii1A+vC7d0+Nzi
         dE7g==
X-Gm-Message-State: AOAM530kVZ3KtQomDz63ELQH8wQBXPKPTV39HvG5Y1eUw6vmZPlZXzc+
        hA5xxzlKXgE7JZueQv2M+goJgg==
X-Google-Smtp-Source: ABdhPJzKNL2JCPvVpU8F6hQzHFLiBnU6109SpSxlKY6rVHFrZHOAluHVa5i7rI/WCMuh4xR0q45NsQ==
X-Received: by 2002:a05:6214:5092:: with SMTP id kk18mr392965qvb.43.1642705973170;
        Thu, 20 Jan 2022 11:12:53 -0800 (PST)
Received: from soleen.c.googlers.com.com (189.216.85.34.bc.googleusercontent.com. [34.85.216.189])
        by smtp.gmail.com with ESMTPSA id w1sm1822509qko.40.2022.01.20.11.12.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jan 2022 11:12:52 -0800 (PST)
From:   Pasha Tatashin <pasha.tatashin@soleen.com>
To:     pasha.tatashin@soleen.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, akpm@linux-foundation.org, rientjes@google.com,
        pjt@google.com, weixugc@google.com, gthelen@google.com,
        mingo@redhat.com, will@kernel.org, rppt@kernel.org,
        dave.hansen@linux.intel.com, hpa@zytor.com,
        aneesh.kumar@linux.ibm.com, jirislaby@kernel.org,
        songmuchun@bytedance.com, qydwhotmail@gmail.com, hughd@google.com,
        ziy@nvidia.com, anshuman.khandual@arm.com
Subject: [PATCH v2 0/3] page table check fixes and cleanups
Date:   Thu, 20 Jan 2022 19:12:47 +0000
Message-Id: <20220120191250.2671557-1-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.34.1.703.g22d0c6ccf7-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changelog:
v2:	- Addressed simplification comments from Wei Xu
	- Added Review-by/Tested-by's from Zi Yan and Wei Xu


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

Previous versions:
v1: https://lore.kernel.org/all/20220120042513.1648831-1-pasha.tatashin@soleen.com

Pasha Tatashin (3):
  mm/debug_vm_pgtable: remove pte entry from the page table
  mm/page_table_check: check entries at pud and pmd levels
  mm/page_table_check: use unsigned long for page counters

 mm/debug_vm_pgtable.c |  2 ++
 mm/page_table_check.c | 68 +++++++++++++++++++++++++------------------
 2 files changed, 42 insertions(+), 28 deletions(-)

-- 
2.34.1.703.g22d0c6ccf7-goog

