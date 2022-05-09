Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 864C751F4A2
	for <lists+linux-kernel@lfdr.de>; Mon,  9 May 2022 08:57:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235422AbiEIGkN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 May 2022 02:40:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235008AbiEIGec (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 May 2022 02:34:32 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CF0A2ED
        for <linux-kernel@vger.kernel.org>; Sun,  8 May 2022 23:30:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 0ADF2B80EA8
        for <linux-kernel@vger.kernel.org>; Mon,  9 May 2022 06:30:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B594C385AB;
        Mon,  9 May 2022 06:30:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652077836;
        bh=DXieFXLBq4ieE8RkkoZNSW7FjctpJuOTdLRbxH7qdmU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JhehAjvyCcEicKiJYLuxM7jPXqRXdGrDQ7YZxKRrouELMebcz7yCCBUice324qwyw
         Rtuw+alC+f5y6hO4rLt3/aEMUNzSA0nsL0Ec3D8YAaapVa8uB6cO1n7txMmJPSItyk
         v68AKRI2x4bc98kxfcR3Ea+XijDESyg1xQUXnrQR2hdztrkqMPAGmlAPQkowRlGhNH
         6QZm7MYN+sUCL1mAPqreqyfJI/M365LdiTl3Dsh4/nCGKbIknaHd9zEiVRHBZnnTv4
         6M3jmnZvrev9JhCcVhJc05QjwCr5s4/qLUpJZm3z8wv7U4WaT3w+gcBZt9aWg3YwnQ
         Je4iUr+fKIT7Q==
Date:   Mon, 9 May 2022 12:00:32 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Bard Liao <yung-chuan.liao@linux.intel.com>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        gregkh@linuxfoundation.org, srinivas.kandagatla@linaro.org,
        pierre-louis.bossart@linux.intel.com, sanyog.r.kale@intel.com,
        bard.liao@intel.com
Subject: Re: [PATCH] soundwire: cadence: recheck device0 attachment after
 status change
Message-ID: <Yni1CKb20D99kAce@matsya>
References: <20220420023039.14144-1-yung-chuan.liao@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220420023039.14144-1-yung-chuan.liao@linux.intel.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20-04-22, 10:30, Bard Liao wrote:
> From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
> 
> This patch adds a status check after device0 attachment to solve race
> conditions observed during attachment with multiple devices per link
> 
> The sequence is the following
> 
> 1) deviceA attaches as device0
> 
> 2) the hardware detects a device0 status change and throws an
>  interrupt.
> 
> 3) the interrupt handler schedules the work function
> 
> 4) the workqueue starts, we read the status
> slave0 = cdns_readl(cdns, CDNS_MCP_SLAVE_INTSTAT0);
> slave1 = cdns_readl(cdns, CDNS_MCP_SLAVE_INTSTAT1);
> 
> we deal with the status change and program deviceA device number to a
> non-zero value.
> 
> 5) deviceB attaches as device0, the device0 status seen by the
> hardware does not change.
> 
> 6) we clear the CDNS_MCP_SLAVE_INTSTAT0/1 registers -> we will never detect
> deviceB!
> 
> This patch suggest re-checking in a loop the device0 status with a
> PING frame, i.e. using the real device0 status instead of information
> on status changes.

Applied, thanks

-- 
~Vinod
