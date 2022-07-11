Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95FCD570D97
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 00:54:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231177AbiGKWyJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 18:54:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229500AbiGKWyG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 18:54:06 -0400
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com [IPv6:2607:f8b0:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 495341E3D2
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 15:54:05 -0700 (PDT)
Received: by mail-pg1-x54a.google.com with SMTP id t6-20020a63dd06000000b00417b4b6fe9cso467018pgg.1
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 15:54:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=xO5JXzhK4rbeGShdnQqpfrChMKSlSVvQkkYlcCCKloo=;
        b=BJEO8MzGCt1wyxahAkRH58z+Yiwxd370rA4VM2qq/BOYsJihcr6nmMaUjluDHGAQvK
         lTmbfgE7Q4zmdaqw6tpq26n2tl1Euf3W7KvSPIRxKTCqscSitr6LxB0KJ98tQ1r8jyHa
         XYrjgZMPGRtlIn4/SNmqxFYyv2b3DQ+F1KDwLRts7hSn812s1VTKwp5yzKcWtNWZJPhc
         dvJJ/4KU90dHojr9IklHLspi2wEvRiXs6vKMU5T7dM+tIFiGUkeiiimbfU4voo2U7VDJ
         1b+ak6WLGS7MAXzRYqDkLgcNfNBgtYhYCBIrQwcHHJKlm2ZtSczahTkCYinx6A8UT7S5
         oNRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=xO5JXzhK4rbeGShdnQqpfrChMKSlSVvQkkYlcCCKloo=;
        b=zxNcymoOTNkgcj4Ds6ax4WkQ44kDbAe8g94RKSiulbY1m859p+Htj+2S/bB6KBkNya
         G1aZxjCled/PMLQOLadIm/QKK/jLGQsINJkBwD940+2zK7OccgPf2uQFJORgyGTzzMUP
         O06TJFKIMMRwJ3QsJc1sfC5I8efBhb6npQKtVr2/Uy7gVyq+hGLJ8N/XXAnAwcwFE1U3
         xfrQN961+RJ4obEmFjYeK5h9yEGnoUc+4TEaFBRwFoYfQKgeJh2DVXrPiIz1T+UEk/mQ
         1P67RihPZHlRXgjKs1jaPIhlDQXixZ5y6dptKxU2gghxis316GdRLf79A7Z86E4//0De
         v17A==
X-Gm-Message-State: AJIora9ZCAL8UhJttnrDsKb4yHE06G3bM0aSFgCZI1wo9U3oPzBgEbPY
        pZHcZ0FEquL8Wh17sFHrWr7y9t1eRA/x
X-Google-Smtp-Source: AGRyM1t4bx/aPiPA15cYX46mj8Q7o/j/YNHlxQl2lRmEGgP4/CGevjmd51dXWiVMj9rt3JzYg7uvCgH7426P
X-Received: from jiangzp-glinux-dev.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:4c52])
 (user=jiangzp job=sendgmr) by 2002:a05:6a00:a12:b0:527:dba9:c416 with SMTP id
 p18-20020a056a000a1200b00527dba9c416mr20575252pfh.33.1657580044634; Mon, 11
 Jul 2022 15:54:04 -0700 (PDT)
Date:   Mon, 11 Jul 2022 15:53:58 -0700
Message-Id: <20220711225359.996974-1-jiangzp@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.37.0.144.g8ac04bfd2-goog
Subject: [kernel PATCH v1 0/1] This patch fixes a previous patch which did not
 remove setting
From:   Zhengping Jiang <jiangzp@google.com>
To:     linux-bluetooth@vger.kernel.org, marcel@holtmann.org
Cc:     Zhengping Jiang <jiangzp@google.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Paolo Abeni <pabeni@redhat.com>, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org
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

scanning_paused to false after resuming. So after setting the value,
the function to update scan will always quit.
Also need to set the value first before updating passive scan.

BUG=b:236868580,b:236340454
TEST=verified suspend is fixed in volteer with LE mouse
TEST=bluetooth_AdapterSRHealth.sr_peer_wake_le_hid
TEST=bluetooth_AdapterCLHealth.cl_adapter_pairing_suspend_resume_test


Changes in v1:
- Fix updating passive scan after suspend resume

Zhengping Jiang (1):
  Bluetooth: hci_sync: Fix resuming passive scan after suspend resume

 net/bluetooth/hci_sync.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

-- 
2.37.0.144.g8ac04bfd2-goog

