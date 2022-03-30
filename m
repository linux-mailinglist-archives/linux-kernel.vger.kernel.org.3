Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DB444ECCBD
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Mar 2022 20:53:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350427AbiC3SzA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Mar 2022 14:55:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350382AbiC3Syt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Mar 2022 14:54:49 -0400
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com [IPv6:2607:f8b0:4864:20::d2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBBD45FF32
        for <linux-kernel@vger.kernel.org>; Wed, 30 Mar 2022 11:52:55 -0700 (PDT)
Received: by mail-io1-xd2d.google.com with SMTP id r2so25839062iod.9
        for <linux-kernel@vger.kernel.org>; Wed, 30 Mar 2022 11:52:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=northvilleschools.net; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=csFzrGs94hc9ejuvCE+fZueUzzUfTyueT4QFad6sO7A=;
        b=kbnhEsKnagC3ws+rlRgd+RU28wvTNGRtMhsWmEWwmbYiqPqptlBL+A9mL7v0airgXu
         nctI+WMn3dDObMW9CsUdJpTlbW4vKrL5pBUyx2pjSAtqZVv+f4VoIF+urD25EjG4nG9u
         zLzFJIR4zoloxEVaPi2GQ7QjUEqZ9P2Zo2he6oaRZpKVsIm/s2LjMtk1F6dvaljt9fHj
         O23mashsppwcbvWYUVZkgQs9nBEuiiElBXVO4KUIO2L6k/7d83gLBgZfI/FJ1ci/tLVu
         sdfVNmsRF/qL4/DMVmAdkYk56XSbbKN/ryP/n2Us/yIx2PBPQQg8HII6vraxFFJ72lWN
         sMOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=csFzrGs94hc9ejuvCE+fZueUzzUfTyueT4QFad6sO7A=;
        b=OOYHZSVZbiLgsEv/8ClzNZKnNXPKy67lnUVjPSE3WirvAtCQu/ckLy/HtaAAOJ4zz6
         uc0KJXl1p4AbrZt5K8fAZGxGb7fs3/APHdehj2WTYlwZCVAAD/E+xUlO7P3GVvc6NnzA
         5z2MgAYEhVTk3Y7GWlQOlAB38fvEt6vptS/NCO1xOj3Fmxzxea66B6bSVDAdkLX0oOVF
         F7LcdOpJawLzZMZ0FeEJNpJZD+z9RJUlKuNp4g17HifLxaLh300G9pkb0EwBzCnyGJNL
         Se/xfjtlXWsi0m+LAvcXiZuqu+ZBV6HITNidzx/TtDLFi8EzUyS96GErzejyjqXc5ESC
         vXYA==
X-Gm-Message-State: AOAM530hvTJ4AvAG6i09Jp+H0a30MmNgxDg92fHCekYliBgbL4Jgs4as
        T8SibhW3EGeB8cDS14dp7YZCiNEKZ5i+36Hb
X-Google-Smtp-Source: ABdhPJzf+QgapgXK+iZ4oLIAi54xyUI7HuBOe15v2PKWDvHqC3zBMwB3TdP35jII066WX2V1hkbzwQ==
X-Received: by 2002:a6b:14a:0:b0:649:a974:9042 with SMTP id 71-20020a6b014a000000b00649a9749042mr12139250iob.81.1648666375278;
        Wed, 30 Mar 2022 11:52:55 -0700 (PDT)
Received: from sckzor-linux (d4-50-247-168.col.wideopenwest.com. [50.4.168.247])
        by smtp.gmail.com with ESMTPSA id k5-20020a6bf705000000b00649a2634725sm11587364iog.17.2022.03.30.11.52.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Mar 2022 11:52:54 -0700 (PDT)
Date:   Wed, 30 Mar 2022 14:52:53 -0400
From:   Charlie Sands <sandsch@northvilleschools.net>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        dan.carpenter@oracle.com
Subject: [PATCH V2] staging: r8188eu: Fix sparse endianness warnings
Message-ID: <YkSnBW70kruOyN9h@sckzor-linux.localdomain>
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
pieces of data in the driver.

Fixes: 15865124feed ("staging: r8188eu: introduce new core dir for
RTL8188eu driver")
Signed-off-by: Charlie Sands <sandsch@northvilleschools.net>
---
V2: Added the "fixes" line to the commit at the request of Dan Carpenter.

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

