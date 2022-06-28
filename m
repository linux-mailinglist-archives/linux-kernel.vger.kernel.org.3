Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF81955DD4F
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:27:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230249AbiF1MUO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jun 2022 08:20:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345577AbiF1MUK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 08:20:10 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D36322AC53
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jun 2022 05:20:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 7E10FB81DF3
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jun 2022 12:20:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DEA15C341CA;
        Tue, 28 Jun 2022 12:20:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1656418807;
        bh=LybbThQzxWLhYysMYiiW1Rvr4yWJp9Yvdf9kzM0kFKw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=iq3VlpjyZHuGz1eeKec39S453iHKXRbCUiatP1MJXtfAfG39NXwi1TbJ23tNQbWs+
         sET63SaMTt6G4gVJbHVpRSWvrggT1mHNhEYzF+jw0GBLMPuLrGw5B8M+wg8hB3a5W6
         3oZ/vfZlpgGS0tIHlpqykVLQv6xaen3/coEpei8o=
Date:   Tue, 28 Jun 2022 14:20:04 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Oded Gabbay <ogabbay@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 00/12] Adding Gaudi2 ASIC support to habanalabs driver
Message-ID: <Yrrx9NBjVxmv3IFD@kroah.com>
References: <20220628105958.1254875-1-ogabbay@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220628105958.1254875-1-ogabbay@kernel.org>
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 28, 2022 at 01:59:46PM +0300, Oded Gabbay wrote:
> I'm sending the v2 of this patch-set after fixing some comments from Greg.
> 
> Changes to each patch are detailed in the relevant patches.
> 
> Patch 6 was added to remove obsolete elements from the device structure.
> 
> Patch 11 in the 1st patch-set, the TPM patch, was removed due to some points
> that Greg raised and I need to investigate and come back with answers.
> 
> Original cover-letter:
> 
> This patch-set adds support for initializing and sending workloads to
> habanalabs next-gen deep-learning training accelerator ASIC, called Gaudi2.
> 
> The Gaudi2 ASIC is based on the same architecture as the Gaudi ASIC and
> therefore, the driver's common code is applicable to it with only a few
> changes. Almost all of the code included in this patch-set is the
> ASIC-depedent code which is different per ASIC.
> 
> The patches details are as follows:
> 
> - Patch 1 adds the necessary registers header files. I took great care of
>   reducing this amount to minimum.
> 
> - Patch 2 adds the Gaudi2 definitions to the uapi file.
> 
> - Patch 3 adds the bulk of the Gaudi2 asic-specific code.
> 
> - Patches 4-6 modify the existing code to initialize the new asic-specific
>   functions and properties and to remove unused elements.
> 
> - Patch 7 adds a generic security module that will be used by Gaudi2, and
>   future ASICs, to initialize the security mechanisms of the device in a
>   common way.
> 
> - Patches 8-11 add various features of Gaudi2 in asic-specific and common code.
> 
> - Patch 12 enables the Gaudi2 code in the driver.
> 
> More details on Gaudi2 Hardware can be found here:
> https://habana.ai/wp-content/uploads/pdf/2022/gaudi2-whitepaper.pdf
> 
> We have already uploaded the updated LLVM compiler for our TPC engine to:
> https://github.com/HabanaAI/tpc_llvm/tree/v1.1.0
> 
> And we are currently working on updating the open-source SynapseAI Core to
> submit workloads to Gaudi2 via the driver.

Look good to me, thanks for the changes!

greg k-h
