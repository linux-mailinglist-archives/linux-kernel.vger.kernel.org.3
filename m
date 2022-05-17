Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 553E852AAD6
	for <lists+linux-kernel@lfdr.de>; Tue, 17 May 2022 20:32:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352186AbiEQSby convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 17 May 2022 14:31:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241586AbiEQSbt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 May 2022 14:31:49 -0400
Received: from sender4-of-o58.zoho.com (sender4-of-o58.zoho.com [136.143.188.58])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 112BD38187;
        Tue, 17 May 2022 11:31:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1652812294; cv=none; 
        d=zohomail.com; s=zohoarc; 
        b=h3h2AaYYTwbCi4JDQc9qA9NjrN77yV6jJZKUpjFlafci0LtdBEjVpbp36kiPD8W3Zl78tdGQqTSllqfD0edO4ZO4v8zA8h2gFhUGZPHOCT3aYIyvbXV3c9GW9cJjr+5MKjEmSnZiyOhE9KPPy9IFcc49MDV8s4vDD1N5JEttL84=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
        t=1652812294; h=Content-Type:Content-Transfer-Encoding:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
        bh=DzAVDUI6vpcfK0zl88k4jLeQQu6WXSwcUJJuw/e98/s=; 
        b=JHOMinLS2F869tH0pR3oPMvmoDkxPN4x3U/vfNG3vS5+lGbdMqkKTZWSEdGOEdgggUUt/CPJZRcm/tO2clCPKRMcPlVa+02xAaY7CBy+UEx8VVF0Oxb0nAYoQkTdxhsM0DhC2fs3enLqgv/y3ayhmj1SsrUOHwcDHZWeISKornM=
ARC-Authentication-Results: i=1; mx.zohomail.com;
        spf=pass  smtp.mailfrom=linux@mniewoehner.de;
        dmarc=pass header.from=<linux@mniewoehner.de>
Received: from z3r0.lan (185.31.62.161 [185.31.62.161]) by mx.zohomail.com
        with SMTPS id 165281229369653.234581199221566; Tue, 17 May 2022 11:31:33 -0700 (PDT)
Message-ID: <66f813f5bcc724a0f6dd5adefe6a9728dbe509e3.camel@mniewoehner.de>
Subject: [PATCH v3] platform/x86: intel-hid: fix _DSM function index
 handling
From:   Michael =?ISO-8859-1?Q?Niew=F6hner?= <linux@mniewoehner.de>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Alex Hung <alex.hung@canonical.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jiri Kosina <trivial@kernel.org>
In-Reply-To: <CAHp75VcoLqByXy_VdhAu-j9oU_cL7FhdcegG=ePGkNK=cD+wKA@mail.gmail.com>
References: <44828f285aeacf0e941f4f6452b190b46146043f.camel@mniewoehner.de>
         <CAHp75VcoLqByXy_VdhAu-j9oU_cL7FhdcegG=ePGkNK=cD+wKA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Date:   Tue, 17 May 2022 20:31:30 +0200
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

Fixes: 97ab4516205e ("platform/x86: intel-hid: fix _DSM function index handling")
Cc: stable@vger.kernel.org
Signed-off-by: Michael Niewöhner <linux@mniewoehner.de>
---
Changes in v3:
Added Fixes tag

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

