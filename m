Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 891B84BE4A4
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Feb 2022 18:59:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379697AbiBUPyO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Feb 2022 10:54:14 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:54660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379695AbiBUPyM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Feb 2022 10:54:12 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6318C26AF2
        for <linux-kernel@vger.kernel.org>; Mon, 21 Feb 2022 07:53:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=2TqQ5tRnp0eoGVknHFyaLoJzJMPsgZYTcbNRq7FHagU=; b=wLMc/Rg+ITMwdTiRmPZG3N00Gs
        vz/8IeufoThPVafZriOUNk3MriGnbrudifGg2G9Gnb1GHrZF3G+VHp4PFqkI5cK4830P0CbcecSZU
        crDwpYFjBlNBNlLdowIWURvNh3dU4bzDPrj8/Ow8LROPCmVxMyxY3j3dwdOPRFnIhyV4Afcaz6Zyk
        OZa2dpPw+NI2rI8ogND9dKYvekrfYCQ7/Cm5XnRPSQpdVvajtt5lPLfglDijMTr44ye97aO4/APfP
        OWxJcDVblxQNqtctdiDvRXb+yMUtPhB+/WsanXHpJoCY1tWu3kNw1kMOq8MAf1fx5w0Lt88dOnPeT
        tOQlmX4w==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nMB0O-001xiY-09; Mon, 21 Feb 2022 15:53:40 +0000
Date:   Mon, 21 Feb 2022 15:53:39 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Hyeonggon Yoo <42.hyeyoo@gmail.com>
Cc:     linux-mm@kvack.org, Roman Gushchin <guro@fb.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>, linux-kernel@vger.kernel.org,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        David Rientjes <rientjes@google.com>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>
Subject: Re: [PATCH 3/5] mm/slab: Do not call kmalloc_large() for unsupported
 size
Message-ID: <YhO1g3k00TeM8PTQ@casper.infradead.org>
References: <20220221105336.522086-1-42.hyeyoo@gmail.com>
 <20220221105336.522086-4-42.hyeyoo@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220221105336.522086-4-42.hyeyoo@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 21, 2022 at 10:53:34AM +0000, Hyeonggon Yoo wrote:
> SLAB's kfree() does not support freeing an object that is allocated from
> kmalloc_large(). Fix this as SLAB do not pass requests larger than
> KMALLOC_MAX_CACHE_SIZE directly to page allocator.

I was wondering if we wanted to go in the other direction and get rid of
kmalloc cache sizes larger than, say, 64kB from the SLAB allocator.

