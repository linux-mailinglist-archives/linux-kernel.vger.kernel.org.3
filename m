Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FA404EB9A6
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Mar 2022 06:27:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242541AbiC3E2s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Mar 2022 00:28:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232366AbiC3E2n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Mar 2022 00:28:43 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5F748DF58
        for <linux-kernel@vger.kernel.org>; Tue, 29 Mar 2022 21:26:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1648614416;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nKA9pWHMxnbapsXj7AFZXsdri/J+aqlfWUZEkrFaXOs=;
        b=iGJDsWQ/xobzWIE0YWfo60CRuBoGTpKYLMumoqW5OW4K95DNTaO/hvgY7rud2LScJ2Qcxi
        QQwlIJOFy+FaPMs0nM5H0taFjHUVyHsaqeBM4D5ot2+jxHFcMg2yhwdKuKLP3HI3/s9wnC
        SY6HCkDBwsKDcyJLgV4J+A/n81StKW0=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-351-_GHxSGqaMuqgXZd0IZLNYg-1; Wed, 30 Mar 2022 00:26:54 -0400
X-MC-Unique: _GHxSGqaMuqgXZd0IZLNYg-1
Received: by mail-qt1-f200.google.com with SMTP id h11-20020a05622a170b00b002e0769b9018so16485650qtk.14
        for <linux-kernel@vger.kernel.org>; Tue, 29 Mar 2022 21:26:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=nKA9pWHMxnbapsXj7AFZXsdri/J+aqlfWUZEkrFaXOs=;
        b=S3FmJ8Z3MCkhpQWCBQYQLX03oUgYsJHkuwajNps5hdH+rC3QEz783IkshYGDM3OuBH
         b53/h56cUOa1CGRMlZ19NewZmoA9YsLznzFT7sqNFWF5ADAWELgXyanpbE7hDYXu81cH
         BOTId3N1bL/5nlmP+KlH88FLtt5K9p1xYkN9rMqJ1PLxuEEbR7YTck3TkT/MwQpa9K15
         nis+5vadKyRmMAzo44nhaIYjlUx2k2GkWC2f3v1aZWFCvv5vU76lPPa7HDt24u+kgnA5
         mm3XS0ei00osjjgT7LNIStc8Li4zt6DA4Ixh7Nmay9mvW3gIe0mj7SycNl9JM5N5N7R+
         ztLA==
X-Gm-Message-State: AOAM530MmALFpy6IOk41hEu+0TLxgNacKuvN71Y2auZP1mSnRDmj28is
        XepCZ758GJzYokR5DtBTOGxoU+6dFjfXsI7E9LwpBf5ePaHIHBLbvfwICudZFnQ5YNy2hESsr5Z
        R1sUYp7NlT11Y++vuEKnF7UDb
X-Received: by 2002:a05:6214:230a:b0:435:4f89:3c0e with SMTP id gc10-20020a056214230a00b004354f893c0emr29007847qvb.92.1648614414344;
        Tue, 29 Mar 2022 21:26:54 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwDTTnL5kXiRn6YJo7R0KGe6AX6xPcJu4FBJYFEXOnIiaFh60A0fM3hMylzfAQAXg6eHu8dUQ==
X-Received: by 2002:a05:6214:230a:b0:435:4f89:3c0e with SMTP id gc10-20020a056214230a00b004354f893c0emr29007830qvb.92.1648614413978;
        Tue, 29 Mar 2022 21:26:53 -0700 (PDT)
Received: from treble ([2600:1700:6e32:6c00::15])
        by smtp.gmail.com with ESMTPSA id p13-20020a05622a048d00b002e1ce0c627csm17321177qtx.58.2022.03.29.21.26.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Mar 2022 21:26:53 -0700 (PDT)
Date:   Tue, 29 Mar 2022 21:26:49 -0700
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     Michael Ellerman <mpe@ellerman.id.au>,
        Peter Zijlstra <peterz@infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "rostedt@goodmis.org" <rostedt@goodmis.org>,
        "aik@ozlabs.ru" <aik@ozlabs.ru>,
        Sathvika Vasireddy <sv@linux.ibm.com>,
        "naveen.n.rao@linux.vnet.ibm.com" <naveen.n.rao@linux.vnet.ibm.com>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
Subject: Re: [RFC PATCH 3/3] objtool/mcount: Add powerpc specific functions
Message-ID: <20220330042649.fj43vxtpxmyxtbnd@treble>
References: <20220318105140.43914-1-sv@linux.ibm.com>
 <20220318105140.43914-4-sv@linux.ibm.com>
 <YjR6kHq4c/rjCTpr@hirez.programming.kicks-ass.net>
 <0b55f122-4760-c1ba-840a-0911cefec2ad@csgroup.eu>
 <20220328195920.dqlfra3lcardko6r@treble>
 <87mth9ezml.fsf@mpe.ellerman.id.au>
 <af262c28-0d73-7ae6-3dd5-2977c9a41f7d@csgroup.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <af262c28-0d73-7ae6-3dd5-2977c9a41f7d@csgroup.eu>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 29, 2022 at 05:32:18PM +0000, Christophe Leroy wrote:
> 
> 
> Le 29/03/2022 à 14:01, Michael Ellerman a écrit :
> > Josh Poimboeuf <jpoimboe@redhat.com> writes:
> >> On Sun, Mar 27, 2022 at 09:09:20AM +0000, Christophe Leroy wrote:
> >>> Second point is the endianess and 32/64 selection, especially when
> >>> crossbuilding. There is already some stuff regarding endianess based on
> >>> bswap_if_needed() but that's based on constant selection at build time
> >>> and I couldn't find an easy way to set it conditionaly based on the
> >>> target being built.
> >>>
> >>> Regarding 32/64 selection, there is almost nothing, it's based on using
> >>> type 'long' which means that at the time being the target and the build
> >>> platform must both be 32 bits or 64 bits.
> >>>
> >>> For both cases (endianess and 32/64) I think the solution should
> >>> probably be to start with the fileformat of the object file being
> >>> reworked by objtool.
> >>
> >> Do we really need to detect the endianness/bitness at runtime?  Objtool
> >> is built with the kernel, why not just build-in the same target
> >> assumptions as the kernel itself?
> > 
> > I don't think we need runtime detection. But it will need to support
> > basically most combinations of objtool running as 32-bit/64-bit LE/BE
> > while the kernel it's analysing is 32-bit/64-bit LE/BE.
> 
> Exactly, the way it is done today with a constant in 
> objtool/endianness.h is too simple, we need to be able to select it 
> based on kernel's config. Is there a way to get the CONFIG_ macros from 
> the kernel ? If yes then we could use CONFIG_64BIT and 
> CONFIG_CPU_LITTLE_ENDIAN to select the correct options in objtool.

As of now, there's no good way to get CONFIG options from the kernel.
That's pretty much by design, since objtool is meant to be a standalone
tool.  In fact there are people who've used objtool for other projects.

The objtool Makefile does at least have access to HOSTARCH/SRCARCH, but
I guess that doesn't help here.  We could maybe export the endian/bit
details in env variables to the objtool build somehow.

But, I managed to forget that objtool can already be cross-compiled for
a x86-64 target, from a 32-bit x86 LE host or a 64-bit powerpc BE host.
There are some people out there doing x86 kernel builds on such systems
who reported bugs, which were since fixed.  And the fixes were pretty
trivial, IIRC.

Libelf actually does a decent job of abstracting those details from
objtool.  So, forget what I said, it might be ok to just detect
endian/bit (and possibly even arch) at runtime like you originally
suggested.

For example bswap_if_needed() could be reworked to be a runtime check.

-- 
Josh

