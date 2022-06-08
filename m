Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75A2F543B64
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jun 2022 20:22:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234367AbiFHSW0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jun 2022 14:22:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234454AbiFHSWT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jun 2022 14:22:19 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DF3E737BC
        for <linux-kernel@vger.kernel.org>; Wed,  8 Jun 2022 11:22:17 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id q15so21374569wrc.11
        for <linux-kernel@vger.kernel.org>; Wed, 08 Jun 2022 11:22:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=CqFfK/K7lvMu2HZST0PsePn93HOEe9I/dMiXVfj24uU=;
        b=oLqhFZfLib2k1MEIDIJcOGQBCwww65p2chr7rI+RMKUcA1rG3r1MuTFixwFRb3b5sK
         +CjQxCkw5ZzQS7QGbT3ZHDgI9i2L3+r6YonwRjhqwgoCJ42LK2ygEAS01iDcbDcYaldg
         PvcIaOEhHRSiUGM6090LrCKZ9GIK8xlxmI4KP6f8eFoYDYM1gZw8GqIYNQ4MkkvO2usV
         ofjQe5j/XRShIcIc1tnaSN79SkPwk3V2LDIXuelyzvVQVEiKjUSnvppH5R/plCki6/NR
         V+pOI6Ey/Yp/TZLktgdMM+5MEteWXgmrY3RqsezGjY2Nz/xYqsV/L8dyRxBEdaLx0b33
         viLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=CqFfK/K7lvMu2HZST0PsePn93HOEe9I/dMiXVfj24uU=;
        b=wNmoRuSNuoH9Uh5u4kXyjgHIuJoLl3omCoElEF2rvmoxMWe5VBvV8iLI1RwiHbk5NO
         RQ0vD3CPkxXk3Gfd22WRrDw4tpAlMesDU5MJ/j9mIejpVJld2hIpoWtvwOAKNc78W21c
         XVIygZZYN/pGNib/QEWZgxNrPiBxXPCVTBgfZY9fEGpIV2Mo3K58fj7d4P+Vu3cEVJaP
         BzzE1XxXaIj43xUnDEGHaFlWev5TQlyhhJw06dhBSifKZgZykvsya7di1UUv6TtOcJ6J
         y3hcKbuo/v9IesD+NnmusVjprlioqYM1j1oA6zOnB/vlG/6FrCEIkE1/Ej3KLKQUIFSC
         9Vyg==
X-Gm-Message-State: AOAM532UDjURaTeM2oJdcV5wRgKscqKSSScYv3B6DU+QKpvpRrQtubRQ
        PlWOUMmI++p6gASY7CWzfGXktkBX+n1sfQ==
X-Google-Smtp-Source: ABdhPJz+WFrYwbvqOsH2U2JLdTRztWjwS7FgP76BcReTg1Gqwlmp2MWWceSAMPxN78PbJ7ikZmdoew==
X-Received: by 2002:adf:f38f:0:b0:210:30cf:6e4a with SMTP id m15-20020adff38f000000b0021030cf6e4amr35808095wro.676.1654712535630;
        Wed, 08 Jun 2022 11:22:15 -0700 (PDT)
Received: from localhost ([2a00:79e0:9d:4:5a2c:fb4d:393:7e96])
        by smtp.gmail.com with ESMTPSA id f18-20020a5d4dd2000000b0020fd392df33sm22145050wru.29.2022.06.08.11.22.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jun 2022 11:22:14 -0700 (PDT)
From:   Jann Horn <jannh@google.com>
To:     Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>
Cc:     Hyeonggon Yoo <42.hyeyoo@gmail.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] mm/slub: add missing TID updates on slab deactivation
Date:   Wed,  8 Jun 2022 20:22:05 +0200
Message-Id: <20220608182205.2945720-1-jannh@google.com>
X-Mailer: git-send-email 2.36.1.476.g0c4daa206d-goog
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The fastpath in slab_alloc_node() assumes that c->slab is stable as long as
the TID stays the same. However, two places in __slab_alloc() currently
don't update the TID when deactivating the CPU slab.

If multiple operations race the right way, this could lead to an object
getting lost; or, in an even more unlikely situation, it could even lead to
an object being freed onto the wrong slab's freelist, messing up the
`inuse` counter and eventually causing a page to be freed to the page
allocator while it still contains slab objects.

(I haven't actually tested these cases though, this is just based on
looking at the code. Writing testcases for this stuff seems like it'd be
a pain...)

The race leading to state inconsistency is (all operations on the same CPU
and kmem_cache):

 - task A: begin do_slab_free():
    - read TID
    - read pcpu freelist (=3D=3DNULL)
    - check `slab =3D=3D c->slab` (true)
 - [PREEMPT A->B]
 - task B: begin slab_alloc_node():
    - fastpath fails (`c->freelist` is NULL)
    - enter __slab_alloc()
    - slub_get_cpu_ptr() (disables preemption)
    - enter ___slab_alloc()
    - take local_lock_irqsave()
    - read c->freelist as NULL
    - get_freelist() returns NULL
    - write `c->slab =3D NULL`
    - drop local_unlock_irqrestore()
    - goto new_slab
    - slub_percpu_partial() is NULL
    - get_partial() returns NULL
    - slub_put_cpu_ptr() (enables preemption)
 - [PREEMPT B->A]
 - task A: finish do_slab_free():
    - this_cpu_cmpxchg_double() succeeds()
    - [CORRUPT STATE: c->slab=3D=3DNULL, c->freelist!=3DNULL]


From there, the object on c->freelist will get lost if task B is allowed to
continue from here: It will proceed to the retry_load_slab label,
set c->slab, then jump to load_freelist, which clobbers c->freelist.


But if we instead continue as follows, we get worse corruption:

 - task A: run __slab_free() on object from other struct slab:
    - CPU_PARTIAL_FREE case (slab was on no list, is now on pcpu partial)
 - task A: run slab_alloc_node() with NUMA node constraint:
    - fastpath fails (c->slab is NULL)
    - call __slab_alloc()
    - slub_get_cpu_ptr() (disables preemption)
    - enter ___slab_alloc()
    - c->slab is NULL: goto new_slab
    - slub_percpu_partial() is non-NULL
    - set c->slab to slub_percpu_partial(c)
    - [CORRUPT STATE: c->slab points to slab-1, c->freelist has objects
      from slab-2]
    - goto redo
    - node_match() fails
    - goto deactivate_slab
    - existing c->freelist is passed into deactivate_slab()
    - inuse count of slab-1 is decremented to account for object from
      slab-2

At this point, the inuse count of slab-1 is 1 lower than it should be.
This means that if we free all allocated objects in slab-1 except for one,
SLUB will think that slab-1 is completely unused, and may free its page,
leading to use-after-free.

Fixes: c17dda40a6a4e ("slub: Separate out kmem_cache_cpu processing from de=
activate_slab")
Fixes: 03e404af26dc2 ("slub: fast release on full slab")
Cc: stable@vger.kernel.org
Signed-off-by: Jann Horn <jannh@google.com>
---
 mm/slub.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/mm/slub.c b/mm/slub.c
index e5535020e0fdf..b97fa5e210469 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -2936,6 +2936,7 @@ static void *___slab_alloc(struct kmem_cache *s, gfp_=
t gfpflags, int node,
=20
 	if (!freelist) {
 		c->slab =3D NULL;
+		c->tid =3D next_tid(c->tid);
 		local_unlock_irqrestore(&s->cpu_slab->lock, flags);
 		stat(s, DEACTIVATE_BYPASS);
 		goto new_slab;
@@ -2968,6 +2969,7 @@ static void *___slab_alloc(struct kmem_cache *s, gfp_=
t gfpflags, int node,
 	freelist =3D c->freelist;
 	c->slab =3D NULL;
 	c->freelist =3D NULL;
+	c->tid =3D next_tid(c->tid);
 	local_unlock_irqrestore(&s->cpu_slab->lock, flags);
 	deactivate_slab(s, slab, freelist);
=20

base-commit: 9886142c7a2226439c1e3f7d9b69f9c7094c3ef6
--=20
2.36.1.476.g0c4daa206d-goog

