Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D3D24833BD
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jan 2022 15:47:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232478AbiACOrt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jan 2022 09:47:49 -0500
Received: from mga07.intel.com ([134.134.136.100]:56878 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232455AbiACOrq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jan 2022 09:47:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1641221266; x=1672757266;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=znrP2i87MLLUcp7H2Vnbtzt9yBXPSnogxgYGZPk7/Eg=;
  b=mLWL3mMBH0VdrIIU0CbZkM21Wz9AQjg3ubeZz9zbRfP1FJ+QWaa6t+g+
   5R36RfarE5RWYkCjJo/DC23vpqnCrkbpaUBvXouXutByWSp2EskC5kjuW
   mtLqgFVbr1fPNs0pKGsF76bDv8nU/2GSSJXxGmO81flh9q+rZS/ZzAk+X
   gtOZyF+kF6nKYzuaASzy+gb2f2RQx9a2QKPJzuxYNq5mhSGxwIJPDKH/1
   F12WYx3TniSph+crwl7EgalVAoCejxecD3SqzCyRK4hIwJAL/ulgd0f46
   DLiH8kUK5bqXoWBP97pWnWgkwWYbkbhToxC9mvxZLrYj8azAeN5e94PVH
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10215"; a="305425389"
X-IronPort-AV: E=Sophos;i="5.88,258,1635231600"; 
   d="scan'208";a="305425389"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jan 2022 06:47:45 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,258,1635231600"; 
   d="scan'208";a="760111132"
Received: from irvmail001.ir.intel.com ([10.43.11.63])
  by fmsmga006.fm.intel.com with ESMTP; 03 Jan 2022 06:47:42 -0800
Received: from newjersey.igk.intel.com (newjersey.igk.intel.com [10.102.20.203])
        by irvmail001.ir.intel.com (8.14.3/8.13.6/MailSET/Hub) with ESMTP id 203ElfGx009815;
        Mon, 3 Jan 2022 14:47:41 GMT
From:   Alexander Lobakin <alexandr.lobakin@intel.com>
To:     cgel.zte@gmail.com
Cc:     Alexander Lobakin <alexandr.lobakin@intel.com>,
        torvalds@linux-foundation.org, nathan@kernel.org,
        ndesaulniers@google.com, keescook@chromium.org,
        wang.yong12@zte.com.cn, xu.xin16@zte.com.cn,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
        Zeal Robot <zealci@zte.com.cn>
Subject: Re: [PATCH linux-next] tools: compiler-gcc.h: Keep compatible with older GCC versions
Date:   Mon,  3 Jan 2022 15:46:35 +0100
Message-Id: <20220103144635.5952-1-alexandr.lobakin@intel.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20220102120201.594408-1-xu.xin16@zte.com.cn>
References: <20220102120201.594408-1-xu.xin16@zte.com.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: cgel.zte@gmail.com
Date: Sun,  2 Jan 2022 12:02:01 +0000

> From: xu xin <xu.xin16@zte.com.cn>
> 
> When HOST CC = gcc (GCC) 4.8.5, we found that there is an error occurring:
                           ^^^^^

From [0]:

Program  Minimal version
GNU C    5.1

This applies to both HOSTCC and CC.

> Undefined __has_attribute as we built the whole kernel and tools.
> 
> To solve this, this patch is given to keep the compatibility with older
> GCC versions.
> 
> Reported-by: Zeal Robot <zealci@zte.com.cn>
> Co-developed-by: wangyong <wang.yong12@zte.com.cn>
> Signed-off-by: xu xin <xu.xin16@zte.com.cn>
> ---
>  tools/include/linux/compiler-gcc.h | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/tools/include/linux/compiler-gcc.h b/tools/include/linux/compiler-gcc.h
> index 8816f06fc6c7..333ed16b3b12 100644
> --- a/tools/include/linux/compiler-gcc.h
> +++ b/tools/include/linux/compiler-gcc.h
> @@ -16,6 +16,10 @@
>  # define __fallthrough __attribute__ ((fallthrough))
>  #endif
>  
> +#ifndef __has_attribute
> +# define __has_attribute(x) 0  /* Compatibility with GCC versions < 5.x */
> +#endif
> +
>  #if __has_attribute(__error__)
>  # define __compiletime_error(message) __attribute__((error(message)))
>  #endif
> -- 
> 2.25.1

[0] https://elixir.bootlin.com/linux/v5.16-rc8/source/Documentation/process/changes.rst#L32

Al
