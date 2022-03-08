Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52BD94D0EEB
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 06:02:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240007AbiCHFC6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 00:02:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230105AbiCHFC4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 00:02:56 -0500
Received: from out0.migadu.com (out0.migadu.com [IPv6:2001:41d0:2:267::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 537CB33EA1
        for <linux-kernel@vger.kernel.org>; Mon,  7 Mar 2022 21:02:01 -0800 (PST)
Date:   Mon, 7 Mar 2022 21:01:54 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1646715719;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=5tjFk/Dw764Ls2/rcpPUJ5xUi4eZvU9dCCyj5nTruvU=;
        b=r4kEFYEK9oik/rlloyN04+OvtWokBLsP8excAZk/EXHJG4PWktet51F1ifiJLdFEJgsRx8
        ZHe7uAJcZU1X+lv4XbGXIgLUwxoV4zJZEkf7EYkzwVt8QICyG33Uiv4VYWbH4eNBWveA9F
        4Hau37Oq3BIdWC1jPN7yh7yrXYC7dr4=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Roman Gushchin <roman.gushchin@linux.dev>
To:     Hyeonggon Yoo <42.hyeyoo@gmail.com>
Cc:     linux-mm@kvack.org, Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Marco Elver <elver@google.com>,
        Matthew WilCox <willy@infradead.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/2] mm/slub: refactor deactivate_slab()
Message-ID: <YibjQpm55PldiKji@carbon.dhcp.thefacebook.com>
References: <20220307074057.902222-1-42.hyeyoo@gmail.com>
 <20220307074057.902222-3-42.hyeyoo@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220307074057.902222-3-42.hyeyoo@gmail.com>
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: linux.dev
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 07, 2022 at 07:40:56AM +0000, Hyeonggon Yoo wrote:
> Simplify deactivate_slab() by unlocking n->list_lock and retrying
> cmpxchg_double() when cmpxchg_double() fails, and perform
> add_{partial,full} only when it succeed.
> 
> Releasing and taking n->list_lock again here is not harmful as SLUB
> avoids deactivating slabs as much as possible.
> 
> [ vbabka@suse.cz: perform add_{partial,full} when cmpxchg_double()
>   succeed.
> 
>   count deactivating full slabs even if debugging flag is not set. ]
> 
> Signed-off-by: Hyeonggon Yoo <42.hyeyoo@gmail.com>

Reviewed-by: Roman Gushchin <roman.gushchin@linux.dev>

Thanks!
