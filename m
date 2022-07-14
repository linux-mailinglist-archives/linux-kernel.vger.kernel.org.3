Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5DB45756A6
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jul 2022 22:55:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240099AbiGNUzp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jul 2022 16:55:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239842AbiGNUzm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jul 2022 16:55:42 -0400
Received: from mail-yw1-x1136.google.com (mail-yw1-x1136.google.com [IPv6:2607:f8b0:4864:20::1136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E04386BC26
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 13:55:41 -0700 (PDT)
Received: by mail-yw1-x1136.google.com with SMTP id 00721157ae682-31c86fe1dddso29501987b3.1
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 13:55:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8FT3ZLNutfEmoo7t4rmO72smGUxB3YnBpqHmRoafQzY=;
        b=HZ44XAYGX8FzWTES4hRq2tiVKduTfdz38wnNZEGET5WEeI1z2v0MODo+hIiiXGMhhk
         lo1yal2LVQ/5q8OYb8sVbTJ1uQSNdmlmaPLmsWaB4vYeTn4RhaDqoOUdUIsEVCrC6Dfk
         lUnKh47qKGa8VtgxYoFUYXyuo5vKSwJOZwHXIMR60d0czsUXWTwhqg+d9dH5ctJsuXQn
         0V85jGrrNquwx5uzqTr9Ba4DvwDiaNAwPYyxhZH+BvxpDm11mQVtIc7DVli9QbNV0a0L
         SN/86WICfm4XgWrivcQxcxs/HlLehyh90AM/D3FAuYCm44bJ/C7fqVxrhkyY5dd/8/I3
         pxvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8FT3ZLNutfEmoo7t4rmO72smGUxB3YnBpqHmRoafQzY=;
        b=DMyjYZxNUkSi0j3fOc/p0mQR3yXeqhBY2HowYNSuM/gFzl8y83EX+fvpsE6diqilqb
         QGoqn6NRpnzlwqU9velOwp6X4raMIHvpCia6qBL7uVXDPMv9Q8y8HeO6XKM2/kTMc3TF
         C4YJZBR7wwIhAwcPrUM6GmM6sGYqyc5ZAje5NfZjs9YIw5NjaK2fxmyazIxuupg0oy2a
         NdYmO4UN5rXph3NxpDRZnMahNAxJnobOSgdg3XnaYyj5V5ghkJQeX8B0uXAzXiXun/N8
         RHYj3/0N2siGomKbZcH8P/PX2+kax0RM4PwhKhzxIvAFErm8rUApV4yMXLwu8Mv95ECx
         gDAw==
X-Gm-Message-State: AJIora/9idtphO4wXY8xYzgbEr74Wq48Jm5/oTC6yq9kVFs9FeNIxPiN
        oMNmZHKOrUhVOn6OXxKcQuluaKlwAbenhfd38sAffQ==
X-Google-Smtp-Source: AGRyM1vsf/AW9faiwfGsjYUxLdsLPzeCK7YiaADgr56vd4wbtXntiSBwM2BNvhM3ZJQTIQwNrAkxVD4gGrf+ES60C9A=
X-Received: by 2002:a81:4427:0:b0:31d:b9ad:4a7c with SMTP id
 r39-20020a814427000000b0031db9ad4a7cmr11478167ywa.396.1657832140847; Thu, 14
 Jul 2022 13:55:40 -0700 (PDT)
MIME-Version: 1.0
References: <20220706205136.v2.1.Ic7a7c81f880ab31533652e0928aa6e687bb268b5@changeid>
 <CACeCKadV=k5J1ZSG+p8M5iBnX5nXrn-XnK62Nq_op2kJ68+-9w@mail.gmail.com>
In-Reply-To: <CACeCKadV=k5J1ZSG+p8M5iBnX5nXrn-XnK62Nq_op2kJ68+-9w@mail.gmail.com>
From:   Tim Van Patten <timvp@google.com>
Date:   Thu, 14 Jul 2022 14:55:29 -0600
Message-ID: <CANkg5ewRc5zhBtxLhazo8Wsfa3Srj32AwZD9mD=W=Qqpqi7zJQ@mail.gmail.com>
Subject: Re: [PATCH v2] platform/chrome: cros_ec: Send host event for prepare/complete
To:     Prashant Malani <pmalani@chromium.org>
Cc:     LKML <linux-kernel@vger.kernel.org>, rrangel@chromium.org,
        robbarnes@google.com, Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        chrome-platform@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

We had issues measuring overall suspend and resume times, which this
patch attempts to help resolve.   As stated in the description, the EC
host command logs couldn't be used reliably, since they weren't
generated at the start of suspend/end of resume, but instead at some
point in the middle of the procedures.   This CL moves when the
commands are sent from the AP to the EC to as early/late as possible
in an attempt to deterministically capture as much of each process as
possible.

While this patch could potentially be split, both the logging and PM
changes are means to the same end: improving logging behavior to make
it easier for developers to measure suspend/resume time and aid in
debugging.   This will make it easier to bisect CLs in the event of
regressions, as well as more deterministically verify optimizations
and improvements.

@Rob Barnes Please fill in any other gaps you think are relevant.


On Thu, Jul 14, 2022 at 12:34 PM Prashant Malani <pmalani@chromium.org> wrote:
>
> HI Tim,
>
> On Wed, Jul 6, 2022 at 7:51 PM Tim Van Patten <timvp@google.com> wrote:
> >
> > Update cros_ec_lpc_pm_ops to call cros_ec_lpc_suspend() during PM
> > .prepare() and cros_ec_lpc_resume() during .complete. This allows the
> > EC to log entry/exit of AP's suspend/resume more accurately.
> >
> > Signed-off-by: Tim Van Patten <timvp@google.com>
> > ---
> >
> > Changes in v2:
> > - Include cros_ec_resume() return value in dev_info() output.
> > - Guard setting .prepare/.complete with #ifdef CONFIG_PM_SLEEP.
> >
> >  drivers/platform/chrome/cros_ec_lpc.c | 14 +++++++++++---
> >  1 file changed, 11 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/platform/chrome/cros_ec_lpc.c b/drivers/platform/chrome/cros_ec_lpc.c
> > index 7677ab3c0ead9..ce49fbc4ed2e1 100644
> > --- a/drivers/platform/chrome/cros_ec_lpc.c
> > +++ b/drivers/platform/chrome/cros_ec_lpc.c
> > @@ -534,19 +534,27 @@ static int cros_ec_lpc_suspend(struct device *dev)
> >  {
> >         struct cros_ec_device *ec_dev = dev_get_drvdata(dev);
> >
> > +       dev_info(dev, "Prepare EC suspend\n");
>
> This patch is doing 2 things:
> 1. Changing the timing of cros_ec_lpc_suspend()/resume() invocation.
> 2. Adding print logs for these callbacks.
>
> Whether 2.) is necessary is already being discussed, so I won't
> comment on that, but it sounds
> like this should be 2 different patches.
>
> Also, please explain what is wrong with "Previously, those events were sent when
> suspend/resume were already in progress." IOW, what issue is this
> solving, besides
> better ordering of EC logs.
>
> BR,
>
> -Prashant



-- 

Tim Van Patten | ChromeOS | timvp@google.com | (720) 432-0997
