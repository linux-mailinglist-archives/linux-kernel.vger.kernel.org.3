Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13A094C8C63
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Mar 2022 14:16:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234963AbiCANR3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Mar 2022 08:17:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234388AbiCANR2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Mar 2022 08:17:28 -0500
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B8F18B6F9;
        Tue,  1 Mar 2022 05:16:46 -0800 (PST)
Received: from mail-wm1-f46.google.com ([209.85.128.46]) by
 mrelayeu.kundenserver.de (mreue009 [213.165.67.97]) with ESMTPSA (Nemesis) id
 1MLz3R-1ngytR2E4X-00HxcH; Tue, 01 Mar 2022 14:16:44 +0100
Received: by mail-wm1-f46.google.com with SMTP id p4so7510045wmg.1;
        Tue, 01 Mar 2022 05:16:44 -0800 (PST)
X-Gm-Message-State: AOAM5338Es48xCXAuK+sLKUTYN8Rz3or0sPQ1yJ665nYnR2pO/d/nVwu
        EVZAQBN0x5ncF/9aiFo54SRWxELGYHaJizhPcMs=
X-Google-Smtp-Source: ABdhPJzVi3TefJRA3CIqwNkyx2euDeSPKypSRgBCiNckgik/0LHB+q68ePkJ0djtvORCJQLX+Id+m1Re1hRGWTaK5dk=
X-Received: by 2002:a05:600c:3b87:b0:381:428c:24c1 with SMTP id
 n7-20020a05600c3b8700b00381428c24c1mr13371304wms.1.1646140603948; Tue, 01 Mar
 2022 05:16:43 -0800 (PST)
MIME-Version: 1.0
References: <9f9107c06f7d065ae6581e5290ef5d72f7298fd1.1646132835.git.geert+renesas@glider.be>
In-Reply-To: <9f9107c06f7d065ae6581e5290ef5d72f7298fd1.1646132835.git.geert+renesas@glider.be>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Tue, 1 Mar 2022 14:16:28 +0100
X-Gmail-Original-Message-ID: <CAK8P3a3JvY=jcXGRRG+Eck2bkGRvb6_FTYZK+9RZS4Fw8y4eHA@mail.gmail.com>
Message-ID: <CAK8P3a3JvY=jcXGRRG+Eck2bkGRvb6_FTYZK+9RZS4Fw8y4eHA@mail.gmail.com>
Subject: Re: [PATCH] base: soc: Make soc_device_match() simpler and easier to read
To:     Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Lee Jones <lee.jones@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:hkADQi8ptUtrDvLoq/s+ykTeXN3qSnsvm6UlWkaCkBNCaHVkjr+
 FkCSg96UDcG69P69YevMuKa9iBt9OtppPKfrkQ8FdbsSDzeNCGfyYm/ADxo0z9j7BwGbsrm
 Z+comdiAs9fr8vdUjrBovWfyNseniNhj+nxJSyqKor073+gLAYhsVLzTgyB1gkewNNJWt1h
 yo3zh6ZyIxMs9mu03iuBQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:b3F+z27nr0s=:ZP7UBrvm3nivpftexF44jp
 2Yc4Hcbc8EPWwNPIW0rcj6HddgwN5qmXYD1xnrp0ULKnTzztD8YQmxcKaHz6TkmMwf+WoQ5s8
 EBHtn0TbhkhdFTnIGbmuvePHe8iEy5ZcpjW12Fms39T7PXOszonuOOBOHPiUehOBXh/R/XQW1
 ZR/e5X6Rowffom8XVrqqRusmHaSzSf+kQb0YkbTscle9cwroh3kNmqxkJDRYmO9WcazM6COcH
 2xgAjHJnhJK7ljpomWG++qIRBkBMY3g9IPYIWf02qpXpHaykutjpCNsbHXiXIe6/fv8bIGaN1
 1mcvTpxSGR7odoWjFi9KZ4+k+kRuAkbr9sh1RYU1s2o/cmi11+5FrINpKsf6JUtaiCcPj64Gx
 XYGZa7ZQlxQ3CNf5O1h3Jcc9KHbVyFfmF8x3XesxOaExAMIDhbf1yMmzboLVFW1ASxw5/X/si
 0qW5r+yE3HqCqW0E5+omg5u02k9c7HWsjJzaEoIFHTu/NH+3acXxhOfmW6EpFk1FB1mLxvfon
 RqCfOwc+LJUyFTnAb/BTqhdScBYcsGre4xj3aeG2ny5KOtn6ZxWxVK0egJPk59VFIV3FLr5mv
 HbP5rG/KolFMXvdVtPdQeBk7yhPQsweHV3JdX/OU5DuUbzwAErkv+Fx+LD9rQcsxtryWoacG+
 yPJj/FtxYx4KaIxU0Wa5ScnMasanhxDoVfxqdaxpPJLswd41B7bgRoK7sqtMqiriEBuh4UoYf
 G5jyeJj2k6c/LXejrLeUyNDLneJEw+uPH4xzQ1WSSC+TuPP1llgLj1WGuq3VzTIDr/b0Wqvt3
 upDnYZjZL0K3ycS7aJqjJRTKFW4lMWzZJyw0wiLId8n2eXw8sA=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 1, 2022 at 12:10 PM Geert Uytterhoeven
<geert+renesas@glider.be> wrote:
>
> The function soc_device_match() is difficult to read for various
> reasons:
>   - There are two loop conditions using different styles: "while (...)"
>     (which is BTW always true) vs. "if ... break",
>   - The are two return condition using different logic: "if ... return
>     foo" vs. "if ... else return bar".
>
> Make the code easier to read by:
>   1. Removing the always-true "!ret" loop condition, and dropping the
>      now unneeded pre-initialization of "ret",
>   2. Converting "if ... break" to a proper "while (...)" loop condition,
>   3. Inverting the logic of the second return condition.
>
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---

Reviewed-by: Arnd Bergmann <arnd@arndb.de>
