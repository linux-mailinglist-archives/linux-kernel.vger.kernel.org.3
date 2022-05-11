Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 093F8522848
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 02:10:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236611AbiEKAKl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 May 2022 20:10:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239820AbiEKAK1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 May 2022 20:10:27 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED69828B6AD
        for <linux-kernel@vger.kernel.org>; Tue, 10 May 2022 17:09:39 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id n8so314478plh.1
        for <linux-kernel@vger.kernel.org>; Tue, 10 May 2022 17:09:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=x2IZWRoSQpbPZs9WYJFMgYc9zvICPs6yFR+KKARA32k=;
        b=mmb751A54mxke2IDtPA5QF+uged9XW0C8/3BSKkc06wfNBGuTfN+qMsJ5HfQtAxy4Z
         cgL/MUpigI4Sg17QFqLzMtcpW1bKXJrfTh/3RGdddieQF8JKePmkkQwtxB0NfMt7tIXp
         D9D84CTyuWcx9FOsVb/loqcsibICdTij/kwNy5FyLnnrC6cbPp62nzG1dqelyiGedyap
         xXh+kQgql65cOLHB2gdbSCqEUYJnVrS05vL4irvkU/LWT8Rzr1E17qPCBED8fOgWd/bt
         1YYDQ0MMAEajYWXbkPN5gfiXCL4DUXFjrAtBXUx6j2QtaEig73IQlRzPh7FwXuLR1wvf
         Ivvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=x2IZWRoSQpbPZs9WYJFMgYc9zvICPs6yFR+KKARA32k=;
        b=x3irTVKktSkDQdzAnQhGRDgH3oGKgcGCu/dzVonr2osw6T/zX2IMDuHEIo6wGJ2SuA
         YWo7EJiPbEMCEYWzaKbETTM+WxaSsP4HUx7QaLR5KE7+ivfrBxuurULiK346myREysFr
         TLq5Iq88oG9HO4Gz3ZQvNfxJ3HCJ5SW9BrO+v0rbYQXnJj592a7lchSW8V+9aakDOHA6
         RgmEzgcBC0z4BJSkuUPqLsNJGWbeu/UEAG+WgSdB/4OpgT/Z3xzZBuynRYw7otH3SpKB
         FQF6b0ATbgamBchP1CIbfLIDdGW5mXVA/VVHJvndYxrB4l48c3Db7AVyb9c6GxNhrjVA
         ylew==
X-Gm-Message-State: AOAM5337LXvl+cMZC3keby2Mm3vrI5O3zR64uGWuRod5k63/3NK2+Mx+
        sjUt6p2abON8AqWX2ZmXwpzHbPAs8ho=
X-Google-Smtp-Source: ABdhPJxILPjt7jfDvUr8owmQ1dXgwusrKk9TlWi9cdTNTPsXAEU3YmOCoKZS0acB5FeHZGqbtVdBEQ==
X-Received: by 2002:a17:90b:4d11:b0:1dc:ec4f:a19c with SMTP id mw17-20020a17090b4d1100b001dcec4fa19cmr2356348pjb.117.1652227779366;
        Tue, 10 May 2022 17:09:39 -0700 (PDT)
Received: from google.com ([2620:15c:211:201:c98a:65b0:edca:b69a])
        by smtp.gmail.com with ESMTPSA id p14-20020a170902b08e00b0015e8da1fb07sm208277plr.127.2022.05.10.17.09.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 May 2022 17:09:38 -0700 (PDT)
Sender: Minchan Kim <minchan.kim@gmail.com>
Date:   Tue, 10 May 2022 17:09:37 -0700
From:   Minchan Kim <minchan@kernel.org>
To:     John Hubbard <jhubbard@nvidia.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-mm <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        John Dias <joaodias@google.com>,
        David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH v4] mm: fix is_pinnable_page against on cma page
Message-ID: <Ynr+wTCQpyh8+vOD@google.com>
References: <20220510211743.95831-1-minchan@kernel.org>
 <857d21da-5de2-fa3e-b1ce-41cc1cfb0191@nvidia.com>
 <Ynr10y6pkH6WwbQo@google.com>
 <bb6e76f1-2cbc-893d-c8ab-3ecd3fcae2a5@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bb6e76f1-2cbc-893d-c8ab-3ecd3fcae2a5@nvidia.com>
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

On Tue, May 10, 2022 at 04:58:13PM -0700, John Hubbard wrote:
> On 5/10/22 4:31 PM, Minchan Kim wrote:
> > > > +	int __mt = get_pageblock_migratetype(page);
> > > > +	int mt = __READ_ONCE(__mt);
> > > 
> > > Although I saw the email discussion about this in v2, that discussion
> > > didn't go far enough. It started with "don't use volatile", and went
> > > on to "try __READ_ONCE() instead", but it should have continued on
> > > to "you don't need this at all".
> > 
> > That's really what I want to hear from experts so wanted to learn
> > "Why". How could we prevent refetching of the mt if we don't use
> > __READ_ONCE or volatile there?
> > 
> > > 
> > > Because you don't. There is nothing you are racing with, and adding
> > > __READ_ONCE() in order to avoid a completely not-going-to-happen
> > > compiler re-invocation of a significant code block is just very wrong.
> > > 
> > > So let's just let it go entirely. :)
> > 
> > Yeah, once it's clear for everyone, I am happy to remove the
> > unnecessary lines.
> > 
> > > 
> > > > +
> > > > +	if (mt == MIGRATE_CMA || mt == MIGRATE_ISOLATE)
> > > 
> 
> With or without __READ_ONCE() or volatile or anything else,
> this code will do what you want. Which is: loosely check
> for either of the above.
> 
> What functional problem do you think you are preventing
> with __READ_ONCE()? Because I don't see one.

I discussed the issue at v1 so please take a look.

https://lore.kernel.org/all/YnFvmc+eMoXvLCWf@google.com/
