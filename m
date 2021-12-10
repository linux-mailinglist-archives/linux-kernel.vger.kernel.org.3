Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E80C46FF79
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Dec 2021 12:08:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234860AbhLJLMQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Dec 2021 06:12:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233407AbhLJLMP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Dec 2021 06:12:15 -0500
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CF73C061746
        for <linux-kernel@vger.kernel.org>; Fri, 10 Dec 2021 03:08:40 -0800 (PST)
Received: by mail-pf1-x429.google.com with SMTP id 8so8189793pfo.4
        for <linux-kernel@vger.kernel.org>; Fri, 10 Dec 2021 03:08:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=pU4E4zp0dRJ3YBMsEmrIPGmx+mLfVwfK9mROOGJDvWA=;
        b=Jt4oYTeyxBg8buM1RGHlmib7mvCk5/VN2M7oVQD8Wg5hGlAhm/MF/Byv9RyvKnooj0
         FT+40KIm8MBfCzOp9P30WYvrZNmjHcHuMWEG0bSg2tGjJ/yUKtfUiTM5Plf0mkTjxoLb
         tB55L4A2P1L2hI76YJFD5YtyAPB3sxWu/1x/LgGwS/g9nYQiNQuj7kY+DpbaZTkNxL3j
         8iwhBeTMRaMb6Xrllnof9hvnEVuzW4kJuF1lQDQOxj5yzxapXsoAdcZ4Iyh75Kj0Pkld
         aDSqP/VxIzs6zmhpXt7+xXLItCvjmDCzOC02aH6xtYn2NaSC7s/G4mE7shwb7V+FmXP9
         c1lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=pU4E4zp0dRJ3YBMsEmrIPGmx+mLfVwfK9mROOGJDvWA=;
        b=3O6QfmBx4pxA/LtgyghLsHqjsTvkrweoLHV8+6Kqa1dwG6Y1k2o6suoSFoaVuLO2M7
         SzWvq0ElMhOpafbCuOGmFy9uE9eQ71NNUpHjUSlZmfSpEaV7+PALQYs/J1xHZZIiU5Ah
         feVfLAFZRyjTDzkkATN6qqpIGmpXeusUzIwR5Ek5jo8B5h6JNEJDTOd6l/GNvxy8DSN2
         7X5zLemd0NVYIMTscc9K9y8TSI2v5JAzIslCfskc9qkulsiGtaB0d9cOGtN8ZKLFOjsk
         cnntUNfRalmKAXIV2EbcniU9Pv32N+jUaL2a8gBX9zJbMNY6Ojt51SdNNBl93pWsGCNc
         oL0g==
X-Gm-Message-State: AOAM533O2rwmi0jqxzoz1lufqgoSH2ujjZIgmtdn8C3LERVj1TVUpiaV
        3NavD+vJ2abyAUUrLA0oKus=
X-Google-Smtp-Source: ABdhPJy4p9Tjog8bYyjnPuaEeGDFRLBgu6djwMci2nDg1J21enoDbHxGk+02svxHPyB6PGP/daqaeg==
X-Received: by 2002:aa7:93c4:0:b0:49f:a7f5:7f5a with SMTP id y4-20020aa793c4000000b0049fa7f57f5amr17478818pff.8.1639134520207;
        Fri, 10 Dec 2021 03:08:40 -0800 (PST)
Received: from odroid ([114.29.23.242])
        by smtp.gmail.com with ESMTPSA id h13sm2891300pfv.84.2021.12.10.03.08.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Dec 2021 03:08:39 -0800 (PST)
Date:   Fri, 10 Dec 2021 11:08:35 +0000
From:   Hyeonggon Yoo <42.hyeyoo@gmail.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Christoph Lameter <cl@gentwo.de>,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>
Subject: Re: Do we really need SLOB nowdays?
Message-ID: <20211210110835.GA632811@odroid>
References: <20211017042852.GA3050@kvm.asia-northeast3-a.c.our-ratio-313919.internal>
 <20211017133618.GA7989@kvm.asia-northeast3-a.c.our-ratio-313919.internal>
 <20211017135708.GA8442@kvm.asia-northeast3-a.c.our-ratio-313919.internal>
 <YWw1n6y/AGED14HD@casper.infradead.org>
 <CAB=+i9Tor-tmZuB8YjATT_rv68nnF2W_TvMvyGp55AGaSyKynw@mail.gmail.com>
 <alpine.DEB.2.22.394.2110251016260.3145@gentwo.de>
 <20211028100414.GA2928@kvm.asia-northeast3-a.c.our-ratio-313919.internal>
 <YXqSoo+b9RTclW/2@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YXqSoo+b9RTclW/2@casper.infradead.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 28, 2021 at 01:08:02PM +0100, Matthew Wilcox wrote:
> On Thu, Oct 28, 2021 at 10:04:14AM +0000, Hyeonggon Yoo wrote:
> > On Mon, Oct 25, 2021 at 10:17:08AM +0200, Christoph Lameter wrote:
> > > On Mon, 18 Oct 2021, Hyeonggon Yoo wrote:
> > > 
> > > > > Better for what use case?  SLOB is for machines with 1-16MB of RAM.
> > > > >
> > > >
> > > > 1~16M is smaller than I thought. Hmm... I'm going to see how it works on
> > > > tiny configuration. Thank you Matthew!
> > > 
> > > Is there any reference where we can see such a configuration? Sure it does
> > > not work with SLUB too?
> > 
> > I thought why Matthew said "SLOB is for machines with 1-16MB of RAM"
> > is because if memory is so low, then it is sensitive to memory usage.
> > 
> > (But I still have doubt if we can run linux on machines like that.)
> 
> I sent you a series of articles about making Linux run in 1MB.

After some time playing with the size of kernel,
I was able to run linux in 6.6MiB of RAM. and the SLOB used
around 300KiB of memory.

Running linux in 1MiB seems almost impossible without introducing
XIP (eXecute In Place) which executes binary directly from ROM or Flash.
(and that's actually not reducing kernel size, it's reducing RAM required to boot)

SLOB seems to be useful when the machine has really really tiny memory.
because the slab allocator can use most of memory when the memory is so
small. But if the machine has some megabytes of RAM,
I think SLUB is right allocator to choose.

Thank you for sending that link.
it was so nice article.
