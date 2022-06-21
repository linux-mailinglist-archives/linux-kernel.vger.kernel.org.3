Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D93DB55360B
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jun 2022 17:26:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351189AbiFUP0H convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 21 Jun 2022 11:26:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350387AbiFUP0B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jun 2022 11:26:01 -0400
Received: from relay.hostedemail.com (smtprelay0017.hostedemail.com [216.40.44.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF8042A951
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jun 2022 08:26:00 -0700 (PDT)
Received: from omf14.hostedemail.com (a10.router.float.18 [10.200.18.1])
        by unirelay13.hostedemail.com (Postfix) with ESMTP id DF469602B7;
        Tue, 21 Jun 2022 15:25:59 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf14.hostedemail.com (Postfix) with ESMTPA id C136633;
        Tue, 21 Jun 2022 15:25:58 +0000 (UTC)
Message-ID: <aa1a96b7141cdf88648de84a0e51896fba23d65c.camel@perches.com>
Subject: Re: [PATCH] Staging: rtl8192e: make sizeof type-independent
From:   Joe Perches <joe@perches.com>
To:     Felix Schlepper <f3sch.git@outlook.com>, gregkh@linuxfoundation.org
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Date:   Tue, 21 Jun 2022 08:25:57 -0700
In-Reply-To: <AM9P190MB1299D518C86D495B168954B2A5B39@AM9P190MB1299.EURP190.PROD.OUTLOOK.COM>
References: <AM9P190MB1299D518C86D495B168954B2A5B39@AM9P190MB1299.EURP190.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.44.1-0ubuntu1 
MIME-Version: 1.0
X-Rspamd-Queue-Id: C136633
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=no
        autolearn_force=no version=3.4.6
X-Stat-Signature: 3redqn4duodack9r4tfxoy1kjbsey4r3
X-Rspamd-Server: rspamout02
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX1/Gd2h38M+HMuAhZt6MzRncn/Cp1goTE90=
X-HE-Tag: 1655825158-138843
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2022-06-21 at 16:58 +0200, Felix Schlepper wrote:
> Making sizeof operator type-independent.
> 
> Reported by checkpatch:
> 
> CHECK: Prefer kmalloc(sizeof(*txb)...) over
>         kmalloc(sizeof(struct rtllib_txb)...)
> 
> ---
> Note: First patch, trying to follow kernelnewbies tutorial.

Congrats on the first patch, but know that checkpatch is a stupid
script and it doesn't necessarily offer the best advice.

A helper mechanism exists that should be preferred over checkpatch's
advice...

> diff --git a/drivers/staging/rtl8192e/rtllib_tx.c b/drivers/staging/rtl8192e/rtllib_tx.c
[]
> @@ -205,8 +205,7 @@ static struct rtllib_txb *rtllib_alloc_txb(int nr_frags, int txb_size,
>  	struct rtllib_txb *txb;
>  	int i;
>  
> -	txb = kmalloc(sizeof(struct rtllib_txb) + (sizeof(u8 *) * nr_frags),
> -		      gfp_mask);
> +	txb = kmalloc(sizeof(*txb) + (sizeof(u8 *) * nr_frags), gfp_mask);

Use struct_size() instead, something like:

	txb = kmalloc(struct_size(txb, fragments, nr_frags), gfp_mask);

>  	if (!txb)
>  		return NULL;
>  

though I would also suggest using kzalloc as safer against memory
initialization defects (and could remove a memset here).

Perhaps something like:
---
 drivers/staging/rtl8192e/rtllib_tx.c | 24 +++++++++++-------------
 1 file changed, 11 insertions(+), 13 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtllib_tx.c b/drivers/staging/rtl8192e/rtllib_tx.c
index 37715afb0210d..bcccde91fa0bd 100644
--- a/drivers/staging/rtl8192e/rtllib_tx.c
+++ b/drivers/staging/rtl8192e/rtllib_tx.c
@@ -205,30 +205,28 @@ static struct rtllib_txb *rtllib_alloc_txb(int nr_frags, int txb_size,
 	struct rtllib_txb *txb;
 	int i;
 
-	txb = kmalloc(sizeof(struct rtllib_txb) + (sizeof(u8 *) * nr_frags),
-		      gfp_mask);
+	txb = kzalloc(struct_size(txb, fragments, nr_frags), gfp_mask);
 	if (!txb)
 		return NULL;
 
-	memset(txb, 0, sizeof(struct rtllib_txb));
 	txb->nr_frags = nr_frags;
 	txb->frag_size = cpu_to_le16(txb_size);
 
 	for (i = 0; i < nr_frags; i++) {
 		txb->fragments[i] = dev_alloc_skb(txb_size);
-		if (unlikely(!txb->fragments[i])) {
-			i--;
-			break;
-		}
+		if (!txb->fragments[i])
+			goto err_free;
 		memset(txb->fragments[i]->cb, 0, sizeof(txb->fragments[i]->cb));
 	}
-	if (unlikely(i != nr_frags)) {
-		while (i >= 0)
-			dev_kfree_skb_any(txb->fragments[i--]);
-		kfree(txb);
-		return NULL;
-	}
+
 	return txb;
+
+err_free:
+	while (i > 0)
+		dev_kfree_skb_any(txb->fragments[--i]);
+	kfree(txb);
+
+	return NULL;
 }
 
 static int rtllib_classify(struct sk_buff *skb, u8 bIsAmsdu)

