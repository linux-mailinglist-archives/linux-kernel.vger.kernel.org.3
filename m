Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5931554D268
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 22:17:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243656AbiFOURA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 16:17:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242586AbiFOUQ6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 16:16:58 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5B3AC4D9F3
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 13:16:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1655324217;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=KkwY3eR126FjGjzwDQgo3l2d+v/rND/Bs0ek1ca5Ghc=;
        b=NTuZRm1tm6s6b5BQ2tsxkUMEioQQLxhVodZIXO6GfPuP4757/TDQe8irKAUdixxARBiVib
        L9qPe3UkERuA6qPdSNRVkwTZzRIvk0k1szuWHzmcLfyKdGYLjjns3x1mWFGe3P0sFgwouS
        e+SHWx/8oNfqhpNXoftHWXsMKEvdLCQ=
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com
 [209.85.166.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-93-jLav-KU7O8Ol1smqDwp_aw-1; Wed, 15 Jun 2022 16:16:56 -0400
X-MC-Unique: jLav-KU7O8Ol1smqDwp_aw-1
Received: by mail-il1-f200.google.com with SMTP id y18-20020a927d12000000b002d3dd2a5d53so9125844ilc.0
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 13:16:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=KkwY3eR126FjGjzwDQgo3l2d+v/rND/Bs0ek1ca5Ghc=;
        b=CuEu7hFuXmLekUSd/9PbKEQtgnwK54zcLm/f1zia0TyjVKNYc03r+JPDSd9EUjjG3y
         tk8BBMcwgAmuNJ+I8j3Vv6dCuGHBU8AdAbgbc59ZFXrsgGY47Wj2lSnyTgnEx9MOH1XM
         YlWdBESvuYCml706+HDaJq4wFudlANrQz1SLYpQIQm3T7Hba1JXhLs5lxOIlF84+C24c
         ZSnF7FgNc/JOoBwvX021iqKYVXywHAzLp+w5LhZhS4jbG2srt2GAWy0CtbJjsxHliFri
         mgjY2pJsWMf8Gkv81fDnMYVjq1AFAPqaSYoOeqJYmjA9/mkdNXqrrZMAQzlgKJ52D04J
         KBRQ==
X-Gm-Message-State: AJIora9BTbycRgk4JQZva6GRTMQcxO0IiK2z/9pOc/nqzuTWKvFg5NkG
        SaMCMpULdF+DQZShBaCRWmNn4M+AA+HUjCAMouoLXZcy0MP2LBdYE6HDPnbRnqFHKWZ0bWxwxLW
        /nOy9+ozDqYFB76dMes6QEe4R
X-Received: by 2002:a05:6e02:1bc1:b0:2d1:96b3:b961 with SMTP id x1-20020a056e021bc100b002d196b3b961mr918516ilv.213.1655324215646;
        Wed, 15 Jun 2022 13:16:55 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1tq2RmeOc+Cw38JYNDWY4FM4DxM7BCAIfsjmCVReo6Nm54OPHKau5ma9UITXSGSPYXAKWiOXA==
X-Received: by 2002:a05:6e02:1bc1:b0:2d1:96b3:b961 with SMTP id x1-20020a056e021bc100b002d196b3b961mr918500ilv.213.1655324215446;
        Wed, 15 Jun 2022 13:16:55 -0700 (PDT)
Received: from xz-m1.local (cpec09435e3e0ee-cmc09435e3e0ec.cpe.net.cable.rogers.com. [99.241.198.116])
        by smtp.gmail.com with ESMTPSA id e98-20020a02866b000000b00331a3909e46sm6551771jai.68.2022.06.15.13.16.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jun 2022 13:16:54 -0700 (PDT)
Date:   Wed, 15 Jun 2022 16:16:53 -0400
From:   Peter Xu <peterx@redhat.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Peter Collingbourne <pcc@google.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Nadav Amit <nadav.amit@gmail.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Yang Shi <shy828301@gmail.com>,
        Hugh Dickins <hughd@google.com>,
        Mel Gorman <mgorman@techsingularity.net>
Subject: Re: [PATCH v3] mm/mprotect: try avoiding write faults for exclusive
 anonymous pages when changing protection
Message-ID: <Yqo+NQBbEk1SU0cO@xz-m1.local>
References: <20220614093629.76309-1-david@redhat.com>
 <Yqn53TimQq33BanG@xz-m1.local>
 <3f190cd4-df87-feeb-bae4-56348498fa82@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <3f190cd4-df87-feeb-bae4-56348498fa82@redhat.com>
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 15, 2022 at 09:52:11PM +0200, David Hildenbrand wrote:
> write unprotection is a change from RO->RW, so I don't immediately see
> the difference.

In my view "unprotect a pte" is only a subset of "grant pte write
permission", since: "unprotect" has a prerequisite that it used to be
"protected" so that's why we can unprotect. Aka, in mm term that's only
when VM_WRITE set.

So basically it is a hint that we're only working on VM_WRITE regions,
where I thought "unprotect" was slightly better.

> 
> Anyhow, I don't like the sounding of TRY_WRITE_UNPROTECT.
> 
> I made it match the function name that I had:
> 
> MM_CP_TRY_CHANGE_WRITABLE
> -> !pte_write()?
>  -> can_change_pte_writable() ?
>   ->pte_mkwrite()
> 
> Maybe MM_CP_TRY_MAKE_WRITABLE / MM_CP_TRY_MAKE_PTE_WRITABLE is clearer?
> 
> Open for suggestions because I'm apparently not the bast at naming
> things either.

Me neither.  I don't have a strong opinion anyway, and frankly indeed the
old naming is not great either to me.  Maybe there's better thoughts.

Thanks,

-- 
Peter Xu

