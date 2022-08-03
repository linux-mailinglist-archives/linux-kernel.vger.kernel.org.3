Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 803BF588964
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Aug 2022 11:27:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237329AbiHCJ1G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Aug 2022 05:27:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234150AbiHCJ1D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Aug 2022 05:27:03 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AED7B9FE7;
        Wed,  3 Aug 2022 02:27:02 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id v18so15854099plo.8;
        Wed, 03 Aug 2022 02:27:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=MVm6QmzipnyToLLkHlXgCnRVhkMCCP5rnBDdZpKvHUM=;
        b=hXZI8q8EVU8SnP+ORDIvV8YS5W6ThAdvCpal5haO3s3myszY4AIx/2AF1Ciz0Uvnt4
         MWz6E8S9aUtYAkTjZeVAActQYVZvTZ+euyf4zfac9VcpQqud8mphEd6Qns0QJeaBAWjB
         k0skGVtX6/78MF3JZwg+pbKSrOiWobOPOT0Q3z/UWe+eOtU8Ud+ZoNZ5paubDSba/O6B
         zRSKLoOcDWAXAObyrqRjLc35OdCx3pFFxp+0TUgBHOlJx1WWbLeqBYP4iSuXI0GFdEGE
         nx9WFu+ebFE61JPrLtnW0/9pM85bR/13tElWoiLDr5AOUaQcE35HciNACBuurw8zADuN
         DGXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=MVm6QmzipnyToLLkHlXgCnRVhkMCCP5rnBDdZpKvHUM=;
        b=OaHI/Iu8GFPKyAFZi3licgydONgsuYAylVq2thdVzU6gzDSYb+YHW77eE9aukMgrLW
         iH+AdWZevJJeEgg+1ak34MJxEbni1h/apCzSWIbu6rDilQFlzDH/VWkIvPnMaMYSMcnL
         lxIK5qKOM9lih9JcZaza50T6lF7Dfr5SXYaloXqQEFGsCuqbv8n5EC3yIZFZqT5D3qta
         VcSZTt9G90gpb9C4lndPgTHQIWe5cNY1aT/Se2QecgwGJYVfR8Tbpbc3vj7kSfmaPB4F
         3fyHJD2cEkas3s4s8DE/srpAC02RHriVrpD6WeuM67mrdjhMp4Yz46aX4SxRg07y3UWo
         /wyA==
X-Gm-Message-State: ACgBeo0LuVlqzyMoAhNbyzhRISgV8D3AliF8Wva/qk12JjCr+4Hs7rkh
        UdN1cJSoGhEEfK8O79FLJRsec/yBmTb+kU3WIv2dIX81cr8h
X-Google-Smtp-Source: AA6agR4HSCjsx3al/Z3BmrIGBn74ROpqAVyeeZ6yN8Okjp5/cBWADFKXP740gHNIx1D+PyNEgo9GHecFLiBpBFcCDwU=
X-Received: by 2002:a17:903:264b:b0:16d:b891:593 with SMTP id
 je11-20020a170903264b00b0016db8910593mr26128519plb.133.1659518822112; Wed, 03
 Aug 2022 02:27:02 -0700 (PDT)
MIME-Version: 1.0
References: <CAMhUBjkps_2EAkbCpGuLiWVFObLkLuj=3UqbxcuENUNXMkbS9Q@mail.gmail.com>
 <YudX0t/P94a0LKtr@ls3530>
In-Reply-To: <YudX0t/P94a0LKtr@ls3530>
From:   Zheyu Ma <zheyuma97@gmail.com>
Date:   Wed, 3 Aug 2022 17:26:51 +0800
Message-ID: <CAMhUBjk-nounZeqN3xq1Yp7+YG=iG+L2_3e1JOnWTJasiups-w@mail.gmail.com>
Subject: Re: [BUG] video: fbdev: arkfb: Found a divide-by-zero bug which may
 cause DoS
To:     Helge Deller <deller@gmx.de>
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Linux Fbdev development list <linux-fbdev@vger.kernel.org>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, Aug 1, 2022 at 12:35 PM Helge Deller <deller@gmx.de> wrote:
>
> * Zheyu Ma <zheyuma97@gmail.com>:
> > I found a bug in the arkfb driver in the latest kernel, which may cause DoS.
> >
> > The reason for this bug is that the user controls some input to ioctl,
> > making 'mode' 0x7 on line 704, which causes hdiv = 1, hmul = 2, and if
> > the pixclock is controlled to be 1, it will cause a division error in
> > the function ark_set_pixclock().
>
> You are right.
> I see in:
>   drivers/video/fbdev/arkfb.c:784: ark_set_pixclock(info, (hdiv * info->var.pixclock) / hmul);
> with hdiv=1, pixclock=1 and hmul=2 you end up with (1*1)/2 = (int) 0.
> and then in
>   drivers/video/fbdev/arkfb.c:504: rv = dac_set_freq(par->dac, 0, 1000000000 / pixclock);
> you'll get a division-by-zero.
>
> > The easiest patch is to check the value of the argument 'pixclock' in
> > the ark_set_pixclock function, but this is perhaps too late, should we
> > do this check earlier? I'm not sure, so I'll report this bug to you.
>
> Yes, I think it should be done earlier.
>
> Geert always mentioned that an invalid pixclock from userspace should be
> rounded up to the next valid pixclock.
> But since I don't have that hardware, I'm not sure how this can be done
> best for this driver.
>
> Do you have the hardware to test?
> If so, could you check the patch below?

Thanks for your patch, it works for me :)

> It should at least prevent the division-by-zero.
> If it works, I'm happy if you could send a final patch...

I've sent a patch to the mailing list, thanks again for your reminder.

regards,

Zheyu Ma
