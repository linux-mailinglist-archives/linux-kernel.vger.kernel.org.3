Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9E7B50CBE9
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Apr 2022 17:43:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236053AbiDWPqj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Apr 2022 11:46:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232276AbiDWPqh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Apr 2022 11:46:37 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F5AE2BB0B
        for <linux-kernel@vger.kernel.org>; Sat, 23 Apr 2022 08:43:40 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id y32so19157104lfa.6
        for <linux-kernel@vger.kernel.org>; Sat, 23 Apr 2022 08:43:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4WHApmPCfTFsZFN9GFCJLzgthMPw0HP2hQj97izCWAk=;
        b=PGJKcPYtMN8PggIvNqazp/mB0spUOZzpAI74tLjDiGm2UMzPpYb5k+ZQl/XUiPToPt
         f9EHvc7CADGq3JuAeqBZ2q+SFcKn+5pOnBqHBqsAji2Mv4KEc2ZUF8HLP+e+jVSaq5oM
         sw9B7mgOwdLx6J7RrQMldjCejWQRR0x71qUr01TLl8FPU/zV7yy3jYZI46QuD6p1sOr9
         JvxoB3eR0yzGZlVzIsUcCCiwYYL+Ujn/sp4NTUYQOFyEsczOvjyTYFArL+vOU3b/l5nD
         tUJMl+hMtn7BmkpKXNXkCoP8TOdZLiWIRVnE9sFLbNdLf6GqmpxZ/WxK0TZA6oPJ2aoU
         U9jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4WHApmPCfTFsZFN9GFCJLzgthMPw0HP2hQj97izCWAk=;
        b=Vo6iAd6oeLtM28ed9SnxLvO7sd0+Ayj+G50AKyaNYgEmfcTIU2k/z8Qrb52qDDaKTP
         XxvUFLh+fHONyrGohmsBnsF0RDTm0EtfYgmGczp0hyJMqdIHIAn4JHMkfu9cY0FxOyzc
         yhnzAX8gdJ+PmFQXCHJT4RWbB1oHB33deCB681NneAKiE8K7wzEM4Vt+zH09gu+7AgY0
         MMHEyBLe9ruWkqnOUo3qfu5QbcpGvFJx+adcAziitEEDqIbwomcqkdLiFUt8aeFt6s+C
         D+LBJqFLoLQv87wMoM844Nmhr0kiywKofqOOlbeM/++HE/0MxBdgR53ZLlLPWpgQgoZB
         nx+A==
X-Gm-Message-State: AOAM532PAR72XnTgelMHp06sFGhJhdtDFN882aUj/hULhbkCwIChasOf
        8lhIepVXyAXPizttKq24BQRALkJRiKoZ8JBIO8IOtQ==
X-Google-Smtp-Source: ABdhPJyk3Nx7kYTAwClkyxuwSV4OEapAO7ZAQTeCMdnIsRRk3FBmUgbOjZMJR8UTSfe7a/EGPyA0Kz1hU8LBniYwoXo=
X-Received: by 2002:a05:6512:3fa1:b0:44a:f351:5a00 with SMTP id
 x33-20020a0565123fa100b0044af3515a00mr6786966lfa.19.1650728618477; Sat, 23
 Apr 2022 08:43:38 -0700 (PDT)
MIME-Version: 1.0
References: <20220423102421.16869-1-fmdefrancesco@gmail.com> <20220423102421.16869-3-fmdefrancesco@gmail.com>
In-Reply-To: <20220423102421.16869-3-fmdefrancesco@gmail.com>
From:   Todd Kjos <tkjos@google.com>
Date:   Sat, 23 Apr 2022 08:43:27 -0700
Message-ID: <CAHRSSEwLRHVpeBk+v_pGOukT_0b9LhVD3mRFWcuBrJ4Tcv3tMA@mail.gmail.com>
Subject: Re: [PATCH 2/3] binder: Use kmap_local_page() in binder_alloc_copy_user_to_buffer()
To:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        =?UTF-8?B?QXJ2ZSBIasO4bm5ldsOlZw==?= <arve@android.com>,
        Todd Kjos <tkjos@android.com>,
        Martijn Coenen <maco@android.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Christian Brauner <brauner@kernel.org>,
        Hridya Valsaraju <hridya@google.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Ira Weiny <ira.weiny@intel.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 23, 2022 at 3:24 AM Fabio M. De Francesco
<fmdefrancesco@gmail.com> wrote:
>
> The use of kmap() is being deprecated in favor of kmap_local_page()
> where it is feasible. With kmap_local_page(), the mapping is per
> thread, CPU local and not globally visible.
>
> binder_alloc_copy_user_to_buffer() is a function where the use of
> kmap_local_page() in place of kmap() is correctly suited because
> the mapping is local to the thread.
>
> Therefore, use kmap_local_page() / kunmap_local().
>
> Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>

Acked-by: Todd Kjos <tkjos@google.com>

> ---
>  drivers/android/binder_alloc.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/android/binder_alloc.c b/drivers/android/binder_alloc.c
> index 0b3f2f569053..0875c463c002 100644
> --- a/drivers/android/binder_alloc.c
> +++ b/drivers/android/binder_alloc.c
> @@ -1217,9 +1217,9 @@ binder_alloc_copy_user_to_buffer(struct binder_alloc *alloc,
>                 page = binder_alloc_get_page(alloc, buffer,
>                                              buffer_offset, &pgoff);
>                 size = min_t(size_t, bytes, PAGE_SIZE - pgoff);
> -               kptr = kmap(page) + pgoff;
> +               kptr = kmap_local_page(page) + pgoff;
>                 ret = copy_from_user(kptr, from, size);
> -               kunmap(page);
> +               kunmap_local(kptr);
>                 if (ret)
>                         return bytes - size + ret;
>                 bytes -= size;
> --
> 2.34.1
>
