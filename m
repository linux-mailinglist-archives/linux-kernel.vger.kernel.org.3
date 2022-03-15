Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61E954D9DEB
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Mar 2022 15:42:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348996AbiCOOnW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Mar 2022 10:43:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347777AbiCOOnT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Mar 2022 10:43:19 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BBDA55BCC;
        Tue, 15 Mar 2022 07:42:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=RmMj67xB8euM1RYehVlWq8W09wCNdWF88eGn88NV1Z0=; b=aMJ+EBriPSUzakRINtFFdLzOZq
        VlQGy1fNoLOdtGW5uIJUOmCt87EdxT0TtHr0BwFJQ6OmikwRgX3E9EKPKaXIydOegw/m9CNPm6xBE
        Aa7PfJw8ky2zsxRLIOMrSaDDmpLiopgAHLIGFgWedlaY2jIcSh02O+SV1NfDFqqb5HF7Im+djX4lP
        Ue7xj1yeH2Wixijmz/ddbSQ4YSB69hNT3JvQiYbgbprAtz2XfdG9XsZIKT90Z6Bcs70UlUb9af8BV
        ARprZZiSGE7lSGs4gBzk8FNB6zxkkU5OsQHONNNEOHO3RRTE/IIbCzUJlKm6qHuZiXt3y0kIQwena
        GoiB71Yg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nU8N7-0057SZ-DK; Tue, 15 Mar 2022 14:42:01 +0000
Date:   Tue, 15 Mar 2022 14:42:01 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: build failure after merge of the folio tree
Message-ID: <YjCluUjWNZ9wg4fW@casper.infradead.org>
References: <20220315212610.0f996842@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220315212610.0f996842@canb.auug.org.au>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 15, 2022 at 09:26:10PM +1100, Stephen Rothwell wrote:
> Hi all,
> 
> After merging the folio tree, today's linux-next build (powerpc
> ppc64_defconfig) failed like this:
> 
> mm/readahead.c: In function 'read_cache_pages_invalidate_page':
> mm/readahead.c:54:17: error: implicit declaration of function 'do_invalidatepage'; did you mean 'd_invalidate'? [-Werror=implicit-function-declaration]
>    54 |                 do_invalidatepage(page, 0, PAGE_SIZE);
>       |                 ^~~~~~~~~~~~~~~~~
>       |                 d_invalidate
> 
> Caused by commit
> 
>   f1fdabbaae8e ("fs: Turn do_invalidatepage() into folio_invalidate()")
> 
> I have used the folio tree from next-20220310 for today.

Sorry about that.  Originally, I'd removed that entire function in an
earlier commit, but had to shuffle that commit to after the NFS tree
merges.

There's a new for-next for your merge resolution tomorrow ... not much
I can do about the conflicts, but all your resolutions seemed
reasonable.  Fixed a couple of other build bugs noted by the build bots
(ceph & hostfs)


