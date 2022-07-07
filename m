Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FE2B56ABE0
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jul 2022 21:31:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236097AbiGGTbe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jul 2022 15:31:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235993AbiGGTbb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jul 2022 15:31:31 -0400
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78EC226AD7;
        Thu,  7 Jul 2022 12:31:30 -0700 (PDT)
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-31c9b70c382so117601847b3.6;
        Thu, 07 Jul 2022 12:31:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+Yo1gyIUuh0t0KSq4z0vIRNUEuFAyyrHGuMhkAu6OgU=;
        b=bjWRR5WmN9XzXuT+Dm+6LuDuva1UfMrSvnpKAh+7UBCzftsl5FMC0TQ0ezOgWCWYnd
         AMccNaJ2JeBPlw9O+38p5is+uqG8OkVbR+g4liAjEAV7Hl3aTyCmEikiLIlOTg0acJT2
         tm6aumBPzrcpeiSAC3VNALQ2w+GdZ3HRWa0BklA+CfHSGEjGliOviBzbGYHYI6v2wNE/
         hstiNUSSVSQAvh5FkryFArpXmJJ3cLWG3SY4A1Q8fmsTOoJSblUzZzd/1HB8HauxwQF9
         ESxKytPsLhgiVM7yCt+kbTiUvP2X3VW8zA0Sf3vvu81mOnml8K4+iv+8MD0kuYK5XJz6
         SOGQ==
X-Gm-Message-State: AJIora++9qLBp+9jMgiW8UF960hva/LYdMGJrcyPRo3gqBHkjfM+OxxY
        pbGJQ6lWdwvry4iAO11cl8ins8ita6tSkc5Y+GaRv55ShRc=
X-Google-Smtp-Source: AGRyM1vwKkl4yV8gdhcd8bbAYKoO9Z0C3T9ptqQVFriF7T9p7uUohruC7M0Kt+PbS2XQd7ImTWhKy+cPxlHB58tjk+4=
X-Received: by 2002:a0d:c486:0:b0:31c:3b63:91fe with SMTP id
 g128-20020a0dc486000000b0031c3b6391femr49182721ywd.7.1657222289321; Thu, 07
 Jul 2022 12:31:29 -0700 (PDT)
MIME-Version: 1.0
References: <5592689.DvuYhMxLoT@kreacher> <be219334-456f-c2f1-7102-4a3b01e8cd59@redhat.com>
In-Reply-To: <be219334-456f-c2f1-7102-4a3b01e8cd59@redhat.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 7 Jul 2022 21:31:18 +0200
Message-ID: <CAJZ5v0jPpsO4OkC=3ZkEwKzQWufwrt6YwMhNv8heEC12chDPTA@mail.gmail.com>
Subject: Re: [RFC][PATCH] ACPI: EC: Make evaluate acpi_ec_add() _REG for EC
 operation regions
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 6, 2022 at 10:26 PM Hans de Goede <hdegoede@redhat.com> wrote:
>
> Hi,
>
> On 7/6/22 14:37, Rafael J. Wysocki wrote:
> > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> >
> > acpi_ec_ecdt_probe() is called between acpi_load_tables() and
> > acpi_enable_subsystem().  It passes ACPI_ROOT_OBJECT as ec->handle
> > to acpi_ec_setup() and so ACPI_ROOT_OBJECT is passed to
> > acpi_install_address_space_handler() via ec_install_handlers().
> >
> > Next, acpi_ns_validate_handle() converts it to acpi_gbl_root_node
> > which is passed to acpi_ev_install_space_handler() and the handler is
> > installed for acpi_gbl_root_node.
> >
> > Now, acpi_gbl_root_node is passed to acpi_ev_execute_reg_methods() which
> > evaluates _REG for any ACPI_ADR_SPACE_EC regions it can find in the
> > namespace which should not be necessary, because the OS is expected to
> > make the ECDT operation regions available before evaluating any AML, so
> > in particular AML is not expected to check the evaluation of _REG before
> > it accesses these operation regions (see ACPI 6.4, Section 6.5.4,
> > exception 2 [1]).  Doing that is also problematic, because the _REG
> > methods for the ACPI_ADR_SPACE_EC regions may depend on various _INI, so
> > they should be be evaluated before running acpi_initialize_objects() [2].
> >
> > Address this problem by modifying acpi_install_address_space_handler()
> > to avoid evaluating _REG for ACPI_ADR_SPACE_EC regions when the handler
> > is installed for acpi_gbl_root_node which indicates the ECDT case.
> >
> > However, this needs to be accompanied by an EC driver change to
> > actually trigger the evaluation of _REG for the ACPI_ADR_SPACE_EC
> > regions when it finds the EC object in the namespace.
> >
> > Link: https://uefi.org/specs/ACPI/6.4/06_Device_Configuration/Device_Configuration.html#reg-region # [1]
> > Link: https://github.com/acpica/acpica/pull/786 # [2]
> > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > ---
> >
> > Note: This change doesn't make any practical difference on any of the systems
> > in my office.
> >
> > ---
> >  drivers/acpi/acpica/evxfregn.c |   12 ++++++++++++
> >  drivers/acpi/ec.c              |    7 +++++++
> >  2 files changed, 19 insertions(+)
> >
> > Index: linux-pm/drivers/acpi/ec.c
> > ===================================================================
> > --- linux-pm.orig/drivers/acpi/ec.c
> > +++ linux-pm/drivers/acpi/ec.c
> > @@ -1632,6 +1632,13 @@ static int acpi_ec_add(struct acpi_devic
> >                       acpi_handle_debug(ec->handle, "duplicated.\n");
> >                       acpi_ec_free(ec);
> >                       ec = boot_ec;
> > +                     /*
> > +                      * Uninstall the EC address space handler and let
> > +                      * acpi_ec_setup() install it again along with
> > +                      * evaluating _REG methogs associated with
> > +                      * ACPI_ADR_SPACE_EC operation regions.
> > +                      */
> > +                     ec_remove_handlers(ec);
>
> This will call the _REG method to get called with ACPI_REG_DISCONNECT (0)
> as second argument which may lead to unexpected consequences so I'm not
> in favor of doing things this way.
>
> IMHO it would be much better to instead have flags; or if flags are
> disliked a separate function to only call _REG later on.

I'm aware of the _REG(EC, 0) part, but I thought that it might be the
right thing to do.

First off, I'm a bit concerned about leaving the EC address space
handler attached to the root node after we have discovered the proper
EC object in the namespace, because that's inconsistent with the "no
ECDT" case.

It leaves a potential problem on the table too, because acpi_ec_add()
changes boot_ec->handle from ACPI_ROOT_OBJECT to ec->handle and if
ec_remove_handlers() is called for it after that, it will fail to
remove the handler, but it will clear the
EC_FLAGS_EC_HANDLER_INSTALLED flag (so the change above is actually
incorrect, because it should remove the handler before changing
boot_ec->handle).

But in order to move the EC address space handler under the EC object,
it needs to be uninstalled and for this purpose AML needs to be told
that it's not there, so evaluating _REG(EC, 0) seems reasonable to me
even though I agree that it is somewhat risky.

Second, the spec is kind of suggesting doing it (cf. the "These
operation regions may become inaccessible after OSPM runs
_REG(EmbeddedControl, 0)" comment in the _REG definition section).

Moreover, I don't quite like the ACPI_NO_INSTALL_SPACE_HANDLER flag,
because it causes the "handler installation" to actually do something
else.

> >               }
> >       }
> >
> > Index: linux-pm/drivers/acpi/acpica/evxfregn.c
> > ===================================================================
> > --- linux-pm.orig/drivers/acpi/acpica/evxfregn.c
> > +++ linux-pm/drivers/acpi/acpica/evxfregn.c
> > @@ -78,6 +78,18 @@ acpi_install_address_space_handler(acpi_
> >               goto unlock_and_exit;
> >       }
> >
> > +     /*
> > +      * Avoid evaluating _REG methods if an EC address space handler is
> > +      * installed for acpi_gbl_root_node, because this is done in order to
> > +      * make Embedded Controller operation regions, accessed via the Embedded
> > +      * Controllers described in ECDT, available early (see ACPI 6.4, Section
> > +      * 6.5.4, exception 2).
> > +      */
> > +
> > +     if (node == acpi_gbl_root_node || space_id == ACPI_ADR_SPACE_EC) {
> > +             goto unlock_and_exit;
> > +     }
> > +
>
> Hmm, I like this in that it is KISS. But OTOH this does mean that
> acpi_install_address_space_handler() now behaves differently depending on its
> parameters in a possibly surprising way. So IMHO this feels a bit too clever
> for our own good, since it may surprise the callers of this function.
>
> My biggest problem is, that as indicated above I believe that instead
> of uninstalling + re-installing the handler we really need to have a way
> to just call _REG later; and that in turn requires the caller to know if
> _REG has run or not.

Well, as stated above, I think it would be prudent to move the handler
under the EC object proper once it has been discovered.

> I've posted a new RFC patch series which adds flags to
> acpi_install_address_space_handler() to not run / only run _REG :
>
> https://lore.kernel.org/linux-acpi/20220706201410.88244-1-hdegoede@redhat.com/
>
> this then gets used in the drivers/acpi/ec.c patch to defer calling _REG when
> registering the handler based on the ECDT until the DSDT EC entry is parsed.
> I personally like how this turns out and IMHO this is cleaner (less hackish)
> then the proposed solution with calling ec_remove_handlers(ec) :
>
> https://lore.kernel.org/linux-acpi/20220706201410.88244-3-hdegoede@redhat.com/

Overall, I think that we'll need a new "no _REG" variant of
acpi_install_address_space_handler(), at least for backward
compatibility with other OSes using ACPICA, but I would call it
acpi_install_address_space_handler_no_reg() and do all of the flags
(or BOOL for that matter) passing internally in evxfregn.c.

Thanks!
