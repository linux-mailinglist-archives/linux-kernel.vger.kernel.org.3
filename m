Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B51A59BE58
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Aug 2022 13:21:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232953AbiHVLUw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Aug 2022 07:20:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231649AbiHVLUq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Aug 2022 07:20:46 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DCD01EAFE
        for <linux-kernel@vger.kernel.org>; Mon, 22 Aug 2022 04:20:45 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id gt3so8048773ejb.12
        for <linux-kernel@vger.kernel.org>; Mon, 22 Aug 2022 04:20:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=cgJN2ys9qVPNZ5LS8BKgDsHmvC/ytmOYuYaJYA/HCmg=;
        b=dp12s38RtePIj9ZwHxOMYV2XISJFfRJui+/uiiQF7B5539RHm0SmyzakQqhAluf7Mc
         ZexTMrxhsOjYh4hIW/BK4OfL0v4oMY5bwAprTNFfHdxE+DfAOflCnV8hLIhTDBz1FBM6
         Ufk/PGgg1jp1ruzvmCZndel0jQQWxyIZBVnFCkHZYngDz2Onhm2REId9OBDjCqNVkDlU
         uZXi9Q/c6eLgJVt7kk13pYitak+3Tpbsy1u9NrFaRh13R4uT2WEvRiKg4DfrlTMvZJ7E
         Ht3BgtUiN8SuJcczU7B1GK0Kyh0r4Q/4uddqYPNkJdNIJ67jJFlYt8SwTVMxB7QVfCX2
         o2pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=cgJN2ys9qVPNZ5LS8BKgDsHmvC/ytmOYuYaJYA/HCmg=;
        b=WSYze+xMRqwDGCJTRZfZ4h1rfDkawR3TUNOE9sc9gnXjbE0MAfyLSII4OZSJzMjw7X
         XrelR5acIYoQ5zctJsRQxdxueSaGPbdJgYrDBelllPi9iaQvGmCWqMXodeQTFh+sjC9n
         SK1J2SzhoQg+s5CkjxSxJu7wHz++Hav/3B43XnoYLGGRYFWcXijP+PuJmZv7MiW9RFeq
         ACWB+MJMf/xdGuFAVDJMyXaleG/VwsPc+v7ZQVpg5g/77fHhoujoRolBvfCKWaE1zFHz
         rPZ07APupkGqtH+8Hmc8+iP3612yA9Jn6IiPQZO4U9Gtyz6aZnNyBkK64S9odkAR0KPU
         dNwg==
X-Gm-Message-State: ACgBeo0gzz5XXyB4wwFux3vjVLZ2PRxRUUKhzt6231MpkPjyGi6oVI61
        qJ8215U5YgkQBSTseq4/XOQ0SCI1pYmDs8brtpwE6Q==
X-Google-Smtp-Source: AA6agR4T6Kaw/vxtVJKoeTJ6uuu+b/StMskQT4k6L0VQvGtA8MKgg/P6udOicBqmXtdGE9yzS8e3SEKhOJCbVa6vmfs=
X-Received: by 2002:a17:906:974f:b0:73d:716a:7d98 with SMTP id
 o15-20020a170906974f00b0073d716a7d98mr4732698ejy.208.1661167244102; Mon, 22
 Aug 2022 04:20:44 -0700 (PDT)
MIME-Version: 1.0
References: <20220815110240.18293-1-chenzhongjin@huawei.com>
In-Reply-To: <20220815110240.18293-1-chenzhongjin@huawei.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 22 Aug 2022 13:20:32 +0200
Message-ID: <CACRpkdZsdggUptPkPhzzu8vv9moSO+rjvZxZRb1VqJ2xWjY=HQ@mail.gmail.com>
Subject: Re: [RESEND PATCH] ARM: Recover kretprobes return address for EABI
 stack unwinder
To:     Chen Zhongjin <chenzhongjin@huawei.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, linux@armlinux.org.uk, arnd@arndb.de,
        ardb@kernel.org, rmk+kernel@armlinux.org.uk, rostedt@goodmis.org,
        nick.hawkins@hpe.com, john@phrozen.org, mhiramat@kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 15, 2022 at 1:06 PM Chen Zhongjin <chenzhongjin@huawei.com> wrote:

> 'fed240d9c974 ("ARM: Recover kretprobe modified return address in stacktrace")'
> has implemented kretprobes return address recovery for FP
> unwinder, this patch makes it works for EABI unwinder.
>
> It saves __kretprobe_trampoline address in LR on stack to identify
> and recover the correct return address in EABI unwinder.
>
> Since EABI doesn't use r11 as frame pointer, we need to use SP to
> identify different kretprobes addresses. Here the value of SP has fixed
> distance to conventional FP position so it's fine to use it.
>
> Passed kunit kprobes_test on QEMU.
>
> Signed-off-by: Chen Zhongjin <chenzhongjin@huawei.com>

This looks correct to me FWIW I understand the assembly
but I'm vaguely unfamiliar with the kprobe API, but anyway:
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Would you please drop it into Russell's patch tracker?

Yours,
Linus Walleij
