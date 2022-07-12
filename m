Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6391B5722C3
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 20:37:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231534AbiGLShS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jul 2022 14:37:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229547AbiGLShP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 14:37:15 -0400
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3DFABDBB4;
        Tue, 12 Jul 2022 11:37:14 -0700 (PDT)
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-31d7db3e6e5so59706917b3.11;
        Tue, 12 Jul 2022 11:37:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PBudPr+ef/1eAC7pkkqhWqEt24GxhuAJQSbGXLu+x1M=;
        b=t/+8ISV0mO9RbKKQlOM/ajfYNHhMJKPYrseV/kDnVejYOJWcilXh3s5ye6Q/GV9YbE
         wZNPi5+/90XRAU4yN46lrLMKa6bcGjOAS8bFW42t/x7p4jvzAZy/1+i/8CbWqE+QMllP
         pwYHbX8uk2iBGitt5bQ7GbAj/blkRcE6RtJ+/0V+eHd0x9QZTxRJvP6s8ksfGDuerDHZ
         oc5Dj2IugpNpqzl5sYxaJQoAZk9synJJA208sToTb7rKy3Q/6MlmC4u+anWycd+FH0Fu
         KwNiJmFrvqbDqiZPnF/ijaFdZqNm4Uyasy7VD4sqD+BJlDJcMphZafiGBtqDQ8QlsxBx
         xkQA==
X-Gm-Message-State: AJIora8V9AcaRfbsX0TjKoIRwUKf48E0K66xnQ4AYES1zqDYJDdCG8Xd
        9puzWPJIWS8zH2NDXwhVp2SvvKKoMcsV0NBR3ao=
X-Google-Smtp-Source: AGRyM1sulZRG0Oy7UEdjnNzrAxjmTThiO5ryqzUwyuVFFUHXsC/64KxZwQVWjUa/X1I5gbuG1XEa8M7IaeEx7rxIh6I=
X-Received: by 2002:a0d:d952:0:b0:31d:789d:221c with SMTP id
 b79-20020a0dd952000000b0031d789d221cmr13029452ywe.515.1657651033922; Tue, 12
 Jul 2022 11:37:13 -0700 (PDT)
MIME-Version: 1.0
References: <20220623064605.2538969-1-quic_kshivnan@quicinc.com>
In-Reply-To: <20220623064605.2538969-1-quic_kshivnan@quicinc.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 12 Jul 2022 20:37:03 +0200
Message-ID: <CAJZ5v0hX6H1Z-2bAJvV92YO95N_D=uNotVxJRcA9cmGQwsr1fQ@mail.gmail.com>
Subject: Re: [PATCH] PM: QoS: Add check to make sure CPU freq is non-negative
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

On Thu, Jun 23, 2022 at 8:47 AM Shivnandan Kumar
<quic_kshivnan@quicinc.com> wrote:
>
>         CPU frequency should never be non-negative.

Do you mean "always be non-negative"?

>         If some client driver calls freq_qos_update_request with some
>         value greater than INT_MAX, then it will set max CPU freq at
>         fmax but it will add plist node with some negative priority.
>         plist node has priority from INT_MIN (highest) to INT_MAX
>         (lowest). Once priority is set as negative, another client
>         will not be able to reduce max CPU frequency. Adding check
>         to make sure CPU freq is non-negative will fix this problem.
> Signed-off-by: Shivnandan Kumar <quic_kshivnan@quicinc.com>
>
> ---
>  kernel/power/qos.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/kernel/power/qos.c b/kernel/power/qos.c
> index ec7e1e85923e..41e96fe34bfd 100644
> --- a/kernel/power/qos.c
> +++ b/kernel/power/qos.c
> @@ -531,7 +531,8 @@ int freq_qos_add_request(struct freq_constraints *qos,
>  {
>         int ret;
>
> -       if (IS_ERR_OR_NULL(qos) || !req)
> +       if (IS_ERR_OR_NULL(qos) || !req || value < FREQ_QOS_MIN_DEFAULT_VALUE
> +               || value > FREQ_QOS_MAX_DEFAULT_VALUE)

Why do you check against the defaults?

>                 return -EINVAL;
>
>         if (WARN(freq_qos_request_active(req),
> @@ -563,7 +564,8 @@ EXPORT_SYMBOL_GPL(freq_qos_add_request);
>   */
>  int freq_qos_update_request(struct freq_qos_request *req, s32 new_value)
>  {
> -       if (!req)
> +       if (!req || new_value < FREQ_QOS_MIN_DEFAULT_VALUE ||
> +               new_value > FREQ_QOS_MAX_DEFAULT_VALUE)
>                 return -EINVAL;
>
>         if (WARN(!freq_qos_request_active(req),
> --

I agree that it should guard against adding negative values, but I
don't see why s32 can be greater than INT_MAX.

Also why don't you put the guard into freq_qos_apply() instead of
duplicating it in the callers of that function?
