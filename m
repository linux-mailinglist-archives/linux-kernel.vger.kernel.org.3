Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 740C24A55C7
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Feb 2022 05:01:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233389AbiBAEBZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jan 2022 23:01:25 -0500
Received: from mailout2.samsung.com ([203.254.224.25]:29917 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233351AbiBAEBX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jan 2022 23:01:23 -0500
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20220201040120epoutp02c0eb2ff0eab32d88d416e82cb9ac58b0~PjZnWNlun1656816568epoutp02h
        for <linux-kernel@vger.kernel.org>; Tue,  1 Feb 2022 04:01:20 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20220201040120epoutp02c0eb2ff0eab32d88d416e82cb9ac58b0~PjZnWNlun1656816568epoutp02h
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1643688080;
        bh=ZmBTEC+0WPDKOC4P5afhfOYeioQ52vDJpCgVji++mV8=;
        h=From:To:Cc:Subject:Date:References:From;
        b=RkBeHFKpc65ceP9z6M0cpLBZpSk+mq/7uCzynW2hVJEGwXbTJB12QHZGX0t5ozEsn
         o0Caaj4WQSuSixB6ZN4pZU2Mt54nLku0NYGGcWEyhUTv6TnsISHzPDnd8MDPASyP5U
         /tKwQQd4lrLM2N/b+w1zMJnvpjX5pTByJOQTJ+PM=
Received: from epsmges5p2new.samsung.com (unknown [182.195.42.74]) by
        epcas5p2.samsung.com (KnoxPortal) with ESMTP id
        20220201040119epcas5p227dbb22cbbb5c95f22d626758e03f237~PjZmbHFx12061920619epcas5p2-;
        Tue,  1 Feb 2022 04:01:19 +0000 (GMT)
Received: from epcas5p2.samsung.com ( [182.195.41.40]) by
        epsmges5p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        0E.05.46822.060B8F16; Tue,  1 Feb 2022 13:00:32 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas5p1.samsung.com (KnoxPortal) with ESMTPA id
        20220201040100epcas5p180ef094058fc9c76b4b94d9d673fc5fc~PjZT--B3w0531705317epcas5p12;
        Tue,  1 Feb 2022 04:01:00 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20220201040100epsmtrp1a5867ee6c34aac3ffb4d72c494b51cf1~PjZT-Dl091494414944epsmtrp1O;
        Tue,  1 Feb 2022 04:01:00 +0000 (GMT)
X-AuditID: b6c32a4a-dfbff7000000b6e6-cd-61f8b06094d9
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        3E.98.08738.B70B8F16; Tue,  1 Feb 2022 13:00:59 +0900 (KST)
Received: from localhost.localdomain (unknown [107.109.224.44]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20220201040057epsmtip299db92648f29cf696241063199f6984f~PjZRcl6Lx2811028110epsmtip2D;
        Tue,  1 Feb 2022 04:00:57 +0000 (GMT)
From:   Maninder Singh <maninder1.s@samsung.com>
To:     pmladek@suse.com, rostedt@goodmis.org, senozhatsky@chromium.org,
        andriy.shevchenko@linux.intel.com, linux@rasmusvillemoes.dk
Cc:     akpm@linux-foundation.org, wangkefeng.wang@huawei.com,
        mbenes@suse.cz, swboyd@chromium.org, ojeda@kernel.org,
        linux-kernel@vger.kernel.org, will@kernel.org,
        catalin.marinas@arm.com, Maninder Singh <maninder1.s@samsung.com>,
        Vaneet Narang <v.narang@samsung.com>
Subject: [PATCH 1/1] kallsyms: print module name in %ps/S case when KALLSYMS
 is disabled
Date:   Tue,  1 Feb 2022 09:30:44 +0530
Message-Id: <20220201040044.1528568-1-maninder1.s@samsung.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrEKsWRmVeSWpSXmKPExsWy7bCmhm7Chh+JBu/nGFnMWb+GzaK3aTqT
        xftlPYwWl3fNYbN4PGsem8Xh+W0sFndX3GCyWDl/OaPF/8dfWS32dTxgsti9cRGbxfE7T5ks
        Dp2cy2jR+Pk+o0XLHVMHfo8189YwesxuuMji0bLvFrtHy5G3rB6bVnWyeZyY8ZvFY97JQI8L
        XdkefVtWMXqs33KVxePMgiPsHp83yQXwRHHZpKTmZJalFunbJXBldKz1LVgpXrGtOayBcY9Q
        FyMnh4SAicT/jStZuxi5OIQEdjNKtGx6zQLhfGKU+PDwNDuE85lR4uTnRnaYluO7Z0G17GKU
        OLNuGiOE84VRomfPdmaQKjYBPYlVu/aAzRIRaGKU6Fv9B2wWs0Afk8TNJbuBHA4OYYEoiR8X
        6kAaWARUJa6u2cYEYvMK2EmcbmxmglgnLzHz0nd2iLigxMmZT1hAbGagePPW2cwgMyUEdnBI
        bNmwmwWiwUVi9p2trBC2sMSr41ug7paSeNnfxg7R0M0osaH7GAuEM4NR4vPBq4wQVfYSTy4u
        ZAW5jllAU2L9Ln2IsKzE1FPrmCA280n0/n4CdR2vxI55MLaqRMvNDVCLpSU+f/wIdZCHxMSe
        2WDjhQRiJSbPvcUygVF+FpKHZiF5aBbC5gWMzKsYJVMLinPTU4tNC4zyUsv1ihNzi0vz0vWS
        83M3MYKTnZbXDsaHDz7oHWJk4mA8xCjBwawkwrt34fdEId6UxMqq1KL8+KLSnNTiQ4zSHCxK
        4ryn0zckCgmkJ5akZqemFqQWwWSZODilGpi6m0NuuWfsm/f65rTA2PkLLAIuz+YImX/uZAqX
        EWd6vs1V29b94ZJnNa8EfWoJ0C/xP+yymY/vQut1hlfOk9tWtdeun6r9k+3K++fd6hMq86Q8
        P31wUbI68WXz+kimhCZzpqjH6pE7DreWMWS2vz1+UYX1sdLLkldXEzecuSHa48/juv/dbNX1
        M3es93hwv3+v54nyh3khqhIeNjdTtGbGu9378jRNYNORh6EuZZOUZy/X7lvBavDz0ydNo/98
        e2vCQs/Nc5/NePeiufimj9XH1S7/+lj5/cIWmTUbnh42WqMVufumzjsHz2/NPfPezJLbcNju
        SVbND5FkXY3iLo9tins69mYdPdp8eUv9/SX1SizFGYmGWsxFxYkAxiVgseUDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrOLMWRmVeSWpSXmKPExsWy7bCSvG71hh+JBr13WSzmrF/DZtHbNJ3J
        4v2yHkaLy7vmsFk8njWPzeLw/DYWi7srbjBZrJy/nNHi/+OvrBb7Oh4wWezeuIjN4vidp0wW
        h07OZbRo/Hyf0aLljqkDv8eaeWsYPWY3XGTxaNl3i92j5chbVo9NqzrZPE7M+M3iMe9koMeF
        rmyPvi2rGD3Wb7nK4nFmwRF2j8+b5AJ4orhsUlJzMstSi/TtErgyOtb6FqwUr9jWHNbAuEeo
        i5GTQ0LAROL47lmsXYxcHEICOxgl/j/+xwSRkJb4+e89C4QtLLHy33N2iKJPjBIn5/1mA0mw
        CehJrNq1hwUkISLQwSixfsM5JhCHWWAWk8TRKR/BRgkLREg82reIEcRmEVCVuLpmG1icV8BO
        4nRjM9Q6eYmZl76zQ8QFJU7OfAK2mhko3rx1NvMERr5ZSFKzkKQWMDKtYpRMLSjOTc8tNiww
        ykst1ytOzC0uzUvXS87P3cQIjhstrR2Me1Z90DvEyMTBeIhRgoNZSYR378LviUK8KYmVValF
        +fFFpTmpxYcYpTlYlMR5L3SdjBcSSE8sSc1OTS1ILYLJMnFwSjUw2eXJ3F7QIvRbKuT/LEdO
        rXzbP0v0gi2EJl2JXDzni2YZ78/DcxIjm7wi67/skfa0FEnvi5tpIZqgtEIiyP9Xd/bexGtX
        S+4wlH//+St20my33I96rG9XSG3h4a0snXQiau+G9XqCs6farlNqPjV9Vdwpw1nMnSdzT30R
        vlpadV8n1PZhnIJv2xKhvU3drZ1vJsVJ/rGt9uZeO6HLdIHTnC1HIttZS5+tnL9aUvLk2qfO
        cvPnXakSiNslnbrIh+3ElcmXLCa1LRPI9y/5PXW6U2ky53Oe3wumvd3Mrcmb3V1n4Mqw2rYy
        WC3nW84NgYvbp1hv2su98Hg4M1/mcZ2001aPf609UbDx6dFlb6ZxKrEUZyQaajEXFScCADHt
        0CwKAwAA
X-CMS-MailID: 20220201040100epcas5p180ef094058fc9c76b4b94d9d673fc5fc
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
X-CMS-RootMailID: 20220201040100epcas5p180ef094058fc9c76b4b94d9d673fc5fc
References: <CGME20220201040100epcas5p180ef094058fc9c76b4b94d9d673fc5fc@epcas5p1.samsung.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

original:
With KALLSYMS
                   %pS                               %ps
[16.4200]  hello_init+0x0/0x24 [crash]        hello_init [crash]

Without KALLSYMS:
[16.2200]      0xbe200040                         0xbe200040

With Patch (Without KALLSYMS:) load address + current offset [Module Name]

[13.5993]  0xbe200000+0x40 [crash]           0xbe200000+0x40 [crash]

It will help in better debugging and checking when KALLSYMS is disabled,
user will get information about module name and load address of module.

verified for arm64:
/ # insmod /crash.ko

[   19.263556] 0xffff800000ec0000+0x38 [crash]

..

[   19.276023] Call trace:
[   19.276277]  0xffff800000ec0000+0x28 [crash]
[   19.276567]  0xffff800000ec0000+0x58 [crash]
[   19.276727]  0xffff800000ec0000+0x74 [crash]
[   19.276866]  0xffff8000080127d0
[   19.276978]  0xffff80000812d95c
[   19.277085]  0xffff80000812f554

Signed-off-by: Vaneet Narang <v.narang@samsung.com>
Signed-off-by: Maninder Singh <maninder1.s@samsung.com>
---
 include/linux/kallsyms.h | 27 +++++++++++++++++++++++++++
 lib/vsprintf.c           |  5 +++--
 2 files changed, 30 insertions(+), 2 deletions(-)

diff --git a/include/linux/kallsyms.h b/include/linux/kallsyms.h
index 5fb17dd4b6fa..ebfeb6099c28 100644
--- a/include/linux/kallsyms.h
+++ b/include/linux/kallsyms.h
@@ -163,6 +163,33 @@ static inline bool kallsyms_show_value(const struct cred *cred)
 	return false;
 }
 
+#ifdef CONFIG_MODULES
+static inline int fill_minimal_module_info(char *sym, int size, unsigned long value)
+{
+	struct module *mod;
+	unsigned long offset;
+	int ret = 0;
+
+	preempt_disable();
+	mod = __module_address(value);
+	if (mod) {
+		offset = value - (unsigned long)mod->core_layout.base;
+		snprintf(sym, size - 1, "0x%lx+0x%lx [%s]",
+				(unsigned long)mod->core_layout.base, offset, mod->name);
+
+		sym[size - 1] = '\0';
+		ret = 1;
+	}
+
+	preempt_enable();
+	return ret;
+}
+#else
+static inline int fill_minimal_module_info(char *sym, int size, unsigned long value)
+{
+	return 0;
+}
+#endif /*CONFIG_MODULES*/
 #endif /*CONFIG_KALLSYMS*/
 
 static inline void print_ip_sym(const char *loglvl, unsigned long ip)
diff --git a/lib/vsprintf.c b/lib/vsprintf.c
index 61528094ec87..41c74abb1726 100644
--- a/lib/vsprintf.c
+++ b/lib/vsprintf.c
@@ -985,9 +985,7 @@ char *symbol_string(char *buf, char *end, void *ptr,
 		    struct printf_spec spec, const char *fmt)
 {
 	unsigned long value;
-#ifdef CONFIG_KALLSYMS
 	char sym[KSYM_SYMBOL_LEN];
-#endif
 
 	if (fmt[1] == 'R')
 		ptr = __builtin_extract_return_addr(ptr);
@@ -1007,6 +1005,9 @@ char *symbol_string(char *buf, char *end, void *ptr,
 
 	return string_nocheck(buf, end, sym, spec);
 #else
+	if (fill_minimal_module_info(sym, KSYM_SYMBOL_LEN, value))
+		return string_nocheck(buf, end, sym, spec);
+
 	return special_hex_number(buf, end, value, sizeof(void *));
 #endif
 }
-- 
2.17.1

