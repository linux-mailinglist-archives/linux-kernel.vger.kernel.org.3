Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 559C049F6E4
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jan 2022 11:12:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244437AbiA1KMe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jan 2022 05:12:34 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:36314 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S243748AbiA1KM3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jan 2022 05:12:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1643364749;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=vrB8wKd/YuQDRzVLBwG4KgSFnRULjzQXEtQgJ4S5oNc=;
        b=I0SqErYooRrn5ZBOHjHEs3SmIxrzzELlo3jWXNvrVQgSxqqE1TWZDSBSDRE9NtHCjsbZ++
        5bRB2q5WwynoZBNaaG+y7uTstdSL4mWrTdNuLMZjWTBaeHjaeToBUelQajXoetempl1+ux
        4Vg3FjNqJOL6pdRIsH5rMaNJ7hCwloA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-339-O80TzOU3MMC2GBxfNuzNFA-1; Fri, 28 Jan 2022 05:12:24 -0500
X-MC-Unique: O80TzOU3MMC2GBxfNuzNFA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 84E102F45;
        Fri, 28 Jan 2022 10:12:22 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.26])
        by smtp.corp.redhat.com (Postfix) with ESMTP id DBEC260C41;
        Fri, 28 Jan 2022 10:12:20 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <20220128074731.1623738-1-hch@lst.de>
References: <20220128074731.1623738-1-hch@lst.de>
To:     Christoph Hellwig <hch@lst.de>
Cc:     dhowells@redhat.com, torvalds@linux-foundation.org,
        viro@zeniv.linux.org.uk, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, Amir Goldstein <amir73il@gmail.com>,
        Chaitanya Kulkarni <chaitanyak@nvidia.com>
Subject: Re: [PATCH v2] fs: rename S_KERNEL_FILE
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <918224.1643364739.1@warthog.procyon.org.uk>
Date:   Fri, 28 Jan 2022 10:12:19 +0000
Message-ID: <918225.1643364739@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Hellwig <hch@lst.de> wrote:

> S_KERNEL_FILE is grossly misnamed.  We have plenty of files hold

"held".

> open by the kernel kernel using filp_open.

You said "kernel" twice.

And so what?  Cachefiles holds files open by filp_open - but it can only do so
temporarily otherwise EMFILE/ENFILE and OOMs start to become a serious problem
because it could end up holding thousands of files open (one or two of the
xfstests cause this to happen).

Further, holding the file open *doesn't* prevent cachefilesd from trying to
cull the file to make space whilst it's "in use".

Yet further, I'm not holding the directories that form the cache layout open
with filp_open at all - I'm not reading them, so that would just be a waste of
resources - but I really don't want cachefilesd culling them because it sees
they're empty but cachefiles is holding them ready.

> This flag OTOH signals the inode as being a special snowflake that
> cachefiles holds onto that can't be unlinked because of ..., erm, pixie
> dust.

Really?  I presume you read the explanation I gave of the races that are a
consequence of splitting the driver between the kernel and userspace?  I could
avoid them - or at least mitigate them - by keeping my own list of all the
inodes in use by cachefiles so that cachefilesd can query it.  I did, in fact,
use to have such a list, but the core kernel already has such lists and the
facilities to translate pathnames into internal objects, so my stuff ought to
be redundant - all I need is one inode flag.

Further, that inode flag can be shared with anyone else who wants to do
something similar.  It's just an "I'm using this" lock.  There's no particular
reason to limit its use to cachefiles.  In fact, it is better if it is then
shared so that in the unlikely event that two drivers try to use the same
file, an error will occur.

I do use it to defend cachefiles against itself also.  In the event that
there's a bug or a race and it tries to reuse its own cache - particularly
with something like NFS that can have multiple superblocks for the same
source, just with different I/O parameters, for example - this can lead to
data corruption.  I try to defend against it in fscache also, but there can be
delayed effects due to object finalisation being done in the background after
fscache has returned to the netfs.

Now, I do think there's an argument to be made for splitting the flag into
two, as I advanced in a proposed patch.  One piece would just be an "I'm using
this", the other would be a "don't delete this" flag.  Both are of potential
use to other drivers.

I take it you'd prefer this to be done a different way?

David

