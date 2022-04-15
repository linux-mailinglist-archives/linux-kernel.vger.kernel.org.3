Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3771B502F79
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Apr 2022 22:03:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350188AbiDOUFK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Apr 2022 16:05:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237323AbiDOUFI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Apr 2022 16:05:08 -0400
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E1B4AC932
        for <linux-kernel@vger.kernel.org>; Fri, 15 Apr 2022 13:02:39 -0700 (PDT)
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 23FK2Y1v071240;
        Fri, 15 Apr 2022 15:02:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1650052954;
        bh=xaBNCcLxYeeG0qKCjQVB0DRbbiOwazzl1nKIfO4Zqbk=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=Qe7WwAm1Bk9J396N3mFVR33BIAQtrO8ETtUlWgljp41cDXM3XSXtwCFV9lP5SX7WQ
         VrFgh7BJBmSr/MhIaOCbv9JMlzcFF5MFbd4Y3YL3HV4SSUKuKNFc0hE6NXWwgg04Cn
         dtXOFSnc3SOnPGe4RXkwLgfUSCUVVe/aBUIyrJJQ=
Received: from DLEE103.ent.ti.com (dlee103.ent.ti.com [157.170.170.33])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 23FK2YTv035851
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 15 Apr 2022 15:02:34 -0500
Received: from DLEE111.ent.ti.com (157.170.170.22) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Fri, 15
 Apr 2022 15:02:34 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Fri, 15 Apr 2022 15:02:34 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 23FK2Y0u014889;
        Fri, 15 Apr 2022 15:02:34 -0500
From:   Nishanth Menon <nm@ti.com>
To:     <kristo@kernel.org>, QintaoShen <unSimple1993@163.com>
CC:     Nishanth Menon <nm@ti.com>, <linux-kernel@vger.kernel.org>,
        <ssantosh@kernel.org>, <d-gerlach@ti.com>
Subject: Re: [PATCH v1] soc: ti: ti_sci_pm_domains: Check for null return of devm_kcalloc
Date:   Fri, 15 Apr 2022 15:02:33 -0500
Message-ID: <165005283988.16277.2709789836252162848.b4-ty@ti.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <1648107843-29077-1-git-send-email-unSimple1993@163.com>
References: <1648107843-29077-1-git-send-email-unSimple1993@163.com>
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

Hi QintaoShen,

On Thu, 24 Mar 2022 15:44:03 +0800, QintaoShen wrote:
> The allocation funciton devm_kcalloc may fail and return a null pointer,
> which would cause a null-pointer dereference later.
> It might be better to check it and directly return -ENOMEM just like the
> usage of devm_kcalloc in previous code.
> 
> 

I have applied the following to branch ti-drivers-soc-next on [1].
Thank you!

[1/1] soc: ti: ti_sci_pm_domains: Check for null return of devm_kcalloc
      commit: ba56291e297d28aa6eb82c5c1964fae2d7594746

Sidenote: [PATCH] is sufficient for v1 of the patch, it is understood to be
 default indexed from 1 ;). Ofcourse, an update of the patch would have been
 posted as [PATCH V2] and so on..

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

