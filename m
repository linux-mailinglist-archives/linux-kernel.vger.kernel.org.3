Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 003B54BBE72
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Feb 2022 18:32:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238617AbiBRRcO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Feb 2022 12:32:14 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:41752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236830AbiBRRcJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Feb 2022 12:32:09 -0500
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com [IPv6:2607:f8b0:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7453C5C87A
        for <linux-kernel@vger.kernel.org>; Fri, 18 Feb 2022 09:31:51 -0800 (PST)
Received: by mail-ot1-x32d.google.com with SMTP id j8-20020a056830014800b005ad00ef6d5dso2467167otp.0
        for <linux-kernel@vger.kernel.org>; Fri, 18 Feb 2022 09:31:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=nebMkmur+LCxBFBdQ4EXcYnlngkdDHM11vfdWfCglsQ=;
        b=qOv30FszpMXxedCYqw7Wlk3PgAiJh6cKSD3NQ7aJFQyHEdlXr13TAv3jxhrAWun9sO
         YKvcPV8jrrIF/QJEAYVnBOnyEdF1iCqU+rHIVvS4VFGPyAf3gDFsqsBU6+DZxonWYQcE
         6N0xBLSI5cD6TXX/dSD2bA3g7id7/dnJaTN4QkJGJZvTvL3WJ0beg+N8Tg+UcJPZ1b4E
         Vdy054NfIH5ql9x01R86PI3sjjb5Gf0u9uqo6E2keDLxW5SdFy+qrIB8Aft1WCxC+Zyr
         2BCpWFj3rQdi7WtkjEIGgKatb4JD5Jx8axCFz7I8+zyr0564OtCpQ+wIIvX9uy7nUq93
         0nTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=nebMkmur+LCxBFBdQ4EXcYnlngkdDHM11vfdWfCglsQ=;
        b=Y9WfoMwHEdTEkRyE7JWwKY7nZ+tH/yPk3DMaEJ5VpdM1sBua9x+ns8cmtuHNskCY7/
         4GIFKGIDrD0Saujd1VWh5Ugg0JBu1WCuUy8aNFR33PNlitJ2dBeQBX/Qcc4JZ5FrguTr
         oL+jCcs5SZKPO+6jEDRy7uegg5yyIobbYL6uAM+CyhRZ/EiotHEIDZ7zBCm9imq98bF+
         Wk4mjQrc2OMgko/LAJCzSpt3dlGRZQ1GpGUdbrAgvZ0Lds/p+4lAnbAp17zv0wGNS8Lr
         VnI9TijJO1kEwfxj0wzCyY8Ddy5hqs5HAEbhXDJ16bmfOll9xSK1ZrznVWDScxuBEdFI
         NYgA==
X-Gm-Message-State: AOAM531NrN++A5tl1VNYA3aednty1/X9PbB9FsuK3XOpaS3oXlhxZ5oX
        9IUX4y2PNb+wf3bMZ1LwrWHMWTrJoa+KApQtAapYoA==
X-Google-Smtp-Source: ABdhPJwHuglG3+2+j2XRYDFvOYqQuaKHBnuw+/dO3Bw5z0CIdEYLx0tl4quY7Mc68D/E3dWCqQGvzAzwhhXj3decPis=
X-Received: by 2002:a9d:27e8:0:b0:599:976a:c873 with SMTP id
 c95-20020a9d27e8000000b00599976ac873mr2843690otb.305.1645205510543; Fri, 18
 Feb 2022 09:31:50 -0800 (PST)
MIME-Version: 1.0
References: <20220217142133.72205-1-cgzones@googlemail.com> <20220217142133.72205-4-cgzones@googlemail.com>
In-Reply-To: <20220217142133.72205-4-cgzones@googlemail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Fri, 18 Feb 2022 09:31:39 -0800
Message-ID: <CAKwvOdkNZ3W9amcQKHOEfQLbdWC=4VDtrBdbOVHtWruipQnyKg@mail.gmail.com>
Subject: Re: [PATCH 5/5] selinux: drop unnecessary NULL check
To:     =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Cc:     selinux@vger.kernel.org, Paul Moore <paul@paul-moore.com>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Eric Paris <eparis@parisplace.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Ondrej Mosnacek <omosnace@redhat.com>,
        Serge Hallyn <serge@hallyn.com>,
        Austin Kim <austin.kim@lge.com>,
        Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
        Casey Schaufler <casey@schaufler-ca.com>,
        Yang Li <yang.lee@linux.alibaba.com>,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 17, 2022 at 6:22 AM Christian G=C3=B6ttsche
<cgzones@googlemail.com> wrote:
>
> Commit e3489f8974e1 ("selinux: kill selinux_sb_get_mnt_opts()")
> introduced a NULL check on the context after a successful call to
> security_sid_to_context().  This is on the one hand redundant after
> checking for success and on the other hand insufficient on an actual
> NULL pointer, since the context is passed to seq_escape() leading to a
> call of strlen() on it.
>
> Reported by Clang analyzer:
>
>     In file included from security/selinux/hooks.c:28:
>     In file included from ./include/linux/tracehook.h:50:
>     In file included from ./include/linux/memcontrol.h:13:
>     In file included from ./include/linux/cgroup.h:18:
>     ./include/linux/seq_file.h:136:25: warning: Null pointer passed as 1s=
t argument to string length function [unix.cstring.NullArg]
>             seq_escape_mem(m, src, strlen(src), flags, esc);
>                                    ^~~~~~~~~~~

I'm guessing there was more to this trace for this instance of this warning=
?

>
> Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>
> ---
>  security/selinux/hooks.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> index 1e69f88eb326..ac802b99d36c 100644
> --- a/security/selinux/hooks.c
> +++ b/security/selinux/hooks.c
> @@ -1020,7 +1020,7 @@ static int show_sid(struct seq_file *m, u32 sid)
>         rc =3D security_sid_to_context(&selinux_state, sid,
>                                              &context, &len);
>         if (!rc) {

^ perhaps changing this condition to:

if (!rc && context) {

It might be nice to retain the null ptr check should the semantics of
security_sid_to_context ever change.

> -               bool has_comma =3D context && strchr(context, ',');
> +               bool has_comma =3D strchr(context, ',');
>
>                 seq_putc(m, '=3D');
>                 if (has_comma)
> --
> 2.35.1
>


--=20
Thanks,
~Nick Desaulniers
