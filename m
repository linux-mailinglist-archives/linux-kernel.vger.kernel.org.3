Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 319295A9D0F
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 18:29:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234995AbiIAQ3J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 12:29:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234533AbiIAQ3F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 12:29:05 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCCAB844C0
        for <linux-kernel@vger.kernel.org>; Thu,  1 Sep 2022 09:29:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1662049741;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Ss+788P3BPmasfJtALEqRKNF7dmBsC3V1B9rlxVbN7E=;
        b=J99b2zoJPqzq02cOxk9sezlOGfACIsFq9T9oSFkI7/u2k6Zxw15AJqgiGiKckJ2PpXT//X
        FONFr/9wmUJiDOgkyqhWQnwBKRZrKbXtKDHCZ/4JkzhoVBQ8Ngltc/leXVMj9ms8JQ3NKX
        DWUPpTDYm+/dT8BOSokSWfrza36CHy8=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-312-Nhr3XpbaOGer2HkqMvs42A-1; Thu, 01 Sep 2022 12:29:00 -0400
X-MC-Unique: Nhr3XpbaOGer2HkqMvs42A-1
Received: by mail-qv1-f71.google.com with SMTP id b16-20020ad45190000000b004972d2dbdbcso11462091qvp.1
        for <linux-kernel@vger.kernel.org>; Thu, 01 Sep 2022 09:28:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=Ss+788P3BPmasfJtALEqRKNF7dmBsC3V1B9rlxVbN7E=;
        b=WEy3vpYVnupl5HE3hH4zxYqifcs2qMWlkjoN+qx8pr3IBZ3VgesNqMzHqtFQR8Mz6d
         pT61CZ8chdVkSUhk+USvbhihRkhcx2aWjWqRghG6Z1yLwyFPu6hQ4xFUDTmRv4WgkvrY
         u2EbthqpvKckMkywnmQcGpmqjTwKZIeBDs4Y5w8zcdfIw82o0gTORT4OgXtrT+fRr+kI
         OVqnnkRY2Oku+Ooxl7DssozFFgljoqQ1T2bABcAvpUjkmp03hMG1lp6u+wV8+L2h/pyq
         bsmY48nUKPO7WmRYAtA23ell6Sm9d8b73lPPGz39GabeH172YCNCrCfQxvLlsdijRDrD
         50Hw==
X-Gm-Message-State: ACgBeo0gGLbA5n/YxpvbIUqtuWPRzTwoUIXhZFmwwFXB2AnLMmJqxN00
        UmsLuzDTZgQPuczZ6K9NQ6AaSVQRGNv/u52O/IN1mqxeKWV0fEsSJEF2GgT3aoe0gqfGmTNWHjG
        k35gcb80CiF8xiniqxShfMXBD
X-Received: by 2002:ac8:5a49:0:b0:343:6d5a:43ba with SMTP id o9-20020ac85a49000000b003436d5a43bamr25466056qta.63.1662049739572;
        Thu, 01 Sep 2022 09:28:59 -0700 (PDT)
X-Google-Smtp-Source: AA6agR5bxi3Vv6LuaC5ccFEhqjmnWsgxKw/LoMgvfdtqekeyRAG6cPfjRpPDsUg2NwAOhLCxkWUOvQ==
X-Received: by 2002:ac8:5a49:0:b0:343:6d5a:43ba with SMTP id o9-20020ac85a49000000b003436d5a43bamr25466026qta.63.1662049739359;
        Thu, 01 Sep 2022 09:28:59 -0700 (PDT)
Received: from xz-m1.local (bras-base-aurron9127w-grc-35-70-27-3-10.dsl.bell.ca. [70.27.3.10])
        by smtp.gmail.com with ESMTPSA id w2-20020a05622a134200b0034454d0c8f3sm11036763qtk.93.2022.09.01.09.28.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Sep 2022 09:28:58 -0700 (PDT)
Date:   Thu, 1 Sep 2022 12:28:57 -0400
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
Message-ID: <YxDdycTur733hMgt@xz-m1.local>
References: <20220901072119.37588-1-david@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220901072119.37588-1-david@redhat.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 01, 2022 at 09:21:19AM +0200, David Hildenbrand wrote:
> commit 4b471e8898c3 ("mm, thp: remove infrastructure for handling splitting
> PMDs") didn't remove all details about the THP split requirements for
> RCU GUP-fast.
> 
> IPI broeadcasts on THP split are no longer required.
> 
> Cc: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> Cc: Sasha Levin <sasha.levin@oracle.com>
> Cc: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
> Cc: Vlastimil Babka <vbabka@suse.cz>
> Cc: Jerome Marchand <jmarchan@redhat.com>
> Cc: Andrea Arcangeli <aarcange@redhat.com>
> Cc: Hugh Dickins <hughd@google.com>
> Cc: Jason Gunthorpe <jgg@nvidia.com>
> Cc: John Hubbard <jhubbard@nvidia.com>
> Cc: Peter Xu <peterx@redhat.com>
> Cc: Yang Shi <shy828301@gmail.com>
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  mm/gup.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/mm/gup.c b/mm/gup.c
> index 5abdaf487460..cfe71f422787 100644
> --- a/mm/gup.c
> +++ b/mm/gup.c
> @@ -2309,9 +2309,8 @@ EXPORT_SYMBOL(get_user_pages_unlocked);
>   *
>   * Another way to achieve this is to batch up page table containing pages
>   * belonging to more than one mm_user, then rcu_sched a callback to free those
> - * pages. Disabling interrupts will allow the fast_gup walker to both block
> - * the rcu_sched callback, and an IPI that we broadcast for splitting THPs
> - * (which is a relatively rare event). The code below adopts this strategy.
> + * pages. Disabling interrupts will allow the fast_gup walker to block the
> + * rcu_sched callback.

This is the comment for fast-gup in general but not only for thp split.

I can understand that we don't need IPI for thp split, but isn't the IPIs
still needed for thp collapse (aka pmdp_collapse_flush)?

-- 
Peter Xu

