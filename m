Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C85C555314
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jun 2022 20:15:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377533AbiFVSPP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jun 2022 14:15:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346019AbiFVSPN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 14:15:13 -0400
Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54BAB3CA45;
        Wed, 22 Jun 2022 11:15:13 -0700 (PDT)
Received: by mail-qv1-f46.google.com with SMTP id g18so18839431qvn.2;
        Wed, 22 Jun 2022 11:15:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=S6RaOwUUNsa35j0zwNNMMC8L4W+AYUi6AJGjFqNAiII=;
        b=0kQHv3upiApeFF9omqaSCSpIB6eQU+qedKYNIKpqhxiC9TEarUoDcnkfNeNxvupMuW
         IHKT2NZgK8/apwvbpZs/Zacdy2YjhIJMqScQpp7NYKNtLzrdVeeLgvdnIi2sIYxReHEc
         kg2DSjXREoMBTCqh52/ZAtJ41A4nLWXqne9Lg+zpCAP+6Mr3WD81vUWLzm2nHF4N7U4j
         lSJxub34JFhfouQ5q2f5NFHFhZiLaLcSrID//FE8BvoTQMT+B8WPQrHVrwKAPub3/7Jj
         un3wiqVWZcvzDmyYIk1b15CsW9eWOsdQc77YZL9kJx+CpPa048P9zdrKX7aqZ3AVoPEn
         SLFQ==
X-Gm-Message-State: AJIora+XuyRFdqeWNwoxTAa0ZNA+xgb+TlQKyfohUYX+x40c1aqkVGWX
        5l+MqpHdMzr5oDj3W/iSpx5lbVnnhDaDBA==
X-Google-Smtp-Source: AGRyM1tX061kOF6g0bbkPK1fACkx8BYGnjyjvtFfOzKMkAQaEDhl0Ipzh1e7offsAn173Kg4ihtJ3w==
X-Received: by 2002:ad4:5ba1:0:b0:46e:2f1f:9836 with SMTP id 1-20020ad45ba1000000b0046e2f1f9836mr28566864qvq.87.1655921712257;
        Wed, 22 Jun 2022 11:15:12 -0700 (PDT)
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com. [209.85.128.172])
        by smtp.gmail.com with ESMTPSA id u12-20020a37ab0c000000b006a34a22bc60sm16148165qke.9.2022.06.22.11.15.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Jun 2022 11:15:11 -0700 (PDT)
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-3137316bb69so170898137b3.10;
        Wed, 22 Jun 2022 11:15:11 -0700 (PDT)
X-Received: by 2002:a81:3a81:0:b0:317:7dcf:81d4 with SMTP id
 h123-20020a813a81000000b003177dcf81d4mr5778535ywa.47.1655921710907; Wed, 22
 Jun 2022 11:15:10 -0700 (PDT)
MIME-Version: 1.0
References: <20220622173614.12778-1-prabhakar.mahadev-lad.rj@bp.renesas.com> <20220622173614.12778-2-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20220622173614.12778-2-prabhakar.mahadev-lad.rj@bp.renesas.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 22 Jun 2022 20:14:59 +0200
X-Gmail-Original-Message-ID: <CAMuHMdXsOHtmdbO8B=hVFV2MEz1TszxtOK2c651racyREYU=0g@mail.gmail.com>
Message-ID: <CAMuHMdXsOHtmdbO8B=hVFV2MEz1TszxtOK2c651racyREYU=0g@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] mmc: renesas_sdhi: Get the reset handle early in
 the probe
To:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Cc:     Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Pavel Machek <pavel@denx.de>,
        Linux MMC List <linux-mmc@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Prabhakar <prabhakar.csengg@gmail.com>,
        Biju Das <biju.das.jz@bp.renesas.com>
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

On Wed, Jun 22, 2022 at 7:36 PM Lad Prabhakar
<prabhakar.mahadev-lad.rj@bp.renesas.com> wrote:
> In case of devm_reset_control_get_optional_exclusive() failure we returned
> directly instead of jumping to the error path to roll back initialization.
>
> This patch moves devm_reset_control_get_optional_exclusive() early in the
> probe so that we have the reset handle prior to initialization of the
> hardware.
>
> Fixes: b4d86f37eacb7 ("mmc: renesas_sdhi: do hard reset if possible")
> Reported-by: Pavel Machek <pavel@denx.de>
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
