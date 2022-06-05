Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48DFD53DD49
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Jun 2022 19:14:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346239AbiFEROV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Jun 2022 13:14:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238415AbiFEROU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Jun 2022 13:14:20 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BD7B26C1
        for <linux-kernel@vger.kernel.org>; Sun,  5 Jun 2022 10:14:19 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id bg6so5064760ejb.0
        for <linux-kernel@vger.kernel.org>; Sun, 05 Jun 2022 10:14:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=a3x+eyy5atoIb9DGqUx5bT9jNzOvpNqSnj+uS1T2FQ0=;
        b=DbcuE1hd+NZHuP8qvfxP4VrqLHJ7dtzuEQ1L62aQS9cEEqcmG+mpSI8+FdFIDT+Qmo
         e3BuaS8Jo46i4pJYgVFTBo18fT8GzP+3wmNz5yX7SSUAU07oxx4OjW5pya+MlK6CgB+B
         cqu+xwCYRUG/9KWyTtOtuhFZHZe13vvZ/dEC0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=a3x+eyy5atoIb9DGqUx5bT9jNzOvpNqSnj+uS1T2FQ0=;
        b=cLlnAP6jAJrRQ95oaxRFtBV93e3kRN3K6y622WdOBMlGx8BzezwADMJShBsBvHrYft
         TefH8zwaLAIxGWHCPoPA97wWx+zfeqKy1a6KrmYNN2BFKjhT6o63bjV01/TD+Qcfj3eQ
         5OX23rP/SZG0TxXO8VLjzY5gz3ORCmEVfYlzEpEUdGSWtECnkh2C6/HjEzPRwRabk3Qa
         pKDAlAG4Df4uFkx6zKtY13YApf7txprz2EpqVh5CE9xXB7znWKxSgZrhwEqEcC0iXkTQ
         JQ8wgoaXlpWm10oRYgLU/4EFlIRsXlVVwhkjZHw+iyG1p5uWgpfTYCDt/mFvBgS/pkrs
         aBaQ==
X-Gm-Message-State: AOAM532WqRCZkh5qm9+v7CK8CGu7a9UUNHKeiYUT01Mq/UGqOn8nemq5
        56/TSLy+bRdCWK4fgULAZHJZvdsWu35OE+yJzjk=
X-Google-Smtp-Source: ABdhPJwnScSAc0eBHITTVKmBSiPrvqL0MFAPp7Nwy3DMkl4OvXhtBCh6tUtsMOdsLJ6OFKehxpSZiw==
X-Received: by 2002:a17:907:1b03:b0:6ff:78d4:c140 with SMTP id mp3-20020a1709071b0300b006ff78d4c140mr18914054ejc.554.1654449257325;
        Sun, 05 Jun 2022 10:14:17 -0700 (PDT)
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com. [209.85.128.44])
        by smtp.gmail.com with ESMTPSA id d22-20020a50fb16000000b0042617ba6389sm7080058edq.19.2022.06.05.10.14.16
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 05 Jun 2022 10:14:16 -0700 (PDT)
Received: by mail-wm1-f44.google.com with SMTP id a10so4007563wmj.5
        for <linux-kernel@vger.kernel.org>; Sun, 05 Jun 2022 10:14:16 -0700 (PDT)
X-Received: by 2002:a05:600c:2e07:b0:39c:37df:2c40 with SMTP id
 o7-20020a05600c2e0700b0039c37df2c40mr14921579wmf.154.1654449256144; Sun, 05
 Jun 2022 10:14:16 -0700 (PDT)
MIME-Version: 1.0
References: <165442136963.152751.14259048792272164569.tglx@xen13>
In-Reply-To: <165442136963.152751.14259048792272164569.tglx@xen13>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 5 Jun 2022 10:13:59 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgjTMQgiKzBZTmb=uWGDEQxDdyF1+qxBkODYciuNsmwnw@mail.gmail.com>
Message-ID: <CAHk-=wgjTMQgiKzBZTmb=uWGDEQxDdyF1+qxBkODYciuNsmwnw@mail.gmail.com>
Subject: Re: [GIT pull] objtool/urgent for v5.19-rc1
To:     Thomas Gleixner <tglx@linutronix.de>,
        Masahiro Yamada <masahiroy@kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>
Content-Type: multipart/mixed; boundary="0000000000003652d105e0b67c3e"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--0000000000003652d105e0b67c3e
Content-Type: text/plain; charset="UTF-8"

On Sun, Jun 5, 2022 at 2:30 AM Thomas Gleixner <tglx@linutronix.de> wrote:
>
> diff --git a/scripts/Makefile.build b/scripts/Makefile.build
> index 06400504150b..6a663b27b286 100644
> --- a/scripts/Makefile.build
> +++ b/scripts/Makefile.build
> @@ -218,7 +218,7 @@ objtool_args =                                                              \
>         $(if $(CONFIG_SLS), --sls)                                      \
>         $(if $(CONFIG_STACK_VALIDATION), --stackval)                    \
>         $(if $(CONFIG_HAVE_STATIC_CALL_INLINE), --static-call)          \
> -       --uaccess                                                       \
> +       $(if $(CONFIG_HAVE_UACCESS_VALIDATION), --uaccess)              \
>         $(if $(linked-object), --link)                                  \
>         $(if $(part-of-module), --module)                               \
>         $(if $(CONFIG_GCOV_KERNEL), --no-unreachable)

Since this clashed with the Kbuild cleanups I just merged, I looked at
it and threw up in my mouth a little.

Not a new problem, but can we do something like that attached, perhaps?

Untested, but looks trivially obvious. FamousLastWords(tm).

                  Linus

--0000000000003652d105e0b67c3e
Content-Type: text/x-patch; charset="US-ASCII"; name="patch.diff"
Content-Disposition: attachment; filename="patch.diff"
Content-Transfer-Encoding: base64
Content-ID: <f_l41k8chg0>
X-Attachment-Id: f_l41k8chg0

IHNjcmlwdHMvTWFrZWZpbGUubGliIHwgMjkgKysrKysrKysrKysrKysrLS0tLS0tLS0tLS0tLS0K
IDEgZmlsZSBjaGFuZ2VkLCAxNSBpbnNlcnRpb25zKCspLCAxNCBkZWxldGlvbnMoLSkKCmRpZmYg
LS1naXQgYS9zY3JpcHRzL01ha2VmaWxlLmxpYiBiL3NjcmlwdHMvTWFrZWZpbGUubGliCmluZGV4
IGQxNDI1Nzc4NjY0Yi4uYzc5Y2VkODExMzBkIDEwMDY0NAotLS0gYS9zY3JpcHRzL01ha2VmaWxl
LmxpYgorKysgYi9zY3JpcHRzL01ha2VmaWxlLmxpYgpAQCAtMjI5LDIwICsyMjksMjEgQEAgaWZk
ZWYgQ09ORklHX09CSlRPT0wKIAogb2JqdG9vbCA6PSAkKG9ianRyZWUpL3Rvb2xzL29ianRvb2wv
b2JqdG9vbAogCi1vYmp0b29sX2FyZ3MgPQkJCQkJCQkJXAotCSQoaWYgJChDT05GSUdfSEFWRV9K
VU1QX0xBQkVMX0hBQ0spLCAtLWhhY2tzPWp1bXBfbGFiZWwpCVwKLQkkKGlmICQoQ09ORklHX0hB
VkVfTk9JTlNUUl9IQUNLKSwgLS1oYWNrcz1ub2luc3RyKQkJXAotCSQoaWYgJChDT05GSUdfWDg2
X0tFUk5FTF9JQlQpLCAtLWlidCkJCQkJXAotCSQoaWYgJChDT05GSUdfRlRSQUNFX01DT1VOVF9V
U0VfT0JKVE9PTCksIC0tbWNvdW50KQkJXAotCSQoaWYgJChDT05GSUdfVU5XSU5ERVJfT1JDKSwg
LS1vcmMpCQkJCVwKLQkkKGlmICQoQ09ORklHX1JFVFBPTElORSksIC0tcmV0cG9saW5lKQkJCQlc
Ci0JJChpZiAkKENPTkZJR19TTFMpLCAtLXNscykJCQkJCVwKLQkkKGlmICQoQ09ORklHX1NUQUNL
X1ZBTElEQVRJT04pLCAtLXN0YWNrdmFsKQkJCVwKLQkkKGlmICQoQ09ORklHX0hBVkVfU1RBVElD
X0NBTExfSU5MSU5FKSwgLS1zdGF0aWMtY2FsbCkJCVwKLQkkKGlmICQoQ09ORklHX0hBVkVfVUFD
Q0VTU19WQUxJREFUSU9OKSwgLS11YWNjZXNzKQkJXAotCSQoaWYgJChkZWxheS1vYmp0b29sKSwg
LS1saW5rKQkJCQkJXAotCSQoaWYgJChwYXJ0LW9mLW1vZHVsZSksIC0tbW9kdWxlKQkJCQlcCi0J
JChpZiAkKENPTkZJR19HQ09WX0tFUk5FTCksIC0tbm8tdW5yZWFjaGFibGUpCitvYmp0b29sX2Fy
Z3MtJChDT05GSUdfSEFWRV9KVU1QX0xBQkVMX0hBQ0spCQkrPSAtLWhhY2tzPWp1bXBfbGFiZWwK
K29ianRvb2xfYXJncy0kKENPTkZJR19IQVZFX05PSU5TVFJfSEFDSykJCSs9IC0taGFja3M9bm9p
bnN0cgorb2JqdG9vbF9hcmdzLSQoQ09ORklHX1g4Nl9LRVJORUxfSUJUKQkJCSs9IC0taWJ0Citv
Ymp0b29sX2FyZ3MtJChDT05GSUdfRlRSQUNFX01DT1VOVF9VU0VfT0JKVE9PTCkJKz0gLS1tY291
bnQKK29ianRvb2xfYXJncy0kKENPTkZJR19VTldJTkRFUl9PUkMpCQkJKz0gLS1vcmMKK29ianRv
b2xfYXJncy0kKENPTkZJR19SRVRQT0xJTkUpCQkJKz0gLS1yZXRwb2xpbmUKK29ianRvb2xfYXJn
cy0kKENPTkZJR19TTFMpCQkJCSs9IC0tc2xzCitvYmp0b29sX2FyZ3MtJChDT05GSUdfU1RBQ0tf
VkFMSURBVElPTikJCQkrPSAtLXN0YWNrdmFsCitvYmp0b29sX2FyZ3MtJChDT05GSUdfSEFWRV9T
VEFUSUNfQ0FMTF9JTkxJTkUpCQkrPSAtLXN0YXRpYy1jYWxsCitvYmp0b29sX2FyZ3MtJChDT05G
SUdfSEFWRV9VQUNDRVNTX1ZBTElEQVRJT04pCQkrPSAtLXVhY2Nlc3MKK29ianRvb2xfYXJncy0k
KENPTkZJR19HQ09WX0tFUk5FTCkJCQkrPSAtLW5vLXVucmVhY2hhYmxlCisKK29ianRvb2xfYXJn
cyA9ICQob2JqdG9vbF9hcmdzLXkpCQlcCisJJChpZiAkKGRlbGF5LW9ianRvb2wpLCAtLWxpbmsp
CQlcCisJJChpZiAkKHBhcnQtb2YtbW9kdWxlKSwgLS1tb2R1bGUpCiAKIGRlbGF5LW9ianRvb2wg
Oj0gJChvciAkKENPTkZJR19MVE9fQ0xBTkcpLCQoQ09ORklHX1g4Nl9LRVJORUxfSUJUKSkKIAo=
--0000000000003652d105e0b67c3e--
