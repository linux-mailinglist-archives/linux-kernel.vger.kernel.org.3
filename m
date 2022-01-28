Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9ECFB49F72D
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jan 2022 11:19:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347820AbiA1KTv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jan 2022 05:19:51 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:40592 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347815AbiA1KTu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jan 2022 05:19:50 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E321EB82513;
        Fri, 28 Jan 2022 10:19:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04628C340EB;
        Fri, 28 Jan 2022 10:19:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1643365187;
        bh=M4CzaFgG70uWAYMcfxgjqVmuqyccRd4KGSpeOBh5IPA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ja949el96CB8xtTnxOlrm2Tw4TwUTsQsvWzqM9oZVwNbzg+xfa3blRvaOzkKHxliz
         HAdTTpd0mI3fDa6v9zsQCx5ojmyyeHqgT1f3WU3NR1zjI37wscpU9fTKfJdYxmibtl
         8aqGmrilIdMmAI7ATOyIXFrjpmrCtLlFgNq/MYDM=
Date:   Fri, 28 Jan 2022 11:19:44 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Zhou Qingyang <zhou1615@umn.edu>
Cc:     kjlu@umn.edu, Robert Moore <robert.moore@intel.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Len Brown <lenb@kernel.org>, Lv Zheng <lv.zheng@intel.com>,
        linux-acpi@vger.kernel.org, devel@acpica.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ACPICA: Linuxize: Fix a NULL pointer dereference in
 acpi_db_convert_to_package()
Message-ID: <YfPDQDrnoTHC6S6Q@kroah.com>
References: <20220124164014.51658-1-zhou1615@umn.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220124164014.51658-1-zhou1615@umn.edu>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 25, 2022 at 12:40:14AM +0800, Zhou Qingyang wrote:
> In acpi_db_convert_to_package(), the variable elements is assigned by
> ACPI_ALLOCATE_ZEROED() and passes its address to 
> acpi_db_convert_to_object(). In that function we may have a dereference
> of elements without checks. ACPI_ALLOCATE_ZEROED() would return NULL on
> failure, which may lead to NULL pointer dereference.
> 
> Fix this bug by adding a NULL check of elements.
> 
> This bug was found by a static analyzer.
> 
> Builds with 'make allyesconfig' show no new warnings,
> and our static analyzer no longer warns about this code.
> 
> Fixes: 995751025572 ("ACPICA: Linuxize: Export debugger files to Linux")
> Signed-off-by: Zhou Qingyang <zhou1615@umn.edu>
> ---
> The analysis employs differential checking to identify inconsistent 
> security operations (e.g., checks or kfrees) between two code paths 
> and confirms that the inconsistent operations are not recovered in the
> current function or the callers, so they constitute bugs. 
> 
> Note that, as a bug found by static analysis, it can be a false
> positive or hard to trigger. Multiple researchers have cross-reviewed
> the bug.
> 
>  drivers/acpi/acpica/dbconvert.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/acpi/acpica/dbconvert.c b/drivers/acpi/acpica/dbconvert.c
> index 2b84ac093698..8dbab6932049 100644
> --- a/drivers/acpi/acpica/dbconvert.c
> +++ b/drivers/acpi/acpica/dbconvert.c
> @@ -174,6 +174,8 @@ acpi_status acpi_db_convert_to_package(char *string, union acpi_object *object)
>  	elements =
>  	    ACPI_ALLOCATE_ZEROED(DB_DEFAULT_PKG_ELEMENTS *
>  				 sizeof(union acpi_object));
> +	if (!elements)
> +		return (AE_NO_MEMORY);
>  
>  	this = string;
>  	for (i = 0; i < (DB_DEFAULT_PKG_ELEMENTS - 1); i++) {
> -- 
> 2.25.1
>

As stated before, umn.edu is still not allowed to contribute to the
Linux kernel.  Please work with your administration to resolve this
issue.

