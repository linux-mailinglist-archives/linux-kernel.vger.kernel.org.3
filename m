Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A20AB4D95E1
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Mar 2022 09:04:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345694AbiCOIFY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Mar 2022 04:05:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229500AbiCOIFX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Mar 2022 04:05:23 -0400
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com [IPv6:2607:f8b0:4864:20::b2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68EE436153
        for <linux-kernel@vger.kernel.org>; Tue, 15 Mar 2022 01:04:11 -0700 (PDT)
Received: by mail-yb1-xb2e.google.com with SMTP id j2so35859375ybu.0
        for <linux-kernel@vger.kernel.org>; Tue, 15 Mar 2022 01:04:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sD6Evvt413aW7EC+yE73RQslFqn+KLsEJuMxymm1Z5Y=;
        b=lbgYwm1J3dzPB+Mm9vFE1RZvYUlB/QzsWhDPdMhrpe7tv0gszPoAUQ/2Ow50+wg3Gu
         rTKBGtWPHpbEvU03dwwJZEGuXbRHb1fLkyMw0uNtkFDXeGJKmbPV0sSR3MWkNJsGmSqH
         yfE4ngOiNG9Hi6MN1HYuJVM0a5Aj5nibrU83XJh0RSc6OVEO2/nX3QlbySpp0Ho4nhnG
         Bf3fm4QNKkS3BzAtg0E06i+wqhjuPfuCbo917Y98SV4f+3Fy2UWhavoEAKs07QJvbiCb
         JF1xYNRFe16WB3wm6xHMR16qhQtJkOdwyNjjiuifNf3ExhRW6ZFBSSIkadbJec3MkAds
         W59A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sD6Evvt413aW7EC+yE73RQslFqn+KLsEJuMxymm1Z5Y=;
        b=hJ5abbKhuTCvaNcBdGLooarulA/Ou/yNj0XdxNxdmqr6I2fULY+yjCm0NHw4hhTlPW
         ePpRH/B4LYgqOufrKx/R+jBA9Kyw4dRurkPa4Z0WgVEEZFFM8N4NvbNklBhl3zjA0RS9
         VRpBb1oE/98eOBDP2Pa0NZkqUOTKiVxdS10ldBtk+oTd86Ft7jQ1g5ml0lSHFGCb7hz+
         jqKMiTgk2gxS9ESjRIu5vx58CZwtZh6nPP6nJDFlnCkx6SAH5oNFNQgbTv/58wqpe+Wo
         S4FAlOd+aa47BXYjAfNf/58wO1Tfh7EvePSvFXZPMy7qh+A0e7RGV5vsPJHog2sStbuP
         pCDQ==
X-Gm-Message-State: AOAM531t4Xwoh9q3/wZ5eJVmAlGZXyBZ1Aa2rGjDVw7yYjkTiimFup00
        gYwR2KXDMbieBa3NHN4QFSN1I06X99bWTM6xUvw=
X-Google-Smtp-Source: ABdhPJyDGUEvbfBl30FsyFaGE2MtCeKED4B7uUPZYu4/kqMLipYMj9fNkeNCU3BN4fCRpy448TlpriaSUFv3x176Npg=
X-Received: by 2002:a25:af83:0:b0:633:73fb:ff57 with SMTP id
 g3-20020a25af83000000b0063373fbff57mr2275237ybh.46.1647331450663; Tue, 15 Mar
 2022 01:04:10 -0700 (PDT)
MIME-Version: 1.0
References: <20220308092047.1008409-1-butterflyhuangxx@gmail.com> <YicoOC+WZhNLq+pX@kroah.com>
In-Reply-To: <YicoOC+WZhNLq+pX@kroah.com>
From:   butt3rflyh4ck <butterflyhuangxx@gmail.com>
Date:   Tue, 15 Mar 2022 16:04:01 +0800
Message-ID: <CAFcO6XO9JMMyWmiuR9mP0S7vxjeBHA+KT6vwCg3pqnqy-vnMxA@mail.gmail.com>
Subject: Re: [PATCH] virt: acrn: fix a memory leak in acrn_dev_ioctl()
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Li Fei1 <fei1.li@intel.com>, LKML <linux-kernel@vger.kernel.org>
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

On Tue, Mar 8, 2022 at 5:56 PM Greg KH <gregkh@linuxfoundation.org> wrote:
>
> On Tue, Mar 08, 2022 at 05:20:47PM +0800, Xiaolong Huang wrote:
> > The vm_param and cpu_regs need to be freed via kfree()
> > before return -EINVAL error.
> >
> > Fixes: 9c5137aedd11 ("virt: acrn: Introduce VM management interfaces")
> > Fixes: 2ad2aaee1bc9 ("virt: acrn: Introduce an ioctl to set vCPU registers state")
> > Signed-off-by: Xiaolong Huang <butterflyhuangxx@gmail.com>
> > Signed-off-by: Fei Li <fei1.li@intel.com>
> > ---
> >  drivers/virt/acrn/hsm.c | 20 +++++++++++++++-----
> >  1 file changed, 15 insertions(+), 5 deletions(-)
> >
> > diff --git a/drivers/virt/acrn/hsm.c b/drivers/virt/acrn/hsm.c
> > index 5419794fccf1..423ea888d79a 100644
> > --- a/drivers/virt/acrn/hsm.c
> > +++ b/drivers/virt/acrn/hsm.c
> > @@ -136,8 +136,10 @@ static long acrn_dev_ioctl(struct file *filp, unsigned int cmd,
> >               if (IS_ERR(vm_param))
> >                       return PTR_ERR(vm_param);
> >
> > -             if ((vm_param->reserved0 | vm_param->reserved1) != 0)
> > +             if ((vm_param->reserved0 | vm_param->reserved1) != 0) {
> > +                     kfree(vm_param);
> >                       return -EINVAL;
> > +             }
> >
> >               vm = acrn_vm_create(vm, vm_param);
> >               if (!vm) {
> > @@ -182,21 +184,29 @@ static long acrn_dev_ioctl(struct file *filp, unsigned int cmd,
> >                       return PTR_ERR(cpu_regs);
> >
> >               for (i = 0; i < ARRAY_SIZE(cpu_regs->reserved); i++)
> > -                     if (cpu_regs->reserved[i])
> > +                     if (cpu_regs->reserved[i]) {
> > +                             kfree(cpu_regs);
> >                               return -EINVAL;
> > +                     }
> >
> >               for (i = 0; i < ARRAY_SIZE(cpu_regs->vcpu_regs.reserved_32); i++)
> > -                     if (cpu_regs->vcpu_regs.reserved_32[i])
> > +                     if (cpu_regs->vcpu_regs.reserved_32[i]) {
> > +                             kfree(cpu_regs);
> >                               return -EINVAL;
> > +                     }
> >
> >               for (i = 0; i < ARRAY_SIZE(cpu_regs->vcpu_regs.reserved_64); i++)
> > -                     if (cpu_regs->vcpu_regs.reserved_64[i])
> > +                     if (cpu_regs->vcpu_regs.reserved_64[i]) {
> > +                             kfree(cpu_regs);
> >                               return -EINVAL;
> > +                     }
> >
> >               for (i = 0; i < ARRAY_SIZE(cpu_regs->vcpu_regs.gdt.reserved); i++)
> >                       if (cpu_regs->vcpu_regs.gdt.reserved[i] |
> > -                         cpu_regs->vcpu_regs.idt.reserved[i])
> > +                         cpu_regs->vcpu_regs.idt.reserved[i]) {
> > +                             kfree(cpu_regs);
> >                               return -EINVAL;
> > +                     }
> >
> >               ret = hcall_set_vcpu_regs(vm->vmid, virt_to_phys(cpu_regs));
> >               if (ret < 0)
> >
> > base-commit: 5859a2b1991101d6b978f3feb5325dad39421f29
> > --
> > 2.25.1
> >
>
> How did you test this?

Ok, thanks.  Firstly there is just some
parameter that should be freed before func returns the -EINVAL error
in the patch. I think it was correct, no need to test it. And
secondly the commitor
Li Fei1 also reviewed the patch code. finally I am sorry that  no arcn
hso hardware to test it.

Regards,
  butt3rflyh4ck.

-- 
Active Defense Lab of Venustech
