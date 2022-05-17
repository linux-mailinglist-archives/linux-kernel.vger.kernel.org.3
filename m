Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5BEE52A0A8
	for <lists+linux-kernel@lfdr.de>; Tue, 17 May 2022 13:44:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345206AbiEQLoF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 May 2022 07:44:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229770AbiEQLoD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 May 2022 07:44:03 -0400
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21A644348A
        for <linux-kernel@vger.kernel.org>; Tue, 17 May 2022 04:44:00 -0700 (PDT)
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20220517114357epoutp03304194d5aef37735da6281b311c8724b~v4cgL7FBs1100611006epoutp03w
        for <linux-kernel@vger.kernel.org>; Tue, 17 May 2022 11:43:57 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20220517114357epoutp03304194d5aef37735da6281b311c8724b~v4cgL7FBs1100611006epoutp03w
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1652787837;
        bh=fjaQh4eEPkt0UKXFBEJLbDXgHrVIRR5OPeMgokpmREI=;
        h=Subject:Reply-To:From:To:CC:In-Reply-To:Date:References:From;
        b=UW+t9vuE3oOQUtcHn2tjMtx87W9oyhzDRZaN2YWVIVv7Q7OSar8rwC+onC151IWYT
         ss2aY4y2RbDqaDc0vUolRRwwYdoPGrn0LMXoOtkYFJtPoyXcuPZqZn1NsnfxM/XBnC
         +Ws1mCiWVm9xaROd42oqQMvDyM5pc7dlQTJIv9To=
Received: from epsmges5p3new.samsung.com (unknown [182.195.42.75]) by
        epcas5p4.samsung.com (KnoxPortal) with ESMTP id
        20220517114356epcas5p4b12f1803dc079771a290b8fa1485eeac~v4cfA-m8W3035330353epcas5p4s;
        Tue, 17 May 2022 11:43:56 +0000 (GMT)
X-AuditID: b6c32a4b-1fdff70000002622-73-62838a7cbde7
Received: from epcas5p1.samsung.com ( [182.195.41.39]) by
        epsmges5p3new.samsung.com (Symantec Messaging Gateway) with SMTP id
        C6.80.09762.C7A83826; Tue, 17 May 2022 20:43:56 +0900 (KST)
Mime-Version: 1.0
Subject: RE: [PATCH modules-next 1/1] kallsyms: enhance %pS/s/b printing
 when KALLSYSMS is disabled
Reply-To: maninder1.s@samsung.com
Sender: Maninder Singh <maninder1.s@samsung.com>
From:   Maninder Singh <maninder1.s@samsung.com>
To:     Kees Cook <keescook@chromium.org>
CC:     "mcgrof@kernel.org" <mcgrof@kernel.org>,
        "pmladek@suse.com" <pmladek@suse.com>,
        "rostedt@goodmis.org" <rostedt@goodmis.org>,
        "senozhatsky@chromium.org" <senozhatsky@chromium.org>,
        "andriy.shevchenko@linux.intel.com" 
        <andriy.shevchenko@linux.intel.com>,
        "linux@rasmusvillemoes.dk" <linux@rasmusvillemoes.dk>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "wangkefeng.wang@huawei.com" <wangkefeng.wang@huawei.com>,
        Vaneet Narang <v.narang@samsung.com>,
        "swboyd@chromium.org" <swboyd@chromium.org>,
        "ojeda@kernel.or" <ojeda@kernel.or>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-modules@vger.kernel.org" <linux-modules@vger.kernel.org>,
        "avimalin@gmail.com" <avimalin@gmail.com>,
        "atomlin@redhat.com" <atomlin@redhat.com>,
        Onkarnath <onkarnath.1@samsung.com>
X-Priority: 3
X-Content-Kind-Code: NORMAL
In-Reply-To: <202205111513.3AD646936@keescook>
X-Drm-Type: N,general
X-Msg-Generator: Mail
X-Msg-Type: PERSONAL
X-Reply-Demand: N
Message-ID: <20220517035810epcms5p3f7dc52887e356559b55a2cbf9d04a039@epcms5p3>
Date:   Tue, 17 May 2022 09:28:10 +0530
X-CMS-MailID: 20220517035810epcms5p3f7dc52887e356559b55a2cbf9d04a039
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrGKsWRmVeSWpSXmKPExsWy7bCmum5NV3OSwbwfXBZz1q9hs+htms5k
        cWT+GlaLBwevs1uc6c61uLxrDptFw+zvrBaPZ81js7gx4SmjxcwvQBUrej6wWvx//JXVYl/H
        AyaL3RsXsVkcv/OUyeLQybmMFo2f7zM6CHrMbrjI4rFz1l12j5Z9t4DEkbesHl+un2f02LSq
        k83jxIzfLB7zTgZ6XOjK9ni/7yqbR9+WVYwe67dcZfH4vEkugDeKyyYlNSezLLVI3y6BK6Pr
        4n3mgu8uFcv3tDA3MN407WLk5JAQMJFobz7G1sXIxSEksJtR4lPDRvYuRg4OXgFBib87hEFq
        hAVSJZbsfssCYgsJKEpcmLGGEaREWMBA4tdWDZAwm4CexKpde8BKRARUJb5famYGGckssJVN
        4vrec6wQu3glZrQ/ZYGwpSW2L9/KCGJzAjUfPX4fqkZU4ubqt+ww9vtj8xkhbBGJ1ntnmSFs
        QYkHP3dDxWUkVm/uhZpZLfH09TmwXyQEWhgl9u2GKTKXWL9kFdhQXgFfie+n/oM1sABdenxh
        JxvIMxICLhKn32iBhJkF5CW2v53DDBJmFtCUWL9LH2KKrMTUU+uYIEr4JHp/P2GCeWvHPBhb
        VaLl5gZWmBc/f/wIdZqHRNOfR0yQYF7OKPHw9QrWCYwKsxAhPQvJ5lkImxcwMq9ilEwtKM5N
        Ty02LTDOSy3XK07MLS7NS9dLzs/dxAhOilreOxgfPfigd4iRiYPxEKMEB7OSCK9BRUOSEG9K
        YmVValF+fFFpTmrxIUZpDhYlcV6B/41JQgLpiSWp2ampBalFMFkmDk6pBib2eIaLq4S0d+6N
        TrV1EHNK/WTIH/6q29Lja1XbAY73XWfuXF+iXWrzyquv9cnhJrmg3To2J2QabBxefXsbmBJz
        vOF6T3EmZ3PXuvTq++tCny6Oem6pb9psE7f2yhGzCsOo8sBFO1L/r+VQdOntFn23NTKds/iA
        2bbYrXoTM/y+5j/ViK443l5XbTBxnanuN5tzS8tXeS3MWbv3NZO/1syfCwy2P+Fm2vFxzcWn
        D9aH5vC0aRfMPimcf+M6B49S30nD9D4ZR74JDfmXy7Z88bYVfC9tWHuvKP33TFVDjXncbZYl
        viK6/f3Zkg9TeT4GPPe6KRRYzLdfgW2O26UG7S1SHfvvenx68Dj01q/ZSizFGYmGWsxFxYkA
        Iqq6XPkDAAA=
X-CMS-RootMailID: 20220421041604epcas5p414cf2e851d1bd828a151dc6b2b004680
References: <202205111513.3AD646936@keescook>
        <20220421041542.9195-1-maninder1.s@samsung.com>
        <CGME20220421041604epcas5p414cf2e851d1bd828a151dc6b2b004680@epcms5p3>
X-Spam-Status: No, score=-3.0 required=5.0 tests=BAYES_00,DATE_IN_PAST_06_12,
        DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kees,

> 
> I'd like this patch reverted from -next.
> - too many logical changes is a single patch

ok, will try to break patch in separate patches.

> - addition of dangerous API usage

sprintf was alraedy there, just changed its position
and in current logic it seems not possible to change it.

Because sprint_symbol interface is made without len of array

int sprint_symbol(char *buffer, unsigned long address)
{
        return __sprint_symbol(buffer, address, 0, 1, 0);
}
EXPORT_SYMBOL_GPL(sprint_symbol);


So either we need to change API declaration for all cases.
please suggest, then I can make one separate change to include
size of buffer as argument.

otherwise there is no benefit to take care of size at some places only.

> - duplicated logic (maybe? hard to review due to the changes)

We tried to avoid all duplicacies, but will check to clean patch more.
 
> Details below...
> 
> > 
..
> > 
> > (C) With patched kernel
> > with KALLYSMS:
> > [41.974576] ps function_1 [crash]
> > [41.975173] pS function_1+0x4/0x2c [crash]
> > [41.975386] pSb function_1+0x4/0x2c [crash a8b20caaec9635b316cf4812f6b55598fe2b7cee]
> > [41.975879] pB function_1+0x4/0x2c [crash]
> > [41.976076] pBb function_1+0x4/0x2c [crash a8b20caaec9635b316cf4812f6b55598fe2b7cee]
> > 
> > without KALLSYMS:
> > [9.624152] ps 0xffff800001bd008c [crash]	// similar to original, no changes
> 
> Why is this not hashed?
>

Because without patch also we print complete address in case of %ps,
only addition is module name now.

if we made it to hashed, then I will make one patch after this to hash it
as Andy told it will change current behaviour.
 
> > [9.624548] pS 0x(____ptrval____)+0x8c [crash]   // base address hashed and offset is without hash
> > [9.624847] pSb 0x(____ptrval____)+0x8c [crash a8b20caaec9635b316cf4812f6b55598fe2b7cee]
> > [9.625388] pB 0x(____ptrval____)+0x8c [crash]
> > [9.625594] pBb 0x(____ptrval____)+0x8c [crash a8b20caaec9635b316cf4812f6b55598fe2b7cee]
> 
> Why is "____ptrval____" visible here after 9 seconds of boot? I would
> expect a hashed value to be present.
> 

Actually I verified it on QEMU setup with minimal roots and in this case
hashed values were not present.

I tested it on my target;s old kernel for actual hash values.
But pasted the logs of latets kernel only with __ptr___

> > 
> > with disable hashing:
> > [8.563916] ps 0xffff800000f2008c [crash]
..
> >  
> >  int lookup_symbol_name(unsigned long addr, char *symname);
> >  int lookup_symbol_attrs(unsigned long addr, unsigned long *size, unsigned long *offset, char *modname, char *name);
> > diff --git a/include/linux/module.h b/include/linux/module.h
> > index 46d4d5f2516e..66f4491249c5 100644
> > --- a/include/linux/module.h
> > +++ b/include/linux/module.h
> > @@ -682,6 +682,20 @@ static inline bool is_livepatch_module(struct module *mod)
> >  
> >  void set_module_sig_enforced(void);
> >  
> > +static inline int fill_name_build_id(char *buffer, char *modname,
> > +			    int add_buildid, const unsigned char *buildid,
> > +			    int len)
> > +{
> > +	len += sprintf(buffer + len, " [%s", modname);
> 
> This patch uses sprintf() everywhere. This needs to be using
> scnprintf(). https://lwn.net/Articles/69419/
> 

These were already present .
Moved sprintf from __sprint_symbol to new function fill_name_build_id

and same logic added when KALLSYMS is disabled.

new API sprint_module_info added 2 new sprintf, which can be taken care of with
passing size of buffer.

But as already explained either we should take care of all APIs with one separate patch.
or we can allow these 2 sprintfs also to make same dsign with KALLSYMS.



> > diff --git a/kernel/kallsyms.c b/kernel/kallsyms.c
> > index 79f2eb617a62..e6e96b2e0257 100644
> > --- a/kernel/kallsyms.c
> > +++ b/kernel/kallsyms.c
> > @@ -465,19 +465,8 @@ static int __sprint_symbol(char *buffer, unsigned long address,
> >  	if (add_offset)
> >  		len += sprintf(buffer + len, "+%#lx/%#lx", offset, size);
> >  
> > -	if (modname) {
> > -		len += sprintf(buffer + len, " [%s", modname);
> > -#if IS_ENABLED(CONFIG_STACKTRACE_BUILD_ID)
> > -		if (add_buildid && buildid) {
> > -			/* build ID should match length of sprintf */
> > -#if IS_ENABLED(CONFIG_MODULES)
> > -			static_assert(sizeof(typeof_member(struct module, build_id)) == 20);
> > -#endif
> > -			len += sprintf(buffer + len, " %20phN", buildid);
> > -		}
> > -#endif
> > -		len += sprintf(buffer + len, "]");
> > -	}
> > +	if (modname)
> > +		len += fill_name_build_id(buffer, modname, add_buildid, buildid, len);
> 
> Build ID is now part of sprint_module_info?
> 

It was part of sprint_module_info earlier also.
just modular the code with new API fill_name_build_id()
to call it in case of disabled KALLSYMS also.

> >  
> >  	return len;
> >  }
> > @@ -572,6 +561,18 @@ int sprint_backtrace_build_id(char *buffer, unsigned long address)
> >  	return __sprint_symbol(buffer, address, -1, 1, 1);
> >  }
> >  
> > +int sprint_kallsym_common(char *buffer, unsigned long address, int build_id,
> > +			    int backtrace, int symbol)
> 
> I find the build_id argument order unexpected: I'd think it'd match the
> ordering of __sprint_symbol?
> 
> > +{
> > +	if (backtrace)
> > +		return __sprint_symbol(buffer, address, -1, 1, build_id);
> > +
> > +	if (symbol)
> > +		return __sprint_symbol(buffer, address, 0, 1, build_id);
> > +
> > +	return __sprint_symbol(buffer, address, 0, 0, 0);
> > +}
> > +
> >  /* To avoid using get_symbol_offset for every symbol, we carry prefix along. */
> >  struct kallsym_iter {
> >  	loff_t pos;
..

> > diff --git a/lib/vsprintf.c b/lib/vsprintf.c
> > index 40d26a07a133..e0aba2c80b8e 100644
> > --- a/lib/vsprintf.c
> > +++ b/lib/vsprintf.c
> > @@ -999,33 +999,92 @@ char *bdev_name(char *buf, char *end, struct block_device *bdev,
> >  }
> >  #endif
> >  
..
> > +	preempt_enable();
> > +	if (!mod)
> > +		return 0;
> > +
> > +	/* address belongs to module */
> > +	if (add_offset)
> > +		len = sprintf(buf, "0x%p+0x%lx", base, offset);
> > +	else
> > +		len = sprintf(buf, "0x%lx", value);
> > +
> > +	return len + fill_name_build_id(buf, modname, modbuildid, buildid, len);
> 
> Doesn't this duplicate a bunch of logic elsewhere?
>

Yes little bit similar code in kallsyms.c for adding offset but purpose is different.
in 1 we need to hash.

but will check more if we can make some clean patch set with 2-3 patches rather than from 1 single patch change.

 
> > +}
> > +#else
> > +static inline int sprint_module_info(char *buf, unsigned long value,
> > +			     int modbuildid, int backtrace, int symbol)
> > +{
> > +	return 0;
> > +}
> > +#endif
> > +
> >  static noinline_for_stack
> >  char *symbol_string(char *buf, char *end, void *ptr,
> >  		    struct printf_spec spec, const char *fmt)
> >  {
> >  	unsigned long value;
> > -#ifdef CONFIG_KALLSYMS
> >  	char sym[KSYM_SYMBOL_LEN];
> > -#endif
> > +	int backtrace = 0, symbol = 0, build_id = 0;
> >  
> >  	if (fmt[1] == 'R')
> >  		ptr = __builtin_extract_return_addr(ptr);
> >  	value = (unsigned long)ptr;
> >  
> > -#ifdef CONFIG_KALLSYMS
> > -	if (*fmt == 'B' && fmt[1] == 'b')
> > -		sprint_backtrace_build_id(sym, value);
> > -	else if (*fmt == 'B')
> > -		sprint_backtrace(sym, value);
> > -	else if (*fmt == 'S' && (fmt[1] == 'b' || (fmt[1] == 'R' && fmt[2] == 'b')))
> > -		sprint_symbol_build_id(sym, value);
> > -	else if (*fmt != 's')
> > -		sprint_symbol(sym, value);
> > -	else
> > -		sprint_symbol_no_offset(sym, value);
> > +	if (fmt[0] == 'B' && fmt[1] == 'b') {
> > +		backtrace = 1;
> > +		build_id = 1;
> > +	} else if (fmt[0] == 'B')
> > +		backtrace = 1;
> > +	else if (fmt[0] == 'S' && (fmt[1] == 'b' || (fmt[1] == 'R' && fmt[2] == 'b'))) {
> > +		symbol = 1;
> > +		build_id = 1;
> > +	} else if (fmt[0] != 's')
> > +		symbol = 1;
> > +	else {
> > +		/* Do Nothing, no offset */
> > +	}
> >  
> > +#ifdef CONFIG_KALLSYMS
> > +	sprint_kallsym_common(sym, value, build_id, backtrace, symbol);
> >  	return string_nocheck(buf, end, sym, spec);
> >  #else
> > +	if (sprint_module_info(sym, value, build_id, backtrace, symbol))
> > +		return string_nocheck(buf, end, sym, spec);
> 
> These take the same arguments, and only differ about their ability to
> look things up.
> 

Yes, Will make both API with same name, it will clean the code more.

> > +
> >  	return special_hex_number(buf, end, value, sizeof(void *));
> >  #endif
> >  }
> > -- 
> > 2.17.1
> > 
> 
> -- 

Thanks for input, please suggest about sprintf changes, then I will send
new patches with more clean code.

----
Maninder Singh
