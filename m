Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB774532A5B
	for <lists+linux-kernel@lfdr.de>; Tue, 24 May 2022 14:31:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237384AbiEXMbF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 May 2022 08:31:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237363AbiEXMbA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 May 2022 08:31:00 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [217.72.192.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F7E893981
        for <linux-kernel@vger.kernel.org>; Tue, 24 May 2022 05:30:57 -0700 (PDT)
Received: from mail-yw1-f174.google.com ([209.85.128.174]) by
 mrelayeu.kundenserver.de (mreue106 [213.165.67.113]) with ESMTPSA (Nemesis)
 id 1N2VKr-1ni0xs2gxD-013wib for <linux-kernel@vger.kernel.org>; Tue, 24 May
 2022 14:30:55 +0200
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-3003cb4e064so7202107b3.3
        for <linux-kernel@vger.kernel.org>; Tue, 24 May 2022 05:30:55 -0700 (PDT)
X-Gm-Message-State: AOAM531tW1o/6bFNEZqeIqsPuddbKsqLq5N56rSqs5iTFlUK3o+sJnSL
        QYZbHiQHSeGgf9lthGrU+/d/teLECLoovSk9UTk=
X-Google-Smtp-Source: ABdhPJydwm9ZeQkJCZTDhTWemb3DUsSF1BiWMivHtJQfFJ6OjF0fBSQWMxFqbwtza36HGeAy93l3UAAU+B1mkG6N7Ok=
X-Received: by 2002:a0d:efc2:0:b0:2fe:d2b7:da8 with SMTP id
 y185-20020a0defc2000000b002fed2b70da8mr27015519ywe.42.1653395454413; Tue, 24
 May 2022 05:30:54 -0700 (PDT)
MIME-Version: 1.0
References: <20220523150521.2947108-1-nathan@kernel.org>
In-Reply-To: <20220523150521.2947108-1-nathan@kernel.org>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Tue, 24 May 2022 14:30:36 +0200
X-Gmail-Original-Message-ID: <CAK8P3a1pRmTeufSUOrRZx_B=VafmG33P1_vzn-YTpcSKDjfvVA@mail.gmail.com>
Message-ID: <CAK8P3a1pRmTeufSUOrRZx_B=VafmG33P1_vzn-YTpcSKDjfvVA@mail.gmail.com>
Subject: Re: [PATCH] misc: rtsx: Fix clang -Wsometimes-uninitialized in rts5261_init_from_hw()
To:     Nathan Chancellor <nathan@kernel.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        clang-built-linux <llvm@lists.linux.dev>,
        patches@lists.linux.dev, Dan Carpenter <dan.carpenter@oracle.com>,
        kernel test robot <lkp@intel.com>, Tom Rix <trix@redhat.com>,
        Ricky WU <ricky_wu@realtek.com>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:IPfEqANCpeGQT4I5vvTVLwjtt85tkfqzHGY3tMxzRWCh5ngXDUe
 DadM6NPrHrtcI2dSaLUTDm3tdTMcWNpVI5q3qzsCa4ZzJBupDAjexnudS+HO+rd4xaswM8N
 v39ULvqvrcyBZEinxuJVPRS/gMFYIjRnFnvEpSo6VHguCeUdJr7hfQapmTbt7hHXps3Zgnx
 fAm9QYSUN5SebA1Cme/RQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:jJPvRkR6LOo=:iypfv15fbHOkvJP9Pg/ITk
 +igaoCxxIOlpraVfvuwTypCjPK/H+Sd4HK++Up4juj+JI6zKOc61RoE/uuyQjiMt6GtaQEF0V
 UdXTKXhoPTlUS/ZhY/cTpjNG5XvOIO3bk+L1Inib7LVGiOCrYebV7r4Lz5DVNEuF9ErObcbA7
 IUzUGM3Q4fRwLVxuLsZ1IafyvRUemOxayRw+kefGuQofJETpqzcPzshf9V8lb+owGzclYsoKq
 NQw87Vp4osAS0pG+PQmN/UdNOper7JUYa9MlvuOyCLcCOJjwkC5hNtmlfFuvrdqa5Hz3k7MFG
 9sLZBfvMjNFR8HPE4VbyfcDKtLdLhnzDnpHG25Wwsue3dU0lQjl6h6zTlsxH6Qo3KuCwc+NNc
 6LtzY0hGfAPh0khgMQ8/md4QqMvL9XQj2FmO5jMI11s3BlZwC9JBTydhEHDCDjpJU98hwHAdk
 EZqcnMXRrztTBVw4G0l8cE5WFopIgLxqURvSsPA6Zu0GjKCTh9S08bhM6TSEHFljwx0rZLsCh
 guSV0uVtE6HQXVNZgfVxYUmwn10ng4pjkjWBHD4P+vw7MfNgIf56de5obKM9CNBTlKVqAP1L/
 3Zwgc2VFVVX3xuRRGZl4JpwC8/iAZqNuRI90rPtpSPCh2eMpid0AJ+zD8FBYxvLH86INCVkva
 F2txdwdKmqHsd4wlB0n0UE9kGcp3Gzk46ExiJJf4VkGYr1w3AnA+DdkiTO9QrGbxzT5zSyBqw
 ZdrayQBoHmXc08bp5K7Bcg3ZMx7qW2e+iCxEmFfKDP/Wh6XVEduq2AlgfK+8HmV0MnGsm3/yB
 5loxqnDq+7o/xNzl8n/TeqHPuucHbXSQzT57TEubMzQTTggMlfMeiB3cGxJnDwNZkwzHSufN5
 S/vYibcC2LsGKJP81EJA==
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 23, 2022 at 5:05 PM Nathan Chancellor <nathan@kernel.org> wrote:
>
> Clang warns:
>
>   drivers/misc/cardreader/rts5261.c:406:13: error: variable 'setting_reg2' is used uninitialized whenever 'if' condition is false [-Werror,-Wsometimes-uninitialized]
>           } else if (efuse_valid == 0) {
>                      ^~~~~~~~~~~~~~~~
>   drivers/misc/cardreader/rts5261.c:412:30: note: uninitialized use occurs here
>           pci_read_config_dword(pdev, setting_reg2, &lval2);
>                                       ^~~~~~~~~~~~
>
> efuse_valid == 1 is not a valid value so just return early from the
> function to avoid using setting_reg2 uninitialized.
>
> Fixes: b1c5f3085149 ("misc: rtsx: add rts5261 efuse function")
> Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
> Reported-by: kernel test robot <lkp@intel.com>
> Reported-by: Tom Rix <trix@redhat.com>
> Suggested-by: Ricky WU <ricky_wu@realtek.com>
> Signed-off-by: Nathan Chancellor <nathan@kernel.org>

Looks good to me,

Acked-by: Arnd Bergmann <arnd@arndb.de>
