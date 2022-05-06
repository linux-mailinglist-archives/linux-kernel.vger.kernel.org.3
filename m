Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65FCA51E20C
	for <lists+linux-kernel@lfdr.de>; Sat,  7 May 2022 01:40:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1444995AbiEFX2D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 May 2022 19:28:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1444957AbiEFX2A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 May 2022 19:28:00 -0400
Received: from mail-oo1-xc32.google.com (mail-oo1-xc32.google.com [IPv6:2607:f8b0:4864:20::c32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 806AF712CE
        for <linux-kernel@vger.kernel.org>; Fri,  6 May 2022 16:24:16 -0700 (PDT)
Received: by mail-oo1-xc32.google.com with SMTP id q73-20020a4a334c000000b0035eb110dd0dso1499966ooq.10
        for <linux-kernel@vger.kernel.org>; Fri, 06 May 2022 16:24:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:user-agent:date:message-id
         :subject:to:cc;
        bh=/ElELV4+QaCmbQivuCO+s3nmw20xVvpsLHj2VQCOczQ=;
        b=Q/mL5LmBEmb9tU2w0cn5NhXVWbyWIiPZkShqLXDDa+rVYo+1WH5J6y4cbFsJ/GHnIC
         cRQnPAAT2Uuv1KT9qQMyQhEBwSwfFhY1cgAJT+RawLfPkt8k09bvKbPuhGRMAXoU9bmo
         oaM+z+Z1SZgTAZFMlrKYNiQUFUqDmFkNmJnYU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:in-reply-to:references:from
         :user-agent:date:message-id:subject:to:cc;
        bh=/ElELV4+QaCmbQivuCO+s3nmw20xVvpsLHj2VQCOczQ=;
        b=3rbM9cqOEo9UevafQPkvAgKhziQdiPvUnTniUM1FLZIv1ixNTdrxNd8dR2ulWFSjCe
         lk0e20YPk+yQsjWPUisdp1n6Y2sMAUsZH3bZfXMCC1PhsEbCGaFFSxnfbo5Cwhtbmqqj
         5QZA2N95uq2ubu/yDDo74uEL4DcqVlpadijw681vGCNmu3d1RgVVz8M3/59oHBQwyw54
         +Km0mvpVX+nYXUYLvWI/Yu+sTiK8cZKXnxpKedT23HAyy0RNeOY2Sxt9Oc9+jnSwcIqm
         yxbTMflA66OQnNxI8v8qqVQMW7q8XFU+sUhd4qK3yFxaG2QgRJLqCdYs8IuWXZkFVELW
         DoVA==
X-Gm-Message-State: AOAM531VcE9FBpRGWBTyP1NblUxb2xFiKk6I/jW1gFhUTXqTSokAHV7U
        dNFPXtLvZuobYObC8AycyDksP+XNp23bQXwssA+VjQ==
X-Google-Smtp-Source: ABdhPJyUJ6tVOobOozeBnxyxa8RgSY9d+Hm2+Rmx0y+yjUzUjdvUB/hoshBRw+G0Dpmcp5sPU11pJETcqoz8VXu5aq0=
X-Received: by 2002:a4a:6b49:0:b0:329:99cd:4fb8 with SMTP id
 h9-20020a4a6b49000000b0032999cd4fb8mr1917932oof.25.1651879455825; Fri, 06 May
 2022 16:24:15 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 6 May 2022 19:24:15 -0400
MIME-Version: 1.0
In-Reply-To: <YnKvoh+h07at8b65@builder.lan>
References: <20220412194505.614002-1-swboyd@chromium.org> <YnKvoh+h07at8b65@builder.lan>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.10
Date:   Fri, 6 May 2022 19:24:15 -0400
Message-ID: <CAE-0n517iAS9KSdunMX18LpqDrQ4ac-yRCZq82j-XdExaGjCXA@mail.gmail.com>
Subject: Re: [PATCH] clk: qcom: rpmh: Set wake/sleep state for BCM clks
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        patches@lists.linux.dev, Alex Elder <elder@linaro.org>,
        Taniya Das <quic_tdas@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Bjorn Andersson (2022-05-04 09:53:54)
> On Tue 12 Apr 14:45 CDT 2022, Stephen Boyd wrote:
>
> > Set the wake and sleep state for BCM clks here, not just the active
> > state, as the active only state is dropped when CPUs go to deep idle.
> > This ensures the clk is always on when the driver thinks it is on.
> >
> > This was found by inspection, and could very well be incorrect if the
> > RPMh hardware copies over the active only state to the sleep and wake
> > states.
> >
>
> Taking another look at this patch and now it makes perfect sense to me.
> Sorry for not grasping the problem earlier.
>
> Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>
>
>
> Will you take this in fixes, or do you want me to pick it for 5.19?
>

I'm waiting for Taniya to reply. For all I know this has no effect
because there's some sort of copy/paste from one state to another. Until
then it doesn't seem like we should do anything.
