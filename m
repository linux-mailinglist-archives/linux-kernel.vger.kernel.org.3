Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6FD44DCE76
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Mar 2022 20:07:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237849AbiCQTIp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Mar 2022 15:08:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232406AbiCQTIl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Mar 2022 15:08:41 -0400
Received: from mail-oi1-x230.google.com (mail-oi1-x230.google.com [IPv6:2607:f8b0:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4755A1FDFE8
        for <linux-kernel@vger.kernel.org>; Thu, 17 Mar 2022 12:07:24 -0700 (PDT)
Received: by mail-oi1-x230.google.com with SMTP id b188so6564806oia.13
        for <linux-kernel@vger.kernel.org>; Thu, 17 Mar 2022 12:07:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:user-agent:date:message-id
         :subject:to:cc;
        bh=Vx4F4flqEMKV9EEVrVwudLxc5Z4HECJWyM4/A1Dnkk0=;
        b=caXPf3i2JFsVELaO09oGL2NMqvNV/EdTDoTeFLjtB3LDI5nzhnmJsIVZO6TmoW3e5W
         pItyhYaIKxH1ehZESY2xk03P8yams/izTna63r7BKzxWdCc4VWhy0CkEO6elS0GBlI+x
         K+URvA2poM99991SLijz8sBS10l0h8K0lgGiY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:in-reply-to:references:from
         :user-agent:date:message-id:subject:to:cc;
        bh=Vx4F4flqEMKV9EEVrVwudLxc5Z4HECJWyM4/A1Dnkk0=;
        b=WfUYDKLV+kF5u6m8+DoXjmCGiT4TafbvYZXmd3xWalzE/512msrTGVPR5RJdzJIA7T
         +h2J9j8dvBE+oAN0lIBiq7HNbiAVvcrlzWtvqJ5Xmw/DkOWnQH9qaG5JS9BaUd0QoDdk
         YrdXedmnNDWvWxtZ9uVO89hI+iIOmR3QwJ0Ose84xWvp+i1xfhFmjFwvsnrGdm2Zm9jF
         A3M5ZR+dUtLuRHgF9VNHOQlwQ2waHN2ceOzx0XjkJO67Tp53mO4g1L8+L1qZOKsoUdhq
         5GC7iHfhnSuF/ggj8ih2bV28GzKIsPMzuaCgiJ8XJ3MVGFLAReVsWeCGPwhNCvdG0AYk
         i8mg==
X-Gm-Message-State: AOAM530R1TZysHURMlCLlrwpBW/ibrZQvVeDS67zRcmgzgTuhHmi2srt
        xusm4oBcACRq1S1WsIotpL1HSSx98Kj42P7Ty7Kojg==
X-Google-Smtp-Source: ABdhPJz+OzfR+V81525rJM0VCUAy/zin6BbXEAMra/9d8cP2h/7TSUQZLf29Eug0QDRZulHfVIjxAM7HESr9l54BADc=
X-Received: by 2002:aca:bd41:0:b0:2ec:ff42:814f with SMTP id
 n62-20020acabd41000000b002ecff42814fmr2779318oif.63.1647544043628; Thu, 17
 Mar 2022 12:07:23 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 17 Mar 2022 15:07:23 -0400
MIME-Version: 1.0
In-Reply-To: <1646679549-12494-1-git-send-email-quic_pmaliset@quicinc.com>
References: <1646679549-12494-1-git-send-email-quic_pmaliset@quicinc.com>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.10
Date:   Thu, 17 Mar 2022 15:07:23 -0400
Message-ID: <CAE-0n51HZKXCtrzf3_5wnoCZfhRoq8AqmUwsdk31iaiteVRDYg@mail.gmail.com>
Subject: Re: [PATCH v2] [RFC PATCH] PCI: Update LTR threshold based on LTRME bit
To:     Prasad Malisetty <quic_pmaliset@quicinc.com>, agross@kernel.org,
        bhelgaas@google.com, bjorn.andersson@linaro.org, kw@linux.com,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, lorenzo.pieralisi@arm.com,
        rajatja@google.com, refactormyself@gmail.com, robh@kernel.org
Cc:     quic_vbadigan@quicinc.com, quic_ramkri@quicinc.com,
        manivannan.sadhasivam@linaro.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Prasad Malisetty (2022-03-07 10:59:09)
> Update LTR threshold scale and value based on LTRME (Latency
> Tolenrance Reporting Mechanism) from device capabilities.
>
> In ASPM driver, LTR threshold scale and value is updating
> based on tcommon_mode and t_poweron values. In kioxia NVMe,
> L1.2 is failing due to LTR threshold scale and value is
> greater values than max snoop/non snoop value.
>
> In general, updated LTR threshold scale and value should be
> less than max snoop/non snoop value to enter the device
> into L1.2 state.
>
> Signed-off-by: Prasad Malisetty <quic_pmaliset@quicinc.com>
>

Any Fixes tag?

> ---
> Changes since v1:
>         - Added missing variable declaration in v1 patch.
> ---
>  drivers/pci/pcie/aspm.c | 12 +++++++++---
>  1 file changed, 9 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
> index a96b742..a67746c 100644
> --- a/drivers/pci/pcie/aspm.c
> +++ b/drivers/pci/pcie/aspm.c
> @@ -463,6 +463,7 @@ static void aspm_calc_l1ss_info(struct pcie_link_state *link,
>         u32 val1, val2, scale1, scale2;
>         u32 t_common_mode, t_power_on, l1_2_threshold, scale, value;
>         u32 ctl1 = 0, ctl2 = 0;
> +       u32 cap;
>         u32 pctl1, pctl2, cctl1, cctl2;
>         u32 pl1_2_enables, cl1_2_enables;
>
> @@ -499,9 +500,14 @@ static void aspm_calc_l1ss_info(struct pcie_link_state *link,
>          * Table 5-11.  T(POWER_OFF) is at most 2us and T(L1.2) is at
>          * least 4us.

Can this comment be updated to include why LTR cap matters?

>          */
> -       l1_2_threshold = 2 + 4 + t_common_mode + t_power_on;
> -       encode_l12_threshold(l1_2_threshold, &scale, &value);
> -       ctl1 |= t_common_mode << 8 | scale << 29 | value << 16;
> +       pcie_capability_read_dword(child, PCI_EXP_DEVCAP2, &cap);
> +       if (!(cap & PCI_EXP_DEVCAP2_LTR)) {
> +               l1_2_threshold = 2 + 4 + t_common_mode + t_power_on;
> +               encode_l12_threshold(l1_2_threshold, &scale, &value);
> +               ctl1 |= scale << 29 | value << 16;
> +       }
> +
> +       ctl1 |= t_common_mode;
