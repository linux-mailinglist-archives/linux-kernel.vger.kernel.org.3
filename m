Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 142B4479B1A
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Dec 2021 14:52:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233277AbhLRNvq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Dec 2021 08:51:46 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:44408 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229580AbhLRNvp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Dec 2021 08:51:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1639835504;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=BIFz5ajtFoBBkDaiDzhdzEAut5QHeIJpeIasvSkTdck=;
        b=Y3m6HIKv3VnjO5l7uiY4+NBWGZCJKoPYjTHgpF+GpuGvrRFRvqwagyqV4FC2pQxZfF5L3B
        VROAM2+ozOA2+aN/N0eWf31EfU9eSReh3CPQc07Xz4L+XfBSedn0AmQBFAUpfpNvSGluAD
        CLkKrYwx16WYXwJLxbvXaNY/yHZA0Sk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-399-Sg7s_sLVNYOqBjhC08zpgA-1; Sat, 18 Dec 2021 08:51:41 -0500
X-MC-Unique: Sg7s_sLVNYOqBjhC08zpgA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 73E6D1853028;
        Sat, 18 Dec 2021 13:51:39 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.122])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 8B45F94B8A;
        Sat, 18 Dec 2021 13:51:37 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <Yb3AbFhc9ApdHpcA@codewreck.org>
References: <Yb3AbFhc9ApdHpcA@codewreck.org> <20211203185816.796637-1-arnd@kernel.org> <YaqwdNGlZDBDcg5R@codewreck.org>
To:     Dominique Martinet <asmadeus@codewreck.org>
Cc:     dhowells@redhat.com, Arnd Bergmann <arnd@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Eric Van Hensbergen <ericvh@gmail.com>,
        Latchesar Ionkov <lucho@ionkov.net>,
        Jeff Layton <jlayton@kernel.org>,
        v9fs-developer@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 9p: fix unused-variable warning
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2222223.1639835496.1@warthog.procyon.org.uk>
Date:   Sat, 18 Dec 2021 13:51:36 +0000
Message-ID: <2222224.1639835496@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dominique Martinet <asmadeus@codewreck.org> wrote:

> David since then fixed the warning differently in v2 of the patch (he
> moved the fscache_note_page_release() out of the ifdef), so I won't do
> anything with this even if in principle I tend to agree that
> if(IS_ENABLED()) lead to better compiler coverage

Yeah, fscache_note_page_release() compiles out in such a case because
v9fs_inode_cookie() becomes unconditionally NULL if it's disabled.

If you want me to do something different, can you give me an incremental patch
to merge into mine?

David

