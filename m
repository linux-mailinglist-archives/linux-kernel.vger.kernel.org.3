Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E954568360
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jul 2022 11:26:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232019AbiGFJRl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jul 2022 05:17:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231305AbiGFJRj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 05:17:39 -0400
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E943F1D
        for <linux-kernel@vger.kernel.org>; Wed,  6 Jul 2022 02:17:35 -0700 (PDT)
Received: by mail-qt1-f173.google.com with SMTP id bs20so17373300qtb.11
        for <linux-kernel@vger.kernel.org>; Wed, 06 Jul 2022 02:17:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=N5bac8l9SxzDPCg8iINwZ/ihRJfBHL5uFQtEx4wJI88=;
        b=y6z3DMha2liFgpENA6KifpWCPnxnR3MF52rrpZO0trFRvPd069l3q4mjccd0jF5n83
         x73D5N7GokdTyDhNMF1Nf/zYn31ZaztXk5NQGRuUoDSx3090HvrP/GviziKMDJQRj7d6
         tNyMrbioqXiy3RQvacNwj7gKxK2yRAwULG4VPFGB+1fGbgWEOSoQhaeGBY311oes0fWF
         EtwXh4+eebJMVOLbRPCjuJE9Sd8XPQHwXA5GvK+JssbtT83sUKKDiDsWpEG2Cyp6+RZG
         KmHqDHLc5w1hYlQylyew4x2O5cbMzvOfDtxzXdCBEcyK0wqjRSGSHll83NZi1JyPrV4/
         SQ3A==
X-Gm-Message-State: AJIora98/c1W5slSeD2YB5HJWsXN2aFy8s/fxMG/WS+1gWkBL9eKdyvN
        p6XydEmP1Fea+V3Ke0IW4WhFSf+NmmYrNg==
X-Google-Smtp-Source: AGRyM1v6Ax7NuZ6jjlFLaMHF0fIErMH9lXZZPm1eLDChTOZ+cNTuqTmTSb3kB75N1USmE+gJ9PfQ6A==
X-Received: by 2002:ad4:5dc1:0:b0:462:194:bc7a with SMTP id m1-20020ad45dc1000000b004620194bc7amr36751615qvh.87.1657099054355;
        Wed, 06 Jul 2022 02:17:34 -0700 (PDT)
Received: from mail-yb1-f179.google.com (mail-yb1-f179.google.com. [209.85.219.179])
        by smtp.gmail.com with ESMTPSA id f15-20020ac87f0f000000b00304e8938800sm25213055qtk.96.2022.07.06.02.17.33
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Jul 2022 02:17:34 -0700 (PDT)
Received: by mail-yb1-f179.google.com with SMTP id c143so17765388ybf.3
        for <linux-kernel@vger.kernel.org>; Wed, 06 Jul 2022 02:17:33 -0700 (PDT)
X-Received: by 2002:a5b:6c1:0:b0:669:a7c3:4c33 with SMTP id
 r1-20020a5b06c1000000b00669a7c34c33mr42274477ybq.543.1657099053737; Wed, 06
 Jul 2022 02:17:33 -0700 (PDT)
MIME-Version: 1.0
References: <20220628084903.3147123-1-yangyingliang@huawei.com>
In-Reply-To: <20220628084903.3147123-1-yangyingliang@huawei.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 6 Jul 2022 11:17:22 +0200
X-Gmail-Original-Message-ID: <CAMuHMdV=YG_EMFO0jq7s4nH=VN3aWox3=+fWuF46HVHdWCDdMg@mail.gmail.com>
Message-ID: <CAMuHMdV=YG_EMFO0jq7s4nH=VN3aWox3=+fWuF46HVHdWCDdMg@mail.gmail.com>
Subject: Re: [PATCH -next v2] m68k: virt: platform: fix missing
 platform_device_unregister() on error in virt_platform_init()
To:     Yang Yingliang <yangyingliang@huawei.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-m68k <linux-m68k@lists.linux-m68k.org>,
        Laurent Vivier <laurent@vivier.eu>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 28, 2022 at 10:39 AM Yang Yingliang
<yangyingliang@huawei.com> wrote:
> Add the missing platform_device_unregister() before return
> from virt_platform_init() in the error handling case.
>
> Fixes: 05d51e42df06 ("m68k: Introduce a virtual m68k machine")
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
> ---
> v2:
>   change for loop to while at lable err_unregister_rtc_virtio.

Reviewed-by: Geert Uytterhoeven <geert@linux-m68k.org>
i.e. will queue in the m68k for-v5.20 branch.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
