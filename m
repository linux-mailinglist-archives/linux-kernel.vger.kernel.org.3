Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BCF7560F36
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Jun 2022 04:32:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231946AbiF3Cai (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jun 2022 22:30:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231887AbiF3CaU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jun 2022 22:30:20 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D96102FFEA
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jun 2022 19:30:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 956A561962
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jun 2022 02:30:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7CDFDC34114;
        Thu, 30 Jun 2022 02:30:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1656556208;
        bh=NnybmbeAGGn2R9XqSjtu72EBzlcQuCDFvjoFj0kGor8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=zokvkdPOolcqpwXgwOO/60AcLiBNevbBePZMYXAwx2dg3TDmLQtANAexZYqgs8MFY
         gKJOWFU/IKaw57VgNqZHSY9oxsLGBjaJvTvSuWnqz+gQtBdbreUCBjtVUzT832/cF6
         NUXTZ9cUQpPwBhnvJyNOkDaDUcqJFNkpZS9o2Jkw=
Date:   Wed, 29 Jun 2022 19:30:06 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Feng Tang <feng.tang@intel.com>
Cc:     Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, dave.hansen@intel.com,
        Joerg Roedel <jroedel@suse.de>,
        Robin Murphy <robin.murphy@arm.com>
Subject: Re: [RFC PATCH] mm/slub: enable debugging memory wasting of kmalloc
Message-Id: <20220629193006.77e9f071a5940e882c459cdd@linux-foundation.org>
In-Reply-To: <20220630014715.73330-1-feng.tang@intel.com>
References: <20220630014715.73330-1-feng.tang@intel.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 30 Jun 2022 09:47:15 +0800 Feng Tang <feng.tang@intel.com> wrote:

> kmalloc's API family is critical for mm, with one shortcoming that
> its object size is fixed to be power of 2. When user requests memory
> for '2^n + 1' bytes, actually 2^(n+1) bytes will be allocated, so
> in worst case, there is around 50% memory space waste.
> 
> We've met a kernel boot OOM panic, and from the dumped slab info:
> 
>     [   26.062145] kmalloc-2k            814056KB     814056KB
> 
> >From debug we found there are huge number of 'struct iova_magazine',
> whose size is 1032 bytes (1024 + 8), so each allocation will waste
> 1016 bytes. Though the issue is solved by giving the right(bigger)
> size of RAM, it is still better to optimize the size (either use
> a kmalloc friendly size or create a dedicated slab for it).

Well that's nice, and additional visibility is presumably a good thing.

But what the heck is going on with iova_magazine?  Is anyone looking at
moderating its impact?

