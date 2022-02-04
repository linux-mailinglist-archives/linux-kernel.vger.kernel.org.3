Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 365CB4AA394
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Feb 2022 23:54:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354384AbiBDWyP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Feb 2022 17:54:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353907AbiBDWyL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Feb 2022 17:54:11 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49C6CC06134A
        for <linux-kernel@vger.kernel.org>; Fri,  4 Feb 2022 14:54:09 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DFD2F61AC3
        for <linux-kernel@vger.kernel.org>; Fri,  4 Feb 2022 22:54:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC487C004E1;
        Fri,  4 Feb 2022 22:54:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1644015248;
        bh=FMqUl3+T/6TQy2UFloZ92sPUyidlI+1aclHeNhJbKq0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Dl4lhUPI82W/mGfvO5IOe92HmKMiwEwhBnvpoAxBzjUtw11b7qg+LxFnQtiSknQm0
         75AffvOzgTava/+uSWhbj2MG9e8SCzrHgqiFrKKg/9tOHJE2zHqTXvuAoEBqGB9g59
         qKSY6n8Tt7NnwR1t1EHXIw84GCs7wj8b+Hl5d3Vs=
Date:   Fri, 4 Feb 2022 14:54:07 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Michal Hocko <mhocko@suse.com>
Cc:     Mike Rapoport <rppt@kernel.org>,
        Wei Yang <richard.weiyang@gmail.com>, linux-mm@kvack.org,
        LKML <linux-kernel@vger.kernel.org>,
        David Hildenbrand <david@redhat.com>,
        Alexey Makhalov <amakhalov@vmware.com>,
        Dennis Zhou <dennis@kernel.org>,
        Eric Dumazet <eric.dumazet@gmail.com>,
        Oscar Salvador <osalvador@suse.de>, Tejun Heo <tj@kernel.org>,
        Christoph Lameter <cl@linux.com>,
        Nico Pache <npache@redhat.com>,
        Rafael Aquini <raquini@redhat.com>
Subject: Re: [PATCH 2/6] mm: handle uninitialized numa nodes gracefully
Message-Id: <20220204145407.c32a405fd7e8dc281993e1aa@linux-foundation.org>
In-Reply-To: <YfuUxI3k27msAORC@dhcp22.suse.cz>
References: <20220127085305.20890-1-mhocko@kernel.org>
        <20220127085305.20890-3-mhocko@kernel.org>
        <YfKgE5hTgbaBeaMa@kernel.org>
        <YfKwjAlPW2kJUv5w@dhcp22.suse.cz>
        <20220201024119.2ailcw4rp5thambz@master>
        <YfkDXYhGjAvAKKeU@dhcp22.suse.cz>
        <20220203002116.akpk5um5nkpeflve@master>
        <YfuC6IaasxcnAdGl@kernel.org>
        <YfuUxI3k27msAORC@dhcp22.suse.cz>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.7 required=5.0 tests=BAYES_05,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 3 Feb 2022 09:39:32 +0100 Michal Hocko <mhocko@suse.com> wrote:

> > I shuffled the words a bit, maybe this sounds better not only to me :)
> > 
> > /*
> >  * We do not want to confuse userspace by sysfs files/directories for node
> >  * without any memory attached to it, so this node is not marked as
> >  * N_MEMORY and not marked online so that topology_init() won't create
> >  * sysfs hierarchy for this node.  The pgdat will get fully initialized by
> >  * hotadd_init_pgdat() when memory is hotpluged into this node
> >  */
> 
> Yes, I like this comment more than mine. Andrew could you replace it in
> your tree or should I repost the patch?

I did this.

--- a/mm/page_alloc.c~mm-handle-uninitialized-numa-nodes-gracefully-fix
+++ a/mm/page_alloc.c
@@ -8155,12 +8155,16 @@ void __init free_area_init(unsigned long
 			}
 			arch_refresh_nodedata(nid, pgdat);
 			free_area_init_memoryless_node(nid);
+
 			/*
-			 * not marking this node online because we do not want to
-			 * confuse userspace by sysfs files/directories for node
-			 * without any memory attached to it (see topology_init)
-			 * The pgdat will get fully initialized when a memory is
-			 * hotpluged into it by hotadd_init_pgdat
+			 * We do not want to confuse userspace by sysfs
+			 * files/directories for node without any memory
+			 * attached to it, so this node is not marked as
+			 * N_MEMORY and not marked online so that no sysfs
+			 * hierarchy will be created via register_one_node for
+			 * it. The pgdat will get fully initialized by
+			 * hotadd_init_pgdat() when memory is hotplugged into
+			 * this node.
 			 */
 			continue;
 		}
_

