Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9073048444C
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jan 2022 16:11:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234706AbiADPLc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jan 2022 10:11:32 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:49204 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231168AbiADPLb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jan 2022 10:11:31 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 0FE0CB8160D
        for <linux-kernel@vger.kernel.org>; Tue,  4 Jan 2022 15:11:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0641C36AE9;
        Tue,  4 Jan 2022 15:11:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641309088;
        bh=bJMLAxfxFS5DwU5X/+9RBjzIE6aeFEH+//oc3YJvXWw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=TJ1klds9TgLNQlVlBFja//uq8Bi9X+u8hgQyT/FKRv8fWbHbejNZvaLqDW8HxXEsL
         chqa+MwZ99RQMFEa9nzT/nQ8E86pQ9GG79c02rZbbVt+4hkfKa64e3YwYjQrYGnXWd
         8xhkOmFi/cY4S15r+94MsYgGX5+GaoHSux6xCLH172paWGIcCcpefJ8Ax3NVJkIIDL
         5MMhmiz8BmIk9v7ya8vV+bhWmJZC8WDZ28OaHNRi/WDYhilrhMIpJKY9f1ZCcUvdOQ
         VQK7YxT4gb3vG9dOVoO9zWIWERoidixJroWqKD0Qj77BDrknp6GbXEmP1ablCviH0/
         Uk9X5H4lImI/g==
Date:   Tue, 4 Jan 2022 15:11:23 +0000
From:   Will Deacon <will@kernel.org>
To:     Yang Yingliang <yangyingliang@huawei.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        bbudiredla@marvell.com
Subject: Re: [PATCH -next] perf/marvell_cn10k_tad_pmu: Fix return value check
 in tad_pmu_probe()
Message-ID: <20220104151123.GA2005@willie-the-truck>
References: <20211221112252.306558-1-yangyingliang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211221112252.306558-1-yangyingliang@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 21, 2021 at 07:22:52PM +0800, Yang Yingliang wrote:
> In case of error, the function devm_ioremap() returns NULL
> pointer not ERR_PTR(). The IS_ERR() test in the return value
> check should be replaced with NULL test.
> 
> Fixes: 036a7584bede ("drivers: perf: Add LLC-TAD perf counter support")
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
> ---
>  drivers/perf/marvell_cn10k_tad_pmu.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/perf/marvell_cn10k_tad_pmu.c b/drivers/perf/marvell_cn10k_tad_pmu.c
> index 250dd4c52d70..7f4d292658e3 100644
> --- a/drivers/perf/marvell_cn10k_tad_pmu.c
> +++ b/drivers/perf/marvell_cn10k_tad_pmu.c
> @@ -312,7 +312,7 @@ static int tad_pmu_probe(struct platform_device *pdev)
>  		regions[i].base = devm_ioremap(&pdev->dev,
>  					       res->start,
>  					       tad_pmu_page_size);
> -		if (IS_ERR(regions[i].base)) {
> +		if (!regions[i].base) {
>  			dev_err(&pdev->dev, "TAD%d ioremap fail\n", i);
>  			return -ENOMEM;

Thanks, but Dan already caught this:

https://lore.kernel.org/r/20211217145907.GA16611@kili

I'll push out his fix soon.

Will
