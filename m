Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39BA74BAA5B
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Feb 2022 20:53:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245557AbiBQTx3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Feb 2022 14:53:29 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:45346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231487AbiBQTx1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 14:53:27 -0500
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com [IPv6:2607:f8b0:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA86C12E150
        for <linux-kernel@vger.kernel.org>; Thu, 17 Feb 2022 11:53:12 -0800 (PST)
Received: by mail-oi1-x229.google.com with SMTP id v25so782950oiv.2
        for <linux-kernel@vger.kernel.org>; Thu, 17 Feb 2022 11:53:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:user-agent:date:message-id
         :subject:to:cc;
        bh=M+doG4hOkesdbvT8ytk1W2x52hbEiy5SqUAs3PiTxWs=;
        b=ajFOJekJGOXYKnbIR0AGefnhQdw2TLlmHA+b7uKmBRNsNq/jFc4XFF4MnK/vW7GToR
         phKhASp9LCiozG918AR/TyIVQQ1cNfwdH9C062r2MJqEyS6n7fqiDXRB59yV1WSyqBEF
         4Yupsavi+A8ybL/NfT6vOzUau4xa5t+rkHobQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:in-reply-to:references:from
         :user-agent:date:message-id:subject:to:cc;
        bh=M+doG4hOkesdbvT8ytk1W2x52hbEiy5SqUAs3PiTxWs=;
        b=NCickEQQHsib1hRt8K6S2qtA6wbye8inLbbE+ZpzZ3WN/+TH6G8HXm0LS1PllhdRIq
         kPPGqzUJwl76WTILm4KgQw3fW7eLjJWIpoQb1WJbdaX5Pc3IFKTTj7SB4Hv6RodEIsGa
         ROvN+LQRvfVrbYKXqROlw/z+ZmgC4fSn8GRj5bx0a6vjAvyldPv+SFFuMBaTBk8gdO+6
         qa7MC2iAeMnZA9mpoSQMYFv6xAWIr5EKii//hka++lyPGU3m1QXy6YstojMRr0fpsKQM
         ZhLfDjQr+447WsTONWBHOZs3Mg5ijvn9IxTrktsMsDqktIv02REI5JkBiRQMegE4mA5G
         nPkA==
X-Gm-Message-State: AOAM530dNsQe82TG15lTy3WGqeKMcPc9XUaGZHV0rfCiieoUI7ckoorG
        9GtQxPEvM+MflSYuD76Br2NDuY9CoYvZxXLV0KZh1A==
X-Google-Smtp-Source: ABdhPJybhDJoXr99rxvMT4dvF5Jw/4cgFw4TekjYxtOTU1Sr8MQippcgWwYJ5d2Dn0iO+AJDeH3ccP4DhPjQsb/YmBc=
X-Received: by 2002:a05:6808:b2f:b0:2cf:9af3:1687 with SMTP id
 t15-20020a0568080b2f00b002cf9af31687mr1800955oij.112.1645127592064; Thu, 17
 Feb 2022 11:53:12 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 17 Feb 2022 11:53:11 -0800
MIME-Version: 1.0
In-Reply-To: <d70291a6-7e3f-0406-2826-3a30f2d5650b@quicinc.com>
References: <1644850708-11099-1-git-send-email-quic_srivasam@quicinc.com>
 <1644850708-11099-9-git-send-email-quic_srivasam@quicinc.com>
 <CAE-0n52jD_BvQm4CeTkiR723-3uKC9G4fFeynFbs5Ukg_S762g@mail.gmail.com> <d70291a6-7e3f-0406-2826-3a30f2d5650b@quicinc.com>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.10
Date:   Thu, 17 Feb 2022 11:53:11 -0800
Message-ID: <CAE-0n51zr2qZ4qSzsC4=3d_jCYGvSxh8_3znrEQFaNrGfRU2Gw@mail.gmail.com>
Subject: Re: [RESEND v13 08/10] ASoC: qcom: Add lpass CPU driver for codec dma control
To:     Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>,
        agross@kernel.org, alsa-devel@alsa-project.org,
        bgoswami@codeaurora.org, bjorn.andersson@linaro.org,
        broonie@kernel.org, devicetree@vger.kernel.org,
        judyhsiao@chromium.org, lgirdwood@gmail.com,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        perex@perex.cz, quic_plai@quicinc.com, robh+dt@kernel.org,
        rohitkr@codeaurora.org, srinivas.kandagatla@linaro.org,
        tiwai@suse.com
Cc:     Venkata Prasad Potturu <quic_potturu@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Srinivasa Rao Mandadapu (2022-02-16 01:42:42)
>
> On 2/15/2022 7:03 AM, Stephen Boyd wrote:
> Thanks for your time Stephen!!!
> > Quoting Srinivasa Rao Mandadapu (2022-02-14 06:58:26)
> >> +       struct snd_soc_pcm_runtime *soc_runtime = asoc_substream_to_rtd(substream);
> >> +       struct lpaif_dmactl *dmactl;
> >> +       int ret = 0, id;
> >> +
> >> +       switch (cmd) {
> >> +       case SNDRV_PCM_TRIGGER_START:
> >> +       case SNDRV_PCM_TRIGGER_RESUME:
> >> +       case SNDRV_PCM_TRIGGER_PAUSE_RELEASE:
> >> +               __lpass_platform_codec_intf_init(dai, substream);
> >> +               break;
> >> +       case SNDRV_PCM_TRIGGER_STOP:
> >> +       case SNDRV_PCM_TRIGGER_SUSPEND:
> >> +       case SNDRV_PCM_TRIGGER_PAUSE_PUSH:
> >> +               __lpass_get_dmactl_handle(substream, dai, &dmactl, &id);
> >> +               if (!dmactl) {
> >> +                       dev_err(soc_runtime->dev, "failed to get dmactl handle\n");
> > This same message is in many places. I really hope it never gets printed
> > because finding out which line it got printed at is going to be
> > impossible.
> Okay. Will add function name in each print.

Are they useful prints at all? They seem like development prints that
won't trigger after the driver is developed. Why can't we just remove
them?
