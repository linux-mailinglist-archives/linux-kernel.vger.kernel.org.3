Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90E694B5D15
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Feb 2022 22:41:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231420AbiBNVim (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Feb 2022 16:38:42 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:54622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231375AbiBNVif (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 16:38:35 -0500
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F74B16BFAB
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 13:38:26 -0800 (PST)
Received: by mail-pf1-x435.google.com with SMTP id g1so11681529pfv.1
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 13:38:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=nvhw2mfiv5vz0PCotC2YerW2zjqLoGJP2/g8au3hNsU=;
        b=LdBODM3NM3N1GiOpNb4ADxNX+JW7wrSSwfa2J/4h6Jj3vpnIVxT9nhn2XX7X4vjbaF
         MEJFbUosMkvl0k9lkkfo322Co5jxhyYFoNX/VCnJo/jygZBi+kJ9Senvf+nukrpGFbT/
         4H3DTWAL9jlo7NBGm+E/u+3d7f3H8ta0fYT2w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=nvhw2mfiv5vz0PCotC2YerW2zjqLoGJP2/g8au3hNsU=;
        b=BP3E6gh31h4J9FY4o899/duY1IJUqlxoufYdr4WLIfkFeIY1PSMs07oIuZvgev5vBv
         UDXZ6a/xLFNk6P3Ho9Pfzk20vaHzWPKMSHJxVVTanL6PNShTNZ2o3MOSWtu82cOxoUXz
         lu6K22PWhDJRE7GnS4tmviEgT8gq2jhPBLAopPkrJkLUMBBGjWIjdvBJhzwrtPz3L+BY
         fOwv6G0azzZJKF2z3HfWX0Nee77eOIT9XPk4MDx6k94IyXDyr0iM1+h/TRwvOeB5MMAi
         s2DTdfPPivGmG+aknMS14Xp6njAvyXouLI1xwzGVrkKJT9a+h65WtNU0CuvSj61xQhVd
         Ij0A==
X-Gm-Message-State: AOAM5315zDCAyjjN0gc7tLXcZOl0zN7M5Wc17qshrDkrugqA9ha0yP/m
        cqC48jclqJMFE18BvZDu7M3Skw==
X-Google-Smtp-Source: ABdhPJxFrstnucpwd4+VXOVxZctVsNoLCvi/po5w2kM4Ks5Hhv9SmqpM2gZ9FqLO0ndFYnRLPI+HZg==
X-Received: by 2002:a05:6a00:194e:: with SMTP id s14mr706046pfk.82.1644874705659;
        Mon, 14 Feb 2022 13:38:25 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id g126sm451499pgc.31.2022.02.14.13.38.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Feb 2022 13:38:25 -0800 (PST)
From:   Kees Cook <keescook@chromium.org>
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Kees Cook <keescook@chromium.org>,
        Christian Brauner <brauner@kernel.org>,
        Andy Lutomirski <luto@amacapital.net>,
        =?UTF-8?q?Robert=20=C5=9Awi=C4=99cki?= <robert@swiecki.net>,
        Jann Horn <jannh@google.com>, Oleg Nesterov <oleg@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: [PATCH 0/2] exit: Introduce __WCHILDSIGINFO for waitid
Date:   Mon, 14 Feb 2022 13:38:21 -0800
Message-Id: <20220214213823.3297816-1-keescook@chromium.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=689; h=from:subject; bh=ysptg2kG54PmHPPdsG3BCY4dg0JapIzNFbAp++ZnfKo=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBiCsvNfYT+JnkT5mppyqxgRiYxE+8aeRlwqsDKM9gg SkGO3J2JAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCYgrLzQAKCRCJcvTf3G3AJvPuEA CTVicJCnsllg5+N2h+fxsTBUmOvVjyAlR72ZZ3kFTzCNL1wO/WWCxTVib5GNV7vz1vnN9hFnLI9ii9 YhbIwfQW9FrtJjAbtbr2Y9+PxfkzKfNNCpjXd0jH4Sk2QYSqXRS4VZDyOtvGxVuhGQXE77bY/I83Lo qQnjkfCI8LZmyPQT6OK8G2rCjE8GAXyEzEIy5Hu632u2VBzyO/OXoz3tNxPRY73dI/lIIAwVGXRIw/ LNBtpNvycxCzsrbQtRP/gSuTj/YKTwA5Ls+KwAey7uPUWY29aor3Jv9hu99DDfaNPcdlvp3hSJofZe i9dGOYAFDZthtgqZmeUPKBurLE+kt4ppmgVEyygsOoMrkkMjVlOI5Onppj+T0Q9v0bnyZ3Mal2VFIl ducLqjo37raIwukB6eouHQq6TL1IYTrV4jhSz3eUAI3qq5eCsadKiCBeldjACUeEGTH0BP6agxX/M6 6u6JrIEBwLPTTR1RIb3caOxBtqw/cEyAk3G+55/aecKlzcAm86WBIAd6P/vR33uvdjS3gqYEfDrc91 C1qat4lPUY+IPxHNc1trg2vamwGrzdRxuQb4L3/wIcLJ93jmWru/2sZ6+enMuw+2ROHtX8qp5l9miD zFtEl2/q535MUxORWa0hiW1w15g6UhfIPjl7bdJJZhThtuvF+W1GSFH/ORew==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Okay, here's a working version of this. Is adding 48 bytes into task
struct worth it? Can this be improved, and is the non-signal-exit logic
for __WCHILDSIGINFO sane?

Other thoughts?

-Kees

Kees Cook (2):
  exit: Introduce __WCHILDSIGINFO for waitid
  selftests/seccomp: Check for waitid() behavior

 include/linux/sched.h                         |   1 +
 include/uapi/linux/wait.h                     |   1 +
 kernel/exit.c                                 |  23 +++-
 kernel/signal.c                               |   4 +
 tools/testing/selftests/seccomp/seccomp_bpf.c | 130 ++++++++++++++++++
 5 files changed, 155 insertions(+), 4 deletions(-)

-- 
2.30.2

