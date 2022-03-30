Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA58F4EB8AF
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Mar 2022 05:14:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242242AbiC3DP5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Mar 2022 23:15:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234767AbiC3DPx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Mar 2022 23:15:53 -0400
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com [IPv6:2607:f8b0:4864:20::d36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 526512BB0C
        for <linux-kernel@vger.kernel.org>; Tue, 29 Mar 2022 20:14:07 -0700 (PDT)
Received: by mail-io1-xd36.google.com with SMTP id g21so10150284iom.13
        for <linux-kernel@vger.kernel.org>; Tue, 29 Mar 2022 20:14:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=northvilleschools.net; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=tx0S3IoWKwhBblgXlSk6eBT885Zq+4pfcJ7ztGcossU=;
        b=QqQjkH3EtCEzRB3DKA9ZBkqDexr43NHDlVfYhH87ZKsMQNE1foRYtUP/dKASISz0jU
         WXeqYfLgkG28RXOjiu0sDswqCYH6Qy+Mfk6k0FrxXGiBPs4wWbY9Ctry4OBQRc7ZEWIZ
         RRfKpISO8icHhEyWp/v7MMKCCpr7/cobnyiptbjSQLq7yJcNmEJj6z0d0bIXBS3qbbef
         awgn/5vkcZUwJ4nk8w6pRjqpT+kUIW4TwyAEtQ0/YgAHoFLyfiYmZ//90J2vuNfZwgI7
         hnZ1D7sxlIjtTbe0ka8nYAjedsVs1HJak7sNMnqD67C1knyIrcOReomHJSRsgCzx2lMh
         SKFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=tx0S3IoWKwhBblgXlSk6eBT885Zq+4pfcJ7ztGcossU=;
        b=hnBBY/bjXRKw67oOoFNVGvFFBfB6Uu03Ndu44xWFRRkKwTl2mrVFNmeLUy0IsnUrGD
         hicR60c2Jot+fZerBZ8+y9owijl5fvTCQSyLCpHOyrhEyEsy+zZV0FJiQjRRyivmnVjB
         6tQgisZ4paAh6M3S+3jMu7u8gk1jvgR55XbOVkTugaQrQtZyhk7RkWmAvlao9T2cRQNf
         JqGZzN2FKwwBNooGfs1O9LwstiOXnSGzbq1lTrxgZkR09CD2gKPQ3izxX3jTmD33c6zG
         d0Lev8t0Uz77RjH3SxRa4FCVRrgE4OIVgekAex4dPecYO/g47saIT5gn0ALLHymCie52
         1tCQ==
X-Gm-Message-State: AOAM532bIoZeoC/YT5vUtganMWfcZmAh6rQa7w0dAq6D1GCkU/MII9s2
        P6N2VZgDDJ0Q7028BeeM+aJZDKV9ifZmLEq1
X-Google-Smtp-Source: ABdhPJxz1kNiwMvaB7buRSeau/6CVisXBu1tQl0Gx5bHwm86vNcKXCj0Clz5qEp6FP6wuPBmMCSq8A==
X-Received: by 2002:a02:7115:0:b0:2fa:a6d9:9e10 with SMTP id n21-20020a027115000000b002faa6d99e10mr16234152jac.293.1648610046447;
        Tue, 29 Mar 2022 20:14:06 -0700 (PDT)
Received: from sckzor-linux (d4-50-247-168.col.wideopenwest.com. [50.4.168.247])
        by smtp.gmail.com with ESMTPSA id y11-20020a92d80b000000b002c880174e40sm8191734ilm.57.2022.03.29.20.14.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Mar 2022 20:14:06 -0700 (PDT)
Date:   Tue, 29 Mar 2022 23:14:05 -0400
From:   Charlie Sands <sandsch@northvilleschools.net>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH] staging: r8188eu: Fix sparse endianness warnings.
Message-ID: <YkPK/QmLAp3BkygY@sckzor-linux.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes sparse warnings about the endianness of different
integers in the driver.

Signed-off-by: Charlie Sands <sandsch@northvilleschools.net>
---
 drivers/staging/r8188eu/core/rtw_br_ext.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_br_ext.c b/drivers/staging/r8188eu/core/rtw_br_ext.c
index d68611ef22f8..ed41c4e30262 100644
--- a/drivers/staging/r8188eu/core/rtw_br_ext.c
+++ b/drivers/staging/r8188eu/core/rtw_br_ext.c
@@ -70,7 +70,7 @@ static int __nat25_add_pppoe_tag(struct sk_buff *skb, struct pppoe_tag *tag)
 	struct pppoe_hdr *ph = (struct pppoe_hdr *)(skb->data + ETH_HLEN);
 	int data_len;
 
-	data_len = tag->tag_len + TAG_HDR_LEN;
+	data_len = be16_to_cpu(tag->tag_len) + TAG_HDR_LEN;
 	if (skb_tailroom(skb) < data_len)
 		return -1;
 
@@ -432,7 +432,7 @@ int nat25_db_handle(struct adapter *priv, struct sk_buff *skb, int method)
 		/*                Handle PPPoE frame                 */
 		/*---------------------------------------------------*/
 		struct pppoe_hdr *ph = (struct pppoe_hdr *)(skb->data + ETH_HLEN);
-		unsigned short *pMagic;
+		__be16 *pMagic;
 
 		switch (method) {
 		case NAT25_CHECK:
@@ -471,7 +471,7 @@ int nat25_db_handle(struct adapter *priv, struct sk_buff *skb, int method)
 						tag->tag_len = htons(MAGIC_CODE_LEN+RTL_RELAY_TAG_LEN+old_tag_len);
 
 						/*  insert the magic_code+client mac in relay tag */
-						pMagic = (unsigned short *)tag->tag_data;
+						pMagic = (__be16 *)tag->tag_data;
 						*pMagic = htons(MAGIC_CODE);
 						memcpy(tag->tag_data+MAGIC_CODE_LEN, skb->data+ETH_ALEN, ETH_ALEN);
 
@@ -557,9 +557,11 @@ int nat25_db_handle(struct adapter *priv, struct sk_buff *skb, int method)
 						struct icmp6hdr  *hdr = (struct icmp6hdr *)(skb->data + ETH_HLEN + sizeof(*iph));
 						hdr->icmp6_cksum = 0;
 						hdr->icmp6_cksum = csum_ipv6_magic(&iph->saddr, &iph->daddr,
-										iph->payload_len,
+										be16_to_cpu(iph->payload_len),
 										IPPROTO_ICMPV6,
-										csum_partial((__u8 *)hdr, iph->payload_len, 0));
+										csum_partial((__u8 *)hdr,
+										be16_to_cpu(iph->payload_len),
+										0));
 					}
 				}
 			}
-- 
2.35.1

