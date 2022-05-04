Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E904519600
	for <lists+linux-kernel@lfdr.de>; Wed,  4 May 2022 05:30:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344341AbiEDDeY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 May 2022 23:34:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344472AbiEDDeN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 May 2022 23:34:13 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 321DB1AF03
        for <linux-kernel@vger.kernel.org>; Tue,  3 May 2022 20:30:39 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id a21so322637edb.1
        for <linux-kernel@vger.kernel.org>; Tue, 03 May 2022 20:30:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Gs5Ounip899C5lOiAHgN9uTnUVGqEvAG7D7k08amNUU=;
        b=HDFCo6RgpG74US91ZvtFD01vc6SEfhs/hMctx67JvMAFtT8caBpUOb07SMOPDFS0II
         lKG7CSe5N/dGOVU0YUMpd6Bzw3Y2PQjCVndT1T0Se7+/0A7GGC7+l8AnScBLo4l5q1fF
         gX1/SoS2DdcwJcirjlMsLQNSS3z3H+2wAANvI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Gs5Ounip899C5lOiAHgN9uTnUVGqEvAG7D7k08amNUU=;
        b=lEwb60GCUYpN+HwQtkGw+U///AgdT7oK32FJIx+hzRbSPQriZDj2syk49M3I12MHAJ
         FxtWb97Ti/EXB/3waocj23IWBdU0E/OOx+dsJK01EcfUXt8cZgqGQq1FIFt6I2w5lbYn
         nIOfBZMOGPGgPhDFloFmnNDh44S3SEkliVuLZ9qXIhvDxafcuxJbbTbEYG3ZLLg8zIcA
         wnPcH33ePvMnpQjjDUJkhhhbNEcYv4jYocMYscsjhYLdOH4yav1qrtzxs1quJZHFcJQs
         YfZPO5+ereTq8urAWJ8m81isp8yg2JYQ7T0YHffZvhBNY1TeB8+D9XYRhOKQxrJE8lP4
         RohQ==
X-Gm-Message-State: AOAM531lEJjcpQ1SX3lCzq9MmeHHxT9A5O4MItwk48AxNw6sywKRHtNy
        BE749aatIfx9HILRbGI1xwTtQBGIRfc2n9g6gRo=
X-Google-Smtp-Source: ABdhPJx3hiCEJhE0Rl0OWbz6xq+SZJKY9wdhy7SOZtkh1SmwyWyrBKwB0eg04Uv6CwSaY1pOyGKT7g==
X-Received: by 2002:a05:6402:2397:b0:426:4967:8574 with SMTP id j23-20020a056402239700b0042649678574mr21562080eda.197.1651635037534;
        Tue, 03 May 2022 20:30:37 -0700 (PDT)
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com. [209.85.221.45])
        by smtp.gmail.com with ESMTPSA id gv36-20020a1709072be400b006f3ef214e5bsm5165599ejc.193.2022.05.03.20.30.36
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 May 2022 20:30:36 -0700 (PDT)
Received: by mail-wr1-f45.google.com with SMTP id d5so261938wrb.6
        for <linux-kernel@vger.kernel.org>; Tue, 03 May 2022 20:30:36 -0700 (PDT)
X-Received: by 2002:a5d:6d09:0:b0:20c:53a9:cc30 with SMTP id
 e9-20020a5d6d09000000b0020c53a9cc30mr13905399wrq.513.1651635035897; Tue, 03
 May 2022 20:30:35 -0700 (PDT)
MIME-Version: 1.0
References: <20220502173338.1.I26eca1856f99e6160d30de6d50ecab60e6226354@changeid>
 <13819b2d-26f0-14f4-9cb9-affb6b18f13d@quicinc.com>
In-Reply-To: <13819b2d-26f0-14f4-9cb9-affb6b18f13d@quicinc.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Tue, 3 May 2022 20:30:23 -0700
X-Gmail-Original-Message-ID: <CAD=FV=VBqbhB03uPtnzYdRHhU-4TnX6RgDpHK27RUXY84esebw@mail.gmail.com>
Message-ID: <CAD=FV=VBqbhB03uPtnzYdRHhU-4TnX6RgDpHK27RUXY84esebw@mail.gmail.com>
Subject: Re: [PATCH] soc: qcom: socinfo: Add another ID for sc7180
To:     Sai Prakash Ranjan <quic_saipraka@quicinc.com>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>, matvore@chromium.org,
        Stephen Boyd <swboyd@chromium.org>,
        Andy Gross <agross@kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, May 3, 2022 at 7:14 PM Sai Prakash Ranjan
<quic_saipraka@quicinc.com> wrote:
>
> Hi,
>
> On 5/3/2022 6:03 AM, Douglas Anderson wrote:
> > It appears the some sc7180 devices, like the one in my
> > sc7180-trogdor-homestar, report an ID of 407 instead of 425. Add
> > another ID into the list.
> >
> > Signed-off-by: Douglas Anderson <dianders@chromium.org>
> > ---
> >
> >   drivers/soc/qcom/socinfo.c | 1 +
> >   1 file changed, 1 insertion(+)
> >
> > diff --git a/drivers/soc/qcom/socinfo.c b/drivers/soc/qcom/socinfo.c
> > index cee579a267a6..2ef1dc2a1dd3 100644
> > --- a/drivers/soc/qcom/socinfo.c
> > +++ b/drivers/soc/qcom/socinfo.c
> > @@ -318,6 +318,7 @@ static const struct soc_id soc_id[] = {
> >       { 396, "IPQ8071A" },
> >       { 402, "IPQ6018" },
> >       { 403, "IPQ6028" },
> > +     { 407, "SC7180" },
> >       { 421, "IPQ6000" },
> >       { 422, "IPQ6010" },
> >       { 425, "SC7180" },
>
> Hmm, this ID maps to SM6250 which is a mobile variant. Not sure we should
> use it for SC7180 which already has 425 ID assigned, perks of marketing :)

That's super weird. Any idea why my strongbad reports 407 then? Is it
a firmware bug, or someone misprogrammed something? What can we do to
make the CPU recognized in strongbad?

...and just for extra info, I believe strongbad actually has the
slightly faster version of sc7180. It has a higher GPU/CPU speed. In
some places I've heard it called sc7185, but in other places I've
heard it called just sc7180 with a faster clock speed...

-Doug
