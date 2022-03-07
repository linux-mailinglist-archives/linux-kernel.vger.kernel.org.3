Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FF6C4CEF3E
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Mar 2022 02:51:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234632AbiCGBwg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Mar 2022 20:52:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230334AbiCGBwe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Mar 2022 20:52:34 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0A3213D72;
        Sun,  6 Mar 2022 17:51:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646617901; x=1678153901;
  h=from:to:cc:subject:references:date:in-reply-to:
   message-id:mime-version;
  bh=zaTl8EdBqb1BfExEr5Pn9LlMlwWHzQ3D+lX4vvh3fZ4=;
  b=MmApI/3QQTDGVIkbWj1usWKJD2oFJ2iE2twnXjsqLWvGznJQPP4aqnZP
   iZVmfGN0OkypDDduIfv5klhwcCn1jDe9xMxDDxloWHXreJNfso3ZL6Aho
   U12025Fld5C6TV9igtZdISGUC8TPvrj+IExqN+AURuo9TaXUbh+jgBLev
   X4t+91DSrQ63DexTCePI2+pblOr7VKoTLTVsujwNC4a9hL3J9jRVTleEd
   vaEl0qxBT7hGZu90sL8/XIUkw3LTmimpNZmRwh1CeclM9I+65hK+7JYKp
   BMhslkzukX80Ch1J43WVCn7Epef9mlLrccpYVep0vSEbDgOf28kuUtlo4
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10278"; a="254006830"
X-IronPort-AV: E=Sophos;i="5.90,160,1643702400"; 
   d="scan'208";a="254006830"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2022 17:51:40 -0800
X-IronPort-AV: E=Sophos;i="5.90,160,1643702400"; 
   d="scan'208";a="536917993"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.239.13.94])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2022 17:51:38 -0800
From:   "Huang, Ying" <ying.huang@intel.com>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     linux-kernel@vger.kernel.org,
        Igor Zhbanov <i.zhbanov@omprussia.ru>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org,
        James Morse <james.morse@arm.com>,
        Tony Luck <tony.luck@intel.com>, Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH] ACPI: APEI: fix return value of __setup handlers
References: <20220306024620.5847-1-rdunlap@infradead.org>
Date:   Mon, 07 Mar 2022 09:51:36 +0800
In-Reply-To: <20220306024620.5847-1-rdunlap@infradead.org> (Randy Dunlap's
        message of "Sat, 5 Mar 2022 18:46:20 -0800")
Message-ID: <87fsnu7cnr.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Randy Dunlap <rdunlap@infradead.org> writes:

> __setup() handlers should return 1 to indicate that the boot option
> has been handled. Returning 0 causes a boot option to be listed in
> the Unknown kernel command line parameters and also added to init's
> arg list (if no '=' sign) or environment list (if of the form 'a=b').
>
> Unknown kernel command line parameters "erst_disable
>   bert_disable hest_disable BOOT_IMAGE=/boot/bzImage-517rc6", will be
>   passed to user space.
>
>  Run /sbin/init as init process
>    with arguments:
>      /sbin/init
>      erst_disable
>      bert_disable
>      hest_disable
>    with environment:
>      HOME=/
>      TERM=linux
>      BOOT_IMAGE=/boot/bzImage-517rc6
>
> Fixes: a3e2acc5e37b ("ACPI / APEI: Add Boot Error Record Table (BERT) support")
> Fixes: a08f82d08053 ("ACPI, APEI, Error Record Serialization Table (ERST) support")
> Fixes: 9dc966641677 ("ACPI, APEI, HEST table parsing")
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>

Good catch!  Thanks for fixing!

Reviewed-by: "Huang, Ying" <ying.huang@intel.com>

Best Regards,
Huang, Ying

> Reported-by: Igor Zhbanov <i.zhbanov@omprussia.ru>
> Link: lore.kernel.org/r/64644a2f-4a20-bab3-1e15-3b2cdd0defe3@omprussia.ru
> Cc: Huang Ying <ying.huang@intel.com>
> Cc: "Rafael J. Wysocki" <rafael@kernel.org>
> Cc: Len Brown <lenb@kernel.org>
> Cc: linux-acpi@vger.kernel.org
> Cc: James Morse <james.morse@arm.com>
> Cc: Tony Luck <tony.luck@intel.com>
> Cc: Borislav Petkov <bp@alien8.de>
> ---
>  drivers/acpi/apei/bert.c |    2 +-
>  drivers/acpi/apei/erst.c |    2 +-
>  drivers/acpi/apei/hest.c |    2 +-
>  3 files changed, 3 insertions(+), 3 deletions(-)
>
> --- lnx-517-rc6.orig/drivers/acpi/apei/bert.c
> +++ lnx-517-rc6/drivers/acpi/apei/bert.c
> @@ -77,7 +77,7 @@ static int __init setup_bert_disable(cha
>  {
>  	bert_disable = 1;
>  
> -	return 0;
> +	return 1;
>  }
>  __setup("bert_disable", setup_bert_disable);
>  
> --- lnx-517-rc6.orig/drivers/acpi/apei/erst.c
> +++ lnx-517-rc6/drivers/acpi/apei/erst.c
> @@ -891,7 +891,7 @@ EXPORT_SYMBOL_GPL(erst_clear);
>  static int __init setup_erst_disable(char *str)
>  {
>  	erst_disable = 1;
> -	return 0;
> +	return 1;
>  }
>  
>  __setup("erst_disable", setup_erst_disable);
> --- lnx-517-rc6.orig/drivers/acpi/apei/hest.c
> +++ lnx-517-rc6/drivers/acpi/apei/hest.c
> @@ -224,7 +224,7 @@ err:
>  static int __init setup_hest_disable(char *str)
>  {
>  	hest_disable = HEST_DISABLED;
> -	return 0;
> +	return 1;
>  }
>  
>  __setup("hest_disable", setup_hest_disable);
