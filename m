Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF18950FC39
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 13:47:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345787AbiDZLur (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 07:50:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229585AbiDZLup (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 07:50:45 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D88C032EF1;
        Tue, 26 Apr 2022 04:47:37 -0700 (PDT)
Date:   Tue, 26 Apr 2022 13:47:34 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1650973656;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qhTe3rXGVtUc76KewVm4yQpY7h0Bmtd3SNVKnbkCB3s=;
        b=asVeung/CiSsVRuxtfEAm3It6XUCErzkC6VvkOvaQQ8fZCbx042HNYJvLrHVr20k/pp0MS
        /azs8QxjNgHC3QrPkGV8iyIaI4cZBueBrvM5CzZXm/AFYecW39Bo+wdt1W8PPJOcbbJsIw
        i4UI0ue9IdSR2YRvkzqKNMq7aYL5s4294DL5qPrkXXjYf1H5QwebXCyxGoYImg0NVHQU7V
        oVj35Oet9xC1xPHIS0Mkd5ZmjGLWOA1482+1EsMyeAQexYCJqzchfO4+n4XYS1B6iqGxdc
        0T8qsEUVBvIbX5lYJFWuA5WK46KLfad3MhJ8deKdohZ3YgYn/l/uysL28bvSyw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1650973656;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qhTe3rXGVtUc76KewVm4yQpY7h0Bmtd3SNVKnbkCB3s=;
        b=Ks55If1juL3ARLDz2V4EPwsZyCTMB7miQuJvHrqgOUjIOunhxHzS7P1lpf+Ttaw5ZjDzJC
        Dml4KxUUvc1L2RDw==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Cc:     Ira Weiny <ira.weiny@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Will Deacon <will@kernel.org>,
        Peter Collingbourne <pcc@google.com>,
        Vlastimil Babka <vbabka@suse.cz>, linux-kernel@vger.kernel.org,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        outreachy@lists.linux.dev, Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v2 4/4] Documentation/vm: Rework "Temporary Virtual
 Mappings" section
Message-ID: <Ymfb1saaHVuq4IUl@linutronix.de>
References: <20220425162400.11334-1-fmdefrancesco@gmail.com>
 <20220425162400.11334-5-fmdefrancesco@gmail.com>
 <YmecctAD9XXYG8CR@linutronix.de>
 <3610796.MHq7AAxBmi@leap>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <3610796.MHq7AAxBmi@leap>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-04-26 12:45:12 [+0200], Fabio M. De Francesco wrote:
> > > +* kmap_local_page().  This function is used to require short term=20
> mappings.
> > > +  It can be invoked from any context (including interrupts) but the=
=20
> mappings
> > > +  can only be used in the context which acquired them.
> > > +
> > > +  This function should be preferred, where feasible, over all the=20
> others.
> >=20
> > feasible? It should always be used.=20
>=20
> No, it cannot always be used. Please read again few lines above this that=
=20
> "The mapping can only be used in the context which acquired them". We=20
> cannot do blind s/kmap/kmap_local_page/.

I'm sorry it seems I slipped while reading and replying.
The kmap_atomic() part has "should be only used if it is absolutely
required" =E2=80=A6 " otherwise kmap_local_page()". The kmap_atomic() shoul=
d be
used in new code. The alternative kmap() and kmap_local*() should be
enough.

> > Maybe "thread local" instead CPU local? Another thread on the same CPU
> > can not use this mapping.
> >=20
>=20
> Hmm, I might add "thread local" to convey that the local mappings should=
=20
> stay in the same context that acquired them.=20
>=20
> However, kmap_local_page() also disable migration. This is how Thomas=20
> Gleixner talks about kmap_local_page() in his patch where it introduced=
=20
> this function:=20
>=20
> "The kmap_local.*() functions can be invoked from both preemptible and
> atomic context. kmap local sections disable migration to keep the resulti=
ng
> virtual mapping address correct, but disable neither pagefaults nor
> preemption.".
>=20
> Therefore, if it "disable migration" it is "CPU local". I mean that I mig=
ht=20
> also add "thread local" but I think (at least at this moment) that I won'=
t=20
> remove "CPU local".

Hmm. It is thread-local in the end. There are slots 0 =E2=80=A6 KM_MAX_IDX =
for
the mappings. Slot 0 for task A can be different from slot 0 for task B
while both run on CPU0. So the same address, that is returned from
kmap_local(), will point to a different page for both tasks. Both tasks
can't be migrated to another CPU while the mapping is active.
"CPU local" sounds like something that is same to everyone on the same
CPU which is what this_cpu_read() for instance does.

> @Ira: what about this proposal?
>=20
> Thanks,
>=20
> Fabio

Sebastian
