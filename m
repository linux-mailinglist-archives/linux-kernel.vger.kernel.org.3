Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0094A50E2BA
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 16:10:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229570AbiDYONp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 10:13:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232506AbiDYONd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 10:13:33 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 473C51135;
        Mon, 25 Apr 2022 07:10:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650895829; x=1682431829;
  h=message-id:subject:from:reply-to:to:cc:date:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=I6pbNh7Vvjp6206TEWobvDHIwjXcGBl7BZL/qhyjK3o=;
  b=KVQJZcffmZr/BVgpl73cx7FLmQUhXCbEK9ka8RHzq/zz/WLyv989Wqck
   j5HEjTrc6bOU3CJmgAI4CF+b+4ncHxgj7CgAOrXWiTTvCNadwIG33YraI
   ery7CWr1+mdSFUssM8WkcfRUi227ggQd9LlbH+FHtr7PUSXyZKOma6PE9
   OgSpkE9ohKAm/x4ofPHjCjf/BKLsBePaKKiG6ICMsJhSTEqKdhAE8mwOB
   D1TyqlIjNz3H4ObFWm/l21ltAL9JhOO8efVxmZrmBVdVc9QpXXdA5So/7
   V48sfDRgaFtEusUANwZReMCcsk0VpbJH5tw76uhxNj0whf54rrO88Lglw
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10328"; a="290394809"
X-IronPort-AV: E=Sophos;i="5.90,288,1643702400"; 
   d="scan'208";a="290394809"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Apr 2022 07:10:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,288,1643702400"; 
   d="scan'208";a="537556753"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga002.jf.intel.com with ESMTP; 25 Apr 2022 07:10:28 -0700
Received: from jiunhong-mobl.amr.corp.intel.com (jiunhong-mobl.amr.corp.intel.com [10.209.83.58])
        by linux.intel.com (Postfix) with ESMTP id 930CC5809EB;
        Mon, 25 Apr 2022 07:10:28 -0700 (PDT)
Message-ID: <ccc214492fb66bfec88a9aec516e4cbeff80eb99.camel@linux.intel.com>
Subject: Re: [PATCH] platform/x86/intel: pmc/core: change pmc_lpm_modes to
 static
From:   "David E. Box" <david.e.box@linux.intel.com>
Reply-To: david.e.box@linux.intel.com
To:     Tom Rix <trix@redhat.com>, irenic.rajneesh@gmail.com,
        david.e.box@intel.com, hdegoede@redhat.com, markgross@kernel.org
Cc:     platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Mon, 25 Apr 2022 07:10:28 -0700
In-Reply-To: <20220423123048.591405-1-trix@redhat.com>
References: <20220423123048.591405-1-trix@redhat.com>
Organization: David E. Box
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2022-04-23 at 08:30 -0400, Tom Rix wrote:
> Sparse reports this issue
> core.c: note: in included file:
> core.h:239:12: warning: symbol 'pmc_lpm_modes' was not declared. Should it be
> static?
> 
> Global variables should not be defined in headers.  This only works
> because core.h is only included by core.c. Single file use
> variables should be static, so change its storage-class specifier
> to static.
> 
> Signed-off-by: Tom Rix <trix@redhat.com>

Reviewed-by: David E. Box <david.e.box@linux.intel.com>

Thanks

> ---
>  drivers/platform/x86/intel/pmc/core.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/platform/x86/intel/pmc/core.h
> b/drivers/platform/x86/intel/pmc/core.h
> index a46d3b53bf61..7a059e02c265 100644
> --- a/drivers/platform/x86/intel/pmc/core.h
> +++ b/drivers/platform/x86/intel/pmc/core.h
> @@ -236,7 +236,7 @@ enum ppfear_regs {
>  #define ADL_LPM_STATUS_LATCH_EN_OFFSET		0x1704
>  #define ADL_LPM_LIVE_STATUS_OFFSET		0x1764
>  
> -const char *pmc_lpm_modes[] = {
> +static const char *pmc_lpm_modes[] = {
>  	"S0i2.0",
>  	"S0i2.1",
>  	"S0i2.2",

