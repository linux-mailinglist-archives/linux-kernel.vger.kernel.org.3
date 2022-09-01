Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97F885A913E
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 09:52:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233279AbiIAHww (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 03:52:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234066AbiIAHwb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 03:52:31 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2075.outbound.protection.outlook.com [40.107.94.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C078E12084;
        Thu,  1 Sep 2022 00:51:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ls8JNAwkhGT6yPZYMAwdgTLKrjNDEcvin2TshEB7kTAMTNMpnCw9nsWN0qbfEdLqpAmxHRljSCACrySkjiInd5LgmENPhppMN+1yXptnFlZ1LG8y7lng6LvZA9LyEoPvCqmTY/BykcPSQ3xEPFkP3u4K9cwUNSwYDxY8F9XOH3W3O/h3mABH99DN86O+xlZe687RsY8NCTYnJrl4nWn1jIPpsGvfyh+wuaEET2wGkssenYG9EVr056oM8wLE+qxJWUqVbuezpom8z6MhvHOWxvmq+G1nCBCmZRw920aUEvZao+XhlIbDmA2Dbc5k/EiM497P2xtbBVLFCboGx5rPKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KNtOvHxWLkXYBnkclPlVmERhlfU1ZZQLhu8CntbvjLY=;
 b=h+bJh2Ui1QxuQ1HljMwIdBc/MBu8pvdXXZhVhhwTlzWy512GmtFpeVAzHWJpfB2Tb4hHeD9TZe7Iys2tg5Qskwd3bU3s080r542YHcEy95ZRB9KvmU7Ai/qXKwE9yioA5itpMzcSl56WNknH6CL/0iYBASaf0VueaeI3o8onET+hq9DHeVjJjy+YsrqD0u2jHVxEh2b4aCGqx8Sd2EACvPZb9qRZccHpBnzvOSNlx2fc4YAovYW3O2rMS239Iv+EylgZbOLDrm+ybs+19g9s2Jc0c/va7ABlOLXMCYN02CNDdmrDKetge3Zhh6fcESIRAp0E55SCc0cht/F9hRfMnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=huawei.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KNtOvHxWLkXYBnkclPlVmERhlfU1ZZQLhu8CntbvjLY=;
 b=SdhuE0EmelQdGrl+CUk07FpYgb2VnLMDwcv3CzpmlRGBTNgy7r//TjLoF9eT0+NUx5DGqORuzjcpoe5HQ1ZnutDPDoc0jPHXuSeWrvict7QoNmcUNUfBw6icaKq72TiO0B/KlvogrF7QeB/YmZoqR9dJSi2bib27WpJyX5R9cp8=
Received: from DM6PR01CA0024.prod.exchangelabs.com (2603:10b6:5:296::29) by
 DM4PR12MB6062.namprd12.prod.outlook.com (2603:10b6:8:b2::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5588.10; Thu, 1 Sep 2022 07:51:11 +0000
Received: from DM6NAM11FT003.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:296:cafe::49) by DM6PR01CA0024.outlook.office365.com
 (2603:10b6:5:296::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.10 via Frontend
 Transport; Thu, 1 Sep 2022 07:51:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT003.mail.protection.outlook.com (10.13.173.162) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5588.10 via Frontend Transport; Thu, 1 Sep 2022 07:51:11 +0000
Received: from rric.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Thu, 1 Sep
 2022 02:51:08 -0500
Date:   Thu, 1 Sep 2022 09:50:33 +0200
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
Subject: Re: [PATCH 13/15] cxl/acpi: Rework devm_cxl_enumerate_ports() to
 support RCD mode
Message-ID: <YxBkScfVJF5CAdCD@rric.localdomain>
References: <20220831081603.3415-1-rrichter@amd.com>
 <20220831081603.3415-14-rrichter@amd.com>
 <20220831131119.00002c7f@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20220831131119.00002c7f@huawei.com>
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: df5375b6-c3d4-4513-166a-08da8beebce6
X-MS-TrafficTypeDiagnostic: DM4PR12MB6062:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Mx8kV0dBIJ4ULtSwbfZUG8vH/sddQHjea2uutcphnX1rWDX/O17DKNZl49aBIBNPmwQHPpzbtsZAIwDXuusxpY7rP5Mn3IsJjGSy4zVnePA//2JYBbUT0jaD5X02crD1RTxq/72KD60MuE3nCrRDFy9fN3SKuHzWbfAm6iNwqusey9s5+d7760r2E4rh+h5kh98YGAaLnGKpldjjafq4isl10vzPWtSV9fnIBnXmxeYIFoaV7RntYRdnFDsERg6ryEHKHGRkbXHZjIcILWb9g1g5I3uNBMrAAC1D34R7E2Ao+jZsBe1r1u39/Kt05kmlWNU4kPqPkExxqsoT/H7eWp834yetxgQ6jEGneSpaMO3uP6X+xG4WMtdwTJf/NzheXpl9pO/PdCyKcrDGiWKzeLjzGXTM/G2S1zOWTv6JFRAwIcRBU6tvr1Xx44GgVbfM7+nh303Xu5vbpN3NuHVjzAN3MxjAjNXe5YPCssxVkqsm0ojhpy6HoD6vy70a02QpLGW/2aD6O3+YMKds+Vu3agUeJy3F/2JHJeyS1gzUtorCbo6TFVfKLPwjuP+/49KciU9Sb9uX9YJtHqkljq8YXoUV1DyP3KW2+ruW4hQBRvlQSidHo10sI0RABd8OKlDFuE85hUnJYMH6uKDwGEC7aadwCR53TmbOeHeFO55UZmtg9JW79r1UdK+eSSY4DqrppRejcHTarw+3oR4ZthXPjxxmreqHi4jVqkPAvnXqfuBfdu+UtjKVkn1MRr7cvurqVDZrReVALvrLLJXCNuc8MhcCpK1XNYBMbqKvkhxiRef2qGk3jCq3/0NmDKTfR+Ws
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(4636009)(136003)(376002)(396003)(346002)(39860400002)(36840700001)(46966006)(40470700004)(336012)(53546011)(356005)(7696005)(70586007)(70206006)(26005)(316002)(40460700003)(9686003)(36860700001)(6916009)(41300700001)(82740400003)(54906003)(8676002)(2906002)(16526019)(81166007)(4326008)(186003)(6666004)(40480700001)(478600001)(7416002)(426003)(5660300002)(55016003)(47076005)(82310400005)(83380400001)(8936002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2022 07:51:11.2925
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: df5375b6-c3d4-4513-166a-08da8beebce6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT003.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6062
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 31.08.22 13:11:19, Jonathan Cameron wrote:
> On Wed, 31 Aug 2022 10:16:01 +0200
> Robert Richter <rrichter@amd.com> wrote:
> 
> > RCD mode has a different enumeration scheme other than in CXL VH mode.
> > An RCD is directly connected to an RCH without downstream and upstream
> > ports showing up in between in the PCI hierarchy. Due to the direct
> > connection of RCD and RCH, the host bridge is always the RCD's parent
> > instead of the grandparent. 
> Mentioned earlier, but that's not quite true.  There is a reference in
> the spec to allowing it to be under a root port (some sort of virtual structure
> - I'm not sure of 'why' you would that though.)(

Yes, but software view is still the same, see other mail.

> 
> > Modify devm_cxl_enumerate_ports()
> > respectively.
> 
> Don't line wrap above.
> 
> > 
> > Implement this by introducing a function to determine the device's
> > downstream port. The 'for' loop is adjusted for RCD mode and in this
> > case find_cxl_port() will always find the host's associated port and
> > the loop iteration stops.
> > 
> > Signed-off-by: Robert Richter <rrichter@amd.com>
> > ---
> >  drivers/cxl/core/port.c | 36 ++++++++++++++++++++++++------------
> >  1 file changed, 24 insertions(+), 12 deletions(-)
> > 
> > diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
> > index 61e9915162d5..08b99423dbf8 100644
> > --- a/drivers/cxl/core/port.c
> > +++ b/drivers/cxl/core/port.c
> > @@ -1084,6 +1084,22 @@ static struct device *grandparent(struct device *dev)
> >  	return NULL;
> >  }
> >  
> > +static struct device *cxl_mem_dport_dev(struct cxl_memdev *cxlmd)
> > +{
> > +	struct device *dev = cxlmd->dev.parent;
> > +	struct pci_dev *pdev = to_pci_dev(cxlmd->dev.parent);
> 
> to_pci_dev(dev);

Ok.

> 
> > +
> > +	/*
> > +	 * An RCiEP is directly connected to the root bridge without
> > +	 * any PCI bridges/ports in between. Reduce the parent level
> > +	 * for those.
> > +	 */
> > +	if (pci_pcie_type(pdev) == PCI_EXP_TYPE_RC_END)
> > +		return dev;
> > +
> > +	return dev->parent;
> Switching from grandparent to this is a little confusing because it's
> done in two steps.  Perhaps use
> 	return grandparent(cmlmd->dev);
> here to keep that connection and rename dev in this function to parent.
> 
> Far too many devices in here with similar names for it to be easy
> to read.

Can improve this a little.

> 
> 
> > +}
> > +
> >  static void delete_endpoint(void *data)
> >  {
> >  	struct cxl_memdev *cxlmd = data;
> > @@ -1339,7 +1355,7 @@ static int add_port_attach_ep(struct cxl_memdev *cxlmd,
> >  int devm_cxl_enumerate_ports(struct cxl_memdev *cxlmd)
> >  {
> >  	struct device *dev = &cxlmd->dev;
> > -	struct device *iter;
> > +	struct device *dport_dev;
> >  	int rc;
> >  
> >  	rc = devm_add_action_or_reset(&cxlmd->dev, cxl_detach_ep, cxlmd);
> > @@ -1352,25 +1368,21 @@ int devm_cxl_enumerate_ports(struct cxl_memdev *cxlmd)
> >  	 * attempt fails.
> >  	 */
> >  retry:
> > -	for (iter = dev; iter; iter = grandparent(iter)) {
> > -		struct device *dport_dev = grandparent(iter);
> > +	for (dport_dev = cxl_mem_dport_dev(cxlmd); dport_dev;
> > +	     dport_dev = grandparent(dport_dev)) {
> 
> I don't like looping for the RCD case as it relies a bit too
> much on subtle relationships between devices and parent.
> 
> Perhaps better to factor out the contents of the loop, then handle
> the RCD case separately from the main loop.
> I haven't tried it, so perhaps that looks even less readable.

I see your point here, will take a look.

Thanks,

-Robert
