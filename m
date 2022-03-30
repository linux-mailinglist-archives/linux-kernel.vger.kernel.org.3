Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F5424EC6ED
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Mar 2022 16:44:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347215AbiC3OqL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Mar 2022 10:46:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347210AbiC3OqG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Mar 2022 10:46:06 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68D02D5EB0
        for <linux-kernel@vger.kernel.org>; Wed, 30 Mar 2022 07:44:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1648651451; x=1680187451;
  h=message-id:date:mime-version:to:cc:references:from:
   subject:in-reply-to:content-transfer-encoding;
  bh=FbSCiPRXnQn6ntRW3KG9zUq12rhe3a5DhU5jjWuzQQc=;
  b=M8pg0nfvxK8VcOCpqqtfk+/P6Jmb7DrmoONvMWL4/DYSDB8idAArwGQd
   M/M7KNGrlNrd74IL9Q7QWnqPnp3iCE+a2MJCx9UD9TgUy0yQVZlNhd63q
   rgHD37n++Aws2XnWXnG5m6pvkO9hEvqBc8dAL2Yqu8o+MkuKw4qEank83
   KDvkuvNZ4AHquzapFbpOOD0YUrt4wkdWsuoKTb+4X2MD7w/XqJDMpi322
   h8nkz8xI2EYT7uwhySqaCfYJMJjeFMWR32W64ZM2DJYd7iTo2Y6fOA2uh
   qNEBB5JNap+PguDdfZISaX/rph2Dn6qFXz2FfEBwJFJRf+LyWMD105o7k
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10301"; a="322739180"
X-IronPort-AV: E=Sophos;i="5.90,222,1643702400"; 
   d="scan'208";a="322739180"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Mar 2022 07:44:10 -0700
X-IronPort-AV: E=Sophos;i="5.90,222,1643702400"; 
   d="scan'208";a="586023829"
Received: from amahade1-mobl2.amr.corp.intel.com (HELO [10.209.45.250]) ([10.209.45.250])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Mar 2022 07:44:10 -0700
Message-ID: <6e8f0e63-5e21-3694-3e76-290e3fe58e9d@intel.com>
Date:   Wed, 30 Mar 2022 07:44:14 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Content-Language: en-US
To:     Matthias Welwarsky <matthias.welwarsky@sysgo.com>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org, x86-ml <x86@kernel.org>
References: <3422754.iIbC2pHGDl@linux-3513> <3346653.QJadu78ljV@linux-3513>
 <066bbff7-d2fe-44d3-0245-ccbcb5990257@intel.com>
 <3160482.aeNJFYEL58@linux-3513>
From:   Dave Hansen <dave.hansen@intel.com>
Subject: Re: x86, possible bug in __memmove() alternatives patching
In-Reply-To: <3160482.aeNJFYEL58@linux-3513>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/30/22 06:56, Matthias Welwarsky wrote:
> 
> Here's the relevant bits:
> 
>         /* FSRM implies ERMS => no length checks, do the copy directly */
> .Lmemmove_begin_forward:
>         ALTERNATIVE "cmp $0x20, %rdx; jb 1f", "", X86_FEATURE_FSRM
>         ALTERNATIVE "", __stringify(movq %rdx, %rcx; rep movsb; RET), 
> X86_FEATURE_ERMS
> 
> If FSRM is there but ERMS isn't, the first ALTERNATIVE is activated but not 
> the second one. That means the length check (< 32) and subsequent "jb 1f" is 
> suppressed but the "movq %rdx, %rcx; rep movsb; RET" is also not there. 

Ahh, thanks for the explanation.  It would help if I wasn't reading the
code wrong.

> I'll send a patch. I think the same rationale applies to FSRM as to ERMS, 
> which gets manually cleared when IA32_MISC_ENABLE says that fast string ops 
> are not available. It will be a one liner added to the dependency table in 
> cpu-deps.c, making FSRM depend on ERMS so that it gets automatically cleared.

Sounds good.  Could you also add some of that explanation to a comment
__memmove and basically say that the code is broken if the dependency
isn't enforced?
