Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D506C4D1485
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 11:14:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345680AbiCHKPl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 05:15:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345627AbiCHKPi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 05:15:38 -0500
Received: from mail-yw1-x1132.google.com (mail-yw1-x1132.google.com [IPv6:2607:f8b0:4864:20::1132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 866993B2B5
        for <linux-kernel@vger.kernel.org>; Tue,  8 Mar 2022 02:14:41 -0800 (PST)
Received: by mail-yw1-x1132.google.com with SMTP id 00721157ae682-2dbd97f9bfcso195420977b3.9
        for <linux-kernel@vger.kernel.org>; Tue, 08 Mar 2022 02:14:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WTPf4+AOQGgbq7pMLk9eUh6WofGxRz5W+7NnL1Nfx+w=;
        b=nD1K+wHr6IgLBaC/CEXc+rLxJKRnZZ1emaCQCpniaLobfFEnYkfAOZmr72z4E9XcSM
         xTh9kEXLOAasKxtA7DHHunHD9FmhgnrPrNpQy0ho+TA+0EStSDo6abRcWN/2waFLOTw1
         eYwwHuToPXLkH4WhsS6DD17G5ETsOgn0F30vlq4lx4s5u+ZUSrHS1lUTNJJGULAGPgp1
         yT2ZP7Fg7o706oPj0+9eSXpd9IRJTQb6PKOYiNI99AKe82Dd0HCXzN6hQ2xbqeuuqyE5
         KlHEsdy861WQqj/WyA4Ax39y4KN5LtDK6hEUMxYRaMVGJYbini/hor6VMaUmmhLlW46S
         HoxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WTPf4+AOQGgbq7pMLk9eUh6WofGxRz5W+7NnL1Nfx+w=;
        b=KORgU5Six8eLguef82pDWFdmviyWLxe30Wu6fibquuP0hcz46BxXeaNTjxTVvSQ3Rm
         ZJbrAXrsV6VpyMCUC1NGRB8EhLRyODCElp7tcZxlpTE6bAoMa5o7O8U0olh1xp4HGBVl
         ApfxLkw93JYLAyElAMBJqwifcct7VN4wEZZNPyz3lqJWDSLEimzEJY3f7ceRzPC9tAZp
         yJJ8RG6PnOqLb+qo8ZGDWGoFLvu63AO+ieTWEuPwrfrkPVeGj9CweBOtVxseiAWf3td9
         8Fpx7CLfe+he2Y7TUWT6zJ20gKxt19GmAdrKEqd3Nw8YG69QjmBTSpi38usTLbymfoYc
         1f3w==
X-Gm-Message-State: AOAM533iAhF/gW7NPU71S8MIuRQ99yEDxEuPgtWahjRvFgZCalR1wj+u
        qZO+ejdkEu2l1ssj15ZcpbrZvOLuwZ1svZpsagU=
X-Google-Smtp-Source: ABdhPJwRLVYHk2Npb0af852mSLIdZ3RDcTpKcdFz2Chf2AUpX1Sy47x88bfN+DwaMxxV0PH3S9bayd6VWjaEaKZpGW0=
X-Received: by 2002:a81:8306:0:b0:2dc:2180:c754 with SMTP id
 t6-20020a818306000000b002dc2180c754mr12062055ywf.70.1646734480705; Tue, 08
 Mar 2022 02:14:40 -0800 (PST)
MIME-Version: 1.0
References: <20220308092047.1008409-1-butterflyhuangxx@gmail.com> <YicoOC+WZhNLq+pX@kroah.com>
In-Reply-To: <YicoOC+WZhNLq+pX@kroah.com>
From:   butt3rflyh4ck <butterflyhuangxx@gmail.com>
Date:   Tue, 8 Mar 2022 18:14:31 +0800
Message-ID: <CAFcO6XMy+rT_cnw2Q7Jzg=byKWQ8tcVU+8ZBCCfTD1-JNy7oLw@mail.gmail.com>
Subject: Re: [PATCH] virt: acrn: fix a memory leak in acrn_dev_ioctl()
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     fei1.li@intel.com, LKML <linux-kernel@vger.kernel.org>
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

No, not yet. I just code audit.

Regards,
 butt3rflyh4ck.

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



-- 
Active Defense Lab of Venustech
