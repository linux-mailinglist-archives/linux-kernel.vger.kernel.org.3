Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E85B458DD95
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Aug 2022 20:01:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344251AbiHISBB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Aug 2022 14:01:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344166AbiHISAf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Aug 2022 14:00:35 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C7B0A26579
        for <linux-kernel@vger.kernel.org>; Tue,  9 Aug 2022 11:00:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1660068008;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=AfxVZADNWEfFzXttPFva+96zrEVI5cpqVt6HGbyuOxU=;
        b=LBaRH6pForMmmAdW0Rq49ynui/h++Es6JJKIVdfi3Nv3BJrepPL48g82GSIMuaVWnVznqd
        ewu07Kb9dmq9ifh2zHrfFm26kzaGaGkqJaJXSDRqRpyQmmdP+2MAlmucQhFK3Q34I4ZkBS
        aPj8t+0btprXEXywYB0ToawnjxxAR/M=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-463-XVfCQf9WPzqnMT-QHTKHjA-1; Tue, 09 Aug 2022 13:59:52 -0400
X-MC-Unique: XVfCQf9WPzqnMT-QHTKHjA-1
Received: by mail-qt1-f198.google.com with SMTP id a8-20020a05622a064800b00342240a9fccso9502227qtb.18
        for <linux-kernel@vger.kernel.org>; Tue, 09 Aug 2022 10:59:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=AfxVZADNWEfFzXttPFva+96zrEVI5cpqVt6HGbyuOxU=;
        b=Mo4dTf0SbrlzfBcn7wJU3aA1EqCUAV4y9nQ0aHcev//7+7bDkwB77M/VTLyT/xrSK9
         CNwWElg9D3uya+MJ42AXg76mEqCQW4gRVmgb2ofSbC5BS0vDa/EnkqX40ziw9PQ6PT80
         fC2UpzN5PwwaXHBK41rv5ien1QS+JvRvrU+IEO3Q5WVHTnaLyc2Koz63fipXbt2g2yg4
         Pg4zXCTDkyRabYQoGtf/03yndZPxWQ8cgZuVT4HX85veiRXSWS0pwS1m9Remy4RTLcyH
         +6LzaxvW//6EhxadxRp3Jtv/VxhMy6PqCkLxKwrbvnX77qBtueCm1ekQ01Vs1tYA0LGz
         yIuQ==
X-Gm-Message-State: ACgBeo2A+qdBu/WWM4X0NHvn5/95M/J1x246+lR8hjpsY29etl+WvyzT
        hG3SSKPoAKZIEuRbwOntdm1CiQT6HWOQrUMfqXJYOX0IsNa2V/mx5vxZyamX/jC4mr7g0XXGMlM
        YAy7exmIekOvbO29YFoT5sDOK
X-Received: by 2002:a05:620a:244f:b0:6b9:1f0b:7f37 with SMTP id h15-20020a05620a244f00b006b91f0b7f37mr13570488qkn.174.1660067990809;
        Tue, 09 Aug 2022 10:59:50 -0700 (PDT)
X-Google-Smtp-Source: AA6agR7LwD134opYI7m4cSVZp75ssZ8YAyGKFdgxTK2aDmMMrRhnIQSaR9RNq/3fS5K5eZbh8MiPpw==
X-Received: by 2002:a05:620a:244f:b0:6b9:1f0b:7f37 with SMTP id h15-20020a05620a244f00b006b91f0b7f37mr13570480qkn.174.1660067990568;
        Tue, 09 Aug 2022 10:59:50 -0700 (PDT)
Received: from xz-m1.local (bras-base-aurron9127w-grc-35-70-27-3-10.dsl.bell.ca. [70.27.3.10])
        by smtp.gmail.com with ESMTPSA id q15-20020ac8450f000000b0034303785596sm2723182qtn.34.2022.08.09.10.59.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Aug 2022 10:59:50 -0700 (PDT)
Date:   Tue, 9 Aug 2022 13:59:48 -0400
From:   Peter Xu <peterx@redhat.com>
To:     "Huang, Ying" <ying.huang@intel.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Andrea Arcangeli <aarcange@redhat.com>,
        David Hildenbrand <david@redhat.com>,
        Minchan Kim <minchan@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Nadav Amit <nadav.amit@gmail.com>,
        Hugh Dickins <hughd@google.com>,
        Andi Kleen <andi.kleen@intel.com>,
        "Kirill A . Shutemov" <kirill@shutemov.name>
Subject: Re: [PATCH v2 2/2] mm: Remember young/dirty bit for page migrations
Message-ID: <YvKglA2LQkYeznZ9@xz-m1.local>
References: <20220804203952.53665-1-peterx@redhat.com>
 <20220804203952.53665-3-peterx@redhat.com>
 <877d3hhksz.fsf@yhuang6-desk2.ccr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <877d3hhksz.fsf@yhuang6-desk2.ccr.corp.intel.com>
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 09, 2022 at 04:40:12PM +0800, Huang, Ying wrote:
> > @@ -2160,6 +2167,12 @@ static void __split_huge_pmd_locked(struct vm_area_struct *vma, pmd_t *pmd,
> >  				entry = pte_wrprotect(entry);
> >  			if (!young)
> >  				entry = pte_mkold(entry);
> > +			if (dirty)
> > +				/*
> > +				 * NOTE: this may contains setting soft
> > +				 * dirty too on some archs like x86.
> > +				 */
> 
> Personally, I prefer to put comments above "if (dirty)".  But you can
> choose your favorite way unless it violates coding style.

Sure.

> 
> > +				entry = pte_mkdirty(entry);
> 
> We don't track dirty flag even for normal PTE before.  So I think we
> should separate the dirty flag tracking for normal PTE in a separate
> patch.

It's kinda convenient to touch that up, but for sure I can split that into
a tiny but separate patch too.

[...]

> I don't find pte_dirty() is synced to PageDirty() as in
> try_to_migrate_one().  Is it a issue in the original code?

I think it has?  There is:

		/* Set the dirty flag on the folio now the pte is gone. */
		if (pte_dirty(pteval))
			folio_mark_dirty(folio);

?

Thanks,

-- 
Peter Xu

