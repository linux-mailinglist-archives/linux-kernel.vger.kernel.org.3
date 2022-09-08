Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD1535B20E1
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 16:41:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231739AbiIHOlO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Sep 2022 10:41:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231572AbiIHOkp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Sep 2022 10:40:45 -0400
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com [IPv6:2607:f8b0:4864:20::b2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B895EB847;
        Thu,  8 Sep 2022 07:40:16 -0700 (PDT)
Received: by mail-yb1-xb2e.google.com with SMTP id a67so15049129ybb.3;
        Thu, 08 Sep 2022 07:40:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=P6etuL406xLRhT6RqJwslD+tK1bv2bUyoaOC1vIESrQ=;
        b=O7auhBhG7nxbGY34/Uxjtdn3WKa+7mB6yfQqIFe4x0OwSVxuqbTI0a7XpqHZl+qGjl
         v/ztxcw4PGowK8XQDZJ85NQsGMFU+nhf+4Rj6XloT7dXP6SKyIuTcDO1CWY+MG8maIts
         vu4AGwuE9yPyNwiToDAW6uOq2n4ZfgTiaTE1BEW8EQzTAenoM5lN/YtoAbSgid/W9UcZ
         KMh1dco6H3N68pTCN/vGZuauX05Pg3FspKaE80UDKPtfwR2N8LffSYUjhADQW2NMHlpD
         KRyAK9Ni45PHdEY6JlRZ0RgKUJs8OcVXqZRLhYeAXAIokd3607h/95knWVh8afYsysxc
         s2ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=P6etuL406xLRhT6RqJwslD+tK1bv2bUyoaOC1vIESrQ=;
        b=Nhukm0YAvJsfznbgQShTaD10vZjjg/CuiTqMMjAHJlrX1dDHmbCHWYbOXn/xfo9pAD
         aekDOMtkRooNK6GEazgYhnXgvG9iz5SVRiR0kk9ni/V6TGs3LtRGrw9BL2XjbCJGYBUh
         aL+iMzrbV6166LuwMebpv9O0vqqAX4LsOQANVUN+FBXjSIT5VpWf9kFNkfYfIL+Wkpxm
         GOnGGlLOdLZkOM48L4PSw4F8bZblvH/3ohrlRPVMNhpmXrAqQ54K0BvI2ULq6LRRS536
         rRg/aY8rVwcDOyRiu9FbdSOwosUU6xhAWjr+szis702R2QyVptkZ10eArEM05lwhYG7b
         95wg==
X-Gm-Message-State: ACgBeo3TbKdwvdvSxezfG9sbJQAPLVRYbJ4vGRz//JXcQUwwpoH9R9St
        TO0Vu7G56IxXyubvYmyxMveNlbCl6LDSHttbfRE=
X-Google-Smtp-Source: AA6agR7UZHUk270jZt+chAm9rm9ZheP07KjHt6vNXD9pMgs6BeYqfa8JQMvKdUhJpTPAuGK13ZGmu2capesX8rTXTyE=
X-Received: by 2002:a25:83d2:0:b0:696:1071:1a01 with SMTP id
 v18-20020a2583d2000000b0069610711a01mr7807235ybm.335.1662648015777; Thu, 08
 Sep 2022 07:40:15 -0700 (PDT)
MIME-Version: 1.0
References: <20220906102154.32526-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20220906102154.32526-2-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <8ecb62b7-53c4-1c43-65b3-567d8c12e131@microchip.com> <CAOnJCUKLpRz4Fbx1XiMnap-ELw2k1c8E9V8bZiSP+x7z9Z5QrA@mail.gmail.com>
 <f362eaeb-6ccd-4392-a346-55fa5ae25e13@microchip.com> <OS0PR01MB5922833FDCA60892191B211A86409@OS0PR01MB5922.jpnprd01.prod.outlook.com>
 <5e894d87-8abb-540d-fbd6-8a1d6f9d0e91@microchip.com> <OS0PR01MB5922F6CC81114BCE7696BEDB86409@OS0PR01MB5922.jpnprd01.prod.outlook.com>
 <02df5db7-99bc-5476-2530-4237c3904933@microchip.com>
In-Reply-To: <02df5db7-99bc-5476-2530-4237c3904933@microchip.com>
From:   "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date:   Thu, 8 Sep 2022 15:39:49 +0100
Message-ID: <CA+V-a8sBvS6Xp0vEV__GTMu-qqy3QJoFzr+F42tL7jkTDszWYA@mail.gmail.com>
Subject: Re: [RFC PATCH 1/2] riscv: vendors: andes: Add support to configure
 the PMA regions
To:     Conor Dooley <Conor.Dooley@microchip.com>,
        Palmer Dabbelt <palmer@dabbelt.com>
Cc:     Biju Das <biju.das.jz@bp.renesas.com>, atishp@atishpatra.org,
        guoheyi@linux.alibaba.com, guoren@linux.alibaba.com,
        "Lad, Prabhakar" <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
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

On Thu, Sep 8, 2022 at 3:04 PM <Conor.Dooley@microchip.com> wrote:
>
> On 08/09/2022 14:01, Biju Das wrote:
> > EXTERNAL EMAIL: Do not click links or open attachments unless you know the content is safe
> >
> > Hi Conor,
> >
> > Thanks for the feedback.
> >
> >> Subject: Re: [RFC PATCH 1/2] riscv: vendors: andes: Add support to
> >> configure the PMA regions
> >>
> >> On 08/09/2022 09:39, Biju Das wrote:
> >>> EXTERNAL EMAIL: Do not click links or open attachments unless you know
> >>> the content is safe
> >>>
> >>> Hi Conor, Atish,
> >>>
> >>> What RISC-V devices you have?
> >>
> >> A bunch ;)
> >>
> >> A __couple__ PolarFire SoC boards, HiFive Unleashed, D1 Nezha, Canaan
> >> k210 MAIX something & the VisionFive.
> >
> > If standard DMA api works without any issue means, on these platforms
> > IO Coherence port is enabled in the hardware. So all peripherals
> > involving DMA work as expected.
> >
> >>> Ours is RISC-V uniprocessor without IO Coherence Port.
> >>
> >> What does "IO Coherence Port" mean? Zicbo*?
> >
> > The HW will provide coherency between CPU and peripheral.
> >
> > If Zibco* is uniprocessor, then highly it may not have IO coherence
> > Port enabled in their design.
>
> Zicbo* are cache management extensions as Geert pointed out.
>
> >
> > Guo, Please confirm.
> >
> >>
> >>> Currently USB, ethernet, SDHI/eMMC doesn't work with standard DMA
> >>> api's.
> >>
> >> Sounds pretty similar to the D1 so.
> >>
> >>> On RISC-V world, how do we handle DMA api for uniprocessor without IO
> >>> Coherence Port?
> >>
> >> If you do mean Zicbo* you're into errata territory there & I don't know
> >> if that'll be acceptable upstream - not for me to make that call...
> >
> > It is not errata for sure. It is a HW design where we don't have
> > IO cache coherency port enabled in the HW. So looks like it is not
> > an extension or errata but it is core stuff.
>
> If you do non-coherent stuff that is not Zicbo*, the precedence set by
> the D1 is errata. As I said to Prabhakar earlier, do a
> `git grep "ERRATA_THEAD*`. I am not a maintainer so I don't know the
> "rules" about doing cache management without the dedicated extensions
> are.
>
Maybe we could have a discussion about this topic at LPC too ;)

Cheers,
Prabhakar
