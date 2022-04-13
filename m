Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D20B4FFE02
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Apr 2022 20:39:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237778AbiDMSlb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Apr 2022 14:41:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237772AbiDMSl2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 14:41:28 -0400
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 544276578F;
        Wed, 13 Apr 2022 11:39:06 -0700 (PDT)
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-2ebd70a4cf5so32567807b3.3;
        Wed, 13 Apr 2022 11:39:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=s7ZiirljygamRSXBd9pz2rQ/gtAwBPQ328d/UpiDcQk=;
        b=FOMlHiyWj4sQyIFASiXqZKyZOuvVueXr6nOq9qQnIWqLF5fXjei/4B6VKVB5LPoBpk
         MRqiEUw7kcn6MVgGGMmyaxj7PL+OhhgvSHt17MhMdRkMBoL4VUBwxg469CQUKfHo1ewg
         SQrns6jK59aQ99UqTVOxC1S9R4cEf/4D7EaTXq/GRYlFvr3YQWl6hGRYFppjT3orL02e
         EJ3jAT5+SyVO6ayYJuHm0NdtcgQ+fQ0AlU2DYEE2/jZXbCJr0j03h8Ty5mypKe4DIXh9
         dhyQq3rrkgkMZVesW24AWKXJNKAgTnrPd0HDNa8nBwY+h/n4d08F/UQDlWKrcaEdnh0d
         yiYg==
X-Gm-Message-State: AOAM530+rvfd5XoefBjALucpUugx+SfkIvzO9H3Czrqj2EXbcyw9aJBW
        /JWyj8pvj0bDhM9Ni4F6qoqv5fJQ4lUV1+uc2h4=
X-Google-Smtp-Source: ABdhPJzerlKsX6NRbuO3Q4fgePtDL4OjlO5J8pZ9jSyz7BXPmML0SiSLAi7G2QTkYTxRuL0BV5dQUpjXBuI8mYEnzmY=
X-Received: by 2002:a81:1096:0:b0:2ec:4a46:7e5a with SMTP id
 144-20020a811096000000b002ec4a467e5amr255495ywq.196.1649875145609; Wed, 13
 Apr 2022 11:39:05 -0700 (PDT)
MIME-Version: 1.0
References: <20220311165310.60418-1-jonathanh@nvidia.com> <db1e0d18-8a6a-02a2-a663-386987cc7df8@nvidia.com>
In-Reply-To: <db1e0d18-8a6a-02a2-a663-386987cc7df8@nvidia.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 13 Apr 2022 20:38:54 +0200
Message-ID: <CAJZ5v0g3feazLCz1GZB_c=qziu8uqFr9J+mWKME1NEggsaSM7g@mail.gmail.com>
Subject: Re: [PATCH] ACPI: SPCR: Add support for NVIDIA 16550-compatible port subtype
To:     Jon Hunter <jonathanh@nvidia.com>
Cc:     "Rafael J . Wysocki" <rafael@kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jeff Brasen <jbrasen@nvidia.com>,
        "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 11, 2022 at 5:54 PM Jon Hunter <jonathanh@nvidia.com> wrote:
>
> Adding linux-tegra ...
>
> On 11/03/2022 16:53, Jon Hunter wrote:
> > From: Jeff Brasen <jbrasen@nvidia.com>
> >
> > Add support for the NVIDIA specific 16550 subtype to SPCR table parsing
> > routine.
> >
> > Signed-off-by: Jeff Brasen <jbrasen@nvidia.com>
> > Signed-off-by: Jon Hunter <jonathanh@nvidia.com>
> > ---
> >   drivers/acpi/spcr.c | 1 +
> >   1 file changed, 1 insertion(+)
> >
> > diff --git a/drivers/acpi/spcr.c b/drivers/acpi/spcr.c
> > index d589543875b8..1eabfcd122ee 100644
> > --- a/drivers/acpi/spcr.c
> > +++ b/drivers/acpi/spcr.c
> > @@ -142,6 +142,7 @@ int __init acpi_parse_spcr(bool enable_earlycon, bool enable_console)
> >       case ACPI_DBG2_16550_COMPATIBLE:
> >       case ACPI_DBG2_16550_SUBSET:
> >       case ACPI_DBG2_16550_WITH_GAS:
> > +     case ACPI_DBG2_16550_NVIDIA:
> >               uart = "uart";
> >               break;
> >       default:
>
> --

So seeing no objections or concerns, I've queued up this one for 5.19
now, thanks!
