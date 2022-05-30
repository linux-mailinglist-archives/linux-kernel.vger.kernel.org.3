Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50D385384CF
	for <lists+linux-kernel@lfdr.de>; Mon, 30 May 2022 17:26:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239461AbiE3PZb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 May 2022 11:25:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241804AbiE3PZB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 May 2022 11:25:01 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF424140C5
        for <linux-kernel@vger.kernel.org>; Mon, 30 May 2022 07:27:03 -0700 (PDT)
Received: from mail-yb1-f175.google.com ([209.85.219.175]) by
 mrelayeu.kundenserver.de (mreue011 [213.165.67.97]) with ESMTPSA (Nemesis) id
 1MAwoL-1o705U2mAD-00BNnR for <linux-kernel@vger.kernel.org>; Mon, 30 May 2022
 16:27:01 +0200
Received: by mail-yb1-f175.google.com with SMTP id t31so6376265ybi.2
        for <linux-kernel@vger.kernel.org>; Mon, 30 May 2022 07:27:01 -0700 (PDT)
X-Gm-Message-State: AOAM530iK3Q2mV8VZSC7415vACqiXJ7deUN+Nxd+NCGh1deNO/Jec/+s
        uOOWffgn70Zwp4/0T3M9UwRiZ5pM+8T+1oJ0c9E=
X-Google-Smtp-Source: ABdhPJx5T8sAy2mpNYpXUMEEXXq3paGLe37RJlBPWUL37w/VrSqmqA+dX26yPRFsA+fHHAhbaULTIG1qF0gAbTdb1Dw=
X-Received: by 2002:a25:4f0a:0:b0:64f:6a76:3d8f with SMTP id
 d10-20020a254f0a000000b0064f6a763d8fmr43544693ybb.134.1653920820404; Mon, 30
 May 2022 07:27:00 -0700 (PDT)
MIME-Version: 1.0
References: <YpCUzStDnSgQLNFN@debian> <CAHk-=wg0uGAX5DYZq+tY2KeUAR8DtR91YE1y9CkPMKkKOyE4jg@mail.gmail.com>
 <CADVatmNGPbSdRNQuwJEWAaPtqb3vBYRjvsuBpoRUnhEHj=X5GQ@mail.gmail.com>
 <CAHk-=wisQd8yiPX=SsK3eFiakKo713hq4SyqPWsJ-oyAmLFefQ@mail.gmail.com>
 <YpIR67FMtTGCwARZ@debian> <CAHk-=wjuyHE=1wLgHncub8FfgeyYqfWYsy4-YrhAvq9991h_Aw@mail.gmail.com>
 <CAHk-=wi_hJV0V=Ecg2dzbe2P_H1XKTu6VP_AtCH6u=tis31ayg@mail.gmail.com>
 <CAK8P3a0-QyOQiieEvM0yQb43XbCtPmeao8UvoAsdFnjCxYPz7Q@mail.gmail.com>
 <CAHk-=whfmwzjF4eBPYS6pHFqHVzJF3m=2h=gRWSRyHks8V=ABA@mail.gmail.com>
 <87a6aztli2.fsf@intel.com> <877d63tleq.fsf@intel.com> <CAK8P3a0-S77QLR1dK3NT6ot7JTAD5AdojAZJr-Xi112-v5EOdw@mail.gmail.com>
 <87czfvrwsv.fsf@intel.com> <CAK8P3a0HNOCOSx9UONw6gf1UUU8J4iAOmMFP8-DtJ3O7XAACsQ@mail.gmail.com>
 <874k17ru44.fsf@intel.com>
In-Reply-To: <874k17ru44.fsf@intel.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Mon, 30 May 2022 16:26:43 +0200
X-Gmail-Original-Message-ID: <CAK8P3a2Zg2QDS1_Ysn8-Zqqd+K7bbTFS7JV7gPabp6nvPiKaog@mail.gmail.com>
Message-ID: <CAK8P3a2Zg2QDS1_Ysn8-Zqqd+K7bbTFS7JV7gPabp6nvPiKaog@mail.gmail.com>
Subject: Re: mainline build failure due to f1e4c916f97f ("drm/edid: add EDID
 block count and size helpers")
To:     Jani Nikula <jani.nikula@intel.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        Viresh Kumar <vireshk@kernel.org>,
        Shiraz Hashim <shiraz.linux.kernel@gmail.com>,
        =?UTF-8?B?VmlsbGUgU3lyasOkbMOk?= <ville.syrjala@linux.intel.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        SoC Team <soc@kernel.org>, Julia Lawall <Julia.Lawall@inria.fr>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:GsNo+lmxofIjxKfQ8P/W5vYMLw6wvfExggyZZJBLHymM0U2xCqF
 cxpRJ+VsjR+G/v2AI1vekY7nhm32qhgNDTfnRRMES1bZLtvq3j9ylWbEBxn+eNBwcmwlxoP
 3Pg83FL9wGY6nxqr7sZlorgCf9dc6tpvs3EGxhPPbOCaHT/SODxv+qIS27AhGBLcWNFfOKA
 KQT89jtpp9CxL1rLWkHAQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:VU2d7sJRNV8=:Bb/K79iZoDkd6FMmH6HbZr
 ShzTmmi4LwZ192mHRmZ3E/bDE6RcJY/kLczT9q/T596wCFBUf8pIfkJlG1mYS/zSkPHmi6ZRq
 IEjHfkH+c55EXwx5vlQDkdWuwNvA+g4BLC4Z2eXZsFpeXCUM1iPdwQfQ25kmwzR7holEsuWVm
 kkdcqlDAOQKv0aErxKI1LkS5CBWhb59LJ2+jZ+wzhd1RrcZTeUmdPLUYYGEn08ogIHj32y6PU
 maDeS++VXnS7Ltjl0b1tvH8IsaAMpkVbp4Dvz/iIpo/xeMv1ftETwJaY9T1a5TFhEf2jm9FJc
 +R21QJACaW8P0kcDqxyZ6Aegx3oFgomTKYtmmVanAErV4oBDaxeJQMOwdqMp+25Pd3pNKUZK2
 je+T5kATa3Sb511AmWyANY0JEo8kbJhnXeXl6UqpF95aErZIK1/5V/v91P7nFiqHJIi0FDiSj
 k2nn52NezY02cJmIdyGm2M9kS7b+6gTBroxnNjoM326pQRVXwxtSvuTo7XPE4DcM3+iiYgrks
 ozFP++1g3WrlOiGPK/8+dSElauOyEYwDmTIoztHxvBPacaqiDfcyfy3lUCMlckz3YgNVz57+T
 I0NzhKoqpd7V524JO12hc5iMKQjna/l0Cf9lC4nrcycAkAa1C+MCweVGPP3iPVc378fbdE1Tv
 BtGzSsJsUZTVGxCSuObU248PDkw/Hzt6XcNVtM/vpoJ5qszqQA8a+jxmaN90lcMTWScUmIhMU
 OA7W9zcmiRghRH7MaVPBnGyn5F5APCeOeLBTtcsUi+Wtkmf9mtvM8KkI+FqeJHJnc0l2hmZaq
 I4VxKFtmAlYDOSTnkFG4iEMpl414Oi591niobnfbMtCjpu54KaU3O62z9+AeZ6sp4j/QL0SEI
 F1gjL/J0BPIEyhbIxwliWD8hFV8SNgNnQtvzU1Vds=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 30, 2022 at 4:08 PM Jani Nikula <jani.nikula@intel.com> wrote:
> On Mon, 30 May 2022, Arnd Bergmann <arnd@arndb.de> wrote:
> > struct my_driver_priv {
> >        struct device dev;
> >        u8 causes_misalignment;
> >        spinlock_t lock;
> >        atomic_t counter;
> > } __packed; /* this annotation is harmful because it breaks the atomics */
>
> I wonder if this is something that could be caught with coccinelle. Or
> sparse. Are there any cases where this combo is necessary? (I can't
> think of any, but it's a low bar. ;)
>
> Cc: Julia.

I think one would first have to make a list of data types that are not
meant to be in a packed structure. It could be a good start to
search for any packed aggregates with a pointer, atomic_t or spinlock_t
in them, but there are of course many more types that you won't
find in hardware structures.

> > or if the annotation does not change the layout like
> >
> > struct my_dma_descriptor {
> >      __le64 address;
> >      __le64 length;
> > } __packed; /* does not change layout but makes access slow on some
> > architectures */
>
> Why is this the case, though? I'd imagine the compiler could figure this
> out.

When you annotate the entire structure as __packed without an
extra __aligned() annotation, the compiler has to assume that the
structure itself is unaligned as well. On many of the older architectures,
this will result in accessing the values one byte at a time. Marking
the structure as "__packed __aligned(8)" instead would be harmless.

When I have a structure with a few misaligned members, I generally
prefer to only annotate the members that are not naturally aligned,
but this approach is not very common.

         Arnd
