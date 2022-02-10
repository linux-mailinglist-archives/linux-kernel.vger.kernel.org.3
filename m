Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D7714B19C2
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 00:47:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345873AbiBJXrM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Feb 2022 18:47:12 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:51138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345864AbiBJXrK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Feb 2022 18:47:10 -0500
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61A6B5F75
        for <linux-kernel@vger.kernel.org>; Thu, 10 Feb 2022 15:47:10 -0800 (PST)
Received: by mail-pf1-x42f.google.com with SMTP id x15so10715801pfr.5
        for <linux-kernel@vger.kernel.org>; Thu, 10 Feb 2022 15:47:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=mHRsq6Kn87GMOD21+jYbugw/48vB/ViEdc86yH1U1RM=;
        b=cE/HfRBcMAiI7aHiAvjjmt/SqsHa2f/rPVtV36FfX+RNibf+yKHCwYxGDTUtUIoQTN
         n+ZC03sN7lJOgFIjtcfdqZc2niTOFjCQnJAiJcOp6p/xKpuK41BgjFbGKDbl7AUWmPk0
         ur5mEAX2mLkDvRd+aBSDYM0PrWWRnuHFIpzh0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=mHRsq6Kn87GMOD21+jYbugw/48vB/ViEdc86yH1U1RM=;
        b=4IRoFo8jkrM8zAJFAqzUtcYwH8hhLk8vVvyCrN2OCBg7muYZUZ7aR91r+FCAvqLCT4
         /3z9i7jPxBrbQ4QQfU73jktZxdqlv3CB3YTlz6baYfBxHWcHY4zerNsLPPbAmYwIPLYM
         09O0FowbLIEbEKzvSaFIWBjEn6RIo/oMGXAWjf/54bTZ7nfdEz269GD7Yp4Bp90glZAH
         MuqPiPcVa1NhAs4jsKBjJIA611PahDcdXUP8OM3Gknl5ujQfp2mzVrfKixn3kd8Uhk47
         DTiL0/7qpZvoeoek3X0nu4gbrnJdwYNtCemDQY+czDcfQvpmsm09oySU8ZuMMWcSuqAy
         QmYw==
X-Gm-Message-State: AOAM533QCzagRIhqtRGmOYcl5ZRVT/1TSqVNSG6RidOYUzQV5kWquEw1
        NgP2iRvMBLEJWOZi+7Ou1ToLAw==
X-Google-Smtp-Source: ABdhPJyGc6kYqWRf+VlsVeyHDKoWC+0J4l3+nlcgViM0mwZ71ZFfynFkb2DC+466DdIh8ebqBFav6w==
X-Received: by 2002:a63:7019:: with SMTP id l25mr1843865pgc.251.1644536829788;
        Thu, 10 Feb 2022 15:47:09 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id 69sm17784092pgc.61.2022.02.10.15.47.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Feb 2022 15:47:09 -0800 (PST)
Date:   Thu, 10 Feb 2022 15:47:08 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     Victor Erminpour <victor.erminpour@oracle.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Hanjun Guo <guohanjun@huawei.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        trivial@kernel.org
Subject: Re: [PATCH v2] ACPI/IORT: Fix GCC 12 warning
Message-ID: <202202101415.43750CEE@keescook>
References: <1644518851-16847-1-git-send-email-victor.erminpour@oracle.com>
 <CAMj1kXEbGWs74M2CZSm6TWpD11mReFsk8z-UUqJt6b6vDCvAEQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMj1kXEbGWs74M2CZSm6TWpD11mReFsk8z-UUqJt6b6vDCvAEQ@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 10, 2022 at 08:41:51PM +0100, Ard Biesheuvel wrote:
> On Thu, 10 Feb 2022 at 19:48, Victor Erminpour
> <victor.erminpour@oracle.com> wrote:
> >
> > When building with automatic stack variable initialization, GCC 12
> > complains about variables defined outside of switch case statements.
> > Move the variable into the case that uses it, which silences the warning:
> >
> > ./drivers/acpi/arm64/iort.c:1670:59: error: statement will never be executed [-Werror=switch-unreachable]
> >   1670 |                         struct acpi_iort_named_component *ncomp;
> >        |                                                           ^~~~~
> >
> > Signed-off-by: Victor Erminpour <victor.erminpour@oracle.com>
> 
> Please cc people that commented on your v1 when you send a v2.
> 
> Still NAK, for the same reasons.

Let me see if I can talk you out of this. ;)

So, on the face of it, I agree with you: this is a compiler bug. However,
it's still worth fixing. Just because it's valid C isn't a good enough
reason to leave it as-is: we continue to minimize the subset of the
C language the kernel uses if it helps us get the most out of existing
compiler features. We've eliminated all kinds of other "valid C" from the
kernel because it improves robustness, security, etc. This is certainly
nothing like removing VLAs or implicit fallthrough, but given that this
is, I think, the only remaining case of it (I removed all the others a
while ago when I had the same issues with the GCC plugins), I'd like to
get it fixed.

And I should point out that Clang suffers[1] from the same problem (the
variables will be missed for auto-initialization), but actually has a
worse behavior: it does not even warn about it.

And note that the problem isn't limited to -ftrivial-auto-var-init. This
code pattern seems to also hide the variables from similar instrumentation
like KASan, etc. (Which is similarly silent like above.)

In both compilers, it seems fixing this is not "easy", and given its
corner-case nature and ease of being worked around in the kernel source,
it isn't being highly prioritized. But since I both don't want these
blinds spots with Clang (and GCC) var-init, and I don't want these
warnings to suddenly appear once GCC 12 _does_ get released, so I'd like
to get this case fixed as well.

All that said, I think this patch could be improved.

I'd recommend, instead, just simply:

diff --git a/drivers/acpi/arm64/iort.c b/drivers/acpi/arm64/iort.c
index f2f8f05662de..9e765d30da82 100644
--- a/drivers/acpi/arm64/iort.c
+++ b/drivers/acpi/arm64/iort.c
@@ -1671,13 +1671,14 @@ phys_addr_t __init acpi_iort_dma_get_max_cpu_address(void)
 	end = ACPI_ADD_PTR(struct acpi_iort_node, iort, iort->header.length);
 
 	for (i = 0; i < iort->node_count; i++) {
+		struct acpi_iort_named_component *ncomp;
+		struct acpi_iort_root_complex *rc;
+		phys_addr_t local_limit;
+
 		if (node >= end)
 			break;
 
 		switch (node->type) {
-			struct acpi_iort_named_component *ncomp;
-			struct acpi_iort_root_complex *rc;
-			phys_addr_t local_limit;
 
 		case ACPI_IORT_NODE_NAMED_COMPONENT:
 			ncomp = (struct acpi_iort_named_component *)node->node_data;

This results in no change in binary instruction output (when there is no
auto-init).

-Kees

[1] https://github.com/llvm/llvm-project/issues/44261

> 
> 
> > ---
> >  drivers/acpi/arm64/iort.c | 12 ++++++------
> >  1 file changed, 6 insertions(+), 6 deletions(-)
> >
> > diff --git a/drivers/acpi/arm64/iort.c b/drivers/acpi/arm64/iort.c
> > index 3b23fb775ac4..65395f0decf9 100644
> > --- a/drivers/acpi/arm64/iort.c
> > +++ b/drivers/acpi/arm64/iort.c
> > @@ -1645,7 +1645,7 @@ void __init acpi_iort_init(void)
> >   */
> >  phys_addr_t __init acpi_iort_dma_get_max_cpu_address(void)
> >  {
> > -       phys_addr_t limit = PHYS_ADDR_MAX;
> > +       phys_addr_t local_limit, limit = PHYS_ADDR_MAX;
> >         struct acpi_iort_node *node, *end;
> >         struct acpi_table_iort *iort;
> >         acpi_status status;
> > @@ -1667,17 +1667,16 @@ phys_addr_t __init acpi_iort_dma_get_max_cpu_address(void)
> >                         break;
> >
> >                 switch (node->type) {
> > +               case ACPI_IORT_NODE_NAMED_COMPONENT: {
> >                         struct acpi_iort_named_component *ncomp;
> > -                       struct acpi_iort_root_complex *rc;
> > -                       phys_addr_t local_limit;
> > -
> > -               case ACPI_IORT_NODE_NAMED_COMPONENT:
> >                         ncomp = (struct acpi_iort_named_component *)node->node_data;
> >                         local_limit = DMA_BIT_MASK(ncomp->memory_address_limit);
> >                         limit = min_not_zero(limit, local_limit);
> >                         break;
> >
> > -               case ACPI_IORT_NODE_PCI_ROOT_COMPLEX:
> > +               }
> > +               case ACPI_IORT_NODE_PCI_ROOT_COMPLEX: {
> > +                       struct acpi_iort_root_complex *rc;
> >                         if (node->revision < 1)
> >                                 break;
> >
> > @@ -1686,6 +1685,7 @@ phys_addr_t __init acpi_iort_dma_get_max_cpu_address(void)
> >                         limit = min_not_zero(limit, local_limit);
> >                         break;
> >                 }
> > +               }
> >                 node = ACPI_ADD_PTR(struct acpi_iort_node, node, node->length);
> >         }
> >         acpi_put_table(&iort->header);
> >
> > _______________________________________________
> > linux-arm-kernel mailing list
> > linux-arm-kernel@lists.infradead.org
> > http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

-- 
Kees Cook
