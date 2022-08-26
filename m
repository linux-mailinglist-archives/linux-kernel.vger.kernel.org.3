Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 357E35A3238
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Aug 2022 00:49:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345390AbiHZWsw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Aug 2022 18:48:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344711AbiHZWst (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Aug 2022 18:48:49 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3928E9279;
        Fri, 26 Aug 2022 15:48:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661554128; x=1693090128;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=jMituVpkGi3k1+Nche8Hgl4KTD1RuXeor1WtiNrz3gA=;
  b=MthOyyN3Q7OnkqIL6BFVe7g7tevOv7xATiiuP3ev3gcup6jLgxVh98pG
   kWmZWIVfMsJJ1h4Rq7lTbZe+aBHhCgq5MZOwddPsFTxnSvyn9J0houJSx
   7VBQGyR0vWKxJfNJk0twOEwaw2rt6bcAV8LcM3gi+SBR+hHNe0CiBOGqv
   NpcNOIDqmnMUM4xIyftagOysXsTmYm/wXFIWpEojFudeKWcL2Koxr2Zk2
   c+DjBuoSxaYGhNSlMud+U1avz+c9tFlm99jlRQ1Yd/qHVNXNXTegXAmkX
   X1NI0ZuLOP9oD48E13IHvJ44NromcFd/HevScFN19Mv+NdOVK+MrchNC+
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10451"; a="292187442"
X-IronPort-AV: E=Sophos;i="5.93,266,1654585200"; 
   d="scan'208";a="292187442"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2022 15:48:44 -0700
X-IronPort-AV: E=Sophos;i="5.93,266,1654585200"; 
   d="scan'208";a="587463787"
Received: from djiang5-mobl1.amr.corp.intel.com (HELO [10.212.32.23]) ([10.212.32.23])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2022 15:48:43 -0700
Message-ID: <f543e2a4-1994-bd53-b60d-206c1e3c0726@intel.com>
Date:   Fri, 26 Aug 2022 15:48:42 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.2.0
Subject: Re: [PATCH] tracepoint: Allow trace events in modules with TAINT_TEST
Content-Language: en-US
To:     alison.schofield@intel.com, Steven Rostedt <rostedt@goodmis.org>
Cc:     linux-kernel@vger.kernel.org, linux-cxl@vger.kernel.org,
        Ira Weiny <ira.weiny@intel.com>,
        Dan Williams <dan.j.williams@intel.com>
References: <20220826223511.170256-1-alison.schofield@intel.com>
From:   Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20220826223511.170256-1-alison.schofield@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 8/26/2022 3:35 PM, alison.schofield@intel.com wrote:
> From: Alison Schofield <alison.schofield@intel.com>
>
> Commit 2852ca7fba9f ("panic: Taint kernel if tests are run")
> introduced a new taint type, TAINT_TEST, to signal that an
> in-kernel test has been run.

has been loaded?

>
> TAINT_TEST taint type defaults into a 'bad_taint' list for
> kernel tracing and blocks the creation of trace events. This
> causes a problem for CXL testing where loading the cxl_test
> module makes all CXL modules out-of-tree, blocking any trace
> events.
>
> Trace events are in development for CXL at the moment and this
> issue was found in test with v6.0-rc1.
>
> Reported-by: Ira Weiny <ira.weiny@intel.com>
> Suggested-by: Dan Williams <dan.j.williams@intel.com>
> Signed-off-by: Alison Schofield <alison.schofield@intel.com>
> ---
>   kernel/tracepoint.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/kernel/tracepoint.c b/kernel/tracepoint.c
> index 64ea283f2f86..5f17378c9dc2 100644
> --- a/kernel/tracepoint.c
> +++ b/kernel/tracepoint.c
> @@ -571,7 +571,8 @@ static void for_each_tracepoint_range(
>   bool trace_module_has_bad_taint(struct module *mod)
>   {
>   	return mod->taints & ~((1 << TAINT_OOT_MODULE) | (1 << TAINT_CRAP) |
> -			       (1 << TAINT_UNSIGNED_MODULE));
> +			       (1 << TAINT_UNSIGNED_MODULE) |
> +			       (1 << TAINT_TEST));
>   }
>   
>   static BLOCKING_NOTIFIER_HEAD(tracepoint_notify_list);
>
> base-commit: 4c612826bec1441214816827979b62f84a097e91
