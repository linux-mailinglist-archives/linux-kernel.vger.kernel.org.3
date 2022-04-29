Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D4D7514FE3
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Apr 2022 17:49:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352019AbiD2PwK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Apr 2022 11:52:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232880AbiD2PwI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Apr 2022 11:52:08 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FB84B0D2A
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 08:48:50 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 12F691F892;
        Fri, 29 Apr 2022 15:48:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1651247329; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=VNBiKREvGzFP27guLk4+UBkX+h08uP+X6xTBrt5hHho=;
        b=drQJxVTKvo1AybnSo2/MzD7LTkaFv9GRGXpGYyqOBRbs5EAF2ux1/GRcTK7qz29bn2iJoA
        WNCGyJapNln5qZErW8Hli7gUXnsEqum3UET0k3VfleSn5eNynUQnDmSNZ21/LWPPfNU0sv
        CB6h2NGGgEdITpuJD9nRvtRD7KrcG6Q=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1651247329;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=VNBiKREvGzFP27guLk4+UBkX+h08uP+X6xTBrt5hHho=;
        b=UM/5Pxeh1Iq/PtXprQH7UyAF1c2SBIAehygBwBjrEgVx8t3OWyaMilGzC3u1zwg3ofS52Z
        ePYIRr92zq0SzFBw==
Received: from kunlun.suse.cz (unknown [10.100.128.76])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 8905D2C141;
        Fri, 29 Apr 2022 15:48:48 +0000 (UTC)
Date:   Fri, 29 Apr 2022 17:48:47 +0200
From:   Michal =?iso-8859-1?Q?Such=E1nek?= <msuchanek@suse.de>
To:     nvdimm@lists.linux.dev
Cc:     Dan Williams <dan.j.williams@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Ira Weiny <ira.weiny@intel.com>, Zou Wei <zou_wei@huawei.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] testing: nvdimm: iomap: make __nfit_test_ioremap a macro
Message-ID: <20220429154847.GN163591@kunlun.suse.cz>
References: <20220429134039.18252-1-msuchanek@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220429134039.18252-1-msuchanek@suse.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 29, 2022 at 03:40:39PM +0200, Michal Suchanek wrote:
> The ioremap passed as argument to __nfit_test_ioremap can be a macro so
> it cannot be passed as function argument. Make __nfit_test_ioremap into
> a macro so that ioremap can be passed as untyped macro argument.

Fixes: 6bc756193ff6 ("tools/testing/nvdimm: libnvdimm unit test infrastructure")

The fallback_fn was passed around to start with, and ioremap was already
a define when this was merged.

> Signed-off-by: Michal Suchanek <msuchanek@suse.de>
> ---
>  tools/testing/nvdimm/test/iomap.c | 18 ++++++++----------
>  1 file changed, 8 insertions(+), 10 deletions(-)
> 
> diff --git a/tools/testing/nvdimm/test/iomap.c b/tools/testing/nvdimm/test/iomap.c
> index b752ce47ead3..ea956082e6a4 100644
> --- a/tools/testing/nvdimm/test/iomap.c
> +++ b/tools/testing/nvdimm/test/iomap.c
> @@ -62,16 +62,14 @@ struct nfit_test_resource *get_nfit_res(resource_size_t resource)
>  }
>  EXPORT_SYMBOL(get_nfit_res);
>  
> -static void __iomem *__nfit_test_ioremap(resource_size_t offset, unsigned long size,
> -		void __iomem *(*fallback_fn)(resource_size_t, unsigned long))
> -{
> -	struct nfit_test_resource *nfit_res = get_nfit_res(offset);
> -
> -	if (nfit_res)
> -		return (void __iomem *) nfit_res->buf + offset
> -			- nfit_res->res.start;
> -	return fallback_fn(offset, size);
> -}
> +#define __nfit_test_ioremap(offset, size, fallback_fn) ({		\
> +	struct nfit_test_resource *nfit_res = get_nfit_res(offset);	\
> +	nfit_res ?							\
> +		(void __iomem *) nfit_res->buf + (offset)		\
> +			- nfit_res->res.start				\
> +	:								\
> +		fallback_fn((offset), (size)) ;				\
> +})
>  
>  void __iomem *__wrap_devm_ioremap(struct device *dev,
>  		resource_size_t offset, unsigned long size)
> -- 
> 2.34.1
> 
