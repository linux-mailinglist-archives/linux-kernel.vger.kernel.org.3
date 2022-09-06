Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5E0E5AF0E9
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 18:45:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233116AbiIFQoZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 12:44:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232975AbiIFQnd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 12:43:33 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96A22959E
        for <linux-kernel@vger.kernel.org>; Tue,  6 Sep 2022 09:21:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1662481298;
        bh=uz87CgceYBbO2OhWDcPevEI1vdwZq53H6Z0g3t5ePO4=;
        h=X-UI-Sender-Class:Subject:From:To:Cc:Date;
        b=PrYFJsmdD5GB0hsm8t5MyUVBYc1AFD78TPva5a61EaCBoxo8OVwIb/JxQVdsUNf2h
         ob3FJCoZxVnH26tqCacelqBiMCoGup6dVRcTFxYv/cdii+vvelq3Q8+8IsWAajxP+B
         A9GqSvMdYZBS6pNbbPdC1tEwEwGzBmVjYVhFrLto=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from homer.fritz.box ([185.221.150.184]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MNsw4-1okvHu2Yem-00OJSZ; Tue, 06
 Sep 2022 18:21:38 +0200
Message-ID: <9f593b8ac1b731cbbf92dc1c7b497b668752b325.camel@gmx.de>
Subject: 307af6c879377 "mbcache: automatically delete entries from cache on
 freeing" ==> PREEMPT_RT grumble
From:   Mike Galbraith <efault@gmx.de>
To:     Jan Kara <jack@suse.cz>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Date:   Tue, 06 Sep 2022 18:21:37 +0200
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Ae1N0W/StEUfza6/Jal2zXaHgK509gqRdVi7l8Ey93lKUsgSOve
 05mP4I/V8cBZhjUgrTZaVH7W0insSFdqrfgR4jSQDGZvu7cnzwV8LwfeBaVnefa9IVletgL
 xW/PyY7tM7a2X1NUMveoFiC9FGB62jnHcaZSSUzB2zirZu9TIHJpe5wdlAInL+pX1lhhX6+
 MGLOUUCVrE6uRDtr3fwWw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:xl0kwGdufbw=:FofzA+lKQhgNb6DPjAStB0
 p72IdW0iNSzEuQZz4PokQzcEJAb3sb2WbJCgY4YkJr/EQ5cISnf/MZXtsSUHd+Kb2Ydu5k0Y9
 KgybUlxYBmno6GST5n/fhM7YXR1lgUUCqgfxxLEqPhWuUeQPMfMgrtRF2+xroDLxrrQvPqP5h
 eKedFecU4GRcEs1ItycX3cU8FjIyaIYRuJXQDvteMssx6X2zrzJFXIUrqYY2pURZNMyZKUBXp
 EgB4YYmb2PXFrF1/zJ4QwqV3oDR020hywHVAhMh0NFkFm/+HHzGK5uv07iTKpgcONF/oEXfXj
 F2hw6UqkeVJutid7FvyJtiB2rGDIyYM4w1OcLv9fMNxxJSxZAhl2ts07sX1zjR2mCbEKcz+Ci
 vpEBvFQLoiEzOuytqdF1s73Yac7Cjo0+HToHjhjCpKo4SYNvV4JlQNVK4wk0D1rV9051kkizQ
 xVj+NhzTJgj9HuyCmIDSlyAM/e9O3XbOo81dDFqOKlqRWXje6TsN5Tb1dvs/GrpOigah+/iUq
 vmS9Fx1vsCNvbVTgHOrWpXMeLzTOPigqBBXtgq33idbAseMzwz/3nfFsowwEF3xaIGDDowlvy
 ImFWtq84fusfqFZD0whr0rUmFZ3tnRd2P31aPoDKrZP9ltClFgHtxiJp+NN83KPMbC/x2y0M9
 CNN2vdBqpkhBU3KB9dVOcEQ1dVVtGi6hS/uWmv8iHaQGmzTv+k5bgbnl3OMPyvhhbSRpXoSk6
 qJeBOw0RtCm6I+x0/q3Svlg9W/dOZZmTp5c8pIymQ/uZ9RdfFka5qe2tEGTJj6f6/H3dtbF4K
 fO3sUpenfQthP2wbAcxTRIkwQE3bSi2pu9v5KvvUyT40S+i8lTd0422NJAcs7eLinZQXz0c4C
 5jRf/jcwvEDvNwFrvkkiEC2ZKeFwVqBvtwxTqyTtnLW4WTmT9mD3LMAePJdE8zmlWztLhIEaM
 w+P3T/nQp1kmBhlj4Tt6JBEWABPgmw3E4ARC1Hw7ipzFTI0mNZE3PdJywa6PvDWkfKP1EnKRq
 nNiYfhgw45+QImjx5g06RwT/p64ufRyz0lBs9tVq2UKz6LU5t86isXwiPMi9nqo7mlOC31Xyz
 czrA8FvqWRIzzA35aI+Ns7FmllR2TQ9icMvuHYx8u5crP+PE77hooJxIufVYYnuC2zVLm24H8
 AVfv2JzuPCEg1jKVH9DUoOiKmx
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jan,

diff --git a/fs/mbcache.c b/fs/mbcache.c
index d1ebb5df2856..96f1d49d30a5 100644
=2D-- a/fs/mbcache.c
+++ b/fs/mbcache.c
@ -106,21 +106,28 @@ int mb_cache_entry_create(struct mb_cache *cache, gfp=
_t mask, u32 key,
 		}
 	}
 	hlist_bl_add_head(&entry->e_hash_list, head);
-	hlist_bl_unlock(head);
-
+	/*
+	 * Add entry to LRU list before it can be found by
+	 * mb_cache_entry_delete() to avoid races
+	 */
 	spin_lock(&cache->c_list_lock);
 	list_add_tail(&entry->e_list, &cache->c_list);
-	/* Grab ref for LRU list */
-	atomic_inc(&entry->e_refcnt);
 	cache->c_entry_count++;
 	spin_unlock(&cache->c_list_lock);
+	hlist_bl_unlock(head);

 	return 0;
 }
 EXPORT_SYMBOL(mb_cache_entry_create);

The above movement of hlist_bl_unlock() is a problem for RT wrt both
taking and releasing of ->c_list_lock, it becoming an rtmutex in RT and
hlist_bl_unlock() taking a preemption blocking bit spinlock.

Is that scope increase necessary?  If so, looks like ->c_list_lock
could probably become a raw_spinlock_t without anyone noticing.

	-Mike
