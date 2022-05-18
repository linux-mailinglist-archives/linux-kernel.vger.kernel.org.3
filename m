Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8596052C55E
	for <lists+linux-kernel@lfdr.de>; Wed, 18 May 2022 23:22:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243030AbiERVFz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 May 2022 17:05:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243029AbiERVFv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 May 2022 17:05:51 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 222C123BC5;
        Wed, 18 May 2022 14:05:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:Content-Type
        :In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=5RhvSiqa1rf3ZIn8UM8Az2UmpI0VdzrL0ZhZPdtUWQU=; b=OFSPHtTLXfglvvoWmjonNs+6Q1
        lpgYB+FEPtM/6mbGAmnujphLiAS+rMHdDKBSO96nt3xCPomcFFyQdNhI1tN8dku3p+sPyf64kli9/
        ZtunTUe6rvovNLHmg36UmHsP4pJTXxHRlQ63zFV+W+uo7eIgz6FfhmcLyE4Mi7+qvBR/Z2gjz9CC3
        HJWkrnzXzd9so/OM6qGwjYyQxYPIWy19GohZbm+tgSmF9XrASs849DHdet/mkiSfRgOl1xdEHAyGP
        WjLJgCWgTo7CpMYGAubapGwGCX2RDcQIfJiMsOWk12kD5JjhAn2yKRe92J1C7MB8VVVUVXCzpI1Rg
        pZTdauNA==;
Received: from [2601:1c0:6280:3f0::aa0b]
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nrQrO-001eW1-3F; Wed, 18 May 2022 21:05:34 +0000
Message-ID: <8ead0da9-9545-b10d-e3db-7df1a1f219e4@infradead.org>
Date:   Wed, 18 May 2022 14:05:28 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: linux-next: Tree for May 18
 (arch/x86/kernel/cpu/microcode/intel.o)
Content-Language: en-US
To:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        X86 ML <x86@kernel.org>, Borislav Petkov <bp@alien8.de>
References: <20220518202934.730a8aba@canb.auug.org.au>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20220518202934.730a8aba@canb.auug.org.au>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/18/22 03:29, Stephen Rothwell wrote:
> Hi all,
> 
> Changes since 20220517:
> 

on x86_64:

CONFIG_PROCESSOR_SELECT=y
# CONFIG_CPU_SUP_INTEL is not set   <<<<<
CONFIG_CPU_SUP_AMD=y
# CONFIG_CPU_SUP_HYGON is not set
CONFIG_CPU_SUP_CENTAUR=y
CONFIG_CPU_SUP_ZHAOXIN=y

CONFIG_MICROCODE=y
CONFIG_MICROCODE_INTEL=y   <<<<<
CONFIG_MICROCODE_AMD=y

causes:

ld: ld: DWARF error: could not find abbrev number 71
arch/x86/kernel/cpu/microcode/intel.o: in function `__load_ucode_intel':
intel.c:(.text+0xe9b): undefined reference to `intel_cpu_collect_info'
ld: arch/x86/kernel/cpu/microcode/intel.o: in function `reload_ucode_intel':
intel.c:(.text+0x130d): undefined reference to `intel_cpu_collect_info'
ld: arch/x86/kernel/cpu/microcode/intel.o: in function `save_microcode_in_initrd_intel':
intel.c:(.init.text+0x108): undefined reference to `intel_cpu_collect_info'
ld: ld: DWARF error: could not find abbrev number 609515
drivers/platform/x86/intel/ifs/load.o: in function `ifs_load_firmware':
load.c:(.text+0x479): undefined reference to `intel_cpu_collect_info'


-- 
~Randy
