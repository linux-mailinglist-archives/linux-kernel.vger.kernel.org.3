Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C34C35AE6A0
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 13:32:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232413AbiIFLc3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 07:32:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231531AbiIFLc0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 07:32:26 -0400
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2065.outbound.protection.outlook.com [40.107.95.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B70B44BA60;
        Tue,  6 Sep 2022 04:32:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CfEFxUOU0LRB5tFJmqxmjKKiwHmu4PQH/i1alRCTuchJ2apY1fvJJ8cgsxOP+YTXZu9HvJ7s8o05uOXThDR0e34euyHwWRUY7q1S7Nv9f0W2HZx3obEgdpLw6ki/9lp8jn8BuhxhrqfilKZsp7UfXbXylG2Cox3GNj114ZyZVzcnOyk+kOHRDeL03RkytQjQTIOf1FpSWRpHD4GqtRuOEbPrKa5kggxF8SYgUOIRHV+yiERi26FKjNsy1Zl9xkQugox7CIbr/Vf/1apgKM7CDtT1sPuCcO4dSZ3IPJgK+x2CFXQ2L0gcNxedHR9mHtUXNDhpAdtp1JoyR11Szupwvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=79IzyMWMg5mJoZavDToNuWZcDULGWH1Fr3PXMnz8N/8=;
 b=XIQBZqh2me/o57XHc7nE5gwRWf8PF2tbljA2VPwhsmfDo2jpGd8zgxp2cb6CbysSmAHfvs84+r1Lgy6beaIJeQaICZoKCARlqTtsvnBWxKgrvOfrjtEkfBVP6j06hXcMvaWSNlj61m5YrjR9yqqukOBTqkXCZdgDaFI/GaUiCOzJO4ZSB3loC10gPr6iqOssOZXncwIGBHTREh1HCdvLKGD3r00kraYuMtxwNLa1FafbgeVxls56aYjoOIEnw16Rv9YTUP2hoY+a9hIzSfflRv0UZW1A4pl2wpnHd9M0jCleE0ihACEA9CuZdfpy22Xb7BRTHxqjsS6KH9froSMhuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=huawei.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=79IzyMWMg5mJoZavDToNuWZcDULGWH1Fr3PXMnz8N/8=;
 b=PI5fpjv3fsxULkOrpgbDNpQLQi5ipJnu04ZqQxfDCxnehLIE2RI+B9/Xrksuq7iwcYE8UPkCuPHV/K96AT3pAb13yKmHhD2geiA8bgGq4uf4+hpL6hqaMEoe0+9UlLvXX29h87qkfKGp/G8bZ6PWegDeVcvuqlvRyBUoWL+UMXc=
Received: from MW4PR03CA0173.namprd03.prod.outlook.com (2603:10b6:303:8d::28)
 by DM4PR12MB5038.namprd12.prod.outlook.com (2603:10b6:5:389::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.10; Tue, 6 Sep
 2022 11:32:22 +0000
Received: from CO1NAM11FT100.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:8d:cafe::e4) by MW4PR03CA0173.outlook.office365.com
 (2603:10b6:303:8d::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.12 via Frontend
 Transport; Tue, 6 Sep 2022 11:32:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT100.mail.protection.outlook.com (10.13.175.133) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5588.10 via Frontend Transport; Tue, 6 Sep 2022 11:32:21 +0000
Received: from rric.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Tue, 6 Sep
 2022 06:32:18 -0500
Date:   Tue, 6 Sep 2022 13:32:16 +0200
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
        Len Brown <lenb@kernel.org>,
        Terry Bowman <terry.bowman@amd.com>
Subject: Re: [PATCH 11/15] cxl/acpi: Extract the host's component register
 base address from RCRB
Message-ID: <YxcvwBTH0gF1SBVE@rric.localdomain>
References: <20220831081603.3415-1-rrichter@amd.com>
 <20220831081603.3415-12-rrichter@amd.com>
 <20220831125656.00007beb@huawei.com>
 <YxBhZdYz606i+pAN@rric.localdomain>
 <20220901120003.000024ce@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20220901120003.000024ce@huawei.com>
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 388e65e1-f462-4cde-530f-08da8ffb76c7
X-MS-TrafficTypeDiagnostic: DM4PR12MB5038:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: B7mH8L31OIkvbMQIhDo49VhAqKvkZVrair/6Z8T5NWmUJJCVsCpoIkVeZATRTdKI2SUhZ0AMPzEgi2gNiEgBXjvlN12CfPeCNY+vzqSc7aftSoRqspCOMYXvAvcS94HdYl9SG14gQXwbiUA7NKXCPAkhhMka9CSLY/WCy37rxARoUG+cBjrPLSsF5yR5vJPFeXp5cOPKo3WXW/fjTSNCw3WboATEUCu/22G4KO69cEhrlhOfWRjOjKQeKsqArHGB2Kza1DlMKqRfcW9IbmGbjHagR5Dqn8vpXKciixGT5lqddfsyRFnzQoGaCJm++7lP6UUFn6vF85Ul3hJHN6tYVnvEHAuw0sb+pfbJ9N8V8OfWooZv3qvnqx5o/gfaAUcCepGrCSoA8y+D2dr8USOikavZjOklfUaU61cEGWG+qAV42L3RBHXzwlkaNpcfawa2S74CnR/YHykGtrvVo8rYDbk0xnimQ3fdtC0RZ2+Z934RrYzVHFPjawAnwFJMR+SEqjivQFFoIIi0bbyiofG0CoI0NMJgmcGZ+rHY2QNSBJOw0p+C+SWacIqokTYzaThetrYVAkZCzpqoqhVvqqONugR5fWbIql92DeZ5HkLv01sz/XlrJmWuF27DfKGuQNcwL5DhblOJ7BT7vwPh1PzKmcFZmSgz7ExqHlx5slZqa6qsdY2NgYFo2nGWzjPvs16GxClgxTk/K68VLxTX7NnLsoxA8olfFN+1SnDC6XBMyfpH49Jpr8/0vvjqRuj/zBGW+IfyTODMZIKV2zTX4oZ5sgUeMpdwaqN372PwKPL61Gnxc4JArGU5GMafkz9OcruD
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(4636009)(39860400002)(346002)(136003)(376002)(396003)(36840700001)(40470700004)(46966006)(356005)(70206006)(36860700001)(8676002)(70586007)(4326008)(82740400003)(81166007)(47076005)(426003)(40480700001)(53546011)(26005)(7696005)(41300700001)(83380400001)(9686003)(316002)(82310400005)(2906002)(6916009)(54906003)(40460700003)(478600001)(186003)(16526019)(55016003)(336012)(8936002)(7416002)(5660300002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Sep 2022 11:32:21.6809
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 388e65e1-f462-4cde-530f-08da8ffb76c7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT100.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5038
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01.09.22 12:00:03, Jonathan Cameron wrote:
> On Thu, 1 Sep 2022 09:38:13 +0200
> Robert Richter <rrichter@amd.com> wrote:
> 
> > On 31.08.22 12:56:56, Jonathan Cameron wrote:
> > > On Wed, 31 Aug 2022 10:15:59 +0200
> > > Robert Richter <rrichter@amd.com> wrote:  
> > 
> > > A few comments inline.  Mostly requests for references for things
> > > I couldn't find in the specs.  
> > 
> > Most of it comes from the pci base spec (5 or 6).
> 
> Ok. Extra references appreciated - these specs are huge, so saving
> searching time always good!

I will add comments for all ther refs in this patch.

[...]

> > > > +	cxl_probe_component_regs(parent, base, &comp_map);
> > > > +	iounmap(base);
> > > > +
> > > > +	if (!comp_map.hdm_decoder.valid) {
> > > > +		dev_err(parent, "HDM decoder registers not found\n");
> > > > +		return -ENXIO;  
> > > 
> > > Hmm. HDM decoder capability is optional for RCDs - might be using the
> > > range registers.  Seems like we'd really want to handle that for
> > > RCDs.  Future work I guess.  
> > 
> > I used the same message as for the non-RCD code path. HDM decoding is
> > just a subset of features handled with component regs. We need to
> > generalize the code for this in the future.
> 
> Sure - much more likely to need that generalized code for an RCD.
> IIRC a CXL 2.0 device must implement HDM decoders, even though the
> other path can be used by software that doesn't understand CXL 2.0.
> Our RCD might be because the device is CXL 1.1...

Yes, this will be a follow on series.

Thanks,

-Robert
