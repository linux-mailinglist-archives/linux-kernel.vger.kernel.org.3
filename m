Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 283265A5B40
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 07:45:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229919AbiH3Fp0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 01:45:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229834AbiH3FpW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 01:45:22 -0400
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 736091F617
        for <linux-kernel@vger.kernel.org>; Mon, 29 Aug 2022 22:45:21 -0700 (PDT)
Received: from sequoia.corp.microsoft.com (162-237-133-238.lightspeed.rcsntx.sbcglobal.net [162.237.133.238])
        by linux.microsoft.com (Postfix) with ESMTPSA id 274422045DF9;
        Mon, 29 Aug 2022 22:45:20 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 274422045DF9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1661838320;
        bh=4tx7988dbpdq6BjiDihRE9SJL3xDVUEU7ewDk7bxwKI=;
        h=From:To:Cc:Subject:Date:From;
        b=rjIZRi5zdg8LaVn/ILkz++FbgiY4eZyRHPsgBTZgwKPFrI/8cNSBe31Kr6w5GsizV
         E4WpkAPgNcG4eQd/4Q70OasvOpubjxjHtjUuw64enAWvgYjK/J5YXIOUf0wFvS7exm
         y8x0mxoUOGDRJCNDEFeVkP87PxjNEstxTRp6bygk=
From:   Tyler Hicks <tyhicks@linux.microsoft.com>
To:     Dan Williams <dan.j.williams@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Ira Weiny <ira.weiny@intel.com>
Cc:     "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Jeff Moyer <jmoyer@redhat.com>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        "Madhavan T. Venkataraman" <madvenka@linux.microsoft.com>,
        nvdimm@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH v2] libnvdimm/region: Allow setting align attribute on regions without mappings
Date:   Tue, 30 Aug 2022 00:45:05 -0500
Message-Id: <20220830054505.1159488-1-tyhicks@linux.microsoft.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-19.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The alignment constraint for namespace creation in a region was
increased, from 2M to 16M, for non-PowerPC architectures in v5.7 with
commit 2522afb86a8c ("libnvdimm/region: Introduce an 'align'
attribute"). The thought behind the change was that region alignment
should be uniform across all architectures and, since PowerPC had the
largest alignment constraint of 16M, all architectures should conform to
that alignment.

The change regressed namespace creation in pre-defined regions that
relied on 2M alignment but a workaround was provided in the form of a
sysfs attribute, named 'align', that could be adjusted to a non-default
alignment value.

However, the sysfs attribute's store function returned an error (-ENXIO)
when userspace attempted to change the alignment of a region that had no
mappings. This affected 2M aligned regions of volatile memory that were
defined in a device tree using "pmem-region" and created by the
of_pmem_region_driver, since those regions do not contain mappings
(ndr_mappings is 0).

Allow userspace to set the align attribute on pre-existing regions that
do not have mappings so that namespaces can still be within those
regions, despite not being aligned to 16M.

Link: https://lore.kernel.org/lkml/CA+CK2bDJ3hrWoE91L2wpAk+Yu0_=GtYw=4gLDDD7mxs321b_aA@mail.gmail.com
Fixes: 2522afb86a8c ("libnvdimm/region: Introduce an 'align' attribute")
Signed-off-by: Tyler Hicks <tyhicks@linux.microsoft.com>
---

While testing with a recent kernel release (6.0-rc3), I rediscovered
this bug and eventually realized that I never followed through with
fixing it upstream. After a year later, here's the v2 that Aneesh
requested. Sorry about that!

v2:
- Included Aneesh's feedback to ensure the val is a power of 2 and
  greater than PAGE_SIZE even for regions without mappings
- Reused the max_t() trick from default_align() to avoid special
  casing, with an if-else, when regions have mappings and when they
  don't
  + Didn't include Pavel's Reviewed-by since this is a slightly
    different approach than what he reviewed in v1
- Added a Link commit tag to Pavel's initial problem description
v1: https://lore.kernel.org/lkml/20210326152645.85225-1-tyhicks@linux.microsoft.com/

 drivers/nvdimm/region_devs.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/nvdimm/region_devs.c b/drivers/nvdimm/region_devs.c
index 473a71bbd9c9..550ea0bd6c53 100644
--- a/drivers/nvdimm/region_devs.c
+++ b/drivers/nvdimm/region_devs.c
@@ -509,16 +509,13 @@ static ssize_t align_store(struct device *dev,
 {
 	struct nd_region *nd_region = to_nd_region(dev);
 	unsigned long val, dpa;
-	u32 remainder;
+	u32 mappings, remainder;
 	int rc;
 
 	rc = kstrtoul(buf, 0, &val);
 	if (rc)
 		return rc;
 
-	if (!nd_region->ndr_mappings)
-		return -ENXIO;
-
 	/*
 	 * Ensure space-align is evenly divisible by the region
 	 * interleave-width because the kernel typically has no facility
@@ -526,7 +523,8 @@ static ssize_t align_store(struct device *dev,
 	 * contribute to the tail capacity in system-physical-address
 	 * space for the namespace.
 	 */
-	dpa = div_u64_rem(val, nd_region->ndr_mappings, &remainder);
+	mappings = max_t(u32, 1, nd_region->ndr_mappings);
+	dpa = div_u64_rem(val, mappings, &remainder);
 	if (!is_power_of_2(dpa) || dpa < PAGE_SIZE
 			|| val > region_size(nd_region) || remainder)
 		return -EINVAL;
-- 
2.25.1

