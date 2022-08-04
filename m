Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 581505896C1
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Aug 2022 05:54:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237489AbiHDDy3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Aug 2022 23:54:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231201AbiHDDy0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Aug 2022 23:54:26 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A3D660524
        for <linux-kernel@vger.kernel.org>; Wed,  3 Aug 2022 20:54:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BA47E617FE
        for <linux-kernel@vger.kernel.org>; Thu,  4 Aug 2022 03:54:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE97BC433D6;
        Thu,  4 Aug 2022 03:54:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659585265;
        bh=TRaZPizYt0MhyTdvIV5gDkYU2dqlDxCp3JATlfnKkos=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bggZUorbj0n4/fqwqMqaZFYuRhR0NLjKaELiYSxT03PoFapIaC+cnM8Ur6UhOTq/o
         CHu8V61IjhPYrfkIdJU8TVYPJAPs04BSoxBZcbgaRSRb/fnO33ZzbN7PdccvllJCvL
         fhyWRC6usAmEkj05zJjoJxyITHhC/3KhIeWpQMpjsk8INVMxa7w1Y+PPgV+qTkqs0L
         dg6a7iQb1gwW519pGaTcXXFi+JGIjnuoNiCEC2ShafBq94iYOQe4Nu1qtyEc68DTKh
         AQ+zwm8xPhXM5QNCgD2Hc5obYSWkobQ27m7s858px8+69/K+KrikpytTCSr00hm7a3
         7FHFrQqt+1tOA==
Date:   Wed, 3 Aug 2022 20:54:23 -0700
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     Joe Perches <joe@perches.com>
Cc:     Christoph Hellwig <hch@infradead.org>, studentxswpy@163.com,
        chao@kernel.org, linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org,
        Hacash Robot <hacashRobot@santino.com>
Subject: Re: [PATCH -next] f2fs: Replace kmalloc() with f2fs_kmalloc
Message-ID: <YutC7yUo/mTfty9q@google.com>
References: <20220801092202.3134668-1-studentxswpy@163.com>
 <YugaBtQcoR4XhXiQ@infradead.org>
 <b43b3babb8aea836add289245c640688bec87829.camel@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b43b3babb8aea836add289245c640688bec87829.camel@perches.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/01, Joe Perches wrote:
> On Mon, 2022-08-01 at 11:23 -0700, Christoph Hellwig wrote:
> > On Mon, Aug 01, 2022 at 05:22:02PM +0800, studentxswpy@163.com wrote:
> > > From: Xie Shaowen <studentxswpy@163.com>
> > > 
> > > replace kmalloc with f2fs_kmalloc to keep f2fs code consistency.
> > 
> > For that removing f2fs_kmalloc entirely would be way better.
> 
> Dunno, maybe doubtful as there's a specific "fault injector" test
> built around f2fs_<foo>alloc. (CONFIG_F2FS_FAULT_INJECTION)

Yes, it's very useful to run the test checking the ENOMEM case.

> 
> For a student lesson, it would significantly better to compile any
> patch, especially to avoid broken patches, before submitting them.
> 
