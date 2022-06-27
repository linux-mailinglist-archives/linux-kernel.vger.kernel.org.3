Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E87655C917
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 14:56:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239515AbiF0Rqf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jun 2022 13:46:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236600AbiF0Rqc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 13:46:32 -0400
Received: from conssluserg-01.nifty.com (conssluserg-01.nifty.com [210.131.2.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E49712AC6;
        Mon, 27 Jun 2022 10:46:31 -0700 (PDT)
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44]) (authenticated)
        by conssluserg-01.nifty.com with ESMTP id 25RHkBIm029206;
        Tue, 28 Jun 2022 02:46:12 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-01.nifty.com 25RHkBIm029206
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1656351972;
        bh=eF/z4J3hvK46CYjkz0vW2qP3SSL8GNPi/m4MKa3lTA4=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Cv6IvFBdMcUwAQjan0sYNsjrIyv7qi2kPgTqLmnAadqXJ5S76mJr+/deINoItIkcy
         5ktlzDsGy8cmP6zMrf0omRH85sQvnbpx15riV0ABksOUo2VKdYublx+ZKYxfMLdr7O
         aL/gbv6bQcT4iB/z5nG2hAk7KdP7AwLKEL0tgEriyZkBaevEmYvDgPq554yXOnG7+x
         e5liEIswtuAPaZTj+MVd3pm5r15A4HqADODSB62cVk0aNYCLZ+G+Qp+Exfzi2Tl9zC
         hQqn5t0P7O8fCB/uruXIPNwdMmN1FYCoR28ycT881hLDqEyUu4YlcJHr/p/N/Hwskg
         OsPjS0kUZ8Ynw==
X-Nifty-SrcIP: [209.85.221.44]
Received: by mail-wr1-f44.google.com with SMTP id n1so14087225wrg.12;
        Mon, 27 Jun 2022 10:46:12 -0700 (PDT)
X-Gm-Message-State: AJIora+OHyQGo8IENuw5+4NsX2w+r4xMMpDLS6VX6K/cv4wH4ySziEXU
        ebJoF+dvKTdF2s6XZtme92vXkCGJvhPTk4Das0k=
X-Google-Smtp-Source: AGRyM1vOTihmrMGMQABUqpV4BfSLQb31+T6YJmO0Sla5hVJuoRGBowvH+3KWuuyg6Aj2mLDtIe82jcUBH+O98laxfmI=
X-Received: by 2002:adf:f5ce:0:b0:21b:832c:80dd with SMTP id
 k14-20020adff5ce000000b0021b832c80ddmr13360923wrp.235.1656351970800; Mon, 27
 Jun 2022 10:46:10 -0700 (PDT)
MIME-Version: 1.0
References: <20220627070214.432390-1-usama.anjum@collabora.com> <15532d64-6744-c8a5-184b-18358211d345@linuxfoundation.org>
In-Reply-To: <15532d64-6744-c8a5-184b-18358211d345@linuxfoundation.org>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Tue, 28 Jun 2022 02:45:27 +0900
X-Gmail-Original-Message-ID: <CAK7LNARxSFSQgmrZe2CXj+V153kymBVyGkXwOPWLNoybQ8+bfg@mail.gmail.com>
Message-ID: <CAK7LNARxSFSQgmrZe2CXj+V153kymBVyGkXwOPWLNoybQ8+bfg@mail.gmail.com>
Subject: Re: [PATCH v1] kbuild: fix sub directory output build of kselftests
To:     Shuah Khan <skhan@linuxfoundation.org>
Cc:     Muhammad Usama Anjum <usama.anjum@collabora.com>,
        Michal Marek <michal.lkml@markovi.net>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Kieran Bingham <kbingham@kernel.org>, kernel@collabora.com,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_SOFTFAIL,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 28, 2022 at 1:54 AM Shuah Khan <skhan@linuxfoundation.org> wrote:
>
> On 6/27/22 1:02 AM, Muhammad Usama Anjum wrote:
> > Build of kselftests fail if kernel's top most Makefile is used for
> > running or building kselftests with separate output directory which is
> > sub-directory. srctree is set to .. erroneously.
> >
> > make kselftest-all O=/linux_mainline/build
> > Makefile:1080: ../scripts/Makefile.extrawarn: No such file or directory
> >
> > make kselftest-all O=build
> > Makefile:1080: ../scripts/Makefile.extrawarn: No such file or directory
> >
> > Fix this by comparing abs_srctree with CURDIR instead of abs_objtree.
> > CURDIR changes based on from where the command has been run and it sets
> > the srctree correctly.
> >
> > Fixes: 25b146c5b8cee("kbuild: allow Kbuild to start from any directory")
> > Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
> > ---
> > Changes in V2:
> > - Correct the bugfix instead of workaround
> >
> > V1: https://lore.kernel.org/lkml/20220223191016.1658728-1-usama.anjum@collabora.com/
> > ---
> >   Makefile | 4 ++--
> >   1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/Makefile b/Makefile
> > index e66358b64ede..4090d7afcda4 100644
> > --- a/Makefile
> > +++ b/Makefile
> > @@ -238,12 +238,12 @@ ifeq ($(need-sub-make),)
> >   # so that IDEs/editors are able to understand relative filenames.
> >   MAKEFLAGS += --no-print-directory
> >
> > -ifeq ($(abs_srctree),$(abs_objtree))
> > +ifeq ($(abs_srctree),$(CURDIR))
> >           # building in the source tree
> >           srctree := .
> >       building_out_of_srctree :=
> >   else
> > -        ifeq ($(abs_srctree)/,$(dir $(abs_objtree)))
> > +        ifeq ($(abs_srctree)/,$(dir $(CURDIR)))
> >                   # building in a subdirectory of the source tree
> >                   srctree := ..
> >           else
> >
>
> Please resend cc'ing linux-kselftest
>
> thanks,
> -- Shuah


Please do not send this any more.
This part is good as is.





-- 
Best Regards
Masahiro Yamada
