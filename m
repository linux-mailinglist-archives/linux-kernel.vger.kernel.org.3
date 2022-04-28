Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11912513235
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Apr 2022 13:14:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345416AbiD1LRw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Apr 2022 07:17:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236798AbiD1LRu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Apr 2022 07:17:50 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9761A674E6;
        Thu, 28 Apr 2022 04:14:35 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id a21so5129128edb.1;
        Thu, 28 Apr 2022 04:14:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=klUaX5LsZlPXz+2S/Ecxx3wW7aKARbJJEWDUTbqH/Nk=;
        b=brrOMsvJQTAEXAUQjWINO2YTgDMMd6eT5U+vBpVl+TwLUSly9kanTmCKFsI09W0NYl
         e2Ud7VFpjHD7ZOv2rrFY7O6gb40X211j/T+lAMzWdcDdg+/x4sE7w3V01C/ArdKJBPJz
         vuTtsgxZd6zj1COrgzj+xvPPXJiuOALYIsDnXML7iNhLfsS+DUWQfwvAPqa4bvyY1nHU
         c3loYjBpS4xUd1QWlfW9IbGW4+8t0bYcdkNjSvvQMnWXCzxEmUWurGNy9qTw0pbxEce2
         f2Vx+YZfi6PHYuvS02rI6+HxNxozLE36AWcEtACRlf1khulF/PFP4HVoED0thomwd1CU
         vOog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=klUaX5LsZlPXz+2S/Ecxx3wW7aKARbJJEWDUTbqH/Nk=;
        b=T13jf4JK+xtLLS/Tqvlbt+B4PzrDyeojNA1+VE6SPgWsI4qn4NZDeSWeIsVKd+aqfZ
         oP/PhsHQqxBqMI+rhsFu2NrpZdgAhziCC9jdRkJc/SHiKnERgKC3yOMy0vSpc7HcUCke
         VvC3ziuiX1Oyqv71sLgYpobdyDCGxVw52WhNkTHmBqU7BeZ64fOF98JVMal0mi0IWCrd
         KSjJifpvGhaOpQGngiBXxgmCuk7B07fv+5gJE3ZswQAH22RVsB00cbuzP09TNxW7rYyG
         8+cm/xO6r78+Ihz0L5L3DMA+FebQW01Ca21Grkv0yGnJQ1QnUJwhwbux8a3xjtOTRxDH
         eg9Q==
X-Gm-Message-State: AOAM532CJldxaLNgxpe1/LBzhsJJblsrLedHGqyAGkf7QGlCMWtPbaiX
        +PZ9Z+9iwdo+H9arZu44tCfT6jlFRpo=
X-Google-Smtp-Source: ABdhPJybBsv9UEF9BtIRVZX8Gyzc4N8+6vv3dS/0K6yu0WQ+zmqjfEAZA6iOX42oWlnaDdw3Aew4yQ==
X-Received: by 2002:aa7:dd45:0:b0:425:8cea:8c76 with SMTP id o5-20020aa7dd45000000b004258cea8c76mr34965037edw.353.1651144474081;
        Thu, 28 Apr 2022 04:14:34 -0700 (PDT)
Received: from leap.localnet (host-79-50-86-254.retail.telecomitalia.it. [79.50.86.254])
        by smtp.gmail.com with ESMTPSA id p5-20020a1709066a8500b006f3bdf3a2f4sm3491952ejr.105.2022.04.28.04.14.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Apr 2022 04:14:32 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     Ira Weiny <ira.weiny@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Will Deacon <will@kernel.org>,
        Peter Collingbourne <pcc@google.com>,
        Vlastimil Babka <vbabka@suse.cz>, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, outreachy@lists.linux.dev,
        Jonathan Corbet <corbet@lwn.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v3 4/4] Documentation/vm: Rework "Temporary Virtual Mappings" section
Date:   Thu, 28 Apr 2022 13:14:30 +0200
Message-ID: <6442788.4vTCxPXJkl@leap>
In-Reply-To: <YmpYEkvbJX2JBPvW@linutronix.de>
References: <20220427183821.1979-1-fmdefrancesco@gmail.com> <20220427183821.1979-5-fmdefrancesco@gmail.com> <YmpYEkvbJX2JBPvW@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On gioved=C3=AC 28 aprile 2022 11:02:10 CEST Sebastian Andrzej Siewior wrot=
e:
> On 2022-04-27 20:38:21 [+0200], Fabio M. De Francesco wrote:
> > index e05bf5524174..c8aff448612b 100644
> > --- a/Documentation/vm/highmem.rst
> > +++ b/Documentation/vm/highmem.rst
> > @@ -50,26 +50,78 @@ space when they use mm context tags.
> =E2=80=A6
> > =20
> > -* kmap().  This permits a short duration mapping of a single page.  It=
=20
needs
> > -  global synchronization, but is amortized somewhat.  It is also prone=
=20
to
> > -  deadlocks when using in a nested fashion, and so it is not=20
recommended for
> > -  new code.
> > +  These mappings are thread-local and CPU-local (i.e., migration from=
=20
one CPU
> > +  to another is disabled - this is why they are called "local"), but=20
they don't
> > +  disable preemption.=20
>=20
> So if you replace this block with
>=20
>    These mappings are thread-local and CPU-local meaning that the mapping
>    can only be accessed from within this thread and the thread is bound=20
the
>    CPU while the mapping is active. Even if the thread is preempted=20
(since
>    preemption is never disabled by the function) the CPU can not be
>    unplugged from the system via CPU-hotplug until the mapping is=20
disposed.

OK, I'm too wordy here :(

> The you could drop the latter block
>=20
> >                          It's valid to take pagefaults in a local kmap=
=20
region,
> > +  unless the context in which the local mapping is acquired does not=20
allow it
> > +  for other reasons.
>=20
> > +  kmap_local_page() always returns a valid virtual address and it is=20
assumed
> > +  that kunmap_local() will never fail.
>=20
> from here
>=20
> > +  If a task holding local kmaps is preempted, the maps are removed on=
=20
context
> > +  switch and restored when the task comes back on the CPU. The maps=20
are
> > +  strictly thread-local and CPU-local, therefore it is guaranteed that=
=20
the
> > +  task stays on the CPU and the CPU cannot be unplugged until the=20
local kmaps
> > +  are released.
>=20
> to here since it mostly the same thing.

I agree, this is redundant.

>=20
> > +  Nesting kmap_local_page() and kmap_atomic() mappings is allowed to a=
=20
certain
> > +  extent (up to KMAP_TYPE_NR) but their invocations have to be=20
strictly ordered
> > +  because the map implementation is stack based. See kmap_local_page=20
() kdocs
>=20
> kmap_local_page () =3D> kmap_local_page()

Sure, it's just a typo.

> > +  (included in the "Functions" section) for details on how to manage=20
nested
> > +  mappings.
> > =20
> >  * kmap_atomic().  This permits a very short duration mapping of a=20
single
> >    page.  Since the mapping is restricted to the CPU that issued it, it
> >    performs well, but the issuing task is therefore required to stay on=
=20
that
> >    CPU until it has finished, lest some other task displace its=20
mappings.
> > =20
> > -  kmap_atomic() may also be used by interrupt contexts, since it is=20
does not
> > -  sleep and the caller may not sleep until after kunmap_atomic() is=20
called.
> > +  kmap_atomic() may also be used by interrupt contexts, since it does=
=20
not
> > +  sleep and the callers too may not sleep until after kunmap_atomic()=
=20
is
> > +  called.
> > +
> > +  Each call of kmap_atomic() in the kernel creates a non-preemptible=20
section
> > +  and disable pagefaults. This could be a source of unwanted latency,=
=20
so it
> > +  should be only used if it is absolutely required, otherwise=20
kmap_local_page()
> > +  should be used where it is feasible.
>=20
> I'm not keen about the "absolutely required" wording and "feasible".
> That said, the other pieces look good, thank you for the work.

I'll rewrite the last part of this sentence as it follows:

+ should be only used if it is required, otherwise kmap_local_page()
+ should be preferred.

Thank you so much for the time you have spent for reviewing and helping,

=46abio


