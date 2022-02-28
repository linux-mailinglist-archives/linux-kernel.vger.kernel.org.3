Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88AAA4C77EF
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Feb 2022 19:35:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240160AbiB1SgP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Feb 2022 13:36:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240132AbiB1Sfp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Feb 2022 13:35:45 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E59D89314;
        Mon, 28 Feb 2022 10:21:31 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D075161382;
        Mon, 28 Feb 2022 18:21:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1316FC340E7;
        Mon, 28 Feb 2022 18:21:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1646072490;
        bh=HURwpYk49WHR9wrt6CmLlrGnYMNZUAgxNFabTYrqi0g=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=m5UklltcS4LF8iskWclk7Vtkz839DWEFjE6CNbTcjY7OLXAmzzskXnjYw4KMESW+Y
         4GlaOg2XEVcrrAprOkFLleCFkWhlbhonM+70wIgwkUuLNAOwlq39GafSvTx2GI/bR3
         u7tw3Z93Y3VhlM5UTFdHQrUtHJOi0yuI4dw9avMg=
Date:   Mon, 28 Feb 2022 10:21:29 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: build failure after merge of the akpm-current tree
Message-Id: <20220228102129.9d650474543760f6a1f672fb@linux-foundation.org>
In-Reply-To: <20220301013308.5a91c6a1@canb.auug.org.au>
References: <20220301013308.5a91c6a1@canb.auug.org.au>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 1 Mar 2022 01:33:08 +1100 Stephen Rothwell <sfr@canb.auug.org.au> wrote:

> Hi all,
> 
> After merging the akpm-current tree, today's linux-next build (powerpc
> ppc64_defconfig) failed like this:
> 
> mm/rmap.c: In function 'try_to_migrate_one':
> mm/rmap.c:1870:64: error: 'page' undeclared (first use in this function)
>  1870 |                                                 compound_order(page));
>       |                                                                ^~~~
> mm/rmap.c:1870:64: note: each undeclared identifier is reported only once for each function it appears in
> 
> Caused by commit
> 
>   e05239e90b65 ("mm/migration: add trace events for base page and HugeTLB migrations")
> 
> inertacting with commit
> 
>   efe8a99f35f6 ("mm/rmap: Convert rmap_walk() to take a folio")
> 
> from the folio tree.
> 
> I have reverted commit e05239e90b65 for today.

Thanks, I've moved yet more things into the post-linux-next queue and
fixed things up.

