Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C3E258CCE8
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Aug 2022 19:44:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244339AbiHHRoJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Aug 2022 13:44:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244343AbiHHRnf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Aug 2022 13:43:35 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC355B51
        for <linux-kernel@vger.kernel.org>; Mon,  8 Aug 2022 10:43:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659980614; x=1691516614;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=eZHz5AZts8pa+4dAgLDzj+RDlAzwOdbJVrXvXp0Rcms=;
  b=WfL43eYuI3KWCs5hUgkt+oYHtcri+hAusIikoE4nQd7hW7eQOSV/U/zl
   aIj4HPf0AZ1kGVWpxjrcZBReISUp5iIsiBfAdgZ1Y4jN0XKJTwkPTv8/j
   Lc8A/t04jO9AthfJItzKuBXslRCm/SGsRnuXtpv//wIjYE5qFdp8pJReS
   OJl/amiW7l6A4OouBVNwKyvdOdpiIaPD+lftPTIiY7L2TdGb+NRbHbFR/
   vWXh11Gn+wx6fE/wPL+hGAo9KkOqKEgW+EdVB5bPz5y8vp95zOsPsKEb0
   EPKjnFYoj5yJ/0bkIZVFHHv5IoLhT9S/aWTrtiId5wMb3RIJNM+connEI
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10433"; a="273703180"
X-IronPort-AV: E=Sophos;i="5.93,222,1654585200"; 
   d="scan'208";a="273703180"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Aug 2022 10:43:34 -0700
X-IronPort-AV: E=Sophos;i="5.93,222,1654585200"; 
   d="scan'208";a="604452861"
Received: from sankarka-mobl1.amr.corp.intel.com (HELO [10.212.251.15]) ([10.212.251.15])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Aug 2022 10:43:34 -0700
Message-ID: <b929e415-def2-b47b-fd1e-57877a98c2ad@intel.com>
Date:   Mon, 8 Aug 2022 10:43:35 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [RFC PATCH 1/5] entry: Pass pt_regs to
 irqentry_exit_cond_resched()
Content-Language: en-US
To:     Borislav Petkov <bp@alien8.de>, Ira Weiny <ira.weiny@intel.com>
Cc:     Rik van Riel <riel@surriel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, kernel-team@fb.com
References: <20220805173009.3128098-1-ira.weiny@intel.com>
 <20220805173009.3128098-2-ira.weiny@intel.com> <YvDnkALyHl77R/Ug@zn.tnic>
 <YvFJGxU0k492npYT@iweiny-desk3> <YvFKHaRdOkg5RHtv@zn.tnic>
From:   Dave Hansen <dave.hansen@intel.com>
In-Reply-To: <YvFKHaRdOkg5RHtv@zn.tnic>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/8/22 10:38, Borislav Petkov wrote:
> On Mon, Aug 08, 2022 at 10:34:19AM -0700, Ira Weiny wrote:
>> I thought about that but generally have been steered away from using bool
>> arguments like this.
> The reason being?

Might have been me.  Function calls that look like this:

	foo(&ptr, false, true, false, true, 1, 0);

are incomprehensible.  A true/false is effectively a magic number here
and you have to go looking at the code implementing 'foo()' or at least
the declaration hoping that the variable names help (if the declaration
has variable names).

I think I've encouraged Ira to do something like this instead:

enum foo_mode {
	MODE_BAR,
	MODE_BAZ
}

where the call ends up looking like:

	foo(&ptr, MODE_BAR);

which is much more self-documenting.
