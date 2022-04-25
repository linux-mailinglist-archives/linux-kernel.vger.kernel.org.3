Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 427A750DE71
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 13:05:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241639AbiDYLIO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 07:08:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241731AbiDYLHt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 07:07:49 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B9C671A82B
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 04:04:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1650884650;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=53DTezqepMIC9Xq8psxHzqJsjt4jekr/8PlNq1hXFZw=;
        b=TqptwXh8i3aRWwXleLPIkXHxt7INdH+GvWWUDBzL0rY3mGpDsPkKJv+f9sfHqeeeab8Dts
        iv3pH9IyC6DqxE+/+Vbx8c+ZhOfl5AEQLSb5FK+aXa/xC8sK05njl/ASl90OuWUsh2HtTM
        KDkbwksyvSwrL6h7TSbLc5+p18I3pAo=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-364-el2x6POnNNCwYQETgj74GQ-1; Mon, 25 Apr 2022 07:04:06 -0400
X-MC-Unique: el2x6POnNNCwYQETgj74GQ-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 29F88833962;
        Mon, 25 Apr 2022 11:04:06 +0000 (UTC)
Received: from file01.intranet.prod.int.rdu2.redhat.com (file01.intranet.prod.int.rdu2.redhat.com [10.11.5.7])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 191FA401475;
        Mon, 25 Apr 2022 11:04:06 +0000 (UTC)
Received: from file01.intranet.prod.int.rdu2.redhat.com (localhost [127.0.0.1])
        by file01.intranet.prod.int.rdu2.redhat.com (8.14.4/8.14.4) with ESMTP id 23PB463w025596;
        Mon, 25 Apr 2022 07:04:06 -0400
Received: from localhost (mpatocka@localhost)
        by file01.intranet.prod.int.rdu2.redhat.com (8.14.4/8.14.4/Submit) with ESMTP id 23PB45Cv025592;
        Mon, 25 Apr 2022 07:04:05 -0400
X-Authentication-Warning: file01.intranet.prod.int.rdu2.redhat.com: mpatocka owned process doing -bs
Date:   Mon, 25 Apr 2022 07:04:05 -0400 (EDT)
From:   Mikulas Patocka <mpatocka@redhat.com>
X-X-Sender: mpatocka@file01.intranet.prod.int.rdu2.redhat.com
To:     David Laight <David.Laight@ACULAB.COM>
cc:     "'Linus Torvalds'" <torvalds@linux-foundation.org>,
        Andy Shevchenko <andy@kernel.org>,
        device-mapper development <dm-devel@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Mike Snitzer <msnitzer@redhat.com>,
        Mimi Zohar <zohar@linux.ibm.com>,
        Milan Broz <gmazyland@gmail.com>
Subject: RE: [PATCH] hex2bin: make the function hex_to_bin constant-time
In-Reply-To: <789f0463ce974e90a93f4dbf8c471156@AcuMS.aculab.com>
Message-ID: <alpine.LRH.2.02.2204250701410.10912@file01.intranet.prod.int.rdu2.redhat.com>
References: <alpine.LRH.2.02.2204241648270.17244@file01.intranet.prod.int.rdu2.redhat.com> <CAHk-=wh+Z+OKH3jRttWGHbWSQq2wVMtdnA=ntDiadZu=VxAC7w@mail.gmail.com> <CAHk-=wibmkFz6dybsdpW_3kUnV20FhJazerWDcbm7yCp_Xv+CA@mail.gmail.com>
 <789f0463ce974e90a93f4dbf8c471156@AcuMS.aculab.com>
User-Agent: Alpine 2.02 (LRH 1266 2009-07-14)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.10
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 25 Apr 2022, David Laight wrote:

> From: Linus Torvalds
> > Sent: 24 April 2022 22:42
> > 
> > On Sun, Apr 24, 2022 at 2:37 PM Linus Torvalds
> > <torvalds@linux-foundation.org> wrote:
> > >
> > > Finally, for the same reason - please don't use ">> 8".  Because I do
> > > not believe that bit 8 is well-defined in your arithmetic. The *sign*
> > > bit will be, but I'm not convinced bit 8 is.
> > 
> > Hmm.. I think it's ok. It can indeed overflow in 'char' and change the
> > sign in bit #7, but I suspect bit #8 is always fine.
> > 
> > Still, If you want to just extend the sign bit, ">> 31" _is_ the
> > obvious thing to use (yeah, yeah, properly "sizeof(int)*8-1" or
> > whatever, you get my drift).
> 
> Except that right shifts of signed values are UB.
> In particular it has always been valid to do an unsigned
> shift right on a 2's compliment negative number.
> 
> 	David

Yes. All the standard versions (C89, C99, C11, C2X) say that right shift 
of a negative value is implementation-defined.

So, we should cast it to "unsigned" before shifting it.

Mikulas

