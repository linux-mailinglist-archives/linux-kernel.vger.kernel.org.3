Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 970F653BB3E
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Jun 2022 16:53:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236262AbiFBOxW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Jun 2022 10:53:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232395AbiFBOxV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jun 2022 10:53:21 -0400
Received: from conssluserg-03.nifty.com (conssluserg-03.nifty.com [210.131.2.82])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD1EA220E23;
        Thu,  2 Jun 2022 07:53:19 -0700 (PDT)
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181]) (authenticated)
        by conssluserg-03.nifty.com with ESMTP id 252Er1J1006016;
        Thu, 2 Jun 2022 23:53:02 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-03.nifty.com 252Er1J1006016
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1654181582;
        bh=imtaVi9/hFdVPt5cAOLrPSRx54Ajp5nfpFyY97JYvcc=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=o0Kgqgc4sJ2IoFOODtVgeuvXPZLehLhrv1hxvOVVljPQyklOjNvfWBlSGetALtGr/
         F2ZAj2JwwULPQ+J2n8/ow6PPLm1KFM0UDLgnuVLI92vl097WnzDK3Kc+B7St2NPEap
         1BydcdzmXC61V0/p8saj6fq3K1WN1jelSEp0Yy6cOB29xFRKQEGjNr3JtsdlPJJJ39
         COsXMLJEPd7yfxzNMxG5V5DCEN0sQcvUGYmpUpzjjWUo06jqFiNZHhUqSJzgjRWJ/h
         +blJX2h60Bbn8FLYZDPcdWortLagWu7tNUYn0SQ9dWJC9A8LhVEtoITWxQ/tNzJgaG
         7YdCsWThZMeWg==
X-Nifty-SrcIP: [209.85.214.181]
Received: by mail-pl1-f181.google.com with SMTP id n18so4720733plg.5;
        Thu, 02 Jun 2022 07:53:02 -0700 (PDT)
X-Gm-Message-State: AOAM533yoeNzeDwUQ8yb1rSXsgbzBfgNRmh92oS7cryjHdcLr6gs/vjk
        mPetCfHW6UjV1IW0QGmj0X6t9HmoJtCclCAOXI8=
X-Google-Smtp-Source: ABdhPJymfz4Mqj1KAB6W8gd+LGmPDeULQYHKo8ZuLHnrwRleZfJxyAwnuRD5VP/wZNcjGxykd5rDD93Szri82E3Lfao=
X-Received: by 2002:a17:903:1205:b0:15e:8cbc:fd2b with SMTP id
 l5-20020a170903120500b0015e8cbcfd2bmr5326164plh.99.1654181581386; Thu, 02 Jun
 2022 07:53:01 -0700 (PDT)
MIME-Version: 1.0
References: <20220602015050.3185028-1-kbusch@fb.com>
In-Reply-To: <20220602015050.3185028-1-kbusch@fb.com>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Thu, 2 Jun 2022 23:52:24 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQot2kMxmisAE2XP3ukPSGBJkLWWYzrTcjV9exSVQKupQ@mail.gmail.com>
Message-ID: <CAK7LNAQot2kMxmisAE2XP3ukPSGBJkLWWYzrTcjV9exSVQKupQ@mail.gmail.com>
Subject: Re: [PATCH] kbuild: show the install image name and path
To:     Keith Busch <kbusch@fb.com>
Cc:     Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Keith Busch <kbusch@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_SOFTFAIL,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 2, 2022 at 10:51 AM Keith Busch <kbusch@fb.com> wrote:
>
> From: Keith Busch <kbusch@kernel.org>
>
> Prior to commit f774f5bb87d13 ("kbuild: factor out the common
> installation code into"), a 'make install' would print out the install
> command like:
>
>   sh ./arch/x86/boot/install.sh 5.18.0-11935-gbffe08031c89 \
>         arch/x86/boot/bzImage System.map "/boot"
>
> This output was very useful for my workflow, so this patch prints it out
> again. I'm not sure if there's a better way to do this than what's
> implemented here, so any feedback is appreciated.
>
> Cc: Masahiro Yamada <masahiroy@kernel.org>
> Signed-off-by: Keith Busch <kbusch@kernel.org>
> ---
>  scripts/install.sh | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/scripts/install.sh b/scripts/install.sh
> index 9bb0fb44f04a..2989d25ef069 100755
> --- a/scripts/install.sh
> +++ b/scripts/install.sh
> @@ -33,6 +33,7 @@ do
>         # installkernel(8) says the parameters are like follows:
>         #
>         #   installkernel version zImage System.map [directory]
> +       echo "$0 ${KERNELRELEASE} ${KBUILD_IMAGE} ${INSTALL_PATH}"
>         exec "${file}" "${KERNELRELEASE}" "${KBUILD_IMAGE}" System.map "${INSTALL_PATH}"
>  done
>
> --
> 2.30.2
>

You said "useful for *my* flow",
so you can do whatever you think is useful in
${HOME}/bin/${INSTALLKERNEL}, can't you?




$ cat ~/bin/installkernel
#!/bin/sh

echo '== useful info for my workflow =='
echo "$@"
echo '================================='

exec /sbin/${INSTALLKERNEL} "$@"




$ chmod +x ~/bin/installkernel

$ make install
  INSTALL /boot
== useful info for my workflow ==
5.17.0 arch/x86/boot/bzImage System.map /boot
=================================






-- 
Best Regards
Masahiro Yamada
