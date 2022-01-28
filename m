Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C049449F722
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jan 2022 11:18:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347859AbiA1KSd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jan 2022 05:18:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347467AbiA1KSH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jan 2022 05:18:07 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FCD3C06173B;
        Fri, 28 Jan 2022 02:18:07 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F2ED661E48;
        Fri, 28 Jan 2022 10:18:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B43D4C340E0;
        Fri, 28 Jan 2022 10:18:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1643365086;
        bh=FpyUHmjkG6laiyj9unPeqvCUaLot+5PMgUU2jkkgb6U=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mwzHz0bC/pNzofos1H7lO3sobNhSNKjXt90GM/nfKZvB/nva9WZNGOC8lSxyqcuVQ
         76XULi2NupYz3aq+8GkUDzbV5onjlAPK1vJNgvmxHHJGTqI1XPnqDuSOvF3Mdlnxuw
         Q1zCdlFuoAeRWnIXWjYTKdZsN8YlI49y6zEU7FvM=
Date:   Fri, 28 Jan 2022 11:17:57 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Zhou Qingyang <zhou1615@umn.edu>
Cc:     kjlu@umn.edu, "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>, Lv Zheng <lv.zheng@intel.com>,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ACPI / tables: Fix a NULL pointer dereference in
 acpi_table_initrd_override()
Message-ID: <YfPC1aFxtt9TazL9@kroah.com>
References: <20220124164251.52466-1-zhou1615@umn.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220124164251.52466-1-zhou1615@umn.edu>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 25, 2022 at 12:42:51AM +0800, Zhou Qingyang wrote:
> In acpi_table_initrd_override(), the return value of acpi_os_map_memory()
> is assigned to table and there is a dereference of it after that.
> acpi_os_map_memory() will return NULL on failure, which may lead to NULL
> pointer dereference.
> 
> Fix this bug by adding a NULL check of table.
> 
> This bug was found by a static analyzer.
> 
> Builds with 'make allyesconfig' show no new warnings,
> and our static analyzer no longer warns about this code.
> 
> Fixes: 5ae74f2cc2f1 ("ACPI / tables: Move table override mechanisms to tables.c")
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
>  drivers/acpi/tables.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/acpi/tables.c b/drivers/acpi/tables.c
> index 0741a4933f62..8b10c192ed32 100644
> --- a/drivers/acpi/tables.c
> +++ b/drivers/acpi/tables.c
> @@ -696,6 +696,10 @@ acpi_table_initrd_override(struct acpi_table_header *existing_table,
>  	while (table_offset + ACPI_HEADER_SIZE <= all_tables_size) {
>  		table = acpi_os_map_memory(acpi_tables_addr + table_offset,
>  					   ACPI_HEADER_SIZE);
> +		if (!table) {
> +			return AE_NO_MEMORY;
> +		}
> +
>  		if (table_offset + table->length > all_tables_size) {
>  			acpi_os_unmap_memory(table, ACPI_HEADER_SIZE);
>  			WARN_ON(1);
> -- 
> 2.25.1
> 

As stated before, umn.edu is still not allowed to contribute to the
Linux kernel.  Please work with your administration to resolve this
issue.

