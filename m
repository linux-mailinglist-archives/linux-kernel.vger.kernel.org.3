Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFA325760E2
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jul 2022 13:50:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234755AbiGOLub (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jul 2022 07:50:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229747AbiGOLu2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jul 2022 07:50:28 -0400
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DF533CBE9;
        Fri, 15 Jul 2022 04:50:28 -0700 (PDT)
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-31bf3656517so44253307b3.12;
        Fri, 15 Jul 2022 04:50:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ODlRaYl4nNRZcLflmQwFsIPgbljwKqGpNV/7h9powFk=;
        b=2lChuzPi2HlMc6hYANmHzd4zeumeQTXQU+F1ZkMNmwD625scgBW5FGYlV5zk4iJfkY
         bmjY5tg7uzkndb1j2kWL+Ihaj/Go/18glCSUpJYMikKwRcDX5Bzj7pW9djFSX6eSCgFh
         VJ/Rw4N54fBe8xNCoxKJzFiwuCfZhbwfpqjhCxaGlXg6taAkmgjikDRqdQ3jaeLOp6KI
         ULL1YuhYcf4/ef/i+mWQ+OouI95d11s8ISDHFStn087R/41C5EgYUecMsz39MHvvsBsO
         owloJcnUtS6QkKfkyovsuFE+v3pwpqgGOSWpL6+ScmpPCCqNPBaBWMG+gNrtCO8O+AnC
         sT5g==
X-Gm-Message-State: AJIora9uRE9GB5p9HsSPoFlECyJLes5MYf8uiZhbVAnsnEHVyvRZZNxq
        2xOr1Qy0g92f45ynW2aIl+/mdCsmfWiyPLy9KczA2ybSGJU=
X-Google-Smtp-Source: AGRyM1tpHdel1yo/M53zZ2Ww9xBIekgUzwaULf7gOTm7kr6pdXL+fsmU3yQDoD7D+tAriRliTJE2Ah2eDdXb0IXHako=
X-Received: by 2002:a81:5957:0:b0:31c:f620:17ef with SMTP id
 n84-20020a815957000000b0031cf62017efmr14883687ywb.19.1657885827529; Fri, 15
 Jul 2022 04:50:27 -0700 (PDT)
MIME-Version: 1.0
References: <20220715040949.3807070-1-quic_kshivnan@quicinc.com>
In-Reply-To: <20220715040949.3807070-1-quic_kshivnan@quicinc.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 15 Jul 2022 13:50:15 +0200
Message-ID: <CAJZ5v0hBTGJ3K5VMnef22-6yEU7rDn1wMBmgqeu41wKQyydNgA@mail.gmail.com>
Subject: Re: [PATCH v3]PM: QoS: Add check to make sure CPU freq is non-negative
To:     Shivnandan Kumar <quic_kshivnan@quicinc.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 15, 2022 at 6:10 AM Shivnandan Kumar
<quic_kshivnan@quicinc.com> wrote:
>
>         CPU frequency should never be negative.
>         If some client driver calls freq_qos_update_request with
>         negative value which will be very high in absolute terms,
>         then qos driver set max CPU freq at fmax as it consider
>         it's absolute value but it will add plist node with negative
>         priority. plist node has priority from INT_MIN (highest)
>         to INT_MAX(lowest). Once priority is set as negative,
>         another client will not be able to reduce CPU frequency.
>         Adding check to make sure CPU freq is non-negative will
>         fix this problem.
>
> Signed-off-by: Shivnandan Kumar <quic_kshivnan@quicinc.com>
> ---
> v2->v3
>         -changed commit text
> v1->v2
>         -addressed comments from Rafael
>         -changed commit text accordingly
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

Why not just put 0 in there directly instead of FREQ_QOS_MIN_DEFAULT_VALUE?

As is, it is somewhat confusing (and same below).

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
