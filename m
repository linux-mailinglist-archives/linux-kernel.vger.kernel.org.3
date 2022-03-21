Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02BC34E2B78
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Mar 2022 16:07:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349805AbiCUPIY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Mar 2022 11:08:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238929AbiCUPIX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 11:08:23 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22D1989CC1
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 08:06:58 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id v4so13281627pjh.2
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 08:06:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=cUWzEMBGSWQIxeTbgVTExlAUidpN0hciDnY2SRNTO88=;
        b=nAGq6Llv/ELAFj7H2w6B7X5DpYP8ss13RxhDZkZzdHQBCoVd6p6Y+FvuaCClUWgGpV
         /Q38BmXzh8bhAnJ3sbSRBM8QWlZMMVJtg6PjQrnK/3CunuwfUcgiLTZsgaKBh2WcWxpc
         nzXspgZcrIrpYIjy1PMEoOoKyQd6Q10HRR7tc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=cUWzEMBGSWQIxeTbgVTExlAUidpN0hciDnY2SRNTO88=;
        b=PFeuhRIt78g9sNOpAl40r52eHw5fSsXsJsrQ8Bbilhe3KtL87MNyj9pSxEZaoYXHzq
         +lrtCo0Up3kyO+E/GdEKGScYm3KGCO4CDcUHJgiY4P8piTWVxyzZy2aj+kVFW80pZpx5
         COd0s7rq1aRGgYAiNs5IIRukmH1GF3UKMvVANvFkTY6riDROFXw2ON3ySAKfqa/benu5
         zNhtt6hQfOuQ1OssRm5M/Ed8AESvDeId1dcg8BzSs0e7dLbJHtKfJGuaCgfaSRWOQmc2
         UIzlt0Oz2MxDuQ5BGvS89A1uoDpqS5qu5myK42v7jIy0SIUudKnCAkcDz4Dvs87Myj0f
         6cCQ==
X-Gm-Message-State: AOAM530DN8YyI7m0AKbAEiEbnMYf0egojDHAPaDne1+XsL0qbMoXJyaI
        OniLWArDnaeBgfsb2boqxUTreQ==
X-Google-Smtp-Source: ABdhPJxY1u68K7MleJKqbizLH3P90fX2j+ugb5+jPgtwZ5dFnzEr7pWUXriJJ5beLbdFdSVhJDLGVA==
X-Received: by 2002:a17:902:dccc:b0:153:a902:e542 with SMTP id t12-20020a170902dccc00b00153a902e542mr13657289pll.16.1647875217525;
        Mon, 21 Mar 2022 08:06:57 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id i7-20020a17090a65c700b001b936b8abe0sm20500425pjs.7.2022.03.21.08.06.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Mar 2022 08:06:57 -0700 (PDT)
Date:   Mon, 21 Mar 2022 08:06:56 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, Kees Cook <keescook@chromium.org>
Subject: [GIT PULL] seccomp update for v5.18-rc1
Message-ID: <202203210806.78B1156916@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull this tiny seccomp update for v5.18-rc1.

Thanks!

-Kees

The following changes since commit eed09ad261822a7bdc441ed192c6f444375e5527:

  samples/seccomp: Adjust sample to also provide kill option (2022-02-10 19:09:12 -0800)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git tags/seccomp-v5.18-rc1

for you to fetch changes up to b5caa8dd9cc8ad5126f06e9266c326d38a1fc6d2:

  samples/seccomp: Improve arch hints (2022-02-13 10:16:25 -0800)

----------------------------------------------------------------
seccomp update for v5.18-rc1

- Improve architecture hints in sample (Kees Cook)

----------------------------------------------------------------
Kees Cook (1):
      samples/seccomp: Improve arch hints

 samples/seccomp/dropper.c | 84 ++++++++++++++++++++++++++++++++++++++++-------
 1 file changed, 73 insertions(+), 11 deletions(-)

-- 
Kees Cook
