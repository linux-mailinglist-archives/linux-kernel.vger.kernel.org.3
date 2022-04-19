Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCA4D506D71
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 15:28:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243747AbiDSN2o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 09:28:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243934AbiDSN2D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 09:28:03 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5728F21E19
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 06:25:20 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id t25so21250497edt.9
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 06:25:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=NYGYZ+AaeH1UkoR29hN0ONV45IHPGeVO496rVaCsOeg=;
        b=ZcP63KQbJe/fq2lztFobt+4aFZJsU7bmacoc7UrvUOEBPRCGkn8K2Uwgz1TudU1vVm
         m/AG5apYjCzvfnZjgqvfy3ERIKR46quwZkbQs6eqYdyzvjhjwgawy2pmk6QIFggBSFoT
         oOKSlIa+QZB5Z7Bi0bVwZYyRH3vmhvpt/+PYNbftMzYV9afjOcEAj3kVfmrGObuF8erl
         S1u/FdJMXedCwFu88jEuVQme82CXHn/xWoapZfPCRfd5muPPBWXap3gonUSvM6oHhfj4
         XeFBi/ldwlcGrKX5nmEVdrRi5ehZTc/DFaN3NTDOXvRCXPer+X26HBfyvbV7Q2q5oNP3
         6/CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NYGYZ+AaeH1UkoR29hN0ONV45IHPGeVO496rVaCsOeg=;
        b=vlbTXdifRr5Mq+cepOxK4nOR0M5/JtqJkxxYYLaiPN8dTsseGJlp6y3afissitTMdR
         6peGwYOMLpDLKD11BNSo9mU3mTVav1VObVJUxuQOL4crdZRqJu6Zjoy+3Nee+PwffIE9
         gVMv6RnDQZ56sggNhypkZgOhdUZY+L7+2IjGs2uqsVErqTcmVBJRaUQXUozkvNXDkwIr
         rQf+gPfN5vT1RgW5zU0QhpgCVVK5SjPb10X9PI01nPDwW8EbcEaTlFFGTtbvqGOeS6Wy
         r3pbFStg3E/c2jCJ9ZiGoo+f1KVOxrTBtaUivpf0hkQnW5EIaiuJ7SoqzM3bnco+nbwH
         13sw==
X-Gm-Message-State: AOAM533a9bKUFD596CaB4wArO8NJbkV5GS0ExrbUN3LabxBczDnlUaw+
        bzsFohenD+aMNgvR+ruvZTU=
X-Google-Smtp-Source: ABdhPJyXcDMv8ru2Wi8pUK5GB8l76sJTEXGV6d+L1yqBCA/Bh8rnWTOm2dfGw8CclmZl5FbXqKjm4g==
X-Received: by 2002:a05:6402:2318:b0:413:7645:fa51 with SMTP id l24-20020a056402231800b004137645fa51mr17623149eda.201.1650374718896;
        Tue, 19 Apr 2022 06:25:18 -0700 (PDT)
Received: from leap.localnet (host-79-50-86-254.retail.telecomitalia.it. [79.50.86.254])
        by smtp.gmail.com with ESMTPSA id fx3-20020a170906b74300b006daecedee44sm5661666ejb.220.2022.04.19.06.25.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Apr 2022 06:25:17 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Ira Weiny <ira.weiny@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Peter Collingbourne <pcc@google.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Mike Rapoport <rppt@linux.ibm.com>,
        linux-kernel@vger.kernel.org, outreachy@lists.linux.dev
Subject: Re: [PATCH v2] mm/highmem: Fix kernel-doc warnings in highmem*.h
Date:   Tue, 19 Apr 2022 15:25:16 +0200
Message-ID: <4058661.1IzOArtZ34@leap>
In-Reply-To: <Yl6unkluUEeRZBbB@casper.infradead.org>
References: <20220418175638.30018-1-fmdefrancesco@gmail.com> <Yl6unkluUEeRZBbB@casper.infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On marted=C3=AC 19 aprile 2022 14:44:14 CEST Matthew Wilcox wrote:
> On Mon, Apr 18, 2022 at 07:56:38PM +0200, Fabio M. De Francesco wrote:
> > +/**
> > + * kunmap_atomic - Unmap the virtual address mapped by kmap_atomic()
> > + * @__addr:       Virtual address to be unmapped
> > + *
> > + * Counterpart to kmap_atomic().
>=20
> I don't think this is a terribly useful paragraph?

I agree but let me remind you that this patch is _only_ about fixing=20
kernel-doc warnings. This warning was simply fixed by moving kdoc comment=20
from highmem.h to highmem-internal.h (which is the file where the=20
definition of kunmap_atomic() resides) and merging the text with few lines=
=20
that already were in highmem-internal.h.

=46urthermore, I've already had an "Acked-by:" tag from Mike Rapoport. I=20
suppose that if I changed the paragraph here I could not forward his ack to=
=20
the next version.

> > + * Effectively a wrapper around kunmap_local() which additionally=20
undoes
> > + * the side effects of kmap_atomic(), i.e. reenabling pagefaults and
> > + * preemption. Prevent people trying to call kunmap_atomic() as if it
> > + * were kunmap() because kunmap_atomic() should get the return value=20
of
> > + * kmap_atomic(), not its argument which is a pointer to struct page.
>=20
> I'd rather this were useful advice to the caller than documentation of
> how it works.  How about:
>=20
>  * Unmap an address previously mapped by kmap_atomic().  Mappings
>  * should be unmapped in the reverse order that they were mapped.
>  * See kmap_local_page() for details.  @__addr can be any address within
>  * the mapped page, so there is no need to subtract any offset that has
>  * been added.  In contrast to kunmap(), this function takes the address
>  * returned from kmap_atomic(), not the page passed to kmap_atomic().
>  * The compiler will warn you if you pass the page.

A change like this should go to a separate patch and indeed I'll send it=20
ASAP. Probably, when I'll rework this text in a separate patch, I'll also=20
copy-paste the paragraph you wrote as-is (too easy!).

However, since the rework of the text in paragraph can only be applied on=20
top of this patch, I'm not sure if I should either (1) make a series with=20
two patches or (2) make a separate patch with a warning to Maintainers that=
=20
the changes in the new patch can only be applied on top of this patch.

Actually, I don't yet know how the Community wants tasks like these to be=20
carried out. Any suggestion?

Thanks for your review and for suggesting a better suited text for the next=
=20
patch.

=46abio M. De Francesco


