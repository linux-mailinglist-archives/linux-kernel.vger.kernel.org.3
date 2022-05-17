Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A81DF529871
	for <lists+linux-kernel@lfdr.de>; Tue, 17 May 2022 05:54:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236634AbiEQDyr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 May 2022 23:54:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231331AbiEQDyo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 May 2022 23:54:44 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6CC62E0BC
        for <linux-kernel@vger.kernel.org>; Mon, 16 May 2022 20:54:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Jej/zNlHp42fGBciz21lgfdwP2bYx92R3jqDU7lJwVE=; b=W2KvdG7RfjLdXNIFYkZIwx/L6b
        Fm2U74FWqtNH+OJgDlLx9d1KHsLN867E91OX8LoJVgveHLgCkTm7Fi2M/WTi7h7VY2Bixqzpaak8u
        QeikjgScoYhxNzplj+sD/X5Il7VgyNV7ugN09Lue1oMbdTc592mR1VnZzu7YpZF3myCtp+ppBCxCJ
        nUhKIaPMPnYhgsUL92ibbsk452jVfiOctJpOq+JjnowXObG6idBJ2dpV037JmWMcNuLX45SC+koje
        Hy4ZUhvKe0WqeD06xogBXG405qM/ARS5i3f22wJX4DetsjRyEPyIXTY1UKGxNi1HNX52YafY73G10
        xYv/jJkA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nqoHx-00AVOS-GY; Tue, 17 May 2022 03:54:25 +0000
Date:   Tue, 17 May 2022 04:54:25 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Vasily Averin <vvs@openvz.org>
Cc:     Shakeel Butt <shakeelb@google.com>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Vlastimil Babka <vbabka@suse.cz>,
        Andrew Morton <akpm@linux-foundation.org>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        David Rientjes <rientjes@google.com>,
        Pekka Enberg <penberg@kernel.org>,
        Christoph Lameter <cl@linux.com>, kernel@openvz.org,
        Linux MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Michal Hocko <mhocko@suse.com>
Subject: Re: [PATCH] tracing: add ACCOUNT flag for allocations from marked
 slab caches
Message-ID: <YoMccU66auLAPEHa@casper.infradead.org>
References: <1fd21e25-b095-e055-fc2e-abda640a0575@openvz.org>
 <CALvZod6wmxxigoLVg8Q+upqOkyoh+nPuVT0yx_XTbu8RXYYFgA@mail.gmail.com>
 <0aaf7b6d-6ed7-45ca-873e-394718f73c9a@openvz.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0aaf7b6d-6ed7-45ca-873e-394718f73c9a@openvz.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 17, 2022 at 06:32:28AM +0300, Vasily Averin wrote:
> > Should this 'if' be unlikely() or should we trace cachep->flags
> > explicitly to avoid this branch altogether?
> 
> In general output of cachep->flags can be useful, but at the moment 
> I am only interested in SLAB_ACCOUNT flag and in any case I would
> prefer to translate it to GFP_ACCOUNT.
> So I'm going to use unlikely() in v2 patch version.

It's still going to be an extra test, and networking is extremely
sensitive to extra instructions if tracing is compiled out.  Passing
in 'cachep' to the trace call looked like the best suggestion to me.
