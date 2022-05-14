Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A449552700D
	for <lists+linux-kernel@lfdr.de>; Sat, 14 May 2022 10:37:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230207AbiENIhf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 May 2022 04:37:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229733AbiENIhd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 May 2022 04:37:33 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D18F21EE
        for <linux-kernel@vger.kernel.org>; Sat, 14 May 2022 01:37:27 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1652517446;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=3gT7kvFRN/C45ruQBTGaFvxVwWlGbId47OUjeiXRcTM=;
        b=Apdt16C17m0cIokAHKk4o2PXGYmSa5bG8UGDgg9e5ZelgxTo5fwgdUSzWuBa6q9NAmr5gj
        TUhg/kOzc624Gfy91z5tNip3dZuFfBTknJW/ONihJOayv3pxBALZnQzP2BISY/k8ZWIXcV
        rmo55JL5dQyiZNnMh3S/idR0R1WOnZHnbQK8TmEql5jA9aU9dBAtajYX8vjjo7nvkl7KBP
        oLIaMZesyk6jN0sPeaeiRP9lpRfuxxjT8mPzYZSgtu5bgDRyGl0b+4Hmx13WJnxnFLxvI4
        FOZv/qkLzPsAlRQGjfwLkwSGROZkoJ4asoAhwvW2HzrWd/x1vq/HPpSmR0PCMw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1652517446;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=3gT7kvFRN/C45ruQBTGaFvxVwWlGbId47OUjeiXRcTM=;
        b=1GtN2iV9LZWcMhkCxXjgcde7PntaqmRfol14sgZP7miE6WluolGTRDMTex4IeDVOK0LUuC
        6KQg7nvF3l8e4RAQ==
To:     "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>,
        "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "hjl.tools@gmail.com" <hjl.tools@gmail.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "aryabinin@virtuozzo.com" <aryabinin@virtuozzo.com>,
        "dvyukov@google.com" <dvyukov@google.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "ak@linux.intel.com" <ak@linux.intel.com>,
        "Lutomirski, Andy" <luto@kernel.org>,
        "glider@google.com" <glider@google.com>
Subject: Re: [RFCv2 03/10] x86: Introduce userspace API to handle per-thread
 features
In-Reply-To: <543eb3ff98f624c6cfa1d450ac3e9ae8934c7c38.camel@intel.com>
References: <20220511022751.65540-1-kirill.shutemov@linux.intel.com>
 <20220511022751.65540-5-kirill.shutemov@linux.intel.com>
 <CAG_fn=V8k3hiviv3htV6wWZ6fUBri=MORfXGJ+Kz7GdRDZvesA@mail.gmail.com>
 <da0f438bb459050e5a586a17382e961259449761.camel@intel.com>
 <20220513230958.dbxp6m3y3lnq74qb@black.fi.intel.com>
 <543eb3ff98f624c6cfa1d450ac3e9ae8934c7c38.camel@intel.com>
Date:   Sat, 14 May 2022 10:37:25 +0200
Message-ID: <87k0aose62.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 13 2022 at 23:50, Edgecombe, Rick P wrote:
> On Sat, 2022-05-14 at 02:09 +0300, Kirill A. Shutemov wrote:
>> On Fri, May 13, 2022 at 05:34:12PM +0000, Edgecombe, Rick P wrote:
>> > On Fri, 2022-05-13 at 16:09 +0200, Alexander Potapenko wrote:
>> > > > +
>> > > > +       /* Handle ARCH_THREAD_FEATURE_ENABLE */
>> > > > +
>> > > > +       task->thread.features |= features;
>> > > > +out:
>> > > > +       return task->thread.features;
>> > > 
>> > > Isn't arch_prctl() supposed to return 0 on success?
>> > 
>> > Hmm, good point. Maybe we'll need a struct to pass info in and out.
>> 
>> But values >0 are unused. I don't see why can't we use them.
>
> Hmm, I don't know what it would break since it is a new "code"
> argument. But the man page says:
> "On success, arch_prctl() returns 0; on error, -1 is returned, and
> errno is set to indicate the error."
>
> So just change the man pages?
> "On success, arch_prctl() returns positive values; on error, -1 is
> returned, and errno is set to indicate the error."

Why?

        prctl(GET, &out)

is the pattern used all over the place.

Thanks,

        tglx
