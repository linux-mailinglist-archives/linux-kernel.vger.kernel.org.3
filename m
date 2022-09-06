Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 958955AE0D3
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 09:20:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238857AbiIFHUC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 03:20:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238846AbiIFHT7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 03:19:59 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2042.outbound.protection.outlook.com [40.107.220.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66EF6167D8;
        Tue,  6 Sep 2022 00:19:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T4Uw8aiTd9T8TnJI+bD+g62fKplZrAJZtpRMU7mAci7UNwR4O8zJw2996qZPRWw0t218fjMUr0FozdgjLbyW7agePvITUX83P2P+wfvYaLSdVExdNh4dC2i+RRti8H9836kwBdxvDKw6YFbVYSaf4PHb9k3Et8zpq7oeLyhBNyM+tRHc4riKs1/xNBBoJsPM1zd7wn60jQjnVg1qN14Df+jBVkuIZNoilWlBl+aP2YfE1P6Zjv154zcjesrM/bXe5DM+k18HL0Jxg59AiPTVeC/goRrJM1AyrbGrF0IHpNPVKtQsD0S3gtiAwRX6pDohJgEdQ9zILvIi5nfIyvGv8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VEO9DHTiHWOytNe5yl7dfYIB0QdiqpptbM3QO6hsnJI=;
 b=mmL6+/+oLiZMt8vZynncghlENGchwVys58tsRZPET23q81pmskoK1zTj486NHlcXei/XO/FpbleMMfdqCaEX6wa92BmswKmnoXMO6xjPdPPV00Ikp3q4mRXa9pkUEs9QhkjOcAcHSmezvTQ7ov0df0RjsFTXhcDxfsSI197JnwjIGKXLa/bS2PM6ZVWiJvKw9DRSuCkuDG6DEJsLZEthf6VqZuZ8CW8dHupm1cCbXgLkJoNEEB8LWT6Lq7OxK5TUlf/6Q4Uek9K/jxGzDRIBNPlKjbC63Crn72MiOWkf56Dzb555dtSwZUJCzOs/kUMGXgHNwt+LJvcoZ0ZVPCxQig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=huawei.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VEO9DHTiHWOytNe5yl7dfYIB0QdiqpptbM3QO6hsnJI=;
 b=vPemg4y8itQ1ZPK0ocyLEHyQ5ZJRUkByVA/i2iMKKh3Z3ndhL88lm3sD26XYMQl/bSu6yyxHvAGGmswuO1mi0HERVosbehaEILQubGuHAYKJl5zG26VF3+AmSbsfIlU8/EsEVSVkliFt36X18aa4QAXBzCKvQbH5ooO4P2e+z/s=
Received: from BN0PR10CA0020.namprd10.prod.outlook.com (2603:10b6:408:143::11)
 by MN0PR12MB6102.namprd12.prod.outlook.com (2603:10b6:208:3ca::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.12; Tue, 6 Sep
 2022 07:19:55 +0000
Received: from BN8NAM11FT077.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:143:cafe::a7) by BN0PR10CA0020.outlook.office365.com
 (2603:10b6:408:143::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.11 via Frontend
 Transport; Tue, 6 Sep 2022 07:19:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT077.mail.protection.outlook.com (10.13.177.232) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5588.10 via Frontend Transport; Tue, 6 Sep 2022 07:19:54 +0000
Received: from rric.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Tue, 6 Sep
 2022 02:19:52 -0500
Date:   Tue, 6 Sep 2022 09:19:49 +0200
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
Message-ID: <Yxb0bequiQAkzj2Q@rric.localdomain>
References: <20220831081603.3415-1-rrichter@amd.com>
 <20220831081603.3415-6-rrichter@amd.com>
 <20220831110804.00003812@huawei.com>
 <YxBKoT2zlUVgXIry@rric.localdomain>
 <20220901111038.00002e00@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20220901111038.00002e00@huawei.com>
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2d2a2744-e75d-4bd1-19fc-08da8fd83263
X-MS-TrafficTypeDiagnostic: MN0PR12MB6102:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0Y+t5im4Bk1zDKcjnFkbH6Am7JY/5g8Fhxz1alEavtpDFJbzljt7Y8wrmrzdrbBmal893+JKGIE2B9/almJtSGvS8pYmwBgpOwvFOs1vLVuIse6YxhQQOLgHAD9HJ4XMZtYhmocNeYbTJExB9vltohep5YLeY4rsYzUnY+3S7WM4d4FwUFKp9GAWjyvaP0N/4DQo5/xHTw1NznAwZLXJHNF8J4YxT+DZAEBBefN+19lZnlHQFPDuDAq3HNIN2Yf9l7fGYgTsouBdkrjqPL3wMXeRZomilBSd/BZWsIDQe+0oWE1PEckl13cwy3Vkz9lvKjwGuOiO83bHnojwg6ZFQUvA3qie2n3kyxcVJEd/Q5NZxXjiNWUFP08KvcVx6SCkNhy4Gu5Np1k9YO7Bvxd2vm2Gkxv5Zs8RA0piC/t9P6wcV2W0+xBDqXmi5kTX2+edfnwVelsZRFTE6r0PNzHtFOBil+gH9E/mKBSqdl/6H506nsc1KfLv8bNkZzxwYgRD7jJ4HjiNCTHK7FRD6HKqWRmdx7iIQBp3ydXeMBfEyjXAqCqZXtMacStfRfi83HOdzgEwRmXRR6sO6QIMdvlPtXtsMu+2P0amnPBZVydkkEbN8ZoNhRox5jO1bKNxn2BIbHL+kR5Y9GZ1NQOrvGPYtDVMkPVHlMgjFcisVl/q4k3iYWpqsXTUyM1d1SWhqrOkqn0nJqb0gHI4xXK264xzUjJTR/mr1zxvH07FwVN5H3FKR6J7cZW/+YsIb7fSvljQgvr/+85m/6FkFmuD3kzs7v4iEGWgjvQBSjS1M7lvs7Cdm3TFJs1yhR5gUG8EDvuH
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(4636009)(376002)(39860400002)(346002)(396003)(136003)(46966006)(40470700004)(36840700001)(4326008)(478600001)(8676002)(6916009)(40480700001)(70586007)(55016003)(82310400005)(316002)(54906003)(5660300002)(40460700003)(8936002)(70206006)(7416002)(82740400003)(2906002)(81166007)(356005)(426003)(36860700001)(41300700001)(26005)(6666004)(53546011)(186003)(16526019)(7696005)(9686003)(336012)(83380400001)(47076005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Sep 2022 07:19:54.6784
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d2a2744-e75d-4bd1-19fc-08da8fd83263
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT077.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6102
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01.09.22 11:10:38, Jonathan Cameron wrote:
> On Thu, 1 Sep 2022 08:01:05 +0200
> Robert Richter <rrichter@amd.com> wrote:
> > On 31.08.22 11:08:04, Jonathan Cameron wrote:
> > > On Wed, 31 Aug 2022 10:15:53 +0200  
> > > Robert Richter <rrichter@amd.com> wrote:

> > > > The probe function is triggered by adding an own root device for RCHs.
> > > > This is different to CXL VH where an ACPI "ACPI0017" root device
> > > > exists. Its detection starts the CXL host detection. In RCD mode such
> > > > a device does not necessarily exists, so solve this by creating a
> > > > plain platform device that is not an ACPI device and is root only for
> > > > RCHs.  
> > > 
> > > If I read this correctly that platform device is created whether or not
> > > there are any cxl devices in the system?
> > > 
> > > Can we create it only if we find some devices that will be placed
> > > under it later?  
> > 
> > This would move the host detection from probe to init which I wanted
> > to avoid to better control driver init order dependencies.
> 
> It's a bit nasty either way.  I can see your reasoning, but
> definitely not keen on it if there is a plausible way to avoid.
> > 
> > I could add a put_device() at the end of a probe so that it will be
> > released in case no other references use it. This implies the refcount
> > is maintained for parent devices. Or this needs to be added to. So if
> > there are no children (hosts) attached to the root device after probe,
> > it will disappear.
> 
> Unless there is precedence for that, it'll be weird enough to be
> hard to maintain.  I guess I can live with the ugliness if we can't
> add something new to ACPI to base this off.

Let's stay with a put_device() for now. Then, we wont have a stale cxl
root device in the system in case there are no RCD children.

-Robert
