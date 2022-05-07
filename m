Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48B1851E753
	for <lists+linux-kernel@lfdr.de>; Sat,  7 May 2022 15:20:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1446383AbiEGNQN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 May 2022 09:16:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240386AbiEGNQL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 May 2022 09:16:11 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A34ABE23
        for <linux-kernel@vger.kernel.org>; Sat,  7 May 2022 06:12:25 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id n18so9880642plg.5
        for <linux-kernel@vger.kernel.org>; Sat, 07 May 2022 06:12:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3uZs7+F79LoAMtZDOq9Dzll+cBDvTlGlRjZEGlEHK6I=;
        b=XfEoVuad9bhriz4Vuir+gza7IdZ377RO82auIIDEDfdxtuvSXcFQId0fv4yHG3BsM/
         o15xRYgnXbRGeu2HapcGpicDFm9NfOhqGvBizQUJeq8TNZHEx+jKBFDW50k6UAYvA6Xs
         dxmI2j17zzLg8ZTPqEV1HhTZZSRy1ZXMO4O9OxR/u9knpX8PJ0N90vhHAa4CcaWyk0fp
         5FVCNUKdqUEtlmN+SAQGHqWcGj5jrJxP0qNZ9QMeObWGqLXoDDyvP/Kqqe1iI0A+56nu
         4xEUom8i/Y3fDAdLAxE2VdmfoQLTaMLZs2gjHLah+176l2vYrmJoEeTZjT0FWLUWU5Zy
         OekQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=3uZs7+F79LoAMtZDOq9Dzll+cBDvTlGlRjZEGlEHK6I=;
        b=mB6Iy6YGbZX2iD5DMp8gF9n5aB0aYpQGOq9UH8DauMobDXx6AgasWchvmGValoMBFC
         9EQAuR4R6aCmzwhlYKxPBwh+eq16G0lvEGp3W4eTQfe+2mayRoTk1XKGUOTzs9C9Fopk
         R5HGWmvXq69FUhCM+KEmLzxmNx2mRjhXJZAL32SK1Of3NWkZtfsgkeFq+VWVzNE9tQwi
         PlVlySHEB3HNFwU/bUU14bx9H5TFmPXSxznKU5us6lLfYRNjcvGzuoCGQWd4GRSBHmnM
         ++7uii2Are7EaDbqGvmhlbaCNRPbGtIXDx2Iy6ArMXcsSgfm6q83Tq374oZHIfHXOy0l
         1RLg==
X-Gm-Message-State: AOAM5330VYfFHchWLqWp0Ua/1eAvM24bTQ7nORQNrZy+/ABV7a4Pf6CJ
        F3MYi+M3QbuWQTesSdBGAMw=
X-Google-Smtp-Source: ABdhPJwFgkA899lReVNqZoN5HnHlJU0YfebxcTK1XLlzvRa6kDWdZoEkbAb4a0NO52I+BUBu3q6MFw==
X-Received: by 2002:a17:90b:2241:b0:1dc:d4d3:3047 with SMTP id hk1-20020a17090b224100b001dcd4d33047mr9767355pjb.128.1651929144788;
        Sat, 07 May 2022 06:12:24 -0700 (PDT)
Received: from localhost.localdomain (124x33x176x97.ap124.ftth.ucom.ne.jp. [124.33.176.97])
        by smtp.gmail.com with ESMTPSA id i191-20020a639dc8000000b003c14af50620sm571418pgd.56.2022.05.07.06.12.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 May 2022 06:12:24 -0700 (PDT)
Sender: Vincent Mailhol <vincent.mailhol@gmail.com>
From:   Vincent Mailhol <mailhol.vincent@wanadoo.fr>
To:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>
Cc:     linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Rikard Falkeborn <rikard.falkeborn@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>,
        Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Subject: [RFC PATCH v2 0/2] call check-atomics.sh only if prerequisites change
Date:   Sat,  7 May 2022 22:11:43 +0900
Message-Id: <20220507131146.834810-1-mailhol.vincent@wanadoo.fr>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220426155229.436681-1-mailhol.vincent@wanadoo.fr>
References: <20220426155229.436681-1-mailhol.vincent@wanadoo.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, check-atomics.sh is executed unconditionally despite the
fact that most developers do not need this to execute this check on
each iterative make instance.

This series first make check-atomics.sh raise an error instead of a
warning when CONFIG_WERROR is set. The second and last patch modifies
Kbuild so that the script is only called when dependencies are
changed.


* Changelog *

v1 -> v2

  * drop the changes on checksyscalls.sh. v1 assumed that
    checksyscalls.sh would only be called from ./Kbuild. It appears
    that there is another user: arch/mips/Makefile c.f. kernel test
    robot's report:
    https://lore.kernel.org/llvm/202205030015.JCmg5yPS-lkp@intel.com/

  * add a patch to the to make Kbuild stop if check-atomics fails and
    if CONFIG_WERROR is set.

Vincent Mailhol (2):
  check-atomiscs: stop build if CONFIG_WERROR=y
  kbuild: call check-atomics.sh only if prerequisites change

 Kbuild                          | 7 ++++---
 Makefile                        | 3 ++-
 scripts/atomic/check-atomics.sh | 9 +++++++--
 3 files changed, 13 insertions(+), 6 deletions(-)

-- 
2.35.1

