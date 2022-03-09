Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A65DB4D26BB
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Mar 2022 05:06:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231284AbiCICJP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 21:09:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231269AbiCICJM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 21:09:12 -0500
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2112.outbound.protection.outlook.com [40.107.243.112])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D10A9B82DE;
        Tue,  8 Mar 2022 18:08:14 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oXgFZbLNk0A9BRpno5PcNtNtHfP20yhoVd5ZFQ9slp1NMLWVO2DzuTXcm5EpK0W0jVjaJjAm06PRh5kjW1mIG33C5VUV915oJErJlcbC6ExgHomHLLFYAa5h1DB6ZklQBQ7+n/v/xruIWvk4MZbBKlobI0TZvfQzS75l4oC/Z6yhBK2ijgjUHfI4fLJnstHStgBwnHFNIaUp++CDxZD97tiBpzEmkiQ3Sx27xA/CRuqh3Z8RliHtW0p5oSUT3CZeMX0qiBsCuszWv7Q9Z6Hs4ITDpR4cgh5K9lJ/CI4fciUCNwLulacUV5E3SH5fTZDaEOYDwcrN9kh5eMFkF4w33w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7/eI83A137BslZ5/tE9NA/TkPfEflyn/2tT+Q8K+aGI=;
 b=jsIBxzAFknfJ39t+EUHq0mj6y+iacsqObi9AK0HNMwKez3wr93MedZ/QcJ6mfh3CRV84YxOQDkEYc9fdY4DMCTHVTlfB6GpDC1750ht2qn//+dY0BYUyShDN9o8C0s06YlxuflwvfHDdICreBBtSnzo4wlpOakXaa56h1xue5dyDe4FKKp0HBVEHy2vtTnGlGx2Quo2N5RUe78ANUrjm0IMGsNYwSUIjKNwJcBfEGMqyQ1sInFEWi/AVtP8dXhr2ogMuzXLsYTBCIaGj4wpF9HDWmJxB7WpzwgdATmiBXNJ+S+kDY0fU0qDXG4tZjqLzWH6xgATFpP3t8BjniI+7hA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7/eI83A137BslZ5/tE9NA/TkPfEflyn/2tT+Q8K+aGI=;
 b=cdd4N9wELln4eeQN35NtIMqBEInLPjEqDOr3BiWdyKnzXHaMvo4RdhFJBTQalAdvOn93fEG+/4DBFqkSeri2kRxgkpjIjTxfqLmPp2lniKQIcw7uTMFdofGaJyhcaIxBrI2QmBAIyXi07AU+fYQrxV45k0ke8xJcKiOU+fhua6k=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from DM5PR0102MB3590.prod.exchangelabs.com (2603:10b6:4:a4::25) by
 SN6PR01MB4288.prod.exchangelabs.com (2603:10b6:805:af::10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5038.17; Wed, 9 Mar 2022 02:08:11 +0000
Received: from DM5PR0102MB3590.prod.exchangelabs.com
 ([fe80::181b:1522:26bc:c243]) by DM5PR0102MB3590.prod.exchangelabs.com
 ([fe80::181b:1522:26bc:c243%4]) with mapi id 15.20.5038.017; Wed, 9 Mar 2022
 02:08:10 +0000
From:   Ilkka Koskinen <ilkka@os.amperecomputing.com>
To:     lorenzo.pieralisi@arm.com, guohanjun@huawei.com,
        sudeep.holla@arm.com, rafael@kernel.org, linux@armlinux.org.uk
Cc:     lenb@kernel.org, robert.moore@intel.com, james.morse@arm.com,
        linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, patches@amperecomputing.com,
        scott@os.amperecomputing.com, darren@os.amperecomputing.com
Subject: [PATCH v6 0/2] ACPI: Arm Generic Diagnostic Dump and Reset device
Date:   Tue,  8 Mar 2022 18:07:48 -0800
Message-Id: <20220309020750.65399-1-ilkka@os.amperecomputing.com>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-ClientProxiedBy: CH0PR03CA0423.namprd03.prod.outlook.com
 (2603:10b6:610:10e::6) To DM5PR0102MB3590.prod.exchangelabs.com
 (2603:10b6:4:a4::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: efc77cbf-a958-4672-c03d-08da0171a8b8
X-MS-TrafficTypeDiagnostic: SN6PR01MB4288:EE_
X-Microsoft-Antispam-PRVS: <SN6PR01MB42883131D546F84D90C125F79D0A9@SN6PR01MB4288.prod.exchangelabs.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bliehxzrId7ENcWhbW1CMeHbgC3Pv4OEhjZ7sf4bODvCwgIkaJtxEQHXH3nEirVePlZt23ivgTTXo0BnslIbOK+wY4lWw7Y3JKoxB0sWBl3W6SVtsJ4D7WjW3h7ffo5qEyqNv1nOeQabhwsYxs0XCfeChLAj14/hq9mtScq//2J2ROUq9G6KzRfnk6odT0294wyXKvnYF4+SUZJU+orpa+b1odTi+eAm4bzYesaux0+8lPJ6MObubXwBm0Hx5INR9fakxa/4KXsH8+eOCTe9ZWpLh/keXCJiyUGYqVbtnazX2Wv+AclgVwIWGm5By+oLSxuwM4xdDM6AcjCI5nOYMFnNbJ4p6Iz9z+eI+Py6Okbws5UlqGp0iTM8WcGaUrBEMxcP2XrXCO2RGJWm8PeokYW62PQ6zoEW8dg4yjpIlNgR3vRrrIU/ku1BJ9o+BEFPQSLxxTfLAu12bnN2zfp4L9X6n/ExN3bpEFtPoftsXFexKPqiK2NQ2tb1oIKcTdJKFp+Ofne4NT0xOuSCCyiDlZC+EQv0T440UoZNfARiGbMNwyunQ5mzgzYiKw0EGyoBqxfdrHrvuZpV/JHbptOUiqo9YSnPJIfwIxXzTqyKWHyYU06Okkud5stizCgQPNhjWEbGbhvIx0dHfSEu5HTDBomtV7w6Ne0zyx8BvaQhN2KY4ahaPrTggnqiLYnxAxbytNjp8PLkoQjcY3YRf1wI/s1aNwNV5MUNjOJ3oBZLFBEtNUNc5S0upQM5c+boW/g7X7TpGf69daIlI7Om96ElqoiryTq65C6r91hyuYj9j0z0Xcvi9HFlQHxEtwQwwOk0
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR0102MB3590.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(66946007)(316002)(86362001)(66556008)(66476007)(6666004)(4326008)(5660300002)(966005)(83380400001)(8676002)(6486002)(38350700002)(26005)(1076003)(2616005)(186003)(7416002)(8936002)(38100700002)(107886003)(52116002)(6506007)(508600001)(6512007)(2906002)(41533002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?x266wc7r/pOOIBMsZ/MzihpetHJtqERjGHYbV/8Tlut1mQIaB142ZLC0Y5oo?=
 =?us-ascii?Q?wBicK2JDIP5QQenN7gV0LD2fdEvBhAaLrzdn/Qu3DUvbzYlVJ+koPMIzUWS/?=
 =?us-ascii?Q?wITbg6xzJayI4o2b1tl6K/K6sTxsCGqbryYDasK2kY5for9hyJai0C+KVao2?=
 =?us-ascii?Q?D6e85VegLfoOsMESYVblh8CoKfd2JGEMLz7NHt9e5onvJFhUkeKr+jAk02zK?=
 =?us-ascii?Q?duHIXoHxVmYe0fiowI457cjbFYtiyJddpfJTqHTSgapRBzzD5S3IQyowdvOP?=
 =?us-ascii?Q?frJQcYf83YRBnGSf8468NubzpW/d9H5d4q/0mwqxMk1e0GxzRk6rn3qSlAS4?=
 =?us-ascii?Q?anaV8KrK7IwdNaGzJtHK3Q70hrpAnhAXlzpMRUK/o9+xjBDu9rpAovQ6MMlI?=
 =?us-ascii?Q?zKwW6tecoQbvnOCq3QZJpQfcxh63p7oCMGMRvMATYPhw9bDeYpRJ2C/9EosN?=
 =?us-ascii?Q?2BLPhqkSOK2fzSst4difFVZBlfblkQeF+LnXiT6ghqOsrJo7gwy4uuysW60c?=
 =?us-ascii?Q?iRuUmoZAFTJGzT8+PZfC7zKSOD//opV7PZ692tsxMMoTMJjSpc1GN2vlbpEy?=
 =?us-ascii?Q?K+suVEoUw+N99OzuuIG9JeQm9YYPS5uIz7EZYwr/98GGQWck76AiIwsc6xSr?=
 =?us-ascii?Q?HQxUby3ECGap50Ey1SCi215cey/zHinZL5DT8u9a1IpKXbHSmALuN36e/r02?=
 =?us-ascii?Q?6ppKmAEIwMv7vvR7UepAtsMxi+xFGxi5ufDeUKDhzXWDeIQ/hmGRP91FsqWL?=
 =?us-ascii?Q?AcmPNaJwlyFuPtRBgzVMzTHAA8V27Es0Wd4SVB3yL+hAPMfiyUNjIvSJkytY?=
 =?us-ascii?Q?iL9fJ/9QzVvWKP+0kl/7xGuuPE73UTptyGGGuz2fIzI3w5JbTTxMYAKK1fFp?=
 =?us-ascii?Q?1JlS3R4yY1OzmfjKqHgf7vkbhy6BVmPUhp1oi/edsDTlqk6v/vN6Xo3ilmVu?=
 =?us-ascii?Q?AlPaH61Yv6MWAAK5BlHy2vuQVrgGKj+UUysWZuLFbyXCPT6fhDNbRp+ZtoQa?=
 =?us-ascii?Q?CZonbHowIARLYaTp4ApvjuPnERT94gx+r/epyvugIxLR//Aci+DC2vjTZPlA?=
 =?us-ascii?Q?rPkoy6eWyjmH8W6XFyit7pxeQyNyIi9wXZp1S3n2na7TB+Ny/YJkQZx65Dn3?=
 =?us-ascii?Q?izMoQkw1Y2MuqtqpKEd0W/cTWJdx8scxhZD7Z1z/EbwM8yGz/4PMmgVZPHtm?=
 =?us-ascii?Q?eSVUNsMgdl+/6gMDcd6TaJvmZskkaBUVLALe3Uzwhp0HP78b+AQwIeTVt0NB?=
 =?us-ascii?Q?KA3MK8cWqJFJz6nf3S5+PH21VAJKqs+2NNUT4ZZRyu1bwsvCw58eS2aHh3Si?=
 =?us-ascii?Q?x7iRWKnfhfFqTJEqotvVo5ABIfq6iZeIpIzke55lsj6NTsK39IpFFFwYDQbv?=
 =?us-ascii?Q?mpNl9FAsIOqMCrlDqnW3Mj2QTmW6eO1MgbyghcwcVBCg4taOBMB9Z3/M7a5q?=
 =?us-ascii?Q?gdWpcKRD//2r4qXJkPKILiL9oIygEmZx6amYAm+JwBWTZZwG949eTxV3gJgs?=
 =?us-ascii?Q?csN8dwfs8mk4XDlo1pXE7NiWC3E+gVTeeUDS4DxAIIvp73tFYggdmQMw8XmJ?=
 =?us-ascii?Q?yVs/Dlfk4a+/25VwSf7+HgGpiCI9O0Owi8E4srbXCpLI4UX3uwGA02QikvWs?=
 =?us-ascii?Q?juW9NWu2M35CzQ411MNGn9mr90yVCrMu8S3qxAOUDUeTv/0tkdpWI/tT8281?=
 =?us-ascii?Q?W/ueJ5dnNr2xFRUeoK4ShLc85b5VTcIMFkI0ZhE35Hh8YfA9SxOMuu9aAxqs?=
 =?us-ascii?Q?e4fcDhkAQg=3D=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: efc77cbf-a958-4672-c03d-08da0171a8b8
X-MS-Exchange-CrossTenant-AuthSource: DM5PR0102MB3590.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Mar 2022 02:08:10.9020
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: C9pTC3c5a9htw3GX5R3KLNlIplGnlVIlcOxCxzgd3l6p+IPQdCOupP4H66OG7+bA8Jj1KAf4YpbeyaW8iCesQPIPOjQuBv4OSCl65UNBobV2KH5CMUyIj/E65oAGaivG
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR01MB4288
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
  git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm bleeding-edge (dd54258fbf6c)

  Requires commit 27e932a31496 ("ACPI: APEI: rename ghes_init() with an "acpi_" prefix")



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

From v5:
	* Brought back platform device/driver
	* Fixed remove() function

Ilkka Koskinen (2):
  ACPI: tables: Add AGDI to the list of known table signatures
  ACPI: AGDI: Add driver for Arm Generic Diagnostic Dump and Reset
    device

 drivers/acpi/arm64/Kconfig  |  10 ++++
 drivers/acpi/arm64/Makefile |   1 +
 drivers/acpi/arm64/agdi.c   | 116 ++++++++++++++++++++++++++++++++++++
 drivers/acpi/bus.c          |   2 +
 drivers/acpi/tables.c       |   2 +-
 include/linux/acpi_agdi.h   |  13 ++++
 6 files changed, 143 insertions(+), 1 deletion(-)
 create mode 100644 drivers/acpi/arm64/agdi.c
 create mode 100644 include/linux/acpi_agdi.h

-- 
2.17.1

