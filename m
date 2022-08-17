Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5D6F5979F3
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Aug 2022 01:07:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241884AbiHQXFz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Aug 2022 19:05:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232457AbiHQXFw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Aug 2022 19:05:52 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2065.outbound.protection.outlook.com [40.107.243.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D52FAB4E5
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 16:05:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YuqzDhXhqxEolWP5FhbGArCq/Sz4DHa93E7t/zHhfTwDU6fG/2GOeKCEYCY9J47skpDrRc6+1Gc3qEy6+qtdjWbXySI0hlDhnz3J+ueDjPUKsQLG14b/+gv+VO7nhZoCVbbPNyCqraFCDe3DHUE4+alUhHHieuCGZUysLx7ipTgrv96+r0hO1ct7F5hG+0/S2r3FXJZI/vx3/bIvNsdA2TLvYMgrs+EE4qEQGkwe0VRM/V30zYRFcao9aWDOknEI1NZexjPLAIlVZKoKE6jjq1nSUn4sOP7Wmz4MucNlA+GdR7FAhNAKucLANhLLc6H4fz2mol897Rqw2UjCb5OkHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5x+XSbyXzVn/BM/TyfJjFuaJolS10xhq7JVoEGrVyiM=;
 b=RQiubdtHD2/bAmDHMRGAvs2u5SrNU4EdsgMpr9cPJ8AIeNPfd8ixMy03nnY28f/ZRnYRciAZ4NJk5OaaitHK2lmz7lnbgc2NOysH+Tp1HqAnLz925J6CbQlVDp/CWKTDYq3+D6rjbPGMZ53MKSKHrNohtj/Ic3jF/imeUZrXaisgaUgnDM1q4VRqSkd+RYHJN8lySSFIVcMa0pfs/hNtnS2zaSKpGd4h8S+L/ywOq8I75DZAKwLOjiGdAD66uzZZREm/VAzrcS9y2+bSCxcny2Xuhqntf37KO4UVacj0/ShQ+jUPgTNbha++2UJwbf2YbOeyHJFdpKX0+dsTni3+tg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5x+XSbyXzVn/BM/TyfJjFuaJolS10xhq7JVoEGrVyiM=;
 b=aOoJcaChuXom7RO/bWNw5Mibp/Jsy15IiAXsORZv23TtzFDE20UhLrV/jTqtEpdWarZEGaKn8Yakhg450cGDNLlNDBHANjvq2HYAxOCZxccus8b1yDCfhEgwtOPK/9B5vVNHrCfO472u3Uu0Lm/+G5Xc3sOz6Xt4t4OH7VydjmDprLNZ2EPeE+nR+/TQspCed4y1t0d4vO6QswILWWaGJBCn2CadomCGR+P/i1g1/YW1cWYM0DQxnm3YVyizp39R+2a+AVmyUfaPbziYj0fewKoU8KXSHrgvd5VCRBB0R7wCx0EeAbdKr0fzrd4Lkp5VreZ8VJHEiqbOgFLoafdMJQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BY5PR12MB4130.namprd12.prod.outlook.com (2603:10b6:a03:20b::16)
 by BL1PR12MB5048.namprd12.prod.outlook.com (2603:10b6:208:30a::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5525.11; Wed, 17 Aug
 2022 23:05:49 +0000
Received: from BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::508d:221c:9c9e:e1a5]) by BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::508d:221c:9c9e:e1a5%9]) with mapi id 15.20.5525.011; Wed, 17 Aug 2022
 23:05:49 +0000
Message-ID: <20370ebb-8e63-2065-307a-81fa874eced2@nvidia.com>
Date:   Wed, 17 Aug 2022 16:05:47 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH v4 2/2] mm/gup.c: Refactor
 check_and_migrate_movable_pages()
Content-Language: en-US
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Alistair Popple <apopple@nvidia.com>, linux-mm@kvack.org,
        akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        "Sierra Guiza, Alejandro (Alex)" <alex.sierra@amd.com>,
        Chaitanya Kulkarni <kch@nvidia.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Felix Kuehling <Felix.Kuehling@amd.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        David Hildenbrand <david@redhat.com>,
        Matthew Wilcox <willy@infradead.org>
References: <487960bf67c7273ff5606c76f73bb51271bc7b90.1660269441.git-series.apopple@nvidia.com>
 <6b61e9bf7c65f78524db32ba3e65a7eb6b8a76a0.1660269441.git-series.apopple@nvidia.com>
 <YvpxOyrDBUHagpC6@nvidia.com> <87edxgvixy.fsf@nvdebian.thelocal>
 <Yvt/hZYfSvlCbU02@nvidia.com> <87wnb7tycb.fsf@nvdebian.thelocal>
 <YvzaXeRox/9fqfdW@nvidia.com>
 <de9a3db9-6130-fe07-88ec-7e728ff5701c@nvidia.com>
 <Yv1wntznpzSXuTYh@nvidia.com>
From:   John Hubbard <jhubbard@nvidia.com>
In-Reply-To: <Yv1wntznpzSXuTYh@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY5PR13CA0020.namprd13.prod.outlook.com
 (2603:10b6:a03:180::33) To BY5PR12MB4130.namprd12.prod.outlook.com
 (2603:10b6:a03:20b::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ed9092f2-8d39-4c01-93c3-08da80a506a0
X-MS-TrafficTypeDiagnostic: BL1PR12MB5048:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: e/lZoDzIoOPQfbqMH8jy7qg1SrMH6peqiDUJ+Tc5SbUIBUBrpHjSz2Wf6luGEYLeH/q+gkVSTfA2c+5QTOxVF5fOmmIu3tZQsqPxq6CuGEJImcggrGAaDuTWiKr1LHU7LyE1U0IV38zbhWczYG+QGrU+WkC6ukWmfFSzhar05LsFDqp7HY41o3JVBHt6HwZaPQS+lhuoAzwwn7K63QMh3O/asT47wrr6ROor3/pdcpKi05S7HH3zHyYNNo3r9gH3VXBg/RfguiwizjLhx0w8g8yeYQhr6TCERiB30qLEiGDGedKiuzR4wjta1z3GABLFU/acrV6S/q1qJUzvkE9w7AA/vB2iQx9WPyCYKqPdnBqzWUl1JZxAkJxLArRqyC90tyyZK+ZpFjUA7caJTrjAT6BUlB0YVR9LSAgsSEzSX6EVRNQZJLJln49V5JCTmTgBHZqrIke01FGOAOgT+1BQ9XVYZRiV+47ZEbMle7/0NTfJLp4f7iethC3XkrVPb+44NY7ec6KyKrt/oUsHP4HLgbedK5kJ+GqhNTxv2JczG9XzSEwm1up6tIkVekrcypf1glRaWvedhCbmhrSowNtxyh4XBBsC421ue3JVNEh8VuAoVaAiiRihhW3b9J1/MszKbGhO6rt6nwAA9V7tU5Kbi3HyVa0zCrIOHUZNaFf9Y6CKoeL3SI5U1qup5YUvQmU4DqitLOR9uDjXJqUdYwEy/ZRKrocaX4r+Yr/rsX1nWiHk40P8jnJ9HqGbfMNHF+8wMy71kcTSirE9VaZ3hx/asu7X5sfzuWxNzcuTNea9PNO8XDGV1bnJ+bVLeDf3FQY6phpF2YTgio17D8ct9VZi2NTAd7ztTrVZoD5EyCmfP+keN9tnFxk3UyUxSN0IrOw4
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB4130.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(376002)(39860400002)(366004)(346002)(136003)(396003)(26005)(86362001)(53546011)(186003)(31696002)(36756003)(31686004)(2616005)(83380400001)(6512007)(6506007)(316002)(4744005)(54906003)(478600001)(966005)(6636002)(41300700001)(66476007)(66556008)(8936002)(7416002)(66946007)(8676002)(5660300002)(2906002)(6862004)(4326008)(38100700002)(6486002)(37006003)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TEYwcEpxUjFrSjd4MWhFTzRLaDN6UE15OFlzWkJVaTZDOEFwRCtmL0ZYZVF1?=
 =?utf-8?B?dGp4R0dCUklZeUk3ajMwNm9BcW9adXNCRXpNYkJHM01ORHlQQ0l1QnN3RS9B?=
 =?utf-8?B?WXh3WTVwbHlMckZJMGNiRVFpL0RzbFh4YUNHWkE5NktmdnY2aHNBU0VHS05Y?=
 =?utf-8?B?a2NhK3F4V3Fib0g4UmJZTDNFb1FoOVVnd2JCM2lXTlFBaHpUcXJIN0xDOEJ3?=
 =?utf-8?B?UFV5RVFja1hjek9SZUt1UHVzeC9qRjF5dHRUV3J4WlNwREJtMlhPbnhZV0xs?=
 =?utf-8?B?NXB3bTNURDlqTGlGV2daRW9JR29TRmprR3hyalhtZ0dUSGI4Rk5UeDJZZlB2?=
 =?utf-8?B?OGljTnhCaEtrUjFvNk5MaHovbFhrVC93bytGNjYwQnYwR1U5UjI4b0dKdjJW?=
 =?utf-8?B?S3Rqc0JnQXBEbWJ0UEt6WTZQVTJGcGNwbXBVcno3ZE84RXRIbGVoblFNMncv?=
 =?utf-8?B?QkdwUURiU3pXbTQ5NmdxUjFyWldwMnhxRElLR1N1YWt3QXFhT1hWa2hZbk9W?=
 =?utf-8?B?NDVtUWNSTU5LTTB3TkEvY2xNWnJCWjFYcVNjeHVUNTVUT2lUWE9kSXMrQ0Q2?=
 =?utf-8?B?ZXRPbVp3aUZLcXljK1BvdGsvK25aNDY3VzVMOWFhR3ZYckk4bStGeWhMc1hS?=
 =?utf-8?B?MFhsZjFpemUrY1krWXpGQXBXMmRlK0p2VmVzbEo2QmcramkralRtdmFrODZ0?=
 =?utf-8?B?bTl2ZUo0V2VzUFhGa0tFRTVsc1B5VW9IVmRNaFI3N2pNeHpJTDA4T2d1dU1o?=
 =?utf-8?B?QUowQ2w2VFFFNXFRVVAyU3IybTZnZERkY24xeTc1UllCaUhYcVRvcHViMkZK?=
 =?utf-8?B?VVcwMXdJTVFrUStocS9jcnJ1YkIwZ0EzbzFybVArdTBZaHBKUlZ0RnI2aWFh?=
 =?utf-8?B?cFFBWGNwWTdkNkhIOEdSdE9vL2pRd05ROG1FMG42d1kxL1JYZVA5T2JUQlpX?=
 =?utf-8?B?YkZILzNmUEFOV3lidERhZlNzL21ZWkhVZ2I1aUF6S1pVd0U0K1NFRFFjOExD?=
 =?utf-8?B?V0J1RkQ2UHIxWnJ1azRESXprZjB4TFY0NmgvL3RrRFlVOGNhTFNNc3BuZU5R?=
 =?utf-8?B?VDh0dEtHNmJPVGE0WE1FOC9WNlUwZlRpbEhFVC9jVitzVzQ1YVVmRnhzOXdt?=
 =?utf-8?B?bEZiVE1HYUZ2aWFod1pmbG9MMXQvdGxlclllMUpvNkpRUjZYcGtIbGJoSXl0?=
 =?utf-8?B?RWlPWXZKaWIvSk1xY01CdGV4WFM3MFF5WUs4d3ZjTktZbUZLSlR3dDlsNC9N?=
 =?utf-8?B?UGx6Smsvd1NlZzhQT01kSHh1YUx1YlB3ZExZV1llTm4xOG40b0RlZFF2QnVt?=
 =?utf-8?B?bXNFczhVRzUwS3Nlelk2TGlDeGtDWW9icGVJZE9BOUZXL3BjZ251TE5vYWpZ?=
 =?utf-8?B?VnZNd21PL1VWTTA3dWJ3Z21uU3hqMDU5WjVMMkdPYTB4RUZLSHNuUUk3Z25p?=
 =?utf-8?B?eksrNUNERitWZ24vWWQyVGx1TGpTVkxjWVJYY0NvZTZmTld1RHdxQ2pkNU9U?=
 =?utf-8?B?MkdDVkFzOW9oTCt6SGhKUU1wUXh3Nyt1NGR4TUFtQkNpQjNycTRVOTVlSzZx?=
 =?utf-8?B?dEJsV0xoZE5kcVhrT1dPMjBWSkxaZFg3WTZvYnIyVDVOellobEJ2Skl0NC9s?=
 =?utf-8?B?KzA2UytzbzVZY2N0Z2QzQUpYVncwdFdkWXBaL3NONlViYW5rb2k3Yjd0Q2p4?=
 =?utf-8?B?dEh3cU5Qd1FNdjA4VWt5UFFXMUlsYks2S1kwbE9QRFVGTlEvVWdWR09qSWdw?=
 =?utf-8?B?aEUvT2JhdzJBWEJ6aVQrUnUzVm9PbXBJVmdzS1hpaE54YVEzU1h4WllHVTdG?=
 =?utf-8?B?UUMyQ3ExNGlzSnp2TjQzNS9NM0oxbTdRUTFzbGQxdncxRnZPMTluaFFENTdC?=
 =?utf-8?B?QnlLVkQxQnFVRlZPMUtyNFF1NW45QVBNU21XdFU4eHk4bllzaG00dWh5bnBw?=
 =?utf-8?B?UHd6eEFNeGhTcVRhdXd1ZUVCVUpNMUpTekpiblUweHBwNzYwUFlQd09rbFZZ?=
 =?utf-8?B?bUswdjFUbTNYMFJscTB4K3pxOW1iQkR5Q2pXemN5TmlVK3Y3TG9aNmtsUDJ6?=
 =?utf-8?B?c2Q4MkFiTmRTZHhhV0lhemx0NjNsVkhsN2llcCtFRE1NUU1YOU5BWmk5ZGhz?=
 =?utf-8?Q?9lB9xM59M2DKVmnve6O2uTimJ?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ed9092f2-8d39-4c01-93c3-08da80a506a0
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB4130.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Aug 2022 23:05:49.6742
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Qj8800Px3hWIPIZxSTKmdoTA1cf/LbUTQq7JsjRckqbz/xQ4tM+4tqDfTOQG1yo6RkV2qLcjxQhdM/JEgE5jbA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5048
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/17/22 15:50, Jason Gunthorpe wrote:
> 
> But why return 0 from the helper function in the first place?
> 

The caller is looking for three distinct return code cases: 0, -EAGAIN,
or some other -errno.  Unless you restructure more, you need all three
of those cases. The 0 case leads to the caller, __gup_longterm_locked,
returning nr_pages.

Here is the comment block that I recommended earlier in this thread, that
documents those cases:

    https://lore.kernel.org/r/dc8fd102-ba30-d980-bdbb-11f39326103d@nvidia.com




thanks,
-- 
John Hubbard
NVIDIA
