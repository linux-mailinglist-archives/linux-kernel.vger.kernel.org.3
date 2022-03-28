Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2EE694EA164
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Mar 2022 22:22:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344458AbiC1UXX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Mar 2022 16:23:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241225AbiC1UXT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Mar 2022 16:23:19 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1E8796661F
        for <linux-kernel@vger.kernel.org>; Mon, 28 Mar 2022 13:21:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1648498897;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=3p40tNFk+gHnhhZuqFavI/fEyZfK9XcFxgpC8+00PDQ=;
        b=Y4auQ0hn1yFrGRjlqtgBhF8t4ymheWBy8wt0cEUNIdPtF76Lb+m9rIzW/uqKyfiWsPWm8L
        sPAXxT06tMJQFMZUA/qws8p+W6Gw+USjg2iJ2I4N7YaeZUl3NeZtRfoiC+qd1HgXUbam6h
        WOdsOwLteN6uj42F63dDGzbWUlxE3n0=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-292-vGSgA54GN4W0sIsGlhcIDQ-1; Mon, 28 Mar 2022 16:21:35 -0400
X-MC-Unique: vGSgA54GN4W0sIsGlhcIDQ-1
Received: by mail-qv1-f70.google.com with SMTP id g1-20020ad446c1000000b00440c9327221so12188512qvw.6
        for <linux-kernel@vger.kernel.org>; Mon, 28 Mar 2022 13:21:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=3p40tNFk+gHnhhZuqFavI/fEyZfK9XcFxgpC8+00PDQ=;
        b=vjQKUKkMPcDHBU986aj83z6ZNf+j4CPcGjqfLLPZMYnsmdnp372EJpBFJztcMVpfkY
         qqJ3ytojcIMkvUi1xDxPF2SUuAnDikgK9iA81Za6a/0NgBtwT+OzNg1+Nh79jf9mQWHk
         m2T1ATpl2qepUT4AZ7aTN3x5hvcyL1mp5uTNmqTcSe71KlhtecIqKtYdkLh3g7/6UJBz
         psTWd1Cz0M+9NLG40MGAIqTQlINQjnuK1aXZveMbKhasTLlupNETsl/73o3i8spNwMoS
         I/YMlCZ5e2anq9yoM+nxwoGz89k0rwghD5uC0iuNIsvI6RVpRR2bGhhpgqXKNl0YGIfO
         QfoA==
X-Gm-Message-State: AOAM532MmUSPNyG9uKildtpGOuPAEuUoVllr/nO/ELCwcK7RePTJ5lsg
        pyKPs7BwnH61JdUytEY15yZ+tZ2H0Vc8ZDcgFqooRXOnerTud8TxhAa3GohWpoipi5fECp259+y
        u4O5vfXrddVgn75LgrkN7GyTH
X-Received: by 2002:a05:6214:29c7:b0:441:3f11:9315 with SMTP id gh7-20020a05621429c700b004413f119315mr22667899qvb.87.1648498895152;
        Mon, 28 Mar 2022 13:21:35 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwNM++ZxHApL6PNdttJ/yUMPNMmzlV+WiT8X4Xf2ogElGi09uECpKMGDIcr2ELe1JrOd+5kdg==
X-Received: by 2002:a05:6214:29c7:b0:441:3f11:9315 with SMTP id gh7-20020a05621429c700b004413f119315mr22667879qvb.87.1648498894940;
        Mon, 28 Mar 2022 13:21:34 -0700 (PDT)
Received: from treble ([2600:1700:6e32:6c00::35])
        by smtp.gmail.com with ESMTPSA id g9-20020a05620a108900b0067b13036bd5sm8275335qkk.52.2022.03.28.13.21.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Mar 2022 13:21:34 -0700 (PDT)
Date:   Mon, 28 Mar 2022 13:21:31 -0700
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        "aik@ozlabs.ru" <aik@ozlabs.ru>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "rostedt@goodmis.org" <rostedt@goodmis.org>,
        "naveen.n.rao@linux.vnet.ibm.com" <naveen.n.rao@linux.vnet.ibm.com>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        Sathvika Vasireddy <sv@linux.ibm.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, ardb@kernel.org
Subject: Re: [RFC PATCH 3/3] objtool/mcount: Add powerpc specific functions
Message-ID: <20220328202131.jis7swqswm7chn6k@treble>
References: <20220318105140.43914-1-sv@linux.ibm.com>
 <20220318105140.43914-4-sv@linux.ibm.com>
 <YjR6kHq4c/rjCTpr@hirez.programming.kicks-ass.net>
 <0b55f122-4760-c1ba-840a-0911cefec2ad@csgroup.eu>
 <20220328195920.dqlfra3lcardko6r@treble>
 <YkIXLnAxtPuSDcOW@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YkIXLnAxtPuSDcOW@hirez.programming.kicks-ass.net>
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 28, 2022 at 10:14:38PM +0200, Peter Zijlstra wrote:
> > FWIW, there have been some objtool patches for arm64 stack validation,
> > but the arm64 maintainers have been hesitant to get on board with
> > objtool, as it brings a certain maintenance burden.  Especially for the
> > full stack validation and ORC unwinder.  But if you only want inline
> > static calls and/or mcount then it'd probably be much easier to
> > maintain.
> 
> IIRC the major stumbling block for arm64 is the whole jump-table thing.
> Either they need to rely on compiler plugins to provide objtool that
> data (yuck, since we support at least 2 different compilers), disable
> jump-tables (yuck, for that limits code-gen just to please a tool) or
> use DWARF (yuck, because build times).

Well yeah, that was indeed the main technical issue but I seem to
remember some arm64 maintainers not really being sold on the value of
objtool regardless.

> There was a little talk about an impromptu 'abi' to communicate
> jump-table details to objtool without going full on DWARF, but that
> seems to have hit a dead end again.

Probably my fault, not enough hours in the day...

-- 
Josh

