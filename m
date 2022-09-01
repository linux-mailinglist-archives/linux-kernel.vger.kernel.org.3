Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E7D25A908E
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 09:41:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233994AbiIAHk5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 03:40:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233414AbiIAHkv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 03:40:51 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2048.outbound.protection.outlook.com [40.107.92.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62A01DC0AB;
        Thu,  1 Sep 2022 00:40:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J2V4vOL9AEUW6rJ8mpMv8UeeMv6720ls7zGxFzi5R9XMYkTYkqJpz9u52UDMc10KafjCDiNxBZ2UVR3AD9wV2V1n3QBWsVl77uPJsgxZX26xr5L+eyQdUBURJUUkHghJgIR2O3LGQ2DkChAWFfoZ1vPsKOUevabb1uYVKAXDNYQ45XZygYCbxxNb+lMslzPNsaJCj3OkkKgg7TL420jX7++6V5PQfhoawOV/siEKypSp5/yWFVeDJVdD9/Yu7GOmTAnqmtOAf4MpZDnGfuHzJupZNCQgvpUPMv7Re4lBGN7yI+uRL1BOnDcUfqhVdsfwpPXaXvAL/EaRVmn5SiVlLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MVje5nvUhmvaBdyBzBXfE4aGR/vmmA/r/pBs+vaLdBY=;
 b=JTftLK9u12qFYGtAAljMLkdnoI/sledP7kkvKMwFsu25NTNJHRNifLH+D0L+FC3Gud9L+XHTxoealwzfHBsw3nKsm+lA0gIHI8bD97qgPoUiYxl1r13Z4vGEvolUqC7Z5YX0oXg/gxFzznSiN+GX4UCTcxktyEI2KzIKkDSSFZ5IQjj/CUgX37cGl5b1n2OiI3eRB+IqAqqq+1otoiENlw8SsYcYEqf97qTuBNJX53c5+gvZQ3zS2/J4/5eistwo6O9TffCPeRw5DaKEkK9k56vbnjEUESX1PEL4B2ijnvFDxPTNexxx6YhqoZ3CwiJcHGULnpxwWsTjueYu6jiS2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=huawei.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MVje5nvUhmvaBdyBzBXfE4aGR/vmmA/r/pBs+vaLdBY=;
 b=t73njmdUkBEPJTbdIGhg4eIeQk1BvRQrmKOr3uHYA+T+uhYlyBhe1DLlTa7YNzWYSCGUW+mVwyi5pVomNLCVSdwBNvPxmn2Bmbst6HTv1b23JIM5yF2IZMCPp6RKD3lIuXq5uTHfu17zsajhaMHnWz5nhg00rKY4N0kYUAwJ744=
Received: from DM6PR21CA0025.namprd21.prod.outlook.com (2603:10b6:5:174::35)
 by SA0PR12MB4512.namprd12.prod.outlook.com (2603:10b6:806:71::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.10; Thu, 1 Sep
 2022 07:40:48 +0000
Received: from DM6NAM11FT073.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:174:cafe::aa) by DM6PR21CA0025.outlook.office365.com
 (2603:10b6:5:174::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.6 via Frontend
 Transport; Thu, 1 Sep 2022 07:40:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT073.mail.protection.outlook.com (10.13.173.152) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5588.10 via Frontend Transport; Thu, 1 Sep 2022 07:40:48 +0000
Received: from rric.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Thu, 1 Sep
 2022 02:40:45 -0500
Date:   Thu, 1 Sep 2022 09:40:24 +0200
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
Subject: Re: [PATCH 12/15] cxl/acpi: Skip devm_cxl_port_enumerate_dports()
 when in RCD mode
Message-ID: <YxBh6OiSQlnM7Mbn@rric.localdomain>
References: <20220831081603.3415-1-rrichter@amd.com>
 <20220831081603.3415-13-rrichter@amd.com>
 <20220831125830.00005105@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20220831125830.00005105@huawei.com>
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6bd142da-029c-423d-9d68-08da8bed4982
X-MS-TrafficTypeDiagnostic: SA0PR12MB4512:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CL9jO898LuaLxXreZDHRr/P3d9PBSCSKwW7ZS5OG33JKWocP7qA1e5f1FTKmIfm+PMEGyWirpHXNtyLjJc2N5g/Jfo0DxDbsO9Dl10jvPZQTDa4v2Y/SuQoQXbJ91mHXDKlgPL+e/nkUY6YXFFDBuRK4yiaprisvMVeElb6ONRybw8/BzGSKnUr5NTPGFMwHzdy38VsInaDX4goISxvLh0MDuwiym8UjISbJ2up/rFGBp9ylmKrB1nfXwFJdu21RzzsgmUfujHff4tMGHuEW/oo3q3+8bDe3DQXL0PI7nX85eidoYM2xSbFDNNYD/mwbwbwes0wW8Oy5rS4u/3cVLlnCTuDV3lMhiB+i34YBG7cnqtOjj5UNETq4aVGV1xTlw5bEgFRW2vnP25LUsJ0+EHGG+0C7OxmXHu2PZbnUyssXiFsy6p6DKDPr/JiEUrblfiuqconc2bVUhT94PwAaJ0uR6p4sBxu6xPIWJ8k2gol6xppWvx2I4+CJoJOaRodyT9vkW4uTKAjNmgoUut20SvZx0vILWeG32M1Eefre8o51LYpJijgCZ9TbEpEGFuMR41O0oLsQKHCG3yr/RTIhZO8RRGEq37dX3iuQOgURaw9X4E/H4qP+D7jLNU/unObj8xCCO97UvOBiTrDvEdoI6RJ+n67qUQu2NskJQO+wfUsabiduL38w1fR1/+Od/eDAMSUS/cr8ImgzVUNadPHouj3F73OUHgJoTFSkNdLwSkdzjoUz0KXt+E1uuWLTdySaJfWwlTR093JBNKPwoS0XnI4tOtDQS5S/mgrCTOyZnI00kN8vH+fdEHMY6AWPK8qf
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(4636009)(136003)(396003)(39860400002)(376002)(346002)(46966006)(36840700001)(40470700004)(478600001)(41300700001)(40460700003)(53546011)(7696005)(9686003)(54906003)(6666004)(26005)(82310400005)(4744005)(55016003)(40480700001)(2906002)(6916009)(316002)(81166007)(82740400003)(356005)(47076005)(186003)(336012)(426003)(16526019)(4326008)(7416002)(8936002)(5660300002)(70206006)(70586007)(8676002)(36860700001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2022 07:40:48.2059
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6bd142da-029c-423d-9d68-08da8bed4982
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT073.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4512
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 31.08.22 12:58:30, Jonathan Cameron wrote:
> On Wed, 31 Aug 2022 10:16:00 +0200
> Robert Richter <rrichter@amd.com> wrote:

> > +/*
> > + * A parent of an RCH (CXL 1.1 host) is a plain platform device while
> > + * a 2.0 host links to the ACPI0017 root device.
> > + */
> > +static inline bool is_rch_uport(struct cxl_port *port)
> > +{
> > +	return is_cxl_port(&port->dev) && !port->dev.parent->fwnode;
> 
> I'm not keen on the presence of fwnode being used to distinguish anything.
> That's the sort of thing that gets 'fixed' by later patches.
> 
> Can we check something more specific?

We actually know the parent device is the root device, so we can check
this. Even easier.

Thanks,

-Robert
