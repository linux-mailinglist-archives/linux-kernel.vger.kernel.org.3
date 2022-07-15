Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA8CF57656B
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jul 2022 18:51:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231317AbiGOQso (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jul 2022 12:48:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229771AbiGOQsl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jul 2022 12:48:41 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EB0E267C
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jul 2022 09:48:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C4B09B82D21
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jul 2022 16:48:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29114C34115;
        Fri, 15 Jul 2022 16:48:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657903717;
        bh=7nCXiwhGkmmW2s7T5Yi43qsIhqbsZvIWOtkF2dkQC9s=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=sSVK6zWm9ogupRm0gxfDMjRI8ElePOS+x+8CyYUFHQTS4VtN9vLPA+yr1QEYl6wA4
         HUD4jWOi+9okoxF/KUhv7B8XFhdADLkwoGvo8ntFC+fAlJpSPJvYPno4jfZURA6WKg
         GIv0F3Y4bciNBt9Br1/4CltCL1bIK/gbbLlNrQDGQ1UJJoD3vhs4dW2ZRu6SJov4jH
         xfM+TTW0WtgiVWug1ym+wfD8FgmRLnFPgfIHrEY2IZOPAWDtXLLcPQCcjECaBglvAH
         SkLZhKytdZg5VyVxVaoUi11M1XTKL1YfbfXqerpwti8d3VeffDd727qey28g6uo9Mk
         76ickshCb/cpA==
Date:   Fri, 15 Jul 2022 11:48:35 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Pali =?iso-8859-1?Q?Roh=E1r?= <pali@kernel.org>,
        kernel test robot <lkp@intel.com>, kbuild-all@lists.01.org,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Russell King <linux@armlinux.org.uk>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] arm: ioremap: Fix compilation of code which use
 pci_remap_iospace() without CONFIG_MMU
Message-ID: <20220715164835.GA1138891@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAK8P3a25JH4=XdS_QRBdTpLhsLyc13XYjt9xq8FcXCNUf+DTiQ@mail.gmail.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 14, 2022 at 10:19:51PM +0200, Arnd Bergmann wrote:
> On Thu, Jul 14, 2022 at 8:57 PM Pali Rohár <pali@kernel.org> wrote:
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
> 
> Are you sure this still happens in mainline kernels? Since
> commit 2f618d5ef5dd ("ARM: remove support for NOMMU ARMv4/v5")
> it should no longer be possible to disable the MMU in any Arm machines
> other than the Cortex-M based ones, which do not support PCI.

I don't know whether it happens in mainline kernels either.

But even if the 2f618d5ef5dd Kconfiggery makes MMU mostly obsolete for
Arm, it seems a little weird that io.h unconditionally promises an
arch-specific implementation of pci_remap_iospace(), but we only
provide it when CONFIG_MMU=y.

It seems like it'd be a little cleaner if the same condition
determined visibility of both the declaration and the definition.

Bjorn
