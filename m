Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57A09520666
	for <lists+linux-kernel@lfdr.de>; Mon,  9 May 2022 23:06:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230027AbiEIVJz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 May 2022 17:09:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230004AbiEIVJr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 May 2022 17:09:47 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69BD672217
        for <linux-kernel@vger.kernel.org>; Mon,  9 May 2022 14:05:39 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-2f83cc145edso129516547b3.11
        for <linux-kernel@vger.kernel.org>; Mon, 09 May 2022 14:05:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=bfz1mnwaX4ka3VLZxEi1SIdcRgMxAF5AucTmvkifj0I=;
        b=AiKMPLXlZuaA3VPSpj/ofOF1/jtgSK4b7F0Y8MltTlfTMOaVr/mSsv2C6Lg+/bm8pK
         b3MmagvFZZvLwH/NIdZSL/eOLHl/1wD7ijQNvZOA1w8Eu5TQCsxDm4fKdWQ/y/zEIymr
         W6lPsa9LMn534psJhgmJ2CL5y5aVTvrinKDT+vVcXvn2BMhzvpxOXWNFAvmmiqAfZVKS
         uefy5ND7VVukTWWPv4zKp8Hbcf7m0qf+5X2rJuh/yg3XD5UKXakphQPF4AZwHvr0+v9R
         yG+smavIqT0RJ9KqK99UIt65nZaAnpD/oCat5UVC/7ZKsCtMuTdXpWH49MM/03xDvj/9
         0aqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=bfz1mnwaX4ka3VLZxEi1SIdcRgMxAF5AucTmvkifj0I=;
        b=LWg6/30Rs8GZKFWdRau6Mdhmkmr1pgwnxCa+8vtmKhBaP8c2UndAAKyd/3fJFt8Tse
         ubx4zW+ofbAUPdIBexBeIamYfwYdeyGpvpHPqOfDuvZZYhxyTfHV8mjGf1suPlu7y/Zq
         trBwh6Ev+A95UfebAgOVaBDSVd/Gyynmz1U8d18y+TO5YZi2IjBDZF3Oaowjy5agizqn
         FsjvKDETDHbhoEWw2A2hWxE0XhWGntJE7xPPVvmvbhqPJc2LOTw0ixRzVOMdgPizCHaK
         1uBNQWaYTNF0zmC7gT/6lI2I7cI/dqokPI9SDfsi/QTpeQaa6CBJyrq6yFKY4BP4YaIL
         Ehkw==
X-Gm-Message-State: AOAM5309EyfO5IDtgCJg0i4zL8vRZdXyy1nsdGFqUHiDeWlBBJ8GHQ37
        /x/i63SMNVICbYRzaDnSo6prbvFUDbwv5w==
X-Google-Smtp-Source: ABdhPJxuy3o513Mphh5qdmHGZppOwcPpU0V84poKA6tagZCsNhO7fAnDzJqL+eG1MvWxf2DsHMZGUUGiCIggUw==
X-Received: from mmandlik.mtv.corp.google.com ([2620:15c:202:201:dfb9:149b:15ff:6b47])
 (user=mmandlik job=sendgmr) by 2002:a25:d450:0:b0:649:1be0:506b with SMTP id
 m77-20020a25d450000000b006491be0506bmr14843403ybf.532.1652130338606; Mon, 09
 May 2022 14:05:38 -0700 (PDT)
Date:   Mon,  9 May 2022 14:05:33 -0700
Message-Id: <20220509140403.1.I28d2ec514ad3b612015b28b8de861b8955033a19@changeid>
Mime-Version: 1.0
X-Mailer: git-send-email 2.36.0.512.ge40c2bad7a-goog
Subject: [PATCH] Bluetooth: Fix Adv Monitor msft_add/remove_monitor_sync()
From:   Manish Mandlik <mmandlik@google.com>
To:     marcel@holtmann.org, luiz.dentz@gmail.com
Cc:     chromeos-bluetooth-upstreaming@chromium.org,
        linux-bluetooth@vger.kernel.org,
        Manish Mandlik <mmandlik@google.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
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

Do not call skb_pull() in msft_add_monitor_sync() as
msft_le_monitor_advertisement_cb() expects 'status' to be
part of the skb.

Same applies for msft_remove_monitor_sync().

Signed-off-by: Manish Mandlik <mmandlik@google.com>
---

 net/bluetooth/msft.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/net/bluetooth/msft.c b/net/bluetooth/msft.c
index f43994523b1f..9990924719aa 100644
--- a/net/bluetooth/msft.c
+++ b/net/bluetooth/msft.c
@@ -387,7 +387,6 @@ static int msft_remove_monitor_sync(struct hci_dev *hdev,
 		return PTR_ERR(skb);
 
 	status = skb->data[0];
-	skb_pull(skb, 1);
 
 	msft_le_cancel_monitor_advertisement_cb(hdev, status, hdev->msft_opcode,
 						skb);
@@ -506,7 +505,6 @@ static int msft_add_monitor_sync(struct hci_dev *hdev,
 		return PTR_ERR(skb);
 
 	status = skb->data[0];
-	skb_pull(skb, 1);
 
 	msft_le_monitor_advertisement_cb(hdev, status, hdev->msft_opcode, skb);
 
-- 
2.36.0.512.ge40c2bad7a-goog

