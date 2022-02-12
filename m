Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCB9D4B380F
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Feb 2022 21:54:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231860AbiBLUw6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Feb 2022 15:52:58 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:59864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231812AbiBLUw4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Feb 2022 15:52:56 -0500
Received: from mail-io1-f44.google.com (mail-io1-f44.google.com [209.85.166.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBEF1606EA;
        Sat, 12 Feb 2022 12:52:50 -0800 (PST)
Received: by mail-io1-f44.google.com with SMTP id s18so15542959ioa.12;
        Sat, 12 Feb 2022 12:52:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EaOHzElyl19Lio2+IgXQrdRampgn3IJJk51hhGDrqvQ=;
        b=lg1AvYy9fZrQEDNWMtPVa7VQR/1im6pdmkOxCByxuogTnT6Digp6YIDUe8/RfOWcQt
         EpYLoGOo+HKj8g8VLaEstBQCwy63+OHBHFLux5Tw1ckyt1irbvPq67VKjPFfUPdgb/WS
         qgkYn629dTWv0a99DWcCJ+2NNOGP9t36tcYcZndKL1eN0lxw88u2uaHyCnaMi+vRhyou
         um+qg76vyaql2ViSTBqvpC4UiQQUd0P3ykW0K9zRP1E3PQ3N1FITHBYk2aP1LVjdbIda
         SHaokF84Rz9TQqVMebHYFAX/8QANtUOnl23lGBA6EJzQPqo9ueLvzNox8/6w+lZMebqh
         dNLw==
X-Gm-Message-State: AOAM533aSqEAKNbU7h4xUxLB7yfC9Koru/1rDd2NKNPx8ehh2tKN1QB2
        GHPqRTSQGo6K+b+aO7fMRW8QwEWxqf9LplraZqs=
X-Google-Smtp-Source: ABdhPJx930dZNCBqHCUogbSTyuDbp2FVQxBA/TLL+y3xo4J5StPz1eItQanT5mUqU7fNh7az3GyCJ7Yxv3mwAOSpRYU=
X-Received: by 2002:a05:6638:37a1:: with SMTP id w33mr3957440jal.73.1644699168559;
 Sat, 12 Feb 2022 12:52:48 -0800 (PST)
MIME-Version: 1.0
References: <20220203082546.3099-1-15330273260@189.cn> <20220203082546.3099-2-15330273260@189.cn>
 <20220203085851.yqstkfgt4dz7rcnw@houat> <11ac5696-29e3-fefa-31c0-b7b86c88bbdc@189.cn>
 <20220209084908.kub4bs64rzhvpvon@houat> <84bfb2fc-595c-3bae-e8a0-c19ccbcfcfd8@189.cn>
 <20220209161624.42ijbnhanaaari46@houat>
In-Reply-To: <20220209161624.42ijbnhanaaari46@houat>
From:   Ilia Mirkin <imirkin@alum.mit.edu>
Date:   Sat, 12 Feb 2022 15:52:37 -0500
Message-ID: <CAKb7UvjJHaDtCnLkVpOpxXC90X6o3TLC+EQOmf9g-BPbS-_rHA@mail.gmail.com>
Subject: Re: [PATCH v6 1/3] drm/lsdc: add drm driver for loongson display controller
To:     Maxime Ripard <maxime@cerno.tech>
Cc:     Sui Jingfeng <15330273260@189.cn>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        suijingfeng <suijingfeng@loongson.cn>,
        David Airlie <airlied@linux.ie>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Roland Scheidegger <sroland@vmware.com>,
        linux-mips@vger.kernel.org, Krzysztof Kozlowski <krzk@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Andrey Zhizhikin <andrey.zhizhikin@leica-geosystems.com>,
        Rob Herring <robh+dt@kernel.org>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Sam Ravnborg <sam@ravnborg.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 9, 2022 at 11:16 AM Maxime Ripard <maxime@cerno.tech> wrote:
>
> On Wed, Feb 09, 2022 at 10:38:41PM +0800, Sui Jingfeng wrote:
> > On 2022/2/9 16:49, Maxime Ripard wrote:
> > > On Fri, Feb 04, 2022 at 12:04:19AM +0800, Sui Jingfeng wrote:
> > > > > > +/* Get the simple EDID data from the device tree
> > > > > > + * the length must be EDID_LENGTH, since it is simple.
> > > > > > + *
> > > > > > + * @np: device node contain edid data
> > > > > > + * @edid_data: where the edid data to store to
> > > > > > + */
> > > > > > +static bool lsdc_get_edid_from_dtb(struct device_node *np,
> > > > > > +                                unsigned char *edid_data)
> > > > > > +{
> > > > > > +     int length;
> > > > > > +     const void *prop;
> > > > > > +
> > > > > > +     if (np == NULL)
> > > > > > +             return false;
> > > > > > +
> > > > > > +     prop = of_get_property(np, "edid", &length);
> > > > > > +     if (prop && (length == EDID_LENGTH)) {
> > > > > > +             memcpy(edid_data, prop, EDID_LENGTH);
> > > > > > +             return true;
> > > > > > +     }
> > > > > > +
> > > > > > +     return false;
> > > > > > +}
> > > > > You don't have a device tree binding for that driver, this is something
> > > > > that is required. And it's not clear to me why you'd want EDID in the
> > > > > DTB?
> > > > 1) It is left to the end user of this driver.
> > > >
> > > > The downstream motherboard maker may use a dpi(XRGB888) or LVDS panel
> > > > which don't have DDC support either, doing this way allow them put a
> > > > EDID property into the dc device node in the DTS. Then the entire system works.
> > > > Note those panel usually support only one display mode.
> > > I guess it depends on what we mean exactly by the user, but the DTB
> > > usually isn't under the (end) user control. And the drm.edid_firmware is
> > > here already to address exactly this issue.
> > >
> > > On the other end, if the board has a static panel without any DDC lines,
> > > then just put the timings in the device tree, there's no need for an
> > > EDID blob.
> >
> > Loongson have a long history of using PMON firmware, The PMON firmware
> > support flush the dtb into the the firmware before grub loading the kernel.
> > You press 'c' key, then the PMON will give you a shell. it is much like a
> > UEFI shell. Suppose foo.dtb is what you want to pass to the vmlinuz.
> > Then type the follow single command can flush the dtb into the PMON firmware.
> >
> > |load_dtb /dev/fs/fat@usb0/foo.dtb|
> >
> > For our PMON firmware, it**is**  totally under developer/pc board maker's control.
> > You can flush whatever dtb every time you bootup until you satisfied.
> > It(the pmon firmware) is designed to let downstream motherboard maker and/or
> > customers to play easily.
> >
> > Support of reading EDID from the dtb is really a feature which downstream
> > motherboard maker or customer wanted. They sometimes using eDP also whose
> > resolution is not 1024x768. This is out of control for a graphic driver
> > developer like me.
>
> And, to reinstate, we already have a mechanism to set an EDID, and if it
> wasn't an option, the DT is not the place to store an EDID blob.

Note that it's pretty common on laptop GPUs to have the attached
panel's EDID be baked into the VBIOS or ACPI (for LVDS / eDP). The hw
drivers in question (e.g. nouveau, radeon, probably i915) know how to
retrieve it specially. I'm no DT expert, but I'd imagine that it's
meant to allow mirroring those types of configurations. Stuff like
"drm.edid_firmware" isn't really meant for system-configuration-level
things, more as an out in case something doesn't work as it should.

Cheers,

  -ilia
