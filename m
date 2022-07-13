Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5162D573A2D
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 17:32:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236643AbiGMPca (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 11:32:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230284AbiGMPc3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 11:32:29 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 164C14D4C9
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jul 2022 08:32:28 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id t3so14332165edd.0
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jul 2022 08:32:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DfFYBGzsnFCamb64n5fw602srlx7DWs3xt0xrxYl+Bk=;
        b=Cdy3TZS7xAOK41gvF5ObngxfiTPXD5FqRi+m1JO4Tva5qC9knFvMpNw9BO9gg8Qnj4
         4cpQdXw15P6bwoKj2eHtetbJ+6zeiRAVlomIlCCBmmz7baQ1CnN5X3QHONbTn3vmmwk6
         5VQiueadMxw8EqzTO2wSI+1zyjuh+Yhwy7JYQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DfFYBGzsnFCamb64n5fw602srlx7DWs3xt0xrxYl+Bk=;
        b=U0XdUjLBkvnGs4D9kQZpcxsOzLT8aZhKCNVzJasZ/tvUFvmwJOMW+52Nd5o5KJCPjG
         l/WfCJnQWn1TnWsZW+S6lwKtsLdbsKShu06SyvCOdKOAn0AuxgrZN40le+/O1msFpgdw
         oVKCMZ3/u5qCpFcSf54wAG3cn1Zy+kUesON39J8WJ+2mFaAOmVeoULUGTxoMl7gpVjeU
         CBuRfqaezaIdlrW6mKy0mLJamYWqCpDu4d60uXVnvl4PtYy37E4bFMsergGKJh3/3+gl
         hfSskkRDGFoQlrVP+SCGr6leWJWIAAtXpoU73aIVW3j1otTDdXIcM2J1LBZF6kRxUJgS
         3IzA==
X-Gm-Message-State: AJIora9WsK9NzQaT1QPObr2W//0CV/ZqftPWYJ8q0uUPUDJwiS6Vd7SC
        vCbQCAzItYvRglrnVTeidAjxPLEiC5Luag==
X-Google-Smtp-Source: AGRyM1sh4Z1PnKuR9gXPxQHFadhdSQLTPIdqhtChvqvj1gmuZgRaa2I8snHnUR+a3B41xs0vV7md4Q==
X-Received: by 2002:a05:6402:388e:b0:43a:d5ff:60f0 with SMTP id fd14-20020a056402388e00b0043ad5ff60f0mr5736972edb.152.1657726346341;
        Wed, 13 Jul 2022 08:32:26 -0700 (PDT)
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com. [209.85.128.44])
        by smtp.gmail.com with ESMTPSA id m16-20020a056402051000b0043a7cdfac46sm8176944edv.23.2022.07.13.08.32.25
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Jul 2022 08:32:25 -0700 (PDT)
Received: by mail-wm1-f44.google.com with SMTP id c131-20020a1c3589000000b003a2cc290135so1434991wma.2
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jul 2022 08:32:25 -0700 (PDT)
X-Received: by 2002:a05:600c:3d95:b0:3a2:e97b:f3ae with SMTP id
 bi21-20020a05600c3d9500b003a2e97bf3aemr10016742wmb.188.1657726345212; Wed, 13
 Jul 2022 08:32:25 -0700 (PDT)
MIME-Version: 1.0
References: <1657087331-32455-1-git-send-email-quic_clew@quicinc.com> <1657087331-32455-2-git-send-email-quic_clew@quicinc.com>
In-Reply-To: <1657087331-32455-2-git-send-email-quic_clew@quicinc.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Wed, 13 Jul 2022 08:32:12 -0700
X-Gmail-Original-Message-ID: <CAD=FV=WfhGksEOqTeuoRawuALAt6tOtNvrajGF4iAuL1xALapQ@mail.gmail.com>
Message-ID: <CAD=FV=WfhGksEOqTeuoRawuALAt6tOtNvrajGF4iAuL1xALapQ@mail.gmail.com>
Subject: Re: [PATCH 1/4] soc: qcom: smp2p: Introduce pending state for virtual irq
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

I'm jumping in half-blind here since I've never looked at this driver
before, so if I say something that sounds wrong then it probably is.
;-P At the very least I'm super thankful for the "summary" kernel doc
at the start of this file (thanks Bjorn!)...

On Tue, Jul 5, 2022 at 11:03 PM Chris Lew <quic_clew@quicinc.com> wrote:
>
> If a smp2p change occurs while a virtual interrupt is disabled, smp2p
> should be able to resend that interrupt on enablement.

That sounds right. I made some attempt to document how I thought this
worked in commit cf9d052aa600 ("pinctrl: qcom: Don't clear pending
interrupts when enabling").


> This functionality requires the CONFIG_HARDIRQS_SW_RESEND to be enabled
> to reschedule the interrupts.

Maybe mention that you don't need to select this yourself because it's
already selected by the arm64 config?


> To ensure the mask and unmask functions
> are called during enabled and disable, set the flag to disable lazy
> IRQ state handling (IRQ_DISABLE_UNLAZY).

From your description of the problem it actually feels like you want
the opposite? When an interrupt is masked lazily then the interrupt
can still fire but won't make it to the client. Then as soon as the
client unmasks the interrupt will fire right away. That's exactly what
you want, isn't it?

Are you certain you need IRQ_DISABLE_UNLAZY?


> Signed-off-by: Chris Lew <quic_clew@quicinc.com>
> ---
>  drivers/soc/qcom/smp2p.c | 18 +++++++++++++-----
>  1 file changed, 13 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/soc/qcom/smp2p.c b/drivers/soc/qcom/smp2p.c
> index 59dbf4b61e6c..1c3259fe98be 100644
> --- a/drivers/soc/qcom/smp2p.c
> +++ b/drivers/soc/qcom/smp2p.c
> @@ -101,6 +101,7 @@ struct smp2p_entry {
>
>         struct irq_domain *domain;
>         DECLARE_BITMAP(irq_enabled, 32);
> +       DECLARE_BITMAP(irq_pending, 32);

You'll get a kernel-doc warning since the rest of the elements in this
structure are documented but your new one isn't...

...in this structure and others you're modifying in this patch...


>         DECLARE_BITMAP(irq_rising, 32);
>         DECLARE_BITMAP(irq_falling, 32);
>
> @@ -146,6 +147,7 @@ struct qcom_smp2p {
>         unsigned local_pid;
>         unsigned remote_pid;
>
> +       int irq;
>         struct regmap *ipc_regmap;
>         int ipc_offset;
>         int ipc_bit;
> @@ -217,8 +219,8 @@ static void qcom_smp2p_notify_in(struct qcom_smp2p *smp2p)
>  {
>         struct smp2p_smem_item *in;
>         struct smp2p_entry *entry;
> +       unsigned long status;
>         int irq_pin;
> -       u32 status;
>         char buf[SMP2P_MAX_ENTRY_NAME];
>         u32 val;
>         int i;
> @@ -247,19 +249,22 @@ static void qcom_smp2p_notify_in(struct qcom_smp2p *smp2p)
>
>                 status = val ^ entry->last_value;
>                 entry->last_value = val;
> +               status |= *entry->irq_pending;
>
>                 /* No changes of this entry? */
>                 if (!status)
>                         continue;
>
> -               for_each_set_bit(i, entry->irq_enabled, 32) {
> -                       if (!(status & BIT(i)))
> -                               continue;
> -
> +               for_each_set_bit(i, &status, 32) {
>                         if ((val & BIT(i) && test_bit(i, entry->irq_rising)) ||
>                             (!(val & BIT(i)) && test_bit(i, entry->irq_falling))) {
>                                 irq_pin = irq_find_mapping(entry->domain, i);
>                                 handle_nested_irq(irq_pin);
> +
> +                               if (test_bit(i, entry->irq_enabled))
> +                                       clear_bit(i, entry->irq_pending);
> +                               else
> +                                       set_bit(i, entry->irq_pending);

Your new logic seems a bit off to me.

For one thing, once an IRQ becomes pending it should stay pending.
With your code I believe that if an IRQ was marked as "rising" and
then it went high and low again while masked that you would lose track
of the interrupt. Normally an edge-triggered interrupt will latch the
edge and keep track of it.

I think the logic should be something like this (untested):

status = val ^ entry->last_value;
entry->last_value = val;

/* IRQs become pending regardless of whether they're masked or not */
for_each_set_bit(i, &status, 32) {
        if ((val & BIT(i) && test_bit(i, entry->irq_rising)) ||
            (!(val & BIT(i)) && test_bit(i, entry->irq_falling)))
                set_bit(i, entry->irq_pending);
}

/* Handled unmasked (AKA enabled) pending IRQs */
for_each_set_bit(i, entry->irq_pending), 32) {
        if (!test_bit(i, entry->irq_enabled))
                continue;
        clear_bit(i, entry->irq_pending);

        irq_pin = irq_find_mapping(entry->domain, i);
        handle_nested_irq(irq_pin);
}
