Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1ED605A8D43
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 07:22:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232919AbiIAFWF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 01:22:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229746AbiIAFWC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 01:22:02 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2046.outbound.protection.outlook.com [40.107.223.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 163941090B8;
        Wed, 31 Aug 2022 22:22:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=foF5QJdG9GtjXhld/SJRGqEsrKxt1u34I7rc2Ea7vFcVUvQtaNW0Hhd7LOmZAAADVuSs6HffK8QWAakldMdJFZx2ZVFsRJeyEmgjMeqfEq6sk9yAYqA4M3QwAqJaLDIJVBcRHsFoipdoaN37BWo4xrKdH7asGjZCDD3L+8PPEpPcsog/KG/eZPLjq53iEK6FM6h0tby/R8yOsz3oPQCZnjBomTDJI/gK97/G2q1ACSoKHx4LVZQKZXHtZnJsvuJx0XHHoD4HvRAqQ1tn5ul/2yqMrjKLc5MuewF93lKQji5EfjHkywQ2VGONTiCtNKMy6b5naP9LVvXxgTowil04dg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9afL7A4o8QmlNpXj9AiVpdFF/g0WA0c7zIXWd3r7oD0=;
 b=lzM93NtcN9bTELpcb80Itwg8eUx4pDp3oyRcwQyv9pBXsFfzaLPCJl1Bw7ox8oDn78jEV2tofG0dtgo/SBMN61ha0jKEQnu/1QP16KcqQjl0EHd8rMOavKhz1I1EGxMJ/m2ByL4Vt9qOGPcx7iT7Nc/TCP27yWGJCmqzJpmLvvkFQ9dTq1+MUTPWi8zPwj5vPhvslZ23oYUXb+C2zjLe3XTrBripDDLROc4vncylPJS2zXtjYd9czXiL1WHBSG4lWL0hBHGY+O4LO6Bs3mvFyM7OmNXiMioTqFj7bD+ZVHok1I2jzTSTo5RpabkHZc9TOdTU+JEzeea7lulsi2V+qg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=huawei.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9afL7A4o8QmlNpXj9AiVpdFF/g0WA0c7zIXWd3r7oD0=;
 b=VmnGhLnL+0glVdbIhTnCtuWrEPRp+AneoJHWnv45nbG6Xn6S6zIv5WnarL99jBEe372Fcp1fcUevqnsGczDW1mHABb8eq4Y/sfqDR62GboELRY0caWwgIs7Ng5lL0YflxM4z5FQy98Bh4+Nspw4ZIhU25TEYe7EdwOquQEqjPwE=
Received: from DM6PR02CA0047.namprd02.prod.outlook.com (2603:10b6:5:177::24)
 by PH7PR12MB5855.namprd12.prod.outlook.com (2603:10b6:510:1d6::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.11; Thu, 1 Sep
 2022 05:21:57 +0000
Received: from DM6NAM11FT033.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:177:cafe::6d) by DM6PR02CA0047.outlook.office365.com
 (2603:10b6:5:177::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.11 via Frontend
 Transport; Thu, 1 Sep 2022 05:21:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT033.mail.protection.outlook.com (10.13.172.221) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5588.10 via Frontend Transport; Thu, 1 Sep 2022 05:21:56 +0000
Received: from rric.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Thu, 1 Sep
 2022 00:21:37 -0500
Date:   Thu, 1 Sep 2022 07:21:33 +0200
From:   Robert Richter <rrichter@amd.com>
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
CC:     Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>
Subject: Re: [PATCH 01/15] cxl/core: Remove duplicate declaration of
 devm_cxl_iomap_block()
Message-ID: <YxBAufysVG4WQgha@rric.localdomain>
References: <20220831081603.3415-1-rrichter@amd.com>
 <20220831081603.3415-2-rrichter@amd.com>
 <20220831095458.0000454a@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20220831095458.0000454a@huawei.com>
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8c01156a-63e0-45ea-3966-08da8bd9e343
X-MS-TrafficTypeDiagnostic: PH7PR12MB5855:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sTPtbACdsw4zP05/Tz9Jv8EacaqFnSt3Ri1XbzDjsc7/gHwBhQj3IRts8ZyFg/ZZ6S/Kzo3gd93r2tsh6mLOxaT3ZcUvw+nlCtMEymk8BSZp9hTlntxtWJgfJt6nXCknQOYEF9HU/+FceCX6IY0f/MlBKHcHlcWCd6FJURdtcuhq+imwIbJtNVUeQvtYYvyAi/2Pr0LGVVtI9O8byQTQuZROMXGnPrKfBpXrPqSWCnYD0t2PIf+z0WZma5a6bvQ2XeQuaHnW/YsyUtxU0+evqD7vEUw1akRjvZScVEFhtlcAGeZQflQQJCR+IfFucQwxMJwY9s2s2fyRkyct2eE1JwywgHb+SaqlJccCvfEpXeD4MwKLRABdSoyCvvz6gANBPe2Kx8hlp/cfbJzzeWtWw+uPB9wh3ymfCfhG80sfr69h2OvQwcKHyAQTq2Dw9JR9KuGlsmS0jbbP9Bygui7r7ZN6YQSQvYFZ/QCWWeycM+0i4qwqFA3G4N7I9Drf1lftM6dWfTqQpVKA5YjltXJ1pijTL3tAwkpzoUJ79M/ZFUG8BMFsudcyapxHidIpecAr7xzaJE4jY0wvvpqvwbS4EQiLctuprI/IUeut8Q7hWU6/nV6bpkEc4jIe05jyPrOQrDEAuryDPt4LFSJBAzccZ6UfxOSgzGC77qdioOFXJo5HbFVGkKpwwopti7VMzZwpN4dHc5si7SgjE7TdogmBQ6iuYZVeuF66AnwsAxtLx/55SWy1/MZmMpYJZppwhA2gXPWiP/L+BY35+5kjf4jRdAMDMpmYY9Wzp4B4x4l6Er5qZCIT/XUYE/1fQRGSFc7f
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(4636009)(376002)(396003)(136003)(346002)(39860400002)(46966006)(36840700001)(40470700004)(83380400001)(9686003)(356005)(47076005)(426003)(16526019)(336012)(186003)(36860700001)(40460700003)(82740400003)(81166007)(8676002)(4326008)(70586007)(70206006)(40480700001)(55016003)(54906003)(6916009)(316002)(82310400005)(7416002)(4744005)(8936002)(5660300002)(2906002)(478600001)(7696005)(53546011)(41300700001)(6666004)(26005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2022 05:21:56.2250
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c01156a-63e0-45ea-3966-08da8bd9e343
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT033.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5855
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks Jonathan for reviewing this series.

On 31.08.22 09:54:58, Jonathan Cameron wrote:
> On Wed, 31 Aug 2022 10:15:49 +0200
> Robert Richter <rrichter@amd.com> wrote:
> 
> > The function devm_cxl_iomap_block() is only used in the core
> > code. There are two declarations in header files of it, in
> > drivers/cxl/core/core.h and drivers/cxl/cxl.h. Remove its unused
> > declaration in drivers/cxl/cxl.h.
> > 
> > Signed-off-by: Robert Richter <rrichter@amd.com>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

There is this 0day test bot warning and I will need to either extend
this patch or add another one to fix regs.c.

-Robert

> 
> The wonders of code evolution leaving signs behind ;)
> 
> > ---
> >  drivers/cxl/cxl.h | 2 --
> >  1 file changed, 2 deletions(-)
