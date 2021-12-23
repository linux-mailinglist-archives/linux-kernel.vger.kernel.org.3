Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C4B4B47DEDC
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Dec 2021 07:04:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346512AbhLWGES (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Dec 2021 01:04:18 -0500
Received: from mx0a-0014ca01.pphosted.com ([208.84.65.235]:40514 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232083AbhLWGEP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Dec 2021 01:04:15 -0500
Received: from pps.filterd (m0042385.ppops.net [127.0.0.1])
        by mx0a-0014ca01.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 1BN3qOO8005437;
        Wed, 22 Dec 2021 22:03:45 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=proofpoint;
 bh=dTTcksViMbwaShkgKco3877HDCfQIX7vCVHneWC5b18=;
 b=jIhZ/HTlHRHWbCR0TJSOWp6HAD0W0Xo2Xsk6QddfKSM9Cmm06AUmR3ISBKxV0q4q7kLv
 sVnt6n3nhSxkjpe8O+l4gkWzg7rbhkRWm6j9R4gOtja6duCcj5xdN5Be6ajNB6ySQ4iC
 6u56G5NNmj1itOKtOzTqJA/PsuGt5Sxs3C+rXDGlm1IFfmETOWNVe7nZ6yu+4oHEL2kB
 Mqnu8L0FIKtOTcu1izeQvq9/PR4PZqyoaDqr/5ZEpmd8cedeT5wJjkpiUYpk/anvcmu3
 8UIBnWN2WBpSr8j165s15BttfLAk7sookp/hVe6gPVRhTiyOR5BE4mryNoBR2vWMVZnF KA== 
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2102.outbound.protection.outlook.com [104.47.55.102])
        by mx0a-0014ca01.pphosted.com (PPS) with ESMTPS id 3d3rwxvjm7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 22 Dec 2021 22:03:45 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bL+QA3dhVNCuPrYeNTXYPhTISQSLbWGx+/9WQszPyidUcEDZufl5lj3lefvhJMfUU8vufOSX1SBVCw95aX5NhZKZKqnMHpEv2jNf6dhbHC+Vyij48Rj9Prrm4zwHI/BPJ6wQ0iDyb+6/UDSTaRCucSXYBUAbahKWlfAA0HlVvoYpvnEgOK1hUht9wDaEzOa9B3uwcIRgd5w4gUkpZtTaOzLxKrf6zbfFPtD+dKzicfos5YGWdcQMIPVt+U3pazVWYKKHx8Zbp6WlN1N+ZsO64BwpD8PDYxB3gOvmXhpHAY4ThKQHI8uJA12wWkk+HmH+2YaMjP/bf2IqnIG32X/cpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dTTcksViMbwaShkgKco3877HDCfQIX7vCVHneWC5b18=;
 b=QqpeM1+6eGVzt/wFzTstSaFttag5ZGbTh1jXdkb+e7Z78DTpWakKFhHrRJlMxBYlVidOMkSoKW/6votp+h3Z7FkD3iGt+EaL8LmoQGGU9RwA53j03foujR/lhyr3L4fPBju4+Kgv4Jp9BRt+IaVMOWD8BvvGXcJFVU9O6sAmKluU6WtKOFoJyJFSyKTxT8ST4iIYrcWkkdgatedUojR5IDR7OuSDfMzVxDA0UrM32ghe4aeJDKQtlROyu4iT/fkNCnJYYQkSD7xrmnpsrUYFDRxV4eCJHZW1ZqnM4fV/ZAk980L/apnLcKT/LOAPoAcIUj0WAs6Ng0+efP9A47UaXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 158.140.1.148) smtp.rcpttodomain=kernel.org smtp.mailfrom=cadence.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=cadence.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dTTcksViMbwaShkgKco3877HDCfQIX7vCVHneWC5b18=;
 b=g4GdhRH7LoVhaR5gTTxbAsxPx0NKt653IVBVvJfaGGqaXRGoSrQV5cXuVlY1shFnRjgUjf8I22xL5G/d9UrfgW7GB55cm8zi7XqnUr/4qIjjcLSCIzoDLBTuz3fw9q4j06XF6atCUQxXCQysRwVvTnDB5CdLdpjMaNmAmaLCFYE=
Received: from BN7PR06CA0043.namprd06.prod.outlook.com (2603:10b6:408:34::20)
 by BYAPR07MB5365.namprd07.prod.outlook.com (2603:10b6:a03:6e::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4801.16; Thu, 23 Dec
 2021 06:03:41 +0000
Received: from BN8NAM12FT019.eop-nam12.prod.protection.outlook.com
 (2603:10b6:408:34:cafe::1e) by BN7PR06CA0043.outlook.office365.com
 (2603:10b6:408:34::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4801.20 via Frontend
 Transport; Thu, 23 Dec 2021 06:03:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 158.140.1.148)
 smtp.mailfrom=cadence.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=cadence.com;
Received-SPF: Pass (protection.outlook.com: domain of cadence.com designates
 158.140.1.148 as permitted sender) receiver=protection.outlook.com;
 client-ip=158.140.1.148; helo=sjmaillnx2.cadence.com;
Received: from sjmaillnx2.cadence.com (158.140.1.148) by
 BN8NAM12FT019.mail.protection.outlook.com (10.13.183.160) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4844.7 via Frontend Transport; Thu, 23 Dec 2021 06:03:40 +0000
Received: from maileu3.global.cadence.com (maileu3.cadence.com [10.160.88.99])
        by sjmaillnx2.cadence.com (8.14.4/8.14.4) with ESMTP id 1BN63d5F021297
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 22 Dec 2021 22:03:40 -0800
X-CrossPremisesHeadersFilteredBySendConnector: maileu3.global.cadence.com
Received: from maileu5.global.cadence.com (10.160.110.202) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Thu, 23 Dec 2021 07:03:27 +0100
Received: from maileu3.global.cadence.com (10.160.88.99) by
 maileu5.global.cadence.com (10.160.110.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2176.2; Thu, 23 Dec 2021 07:03:15 +0100
Received: from vleu-orange.cadence.com (10.160.88.83) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1497.2 via Frontend Transport; Thu, 23 Dec 2021 07:03:15 +0100
Received: from vleu-orange.cadence.com (localhost.localdomain [127.0.0.1])
        by vleu-orange.cadence.com (8.14.4/8.14.4) with ESMTP id 1BN61dNU009303;
        Thu, 23 Dec 2021 07:02:11 +0100
Received: (from sjakhade@localhost)
        by vleu-orange.cadence.com (8.14.4/8.14.4/Submit) id 1BN61bS4009292;
        Thu, 23 Dec 2021 07:01:37 +0100
From:   Swapnil Jakhade <sjakhade@cadence.com>
To:     <vkoul@kernel.org>, <kishon@ti.com>, <robh+dt@kernel.org>,
        <p.zabel@pengutronix.de>, <linux-phy@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>
CC:     <mparab@cadence.com>, <sjakhade@cadence.com>, <a-govindraju@ti.com>
Subject: [PATCH v4 00/15] PHY: Add support for multilink configurations in Cadence Sierra PHY driver
Date:   Thu, 23 Dec 2021 07:01:22 +0100
Message-ID: <20211223060137.9252-1-sjakhade@cadence.com>
X-Mailer: git-send-email 2.15.0
MIME-Version: 1.0
Content-Type: text/plain
X-OrganizationHeadersPreserved: maileu3.global.cadence.com
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4b9e3167-e68f-4a48-bf07-08d9c5d9f7ed
X-MS-TrafficTypeDiagnostic: BYAPR07MB5365:EE_
X-Microsoft-Antispam-PRVS: <BYAPR07MB5365DBBA3BDBEACDEAAA89B6C57E9@BYAPR07MB5365.namprd07.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1201;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QBc69pyU/lM4xnLcRGuTL9CWc6s9v7mpCAOT1/cEgSq/OlYC62eCUL6AgvZOdlHmbKe4o8TA0IDskuUX5g0vRmu7/Diog2k8pqH+aFi6jhhe4oojNaJhrAZkLrdRQkSyJSt1PmUG60xvNs9t4eGOXw93xhiIuhYVYkSqI4xuqPFELqve0CIuhH4hKy22dUm3JSaODSB3yoR7E24EJ8YxTLYanAu1advCdklgAHJrp+e7Os+FzNZ4RtuOC5Bg+ImCFUQ7k8+Q5Rv4oKdPQyAzYdtPRiM3J9+RK53bd9vucqDeXCQ+Dj0QciXTgQw57XVZa5GpAFTkJpz6R5kBfIZ4BSA6NkusYort1ck3t8o/CEz7MI/Sh4mmbLV8yDldoSn0lINCjN6MeeJqkD4jkv0gFqhJ9AGdNQUuJHMun5a/a3joaO0KIVVi6P15+4eBcmV666G9n/Ajv+oPz4vbLHAjCTJGEWURJ5mPizzkUrqsIlKj0W9IksUzqnXhggRFEpAZb8Spyqro5Ncgr3WOWPPqEgnjfb8ZMmx1DFjbDPspKIuExrIrEFhGipAOLoB2HwPWJRgeywFAtSmPUvHhr1tQrND3aVh1+lHbffw30r8eAOL/fuXnHgY6JBZZZUKNE4eiS51nm4wd0r7IWRh4DMI8E7CsDf+K0VXjhqNc/TUu1htL+DaUbtXh9dlIDOBsK6kgykW5M7Rj1PvNmeW4gyj4Le0OYAofk9a1k0XRAtdO0Rv39T/DmcYFTZY7hc8GgPomSfYp1VUotg2HUmgmIneX3e/Kw4jpREOzVtPLjohzSqo=
X-Forefront-Antispam-Report: CIP:158.140.1.148;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:sjmaillnx2.cadence.com;PTR:unknown.Cadence.COM;CAT:NONE;SFS:(4636009)(36092001)(40470700002)(36840700001)(46966006)(426003)(83380400001)(110136005)(54906003)(316002)(47076005)(6666004)(42186006)(4326008)(2906002)(36756003)(2616005)(356005)(336012)(36860700001)(7636003)(5660300002)(508600001)(8676002)(70206006)(8936002)(70586007)(82310400004)(86362001)(26005)(1076003)(40460700001)(186003);DIR:OUT;SFP:1101;
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Dec 2021 06:03:40.6514
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b9e3167-e68f-4a48-bf07-08d9c5d9f7ed
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[158.140.1.148];Helo=[sjmaillnx2.cadence.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM12FT019.eop-nam12.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR07MB5365
X-Proofpoint-ORIG-GUID: pXTTaEzj2upW-LaiRI5kQiHwrYO7GW0z
X-Proofpoint-GUID: pXTTaEzj2upW-LaiRI5kQiHwrYO7GW0z
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2021-12-23_01,2021-12-22_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0
 lowpriorityscore=0 mlxlogscore=999 spamscore=0 priorityscore=1501
 adultscore=0 bulkscore=0 mlxscore=0 phishscore=0 suspectscore=0
 clxscore=1011 impostorscore=0 malwarescore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2112230034
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Cadence Sierra PHY is a multiprotocol PHY supporting different multilink
PHY configurations. This patch series extends functionality of Sierra PHY
driver by adding features like support for multilink multiprotocol
configurations, derived reference clock etc.

The changes have been validated on TI J721E platform.

Version History:

v4:
   - In 12/15, used swap() to make code cleaner. Also, added comments
     to describe PHY multilink configuration logic.
   - Updated commit message for 13/15.

v3:
   - Rebased on latest PHY next
   - Added Reviewed-by and Acked-by tags

v2:
   - Added a new patch 3/15 to rename the SSC macros for dt-bindings
     to use generic names. These macros are not yet used in any DTS file.

Swapnil Jakhade (15):
  phy: cadence: Sierra: Use of_device_get_match_data() to get driver
    data
  phy: cadence: Sierra: Prepare driver to add support for multilink
    configurations
  dt-bindings: phy: cadence-torrent: Rename SSC macros to use generic
    names
  dt-bindings: phy: cadence-sierra: Add binding to specify SSC mode
  phy: cadence: Sierra: Add support to get SSC type from device tree
  phy: cadence: Sierra: Rename some regmap variables to be in sync with
    Sierra documentation
  phy: cadence: Sierra: Add PHY PCS common register configurations
  phy: cadence: Sierra: Check cmn_ready assertion during PHY power on
  phy: cadence: Sierra: Check PIPE mode PHY status to be ready for
    operation
  phy: cadence: Sierra: Update single link PCIe register configuration
  phy: cadence: Sierra: Fix to get correct parent for mux clocks
  phy: cadence: Sierra: Add support for PHY multilink configurations
  phy: cadence: Sierra: Add PCIe + QSGMII PHY multilink configuration
  dt-bindings: phy: cadence-sierra: Add clock ID for derived reference
    clock
  phy: cadence: Sierra: Add support for derived reference clock output

 .../bindings/phy/phy-cadence-sierra.yaml      |    9 +
 .../bindings/phy/phy-cadence-torrent.yaml     |    4 +-
 drivers/phy/cadence/phy-cadence-sierra.c      | 1312 +++++++++++++++--
 include/dt-bindings/phy/phy-cadence.h         |    9 +-
 4 files changed, 1239 insertions(+), 95 deletions(-)

-- 
2.26.1

