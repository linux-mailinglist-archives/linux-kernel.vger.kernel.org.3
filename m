Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F09B24AB8E6
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Feb 2022 11:43:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245546AbiBGKi5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Feb 2022 05:38:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237922AbiBGKdf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Feb 2022 05:33:35 -0500
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2073.outbound.protection.outlook.com [40.107.236.73])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03A4BC043188
        for <linux-kernel@vger.kernel.org>; Mon,  7 Feb 2022 02:33:35 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T7EICUF8uLXj6XyWQ/bbdnM9UsmaS1oanTj06vnpX6w48QWmkWsP69898fin51Zel/h/dj/zOr9sJaS+yIy7I/6rMhmJ1sTOgute7oX8r5fDsgodTW7R72mh+lER13DLZf1hW43rDLLFNwHA47ajjmiwSbO+7zgAzRcKczqCTeiGhztxDuVTgWpaQG3FGRYY63rHSslKlRuqtmRXf+y9Uqi32xFNJXGxEvJ0THdnxpp7oeJldXYYlzBJw4QS4FhuQnO4ZnwI+zvgnXu3Fou7BP43XqmUVVGSvt0EG772OIU32cdMlyF5KV50BFX0w3RU8WfD8mIeJuYpGcuPg6lvhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/7kvnoxLETDHojc+rdhsQm8BikRm3PGuXeP2roOGcfU=;
 b=kuqNvtCS+Ql41j4br5TN0nltpd73hricDk0iDbfr4FzTdDYyqDXX0hrjq7TqpF0RyMZ4d4fxQ0r8VaWFxX7EFRGj/gui4YG9n3lxu3xwGf6eSCvH5reA0U9RpbSrQmK2FQ3zl4RFSMzl6Yzt9V7n57J9wpCy+BjVYAKPsebdlemzU4NEfKdRCyaZg2PvpiktqIHewLL/psZ5LwxkfD2ec0AJ+iQrfRhmb2V+zCsZLxIJSdbpd1ReuSGY8JpVm+3B7Kes4eadJeBvDrn+rBb6MuGXN8NcYuf9SVcpm9qmmMv7OSxB4RFvJ0E5Hdolai3YAnM7QyaMPTJrT/nWGZ4zPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/7kvnoxLETDHojc+rdhsQm8BikRm3PGuXeP2roOGcfU=;
 b=be+hR4hcdN0KnJZb9UNKg5vQRreTLxkyEbzlPar+QTyWS9cvA+7FQkQq1hX2Xn1PSCqnmev8K2NYUnhwE1ArQrfTqsXzrCuyjL2X2/amnmMS/ok4Pj2Gp8SVTLm/X2NgE5xvXVCtzMLpkBvDHLPOZV0aFXxFcjL2BxR4fXRgBlQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vmware.com;
Received: from BY3PR05MB8081.namprd05.prod.outlook.com (2603:10b6:a03:366::15)
 by DM5PR0501MB3686.namprd05.prod.outlook.com (2603:10b6:4:7d::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.10; Mon, 7 Feb
 2022 10:33:31 +0000
Received: from BY3PR05MB8081.namprd05.prod.outlook.com
 ([fe80::283c:d671:e4e5:31f8]) by BY3PR05MB8081.namprd05.prod.outlook.com
 ([fe80::283c:d671:e4e5:31f8%7]) with mapi id 15.20.4975.010; Mon, 7 Feb 2022
 10:33:31 +0000
From:   Jorgen Hansen <jhansen@vmware.com>
To:     linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org
Cc:     gregkh@linuxfoundation.org, pv-drivers@vmware.com,
        Jorgen Hansen <jhansen@vmware.com>
Subject: [PATCH v3 0/8] VMCI: dma dg: Add support for DMA datagrams
Date:   Mon,  7 Feb 2022 02:27:17 -0800
Message-Id: <20220207102725.2742-1-jhansen@vmware.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR11CA0062.namprd11.prod.outlook.com
 (2603:10b6:a03:80::39) To BY3PR05MB8081.namprd05.prod.outlook.com
 (2603:10b6:a03:366::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ca6f8b97-03e5-4f5a-491e-08d9ea254902
X-MS-TrafficTypeDiagnostic: DM5PR0501MB3686:EE_
X-LD-Processed: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0,ExtAddr
X-MS-Exchange-AtpMessageProperties: SA|SL
X-Microsoft-Antispam-PRVS: <DM5PR0501MB36866BBB9FBCD670990B3225DA2C9@DM5PR0501MB3686.namprd05.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DNQeiOIPrUHU6SAoZkYRKUMu5w+rVHN31NaVP3V1GkO3pFImYGZV+KKop8zFsHakQEjvSWlxkVhCDUueR4N5I+hLPKg2F4Y+JMm+ies+aJQlgDW+7SEsGazG4O+64veviyHBouNvcmTb7CQEXidqLSuZhBVHj5jznFFT73jJJjiF/JGiAiOQ4obeY/By0TrVhfRj+Hs2+LrRZiNINBnc9ks3zPZJy/ASzw0z1X+MdcnXy29ui91ejMDIqidHqzs+H0UCGP3yEsPE4V1U3z6Ved2snXxEKxKMx4HjPeJss54syy1KtVJsBJ2ifnC3C63n1c6x6MdTZA65Q/iQi+FKb7P/HjfRWm2hTo+jBBC7ZXJqiAvDozteVqwM6ZMr+xQlyUV1tGFtWpC2QErTQZ7SRz6Xp/JPgM9g8juGW3+oxYS2dcPVXeoeT4Yb6wm95AiXy8eM7xhidyyGX74+3e7eA0mMkPLfqSjx7pC2AsFqvwoMG0nrmulISBy3EypbOoctU87RqK2GpBs97KkeHj5wGOecpSdsEDRU61Z/X21Kiq8zhTs1PvHI18/RKJKHBBi5SKRPgthJQmA4+2r/g7NGV9R1bVC343F/t5wy8c8duxVUPN+ClryZ1YItg4LCyNEDcDbk1AtPAfL8wLkHIwZ/PwQpioLs1wCsmBo/KRsVbTUddNfc8YWzelTm9UB84XGU8TTOCWENpgfLs3KpCir5YF8bos22YiZCnQkIfOSD33q0RxnxwpUnIT1apSYiO3Hf
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY3PR05MB8081.namprd05.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(38350700002)(508600001)(6486002)(38100700002)(107886003)(52116002)(1076003)(8936002)(6512007)(36756003)(186003)(316002)(5660300002)(6506007)(2616005)(2906002)(26005)(66556008)(66476007)(8676002)(4326008)(83380400001)(66946007)(6666004)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?mtXwKbLFcp6TrdDHvCLDJ+k6SnW4nyVMB6nAMLRqg0lhCN45GliDaOodV7nj?=
 =?us-ascii?Q?A+6lWH3/cR60W4EyMHupGfS0W7/7AfeR8mGHKueNu31B4Kb269h0eTAiQrE7?=
 =?us-ascii?Q?LOzFeft12nDcOmg72hmFsv+/XccNWMR80lQrDRZKT1zUivzRaogFYo595UB4?=
 =?us-ascii?Q?LLp5/WOHCIwZkVn9ITFDZAJPQctq19ofjjqcma2oZRD7lJ+KuCNorsdY3Wfc?=
 =?us-ascii?Q?1PewI1w9gmorAVXdbbsx8hpuI5C6m3heLVUMxvj69b5GYFNFxpC+JcB67rOO?=
 =?us-ascii?Q?v1+voz9W1hNI8AGShoOPAQF12+bCPHiNvCwpsoLnvRe5347TXFIonaId4qZY?=
 =?us-ascii?Q?ELbmW3gkzfFJHZCbzcrLdk/u0goTK7AImKrtEa7zkbqD1XmBvgUs3izUcsXR?=
 =?us-ascii?Q?4kDKVSAFiyqcJSWxiS9fyKwc5pocZOSn8xNWSEVd41ATTXQdmYcCjOM4qtoY?=
 =?us-ascii?Q?H7LoEqUTimUcXOjS59aMv3r26AjXNAjm/eSwYguAVbEcz6NPvI1dp7h18JNT?=
 =?us-ascii?Q?JardRtPncv75TYboNA+Mz/lcujlQzh3gwcd4sqpiYR98/7fIUrxvBvafOpz5?=
 =?us-ascii?Q?JrBOlUfcTAeA03znCydWifvw/LBcoTP3yD2cOjc9Flle9rHiPJjgQ8BWtzlP?=
 =?us-ascii?Q?4XP9fplIMEkK57wf5iN0HeV/zJZetjvoQdGEo/aSGX9KR9k5yiwN8G1nnWRK?=
 =?us-ascii?Q?8xWorL07VJgW60xq4pIwPQKF3M2gk4YqJss9iKnt2VCxrFS/JQ4hwtyrGY/Y?=
 =?us-ascii?Q?XnBxhNtKKsEDvMSRK7YXwJDNrcULdFsL5ZjsmfXkWV0iK29CLpAGq7CHqSt+?=
 =?us-ascii?Q?MRYvUUUnVywAL1yRjCF37tHC2RAfAR6zwMMRykgYwcL81ZZgAWpZCxTjnkTz?=
 =?us-ascii?Q?5YuJ6vfcf3gPFr7OLV6NNxDRVLzzuKgioBQ8tFTs7df5h7UcHSqqL/FV26C0?=
 =?us-ascii?Q?pteLryhFShfwA0YHZk38GqRMYsgJePAb5l9Gq8e14szIwvvkGEgnH82/OfeW?=
 =?us-ascii?Q?PlJQwGJkN1nkSBZv9xqCdS3S+mUItbW6XTzAsgtshtsiHBCqwv1JYYdkXdD8?=
 =?us-ascii?Q?WI/fcbI1eVTWbjgeshsJhr7u385Op7We8Pvcb/1fIx2ybpcHGaGpu3pSEMk+?=
 =?us-ascii?Q?kt+mHCR53c11L7LEs/EhuD4PzHQRV0EWwxIn5x+AgsBuoQcIrWLIWQV3QNrQ?=
 =?us-ascii?Q?arFqCnMRyoutsFgpIONWr4Gs4bX7bjKfnB16kTn3YBBaHpYkH84Wyc8c5oxn?=
 =?us-ascii?Q?+DIFkM+LqSAxYALM3s9Sh+iJINfpbEsY2J0uSbSRNn7NMcyUYuVy9VIQHK8I?=
 =?us-ascii?Q?VdMWOD0od25vFT8WEc6QBxw3P0o0f+ZS87VbFBN4PSY9KAufqCj/55prwZfN?=
 =?us-ascii?Q?ymoBWt84GQze30IqvSZqbGCDEmauhsUdOpgSiTHaDbV71AwWSD4ptRtZMiwB?=
 =?us-ascii?Q?/Cz24zo664OPsipy6ipAy9TE5jw94kQJZeO4LSJpk7jvTxqF/cyRhQMKqyx9?=
 =?us-ascii?Q?nfZZJX0s/iID5HVFHnf+uIVL2DGCF5IbFpe5Cjwjh38gZgSEP9v/uuzZn5k6?=
 =?us-ascii?Q?tX5zx8DlFCm0WY4M5tJx4kzDCGz79FVZA3OlkVVog39cJfA9EScuvOqI2EhF?=
 =?us-ascii?Q?I0EVvKAhekW9ouRnsoCky8g=3D?=
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ca6f8b97-03e5-4f5a-491e-08d9ea254902
X-MS-Exchange-CrossTenant-AuthSource: BY3PR05MB8081.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Feb 2022 10:33:31.6086
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: h2A5zUwJGuqcqKaf+tczou21A2CA6pjMR+vJdMUiA/B/z7uLFTyMJp16A8mVJiFVd+mzFrokOFGSKAztRtt6ew==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR0501MB3686
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A new version of the VMCI device will introduce two new major changes:
- support MMIO access to device registers
- support send/receive of datagrams using DMA transfers instead of
  ioread8_rep/iowrite8_rep operations
This patch series updates the VMCI driver to support these new
features while maintaining backwards compatibility.

The DMA based datagram operations use a send and a receive buffer
allocated at module load time. The buffer contains a header
describing the layout of the buffer followed by either an SG list or
inline data. The header also contains a flag indicating whether the
buffer is currently owned by the driver or the device. Both for send
and receive, the driver will initialize the buffer, transfer ownership
to the device by writing the buffer address to a register, and then
wait for the ownership to be transferred back. The device will
generate an interrupt when this happens.

v2 (fixes issues flagged by kernel test robot <lkp@intel.com>):
- changed type of mmio_base to void __iomem *
- made vmci_read_reg, vmci_write_reg and vmci_write_data static functions

v3:
- removed log messages for page size and BAR resources

Jorgen Hansen (8):
  VMCI: dma dg: whitespace formatting change for vmci register defines
  VMCI: dma dg: add MMIO access to registers
  VMCI: dma dg: detect DMA datagram capability
  VMCI: dma dg: set OS page size
  VMCI: dma dg: register dummy IRQ handlers for DMA datagrams
  VMCI: dma dg: allocate send and receive buffers for DMA datagrams
  VMCI: dma dg: add support for DMA datagrams sends
  VMCI: dma dg: add support for DMA datagrams receive

 drivers/misc/vmw_vmci/vmci_guest.c | 335 ++++++++++++++++++++++++-----
 include/linux/vmw_vmci_defs.h      |  84 +++++++-
 2 files changed, 355 insertions(+), 64 deletions(-)

-- 
2.25.1

