Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C37A519B03
	for <lists+linux-kernel@lfdr.de>; Wed,  4 May 2022 10:58:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347070AbiEDJCR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 May 2022 05:02:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347218AbiEDJCA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 05:02:00 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id DFBF6275FF
        for <linux-kernel@vger.kernel.org>; Wed,  4 May 2022 01:57:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1651654663;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=fvXq2I6YdSSqQfmfOGxLM58nh3ANCa3aK4uOGFmwSCU=;
        b=GauPy2fYEvxsHKnqNxDa49VhePLRHyDGAC8QsNG6+N6RApawOjfdutRk/x2vmSP77mW3Jt
        I9DeN7OilUlYkWcPrh+bjmr6wqpL+NpM58oO9nR0IZQdwj1DAS8vRS3jWDKgL7fzjaTZNx
        mgd/1zhgO6zF7N0bLRSQ1DNCOb53I4k=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-542-6GjmA59aOUmzLHgsh8KXYA-1; Wed, 04 May 2022 04:57:38 -0400
X-MC-Unique: 6GjmA59aOUmzLHgsh8KXYA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 705533C02B61;
        Wed,  4 May 2022 08:57:37 +0000 (UTC)
Received: from file01.intranet.prod.int.rdu2.redhat.com (file01.intranet.prod.int.rdu2.redhat.com [10.11.5.7])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 6EB0B4010E21;
        Wed,  4 May 2022 08:57:36 +0000 (UTC)
Received: from file01.intranet.prod.int.rdu2.redhat.com (localhost [127.0.0.1])
        by file01.intranet.prod.int.rdu2.redhat.com (8.14.4/8.14.4) with ESMTP id 2448va6o023376;
        Wed, 4 May 2022 04:57:36 -0400
Received: from localhost (mpatocka@localhost)
        by file01.intranet.prod.int.rdu2.redhat.com (8.14.4/8.14.4/Submit) with ESMTP id 2448vZ0c023372;
        Wed, 4 May 2022 04:57:35 -0400
X-Authentication-Warning: file01.intranet.prod.int.rdu2.redhat.com: mpatocka owned process doing -bs
Date:   Wed, 4 May 2022 04:57:35 -0400 (EDT)
From:   Mikulas Patocka <mpatocka@redhat.com>
X-X-Sender: mpatocka@file01.intranet.prod.int.rdu2.redhat.com
To:     Stafford Horne <shorne@gmail.com>
cc:     Linus Torvalds <torvalds@linux-foundation.org>,
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
In-Reply-To: <YnI7hE4cIfjsdKSF@antec>
Message-ID: <alpine.LRH.2.02.2205040453050.22937@file01.intranet.prod.int.rdu2.redhat.com>
References: <alpine.LRH.2.02.2204241648270.17244@file01.intranet.prod.int.rdu2.redhat.com> <CAHk-=wh+Z+OKH3jRttWGHbWSQq2wVMtdnA=ntDiadZu=VxAC7w@mail.gmail.com> <alpine.LRH.2.02.2204250723120.26714@file01.intranet.prod.int.rdu2.redhat.com>
 <YnI7hE4cIfjsdKSF@antec>
User-Agent: Alpine 2.02 (LRH 1266 2009-07-14)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Scanned-By: MIMEDefang 2.84 on 10.11.54.2
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 4 May 2022, Stafford Horne wrote:

> On Mon, Apr 25, 2022 at 08:07:48AM -0400, Mikulas Patocka wrote:
>  
> > From: Mikulas Patocka <mpatocka@redhat.com>
> > 
> > -int hex_to_bin(char ch)
> > +int hex_to_bin(unsigned char ch)
> >  {
> > -	if ((ch >= '0') && (ch <= '9'))
> > -		return ch - '0';
> > -	ch = tolower(ch);
> > -	if ((ch >= 'a') && (ch <= 'f'))
> > -		return ch - 'a' + 10;
> > -	return -1;
> > +	unsigned char cu = ch & 0xdf;
> > +	return -1 +
> > +		((ch - '0' +  1) & (unsigned)((ch - '9' - 1) & ('0' - 1 - ch)) >> 8) +
> > +		((cu - 'A' + 11) & (unsigned)((cu - 'F' - 1) & ('A' - 1 - cu)) >> 8);
> >  }
> >  EXPORT_SYMBOL(hex_to_bin);
> 
> Hello,
> 
> Just a heads up it seems this patch is causing some instability with crypto self
> tests on OpenRISC when using a PREEMPT kernel (no SMP).
> 
> This was reported by Jason A. Donenfeld as it came up in wireguard testing.
> 
> I am trying to figure out if this is an OpenRISC PREEMPT issue or something
> else.

Hi

That patch is so simple that I can't imagine how could it break the 
curve25519 test. Are you sure that you bisected it correctly?

Mikulas

