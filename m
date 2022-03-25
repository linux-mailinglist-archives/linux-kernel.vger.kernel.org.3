Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18B914E736E
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Mar 2022 13:27:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359081AbiCYM3F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Mar 2022 08:29:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359627AbiCYM23 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Mar 2022 08:28:29 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 380969D4CB;
        Fri, 25 Mar 2022 05:26:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1648211172; x=1679747172;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=zPbGwq876NWJTrSNdW83CswPnnsNvVxs/FP5O1kbI+I=;
  b=nfoQY8ioPVWpP3GJPW6rxz0SpFQLuVeE2CoUjzmabmlMIxtPsUDnmN9u
   dmbTdG3c2wgtHPQhz4nQc9xMBvlfqkQq1NRW2XOGfQUQRpMTQxalMT3nF
   c2tfcoanzhn2cW3jK5PLPYpfEfHpYCx5tcUVwWE231Nf7+/TvzZ4m9CRp
   KB9kym2EnbeVoIfdQO6saMLS/9CjsRftr0eLxzHJ0KR4LzEbu5VuUb6dt
   /tMtEPUTA7ePqK9dqTuxDmfTXwAriXe27U6CeCDyQviNjM4uhaJIG5ci8
   YOikUqhijczIMGwMqbd9NN4ZKoDr13h9fOGDXs5+swDIDztZJhAsXxS9x
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10296"; a="239225140"
X-IronPort-AV: E=Sophos;i="5.90,209,1643702400"; 
   d="scan'208";a="239225140"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2022 05:25:58 -0700
X-IronPort-AV: E=Sophos;i="5.90,209,1643702400"; 
   d="scan'208";a="602036833"
Received: from spandruv-desk.jf.intel.com ([10.54.75.8])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2022 05:25:58 -0700
Message-ID: <41ac8f69c20b7c48c96dc1b26a7a25044a259e44.camel@linux.intel.com>
Subject: Re: [PATCH 1/3] thermal: int340x: Fix bogus acpi_buffer pointer
 freeing
From:   srinivas pandruvada <srinivas.pandruvada@linux.intel.com>
To:     Davidlohr Bueso <dave@stgolabs.net>, rafael@kernel.org
Cc:     daniel.lezcano@linaro.org, amitk@kernel.org, rui.zhang@intel.com,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Fri, 25 Mar 2022 05:25:57 -0700
In-Reply-To: <20220324190950.70486-2-dave@stgolabs.net>
References: <20220324190950.70486-1-dave@stgolabs.net>
         <20220324190950.70486-2-dave@stgolabs.net>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.4 (3.38.4-1.fc33) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2022-03-24 at 12:09 -0700, Davidlohr Bueso wrote:
> It is the caller's responsibility to free only upon ACPI_SUCCESS.
> 

Since context->ret.pointer will be NULL on failure so calling kfree
will just return.

Although we can avoid this call to kfree.

Thanks,
Srinivas

> Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>
> ---
>  drivers/thermal/intel/int340x_thermal/int3400_thermal.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/thermal/intel/int340x_thermal/int3400_thermal.c
> b/drivers/thermal/intel/int340x_thermal/int3400_thermal.c
> index 4954800b9850..0e7931c286ec 100644
> --- a/drivers/thermal/intel/int340x_thermal/int3400_thermal.c
> +++ b/drivers/thermal/intel/int340x_thermal/int3400_thermal.c
> @@ -186,11 +186,11 @@ static int int3400_thermal_run_osc(acpi_handle
> handle, char *uuid_str, int *enab
>                 ret = *((u32 *)(context.ret.pointer + 4));
>                 if (ret != *enable)
>                         result = -EPERM;
> +
> +               kfree(context.ret.pointer);
>         } else
>                 result = -EPERM;
>  
> -       kfree(context.ret.pointer);
> -
>         return result;
>  }
>  


