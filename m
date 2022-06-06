Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1507C53E9E2
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Jun 2022 19:08:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234527AbiFFK7X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jun 2022 06:59:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234484AbiFFK7V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jun 2022 06:59:21 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EDA82F3A6
        for <linux-kernel@vger.kernel.org>; Mon,  6 Jun 2022 03:59:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654513161; x=1686049161;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=KhwvXW6zUbWEM0qHgxCwwh/Nc3q2WDbYu9UOf1uGJ0U=;
  b=El7kvfdoGMzcL74YKFySuM35m5axI/NrS/Adj2lTHPM6dfhcJx+NBy7e
   MP0IKSPayLbYSPknY9er62Gexvyar+IhQ+hl5BXwo4Rs1QiLdh6zrPmGw
   vOnkH+TZrDiHDS3FeEy1Kwz2VWNmoI6qC59xp+IukT/yn6H3I7t4X5Ion
   4wkgRIyVp7fC9KjAZtBQyFGD4R/smknQcaiFCDxoZnaGn7CE687ZmU3up
   5iu1bnFGtpW0XausotNCM3lBqYzFa8ExjxIAbKGdNCrLLKNIi+dGTqTaH
   ggNVmjbGdEJfuPWS5K63spOqYRjs8XQGoBVzWQK7iVcoe700O49pSIhYO
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10369"; a="337528360"
X-IronPort-AV: E=Sophos;i="5.91,280,1647327600"; 
   d="scan'208";a="337528360"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jun 2022 03:59:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,280,1647327600"; 
   d="scan'208";a="758512805"
Received: from irvmail001.ir.intel.com ([10.43.11.63])
  by orsmga005.jf.intel.com with ESMTP; 06 Jun 2022 03:59:17 -0700
Received: from newjersey.igk.intel.com (newjersey.igk.intel.com [10.102.20.203])
        by irvmail001.ir.intel.com (8.14.3/8.13.6/MailSET/Hub) with ESMTP id 256AxGlq023997;
        Mon, 6 Jun 2022 11:59:16 +0100
From:   Alexander Lobakin <alexandr.lobakin@intel.com>
To:     Nathan Chancellor <nathan@kernel.org>
Cc:     Alexander Lobakin <alexandr.lobakin@intel.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
        patches@lists.linux.dev, Dan Carpenter <dan.carpenter@oracle.com>,
        kernel test robot <lkp@intel.com>, Tom Rix <trix@redhat.com>,
        Ricky WU <ricky_wu@realtek.com>
Subject: Re: [PATCH] misc: rtsx: Fix clang -Wsometimes-uninitialized in rts5261_init_from_hw()
Date:   Mon,  6 Jun 2022 12:58:19 +0200
Message-Id: <20220606105819.349320-1-alexandr.lobakin@intel.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220523150521.2947108-1-nathan@kernel.org>
References: <20220523150521.2947108-1-nathan@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nathan Chancellor <nathan@kernel.org>
Date: Mon, 23 May 2022 08:05:22 -0700

> Clang warns:
> 
>   drivers/misc/cardreader/rts5261.c:406:13: error: variable 'setting_reg2' is used uninitialized whenever 'if' condition is false [-Werror,-Wsometimes-uninitialized]
>           } else if (efuse_valid == 0) {
>                      ^~~~~~~~~~~~~~~~
>   drivers/misc/cardreader/rts5261.c:412:30: note: uninitialized use occurs here
>           pci_read_config_dword(pdev, setting_reg2, &lval2);
>                                       ^~~~~~~~~~~~
> 
> efuse_valid == 1 is not a valid value so just return early from the
> function to avoid using setting_reg2 uninitialized.
> 
> Fixes: b1c5f3085149 ("misc: rtsx: add rts5261 efuse function")
> Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
> Reported-by: kernel test robot <lkp@intel.com>
> Reported-by: Tom Rix <trix@redhat.com>
> Suggested-by: Ricky WU <ricky_wu@realtek.com>
> Signed-off-by: Nathan Chancellor <nathan@kernel.org>

Ping? Mainline 5.19-rc1 is now broken due to this.

> ---
> 
> This is basically a v2 of https://lore.kernel.org/20220516130047.3887590-1-trix@redhat.com/.
> 
>  drivers/misc/cardreader/rts5261.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/misc/cardreader/rts5261.c b/drivers/misc/cardreader/rts5261.c
> index 749cc5a46d13..b1e76030cafd 100644
> --- a/drivers/misc/cardreader/rts5261.c
> +++ b/drivers/misc/cardreader/rts5261.c
> @@ -407,6 +407,8 @@ static void rts5261_init_from_hw(struct rtsx_pcr *pcr)
>  		// default
>  		setting_reg1 = PCR_SETTING_REG1;
>  		setting_reg2 = PCR_SETTING_REG2;
> +	} else {
> +		return;
>  	}
>  
>  	pci_read_config_dword(pdev, setting_reg2, &lval2);
> 
> base-commit: 90de6805267f8c79cd2b1a36805071e257c39b5c
> -- 
> 2.36.1

Thanks,
Al
