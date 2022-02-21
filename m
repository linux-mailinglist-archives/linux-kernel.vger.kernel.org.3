Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 063764BE93D
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Feb 2022 19:07:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379517AbiBUPq7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Feb 2022 10:46:59 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:40728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379535AbiBUPqs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Feb 2022 10:46:48 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC46022BC4
        for <linux-kernel@vger.kernel.org>; Mon, 21 Feb 2022 07:46:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=EV7HusSbqWhNkY6/yDWEBcroanF8730OLiwfi90dM0U=; b=PqmHvcn5WHBDlUEiZgM3d6y6X7
        YSEkREN6468+QSX/Tp6pQPcMEU4y6x+2BZ+wooWcCbEGIA9VIfi8De17UjztlZPHS5jZWCe85tWr4
        6Tp9Tj0ZhwCedYLwaS5ChBZN1M54jF/oKeLLc5tN2Ky7XucuTYPDsqUUm+k59QBOYPO6ar/iU7FWO
        Oh2dKPcmmBECbYYaxBLBhod3ZyVGXqBd94tp9MCmeZ67WmD8vLmIdwM/XbtwDGEE4B76cc9E2cc2Y
        3rYaAj5ST6vRC1n8JkGKbRAlysqNKRKG+Ym/+pXyzucjhUo5GWzNBGGnSXVFKVa2w+vG56sA88q4q
        +g4H7anA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nMAsz-001xOo-2s; Mon, 21 Feb 2022 15:46:01 +0000
Date:   Mon, 21 Feb 2022 15:46:01 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Hyeonggon Yoo <42.hyeyoo@gmail.com>
Cc:     linux-mm@kvack.org, Roman Gushchin <guro@fb.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>, linux-kernel@vger.kernel.org,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        David Rientjes <rientjes@google.com>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>
Subject: Re: [PATCH 2/5] mm/sl[auo]b: Do not export __ksize()
Message-ID: <YhOzuUDZwVx5CO09@casper.infradead.org>
References: <20220221105336.522086-1-42.hyeyoo@gmail.com>
 <20220221105336.522086-3-42.hyeyoo@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220221105336.522086-3-42.hyeyoo@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 21, 2022 at 10:53:33AM +0000, Hyeonggon Yoo wrote:
> Do not export __ksize(). Only kasan calls __ksize() directly.

We should probably delete (most of) the kernel-doc comment on __ksize,
leaving only the note that it's uninstrumented and only called by
kasan.  Also, we should probably move the declaration of __ksize from
include/linux/slab.h to mm/slab.h since we don't want to grow new callers.

