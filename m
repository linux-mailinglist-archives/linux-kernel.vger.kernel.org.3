Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4BB8574C39
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jul 2022 13:35:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238958AbiGNLfP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jul 2022 07:35:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238944AbiGNLfM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jul 2022 07:35:12 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76F34599DA;
        Thu, 14 Jul 2022 04:35:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 1E12DB82491;
        Thu, 14 Jul 2022 11:35:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E76AC34114;
        Thu, 14 Jul 2022 11:35:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1657798507;
        bh=GoPENEZo+F+yKjXbviWObMwoSO/Kysv/2liCtyZrmTk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=1KfLNB6EuC7vE7Pl/wY1g5ijbMVKCRxztSyFddc4BAzG+XfLNoi3gMCgSWY4HdUrr
         FuqXf/GTvTDdyht0HSzrOCtdapt7PuxdrifMbVvR0WOzxQlUcsPGdgPpo31j7YzMbz
         BiTsWTry44+HQontWt/cjm70WQu/8k3IuYW2HyC0=
Date:   Thu, 14 Jul 2022 13:35:04 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Michal Simek <michal.simek@amd.com>
Cc:     Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>,
        linux-clk@vger.kernel.org, git <git@xilinx.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Arnd Bergmann <arnd@arndb.de>, robh+dt@kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v14 0/5] clk: clocking-wizard: Driver updates
Message-ID: <Ys//aPLkLGaooYYw@kroah.com>
References: <20220411100443.15132-1-shubhrajyoti.datta@xilinx.com>
 <155c77c3-25d9-7edc-35bd-56e6cfb19ac6@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <155c77c3-25d9-7edc-35bd-56e6cfb19ac6@amd.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 14, 2022 at 01:26:58PM +0200, Michal Simek wrote:
> Hi Stephen and Michael,
> 
> On 4/11/22 12:04, Shubhrajyoti Datta wrote:
> > The patch does the following
> > Update the versions of the clocking wizard ip.
> > Move from staging to clk directory.
> > Update the bindings.
> > 
> > v12:
> > No change.
> > Rebased
> > v13:
> > Update the clocking compatible
> > Add the change removing the driver from staging
> > v14:
> > Moved to the xilinx folder
> > 
> > Shubhrajyoti Datta (5):
> >    dt-bindings: add documentation of xilinx clocking wizard
> >    clk: clocking-wizard: Add the clockwizard to clk directory
> >    clk: clocking-wizard: Rename nr-outputs to xlnx,nr-outputs
> >    clk: clocking-wizard: Fix the reconfig for 5.2
> >    clk: clocking-wizard: Update the compatible
> > 
> >   .../bindings/clock/xlnx,clocking-wizard.yaml  | 77 +++++++++++++++++++
> >   drivers/clk/xilinx/Kconfig                    | 11 +++
> >   drivers/clk/xilinx/Makefile                   |  1 +
> >   .../xilinx}/clk-xlnx-clock-wizard.c           | 19 +++--
> >   drivers/staging/Kconfig                       |  2 -
> >   drivers/staging/Makefile                      |  1 -
> >   drivers/staging/clocking-wizard/Kconfig       | 10 ---
> >   drivers/staging/clocking-wizard/Makefile      |  2 -
> >   drivers/staging/clocking-wizard/TODO          | 13 ----
> >   .../staging/clocking-wizard/dt-binding.txt    | 30 --------
> >   10 files changed, 103 insertions(+), 63 deletions(-)
> >   create mode 100644 Documentation/devicetree/bindings/clock/xlnx,clocking-wizard.yaml
> >   rename drivers/{staging/clocking-wizard => clk/xilinx}/clk-xlnx-clock-wizard.c (96%)
> >   delete mode 100644 drivers/staging/clocking-wizard/Kconfig
> >   delete mode 100644 drivers/staging/clocking-wizard/Makefile
> >   delete mode 100644 drivers/staging/clocking-wizard/TODO
> >   delete mode 100644 drivers/staging/clocking-wizard/dt-binding.txt
> > 
> 
> I was looking at comment in v13 and moving to xilinx folder was done in v14.
> v13: https://lore.kernel.org/r/cover.1631623906.git.shubhrajyoti.datta@xilinx.com
> 
> dt binding is also reviewed by Rob already.
> 
> You asked there to get confirmation from Greg that it can be moved out of
> staging. I didn't see any reply from Greg about it but not sure if this is
> really required to get.
> Greg: Can you please ACK it or comment?

No objection from me if others want to maintainer it in their portion of
the kernel tree:

Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

