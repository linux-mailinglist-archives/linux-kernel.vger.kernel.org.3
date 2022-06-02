Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D01F453B8D3
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Jun 2022 14:11:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234900AbiFBMLk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Jun 2022 08:11:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234866AbiFBMLf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jun 2022 08:11:35 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4774B2A46CD
        for <linux-kernel@vger.kernel.org>; Thu,  2 Jun 2022 05:11:32 -0700 (PDT)
Received: from mail-yb1-f174.google.com ([209.85.219.174]) by
 mrelayeu.kundenserver.de (mreue009 [213.165.67.97]) with ESMTPSA (Nemesis) id
 1MNKuI-1o8MdV1EwU-00OoGc for <linux-kernel@vger.kernel.org>; Thu, 02 Jun 2022
 14:11:31 +0200
Received: by mail-yb1-f174.google.com with SMTP id p13so7958425ybm.1
        for <linux-kernel@vger.kernel.org>; Thu, 02 Jun 2022 05:11:31 -0700 (PDT)
X-Gm-Message-State: AOAM5332DSVrLNjoXGkq92HKjSld1ARP8j/ygbicaRY3c+ryvCNy00gY
        L9NJqJvph4YmNSU4zlTSEA5um7szVePDCl1DM0M=
X-Google-Smtp-Source: ABdhPJxdzkEsdk/cr6/xiJljnwPhNiCbf+6LHxcrbl85hSAm1vRzepzJQWXT9pLy21Z0VxV9G2hS1yUr8gN67lDPmso=
X-Received: by 2002:a25:db8a:0:b0:65c:b04a:f612 with SMTP id
 g132-20020a25db8a000000b0065cb04af612mr4808103ybf.106.1654171890125; Thu, 02
 Jun 2022 05:11:30 -0700 (PDT)
MIME-Version: 1.0
References: <CAK8P3a2Zg2QDS1_Ysn8-Zqqd+K7bbTFS7JV7gPabp6nvPiKaog@mail.gmail.com>
 <91E67F46-A3C7-4159-9E0C-C6C6306F3669@inria.fr> <CAK8P3a2iAsemAQdbTZ_E7GGGCXAOeWbjSjLgXEsd5sg_buZWhw@mail.gmail.com>
 <CAHk-=wgO0V9OdY+DFm-f0qZYMyFSm0ptReO+_qgSTEpBLtFV7Q@mail.gmail.com>
 <d971a684-ccd9-3839-1e30-c166fd55cf49@inria.fr> <CAHk-=wiViikY0szsJGipSxFmMwdsvxjm7SwDfwNfMHYvQ64kAA@mail.gmail.com>
 <CAK8P3a1m80u+eVnoSJ-APihjNQ1se9=FG+E6tKBb-hRJx5FAVg@mail.gmail.com> <74bed19a-713f-1a25-8142-cf32984beada@I-love.SAKURA.ne.jp>
In-Reply-To: <74bed19a-713f-1a25-8142-cf32984beada@I-love.SAKURA.ne.jp>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Thu, 2 Jun 2022 14:11:13 +0200
X-Gmail-Original-Message-ID: <CAK8P3a02fpOPkXSEEd2eDoryVN2zZcRvzJ2qRceAQmCqB8ghag@mail.gmail.com>
Message-ID: <CAK8P3a02fpOPkXSEEd2eDoryVN2zZcRvzJ2qRceAQmCqB8ghag@mail.gmail.com>
Subject: Re: mainline build failure due to f1e4c916f97f ("drm/edid: add EDID
 block count and size helpers")
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Keisuke Nishimura <keisuke.nishimura@inria.fr>,
        Kentaro Takeda <takedakn@nttdata.co.jp>,
        Ayush Sawal <ayush.sawal@chelsio.com>,
        Vinay Kumar Yadav <vinay.yadav@chelsio.com>,
        Rohit Maheshwari <rohitm@chelsio.com>,
        Julia Lawall <Julia.Lawall@inria.fr>,
        Jani Nikula <jani.nikula@intel.com>,
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
        SoC Team <soc@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:fIlLPdr/4OZ8rVJ2kwQu6HHZYAbGdFKL3Cb7NA7NYcngY4Tbs+Y
 tqRPESUoFoxViK0GddRpAG7jHjWKaEuMZ7nSHdliRFon0mQnDapxka6hdvrRjYSrTiWJT0/
 dDqPPI1y1TYUf+OrTTWFB9dm4ScwaKhf2XB3pYKs4968AcrXj5wa7q4aZi7v4rNxQ6vU3Gz
 47ie4gF44pgLP8e+ssabA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:M8M6zndQz70=:sHl0XjMebMBpN+cZpq8Jle
 WnUVcHzvWYUDlhRY4G0daC8Xe/IteKSFJ0YGEkWKSuvTlfEz1TDdSn/3C+ZgVNepG+LxvVNln
 UQDaxYLxrqVZ+VlblnJCdnZ4zAhDRPLijCXgyzdD6gdwU18CSwsSdz9lXtrWn0xCyenwDeA4n
 QPQKRLKTXDoreYAae+DITfZoyRf1b0LMsUjaBikGT4N5/QsMLaIboAlTW6mhQfXMBdDOJv8mQ
 Idc90zhRaaHamiWSygDmGoCQcErb5kOz0M9wMCmZgR9Ig81EvHpyR4uXssai/7jcdyWbnCnrK
 ka1T/JhTzly8lA60T3l/SdBh90iDXwnY1MlV6TpMRWPhEsOe+C7F9euXcgEhPmu/nl0N+JCPR
 tGG92HQP2cQfsCKFLlQMidLAwBM3e+WIKHHUMa82ESH/KjxVsDIPfhwlZzIhKl9mPgOyuSlGV
 8/ZSHswN6G5zy7cwm4h7zoq508TyINPzT5ia759RCstJAhfGDqQ9TCLO0ydBVDIURlzZ05kaU
 SJJt9nqG9fd8CRT/xaNPbso808zLWbx2KncytLgXcJSBq+H6qv3S3ZPW1SqaDh0aMCuHcAZ4n
 SiCYsM9LFmVuOEVBACGPO6QDcZmefFgCX9Hxh6EGBgjdjXy/wmaQGxClFWxchbJ/F/Ojdbmbl
 yAsaJKkmc2VzPpObj332iO93VUC8IwlRXbbwra1Noh7YRcJkak/fc3N2m4DY6FvqVZ2/VWp0Z
 IEfvTuMkct0a7BKTbhZFPKHVzUZ4knmfaLrBm//W2sLVsSCke9xttVDlB/HV6bYLvJYovlZ3p
 jFKwyeodwJ2UCf0x6tT8Il4nNnGAdy9CdIybw4Eqq227dyfvMPnIJwTAlU6qP/f8OOQ1Zzrtd
 kIyxGwmX9AT3svCrFTZA==
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 2, 2022 at 1:21 PM Tetsuo Handa
<penguin-kernel@i-love.sakura.ne.jp> wrote:
> On 2022/06/02 16:38, Arnd Bergmann wrote:
> >> But let's cc the tomoyo and chelsio people.
> >
> > I think both of them work because the structures are always
> > embedded inside of larger structures that have at least word
> > alignment. This is the thing I was looking for, and the
> > __packed attribute was added in error, most likely copied
> > from somewhere else.
>
> The __packed in "struct tomoyo_shared_acl_head" is to embed next
> naturally-aligned member of a larger struct into the bytes that
> would have been wasted if __packed is not specified. For example,
>
> struct tomoyo_shared_acl_head {
>         struct list_head list;
>         atomic_t users;
> } __packed;
>
> struct tomoyo_condition {
>         struct tomoyo_shared_acl_head head;
>         u32 size; /* Memory size allocated for this entry. */
>         (...snipped...)
> };
>
> saves 4 bytes on 64 bits build.
>
> If the next naturally-aligned member of a larger struct is larger than
> the bytes that was saved by __packed, the saved bytes will be unused.

Ok, got it. I think as gcc should still be able to always figure out the
alignment when accessing the atomic, without ever falling back
to byte access on an atomic_get() or atomic_set().

To be on the safe side, I would still either move the __packed attribute
to the 'list' member, or make the structure '__aligned(4)'.

       Arnd
