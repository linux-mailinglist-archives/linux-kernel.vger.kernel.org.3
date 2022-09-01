Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 197E75A8D5E
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 07:31:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233025AbiIAFbe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 01:31:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232999AbiIAFbX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 01:31:23 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2043.outbound.protection.outlook.com [40.107.220.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 575651C10F;
        Wed, 31 Aug 2022 22:31:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cKxZpnnnoRvLZSvCMVCvMVX68LcWtTXemOPnpVcsRLpTZqv4XkRt1o/Hss7LQzhrFsWBK2VETpsPrvRY6AjeoaSV2n/1NuOKDxp93SYVfeu4oEfFWhb1jdO0LW9ENea+g6534pq4dpTBCN33SxXIYb0izVgPsxxX48b3VKelL4IDjwokxj9ie24B+e7jYOhkVvdUvaWNX/wg9nVfcb4mAjDtnLZVYAD83A2Gb6xjs3j4cHai4DfDumAAeG5g7UHIgGShh9AHLv+jgdEJnFjlsZjr8F538JI3J5ToLiKA+sF8DyjDTFRm/vBucal0k0gD9TD1bK846hfWKJEaD/8LRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Pg6vxhWd/g5TA/BrxIQFTA6kg+3SD2NCxKbvHD6Wl5I=;
 b=XcF2ZH/41uf1wMivl9bh8fTKlkzlaaWIirUEQlgBHo8NwIrS2FYLuN1/Et4yf0rXgGovD+r2Nw0wu5QuDxmBDUc+oNz/E6xcev0jRzt5zAKckdkmvSsA5+pUZmv5eRqUIs03cystw1mSuxL6fheL/dC+Y4kqaVFhfwFJO+G5P2mN4NjbPLsuZYcjEVLnRxUseUnN8x/d2Hx9zImP2w2ehzC0DKevSsCzizHmBAJnKWIs5B6yySvsI62+H4Pfg74fGP9EiUxVxNZy74fd9p/X3tXwAYA0gvLNIYVi9lPElEcIzkLgiR8lExz5wu2+Bcpw8GGo2QvfS6vSzBuDRilnrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=huawei.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Pg6vxhWd/g5TA/BrxIQFTA6kg+3SD2NCxKbvHD6Wl5I=;
 b=dMCgy0n2iHZavBxpQRM3LYfPvcuHge8L889sFh78KiTWM2WmQpa9zZ0hq6yc6hD1iVrZCzDqr+tqijGF99Pjh4ZzkOMwT3PQ21lbMP5KMRVW8nQJy3HM8cKqQxx90jAoYnxQNsPA3jbWiJhHKw4xggPXZi11lpO/kg0klHsBvxE=
Received: from DS7PR03CA0106.namprd03.prod.outlook.com (2603:10b6:5:3b7::21)
 by MN0PR12MB6151.namprd12.prod.outlook.com (2603:10b6:208:3c5::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.10; Thu, 1 Sep
 2022 05:31:20 +0000
Received: from DM6NAM11FT082.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3b7:cafe::26) by DS7PR03CA0106.outlook.office365.com
 (2603:10b6:5:3b7::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.10 via Frontend
 Transport; Thu, 1 Sep 2022 05:31:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT082.mail.protection.outlook.com (10.13.173.107) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5588.10 via Frontend Transport; Thu, 1 Sep 2022 05:31:19 +0000
Received: from rric.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Thu, 1 Sep
 2022 00:31:17 -0500
Date:   Thu, 1 Sep 2022 07:31:14 +0200
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
Subject: Re: [PATCH 02/15] cxl/core: Check physical address before mapping it
 in devm_cxl_iomap_block()
Message-ID: <YxBDot30gx7TN92Q@rric.localdomain>
References: <20220831081603.3415-1-rrichter@amd.com>
 <20220831081603.3415-3-rrichter@amd.com>
 <20220831095651.00000c73@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20220831095651.00000c73@huawei.com>
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ac57a969-3908-4e26-a876-08da8bdb3305
X-MS-TrafficTypeDiagnostic: MN0PR12MB6151:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: k5Md5HWwFl912x76u78hYeWgGR29SkEB7WBH1Qw02bPXjpha89YeZY7eHIczrxfKtf+hWEMKbMClATQWlHJqC+bt2DgVBZ9MXz5tFUqnWCGKtrt2sKUbixZLBZdkxPebqadqa/siYYJy8S83ksHWB1LVWAmfrMRIixO+MrAWiezRRSAIF/TixYCTw2vXfHxTcPrnN8m/jUS9nSppNo6799NXkxM7xbGvF41RJeS848VPpuYChGho34ngyIl763Vl23GzoW7yjtwpop4oRRl20VC1ba9kfJwJgxru2dFt1P/9vBQfaY90ry5JAwvCnCEMSWZzcT4q2eMKhTCw0DOK/GwlWHQcyF4HcF91A+gfUM2vbh+JCtOIz7+8Zf67AJsGgc8CyMkWTqCpkShaUC0afJcCvvutiwj7plVYLLEk4xyYvAYEH2ruRlrIxKmj79VuguscB0a48MCrGBuqzuVMVoGicnN4VocC4tif/5uXyV8g7XGXD9B4bW5ely30zd2eNqFyyZDHdzWBUhLsvTn+jwjNyj9VYDVPvI+8wB7EXPNmkKjqpQci9yGD/aIft7wFUvmV5p1GGxj7Z2p6HMUj39V/dsPXt85n2eIHVVnD6z6UZbZnIyJ7e0FzEzfGD0j+gwWo16sGcs5IftPK2XF2oz+04NjCGUnWUpmW9oOnEppPgUc1RGjrEY1jBM0Tp2YPBMKMehGcjT5On62sPICi83XFFDUvvKm69s/jDCFsrWDyUQaiZPzX1cl6yh7P2EnCKI6Fh5rCFzbKyS++Ugd2idVW/JjsQ5JZRdp8bOLVs16HnNr6oW/2a2sVdo9RQtZB
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(4636009)(39860400002)(376002)(346002)(136003)(396003)(36840700001)(46966006)(40470700004)(82740400003)(8936002)(7416002)(356005)(40480700001)(4744005)(9686003)(40460700003)(26005)(70206006)(70586007)(8676002)(4326008)(41300700001)(5660300002)(55016003)(53546011)(7696005)(36860700001)(478600001)(2906002)(336012)(16526019)(81166007)(186003)(47076005)(426003)(6666004)(316002)(6916009)(82310400005)(54906003)(83380400001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2022 05:31:19.5360
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ac57a969-3908-4e26-a876-08da8bdb3305
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT082.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6151
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 31.08.22 09:56:51, Jonathan Cameron wrote:
> On Wed, 31 Aug 2022 10:15:50 +0200
> Robert Richter <rrichter@amd.com> wrote:
> 
> > The physical base address of a CXL range can be invalid and is then
> > set to CXL_RESOURCE_NONE. Early check this case before mapping a
> > memory block in devm_cxl_iomap_block().
> 
> An example of when it is invalid would be a useful addition
> to this description.  Feels to me like this is papering over the cracks
> in something we should have ruled out earlier in the flow.

IIRC this happened during code development in cxl_pci_probe() when
cxl_map_regs() is called but the base addr was not determined
correctly before. It's similar to a NULL pointer check.

-Robert
