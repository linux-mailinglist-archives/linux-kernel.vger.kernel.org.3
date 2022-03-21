Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4AE8C4E2496
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Mar 2022 11:46:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346422AbiCUKsO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Mar 2022 06:48:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235884AbiCUKsM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 06:48:12 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C08A37BD0;
        Mon, 21 Mar 2022 03:46:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2087F6136D;
        Mon, 21 Mar 2022 10:46:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6890FC340E8;
        Mon, 21 Mar 2022 10:46:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647859606;
        bh=Vs+nyNU9WPQ7f8z0iHRRvmd6m3Jk9pFLsFcqph9kasw=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=Xji8JWciE6aQU4muZlCqsXcPBYs396Lv+H94GDwIbQ9/JgGfmEcT1Ru8w9v5r3eK1
         GejAAaXmPvVz+VQVXhdS6xmTFx4MqNh6bhzPlM6ngzQ6UrZC/AT5a+Sgwf3Dt42MgK
         9Nm8UCn8nUNLdjCRnDZit52AZUUXmW2HbN2QhCUZsr154vfgYEfk3JSnUz0z5hgk7/
         /RY0KbZco0vn+vhyix376c0Be74gjmbtQyseHFK1mzMk8h0mURjACj891Abpv3dMUz
         07Lz+HataH0ZP7cYJ3UC2A1/EauM/ty+h1ywrK+3fmHHHJYvSMrKzEGFh1Jt1qLa5y
         Y9xm6hR1q4teg==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v6 2/2] ath10k: Trigger sta disconnect on hardware restart
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20220315082944.12406-3-youghand@codeaurora.org>
References: <20220315082944.12406-3-youghand@codeaurora.org>
To:     Youghandhar Chintala <youghand@codeaurora.org>
Cc:     ath10k@lists.infradead.org, linux-wireless@vger.kernel.org,
        linux-kernel@vger.kernel.org, pillair@codeaurora.org,
        dianders@chromium.org, kuabhs@chromium.org,
        briannorris@chromium.org, mpubbise@codeaurora.org,
        Youghandhar Chintala <youghand@codeaurora.org>
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-ID: <164785960237.19083.15185904446289698730.kvalo@kernel.org>
Date:   Mon, 21 Mar 2022 10:46:44 +0000 (UTC)
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Youghandhar Chintala <youghand@codeaurora.org> wrote:

> Currently after the hardware restart triggered from the driver,
> the station interface connection remains intact, since a disconnect
> trigger is not sent to userspace. This can lead to a problem in
> targets where the wifi mac sequence is added by the firmware.
> 
> After the target restart, its wifi mac sequence number gets
> reset to zero. Hence AP to which our device is connected will receive
> frames with a  wifi mac sequence number jump to the past, thereby
> resulting in the AP dropping all these frames, until the frame
> arrives with a wifi mac sequence number which AP was expecting.
> 
> To avoid such frame drops, its better to trigger a station disconnect
> upon target hardware restart which can be done with API
> ieee80211_reconfig_disconnect exposed to mac80211.
> 
> The other targets are not affected by this change, since the hardware
> params flag is not set.
> 
> Tested-on: WCN3990 hw1.0 SNOC WLAN.HL.3.1-01040-QCAHLSWMTPLZ-1
> Tested-on: QCA6174 hw3.2 PCI WLAN.RM.4.4.1-00110-QCARMSWP-1
> Tested-on: QCA6174 hw3.2 SDIO WLAN.RMH.4.4.1-00048
> 
> Signed-off-by: Youghandhar Chintala <youghand@codeaurora.org>
> Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>

Patch applied to ath-next branch of ath.git, thanks.

2c3fc50591ff ath10k: Trigger sta disconnect on hardware restart

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20220315082944.12406-3-youghand@codeaurora.org/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

