Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F4AA59528E
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Aug 2022 08:33:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230040AbiHPGdc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Aug 2022 02:33:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229684AbiHPGdP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Aug 2022 02:33:15 -0400
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2044.outbound.protection.outlook.com [40.107.102.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A31E43771C8
        for <linux-kernel@vger.kernel.org>; Mon, 15 Aug 2022 17:54:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mlaDNNKbxshJjhInVSht6ctDZXCoPQapOPH4Fy9UgPN2+5Pb2FQAuvHgzDtYaQYMlXX3Ar0awkR/Ph8Dt8QchrFhvmwpO96U3/UP60YgrYzA7/N1h0EwsbQC81WIQ4muNCownPZiFVKgwO49S866xS0ImbmnGhvh0a5wYZ9BUFcDryeVZ5N2ix3Ol/VItjUiLxni5k5NUZ5omog//L2dvzMlQMEpcw1kEvqnW3FHPActMxMOwh5mxeGN6C/M1f9lwWRdRE6wbfYb1FkIAU2tfj43MH2opxNfc4RzcaLQGN0ZmstweKctMPzNz2/J0Gg1RWNtHHNX2yTJLSpmUjWNiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9Xdu99J7cL8+of3s1iMLxJKV8OVZx1n9g6QSOfPM7mU=;
 b=LxcWcC0XKa4gi3pyErWsDdcANDWM0jz6UCzTHhgW98mpul5RMuztLlq7euGTHEnDlB4hkAYdle8wD2ujvpg62GFjuUS53ps+q5wHRzMuz9oRymHT+L1XOtn+LopTtm0AxUPywpxSK25FfhcHckjqZIl+nbWLyuRBjAB94yjuMwrMm2LaN8ap/FlpV9fzW0grX/d72NVxZC8Cxc9yQ86WzsdTfQCQiB+yFw5YeSE2C7gnEMXg1vSmspBBLTM841qVd7sZ4JzXMbssAm6SSdizHNIRxvaUDMuOfUYAU3fMF6LTnvyrucJS6GZFwsPLDbCWvTa5EmJ6fpOI9TK9LXLGsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9Xdu99J7cL8+of3s1iMLxJKV8OVZx1n9g6QSOfPM7mU=;
 b=t/mJm0YsdDq7DquHG5LSAli1vRcIxoDNEM47NJvXRiee1lkovAtkk9uevARWZRYOwW2Mfa5EOj/PKMIE3jiUs6hF1IKF5JNjMeBcdf7mdZ2Ar4Q9yujnSQaNwPR8kQtqVu6Kb88gPlk3+DhAFwl72tQ3Pr2jBRVJmO7Ogo0omlpIMPHgI/+01X96uzUmVf5IL1pqMtaw2fuzpLHieF+zcgGtPtHiTGmA5ChKXqpZMmWGZNcJnZgWkX18OOvo2Xct53Aq81DRlQWXHvJpKYG88jas1qsiRhDGN482hlZ8jVod2U2JG4FDH3Lo+9vVv5F/L7F4b9dYyjgQofTqkEz56Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BYAPR12MB3176.namprd12.prod.outlook.com (2603:10b6:a03:134::26)
 by DM4PR12MB6349.namprd12.prod.outlook.com (2603:10b6:8:a4::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5525.11; Tue, 16 Aug 2022 00:53:55 +0000
Received: from BYAPR12MB3176.namprd12.prod.outlook.com
 ([fe80::eca6:a4a7:e2b2:27e7]) by BYAPR12MB3176.namprd12.prod.outlook.com
 ([fe80::eca6:a4a7:e2b2:27e7%5]) with mapi id 15.20.5504.027; Tue, 16 Aug 2022
 00:53:55 +0000
References: <a9daea363991c023d0364be22a762405b6c6f5c4.1660281458.git-series.apopple@nvidia.com>
 <YvqsoL7fKJzEqTA3@xz-m1.local>
User-agent: mu4e 1.6.9; emacs 27.1
From:   Alistair Popple <apopple@nvidia.com>
To:     Peter Xu <peterx@redhat.com>
Cc:     linux-mm@kvack.org, akpm@linux-foundation.org,
        linux-kernel@vger.kernel.org,
        "Sierra Guiza, Alejandro (Alex)" <alex.sierra@amd.com>,
        Felix Kuehling <Felix.Kuehling@amd.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        John Hubbard <jhubbard@nvidia.com>,
        David Hildenbrand <david@redhat.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        Matthew Wilcox <willy@infradead.org>,
        Karol Herbst <kherbst@redhat.com>,
        Lyude Paul <lyude@redhat.com>, Ben Skeggs <bskeggs@redhat.com>,
        Logan Gunthorpe <logang@deltatee.com>, linuxram@us.ibm.com,
        paulus@ozlabs.org
Subject: Re: [PATCH 1/2] mm/migrate_device.c: Copy pte dirty bit to page
Date:   Tue, 16 Aug 2022 10:51:57 +1000
In-reply-to: <YvqsoL7fKJzEqTA3@xz-m1.local>
Message-ID: <87zgg5uhy7.fsf@nvdebian.thelocal>
Content-Type: text/plain
X-ClientProxiedBy: BYAPR04CA0022.namprd04.prod.outlook.com
 (2603:10b6:a03:40::35) To BYAPR12MB3176.namprd12.prod.outlook.com
 (2603:10b6:a03:134::26)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8b28c564-d6b5-4a02-771b-08da7f21cb8b
X-MS-TrafficTypeDiagnostic: DM4PR12MB6349:EE_
X-LD-Processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4SfwGoqbKu3eO5qBqeQ93Y5wwk0L+P/APE9/LMBpRGHZL7cq9NcP2WW+AuLL0UOTAVwJHTdzgEliHJERKbDO6UJc7S6Z2MQxTyRiMQ2soKU9K0OAu2riQJ8rB/lpjdEHfbiXK1NBRwBFjz7eTOFrda8qBqVGQGHTIA9GO5WPdlZtHou5BLXFylCfFARzLm73dktnyJgKJHSOeLs+zxyR4J6FUoFqpmU7onBmbDP4/mbNTh6a37Ae72s6d5/1yjUhW8lAiIoeFPTCp6m0f2EYhufUveuIuyakFvU0BqkDHVoVOwbzoWUzoOP/73UYkV3Zs0z78WDsce6g7zI/WpDbpL9jiALbv9YbbUrp1CrfoUCRpswu3hYSSuqJvdfJXj/+/LpRLGI7wokmTvN7V+28RGtZTK6qaQptKzjAdpm2J2mp1LJQvtVLIEsJchygP2blohw/kYJVRy4RB6vxPVgO2Rt5uTJtnLMUIXW3BWyb0TBnic3S/M/eXucr4NfxgyfquSe/+TNOMaP9103tndKhxlE2Acha2HkJAXKgYA73d8kVFDm/1fJnLZXBV6cCc5QtY4eu4PHs6kwpd+4tvu6nkBnWing9P0+hTQrRWaNSJtswxqpmnUi9yn51RKrtA+WY0lg3Q1sMmS6boPCoDXosHpfGRoY1DfB0Yv3y9e8t66IRk6Uj324DwylsO7gWQ3WTRcm4ZowJ7q4MqSB3oAsZUjBFZd3K4mDyY1B4Son+6UpNc0dbVGZrpJfm9GK9Lj1b8yl9xmmnh9yHxaGe3EI/M6sZJxD+FAFUyvQCKzs+waE=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB3176.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(136003)(39860400002)(376002)(396003)(346002)(366004)(316002)(38100700002)(66556008)(8676002)(4326008)(83380400001)(6916009)(478600001)(66946007)(54906003)(6486002)(2906002)(86362001)(26005)(7416002)(5660300002)(8936002)(9686003)(6512007)(6506007)(41300700001)(66476007)(186003)(14143004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?sxqkMsr6ZQelvVMMbkFTB9DQ2+vY2BalfyUTaMHL0bX+RjWjxj2Lnoqwd835?=
 =?us-ascii?Q?9ni6jAQe+6xmzmALVB9KAEcgrL2QTO5ZceYIGwR9IAfhRn+V46+nHcJ3oBJ4?=
 =?us-ascii?Q?5k6jpUQ5qTyaRym0XK5S9Y3V5u+hp+EZGx1u+pDdF5kM9EktBp6AqOeMgL59?=
 =?us-ascii?Q?IFz0cw+M6iyjJUquPe9HRoWpVI4Nog2DFMZajIz97oHRPfyot1QbtA6psNPM?=
 =?us-ascii?Q?E/8jeRhH+1VtS+53/bGWRmuZNZwqAc7SUyKvn6aKLJJ+aalh1HstnNQWID9V?=
 =?us-ascii?Q?s6znbirl0Rdt8pjgLnleAqO8mEENhb4ppYzzHOpDIVKA16cborMIIDiZuifR?=
 =?us-ascii?Q?J7liTiP7788e8rUu4fODFN39XGEDOsVT62LdwXpWbDjDvckBP6caPqZjHWXk?=
 =?us-ascii?Q?DywgK/QG1A676IHwvpEfKTCT1mOPEHdZYx3RRqD0X0IgdIS9fsTPrOAoXz/N?=
 =?us-ascii?Q?dOv2ZKMD2rSyhit13fI/9V5Av0Ss9Iya7i3fAhGrYUYrsnUS/5abY9nhgdMH?=
 =?us-ascii?Q?3Vnue67lkFgb0S8fF/j013AosrzdTpgiWJUcZ/+T8A1v6XGwGy7xv2Qetkqa?=
 =?us-ascii?Q?JEW8Uy83DAiQbjT+dLKgQ623TRrcKA/9+N/JdtjQSfB7K9N/LqbYhTGp5blc?=
 =?us-ascii?Q?Uo1rHsBbnfcCWN5Y7OLbC9kFLGnf8kzOPq16vuWGo+XkBzQXft/zL09MUvcY?=
 =?us-ascii?Q?y63znSgeOfkJF8w6FVZxKT78pHaehRTR8ub5Xme/AUPnhtIgmp/PdkgsqvEz?=
 =?us-ascii?Q?VvueqYyw0WnBlY1+A+3USF/e9UxQr72UpfhRzYtrkEDsEHl533W5pZsWy4OT?=
 =?us-ascii?Q?+dZB9kaPUAenKUl1ES3n/wZ0r9513xq8CPSCnu4h3RG96pF9C05MZsGU39UF?=
 =?us-ascii?Q?5PRBc29Rpn31AY06iP5r6apa3HdKq8FisMoaiihBNnq7CM7TL6rBRVY2Q7EA?=
 =?us-ascii?Q?t9jxnnZwgR6wixJohTiNnGeScq/1/AFi8Oz97dBFkDvw6wjqd6v+CD/ujNv5?=
 =?us-ascii?Q?KlFvDv999mq1Z9tLjy2pFhCky5vcwXKsRp1/bX2T0UPZJcMLoHGzeOl+Qr6t?=
 =?us-ascii?Q?V6Ak6N3nfNddVLdyfRParlCdSiyu0hyAkTJD/UivEDb0ShGL057sfa79SPOJ?=
 =?us-ascii?Q?xrgZLtxAaRugYYVeCLrWgoCvWu5Y0Uw9c7ppDgd3reLhDl1ZeEHgLcl0IA43?=
 =?us-ascii?Q?3pNcXoRpAHvtTQLNfhC0YVNiDd2vqf7ZzSldIEw72QK+VFr8lohdLGbm/Nh5?=
 =?us-ascii?Q?/LVYHYoVW3Nfxhpas0wQoBXYteYfKgi9uLh0Oqa6gUIRKXc9ecTyhmSpFWh8?=
 =?us-ascii?Q?TFIPnPEfRcqrTWP3fsI8MrOh+1BUogobfthZWoiySw5BXCD6vz1HrJno99ul?=
 =?us-ascii?Q?Fgu3sf7/C9FG95CeIccxqRcsOy03fnZX2v0BJq/HbtafP007jDJdORlZ+PaO?=
 =?us-ascii?Q?u+799DaC78TX7kyGwZl/r8gKUa4HtUUZ4XwrAMxd/iZWxSmAdgQx7p1z/SAZ?=
 =?us-ascii?Q?poi/FDmobEV8mMMmkaFfh3aEr2mKQDUDP05YHf6qzEnfZgpu/vD/AI2N0ch4?=
 =?us-ascii?Q?KR27DuVf0MEPiesUrYTv5GD5gq4+uqF0aP+r/Vrw?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b28c564-d6b5-4a02-771b-08da7f21cb8b
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB3176.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Aug 2022 00:53:55.3472
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ygr1KD5F79MJhn+N2G7CZZh0Z7gVjAg7OppJ+oFA9sW3HHJGtwAVD+cd/0jVvYAtSmKzTPAUNbMKmhO/UhIwSA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6349
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Peter Xu <peterx@redhat.com> writes:

> Hi, Alistair,
>
> On Fri, Aug 12, 2022 at 03:22:30PM +1000, Alistair Popple wrote:
>> migrate_vma_setup() has a fast path in migrate_vma_collect_pmd() that
>> installs migration entries directly if it can lock the migrating page.
>> When removing a dirty pte the dirty bit is supposed to be carried over
>> to the underlying page to prevent it being lost.
>>
>> Currently migrate_vma_*() can only be used for private anonymous
>> mappings. That means loss of the dirty bit usually doesn't result in
>> data loss because these pages are typically not file-backed. However
>> pages may be backed by swap storage which can result in data loss if an
>> attempt is made to migrate a dirty page that doesn't yet have the
>> PageDirty flag set.
>>
>> In this case migration will fail due to unexpected references but the
>> dirty pte bit will be lost. If the page is subsequently reclaimed data
>> won't be written back to swap storage as it is considered uptodate,
>> resulting in data loss if the page is subsequently accessed.
>>
>> Prevent this by copying the dirty bit to the page when removing the pte
>> to match what try_to_migrate_one() does.
>>
>> Signed-off-by: Alistair Popple <apopple@nvidia.com>
>> Reported-by: Peter Xu <peterx@redhat.com>
>
> This line should be:
>
> Reported-by: Huang Ying <ying.huang@intel.com>
>
> Please also feel free to add:
>
> Acked-by: Peter Xu <peterx@redhat.com>

Thanks Peter, my bad. I assume Andrew can fix up the tags if I don't
need to re-spin this series.

> Thanks,
