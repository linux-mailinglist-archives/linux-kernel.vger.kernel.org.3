Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1179B49BD55
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 21:40:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232334AbiAYUkq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jan 2022 15:40:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232323AbiAYUke (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jan 2022 15:40:34 -0500
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95162C061747
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jan 2022 12:40:33 -0800 (PST)
Received: by mail-lj1-x229.google.com with SMTP id b14so11795874ljb.0
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jan 2022 12:40:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=n1kkTsjIA/F1IWqHrRaAWXMMPcD/Uv5ibtuDYOR7mwM=;
        b=mJk2ZakZu9I4pk9ZoweaWEZ3lyYSGbgesgD9J/pjxjHu6TkSoxv0cYzmtihs6k5lU2
         fz/iNa2Xud3i6QpKnpMf7VR8Z2zqbO4oB1LdCt7Kg3vOzqDKuy33QrHfJiIZxUsZgsI8
         N0PSaWypurs2tesgR5wsi8QyogQqzn5smMLdvmsrqi/PUHWmtBIzdp9uNKVsschFg1L+
         mdt2/e/Rz8aD1/HSE58uOXXtxobp4VqjVnQQ8zAgg4S4GcaP5U4gD49Xl19cnDhQ7KwE
         dqwcwf5Jap/KNesQUYJlyYTtKBzhBsZHLsn3ETpOO0dwrgG08Ii9+pWjZ9mpJOzBfqBo
         xeag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=n1kkTsjIA/F1IWqHrRaAWXMMPcD/Uv5ibtuDYOR7mwM=;
        b=CTt51FPcTgVVjmRGlZqEk8cmOrSiKYjJSeePv9kIYY9a38+Q+qG0t15VPY59qOsoX6
         flhwP4Kjatkl5tR00ubM4y0TeSMlq5PuTRZm3SmqG+9SYXbMc0tFuP5lYY5hquq1QwuH
         o48zQPmZBmAiD2YTFFrGYN18dt6LewyvroUJs3bNwfq70If8osa/gaElxhcriKIh7EpI
         /j8wL+TDgLpCCauSJ6C9ZPBGsBtVkr0/8pzBAk5/fLD/PmjWmHTfP3dfi7lHTMQvIqY9
         3cspIMA8SnjgPBlr0cwWE13dRzTvd/aJ0clRXoR4SN3xYgG5AjteM3Iw0FOLWxm2K/rc
         WDcQ==
X-Gm-Message-State: AOAM5317WxAtXDbPpEOl7zDJ5gVOGqQqcNizMaJAiA8jL+mt4XP9RvKM
        W2SPNSNFr4gGolU6555E3hy6f2hA2ef5MlDVf8cNXg==
X-Google-Smtp-Source: ABdhPJwqFYjcPHxaLoTDrVYkTbJkK5FXJutbgwZV1gs460eQh4UwxRmcQkJCvM89L3w0xQnwcPP4T5KE7zK0Rco8yg8=
X-Received: by 2002:a2e:a5c9:: with SMTP id n9mr16093565ljp.220.1643143231698;
 Tue, 25 Jan 2022 12:40:31 -0800 (PST)
MIME-Version: 1.0
References: <20220125141422.32655-1-cgzones@googlemail.com> <20220125141422.32655-3-cgzones@googlemail.com>
In-Reply-To: <20220125141422.32655-3-cgzones@googlemail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Tue, 25 Jan 2022 12:40:19 -0800
Message-ID: <CAKwvOdmLAhbvvqi7900yAS5zV8c_Hb7a-Tj_NyVHxh+mePpQbQ@mail.gmail.com>
Subject: Re: [PATCH 4/9] selinux: enclose macro arguments in parenthesis
To:     =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Cc:     selinux@vger.kernel.org, Paul Moore <paul@paul-moore.com>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Eric Paris <eparis@parisplace.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Xiong Zhenwu <xiong.zhenwu@zte.com.cn>,
        Tyler Hicks <tyhicks@linux.microsoft.com>,
        Ondrej Mosnacek <omosnace@redhat.com>,
        Xiu Jianfeng <xiujianfeng@huawei.com>,
        Jeff Vander Stoep <jeffv@google.com>,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 25, 2022 at 6:14 AM Christian G=C3=B6ttsche
<cgzones@googlemail.com> wrote:
>
> Enclose the macro arguments in parenthesis to avoid potential evaluation
> order issues.
>
> Note the xperm and ebitmap macros are still not side-effect safe due to
> double evaluation.
>
> Reported by clang-tidy [bugprone-macro-parentheses]

Good idea to run clang-tidy :)
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>

>
> Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>
> ---
>  security/selinux/include/security.h | 4 ++--
>  security/selinux/ss/ebitmap.h       | 6 +++---
>  security/selinux/ss/sidtab.c        | 4 ++--
>  3 files changed, 7 insertions(+), 7 deletions(-)
>
> diff --git a/security/selinux/include/security.h b/security/selinux/inclu=
de/security.h
> index 6482e0efb368..d91a5672de99 100644
> --- a/security/selinux/include/security.h
> +++ b/security/selinux/include/security.h
> @@ -254,8 +254,8 @@ struct av_decision {
>  #define XPERMS_AUDITALLOW 2
>  #define XPERMS_DONTAUDIT 4
>
> -#define security_xperm_set(perms, x) (perms[x >> 5] |=3D 1 << (x & 0x1f)=
)
> -#define security_xperm_test(perms, x) (1 & (perms[x >> 5] >> (x & 0x1f))=
)
> +#define security_xperm_set(perms, x) ((perms)[(x) >> 5] |=3D 1 << ((x) &=
 0x1f))
> +#define security_xperm_test(perms, x) (1 & ((perms)[(x) >> 5] >> ((x) & =
0x1f)))
>  struct extended_perms_data {
>         u32 p[8];
>  };
> diff --git a/security/selinux/ss/ebitmap.h b/security/selinux/ss/ebitmap.=
h
> index 9eb2d0af2805..58eb822f11ee 100644
> --- a/security/selinux/ss/ebitmap.h
> +++ b/security/selinux/ss/ebitmap.h
> @@ -118,9 +118,9 @@ static inline void ebitmap_node_clr_bit(struct ebitma=
p_node *n,
>  }
>
>  #define ebitmap_for_each_positive_bit(e, n, bit)       \
> -       for (bit =3D ebitmap_start_positive(e, &n);       \
> -            bit < ebitmap_length(e);                   \
> -            bit =3D ebitmap_next_positive(e, &n, bit))   \
> +       for ((bit) =3D ebitmap_start_positive(e, &(n));   \
> +            (bit) < ebitmap_length(e);                 \
> +            (bit) =3D ebitmap_next_positive(e, &(n), bit))       \
>
>  int ebitmap_cmp(struct ebitmap *e1, struct ebitmap *e2);
>  int ebitmap_cpy(struct ebitmap *dst, struct ebitmap *src);
> diff --git a/security/selinux/ss/sidtab.c b/security/selinux/ss/sidtab.c
> index 293ec048af08..a54b8652bfb5 100644
> --- a/security/selinux/ss/sidtab.c
> +++ b/security/selinux/ss/sidtab.c
> @@ -27,8 +27,8 @@ struct sidtab_str_cache {
>         char str[];
>  };
>
> -#define index_to_sid(index) (index + SECINITSID_NUM + 1)
> -#define sid_to_index(sid) (sid - (SECINITSID_NUM + 1))
> +#define index_to_sid(index) ((index) + SECINITSID_NUM + 1)
> +#define sid_to_index(sid) ((sid) - (SECINITSID_NUM + 1))
>
>  int sidtab_init(struct sidtab *s)
>  {
> --
> 2.34.1
>


--=20
Thanks,
~Nick Desaulniers
