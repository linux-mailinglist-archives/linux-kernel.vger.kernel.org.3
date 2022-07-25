Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E124580338
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jul 2022 18:58:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236643AbiGYQ6C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jul 2022 12:58:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235121AbiGYQ5z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jul 2022 12:57:55 -0400
Received: from out02.mta.xmission.com (out02.mta.xmission.com [166.70.13.232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7C2D63EF;
        Mon, 25 Jul 2022 09:57:53 -0700 (PDT)
Received: from in01.mta.xmission.com ([166.70.13.51]:59392)
        by out02.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1oG1Or-0041S6-Td; Mon, 25 Jul 2022 10:57:45 -0600
Received: from ip68-227-174-4.om.om.cox.net ([68.227.174.4]:60550 helo=email.froward.int.ebiederm.org.xmission.com)
        by in01.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1oG1Oq-006Si1-Im; Mon, 25 Jul 2022 10:57:45 -0600
From:   "Eric W. Biederman" <ebiederm@xmission.com>
To:     Albert Huang <huangjie.albert@bytedance.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Nick Desaulniers <ndesaulniers@google.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Michael Roth <michael.roth@amd.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Joerg Roedel <jroedel@suse.de>,
        Sean Christopherson <seanjc@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Kees Cook <keescook@chromium.org>,
        linux-kernel@vger.kernel.org, kexec@lists.infradead.org,
        linux-kbuild@vger.kernel.org
References: <20220725083904.56552-1-huangjie.albert@bytedance.com>
        <20220725083904.56552-4-huangjie.albert@bytedance.com>
Date:   Mon, 25 Jul 2022 11:57:36 -0500
In-Reply-To: <20220725083904.56552-4-huangjie.albert@bytedance.com> (Albert
        Huang's message of "Mon, 25 Jul 2022 16:38:55 +0800")
Message-ID: <87fsipf7un.fsf@email.froward.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1oG1Oq-006Si1-Im;;;mid=<87fsipf7un.fsf@email.froward.int.ebiederm.org>;;;hst=in01.mta.xmission.com;;;ip=68.227.174.4;;;frm=ebiederm@xmission.com;;;spf=softfail
X-XM-AID: U2FsdGVkX180fZatt+af7PbVBVhJaSGK05ATzRuruNk=
X-SA-Exim-Connect-IP: 68.227.174.4
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-DCC: XMission; sa08 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ****;Albert Huang <huangjie.albert@bytedance.com>
X-Spam-Relay-Country: 
X-Spam-Timing: total 513 ms - load_scoreonly_sql: 0.14 (0.0%),
        signal_user_changed: 15 (3.0%), b_tie_ro: 13 (2.5%), parse: 1.31
        (0.3%), extract_message_metadata: 14 (2.8%), get_uri_detail_list: 3.0
        (0.6%), tests_pri_-1000: 20 (3.9%), tests_pri_-950: 1.41 (0.3%),
        tests_pri_-900: 1.17 (0.2%), tests_pri_-90: 116 (22.6%), check_bayes:
        114 (22.1%), b_tokenize: 11 (2.1%), b_tok_get_all: 14 (2.7%),
        b_comp_prob: 4.5 (0.9%), b_tok_touch_all: 79 (15.3%), b_finish: 1.39
        (0.3%), tests_pri_0: 329 (64.1%), check_dkim_signature: 0.56 (0.1%),
        check_dkim_adsp: 4.9 (1.0%), poll_dns_idle: 0.50 (0.1%), tests_pri_10:
        2.3 (0.4%), tests_pri_500: 8 (1.6%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH 3/4] x86: Support the uncompressed kernel to speed up
 booting
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Albert Huang <huangjie.albert@bytedance.com> writes:

> From: "huangjie.albert" <huangjie.albert@bytedance.com>
>
> Although the compressed kernel can save the time of loading the
> kernel into the memory and save the disk space for storing the kernel,
> but in some time-sensitive scenarios, the time for decompressing the
> kernel is intolerable. Therefore, it is necessary to support uncompressed
> kernel images, so that the time of kernel decompression can be saved when
> the kernel is started.
>
> This part of the time on my machine is approximately:
> image type      image  size      times
> compressed(gzip) 8.5M            159ms
> uncompressed     53M             8.5ms

Why in the world are you using arch/x86/boot/compressed/... for an
uncompressed kernel.  Especially if you don't plan to process
relocations.

Even if it somehow makes sense why have you not followed the pattern
used by the rest of the code and implemented a file that implements
a no-op __decompress routine?

Eric


> Signed-off-by: huangjie.albert <huangjie.albert@bytedance.com>
> ---
>  arch/x86/Kconfig                  |  1 +
>  arch/x86/boot/compressed/Makefile |  5 ++++-
>  arch/x86/boot/compressed/misc.c   | 13 +++++++++++++
>  scripts/Makefile.lib              |  5 +++++
>  4 files changed, 23 insertions(+), 1 deletion(-)
>
> diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
> index adbd3a2bd60f..231187624c68 100644
> --- a/arch/x86/Kconfig
> +++ b/arch/x86/Kconfig
> @@ -221,6 +221,7 @@ config X86
>  	select HAVE_KERNEL_LZO
>  	select HAVE_KERNEL_XZ
>  	select HAVE_KERNEL_ZSTD
> +	select HAVE_KERNEL_UNCOMPRESSED
>  	select HAVE_KPROBES
>  	select HAVE_KPROBES_ON_FTRACE
>  	select HAVE_FUNCTION_ERROR_INJECTION
> diff --git a/arch/x86/boot/compressed/Makefile b/arch/x86/boot/compressed/Makefile
> index 19e1905dcbf6..0c8417a2f792 100644
> --- a/arch/x86/boot/compressed/Makefile
> +++ b/arch/x86/boot/compressed/Makefile
> @@ -26,7 +26,7 @@ OBJECT_FILES_NON_STANDARD	:= y
>  KCOV_INSTRUMENT		:= n
>  
>  targets := vmlinux vmlinux.bin vmlinux.bin.gz vmlinux.bin.bz2 vmlinux.bin.lzma \
> -	vmlinux.bin.xz vmlinux.bin.lzo vmlinux.bin.lz4 vmlinux.bin.zst
> +	vmlinux.bin.xz vmlinux.bin.lzo vmlinux.bin.lz4 vmlinux.bin.zst vmlinux.bin.none
>  
>  # CLANG_FLAGS must come before any cc-disable-warning or cc-option calls in
>  # case of cross compiling, as it has the '--target=' flag, which is needed to
> @@ -139,6 +139,8 @@ $(obj)/vmlinux.bin.lz4: $(vmlinux.bin.all-y) FORCE
>  	$(call if_changed,lz4_with_size)
>  $(obj)/vmlinux.bin.zst: $(vmlinux.bin.all-y) FORCE
>  	$(call if_changed,zstd22_with_size)
> +$(obj)/vmlinux.bin.none: $(vmlinux.bin.all-y) FORCE
> +	$(call if_changed,none)
>  
>  suffix-$(CONFIG_KERNEL_GZIP)	:= gz
>  suffix-$(CONFIG_KERNEL_BZIP2)	:= bz2
> @@ -147,6 +149,7 @@ suffix-$(CONFIG_KERNEL_XZ)	:= xz
>  suffix-$(CONFIG_KERNEL_LZO) 	:= lzo
>  suffix-$(CONFIG_KERNEL_LZ4) 	:= lz4
>  suffix-$(CONFIG_KERNEL_ZSTD)	:= zst
> +suffix-$(CONFIG_KERNEL_UNCOMPRESSED)	:= none
>  
>  quiet_cmd_mkpiggy = MKPIGGY $@
>        cmd_mkpiggy = $(obj)/mkpiggy $< > $@
> diff --git a/arch/x86/boot/compressed/misc.c b/arch/x86/boot/compressed/misc.c
> index cf690d8712f4..c23c0f525d93 100644
> --- a/arch/x86/boot/compressed/misc.c
> +++ b/arch/x86/boot/compressed/misc.c
> @@ -181,6 +181,19 @@ void __puthex(unsigned long value)
>  	}
>  }
>  
> +#ifdef CONFIG_KERNEL_UNCOMPRESSED
> +#include <linux/decompress/mm.h>
> +static int __decompress(unsigned char *buf, long len,
> +				long (*fill)(void*, unsigned long),
> +				long (*flush)(void*, unsigned long),
> +				unsigned char *outbuf, long olen,
> +				long *pos, void (*error)(char *x))
> +{
> +	memcpy(outbuf, buf, olen);
> +	return 0;
> +}
> +#endif
> +
>  #ifdef CONFIG_X86_NEED_RELOCS
>  static void handle_relocations(void *output, unsigned long output_len,
>  			       unsigned long virt_addr)
> diff --git a/scripts/Makefile.lib b/scripts/Makefile.lib
> index 3fb6a99e78c4..c89d5466c617 100644
> --- a/scripts/Makefile.lib
> +++ b/scripts/Makefile.lib
> @@ -438,6 +438,11 @@ quiet_cmd_lz4 = LZ4     $@
>  quiet_cmd_lz4_with_size = LZ4     $@
>        cmd_lz4_with_size = { cat $(real-prereqs) | $(LZ4) -l -c1 stdin stdout; \
>                    $(size_append); } > $@
> +# none
> +quiet_cmd_none = NONE     $@
> +      cmd_none = (cat $(filter-out FORCE,$^) && \
> +      $(call size_append, $(filter-out FORCE,$^))) > $@ || \
> +      (rm -f $@ ; false)
>  
>  # U-Boot mkimage
>  # ---------------------------------------------------------------------------
