Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB62E5468F0
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Jun 2022 17:00:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238188AbiFJPAf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Jun 2022 11:00:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234890AbiFJPAd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jun 2022 11:00:33 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D17F2EE1C
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jun 2022 08:00:32 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id j6so24043706pfe.13
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jun 2022 08:00:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lSK2wZhEtJ5wnNqYHfb5O845HlqDf+dscUxaAejYqd0=;
        b=Dom89QJB4I+++vWACM0Z4fKLVgUr1rKKAz6BGW2zT2v2+7aeal24mQ9OA4EHIUT4J3
         gOF3/A5t8fp9SXY7Sw/QuSyeom5VpM1CsTg/AHiHxh18XjXYHkrf7SW5NMyojeNxSFNm
         UeBFRnICArmqKXB/MmbUvuheFfEhDMNDwbMRmJ4ANcc2uktDaiXcVLWSXXYmE9GdKvVx
         4k+weCnDNirYuk//diluog0d842/FmckCf8dDVvVTn+bQvHTg5G8Wnmjj6j6sLcA/RCv
         llVEL5/J7WX1FFwNYCveLgNkXteF+gi4Q1iG77SiL1BX+KnqENHaZN5Pw8zKj/hiENw5
         JQog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lSK2wZhEtJ5wnNqYHfb5O845HlqDf+dscUxaAejYqd0=;
        b=196oRNduz5ugcnTh16H11jBFVq9hlnak4oEqmgeBDIhsXrHrHTUOBYZaRAG6SDdNFx
         sLFqTKfoEIiu2WhHug951KQ/rF48OvnRU6I2o8AFV690QFXayMIdIgpWADwFBeDcQ9b/
         Ernt3D+2ZpmDZr2FKf7wZwtnUsdMkxpkdmpMoDL9SVUu9vD+Dr0fvgD836kl0dD85RTU
         Uq/+kLF2xHw55ua/n2ytjfpRcDQr2lhm3X2S192zKvAUjF0jfkzyVZlfajP83j/PzT90
         tOaE0iAq5dSH2jxp8oPcvfO2NUsewSqa7uskFVFGVfSzUYlA2HLFzgvSKzHOu71XZ1cx
         JaKQ==
X-Gm-Message-State: AOAM531INPdVu9et3J+5SzPwbHCNllnb5aBn1rQMlfABlx1I1po32+DG
        2dXGZcdmUBAjE793HwGvdVQTZrySKb5Lu6Ros9LmAg==
X-Google-Smtp-Source: ABdhPJwiMZY+Y30ibJBuiqQg10SC1Ijf82hELE1i89/molZqYgYrXu2U1U4CER9Km2C9i5dmsHXpnC/feSug+3AOJ7k=
X-Received: by 2002:a63:114:0:b0:3fd:431a:dd77 with SMTP id
 20-20020a630114000000b003fd431add77mr32260670pgb.619.1654873231981; Fri, 10
 Jun 2022 08:00:31 -0700 (PDT)
MIME-Version: 1.0
References: <20220609134057.2485190-1-pterjan@google.com> <YqNMGgwsjhB7TNzk@kroah.com>
In-Reply-To: <YqNMGgwsjhB7TNzk@kroah.com>
From:   Pascal Terjan <pterjan@google.com>
Date:   Fri, 10 Jun 2022 15:00:14 +0000
Message-ID: <CAANdO=KDp9aYbRGxb4sDQtBD4rrjpy6_ruQBt9mZiVKtW_KZGw@mail.gmail.com>
Subject: Re: [PATCH] vboxguest: add missing devm_free_irq
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Hans de Goede <hdegoede@redhat.com>, Arnd Bergmann <arnd@arndb.de>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 10 Jun 2022 at 13:50, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Thu, Jun 09, 2022 at 02:40:57PM +0100, Pascal Terjan wrote:
> > This fixes the following warning when unloading the module:
> >
> > [249348.837181] remove_proc_entry: removing non-empty directory 'irq/20', leaking at least 'vboxguest'
> > [249348.837219] WARNING: CPU: 0 PID: 6708 at fs/proc/generic.c:715 remove_proc_entry+0x119/0x140
> >
> > [249348.837379] Call Trace:
> > [249348.837385]  unregister_irq_proc+0xbd/0xe0
> > [249348.837392]  free_desc+0x23/0x60
> > [249348.837396]  irq_free_descs+0x4a/0x70
> > [249348.837401]  irq_domain_free_irqs+0x160/0x1a0
> > [249348.837452]  mp_unmap_irq+0x5c/0x60
> > [249348.837458]  acpi_unregister_gsi_ioapic+0x29/0x40
> > [249348.837463]  acpi_unregister_gsi+0x17/0x30
> > [249348.837467]  acpi_pci_irq_disable+0xbf/0xe0
> > [249348.837473]  pcibios_disable_device+0x20/0x30
> > [249348.837478]  pci_disable_device+0xef/0x120
> > [249348.837482]  vbg_pci_remove+0x6c/0x70 [vboxguest]
> >
> > Signed-off-by: Pascal Terjan <pterjan@google.com>
> > ---
> >  drivers/virt/vboxguest/vboxguest_linux.c | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/drivers/virt/vboxguest/vboxguest_linux.c b/drivers/virt/vboxguest/vboxguest_linux.c
> > index 6e8c0f1c1056..faa4bc9f625c 100644
> > --- a/drivers/virt/vboxguest/vboxguest_linux.c
> > +++ b/drivers/virt/vboxguest/vboxguest_linux.c
> > @@ -423,6 +423,7 @@ static void vbg_pci_remove(struct pci_dev *pci)
> >       vbg_gdev = NULL;
> >       mutex_unlock(&vbg_gdev_mutex);
> >
> > +     devm_free_irq(gdev->dev, pci->irq, gdev);
>
> The whope point of using devm_* calls is so you don't have to do stuff
> like this.  Perhaps this should not be using devm_() for the irq at all?

My initial assumption was that some sort of dependency was missing
somewhere to ensure this gets freed first, but I failed to find any
documentation on how this is supposed to work, so I went with a fix
that would work.

But you are obviously right, if we manually free it in the normal path
then using devm_{request,free}_irq sounds like just overhead without
benefits.
