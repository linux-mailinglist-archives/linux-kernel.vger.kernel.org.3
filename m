Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02C6750FC82
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 14:08:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349769AbiDZML2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 08:11:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345487AbiDZML0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 08:11:26 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D42915044E
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 05:08:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=oFju6382BGkZeSCzVjUNRKIZ/1PRe5wDyUSMoe2X2bs=; b=cixsBX/RRpllrTZFRx1hr8Maiv
        jF26zQymv/PfTCKgTN5mjT82DB8Ld0x3Yp2anTkssEu/bJMNsbpNaQ56kzjKX/dzVoVFowtIvisZm
        fl5rRr73u46yD7NTvbo/sdJN0pLkGxLdFEFLadtsmrA7b+glmX2Ryh3WM/QzPIeX/6uLV4KF8jsDS
        LwckdvOcKbqxohtL7SQkd81G91wQhHczN/eEpfCgaYl7K9qQvzt8+j/gXVtSlwDddErTa/DScdztB
        Dak/2i/zPGSKpjCVgKjE/qjhaZ2YCJuA/CE5Ygdxwa41o4UjMyIYOqT6O3b9aXQw0o6M4NrMqKuYS
        nvZSyAUw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1njJzE-009c41-AM; Tue, 26 Apr 2022 12:08:08 +0000
Date:   Tue, 26 Apr 2022 13:08:08 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Wan Jiabing <wanjiabing@vivo.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        David Howells <dhowells@redhat.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Julia Lawall <Julia.Lawall@inria.fr>
Subject: Re: [PATCH] mm/filemap: Fix NULL pointer dereference in
 pagecache_get_page
Message-ID: <YmfgqKcMmstgfz+0@casper.infradead.org>
References: <20220426082549.590899-1-wanjiabing@vivo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220426082549.590899-1-wanjiabing@vivo.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 26, 2022 at 04:25:48PM +0800, Wan Jiabing wrote:
> Fix following coccicheck error:
> mm/folio-compat.c:128:17-21: ERROR: folio is NULL but dereferenced.
>  	folio = __filemap_get_folio(mapping, index, fgp_flags, gfp);
> -	if ((fgp_flags & FGP_HEAD) || !folio || xa_is_value(folio))
> +	if (!folio)
> +		return NULL;
> +	if ((fgp_flags & FGP_HEAD) || xa_is_value(folio))
>  		return &folio->page;

That doesn't dereference the folio.  Coccicheck is wrong.
