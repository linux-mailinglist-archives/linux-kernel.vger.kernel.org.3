Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9FD1E4A0398
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jan 2022 23:24:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348615AbiA1WYv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jan 2022 17:24:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230083AbiA1WYt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jan 2022 17:24:49 -0500
Received: from mail-il1-x12d.google.com (mail-il1-x12d.google.com [IPv6:2607:f8b0:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE19EC061714
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jan 2022 14:24:49 -0800 (PST)
Received: by mail-il1-x12d.google.com with SMTP id p7so2569435ilp.11
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jan 2022 14:24:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kcukqFB2Mce3QdbJubqacFhf/ApIpRPr+r5PZzJZmjU=;
        b=kEyOokOZpOpSkRVUDqQ+jhnPxg2+Zy0uxaD/bF4qTVOq4WYVv5DIJ5rV5VH55Xbtf+
         PrNgg6RDp1pzfNIupQ8uo2sts2p6k1tXDCm1JNOB1rGvo4AiABmjtBjS7au4u+IEPK4K
         7/22pmdD5LryWtyAiniDC6JFW2v3Q4Af1/gtA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kcukqFB2Mce3QdbJubqacFhf/ApIpRPr+r5PZzJZmjU=;
        b=3/Sqj6xHe0BV2pa0ypovB+1kUGa4l8QJrz+Sy/1QC8Vv10OWLyRFO1VGYpYfX2lfGv
         7+eOgiqcv8x7E5IKuYWxi6ZON3XxjY0WY3oGb0f0KqFvoBZq9RaBOeHhnkqsgS/dtqUn
         jvs5FAL+gAFrf7+SU0P2UlQrwKggbvUuS1KZSMuzJ7gsPxwSn5KTGX0Rn30/s/zfAaxs
         VmX0QmTC6MqKnNxd7/txUXucz/3y48QSmkkN/e05ofGze6c/L8SZv8rNLSmNJk2vkHYH
         3H3Q4D9+4oVVX9nlopyODmr1dzYFUOV7OjlUeCWQsBD3+DvI/C9Js/05kx5oRrV2/r82
         eeWA==
X-Gm-Message-State: AOAM533gZMDs3P9LB5Tc3KoAvz76HoaHNrAuVNm5ykzY5VcIZMkYDHqM
        ecRlNKrGywp+klV1MXAp/T7L6hUyjuxBPg==
X-Google-Smtp-Source: ABdhPJyLDbT/7xJjC17ovv6YKaE79b2mwmyOL6M41UQxLrbfhZHBXlQSNMVaowYAnK4OqeBS+eB+JA==
X-Received: by 2002:a05:6e02:1d9a:: with SMTP id h26mr7159682ila.142.1643408689076;
        Fri, 28 Jan 2022 14:24:49 -0800 (PST)
Received: from mail-il1-f182.google.com (mail-il1-f182.google.com. [209.85.166.182])
        by smtp.gmail.com with ESMTPSA id f2sm14860699ilu.79.2022.01.28.14.24.48
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Jan 2022 14:24:48 -0800 (PST)
Received: by mail-il1-f182.google.com with SMTP id u5so6637662ilq.9
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jan 2022 14:24:48 -0800 (PST)
X-Received: by 2002:a05:6e02:1d9a:: with SMTP id h26mr7159636ila.142.1643408688177;
 Fri, 28 Jan 2022 14:24:48 -0800 (PST)
MIME-Version: 1.0
References: <20220128144055.207267-1-daniel.thompson@linaro.org>
In-Reply-To: <20220128144055.207267-1-daniel.thompson@linaro.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Fri, 28 Jan 2022 14:24:36 -0800
X-Gmail-Original-Message-ID: <CAD=FV=U7h=D+SqLU8Z12YzEjA+kDPjVZ6TxmaH8uQrg1DWT9sg@mail.gmail.com>
Message-ID: <CAD=FV=U7h=D+SqLU8Z12YzEjA+kDPjVZ6TxmaH8uQrg1DWT9sg@mail.gmail.com>
Subject: Re: [PATCH] kdb: Fix the putarea helper function
To:     Daniel Thompson <daniel.thompson@linaro.org>
Cc:     Jason Wessel <jason.wessel@windriver.com>,
        kgdb-bugreport@lists.sourceforge.net,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, Jan 28, 2022 at 6:41 AM Daniel Thompson
<daniel.thompson@linaro.org> wrote:
>
> Currently kdb_putarea_size() uses copy_from_kernel_nofault() to write *to*
> arbitrary kernel memory. This is obviously wrong and means the memory
> modify ('mm') command is a serious risk to debugger stability: if we poke
> to a bad address we'll double-fault and lose our debug session.
>
> Fix this the (very) obvious way.
>
> Note that there are two Fixes: tags because the API was renamed and this
> patch will only trivially backport as far as the rename (and this is
> probably enough). Nevertheless Christoph's rename did not introduce this
> problem so I wanted to record that!
>
> Fixes: fe557319aa06 ("maccess: rename probe_kernel_{read,write} to copy_{from,to}_kernel_nofault")
> Fixes: 5d5314d6795f ("kdb: core for kgdb back end (1 of 2)")
> Signed-off-by: Daniel Thompson <daniel.thompson@linaro.org>
> ---
>  kernel/debug/kdb/kdb_support.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/kernel/debug/kdb/kdb_support.c b/kernel/debug/kdb/kdb_support.c
> index df2bface866ef..85cb51c4a17e6 100644
> --- a/kernel/debug/kdb/kdb_support.c
> +++ b/kernel/debug/kdb/kdb_support.c
> @@ -291,7 +291,7 @@ int kdb_getarea_size(void *res, unsigned long addr, size_t size)
>   */
>  int kdb_putarea_size(unsigned long addr, void *res, size_t size)
>  {
> -       int ret = copy_from_kernel_nofault((char *)addr, (char *)res, size);
> +       int ret = copy_to_kernel_nofault((char *)addr, (char *)res, size);

Looks fine to me.

Reviewed-by: Douglas Anderson <dianders@chromium.org>

If you wanted to further clean things up a bit, you could probably get
rid of at some of the unnecessary "char *" casts and also add a
"const", AKA:

int kdb_putarea_size(unsigned long addr, const void *res, size_t size)
{
  int ret = copy_to_kernel_nofault((void *)addr, res, size);


-Doug
