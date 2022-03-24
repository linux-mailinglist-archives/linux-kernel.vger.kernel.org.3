Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A044C4E67D3
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Mar 2022 18:29:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243701AbiCXRbU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Mar 2022 13:31:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242669AbiCXRbS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Mar 2022 13:31:18 -0400
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com [IPv6:2607:f8b0:4864:20::82b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE8F355747
        for <linux-kernel@vger.kernel.org>; Thu, 24 Mar 2022 10:29:46 -0700 (PDT)
Received: by mail-qt1-x82b.google.com with SMTP id t19so4460402qtc.4
        for <linux-kernel@vger.kernel.org>; Thu, 24 Mar 2022 10:29:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:reply-to:mime-version
         :content-disposition;
        bh=cYD0W2yiOTbVTGcteGLlatIUAd0iwc/hCFG55ghJwoY=;
        b=gy4oFJ0NjYPjFx3ZniSuKAThvdpErlPjAnj20IKcpSBb6MsCS5qV2VnZwV6fiGslbL
         3EFbk8UTE2xNpAHQ/MDvpuugaenjfOhErB9t3ekQanigWLM/P0SI+X6llt6uuGVvsaQU
         Jd95QrEgIsxHCYndtxFcCcvvlqWo1mG1tqwuqOFr8N8ofkbcyBgNmC8RnjLURwsrpfUb
         XaDGq5YzDdqOaRM1dQndzGMipWKXRZ+vUMnWy2nbeg9gvVLPF9Drqj30N1uIc2JCb8CC
         nMo1/rvA9CqqzPeEm+Y2+WQzm1nLkvYhGw5SwRrUxD/RxRAlbAR2gkcbKg7xZDSULDfq
         1f7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :reply-to:mime-version:content-disposition;
        bh=cYD0W2yiOTbVTGcteGLlatIUAd0iwc/hCFG55ghJwoY=;
        b=M0yECzPB2N2SPi2PNtpJ513040aaTUR6gfmqx3I6naN8JwwUPPKqHvZi2ZLEemM3K4
         u9vMzc6XuWQtBpsoTxEqViuc+MRcsxky9N0QvTCDnDYvF07Jx/MTbketDEi1JoTVUZT3
         pWfvQOYC9nyywTWp9w82x03Z9sLRrhiN5ZkP4vadqZLPPv2L7e1F05TwLfaM24IRr5Je
         PAj/wWjAJ4LfWOd0zza98rEVEKB1nl5SsLjdLDWW6pKXVuX6slFSZHvw5qwfyUSiCvSP
         H400s81D1SUFGlVkyYlrbO07/555FDqSsvOiBcyU2XCHT3EIYfLOntF6e7zUw3oNh5NC
         RXUw==
X-Gm-Message-State: AOAM530W9RjeeK/I3SQZsMYeLDzqtor8ZClFyw53xXd7NCC2ps/H+8NA
        tDTPeZiW1VyxpsYCgqehFA==
X-Google-Smtp-Source: ABdhPJwhVJyG0O1PAwXEn58z5sXzAbPqXhMX5LetJY46PQXWM4qhn8nJcvNKQyF0E+cV20Kyi4kGRA==
X-Received: by 2002:a05:622a:208:b0:2e1:b3ec:b7ce with SMTP id b8-20020a05622a020800b002e1b3ecb7cemr5718572qtx.345.1648142985666;
        Thu, 24 Mar 2022 10:29:45 -0700 (PDT)
Received: from serve.minyard.net (serve.minyard.net. [2001:470:b8f6:1b::1])
        by smtp.gmail.com with ESMTPSA id v7-20020ac85787000000b002e1c8376517sm2814783qta.22.2022.03.24.10.29.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Mar 2022 10:29:44 -0700 (PDT)
Sender: Corey Minyard <tcminyard@gmail.com>
Received: from minyard.net (unknown [IPv6:2001:470:b8f6:1b:f879:e43:4f26:fbe9])
        by serve.minyard.net (Postfix) with ESMTPSA id B5D471800BA;
        Thu, 24 Mar 2022 17:29:42 +0000 (UTC)
Date:   Thu, 24 Mar 2022 12:29:41 -0500
From:   Corey Minyard <minyard@acm.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        openipmi-developer@lists.sourceforge.net
Subject: [GIT PULL] IPMI bug fixes for 5.17
Message-ID: <20220324172941.GI3457@minyard.net>
Reply-To: minyard@acm.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
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

The following changes since commit 0c947b893d69231a9add855939da7c66237ab44f:

  Merge tag '5.17-rc-part1-smb3-fixes' of git://git.samba.org/sfrench/cifs-2.6 (2022-01-17 09:53:21 +0200)

are available in the Git repository at:

  https://github.com/cminyard/linux-ipmi.git tags/for-linus-5.17-1

for you to fetch changes up to 8d10ea152e2fb9b4a42b282cb90bfc4d98e319a3:

  ipmi: initialize len variable (2022-03-20 12:37:15 -0500)

----------------------------------------------------------------
Minor fixes for IPMI

Little fixes for various things people have noticed.

One enhancement, the IPMI over IPMB (I2c) is modified to allow it to
take a separate sender and receiver device.  The Raspberry Pi has an
I2C slave device that cannot send.

----------------------------------------------------------------
Corey Minyard (3):
      ipmi: Add the git repository to the MAINTAINERS file
      ipmi:ipmi_ipmb: Unregister the SMI on remove
      ipmi:ipmb: Add the ability to have a separate slave and master device

Jason Wang (1):
      ipmi: ssif: replace strlcpy with strscpy

Joel Stanley (2):
      ipmi: kcs: aspeed: Add AST2600 compatible string
      ipmi: kcs: aspeed: Remove old bindings support

Rikard Falkeborn (1):
      ipmi/watchdog: Constify ident

Tom Rix (1):
      ipmi: initialize len variable

 .../devicetree/bindings/ipmi/ipmi-ipmb.yaml        |  8 +++
 MAINTAINERS                                        |  1 +
 drivers/char/ipmi/ipmi_ipmb.c                      | 60 ++++++++++++++++---
 drivers/char/ipmi/ipmi_ssif.c                      |  4 +-
 drivers/char/ipmi/ipmi_watchdog.c                  |  2 +-
 drivers/char/ipmi/kcs_bmc_aspeed.c                 | 67 +++-------------------
 6 files changed, 70 insertions(+), 72 deletions(-)
