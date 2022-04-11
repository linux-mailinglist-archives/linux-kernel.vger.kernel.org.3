Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 132704FBFB7
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Apr 2022 16:58:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347577AbiDKPA3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Apr 2022 11:00:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244142AbiDKPA1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 11:00:27 -0400
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CF491AD83
        for <linux-kernel@vger.kernel.org>; Mon, 11 Apr 2022 07:58:13 -0700 (PDT)
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 23BEw67i092233;
        Mon, 11 Apr 2022 09:58:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1649689086;
        bh=dw681I1yslqUMjB2/eotxXfGJMuy77gFm406LHAxoZY=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=gtBAtG+mJwUnuCyQsB7zDvjSunPsFR3atB7v6cXWbZzYwrfyx8TfoYQx3tXa3gB5K
         54ejmRjBkVGZ25OCeD1OqdyR1Pp6Cdix4lCtjoyWdXxPVSSLCOGMd3RqlFDGZb/X1h
         Oj67U3C6fSn9CwTRiwHunXgVlfhppKyVKEjaux8g=
Received: from DFLE107.ent.ti.com (dfle107.ent.ti.com [10.64.6.28])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 23BEw6mZ073878
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 11 Apr 2022 09:58:06 -0500
Received: from DFLE103.ent.ti.com (10.64.6.24) by DFLE107.ent.ti.com
 (10.64.6.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Mon, 11
 Apr 2022 09:58:06 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Mon, 11 Apr 2022 09:58:06 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 23BEw6Jf016381;
        Mon, 11 Apr 2022 09:58:06 -0500
From:   Nishanth Menon <nm@ti.com>
To:     Jakob Koschel <jakobkoschel@gmail.com>
CC:     Nishanth Menon <nm@ti.com>,
        Cristiano Giuffrida <c.giuffrida@vu.nl>,
        Mike Rapoport <rppt@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Brian Johannesmeyer <bjohannesmeyer@gmail.com>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        "Bos, H.J." <h.j.bos@vu.nl>
Subject: Re: [PATCH] soc: ti: replace usage of found with dedicated list iterator variable
Date:   Mon, 11 Apr 2022 09:58:06 -0500
Message-ID: <164968906243.29063.1232418858102294654.b4-ty@ti.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220324072503.63244-1-jakobkoschel@gmail.com>
References: <20220324072503.63244-1-jakobkoschel@gmail.com>
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

Hi Jakob Koschel,

On Thu, 24 Mar 2022 08:25:03 +0100, Jakob Koschel wrote:
> To move the list iterator variable into the list_for_each_entry_*()
> macro in the future it should be avoided to use the list iterator
> variable after the loop body.
> 
> To *never* use the list iterator variable after the loop it was
> concluded to use a separate iterator variable instead of a
> found boolean [1].
> 
> [...]

I have applied the following to branch ti-drivers-soc-next on [1].
Thank you!

[1/1] soc: ti: replace usage of found with dedicated list iterator variable
      commit: d281a982c2693c6a7bffaa1ae1ff3b400d6e6c74

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

