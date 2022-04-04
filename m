Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F51B4F1054
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Apr 2022 09:53:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353596AbiDDHyY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Apr 2022 03:54:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233822AbiDDHyT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Apr 2022 03:54:19 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 725BC34641
        for <linux-kernel@vger.kernel.org>; Mon,  4 Apr 2022 00:52:23 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: usama.anjum)
        with ESMTPSA id 1F4991F4575C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1649058742;
        bh=x1VinAdRPQoJHVNstNlVveO35hxb/5sR/7Ny5l1p3Io=;
        h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
        b=YiqEhEg4ssGOtrMDM05KkO9AYvGHSfr+IfVaO7eW50S1b4fkapRZG/g2dNIVuE/hi
         8OjIL3g0Y5wacFey5CTKRa/mrZQO5CAF5acnk0Jh4L75ItU5Rtcsphcf5I91vzOh3d
         cBHqra39gdUTmmYTTGXwKLlGFnkMZ3kXBxskE6UTYa6PG+rmOcWzc50bTRp8nBoqCk
         IizeJwCcvWSUD54d51doHzfetq3k6zi/j6hEr8myGxMTRtNOxmb99my1MxltLBeiIS
         nlcmxO4WsRBU8C+PlUf/PEaODQ4NkQ73miBR8qDj20men7zHkvtxzcLpWNyHnjgN6v
         XGUDxOXfR2tiw==
Message-ID: <ace47a96-4e43-697a-4cfe-04544f014940@collabora.com>
Date:   Mon, 4 Apr 2022 12:52:15 +0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.2
Cc:     usama.anjum@collabora.com, kernel@collabora.com,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iommu/vt-d: remove unneeded validity check on dev
Content-Language: en-US
To:     David Woodhouse <dwmw2@infradead.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>
References: <20220313150337.593650-1-usama.anjum@collabora.com>
From:   Muhammad Usama Anjum <usama.anjum@collabora.com>
In-Reply-To: <20220313150337.593650-1-usama.anjum@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Any thoughts?

On 3/13/22 8:03 PM, Muhammad Usama Anjum wrote:
> dev_iommu_priv_get() is being used at the top of this function which
> dereferences dev. Dev cannot be NULL after this. Remove the validity
> check on dev and simplify the code.
> 
> Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
> ---
>  drivers/iommu/intel/iommu.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
> index df5c62ecf942b..f79edbbd651a4 100644
> --- a/drivers/iommu/intel/iommu.c
> +++ b/drivers/iommu/intel/iommu.c
> @@ -2502,7 +2502,7 @@ static struct dmar_domain *dmar_insert_one_dev_info(struct intel_iommu *iommu,
>  		}
>  	}
>  
> -	if (dev && domain_context_mapping(domain, dev)) {
> +	if (domain_context_mapping(domain, dev)) {
>  		dev_err(dev, "Domain context map failed\n");
>  		dmar_remove_one_dev_info(dev);
>  		return NULL;

-- 
Muhammad Usama Anjum
