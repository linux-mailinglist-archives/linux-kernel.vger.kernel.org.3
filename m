Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A887B5837B1
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jul 2022 05:45:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234209AbiG1DpC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jul 2022 23:45:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230233AbiG1Doe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jul 2022 23:44:34 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DE3D5C9DB
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jul 2022 20:44:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1658979872; x=1690515872;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=d8bKUQNIiVTi4UIB+oY/NGaVnZ9s0q27vb0caK8QMJg=;
  b=F2dkKSEAfLlU0bmCgw34H2ioixGCuZ1d7tAKkXW/lP64ZELF5OTFkdZq
   xFUH/X482Rv75F6b7GByUtMX0HsJCdM6lwj/kpqvK3zkfF//cUOLEhrlK
   6OIFuXNA42V3E+OVp7gczwEI8BbUffrXn23TjdAn6W5wUFnLZxeuTNhco
   tgIPolgIQMkEmClsGIcfjc/wBtgoMreBJETEdTqG1G50I/kt/vkTdqu6/
   c0DVUCPkglnE3GTjCIC+UuLdAJsuXGCq/64NKKb7b66QwazsaL4NLsX02
   U15a8DmaKcNVfrbLjIOv2zqxrm7OiLa+cdWHXUxCb+NaJrs2FZp5Wc8cm
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10421"; a="275292815"
X-IronPort-AV: E=Sophos;i="5.93,196,1654585200"; 
   d="scan'208";a="275292815"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jul 2022 20:44:31 -0700
X-IronPort-AV: E=Sophos;i="5.93,196,1654585200"; 
   d="scan'208";a="600676749"
Received: from hurleyst-mobl.amr.corp.intel.com (HELO skuppusw-desk1.amr.corp.intel.com) ([10.209.106.108])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jul 2022 20:44:31 -0700
From:   Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org
Cc:     "H . Peter Anvin" <hpa@zytor.com>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Kai Huang <kai.huang@intel.com>,
        Wander Lairson Costa <wander@redhat.com>,
        Isaku Yamahata <isaku.yamahata@gmail.com>,
        marcelo.cerri@canonical.com, tim.gardner@canonical.com,
        khalid.elmously@canonical.com, philip.cox@canonical.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH v9 6/6] selftests: tdx: Test GetQuote TDX attestation feature
Date:   Wed, 27 Jul 2022 20:44:20 -0700
Message-Id: <20220728034420.648314-7-sathyanarayanan.kuppuswamy@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220728034420.648314-1-sathyanarayanan.kuppuswamy@linux.intel.com>
References: <20220728034420.648314-1-sathyanarayanan.kuppuswamy@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In TDX guest, the second stage of the attestation process is Quote
generation. This process is required to convert the locally generated
TDREPORT into a remotely verifiable Quote. It involves sending the
TDREPORT data to a Quoting Enclave (QE) which will verify the
integerity of the TDREPORT and sign it with an attestation key.

Intel's TDX attestation driver exposes TDX_CMD_GET_QUOTE IOCTL to
allow user agent get the TD Quote.

Add a kernel selftest module to verify the Quote generation feature.

TD Quote generation involves following steps:

* Get the TDREPORT data using TDX_CMD_GET_REPORT IOCTL.
* Embed the TDREPORT data in quote buffer and request for quote
  generation via TDX_CMD_GET_QUOTE IOCTL request.
* Upon completion of the GetQuote request, check for non zero value
  in the status field of Quote header to make sure the generated
  quote is valid.

Reviewed-by: Tony Luck <tony.luck@intel.com>
Reviewed-by: Andi Kleen <ak@linux.intel.com>
Acked-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
---
 tools/testing/selftests/tdx/tdx_attest_test.c | 74 ++++++++++++++++---
 1 file changed, 64 insertions(+), 10 deletions(-)

diff --git a/tools/testing/selftests/tdx/tdx_attest_test.c b/tools/testing/selftests/tdx/tdx_attest_test.c
index 7155cc751eaa..14125b97e308 100644
--- a/tools/testing/selftests/tdx/tdx_attest_test.c
+++ b/tools/testing/selftests/tdx/tdx_attest_test.c
@@ -23,6 +23,7 @@
 
 #define devname         "/dev/tdx-guest"
 #define HEX_DUMP_SIZE	8
+#define QUOTE_SIZE	8192
 
 /*
  * struct td_info - It contains the measurements and initial configuration of
@@ -114,17 +115,11 @@ static void print_array_hex(const char *title, const char *prefix_str,
 }
 #endif
 
-TEST(verify_report)
+/* Helper function to get TDREPORT */
+long get_tdreport(int devfd, __u8 *reportdata, __u8 *tdreport)
 {
-	__u8 reportdata[TDX_REPORTDATA_LEN];
-	struct tdreport_data *tdr_data;
-	__u8 tdreport[TDX_REPORT_LEN];
 	struct tdx_report_req req;
-	int devfd, i;
-
-	devfd = open(devname, O_RDWR | O_SYNC);
-
-	ASSERT_LT(0, devfd);
+	int i;
 
 	/* Generate sample report data */
 	for (i = 0; i < TDX_REPORTDATA_LEN; i++)
@@ -137,8 +132,22 @@ TEST(verify_report)
 	req.tdreport    = (__u64)tdreport;
 	req.tdr_len     = TDX_REPORT_LEN;
 
+	return ioctl(devfd, TDX_CMD_GET_REPORT, &req);
+}
+
+TEST(verify_report)
+{
+	__u8 reportdata[TDX_REPORTDATA_LEN];
+	struct tdreport_data *tdr_data;
+	__u8 tdreport[TDX_REPORT_LEN];
+	int devfd;
+
+	devfd = open(devname, O_RDWR | O_SYNC);
+
+	ASSERT_LT(0, devfd);
+
 	/* Get TDREPORT */
-	ASSERT_EQ(0, ioctl(devfd, TDX_CMD_GET_REPORT, &req));
+	ASSERT_EQ(0, get_tdreport(devfd, reportdata, tdreport));
 
 	tdr_data = (struct tdreport_data *)tdreport;
 
@@ -157,4 +166,49 @@ TEST(verify_report)
 	ASSERT_EQ(0, close(devfd));
 }
 
+TEST(verify_quote)
+{
+	__u8 reportdata[TDX_REPORTDATA_LEN];
+	struct tdx_quote_hdr *quote_hdr;
+	struct tdx_quote_req quote_req;
+	__u8 *quote_buf = NULL;
+	__u64 quote_buf_size;
+	int devfd;
+
+	/* Open attestation device */
+	devfd = open(devname, O_RDWR | O_SYNC);
+
+	ASSERT_LT(0, devfd);
+
+	/* Add size for quote header */
+	quote_buf_size = sizeof(*quote_hdr) + QUOTE_SIZE;
+
+	/* Allocate quote buffer */
+	quote_buf = malloc(quote_buf_size);
+	ASSERT_NE(NULL, quote_buf);
+
+	quote_hdr = (struct tdx_quote_hdr *)quote_buf;
+
+	/* Initialize GetQuote header */
+	quote_hdr->version = 1;
+	quote_hdr->status  = GET_QUOTE_SUCCESS;
+	quote_hdr->in_len  = TDX_REPORT_LEN;
+	quote_hdr->out_len = 0;
+
+	/* Get TDREPORT data */
+	ASSERT_EQ(0, get_tdreport(devfd, reportdata,
+				(__u8 *)&quote_hdr->data));
+
+	/* Fill GetQuote request */
+	quote_req.buf	  = (__u64)quote_buf;
+	quote_req.len	  = quote_buf_size;
+
+	ASSERT_EQ(0, ioctl(devfd, TDX_CMD_GET_QUOTE, &quote_req));
+
+	/* Check whether GetQuote request is successful */
+	EXPECT_EQ(0, quote_hdr->status);
+
+	free(quote_buf);
+}
+
 TEST_HARNESS_MAIN
-- 
2.25.1

