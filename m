Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EAF6958993D
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Aug 2022 10:24:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238288AbiHDIYs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Aug 2022 04:24:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229665AbiHDIYm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Aug 2022 04:24:42 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [217.72.192.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01C084C636;
        Thu,  4 Aug 2022 01:24:38 -0700 (PDT)
Received: from mail-ej1-f52.google.com ([209.85.218.52]) by
 mrelayeu.kundenserver.de (mreue107 [213.165.67.113]) with ESMTPSA (Nemesis)
 id 1MRnXY-1nqTl91Vb0-00TFTN; Thu, 04 Aug 2022 10:24:37 +0200
Received: by mail-ej1-f52.google.com with SMTP id c24so4771700ejd.11;
        Thu, 04 Aug 2022 01:24:37 -0700 (PDT)
X-Gm-Message-State: ACgBeo1ODei5vSwkfmgxd+RMkNkBJYahML4QqrXyvnGlAAohjLkf5ouW
        9HPhMcGAQfTwRweY2+WsTKG/+E51uYJRgn+Mpyg=
X-Google-Smtp-Source: AA6agR7mx2DcqpUWDVSgizEz+I+v1CueGd21v5hR8W+ij/iiqR6AnsafECfmF4+yDDNQfg74+XRR1lx7VIfSL42tGVw=
X-Received: by 2002:a17:907:d0f:b0:72e:db1f:9b91 with SMTP id
 gn15-20020a1709070d0f00b0072edb1f9b91mr603460ejc.470.1659601476990; Thu, 04
 Aug 2022 01:24:36 -0700 (PDT)
MIME-Version: 1.0
References: <20220711122459.13773-1-me@linux.beauty> <20220711122459.13773-5-me@linux.beauty>
 <CAK8P3a2Mr0ZMXGDx6htYEbBBtm4mubk-meSASJjPRK1j1O-hEA@mail.gmail.com>
 <181efcca6ae.de84203d522625.7740936811073442334@linux.beauty>
 <CAK8P3a30o1RLifV1TMqDJ26vLhVdOzz3wP6yPrayLV2GPxUtwQ@mail.gmail.com> <18267b7a61f.12b26bd91245310.4476663913461696630@linux.beauty>
In-Reply-To: <18267b7a61f.12b26bd91245310.4476663913461696630@linux.beauty>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Thu, 4 Aug 2022 10:24:20 +0200
X-Gmail-Original-Message-ID: <CAK8P3a0zSGqj3YEi+i9yfSLk8-aJtyiY6Bj069cxCdErk81+cw@mail.gmail.com>
Message-ID: <CAK8P3a0zSGqj3YEi+i9yfSLk8-aJtyiY6Bj069cxCdErk81+cw@mail.gmail.com>
Subject: Re: [PATCH 4/4] sample/reserved_mem: Introduce a sample of struct
 page and dio support to no-map rmem
To:     Li Chen <me@linux.beauty>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Li Chen <lchen@ambarella.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        DTML <devicetree@vger.kernel.org>, Linux-MM <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:yzIq8vPx8ZJNLHi/8z+h6JR8GjTYb5Rb2KDVoPjo6kuFclbusm9
 n43hDbTALvs30gNLs4/GKVw2NRxBXHG6kL5K1bR2gzPvtWxyl9RUZIEen5QdoNgQUNt9N/a
 hnZVqZHGEVWzLPJhdGpoKlZMUFn16b02TLX+YyY8Rw4SXsUHoy1FUB0tEoeuaa1da4sDDNG
 iWB87lCpj+48aIUj8sZzA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:yldv/sAQqdM=:EwoksoRYbM8iRTgYdnh2Yp
 A5QecUZZ53vcBhiB3yv4FaJtYWM7cBBiXj3rQ41Eledd1Uvn7yLVKzZtJ5F5w3skDcy/qJjZD
 NaAA4ikEEUmwoWNv9dbZXSjkmptgV5r0v1FIQoPy3cOESZHhMJW+TcqHJK9gBUmW57qf965Gq
 PhULGktuvvzfqVB2hdg9hL+8EHNEaP2czv5Gc2GkBRvvAb7l8axDjou3VYxBlESI92Q0gCR4L
 dnlp04UkIlzB5bBRTCFscwfMYpxByiaTVEJe8iqClIKOJym4xgegmZZNwgYFvX4a5DZYHJpIg
 Nj3Ui4D6N0HjivDuvo5jdmjeakDxVbzoO2ZBtT6tNbmakH3/X90APX6gJKFYuoXBJzwlRTDtK
 IEpnBB/CTeWcweaJlUXD614sFiEdhwijVvkapA/2J6evO+e7teFmfNJGE83VQ1YfTVnoJfc9z
 IthtoNfsKKOf0vI61qvh4nBbpoiqD/i1W6Rd4Cck1jFwyyyADTXXxVb77r3eC7Pw3B+z4XIJ8
 eCP7NAoF4fqM7Kgh2razmMMqZvCNW9h7Q7xyw/eeI6f5gdYgHQ4jmSsf9sI+ShKGPExr9Ag9k
 TVEp8dprAzmLeu3XqwhKgQBuO3jZ9G0gQQJRXf0noZ1pKnkdgdBx83VKg8Y79U97v17DwBzER
 Y3LlGdv8i5GAWfgMoH/fdi0JuB7wl5YC/zFARgpwxhhVwwElBa7SAcc6u2erOQr60qRxXPp6G
 WVB7Vd+PXQKtRXs+VK2iuHrQWhvl6Hg0wrdMBzrWY1GarGNhS2zN2T+FLDFnYUvdty1EL8JCk
 bzkUGGZVDlRKlGbFEsa4f7WUxAzccN8PB/p8XWoiTcuIFKg0husKD6e7WsAFve4+LjzuZ/dWo
 03bsVvPzleYJgF0zWO/g==
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 4, 2022 at 9:17 AM Li Chen <me@linux.beauty> wrote:
> ---- On Tue, 12 Jul 2022 16:50:46 +0900  Arnd Bergmann  wrote ---
>  > Does your hardware require a fixed address for the buffer? If it can be
>  > anywhere in memory (or at least within a certain range) but just has to
>  > be physically contiguous, the normal way would be to use a CMA area
>  > to allocate from, which gives you 'struct page' backed pages.
>
> CMA does support Direct I/O, but it has its own issue:
> It does not guarantee that the memory previously borrowed by the OS will be returned to the device.
>
> We've been plagued by examples like this in the past:
> Many other kernel modules/subsystems have already allocated much memory from both non-CMA and CMA memory,
> When our DSP driver got probed then, cma_alloc will fail in that non-CMA system memory is not enough
> for CMA memory to migrate.

This part should at least be possible to solve by declaring the amount
and location of
CMA areas in the right way. It's not great to fine-tune the DT for a
particular kernel's
use, but if you know which other drivers require CMA type allocations
you can find a lower
bound that should suffice.

Most coherent allocations tend to be long-lived and only for very
small memory regions.
If you have another driver that uses large or periodic
dma_alloc_coherent() type allocations,
you can consider either giving that device its own CMA area, or fixing
it to use streaming
mappings.

        Arnd
