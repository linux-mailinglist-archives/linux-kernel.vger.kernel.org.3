Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1267C544E7C
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jun 2022 16:15:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235182AbiFIOOz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jun 2022 10:14:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233850AbiFIOOr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 10:14:47 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A0351719C4
        for <linux-kernel@vger.kernel.org>; Thu,  9 Jun 2022 07:14:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1654784085;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4XBKvHmwR/IvhiCpGn2MggHZNtRmBYysvOLx4s1tsdc=;
        b=aueGElee75dC8Mfm4uP69yt9d85LiTMisnfjWUM/jqxkti4revIwXm8X0X5dRnnt8snYU1
        8HXAfSK5Pq7g8EUNlXvQ+XvTxKuPdQMo0QzwQdCWTnwoDClt5Ry0Zha5Do5fHgtj+FZJhP
        IQdU+zvx0sOrF4ocPHyO4qbQJuwgorE=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-126-4mrVnexEO5OLtFd6GEWNSg-1; Thu, 09 Jun 2022 10:14:42 -0400
X-MC-Unique: 4mrVnexEO5OLtFd6GEWNSg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 6C60F294EDEC;
        Thu,  9 Jun 2022 14:14:41 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.62])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C119F18EA6;
        Thu,  9 Jun 2022 14:14:39 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <CAHk-=wh6+KUi+T8Ncn6BWTHDTJCzrJxgT47SWbq-ZWs1_vbvHA@mail.gmail.com>
References: <CAHk-=wh6+KUi+T8Ncn6BWTHDTJCzrJxgT47SWbq-ZWs1_vbvHA@mail.gmail.com> <20220422134308.1613610-1-svens@linux.ibm.com> <202204221052.85D0C427@keescook> <CAHk-=wjahn2fZtMxmc4D9UOUGWVws1wZ=X46jrTV=_tEpzXeoA@mail.gmail.com> <202206081404.F98F5FC53E@keescook> <CAHk-=wiFn-_OaWKY=nXt3YSiy=obrNoQW_u7zKO7qoArez=GUw@mail.gmail.com> <AEEBCF5D-8402-441D-940B-105AA718C71F@chromium.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     dhowells@redhat.com, dchinner@redhat.com,
        Kees Cook <keescook@chromium.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] s390: disable -Warray-bounds
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <4147482.1654784079.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date:   Thu, 09 Jun 2022 15:14:39 +0100
Message-ID: <4147483.1654784079@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.11.54.5
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds <torvalds@linux-foundation.org> wrote:

> > Yeah. Happily, this has already been solved, but it looks like David d=
idn't do a pull yet for it?
> >
> > https://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git/=
log/?h=3Dfscache-next
> =

> Good.

Do you want it tagging and a pull req generating, even though it's a singl=
e
patch?

Note that Dave Chinner would rather I converted code like:

	struct myfs_inode *myfsinode =3D xyz;
	myfsinode->netfs.inode.i_ino =3D 123;

to something like:

	struct myfs_inode *myfsinode =3D xyz;
	struct inode *inode =3D VFS_I(myfsinode);
	inode->i_ino =3D 123;

where the translation is wrapped inside a VFS_I() macro in every filesyste=
m
and wants this across all filesystems.  I think the former looks cleaner, =
but
he has a point about how to deal with yet another layer of wrapping being
inserted in the future.  Do you have a preference?

David

