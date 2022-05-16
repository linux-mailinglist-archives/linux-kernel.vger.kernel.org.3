Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FDC65284F2
	for <lists+linux-kernel@lfdr.de>; Mon, 16 May 2022 15:06:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243662AbiEPNGw convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 16 May 2022 09:06:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229895AbiEPNGt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 May 2022 09:06:49 -0400
Received: from sender4-of-o58.zoho.com (sender4-of-o58.zoho.com [136.143.188.58])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CEE311A0A;
        Mon, 16 May 2022 06:06:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1652706397; cv=none; 
        d=zohomail.com; s=zohoarc; 
        b=MDZ4xEOWpxIZhmqokCcpk391itTa2iDZCEgtXO6j1BQRlGmdO7MZyj1HleRHimBJWb8eiE4efI3WVB1sf2pmUApWHt15cnaK974SxRjJW5FiQT0n4fcarG73zBJr7sCQbI1F976HU7erIX2pFFnmhmV6Zg3Rqt18vxKdQuhhykI=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
        t=1652706397; h=Content-Type:Content-Transfer-Encoding:Date:From:MIME-Version:Message-ID:Subject:To; 
        bh=rMdGdZjft1ez7rS5/RSOrjzo5Y2NZwBNqyLlALkfo9Q=; 
        b=Mc3ZL4rUFnEMgu6dlar4j6tcpBIUXh2aGMANRDREVeRYLxlVRg2Jkdv3p8WWf8+4A4Rh6i8CzkI3yAPu+3tfK5dvkeaKRBKYxqLwRR8H1L1iBSdQxM2l4JcjqT4chDQb/Q6fHA+FfRVWVhsWfP+YAC+jMKXBx1U+YV6qcrspAbY=
ARC-Authentication-Results: i=1; mx.zohomail.com;
        spf=pass  smtp.mailfrom=linux@mniewoehner.de;
        dmarc=pass header.from=<linux@mniewoehner.de>
Received: from z3r0.lan (185.31.62.161 [185.31.62.161]) by mx.zohomail.com
        with SMTPS id 1652706395737383.4100488774111; Mon, 16 May 2022 06:06:35 -0700 (PDT)
Message-ID: <44828f285aeacf0e941f4f6452b190b46146043f.camel@mniewoehner.de>
Subject: [PATCH v2] platform/x86: intel-hid: fix _DSM function index
 handling
From:   Michael =?ISO-8859-1?Q?Niew=F6hner?= <linux@mniewoehner.de>
To:     Alex Hung <alex.hung@canonical.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        trivial@kernel.org
Content-Type: text/plain; charset="UTF-8"
Date:   Mon, 16 May 2022 15:06:32 +0200
MIME-Version: 1.0
User-Agent: Evolution 3.42.2 
Content-Transfer-Encoding: 8BIT
X-ZohoMailClient: External
X-Spam-Status: No, score=-0.4 required=5.0 tests=BAYES_00,DKIM_ADSP_ALL,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

intel_hid_dsm_fn_mask is a bit mask containing one bit for each function
index. Fix the function index check in intel_hid_evaluate_method
accordingly, which was missed in commit 97ab4516205e ("platform/x86:
intel-hid: fix _DSM function index handling").

Cc: stable@vger.kernel.org
Signed-off-by: Michael Niewöhner <linux@mniewoehner.de>
---
Changes in v2:
Added Cc to stable

 drivers/platform/x86/intel/hid.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/platform/x86/intel/hid.c b/drivers/platform/x86/intel/hid.c
index 13f8cf70b9ae..5c39d40a701b 100644
--- a/drivers/platform/x86/intel/hid.c
+++ b/drivers/platform/x86/intel/hid.c
@@ -238,7 +238,7 @@ static bool intel_hid_evaluate_method(acpi_handle handle,
 
        method_name = (char *)intel_hid_dsm_fn_to_method[fn_index];
 
-       if (!(intel_hid_dsm_fn_mask & fn_index))
+       if (!(intel_hid_dsm_fn_mask & BIT(fn_index)))
                goto skip_dsm_eval;
 
        obj = acpi_evaluate_dsm_typed(handle, &intel_dsm_guid,
-- 
2.34.1


