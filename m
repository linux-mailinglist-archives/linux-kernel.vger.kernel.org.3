Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F4D34C5692
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Feb 2022 16:08:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232179AbiBZPJP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Feb 2022 10:09:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230315AbiBZPJM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Feb 2022 10:09:12 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA79C1DC9A2;
        Sat, 26 Feb 2022 07:08:36 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6C0C660B89;
        Sat, 26 Feb 2022 15:08:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D360C340E8;
        Sat, 26 Feb 2022 15:08:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1645888115;
        bh=ijmknrhdQP18Q3RIGWdlxw9x4DRN8zfnfy7bwDbty/A=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=zeAx8OoHqjb05X0iSOHmFdz5gHsJZH2RRa0qOwRW4Afu7B5/3Cx7Ecnc6PIZDb8yg
         2BAFCTCdQE55GcHlKltTZLWtqLPoys2qurnm2WgFUO1U/gAj3pXvTwN1RpdVOI+T49
         f+th7ooD43Yjwj4xAtkmXqmxRfIYKMcqujyqd6bw=
Date:   Sat, 26 Feb 2022 16:08:32 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     broonie@kernel.org, Kai-Heng Feng <kai.heng.feng@canonical.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        linux-mmc@vger.kernel.org
Subject: Re: linux-next: build failure after merge of the char-misc tree
Message-ID: <YhpCcE19y3sGqLQ3@kroah.com>
References: <20220225204055.3899986-1-broonie@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220225204055.3899986-1-broonie@kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 25, 2022 at 08:40:55PM +0000, broonie@kernel.org wrote:
> Hi all,
> 
> After merging the char-misc tree, today's linux-next build (x86
> allmodconfig) failed like this:
> 
> /tmp/next/build/drivers/mmc/host/rtsx_pci_sdmmc.c: In function 'sd_request':
> /tmp/next/build/drivers/mmc/host/rtsx_pci_sdmmc.c:809:17: error: unused variable 'dev' [-Werror=unused-variable]
>   809 |  struct device *dev = &host->pdev->dev;
>       |                 ^~~
> /tmp/next/build/drivers/mmc/host/rtsx_pci_sdmmc.c: In function 'sdmmc_set_ios':
> /tmp/next/build/drivers/mmc/host/rtsx_pci_sdmmc.c:1084:17: error: unused variable 'dev' [-Werror=unused-variable]
>  1084 |  struct device *dev = &host->pdev->dev;
>       |                 ^~~
> /tmp/next/build/drivers/mmc/host/rtsx_pci_sdmmc.c: In function 'sdmmc_get_ro':
> /tmp/next/build/drivers/mmc/host/rtsx_pci_sdmmc.c:1133:17: error: unused variable 'dev' [-Werror=unused-variable]
>  1133 |  struct device *dev = &host->pdev->dev;
>       |                 ^~~
> /tmp/next/build/drivers/mmc/host/rtsx_pci_sdmmc.c: In function 'sdmmc_get_cd':
> /tmp/next/build/drivers/mmc/host/rtsx_pci_sdmmc.c:1159:17: error: unused variable 'dev' [-Werror=unused-variable]
>  1159 |  struct device *dev = &host->pdev->dev;
>       |                 ^~~
> /tmp/next/build/drivers/mmc/host/rtsx_pci_sdmmc.c: In function 'sdmmc_switch_voltage':
> /tmp/next/build/drivers/mmc/host/rtsx_pci_sdmmc.c:1258:17: error: unused variable 'dev' [-Werror=unused-variable]
>  1258 |  struct device *dev = &host->pdev->dev;
>       |                 ^~~
> /tmp/next/build/drivers/mmc/host/rtsx_pci_sdmmc.c: In function 'sdmmc_execute_tuning':
> /tmp/next/build/drivers/mmc/host/rtsx_pci_sdmmc.c:1311:17: error: unused variable 'dev' [-Werror=unused-variable]
>  1311 |  struct device *dev = &host->pdev->dev;
>       |                 ^~~
> cc1: all warnings being treated as errors
> 
> Caused by commit
> 
>   7570fb41e450ba37 ("mmc: rtsx: Let MMC core handle runtime PM")
> 
> I have used the char-misc tree from yesterday instead.

Kai-Heng, can you send an add-on patch to fix this?

thanks,

greg k-h
