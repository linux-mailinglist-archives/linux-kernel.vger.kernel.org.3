Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F5A44ECC49
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Mar 2022 20:30:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350452AbiC3Sbd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Mar 2022 14:31:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237396AbiC3SbW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Mar 2022 14:31:22 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2127.outbound.protection.outlook.com [40.107.20.127])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CC352DD57
        for <linux-kernel@vger.kernel.org>; Wed, 30 Mar 2022 11:28:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bocV2xOGoH4EnZzzOYYH/1tsTO2upJ8nqYchRUByD6m37T8fc0yQDrge+r6aSAq/9vqk0L8edURb10VlBJWSuDshCfc4pQGexfF+Ek+tk0c3SXduUlFiakQ5qKODMwNkGMYvGEcH9d1+fpl76Oqpm2kEg4LZ2p7d+k368a8HWgADackK9drJ8WF14bxB/dnYl67FZx6zbd8vW3bumfHQvgFG0vto/vVKec4VRJCl5k/G3XXBSIKmYs7AeLGZ2GOVRcdo3QWCuRxULQ/gQm2CP5ABorRJPji1SaER9FYrC04yNKcpN493Q37pdLIPrb2OJiqzpc3dEEaAcV7ASjYpog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EUpdsr84ucuMox3wVndBbJQM+nA+hcmPNi5xzqj9rMI=;
 b=SNwaISwRok4LtrPvb5auz7UCxqJp4lTZJnC/bHK/5fPNmTJPRUQ+NlTVVFi/8uMl7RHP887LZQEpJZQ/WuK4ratBRGpWMkC0Uz+gn5zvvcfZcA9XEIDP7VmpnptcCjfdrpDyDNsUn3SphSBUggoDg70SD4GeLiHjem6V2W7SjrCMrhhUK6vP1cAqxIXB7H4FBB7doV3Mjfdu+Bh6Nux6TFJLUbhp43stLAe6Z1d5Tyurhb5Kqgyf/HrhZQuWN6nn9M2lX5qiEyI1JtVmYgZzrKT5P9KPN6z/veP6QDHpOLhTtcDndFlOYL0jdK6CId+LNtsNepHqVScK+I2BceaEfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 217.111.95.7) smtp.rcpttodomain=kernel.org smtp.mailfrom=arri.de; dmarc=none
 action=none header.from=arri.de; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=arrigroup.onmicrosoft.com; s=selector1-arrigroup-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EUpdsr84ucuMox3wVndBbJQM+nA+hcmPNi5xzqj9rMI=;
 b=OlUbXMZfpiDlV+J65EL30rWyMLPxk60mjTtYV3q/I9MPPa2IGX/SyB+HNZbU+lcsucvtx7fWytLmRN9tN3kU9NXmMVpVSz6xdE6cs9nedJ6DqQGh1aDYw64Ej7kljM00VfKeVUDcRDMrsdbB5KXtQiSZi1NBdMLZwy/YvwrW4Is=
Received: from AM5PR0202CA0005.eurprd02.prod.outlook.com
 (2603:10a6:203:69::15) by AS8PR07MB7399.eurprd07.prod.outlook.com
 (2603:10a6:20b:2a3::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.20; Wed, 30 Mar
 2022 18:27:58 +0000
Received: from VE1EUR02FT011.eop-EUR02.prod.protection.outlook.com
 (2603:10a6:203:69:cafe::52) by AM5PR0202CA0005.outlook.office365.com
 (2603:10a6:203:69::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.13 via Frontend
 Transport; Wed, 30 Mar 2022 18:27:58 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 217.111.95.7)
 smtp.mailfrom=arri.de; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arri.de;
Received-SPF: Fail (protection.outlook.com: domain of arri.de does not
 designate 217.111.95.7 as permitted sender) receiver=protection.outlook.com;
 client-ip=217.111.95.7; helo=mta.arri.de;
Received: from mta.arri.de (217.111.95.7) by
 VE1EUR02FT011.mail.protection.outlook.com (10.152.12.150) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5123.19 via Frontend Transport; Wed, 30 Mar 2022 18:27:57 +0000
Received: from localhost.localdomain (192.168.54.86) by mta.arri.de
 (10.10.18.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Wed, 30 Mar
 2022 20:27:56 +0200
From:   Christian Eggers <ceggers@arri.de>
To:     Ard Biesheuvel <ardb@kernel.org>
CC:     "Russell King (Oracle)" <linux@armlinux.org.uk>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        <llvm@lists.linux.dev>, Nathan Chancellor <nathan@kernel.org>
Subject: Re: CONFIG_THUMB2_KERNEL=y boot failure after Spectre BHB fixes
Date:   Wed, 30 Mar 2022 20:27:56 +0200
Message-ID: <1896453.PYKUYFuaPT@localhost.localdomain>
Organization: Arnold & Richter Cine Technik GmbH & Co. Betriebs KG
In-Reply-To: <CAMj1kXGbNtJPEowha8=vFgjdv_m2viHJ2Q7AqtJeqOPLa8-1Sg@mail.gmail.com>
References: <YipOoAaBIHjeCKOq@dev-arch.thelio-3990X> <10062923.nUPlyArG6x@localhost.localdomain> <CAMj1kXGbNtJPEowha8=vFgjdv_m2viHJ2Q7AqtJeqOPLa8-1Sg@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Originating-IP: [192.168.54.86]
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c1d615a3-8e94-4cfb-f55a-08da127b03a5
X-MS-TrafficTypeDiagnostic: AS8PR07MB7399:EE_
X-Microsoft-Antispam-PRVS: <AS8PR07MB7399C9CAFD62CD45107452CFBF1F9@AS8PR07MB7399.eurprd07.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GfTqCbK9Fvw0Hq4l0yF4PkTlnYGHGLPW/bOAplUO9+KS4va+x0n4ydjV4ALynKIyad3FGx9Q8Pfesxi2ToA7oVPh2rpPnZRjhpTsznrYVjq9M/biQYwbcFX8KRnreEPQNV0i8ndYA8/ljHYl+NsStsM1ValuBfMX7mB8bgdzlKNA6jBBxha+nd87Y8SJGWDiIgWK1LRI5XoPP7P2SYL1xDv0hY83gEqL6gP/q5jesoId1v+bEmshvKt33DfuRCTgaM2PLnUTWbdpr1ucOBWvs//c1xR62RpCV6fLNqKGlYrBmlBO/uVi+E1FTuXdRebYCLQkvcw07Fy4OAeJQ69FywPyRyooK35Ww3tOvOFxnWFMe5OfHXw5aCVsqh0S9TuDxYCIIJHhDPZTsDD4YEVqf+I6T2y4n4fxGgF9nCE7hHhVNVu4VujltN5eJrKbu6KrmEj5EGvSoLOV85+BdsAevqtqXi9cqI8F/lKVAggk7yjw0qbgQ5J+Y4dIu+jDnU+AH0y6AHlS1oqZ9rNBM6ZFP2om6G3290AJ4ixpeSdNJ1KIdv5aGOLuMO/Cs5Ds7NPIC1o+hLh+MDrWE4FqUJz7GNJ5zUWinJkqmVsp4sj91uHSxpg9cdN5at2IkuD//t6Ica65mCp9pecx0kmqbnFm/wy+bSMVxWwxYf3rla5KFQZ4ps7R6ZQvhZ+ROphmesQ9lWGSA+kHHfu1RlUCPNaM+w==
X-Forefront-Antispam-Report: CIP:217.111.95.7;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mta.arri.de;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(40470700004)(36840700001)(46966006)(82310400004)(70586007)(70206006)(4326008)(8676002)(316002)(336012)(6862004)(426003)(16526019)(186003)(7696005)(26005)(40460700003)(8936002)(4744005)(36916002)(81166007)(356005)(5660300002)(9686003)(83380400001)(86362001)(2906002)(508600001)(47076005)(55016003)(54906003)(36860700001)(36900700001);DIR:OUT;SFP:1102;
X-OriginatorOrg: arri.de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2022 18:27:57.7363
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c1d615a3-8e94-4cfb-f55a-08da127b03a5
X-MS-Exchange-CrossTenant-Id: e6a73a5a-614d-4c51-b3e3-53b660a9433a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e6a73a5a-614d-4c51-b3e3-53b660a9433a;Ip=[217.111.95.7];Helo=[mta.arri.de]
X-MS-Exchange-CrossTenant-AuthSource: VE1EUR02FT011.eop-EUR02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR07MB7399
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday, 30 March 2022, 19:42:31 CEST, Ard Biesheuvel wrote:
> On Wed, 30 Mar 2022 at 19:33, Christian Eggers <ceggers@arri.de> wrote:
> >
> > I just switched to v5.15.31-rt38 which already includes
> > 6c7cb60bff7a ("ARM: fix Thumb2 regression")
> >
> > This kernel boots fine now, even with CONFIG_HARDEN_BRANCH_HISTORY=y. After
> > applying the patch series from Ard, the system still boots fine.
> >
> > I haven't any understanding what these patches do. Is there anything I shall
> > test?
> >
> 
> Thanks for confirming. The first fix affects all Thumb2
> configurations, my patch only affects Thumb2 configurations that
> actually enable the loop8 mitigation for Spectre-BHB.
> 
> What type of CPU are you booting on?
> 

NXP i.MX6ULL (ARM Cortex-A7).



