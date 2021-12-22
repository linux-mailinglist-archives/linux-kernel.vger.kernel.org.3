Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C535047CB4E
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Dec 2021 03:14:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238610AbhLVCO4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Dec 2021 21:14:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237775AbhLVCOz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Dec 2021 21:14:55 -0500
Received: from out1.migadu.com (out1.migadu.com [IPv6:2001:41d0:2:863f::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40E7BC061574
        for <linux-kernel@vger.kernel.org>; Tue, 21 Dec 2021 18:14:55 -0800 (PST)
Date:   Wed, 22 Dec 2021 11:14:45 +0900
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1640139293;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=/9QLrdP3oG8h0EWJQgoqlJH+JbboJwLSeHDc6dvgFQ0=;
        b=v5rJshvzgacUGbtNde/Bqx/AGvbfPQn6RfvKRHCaIXyN2Afuz4lp+wpT4ecRm91gzpPNEj
        hWriMASnMRy2cPOgeHlsxfQoDfEzJm64LUtgDwTQAW3HVEQ3385MQJ+SBIe2Vo+VIZhNLC
        WmsJuj9sHE6ymQMTqnCy4czYOkEdIa4=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Naoya Horiguchi <naoya.horiguchi@linux.dev>
To:     Liu Shixin <liushixin2@huawei.com>
Cc:     Naoya Horiguchi <naoya.horiguchi@nec.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Oscar Salvador <osalvador@suse.de>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] mm/hwpoison: clear MF_COUNT_INCREASED before
 retrying get_any_page()
Message-ID: <20211222021445.GA1534186@u2004>
References: <20211221074908.3910286-1-liushixin2@huawei.com>
 <20211222003751.GA1529256@u2004>
 <d0e572ee-0e32-371d-3f5b-7afdeb4013e4@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <d0e572ee-0e32-371d-3f5b-7afdeb4013e4@huawei.com>
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: linux.dev
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 22, 2021 at 09:49:18AM +0800, Liu Shixin wrote:
> 
> 
> On 2021/12/22 8:37, Naoya Horiguchi wrote:
> > On Tue, Dec 21, 2021 at 03:49:08PM +0800, Liu Shixin wrote:
> >> Hulk Robot reported a panic in put_page_testzero() when testing madvise()
> >> with MADV_SOFT_OFFLINE. The BUG() is triggered when retrying get_any_page().
> >> This is because we keep MF_COUNT_INCREASED flag in second try but the refcnt
> >> is not increased.
> > Hi Shixin, 
> >
> > Thanks you for the report.
> >
> > I'm not still sure about the logic behind the bug.
> > madvise(MADV_SOFT_OFFLINE) should not work on free pages because
> > madvise_inject_error() pins the target page with get_user_pages_fast()
> > (MF_COUNT_INCREASED means refcount is incremented by the caller).
> > The retry logic can be called when soft_offline_free_page() fails, so
> > the logic assumes that the target page is a free page.  So why does
> > clearing MF_COUNT_INCREASED affect and solve the issue?
> >
> > It seems to me that if soft_offline_page() is called on a free page
> > with MF_COUNT_INCREASED set, then it's problematic itself.
> >
> > Thanks,
> > Naoya Horiguchi
> 
> The page is not free when soft_offline_page() is called. In get_any_page(),
> if MF_COUNT_INCREASED is set and !HWPoisonHandlable(page), put_page()
> will be called firstly and then goto try_again. The page is freed in this period.

Okay, the logic is clear to me now.

> >>
> >> Fixes: b94e02822deb ("mm,hwpoison: try to narrow window race for free pages")
> >> Reported-by: Hulk Robot <hulkci@huawei.com>
> >> Signed-off-by: Liu Shixin <liushixin2@huawei.com>

Thank you very much.

Acked-by: Naoya Horiguchi <naoya.horiguchi@nec.com>

> >> ---
> >>  mm/memory-failure.c | 1 +
> >>  1 file changed, 1 insertion(+)
> >>
> >> diff --git a/mm/memory-failure.c b/mm/memory-failure.c
> >> index 68d9a35f8908..160526f83bcb 100644
> >> --- a/mm/memory-failure.c
> >> +++ b/mm/memory-failure.c
> >> @@ -2288,6 +2288,7 @@ int soft_offline_page(unsigned long pfn, int flags)
> >>  	} else if (ret == 0) {
> >>  		if (soft_offline_free_page(page) && try_again) {
> >>  			try_again = false;
> >> +			flags &= ~MF_COUNT_INCREASED;
> >>  			goto retry;
> >>  		}
> >>  	}
> >> -- 
> >> 2.25.1
> >>
> > .
> >
> 
