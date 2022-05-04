Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F1AB51A14A
	for <lists+linux-kernel@lfdr.de>; Wed,  4 May 2022 15:48:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350821AbiEDNwT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 May 2022 09:52:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349786AbiEDNwP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 09:52:15 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2065.outbound.protection.outlook.com [40.107.20.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7143F1DA66;
        Wed,  4 May 2022 06:48:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l3qWY4nUO0jSggKB/fh/Tf47wRI9F3swmCXQFSX78LiZKzVILY3ZEkxYJy3jmwCqP4JsY/CBKv58OdiATonkQBQOPJXUnDPSggwwHixa24/hK2s3ztoPXdO7hSjEtCq2neYSJLZXgDwiKt9Otcfk9Asuem/5c19CoGX7opG8bbpnWXIKlOqxa/uOh2G1m9oG5yxsnk9wmf7oG861pt0K1OuzPLRB9m06GYl+tBSbc87M2i6oW3/0WATFJUwBbVVTKfaSWrAVZ/ty2s095fnCVdOECCZzQIM3McmOwAbX1cH+sEbfFpN+RkOlWCpHZ9+S/cfWyTrtM6IS8T+iyZpcVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KnBX3F4GvTWjdLkb6iIUiKOgvKv7TvouLb20eCT20Y4=;
 b=iKjJQvalGq9l1FDW6bOD60ZOgN8gcSxXsCwxVbq5qfepaFVZNXvYvQig1UTBXD1UJ05EK3/8n3A1KlfBaXyidrEimo7mqsrnVwuYfAGz4gw64u7Cdas8Jd422dwbKhezQoLyXZoG2VeovIsvqBphZYdAeCUey6GDAW72yEq/I3VWLrd0ysCAHit36RVNJ0Pzfp0K7lCSLSFegtt67LeRCdaoY7C2Ej1cQaO4tKq3cKTmeXwcxRCiEflY25wkcGw+dN6O+wNzq7Jm5wpWKMsSlcitrzSOwJJCBlxszcwde5Q+yPhnQ2icKAqn03cxdtb11gC6M2KZdG5SZaJLTP7fdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 139.15.153.200) smtp.rcpttodomain=pengutronix.de smtp.mailfrom=in.bosch.com;
 dmarc=pass (p=reject sp=none pct=100) action=none header.from=in.bosch.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=in.bosch.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KnBX3F4GvTWjdLkb6iIUiKOgvKv7TvouLb20eCT20Y4=;
 b=ec0y3ELlQ5CiZGGQtOyWLnNQjdfcYYZGBqATzxXjjRL4baTq/obSG2HXZP9kIE0FjIAw7hJY1Dt5mxazvh23dlERc6DNgf2vRCJR3vpyn2ySuLOXV77fOWjsAsOoVdxcU1X9xzQjgCw803ErHzn3OEirDxUVRmuoxCpTGf4CdWg=
Received: from AS9PR06CA0310.eurprd06.prod.outlook.com (2603:10a6:20b:45b::20)
 by AM0PR10MB3619.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:15a::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.14; Wed, 4 May
 2022 13:48:36 +0000
Received: from VE1EUR03FT028.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:20b:45b:cafe::d6) by AS9PR06CA0310.outlook.office365.com
 (2603:10a6:20b:45b::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.25 via Frontend
 Transport; Wed, 4 May 2022 13:48:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 139.15.153.200)
 smtp.mailfrom=in.bosch.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=in.bosch.com;
Received-SPF: Pass (protection.outlook.com: domain of in.bosch.com designates
 139.15.153.200 as permitted sender) receiver=protection.outlook.com;
 client-ip=139.15.153.200; helo=eop.bosch-org.com;
Received: from eop.bosch-org.com (139.15.153.200) by
 VE1EUR03FT028.mail.protection.outlook.com (10.152.18.88) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5227.15 via Frontend Transport; Wed, 4 May 2022 13:48:36 +0000
Received: from SI-EXCAS2000.de.bosch.com (10.139.217.201) by eop.bosch-org.com
 (139.15.153.200) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2375.24; Wed, 4 May
 2022 15:48:35 +0200
Received: from SI-HUB2000.de.bosch.com (10.4.103.108) by
 SI-EXCAS2000.de.bosch.com (10.139.217.201) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.24; Wed, 4 May 2022 15:48:35 +0200
Received: from localhost.localdomain (10.167.1.123) by SI-HUB2000.de.bosch.com
 (10.4.103.108) with Microsoft SMTP Server id 15.1.2375.24; Wed, 4 May 2022
 15:48:31 +0200
From:   <Gireesh.Hiremath@in.bosch.com>
To:     <m.felsch@pengutronix.de>
CC:     <linux-omap@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-input@vger.kernel.org>,
        <bcousson@baylibre.com>, <tony@atomide.com>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <dmitry.torokhov@gmail.com>,
        <mkorpershoek@baylibre.com>, <davidgow@google.com>,
        <swboyd@chromium.org>, <fengping.yu@mediatek.com>,
        <y.oudjana@protonmail.com>, <rdunlap@infradead.org>,
        <colin.king@intel.com>, <Gireesh.Hiremath@in.bosch.com>,
        <sjoerd.simons@collabora.co.uk>, <VinayKumar.Shettar@in.bosch.com>,
        <Govindaraji.Sivanantham@in.bosch.com>,
        <anaclaudia.dias@de.bosch.com>
Subject: Re: [PATCH 2/4] Input: mt-matrix-keypad: Add Bosch mt matrix keypad driver
Date:   Wed, 4 May 2022 13:48:17 +0000
Message-ID: <20220504134817.1490-1-Gireesh.Hiremath@in.bosch.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20220504105254.1576-2-Gireesh.Hiremath@in.bosch.com>
References: <20220504105254.1576-2-Gireesh.Hiremath@in.bosch.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.167.1.123]
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fced71a7-17a4-4bc9-401d-08da2dd4c960
X-MS-TrafficTypeDiagnostic: AM0PR10MB3619:EE_
X-Microsoft-Antispam-PRVS: <AM0PR10MB36197F4DFB1F70D45BDF8838A6C39@AM0PR10MB3619.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: D6PZvQpr/pH6obkn1Uj2YIahbKSKLDlOEYpHFbh1GTnzHwCGQw62Y7nJwuICPLDkpO0zyluDUf7xVDvtP0CorYMSasH+UNkybKGXcpao1kFqev76v8KGwHi4POPJqHJneee8BnsHIAmlSIeN4UxcAoycEXrmQ+tirzO295IpoGuSAuICBZMNxUnYGneLssidqWtkg5q927HZCng8JRbFxyiyXgOfkxeQM/2nHaL3lSsJb2ClZJ39rVnl4HflTQ8Tt6nMqwwRtzG4tIMmSGK/LCjpiuh7ivpfFRMLsmwEHopQVt+JUHctqjhVoIlOZ+UTjWkKKFRGDZa2l5w0SLLBmdB6RHi32PQLH+nCe4dFRUuLQMLiEqw3pgUo+vHPRrQf/VKmWkm3Wk0NuG56Yk+l/Giko0KERTK14GlxJnzZNQRPl67FycHCHhgJIDQpy2NV6XffWAFjipPMMOhIyj6LVzOA/JQ9ofDs7doRkiZfxMvpbkqQKerTth2b118OWR1o1GoJCa0qNZPF2gauW5NbEb3Ds4gMmqw2UypACShI426uFufclm3eIwKEGM/QF1LP95xWx+KuoJuiSD39NVh9CQfRwB5e0G1Dy8tW2ph4JQPLXBLHcXdYEa907pkmm8m96LVWc6xrqLbziuH+4+7aO0kSUumcgR8rlIxMkMMTlsEphdg4ypOJHZbcnxgoc1mPnGMVWOr0W3bARFhqA7mIHA==
X-Forefront-Antispam-Report: CIP:139.15.153.200;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:eop.bosch-org.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(40470700004)(36840700001)(46966006)(54906003)(40460700003)(6666004)(26005)(508600001)(316002)(356005)(81166007)(16526019)(1076003)(8936002)(7416002)(2906002)(82960400001)(2876002)(86362001)(336012)(2616005)(186003)(82310400005)(47076005)(107886003)(8676002)(70206006)(70586007)(4326008)(5660300002)(36860700001)(6916009)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: in.bosch.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 May 2022 13:48:36.0253
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fced71a7-17a4-4bc9-401d-08da2dd4c960
X-MS-Exchange-CrossTenant-Id: 0ae51e19-07c8-4e4b-bb6d-648ee58410f4
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=0ae51e19-07c8-4e4b-bb6d-648ee58410f4;Ip=[139.15.153.200];Helo=[eop.bosch-org.com]
X-MS-Exchange-CrossTenant-AuthSource: VE1EUR03FT028.eop-EUR03.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR10MB3619
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Gireesh Hiremath <Gireesh.Hiremath@in.bosch.com>

The existing matric_keypad.c use different gpio line for row and colunm,
where in mt_matrix_kepad.c use same gpio line for row as well as column.
a key can be placed at each intersection of a unique row number 
not equal to a unique column and they are diagonally symmetric.
Advantage of this is with existed gpio line we can get more keys
  
example: in matrix_keypad.c for 5 gpio line possible matrix is 2X3 or 3X2
and maximum possible keys are 6 but 
in mt_matrix_kepad.c for same 5 gpio line possible matrix is 5X5 and maximum
possible buttons are 10, below table will discribe that
	------------------------------------------------------
	|Row\Col |GPIO 0 | GPIO 1 | GPIO 2 | GPIO 3 | GPIO 4 |
	------------------------------------------------------
	| GPIO 0 |  X    | KEY_9  | KEY_2  | KEY_3  | KEY_1  |
	------------------------------------------------------
	| GPIO 1 | KEY_9 |  X     | KEY_6  | KEY_5  |  KEY_0 |
	------------------------------------------------------
	| GPIO 2 | KEY_2 | KEY_6  |  X     | KEY_4  | KEY_7  |
	------------------------------------------------------
	| GPIO 3 | KEY_3 | KEY_5  | KEY_4  |  X     | KEY_8  |
	------------------------------------------------------
	| GPIO 4 | KEY_1 |  KEY_0 | KEY_7  | KEY_8  |  X     |
	------------------------------------------------------
	X - invalid key
	KEY_x - preferred key code
	
both matric_keypad.c and mt_matrix_kepad.c logically operate differently,
my openion is not to merge both.
