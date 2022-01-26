Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D86149C41A
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jan 2022 08:16:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237673AbiAZHQC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jan 2022 02:16:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237647AbiAZHQB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jan 2022 02:16:01 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7363C06161C
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jan 2022 23:16:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=On3Q1c3Qq6iLqOHVi/d/TF+A/Lfpo2wsv2Ihe+ojSJw=; b=wNG6D/t1xfJGpmlDQ1D1VlIFTq
        ydXXhcg/jpP0aLcvm/COST+BusNZQ9+cOweLaQHnChaOvVJNcz5cutJZpyaTbveGaBbu9icU+HmJK
        mLOrTOwRdAvZrp7uRyOaeZfGdgXjezRe/2BpYz3qM45VIiqEdYYWMkNOb2hf26PAAOUHrmgy16D8W
        vhKmCbKfJavS7D+GXzZt2ZEoS+/yK9twIvauiBVAWgjswFzzzP+4+m6tCExHTucvNTCW0uTGSzrVg
        aha/3ZQCa9Rz7xwu7+1zPPgrZjlDzDpNuhdzRyR7KJsXOVp03Xua+B50mzvOXQKvgkPJiEgsPLZfR
        xDaQ6wCA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nCcX8-00ASZv-Qt; Wed, 26 Jan 2022 07:15:58 +0000
Date:   Tue, 25 Jan 2022 23:15:58 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Anshuman Khandual <anshuman.khandual@arm.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        hch@infradead.org, akpm@linux-foundation.org
Subject: Re: [RFC V1 01/31] mm/debug_vm_pgtable: Directly use
 vm_get_page_prot()
Message-ID: <YfD1Lijf+UKGBBzb@infradead.org>
References: <1643029028-12710-1-git-send-email-anshuman.khandual@arm.com>
 <1643029028-12710-2-git-send-email-anshuman.khandual@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1643029028-12710-2-git-send-email-anshuman.khandual@arm.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> +	 *
> +	 * Protection based vm_flags combinatins are always linear
> +	 * and increasing i.e VM_NONE ..[VM_SHARED|READ|WRITE|EXEC].
>  	 */
> -	for (idx = 0; idx < ARRAY_SIZE(protection_map); idx++) {
> +	for (i = VM_NONE; i <= (VM_SHARED | VM_READ | VM_WRITE | VM_EXEC); ix++) {
>  		pte_basic_tests(&args, idx);
>  		pmd_basic_tests(&args, idx);
>  		pud_basic_tests(&args, idx);

This looks rather convoluted.  I'd prefer to add a helper for the body
of this loop, and then explicitly call it for all the valid
combinations.  Right now all are valid, so this dosn't change a thing
except for generating larger code due to the explicit loop unrolling,
but I think it is much easier to follow and maintain.
