Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97FAB4DCCE3
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Mar 2022 18:49:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236989AbiCQRvG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Mar 2022 13:51:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235536AbiCQRvF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Mar 2022 13:51:05 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D9DFB1F6356
        for <linux-kernel@vger.kernel.org>; Thu, 17 Mar 2022 10:49:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1647539387;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=eCBBOCUUJoxcZeKDp521zRXl50YJfiPdzqkETe2J4uM=;
        b=CnsOBW6NnsxC0JURYuAmBv38nxbb7pmKjymS42gutUmk1h39dXxskBzMR7fyzqr7bDXq5o
        8DZi9NTwhaB7dDR0ucFlBC8EqRrmKxUqfOoOCMKys0B9Md0ea/6d5C4/UFVqCsReris383
        d9j/eTvZHUkJ/zJLY8Cs8tEznTV17d8=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-421-UzQF4e8JMNS7qWMiJh8W-A-1; Thu, 17 Mar 2022 13:49:43 -0400
X-MC-Unique: UzQF4e8JMNS7qWMiJh8W-A-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 2EBAA802C16;
        Thu, 17 Mar 2022 17:49:43 +0000 (UTC)
Received: from Diego (unknown [10.39.208.28])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 83566112C08C;
        Thu, 17 Mar 2022 17:49:39 +0000 (UTC)
Date:   Thu, 17 Mar 2022 18:49:35 +0100 (CET)
From:   Michael Petlan <mpetlan@redhat.com>
X-X-Sender: Michael@Diego
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
cc:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        jolsa@kernel.org, atrajeev@linux.vnet.ibm.com, maddy@linux.ibm.com,
        kjain@linux.ibm.com
Subject: Re: [PATCH] perf symbols: Fix symbol size calculation condition
In-Reply-To: <YjNVnA+tToooxUV+@kernel.org>
Message-ID: <alpine.LRH.2.20.2203171849180.29735@Diego>
References: <20220317135536.805-1-mpetlan@redhat.com> <YjNVnA+tToooxUV+@kernel.org>
User-Agent: Alpine 2.20 (LRH 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.3
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 17 Mar 2022, Arnaldo Carvalho de Melo wrote:
> Em Thu, Mar 17, 2022 at 02:55:36PM +0100, Michael Petlan escreveu:
> > Before this patch, the symbol end address fixup to be called, needed two
> > conditions being met:
> > 
> >   if (prev->end == prev->start && prev->end != curr->start)
> > 
> > Where
> >   "prev->end == prev->start" means that prev is zero-long
> >                              (and thus needs a fixup)
> > and
> >   "prev->end != curr->start" means that fixup hasn't been applied yet
> > 
> > However, this logic is incorrect in the following situation:
> > 
> > *curr  = {rb_node = {__rb_parent_color = 278218928,
> >   rb_right = 0x0, rb_left = 0x0},
> >   start = 0xc000000000062354,
> >   end = 0xc000000000062354, namelen = 40, type = 2 '\002',
> >   binding = 0 '\000', idle = 0 '\000', ignore = 0 '\000',
> >   inlined = 0 '\000', arch_sym = 0 '\000', annotate2 = false,
> >   name = 0x1159739e "kprobe_optinsn_page\t[__builtin__kprobes]"}
> > 
> > *prev = {rb_node = {__rb_parent_color = 278219041,
> >   rb_right = 0x109548b0, rb_left = 0x109547c0},
> >   start = 0xc000000000062354,
> >   end = 0xc000000000062354, namelen = 12, type = 2 '\002',
> >   binding = 1 '\001', idle = 0 '\000', ignore = 0 '\000',
> >   inlined = 0 '\000', arch_sym = 0 '\000', annotate2 = false,
> >   name = 0x1095486e "optinsn_slot"}
> > 
> > In this case, prev->start == prev->end == curr->start == curr->end,
> > thus the condition above thinks that "we need a fixup due to zero
> > length of prev symbol, but it has been probably done, since the
> > prev->end == curr->start", which is wrong.
> > 
> > After the patch, the execution path proceeds to arch__symbols__fixup_end
> > function which fixes up the size of prev symbol by adding page_size to
> > its end offset.
> 
> You missed this:
> 
> Fixes: 3b01a413c196c910 ("perf symbols: Improve kallsyms symbol end addr calculation")
> 
> I'll add it to the patch, ok?

Sure thing. Thanks.
M

> 
> - Arnaldo
>  
> > Signed-off-by: Michael Petlan <mpetlan@redhat.com>
> > ---
> >  tools/perf/util/symbol.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/tools/perf/util/symbol.c b/tools/perf/util/symbol.c
> > index fb075aa8f8f2..dea0fc495185 100644
> > --- a/tools/perf/util/symbol.c
> > +++ b/tools/perf/util/symbol.c
> > @@ -231,7 +231,7 @@ void symbols__fixup_end(struct rb_root_cached *symbols)
> >  		prev = curr;
> >  		curr = rb_entry(nd, struct symbol, rb_node);
> >  
> > -		if (prev->end == prev->start && prev->end != curr->start)
> > +		if (prev->end == prev->start || prev->end != curr->start)
> >  			arch__symbols__fixup_end(prev, curr);
> >  	}
> >  
> > -- 
> > 2.18.4
> 
> -- 
> 
> - Arnaldo
> 
> 

