Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A5D5512F3C
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Apr 2022 11:02:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344524AbiD1JFa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Apr 2022 05:05:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230210AbiD1JF2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Apr 2022 05:05:28 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B476B5E760;
        Thu, 28 Apr 2022 02:02:14 -0700 (PDT)
Date:   Thu, 28 Apr 2022 11:02:10 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1651136532;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nj4PDORr37hCPcQ8/+P0dvD7HEbFV5wfOgr3H/Ce7qI=;
        b=a7A1T8XdWfmHscqJZvPDsuiFPxordnba0GoU6IPgxTszKIUo1tIyjV2tW1D/YB53bTphka
        EyaH+4b6DYCMJgMkmWdF3sGqZ8DNtPK1zE6eFvVajreZqyV5d1i8sTA3A/hLJ9oYTYYv8g
        /shcYpZKPEKHdCmqROSWAJquuR1b47ExK8SXTgMcL6QypazELHM9CBZaLV1C63LswnN/Fh
        MFJlJAnCxgiB2oPhgC1pQ+jsHHAKZhEdCYwpfipD5q1k4x9jnnuAWR8CibZ1ydtDIFmqCd
        oZYLP3jEfMnzVq6Pro38JYhZwg+ywPSLVoH6y1I5Foi/wcJPeQsGFxxKzzwjgQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1651136532;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nj4PDORr37hCPcQ8/+P0dvD7HEbFV5wfOgr3H/Ce7qI=;
        b=i3+W1bxrqBvRtYliqtDeQplIH/hcjqWnqVqz/OlPBc+Ipf+7rF/UzoseuOHFZcwZ4e+uH5
        SkVnFxZLoW0CB3Bg==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
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
Subject: Re: [PATCH v3 4/4] Documentation/vm: Rework "Temporary Virtual
 Mappings" section
Message-ID: <YmpYEkvbJX2JBPvW@linutronix.de>
References: <20220427183821.1979-1-fmdefrancesco@gmail.com>
 <20220427183821.1979-5-fmdefrancesco@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20220427183821.1979-5-fmdefrancesco@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-04-27 20:38:21 [+0200], Fabio M. De Francesco wrote:
> index e05bf5524174..c8aff448612b 100644
> --- a/Documentation/vm/highmem.rst
> +++ b/Documentation/vm/highmem.rst
> @@ -50,26 +50,78 @@ space when they use mm context tags.
=E2=80=A6
> =20
> -* kmap().  This permits a short duration mapping of a single page.  It n=
eeds
> -  global synchronization, but is amortized somewhat.  It is also prone to
> -  deadlocks when using in a nested fashion, and so it is not recommended=
 for
> -  new code.
> +  These mappings are thread-local and CPU-local (i.e., migration from on=
e CPU
> +  to another is disabled - this is why they are called "local"), but the=
y don't
> +  disable preemption.=20

So if you replace this block with

   These mappings are thread-local and CPU-local meaning that the mapping
   can only be accessed from within this thread and the thread is bound the
   CPU while the mapping is active. Even if the thread is preempted (since
   preemption is never disabled by the function) the CPU can not be
   unplugged from the system via CPU-hotplug until the mapping is disposed.

The you could drop the latter block

>                          It's valid to take pagefaults in a local kmap re=
gion,
> +  unless the context in which the local mapping is acquired does not all=
ow it
> +  for other reasons.

> +  kmap_local_page() always returns a valid virtual address and it is ass=
umed
> +  that kunmap_local() will never fail.

=66rom here

> +  If a task holding local kmaps is preempted, the maps are removed on co=
ntext
> +  switch and restored when the task comes back on the CPU. The maps are
> +  strictly thread-local and CPU-local, therefore it is guaranteed that t=
he
> +  task stays on the CPU and the CPU cannot be unplugged until the local =
kmaps
> +  are released.

to here since it mostly the same thing.

> +  Nesting kmap_local_page() and kmap_atomic() mappings is allowed to a c=
ertain
> +  extent (up to KMAP_TYPE_NR) but their invocations have to be strictly =
ordered
> +  because the map implementation is stack based. See kmap_local_page () =
kdocs

kmap_local_page () =3D> kmap_local_page()

> +  (included in the "Functions" section) for details on how to manage nes=
ted
> +  mappings.
> =20
>  * kmap_atomic().  This permits a very short duration mapping of a single
>    page.  Since the mapping is restricted to the CPU that issued it, it
>    performs well, but the issuing task is therefore required to stay on t=
hat
>    CPU until it has finished, lest some other task displace its mappings.
> =20
> -  kmap_atomic() may also be used by interrupt contexts, since it is does=
 not
> -  sleep and the caller may not sleep until after kunmap_atomic() is call=
ed.
> +  kmap_atomic() may also be used by interrupt contexts, since it does not
> +  sleep and the callers too may not sleep until after kunmap_atomic() is
> +  called.
> +
> +  Each call of kmap_atomic() in the kernel creates a non-preemptible sec=
tion
> +  and disable pagefaults. This could be a source of unwanted latency, so=
 it
> +  should be only used if it is absolutely required, otherwise kmap_local=
_page()
> +  should be used where it is feasible.

I'm not keen about the "absolutely required" wording and "feasible".
That said, the other pieces look good, thank you for the work.

> -  It may be assumed that k[un]map_atomic() won't fail.
> +  It is assumed that k[un]map_atomic() won't fail.

Sebastian
