Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D993589D0F
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Aug 2022 15:51:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239964AbiHDNv1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Aug 2022 09:51:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239938AbiHDNvX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Aug 2022 09:51:23 -0400
Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 489DDBE31;
        Thu,  4 Aug 2022 06:51:18 -0700 (PDT)
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-31f41584236so201223087b3.5;
        Thu, 04 Aug 2022 06:51:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=ekqRBsNEHnn5dHwHj+jXMWOlgtda6Vawkx81upWnkVo=;
        b=CAAkrTmBBW+W6cjI03LbM6H/pQZiMARZ2m9pFIYa2v7YoTBJiYouOg9k6eGSVvB64y
         5NuJq4yqBphiJ5QAxv0CEgF5bMKBBD2HkeOLRfgTXGx3YM5TGh28pb39KiDon2q2z+Kk
         bEgxjx8AHGOWoCxtbCQWUmsu7iwF9spf6p9sfckjAK9kKFaZBIhci0gBIcko7YN/b7FH
         V3XvUPO9D0J0DZ7GStfl3BOeI2hajd9cDtYilssxNvNskEGVwngx+0lyUr9MdxEZtlbr
         tqbiXZjy9t1DDOVodP52nn2dVh+qKPIq2eoWvKxPssImUUFCwtsDIprxTF0Adz6sMwGu
         w1RQ==
X-Gm-Message-State: ACgBeo1QJkAx7yipP7obF3Jw2wybCYUp0BXVE5t5iIy5Ej4YcUgfDEd8
        VTTzPvwE29HGJtNfbjqd6+JPY2hqk9jICEz2iDI=
X-Google-Smtp-Source: AA6agR4K2l9x6u2i3iY0vE7/vmKx/6SFnVShTzG4bC35ADSfJWIZj0rXieNLMBkP4yE513Vz+O2tcRVUzoW6Rv/hSjQ=
X-Received: by 2002:a81:1a11:0:b0:31e:4549:d667 with SMTP id
 a17-20020a811a11000000b0031e4549d667mr1803894ywa.196.1659621077390; Thu, 04
 Aug 2022 06:51:17 -0700 (PDT)
MIME-Version: 1.0
References: <5592689.DvuYhMxLoT@kreacher> <be219334-456f-c2f1-7102-4a3b01e8cd59@redhat.com>
 <CAJZ5v0jPpsO4OkC=3ZkEwKzQWufwrt6YwMhNv8heEC12chDPTA@mail.gmail.com> <29f01ef7-03f7-817b-630b-52be72c83396@redhat.com>
In-Reply-To: <29f01ef7-03f7-817b-630b-52be72c83396@redhat.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 4 Aug 2022 15:51:06 +0200
Message-ID: <CAJZ5v0jQgdqbN67OKpAmL31UnjBjyiEUtY-tCrBYwa_HHeD8pg@mail.gmail.com>
Subject: Re: [RFC][PATCH] ACPI: EC: Make evaluate acpi_ec_add() _REG for EC
 operation regions
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Hans,

On Thu, Aug 4, 2022 at 1:57 PM Hans de Goede <hdegoede@redhat.com> wrote:
>
> Hi Rafael,
>
> Sorry for the slow response...

No sweat.

> On 7/7/22 21:31, Rafael J. Wysocki wrote:
> > On Wed, Jul 6, 2022 at 10:26 PM Hans de Goede <hdegoede@redhat.com> wrote:
> >>
> >> Hi,
> >>
> >> On 7/6/22 14:37, Rafael J. Wysocki wrote:
> >>> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> >>>
> >>> acpi_ec_ecdt_probe() is called between acpi_load_tables() and
> >>> acpi_enable_subsystem().  It passes ACPI_ROOT_OBJECT as ec->handle
> >>> to acpi_ec_setup() and so ACPI_ROOT_OBJECT is passed to
> >>> acpi_install_address_space_handler() via ec_install_handlers().
> >>>
> >>> Next, acpi_ns_validate_handle() converts it to acpi_gbl_root_node
> >>> which is passed to acpi_ev_install_space_handler() and the handler is
> >>> installed for acpi_gbl_root_node.
> >>>
> >>> Now, acpi_gbl_root_node is passed to acpi_ev_execute_reg_methods() which
> >>> evaluates _REG for any ACPI_ADR_SPACE_EC regions it can find in the
> >>> namespace which should not be necessary, because the OS is expected to
> >>> make the ECDT operation regions available before evaluating any AML, so
> >>> in particular AML is not expected to check the evaluation of _REG before
> >>> it accesses these operation regions (see ACPI 6.4, Section 6.5.4,
> >>> exception 2 [1]).  Doing that is also problematic, because the _REG
> >>> methods for the ACPI_ADR_SPACE_EC regions may depend on various _INI, so
> >>> they should be be evaluated before running acpi_initialize_objects() [2].
> >>>
> >>> Address this problem by modifying acpi_install_address_space_handler()
> >>> to avoid evaluating _REG for ACPI_ADR_SPACE_EC regions when the handler
> >>> is installed for acpi_gbl_root_node which indicates the ECDT case.
> >>>
> >>> However, this needs to be accompanied by an EC driver change to
> >>> actually trigger the evaluation of _REG for the ACPI_ADR_SPACE_EC
> >>> regions when it finds the EC object in the namespace.
> >>>
> >>> Link: https://uefi.org/specs/ACPI/6.4/06_Device_Configuration/Device_Configuration.html#reg-region # [1]
> >>> Link: https://github.com/acpica/acpica/pull/786 # [2]
> >>> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> >>> ---
> >>>
> >>> Note: This change doesn't make any practical difference on any of the systems
> >>> in my office.
> >>>
> >>> ---
> >>>  drivers/acpi/acpica/evxfregn.c |   12 ++++++++++++
> >>>  drivers/acpi/ec.c              |    7 +++++++
> >>>  2 files changed, 19 insertions(+)
> >>>
> >>> Index: linux-pm/drivers/acpi/ec.c
> >>> ===================================================================
> >>> --- linux-pm.orig/drivers/acpi/ec.c
> >>> +++ linux-pm/drivers/acpi/ec.c
> >>> @@ -1632,6 +1632,13 @@ static int acpi_ec_add(struct acpi_devic
> >>>                       acpi_handle_debug(ec->handle, "duplicated.\n");
> >>>                       acpi_ec_free(ec);
> >>>                       ec = boot_ec;
> >>> +                     /*
> >>> +                      * Uninstall the EC address space handler and let
> >>> +                      * acpi_ec_setup() install it again along with
> >>> +                      * evaluating _REG methogs associated with
> >>> +                      * ACPI_ADR_SPACE_EC operation regions.
> >>> +                      */
> >>> +                     ec_remove_handlers(ec);
> >>
> >> This will call the _REG method to get called with ACPI_REG_DISCONNECT (0)
> >> as second argument which may lead to unexpected consequences so I'm not
> >> in favor of doing things this way.
> >>
> >> IMHO it would be much better to instead have flags; or if flags are
> >> disliked a separate function to only call _REG later on.
> >
> > I'm aware of the _REG(EC, 0) part, but I thought that it might be the
> > right thing to do.
> >
> > First off, I'm a bit concerned about leaving the EC address space
> > handler attached to the root node after we have discovered the proper
> > EC object in the namespace, because that's inconsistent with the "no
> > ECDT" case.
>
> True, but in the ECDT case the EC opregion should work anywhere
> according to the spec, so I believe it is consistent with the spec.

That's until the proper EC object is discovered, though.

> > It leaves a potential problem on the table too, because acpi_ec_add()
> > changes boot_ec->handle from ACPI_ROOT_OBJECT to ec->handle and if
> > ec_remove_handlers() is called for it after that, it will fail to
> > remove the handler, but it will clear the
> > EC_FLAGS_EC_HANDLER_INSTALLED flag (so the change above is actually
> > incorrect, because it should remove the handler before changing
> > boot_ec->handle).
>
> You are right, but this can be fixed by keeping track of the handle
> used when registering the handler, e.g. something like this:
>
> From fceb436703bc8f0e29b7613246a83c039b631cb4 Mon Sep 17 00:00:00 2001
> From: Hans de Goede <hdegoede@redhat.com>
> Date: Thu, 4 Aug 2022 13:38:35 +0200
> Subject: [PATCH] ACPI: EC: Fix EC address space handler unregistration
>
> When an ECDT table is present the EC address space handler gets registered
> on the root node. So to unregister it properly the unregister call also
> must be done on the root node.
>
> Store the ACPI handle used for the acpi_install_address_space_handler()
> call and use te same handle for the acpi_remove_address_space_handler()
> call.
>
> Reported-by: Rafael J. Wysocki <rafael@kernel.org>
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---
>  drivers/acpi/ec.c       | 4 +++-
>  drivers/acpi/internal.h | 1 +
>  2 files changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/acpi/ec.c b/drivers/acpi/ec.c
> index 1e93677e4b82..6aa8210501d3 100644
> --- a/drivers/acpi/ec.c
> +++ b/drivers/acpi/ec.c
> @@ -1483,6 +1483,7 @@ static int ec_install_handlers(struct acpi_ec *ec, struct acpi_device *device,
>                         return -ENODEV;
>                 }
>                 set_bit(EC_FLAGS_EC_HANDLER_INSTALLED, &ec->flags);
> +               ec->address_space_handler_handle = ec->handle;
>         }
>
>         if (call_reg && !test_bit(EC_FLAGS_EC_REG_CALLED, &ec->flags)) {
> @@ -1543,7 +1544,8 @@ static int ec_install_handlers(struct acpi_ec *ec, struct acpi_device *device,
>  static void ec_remove_handlers(struct acpi_ec *ec)
>  {
>         if (test_bit(EC_FLAGS_EC_HANDLER_INSTALLED, &ec->flags)) {
> -               if (ACPI_FAILURE(acpi_remove_address_space_handler(ec->handle,
> +               if (ACPI_FAILURE(acpi_remove_address_space_handler(
> +                                       ec->address_space_handler_handle,
>                                         ACPI_ADR_SPACE_EC, &acpi_ec_space_handler)))
>                         pr_err("failed to remove space handler\n");
>                 clear_bit(EC_FLAGS_EC_HANDLER_INSTALLED, &ec->flags);
> diff --git a/drivers/acpi/internal.h b/drivers/acpi/internal.h
> index 628bf8f18130..140af11d0c39 100644
> --- a/drivers/acpi/internal.h
> +++ b/drivers/acpi/internal.h
> @@ -173,6 +173,7 @@ enum acpi_ec_event_state {
>
>  struct acpi_ec {
>         acpi_handle handle;
> +       acpi_handle address_space_handler_handle;
>         int gpe;
>         int irq;
>         unsigned long command_addr;
> --

This works.

I would rename address_space_handler_handle to something like
address_space_handler_holder.

> This fixes ec_remove_handlers() without requiring (IMHO) risky changes
> where we call _REG() multiple times.
>
> Also note that ec_remove_handlers() is only ever called from
> acpi_ec_driver.remove which in practice never runs since the EC never
> gets hot unplugged (arguably the entire remove code could be removed).

Indeed.

> > But in order to move the EC address space handler under the EC object,
> > it needs to be uninstalled and for this purpose AML needs to be told
> > that it's not there, so evaluating _REG(EC, 0) seems reasonable to me
> > even though I agree that it is somewhat risky.
>
> I'm pretty worried that calling _REG(EC, 0) will cause problems
> the _REG handlers run pretty early on and various BIOS/ACPI table
> authors seem to (ab)use this to do some sort of early setup
> of some things in _REG, That is pretty much how this whole thread
> has started. Given all the weirdness some ACPI tables do in their
> _REG handling running _REG 3 times:
>
> 1. _REG(EC, 1)
> 2. _REG(EC, 0)
> 3. _REG(EC, 1)
>
> really seems like a bad idea to me. I have the feeling that this is
> asking for trouble.

OK, fair enough.

> > Second, the spec is kind of suggesting doing it (cf. the "These
> > operation regions may become inaccessible after OSPM runs
> > _REG(EmbeddedControl, 0)" comment in the _REG definition section).
>
> That is boilerplate documentation copy and pasted from all the
> other address space handlers the spec defines. I'm not sure if
> Windows ever actually calls _REG(EmbeddedControl, 0) and I would
> not be surprised if Windows does not do this.
>
> > Moreover, I don't quite like the ACPI_NO_INSTALL_SPACE_HANDLER flag,
> > because it causes the "handler installation" to actually do something
> > else.
>
> As mentioned before (IIRC) I would be more then happy to respin both
> the ACPICA as well as the Linux ACPI bits to introduce / use 2 new
> functions for this, lets say:
>
> 1. acpi_install_address_space_handler_no__reg()

So we need this in ACPICA, because it doesn't make sense to drop and
re-acquire the namespace mutex around _REG evaluation in the non-EC
case.

But as stated before I would prefer to introduce an
acpi_install_address_space_handler_internal() taking an additional
BOOL run__reg argument  and I would define
acpi_install_address_space_handler() and the new
acpi_install_address_space_handler_no__reg() as wrappers around it.

> 2. acpi_run_address_space_handler__reg()

So this would just be a wrapper around acpi_ev_execute_reg_methods()
that would acquire the namespace mutex around it, right?  [I think
that it should also acquire acpi_gbl_namespace_rw_lock along the lines
of acpi_walk_namespace(), though.]

I would call it acpi_execute_reg_methods() then.
