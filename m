Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1AEFD500262
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Apr 2022 01:14:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239049AbiDMXQd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Apr 2022 19:16:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239122AbiDMXQ2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 19:16:28 -0400
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com [IPv6:2607:f8b0:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A7D325C66
        for <linux-kernel@vger.kernel.org>; Wed, 13 Apr 2022 16:14:05 -0700 (PDT)
Received: by mail-oi1-x232.google.com with SMTP id e4so3686426oif.2
        for <linux-kernel@vger.kernel.org>; Wed, 13 Apr 2022 16:14:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:user-agent:date:message-id
         :subject:to:cc;
        bh=dorfVU/xJSabHsQtVBWrq/Iqc9CAJtp4oOExMJgEUDQ=;
        b=m+OmSD/e4we/K+vygGa6butFRkA8E+g/p2ckEiZ/uW+cVdyspvoJRGw+9FyyXam5cq
         tKUR+8UFC5n7VmwCQP8rHi/+hQ5PDk//cvhjT5HtpMvvW9ER33VqwEDQkbDEFxhsM7hb
         z5Yse8JE+ZpUXuCYKRHbRXAPEJQEZ0GE9T76A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:in-reply-to:references:from
         :user-agent:date:message-id:subject:to:cc;
        bh=dorfVU/xJSabHsQtVBWrq/Iqc9CAJtp4oOExMJgEUDQ=;
        b=aGHg98m9JjZGdtxICqNmzhEe94w5RxFdGY4Np3HbJ1/rAeV92qxUsMZZR27y/2Kv+n
         xFGWP5c8FyFYlylPsPNjO6qD766SdMAeIa9/fy2uFckrdfYBR22Sz77dIhNQuosTAAka
         nT8NsQwHm2cZshPO+qRXmd86B1Ieb5E8Rfbdo0ObEYMChzWWbJAUi/sx4jFoOQtQhchG
         u0PTI/Jcd9p6wS3cJLg1vej84lGvFH8PhLty6zr9c9cqsZq17gXfPppZiDWGAYR/19vw
         tGlYQtN5gXi2eBrxU070FZlFHaijboJXMoVEOrJlFplD+JfNKW/47Ryhkv2gu1K7T1bp
         6LeA==
X-Gm-Message-State: AOAM533vthQ/rr0HTA4LPFhZ0pICNd3jv+d+f/1d1pRBfj763mg4bKBo
        aieqQ7OihZcA/Z/ZlTkSuK1OjLJqLLSzOclpnLOHDQ==
X-Google-Smtp-Source: ABdhPJy/y7cGBki5XtEew+aPGYslTH0aAHoZeAOee7B/n9e30cebHJofLtYmhLy+51DqypLaLc+k7XKo3IKWa8yDq70=
X-Received: by 2002:aca:bd41:0:b0:2ec:ff42:814f with SMTP id
 n62-20020acabd41000000b002ecff42814fmr195472oif.63.1649891644404; Wed, 13 Apr
 2022 16:14:04 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 13 Apr 2022 16:14:02 -0700
MIME-Version: 1.0
In-Reply-To: <d80ece40-fdd7-f304-3989-47ae152d5ac9@linaro.org>
References: <20220412220033.1273607-1-swboyd@chromium.org> <20220412220033.1273607-2-swboyd@chromium.org>
 <CAD=FV=UFbOhs0ggxDbVwKM_8x=ELT85zFd-Wk6dJ_M+Awz+Pxw@mail.gmail.com> <d80ece40-fdd7-f304-3989-47ae152d5ac9@linaro.org>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.10
Date:   Wed, 13 Apr 2022 16:14:02 -0700
Message-ID: <CAE-0n53kebRHTogSkiAOcA4tMpA+EcXQHtNX0Zzut-xE2vCkpw@mail.gmail.com>
Subject: Re: [PATCH 1/2] interconnect: qcom: sc7180: Drop IP0 interconnects
To:     Alex Elder <elder@linaro.org>,
        Doug Anderson <dianders@chromium.org>
Cc:     Georgi Djakov <djakov@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, patches@lists.linux.dev,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Taniya Das <quic_tdas@quicinc.com>,
        Mike Tipton <quic_mdtipton@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Alex Elder (2022-04-13 14:02:00)
> On 4/13/22 3:55 PM, Doug Anderson wrote:
> > Hi,
> >
> > On Tue, Apr 12, 2022 at 4:20 PM Stephen Boyd <swboyd@chromium.org> wrote:
> >>
> >> @@ -519,8 +500,6 @@ static const struct of_device_id qnoc_of_match[] = {
> >>            .data = &sc7180_dc_noc},
> >>          { .compatible = "qcom,sc7180-gem-noc",
> >>            .data = &sc7180_gem_noc},
> >> -       { .compatible = "qcom,sc7180-ipa-virt",
> >> -         .data = &sc7180_ipa_virt},
> >>          { .compatible = "qcom,sc7180-mc-virt",
> >>            .data = &sc7180_mc_virt},
> >>          { .compatible = "qcom,sc7180-mmss-noc",
> >
> > I have no objection to ${SUBJECT} change landing and based on all your
> > research and Alex's review/testing I think it's good to go.
> >
> > However, now that you're removed the driver that cared about
> > "qcom,sc7180-ipa-virt", should we also be removing it from the
> > `bindings/interconnect/qcom,rpmh.yaml` file and the `sc7180.dtsi`
> > file? I think that removing it from _either_ the driver (like your
> > patch here does) _or_ the sc7180.dtsi file would fix the bug, right?
> > ...and then removing it from the yaml would just be cleanup...

Yes, but that's mostly a cleanup. I didn't include it in this series
because DTB is supposed to be "stable" and thus backporting a fix to the
kernel by removing something from DT is sort of wrong. I don't know or
expect that the kernel DTS files will be used from the stable kernels.
It's better to fix the kernel C code. We can of course remove the
binding, but there's a part of me that would prefer that we put the IPA
clk back into the interconnect driver, so leaving the binding is another
motivator for me to hopefully excise the IPA clk from the rpmh-clk
driver in the future.

Anyway, I'm happy to remove the compatible string from the binding if
folks want that. Having the DT node is wasteful because the kernel makes
a device so we can certainly remove that as well. I'll send another
patch for that if this patch is accepted by Georgi.

>
> That's a good point, I hadn't thought about that but you're right.
>
> I think we were too pleased about identifying the problem and
> proving it could happen (and cause a crash), so we didn't think
> hard enough about this other piece.
>
> Stephen, I think you should re-spin the series and add the
> proper change to the binding.  You can keep the tags I gave
> before.

I will not combine the removal of the binding from this patch. This
patch is good as is and fixes the problem while ignoring the DT binding
and that larger discussion.

>
> I've got a note to follow up with similar changes to other
> platforms where the interconnect driver includes resource "IP0"
> and will plan to do what Doug suggests there too.
