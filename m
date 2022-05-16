Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FD82528D7F
	for <lists+linux-kernel@lfdr.de>; Mon, 16 May 2022 20:53:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345176AbiEPSxj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 May 2022 14:53:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232386AbiEPSxh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 May 2022 14:53:37 -0400
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E7CB3EABB
        for <linux-kernel@vger.kernel.org>; Mon, 16 May 2022 11:53:36 -0700 (PDT)
Received: by mail-lj1-x230.google.com with SMTP id g16so19255122lja.3
        for <linux-kernel@vger.kernel.org>; Mon, 16 May 2022 11:53:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvz-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:from:subject:to:cc
         :content-language:content-transfer-encoding;
        bh=nuaRCyZ3f8/tAk5NBkEcb+gaJ9vpmmFYS74QQLXNLAk=;
        b=uHW2EOknJrrdEJKCG/9WPjfw9+6HT1KxNEanFdBQTCPYnK+1353SmGzP9S4QOZIkBM
         USeZ6AT9OmZ1K/5kggz51UgdnUpkAKg5hiZxDmRECbfTH7AUbRw0vfesKIX5WCM140pa
         1lzo6/pJrYfCkGtdWfIO/olD1whWCjh70BZ+vzfstWpzXGH/S8Vva2BtDXFWv32Zq9X7
         VfXEvKtN8dWYgZSekKRsgMYcLiftUAQwGhES7+8UCu9rwRvDqFGZWoXBjPu//0DHBMYw
         +F/B0aOwFrSH9r7lDT0Sb/zV/FNIpGYLQu/tSluvf7mGdOyZWQJPsXZsSQDf4tJ2qANp
         GSIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:from
         :subject:to:cc:content-language:content-transfer-encoding;
        bh=nuaRCyZ3f8/tAk5NBkEcb+gaJ9vpmmFYS74QQLXNLAk=;
        b=nm2rIoyE/0o+A2hszPgay9Tft8m6xAvU8e3YElTC9Uu8VjGWG6Nl+87YLiiUIVp8RH
         Bzf4z/2aJ0gJqRFRDLvYOes2rNscE7MbXVmFojb3GVP/wh9WDYz6BURCAO3Y75VBrydI
         UY0PS4YYcxfMctxmZE1oIOa1kYErgDuAV/cOYrGlkhCBkh0Vp8aHSLoW9Rpb+NBdNnn+
         NyqDl6XI0sfkqxD9oXHAl/Sim2E3k+wN8hkbrs02YST973RLIKTsmmgX+h32yDnPntiu
         LxM/rTcIMolj3CnjvyxXf+IlQa9SDxMzjBmkxxL8fLHO13w2n/SqS4vmJDxZH0+gav7C
         7XUg==
X-Gm-Message-State: AOAM531WS7ioXAvnW1DkPPFT7UGed58N2TbbwP5ZFhow17AGDi6R4093
        yDcKBICDat6tLYNZtBttvcpd4g==
X-Google-Smtp-Source: ABdhPJww7Y9nENr1+mTatkIp+n0/Fh5qQaeQBoLLg5apVauQaouQWDA2JQ+MZO6Cwh5vfN1CWSnZ0A==
X-Received: by 2002:a2e:9dc8:0:b0:24f:d84:3001 with SMTP id x8-20020a2e9dc8000000b0024f0d843001mr11931801ljj.435.1652727214669;
        Mon, 16 May 2022 11:53:34 -0700 (PDT)
Received: from [192.168.1.72] (46-138-221-128.dynamic.spd-mgts.ru. [46.138.221.128])
        by smtp.gmail.com with ESMTPSA id w8-20020a2e3008000000b00250664c906asm1639086ljw.133.2022.05.16.11.53.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 May 2022 11:53:34 -0700 (PDT)
Message-ID: <1fd21e25-b095-e055-fc2e-abda640a0575@openvz.org>
Date:   Mon, 16 May 2022 21:53:32 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
From:   Vasily Averin <vvs@openvz.org>
Subject: [PATCH] tracing: add ACCOUNT flag for allocations from marked slab
 caches
To:     Roman Gushchin <roman.gushchin@linux.dev>,
        Vlastimil Babka <vbabka@suse.cz>,
        Andrew Morton <akpm@linux-foundation.org>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        David Rientjes <rientjes@google.com>,
        Pekka Enberg <penberg@kernel.org>,
        Christoph Lameter <cl@linux.com>
Cc:     kernel@openvz.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Shakeel Butt <shakeelb@google.com>,
        Michal Hocko <mhocko@suse.com>
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Slab caches marked with SLAB_ACCOUNT force accounting for every
allocation from this cache even if __GFP_ACCOUNT flag is not passed.
Unfortunately, at the moment this flag is not visible in ftrace output,
and this makes it difficult to analyze the accounted allocations.

This patch adds the __GFP_ACCOUNT flag for allocations from slab caches
marked with SLAB_ACCOUNT to the ftrace output.

Signed-off-by: Vasily Averin <vvs@openvz.org>
---
 mm/slab.c | 3 +++
 mm/slub.c | 3 +++
 2 files changed, 6 insertions(+)

diff --git a/mm/slab.c b/mm/slab.c
index 0edb474edef1..4c3da8dfcbdb 100644
--- a/mm/slab.c
+++ b/mm/slab.c
@@ -3492,6 +3492,9 @@ void *__kmem_cache_alloc_lru(struct kmem_cache *cachep, struct list_lru *lru,
 {
 	void *ret = slab_alloc(cachep, lru, flags, cachep->object_size, _RET_IP_);
 
+	if (cachep->flags & SLAB_ACCOUNT)
+		flags |= __GFP_ACCOUNT;
+
 	trace_kmem_cache_alloc(_RET_IP_, ret,
 			       cachep->object_size, cachep->size, flags);
 
diff --git a/mm/slub.c b/mm/slub.c
index ed5c2c03a47a..670bbfef9e49 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -3231,6 +3231,9 @@ void *__kmem_cache_alloc_lru(struct kmem_cache *s, struct list_lru *lru,
 {
 	void *ret = slab_alloc(s, lru, gfpflags, _RET_IP_, s->object_size);
 
+	if (s->flags & SLAB_ACCOUNT)
+		gfpflags |= __GFP_ACCOUNT;
+
 	trace_kmem_cache_alloc(_RET_IP_, ret, s->object_size,
 				s->size, gfpflags);
 
-- 
2.25.1

