Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C3A74D4FC1
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Mar 2022 17:52:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244349AbiCJQxG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Mar 2022 11:53:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244303AbiCJQxA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Mar 2022 11:53:00 -0500
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2041.outbound.protection.outlook.com [40.107.243.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FF14198D17;
        Thu, 10 Mar 2022 08:51:57 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W6xQ/BVAtv3M/6//65Q8JGu+C6RyNdYEwsMl+ITSEPFUcW+jScR7ZhbS3EJmlqsFaONv4X6u1EReDOp3v0WkqFSxxAMXzso2iDUKxAwG0EsAM1nmD+z+uVfNmptmiQ2uTFefxB8VPGKFBSyPsq6KvwQ0eEjyOcqKGbbV5/AygX4crIqA9nJMo+oPsEMj+tB2J4KcdHaXpQEXzvpcH5Fjwk0MDgJFWnpHpJOM4RSpbltjsYWbJbOhX1KFIYWRnjDZSchdw3Hp6JCuD06eXI6pYT8qaaLoKNDu6LQgIEhVv0Edbvub5QCdfB7fNL4hQiiE+EEoOvnRKTOIb+yC6B7JvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Xgf2e1FJTDH3LxidPdISuMO/+/jGVCLL40FxqC3uX+o=;
 b=TSxvMv+LLFTGuMjMjPO8mQJDYBlEw/1+Ht8BQLcmJCrbwPsGOZmGh4HBM+Og0uUH+NCsBZU47uJ6PHnxN2FCUBSuNO3xlThMwyYEbhT05vKMt4H2NXGZ//CKzRZje91yPVs0qkLd2puxKS3ZFPXLobi8dZFwKwBLrKPViXsjNR//hIjmKYBd7YNUBGZm+SG9enHA6ZPmDwqtVPiZqP/zHy+30gq0lcB7Tq63s2IFg2WU/wP+l8VT+2/L+Ho1z4sJXkec6DZRk1RXsXZtCef0Sbemhx5l4L83QXPHfab3Y8CEjQH1yjo350C6mzSjtOTVS3U9HU5g5YqliQrTus5S0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Xgf2e1FJTDH3LxidPdISuMO/+/jGVCLL40FxqC3uX+o=;
 b=sFidxRyOpmcPJ0+BJRWDFiOj5u2CkSEPk28CL4VCGpitR3p9oJMczq4VTNRjPvcTJ2KRqZIlCirkJsP8BvM3m8USRG7IzyJZV+zb4pgNhCw4yODtKn4rrs8/QYCBjnTwZtKCU1uwBCdhpqInn4ZJuFb6H9gNGZqKB/YurjTqX1qxICVWnqEW6HAqmxBwJ412MFpEYsft1gmNf21ESBARV8k30ebt/1UccSHI6KPLUXRz30eiWlqFivlSLhTX41xAHQ8bhDSXN20KsLDuKqBNLlr+5T6jI4S+Ff9CSiW9dU0WBDUPjYWbqIAUrrlgoiCOk3QINk1y5AzjC9tAWsZXLQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CO6PR12MB5444.namprd12.prod.outlook.com (2603:10b6:5:35e::8) by
 SN1PR12MB2446.namprd12.prod.outlook.com (2603:10b6:802:26::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5038.15; Thu, 10 Mar 2022 16:51:55 +0000
Received: from CO6PR12MB5444.namprd12.prod.outlook.com
 ([fe80::fd75:b9cc:faca:22fd]) by CO6PR12MB5444.namprd12.prod.outlook.com
 ([fe80::fd75:b9cc:faca:22fd%5]) with mapi id 15.20.5038.027; Thu, 10 Mar 2022
 16:51:55 +0000
Message-ID: <42f99db6-f450-f2dd-fccd-17868b16b561@nvidia.com>
Date:   Thu, 10 Mar 2022 16:51:48 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v2] mailbox: tegra-hsp: Flush whole channel
Content-Language: en-US
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jassi Brar <jassisinghbrar@gmail.com>
Cc:     linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220302150424.1305301-1-thierry.reding@gmail.com>
From:   Jon Hunter <jonathanh@nvidia.com>
In-Reply-To: <20220302150424.1305301-1-thierry.reding@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO2P265CA0345.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:d::21) To CO6PR12MB5444.namprd12.prod.outlook.com
 (2603:10b6:5:35e::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a17856c1-0682-4753-6626-08da02b648ad
X-MS-TrafficTypeDiagnostic: SN1PR12MB2446:EE_
X-Microsoft-Antispam-PRVS: <SN1PR12MB2446042339B004D41A7BE7F0D90B9@SN1PR12MB2446.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: n3Gsb7gShrHIkCEGZMok8EV35BiLE+BQYfLCfKvyklZeXdzvCzfTnWxYJ6HWoQJu6DkD8qGOs7zEKRJSiB95UBRBPgRR+jKf62naRUhaavDVpQ9KJYj8MXz2n+RHKpBBuEld7pve4pXfk9N+TR1fYnuRWuXyZCg7GhZIRRSHWy/R9hIQOJmJLjOtVTdEAyB0rO+XudX1fuo7REzW19SkSrWMv72vv5zlFeb36AsBbcXcbvBP1AsknadEkWFLMPLApTHhQZHbbVgX+gs26Asvb49+upQ0AqMpP6eUW8J9YzEe+6G2nUNbiWlSK1UfkpI9aABRK4kHcAjXUaVx74eq6gblqFsU5Nmo7ynEO4lq33O67NS+RXm5FGbX3M+SmSKBzmviaBxxjxIT3kRSyIzGZZ/1jYc4/ZiNZ2oiuDo1w9p/SdLwr5L1k5zPsXXLE1VnPbtOZ4SWdT/fYJBrA2revZOsiVoqq0dpURfAV7Ts6MfiAF82mfumBgGuzxUND5VK1GgDkqSbZpYKtvk3pG42ycTMnlgdmWfoy3rXDLVneAj+ANrar73M4HAAvCbHBZRoDSGlXncTWfpos8SnJubuLfm+GEZfMMMuEX8/G5AAXP5CiNMA7PBCyor3UqgYq1QXEkob+2HvZpHTqVwJodvIeg2DLe4nA/SBUyAHpXK9GBP09tlrjhUs9iVqm+UYYOwuTolMgCUCPifoGXnkCuaCg0L4Yz/NxTLWwGEZ0WSrwuDHMCG/S7JFZGxG3zOyOn9r
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR12MB5444.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(6486002)(15650500001)(31696002)(6506007)(83380400001)(53546011)(2906002)(6512007)(66946007)(508600001)(86362001)(8936002)(66476007)(8676002)(66556008)(4326008)(5660300002)(38100700002)(31686004)(6666004)(2616005)(316002)(186003)(36756003)(110136005)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RlZDSG1oMkpTZ3RsRWxxZXd1ZUdCKyszREFVa2NqbCt3VWdDbUp1bGx3WHYy?=
 =?utf-8?B?c0tkMWtrSi93MjlVak5Bbm5aNWpqZGd3OTJhQ2hsRWo3SHpUanJ3RlRNN3RL?=
 =?utf-8?B?b1dDRzdVN1ZZWGhxb3VjWWc1aFg1a3NvczdTV3pEek4wajRITDBiOURIZ3Zs?=
 =?utf-8?B?TmhQWU51VlF3cGVidXZUeWNJdnBhQlVnbGluL2xpVWVpMG9paXFBVEJ4UENs?=
 =?utf-8?B?U1lnbVJWNnlKYWc5T1U3RmgwNXdTN3VpOFlkRTROTGxXSWFkVlAwaUp2ZjEy?=
 =?utf-8?B?Y2tRVXFPYWZ0VWNMUFBBa3ArQVlGR1czZUJTQkhlMnFud3pURDZHNDJIN01I?=
 =?utf-8?B?aWUxeS9GVHl5eDlWMTFZOGlNWTZVQ3NYVDdxQnR4bGt6YWl4cHN6MTJTcFR1?=
 =?utf-8?B?dURWL2lJcURmWUt3U21qaUM1QTRFVXJNblMvZDBvcTFqQ2tRc2NRek1uUHRw?=
 =?utf-8?B?a1ExdWt4UmNpL0gzZkEzU0ZTaWxySHNVQzh6ZVBaUlQ4Mk1PdmxneElML2Z2?=
 =?utf-8?B?STNJTUNLYW5qRG9GN1FwSEZIaVVsdmNQWjZzT21XeVlMOEFIWUxHKzY4RG0v?=
 =?utf-8?B?TGl4SWYra1V1ZmFwdk5BbTcwOVdicTlZZFVNemFieWpmYmZxL0JBZENxdjRV?=
 =?utf-8?B?U296SG90R3N1ZzBZSXpYY3kyRjZ6a0FVR3drSjcybnVBOEErRFFoek14L0Na?=
 =?utf-8?B?VW5tUUpsQ0wyb0YwcWpiRDBSV0FTY1JNUjVvTnUxQXZNaHF1SWZGb21iN0x1?=
 =?utf-8?B?NGZOUkk4NDkwSjQwWXhZVVo3OWVRWC9OYVEzK2grZGE2Nk1TNjQ4YU5CWSsz?=
 =?utf-8?B?Qnh2ektjY3JnVklna3ZNVU9EbkltTTlLZWxwUS83ZE90NnNRSEVnaG54R0tN?=
 =?utf-8?B?STAxMzFHM2hQVEExL3RzUWE4M0l5aGM4Z3JibTVCQ1dnaCtKMEcrQWExeDNW?=
 =?utf-8?B?VHVhUzZlalBIajFQemNOVENjTlgzL1RkT0FCdXJKdkVNMElIaHBLU1FDRUty?=
 =?utf-8?B?VUpLYTBLWTdrTG9FQ2hDMVE5N1MvZGtwdEpseDlPTW9yeVVLdnVxaWs5Wk4r?=
 =?utf-8?B?MFh5cVkxYUg0ZllRMTZpTG8vVUJrOVh0QUpJY0drZEpxVDJpN3R0NUFtWW4r?=
 =?utf-8?B?R3EwaXBYOVUwbGJNaHJMb09SMFNRRHRPbVhqajRXS0V2bGhVYTdUaTlZK0l1?=
 =?utf-8?B?NDVTMmYxTEh0aXR6RFRLbElXUWwwN01DbE5wYWlnMC9NeElOZkJZQU5rTWV3?=
 =?utf-8?B?Q0NEUGx1dkR0aDc5TUZqTXFjODA2cHZqTHR3RHNQS2pTcTQ1emN5WjUwdXdu?=
 =?utf-8?B?UVlZM3dpdk5JNmY0T1lHLzVGRkNkSmgwdmkwWExGMmNFdWhIUThaMTZYMjF0?=
 =?utf-8?B?akVMQTFPTThFNlZXeXI0MVlHSTNTdWgrMSszbzlyVFljcStlekh3a3dDaWgv?=
 =?utf-8?B?Z2RyRGVWMngxVHpsYlA0UmR1L2JjMzlnYW9EdkpTcmdXOVozVEhsMHFSbjJO?=
 =?utf-8?B?b1FSamJ6aU1SWnlWVlJUUmxYVmsrU09TYXU0OU5GdElxSjh3cUpHR2QzaUNw?=
 =?utf-8?B?cTRXRVNSa3BoSGRMZllmeDMvNG5HcGYwakRMRVhPcWRRbWJ1Nyt4QWRsb0Z3?=
 =?utf-8?B?aFQxMFlCRU1RTTVHOEJFeFdjRVN0MHJMdzkzNjlEc00xT09SRUpBUDdUTlpC?=
 =?utf-8?B?UW9DMTBKdHR2UUQ0bVlmcjZEVnpkb25jT3VZU2hqT0Z5eDRwSmYvbnhTTWdV?=
 =?utf-8?B?K0NWaEhHVWhmeHpKeC9xbEl0R0NVRjhmRHVkTlExNGtxcVE4dXlRL3BUdTdU?=
 =?utf-8?B?d1JOMERlWmNwamFDcUQzM2hETXlIMmJudnFkMG9lWHMrS2V4T0Z0Q3Rkc0Nm?=
 =?utf-8?B?VDBsMFFpUzRNWDZLVk5OSWF3VnNXM0ZzU1Q1MXY1RDl1ckdER3NWR3JRcGcz?=
 =?utf-8?B?VVNpTlI0Z3YwVDNsYm1zeGk2dUdYY3gwMGRGdnRFd0R5anlFeU1FaGxnQnNs?=
 =?utf-8?B?UDFsUERSQ3pQUGhoUEIrZmw0Q1lpN1J1OGZZZ1VldmhMQnZLSUNySWIvQWhl?=
 =?utf-8?B?TEFYZThnZjRNKzIyWENIZ25DOGFianh2eVU1djU3cy9qUURpcDROaHZxbCto?=
 =?utf-8?B?YndXMU5nZDlVUjdQT2taTkNORWtnUVBDN3lWK0twSm1zWkt4Y00vSVRpSERB?=
 =?utf-8?B?WXByR3lLSlUvMmRaWDU5RGlzR0JNSmV4djJGYk0zWDkrbGhMMWNFRlRlanVN?=
 =?utf-8?Q?AvQ+oHENk7QiSNMN9tjrdSZeMNtjGXU9DuiKT0cMTs=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a17856c1-0682-4753-6626-08da02b648ad
X-MS-Exchange-CrossTenant-AuthSource: CO6PR12MB5444.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2022 16:51:55.5629
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RdD2dwH78n7pn2JI821FlXmuexqpUHDLFBLuJnoGH1vo+/SYO6AigRPbwhhtBEuuKEN9piB4jlELoAB4hV+7VA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR12MB2446
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

Hi Jassi,

On 02/03/2022 15:04, Thierry Reding wrote:
> From: Pekka Pessi <ppessi@nvidia.com>
> 
> The txdone can re-fill the mailbox. Keep polling the mailbox during the
> flush until all the messages have been delivered.
> 
> This fixes an issue with the Tegra Combined UART (TCU) where output can
> get truncated under high traffic load.
> 
> Signed-off-by: Pekka Pessi <ppessi@nvidia.com>
> Tested-by: Jon Hunter <jonathanh@nvidia.com>
> Fixes: 91b1b1c3da8a ("mailbox: tegra-hsp: Add support for shared mailboxes")
> Cc: stable@vger.kernel.org
> Signed-off-by: Thierry Reding <treding@nvidia.com>
> ---
> Changes in v2:
> - add Fixes: line
> - Cc stable
> 
>   drivers/mailbox/tegra-hsp.c | 5 +++++
>   1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/mailbox/tegra-hsp.c b/drivers/mailbox/tegra-hsp.c
> index acd0675da681..78f7265039c6 100644
> --- a/drivers/mailbox/tegra-hsp.c
> +++ b/drivers/mailbox/tegra-hsp.c
> @@ -412,6 +412,11 @@ static int tegra_hsp_mailbox_flush(struct mbox_chan *chan,
>   		value = tegra_hsp_channel_readl(ch, HSP_SM_SHRD_MBOX);
>   		if ((value & HSP_SM_SHRD_MBOX_FULL) == 0) {
>   			mbox_chan_txdone(chan, 0);
> +
> +			/* Wait until channel is empty */
> +			if (chan->active_req != NULL)
> +				continue;
> +
>   			return 0;
>   		}
>   


Any feedback on this? Can we queue this up for v5.18?

Thanks
Jon

-- 
nvpublic
