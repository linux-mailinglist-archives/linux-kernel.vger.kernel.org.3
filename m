Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C44C74A72A5
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Feb 2022 15:04:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237492AbiBBOE2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Feb 2022 09:04:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231852AbiBBOE0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Feb 2022 09:04:26 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5600FC061714
        for <linux-kernel@vger.kernel.org>; Wed,  2 Feb 2022 06:04:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=kBjoQP6Uo0tPLosDtcT2XD2WLyNHA0G/D9g0cgaEJ1s=; b=qNrg5H1tXfWMIelRnu2c5IChMR
        SxvYzy2q1Qz/V/D+1qgvX4VYVALTKEa4QCT8dJHlH/codrG1FAGGdbcRZHQ/Z8l5QUt8lgVgnAUO/
        VQ1wS6B+RO+uMUvnBQLumW86x4+TRQ56B9bhcaDiDnQQEZozriePY+mt3LG7/sFEzdWt4y41Z+f5S
        gyrBw+GCA6Un0Z70N7HdEA5sACSh6NvcsW+CQ8gyLZ4u+wbKz+luSGxP27ANbUMrYXGws4KdKdaqd
        WOdBX5g/Isz6KQJhk8S90Z7SdeqIWNwNDTEOajzHe1D5ble409oUMkBPd6vqTtBHoFV/Kl3r4jQQN
        SXt9saFA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nFGF8-00FWUe-0f; Wed, 02 Feb 2022 14:04:18 +0000
Date:   Wed, 2 Feb 2022 06:04:17 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     John Hubbard <jhubbard@nvidia.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Peter Xu <peterx@redhat.com>, Jason Gunthorpe <jgg@ziepe.ca>,
        Jan Kara <jack@suse.cz>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        =?iso-8859-1?B?Suly9G1l?= Glisse <jglisse@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>, linux-mm@kvack.org
Subject: Re: [PATCH 1/4] mm: Fix invalid page pointer returned with FOLL_PIN
 gups
Message-ID: <YfqPYbxGKoeHNhGv@infradead.org>
References: <20220131051752.447699-1-jhubbard@nvidia.com>
 <20220131051752.447699-2-jhubbard@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220131051752.447699-2-jhubbard@nvidia.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 30, 2022 at 09:17:49PM -0800, John Hubbard wrote:
> From: Peter Xu <peterx@redhat.com>
> 
> Alex reported invalid page pointer returned with pin_user_pages_remote() from
> vfio after upstream commit 4b6c33b32296 ("vfio/type1: Prepare for batched
> pinning with struct vfio_batch").  This problem breaks NVIDIA vfio mdev.

I haven't actually seen any nvidia mdev module in the tree.
