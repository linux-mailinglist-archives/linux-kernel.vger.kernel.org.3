Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E68052E3CF
	for <lists+linux-kernel@lfdr.de>; Fri, 20 May 2022 06:34:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234339AbiETEdp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 May 2022 00:33:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239676AbiETEdm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 May 2022 00:33:42 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 58C025F261
        for <linux-kernel@vger.kernel.org>; Thu, 19 May 2022 21:33:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1653021219;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=1xG+mMcwGEN5XJMWaqhoEuXIw7t293hEIaVOvS4m0iY=;
        b=Nc+BxR93rOqZctssgkjCTJLcGUhkUd033HEBPHtlc/H5RqZzAHGAGPVRoY0aWpe+a3OCYd
        78+TaEmfHcUfUOowZpLXpXT6Wb07/LRPMdlrB5FcWFXC3t15sjyL4cviuRMw8fM40hBkge
        c0jAKHiENQrVUbugkIllRMoFXD439EI=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-205-h6Fig9C-M2y92jb6AIGjmQ-1; Fri, 20 May 2022 00:33:35 -0400
X-MC-Unique: h6Fig9C-M2y92jb6AIGjmQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 116C02949BA9;
        Fri, 20 May 2022 04:33:35 +0000 (UTC)
Received: from rh (vpn2-54-35.bne.redhat.com [10.64.54.35])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 21A042011C79;
        Fri, 20 May 2022 04:33:34 +0000 (UTC)
Received: from localhost ([::1] helo=rh)
        by rh with esmtps  (TLS1.3) tls TLS_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <dchinner@redhat.com>)
        id 1nruKR-001Ult-34; Fri, 20 May 2022 14:33:31 +1000
Date:   Fri, 20 May 2022 14:33:29 +1000
From:   Dave Chinner <dchinner@redhat.com>
To:     Roman Gushchin <roman.gushchin@linux.dev>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Kent Overstreet <kent.overstreet@gmail.com>,
        Hillf Danton <hdanton@sina.com>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: Re: [PATCH v3 0/6] mm: introduce shrinker debugfs interface
Message-ID: <YocaGTFTB4qLuSw3@rh>
References: <20220509183820.573666-1-roman.gushchin@linux.dev>
 <YoZ7GA9cjQiylEP7@carbon>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YoZ7GA9cjQiylEP7@carbon>
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.4
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 19, 2022 at 10:15:04AM -0700, Roman Gushchin wrote:
> On Mon, May 09, 2022 at 11:38:14AM -0700, Roman Gushchin wrote:
> > There are 50+ different shrinkers in the kernel, many with their own bells and
> > whistles. Under the memory pressure the kernel applies some pressure on each of
> > them in the order of which they were created/registered in the system. Some
> > of them can contain only few objects, some can be quite large. Some can be
> > effective at reclaiming memory, some not.
> > 
> > The only existing debugging mechanism is a couple of tracepoints in
> > do_shrink_slab(): mm_shrink_slab_start and mm_shrink_slab_end. They aren't
> > covering everything though: shrinkers which report 0 objects will never show up,
> > there is no support for memcg-aware shrinkers. Shrinkers are identified by their
> > scan function, which is not always enough (e.g. hard to guess which super
> > block's shrinker it is having only "super_cache_scan").
> > 
> > To provide a better visibility and debug options for memory shrinkers
> > this patchset introduces a /sys/kernel/debug/shrinker interface, to some extent
> > similar to /sys/kernel/slab.
> > 
> > For each shrinker registered in the system a directory is created.
> > As now, the directory will contain only a "scan" file, which allows to get
> > the number of managed objects for each memory cgroup (for memcg-aware shrinkers)
> > and each numa node (for numa-aware shrinkers on a numa machine). Other
> > interfaces might be added in the future.
> > 
> > To make debugging more pleasant, the patchset also names all shrinkers,
> > so that debugfs entries can have meaningful names.
> > 
> > 
> > v3:
> >   1) separated the "scan" part into a separate patch, by Dave
> >   2) merged *_memcg, *_node and *_memcg_node interfaces, by Dave
> >   3) shrinkers naming enhancements, by Christophe and Dave
> >   4) added signal_pending() check, by Hillf
> >   5) enabled by default, by Dave
> 
> Any comments? Thoughts? Objections?

I have no time available to look at this right now, and won't for a
while.

Cheers,

Dave.
-- 
Dave Chinner
dchinner@redhat.com

