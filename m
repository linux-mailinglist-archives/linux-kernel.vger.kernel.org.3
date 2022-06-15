Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 068D554C82F
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 14:11:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346376AbiFOMLN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 08:11:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237334AbiFOMLL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 08:11:11 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 166434ECC7
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 05:11:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1655295061;
        bh=ezOnlosGKAAydv3zO7jEy12Plio79ZRPNcLr5oCfANk=;
        h=X-UI-Sender-Class:From:To:Subject:Date;
        b=eVdRi8NFzgZMhvm39tOzsTq+7RInziJqqsZw1cO2ZjhlsCdmKpkSERmH3gn4obWak
         oo/phsUoH/37hA4AD1+6e9EssAMqC3kziu+K/ja2qbHIb+ZYDsyVwHorJHh2V/KMo6
         9VwTNjHUKRYRbEG95DLL8bN9A+q/dhpXgYNI947s=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [217.61.154.5] ([217.61.154.5]) by web-mail.gmx.net
 (3c-app-gmx-bap28.server.lan [172.19.172.98]) (via HTTP); Wed, 15 Jun 2022
 14:11:01 +0200
MIME-Version: 1.0
Message-ID: <trinity-685a668a-2395-45f2-81e5-53f526863a66-1655295061671@3c-app-gmx-bap28>
From:   Frank Wunderlich <frank-w@public-files.de>
To:     linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
        Robin Murphy <robin.murphy@arm.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Christoph Hellwig <hch@lst.de>
Subject: helping with remapping vmem for dma
Content-Type: text/plain; charset=UTF-8
Date:   Wed, 15 Jun 2022 14:11:01 +0200
Importance: normal
Sensitivity: Normal
X-Priority: 3
X-Provags-ID: V03:K1:prJPJkK3LsA2dyv/B4CgBXInvxwhazHL2+i4NT5HILEb0X3vFX2cw2FHYhNF3WSJuZ6Dh
 jhmKjare/8EgAott0Sca5YAcM35WB3vvDVwE2cfCmpzzTqusTiZ8Zq6eDILWAG17d/5G/fsnZ586
 I8jgOiDFMu6lr/hfrSGxg4/f5ZKAMzmBzODiFRIN5igr7MtzHmHpB68fiJL+gz+YfHZ6guHCqJCt
 DeIXT4zSWnkGfa+akDLPrXRo96raafEoUrhBhKIqJQctZiu4ENZZ0BNQLtNjc8xroQHqEW+1ONgF
 tg=
X-UI-Out-Filterresults: notjunk:1;V03:K0:I5EpnuWbdMs=:ufROBBNVL+7PfkfwLzSBOr
 2RuWzvzA64Ae3f+/XuatqJmvz620Weh1IefvrkyIXvyLA67qUtJtiVDfEaX6LnTAp/xQ5g6GM
 rDiZ3XjUikldjRPWTvVB/7skxGqu5tq5Z4KNloGhXyDeeDhaZAih8X74pbBzN5yB0BN4Om8Ja
 lxCSTBk+uVVp2AUXE/jz4+7tZVF1vZ+DTx7Pqr3Yqo3rfgcRmqDxemgPtAF0T+nQ1YreojLTT
 OU1AtRFpEXZF4A7O8rD5t9ahaB1Gk1+pPAT7xroPav7RXihvjRR1Etef8H9f6eVmp33Xve2kQ
 lX3Eo1y0CUYkWyz+Vx+BOe2XAX/E//9nqmh9lXnxFqVpZ5TYsC+2rwVkMApcOLwb2qXMoMK1M
 8T2GmMDA4srPiO7kRGSS2zQa8NKe1I6Lpf72iYRGEBStv3dZU3CfiMqQpSvdqYqZyorWZ8d9k
 TVcKlTvNOLGbm6ol2prRUXGuUPHNw0lML1K+Mo1A4v3SAPF/7Q+Ps9bOO9Rs6/uZNM+Ua1NT+
 nmOurj7u4hrtjoMS15LiTBjHk42SV168r421WfclqUEbQ5FlAUibXEsH3LHO11B84p5Yp8lV2
 Zw6lyCNJqOmsQtFVXUN1nhrnASqwwaYAr/qBm+a+VnY+HEEd389u5lfSn0c8k/GqOK4P5ucI1
 IVf0Y3kf9Z/iKbNpN2LiCivRaf3QI5jjmrg0QH62vivEofrM+hEkt4TOh6GRcp5Td6gaAxMK1
 lEqZvgIi30Com2Imo/i7oYn4mY6kevap9kufnW/J5BiektwbyYNGhHHYpxRL5wr/drF4ILsMI
 J8k0Nbb
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

i have upported a wifi-driver (mt6625l for armhf) for some time and fall now (at least 5.18) in the
"rejecting DMA map of vmalloc memory" error [1].

maybe anybody here can guide me on how to nail it down and maybe fix it.

as far as i have debugged it, it uses dma_map_single [2] to get dma memory from a previous
allocated memory region.

this function "kalDevPortRead" in [2] is used via macro HAL_PORT_RD [3] (used in HAL_READ_RX_PORT
and HAL_READ_INTR_STATUS in same hal.h file)

HAL_READ_INTR_STATUS is always called with an empty int array as buf which i guess is not the problem.
I think the issue is using the use with an preallocated prSDIOCtrl struct (have not completely traced
it back where it is allocated).

calls of HAL_PORT_RD/HAL_READ_RX_PORT are in nic{,_rx}.c (with sdio-struct) ([4] as example)

maybe there is a simple way to get an address in preallocated memory as replacement for the dma_map_simple call (and the unmap of course).

regards Frank

[1] https://elixir.bootlin.com/linux/latest/source/include/linux/dma-mapping.h#L327
[2] https://github.com/frank-w/BPI-R2-4.14/blob/5.18-main/drivers/misc/mediatek/connectivity/wlan/gen2/os/linux/hif/ahb/ahb.c#L940
[3] https://github.com/frank-w/BPI-R2-4.14/blob/5.18-main/drivers/misc/mediatek/connectivity/wlan/gen2/include/nic/hal.h#L176
[4] https://github.com/frank-w/BPI-R2-4.14/blob/5.18-main/drivers/misc/mediatek/connectivity/wlan/gen2/nic/nic_rx.c#L3604
