Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1AFCC5AB674
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Sep 2022 18:26:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235713AbiIBQ0g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Sep 2022 12:26:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235064AbiIBQ0c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Sep 2022 12:26:32 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D202295AEA;
        Fri,  2 Sep 2022 09:26:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662135991; x=1693671991;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=+zsnx7XILF5i1LZxX69+MDnUgD+gGFY/9ckzzb8j+iU=;
  b=MK1KKAKy7jn9BOl9kV8eOkEPXZkNG4yfFKmVNeWxAQMa7HEeTGnbUr1V
   mKS4VfenuvKnfcWFaG0kPNpIT8rNSvmGBK3/CUPDZgnxqQz7t3PN8TVyF
   WQGZpD3iLDtbE8FhSQocAsoLfaIl5X3tGnYPB6uCSaRVcQ4stqRrYi/qy
   GNU4+z7cGn4TBxYJ+HqVRdyFjNjiMCix1K6KZfLRThkhuRl5vCa2cr8/B
   8q5wuLZCDv9cgftCPtHvCEouoCXW8xEFpHVNSw4aF2T3h84L8hzrshS4k
   +V27RXipc63iinPIkTG87vV0wJbIjeRcnyf2WP0V0PyOL74IrMqzK5KXg
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10458"; a="293596371"
X-IronPort-AV: E=Sophos;i="5.93,283,1654585200"; 
   d="scan'208";a="293596371"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2022 09:08:47 -0700
X-IronPort-AV: E=Sophos;i="5.93,283,1654585200"; 
   d="scan'208";a="674406814"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.252.42.34])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2022 09:08:44 -0700
Message-ID: <8ed21b90-07e5-f611-2a7c-ce185c4d2a8c@intel.com>
Date:   Fri, 2 Sep 2022 19:08:38 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.11.0
Subject: Re: perf record --kcore does not work when /proc/modules changed
 during copy
Content-Language: en-US
To:     Daniel Dao <dqminh@cloudflare.com>, acme@kernel.org,
        linux-perf-users@vger.kernel.org,
        kernel-team <kernel-team@cloudflare.com>,
        linux-kernel <linux-kernel@vger.kernel.org>, jolsa@redhat.com,
        namhyung@kernel.org
References: <CA+wXwBT_fiBrFG-=C=eWGHuJ3XzxDLe-Ba4ybOvuxvu5A1+Tig@mail.gmail.com>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <CA+wXwBT_fiBrFG-=C=eWGHuJ3XzxDLe-Ba4ybOvuxvu5A1+Tig@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
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

On 2/09/22 18:46, Daniel Dao wrote:
> Hi Perf tools maintainers,
> 
> `perf record --kcore` frequently did not work on a somewhat busy system.
> For example:
> 
>   sudo perf record --kcore -- sleep 1
>   ERROR: Failed to copy kcore
> 
> Using strace to look at the invocation, the failure looks like:
> 
>   ...
>   openat(AT_FDCWD, "/proc/modules", O_RDONLY) = 56
>   openat(AT_FDCWD, "perf.data/kcore_dir/modules", O_RDONLY) = 57
>   read(56, "mpls_gso 16384 0 - Live 0xffffff"..., 4096) = 4070
>   read(57, "mpls_gso 16384 0 - Live 0xffffff"..., 4070) = 4070
>   read(56, "xt_conntrack 24576 22 - Live 0xf"..., 4096) = 3738
>   read(57, "xt_conntrack 24576 22 - Live 0xf"..., 3738) = 3738
>   close(57)                               = 0
>   close(56)                               = 0
>   close(55)                               = 0
>   unlink("perf.data/kcore_dir/kcore")     = 0
>   close(54)                               = 0
>   unlink("perf.data/kcore_dir/modules")   = 0
>   unlink("perf.data/kcore_dir/kallsyms")  = 0
>   write(2, "ERROR: Failed to copy kcore\n", 28ERROR: Failed to copy kcore
>   ...
> 
> We can see that the verification of proc/modules failed because /proc/modules
> output changed after we copied kcore. When i looked at it, they are caused by
> changes of module refcount which seems expected on busy systems, such as
> 
>   < tcp_bbr 40960 12644 - Live 0x0000000000000000
>   ---
>   > tcp_bbr 40960 12678 - Live 0x0000000000000000
> 
> Any suggestions on how to make this work is much appreciated.

At the moment I can't think why the proc/modules file needs to be
compared at all since we also compare proc/kallsyms which should be
enough.
