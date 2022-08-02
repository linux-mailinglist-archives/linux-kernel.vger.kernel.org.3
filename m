Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6853958821F
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Aug 2022 20:56:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230180AbiHBS4B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Aug 2022 14:56:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230127AbiHBSzr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Aug 2022 14:55:47 -0400
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08AB7140CB
        for <linux-kernel@vger.kernel.org>; Tue,  2 Aug 2022 11:55:44 -0700 (PDT)
Received: by mail-pj1-x104a.google.com with SMTP id b5-20020a17090a6e0500b001f3076ab926so7940146pjk.1
        for <linux-kernel@vger.kernel.org>; Tue, 02 Aug 2022 11:55:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:mime-version:message-id:date:from:to:cc;
        bh=z6YOAbeOZEs1MBBf+w9QW4hYsp3caV69mYkSKHQ/2TQ=;
        b=ZTUncLsSJVThOeuuCQW326smIKVVrW1Fa/gxz87xVQmlkUAR2mqql9vnUDMX7T0Pbu
         AxFA3I6qwAzNHmrHlsCzMChD5TJt1CVI+CGhlHmK+GvvnjtAe5qHNm7ucZNgpoT6eOn5
         4ZC8/ruhVXEbs7a/1hI5943gZOAM93FT1XUkdSn0+E10TdhLc3Omaq//W8YwjfOaXJ7h
         D2aOCtERQ40RdTcf1X8MZYjr/ZvPVVHQ95sQHQ555KOthe0rb9Z0iSjaS3uhB0xIVcm1
         MfG4vgdWtMQMrDrjpikQSgyKXmxyNEmfNYh+UKnVvN++tjYFAUEAdrmyz4M9uYYlxKVu
         Vk/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc;
        bh=z6YOAbeOZEs1MBBf+w9QW4hYsp3caV69mYkSKHQ/2TQ=;
        b=7nnfdf1XT2VTzH10SZ8wzZKAke+lYAt2IPj5n69uKBPoIA6qFSg0q63yjLWyjJPYEv
         Yqt6RQCEgGrRdbhPupmEN2e6GoD7tH9VwFq7jGIvxm8KMh9xIHaqXhpkx6PhW4Lac6Yt
         x46zoEQOG71KHHTW4wNivga1vMEqvTw5oU+siyuWcX3kWVo3O8YHpbAA1ZoiZdaT6Y1V
         GYfeMk8BzI10ecYwWhKqa2mQw/oDA5ZmjitKlTFkyxbPsu39j5unKih458QIBeXFbaX9
         SyFrXMrJZKxroEhIwuBtVjoegn2b3ECyvNHIKHEmUIBJjyX45ZPHT/npV9uP8qDvHAO3
         xWdA==
X-Gm-Message-State: AJIora+yo+yEnx0wUL7drC0n3VLA2QbMXHNBoYd0XXAysSazjnUPah49
        pGH2uodQrQSRaGDp97eUYq03d5EMEN0=
X-Google-Smtp-Source: AGRyM1t6fClii7zpegnV02vPW+r4wyiAPzq9rJA8TINHaXWJZhY3vSYkv3E75sTG2cFO2YcaZim0tu2J85rf
X-Received: from jackyli.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:3b51])
 (user=jackyli job=sendgmr) by 2002:a05:6a00:8cc:b0:52c:7ab5:2ce7 with SMTP id
 s12-20020a056a0008cc00b0052c7ab52ce7mr21578935pfu.28.1659466543879; Tue, 02
 Aug 2022 11:55:43 -0700 (PDT)
Date:   Tue,  2 Aug 2022 18:55:32 +0000
Message-Id: <20220802185534.735338-1-jackyli@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.37.1.455.g008518b4e5-goog
Subject: [PATCH 0/2] Improve error handling during INIT_EX file initialization
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
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
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

Jacky Li (2):
  crypto: ccp - Initialize PSP when reading psp data file failed
  crypto: ccp - Fail the PSP initialization when writing psp data file
    failed

 .../virt/kvm/x86/amd-memory-encryption.rst    |  5 +-
 drivers/crypto/ccp/sev-dev.c                  | 52 ++++++++++++-------
 2 files changed, 35 insertions(+), 22 deletions(-)

-- 
2.37.1.455.g008518b4e5-goog

