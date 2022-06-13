Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A864C54A1B1
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jun 2022 23:43:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236235AbiFMVnx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jun 2022 17:43:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352276AbiFMVne (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jun 2022 17:43:34 -0400
Received: from mail-pf1-x44a.google.com (mail-pf1-x44a.google.com [IPv6:2607:f8b0:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 618AC6270
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jun 2022 14:43:32 -0700 (PDT)
Received: by mail-pf1-x44a.google.com with SMTP id i19-20020aa79093000000b0050d44b83506so2844727pfa.22
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jun 2022 14:43:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=M9u2uZrITY2ZmiHjCgQwdtv5Ky15VkyjtQ04bHL3Xio=;
        b=NnxOPuFpNs5MnMcovgUqGxaZmAXo2RDglY8A41g2hQyQzsPDlOWea/WR9ctTMqtneP
         RmEPy8aIlzarloEypEpgbhWmddMCO4MzzX2IbOfqv2K2klXDV5lc42DWISlmencWQltz
         LqhhEOJ9bfVLARa37Ov3eGxijku/MwfleKPMwRSHyjTPAI89Uvt3/S9VJ/hvxi62H6Qx
         1KiIKvr31LPhV0XEpYIg6yxRHDBoLfDivJyPtt/YEv3vR6WBXMOE3StYmHwOauMLwGW6
         HEMqf4EAvlGqqaB6y52VA8KaE+a4L4igEBKwo//t5WFd6FT75eyDyTk1hK/XX1BC6L30
         m65w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=M9u2uZrITY2ZmiHjCgQwdtv5Ky15VkyjtQ04bHL3Xio=;
        b=FzpAKcNn/a5PWhZ5USrCQ+WQG0YM+klAKQAtkXurM6OQ3ReN3RWnCVMOBYPoxV015L
         KZsQMvT3gGaJPgV62D/zhoxUOD+ClXl/e04BypkdWPAKSANcj7C1IxVJX4UscmfwnLwE
         eAnGeigCvJj49xMat6OkV3jLWjIRHjDV/E6xeEC8dc0Wmbpv4h4uD01gANV9XJRVN6in
         wsqHS8Kqo5mUk93PS5gwZ9GmWkIgsABpyGonFzsXfZRbRuyLm3nYM70vK/qt0BjiYLq5
         0BMUXRdG5I4xMgA2a+ps76+ZAiK3CokjHp+2WfTOm2NmxrPtNbDk0iTpKztwhfQeM5tH
         BDKA==
X-Gm-Message-State: AJIora+7BaRsMglKUH5V5QaC/S1DDF2kwRNrC2pqqgKS5ltWmwO5glfP
        wLQdKZSvjEHjWX7vJ0sohnzRSaae2m6I
X-Google-Smtp-Source: AGRyM1t/zJRywM18OCZjxBcOmaA2MiocqnI4Hdgc1dAqJTjLs8xD5UHnaNoj5POcyXAHy86FND9u5aItmXQA
X-Received: from jiangzp-glinux-dev.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:4c52])
 (user=jiangzp job=sendgmr) by 2002:a17:90a:178f:b0:1e3:3ba:c185 with SMTP id
 q15-20020a17090a178f00b001e303bac185mr47670pja.1.1655156611283; Mon, 13 Jun
 2022 14:43:31 -0700 (PDT)
Date:   Mon, 13 Jun 2022 14:43:26 -0700
Message-Id: <20220613214327.15866-1-jiangzp@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.36.1.476.g0c4daa206d-goog
Subject: [kernel PATCH v1 0/1] Fix refresh cached connection info
From:   Zhengping Jiang <jiangzp@google.com>
To:     linux-bluetooth@vger.kernel.org, marcel@holtmann.org
Cc:     chromeos-bluetooth-upstreaming@chromium.org,
        Zhengping Jiang <jiangzp@google.com>,
        Brian Gix <brian.gix@intel.com>,
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


Get connection info will return error when using synchronous hci_sync
call to refresh the cached information when the data times out. This is
because the cmd->user_data was not set before the call, so it will fail
checking connection is still connected.

Changes in v1:
- Set connection data before calling hci_cmd_sync_queue

Zhengping Jiang (1):
  Bluetooth: mgmt: Fix refresh cached connection info

 net/bluetooth/mgmt.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

-- 
2.36.1.476.g0c4daa206d-goog

