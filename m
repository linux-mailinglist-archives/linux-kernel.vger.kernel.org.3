Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 053055019E8
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Apr 2022 19:18:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245740AbiDNRUp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Apr 2022 13:20:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245714AbiDNRTw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 13:19:52 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BF9B630B
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 10:17:25 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id n18so5192420plg.5
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 10:17:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/xHnbfO/6RDF2V6Som/YOPdX7GJf70J0XIxAV0SFUKc=;
        b=Wef1YPrL1c82H3OcohFJZHkyqYM2Pgnp2Sn52/3jc6OyRc8jdnkyLjTL51mZzDG7iS
         gVutqtKgia4gJQ5EEyjlTYUR3ODJEipRJNWsbiQ0yudFxRHvicckNTd/GfWrm08L85lS
         aBACkHBXM8GMvdgOOTIMZ3ZvAzVYixwiSc99ZxMC5dC9BUrunqd7d261XZgCoQaBITnn
         8u0DxF80r31+6VmgTSdrBgwcr7aR/GHKLIGlE47CIz2l1Fdwu3vmnHEgI2bf6lkgMp7+
         Iff3SMIPnA7Yx/57gV9xT7jh9zms1F38kmOOthyEBN5GroPrDmG4ChoCHraavRNiks5o
         9vnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/xHnbfO/6RDF2V6Som/YOPdX7GJf70J0XIxAV0SFUKc=;
        b=IdJPhGO+m7hRT5v9eL1zhts0H8SSWlfv3P43dZXy8ZT7Xvco1dNHfOgdS/NGtjJv9x
         mNcAirC1BrzrsF21Dg/WzyVNbIBxZQmSgi6EW7BAizxES9fvzB3F4pLOehj3FfCH4eP5
         cMT/xG8DfMHYEe4DIf8wfpN4uoN4LNH4/g0renJg29Tq1Xn+0hjXG9T7luHrGiZ+L1/7
         8UTxpXD8+wo42Iz6ajJka7wROR/oYi48Zk2lXKfnY7E1YDPs28oDINRwWybZ8ghSLX/y
         /zrl/ayEb4RHCO+9wDIF9w0o1yAawmCbuURfh8XdEEhlfevh8+ilfLTyDpi3TkFABTfD
         LJnQ==
X-Gm-Message-State: AOAM5313ex9NTV7yfEDPcGGn7A0eUNKIytaKK7uxazdz72GHbPpFzqJc
        I9plClr40q+m2tV4pFrHUep9fSErYZRtpsDylyUtyQ==
X-Google-Smtp-Source: ABdhPJwCsQXpHY2XnN7Do9HE7onV49GxLhA2Lxccz9/ExwvX5ViFV1e6weDfJfzTsSUR0Tvdqll6UALmEGgpLmUAWQw=
X-Received: by 2002:a17:90a:430d:b0:1bc:f340:8096 with SMTP id
 q13-20020a17090a430d00b001bcf3408096mr4655205pjg.93.1649956644554; Thu, 14
 Apr 2022 10:17:24 -0700 (PDT)
MIME-Version: 1.0
References: <164982968798.684294.15817853329823976469.stgit@dwillia2-desk3.amr.corp.intel.com>
 <164982969858.684294.17819743973041389492.stgit@dwillia2-desk3.amr.corp.intel.com>
 <20220413084309.GV2731@worktop.programming.kicks-ass.net> <CAPcyv4huZVNkxa7-rQ_J=nVN77+5F1AJg5vi6kLHp8t5khcwHA@mail.gmail.com>
 <Ylf0dewci8myLvoW@hirez.programming.kicks-ass.net>
In-Reply-To: <Ylf0dewci8myLvoW@hirez.programming.kicks-ass.net>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Thu, 14 Apr 2022 10:17:13 -0700
Message-ID: <CAPcyv4hFabn6H064HTrH8=GQ-cxsOk4xEK8s66JQxQavfgAzGw@mail.gmail.com>
Subject: Re: [PATCH v2 02/12] device-core: Add dev->lock_class to enable
 device_lock() lockdep validation
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     linux-cxl@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Dave Jiang <dave.jiang@intel.com>,
        Kevin Tian <kevin.tian@intel.com>,
        Vishal L Verma <vishal.l.verma@intel.com>,
        "Schofield, Alison" <alison.schofield@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux NVDIMM <nvdimm@lists.linux.dev>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 14, 2022 at 3:16 AM Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Wed, Apr 13, 2022 at 03:01:21PM -0700, Dan Williams wrote:
>
> > > That's not an obvious conclusion; lockdep has lots of funny annotations,
> > > subclasses is just one.
> > >
> > > I think the big new development in lockdep since that time with Alan
> > > Stern is that lockdep now has support for dynamic keys; that is lock
> > > keys in heap memory (as opposed to static storage).
> >
> > Ah, I was not aware of that, that should allow for deep cleanups of
> > this proposal.
>
> > > If you want lockdep validation for one (or more) dev->mutex instances,
> > > why not pull them out of the no_validate class and use the normal
> > > locking?
> >
> > Sounds perfect, just didn't know how to do that with my current
> > understanding of how to communicate this to lockdep.
> >
> > >
> > > This is all quite insane.
> >
> > Yes, certainly in comparison to your suggestion on the next patch.
> > That looks much more sane, and even better I think it allows for
> > optional lockdep validation without even needing to touch
> > include/linux/device.h.
>
> Right, so lockdep has:
>
>  - classes, based off of lock_class_key address;
>
>    * lock_class_key should be static storage; except now we also have:
>
>        lockdep_{,un}register_key()
>
>      which allows dynamic memory (aka. heap) to be used for classes,
>      important to note that lockdep memory usage is still static storage
>      because the memory allocators use locks too. So if you register too
>      many dynamic keys, you'll run out of lockdep memory etc.. so be
>      careful.
>
>    * things like mutex_init() have a static lock_class_key per site
>      and hence every lock initialized by the same code ends up in the
>      same class by default.
>
>    * can be trivially changed at any time, assuming the lock isn't held,
>      using lockdep_set_class*() family.
>
>      (extensively used all over the kernel, for example by the vfs to
>       give each filesystem type their own locking order rules)
>
>    * lockdep_set_no_validate_class() is a magical variant of
>      lockdep_set_class() that sets a magical lock_class_key.

Golden, thanks Peter!

>
>    * can be changed while held using lock_set_class()

One more sanity check... So in driver subsystems there are cases where
a device on busA hosts a topology on busB. When that happens there's a
need to set the lock class late in a driver since busA knows nothing
about the locking rules of busB. Since the device has a longer
lifetime than a driver when the driver exits it must set dev->mutex
back to the novalidate class, otherwise it sets up a use after free of
the static lock_class_key. I came up with this and it seems to work,
just want to make sure I'm properly using the lock_set_class() API and
it is ok to transition back and forth from the novalidate case:

diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index 990b6670222e..32673e1a736d 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -405,6 +405,29 @@ struct cxl_nvdimm_bridge
*cxl_find_nvdimm_bridge(struct cxl_nvdimm *cxl_nvd);
 #define __mock static
 #endif

+#ifdef CONFIG_PROVE_LOCKING
+static inline void cxl_lock_reset_class(void *_dev)
+{
+       struct device *dev = _dev;
+
+       lock_set_class(&dev->mutex.dep_map, "__lockdep_no_validate__",
+                      &__lockdep_no_validate__, 0, _THIS_IP_);
+}
+
+static inline int cxl_lock_set_class(struct device *dev, const char *name,
+                                    struct lock_class_key *key)
+{
+       lock_set_class(&dev->mutex.dep_map, name, key, 0, _THIS_IP_);
+       return devm_add_action_or_reset(dev, cxl_lock_reset_class, dev);
+}
+#else
+static inline int cxl_lock_set_class(struct device *dev, const char *name,
+                                    struct lock_class_key *key)
+{
+       return 0;
+}
+#endif
+
 #ifdef CONFIG_PROVE_CXL_LOCKING
 enum cxl_lock_class {
        CXL_ANON_LOCK,

>      ( from a lockdep pov it unlocks the held stack,
>        changes the class of your lock, and re-locks the
>        held stack, now with a different class nesting ).
>
>      Be carefule! It doesn't forget the old nesting order, so you
>      can trivally generate cycles.
>
>  - subclasses, basically distinct addresses inside above mentioned
>    lock_class_key object, limited to 8. Normally used with
>    *lock_nested() family of functions. Typically used to lock multiple
>    instances of a single lock class where there is defined order between
>    instances (see for instance: double_rq_lock()).
>
>  - nest_lock; eg. mutex_lock_nest_lock(), which allows expressing things
>    like: multiple locks of class A can be taken in any order, provided
>    we hold lock B.
>
> With many of these, it's possible to get it wrong and annotate real
> deadlocks away, so be careful :-)

Noted.
