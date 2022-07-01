Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3E2B563309
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Jul 2022 13:58:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236067AbiGAL63 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Jul 2022 07:58:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233740AbiGAL6W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jul 2022 07:58:22 -0400
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com [IPv6:2607:f8b0:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C32E92BCF
        for <linux-kernel@vger.kernel.org>; Fri,  1 Jul 2022 04:58:21 -0700 (PDT)
Received: by mail-ot1-x334.google.com with SMTP id 72-20020a9d064e000000b00616c2a174bcso1652117otn.8
        for <linux-kernel@vger.kernel.org>; Fri, 01 Jul 2022 04:58:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qdF+RSNMgLBcS3xDVeKhnoMiD/rejai4UUkHp1itl9U=;
        b=TzEQ5h3eOkhlUQMq926n84dZVu5OZJQHbLUxkpx/zmlMCEHgG2AK2Boyf77VKLhrs/
         6+gE3Ypu3F+I6oAFJnQScv//WgvXFlMZTqdC/b2wVNZuvB/9YFfMByyz1fzbSCV5joK4
         7mONaT8QxyaG+5jeMT+e62MiOgzdGaWTMz958wLMcAtIwUHSSGI7sOc3fCxO83XDrfcV
         7H5KjjZWF9G53MO64ypwa8u5409HtIgq8chsbg3QZkSnzqQ449cmp/ju6RgVydouy16f
         /DHX08BvzPvBIpYTnHVoV2lKRp5AedH31734YRXEvq4tSzN5HCiG+KnBdzedmZBqKI4+
         baRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qdF+RSNMgLBcS3xDVeKhnoMiD/rejai4UUkHp1itl9U=;
        b=PRArfWF/DgnDU6F8LJ5Xdy1zK/OCTBu840l8c3FpmNFXZez6l2ElYzfoAs+P4GWNfM
         wLRtLt6gWkEjvsbH0CGuSfBPvYc73pfU0g9Pm0qtKz8natkInO/IU6ed1B3/2ye4+ScP
         ixpYy6pftlmKRJVO0JneTmjyrhpOIdS+8cKlgBzS4wEcrQk+I/4vLK6xA89o8p1W+HJ1
         MG2P9COiYopebdDNqxhW5KrEMJ0G+QgeJStJc6GtQ4SKsKlxd6DQaReVOUcfGsBfeAFm
         4RCKC4tt8DvPQ0EC6NzLzijJcWNP2iz463g9Pmlbqox6YWQg8v10vHebL7jcoSTggc4w
         5cjA==
X-Gm-Message-State: AJIora9RAfbqrdx/VQ7OiDlNScx7903qmzqKlQjTP6JONkOy8Kc7TM/1
        urjYWuVJsFFtA5E/oALofIi8NmdKewY923cc4P4ACw==
X-Google-Smtp-Source: AGRyM1uVIfszKZu+EFEyXeuG0nfNhO5npeNYP9K8liqWxxdkdNL5DPhuXT+s8Upoys03fUvgc843UBZsFx0VdqRBf9I=
X-Received: by 2002:a9d:2ac2:0:b0:60b:2f8b:eaba with SMTP id
 e60-20020a9d2ac2000000b0060b2f8beabamr6355112otb.348.1656676701137; Fri, 01
 Jul 2022 04:58:21 -0700 (PDT)
MIME-Version: 1.0
References: <20220624090055.569400-1-etienne.carriere@linaro.org> <7329b1e1-6337-5430-e90f-7f4c59c00636@foss.st.com>
In-Reply-To: <7329b1e1-6337-5430-e90f-7f4c59c00636@foss.st.com>
From:   Etienne Carriere <etienne.carriere@linaro.org>
Date:   Fri, 1 Jul 2022 13:58:10 +0200
Message-ID: <CAN5uoS_yWujQ=zDHaLqsFuH9w-fnzePhU=CJFwxxLRJOxoEgyw@mail.gmail.com>
Subject: Re: [PATCH] ARM: dts: stm32: fix pwr regulators references to use scmi
To:     Alexandre TORGUE <alexandre.torgue@foss.st.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-stm32@st-md-mailman.stormreply.com,
        devicetree@vger.kernel.org,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks Alex,

By the way, my review tags for other fixes to the scmi DTS files [1],
[2] and [3]:
Acked-by: Etienne Carriere <etienne.carriere@linaro.org>
Tested-by: Etienne Carriere <etienne.carriere@linaro.org>
These are needed for a consistent kernel configuration of these boards.

Br,
etienne

[1] https://lore.kernel.org/lkml/20220624092715.1397827-2-gabriel.fernandez@foss.st.com/
[2] https://lore.kernel.org/lkml/20220624092715.1397827-3-gabriel.fernandez@foss.st.com/
[3] https://lore.kernel.org/lkml/20220624092715.1397827-4-gabriel.fernandez@foss.st.com/

On Fri, 1 Jul 2022 at 13:44, Alexandre TORGUE
<alexandre.torgue@foss.st.com> wrote:
>
> Hi Etienne
>
> On 6/24/22 11:00, Etienne Carriere wrote:
> > Fixes stm32mp15*-scmi DTS files introduced in [1] to also access PWR
> > regulators through SCMI service. This is needed since enabling secure
> > only access to RCC clock and reset controllers also enables secure
> > access only on PWR voltage regulators reg11, reg18 and usb33 hence
> > these must also be accessed through SCMI Voltage Domain protocol.
> > This change applies on commit [2] that already corrects issues from
> > commit [1].
> >
> > Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>
> > Link: [1] https://lore.kernel.org/linux-arm-kernel/20220422150952.20587-7-alexandre.torgue@foss.st.com
> > Link: [2] https://lore.kernel.org/linux-arm-kernel/20220613071920.5463-1-alexandre.torgue@foss.st.com
> > Signed-off-by: Etienne Carriere <etienne.carriere@linaro.org>
> > ---
>
> Applied in stm32-fixes.
>
> Thanks
> Alex
