Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F8CA573872
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 16:10:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236366AbiGMOKQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 10:10:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236277AbiGMOKM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 10:10:12 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2080.outbound.protection.outlook.com [40.107.92.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F03B238A;
        Wed, 13 Jul 2022 07:10:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KkXJ3lNo1XK0b7X1eJJ+0/kCNju5hxpguyTwv9EraA948/SUt4Fnz4O8dCodJaUqxRiT6GxBIObOxU+0E0hhTIkGm2iTAoQPUbawcdxR/lrIVQZyw26eVTOItM0Zz0eQNJL8FZngsyuOkAoF2XhR6C/BEFWoA5qjxLN+Gvpp3GPP0cm6lZnhCrbP8gCrhVMT1VxAhc5XqTFByaZ6tSnWM12hktCoZJ8Fikrk4eUxoaRqUVrJOqDbdE0AUJaeq82/rE3gz3B15mgKgV/t5oF9stxxVWkERh2+d3V5J0VYvCRr60f+n6s3SGg7aqDZe+j7wQEm79tgMv3BuIZPKTAvjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RBzVmXC/HE4vSPWSDhCPegBWNN1x5rhrS8A7TYMnLXI=;
 b=nfXivNMUZQmZxwRxuZ3NMCvVqPIvk2yjm6GiQw9F0BzMbjNxwiDZO4CQq1YWXcf/ZdbdsGiiZTnuHa5whd7DX7qRPKwCEqITyV/APGDwgGEyHXSdmvjH1hbfz2gRPzlyKelSKgDh1LZtGMQHk+4RCmlfBXxZ7awmJVTXLptvy7uHVAyzrkyWfR2BG3pLxXWo36d0ZHaSZSmXG+sueJSfIEZ7mC1bFnUAzmLh8fpa8W0PKETcFRODv2GwLQDSjg5GmUQhqTDlSz6U2qT0Pgf4MWWXmk+pVR/mpqUWkJcsgHrvjqe5QuPrPfWggA0RwjzWVUmey8mJP5ZNmFwwr1X3+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RBzVmXC/HE4vSPWSDhCPegBWNN1x5rhrS8A7TYMnLXI=;
 b=ZIy3w31Cb6TkGinMZnh3+n180b5GQtPBT82dTxg+i13OgdzzU1ZwdFgRaym5sZQ+CX8tZEAXdUN9nfpOrpCEKdnwTEE3SN/ab7H7/gAaXL7aioe1a1Wfi+dA+ooXedwyjJL7/TukkGPC2Pf1ttF11aFd9HMJb4o4LgWhuJdMUFQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5874.namprd12.prod.outlook.com (2603:10b6:208:396::17)
 by BL0PR12MB2417.namprd12.prod.outlook.com (2603:10b6:207:45::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.20; Wed, 13 Jul
 2022 14:10:08 +0000
Received: from BL1PR12MB5874.namprd12.prod.outlook.com
 ([fe80::c96b:6385:264b:b92d]) by BL1PR12MB5874.namprd12.prod.outlook.com
 ([fe80::c96b:6385:264b:b92d%4]) with mapi id 15.20.5438.012; Wed, 13 Jul 2022
 14:10:08 +0000
Message-ID: <e871f27d-2bfe-62e3-a5fa-8e1fe52e856a@amd.com>
Date:   Wed, 13 Jul 2022 09:10:05 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH] thermal/drivers/qcom: Code refactoring
Content-Language: en-US
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     amitk@kernel.org, thara.gopinath@gmail.com, agross@kernel.org,
        david.brown@linaro.org, linux-pm@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        bilbao@vt.edu, konrad.dybcio@somainline.org
References: <20220712173127.3677491-1-carlos.bilbao@amd.com>
 <Ys5KdVQmA9YTmfCT@builder.lan>
From:   Carlos Bilbao <carlos.bilbao@amd.com>
In-Reply-To: <Ys5KdVQmA9YTmfCT@builder.lan>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR03CA0241.namprd03.prod.outlook.com
 (2603:10b6:610:e5::6) To BL1PR12MB5874.namprd12.prod.outlook.com
 (2603:10b6:208:396::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e8da781c-c4cd-468a-3d6a-08da64d96467
X-MS-TrafficTypeDiagnostic: BL0PR12MB2417:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: aJvfHngJGTD5Vrggr6/v15/okODmm11WmilJxw/SU1ZypP+koiEg6VQ+QvBIZIUemUHTQmDCJ1YIEKsmbCgMc3kverjFPsjH/uiPJx1jFnhP+D/2nOAi/j27XVUOImmh1UtbzQAwy0+Bi6/4LilN2IGzGIX7tbee+UGhNtB7wB33BJFDVKuv8KNS2yb6z0NlAGIMJHx78Y9i1jKeYjCffkjuZASHYQMh+eRaMKZdxIEwjb2FncGsNrspFDxK9yRar63XolTIrwmbysVHbog9cO7aDgMR2e7uc1NkvrEecjNxdVVB2IliUWdVLPX2Orb93759shJ+pF8PuWPo72ua5svSMl06YlSNEXEYqg8ShgwG5YaQ7CJuXX/s8bw4JYPUXU+5cfhyTxi0OzdtAGsinxcmLy1b9TIpRE/KyvdUOlX6xgoOxlWLG8wSORJQQy4PG2265cv/VPHGtBtigApaekQOHKYxZor4ynPkem2K5BhjGLHE4f8LyMDaebX6u9y2NffWZSBKHOKtpsdl26oXMCFVTZV0Ui/UX6WVtqtsiPYXTgxLA2HUjKZjK402ZjdZhGtHe7GkwgyZSR/s5OnJntFYpWzH6JgEM1q+gd4Dd8LKOfYrPNlvVT24zrFVNBblewexDZrNCvkGTKpWFwIM6OEszYK1zwTB2FCxwDw/rDMIymPoZaZW7k07ytFNKSnBDSxD8t/VgEr1Dr12PTPbQ0y0xrccJL60DqdTdkTt2HIwlzaFuv3bFfKtPnDeHfkKs/gXWdXhA+NPlukQsP634oPxe4odsC0iZvtyhQZQAhwgMczFHeZuetXqIqafIFEntI+MmZGbac5P1t/EPk4VvRYr1tJL5lPUxCl0+YCWQeE=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5874.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(376002)(39860400002)(396003)(136003)(346002)(366004)(6512007)(41300700001)(53546011)(6666004)(2906002)(26005)(86362001)(6486002)(478600001)(8936002)(6506007)(44832011)(38100700002)(5660300002)(2616005)(7416002)(36756003)(31696002)(83380400001)(316002)(6916009)(4326008)(66946007)(31686004)(66556008)(8676002)(186003)(66476007)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bWdjaE1UMmpRYXhqaTVTWC9BckJzMVBzV28zUHZzdGhDaU5IemlXSW92dHhv?=
 =?utf-8?B?bFJmN01yRXVER3YwWU8zSlo1NzhGOXJBZXBHY3dleVBYQVRuZFhRV3lMS0xq?=
 =?utf-8?B?QlRWc3RSblpLUHhLK0tna2V3Z1JCUHFGb0laTlQ0b1MrMklIeGpsWm1aZVZN?=
 =?utf-8?B?cWxtSFd1M1FwRFlpYldxQ0k3Um5ZMm5LK0VkSU1VWHFEc0ZQUURORjB4bkVO?=
 =?utf-8?B?SWErQWtGMDRzZDhCOWJPbTFtYVV3aG54YmxDOVVpQlkwZkxhd1ZxUTA0VHR4?=
 =?utf-8?B?eEE0NzJITmMwcTFmTEhPYXFiZEtDbFh0YldoTHArTnV5TVp2em9aSHdMYktC?=
 =?utf-8?B?ZmxFM2tkalc0L3J2M2FMNlFma0FpbFI5enZHNjA2b1dHKzU3SmFWdS9vem9j?=
 =?utf-8?B?dVVoZGhwODJvYlNRR25VNjlhY2JQNHVYdUNjQUlNLzQweGlyMmtEWUNZYkJB?=
 =?utf-8?B?S3ptVXlRYUkxVkFKT0tTVWg0WnJjUFFrNEZEL09lc3RyMTVBaFRuWFk5V1J3?=
 =?utf-8?B?dXBqd0dNYVZjVjRkOXgrQnNUVG5jZTk0aVdqK3VhbGJMcnBvVndwR0h3VGRv?=
 =?utf-8?B?dWJaSkxobGZ0NDhuY01nY2VYK1BhaEV3QmxnRGp2ZUlyMHFwWmlUQjhRUG95?=
 =?utf-8?B?MGJHQ2MxWjlJVzh4M29GZFYrelZhZ3IybitxWERSRlg4TnNBU2R5bENWR1JV?=
 =?utf-8?B?MElwdWc2SzdiUkFYTHYrTU44a2QvTmpWWHdldHViY1VQeHNXSWNndkYwbXE4?=
 =?utf-8?B?SkRuak4zaTlPRGZ5bmRnbXVGTGFyRTVsV0tpT3NvNkJrWmlrTUVIcnFKWkNh?=
 =?utf-8?B?RHYvdWUvV1ppRmRPYndVN3VPbWpyN2NGYW9oUiswVE1nUy9WcUgyTFdxdDVF?=
 =?utf-8?B?NFdza0FkVmJJa01MTjROVjhHRjZRVUI5eitWSGVxNGVDRjVUMTVETEJyZzQz?=
 =?utf-8?B?dWxvT2tJY0FLM1JpMkIzMkp5REdBaTh6Z3Njd2I0b0REcFF3amgrL2k3eFpo?=
 =?utf-8?B?aTdFZ0JOMnBuMUlaWkgyb1VIWnZpWUxZRWZWRUxWM0lTVEd3VWJtRFZ5L0tj?=
 =?utf-8?B?SE1yT2pEeGpZNW13VGRySW9nNGEwWEtYUjB2eW5hRXNIKzB6YTFVcDROaUJI?=
 =?utf-8?B?ZWZsWUlLWnRxSi9Lc29hM3BoMFFISSs1TG1ETUVhakFIajNyRUdFOUU3K2Q2?=
 =?utf-8?B?YmhDNFYrcnNRcldVMkxPZUtJN3QwU0lOaUN0T0JJSWtQNmRNdW9lVmh3ZFV4?=
 =?utf-8?B?a2RJMXd4bEFnWFFpN25BendCWmtjOEFrVktycmdBaEROUDJCZW1RSERJSnV2?=
 =?utf-8?B?eSt1NjBIVGFJanduMHlSVHdhK3NGdk4weW5wa3pubkFKSm9OUkFhWVd1c2Ur?=
 =?utf-8?B?SktVWDFTRngzTFZVdDRqeXdiazRJUTFXWXhMdVo2cjNkN2hESXFNS0hja0dJ?=
 =?utf-8?B?VlhnKzFkMUR6WWhhSG1TbTZqbG9BUlp1SHE4b29nYW9KcExLUjNpTHBGaTJ6?=
 =?utf-8?B?MXlvZ3V2MmZtNTE5M3VQdUQ5aGxyTTRIdCtJQ1YyakdiRURUOFVUNXNVNkdi?=
 =?utf-8?B?MVNuSHRqdEVFTkJRK2kxek9qM1pZSE5LU1FEc0xEaHQ1Tnl5M2ZZWGYzMWM2?=
 =?utf-8?B?TXBqVjRXV2pzbU9ZK3d2blJ1Zkt4bGVrdEllTGhNL0lTUjhuSEpMV0dvVWgv?=
 =?utf-8?B?aW1HYUhGL2Z5dG4vMGI4ZlJYOVBOZlFrV3NlV2kzUEx2SUNHWGFRbXNYMUMx?=
 =?utf-8?B?cUROMGVhd1ZhN2pRTVBSR0ZaMnN5czlNaHNyZFNCdXRuMFFPUXljc0d5TDNv?=
 =?utf-8?B?VGpVY3dWU2tiQ2VuODNFM3k0RHdHWkhpRzVKcEhkSHg0ZGRaUDIvbmtEYUti?=
 =?utf-8?B?UWJPVEROWXYzeWRNZ2xSTDVLejVMMi81TWs4dGZ0MjEwU1M5N3gxTC9QUTda?=
 =?utf-8?B?QmhudncwU0tTNW9CSFpPM2E3Nnpua1pKV1JhaytWR003SHd0cHFQdVM5Z0g3?=
 =?utf-8?B?cjFGR0dCMFBjcit0ZnRxTG50VVdkMWo5VWhtUUVBRzZSTHRoVlhUVkY4c1VV?=
 =?utf-8?B?Sm84N2dkSnhLUG9tUy9RTFkvQmJNaFYrWFlUelc5NFVqQm53Vm5mUlg2T2o0?=
 =?utf-8?Q?AvEUjXPzoobOzIqOKm+Ky+vV7?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e8da781c-c4cd-468a-3d6a-08da64d96467
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5874.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2022 14:10:08.3233
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cSn2PLNnxZq8J6yEsLtNVmJZa4/0omj9QBYdKrK5qJwo5Z3hBQ2etpSXX8eNima1YuHBl2Negx9UNtBDumOXBA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB2417
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/12/22 23:30, Bjorn Andersson wrote:

> On Tue 12 Jul 12:31 CDT 2022, Carlos Bilbao wrote:
>
>> Some functions in tsens-8960.c can directly return ret instead of doing an
>> extra check. In function calibrate_8960(), a second check for IS_ERR(data)
>> can also be avoided in some cases. A constant could be used to represent
>> the maximum number of sensors (11). Finally, function code_to_degc() can be
>> simplified, avoiding using an extra variable.
>>
> Thanks for the patch Carlos. These are rather small fixes, but it would
> still be nice to keep them separate, so that in the even of there being
> some unforseen regression it would be easy to track down and fix the
> relevant patch.
Thanks for your comments Bjorn and Konrad. From what you say, I believe it
would be good to have this as a small refactoring patchset that includes:

1/4 Simplify return values.
2/4 Simplify function code_to_degc().
3/4 Simplify function calibrate_8960().
4/4 Create array MAX_NUM_SENSORS[] for maximum number of sensors per
version (v0.1, v1, v2), that can be further populated when future versions
appear.
>> Include these small refactoring changes.
>>
>> Signed-off-by: Carlos Bilbao <carlos.bilbao@amd.com>
>> ---
>>   drivers/thermal/qcom/tsens-8960.c   | 25 +++++++++----------------
>>   drivers/thermal/qcom/tsens-common.c | 18 ++++++++----------
>>   drivers/thermal/qcom/tsens-v0_1.c   |  6 +++---
>>   drivers/thermal/qcom/tsens-v1.c     |  2 +-
>>   drivers/thermal/qcom/tsens.h        |  1 +
>>   5 files changed, 22 insertions(+), 30 deletions(-)
>>
>> diff --git a/drivers/thermal/qcom/tsens-8960.c b/drivers/thermal/qcom/tsens-8960.c
>> index 8d9b721dadb6..576bca871655 100644
>> --- a/drivers/thermal/qcom/tsens-8960.c
>> +++ b/drivers/thermal/qcom/tsens-8960.c
>> @@ -76,10 +76,8 @@ static int suspend_8960(struct tsens_priv *priv)
>>   		mask = SLP_CLK_ENA_8660 | EN;
>>   
>>   	ret = regmap_update_bits(map, CNTL_ADDR, mask, 0);
> Why not just do:
>
> 	return regmap_writen(...);

Yep, should be part of patch 1/4.

>> -	if (ret)
>> -		return ret;
>>   
>> -	return 0;
>> +	return ret;
>>   }
>>   
>>   static int resume_8960(struct tsens_priv *priv)
>> @@ -106,10 +104,8 @@ static int resume_8960(struct tsens_priv *priv)
>>   		return ret;
>>   
>>   	ret = regmap_write(map, CNTL_ADDR, priv->ctx.control);
>> -	if (ret)
>> -		return ret;
>>   
>> -	return 0;
>> +	return ret;
>>   }
>>   
>>   static int enable_8960(struct tsens_priv *priv, int id)
>> @@ -132,10 +128,8 @@ static int enable_8960(struct tsens_priv *priv, int id)
>>   		reg |= mask | SLP_CLK_ENA_8660 | EN;
>>   
>>   	ret = regmap_write(priv->tm_map, CNTL_ADDR, reg);
>> -	if (ret)
>> -		return ret;
>>   
>> -	return 0;
>> +	return ret;
>>   }
>>   
>>   static void disable_8960(struct tsens_priv *priv)
>> @@ -206,10 +200,8 @@ static int init_8960(struct tsens_priv *priv)
>>   
>>   	reg_cntl |= EN;
>>   	ret = regmap_write(priv->tm_map, CNTL_ADDR, reg_cntl);
>> -	if (ret)
>> -		return ret;
>>   
>> -	return 0;
>> +	return ret;
>>   }
>>   
>>   static int calibrate_8960(struct tsens_priv *priv)
>> @@ -221,10 +213,11 @@ static int calibrate_8960(struct tsens_priv *priv)
>>   	struct tsens_sensor *s = priv->sensor;
>>   
>>   	data = qfprom_read(priv->dev, "calib");
>> -	if (IS_ERR(data))
>> +	if (IS_ERR(data)) {
>>   		data = qfprom_read(priv->dev, "calib_backup");
>> -	if (IS_ERR(data))
>> -		return PTR_ERR(data);
>> +		if (IS_ERR(data))
>> +			return PTR_ERR(data);
>> +	}
>>   
>>   	for (i = 0; i < num_read; i++, s++)
>>   		s->offset = data[i];
>> @@ -278,6 +271,6 @@ static const struct tsens_ops ops_8960 = {
>>   };
>>   
>>   const struct tsens_plat_data data_8960 = {
>> -	.num_sensors	= 11,
>> +	.num_sensors	= MAX_NUM_SENSORS,
>>   	.ops		= &ops_8960,
>>   };
>> diff --git a/drivers/thermal/qcom/tsens-common.c b/drivers/thermal/qcom/tsens-common.c
>> index 528df8801254..fe5f4459e1cc 100644
>> --- a/drivers/thermal/qcom/tsens-common.c
>> +++ b/drivers/thermal/qcom/tsens-common.c
>> @@ -66,19 +66,17 @@ void compute_intercept_slope(struct tsens_priv *priv, u32 *p1,
>>   
>>   static inline int code_to_degc(u32 adc_code, const struct tsens_sensor *s)
>>   {
>> -	int degc, num, den;
>> +	int degc, den;
>>   
>> -	num = (adc_code * SLOPE_FACTOR) - s->offset;
>> +	degc = (adc_code * SLOPE_FACTOR) - s->offset;
> At this point the variable name is misleading, it's not until you have
> reassigned degc below that it's value represent the temperature.
>
Sure, will rename.
>>   	den = s->slope;
>>   
>> -	if (num > 0)
>> -		degc = num + (den / 2);
>> -	else if (num < 0)
>> -		degc = num - (den / 2);
>> -	else
>> -		degc = num;
> So the main part of this change is to rework the else case, how about
> just starting with:
>
> 	if (!num)
> 		return 0;
Makes sense.
>
>> -
>> -	degc /= den;
>> +	if (degc != 0) {
>> +		if (degc > 0)
>> +			degc = (degc + (den / 2)) / den;
>> +		else
>> +			degc = (degc - (den / 2)) / den;
>> +	}
>>   
>>   	return degc;
>>   }
>> diff --git a/drivers/thermal/qcom/tsens-v0_1.c b/drivers/thermal/qcom/tsens-v0_1.c
>> index 6f26fadf4c27..42e897526345 100644
>> --- a/drivers/thermal/qcom/tsens-v0_1.c
>> +++ b/drivers/thermal/qcom/tsens-v0_1.c
>> @@ -188,7 +188,7 @@ static int calibrate_8916(struct tsens_priv *priv)
>>   static int calibrate_8974(struct tsens_priv *priv)
>>   {
>>   	int base1 = 0, base2 = 0, i;
>> -	u32 p1[11], p2[11];
>> +	u32 p1[MAX_NUM_SENSORS], p2[MAX_NUM_SENSORS];
>>   	int mode = 0;
>>   	u32 *calib, *bkp;
>>   	u32 calib_redun_sel;
>> @@ -324,7 +324,7 @@ static const struct tsens_features tsens_v0_1_feat = {
>>   	.crit_int	= 0,
>>   	.adc		= 1,
>>   	.srot_split	= 1,
>> -	.max_sensors	= 11,
>> +	.max_sensors	= MAX_NUM_SENSORS,
>>   };
>>   
>>   static const struct reg_field tsens_v0_1_regfields[MAX_REGFIELDS] = {
>> @@ -374,7 +374,7 @@ static const struct tsens_ops ops_8974 = {
>>   };
>>   
>>   const struct tsens_plat_data data_8974 = {
>> -	.num_sensors	= 11,
>> +	.num_sensors	= MAX_NUM_SENSORS,
>>   	.ops		= &ops_8974,
>>   	.feat		= &tsens_v0_1_feat,
>>   	.fields	= tsens_v0_1_regfields,
>> diff --git a/drivers/thermal/qcom/tsens-v1.c b/drivers/thermal/qcom/tsens-v1.c
>> index 10b595d4f619..98acc9b64555 100644
>> --- a/drivers/thermal/qcom/tsens-v1.c
>> +++ b/drivers/thermal/qcom/tsens-v1.c
>> @@ -149,7 +149,7 @@ static const struct tsens_features tsens_v1_feat = {
>>   	.crit_int	= 0,
>>   	.adc		= 1,
>>   	.srot_split	= 1,
>> -	.max_sensors	= 11,
>> +	.max_sensors	= MAX_NUM_SENSORS,
>>   };
>>   
>>   static const struct reg_field tsens_v1_regfields[MAX_REGFIELDS] = {
>> diff --git a/drivers/thermal/qcom/tsens.h b/drivers/thermal/qcom/tsens.h
>> index 2fd94997245b..d2d78c7e20c8 100644
>> --- a/drivers/thermal/qcom/tsens.h
>> +++ b/drivers/thermal/qcom/tsens.h
>> @@ -6,6 +6,7 @@
>>   #ifndef __QCOM_TSENS_H__
>>   #define __QCOM_TSENS_H__
>>   
>> +#define MAX_NUM_SENSORS		11
> This only seems to apply for the three cases you have listed here, e.g.
> tsens-v2 (which also includes tsens.h) has max_sensors = 16.

This should be an array with an enum for the versions.

> Regards,
> Bjorn
>
>>   #define ONE_PT_CALIB		0x1
>>   #define ONE_PT_CALIB2		0x2
>>   #define TWO_PT_CALIB		0x3
>> -- 
>> 2.31.1
>>

Thanks,

Carlos.

