Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57221575CEC
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jul 2022 10:03:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232465AbiGOICI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jul 2022 04:02:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229782AbiGOICD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jul 2022 04:02:03 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EBA07E00E
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jul 2022 01:02:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C1770B82AB2
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jul 2022 08:02:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34833C3411E;
        Fri, 15 Jul 2022 08:01:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657872119;
        bh=MIY0Qfj60RmPZQMHDKKewkDUeps6TZXnZNMjlC3SW+8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JOAU3xuxNGAsKI6S8W7SrogEclNkIVwb5seG+q1feJRqXxSgC9Px2Tfq1RPIhlP2v
         lB7axIO/2MAIQXBfEu7POCeUf2et/R2VUBnVgdit4bh4xDMYWNNyX/YgZ3wchs+XBR
         Q8i6fCxJJql/NHoEFpk1Rlmi+8FhrOqggArOx0zz+PuOevRYRRjSFnuC2dZhb+GX/H
         vSUkSQTmGMgvXchDuv2v8uu/WhpNCanM+ZLoliBGTHQp5V1CKhSTjdaHJk4VgJoyhE
         BOYksuzheU3sgRDAFutsHxiAzQhnS/H7dNX6g+VyT3XiAitRSg9xxGCQSAJ0ODScWL
         CexEGZVjsqE2g==
Received: by pali.im (Postfix)
        id CF217A32; Fri, 15 Jul 2022 10:01:55 +0200 (CEST)
Date:   Fri, 15 Jul 2022 10:01:55 +0200
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     kernel test robot <lkp@intel.com>, kbuild-all@lists.01.org,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Russell King <linux@armlinux.org.uk>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] arm: ioremap: Fix compilation of code which use
 pci_remap_iospace() without CONFIG_MMU
Message-ID: <20220715080155.pwk724qxfv67px36@pali>
References: <20220714185700.6137-1-pali@kernel.org>
 <CAK8P3a25JH4=XdS_QRBdTpLhsLyc13XYjt9xq8FcXCNUf+DTiQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAK8P3a25JH4=XdS_QRBdTpLhsLyc13XYjt9xq8FcXCNUf+DTiQ@mail.gmail.com>
User-Agent: NeoMutt/20180716
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 14 July 2022 22:19:51 Arnd Bergmann wrote:
> On Thu, Jul 14, 2022 at 8:57 PM Pali Rohár <pali@kernel.org> wrote:
> >
> > Custom ARM version of pci_remap_iospace() is implemented only for MMU
> > kernel builds. So do not define pci_remap_iospace() without CONFIG_MMU.
> >
> > See compilation failures:
> > https://lore.kernel.org/r/202112040150.wvyJZIZO-lkp@intel.com/
> > https://lore.kernel.org/r/202112261802.u9iXqdWh-lkp@intel.com/
> > https://lore.kernel.org/r/202201131529.A2s7rKQc-lkp@intel.com/
> > https://lore.kernel.org/r/202203090147.24cUL0De-lkp@intel.com/
> >
> > Fixes: bc02973a06a6 ("arm: ioremap: Implement standard PCI function pci_remap_iospace()")
> > Reported-by: kernel test robot <lkp@intel.com>
> > Signed-off-by: Pali Rohár <pali@kernel.org>
> >
> > ---
> >
> > PING!!!! Is somebody interested in fixing these compile errors? As nobody
> > answered to my emails where I proposed this fix more than half year ago and
> > asked for opinion...
> >
> > https://lore.kernel.org/r/20211204022131.bmhla4gkph7s7hy2@pali/
> > https://lore.kernel.org/r/20211205123209.lyx76daqdwzqwex4@pali/
> > https://lore.kernel.org/r/20211226215135.blcnafbuwhrq5ram@pali/
> > https://lore.kernel.org/r/20220113134938.3tx7iiukphvazvsq@pali/
> > https://lore.kernel.org/r/20220308184851.jmw2xvrapy5wzwof@pali/
> >
> 
> Are you sure this still happens in mainline kernels? Since
> commit 2f618d5ef5dd ("ARM: remove support for NOMMU ARMv4/v5")
> it should no longer be possible to disable the MMU in any Arm machines
> other than the Cortex-M based ones, which do not support PCI.
> 
>          Arnd

I do not know, it it bot who is complaining.
