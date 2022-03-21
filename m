Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2EF04E2372
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Mar 2022 10:38:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345082AbiCUJjh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Mar 2022 05:39:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233668AbiCUJjb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 05:39:31 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8BDA4DF4
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 02:38:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1647855482;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=CKsx9lB6p9WZgwNtKRiFWqPlet0kE4LtzkeugjgOYxw=;
        b=g8tFGSwsSAAPj0jchcr5axtMYkZYVoXwoFu2llviMMuKHEFp0jlnL6DOt/ViPYOn/ZmprV
        bk6/K04/6y4c2a5K8LP7T8ADhwAaRFfUmAC4BHBFiKE9CVEvb//Wgfme7rwICBqdDJlGR8
        /lzAjCtDb2DDGMvNT0VXBYLA2ygnrTc=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-322-jCMNr4XVNeSNL75jysd6Mg-1; Mon, 21 Mar 2022 05:37:58 -0400
X-MC-Unique: jCMNr4XVNeSNL75jysd6Mg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 7D0411044562;
        Mon, 21 Mar 2022 09:37:58 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.19])
        by smtp.corp.redhat.com (Postfix) with ESMTP id AFA01400E11D;
        Mon, 21 Mar 2022 09:37:57 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <1745593.TLkxdtWsSY@leap>
References: <1745593.TLkxdtWsSY@leap> <1821968.CQOukoFCf9@leap> <000000000000b1807c05daad8f98@google.com> <977073.1647852411@warthog.procyon.org.uk>
To:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Cc:     dhowells@redhat.com, christophe.jaillet@wanadoo.fr,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] KASAN: null-ptr-deref Read in __free_pages
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <985900.1647855477.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date:   Mon, 21 Mar 2022 09:37:57 +0000
Message-ID: <985901.1647855477@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.84 on 10.11.54.2
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fabio M. De Francesco <fmdefrancesco@gmail.com> wrote:

> I cannot have any objection, it's up to you to decide :)

Of course you can object.  That's kind of the point of a review;-)

How about the attached instead, then?

David
---
--- a/kernel/watch_queue.c
+++ b/kernel/watch_queue.c
@@ -271,9 +271,8 @@ long watch_queue_set_size(struct pipe_inode_info *pipe=
, unsigned int nr_notes)
 	return 0;
 =

 error_p:
-	for (i =3D 0; i < nr_pages; i++)
-		if (pages[i])
-			__free_page(pages[i]);
+	while (--i >=3D 0)
+		__free_page(pages[i]);
 	kfree(pages);
 error:
 	(void) account_pipe_buffers(pipe->user, nr_pages, pipe->nr_accounted);

