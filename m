Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F0FB494BD2
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jan 2022 11:34:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359869AbiATKe2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jan 2022 05:34:28 -0500
Received: from mout.kundenserver.de ([217.72.192.74]:39841 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234927AbiATKeX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jan 2022 05:34:23 -0500
Received: from mail-wm1-f53.google.com ([209.85.128.53]) by
 mrelayeu.kundenserver.de (mreue106 [213.165.67.113]) with ESMTPSA (Nemesis)
 id 1M3UEW-1nB2jf1J34-000aYh; Thu, 20 Jan 2022 11:34:21 +0100
Received: by mail-wm1-f53.google.com with SMTP id q141-20020a1ca793000000b00347b48dfb53so12714962wme.0;
        Thu, 20 Jan 2022 02:34:21 -0800 (PST)
X-Gm-Message-State: AOAM532mmwt4WDlPeYfxPfmVVWoGR6VohFudIl8oMshBEnKsEHLabE64
        fddo/O528bZajEpSKh5xNaMt27PNXKxNgnM4XwI=
X-Google-Smtp-Source: ABdhPJxEAFXYVk6DktXv3061JPbB7MqrKutmOAXqbVu5eyk6Pz36dhnH8dbuNkOxd7GlFiEfJn/5TzSKv0rhSZwiTMY=
X-Received: by 2002:a7b:ce96:: with SMTP id q22mr8113766wmj.82.1642671479094;
 Thu, 20 Jan 2022 01:37:59 -0800 (PST)
MIME-Version: 1.0
References: <20220120073911.99857-14-guoren@kernel.org>
In-Reply-To: <20220120073911.99857-14-guoren@kernel.org>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Thu, 20 Jan 2022 10:37:43 +0100
X-Gmail-Original-Message-ID: <CAK8P3a03-3QTC-vxmnbouK7wBd8iunPGZpX0-Jf6ntS1DY0E=w@mail.gmail.com>
Message-ID: <CAK8P3a03-3QTC-vxmnbouK7wBd8iunPGZpX0-Jf6ntS1DY0E=w@mail.gmail.com>
Subject: Re: [PATCH V3 13/17] riscv: compat: signal: Add rt_frame implementation
To:     Guo Ren <guoren@kernel.org>
Cc:     Palmer Dabbelt <palmer@dabbelt.com>, Arnd Bergmann <arnd@arndb.de>,
        Anup Patel <anup@brainfault.org>,
        gregkh <gregkh@linuxfoundation.org>,
        liush <liush@allwinnertech.com>, Wei Fu <wefu@redhat.com>,
        Drew Fustini <drew@beagleboard.org>,
        Wang Junqiang <wangjunqiang@iscas.ac.cn>,
        Christoph Hellwig <hch@lst.de>,
        Christoph Hellwig <hch@infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        linux-csky@vger.kernel.org,
        linux-s390 <linux-s390@vger.kernel.org>,
        sparclinux <sparclinux@vger.kernel.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        inux-parisc@vger.kernel.org,
        "open list:BROADCOM NVRAM DRIVER" <linux-mips@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Guo Ren <guoren@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:maXbNfNUf4coYMldaGrFVEumiNLwf3mNjO8XH1NNRoQtd2zeNdf
 gJEKLqKMfYWyqs6qTQw//UbtBSSV7qnDMo4ZyuQD84WhLaDnkmEwjBajkAQ4pB7qq2o0a3R
 +22Xsievc4CmTwghx28LxQOByrgKHl80yDKUA/B1bqK2dqdxv8c4iCHGcnVEngTzHZSLqLW
 npYIW6C29QfRyI0RmBDuA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:5eelWh45nRQ=:AMM50bWtIrqXR/xRnTg739
 oGEH6ShLu3ymDZw+hsNqhPbKWVHQNfN/3jsM7tWA0iDBQ1y1xtekBTK0+aXoQ/VBWEBdmyEPJ
 qyv4Ve/9RE+GqfZomw4fOrm8KTGD9xhwvK9VMGudqtjJSOZK4uiTo30XZTu0EG2IA8j0YHFyr
 0uxBgeOaSGDtgAw45cc9K+qNzaQ8ib8VEf3wZLcs9IKyZTg8rTwhOrM9biEV/LgK/kFvSlMnd
 rs9MRvxF5IsE+cw7rvT13frPZuWKwSgZOlxNarR4UDADuAHHndwfIRY2D/dqkCpnrYA4zTn8a
 ZqPNAeBjWgMB0zjSj+RS+Mk5vqae59Y1ZklhScn9tn47CsOSkcuhvVZT7fwguPnacB6fGOpd6
 CD1P3r7RBqU4v1+pJZOKmrHm8R/J5YjZ8ofgRJ0qaKenTATdefw3yhyjRJzXH51Zt4EtYRbAa
 2sF1uUkto7mgVq/71+FsAoNtxyY8QdPkQVzJAn814eVPzXCExvgQkutB53i6RcNS/iPJy+Dac
 rK7k8YgLXzNMUL3GQei2uh09d4O4tW6Qq2tbr8GUlOZj6Ts/ZlDv70b5Umfw94iQAEB3T0Lzl
 ZrwZ10uZR4K4wA3JzBBILU0gjA7XNdaMgTIQLJh1BoSfMlinYRGJ5OPUymdIN8/oUQhxcfER5
 apKGnaHiBU66x3JTNDT/QrJT3BABEeZvJ54m0K1ciYAjHC46PoeYWsChBKaKnXgyt43uT+OQr
 YetzrTAzjjsVrRr2FhV4LSBP07YLx4v84Qsp1bIv6ZPA9QqCfI1TFcFbNY/QkQaw/eXMpTgNb
 nfiUfWvLadhY0FJAgIBxgkQwBMNAFnVXFfi4PedWKF5OUlaTI8Pc9eYGapjDiLnBOxhOAC3
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 20, 2022 at 8:39 AM <guoren@kernel.org> wrote:
>
> From: Guo Ren <guoren@linux.alibaba.com>
>
> Implement compat_setup_rt_frame for sigcontext save & restore. The
> main process is the same with signal, but the rv32 pt_regs' size
> is different from rv64's, so we needs convert them.
>
> Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
> Signed-off-by: Guo Ren <guoren@kernel.org>
> Cc: Arnd Bergmann <arnd@arndb.de>

I hope someone else can properly review this part, it's not my area
but it looks complex enough that it could bring subtle bugs.

       Arnd
