Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B72F751ACF8
	for <lists+linux-kernel@lfdr.de>; Wed,  4 May 2022 20:35:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377218AbiEDSii (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 May 2022 14:38:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377103AbiEDSiX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 14:38:23 -0400
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com [IPv6:2607:f8b0:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 492372E9D6
        for <linux-kernel@vger.kernel.org>; Wed,  4 May 2022 11:28:41 -0700 (PDT)
Received: by mail-ot1-x331.google.com with SMTP id g11-20020a9d648b000000b00605e4278793so1436340otl.7
        for <linux-kernel@vger.kernel.org>; Wed, 04 May 2022 11:28:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=TQPIA3VoumXyz1RrJSRcgA9lX+Pt6VG1KcKf5rCLbxQ=;
        b=y1IysrpGVOmONLnNwZEc588WNAHRPAVbFpbSh/tJ4Au9pwjAy+vAt6bt+DJFv/wPCj
         y9n5yzmHwrbKGHGMfUf7W/KJd+IFmpwCMHVhCkYNtZo3mdz1V/opKepzQdrFWSaUWUlt
         Q70UsdaJdM4/hzlkecq9pUbmdwSoE3i7m7s9GewikuTR9bPIqoPmZXHhpPr+gC72pR/p
         Z29aM2mn1GTHHp5RBCcB8Wzf5wtwdcen1Du1C6BZYvk2ehSnXJPFYMcW3fAiLbQqiG2a
         0seyeIzRe4cMUdCb2YpX/yt9KfODo/fC4RvdEplUg9NtsQHmYnhP3ofpAuk4FEYS1i7w
         YVBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=TQPIA3VoumXyz1RrJSRcgA9lX+Pt6VG1KcKf5rCLbxQ=;
        b=Dj+eI2W2pU8y71hXJVwKFmEDxW4uHoZ21A4LWREPF2i1B3Ke6jdroC7At1w/S//e10
         0dZrOgiaNK7D9yro5k1Br2uRO40zmUMS5eE83a5kfLiGzykK5GVdRkvXxfoaKWYq9GNF
         lSvvXsWPXdk4o8TdvqznVTZ/3CbfBOF8XqAMDO0x4R5+nuv++pu/qAJABP9Yge6T5S/8
         tQ5hmRJstMvRYbczCPKfdhDGXGeHkNvwN0uSdt/n5h5Dd9CX6hEKI2wQc3eR/i+HEpwz
         BaMoE7oa8R2dQCQXDygKJsEs1Vn7EATU+W4XNC7gOud7kZ2Dtfi3SY0qa1d1MtFWMTm+
         xsBA==
X-Gm-Message-State: AOAM532vUEpMbk+MvqCoxbNru5nNuP28fj8TWCctR/GbQNQy0c1zBqgu
        M1XLqOHTS1hxtkRY5Smu41pQoQ==
X-Google-Smtp-Source: ABdhPJxYkiegcJ9IRk6D1ytXYH8Rm5Z9s0sDkK09+L3SZz4yCj9MynlTPJUgbX3gQGvlpBMyFfR0+A==
X-Received: by 2002:a9d:2621:0:b0:606:254a:bc78 with SMTP id a30-20020a9d2621000000b00606254abc78mr4469271otb.57.1651688920275;
        Wed, 04 May 2022 11:28:40 -0700 (PDT)
Received: from ripper (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id y14-20020a0568302a0e00b006060322123fsm3783845otu.15.2022.05.04.11.28.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 May 2022 11:28:39 -0700 (PDT)
Date:   Wed, 4 May 2022 11:30:25 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Doug Anderson <dianders@chromium.org>
Cc:     Sai Prakash Ranjan <quic_saipraka@quicinc.com>,
        matvore@chromium.org, Andy Gross <agross@kernel.org>,
        "Reviewed-by : Stephen Boyd" <swboyd@chromium.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>
Subject: Re: (subset) [PATCH] soc: qcom: socinfo: Add another ID for sc7180
Message-ID: <YnLGQWPmcJo73vtu@ripper>
References: <20220502173338.1.I26eca1856f99e6160d30de6d50ecab60e6226354@changeid>
 <165168485227.3730817.11549721304895378126.b4-ty@linaro.org>
 <CAD=FV=WkJu8s5EmwJke49TPZ8CU8kD-CMcQi-9a3oUMqz9yBrQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAD=FV=WkJu8s5EmwJke49TPZ8CU8kD-CMcQi-9a3oUMqz9yBrQ@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 04 May 10:51 PDT 2022, Doug Anderson wrote:

> Hi,
> 
> On Wed, May 4, 2022 at 10:21 AM Bjorn Andersson
> <bjorn.andersson@linaro.org> wrote:
> >
> > On Mon, 2 May 2022 17:33:45 -0700, Douglas Anderson wrote:
> > > It appears the some sc7180 devices, like the one in my
> > > sc7180-trogdor-homestar, report an ID of 407 instead of 425. Add
> > > another ID into the list.
> > >
> > >
> >
> > Applied, thanks!
> >
> > [1/1] soc: qcom: socinfo: Add another ID for sc7180
> >       commit: c35886d605604e0b03cdd835ae3249dc1fe0cc2a
> 
> Hmm. Did you see the responses from Sai [1] about this? He seemed to
> indicate that there might be some issue here because he thought 407
> was supposed to be a different SoC. Are we sure we want to land this
> patch while we're sorting it out?
> 

I stared at the thread but didn't see his reply for some reason.

Congrats on the getting the random SoC in your device ;) As this was the
top patch on drivers-for-5.19, I just popped that off and pushed the
branch again.

Let me know when you've figured the numbering out (and if it turns out
to be the mobile id I wouldn't mind carrying that in the table)

Regards,
Bjorn

> [1] https://lore.kernel.org/r/13819b2d-26f0-14f4-9cb9-affb6b18f13d@quicinc.com/
