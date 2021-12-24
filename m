Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF01F47EB6A
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Dec 2021 05:37:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245700AbhLXEhb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Dec 2021 23:37:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240362AbhLXEha (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Dec 2021 23:37:30 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5E09C061401;
        Thu, 23 Dec 2021 20:37:29 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 0CF0BB82251;
        Fri, 24 Dec 2021 04:37:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17CDEC36AE8;
        Fri, 24 Dec 2021 04:37:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1640320645;
        bh=o5SDSUBWw2ZtcjmlpZGs0bUmBos2G1Mi5xXAX5hWM6E=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fyirxl+EnrJu7QK+qD2z3fc3N30l9Ud3cj4fbWBAMxkihTe1ODmjhbgs94AvFLUQC
         t2p/F1rr58uLPLOVy9MrFCYWRRq5dnskQdeO5czkiy+VtQApz1MNPNV9CTcyMwqXMi
         06v/SuyqHVP4QsoDo5tj3RmvSNGnT3pLhaMO8i2kIuL48O1qwA6M2ontVFTOi38uCi
         XbxBcgMleesOOS+x9QGmw8RD1hAjwFnG5DRQBsdcKS8OJ+Tg4sQndAuAU5vvlz7BBC
         7Gz7J0vXUqQGIKVBMCkJ8QfZ11EY57/6oJXgZXC1b1yEPR2XsWOpt2ZlYJYmTZH8AT
         AMf2FI4WTc6zw==
Date:   Fri, 24 Dec 2021 10:07:22 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Kishon Vijay Abraham I <kishon@ti.com>,
        Aswath Govindraju <a-govindraju@ti.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: build failure after merge of the phy-next tree
Message-ID: <YcVOgkEStxUTTEA4@matsya>
References: <20211224140302.33d25020@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211224140302.33d25020@canb.auug.org.au>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24-12-21, 14:03, Stephen Rothwell wrote:
> Hi all,
> 
> After merging the phy-next tree, today's linux-next build (x86_64
> allmodconfig) failed like this:
> 
> drivers/phy/phy-can-transceiver.c: In function 'can_transceiver_phy_power_on':
> drivers/phy/phy-can-transceiver.c:35:9: error: implicit declaration of function 'mux_state_select'; did you mean 'mux_control_select'? [-Werror=implicit-function-declaration]
>    35 |   ret = mux_state_select(can_transceiver_phy->mux_state);
>       |         ^~~~~~~~~~~~~~~~
>       |         mux_control_select
> drivers/phy/phy-can-transceiver.c: In function 'can_transceiver_phy_power_off':
> drivers/phy/phy-can-transceiver.c:59:3: error: implicit declaration of function 'mux_state_deselect'; did you mean 'mux_control_deselect'? [-Werror=implicit-function-declaration]
>    59 |   mux_state_deselect(can_transceiver_phy->mux_state);
>       |   ^~~~~~~~~~~~~~~~~~
>       |   mux_control_deselect
> drivers/phy/phy-can-transceiver.c: In function 'can_transceiver_phy_probe':
> drivers/phy/phy-can-transceiver.c:113:15: error: implicit declaration of function 'devm_mux_state_get'; did you mean 'devm_mux_control_get'? [-Werror=implicit-function-declaration]
>   113 |   mux_state = devm_mux_state_get(dev, NULL);
>       |               ^~~~~~~~~~~~~~~~~~
>       |               devm_mux_control_get
> drivers/phy/phy-can-transceiver.c:113:13: error: assignment to 'struct mux_state *' from 'int' makes pointer from integer without a cast [-Werror=int-conversion]
>   113 |   mux_state = devm_mux_state_get(dev, NULL);
>       |             ^
> cc1: all warnings being treated as errors
> 
> Caused by commit
> 
>   1e68cd3ff73e ("phy: phy-can-transceiver: Add support for setting mux")
> 
> I have used the phy-next tree from next-20211223 for today.

Thanks for letting me know. I have dropped the offending commit


-- 
~Vinod
