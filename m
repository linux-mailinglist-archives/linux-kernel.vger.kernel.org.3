Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4023A53F2E1
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jun 2022 02:09:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235218AbiFGAJL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jun 2022 20:09:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232547AbiFGAJJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jun 2022 20:09:09 -0400
Received: from mail-pf1-x449.google.com (mail-pf1-x449.google.com [IPv6:2607:f8b0:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D58158CB07
        for <linux-kernel@vger.kernel.org>; Mon,  6 Jun 2022 17:09:07 -0700 (PDT)
Received: by mail-pf1-x449.google.com with SMTP id q12-20020a056a0002ac00b0051bb2e66c91so8381802pfs.4
        for <linux-kernel@vger.kernel.org>; Mon, 06 Jun 2022 17:09:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=5njyuqsJfb5ANEto3T4lhSV8l6ei77v301vQGlsYZZs=;
        b=Xarlvgo+aGPSnUVW4AOncnP8EbZ3BDRcAMJ/n5Vh/I2VAK/jbjiHP70PuNcB5+ROEq
         L5E1vlBRIZKAd/n389NC8wA25BLPCjYTKd8SQ9AmXkzshhNsaYdYIQeb2YoVwbviJijj
         DHtroToE9o7QMHbETr6NQ/PqJBn/pA3glQhTKRmS5cHTWQ/epMRkS42JuM/iOd0kEu5E
         nVfq/0CEs+H9LqMuL9j203jGJlksrY6JXLcL1dkDXkI9Jg9GUQFJGLwTh491SGdDr0mA
         7aLezO8L8vN2MTOXmmYx9ATd3CwK1Nwct7CwcLAaMmxPQ/uSHhVRj7SEm01O3BRzbbSe
         fEuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=5njyuqsJfb5ANEto3T4lhSV8l6ei77v301vQGlsYZZs=;
        b=BXDb9YgEsHHAts1O4MftklwSj0dqb6hBnRdYxzrMfQIoSsFBijav2Q+IO66rzG9NiS
         dBGb3RlPGpyFbik13devvykkLCYqfnKIQuoJuoYDTZZgxZKaX5NtCLGNTOXa2Tqs5OKH
         i/+2UVXtdnzeuakFfEHWrQESO9q5zDhPZq2Tst/tu5TOjAIOopS8mIEPIQVK0FZ/DcDJ
         +ddm8uZuKExQPP6KYq6XmXPRjoRuMGik5Z4iwRj9oOxVDdLT0KPonVsa1PBirfKLD5ET
         +mRo6yHiuXfo1CwWqve0HQXYRUOE6KHzowyKO7LD6KygTdKZLTzgLoQ1EKr0LH6ToYdP
         m9GQ==
X-Gm-Message-State: AOAM530WM1Ihpk3eelJeYVoE5H89kVtx2dkmzZL5rwLW+myXp/OLeHtW
        QTAjUNbyVeuSGUDQin9NezdCDwvrl56g
X-Google-Smtp-Source: ABdhPJysN3Jfvc2kr6L+a1zuctuQEbH8RmFdNFd8u4ZR9Tc4WGWrW/1ALQMRqSCJyjJYXehXqmpBCH6RijA0
X-Received: from irogers.svl.corp.google.com ([2620:15c:2cd:202:e763:4219:a098:af4b])
 (user=irogers job=sendgmr) by 2002:a05:6a00:cd2:b0:51c:28b5:1573 with SMTP id
 b18-20020a056a000cd200b0051c28b51573mr5173255pfv.59.1654560547157; Mon, 06
 Jun 2022 17:09:07 -0700 (PDT)
Date:   Mon,  6 Jun 2022 17:08:51 -0700
Message-Id: <20220607000851.39798-1-irogers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.36.1.255.ge46751e96f-goog
Subject: [PATCH] perf unwind: Fix uninitialized variable
From:   Ian Rogers <irogers@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Sedat Dilek <sedat.dilek@gmail.com>
Cc:     Ian Rogers <irogers@google.com>, llvm@lists.linux.dev,
        Fangrui Song <maskray@google.com>,
        Sebastian Ullrich <sebasti@nullri.ch>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ret may be uninitialized on error goto paths.

Reported-by: Sedat Dilek <sedat.dilek@gmail.com>
Fixes: dc2cf4ca866f ("perf unwind: Fix segbase for ld.lld linked objects")
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/unwind-libunwind-local.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/util/unwind-libunwind-local.c b/tools/perf/util/unwind-libunwind-local.c
index 37622699c91a..6e5b8cce47bf 100644
--- a/tools/perf/util/unwind-libunwind-local.c
+++ b/tools/perf/util/unwind-libunwind-local.c
@@ -174,7 +174,7 @@ static int elf_section_address_and_offset(int fd, const char *name, u64 *address
 	Elf *elf;
 	GElf_Ehdr ehdr;
 	GElf_Shdr shdr;
-	int ret;
+	int ret = -1;
 
 	elf = elf_begin(fd, PERF_ELF_C_READ_MMAP, NULL);
 	if (elf == NULL)
-- 
2.36.1.255.ge46751e96f-goog

