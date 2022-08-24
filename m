Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A97059F235
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Aug 2022 05:54:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233472AbiHXDy2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Aug 2022 23:54:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232676AbiHXDyX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Aug 2022 23:54:23 -0400
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B33C491EA
        for <linux-kernel@vger.kernel.org>; Tue, 23 Aug 2022 20:54:23 -0700 (PDT)
Received: by mail-pg1-x52a.google.com with SMTP id r69so13951825pgr.2
        for <linux-kernel@vger.kernel.org>; Tue, 23 Aug 2022 20:54:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc;
        bh=PhpgZPFUtaUU9Q/iQOAzkVlGcu68oagMhy31aoIg+aA=;
        b=NNBeqrnklN2r2dr4Dqt8daNMCTW3z7H1rnjvaDn2gWmThrsvbpUOf7D0O+9/j3rzoW
         +WpAMznacX2JKhk+6q4ZCzCTQ1gHzTxmtzNvJq82f6TQ77BB3+ChKnYnxaen9vQo8f0Z
         zdrTxj30KMpWcdanZlqz5K3zVYx0/zFTDcqHLGEJKffTP8d0HwfTBG5cJJsp09No0l1R
         f0LTdtQlyl+c89ocXNz7vQvTtxndY56O62ex8h1grOP02reWznwas3F7WIaYTrgPjW/+
         cZKTbkDcMPKHRh/RxRSqjSVmJp+RowmhgNfX24JwhWJ4SfevgF+xXuNm2WFZFC/n5PEs
         vMYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=PhpgZPFUtaUU9Q/iQOAzkVlGcu68oagMhy31aoIg+aA=;
        b=k6mBnuBx4OkT083CCcLpa7FpNL5RVOoMAZ1Z2rkEvrXx72lqJL/u6GSYDsU5pm4lv/
         ptjjSsAuTeMN8TxCncFo7gEOIKcnbFBfRguVl+/EtJ8S74ZIWhAoXiz+MOLCFdfmKt+9
         C/aOGYseM9rMRS3VaTup/HlijweVDvN34enRbXgj0lzXPCrCmzAvHia3guciSUZFAF/A
         NpbMTc7nqL8rKcCTHxOkJN7A9okwFD4EV0gRoEIrZj6aLQ548ObjWDgda+MdT30U4INo
         cEImm1wT1Kp3sXM2O+hR98iYwkrNwbrehl6y/n57so7C6Ak4NaKDfi5WV27HCI/UDIFj
         MvCQ==
X-Gm-Message-State: ACgBeo0XihBVaY8qr7bS4W6a37c414jk1d42YC9OioMesXgYiAbSroz+
        U4M4yuBsy95dlZxJbG+ZD/M=
X-Google-Smtp-Source: AA6agR7dXxxKnMRZUrOTwunLitSYOa4t6HHRBE/PA8aK7edN/NphlVv1F5mJiKwnyVIE6LF9sP9sKA==
X-Received: by 2002:a63:2a02:0:b0:42b:2711:d534 with SMTP id q2-20020a632a02000000b0042b2711d534mr64858pgq.176.1661313262784;
        Tue, 23 Aug 2022 20:54:22 -0700 (PDT)
Received: from hyeyoo ([114.29.91.56])
        by smtp.gmail.com with ESMTPSA id 88-20020a17090a09e100b001f94d25bfabsm174610pjo.28.2022.08.23.20.54.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Aug 2022 20:54:19 -0700 (PDT)
Date:   Wed, 24 Aug 2022 12:54:14 +0900
From:   Hyeonggon Yoo <42.hyeyoo@gmail.com>
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Roman Gushchin <roman.gushchin@linux.dev>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 13/17] mm/sl[au]b: cleanup
 kmem_cache_alloc[_node]_trace()
Message-ID: <YwWg5g8sfw0r9ypH@hyeyoo>
References: <20220817101826.236819-1-42.hyeyoo@gmail.com>
 <20220817101826.236819-14-42.hyeyoo@gmail.com>
 <df514b30-3a9a-679e-1851-7589526960a1@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <df514b30-3a9a-679e-1851-7589526960a1@suse.cz>
X-Spam-Status: No, score=-0.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,HK_RANDOM_ENVFROM,
        HK_RANDOM_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 23, 2022 at 05:04:36PM +0200, Vlastimil Babka wrote:
> On 8/17/22 12:18, Hyeonggon Yoo wrote:
> > This patch does:
> 
> I've removed this line locally and re-idented the rest.

Ah, thanks. looks better.

> > 	- Despite its name, kmem_cache_alloc[_node]_trace() is hook for
> > 	  inlined kmalloc. So rename it to kmalloc[_node]_trace().
> > 
> > 	- Move its implementation to slab_common.c by using
> >           __kmem_cache_alloc_node(), but keep CONFIG_TRACING=n varients to
> > 	  save a function call when CONFIG_TRACING=n.
> > 
> > 	- Use __assume_kmalloc_alignment for kmalloc[_node]_trace
> > 	  instead of __assume_slab_alignement. Generally kmalloc has
> > 	  larger alignment requirements.
> > 
> > Suggested-by: Vlastimil Babka <vbabka@suse.cz>
> > Signed-off-by: Hyeonggon Yoo <42.hyeyoo@gmail.com>
> 
> Reviewed-by: Vlastimil Babka <vbabka@suse.cz>

Thanks!

-- 
Thanks,
Hyeonggon
