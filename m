Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 241435A9216
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 10:29:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234202AbiIAI3v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 04:29:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234207AbiIAI3p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 04:29:45 -0400
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2056.outbound.protection.outlook.com [40.107.95.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38477CFC;
        Thu,  1 Sep 2022 01:19:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P7z+E1ajdrtAJNTgnMiV5ARGi+ScggxhwV7aYkq/ZmsWGZC2mi+lCM3JMOxIp4xL/Yo/bZxRImPcAVLj8RxdqXFUZfK+VjCMKOO0efJc0bOgY1Tbzph2CT47ZPqpvq3JcGGX02v1WI4XX4NVGjlJAFRs0HjdYP/9jq8+z1mMBFQ8IqDzh8zieJfKMzWGmmTj5Rni+zkVBVsQM2RRQGJHPU7gVL/xrAaxByIxMyHqBOvLnyrZ3YIClT/U/lP2IOXKGmWMopHZjD72cIYO4CM9AtVcPqvGwmBlwm1zVOIhkaWvGAbm+u+8V1YmnvJ+qLODuiOwm8nsnvFjzGTzHLyEXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gTQ8VlRW1jEZ2kieo7ZqMtGr+ZtxqEjeHE4rPHqkSWY=;
 b=Xt0xygpWwjgid8FUWJJxxKWrBlZgNMGOeqiaLHhtAmeQkVqefXbJkvTEHNIaXf+uDe0eJYPE5aEyQd/bQPWQ4SFjQXwWOHLuqcZZIsnqys17639o0v7esf7jJMD0GobPaDjIFatSLGjBwiOg0XL8rj9gK0zBnf1Mx4Y15dcQ0BkB1InHmbozFf4EJGcOUyyQbqvYCSf8oeiN0AjL2rylmAyca7NwY72e70PWJBtEeIH1bnwC3kmV5fwmGHbbM+bKcu6+lNXzIoW7kZGP3+cOL3lGIZr+YSpmmhVOG05mZYSDLFIGPqr8yZeZOWZpS0+TOZyoaKJ/eOVys2lJcv0huQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=huawei.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gTQ8VlRW1jEZ2kieo7ZqMtGr+ZtxqEjeHE4rPHqkSWY=;
 b=O64F+6QcZ9go7jUJiCzgvLzvRfcJTZCiUI6yipxwh6cTkumk4LLQqFrz/RP/jJOpRpH1hzIvZ4lKk/5Cau1Ok582gYGExWnPUqnNMgEl1f0+mvty4MadCICs2kPdUGM8/1foOyVc9NKZOwf50tMLd7Fk91ttL87fVPZmKSgqgGU=
Received: from DS7PR03CA0088.namprd03.prod.outlook.com (2603:10b6:5:3bb::33)
 by SA1PR12MB6677.namprd12.prod.outlook.com (2603:10b6:806:250::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.11; Thu, 1 Sep
 2022 08:19:43 +0000
Received: from CY4PEPF0000B8E8.namprd05.prod.outlook.com
 (2603:10b6:5:3bb:cafe::32) by DS7PR03CA0088.outlook.office365.com
 (2603:10b6:5:3bb::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.10 via Frontend
 Transport; Thu, 1 Sep 2022 08:19:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000B8E8.mail.protection.outlook.com (10.167.241.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5588.7 via Frontend Transport; Thu, 1 Sep 2022 08:19:42 +0000
Received: from rric.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Thu, 1 Sep
 2022 03:19:40 -0500
Date:   Thu, 1 Sep 2022 10:19:13 +0200
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
Subject: Re: [PATCH 00/15] cxl: Add support for Restricted CXL hosts (RCD
 mode)
Message-ID: <YxBrAH1EZI8kuQdi@rric.localdomain>
References: <20220831081603.3415-1-rrichter@amd.com>
 <20220831132329.00007c46@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20220831132329.00007c46@huawei.com>
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2c2e753e-3eac-46df-4766-08da8bf2b908
X-MS-TrafficTypeDiagnostic: SA1PR12MB6677:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YjJBJcR9eIzfD0ozD7zLPsOzMKdy6FOptngjmOIC8RWkP7xgKCQ8qTrLrzZxIcXUrEplf1UB+lnwlREhOOs8/0+vmzr0glEVMryDp4mHUP5CvZi2ZPBbYfjm8Y0+m965uoh26kGDlx8AWG+DRkc5Fq0ccHWMMKvjqD9xswkxSQ61UKTd+vUqjNCdejLd3DQeMQ1aVDxizJsUGYotadXAJPHQnjeshm+2DVilivNBBju8NoPLoG4jo/6SzjlXpol6JzNNElCgb+Q4RuZs1hpxW+BeGKC+KRnXl8BB2c4PFPb2M9SeyB9DsTbIv0pDP26zDhKHzed6zBJikvtNHC6oT25yjIG9/tMXpErG23kE5dGl0/kW753+f9G1J1yx671lq50tZ9SzRhcV3YXEhRtBvNyHcn7w7prdUsIoccz0g6lRT8olT1fj+tWmyT+BetLHtDJBzUlYkQDk5Ms839/7+CUzl2FUcTndWICh7CUiGf1EEwI3XVWjWwoCbXV6yNShrAy7EPKEOstmU1vlTnSIP9EuuChb3bni3E//vCTSZMyV1mYBiAhRW5hTD5Dy+GsqI7Y5VbOGoGSiOY+Rrv+HKe7OYJZz6x5pHPePHOjDzLK4ULiL5Zm+RFDwgls5bCkWiYOh48oZoVQOEr0xp9FtTPf8/3Vx8VtkwBUbv+AWF/uIvattAE5XXQ5IqilnHoxummrNuyFv7U2ZQ6WZrx6f/Z7zqy3oMvZkBTlZijlecdbvr6jO7ljfPjrPOU+9LJmcD7TtdqL3HESl77rmJcHLV1e9Wuwul6PGSYUD8636hC1sH6vRBD9fa4vQGBmELq7IV3zMu4XfWEo+JpIld/NB2g==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(4636009)(136003)(396003)(346002)(376002)(39860400002)(40470700004)(36840700001)(46966006)(40460700003)(9686003)(7696005)(6666004)(2906002)(82310400005)(36860700001)(53546011)(478600001)(55016003)(26005)(5660300002)(966005)(41300700001)(7416002)(8936002)(356005)(81166007)(16526019)(47076005)(83380400001)(40480700001)(82740400003)(186003)(426003)(336012)(6916009)(54906003)(316002)(70586007)(70206006)(4326008)(8676002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2022 08:19:42.7458
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c2e753e-3eac-46df-4766-08da8bf2b908
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000B8E8.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6677
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Jonathan,

On 31.08.22 13:23:29, Jonathan Cameron wrote:
> On Wed, 31 Aug 2022 10:15:48 +0200
> Robert Richter <rrichter@amd.com> wrote:
> 
> > In Restricted CXL Device (RCD) mode (formerly referred to as CXL 1.1)
> > the PCIe enumeration hierarchy is different from CXL VH Enumeration
> > (formerly referred to as 2.0, for both modes see CXL spec 3.0: 9.11
> > and 9.12, [1]). This series adds support for RCD mode. It implements
> > the detection of Restricted CXL Hosts (RCHs) and its corresponding
> > Restricted CXL Devices (RCDs). It does the necessary enumeration of
> > ports and connects the endpoints. With all the plumbing an RCH/RCD
> > pair is registered at the Linux CXL bus and becomes visible in sysfs
> > in the same way as CXL VH hosts and devices do already. RCDs are
> > brought up as CXL endpoints and bound to subsequent drivers such as
> > cxl_mem.
> > 
> > For CXL VH the host driver (cxl_acpi) starts host bridge discovery
> > once the ACPI0017 CXL root device is detected and then searches for
> > ACPI0016 host bridges to enable CXL. In RCD mode an ACPI0017 device
> > might not necessarily exist and the host bridge can have a standard
> > PCIe host bridge PNP0A08 ID, there aren't any CXL port or switches in
> > the PCIe hierarchy visible. As such the RCD mode enumeration and host
> > discovery is very different from CXL VH. See patch #5 for
> > implementation details.
> > 
> > This implementation expects the host's downstream and upstream port
> > RCRBs base address being reported by firmware using the optional CEDT
> > CHBS entry of the host bridge (see CXL spec 3.0, 9.17.1.2).
> > 
> > RCD mode does not support hot-plug, so host discovery is at boot time
> > only.
> > 
> > Patches #1 to #4 are prerequisites of the series with fixes needed and
> > a rework of debug messages for port enumeration. Those are general
> > patches and could be applied earlier and independently from the rest
> > assuming there are no objections with them. Patches #5 to #15 contain
> > the actual implementation of RCD mode support.
> > 
> > [1] https://www.computeexpresslink.org/spec-landing
> 
> Hi Robert,
> 
> I'm curious on the aims of this work.  Given expectation for RCDs is often
> that the host firmware has set them up before the OS loads, what functionality
> do you want to gain by mapping these into the CXL 2.0+ focused infrastructure?
> 
> When I did some analysis a while back on CXL 1.1 I was pretty much assuming
> that there was no real reason to let the OS know about it because it
> couldn't do much of any use with the information.  There are some corners
> like RAS where it might be useful or perhaps to enable some of the CXL 3.0
> features that are allowed to be EP only and so could be relevant for
> an older host (e.g. CPMUs).

though CXL RCD works with a legacy kernel or without any CXL
functionality added, a CXL aware kernel can be useful also for RCD
mode. RAS is a topic here but also gathering device information such
as status or topology. Everything where access to the component
register block or mailbox interface is required.

Another plus, the CXL hierarchy becomes visible for RCD mode in sysfs
and the device hierarchy.

Reusing the existing infrastructure for this makes sense. Many
features overlap in both modes (e.g. RAS, mailbox again, or topology
information).

Thanks again for you review.

-Robert

> 
> With my QEMU hat on I wasn't planning to bother with anything pre 2.0
> but it might be worth considering to let us exercise this code...
> 
> Jonathan
