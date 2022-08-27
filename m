Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE0F55A32DA
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Aug 2022 02:02:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344803AbiH0ACJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Aug 2022 20:02:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241925AbiH0ACH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Aug 2022 20:02:07 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4353E58BB;
        Fri, 26 Aug 2022 17:02:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661558525; x=1693094525;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=SkUk/earvrI4Mk539WgoAWpm1Lwgqi1nI/36sw2BwJE=;
  b=aXlfouW/f6LWKDXeVcv17D/8ttPBqIhWwu9opXeqaXv8fCvGbWoAFxk5
   Jb2r/mD7GNAEjZoWgsSONaBdjObUcIziuqdJcP97mmxPrQ2tUOiZpoNKG
   s0aGtXoCGmL2UxGrc5v1tAGgUaQCnyyAuf149KAHy0gNe3Ud586LiCoEJ
   6ZaR41HIUQfmAPYruqkSt2ERDEjuSXhe1KX+aOjRxgnFda3abCuiADLq9
   VtBKafSYKiYgNYWCw4HnPxpQTa0Z4/5AESnHhbyc5ffl4l2/mwtfURK4e
   MaRkOQvYy1EVpj0l4N5Viw1tgI5S4nm2Ntpy4V9SDudimwd7wJfuVOssI
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10451"; a="293361293"
X-IronPort-AV: E=Sophos;i="5.93,266,1654585200"; 
   d="scan'208";a="293361293"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2022 17:02:05 -0700
X-IronPort-AV: E=Sophos;i="5.93,266,1654585200"; 
   d="scan'208";a="679034852"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO aschofie-mobl2) ([10.209.82.226])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2022 17:02:04 -0700
Date:   Fri, 26 Aug 2022 17:02:03 -0700
From:   Alison Schofield <alison.schofield@intel.com>
To:     Steven Rostedt <rostedt@goodmis.org>,
        David Gow <davidgow@google.com>
Cc:     linux-kernel@vger.kernel.org, linux-cxl@vger.kernel.org,
        Ira Weiny <ira.weiny@intel.com>,
        Dan Williams <dan.j.williams@intel.com>
Subject: Re: [PATCH] tracepoint: Allow trace events in modules with TAINT_TEST
Message-ID: <Ywle+96kZr5Y6Kn/@aschofie-mobl2>
References: <20220826223511.170256-1-alison.schofield@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220826223511.170256-1-alison.schofield@intel.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+ David Gow - Submitter of the new taint type

On Fri, Aug 26, 2022 at 03:35:11PM -0700, alison.schofield@intel.com wrote:
> From: Alison Schofield <alison.schofield@intel.com>
> 
> Commit 2852ca7fba9f ("panic: Taint kernel if tests are run")
> introduced a new taint type, TAINT_TEST, to signal that an
> in-kernel test has been run.
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
>  kernel/tracepoint.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/tracepoint.c b/kernel/tracepoint.c
> index 64ea283f2f86..5f17378c9dc2 100644
> --- a/kernel/tracepoint.c
> +++ b/kernel/tracepoint.c
> @@ -571,7 +571,8 @@ static void for_each_tracepoint_range(
>  bool trace_module_has_bad_taint(struct module *mod)
>  {
>  	return mod->taints & ~((1 << TAINT_OOT_MODULE) | (1 << TAINT_CRAP) |
> -			       (1 << TAINT_UNSIGNED_MODULE));
> +			       (1 << TAINT_UNSIGNED_MODULE) |
> +			       (1 << TAINT_TEST));
>  }
>  
>  static BLOCKING_NOTIFIER_HEAD(tracepoint_notify_list);
> 
> base-commit: 4c612826bec1441214816827979b62f84a097e91
> -- 
> 2.31.1
> 
