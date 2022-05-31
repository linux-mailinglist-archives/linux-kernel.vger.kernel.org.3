Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 265C8539993
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Jun 2022 00:32:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348463AbiEaWcO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 May 2022 18:32:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240474AbiEaWcK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 May 2022 18:32:10 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D30355A0B7
        for <linux-kernel@vger.kernel.org>; Tue, 31 May 2022 15:32:09 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id j6so195384pfe.13
        for <linux-kernel@vger.kernel.org>; Tue, 31 May 2022 15:32:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=P9LyQVuvmVsNZW+3nPRkSL6POGxEfk0Mn3guF1+YKuI=;
        b=KN2tTYofItlyGe49xSbgyxQWQ327Y7iR6YoFSM9lhh+wiM1RX/01VGMPQk3muL0ImN
         ZabsYj5dpUeZY8QZi0bzCA53EjL5//Ogzm6HcmIBFQLYHH6Gdnqx/Mm0QCfURZwwN/6+
         Bfh5dacPirFGkAjSKezJgUXm/9DqjlcIXhLQE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=P9LyQVuvmVsNZW+3nPRkSL6POGxEfk0Mn3guF1+YKuI=;
        b=359JvSMfuPUuaCTRXw36nT6+ZapSFRm/MFZ5GzduFJkCxS6ZuUIDF5qAlbu33DzAew
         Z/nlKbhyBtg3BXggm/ti+vXZtjHR3XL0CJAL3mt3sIQkZSy8+M5jsBHn0SaXe8ZloJ+3
         CsqfON/dvHi46Mam6ZWVnUsI1INGoR76qumYy7IRCyDwWeWtLyIWJHuNhLfUQ8hLTI8i
         kaVT8tLoMPH73EoPYdZf43HI9LrufBXCGDKtnQf4gSNPEdwaUJqgcGgFB1PszptyEU3j
         0TYvUXg7YYYfQqQtFLg+y4I4N6XVZj2IpAYBWBjjAGZz2vqnlZd33AGpz5gW/upi27Hi
         a61Q==
X-Gm-Message-State: AOAM5337p9uekNexLva/0gMAdqAWw8njT35arpUhPjEF6yB6I6ymQs1r
        b6NAwq55EL0R2e56x2vAgV/ASA==
X-Google-Smtp-Source: ABdhPJwjBCrqDfLak45rq28qmCzF8Bpop3q8Bs7jqR40KSaDpro/v7PxK29LFIjoEyuzeSdZ/p9aGA==
X-Received: by 2002:a63:5843:0:b0:3fc:34b5:8278 with SMTP id i3-20020a635843000000b003fc34b58278mr7454016pgm.249.1654036329384;
        Tue, 31 May 2022 15:32:09 -0700 (PDT)
Received: from localhost ([2620:15c:11a:202:e69e:f483:e751:7c7c])
        by smtp.gmail.com with UTF8SMTPSA id b3-20020a170902d40300b001620a2737b6sm59801ple.74.2022.05.31.15.32.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 31 May 2022 15:32:09 -0700 (PDT)
Date:   Tue, 31 May 2022 15:32:07 -0700
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
Cc:     Stephen Boyd <swboyd@chromium.org>, agross@kernel.org,
        alsa-devel@alsa-project.org, bgoswami@quicinc.com,
        bjorn.andersson@linaro.org, broonie@kernel.org,
        devicetree@vger.kernel.org, judyhsiao@chromium.org,
        lgirdwood@gmail.com, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, perex@perex.cz,
        quic_plai@quicinc.com, quic_rohkumar@quicinc.com,
        robh+dt@kernel.org, srinivas.kandagatla@linaro.org, tiwai@suse.com,
        vkoul@kernel.org
Subject: Re: [PATCH v2] ASoC: qcom: soundwire: Add support for controlling
 audio CGCR from HLOS
Message-ID: <YpaXZ6KfApGebkBy@google.com>
References: <1652877755-25120-1-git-send-email-quic_srivasam@quicinc.com>
 <CAE-0n53g9rWks+euk5KHBzmJNEB3xLbJzMgCxN52DO5x+9-Wgg@mail.gmail.com>
 <51b8aca1-e038-4907-e973-ebdbebaf9b28@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <51b8aca1-e038-4907-e973-ebdbebaf9b28@quicinc.com>
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 24, 2022 at 04:19:47PM +0530, Srinivasa Rao Mandadapu wrote:
> 
> On 5/21/2022 8:43 AM, Stephen Boyd wrote:
> Thanks for your time Stephen!!!
> > Quoting Srinivasa Rao Mandadapu (2022-05-18 05:42:35)
> > > diff --git a/drivers/soundwire/qcom.c b/drivers/soundwire/qcom.c
> > > index da1ad7e..445e481 100644
> > > --- a/drivers/soundwire/qcom.c
> > > +++ b/drivers/soundwire/qcom.c
> > > @@ -1333,6 +1337,10 @@ static int qcom_swrm_probe(struct platform_device *pdev)
> > >          ctrl->bus.compute_params = &qcom_swrm_compute_params;
> > >          ctrl->bus.clk_stop_timeout = 300;
> > > 
> > > +       ctrl->audio_cgcr = devm_reset_control_get_exclusive(dev, "swr_audio_cgcr");
> > > +       if (IS_ERR(ctrl->audio_cgcr))
> > > +               dev_err(dev, "Failed to get audio_cgcr reset required for soundwire-v1.6.0\n");
> > Why is there no return on error here? Is the reset optional?
> Yes it's optional. For older platforms this is not required.

If it's optional then either there should be no error message, or the
error message should only be logged when the version is >= 1.6.0. There
are few things worse than a kernel log riddled with misleading error
messages.
