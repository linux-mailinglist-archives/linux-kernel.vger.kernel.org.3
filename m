Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F384C4A985B
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Feb 2022 12:24:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358327AbiBDLYe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Feb 2022 06:24:34 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:33121 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1358313AbiBDLYd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Feb 2022 06:24:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1643973873;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=uc6vVra09nrjwDshG0ljVhrQXgW6/yiELZ5yz/Fp/sM=;
        b=Gx6i6dTV6WpiVuecwmvcX/amtXGDsiBXzEIwDfxr3xc7ff/pYHBWoA3VgC9UIa+O/dIZCX
        P+4fFBQY+S0WIec4+QucCERsMHqccLWegbkvleKRnf3t09B6oeA9AI8yOWIsIrTliKsCXM
        Whg2LfxIdBYMdDp5rUJeWRT0PLSHHWI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-127-5vjh7t1ZPtmdfUN6i_xaUg-1; Fri, 04 Feb 2022 06:24:27 -0500
X-MC-Unique: 5vjh7t1ZPtmdfUN6i_xaUg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2B5E3101F001;
        Fri,  4 Feb 2022 11:24:26 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.26])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 8CB0C106C0FA;
        Fri,  4 Feb 2022 11:24:24 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <Yfq7J9LU58FqNFVW@kernel.org>
References: <Yfq7J9LU58FqNFVW@kernel.org> <20220202024137.2516438-1-Liam.Howlett@oracle.com> <20220202024137.2516438-8-Liam.Howlett@oracle.com>
To:     Mike Rapoport <rppt@kernel.org>,
        Liam Howlett <liam.howlett@oracle.com>
Cc:     dhowells@redhat.com,
        "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v5 07/70] Maple Tree: Add new data structure
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1181362.1643973863.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date:   Fri, 04 Feb 2022 11:24:23 +0000
Message-ID: <1181363.1643973863@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Mike Rapoport <rppt@kernel.org> wrote:

> > +The Maple Tree maintains a small memory footprint and was designed to=
 use
> > +modern processor cache efficiently.  The most important user of the M=
aple Tree
> > +is the virtual memory area.
> =

> For me it sounds like VMA *is* the maple tree user. Maybe

I'm having a go at using it for the netfs lib support library to store a l=
ist
of dirty regions.  So far it looks like it should work for me.  It might b=
e
more useful if it had a loff_t index, but I can manage with pgoff_t.

Also isn't the intention to move xarray to use this inside eventually?

I would just drop the last sentence from the docs entirely.  If someone wa=
nts
to know who is using it, they can probably work it out with grep;-).  And,
anyway, once there's more than one user, which is the most important will =
be
subjective - and if you do put a list of users here, it's likely to get ou=
t of
date.

> > +
> > +The Maple Tree can store between 0 and ``ULONG_MAX``.  The Maple Tree=
 reserves
> =

>                           ^ values

Indices or keys?  Isn't the "value" the thing that is being storing at an
index or index range?

> > +Pre-allocating of nodes is also supported using the advanced API.  Th=
is is
> > +useful for users who must guarantee a successful store operation with=
in a given
> > +code segment when allocating cannot be done.  Allocations of nodes ar=
e
> > +relatively small at 256 bytes.
> =

> I doubt the size here will get timely updates when the node size will
> change in the code, maybe use "around" or "roughly" to be future proof? =
:)

I would suggest dropping the number and saying "Nodes are relatively small
allocations".  If there's a symbol that specifies this, you could plonk th=
at
in.

> There are a lots of comments describing the maple tree internals here an=
d
> below. Did yaou consider adding a section "Implementation details" or
> something like that to the maple_tree.rst and linking these comments the=
re
> with DOC: and some glue text?

Could even add a maple_tree_gory_details.rst.  It doesn't necessarily have=
 to
go in the same document as the API description.

David

