Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8987B53087C
	for <lists+linux-kernel@lfdr.de>; Mon, 23 May 2022 06:48:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349241AbiEWErT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 May 2022 00:47:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229948AbiEWErO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 May 2022 00:47:14 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47E3426116
        for <linux-kernel@vger.kernel.org>; Sun, 22 May 2022 21:47:13 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id pq9-20020a17090b3d8900b001df622bf81dso12572763pjb.3
        for <linux-kernel@vger.kernel.org>; Sun, 22 May 2022 21:47:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CCd/pDk/Xk+019KXS57x+NXHFX4o0pmZ9eQN5FcIC0o=;
        b=A+RvI1aM4kHHzoMhgrE6eDXv2Y5GsECvz92Cw+GcuYV4Omq/K7+tDGsEbedIQ8AAyT
         uQoi+IDyqFU4tThm45EWDbVwoTW/rW4z3LLOv5Kh0BDxXgW3+eU7WOz0TtHQkXndXOz7
         xDUIXbhHB5Uuge0ymRKxJmCFIKDb4PC9e2CKvKYyu8JcC4s2TFIXUY04kMEntBl7FLHj
         i3DBSWXF/dUqNQ8Lbj/FcSHvKH3sKtcIS0PhiX/DSP5IXNTs18nt18adQG36+H9LzA7g
         Zcsm03GKiQ3yVj34ilzz+81sMOP0Cw58YO1s1c5/g7jBcmKB6fFjEgj79SM7BnB+eyEV
         3w8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CCd/pDk/Xk+019KXS57x+NXHFX4o0pmZ9eQN5FcIC0o=;
        b=xRyZ49z5pDb0hLtMa7Yu6PDxgzcUIzzAzxLn2M4b53Ma45XktVwIToFTxcEVjrH+io
         y8ZBRcvcnOV/s6zbR52mOit8dY0TasqGkGM9TaQfotAZSLBmDrOwW+GC7buMZsEeyX/2
         +HlX4LcEuCaBO6NMWR7DqVi/w4Uh/+EAl1RBRUTWRmw4FWpSzQ3RsiKgZrMd76TGpFYL
         VB+DLToIrsgo74fzAyLN00ljKPK+dNd/oAGENIm/t5LS0lbw+LfuWtSQ7tFPqOGHgPYz
         LPAZRjh48ulUW38ilugM8GlK7F0MLiROOwnuTczKoGKDKDzw4hM5Ywzr/6pQxilJeAq/
         rOTQ==
X-Gm-Message-State: AOAM533dd3fJhLu92II0Z5bq6cemKy8PSjlLCGmQdUACSIAYh11XZoS9
        RjeYxh2mw3JpAmZPxuhkuTGqAYPKn/fUo1GkRA==
X-Google-Smtp-Source: ABdhPJx09UBUQIVQuiLOg0AIkNHRaZudxp9clBc+IKxU+EMxNYIARbzBbokph4vjmFyZiEHfj8JYRfGsurIpleTJPHY=
X-Received: by 2002:a17:902:d711:b0:161:f859:bed7 with SMTP id
 w17-20020a170902d71100b00161f859bed7mr13178025ply.31.1653281232821; Sun, 22
 May 2022 21:47:12 -0700 (PDT)
MIME-Version: 1.0
References: <CAMhUBj=5jD5AjyaF8UmMXAZGFnMEgTruFM2KYL3GGZt-ABcHBQ@mail.gmail.com>
 <CACGkMEvgtzUXw9v=cMN3=Mqm9YTp_2bKmc4--q2+BREvgVdeLg@mail.gmail.com>
In-Reply-To: <CACGkMEvgtzUXw9v=cMN3=Mqm9YTp_2bKmc4--q2+BREvgVdeLg@mail.gmail.com>
From:   Zheyu Ma <zheyuma97@gmail.com>
Date:   Mon, 23 May 2022 12:47:01 +0800
Message-ID: <CAMhUBj=rC8ziy5B8cOroeZQW7f+DhsOkCvLWH-L89zx2LZy-Eg@mail.gmail.com>
Subject: Re: [BUG] vDPA/ifcvf: got a warning when removing the module
To:     Jason Wang <jasowang@redhat.com>
Cc:     mst <mst@redhat.com>, Zhu Lingshan <lingshan.zhu@intel.com>,
        Yongji Xie <xieyongji@bytedance.com>,
        Eli Cohen <elic@nvidia.com>, Parav Pandit <parav@nvidia.com>,
        virtualization <virtualization@lists.linux-foundation.org>,
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

On Mon, May 23, 2022 at 12:15 PM Jason Wang <jasowang@redhat.com> wrote:
>
> On Sat, May 21, 2022 at 10:27 PM Zheyu Ma <zheyuma97@gmail.com> wrote:
> >
> > Hello,
> >
> > I found a bug in the ifcvf driver.
> > When removing the module, I got the following warning:
> >
> > [   14.478123] general protection fault, probably for non-canonical
> > address 0xdffffc0000000005: 0000 [#1] PREEMPT SMP KASAN PTI
> > [   14.478701] KASAN: null-ptr-deref in range
> > [0x0000000000000028-0x000000000000002f]
> > [   14.479922] RIP: 0010:vdpa_mgmtdev_unregister+0x39/0x150
> > [   14.484063] Call Trace:
> > [   14.484186]  <TASK>
> > [   14.484292]  ? _raw_spin_unlock_irqrestore+0x3d/0x60
> > [   14.484536]  ifcvf_remove+0x3a/0x50 [ifcvf]
> > [   14.484743]  pci_device_remove+0x92/0x240
> >
> > The reason is that the 'ifcvf_mgmt_dev' is zero which means that
> > ifcvf_vdpa_dev_add() was not executed.
> > Since I am not familiar with the driver, I cannot find a proper solution for it.
> >
>
> Looks like the drv data needs to be set in probe(). Could you pleas
> try to the attached patch? (compile test only).

This patch works for me, thanks!

Tested-by: Zheyu Ma <zheyuma97@gmail.com>

Regards,
Zheyu Ma
