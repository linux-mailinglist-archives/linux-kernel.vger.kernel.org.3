Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93A87573A2F
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 17:32:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236783AbiGMPcn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 11:32:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236219AbiGMPcj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 11:32:39 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B91504D4FC
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jul 2022 08:32:37 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id dn9so20489132ejc.7
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jul 2022 08:32:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=va4HUCl90cp8eYmGtRYCMwW6lU4n7zmdJ09yHuardDo=;
        b=N5oZrzfvRlM67mH8DE9VOV77UYaVi6aOiidlMs/IgGPMDtCUyfoqclHYzM/jMfqLab
         Zt+oP5fpACyu6XiECW8+qQeyTal2ygFE8RFIG6GztI95eP47ruWrU1w2b5d0oNTGOrQm
         y2FVQ7sIYBkD+5wITsALrYjHfLkffJDnnrAVI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=va4HUCl90cp8eYmGtRYCMwW6lU4n7zmdJ09yHuardDo=;
        b=VrtDcwXolqBj/R6qO3LCRl1+svVluzR8G3zKjYZal6IZvMzU+dYoMW40x/V8gPxeb1
         qU/tMez3UVL0NXUpMJUK2zNN2GJKVDPX99O1dI7WsPNpXbIKbmfFQ3hVJGJrs+ZcKRSz
         AwzU4RQwrYgknSJ8OEeZOTUlwuGHVKzcYqIX0/0hUIaPNlrPPa3vgt9rxoKe/0PUZ3WB
         MKtkJxNTWOmorq5IkqdY25toWY5F+EMRpnOpsOdbG+6Vzbkzr8+4NfvcOXOLey3xP3qy
         OrQ7r9IJQFqhmm2gfNZ3/SVJHwXhHhUM6vScq07CxctDWFuaeRapAXIYAljbUWWj0m+M
         OBzQ==
X-Gm-Message-State: AJIora+JyTO1lV66Sl+26/D99vHpNsUgpGlUzZxdVc6AWiRPZZZ9K8JY
        WU7oilfkG1zPUifn5R4Hhx86nsb2olFWkydB
X-Google-Smtp-Source: AGRyM1saDbjxDrU22AxOEUS5yRCr6WsiH11P27mwcu1iEh8+5boSLSI3smE69rQh1g/lYdAfIkKeEQ==
X-Received: by 2002:a17:907:28c9:b0:72b:6912:5453 with SMTP id en9-20020a17090728c900b0072b69125453mr3935645ejc.419.1657726357071;
        Wed, 13 Jul 2022 08:32:37 -0700 (PDT)
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com. [209.85.221.48])
        by smtp.gmail.com with ESMTPSA id d10-20020a50fe8a000000b0043a734c7393sm8118259edt.31.2022.07.13.08.32.36
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Jul 2022 08:32:36 -0700 (PDT)
Received: by mail-wr1-f48.google.com with SMTP id h17so16076874wrx.0
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jul 2022 08:32:36 -0700 (PDT)
X-Received: by 2002:adf:f90d:0:b0:20c:de32:4d35 with SMTP id
 b13-20020adff90d000000b0020cde324d35mr3839544wrr.583.1657726356035; Wed, 13
 Jul 2022 08:32:36 -0700 (PDT)
MIME-Version: 1.0
References: <1657087331-32455-1-git-send-email-quic_clew@quicinc.com> <1657087331-32455-4-git-send-email-quic_clew@quicinc.com>
In-Reply-To: <1657087331-32455-4-git-send-email-quic_clew@quicinc.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Wed, 13 Jul 2022 08:32:23 -0700
X-Gmail-Original-Message-ID: <CAD=FV=WEa3U1gNfUbpi2FvGYz9=4cub9wuV6XNXS5A=M2mDsaw@mail.gmail.com>
Message-ID: <CAD=FV=WEa3U1gNfUbpi2FvGYz9=4cub9wuV6XNXS5A=M2mDsaw@mail.gmail.com>
Subject: Re: [PATCH 3/4] soc: qcom: smp2p: Add memory barrier for irq_pending
To:     Chris Lew <quic_clew@quicinc.com>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
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

On Tue, Jul 5, 2022 at 11:03 PM Chris Lew <quic_clew@quicinc.com> wrote:
>
> There is a very tight race where the irq_retrigger function is run
> on one cpu and the actual retrigger softirq is running on a second
> cpu. When this happens, there may be a chance that the second cpu
> will not see the updated irq_pending value from first cpu.
>
> Add a memory barrier to ensure that irq_pending is read correctly.
>
> Signed-off-by: Chris Lew <quic_clew@quicinc.com>
> ---
>  drivers/soc/qcom/smp2p.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
>
> diff --git a/drivers/soc/qcom/smp2p.c b/drivers/soc/qcom/smp2p.c
> index a94cddcb0298..a1ea5f55c228 100644
> --- a/drivers/soc/qcom/smp2p.c
> +++ b/drivers/soc/qcom/smp2p.c
> @@ -249,6 +249,9 @@ static void qcom_smp2p_notify_in(struct qcom_smp2p *smp2p)
>
>                 status = val ^ entry->last_value;
>                 entry->last_value = val;
> +
> +               /* Ensure irq_pending is read correctly */
> +               mb();
>                 status |= *entry->irq_pending;
>
>                 /* No changes of this entry? */
> @@ -356,6 +359,11 @@ static int smp2p_retrigger_irq(struct irq_data *irqd)
>
>         set_bit(irq, entry->irq_pending);
>
> +       /* Ensure irq_pending is visible to all cpus that retried interrupt
> +        * can run on
> +        */
> +       mb();
> +

For the most part memory barriers break my brain and there should be a
very high bar for using them instead of normal locking mechanisms.
It's got to be an area that's super performance critical. I don't
think this is.

...but also if you really can have two thread mucking with
irq_pending, it seems like you have a bigger problem. Both threads are
doing read-modify-write of irq_pending (clear_bit and set_bit aren't
atomic) and a memory barrier won't help you there.

Just use a normal locking mechanism.


-Doug
