Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32778598E2A
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Aug 2022 22:39:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245215AbiHRUhQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Aug 2022 16:37:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237730AbiHRUhN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Aug 2022 16:37:13 -0400
Received: from mail-yw1-x1135.google.com (mail-yw1-x1135.google.com [IPv6:2607:f8b0:4864:20::1135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7352CD2B1C
        for <linux-kernel@vger.kernel.org>; Thu, 18 Aug 2022 13:37:12 -0700 (PDT)
Received: by mail-yw1-x1135.google.com with SMTP id 00721157ae682-32a09b909f6so73296317b3.0
        for <linux-kernel@vger.kernel.org>; Thu, 18 Aug 2022 13:37:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=te30C2IAdz2ie8EgRg97JfclKhmQvdhP0CAG9MwGiPg=;
        b=R8BGKbrQWN9tKOcihZmAg+481uKcV+OrvDznnerC6qC6pL2xBHBXXndxqzS8/fowr1
         T5dUS5lTNiKtuylWqThnPxXZyZmA4U5WqQBKreC5PqBXUr4X06tW/mJsIL31bXftTA/K
         w2ETjeB7y1blHFegoa7rqwiJTLATsCgCqBQzDiIYxiFhH878Q9+fEPiQjJ0LwFAWfVYo
         8xFz9Rb8CJlseioN5hhIkvKmtKp8vArQ3d8LWeJr5efKz1Mp3lXjXFoEA36g4lpwh+7N
         C8cVSNP5wnUOI7jYVAcCqbcPFPMvqh3SAlc2k/BGECepzkzCK3/xxk0+dyHkg85IHjrs
         xylg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=te30C2IAdz2ie8EgRg97JfclKhmQvdhP0CAG9MwGiPg=;
        b=2rDpq3ifsWqFo+nyJ9DAiogoc9MD4K0mtsaOTpQw5FB33MC+xe3eeVKYcGs/d7/AJi
         4gPquMroXCHxP4Fpvs45byWhIoGGtYlkgsKo6fBZ00/Mw4u5WktqPaS477y4hfLFjt4v
         Y0MOjWbZJjXhWET5GCNSal6UoP0QRXth/wE6rt8o3NWjYmo9IKjfP+8/4tzf6sE2l4H6
         GkS/D8vic3ST7IfD4pLOA7mXXSsY4DA7GfYRBmL4eBQBMrLb/ognl/uZgMHC7hni8Z94
         cRRxryBiyFK9emri8xuwetqiMKGseI4KtBg/+VCasiVQyh7actT2nY+yFP+EOgXUP1tk
         0i2A==
X-Gm-Message-State: ACgBeo1874+QWCx1RjgH8c9QjZU8U7N0i5YS5d83KH3N4h7pqGS9uWUM
        jF84sM6CfQtkQd1eMIBVe4XJxf3LyoHcpgHlXhk=
X-Google-Smtp-Source: AA6agR4IbvQyTpxWSObecVxKV+yoUtdTEEwH2SEHW57LLRtwAGw54BL9LoY9/YxK2Eg7HJB+oTRVTzUx3IRAnksYHN0=
X-Received: by 2002:a81:99d7:0:b0:336:f7d3:8b4b with SMTP id
 q206-20020a8199d7000000b00336f7d38b4bmr3408213ywg.194.1660855031685; Thu, 18
 Aug 2022 13:37:11 -0700 (PDT)
MIME-Version: 1.0
References: <YvvHK2zb1lbm2baU@debian> <20220817071048.4v66zky5qysn45wq@houat>
In-Reply-To: <20220817071048.4v66zky5qysn45wq@houat>
From:   Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Date:   Thu, 18 Aug 2022 21:36:35 +0100
Message-ID: <CADVatmOKemXQbRpJeeqR2NbWMkUc9U09xrch=OpDkxFXqbH8XA@mail.gmail.com>
Subject: Re: drm warning with mainline due to 467e30171b5b ("drm/vc4: hdmi:
 Move HDMI reset to pm_resume")
To:     Maxime Ripard <maxime@cerno.tech>
Cc:     Dave Stevenson <dave.stevenson@raspberrypi.com>,
        Emma Anholt <emma@anholt.net>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
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

On Wed, Aug 17, 2022 at 8:10 AM Maxime Ripard <maxime@cerno.tech> wrote:
>
> Hi,
>
> On Tue, Aug 16, 2022 at 05:34:51PM +0100, Sudip Mukherjee (Codethink) wrote:
> > Not sure if it has been reported but the mainline kernel shows a drm warning
> > on RPI4B.
> >
> > [   14.821276] WARNING: CPU: 3 PID: 187 at drivers/gpu/drm/vc4/vc4_hdmi_regs.h:487 vc5_hdmi_reset+0x1f8/0x240 [vc4]

<snip>

> >
> > git bisect pointed to 467e30171b5b ("drm/vc4: hdmi: Move HDMI reset to pm_resume")
> > and reverting this commit has fixed the warning.
> >
> > I will be happy to test any patch or provide any extra log if needed.
>
> We have fixes for this in drm-misc-next that have missed the cut for the
> merge window:
>
> https://lore.kernel.org/all/20220629123510.1915022-38-maxime@cerno.tech/
> https://lore.kernel.org/all/20220629123510.1915022-39-maxime@cerno.tech/
>
> If it fixes it for you, I'll apply it to drm-misc-fixes

Thanks. With these two patches applied on top of the latest mainline,
I don't see the warning anymore.

Tested-by: Sudip Mukherjee <sudip.mukherjee@codethink.co.uk>


-- 
Regards
Sudip
