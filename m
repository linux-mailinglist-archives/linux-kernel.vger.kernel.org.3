Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 476455819F9
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jul 2022 20:50:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239694AbiGZSuA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jul 2022 14:50:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234098AbiGZSt7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jul 2022 14:49:59 -0400
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99CBA33A0F;
        Tue, 26 Jul 2022 11:49:58 -0700 (PDT)
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-31f56c42ab5so16171587b3.10;
        Tue, 26 Jul 2022 11:49:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=yPFBVlu0ObcRvnu08ApRMdRFd37TOD9Ck2WSxYLLAak=;
        b=xzJHEuceeGaCoGU8Jw71QmNaI4UDtNOXeP9tPrEsg/wnDVliOZm9mM+faE9+BVzRWY
         kIT2IrEvkwA6F4p4u3/tlOP2GW1lfkakLBfxDYYzzPCW/9ko7xLWpECxG19haL9Y6GwD
         x/GWWg1GFaip3tHZkcrFf1oY50pAeazHh/vOfdEBlVxqugFpF4ml55OxYKUT9MdE0dMe
         dFaGTuPgkz/zpsB9yilb/vfcCvD422hycKzQNyhxhi2MULJA5fvQ+XkZomRKUwn3HWuV
         bD43Zyz64u0/FsSQVIuDvuBpzyJW3sVdDrluSkGIMSJe56QuqiLcFsWU8pmphHk4W4wl
         KbSA==
X-Gm-Message-State: AJIora99fgXEly9SvVDapru5XsJ6wiV+z/LfWu8L2Gr65t9d6Mei1LGF
        h0T61NGnAfuYqk7wb4tffg4xqKlv/CsmldqTc68=
X-Google-Smtp-Source: AGRyM1uYzWJTgl9AUnf50Mem4W2oNSii45IbbvWm02rpcEVSHnldNWsTv6klxTrj/yRH+hRkZJSN6wQ75jzs6LNACwA=
X-Received: by 2002:a81:78c6:0:b0:31e:848b:6e2 with SMTP id
 t189-20020a8178c6000000b0031e848b06e2mr16334621ywc.301.1658861397853; Tue, 26
 Jul 2022 11:49:57 -0700 (PDT)
MIME-Version: 1.0
References: <20220715122539.3978614-1-quic_kshivnan@quicinc.com>
In-Reply-To: <20220715122539.3978614-1-quic_kshivnan@quicinc.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 26 Jul 2022 20:49:46 +0200
Message-ID: <CAJZ5v0jykjSWrrv7Cd_bPi0s8g7DgGQAEEzajq6RFURwQtbAqw@mail.gmail.com>
Subject: Re: [PATCH v4]PM: QoS: Add check to make sure CPU freq is non-negative
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

On Fri, Jul 15, 2022 at 2:27 PM Shivnandan Kumar
<quic_kshivnan@quicinc.com> wrote:
>
>         CPU frequency should never be negative.
>         If some client driver calls freq_qos_update_request with
>         negative value which will be very high in absolute terms,
>         then qos driver sets max CPU freq at fmax as it considers
>         it's absolute value but it will add plist node with negative
>         priority. plist node has priority from INT_MIN (highest)
>         to INT_MAX(lowest). Once priority is set as negative,
>         another client will not be able to reduce CPU frequency.
>         Adding check to make sure CPU freq is non-negative will
>         fix this problem.
>
> Signed-off-by: Shivnandan Kumar <quic_kshivnan@quicinc.com>
> ---
> v3->v4
>         -used 0 instead of FREQ_QOS_MIN_DEFAULT_VALUE
> v2->v3
>         -changed commit text
> v1->v2
>         -addressed comments from Rafael
>         -changed commit text accordingly
>  kernel/power/qos.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/kernel/power/qos.c b/kernel/power/qos.c
> index ec7e1e85923e..af51ed6d45ef 100644
> --- a/kernel/power/qos.c
> +++ b/kernel/power/qos.c
> @@ -531,7 +531,7 @@ int freq_qos_add_request(struct freq_constraints *qos,
>  {
>         int ret;
>
> -       if (IS_ERR_OR_NULL(qos) || !req)
> +       if (IS_ERR_OR_NULL(qos) || !req || value < 0)
>                 return -EINVAL;
>
>         if (WARN(freq_qos_request_active(req),
> @@ -563,7 +563,7 @@ EXPORT_SYMBOL_GPL(freq_qos_add_request);
>   */
>  int freq_qos_update_request(struct freq_qos_request *req, s32 new_value)
>  {
> -       if (!req)
> +       if (!req || new_value < 0)
>                 return -EINVAL;
>
>         if (WARN(!freq_qos_request_active(req),
> --

Applied as 5.20 material, thanks!
