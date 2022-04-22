Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CFEF50B437
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 11:37:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1446099AbiDVJj3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 05:39:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357468AbiDVJjZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 05:39:25 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37FB653737;
        Fri, 22 Apr 2022 02:36:33 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id bv19so15237184ejb.6;
        Fri, 22 Apr 2022 02:36:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jO/vxDbeCOIwMZpGyPBrJ93fKruvAZdChVh9tS+X+e8=;
        b=gAg4QfVMOQzg3Wo9SO5pjrLDbi8o6PVWL9VrsfN3oRTrmLA014Mjh/LdgUMNSjRSyB
         MDfMYemTjD74cjmMrubbhLrQwsTUmlkYmBeaLIIz/jK6WuGlxIUvJirJh7gR6Hb6LrKZ
         Jz9nRB28sBCSz7tDUJKEMO4E/w0MkFQoH5B9RlEGOhYi/PR8bAfOPduknHPaguvz32iw
         rrZSwMiUJQOXc9CBwfVcttyi4QKqEGZUG324pKKnfeIsrmJZF+Vn2hnNwEhzICCLFKR+
         jrv7Bh/UGwSumlQ5M272FIzlT+USYC8GPXPfoTItHzUa1FZY+X8Dg3PAp8nYLxsYpSlW
         NX8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jO/vxDbeCOIwMZpGyPBrJ93fKruvAZdChVh9tS+X+e8=;
        b=muHtWZ7tq+zpJRyc94RoyyPh2vMktxXBSc352jUvwGBGTEFSaMdpN0bNaFeac8r8Ji
         mCxP6pj3PpyWx8/Oyhjd0uyiJyDhUXyyZlxyhbFnMd6ovtvcA7Jlmtj53Op3lxbaywx9
         jH1GcDA2XOhP9iy+A1mOAAjsQK5UJ0mz6VWBA6OSqZS5g3EH4pnScMJK2kCCaGrN8ZbS
         OxwhFnw9dKW8urJvX0xTXaSrvnsqY3y+bsSCfE0MECzGp00G71z5+uWoNhxeqkM95ek6
         D8SIx5lEeGBsvH9DXBFRYSisAYqebyQRSbsVEMBdIKVIKTnz6pe9SUYzNh92NZaBHoQf
         6TfQ==
X-Gm-Message-State: AOAM533I0+5VIRxt/LliA3pw+vDRQ0i4QVLuCeBCZPGzzIAVSa0JoxGt
        TBPYh/p3Ml3jvWEnAf2/x/g=
X-Google-Smtp-Source: ABdhPJxClEYIuim6d5CYgBJxMfNobumHE1XRkHMdvQqHDjpZ2pZa9HvT6M336UjanJpLS0f2QQCxWQ==
X-Received: by 2002:a17:906:9b89:b0:6da:ac6b:e785 with SMTP id dd9-20020a1709069b8900b006daac6be785mr3354360ejc.295.1650620191608;
        Fri, 22 Apr 2022 02:36:31 -0700 (PDT)
Received: from leap.localnet (host-79-50-86-254.retail.telecomitalia.it. [79.50.86.254])
        by smtp.gmail.com with ESMTPSA id n25-20020a1709062bd900b006e8766b7907sm562323ejg.223.2022.04.22.02.36.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Apr 2022 02:36:30 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Mike Rapoport <rppt@kernel.org>
Cc:     Ira Weiny <ira.weiny@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Will Deacon <will@kernel.org>,
        Peter Collingbourne <pcc@google.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        linux-doc@vger.kernel.org, outreachy@lists.linux.dev,
        Mike Rapoport <rppt@linux.ibm.com>
Subject: Re: [PATCH 1/4] mm/highmem: Fix kernel-doc warnings in highmem*.h
Date:   Fri, 22 Apr 2022 11:36:28 +0200
Message-ID: <1819415.CQOukoFCf9@leap>
In-Reply-To: <YmJmLrS3hPR6gOaw@kernel.org>
References: <20220421180200.16901-1-fmdefrancesco@gmail.com> <20220421180200.16901-2-fmdefrancesco@gmail.com> <YmJmLrS3hPR6gOaw@kernel.org>
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

On venerd=C3=AC 22 aprile 2022 10:24:14 CEST Mike Rapoport wrote:
> On Thu, Apr 21, 2022 at 08:01:57PM +0200, Fabio M. De Francesco wrote:
> > `scripts/kernel-doc -v -none include/linux/highmem*` reports the=20
following
> > warnings:
> >=20
> > include/linux/highmem.h:160: warning: expecting prototype for=20
kunmap_atomic(). Prototype was for nr_free_highpages() instead
> > include/linux/highmem.h:204: warning: No description found for return=20
value of 'alloc_zeroed_user_highpage_movable'
> > include/linux/highmem-internal.h:256: warning: Function parameter or=20
member '__addr' not described in 'kunmap_atomic'
> > include/linux/highmem-internal.h:256: warning: Excess function=20
parameter 'addr' description in 'kunmap_atomic'
> >=20
> > Fix these warnings by (1) moving the kernel-doc comments from highmem.h=
=20
to
> > highmem-internal.h (which is the file were the kunmap_atomic() macro is
> > actually defined), (2) extending and merging it with the comment which=
=20
was
> > already in highmem-internal.h, and (3) using correct parameter names.
> >=20
> > Cc: Mike Rapoport <rppt@linux.ibm.com>
> > Cc: Ira Weiny <ira.weiny@intel.com>
> > Suggested-by: Matthew Wilcox <willy@infradead.org>
> > Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
> > ---
> >  include/linux/highmem-internal.h | 14 +++++++++++---
> >  include/linux/highmem.h          | 15 +++------------
> >  2 files changed, 14 insertions(+), 15 deletions(-)
> >
> > [...]
> >
> > + *
> > + * Unmap an address previously mapped by kmap_atomic() and re-enables
>=20
> Unmap ... and re-enable
>=20
> or=20
>=20
> Unmaps ... and re-enables

Sorry, I should have read it twice before submitting :(

This entire series has already been taken by Andrew Morton for "-mm"=20
immediately after submission. I think that probably the better suited=20
solution is to send a correction when they show upstream.=20

Do you agree with me or you prefer that I resubmit the whole series as a v2=
=20
now?

>=20
> Other than that
>=20
> Acked-by: Mike Rapoport <rppt@linux.ibm.com>
>=20

I also saw your "Acked-by" tag in patch 2/4. Thanks!

Regards,

=46abio


