Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C85A4FF37F
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Apr 2022 11:27:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234442AbiDMJ3j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Apr 2022 05:29:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229927AbiDMJ3h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 05:29:37 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E75A853B69;
        Wed, 13 Apr 2022 02:27:16 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id 2so1408038pjw.2;
        Wed, 13 Apr 2022 02:27:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=aWHwuVM56mGn8hBqdvVQF2h0/hgZKGEUzuVUodXvntM=;
        b=aB5TwnS2HFOxmF1b4l/z53MXkVL/ul/v+PNiOchygCcKgXValBvZeliRKQJV9gj+Vc
         slXEpmzWh4+qwCgizBHHcwatvJK+yGMbDQVlcKamI7mLLHsWbqqaGCoNgwgU7NkvhjjN
         4anPrku0hGi4Gnx1ceAqVwoBcAoPsQJ5bCKeR0q6lvogtnEtu7A0CelRpz9PRQsQvCq/
         C4cpmbhO+PVUMP+LHcAPLZBkYd2uRpGA2RfWNySq9ltXftbkhX5Z4qfOk05h/WmjCH4T
         R8pQWKToUbzigm26AAkQkemT3Oi6+vTYyaPdt0Q686WhH4YfAwo3EFk51RineGqM/R5e
         xVlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aWHwuVM56mGn8hBqdvVQF2h0/hgZKGEUzuVUodXvntM=;
        b=35rz8bpTb+Yr94p9BF5Qx6Bqn/OmueOiirla1K8uyBD9joZ8/T7acyMS7FhPyYZcLN
         Q/CsyyLbChLaFbOaMzke3118DOBPQ171h+jJDEVkKbGtgpq6PAtPCHn5Gs0+X1/0l9gt
         qITHiLKzD0eKLUQN4CA84f1YZAWrf8PHR41BuLHem9IvrO9DyNNOZVO7NepkCb10Ciym
         JHAUsqj6M7QPDAH2IxlGeXtSNc7s32yyRlmQgKsiJWmmCbBAM5gw/s99dnZBAHZo23NM
         qvB4s6tOVOS8lyFk5r1GAh+Kq0NuN4uqMdM6yJgEZoTXrnDjc7ndwKgx7DEog7D1XuXq
         fMEg==
X-Gm-Message-State: AOAM530O6iu/KxGqKwAVlA/WpBpKm9iskQcd+aXqP1UePDjjHAJtmIDn
        Po7ycAGtP7jwcAAzqJcmZw/5Tg5QuQ/+y6q4Sw==
X-Google-Smtp-Source: ABdhPJz9O5s6O8Bzb1wJFWqKHLGPLctQp79wNjlG9K87jHZwVNQ1wY2A1CSv2mriOcsbvGMVcNcMLrNXE9xUX/PJAU4=
X-Received: by 2002:a17:90a:fb97:b0:1cb:adf9:88ba with SMTP id
 cp23-20020a17090afb9700b001cbadf988bamr9766014pjb.46.1649842036480; Wed, 13
 Apr 2022 02:27:16 -0700 (PDT)
MIME-Version: 1.0
References: <20220409134926.331728-1-zheyuma97@gmail.com> <CAFdVvOzx7t99Btf4Jv5+5=6es0i8AKx_1Bwj5gQd-Oqnqi+tPA@mail.gmail.com>
In-Reply-To: <CAFdVvOzx7t99Btf4Jv5+5=6es0i8AKx_1Bwj5gQd-Oqnqi+tPA@mail.gmail.com>
From:   Zheyu Ma <zheyuma97@gmail.com>
Date:   Wed, 13 Apr 2022 17:27:04 +0800
Message-ID: <CAMhUBj=EG8UrFoLp34F2aSTAoM8jY+Agg_PQypn6zjZ_dkUyoA@mail.gmail.com>
Subject: Re: [PATCH] scsi: mpi3mr: Fix an error code when probing the driver
To:     Sathya Prakash Veerichetty <sathya.prakash@broadcom.com>
Cc:     Kashyap Desai <kashyap.desai@broadcom.com>,
        Sumit Saxena <sumit.saxena@broadcom.com>,
        Sreekanth Reddy <sreekanth.reddy@broadcom.com>,
        jejb@linux.ibm.com,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        mpi3mr-drvr-developers <mpi3mr-linuxdrv.pdl@broadcom.com>,
        linux-scsi <linux-scsi@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
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

On Wed, Apr 13, 2022 at 1:58 AM Sathya Prakash Veerichetty
<sathya.prakash@broadcom.com> wrote:
>
> On Sat, Apr 9, 2022 at 7:49 AM Zheyu Ma <zheyuma97@gmail.com> wrote:
> >
> > During the process of driver probing, probe function should return < 0
> > for failure, otherwise kernel will treat value >= 0 as success.
> >
> > Signed-off-by: Zheyu Ma <zheyuma97@gmail.com>
> > ---
> >  drivers/scsi/mpi3mr/mpi3mr_os.c | 5 +++--
> >  1 file changed, 3 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/scsi/mpi3mr/mpi3mr_os.c b/drivers/scsi/mpi3mr/mpi3mr_os.c
> > index f7cd70a15ea6..240bfdf9788b 100644
> > --- a/drivers/scsi/mpi3mr/mpi3mr_os.c
> > +++ b/drivers/scsi/mpi3mr/mpi3mr_os.c
> > @@ -4222,9 +4222,10 @@ mpi3mr_probe(struct pci_dev *pdev, const struct pci_device_id *id)
> >         struct Scsi_Host *shost = NULL;
> >         int retval = 0, i;
> >
> > -       if (osintfc_mrioc_security_status(pdev)) {
> > +       retval = osintfc_mrioc_security_status(pdev);
> > +       if (retval) {
> >                 warn_non_secure_ctlr = 1;
> > -               return 1; /* For Invalid and Tampered device */
> > +               return retval; /* For Invalid and Tampered device */
> >         }
> NAK. The driver has to return 1 when invalid/tampered controllers are
> detected just to say the controller is held by the mpi3mr driver
> without any actual operation.

Thanks for your explanation, I will drop this patch.

Zheyu Ma
