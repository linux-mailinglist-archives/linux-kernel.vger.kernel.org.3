Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 645F15A8DEA
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 08:01:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232373AbiIAGBr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 02:01:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232785AbiIAGBn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 02:01:43 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2074.outbound.protection.outlook.com [40.107.237.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE301E2C76;
        Wed, 31 Aug 2022 23:01:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L+ZQ/TtpEy+SPYqcY0/M9eJ7XAotxz5+Ouwo2i2TsO/GlEsRnuWVw+5ZDqGfFcK2hjKITXbfJRNxm40CtFrB6408IQawnlgQfgp2ShbbqKg0pwwkh3i9GhqWXGsdMw/v1yRTDqJfv92tLgiUuN+EYF/SFaQweO3FUHiqFK05LgJDwKPbtHVgzezqPRG+zHtAkeuvFEh329PJtgAcUYZh8qCkaBbd6XvgPqHz1mJ/DxRhPYs01SK0yQ3Wd/Pkmt9EgqMFd1MJtMbAw/tt6+ZSshZ1mLpVrBt1mw0591yxoucXax2erbC3MG3I3/2WUJ/q/Jtcq0KgTwfurRCxcFQmDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c9/yf7Urz4ohspQzWVW630EJWoBHog91yWFmH94Xcic=;
 b=CO7Qw/vSXAxVt9cL6McWA9ZMBMRtHCy3lm0wyzoy5NKQpYwxtV3ZFGWZe2jP+fKHiicXCsx1SA2JUk86KjwZBri+bEknao6f0Mqco0dLsfIgJU4SB/oOlWDwegF0cRgBPo9+5H3UAXc/UcmHu5CYMf7D+ABqe6Eov14g9qrCsD81Pntjx7Q/Ef0br1RNdFbMP9yZfRp921MgJZUBXFah8KXohWFqU+VEeKkAFYKL7TqH6mQP71fc52tjLq9g4foMloxQamCCucKwqZZHOt6klvYCCCRh19YFayKq1gp0uVU1wFWvofBPPancgXoeNv4OAf6hPLfvA3gY/0fiHBhxYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=huawei.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c9/yf7Urz4ohspQzWVW630EJWoBHog91yWFmH94Xcic=;
 b=OpaGG8D9gfl2vFj9Q4zybx+XEcacUVJeBsAdgcpVmUDTgeKatZwLLfdnABtJAos90Ym1r2fbwIZWquO0u6lJcsIIqh3awNVGumA913jEgkCoFOeGKWsx2PlGZz0S40KGuQjkvPB2GTTeA5vWBIiDJKesul0lIhLes9OmcWThI+o=
Received: from MW4PR04CA0156.namprd04.prod.outlook.com (2603:10b6:303:85::11)
 by IA1PR12MB6436.namprd12.prod.outlook.com (2603:10b6:208:3ac::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.10; Thu, 1 Sep
 2022 06:01:40 +0000
Received: from CO1NAM11FT054.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:85:cafe::38) by MW4PR04CA0156.outlook.office365.com
 (2603:10b6:303:85::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.12 via Frontend
 Transport; Thu, 1 Sep 2022 06:01:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT054.mail.protection.outlook.com (10.13.174.70) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5588.10 via Frontend Transport; Thu, 1 Sep 2022 06:01:39 +0000
Received: from rric.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Thu, 1 Sep
 2022 01:01:34 -0500
Date:   Thu, 1 Sep 2022 08:01:05 +0200
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
Subject: Re: [PATCH 05/15] cxl/acpi: Add probe function to detect restricted
 CXL hosts in RCD mode
Message-ID: <YxBKoT2zlUVgXIry@rric.localdomain>
References: <20220831081603.3415-1-rrichter@amd.com>
 <20220831081603.3415-6-rrichter@amd.com>
 <20220831110804.00003812@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20220831110804.00003812@huawei.com>
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b518b3fe-3538-4bb7-34e0-08da8bdf6fee
X-MS-TrafficTypeDiagnostic: IA1PR12MB6436:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BHgBedyk/UvczAYaiA14wuB/B4DyULbIyh3pAc5zgV1PcEdQbYfgfiSXfj05XoSSjmiyZSiFd91Fil6I+bu0t1Ed6586HDJaiUjWTIIqDw/JDtKZbVdC2NscfkHA+NP3bh2YfXAVYBfejIlBwMrY+zxbI+oTnMP/wq7AL69uKyzcoooP/RG/hLlviMGMZE8aww5YeSiR1JgsdeeLoSfNVYucv7rYoazuSf6Cv6p7O+MP6HBxOYHBOuZCv19JS6qTp9uYcN2lOYmS/ipa4jmtf4CieWS/fZrwVtCUq+Mt2FYxFX+BYj8xY6BSkPBWriQO2NkkdRES8o7OcjwaPl22VZJAoR07HEKYyK+KvW78yBHTqgVtysdoM4PN27p/s/MCWXm14YSvKW0njt0Ts5rOty2Ovks6qHesnkO3R2aica9Ea1rNEyPGGdAZSSD0RdqHoqMo/n7M8RrIrJXNT2wcRD0udcA2stV81PJ77Yjx7XqdJBeczWEkc5pZOVdDVwMbCw1ENwrEqDZ9+D5mPPFcvB0uNoe+Ad1WramMBVXylAviqvJ5wZ18wR4bZIGOXTF+fvI0AijlWV+IRoDXWKVgm4/Cm77oQ6IdfpOqin2iCROQRCIS2lQCJm4eY/rTleiKcLhhkZRZqnGj2f6zVYVgEY8iMc3MM7MAcwrqgQh/At/FOZMjnhu2k+kRhDPPNWgrK7/U9u8Z7EKN3zJg93RTz1jkMuukpHi2drQF6ZnuSuw13NqP0Sl3blVHJnzGsinyVQ+CCXygV1I5uCQRkCD2C6B6zsuCDvnhyMePoKrZw1sDCe2aPF5zyRgaYGYhBDX5
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(4636009)(396003)(136003)(376002)(346002)(39860400002)(40470700004)(46966006)(36840700001)(7416002)(6666004)(55016003)(2906002)(82740400003)(40480700001)(16526019)(336012)(54906003)(41300700001)(6916009)(47076005)(426003)(7696005)(316002)(83380400001)(40460700003)(81166007)(82310400005)(53546011)(356005)(4326008)(186003)(36860700001)(9686003)(8936002)(5660300002)(70206006)(26005)(478600001)(8676002)(70586007)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2022 06:01:39.6321
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b518b3fe-3538-4bb7-34e0-08da8bdf6fee
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT054.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6436
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 31.08.22 11:08:04, Jonathan Cameron wrote:
> On Wed, 31 Aug 2022 10:15:53 +0200

> Robert Richter <rrichter@amd.com> wrote:
> 
> > Restricted CXL device (RCD) mode (formerly CXL 1.1) uses a different
> > enumeration scheme other than CXL VH (formerly CXL 2.0). In RCD mode a
> > host/device (RCH-RCD) pair shows up as a legal PCIe hierarchy with an
> > ACPI host bridge ("PNP0A08" or "ACPI0016" HID) and RCiEP connected to
> > it with a description of the CXL device.
> > 
> > Add function cxl_restricted_host_probe() to probe RCD enumerated
> > devices. The function implements a loop that detects all CXL capable
> > ACPI PCI root bridges in the system (RCD mode only). The iterator
> > function cxl_find_next_rch() is introduced to walk through all of the
> > CXL hosts. The loop will then enable all CXL devices connected to the
> > host. For now, only implement an empty loop with an iterator that
> > returns all pci host bridges in the system.
> > 
> > The probe function is triggered by adding an own root device for RCHs.
> > This is different to CXL VH where an ACPI "ACPI0017" root device
> > exists. Its detection starts the CXL host detection. In RCD mode such
> > a device does not necessarily exists, so solve this by creating a
> > plain platform device that is not an ACPI device and is root only for
> > RCHs.
> 
> If I read this correctly that platform device is created whether or not
> there are any cxl devices in the system?
> 
> Can we create it only if we find some devices that will be placed
> under it later?

This would move the host detection from probe to init which I wanted
to avoid to better control driver init order dependencies.

I could add a put_device() at the end of a probe so that it will be
released in case no other references use it. This implies the refcount
is maintained for parent devices. Or this needs to be added to. So if
there are no children (hosts) attached to the root device after probe,
it will disappear.

> > @@ -531,7 +566,41 @@ static struct platform_driver cxl_acpi_driver = {
> >  	.id_table = cxl_test_ids,
> >  };
> >  
> > -module_platform_driver(cxl_acpi_driver);
> > +static void cxl_acpi_device_release(struct device *dev) { }
> 
> Why the empty release?  Perhaps introduce this only when it
> does something.

The core device driver requires this in device_release() to be setup.

There is nothing to do as the device is kept in a static struct.
That's why it's empty.

-Robert
