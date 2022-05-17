Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1314B52A398
	for <lists+linux-kernel@lfdr.de>; Tue, 17 May 2022 15:38:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347934AbiEQNiE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 May 2022 09:38:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346878AbiEQNh7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 May 2022 09:37:59 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 048664198E
        for <linux-kernel@vger.kernel.org>; Tue, 17 May 2022 06:37:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=40nH6wtaPQSKPcYfhRzm0nohHoI8B7JXQDWdeAfb0LM=; b=ZmhUd+DTB2IdZZo+5NYoVuK+/q
        hCaQHZ5E7hsxCJ73Jv1dv/2RIKwUzzLBanXefYUYfRR8oScViC+nxZsT342Qa818iBkowrJaQGgz7
        3izE9vtXhP6ahmKTtP2qbY388OFC84VQWA8QZUykGQ6jEe2ixqKVFF7C2/TA+xUiOE7pT8ICODeP+
        IAiyYNDfAp9gPNkUEJh0vRMmHgzRPhrvoOvyZGFSSJL3F7iFKt+zHVQQA0jgL0BuDvuq+PEhglRwp
        wQ+fSlRsuG6kF1dNxWYzmrB3He0+j81Dm4vpE6Ddc8/erheaRVaUlZmQnmlnOJEDtBdrJW1QUhcDN
        WTMp3rtA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nqxOV-00AtRa-6q; Tue, 17 May 2022 13:37:47 +0000
Date:   Tue, 17 May 2022 14:37:47 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     YoMccU66auLAPEHa@casper.infradead.org
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Shakeel Butt <shakeelb@google.com>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Vlastimil Babka <vbabka@suse.cz>, kernel@openvz.org,
        linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        David Rientjes <rientjes@google.com>,
        Pekka Enberg <penberg@kernel.org>,
        Christoph Lameter <cl@linux.com>,
        Michal Hocko <mhocko@suse.com>
Subject: Re: [PATCH v2] tracing: add ACCOUNT flag for allocations from marked
 slab caches
Message-ID: <YoOlK2r0v6VF8R7X@casper.infradead.org>
References: <8ef9de6a-7497-07f7-852c-befcc3843771@openvz.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8ef9de6a-7497-07f7-852c-befcc3843771@openvz.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 17, 2022 at 12:44:14PM +0300, Vasily Averin wrote:
>  2) rework kmem_cache_alloc* tracepoints to use cachep instead
>     of current cachep->*size parameters. Now kmalloc[_node] and
>     kmem_cache_alloc[_node] tracepoints do not use common template

You can keep the common template.  Just pass in s->object_size as well
as s.

