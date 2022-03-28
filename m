Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A7C64E8C4E
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Mar 2022 04:49:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237680AbiC1CvB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Mar 2022 22:51:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237678AbiC1Cu6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Mar 2022 22:50:58 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5AD742EFB
        for <linux-kernel@vger.kernel.org>; Sun, 27 Mar 2022 19:49:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1648435759; x=1679971759;
  h=message-id:date:mime-version:to:cc:references:from:
   subject:in-reply-to:content-transfer-encoding;
  bh=9rqPqfcIa1ccW3H6rOJaZsgeTrXk813nKYlbyrcSd64=;
  b=d0Su/EWdsBrfk6mYQFxuouRgXE2oeqiMQ78xUekp41KRQ0K8ljl7oUUz
   ibw2qAiFUkcuP9wriGi+fOt6Gsyoih99lqTOfUq2WWEj6QbvlgmsPVkSL
   7NOwCix3iw6YmJM7mWIBSNSUT26ovFk7nQXBNnjVZ9DRkTzQtRhOPex7D
   j2NSp6oPttZbJ/S5nOUX09/uJMBI040cyUIWqS6sazphbHXdOmof3ba0a
   U+pWfouyQSiGVAMlt3seP251p/xNKKXCJ2s9ESlvam7MwVFweyQt+hOLy
   gfbwL7OKG6wiwqgDigDrcAzmfon6LaeJt+KRlcWfN8VcI8/72n8/U6jEj
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10299"; a="345334471"
X-IronPort-AV: E=Sophos;i="5.90,216,1643702400"; 
   d="scan'208";a="345334471"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Mar 2022 19:49:19 -0700
X-IronPort-AV: E=Sophos;i="5.90,216,1643702400"; 
   d="scan'208";a="520833975"
Received: from crjohnso-mobl.amr.corp.intel.com (HELO [10.209.122.14]) ([10.209.122.14])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Mar 2022 19:49:19 -0700
Message-ID: <347c75b8-3a48-0758-892a-0d0ac139f740@intel.com>
Date:   Sun, 27 Mar 2022 19:49:19 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Content-Language: en-US
To:     Haowen Bai <baihaowen@meizu.com>, dave.hansen@linux.intel.com,
        luto@kernel.org, peterz@infradead.org
Cc:     linux-kernel@vger.kernel.org
References: <1648433573-25735-1-git-send-email-baihaowen@meizu.com>
From:   Dave Hansen <dave.hansen@intel.com>
Subject: Re: [PATCH] x86/mm: Directly return instead of using local ret
 variable
In-Reply-To: <1648433573-25735-1-git-send-email-baihaowen@meizu.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/27/22 19:12, Haowen Bai wrote:
> 
> diff --git a/arch/x86/mm/pf_in.c b/arch/x86/mm/pf_in.c
> index 3f83e31..4eff3ee 100644
> --- a/arch/x86/mm/pf_in.c
> +++ b/arch/x86/mm/pf_in.c
> @@ -130,7 +130,6 @@ enum reason_type get_ins_type(unsigned long ins_addr)
>  	unsigned char *p;
>  	struct prefix_bits prf;
>  	int i;
> -	enum reason_type rv = OTHERS;
>  
>  	p = (unsigned char *)ins_addr;
>  	p += skip_prefix(p, &prf);
> @@ -141,7 +140,7 @@ enum reason_type get_ins_type(unsigned long ins_addr)
>  	CHECK_OP_TYPE(opcode, imm_wop, IMM_WRITE);
>  
>  exit:
> -	return rv;
> +	return OTHERS;
>  }
>  #undef CHECK_OP_TYPE
>  

Does this even compile?  Take a look at this macro:

> #define CHECK_OP_TYPE(opcode, array, type) \
>         for (i = 0; i < ARRAY_SIZE(array); i++) { \
>                 if (array[i] == opcode) { \
>                         rv = type; \
>                         goto exit; \
>                 } \

It uses 'rv'.

