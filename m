Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E61814BF337
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Feb 2022 09:12:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229602AbiBVILE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Feb 2022 03:11:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229531AbiBVILC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 03:11:02 -0500
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 455C1151C79
        for <linux-kernel@vger.kernel.org>; Tue, 22 Feb 2022 00:10:38 -0800 (PST)
Received: by mail-pg1-x534.google.com with SMTP id 139so16415983pge.1
        for <linux-kernel@vger.kernel.org>; Tue, 22 Feb 2022 00:10:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=dLYMT+TbMwuVBEVL1LUh/1FaEDF3RiFVyuJ9ryG9pZQ=;
        b=gUBGwwJmZWECPNwfVmegNKWUeav98YrSGHoSxgfJA/X2xB0S4dUuFT/Cj0845cc3Uq
         UIsotgAA/bwX6PZeLkVO2Cba7onUIGg8Mh8a+1a9D2mYVvzp434EV/xS/ZhP/ux6fMlZ
         Oo95xBBf9/VHpTG5XqOc6u9EqOmG0y36W53WlNRuhJR6GIX/320WyGOgejnzg8jXobLq
         UhPi/duN116Svel90rbXIWYWRGeeIYs2my18Fdsm99xEnCuZgAixxW9gDflFXbQentrL
         L2DgN05hfdZd2K/q4Y4r+W2IdMRpJJpyMn9GSL2dlEFBUhmqkIo/9fYvuMijZzFWH282
         jSLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=dLYMT+TbMwuVBEVL1LUh/1FaEDF3RiFVyuJ9ryG9pZQ=;
        b=QfEpPqZrJHd9fsOL8Ixe9M5JBizNuzMjfbofcg/0Pw+4A+dwTMC8aj38AdiH/C9x5w
         w0q/A7Auxi0S1AkZo4L3jHZL+MeV4AEojnzmpRZ+YAJQwQtCCZ37uz42K3Y16UNh16sM
         3kppFkHw15kB8j890LWIMIX6C3rR9HOL0HB3dnDxO9Z7arrLGkP4224WaTC4zyTlGlhN
         fixFYC6SvaLmOHRYEGq6ZmOsJm8OACcNy2MXgzvXZsslgiiKEjf7yl/Rjujc8DS9YrSw
         r1kEiTBkb0a9IfSyZagZ8BmnWj0Z7U84gfMMZToz7COf7OJo4lPPBGcQo0eevZspQVaL
         JNBw==
X-Gm-Message-State: AOAM5335An4i3Q8K0ZsgsWwpmKlnPAbS5sFJUzrlz1+A5gDnyidtVsZg
        gly7zY8zG1B1rCyNLgQJPnY=
X-Google-Smtp-Source: ABdhPJwyJGpw6LufCqfBxI6fEupQpGufZ1VQiF9jqroL+pDp5EvzTwJhjlV5dsPSpCEsFPwVXiwGZw==
X-Received: by 2002:a05:6a00:1a04:b0:4e1:786c:cce3 with SMTP id g4-20020a056a001a0400b004e1786ccce3mr23452111pfv.81.1645517437813;
        Tue, 22 Feb 2022 00:10:37 -0800 (PST)
Received: from ip-172-31-19-208.ap-northeast-1.compute.internal (ec2-18-181-137-102.ap-northeast-1.compute.amazonaws.com. [18.181.137.102])
        by smtp.gmail.com with ESMTPSA id p4sm20092924pgh.53.2022.02.22.00.10.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Feb 2022 00:10:37 -0800 (PST)
Date:   Tue, 22 Feb 2022 08:10:32 +0000
From:   Hyeonggon Yoo <42.hyeyoo@gmail.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     linux-mm@kvack.org, Roman Gushchin <guro@fb.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>, linux-kernel@vger.kernel.org,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        David Rientjes <rientjes@google.com>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>
Subject: Re: [PATCH 3/5] mm/slab: Do not call kmalloc_large() for unsupported
 size
Message-ID: <YhSaeKIBNbG81I07@ip-172-31-19-208.ap-northeast-1.compute.internal>
References: <20220221105336.522086-1-42.hyeyoo@gmail.com>
 <20220221105336.522086-4-42.hyeyoo@gmail.com>
 <YhO1g3k00TeM8PTQ@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YhO1g3k00TeM8PTQ@casper.infradead.org>
X-Spam-Status: No, score=-0.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,HK_RANDOM_ENVFROM,
        HK_RANDOM_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 21, 2022 at 03:53:39PM +0000, Matthew Wilcox wrote:
> On Mon, Feb 21, 2022 at 10:53:34AM +0000, Hyeonggon Yoo wrote:
> > SLAB's kfree() does not support freeing an object that is allocated from
> > kmalloc_large(). Fix this as SLAB do not pass requests larger than
> > KMALLOC_MAX_CACHE_SIZE directly to page allocator.
> 
> I was wondering if we wanted to go in the other direction and get rid of
> kmalloc cache sizes larger than, say, 64kB from the SLAB allocator.

Good point.

Hmm.. I don't think SLAB is benefiting from queueing that large objects,
and maximum size is still limited to what buddy allocator supports.

I'll try reducing kmalloc caches up to order-1 page like SLUB.
That would be easier to maintain.

Thanks,
Hyeonggon
