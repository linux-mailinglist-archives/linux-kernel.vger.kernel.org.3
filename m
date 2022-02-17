Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50AD14B986D
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Feb 2022 06:46:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234492AbiBQFrF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Feb 2022 00:47:05 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:59768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230097AbiBQFrC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 00:47:02 -0500
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2088.outbound.protection.outlook.com [40.107.94.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DCB99AD9B
        for <linux-kernel@vger.kernel.org>; Wed, 16 Feb 2022 21:46:48 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Tr/IeK4K40UcEPiTtEoTJ4PVr8hG4tgefEWwcJ8suVf113dfpqdz34H5H5Iqtk3BrwcW4fRuqR2ztsQAq3EK5BSyL00rw3MLCKHs7x0F/UaeJANrQTBPivJov9plZJdo2RMcjULy4hUVMpqJC5jWXqjfm9Oz4+7hhlE+6XG5G5RLjeHws+eLrLp7L7KPWuTgA1Wyaq0+er/2JAqNLrfY5peQ0EWzAqcacu9s+//IjW3FPORfXZSI67v8NJAOTYbNf07YgN2nF2qA1z2mREdi0QjGWmZgG+B05zgggKAK/70T3e/FQtts9Jp5ZSRJKVotJzhpxJXnRWsLB84ZYvF4hw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XWSEFogcEBpvQCfCf9gUNHzGkcZExlvDb4dDNCJeOAk=;
 b=Gr89XsRQ8A+p2mA/+1s2RH9kJ8EIGOa9dY1zG/3ZMXeJdI1jqI1QtqA/USOfLMqhwNe0H9QcpydJ0coG0h9a3YW1AXKXpdXx3xE2DPqjacveacl7B9AoFdP8meUHwlNoznR154j0karb3gPyAj2OybLKFBmoFbFX3ZtMGuJ02vv2GTQeDRAUE+w+lxBuP/VO76BiU1D7TprtLFlP1eOflZFO4CMIjs4uRV9B07Rkfyk+TXqZqdVsspM+QHGiH2IVFgt/+LHDIpCT1G3FLQY6d/GXjXudKVnSN9T97089RwD2s5uxb7Z4dsKFGSEv+M2q9OfJGqiT0GO01H5rEwDetw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XWSEFogcEBpvQCfCf9gUNHzGkcZExlvDb4dDNCJeOAk=;
 b=r2o0DdinMmOqlk0tFAQIqdwSJAus7DxD/8inPDAweDUXB3i6P5PM1051xTTzFCHy3qynsCBSL0wNOrFVUI3m4KjchK8duLeHkbkrc5PWDteB8lAGfeSnV1EeOPr8Dbyf8h3gb/xF4fZfUkL9Pos5XKdGlzRq1oc/GYRNA+WS8hxAiRA4AVwHMzk1fXDetoXogCkzQjvs7fO0nyzXcateEN5f0VkGQ/YnVthiStAdT4pFJ3korqukRYhL8VT1qmgsVA9aejOsrTtGQxPVZELOfglNB30wF5LuPEvbHwJrCrd19j95qWGsqrL0b5L1zhm09m+LkRG6zXkrsc+KLpTH3Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BY5PR12MB4130.namprd12.prod.outlook.com (2603:10b6:a03:20b::16)
 by MN0PR12MB5835.namprd12.prod.outlook.com (2603:10b6:208:37a::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.16; Thu, 17 Feb
 2022 05:46:44 +0000
Received: from BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::498:6469:148a:49c7]) by BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::498:6469:148a:49c7%6]) with mapi id 15.20.4995.015; Thu, 17 Feb 2022
 05:46:44 +0000
Message-ID: <790b82cc-ea85-3483-6626-8e047260e603@nvidia.com>
Date:   Wed, 16 Feb 2022 21:46:42 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.0
Subject: Re: [PATCH v4 4/4] mm: Rework swap handling of zap_pte_range
Content-Language: en-US
To:     Peter Xu <peterx@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Matthew Wilcox <willy@infradead.org>,
        Yang Shi <shy828301@gmail.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Alistair Popple <apopple@nvidia.com>,
        David Hildenbrand <david@redhat.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Hugh Dickins <hughd@google.com>
References: <20220216094810.60572-1-peterx@redhat.com>
 <20220216094810.60572-5-peterx@redhat.com>
 <b04fabea-6216-3808-44e8-0a2125bf0230@nvidia.com>
 <Yg3VHr28m0739GQE@xz-m1.local>
From:   John Hubbard <jhubbard@nvidia.com>
In-Reply-To: <Yg3VHr28m0739GQE@xz-m1.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR13CA0043.namprd13.prod.outlook.com
 (2603:10b6:a03:2c2::18) To BY5PR12MB4130.namprd12.prod.outlook.com
 (2603:10b6:a03:20b::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 134e3ca7-6711-4d00-f677-08d9f1d8e117
X-MS-TrafficTypeDiagnostic: MN0PR12MB5835:EE_
X-Microsoft-Antispam-PRVS: <MN0PR12MB58358924199868B130D7E7F2A8369@MN0PR12MB5835.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4502;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: T60YWeA2bbveZmL/q9Yebel6STnVILsJGIpp+b5lwm3dXQBy5zDkahrpchvEgsaRrbdzxx/g/FtyZkObAaNBkxwjIaxnmbgDQyYou6yA9fhlhLmOngweC58peNxm8yY0+ujxanTm1AO4fSSwdFrw2L/GBJhfTC223fdPxT9ukpaS/j1NJ1UH1SaN8Ov3v3tTAxIu3NfDbGjzO1aUILlhW0xm40os9WWkX35l2zE7+Nk8qI2y8EqUIEnpSkPok5+qP4ggckSfqxHytCQbBRFAeu2c77pmBpxvZgYKBT3LlbhtOm51+LDngNOU4KobET9/PYj2oejerLSS2t0m9go3mayAVpsdCV0nD5aFn3a6ZfOCewkqj0vwBa3BupKfHMTwYjNp9JUaC6ISEqtWmw2woRFfiMnuCjL3MX1UDWD9x7GCz3f0fo4YOimsgl05ZOLx/2H00zD4tgHiN2kBrpiZ/8vGpTcR2JwA8I+DrRU4OFF7A7cF40rQvX0pCEDSHgon9Y7BmCG4GeMygkWgLFsZsBxCVepTraAy7TReFze/s7yFeKK+RL50X0D4pCKhDLihPixecmm61xwQNlkOI+k/CwuWrG+orM0Xkx0Ft96nAzSwMkIc2PftgVI1DawljJBHAiw9SuBxnYZeCv5nz6zc4QXpeuvslKtS9Nir+0IJ1gWrrbBUD/Z+HYWxzKmVw33LNKip1qj6AderQ3RcKWs0fMliVWcLM7jr2mMISXD7EAeliinubdV9Za54Fd11Oznq
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB4130.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(66476007)(83380400001)(66946007)(4326008)(8676002)(66556008)(53546011)(6512007)(6506007)(86362001)(2906002)(31686004)(36756003)(38100700002)(5660300002)(31696002)(6486002)(186003)(508600001)(2616005)(26005)(8936002)(7416002)(316002)(6916009)(54906003)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RFpSKzErOGtocXlYc2xYaWFqZjZIVkVBaUlTSjJmS3o2WHVuK2p4WjY3b0Vp?=
 =?utf-8?B?YzMvNFJZUUwya21CYzZteFg3ZVVUR09ROUMydzV2ZVVTT0RPNEROdnl5S00y?=
 =?utf-8?B?QVNLQ2p2ek9FM0xsTUJmRUJ6QkFZNnNpMjNwZ3M2djQzcnFRNFU1WjVldFRn?=
 =?utf-8?B?dHA1VWhBTXFvc0N5aXVCZGEzTi9FM0hsSGh5Q2tpdnFBaGFsY1RnMnhuZlhJ?=
 =?utf-8?B?NjlncTJVeFU2dVZFTFdSM1o5cGx0NFV4K2JWaks0T0tJT2hFR2J3dVVFOGNL?=
 =?utf-8?B?bVlEeEFwL3NQK0FodndBcmxyNGJlc0EzSXFZU1d3R1dGZnJxd21maWxoVzVk?=
 =?utf-8?B?Y1BtNjFwbmVibWxMbjBZd1hHa3dIMVlGNnFIejBuc04wbWE2OXIvUmpRdVNV?=
 =?utf-8?B?dEdrS2VpWiswMUs4UXZONXVoRTZvSXBsRWNkYzZLS1dxa285SVE5VERzSWMv?=
 =?utf-8?B?WlUzMlNRenFsSUg4SWxNYnlCdHZVeDNUNDVMdkRVL2V6dVNRKzl3MEd2bmZs?=
 =?utf-8?B?MFpldnhweG04cEdzV3FrRUdEK2JsQ3huRm1QSk9IK2VxYVhpYmpyd1NyTGlh?=
 =?utf-8?B?T251Q01ZOFBpQ1A2QmRRNXdqNjJGSEZyeW9XQkk1S1hHS0ZraG1qbEpSOFho?=
 =?utf-8?B?UFQvTDhJamw5RVdmU0dnNGdZNTJtaXUreGlzeDB5ZHIwVjBoYUMwWk85eTg1?=
 =?utf-8?B?SU00dncvdlRnblJ6b1lqMlBud0NlcWtpcTFrR0krRVVDaVh2OGZGcExPWExj?=
 =?utf-8?B?am9KR3dmSG5BV2JGeVNNOHEyZVJPcU9BYklDb08wVk1Mb29JZWJmWWF5elg3?=
 =?utf-8?B?bnM4STYySHZUZTZVYmIvaVZtbGJMZEJaV3hiVFBMdlowVFdtbEpYOHZ3Qkln?=
 =?utf-8?B?SjBwaWlIVFRlOGxEb29ZdGZCOFgrNHdta215Q1ZWRllFQkpuRWRwcnR4QXBZ?=
 =?utf-8?B?ZUlkMmpqU0tHTTRoUHhRakI0Z0FTMEhDdm9PMjk2MU9zK2NxTFpVSHhEY1Av?=
 =?utf-8?B?NUI2bERZd3dNcHBIRkpBSVNFZWh4NUlKNnZQUW1PdDF5eXhKMHgxYkRCK0gy?=
 =?utf-8?B?aHljTkhWOUhIYVVSL1VXN3RQYUVzVGhxemU5MnBUSzRDY0FWbE1HOE1EQjBp?=
 =?utf-8?B?N1BYWUpWNHp6SGYxTU1YVnpKNjN1MFFBSmRON0wxemw4c2VERGZKNXZOb1JC?=
 =?utf-8?B?RElFUnI3QWFrTkdhVnpuaC9LWU5mZHdvVjRleUI0dTlZcGRodkNERVhLSzdm?=
 =?utf-8?B?KzRVQ0V6UGZkR213M2szVWJNNVNPenYzSFlFTUJneXBqUlZDcDhYN2w5ZXh0?=
 =?utf-8?B?VlUvZHllcnRtTmlPMGpsOXFiSU5nL1pXMGhMMXhvdGJGZSsyR3pGZ1Z3NFBK?=
 =?utf-8?B?U2dkTS9NVXdhamwzU0MrVWpRU3RDMHBwc2lrUG9ZMWZsM0FOdjBvdGViZ3c1?=
 =?utf-8?B?SWZKVWFkemNRWnBZZUdMMGZveFJEOXBRSmlyL3JaQXR3WkxtNnJhanZZN3h6?=
 =?utf-8?B?MzlGUE5ISEJHWmpoMmZkQW5Tc2xaRjNMZEZ5UWF3MWdKWGdCeUtJc0Z3Ky9Z?=
 =?utf-8?B?VG1SSkczRGxzSkNNWXI4dEtoMXJLU2ZFWGYvTVBlaFRTVUp5RSswM1RiK21G?=
 =?utf-8?B?emhqd3pJNER2NnF2VmpQa3l3aHkrc202OUQ5UHZiSTFCKzdSeU5LVmQzd2tO?=
 =?utf-8?B?emFwSjVIQmNtNWwzWnZrLzdtS3dMaXQwRktNNGFCOUhYT3NKRTVQSTlhcTcw?=
 =?utf-8?B?U3VJeWJhMGxsa0lqYzl0TVZXYitwVWlVVmRGRGRXWVpINXNSMk9lYTZES2Vh?=
 =?utf-8?B?UUt6Y1c4eXZIOE82V1hkT3FPVmFZS2VDKzZaUzNHOUZrTzQ3eDdVNjQ5dDcy?=
 =?utf-8?B?d1VKTldVam9zNi8xeE12K01uQW92RzFHWTdqL1dOMllMMWpUWjFRMGJhZmpT?=
 =?utf-8?B?VytaUjZGb1YydEFDajM0NXUwVWduTUZCaEI2bDdNdHhMRTJEY2U5Y1F1NVRo?=
 =?utf-8?B?NzFmeXp5cGVoUC9aMUNKOHVwV0RWREF0L0d2Z3JtdERTTUw5cjExNm51TDRz?=
 =?utf-8?B?ZG1SOTJjaFRRakJkUTQ0bzdpT1N6K0V4eENkdTZOamRlaHIwb04wS3F0S1BE?=
 =?utf-8?B?aXBzSk50YTRvK2hIVUkxMXVUTE5EbTExSTdwczA1TU5YeDF1dXJLWElucWRu?=
 =?utf-8?Q?XQ1Xad4L/7QV8jqHK4AMOuc=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 134e3ca7-6711-4d00-f677-08d9f1d8e117
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB4130.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Feb 2022 05:46:44.2403
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ogl5MsqrLmWHaXkEkR+wI3B+PaWODJK3VEX5Y/hN+Af+SFRnaP1Po4sWByIwocMvVS7Fd7IhZ81NnDdkfnQA9A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5835
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/16/22 20:54, Peter Xu wrote:
> On Wed, Feb 16, 2022 at 07:25:14PM -0800, John Hubbard wrote:
>> On 2/16/22 1:48 AM, Peter Xu wrote:
>>> Clean the code up by merging the device private/exclusive swap entry handling
>>> with the rest, then we merge the pte clear operation too.
>>
>> Maybe also mention that you reduced the code duplication in the
>> is_device_private_entry() area, by letting it fall through to the common
>> pte_clear_not_present_full() at the end of the loop? Since you're listing
>> the other changes, that one seems worth mentioning.
> 
> Isn't that the "we merge the pte clear operation" part? :)
>

Somehow that part wasn't as clear to me, but...

> I can add another sentence to it, if it looks better to you:
> 
> ---8<---
> Clean the code up by merging the device private/exclusive swap entry
> handling with the rest, then we merge the pte clear operation too.  We do
> it by letting the private/exclusive block fall through to the last call to
> pte_clear_not_present_full().
> ---8<---
> 

...no need to change anything here. I just wanted the list to be complete,
and it is.


thanks,
-- 
John Hubbard
NVIDIA
