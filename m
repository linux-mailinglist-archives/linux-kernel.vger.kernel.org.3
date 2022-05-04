Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB60A519E9A
	for <lists+linux-kernel@lfdr.de>; Wed,  4 May 2022 13:54:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348861AbiEDL55 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 May 2022 07:57:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346784AbiEDL54 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 07:57:56 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 72A5A21E37
        for <linux-kernel@vger.kernel.org>; Wed,  4 May 2022 04:54:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1651665259;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=/49Ts2Y3PyK3UG8Ta4Osw4LZ0F6LxlnPsPESd+HWXHY=;
        b=S8UwElLoXEo4fohtFXhGSRY0oeV9pAWChuS1rYHPEw9gFfYhmC6atVGzOvqAmQ4C6bVKD0
        9GKGVYPKploYEbhBmwKvDNOJi1Ey9FHQyb20xGK2c1XGuxoNIEyw29obJmlZG3RlSR+d7/
        6fIACVHTFYcnxDfYkl3I19mwEKptXUU=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-198-9Sh-mlorMq-AjzZQYiv4cg-1; Wed, 04 May 2022 07:54:15 -0400
X-MC-Unique: 9Sh-mlorMq-AjzZQYiv4cg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 0A7A41C04B40;
        Wed,  4 May 2022 11:54:15 +0000 (UTC)
Received: from file01.intranet.prod.int.rdu2.redhat.com (file01.intranet.prod.int.rdu2.redhat.com [10.11.5.7])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id D57CB40CF8F8;
        Wed,  4 May 2022 11:54:14 +0000 (UTC)
Received: from file01.intranet.prod.int.rdu2.redhat.com (localhost [127.0.0.1])
        by file01.intranet.prod.int.rdu2.redhat.com (8.14.4/8.14.4) with ESMTP id 244BsEPg020594;
        Wed, 4 May 2022 07:54:14 -0400
Received: from localhost (mpatocka@localhost)
        by file01.intranet.prod.int.rdu2.redhat.com (8.14.4/8.14.4/Submit) with ESMTP id 244BsEjr020590;
        Wed, 4 May 2022 07:54:14 -0400
X-Authentication-Warning: file01.intranet.prod.int.rdu2.redhat.com: mpatocka owned process doing -bs
Date:   Wed, 4 May 2022 07:54:14 -0400 (EDT)
From:   Mikulas Patocka <mpatocka@redhat.com>
X-X-Sender: mpatocka@file01.intranet.prod.int.rdu2.redhat.com
To:     Andy Shevchenko <andriy.shevchenko@intel.com>
cc:     Stafford Horne <shorne@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andy Shevchenko <andy@kernel.org>,
        device-mapper development <dm-devel@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Mike Snitzer <msnitzer@redhat.com>,
        Mimi Zohar <zohar@linux.ibm.com>,
        Milan Broz <gmazyland@gmail.com>, Jason@zx2c4.com
Subject: Re: [PATCH v2] hex2bin: make the function hex_to_bin constant-time
In-Reply-To: <YnJFViBFIgYOl7/2@smile.fi.intel.com>
Message-ID: <alpine.LRH.2.02.2205040752210.20320@file01.intranet.prod.int.rdu2.redhat.com>
References: <alpine.LRH.2.02.2204241648270.17244@file01.intranet.prod.int.rdu2.redhat.com> <CAHk-=wh+Z+OKH3jRttWGHbWSQq2wVMtdnA=ntDiadZu=VxAC7w@mail.gmail.com> <alpine.LRH.2.02.2204250723120.26714@file01.intranet.prod.int.rdu2.redhat.com> <YnI7hE4cIfjsdKSF@antec>
 <alpine.LRH.2.02.2205040453050.22937@file01.intranet.prod.int.rdu2.redhat.com> <YnJFViBFIgYOl7/2@smile.fi.intel.com>
User-Agent: Alpine 2.02 (LRH 1266 2009-07-14)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Scanned-By: MIMEDefang 2.84 on 10.11.54.1
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 4 May 2022, Andy Shevchenko wrote:

> On Wed, May 04, 2022 at 04:57:35AM -0400, Mikulas Patocka wrote:
> > On Wed, 4 May 2022, Stafford Horne wrote:
> > > On Mon, Apr 25, 2022 at 08:07:48AM -0400, Mikulas Patocka wrote:
> 
> ...
> 
> > > Just a heads up it seems this patch is causing some instability with crypto self
> > > tests on OpenRISC when using a PREEMPT kernel (no SMP).
> > > 
> > > This was reported by Jason A. Donenfeld as it came up in wireguard testing.
> > > 
> > > I am trying to figure out if this is an OpenRISC PREEMPT issue or something
> > > else.
> 
> > That patch is so simple that I can't imagine how could it break the 
> > curve25519 test. Are you sure that you bisected it correctly?
> 
> Can you provide a test cases for hex_to_bin()?

I tested it with this:

#include <stdio.h>

int hex_to_bin(unsigned char c);

int main(void)
{
        int i;
        for (i = 0; i < 256; i++)
                printf("%02x - %d\n", i, hex_to_bin(i));
        return 0;
}

Mikulas

