Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C644B4992A4
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jan 2022 21:23:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229897AbiAXUWx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jan 2022 15:22:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356421AbiAXUEB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jan 2022 15:04:01 -0500
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5433C02B744;
        Mon, 24 Jan 2022 11:30:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:Content-Type
        :In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=NapAq0upa/xBbdyBqNdIKWsoXhhYnY7MaFwJ0hBc1gQ=; b=XCCZ+iqpLLRJJjGyeS+6bUL9ce
        kqx71LzsFHLHQlEeDPymTFu7GqIoJvaBvlsN0iXwxiULvVp33rTGhJr5/n0QOnH5Cn9b2IwkkSIHd
        mnATGZg7DrWmDpgDYRLzgETPROWfwiqO6PWq0f9a4Ab2gQVI1bhap975hG1f6bgc3Az7vSx4Vr6jz
        7V5qh5gnQhBdc/lYwHbJkGzBMKvnFN5i4iN6d17IEKrvW3kTdna/7Yq7f3d0Shog6c7kLLE5RA/pc
        bHB2hEOuBBgf+XOZ31iuiEtYwniv9U2B/XLcDfEMiGW8EFFFifEwHpSRW+vdV37n82dxxhCdk4b58
        Wt3OLIRQ==;
Received: from [2601:1c0:6280:3f0::aa0b]
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nC52k-003FFE-Pd; Mon, 24 Jan 2022 19:30:23 +0000
Message-ID: <0ab7e64d-54ab-ed9d-ed23-75c6902cca25@infradead.org>
Date:   Mon, 24 Jan 2022 11:30:15 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH -next] exit: export make_task_dead()
Content-Language: en-US
To:     Christoph Hellwig <hch@infradead.org>
Cc:     linux-kernel@vger.kernel.org,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        linux-ia64@vger.kernel.org, Tony Luck <tony.luck@intel.com>,
        kernel test robot <lkp@intel.com>
References: <20220122174834.6493-1-rdunlap@infradead.org>
 <Ye5vR609miJCKdYa@infradead.org>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <Ye5vR609miJCKdYa@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/24/22 01:20, Christoph Hellwig wrote:
> On Sat, Jan 22, 2022 at 09:48:34AM -0800, Randy Dunlap wrote:
>> In a config file from "kernel test robot <lkp@intel.com>" for a
>> different problem, this linker error was exposed when
>> CONFIG_IA64_MCA_RECOVERY=m.
>>
>> We could either export make_task_dead() or restrict IA64_MCA_RECOVERY
>> to a bool Kconfig symbol instead of a tristate symbol, so go with the

OK, I'll send a patch to do ^^^that^^^ instead.

>> EXPORT_SYMBOL() path.
>>
>> Fixes this build error:
>>
>> ERROR: modpost: "make_task_dead" [arch/ia64/kernel/mca_recovery.ko] undefined!
>>
>> Fixes: 0e25498f8cd4 ("exit: Add and use make_task_dead.")
>> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
>> Cc: "Eric W. Biederman" <ebiederm@xmission.com>
>> Cc: linux-ia64@vger.kernel.org
>> Cc: Tony Luck <tony.luck@intel.com>
>> Cc: kernel test robot <lkp@intel.com>
>> ---
>>  kernel/exit.c |    1 +
>>  1 file changed, 1 insertion(+)
>>
>> --- linux-next-20220121.orig/kernel/exit.c
>> +++ linux-next-20220121/kernel/exit.c
>> @@ -896,6 +896,7 @@ void __noreturn make_task_dead(int signr
>>  
>>  	do_exit(signr);
>>  }
>> +EXPORT_SYMBOL(make_task_dead);
> 
> EXPORT_SYMBOL_GPL and restricted, please.
> 
> Or even better: force the mca recovery code to be built in.

thanks.
-- 
~Randy
