Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8ACAE46ED35
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Dec 2021 17:36:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239642AbhLIQkF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Dec 2021 11:40:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232484AbhLIQkE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Dec 2021 11:40:04 -0500
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80F1CC061746;
        Thu,  9 Dec 2021 08:36:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=EX9CGudp8dcrlnGUunc7sBtpaUqex0FFLoIEdm/NNQU=; b=1AYxprNzJk2VftgVMiVW/BLBep
        vIpgmJxPO2bvW0MGvbcaflTRDzV3VdEwGaxvKeLiIqzyWgfv12g6XBir6C9JaDHZRFhbX0inyyPDt
        qp7Tza9iJpPjLuokDAtbqlRz8mQILYqgr9QnQshPKNXjWtCqLF/F2UHFfoPk3DayCYn87+DozNeDE
        hnU165KADK8FXw58uYX74kau994C0SqWf2EJ4sxRgR/DSe16iOTfu2/ocE0pBLv4n3zTPy41Ackkh
        0cEltJltMwnwi3KbVfUIe4Hvnz2Qj31D0Plu5TsnqPyLja/0iI/zU/+tnj0cS9sEGsA5nb6/k3LHu
        ORUe9O0g==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:56206)
        by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <linux@armlinux.org.uk>)
        id 1mvMP5-0000Es-DK; Thu, 09 Dec 2021 16:36:19 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1mvMP1-0007Lr-Uo; Thu, 09 Dec 2021 16:36:15 +0000
Date:   Thu, 9 Dec 2021 16:36:15 +0000
From:   "Russell King (Oracle)" <linux@armlinux.org.uk>
To:     Ilkka Koskinen <ilkka@os.amperecomputing.com>
Cc:     lorenzo.pieralisi@arm.com, guohanjun@huawei.com,
        sudeep.holla@arm.com, rafael@kernel.org, lenb@kernel.org,
        robert.moore@intel.com, linux-acpi@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devel@acpica.org, patches@amperecomputing.com,
        scott@os.amperecomputing.com, darren@os.amperecomputing.com
Subject: Re: [PATCH 2/2] ACPI: AGDI: Add driver for Arm Generic Diagnostic
 Dump and Reset device
Message-ID: <YbIwfzND2R4WyQO7@shell.armlinux.org.uk>
References: <20211203024311.49865-1-ilkka@os.amperecomputing.com>
 <20211203024311.49865-3-ilkka@os.amperecomputing.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211203024311.49865-3-ilkka@os.amperecomputing.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, Dec 02, 2021 at 06:43:11PM -0800, Ilkka Koskinen wrote:
> +static int __init agdi_init(void)
> +{
> +	int ret;
> +	acpi_status status;
> +	struct acpi_table_agdi *agdi_table;
> +	struct agdi_data *pdata;
> +	struct platform_device *pdev;
> +
> +	if (acpi_disabled)
> +		return 0;
> +
> +	status = acpi_get_table(ACPI_SIG_AGDI, 0,
> +				(struct acpi_table_header **) &agdi_table);
> +	if (ACPI_FAILURE(status))
> +		return -ENODEV;
> +
> +	pdata = kzalloc(sizeof(*pdata), GFP_ATOMIC);

Why does this need to be GFP_ATOMIC? Also, struct agdi_data is a single
int in size, why do you need to kzalloc() it?

> +	if (!pdata) {
> +		ret = -ENOMEM;
> +		goto err_put_table;
> +	}
> +
> +	if (agdi_table->flags & ACPI_AGDI_SIGNALING_MODE) {
> +		pr_warn("Interrupt signaling is not supported");
> +		ret = -ENODEV;
> +		goto err_free_pdata;
> +	}
> +
> +	pdata->sdei_event = agdi_table->sdei_event;
> +
> +	pdev = platform_device_register_data(NULL, "agdi", 0, pdata, sizeof(*pdata));

platform_device_register_data() uses kmemdup() internally with the
platform data, meaning it takes a copy of the platform data. There is
no need for the pdata allocation to persist past this point. Hence,
given that it is a single int in size, you may as well put
"struct agdi_data" on the stack.

Thanks.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 40Mbps down 10Mbps up. Decent connectivity at last!
