Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E60F5A8E32
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 08:17:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233315AbiIAGRR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 02:17:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233297AbiIAGRP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 02:17:15 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2062.outbound.protection.outlook.com [40.107.94.62])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F0D51195D7;
        Wed, 31 Aug 2022 23:17:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c17D90JDcwqL51dt+3J3+tTP2Ubx5ZYFbCAWkBH4tp+iiYne5mDApMea87Ozo0K+ULDMvTKitiv5JKUs2UYBKzclaxwZgHwIF8h2NjrAbGZhyAXf/fbpJh+sbi9XYIhj7yueE56ANmk5U/GleZnocqg4E/HIQ36Gm0qhVAQmdSJCcf2p5dParO0qF1+i65beDyswLOySiAkndjdaOJwr3RmGuYDzQovjogay66gQy9sVdK73D55hjQs/AqzH2fcYEtbvEm/ckU6bIwj7grKlVDejQZePRg+Z9pzFGczbKVpa8vNGZhFFeVEt8tuUgVQPbYzed5CxMUljDN06gJWNUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hCg3euqvwt8dOMemnKH/SMmIEr5uy1SwglZpQxzEqQQ=;
 b=DNa+FDG7n46Aj3gMZghBiNnbPosb6eH4eC2pmO9JSOQ/Jwt0ipSSPLM6GkN0At0JlI3cVRigml8UladbNo6bGL5fYrQlaoe1VMgwei409rmvsMDwwtUzIngffcg4qnF3kMhZAbOTq4Op4naAWVcE5GAOVoWJukZx+HY34mM6F5/84m2OAdlyCtC/3PFY9EskdgcxDCX0b50Kk5ivV1QoBlgeVUglbv7ENXF+uzlmnXkyFG4CyF1EEQQ9c+8vEbl5euz5rCKJ0KfLsb090SKyhJZrBVxIzFiNLwL2Ov2C4ziShPGnLI3xyC0k3VVbwNgkzhjjUcUNrRQeR+W+kwpi9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=huawei.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hCg3euqvwt8dOMemnKH/SMmIEr5uy1SwglZpQxzEqQQ=;
 b=D29OtgMeX/1D8F4EOCFpY37qU340Z48ZjSZWvfJeDwjBjI8zzulpoLEnon5r22BFg6Pyg6u9GeKXE2pPewCgruCAVGevR0G5ovKIDGC9sqO20z5FIkBjvVxrETa33rzfTecbjYqBe1OJhLbc5Au9otvuoFk7Yc+09+fofaQha+o=
Received: from MW4P220CA0003.NAMP220.PROD.OUTLOOK.COM (2603:10b6:303:115::8)
 by SN7PR12MB6789.namprd12.prod.outlook.com (2603:10b6:806:26b::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.10; Thu, 1 Sep
 2022 06:17:12 +0000
Received: from CO1NAM11FT041.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:115:cafe::cf) by MW4P220CA0003.outlook.office365.com
 (2603:10b6:303:115::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.15 via Frontend
 Transport; Thu, 1 Sep 2022 06:17:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT041.mail.protection.outlook.com (10.13.174.217) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5588.10 via Frontend Transport; Thu, 1 Sep 2022 06:17:11 +0000
Received: from rric.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Thu, 1 Sep
 2022 01:17:07 -0500
Date:   Thu, 1 Sep 2022 08:16:52 +0200
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
Subject: Re: [PATCH 07/15] cxl/acpi: Check RCH's PCIe Host Bridge ACPI ID
Message-ID: <YxBOVH+irgYSbEIz@rric.localdomain>
References: <20220831081603.3415-1-rrichter@amd.com>
 <20220831081603.3415-8-rrichter@amd.com>
 <20220831112028.00002566@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20220831112028.00002566@huawei.com>
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 95bdca73-3cd8-4b5c-2149-08da8be19b23
X-MS-TrafficTypeDiagnostic: SN7PR12MB6789:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7ckIHSFUFHrzEu/YO+Bpz2LSlHupp6fIWXqXMbykZMyAfY1mEkzKqJ4x0NCWU/fwpscDPcDTcIX0P/qdcVKLqitfI6bkqtI7jPhOTGDNyohoioonIatudSSUFgLWg0DYO/33naV3RDc/jfpxodl4ycJhK1edWG/FW8Z18txzuClTbxnhDdR8F/aQCZ4yjhIYAconMk5z5qhVHf01V/Zho/W9jvIxJ8rQk/KMYifRydUT620vYWYUo5SI+iGWMe8bRHI5B4P7H81OlCNVopK0hA8VMI06ZCXcqUPREMwd1dogVkxZCO0nJ69DDgCd7ocfCAxVLulZGSHLsbC//Earw799RCSpGUYzNXwKpjycG2PSK/CDjIoC7Uvr/U4YgAYz4fD3gejebsdZxBdwr7C7sUg6+VzzCXhimkpEPtOp8vNwITzAu1gPsA7hg552/hIccMF+6lvYgfDNYbUxyrJOoL7uwRWxyzzt8yH/8U8D/PmcTz4P2A7oYoUMBZTWeDXJTpoT64Tc4FNu8dIysaEhWjzBsL3OJ1FncUNrxlc+Xbfj0FORJar1t7pabFUOJZCuRxHJKPI2RCae0bg5kGH+K8eYjRN1KusG2WCwiMV8WwjlptNOx4jyW27GZBEiM78+eU6sAjfLD0FHaE6p7G4742veWIPMokXQe3z0NkX8oed0Uyhi0+ZnV5cabpDX95S/MYFIoNsBNvjUwfeuEeBEGa4E+hiDmBM02wHXCvb5ga26+IVX8Zx01bCpG8NyOS6t+SRe5nmaq+EHeURVzr6b+LvFFEAzNJAHuByuO2xtH4iLLO5gkPe2P+YY0iMqIImj/8M64PbqqviyaKeFIt6VUg==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(4636009)(39860400002)(136003)(376002)(346002)(396003)(36840700001)(40470700004)(46966006)(186003)(336012)(16526019)(70206006)(70586007)(6666004)(478600001)(8676002)(426003)(8936002)(4326008)(47076005)(83380400001)(40460700003)(41300700001)(7416002)(5660300002)(9686003)(82740400003)(356005)(26005)(81166007)(2906002)(54906003)(55016003)(36860700001)(7696005)(40480700001)(53546011)(82310400005)(316002)(6916009)(36900700001)(67856001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2022 06:17:11.1144
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 95bdca73-3cd8-4b5c-2149-08da8be19b23
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT041.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6789
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 31.08.22 11:20:28, Jonathan Cameron wrote:
> Robert Richter <rrichter@amd.com> wrote:

> > +static const struct acpi_device_id cxl_host_ids[] = {
> > +	{ "ACPI0016", 0 },
> > +	{ "PNP0A08", 0 },
> > +	{ },
> 
> Trivial but no comma after a null terminator.   Always good to make
> it harder for people to add things where they really shouldn't!

Can do this.

> pci_root.c avoids using an acpi_device_id table for similar matching.
> I think the point being to separate probe type use of this table
> from cases where we aren't using a normal device probe.
> So to remain consistent with that, I would just grab the hid
> and match it directly in this code.

Grabbing the hid only is actually a violation of the acpi spec as a
cid could be used interchangeable. It must also work then.

It is also not possible to use something like probe or a handler
matching the ids because the hosts must be enabled with the already
existing drivers and handlers. Suppose there are multiple handlers for
the same ids, the first handler wins and all other never get called.

To me it looks sane and simple to use acpi_match_device_ids() here.

-Robert

> 
> I don't feel that strongly about this if the ACPI maintainers are
> fine with reusing this infrastructure as you have it here.
