Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85AE45B2C25
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 04:34:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229891AbiIICeY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Sep 2022 22:34:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbiIICeT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Sep 2022 22:34:19 -0400
Received: from mail-oa1-x35.google.com (mail-oa1-x35.google.com [IPv6:2001:4860:4864:20::35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6506109D2E;
        Thu,  8 Sep 2022 19:34:17 -0700 (PDT)
Received: by mail-oa1-x35.google.com with SMTP id 586e51a60fabf-1278624b7c4so597336fac.5;
        Thu, 08 Sep 2022 19:34:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=fGrsc0HBgDYyvA5mzdziJoY/MD2IIKvGq2s1hV4eNMw=;
        b=bBWLRK/VW+7HLRt9xtpQRmk672gBKqyBOvCthHIY6QZmChG0xRIhVSuZLxzvac9/Np
         HzI0ktV2ykCSzoi0jbU+bL8MfBnOH4J5pWYiiKXhjeddJ/MSRhgNQwVzwdHHOV2AuQvS
         phumDuM+9RzFQEmhdq3Q3SL0OkVf/FDOQh8iSpZcFSRB/XX/7gRJmpXT0Tk8K8S8w7we
         8yLaY8zYwsb9ZIfh+q6u9wumYfCGXvOqS9/lZIcuso8QH33hzOAn/MDmjw+QgobIzR51
         1SyE4Jp+Qme9jvZajQ7asKs/nCtZ85YrMgrM5UncFBRRj/ngS+4JS6VFlhdLMoNJTVOC
         zdgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=fGrsc0HBgDYyvA5mzdziJoY/MD2IIKvGq2s1hV4eNMw=;
        b=18aeRia5fJzb5BPwCKcob7Ko9FAxQxhlAykBNgk8uHDRNUMNoHB2FWgpUCzSIbi9Qv
         EKoyeA2f11lWkTXivauivir5d1kWU79SW0Tdrn3WBjJO5oCTruTiKCwo5tbEzrLxXUvr
         3Vo11C+JDX94v1T7TXac0CLNBk617m7uQyITS0i/zNZDijyjTnR0T+V4/646FiqxiUmV
         R+OohqvkGlD/gnhPOBfLUv85nleIiCcc/C3cxQyaQtj19jl0cZq2wxXntRgMVSia5w3n
         4mL56Z77LO/nGotT8e3aiqab1SQBu+wVCMnZCntncQIqt2o2YCIi7vnNSnceAcNbFGws
         eMHg==
X-Gm-Message-State: ACgBeo0d7U37sgdAsE2+nwkiep3Bmu459zwv+pvoP8582xgslYcv87AL
        priqB8obzvWFuYAx/S0BT6380Q7uKDFV/Q==
X-Google-Smtp-Source: AA6agR68lPgGqF2kRNcn3etMwjxYP6mznt61YAwWCsxg5mLQ6N2N4KP1CWXMlBBjb11gAyrmBZsCRQ==
X-Received: by 2002:a05:6808:2194:b0:344:e71e:39f4 with SMTP id be20-20020a056808219400b00344e71e39f4mr2616250oib.31.1662690856766;
        Thu, 08 Sep 2022 19:34:16 -0700 (PDT)
Received: from macondo ([2804:431:e7cc:ed0b:fde6:d0df:8e59:d84f])
        by smtp.gmail.com with ESMTPSA id w16-20020a4a9d10000000b00448aff53822sm181326ooj.40.2022.09.08.19.34.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Sep 2022 19:34:16 -0700 (PDT)
Date:   Thu, 8 Sep 2022 23:34:12 -0300
From:   Rafael Mendonca <rafaelmendsr@gmail.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>
Cc:     "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ACPI: PCC: Fix memory leak in address space setup
Message-ID: <YxqmJLCQrK39Mx3O@macondo>
References: <20220909021348.472674-1-rafaelmendsr@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220909021348.472674-1-rafaelmendsr@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 08, 2022 at 11:13:47PM -0300, Rafael Mendonca wrote:
> The allocated memory for the pcc_data struct doesn't get freed under an
> error path in pcc_mbox_request_channel() or acpi_os_ioremap().
> 
> Fixes: 77e2a04745ff8 ("ACPI: PCC: Implement OperationRegion handler for the PCC Type 3 subtype")
> Signed-off-by: Rafael Mendonca <rafaelmendsr@gmail.com>
> ---
>  drivers/acpi/acpi_pcc.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/acpi/acpi_pcc.c b/drivers/acpi/acpi_pcc.c
> index a12b55d81209..fe5ab0fdc3bf 100644
> --- a/drivers/acpi/acpi_pcc.c
> +++ b/drivers/acpi/acpi_pcc.c
> @@ -63,6 +63,7 @@ acpi_pcc_address_space_setup(acpi_handle region_handle, u32 function,
>  	if (IS_ERR(data->pcc_chan)) {
>  		pr_err("Failed to find PCC channel for subspace %d\n",
>  		       ctx->subspace_id);
> +		kfree(data);
>  		return AE_NOT_FOUND;
>  	}
>  
> @@ -72,6 +73,7 @@ acpi_pcc_address_space_setup(acpi_handle region_handle, u32 function,
>  	if (!data->pcc_comm_addr) {
>  		pr_err("Failed to ioremap PCC comm region mem for %d\n",
>  		       ctx->subspace_id);

I was wondering if pcc_mbox_free_channel() should be called here as well
in case of acpi_os_ioremap() failure.

> +		kfree(data);
>  		return AE_NO_MEMORY;
>  	}
>  
> -- 
> 2.34.1
> 
