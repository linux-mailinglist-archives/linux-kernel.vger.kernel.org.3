Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5250349DD02
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jan 2022 09:53:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238049AbiA0Ixe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jan 2022 03:53:34 -0500
Received: from mail-ej1-f53.google.com ([209.85.218.53]:39776 "EHLO
        mail-ej1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237928AbiA0IxX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jan 2022 03:53:23 -0500
Received: by mail-ej1-f53.google.com with SMTP id j2so4226764ejk.6
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jan 2022 00:53:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Yw/+DDZVAI1kM3jl62EkxWAhTt9qU97/TTaQLgANFqA=;
        b=FG1WbX44Jryj/pMeYJJtXJwuqIdIP3w2zHxf+WniEGuaw+1fNq8M1s7tUW2wexKHNK
         ivU/VXetxxd11KP7yzBd+RYGN6fDj09vMXswget/3G6GeyqbPbAI/5TpEwnjZ3MGLR5o
         DSNbTkPdVHvHNdFnTY/R12UtqfcuvNmmjji1mUUFTN6I8Yth4u8O2/qARrbojz1eE0ws
         Iho2kEpeXBiNjmxrZgsLo1fWh920SSZyfQTrKLQJ7tp5gNILqVUJAkgRPZ9JPKMz9Req
         kIusB7jWJO1Nsl+UHggJugcwkgaKbuZhX1T7yxpYOAhzPVuuxj+4oCMO5/6EHDcKXjQC
         RVIw==
X-Gm-Message-State: AOAM530sZ1u+WWAoIvn4L5EjXzTgO5D+qoXvetQj7jPevbMOKMEFSq2e
        odghPgYYR/r8d4QQG9GEhxnU8/a9S0k=
X-Google-Smtp-Source: ABdhPJxR/nkchzrmyjQR0DAh0Fch7YdSctIIC56sUAj9QFTJaDNlIHcSch+FL75+Y65K4z2NQOAw8g==
X-Received: by 2002:a17:907:94d5:: with SMTP id dn21mr2232871ejc.77.1643273602447;
        Thu, 27 Jan 2022 00:53:22 -0800 (PST)
Received: from localhost.localdomain (ip-85-160-47-31.eurotel.cz. [85.160.47.31])
        by smtp.gmail.com with ESMTPSA id n11sm11029757edv.52.2022.01.27.00.53.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jan 2022 00:53:21 -0800 (PST)
From:   Michal Hocko <mhocko@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     <linux-mm@kvack.org>, LKML <linux-kernel@vger.kernel.org>,
        David Hildenbrand <david@redhat.com>,
        Alexey Makhalov <amakhalov@vmware.com>,
        Dennis Zhou <dennis@kernel.org>,
        Eric Dumazet <eric.dumazet@gmail.com>,
        Oscar Salvador <osalvador@suse.de>, Tejun Heo <tj@kernel.org>,
        Christoph Lameter <cl@linux.com>,
        Nico Pache <npache@redhat.com>,
        Wei Yang <richard.weiyang@gmail.com>,
        Rafael Aquini <raquini@redhat.com>,
        Michal Hocko <mhocko@suse.com>
Subject: [PATCH 6/6] memcg: do not tweak node in alloc_mem_cgroup_per_node_info
Date:   Thu, 27 Jan 2022 09:53:05 +0100
Message-Id: <20220127085305.20890-7-mhocko@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220127085305.20890-1-mhocko@kernel.org>
References: <20220127085305.20890-1-mhocko@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Wei Yang <richard.weiyang@gmail.com>

alloc_mem_cgroup_per_node_info is allocated for each possible node and
this used to be a problem because not !node_online nodes didn't have
appropriate data structure allocated. This has changed by "mm: handle
uninitialized numa nodes gracefully" so we can drop the special casing
here.

Signed-off-by: Wei Yang <richard.weiyang@gmail.com>
Signed-off-by: Michal Hocko <mhocko@suse.com>
---
 mm/memcontrol.c | 14 ++------------
 1 file changed, 2 insertions(+), 12 deletions(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 09d342c7cbd0..8b3f9eef4c65 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -5067,18 +5067,8 @@ struct mem_cgroup *mem_cgroup_from_id(unsigned short id)
 static int alloc_mem_cgroup_per_node_info(struct mem_cgroup *memcg, int node)
 {
 	struct mem_cgroup_per_node *pn;
-	int tmp = node;
-	/*
-	 * This routine is called against possible nodes.
-	 * But it's BUG to call kmalloc() against offline node.
-	 *
-	 * TODO: this routine can waste much memory for nodes which will
-	 *       never be onlined. It's better to use memory hotplug callback
-	 *       function.
-	 */
-	if (!node_state(node, N_NORMAL_MEMORY))
-		tmp = -1;
-	pn = kzalloc_node(sizeof(*pn), GFP_KERNEL, tmp);
+
+	pn = kzalloc_node(sizeof(*pn), GFP_KERNEL, node);
 	if (!pn)
 		return 1;
 
-- 
2.30.2

