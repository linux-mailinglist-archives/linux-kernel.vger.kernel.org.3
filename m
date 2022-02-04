Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF7D24A9222
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Feb 2022 02:54:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356562AbiBDByB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Feb 2022 20:54:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234520AbiBDBx7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Feb 2022 20:53:59 -0500
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com [IPv6:2607:f8b0:4864:20::d31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D5A4C061714
        for <linux-kernel@vger.kernel.org>; Thu,  3 Feb 2022 17:53:59 -0800 (PST)
Received: by mail-io1-xd31.google.com with SMTP id w7so5675082ioj.5
        for <linux-kernel@vger.kernel.org>; Thu, 03 Feb 2022 17:53:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=CxeSMOub6619/Vo/I4fh/hAKT2CKDmbES7X5b4hBt8I=;
        b=MpSoFkim7n2kSWDPKb+IqXhnmOsLb7b5KC27bLpPoVTWuCDoPXkrp/X2PiCCDo5j0/
         oHbaA1J0LbL9NzswCzYHWxQatylxecmokxuWEwq+y06VaMDrDX1OKWQXWVxKp3xw4npT
         2FNeDbtP7DWoIOiXpTtPMrx2c3R4VgnfP+LReiFvGO7gS078fgqIlq9smzd9CD6688Ia
         Os14jTeMHLfh7JRlHh6KXu+Dca9eCT5hJhRA5Xu2g3W06lMsRVCrRMQVBgtYDbEw1nZV
         fYzCKHYA0NDIfFVivpCethfaXfzUJ5hnS2Ax+2VI9yuNw3gNhfhIPoQ3yF3Bn2bjE9ld
         znHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=CxeSMOub6619/Vo/I4fh/hAKT2CKDmbES7X5b4hBt8I=;
        b=b00I2GL6fEOPzaZwppWUrVqS6xG9mE0ntfhGm2aXdz9/g5iVN0f66DZIIyiCuEG2Qi
         c1QnFQw5BvKuPekgVgpmWhoGXdN5vhAl/AHntqr2OnBr0u48EII/zJpaZen677VOzZUw
         F+V9TQGcpEBndGFt8PO26dFkYBE8quPVIoisUSTz/VJ5NR4cjHMpBhjaqMOG5DQmM6rp
         zPWGwoVGQ160kGlOSlRajjJY6c1HNj1xda/sKGLfmeRncpkdbXpGkrUDlzDEAFHaslDF
         SG7eZOAx5tVfeuzDPWn72k/DertIM1Dlnc54uJ+I2UtlrXlngZklpv5rZQJGzI48gBLz
         Ykjw==
X-Gm-Message-State: AOAM533/9APttc76Cfgjj2ZOnjxt9HSSyHVIhTv5OSV6ppX3yULWK9vz
        iPjkH6FKQmVM95MTUBX36ncTB4esLlmUsZH55rPmKw==
X-Google-Smtp-Source: ABdhPJymJ8VU7aQ0lQIoyaDdsEdp0vaAbuhPnh0m/5z8gGx7M8shBPPt2lx3rkcycP/wtHL30dI0Eb1TrqgFhFIuYCs=
X-Received: by 2002:a05:6638:d93:: with SMTP id l19mr330160jaj.68.1643939638018;
 Thu, 03 Feb 2022 17:53:58 -0800 (PST)
MIME-Version: 1.0
References: <20220128220156.4057446-1-jmeurin@google.com> <20220131110003.7aacad70@xps13>
In-Reply-To: <20220131110003.7aacad70@xps13>
From:   Jean-Marc Eurin <jmeurin@google.com>
Date:   Thu, 3 Feb 2022 17:53:47 -0800
Message-ID: <CAL3wywWSDJUsbgJf4NXctxJmrJRzyO9V-PVcu3qftM1GGPyU_Q@mail.gmail.com>
Subject: Re: [PATCH v2] mtdoops: Fix the size of the header read buffer.
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 31, 2022 at 2:00 AM Miquel Raynal <miquel.raynal@bootlin.com> w=
rote:
>
> Hi Jean-Marc,
>
> jmeurin@google.com wrote on Fri, 28 Jan 2022 14:01:56 -0800:
>
> > The read buffer size depends on the MTDOOPS_HEADER_SIZE.
> >
> > Tested: Changed the header size, it doesn't panic, header is still
> > read/written correctly.
>
> On what Linux kernel version are you? It looks like we don't share the
> same code base, are we?

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/dri=
vers/mtd/mtdoops.c?h=3Dv5.17-rc2
has that bug.  If you try to increase the MTDOOPS_HEADER_SIZE,
find_next_position() will try to do an mtd_read() of
MTDOOPS_HEADER_SIZE bytes in a count buffer that is fixed to only 8
bytes.

Thanks,

Jean-Marc

>
> >
> > Signed-off-by: Jean-Marc Eurin <jmeurin@google.com>
> > ---
> >  drivers/mtd/mtdoops.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/mtd/mtdoops.c b/drivers/mtd/mtdoops.c
> > index 227df24387df..09a26747f490 100644
> > --- a/drivers/mtd/mtdoops.c
> > +++ b/drivers/mtd/mtdoops.c
> > @@ -223,7 +223,7 @@ static void find_next_position(struct mtdoops_conte=
xt *cxt)
> >  {
> >       struct mtd_info *mtd =3D cxt->mtd;
> >       int ret, page, maxpos =3D 0;
> > -     u32 count[2], maxcount =3D 0xffffffff;
> > +     u32 count[MTDOOPS_HEADER_SIZE/sizeof(u32)], maxcount =3D 0xffffff=
ff;
> >       size_t retlen;
> >
> >       for (page =3D 0; page < cxt->oops_pages; page++) {
>
>
> Thanks,
> Miqu=C3=A8l
