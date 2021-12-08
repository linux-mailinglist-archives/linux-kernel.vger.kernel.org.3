Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 881CA46D03D
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Dec 2021 10:40:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229734AbhLHJoL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Dec 2021 04:44:11 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:48641 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229687AbhLHJoK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Dec 2021 04:44:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1638956438;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2uSuAHdOx5fx6JiRcZg1wmWYaeDy0nKcYUXfbgfOZoc=;
        b=ZYUfahR7EoaUhT74R1yteC96AHKA21L/8myuGheDHs8FtYbbkmBPIkOvOJ0UiuUReULOi7
        zY94xj03NF29dU5/AKtf8cnrx8ghzwua66xdyz2IG/ZoU5JU3wLuFzRKV0EKr8rpejxio+
        mUe98KTxe8T+FWq+0n38mNRydmrVboY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-232-1GPQK18IPwG6EXaWN7DTtA-1; Wed, 08 Dec 2021 04:40:35 -0500
X-MC-Unique: 1GPQK18IPwG6EXaWN7DTtA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0441F81EE60;
        Wed,  8 Dec 2021 09:40:34 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.25])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 5920F45D72;
        Wed,  8 Dec 2021 09:40:13 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <20211206172340.fded3873aed7e853b54ab276@linux-foundation.org>
References: <20211206172340.fded3873aed7e853b54ab276@linux-foundation.org> <1638760762-27239-1-git-send-email-huangzhaoyang@gmail.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     dhowells@redhat.com, Huangzhaoyang <huangzhaoyang@gmail.com>,
        Zhaoyang Huang <zhaoyang.huang@unisoc.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-cachefs@redhat.com
Subject: Re: [PATCH] mm: mask DIRECT_RECLAIM in kswapd
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2502102.1638956412.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date:   Wed, 08 Dec 2021 09:40:12 +0000
Message-ID: <2502103.1638956412@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton <akpm@linux-foundation.org> wrote:

> >       __fscache_maybe_release_page
> > 	...
> >          if (!(gfp & __GFP_DIRECT_RECLAIM) || !(gfp & __GFP_FS)) {
> >                  fscache_stat(&fscache_n_store_vmscan_busy);
> >                  return false;
> >          }
> =

> Well, we have thus far been permitting kswapd's memory allocations to
> enter direct reclaim.  Forbidding that kernel-wide might be the right
> thing to do, or might not be.  But disabling it kernel-wide because of
> a peculiar hack in fscache is not good justification.

It's avoiding sleeping in ->releasepage() if fscache is doing something wi=
th
the page.  With the old I/O still used by nfs and cifs, PG_fscache means t=
hat
the page is known to fscache and it might be doing something with it in th=
e
background.  You have to ask fscache to release the page, which may requir=
e
I/O to take place, to get rid of the mark.

With the new I/O, as used by 9p, afs and ceph, where we're doing async DIO
between the page and the cache, PG_fscache just means that there's a DIO w=
rite
in progress from the page.  It will be cleared when the DIO completes.

I'm fine with changing the condition in the if-statement.  Note that in my
fscache-rewrite branch:

	https://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git/log=
/?h=3Dfscache-rewrite

I've been changing this to:

	if (!gfpflags_allow_blocking(gfp) || !(gfp & __GFP_FS))

and the old I/O is gone.  This is aimed at the next merge window.  If you =
want
me to change it there, let me know.

David

