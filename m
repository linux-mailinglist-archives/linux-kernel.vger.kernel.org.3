Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7154A5A8F28
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 09:05:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233526AbiIAHEw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 03:04:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233528AbiIAHEX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 03:04:23 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2061a.outbound.protection.outlook.com [IPv6:2a01:111:f400:7eaa::61a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53868D51E6;
        Thu,  1 Sep 2022 00:04:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QM8bTFwI+WGZPcbI+ziOmJbpjdZ9umh8pJ0OrGBykBfTHhy50BoAVm4maKkLgVF2HSaQQQ2ku2ED5r1BKy8bP+9I4+eUEVzKX4E1PY9WEhqKOZo76k9kQ+6bnSvxbhqzekiB1gZ/BB9oisVEaYtaLv7WjvVLuuqwWjKB0P2cZcOHjeiBVKWp5vxlm+7X7r8gix/+rsOctsXeSpNC0zd3YzST+hxHFz3iPeRYn4oYajBfLXrEcFeF1BQVq6V6e6oZC4lluAtTc8dF0Gwt3OL06z4hOca8gWS5SEXllbacpGrY5pKjPmBuAyBrVdWXU+7enEA07IEKNVQTqGxF+UzTsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1vYw1ugTaJXPLlypEdRv3F04LgK+W7iMAG53ME6V7LU=;
 b=fGatTSno0FLyEyJOtVi56er68MsSEwOiH3DAzbMz8b8HXzMiQ03EhxtVkpHMcOGOvsX3wOKF5n1lsMI2m4VWwlOwv7p2CUsvUhOCHnvlrCTzimtmmqG8Yf40dHSpJtQXK45SeErzRtirpj6r79Yn5TLmgl9EZFjP3g1lp4DjdxZ+cwvh5sm+3Y3a4PVot5Wno6jyMTJBz6WtuJ+SqsJl8sRWzL2eCn7p05R5DDs8taK3FHBZhyA9INYZYgCer+WUmFtUo9c9T1hB/q1WBlRFB4WhzNeKlfd+hPzITViSVXqx4WFbZ1QtGiT6G4ezDO1FPASRRLbO8GFVE7qZfI/24g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=huawei.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1vYw1ugTaJXPLlypEdRv3F04LgK+W7iMAG53ME6V7LU=;
 b=c1Az60HXA6PuvyJOuTB1C4gPTifnEKn4hxcptgU+D3urf5q0VvEb1b8+tQ0ViZ4L9ZfA5qiNOiZO+VobSf65BmUm/2vJrKBioGJ0WUncklYSl+AFFHum48aMmLTrqLrVuOJB/FTzdjWlG753FUv9eACpnBK7bFQ4YS4SH3obCTY=
Received: from DS7PR06CA0024.namprd06.prod.outlook.com (2603:10b6:8:2a::8) by
 DM6PR12MB4895.namprd12.prod.outlook.com (2603:10b6:5:1bc::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5588.10; Thu, 1 Sep 2022 07:04:09 +0000
Received: from DM6NAM11FT009.eop-nam11.prod.protection.outlook.com
 (2603:10b6:8:2a:cafe::50) by DS7PR06CA0024.outlook.office365.com
 (2603:10b6:8:2a::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.10 via Frontend
 Transport; Thu, 1 Sep 2022 07:04:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT009.mail.protection.outlook.com (10.13.173.20) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5588.10 via Frontend Transport; Thu, 1 Sep 2022 07:04:09 +0000
Received: from rric.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Thu, 1 Sep
 2022 02:04:05 -0500
Date:   Thu, 1 Sep 2022 09:04:02 +0200
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
Subject: Re: [PATCH 10/15] cxl/acpi: Extract the RCH's RCRB base address from
 CEDT
Message-ID: <YxBZYkLzZXPCVZum@rric.localdomain>
References: <20220831081603.3415-1-rrichter@amd.com>
 <20220831081603.3415-11-rrichter@amd.com>
 <20220831120909.00004e49@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20220831120909.00004e49@huawei.com>
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: aebb136a-fb8f-4571-21d3-08da8be82ad6
X-MS-TrafficTypeDiagnostic: DM6PR12MB4895:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Ye8WzMWOWH4hwXAggpP91VwJhkcW27PUYFFTGIes7gMVkOcVlGpx0mFwLqpCQaLLqTljuWhWZkGoXTjxs1iJzKlKL3yiod57xoYkJJ2vBY7SLI4fbPIiMcTVG9tS47TzirHGRyJNii+FW0t3eC2/1GV3HNCmJuIuuCJMFX0mX3tpl937PCvChhwUKLTC9IWfbNtRMzX0+STESTb6uBGWGRMKjpAa6ZN+VmZ2xlOo01NdqGU6KlkCU/5ba0fTe9bTxLydnMe5WiCetSZ7o3KNz7LxpSuUf46J8HoduVNgepLIaPJT7yD7o14fJYOTXp2Oohl2ntECXW4rhqHTb67CXFMt+3U1DiX+OSxYHMRmBkG+/fGRMS0kWGBa2LJ6AJObA2ia6ae9OBPCw5Gf55FjkNOKKlnZSk8mQk98iCsISbcRkG2KZQou6LS2GMhC4hQwZ1T3CnHL1UCWsjh0ATRcE8ke+8RSkEuuO9dbTJJXm0UvlDWmhrss0Uoqfx4sv5iQlc8VB2olJ4ylLCgdAIUw2RC4YFOGLBTw1CtdmvF8i4HylGolkGMVVWO2yrqgpZQDqLKtRMI1BdBBssl1ThIRajanyLAQi1pSZH3fRyh18tHDruuvjh9zaclbSjE+bM4I0ypRdlr8uhCXBrhMcyyMrT0FvCGdBiqhYhKw214lJYkt7ZrDEwoojXxg1A7BSH/neaiRDnEC8s/37h/BcY3QhbrbBl7mKE7RViv65ltCGblGKnib/V93u94sWrRDODoluUkpJwauNdtNumVzPl8ct7V+oK6RItaWdF6yQrnX3aA2c3jeMNUZZsMIouxa2TDH
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(4636009)(136003)(39860400002)(376002)(396003)(346002)(36840700001)(40470700004)(46966006)(4326008)(8676002)(356005)(70206006)(70586007)(54906003)(40460700003)(6916009)(81166007)(316002)(7696005)(83380400001)(53546011)(41300700001)(6666004)(82310400005)(47076005)(9686003)(426003)(26005)(16526019)(336012)(186003)(82740400003)(40480700001)(55016003)(478600001)(36860700001)(7416002)(2906002)(8936002)(5660300002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2022 07:04:09.2759
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: aebb136a-fb8f-4571-21d3-08da8be82ad6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT009.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4895
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 31.08.22 12:09:09, Jonathan Cameron wrote:
> On Wed, 31 Aug 2022 10:15:58 +0200
> Robert Richter <rrichter@amd.com> wrote:

> >  static int __init cxl_restricted_host_probe(struct platform_device *pdev)
> >  {
> >  	struct pci_host_bridge *host = NULL;
> >  	struct acpi_device *adev;
> >  	unsigned long long uid = ~0;
> > +	resource_size_t rcrb;
> 
> Some of these could be made local to the while loop to reduce their scope.

I would need to move most of the vars into the loop then. So I rather
want to keep it as it is.

I also remember a compiler or code checker complaining about block
declaration, though it is in the c standard.

-Robert

> >  
> >  	while ((host = cxl_find_next_rch(host)) != NULL) {
> >  		adev = ACPI_COMPANION(&host->dev);
> > @@ -382,6 +419,12 @@ static int __init cxl_restricted_host_probe(struct platform_device *pdev)
> >  		if (uid > U32_MAX)
> >  			continue;
> >  
> > +		rcrb = cxl_get_rcrb(uid);
> > +		if (!rcrb)
> > +			continue;
> > +
> > +		dev_dbg(&host->dev, "RCRB found: 0x%08llx\n", (u64)rcrb);
> > +
> >  		dev_info(&host->dev, "host supports CXL\n");
> >  	}
> >  
> 
