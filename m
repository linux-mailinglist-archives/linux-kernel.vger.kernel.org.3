Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 342D84F62F9
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 17:19:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235873AbiDFPSq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Apr 2022 11:18:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235868AbiDFPQn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 11:16:43 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16694215902;
        Wed,  6 Apr 2022 05:16:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 86374B82004;
        Wed,  6 Apr 2022 12:11:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E54D8C385A3;
        Wed,  6 Apr 2022 12:11:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649247085;
        bh=gi/43PSg3s+HncWV4pygeyKCzviOExbVIekcbIkX8Eg=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=LF66WlE+eNojHyvhuXfcyptyUC9bV8RwAoGcAAMBUwA/eQHSMwUBqYTFkZpm/A9JB
         bsSr/KL4JOo4hkRS2ZCFtqB9JC4y2GNGdGRZjTCqTbBolC3t4qjQ4wm3KrBZC5e5bt
         Mz57FFzXk1mF88JMMPHo+7qi20wmUqncyqIiQqCo6LG2BY42sjz/YlkSkrRlD/NdNk
         NlQSRO3JU7/KFNHt+vlHZSOIayN6YPDCCvjpuRegxQr6f6b33ssFTx7q0mdEc9J63K
         XhTXJaYkrKOqLp0r2ysyt0qgTUDxU++/KapRG2oSxUAlXV+1D9InhPKcC7mEBMApxR
         gMHkcVtoBf1WQ==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [v2] brcmfmac: Avoid keeping power to SDIO card unless WOWL is
 used
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20220323083950.414783-1-ulf.hansson@linaro.org>
References: <20220323083950.414783-1-ulf.hansson@linaro.org>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     linux-wireless@vger.kernel.org,
        Yann Gautier <yann.gautier@foss.st.com>,
        Arend van Spriel <aspriel@gmail.com>,
        Franky Lin <franky.lin@broadcom.com>,
        Hante Meuleman <hante.meuleman@broadcom.com>,
        Gustavo Padovan <gustavo.padovan@collabora.com>,
        Adrian Ratiu <adrian.ratiu@collabora.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        brcm80211-dev-list.pdl@broadcom.com, linux-kernel@vger.kernel.org
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-ID: <164924707922.19026.4759219518482379162.kvalo@kernel.org>
Date:   Wed,  6 Apr 2022 12:11:22 +0000 (UTC)
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ulf Hansson <ulf.hansson@linaro.org> wrote:

> Keeping the power to the SDIO card during system wide suspend, consumes
> energy. Especially on battery driven embedded systems, this can be a
> problem. Therefore, let's change the behaviour into allowing the SDIO card
> to be powered off, unless WOWL is supported and enabled.
> 
> Note that, the downside from this change, is that during system resume the
> SDIO card needs to be re-initialized and the FW must be re-programmed. Even
> if this may take some time to complete, it should we worth it, rather than
> draining the battery.
> 
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> Tested-by: Christophe Roullier <christophe.roullier@foss.st.com>
> Reviewed-by: Yann Gautier <yann.gautier@foss.st.com>

Patch applied to wireless-next.git, thanks.

92cadedd9d5f brcmfmac: Avoid keeping power to SDIO card unless WOWL is used

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20220323083950.414783-1-ulf.hansson@linaro.org/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

