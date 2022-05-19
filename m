Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71E2852E018
	for <lists+linux-kernel@lfdr.de>; Fri, 20 May 2022 00:49:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245559AbiESWtD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 May 2022 18:49:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233763AbiESWs5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 18:48:57 -0400
Received: from mail-oa1-x34.google.com (mail-oa1-x34.google.com [IPv6:2001:4860:4864:20::34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B020192D05
        for <linux-kernel@vger.kernel.org>; Thu, 19 May 2022 15:48:56 -0700 (PDT)
Received: by mail-oa1-x34.google.com with SMTP id 586e51a60fabf-f16a3e0529so8523621fac.2
        for <linux-kernel@vger.kernel.org>; Thu, 19 May 2022 15:48:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:user-agent:date:message-id
         :subject:to:cc;
        bh=gPmJM59HilOSZAiNocBUyn1VGxu9PFrDrw8E4Yeqrfk=;
        b=Ivbz2PDWtVwyLf0aE9K3mPrsVLOK80ClXfeDGxNsqdlxmI6lf/HqV7VfS+K1pFR238
         KfAvg7i6sxEPBmB782C8Q6xIoiiz4VrGwKI6qxj4FpHIfeHM7VsU0oaEHwdpWxktouqK
         31WAtWkdHxSG3SjDgz+OusBnk+tjWjtiPafIw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:in-reply-to:references:from
         :user-agent:date:message-id:subject:to:cc;
        bh=gPmJM59HilOSZAiNocBUyn1VGxu9PFrDrw8E4Yeqrfk=;
        b=tX0M7Ff/SmEwKvdZ/QnP5kQ6V/I/sXvyGr/9ubOM6mvHZMtXs0+HAjyqBz18BmLzXj
         kOroGOdSeCqIlpf8pZknXNcWy/iUL8Kjo+Au7cNcf+bA/pmj67NLhNgli8BI0CFDK2/3
         kpnY8x5FxyvpDqw8meEfwgH+ynY2+HFRuPIn22CKTMwMdXiUEu042dv7K6PFAW203CQu
         EYyG5D5cHw/z2nMRVblWwBrigfH+mCnIvtYJC2VtaKnkFusohH/w71+k6Ef8tvfnmACL
         Z/W/jhda1XweMSi/9VHD1KYcVoWWacZw1hpLPvnE5PHz0IoLB31KdmMGE9VsLhNot7I7
         oilQ==
X-Gm-Message-State: AOAM531mIHNqHbZryWUia4fobZhvFFGquGZPtb9RuJAJDRwvRUJkyy8y
        VTeGhW90/bAg3FWG9mO0c4eD4v6D0d5SLMhmOLPaKw==
X-Google-Smtp-Source: ABdhPJw5ddHxY0cfryu3hgg4S9UcGUCH59iSaeUGGcNe4rzoKsPmMGWR455MyyYyru3KXBJ68SY9LKIemGUmA3oUAE4=
X-Received: by 2002:a05:6870:240d:b0:f1:b878:e97c with SMTP id
 n13-20020a056870240d00b000f1b878e97cmr3801393oap.193.1653000536016; Thu, 19
 May 2022 15:48:56 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 19 May 2022 15:48:55 -0700
MIME-Version: 1.0
In-Reply-To: <1652982339-18190-3-git-send-email-quic_khsieh@quicinc.com>
References: <1652982339-18190-1-git-send-email-quic_khsieh@quicinc.com> <1652982339-18190-3-git-send-email-quic_khsieh@quicinc.com>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.10
Date:   Thu, 19 May 2022 15:48:55 -0700
Message-ID: <CAE-0n52ugbZfhP7BTYoo9yt1CMsKTW5uW74GdBNx14cRzj39gA@mail.gmail.com>
Subject: Re: [PATCH v5 2/3] phy: qcom-qmp: add regulator_set_load to dp phy
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

Quoting Kuogee Hsieh (2022-05-19 10:45:38)
> diff --git a/drivers/phy/qualcomm/phy-qcom-qmp.c b/drivers/phy/qualcomm/phy-qcom-qmp.c
> index b144ae1..24f39ee 100644
> --- a/drivers/phy/qualcomm/phy-qcom-qmp.c
> +++ b/drivers/phy/qualcomm/phy-qcom-qmp.c
> @@ -5008,6 +5019,11 @@ static int qcom_qmp_phy_com_init(struct qmp_phy *qphy)
>                 return 0;
>         }
>
> +       if (cfg->vreg_enable_load) {
> +               for (i = 0; i <= cfg->num_vregs; i++)

Just less than (<) cfg->num_vregs, not less than or equal to (<=)

> +                       regulator_set_load(qmp->vregs[i].consumer, cfg->vreg_enable_load[i]);
> +       }
>
