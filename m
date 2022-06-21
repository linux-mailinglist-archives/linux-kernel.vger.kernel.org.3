Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2766D552E5C
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jun 2022 11:31:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348829AbiFUJbu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jun 2022 05:31:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348475AbiFUJbs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jun 2022 05:31:48 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4B10A2710
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jun 2022 02:31:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1655803906;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=VGKFaQXI7Vycha22w6zMWNSh9b/P0DeKulo0BjmnruA=;
        b=fKYKQvPVo/UYtZPum4ejkJ9CRqXOershbbvF62BKjBfVpw/uG1FHnzJlRvS5puIJplDr0i
        Hm+e9XMuIYX2Tm0wy3QilfkeyE0C2VU4TjwwjM/1bEXF9PB2re8LGCytNggFQmWKI/PN9x
        LpfJyNQvFYRxkZAp7a5Q6ZHW/vlLmDM=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-341-Y0uMB8s6NqaYWXNBoOg1_A-1; Tue, 21 Jun 2022 05:31:44 -0400
X-MC-Unique: Y0uMB8s6NqaYWXNBoOg1_A-1
Received: by mail-wm1-f71.google.com with SMTP id v125-20020a1cac83000000b0039c832fbd02so8189249wme.4
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jun 2022 02:31:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:content-transfer-encoding:user-agent:mime-version;
        bh=VGKFaQXI7Vycha22w6zMWNSh9b/P0DeKulo0BjmnruA=;
        b=siV7XLSIMH7IC7N4X+4iAPkYOLU8xvjO+Vr82Z8gYlZVo1bmlh1C4dT1tPqXfk42Jc
         a363jtTdmAtrGwiLJANrhOtlCc7DL+jlCfsR+sgXrw/bSd+BtIehnipF+SzgFq9UZb0F
         MbPFkzMTfIAqkyowDRAd3tYKATe2QJciLgo0+J7T5UoiQan5KS6tET8o9k4PvuSgEdPX
         PkA84vllDU8DyU/BA+ZDfRUeqdSXExjYXpZkObKCq2KAQSg7+mC5gWDH6yZXVaXu3eiK
         1ckzyIXb2VIR8Ry1lkucw5JKPVdeayzcKigrdRq6DiDpOXwUUzqHbYG64iLh/NklrFZP
         GAjA==
X-Gm-Message-State: AJIora+u23SrTkZJIj5fyMLLVWNXqGkVXJorVGUiEJQaE7J2QC9gPVUy
        2eEMIQ/J/hmCEi0eSYhH3YXqJt3gRVNqMPxaM+RKqSCpG7MW8SnaZwqBhi+cKlMr65R2EwcFNmF
        5pRvn94lhNhI0nN1hmeQB6CDM
X-Received: by 2002:a05:6000:54f:b0:21b:944c:c70b with SMTP id b15-20020a056000054f00b0021b944cc70bmr5442273wrf.572.1655803903284;
        Tue, 21 Jun 2022 02:31:43 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1tNk/DJ9ls9t+jxPiliozBGhQQYVU2dBuA6MUNSG9KKPfxVZxCyIXT5RioZo+/fj+54bzhhIw==
X-Received: by 2002:a05:6000:54f:b0:21b:944c:c70b with SMTP id b15-20020a056000054f00b0021b944cc70bmr5442255wrf.572.1655803903056;
        Tue, 21 Jun 2022 02:31:43 -0700 (PDT)
Received: from ?IPv6:2a0c:5a80:1b12:b300:47b0:25ba:1a2e:72ac? ([2a0c:5a80:1b12:b300:47b0:25ba:1a2e:72ac])
        by smtp.gmail.com with ESMTPSA id h20-20020a05600c351400b00397342bcfb7sm19003908wmq.46.2022.06.21.02.31.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jun 2022 02:31:42 -0700 (PDT)
Message-ID: <c00a1b621850fedaea3da01ab178e91b79f1dce5.camel@redhat.com>
Subject: Re: [PATCH 7/7] mm/page_alloc: Replace local_lock with normal
 spinlock
From:   Nicolas Saenz Julienne <nsaenzju@redhat.com>
To:     Mel Gorman <mgorman@techsingularity.net>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Marcelo Tosatti <mtosatti@redhat.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Michal Hocko <mhocko@kernel.org>,
        Hugh Dickins <hughd@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>
Date:   Tue, 21 Jun 2022 11:31:41 +0200
In-Reply-To: <20220621092950.GF15453@techsingularity.net>
References: <20220613125622.18628-1-mgorman@techsingularity.net>
         <20220613125622.18628-8-mgorman@techsingularity.net>
         <04709b2d0dc702c9bf50f57cde125b07cdf54363.camel@redhat.com>
         <20220621092950.GF15453@techsingularity.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.2 (3.44.2-1.fc36) 
MIME-Version: 1.0
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2022-06-21 at 10:29 +0100, Mel Gorman wrote:
> On Fri, Jun 17, 2022 at 11:39:03AM +0200, Nicolas Saenz Julienne wrote:
> > Hi Mel,
> >=20
> > On Mon, 2022-06-13 at 13:56 +0100, Mel Gorman wrote:
> > > @@ -3446,12 +3490,16 @@ void free_unref_page(struct page *page, unsig=
ned int order)
> > >  		migratetype =3D MIGRATE_MOVABLE;
> > >  	}
> > > =20
> > > -	local_lock_irqsave(&pagesets.lock, flags);
> > > -	freed_pcp =3D free_unref_page_commit(page, migratetype, order, fals=
e);
> > > -	local_unlock_irqrestore(&pagesets.lock, flags);
> > > -
> > > -	if (unlikely(!freed_pcp))
> > > +	zone =3D page_zone(page);
> > > +	pcp_trylock_prepare(UP_flags);
> >=20
> > Now that you're calling the *_irqsave() family of function you can drop
> > pcp_trylock_prepare/finish()
> >=20
> > For the record in UP:
> >=20
> > #define spin_trylock_irqsave(lock, flags) \
> > ({ \
> > 	local_irq_save(flags); \
> > 	1;
> > })
> >=20
>=20
> The missing patch that is deferred for a later release uses spin_trylock
> so unless that is never merged because there is an unfixable flaw in it,
> I'd prefer to leave the preparation in place.
>=20
> > > +	pcp =3D pcpu_spin_trylock_irqsave(struct per_cpu_pages, lock, zone-=
>per_cpu_pageset, flags);
> > > +	if (pcp) {
> > > +		free_unref_page_commit(pcp, zone, page, migratetype, order);
> > > +		pcp_spin_unlock_irqrestore(pcp, flags);
> > > +	} else {
> > >  		free_one_page(page_zone(page), page, pfn, order, migratetype, FPI_=
NONE);
> > > +	}
> > > +	pcp_trylock_finish(UP_flags);
> > >  }
> > > =20
> > >  /*
> >=20
> > As Vlastimil mentioned elsewhere, I also wonder if it makes sense to ju=
st
> > bypass patch #5. Especially as its intent isn't true anymore:
> >=20
> > "As preparation for dealing with both of those problems, protect the li=
sts
> > with a spinlock.  The IRQ-unsafe version of the lock is used because IR=
Qs
> > are already disabled by local_lock_irqsave.  spin_trylock is used in
> > preparation for a time when local_lock could be used instead of
> > lock_lock_irqsave."
> >=20
>=20
> It's still true, the patch just isn't included as I wanted them to be
> separated by time so a bisection that points to it is "obvious" instead
> of pointing at the whole series as being a potential problem.

Understood, I jumped straight into the code and missed your comment in the
cover letter.

Thanks!

--=20
Nicol=C3=A1s S=C3=A1enz

