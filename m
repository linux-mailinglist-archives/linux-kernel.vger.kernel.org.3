Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF85B5B27BE
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 22:33:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229831AbiIHUcx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Sep 2022 16:32:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229816AbiIHUcs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Sep 2022 16:32:48 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CF6D5F7D9
        for <linux-kernel@vger.kernel.org>; Thu,  8 Sep 2022 13:32:47 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id u9so40822554ejy.5
        for <linux-kernel@vger.kernel.org>; Thu, 08 Sep 2022 13:32:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :from:to:cc:subject:date;
        bh=qfAt/hjdgJmut/nxKh8LKAbLz+hFQ0D93ZGVPZeDHCE=;
        b=aAIE4m7F9Tr38MxixsV+aCa56FNNfunP8LyZ6eaxqWLkEYCIAuRZZ9a7xKuNpZH9JR
         TvcK6AEx475kJbWAnLMPjwwIDDchCLPnpp3zl4ikPn6JdGAAnitymy3w+lCiQ1C2wBHx
         vONvovyCv1lER0INez4U7O+AptQcjPYlhloRdo41iNjL1OjWAZ8FwCnUDuSpFvimg2bT
         LAqf8UplcHfcPkzShALjjzE89yZ2JINpO9nQ5kS/V4keWZ6M/KCyc9peErinsjhoH0+d
         zckM97GKxUU31qcfrQKB0bSDs6G1jYEkViYFDff5KkiifLw6sEyrM8knt+dabRxt2+m4
         JfuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :x-gm-message-state:from:to:cc:subject:date;
        bh=qfAt/hjdgJmut/nxKh8LKAbLz+hFQ0D93ZGVPZeDHCE=;
        b=RGbNCTRY/Zlm+83GBywHgSm/5PxdGOIN0kiZV5FVw8uISDHLT5r3VCsHnBqulCB7i8
         sbQ/2kyuty340ZetILVtYlUBDUrlBqUlXdmGyVvYe41mnFUxSusBtK5JLzI0648rHz2e
         yS9nYGhCyaNYJy5V6G9IMX6tLbQwvJDNSD4igPD/clDmuBKvlksWMfr+QWIjsZKI6Heg
         slwAmkIB1fkNahPJg8RpEnbkHUOaiHcLAr703B6utqLxn4tydE4pJAgUuW0aWk/l2DGu
         fQCXZzP5S8TzW07RjDjZ6u0u70Ic1EVSpNJJIoLhMTB5ajPPvfJ2bguQT9nEebBKNxpn
         N1Yg==
X-Gm-Message-State: ACgBeo0tdBIgjgHeZs3kFNVo7yxs0B89OgzHNv+b2I+T/0YCpfZWdVlI
        7hRuJvtyg6jj3nhm0LfL0Lk=
X-Google-Smtp-Source: AA6agR44ZBiMS9NG4ag9pmG5ERjX8gI6Q9WP+Nvm09J3cDY9v9fxOke2Ltb9DBX0l6rEcVzwSrnEDA==
X-Received: by 2002:a17:906:cc5d:b0:741:38a8:a50a with SMTP id mm29-20020a170906cc5d00b0074138a8a50amr7165129ejb.650.1662669166030;
        Thu, 08 Sep 2022 13:32:46 -0700 (PDT)
Received: from matrix-ESPRIMO-P710 (p57ba2cf5.dip0.t-ipconnect.de. [87.186.44.245])
        by smtp.gmail.com with ESMTPSA id el3-20020a056402360300b0045081dc93dfsm1609355edb.78.2022.09.08.13.32.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Sep 2022 13:32:45 -0700 (PDT)
Date:   Thu, 8 Sep 2022 22:32:43 +0200
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Dan Carpenter <error27@gmail.com>
Subject: [PATCH] staging: rtl8192e: Fix return type for implementation of
 ndo_start_xmit
Message-ID: <20220908203243.GA23048@matrix-ESPRIMO-P710>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

CFI (Control Flow Integrity) is a safety feature allowing the system to
detect and react should a potential control flow hijacking occurs. In
particular, the Forward-Edge CFI protects indirect function calls by
ensuring the prototype of function that is actually called matches the
definition of the function hook.

Since Linux now supports CFI, it will be a good idea to fix mismatched
return type for implementation of hooks. Otherwise this would get
cought out by CFI and cause a panic.

Use enums from netdev_tx_t as return value instead, then change return
type to netdev_tx_t.

Suggested-by: Dan Carpenter <error27@gmail.com>
Signed-off-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
---
Tested with rtl8192e
Transferred this patch over wlan connection of rtl8192e
---
 drivers/staging/rtl8192e/rtllib.h    |  2 +-
 drivers/staging/rtl8192e/rtllib_tx.c | 10 +++++-----
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtllib.h b/drivers/staging/rtl8192e/rtllib.h
index 0ecd81a81866..b4b606f552fb 100644
--- a/drivers/staging/rtl8192e/rtllib.h
+++ b/drivers/staging/rtl8192e/rtllib.h
@@ -1938,7 +1938,7 @@ int rtllib_encrypt_fragment(
 	struct sk_buff *frag,
 	int hdr_len);
 
-int rtllib_xmit(struct sk_buff *skb,  struct net_device *dev);
+netdev_tx_t rtllib_xmit(struct sk_buff *skb,  struct net_device *dev);
 void rtllib_txb_free(struct rtllib_txb *txb);
 
 /* rtllib_rx.c */
diff --git a/drivers/staging/rtl8192e/rtllib_tx.c b/drivers/staging/rtl8192e/rtllib_tx.c
index 42f81b23a144..ebcaf3bf22d6 100644
--- a/drivers/staging/rtl8192e/rtllib_tx.c
+++ b/drivers/staging/rtl8192e/rtllib_tx.c
@@ -543,7 +543,7 @@ static u8 rtllib_current_rate(struct rtllib_device *ieee)
 		return ieee->rate & 0x7F;
 }
 
-static int rtllib_xmit_inter(struct sk_buff *skb, struct net_device *dev)
+static netdev_tx_t rtllib_xmit_inter(struct sk_buff *skb, struct net_device *dev)
 {
 	struct rtllib_device *ieee = (struct rtllib_device *)
 				     netdev_priv_rsl(dev);
@@ -946,23 +946,23 @@ static int rtllib_xmit_inter(struct sk_buff *skb, struct net_device *dev)
 			if ((*ieee->hard_start_xmit)(txb, dev) == 0) {
 				stats->tx_packets++;
 				stats->tx_bytes += le16_to_cpu(txb->payload_size);
-				return 0;
+				return NETDEV_TX_OK;
 			}
 			rtllib_txb_free(txb);
 		}
 	}
 
-	return 0;
+	return NETDEV_TX_OK;
 
  failed:
 	spin_unlock_irqrestore(&ieee->lock, flags);
 	netif_stop_queue(dev);
 	stats->tx_errors++;
-	return 1;
+	return NETDEV_TX_BUSY;
 
 }
 
-int rtllib_xmit(struct sk_buff *skb, struct net_device *dev)
+netdev_tx_t rtllib_xmit(struct sk_buff *skb, struct net_device *dev)
 {
 	memset(skb->cb, 0, sizeof(skb->cb));
 	return rtllib_xmit_inter(skb, dev);
-- 
2.37.2

