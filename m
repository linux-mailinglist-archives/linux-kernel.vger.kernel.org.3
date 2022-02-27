Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4F754C5900
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Feb 2022 04:02:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229708AbiB0DB1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Feb 2022 22:01:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229521AbiB0DBZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Feb 2022 22:01:25 -0500
Received: from mail-oo1-xc2f.google.com (mail-oo1-xc2f.google.com [IPv6:2607:f8b0:4864:20::c2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D15281FA1CE
        for <linux-kernel@vger.kernel.org>; Sat, 26 Feb 2022 19:00:49 -0800 (PST)
Received: by mail-oo1-xc2f.google.com with SMTP id y15-20020a4a650f000000b0031c19e9fe9dso13093636ooc.12
        for <linux-kernel@vger.kernel.org>; Sat, 26 Feb 2022 19:00:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :mime-version;
        bh=2z1pRmn1T2Qq2g9KlTJ37xlcneIUSbISMr8g/idJeeo=;
        b=VClutb9yYCy5/JCAn1Xcv1/Q7zQD1CNaINyAtJw7xexLiht6HubWw0S0fyxvREGuAx
         AkQSzwxz6ZDsk7nE/vE+zic6fKtitlu65BvP5+SBQCso/Ev5PPCSxCBj6J+6Ga96BAVe
         sf/VU7deVwQwqSHao9RFYPX9zZNNhHNautK1DpKVj3dzqYALVXMc/Ri4hD6nQFBmOg0z
         FfVzf215oUQMDN+K4mwz1erGRgMOP9nffZwTuYU7uuE27oARoxM+05LlLnkUsO6Beicx
         NnCMfhKu0h1YH5yvdIYT7DNoAD1XxmcQYZvxuCEPOkNTnFv4D5uL4Nty6fQiMuJ70lft
         zcKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:mime-version;
        bh=2z1pRmn1T2Qq2g9KlTJ37xlcneIUSbISMr8g/idJeeo=;
        b=h7jFk79dsigFLLyOlzIVbt0tcItdvxjK0OfX5EoModSOm51QXPD1UpqTJVIhcBgWfY
         hEOJkkQp2FNCmPt/jASkId5J+KHku3ckhwTeaRbce60P8R4UaiRVjTUQXALFDBlhPBYe
         i6wCw7QEeYsK8YDrpM1rt1cdnJlU6T/14p+ykqusexy2Z1hFzIpOk9ii9uvMWPe4S9QO
         790s3GsToMK5KEBYne5FXKLq95zFMS0gVcLmmfPUlwS2DvC0ecwERKW/oErq/f3CZVWR
         glUwdyZe8JwyWCk8qAa2WSLOTilmy4HcQmfYMAoEo+dS26PixHdqz1qhygj1PynBtKqX
         T2Wg==
X-Gm-Message-State: AOAM531mZaOMDMh40oXUI8ciPlW1L082ZqPoUeEmzes6mCvRAI6+cNTJ
        VPneJ4LJVfmikaD1QNX199koIg==
X-Google-Smtp-Source: ABdhPJxwMtTS/A+ZsASHAfYUz5ChWEMPKqwDCApb92U8vWxlucGbX1KrxSno8Vgh5CpRhelf9PBr9Q==
X-Received: by 2002:a4a:ad41:0:b0:319:462a:9c0c with SMTP id s1-20020a4aad41000000b00319462a9c0cmr5971065oon.76.1645930848911;
        Sat, 26 Feb 2022 19:00:48 -0800 (PST)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id i5-20020a056870578500b000d6e1a022e4sm2726725oap.32.2022.02.26.19.00.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Feb 2022 19:00:48 -0800 (PST)
Date:   Sat, 26 Feb 2022 19:00:37 -0800 (PST)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@ripple.anvils
To:     Mike Kravetz <mike.kravetz@oracle.com>,
        Matthew Wilcox <willy@infradead.org>
cc:     Hugh Dickins <hughd@google.com>, cgel.zte@gmail.com,
        kirill@shutemov.name, songliubraving@fb.com,
        akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, yang.yang29@zte.com.cn,
        wang.yong12@zte.com.cn, Zeal Robot <zealci@zte.com.cn>
Subject: Re: [PATCH linux-next] Fix shmem huge page failed to set F_SEAL_WRITE
 attribute problem
In-Reply-To: <Yg5RDDRLVsuT/Rfw@casper.infradead.org>
Message-ID: <8986d97-3933-8fa7-abba-aabd67924bc2@google.com>
References: <20220215073743.1769979-1-cgel.zte@gmail.com> <1f486393-3829-4618-39a1-931afc580835@oracle.com> <d6e74520-88bc-9f57-e189-8e4f389726e@google.com> <Yg5RDDRLVsuT/Rfw@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-16.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,FROM_FMBLA_NEWDOM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 17 Feb 2022, Matthew Wilcox wrote:
> On Wed, Feb 16, 2022 at 05:25:17PM -0800, Hugh Dickins wrote:
> > On Wed, 16 Feb 2022, Mike Kravetz wrote:
> > > On 2/14/22 23:37, cgel.zte@gmail.com wrote:
...
> > > > @@ -39,8 +40,12 @@ static void memfd_tag_pins(struct xa_state *xas)
> > > >  	xas_for_each(xas, page, ULONG_MAX) {
> > > >  		if (xa_is_value(page))
> > > >  			continue;
> > > > +
> > > >  		page = find_subpage(page, xas->xa_index);
> > > > -		if (page_count(page) - page_mapcount(page) > 1)
> > > > +		count = page_count(page);
> > > > +		if (PageTransCompound(page))
> > > 
> > > PageTransCompound() is true for hugetlb pages as well as THP.  And, hugetlb
> > > pages will not have a ref per subpage as THP does.  So, I believe this will
> > > break hugetlb seal usage.
> > 
> > Yes, I think so too; and that is not the only issue with the patch
> > (I don't think page_mapcount is enough, I had to use total_mapcount).

Mike, we had the same instinctive reaction to seeing a PageTransCompound
check in code also exposed to PageHuge pages; but in fact that seems to
have worked correctly - those hugetlbfs pages are hard to predict!
But it was not working on pte maps of THPs.

> > 
> > It's a good find, and thank you WangYong for the report.
> > I found the same issue when testing my MFD_HUGEPAGE patch last year,
> > and devised a patch to fix it (and keep MFD_HUGETLB working) then; but
> > never sent that in because there wasn't time to re-present MFD_HUGEPAGE.
> > 
> > I'm currently retesting my patch: just found something failing which
> > I thought should pass; but maybe I'm confused, or maybe the xarray is
> > working differently now.  I'm rushing to reply now because I don't want
> > others to waste their own time on it.
> 
> I did change how the XArray works for THP recently.
> 
> Kirill's original patch stored:
> 
> 512: p
> 513: p+1
> 514: p+2
> ...
> 1023: p+511
> 
> A couple of years ago, I changed it to store:
> 
> 512: p
> 513: p
> 514: p
> ...
> 1023: p
> 
> And in January, Linus merged the commit which changes it to:
> 
> 512-575: p
> 576-639: (sibling of 512)
> 640-703: (sibling of 512)
> ...
> 960-1023: (sibling of 512)
> 
> That is, I removed a level of the tree and store sibling entries
> rather than duplicate entries.  That wasn't for fun; I needed to do
> that in order to make msync() work with large folios.  Commit
> 6b24ca4a1a8d has more detail and hopefully can inspire whatever
> changes you need to make to your patch.

Matthew, thanks for the very detailed info, you shouldn't have taken
so much trouble over it: I knew you had done something of that kind,
and yes, that's where my suspicion lay at the time of writing.  But
you'll be relieved to know that the patch I wrote before your changes
turned out to be unaffected, and just as valid after your changes.

"just found something failing which I thought should pass" was me
forgetting, again and again, just how limited are the allowed
possibilities for F_SEAL_WRITE when mmaps are outstanding.

One thinks that a PROT_READ, MAP_SHARED mapping would be allowed;
but of course all the memfds are automatically O_RDWR, so mprotect
(no sealing hook) allows it to be changed to PROT_READ|PROT_WRITE,
so F_SEAL_WRITE is forbidden on any MAP_SHARED mapping: only allowed
on MAP_PRIVATEs.

I'll now re-read the commit message I wrote before, update if necessary,
and then send to Andrew, asking him to replace the one in this thread.

Hugh
