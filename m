Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17B4250E354
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 16:36:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240826AbiDYOiW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 10:38:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235507AbiDYOiH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 10:38:07 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D845E1E8;
        Mon, 25 Apr 2022 07:35:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650897302; x=1682433302;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=fWXIa71NeGGWHMHlo+yI2o4Jp974jDRWwSIqgJF5Cjg=;
  b=YnFXTJmHzTf7rCzyaAukeFh4Cyy0fU/Wx2OApKSd5rIkwfzSW0w5qHsa
   6DzIjqvXEeHlErmzIA6Q7H+MxB4cmmsoIZoSjnqL0r1l/Olx8LJG9B5BO
   ahl9xbn1+ZwntEnYcAnO/b0HU2yJfafod5G+PPBfQ5K+/BNXo4612lET2
   eBMhz5xE60cR7moFIRcRlSoDBON/mgD919pOWTJG6wQDihSrJ52dIVcqg
   49KoyBi2ggx2juEP4vv+0rjU/mRAXMkqylhfZuKFYwDURjcQu9MdfNimY
   ym+WXc/ediULOEMQd9i8WpRFtk649hjPBm18G2vd3iS1tjcn6UG98sDcS
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10328"; a="290401705"
X-IronPort-AV: E=Sophos;i="5.90,288,1643702400"; 
   d="scan'208";a="290401705"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Apr 2022 07:35:02 -0700
X-IronPort-AV: E=Sophos;i="5.90,288,1643702400"; 
   d="scan'208";a="595260898"
Received: from silpixa00400314.ir.intel.com (HELO silpixa00400314) ([10.237.222.76])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Apr 2022 07:35:00 -0700
Date:   Mon, 25 Apr 2022 15:34:53 +0100
From:   Giovanni Cabiddu <giovanni.cabiddu@intel.com>
To:     Haowen Bai <baihaowen@meizu.com>
Cc:     Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>, qat-linux@intel.com,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] crypto: qat - Fix unsigned function returning negative
 constant
Message-ID: <YmaxfKXqYNOgGXYI@silpixa00400314>
References: <1650790231-16894-1-git-send-email-baihaowen@meizu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1650790231-16894-1-git-send-email-baihaowen@meizu.com>
Organization: Intel Research and Development Ireland Ltd - Co. Reg. #308263 -
 Collinstown Industrial Park, Leixlip, County Kildare - Ireland
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 24, 2022 at 04:50:31PM +0800, Haowen Bai wrote:
> The function qat_uclo_check_image_compat has an unsigned return type, but
Nit, function names should have parenthesis: qat_uclo_check_image_compat()
> returns a negative constant to indicate an error condition. So we change
> unsigned to int.
> 
> Signed-off-by: Haowen Bai <baihaowen@meizu.com>
Fixes: b4b7e67c917f ("crypto: qat - Intel(R) QAT ucode part of fw loader")
Acked-by: Giovanni Cabiddu <giovanni.cabiddu@intel.com>

> ---
>  drivers/crypto/qat/qat_common/qat_uclo.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/crypto/qat/qat_common/qat_uclo.c b/drivers/crypto/qat/qat_common/qat_uclo.c
> index 6356402a2c9e..4b6f37d6e85b 100644
> --- a/drivers/crypto/qat/qat_common/qat_uclo.c
> +++ b/drivers/crypto/qat/qat_common/qat_uclo.c
> @@ -519,7 +519,7 @@ qat_uclo_map_chunk(char *buf, struct icp_qat_uof_filehdr *file_hdr,
>  	return NULL;
>  }
>  
> -static unsigned int
> +static int
>  qat_uclo_check_image_compat(struct icp_qat_uof_encap_obj *encap_uof_obj,
>  			    struct icp_qat_uof_image *image)
>  {
> -- 
> 2.7.4
> 
