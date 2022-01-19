Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D29749352C
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jan 2022 07:49:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346122AbiASGtk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jan 2022 01:49:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345647AbiASGte (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jan 2022 01:49:34 -0500
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0EF8C061574;
        Tue, 18 Jan 2022 22:49:33 -0800 (PST)
Received: by mail-lf1-x129.google.com with SMTP id m1so5373100lfq.4;
        Tue, 18 Jan 2022 22:49:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to;
        bh=4qGM2PfWPk6RGTVLrrFSHYqmCik/v9iLb4ZUp6ZvJnw=;
        b=NnxaFzVW7dVtK/7bDW/MwUcZfru0yFMo1fnaIQZHCUiblkQmRt/V5WqnrtmbuX2w/v
         5zgYuqibtmKjNA4Fh1AB+tkKs/Z/bcf6BrB0nut9GhN2JJjSAaZWqesrMAHYQR+5ZJ0Q
         3kYPRJEXHSiAick74qhTVLnNxLL5SBiaDPbySbuG7YkvafPWrHeMOONUhdjmCuLBICqr
         tPNOf1qsnivsLVQtUMXwC5Mh9cGVlfNcm1H+y/Ed1PjExvhBxY3cAqskg/90Ckm89hVy
         5l/xh2EGQgMC006XiLoIFn4Wexx+JLO0tE3h4cGgcCFWgItZuG9es2UpT2YTEQu4I7ZO
         1BTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=4qGM2PfWPk6RGTVLrrFSHYqmCik/v9iLb4ZUp6ZvJnw=;
        b=yFEo2I69A//phjAnIjRjFHU9nM9wnipePNq8T1MKNQaPKHnlFwwBiRC0j97QKujgpz
         DM2+f/gW3eco0VNRTmy7Nzjsw/pB83I9uiypVAnMVW+IzpBWJ9Zg//oGXVPzAgWEv51D
         CrUQJE46bpZmL+2457JNuJ+28ll7jzXB2NXM/Wq208dwSerbWCREg8WAuZjZTE6XL/gi
         NmKi5dS8zfe814vngAmbEJeVDJSZoy4C/0uAZ6jZGsNJ/QLw9OgnzZDIh8GVhHfeQiAt
         ocrc7aSh7PpynRArBvJNMr6rXS1SXb+k5g6aANq11CBMgD8DKipKJw7pwojlZYCIy06D
         r+Bg==
X-Gm-Message-State: AOAM530bwrhtIvlQl0BZYnqWBe4JidFnpCwEqIK7xkk81sBYT/tB4dMo
        FyaYg8Tfd3cvJI+qBYexP28=
X-Google-Smtp-Source: ABdhPJxbU8IfDu3SpJWUT2eTInv3+sMu15J2Fqypqq8yvoUkpJqf1uIPFt/Ebj0L/92FbMSZnudvBg==
X-Received: by 2002:a05:6512:787:: with SMTP id x7mr25529594lfr.647.1642574971753;
        Tue, 18 Jan 2022 22:49:31 -0800 (PST)
Received: from localhost ([2a05:3580:f312:6c01:1b6d:df4d:cbec:e4a2])
        by smtp.gmail.com with ESMTPSA id b23sm1756726lfv.22.2022.01.18.22.49.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jan 2022 22:49:31 -0800 (PST)
Date:   Wed, 19 Jan 2022 09:49:30 +0300
From:   Andrey Skvortsov <andrej.skvortzov@gmail.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Arnaud Ferraris <arnaud.ferraris@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Avri Altman <avri.altman@wdc.com>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Huijin Park <huijin.park@samsung.com>,
        Christian =?utf-8?B?TMO2aGxl?= <CLoehle@hyperstone.com>,
        Yue Hu <huyue2@yulong.com>, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mmc: core: Wait for command setting 'Power Off
 Notification' bit to complete
Message-ID: <Yee0ejAQeL+wSRsz@skv.local>
Mail-Followup-To: Andrey Skvortsov <andrej.skvortzov@gmail.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Arnaud Ferraris <arnaud.ferraris@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Avri Altman <avri.altman@wdc.com>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Huijin Park <huijin.park@samsung.com>,
        Christian =?utf-8?B?TMO2aGxl?= <CLoehle@hyperstone.com>,
        Yue Hu <huyue2@yulong.com>, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220115121447.641524-1-andrej.skvortzov@gmail.com>
 <CAPDyKFr_9kfAns2p6fsUck93s3peyrHvCtv5M9E3fnxLmHbRqQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAPDyKFr_9kfAns2p6fsUck93s3peyrHvCtv5M9E3fnxLmHbRqQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Ulf

On 22-01-18 19:48, Ulf Hansson wrote:
> On Sat, 15 Jan 2022 at 13:15, Andrey Skvortsov
> <andrej.skvortzov@gmail.com> wrote:
> >
> > SD card is allowed to signal busy on DAT0 up to 1s after the
> > CMD49. According to SD spec (version 6.0 section 5.8.1.3) first host
> > waits until busy of CMD49 is released and only then polls Power
> > Management Status register up to 1s until the card indicates ready to
> > power off.
> >
> > Without waiting for busy before polling status register sometimes card
> > becomes unresponsive and system fails to suspend:
> >
> >   [  205.907459] Freezing remaining freezable tasks ... (elapsed 0.001 seconds) done.
> >   [  206.421274] sunxi-mmc 1c0f000.mmc: data error, sending stop command
> >   [  206.421321] sunxi-mmc 1c0f000.mmc: send stop command failed
> >   [  206.421347] mmc0: error -110 reading status reg of PM func
> >   [  206.421366] PM: dpm_run_callback(): mmc_bus_suspend+0x0/0x74 returns -110
> >   [  206.421402] mmcblk mmc0:aaaa: PM: failed to suspend async: error -110
> >   [  206.437064] PM: Some devices failed to suspend, or early wake event detected
> 
> Thanks for your patch!
> 
> I recall I was hesitating on adding another busy completion check for
> this, but thought polling the status register for the power management
> function should be sufficient.
> 
> >
> > Tested with Sandisk Extreme PRO A2 64GB on Allwinner A64 system.
> 
> I will give this patch a try too, to make sure it still works on my
> side. Assuming that works fine, I will queue this up for fixes and by
> adding a fixes/stable tag.

Thank you! More testing would be certainly great, because only one of my SD-cards
supports "Power Notification".

-- 
Best regards,
Andrey Skvortsov
