Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B06E53AB5F
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Jun 2022 18:55:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353917AbiFAQzQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Jun 2022 12:55:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351331AbiFAQzN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jun 2022 12:55:13 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74ECD985BD
        for <linux-kernel@vger.kernel.org>; Wed,  1 Jun 2022 09:55:12 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id c196so2523896pfb.1
        for <linux-kernel@vger.kernel.org>; Wed, 01 Jun 2022 09:55:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=bbckhJ9XlY3Nme+BPmiObgn0CQAdmt4CSl1wsZbSeV0=;
        b=FlZ/UGKxH5AQlCmDo/sE5CPr5JuOqd2r8n9Vi5nbW1KX/GjkV3/Gtn9S6TTaVs+TdM
         ev3zTuRFx8UNm1OCV/PSOOXMWgc36pGrvvKLw4PUY5kjp2WqC0RFVWZ4l7jKZrwRiVPL
         xaKITrvINKY1yyebYI+wZbnZ5O/vaFszXS5xc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=bbckhJ9XlY3Nme+BPmiObgn0CQAdmt4CSl1wsZbSeV0=;
        b=mdZS3lVD/4y+suU9TXImiBbTi1+MMbhRB92G1Q7ubH8S1E6vYvy9c28nEvJBPNNboL
         +B10yQZDwDjYZ5mfKc/ex6T+W7PIHh7rymA/Ol9YLf8/K/97xVWjH/+aPsXYBtUcLR5D
         W2nKu4mCXRMd6ArowUdPsifSoMfJVa00n/vUVyoFYZBPyYTn9RGuZBHc75jF/6ux8yud
         kOVVPbUCqKbGd3maNw+Q1I04OqumizB27o2DPnAIaypT/Df6BndSkxBr2LpgvSKCJYgL
         53GB1CQHGmPZl03G3R+FYZoipWM1Hf6MSnmfKdWEjpthRvaAIqqs8Lo5uRQBUj/fLcp0
         Lh+g==
X-Gm-Message-State: AOAM532JrKkSDMKqx3E9it9ddxE4IRHDOTgVnwt7esVt2JsZRhqwDZJv
        PzhfagI0oLwhywsuMz7oMhxCOg==
X-Google-Smtp-Source: ABdhPJxvz006k4bCcMabU3sUioYhsFPS+sODZatl7Pq8O6MVnYLQ0t5SXSDd6s81fwyeDL690piJlw==
X-Received: by 2002:a05:6a00:168a:b0:4f7:e161:83cd with SMTP id k10-20020a056a00168a00b004f7e16183cdmr577037pfc.56.1654102511801;
        Wed, 01 Jun 2022 09:55:11 -0700 (PDT)
Received: from localhost ([2620:15c:11a:202:e69e:f483:e751:7c7c])
        by smtp.gmail.com with UTF8SMTPSA id g10-20020a63e60a000000b003fab08e09e9sm1563351pgh.67.2022.06.01.09.55.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Jun 2022 09:55:11 -0700 (PDT)
Date:   Wed, 1 Jun 2022 09:55:09 -0700
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>,
        Stephen Boyd <swboyd@chromium.org>, agross@kernel.org,
        alsa-devel@alsa-project.org, bgoswami@quicinc.com,
        bjorn.andersson@linaro.org, broonie@kernel.org,
        devicetree@vger.kernel.org, judyhsiao@chromium.org,
        lgirdwood@gmail.com, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, perex@perex.cz,
        quic_plai@quicinc.com, quic_rohkumar@quicinc.com,
        robh+dt@kernel.org, tiwai@suse.com, vkoul@kernel.org
Subject: Re: [PATCH v2] ASoC: qcom: soundwire: Add support for controlling
 audio CGCR from HLOS
Message-ID: <YpeZ7TdHK20xiLz9@google.com>
References: <1652877755-25120-1-git-send-email-quic_srivasam@quicinc.com>
 <CAE-0n53g9rWks+euk5KHBzmJNEB3xLbJzMgCxN52DO5x+9-Wgg@mail.gmail.com>
 <51b8aca1-e038-4907-e973-ebdbebaf9b28@quicinc.com>
 <YpaXZ6KfApGebkBy@google.com>
 <7c74868d-624b-c18e-b377-026e70813fcc@quicinc.com>
 <1ec64a99-cfcf-c903-935b-d1bb0617c284@linaro.org>
 <61c151e2-c44c-3b84-9fed-a83abef83c17@quicinc.com>
 <2a520eaf-c1de-aa91-3029-83f5469cdbb0@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2a520eaf-c1de-aa91-3029-83f5469cdbb0@linaro.org>
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 01, 2022 at 02:42:30PM +0100, Srinivas Kandagatla wrote:
> 
> 
> On 01/06/2022 14:15, Srinivasa Rao Mandadapu wrote:
> > > > > > > > +       ctrl->audio_cgcr =
> > > > > > > > devm_reset_control_get_exclusive(dev,
> > > > > > > > "swr_audio_cgcr");
> > > > > > > > +       if (IS_ERR(ctrl->audio_cgcr))
> > > > > > > > +               dev_err(dev, "Failed to get
> > > > > > > > audio_cgcr reset required for
> > > > > > > > soundwire-v1.6.0\n");
> > > > > > > Why is there no return on error here? Is the reset optional?
> > > > > > Yes it's optional. For older platforms this is not required.
> > > > > If it's optional then either there should be no error message, or the
> > > > > error message should only be logged when the version is >= 1.6.0. There
> > > > > are few things worse than a kernel log riddled with misleading error
> > > > > messages.
> > > > 
> > > > In that case, it can be done like below. Kindly let me know your
> > > > opinion on this.
> > > > 
> > > > if (ctrl->version >= 0x01060000) {
> > > 
> > > This is not true 1.7+ variants do not require anything as such.
> > 
> > I think it applies for all upcoming versions as Qualcomm Hardware team.
> > Here is the not from HW Team.
> 
> Am testing sm8450 which has 1.7.0 and it does not require/have such control.
> 
> I dont understand what is the issue in adding a flag to
> struct qcom_swrm_data.
> 
> This should give finer control rather than matching anything > 1.6.

I agree, a flag seems a suitable option.
