Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B71B24BA1AD
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Feb 2022 14:45:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241299AbiBQNpC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Feb 2022 08:45:02 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:48514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241316AbiBQNoq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 08:44:46 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F9E92B3194
        for <linux-kernel@vger.kernel.org>; Thu, 17 Feb 2022 05:43:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=xMLGTKj4HTOTXdlhSUyVvWQINdLGyf8MyKTFBShV+f4=; b=YgRZ2OECOBTphRSxVwowj4LEGo
        MfNJFpDMUbcRjXPoQ6THgCYUAwdvAh9DZUiABlDIfEHnReQTVnR+r2Ob8djBg17cpOK4t2ZWlRSYu
        BK3TnQeXuf5YnCshO2gbo7prAxxOCXXmpOw3ieSqEy6RBV+p8vUrRsuVwsVSww93FmzQ8ghuu/jIf
        o5Sy3KYuKPSj/hsPYoIrAXExk2wUWN46Q4Kn60c3rERbMgYXOojrHB5zO8j3zvjAcBR7alCgLwq5B
        SDEjyoMJnme/ujnlAWjh0sYfUSau86++w1jG+2m0umDX88QXROlGHlGyxd+qj/08qFK/7ZT0MoXfX
        8n6lYpGQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nKh4O-00FeQI-Td; Thu, 17 Feb 2022 13:43:40 +0000
Date:   Thu, 17 Feb 2022 13:43:40 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Hugh Dickins <hughd@google.com>
Cc:     Mike Kravetz <mike.kravetz@oracle.com>, cgel.zte@gmail.com,
        kirill@shutemov.name, songliubraving@fb.com,
        akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, yang.yang29@zte.com.cn,
        wang.yong12@zte.com.cn, Zeal Robot <zealci@zte.com.cn>
Subject: Re: [PATCH linux-next] Fix shmem huge page failed to set
 F_SEAL_WRITE attribute problem
Message-ID: <Yg5RDDRLVsuT/Rfw@casper.infradead.org>
References: <20220215073743.1769979-1-cgel.zte@gmail.com>
 <1f486393-3829-4618-39a1-931afc580835@oracle.com>
 <d6e74520-88bc-9f57-e189-8e4f389726e@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d6e74520-88bc-9f57-e189-8e4f389726e@google.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 16, 2022 at 05:25:17PM -0800, Hugh Dickins wrote:
> On Wed, 16 Feb 2022, Mike Kravetz wrote:
> > On 2/14/22 23:37, cgel.zte@gmail.com wrote:
> > > From: wangyong <wang.yong12@zte.com.cn>
> > > 
> > > After enabling tmpfs filesystem to support transparent hugepage with the
> > > following command:
> > >  echo always > /sys/kernel/mm/transparent_hugepage/shmem_enabled
> > > The docker program adds F_SEAL_WRITE through the following command will
> > > prompt EBUSY.
> > >  fcntl(5, F_ADD_SEALS, F_SEAL_WRITE)=-1.
> > > 
> > > It is found that in memfd_wait_for_pins function, the page_count of
> > > hugepage is 512 and page_mapcount is 0, which does not meet the
> > > conditions:
> > >  page_count(page) - page_mapcount(page) != 1.
> > > But the page is not busy at this time, therefore, the page_order of
> > > hugepage should be taken into account in the calculation.
> > > 
> > > Reported-by: Zeal Robot <zealci@zte.com.cn>
> > > Signed-off-by: wangyong <wang.yong12@zte.com.cn>
> > > ---
> > >  mm/memfd.c | 16 +++++++++++++---
> > >  1 file changed, 13 insertions(+), 3 deletions(-)
> > > 
> > > diff --git a/mm/memfd.c b/mm/memfd.c
> > > index 9f80f162791a..26d1d390a22a 100644
> > > --- a/mm/memfd.c
> > > +++ b/mm/memfd.c
> > > @@ -31,6 +31,7 @@
> > >  static void memfd_tag_pins(struct xa_state *xas)
> > >  {
> > >  	struct page *page;
> > > +	int count = 0;
> > >  	unsigned int tagged = 0;
> > >  
> > >  	lru_add_drain();
> > > @@ -39,8 +40,12 @@ static void memfd_tag_pins(struct xa_state *xas)
> > >  	xas_for_each(xas, page, ULONG_MAX) {
> > >  		if (xa_is_value(page))
> > >  			continue;
> > > +
> > >  		page = find_subpage(page, xas->xa_index);
> > > -		if (page_count(page) - page_mapcount(page) > 1)
> > > +		count = page_count(page);
> > > +		if (PageTransCompound(page))
> > 
> > PageTransCompound() is true for hugetlb pages as well as THP.  And, hugetlb
> > pages will not have a ref per subpage as THP does.  So, I believe this will
> > break hugetlb seal usage.
> 
> Yes, I think so too; and that is not the only issue with the patch
> (I don't think page_mapcount is enough, I had to use total_mapcount).
> 
> It's a good find, and thank you WangYong for the report.
> I found the same issue when testing my MFD_HUGEPAGE patch last year,
> and devised a patch to fix it (and keep MFD_HUGETLB working) then; but
> never sent that in because there wasn't time to re-present MFD_HUGEPAGE.
> 
> I'm currently retesting my patch: just found something failing which
> I thought should pass; but maybe I'm confused, or maybe the xarray is
> working differently now.  I'm rushing to reply now because I don't want
> others to waste their own time on it.

I did change how the XArray works for THP recently.

Kirill's original patch stored:

512: p
513: p+1
514: p+2
...
1023: p+511

A couple of years ago, I changed it to store:

512: p
513: p
514: p
...
1023: p

And in January, Linus merged the commit which changes it to:

512-575: p
576-639: (sibling of 512)
640-703: (sibling of 512)
...
960-1023: (sibling of 512)

That is, I removed a level of the tree and store sibling entries
rather than duplicate entries.  That wasn't for fun; I needed to do
that in order to make msync() work with large folios.  Commit
6b24ca4a1a8d has more detail and hopefully can inspire whatever
changes you need to make to your patch.
