Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B5974CCD0A
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Mar 2022 06:23:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238071AbiCDFX4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Mar 2022 00:23:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238154AbiCDFXv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Mar 2022 00:23:51 -0500
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2098.outbound.protection.outlook.com [40.107.220.98])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B633184B79;
        Thu,  3 Mar 2022 21:23:04 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n+uIiSKsoNaGBGRDFhsEdlT2PTL/+t6xv410OUPTygF2SorOlZgfcZR0yGlepVMvcFOldDi2yZGAyYHI2zb1J0ECDPBTtY9F+6kv5Tr3b6fcPb26lXp6vqaVDxfqKXupXaEV95K3s9Q+AEJzeGTUi8lmPl5EtjBByEImNhWlDjwW3nX9y5B+98sEyGtYLz1EpvlRSmZdDkpEhOA5iJvCJK3H/FU2H5GG0zKIVyIO0T1VCVzoP3O1cAfPiYLN2AvFFE6F1TfOR1+y2snvB9YqGud7aiWa+msgobD+uuI1YmZU7KathpqFUxIz7xyWXsmMStPXjARuN0ihrXbVeb6P3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8Mnt0BVzRyWj/Pd9UarkC1p5dfib/C8yCO0tbyIgLpY=;
 b=iGgJILJSYeX5F9HRKy2bgPrHTj8CskboYR12qFEgYoQallTp5tBZjKWTWzVAKyg1KYz7n4HnydQNOL9cst6I8EaR8Riugf0/Q3Z5ewU2W0HEFuPsTl2jjvguzqU2mOeLwVEuYu2Ed6+bXwWw4AyUJ5fFSw6t7LvQqCrnlc7picd9mzJFZtlOFZzAPKwFWHQB5A2joNMZiQKWiecwHArvDD13PMf/pWf7lJ7StaaOzm1MVYDUomJ99VYVDV5ImPjRO7OR16MnW6X4Um9pBT3/j9JsNSPIU0j0fxm0ZTJBsQO0M56uI6hSTupHtHJ1SHg2Uxkb+nTqKw8OdHF6IPw1Hg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8Mnt0BVzRyWj/Pd9UarkC1p5dfib/C8yCO0tbyIgLpY=;
 b=QvpO3/1tvcOxgGZ/HAA80ac4BJY6vPRCaFxuMce5SW1q+D6IW3nXfqSWZiLYmxTC6/2fm1a09eIRZIwkqkZBesNDgdmSjMEyN0YS6S08DDxUcvqsPcQHYSMnkoOyMqCG5eiERslbz9gxtiljlkgqD709V+D9ZH0uEHnS3REhTmw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from DM5PR0102MB3590.prod.exchangelabs.com (2603:10b6:4:a4::25) by
 CH2PR01MB5896.prod.exchangelabs.com (2603:10b6:610:39::30) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5017.22; Fri, 4 Mar 2022 05:23:01 +0000
Received: from DM5PR0102MB3590.prod.exchangelabs.com
 ([fe80::181b:1522:26bc:c243]) by DM5PR0102MB3590.prod.exchangelabs.com
 ([fe80::181b:1522:26bc:c243%4]) with mapi id 15.20.5017.026; Fri, 4 Mar 2022
 05:23:01 +0000
From:   Ilkka Koskinen <ilkka@os.amperecomputing.com>
To:     lorenzo.pieralisi@arm.com, guohanjun@huawei.com,
        sudeep.holla@arm.com, rafael@kernel.org, linux@armlinux.org.uk
Cc:     lenb@kernel.org, robert.moore@intel.com, james.morse@arm.com,
        linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, patches@amperecomputing.com,
        scott@os.amperecomputing.com, darren@os.amperecomputing.com
Subject: xFrom e2ebdef7c3a5e7ba998ff20bf62806c388efeaac Mon Sep 17 00:00:00 2001
Date:   Thu,  3 Mar 2022 21:22:39 -0800
Message-Id: <20220304052241.151946-1-ilkka@os.amperecomputing.com>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-ClientProxiedBy: CH2PR12CA0006.namprd12.prod.outlook.com
 (2603:10b6:610:57::16) To DM5PR0102MB3590.prod.exchangelabs.com
 (2603:10b6:4:a4::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d09ac243-c7e0-4fc3-7cd8-08d9fd9f0cc9
X-MS-TrafficTypeDiagnostic: CH2PR01MB5896:EE_
X-Microsoft-Antispam-PRVS: <CH2PR01MB589630800B67255675A971619D059@CH2PR01MB5896.prod.exchangelabs.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /dcdi9a37MlyA03+0b52pMibpNGV3FHSaGzqOg2CAu2xr4kSRl6dn56X1Pkj21BIUEW3f6UoAfs8HeZzZrnuwZ7b8TNXo0pctCLhHKANX561Skh3D9+dZd5OfgfDDMSOj25FxcdIQzsS9RUO0VLEtrJV2OmdqKmOzimdhQjkH2Bn18wOBiHlMKfifIXjTVmys0b3zz/+wgzv6X8tux2aM3ocKnRvvH3VLcZavL7yEEIhMQD7KQLgimYt55c1p1LAPXZvS61O9YUpGJBaOh/mKztxZyWGoRLzGahvb7JOOJZMT4VNa1Le7TubSssIjGSLZLcCCnsVJBtqbyjvMe3NC9sm63l28w3qokuz9p5b2O5h9qDCujyrDs12AnDzzYU+FzilAGB3kgpJfGAS/hJARhtV2hqhp9jOJvfmFG7wXeS/QbWOn/hi+ZxIWlniMrXILF9qMK403drvYd87wzbn5PvNW8JQFTKqhzGqpvnnbY4fstGuXKcJKpEqBvr0a+Z6O28O6yLmwL/YV+3SABYfK57YibLauUIE+2k8Suqa0ydHH27ZzUWj0w2ucl4suuinQCAOBQmXCw95v/ioJO2tNpvgqFIyNKCJhgQmH4RqYaGbR+/1nWh2DBJW0Dvpsehxk+ufGBUn+kTw6046tGt7a3QYMtkV6vucxxJILRzl5JBjhfZcD2htyp7zyooiWp/nEVg5w2kKaH33mDxD0bjWfwUx0pwsHPIz2YeYz810V6wE+FNfqlM4MirKqhVSyJ1zMnYc5l0ivejddmKZnde2Yrd0OnJhtSvBElqX41c+puY=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR0102MB3590.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(1076003)(5660300002)(6512007)(7416002)(26005)(8936002)(107886003)(2906002)(186003)(2616005)(6486002)(83380400001)(38350700002)(38100700002)(508600001)(6506007)(316002)(52116002)(66556008)(6666004)(4326008)(8676002)(66476007)(66946007)(86362001)(966005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?9ae8yS2lwiLpFTrqChycuVeWLhJMGnhw5rbaKr5T0MN4eNPxhCZ2TeT5mVm5?=
 =?us-ascii?Q?HXO2LQpJWsDL4IcAeqc6Xawy18Zl/wQylPvvA3Sx6BfA9Vwc5UGUjgK2GfJF?=
 =?us-ascii?Q?l7jpVQRcp8s4xox2rkxv1blq2TbvH0BAEYXnJ3OnlxqHU8ncH+qQNyF55x5b?=
 =?us-ascii?Q?sYLkJAzXEE7+8JGhoCqGOFuG//fcoGQ5teutbZpwdTU/P8zm2S2PdhzP/96G?=
 =?us-ascii?Q?wsMd3yCEK/We75KX99o6dQV1mGxQ9eewtPZcdFBlNhS/SF+85M2rK/JGu9I6?=
 =?us-ascii?Q?alNaZZPbKa6MaHM+P1up82NHNVbryVM90g5J/RmoOcM7/3MGT2LHfEjACDPK?=
 =?us-ascii?Q?E62tNw/EOrU+8/aaO2oK9DvVEOtL7uZJBk0uE1oQx23PXms7N98/bhOykFwn?=
 =?us-ascii?Q?+T+G2e/fNIf0JKYZOMcbitCojthh1mXVKEBGqMXg5XaqqvhNK4utgHhuUNAn?=
 =?us-ascii?Q?JjWW851hWbGe6dNnrfaA/5r0EqylT3HWGqBUsC/Sf4a9hUaBzU4NKf2YEL78?=
 =?us-ascii?Q?zF6kYz385357k4JIO8deoayESqcZVctZJz/CRdPx5INunf3sKS7hakvq6JrV?=
 =?us-ascii?Q?Rv2jV0zRJQcZULX4OTMYaGFEj9Ov83UMQAqBZpz+pQqVWbwfgr6si/k+u+Gi?=
 =?us-ascii?Q?U4ZIUGV85LHxKse6Hh0jtoYBWyDw7lTTZe1uDStcc3UiMwXLSH+4NVz3uHia?=
 =?us-ascii?Q?ganBX4ocmubwucqRd78PTbDsncfLjIythOnGa1IJFf1vlLvnu9GRt1jqDSPV?=
 =?us-ascii?Q?V4/khqXrSbqHvOpImVB5RyZ1RTbY/KztB8KLxRZHsoEgCDq6GsyJEDdclDJy?=
 =?us-ascii?Q?RTtsBEbFs16IzI99SLnE6tnksO5cSWf9UQpnXkbMW/g+J2QBZXQHkT+4nNuE?=
 =?us-ascii?Q?CE0aDegwZUTUPE8MT9bKqe8eSiYsBLzZLBfM6MDd2D7wK2fVKWY8fmlyoIxO?=
 =?us-ascii?Q?ILCh73A9DMzp1hADcgScljdOIJ9YSQ/yytPDv/YS2XWwoyQqGF43q8/Rs/Ji?=
 =?us-ascii?Q?uZTk/poALcPg0BcWN9fxFSZlwYH7p3V72dxjTU2efWsOaCRg1x+QnencJahZ?=
 =?us-ascii?Q?wiQ/JXOy1KRMA97+YGe/zCVjjXk66pq30p34NQSErLN/73q4aULrIR1HJsWA?=
 =?us-ascii?Q?zL20vZzKV0hsdhwGdE43dXx1ZXjP7O1Jvy9B3v8hZ2XdpRhFg65eJ/d8CAeq?=
 =?us-ascii?Q?Gr8wOt7pREGC+C3WWwsGrUqbeANfXO13+LlcYgN32l9y64RPRWlvRLySz+2H?=
 =?us-ascii?Q?hsH2w1QqNv5zQc6AYex3W6xpRIRWmaqactLGaeu1CBCdb7c7/ubvH2/RDSyS?=
 =?us-ascii?Q?wXO+y9/FJMGbTvhDFvi4qYNdElq03Wo8RkTitEKU2L3tLtxjo08zZrlXekS5?=
 =?us-ascii?Q?gBd8k6q9cbi2Ie0S27bx/T33/0haiM9Lb9/wRGV7UF0siedcyZ/L8lhCbfIX?=
 =?us-ascii?Q?eEY+x8+snIKKKkHPRr9KINfH9BDm7iySb+cQYCla2B9lKo9SpmauMDwKUupS?=
 =?us-ascii?Q?VnPsExojEIOJQPqp2+llw9/58RNQYIpXK2q+BMr9THqUmNBrR8q9YpMPuN+k?=
 =?us-ascii?Q?dlVKiRhCw0n12gV9lg2QV5A3X8Vl/Nojbi0I90D0ftPj8k4r/7mXsVvSd2Bt?=
 =?us-ascii?Q?wbUKBQkAzklEA2GuckHsGGTsDk/H7xSP76/fAs2M3T8sXHgFq+tv7o4piEe4?=
 =?us-ascii?Q?yNOUqSn5ss1DlfTg3nFMQcZUE48R97qw/6CKYQDVSacnoYVMSjSzFUL/jvjN?=
 =?us-ascii?Q?fyW95qrKbw=3D=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d09ac243-c7e0-4fc3-7cd8-08d9fd9f0cc9
X-MS-Exchange-CrossTenant-AuthSource: DM5PR0102MB3590.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2022 05:23:01.1106
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aCrwLDUmhKa/OUbtj8d7WEJuCbILx4OLVKpYzdsMfTE3kZZ50O+7qu5V7pAw4feHIAmZr/8o3tVpEu9cIJ+++47e76UqhwAaZTZfWm4Ypejvux3rNAVfuf3fd34J55dN
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR01MB5896
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Lorenzo,

Would you prefer this version, which doesn't have platform device/driver
any more?

--Ilkka


----

Arm Generic Diagnostic Dump and Reset device enables a maintainer to
request OS to perform a diagnostic dump and reset a system via SDEI
event or an interrupt. This patchset adds support for the SDEI path.

I do have a patch to enable the interrupt path as well but I'm holding
it back since AGDI table is missing interrupt configuration fields
(trigger type etc.).

The recently published specification is available at
https://developer.arm.com/documentation/den0093/latest

The patchset was tested on Ampere Altra/Mt. Jade.

The patchset applies on top of
  git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm bleeding-edge (9db71e8e3027)

I also tested it works on top of Shuai Xue's new patches in bleeding-edge branch (c6f4ba2d2b9a)

From v1:
     * Moved pdata to the stack and dropped unnecessary kzalloc() in agdi_init()
     * Changed the ACPICA patch upstreaming order comment in the paragraph above

From v2:
     * The first patch was split. The most of it was merged to ACPICA project
       at first and later ported to linux-acpi
       (fd919e37cb15914c6fe13e13d530a4f732407c6d). The rest are in the first
       patch.

From v3:
     Fixed:
	* Moved header files in alphabetical order and removed unnecessary ones

From v4:
	* Platform device/driver stuff removed
	* acpi_agdi_init() call moved from device_initcall to acpi_init() 
	* Slightly modified Kconfig text to keep checkpatch happy

Ilkka Koskinen (2):
  ACPI: tables: Add AGDI to the list of known table signatures
  ACPI: AGDI: Add support for Arm Generic Diagnostic Dump and Reset
    device

 drivers/acpi/arm64/Kconfig  | 10 +++++++
 drivers/acpi/arm64/Makefile |  1 +
 drivers/acpi/arm64/agdi.c   | 52 +++++++++++++++++++++++++++++++++++++
 drivers/acpi/bus.c          |  2 ++
 drivers/acpi/tables.c       |  2 +-
 include/linux/acpi_agdi.h   | 13 ++++++++++
 6 files changed, 79 insertions(+), 1 deletion(-)
 create mode 100644 drivers/acpi/arm64/agdi.c
 create mode 100644 include/linux/acpi_agdi.h

-- 
2.17.1

