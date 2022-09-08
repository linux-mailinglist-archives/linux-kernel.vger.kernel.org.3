Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AAEC75B1BE8
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 13:51:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229971AbiIHLva (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Sep 2022 07:51:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229579AbiIHLv0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Sep 2022 07:51:26 -0400
Received: from mail-yb1-xb2b.google.com (mail-yb1-xb2b.google.com [IPv6:2607:f8b0:4864:20::b2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7F4F12754A;
        Thu,  8 Sep 2022 04:51:25 -0700 (PDT)
Received: by mail-yb1-xb2b.google.com with SMTP id 11so26078286ybu.0;
        Thu, 08 Sep 2022 04:51:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=a436DR9ekYarilCtTMkNs/UYHjO6SBD2Qq+LooUdeOk=;
        b=PQeK/QFDstoxZ+S0453r2TClY9wix1qZLhWHZ0dQYcpE3TvXPQ8HH+kmPBKJSpNInY
         lRQroR0Fr1OONJr8JyeHuM8hfrO1Ah2LbDjw2oH5Vzari4cCnjsI7qYcRK6T74wdJOl9
         fUtaJGdqpVgEwlgLXRaWOsAc+r2nOGyVWqtnS/qlqS+JSeQYok6QcVJ//XIxdW758ww/
         w+wHJQhs5zy3VtJkNwg3vwQRr8wtjGZ8IKSKJiTKZ6TchJpEO2omk4B70NoVVBymi65b
         TCrDMZCTFQhUv5Cs/yCSex9cJBp+WXPoBN2xctxI99u/edfz9OFiG6uOAAkeMbAAqQS3
         y/Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=a436DR9ekYarilCtTMkNs/UYHjO6SBD2Qq+LooUdeOk=;
        b=KYwDat/K0egbFUeOmmMf49hpDW9H9qOw2LXth6axm9s5yrvRhYq3a13MwCcYpw/k9I
         9E5ErTPjxzWq1RcduxxIJIIQYKirQjU77KOv4eQHv5dWKJHLrVs2Yfwga7BP+kxKsOUs
         hYWUCL0YN2HOER6KIKBXIsSV4Cl6RomMyMZAB1yaHEZgez/MB25m/yo+ALrbepqbFUqi
         rYbBzj/APGU33+3n+d6MaWGt5KQMOjuvTwCi51TtBeME0YA++AIkDaP+j+ceD/ec5XhL
         s4N4T/0FhT+dkXXtUTgEfF3vXa36Ss36tyW7HP5qxgK/WR3eV0Gx54f/c7cSPvy3KTMs
         d95w==
X-Gm-Message-State: ACgBeo1cmtYWdLn1VZDbmsHNTG/Ri5bBPHaSJ8Sz4efJ5Skrsxp4/1tO
        o8o5JRjTJHEha9hNlq8G6ZAbQ5/MZKdR5t+8fS4jRvYv9s/anQ==
X-Google-Smtp-Source: AA6agR6E7xqAbO/Yprtm4+wPiLhw7gwiKgsB/maUWDEJUTLb4z+vH9/hiMygV2JLUV4WmRV8WAKxeq+yBYhz05q96LQ=
X-Received: by 2002:a05:6902:20a:b0:670:c563:9180 with SMTP id
 j10-20020a056902020a00b00670c5639180mr6824058ybs.401.1662637885111; Thu, 08
 Sep 2022 04:51:25 -0700 (PDT)
MIME-Version: 1.0
References: <20220906102154.32526-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20220906102154.32526-2-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <8ecb62b7-53c4-1c43-65b3-567d8c12e131@microchip.com> <CAOnJCUKLpRz4Fbx1XiMnap-ELw2k1c8E9V8bZiSP+x7z9Z5QrA@mail.gmail.com>
 <f362eaeb-6ccd-4392-a346-55fa5ae25e13@microchip.com> <OS0PR01MB5922833FDCA60892191B211A86409@OS0PR01MB5922.jpnprd01.prod.outlook.com>
In-Reply-To: <OS0PR01MB5922833FDCA60892191B211A86409@OS0PR01MB5922.jpnprd01.prod.outlook.com>
From:   "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date:   Thu, 8 Sep 2022 12:50:58 +0100
Message-ID: <CA+V-a8uttuVd5_UXvNjXU6yG-GpmxG-BuEAm9pWxx13PjZ-h5w@mail.gmail.com>
Subject: Re: [RFC PATCH 1/2] riscv: vendors: andes: Add support to configure
 the PMA regions
To:     guoren@linux.alibaba.com,
        "Conor.Dooley@microchip.com" <Conor.Dooley@microchip.com>
Cc:     "atishp@atishpatra.org" <atishp@atishpatra.org>,
        Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        "paul.walmsley@sifive.com" <paul.walmsley@sifive.com>,
        Biju Das <biju.das.jz@bp.renesas.com>,
        "palmer@dabbelt.com" <palmer@dabbelt.com>,
        "aou@eecs.berkeley.edu" <aou@eecs.berkeley.edu>,
        "atishp@rivosinc.com" <atishp@rivosinc.com>,
        "apatel@ventanamicro.com" <apatel@ventanamicro.com>,
        "geert+renesas@glider.be" <geert+renesas@glider.be>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
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

Hi Guo,

> > -----Original Message-----
> > From: Conor.Dooley@microchip.com <Conor.Dooley@microchip.com>
> > Sent: 08 September 2022 00:38
> > To: atishp@atishpatra.org
> > Cc: Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>;
> > paul.walmsley@sifive.com; palmer@dabbelt.com; aou@eecs.berkeley.edu;
> > atishp@rivosinc.com; apatel@ventanamicro.com; geert+renesas@glider.be;
> > linux-riscv@lists.infradead.org; linux-renesas-soc@vger.kernel.org;
> > linux-kernel@vger.kernel.org; prabhakar.csengg@gmail.com; Biju Das
> > <biju.das.jz@bp.renesas.com>
> > Subject: Re: [RFC PATCH 1/2] riscv: vendors: andes: Add support to
> > configure the PMA regions
> >
> > On 07/09/2022 22:52, Atish Patra wrote:
> > > EXTERNAL EMAIL: Do not click links or open attachments unless you know
> > > the content is safe
> > >
> > >
> > > On Tue, Sep 6, 2022 at 3:40 AM <Conor.Dooley@microchip.com
> > > <mailto:Conor.Dooley@microchip.com>> wrote:
> > >
> > > On 06/09/2022 11:21, Lad Prabhakar wrote:
> > >
> > >> diff --git a/arch/riscv/include/asm/sbi.h
> > >> b/arch/riscv/include/asm/sbi.h index 2a0ef738695e..10a7c855d125
> > >> 100644 --- a/arch/riscv/include/asm/sbi.h +++
> > >> b/arch/riscv/include/asm/sbi.h @@ -37,6 +37,7 @@ enum sbi_ext_id {
> > >>
> > >> /* Vendor extensions must lie within this range */
> > >> SBI_EXT_VENDOR_START = 0x09000000, +       SBI_EXT_ANDES =
> > >> 0x0900031E, SBI_EXT_VENDOR_END = 0x09FFFFFF, };
> > >
I am interested to know what is the status of your patch series [0].

[0] https://lore.kernel.org/lkml/20210606143848.GA5983@lst.de/T/#m7f4c4cdfb92d6c8672bbfabebda729ce4700e177

Cheers,
Prabhakar
