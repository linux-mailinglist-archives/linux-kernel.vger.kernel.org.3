Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4635F5A8EE4
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 08:57:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233239AbiIAG5H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 02:57:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232971AbiIAG5E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 02:57:04 -0400
Received: from conssluserg-06.nifty.com (conssluserg-06.nifty.com [210.131.2.91])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D949121406;
        Wed, 31 Aug 2022 23:57:01 -0700 (PDT)
Received: from mail-oa1-f49.google.com (mail-oa1-f49.google.com [209.85.160.49]) (authenticated)
        by conssluserg-06.nifty.com with ESMTP id 2816uTPA029122;
        Thu, 1 Sep 2022 15:56:29 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-06.nifty.com 2816uTPA029122
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1662015389;
        bh=dEBifxWsZbGTjkX4Q4TXMbY4QRDyWToKG+5NkGoIiwI=;
        h=From:Date:Subject:To:Cc:From;
        b=i44gVMINQTP60BtDWVA4il1nf4VUxhoJUmJg33mQczyLfnK+mrMBpUgt5CNqOZkrT
         bHkcUadN79jiJyt6zJZDEikdLLHqdvBUdYO40zyuTWDfwn01G/z62WEb4Pk9P3exxS
         ouk2redb9+SUEK/p6cQXyw6hIv1y3a34RCXLWPQEQMVrXWeCn0wxiOvASugSeYFq5+
         31z6aYSu85Ip9vnj01Fl/2svewpwIuKBayCeHDPsvecxmEOTbIr15bxqgVZeqPakNQ
         jj7F4OYf2YQTTN3cY7M+8DfQbijjBOvw9aSLhJZSFF8WNYvSKrvzrR6uktzNWLoRyk
         zv+SslJim3F1Q==
X-Nifty-SrcIP: [209.85.160.49]
Received: by mail-oa1-f49.google.com with SMTP id 586e51a60fabf-11ee4649dfcso23083702fac.1;
        Wed, 31 Aug 2022 23:56:29 -0700 (PDT)
X-Gm-Message-State: ACgBeo1i27iqJnpI9NivBuZqSIWiy+KZFz82cc5rqSpVf24dIw3RCvW/
        cVVkSxOp4xDAY471dOpS887u/NQu2IvLw+dqn34=
X-Google-Smtp-Source: AA6agR7DUBm/R7AQ7AzML8dCnDkweWnAfSbC2YBIG6meuI1GlY4tPxfpzZRrEvfXPjdzp8rbo1DjPj42gj4BCbCRx5Y=
X-Received: by 2002:a05:6808:1189:b0:33a:34b3:6788 with SMTP id
 j9-20020a056808118900b0033a34b36788mr2701440oil.194.1662015388666; Wed, 31
 Aug 2022 23:56:28 -0700 (PDT)
MIME-Version: 1.0
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Thu, 1 Sep 2022 15:55:52 +0900
X-Gmail-Original-Message-ID: <CAK7LNATbAVE8QY_QZQkiaNy9UZb2tH30eP50n0TNpgsHVrTKJQ@mail.gmail.com>
Message-ID: <CAK7LNATbAVE8QY_QZQkiaNy9UZb2tH30eP50n0TNpgsHVrTKJQ@mail.gmail.com>
Subject: Fix make.cross for 0day bot
To:     lkp@lists.01.org, 0day robot <lkp@intel.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_SOFTFAIL,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,  maintainers of Intel 0day bot,

make.cross is supposed to use the latest GCC by default
(according to the comment "use highest available version")
but actually chooses GCC 9.3.0 rather than gcc-12.1.0.

If both gcc-9.3.0-nolibc and gcc-12.1.0-nolibc exist
in COMPILER_INSTALL_PATH, make.cross chooses gcc-9.3.0.

Likewise, make.cross installs gcc-9.3.0 when no suitable compiler is found.


This is due the fact that compiler is sorted like follows:

gcc-10.2.0-nolibc
gcc-10.3.0-nolibc
gcc-11.1.0-nolibc
gcc-11.2.0-nolibc
gcc-11.3.0-nolibc
gcc-12.1.0-nolibc
gcc-4.9.4-nolibc
gcc-5.5.0-nolibc
gcc-6.4.0-nolibc
gcc-6.5.0-nolibc
gcc-7.5.0-nolibc
gcc-8.1.0-nolibc
gcc-9.2.0-nolibc
gcc-9.3.0-nolibc


Then, gcc-9.3.0-nolibc is picked up since it is listed at the last.



'sort -V' can do natural sort for versions:

gcc-4.9.4-nolibc
gcc-5.5.0-nolibc
gcc-6.4.0-nolibc
gcc-6.5.0-nolibc
gcc-7.5.0-nolibc
gcc-8.1.0-nolibc
gcc-9.2.0-nolibc
gcc-9.3.0-nolibc
gcc-10.2.0-nolibc
gcc-10.3.0-nolibc
gcc-11.1.0-nolibc
gcc-11.2.0-nolibc
gcc-11.3.0-nolibc
gcc-12.1.0-nolibc




One example code change is like follows:



--- make.cross.old      2022-09-01 12:18:20.933154233 +0900
+++ make.cross  2022-09-01 15:06:48.995945712 +0900
@@ -143,7 +143,7 @@
        local URL='https://download.01.org/0day-ci/cross-package'
        local list=/tmp/0day-ci-crosstool-files

-       lftp -c "open $URL && find -d 3 > $list" || return
+       lftp -c "open $URL && find -d 3" | sort -V > $list || return

        local file
        local gcc_arch_pattern=$(echo "${gcc_arch}" | sed 's/*/.*/g')
@@ -206,7 +206,7 @@
        }

        # use highest available version
-       gcc_exec=${gcc_exec[-1]}
+       gcc_evec=$(tr ' ' '\n' <<< ${gcc_exec[@]} | sort -V | tail -n1)
 }

 update_path_env_for_parisc()
@@ -340,7 +340,7 @@

                # load build-in depends libs
                local
deplibs_path=($COMPILER_INSTALL_PATH/${COMPILER}*/${gcc_arch}/libexec/gcc/${gcc_arch}/*)
-               deplibs_path=${deplibs_path[-1]}
+               deplibs_path=$(tr ' ' '\n' <<< ${deplibs_path[@]} |
sort -V | tail -n1)
                [[ -d $deplibs_path ]] && export
LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$deplibs_path

                install_dependence "$gcc_exec" || return



-- 
Best Regards
Masahiro Yamada
