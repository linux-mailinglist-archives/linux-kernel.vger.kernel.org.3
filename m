Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3D505696C3
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jul 2022 02:14:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234149AbiGGAOm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jul 2022 20:14:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230090AbiGGAOl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 20:14:41 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E45272CE20
        for <linux-kernel@vger.kernel.org>; Wed,  6 Jul 2022 17:14:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8637861FC8
        for <linux-kernel@vger.kernel.org>; Thu,  7 Jul 2022 00:14:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A08C4C3411C
        for <linux-kernel@vger.kernel.org>; Thu,  7 Jul 2022 00:14:39 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="RBy/eCE6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1657152876;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=uqmSVwHKl31/lFPqApMos8prPIN0Q1DfKDKVwwfPmPk=;
        b=RBy/eCE6FFsVWvfjjcPXsJ1BTlDjB3PU7H1fvET8xZR5XIOhGQyQSfU+2qNvwNv1zwvgcj
        hGX3PW7m4FMPDKdRLBea+E0X5RzNtuQJn/SDtUnP/cKKbjegNnf028UwhdHNwVVIQhvwCR
        4Qs9ylWNctxDThHtFnsenQJ8qE0/EWw=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 3dbdfd84 (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO)
        for <linux-kernel@vger.kernel.org>;
        Thu, 7 Jul 2022 00:14:35 +0000 (UTC)
Received: by mail-il1-f178.google.com with SMTP id p13so10161108ilq.0
        for <linux-kernel@vger.kernel.org>; Wed, 06 Jul 2022 17:14:34 -0700 (PDT)
X-Gm-Message-State: AJIora81CzTuXe5Fng9NlQ5yhVkopKZKYxXIxP47wiS37VRV1YJKAAa1
        b4hdoO2uC2MMRxOhQ/aImZf8mXMRvIUs92d3o0E=
X-Google-Smtp-Source: AGRyM1sUjQNJFmAtJpPy/Rz1X3alkBZUZJdKOyJtoUolrHu3bMjjXkSF4R0w7vfhziXPRVBsdhUx1iYc+h3jDTkJuzU=
X-Received: by 2002:a92:c26e:0:b0:2da:be5e:69d9 with SMTP id
 h14-20020a92c26e000000b002dabe5e69d9mr25059337ild.42.1657152873786; Wed, 06
 Jul 2022 17:14:33 -0700 (PDT)
MIME-Version: 1.0
References: <20220707000021.504308-1-Jason@zx2c4.com> <2603a1c4-ef5d-7719-b458-e70da180b878@infradead.org>
In-Reply-To: <2603a1c4-ef5d-7719-b458-e70da180b878@infradead.org>
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
Date:   Thu, 7 Jul 2022 02:14:23 +0200
X-Gmail-Original-Message-ID: <CAHmME9oeyPy5EEXU094xSEBDQ1xcqAgVbAihgS7_kEWCnw1kww@mail.gmail.com>
Message-ID: <CAHmME9oeyPy5EEXU094xSEBDQ1xcqAgVbAihgS7_kEWCnw1kww@mail.gmail.com>
Subject: Re: [PATCH] random: remove "nordrand" flag in favor of "random.trust_cpu"
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     LKML <linux-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>,
        "Theodore Ts'o" <tytso@mit.edu>, "H . Peter Anvin" <hpa@zytor.com>,
        Borislav Petkov <bp@suse.de>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Randy,

On Thu, Jul 7, 2022 at 2:12 AM Randy Dunlap <rdunlap@infradead.org> wrote:
> > However, x86 RDRAND does have a history of being occassionally
>
>                                                    occasionally
>
> > automatically disabling "nordrand" if we detect it's problematic.
> ?  I.e., disabling RDRAND and RDSEED.
> > -      * The nordrand option can clear X86_FEATURE_RDRAND, so check for
> > +      * The self test can clear X86_FEATURE_RDRAND, so check for
>
> Preferably:    self-test

Thanks. Fixing all of those.

Jason
