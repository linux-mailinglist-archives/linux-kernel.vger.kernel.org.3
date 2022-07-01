Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4F84563440
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Jul 2022 15:19:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230194AbiGANTj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Jul 2022 09:19:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229555AbiGANTi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jul 2022 09:19:38 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09EEB5C9CE
        for <linux-kernel@vger.kernel.org>; Fri,  1 Jul 2022 06:19:38 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id B11C01FED2;
        Fri,  1 Jul 2022 13:19:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1656681576; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=xFgoHlyRa7LHDHxJ/dQcYb8z363BN8ijGLLytPfITt4=;
        b=qlUZohiu44BSWswbAw5H6MLyMuGchSMRiwXroekPENBEzT1W1745fSk07Kgg+BoK7DIOEH
        gyrTJuxqaZVllCRs0XWu7Ppewzgjsx0YiO+Xd6dkKt2dUjz9m0K3J8VnjKGv79GEJxnNP+
        A2YQ8WrpHsKMGRK4zAHmwOqqCWW+NJQ=
Received: from suse.cz (unknown [10.100.201.86])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id C4E3B2C141;
        Fri,  1 Jul 2022 13:19:35 +0000 (UTC)
Date:   Fri, 1 Jul 2022 15:19:35 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     cgel.zte@gmail.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, vbabka@suse.cz, minchan@kernel.org,
        oleksandr@redhat.com, xu xin <xu.xin16@zte.com.cn>,
        Jann Horn <jannh@google.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH linux-next] mm/madvise: allow KSM hints for
 process_madvise
Message-ID: <Yr70ZwUAIHNz5VNy@dhcp22.suse.cz>
References: <20220701084323.1261361-1-xu.xin16@zte.com.cn>
 <Yr66Uhcv+XAPYPwj@dhcp22.suse.cz>
 <93e1e19a-deff-2dad-0b3c-ef411309ec58@redhat.com>
 <c9de1c34-2a39-e4a2-c9b0-9790c5ffab13@redhat.com>
 <Yr7h/E/6A+tsjU9r@dhcp22.suse.cz>
 <203548a6-cf70-30ce-6756-f6c909e7ef21@redhat.com>
 <Yr7qQsWQGb0dhkxr@dhcp22.suse.cz>
 <54b67d6b-f600-1b9b-3d3f-e91b13d04c91@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <54b67d6b-f600-1b9b-3d3f-e91b13d04c91@redhat.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 01-07-22 14:39:24, David Hildenbrand wrote:
> > I am not sure about exact details of the KSM implementation but if that
> > is not a desirable behavior then it should be handled on the KSM level.
> > The very sam thing can easily happen in a multithreaded (or in general
> > multi-process with shared mm) environment as well.
> 
> I don't quite get what you mean.

I meant to say that if KSM needs to be aware of a special CoW semantic
then it should be handled on the KSM layer regardless whether the KSM
has been set by the process itself or any other process that has acccess
to the MM. process_madvise is just another way to access a remote MM
other than sharing the full MM.
 
[...]
> > Are you saying that any remote handling of the KSM has to deal with a
> > pre-existing semantic as well? Are we aware of any existing application
> > that really uses MADV_UNMERGEABLE in a hope to disable KSM for any of
> > its sensitive memory ranges? My understanding is that this is simply a
> > on/off knob and a remote way to do the same is in line with the existing
> > API.
> 
> "its sensitive memory ranges" that's exactly what I am concerned of.
> There should be a toggle, and existing applciations will not be using it.

The thing is that most applications (are there any?) do not actively
say that something is not KSM safe, right? They expect they opt in where
it makes sense. So my question is, whether any remote way to opt in for
KSM has to redefine the existing semantic or the same should be achieved
by a sufficient privileges?

The former would have really hard times to be applicable to the very
likely first hand usecase - unmodifiable binaries...

> > To be completely honest I do not really buy an argument that this might
> > break something much more than the original application can do already.
> 
> How can you get a shared zeropage in a private mapping after a previous
> write if not via KSM?

I was not referring to KSM specifically here. My recollection is that
PTRACE_MODE_READ_FSCREDS is quite powerful already.
-- 
Michal Hocko
SUSE Labs
