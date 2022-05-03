Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53E84518521
	for <lists+linux-kernel@lfdr.de>; Tue,  3 May 2022 15:08:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235617AbiECNMD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 May 2022 09:12:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234220AbiECNL7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 May 2022 09:11:59 -0400
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB4372B251
        for <linux-kernel@vger.kernel.org>; Tue,  3 May 2022 06:08:22 -0700 (PDT)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 243D7sYr051311;
        Tue, 3 May 2022 08:07:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1651583274;
        bh=+BPTMJnXCFZY1AvrKO5syPBndSeHvxlUjNoLLHha8yQ=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=qyEjcGiqnAtQFn93+C3EGVVxDM8cm4vKdosF+9baFu6NIho3AgM7NFVUzVKb8WxbT
         j+h8iWdlxnU2yEtIwymEDlXZvuO6VA9aQ1RKezacoiwMnxo3xvDqoVEw1jkxqNJsxr
         MskQO1Brg+Dzt5Opf1JIr/BZOUftALb88ANd/Mz8=
Received: from DFLE107.ent.ti.com (dfle107.ent.ti.com [10.64.6.28])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 243D7sgG081310
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 3 May 2022 08:07:54 -0500
Received: from DFLE107.ent.ti.com (10.64.6.28) by DFLE107.ent.ti.com
 (10.64.6.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Tue, 3
 May 2022 08:07:54 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE107.ent.ti.com
 (10.64.6.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Tue, 3 May 2022 08:07:54 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 243D7sgB003767;
        Tue, 3 May 2022 08:07:54 -0500
From:   Nishanth Menon <nm@ti.com>
To:     <kristo@kernel.org>, Dave Gerlach <d-gerlach@ti.com>,
        <ssantosh@kernel.org>
CC:     Nishanth Menon <nm@ti.com>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [RESEND PATCH v2] firmware: ti_sci: Switch transport to polled mode during system suspend
Date:   Tue, 3 May 2022 08:07:54 -0500
Message-ID: <165158326360.6155.2361452626116386271.b4-ty@ti.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220412192138.31189-1-d-gerlach@ti.com>
References: <20220412192138.31189-1-d-gerlach@ti.com>
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

Hi Dave Gerlach,

On Tue, 12 Apr 2022 14:21:38 -0500, Dave Gerlach wrote:
> During system suspend it is completely valid for devices to invoke TISCI
> commands during the noirq phase of the suspend path. Specifically this
> will always be seen for devices that define a power-domains DT property
> and make use of the ti_sci_pm_domains genpd implementation.
> The genpd_finish_suspend call will power off devices during the noirq
> phase, which will invoke TISCI.
> 
> [...]

I have applied the following to branch ti-drivers-soc-next on [1].
Thank you!

[1/1] firmware: ti_sci: Switch transport to polled mode during system suspend
      commit: b9e8a7d950ffed4cdd81e6457cfb8049227da2d1

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

