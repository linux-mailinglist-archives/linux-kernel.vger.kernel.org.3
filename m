Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B79AD5828E4
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jul 2022 16:46:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234117AbiG0Oqx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jul 2022 10:46:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233343AbiG0Oqu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jul 2022 10:46:50 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 502C21EC68
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jul 2022 07:46:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1658933208;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xuFpOaXJaj/gAOk0ci5YpbcXaLPN1T4Ab/tSiyAfQzA=;
        b=EzTr3jpc6kPxoCbFYwAUEIoTfmrZOPhUUPijqNTdlS4XG0drK/IpPrBBEKb9oGO1+2mqAH
        801GwC4ADlWLPSJI6PVhdvJLNkGpehL9h9uvdOL4wO+86rsYKrMeC/BN4x/5yc3wboTFqV
        QPuN/3Ucva3NTvp5b16GaAKmPanQ338=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-635-zjaeplmAPJ668snlUMnWUQ-1; Wed, 27 Jul 2022 10:46:42 -0400
X-MC-Unique: zjaeplmAPJ668snlUMnWUQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 2FA543C10222;
        Wed, 27 Jul 2022 14:46:42 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.10])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E06FA1415121;
        Wed, 27 Jul 2022 14:46:40 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <1822b768504.1d4e377e236061.5518350412857967240@siddh.me>
References: <1822b768504.1d4e377e236061.5518350412857967240@siddh.me> <20220723135447.199557-1-code@siddh.me> <Ytv/4Tljvlt0PJ2r@kroah.com>
To:     Siddh Raman Pant <code@siddh.me>
Cc:     dhowells@redhat.com, "Greg KH" <gregkh@linuxfoundation.org>,
        "Christophe JAILLET" <christophe.jaillet@wanadoo.fr>,
        "Eric Dumazet" <edumazet@google.com>,
        "Fabio M. De Francesco" <fmdefrancesco@gmail.com>,
        "linux-security-modules" <linux-security-module@vger.kernel.org>,
        "linux-kernel-mentees" 
        <linux-kernel-mentees@lists.linuxfoundation.org>,
        "linux-kernel" <linux-kernel@vger.kernel.org>,
        "syzbot+c70d87ac1d001f29a058" 
        <syzbot+c70d87ac1d001f29a058@syzkaller.appspotmail.com>
Subject: Re: [PATCH] kernel/watch_queue: Make pipe NULL while clearing watch_queue
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <3558069.1658933200.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date:   Wed, 27 Jul 2022 15:46:40 +0100
Message-ID: <3558070.1658933200@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.7
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Siddh Raman Pant <code@siddh.me> wrote:

> Greg KH <gregkh@linuxfoundation.org> wrote:

> > > -	spin_unlock_bh(&wqueue->lock);
> > >  	rcu_read_unlock();
> >
> > Also you now have a spinlock held when calling rcu_read_unlock(), are
> > you sure that's ok?

Worse, we have softirqs disabled still, which might cause problems for
rcu_read_unlock()?

> We logically should not do write operations in a read critical section, =
so the
> nulling of `wqueue->pipe->watch_queue` should happen after rcu_read_unlo=
ck().
> Also, since we already have a spinlock, we can use it to ensure the null=
ing.
> So I think it is okay.

Read/write locks are perhaps misnamed in this sense; they perhaps should b=
e
shared/exclusive.  But, yes, we *can* do certain write operations with the
lock held - if we're careful.  Locks are required if we need to pairs of
related memory accesses; if we're only making a single non-dependent write=
,
then we don't necessarily need a write lock.

However, you're referring to RCU read lock.  That's a very special lock th=
at
has to do with maintenance of persistence of objects without taking any ot=
her
lock.  The moment you drop that lock, anything you accessed under RCU prot=
ocol
rules should be considered to have evaporated.

Think of it more as a way to have a deferred destructor/deallocator.

So I would do:

+
+	/* Clearing the watch queue, so we should clean the associated pipe. */
+	if (wqueue->pipe) {
+		wqueue->pipe->watch_queue =3D NULL;
+		wqueue->pipe =3D NULL;
+	}
+
	spin_unlock_bh(&wqueue->lock);
 	rcu_read_unlock();
 }

However, since you're now changing wqueue->pipe whilst a notification is b=
eing
posted, you need a barrier in post_one_notification() to prevent the compi=
ler
from reloading the value:

	struct pipe_inode_info *pipe =3D READ_ONCE(wqueue->pipe);

David

