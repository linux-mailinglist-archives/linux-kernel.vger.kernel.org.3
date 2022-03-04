Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B59B4CCDB0
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Mar 2022 07:26:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238365AbiCDG0r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Mar 2022 01:26:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232071AbiCDG0m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Mar 2022 01:26:42 -0500
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2099.outbound.protection.outlook.com [40.107.255.99])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A89D3AF1DA;
        Thu,  3 Mar 2022 22:25:54 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HTuc7Xm0bkBK15BBvE4ibpb+pR61Cq7TgE5vq7wSmI6PPkMGeIQLbgY3WS95ZtJ6C99oGykT2bWZ9fzjlcKmmr99SF0dYjT2UGkLvWPL3Tt/xsS3uFE/LGwomzlAHM2wyR/V30wEFrShy+FEF7gsy3S0OK9cJgjHQAzmndV56AFPsE0+Fwba1FSZorwXKSjIUsxouuNrJucH9MxW9SJrecEdbUIr7/cQeFKY9/fCsBO/BIa8dWJ6/l91IM0T1yXvhRDZKc9G1RhvK+lbJs/9e+8BwF6Ti4y8yBfV29NT1RwVWRkf0wa5PqaIA8sQY0LKswz3Y1mXiBxcoOdWl9AlEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W9UjCJhrMFHgrzhto+GR0opGkPZr2TkaqDOvMk6GKNM=;
 b=bLocSLgF8XwIkv1KHBZM2T/gmi+EBXCzoRqsA/iY/LHWT0rjPN27zSMtKMt6Sycaoz3LL+XSGTxVsfX1XBZ9fGHjl1L4HfzjtLj5DFDyWfX5eUp5wB1W26YPffMXojMCCWYfGY+m/RbYB2WyPn1RECE6iz/hDrkb3pV1om0RhXRsOmB3js1gpGzTWcM0xabefNEM1UopsZgoaCU5mAycRCCTDnU7UXK/DGk3f6rd6GdWsKU//BAavxa4nuCYI+iF0InqG2bb3B4JiZMRRvdim9jbtE9Pv5AD86GkqzhiaQg1IDsat0I5203AIXb1oJPWsrx+CD9gPpeJZrlxO5i39w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo0.onmicrosoft.com;
 s=selector2-vivo0-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W9UjCJhrMFHgrzhto+GR0opGkPZr2TkaqDOvMk6GKNM=;
 b=XnyUhd4Wohmf8/RC/tKLSeh7eATlKQ30s/fiw8NvGhxqzUKJ6CpVyM8eorUzLRGVVow5e512XsxY3IpldBCESis9gqz+1TqGfukm8JZvwiatVdMgtsk7wgWnq8tUqqoH2PsVJTrlmzqTVRu7izkoaReZjt88/H7EQfyR+WPPB9Y=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SG2PR06MB3367.apcprd06.prod.outlook.com (2603:1096:4:78::19) by
 KL1PR0601MB3767.apcprd06.prod.outlook.com (2603:1096:820:17::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.16; Fri, 4 Mar
 2022 06:25:48 +0000
Received: from SG2PR06MB3367.apcprd06.prod.outlook.com
 ([fe80::9d3f:ff3b:1948:d732]) by SG2PR06MB3367.apcprd06.prod.outlook.com
 ([fe80::9d3f:ff3b:1948:d732%4]) with mapi id 15.20.5017.026; Fri, 4 Mar 2022
 06:25:47 +0000
From:   Wan Jiabing <wanjiabing@vivo.com>
To:     Jonathan Corbet <corbet@lwn.net>,
        David Howells <dhowells@redhat.com>,
        Jeff Layton <jlayton@kernel.org>,
        Wan Jiabing <wanjiabing@vivo.com>,
        Mike Rapoport <rppt@kernel.org>,
        Rohith Surabattula <rohiths@microsoft.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     kael_w@qq.com
Subject: [PATCH] netfs: rename read_helper.c to io.c in netfs_library.rst
Date:   Fri,  4 Mar 2022 14:25:21 +0800
Message-Id: <20220304062526.336853-1-wanjiabing@vivo.com>
X-Mailer: git-send-email 2.35.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR0401CA0005.apcprd04.prod.outlook.com
 (2603:1096:3:1::15) To SG2PR06MB3367.apcprd06.prod.outlook.com
 (2603:1096:4:78::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1a00b180-539d-41be-a61c-08d9fda7d1bb
X-MS-TrafficTypeDiagnostic: KL1PR0601MB3767:EE_
X-Microsoft-Antispam-PRVS: <KL1PR0601MB3767E53F758284A2B4D2CFEAAB059@KL1PR0601MB3767.apcprd06.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nRieriuo1JZ5JgbQbCSXeIVX04DA+C6pfxNBGyXLA7fIENwjHd4R823zEVA4DEds2s9OPfXB9tyj2fFH3IJzhpY717PaAv0sjGwajxXp+S8wGu9ytzZI83AlAiolkb5j428iBjMhFW8j1BAxAoXIlsGhBiSAVmUQSSn3+VBE8pVsn9Cd+0yF7HakRpkE+PU1rAMPGO125QKVabB0pp/y5NahG1Xi7QD0j0//RZZhVTsA66EAcw0w83APqDbtKDMiHbhmTN7zcvTxA/czErglTHs8j2vGiBiHDBR83lIjY0F2eY8RHtdSUKEHXJxF78PUq/LjCL4UVZ8ufQ6TF7RE1iIfMqcWMx2+kMwi8Oj+bPkpUDOojIlfYjQrUAxe92eWg7tHi6p2IkzL22Gy0FRetYXavseUXadKImmgAXzKlHneq0gibDDVuH5LmjQaGQx5WIeZPY/3ksKSq57ZtuW5fJWHn+rFjdcKgILx+Qyd1Dr0r1S5AMvJzza1oli/Hdu8ONbl8fNVq/qUfta1jbNlmw3pKv57hmrJTHlEwnm0F79At3qbT5shFdzIKv4v4THxZWEPIe2TCPuqzUI/T/Y+f/kt0nTcAyFlAk5nvxQ19nw7ZK3GaOniQXU5cqWPHHaecu6M9ySvkGVcqXyewxr+fhd9FQJNGhD0yumMvBhC+QYY/3+r79f+cJc+xckPzL6g
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SG2PR06MB3367.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(38100700002)(38350700002)(508600001)(6486002)(86362001)(4326008)(8676002)(66556008)(66476007)(8936002)(316002)(5660300002)(4744005)(110136005)(66946007)(83380400001)(26005)(186003)(1076003)(2616005)(6512007)(6666004)(6506007)(2906002)(52116002)(36756003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?1hNTEMaNPjNVkO+s8QHOkOnAALBqKNBpTADuppCEzDXudofPVyda8TKOXv5M?=
 =?us-ascii?Q?usLQGi2g6Jhi+Og4VMJdu4a/VEFHxhUpzL0cLXTXQnf0wVKD7R6/oPCWGo2s?=
 =?us-ascii?Q?tbYtjPUkkL6T5/1XDXmJXzhA9KiLxoi4RTF0HqKSf1sf380s2XCadm9XoXIU?=
 =?us-ascii?Q?JabJ0xRTfRxzlMIUCnIpL0WE78eqcxKwImkF2mGSU8x6kKSC+jwbxKAi+Za9?=
 =?us-ascii?Q?u1IcmY2G6U5/8uD9jKgUn26xD+/QVHrhSgbodNU6Fhfv3Nqa7um+LTJteFyE?=
 =?us-ascii?Q?jPHNOuHY1fbfQ+nKI6cD7PwzAtMNq4zq9QZqn2HZXmQNoARsazae0tK0jnFU?=
 =?us-ascii?Q?ysdnb9bnjs6REBPIX9ZSRkObL2u+IHIL0OAdWn+ErzvdhYyUKl8Gvvxj/YCN?=
 =?us-ascii?Q?wtlzx3Enk8EuyfEQJglL5dTRNcrP+aciEe3OnZLndzaADKafzgXuu5HPBqnj?=
 =?us-ascii?Q?kj3B29W6IiAJjuPPDZpAmc5ks0BB31MDOJfwivNgZQC5tL65Ozkm7I2nAFW1?=
 =?us-ascii?Q?j8Wp9e6fvnfSjSTBnGWDLIf4F6og4HcQhUb0OK+e1GW6d+WQYYh9VyfmUjpQ?=
 =?us-ascii?Q?PS4Pwqxl5TPWSirYK8kQetkhP1+V1LmO/JouxUiNe4TGPp8K2LR84OifvQbT?=
 =?us-ascii?Q?Nb378p6Pj2YtBDy2x58RMzYaVSVCYSR/qoc/YnCqhYRZh4jO/QMixPFIFU2c?=
 =?us-ascii?Q?pLIkLlSlFbmTIOUtzJW8f2AmblBU4DnDtx1Rq82d++/4VDeENnjPhioYqWHm?=
 =?us-ascii?Q?8gEHmkolBHeljASI7v60nqPc5ZuSBvygC3OcYX82KEPV6lFAj+wLtxFx7hsN?=
 =?us-ascii?Q?e/497rxXcfiuKjG1JTCCnIYGw/oUb9TOxSAQ2UbH9Tus5sBlNLIYGkW/38ke?=
 =?us-ascii?Q?MM4yEtUd/7AG0RIjffVDu84wLs3tlDKb7WucDAih6pUc/VRngNaCQbHPVLvK?=
 =?us-ascii?Q?yoULo9EQCbNewH7LHCLGpVcz7rEIgt7G8ki4VZDANMm0a+WMF7o8B7efaT75?=
 =?us-ascii?Q?rKrDcx8y2KGY4mgFZj67a7QInGjoR4tsn9K9SxRjHpIuk4pYeTiLMa7U/Jgp?=
 =?us-ascii?Q?6pTmqrOc/v1WHbjzINLgJxvC79NUA62Su00/uLl/zyFs9nvt0SqL8+LRjJdj?=
 =?us-ascii?Q?sICC5PsjPXpWARLJd2JAi5zWUiBSVggjuys4/j8836LywAVszWivi1MqTr8t?=
 =?us-ascii?Q?vDxEUYYuWx0ZlyJOzOLgaASqJIPQb/CwGDRMfQmMRRsKFtzwz+rhXiqiFeH3?=
 =?us-ascii?Q?7y08eqnKy6ipEJ/st8zCA13PGeEs5s+hGohFwauTqc5EI+ODBeeIH2inZjKX?=
 =?us-ascii?Q?rW1Z1wjbgY8RX1Xmx0BxTcy2ZzIZwTapa3Vrr+GQDFnjMbWSf4Q+e84/FvEs?=
 =?us-ascii?Q?0zkbMtF3IiNLLxHtFJFMdBkVmUe85V5ti2xrcgtkmjKe3SM6z6LVZvUoEj+L?=
 =?us-ascii?Q?zglFkGJWeOuXoJjIND+CM4F+Ft0qwNY0OicwKJqzr32JAa/OoFIe74TSXj/A?=
 =?us-ascii?Q?sflhp3Tj9jgbbl96Cpp7O9VOSqi/UjIPLPdXNufb58mvbpBpqq/k8TkRFrhY?=
 =?us-ascii?Q?xeyG/N9C/T/M/tTNjD6NunxSUTm81AxEpZYJe5DTz9lbXNFPXUcWnb1gElV/?=
 =?us-ascii?Q?kYAo1uTcC3J0/vQl+iFokWY=3D?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a00b180-539d-41be-a61c-08d9fda7d1bb
X-MS-Exchange-CrossTenant-AuthSource: SG2PR06MB3367.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2022 06:25:47.4893
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PQsHxhpTx1VIrOVKsbvqz5u5bJtbFZSZCL7ek3/T8U+4mjF9rXsoUR111HQ4ADJgQEYowt9do+LNEmYLNVMBWg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR0601MB3767
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix following 'make htmldocs' error:
Error: Cannot open file ./fs/netfs/read_helper.c
WARNING: kernel-doc './scripts/kernel-doc -rst -enable-lineno
-sphinx-version 2.4.4 ./fs/netfs/read_helper.c' failed with return code 1

Fixes: ad9e5adb388f ("netfs: Rename rename read_helper.c to io.c")
Signed-off-by: Wan Jiabing <wanjiabing@vivo.com>
---
 Documentation/filesystems/netfs_library.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/filesystems/netfs_library.rst b/Documentation/filesystems/netfs_library.rst
index 5e1b25349c41..d3123348d2a2 100644
--- a/Documentation/filesystems/netfs_library.rst
+++ b/Documentation/filesystems/netfs_library.rst
@@ -562,4 +562,4 @@ API Function Reference
 ======================
 
 .. kernel-doc:: include/linux/netfs.h
-.. kernel-doc:: fs/netfs/read_helper.c
+.. kernel-doc:: fs/netfs/io.c
-- 
2.35.1

