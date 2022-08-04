Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 359E9589A48
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Aug 2022 12:08:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239349AbiHDKI2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Aug 2022 06:08:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231805AbiHDKI0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Aug 2022 06:08:26 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2073.outbound.protection.outlook.com [40.107.223.73])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6B901A823
        for <linux-kernel@vger.kernel.org>; Thu,  4 Aug 2022 03:08:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jZ7ZQ5JUGLu3SWisACyA0AGpnd8lGPT2ThlBf2qMwPzeyAVFWvDMFkIYXj6cV93vAQH9p2kdtXSYCY0Olrsk0jkr4pdua/lgPZnRRYrqxzeEN3pknVLNosMtNKtLGrEnuN/YLowDl5Eh19XzZEPPqt8PmK/gMGC4VpQGAuW5LdLPVFcDrXOlZcCyW3lrx8MCVoewV8v/GU76uMuiOB34sypfT25Eqcojw5a+gkt3R3Q5sW1/Su7JtCrD1osrnNt+Q+ZUklvriPHuXVOppUozL68A+sZKQKLk3PiQJUdOrOogciFSkNCB/AFP1U9TMuktwARBklmAiSi+s2Pv3NqbaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Up9ROtzAR1j7A/v3gAAsf+SQE4/vYO+w5+Mfwz6QWR4=;
 b=SqUAenJ9UgRJeShaS8gRS/oC7f/lTtU/h2lc2lnGXoF4fw9Hma4IKGg/Q/rjxdoGlWzTnem9r1i5/UIZEzHAoM15MGMb8cUdDSjsZrSonfqaHSCM5GwLu+beexiwVbux96FrvRm/Dg5Qi9hBzDqFAS+Tk+cxIjFg9IA+gSSX1JbpkFPa/T63Ldd1MFqvRvDvvG+9VPKAFjDhix9b4Hdizs2atmRM9gGXMWWXUMV7x+ga42mDvkPj5bGfGb5bAEcnra1KAYaFOGaaFfAlRRYZRlmHflB3mQcE9E7QgqJIL8oisd0g03e2B3DidQmGmdqMxBEOmrgihkww+YSkBoMTFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Up9ROtzAR1j7A/v3gAAsf+SQE4/vYO+w5+Mfwz6QWR4=;
 b=PCyF/OAOGcqIW0Q22keKi8Kh9RgSk2TvMDqIiULD8SyBJCci/zindUYFEKQweKG0cETbxc3WfSaYxp1S2NKujtwX0CnTPaxH8KXvUadYKiM2expIh3MbSjJdL3dT2NxomIqrQQy8/Dvfe/dHmDJ4va6v469jKJYiH2fwgwEzmuqCRsF8D0zX9G4HzqhCy5zTyjzjiTL/E54IWcnCU8at8P/u+PKa3fEgn/4TAp/hoVK47rgJqNbQMRblhhjmTby9LLCQpPYNSlfTtU5Qqr4Q3h33ACSW+eV8zYz3fWJuBIJA2hgCJSMSxJEwQkUBN+XQCuzBnS9rGUTNWbD1HATAGw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BYAPR12MB3176.namprd12.prod.outlook.com (2603:10b6:a03:134::26)
 by MN2PR12MB3888.namprd12.prod.outlook.com (2603:10b6:208:162::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.14; Thu, 4 Aug
 2022 10:08:22 +0000
Received: from BYAPR12MB3176.namprd12.prod.outlook.com
 ([fe80::eca6:a4a7:e2b2:27e7]) by BYAPR12MB3176.namprd12.prod.outlook.com
 ([fe80::eca6:a4a7:e2b2:27e7%5]) with mapi id 15.20.5482.016; Thu, 4 Aug 2022
 10:08:22 +0000
References: <814dee5d3aadd38c3370eaaf438ba7eee9bf9d2b.1659399696.git-series.apopple@nvidia.com>
 <20220802171215.3c909e1984ec345ff94af155@linux-foundation.org>
 <87czdg7tlt.fsf@nvdebian.thelocal>
 <4cfb6fd5-f820-b56d-bbfe-13c92a5bf682@redhat.com>
User-agent: mu4e 1.6.9; emacs 27.1
From:   Alistair Popple <apopple@nvidia.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        jgg@nvidia.com, minchan@kernel.org, linux-kernel@vger.kernel.org,
        jhubbard@nvidia.com, pasha.tatashin@soleen.com
Subject: Re: [PATCH v2] mm/gup.c: Simplify and fix
 check_and_migrate_movable_pages() return codes
Date:   Thu, 04 Aug 2022 19:57:21 +1000
In-reply-to: <4cfb6fd5-f820-b56d-bbfe-13c92a5bf682@redhat.com>
Message-ID: <87zggk5njh.fsf@nvdebian.thelocal>
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR05CA0059.namprd05.prod.outlook.com
 (2603:10b6:a03:33f::34) To BYAPR12MB3176.namprd12.prod.outlook.com
 (2603:10b6:a03:134::26)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8cbda487-2275-475e-d2ce-08da76014311
X-MS-TrafficTypeDiagnostic: MN2PR12MB3888:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Ag4cKtxasDsMrbDKeYsVLRWZp/C6wcBaWZBLJaKCfFlVJ87UDIgLrUEAugEn7s+oDQgOagTaUfwkVjjX3VPM7HqeQf7vPY7spOKKg+oa7LcfO3gep2ux+aOBcUAHRL1XZCLI80dMY8ByY9ma6JuCkt1AbzyxmHxIiTb6e8xXcjfvmNOerIm9KJ56HhJ7qDyHucbGGTfNS0CPialqaS8fI4zjJJVLJShMCeA4gFWOI6xVO4eDa9q51bifqG1mmSbMVZiQWGTn4HwUeIgzpvSFdFJm+663q2BS2MTTUUheBaWOBCpXnV3f1nYk7JMM3LnhECGB6lbHjffOHrsIU71HFR3oA9IB0KzfTMe8SBTY0rDb8ytA0HLjsUhfzmg8+8gPbCDTBFQjf/qgXxJeWXPzsKiF9J8ur3UYwHCugHEi3M5slvOFud5eFOvMBbIz0QGrrbybPYhrZDphryPUCfpnR8TD1kx9cXciKjWVn5gz4dz68FeGM+q8Et5BgquygE1BLxmCcNs6DsmI+zZAXonb/0bXQ9BmKabYlJxHjEfszZsGJr71Ya1Om9NQ1yxSweSDSONsOXzNJJK5z7hnFucpkAHERzgWGLCSzS3HiyyXE3gzxgfDiIRARBb6PVIRhz909a76LqKQcF5g6GDn03LKVoqAC3VHcX08HL8Wd2k6GFe5BlG+OtBA/2EgiuoipVsLo0bQtQTNO26pXOty95utfq5XfYxFLBIIfYK4cCnaK08RRqFPgZhyqOiYW5B/CFWcG66UK3cVs6XpmfN3ucmFsOEY3r+1wZfHx2KHoKKoWbUm8Pqgt5mbzL/M/Yowtj4K
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB3176.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(376002)(346002)(396003)(39860400002)(136003)(366004)(6916009)(316002)(86362001)(38100700002)(26005)(6512007)(9686003)(4326008)(66476007)(8676002)(66556008)(66946007)(186003)(5660300002)(966005)(6486002)(83380400001)(478600001)(53546011)(8936002)(2906002)(41300700001)(6506007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?0/9IzB2bRptWoStrWzfJwZz5j63sTcvD5SfDm/7/rLp7KYpdlWbcEI8E3MYp?=
 =?us-ascii?Q?B9tcq7du6lrd91y/QEU8OfG3Nj2ioVhl9k5eBdQwWwokEDHXKT4A3NIF23c/?=
 =?us-ascii?Q?zM65z3rM8W4T48FiIa4StJgbtrMwiQmo1hQ4kXWafL3cgfpn8EqtvtDEnrps?=
 =?us-ascii?Q?Vx7nf8n2wwq4ngUgBdqLbR+oxSLjqNEkndRzMtkrIqa64ulV7dCjCQnplI/H?=
 =?us-ascii?Q?0Xmczvq5MG9EiXK/vdnz7J5HSyXLd/DlIfwlkKe92wehgeDpifH07HW0JTVi?=
 =?us-ascii?Q?xiVJ1dH+nqeOFS4IRr8UNZ/wJq5bRRinbJXudcAtzWyQpy31cGgflJKIByfk?=
 =?us-ascii?Q?UxcZ0AGhDO9dbTF4e9QG1cOgk4xfKqDUdAg2MAP/O5eVlcmKrBSObWHzLhBN?=
 =?us-ascii?Q?QnQwPd+AJl2muwP3B6lB/1RQim8GTVGW299l2JNG0hmh4BZ+CUd5Z9VeYySr?=
 =?us-ascii?Q?Yjzqaeu56cJgnJVcZzhZdBwE/RIn2g4dn1sjLWNVRgG3nUDTNUueL+UKGqsV?=
 =?us-ascii?Q?3kAa7IGnKnJE5W7b9so/pps9M22Eb8RQw/Avw/V1T/5fTnFuhxDDbOtkXYRj?=
 =?us-ascii?Q?UEy0N9UP3XtkC4P43arki8uSD1YGCYzAmzSBTXTFcUwu5XN4uOVhaYm98wbF?=
 =?us-ascii?Q?VLEPPgmexCY+NEsvW5xsOzP96Xp28/1pCHrOtLEfnbqQCefInEjb+9rpClrG?=
 =?us-ascii?Q?EV1Su4pDfSOAmkmuqhmJ2/J6uMVxri+nGndtsD58SC305NmHEffsZEfZXVLk?=
 =?us-ascii?Q?AGbG0sgLHxoooMOoEwTfY2GimllCqg26DEmF775GqepQBoj7CTtX7NIZiSEu?=
 =?us-ascii?Q?+Qmn0efztGBYV2Kcn5/9gemOy84Oyk77A+9gYIGtzDJa51L8qzAsjUQ77ENm?=
 =?us-ascii?Q?oBGPPtNqBlpzqay82Jn8iX7bNN73yJWKytA06DYwK1JnB2pGtI5x/3oCJrFx?=
 =?us-ascii?Q?7ylc4VHZ+yGT6C+JosUlMOkn3uf6+0nBUQVBODYzJ+oQNQrrEAMS9TItKH/B?=
 =?us-ascii?Q?nHze9XQVI8jjCOfNIHykBTyN0JEnVlpNQgHW7HuF/sfeVl2G6hOFjEgsjp4L?=
 =?us-ascii?Q?+FmYXltTsZusiaZrNc0WJjNvsF2ZJ//geG8r8EYwEL8tLy+YyzKM7DamrCuT?=
 =?us-ascii?Q?r62b8G7z+TvUR2Sk56Sp+IQ9t3/hshrq/LnOpa9lFZO1VNNKdB7GH0QhzTjz?=
 =?us-ascii?Q?krIdKNxAUCkE/BS69uHE3wSJKrjtmbOTJYmNmKUkMd4qAr5KuX9HuHTqKtVQ?=
 =?us-ascii?Q?l9U8WntqiCMBb/Qj4mdVep33b/u3WfngY2YHfVZVdTOUCVvSBfKQnMyVCBHS?=
 =?us-ascii?Q?TUMdI6UqHUlgJYMJDIjbAd14ofrYCvk8JD/z5BI88RvP1jCTqDqpeFZuJEPu?=
 =?us-ascii?Q?BaMEC1BN+j31HvF3GrthIkZ4XSPfElDn2bn7E0d7o3HyB6ei0AcUS/sZCi0w?=
 =?us-ascii?Q?ILIHahFr84D0WCtDgpeEa6+S88wa6RAW5t219aa0p1YC09QGhp8sTlLLEmVj?=
 =?us-ascii?Q?3Cw+Rle5m3yoiRF/vlEA0zN0tAt6MieTwwdhgWfsUrNz2dK/oVfAp4/8qJFJ?=
 =?us-ascii?Q?8cS34RH46q9ST+Mc1ZTvvMwejlAza/jKG7H1ohvn?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8cbda487-2275-475e-d2ce-08da76014311
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB3176.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2022 10:08:22.0507
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qplRWtDbglWf7QjwlFi2Enm0F3htgqXmWFhP1jaWIXFrdVhXKo66h69gi69TrmDdxcHFLD5tIBKcABoHxz1BmA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3888
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


David Hildenbrand <david@redhat.com> writes:

> On 04.08.22 02:12, Alistair Popple wrote:
>>
>> Andrew Morton <akpm@linux-foundation.org> writes:
>>
>>> On Tue,  2 Aug 2022 10:30:12 +1000 Alistair Popple <apopple@nvidia.com> wrote:
>>>
>>>> When pinning pages with FOLL_LONGTERM check_and_migrate_movable_pages()
>>>> is called to migrate pages out of zones which should not contain any
>>>> longterm pinned pages.
>>>>
>>>> When migration succeeds all pages will have been unpinned so pinning
>>>> needs to be retried. This is indicated by returning zero. When all pages
>>>> are in the correct zone the number of pinned pages is returned.
>>>>
>>>> However migration can also fail, in which case pages are unpinned and
>>>> -ENOMEM is returned. However if the failure was due to not being unable
>>>> to isolate a page zero is returned. This leads to indefinite looping in
>>>> __gup_longterm_locked().
>>>>
>>>> Fix this by simplifying the return codes such that zero indicates all
>>>> pages were successfully pinned in the correct zone while errors indicate
>>>> either pages were migrated and pinning should be retried or that
>>>> migration has failed and therefore the pinning operation should fail.
>>>>
>>>> This fixes the indefinite looping on page isolation failure by failing
>>>> the pin operation instead of retrying indefinitely.
>>>>
>>>
>>> Are we able to identify a Fixes: for this?  Presumably something in the
>>> series "Add MEMORY_DEVICE_COHERENT for coherent device memory mapping"?
>>
>> It seems the infinite loop was desired behaviour so I will re-spin this
>> as a pure clean-up.
>>
>
> How can the infinite loop trigger when we allow longterm-pinning the
> shared zeropage? (note: disallowing that for now was a bug)

Right, I don't know of any other triggers so based on the discussion
Pasha pointed me at I think the infinite loop is probably fine unless
there are other bugs.

Apologies I should have copied you on the new version which is just a
clean-up now -
https://lore.kernel.org/linux-mm/20220804032241.859891-1-apopple@nvidia.com/
