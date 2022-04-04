Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CB224F1C16
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Apr 2022 23:26:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381726AbiDDVXy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Apr 2022 17:23:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380413AbiDDUFb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Apr 2022 16:05:31 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F162CC36
        for <linux-kernel@vger.kernel.org>; Mon,  4 Apr 2022 13:03:33 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id i27so15174579ejd.9
        for <linux-kernel@vger.kernel.org>; Mon, 04 Apr 2022 13:03:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=CrpYt5lVlKuy2k+kKWnZgQywx0bCmkEjtjH6HYRoOhQ=;
        b=QWtilS35liU4Gd847ayqzl1+Xu3q5LYVHMfUzUizuln6K7VajF0VthS1a5ivhzNuZs
         Vb0AbMMPTtLaqQ4fs96PTRsH5w8FZuGJQgk7wadg4Zc3h1TT5TsDl2lEcelg9XECB2ef
         q6pR6ZpG0WiArgQVkKPp2zQvs80GH3EFdkk8IBI8n7UhuS1QqVotwHz2FlEBLP/5/tB2
         CJ6tkq0oJXB2dZ1K3zGKK1n8+9u3/7xygKNh015o9+LY81o7hMI+cCH66leOlKSBgFnw
         BXGjLKXGVsCcw0zfsHm7B1VvznCY4DVSqevmzZrA6DknE0HLN8njsh9vZ7s6qDiGhw+Y
         jS3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=CrpYt5lVlKuy2k+kKWnZgQywx0bCmkEjtjH6HYRoOhQ=;
        b=nKLLxKs8lcsSIy+OgDxEIEmgsOuXhOCGWPkwNfyP8N7y8c41PgqBkQ54YzMEKv+SqA
         nBYArzCsKQLV1/uvGBMNqcQs83zPJvE/Jk16YxZRAFhH0LIuTgQiSliW1a9xBZu35OLU
         rKgJVJaCYClw3M+IOA4tENGARa+ebyP+cFeyxMaGR4x8Vv0IZV5DjXph+S6aajBYlCKv
         mpa5mljyjobak5gkJ4MeR9tzg4BGS2/GJELTWjuoDt4E8MyNNy5CBQaBQcIUkbb7DoT9
         Tjg7UxnZtoCJrY882PBuDeKyryqiKtbcF65iQ71c4P6VcAo3JZcpOEH3c+vtYGiLaIN1
         iI8Q==
X-Gm-Message-State: AOAM531nnxztb8/jXcyKt46zjCeh+Veu+qXYknJEpHcHf/j7u7QvpYZR
        /YupNByx3Oo6QFt5okXBqlI420J7FhfABM2lQwpf
X-Google-Smtp-Source: ABdhPJyIZr77gRBKBLN+KRty/vPEiELEMcVGmq1Bl8JpZPMVFi21TaeAcOxBzdX6c3pksfR5Ragz6OdS5QPYOCAQBHg=
X-Received: by 2002:a17:906:4443:b0:6cf:6a7d:5f9b with SMTP id
 i3-20020a170906444300b006cf6a7d5f9bmr1776503ejp.12.1649102612452; Mon, 04 Apr
 2022 13:03:32 -0700 (PDT)
MIME-Version: 1.0
References: <20220217142133.72205-3-cgzones@googlemail.com> <20220308165527.45456-1-cgzones@googlemail.com>
In-Reply-To: <20220308165527.45456-1-cgzones@googlemail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Mon, 4 Apr 2022 16:03:21 -0400
Message-ID: <CAHC9VhSGggUV2po0mj0qqMBBX1n56BzR99khcYfhjv4jZprEiQ@mail.gmail.com>
Subject: Re: [PATCH v2 4/5] selinux: declare data arrays const
To:     =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Cc:     selinux@vger.kernel.org,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Eric Paris <eparis@parisplace.org>,
        Ondrej Mosnacek <omosnace@redhat.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jeremy Kerr <jk@codeconstruct.com.au>,
        Richard Haines <richard_c_haines@btinternet.com>,
        Lakshmi Ramasubramanian <nramas@linux.microsoft.com>,
        Austin Kim <austin.kim@lge.com>,
        Yang Li <yang.lee@linux.alibaba.com>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 8, 2022 at 11:55 AM Christian G=C3=B6ttsche
<cgzones@googlemail.com> wrote:
>
> The arrays for the policy capability names, the initial sid identifiers
> and the class and permission names are not changed at runtime.  Declare
> them const to avoid accidental modification.
>
> Do not override the classmap and the initial sid list in the build time
> script genheaders, by using a static buffer in the conversion function
> stoupperx().  In cases we need to compare or print more than one
> identifier allocate a temporary copy.
>
> Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>
> ---
> v2:
>    Drop const exemption for genheaders script by rewriting stoupperx().
> ---
>  scripts/selinux/genheaders/genheaders.c       | 76 ++++++++++---------
>  scripts/selinux/mdp/mdp.c                     |  4 +-
>  security/selinux/avc.c                        |  2 +-
>  security/selinux/include/avc_ss.h             |  2 +-
>  security/selinux/include/classmap.h           |  2 +-
>  .../selinux/include/initial_sid_to_string.h   |  3 +-
>  security/selinux/include/policycap.h          |  2 +-
>  security/selinux/include/policycap_names.h    |  2 +-
>  security/selinux/ss/services.c                |  4 +-
>  9 files changed, 51 insertions(+), 46 deletions(-)
>
> diff --git a/scripts/selinux/genheaders/genheaders.c b/scripts/selinux/ge=
nheaders/genheaders.c
> index f355b3e0e968..a2caff3c997f 100644
> --- a/scripts/selinux/genheaders/genheaders.c
> +++ b/scripts/selinux/genheaders/genheaders.c
> @@ -26,19 +26,23 @@ static void usage(void)
>         exit(1);
>  }
>
> -static char *stoupperx(const char *s)
> +static const char *stoupperx(const char *s)
>  {
> -       char *s2 =3D strdup(s);
> -       char *p;
> +       static char buffer[256];
> +       unsigned int i;
> +       char *p =3D buffer;
>
> -       if (!s2) {
> -               fprintf(stderr, "%s:  out of memory\n", progname);
> +       for (i =3D 0; i < (sizeof(buffer) - 1) && *s; i++)
> +               *p++ =3D toupper(*s++);
> +
> +       if (*s) {
> +               fprintf(stderr, "%s:  buffer too small\n", progname);
>                 exit(3);
>         }
>
> -       for (p =3D s2; *p; p++)
> -               *p =3D toupper(*p);
> -       return s2;
> +       *p =3D '\0';
> +
> +       return buffer;
>  }

Hmmm.  I recognize this is just build time code so it's not as
critical, but I still don't like the idea of passing back a static
buffer to the caller; it just seems like we are asking for future
trouble.  I'm also curious as to why you made this choice in this
revision when the existing code should have worked (passed a const,
returned a non-const).  I'm sure I'm missing something obvious, but
can you help me understand why this is necessary?

--=20
paul-moore.com
