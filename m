Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D64E5A677F
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 17:33:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230500AbiH3PdH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 11:33:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230483AbiH3PdA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 11:33:00 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2058.outbound.protection.outlook.com [40.107.237.58])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 230F1155A7E;
        Tue, 30 Aug 2022 08:32:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N2ceuUgt8ZsjiGMq0Du6cAfzyroOX3fe4Mrvo/yClr8qIpa/aczImj3bz9vT77HJ8/zk+vG28mr0p61DqX1eYPwL3SJemeZozbNvZHIpHoqrdTqTa8QRLC41SRQtA86xpUptN2s0hZREbwHIy3T5e1XOF36vzwoG5s9Rf9Iks3Tqjuu6AnUpFF+Kj13YIOMBQIySzA9eP123BbaM3WIS8RGUOTzQEZbimoYrsLtm7V6kwNJCfcIpJnit4SjfiCbmDk03r5jSE1ZWjNjSnhgMvNxrn4cdQh76ui0F4jKGijFvd9vVMg1g3hQkk9ga01zrn+Nq5yKyzFNaS481iTh3Gg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kU9UyElRHN2XrekQKRSJec3KqWD479mCecXHZ3GdwNo=;
 b=nXmwzAw/VMDjjWrq3aWa4Gtx+XOEtSQbrMvKM7Wk3T3d7WZsqrwqoJlb1jPzblK+mu3EBBVhh4qVF/xA9l5pbxGfe56mdkG3Wx6+/YHo4ZIjUNYWkvEdAgCT8prwsKEhCPpw5YSa43KEY+bvnCc3baF0oGWf/rsm5bAMcEOkBs2a0bXNQ9jdWZyIOJY0thhJwx+MWFKG/U9xvaVHen86+2ZVfBhzgCihYdBJNQHzdhAmQ/+Zsz5p+jA9YF8lVV8gEogFrWX5ADoczcIniJJzv5JwduA+v9x+n/6R367ew5ggSsMykHXwr49auiQ/tfbloVGOR4mMNzziWs9vyoUCDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kU9UyElRHN2XrekQKRSJec3KqWD479mCecXHZ3GdwNo=;
 b=bkOB10w4Ppdow1ovn/3i2LMoYZp4r+M+yGiJJesqfZbkiqNFaP3rhjtPXscuUJ6NgXSWWKA6+8vb4AkvYQXRN0gqJOG4TtTVasyU8+bqck5CNFsvaVypvfwrVSAk1vpu46CVopvfZovJSB+ryVMOvlt93F/5m2SvcK6Ua5PqcMs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5229.namprd12.prod.outlook.com (2603:10b6:5:398::12)
 by BL0PR12MB2579.namprd12.prod.outlook.com (2603:10b6:207:4d::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.21; Tue, 30 Aug
 2022 15:32:48 +0000
Received: from DM4PR12MB5229.namprd12.prod.outlook.com
 ([fe80::c175:4c:c0d:1396]) by DM4PR12MB5229.namprd12.prod.outlook.com
 ([fe80::c175:4c:c0d:1396%4]) with mapi id 15.20.5566.021; Tue, 30 Aug 2022
 15:32:48 +0000
Message-ID: <c3ea3992-df42-3a26-6d30-834368faf91c@amd.com>
Date:   Tue, 30 Aug 2022 10:32:46 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: crypto: ccp - Release dma channels before dmaengine unrgister
Content-Language: en-US
To:     Koba Ko <koba.ko@canonical.com>, John Allen <john.allen@amd.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220830093439.951960-1-koba.ko@canonical.com>
From:   Tom Lendacky <thomas.lendacky@amd.com>
In-Reply-To: <20220830093439.951960-1-koba.ko@canonical.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BL1PR13CA0435.namprd13.prod.outlook.com
 (2603:10b6:208:2c3::20) To DM4PR12MB5229.namprd12.prod.outlook.com
 (2603:10b6:5:398::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 092521bd-5a50-449f-f806-08da8a9ce4a0
X-MS-TrafficTypeDiagnostic: BL0PR12MB2579:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OjYaQuQ146taODpaCsrwOCRL3YnxS0cLQZX3rN96E1LR8ZtGGmthsr0O5oD/buWMTIFs2qn9RSKaPLDRnRUqvXYwwOnzQbWTDShEaZ8OtzlSxPivCFt9pJQhZ4fb/rFqnAxBybK8Hz4KpetSKCCS+73xGMPErGySgc8c6g+Bz0tQPP4M6j/7qCsneSNGHgHYk1WbUWCKqPYbZ9qq3C2ijSSQl3eoa/0paHZrpN3NGfidOcQb9d4BaGcdggvyH3D7LuHM0KPTmyMEkugtG5Qx+vLDu9NZL9u6ydS5+QpBz4CvGTQrXiKFsywHJLtFTokzSBICYUqIOIQTgB69GOn1y10OmexPAzTpK2n9PqMoyn6AYpNuC0FRHI6xa3R7iweAuIzjGkELDwgP3Ma62yL0xdqobwC8aki090PDZZ3X4oEmH1E+s9CQw4N6/RaOFe6GWU3eis0DVfK9YV32CppVgtRe7tDDcpGnoYxazHXQ68mJgQYy609m3M5Vko52pXoGeDOtv+gXzJJawyDzhMbOjeo3LiCCPaFnwyKS8K3cC2vO3SzArwb0sJvF+dUpQp/l7cjXCuhmy7BRSNZjNiwtg44ZAgQSPijBssycEk4lo4MvX9CcUBwF7Zr/VEeyrit/B3EmVGF7oytOc8wyphkQo+Aq+tsUU7puAxiLKv8WziQ1svGC9HXkDYuhrtVYeZLoeWeSbiReqf4RfEPJK0BNl8vM/6CHB9zczFG80foLiSyhPCJ8wXcwtnNPUcOeRNYEfUh/DihyyZvA2GC8pmB6fA9Kl6RrWHfdDNtnpY1YUeM=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5229.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(366004)(39860400002)(376002)(346002)(136003)(396003)(6506007)(53546011)(31696002)(6512007)(86362001)(36756003)(26005)(186003)(31686004)(478600001)(2616005)(41300700001)(6486002)(83380400001)(316002)(66556008)(66946007)(66476007)(8676002)(110136005)(8936002)(38100700002)(5660300002)(2906002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?LzBDWXBSQitTeGRObE83azNUaXFLWUVDNFN5WHVveU4ydGpGVTNaZnI3MS83?=
 =?utf-8?B?cTlTMVNsYVNhUFRIaVRZd0xSVy9LaG5zTjdQdmc0dzlnZHBUVkdvaDM5bVNP?=
 =?utf-8?B?emt0Vk5odkFaQlFwQWIxbjdUQ3NXdEhCdjY0cFRxZHFYRnlKMDF6clJWUXUx?=
 =?utf-8?B?SnZkd3dORmduOFlPcHN4SVpkeitvSUtaSWY5UCtsUloyVExEbDFBcm83dU1H?=
 =?utf-8?B?UDQ3TVQyMnYvc0IwbWtNUGVXVnlqbVcyOXg0NzJ4MXkrb05iWXZnY3FSRVla?=
 =?utf-8?B?bXQ5TVhoQ0JzY1BsMG0yd1NONTRSa0RIeFZHaHI2cU1XVDZKc1JJd2YrVzhI?=
 =?utf-8?B?L3NrMHNLR0NLcGtnWVFPWEpGMEpFSzBTRVcyaE1PNXdTMlgvV2dhVko4bkpI?=
 =?utf-8?B?Y2ROVmtCcCtFU0dSVDB1S28zOFRkOFhqUGtlY3k5djNYWjhndWRUQVRzcEVL?=
 =?utf-8?B?MWYxaElnK3VPVllTK0FmT3h5NGRDb21ZaDdNQzgzeTFHeWg5N085dEdCNm03?=
 =?utf-8?B?WkU4UmVxdjhYcXhBVTZrTk5CQXU1QTFHSm5BRjU0TmNia0R6aUYvVUFZZmov?=
 =?utf-8?B?VkNZODYydkZXSDkydTFOdFB6cHJxUFBwbVVRWEFaS1ozdUpudDA4a1JMbXZQ?=
 =?utf-8?B?MlRSMVVHZ2JHTkdla0JwMHdrVW9hNVo0QTZoUDVnajBybnpTaE1yQy9SdGZa?=
 =?utf-8?B?TGRYam1EWUk0VTQ5azQ3NEVnTzRFa0ltWWFjT2wyVkNkSjFJM2NMWS9YZEJx?=
 =?utf-8?B?a3pDOGViUFMvcnFFbWxCbkNQaDhXMUlIL0dibmRLbEFUdlVocWdqaWhaM1RQ?=
 =?utf-8?B?Slo1M0dBS1dNK0VFaHFWSG9ZQS9JYWFqQlFXM2pQdTNlYUlPWGNUanY0eFhR?=
 =?utf-8?B?ZENHV2M0VTliNTF5VjlnTDBJYjVMMEwyR1VTUnVxZHdHLzhsQmpKbnBNY1RE?=
 =?utf-8?B?L0txRkVSM2RTb0dUbnVEdTFlcHRKVGF1Y0VhVnpTTmJEWDJIQXVIcytJdGZH?=
 =?utf-8?B?d2FFKzUvMjVkcFFuMnRPWXM4V0VBcXRaeUVqV3RZOWs5d2xzbXlJT0ZJOWJp?=
 =?utf-8?B?Zks1cUVXTUNCMEwrcVJLazNCNDAzWVUrcjgrZnlVSnRROS96T3FBSW5YbHVE?=
 =?utf-8?B?YXBFRERvRXp5cUpFWTlma1JJdW1kSzE0V2todWVrdE1TamVLWDJXL3duTWRW?=
 =?utf-8?B?UU05SitUZzR0eGZHTVdqRnFHcndTOW1aTnlWQ21xZnZ3cDZrQjNIRnFCRFVa?=
 =?utf-8?B?THlERHl2N2l0b21BaHVDOEswWlZUd3UxMTZpamVTYzFQUDVjMm0ydXBmWnJk?=
 =?utf-8?B?bjN6aStDSDUrT3hOZmoyR2xGVFdXaGlZRmpPaVlvUG1YVGY3NlZsUEgxeER3?=
 =?utf-8?B?QkoyTVZBa0tMbE45UGRMYm8zSVgwYVVoZ3N2cjd2aXdoT2x0cWJ1c1dFTDVH?=
 =?utf-8?B?V1NISWpzYVBnelJSSVZjN0hMRWU1cGIyUkxSb1Rla3pBMm1zNnVuZ0hOWWll?=
 =?utf-8?B?b0NHQjhybllwdnpoMFRiNWpLNHVYOVpMWmxGTlNtRU1LZDhEYlh0Z3pkYm5r?=
 =?utf-8?B?RkRWa05LSnBzNGJLN1Vta3J2Q3NvQzhLUHNoajYvaEdHeWtoZVpRNEwwbUNx?=
 =?utf-8?B?ZCt0MmZYOUM4TFhkMGpzcWhWcll2MTVhNVQ4aUNyZnlrNlhSLzU4dU9LL0Nv?=
 =?utf-8?B?djlBL1VOaWZ1TkVZYnZackZHOUJEUGcwQ2lVWVdlNUlxWEJZTk51QytOY0Jp?=
 =?utf-8?B?UGpmaGdOL21SUVNROEtnWlRGYm1scmpmRmxSYTJIbXpKSGJZUExYdmwwNith?=
 =?utf-8?B?VjhEQ3VvdTFzSldXNys2UXE2b1JacjAwNVdqTUI3S2N5andsZUNmbzhvVTZY?=
 =?utf-8?B?b1pUQy9aeUZBU1JUUTdkblUwQXpKVUhRS3BlT3pmUStSSUVZdFlESnRBclZM?=
 =?utf-8?B?QUl2WDlTRDZEa3Y0MWJjQzBlbjQrdW9rcDY0YUplanZxYzlwdWp0c0lyQ3NN?=
 =?utf-8?B?d1lMLzFGMnNjUnVHRDNYS1VJOHAvcDBQN21qY05NekNUYkRPOG5XNmMxa2hn?=
 =?utf-8?B?WW1LVFIwcmlBVy9JWE5QdEh2cXUyaEh1aDNoS1AyRFBRYmsrWlo0Rys4TkpZ?=
 =?utf-8?Q?E4tf+2Gwof+W/AThEnkbx9gE2?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 092521bd-5a50-449f-f806-08da8a9ce4a0
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5229.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Aug 2022 15:32:48.3506
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BuufsAVh94TFDqWv91VeYL96hitVhZ7vJmaPJfkTynYseBcAIZ/KYT0Y5Q3MIwzsWbdfKBFJeyg45KbPfuxi8Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB2579
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/30/22 04:34, Koba Ko wrote:
> A warning is shown during shutdown,
> 
> __dma_async_device_channel_unregister called while 2 clients hold a reference
> WARNING: CPU: 15 PID: 1 at drivers/dma/dmaengine.c:1110
> __dma_async_device_channel_unregister
> 
> Call dma_release_channel for occupied channles
> before dma_async_device_unregister.
> 
> Fixes: 4cbe9bc34ed0 ("crypto: ccp - ccp_dmaengine_unregister release dma channels")
> Signed-off-by: Koba Ko <koba.ko@canonical.com>
> ---
>   drivers/crypto/ccp/ccp-dmaengine.c | 8 +++++++-
>   1 file changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/crypto/ccp/ccp-dmaengine.c b/drivers/crypto/ccp/ccp-dmaengine.c
> index 7d4b4ad1db1f3..ba3eb1ac3b55d 100644
> --- a/drivers/crypto/ccp/ccp-dmaengine.c
> +++ b/drivers/crypto/ccp/ccp-dmaengine.c
> @@ -641,6 +641,10 @@ static void ccp_dma_release(struct ccp_device *ccp)
>   	for (i = 0; i < ccp->cmd_q_count; i++) {
>   		chan = ccp->ccp_dma_chan + i;
>   		dma_chan = &chan->dma_chan;
> +
> +		if (dma_chan->client_count)
> +			dma_release_channel(dma_chan);
> +
>   		tasklet_kill(&chan->cleanup_tasklet);
>   		list_del_rcu(&dma_chan->device_node);
>   	}
> @@ -762,12 +766,14 @@ int ccp_dmaengine_register(struct ccp_device *ccp)
>   void ccp_dmaengine_unregister(struct ccp_device *ccp)
>   {
>   	struct dma_device *dma_dev = &ccp->dma_dev;
> +	struct dma_chan *dma_chan;
> +	unsigned int i;
>   
>   	if (!dmaengine)
>   		return;
>   
> -	dma_async_device_unregister(dma_dev);
>   	ccp_dma_release(ccp);
> +	dma_async_device_unregister(dma_dev);

Seems the right way to get rid of the warn, but can there still be a race 
where the channel is grabbed again after ccp_dma_release() and before 
dma_async_device_unregister() is called?

Thanks,
Tom

>   
>   	kmem_cache_destroy(ccp->dma_desc_cache);
>   	kmem_cache_destroy(ccp->dma_cmd_cache);
