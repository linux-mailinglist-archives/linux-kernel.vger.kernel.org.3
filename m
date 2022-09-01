Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9A995A8ECB
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 08:54:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232987AbiIAGyH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 02:54:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232456AbiIAGyF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 02:54:05 -0400
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2073.outbound.protection.outlook.com [40.107.101.73])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5455120F86;
        Wed, 31 Aug 2022 23:54:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TqArMzNnhj02uJG1uJ5nfFxz3U5cmsW0oKuwX6EQ0MCejl6Y0yhfCDw81VnP//ZWrEV1ih666KowpQtpxAqYqrytLPr+jYbOLxQx1y4NJNVX9uesKDUz1B4Chk3fb9CcXc4gXQdncuwYBCIHpf83WwkWFBTClcXeXDFjXYuj+6rmDquWGXNGrHY8N0EXiJXGGoUxcelq+9bZquq0lQFhX2p3Cu0wN2ybI3W3bJ7h0jJ0NrFa9FbECUgxHMEuCzcAnrnK+VinpC/UjPOrWIoOmbGuHnqaAPU1Yyp4cGMtyf0TqaCX06J1ZsTXVAwTcBd68Uod9powYotAAt0aiztdVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pxTLQM6mTYwdWs4Qk3wN3PQx5G2UziqwX9x+h0eGgVk=;
 b=YJ7F8Q8NQ0kDFfqTtIgjjvPS+cD/l12OsD+ZXdJiUMUc557ge5MN8BFlu270NVePHEfLRALTlAiWbeAjatowhGncvJI2xpTiRJ/X+OesMvUXeSd6uirwtIGt+g3tVJogTxOOOYVo3wygnAz/uJdyve/gt/iy/eNxlZ5RDIkrNmoLA/10T3M5EuGvjAYrCjylSUQs1GQQlvGJaZDKFFj5qvDcnYnWM9S97mDnq8mz3HN/i6L8ft5irekCyrje/ZOt8fi/LyIaT+kkJ/9+Yr3HFLAx8pSMzKdu4xiusiATb8M8mVViJhiQL5bnUyCpRB+5JnmMPDIpjr65Z5UiMP1u/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=huawei.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pxTLQM6mTYwdWs4Qk3wN3PQx5G2UziqwX9x+h0eGgVk=;
 b=YmmNm3yO30t5wFnOjLvDVt4vg9QmNtaiqL9btViZRt5pNTghM3BC+HKQDqTtIqQHkwgX9iHxwOEjiOsvY3NN1o2BMImPM2ZBqkNMfv4sD/ag1c4UQ8oliV/L+tklGmK6ChLENonwvtwi62J6conTNWUGbXa7hoyyCt94Con5BGU=
Received: from BN9PR03CA0391.namprd03.prod.outlook.com (2603:10b6:408:111::6)
 by MW3PR12MB4491.namprd12.prod.outlook.com (2603:10b6:303:5c::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.16; Thu, 1 Sep
 2022 06:54:02 +0000
Received: from BN8NAM11FT080.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:111:cafe::c) by BN9PR03CA0391.outlook.office365.com
 (2603:10b6:408:111::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.10 via Frontend
 Transport; Thu, 1 Sep 2022 06:54:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT080.mail.protection.outlook.com (10.13.176.82) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5588.10 via Frontend Transport; Thu, 1 Sep 2022 06:54:00 +0000
Received: from rric.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Thu, 1 Sep
 2022 01:53:55 -0500
Date:   Thu, 1 Sep 2022 08:53:36 +0200
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
Subject: Re: [PATCH 09/15] cxl/acpi: Determine PCI host bridge's ACPI UID
Message-ID: <YxBW8Kz/bgoMsAee@rric.localdomain>
References: <20220831081603.3415-1-rrichter@amd.com>
 <20220831081603.3415-10-rrichter@amd.com>
 <20220831120027.000017b3@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20220831120027.000017b3@huawei.com>
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 667fd923-192b-48a8-1c5c-08da8be6c00d
X-MS-TrafficTypeDiagnostic: MW3PR12MB4491:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: m4stPIorWN1zfCxQn2QknpDmMRKs8rKYRtBmiVm+V7ZEpuWUfczMYGtSUCrRST460vOxYlTkQ3KrPkCDZJYteQfJ70SEu8d/f/wh+nplrk8KTIanAdxw9m7YifKSxK+awkoeazlwggwT9DHiwvdXyppVKIj2JxIHGJumqzBYRnN9kKzuZ/FgejPQJRk5styAaHyvBeA3ZTq11iiEIUYIf3ihe1sQ81M6NT9g1Hp02JtEtCvkpyRcj6i2xEWZjSZt6Aa19QRYkwwpnljhudKzYiDbO6xT/aclPQCV8h27UBNt4mMZBF4FAx+b1v4nZO/hvzHLSikeXwA1duXGvArW9Q0a82oQ8JUthmJE4mA2m2QlXJXM2Kd18xVq1++RQ7iBrCp2KyeQ0pqvdFinI3aUlqVVtPAWl0+ZYAw4wdFT0lZ3/MYPBSw6nBDBy4xvfUoofN0N/xi9SDWDEBEN6VvY9nHeaXp8BS+QghoQgxl3vQd8ItOx3yGPQpqEvMu+4d9tOlT+QtWruIOtupkpkFKqHtUBBzxQEfDIUYYA4E+gQX8f7x3/LlPeBVEQj/Qp12ILSwjF/7D0qyZ9D7vCiE2tCw7sl/LzlReVYGUDnDeRr3pn0dUqh+jRX/m2vVXhJEk6XCQBeBDSjndGbJGN+mzLEXZrDK73ovRFMV59AaiABQuuEh0ByLlPVuokdtg+MO1ibXNUymRzvEcS7F1eEhTxqCJyO8zajE73ao+poD+aHuWVziPR8+e1jjp7pZlisv5RLHd0g0pc8AoKwg/bZPw8p3W/YewSmKXzZB2yO94wNGztDdsvrf+uYN+BhKjMYvQ7
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(4636009)(396003)(346002)(136003)(376002)(39860400002)(36840700001)(40470700004)(46966006)(83380400001)(40460700003)(336012)(47076005)(16526019)(426003)(356005)(36860700001)(186003)(82740400003)(5660300002)(81166007)(70206006)(7416002)(70586007)(4326008)(55016003)(2906002)(82310400005)(8676002)(40480700001)(7696005)(41300700001)(53546011)(478600001)(6666004)(8936002)(6916009)(54906003)(9686003)(26005)(316002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2022 06:54:00.6545
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 667fd923-192b-48a8-1c5c-08da8be6c00d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT080.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4491
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 31.08.22 12:00:27, Jonathan Cameron wrote:
> On Wed, 31 Aug 2022 10:15:57 +0200
> Robert Richter <rrichter@amd.com> wrote:
> 
> > The UID is needed to read the RCH's CEDT entry with the RCRB base
> > address. Determine the host's UID from its ACPI fw node.
> > 
> > Signed-off-by: Robert Richter <rrichter@amd.com>
> > ---
> >  drivers/cxl/acpi.c | 12 ++++++++++++
> >  1 file changed, 12 insertions(+)
> > 
> > diff --git a/drivers/cxl/acpi.c b/drivers/cxl/acpi.c
> > index f9cdf23a91a8..b3146b7ae922 100644
> > --- a/drivers/cxl/acpi.c
> > +++ b/drivers/cxl/acpi.c
> > @@ -368,8 +368,20 @@ struct pci_host_bridge *cxl_find_next_rch(struct pci_host_bridge *host)
> >  static int __init cxl_restricted_host_probe(struct platform_device *pdev)
> >  {
> >  	struct pci_host_bridge *host = NULL;
> > +	struct acpi_device *adev;
> > +	unsigned long long uid = ~0;
> >  
> >  	while ((host = cxl_find_next_rch(host)) != NULL) {
> > +		adev = ACPI_COMPANION(&host->dev);
> > +		if (!adev || !adev->pnp.unique_id ||
> > +			(kstrtoull(adev->pnp.unique_id, 10, &uid) < 0))
> 
> There is an acpi_device_uid() accessor function that should probably be
> used here.

That accessor actually does not help really, there is no null pointer
check for adev. Using it actually adds more complexity since another
variable is introduced plus you need to look at the function's
implementation anyway.

The adev->pnp.unique_id access pattern is widely used in the kernel, I
don't expect changes in the data struct here.

> Also, should a fialure to convert to an integer (or one within
> limits) be something we paper over?  Feels like we should fail
> hard if that happens.

This is a real corner case and close to a broken firmware
implementation. I think current dbg messages are good to find where
the detection stops.

> Admittedly I can't immediately find any spec that states that
> the _UID should be either integer or under 32 bits...
> ACPI allows a string and CXL just says it's 4 bytes long.

IIRC the UID can be implemented as string or 8 bytes, there is no
limitation then. That's why the range check below.

-Robert

> 
> > +			continue;
> > +
> > +		dev_dbg(&adev->dev, "host uid: %llu\n", uid);
> > +
> > +		if (uid > U32_MAX)
> > +			continue;
> > +
> >  		dev_info(&host->dev, "host supports CXL\n");
> >  	}
> >  
> 
