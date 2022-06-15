Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD50054C7F0
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 13:54:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347230AbiFOLyN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 07:54:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347951AbiFOLyE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 07:54:04 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 801AC25CB;
        Wed, 15 Jun 2022 04:54:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=ZvNzq09TdLzqZwexljuHETkJeL+6Sds0r4wzjQ/HMi4=; b=i4MVsHiQuG8LAiV+GqX7FPx/Gk
        /3Tg3rurZJZ8OxfjdxMPfSslNT96JSU/5vr53PlGFmdDVaW7XyInbVmDA+JEuPSBhh4MXvqEtaaRM
        fpnX61iUuQff4KbGQyR/4J3vcwTDMYTn7uekJLv8VQbx7HDBKs+B9GWhfZHVCFSC5c4AFsauHQHVC
        jocf22X585lFpCZk6vhrJZ5Hgwv4SBz/5yMxzYg4iW0hhY5bkDlgmgnK6P0xCy4GcSqKdrCGFPH0v
        Aky09pIl07V83eXE3N+mzaOIoi/xrivF6WMm7zXamcRZsArr+jQwkXru0rQNt8nPgiCtxEuWeHjk/
        mQljCOwg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1o1Ray-00EISR-Pg; Wed, 15 Jun 2022 11:54:00 +0000
Date:   Wed, 15 Jun 2022 04:54:00 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Juergen Gross <jgross@suse.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        xen-devel@lists.xenproject.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>
Subject: Re: [PATCH] xen: don't require virtio with grants for non-PV guests
Message-ID: <YqnIWCXxsGzkfQp7@infradead.org>
References: <20220615084835.27113-1-jgross@suse.com>
 <YqnBZhiLOHnoalbC@infradead.org>
 <9b9785f5-085b-0882-177f-d8418c366beb@suse.com>
 <YqnCZ+EKZeZ5AEnr@infradead.org>
 <c5a521e0-26b1-b1d6-7f7d-00aa9b4b1e0e@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c5a521e0-26b1-b1d6-7f7d-00aa9b4b1e0e@suse.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 15, 2022 at 01:39:01PM +0200, Juergen Gross wrote:
> No, it doesn't. I'm working on a qemu patch series enabling the qemu
> based backends to support grants with virtio. The code is working fine
> on x86, too (apart from the fact that the backends aren't ready yet).

The code right now in mainline only ever sets the ops for DMA.  So
I can't see how you could make it work.
