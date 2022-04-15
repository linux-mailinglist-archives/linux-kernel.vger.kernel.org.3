Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19466502F7E
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Apr 2022 22:06:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350682AbiDOUHB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Apr 2022 16:07:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350006AbiDOUG7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Apr 2022 16:06:59 -0400
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4858A1260F
        for <linux-kernel@vger.kernel.org>; Fri, 15 Apr 2022 13:04:28 -0700 (PDT)
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 23FK4CsV030923;
        Fri, 15 Apr 2022 15:04:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1650053052;
        bh=y+wTU7sizsD3IvJnJ8WjOkdWobCLqTAYCbGo3eQv6f8=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=jYmJTWoargiNuJlbvKUoy4e9fbnu/3G3jF0eH61o+5kTlkR8Dq8NvWdhKvobNDgsr
         cMN5Z8FMVzLwOnuPTJlgvYWVYWyKUKEy296gzOe9ym07owlOCkCe1s09+EQEc3/HZp
         mNrdeXzR3k4e32SPFjFYYzlEaS9rc+TcUmqbtKrc=
Received: from DLEE101.ent.ti.com (dlee101.ent.ti.com [157.170.170.31])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 23FK4CbG036732
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 15 Apr 2022 15:04:12 -0500
Received: from DLEE108.ent.ti.com (157.170.170.38) by DLEE101.ent.ti.com
 (157.170.170.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Fri, 15
 Apr 2022 15:04:11 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Fri, 15 Apr 2022 15:04:11 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 23FK4Bqx016000;
        Fri, 15 Apr 2022 15:04:11 -0500
From:   Nishanth Menon <nm@ti.com>
To:     <linux-kernel@vger.kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>
CC:     Nishanth Menon <nm@ti.com>, <linux-arm-kernel@lists.infradead.org>,
        Tero Kristo <kristo@kernel.org>,
        Santosh Shilimkar <ssantosh@kernel.org>
Subject: Re: [PATCH] reset: ti-sci: allow building under COMPILE_TEST
Date:   Fri, 15 Apr 2022 15:04:11 -0500
Message-ID: <165005302006.19932.6167337115482683498.b4-ty@ti.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220404094500.2708816-1-p.zabel@pengutronix.de>
References: <20220404094500.2708816-1-p.zabel@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Philipp Zabel,

On Mon, 4 Apr 2022 11:45:00 +0200, Philipp Zabel wrote:
> Since commit 043cfff99a18 ("firmware: ti_sci: Fix compilation failure
> when CONFIG_TI_SCI_PROTOCOL is not defined") it is possible to build
> reset-ti-sci under CONFIG_COMPILE_TEST.
> 
> 

I have applied the following to branch ti-drivers-soc-next on [1].
Thank you!

[1/1] reset: ti-sci: allow building under COMPILE_TEST
      commit: a6af504184c981efd253f986e6fc54db57b1d39f

(minor edit: Capitalized "A" in allow in $subject)

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

