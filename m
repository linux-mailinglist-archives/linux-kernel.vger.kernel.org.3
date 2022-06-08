Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2848542EB6
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jun 2022 13:06:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237748AbiFHLGX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jun 2022 07:06:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233907AbiFHLGV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jun 2022 07:06:21 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE43617ED23;
        Wed,  8 Jun 2022 04:06:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 76D0961225;
        Wed,  8 Jun 2022 11:06:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98324C34116;
        Wed,  8 Jun 2022 11:06:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654686378;
        bh=B7KiNiEUm0hM3MxGWL8mWf3tXwJKwloCq7rFvO2y/LM=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=VpF084q5yRR8y6kSx8weSz0Dm+n2J0qh4FXhuBsX/OR17q1b/RdumQIrCIWMXZ/4D
         v8BNS0GIq5Q3qLKFzByhCxl6Se0INGev4dA37TQLAyWCG6UGiiYAvENiPOw/7HIyb2
         iKBLAxGg9spWF766IWjVmFO2/pGGX5srTDGCxszX9VdBXLRv8dqz1RURKsOD0qPHE0
         tzfnGG9ZIMWvDkT3iltLB6cJRWHmMdHgmGLvVC4A803MHihnpWrKyiJTyK7AkBmcid
         saBxoPENltJO2FTVujmAEqK6CVPs6ltcCfs4uiLOWQCa9hbabduGUA9ot2w9PjUnwg
         7YkGV5ZB6sNvg==
Date:   Wed, 8 Jun 2022 13:06:14 +0200 (CEST)
From:   Jiri Kosina <jikos@kernel.org>
To:     Li Qiong <liqiong@nfschina.com>
cc:     Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Pandruvada@lists.nfsmail.com,
        Srinivas <srinivas.pandruvada@intel.com>,
        Ye Xiang <xiang.ye@intel.com>, Even Xu <even.xu@intel.com>,
        linux-kernel@vger.kernel.org, yuzhe@nfschina.com,
        renyu@nfschina.com, linux-input@vger.kernel.org
Subject: Re: [PATCH 1/2] HID: intel-ish-hid: ipc: use time_before to replace
 "jiffies < a"
In-Reply-To: <20220606134750.20736-1-liqiong@nfschina.com>
Message-ID: <nycvar.YFH.7.76.2206081306090.10851@cbobk.fhfr.pm>
References: <20220606134750.20736-1-liqiong@nfschina.com>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 6 Jun 2022, Li Qiong wrote:

> time_before deals with timer wrapping correctly.
> 
> Signed-off-by: Li Qiong <liqiong@nfschina.com>
> ---
>  drivers/hid/intel-ish-hid/ipc/ipc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/hid/intel-ish-hid/ipc/ipc.c b/drivers/hid/intel-ish-hid/ipc/ipc.c
> index 8ccb246b0114..15e14239af82 100644
> --- a/drivers/hid/intel-ish-hid/ipc/ipc.c
> +++ b/drivers/hid/intel-ish-hid/ipc/ipc.c
> @@ -578,7 +578,7 @@ static void _ish_sync_fw_clock(struct ishtp_device *dev)
>  	static unsigned long	prev_sync;
>  	uint64_t	usec;
>  
> -	if (prev_sync && jiffies - prev_sync < 20 * HZ)
> +	if (prev_sync && time_before(jiffies, prev_sync + 20 * HZ))
>  		return;

Applied, thanks.

-- 
Jiri Kosina
SUSE Labs

