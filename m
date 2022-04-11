Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD95A4FBDA5
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Apr 2022 15:45:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346665AbiDKNr7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Apr 2022 09:47:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346701AbiDKNrd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 09:47:33 -0400
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam08on2044.outbound.protection.outlook.com [40.107.100.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 664C712622
        for <linux-kernel@vger.kernel.org>; Mon, 11 Apr 2022 06:45:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g5DhebQ/A2lW4urKlcnELXmgSyA5AYhlBIX4jkO1atqsvj5P37alu47+1mhMwIVj55ivRmc8sejINXhiVCrKRFqRQRGX9RyUVUZFrF5zGydKcomLXsQJlarV3Bq3fT5VeSaBHTbJBzRzH6TPmpN8f3NjDm4SC22qy6nldkOTWBCSlJ18r45VoGLlnqn5j7NNx+iq59uyeS855AUT39m9GaoFzvKyvGtJI0qhTEjMB+4XT/CSAB+U5CkDQqTIcIxj1Ew7ckkZzxicrRvjUwIXV1kBmy98csM2eNmCu35ofLvefw3upKmUijV8d9X8N9X4PnhmgQ1OLwtS7u44or/ijQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AZ+w75EM2VuGoAfQ8+g0CCR00IWDrX/QhVFyHsZilMg=;
 b=GYn7a36lsNBIuAYufJaDuU5JrQa57/+r8jE5yzXKi7pJr+S1jVH6USSeoMF68Pskopm9687gkV8fZsLsZrS4saCSGx7TSlVKJzdQdoGKbNP5QNQMUwsLaWCapbopRmQR0xDRdeF0X/qTetoGLZe7+BaihK6VvQMoXHdExARhe1VadQXLjn55nC4r7bNRl+DctXg4zLU+AS5H2e5ExZeA9+wO0akS7tfbzkkV+gWFIe0DBygWgOtjMCwWOt4F+f3ty5uoijVx+z9Fy/Ivbaj8scbNw7swZqlt8JLIE8mW18BSscYO5X9nhk/k+z+ny/mgHEReZB0wHkdhB37aB13atw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AZ+w75EM2VuGoAfQ8+g0CCR00IWDrX/QhVFyHsZilMg=;
 b=b8buIoJ4+zfYRuJ9t3TxYG0X/yX5cP7mkNl/pRWj4B2pVIPmMaffGog3Qi2za/YpKT5bqS2vaa0StsHT2Gr0KFRhCNtoigOOKO+HjFvQ6D+8cazgzu99nxGF3NqV5HMvTX7TJ0pbisCCEnQ1miTUfRxpzghZXkDcpVWSLtnNhjY=
Received: from MW2PR16CA0001.namprd16.prod.outlook.com (2603:10b6:907::14) by
 DM6PR12MB4714.namprd12.prod.outlook.com (2603:10b6:5:30::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5144.29; Mon, 11 Apr 2022 13:45:16 +0000
Received: from CO1NAM11FT027.eop-nam11.prod.protection.outlook.com
 (2603:10b6:907:0:cafe::53) by MW2PR16CA0001.outlook.office365.com
 (2603:10b6:907::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5144.29 via Frontend
 Transport; Mon, 11 Apr 2022 13:45:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT027.mail.protection.outlook.com (10.13.174.224) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5144.20 via Frontend Transport; Mon, 11 Apr 2022 13:45:16 +0000
Received: from AUS-LX-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Mon, 11 Apr
 2022 08:45:14 -0500
From:   Mario Limonciello <mario.limonciello@amd.com>
To:     Mark Brown <broonie@kernel.org>, Takashi Iwai <tiwai@suse.com>,
        "Jaroslav Kysela" <perex@perex.cz>,
        "moderated list:SOUND - SOC LAYER / DYNAMIC AUDIO POWER MANAGEM..." 
        <alsa-devel@alsa-project.org>
CC:     Vijendar Mukunda <Vijendar.Mukunda@amd.com>,
        open list <linux-kernel@vger.kernel.org>,
        Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH 0/2] Allow detecting ACP6x DMIC via _DSD
Date:   Mon, 11 Apr 2022 08:45:30 -0500
Message-ID: <20220411134532.13538-1-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 70d527d8-348b-421b-8aed-08da1bc182eb
X-MS-TrafficTypeDiagnostic: DM6PR12MB4714:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB471416148F8A06DD21E4E0A2E2EA9@DM6PR12MB4714.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 96HVx+yYbREwDEhG36XFamTPuEuTV7Ns3/gbab6Eqtt1JdeRo5LoMKAgPv8/QeQSFocwyBTpn+YDLdFhUTQymI+eAgmGElHELhue0RWOFpkWJNyyfVaIzmDQBKasJlr4S3Ka3qXF0LGEQ82m+bn7j3L39mwi55lcAMGm4ONhu6P8ORVLWjGstkl6veQ4h1mMXpRBHdNfqYdyF2wLHmu6qriAyDYWp4ytBZ8GrjHtlbBCG2KW+wOvWxbbuSPSg4cDFF/v9E9K/19EAntBUofLign2sZhCNaD8SIwe0PY1WydAfUhFldTLN0Z8d8MjciNVYWdU+tBi1vHlsMJv5nrepdEDarqEo9Tb6cS3lbTBo/w5SarkrLcz06VlVprCcZ2yh8oJrJ9HXoUenmJHyfJS70IZjNGBU6yfnH41AxuGtRtMibIvUBIiduL0JEnGLgZTaSr7+N7S3clj5NcKZpwmZG8Q3hYwn+EYQ1hhhO195yo+Mfvb/pi9CMLYqniqkHdZLlvtSAxbBNi+S7x//Tje0txMs/+rbftk9gMAgTzUQ7Fexv+m4pguE8RRHudHEm1K2kPDmAeya7htzuibOoKZ3Kmp59OuUPBcj8+CZBbRsboHJLfssHIrccelq6b4tYsUAkd220r06SSXbpeXqpUbHyau9Hp3zXer+JWFwZJ1xsxLKad6J8d3ldMjtJjyWbGWhmZwBHBGbwT/0YiyFuDvV3wpgFgLvM/1sjULVXQecVw=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(36840700001)(40470700004)(46966006)(83380400001)(47076005)(4744005)(36756003)(16526019)(2616005)(1076003)(508600001)(426003)(186003)(26005)(356005)(2906002)(81166007)(86362001)(40460700003)(336012)(36860700001)(8936002)(316002)(70206006)(8676002)(4326008)(7696005)(82310400005)(6666004)(5660300002)(110136005)(70586007)(44832011)(54906003)(32563001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Apr 2022 13:45:16.3584
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 70d527d8-348b-421b-8aed-08da1bc182eb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT027.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4714
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It's not possible to probe for the presence of a DMIC, so the ACP6x
machine driver currently has a hardcoded list of all the systems known
to have a DMIC connected to the ACP.

Although this design works it means that the acp6x driver needs to always
grow with more systems and worse, if an OEM introduces a new system there
will be a mismatch in time that even if the driver (otherwise) works fine
it needs their system added to the list to work.

So this series introduces a _DSD that OEMs can populate into the BIOS to
indicate presence of a DMIC.

Mario Limonciello (2):
  ASoC: amd: Add driver data to acp6x machine driver
  ASoC: amd: Add support for enabling DMIC on acp6x via _DSD

 sound/soc/amd/yc/acp6x-mach.c | 42 +++++++++++++++++++++++++++++++----
 1 file changed, 38 insertions(+), 4 deletions(-)

-- 
2.34.1

