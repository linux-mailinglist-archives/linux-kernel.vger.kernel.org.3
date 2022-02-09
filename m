Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5AF844AEAE9
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Feb 2022 08:17:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237860AbiBIHRk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Feb 2022 02:17:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233694AbiBIHQ7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 02:16:59 -0500
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2051.outbound.protection.outlook.com [40.107.237.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53AD1C0613CB
        for <linux-kernel@vger.kernel.org>; Tue,  8 Feb 2022 23:16:50 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LYxoTWwW3DFPiTsfAuX3tUgphAN3/cYseow3VmUkfhOLxQDRsZHgkUzJUa2AK5L8mh8LRw1VsUht1kDBG9uSVqX6rguPFlUM0xjbgBXqgYTPR6EtgAmEQO3x/cBDGqAW7sGySrqdnmereg0P0xr7dwuaQioh4LQZXAz0gzQPJK9qazcf/KwVGGTQiOA0VHRXeU16/3ji1WjsfIKciRTVNvza/Gzw1XEQMC9mEXsLbzI7/LLrkNQGcnlXrfGicJHdT/ahinc9tNysTVypxhkPn89tgCO1Ic/G3RvyQnBzqkxw3fvN4I54vQUn+yE0modKQXDioOqRXgrJ/zpM1pgj5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EfV7x6a6GpwGLLz68QUYdYDzNhW0zI2YccfWg067axo=;
 b=HNjbtXbIYgdU37vK5yZO0vZuC74dYuiXVQ8tV1XRHk/5veF3iuaPVLjEtpCNoQ/IEt1d42A0rd9ILv/xFZA3iICa1HWuxihM4OSjgMLiJMBnZDrWer1JaTtU0W2z+gKfubgI9cgOCIZobgpA+vhqe9zzFuAaI34euhMI2NtsDm9keNcWbC1QtSaghxrxIlod5CC2yjcgrsGu0h8znU20+bWhi55GQYxtOm7ZFTaeXRAIrcGxbO3zncB39WM5KnxkW0nurIz05QdPplCfgNgcH0P0sOIjrl4nkg0QfDTklrRKPx2m7aoIsyAbhU9cjHeHGextGa1rE2fX0LVIC0XYdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EfV7x6a6GpwGLLz68QUYdYDzNhW0zI2YccfWg067axo=;
 b=wJaH7BtxB0y4cTliXRvgfFbOePR9hII828jPMfPTN92RfbiKinMNMSJ/GNXJ0q30GE947TWZYSUeLpfcIuYTA7C58oGPGZYYwuRZzAwAD5wnkzraKMyy58NpQ1pzrF6wfnPqjZbbY23Uj9+iAK4zFjlNAunJyjtQmmEzipERBHE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH0PR12MB5346.namprd12.prod.outlook.com (2603:10b6:610:d5::24)
 by CH0PR12MB5042.namprd12.prod.outlook.com (2603:10b6:610:e1::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.12; Wed, 9 Feb
 2022 07:16:48 +0000
Received: from CH0PR12MB5346.namprd12.prod.outlook.com
 ([fe80::ad10:b9b4:d5cb:af1e]) by CH0PR12MB5346.namprd12.prod.outlook.com
 ([fe80::ad10:b9b4:d5cb:af1e%5]) with mapi id 15.20.4975.011; Wed, 9 Feb 2022
 07:16:48 +0000
Subject: Re: [PATCH] tee: amdtee: Make use of the helper macro LIST_HEAD()
To:     Cai Huoqing <cai.huoqing@linux.dev>
Cc:     Jens Wiklander <jens.wiklander@linaro.org>,
        Sumit Garg <sumit.garg@linaro.org>,
        Devaraj Rangasamy <Devaraj.Rangasamy@amd.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        op-tee@lists.trustedfirmware.org, linux-kernel@vger.kernel.org
References: <20220209032745.38570-1-cai.huoqing@linux.dev>
From:   Rijo Thomas <Rijo-john.Thomas@amd.com>
Message-ID: <302e8426-5a22-23dd-2b3b-7eb6d0ee2e8d@amd.com>
Date:   Wed, 9 Feb 2022 12:46:36 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
In-Reply-To: <20220209032745.38570-1-cai.huoqing@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR02CA0037.apcprd02.prod.outlook.com
 (2603:1096:3:18::25) To CH0PR12MB5346.namprd12.prod.outlook.com
 (2603:10b6:610:d5::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a454d120-d902-4588-dcb9-08d9eb9c22ae
X-MS-TrafficTypeDiagnostic: CH0PR12MB5042:EE_
X-Microsoft-Antispam-PRVS: <CH0PR12MB50421F9E81AC0A74225009D3CF2E9@CH0PR12MB5042.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:217;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sGsEjw6EQVb+q487i283Fhms/aJBRAhdBm/zIGBH3ts8s8rHLrIbiSsBhlCtmWHj35Y32XclXQD3m8mIY+prcGFSDfG9edIWzL2UKoq3PLdmvrt+p/GjV9x6m8iBl3W2+SFt6N5ahVsBgOggwX8jmTUCX1VrXjcAihRbudobQV+FoVvp1NBgA3Nq7dm1PlENpBTVZ+K3yIMECwNxEGxEXslOHS/bl8srQbW0sDaGMrrqMQP0nczeLEWPRxyl20pLLIxwQ/H8QMxjovLCCyVxXHOQJD+NrMBBPLOERXh9sJ95tSqd8rJJLnlvmkVJ2bmndBby/M/n3yDm2UkpPsMBJ+I47p3kbYqIu6UWMyUqb5Ey2ZFbl3xXg4Rl4nGv4q7QH1wP/b/Kjj2+xeDDTkSx0wZQNXuYjWtaZ7p8DspZa3tiVb8/t6qefcKwYPiM+OyLdo3JSvOM2vu+063cXqqjUIULzmfPAAHPWSpAZ57WLxggo9WA+q7UK/J+IRePTUX9CCtjPq6p86B2aB+xNrEOpmSP/YnqjTGkkdF6JQlxShKPdlDuJiZIXIxxRYqPVShHuohmkd2Hz2d9L6gNrPqm/b1ahP//oKsKl4ou6ptCJteexX8aNLhu5vN3nX6VqKPweK47dY6QSh0m3chqMg8Sfd6RBgnpnciGFq3oc44Ys5MLt2o/Csi4FpgX2TStq2rqu/HnoHbYpCARJc+Xs3MlecaY+b+XeugZuIpH2wh+g4Y=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR12MB5346.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(316002)(66946007)(31686004)(2906002)(6916009)(6506007)(6666004)(6512007)(53546011)(508600001)(186003)(31696002)(26005)(2616005)(86362001)(4326008)(66556008)(83380400001)(36756003)(66476007)(8676002)(8936002)(38100700002)(4744005)(6486002)(5660300002)(54906003)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?REFpQ1VESmRJZVJ0cWplMS9wMkpqMFBpbmtNNlJvd3JhTXlMcXJpNExNMERY?=
 =?utf-8?B?YWU1RDJiZTdKbHNaQWF2SDl0MTFESXlGaHdTd0Z3WmIxTDM1V1RTRmo4aENX?=
 =?utf-8?B?c3Q2Rjc1cHNscjU1dWZlaE9qVGJvR2F6VzRoMXhJMVJleEVwUFMydnJ0RDdi?=
 =?utf-8?B?ekhKREsyQUt2bWFNM0ZOUTcxcVF1aEZDR2hoeG1IQ3d4SHJHZGJYVlcwN0JN?=
 =?utf-8?B?aXFFNHMzVFFkNjllWEVVbWhWSW5GTnhBa3NmeVk3N3UrNnFFMVZ1R1JDYmRv?=
 =?utf-8?B?YkhBYVFhci9iR2VxZXNhSkFlL3RhckYyMVVSWnV2OGtxUWhQWEJuTkZYdmpR?=
 =?utf-8?B?UDBMdTNSaEY3eWNuREZ0enpLajI2OVFKUFJwOUhWS2V5NFd0QmlkMmNMUXV2?=
 =?utf-8?B?VlBvVURMN1dvVE5DY1pwcEpPQ3hWa3hXZkxBckFodTVxTVZUUld5SzBDdEF3?=
 =?utf-8?B?UlVkTnNqRVROdDdOTW93amNmT0t2YjBaalFqaG0wZkQ5aTBaWEZsUXIyRnRn?=
 =?utf-8?B?MEJtTVVjeko0RWQ4SGluZW55RS9BSlFUQnJsM1llOHJXUWVabHZCK2toM04z?=
 =?utf-8?B?NVJZdC9IZjdTdzhPOFBla0l3a2JoUjlNajZNcGdYdDRvY3F6Ykl1Rk1hRWhD?=
 =?utf-8?B?TjVWWGpIeFdjY0k3OXVCdThRU2QvQlFDL0xLbVFRZHFDSFYwWnFOd2htaHdQ?=
 =?utf-8?B?TkJzUEFKQjdoNUVHNGRZNVlXMzh6Zi9McTlUNUlPbTJseDhDaXJaaWlxUzZE?=
 =?utf-8?B?ckk0cVY2OXhuZVMvUEVLUDJ1NnVYNjhoNUo4c215ZGdlOVhaSDFIY2NVR2NY?=
 =?utf-8?B?MHF5dDh0SVh2K1JMM1J3bUFPeHNrQkRmYkdzWitmRjl1WWlRUGZpYk5YckdE?=
 =?utf-8?B?aVczbG5ZKzNma3BzQ1U4VnA1eU1VL09ub1J2T0NhUlRHVTBsMEoxMEtqa1J3?=
 =?utf-8?B?blVYNHFWRWJXYTR5ZmlsR2ptOFJzQUlMb0hBK0QwbnphSWRJeTdHeURkdnR5?=
 =?utf-8?B?clhBOWhlbXJDRFlzMGZteEFlN09ibExVd3AyVUlNeGRQaWVkVWhYcEVwS1ZQ?=
 =?utf-8?B?emh5bGFpVy9WV0s5Q3U4VFZVN01oc2s4c205VFUyMmlQL2V3QzBiT0Rxdjdo?=
 =?utf-8?B?U0JVWW1CaWRiL0wvdWlzSjRabUF5WXppbi90Z3c4TW9LR2xvT2NIa3lWa1NY?=
 =?utf-8?B?dllKbEJHRm8yVk8vamhnVHBpckdBTTlzWXFSTHZ4eVVVcFZLMU85YVRkN2lL?=
 =?utf-8?B?bzA2UWhVWUUrMzFURTFnZUVWUFIzRTFqbWRSR1VxY0RBeFVMOFdGK2pLaTVn?=
 =?utf-8?B?ZzVrVHBVZ1VuaWsyMG9OOWppRkRHanR0cnRQT1NtRWtreDlUVXB2MXNsMjNO?=
 =?utf-8?B?WUxNZHJXMmYvaWt6MGExaWx3SFcwaWt2K3lxbVpicm5Nc3hyUTV5NmlEdnk2?=
 =?utf-8?B?QzlyN1lUVmlQWU9xdWpmdkt1NmFyNUlaYWRSVDlvS0JWbUNESnV1c3BBYlM1?=
 =?utf-8?B?MzRETDczVHZ1Z1hLeUZMTTJqOS84MUVsZjRhTEZLOFhPdFA5UTdObEhoSnFv?=
 =?utf-8?B?bHUxQ2ZXNzE2bHp0WHVxU2xCYmxXYnpQOE1NeVhTRUdBbi9JZmdEUUN1V1E4?=
 =?utf-8?B?a1lLOTZWYTI5T0dUVXljY0tBWFFrbGtMaVYwL0xsd1d4OG5GcEExWkk0MXRi?=
 =?utf-8?B?bGg0dzkrRGpFeUZXMVN1UUFrTkl6dW4yaEtXTC9QalV4blJlV0RvTEw5bWpX?=
 =?utf-8?B?T2kzRHdMeXRXS0R0R0hmMlFscGE5dDVoS3VEWDEyYUJTQlAzOURRL2dpUU9l?=
 =?utf-8?B?ZVgzaUZMV04wamF5WnlnZldzclhKcTNiSXVYd1NjekpPSC9rMlZFTUlYTFRU?=
 =?utf-8?B?ai8wZnhQZzFwUFVocm5VUzFVMEpEZlRlSTBlU3p0VmFCd2VuYzZFbjN6UkZq?=
 =?utf-8?B?TldaaFpEQmdSN0pubk9MWnQrVmZ0b01KTUpUTGQ1eUJuVEhVVTQ5N0kyYmJN?=
 =?utf-8?B?N2xlaWErM05RK0tTQlZyUEYzblNJTFpucEdSRGVkK2Roelh5MGJjWkd6bHR5?=
 =?utf-8?B?eFJsZ3RpWkxUNTZhWVk5N3p0YjM2Vk0xeWN4cEx4WnllVTY4blVtSHQxUmZW?=
 =?utf-8?B?NmorK3VZN21jOTJWM2l5WTQ5SXhXUjJWaDdRS0tjNHBwdmRJWkN1Kzd1T3NZ?=
 =?utf-8?Q?ljlHOT2x4i+q2Wr0pfIiLpI=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a454d120-d902-4588-dcb9-08d9eb9c22ae
X-MS-Exchange-CrossTenant-AuthSource: CH0PR12MB5346.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2022 07:16:48.1758
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jKW3NMOskjbp3+XaLQhPOz+ApeNEjG0fNy3hG150VaoeZLL3NIQplRjnhpIF05ElPgUZO9XMHJAkHpMcAOHcGw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5042
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2/9/2022 8:57 AM, Cai Huoqing wrote:
> Replace "struct list_head head = LIST_HEAD_INIT(head)" with
> "LIST_HEAD(head)" to simplify the code.
> 
> Signed-off-by: Cai Huoqing <cai.huoqing@linux.dev>
> ---
>  drivers/tee/amdtee/call.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/tee/amdtee/call.c b/drivers/tee/amdtee/call.c
> index 07f36ac834c8..cec6e70f0ac9 100644
> --- a/drivers/tee/amdtee/call.c
> +++ b/drivers/tee/amdtee/call.c
> @@ -122,7 +122,7 @@ static int amd_params_to_tee_params(struct tee_param *tee, u32 count,
>  }
>  
>  static DEFINE_MUTEX(ta_refcount_mutex);
> -static struct list_head ta_list = LIST_HEAD_INIT(ta_list);
> +static LIST_HEAD(ta_list);
>  

Reviewed-by: Rijo Thomas <Rijo-john.Thomas@amd.com>

Thanks,
Rijo

>  static u32 get_ta_refcount(u32 ta_handle)
>  {
> 
