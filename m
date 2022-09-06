Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 896BF5AF6CF
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 23:28:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229591AbiIFV2Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 17:28:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229997AbiIFV2O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 17:28:14 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2055.outbound.protection.outlook.com [40.107.223.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB7BBBAD99
        for <linux-kernel@vger.kernel.org>; Tue,  6 Sep 2022 14:27:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZSCp5aXLSd0hLyf1ggNCDSkPRuQH45Iini2q07m7uENG5jLqz9vckABKSNrwO/mqReDOXLzeMkksKHAGRHAHC8op8QtrOk9dRHaEJOdTBogUNkqfR1V9WEhdg/2QFExkonKgSpdN1drIWu4l8KMAsmED5BKEJuM3O6VC/gv2X7mbMYu/6/qrqBhPWHdU+AqIoEpYg/chdBUi6Bq6qVF4xsdOMSkgsCgpIxYSPVAQ0FIVJeRpwsN3qncVwcC29v1gh0aR2U+kMEtMpW0hm2A2U+8lkrWYvho1B8bQ/TQRRI42G0f+Zdg5MTh0lUTWRvBF2qfhq5nSD1BW5p69BRsJUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OPVAxOWeWZMrD7SXQcXsOKebsLAS4/Et1CMxLf+IEis=;
 b=HHNMlGUTTFxw+AvhaEK7tpNYnc6Gzqokl1dnTWSPxVbCJDxwHy14ic3Fic1wICVRw/ZI4ekfzyu855dvApgzGwZVBqkM4OVRaCAqm9F+HzU5L6zgoiNW0ny9aumP2XOuQY0FxVrD3tQaOtCDalrGggsYAjh2PxM/HBqo0Lq1jSwIssgkgNPwg6VrsUd56FxahRIRk0o0QMKwRn2O9NpoE2Zw89qkJvSYkgtmtIcaTAXOj/Tx54xNpcIFheedv5EiKgXJ9Y+rB3ynC+gIr2oxx3ikJ4N1ktiTg8tYId5Vnb8AXgEWTKcbGE3nR1xIuV/srPwMbHS5Ec3743Y/2sv8SQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OPVAxOWeWZMrD7SXQcXsOKebsLAS4/Et1CMxLf+IEis=;
 b=rec5Y+6mWggdUeR8+QHsUTa83UCrxJFRsUWitO4I/JbolMCOQuyEfCU2cwgcGQt1azT0QqQI5cHab4YUIH5x2om1GszwmYDEuTYP0nuFnLa0wElSxafCcC/1pGS266Gs8NMAeLO8xKwfn7jX9wdFg2qztZ35lkdhUDr9Yuuvh0JS4MzyDlgwJYKUA2RCw1Qfp3dwgC22/wzY866em5rEmSOIOrVG8pNNZbPSO/TDCFEnwoby+PAcyWbAVtE3WPdhWdPXoh6TD4vi37C4weJLp9Dkr5uNJukPm/3i3fedgt5YEzfsgBUJOeZbv0itv/mcKxkPHcuYYUo0LUg9lfwdEA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB4140.namprd12.prod.outlook.com (2603:10b6:5:221::13)
 by BL1PR12MB5875.namprd12.prod.outlook.com (2603:10b6:208:397::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.16; Tue, 6 Sep
 2022 21:27:52 +0000
Received: from DM6PR12MB4140.namprd12.prod.outlook.com
 ([fe80::e0c5:bb15:a743:7ddb]) by DM6PR12MB4140.namprd12.prod.outlook.com
 ([fe80::e0c5:bb15:a743:7ddb%3]) with mapi id 15.20.5588.018; Tue, 6 Sep 2022
 21:27:52 +0000
Message-ID: <8e0c26c5-58d3-766e-1ddb-00c0c7af19d0@nvidia.com>
Date:   Tue, 6 Sep 2022 14:27:48 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH] mm: gup: fix the fast GUP race against THP collapse
Content-Language: en-US
To:     Yang Shi <shy828301@gmail.com>
Cc:     david@redhat.com, peterx@redhat.com,
        kirill.shutemov@linux.intel.com, jgg@nvidia.com, hughd@google.com,
        akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <20220901222707.477402-1-shy828301@gmail.com>
 <e6ad1084-c301-9f11-1fa7-7614bf859aaf@nvidia.com>
 <CAHbLzkp2CKG5CQA25=HHzKde-8OFTPU2kMWD8remXMNNyF+_tA@mail.gmail.com>
From:   John Hubbard <jhubbard@nvidia.com>
In-Reply-To: <CAHbLzkp2CKG5CQA25=HHzKde-8OFTPU2kMWD8remXMNNyF+_tA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR01CA0030.prod.exchangelabs.com (2603:10b6:a02:80::43)
 To DM6PR12MB4140.namprd12.prod.outlook.com (2603:10b6:5:221::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9f8d6cf4-bab0-44ba-0c59-08da904ea786
X-MS-TrafficTypeDiagnostic: BL1PR12MB5875:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SLgnQXmPTyi8A5ezpd5OyV68nMDIedM+rShtau8CAGIqXQe0Juhk9vP7xaTJRZBb/KREAO2LPurqRNN0JRYhD7qDz+/gUlZG4DuW3pkCePf58kdR4Ao7ZcuW530yfjd9Fhgl+MkjZbfoYkw0pK6UH6bckp+BCwt1GcGRXUmDuMbfSOy9hGEMrA+BIzmeh2GaOTKYr8II0f/Txnam6uhJLGxKYfaFwpcjyXhACqOwtAubLbFNHqRyXcziAnAyqxO6klM3ztI74Zg02nfL8z6Sk1dR8b/2+ERqrD+p/a4cnGxP5mKvhXj+ymh3BiyG555Z87IXhsKCbEAvon8tIUvEAlBz3SIzM4JEWJj/+kK8MS9gRi1Gh1LqUwXsgytICBkK343u82gs9RP61oHtzh+kTVQsA/dJpxL05Zg2g0mCnozW6l7+Rh4Z7GXUI9Z6KHMjXfkfaQJryqQLp+acoU/JXmHE5Ie1YfsyeceGq+C39y8GcYmIAIXgPny3KA/elYuwVALgGL+BD5rFb1OTvI2aCggi37tGswKArt+jg4JMQ1saUF6bwLo3OazeMV1vJNvHn2UcnUgzSkqJJcl2x0HhkrN+n4Nxt8F9n+mLlMQuQKumWul58oa95PHV6O54lOqrHw4YM+goSDIexa71Pt786HTfO8UI1INI42r+XigrtVONGWyKltBKyo/KBlkr5smg8Ks9x6+04oGMKTtueAwaCwxeP1VuBgE0NkCl35zphobJjRmT1TmyX2ClX70bMeaJKjI9NUwL5vrVuWo15QQ0oDA3MU1EpJ8ir/KqoNmlLMU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4140.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(39860400002)(346002)(366004)(136003)(396003)(376002)(6506007)(6666004)(26005)(6512007)(2616005)(53546011)(4326008)(8936002)(4744005)(5660300002)(186003)(8676002)(41300700001)(2906002)(6486002)(316002)(66476007)(66556008)(478600001)(6916009)(38100700002)(31696002)(86362001)(66946007)(36756003)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?djdKc1RDbGhMeVVnZ3VUNFZwS2NiR1d2L1NkVEZ5b2p5M0I5eldBNVRCdldL?=
 =?utf-8?B?R2JNN3BBa0VwNXp3dmRJSmdlczdpMis1YWF1NlZxekZPTDZ4ODk4a3hybEZT?=
 =?utf-8?B?L2hHaHA3Zm1zOVkyM3F2bkVCNkluSVlBMG9HZlpHQnZsOVZvSFNBMzhWZUFj?=
 =?utf-8?B?RTRMUjlIYW14ZVhpbFpQeEJTTEVWckdVR21VMEdtZTFmOTNCQWMyd0hJbjgy?=
 =?utf-8?B?aWtpeDhVUm5rYi9ld2ZvbUlOdk03OGo2TmdzZ3duUmN2aHBRQ3B5RnVpVUVG?=
 =?utf-8?B?dG5RU3VTZWhjTmdFaGZKTklSaUM0T29VZittV1RKbTQzVThsT3ZWbFlZdTl5?=
 =?utf-8?B?c25wdEMra3U2VmNKS1JiSkNSUWFpbitWUXFTUjhEdG8vQkM5RHRHYjN0QnNt?=
 =?utf-8?B?RHc4cmlhRjA4UFd3eXFvUWZHMjlldDNuSC9xVm1WdklONFVrZ2RhYlZnTHpW?=
 =?utf-8?B?ZGtLV1lNNEZLUUVHUU4xem1jSlZ4K2pwSzhzZlh1WTJ5VENicXl5a2QwQi9Y?=
 =?utf-8?B?TGVKdlowalgvbGp5bEV3QnRuT1l1cDB2b2JRdUR0VWRsY0ppdGwyQm9ZeGlE?=
 =?utf-8?B?UW1VM1o5WXROTlZXM0w4OTJvd1Bzd1ZpdDJFcnk5KzNRSFEyOWFYeGRBSjZC?=
 =?utf-8?B?VzZqcC9FYnppWVpUOHg4TnN0b2lCbzExOUlpSGh1T3lqQWpXVXZ0NUJqakIw?=
 =?utf-8?B?MlltZ1JTMmdLMno4YkpCUm51WUhJUTA0ekthVlNUejQ0NzB0eTRDQ0o4dGRR?=
 =?utf-8?B?dEpPMkFxaHhvbXlDU1JqSENyNXkzUFM1dHdMeTVuTFl0SEpOeTNNeWpNWTBi?=
 =?utf-8?B?N2hHK1ZaTUJ6M0xPSERycFMvTXllVFdXRUhSUEV6T01HZUs1MGllVWMyeEQ2?=
 =?utf-8?B?Vi9rSkJDLzZvS2diNWwwd0xWL3VIQ25FOE1WbFJ3Z3dMRDN3NXFVbnNOZlpJ?=
 =?utf-8?B?N1pWeWlBb3RuSlo1MW9aWGZwTHdLS2lzdjM4SHZxV1BVNVB0M0NEeFh1eWcx?=
 =?utf-8?B?STVUVTNDWmpUS25mMmswT0RXdUpzMjJsbEl1UklVMFdDM2RUMDBVcHVtUUVC?=
 =?utf-8?B?RjlaWmxxd1ZQYTZ0dmhFcFNvMlhWUlhJWmMvMnNyOWlCTVNCRVg4WVdQTVlv?=
 =?utf-8?B?blByNWI4dW82ZDRGdkFGem9nVHdMOGEzV2JkMlVZWk5hNC9lV28xZmE0Y3Jt?=
 =?utf-8?B?SVU2ZzFCNlA5b1BLYUxNS0k0Y3NudlA1Um5jUEpvai9wbVBHa1JJdXpSVEN1?=
 =?utf-8?B?NXIvVUlaSU92eSttZWVTamVEbnJ1UWcvNE9jYUlyWXZ4bDE0SzdIWjIyTThP?=
 =?utf-8?B?K2l4YUZ2eDYxSml4NlB5dlA5am5udmZmUitGNm1tS3A5ZVl1S3IvNThNbGdN?=
 =?utf-8?B?WTdQRUhiY2phNTNLZ3FkZmg3aThHWHhia0NCYzlaYWhJRXBtNzJGQzltWVZu?=
 =?utf-8?B?ZTcxRzNFOXkvSmVRZjNEYXZ4MnZqSk5WT2FDd1kyTlBxY05KVHY0QUhEWEhm?=
 =?utf-8?B?TmUyZFprK3RkTU5pK0hxRlY0ZGU1NDRpNUJISDlsUkxONFRDOGp0RFFYUEg3?=
 =?utf-8?B?UmtGbFQ2RjRYU2pSd1B3bi8xUXFsZGZIeHpQTlhrZkhWK3E1cHZrZ0VnSjMw?=
 =?utf-8?B?Tjd3U1B0eFl6M21LWmw1NDhhMVVwYlB0R1ZhR0R3RWVZYi9rN3B4QnNDK1Ru?=
 =?utf-8?B?MnNnd3ZvYVkxYTVmeE14cXhWa1VTS252ekNHazFyZE42VTV2aGo5T3Y5NDdo?=
 =?utf-8?B?cjdudDNNZktXWk9FUGQzNEZvUDlQanl2Zkt2SEFPWmJHRTdJRDNGcmNWV0Nw?=
 =?utf-8?B?WDNPU09WUVJlRTc4RENUcENDcURiYlJIdDNNU0ZlWkNnaHYvdXAvTnpvTmY1?=
 =?utf-8?B?ZE11dmp2RnZEeDBhSTlqRlhLTHMzaDFYSGR3dGpCZGF4WFBuWkVqSVl2b2VN?=
 =?utf-8?B?Rk9QZzgzQ0NObVlKbHpOTUZ1WXV3WEhTTWZKSG94bSt3bjdpZjc2V2pURGFR?=
 =?utf-8?B?OEg5R1RsUXdsRnZsNEgzUXhBZXVGRWZKcTIxYW5PQ1FDRDFGVWxScmtmcklo?=
 =?utf-8?B?dUVTL1JxcHFWNTM2MEgrU2xycHI5ek9JM0d2MHJpMTl6ODZVMkRqV013c3gr?=
 =?utf-8?Q?ZjNzW4ptTMKKmVo3dRQrTXbRk?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f8d6cf4-bab0-44ba-0c59-08da904ea786
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4140.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Sep 2022 21:27:52.0650
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: y5n8B4FX1UoO5f3iOg6hkXMzv3xL8fVP4IzZZ6dwU8Y7lGJECmmZgBudCJnvw0FdfuXq1/sPNroldlH08dV/1A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5875
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/6/22 11:50, Yang Shi wrote:
>>> -             if (unlikely(pte_val(pte) != pte_val(*ptep))) {
>>> +             /*
>>> +              * THP collapse conceptually does:
>>> +              *   1. Clear and flush PMD
>>> +              *   2. Check the base page refcount
>>> +              *   3. Copy data to huge page
>>> +              *   4. Clear PTE
>>> +              *   5. Discard the base page
>>> +              *
>>> +              * So fast GUP may race with THP collapse then pin and
>>> +              * return an old page since TLB flush is no longer sufficient
>>> +              * to serialize against fast GUP.
>>> +              *
>>> +              * Check PMD, if it is changed just back off since it
>>> +              * means there may be parallel THP collapse.
>>> +              */
>>
>> As I mentioned in the other thread, it would be a nice touch to move
>> such discussion into the comment header.
> 
> Sure, you mean the comment before gup_pte_range() so that the real
> code stays succinct, right?
Yes.

thanks,

-- 
John Hubbard
NVIDIA

