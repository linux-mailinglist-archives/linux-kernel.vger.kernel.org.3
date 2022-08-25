Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F9C15A1585
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Aug 2022 17:23:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240860AbiHYPXs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Aug 2022 11:23:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239089AbiHYPXl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 11:23:41 -0400
X-Greylist: delayed 1051 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 25 Aug 2022 08:23:38 PDT
Received: from matoro.tk (unknown [IPv6:2600:1700:4b10:9d80::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8199DB9408;
        Thu, 25 Aug 2022 08:23:38 -0700 (PDT)
DKIM-Signature: a=rsa-sha256; bh=AuAC64zMFikVQyOsFvSed5o9/crqW6vUnJOdVdTX1bc=;
 c=relaxed/relaxed; d=matoro.tk;
 h=Subject:Subject:Sender:To:To:Cc:Cc:From:From:Date:Date:MIME-Version:MIME-Version:Content-Type:Content-Type:Content-Transfer-Encoding:Content-Transfer-Encoding:Reply-To:In-Reply-To:In-Reply-To:Message-Id:Message-Id:References:References:Autocrypt:Openpgp;
 i=@matoro.tk; s=20220801; t=1661439948; v=1; x=1661871948;
 b=HJtHo/m3mAL67rsOyV2HRrRp7hqfGXn4hpNwNzCBGVvVx3PxMxJoruJgF//TrwTe7gyCiUzL
 xNnKRubKcezNfRzN9LzubC0zYlARqwY5rD6tHisXvOKh3S3KDf2ibOPQI4UEdOhK0hkO0nueQHq
 qYq7FpmKmjqlqWmkR1poCfdTwsGaqS5LLAQzNnmF9xZzDMkNI99sgQRAOolQ2+Ah5edLbzxTnIy
 DH0RiiBhfxDGlfYYaQrYq58VTlKhEbOktgPiNdc3vbUeDpxn7EBi/PCxGR3iijV7DeAtKt3EEjy
 /btyeTwQynOF8TMEcd4As4a/CloFyfCCp3Qi4NdZCjTyT5H69vuhpBNE0Iq8x3NPqSe9c0R6n89
 +K86hR7XMrtHaFFwaHiziMLTH6BanuWZSt5XG08fh06WDv1LDyvyGNYjqUxHQaI/GvsbOElS8A8
 fCJWuob2oLMnoE8bzIHnjPgVSFq8phTqR0JarONYdgrgih0LUn5YM/4gfOXsN3uSF+AAJG5TVUB
 BDq5X6QUzkriPSr16CgI9Sp+xIxnZXcmKhPR42FMt1s4bbVwOeC8aKJYbfV+JwBFKYg9U42U6+/
 BVDGmIHt7Msl4+k67nDuEpVozBTnuMlNZXJNskgKQvg+kl/l/UHsF67Quba2BJ9SAakn7YT4Zrm
 buqiHEerQ4M=
Received: by matoro.tk (envelope-sender
 <matoro_mailinglist_kernel@matoro.tk>) with ESMTPS id 0e5fc778; Thu, 25 Aug
 2022 11:05:48 -0400
MIME-Version: 1.0
Date:   Thu, 25 Aug 2022 11:05:48 -0400
From:   matoro <matoro_mailinglist_kernel@matoro.tk>
To:     Jan Kara <jack@suse.cz>
Cc:     Meelis Roos <mroos@linux.ee>, Matthew Wilcox <willy@infradead.org>,
        "Theodore Y. Ts'o" <tytso@mit.edu>, linux-alpha@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>, linux-block@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: ext4 corruption on alpha with 4.20.0-09062-gd8372ba8ce28
In-Reply-To: <20190221132916.GA22886@quack2.suse.cz>
References: <076b8b72-fab0-ea98-f32f-f48949585f9d@linux.ee>
 <20190216174536.GC23000@mit.edu>
 <e175b885-082a-97c1-a0be-999040a06443@linux.ee>
 <20190218120209.GC20919@quack2.suse.cz>
 <4e015688-8633-d1a0-308b-ba2a78600544@linux.ee>
 <20190219132026.GA28293@quack2.suse.cz>
 <20190219144454.GB12668@bombadil.infradead.org>
 <d444f653-9b99-5e9b-3b47-97f824c29b0e@linux.ee>
 <20190220094813.GA27474@quack2.suse.cz>
 <2381c264-92f5-db43-b6a5-8e00bd881fef@linux.ee>
 <20190221132916.GA22886@quack2.suse.cz>
Message-ID: <97dbffaefa65a83b36e1ec134fd53a66@matoro.tk>
X-Sender: matoro_mailinglist_kernel@matoro.tk
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RDNS_NONE,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello all, I know this is quite an old thread.  I recently acquired some 
alpha hardware and have run into this exact same problem on the latest 
stable kernel (5.18 and 5.19).  CONFIG_COMPACTION seems to be totally 
broken and causes userspace to be extremely unstable - random segfaults, 
corruption of glibc data structures, gcc ICEs etc etc - seems most 
noticable during tasks with heavy I/O load.

My hardware is a DS15 (Titan), so only slightly newer than the Tsunamis 
mentioned earlier.  The problem is greatly exacerbated when using a 
machine-optimized kernel (CONFIG_ALPHA_TITAN) over one with 
CONFIG_ALPHA_GENERIC.  But it still doesn't go away on a generic kernel, 
just pops up less often, usually very I/O heavy tasks like checking out 
a tag in the kernel repo.

However all of this seems to be dependent on CONFIG_COMPACTION.  With 
this toggled off all problems disappear, regardless of other options.  I 
tried reverting the commit 88dbcbb3a4847f5e6dfeae952d3105497700c128 
mentioned earlier in the thread (the structure has moved to a different 
file but was otherwise the same), but it unfortunately did not make a 
difference.

Since this doesn't seem to have a known cause or an easy fix, would it 
be reasonable to just add a Kconfig dep to disable it automatically on 
alpha?

Thank you!

-------- Original Message --------
Subject: Re: ext4 corruption on alpha with 4.20.0-09062-gd8372ba8ce28
Date: 2019-02-21 08:29
 From: Jan Kara <jack@suse.cz>
To: Meelis Roos <mroos@linux.ee>

On Thu 21-02-19 01:23:50, Meelis Roos wrote:
> > > First, I found out that both the problematic alphas had memory compaction and
> > > page migration and bounce buffers turned on, and working alphas had them off.
> > >
> > > Next, turing off these options makes the problematic alphas work.
> >
> > OK, thanks for testing! Can you narrow down whether the problem is due to
> > CONFIG_BOUNCE or CONFIG_MIGRATION + CONFIG_COMPACTION? These are two
> > completely different things so knowing where to look will help. Thanks!
> 
> Tested both.
> 
> Just CONFIG_MIGRATION + CONFIG_COMPACTION breaks the alpha.
> Just CONFIG_BOUNCE has no effect in 5 tries.

OK, so page migration is problematic. Thanks for confirmation!

								Honza
