Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B084751852A
	for <lists+linux-kernel@lfdr.de>; Tue,  3 May 2022 15:10:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233606AbiECNN3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 May 2022 09:13:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235935AbiECNN1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 May 2022 09:13:27 -0400
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 338D72B259
        for <linux-kernel@vger.kernel.org>; Tue,  3 May 2022 06:09:55 -0700 (PDT)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 243D9oah043839;
        Tue, 3 May 2022 08:09:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1651583390;
        bh=f4HPcsRiI8vom0RSmgtniIM5Igr6j2cgcKBbgGgg70E=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=IMfdVdJM9JGnAS0GbdneUzas6WVtg6A5AG8fQfHEYidXxWPNmE1387uS64vzDcWWV
         CSQhIQsuOnu1LMY5RJgd84m8bK0QCeZye8vP20Vl3ZHJgzUKWoqvPabWdAZEGtrqZY
         YgMaAngOa3kqRfp5NAQUd02CVKClMiDiBLuKbQjg=
Received: from DLEE103.ent.ti.com (dlee103.ent.ti.com [157.170.170.33])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 243D9oFX082944
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 3 May 2022 08:09:50 -0500
Received: from DLEE106.ent.ti.com (157.170.170.36) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Tue, 3
 May 2022 08:09:50 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Tue, 3 May 2022 08:09:49 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 243D9nOo011626;
        Tue, 3 May 2022 08:09:49 -0500
From:   Nishanth Menon <nm@ti.com>
To:     Drew Fustini <dfustini@baylibre.com>,
        Santosh Shilimkar <ssantosh@kernel.org>
CC:     Nishanth Menon <nm@ti.com>, <linux-kernel@vger.kernel.org>,
        Dave Gerlach <d-gerlach@ti.com>,
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH] soc: ti: wkup_m3_ipc: Add debug option to halt m3 in suspend
Date:   Tue, 3 May 2022 08:09:48 -0500
Message-ID: <165158335751.6631.17627635090230319149.b4-ty@ti.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220502033211.1383158-1-dfustini@baylibre.com>
References: <20220502033211.1383158-1-dfustini@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Drew Fustini,

On Sun, 1 May 2022 20:32:12 -0700, Drew Fustini wrote:
> From: Dave Gerlach <d-gerlach@ti.com>
> 
> Add a debugfs option to allow configurable halting of the wkup_m3
> during suspend at the last possible point before low power mode entry.
> This condition can only be resolved through JTAG and advancing beyond
> the while loop in a8_lp_ds0_handler [1]. Although this hangs the system
> it forces the system to remain active once it has been entirely
> configured for low power mode entry, allowing for register inspection
> through JTAG to help in debugging transition errors.
> 
> [...]

I have applied the following to branch ti-drivers-soc-next on [1].
Thank you!

[1/1] soc: ti: wkup_m3_ipc: Add debug option to halt m3 in suspend
      commit: 2a21f9e6d9a408dbd09a01caf5fff42c2f70fa82

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

