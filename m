Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 376C25873E7
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Aug 2022 00:26:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235305AbiHAWZt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Aug 2022 18:25:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235332AbiHAWZp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Aug 2022 18:25:45 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id F0B3143E62
        for <linux-kernel@vger.kernel.org>; Mon,  1 Aug 2022 15:25:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1659392744;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=JuDYx7rY0J8nhH7yYroLa1iYucx7uxXCdAdFRarEXz8=;
        b=H71KrKltcJ8w9Sv/dMkhi618ocoDzgSh8tMUnL9riNL+HCJegMxJgOZfDSV7CD+hyPUkJj
        nanoqkTZAWUSgiATHqlWWDf9f1oqX46rD/+DrHqrxXUjB95lVmEycWb/2tnraC2rnjtvkH
        qLdestzfu8Yk/VKL5z/ctrBNsn0gQdU=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-103-kx7v_k3eP2qOpGuXXXaW2g-1; Mon, 01 Aug 2022 18:25:42 -0400
X-MC-Unique: kx7v_k3eP2qOpGuXXXaW2g-1
Received: by mail-qk1-f200.google.com with SMTP id az14-20020a05620a170e00b006b666c4627bso10365879qkb.23
        for <linux-kernel@vger.kernel.org>; Mon, 01 Aug 2022 15:25:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=JuDYx7rY0J8nhH7yYroLa1iYucx7uxXCdAdFRarEXz8=;
        b=mEbEnpR0wU5QoJF2o0d6n+nzj5I4dmcecXOI13T6Ar1G/7FyvmDPleZThm3Uzl6OGi
         dTOe9K4fxrfHQMS+qfDAzILn7WcPmz8Dj+abqY8mYvnaxIwvS6XOjE8bY02+byGVnhlI
         WqpVJY9yFpDVBwxivOqPFFYrKn2kJWpZrJJ2EyzqPah48DPVFFLunQ+n2nB5IdtIu60a
         s2BHVvgWzXExMNZcRYtvzJzhVOWjURcLnRH80yUqJl0mvQXZrrbXiPgzsez7+MZYZYQ/
         Cn4Z2SUnGnAS/bCEOYEiziqQgxzYlVwEZWQM2EAl9s9Zb6E2t8MjL5+P5YP/kU8fRwb9
         U8Tw==
X-Gm-Message-State: AJIora9cDEld1h99mnu6vdmX2Xatry/zILWYOvwIgR+o/FV73zXGkgSd
        ep/rpEwqm1O+gGhZK9XRH2W0Ahvf/0lTgIdtV1Mz4mP9ZL/z2Tp1vOdv09XMJ0OgSVIJS9sGD4h
        ueBz66se/kBq4Xqa1E6edyNei
X-Received: by 2002:ac8:7fcd:0:b0:31f:393a:7320 with SMTP id b13-20020ac87fcd000000b0031f393a7320mr16130503qtk.11.1659392742428;
        Mon, 01 Aug 2022 15:25:42 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1s9QavQ6UCl89HWn9HB+y/pVPGLyyjDb7YjYhagDxykylUdwhjqBKKeaWnrBZ77w3N/uo9SQA==
X-Received: by 2002:ac8:7fcd:0:b0:31f:393a:7320 with SMTP id b13-20020ac87fcd000000b0031f393a7320mr16130479qtk.11.1659392742210;
        Mon, 01 Aug 2022 15:25:42 -0700 (PDT)
Received: from xz-m1.local (bras-base-aurron9127w-grc-35-70-27-3-10.dsl.bell.ca. [70.27.3.10])
        by smtp.gmail.com with ESMTPSA id dm52-20020a05620a1d7400b006a6ab259261sm9120434qkb.29.2022.08.01.15.25.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Aug 2022 15:25:41 -0700 (PDT)
Date:   Mon, 1 Aug 2022 18:25:40 -0400
From:   Peter Xu <peterx@redhat.com>
To:     "Huang, Ying" <ying.huang@intel.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Andrea Arcangeli <aarcange@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Nadav Amit <nadav.amit@gmail.com>,
        Hugh Dickins <hughd@google.com>,
        David Hildenbrand <david@redhat.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Andi Kleen <andi.kleen@intel.com>
Subject: Re: [PATCH RFC 0/4] mm: Remember young bit for migration entries
Message-ID: <YuhS5DcwwNvy2Rkn@xz-m1.local>
References: <20220729014041.21292-1-peterx@redhat.com>
 <87pmhkjzo7.fsf@yhuang6-desk2.ccr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87pmhkjzo7.fsf@yhuang6-desk2.ccr.corp.intel.com>
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 01, 2022 at 01:33:28PM +0800, Huang, Ying wrote:
> If my understanding were correct, max_swapfile_size() provides a
> mechanism to identify the available bits with swp_entry_t and swap PTE
> considered.  We may take advantage of that?

That's an interesting trick, I'll have a closer look, thanks for the
pointer!

> 
> And according to commit 377eeaa8e11f ("x86/speculation/l1tf: Limit swap
> file size to MAX_PA/2"), the highest bit of swap offset needs to be 0 if
> L1TF mitigation is enabled.
> 
> Cced Andi for confirmation.

Yeah it'll be great to have a confirmation, hopefully max_swapfile_size()
should have covered that case.

-- 
Peter Xu

