Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B717852C1B9
	for <lists+linux-kernel@lfdr.de>; Wed, 18 May 2022 20:08:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238952AbiERSBf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 May 2022 14:01:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241357AbiERSBO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 May 2022 14:01:14 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1AFD68CCC3
        for <linux-kernel@vger.kernel.org>; Wed, 18 May 2022 11:01:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1652896872;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=z8xlrowAUvM1/2ybSeOaJOkkrtVJbfEDH0nQAodlR3g=;
        b=U0VQQd818+Fs6/ZSL+dyTMFSnmMoGcUNogps86rWyNXLAnTN5K4gZStA9OU4TOxRt8aERO
        aVH2czJkkn6J8IGTag/mRSnx3wzGl3cK/jerpJanu7XH0zL6eqw8fKDHha/C9KRp27ealP
        XRlYGsjriAHxczCOZj1BLevyZHQSY7I=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-451-ETkq05ZvP7SV80FQFsNKkA-1; Wed, 18 May 2022 14:01:10 -0400
X-MC-Unique: ETkq05ZvP7SV80FQFsNKkA-1
Received: by mail-wm1-f70.google.com with SMTP id e9-20020a05600c4e4900b00394779649b1so3234477wmq.3
        for <linux-kernel@vger.kernel.org>; Wed, 18 May 2022 11:01:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:content-transfer-encoding:user-agent:mime-version;
        bh=z8xlrowAUvM1/2ybSeOaJOkkrtVJbfEDH0nQAodlR3g=;
        b=6C/ty3c3SmIDwXBz71FRjwmT8jgvwLq7R4bT5/X5/VnueEnBdS8CSKmHfbZioKwiXv
         yQv6Kihi5EwnaA49lrDkBCrT6Mek4xsQjwBtbGjysvBleYF20HaRj3Vn26kNROfAGLL3
         4btLoke5YuFpWr5WVnmh8EFAxtNMRTexaj3m0gZ9vM2Btig7R8VkDtPUFw5beD47nWGQ
         BrmBZYwm30SmKT01Y/XuYXxtnOAkt9KgJksulbumfb2bYjA72KRJM6AZ9EZVYYQ9SDY6
         h8Zth62lAv9f0MeaSO8UkwzwJnCFzW4LaND4gU//HUB9/KvxZA+MzaguSmK2GFKUjFNB
         MAnw==
X-Gm-Message-State: AOAM533dt/9PCyVe3RQW6XsJWSka1KJxu+nwuUOcXDAw9jVogm17yo53
        rXbrwqrhgk8dImsFo4sSIGZY6sUhFFFIzUqHYm9ctB8BHqa0Ubtz9IlgYN+W5QOzUr0rHbuvrLT
        ZggacBFXd7abJq8b1ulIxN/3U
X-Received: by 2002:a7b:ce02:0:b0:381:2007:f75c with SMTP id m2-20020a7bce02000000b003812007f75cmr1050650wmc.6.1652896869369;
        Wed, 18 May 2022 11:01:09 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxBcYFHJwrznm9sfk4CRqqfgijdDfW6hPYDdn37Qxw4KOcOCf+ZFixqXha94HyPD+3N3LMb4g==
X-Received: by 2002:a7b:ce02:0:b0:381:2007:f75c with SMTP id m2-20020a7bce02000000b003812007f75cmr1050631wmc.6.1652896869182;
        Wed, 18 May 2022 11:01:09 -0700 (PDT)
Received: from ?IPv6:2a0c:5a80:1d02:ba00:f4f8:7394:c8:7ddf? ([2a0c:5a80:1d02:ba00:f4f8:7394:c8:7ddf])
        by smtp.gmail.com with ESMTPSA id j10-20020adfa78a000000b0020c5253d8fcsm3034662wrc.72.2022.05.18.11.01.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 May 2022 11:01:08 -0700 (PDT)
Message-ID: <09fbcf0884ef5e03812566b9576979253e506ce9.camel@redhat.com>
Subject: Re: [PATCH 0/6] Drain remote per-cpu directly v3
From:   Nicolas Saenz Julienne <nsaenzju@redhat.com>
To:     Mel Gorman <mgorman@techsingularity.net>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Marcelo Tosatti <mtosatti@redhat.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Michal Hocko <mhocko@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>
Date:   Wed, 18 May 2022 20:01:07 +0200
In-Reply-To: <20220512085043.5234-1-mgorman@techsingularity.net>
References: <20220512085043.5234-1-mgorman@techsingularity.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.1 (3.44.1-1.fc36) 
MIME-Version: 1.0
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2022-05-12 at 09:50 +0100, Mel Gorman wrote:
> Changelog since v2
> o More conversions from page->lru to page->[pcp_list|buddy_list]
> o Additional test results in changelogs
>=20
> Changelog since v1
> o Fix unsafe RT locking scheme
> o Use spin_trylock on UP PREEMPT_RT
>=20
> This series has the same intent as Nicolas' series "mm/page_alloc: Remote
> per-cpu lists drain support" -- avoid interference of a high priority
> task due to a workqueue item draining per-cpu page lists. While many
> workloads can tolerate a brief interruption, it may be cause a real-time
> task runnning on a NOHZ_FULL CPU to miss a deadline and at minimum,
> the draining in non-deterministic.
>=20
> Currently an IRQ-safe local_lock protects the page allocator per-cpu list=
s.
> The local_lock on its own prevents migration and the IRQ disabling protec=
ts
> from corruption due to an interrupt arriving while a page allocation is
> in progress. The locking is inherently unsafe for remote access unless
> the CPU is hot-removed.
>=20
> This series adjusts the locking. A spinlock is added to struct
> per_cpu_pages to protect the list contents while local_lock_irq continues
> to prevent migration and IRQ reentry. This allows a remote CPU to safely
> drain a remote per-cpu list.
>=20
> This series is a partial series. Follow-on work should allow the
> local_irq_save to be converted to a local_irq to avoid IRQs being
> disabled/enabled in most cases. Consequently, there are some TODO comment=
s
> highlighting the places that would change if local_irq was used. However,
> there are enough corner cases that it deserves a series on its own
> separated by one kernel release and the priority right now is to avoid
> interference of high priority tasks.

FWIW tested this against our RT+nohz_full workloads. I can have another go =
if
the locking scheme changes.

Tested-by: Nicolas Saenz Julienne <nsaenzju@redhat.com>

Thanks,

--=20
Nicol=C3=A1s S=C3=A1enz

