Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C2B84AE14D
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Feb 2022 19:46:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1385257AbiBHSpF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Feb 2022 13:45:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1385189AbiBHSo5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Feb 2022 13:44:57 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3AA8C0612C2;
        Tue,  8 Feb 2022 10:44:43 -0800 (PST)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 218Gqsc5026751;
        Tue, 8 Feb 2022 18:44:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2021-07-09; bh=Q1NIwb+2r1U2jtlr3RdXJ8qglw0iSOw8bH8mLxYS2B0=;
 b=AxXm6gdA8pFxoipOduu/tx55aqgJaWyHp+J6unIl45u1N4ezcmdiueEgavy94mVKz/5Q
 tKCFDRsWWMeuAaROFy9hverg2iTfd6qkRo3XWYC2nSm5otxtzMbgIHhRLC7Br0uWkX3V
 P9zkZmhaw9dtl9/KlRVOpjtEWow6gxur90Xe1QR1AGfcvL5iEJxlWJsC3NBVuXuQLWAP
 SsLXgHCAGZsL8hWhd4Xlkcayf6UMxlk51EhRX/4KztIWWXCFgEN90Kl4ZwIoxPc6iuVL
 +HqvoLBkeZqbExEH1FZ4nNEhTvYJssjgEcHSM2P46gpcGbX75yFZ/iV3ZYD/CxQ2Tp/4 gg== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3e3h28j8q9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 08 Feb 2022 18:44:08 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 218Ia2Q6166506;
        Tue, 8 Feb 2022 18:44:06 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam07lp2044.outbound.protection.outlook.com [104.47.56.44])
        by userp3020.oracle.com with ESMTP id 3e1jprbdcg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 08 Feb 2022 18:44:06 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z3ofAIR0QWZZfwVrN3VN6rNxo/3jHauAL4wQ/N4hYR54YkGAjpXq+SW+hBJi0abEb53w9iVTJaEOXtWJvc0sV3HYOJg6Vmh5fH0mD6Z0CJnH68ZpvWp9tWG0dF+tnsLE1a3eK/xaUIhI8yH+ViWCr1wrIqMdaG9xHowgffxU2/1higndr0XcOW27AaKUCg+tY5izUYo39tORJq8GYYbfHXcNMPKgIEeb9k/N3rNI76hrJsp2fv1qLYzxFMu/yziq/CivyC5pTWMWILS4yxtjI+9LRhsTjH5yoUk7F9LpMAhI8W2/gWEI1tWP9VgDv13AUlaTlGtb9stzko8S7rL9SQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q1NIwb+2r1U2jtlr3RdXJ8qglw0iSOw8bH8mLxYS2B0=;
 b=GYUawMwmN9I0xFHa4XGJTyeYUj/2AMz+77kozgGvRo/sF20HafchhB24a+FBNWiY7FA/Urix+SsmNNVSL9dNZra9KYhlfEBxG0qM1WklTj3e3KEJCbdf3rzeIRxX4QapShq5gKilGVCFR+CrZeP8QoEUilCdbBfa7Ph//6ISlvVtsYnCTnTF3JlObtemVff1k2uDSjv0G/R9Qr4dkZwjY6U2JQ/oe/1uZOGKfj8qwZD9IMQOGrzX/QlpcBX2VqM5brS7SrkZWa1Ki3KxMPHA/FKzsOnUIAhaUn4rI4kqiit5ckX3IwQ1CD8Y93WY2u4P6+5AXeYo25eiBSROwQof9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q1NIwb+2r1U2jtlr3RdXJ8qglw0iSOw8bH8mLxYS2B0=;
 b=xZ3V5MKdU7sp7j50z6rD970adOimzRHcfob54DSj2b0VK0UEVwBdQNAoGsXvELBw4K1FOZldgrVmEb75xCy9EFtdaEFgC/3GMw0rdS8ryHWe7RtrVt47K9eNqSSLC3kZAmRA/WkbyxnEHw9FF+beaG8n2SCjG731ooe3/wZZCi8=
Received: from SA2PR10MB4715.namprd10.prod.outlook.com (2603:10b6:806:fb::10)
 by SA1PR10MB5781.namprd10.prod.outlook.com (2603:10b6:806:23e::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.19; Tue, 8 Feb
 2022 18:44:04 +0000
Received: from SA2PR10MB4715.namprd10.prod.outlook.com
 ([fe80::644e:5828:a72c:c1de]) by SA2PR10MB4715.namprd10.prod.outlook.com
 ([fe80::644e:5828:a72c:c1de%3]) with mapi id 15.20.4951.019; Tue, 8 Feb 2022
 18:44:04 +0000
From:   Nick Alcock <nick.alcock@oracle.com>
To:     mcgrof@kernel.org, masahiroy@kernel.org
Cc:     jolsa@kernel.org, rostedt@goodmis.org, bas@baslab.org,
        tglozar@gmail.com, Ast-x64@protonmail.com, viktor.malik@gmail.com,
        dxu@dxuuu.xyz, acme@kernel.org, adrian.hunter@intel.com,
        ak@linux.intel.com, irogers@google.com,
        linux-kbuild@vger.kernel.org, linux-modules@vger.kernel.org,
        linux-kernel@vger.kernel.org, arnd@arndb.de,
        akpm@linux-foundation.org, eugene.loh@oracle.com,
        kris.van.hees@oracle.com,
        Victor Erminpour <victor.erminpour@oracle.com>
Subject: [PATCH v8 1/6] kbuild: bring back tristate.conf
Date:   Tue,  8 Feb 2022 18:43:04 +0000
Message-Id: <20220208184309.148192-2-nick.alcock@oracle.com>
X-Mailer: git-send-email 2.35.0.260.gb82b153193.dirty
In-Reply-To: <20220208184309.148192-1-nick.alcock@oracle.com>
References: <20220208184309.148192-1-nick.alcock@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO2P123CA0088.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:138::21) To SA2PR10MB4715.namprd10.prod.outlook.com
 (2603:10b6:806:fb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7d518264-eaa3-45e7-cf53-08d9eb32fb41
X-MS-TrafficTypeDiagnostic: SA1PR10MB5781:EE_
X-Microsoft-Antispam-PRVS: <SA1PR10MB578174571166E9D172A87AD38B2D9@SA1PR10MB5781.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3826;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6vUOVLJIllmX3jSf0zJobJ9JPLPxkZxrRlNeYbDbfRGVIIhI/X/IZkg0JwhMfjtpIUav0iQ3+m04F/CvG/WUP4Qr+mDvtKnHI6+oCvWSyEErg3XnQBS2SwLECC4bhN0NQcydxXRUeo6FXW60ukr2PRjNqehdlppfSWvGhVznWyMoAHQhLnFQzP9/yW7bhBHaFpyFZaOH8+89nhH1049RyZVJrlhwvqHkbp8R6HF2jQK3J545FGsUhdKfku/7uHaeYvfEzxDh2FEiP0USLKbV8oupWobK7j4tk7T7mpQvSgDO/ebxbne7DFJS+M6sIsmzBTEJHdyNbE7WjAnpfB8NB+DeZZsKu1lvMCQc7xMryq/J8rTmilaQyeT95fPX5pOlrTm5BrF85fZnNR0h/L5qJIE4h/OlQQeE+bYqH/zILptyP6Hp0gAOHDAU4zRS6o4hUDfVLvR7mPyOdOeZAR9bbx7Yr84o6bCGJ4nAvidsMy9n9TJX72/kgeRnrYnsg8quhRU6DqDUUIBshpyuaqUXx6cu73F5r0EvMRd239fvtTulMiaqV58g95iAo34ZNo8Ucrb1VnXIaZQOcEH71dY5NKiq2lx5RyWhPqmxYSgbSKu4ZgCANa0vkgmkBVK0j+rnbGjJDXWJeLllSH7WIH1R1w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA2PR10MB4715.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(83380400001)(107886003)(86362001)(6486002)(36756003)(52116002)(5660300002)(6512007)(1076003)(508600001)(6506007)(7416002)(186003)(8676002)(44832011)(66556008)(316002)(2906002)(8936002)(66476007)(4326008)(2616005)(38100700002)(66946007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?mZOOQUodeBT7jVln2xp7Mrl740P0u4sLGRNR/F1maqZpb9fSsaY1AujiZvlE?=
 =?us-ascii?Q?IIUrfNFN4Bw7KmIhiuKtvG8coPKYRq+e1p4yibw+070mjyZnFQ/K5srU2h1y?=
 =?us-ascii?Q?2ha62Xai3Gg30Nvncj17Pvfkqfr8WjDan6XVhqpQOQsymtMIpGna8Yp3Uf9Q?=
 =?us-ascii?Q?wMqgLFh0fsnR1BLP6nFtOHX0G65XbfdyzgOhksRtM/zOCyz6U9XRb92GED8w?=
 =?us-ascii?Q?KpwMN91+NbDjlkImc9zIQL++LqsKEK6QijMjTQBxiv1SbW8WsGC6jIhp+iWz?=
 =?us-ascii?Q?uRNQpYUS2gJcTHKT9SZkJXWvgbElD3TPnlC9TdgNCjHqi6B2/4Gj8JfAYVTL?=
 =?us-ascii?Q?M0QdSxCBE9amS1NlgBhgQnwzM2s7u5zzGCH9yG/aBPnuuful4+HhxxHgnutL?=
 =?us-ascii?Q?yLr9liId7GdZCkoMd8ifk81IYmNp0R9Nfc7kknsC3DIcr4K7EX7Q5BUbm0UJ?=
 =?us-ascii?Q?Wun3Mutj6XIKrGn7uULj1YQSH/owwEMjjuN7I9NoEAZFfbIOXLCyWF5vj++d?=
 =?us-ascii?Q?X0KYlMQZ0Gy/0PPczOq+Ws4BssjN4t3309sTwgAJQVpV41WHsuZzQKQgR+QG?=
 =?us-ascii?Q?YVy4VfEpV63NvKVJgVtYAInyg+YH2ahzsUFaoLsBNC9Fip6ub7ggG6HHX/pr?=
 =?us-ascii?Q?YFN33id3NWcL5YRfzKiiQdUoBg0rrRheGr4SRtW5BtuXkWkBMFViRqFNbzte?=
 =?us-ascii?Q?WXEn/sigkZ2UhL0CzVhmw0cOSwC3aiM9Wx0gZQHJKE6l3pwWFkQ4YePiD4tF?=
 =?us-ascii?Q?HwD17cEwaFfNo8VrinfYTEg84WvJXnbM+F5wvSNKtA1uYP+YPPlrE2Y3llCs?=
 =?us-ascii?Q?YArdcilvUf91CUxd/sJhA8E0IwG1w5h98G0FFzIPQ4WHVTa0aJnJqfdRTnHs?=
 =?us-ascii?Q?C0WTWH+ydsPwZ1PTXaZ1dc5uuac8tWaTnbWIAdz+BNvDFp5JKMdZURM5zs7q?=
 =?us-ascii?Q?MuHsbSDJw19hrbC2d6r2JLK+NAkZVT3Zwj3uJpg3UPXh4MqUCoYESgxuUnZ6?=
 =?us-ascii?Q?umdtITzhIv5xsNpInJ5LtSd1y8AMGdcuOvvukzGXonF4C491kkpZn2ZWFbWe?=
 =?us-ascii?Q?rou+w8JsXLC7XjjQOvt87KA95ECPXrBbIVAb9FFXhdpUp5q9OXYqJBCG5Od9?=
 =?us-ascii?Q?cObhsAu3aH6ycsXr34TNcSPRf6/NJzehLVYPW56NywCPVkVq86H1+LO5ppNH?=
 =?us-ascii?Q?jCCaGo3DEDy0GwKlIgrfoPei5KKzY+kJvTR2x9QLW5jpnM1jT8yOayWWJdLd?=
 =?us-ascii?Q?QK2wC2FZECwOtu0M6FwZuHngDsIk064DDEawjGfY3uw0VabH99gCchKoQMqw?=
 =?us-ascii?Q?Q+GVgzKpqWpAMhBYkduTt2L/BTpsuKbevPXk30/Jv8OnWW8bp+vaAFjgv50o?=
 =?us-ascii?Q?7VWU8QgGaE1SWmVU5t2ikTM6Yl+wk57+xcalC0PZL9FtEO9n9MnzZQzdHaxo?=
 =?us-ascii?Q?mMKS72Nml1/5Kiqkrl/V5qM7W8YLc81tiCw/NR9Vb18EHcBEw5qtxBs2gG7j?=
 =?us-ascii?Q?PJ2hAMTnuMAqEYV0+P7M9iynOti9DlA7MoC5c2r/ae4IEf/OqJXGAEF5sCas?=
 =?us-ascii?Q?tZT5WQFU+vvzcgtAq+tgqQVVwtQZq5ORdjU/g9alXraxeWczO9wYq7X4RDrd?=
 =?us-ascii?Q?Fjs1F8w63RORiU56tJgUlBS/RAnnGuA+wrDAMyhj/yTK?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d518264-eaa3-45e7-cf53-08d9eb32fb41
X-MS-Exchange-CrossTenant-AuthSource: SA2PR10MB4715.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Feb 2022 18:44:04.7484
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SMeACkdKEb4ZqsMN8jYmd52cvOSTLtdvQpx2+8HXUr6lyyGmTLj/G4QDujinTKHq07ExXoH387BGWHMUprB0HQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB5781
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10252 signatures=673431
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 mlxscore=0 bulkscore=0
 malwarescore=0 suspectscore=0 phishscore=0 adultscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2201110000
 definitions=main-2202080109
X-Proofpoint-ORIG-GUID: 17MMnhxkdo9khO4fXsLG44v3ZgXpAOIT
X-Proofpoint-GUID: 17MMnhxkdo9khO4fXsLG44v3ZgXpAOIT
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tristate.conf was dropped because it is not needed to build a
modules.builtin (although dropping it introduces a few false positives
into modules.builtin support), and doing so avoids one round of
recursion through the build tree to build it.  But kallmodsyms support
requires building a mapping from object file name to built-in module
name for all builtin modules: this seems to me impossible to accomplish
without parsing all makefiles under the influence of tristate.conf,
since the makefiles are the only place this mapping is recorded.

So bring it back for this purpose.  (Thanks to the refactoring in
the 5.16 timeframe, this is basically a reimplementation of commit
8b41fc4454e36fbfdbb23f940d023d4dece2de29 rather than a simple
reversion.)

Signed-off-by: Nick Alcock <nick.alcock@oracle.com>
Reviewed-by: Victor Erminpour <victor.erminpour@oracle.com>
Reviewed-by: Kris Van Hees <kris.van.hees@oracle.com>
---

Notes:
    v7: rewrite in terms of the new confdata refactoring
    v8: adjust for changes in 5.17 merge window

 Documentation/kbuild/kconfig.rst |  5 ++++
 Makefile                         |  2 +-
 scripts/kconfig/confdata.c       | 42 +++++++++++++++++++++++++++-----
 3 files changed, 42 insertions(+), 7 deletions(-)

diff --git a/Documentation/kbuild/kconfig.rst b/Documentation/kbuild/kconfig.rst
index 5967c79c3baa..e2c78760d442 100644
--- a/Documentation/kbuild/kconfig.rst
+++ b/Documentation/kbuild/kconfig.rst
@@ -162,6 +162,11 @@ KCONFIG_AUTOCONFIG
 This environment variable can be set to specify the path & name of the
 "auto.conf" file.  Its default value is "include/config/auto.conf".
 
+KCONFIG_TRISTATE
+----------------
+This environment variable can be set to specify the path & name of the
+"tristate.conf" file.  Its default value is "include/config/tristate.conf".
+
 KCONFIG_AUTOHEADER
 ------------------
 This environment variable can be set to specify the path & name of the
diff --git a/Makefile b/Makefile
index ceb987e5c87b..199b6f388484 100644
--- a/Makefile
+++ b/Makefile
@@ -716,7 +716,7 @@ $(KCONFIG_CONFIG):
 #
 # Do not use $(call cmd,...) here. That would suppress prompts from syncconfig,
 # so you cannot notice that Kconfig is waiting for the user input.
-%/config/auto.conf %/config/auto.conf.cmd %/generated/autoconf.h: $(KCONFIG_CONFIG)
+%/config/auto.conf %/config/auto.conf.cmd %/generated/autoconf.h %/tristate.conf: $(KCONFIG_CONFIG)
 	$(Q)$(kecho) "  SYNC    $@"
 	$(Q)$(MAKE) -f $(srctree)/Makefile syncconfig
 else # !may-sync-config
diff --git a/scripts/kconfig/confdata.c b/scripts/kconfig/confdata.c
index 59717be31210..21dd9112311c 100644
--- a/scripts/kconfig/confdata.c
+++ b/scripts/kconfig/confdata.c
@@ -216,6 +216,13 @@ static const char *conf_get_autoheader_name(void)
 	return name ? name : "include/generated/autoconf.h";
 }
 
+static const char *conf_get_tristate_name(void)
+{
+	char *name = getenv("KCONFIG_TRISTATE");
+
+	return name ? name : "include/config/tristate.conf";
+}
+
 static int conf_set_sym_val(struct symbol *sym, int def, int def_flags, char *p)
 {
 	char *p2;
@@ -667,8 +674,12 @@ static char *escape_string_value(const char *in)
  */
 enum output_n { OUTPUT_N, OUTPUT_N_AS_UNSET, OUTPUT_N_NONE };
 
+#define PRINT_ESCAPE		0x01
+#define PRINT_UPCASE		0x02
+#define PRINT_TRISTATE_ONLY	0x04
+
 static void __print_symbol(FILE *fp, struct symbol *sym, enum output_n output_n,
-			   bool escape_string)
+			   int flags)
 {
 	const char *val;
 	char *escaped = NULL;
@@ -676,6 +687,9 @@ static void __print_symbol(FILE *fp, struct symbol *sym, enum output_n output_n,
 	if (sym->type == S_UNKNOWN)
 		return;
 
+	if (flags & PRINT_TRISTATE_ONLY && sym->type != S_TRISTATE)
+		return;
+
 	val = sym_get_string_value(sym);
 
 	if ((sym->type == S_BOOLEAN || sym->type == S_TRISTATE) &&
@@ -685,29 +699,38 @@ static void __print_symbol(FILE *fp, struct symbol *sym, enum output_n output_n,
 		return;
 	}
 
-	if (sym->type == S_STRING && escape_string) {
+	if (sym->type == S_STRING && flags & PRINT_ESCAPE) {
 		escaped = escape_string_value(val);
 		val = escaped;
 	}
 
-	fprintf(fp, "%s%s=%s\n", CONFIG_, sym->name, val);
+	if (flags & PRINT_UPCASE)
+		fprintf(fp, "%s%s=%c\n", CONFIG_, sym->name, (char)toupper(*val));
+	else
+		fprintf(fp, "%s%s=%s\n", CONFIG_, sym->name, val);
 
 	free(escaped);
 }
 
 static void print_symbol_for_dotconfig(FILE *fp, struct symbol *sym)
 {
-	__print_symbol(fp, sym, OUTPUT_N_AS_UNSET, true);
+	__print_symbol(fp, sym, OUTPUT_N_AS_UNSET, PRINT_ESCAPE);
 }
 
 static void print_symbol_for_autoconf(FILE *fp, struct symbol *sym)
 {
-	__print_symbol(fp, sym, OUTPUT_N_NONE, false);
+	__print_symbol(fp, sym, OUTPUT_N_NONE, 0);
+}
+
+static void print_symbol_for_tristate(FILE *fp, struct symbol *sym)
+{
+	__print_symbol(fp, sym, OUTPUT_N_NONE, PRINT_ESCAPE | PRINT_UPCASE |
+		       PRINT_TRISTATE_ONLY);
 }
 
 void print_symbol_for_listconfig(struct symbol *sym)
 {
-	__print_symbol(stdout, sym, OUTPUT_N, true);
+	__print_symbol(stdout, sym, OUTPUT_N, PRINT_ESCAPE);
 }
 
 static void print_symbol_for_c(FILE *fp, struct symbol *sym)
@@ -1131,6 +1154,13 @@ int conf_write_autoconf(int overwrite)
 	if (ret)
 		return ret;
 
+
+	ret = __conf_write_autoconf(conf_get_tristate_name(),
+				    print_symbol_for_tristate,
+				    &comment_style_pound);
+	if (ret)
+		return ret;
+
 	/*
 	 * Create include/config/auto.conf. This must be the last step because
 	 * Kbuild has a dependency on auto.conf and this marks the successful
-- 
2.35.0.260.gb82b153193.dirty

