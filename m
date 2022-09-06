Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 656855AE11B
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 09:30:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238085AbiIFHav (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 03:30:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233440AbiIFHas (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 03:30:48 -0400
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1anam02on2054.outbound.protection.outlook.com [40.107.96.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95B4726AF1;
        Tue,  6 Sep 2022 00:30:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AurXVlozOmdRlOciqAV1ND8nsszUYr3qFbO1+XVWb4kV0ToJ3zGpoD4uDi0EVm1xKSnXEa+VlV6SgjOtmr9LTeX9RB7G1AQLPGTgO3V5uqtRl5Yd7nDZ3LsKPnozQ4PNnJmWHAK1hdbun7ejEPI9LVYKUaJjd9cgLVJObfoEg+yS7qQ5GzLcnLHEePHFXZtv0lx05hKW5HYBX4OYeDD5gdZnBGKBlkyrIg3cEnqJdYIv+lFw0xLLgcPaQss5BOFjDcRp1WLbCjCWa5IMqpUbqbEU342YPI7x8DlKZOAZQIE4Qyc7OUKg452dp1ZGcF8bL8KiR30PLvDp2JRkI3BLFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IvvAUlFbaFUruchYAXKIJEBLq4XuLefBxzSSBACJeGI=;
 b=Ac+oXjGizqzl9hETK8JXSDhe6eogyL5nijTXOBMkvEtDP4iv1x1WwK+I9KDsALf9v6UGO5YNy/xnMAG53t6DgMAUs2DTxJ6pykWDjfmh76D8eNjK9s/BrPI6InTvjmPmi1i7mkn1pQ1ATDg4PegOtDj4vplwJ0Bic+sHqo9ytazpyxP8+qVOy4TkAih+Pxoz/2NqbwEfxiNDCY7o07lgQN2YPjP/Qj0UUCUs8UmW8QM4A9/cQQ0ZVUezAwMx26M5qqxpgt1JX1sdDRk7v/ANKHfoSJ8HtoTtZBU55LPrYtnCCai8hNeGcV6ZZPw2AccLlnnsjUbsE+KTf1B3nC7iwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=huawei.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IvvAUlFbaFUruchYAXKIJEBLq4XuLefBxzSSBACJeGI=;
 b=0MM1vhld+rrgeAWrJ9AIF1BKfNnvKt3QeRYNzcc1hu2I5qS1HkvQfE5Z9DXcL7MCkTxerhCBZR+G3TlFQYK5zErG6UJX0KcJ41PqilvpagGWm3pXk10YqcedlEgXYmoSwFfOiIqA1x+jMPjdCjEjW/3dlXPRdSGFvb8WvrWoNis=
Received: from MW4P221CA0026.NAMP221.PROD.OUTLOOK.COM (2603:10b6:303:8b::31)
 by BL1PR12MB5174.namprd12.prod.outlook.com (2603:10b6:208:31c::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.11; Tue, 6 Sep
 2022 07:30:44 +0000
Received: from CO1NAM11FT010.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:8b:cafe::7a) by MW4P221CA0026.outlook.office365.com
 (2603:10b6:303:8b::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.12 via Frontend
 Transport; Tue, 6 Sep 2022 07:30:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT010.mail.protection.outlook.com (10.13.175.88) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5588.10 via Frontend Transport; Tue, 6 Sep 2022 07:30:43 +0000
Received: from rric.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Tue, 6 Sep
 2022 02:30:40 -0500
Date:   Tue, 6 Sep 2022 09:30:37 +0200
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
Message-ID: <Yxb3HQVr5BJzxedj@rric.localdomain>
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
X-MS-Office365-Filtering-Correlation-Id: 39655a34-7cad-4943-f631-08da8fd9b50e
X-MS-TrafficTypeDiagnostic: BL1PR12MB5174:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /2q+wbIH+gM+aEW7vkqFzQeWKqWFT11091uHUAO9wMuXDkrjNrPY3pRlrcOinaoZPIKubE/vFZLV2swxbbt3xOPfX5bDVF6GRQN0jYQpOXJQvYZLiKJbdGJ+cXfzIcRuojruYw96jYLVCHge6Q4ZY2mkyGfCOv/BHmlI/iH34xnEKcdMGGVukMRbq7w9JyRcFL9fWTYHGFTopJVChuQba2/PoqqwFzXlRmEPTdEKyrna90yEr0vURmRFLif0NwP5Yp+Ix+jidSjLL3TgRobNOrAgNee+fPQC3WmomxYzqi5e+YHUMn7sMtEaTjWAr3CdbN294dTYxgqLocc3KkIUJYBjoh1QO4zB1t//A8vPWdH9jfRtHSNcYNEZL2eFDcRMdDNGu7KP85YfiIuTgKN5t2qaBFNidYBPNSOhcXhIvNmPYHl6Y+wG0LMdF3x2OTd4I+8NUCzZ0rjudrK95G41Y9xTKnwtxxdqNqcYVmlx0Nf8+14PD1x8ZPkdPBSG7RCxqECGYZsQekj8QP2/I7aOOMUVyHTZd3voAmmBbDlw7MLQ+ze4poio8+rYUGz5O2lhAH2xvGPawqAorGH1gkjVjdF0XZA81Qh1R6k7iEY47e7D019bw2Hts/6LY1EqRftzcpUWjcEL4y/XtlWk0PqwJ257baJ7mWJ2TWm4pdbVIb5BHJk/LlfwmL8C6KiMXIth1pU1WdBFB2uhVX+b7sAipOYX4N5tcpRjFHEg4vJANtRcQfFJOQBEZRbO6aRUUnOfgWEEFuIgCWIO0mRjA3R9KBGel+0FHyf44KBLH3AGzo8VcBBcJxjV13gdqXVHbH9g
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(4636009)(39860400002)(376002)(136003)(396003)(346002)(40470700004)(36840700001)(46966006)(4326008)(83380400001)(8676002)(70206006)(70586007)(336012)(16526019)(426003)(47076005)(8936002)(36860700001)(5660300002)(7416002)(26005)(53546011)(478600001)(7696005)(41300700001)(186003)(6666004)(40460700003)(54906003)(316002)(6916009)(4744005)(40480700001)(9686003)(55016003)(356005)(15650500001)(2906002)(81166007)(82310400005)(82740400003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Sep 2022 07:30:43.2803
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 39655a34-7cad-4943-f631-08da8fd9b50e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT010.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5174
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
> 
> Patch looks good to me if we want to make this sort of change.

Should I take this as a Reviewed-by?

Thanks,

-Robert
