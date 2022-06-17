Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A09D554F47B
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Jun 2022 11:39:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381066AbiFQJjT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Jun 2022 05:39:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235673AbiFQJjM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jun 2022 05:39:12 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4A1696899F
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jun 2022 02:39:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1655458750;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1GFgSble/mgs+0F6X8rsxYiNnD2yRs1iX9KEcjvB8Rs=;
        b=D4y/PXm3+MqZBFqBjePtuser+cCw6+9rWDbdsHmX7oj4+KI31ARLwi44ytNnk/2Rj65bJC
        0s6cKqpdLF0nkQWImG4DhampiBbMAfPWfAIVvkJmP3XkNaxy5lsNmrxmC/X5OnnpOWP4/q
        jZaTfKsel+0ySPdTyfLWLn9052bYrBk=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-663-GfqkU5bbPPW2qsB5WXOelg-1; Fri, 17 Jun 2022 05:39:07 -0400
X-MC-Unique: GfqkU5bbPPW2qsB5WXOelg-1
Received: by mail-wr1-f72.google.com with SMTP id u18-20020adfb212000000b0021855847651so834578wra.6
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jun 2022 02:39:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:content-transfer-encoding:user-agent:mime-version;
        bh=1GFgSble/mgs+0F6X8rsxYiNnD2yRs1iX9KEcjvB8Rs=;
        b=K74aMcAt/swwTHg27sHQK//7u4cCN9/AmPhZhOkpT/opdRhxNSWG/tpy+ju/qLQ1d9
         /GKZr3V/gcVdXasLpwGJW5tbVhuvnbiPkSiTnGk+5fRw1SOcBg10NimWzHCiL1ze0//U
         J76kGES9wt8lBENySXs0soXbKf/D7Xf1chrGnA/OGyuklUA97ND1iytrYWhCDg1rfOTN
         Q9ux79voIDm7MBxnC6i0FscXQYivTgiQF2h3Z52hDjO2olI0yGDuyLHlCwZiitLpKimJ
         DFdqGxBIf85m5CUcG2YtmsV8RwXmKuKUhmsejg36SznuWZ8xUIJ2LAutB6KWf69EbhFz
         Z6bg==
X-Gm-Message-State: AJIora/dgyLXlqPMqjFrFsUKIi28WhPE4H92M6jkqfe2PMd4QKUBeuSi
        NIqWiXqvoetY38UwRvISVV55BILZ83I3zPjmpnpPsRBbURq8dV8nyCiKwZqzhMwcy4Vao7nL6AJ
        VQ6VE9jjFXRDgJS18J07J0y4F
X-Received: by 2002:a05:600c:3790:b0:39c:62b9:b164 with SMTP id o16-20020a05600c379000b0039c62b9b164mr9277707wmr.0.1655458746275;
        Fri, 17 Jun 2022 02:39:06 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1ssOzlsz8rX7DUYTbgbx9m7NXAW6WexEIBYo3eYb/SuXC8Znoxg8CzlQ8ZdEsAjE32MMerotg==
X-Received: by 2002:a05:600c:3790:b0:39c:62b9:b164 with SMTP id o16-20020a05600c379000b0039c62b9b164mr9277690wmr.0.1655458746059;
        Fri, 17 Jun 2022 02:39:06 -0700 (PDT)
Received: from ?IPv6:2a0c:5a80:1b12:b300:47b0:25ba:1a2e:72ac? ([2a0c:5a80:1b12:b300:47b0:25ba:1a2e:72ac])
        by smtp.gmail.com with ESMTPSA id n23-20020a05600c3b9700b0039c5224bfcbsm9337826wms.46.2022.06.17.02.39.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jun 2022 02:39:05 -0700 (PDT)
Message-ID: <04709b2d0dc702c9bf50f57cde125b07cdf54363.camel@redhat.com>
Subject: Re: [PATCH 7/7] mm/page_alloc: Replace local_lock with normal
 spinlock
From:   Nicolas Saenz Julienne <nsaenzju@redhat.com>
To:     Mel Gorman <mgorman@techsingularity.net>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Marcelo Tosatti <mtosatti@redhat.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Michal Hocko <mhocko@kernel.org>,
        Hugh Dickins <hughd@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>
Date:   Fri, 17 Jun 2022 11:39:03 +0200
In-Reply-To: <20220613125622.18628-8-mgorman@techsingularity.net>
References: <20220613125622.18628-1-mgorman@techsingularity.net>
         <20220613125622.18628-8-mgorman@techsingularity.net>
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

Hi Mel,

On Mon, 2022-06-13 at 13:56 +0100, Mel Gorman wrote:
> @@ -3446,12 +3490,16 @@ void free_unref_page(struct page *page, unsigned =
int order)
>  		migratetype =3D MIGRATE_MOVABLE;
>  	}
> =20
> -	local_lock_irqsave(&pagesets.lock, flags);
> -	freed_pcp =3D free_unref_page_commit(page, migratetype, order, false);
> -	local_unlock_irqrestore(&pagesets.lock, flags);
> -
> -	if (unlikely(!freed_pcp))
> +	zone =3D page_zone(page);
> +	pcp_trylock_prepare(UP_flags);

Now that you're calling the *_irqsave() family of function you can drop
pcp_trylock_prepare/finish()

For the record in UP:

#define spin_trylock_irqsave(lock, flags) \
({ \
	local_irq_save(flags); \
	1;
})

> +	pcp =3D pcpu_spin_trylock_irqsave(struct per_cpu_pages, lock, zone->per=
_cpu_pageset, flags);
> +	if (pcp) {
> +		free_unref_page_commit(pcp, zone, page, migratetype, order);
> +		pcp_spin_unlock_irqrestore(pcp, flags);
> +	} else {
>  		free_one_page(page_zone(page), page, pfn, order, migratetype, FPI_NONE=
);
> +	}
> +	pcp_trylock_finish(UP_flags);
>  }
> =20
>  /*

As Vlastimil mentioned elsewhere, I also wonder if it makes sense to just
bypass patch #5. Especially as its intent isn't true anymore:

"As preparation for dealing with both of those problems, protect the lists
with a spinlock.  The IRQ-unsafe version of the lock is used because IRQs
are already disabled by local_lock_irqsave.  spin_trylock is used in
preparation for a time when local_lock could be used instead of
lock_lock_irqsave."

--=20
Nicol=C3=A1s S=C3=A1enz

