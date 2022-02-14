Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D3334B5C79
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Feb 2022 22:20:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230452AbiBNVTl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Feb 2022 16:19:41 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:40246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230446AbiBNVTi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 16:19:38 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6AA6F1162AA
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 13:19:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1644873567;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=iPJv+2s91+qxlbeq2Ny6bT4Ihe2WEyqS+/iM8RL4Bn0=;
        b=TPRDGWJ+WyvUOpVqvPOd6lCb2GSivskACzjLLvnyQJiwDPdsM4XAdvW1ild2jB993ZGigB
        c9+4t1hmpEYY6JEnAFkh3higuweaFZGko7+jeMPuW1NtDozcU/EOnSaVPGnIUZP+Uo8hOR
        ukD03ByMoeDuzNJ2BoFkKXchLJuUo48=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-626-xIry2x51NpSAnPmKZCx4JA-1; Mon, 14 Feb 2022 15:07:34 -0500
X-MC-Unique: xIry2x51NpSAnPmKZCx4JA-1
Received: by mail-qk1-f199.google.com with SMTP id p23-20020a05620a15f700b00506d8ec3749so9963041qkm.4
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 12:07:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=iPJv+2s91+qxlbeq2Ny6bT4Ihe2WEyqS+/iM8RL4Bn0=;
        b=EV2AwEYkLHwvsAQokmNZaVWGZBy0c1nsKbrst8wZ6zyofv4scQ10SMriacoZxxKKZX
         T3rLYweeqVggXM/0f+d5NiPgKFvN0VCC4Oq3oZAF4Q7neua2eRehV7FCRqdpde4mPxbO
         CGpnqi3RJxvRgtlLJ7ShgsbVFu/oOJ70tgGOeAxj1q2pjuaPaOjyofVL6oTwQn+c0BNn
         j9Nj7SaQCry7+f8KoOW9GTOKZ1SdcFxHp3JdaEF/EQ3Gt88etUHUptjNY/P+8YzDbd2B
         EvFj7YJ86j+zzTRKeb+Nc7voWHkdfJjanFpDRPn2JCxAIcFYMIMb4gTy8GHZqYoY2KGn
         7j0w==
X-Gm-Message-State: AOAM533FyctrWQ7zLTh2bl/6hlTE59aJtSqyXhPjp61orWlHgS6RtLqs
        MiRm21tTDNjg3onDzDv9EwefhggQJGSfzAfBV3GgQtSVlip7To3oQS0PugN9q6gaxrQfMGBbt8t
        QYMD5m1f1870qxzNgSd3SfU2u
X-Received: by 2002:ac8:58c2:: with SMTP id u2mr440863qta.509.1644869253745;
        Mon, 14 Feb 2022 12:07:33 -0800 (PST)
X-Google-Smtp-Source: ABdhPJziQ3LUbgpn5decE7UKkR4L9MWWc2+J8EzWdi5Gt9Je1G/dpGasfQR+cKCLqAzYrwsLSIfSRw==
X-Received: by 2002:ac8:58c2:: with SMTP id u2mr440842qta.509.1644869253496;
        Mon, 14 Feb 2022 12:07:33 -0800 (PST)
Received: from treble ([2600:1700:6e32:6c00::35])
        by smtp.gmail.com with ESMTPSA id c21sm18647378qte.68.2022.02.14.12.07.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Feb 2022 12:07:33 -0800 (PST)
Date:   Mon, 14 Feb 2022 12:07:30 -0800
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     Valdis =?utf-8?Q?Kl=C4=93tnieks?= <valdis.kletnieks@vt.edu>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Justin Forbes <jmforbes@linuxtx.org>,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH v2] tools: Fix use-after-free for realloc(..., 0)
Message-ID: <20220214200730.a3qz6ocy2ohwafrt@treble>
References: <20220213182443.4037039-1-keescook@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220213182443.4037039-1-keescook@chromium.org>
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 13, 2022 at 10:24:43AM -0800, Kees Cook wrote:
> GCC 12 was correctly reporting a potential use-after-free condition in
> the xrealloc helper. Fix the warning by avoiding an implicit "free(ptr)"
> when size == 0:
> 
> In file included from help.c:12:
> In function 'xrealloc',
>     inlined from 'add_cmdname' at help.c:24:2: subcmd-util.h:56:23: error: pointer may be used after 'realloc' [-Werror=use-after-free]
>    56 |                 ret = realloc(ptr, size);
>       |                       ^~~~~~~~~~~~~~~~~~
> subcmd-util.h:52:21: note: call to 'realloc' here
>    52 |         void *ret = realloc(ptr, size);
>       |                     ^~~~~~~~~~~~~~~~~~
> subcmd-util.h:58:31: error: pointer may be used after 'realloc' [-Werror=use-after-free]
>    58 |                         ret = realloc(ptr, 1);
>       |                               ^~~~~~~~~~~~~~~
> subcmd-util.h:52:21: note: call to 'realloc' here
>    52 |         void *ret = realloc(ptr, size);
>       |                     ^~~~~~~~~~~~~~~~~~
> 
> Reported-by: "Valdis Klētnieks" <valdis.kletnieks@vt.edu>
> Fixes: 2f4ce5ec1d44 ("perf tools: Finalize subcmd independence")
> Cc: Josh Poimboeuf <jpoimboe@redhat.com>
> Signed-off-by: Kees Cook <keescook@chromium.org>
> ---
> v1: https://lore.kernel.org/lkml/20220212181855.3460176-1-keescook@chromium.org/
> v2: simplify logic (josh)

Thanks, running through testing now.

-- 
Josh

