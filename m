Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1030B50C525
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Apr 2022 01:46:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229969AbiDVXdV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 19:33:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231755AbiDVXdA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 19:33:00 -0400
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F120CBF73;
        Fri, 22 Apr 2022 16:14:47 -0700 (PDT)
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 23MNEWcV059722;
        Fri, 22 Apr 2022 18:14:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1650669272;
        bh=7XjQZD4KtPOGu7ug5uoIpXVCaFJ8ucmoZCCk+9odcS0=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=eR42Jk6mYCJX8efcm2FAc8Rd1LxSUvnKS6FXuyVAAwEoVwHKe14FbdJiZNCPVbLSe
         kYW1jKUsA2+1PSzIHTePU5vmQstP9e9jEpW/yp0LPgNRnc5+LIg7DXYoJlxc0dXQWo
         d3ZYaGFu9WQcTD2QdbSo9ZI6eVOIyDZF4qHdNlNc=
Received: from DLEE102.ent.ti.com (dlee102.ent.ti.com [157.170.170.32])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 23MNEWw1030768
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 22 Apr 2022 18:14:32 -0500
Received: from DLEE103.ent.ti.com (157.170.170.33) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Fri, 22
 Apr 2022 18:14:32 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Fri, 22 Apr 2022 18:14:32 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 23MNEWTN031542;
        Fri, 22 Apr 2022 18:14:32 -0500
From:   Nishanth Menon <nm@ti.com>
To:     Drew Fustini <dfustini@baylibre.com>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        Dave Gerlach <d-gerlach@ti.com>,
        Tony Lindgren <tony@atomide.com>
CC:     Nishanth Menon <nm@ti.com>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>
Subject: Re: (subset) [PATCH v2 0/2] soc: ti: wkup_m3_ipc: support vtt toggle
Date:   Fri, 22 Apr 2022 18:14:31 -0500
Message-ID: <165066925452.1802.14006320713243100128.b4-ty@ti.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220409211215.2529387-1-dfustini@baylibre.com>
References: <20220409211215.2529387-1-dfustini@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Drew Fustini,

On Sat, 9 Apr 2022 14:12:13 -0700, Drew Fustini wrote:
> This series enables the Cortex M3 processor found in AM33xx and AM43xx
> SoCs to toggle the VTT regulator during low power mode transitions.
> 
> I recently converted the Wakeup M3 IPC bindings to YAML. Rob has applied
> that patch [1]. It is a prerequisite for the wkup-m3-ipc.yaml patch in
> this series.
> 
> [...]

I have applied the following to branch ti-drivers-soc-next on [1].
Thank you!

[2/2] soc: ti: wkup_m3_ipc: Add support for toggling VTT regulator
      commit: f226041424cf87245d39a1b2dfae304308b36b6b

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent up the chain during
the next merge window (or sooner if it is a relevant bug fix), however if
problems are discovered then the patch may be dropped or reverted.

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

[1] git://git.kernel.org/pub/scm/linux/kernel/git/ti/linux.git
-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D

