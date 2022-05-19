Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B899352DB52
	for <lists+linux-kernel@lfdr.de>; Thu, 19 May 2022 19:31:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242831AbiESRaz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 May 2022 13:30:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242491AbiESRaf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 13:30:35 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 219323DDCA
        for <linux-kernel@vger.kernel.org>; Thu, 19 May 2022 10:29:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B04BC616FA
        for <linux-kernel@vger.kernel.org>; Thu, 19 May 2022 17:29:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D17BCC385AA;
        Thu, 19 May 2022 17:29:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1652981389;
        bh=g53Y2YaDhOn31lb4ikdAKEj8xh9/Sa586oK5ccMyOKM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=j55Dg0KOedrmIYtQCAjwlgobU/eX/Y7m/nIQOUUzxAa5QCS4+yfVJs0zuYfBExfGP
         VtDpTFM9sPH3MJJVyy4le6VvsqOSafd8I+piJslp3hWLcH2nenxMrDzyET21hwWHdW
         9WLVAun1TmCy8ADN1FVJ5eCUoRWatIAJNH1QX6A8=
Date:   Thu, 19 May 2022 10:29:48 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     kernel test robot <lkp@intel.com>
Cc:     "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Eric Biederman <ebiederm@xmission.com>,
        kbuild-all@lists.01.org,
        Linux Memory Management List <linux-mm@kvack.org>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        kexec@lists.infradead.org
Subject: Re: [PATCH v2] kexec_file: Drop weak attribute from
 arch_kexec_apply_relocations[_add]
Message-Id: <20220519102948.f5c990db0e5f9cfb35c2a68f@linux-foundation.org>
In-Reply-To: <202205192320.CoXevcfR-lkp@intel.com>
References: <20220519091237.676736-1-naveen.n.rao@linux.vnet.ibm.com>
        <202205192320.CoXevcfR-lkp@intel.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 19 May 2022 23:17:48 +0800 kernel test robot <lkp@intel.com> wrote:

> Hi "Naveen,
> 
> I love your patch! Yet something to improve:
> 
> [auto build test ERROR on f993aed406eaf968ba3867a76bb46c95336a33d0]
> 
> url:    https://github.com/intel-lab-lkp/linux/commits/Naveen-N-Rao/kexec_file-Drop-weak-attribute-from-arch_kexec_apply_relocations-_add/20220519-171432
> base:   f993aed406eaf968ba3867a76bb46c95336a33d0
> config: s390-allmodconfig (https://download.01.org/0day-ci/archive/20220519/202205192320.CoXevcfR-lkp@intel.com/config)
> compiler: s390-linux-gcc (GCC) 11.3.0
> reproduce (this is a W=1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # https://github.com/intel-lab-lkp/linux/commit/67171688c71cb5b05f26e0dfc45eec8d8d1428ff
>         git remote add linux-review https://github.com/intel-lab-lkp/linux
>         git fetch --no-tags linux-review Naveen-N-Rao/kexec_file-Drop-weak-attribute-from-arch_kexec_apply_relocations-_add/20220519-171432
>         git checkout 67171688c71cb5b05f26e0dfc45eec8d8d1428ff
>         # save the config file
>         mkdir build_dir && cp config build_dir/.config
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross W=1 O=build_dir ARCH=s390 SHELL=/bin/bash arch/s390/
> 
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
> 
> All errors (new ones prefixed by >>):
> 
>    In file included from arch/s390/kernel/machine_kexec_reloc.c:3:
> >> arch/s390/include/asm/kexec.h:89:38: error: unknown type name 'Elf_Shdr'; did you mean 'elf_shdr'?
>       89 |                                      Elf_Shdr *section,
>          |                                      ^~~~~~~~
>          |                                      elf_shdr
>    arch/s390/include/asm/kexec.h:90:44: error: unknown type name 'Elf_Shdr'
>       90 |                                      const Elf_Shdr *relsec,
>          |                                            ^~~~~~~~
>    arch/s390/include/asm/kexec.h:91:44: error: unknown type name 'Elf_Shdr'
>       91 |                                      const Elf_Shdr *symtab);
>          |                                            ^~~~~~~~

Thanks, I did this:

--- a/arch/s390/include/asm/kexec.h~kexec_file-drop-weak-attribute-from-arch_kexec_apply_relocations-fix
+++ a/arch/s390/include/asm/kexec.h
@@ -9,6 +9,8 @@
 #ifndef _S390_KEXEC_H
 #define _S390_KEXEC_H
 
+#include <linux/module.h>
+
 #include <asm/processor.h>
 #include <asm/page.h>
 #include <asm/setup.h>
_

