Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DB3D56B738
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jul 2022 12:24:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237661AbiGHKWp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jul 2022 06:22:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237345AbiGHKWo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jul 2022 06:22:44 -0400
Received: from mail-yw1-x1134.google.com (mail-yw1-x1134.google.com [IPv6:2607:f8b0:4864:20::1134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39FDC1C917
        for <linux-kernel@vger.kernel.org>; Fri,  8 Jul 2022 03:22:43 -0700 (PDT)
Received: by mail-yw1-x1134.google.com with SMTP id 00721157ae682-2ef5380669cso194039497b3.9
        for <linux-kernel@vger.kernel.org>; Fri, 08 Jul 2022 03:22:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XZ4IbpkhTt7N5QdvdcRfv0LETZPalI9AnqCWUmPEgog=;
        b=X3O0NXyho2Ze70IR2+FhfW0cRMjUsjsmkHjyiiNZ2Ph1zTaLUx4Nz1WJ20nk9BBS8E
         Rr3plbtojjCdfENUItK5Ik0H64DQqJzGPLyJTWWnAWObahAwp+bpglbZBepGzeouMp0c
         cFPcoohMwZCTsbQn/gyLHeFmNaRqnxANrSF28HFe56kgUwVPGOj3A0mgeRB9TQv4ErKT
         zttGd0xDSPSXPTYLAA2rk/ZspSRi96vEp5Wl+VG/gjNep7XzG6pywaoUIFTH4rHLprAb
         bI7BExV8B83ZaROMgzzPQFAumDbnSrx90e5VP4Dkc1D89VpEZuPEI3ME5ANp0Haia8jG
         RY/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XZ4IbpkhTt7N5QdvdcRfv0LETZPalI9AnqCWUmPEgog=;
        b=2/GUDGuKzZyyZHpZBKxLjDwLNqYG6qOLOtomOYmm92ZJpUHrhUkzaGeUSTosgAhA6C
         ZX9iyfIsFmNDrRsOwDq0MGL/NCaltmQKGrVrlPDnqo5G+bGKFHLGyw26T7EpQYLEJCwk
         HYisx4W4Mnc6HqARTAOzJECosJ5zB4VVzEUEAz1sIUmW8pV0ihUBCLAcu50ODddj9fGI
         KFM0mPD2R9xGbFvaG/uH8ymCU0uYwMHPdHb1dEn+L1RiLEWrlErJRW3TGi2I1W8QYc+1
         M6uGr5bsdzgxuWFq97Ma2Scy6NmHYt/ewWb2oZOI7pGwuJS+ktdS/8P4DUzEPUg9jXR8
         AQBQ==
X-Gm-Message-State: AJIora/ZNPztWUF44FxhdUiQa7dgw71NcO3jQ97gQhivwnEsllNjNXgD
        2pYG2o3gntMQz848J52UzAFhK4MLRPhHn8vopU8=
X-Google-Smtp-Source: AGRyM1tl6c85dccTAnzvDTTnQkyHZS0mobUXNvZdBvp7v+R3SZa6ILtw7kdYwTzsLgFK9dnfMyZhIYJxwyBJJk2Mdso=
X-Received: by 2002:a81:72c4:0:b0:31c:b309:c4e8 with SMTP id
 n187-20020a8172c4000000b0031cb309c4e8mr3133190ywc.520.1657275762117; Fri, 08
 Jul 2022 03:22:42 -0700 (PDT)
MIME-Version: 1.0
References: <20220707091301.1282291-1-cezary.rojewski@intel.com>
In-Reply-To: <20220707091301.1282291-1-cezary.rojewski@intel.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Fri, 8 Jul 2022 12:22:05 +0200
Message-ID: <CAHp75VceKBoxXVPP4dRYb8LQqHMMDHFp6-E2iuZ-h2RTK8PWQQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] lib/string_helpers: Introduce strsplit_u32()
To:     Cezary Rojewski <cezary.rojewski@intel.com>
Cc:     Andy Shevchenko <andy@kernel.org>, Mark Brown <broonie@kernel.org>,
        ALSA Development Mailing List <alsa-devel@alsa-project.org>,
        Takashi Iwai <tiwai@suse.com>,
        Jaroslav Kysela <perex@perex.cz>,
        amadeuszx.slawinski@linux.intel.com,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Hans de Goede <hdegoede@redhat.com>,
        =?UTF-8?Q?P=C3=A9ter_Ujfalusi?= <peter.ujfalusi@linux.intel.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        Bard Liao <yung-chuan.liao@linux.intel.com>
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

On Thu, Jul 7, 2022 at 11:03 AM Cezary Rojewski
<cezary.rojewski@intel.com> wrote:
>
> Add strsplit_u32() and its __user variant to allow for splitting
> specified string into array of u32 tokens.

And I believe we have more of this done in old code.
Since all callers use ',' as a delimiter, have you considered using
get_options()?

> Originally this functionality was added for the SOF sound driver. As
> more users are on the horizon, relocate it so it becomes a common good.

Maybe it can be fixed just there.

-- 
With Best Regards,
Andy Shevchenko
