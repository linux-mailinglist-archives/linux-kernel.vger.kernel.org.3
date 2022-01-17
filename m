Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1305B4903E8
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jan 2022 09:32:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238210AbiAQIcr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jan 2022 03:32:47 -0500
Received: from mga11.intel.com ([192.55.52.93]:22559 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238201AbiAQIcn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jan 2022 03:32:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1642408363; x=1673944363;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=9tJd1d4BMhBoupOx95gX9rum423ETMCxhY6LxtaY1Lo=;
  b=UAMFydnxVGoiRNcRtDiXf9Qj0yh7Yi7EGCJgkatQ1yiXwz+uXGmiebwz
   drH7b8cpnKuMt8wCGQFs9ztLVBWv+EHxiuH2ylFmHUwV657wtsgMLZ7+I
   z6do29N1+1Lskkja/rgZbksBTff+pFrlrZg2bN8W2di5EM1b9OYBTdZ1z
   LnqLzVqIbWApd3Ob3V6Cg1dIhUfcjdHBwne1JWfLRjCLVGXwwGIno7FGv
   PvtvmKgBv4ldkBN0dUEGy/eEgKftR2MWBhoTq2/3qxN0Hbj8HSZEpo5nL
   BU3cRNasw7jYNzDRL13k5MtHonGNLemtZggSSuFbcc+PmTSzguIdJ09c1
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10229"; a="242138479"
X-IronPort-AV: E=Sophos;i="5.88,295,1635231600"; 
   d="scan'208";a="242138479"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jan 2022 00:32:42 -0800
X-IronPort-AV: E=Sophos;i="5.88,295,1635231600"; 
   d="scan'208";a="531248980"
Received: from rongch2-mobl.ccr.corp.intel.com (HELO [10.249.175.229]) ([10.249.175.229])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jan 2022 00:32:40 -0800
Subject: Re: [kbuild-all] Re: WARNING: modpost:
 vmlinux.o(.text.unlikely+0x2c44): Section mismatch in reference from the
 function trace_define_generic_fields() to the variable
 .init.data:initcall_level_names
To:     Steven Rostedt <rostedt@goodmis.org>,
        kernel test robot <lkp@intel.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
References: <202112210114.CFpCHRci-lkp@intel.com>
 <20220110185100.6c4c226c@gandalf.local.home>
From:   "Chen, Rong A" <rong.a.chen@intel.com>
Message-ID: <cea7d17b-1994-e2cb-7580-4bd2f287ebdd@intel.com>
Date:   Mon, 17 Jan 2022 16:32:38 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20220110185100.6c4c226c@gandalf.local.home>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/11/2022 7:51 AM, Steven Rostedt wrote:
> On Tue, 21 Dec 2021 01:12:12 +0800
> kernel test robot <lkp@intel.com> wrote:
> 
>> All warnings (new ones prefixed by >>, old ones prefixed by <<):
>>
>>>> WARNING: modpost: vmlinux.o(.text.unlikely+0x2c44): Section mismatch in reference from the function trace_define_generic_fields() to the variable .init.data:initcall_level_names
>> The function trace_define_generic_fields() references
>> the variable __initdata initcall_level_names.
>> This is often because trace_define_generic_fields lacks a __initdata
>> annotation or the annotation of initcall_level_names is wrong.
> 
> I keep getting this, and it looks like a bug in the compiler not the kernel
> code.
> 
> We have:
> 
> int filter_assign_type(const char *type)
> {
> 	if (strstr(type, "__data_loc") && strstr(type, "char"))
> 		return FILTER_DYN_STRING;
> 
> 	if (strstr(type, "__rel_loc") && strstr(type, "char"))
> 		return FILTER_RDYN_STRING;
> 
> 	if (strchr(type, '[') && strstr(type, "char"))
> 		return FILTER_STATIC_STRING;
> 
> 	if (strcmp(type, "char *") == 0 || strcmp(type, "const char *") == 0)
> 		return FILTER_PTR_STRING;
> 
> 	return FILTER_OTHER;
> }
> 
> static int __trace_define_field(struct list_head *head, const char *type,
> 				const char *name, int offset, int size,
> 				int is_signed, int filter_type)
> {
> 	struct ftrace_event_field *field;
> 
> 	field = kmem_cache_alloc(field_cachep, GFP_TRACE);
> 	if (!field)
> 		return -ENOMEM;
> 
> 	field->name = name;
> 	field->type = type;
> 
> 	if (filter_type == FILTER_OTHER)
> 		field->filter_type = filter_assign_type(type);
> 	else
> 		field->filter_type = filter_type;
> 
> 	field->offset = offset;
> 	field->size = size;
> 	field->is_signed = is_signed;
> 
> 	list_add(&field->link, head);
> 
> 	return 0;
> }
> 
> #define is_signed_type(type)	(((type)(-1)) < (type)1)
> 
> static LIST_HEAD(ftrace_generic_fields);
> 
> #define __generic_field(type, item, filter_type)			\
> 	ret = __trace_define_field(&ftrace_generic_fields, #type,	\
> 				   #item, 0, 0, is_signed_type(type),	\
> 				   filter_type);			\
> 	if (ret)							\
> 		return ret;
> 
> 
> static int trace_define_generic_fields(void)
> {
> 	int ret;
> 
> 	__generic_field(int, CPU, FILTER_CPU);
> 	__generic_field(int, cpu, FILTER_CPU);
> 	__generic_field(char *, COMM, FILTER_COMM);
> 	__generic_field(char *, comm, FILTER_COMM);
> 
> 	return ret;
> }
> 
> 
> Please tell me where initcall_level_names is being referenced?
> 
> Either fix the compiler or tell me exactly what the bug is. Otherwise, stop
> sending me this.
> 
> -- Steve

Hi Steve,

I'm not familiar with the code, the warning can be silenced with the 
below change:

--- a/kernel/trace/trace_events.c
+++ b/kernel/trace/trace_events.c
@@ -162,7 +162,7 @@ EXPORT_SYMBOL_GPL(trace_define_field);
         if (ret)                                                        \
                 return ret;

-static int trace_define_generic_fields(void)
+static __init int trace_define_generic_fields(void)
  {
         int ret;

@@ -174,7 +174,7 @@ static int trace_define_generic_fields(void)
         return ret;
  }

-static int trace_define_common_fields(void)
+static __init int trace_define_common_fields(void)
  {
         int ret;
         struct trace_entry ent;

If the warning can't be fixed, we'll add the warning to the ignore list.

Best Regards,
Rong Chen
