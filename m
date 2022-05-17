Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2947529A64
	for <lists+linux-kernel@lfdr.de>; Tue, 17 May 2022 09:06:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236552AbiEQHGa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 May 2022 03:06:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235983AbiEQHGT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 May 2022 03:06:19 -0400
Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD65546B37;
        Tue, 17 May 2022 00:06:18 -0700 (PDT)
Received: by mail-qk1-f172.google.com with SMTP id j6so13937535qkp.9;
        Tue, 17 May 2022 00:06:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4FNoWTSP55ndOPeC+jkUPZPRKqM/W1oOHqIRSNLtrZE=;
        b=OBx16Kqb7r/+WLcnb5FTGr2Kr9wGIVdq5Jdby5mqBuZLdpVHcHK3E1WQF78mNvBBeh
         XJDuNNkbP+cUaa3VCXcy6yju/xlqzLEZ4ocvbhDJ7xqUnBL/8lH1aoHAlhp6QPIdlKO3
         XPJuMEq+d/3uCgAsJlskKVeBlvqFj2ssSuxFKY+/TU/NX+w/3gWu7N8D5C4xzANoZm5J
         g8fZ5uCzYvEppngqlHoOtvuqeYwMvNvV/Tsy79ZeTFBGNr7ZIC78/0sYJJU0Ac5sG9lc
         j9oAyiOEkOY1PFRt93WBfXgVMBV7HdsQzomoxxZB+TRErkdWHf6FSx0pS3Q9W1Wn9QCv
         Q28g==
X-Gm-Message-State: AOAM53303j8WQceCZHMUttYYLwqLBqrQuEmXDkAjEy94U+IuVG1ZCB93
        n2hPm80moYX7m4Y/6+GQmw7fhDXxs1ZQFg==
X-Google-Smtp-Source: ABdhPJyEQwLmWKk1r/vhQKb0WeaL4Uaac06SPYPu9OOYJ0V4eBPWc3vpFy/F66G7LnfhB9F/dbHjdw==
X-Received: by 2002:a05:620a:859:b0:6a0:15d6:60ca with SMTP id u25-20020a05620a085900b006a015d660camr15091013qku.350.1652771177812;
        Tue, 17 May 2022 00:06:17 -0700 (PDT)
Received: from mail-yb1-f170.google.com (mail-yb1-f170.google.com. [209.85.219.170])
        by smtp.gmail.com with ESMTPSA id c4-20020ac81104000000b002f3b82571b1sm7326984qtj.1.2022.05.17.00.06.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 May 2022 00:06:17 -0700 (PDT)
Received: by mail-yb1-f170.google.com with SMTP id o80so11135242ybg.1;
        Tue, 17 May 2022 00:06:17 -0700 (PDT)
X-Received: by 2002:a25:e04d:0:b0:64d:6f23:b906 with SMTP id
 x74-20020a25e04d000000b0064d6f23b906mr13099556ybg.380.1652771177087; Tue, 17
 May 2022 00:06:17 -0700 (PDT)
MIME-Version: 1.0
References: <20220517033526.2035735-1-zhangjialin11@huawei.com>
In-Reply-To: <20220517033526.2035735-1-zhangjialin11@huawei.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 17 May 2022 09:06:05 +0200
X-Gmail-Original-Message-ID: <CAMuHMdW4Zm+iAu5Pwwsf4cF-QUSk-aqQXosK5VpL56Y1EOPXyw@mail.gmail.com>
Message-ID: <CAMuHMdW4Zm+iAu5Pwwsf4cF-QUSk-aqQXosK5VpL56Y1EOPXyw@mail.gmail.com>
Subject: Re: [PATCH] iio: adc: rzg2l_adc: add missing fwnode_handle_put() in rzg2l_adc_parse_properties()
To:     Jialin Zhang <zhangjialin11@huawei.com>
Cc:     "Lad, Prabhakar" <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Biju Das <biju.das.jz@bp.renesas.com>,
        linux-iio@vger.kernel.org,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
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

On Tue, May 17, 2022 at 6:44 AM Jialin Zhang <zhangjialin11@huawei.com> wrote:
> fwnode_handle_put() should be used when terminating
> device_for_each_child_node() iteration with break or
> return to prevent stale device node references from
> being left behind.
>
> Fixes: d484c21bacfa ("iio: adc: Add driver for Renesas RZ/G2L A/D converter")
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Jialin Zhang <zhangjialin11@huawei.com>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
