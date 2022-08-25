Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4353D5A1D39
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Aug 2022 01:36:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244528AbiHYXg2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Aug 2022 19:36:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231861AbiHYXgZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 19:36:25 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C815ACA11
        for <linux-kernel@vger.kernel.org>; Thu, 25 Aug 2022 16:36:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1661470583;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=fZkbW2nKw9OcNR++w2Lt3hNVn3FfxAMwHGTXAs+/ztQ=;
        b=NVvv0j+l4lqJT/TDtvANtYh9/Ba/InC83JiOeGL6MfuRugbtj3E6solgKEn0iElUd9nsCN
        yi+iVAy1t6mnErRjOGks5hUBUCtXVu1Rs2nTVtIuTcQU9vnQG8a5gKjtwo+75WfOLKzb3B
        qOiH91wQpBpWWy6qk+L9oUUWfYimETE=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-650-VmH-jDZgNOiZtytVsxHhvg-1; Thu, 25 Aug 2022 19:36:22 -0400
X-MC-Unique: VmH-jDZgNOiZtytVsxHhvg-1
Received: by mail-qv1-f72.google.com with SMTP id od16-20020a0562142f1000b00496e2ea7934so8647747qvb.13
        for <linux-kernel@vger.kernel.org>; Thu, 25 Aug 2022 16:36:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=fZkbW2nKw9OcNR++w2Lt3hNVn3FfxAMwHGTXAs+/ztQ=;
        b=VlndjqFnwv9K2tt54FJR02LdFLj60Z4xrGtAdgX+P9bcFI8sfsaBU3G6QJIb8LrQAQ
         UXTDBpMa7KzjoKueETJ19K/mccrI0jYnDROAviu1Wqp3DvafCNqeRUA0EFU+g4Rxon35
         z3efEeakTmXqWJfnwGoNaoSLuHmBViItAUGlPtyvW9Ii4XMC2xc6PtJfmuTtrGzQimrq
         w7AVvytamitNKw8HUb71KkDvu8TIDNMlBj9mWNjxxOMuDN1U2H7xLrAsGz9pmf0/2UwK
         hfETy0l4W6DtJffsohIH49FXVunb2H0m1UiELHIeNpdXxeFMpl15DT6GNc981UdEmkeP
         bmcQ==
X-Gm-Message-State: ACgBeo28p75YLh8ovMspLaBHuwMGmv7gVZuWgW3SOw3YtxLthss3LAXx
        8OoLjKYsmD1D5ag+INF9oJsPkKLghRuWwpUP0xB0OOL5/TmXwGxdmHi3nY2Fgl5mFnxrDcOb/QU
        CF6j2rBXuVJpCZhwS6b44uVKu
X-Received: by 2002:ac8:5948:0:b0:342:f500:2eb7 with SMTP id 8-20020ac85948000000b00342f5002eb7mr5760964qtz.483.1661470581830;
        Thu, 25 Aug 2022 16:36:21 -0700 (PDT)
X-Google-Smtp-Source: AA6agR7TBH9R3amncjXP/5aFj5LeS8C1KlxU0maHmlQmU9GZdotjAyQBWdSKlYFKnk+U7FuoDJCUoA==
X-Received: by 2002:ac8:5948:0:b0:342:f500:2eb7 with SMTP id 8-20020ac85948000000b00342f5002eb7mr5760938qtz.483.1661470581599;
        Thu, 25 Aug 2022 16:36:21 -0700 (PDT)
Received: from xz-m1.local (bras-base-aurron9127w-grc-35-70-27-3-10.dsl.bell.ca. [70.27.3.10])
        by smtp.gmail.com with ESMTPSA id w16-20020a05620a425000b006bba46e5eeasm663162qko.37.2022.08.25.16.36.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Aug 2022 16:36:21 -0700 (PDT)
Date:   Thu, 25 Aug 2022 19:36:18 -0400
From:   Peter Xu <peterx@redhat.com>
To:     Alistair Popple <apopple@nvidia.com>
Cc:     "Huang, Ying" <ying.huang@intel.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        huang ying <huang.ying.caritas@gmail.com>,
        Linux MM <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "Sierra Guiza, Alejandro (Alex)" <alex.sierra@amd.com>,
        Felix Kuehling <Felix.Kuehling@amd.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        John Hubbard <jhubbard@nvidia.com>,
        David Hildenbrand <david@redhat.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        Matthew Wilcox <willy@infradead.org>,
        Karol Herbst <kherbst@redhat.com>,
        Lyude Paul <lyude@redhat.com>, Ben Skeggs <bskeggs@redhat.com>,
        Logan Gunthorpe <logang@deltatee.com>, paulus@ozlabs.org,
        linuxppc-dev@lists.ozlabs.org, stable@vger.kernel.org
Subject: Re: [PATCH v2 1/2] mm/migrate_device.c: Copy pte dirty bit to page
Message-ID: <YwgHcjBmldFiI71O@xz-m1.local>
References: <87czcyawl6.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <Yv5QXkS4Bm9pTBeG@xz-m1.local>
 <874jy9aqts.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <87czcqiecd.fsf@nvdebian.thelocal>
 <YwaJSBnp2eyMlkjw@xz-m1.local>
 <YwaOpj54/qUb5fXa@xz-m1.local>
 <87o7w9f7dp.fsf@nvdebian.thelocal>
 <87k06xf70l.fsf@nvdebian.thelocal>
 <YwePm5lMSU2tsW6f@xz-m1.local>
 <877d2wezll.fsf@nvdebian.thelocal>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <877d2wezll.fsf@nvdebian.thelocal>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 26, 2022 at 08:09:28AM +1000, Alistair Popple wrote:
> > I looked at some of the callers, it seems not all of them are ready to
> > handle that (__kvmppc_svm_page_out() or svm_migrate_vma_to_vram()).  Is it
> > safe?  Do the callers need to always properly handle that (unless the
> > migration is only a best-effort, but it seems not always the case).
> 
> Migration is always best effort. Callers need to be prepared to handle
> failure of a particular page to migrate, but I could believe not all of
> them are.

Ok, I see that ppc list is in the loop, hopefully this issue is aware since
afaict ppc will sigbus when migrate_vma_setup() fails, otoh the svm code
just dumps some device error (and I didn't check upper the stack from there).

> 
> > Besides, since I read the old code of prepare(), I saw this comment:
> >
> > -		if (!(migrate->src[i] & MIGRATE_PFN_LOCKED)) {
> > -			/*
> > -			 * Because we are migrating several pages there can be
> > -			 * a deadlock between 2 concurrent migration where each
> > -			 * are waiting on each other page lock.
> > -			 *
> > -			 * Make migrate_vma() a best effort thing and backoff
> > -			 * for any page we can not lock right away.
> > -			 */
> > -			if (!trylock_page(page)) {
> > -				migrate->src[i] = 0;
> > -				migrate->cpages--;
> > -				put_page(page);
> > -				continue;
> > -			}
> > -			remap = false;
> > -			migrate->src[i] |= MIGRATE_PFN_LOCKED;
> > -		}
> >
> > I'm a bit curious whether that deadlock mentioned in the comment is
> > observed in reality?
> >
> > If the page was scanned in the same address space, logically the lock order
> > should be guaranteed (if both page A&B, both threads should lock in order).
> > I think the order can be changed if explicitly did so (e.g. fork() plus
> > mremap() for anonymous here) but I just want to make sure I get the whole
> > point of it.
> 
> You seem to have the point of it. The trylock_page() is to avoid
> deadlock, and failure is always an option for migration. Drivers can
> always retry if they really need the page to migrate, although success
> is never guaranteed. For example the page might be pinned (or have
> swap-cache allocated to it, but I'm hoping to at least get that fixed).

If so I'd suggest even more straightforward document for either this
trylock() or on the APIs (e.g. for migrate_vma_setup()).  This behavior is
IMHO hiding deep and many people may not realize.  I'll comment in the
comment update patch.

Thanks.

-- 
Peter Xu

