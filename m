Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC40056BF4F
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jul 2022 20:35:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238996AbiGHQuJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jul 2022 12:50:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238909AbiGHQuG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jul 2022 12:50:06 -0400
Received: from mail-yw1-x112a.google.com (mail-yw1-x112a.google.com [IPv6:2607:f8b0:4864:20::112a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC2292CCB7
        for <linux-kernel@vger.kernel.org>; Fri,  8 Jul 2022 09:50:05 -0700 (PDT)
Received: by mail-yw1-x112a.google.com with SMTP id 00721157ae682-31c89111f23so153509027b3.0
        for <linux-kernel@vger.kernel.org>; Fri, 08 Jul 2022 09:50:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=LaMBIefLyrWIZ2KZH3vrySSwBs8YIATiA1SUOo0jUEk=;
        b=kQcH4jPoCGp9lpWPfnBqA8M4TYbwkC2rLOQjvC8rlBMkMveIVZyPRnm0+QVVJSk6Ye
         WFduDaZinYYHf0w2QyMNJWQ1NIiJ6zhkfKadzwP/1xY4dnWlAV4OV/Odr0QzQM4Blk4r
         vZnom6p24eTvTGXD/77BaiFfBUUG9WGTqRmZ4Jd4kWR6F3u1tVMbMRApX5IgVckjJgy2
         KBp1YFYz0ETJ5iJrmXGBJmqM6JtHErBIOOd2nf4sy6wGlNhwNAgvf82a7uL+vvdYGfin
         fBuSyQo/xwCw9M1L+sXRh+yd3IlRCGF4CZlGrcpsSsogFl2hTlILi8jpVGcAtNeWqUSl
         xXdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=LaMBIefLyrWIZ2KZH3vrySSwBs8YIATiA1SUOo0jUEk=;
        b=6pBSuvXsGfHafLBVJc2aZoRyzjtROKgahC4Yw2C36vrfg9cvAWalqqQYbOyEpKtyMa
         8In5TfCtOECCXdyc8WIu84cpQbaa/TwgGH7Avtw37+8+dje7nq5AYjmvOkmBB0I1nZ+g
         ByLaU1upS0JW8k9xkyDvzbvZlSwbQltnuDLDgyQAmeY19vqQnc/fccoi8MWaRnaa/yxF
         RJKY41xZuI9/67tZlHw2ZONj8lW5YhjZl5x+EZtYlEbAjAUM03YQUElcw0cb6WCaF4ob
         rN1qHYvXmQKY/sBrEfERokgJPMg72FmR1PEaKczsn3cW5m2ZgDxBkdSdhB3VfELn8gZ+
         azww==
X-Gm-Message-State: AJIora9fD8RKKkV2rlO80tFCxssmPXNw1l+v20kC8kye1MKsJFyaY5gB
        swKkYKsKy/Wy3JfXoJ54mQMlevF3oAmByb70KzI=
X-Google-Smtp-Source: AGRyM1tZlRngOGhokxDZmr1qD7HVrtiCVQ9gBovI9Z7DDmmuzaLt5cP5jAfxbLydF4YD2WWIPe7PJYFzWZHtVmC6G94=
X-Received: by 2002:a81:108f:0:b0:31c:d7ae:9ff1 with SMTP id
 137-20020a81108f000000b0031cd7ae9ff1mr4939212ywq.18.1657299005058; Fri, 08
 Jul 2022 09:50:05 -0700 (PDT)
MIME-Version: 1.0
References: <20220707091301.1282291-1-cezary.rojewski@intel.com>
 <CAHp75VceKBoxXVPP4dRYb8LQqHMMDHFp6-E2iuZ-h2RTK8PWQQ@mail.gmail.com>
 <e0c7d254-ace3-625c-cc83-52ca0b45e9fc@intel.com> <CAHp75VckU2ZraLJ-frjWXjUu9pFW+-XmWgTbYqUXOUNAD-1HGA@mail.gmail.com>
 <6c8e4104-2239-a188-649d-585f059cabdd@intel.com> <YsgjdKEtE7pMDTnZ@smile.fi.intel.com>
 <a73b3ec0-5abb-ddfd-414b-b9807f05413e@linux.intel.com> <CAHp75Vd4D0KF7ik+aMOwv-+bofWja_tDe4YUmihQBF+RiHZTmA@mail.gmail.com>
 <e2fe6351-f9ee-48eb-ad7f-280249f7f3f7@intel.com>
In-Reply-To: <e2fe6351-f9ee-48eb-ad7f-280249f7f3f7@intel.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Fri, 8 Jul 2022 18:49:27 +0200
Message-ID: <CAHp75VfvN-iJTpgg6JeKhOqJLhtYSieo7d7SOCBoUu-81FtSqg@mail.gmail.com>
Subject: Re: [PATCH 1/2] lib/string_helpers: Introduce strsplit_u32()
To:     Cezary Rojewski <cezary.rojewski@intel.com>
Cc:     =?UTF-8?Q?P=C3=A9ter_Ujfalusi?= <peter.ujfalusi@linux.intel.com>,
        Andy Shevchenko <andy@kernel.org>,
        Mark Brown <broonie@kernel.org>,
        ALSA Development Mailing List <alsa-devel@alsa-project.org>,
        Takashi Iwai <tiwai@suse.com>,
        Jaroslav Kysela <perex@perex.cz>,
        amadeuszx.slawinski@linux.intel.com,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        Bard Liao <yung-chuan.liao@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 8, 2022 at 6:32 PM Cezary Rojewski
<cezary.rojewski@intel.com> wrote:
>
> On 2022-07-08 5:25 PM, Andy Shevchenko wrote:
> > On Fri, Jul 8, 2022 at 2:34 PM P=C3=A9ter Ujfalusi
> > <peter.ujfalusi@linux.intel.com> wrote:

> A long shot, but what if we were to modify get_options() so it takes
> additional element-size parameter instead?

But why? int / unsigned int, u32 / s32  are all compatible in the current c=
ases.

--=20
With Best Regards,
Andy Shevchenko
