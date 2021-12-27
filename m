Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 006C547FB0E
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Dec 2021 09:33:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235696AbhL0IdM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Dec 2021 03:33:12 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:20373 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231500AbhL0IdL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Dec 2021 03:33:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1640593990;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=2qRZwgsHfWSWyU7Hnx0+MbH1Bxd9KQydQv+v81acaAc=;
        b=BrP4vbCm/uZ9FmNcPnr6+dgZpv4MwkhyyKO8Xtfa6euhyZ7x40iszLOK4uJnVEAj9On3Wl
        rnpyGL9g/dtMTzx0ialgpQgUglAYWDLL0rp4svsOB00kAZeDW17hNYiVbd1F3yTz9qC+6k
        iZRbAqWI4G0OHXB98JpnQeVlmjrwydU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-63-Dx_5mBxTNMWNFbTnM5UF1g-1; Mon, 27 Dec 2021 03:33:05 -0500
X-MC-Unique: Dx_5mBxTNMWNFbTnM5UF1g-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 62F698042E0;
        Mon, 27 Dec 2021 08:33:01 +0000 (UTC)
Received: from localhost (ovpn-12-246.pek2.redhat.com [10.72.12.246])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id F11E76ABBF;
        Mon, 27 Dec 2021 08:32:56 +0000 (UTC)
Date:   Mon, 27 Dec 2021 16:32:53 +0800
From:   Baoquan He <bhe@redhat.com>
To:     Hyeonggon Yoo <42.hyeyoo@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        akpm@linux-foundation.org, hch@lst.de, cl@linux.com,
        John.p.donnelly@oracle.com, kexec@lists.infradead.org,
        penberg@kernel.org, rientjes@google.com, iamjoonsoo.kim@lge.com,
        vbabka@suse.cz, David.Laight@aculab.com, david@redhat.com,
        x86@kernel.org, bp@alien8.de
Subject: Re: [PATCH v4 3/3] mm/page_alloc.c: do not warn allocation failure
 on zone DMA if no managed pages
Message-ID: <20211227083253.GA24172@MiWiFi-R3L-srv>
References: <20211223094435.248523-1-bhe@redhat.com>
 <20211223094435.248523-4-bhe@redhat.com>
 <Ycax90Xex3THEZTi@ip-172-31-30-232.ap-northeast-1.compute.internal>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Ycax90Xex3THEZTi@ip-172-31-30-232.ap-northeast-1.compute.internal>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/25/21 at 05:53am, Hyeonggon Yoo wrote:
> On Thu, Dec 23, 2021 at 05:44:35PM +0800, Baoquan He wrote:
...... 
> > diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> > index 7c7a0b5de2ff..843bc8e5550a 100644
> > --- a/mm/page_alloc.c
> > +++ b/mm/page_alloc.c
> > @@ -4204,7 +4204,8 @@ void warn_alloc(gfp_t gfp_mask, nodemask_t *nodemask, const char *fmt, ...)
> >  	va_list args;
> >  	static DEFINE_RATELIMIT_STATE(nopage_rs, 10*HZ, 1);
> >  
> > -	if ((gfp_mask & __GFP_NOWARN) || !__ratelimit(&nopage_rs))
> > +	if ((gfp_mask & __GFP_NOWARN) || !__ratelimit(&nopage_rs) ||
> > +		(gfp_mask & __GFP_DMA) && !has_managed_dma())
> >  		return;
> >
> 
> Warning when there's always no page in DMA zone is unnecessary 
> and it confuses user.
> 
> The patch looks good.
> Reviewed-by: Hyeonggon Yoo <42.hyeyoo@gmail.com>
> 
> And there is some driers that allocate memory with GFP_DMA
> even if that flag is unnecessary. We need to do cleanup later.

Thanks for reviewing and giving out some awesome suggestions.

> 
> Baoquan Are you planning to do it soon?
> I want to help that.

Yes, I had the plan and have done a little part. I talked to Christoph
about my thought. I planned to collect all kmalloc(GFP_DMA) callsite and
post a RFC mail, CC mailing list and maintainers related. Anyone
interested or know one or several callsites well can help.

Now, Christoph has handled all under drviers/scsi, and post patches to
fix them. I have gone throug those places and found out below callsites
where we can remove GFP_DMA directly when calling kmalloc() since not
necessary. And even found one place kmalloc(GFP_DMA32).

(HEAD -> master) vxge: don't use GFP_DMA
mtd: rawnand: marvell: don't use GFP_DMA
HID: intel-ish-hid: remove wrong GFP_DMA32 flag
ps3disk: don't use GFP_DMA
atm: iphase: don't use GFP_DMA

Next, I will send a RFC mail to contain those suspect callsites. We can
track them and can help if needed. Suggest to change them with:
1) using dma_alloc_xx , or dma_map_xx after kmalloc()
2) using alloc_pages(GFP_DMA) instead

When we fix, we all post patch with subject key words as
'xxxx: don't use GFP_DMA'. Christoph has posted patch with the similar
subject, we can search subject to get all related patches for later back
porting.

I will add you to CC when sending. Could be tomorrow. Any suggestion or thought?

Thanks
Baoquan

