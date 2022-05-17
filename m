Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1860A52AAAF
	for <lists+linux-kernel@lfdr.de>; Tue, 17 May 2022 20:26:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348836AbiEQS0f convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 17 May 2022 14:26:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352115AbiEQS0Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 May 2022 14:26:16 -0400
Received: from sender4-of-o58.zoho.com (sender4-of-o58.zoho.com [136.143.188.58])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29FE4220EA;
        Tue, 17 May 2022 11:26:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1652811971; cv=none; 
        d=zohomail.com; s=zohoarc; 
        b=E7nkhhzyAb2NSHwmsADpzJJWrCBT2Vk6ISmdbqYkrk/rG7Cr+Do73hCcR8g6gyPzIzBy7GgnGiEyEDQR+C+i06sl3brUJLXY9BnNZk4t2QyJ1gbG+d+DfT6bLXj1+W5DBnkPRV7PJRU1vfPovdQzZCO7Gh2ZYAnZeU7y1U97rd4=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
        t=1652811971; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
        bh=Y9YimAnJKBglTx1djbp8syx3nqzLsbEglYyst69uI5Q=; 
        b=TGhUqune1tf51bd7y1egfs2EWMS2T4+QvYyAUWigD9nw2wH1d1ZMTr1vmfsFAvmgO7oI40I3DI93CqV1vnOrhsCJ9+5Ep2/E4aZGo2RTajeVlwYIWla5gXgYbdjRT5zQE8wGqTEADZYC1CICTXlhwso5irv5fxFYU5EoVT0jegU=
ARC-Authentication-Results: i=1; mx.zohomail.com;
        spf=pass  smtp.mailfrom=linux@mniewoehner.de;
        dmarc=pass header.from=<linux@mniewoehner.de>
Received: from z3r0.lan (185.31.62.161 [185.31.62.161]) by mx.zohomail.com
        with SMTPS id 1652811946661528.7783926675852; Tue, 17 May 2022 11:25:46 -0700 (PDT)
Message-ID: <28686e8d994c297a78fb816805cd3652a8f8c90a.camel@mniewoehner.de>
Subject: Re: [PATCH] ACPI: utils: include UUID in _DSM evaluation warning
From:   Michael =?ISO-8859-1?Q?Niew=F6hner?= <linux@mniewoehner.de>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Len Brown <lenb@kernel.org>,
        "open list:ACPI" <linux-acpi@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
In-Reply-To: <CAJZ5v0h+kKwdntGPC5PP6N0ZRbRzLxuwcwTGm-PNBH6Z3mnETg@mail.gmail.com>
References: <f80dfd57fdca87897f070a3ea4ee0a26b03e7831.camel@mniewoehner.de>
         <CAJZ5v0h+kKwdntGPC5PP6N0ZRbRzLxuwcwTGm-PNBH6Z3mnETg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Date:   Tue, 17 May 2022 20:25:43 +0200
MIME-Version: 1.0
User-Agent: Evolution 3.42.2 
Content-Transfer-Encoding: 8BIT
X-ZohoMailClient: External
X-Spam-Status: No, score=-0.4 required=5.0 tests=BAYES_00,DKIM_ADSP_ALL,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2022-05-17 at 16:49 +0200, Rafael J. Wysocki wrote:
> On Mon, May 16, 2022 at 7:25 PM Michael Niewöhner <linux@mniewoehner.de>
> wrote:
> > 
> > The _DSM evaluation warning in its current form is not very helpful, as
> > it lacks any specific information:
> >   ACPI: \: failed to evaluate _DSM (0x1001)
> > 
> > Thus, include the UUID of the missing _DSM:
> >   ACPI: \: failed to evaluate _DSM bf0212f2-... (0x1001)
> > 
> > Signed-off-by: Michael Niewöhner <linux@mniewoehner.de>
> > ---
> >  drivers/acpi/utils.c | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/acpi/utils.c b/drivers/acpi/utils.c
> > index d5cedffeeff9..7da993f5b6c3 100644
> > --- a/drivers/acpi/utils.c
> > +++ b/drivers/acpi/utils.c
> > @@ -681,7 +681,8 @@ acpi_evaluate_dsm(acpi_handle handle, const guid_t
> > *guid,
> > u64 rev, u64 func,
> > 
> >         if (ret != AE_NOT_FOUND)
> >                 acpi_handle_warn(handle,
> > -                               "failed to evaluate _DSM (0x%x)\n", ret);
> > +                               "failed to evaluate _DSM %pUb (0x%x)\n",
> > +                               ret, guid);
> 
> Shouldn't this be "guid, ret" ?

Ouch, yes ofc.

> Also, don't you want to print the
> value of the GUID rather than the address of its location?

Not sure what you mean tbh. Documentation/core-api/printk-formats.rst states
%pUb being the right format. lib/test_printf.c implements it that way, too.

> 
> And I don't think you need to break the line here.
> 
> > 
> >         return NULL;
> >  }
> > --
> > 2.34.1
> > 
> > 

