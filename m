Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18A354B1DA0
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 06:16:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234093AbiBKFPr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Feb 2022 00:15:47 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:51354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232414AbiBKFPq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Feb 2022 00:15:46 -0500
Received: from conssluserg-06.nifty.com (conssluserg-06.nifty.com [210.131.2.91])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1A9C273F;
        Thu, 10 Feb 2022 21:15:45 -0800 (PST)
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173]) (authenticated)
        by conssluserg-06.nifty.com with ESMTP id 21B5FVkP006898;
        Fri, 11 Feb 2022 14:15:31 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-06.nifty.com 21B5FVkP006898
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1644556531;
        bh=mitghgEfKuKyjdY9jDBe/7KTAvP/5B9u40VjiTNc/Ic=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=MQhpxTBbisxaDLOJ3+kcRFD9WOafjZdICFKBg+sj1Py8z2rwkkD2F/yu1HO9Rjpg1
         l3qVH0Coa6BQjuKoc4gH36ALS3eVj3/sAATHnR2aMfDy3SdVc9yO6zE5CCfPEhkEgx
         +7jgRzAiqZpS8OwFWv2bLc0EhEdrsdMQIeNVtFQhazug5F0+86RxzeuCCkLh/kdQKq
         NKufJDz7nppGNcIUZXesv8GroH9pvNXI7xdRgNYkhcizxJs0jgCXo2T7VhNpptpXOj
         z+7xq0f8QOlx0a5M9Tra0yhaRIxMF7WrjW8NtSoiVSYGMn1PIRUUHFwGoZvdAzq8Ky
         HEu9nkWEK6c3Q==
X-Nifty-SrcIP: [209.85.214.173]
Received: by mail-pl1-f173.google.com with SMTP id y7so3781619plp.2;
        Thu, 10 Feb 2022 21:15:31 -0800 (PST)
X-Gm-Message-State: AOAM531KPyIUOpwBNWRkeq+8jguIPrjaJ7t12ePMOY+wk+CyqUKoPUxR
        tBaXjbQ4q+cOguADfDUDt6axxUMBm3LHyMKHelg=
X-Google-Smtp-Source: ABdhPJybDVNbhieEkyArIsmUcSy4IlKVcgFTFCPdtPeoxkswPtXaJVnPilpknkJyuSSnSw8snTsV0vyTQtNTPmAFU3s=
X-Received: by 2002:a17:90b:4d82:: with SMTP id oj2mr62621pjb.77.1644556530580;
 Thu, 10 Feb 2022 21:15:30 -0800 (PST)
MIME-Version: 1.0
References: <20220210093342.2118196-1-masahiroy@kernel.org> <YgV9CHKpS/ptY3my@bergen.fjasle.eu>
In-Reply-To: <YgV9CHKpS/ptY3my@bergen.fjasle.eu>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Fri, 11 Feb 2022 14:14:53 +0900
X-Gmail-Original-Message-ID: <CAK7LNATAYb_s7_DVXPcNU7LBgTA5_-dC8P1NLUyvSTLcv+8vWg@mail.gmail.com>
Message-ID: <CAK7LNATAYb_s7_DVXPcNU7LBgTA5_-dC8P1NLUyvSTLcv+8vWg@mail.gmail.com>
Subject: Re: [PATCH] kbuild: replace $(if A,A,B) with $(or A,B)
To:     Nicolas Schier <nicolas@fjasle.eu>
Cc:     Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_SOFTFAIL,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 11, 2022 at 6:08 AM Nicolas Schier <nicolas@fjasle.eu> wrote:
>
> P=C3=A5 to. 10. feb. 2022 kl. 18.33 +0000 skrev Masahiro Yamada:
> > Date:   Thu, 10 Feb 2022 18:33:42 +0900
> > From: Masahiro Yamada <masahiroy@kernel.org>
> > To: linux-kbuild@vger.kernel.org
> > Cc: linux-kernel@vger.kernel.org, Masahiro Yamada <masahiroy@kernel.org=
>
> > Subject: [PATCH] kbuild: replace $(if A,A,B) with $(or A,B)
> > Message-Id: <20220210093342.2118196-1-masahiroy@kernel.org>
> > X-Mailer: git-send-email 2.32.0
> > X-Mailing-List: linux-kbuild@vger.kernel.org
> >
> > $(or ...) is available since GNU Make 3.81, and useful to shorten the
> > code in some places.
> >
> > Covert as follows:
> >
> >   $(if A,A,B)  -->  $(or A,B)
> >
> > Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> > ---
> >
> >  Makefile                                    | 8 ++++----
> >  scripts/Makefile.build                      | 3 +--
> >  scripts/Makefile.clean                      | 2 +-
> >  scripts/Makefile.lib                        | 4 ++--
> >  tools/bpf/bpftool/Makefile                  | 4 ++--
> >  tools/build/Makefile                        | 2 +-
> >  tools/counter/Makefile                      | 2 +-
> >  tools/gpio/Makefile                         | 2 +-
> >  tools/hv/Makefile                           | 2 +-
> >  tools/iio/Makefile                          | 2 +-
> >  tools/lib/api/Makefile                      | 2 +-
> >  tools/lib/bpf/Makefile                      | 2 +-
> >  tools/lib/perf/Makefile                     | 2 +-
> >  tools/lib/subcmd/Makefile                   | 2 +-
> >  tools/objtool/Makefile                      | 2 +-
> >  tools/pci/Makefile                          | 2 +-
> >  tools/perf/Makefile.perf                    | 4 ++--
> >  tools/power/x86/intel-speed-select/Makefile | 2 +-
> >  tools/scripts/utilities.mak                 | 2 +-
> >  tools/spi/Makefile                          | 6 +++---
> >  tools/tracing/rtla/Makefile                 | 2 +-
> >  tools/usb/Makefile                          | 2 +-
> >  22 files changed, 30 insertions(+), 31 deletions(-)
> >
> [...]
> > diff --git a/tools/lib/bpf/Makefile b/tools/lib/bpf/Makefile
> > index f947b61b2107..df1f6ff7bc49 100644
> > --- a/tools/lib/bpf/Makefile
> > +++ b/tools/lib/bpf/Makefile
> > @@ -60,7 +60,7 @@ ifndef VERBOSE
> >    VERBOSE =3D 0
> >  endif
> >
> > -INCLUDES =3D -I$(if $(OUTPUT),$(OUTPUT),.)                            =
 \
> > +INCLUDES =3D -I$(or $(OUTPUT),.)                               \
> >          -I$(srctree)/tools/include -I$(srctree)/tools/include/uapi
>
> I think I'd have shortened the whitespaces before the stray backslash.
>
> >
> >  export prefix libdir src obj
> > diff --git a/tools/lib/perf/Makefile b/tools/lib/perf/Makefile
> > index 08fe6e3c4089..2d985d6a3a96 100644
> > --- a/tools/lib/perf/Makefile
> > +++ b/tools/lib/perf/Makefile
> > @@ -153,7 +153,7 @@ $(TESTS_STATIC): $(TESTS_IN) $(LIBPERF_A) $(LIBAPI)
> >       $(QUIET_LINK)$(CC) -o $@ $^
> >
> >  $(TESTS_SHARED): $(TESTS_IN) $(LIBAPI)
> > -     $(QUIET_LINK)$(CC) -o $@ -L$(if $(OUTPUT),$(OUTPUT),.) $^ -lperf
> > +     $(QUIET_LINK)$(CC) -o $@ -L$(if $(OUTPUT),.) $^ -lperf
>
> $(if ...)  -> $(or ...)


Oops, thanks. I fixed it and sent v2.





> With this one fixed:
> Reviewed-by: Nicolas Schier <nicolas@fjasle.eu>
>
> Thanks for that patch.  I have never seen $(or) in use before but it
> definitively makes sense!
>
> Kind regards,
> Nicolas
>
>
> --
> epost|xmpp: nicolas@fjasle.eu          irc://oftc.net/nsc
> =E2=86=B3 gpg: 18ed 52db e34f 860e e9fb  c82b 7d97 0932 55a0 ce7f
>      -- frykten for herren er opphav til kunnskap --



--=20
Best Regards
Masahiro Yamada
