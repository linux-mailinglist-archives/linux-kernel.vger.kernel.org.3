Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBBAC5753C3
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jul 2022 19:10:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240146AbiGNRKU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jul 2022 13:10:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231892AbiGNRKS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jul 2022 13:10:18 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 426884B0E4;
        Thu, 14 Jul 2022 10:10:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 03399B82775;
        Thu, 14 Jul 2022 17:10:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47A68C34114;
        Thu, 14 Jul 2022 17:10:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657818614;
        bh=vDQxXLVTJFK74v+ZithVlCtCKw4wiZkU9/wB6juRoEU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=bvL7bvjMsOvuOQmCDwSwj5lzPREWDmApOpqeLXKQjmN3bg3cEBG5r6MfUcq5AseHG
         dDQO/LSkZM5CqWu93miSLvmLCdAwrCwCaWjFCjV0CFwtdm6pWrKrBY0B1hhZoG+V8F
         FEqCme8WNY+uER2OitXOKLcnVG5CrrHdmk4MYMYbstWs9nRCcwP2mcVWeverfWC443
         YyG9LN2As52rL+2ykwheYKPlcwLbiuBWCELDi194WRK8IiY8st/YdpTYpesW98hTl5
         IBSCgGsbjeiy/ChNeVpgfofYwf3S7arLJO85A7a7rKAfr3Lfem71hN3mUFK/ZlNS5K
         gv4wGle0dKf9g==
Date:   Thu, 14 Jul 2022 12:10:12 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Richard Zhu <hongxing.zhu@nxp.com>
Cc:     l.stach@pengutronix.de, bhelgaas@google.com, robh+dt@kernel.org,
        broonie@kernel.org, lorenzo.pieralisi@arm.com, festevam@gmail.com,
        francesco.dolcini@toradex.com, linux-pci@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel@pengutronix.de, linux-imx@nxp.com
Subject: Re: [PATCH v15 0/17] PCI: imx6: refine codes and add the error
 propagation
Message-ID: <20220714171012.GA1029546@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1657783869-19194-1-git-send-email-hongxing.zhu@nxp.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 14, 2022 at 03:30:52PM +0800, Richard Zhu wrote:
> This series patches refine pci-imx6 driver and do the following main changes.
> - Encapsulate the clock enable into one standalone function
> - Add the error propagation from host_init and resume
> - Turn off regulator when the system is in suspend mode
> - Let the probe successfully when link never comes up
> - Do not hide the phy driver callbacks in core reset and clk_enable.
> - Keep symmetric as much as possible between suspend and resume callbacks.
> BTW, this series are verified on i.MX8MM EVK board when one NVME is used.
> 
> Main changes from v14 to v15 refer to Lucas' comments and Bjorn's suggestions:
> Only the five patches listed below have changes.
> 10/17
> - Remove regulator_disable() from imx6_pcie_shutdown() and update the commit
>   log accordingly refer to Lucas' comments.
> 11/17
> - Move the regulator enable before the PHY init and core reset assert to
>   avoid introducing more failure cleanup paths refer to Lucas' comments.
> 14/17 has the codes conflictions.
> - Rebase the 14/17 patch because of the codes conflictions introduced by
>   previous 11/17 new changes.
> 16/17
> - Add the missing the IMX8MQ case and drop the default case in
>   imx6_pcie_ltssm_disable() refer to Lucas' comments.
> 17/17
> - Rebase the codes and resolve the codes conflictions introduced by
>   previous 11/17 new changes.
> - Correct one failure cleanup in imx6_pcie_host_init().
> 
> Main changes from v13 to v14 refer to Bjorn's comments:
> - To keep suspend/resume symmetric as much as possible. Create
>   imx6_pcie_stop_link() and imx6_pcie_host_exit() functions, and invoke
>   them in suspend callback.
> - Since the imx6_pcie_clk_disable() is invoked by imx6_pcie_host_exit(),
>   to be symmetric with imx6_pcie_host_exit(), move imx6_pcie_clk_enable()
>   to imx6_pcie_host_init() from imx6_pcie_deassert_core_reset().
> 
> Main changes from v12 to v13:
> - Call imx6_pcie_host_init() instead of duplicating codes in resume.
> - Move the regulator enable out of imx6_pcie_deassert_core_reset().
>   Re-format the error handling in imx6_pcie_deassert_core_reset()
>   and imx6_pcie_host_init() accordingly.
> 
> Main changes from v11 to v12 issued by Bjorn:
> - Add four intro patches to move code around to collect similar things
>   (PHY management, reset management) together.  This makes the first
>   diff to collect clock enables simpler because it's not cluttered with
>   unrelated things that didn't actually change.
> - Factor out ref clock disables so the disable function structure matches
>   the enable structure.
> - Drop unused "ret" from "Reduce resume time ..." to avoid bisection
>   hole, then add it back in "Do not hide phy driver ..." where we start
>   using it again.
> - Add patch to make imx6_pcie_clk_disable() symmetric with
>   imx6_pcie_clk_enable() in terms of enable/disable ordering.
> 
> Main changes from v10 to v11:
> No code changes, just do the following operations refer to Bjorn's comments.
>   - Split #6 patch into two patches.
>   - Rebase to v5.19-rc1 based on for-next branch of Shawn's git.
> 
> Main changes from v9 to v10:
> - Add the "Reviewed-by: Lucas Stach <l.stach@pengutronix.de>" tag into #3
>   and #4 patches.
> - Refer to Bjorn's comments:
>   - refine the commit of the first patch
>   - keep alignment of the message format in the second patch
>   - More specific commit and subject of the #5 and #7 patches.
> - Move the regualtor_disable into suspend, turn off the regulator when bus
>   is powered off and system in suspend mode.
> - Let the driver probe successfully, return zero in imx6_pcie_start_link()
>   when PCIe link is down. 
>   In this link down scenario, only start the PCIe link training in resume
>   when the link is up before system suspend to avoid the long latency in
>   the link training period.
> - Don't hide phy driver callbacks in core reset and clk_enable, and refine
>   the error handling accordingly.
> - Drop the #8 patch of v9 series, since the clocks and powers are not gated
>   off anymore when link is down.
> 
> Main changes from v8 to v9:
> - Don't change pcie-designware codes, and do the error exit process only in
>   pci-imx6 driver internally.
> - Move the phy driver callbacks to the proper places
> 
> Main changes from v7 to v8:
> Regarding Bjorn's review comments.
> - Align the format of the dev_info message and refine commit log of
>   #6/7/8 patches.
> - Rename the err_reset_phy label, since there is no PHY reset in the out
> 
> Main changes from v6 to v7:
> - Keep the regulator usage counter balance in the #5 patch of v6 series.
> 
> Main changes from v5 to v6:
> - Refer to the following discussion with Fabio, fix the dump by his patch.
>   https://patchwork.kernel.org/project/linux-pci/patch/1641368602-20401-6-git-send-email-hongxing.zhu@nxp.com/
>   Refine and rebase this patch-set after Fabio' dump fix patch is merged.
> - Add one new #4 patch to disable i.MX6QDL REF clock too when disable clocks
> - Split the regulator refine codes into one standalone patch #5 in this version.
> 
> Main changes from v4 to v5:
> - Since i.MX8MM PCIe support had been merged. Based on Lorenzo's git repos,
>   resend the patch-set after rebase.
> 
> Main changes from v3 to v4:
> - Regarding Mark's comments, delete the regulator_is_enabled() check.
> - Squash #3 and #6 of v3 patch into #5 patch of v4 set.
> 
> Main changes from v2 to v3:
> - Add "Reviewed-by: Lucas Stach <l.stach@pengutronix.de>" tag into
>   first two patches.
> - Add a Fixes tag into #3 patch.
> - Split the #4 of v2 to two patches, one is clock disable codes move,
>   the other one is the acutal clock unbalance fix.
> - Add a new host_exit() callback into dw_pcie_host_ops, then it could be
>   invoked to handle the unbalance issue in the error handling after
>   host_init() function when link is down.
> - Add a new host_exit() callback for i.MX PCIe driver to handle this case
>   in the error handling after host_init.
> 
> Main changes from v1 to v2:
> Regarding Lucas' comments.
>   - Move the placement of the new imx6_pcie_clk_enable() to avoid the
>     forward declarition.
>   - Seperate the second patch of v1 patch-set to three patches.
>   - Use the module_param to replace the kernel command line.
> Regarding Bjorn's comments:
>   - Use the cover-letter for a multi-patch series.
>   - Correct the subject line, and refine the commit logs. For example,
>     remove the timestamp of the logs.
> 
> Bjorn Helgaas (5):
>   PCI: imx6: Move imx6_pcie_grp_offset(), imx6_pcie_configure_type()
>     earlier
>   PCI: imx6: Move PHY management functions together
>   PCI: imx6: Move imx6_pcie_enable_ref_clk() earlier
>   PCI: imx6: Factor out ref clock disable to match enable
>   PCI: imx6: Disable clocks in reverse order of enable
> 
> Richard Zhu (12):
>   PCI: imx6: Move imx6_pcie_clk_disable() earlier
>   PCI: imx6: Collect clock enables in imx6_pcie_clk_enable()
>   PCI: imx6: Propagate .host_init() errors to caller
>   PCI: imx6: Disable i.MX6QDL clock when disabling ref clocks
>   PCI: imx6: Call host init function directly in resume
>   PCI: imx6: Turn off regulator when system is in suspend mode
>   PCI: imx6: Move regulator enable out of
>     imx6_pcie_deassert_core_reset()
>   PCI: imx6: Mark the link down as non-fatal error
>   PCI: imx6: Reduce resume time by only starting link if it was up
>     before suspend
>   PCI: imx6: Do not hide phy driver callbacks and refine the error
>     handling
>   PCI: imx6: Move the imx6_pcie_ltssm_disable() earlier
>   PCI: imx6: Reformat suspend callback to keep symmetric with resume
> 
> drivers/pci/controller/dwc/pci-imx6.c | 660 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++------------------------------------------------
> 1 file changed, 357 insertions(+), 303 deletions(-)

Applied to pci/ctrl/imx6 for v5.20, thanks!
