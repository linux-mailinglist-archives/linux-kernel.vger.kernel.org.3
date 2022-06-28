Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1B1355F1EB
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jun 2022 01:40:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229944AbiF1Xfo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jun 2022 19:35:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229471AbiF1Xfm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 19:35:42 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0C0E39179;
        Tue, 28 Jun 2022 16:35:40 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id e2so19769684edv.3;
        Tue, 28 Jun 2022 16:35:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kl62yh9fcFGqVyYLNjMbcUjr7j+88ktEAbLSuJ6L1KY=;
        b=M6u8xP/isYO4zwe1vwxJwWsp4YrBRQw2N343gV4jBw2i/29+NTYiAMrPcgFlC+b5uV
         TOYjMeUjdf3jen1z9w7Ivo9JGpHRKUa4zP92JDjV3JLQZOGmXmLTqeeqk6DspIXeW38P
         Qzf0ZFmhnmXObPKJd9AoBQCs/hwBPeeM4uxRyLQXcpEK/2DZ91pVTxDOllTwv4QG6Xn/
         wb1xtfzJwLrwJfPP1Fdf/02hjRokHf2olFFpBd+Z4sfh1/4F/SvRfYanxkpu8E/Z8RMm
         xaXKZT5i7eAnMB0AacjCr63cU8bNTuKBegH4MtldDwTa9/1lZT8SiUXRKaEbM/GGzJPN
         dSBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kl62yh9fcFGqVyYLNjMbcUjr7j+88ktEAbLSuJ6L1KY=;
        b=2Ty03sKf0Az3VqWZZh1Oml6q4fPlNg61iFus1PfUkhOq5+pDlhpj5Qc07ABPvfkFGm
         13YjCeHimrIevY+7OmadvW1bec3dihwLOiz+DdYxqyxETRxD0DmpsTfe1OTxArVDWES+
         JwzeV/xGA0EJAbfTXPX8IeoNXohsfU0oCWAHjedhAdu0ys6n5nVIaGvzBBuXG7TocVFY
         sgR9cSDJJA62zSimAD2XEeAkbzcou5fIp1JCm9XZdzkkzxl60zrwhb488KRZDqDKwrfN
         /sy85Yx3YRtayCce/42vVC4NyNYdE/WnerQDCU863wzYhhNVuBcbp/jij8F+qb3vfAC6
         3iaQ==
X-Gm-Message-State: AJIora9HxE0ZvEG72YBH3dc0usL6YZLxx8Av898O0SvcVVXyj+l7KrXb
        0VJjjKV2Jbrp13JT2L0jtHNHynDbFi+YBzyBMDE=
X-Google-Smtp-Source: AGRyM1t5umLiHjcwLID87ouxNCjRvmkitFjy0Lz5f0X/cd77dmmK/oDjS+pai03X+fSYzgFMpV5cmMDAtNqQnwyE6i0=
X-Received: by 2002:a05:6402:42c6:b0:435:dc4b:1bb2 with SMTP id
 i6-20020a05640242c600b00435dc4b1bb2mr602470edc.355.1656459339402; Tue, 28 Jun
 2022 16:35:39 -0700 (PDT)
MIME-Version: 1.0
References: <CAABZP2wCsXG=qaZ68OwDDPA=uG-4Wb-e6WxMNuHNbJTZ1ruenA@mail.gmail.com>
 <CAK7LNATNo74bcp6F08iiYjbMrnNeQWsOSys5vYfG88jjpU-kZQ@mail.gmail.com>
In-Reply-To: <CAK7LNATNo74bcp6F08iiYjbMrnNeQWsOSys5vYfG88jjpU-kZQ@mail.gmail.com>
From:   Zhouyi Zhou <zhouzhouyi@gmail.com>
Date:   Wed, 29 Jun 2022 07:35:27 +0800
Message-ID: <CAABZP2y0ScFKftLJsyi9qP16ezpSMy1UxoDmWp1mDktCxJkh1A@mail.gmail.com>
Subject: Re: Possible problem in check-local-export during the kernel build
 process (RCU torture)
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        rcu <rcu@vger.kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        linux-modules <linux-modules@vger.kernel.org>,
        Guenter Roeck <linux@roeck-us.net>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 28, 2022 at 3:25 PM Masahiro Yamada <masahiroy@kernel.org> wrote:
>
> On Tue, Jun 28, 2022 at 9:55 AM Zhouyi Zhou <zhouzhouyi@gmail.com> wrote:
> >
> > Dear Masahiro:
> >
> > 1. The cause of the problem
> > When I am doing RCU torture test:
> >
> > #git clone https://kernel.source.codeaurora.cn/pub/scm/linux/kernel/git/paulmck/linux-rcu.git
> > #cd linux-rcu
> > #git checkout remotes/origin/pmladek.2022.06.15a
> > #./tools/testing/selftests/rcutorture/bin/torture.sh
> >
> > The kernel building report error something in both Dell PowerEdge R720
> > and Thinkpad T14 (Amd).
> >
> > For example:
> > /mnt/rcu/linux-rcu/tools/testing/selftests/rcutorture/res/2022.06.27-10.42.37-torture#
> > find . -name Make.out|xargs grep Error
> > ./results-rcutorture-kasan/RUDE01/Make.out:make[2]: ***
> > [scripts/Makefile.build:257: kernel/trace/power-traces.o] Error 255
>
>
> check-local-export stopped using the process substitution.
> Seet this commit:
>
>
> commit da4288b95baa1c7c9aa8a476f58b37eb238745b0
> Author: Masahiro Yamada <masahiroy@kernel.org>
> Date:   Wed Jun 8 10:11:00 2022 +0900
>
>     scripts/check-local-export: avoid 'wait $!' for process substitution
>
>
>
>
> You are debugging the stale Kbuild code.
Thank Masahiro for your help
I patched da4288b95baa1c7c9aa8a476f58b37eb238745b0 to
pmladek.2022.06.15a branch of linux-rcu, after 13 hours' RCU torture
test,
all the testcases are built successfully!

Tested-by: Zhouyi Zhou <zhouzhouyi@gmail.com>
>
> If your main interest is RCU torture,
> please narrow it down to a standalone script,
> not the entire Kbuild.
OK and Thank you and Paul both for your guidance and encouragement ;-)
>
>
>
>
>
>
>
>
>
> >
> > 2. I trace the problem to check-local-export
> > I add some echo statement in Makefile.build
> > diff --git a/scripts/Makefile.build b/scripts/Makefile.build
> > index 1f01ac65c0cd..0d48a2d3efff 100644
> > --- a/scripts/Makefile.build
> > +++ b/scripts/Makefile.build
> > @@ -227,13 +227,21 @@ cmd_check_local_export =
> > $(srctree)/scripts/check-local-export $@
> >
> >  define rule_cc_o_c
> >         $(call cmd_and_fixdep,cc_o_c)
> > +       echo "after fixdep $$? $<"
> >         $(call cmd,gen_ksymdeps)
> > +       echo "after gen_ksymdeps $$? $<"
> >         $(call cmd,check_local_export)
> > +       echo "after check_local_export $$? $<"
> >         $(call cmd,checksrc)
> > +       echo "after checksrc $$? $<"
> >         $(call cmd,checkdoc)
> > +       echo "after checkdoc $$? $<"
> >         $(call cmd,gen_objtooldep)
> > +       echo "after gen_objtooldep $$? $<"
> >         $(call cmd,gen_symversions_c)
> > +       echo "after gen_symversions $$? $<"
> >         $(call cmd,record_mcount)
> > +       echo "after record_mcount $$? $<"
> >  endef
> >
> > Then I rerun the torture.sh
> >
> > The result show it is check_local_export did not continue in all failed builds.
> >
> > 3. I trace into wait statement in check-local-export
> > diff --git a/scripts/check-local-export b/scripts/check-local-export
> > index da745e2743b7..d35477d95bdc 100755
> > --- a/scripts/check-local-export
> > +++ b/scripts/check-local-export
> > @@ -12,7 +12,7 @@ declare -A symbol_types
> >  declare -a export_symbols
> >
> >  exit_code=0
> > -
> > +echo "check-local-export L15 ${0} ${1}"
> >  while read value type name
> >  do
> >         # Skip the line if the number of fields is less than 3.
> > @@ -50,9 +50,10 @@ do
> >         #   done < <(${NM} --quiet ${1})
> >  done < <(${NM} ${1} 2>/dev/null || { echo "${0}: ${NM} failed" >&2; false; } )
> >
> > +echo "check-local-export L53 ${0} ${1}"
> >  # Catch error in the process substitution
> >  wait $!
> > -
> > +echo "check-local-export L56 ${0} ${1} $! $?"
> >  for name in "${export_symbols[@]}"
> >  do
> >         # nm(3) says "If lowercase, the symbol is usually local"
> > @@ -61,5 +62,9 @@ do
> >                 exit_code=1
> >         fi
> >  done
> > -
> > +if [ ${exit_code} -ne 0 ] ; then
> > +    echo "Zhouyi Zhou"
> > +    echo ${exit_code}
> > +fi
> > +echo "check-local-export L69 $? ${exit_code}"
> >  exit ${exit_code}
> >
> > Then I rerun the torture.sh
> >
> > The result show it is wait $! in all failed builds because in all failed cases,
> > there is L53, but no L56
> >
> > 4. I look into source code of wait command
> > #wget http://ftp.gnu.org/gnu/bash/bash-5.0.tar.gz
> > #tar zxf tar zxf bash-5.0.tar.gz
> > I found that there are QUIT statements in realization of function wait_for
> >
> > 5. My Guess
> > wait statement in check-local-export may cause bash to quit
> > I am very interested in this problem, but I am a rookie, I am very
> > glad to proceed the investigation with your further directions.
> >
> > Sorry to have brought you so much trouble.
> >
> >
> > Kind Regard
> > Thank you very much
> > Zhouyi
>
>
>
> --
> Best Regards
> Masahiro Yamada
Best Regards
Zhouyi
