Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0002452F7E7
	for <lists+linux-kernel@lfdr.de>; Sat, 21 May 2022 05:13:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350352AbiEUDNu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 May 2022 23:13:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232435AbiEUDNo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 May 2022 23:13:44 -0400
Received: from mail-oa1-x30.google.com (mail-oa1-x30.google.com [IPv6:2001:4860:4864:20::30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E65415EA63
        for <linux-kernel@vger.kernel.org>; Fri, 20 May 2022 20:13:43 -0700 (PDT)
Received: by mail-oa1-x30.google.com with SMTP id 586e51a60fabf-e656032735so12378176fac.0
        for <linux-kernel@vger.kernel.org>; Fri, 20 May 2022 20:13:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:user-agent:date:message-id
         :subject:to;
        bh=z9YTOjtD+Dp8ysX3Zqk41W0+lPLgTo0iBxjrvvqtCBU=;
        b=cLDsvBQl3CZnZjmn3PmDvOxQs7A+4qpMSGeH+GcvPeqE6Rvcs0ccD3rvO0oo6H8M4v
         yEhmbpIEQToKgIxmIMitMFetTqQiY55KOQGQWEmS9133pgxN41HPQqgKkrwNCHndBuAT
         h66dGug5YTy2lURMzBPiPK2i5uxrMz3oPziA8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:in-reply-to:references:from
         :user-agent:date:message-id:subject:to;
        bh=z9YTOjtD+Dp8ysX3Zqk41W0+lPLgTo0iBxjrvvqtCBU=;
        b=hnWU2sIOOQ9yixSjGR+R7s3VYrGy0VUpyGiVx5vX0ZUrIDJWfpR39uakoTRsVFb7KE
         RkgoW9G4bNOImiYlLEw4v+L4A1D8vE5/2/DVW4piPdImYYpvQrziyC57BYEzYfWaUO/M
         EPrmGOA34/HSHGNdhaF37bhf9COyUGDD75FdOOQ7agxxMRX/P5sGZAGFk/Mty7q/Vpgs
         AcOhUvF3j1koFva6IvPbFpBUbcRaOTrRFupY5ngvSblnb5kZYbmdZLNqmJGWJi3OdV7G
         /UtyRRpnIkx9osWxw3rnj/dIuBO9gwAyqRciCwGG5uoSb/Uow+nsSfOkwDFTXOe9hkFK
         mv9A==
X-Gm-Message-State: AOAM533X7EMUSnFE7L6jZhwdIEpy9oAA/1NJxv/n2FV3BpDrFUd5IdEq
        YhGlaMqvwTthrtRkF2nmr8m/PKSCi3kLcvTIjgM3pw==
X-Google-Smtp-Source: ABdhPJyIw+llNRTQ/iWjLecfnj7stFoJrXY3wx+LQdTK0mDBx0mttcqVey3oWixUE9g2fqdMqfohHlynJ4sBtrZiqhk=
X-Received: by 2002:a05:6870:240d:b0:f1:b878:e97c with SMTP id
 n13-20020a056870240d00b000f1b878e97cmr6985165oap.193.1653102821168; Fri, 20
 May 2022 20:13:41 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 20 May 2022 20:13:40 -0700
MIME-Version: 1.0
In-Reply-To: <1652877755-25120-1-git-send-email-quic_srivasam@quicinc.com>
References: <1652877755-25120-1-git-send-email-quic_srivasam@quicinc.com>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.10
Date:   Fri, 20 May 2022 20:13:40 -0700
Message-ID: <CAE-0n53g9rWks+euk5KHBzmJNEB3xLbJzMgCxN52DO5x+9-Wgg@mail.gmail.com>
Subject: Re: [PATCH v2] ASoC: qcom: soundwire: Add support for controlling
 audio CGCR from HLOS
To:     Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>,
        agross@kernel.org, alsa-devel@alsa-project.org,
        bgoswami@quicinc.com, bjorn.andersson@linaro.org,
        broonie@kernel.org, devicetree@vger.kernel.org,
        judyhsiao@chromium.org, lgirdwood@gmail.com,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        perex@perex.cz, quic_plai@quicinc.com, quic_rohkumar@quicinc.com,
        robh+dt@kernel.org, srinivas.kandagatla@linaro.org, tiwai@suse.com,
        vkoul@kernel.org
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

Quoting Srinivasa Rao Mandadapu (2022-05-18 05:42:35)
> diff --git a/drivers/soundwire/qcom.c b/drivers/soundwire/qcom.c
> index da1ad7e..445e481 100644
> --- a/drivers/soundwire/qcom.c
> +++ b/drivers/soundwire/qcom.c
> @@ -1333,6 +1337,10 @@ static int qcom_swrm_probe(struct platform_device *pdev)
>         ctrl->bus.compute_params = &qcom_swrm_compute_params;
>         ctrl->bus.clk_stop_timeout = 300;
>
> +       ctrl->audio_cgcr = devm_reset_control_get_exclusive(dev, "swr_audio_cgcr");
> +       if (IS_ERR(ctrl->audio_cgcr))
> +               dev_err(dev, "Failed to get audio_cgcr reset required for soundwire-v1.6.0\n");

Why is there no return on error here? Is the reset optional?

> +
>         ret = qcom_swrm_get_port_config(ctrl);
>         if (ret)
>                 goto err_clk;
