Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3955959CFD8
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Aug 2022 06:17:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238769AbiHWERH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Aug 2022 00:17:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235781AbiHWERD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Aug 2022 00:17:03 -0400
Received: from mail-pf1-x449.google.com (mail-pf1-x449.google.com [IPv6:2607:f8b0:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B38095D134
        for <linux-kernel@vger.kernel.org>; Mon, 22 Aug 2022 21:17:01 -0700 (PDT)
Received: by mail-pf1-x449.google.com with SMTP id d10-20020a056a00198a00b005367ac052bbso2046829pfl.16
        for <linux-kernel@vger.kernel.org>; Mon, 22 Aug 2022 21:17:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:mime-version:message-id:date:from:to:cc;
        bh=RQF+Hp7R78XaNSbP7FojiWh6Ao2+lXh+qmPouBKsoxs=;
        b=hvvCtSMC0Rq+dBBMJ5/nypqanMxOAHvudpyxc+IxZ6lJomJw9YZ+46Td1IjlOeO3sQ
         6jNaU3VtHrGBlpybAUUCHjrZbX//Xl5mS4RV2d40mCyQSKNo4ZucXdF7F8I1g1fvqZdM
         Sqpg4AMErjvRTLy6cINr88zSPKEpf9haHufA8oKfqPNnmE66jyNZt3Hbta+VPSyri8B5
         3plvN2/EuHLtLkTE+mPOETi1Ti3qioAIspnkbs8HD0h8Esn6G+fni3dezZppbtQ8ZtwJ
         UO9UneKitbkHzuBhN/xJxXiQIveSx4GJEPL06MLK9fyI4FVz9ZDtJeCDPiCj2vduLlpt
         3RfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc;
        bh=RQF+Hp7R78XaNSbP7FojiWh6Ao2+lXh+qmPouBKsoxs=;
        b=RYz4etoKptJmvqXd5Y4SpS+Mm+EAjd3cUxPea/snf6Ln8zC2MnxzPkim+cztMiO3TZ
         YO0dlMGCgvfsGsAe5s93uLgsQMDSDhiw1/RbvMIBGAu5rRwS71xO8wy2RETeV1TCIML+
         wwWGkLB2gFUbqrOKgZXmywzT0kxKdNgHveJIDX3RJJGyiteXUsYowEQokDl0sK68yCuu
         jWmSA7JYWRK2UxNt2fSDGB1WuYm4ALyx6fXLEcIPswHlkBgsuIpUMrNHcscEVDnjmn8V
         0YoaajP60qXo5rIQGHp4NzdElNVYpW43xZPM8vFGA7kdlNKZPNGsDnSNrIsslaTzTHNW
         Chqg==
X-Gm-Message-State: ACgBeo3myK6lynnAO1eJoJEqWV39AL3IbWAq6k86sIOldxBKQwkJNWJH
        8H7Q3KPnyQkL4WkcnVTj3WX/k2wG60iN
X-Google-Smtp-Source: AA6agR5GsrlymQnzABGSg82b/1ULRf+EGCNJ+vYGzb2JaeGX2VQvvlFplwzTUlar4K29y9a31LyiQW1sAtAP
X-Received: from jiangzp-glinux-dev.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:4c52])
 (user=jiangzp job=sendgmr) by 2002:a17:90b:354e:b0:1fa:a4a3:bb3a with SMTP id
 lt14-20020a17090b354e00b001faa4a3bb3amr1542937pjb.134.1661228220929; Mon, 22
 Aug 2022 21:17:00 -0700 (PDT)
Date:   Mon, 22 Aug 2022 21:16:55 -0700
Message-Id: <20220823041656.3398118-1-jiangzp@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.37.1.595.g718a3a8f04-goog
Subject: [kernel PATCH v1 0/1] Bluetooth: hci_sync: hold hdev->lock when
 cleanup hci_conn
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
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hold hdev->lock for hci_conn_failed. There are possible race conditions
which may cause kernel crash.

Changes in v1:
- Hold hdev->lock for hci_conn_failed

Zhengping Jiang (1):
  Bluetooth: hci_sync: hold hdev->lock when cleanup hci_conn

 net/bluetooth/hci_sync.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

-- 
2.37.1.595.g718a3a8f04-goog

