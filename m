Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C0EC58C17E
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Aug 2022 04:20:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242597AbiHHCUI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 Aug 2022 22:20:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243891AbiHHCTu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Aug 2022 22:19:50 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on20613.outbound.protection.outlook.com [IPv6:2a01:111:f400:7eab::613])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF5E832EF7
        for <linux-kernel@vger.kernel.org>; Sun,  7 Aug 2022 18:58:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lgd7K3UebD4kGDZbFzrA/vnZjMGovBHInGXCvLhOy93J3Nis9SoITaLY0A2UnzhOWyOQSiR6MRFhk4dwp+wtQDYgO39s37IIRdyAyO3fBY3HjlPMnOa1R3dKtmN7b4xZaz0LnCI2gsOr/ztyuIyp3tWn3F1mWpzQbM6BTerLORGJ3yx3V2tPpDZ2TvWDAXdxZUBE3ci4LlOYzeJGELFYGZjOrTtqEwgW5gMsa5LTF+c7gazXukLW9PTXqZZj486N+2QpPlUHEMUKpQhYoDgj3hYb/OdDsrQuDgktwkvH3IW8oBqs1sVhW265BA2oySjct0EBjXQ4rUY+91/LZhlZFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KrEBj2bL9b4dEc0G/7E/yYumL1+CbiSXNF3nGwlLoYY=;
 b=SwXpy5XDQkdqV5J4kbzIftAiUl9C+6J2K3T/D+UNND68Kj7LAVYDHDtOZp3U0OsbgegcWOV9ewsKBx9G5eo57L+B7vx0IEUBXqPoJ8a4562NRJxFq6vubes77AUU5bJ83XvJjb8W7RNYPLFBvG+9EdP1jhfXmloRHw13TNqhvOW5l6AQb+8Jnl/AdvhNyyzFo01PLvCmtyfiTwKFlBmTNMOJoSDulpu8TvEW9lnu+WnTZQyjBo2WjZaH2xOhR09tRQ5f7tHv5Q7+5dxM0rhodTNocjMXb3rUzmQYMCH5eDS4K0mTbVETa8fLoxzyyghvTrtut+dsT9y1Eh1mL2gaCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KrEBj2bL9b4dEc0G/7E/yYumL1+CbiSXNF3nGwlLoYY=;
 b=G6cMFA1KL+rb8xreT9LWg0ntKnZFpcMbo5xgj2U50xkJKcAjmTNLoAtLQHOGKnDLDkTIIf6TR6dAGraaHO+pn+DcD9LPPfiD80rpCOmg6h5c5OCDuIHyPVagetJJMej4h/r9eTN+S3SSxAB3rzNEjoLoMI0VNa7G1K+6l3MzCmamIzJcjLwnTPjZ6jqD4bCqv+1eHwqJrq5jJ2fdIKPIL88UvnNI1R+JJLDjaKorki1LinN9g+MtEgm4CGzxLK6V6ebjksRcGojUKDvBu44pV5Br1lQxf7hZ2Q/81bwH/t8PUKpvB99iPm3vhwI4WY3VKYqQxfvNl8xeWHRlaYcVOg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BYAPR12MB3176.namprd12.prod.outlook.com (2603:10b6:a03:134::26)
 by SN1PR12MB2445.namprd12.prod.outlook.com (2603:10b6:802:31::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.16; Mon, 8 Aug
 2022 01:57:21 +0000
Received: from BYAPR12MB3176.namprd12.prod.outlook.com
 ([fe80::eca6:a4a7:e2b2:27e7]) by BYAPR12MB3176.namprd12.prod.outlook.com
 ([fe80::eca6:a4a7:e2b2:27e7%5]) with mapi id 15.20.5504.020; Mon, 8 Aug 2022
 01:57:21 +0000
References: <3e20a542e756bbc0f66435c9344ff674f3ff7ac7.1659680600.git-series.apopple@nvidia.com>
 <Yu0HsWC09OCgiDmd@nvidia.com>
User-agent: mu4e 1.6.9; emacs 27.1
From:   Alistair Popple <apopple@nvidia.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     linux-mm@kvack.org, akpm@linux-foundation.org,
        linux-kernel@vger.kernel.org,
        "Sierra Guiza, Alejandro (Alex)" <alex.sierra@amd.com>,
        Chaitanya Kulkarni <kch@nvidia.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Felix Kuehling <Felix.Kuehling@amd.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH v2 1/2] mm/gup.c: Don't pass gup_flags to
 check_and_migrate_movable_pages()
Date:   Mon, 08 Aug 2022 11:55:15 +1000
In-reply-to: <Yu0HsWC09OCgiDmd@nvidia.com>
Message-ID: <87wnbjxzt0.fsf@nvdebian.thelocal>
Content-Type: text/plain
X-ClientProxiedBy: SYXPR01CA0134.ausprd01.prod.outlook.com
 (2603:10c6:0:30::19) To BYAPR12MB3176.namprd12.prod.outlook.com
 (2603:10b6:a03:134::26)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 85c3e305-806e-4c8e-2a35-08da78e154c5
X-MS-TrafficTypeDiagnostic: SN1PR12MB2445:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EhXXjE6ML7zETwYyF8kV0TA/A8odG3y2QBKByk8uQK8D9AUDV/tIC5v3yAoCydVmcyTeTlduTbF1R5AiWk/45Eg/a1XMpooQDY8J5D6HHXBNk3bkfvGxKQOGvqElJpVOsh/yNdz3AmNr69EuLWS1ClRnxvbvkCf0aiURd1yqk+ILXWUDa3z/514cQCSwHW1BJPoGyegFbuDDz6f/jNSwSRmbsMcVsiIOsm94anp5WTQhQmz0Vs75l0iIrygHQ+T7rRJJgedpZ0jCHwzu1LOGRbHOoHDFnhvuJqO3hj/ZxQrCfjE/wII0Q0dm1GSfL04chb9O8Ii/yWkmwFF7XR0ZZP/6X86eqqQBpTwZVrXursoo96qGv4dh0FuI2f9OXz8Z3yfqOGaMc5pAclEjyNLXasSFumwXsfrJCKOVv0gSI7D69zwnchk7zKT0zvPz1w9hHtPnC4dd1LuqEg6mDt5avYtcvzT7JBiHegDvds7/o/Z7gmmlZNFxynVHQVBIkmOrBD2c0ofTAm4S1P95jtLQFBBDvp1tNJ5h6gq0QlXHXkwu3DprvgkhCUu6yXZzLA5zBKEpLNeJ0+8q58tgV3Ejiqa21j8/nKfcPneZohISDm7D5NM8hQgjR93WCl2kj+Nkyberw+0ocJL7ZBZXqGQaIYxcKIIZ1Gyn6QuNNmGV1vWkIgbUS9W6J0DWdtsLs8g0SSnApPdKFO4XyXBrsuD5lf+yzTWw6qHxANl2aTYI1IaWquX6cAYCGEU5zmaz1M+J
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB3176.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(376002)(366004)(136003)(346002)(39860400002)(396003)(4744005)(478600001)(6862004)(6486002)(66556008)(8936002)(66946007)(2906002)(4326008)(66476007)(7416002)(38100700002)(5660300002)(9686003)(86362001)(41300700001)(186003)(6666004)(26005)(6512007)(6506007)(316002)(6636002)(54906003)(8676002)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?yf9aH7440lBeKe3sYdrDBYTG2hrLRSD7zpN19xL4NVWcmEX7u76kfir/5hv7?=
 =?us-ascii?Q?gnLHr7ffL+YzRQ+cLRGAZLZwXzC4F12NM7A34acHoZzw12Vs90rOoma5RMAT?=
 =?us-ascii?Q?wesjc8Ej/OtkKtYZKPrSS9ifpmVZMUOzobcV7AKiPQEr9ahE1S2/vbPoDqm0?=
 =?us-ascii?Q?+Kh5yP6cV0rnM8MyiffbtLqfI/+r45hXGYRhDaZ9Q4/APLs0N8ZSGj/h7Jz/?=
 =?us-ascii?Q?xy3EZEvZOG8YXSGsnZuKXXhZwZcb7/wWSrH1G8lJ2Idqvd/z50yBIgBL9oCf?=
 =?us-ascii?Q?mLAR8SBcNGxf9ND2q2m+vSQh2W94vsDIThP2zPFxOvQLD37H5AUXnRQ5xpIt?=
 =?us-ascii?Q?788pr8cebCm/oV/vaRMlhe1J3IFjpxGGcdPM5iIZ9iCPXzT8i9KkaMX93/N6?=
 =?us-ascii?Q?IuSQXiow9Iz/1YWFYPoYzEqGxRFGLGb/kC7l5hjw9YZ767Ef4/Cm6VBdIW99?=
 =?us-ascii?Q?zG1RV0SEelvCyWkLGjtiDRFRuE9ZskWSNhjrRPNJOYbXX0QEdloF457hjo2K?=
 =?us-ascii?Q?x4VUwlhQA9hzf7s+W6jXn+E47zQDZ4TlLh1YxD/4shWc27Ev87bsoghHtjr3?=
 =?us-ascii?Q?bKZiJRi6TQejCmZnRAea+DtyFyKUqSGqaECb3fZRLIKKzfQV5AAsr1ANTVtu?=
 =?us-ascii?Q?3oEs7rVNMVG4e2qjPXVZZoMlgJMNgfq8IbXcuTRO8xZxB/mcdmzx4BUso197?=
 =?us-ascii?Q?dL0ZWizTHAeqgRZfXET6kJiXCzKX4AIH4+K6sDvvbHKg0GD2BF8qFZQchate?=
 =?us-ascii?Q?auq1eBLlgDvrrUfEELXdgnyalHb0jipn1kr+6/8yXJLOFuUvehVONDCOCPwS?=
 =?us-ascii?Q?nAFBEkP+U5i3a1kI0iXemjLDsX+xlRY+p8T/INWTQrdgNylgyniH9UogaKxY?=
 =?us-ascii?Q?Sop7/kHVR+8z4RL/ah0wPip9ohWq2AUl/Ip8VNSBBQXJcpS0Gm6R5r29gAiF?=
 =?us-ascii?Q?FW4WWkf2DZtZOiwwlojpM4FnRgU9fePF+KnNxe9cqz+pmJ2ifklms+TYxWQ0?=
 =?us-ascii?Q?xpxA40H91GjZrD7KnZhG2yIkOxXc++xudsMd1pAAAWQ41pf9RdX+HNkBOtoD?=
 =?us-ascii?Q?U7erRA2/eQLJPyde3WGIBiJ+6T9nkEU3PchDPy/zKvooN5B9IzzC+yqcFNLk?=
 =?us-ascii?Q?qd5c6K7/M6cJlBwzGDWhwhF/rlMg2lZsGGOQyZmVlmwtXm1r5Ll9HoQg+RfX?=
 =?us-ascii?Q?ib129Q7SWlD2MH6+Vq5xlpmEasBoHKwavmzT95ZWI4ydnE8c13ob1MmqqO/S?=
 =?us-ascii?Q?pAQTvUuZiLFDPy7/1rqMgu/pdX8o4iLoa7b9DOXlTZrRKndEa1KEIUvIjVwi?=
 =?us-ascii?Q?vTl99EVGBlXQQDYWGsOVn/KxYQAPOyT8mUDtYChMSvO3m9rJ4g9avgl7mVt6?=
 =?us-ascii?Q?ScAxtxyXdJTcjb4A8OeX4Gz0yavdkHRqWGRxYpeUR4IWVrMXxROgXoH8dXBr?=
 =?us-ascii?Q?LSdCGv45G+2ihMidVhPcK24du50LvBmJgm3T7w+RNqPsTj7ooqnuN1UVA1mV?=
 =?us-ascii?Q?xBJVOhGvAyFRNYh7wvW084d9OG1qE1gCePMrmrr+OoxSr2APvPvTln06dHwt?=
 =?us-ascii?Q?16wE6fL23a3OCNTF6J96uEzOKzOZDpeLuxphbXYG?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 85c3e305-806e-4c8e-2a35-08da78e154c5
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB3176.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Aug 2022 01:57:21.2622
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VCb5Mj/S/IDh2GiHY8dHFYmKxFso3HeIdEKm3SIVD7I1I290Qytp9nsNHYBQqx0KVaeUKQAGN6txJeNJTrR2mQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR12MB2445
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Jason Gunthorpe <jgg@nvidia.com> writes:

> On Fri, Aug 05, 2022 at 04:29:52PM +1000, Alistair Popple wrote:
>> @@ -2053,7 +2046,9 @@ static long __gup_longterm_locked(struct mm_struct *mm,
>>  					     NULL, gup_flags);
>>  		if (rc <= 0)
>>  			break;
>> -		rc = check_and_migrate_movable_pages(rc, pages, gup_flags);
>> +
>> +		WARN_ON_ONCE(!(gup_flags & FOLL_PIN));
>> +		rc = check_and_migrate_movable_pages(rc, pages);
>
> This should be moved up:

Ok. I debated doing that originally but wanted to keep the WARN_ON
close to the code that makes that assumption. On the other hand a
comment would achieve that so will move it up. Thanks.

> 	if (!(gup_flags & FOLL_LONGTERM))
> 		return __get_user_pages_locked(mm, start, nr_pages, pages, vmas,
> 					       NULL, gup_flags);
> 	if (WARN_ON(!(gup_flags & FOLL_PIN)))
> 	   return  -EINVAL;
> 	flags = memalloc_pin_save();
>
> Jason
