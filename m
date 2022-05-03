Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF9A051901E
	for <lists+linux-kernel@lfdr.de>; Tue,  3 May 2022 23:36:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242938AbiECVht (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 May 2022 17:37:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbiECVhq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 May 2022 17:37:46 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64AA3329AC
        for <linux-kernel@vger.kernel.org>; Tue,  3 May 2022 14:34:09 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id z5-20020a17090a468500b001d2bc2743c4so3118156pjf.0
        for <linux-kernel@vger.kernel.org>; Tue, 03 May 2022 14:34:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=yWvoulYYPDYzhzuwmw8fpxaZErlTCWK5buejUsnQBTE=;
        b=Jx4v36StIqgSJms0f7kENWyb1L+GtVG4yXLsmdOMNXNaXYB0iQp8j3Cb6xLOZ+vMUN
         B0yVZYuGK3RRAZfjzco5ho4ZGJ83bUt4gUGyaOeUcmvXPKAmyQi3aWEpQvncd8MCHxem
         3NY1HcC9iTU7MM9MIU9muivCH0QOoM9/DPlLE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=yWvoulYYPDYzhzuwmw8fpxaZErlTCWK5buejUsnQBTE=;
        b=ab8Tmr+Ir1JINxDWzsrxEpiAPWkAjYafwgleAcjTTgNiAG3xFwVBF41UIsf+4ck4Uw
         CKZ4EazBAAa1rcRhLcGC8TwRVo97pjlj+sR1WZ9FT7WKSJ4f0deENGRWJVtMpqI/FYIJ
         k5Kw6Wh17n3hQlEMcy5GpcLY2T+s0xmy4oo66O1X2a9jybspB3RLB8VY/4A1g9JvVj2x
         ilyjZfEDFPhcbMU3ASizIKSQNx7+4KHThGMpe4RGFXlWhhpsVhvFZtgsilSaWFObgTS7
         c+/D1GQk1LqobolF+d2XaaI1OFuE1Mfqa+Q7tksvNYzqhOgMM3nSeSuErn7jozCmP5Nq
         o19A==
X-Gm-Message-State: AOAM531bCTHhJGsgW9AI3EqiKoNqhh4yIJZwPzgDNIkTBy4HNE/f4ZK5
        Gmt37aW5Xr5gEM8ltZdYCXV5hA==
X-Google-Smtp-Source: ABdhPJxplZiK0r84aZXH329NdkIsa6Ae1LO/Vr+2W5jE9b8kJmHMBoLqcdq8o89Fkl+wSO77qaSVyg==
X-Received: by 2002:a17:902:9a42:b0:158:bf91:ecec with SMTP id x2-20020a1709029a4200b00158bf91ececmr18723229plv.115.1651613648934;
        Tue, 03 May 2022 14:34:08 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id d25-20020aa78699000000b0050dc7628140sm6729198pfo.26.2022.05.03.14.34.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 May 2022 14:34:08 -0700 (PDT)
Date:   Tue, 3 May 2022 14:34:07 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, Jann Horn <jannh@google.com>,
        Kees Cook <keescook@chromium.org>
Subject: [GIT PULL] seccomp fix for v5.18-rc6
Message-ID: <202205031433.6CB037ED@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull this small seccomp selftest fix for v5.18-rc6. The selftest
environment assumptions that seccomp depended on changed slightly in
v5.17 and Jann found a simple fix.

Thanks!

-Kees

The following changes since commit ce522ba9ef7e2d9fb22a39eb3371c0c64e2a433e:

  Linux 5.18-rc2 (2022-04-10 14:21:36 -1000)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git tags/seccomp-v5.18-rc6

for you to fetch changes up to 2bfed7d2ffa5d86c462d3e2067f2832eaf8c04c7:

  selftests/seccomp: Don't call read() on TTY from background pgrp (2022-04-29 11:28:41 -0700)

----------------------------------------------------------------
seccomp fix for v5.18-rc6

- Avoid using stdin for read syscall testing (Jann Horn)

----------------------------------------------------------------
Jann Horn (1):
      selftests/seccomp: Don't call read() on TTY from background pgrp

 tools/testing/selftests/seccomp/seccomp_bpf.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

-- 
Kees Cook
