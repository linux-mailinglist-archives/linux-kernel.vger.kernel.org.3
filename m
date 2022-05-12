Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62D235250CE
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 17:04:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355677AbiELPEH convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 12 May 2022 11:04:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231782AbiELPED (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 11:04:03 -0400
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F91C6BFED;
        Thu, 12 May 2022 08:04:00 -0700 (PDT)
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-2f16645872fso60025107b3.4;
        Thu, 12 May 2022 08:04:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=03yB+3thvFD8JtxaGtTda0M+LOZiA6X6v6EA8xoZfXM=;
        b=e4Ct9ZIOom74c7Ba9ymnDNQpfFK4j/1r+hPXxxHc86JE/jwjAnH2tlShNjGsLX74nq
         NHmveYwy7z0T49PNZxafLQc9eJyn3qih64HFlFycxXBAzA9ihLDTSy09r60xdYmpzRT1
         etrE9PTqtRQyH/uKuBN5fhgpGcZhu9yzPPop4FZ/tg9s/IvFz3pXfHN9bFKTq7TIu8oK
         GvMe8XzSwKPqKJ0SI45A1A17SuPNn68biJiLvuY0g/M/kISF4yQTYHRsM7v+GczYmduL
         MNsp/GcJc8OcKv11mr5TAqODRr5eaqZlUbc80nLIReHhKGfyRZG5t7g8xwzkLThDHPcq
         M7tQ==
X-Gm-Message-State: AOAM5326XRgBNf3IeSnof5rhGAuuejCDRjov/ZHxE4qFVKSdmif12KU0
        0yr7JT69bUGmvAFyaN7eoDmKFWtzzL9ty8CrXAQ=
X-Google-Smtp-Source: ABdhPJxFA3tZOBogfQgb9aTgqq84JZxkvDvNi3qwEuj4PulKcyiU7vJHw/S2JJ/D2cvzfRRNHdxeWqzmOfVkiSKTz6Y=
X-Received: by 2002:a0d:ddce:0:b0:2f8:c9f7:8f7c with SMTP id
 g197-20020a0dddce000000b002f8c9f78f7cmr479195ywe.301.1652367839727; Thu, 12
 May 2022 08:03:59 -0700 (PDT)
MIME-Version: 1.0
References: <20220511134559.1466925-1-pierre.gondois@arm.com> <20220511141731.rjyjmgvux43lsj3x@bogus>
In-Reply-To: <20220511141731.rjyjmgvux43lsj3x@bogus>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 12 May 2022 17:03:48 +0200
Message-ID: <CAJZ5v0gvHO=2ZwdpQrgMufGFtkEcG-K9zEqoFBYys36qAhTE4Q@mail.gmail.com>
Subject: Re: [PATCH v1 1/5] ACPI: CPPC: Check _OSC for flexible address space
To:     Sudeep Holla <sudeep.holla@arm.com>,
        Pierre Gondois <pierre.gondois@arm.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Ionela Voinescu <Ionela.Voinescu@arm.com>,
        Dietmar Eggemann <Dietmar.Eggemann@arm.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Robert Moore <robert.moore@intel.com>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        "open list:ACPI COMPONENT ARCHITECTURE (ACPICA)" <devel@acpica.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 11, 2022 at 4:17 PM Sudeep Holla <sudeep.holla@arm.com> wrote:
>
> On Wed, May 11, 2022 at 03:45:55PM +0200, Pierre Gondois wrote:
> > ACPI 6.2 Section 6.2.11.2 'Platform-Wide OSPM Capabilities':
> >   Starting with ACPI Specification 6.2, all _CPC registers can be in
> >   PCC, System Memory, System IO, or Functional Fixed Hardware address
> >   spaces. OSPM support for this more flexible register space scheme is
> >   indicated by the “Flexible Address Space for CPPC Registers” _OSC bit
> >
> > Otherwise (cf ACPI 6.1, s8.4.7.1.1.X), _CPC registers must be in:
> > - PCC or Functional Fixed Hardware address space if defined
> > - SystemMemory address space (NULL register) if not defined
> >
> > Add the corresponding _OSC bit and check it when parsing _CPC objects.
> >
>
> Looks good, other than a minor nit below. Feel free to ignore that or
> check what is Rafael's preference. Otherwise,
>
> Reviewed-by: Sudeep Holla <sudeep.holla@arm.com>
>
> > Signed-off-by: Pierre Gondois <pierre.gondois@arm.com>
> > ---
> >  drivers/acpi/bus.c       | 18 ++++++++++++++++++
> >  drivers/acpi/cppc_acpi.c |  9 +++++++++
> >  include/linux/acpi.h     |  2 ++
> >  3 files changed, 29 insertions(+)
> >
> [...]
>
> > diff --git a/include/linux/acpi.h b/include/linux/acpi.h
> > index d7136d13aa44..977d74d0465b 100644
> > --- a/include/linux/acpi.h
> > +++ b/include/linux/acpi.h
> > @@ -574,6 +574,7 @@ acpi_status acpi_run_osc(acpi_handle handle, struct acpi_osc_context *context);
> >  #define OSC_SB_OSLPI_SUPPORT                 0x00000100
> >  #define OSC_SB_CPC_DIVERSE_HIGH_SUPPORT              0x00001000
> >  #define OSC_SB_GENERIC_INITIATOR_SUPPORT     0x00002000
> > +#define OSC_SB_CPC_FLEXIBLE_ADR_SP           0x00004000
>
> I would prefer ADR_SPACE instead of ADR_SP.

Yes, please make this change.
