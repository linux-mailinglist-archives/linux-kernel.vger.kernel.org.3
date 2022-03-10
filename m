Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5AE614D42D4
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Mar 2022 09:48:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240493AbiCJItS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Mar 2022 03:49:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231153AbiCJItQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Mar 2022 03:49:16 -0500
Received: from APC01-HK2-obe.outbound.protection.outlook.com (mail-eopbgr1300111.outbound.protection.outlook.com [40.107.130.111])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BF1BF4628
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 00:48:15 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a8KFoy7oHeNJ1ezk7K8p+mUhGUIVtCxgSlIqFaPXl+kzoc5ZmDskQfL0m6FtBr0TznOkEDMUlmrM3u/e08GTJ2XgzkiN8lB4rpCwsQgIXQxIwvDUD7MXtxJtPhpGif2/4H5R6BDwDLx4uc2CECfCTIpupBzXi355m+tTGnNEnlt459nQmHoTiqhRzw5ftUIyxq9SF/MNDuTpzAupSRxxFf1FbNRuhdnsxW4TK3f1n2L4WMkm8MfPI8gCzyKtr/LKmoe5403k/6aKLm/oeFPYTMboIyg9M0oIkQmG0rq8BTErKuW9JW1N7cZU0WIVhzP1auEtDPpWqvuT+KMu9L/jEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PnvQ9O6zxJEpRDDXt7z/KmWrc2rhm1mf/Ajej4Rc+zc=;
 b=gntur4Yatzg+07C+GC4pSJRyJ6Cvp83ixBHdALhPFQqEIkLVusANQEJLLb6GFAOAxrSq3Wstf5mEfFclJjSTsyJTXk+qhhobCpgavlLfL6VfLjP9n7ZvgK5BIg/I7GVs1Jt0HIOOaZiXNUdhmnbVI7rIRJwC2CRj2Lp5utaHy8c944NcJ8Df9JkPe9WN6pdurIjwFabo4/QuAWRAnpfBj+bfwvkDYcFW+hOYsBA28vm7DENjKveggWnLLhj8aZSdzT5j37kWG0QhnGP/6FekoZ9DxsixQt/PPlg+FS2wEgEqXfTb/nO4YC/BsEzJMAK3BKBemL3gflKUfb9on0+xPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo0.onmicrosoft.com;
 s=selector2-vivo0-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PnvQ9O6zxJEpRDDXt7z/KmWrc2rhm1mf/Ajej4Rc+zc=;
 b=C2YqFqIRxUlUBNH9RuljATnU1ooV7Ozz8G9zuyR1T99f5TxnxuDZiipHd4N1/gvo/1tfjvSJwXVXzB9caC/QhdjkqytzNvy6y2zOTOWXpNJSChON9A2C2ogtreU8v6pt/7kCgbD2AmDT0RM0LS3yuvRW9of6KZ9/c3p4hX13yKA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from HK2PR06MB3492.apcprd06.prod.outlook.com (2603:1096:202:2f::10)
 by TY2PR06MB2895.apcprd06.prod.outlook.com (2603:1096:404:31::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.14; Thu, 10 Mar
 2022 08:48:12 +0000
Received: from HK2PR06MB3492.apcprd06.prod.outlook.com
 ([fe80::d924:a610:681d:6d59]) by HK2PR06MB3492.apcprd06.prod.outlook.com
 ([fe80::d924:a610:681d:6d59%5]) with mapi id 15.20.5061.022; Thu, 10 Mar 2022
 08:48:12 +0000
Message-ID: <e2cf72f1-7fe4-77d7-6700-015fa5214abc@vivo.com>
Date:   Thu, 10 Mar 2022 16:48:07 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH] irqchip/apple-aic: application of sizeof() to a pointer
Content-Language: en-US
To:     Marc Zyngier <maz@kernel.org>
Cc:     Hector Martin <marcan@marcan.st>, Sven Peter <sven@svenpeter.dev>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Thomas Gleixner <tglx@linutronix.de>,
        "moderated list:ARM/APPLE MACHINE SUPPORT" 
        <linux-arm-kernel@lists.infradead.org>,
        "open list:IRQCHIP DRIVERS" <linux-kernel@vger.kernel.org>,
        "zhengkui_guo@outlook.com" <zhengkui_guo@outlook.com>
References: <20220310050238.4478-1-guozhengkui@vivo.com>
 <87sfrqyzyr.wl-maz@kernel.org>
From:   Guo Zhengkui <guozhengkui@vivo.com>
In-Reply-To: <87sfrqyzyr.wl-maz@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: HK2PR03CA0066.apcprd03.prod.outlook.com
 (2603:1096:202:17::36) To HK2PR06MB3492.apcprd06.prod.outlook.com
 (2603:1096:202:2f::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8971e5f7-2f40-4d8e-8434-08da0272b589
X-MS-TrafficTypeDiagnostic: TY2PR06MB2895:EE_
X-Microsoft-Antispam-PRVS: <TY2PR06MB2895251F63F344C3783A0EDDC70B9@TY2PR06MB2895.apcprd06.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: R9joNw27bvmBQkooa0jPMExyAj7exX0+pyahvcvVdNwyyCVV4B8VVy03mZ8fgZhILC7k6VhZ0sZb9huJan1tYcVDU8MW7lP4ZiUAoM55/IlcoMHW2c1lEPpoBRyuPhbwJ6yi7xikvMo5aZRbtHKcX9SX9Gv9+Ru8Doit4Qi5cbgsCd80nUmQva7emmGWIuyM2hlzda5VJ6PV3e2SBuER1zFtsAT375l9T1IzwLBpCSyawZu26reSob8qzZfc3htlRe++sv1fSxsqn0zoTpKAiPOVgzFtRfxkl7SFmQvj5LA8EJeXYrHAiHO5WxL3jdeuaHkpO+il0rZHC5cPvCSdXtPz68kz0O3MRh4C/V81QcMgmC6CaqmsTwHyX0Fa5hZO193bJzSu6pIdEdGtDv8aVsCwMEJAbsBxBdHa/btVcigK8cFySVPu66goIF5IQeYdrrZZGpvh3yJbCFvqh+PAd8wKxg5j00LD4etkka5B+An6/ywPFHs/Qn6qXdvRMtDsn+He/qmVSYUcRM9+LKv+YOpGnWv30QcWEYvtONwXwf8LnBhlutEB4a1N7I2gFS9Xb7XlhgoNYzQDHXSHnSe8TCfGWVOwM0RdbUtISa7UhQev/jw3EqbtzjgY/YWzOvQMP0L/zOmFmbfxuyqFVbuxdy+svhC04HOe1/VeiM0hQPWm7bwXb28+kqLQcYl/jlLjl5mTALETvfHhSiwNIVMa5dVWuML/mleOhRL+Cf2nu/z0sGrai/R4p/SfkdicSCsGFtvgffGF8Ae1CsfqC7XwJzZAMOr2i/ZJVmFnQqBsQPxf3fEUPn7qk06UGQtSRjGjTYhdDKApTUeRQgHE1Pfl7A77HGmLei0git4ojmCWU94/3FZOGehij0aCaGfoGyN5
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HK2PR06MB3492.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(47660400002)(54906003)(86362001)(6916009)(66946007)(31696002)(6506007)(52116002)(316002)(83380400001)(66476007)(38350700002)(38100700002)(66556008)(8676002)(4326008)(53546011)(6512007)(6666004)(2906002)(36756003)(2616005)(26005)(31686004)(186003)(5660300002)(966005)(6486002)(508600001)(8936002)(46800400005)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VEI5L3llcENZaFZha0RldTZVQUhEazJDWTdCdzlBa2lkSUVKb1lPbDV4RDcw?=
 =?utf-8?B?bVJFU2tjdUNhSU5weEg2OVNHSjh2T2hjOGdXa0Q2OWVHVVZFZDhxNVhQNXov?=
 =?utf-8?B?OXRDd3pSd2hCa2U2R1pTSUp3YWUrWldpVmVlckxiVWE3eXA2R21YT3ZmTGp6?=
 =?utf-8?B?blpWbDl2S1JSMGR5YVBZN2lmcFZpbjBsTEFRS0N1d2hqSTI4VU94ZGdCRTVB?=
 =?utf-8?B?QU1SWnlIZkd3OW1uL2NLM2hWRnNjbHprVnBseGNaYkhZbkJ0MFBqRXlkcnBy?=
 =?utf-8?B?aEpDc0I5K2xOWXBNbk9VLzFwNWJDZVFxSGRxQmpxdGM4ZndreURlTXBHOWth?=
 =?utf-8?B?Sk1pZWdaZ0FQbnhtSkJ2bXl5bmp3TzFMWEQvTmw1QmNHR0kvZ0lqVHpZUG1K?=
 =?utf-8?B?c001dFBnUVZrRXRxUHlaM3ErUTJPNnBpei9haTI3MjdBSTc4aldpM2FzbTk5?=
 =?utf-8?B?S2RZaUxaYjQ3YnFVOXpOYWJ4NDhxV2F0R3NtM1pWaHdaek5FcU0zMXduWGoy?=
 =?utf-8?B?L1RFQ2FOMHlBNFFSWjFmV2VrVnlHaERscmRIWmRSZVBxYW9NaVRMZjR4cDJB?=
 =?utf-8?B?aHA1UW0rMTNyeGhEZW9ocVluazBaM1FhR3hCWnBJVE5sYy9HQXZlejRnbWE0?=
 =?utf-8?B?WWs0L0J3eEdCNC80VGpWM1kzMTIwRDNMVm5hWkN2TE5RWnhJeEJ4WG5tdWZo?=
 =?utf-8?B?QmU2c0FMRXdwRHY2RDhlNEFKam9KWE9uVXRlZWNFK0MwaWNpS05ERFRaOHk2?=
 =?utf-8?B?SnJ1a2ozaWhDVHJoeGEyUWZ6ZXptdFd3UU9RQmN5ZFdTaXBYWEEyUW1nb3JY?=
 =?utf-8?B?MjlzY3ByZ1RZd2ZzTUlneWxnenlCdmE0YzdzRDYrSEZPb2ZPNWNWMXZ5aWdD?=
 =?utf-8?B?Z043ajgwSVpGMWU1MFcyLzViaERBT0pQOUtweGxJNjRuQTk1N1hJK0VrODV0?=
 =?utf-8?B?TmREK3RGSzRrWWpUR1NJamRpQWFkMld4a2RBWkR1RmxOK1EwN0ZCMmM4RnMx?=
 =?utf-8?B?L3VaU3JyK1pqQU1vTkd6bDd3a09wVDF6L29VYzlXK0ZMSVd5MkFiQnJKVDBh?=
 =?utf-8?B?Q3AyNFkzUUZQWWhlSGhURjduSTdsakxTdVdrcmJsdk9SazhpOTFjTlhmYlBY?=
 =?utf-8?B?VFNBUVF6RGZrclFFUU1LYWxUdU9lbUtZOVl4Vllnb0dZNDRFMzFBcW5KTVdj?=
 =?utf-8?B?N1o5U3BJelBOZkhsNXdieENNK0VUTDFoaUx5K3FFRXkzdW5MOGlyWE01UUcr?=
 =?utf-8?B?cldYdjBjQ2FrVjZrTWtCeVQ3dUlTdGJNNG1WbW1BNnFSUjlNNnV2YW43Tjk4?=
 =?utf-8?B?ZUM5UDladUZ5VXVoQVFyTjVGeHlmZ0xOS3JNMWdoTXJZUUZJZFpMMU93ZFZW?=
 =?utf-8?B?UC9ycUZKcEJxR3orZXdtSGZycXpQSnVkdGdMc01tWmxHbkNGaDZLQmdqSzF3?=
 =?utf-8?B?UDNiZUdsekxkRkNITXd6eUdoWHg4OUg3UXV0RmlKY3lHZkhYYzNtMXJwRGZY?=
 =?utf-8?B?TWE3b1p3bXpZZnZOa2dna3IrS3Z5N29wWkhQdjJBYW4ybTd2Z1ZkdjdVaERQ?=
 =?utf-8?B?UnIwazRib3BQUy9Ob3VxSk9LeDZCSjNOb1B3c3JBMWR6ZnRpVWwzRWNic2pR?=
 =?utf-8?B?RWxqVVVINERCYXZsbXNhOUx1TnNETXJuL3hYMEEzd1FndE56MUVabGk5Z2Vq?=
 =?utf-8?B?dFQ5c0RqaGZUc1RlYU4wcjIxa0hNbkwxWlU5Q3NqWERCZC9DZFRUQkZkNXVQ?=
 =?utf-8?B?eEtUUGVUMXNPM29pREtKYk45TzhkeEV2dGdPL1pveDBUVld4elA0YTJWN3g2?=
 =?utf-8?B?WS9Ob205Ly9Fa1VMUUxodVo2eHp0MEowb0hmdzYxbW1XZ21NM0lLQkV1UXJo?=
 =?utf-8?B?S1BYclNXVFdxUFd2TVpXNnFXMnF3T3FXYmJaMDBoNlZmWnJlMzQ1cERhRmxO?=
 =?utf-8?B?V1NUSVNaK3lrNHZyUEZSWk9KdE9vZ2ZNV20xWWFpVGVHMDRhNVBYRjMwUVI5?=
 =?utf-8?B?aXNyclNLbU5qYitiSnVteXp2ekVERkdva1ZKSDRhTVZ1Y1NJZ0lBOUJwS1lJ?=
 =?utf-8?B?QUJEU05KQjRkbTY0dXQ3YUtadndpb0VMcVNJd3dFRzVlWFNiOVozRUtQbU5D?=
 =?utf-8?B?clhXam1Eb3NuV0o3OWJVOVZMZUJhajMxRUhFSzM0bE95MmdVVVo1Y3E3VzRv?=
 =?utf-8?Q?RkpAw/qSC4OEtpzcIeu9bvg=3D?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8971e5f7-2f40-4d8e-8434-08da0272b589
X-MS-Exchange-CrossTenant-AuthSource: HK2PR06MB3492.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2022 08:48:12.3437
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2G9gkKX+fjlgAkdwAtUC+aRbpnut/JAcnDAGqIzR9nPuuTpHal5yFtAZUgTZFt9cPqrE/g8mx1YxnIkMgfAq3Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY2PR06MB2895
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/3/10 16:27, Marc Zyngier wrote:
> On Thu, 10 Mar 2022 05:02:38 +0000,
> Guo Zhengkui <guozhengkui@vivo.com> wrote:
>>
>> `ic->fiq_aff[fiq]` is a pointer to the unnamed struct.
>> `sizeof(ic->fiq_aff[fiq])` intends to get the size of this pointer. But
>> readers may get confused. `sizeof(unsigned long)` makes more sense because
>> `unsigned long` has the same size of pointer.
> 
> More sense? It really depends on who reads the code.
> 
>>
>> reference:
>> https://lore.kernel.org/all/Ya%2FeUbdN1+ABFVWf@rowland.harvard.edu/
>> https://lore.kernel.org/all/YbBGGI9wQenI4kP7@kroah.com/
>> https://lore.kernel.org/all/20211209062441.9856-1-guozhengkui@vivo.com/
>>
>> Signed-off-by: Guo Zhengkui <guozhengkui@vivo.com>
>> ---
>>   drivers/irqchip/irq-apple-aic.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/irqchip/irq-apple-aic.c b/drivers/irqchip/irq-apple-aic.c
>> index b40199c6625e..23098b469b1a 100644
>> --- a/drivers/irqchip/irq-apple-aic.c
>> +++ b/drivers/irqchip/irq-apple-aic.c
>> @@ -810,7 +810,7 @@ static void build_fiq_affinity(struct aic_irq_chip *ic, struct device_node *aff)
>>   	if (WARN_ON(n < 0))
>>   		return;
>>   
>> -	ic->fiq_aff[fiq] = kzalloc(sizeof(ic->fiq_aff[fiq]), GFP_KERNEL);
>> +	ic->fiq_aff[fiq] = kzalloc(sizeof(unsigned long), GFP_KERNEL);
> 
> And by doing that, you are making even more difficult to spot the
> glaring bug that is in front of your eyes: we're not trying to
> allocate a pointer, but to allocate the full data structure.
> 

Oh, I surely made a big mistake...

> Nothing went wrong as a 64bit allocation is plenty when you need at
> most 10 bits, but jeez, what a howler. I'm stashing the fixlet below
> on top.
> 

So, will you send this new patch by yourself?

Zhengkui

> Thanks,
> 
> 	M.
> 
> diff --git a/drivers/irqchip/irq-apple-aic.c b/drivers/irqchip/irq-apple-aic.c
> index b40199c6625e..3f1d2f3ccb7f 100644
> --- a/drivers/irqchip/irq-apple-aic.c
> +++ b/drivers/irqchip/irq-apple-aic.c
> @@ -810,7 +810,7 @@ static void build_fiq_affinity(struct aic_irq_chip *ic, struct device_node *aff)
>   	if (WARN_ON(n < 0))
>   		return;
>   
> -	ic->fiq_aff[fiq] = kzalloc(sizeof(ic->fiq_aff[fiq]), GFP_KERNEL);
> +	ic->fiq_aff[fiq] = kzalloc(sizeof(*ic->fiq_aff[fiq]), GFP_KERNEL);
>   	if (!ic->fiq_aff[fiq])
>   		return;
>   
> 
