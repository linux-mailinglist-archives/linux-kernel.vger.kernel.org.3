Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B46A589899
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Aug 2022 09:44:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239147AbiHDHoP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Aug 2022 03:44:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232405AbiHDHoL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Aug 2022 03:44:11 -0400
Received: from mail-oa1-x30.google.com (mail-oa1-x30.google.com [IPv6:2001:4860:4864:20::30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E8AE61D7A
        for <linux-kernel@vger.kernel.org>; Thu,  4 Aug 2022 00:44:10 -0700 (PDT)
Received: by mail-oa1-x30.google.com with SMTP id 586e51a60fabf-10ee900cce0so11481908fac.5
        for <linux-kernel@vger.kernel.org>; Thu, 04 Aug 2022 00:44:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=nUEU9o3cM5Kmc1EYUHE1SdxMORqRyA15fSC0pKpPPpA=;
        b=jVbav0mnsWsmRr52DoW67vlijQQnljhaeszrKNhLr83Axf0fna1SYSOT3MH0d0MK6u
         02BjMQtbZNTJ/rD7EqzpxDxQC1nq5KS/970y+cya2OAJlN6pnJdtHbBIQys7TNkYday8
         yHJoJEHUod6fFDYx++GjLc/1FAAAKyQ+W95EqhbumVIJR3JJvY8gMzQ4tpebokMw9wJx
         ip3sf17OpIilVpv7envx6eQlptwYXeT3eAM9XukxQ4WuAtYjDD1ZlD/2kht9MLrs1vYI
         1mH2/0m3hpqdosozylFFtMisZnwJUnCJs2INlP2lPLWMBbGxFqtq3BcUk0Ks4ilWxkAa
         6bvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=nUEU9o3cM5Kmc1EYUHE1SdxMORqRyA15fSC0pKpPPpA=;
        b=FrPZfvXrNe4pDG5jGp4CP0V/zxeJl+XvWtcxmFXzaMIQIpLgE/Kot8jWSGA9wJUPF9
         cSg0oFLKLH8PnVeVVKJjph7NLgot7w6/51cszf0AZ/XLWQC2D+r7WnnLcVm9N2kb/IMo
         lutbcTAJh/JRKkdYMUZA8GVAeSp9fkIqQzJSYRvexi6VIWp251wZ5IqLf7HTRPVe/Iai
         RaGNvsl63sE66B0B4toWP3FcN9r2tzLUYV6T9Fa0dAaOh8ZI4Sy04eeaa0deasGhOLQH
         XBJAwLQj+eUBVhVnyFlYgDKJqO6KHfgcoGtUsMdhX17lcPnEBp8WAvlkemRp984NDTRP
         SshQ==
X-Gm-Message-State: ACgBeo1gCn82HpahZCsNYRgqbazeMMd7mdMgIl6fwVGL4T9Z0/dPmY0J
        IonXntQmgOHIsDvGFRwVhvVCKGSFeYFk7/3tpJk=
X-Google-Smtp-Source: AA6agR74w1TmI+hmQCaAYcMZ9/+IS/zunLEqTvdiGsyln1BmvAgTP+erCWXjumNm0tyIR9nEsEsbaVEFOvTPB+auiPY=
X-Received: by 2002:a05:6870:9193:b0:10d:130e:e57c with SMTP id
 b19-20020a056870919300b0010d130ee57cmr3611160oaf.286.1659599049528; Thu, 04
 Aug 2022 00:44:09 -0700 (PDT)
MIME-Version: 1.0
References: <CAFCwf11=9qpNAepL7NL+YAV_QO=Wv6pnWPhKHKAepK3fNn+2Dg@mail.gmail.com>
 <CAPM=9tzWuoWAOjHJdJYVDRjoRq-4wpg2KGiCHjLLd+OfWEh5AQ@mail.gmail.com>
 <CAFCwf12N6DeJAQVjY7PFG50q2m405e=XCCFvHBn1RG65BGbT8w@mail.gmail.com> <CAPM=9txSKv_xwZJ6SndtqsdQm6aK1KJVF91dB5Odhc_Xv6Qdrw@mail.gmail.com>
In-Reply-To: <CAPM=9txSKv_xwZJ6SndtqsdQm6aK1KJVF91dB5Odhc_Xv6Qdrw@mail.gmail.com>
From:   Oded Gabbay <oded.gabbay@gmail.com>
Date:   Thu, 4 Aug 2022 10:43:42 +0300
Message-ID: <CAFCwf10CsLgt+_qT7dT=8DVXsL0a=w=uXN6HC=CpP5EfitvLfQ@mail.gmail.com>
Subject: Re: New subsystem for acceleration devices
To:     Dave Airlie <airlied@gmail.com>
Cc:     dri-devel <dri-devel@lists.freedesktop.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Yuji Ishikawa <yuji2.ishikawa@toshiba.co.jp>,
        Jiho Chu <jiho.chu@samsung.com>, Arnd Bergmann <arnd@arndb.de>,
        "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 4, 2022 at 2:54 AM Dave Airlie <airlied@gmail.com> wrote:
>
> On Thu, 4 Aug 2022 at 06:21, Oded Gabbay <oded.gabbay@gmail.com> wrote:
> >
> > On Wed, Aug 3, 2022 at 10:04 PM Dave Airlie <airlied@gmail.com> wrote:
> > >
> > > On Sun, 31 Jul 2022 at 22:04, Oded Gabbay <oded.gabbay@gmail.com> wrote:
> > > >
> > > > Hi,
> > > > Greg and I talked a couple of months ago about preparing a new accel
> > > > subsystem for compute/acceleration devices that are not GPUs and I
> > > > think your drivers that you are now trying to upstream fit it as well.
> > >
> > > We've had some submissions for not-GPUs to the drm subsystem recently.
> > >
> > > Intel GNA, Intel VPU, NVDLA, rpmsg AI processor unit.
> > >
> > > why is creating a new subsystem at this time necessary?
> > >
> > > Are we just creating a subsystem to avoid the open source userspace
> > > consumer rules? Or do we have some concrete reasoning behind it?
> > >
> > > Dave.
> >
> > Hi Dave.
> > The reason it happened now is because I saw two drivers, which are
> > doing h/w acceleration for AI, trying to be accepted to the misc
> > subsystem.
> > Add to that the fact I talked with Greg a couple of months ago about
> > doing a subsystem for any compute accelerators, which he was positive
> > about, I thought it is a good opportunity to finally do it.
> >
> > I also honestly think that I can contribute much to these drivers from
> > my experience with the habana driver (which is now deployed in mass at
> > AWS) and contribute code from the habana driver to a common framework
> > for AI drivers.
>
> Why not port the habana driver to drm now instead? I don't get why it
> wouldn't make sense?

imho, no, I don't see the upside. This is not a trivial change, and
will require a large effort. What will it give me that I need and I
don't have now ?

>
> Stepping up to create a new subsystem is great, but we need rules
> around what belongs where, we can't just spawn new subsystems when we
> have no clear guidelines on where drivers should land.
>
> What are the rules for a new accel subsystem? Do we have to now
> retarget the 3 drivers that are queued up to use drm for accelerators,
> because 2 drivers don't?
>
> There's a lot more to figure out here than merge some structures and
> it will be fine.
I totally agree. We need to set some rules and make sure everyone in
the kernel community is familiar with them, because now you get
different answers based on who you consult with.

My rules of thumb that I thought of was that if you don't have any
display (you don't need to support X/wayland) and you don't need to
support opengl/vulkan/opencl/directx or any other gpu-related software
stack, then you don't have to go through drm.
In other words, if you don't have gpu-specific h/w and/or you don't
need gpu uAPI, you don't belong in drm.

After all, memory management services, or common device chars handling
I can get from other subsystems (e.g. rdma) as well. I'm sure I could
model my uAPI to be rdma uAPI compliant (I can define proprietary uAPI
there as well), but this doesn't mean I belong there, right ?

>
> I think the one area I can see a divide where a new subsystem is for
> accelerators that are single-user, one shot type things like media
> drivers (though maybe they could be just media drivers).
>
> I think anything that does command offloading to firmware or queues
> belongs in drm, because that is pretty much what the framework does. I
I think this is a very broad statement which doesn't reflect reality
in the kernel.

> think it might make sense to enhance some parts of drm to fit things
> in better, but that shouldn't block things getting started.
>
> I'm considering if, we should add an accelerator staging area to drm
> and land the 2-3 submissions we have and try and steer things towards
> commonality that way instead of holding them out of tree.
Sounds like a good idea regardless of this discussion.

>
> I'd like to offload things from Greg by just not having people submit
> misc drivers at all for things that should go elsewhere.
Great, at least we can agree on that.

Thanks,
Oded

>
> Dave.
>
>
> >
> > Regarding the open source userspace rules in drm - yes, I think your
> > rules are too limiting for the relatively young AI scene, and I saw at
> > the 2021 kernel summit that other people from the kernel community
> > think that as well.
> > But that's not the main reason, or even a reason at all for doing
> > this. After all, at least for habana, we open-sourced our compiler and
> > a runtime library. And Greg also asked those two drivers if they have
> > matching open-sourced user-space code.
> >
> > And a final reason is that I thought this can also help in somewhat
> > reducing the workload on Greg. I saw in the last kernel summit there
> > was a concern about bringing more people to be kernel maintainers so I
> > thought this is a step in the right direction.
> >
> > Oded
