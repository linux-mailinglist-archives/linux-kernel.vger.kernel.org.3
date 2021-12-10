Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 86802470C32
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Dec 2021 22:03:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344474AbhLJVHC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Dec 2021 16:07:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344318AbhLJVGr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Dec 2021 16:06:47 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5D22C061A32
        for <linux-kernel@vger.kernel.org>; Fri, 10 Dec 2021 13:03:11 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id y17-20020a2586d1000000b005f6596e8760so18448539ybm.17
        for <linux-kernel@vger.kernel.org>; Fri, 10 Dec 2021 13:03:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=Dnig+jFvfQxWe8PEUFRnomEBEtDGU70e5+ZRqNNPE5M=;
        b=Jv0XPHWOmWo5RJHHMlwBNT4cv8XIWmPxP+ZMwgZgzWxujsm2jfSsb0H1r9V7s9VlrH
         9UquznFem06w07rt3Tn/woHktcdXTOYyeHc18tZEBGkbv1rhkog+JCMoDYz2oPGKEQWt
         sGLFlCBQbyOVXQeZDuM9vLwHizcvlvhC5voC0TaYoGNRXeM9mX4+uzaYq9QRxUv/Gq79
         Wwx+UwP8lHIYPPqRIDCD72QcXv0Z9pwy87+fA7pRUTll48+ToHGjB4GkagbdkNSfFXmV
         ucwIkz6bxv852eLmRHK1/NOQu/lsGR7pImzZZ5w4VVaA6HyRILisIIWjnBX1K7SSEC/S
         IBwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=Dnig+jFvfQxWe8PEUFRnomEBEtDGU70e5+ZRqNNPE5M=;
        b=UI5t5l07c3p905KB+oXSfr+DWStUOULu1zfsQwAt6PErG65JKxXEGHZGhLn23EEPeh
         rtZy+xXDktiFJTEw7DVKourWxK54kNApNJC1wAIKP5P9VV5Wc7M/di2DbtvuV40aOc+8
         YsoPIKThP4O0+EJdR8N/Ns4nfynWCGq3YMR5VBhUSU2NQlCcyYECv2uiAWnO/QusdE8q
         tVJ7Ygu3bIHKpd/3zLrXpkD49O5YYFBRoNkzCzNMD3xGoRdXra/Gq9bsyn/ULijc9mOj
         p510mMWBt7s3n5jtc1+shpEdfkk/ViHODesC2igNXi/lkDjm7r/AaJQXlbskgJj31aBi
         T/DA==
X-Gm-Message-State: AOAM532IVKZIZjRvzf/uywX3IwNLf0cD+sH/NwZR+UeQAGhVELA7wejW
        fAgvt0cej7q/vG2AUIOXAKqKvKJxOtX9RkN2zUMKLJ7UaW0kCdmrY2GoWdll/7b9nombfLUPvUX
        sXnXJRNnyVp01i01fzCjTZCFbeiMpSaerHCojifWOIr/JOLBnk2ha/9iaxNDKXoXms5UavWii
X-Google-Smtp-Source: ABdhPJydVMCEUedXsUMAWL6BFb7HW3msllm/IneLlVFFvHhzhdCYKkPz0xmnI1jnllrH47sSbuof38mzxTt1
X-Received: from uluru3.svl.corp.google.com ([2620:15c:2cd:202:7416:17a6:6678:d4d5])
 (user=eranian job=sendgmr) by 2002:a25:db8b:: with SMTP id
 g133mr17698341ybf.697.1639170190933; Fri, 10 Dec 2021 13:03:10 -0800 (PST)
Date:   Fri, 10 Dec 2021 13:02:25 -0800
In-Reply-To: <20211210210229.2991238-1-eranian@google.com>
Message-Id: <20211210210229.2991238-11-eranian@google.com>
Mime-Version: 1.0
References: <20211210210229.2991238-1-eranian@google.com>
X-Mailer: git-send-email 2.34.1.173.g76aa8bc2d0-goog
Subject: [PATCH v4 10/14] perf tools: add branch-brs as a new event
From:   Stephane Eranian <eranian@google.com>
To:     linux-kernel@vger.kernel.org
Cc:     peterz@infradead.org, kim.phillips@amd.com, acme@redhat.com,
        jolsa@redhat.com, songliubraving@fb.com, mpe@ellerman.id.au,
        maddy@linux.ibm.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Although branch-brs is specific to AMD Zen3, we provide it in the list of
events recognized by perf as a convenience. It allows: $ perf stat -e
branch-brs $ perf list

and enable some test suite to pass.

Signed-off-by: Stephane Eranian <eranian@google.com>
---
 tools/perf/util/parse-events.l | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/perf/util/parse-events.l b/tools/perf/util/parse-events.l
index 4efe9872c667..97e70368e7c7 100644
--- a/tools/perf/util/parse-events.l
+++ b/tools/perf/util/parse-events.l
@@ -366,6 +366,7 @@ mem-loads-aux				|
 mem-stores				|
 topdown-[a-z-]+				|
 tx-capacity-[a-z-]+			|
+branch-brs				|
 el-capacity-[a-z-]+			{ return str(yyscanner, PE_KERNEL_PMU_EVENT); }
 
 L1-dcache|l1-d|l1d|L1-data		|
-- 
2.34.1.173.g76aa8bc2d0-goog

