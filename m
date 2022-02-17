Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7259D4B97A5
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Feb 2022 05:22:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233772AbiBQEWl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Feb 2022 23:22:41 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:34468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232064AbiBQEWj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Feb 2022 23:22:39 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1F2869D4E9
        for <linux-kernel@vger.kernel.org>; Wed, 16 Feb 2022 20:22:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1645071745;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=jsHNKqs8sMpQeIjeGlGIhSZmEPrsyGStco+1CJJy4J4=;
        b=ZTP+EAP0ORiDjA/Ai5P4tf7BbNDPgaiRBGyaibaDaViK2k4GGyO/TxIATx74SxVrTevCAG
        du9ClPwl38dil3A+QZ9+IPoByTh8jVyiQzdyUJmMYEzXOfU075Ie9PoKnLaDiZmp/RxKtZ
        8OLnd8RJb7355+BE4iB/dxIiMZQWYjo=
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com
 [209.85.210.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-256-Si1tqcCTOUyv5mf7ZRkdRQ-1; Wed, 16 Feb 2022 23:22:23 -0500
X-MC-Unique: Si1tqcCTOUyv5mf7ZRkdRQ-1
Received: by mail-pf1-f200.google.com with SMTP id b6-20020a621b06000000b004e1453487efso2522290pfb.22
        for <linux-kernel@vger.kernel.org>; Wed, 16 Feb 2022 20:22:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=jsHNKqs8sMpQeIjeGlGIhSZmEPrsyGStco+1CJJy4J4=;
        b=fGo/m4RC9BtLdIWDLncwKf5GMkZY3pa/nVvtqTi6H6IamaOmyj7b2ZmqXRnpt5/5hJ
         yfdau99vYL/ds0J7KGwKVgP37FoUQ4jLOivOK0y51tAl9pFSICNRPUF2dvV7lGSq1/xZ
         6ra6ZIqTh18/glXsNxFQaHKCBugsE049wu5YZ6hTNAIPOPQ7HvGe1HZTpHa59z+1FCSo
         QQFyjo0GwDdXX1keBUK53vPFMJSTAYX2GuhKXehNUO1mekEjy9mnrij7F+AOToVW8Uue
         Zw0Tj/SA0PLLeFqRFVuLClAdZOrPTeqzwAGDBe+bw+8avBeZCAs3CymnLrFoKNqYfi85
         3oGw==
X-Gm-Message-State: AOAM531MQlr6v02VGjuIwoODuJIvHViG8pdDV9ul9+IRBwHHF3PkosbP
        WurQ79QMkwCT+9HY7tCg8G2ZuDmQUus4RaP7P/fEuPBo4iVMHWoRMWPC8gvB7PKFxWyQTNt3tVN
        7TDEIcJacgJ8DQvW1jBZ32unR
X-Received: by 2002:a63:804:0:b0:365:62b2:28a1 with SMTP id 4-20020a630804000000b0036562b228a1mr1022795pgi.146.1645071742543;
        Wed, 16 Feb 2022 20:22:22 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxzatQDtItguYKWvjxxzFVQb2Ee0fT6oE3lB9g4Q+BrL4UMsaB+mFy9vjGoARR5VAgfcBX20w==
X-Received: by 2002:a63:804:0:b0:365:62b2:28a1 with SMTP id 4-20020a630804000000b0036562b228a1mr1022768pgi.146.1645071742188;
        Wed, 16 Feb 2022 20:22:22 -0800 (PST)
Received: from xz-m1.local ([94.177.118.126])
        by smtp.gmail.com with ESMTPSA id bf4sm605576pjb.10.2022.02.16.20.22.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Feb 2022 20:22:21 -0800 (PST)
Date:   Thu, 17 Feb 2022 12:22:14 +0800
From:   Peter Xu <peterx@redhat.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Matthew Wilcox <willy@infradead.org>,
        Yang Shi <shy828301@gmail.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Alistair Popple <apopple@nvidia.com>,
        David Hildenbrand <david@redhat.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Hugh Dickins <hughd@google.com>
Subject: Re: [PATCH v4 1/4] mm: Don't skip swap entry even if zap_details
 specified
Message-ID: <Yg3NdtG4Y63OCYxe@xz-m1.local>
References: <20220216094810.60572-1-peterx@redhat.com>
 <20220216094810.60572-2-peterx@redhat.com>
 <20220216185455.c5af4f44f90b103971f34e1f@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220216185455.c5af4f44f90b103971f34e1f@linux-foundation.org>
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 16, 2022 at 06:54:55PM -0800, Andrew Morton wrote:
> On Wed, 16 Feb 2022 17:48:07 +0800 Peter Xu <peterx@redhat.com> wrote:
> 
> > The "details" pointer shouldn't be the token to decide whether we should skip
> > swap entries.  For example, when the user specified details->zap_mapping==NULL,
> > it means the user wants to zap all the pages (including COWed pages), then we
> > need to look into swap entries because there can be private COWed pages that
> > was swapped out.
> 
> I assume "user" here means "caller".

Right.

> 
> > Skipping some swap entries when details is non-NULL may lead to wrongly leaving
> > some of the swap entries while we should have zapped them.
> > 
> > A reproducer of the problem:
> > 
> > ...
> >
> > The issue seems to exist starting from the initial commit of git.
> 
> I'll add cc:stable to this one, thanks.

Yes, thanks.

I didn't yet check the backports to stable yet, some of them might need some
tweaks on the patch.  I'll follow that up when it hits it.

-- 
Peter Xu

