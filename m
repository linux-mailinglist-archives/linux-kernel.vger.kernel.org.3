Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3AF4F51926C
	for <lists+linux-kernel@lfdr.de>; Wed,  4 May 2022 01:46:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244368AbiECXts (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 May 2022 19:49:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232653AbiECXtr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 May 2022 19:49:47 -0400
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam07on2056.outbound.protection.outlook.com [40.107.212.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8306429CAA
        for <linux-kernel@vger.kernel.org>; Tue,  3 May 2022 16:46:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RhiyMucqYvrnA/TJb7ILPsYQQdpfkJpUSOWQdxmvpgT9XEC+KtvJ7+mxbBcQ/FdjMokZbhKJAbmWDLG0fHU01kRRM95nFbe5bCYr9rL/tAUS907f7mJYtBEBQ26QyPC7Sni1tpBoqUDejEkxWJzm/T1MuCYw0/NqKsfGAkKpaUsLzRQwZHq+7meHlT3sX/c1nsLBBmzttgjPOhsyREC4biTXos5J+CiC8RWptDKvAwFIwEqWXGQDxdNXiQvv0UTz9e6Ihxym3rE70FdqHFhoIW63GTV6kaRR1APmImZYYJXnCdtPbpEQxwsk2plnG0Kh2mf+pF0qs/gweUGUWxqAxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dCnw1llZv9PeQUxzbu8LuvQQ1C+IxDladDLcbz1XjRk=;
 b=InnkxLCq8uh01ZypFc584Ydlu2mz4tIgJX8VqDEnfeFsZytjY9Kl8cMN8OWXOfrFsWG/oIXTwTAue+Gmt+2Gua9pfl0tXulDbwpWB11obo2opf5WQT6jRfcNQKzl0NGASNVl/N+KV7hhjHgUyilFubGF+TCnEtlS794QGMmBSCb1tf2afPHzIpLOUS9UcDnuegiSUzYdeQEaNJu59kFGDWflE2qEr6e01hZNJQ21pVgH0ANQrYaKSZPUjQ+fh/3/nIR+M6WLf6cf0gkIsNgesQsKtq2mNTi5KXQWGDovbty2gTpi5kj8c5cx1N3dtDdi53x5SyHS1RznIFIuOrBDcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dCnw1llZv9PeQUxzbu8LuvQQ1C+IxDladDLcbz1XjRk=;
 b=JTEQz7jEEBNZx4cjbzwzawtVhGSC5myQxYpxjkF4ZeYT38vJyFhAV9xedXqTphhHcLaBHGFMHpwLo+8yEujm2S4/uJzCrJnFfI7F4/E5lvnfz/TCmqm3fShi67a54KU9MPPK6nzjVzYKvlcU9WwHZHHKT4VxKF2/4sq4WMakPNdUJfUKQPIkwYWSz/1pkcwVAS0poNUyr8Lnwat6l3HyyzN3d4igw5KmgdX4poQINl65aU7RWKXJwtniLLnPOQ/+p4zRILJb4Pbm2bLUKYuN8T9S7KIcf5zZMX2qy4vINM6y3urI3G9A4GYBeJffr6g0wiRa7xegfXvsEUO/PX1img==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BYAPR12MB3176.namprd12.prod.outlook.com (2603:10b6:a03:134::26)
 by BL0PR12MB4722.namprd12.prod.outlook.com (2603:10b6:208:8c::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.12; Tue, 3 May
 2022 23:46:11 +0000
Received: from BYAPR12MB3176.namprd12.prod.outlook.com
 ([fe80::2d17:b68a:e101:4c18]) by BYAPR12MB3176.namprd12.prod.outlook.com
 ([fe80::2d17:b68a:e101:4c18%6]) with mapi id 15.20.5186.028; Tue, 3 May 2022
 23:46:10 +0000
From:   Alistair Popple <apopple@nvidia.com>
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     Davidlohr Bueso <dave@stgolabs.net>, Wei Xu <weixugc@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Huang Ying <ying.huang@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Yang Shi <shy828301@gmail.com>, Linux MM <linux-mm@kvack.org>,
        Greg Thelen <gthelen@google.com>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Jagdish Gediya <jvgediya@linux.ibm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Michal Hocko <mhocko@kernel.org>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Brice Goglin <brice.goglin@gmail.com>,
        Feng Tang <feng.tang@intel.com>, Jonathan.Cameron@huawei.com
Subject: Re: RFC: Memory Tiering Kernel Interfaces
Date:   Wed, 04 May 2022 08:35:56 +1000
References: <CAAPL-u9sVx94ACSuCVN8V0tKp+AMxiY89cro0japtyB=xNfNBw@mail.gmail.com>
 <20220501175813.tvytoosygtqlh3nn@offworld>
 <87o80eh65f.fsf@nvdebian.thelocal>
 <e47bf89c-cee7-3006-5c1b-c76f640c3e23@intel.com>
User-agent: mu4e 1.6.9; emacs 27.1
In-reply-to: <e47bf89c-cee7-3006-5c1b-c76f640c3e23@intel.com>
Message-ID: <87mtfygoxs.fsf@nvdebian.thelocal>
Content-Type: multipart/mixed; boundary="=-=-="
X-ClientProxiedBy: SA9PR13CA0051.namprd13.prod.outlook.com
 (2603:10b6:806:22::26) To BYAPR12MB3176.namprd12.prod.outlook.com
 (2603:10b6:a03:134::26)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2fb01e51-a4ab-408d-ad3e-08da2d5f19aa
X-MS-TrafficTypeDiagnostic: BL0PR12MB4722:EE_
X-Microsoft-Antispam-PRVS: <BL0PR12MB4722E76DD0F6A3FA8827E574DFC09@BL0PR12MB4722.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DJocxAp+NM/3tX5KAP/ldE3fXHn4Fwul27EOATPsSWpzgRMmGbrQlCSbzAP7fRjdllA4bwQfcc1RZjl3r+6I/xwsrx+M9DgMDNMGJiXrgVmsPGe5EHlSpATatBz3eNceUNcSUmfXvTIC2wnecNmFrieZ/vv/azZy3oGsG16LLztELJLtAeMPnf2fplbTT7eV8RhlcTE8VkfIZPNXdHuZJjQYZ+DiSyTLFl+8Dlu4BLJbXOtQmijlYJBimsK9Gt95IAtjgd+nIiOHDQwY7ehxNEyU4M+6AO/DKEF4YX186P77E2An/NNfaAJLJwzu4LXJtPsjDfeKoVaj1Z3zi0TyDKsJjb2bTntCBk8V4Ox9AB89fcBNW3N05WgAyWoq8mgLZLXooGQ8oL2sLhX+XhH8pqrC5vGtb/RhH947+tXaFJjvD7GC+g061iPs13u69CwFxXRMgNzObHp/a/D9vBtoe15lgtPF19qhuw9n25cE4Ftc+Jw2QK6zH78QB+fiWw9Nm5HZMhcVr3fwSHUpARHDmM2osNRs6aC0e2Iex0se2uKCtQaiPg1QtAjkcVgopePYxbfk5wZ+58MX7FIaVtPMHzz4KIu1v9m0Ql9cGARCHiD5V3WrtWIPF9NJTg0V0kQ/692cn8v3juWBGldAFgQ//Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB3176.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(508600001)(86362001)(5660300002)(6486002)(8936002)(7416002)(6506007)(53546011)(44144004)(6666004)(2906002)(26005)(6512007)(38100700002)(83380400001)(186003)(66946007)(66556008)(66476007)(6916009)(54906003)(4326008)(316002)(8676002)(9686003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?uzIscV1rR3X1UvXiE1FplspUwW5nGRFlPobhFmDq/3f51PJPKkrnTaAZDC/Q?=
 =?us-ascii?Q?lLzc0Pk4vyWpGwPatWLns0LzCtMdgZ5GA3dxpZqAeuv+etMcQKoz3X/VLLYm?=
 =?us-ascii?Q?UWPaOnBgeDvMQtwhCpZjDc/5LMtSXngCKwJeX0zU4xcFQEcM/Ot/oviZR1Gb?=
 =?us-ascii?Q?VmalkKBmuAoVLNbkv8eWN2hqX/BF8VnismouR7oymkeYsRwPRQ3jEBKXfXXr?=
 =?us-ascii?Q?aBBuowJUog0vdR6ZjrZUu3B5yz/sVQju+olJzF+UnzwerYTm+5qrH6ssQ43s?=
 =?us-ascii?Q?S9mtPZYD0LbmcZGFdFvt4TzWdqcOvUMCIPGLOrFL24vzqWe5xXmJ28tXau2w?=
 =?us-ascii?Q?dYtBKEj4QL6fwKa7B4cZ2qOJWHaLISI3bKou2Hg1/MaY1LPTKMnymdzSRMSf?=
 =?us-ascii?Q?nHjaBQ0EEqvC6CX6pFno7aMtqjqybJlMG2gjhavKTPigj4dCKoG+miJg/lWX?=
 =?us-ascii?Q?VK1FVrsRWQMSd13B6MMTPGBBKSOuHo25hxKsqNEMyVdNHRVX5FkjT28gJpfK?=
 =?us-ascii?Q?LWFzMhRx1b4rZ3sDzALZlJe3O464o/Wn29LnU+bAkTJ+GdS4RdQ88OaH+9EH?=
 =?us-ascii?Q?onp4PWnNq6MPg5stwbjdsdwpzNfQ4FBhV7sfPPDZMvXYCTwmnN24KwoO8Xk9?=
 =?us-ascii?Q?EOYfKXSyX65qgMF87elDGzn4gWVfT7eT+5UyP0emuJXdJTPENnI6Dr8eWv7b?=
 =?us-ascii?Q?aMQkPCNUjp4qTywumS1xuzlPyfhLEnsaWAp+BimZp7TQlWAu8i+V5ZYTitBN?=
 =?us-ascii?Q?wDJAKzngSJwOGfFhinyKNFmxqPK+1rAAOv/vgr+zyuGVtO5m409ed0HjrNhY?=
 =?us-ascii?Q?1sOjzsCwnds+QYd9Po0Cc86rCe+LZCL6duyirpdHpcrxbXthVwndsqIU8OA4?=
 =?us-ascii?Q?3kYdYpf9mcrcjPLz+2My8v4oP/mcgtOTGodbQ9pZ/8i/Gi7nKrLCLvv9cHhL?=
 =?us-ascii?Q?01/gOBz581UtSxKlz1sYEgc0IrUz6my9ACs8o6Up8rIz1Rc1mpBkN8/DeZCx?=
 =?us-ascii?Q?Ut9noJiX2GigKpaq77BEVCjJvxjhwOi7Pn5MB5bGqDFitgDZo/nYcJE7/+jr?=
 =?us-ascii?Q?Rh0IPhNK0LSlJOShH8Fx7svFVxDsi/xDccu15WcpZ8XuYiUkz0CIKghrzAHB?=
 =?us-ascii?Q?Dlwxn5HYliQ1bEoVnqdZD6zJ1KQ98N0N1TZ/Pruvyl0Y3aNA7fMucPKyWAH2?=
 =?us-ascii?Q?hROFaud9v+eBHbYUGq6VjH1azsm0AIQ9Ipjznkke4TSX/uIegZdVFZN6nrn0?=
 =?us-ascii?Q?sNBrgQhbvZct2HJSNWZMwtZ/l6l8PKEmk4BY0Itrm+WIdW/TjcEBin5u8ul/?=
 =?us-ascii?Q?SHkks8YA2MSH+5YVfKBHcHJZm1MEwHyK2XZOuAVYjWGAiH2CetlkSsP7lPIw?=
 =?us-ascii?Q?IWw6wRefh6iOc4p/AnRt4GXWUbJgFymevOu7kAoWNbysLSNXlcix47CAwKJ7?=
 =?us-ascii?Q?KW1kULCfOf2bFQp3qGuRrOgNvCqoK8dVq47HhWZP41AJwz3I8ulHshmqTD9F?=
 =?us-ascii?Q?92fZsc5dEE0dwu7XU43t8lV7/WOjduX42OHBQa/m2QL+Jmn8WGdlYr3nhvSy?=
 =?us-ascii?Q?eA81cbynzCN6gm7zOEgILDm19JFBUP9oD9HSuR1UlaBhwZ2S+d4BleD+Q8hk?=
 =?us-ascii?Q?FDzYiP1NorhpVAcCNWMjJ8PwYfGCp0HuYOPG+vN+V39AuRp936bcUJ2dnk59?=
 =?us-ascii?Q?FCAy1Bs/aaYvXlKbq75060+n1SI4+kYgCvq5K3j8I2FJsQDPcWk0bL2G67CT?=
 =?us-ascii?Q?PNbidWeAxw=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2fb01e51-a4ab-408d-ad3e-08da2d5f19aa
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB3176.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 May 2022 23:46:10.5073
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NxNl9kH4NlgtZGgeeclXBXs2XNjgMpoyTDO1IAtCrQUyDwiDYFocudTkdj1jeWQ3LzjWkZAOKTtRVQdj+LKw0w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB4722
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=
Content-Type: text/plain
Content-Disposition: inline

Dave Hansen <dave.hansen@intel.com> writes:

> On 5/3/22 10:14, Alistair Popple wrote:
>> I would certainly be interested in figuring out how HW could provide some sort
>> of heatmap to identify which pages are hot and which processing unit is using
>> them. Currently for these systems users have to manually assign memory policy to
>> get any reasonable performance, both to disable NUMA balancing and make sure
>> memory is allocated on the right node.
>
> Autonuma-induced page faults are a total non-starter for lots of
> workloads, even ignoring GPUs.  Basically anyone who is latency
> sensitive stays far, far away from autonuma.
>
> As for improving on page faults for data collection...
>
> *Can* hardware provide this information?  Definitely.
>
> Have hardware vendors been motivated enough to add hardware to do this?
>  Nope, not yet.

Not entirely true. The GPUs on POWER9 have performance counters capable of
collecting this kind of information for memory accessed from the GPU. I will
admit though that sadly most people probably don't have a P9 sitting under their
desk :)

For various reasons these counters weren't exposed to the kernel but that's
something I would like to work on fixing.

> Do you know anyone that works for any hardware companies? ;)

Maybe ;)

> Seriously, though.  Folks at Intel _are_ thinking about this problem.
> I'm hoping we have hardware some day to help lend a hand.  The more
> hardware vendors that do this, the more likely it is that we'll have
> good kernel code to consume data from the hardware.

Agreed.

--=-=-=--
