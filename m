Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 222575A46E7
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Aug 2022 12:14:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229706AbiH2KOh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Aug 2022 06:14:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229663AbiH2KOf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Aug 2022 06:14:35 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F2791EEF2
        for <linux-kernel@vger.kernel.org>; Mon, 29 Aug 2022 03:14:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 373BDB80E4D
        for <linux-kernel@vger.kernel.org>; Mon, 29 Aug 2022 10:14:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CEF2EC433C1
        for <linux-kernel@vger.kernel.org>; Mon, 29 Aug 2022 10:14:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661768071;
        bh=8mRXtur5e07Eo3TgU293otnv/4nMQhC/cR9X2OpR4KM=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=u+O//kNKnZXqlGs25hILIj73hBJ1QrYkqzaj0HBvjHWbXShphLT9WKeCyEkZKfhJf
         VE9++mY581iY2aXGAGvmHCfIgfDrjqPk+cKt0k8xC6lzqbqQL4S8RjdKIKGkahi24v
         buC8srHHxSJyW246E3Vrm60Oqsof8Vj8cOHjy/JZroB9U5B4XINHyiGYFavEkCRwEq
         PztULHIux5GhUIxGuW7eLEkZPSFely09xiKXMTzANu+yxOeTubDxJs5VkhDvhbtrm6
         6LherkN2d+68vZ3WVgcCvS5olzXkl+UF4mU1dK8Pz9F6m7Fd0QE3rvQ5bkNdQWNXyx
         iAa9otBHaQTpg==
Received: by mail-ot1-f44.google.com with SMTP id 6-20020a9d0106000000b0063963134d04so5572843otu.3
        for <linux-kernel@vger.kernel.org>; Mon, 29 Aug 2022 03:14:31 -0700 (PDT)
X-Gm-Message-State: ACgBeo1TfODpNaWd2t3fPiRzQe9Dp7x+LyTKrFnTEHN7rkSv3UeVdP2o
        lBKzJszkcGjUO+0CcC+7hXOEG8MTnHiKPpJ00Xc=
X-Google-Smtp-Source: AA6agR507Xn/xHhEo86E5es1to1vy8TPLqGgokrCB95baG6AisBHnuAxI08IXKqsKBMUVdjTCSU4Ko9Zi3K8sUybsTc=
X-Received: by 2002:a05:6830:1e85:b0:638:c371:a00d with SMTP id
 n5-20020a0568301e8500b00638c371a00dmr6128672otr.177.1661768070976; Mon, 29
 Aug 2022 03:14:30 -0700 (PDT)
MIME-Version: 1.0
References: <20220825133123.1874337-1-yangyingliang@huawei.com>
In-Reply-To: <20220825133123.1874337-1-yangyingliang@huawei.com>
From:   Oded Gabbay <ogabbay@kernel.org>
Date:   Mon, 29 Aug 2022 13:14:04 +0300
X-Gmail-Original-Message-ID: <CAFCwf13WoDk6y435zmG5VQa1kRqDo1TA26ZhT5=bTp6qtQr8XQ@mail.gmail.com>
Message-ID: <CAFCwf13WoDk6y435zmG5VQa1kRqDo1TA26ZhT5=bTp6qtQr8XQ@mail.gmail.com>
Subject: Re: [PATCH -next] habanalabs/gaudi2: fix free irq in error path in gaudi2_enable_msix()
To:     Yang Yingliang <yangyingliang@huawei.com>
Cc:     "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 25, 2022 at 4:23 PM Yang Yingliang <yangyingliang@huawei.com> wrote:
>
> Add two variables to store completion irq and event queue irq. And add
> a new lable to free event queue irq in error path in gaudi2_enable_msix().
>
> Fixes: d7bb1ac89b2f ("habanalabs: add gaudi2 asic-specific code")
> Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
> ---
>  drivers/misc/habanalabs/gaudi2/gaudi2.c | 21 +++++++++++++--------
>  1 file changed, 13 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/misc/habanalabs/gaudi2/gaudi2.c b/drivers/misc/habanalabs/gaudi2/gaudi2.c
> index 98336a1a84b0..54eca19b270b 100644
> --- a/drivers/misc/habanalabs/gaudi2/gaudi2.c
> +++ b/drivers/misc/habanalabs/gaudi2/gaudi2.c
> @@ -3518,6 +3518,7 @@ static int gaudi2_enable_msix(struct hl_device *hdev)
>         struct asic_fixed_properties *prop = &hdev->asic_prop;
>         struct gaudi2_device *gaudi2 = hdev->asic_specific;
>         int rc, irq, i, j, user_irq_init_cnt;
> +       int completion_irq, event_queue_irq;
>         irq_handler_t irq_handler;
>         struct hl_cq *cq;
>
> @@ -3532,17 +3533,19 @@ static int gaudi2_enable_msix(struct hl_device *hdev)
>                 return rc;
>         }
>
> -       irq = pci_irq_vector(hdev->pdev, GAUDI2_IRQ_NUM_COMPLETION);
> +       completion_irq = pci_irq_vector(hdev->pdev, GAUDI2_IRQ_NUM_COMPLETION);
>         cq = &hdev->completion_queue[GAUDI2_RESERVED_CQ_CS_COMPLETION];
> -       rc = request_irq(irq, hl_irq_handler_cq, 0, gaudi2_irq_name(GAUDI2_IRQ_NUM_COMPLETION), cq);
> +       rc = request_irq(completion_irq, hl_irq_handler_cq, 0,
> +                        gaudi2_irq_name(GAUDI2_IRQ_NUM_COMPLETION), cq);
>         if (rc) {
>                 dev_err(hdev->dev, "Failed to request IRQ %d", irq);
Please fix the error prints to print the correct irq.
And I think you should remove the "irq" local variable completely.

Oded

>                 goto free_irq_vectors;
>         }
>
> -       irq = pci_irq_vector(hdev->pdev, GAUDI2_IRQ_NUM_EVENT_QUEUE);
> -       rc = request_irq(irq, hl_irq_handler_eq, 0, gaudi2_irq_name(GAUDI2_IRQ_NUM_EVENT_QUEUE),
> -                       &hdev->event_queue);
> +       event_queue_irq = pci_irq_vector(hdev->pdev, GAUDI2_IRQ_NUM_EVENT_QUEUE);
> +       rc = request_irq(event_queue_irq, hl_irq_handler_eq, 0,
> +                        gaudi2_irq_name(GAUDI2_IRQ_NUM_EVENT_QUEUE),
> +                        &hdev->event_queue);
>         if (rc) {
>                 dev_err(hdev->dev, "Failed to request IRQ %d", irq);
>                 goto free_completion_irq;
> @@ -3551,7 +3554,7 @@ static int gaudi2_enable_msix(struct hl_device *hdev)
>         rc = gaudi2_dec_enable_msix(hdev);
>         if (rc) {
>                 dev_err(hdev->dev, "Failed to enable decoder IRQ");
> -               goto free_completion_irq;
> +               goto free_event_queue_irq;
>         }
>
>         for (i = GAUDI2_IRQ_NUM_USER_FIRST, j = prop->user_dec_intr_count, user_irq_init_cnt = 0;
> @@ -3582,9 +3585,11 @@ static int gaudi2_enable_msix(struct hl_device *hdev)
>
>         gaudi2_dec_disable_msix(hdev, GAUDI2_IRQ_NUM_SHARED_DEC1_ABNRM + 1);
>
> +free_event_queue_irq:
> +       free_irq(event_queue_irq, &hdev->event_queue);
> +
>  free_completion_irq:
> -       irq = pci_irq_vector(hdev->pdev, GAUDI2_IRQ_NUM_COMPLETION);
> -       free_irq(irq, cq);
> +       free_irq(completion_irq, cq);
>
>  free_irq_vectors:
>         pci_free_irq_vectors(hdev->pdev);
> --
> 2.25.1
>
