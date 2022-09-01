Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 756EF5A9147
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 09:54:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233322AbiIAHye (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 03:54:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230307AbiIAHyc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 03:54:32 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2082.outbound.protection.outlook.com [40.107.220.82])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C7B3221;
        Thu,  1 Sep 2022 00:54:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SjyBZBQY48AXIyVlzA3o0N3+LX0taUuM+Lb1gOHSoLGlP/mK+n2n0ZBdHbPcEktmnJyrZKbRVDHyqXAmwI0dKgmsUQbGyqENiCE0j2qL7l16jXk+PdV68jMpwFk8JnniLdG3ZEk1r+i7Y7FygksaRbRkbjgUhLXpV59JNZZ4DKhs2xC6WAKtcsTMT5tHIasWwiZAft2KpKHedFd1IG/bUDBvLgVmR1X36casndtcmtThUC7cdnh9EWWsqAGegtuHOWDn6tvaWNTrNckEaxumUsmCIWbN+A5X8sYa8QW/uEf8hwtwJojU06Tjny/hc3Zp8qP9Lp7YKjiykRr+PBYtPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/0IscvScqDFALljUzmQV09cPQY/iWuMGKR1mCv5ydNQ=;
 b=OJwlt4NtDw0eupuPzhPrGBQqueb05wgLWpOg2HDDP6+kLz6eY6WsYSOcMIsDcxpyhcedmD3l94kTkDTloZG7xSDekDBApG5ucC5f/9TV7KNj8bxdUD3dqdlfIIPySurQ5N3YrznwxCCgXB9masd3/tAk8pchx9fAFk4/m0kscR3f7egAJrIspnb467k348ApZZtLEjroLF8KBsP8fqJOMv+8DFIjNY6Z5VwCeascK0MKhEMGfqmG9C6jrGXb5uVVzLE1CzAM/IoCKFqigYKt6ZwKtvMiaRw8Tuhhjv7YN1+mNgy1kpToIFIN2X4Dy10dU42vVSF8EO/FK8q53vBF1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=huawei.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/0IscvScqDFALljUzmQV09cPQY/iWuMGKR1mCv5ydNQ=;
 b=CF5W5h5P9hh+jNa2qCbrT7qjJy8DnP5HFK+POXlcLElXNSWnZJJNHzZkVN8Pg/ahkGhIYTYY9SjtkhS5BeXchQ/cajYwGqWm0BIGzARVGXt3hTM6jT6WeBgOt7O+cpXaPGwEnIl7Lrg4fePqxlHPa6sNDHH/ZZFp19oyNpNljVw=
Received: from DM6PR02CA0160.namprd02.prod.outlook.com (2603:10b6:5:332::27)
 by SJ1PR12MB6218.namprd12.prod.outlook.com (2603:10b6:a03:457::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.21; Thu, 1 Sep
 2022 07:54:29 +0000
Received: from DM6NAM11FT097.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:332:cafe::c0) by DM6PR02CA0160.outlook.office365.com
 (2603:10b6:5:332::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.11 via Frontend
 Transport; Thu, 1 Sep 2022 07:54:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT097.mail.protection.outlook.com (10.13.172.72) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5588.10 via Frontend Transport; Thu, 1 Sep 2022 07:54:29 +0000
Received: from rric.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Thu, 1 Sep
 2022 02:54:26 -0500
Date:   Thu, 1 Sep 2022 09:54:23 +0200
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
Subject: Re: [PATCH 14/15] cxl/acpi: Enumerate ports in RCD mode to enable
 RCHs and RCDs
Message-ID: <YxBlL64H4InIPGT7@rric.localdomain>
References: <20220831081603.3415-1-rrichter@amd.com>
 <20220831081603.3415-15-rrichter@amd.com>
 <20220831131634.00007870@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20220831131634.00007870@huawei.com>
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 97cf7577-638f-45be-a222-08da8bef32e9
X-MS-TrafficTypeDiagnostic: SJ1PR12MB6218:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OcU3bWgmgerFk6VZip48W0yfUXMRpua1wl0don0GD/b7ONONmrj62C+yynBm7Kw5qebjSU7cyh9NKYem5VH6Djtn2APFcJZNIIolARUq0sDjDNg5kaAyxkKFpvXJHYa/e8mgyjMCoaxvPUNCL/PfGXJIZ1rNHR/dLyJ4C/DMt6UZn+61URH7A7UDm6YkdcyH4x/GmX5e454bMcewSwNNd75RRicrDSyz5mTpm2rU7WE2XhifZQm6Cs47YYzNPaCkcECuaK2B0qMTYU2imRXEgtxCQTuI8LCxp2nOlBskI8ezJgzx0YkdI17S4B2ubx+c8ExDLpUn0fQfG5wazQycy/KmsjMtlMV3h0z8D28Rnwa5OkkHq+ndpLTo/ELaIO/x/PMjol+uKV+0uPEzShlvNq2wTxhpFZ/ncWpIhdp8ht5Q81/hDbOeMJ2uMp0uGkBIoZ8UKPIh8Lh3reRxZp98FGUvTUh71QKwm2Ih+keFyQ/ClcpZihabwIKodK6hS8I2DQNQEW6qh8LyGo6mWUSdzixXVq8hP6qxn5v1hNtI02mteMbt47kKphMm17TOX/FvLxhQC+TJHrwIqSk/IgJTps4FXxtJ5GobFwzuCWTkE9eKmP9YlXCktDeUBUwWtlK/zL+UhxJa0v1CM3SxGi50JgMXPiJRTG4tdTQH/wLayENaLbnNBCXMqk5To4bgN5hsVR269vgUSZmqUOPR9os8JAtCi7EMuXEsb3YpsWPdRbn+ua26FF5Xupl9Wrl/wTsxFKCIyiOhJbwxqVJpKz9m7nig9pUe++bT5/WXtPaq2n1B/HTo5qkffHqS3HsMzYCk
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(4636009)(136003)(39860400002)(376002)(346002)(396003)(36840700001)(40470700004)(46966006)(40460700003)(478600001)(2906002)(7416002)(336012)(5660300002)(16526019)(53546011)(81166007)(7696005)(82310400005)(36860700001)(82740400003)(6666004)(54906003)(41300700001)(6916009)(70586007)(8676002)(4326008)(70206006)(186003)(8936002)(26005)(356005)(9686003)(40480700001)(47076005)(426003)(316002)(55016003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2022 07:54:29.2869
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 97cf7577-638f-45be-a222-08da8bef32e9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT097.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6218
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 31.08.22 13:16:34, Jonathan Cameron wrote:
> On Wed, 31 Aug 2022 10:16:02 +0200
> Robert Richter <rrichter@amd.com> wrote:

> > diff --git a/drivers/cxl/acpi.c b/drivers/cxl/acpi.c
> > index 88bbd2bb61fc..56b2d222afcc 100644
> > --- a/drivers/cxl/acpi.c
> > +++ b/drivers/cxl/acpi.c
> > @@ -471,13 +471,52 @@ static int cxl_setup_component_reg(struct device *parent,
> >  	return 0;
> >  }
> >  
> > +static int cxl_enumerate_rch_ports(struct device *root_dev,
> > +				   struct cxl_port *cxl_root,
> > +				   struct pci_host_bridge *host,
> > +				   resource_size_t component_reg_phys,
> > +				   int port_id)
> > +{
> > +	struct cxl_dport *dport;
> > +	struct cxl_port *port;
> > +	struct pci_dev *pdev;
> > +
> > +	dport = devm_cxl_add_dport(cxl_root, &host->dev, port_id,
> > +				   component_reg_phys);
> > +	if (IS_ERR(dport))
> > +		return PTR_ERR(dport);
> > +
> > +	port = devm_cxl_add_port(root_dev, &host->dev,
> > +				 component_reg_phys, dport);
> > +	if (IS_ERR(port))
> > +		return PTR_ERR(port);
> > +
> > +	pdev = pci_get_slot(host->bus, PCI_DEVFN(0, 0));
> > +	if (!pdev)
> > +		return -ENXIO;
> > +
> > +	/* Note: The endpoint provides the component reg base. */
> 
> I'm not sure what this comment means.  Which component reg base?

There is no component_reg_phys provided here, so the addr is
CXL_RESOURCE_NONE.

Will improve the comment.

> 
> > +	dport = devm_cxl_add_dport(port, &pdev->dev, 0,
> > +				   CXL_RESOURCE_NONE);
> 
> Trivial: No need to wrap the above.

Right.

Thanks,

-Robert
