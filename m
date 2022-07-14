Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3EDD575549
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jul 2022 20:45:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238378AbiGNSpf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jul 2022 14:45:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234681AbiGNSpd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jul 2022 14:45:33 -0400
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9914A2655A;
        Thu, 14 Jul 2022 11:45:32 -0700 (PDT)
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-31c89111f23so26630097b3.0;
        Thu, 14 Jul 2022 11:45:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vycimkfJJnUL5HYw9lyGFjZXDKTehh2hU0oCewywAvI=;
        b=DV9o9bOE2Mdx4/RFGQGCclZB9ONoYZwFrhrQcgmJMPU9RAHghOel1DQ5ZfESTR7Ese
         xYHU8czOYOLn5yGoBkwSzeRlaOVn1M6uYOeevraYU2caa+flKs0aiuFWfBowMOVXMnqX
         wwGzbcWEmIGpQsmUkGHB0F5qx8qce1Wq4wjUaXqqpF2Lwm7nSvvDKyte7oh3DR8szb4/
         u5LFiGnnbi9ZW2J3Upd+ygLkB7GmTtGaFDe8ySvQjk+QUKKWALMvYkzoCcBYkfIVPOcT
         9zCTx3WXSTXuPSWyuzulFmU5aW5M5yxhSe2iVVUgVLwrx9G87wrTd+s07n7MklwAj5dh
         JGfA==
X-Gm-Message-State: AJIora9a4Gc7Q+xhBqjLNyoaOE6fnZSCic37yhnDBS8QS0RIA9eJI+ck
        BcMU8h3Ssfdbte5OTu9RneBi9lQU8tti4IphAZU=
X-Google-Smtp-Source: AGRyM1vHXH+1iJc3fePh9kl8IreHJ4qMF9LS3Ans67zy8K7b8p6RgOnh1NOLD+eu32cfeWgS06ViSKGFAASJAX1wdBc=
X-Received: by 2002:a0d:d952:0:b0:31d:789d:221c with SMTP id
 b79-20020a0dd952000000b0031d789d221cmr11204391ywe.515.1657824331896; Thu, 14
 Jul 2022 11:45:31 -0700 (PDT)
MIME-Version: 1.0
References: <20220714134342.3498384-1-quic_kshivnan@quicinc.com>
In-Reply-To: <20220714134342.3498384-1-quic_kshivnan@quicinc.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 14 Jul 2022 20:45:21 +0200
Message-ID: <CAJZ5v0hQ=YXEysP0vWruwiPV+ubQoc_rTwQ1K=Y3p7hjm8UFMg@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] PM: QoS: Add check to make sure CPU freq is non-negative
To:     Shivnandan Kumar <quic_kshivnan@quicinc.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 14, 2022 at 3:44 PM Shivnandan Kumar
<quic_kshivnan@quicinc.com> wrote:
>
>         CPU frequency should never be negative.
>         If some client driver calls freq_qos_update_request with some
>         value greater than INT_MAX, then it will set max CPU freq at
>         fmax but it will add plist node with some negative priority.
>         plist node has priority from INT_MIN (highest) to INT_MAX
>         (lowest). Once priority is set as negative, another client
>         will not be able to reduce CPU frequency. Adding check to
>         make sure CPU freq is non-negative will fix this problem.

The changelog doesn't match the patch any more, please rewrite it.

>
> Signed-off-by: Shivnandan Kumar <quic_kshivnan@quicinc.com>
>
> ---
> v1->v2
>         -addressed comments from Rafael
>         -changed commit text accordingly
>
>  kernel/power/qos.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/kernel/power/qos.c b/kernel/power/qos.c
> index ec7e1e85923e..27e6596f287a 100644
> --- a/kernel/power/qos.c
> +++ b/kernel/power/qos.c
> @@ -531,7 +531,7 @@ int freq_qos_add_request(struct freq_constraints *qos,
>  {
>         int ret;
>
> -       if (IS_ERR_OR_NULL(qos) || !req)
> +       if (IS_ERR_OR_NULL(qos) || !req || value < FREQ_QOS_MIN_DEFAULT_VALUE)
>                 return -EINVAL;
>
>         if (WARN(freq_qos_request_active(req),
> @@ -563,7 +563,7 @@ EXPORT_SYMBOL_GPL(freq_qos_add_request);
>   */
>  int freq_qos_update_request(struct freq_qos_request *req, s32 new_value)
>  {
> -       if (!req)
> +       if (!req || new_value < FREQ_QOS_MIN_DEFAULT_VALUE)
>                 return -EINVAL;
>
>         if (WARN(!freq_qos_request_active(req),
> --
> 2.25.1
>
