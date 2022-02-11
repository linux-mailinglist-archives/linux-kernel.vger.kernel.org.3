Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33D074B24A6
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 12:44:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349547AbiBKLn5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Feb 2022 06:43:57 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:57160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232547AbiBKLny (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Feb 2022 06:43:54 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69B62EA4;
        Fri, 11 Feb 2022 03:43:53 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 01408619E4;
        Fri, 11 Feb 2022 11:43:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6368EC340EE;
        Fri, 11 Feb 2022 11:43:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644579832;
        bh=PYLbPWTm08w/m0Z3E62EOS3Y3FI+zIO516vLJZfda6o=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=bo1ylpBLPdjV0n92cOnA2l5VHpXljd3ivbr41I0zhrXlD0R4CPrT7invTfIrOWTdc
         quHptOdd6Niww3+Ie76w6FfEnFAwNAZJoZlcizjgsBQv9GQCjFpU5aPEAWIXOJA/I6
         IWLeGl0RZrE4fZq5hNiYds6/paABueHdjoz2fzPjA56TqMABkz+NS5NIty6PQjsGS6
         4evLxrmnrIUXTEVoZdVHbBKj/x/ywugxrLQifXfHx0Wpt0bgRUuo+ZX+XVarSdYhfr
         ncwvcyzcJ0hBdfIUNSmAKjpDK7sySYRPXbSbqJ/SYM0LMp57cR1c4fHWnEWjVPE5YS
         FfV7X3jRIZmQw==
Received: by mail-wm1-f50.google.com with SMTP id k41so4128053wms.0;
        Fri, 11 Feb 2022 03:43:52 -0800 (PST)
X-Gm-Message-State: AOAM5317YoaoBOPTjqiTjv0MYnxSacCzNfIKvDb7hO3rZBjoPQJpfRXZ
        vfgwGQQe1hL1cN1SaJECLoNCxSYyBxVfTn4R6sY=
X-Google-Smtp-Source: ABdhPJxTQ0hppsDtQCg8WjAIngOZ2Viph6OeIWSlDwm8lasVTkYkAhja+Y7TViOHfUlHze3Si5FF3teNhywY00+VCbA=
X-Received: by 2002:a05:600c:a47:: with SMTP id c7mr1148964wmq.25.1644579830682;
 Fri, 11 Feb 2022 03:43:50 -0800 (PST)
MIME-Version: 1.0
References: <1644518851-16847-1-git-send-email-victor.erminpour@oracle.com>
 <CAMj1kXEbGWs74M2CZSm6TWpD11mReFsk8z-UUqJt6b6vDCvAEQ@mail.gmail.com>
 <202202101415.43750CEE@keescook> <3740c93e-9fde-f89f-9752-26ffff3ea274@arm.com>
In-Reply-To: <3740c93e-9fde-f89f-9752-26ffff3ea274@arm.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Fri, 11 Feb 2022 12:43:38 +0100
X-Gmail-Original-Message-ID: <CAMj1kXFbZ3amLQqzKf8XXR9EHLkEuwZ1dYwiFadzUJgCN3bsgg@mail.gmail.com>
Message-ID: <CAMj1kXFbZ3amLQqzKf8XXR9EHLkEuwZ1dYwiFadzUJgCN3bsgg@mail.gmail.com>
Subject: Re: [PATCH v2] ACPI/IORT: Fix GCC 12 warning
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     Kees Cook <keescook@chromium.org>,
        Victor Erminpour <victor.erminpour@oracle.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Hanjun Guo <guohanjun@huawei.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        trivial@kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 11 Feb 2022 at 11:34, Robin Murphy <robin.murphy@arm.com> wrote:
>
> Hi Kees,
>
> On 2022-02-10 23:47, Kees Cook wrote:
> > On Thu, Feb 10, 2022 at 08:41:51PM +0100, Ard Biesheuvel wrote:
> >> On Thu, 10 Feb 2022 at 19:48, Victor Erminpour
> >> <victor.erminpour@oracle.com> wrote:
> >>>
> >>> When building with automatic stack variable initialization, GCC 12
> >>> complains about variables defined outside of switch case statements.
> >>> Move the variable into the case that uses it, which silences the warning:
> >>>
> >>> ./drivers/acpi/arm64/iort.c:1670:59: error: statement will never be executed [-Werror=switch-unreachable]
> >>>    1670 |                         struct acpi_iort_named_component *ncomp;
> >>>         |                                                           ^~~~~
> >>>
> >>> Signed-off-by: Victor Erminpour <victor.erminpour@oracle.com>
> >>
> >> Please cc people that commented on your v1 when you send a v2.
> >>
> >> Still NAK, for the same reasons.
> >
> > Let me see if I can talk you out of this. ;)
> >
> > So, on the face of it, I agree with you: this is a compiler bug. However,
> > it's still worth fixing. Just because it's valid C isn't a good enough
> > reason to leave it as-is: we continue to minimize the subset of the
> > C language the kernel uses if it helps us get the most out of existing
> > compiler features. We've eliminated all kinds of other "valid C" from the
> > kernel because it improves robustness, security, etc. This is certainly
> > nothing like removing VLAs or implicit fallthrough, but given that this
> > is, I think, the only remaining case of it (I removed all the others a
> > while ago when I had the same issues with the GCC plugins), I'd like to
> > get it fixed.
>
> It concerns me if minimising the subset of the C language that the
> kernel uses is achieved by converting more of the kernel to a
> not-quite-C language that is not formally specified anywhere, by
> prematurely adopting newly-invented compiler options that clearly don't
> work properly (the GCC warning message quoted above may as well be
> "error: giraffes are not purple" for all the sense it makes.)
>
> > And I should point out that Clang suffers[1] from the same problem (the
> > variables will be missed for auto-initialization), but actually has a
> > worse behavior: it does not even warn about it.
> >
> > And note that the problem isn't limited to -ftrivial-auto-var-init. This
> > code pattern seems to also hide the variables from similar instrumentation
> > like KASan, etc. (Which is similarly silent like above.)
>
>  From your security standpoint (and believe me, I really do have faith
> in your expertise here), which of these sounds better:
>
> 1: Being able to audit code based on well-defined language semantics
>
> 2: Playing whack-a-mole as issues are discovered empirically.
>
> 3: Neither of the above, but a warm fuzzy feeling because hey someone
> said "security" in a commit message.
>
> AFAICS you're effectively voting against #1, and the examples you've
> given demonstrate that #2 is nowhere near reliable enough either, so
> where does that leave us WRT actual secure and robust code in Linux?
>

My concerns are more about:
- The GCC version of the feature not being fully baked yet, which
makes it hard to have full confidence in its implementation (surely,
GCC has a test case or two with a switch scope variable declaration;
- We waste the credit we have with other developers who care less
about security on things that we could have fixed before they'd even
notice. What will happen the next time around when we *really* need
source level changes?

> > In both compilers, it seems fixing this is not "easy", and given its
> > corner-case nature and ease of being worked around in the kernel source,
> > it isn't being highly prioritized. But since I both don't want these
> > blinds spots with Clang (and GCC) var-init, and I don't want these
> > warnings to suddenly appear once GCC 12 _does_ get released, so I'd like
> > to get this case fixed as well.
> >

So how is this

switch {
var foo;
case x:
   ...
}

fundamentally different from

{
var foo;
switch {
case x:
   ...
}
}

Surely, some kind of transformation is possible where the var
declaration is hoisted into a parent scope added around the entire
switch {} statement?

> > All that said, I think this patch could be improved.
> >
> > I'd recommend, instead, just simply:
> >
> > diff --git a/drivers/acpi/arm64/iort.c b/drivers/acpi/arm64/iort.c
> > index f2f8f05662de..9e765d30da82 100644
> > --- a/drivers/acpi/arm64/iort.c
> > +++ b/drivers/acpi/arm64/iort.c
> > @@ -1671,13 +1671,14 @@ phys_addr_t __init acpi_iort_dma_get_max_cpu_address(void)
> >       end = ACPI_ADD_PTR(struct acpi_iort_node, iort, iort->header.length);
> >
> >       for (i = 0; i < iort->node_count; i++) {
> > +             struct acpi_iort_named_component *ncomp;
> > +             struct acpi_iort_root_complex *rc;
> > +             phys_addr_t local_limit;
> > +
> >               if (node >= end)
> >                       break;
> >
> >               switch (node->type) {
> > -                     struct acpi_iort_named_component *ncomp;
> > -                     struct acpi_iort_root_complex *rc;
> > -                     phys_addr_t local_limit;
> >
> >               case ACPI_IORT_NODE_NAMED_COMPONENT:
> >                       ncomp = (struct acpi_iort_named_component *)node->node_data;
> >
> > This results in no change in binary instruction output (when there is no
> > auto-init).
>
> In fairness I'd have no objection to that patch if it came with a
> convincing justification, but that is so far very much lacking. My aim
> here is not to be a change-averse Luddite, but to try to find a
> compromise where I can actually have some confidence in such changes
> being made. Let's not start pretending that 3 100ml bottles of shampoo
> are somehow "safer" than a 300ml bottle of shampoo...
>

Not sure I get the shampoo reference, but I just don't think this
idiom meets the bar for code that really needs modification for the
compiler to be able to do the right thing.


> >
> > [1] https://github.com/llvm/llvm-project/issues/44261
> >
> >>
> >>
> >>> ---
> >>>   drivers/acpi/arm64/iort.c | 12 ++++++------
> >>>   1 file changed, 6 insertions(+), 6 deletions(-)
> >>>
> >>> diff --git a/drivers/acpi/arm64/iort.c b/drivers/acpi/arm64/iort.c
> >>> index 3b23fb775ac4..65395f0decf9 100644
> >>> --- a/drivers/acpi/arm64/iort.c
> >>> +++ b/drivers/acpi/arm64/iort.c
> >>> @@ -1645,7 +1645,7 @@ void __init acpi_iort_init(void)
> >>>    */
> >>>   phys_addr_t __init acpi_iort_dma_get_max_cpu_address(void)
> >>>   {
> >>> -       phys_addr_t limit = PHYS_ADDR_MAX;
> >>> +       phys_addr_t local_limit, limit = PHYS_ADDR_MAX;
> >>>          struct acpi_iort_node *node, *end;
> >>>          struct acpi_table_iort *iort;
> >>>          acpi_status status;
> >>> @@ -1667,17 +1667,16 @@ phys_addr_t __init acpi_iort_dma_get_max_cpu_address(void)
> >>>                          break;
> >>>
> >>>                  switch (node->type) {
> >>> +               case ACPI_IORT_NODE_NAMED_COMPONENT: {
> >>>                          struct acpi_iort_named_component *ncomp;
> >>> -                       struct acpi_iort_root_complex *rc;
> >>> -                       phys_addr_t local_limit;
> >>> -
> >>> -               case ACPI_IORT_NODE_NAMED_COMPONENT:
> >>>                          ncomp = (struct acpi_iort_named_component *)node->node_data;
> >>>                          local_limit = DMA_BIT_MASK(ncomp->memory_address_limit);
> >>>                          limit = min_not_zero(limit, local_limit);
> >>>                          break;
> >>>
> >>> -               case ACPI_IORT_NODE_PCI_ROOT_COMPLEX:
> >>> +               }
> >>> +               case ACPI_IORT_NODE_PCI_ROOT_COMPLEX: {
> >>> +                       struct acpi_iort_root_complex *rc;
> >>>                          if (node->revision < 1)
> >>>                                  break;
> >>>
> >>> @@ -1686,6 +1685,7 @@ phys_addr_t __init acpi_iort_dma_get_max_cpu_address(void)
> >>>                          limit = min_not_zero(limit, local_limit);
> >>>                          break;
> >>>                  }
> >>> +               }
> >>>                  node = ACPI_ADD_PTR(struct acpi_iort_node, node, node->length);
> >>>          }
> >>>          acpi_put_table(&iort->header);
> >>>
> >>> _______________________________________________
> >>> linux-arm-kernel mailing list
> >>> linux-arm-kernel@lists.infradead.org
> >>> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> >
