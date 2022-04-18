Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 078DA505C89
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Apr 2022 18:40:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346348AbiDRQmz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Apr 2022 12:42:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346323AbiDRQmt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Apr 2022 12:42:49 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CC801CB1E;
        Mon, 18 Apr 2022 09:40:09 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id i27so27801231ejd.9;
        Mon, 18 Apr 2022 09:40:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FuAliLqkyYXn5Ey/EtjXF/Yu7oHI4/uKKrNgvBgX40c=;
        b=HebNsdKGP3yphWPGFSkZWvD1iaQWfLNxZhW5jTbTLcZ0S9fAgKGiXLbBg0TTnvT1FV
         c+JA3Udj18Mo6SUExXKSxsdd9J7tPqMULdZH0/E38SvMlKDPHNy2U+HBA4bTUcZCELQ9
         7aWOae4pdxva6sKGa8anR8axhqdxJafsgCBs6B0HLBVIqjT55F6K0yVvqtpVlHgzSsR3
         oqcazq59cY18iTwty+ozgl8CAztirZoyHNS+kPeicq2sOhwdQVAYx5IGmz7Eo8t2HBO/
         16egiV3IkjJrfXb4R7JU3+I3tsrPwTNDTiTQRUITme099wLOvPIWWFiseZdAVpqdnhIs
         Fs0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FuAliLqkyYXn5Ey/EtjXF/Yu7oHI4/uKKrNgvBgX40c=;
        b=Q8FLVFVIVU4kLNZvewQoOd+PBOS90CheqTms8PWlcJM2WQNdUmSo1SQQa73Vq7+55S
         Df7nDdSIVwbv9LZQMu4gCGCTa9g7ePItHUnp2fZJnxog1MhUxP1PWKsDqwIxT626GO1C
         dcskOXS71Q/MG9CWlUyCfT3Woc+EkxPk2T3z0LeA7uWUZCvTj8mvEMEpfQ//Z20+eOi6
         IukD4siND63melzMKiW1TlAS/QzwkirABdCOk9bqNcdmYSs1j3y5uojp9o/O+pS/tPTa
         QqhP6vkwHHT4EjtHNOQmAcXj0q+IfGroXCrbld8hP1ClIzA/7t1R63iSXRXuW480JL1Z
         JBcQ==
X-Gm-Message-State: AOAM532D5Qu1BCfX/q03pZTpuPufybxYONt2JM4cXE1ppmbkA9vQ6lXl
        iWBlVwjegane26gVLIXSgPBTS9hvXkfHwDC7kZK18fapW40=
X-Google-Smtp-Source: ABdhPJyaKoj4mv6UqdwrhwT31wWEjGcRuUu2PMnQVHnJsiFOgYOIT6nlTXzwAvL3RiTlQyiw6ulI4AiN0g5tlciXxKs=
X-Received: by 2002:a17:907:7d90:b0:6e8:cd12:8893 with SMTP id
 oz16-20020a1709077d9000b006e8cd128893mr10072953ejc.13.1650300008182; Mon, 18
 Apr 2022 09:40:08 -0700 (PDT)
MIME-Version: 1.0
References: <tencent_FE734C50BC851F2AB5FE1380F833A7E67A0A@qq.com>
In-Reply-To: <tencent_FE734C50BC851F2AB5FE1380F833A7E67A0A@qq.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Mon, 18 Apr 2022 18:39:57 +0200
Message-ID: <CAFBinCC=Dp4bXT9sbmT=ZTiVfC1Mj=oRVxeDXfKbDczq45iekQ@mail.gmail.com>
Subject: Re: [PATCH] clk: meson: meson8b: fix a memory leak in meson8b_clkc_init_common()
To:     xkernel.wang@foxmail.com
Cc:     Neil Armstrong <narmstrong@baylibre.com>, jbrunet@baylibre.com,
        mturquette@baylibre.com, sboyd@kernel.org, khilman@baylibre.com,
        p.zabel@pengutronix.de, linux-amlogic@lists.infradead.org,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

first of all: thank you for this patch!

On Thu, Apr 7, 2022 at 11:28 AM <xkernel.wang@foxmail.com> wrote:
>
> From: Xiaoke Wang <xkernel.wang@foxmail.com>
>
> `rstc` is allocated by kzalloc() for resetting the controller register,
> however, if reset_controller_register() fails, `rstc` is not properly
> released before returning, which can lead to memory leak.
> Therefore, this patch adds kfree(rstc) on the above error path.
In general I am fine with this approach. There's some more "return"
statements below. Should these be covered as well?

Also a note about meson8b_clkc_init_common() itself: failures in that
function will result in a non-working system.
If we can't register the reset controller then most devices won't
probe and CPU SMP cannot work.
If registering any clock or the clock controller doesn't work then the
system also won't work as clocks are not available to other drivers.
So freeing memory in case of an error is good to have, but the end
result is still the same: the system won't work.


Best regards,
Martin
