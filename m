Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2ECF55B1C8A
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 14:14:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231391AbiIHMOA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Sep 2022 08:14:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229576AbiIHMNz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Sep 2022 08:13:55 -0400
Received: from mail-yb1-xb2b.google.com (mail-yb1-xb2b.google.com [IPv6:2607:f8b0:4864:20::b2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0633DE55B7;
        Thu,  8 Sep 2022 05:13:55 -0700 (PDT)
Received: by mail-yb1-xb2b.google.com with SMTP id g5so26051394ybg.11;
        Thu, 08 Sep 2022 05:13:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=SAM3mkegdCeaGVQgcXVVpthAb6ElEKSQcT12XxK/rDg=;
        b=UYY6e5y5Giua61QzsVGiSq6DQZmkmftZ5Wb4Q3NhvE1cm4x9K/cpS0diwQNlJYBYOM
         MVqzw7cWdy2dJ3NeACQF5z23xfaE7WFpktSAzkfjgLTVY63bPZt0cQNjugQMveKVF13r
         uxGJTiQKmgPL39oAuTkrmi1TJFAdA7yZaQLIYVSvi54x6VSj98lW0HPjlFER2DfiauNU
         lnA10QQoeF7QMS8e+f29qG33KPzOfvgObyjZ9uXJuSvrg6QKANfFrvE7LCmRgkYtLtFd
         ycaHI7Dt7tw1tSrFu880GPKa1Rz5PeYCelMR7JAo001c6e3TwrifFoHBrw/+khYPdwSi
         kxaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=SAM3mkegdCeaGVQgcXVVpthAb6ElEKSQcT12XxK/rDg=;
        b=5jxWJAqBbsTYR8p9d4EpKGG2wqw8onzWJtuM/dSSgfzzyDEYLAeb86kGDTmPoEH1sy
         fkqr6JYjjOBbc3HSq6FEg5F0dQOthXbU05P9pE9QWk/DQKaEZ1q2Da/6SSFfryUwsxb2
         zQ1e38FDtbcFjYq12OYxhj7QvtLAXBa8jJVLo3dHL1iJY8ATx0DiRvrZFZbiOIG0npa/
         8rpnAFqUGcg9nmmTnPGEREdP/kSI4dmJDLHPakgOtcUrUmbkyvxvZCXbixXHAiU0mJ/6
         Xho4qXhsCU5GuXWZzyRvHiluDgG4SfvSH3/0GSK3BpHeIZ6jRIkXf+JaL0zEfbYfwqv/
         Awlg==
X-Gm-Message-State: ACgBeo0n8IDEsGP8gq3YZBiH4oFrI0GWY85HZa/RLge2xf1xBve/dfzB
        6uoZPiFdVQ4cfFR5BtCda4WuVUNri+i8a3/+xHY=
X-Google-Smtp-Source: AA6agR6A54qH3lxmUpYHnW0X+bo5fGo16klKJB94RRqUN+vA9dsVtSbx9UghA4lAdjeptmty+EzDNfWxIYmbPjPMWiY=
X-Received: by 2002:a25:99c5:0:b0:6a9:6c30:a67d with SMTP id
 q5-20020a2599c5000000b006a96c30a67dmr6851545ybo.117.1662639234282; Thu, 08
 Sep 2022 05:13:54 -0700 (PDT)
MIME-Version: 1.0
References: <20220906102154.32526-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20220906102154.32526-2-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <8ecb62b7-53c4-1c43-65b3-567d8c12e131@microchip.com> <CAOnJCUKLpRz4Fbx1XiMnap-ELw2k1c8E9V8bZiSP+x7z9Z5QrA@mail.gmail.com>
 <f362eaeb-6ccd-4392-a346-55fa5ae25e13@microchip.com> <OS0PR01MB5922833FDCA60892191B211A86409@OS0PR01MB5922.jpnprd01.prod.outlook.com>
 <CA+V-a8uttuVd5_UXvNjXU6yG-GpmxG-BuEAm9pWxx13PjZ-h5w@mail.gmail.com> <e72263ee-10af-1249-5f0d-7e90e8e88441@microchip.com>
In-Reply-To: <e72263ee-10af-1249-5f0d-7e90e8e88441@microchip.com>
From:   "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date:   Thu, 8 Sep 2022 13:13:27 +0100
Message-ID: <CA+V-a8vS_ozrbEC=JmRwMTQxwqsciPdoaVU=rbPK-=DpkhfP7A@mail.gmail.com>
Subject: Re: [RFC PATCH 1/2] riscv: vendors: andes: Add support to configure
 the PMA regions
To:     Conor Dooley <Conor.Dooley@microchip.com>
Cc:     guoren@linux.alibaba.com, atishp@atishpatra.org,
        "Lad, Prabhakar" <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>, atishp@rivosinc.com,
        apatel@ventanamicro.com,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 8, 2022 at 1:00 PM <Conor.Dooley@microchip.com> wrote:
>
> On 08/09/2022 12:50, Lad, Prabhakar wrote:
> > EXTERNAL EMAIL: Do not click links or open attachments unless you know the content is safe
> >
> > Hi Guo,
> >
> >>> -----Original Message-----
> >>> From: Conor.Dooley@microchip.com <Conor.Dooley@microchip.com>
> >>> Sent: 08 September 2022 00:38
> >>> To: atishp@atishpatra.org
> >>> Cc: Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>;
> >>> paul.walmsley@sifive.com; palmer@dabbelt.com; aou@eecs.berkeley.edu;
> >>> atishp@rivosinc.com; apatel@ventanamicro.com; geert+renesas@glider.be;
> >>> linux-riscv@lists.infradead.org; linux-renesas-soc@vger.kernel.org;
> >>> linux-kernel@vger.kernel.org; prabhakar.csengg@gmail.com; Biju Das
> >>> <biju.das.jz@bp.renesas.com>
> >>> Subject: Re: [RFC PATCH 1/2] riscv: vendors: andes: Add support to
> >>> configure the PMA regions
> >>>
> >>> On 07/09/2022 22:52, Atish Patra wrote:
> >>>> EXTERNAL EMAIL: Do not click links or open attachments unless you know
> >>>> the content is safe
> >>>>
> >>>>
> >>>> On Tue, Sep 6, 2022 at 3:40 AM <Conor.Dooley@microchip.com
> >>>> <mailto:Conor.Dooley@microchip.com>> wrote:
> >>>>
> >>>> On 06/09/2022 11:21, Lad Prabhakar wrote:
> >>>>
> >>>>> diff --git a/arch/riscv/include/asm/sbi.h
> >>>>> b/arch/riscv/include/asm/sbi.h index 2a0ef738695e..10a7c855d125
> >>>>> 100644 --- a/arch/riscv/include/asm/sbi.h +++
> >>>>> b/arch/riscv/include/asm/sbi.h @@ -37,6 +37,7 @@ enum sbi_ext_id {
> >>>>>
> >>>>> /* Vendor extensions must lie within this range */
> >>>>> SBI_EXT_VENDOR_START = 0x09000000, +       SBI_EXT_ANDES =
> >>>>> 0x0900031E, SBI_EXT_VENDOR_END = 0x09FFFFFF, };
> >>>>
> > I am interested to know what is the status of your patch series [0].
> >
> > [0] https://lore.kernel.org/lkml/20210606143848.GA5983@lst.de/T/#m7f4c4cdfb92d6c8672bbfabebda729ce4700e177
>
> Heh, take a look at:
> git grep "ERRATA_THEAD*"
>
> This is all can-of-worms territory that we are heading to here, as
> the Zicbo* extensions is what is meant to be doing these sorts of
> things..
>
Aha thanks for the pointer.

Cheers,
Prabhakar
