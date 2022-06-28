Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3585D55E2BA
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:36:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243105AbiF1IbF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jun 2022 04:31:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245258AbiF1IbB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 04:31:01 -0400
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B033626AC5
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jun 2022 01:31:00 -0700 (PDT)
Received: by mail-pg1-x52d.google.com with SMTP id 9so11506959pgd.7
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jun 2022 01:31:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=2TpQEUwBlGb88p4IGzi7coXlKXR6VM/Rxu7edgxZRdk=;
        b=aDHAR+gThE7DCHiMc4w+Xv3mkdu4rkVcgXPF4v+8X8PUvOGiD8/v36X1k4A6RW/uNs
         Wcs/s0KQGad+czgeUL1BFEdgFXjpzIGT9VHf1J3Btmuqn5TWE1SO9k3Ub1Cuj2wPXdjP
         oiHmgyW3Mo1xkPaGmn+cEOLw9ylL/C2D5qGfZNSwOS4wUGIXKAQsYoRB3mscXSt9hez0
         6DsC1Mnw75dCIc/sU+YFSvQTk+9Ik1HJc+8FpUxpk7njKXZhvdr8dGLt8h34iV3XUKkz
         zAJL1cMHV+FtKiGWoDgKggTNoEugbHIL95tfX/HdtkUF9FBTCUSyWxKu+o8Z230rCi/n
         5IJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=2TpQEUwBlGb88p4IGzi7coXlKXR6VM/Rxu7edgxZRdk=;
        b=eLHF4dUEi3xxAJb83BRIqH/r4q0BCJY+yYt3l/krF5ZGbpZPu1t3sBro47hIzXk1ia
         F9+e4Vt10hbg8BxkgTDAD/egwms9xUdtM64ykUHVkfGUsOFxdqsU+eyY4r853RJ/p2BI
         9SiAGAtKbSkqkPfqWFmwMuYUYyKHOfBe/bZxox1rWoGngwK8Z+jh385g/TtI5Sq6/yFw
         uqaxJHZ8st4q7KfEiNQ7P2YZwoGgJCqwpez95Lb+j4TVmXp+rSeTJPbtxkvvzOadcNLv
         XL7q1kqKhL14vCs+wKzLNX7tEML3GwbbJdi7/NVlkoB4p3geW7YhgKSb0iMlRFg64KA6
         mbkA==
X-Gm-Message-State: AJIora8bA6KshoyomLay/4bOzltRFHvZI+EeBPEYNfXxE0HJW7FqlMnZ
        bAHDid4pjQCqJjM6iBr3WHs=
X-Google-Smtp-Source: AGRyM1t7VQLkR1oO3Z/OyJLVwJsR2RoJKs4ViIJTiEBeq57yqGnKG7zKU0eZOc74hdIrVGHSNEbuIg==
X-Received: by 2002:a05:6a00:1489:b0:525:b83f:b32f with SMTP id v9-20020a056a00148900b00525b83fb32fmr3542633pfu.25.1656405059955;
        Tue, 28 Jun 2022 01:30:59 -0700 (PDT)
Received: from localhost ([2409:10:24a0:4700:e8ad:216a:2a9d:6d0c])
        by smtp.gmail.com with ESMTPSA id u9-20020a170902e5c900b0016760c06b76sm250708plf.194.2022.06.28.01.30.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jun 2022 01:30:59 -0700 (PDT)
Date:   Tue, 28 Jun 2022 17:30:57 +0900
From:   Stafford Horne <shorne@gmail.com>
To:     Marc Zyngier <maz@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Openrisc <openrisc@lists.librecores.org>,
        Jonas Bonn <jonas@southpole.se>,
        Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH] irqchip: or1k-pic: Undefine mask_ack for level triggered
 hardware
Message-ID: <Yrq8QaYRfcnRJcKP@antec>
References: <20220628012854.681220-1-shorne@gmail.com>
 <877d512o0a.wl-maz@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <877d512o0a.wl-maz@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 28, 2022 at 09:25:25AM +0100, Marc Zyngier wrote:
> On Tue, 28 Jun 2022 02:28:54 +0100,
> Stafford Horne <shorne@gmail.com> wrote:
> > 
> > The mask_ack operation clears the interrupt by writing to the PICSR
> > register.  This we don't want for level triggered interrupt because
> > it does not actually clear the interrupt on the source hardware.
> > 
> > This was causing issues in qemu with multi core setups where
> > interrupts would continue to fire even though they had been cleared in
> > PICSR.
> > 
> > Just remove the mask_ack operation.
> > 
> > Signed-off-by: Stafford Horne <shorne@gmail.com>
> > ---
> > Note,
> > 
> > I currently have this queued with openrisc fixes for 5.19-rcX.  If this is ok
> > with the IRQ maintainers I would like to have this merged via the OpenRISC
> > queue.
> > 
> >  drivers/irqchip/irq-or1k-pic.c | 1 -
> >  1 file changed, 1 deletion(-)
> > 
> > diff --git a/drivers/irqchip/irq-or1k-pic.c b/drivers/irqchip/irq-or1k-pic.c
> > index 49b47e787644..f289ccd95291 100644
> > --- a/drivers/irqchip/irq-or1k-pic.c
> > +++ b/drivers/irqchip/irq-or1k-pic.c
> > @@ -66,7 +66,6 @@ static struct or1k_pic_dev or1k_pic_level = {
> >  		.name = "or1k-PIC-level",
> >  		.irq_unmask = or1k_pic_unmask,
> >  		.irq_mask = or1k_pic_mask,
> > -		.irq_mask_ack = or1k_pic_mask_ack,
> >  	},
> >  	.handle = handle_level_irq,
> >  	.flags = IRQ_LEVEL | IRQ_NOPROBE,
> 
> Acked-by: Marc Zyngier <maz@kernel.org>
> 
> Feel free to take this via your tree.

Thanks,

-Stafford
