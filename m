Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2AAB14B230D
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 11:25:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348868AbiBKKYJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Feb 2022 05:24:09 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:51280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346916AbiBKKYH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Feb 2022 05:24:07 -0500
X-Greylist: delayed 315 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 11 Feb 2022 02:24:01 PST
Received: from forward500j.mail.yandex.net (forward500j.mail.yandex.net [5.45.198.250])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C146D220
        for <linux-kernel@vger.kernel.org>; Fri, 11 Feb 2022 02:24:01 -0800 (PST)
Received: from myt6-de4b83149afa.qloud-c.yandex.net (myt6-de4b83149afa.qloud-c.yandex.net [IPv6:2a02:6b8:c12:401e:0:640:de4b:8314])
        by forward500j.mail.yandex.net (Yandex) with ESMTP id 7C1246CB6BA2;
        Fri, 11 Feb 2022 13:18:41 +0300 (MSK)
Received: from 2a02:6b8:c12:1723:0:640:c7c2:e344 (2a02:6b8:c12:1723:0:640:c7c2:e344 [2a02:6b8:c12:1723:0:640:c7c2:e344])
        by myt6-de4b83149afa.qloud-c.yandex.net (mxback/Yandex) with HTTP id dIYhLv0cJCg1-Iec4T0gI;
        Fri, 11 Feb 2022 13:18:40 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxt.ru; s=mail; t=1644574720;
        bh=+QzWvPmQ9CrQg+9DVBPDGn2iMJvpYZnpZYUSGInu5DU=;
        h=References:Date:Message-Id:Cc:Subject:In-Reply-To:To:From;
        b=Awe4H7r7545QR/+EprGABpQbh5FZaCRNU9KDR/ioLqCYK/a1mLKNXi3jaQ3D5PN++
         z3fjCMFCboRoZ2yuZwBWPC5eFqS0a2yXksD8j9h8nxFKpbMwuQR1rV8HuChBo+UYci
         dSegY4N/LM9B7ol+wFKxSAllsbZM350uQp77JyPg=
Authentication-Results: myt6-de4b83149afa.qloud-c.yandex.net; dkim=pass header.i=@nxt.ru
Received: by myt5-c7c2e3441f25.qloud-c.yandex.net with HTTP;
        Fri, 11 Feb 2022 13:18:40 +0300
From:   Aleksandr Fedorov <sanekf@nxt.ru>
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
In-Reply-To: <b090141f-0822-609f-429d-ea790d7fc828@arm.com>
References: <5481021644415780@myt5-a5512e99e394.qloud-c.yandex.net> <b090141f-0822-609f-429d-ea790d7fc828@arm.com>
Subject: Re: [PATCH] iommu: explicitly check for NULL in iommu_dma_get_resv_regions()
MIME-Version: 1.0
X-Mailer: Yamail [ http://yandex.ru ] 5.0
Date:   Fri, 11 Feb 2022 13:18:40 +0300
Message-Id: <10011281644574720@myt5-c7c2e3441f25.qloud-c.yandex.net>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> On 2022-02-09 14:09, Aleksandr Fedorov wrote:
>> iommu_dma_get_resv_regions() assumes that iommu_fwspec field for
>> corresponding device is set which is not always true. Since
>> iommu_dma_get_resv_regions() seems to be a future-proof generic API
>> that can be used by any iommu driver, add an explicit check for NULL.
> 
> Except it's not a "generic" interface for drivers to call at random,
> it's a helper for retrieving common firmware-based information
> specifically for drivers already using the fwspec mechanism for common
> firmware bindings. If any driver calls this with a device *without* a
> valid fwnode, it deserves to crash because it's done something
> fundamentally wrong.
> 
> I concur that it's not exactly obvious that "non-IOMMU-specific" means
> "based on common firmware bindings, thus implying fwspec".

Thanks for the explanations, yes, this was the misunderstanding on my
part. Maybe add a comment?

diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
index d85d54f2b549..ce5e7d4d054a 100644
--- a/drivers/iommu/dma-iommu.c
+++ b/drivers/iommu/dma-iommu.c
@@ -379,6 +379,9 @@ void iommu_put_dma_cookie(struct iommu_domain *domain)
  * for general non-IOMMU-specific reservations. Currently, this covers GICv3
  * ITS region reservation on ACPI based ARM platforms that may require HW MSI
  * reservation.
+ *
+ * Note that this helper is meant to be used only by drivers that are already
+ * using the fwspec mechanism for common firmware bindings.
  */
 void iommu_dma_get_resv_regions(struct device *dev, struct list_head *list)
 {
