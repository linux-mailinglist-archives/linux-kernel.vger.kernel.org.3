Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B8EA5A8D6A
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 07:36:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233086AbiIAFg3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 01:36:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229720AbiIAFg0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 01:36:26 -0400
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam07on2050.outbound.protection.outlook.com [40.107.212.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B0B4D87FF;
        Wed, 31 Aug 2022 22:36:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Tb8XSFu/PQ+76NAFHXeWawIJOLDWlM5P0W2LETV7KrSgUNSGQ+af4dr+tXtvZFgDhTVjhH4Z0ExJHfUVwoGPZnpFn6c1bjI8SuXcjHFDI9KQah6i+QYojUsRVOyPCno3jLy+6PU3E6CsJiY9PfOGwIuPbjaXKGwv+oTA59OdMiTSwFgwjRQ/JJGaBjhQDgq15Oxbvouu2/a/A4yMttdLagkLAqtRdW4xhWVgP2R3rv2FRtNp7MhdR6UyzzJGDNpxkHpstD7i8bZT1BoyFze91CXHKeR2tLI0xvQjSd5BIULuJrNLXjourplJ4vtGdAITs+yH6UsxIOMGFdEWn09+3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l2HG/id/6/6W+u0xfRmx9BYPPymW5Qt2Ywzom8uHqYs=;
 b=Xxen6zkyE+0g2HTmle25POvT3ul2ATX5juPxa5FQnWzY2cNz/2TXbP0pqOskY6xLk4UtIigvT00XqZa4nq9oxoJgsU1t1mUHC55fsbGdp337Lqp5BLXPp97y6AWSU+dX0LwsUr4uRLYxuYjal+3h3e2LRDvhcKrO5rofmx/2zNBBRrw4AYLnngO1zdmctzsavxRtaNBsX93hVoVi28dy9eG/qCjwkW+gUwNmmGAAkTfAMMqcMlMKEcUIwZ8fsz4RhAfkTk/mZr3F5aqMESaGXqJeS0NKI3dpSEjrBuvjeNbv0aZZgpYpYJbsFD29g7psQu72KK+VMRONVfWWVMQ6iQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=huawei.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l2HG/id/6/6W+u0xfRmx9BYPPymW5Qt2Ywzom8uHqYs=;
 b=LLwGhkUOtVwWBPdozNlpRzrsaqDUo+fiLi6l6vYs2bBR0AYeKAg3JwTibGZeevVS1JAHT9kUzH77PTrToVKYeqxi9b3U/xb2JDeFO2q2Xx2bsClJBzeH73FUPi46J+3luK0sdhDkYtGudJe2owgD682aoWKp0T7AuDJ+9JQaAPE=
Received: from DS7PR07CA0021.namprd07.prod.outlook.com (2603:10b6:5:3af::23)
 by CH0PR12MB5281.namprd12.prod.outlook.com (2603:10b6:610:d4::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.10; Thu, 1 Sep
 2022 05:36:23 +0000
Received: from DM6NAM11FT016.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3af:cafe::7) by DS7PR07CA0021.outlook.office365.com
 (2603:10b6:5:3af::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.10 via Frontend
 Transport; Thu, 1 Sep 2022 05:36:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT016.mail.protection.outlook.com (10.13.173.139) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5588.10 via Frontend Transport; Thu, 1 Sep 2022 05:36:23 +0000
Received: from rric.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Thu, 1 Sep
 2022 00:36:20 -0500
Date:   Thu, 1 Sep 2022 07:36:17 +0200
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
Subject: Re: [PATCH 03/15] cxl: Unify debug messages when calling
 devm_cxl_add_port()
Message-ID: <YxBE0U4WyBeAc3R+@rric.localdomain>
References: <20220831081603.3415-1-rrichter@amd.com>
 <20220831081603.3415-4-rrichter@amd.com>
 <20220831105945.00004668@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20220831105945.00004668@huawei.com>
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f1d073fb-9c15-4216-ee26-08da8bdbe7f5
X-MS-TrafficTypeDiagnostic: CH0PR12MB5281:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bs7RRob/ley/ztWxJo397SD1D0PNUYPK0HLrY1pQKW0249vog/n0ApwdhskThlEjM6EQEPqXwBBz3zUywdaarGw4WdQVSFLbrt5unqU8Lqp/w4RBfBl4Hd7Y0qLMM2r4vG0ZT0Nmc1yRYctJs9/py2D0tVv0kakDTF0T/spAGOiW5y2jQyE4tA2VyirCRoY/GkjP63LLxSysSYh7AmhiF0775YWKBrQ/yDZT8ZbwQjtbJU0WD8CbBh+hOT7SQs2FbnyYRX+SADOSWLs/x61gmRQ0gkJEEbWWUAVSwQzmYRUMfHwMQf1/EqgNWWm6Skz7qEhyxDYAOCw+H/FMxpurksrEz6g9JRCDzVa1QKhpjZ194e3AmCReTk1T57Kfauy4LxiUL5X/qtLhxPPQ0pp/DJCfQIT/Wgxbm4iPN8iv0+KydQmcvw5nnqiT07pvMl32bUwB4+vK1OTLsR7R+Q69HKfYdbgpPQdbVsmQUXXPZYmEdq/K1nCYVqU9WilojsW7RacXUnAifosg+L5TczkryzGhs+uRAMCczbpgU+YVZ1DXNd03eR8vNjb/LQTaHp/lmiOwYnktV7akSnNeIbQb4si+aIOMeWK6Leec2FKirCFeJaHP4spmRqEYTUsYukOmqy7wh5RxcdJVx6bAftpru9bfLga4OWzA/VcI4SouU9a4Bu+74h2EUHuG9GsKamoe6jfTDycPxefzPjnINcty+pYH+8ewbmToYu6S4J2O89z6SLyLQBwRml//oW3RBCH1FkkkN0uOBW2hAVuYukWtYUyEVaYx4Y9RqxPdeKTG679tr+zdsyXOqzrDXw5G5VPq
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(4636009)(136003)(39860400002)(396003)(376002)(346002)(36840700001)(40470700004)(46966006)(70586007)(70206006)(4744005)(5660300002)(15650500001)(7416002)(4326008)(8936002)(8676002)(6666004)(478600001)(316002)(6916009)(54906003)(82310400005)(2906002)(41300700001)(336012)(81166007)(426003)(186003)(47076005)(26005)(7696005)(9686003)(83380400001)(53546011)(82740400003)(40480700001)(40460700003)(36860700001)(16526019)(55016003)(356005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2022 05:36:23.1161
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f1d073fb-9c15-4216-ee26-08da8bdbe7f5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT016.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5281
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 31.08.22 10:59:45, Jonathan Cameron wrote:
> On Wed, 31 Aug 2022 10:15:51 +0200
> Robert Richter <rrichter@amd.com> wrote:
> 
> > CXL ports are added in a couple of code paths using
> > devm_cxl_add_port(). Debug messages are individually generated, but
> > are incomplete and inconsistent. Change this by moving its generation
> > to devm_cxl_add_port(). This unifies the messages and reduces code
> > duplication. Also, generate messages on failure.
> > 
> > Signed-off-by: Robert Richter <rrichter@amd.com>
> 
> This is one for Dan etc as it is mostly a question of how verbose we want
> the debug prints to be plus preference for caller or callee being
> responsible for outputting this sort of message.

Esp. together with dyndbg this is very useful as you can get a whole
picture of the port enablement.

-Robert
