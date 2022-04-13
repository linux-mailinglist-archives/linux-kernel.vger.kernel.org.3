Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4F764FF548
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Apr 2022 12:55:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234794AbiDMK5T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Apr 2022 06:57:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbiDMK5R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 06:57:17 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27BF75A085
        for <linux-kernel@vger.kernel.org>; Wed, 13 Apr 2022 03:54:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B8BEA61BBE
        for <linux-kernel@vger.kernel.org>; Wed, 13 Apr 2022 10:54:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C379C385A3;
        Wed, 13 Apr 2022 10:54:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649847296;
        bh=YRSjE5SEipQF3+7DHWCXcFxSxmoQRKjQ24qGlk4pUQ8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=j845OEhK0aDGEHuDBHxDdmbqtiETHCGXzmxb3tReLr7XQgKNzxqFk3B7aO07rHgKE
         XxdD3n2IBI6pYfOekFajFfjT77arlDL/sH+zdsSgVmBrX8IIS+OV4yH04nCI+zVt/O
         7HpYQNk/DTTQgkSO7ZeqkCeNXhKSdLWcrcFCiUOHDGI5+fkugPvGdnzbvfwOcdFoRI
         IbwOT0M1XLOnczZppimPiTDjTuuMASAxeSRWms34wPBI+ZPbQgOJfXIB0JhUWG44eS
         et3nSpmWpIeVcCi1IuSyEbOvOIUriLmc5lk9DCvO/tpjptO9jjGItbmXBf55leBIZ/
         mafbYtarUsgyg==
Date:   Wed, 13 Apr 2022 16:24:51 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Miaoqian Lin <linmq006@gmail.com>
Cc:     Kishon Vijay Abraham I <kishon@ti.com>,
        Tony Lindgren <tony@atomide.com>,
        linux-phy@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] phy: mapphone-mdm6600: Fix PM error handling in
 phy_mdm6600_probe
Message-ID: <Ylar+x3fI9DpmeKB@matsya>
References: <20220105123947.17946-1-linmq006@gmail.com>
 <20220301024615.31899-1-linmq006@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220301024615.31899-1-linmq006@gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01-03-22, 02:46, Miaoqian Lin wrote:
> The pm_runtime_enable will increase power disable depth.
> If the probe fails, we should use pm_runtime_disable() to balance
> pm_runtime_enable(). And use pm_runtime_dont_use_autosuspend() to
> undo pm_runtime_use_autosuspend()
> In the PM Runtime docs:
>     Drivers in ->remove() callback should undo the runtime PM changes done
>     in ->probe(). Usually this means calling pm_runtime_disable(),
>     pm_runtime_dont_use_autosuspend() etc.
> 
> We should do this in error handling.

Applied, thanks

-- 
~Vinod
