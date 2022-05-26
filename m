Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB2EF534D95
	for <lists+linux-kernel@lfdr.de>; Thu, 26 May 2022 12:50:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236132AbiEZKuY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 May 2022 06:50:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232894AbiEZKuU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 May 2022 06:50:20 -0400
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com [IPv6:2607:f8b0:4864:20::d36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8867CEB86
        for <linux-kernel@vger.kernel.org>; Thu, 26 May 2022 03:50:19 -0700 (PDT)
Received: by mail-io1-xd36.google.com with SMTP id f4so1178531iov.2
        for <linux-kernel@vger.kernel.org>; Thu, 26 May 2022 03:50:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=TC+g0nLAl/Vtki0o8V8TPa4Q9UDxrM3TqOj5/L4+ixM=;
        b=YFtSfT1JENMX6vzmwrx9GUbDu6/VrDr0IVJXPX2gPnW/hjKdIBiu33pEJOVxzUsw3Q
         x8OLELh31z75OJ0Gr5ZVVXHB2/2YyzR17mKXIj2WitC/FOmbvyhKCbcsAnDL871UhB90
         1c9fp2OQkf/e129KebQgybN3Uf+sWJu2myQSYcc+LGU45Sy4xQH5ntgeP3HOB+7lyVkZ
         w08YnDMYmP4ap7DT4XwMf5rlSSlldPalKvbouARLM3j7BClrRqllsKQ+d07rEwMZsAHW
         EQhnlZso+cIP/G8XyqToiCG3T0cYvIJEJXvlE/PWFHx9/+kCow1npxzOtkSXD89wQtbg
         a+kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=TC+g0nLAl/Vtki0o8V8TPa4Q9UDxrM3TqOj5/L4+ixM=;
        b=l19Qg2Dtsk21rvwLdXnPBhz9wYyR2N8Ssn0n3gVrJMY9e7ukWeKb8f489u51HuiRzf
         KKmB/ylEXb7EWZgZHUDdA88thkFHr0dRaz9qc73QvFs1zXSlbpGC4Qsex61nrs/lfPWD
         QzJM1CkF9+5R8qm6XkrMWLDL615glFcPggHTTTCBq9roJfOpkBgOsN4zUXLUuWcqFmtK
         Cf6ZXMjPgPvzDxowwZ/LfkvxggyEZiYaUgcbMIXM33YbM5bxld5BguIzc7yd1aEJf10Y
         msmy06lRMpUuT5IBIhTBMwh0MSWo6VVL9bZlUkv0EY3t/lyKwq+lmtPXEqALjBZBdWt9
         VGoQ==
X-Gm-Message-State: AOAM533BKHKK5hR+ZTnqDXIs4PmxQDlk3JmTTqyTf3XUsBxyA+uY61UZ
        wJIkO18o9a8e6HEE7jGW36Shl7l0V9baCuyO
X-Google-Smtp-Source: ABdhPJwUpV2a90iS2PiXgiTesfBKCL+xwb8RUX/N5sKCYXvl4cOcQJr9lDj9vqIttu3IQmrFrI3nxQ==
X-Received: by 2002:a05:6638:1c13:b0:32e:c1d:a790 with SMTP id ca19-20020a0566381c1300b0032e0c1da790mr18978604jab.43.1653562219209;
        Thu, 26 May 2022 03:50:19 -0700 (PDT)
Received: from n2.us-central1-a.c.spheric-algebra-350919.internal (151.16.70.34.bc.googleusercontent.com. [34.70.16.151])
        by smtp.gmail.com with ESMTPSA id m1-20020a923f01000000b002d11397f4f9sm409593ila.74.2022.05.26.03.50.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 May 2022 03:50:18 -0700 (PDT)
Date:   Thu, 26 May 2022 10:50:17 +0000
From:   Hyeonggon Yoo <42.hyeyoo@gmail.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Vlastimil Babka <vbabka@suse.cz>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>, patches@lists.linux.dev,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Alexander Potapenko <glider@google.com>
Subject: Re: [GIT PULL] slab for 5.19
Message-ID: <Yo9baUjgXqM63vSS@n2.us-central1-a.c.spheric-algebra-350919.internal>
References: <8062f61e-5a4d-00a5-be1a-7921d3277e9d@suse.cz>
 <CAHk-=wiztQWhEw4tLiH3t5gw=gKB7XtoTXC=S2bhxBxoxOVZLw@mail.gmail.com>
 <6cdbe746-2c6f-f698-11d4-9f86d2c4e5cc@suse.cz>
 <CAHk-=wjC5nS+fnf6EzRD9yQRJApAhxx7gRB87ZV+pAWo9oVrTg@mail.gmail.com>
 <af059855-959f-95b8-afc4-fad97e52cb46@suse.cz>
 <CAHk-=wjDNR5MxVXk17FjXJApUY5e7GWZGUe7t4e98RJALooXDA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wjDNR5MxVXk17FjXJApUY5e7GWZGUe7t4e98RJALooXDA@mail.gmail.com>
X-Spam-Status: No, score=-0.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,HK_RANDOM_ENVFROM,
        HK_RANDOM_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 25, 2022 at 04:07:24PM -0700, Linus Torvalds wrote:
> On Wed, May 25, 2022 at 3:01 PM Vlastimil Babka <vbabka@suse.cz> wrote:
> >
> > Yes, running rcutorture will trigger that stackdepot allocation, but as
> > that's in RCU debugging part of config, I considered it in the same
> > category as enabling slub debugging.
> 
> Yeah, I don't think rcutorture is a problem per se, it was more an
> example of a random interaction that doesn't actually seem to make
> much sense.

Creating cache with SLAB_STORE_USER is (currently) done in rcutorture.
SLAB_STORE_USER means "we're going to track every user of this slab
cache" so IMO it should not be done if not debugging.

Otherwise stackdepot will be used only when user passes slub_debug
boot parameter. 

> As far as I can tell, there is nothing in rcutorture that actually
> wants that stack trace, and it seems to be doing just a test of the
> object dumping working.

dumping an arbitrary object may call kmem_dump_obj(), which will dump
slab objects and thus printing where it was allocated.

> 
> So it was more the oddity and randomness of it that made me go
> "Whaah?" There might be others hiding elsewhere, that rcutorture use
> just  happened to use the flag explicitly.
> 
>              Linus

AFAIK only 1) creating cache with SLAB_STORE_USER or 2) passing
slub_debug make kernel allocate hash table for stackdepot.

This do not look that odd too me.

But I agree not asking size of hash table to user and by 1) using
rhashtables or 2) deciding size of hash table at runtime would be
better :)
