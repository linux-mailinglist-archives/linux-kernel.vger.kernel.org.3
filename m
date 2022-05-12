Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABA1252417D
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 02:27:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349640AbiELA1C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 20:27:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242707AbiELA07 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 20:26:59 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4072335DE7
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 17:26:58 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id e24so3705071pjt.2
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 17:26:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=lSOQOgP92/YiU5VAWj+NdXGc95/DnozpR5AdrSptpI4=;
        b=nj48KdFh+/sfMu3rISqNM01K4uo221UQg9EECYj9I1566x6pbwZ2im6XJF1nepDYAR
         rAS1n9HuNI+9hF04K4JpP2/eftkYUUNbN9BhUht3NRASeQ136OfBwoQBHzoCUD29mOXX
         c0P2aAmQdLPSObjwvEzC+qqDiOo9GskHVMz51V3OvVdhdrZFbUcw9YJJRHB7hUUNDMiK
         tSWV01HrIsISPKBi90rk4a7dgXhLP6d4mfqxDvBM9Y3gFGU0zfLhimu8NYEO2/SgyeVP
         ul/LtTlNBnN6zwuJz9kni2nCqJ0V8JnFtjWJPcfpdYuxqbeKnAGPl8/Lu1wwVAqxzyYl
         csTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to;
        bh=lSOQOgP92/YiU5VAWj+NdXGc95/DnozpR5AdrSptpI4=;
        b=q91AyuE6PHcwYY9GQzjdQ+NjDzvp0gKG2uo6trMIU9VGBo3i/DgEaJR8ClInsuZ/2v
         Gxxsjy4zb8dBoJSnkaQW3eNtrxF65KmQ/XeS8U+I6Ck8Y3QXXTie8U+eOJIC52X7h3YW
         p6swTJ6awPpY/ztcA8DQAxRPkbkZT1k4DDZjSczbCG+rZYxvqSR2QuBn+LlxVCU+e+2U
         J3oekyl8yAF6WITdI9WIO0QNY7gaUnoFqtVgCWO5I/uTHRtFfbsvlRWeOpOInAZ8Yl3R
         K1S2OlkAx40iLE0MB7z/wavtG4D1tdFdoLTAsLZCp7ydebGRvmDZRkiuEWTGDrnodvHE
         JQ0A==
X-Gm-Message-State: AOAM5312y9YwXF+4X3w3uWFgKC1CgXkzXhYPRBXC4wJkRJVNEAyYcvBg
        af5BgbPZPS6HZq9hsQrj6Mk=
X-Google-Smtp-Source: ABdhPJyh51RrSZyzGueYZU+R57NkHQ8GfEjV+AaZcM12tnOzVv5rZ2hD+66yclGja+Q1K83BPJkE4Q==
X-Received: by 2002:a17:90b:4a84:b0:1dc:67e9:a92c with SMTP id lp4-20020a17090b4a8400b001dc67e9a92cmr7878081pjb.141.1652315217763;
        Wed, 11 May 2022 17:26:57 -0700 (PDT)
Received: from google.com ([2620:15c:211:201:69ef:9c87:7816:4f74])
        by smtp.gmail.com with ESMTPSA id d6-20020a170902654600b0015f44241a31sm77278pln.110.2022.05.11.17.26.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 May 2022 17:26:57 -0700 (PDT)
Sender: Minchan Kim <minchan.kim@gmail.com>
Date:   Wed, 11 May 2022 17:26:55 -0700
From:   Minchan Kim <minchan@kernel.org>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     John Hubbard <jhubbard@nvidia.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-mm <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        John Dias <joaodias@google.com>,
        David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH v4] mm: fix is_pinnable_page against on cma page
Message-ID: <YnxUTxnCJ6EsmjEi@google.com>
References: <YnwupNzDNv7IbjRQ@google.com>
 <54b5d177-f2f4-cef2-3a68-cd3b0b276f86@nvidia.com>
 <Ynw6mauQuNhrOAHy@google.com>
 <f7bcda22-8ffe-67be-36bc-fcde58d8884a@nvidia.com>
 <YnxCCPZUfgQNXSg6@google.com>
 <8f083802-7ab0-15ec-b37d-bc9471eea0b1@nvidia.com>
 <20220511234534.GG1790663@paulmck-ThinkPad-P17-Gen-1>
 <ea64b36c-ecc1-74db-dd2e-909e7e507ef8@nvidia.com>
 <0d90390c-3624-4f93-f8bd-fb29e92237d3@nvidia.com>
 <20220512002207.GJ1790663@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220512002207.GJ1790663@paulmck-ThinkPad-P17-Gen-1>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 11, 2022 at 05:22:07PM -0700, Paul E. McKenney wrote:
> On Wed, May 11, 2022 at 05:12:32PM -0700, John Hubbard wrote:
> > On 5/11/22 16:57, John Hubbard wrote:
> > > On 5/11/22 16:45, Paul E. McKenney wrote:
> > > > > 
> > > > > Well no, because the "&" operation is a single operation on the CPU, and
> > > > > isn't going to get split up like that.
> > > > 
> > > > Chiming in a bit late...
> > > 
> > > Much appreciated!
> > > 
> > > > 
> > > > The usual way that this sort of thing causes trouble is if there is a
> > > > single store instruction that changes the value from MIGRATE_ISOLATE
> > > > to MIGRATE_CMA, and if the compiler decides to fetch twice, AND twice,
> > > 
> > > Doing an AND twice for "x & constant" this definitely blows my mind. Is
> > > nothing sacred? :)
> > > 
> > > > and then combine the results.  This could give a zero outcome where the
> > > > underlying variable never had the value zero.
> > > > 
> > > > Is this sort of thing low probability?
> > > > 
> > > > Definitely.
> > > > 
> > > > Isn't this sort of thing prohibited?
> > > > 
> > > > Definitely not.
> > > > 
> > > > So what you have will likely work for at least a while longer, but it
> > > > is not guaranteed and it forces you to think a lot harder about what
> > > > the current implementations of the compiler can and cannot do to you.
> > > > 
> > > > The following LWN article goes through some of the possible optimizations
> > > > (vandalisms?) in this area: https://lwn.net/Articles/793253/
> > > > 
> > > 
> > > hmm, I don't think we hit any of those  cases, do we? Because here, the
> > > "write" side is via a non-inline function that I just don't believe the
> > > compiler is allowed to call twice. Or is it?
> > > 
> > > Minchan's earlier summary:
> > > 
> > > CPU 0                         CPU1
> > > 
> > > 
> > >                                set_pageblock_migratetype(MIGRATE_ISOLATE)
> > > 
> > > if (get_pageblock_migrate(page) & MIGRATE_CMA)
> > > 
> > >                                set_pageblock_migratetype(MIGRATE_CMA)
> > > 
> > > if (get_pageblock_migrate(page) & MIGRATE_ISOLATE)
> > > 
> > > ...where set_pageblock_migratetype() is not inline.
> > > 
> > > thanks,
> > 
> > Let me try to say this more clearly: I don't think that the following
> > __READ_ONCE() statement can actually help anything, given that
> > get_pageblock_migratetype() is non-inlined:
> > 
> > +	int __mt = get_pageblock_migratetype(page);
> > +	int mt = __READ_ONCE(__mt);
> > +
> > +	if (mt & (MIGRATE_CMA | MIGRATE_ISOLATE))
> > +		return false;
> > 
> > 
> > Am I missing anything here?
> 
> In the absence of future aggression from link-time optimizations (LTO),
> you are missing nothing.

A thing I want to note is Android kernel uses LTO full mode.
