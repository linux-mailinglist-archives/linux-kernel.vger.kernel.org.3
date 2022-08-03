Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45AA2588F33
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Aug 2022 17:16:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236221AbiHCPQI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Aug 2022 11:16:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232272AbiHCPQG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Aug 2022 11:16:06 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAE265F46
        for <linux-kernel@vger.kernel.org>; Wed,  3 Aug 2022 08:16:02 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id f22so10883287edc.7
        for <linux-kernel@vger.kernel.org>; Wed, 03 Aug 2022 08:16:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=3YBGLkEwVoW2LvMmulWhsVedej5Z16WRTdg7cXlL6ZM=;
        b=FAmdOiYinoDcAA+TehBhqXwLHOb5zIazpi+mrI1vLtK/rnldnfEHhN5ZH30Fdx9a4m
         Y0255Pf9D10Wbh9iRwbIRfvKgsQliOtPODqyA4i/tIBke1EZl7wEkOy4GmCqQs3cL9Cj
         NuVHiYQCFX0pAAw/b+vVjNC3cHK2mBmsAv4u0dXyTy4HPDChtjYyZQ23UWJp9SnA4Rki
         3BJRG5OGqgZLde8JlaKhROSyDJyzRI8x8af8/JzTomoTuKXes2zitp478Yqan9WiOrrA
         BN4AoIYT4Kjjqh56tAkMFbcEap9vnaKqkArGWSwQPfFEZdNgVratpkOnkk5GwMJPJChI
         MmDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=3YBGLkEwVoW2LvMmulWhsVedej5Z16WRTdg7cXlL6ZM=;
        b=T1sUyYed699N91ZdxCiJy076DGeqe2yRb/NFLKpEzXPQZ8sg34fKmnl+MC7jNZQFGt
         zrLnQayJY2d2UE9t/34AgEvsAG/EpavUBFh7s2wSpprWczD5ndD//2jmOr1EGoBqWMOR
         cuNetOaPjGvOFuuAoI7teLAa8d7f8CEn24Z9ukam/sP+Jq4dQDeC2Dlh0CmceB1dYq0C
         8ucoINtg5NsgJxjco2CFjSNG9x9kjpuThrZeoESQGrraxgiiqiS/vNc2R4oirBv2LQ8u
         PuFWViDqmqBEgcUu6WydrJNpTzcnGRJp9wv4/dRun7QTekz9O5x5IxbtTO/a+J3PwbO1
         OIiA==
X-Gm-Message-State: ACgBeo3zxyVEv0Hus4tpTOk9+KuJjkd1U058kfy83/d2/5oX5U6GZshK
        5gprgxN7IkNbRdLwArFlHyi/PF0VsS85w9Tr0vPBQA==
X-Google-Smtp-Source: AA6agR4x6DtXirRxnhTcls5sJ1R5pcmz41UUXPIYNZ/mJKy08n/wCbqtZlcFh9LoYFeOtjo6MIlDSO9MH73iYHQ787g=
X-Received: by 2002:a05:6402:2790:b0:43e:5a76:4d20 with SMTP id
 b16-20020a056402279000b0043e5a764d20mr1877144ede.175.1659539761132; Wed, 03
 Aug 2022 08:16:01 -0700 (PDT)
MIME-Version: 1.0
References: <20220803010139.GA32634@rajth-NUC10i7FNH> <YuoJceCfuJ4RKon5@lahna>
In-Reply-To: <YuoJceCfuJ4RKon5@lahna>
From:   Benson Leung <bleung@google.com>
Date:   Wed, 3 Aug 2022 08:15:49 -0700
Message-ID: <CANLzEkucqXP6fU1OZ0+B4p10SXiR7-BJa+dn5xjp20UhE8UsEg@mail.gmail.com>
Subject: Re: [PATCH] Supporting wake on DP hot events behind TBT/USB4 routers
To:     Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     Rajat Khandelwal <rajat.khandelwal@intel.com>,
        andreas.noever@gmail.com, michael.jamet@intel.com,
        YehezkelShB@gmail.com, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, pmalani@google.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mika,

On Tue, Aug 2, 2022 at 10:37 PM Mika Westerberg
<mika.westerberg@linux.intel.com> wrote:
>
> Hi,
>
> On Wed, Aug 03, 2022 at 06:31:39AM +0530, Rajat Khandelwal wrote:
> > Current implementation doesn't allow user to go into system suspend
> > and simultaneously project the screen on an external display connected
> > to a TBT/USB4 device. This patch enables this feature.
> >
> > Let me know what you think about this.
>
> Please prefix patches to follow the sybsystem style. For Thunderbolt it
> should be "thunderbolt: ....".
>
> This will cause any monitor plug to wake up the system and I'm not sure
> we want that, at least to be default behaviour. If you have a regular
> Type-C (non-USB4/TBT) dock and you plug in a monitor to that, does it
> wake up?

Speaking for Google and our ChromeOS USB-C policy, yes, if the host is
in S0iX or S3, an already attached USB-C docking station in DP Alt
Mode will respond to a display attach via HPD via an Alert message in
USB PD. We called this feature wake-on-dock.

We implemented wake-on-dock for DP Alt Mode in the EC, since our EC
handles USB PD anyway, and is handling the PD Alert message which
contains the HPD status.

However, when the dock supports USB4 or Thunderbolt, those modes don't
involve USB PD for device attach, so our EC doesn't have the role of
waking the system, so something else on the system must, which is this
feature being discussed.

>
> IIRC I already suggested you to do this for the USB4 ports themselves
> (struct usb4_port) so that userspace can make them wake up the system on
> any event by writing "enabled > .../wakeup" which is the normal way.

Yes, I would support making this toggle-able like other wakeup sources.

-- 
Benson Leung
Staff Software Engineer
Chrome OS Kernel
Google Inc.
bleung@google.com
Chromium OS Project
bleung@chromium.org
