Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1392D557D81
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jun 2022 16:07:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231816AbiFWOHE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jun 2022 10:07:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231583AbiFWOHD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jun 2022 10:07:03 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86D873E5F2;
        Thu, 23 Jun 2022 07:07:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655993222; x=1687529222;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=UIe0eFgVy7RvJql1SxjU8dfvbq7qXdulL0n2hKPyi9s=;
  b=epYEfu8bee/lJsKpRmxDz8VhMjBW31DRj3kouIQ6y8Bun5iW5352aKar
   3wGb6Bq87ydvRstWLc69Jtcg9e7YEnjaLeTe+pqD+xSRZEKG6/B3AfXvU
   zc5vs9pCPcGu6qf3G+DdkF/QLVzL4RsfJqhz+BXMesDBjWOguaBvpwguU
   ZsaM/YGjCnD29vki9BsfwE6SdeF4qy6GxxfSY+BN9ZnqHyymwJMvqGBY2
   zvnPOqpOZxXQuEKduU73/7/ChxRS4o4RkaC83++IUFkH/o/cb64yqkUft
   auryNRCoJej+E9zaWiZQzBw7vkiJAHaS/nawTOwH0owOI5GcdrxCVm43p
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10386"; a="279495397"
X-IronPort-AV: E=Sophos;i="5.92,216,1650956400"; 
   d="scan'208";a="279495397"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2022 07:07:02 -0700
X-IronPort-AV: E=Sophos;i="5.92,216,1650956400"; 
   d="scan'208";a="730869606"
Received: from davidsma-mobl2.amr.corp.intel.com (HELO [10.209.126.175]) ([10.209.126.175])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2022 07:07:01 -0700
Message-ID: <de2500c4-fce4-31dc-29bc-aa3007027eb9@intel.com>
Date:   Thu, 23 Jun 2022 07:06:36 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [RFC] memmap: introduce cmdline parameter "memmap=nn[KMG]$"
 without start addr
Content-Language: en-US
To:     lizhe.67@bytedance.com, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org,
        hpa@zytor.com
Cc:     lizefan.x@bytedance.com, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220623062402.12392-1-lizhe.67@bytedance.com>
From:   Dave Hansen <dave.hansen@intel.com>
In-Reply-To: <20220623062402.12392-1-lizhe.67@bytedance.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/22/22 23:24, lizhe.67@bytedance.com wrote:
> In our scenario, we need reserve or alloc large continous memory like
> 256M in machine which have different memory specification at just
> boot phase for a user land process.

Just marking the memory reserved doesn't do any good by itself.  There
must be some *other* kernel code to find this reserved area and make it
available to userspace.

It seems kinda silly to add this to the kernel without also adding the
other half of the solution.  Plus, we don't really even know what this
is for.  Are there other, better solutions?  I certainly can't offer any
because this changelog did not provide a full picture of the problem
this solves.
