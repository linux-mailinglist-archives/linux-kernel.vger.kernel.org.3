Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64EF95696AF
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jul 2022 02:02:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234684AbiGGAC3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jul 2022 20:02:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234580AbiGGAC2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 20:02:28 -0400
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com [IPv6:2607:f8b0:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A362F2D1C5
        for <linux-kernel@vger.kernel.org>; Wed,  6 Jul 2022 17:02:27 -0700 (PDT)
Received: by mail-oi1-x235.google.com with SMTP id s188so21447662oib.6
        for <linux-kernel@vger.kernel.org>; Wed, 06 Jul 2022 17:02:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:user-agent:date:message-id
         :subject:to:cc;
        bh=PnPr/1wV1VsDM5AHnYfjPAu3D3lvVU7n3T6uqgg9/R0=;
        b=cy5YW5oK8azkNdczvWFJwyh++jfARujG2dfBKCYuhU29WcT/XmK1mxCRYPxCTDuzHD
         S930YX/X6BdzGqHueKcrrFx+425I4eqBGTp0flDBv9boMS5HM7KjVEznIn2TJd0cJpBS
         pKupIMlhavC4356aVBEbh/9Lt/TaZMJ3fl0C4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:in-reply-to:references:from
         :user-agent:date:message-id:subject:to:cc;
        bh=PnPr/1wV1VsDM5AHnYfjPAu3D3lvVU7n3T6uqgg9/R0=;
        b=4LOB5/5PqGQDazFdK2lA+Bb3XilYEgt1BKR+HhJBmA38vUwW9TmJWqaPDwY6ZBfC1w
         n5OJ0RPidoQqKXlvLmBXDi4ZNzbxV6K+gGIwRiuf0M/FSwCtTj4QQUmx3ec8L6bOXlPA
         IMJUA/rAaxSmkAl0iVxTlPupUNF3usq615Aw3Uacx2VNbX+49qR8pONbd+rEPwGs9dIg
         PtdTquNLl46IdwWPZNA+yoy7dzp1uWqI49193MR1KBHpG1/KcJuG0RH3YBhO3TWM1OZu
         MXkVhqfWhRAkYO0xGd6yThGYvoY8HlBFto7X/2KAB/X4bUpO1VhTxmH/T0JKTPZ/GE44
         6jxw==
X-Gm-Message-State: AJIora+k3ZLo5SKtyUGnLH0mB8M9LM8boCZjSVKuO2+QBYvsnzVJ6TgG
        5IOJU7TzstJaYRr0Pmyx8xAIfTXwWv5KMpLmCvrCfA==
X-Google-Smtp-Source: AGRyM1vW63Yppk8g9ETKCFgydRa/5t3+pkplkfQ29ri3PaE1IB+DZLPNqhEt4I43L+jR0L5u6CSyYIFc3FbBzB2Bd/k=
X-Received: by 2002:a05:6808:171c:b0:334:9342:63ef with SMTP id
 bc28-20020a056808171c00b00334934263efmr808946oib.63.1657152147038; Wed, 06
 Jul 2022 17:02:27 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 6 Jul 2022 20:02:26 -0400
MIME-Version: 1.0
In-Reply-To: <Yr5xS/HCrBuNrn9N@builder.lan>
References: <20220628201340.3981860-1-swboyd@chromium.org> <Yr5xS/HCrBuNrn9N@builder.lan>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.10
Date:   Wed, 6 Jul 2022 20:02:26 -0400
Message-ID: <CAE-0n51Ex7T+B0PwwYmH-o9VAy5PYgzGFb=bOTu8ae4t0sGZKw@mail.gmail.com>
Subject: Re: [PATCH/RFC] clk: qcom: rpmh: Block system suspend if XO is enabled
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, patches@lists.linux.dev,
        linux-arm-msm@vger.kernel.org, Taniya Das <quic_tdas@quicinc.com>,
        Mike Tipton <quic_mdtipton@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Bjorn Andersson (2022-06-30 21:00:11)
> On Tue 28 Jun 15:13 CDT 2022, Stephen Boyd wrote:
>
> > Tracking down what RPMh resource is blocking XO shutdown in suspend is
> > hard. Largely because we need external debug tools to dump the RPMh
> > internal state to figure out what resource is enabled. Instead of doing
> > that, let's just block system wide suspend in the kernel if the RPMh XO
> > resource is enabled by something in the kernel. This will help us narrow
> > down XO shutdown failures to the XO clk, and not something else like an
> > interconnect or regulator RPMh resource.
> >
> > I'm sending this as an RFC because it breaks suspend for me on Trogdor
> > boards. I found out that the XO resource is always enabled on these
> > devices because the audio driver leaves an audio clk always on. This
> > means that the XO resource must not be used to determine if XO shutdown
> > is achievable, or we're leaving power savings on the table.
> >
> > Cc: Taniya Das <quic_tdas@quicinc.com>
> > Cc: Mike Tipton <quic_mdtipton@quicinc.com>
> > Signed-off-by: Stephen Boyd <swboyd@chromium.org>
>
> Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>
>
> > ---
> >
> > Please don't apply. It will break suspend on Trogdor boards.
> >
>
> This seems like a useful debug feature for people outside of Qualcomm,
> so I assume you're saying that we shouldn't merge it until someone has
> fixed the audio driver? Or did you post it just as a debug tool?
>

I mainly posted it to get a response from Qualcomm on what's going on. I
haven't tried to fix the audio driver so far, but I can certainly look
into it. The audio clk driver keeping XO on doesn't seem to matter for
power because we're hitting the deepest of sleeps on Trogdor boards.

I also realized that due to clk adoption logic we can't be certain that
this driver's suspend function will be called after other clk providers
that consume XO run their suspend functions. We can probably assume clk
consumers that aren't providers will probe after clk-rpmh, so this check
is generally safe because we don't have clk providers disabling clks
during their suspend functions. It's just not totally safe.

Maybe this is a good reason to add some sort of suspend op to clk_ops
and then call that during system wide suspend.
