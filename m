Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9CD45A3D87
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Aug 2022 14:38:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229463AbiH1MiI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 Aug 2022 08:38:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbiH1MiG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Aug 2022 08:38:06 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B91A2F67B
        for <linux-kernel@vger.kernel.org>; Sun, 28 Aug 2022 05:38:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1661690283;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YWZ0OCc6Jw8ZV0oLlM1p01dda6gQGAes6Y+jsvNcrnc=;
        b=PAq/Q6aTfvHZxDncpWTqjZeHS1iPrq6G0oBR3bYrosdDnYF3coWxXAohzRvLzPlpQYVGWg
        ulZsXBgxwB5777P2OR82f4aIOW6hOC28ituOkHZ+TErYC/FbRm9fzcUYZzdx3PWc2+ULKv
        fxRoxZf/P6DZtqtFUFRy8VgXWHfMUJU=
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com
 [209.85.166.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-593-35PgoV5bPJe6xC9dXEDD0A-1; Sun, 28 Aug 2022 08:38:02 -0400
X-MC-Unique: 35PgoV5bPJe6xC9dXEDD0A-1
Received: by mail-il1-f199.google.com with SMTP id w11-20020a056e021c8b00b002ea48389206so4320250ill.3
        for <linux-kernel@vger.kernel.org>; Sun, 28 Aug 2022 05:38:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:organization:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-message-state
         :from:to:cc;
        bh=YWZ0OCc6Jw8ZV0oLlM1p01dda6gQGAes6Y+jsvNcrnc=;
        b=aCV0CFO1mtFZvjQMn7P4HWbTsJkSmhGRIdMeVTGG0ANbKNBuBy7xmPyQhObp2P7aQw
         a1Kv3hY+vTJuH7wHHSHk8OzQkUvZR8vRTSnfVIH1tRqJkiLG+nj8oz9yNVSJl3Yq2JHA
         KtYL6dd6gDHztAvvzwayeYHVDCfNFwDrbbohJQ5jRtHJODaDOgWeKrSg/zEcRq9J4eiD
         EDyYF+vPd3BDixG8zZf8T5b9hpwGfcFTZhRR75yO4jprj2atSuSG0c3BF2hxEdbTMdIQ
         PCYpaXIkFkb8Sfwf/ydQWyvtpS45IczjJUmNWC73uCTDXUsRhbGQzi13vvCkgLjL8SgE
         SKcg==
X-Gm-Message-State: ACgBeo171u+ymXsw2xBeKCRRLUqi8cMX2Jt+lC/2CP6ooQxD54i5y8P1
        sxiUNZ2t8WrSO6sf7A1t95b57b/E36e/qMiLFEq3F6yHPafz4wRBq/bvkvaHdomM1giIP5miiRg
        36GXnaYNwTqH03oJY7pI+nT9b
X-Received: by 2002:a05:6e02:1b09:b0:2df:1c60:e428 with SMTP id i9-20020a056e021b0900b002df1c60e428mr7666594ilv.227.1661690281943;
        Sun, 28 Aug 2022 05:38:01 -0700 (PDT)
X-Google-Smtp-Source: AA6agR5px5ANkM8ZpE9nMa44q0u7kj+R2zpLrObamHUIS2ILRuz6ZAXI92T9u3hhTeKSU/8keTmlzQ==
X-Received: by 2002:a05:6e02:1b09:b0:2df:1c60:e428 with SMTP id i9-20020a056e021b0900b002df1c60e428mr7666578ilv.227.1661690281729;
        Sun, 28 Aug 2022 05:38:01 -0700 (PDT)
Received: from redhat.com ([38.15.36.239])
        by smtp.gmail.com with ESMTPSA id d9-20020a023f09000000b00349eece079dsm3121665jaa.35.2022.08.28.05.38.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Aug 2022 05:38:01 -0700 (PDT)
Date:   Sun, 28 Aug 2022 06:37:59 -0600
From:   Alex Williamson <alex.williamson@redhat.com>
To:     John Hubbard <jhubbard@nvidia.com>
Cc:     akpm@linux-foundation.org, alex.sierra@amd.com,
        willy@infradead.org, hch@lst.de, Felix.Kuehling@amd.com,
        apopple@nvidia.com, david@redhat.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] mm: re-allow pinning of zero pfns (again)
Message-ID: <20220828063759.60c85fd6.alex.williamson@redhat.com>
In-Reply-To: <033c2e8d-8ba9-3e0b-9dee-7d0973c708fa@nvidia.com>
References: <166015037385.760108.16881097713975517242.stgit@omen>
        <033c2e8d-8ba9-3e0b-9dee-7d0973c708fa@nvidia.com>
Organization: Red Hat
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 27 Aug 2022 17:59:32 -0700
John Hubbard <jhubbard@nvidia.com> wrote:

> On 8/10/22 09:53, Alex Williamson wrote:
> > The below referenced commit makes the same error as 1c563432588d ("mm: fix
> > is_pinnable_page against a cma page"), re-interpreting the logic to exclude
> > pinning of the zero page, which breaks device assignment with vfio.
> > 
> > To avoid further subtle mistakes, split the logic into discrete tests.
> > 
> > Suggested-by: Matthew Wilcox <willy@infradead.org>
> > Suggested-by: Felix Kuehling <felix.kuehling@amd.com>
> > Link: https://lore.kernel.org/all/165490039431.944052.12458624139225785964.stgit@omen
> > Fixes: f25cbb7a95a2 ("mm: add zone device coherent type memory support")
> > Signed-off-by: Alex Williamson <alex.williamson@redhat.com>
> > ---
> >  include/linux/mm.h |   17 ++++++++++++++---
> >  1 file changed, 14 insertions(+), 3 deletions(-)  
> Hi Alex,
> 
> Looks good. I'm suggesting a simpler comment, below, because
> even though the VFIO folks are thinking about VFIO, here we
> are deep in the mm layer and there are lots of non-VFIO callers
> that may pin the zero page.
> 
> > 
> > diff --git a/include/linux/mm.h b/include/linux/mm.h
> > index 18e01474cf6b..835106a9718f 100644
> > --- a/include/linux/mm.h
> > +++ b/include/linux/mm.h
> > @@ -1544,9 +1544,20 @@ static inline bool is_longterm_pinnable_page(struct page *page)
> >  	if (mt == MIGRATE_CMA || mt == MIGRATE_ISOLATE)
> >  		return false;
> >  #endif
> > -	return !(is_device_coherent_page(page) ||
> > -		 is_zone_movable_page(page) ||
> > -		 is_zero_pfn(page_to_pfn(page)));
> > +	/*
> > +	 * The zero page might reside in a movable zone, however it may not
> > +	 * be migrated and can therefore be pinned.  The vfio subsystem pins
> > +	 * user mappings including the zero page for IOMMU translation.
> > +	 */  
> 
> Those notes are all about (some of) the callers. But it's a simple
> answer, really, so how about just this:
> 
> 	/* The zero page is always allowed to be pinned. */

Sure.  Are we looking for a re-spin with this?  I see Andrew already
added this incremental change to his hotfix-unstable branch separately.
I'd hate for a comment re-spin to delay getting a fix for this problem,
that blocks any VM use cases of VFIO, into mainline any longer.  Thanks,

Alex

