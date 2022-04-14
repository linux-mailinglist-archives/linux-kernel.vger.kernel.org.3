Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AECDA500434
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Apr 2022 04:30:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239255AbiDNCdL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Apr 2022 22:33:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229759AbiDNCdI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 22:33:08 -0400
Received: from mail-oa1-x33.google.com (mail-oa1-x33.google.com [IPv6:2001:4860:4864:20::33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D5AF1CFD7
        for <linux-kernel@vger.kernel.org>; Wed, 13 Apr 2022 19:30:43 -0700 (PDT)
Received: by mail-oa1-x33.google.com with SMTP id 586e51a60fabf-de3eda6b5dso4000844fac.0
        for <linux-kernel@vger.kernel.org>; Wed, 13 Apr 2022 19:30:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=7X6E8VDuzQ2F6uzfOyPSrPGa6oXVkDPvWJCmwSR7mdo=;
        b=bo0blbPqgTEVW7RMqPw1KP4Oe7hINNAR2sPuU9TD3hbvp0BU91R9sK8aymt3DNT2Jp
         rRzKFRc9bN6xdz90wo2eRfib4wtO/vJiaUo3cVBDS5vE0YPOM/aATj19OSP2hJRmUG8r
         +sf0T52pDSmqXnBkg0B9xO3lzgCm/6spBgrrYC6Bt0/UrX01eanO/OwXa2S7GqXDB9eg
         AjfeZxHetIo+V684w7eCscmFr05tON/5YOi8/SHSKEOL2O1U99fIidbNOriMptDljSZ4
         jFN5menkSvIy44jD/eAowSrcmDTLW1L0X+6Pe02O0vGmiLNcUZTY0llEqJDByhGUpbCK
         zKVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=7X6E8VDuzQ2F6uzfOyPSrPGa6oXVkDPvWJCmwSR7mdo=;
        b=ilx9Q1IpT6HIOvHJVpmcPmt/JFHBBgODv34uCNgLOqXC1adMYxDULRBg9S1b0ZT7u2
         4DvyN8idorpyiigiZbr+ZJh3mFmC6AghUedaVsWDxpvNODyYOfR7WjIY6iJSY3NkTvTD
         n3CPa/v1Y3rs9uiN1+TXINDnLPDlTRhKHyIoQoEKoXoHFDeSqHh3HUASYgGPEUcHNDyo
         u22gY8a26G9gBhyuEzMM6yKhqKNpLvfUxh/nkW5UsJkxjFRJRI9sDevdMlAss4gGGnBo
         l0cXKZCXReISQyjgMLF+fwlZ9GNiWpwTWgpkTXznZezewHc1qVTlk4mr4x1ZF9bwSkgD
         S71w==
X-Gm-Message-State: AOAM533iOa1QHlhtvpQ4cUlb7MOzkD54Pti+RUrUIUv24d+9mQsAMMeh
        YIgV1IRrf8Vg9lduQbcjew1YAw==
X-Google-Smtp-Source: ABdhPJzUtEe+aXzU9LlPHKE08voE5cBhh6v8HbXuxYfmuSt7QTqtLUQm5R5Mwd3zhNzmSqC17u65TA==
X-Received: by 2002:a05:6870:9604:b0:de:a876:fbba with SMTP id d4-20020a056870960400b000dea876fbbamr670561oaq.239.1649903442911;
        Wed, 13 Apr 2022 19:30:42 -0700 (PDT)
Received: from ripper ([2600:1700:a0:3dc8:205:1bff:fec0:b9b3])
        by smtp.gmail.com with ESMTPSA id d17-20020a056830045100b005e9d02b0be2sm285463otc.58.2022.04.13.19.30.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Apr 2022 19:30:42 -0700 (PDT)
Date:   Wed, 13 Apr 2022 19:32:55 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     Georgi Djakov <djakov@kernel.org>, linux-kernel@vger.kernel.org,
        patches@lists.linux.dev, linux-arm-msm@vger.kernel.org,
        linux-pm@vger.kernel.org, Alex Elder <elder@linaro.org>,
        Taniya Das <quic_tdas@quicinc.com>,
        Mike Tipton <quic_mdtipton@quicinc.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: Re: [PATCH 0/2] interconnect: qcom: Remove IP0 resource
Message-ID: <YleH1+V9RCtMGege@ripper>
References: <20220412220033.1273607-1-swboyd@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220412220033.1273607-1-swboyd@chromium.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 12 Apr 15:00 PDT 2022, Stephen Boyd wrote:

> These two patches remove the IP0 interconnect used for IPA because
> they're also present in the clk-rpmh driver. I see there are some more
> IP0 usages in the interconnect drivers, but I don't see a corresponding
> IPA clk in clk-rpmh, so I left these out. We can remove all of them if
> desired, but the sc7180 patch is most important to me as it fixes
> boot on my trogdor lazor device.
>  
> Stephen Boyd (2):
>   interconnect: qcom: sc7180: Drop IP0 interconnects
>   interconnect: qcom: sdx55: Drop IP0 interconnects
> 
>  drivers/interconnect/qcom/sc7180.c | 21 ---------------------
>  drivers/interconnect/qcom/sdx55.c  | 21 ---------------------
>  2 files changed, 42 deletions(-)
> 
> Cc: Alex Elder <elder@linaro.org>
> Cc: Bjorn Andersson <bjorn.andersson@linaro.org>
> Cc: Taniya Das <quic_tdas@quicinc.com>
> Cc: Mike Tipton <quic_mdtipton@quicinc.com>
> Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> 

Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>

> base-commit: 3123109284176b1532874591f7c81f3837bbdc17
> -- 
> https://chromeos.dev
> 
