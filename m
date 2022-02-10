Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D6B54B1775
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Feb 2022 22:13:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344542AbiBJVNu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Feb 2022 16:13:50 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:41206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236222AbiBJVNt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Feb 2022 16:13:49 -0500
X-Greylist: delayed 307 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 10 Feb 2022 13:13:41 PST
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77C7AF47;
        Thu, 10 Feb 2022 13:13:41 -0800 (PST)
Received: from leknes.fjasle.eu ([46.142.99.154]) by mrelayeu.kundenserver.de
 (mreue009 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1Mnac9-1nyzQT0gvl-00jYQB; Thu, 10 Feb 2022 22:08:24 +0100
Received: from localhost.fjasle.eu (unknown [IPv6:fd00::6f0:21ff:fe91:394])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by leknes.fjasle.eu (Postfix) with ESMTPS id 8705A3C050;
        Thu, 10 Feb 2022 22:08:19 +0100 (CET)
Authentication-Results: leknes.fjasle.eu; dkim=none; dkim-atps=neutral
Received: by localhost.fjasle.eu (Postfix, from userid 1000)
        id 25BC318B0; Thu, 10 Feb 2022 22:00:56 +0100 (CET)
Date:   Thu, 10 Feb 2022 22:00:56 +0100
From:   Nicolas Schier <nicolas@fjasle.eu>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kbuild: replace $(if A,A,B) with $(or A,B)
Message-ID: <YgV9CHKpS/ptY3my@bergen.fjasle.eu>
References: <20220210093342.2118196-1-masahiroy@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220210093342.2118196-1-masahiroy@kernel.org>
Jabber-ID: nicolas@jabber.no
X-Operating-System: Debian GNU/Linux bookworm/sid
X-Provags-ID: V03:K1:apwdst/S/4MvpD5SeWBwUhd/SEKva7BSqmtXbCEgsgotW4V5moE
 KqINi4CGet4lvPWXMlYDaNrgn7V2RTMdF4hBZuZK+OyLzH0RUURko9mYfH4uwgz4Kvw17oi
 RgxVS/4jQqHYDUw2ir9SeZipIYxutwdx7tk6fJa5aa96IvmirbbmtHiJclS8CfgIOoEziwH
 /YvBZXpDJddXhMk8T1zTg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:BjgAJG7ufrk=:SKnf7B6DC4QEBqtc8z0vov
 rLMtIJ5Mz0KJm86bSwOrHXAbcjKtUQISLXoGCntfXzlCLvRk9rMgCHv/mDcigFYHHLBjRdyXg
 LhwGl+jasbDhdhQvwSm1BHJQTe/KAm+Xi1CSIFE8+Y2NbkDgql5d8JI6Nhc34mazDWGXZO3X8
 0tIZNUHW1Xv93qc2A1EZyncCyh5FW+jgQ6Fj/dOH/nTCqEc5vj1pRGa2ZFa4iXRklzaIwnWML
 QwHZuRj1szcJ/mrJSUEvswhG+tBuSawCGe6eZNyflCBOLzGMHqfdoyGwlt1GoXqE53UHYQwiJ
 BPZk+FrIHBzm2AeevAvnBSUMI/+y6OheE0E+YDc9/NMC20Gxgqns1n7C7FX8CtzKM7BXeUvLf
 jCHaxPjlPMq3aRka4E2ye2Cdpg2aFtHvb4/9rcft8byVRdDGEyHqvHgE2FtSiG7JnfuFKZMDW
 J5QVAnzFB59NDEnlZOdwykPiur4NHJe+MNT1o2VnBbFBVvKm0JyE5v4KLj+ODn1+QBseb6x/E
 kJUGSR0WwAcOe2WcJXIfoFrfP+95dUX9gL77JZaxk5loIbObySz03EsRx876eaYfU8vnWABEi
 Tt63qfWTMaC6Wu1Tw/MSEkVBDAbzYd3Gc9X8ERBRdYGIQN3uOTC3f7nVnHHpPPWhLIhQ1l/8G
 YbgboL9PeR+ImjvYIkLG71Jd6/aJJktZbYTM/MiuvpsQUS86YbOrtMCvXPfAl7RNK0/U=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

På to. 10. feb. 2022 kl. 18.33 +0000 skrev Masahiro Yamada:
> Date:   Thu, 10 Feb 2022 18:33:42 +0900
> From: Masahiro Yamada <masahiroy@kernel.org>
> To: linux-kbuild@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org, Masahiro Yamada <masahiroy@kernel.org>
> Subject: [PATCH] kbuild: replace $(if A,A,B) with $(or A,B)
> Message-Id: <20220210093342.2118196-1-masahiroy@kernel.org>
> X-Mailer: git-send-email 2.32.0
> X-Mailing-List: linux-kbuild@vger.kernel.org
> 
> $(or ...) is available since GNU Make 3.81, and useful to shorten the
> code in some places.
> 
> Covert as follows:
> 
>   $(if A,A,B)  -->  $(or A,B)
> 
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> ---
> 
>  Makefile                                    | 8 ++++----
>  scripts/Makefile.build                      | 3 +--
>  scripts/Makefile.clean                      | 2 +-
>  scripts/Makefile.lib                        | 4 ++--
>  tools/bpf/bpftool/Makefile                  | 4 ++--
>  tools/build/Makefile                        | 2 +-
>  tools/counter/Makefile                      | 2 +-
>  tools/gpio/Makefile                         | 2 +-
>  tools/hv/Makefile                           | 2 +-
>  tools/iio/Makefile                          | 2 +-
>  tools/lib/api/Makefile                      | 2 +-
>  tools/lib/bpf/Makefile                      | 2 +-
>  tools/lib/perf/Makefile                     | 2 +-
>  tools/lib/subcmd/Makefile                   | 2 +-
>  tools/objtool/Makefile                      | 2 +-
>  tools/pci/Makefile                          | 2 +-
>  tools/perf/Makefile.perf                    | 4 ++--
>  tools/power/x86/intel-speed-select/Makefile | 2 +-
>  tools/scripts/utilities.mak                 | 2 +-
>  tools/spi/Makefile                          | 6 +++---
>  tools/tracing/rtla/Makefile                 | 2 +-
>  tools/usb/Makefile                          | 2 +-
>  22 files changed, 30 insertions(+), 31 deletions(-)
> 
[...]
> diff --git a/tools/lib/bpf/Makefile b/tools/lib/bpf/Makefile
> index f947b61b2107..df1f6ff7bc49 100644
> --- a/tools/lib/bpf/Makefile
> +++ b/tools/lib/bpf/Makefile
> @@ -60,7 +60,7 @@ ifndef VERBOSE
>    VERBOSE = 0
>  endif
>  
> -INCLUDES = -I$(if $(OUTPUT),$(OUTPUT),.)				\
> +INCLUDES = -I$(or $(OUTPUT),.)				\
>  	   -I$(srctree)/tools/include -I$(srctree)/tools/include/uapi

I think I'd have shortened the whitespaces before the stray backslash.

>  
>  export prefix libdir src obj
> diff --git a/tools/lib/perf/Makefile b/tools/lib/perf/Makefile
> index 08fe6e3c4089..2d985d6a3a96 100644
> --- a/tools/lib/perf/Makefile
> +++ b/tools/lib/perf/Makefile
> @@ -153,7 +153,7 @@ $(TESTS_STATIC): $(TESTS_IN) $(LIBPERF_A) $(LIBAPI)
>  	$(QUIET_LINK)$(CC) -o $@ $^
>  
>  $(TESTS_SHARED): $(TESTS_IN) $(LIBAPI)
> -	$(QUIET_LINK)$(CC) -o $@ -L$(if $(OUTPUT),$(OUTPUT),.) $^ -lperf
> +	$(QUIET_LINK)$(CC) -o $@ -L$(if $(OUTPUT),.) $^ -lperf

$(if ...)  -> $(or ...)

With this one fixed:
Reviewed-by: Nicolas Schier <nicolas@fjasle.eu>

Thanks for that patch.  I have never seen $(or) in use before but it 
definitively makes sense!

Kind regards,
Nicolas


-- 
epost|xmpp: nicolas@fjasle.eu          irc://oftc.net/nsc
↳ gpg: 18ed 52db e34f 860e e9fb  c82b 7d97 0932 55a0 ce7f
     -- frykten for herren er opphav til kunnskap --
