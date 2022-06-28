Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66CBE55CFD3
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:07:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242192AbiF1Azk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jun 2022 20:55:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236425AbiF1Azh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 20:55:37 -0400
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com [IPv6:2607:f8b0:4864:20::735])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF6741D0E5;
        Mon, 27 Jun 2022 17:55:35 -0700 (PDT)
Received: by mail-qk1-x735.google.com with SMTP id b133so8591578qkc.6;
        Mon, 27 Jun 2022 17:55:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to;
        bh=xuT7J5doI1Fzk1y+roRLQ1hNMG6KHDUXMZs++4UnW28=;
        b=Zj+tSmAt+cy52Gjo2psozKosRNwTMqqrTnMm7mOlC08u091ipAYciRlaHXzVmfLEJl
         huA2w53TDWBTsxlR4qJHatyDqGlgXYdiekH2ZBSlk+HwR3OgwMUZZ9pe9qHItuuVYBUV
         snnyq6rkH8uvGRpUb2zE4rSjNjCFCs/s1QBRPcw/BFG1aSHTOynBTnhlCgVJXfguoxAP
         srFI66nxBeWd9QySY/fwenVA7UgdEVJuRgXQzpf7SpMOczpq4ZZ6vv9ULGSy/Uq2m00l
         yJ9H1FnyhGIAWAjFyo6yQH57kVWJwNQpZ6AHhJFJ+IGHc+hNj73UlTvMODrITwbmMxvP
         Jh8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=xuT7J5doI1Fzk1y+roRLQ1hNMG6KHDUXMZs++4UnW28=;
        b=m1FOhktT+x1TuvmcnPdohf4i7spYIh8xPlBQ67v2VO0FMpCUQPcFdzrTHuyjgdJjyf
         PSp660q6qA1MkSinKYb1Utl0+ZjkfCwhk7TECqx0IHBjLEMkMjNfoAWkrzj8d+Q6+dHu
         JZtM+gnzIQWyJu7ET5WGXI9fVgLMhG8FvU9HdXF7ZU97fLLf401GlQppmftcUdW+bXuU
         3b5CGutvIKhScRzCKqys+NwDtwrVzkY9mgY5K2fnh7XBdKDqvAyEGmND5Hd233JSBwLi
         pZvBussrI8dORUd2NETKpTmf4GAZJATGk5P//zgnZ8cs13T1ZADKvuD0p3rWy9EQdBTS
         n7vw==
X-Gm-Message-State: AJIora8HSA0AQhQUkpAyc0awvCv4bxK1DtGTzyHJ7kOYEuGjeTwwIrs1
        SnfgJ7pXzddeRLE32RQjR7IEEC1cj1/sZq/sgeLXgR079dU=
X-Google-Smtp-Source: AGRyM1sHZjoMFQeVPG8Gv1jvoLu2cljadO/fHv3IbNF7R4rjjoDYQYrK894J5Q0sNKAmdxyER1OuFmJhWrrh7zlB1Xk=
X-Received: by 2002:a37:48b:0:b0:6af:2c49:1598 with SMTP id
 133-20020a37048b000000b006af2c491598mr4791654qke.121.1656377735033; Mon, 27
 Jun 2022 17:55:35 -0700 (PDT)
MIME-Version: 1.0
From:   Zhouyi Zhou <zhouzhouyi@gmail.com>
Date:   Tue, 28 Jun 2022 08:55:24 +0800
Message-ID: <CAABZP2wCsXG=qaZ68OwDDPA=uG-4Wb-e6WxMNuHNbJTZ1ruenA@mail.gmail.com>
Subject: Possible problem in check-local-export during the kernel build
 process (RCU torture)
To:     Masahiro Yamada <masahiroy@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        rcu <rcu@vger.kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        linux-kbuild@vger.kernel.org, linux-modules@vger.kernel.org,
        linux@roeck-us.net
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

Dear Masahiro:

1. The cause of the problem
When I am doing RCU torture test:

#git clone https://kernel.source.codeaurora.cn/pub/scm/linux/kernel/git/paulmck/linux-rcu.git
#cd linux-rcu
#git checkout remotes/origin/pmladek.2022.06.15a
#./tools/testing/selftests/rcutorture/bin/torture.sh

The kernel building report error something in both Dell PowerEdge R720
and Thinkpad T14 (Amd).

For example:
/mnt/rcu/linux-rcu/tools/testing/selftests/rcutorture/res/2022.06.27-10.42.37-torture#
find . -name Make.out|xargs grep Error
./results-rcutorture-kasan/RUDE01/Make.out:make[2]: ***
[scripts/Makefile.build:257: kernel/trace/power-traces.o] Error 255

2. I trace the problem to check-local-export
I add some echo statement in Makefile.build
diff --git a/scripts/Makefile.build b/scripts/Makefile.build
index 1f01ac65c0cd..0d48a2d3efff 100644
--- a/scripts/Makefile.build
+++ b/scripts/Makefile.build
@@ -227,13 +227,21 @@ cmd_check_local_export =
$(srctree)/scripts/check-local-export $@

 define rule_cc_o_c
        $(call cmd_and_fixdep,cc_o_c)
+       echo "after fixdep $$? $<"
        $(call cmd,gen_ksymdeps)
+       echo "after gen_ksymdeps $$? $<"
        $(call cmd,check_local_export)
+       echo "after check_local_export $$? $<"
        $(call cmd,checksrc)
+       echo "after checksrc $$? $<"
        $(call cmd,checkdoc)
+       echo "after checkdoc $$? $<"
        $(call cmd,gen_objtooldep)
+       echo "after gen_objtooldep $$? $<"
        $(call cmd,gen_symversions_c)
+       echo "after gen_symversions $$? $<"
        $(call cmd,record_mcount)
+       echo "after record_mcount $$? $<"
 endef

Then I rerun the torture.sh

The result show it is check_local_export did not continue in all failed builds.

3. I trace into wait statement in check-local-export
diff --git a/scripts/check-local-export b/scripts/check-local-export
index da745e2743b7..d35477d95bdc 100755
--- a/scripts/check-local-export
+++ b/scripts/check-local-export
@@ -12,7 +12,7 @@ declare -A symbol_types
 declare -a export_symbols

 exit_code=0
-
+echo "check-local-export L15 ${0} ${1}"
 while read value type name
 do
        # Skip the line if the number of fields is less than 3.
@@ -50,9 +50,10 @@ do
        #   done < <(${NM} --quiet ${1})
 done < <(${NM} ${1} 2>/dev/null || { echo "${0}: ${NM} failed" >&2; false; } )

+echo "check-local-export L53 ${0} ${1}"
 # Catch error in the process substitution
 wait $!
-
+echo "check-local-export L56 ${0} ${1} $! $?"
 for name in "${export_symbols[@]}"
 do
        # nm(3) says "If lowercase, the symbol is usually local"
@@ -61,5 +62,9 @@ do
                exit_code=1
        fi
 done
-
+if [ ${exit_code} -ne 0 ] ; then
+    echo "Zhouyi Zhou"
+    echo ${exit_code}
+fi
+echo "check-local-export L69 $? ${exit_code}"
 exit ${exit_code}

Then I rerun the torture.sh

The result show it is wait $! in all failed builds because in all failed cases,
there is L53, but no L56

4. I look into source code of wait command
#wget http://ftp.gnu.org/gnu/bash/bash-5.0.tar.gz
#tar zxf tar zxf bash-5.0.tar.gz
I found that there are QUIT statements in realization of function wait_for

5. My Guess
wait statement in check-local-export may cause bash to quit
I am very interested in this problem, but I am a rookie, I am very
glad to proceed the investigation with your further directions.

Sorry to have brought you so much trouble.


Kind Regard
Thank you very much
Zhouyi
