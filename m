Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5AE4596330
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Aug 2022 21:32:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236879AbiHPTcZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Aug 2022 15:32:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236768AbiHPTcX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Aug 2022 15:32:23 -0400
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com [IPv6:2607:f8b0:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F176987695
        for <linux-kernel@vger.kernel.org>; Tue, 16 Aug 2022 12:32:21 -0700 (PDT)
Received: by mail-pg1-x54a.google.com with SMTP id k4-20020a63ff04000000b0041beb6ea9bbso4331776pgi.21
        for <linux-kernel@vger.kernel.org>; Tue, 16 Aug 2022 12:32:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:mime-version:message-id:date:from:to:cc;
        bh=lnds6ny2TNE2xsTeBwgr2LZaFGS1qTR6zkBwE36ZPac=;
        b=n6mCgX9AA0fSKZgignFSTauJfNPKQiqQKj5oEO4y/re7xpeWAyuaHIq4jY64/1U4TJ
         d34doOwJgPRR5UnG76B4bPe6tNyDhWvJDVIO8V6uEwqbyNiRePCPPKcpXSomddMnYU4U
         fK+Dz+oRm6wix+ijA4slGOFe51rhYdXcWUsZCE8Mbq9gfoAd8ERCu+paFKuQ+8xZSPmH
         8e3L6UVOpLrEw/PKRzmlxC1UWZQ8d5/RiWuvLRY3zsRgvly4IdminDhZV0t15LIHgfqj
         4BWr13wZFNM5lW2BiCEAyLrjjvvRD9xDGSw71YrdWcBKKk0wx9mZVgUtp2yXgpW2suPw
         0gkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc;
        bh=lnds6ny2TNE2xsTeBwgr2LZaFGS1qTR6zkBwE36ZPac=;
        b=yP6AINV8A8sCHbjutviKxc83+EA656rRefbnVz76W6hHCoJWk0n2H3VWa3v5E0BnMf
         RFSdJR2sl91dJb5zoRPdB3EkeLRYgMJ/6zTeo+VD16uf+QxqaNgFh3aMNtoMQ0LlWno4
         od1aBCtk90kNqjHBrBr2In4BaxDbdOFu+APMqIwMBLiXC57MSxA43ZnuShJEZ9upcSKk
         I8W3CGv/DwU/gS2lnLu32dQE9q83y7lXZ15ty/SOO2O1lb8qL3/Xw0oZquIJkBtJMh2K
         i1vi4OUS0fchUT1bmrPDG+Heg+MXSDF82rsbCiJTgPLctJZnFkwiHPNXfgip+r7WdPEb
         4eyA==
X-Gm-Message-State: ACgBeo3E9AjSwhhyonXWQbaBGYaCbAUNqSidliWMh3erb++XKg069Hmz
        dVPtUCSrUjbLuRCvm5syPKQFTcqKl6w=
X-Google-Smtp-Source: AA6agR4Phdgs3HsIXQvZUmZfFPGRrsUMqjfDu9WtYjkDvvD9fRiG4P0AsOjUwr+M+wjvgodXKT6WNeXe3D9c
X-Received: from jackyli.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:3b51])
 (user=jackyli job=sendgmr) by 2002:a17:902:f686:b0:172:8c44:8e94 with SMTP id
 l6-20020a170902f68600b001728c448e94mr2806567plg.157.1660678341448; Tue, 16
 Aug 2022 12:32:21 -0700 (PDT)
Date:   Tue, 16 Aug 2022 19:32:07 +0000
Message-Id: <20220816193209.4057566-1-jackyli@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.37.1.595.g718a3a8f04-goog
Subject: [PATCH v2 0/2] Improve error handling during INIT_EX file initialization
From:   Jacky Li <jackyli@google.com>
To:     Brijesh Singh <brijesh.singh@amd.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        John Allen <john.allen@amd.com>
Cc:     Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Marc Orr <marcorr@google.com>, Alper Gun <alpergun@google.com>,
        Peter Gonda <pgonda@google.com>, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jacky Li <jackyli@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently the PSP initialization fails when the INIT_EX file is missing
or invalid, while the initialization continues when the OS fails to
write the INIT_EX file. This series handles both cases in a more robust
way by resolving the file read error as well as throwing the write error
to the caller.
---
Changelog since v1:
- refactor around __sev_init_ex_locked() and fix format.

Jacky Li (2):
  crypto: ccp - Initialize PSP when reading psp data file failed
  crypto: ccp - Fail the PSP initialization when writing psp data file
    failed

 .../virt/kvm/x86/amd-memory-encryption.rst    |  5 +-
 drivers/crypto/ccp/sev-dev.c                  | 62 +++++++++++--------
 2 files changed, 39 insertions(+), 28 deletions(-)

-- 
2.37.1.595.g718a3a8f04-goog

