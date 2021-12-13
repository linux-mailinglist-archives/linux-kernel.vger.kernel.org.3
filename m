Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A53BB471FEE
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Dec 2021 05:22:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231669AbhLMEWF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Dec 2021 23:22:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231658AbhLMEWE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Dec 2021 23:22:04 -0500
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F933C06173F
        for <linux-kernel@vger.kernel.org>; Sun, 12 Dec 2021 20:22:04 -0800 (PST)
Received: by mail-pg1-x535.google.com with SMTP id m15so13429467pgu.11
        for <linux-kernel@vger.kernel.org>; Sun, 12 Dec 2021 20:22:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jQQJUL+2/wug1CwSeW0/HvyMjIHjOfrSGngioVBJozA=;
        b=KRXd6qzl75tOMNpUTUgirP5+yGEihU+B6hI7ZWdBDEckPEcOgWB0jF/28UNzrIkv1u
         0AQ0VdNFpB/446ELEMrCy75gxD48r7z3MclQKDwKkCf+3jAJUmQECXsf3wfL8avUaQ46
         qVg6IQuNHy9FU7Tj7XGikZd/XZPKE7R2uFH2yvD76EHnxoyQaBvAsJhq/2CFIjj/Qdlj
         tOgX7XvmtU9SFQjwUvRXkrK466D8rRGHzNfqItgvqirZlntp9a+YuitCjp9t2NDh8xIL
         3rIbXU/SLwIyydpXAnbKAErWIEfsRKomLTz5YFEARWSEi5inNFTjtznUy46MEeUeGYgA
         /knw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jQQJUL+2/wug1CwSeW0/HvyMjIHjOfrSGngioVBJozA=;
        b=uATeop4EkrG826l6iLnQmyVX/uIjjzMCAXe3bHP3bawF1gP6Hz36VwnrLkQ1Oeyzy6
         4ajaYrw1BFoyY76PJ/oo3QWW8bDjEoolQYSm0l7UNwwwCXdYdVZB74iCrGkQ+XoC/De3
         EwOnkGdospaLKkmJF3A350RwL23RGRv17q0S6bMS88+Y2h/FLNwiyObPtXtbEcFXgF0C
         HGDwHO/jc//2D5FkmJqHQJPrWyQ20O8103eYErVBzFOj+t6mP2m4gN6cnL4aCIUNNxSo
         5kVwVQ0OgH6iWndaf//670h5Bg+bjZQ4k+TqyePwsZL7zPrpGHQhFs1B+bJHd5tsQ7lb
         F9QA==
X-Gm-Message-State: AOAM532a1VXxEigFq0CfhTRWSMx6oH7c1uUJotnyg7guIT4CVcYYG+wy
        OT+xXD4/PGzk6Ps/zLVwlv1e5LtT5klRnA==
X-Google-Smtp-Source: ABdhPJx/dNjj8H+2ha/fG2tLMi4m2YNAWMeKpcrWMRsOKdU+Z0tkKdHBpy2PRModnL7RjkoZ13jdew==
X-Received: by 2002:a63:1001:: with SMTP id f1mr50721530pgl.353.1639369323706;
        Sun, 12 Dec 2021 20:22:03 -0800 (PST)
Received: from localhost ([47.88.60.64])
        by smtp.gmail.com with ESMTPSA id m76sm10028149pfd.160.2021.12.12.20.22.01
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 12 Dec 2021 20:22:03 -0800 (PST)
From:   Lai Jiangshan <jiangshanlai@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     x86@kernel.org, Lai Jiangshan <laijs@linux.alibaba.com>
Subject: [PATCH 0/3] x86/entry: Fix 3 suspicious bugs
Date:   Mon, 13 Dec 2021 12:22:12 +0800
Message-Id: <20211213042215.3096-1-jiangshanlai@gmail.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lai Jiangshan <laijs@linux.alibaba.com>

The problems described in patch1/patch2 can only happen when the system
owner is really paranoid.

For patch3, I hardly believe #VC can hit in the code range returining
to user without implementing more SEV features.

Lai Jiangshan (3):
  X86/db: Change __this_cpu_read() to this_cpu_read() in
    hw_breakpoint_active()
  x86/hw_breakpoint: Add stack_canary to hw_breakpoints denylist
  x86/sev: The code for returning to user space is also in syscall gap

 arch/x86/entry/entry_64.S        | 2 ++
 arch/x86/entry/entry_64_compat.S | 2 ++
 arch/x86/include/asm/debugreg.h  | 2 +-
 arch/x86/include/asm/proto.h     | 4 ++++
 arch/x86/include/asm/ptrace.h    | 4 ++++
 arch/x86/kernel/hw_breakpoint.c  | 8 ++++++++
 6 files changed, 21 insertions(+), 1 deletion(-)

-- 
2.19.1.6.gb485710b

