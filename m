Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB48647C217
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Dec 2021 16:01:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235681AbhLUPBP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Dec 2021 10:01:15 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:58005 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232308AbhLUPBO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Dec 2021 10:01:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1640098874;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/fRof4FvIHTm/GA4a84kkFSjYLrFuujAcKIJUtcRLBI=;
        b=CFe/um/q14P1AwMw6vRdWyoUuhkqnlxhHlphCEA4BcrXTLjE4P2GNzrlTiwuLJuTTTt17g
        h3lL6RLkGokodEZ79pHPGOILciWgkNSSIm35FfhaeKMB4X1AU9nuCoC/9w9kLgB+Ng2WM8
        4g75LmM+nrwy1jfEuG+7ynq0mYKg7uw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-643-zofRsrvPOr6HCEYU3SpXLg-1; Tue, 21 Dec 2021 10:01:09 -0500
X-MC-Unique: zofRsrvPOr6HCEYU3SpXLg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 00AC687110B;
        Tue, 21 Dec 2021 15:00:48 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.165])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 14EBC5BD34;
        Tue, 21 Dec 2021 15:00:20 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <CAGWkznHcuiwPPMZE95nYG=EFkM8NmLUQZooS5+a+GigP50qksg@mail.gmail.com>
References: <CAGWkznHcuiwPPMZE95nYG=EFkM8NmLUQZooS5+a+GigP50qksg@mail.gmail.com> <1638952658-20285-1-git-send-email-huangzhaoyang@gmail.com> <2868725.1638995206@warthog.procyon.org.uk>
To:     Zhaoyang Huang <huangzhaoyang@gmail.com>
Cc:     dhowells@redhat.com, Marc Dionne <marc.dionne@auristor.com>,
        Zhaoyang Huang <zhaoyang.huang@unisoc.com>,
        linux-cachefs@redhat.com, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] fs: judging context via current_is_kswapd instead of gfp_flag
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <73895.1640098820.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date:   Tue, 21 Dec 2021 15:00:20 +0000
Message-ID: <73896.1640098820@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Zhaoyang Huang <huangzhaoyang@gmail.com> wrote:

> > > -             if (!(gfp_flags & __GFP_DIRECT_RECLAIM) || !(gfp_flags=
 & __GFP_FS))
> > > +             if (current_is_kswapd() || !(gfp_flags & __GFP_FS))
> > >                       return false;
> > >               wait_on_page_fscache(page);
> ...
> If the gfp flag here is used for judging kswapd context, I think the
> answer is yes as kswapd applied __GFP_DIRECT_RECLAIM.

Now I come to look at applying it, I'm not sure whether this change is rig=
ht.

I don't know if kswapd has anything to do with it.  The check is to see if
we're allowed to block at this point - and wait is just for the completion=
 of
a DIO write to disk.

It would seem like gfpflags_allow_blocking() is the right thing to call - =
and
that should use current_is_kswapd() if appropriate.

David

