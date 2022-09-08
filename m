Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26F535B2143
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 16:52:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232750AbiIHOwP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Sep 2022 10:52:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231655AbiIHOwD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Sep 2022 10:52:03 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2076.outbound.protection.outlook.com [40.107.220.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C374B114A4A;
        Thu,  8 Sep 2022 07:51:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lyI2/J+lEqHyx6TWmXY1TF5qW/p0/jsZpQYycOVDenqJmpXO8J6ZAN1qUI+cqZfmKiwRmerdg88KHmFY1aZFnl2nl+khD109r174KoQgG/tK9Jav3DAoW2dkgY9eEnHIhSXZrT0uU93HiioEpwsSyPmRCRYajIDLuKBoxuxA2kLc5skmlDsJkSIXhoLMtQpVDKq9WMJ+3+4J4I0Wox8eMXyzSp/2hSdFKyLJuf1dTH9Bk0+6lJbR0OxteVKqvfh/Cd7G76V6bJwM15KAloI6a0ZTGkBgLj02wmD2QVmGlbUFcB1IGox/rYezbK70GLbsuqx368L9XilrsZ+FgPP+NQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LAtbmwFdK7WiI8B5dXLFINZI6BMONRE57xu6akg+2FA=;
 b=aBtrAgWhAuqnX8qt5Bq9WpxnNhQJpTOWPXdW7bZDK0Ji1ypb238YvJnKgkQD03JRQbNAzxH26WWXSyfSDrVNZ+PKXoYyB6XVyr/CPLFMG0YpTT29DJg7Y70AsBjTGAYzJ6aaO2NnUWv73dVd55ojsrbqM9g00vIdV7RqMABBAkIGGeLSF8yzWPI1IfhpenJHNvF6JMqHg4btkh3nN99PcoATAAjqdMPuymME1U5zEWyTPuKPucKfkdPpogl+r38K10LHD4wTpeAOI/PfoYNaRm73gNu7VqsxohIKGfDADDbpAFp4htYFAne6OZzjaZU0DkNYMZIBNu1mZIKZlasuOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LAtbmwFdK7WiI8B5dXLFINZI6BMONRE57xu6akg+2FA=;
 b=eLwnpCnIeYESLwLKP+dcEQjc36TPg43uyAXNNfaVewcYFjCHr9qtXDSRWAZjtApC/wNsedS6+ZKbqoZtUH7aqw9K61mQ3Axe4d3Hfer8jlH7hEiR1kwmMEr6qR+VkSCmV1c0lbVanYBoio4cFZgY7LSWUyPAdWQeg5NsY9xX5Bk=
Received: from MW4PR03CA0120.namprd03.prod.outlook.com (2603:10b6:303:b7::35)
 by MN2PR12MB4173.namprd12.prod.outlook.com (2603:10b6:208:1d8::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.18; Thu, 8 Sep
 2022 14:51:43 +0000
Received: from CO1NAM11FT109.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:b7:cafe::75) by MW4PR03CA0120.outlook.office365.com
 (2603:10b6:303:b7::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.12 via Frontend
 Transport; Thu, 8 Sep 2022 14:51:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT109.mail.protection.outlook.com (10.13.174.176) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5612.13 via Frontend Transport; Thu, 8 Sep 2022 14:51:42 +0000
Received: from rric.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Thu, 8 Sep
 2022 09:51:40 -0500
Date:   Thu, 8 Sep 2022 16:51:36 +0200
From:   Robert Richter <rrichter@amd.com>
To:     Dan Williams <dan.j.williams@intel.com>
CC:     Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>
Subject: Re: [PATCH 01/15] cxl/core: Remove duplicate declaration of
 devm_cxl_iomap_block()
Message-ID: <YxoBeJ4p/5oTSqrG@rric.localdomain>
References: <20220831081603.3415-1-rrichter@amd.com>
 <20220831081603.3415-2-rrichter@amd.com>
 <63198120f143a_58016294a0@dwillia2-xfh.jf.intel.com.notmuch>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <63198120f143a_58016294a0@dwillia2-xfh.jf.intel.com.notmuch>
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT109:EE_|MN2PR12MB4173:EE_
X-MS-Office365-Filtering-Correlation-Id: 42756016-6e76-4140-7aaf-08da91a9a515
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QNMxm/ivYir37W4plYPxaJ6xPldF/CT5708ARCd5T1Hit7iKW7JgfYa3kfazFtDqOKySCgF3GGGOsNuwXBJp+IaFoJBGCfnuAUUPWpFTz2fghL8VxubwvtfCgZbX7RuCDwdqdUWK5vACBBKHiIhDjF0vqoKtk3tFbXQC93NjL0CTQa3isl4Ym6mr/oyw2nxzWkI0N6nw5TAzMOm0GO2gweSX6lakqh77b5BMkBi1xfHb8b7r0JEPcJPqt2KSna9JxWaJxnHp9/kH/bCu+BLFF1eSL7qd9c4XlBOyw4EaES0gKukvuUVAbNo9hocCicvmmY8OeZMUePf6aISvX/e2N6yhSfRZ5uPLCEl2QBMYdnVfUvQOudAYHcF7/R4dUQ1oSNoNTsCSJ8OhyJ87T81oVH0nd7a1/vR3U0Rj46SlMu8mM0ofzdjc5Chcdno8JOJg4v9AReORRwBouILxnTV7lWgHzCUGKzt+8On/n7OdxJH8RVh+aVC3m66zW7BdiiRqoX0kUXe8KjYki74MKYE3GCqqQr/l2vw10xdvvzlkD7YIMJja33wuvxDcq5IkxLPkqnkLgfAAAkkn4pknFRcJhJtz6XyEHrk7olAkBhVxvqKc89ZXY6gNhOrZwespN+1Zt9O/yKITTLl7VsvN3UakAC8pzra4nG7KkhxbVYQZCk+/jR9kYiLmpquoKktMtzCa1bEawOOgWFHJ84XiL1uF+5dKU+c5O6lMJBInpsQZHEFI3RH573MCla4B1N0OV1u+aTvVNVRwYokGs/entPgnvN7qJ3bTI5IKkd+juGSWwBV2B7/oIEeuNo5zCVGkOL64
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(4636009)(39860400002)(346002)(376002)(136003)(396003)(36840700001)(40470700004)(46966006)(5660300002)(478600001)(426003)(336012)(16526019)(186003)(83380400001)(47076005)(4326008)(6666004)(7416002)(8676002)(53546011)(41300700001)(7696005)(9686003)(26005)(2906002)(82310400005)(70206006)(316002)(40460700003)(6916009)(36860700001)(54906003)(4744005)(70586007)(8936002)(356005)(82740400003)(40480700001)(55016003)(81166007)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2022 14:51:42.9620
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 42756016-6e76-4140-7aaf-08da91a9a515
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT109.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4173
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07.09.22 22:44:01, Dan Williams wrote:
> Robert Richter wrote:
> > The function devm_cxl_iomap_block() is only used in the core
> > code. There are two declarations in header files of it, in
> > drivers/cxl/core/core.h and drivers/cxl/cxl.h. Remove its unused
> > declaration in drivers/cxl/cxl.h.
> > 
> > Signed-off-by: Robert Richter <rrichter@amd.com>
> 
> Looks good,
> 
> Reviewed-by: Dan Williams <dan.j.williams@intel.com>

Note there was a 0day build error. So I will add the inclusion of
"core.h" to core/regs.c to this patch. I hope that is ok.

Thanks,

-Robert
