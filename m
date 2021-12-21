Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ADF7347B840
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Dec 2021 03:09:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229916AbhLUCI5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Dec 2021 21:08:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229558AbhLUCI4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Dec 2021 21:08:56 -0500
Received: from out1.migadu.com (out1.migadu.com [IPv6:2001:41d0:2:863f::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CA74C061574
        for <linux-kernel@vger.kernel.org>; Mon, 20 Dec 2021 18:08:56 -0800 (PST)
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1640052534;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Dzgw+SXsH3WnSRNjasJTdlXPAi0tser+CNOzsg0LQ/s=;
        b=hIYZpFpFqxlJkiMlU+kX/s4HOBiVfvxewooJLgLKw+ikMnop0M44lRPGYW400hHZPrxtXA
        wHCrB935cGzGdMVwBhERdbx0VxwP4qJYKVtzUNwdfwjGcTVA7kYeauBNCaGE9IQz3MjRtP
        D3sAaftjBTJo6EOFSQL3LGAj4+bcqIk=
Date:   Tue, 21 Dec 2021 02:08:54 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   yajun.deng@linux.dev
Message-ID: <56d8e86231eec9f46abf9117596ffe07@linux.dev>
Subject: Re: [PATCH] init: fix the wrong __setup_param() definition
To:     "Marco Elver" <elver@google.com>
Cc:     keescook@chromium.org, samitolvanen@google.com, ojeda@kernel.org,
        masahiroy@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <CANpmjNPsCVkq7SsVL-xpktGe3RsJnRGTJxEPZ60VUt1w_5QgPQ@mail.gmail.com>
References: <CANpmjNPsCVkq7SsVL-xpktGe3RsJnRGTJxEPZ60VUt1w_5QgPQ@mail.gmail.com>
 <20211220035448.12054-1-yajun.deng@linux.dev>
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: linux.dev
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

December 20, 2021 7:20 PM, "Marco Elver" <elver@google.com> wrote:=0A=0A>=
 On Mon, 20 Dec 2021 at 04:55, Yajun Deng <yajun.deng@linux.dev> wrote:=
=0A> =0A>> The parameters in __setup_param() should be four rather than t=
hree when=0A>> MODULE isn't definited.=0A> =0A> This is actually "when MO=
DULE is defined". __setup_param() becomes a=0A> nop when compiling as a m=
odule.=0A> =0A> But that begs the question: why hasn't this been caught b=
efore?=0A> Probably because nobody should be using __setup_param() if som=
ething=0A> can also be compiled as a module, in which case module_param()=
 and=0A> friends should be used. But perhaps there are valid usecases whe=
re i=0A> t's meant to become a nop if MODULE.=0A> =0A> I don't object thi=
s fix, since the !MODULE __setup_param() seems like=0A> it was meant to b=
e defined.=0A> =0A> Just curious: did you actually encounter a problem wi=
th some new code=0A> using __setup_param()?=0A=0ANO, it is just code insp=
ection. But for the current code, it's really a bug.=0Avim drivers/clk/im=
x/clk.c  +161=0A=0A#ifndef MODULE=0A=0A...=0A__setup_param("earlycon", im=
x_keep_uart_earlycon,=0A              imx_keep_uart_clocks_param, 0); =0A=
__setup_param("earlyprintk", imx_keep_uart_earlyprintk,=0A              i=
mx_keep_uart_clocks_param, 0); =0A=0A=0A> =0A>> Fixes: 1da177e4c3f4 ("Lin=
ux-2.6.12-rc2")=0A>> Signed-off-by: Yajun Deng <yajun.deng@linux.dev>=0A>=
> ---=0A>> include/linux/init.h | 2 +-=0A>> 1 file changed, 1 insertion(+=
), 1 deletion(-)=0A>> =0A>> diff --git a/include/linux/init.h b/include/l=
inux/init.h=0A>> index d82b4b2e1d25..62a77850f10e 100644=0A>> --- a/inclu=
de/linux/init.h=0A>> +++ b/include/linux/init.h=0A>> @@ -355,7 +355,7 @@ =
void __init parse_early_options(char *cmdline);=0A>> =0A>> #else /* MODUL=
E */=0A>> =0A>> -#define __setup_param(str, unique_id, fn) /* nothing */=
=0A>> +#define __setup_param(str, unique_id, fn, early)/* nothing */=0A>>=
 #define __setup(str, func) /* nothing */=0A>> #endif=0A>> =0A>> --=0A>> =
2.32.0
