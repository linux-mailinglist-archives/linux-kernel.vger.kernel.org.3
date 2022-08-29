Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C32CA5A418B
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Aug 2022 05:43:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229486AbiH2Dnd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 Aug 2022 23:43:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbiH2Dna (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Aug 2022 23:43:30 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A9CC2B610
        for <linux-kernel@vger.kernel.org>; Sun, 28 Aug 2022 20:43:28 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id z2so8581294edc.1
        for <linux-kernel@vger.kernel.org>; Sun, 28 Aug 2022 20:43:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=morsemicro-com.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=Nwpbs0K4MoaHLEivXoiUzT3Zh8lHJPxRGl3AaGXaDhg=;
        b=jTZDkb4QuQpgB1nU+yGNrKoXT/GguRdiMt77lLsVdyDpGMO/SlCpLakTWk9cxxCpkY
         2vBzy4ad2oyywSET0uKuDFVXkTrcCfuM1eOOoJQGiO//lVnttHDcxiz54gHgQiPN6Vvn
         nKi11JoGkZi6i5lQqs9Lq67m8k0f9/HaV2F4nltJ2BGDPp4takwYauvEmBGrN96dY/ba
         hQgvEcHUG57/viKyZm+Lpfq9/b9OfGDlbmcSWazjKBowrdnnh52pIHimYN9ltfCeJ95g
         dV09Vm43XhRVM7+f5vCghu3n1adnn0XauBL0uLTBg/hBQJ8JgTxpIzvBW0ZWY89GzuyO
         d/ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=Nwpbs0K4MoaHLEivXoiUzT3Zh8lHJPxRGl3AaGXaDhg=;
        b=HJijMjZ/ApB4fXwChQogq6TRe158MUSEodB+SERFlwyeRriefzIqCdIjt/hndiS/72
         dLESIKjBBweznMSfr42sgxWcGxzE6pFn5ejVD3jCtwqTUwSGj8C9jY23jVfeoJkKHF3o
         n2eFDxobA8Wyk2j5aEJufCWi9d9xCYB8lp5rVqKleswON38NpQTKii/1JSmD3HoxBSiI
         3PXIr7SQqLrWkLn6nF+YzjGDmoX7DHUe+4bVOrvo5oaqfL2OERS6kI6FmWmxsfY/e4Ag
         E7gjB4k8ZZoE+ZBTWdtzVv34XlzLdUolEP0vB0/yj7IOBHMiLDAURuWkvihTeKVOSEmK
         MhTA==
X-Gm-Message-State: ACgBeo34ffYCgg0x/AIxx8Fy44ZfvQmap9VQWGWvIzSAdc+/3Vjll/1e
        Fibbkp7Rd5Sh0pXM0eq6qeLQZldokJIfFdYYAD+Vlw==
X-Google-Smtp-Source: AA6agR4ZIgZ2j+dIc72VoA09K5TXz8V4lttQDeN00DtTTplOg8FfS3G6hbr8lzbqlfLQqdVb1JK06WDmU6noNjcw+XA=
X-Received: by 2002:a05:6402:24a4:b0:440:8c0c:8d2b with SMTP id
 q36-20020a05640224a400b004408c0c8d2bmr14446911eda.311.1661744607092; Sun, 28
 Aug 2022 20:43:27 -0700 (PDT)
MIME-Version: 1.0
References: <20220810224804.2137240-1-gilad.itzkovitch@morsemicro.com> <f97efe8ff5f466ce938f38dc26cb76c7abcc5a71.camel@sipsolutions.net>
In-Reply-To: <f97efe8ff5f466ce938f38dc26cb76c7abcc5a71.camel@sipsolutions.net>
From:   Gilad Itzkovitch <gilad.itzkovitch@morsemicro.com>
Date:   Mon, 29 Aug 2022 15:43:16 +1200
Message-ID: <CAG_xHGO1GvSy0pC=xNfBGyAin9b58k+b78+7gWv1YoOuQ9OAHQ@mail.gmail.com>
Subject: Re: [PATCH] wifi: ieee80211: Fix for fragmented action frames
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Johannes,

On Thu, Aug 25, 2022 at 8:08 PM Johannes Berg <johannes@sipsolutions.net> wrote:
>
> On Thu, 2022-08-11 at 10:48 +1200, Gilad Itzkovitch wrote:
> > The robust management frame check ensures a station exists for
> > the frame before proceeding, but there are some action frame
> > categories which don't require an existing station, and so the
> > _ieee80211_is_robust_mgmt_frame function peeks into the
> > action frame's payload to identify the category and filter them out.
> >
> > In some scenarios, e.g. DPP at S1G data rates, action frames
> > can get fragmented. This commit adds an extra check to ensure
> > we don't peek into the payload of fragmented frames beyond the
> > first fragment.
> >
> > Signed-off-by: Gilad Itzkovitch <gilad.itzkovitch@morsemicro.com>
> > ---
> >  include/linux/ieee80211.h | 12 ++++++++++++
> >  1 file changed, 12 insertions(+)
> >
> > diff --git a/include/linux/ieee80211.h b/include/linux/ieee80211.h
> > index 55e6f4ad0ca6..5da9608fdce3 100644
> > --- a/include/linux/ieee80211.h
> > +++ b/include/linux/ieee80211.h
> > @@ -4124,6 +4124,7 @@ static inline bool _ieee80211_is_robust_mgmt_frame(struct ieee80211_hdr *hdr)
> >
> >       if (ieee80211_is_action(hdr->frame_control)) {
> >               u8 *category;
> > +             u16 sc;
> >
> >               /*
> >                * Action frames, excluding Public Action frames, are Robust
> > @@ -4134,6 +4135,17 @@ static inline bool _ieee80211_is_robust_mgmt_frame(struct ieee80211_hdr *hdr)
> >                */
> >               if (ieee80211_has_protected(hdr->frame_control))
> >                       return true;
> > +
> > +             /*
> > +              * Some action frames do not have a STA associated with them,
> > +              * so we rule them out from the robust management frame check.
> > +              * The category is within the payload, so we only proceed if
> > +              * we're checking the first fragment.
> > +              */
> > +             sc = le16_to_cpu(hdr->seq_ctrl);
> > +             if (sc & IEEE80211_SCTL_FRAG)
> > +                     return false;
> >
>
>
> This doesn't make much sense to me - why would it be allowed or
> necessary to call this function on a frame that wasn't yet defragmented?
>
> johannes

That was partially our understanding. But, the fragmented action frame is
being dropped by this function as it is part of the provisioning DPP process
(fragmented due to S1G low rates).
Trying to avoid a big change here for this specific action category.
As defragmentation will occur later on in the process there should be a
safe way to avoid dropping the frame beforehand.

Gilad
