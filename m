Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E884530E4D
	for <lists+linux-kernel@lfdr.de>; Mon, 23 May 2022 12:43:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233529AbiEWJh1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 May 2022 05:37:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233414AbiEWJhM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 May 2022 05:37:12 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D92A014088;
        Mon, 23 May 2022 02:36:50 -0700 (PDT)
Received: from mail-yb1-f182.google.com ([209.85.219.182]) by
 mrelayeu.kundenserver.de (mreue012 [213.165.67.97]) with ESMTPSA (Nemesis) id
 1Mi4un-1nO7KQ2abR-00e77y; Mon, 23 May 2022 11:36:47 +0200
Received: by mail-yb1-f182.google.com with SMTP id x2so24022580ybi.8;
        Mon, 23 May 2022 02:36:47 -0700 (PDT)
X-Gm-Message-State: AOAM531/KFI3EEEA5qJ+lfkJMawBRXrxOswi7t61JSInzPAP2Y4ubNBS
        HCE0nnXGeHfcn12XhU2/CWNHpL2Xf3wqX+OBKSI=
X-Google-Smtp-Source: ABdhPJxEXe06M3axoRKKPnNA61tQHMjYpX5dyVq4k6tPeRi1tB4KWQG4XjRdw9Dk8Zg5uHNGuRJXRzt1ho0pY/kHoDc=
X-Received: by 2002:a25:31c2:0:b0:641:660f:230f with SMTP id
 x185-20020a2531c2000000b00641660f230fmr20782159ybx.472.1653298606323; Mon, 23
 May 2022 02:36:46 -0700 (PDT)
MIME-Version: 1.0
References: <20220523020051.141460-1-wangkefeng.wang@huawei.com> <20220523020051.141460-2-wangkefeng.wang@huawei.com>
In-Reply-To: <20220523020051.141460-2-wangkefeng.wang@huawei.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Mon, 23 May 2022 11:36:29 +0200
X-Gmail-Original-Message-ID: <CAK8P3a2cP8Y42C4kCbFSpkcj8cLexinLj=x9m6vvwKJxLvX7yw@mail.gmail.com>
Message-ID: <CAK8P3a2cP8Y42C4kCbFSpkcj8cLexinLj=x9m6vvwKJxLvX7yw@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] asm-generic: Add memory barrier dma_mb()
To:     Kefeng Wang <wangkefeng.wang@huawei.com>
Cc:     Marco Elver <elver@google.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Jonathan Corbet <corbet@lwn.net>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:zPIkvDMlXAm1LZNBiHMWj4e04LbhwlYvvCXzJxKLKjrwGZTDN44
 L9IrERPoIZZklGYgpf1jHh3Qs+XZMXBNkNKKnCr3YL2HOivvyU2TuqJWFKNPWn02zckMJ6Z
 9aNQVXKy4kenpvtRzK6F26I75B+Z3fTubxfZ1yHEzPTzWNPS5MR/O4OolEqiWv66qnoPp51
 RztJQGmaAU1pEF7j9SOOg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:EDywYquYCAY=:7xx0eKix9nIC1tl7Vk6vmA
 /PRFeXYbdk20nJ+oepw3D8EAg2+2P3A9zEjFFv0oJkdT6eYxQOhY8+P5LhEinbF76XfnzSaA8
 /2zwkk5BiGXjlihUrkbIrJMsgU7cVrsNi+uotro/D4OOjXekYTlCQlhY3VtPjqPf5hizIh5of
 xdfQ+ZAcKB3paw7Qk0zNbm0faGyaorYfVpyO2r3WKUnN9NAvTR0HSYzqRBwx+Alb2Sy/684sb
 4OfsoFq45RfHDHQ5b0VbjPjhwDeZVpYkjTwnQxvyzmUvzJsYXiKFTdDR71R8AgiDv7FD1MrlH
 QehUKUa7bjwzt0e0rW9fGr45zWgP3+HVL9crHv1EvSqTLYotX/HACuK/pr9kq1Gg5mHBOI4ov
 +EOoXRgUkH8DM1WMxlL7dAeE0MKNMR4rRd8WyvhldCVuq1Ui1peFIUA7upeJK/zJZTpQjeSm1
 ifPA8XoL4cGUEykOCfe8H3p9nybPMfA5kxInR//JyEuyBmCBD28SlNFCj7tZ+5Kwz83UX1E1+
 7v2gZaq9h0u1tpbgvPIgjH5NeZ5m1aKk3VeTFn3c2LNt1kPjOgPm4KKXsuE4mYmps/DL1LKpP
 p1BWoTE9qqTdyl5q8oRTOy1UuXjwbZIx7+oBSbIUH66wrMf1dwN4gmChqykysdxsyf0pGt+d/
 pnu4X9feKEdJnQvlfyAbIqUbMsdNq+iOYSfO9Xpxc5zy4ySgQ4K+qYdNSTMLVzTFMoz3EqBSo
 L9yPtUm+OlxGFmdj0JLXPZ2yB+9MGCkeaPFWHA==
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 23, 2022 at 4:00 AM Kefeng Wang <wangkefeng.wang@huawei.com> wrote:
>
> The memory barrier dma_mb() is introduced by commit a76a37777f2c
> ("iommu/arm-smmu-v3: Ensure queue is read after updating prod pointer"),
> which is used to ensure that prior (both reads and writes) accesses
> to memory by a CPU are ordered w.r.t. a subsequent MMIO write, this
> is only defined on arm64, but it is a generic memory barrier, let's
> add dma_mb() into documentation and include/asm-generic/barrier.h.
>
> Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
> ---

I assume you plan this to get merged through the arm64 tree.

Reviewed-by: Arnd Bergmann <arnd@arndb.de> # for asm-generic
