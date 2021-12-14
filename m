Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2356347399F
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Dec 2021 01:35:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244502AbhLNAf3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 19:35:29 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:42539 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S244480AbhLNAf2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 19:35:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1639442128;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=44hPhyhxcmlQftiSK+6CWLQyreVx/0BjYdefYhyvGwg=;
        b=RSClF8C+BgcLS9BCdi+7KoLvrCd+o+VTl7XrTWU39xXRgGO7Rwg0bsAFtte+6J1F+moiPQ
        I7DSg5e1tkPuw9gFCsaVoZJFDDPmldM6YlnyW0rdtwwdcnZlyrVCpJHpK0JlMjAJ/FnocO
        6NF0KgAPBdLIHTCb1ZSWHJrfzxJfkiM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-125-RqyHzlc_OsGcrKYRSNCR7Q-1; Mon, 13 Dec 2021 19:35:24 -0500
X-MC-Unique: RqyHzlc_OsGcrKYRSNCR7Q-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3C0F0801AC5;
        Tue, 14 Dec 2021 00:35:23 +0000 (UTC)
Received: from localhost (ovpn-12-46.pek2.redhat.com [10.72.12.46])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 94CF15C23A;
        Tue, 14 Dec 2021 00:35:22 +0000 (UTC)
Date:   Tue, 14 Dec 2021 08:35:19 +0800
From:   Baoquan He <bhe@redhat.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org, hch@lst.de,
        cl@linux.com, John.p.donnelly@oracle.com, kexec@lists.infradead.org
Subject: Re: [PATCH v3 0/5] Avoid requesting page from DMA zone when no
 managed pages
Message-ID: <20211214003519.GA2216@MiWiFi-R3L-srv>
References: <20211213122712.23805-1-bhe@redhat.com>
 <20211213130534.af47c7956c219797e6b56687@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211213130534.af47c7956c219797e6b56687@linux-foundation.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/13/21 at 01:05pm, Andrew Morton wrote:
> On Mon, 13 Dec 2021 20:27:07 +0800 Baoquan He <bhe@redhat.com> wrote:
> 
> > Background information can be checked in cover letter of v2 RESEND POST
> > as below:
> > https://lore.kernel.org/all/20211207030750.30824-1-bhe@redhat.com/T/#u
> 
> Please include all relevant info right here, in the [0/n].  For a
> number of reasons, one of which is that the text is more likely to be
> up to date as the patchset evolves.
> 
> It's unusual that this patchset has two non-urgent patches and the
> final three patches are cc:stable.  It makes one worry that patches 3-5
> might have dependencies on 1-2.  Also, I'd expect to merge the three
> -stable patches during 5.16-rcX which means I have to reorder things,
> redo changelogs, update links and blah blah.
> 
> So can I ask that you redo all of this as two patch series?  A 3-patch
> series which is targeted at -stable, followed by a separate two-patch
> series which is targeted at 5.17-rc1.  Each series with its own fully
> prepared [0/n] cover.

Sure, will do. Sorry for the mess.

Before the 3-patch series posting, I may need to continue discussing and
making clear if the current patch 5/5 is a good fix, or whether we need
change to take other solution. So I will take the first two patches out
and post them.

