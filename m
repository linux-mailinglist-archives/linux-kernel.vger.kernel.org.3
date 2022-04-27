Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C928D512050
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 20:38:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240889AbiD0QBd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 12:01:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240978AbiD0QBa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 12:01:30 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.17.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47C6C8720D;
        Wed, 27 Apr 2022 08:58:05 -0700 (PDT)
Received: from mail-yb1-f172.google.com ([209.85.219.172]) by
 mrelayeu.kundenserver.de (mreue108 [213.165.67.113]) with ESMTPSA (Nemesis)
 id 1Mzhf5-1o5YCK3XYf-00vhgx; Wed, 27 Apr 2022 17:51:42 +0200
Received: by mail-yb1-f172.google.com with SMTP id e12so4117163ybc.11;
        Wed, 27 Apr 2022 08:51:41 -0700 (PDT)
X-Gm-Message-State: AOAM533SoKq4fi/IJ1BLTrJrJX7syR+IW4SJ7lSFsyLWZHXhfs58WQPD
        t2TAXWqIUu82+12vi3/OOaPqCSR6V10QXNNwd3k=
X-Google-Smtp-Source: ABdhPJxg/rp1yZ1Ly2nF5MsxzyFle4shrPG2g7HYew8NwDIoh5cLQ/zvir6C9VKrSaIIp5BPkGMU9F4wPq1zK6iiz6k=
X-Received: by 2002:a25:c604:0:b0:645:d969:97a7 with SMTP id
 k4-20020a25c604000000b00645d96997a7mr22212946ybf.134.1651074700502; Wed, 27
 Apr 2022 08:51:40 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1644824638.git.quic_saipraka@quicinc.com> <31f49b98aa921f03d1a9f27af483ac0e5e5bcdb6.1644824638.git.quic_saipraka@quicinc.com>
In-Reply-To: <31f49b98aa921f03d1a9f27af483ac0e5e5bcdb6.1644824638.git.quic_saipraka@quicinc.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Wed, 27 Apr 2022 17:51:24 +0200
X-Gmail-Original-Message-ID: <CAK8P3a0PyoD3adNm1iSi6B7vyM-Mi7yP0vgJ8FpmEOPTXRDr2A@mail.gmail.com>
Message-ID: <CAK8P3a0PyoD3adNm1iSi6B7vyM-Mi7yP0vgJ8FpmEOPTXRDr2A@mail.gmail.com>
Subject: Re: [PATCHv10 1/6] arm64: io: Use asm-generic high level MMIO accessors
To:     Sai Prakash Ranjan <quic_saipraka@quicinc.com>
Cc:     Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        Marc Zyngier <maz@kernel.org>,
        Trilok Soni <quic_tsoni@quicinc.com>,
        quic_psodagud@quicinc.com, gregkh <gregkh@linuxfoundation.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:TiCnNktqYEftzO2ZWyEYnTWPzKQDRMm4zlTuEku0NeulQq5xe+1
 BGuYMQPhiQDji1fmqliHnnUJURkkR2mU7I+SuABBkCUDomBgXg4V0bOm5tUb7DvxlJEgtY1
 2L1d7aowdQcvnU/MpLUmqUR9pZVPqHQOniybcgxD3QGDaJSaYDUfpFRsEk3LA9PLchvjrIV
 pz4MEDk13GPm+dlQmVL6w==
X-UI-Out-Filterresults: notjunk:1;V03:K0:6l2qDR+Ue4M=:JDeZJzfZm3KZLaB59/dCOa
 /2DYy+qx4YiGayvBlcaN0ON2fLzjDXXdQ98M/9dUmQAO8pwL/29fr6P6niPTBLrTH/ys1gGno
 P7sYP7P2KHugGJVrchzi6Ylp2wNYwyIlh6zCdsQBMbOMOe4fXZ1XbnN8gBSrU3rs5LVDhVK1R
 J1DZMDt6P+4dQju43FiyGrCuhK33Nv59tkHF74OdPvvt2ximQkIVwvpF5HR0+PRv185Fq4Sd4
 F1APeAZ3VNJjcCQA27bmwV3PPAQXV9VmJFsguzQ7CR7As+s/UKEWa4J5hubZlHIWWeLvmlBbZ
 +fvNV++NAdVKVh2yOdgZd5LdHnXF+kntpPJ6EwJV0CC6MBmO7LepQfueK7ngTs9kjec9Fk6MI
 o/3RHOJcHD3SSNIbLiu45uJnw/mYjLD06JlbK3+M9pPb9oybfkqRL1NHwCsS+XT2k143/Xyj8
 9M+AN0ZLjlwAGIHLTRN2k3iWFsuv62wR0bm/xUQx3zmkV4HsKC32Nma6LykGiOnUkAVXiuLQg
 WX+/KU61lw84eTejtv9NXVXYt9yiGVdErNfK9MmLDZbqYTcJClDmpi8YJfjZdQNy01pxxvMyI
 TflF7OaBHiDPEB7Cqkss1L4mYdXxtO/HoqKmhiNX1T9gXXfNfjCHjIKvwuCV1gG9rlHjUoKdQ
 A+oydhWIV/66CphwXuhAkWIeHe6wkdnjiFcwHqGbeoJu9Zwm43WIiDfIKZ2z1Z8lX2UTKfs7m
 stECLgYfoWZ9Zn2cjOqCMBBYb4M6LkOc6cxadlMhLZTbNX5OYMrJIAZJxje0qnGNJu32Q9f91
 yRkPtUiNcItEl5BKZkxsL6o0yycz/6uiHagm06L6N68dOL9jlY=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 24, 2022 at 7:07 AM Sai Prakash Ranjan
<quic_saipraka@quicinc.com> wrote:
>
> Remove custom arm64 MMIO accessors read{b,w,l,q} and their relaxed
> versions in support to use asm-generic defined accessors. Also define
> one set of IO barriers (ar/bw version) used by asm-generic code to
> override the arm64 specific variants.
>
> Suggested-by: Arnd Bergmann <arnd@arndb.de>
> Signed-off-by: Sai Prakash Ranjan <quic_saipraka@quicinc.com>
> Acked-by: Catalin Marinas <catalin.marinas@arm.com>

Reviewed-by: Arnd Bergmann <arnd@arndb.de>
