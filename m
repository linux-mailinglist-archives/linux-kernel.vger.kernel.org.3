Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B89246E03A
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Dec 2021 02:24:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233910AbhLIB1h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Dec 2021 20:27:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229520AbhLIB1g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Dec 2021 20:27:36 -0500
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FF2DC061746
        for <linux-kernel@vger.kernel.org>; Wed,  8 Dec 2021 17:24:03 -0800 (PST)
Received: by mail-ed1-x529.google.com with SMTP id r11so14173657edd.9
        for <linux-kernel@vger.kernel.org>; Wed, 08 Dec 2021 17:24:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=djkd7kU0HKK9P5mJFWg35mLxaEd3Gn4ggjL+YYI2Fxg=;
        b=CdUQEtuDKMWi8LMopTU1N0gv5eoDqcN5kA9XghxcUH5sLhkkJBBRAbBMdyOKEV/ylv
         5x4WBjP+lfP1qFdPvkL7Hrrw0DHKy4r/JoIrcdODrR0HRGzpPk+cKuq6g6KpXaS/Xt8n
         giXoxnG6YXHtLfXeNQhgpjXz8UhMZ4MIO+j64lptb20F+ed4FSeigpswpZNSl3ZpRoZb
         tivmE4apjrS/j782YmiikjiIf836Jm8RU26RN0fvQNvUUGM1o1HFUdOpCGoxnDHwBnxp
         jJJmYxfA0pcLB+elptbTQTb5bvCrRGQC6FOjXTs544NPN/4n0i2dwIct+K5kySTizYin
         Bo3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=djkd7kU0HKK9P5mJFWg35mLxaEd3Gn4ggjL+YYI2Fxg=;
        b=aQR3p6S1junQ+sz83ofLull59bdGiZjo3E4tVnygC07PpZ02M0fk9K0IU+OuJHqOa+
         tYPN9ls1SnmwJU7kM2QfJC30FX9Usot1w2JGiYNxt7r9d94ftU3NOKFHj4MJMTrVX91p
         mUdtT6QHAmn5IRDr00l6BH3IE1zWI2P21Vfy1vuj/gekOfMJaTDW2ZOr56VOwOc/ok5K
         SXgJAHAqRfNhxpB99BkMJ3K3YjTf4U+Q4PF1ZJrBqO7+VB65V99ESonubIpldFDs5SW0
         4zZySGOqKwhPEvvD9hoidcD0BNdXxsMTYsss7wmLk18I4knxNPTEBJMMd5Z3T6DIs1Nc
         54tQ==
X-Gm-Message-State: AOAM5338GibQRnB3vqQCilHLVjXycgcMbf6PDNsSAIkOB6swlq+aMjtL
        LDlGoh7HTlsXnQ360uJdv1TYsEwUSaL7OHfBcQ361A==
X-Google-Smtp-Source: ABdhPJzSKZQOBcRJ8636EiVUcNbp0iqM5adP6qAINVTurdqH+v8qFVpv2I212KR9BQDiBuJREbJg4zul5yOj9bL1PXY=
X-Received: by 2002:aa7:d34c:: with SMTP id m12mr24849425edr.269.1639013041984;
 Wed, 08 Dec 2021 17:24:01 -0800 (PST)
MIME-Version: 1.0
References: <20211208203544.2297121-1-pasha.tatashin@soleen.com> <YbEeKiatjGoCD6Yi@casper.infradead.org>
In-Reply-To: <YbEeKiatjGoCD6Yi@casper.infradead.org>
From:   Pasha Tatashin <pasha.tatashin@soleen.com>
Date:   Wed, 8 Dec 2021 20:23:24 -0500
Message-ID: <CA+CK2bAnMGOXoszHRnFpmYAceF9K1BJRkf88N__ExgA4o1d2Sg@mail.gmail.com>
Subject: Re: [PATCH 00/10] Hardening page _refcount
To:     Matthew Wilcox <willy@infradead.org>
Cc:     LKML <linux-kernel@vger.kernel.org>, linux-mm <linux-mm@kvack.org>,
        linux-m68k@lists.linux-m68k.org,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        william.kucharski@oracle.com,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        schmitzmic@gmail.com, Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Roman Gushchin <guro@fb.com>,
        Muchun Song <songmuchun@bytedance.com>, weixugc@google.com,
        Greg Thelen <gthelen@google.com>,
        David Rientjes <rientjes@google.com>,
        Paul Turner <pjt@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 8, 2021 at 4:05 PM Matthew Wilcox <willy@infradead.org> wrote:
>
> On Wed, Dec 08, 2021 at 08:35:34PM +0000, Pasha Tatashin wrote:
> > It is hard to root cause _refcount problems, because they usually
> > manifest after the damage has occurred.  Yet, they can lead to
> > catastrophic failures such memory corruptions. There were a number
> > of refcount related issues discovered recently [1], [2], [3].
> >
> > Improve debugability by adding more checks that ensure that
> > page->_refcount never turns negative (i.e. double free does not
> > happen, or free after freeze etc).
> >
> > - Check for overflow and underflow right from the functions that
> >   modify _refcount
> > - Remove set_page_count(), so we do not unconditionally overwrite
> >   _refcount with an unrestrained value
> > - Trace return values in all functions that modify _refcount
>

Hi Matthew,

Thank you for looking at this series.

> You're doing a lot more atomic instructions with these patches.

This is not exactly so. There are no *more* atomic instructions. There
are, however, different atomic instructions:

For example:  atomic_add() becomes atomic_fetch_add()

On x86 it is:

atomic_add:
    lock add %eax,(%rsi)

atomic_fetch_add:
    lock xadd %eax,(%rsi)

On ARM64, I believe the same CAS instruction is used for both.

  Have you
> done any performance measurements with these patches applied and debug
> disabled?

Yes, I have done some performance tests exactly as you described with
CONFIG_DEBUG_VM disabled and these patches applied.
I tried: hackbench, unixbench, and a few more benchmarks; I did not
see any performance difference.

>  I'm really not convinced it's worth closing
> one-instruction-wide races of this kind when they are "shouldn't ever
> happen" situations.  If the debugging will catch the problem in 99.99%
> of cases and miss 0.01% without using atomic instructions, that seems
> like a better set of tradeoffs than catching 100% of problems by using
> the atomic instructions.

I think we should relax the precise catching of bugs only if there is
indeed a measurable performance impact. The problem is that if there
is a __refcount bug, the security consequences are dire as it may lead
to leaking memory from one process to another.

Thanks,
Pasha
