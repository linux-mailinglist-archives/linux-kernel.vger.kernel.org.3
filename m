Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E46854C97C4
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Mar 2022 22:27:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238594AbiCAV2V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Mar 2022 16:28:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231863AbiCAV2T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Mar 2022 16:28:19 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C46B2B276;
        Tue,  1 Mar 2022 13:27:36 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E57546121A;
        Tue,  1 Mar 2022 21:27:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 050E6C340EE;
        Tue,  1 Mar 2022 21:27:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1646170055;
        bh=T/McMRYbMuu8/Croir0tdzYmDthGMYZxovzrwCbNsY8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZXir+gDxoZ8hzCA+RmVyyqaW98B0YwW4ZiehZt1BTSyp+AKFk8xVAkybHzsZImWzT
         xH8Yo5bJDkzhEbCSks3rn8ek+g/y+Pe0gUNq1nDNlcWHIA4Nu8BhIHmP2bqQ06ehwg
         sXlg25mSEkcRiJzl7y7ZT9ro9L2CcrJ8lPupIe5w=
Date:   Tue, 1 Mar 2022 22:27:32 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     broonie@kernel.org, Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        linux-mmc@vger.kernel.org
Subject: Re: linux-next: build failure after merge of the char-misc tree
Message-ID: <Yh6PxD9d7Fb4VLP5@kroah.com>
References: <20220225204055.3899986-1-broonie@kernel.org>
 <YhpCcE19y3sGqLQ3@kroah.com>
 <20220301161426.0218d519@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220301161426.0218d519@canb.auug.org.au>
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 01, 2022 at 04:14:26PM +1100, Stephen Rothwell wrote:
> Hi all,
> 
> On Sat, 26 Feb 2022 16:08:32 +0100 Greg KH <gregkh@linuxfoundation.org> wrote:
> >
> > On Fri, Feb 25, 2022 at 08:40:55PM +0000, broonie@kernel.org wrote:
> > > 
> > > After merging the char-misc tree, today's linux-next build (x86
> > > allmodconfig) failed like this:
> > > 
> > > /tmp/next/build/drivers/mmc/host/rtsx_pci_sdmmc.c: In function 'sd_request':
> > > /tmp/next/build/drivers/mmc/host/rtsx_pci_sdmmc.c:809:17: error: unused variable 'dev' [-Werror=unused-variable]
> > >   809 |  struct device *dev = &host->pdev->dev;
> > >       |                 ^~~
> > > /tmp/next/build/drivers/mmc/host/rtsx_pci_sdmmc.c: In function 'sdmmc_set_ios':
> > > /tmp/next/build/drivers/mmc/host/rtsx_pci_sdmmc.c:1084:17: error: unused variable 'dev' [-Werror=unused-variable]
> > >  1084 |  struct device *dev = &host->pdev->dev;
> > >       |                 ^~~
> > > /tmp/next/build/drivers/mmc/host/rtsx_pci_sdmmc.c: In function 'sdmmc_get_ro':
> > > /tmp/next/build/drivers/mmc/host/rtsx_pci_sdmmc.c:1133:17: error: unused variable 'dev' [-Werror=unused-variable]
> > >  1133 |  struct device *dev = &host->pdev->dev;
> > >       |                 ^~~
> > > /tmp/next/build/drivers/mmc/host/rtsx_pci_sdmmc.c: In function 'sdmmc_get_cd':
> > > /tmp/next/build/drivers/mmc/host/rtsx_pci_sdmmc.c:1159:17: error: unused variable 'dev' [-Werror=unused-variable]
> > >  1159 |  struct device *dev = &host->pdev->dev;
> > >       |                 ^~~
> > > /tmp/next/build/drivers/mmc/host/rtsx_pci_sdmmc.c: In function 'sdmmc_switch_voltage':
> > > /tmp/next/build/drivers/mmc/host/rtsx_pci_sdmmc.c:1258:17: error: unused variable 'dev' [-Werror=unused-variable]
> > >  1258 |  struct device *dev = &host->pdev->dev;
> > >       |                 ^~~
> > > /tmp/next/build/drivers/mmc/host/rtsx_pci_sdmmc.c: In function 'sdmmc_execute_tuning':
> > > /tmp/next/build/drivers/mmc/host/rtsx_pci_sdmmc.c:1311:17: error: unused variable 'dev' [-Werror=unused-variable]
> > >  1311 |  struct device *dev = &host->pdev->dev;
> > >       |                 ^~~
> > > cc1: all warnings being treated as errors
> > > 
> > > Caused by commit
> > > 
> > >   7570fb41e450ba37 ("mmc: rtsx: Let MMC core handle runtime PM")
> > > 
> > > I have used the char-misc tree from yesterday instead.  
> > 
> > Kai-Heng, can you send an add-on patch to fix this?
> > 
> > thanks,
> 
> I am still getting these build errors.

Should now be fixed, sorry for the delay.

greg k-h
