Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D65CB479504
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Dec 2021 20:45:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240709AbhLQTpt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Dec 2021 14:45:49 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:51328 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232882AbhLQTpr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Dec 2021 14:45:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1639770347;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Igx5pT1HH94P5Uv419NYopECcz8KKF8yUzXDMo5vI7s=;
        b=RF5m2/vUq4VUvOX75naH5Zwo/YLgglTHnulKiIPhFO95rZPAd+Sy92CEBqCZga/NTDoTjD
        1TvGEnrInNuO2Rr/+bcjQkkBIyCsHq+mfEhXSwUi3ZqwutbYHjd2Sv9VJ8fiS8XBHr7HW0
        9VfLWxwTUjhHWa2IJzKqQVeTR5jGBPk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-651-i9MqQCawOQW2ZcZhOUMmqQ-1; Fri, 17 Dec 2021 14:45:41 -0500
X-MC-Unique: i9MqQCawOQW2ZcZhOUMmqQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0D0271006AA6;
        Fri, 17 Dec 2021 19:45:39 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.122])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 558DB5D6B1;
        Fri, 17 Dec 2021 19:45:27 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <71635415237b406c5fe9e568aae8dd148445a72b.camel@kernel.org>
References: <71635415237b406c5fe9e568aae8dd148445a72b.camel@kernel.org> <163967073889.1823006.12237147297060239168.stgit@warthog.procyon.org.uk> <163967105456.1823006.14730395299835841776.stgit@warthog.procyon.org.uk>
To:     Jeff Layton <jlayton@kernel.org>
Cc:     dhowells@redhat.com, linux-cachefs@redhat.com,
        Trond Myklebust <trondmy@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        Steve French <sfrench@samba.org>,
        Dominique Martinet <asmadeus@codewreck.org>,
        Matthew Wilcox <willy@infradead.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Omar Sandoval <osandov@osandov.com>,
        JeffleXu <jefflexu@linux.alibaba.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-afs@lists.infradead.org, linux-nfs@vger.kernel.org,
        linux-cifs@vger.kernel.org, ceph-devel@vger.kernel.org,
        v9fs-developer@lists.sourceforge.net,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 17/68] fscache: Implement simple cookie state machine
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2038059.1639770326.1@warthog.procyon.org.uk>
Date:   Fri, 17 Dec 2021 19:45:26 +0000
Message-ID: <2038060.1639770326@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Layton <jlayton@kernel.org> wrote:

> > +	case FSCACHE_COOKIE_STATE_RELINQUISHING:
> > +	case FSCACHE_COOKIE_STATE_WITHDRAWING:
> > +		if (cookie->cache_priv) {
> > +			spin_unlock(&cookie->lock);
> > +			cookie->volume->cache->ops->withdraw_cookie(cookie);
> > +			spin_lock(&cookie->lock);
> > +		}
> > +
> > +		switch (state) {
> > +		case FSCACHE_COOKIE_STATE_RELINQUISHING:
> > +			fscache_see_cookie(cookie, fscache_cookie_see_relinquish);
> > +			fscache_unhash_cookie(cookie);
> > +			__fscache_set_cookie_state(cookie,
> > +						   FSCACHE_COOKIE_STATE_DROPPED);
> > +			wake = true;
> > +			goto out;
> > +		case FSCACHE_COOKIE_STATE_WITHDRAWING:
> > +			fscache_see_cookie(cookie, fscache_cookie_see_withdraw);
> > +			break;
> > +		default:
> > +			BUG();
> > +		}
> > +
> 
> Ugh, the nested switch here is a bit hard to follow. It makes it seem
> like the state could change due to the withdraw_cookie and you're
> checking it again, but it doesn't do that.
> 
> This would be clearer if you just duplicated the withdraw_cookie stanza
> for both states and moved the stuff below here to a helper or to a new
> goto block.

There are actually three states, but one's added in a later patch.  It
probably does make sense to split the RELINQ state from the other two.

David

