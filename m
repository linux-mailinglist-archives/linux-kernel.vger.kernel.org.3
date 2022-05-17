Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 051B552AACD
	for <lists+linux-kernel@lfdr.de>; Tue, 17 May 2022 20:29:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352196AbiEQS27 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 17 May 2022 14:28:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352248AbiEQS2p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 May 2022 14:28:45 -0400
Received: from mail-yb1-f172.google.com (mail-yb1-f172.google.com [209.85.219.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1549449F19;
        Tue, 17 May 2022 11:28:42 -0700 (PDT)
Received: by mail-yb1-f172.google.com with SMTP id a3so14824099ybg.5;
        Tue, 17 May 2022 11:28:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=yLKFTvllEnb3n3nFUIfBrKxcB6r2mY4TZ0eJaZi1jOo=;
        b=iyC1p4vbdozsAmKTgsiO69uGEugKzSk9HnSGJqxPzPE6xl78cQ0jUS6AfICx2pR1kP
         X7T/zIH0T4NNTnlqxLTPorh9VMqESfhzZ/E5MvC1yi8QDlGIPt4cGVHiAt7AmbQB7YTf
         8MBnVXaFUn0JFTyctt0EStxCzUhcdCfV/9feKwHtmR5xm0K0OGERk1ygHU2Rz6/OKv1q
         myBbxQfx4Amqg9vioTunmAHydDxUyrwtk4GufaKLwg9a5fAvowJlFkerEInIKxZf0zVW
         mlIwbpfFha6hWhusxMOxG/RTSBbQ7k/JoopAgmM+pFRLmvpVjuNn6GCG/QYd9xeN2DmV
         u73w==
X-Gm-Message-State: AOAM530c/IJ0iymz8jIG3i3jqya3/qFAfGdzK2cARgARdtjDCbCjc7bZ
        a5XbEBWJQ4lTUmosV4fccuoMPu2ZKDR6UVdUC/f++vfF
X-Google-Smtp-Source: ABdhPJygZZcshgEgipo6qKLVDSNEV4d442F2Y1m4FFHpoe9ENg6PLcKPOa83NuL3VpOGX/liUe0jzjwEBdFcig8Z7pE=
X-Received: by 2002:a25:1145:0:b0:64d:d6be:c741 with SMTP id
 66-20020a251145000000b0064dd6bec741mr8749396ybr.137.1652812121705; Tue, 17
 May 2022 11:28:41 -0700 (PDT)
MIME-Version: 1.0
References: <f80dfd57fdca87897f070a3ea4ee0a26b03e7831.camel@mniewoehner.de>
 <CAJZ5v0h+kKwdntGPC5PP6N0ZRbRzLxuwcwTGm-PNBH6Z3mnETg@mail.gmail.com> <28686e8d994c297a78fb816805cd3652a8f8c90a.camel@mniewoehner.de>
In-Reply-To: <28686e8d994c297a78fb816805cd3652a8f8c90a.camel@mniewoehner.de>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 17 May 2022 20:28:30 +0200
Message-ID: <CAJZ5v0hWxhn9WM3ciQgbZpa7x8JwpHK=Bz4kefB_3VnAM0gB9Q@mail.gmail.com>
Subject: Re: [PATCH] ACPI: utils: include UUID in _DSM evaluation warning
To:     =?UTF-8?Q?Michael_Niew=C3=B6hner?= <linux@mniewoehner.de>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        "open list:ACPI" <linux-acpi@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 17, 2022 at 8:26 PM Michael Niewöhner <linux@mniewoehner.de> wrote:
>
> On Tue, 2022-05-17 at 16:49 +0200, Rafael J. Wysocki wrote:
> > On Mon, May 16, 2022 at 7:25 PM Michael Niewöhner <linux@mniewoehner.de>
> > wrote:
> > >
> > > The _DSM evaluation warning in its current form is not very helpful, as
> > > it lacks any specific information:
> > >   ACPI: \: failed to evaluate _DSM (0x1001)
> > >
> > > Thus, include the UUID of the missing _DSM:
> > >   ACPI: \: failed to evaluate _DSM bf0212f2-... (0x1001)
> > >
> > > Signed-off-by: Michael Niewöhner <linux@mniewoehner.de>
> > > ---
> > >  drivers/acpi/utils.c | 3 ++-
> > >  1 file changed, 2 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/drivers/acpi/utils.c b/drivers/acpi/utils.c
> > > index d5cedffeeff9..7da993f5b6c3 100644
> > > --- a/drivers/acpi/utils.c
> > > +++ b/drivers/acpi/utils.c
> > > @@ -681,7 +681,8 @@ acpi_evaluate_dsm(acpi_handle handle, const guid_t
> > > *guid,
> > > u64 rev, u64 func,
> > >
> > >         if (ret != AE_NOT_FOUND)
> > >                 acpi_handle_warn(handle,
> > > -                               "failed to evaluate _DSM (0x%x)\n", ret);
> > > +                               "failed to evaluate _DSM %pUb (0x%x)\n",
> > > +                               ret, guid);
> >
> > Shouldn't this be "guid, ret" ?
>
> Ouch, yes ofc.
>
> > Also, don't you want to print the
> > value of the GUID rather than the address of its location?
>
> Not sure what you mean tbh. Documentation/core-api/printk-formats.rst states
> %pUb being the right format. lib/test_printf.c implements it that way, too.

I missed that, sorry.
