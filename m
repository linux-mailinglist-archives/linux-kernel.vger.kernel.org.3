Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D1614797B2
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Dec 2021 00:59:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231467AbhLQX7I convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 17 Dec 2021 18:59:08 -0500
Received: from mail-yb1-f176.google.com ([209.85.219.176]:39759 "EHLO
        mail-yb1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229665AbhLQX7H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Dec 2021 18:59:07 -0500
Received: by mail-yb1-f176.google.com with SMTP id v203so10835219ybe.6;
        Fri, 17 Dec 2021 15:59:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=4F0gHTidMS+I/Mh8I+yQ11CWW3YbgxApHH85yQIIp/o=;
        b=eLCR+YHqVJcHrBj0baXHo2a/wAtMnXC99VJzA+NeeOvU4Vbw/jW+YEmu82C/8uYvzA
         kVmJtiWqPX6oySbKBK6HR0O9vjScvB7Q2Cmrc47vKTmzfV3q5VeETFcAZGBuWEtD5GgT
         ou1fg/z7eMlnxtXxPEZlhYpn9rs3X29N0c2Fh9LfkyS28f3s8GqtwyXyva0ltQt19q1z
         J8AWT6uG34bOWE62e/Dq/4qwp+ZhK4JMy4XrQhuRtLEGCZxDjKMqRRCIEBFVKX4PK0KC
         HNDtbT52ZYN3so+n1iFfuD5CpFAV7Lqqv91xNTODKOEtTr69aSZqa1wX4/4kN193Z8qY
         CgCQ==
X-Gm-Message-State: AOAM530Qo/lzsvAlZXr+hyJQwAWTG3hcleEmGk2W/4nxrrAvCV0XDyJX
        WfbNQvOsSkaXln82bfGolByXVHvhArVwQ0PshCkWTRZ/6nI=
X-Google-Smtp-Source: ABdhPJwMtgJn9avrIgj5yxzhDON6+NfjkmC1bO6Wq9jC1fgXNPnyGvbiq9KKoqpSqD1lI64vDQ9LQMXw6ENvXywigAY=
X-Received: by 2002:a25:54e:: with SMTP id 75mr7025346ybf.393.1639785546754;
 Fri, 17 Dec 2021 15:59:06 -0800 (PST)
MIME-Version: 1.0
References: <20211216095014.11918-1-tianjia.zhang@linux.alibaba.com>
In-Reply-To: <20211216095014.11918-1-tianjia.zhang@linux.alibaba.com>
From:   =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Date:   Sat, 18 Dec 2021 00:58:55 +0100
Message-ID: <CAAdtpL5DbW4mdv2xtXCx3rpx+TKTdSLRZDOMj8o-ofsaQZnEwg@mail.gmail.com>
Subject: Re: [PATCH] MIPS: Octeon: Fix build errors using clang
To:     Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
Cc:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Adrian Schmutzler <freifunk@adrianschmutzler.de>,
        "open list:BROADCOM NVRAM DRIVER" <linux-mips@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 16, 2021 at 5:11 PM Tianjia Zhang
<tianjia.zhang@linux.alibaba.com> wrote:
>
> A large number of the following errors is reported when compiling
> with clang:
>
>   cvmx-bootinfo.h:326:3: error: adding 'int' to a string does not append to the string [-Werror,-Wstring-plus-int]
>                   ENUM_BRD_TYPE_CASE(CVMX_BOARD_TYPE_NULL)
>                   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>   cvmx-bootinfo.h:321:20: note: expanded from macro 'ENUM_BRD_TYPE_CASE'
>           case x: return(#x + 16);        /* Skip CVMX_BOARD_TYPE_ */
>                          ~~~^~~~
>   cvmx-bootinfo.h:326:3: note: use array indexing to silence this warning
>   cvmx-bootinfo.h:321:20: note: expanded from macro 'ENUM_BRD_TYPE_CASE'
>           case x: return(#x + 16);        /* Skip CVMX_BOARD_TYPE_ */
>                           ^
>
> Follow the prompts to use the address operator '&' to fix this error.
>
> Signed-off-by: Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
> ---
>  arch/mips/include/asm/octeon/cvmx-bootinfo.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
