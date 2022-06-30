Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4E6A561232
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Jun 2022 08:04:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232512AbiF3GEF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Jun 2022 02:04:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230099AbiF3GED (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jun 2022 02:04:03 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2096.outbound.protection.outlook.com [40.107.21.96])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0F5E167D1
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jun 2022 23:04:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aJ1LpCWX9ZXTOyj10zns+IfKZx5v1wGhGliav56ak5tqeOljIJNwC6ehjQlz8OhQR+RZVGRZ0RhPyWl1ukefPR6cLE503mtUKw033NYt5k1p53BspYQspKZqxURkW+h0hiGiD9LnT2CmNSZLI3OmBMQuivKht5V6fx93L+jVw1rNdsQOSF98LjBOxg/r2Q3ww1nb6Bhc/Sws4E5VQXSmhBvjoVtrKL35Zt15l+KajTwXaWB3wd2YrrtgyL4KVqjGDZQ2KjqH+ewyz5ZELiTI3EyZg28fecZUbyLHcyosp5HH/CQM3hqU8wQTgdHC5HHQ4V3kdQNYx+FxuWLhDyJxFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Iqb4xHqjo3gen5g9oF+CWjHjJte9qLIEyLs2ougQWxU=;
 b=PtilW107OiuIh5ICt6GiXpqm56DJN/j2zTiS+9sQQ1pyyV3oDKcdJQJqtt5xSAkyaFP0Hs18gsDV4id6LPoHvOVMewKA25hp0XrvvilHrUJuRpEF7EtQ3l7XaSiDsdZJIK9jmUW0g9z4sqCYoAASXpyqnYOxDVN2gelZjdXPq5wgzs7AxJ3T4DZR5HKi3EpBVqoEdt8JFllR5f/95ei3KytygA2WxV1uOqVceWR8uSFcltRrcD6nbvU6Q2FZcsVbRUCF7mmkrEw7y+sSAIazIjg2mKGe49PkZzZg1ef8dNq9glX2cqR1cC/S3QZWLN8eRm8PTFF7FF7hfnnHeZlB4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=axentia.se; dmarc=pass action=none header.from=axentia.se;
 dkim=pass header.d=axentia.se; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axentia.se;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Iqb4xHqjo3gen5g9oF+CWjHjJte9qLIEyLs2ougQWxU=;
 b=QL4EY7dtuIVEnRwZPnKUFdolAp6lbpp9S2rnVt7sZbIwwFD3zoROnuQd/tjjeRVek3TcvS1v3PNLSOD6wd34lDz0HHfTUlGKws+vsvg4reRTH0aREiWIy6PiXxgCjocFRvIx3ZvmgT1V5DSTReV0mOMKkxXYqcJwOVVIHKrIuag=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=axentia.se;
Received: from AM0PR02MB4436.eurprd02.prod.outlook.com (2603:10a6:208:ed::15)
 by AS8PR02MB6680.eurprd02.prod.outlook.com (2603:10a6:20b:259::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.15; Thu, 30 Jun
 2022 06:03:59 +0000
Received: from AM0PR02MB4436.eurprd02.prod.outlook.com
 ([fe80::11f2:df70:b231:2b45]) by AM0PR02MB4436.eurprd02.prod.outlook.com
 ([fe80::11f2:df70:b231:2b45%4]) with mapi id 15.20.5395.015; Thu, 30 Jun 2022
 06:03:59 +0000
Message-ID: <38ab6884-d0a9-8acd-84cd-dcf6f3f40bc8@axentia.se>
Date:   Thu, 30 Jun 2022 08:03:57 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH] extcon: usbc-tusb320: make sure the state is initialized
 on probe
Content-Language: en-US
To:     Chanwoo Choi <cwchoi00@gmail.com>, linux-kernel@vger.kernel.org
Cc:     MyungJoo Ham <myungjoo.ham@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Michael Auchter <michael.auchter@ni.com>
References: <ab1ad93b-4d39-8863-9704-da779fc4c426@axentia.se>
 <c6d43dab-57bf-7041-9a5a-345fa35ca0c7@gmail.com>
From:   Peter Rosin <peda@axentia.se>
In-Reply-To: <c6d43dab-57bf-7041-9a5a-345fa35ca0c7@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: GV3P280CA0024.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:150:b::30) To AM0PR02MB4436.eurprd02.prod.outlook.com
 (2603:10a6:208:ed::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 94034051-a35f-4b30-65e2-08da5a5e52db
X-MS-TrafficTypeDiagnostic: AS8PR02MB6680:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mSdcdiQg2JRTHrm0Z95R7yXT5YsKzhOdvjfBPJyE7Zo7J2BgI2v270Dx5Lq8JkbJxnsfkTr4/TteiKFpfibahtDuGWBmrKj6PQkHxovJk4duZhU1XlkTrUxbezdpGpbEN4zPGhryBJr+tWPDCY/H2GhCEWP9OAGQbkLvFvbTQ0hHs4FyDCdpGM0ZHSDtoC1J9LzPJ+DdV3MB39NOEDRjp5b9LdMjGM2K+d4Xr9dDltjOsrSG+K2AABSwb6LuaLrpop4ZjnwB6k2jQTxXkBUu1JeDrUS3gilzJdXrNBuLa8HBGHMwrsgHlMi2wuE16QelRxoazSb4ioy0nj+T7fCJefBW2nHXkR9W0WrqC5XMv1AlHAdBbTbvQtXIdvGQkrvWKbhJc6xaKHGuFWcdvEDJtD1d22CXmHNFGXnFihzdfOAAb6yc9tRasrs7PHkvR/IVfQXhAMXQXAf4MSTe8kA5jZCJhD1o61KT+/JTuvLOWAjukgT5VnJFaPhj4Bjra0HA0LeVRflenlj8GesbIoxCpK4YK9AYT3xtEWtTddOT1Tdy33lCsF/ydAXtlhjkTTOlPi+Os5dqKT+hDivx+ZJvxeTz2gpgxL7REqwpilh0hBJ9B4kmuNlA3X4XfEFCELnch6sC1PLi2sgnLQ1A/o0u+FlshRBHTV+Yh+73b5rVXPJBy9jwm1MjUvHvkyM4MskSibJBUF7YIFLnC2L8nVXpH5IeQ3jpFvDhfGOu3gsXSD5YQaFYKmofxU9iJ56d/kyvv5yn0WCjRpJwbPP+yS51yQFeqrLgG7kutZ8slQvIIFDkflDE832BoZSsbpRCK/WHdxzcVzt7Xq3BgSwABjBsCg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR02MB4436.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(136003)(396003)(376002)(366004)(346002)(39840400004)(41300700001)(6486002)(6506007)(8936002)(54906003)(478600001)(2906002)(83380400001)(316002)(2616005)(31696002)(8676002)(4326008)(6512007)(36756003)(66946007)(66476007)(66556008)(38100700002)(31686004)(86362001)(186003)(26005)(5660300002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NkVLK0FheUZ3amwrNWUzdGhzT0NKbU9YWmZDUmQ0eUluVS90aDF3cEZVV3ZE?=
 =?utf-8?B?RXFLQTZHUlljS1N5SGx6QjdxN2E0RGZ6Y2F1NmNkdnc2andKM3d5cnNWcWpO?=
 =?utf-8?B?Vk0ySGM1LzJKQXBXeVVVYVFxTm5XY0F6ZjR3b0VqaEt3VTJIaDRPZU5JYTUr?=
 =?utf-8?B?K1NRZ0dxQU1lZ1dCYW0xOFBxWjdpYmVtQ1NSeTJweEhzdFc2VXRIbjByVVA4?=
 =?utf-8?B?YmhNeVJ4cWRrUnZYUWdRRTdIT2U1TXpwc1B1cThBaEJaNUlMRUdJcXdrZzZR?=
 =?utf-8?B?SVdqNFFOM3ZGRlo1Z0N0Y3ByaXo4LzFpSmc5blFDVlFFVnBiZFBqdjhsdTVt?=
 =?utf-8?B?dzcyUEpYek1taUpsSmhpR3dPU3FmL0JGbURROWFMdnI2QzhTNmkzb21XaDBy?=
 =?utf-8?B?WGZsMWdNNHd4R3hnQzRsejJvQVdTRlBUcVAvMkh1dEFMWk80bmRvQ3pYZmYv?=
 =?utf-8?B?RXhxcDdaUkZUbFNmZnE5N1ZPM3BpQmxtSmI3dkZnVkw0MTU1MURqN0ZlTXRI?=
 =?utf-8?B?QzFheHBnT3JhOFNCNW5yQkJLVUJsQjlmZnBCb2tCNm1JWktUSHRSWmZPRkdZ?=
 =?utf-8?B?bHNwYXNEWHpIbTk3RlZpYS9QV0RVb2Frb1Iwb2cxRE9TMkM1T01pY3ZQVTJZ?=
 =?utf-8?B?TDJWR0w0K1ZqRDUzTHpmajhsOHVnWnRsSFJOdkNlL1VPMkVLb25QcHE2a1Fk?=
 =?utf-8?B?Ti9WZDFwRHViV2d4WkNFWHZXUXlTcXdWTlJTbW92R2IyUzAwVjdaMkhVQ1FZ?=
 =?utf-8?B?WkVWWHBjVE5PQkRvbm9mSEZOSituS1E0VmRlR1hkbWJ4QTFLRzI4S05OMSt4?=
 =?utf-8?B?aVhKdENzZGYrcERFWDBmTnljNDZTM2NnRDYvKzR2MVA0S1hnbmV4MEppVHAv?=
 =?utf-8?B?M1JhdWNPZGZzWGhYMHA5dVJ5aWk3TEM4SzVlUTZObml4bnVWYUtEdG5adHBZ?=
 =?utf-8?B?RSswN29HSjg3QTdXVGV0Y1ZvYjNWU3ZWRmgxOExEVUJFNGpSbjcveHlXODZm?=
 =?utf-8?B?cFpsc3RBSGh0Mzlxa1JMRkhHTU5uR3ZDRW1Td2sxYWJnQzc4Ylo3c2VnRStq?=
 =?utf-8?B?WkVUcC9RUlErMTlaOFRYNHUrbjhGY0Q2cUFqZjZueDhHR0IreFc3T2VJdFBj?=
 =?utf-8?B?Uk5mOVBFOGdxTlFPQjRVcWFQZ2VVMGdOSnRlU05FMm1iWi9yNDhHbWZRWVd3?=
 =?utf-8?B?T0MwTG5sRkswd0N6d0RtZjRIRU9LOWNTS2d6dUVXemVwWjZRMFhzUitHQ0JR?=
 =?utf-8?B?Mzk5RlRzRDF1TlBKVzhubEJueEZoc2lUT0xwRG5PSytXZnNzdXVOMUxXcWRU?=
 =?utf-8?B?M0Y3dmVWaDBVUnNRSkJyMS8yOUJaR3lqRkZPSWpnMjZFWWV0aHhpSHdmS0cv?=
 =?utf-8?B?emk3V2VKb2NPSHpOczNiZ0ZtRnVFTXNEc0NWQXhYeUdDN2NjRW0wUHIxMW1j?=
 =?utf-8?B?T0wxWUdtaWpKVlM0Q1VaeVkyMHFYaWd2TERNakZjWmw2cEpqY3pRdzZEZ240?=
 =?utf-8?B?TG01SEtWbjJiTjJNaG00aWlGb1hXVS85eDdNOThQWmthWk93aEVpMGowNFlu?=
 =?utf-8?B?dDI5aTlIZWlINWRiQTBGQmRMNndVM1E0eWEwVkN3WDNaQUgvTlNCR3MxcHph?=
 =?utf-8?B?aXN5Q29MYU12OTNMRXdXUHg5RjBSVTZtZlBydjhVTEdROEJxZnkxa25xblFT?=
 =?utf-8?B?NnVxYkh6QU1YOHR1U2IvTEpDbGNKSWNiN1pRdENzT2NLdUtkZU1OVTJXb0Q1?=
 =?utf-8?B?TkZJdXFNYTMwOTBleHBKRC9TV0NXdGJDdlZ4NldnM3dHQ2VJRWhPWVBwN3J5?=
 =?utf-8?B?SFFOWjhKNzJOZXM0T2NCR0ZqNGlONnkzWVBDcWdtRFExaXFYbHczMmYxSnY0?=
 =?utf-8?B?QWhqTytPZlJwajc0bWhwQ3Zlc0p3Mkx6Vm8xNGlWdmlnb01kYU0rR0g5a1Uy?=
 =?utf-8?B?WTk5Z2tpYkIxSW9UdTJ2VmdtNWZ2MUJUQWI0b3NmUmkrazNjdGdpMVlPNmk1?=
 =?utf-8?B?T1ErU2ZHVXhOdk1MbnFneHA2OXdUUVVYWjBZNHNJU1phOXVyS2d1MXNRV2NP?=
 =?utf-8?B?Sk5ZdzVteTVKVmpXMnJxOCtGcFpoTldwRGw1UFdiNkNWaGhsdEowL1BUc2RS?=
 =?utf-8?Q?qd9qgz5zTN9TNU4FfK5UbL75K?=
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-Network-Message-Id: 94034051-a35f-4b30-65e2-08da5a5e52db
X-MS-Exchange-CrossTenant-AuthSource: AM0PR02MB4436.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2022 06:03:59.1757
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CLLSF9MTovIc0Wv0Uj48hGOCPRKKSFHyY4IYAaHf8Y6DO6hPzmr9fU1INTgTIZZy
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR02MB6680
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

2022-06-29 at 21:54, Chanwoo Choi wrote:
> On 22. 6. 23. 20:21, Peter Rosin wrote:
>> When the port is connected at boot, there is not necessarily
>> an interrupt flagged in the interrupt status register, causing
>> the IRQ handler to bail out early without reading the state when
>> it is invoked directly from probe.
>>
>> Add a flag that overrides the interrupt status register and reads
>> the state regardless during probe.
>>
>> Fixes: 06bc4ca115cd ("extcon: Add driver for TI TUSB320")
>> Signed-off-by: Peter Rosin <peda@axentia.se>
>> ---
>>  drivers/extcon/extcon-usbc-tusb320.c | 5 ++++-
>>  1 file changed, 4 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/extcon/extcon-usbc-tusb320.c b/drivers/extcon/extcon-usbc-tusb320.c
>> index 6ba3d89b106d..bd3645ae0d52 100644
>> --- a/drivers/extcon/extcon-usbc-tusb320.c
>> +++ b/drivers/extcon/extcon-usbc-tusb320.c
>> @@ -55,6 +55,7 @@ struct tusb320_priv {
>>  	struct extcon_dev *edev;
>>  	struct tusb320_ops *ops;
>>  	enum tusb320_attached_state state;
>> +	bool initialized;
>>  };
>>  
>>  static const char * const tusb_attached_states[] = {
>> @@ -195,7 +196,7 @@ static irqreturn_t tusb320_irq_handler(int irq, void *dev_id)
>>  		return IRQ_NONE;
>>  	}
>>  
>> -	if (!(reg & TUSB320_REG9_INTERRUPT_STATUS))
>> +	if (priv->initialized && !(reg & TUSB320_REG9_INTERRUPT_STATUS))
>>  		return IRQ_NONE;

Do not return early if priv->initialized is false. Behave as before if
priv->initialized is true.

>>  
>>  	state = (reg >> TUSB320_REG9_ATTACHED_STATE_SHIFT) &
>> @@ -297,6 +298,8 @@ static int tusb320_extcon_probe(struct i2c_client *client,
>>  		 */
>>  		tusb320_irq_handler(client->irq, priv);
>>  
>> +	priv->initialized = true;
>> +
> 
> After initializing as 'priv->initialized = true', 
> tusb320_irq_handler() is not anymore detecting the external connector changes.

Have you tested the patch and observed the trouble you are reporting, or
have you simply misread the patch?

> 
> If external connector is detached after finished kernel boot,
> how to change the state of external connector by using extcon_set_state()?
> 

If you did test this and there actually is a problem, maybe there should be
READ_ONCE in the irq handler when checking and WRITE_ONCE when assigning
priv->initialized. But if that's really what's going on I'd be surprised
when it's a variable that changes *once* before the interrupt has even
been requested.

Cheers,
Peter
