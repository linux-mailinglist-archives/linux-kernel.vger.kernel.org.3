Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C726586F99
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Aug 2022 19:34:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232681AbiHARe2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Aug 2022 13:34:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230387AbiHARe0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Aug 2022 13:34:26 -0400
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B605655D
        for <linux-kernel@vger.kernel.org>; Mon,  1 Aug 2022 10:34:25 -0700 (PDT)
Received: by mail-pg1-x532.google.com with SMTP id 206so6788211pgb.0
        for <linux-kernel@vger.kernel.org>; Mon, 01 Aug 2022 10:34:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=iG1tFlsYX7x+sS+wOqXkgTBitFnM+4O9QVj7OfY98rU=;
        b=AujzntJakyHexjnmF/VbxTVSJFb0sJ4Vx0oWFB006B82OjGa5g+YXADCDbUSVMZ03I
         y3P5XW2InEOaI7BxPx2WWRR1f264zPvYiuDyBZuBasv5m7SMWoc1DCOLtXiWOeWKTjyf
         CwlJZiOPjfOSgJavIVLje9jbkSf2Poo8mFn2I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=iG1tFlsYX7x+sS+wOqXkgTBitFnM+4O9QVj7OfY98rU=;
        b=NPntCIpSLS2UfHQzck2J7Z+rdM9SGi3L3Fwe88cLLfGjrGpiUjkDGrK7ZqxB/dl/Va
         RfceHeNVWph2HOFMO81jo+KxJcBXJHm4FE2Z85FRasRlzT/ieJolHd4JRdrgvEKzCJug
         Mis27VMqgL73ZOVxhwL+vLAEc6VtwXEpcCXskPzHr+yBY1WfM/gHDYu6lo/T5XLuZZoz
         xkRSqg1ZIzgzVRFrLIf/eec1LyyK1orIPpwys9bJ2T2bJluoGLF/2K3EpYHpwh+78MKN
         uOov3QPVPVPxyMm9ULesRM0ngh9rFN9FdoduZvic/LA/odyjcpbsLePDoTXZeIY5tKZ0
         lSeA==
X-Gm-Message-State: AJIora9OHDY/2gSQSYjWjd/RfbkDi6S0vnI2H0TDoyyZ8dfMU3tEP6vR
        VFWiB05pI0orSCMgOYQKogfYJQ==
X-Google-Smtp-Source: AGRyM1tjAojuzDmcJt32ZzjbaJaE1UY2jhxIjdusCgWtn0YCp27SY9SXpQXFv8gZaKEhZucmZBSTVQ==
X-Received: by 2002:a63:97:0:b0:41a:3c2:6238 with SMTP id 145-20020a630097000000b0041a03c26238mr14084203pga.499.1659375265142;
        Mon, 01 Aug 2022 10:34:25 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id k12-20020a170902ce0c00b0016bf9437766sm9855117plg.261.2022.08.01.10.34.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Aug 2022 10:34:20 -0700 (PDT)
Date:   Mon, 1 Aug 2022 10:34:16 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, Kees Cook <keescook@chromium.org>,
        YiFei Zhu <zhuyifei@google.com>
Subject: [GIT PULL] seccomp update for v5.20-rc1
Message-ID: <202208011033.344AB17@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull this tiny seccomp update for v5.20-rc1.

Thanks!

-Kees

The following changes since commit a111daf0c53ae91e71fd2bfe7497862d14132e3e:

  Linux 5.19-rc3 (2022-06-19 15:06:47 -0500)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git tags/seccomp-v5.20-rc1

for you to fetch changes up to 3ce4b78f73e8e00fb86bad67ee7f6fe12019707e:

  selftests/seccomp: Fix compile warning when CC=clang (2022-07-27 12:12:16 -0700)

----------------------------------------------------------------
seccomp update for v5.20-rc1

- Fix Clang build warning (YiFei Zhu)

----------------------------------------------------------------
YiFei Zhu (1):
      selftests/seccomp: Fix compile warning when CC=clang

 tools/testing/selftests/seccomp/seccomp_bpf.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

-- 
Kees Cook
