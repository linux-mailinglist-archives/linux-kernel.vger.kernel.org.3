Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5CFB5A9D44
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 18:41:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234485AbiIAQkq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 12:40:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232404AbiIAQko (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 12:40:44 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 736FD2B245
        for <linux-kernel@vger.kernel.org>; Thu,  1 Sep 2022 09:40:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1662050442;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=A/nMIHK86arro9noAagcH6dFQdyi31EgjkmWhoBXsjo=;
        b=JvCbHA38cUUZPupCFOAhO8+iQn4cb5J43T3gzzuC0Umqw6oBYM5isPHMGdlmeLn4z62bGA
        DmYny5/G8COD9smUDCtVB+g5q5QHM+9uKkdGLD4w6nOPLmcH3SCHBleEMclGLG3Kqci8mi
        6PewQf+bRHADyMK6cD25+8Md8aaef+g=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-231-SB561SSqP_y7MaNmAopwyQ-1; Thu, 01 Sep 2022 12:40:41 -0400
X-MC-Unique: SB561SSqP_y7MaNmAopwyQ-1
Received: by mail-qk1-f199.google.com with SMTP id f1-20020a05620a280100b006bc4966f463so14733336qkp.4
        for <linux-kernel@vger.kernel.org>; Thu, 01 Sep 2022 09:40:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=A/nMIHK86arro9noAagcH6dFQdyi31EgjkmWhoBXsjo=;
        b=KmIsqyrpPWuelHHDaCvr6tgtuL9NfUsEKSNyZHZCWOoLKj37vyRrQ+9errPDhxabzp
         gYE10B/xkEgSQ5RCaB9F//iEZpXn6V9jNN0U2jzmFXmFG/DScuY718hiRGZCSf6nzMYN
         ZMQUYIva3T0PvMUnmn2uz76W581pqGqZ/TjaSsMf0pM9TH1MUd33k8s+75NUIpoS6V/S
         H6J/9T7aqpOpOkY5aaypEf5KEzuXkvPPhr3RMBfv861LFNkniiIq6X7hCxZpG92TmJ0d
         gBE2LLIpphKAop7M8PkOd7hRYKyLGhEVuvp77/fYcvPW5oD+ZdPaXeEuUuv466WUW7eW
         eylw==
X-Gm-Message-State: ACgBeo1QWqNE21fNccpD6melUIi/gwWksuYdURdLnTxIH5Ao0dxvDe2T
        UmPwHMUx7O/m7brHNW+LryyFdIxLlJYt2qrlblcKA7Uo9MDbdyCzCNkN8mYWcP1CU9gu77feAUY
        8psfk4veSZtZWLiktEIgD6zz3
X-Received: by 2002:a05:6214:246b:b0:497:28b7:d411 with SMTP id im11-20020a056214246b00b0049728b7d411mr24701935qvb.128.1662050441197;
        Thu, 01 Sep 2022 09:40:41 -0700 (PDT)
X-Google-Smtp-Source: AA6agR6MS53lmxGSQT61ajcBBr0tov+zWwrNh1g766JGRTCtjpX/L+p5GXxooVqt8Z75SFx2xdREzg==
X-Received: by 2002:a05:6214:246b:b0:497:28b7:d411 with SMTP id im11-20020a056214246b00b0049728b7d411mr24701907qvb.128.1662050440899;
        Thu, 01 Sep 2022 09:40:40 -0700 (PDT)
Received: from xz-m1.local (bras-base-aurron9127w-grc-35-70-27-3-10.dsl.bell.ca. [70.27.3.10])
        by smtp.gmail.com with ESMTPSA id fg15-20020a05622a580f00b0034456277e3asm10657307qtb.89.2022.09.01.09.40.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Sep 2022 09:40:40 -0700 (PDT)
Date:   Thu, 1 Sep 2022 12:40:38 -0400
From:   Peter Xu <peterx@redhat.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Sasha Levin <sasha.levin@oracle.com>,
        "Aneesh Kumar K . V" <aneesh.kumar@linux.vnet.ibm.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Jerome Marchand <jmarchan@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Hugh Dickins <hughd@google.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Yang Shi <shy828301@gmail.com>
Subject: Re: [PATCH v1] mm/gup: adjust stale comment for RCU GUP-fast
Message-ID: <YxDghv54uHYMGCfG@xz-m1.local>
References: <20220901072119.37588-1-david@redhat.com>
 <YxDdycTur733hMgt@xz-m1.local>
 <fa0bb4b1-3edd-eb5a-7ad6-dff785d88d8f@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <fa0bb4b1-3edd-eb5a-7ad6-dff785d88d8f@redhat.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 01, 2022 at 06:34:41PM +0200, David Hildenbrand wrote:
> On 01.09.22 18:28, Peter Xu wrote:
> > On Thu, Sep 01, 2022 at 09:21:19AM +0200, David Hildenbrand wrote:
> >> commit 4b471e8898c3 ("mm, thp: remove infrastructure for handling splitting
> >> PMDs") didn't remove all details about the THP split requirements for
> >> RCU GUP-fast.
> >>
> >> IPI broeadcasts on THP split are no longer required.
> >>
> >> Cc: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> >> Cc: Sasha Levin <sasha.levin@oracle.com>
> >> Cc: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
> >> Cc: Vlastimil Babka <vbabka@suse.cz>
> >> Cc: Jerome Marchand <jmarchan@redhat.com>
> >> Cc: Andrea Arcangeli <aarcange@redhat.com>
> >> Cc: Hugh Dickins <hughd@google.com>
> >> Cc: Jason Gunthorpe <jgg@nvidia.com>
> >> Cc: John Hubbard <jhubbard@nvidia.com>
> >> Cc: Peter Xu <peterx@redhat.com>
> >> Cc: Yang Shi <shy828301@gmail.com>
> >> Signed-off-by: David Hildenbrand <david@redhat.com>
> >> ---
> >>  mm/gup.c | 5 ++---
> >>  1 file changed, 2 insertions(+), 3 deletions(-)
> >>
> >> diff --git a/mm/gup.c b/mm/gup.c
> >> index 5abdaf487460..cfe71f422787 100644
> >> --- a/mm/gup.c
> >> +++ b/mm/gup.c
> >> @@ -2309,9 +2309,8 @@ EXPORT_SYMBOL(get_user_pages_unlocked);
> >>   *
> >>   * Another way to achieve this is to batch up page table containing pages
> >>   * belonging to more than one mm_user, then rcu_sched a callback to free those
> >> - * pages. Disabling interrupts will allow the fast_gup walker to both block
> >> - * the rcu_sched callback, and an IPI that we broadcast for splitting THPs
> >> - * (which is a relatively rare event). The code below adopts this strategy.
> >> + * pages. Disabling interrupts will allow the fast_gup walker to block the
> >> + * rcu_sched callback.
> > 
> > This is the comment for fast-gup in general but not only for thp split.
> 
> "an IPI that we broadcast for splitting THP" is about splitting THP.

Ah OK.  Shall we still keep some "IPI broadcast" information here if we're
modifying it?  Otherwise it gives a feeling that none needs the IPIs.

It can be dropped later if you want to rework the thp collapse side and
finally remove IPI dependency on fast-gup, but so far it seems to me it's
still needed.  Or just drop this patch until that rework happens?

> 
> > 
> > I can understand that we don't need IPI for thp split, but isn't the IPIs
> > still needed for thp collapse (aka pmdp_collapse_flush)?
> 
> That was, unfortunately, never documented -- and as discussed in the
> other thread, arm64 doesn't do that IPI before collapse and might need
> fixing. We'll most probably end up getting rid of that
> (undocumented/forgotten) IPI requirement and fix it in GUP-fast by
> re-rechecking if the PMD changed.

Yeah from an initial thought that looks valid to me.  It'll also allow
pmdp_collapse_flush() to be dropped too, am I right?

-- 
Peter Xu

