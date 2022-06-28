Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2415A55CE3C
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:04:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242697AbiF1HZr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jun 2022 03:25:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242568AbiF1HZi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 03:25:38 -0400
Received: from conssluserg-04.nifty.com (conssluserg-04.nifty.com [210.131.2.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C684F2CE2F;
        Tue, 28 Jun 2022 00:25:35 -0700 (PDT)
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53]) (authenticated)
        by conssluserg-04.nifty.com with ESMTP id 25S7PDr0009602;
        Tue, 28 Jun 2022 16:25:14 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-04.nifty.com 25S7PDr0009602
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1656401115;
        bh=eLjAiVxuGvO6AzWFnOFJI+C+QcXzQ40aD2WDoOMylOo=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=fVTQn4EnvDBVZS0FLVGRzFY+R2/L/OWZz6Fe/S9B6zhRK8n6MQmJoBsIV9TwpONeB
         HvDz+HuxaeDU1+IUDE5INxS90LD5NJt6icxiFhpvIRhRANtlIWORuXbp/pE/LTMfZU
         5AGBCuJrZYxPoFl9Xhwl57lj/SAlTOwQgbszYOdjjIlOcWMwrtoHNubeCOmYLjuCAc
         qmP536XTz+5bomt598YJqcDNmQFiYzcR/+/mW4DE8b+HcvaoS8IKjhtOlFAD6gfI9K
         qXUgnzDhhAi7SFvfe2FD/2vdVVrOtgKkECrP9vnov+Yt5CFoz8vN0LTAQv3pxLSgJ7
         7+9sCRPilbpFg==
X-Nifty-SrcIP: [209.85.221.53]
Received: by mail-wr1-f53.google.com with SMTP id s1so16266703wra.9;
        Tue, 28 Jun 2022 00:25:14 -0700 (PDT)
X-Gm-Message-State: AJIora+PCCmiwMBfCMQnsCtQpZk1lawz2MrJ5TOjsVQCS00zLhKPF8EN
        t4LAnOm1J5z/K3kBywvmqKaJURn0IEQjwG9/A+Y=
X-Google-Smtp-Source: AGRyM1uZt0JBBIngefTOq5ciOXsKG9KrTWDDKK7vu9jmcRu4wRqqpeYUcz2ffXtsi6U5Y2sLFFuZqSTom9sFhummQ8w=
X-Received: by 2002:adf:d1ea:0:b0:21b:a6cb:fcf6 with SMTP id
 g10-20020adfd1ea000000b0021ba6cbfcf6mr15985029wrd.477.1656401112927; Tue, 28
 Jun 2022 00:25:12 -0700 (PDT)
MIME-Version: 1.0
References: <CAABZP2wCsXG=qaZ68OwDDPA=uG-4Wb-e6WxMNuHNbJTZ1ruenA@mail.gmail.com>
In-Reply-To: <CAABZP2wCsXG=qaZ68OwDDPA=uG-4Wb-e6WxMNuHNbJTZ1ruenA@mail.gmail.com>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Tue, 28 Jun 2022 16:24:28 +0900
X-Gmail-Original-Message-ID: <CAK7LNATNo74bcp6F08iiYjbMrnNeQWsOSys5vYfG88jjpU-kZQ@mail.gmail.com>
Message-ID: <CAK7LNATNo74bcp6F08iiYjbMrnNeQWsOSys5vYfG88jjpU-kZQ@mail.gmail.com>
Subject: Re: Possible problem in check-local-export during the kernel build
 process (RCU torture)
To:     Zhouyi Zhou <zhouzhouyi@gmail.com>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        rcu <rcu@vger.kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        linux-modules <linux-modules@vger.kernel.org>,
        Guenter Roeck <linux@roeck-us.net>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_SOFTFAIL,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 28, 2022 at 9:55 AM Zhouyi Zhou <zhouzhouyi@gmail.com> wrote:
>
> Dear Masahiro:
>
> 1. The cause of the problem
> When I am doing RCU torture test:
>
> #git clone https://kernel.source.codeaurora.cn/pub/scm/linux/kernel/git/paulmck/linux-rcu.git
> #cd linux-rcu
> #git checkout remotes/origin/pmladek.2022.06.15a
> #./tools/testing/selftests/rcutorture/bin/torture.sh
>
> The kernel building report error something in both Dell PowerEdge R720
> and Thinkpad T14 (Amd).
>
> For example:
> /mnt/rcu/linux-rcu/tools/testing/selftests/rcutorture/res/2022.06.27-10.42.37-torture#
> find . -name Make.out|xargs grep Error
> ./results-rcutorture-kasan/RUDE01/Make.out:make[2]: ***
> [scripts/Makefile.build:257: kernel/trace/power-traces.o] Error 255


check-local-export stopped using the process substitution.
Seet this commit:


commit da4288b95baa1c7c9aa8a476f58b37eb238745b0
Author: Masahiro Yamada <masahiroy@kernel.org>
Date:   Wed Jun 8 10:11:00 2022 +0900

    scripts/check-local-export: avoid 'wait $!' for process substitution




You are debugging the stale Kbuild code.

If your main interest is RCU torture,
please narrow it down to a standalone script,
not the entire Kbuild.









>
> 2. I trace the problem to check-local-export
> I add some echo statement in Makefile.build
> diff --git a/scripts/Makefile.build b/scripts/Makefile.build
> index 1f01ac65c0cd..0d48a2d3efff 100644
> --- a/scripts/Makefile.build
> +++ b/scripts/Makefile.build
> @@ -227,13 +227,21 @@ cmd_check_local_export =
> $(srctree)/scripts/check-local-export $@
>
>  define rule_cc_o_c
>         $(call cmd_and_fixdep,cc_o_c)
> +       echo "after fixdep $$? $<"
>         $(call cmd,gen_ksymdeps)
> +       echo "after gen_ksymdeps $$? $<"
>         $(call cmd,check_local_export)
> +       echo "after check_local_export $$? $<"
>         $(call cmd,checksrc)
> +       echo "after checksrc $$? $<"
>         $(call cmd,checkdoc)
> +       echo "after checkdoc $$? $<"
>         $(call cmd,gen_objtooldep)
> +       echo "after gen_objtooldep $$? $<"
>         $(call cmd,gen_symversions_c)
> +       echo "after gen_symversions $$? $<"
>         $(call cmd,record_mcount)
> +       echo "after record_mcount $$? $<"
>  endef
>
> Then I rerun the torture.sh
>
> The result show it is check_local_export did not continue in all failed builds.
>
> 3. I trace into wait statement in check-local-export
> diff --git a/scripts/check-local-export b/scripts/check-local-export
> index da745e2743b7..d35477d95bdc 100755
> --- a/scripts/check-local-export
> +++ b/scripts/check-local-export
> @@ -12,7 +12,7 @@ declare -A symbol_types
>  declare -a export_symbols
>
>  exit_code=0
> -
> +echo "check-local-export L15 ${0} ${1}"
>  while read value type name
>  do
>         # Skip the line if the number of fields is less than 3.
> @@ -50,9 +50,10 @@ do
>         #   done < <(${NM} --quiet ${1})
>  done < <(${NM} ${1} 2>/dev/null || { echo "${0}: ${NM} failed" >&2; false; } )
>
> +echo "check-local-export L53 ${0} ${1}"
>  # Catch error in the process substitution
>  wait $!
> -
> +echo "check-local-export L56 ${0} ${1} $! $?"
>  for name in "${export_symbols[@]}"
>  do
>         # nm(3) says "If lowercase, the symbol is usually local"
> @@ -61,5 +62,9 @@ do
>                 exit_code=1
>         fi
>  done
> -
> +if [ ${exit_code} -ne 0 ] ; then
> +    echo "Zhouyi Zhou"
> +    echo ${exit_code}
> +fi
> +echo "check-local-export L69 $? ${exit_code}"
>  exit ${exit_code}
>
> Then I rerun the torture.sh
>
> The result show it is wait $! in all failed builds because in all failed cases,
> there is L53, but no L56
>
> 4. I look into source code of wait command
> #wget http://ftp.gnu.org/gnu/bash/bash-5.0.tar.gz
> #tar zxf tar zxf bash-5.0.tar.gz
> I found that there are QUIT statements in realization of function wait_for
>
> 5. My Guess
> wait statement in check-local-export may cause bash to quit
> I am very interested in this problem, but I am a rookie, I am very
> glad to proceed the investigation with your further directions.
>
> Sorry to have brought you so much trouble.
>
>
> Kind Regard
> Thank you very much
> Zhouyi



-- 
Best Regards
Masahiro Yamada
