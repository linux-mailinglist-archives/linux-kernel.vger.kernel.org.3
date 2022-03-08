Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1EEB44D0ED6
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 05:48:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234897AbiCHEtS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Mar 2022 23:49:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231371AbiCHEtP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Mar 2022 23:49:15 -0500
Received: from out0.migadu.com (out0.migadu.com [IPv6:2001:41d0:2:267::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6BE1338A6
        for <linux-kernel@vger.kernel.org>; Mon,  7 Mar 2022 20:48:19 -0800 (PST)
Date:   Mon, 7 Mar 2022 20:48:12 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1646714897;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=vwPcToi9QpulPXpEM+stuEjonF0SMUUBzZ8wliMqGlo=;
        b=OlJkXSjVDTVlrBLHK8ZjiPsXZ7TMAsuvCI5ANkiop9ow580mlFtOzP97SI2sH0tpx0BVjS
        /PierWl3bL6xVr/kciJ870Px0Jvv5J1IaKHdBP/4Galaf/sdjDbt74xkq7DYBzohUWTTma
        GDBEwJ5kTqiYmR/+TwDSbhYF3n68mc8=
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
Subject: Re: [PATCH v3 1/2] mm/slub: limit number of node partial slabs only
 in cache creation
Message-ID: <YibgDEmQRCpvl/uu@carbon.dhcp.thefacebook.com>
References: <20220307074057.902222-1-42.hyeyoo@gmail.com>
 <20220307074057.902222-2-42.hyeyoo@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220307074057.902222-2-42.hyeyoo@gmail.com>
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

On Mon, Mar 07, 2022 at 07:40:55AM +0000, Hyeonggon Yoo wrote:
> SLUB sets number of minimum partial slabs for node (min_partial)
> using set_min_partial(). SLUB holds at least min_partial slabs even if
> they're empty to avoid excessive use of page allocator.
> 
> set_min_partial() limits value of min_partial limits value of
> min_partial MIN_PARTIAL and MAX_PARTIAL. As set_min_partial() can be
> called by min_partial_store() too, Only limit value of min_partial
> in kmem_cache_open() so that it can be changed to value that a user wants.
> 
> [ rientjes@google.com: Fold set_min_partial() into its callers ]
> 
> Signed-off-by: Hyeonggon Yoo <42.hyeyoo@gmail.com>
> Reviewed-by: Vlastimil Babka <vbabka@suse.cz>

LGTM!

Reviewed-by: Roman Gushchin <roman.gushchin@linux.dev>
