Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C86A8472E72
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Dec 2021 15:04:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238209AbhLMOEA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 09:04:00 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:27188 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232193AbhLMOEA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 09:04:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1639404239;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=1AptlvWm8ovvag4ndsPZnTJsnei0DVx3SWRb8MH/REI=;
        b=czgPCxLwgejaGuEn9FHevlMSUrcO9i9CqCha6GYVyJJdzTOeDvRh5hS7assSym1KDjmh4N
        8zryFoJAvjZDkavcHeaYMZpf9H89iWTdyj8iinYji5q96Ebr8Abrz9g8co33zcD65i94Nd
        J3WHa1yd9rX7cfH0okile1NvG55TYok=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-164-kLNGR4PCP-62LTetQkCMpw-1; Mon, 13 Dec 2021 09:03:56 -0500
X-MC-Unique: kLNGR4PCP-62LTetQkCMpw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 677BC343C9;
        Mon, 13 Dec 2021 14:03:53 +0000 (UTC)
Received: from localhost (ovpn-12-202.pek2.redhat.com [10.72.12.202])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id C4344ADCB;
        Mon, 13 Dec 2021 14:03:51 +0000 (UTC)
Date:   Mon, 13 Dec 2021 22:03:48 +0800
From:   Baoquan He <bhe@redhat.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     linux-kernel@vger.kernel.org, tglx@linutronix.de, mingo@redhat.com,
        dave.hansen@linux.intel.com, luto@kernel.org, peterz@infradead.org,
        linux-mm@kvack.org, akpm@linux-foundation.org, hch@lst.de,
        robin.murphy@arm.com, cl@linux.com, penberg@kernel.org,
        rientjes@google.com, iamjoonsoo.kim@lge.com, vbabka@suse.cz,
        m.szyprowski@samsung.com, John.p.donnelly@oracle.com,
        kexec@lists.infradead.org, rppt@linux.ibm.com
Subject: Re: [PATCH RESEND v2 0/5] Avoid requesting page from DMA zone when
 no managed pages
Message-ID: <20211213140348.GA26562@MiWiFi-R3L-srv>
References: <20211207030750.30824-1-bhe@redhat.com>
 <20211207031631.GA5604@MiWiFi-R3L-srv>
 <YbdJ00wRFvi0aqze@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YbdJ00wRFvi0aqze@zn.tnic>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/13/21 at 02:25pm, Borislav Petkov wrote:
> On Tue, Dec 07, 2021 at 11:16:31AM +0800, Baoquan He wrote:
> > > This low 1M lock down is needed because AMD SME encrypts memory making
> > > the old backup region mechanims impossible when switching into kdump
> > > kernel. And Intel engineer mentioned their TDX (Trusted domain extensions)
> > > which is under development in kernel also needs lock down the low 1M.
> > > So we can't simply revert above commits to fix the page allocation
> > > failure from DMA zone as someone suggested.
> 
> Did you read
> 
>   f1d4d47c5851 ("x86/setup: Always reserve the first 1M of RAM")
> 
> carefully for a more generically important reason as to why the first 1M
> should not be used?

Apparently I didn't. I slacked off and just grabbed things stored in my
brain. This is the right justification and missed. Thanks for pointing
it out.

