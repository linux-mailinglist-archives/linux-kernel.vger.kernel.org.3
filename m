Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F1124D6912
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Mar 2022 20:27:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351103AbiCKT2o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Mar 2022 14:28:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237286AbiCKT2l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Mar 2022 14:28:41 -0500
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam08on2099.outbound.protection.outlook.com [40.107.102.99])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47CD93EBB5
        for <linux-kernel@vger.kernel.org>; Fri, 11 Mar 2022 11:27:37 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=krkty5AqTL6OiX6oYKkZWthD01r/Jwr5Rw7SZampUk+RUzeI35A0wdG+dG7K0oHUHo7aBO7vPQrUKf2NvW0bIE82mK0yaAag5NLiSE7zo6AULraWgV0VWxJr//gfWJb/fsrI1m4b5G6XwLrrmqhwHUFABiclbkG+mD20NdRQnoc7ip3xeGssZIECqSLMg1x4yFS/gqSIFgvxGGJAf+qVpufL9ExgAOvUD8w2ATZ4j5bcaPS1X5byq/Ko+oOtTttkxLGwGTvrQINtSV8awPNqQzyY/dnjbkWE16PcNRnM8v6Du8n5niJ59L67399p0t4uxA3e7aXTCijSFhM71Vn7xQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o2Avsal2zREpVmvhx/S5gPvvASZLuqDo9bP42a6Yxio=;
 b=T3e2gnrYFVyeVfsDuTPQXoQaFNadzuxZhIg7nv4ifkzTnSKbIarWvmK7LeI41oI4Y5QmmxgLVXA4m83VxAxazs4E/iFdr/yQBWRY5YC6sBOY8VdoeAgejy/Vhs958BEJhBG5IHIT85Q+8zkXqHHzj4aYkU/oI3su3s/rOF64d9cEKoBM+K7kujSmnZJQj/Px9XSyeb4wFmeigX9CXGAAsyRRH3yYkAso6FphyMZ2INJrKELYWv+kwwA+b7GkGQyzxhV+bM04mo/KZ+x8Rdt4X4oCt4VUax2WA9vFYG7MapIoBqKhNO99iKiXrxhhDrchenuhlX+0Bse8EIzHpqS9jw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=in-advantage.com; dmarc=pass action=none
 header.from=in-advantage.com; dkim=pass header.d=in-advantage.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=inadvantage.onmicrosoft.com; s=selector2-inadvantage-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o2Avsal2zREpVmvhx/S5gPvvASZLuqDo9bP42a6Yxio=;
 b=ppSqnF8ZbSPvBlJZkJFgfzn9XAZlNq4McFZz6R1qc0IZyo7kl/SyXagDSnmTdJDYPshCNCzJKeF5aGejmI8ZlQrxmlPgr+EB7IlGhryQIPFw5N6yiCsZbaJZrlHLMq+PFWElFQEy3Q37jyp6BqXnSSAb29zYBGpOPkJJZa1hL/w=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=in-advantage.com;
Received: from MWHPR1001MB2351.namprd10.prod.outlook.com
 (2603:10b6:301:35::37) by CH0PR10MB4843.namprd10.prod.outlook.com
 (2603:10b6:610:cb::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5061.24; Fri, 11 Mar
 2022 19:27:35 +0000
Received: from MWHPR1001MB2351.namprd10.prod.outlook.com
 ([fe80::7c:dc80:7f24:67c5]) by MWHPR1001MB2351.namprd10.prod.outlook.com
 ([fe80::7c:dc80:7f24:67c5%6]) with mapi id 15.20.5061.024; Fri, 11 Mar 2022
 19:27:35 +0000
Date:   Fri, 11 Mar 2022 11:27:30 -0800
From:   Colin Foster <colin.foster@in-advantage.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: Asymmetric regmap read/write reg
Message-ID: <20220311192730.GA265@COLIN-DESKTOP1.localdomain>
References: <20220310215408.GA3149079@euler>
 <YitOBbJd4mY3hjSA@sirena.org.uk>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YitOBbJd4mY3hjSA@sirena.org.uk>
X-ClientProxiedBy: MWHPR13CA0036.namprd13.prod.outlook.com
 (2603:10b6:300:95::22) To MWHPR1001MB2351.namprd10.prod.outlook.com
 (2603:10b6:301:35::37)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e84f98c6-d1c0-48eb-2440-08da039531eb
X-MS-TrafficTypeDiagnostic: CH0PR10MB4843:EE_
X-Microsoft-Antispam-PRVS: <CH0PR10MB4843AD69C2D7C8AAEE6FF1D4A40C9@CH0PR10MB4843.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AgVVjz7lTI4lD1xKq7qXCumUjs+jrRj7Alw9jD157zlQkcJKTET8Hlvr8CJN3ImsgRRrwSCd7pUy0sWQ0OllWfUZ34xuP2uwj5xpaGmjpaBUPR5o8bzLkeXXmw+k1JNSRSaxJkOo4ZGyoZrLHBAiepH/yVaTtcaKIkoWvpqxiHeSCklENadfg0AcG6mqJFy/z9zEc8JeCbMdQ9jmBQeAUTNyMf83tonVEjWo3gWm6NkLcSk+lonE5v7QAQ6cHSrG++3ZSUmE/Z3QWqwu08FXpz4WJigKsA5XSfAdD8x8z73vteTZR3xjYXFg9+f7v3IxUVFWW+wq7eIZ9lfG9u66Ua546jqI86FHsiGBwVmjFEE1uCwsicVCL3dWZRy1256CIkvXSXKSe0zaYVDdaOpe74wTlzm1SZxnohbwr5+Mv60h2tIiz6AiB5qKfKRQL4kEMeijh41RT8/r7bz89iJ7twFc5VrNtn6fCM3ZyKgW8FrFIuaQCzpNsIbKVMrJ7PguJaDZREq/KdbqO/pFsA0vScK7bz1pC/w+xWiAy3+COIlfX7Eboa4mlJAV/ax9JeLnX8XoK7A2UQNI8T8A1EIejfxeYT7vYoRcwclSn/jtgYXIpUkou1zLGsyk676iBLZNFOfsCOJpNRVw+wWBFitjlJKqPm3S0wlwkGxgWunwrW6BHkaiPDaP/gARyGxrupZIlFK5bP6gTurO+P3O10HqBA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2351.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(376002)(39830400003)(366004)(346002)(396003)(136003)(3480700007)(5660300002)(83380400001)(33656002)(8936002)(1076003)(2906002)(316002)(6916009)(6666004)(44832011)(6512007)(9686003)(4326008)(38100700002)(38350700002)(8676002)(66556008)(66476007)(66946007)(86362001)(186003)(52116002)(508600001)(26005)(6506007)(6486002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Jcl8erm0IDJJER1tEKhy1lvuZv3FDZwEXfjQHpq+SulMiYgf2hKupyxxrFoI?=
 =?us-ascii?Q?9nC/aXIDNE7rqjMmLb12L4/Q6Mk9TWyb0JOl5JO8+gTq0VsN8ESZhWj4y+Ai?=
 =?us-ascii?Q?0tMy4HkcFnNTwDDBGnnn+ukbucXL2HajvNjI6CKKyXctdmC7+QeB/zg3LuRE?=
 =?us-ascii?Q?NcU9OfZ5NZMX1hpWaDo7CTV20GC9xmo+i4hHcluQ/XeoIEQOrojU/1424WsD?=
 =?us-ascii?Q?fieiW5TdLvr7Atyy3ZYvcoE+VaOJ6HVuxhshhZpUAOIkXS1c2WiWesX3Qf5o?=
 =?us-ascii?Q?Mll17hFKEz34dyGd95PiKbRnZH4orKrxyICLm4hp6q9dotyokITZY3j3Ag+2?=
 =?us-ascii?Q?boSENxo+0ocGltMtasUMGZsZxb2LuvvJf5lp8ZNfHtMDpEm1jLdymdOChaVW?=
 =?us-ascii?Q?ubDqQjUCJhvx7HdpZa8ZjXd1hYvczedCAepdLPuMrOeaEu2XWbGi4SHU/S58?=
 =?us-ascii?Q?/uFoVM0FkpLi6RKPMJI4SIJXQx/3llfeVe3UEc3Ni/nyGDI03wWY2Y9IXhO0?=
 =?us-ascii?Q?1rVL/Tx+jhJ6YHjiimTVtYntji0eH7en4clD6tJha5t2A86Ni5XzqALQg2So?=
 =?us-ascii?Q?YH5fGpaiwLoxm2XTMKljhfsEd606Nxo/mS8XGpvvssAIOiZUy+2/v8CSzHr7?=
 =?us-ascii?Q?w0wCGe4LGpMDpmHHAIILWO4FUvMtNg9uwlZLW7yBt7u5ABvf0WN3NmhXzQWh?=
 =?us-ascii?Q?s8kH8JBE53WCbZxiX93NERvlMdzEBu8sS2XAkgBWc6mw1ALIntvpwRboscNd?=
 =?us-ascii?Q?FSEgJccNaufdpTh0429n7D+8YfCbQrk6SktPv/DYv1HTmeaeewIeD0FPlz2b?=
 =?us-ascii?Q?GiSBHBepBTUY7MuaV9OuGR+lnh13lXAPRTGSz+mN8VTWeUzyLUKQhU8PntM6?=
 =?us-ascii?Q?1WsYikqD9pQemIlVI6XkEYDtmbkTITyFOGgT7rPiFHe5fqc3paKKG0Btwkma?=
 =?us-ascii?Q?wgSnA5IswAk7EsWRBPvy4hPWo/Bp9v0ijf0d8fPYg/xC5kE69MTvEyv1wO78?=
 =?us-ascii?Q?CH1q11LFgrmCQrGbrznEvaaKiwKptSsBxE+boeCGDeQAW0dVtSHqySjTj5qZ?=
 =?us-ascii?Q?OX+sEKWB/fHGzLj3jnF/7D2JF1bAJFcLN6Oxqwz2XJ5u0Ho+PYmYqvOeORnw?=
 =?us-ascii?Q?OERSnS+1WPATuU/lA4kio/uDV1vM/q10DXd5ZAqabN1T6LpV6fhFnbpt+osN?=
 =?us-ascii?Q?1htaZ+DghDgj2wz6/AKja7BHyKPQOV3SZe2yVgNF2EQV4IxoKihD/6AkgCTf?=
 =?us-ascii?Q?WBX+NhosWI2SmBSb4gxwbM4++OsCBdVQQC/9NEibXsgmlCygMk1JnSAXMvKD?=
 =?us-ascii?Q?Pay6UdtfAzKHBG0ZgVprKLyNQ1Gv1xWDBZOvm8oSsiTTi+nInOKoDSMTSmXM?=
 =?us-ascii?Q?UlY+I9Ae2PSTTaZS5zu8eqOSJMdaWJh/DR1lPxVg4jgdDVAIGSBC/NwomGvQ?=
 =?us-ascii?Q?IHi6cpsItYeetpBbCQFiTZZyetWMVj+p9UPKnFnLDeKWPbdWAb2SDw=3D=3D?=
X-OriginatorOrg: in-advantage.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e84f98c6-d1c0-48eb-2440-08da039531eb
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2351.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2022 19:27:35.2288
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 48e842ca-fbd8-4633-a79d-0c955a7d3aae
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3PrpzW87zgkUmLp2lOVC0sXZaQxESnCuCmAtecgaS4SpSm3RkZEpvSLmExqV2K1TljSQxy4JVX9n6QTcl2NoxmZ6i7SYPXBK6m9CO1nJHPE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB4843
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 11, 2022 at 01:26:29PM +0000, Mark Brown wrote:
> On Thu, Mar 10, 2022 at 01:54:08PM -0800, Colin Foster wrote:
> 
> > The Ocelot chip has requires 100ns between address write and when the
> > address is ready to be clocked out. This can be dealt with in three
> > different ways:
> > 1. Use a slow enough clock speed
> > 2. Use a delay between address write and value read
> > 3. Clock out N padding bytes to account for the 100ns access time
> > 
> > Forcing a slow clock speed is obviously not ideal, and forcing a delay
> > between "write_then_read" sounds too driver-specific, so option 3 seems
> > like the best option - especially if bulk reads are utilized.
> > 
> > Where regmap comes in is specifically the padding bytes. Reads require
> 
> Why not implement this using a delay?  That seems both more
> straightforward and likely tending to be more accurate given that clock
> rates for SPI devices tend to be a bit vague.  Much less disruptive to
> implement too.

Hi Mark,

Thanks, that's a good idea. I'll reconsider that strategy, especially
since I now have a better understanding of the SPI <> Regmap <> bus
interactions.

Much appreciated!

