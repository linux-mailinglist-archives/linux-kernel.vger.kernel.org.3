Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E7F4507BDD
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 23:22:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357981AbiDSVYq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 17:24:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357976AbiDSVYl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 17:24:41 -0400
Received: from mail-yb1-xb34.google.com (mail-yb1-xb34.google.com [IPv6:2607:f8b0:4864:20::b34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DFF041FA6
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 14:21:57 -0700 (PDT)
Received: by mail-yb1-xb34.google.com with SMTP id t67so33428420ybi.2
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 14:21:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uFa5rTd0mVzbn/LyQsQjYiYFNZBK/D6kGFcBSmtjLzY=;
        b=jZGIoPgbLJiiEHlzQQgD7dBWSd44jma5Asn5zN8Hv+DzGVfn+Z8QYPBZF/yOMRxI36
         +697N4jLNJkwyf2GT1+HWAEz681hCqZn1RZH9RC2xJyu2MAgEKPu9qd3qqPWgweNd60O
         IZVgKVP3TQzl5GanOxBptfUgEOwCkizZD18Mq9ySHXdBckEYkY5ARw9doi5IRCSn8N+K
         SLU+rOP0uYgBKhZcv6e689XcsNVhwgZrxt/gXMwRP2JciAuY4++kl0nrUeJ4B4LFau6m
         h2LiQZH3uoKqnhkGJ5V4ualqtverZx96tnLKt3zzGHaELFiHSzuAX4BomV4/rra90cug
         WN6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uFa5rTd0mVzbn/LyQsQjYiYFNZBK/D6kGFcBSmtjLzY=;
        b=koKJ+nYo3AY6on4JoHl/tCmfvSqVkSBpHj7kt9NaSfP5PCRfjHntqQi039SNTk4JsB
         cLZFTvlL1/MG2nzdI/96KjNmqxODtKyl1X8v+zLs81ZMxJcxae5/9OFmm2qyquGnk10r
         31YZTRsb2GGWNaCCkdvjh+NFn6WAUGq/oPYkwxfFJVs8GjqxE4ex6PyEloQnUxJ1jRM7
         1m3wv9F3gKVeZW1DjjppvdmOS1F6OFDN8c4CZ/naI1S6QFF8SmenXlkc+RcePhVPRnG6
         /HFnB+R8lZUnkpH2UMPmZ6P0tkUhKVQ99uQY07fGV60pRc282gRx41+o2thrbF+xMkw2
         czFA==
X-Gm-Message-State: AOAM533s5vIAWyFc6wxdfpFSeKvWQZAI0n3kiqNdbpeNxjthI7MY4V8F
        72rPrNqYrryx0XqLfmCep+YdB5+X44i3j4PckZldwg==
X-Google-Smtp-Source: ABdhPJysRmddY6nT3hJooaAQ8BuTBiC61BBGBEyVsL1Lb67LFGJd2WHsNLGvyHgeulgTFv/nksGEdAm30zL3GtNCK20=
X-Received: by 2002:a5b:dc5:0:b0:624:f16d:7069 with SMTP id
 t5-20020a5b0dc5000000b00624f16d7069mr17263610ybr.295.1650403316892; Tue, 19
 Apr 2022 14:21:56 -0700 (PDT)
MIME-Version: 1.0
References: <1649048650-14059-1-git-send-email-quic_rohiagar@quicinc.com>
In-Reply-To: <1649048650-14059-1-git-send-email-quic_rohiagar@quicinc.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 19 Apr 2022 23:21:45 +0200
Message-ID: <CACRpkdZKHbWH4EO7nMJJqiXsSWNq9OikpVwC1dY5bh1y9E_tcw@mail.gmail.com>
Subject: Re: [PATCH 0/2] Add pmx65 support for pinctrl
To:     Rohit Agarwal <quic_rohiagar@quicinc.com>
Cc:     agross@kernel.org, bjorn.andersson@linaro.org, robh+dt@kernel.org,
        krzk+dt@kernel.org, linux-arm-msm@vger.kernel.org,
        linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 4, 2022 at 7:04 AM Rohit Agarwal <quic_rohiagar@quicinc.com> wrote:

> Separating the two patches from the original patch series
> "Add Power Domains and Regulators in SDX65" as suggested
> by Linus Walleij.
>
> Thanks,
> Rohit.

Patches applied! They have surely been reviewed long enough.

Yours,
Linus Walleij
