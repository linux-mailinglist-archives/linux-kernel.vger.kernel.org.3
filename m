Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3FA2246E2EC
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Dec 2021 08:08:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233502AbhLIHLq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Dec 2021 02:11:46 -0500
Received: from muru.com ([72.249.23.125]:36310 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231572AbhLIHLo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Dec 2021 02:11:44 -0500
Received: from localhost (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id E1C8B80A3;
        Thu,  9 Dec 2021 07:08:51 +0000 (UTC)
Date:   Thu, 9 Dec 2021 09:08:08 +0200
From:   Tony Lindgren <tony@atomide.com>
To:     Yongqin Liu <yongqin.liu@linaro.org>
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        linux-omap@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Gowtham Tammana <g-tammana@ti.com>,
        Jyri Sarha <jsarha@ti.com>
Subject: Re: [PATCH v2 1/1] ARM: dts: dra7: add entry for bb2d module
Message-ID: <YbGrWGuIWdMNqNqU@atomide.com>
References: <20210921071807.30978-1-narmstrong@baylibre.com>
 <20210921071807.30978-2-narmstrong@baylibre.com>
 <YV1UdSVOrZ3B9pq/@atomide.com>
 <CAMSo37UN78k=WE0CwRyNNV3P9kau+JzVZ7mHOMMvh5Bn=+=jAQ@mail.gmail.com>
 <78b51650-0e32-e81f-0191-2222580e7343@baylibre.com>
 <CAMSo37X1BA1cYYxwjWBo_dhjpGYuYD2KK00+3ZWAwNeJq8UfxQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMSo37X1BA1cYYxwjWBo_dhjpGYuYD2KK00+3ZWAwNeJq8UfxQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Yongqin Liu <yongqin.liu@linaro.org> [211123 17:27]:
> Hi, Neil
> 
> On Tue, 23 Nov 2021 at 20:47, Neil Armstrong <narmstrong@baylibre.com> wrote:
> >
> > Hi,
> >
> > On 23/11/2021 13:17, Yongqin Liu wrote:
> > > Hi, Neil, Tony
> > >
> > > # sorry for the confusion if you have received the mail which I sent
> > > before, which is not in plain text mode.
> > >
> > > We have one out of tree change to enable the SGX544 gpu for the
> > > beagleboard-X15 Android build,
> > >     https://android-review.linaro.org/c/kernel/common/+/20521/11/arch/arm/boot/dts/dra7.dtsi
> > >
> > > and that seems to conflict with this BB2D enabling change,
> > > Could you please help give some suggestions on how we should update our patch
> > > to make it work with BB2D, without the revert of this change?
> >
> > This BB2D patch alters the target-module@59000000 while your SGX
> > change alters the target-module@56000000.
> >
> > Please rebase your patches.
> I am sorry if the "conflict" I used previously caused the confusion.
> What I meant with the "conflict" word is the feature conflict, not the
> patch merge conflict.
> 
> I could merge my SGX change with the BB2D change there, but then my
> build could not boot successfully to the homescreen,
> I need to revert the BB2D change to have it boot to the homescreen successfully.
> 
> Here are the serial console output in case you want to check:
> https://pastebin.com/RY472b96  work with the BB2D change reverted
> https://pastebin.com/aP97r7rJ    does not work with the BB2D change.
> 
> Not sure if you have any idea about the problem.
> Please help give some suggestions on what I could try.

Sounds like your out of tree SGX patches also tinker with the BB2D module.

To me it sounds like you can just tag the new target-module@59000000 added
by this patch with status = "disabled" in your SGX patch until you have
updated the driver code.

I'm adding this patch into omap-for-v5.17/dt as for 2D acceleration there
is the etnaviv driver in the mainline kernel that should be usable to
some extent.

Regards,

Tony


