Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97DF24D50B8
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Mar 2022 18:37:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245179AbiCJRiR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Mar 2022 12:38:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238533AbiCJRiP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Mar 2022 12:38:15 -0500
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2082.outbound.protection.outlook.com [40.107.92.82])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA1601903C5;
        Thu, 10 Mar 2022 09:37:14 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MygH2yj+3S9Y+bcZRZSlk4LP3kc2+bjBhZYLoCXT4qcgrW3U8aMSxqoitmFUhHFosxgpBADBecYVtZCS33uvWVpeQzyBzX7lmxxlrSv85urcJ0x0aaj9urC65zbmZ67vX0Nfew6b7+8l6Ozi8WYfY8oOiW+xAhthYUxbzaEQWuRyK/dA53+d6urL2XcnSa5K1yrtK80jWYWgslSo1+xflNl/zR11209BvlDN5xsfz1rZm5RquvidHaGxumWTKfM+x46MRGzZDkdS25UybrEeYeCbIv/GSMVG+O+b7dfoe5ML8PqycWlb/910dGekDWctsXD9p7Jzc6Acv3LRmj/M3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6+YFkCge9YjV7ChOHWyt0WmOe7+tFLYNVc7ckEbbOik=;
 b=mzoovBUR0I32YpoYcGJvXljCco4BVuTBnhmh9Vu74iObz1aAluuaSZEIo1GUfOkzn10k7rXbT3JNk/Em6KG3BWAOa1VeLHSHouEp0pD+iaSxQix2YvoKPanFQkfehy7roUGmKHvpUKTx+xORD1I4S7avo5KZ+GTO65KGY/8Po3XA1NhPLKE++tI9ud64eiw+SecVsz5TlGlRVl4beQC12v7+vtqMY5HEGgHMb1UKj+vbV1+S/tgtIBaPahBXLd9CrwfOeb8V7yytBZczMnNM9dA6lNDl5CfqzpzoAJLhZcH0KxH1W9Wnc79/6wwCHO0ulMCzU/u2Oti0KLBhNTKsqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6+YFkCge9YjV7ChOHWyt0WmOe7+tFLYNVc7ckEbbOik=;
 b=bJOZxZNRg1uA5n95mqOZ7TWeu8AiDoEC03aEswsy6ePZc8f2F39OAlb9TPBBlDGwtyV53L8aFvCH7WGAyb9Sk300tv4wu4J+nh0D72/0GPHazqZzzcd+KNO23n5JBUwUIz5F7I9xqL4eYirxqBIyVmC3yWVLFf10ITiwpDvQeeSOXLgNm7QBYNQQ1YvPFOXNmnHRhVjyu0T5Azf02Kv3Zmltz7rMeioQVsEsO1VRRHBotaR1CuvVbB2tjJpqltckQBGryO5L3K1G+4+JQp0fdz/tDCjhPISZuampqlM0LMe0zKy6mpCNpTVRJm6R9gj0ggWM0ctOOPKol4XoWQgAsA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CO6PR12MB5444.namprd12.prod.outlook.com (2603:10b6:5:35e::8) by
 PH7PR12MB5879.namprd12.prod.outlook.com (2603:10b6:510:1d7::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5038.16; Thu, 10 Mar 2022 17:37:12 +0000
Received: from CO6PR12MB5444.namprd12.prod.outlook.com
 ([fe80::fd75:b9cc:faca:22fd]) by CO6PR12MB5444.namprd12.prod.outlook.com
 ([fe80::fd75:b9cc:faca:22fd%5]) with mapi id 15.20.5038.027; Thu, 10 Mar 2022
 17:37:12 +0000
Message-ID: <c84a0362-8cb0-2925-5a74-ad9c6c3ffe5f@nvidia.com>
Date:   Thu, 10 Mar 2022 17:37:04 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v2] mailbox: tegra-hsp: Flush whole channel
Content-Language: en-US
From:   Jon Hunter <jonathanh@nvidia.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jassi Brar <jassisinghbrar@gmail.com>
Cc:     linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220302150424.1305301-1-thierry.reding@gmail.com>
 <42f99db6-f450-f2dd-fccd-17868b16b561@nvidia.com>
In-Reply-To: <42f99db6-f450-f2dd-fccd-17868b16b561@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO4P123CA0018.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:150::23) To CO6PR12MB5444.namprd12.prod.outlook.com
 (2603:10b6:5:35e::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1126037a-abe6-4771-3687-08da02bc9bc5
X-MS-TrafficTypeDiagnostic: PH7PR12MB5879:EE_
X-Microsoft-Antispam-PRVS: <PH7PR12MB5879DEA161754ACB6B83B2BCD90B9@PH7PR12MB5879.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 91ae1BxaQOj27tHZLtgMzCiULhonYS7+Smcn+/SIEYbpV6XxSFLF5UHwAk73/BA3ebpWoVoKVw+g25n8OsCvY8PrQj6mU2T4Rn96bbIzrLbSzAmuRp5ltl7I/4TMb4aN1AdhrCJ1XIAsGqvDT9G7AzsElUEr/szMEpNIHeh2zgdverqhKowlbL2zcGkIPofFFsB63HkNFQFuxL3K38P/D6cyHuNXmFw1GXhIJkLvvoCsuyu5WM4JzX6ZFstI+PXGmzKxRmwDdTro8+teymDON/Us+PL9G93OMJGUElpAwy0g2l7R85YrN3CQRICpQyoWyFPKkOE6LOd5de/FEp+9Qatk4DPlhhoiShEBlpOh09/bIILnUBmoOFTRTX4duQV62YbVXsMJDagSftQOk+yH07L+T988+TGAWKxFIDyC+41kFo6HPyTUsIJ4gdxMGNs3llM/EeRR/Tgk6gO8BIrhVjru06rVQj0IJcedTroh0QVpFeTDPyFN9G882Nx15JXfoy3d7eNaOZJs2xSlflF1SfDkk3IjtyBWHZwj0c5ggRZJGsfPEh61GnmagN+ZZKJ5xY5cQhL03kt0kvKk26y803wT3W9F6Ets7wZBW65U/DSgGqibPPL/NCaHHquhduSBmksXEZQDkITnSmUXlOQ+Y2a+InCjfiaZrOZfU1YqOWCScUW7B7T75bpuwq1e6OC36+tb9BBwmdJhBaVQOR8jZ/6eSjmZqfj30xbLCw+HTcInZuvaJm/nueWhefc980/3
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR12MB5444.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(36756003)(6512007)(83380400001)(186003)(53546011)(8936002)(6666004)(38100700002)(15650500001)(2906002)(31686004)(5660300002)(86362001)(66946007)(4326008)(2616005)(8676002)(66556008)(66476007)(316002)(110136005)(31696002)(508600001)(6486002)(6506007)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RFcyemR6V2pMM3EvWFZyMCtmY2hpb09NYksyK0JuOXpmU1dZNGFaTkRndnJZ?=
 =?utf-8?B?ejZjNEJPYm5iMytsQ1cxTktXK0lSbWZSWWNWak41R2lGakZXMmNuMGxrMHJZ?=
 =?utf-8?B?OWJ0ZXkyM0Y1Yzg0WGZyVG03MWVoQngvNWhIRURGKy95NkdXR0Z3ekN3U1c2?=
 =?utf-8?B?elkrNUFoRFlvUHc5N3NsTDQ5R3JMYlRBZUhVdG5Gbm9oVHFvNkw3MHlTclI3?=
 =?utf-8?B?ZVZ3UFYwTEkwMFNKMTZJSGpGVU83V1NmTy9PWkxuQmtIS0gwNWZaUU1xWWU4?=
 =?utf-8?B?OXZUVTc2d3g4Yk1lYXJWQlhweUExRURvYVQvTVlnOWludS9IZ1BUWEhJRjM5?=
 =?utf-8?B?NzhLTk1LUUl4bnFYVFB3RHJBbDZ5em04WElMWFZpWk9lQ0Q1WU95YWxIZm5a?=
 =?utf-8?B?Q2I5RUk5SVJWRzBmRVJ1UXQ4UllLcUt2QXRMS0hhd1NKMmJ0OGIrV0tuK2NH?=
 =?utf-8?B?QU52ak5XUHAvdlE4SmtKK0hJZFQzdmdJL3Q4SG9EajZlTjllYjlXSlNZSHNI?=
 =?utf-8?B?OUllRmVSSlJzcmNvUjFJWHVHa1k0NTkraURLSk9SU0F3VEZJRW83OHJONXVX?=
 =?utf-8?B?TXNpQm5uUGdxOEdBaVRodEkwWEx2MWpMV0c2QzBqUkJEVzZqdEJsdmlTRDhC?=
 =?utf-8?B?V29vN2xydjg0UEIvREkwaWM2NkNBNXNpTmJrNVN2Y1BlTE52MkpLZzRWSEdM?=
 =?utf-8?B?YzRINWRNRUhBZWJ3QmtoK3FJdHNkRGZ1dlZra3ZyTmk0d0ViV1A5ZGVVTWhn?=
 =?utf-8?B?WmpPcUc5bVlxbENLMUVxRnBPblNPUENhZnNSRWJXRW4xL1ozN2t6LzJHWEp1?=
 =?utf-8?B?d3ZQN3NhZVdCRDMzUlFjWnUxQTFEelhPNm96a0JaNElPb25Jd1JMTm0vOVYr?=
 =?utf-8?B?RzVza2lmK01vR2JJaCtWdnV2U2NVVEY4MVl3SzUvd29yVER5MDU1WGhmbDQz?=
 =?utf-8?B?SVkrUXluWkxnaCtkMjZ3TjdMSVNuZGdSSmRGTkkveHpyTlJ5M1FoR0NUQnJs?=
 =?utf-8?B?TXY3U0NPdzE3eEgyT2dvZUJJZDBhOTJpU01zbzBSSXgwUHFubzVESzFvNW8v?=
 =?utf-8?B?SmlCaHBlejM5L2NiSTFUYytHMGtIcXhGVnpBZ1M4R25FeVRoRE16VkFNRkRy?=
 =?utf-8?B?YjFnc0w2K3ppNjRvemJvVVByaEZ0OWZHWDFtNjVvTVgyRmZtNEhCSmh3bkNQ?=
 =?utf-8?B?UCt4UUd1bW5Lc1FyQkswc0YxSEk3Wlo0V0U2Z0lRQ01KNzN2aEFiRXREelFZ?=
 =?utf-8?B?a3ZRa0FmWTRJeSt6dmw1bTFJbUtzc2wvVGl4NStZSG9ZbG1CVTB5aTlDTWVD?=
 =?utf-8?B?UzBab3B6cVk4cks5WmJzRC9tVFZzV0NFb29KNklNZXlsNW9FOFFIMDJSRnNH?=
 =?utf-8?B?MVVBVGtkd2Q1ejEwVGJOTmZWRnlZVmFuWUM5aXdsME9zYXhJVHI3Q29iRGp4?=
 =?utf-8?B?NUpYbjNwZllWczNBZnpzSmwxMnNaNkhPK1N3U3gzQXRRQkNJMmJuai9QMW5E?=
 =?utf-8?B?b0h1RlMvZVYraHhDb3FaRmppQnU5cE1la04veEphOXRZQ3NQTHc0VGpXUExJ?=
 =?utf-8?B?QURzMUZwdkQvNjhEZDYyQldVSDY1eW5pR1RZZFJWVDNXZVpScG1lZzdjeXBS?=
 =?utf-8?B?cjVRekp1S01mZzArZXZQaHZBamxORm1CQ3NKdEFZc1RrSTV1OUhQOFFMbWVy?=
 =?utf-8?B?czFlTmN6KzgwVHFLVFE0MVBRSWZWWFZxbmVSTXJJS3MvY0t3N2h0R2hLSFV3?=
 =?utf-8?B?NGUrSVdCbUpQNGNqMEY0VVprRFprbnRmZnJhRWlUanM4QUZwK2Q3ZHFvbHhQ?=
 =?utf-8?B?dEd4alZjTXVtSjlXZnJEWER4aVUvNDZMZnI2OStvVVVGZEsxTGFTbGlTOHVH?=
 =?utf-8?B?VG9iWStteHhxcGdQWFJFS2l5RnVPTnlDeWc4WUkyMnl4d3IwNjVZK0g2ajFK?=
 =?utf-8?B?bG53eXBPRTRBMG00UDVQSkI0cFcycTB0YXd0RlBFYUErSlQvdkhwU1VTNGtH?=
 =?utf-8?B?a1c0NFEwVzZFL1kzM0lNaDZTQW5DbHhkN1hlcnptUm9Ec0dGVVJrejlQbDBR?=
 =?utf-8?B?Yk8rMFZZblB3ajRteVZOY3h4ZGl1bU5vNVR6akppaHNlNG1yNy9pZXZDK1R2?=
 =?utf-8?B?NU9teVdIV0svNXRERFZjbWJNSmdldE1JaklkOWVqdTFreEF0a1FZdUxEbEtO?=
 =?utf-8?B?UVpMYUF2M21CMms5MDBaUDI5SW5yVVlsYktROHdjWTdqUzBTaXFLc0F1OCtD?=
 =?utf-8?Q?81NsPvpaMgzt4oKzggxJghB+2fc7nlVzyr8VT5mgp0=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1126037a-abe6-4771-3687-08da02bc9bc5
X-MS-Exchange-CrossTenant-AuthSource: CO6PR12MB5444.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2022 17:37:12.0283
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lPklQJWjilFggL4GDeYWHZAL7IU3chKKf2dhpx68pxlaWc07tdtXS9Qm1WG6AMsLtbMA3x25T1lbdN+B8v4X5A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5879
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/03/2022 16:51, Jon Hunter wrote:
> Hi Jassi,
> 
> On 02/03/2022 15:04, Thierry Reding wrote:
>> From: Pekka Pessi <ppessi@nvidia.com>
>>
>> The txdone can re-fill the mailbox. Keep polling the mailbox during the
>> flush until all the messages have been delivered.
>>
>> This fixes an issue with the Tegra Combined UART (TCU) where output can
>> get truncated under high traffic load.
>>
>> Signed-off-by: Pekka Pessi <ppessi@nvidia.com>
>> Tested-by: Jon Hunter <jonathanh@nvidia.com>
>> Fixes: 91b1b1c3da8a ("mailbox: tegra-hsp: Add support for shared 
>> mailboxes")
>> Cc: stable@vger.kernel.org
>> Signed-off-by: Thierry Reding <treding@nvidia.com>
>> ---
>> Changes in v2:
>> - add Fixes: line
>> - Cc stable
>>
>>   drivers/mailbox/tegra-hsp.c | 5 +++++
>>   1 file changed, 5 insertions(+)
>>
>> diff --git a/drivers/mailbox/tegra-hsp.c b/drivers/mailbox/tegra-hsp.c
>> index acd0675da681..78f7265039c6 100644
>> --- a/drivers/mailbox/tegra-hsp.c
>> +++ b/drivers/mailbox/tegra-hsp.c
>> @@ -412,6 +412,11 @@ static int tegra_hsp_mailbox_flush(struct 
>> mbox_chan *chan,
>>           value = tegra_hsp_channel_readl(ch, HSP_SM_SHRD_MBOX);
>>           if ((value & HSP_SM_SHRD_MBOX_FULL) == 0) {
>>               mbox_chan_txdone(chan, 0);
>> +
>> +            /* Wait until channel is empty */
>> +            if (chan->active_req != NULL)
>> +                continue;
>> +
>>               return 0;
>>           }
> 
> 
> Any feedback on this? Can we queue this up for v5.18?

Feel free to add my ...

Reviewed-by: Jon Hunter <jonathanh@nvidia.com>

Jon

-- 
nvpublic
