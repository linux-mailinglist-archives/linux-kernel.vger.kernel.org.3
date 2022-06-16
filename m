Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6839E54EA72
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jun 2022 21:58:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237406AbiFPT6N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jun 2022 15:58:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378250AbiFPT6J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jun 2022 15:58:09 -0400
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A6082982F
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jun 2022 12:58:04 -0700 (PDT)
Received: by mail-pj1-x104a.google.com with SMTP id l22-20020a17090a3f1600b001eaf9daa316so815061pjc.9
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jun 2022 12:58:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=ldQA7TEIhVlvvX0NA61TMlZwIk8p9zKRCpZ/akdEOg0=;
        b=SBeTInydNOQQSIIgk1UxdwVTQtS3JSVzhuVNVlrgcagFpZOPybBo34Ku5h1qMTiB2j
         yLrYCTaTVCE0Ehr69817fN2BPpvLK7YbwyCh5nhsWG840re0GlSaPKs+ehWPSDyCxj9I
         UrTfkkDECUOu/Yqo+yJU3C86mczmDpVax0KqMA7vYxuqSdsWEunc25DriW+PtKEWE1NR
         w3q49LFANdzUz9+7UyKl3TRAajeWnRVZBjAV/7djMAN/5fWwG/yFWrNvGGcWix7mqLuK
         7aWYAjiKpbsyVlfSgl2c6wz7WsLkrns+jcvVw4aSzn4fhWYkPmkFLlAW8RSLVUNQ+eVc
         Jegw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=ldQA7TEIhVlvvX0NA61TMlZwIk8p9zKRCpZ/akdEOg0=;
        b=DFu3hBOS87R6RKeXhC8lASli4pYSVfO7rOPhfMgH4ipIfIr3n7sFTQxmoB3BSBRVT8
         G1kKAKPVwniKr3vtZCoLQNEN0HZNznPUwSMk3mXK99KsYOKFt/TvnmnPJIeBgdQsr1FV
         6UBhw2a4K5aQA7Lu6ZR4SICBxfW8n6ce4xfeZCF3f3y2fDQfHoH+itDX/kQKI7th/1iV
         L+tWNe42y/JMbBzzQsQMcJz25B4VJaBrKPYdvM6ZssdFZ749y+VbOMPV43b+QFbruoOX
         IF8BlNW84mL1KTy2xyGH04Jm3Lz1lVerKu81OntgjP3U+p9FO4rpFJQdLpYjlbWhiyf0
         CrAQ==
X-Gm-Message-State: AJIora+c3Ms2go/TtknOKqEUXvH447X+LIUrX4gFwq69ANVyFJztA7BG
        E5cDZp7XQTSQtzCIvJAO3Bn282x9HXF0DlYYOjM=
X-Google-Smtp-Source: AGRyM1veGI4lauYAj+Jx+KdPs9qNmtQBNqTmD2jU3DLVNe6adv7B8kGGWq6eSm1+9suo0J0EgRfBE0SI0CWHhai2OBg=
X-Received: from samitolvanen.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:4f92])
 (user=samitolvanen job=sendgmr) by 2002:a17:902:aa96:b0:168:c298:bdf3 with
 SMTP id d22-20020a170902aa9600b00168c298bdf3mr6054843plr.100.1655409483545;
 Thu, 16 Jun 2022 12:58:03 -0700 (PDT)
Date:   Thu, 16 Jun 2022 19:57:59 +0000
Message-Id: <20220616195759.3214538-1-samitolvanen@google.com>
Mime-Version: 1.0
X-Developer-Key: i=samitolvanen@google.com; a=openpgp; fpr=35CCFB63B283D6D3AEB783944CB5F6848BBC56EE
X-Developer-Signature: v=1; a=openpgp-sha256; l=968; h=from:subject;
 bh=M/Cou+QZRQKMB4gLGeT+Xtn7Trwx0hGB9psUmLrjsNk=; b=owEB7QES/pANAwAKAUy19oSLvFbuAcsmYgBiq4tH6ZJW4TbEAX23BMBRV4z4mmz7N4T+HenbeDBu
 YMsr6PSJAbMEAAEKAB0WIQQ1zPtjsoPW0663g5RMtfaEi7xW7gUCYquLRwAKCRBMtfaEi7xW7rgKC/
 4lpQ0qGDMRm/ABDcJQMZqJ3uw7lXDi2emAthJndiAaf9xGk9GrChQzgE79cFEfeQJF5RPv43L4FFgA
 nqPEc8B+odVxFoYYNefK/nesp2lFcXGL/zdR1xUCjfihCkOF1Fx5nKjTd0mz2pWzTF8YENjyEMWOOb
 X4Mhvo2HNIjMC0xG1E4A9nyB9RTJKzf13P59C5T6ywkIf0s7PgGSkEf/pe36rbVVLgQnnxwOKE5XGj
 U5gecLD22zQj6/dZehEmZS3YzjTtZiFRyaxk7QeenadkTB4YJ8UkWwXaqYO+aw4FJZx9V/+Hmrpvl2
 57XF024/ew2WF233vSpMlRNfsZ+52HJkFrPSdTCgO41uoG5FsE8Ue0vqsPext7WCnOGk1POWvqhkFi
 svwtNGQfSFLTz0BcWhfI3183MwvXuAeFoR6BxJZCb5oCi8B4rfOz4q6eX1jirJ3hNs5BTHTZstxhH9
 EiQrHULeVXIa695f8HSBI9zEGGkJRVQ5SjRH6Yr7YLerM=
X-Mailer: git-send-email 2.36.1.476.g0c4daa206d-goog
Subject: [PATCH] kbuild: Ignore __this_module in gen_autoksyms.sh
From:   Sami Tolvanen <samitolvanen@google.com>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     Nicolas Schier <nicolas@fjasle.eu>,
        Alexander Lobakin <alobakin@pm.me>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Steve Muckle <smuckle@google.com>,
        linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        Sami Tolvanen <samitolvanen@google.com>
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

Module object files can contain an undefined reference to __this_module,
which isn't resolved until we link the final .ko. The kernel doesn't
export this symbol, so ignore it in gen_autoksyms.sh. This avoids an
unnecessary vmlinux rebuild with UNUSED_KSYMS_WHITELIST when we have a
symbol list that already contains all the module dependencies.

Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
---
 scripts/gen_autoksyms.sh | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/scripts/gen_autoksyms.sh b/scripts/gen_autoksyms.sh
index faacf7062122..653fadbad302 100755
--- a/scripts/gen_autoksyms.sh
+++ b/scripts/gen_autoksyms.sh
@@ -56,4 +56,7 @@ EOT
 # point addresses.
 sed -e 's/^\.//' |
 sort -u |
+# Ignore __this_module. It's not an exported symbol, and will be resolved
+# when the final .ko's are linked.
+grep -v '^__this_module$' |
 sed -e 's/\(.*\)/#define __KSYM_\1 1/' >> "$output_file"
-- 
2.36.1.476.g0c4daa206d-goog

