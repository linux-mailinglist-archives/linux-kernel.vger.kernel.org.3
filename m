Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0524747DF34
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Dec 2021 07:56:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242410AbhLWG4t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Dec 2021 01:56:49 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:39834 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232658AbhLWG4r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Dec 2021 01:56:47 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 10DF661DC8
        for <linux-kernel@vger.kernel.org>; Thu, 23 Dec 2021 06:56:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2AF3C36AE5;
        Thu, 23 Dec 2021 06:56:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1640242606;
        bh=ISmOxWI6u5C+k89d6ZQbgZNWCUXFaswndd35sG+K8z0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=CM5fWh+lMBnLGGltiQMXQB7+PEgxoswhmZAuKApX00qzBb3NfFokxD4noPYkg/cVQ
         wgUdYG/RZMTm/zX3xDONpueRwRrrjkR3y/uhpPDaO/GL42wOkRXpQyjLXzaD6w1lMe
         /TmcrIzy6VnFP2YATaKERGFUIDt4mDY9aYDEgYsQUgym9E9HTZf2pR/QBx12kY+ULs
         T9VABz36aSbtnJAxULLUUtmQ8jcf9vN+QXaY23GsRQ5pn4xd9wGChDwnM/dwRfkxJX
         OqKDW4cVI7xR/d1v/rBco8uIQspbDX86T/MRANXjomdMEXbc62kYTKR2FiTQ4y9xXB
         UuCvjuCx+cuwQ==
Date:   Thu, 23 Dec 2021 12:26:41 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Bard Liao <yung-chuan.liao@linux.intel.com>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        tiwai@suse.de, broonie@kernel.org, gregkh@linuxfoundation.org,
        srinivas.kandagatla@linaro.org,
        pierre-louis.bossart@linux.intel.com, sanyog.r.kale@intel.com,
        bard.liao@intel.com
Subject: Re: [PATCH 3/7] soundwire: intel: improve suspend flows
Message-ID: <YcQdqT6M+W9du8wy@matsya>
References: <20211213054634.30088-1-yung-chuan.liao@linux.intel.com>
 <20211213054634.30088-4-yung-chuan.liao@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211213054634.30088-4-yung-chuan.liao@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13-12-21, 13:46, Bard Liao wrote:
> From: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
> 
> This patch provides both a simplification of the suspend flows and a
> better balanced operation during suspend/resume transition, as part of
> the transition of Sound Open Firmware (SOF) to dynamic pipelines: the
> DSP resources are only enabled when required instead of enabled on
> startup.
> 
> The exiting code relies on a convoluted way of dealing with suspend
> signals. Since there is no .suspend DAI callback, we used the
> component .suspend and marked all the component DAI dmas as
> 'suspended'. The information was used in the .prepare stage to
> differentiate resume operations from xrun handling, and only
> reinitialize SHIM registers and DMA in the former case.
> 
> While this solution has been working reliably for about 2 years, there
> is a much better solution consisting in trapping the TRIGGER_SUSPEND
> in the .trigger DAI ops. The DMA is still marked in the same way for
> the .prepare op to run, but in addition the callbacks sent to DSP
> firmware are now balanced.
> 
> Normal operation:
> hw_params -> intel_params_stream
> hw_free   -> intel_free_stream
> 
> suspend    -> intel_free_stream
> prepare    -> intel_params_stream
> 
> This balanced operation was not required with existing SOF firmware
> relying on static pipelines instantiated at every boot. With the
> on-going transition to dynamic pipelines, it's however a requirement
> to keep the use count for the DAI widget balanced across all
> transitions.
> 
> The component suspend is not removed but instead modified to deal with
> a corner case: when a substream is PAUSED, the ALSA core does not
> throw the TRIGGER_SUSPEND. This is problematic since the refcount for
> all pipelines and widgets is not balanced, leading to issues on
> resume. The trigger callback keeps track of the 'paused' state with a
> new flag, which is tested during the component suspend called later to
> release the remaining DSP resources. These resources will be
> re-enabled in the .prepare step.
> 
> The IPC used in the TRIGGER_SUSPEND to release DSP resources is not a
> problem since the BE dailink is already marked as non-atomic.

Acked-By: Vinod Koul <vkoul@kernel.org>

-- 
~Vinod
