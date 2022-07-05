Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5942567293
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jul 2022 17:28:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231634AbiGEP1e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jul 2022 11:27:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231588AbiGEP1d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 11:27:33 -0400
Received: from mail-yw1-x112b.google.com (mail-yw1-x112b.google.com [IPv6:2607:f8b0:4864:20::112b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F0C01903F
        for <linux-kernel@vger.kernel.org>; Tue,  5 Jul 2022 08:27:32 -0700 (PDT)
Received: by mail-yw1-x112b.google.com with SMTP id 00721157ae682-31c86fe1dddso64940567b3.1
        for <linux-kernel@vger.kernel.org>; Tue, 05 Jul 2022 08:27:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5tmiljg3s19ryvEGAW5ii/Nv2+isUFfuDwQcZYBx++w=;
        b=UVo9GPCOUtVCj/emac2wh5qc6SFskMVJi12e4DvMW+/0nQSJQgXdGJ9QX1t7S1svZp
         Kaoz4HbbwMzKV5JqV9Gg5GQHmc9l9PSTSCDpjkUNdS85DLvthUrE8iuInduPTmckvP3u
         +5ioDYcvu5azoRN2PyclToOV3GgPEIqxeLoFP5MYPKhzQ6J0DRAuc2hIAV/YAwlabXbo
         fdlzFegYTwbLKVuY2ZrUd4A92aBCRvi9K/pMh+aYfXMTQfy88UAHug8Xt1dPes1atiNa
         LjdHXw3j/mGY/a0Pml9OCSGX3cavSv/RAdmqXycuGZXjN9z2uy4NhAuTMn3AdAWghVgm
         ozhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5tmiljg3s19ryvEGAW5ii/Nv2+isUFfuDwQcZYBx++w=;
        b=mLi0F+goM5ivUhqifliSXf1c5JbBL95ryJZjv3nJErJH/61MAVbuSPzbJPkhNtDNt3
         sXqZJWc1HnnO+v+NmdiOjrlMdKd/BQES/ruEnNDvBkBumlFVhityTSt2YOeAiVpTRggc
         +WOpjhh/2Ry+/jEFSTny/JP+7FtGvG/IZa/pozXTDZWS150Et8MKFN9lsJMg9p7gaReV
         FlrvNX9sr1MFTmKjhdgIPjMkRNWhT4TovLp6APkUYb4SzNEfW8g8HHb83mRV2M1Y+rSu
         Hy05b2rOLKgajzdRSpp8rAOBOZY7Q0zwVOjiT9uuaomNhcI2LAlC9mkavcygx9PVNp1L
         60Gg==
X-Gm-Message-State: AJIora8sf9kVyCoYOI8iW0Ge2y483Xq52UGOEqG2vcDUCRJEP/if1HCF
        cyNuJOVvPctHUeikSN9/J3Jfb6suWkuqbbuNPR0=
X-Google-Smtp-Source: AGRyM1s29r7HkV/XRQicyYI2gCQx7K2oP+G2em7n4x3kcXxrK/M219ChC74q0E7E22f8P7HAie6Q/9uQqH23jpxqxa8=
X-Received: by 2002:a81:72c4:0:b0:31c:b309:c4e8 with SMTP id
 n187-20020a8172c4000000b0031cb309c4e8mr8101598ywc.520.1657034851419; Tue, 05
 Jul 2022 08:27:31 -0700 (PDT)
MIME-Version: 1.0
References: <20220703143533.62173-1-andriy.shevchenko@linux.intel.com> <38cf149a-6238-241c-8ddd-4e4d10ca1f73@linux.intel.com>
In-Reply-To: <38cf149a-6238-241c-8ddd-4e4d10ca1f73@linux.intel.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 5 Jul 2022 17:26:55 +0200
Message-ID: <CAHp75VcDfGsoyTSp7US2Fmzd=+1J8xbpcAuP7tXOC=C+D9+QSA@mail.gmail.com>
Subject: Re: [PATCH v1 1/1] ASoC: SOF: Intel: bdw: remove duplicating driver
 data retrieval
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mark Brown <broonie@kernel.org>,
        Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
        sound-open-firmware@alsa-project.org,
        ALSA Development Mailing List <alsa-devel@alsa-project.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
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

On Tue, Jul 5, 2022 at 5:02 PM Pierre-Louis Bossart
<pierre-louis.bossart@linux.intel.com> wrote:
> On 7/3/22 09:35, Andy Shevchenko wrote:

...

> Thanks Andy, we have the same code pattern in sound/soc/sof/intel/byt.c,
> can we change it as part of the series to keep the two files aligned?

Sure. I was looking for the ID of WPT SPI (I2S) controller and that's
how I found these two.


-- 
With Best Regards,
Andy Shevchenko
