Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 50A5949E623
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jan 2022 16:34:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237849AbiA0Pes (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jan 2022 10:34:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229985AbiA0Per (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jan 2022 10:34:47 -0500
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70AE0C061714
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jan 2022 07:34:47 -0800 (PST)
Received: by mail-ej1-x62c.google.com with SMTP id p15so6630658ejc.7
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jan 2022 07:34:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxtx.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=yUa2ioDFsHPQ1yheKLej8gbMqid52oPBmcpyM99h+kE=;
        b=JYdaec/RrKAq8Dl6KWVNIulj8Q4JQMF9EknaUDhIC84aAWTchRbghkRbB4hK08yOKj
         DAFvnSJonHcMLXsXj+YhNunFNJfdl3psjfsPyJrfiYTRaezqpwmr3OVltJqdUQBqKaEa
         LWET4/cb6MuBRehDweZr/ysUkdYHOLI3icpyg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=yUa2ioDFsHPQ1yheKLej8gbMqid52oPBmcpyM99h+kE=;
        b=U+sWrkovQU8wZRyVMXRdUmKfibsnpHyHGrbHmMpW+k2A6hYUpPrBZEERp3BBYqneJD
         ZPsTwTlqCMcqBdNQ8Fo1FySyQeSqCEJoMUd/fA/18YdkkmTzy/9KxYqcQ9AD0fJHSywK
         zQHLpCg3lcdsEWxhWNp08Wr2mn7vuzt+5oZthuM42uCR1HfB9aIbYrdoNVuWoSRqDSvm
         pDSSLohZsO6j+blrxd6FkmMquEYUSQwlLMthpaMRfxYO+Rgh45D2VdwInix3x9ogt9ht
         ABVQv1u73RlvEP7eApVEtoTeEqr4himVAYQJdRONh8+RChymrRb0lAYl5QLs27mVz2We
         jy9w==
X-Gm-Message-State: AOAM533LK4ZWJoR6ZZAF47eHNzgxTSpdA3FLBssWjZErKdVA5wEjJ6cX
        X3L6K0HwZctQoviA9ARAams+jHLxLyr+bndfifumE2R68UpTmg==
X-Google-Smtp-Source: ABdhPJzmPOXUvKbd0BslE1ZJlPsZwhv9JvVcBdRRX9qGxo/4HaaMZLcFJ15IJLX33smoBdPjLQIaURyGKTKLzmsrxYo=
X-Received: by 2002:a17:906:fd55:: with SMTP id wi21mr3334820ejb.712.1643297685454;
 Thu, 27 Jan 2022 07:34:45 -0800 (PST)
MIME-Version: 1.0
References: <20494.1643237814@turing-police>
In-Reply-To: <20494.1643237814@turing-police>
From:   Justin Forbes <jmforbes@linuxtx.org>
Date:   Thu, 27 Jan 2022 09:34:34 -0600
Message-ID: <CAFxkdAoe8XO4ivDpvfP8PTPpuew7k5Ngar3Ua9KhwTq32zdEQg@mail.gmail.com>
Subject: Re: linux-next 20220125 - build failure in objtool with gcc 12
To:     =?UTF-8?Q?Valdis_Kl=C4=93tnieks?= <valdis.kletnieks@vt.edu>
Cc:     LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 26, 2022 at 4:57 PM Valdis Kl=C4=93tnieks
<valdis.kletnieks@vt.edu> wrote:
>
> Fedora Rawhide shipped gcc12, which apparently includes a new warning tha=
t
> causes a build failure.  Apparently, it's unable to figure out that 'ptr'=
 remains
> valid on failed realloc(), and we only call realloc() again on failures..=
.

https://gcc.gnu.org/bugzilla/show_bug.cgi?id=3D104069 explains (toward
the end) why gcc is leaving it to be fixed in the kernel.


>   CC      /usr/src/linux-next/tools/objtool/exec-cmd.o
>   CC      /usr/src/linux-next/tools/objtool/help.o
> In file included from help.c:12:
> In function 'xrealloc',
>     inlined from 'add_cmdname' at help.c:24:2:
> subcmd-util.h:56:23: error: pointer may be used after 'realloc' [-Werror=
=3Duse-after-free]
>    56 |                 ret =3D realloc(ptr, size);
>       |                       ^~~~~~~~~~~~~~~~~~
> subcmd-util.h:52:21: note: call to 'realloc' here
>    52 |         void *ret =3D realloc(ptr, size);
>       |                     ^~~~~~~~~~~~~~~~~~
> subcmd-util.h:58:31: error: pointer may be used after 'realloc' [-Werror=
=3Duse-after-free]
>    58 |                         ret =3D realloc(ptr, 1);
>       |                               ^~~~~~~~~~~~~~~
> subcmd-util.h:52:21: note: call to 'realloc' here
>    52 |         void *ret =3D realloc(ptr, size);
>       |                     ^~~~~~~~~~~~~~~~~~
> cc1: all warnings being treated as errors
> make[4]: *** [/usr/src/linux-next/tools/build/Makefile.build:97: /usr/src=
/linux-next/tools/objtool/help.o] Error 1
> make[3]: *** [Makefile:59: /usr/src/linux-next/tools/objtool/libsubcmd-in=
.o] Error 2
> make[2]: *** [Makefile:63: /usr/src/linux-next/tools/objtool/libsubcmd.a]=
 Error 2
> make[1]: *** [Makefile:69: objtool] Error 2
> make: *** [Makefile:1405: tools/objtool] Error 2
