Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C00B5449A0
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jun 2022 13:03:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243328AbiFILDx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jun 2022 07:03:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243296AbiFILDs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 07:03:48 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 604C533E0B
        for <linux-kernel@vger.kernel.org>; Thu,  9 Jun 2022 04:03:43 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id c196so20803164pfb.1
        for <linux-kernel@vger.kernel.org>; Thu, 09 Jun 2022 04:03:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=IQjWoMytTLM9Dcyp3i5P+y4SUoKQ6ziA0Ta14wE6h3g=;
        b=CwjSPemQL1z4gXSvHaVlKdK2j2sP7CEKbKvnZsN+xhmgsZOj1xqsJLv9N3qfYFtdgL
         3uZ/tnCxe4qPpkqm89Vffx4PNKTMoZUAVm0azLinZP5iT081I17SyTikEi+YfrsXD1aL
         QHeOH9nEpiuA507C7oZZl4+YuPKZeVAypn7ywr109Oio4DfWFIFnztadBj/DaS/p3VGK
         UrJsC8QCbZnSkF7luM9YisRf/AZINEunuICdy8+RoL6nuPJxlJoR7Ii3VMgDlx9QUfio
         ATeGOA4ONeJMy2+aB4OOw5rE6Z4eI70juHAKU+O+xD6jS+iJDcWh6O9NYGKKKeD+On50
         QxtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IQjWoMytTLM9Dcyp3i5P+y4SUoKQ6ziA0Ta14wE6h3g=;
        b=1YedVdCrL9s5HBUNlPPl6e3uy1slLMJE+A2mxiZPWsSyJGSV6WFCMQBpoYdU5CDp8C
         RaUj3DkXpqWecQmGzQKj5PXXqxUUEhFxnXo9VeWjoeVDLGw50MOY3pb5aqxpXWEYALCw
         sg/mHkJCzQ2uKeYiXpHFlRt9VXLKFZIcazdPIQY2XnPUbYStiHbiPnOkwvB+GLExPmpk
         z94nidn6cKctmqa2EQAz9XEofRR5/t5PO0xSH8hfVs9XGCsyxz+I8dH5n/+1ukuFP+op
         i3pPeAfN52GmLFMAiO1LL4MKUew+WY7DFqD1Ujpyyj5Hw5B7NzrfGiEZzHpr+O4rAusk
         EiIw==
X-Gm-Message-State: AOAM5338TziyAr5iUGDCt4giD+0MDC518KoTmpMYl42aGxpxRGpNhJkv
        AvqE3vN5VOvgIJgZDz/1yzCtWDpGGqb4ALSNOw==
X-Google-Smtp-Source: ABdhPJwMGNHGVc6tb9NrGW3aLpKrrpeDHo1YYDFy1Bxx5cYceRnFSsg5BdfG2gOfGg5Ei6E0NUNEorkPcuLwUFnE1vU=
X-Received: by 2002:a05:6a00:ad0:b0:4f7:a357:6899 with SMTP id
 c16-20020a056a000ad000b004f7a3576899mr39745777pfl.80.1654772623393; Thu, 09
 Jun 2022 04:03:43 -0700 (PDT)
MIME-Version: 1.0
References: <20220609083133.4120738-1-zheyuma97@gmail.com> <YqGxjwLHxaXG/646@kroah.com>
In-Reply-To: <YqGxjwLHxaXG/646@kroah.com>
From:   Zheyu Ma <zheyuma97@gmail.com>
Date:   Thu, 9 Jun 2022 19:03:32 +0800
Message-ID: <CAMhUBj=nTiTu8wwjk0=WGE=nJPWtb+kSq_u=MW_FF1DHLE-55A@mail.gmail.com>
Subject: Re: [PATCH] tty: nozomi: Return an error when failing to create the sysfs
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Jiri Slaby <jirislaby@kernel.org>, fseidel@suse.de,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 9, 2022 at 4:38 PM Greg KH <gregkh@linuxfoundation.org> wrote:
>
> On Thu, Jun 09, 2022 at 04:31:33PM +0800, Zheyu Ma wrote:
> > The driver does not handle the error of the creation of sysfs, resulting
> > in duplicate file names being created.
> >
> > The following log can reveal it:
> >
> > [   52.907211] sysfs: cannot create duplicate filename '/devices/pci0000:00/0000:00:05.0/card_type'
>
> How is the same file being created in a normal codepath?
>
> Is the same device being registered twice somehow?

In fact, I tried to load the nozomi driver twice.
In the first load, the driver failed at tty_port_register_device(),
performed error handling and returned an error, but by this time the
make_sysfs_files() had been executed and the sysfs had been created.
In the second load, the make_sysfs_files() is executed again and this
warning is returned.

> > [   52.907224] Call Trace:
> > [   52.907269]  sysfs_add_file_mode_ns+0x23f/0x2b0
> > [   52.907281]  sysfs_create_file_ns+0xe9/0x170
> > [   52.907321]  nozomi_card_init+0x97f/0x12c0 [nozomi]
> >
> > Fix this bug by returning an error when failing to create the sysfs.
> >
> > Fixes: 20fd1e3bea55 ("nozomi driver")
> > Signed-off-by: Zheyu Ma <zheyuma97@gmail.com>
> > ---
> >  drivers/tty/nozomi.c | 24 ++++++++++++++++++++----
> >  1 file changed, 20 insertions(+), 4 deletions(-)
> >
> > diff --git a/drivers/tty/nozomi.c b/drivers/tty/nozomi.c
> > index 0454c78deee6..d0ad1b9898f5 100644
> > --- a/drivers/tty/nozomi.c
> > +++ b/drivers/tty/nozomi.c
> > @@ -1282,14 +1282,26 @@ static ssize_t open_ttys_show(struct device *dev, struct device_attribute *attr,
> >  }
> >  static DEVICE_ATTR_RO(open_ttys);
> >
> > -static void make_sysfs_files(struct nozomi *dc)
> > +static int make_sysfs_files(struct nozomi *dc)
> >  {
> > -     if (device_create_file(&dc->pdev->dev, &dev_attr_card_type))
> > +     int err;
> > +
> > +     err = device_create_file(&dc->pdev->dev, &dev_attr_card_type);
>
> Drivers shouldn't be calling this function anyway, it's a race
> condition.  How about switching this to use the proper device groups
> functionality instead which moves all of the handling of the sysfs files
> to the driver core so that the driver can not get it wrong?

Thanks for your reminder, since I'm not familiar with this function, I
will learn how to use the device groups functionality and revise the
patch.

> That should solve the error handling case.  The fact that this is trying
> to be created twice is a symptom of a worse problem here.  How are you
> duplicating this?

As mentioned above, I tried to load the nozomi driver twice and
make_sysfs_files() is executed twice.

thanks,

Zheyu Ma
