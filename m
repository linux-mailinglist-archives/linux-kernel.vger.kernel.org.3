Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC3005ADDE6
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 05:20:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232901AbiIFDUa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Sep 2022 23:20:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235598AbiIFDUV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Sep 2022 23:20:21 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4673B14D29;
        Mon,  5 Sep 2022 20:20:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662434420; x=1693970420;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=St4AWElOacYvJYJ/oLQtI2v0xDseWEsRsdNyTu/rhRA=;
  b=hNDbsZukWnZcb78K0XKyGeeaYYbmau1fb9q+PmGyJzcolMV4J5g4Lo4b
   0dQfK6bRELXUQeKnQOPHIemOZXjHPYFMVqbpibT7jxOALldYkffhyGoDP
   GIraIDNYDde/hAb57O8tjLHNg35tzOERGjCNQi/1HlW4FgdkjrrhKR8QZ
   ss/6smKa5agt3l6NESajhJGnO7ULNjqnnqQbohHtC9yYzZW6TMcT3o3xb
   7r4X1k2bOmQ/WP0iBuTJ6MD39BFX302Ein5HDPtONjpd2SfSavA5PlTm/
   XFzDED3vQR3od5ABB4STWlguC6YShH9JVajCEeEMTySyBBIEFQpGIGCYd
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10461"; a="294076006"
X-IronPort-AV: E=Sophos;i="5.93,293,1654585200"; 
   d="scan'208";a="294076006"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Sep 2022 20:20:20 -0700
X-IronPort-AV: E=Sophos;i="5.93,293,1654585200"; 
   d="scan'208";a="643995469"
Received: from chenchar-mobl1.amr.corp.intel.com (HELO [10.212.193.190]) ([10.212.193.190])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Sep 2022 20:20:19 -0700
Message-ID: <c387b67e-7545-db72-25f7-7e368dddd75d@intel.com>
Date:   Mon, 5 Sep 2022 20:20:18 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH RFC] x86/sgx: Use a heap allocated list head for
 unsanitized pages
Content-Language: en-US
To:     Jarkko Sakkinen <jarkko@kernel.org>, linux-sgx@vger.kernel.org
Cc:     Haitao Huang <haitao.huang@linux.intel.com>,
        Vijay Dhanraj <vijay.dhanraj@intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Kai Huang <kai.huang@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)" 
        <linux-kernel@vger.kernel.org>
References: <20220906031230.107108-1-jarkko@kernel.org>
From:   Dave Hansen <dave.hansen@intel.com>
In-Reply-To: <20220906031230.107108-1-jarkko@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/5/22 20:12, Jarkko Sakkinen wrote:
> Allocate the list head for the unsanitized pages from heap, and transfer
> its to ownership to ksgxd, which takes care of destroying it. Remove
> sgx_dirty_page_list, as a global list is no longer required.
> 
> Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
> ---
> Depends on https://lore.kernel.org/linux-sgx/20220906000221.34286-1-jarkko@kernel.org/T/#t
> Would this be plausible?
> ---
>  arch/x86/kernel/cpu/sgx/main.c | 44 ++++++++++++++++++++++++----------
>  1 file changed, 31 insertions(+), 13 deletions(-)

What's the benefit?  I guess it saves 16 bytes of kernel image for ~20
lines of code.  Does it add more than 16 bytes to kernel text? ;)
