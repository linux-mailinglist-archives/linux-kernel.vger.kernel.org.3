Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E28C52E01F
	for <lists+linux-kernel@lfdr.de>; Fri, 20 May 2022 00:50:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245585AbiESWu1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 May 2022 18:50:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245577AbiESWuY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 18:50:24 -0400
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com [IPv6:2607:f8b0:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E27192D05
        for <linux-kernel@vger.kernel.org>; Thu, 19 May 2022 15:50:23 -0700 (PDT)
Received: by mail-oi1-x235.google.com with SMTP id q10so8153495oia.9
        for <linux-kernel@vger.kernel.org>; Thu, 19 May 2022 15:50:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:user-agent:date:message-id
         :subject:to:cc;
        bh=deoE4Qm8qsxnbdmXPjW300PaU2ET31mJnZqz2L/cn4M=;
        b=aRgwz/HUss1HuOFpQCIKu/P8t9sN5XH9pnTf2BwXDw+HqKFu/SgOVgmkCmCmdiqkFS
         FtrWmnzUbmqrVIrtquJ2Zw3E1bLnuQp7U4PSC9gUwsyB2958DE/oDCoVursXsRP/I8aJ
         v+gK1ozci++VDzcs1hsANHv4Tcx6yjPjfZVJw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:in-reply-to:references:from
         :user-agent:date:message-id:subject:to:cc;
        bh=deoE4Qm8qsxnbdmXPjW300PaU2ET31mJnZqz2L/cn4M=;
        b=cn1R8W4PRq6YWb7nwjnlnA8p6vaw/Ph60+zI/ID51j27ba62c8lWdCMnxFnpX20ySk
         16Tr9HVTX7CWZ4TkGi121Ho1YfpkEcXUdGo1MzPKUhBY/7VV4xrgiMSP5aBAnrf6riPM
         oInt6sldjbGaVCex0SlIa9ipcVKWWQi5dsAFLMsnQ2Gx+nBnNxKSebaEyH9455VBIx+T
         CpNKJYTQFHO5tXIN22gVYBqeLJgiHaU8ACJH3NBeXqbuCzoyovZGDCOsptITv61Z1h10
         u4saCWzINxNWQEGYrfY42lFFw5HgnavVYyQVDH4VvXS4Ms0mtUGy8tzqAJ9bv33cXuA6
         u54w==
X-Gm-Message-State: AOAM533e9EENN5GB3ANpoi1gqiiwRnn1VJT1zD7sqzRl2xIKQe9YNTE9
        TS2Cvq9LVxM2PWcLnK9vPBuli/UZVE3G3GyNGJY7hg==
X-Google-Smtp-Source: ABdhPJxveqssC09W6euurj9Q0qnAOSawljamJowys0OFddGMQRpM4VOMvK2OjEDDVKeek9Bs6FrxRRgNoQ6rQQ622pg=
X-Received: by 2002:a05:6808:14c2:b0:326:c129:d308 with SMTP id
 f2-20020a05680814c200b00326c129d308mr3615754oiw.193.1653000622517; Thu, 19
 May 2022 15:50:22 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 19 May 2022 15:50:22 -0700
MIME-Version: 1.0
In-Reply-To: <1652982339-18190-2-git-send-email-quic_khsieh@quicinc.com>
References: <1652982339-18190-1-git-send-email-quic_khsieh@quicinc.com> <1652982339-18190-2-git-send-email-quic_khsieh@quicinc.com>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.10
Date:   Thu, 19 May 2022 15:50:22 -0700
Message-ID: <CAE-0n53EbwhC9G5tbLutGb3+8EfmYj45n7DHwjpP0C=b_DuFUg@mail.gmail.com>
Subject: Re: [PATCH v5 1/3] phy: qcom-edp: add regulator_set_load to edp phy
To:     Kuogee Hsieh <quic_khsieh@quicinc.com>, agross@kernel.org,
        airlied@linux.ie, bjorn.andersson@linaro.org, daniel@ffwll.ch,
        dianders@chromium.org, dmitry.baryshkov@linaro.org,
        dri-devel@lists.freedesktop.org, robdclark@gmail.com,
        sean@poorly.run, vkoul@kernel.org
Cc:     quic_abhinavk@quicinc.com, quic_aravindh@quicinc.com,
        quic_sbillaka@quicinc.com, freedreno@lists.freedesktop.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Kuogee Hsieh (2022-05-19 10:45:37)
> diff --git a/drivers/phy/qualcomm/phy-qcom-edp.c b/drivers/phy/qualcomm/phy-qcom-edp.c
> index cacd32f..90093cd 100644
> --- a/drivers/phy/qualcomm/phy-qcom-edp.c
> +++ b/drivers/phy/qualcomm/phy-qcom-edp.c
> @@ -87,14 +87,19 @@ struct qcom_edp {
>
>         struct clk_bulk_data clks[2];
>         struct regulator_bulk_data supplies[2];
> +       int enable_load[2];
>  };
>
>  static int qcom_edp_phy_init(struct phy *phy)
>  {
>         struct qcom_edp *edp = phy_get_drvdata(phy);
>         int ret;
> +       int i;
>
> -       ret = regulator_bulk_enable(ARRAY_SIZE(edp->supplies), edp->supplies);
> +       for (i = 0; i < 2; i++)
> +               regulator_set_load(edp->supplies[i].consumer, edp->enable_load[i]);
> +
> +       ret = regulator_bulk_enable(num_consumers, edp->supplies);

Where is num_consumers coming from?

>         if (ret)
>                 return ret;
>
