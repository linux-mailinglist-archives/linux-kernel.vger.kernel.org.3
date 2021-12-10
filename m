Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D1C0746FF50
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Dec 2021 12:05:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240207AbhLJLIf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Dec 2021 06:08:35 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:25977 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234606AbhLJLIf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Dec 2021 06:08:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1639134299;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=3tIObzwONcMa5RCd0Hkumd34/K1eKJP2JRRip7obC0A=;
        b=HKbkPyzKGzHYPob9y+FZDgsF3J3zoBah3G1n9JD/neNueEiNYeSJgpAbShJAdWa4NdpKZA
        OKuEgGHYCuhabc3sHglJp0dmzOuCNZaypYURIoicgCZTK7c2dEBiXaz2z42lD/sIpJdDC5
        qKK7kaSBqLhhLf3HLi7nXTAGlSndWKM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-384-npGU6MadO1yZ0BthSq5lCw-1; Fri, 10 Dec 2021 06:04:58 -0500
X-MC-Unique: npGU6MadO1yZ0BthSq5lCw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 25790100E32C;
        Fri, 10 Dec 2021 11:04:57 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.122])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 887B85D9D5;
        Fri, 10 Dec 2021 11:04:54 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <20211210073619.21667-3-jefflexu@linux.alibaba.com>
References: <20211210073619.21667-3-jefflexu@linux.alibaba.com> <20211210073619.21667-1-jefflexu@linux.alibaba.com>
To:     Jeffle Xu <jefflexu@linux.alibaba.com>
Cc:     dhowells@redhat.com, linux-cachefs@redhat.com, xiang@kernel.org,
        chao@kernel.org, linux-erofs@lists.ozlabs.org,
        linux-fsdevel@vger.kernel.org, joseph.qi@linux.alibaba.com,
        bo.liu@linux.alibaba.com, tao.peng@linux.alibaba.com,
        gerry@linux.alibaba.com, eguan@linux.alibaba.com,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC 02/19] cachefiles: implement key scheme for demand-read mode
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <269787.1639134293.1@warthog.procyon.org.uk>
Date:   Fri, 10 Dec 2021 11:04:53 +0000
Message-ID: <269788.1639134293@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Jeffle Xu <jefflexu@linux.alibaba.com> wrote:

> Thus simplify the logic of placing backing files, in which backing files
> are under "cache/<volume>/" directory directly.

You then have a scalability issue on the directory inode lock - and there may
also be limits on the capacity of a directory.  The hash function is meant to
work the same, no matter the cpu arch, so you should be able to copy that to
userspace and derive the hash yourself.

> Also skip coherency checking currently to ease the development and debug.

Better if you can do that in erofs rather than cachefiles.  Just set your
coherency data to all zeros or something.

David

