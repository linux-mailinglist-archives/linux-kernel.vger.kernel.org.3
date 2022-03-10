Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C6304D4415
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Mar 2022 10:59:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237195AbiCJKAB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Mar 2022 05:00:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229889AbiCJJ77 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Mar 2022 04:59:59 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08C74107A97
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 01:58:59 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A35DA61DA5
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 09:58:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5A03C340E8;
        Thu, 10 Mar 2022 09:58:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646906338;
        bh=FQEoOUPxPCBBttWI5DToVj2g1UfTM3d42nlNmG2Sr5c=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=moI1WbwcJCsQOHL4VQl9qNNlOkQMgDZ27wKPyA58Y144kGPz/43CelCjrvBGxuyU2
         zZNoGgiitftdQZiVCYGLt0+oTsa6mVpPVzTEyycubnHLTe2vTaU+Ve+pgn//qMP0TJ
         zEKCmMgyc3d8AH95NK+fr6Lpk++NX7JEMFVWsIQRxnf4lSqpbzO6TTKxfaw3L1ISRz
         dHpVPm6cCQpHN/SepiWCDga05EBH7ErkwH9c8CyXk0030X8G4taMDEdz10/dh6gFKx
         w7Uyf6rjPpG5IJB4g3GPPDTbT+Z/cCY7B38VHmqXHIaV6CfarSdR1YCRfLNxBKwsOr
         Kkf+YK6nQCcRw==
Date:   Thu, 10 Mar 2022 09:58:52 +0000
From:   Will Deacon <will@kernel.org>
To:     YueHaibing <yuehaibing@huawei.com>
Cc:     mark.rutland@arm.com, bbhushan2@marvell.com,
        bbudiredla@marvell.com, arnd@arndb.de,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 -next] perf/marvell: cn10k Fix build error without
 CONFIG_OF
Message-ID: <20220310095852.GA1699@willie-the-truck>
References: <20220310065045.24772-1-yuehaibing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220310065045.24772-1-yuehaibing@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 10, 2022 at 02:50:45PM +0800, YueHaibing wrote:
> drivers/perf/marvell_cn10k_ddr_pmu.c:723:21: error: ‘cn10k_ddr_pmu_of_match’ undeclared here (not in a function); did you mean ‘cn10k_ddr_pmu_driver’?
>     	 .of_match_table = cn10k_ddr_pmu_of_match,
>       	                   ^~~~~~~~~~~~~~~~~~~~~~
> 
> Remove the #ifdef around the match table, because CONFIG_OF is always enabled on arm64.
> 
> Fixes: 7cf83e222bce ("perf/marvell: CN10k DDR performance monitor support")
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> ---
> v2: Remove the #ifdef macro as Arnd suggested
> ---
>  drivers/perf/marvell_cn10k_ddr_pmu.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/drivers/perf/marvell_cn10k_ddr_pmu.c b/drivers/perf/marvell_cn10k_ddr_pmu.c
> index 7f3146e71f99..bef0cee3a46a 100644
> --- a/drivers/perf/marvell_cn10k_ddr_pmu.c
> +++ b/drivers/perf/marvell_cn10k_ddr_pmu.c
> @@ -709,13 +709,11 @@ static int cn10k_ddr_perf_remove(struct platform_device *pdev)
>  	return 0;
>  }
>  
> -#ifdef CONFIG_OF
>  static const struct of_device_id cn10k_ddr_pmu_of_match[] = {
>  	{ .compatible = "marvell,cn10k-ddr-pmu", },
>  	{ },
>  };
>  MODULE_DEVICE_TABLE(of, cn10k_ddr_pmu_of_match);
> -#endif

Ah, sorry, I already fixed this when the conflict was first reported:

https://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git/commit/?h=for-next/perf&id=6676a42f1e4f1b8ec166b723a3801b7113c25a0e

However, I thought this driver could be compile-tested on architectures
without OF and then we'd get some report from that? At least, I'm certain
I've _added_ these ifdefs to other PMU drivers in the past.

Will
