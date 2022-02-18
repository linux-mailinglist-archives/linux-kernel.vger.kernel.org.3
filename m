Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0E824BB5F3
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Feb 2022 10:50:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233809AbiBRJvG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Feb 2022 04:51:06 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:50486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233429AbiBRJvE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Feb 2022 04:51:04 -0500
Received: from EUR01-VE1-obe.outbound.protection.outlook.com (mail-eopbgr140130.outbound.protection.outlook.com [40.107.14.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF9F4269ABF;
        Fri, 18 Feb 2022 01:50:47 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e6UIyP94rbq4c3nZRUlNWJIQP6+tY8a0j30n9xYU5mCIGVtfv1WzxQTnavJJws8irHvieik3+jOLKQqOEHgoB7tOPYdjjtWXw32s6CB4yINhpsS4fzFBW0//l8EA/SyvLXB+ryrT4jTeybZhD0UevZ46OUjV+abJv2nOPthg13OUU0nDVEpR69sL5MhgKMlvJrEWmijLTaYW45/yk9ECNq3It+tEUYpJahIOvdCPHk7gHA2NSh+s1gFneMhMWUjbeot+AAGbYK7b4EsGL1huvw7L/iaqXaM6sw0wzDVP4vDUo+tKSq0IhD5ToRC0imT5+b/Op5gt4OynMPisnEDCzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7o8mLb3UDVaR5BmFEz3LPuK2Mxac9KLVZX1QwE+i/ps=;
 b=E9OXa7hfMpXYbnuc/F0cHC+il8CwwAU3eOgEZcONdSl/JjDG98dwGyqKP4LfJJ2s80YBbji0lHFn2sbUUjXvkUPhdHTYmRvw4tb8GznfJJpalHd/Em6OlxnWJZY4oml42ntM7yakcSWl2dRcqIYego4qSf/zY7lke/FQffmivfvzNRIg/kAGusoyh8PI9cKnufQTJYcy3H41zQ6Qt7ugYwgps7Rt7UFiVCVOADyTAwvRHI6sz6UtYSayVdwaD338CCFyDJvvxoUbx8v3MAaiVXKs33z8FGnBQWhEBpVY99bdMKU8QLC229aLiyfZXr/amW1U+vYWwpOgiAdNM2o6/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nokia.com; dmarc=pass action=none header.from=nokia.com;
 dkim=pass header.d=nokia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia.onmicrosoft.com;
 s=selector1-nokia-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7o8mLb3UDVaR5BmFEz3LPuK2Mxac9KLVZX1QwE+i/ps=;
 b=r6Vm0RonM1QyCstzGt6YLlbQlrGLOki5OVV04B38doZ+eYuQNlnCoq3y86OshBS1dL87r6mEd089TNXtpvmK+a7QFaZKAGnVarAr7bgXrtu/VXKThPl7cseWpUXwE2WFb1CQAqxbWE11A8yIOQs9W/lDSybfSIKIi0pzIXIBbfA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nokia.com;
Received: from AM7PR07MB6916.eurprd07.prod.outlook.com (2603:10a6:20b:1b4::19)
 by VI1PR0701MB7054.eurprd07.prod.outlook.com (2603:10a6:800:195::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.7; Fri, 18 Feb
 2022 09:50:45 +0000
Received: from AM7PR07MB6916.eurprd07.prod.outlook.com
 ([fe80::594:fa1f:92c5:e546]) by AM7PR07MB6916.eurprd07.prod.outlook.com
 ([fe80::594:fa1f:92c5:e546%5]) with mapi id 15.20.5017.012; Fri, 18 Feb 2022
 09:50:45 +0000
Message-ID: <bb9d1f78-7f4d-a865-922e-ebf7362f6b64@nokia.com>
Date:   Fri, 18 Feb 2022 10:50:43 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.0
Subject: Re: [PATCH v4 2/2] hwmon: Add driver for Texas Instruments TMP464 and
 TMP468
Content-Language: fr
To:     Guenter Roeck <linux@roeck-us.net>, linux-hwmon@vger.kernel.org
Cc:     Jean Delvare <jdelvare@suse.com>, Rob Herring <robh+dt@kernel.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Krzysztof Adamski <krzysztof.adamski@nokia.com>
References: <20220218065856.1899086-1-linux@roeck-us.net>
 <20220218065856.1899086-2-linux@roeck-us.net>
From:   Agathe Porte <agathe.porte@nokia.com>
In-Reply-To: <20220218065856.1899086-2-linux@roeck-us.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PR1P264CA0016.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:19e::21) To AM7PR07MB6916.eurprd07.prod.outlook.com
 (2603:10a6:20b:1b4::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 435598b3-e794-461a-75d6-08d9f2c42217
X-MS-TrafficTypeDiagnostic: VI1PR0701MB7054:EE_
X-Microsoft-Antispam-PRVS: <VI1PR0701MB705411BB20472B55768764139B379@VI1PR0701MB7054.eurprd07.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4714;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zdwbbBVO3XI651uBz3Gjq185hFG5Q3LmDy3O5Nkq4wYpQ1ujdN8FN+UDBERydRgj3xHK8TJKm+g+sZDPT5CxYKcCd6jufnPNvrmRXrmaqNEPORS0LMPAoeDX1k8gczTQWctD9TD841I+CA1jC11we5Rem834YY0Za03O7HDp8E7DezF/SAadBD4opQMbko12M4k/HVYpGata9DjumkubwIVub4sTK8teLmcoRaUM8YGkmXPuZFgeSUxq4AyPHYg13+ykQAWKOYiqJX4FCt0Sp4G4mpkQDiIGo9VSCWm22PUqCavpmZ4JUA372H5U8m0Bb14SY/13TD6gLDOOU28a9DsaQXJkWNkl/yzjEj+YzNRsIbJJaHqkBz8jAO3qlVrfzrgzwjRB/ssBSnmyR/YmM3KeN//JbvNhJCpbelpiYqQ0g+uJT+/0UqR2uVzlkzwly+hQMjn2p3kQIEuyyWiiX5+eF+YV8TuPcvoAGaydyCg7dUcziTe+ZKRJLi5tU2xeAHkCqDTVovaI3faf2H5QcLBdgvckg5MW7jSqrqiPj5ttCmMgFjm5xgB5PAU1ownsQJRsa+IuisHZA+E9bNg0ADKKHGuP/DKnsWgtKb8WOFq7/XwGka8F9nE4FWpUkBMvGHg+UxHo5fM06HJk5JCf8BEFfYH8LuTLbGLyNG2upMliq+ZFirfchXdRv02CdxH70At+E6qxWa8DrtlZdVIp2vUzBIsXig7kbr+kuaCYFXtEHkCyeI02TNQ9dBoPdtmj
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM7PR07MB6916.eurprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(38100700002)(107886003)(4000180100002)(82960400001)(36756003)(66556008)(8936002)(6486002)(186003)(2616005)(44832011)(26005)(508600001)(54906003)(86362001)(8676002)(4326008)(5660300002)(6512007)(2906002)(316002)(6506007)(66476007)(66946007)(31696002)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?S090SCtXbzNnU0xIZFlPeFBBUmZSQzhRYXdJWjVnQjBRcTdvaVVnSkc4TXNk?=
 =?utf-8?B?c0NUR2h5TUZhUGlqcXJDem9sTmViS0luMW41WTkyS2ViTE15SHRQNE5Cempo?=
 =?utf-8?B?ejNpdjEwKzFubUpWSHNvTjlwZkc3eWxmRUVkb2dVbm5zRGd0Z3gzbXl6OUlE?=
 =?utf-8?B?YUc3Yk5VS3hJU2F6c21vSlNvM0JOcXptdFVFMU9zeVNwSVpmTWJDTDM3NG42?=
 =?utf-8?B?d09VUHBRaVJTYnZXK2ZQekRSbVhJTTJFUExXQmxYbzZTUzN6c1h6amdZV3M5?=
 =?utf-8?B?ODUySk5BcHl2ajU4cGxEYnF5aHQ4MDJHZWdCaEFjbHo1dWtGYzJNeUJEaFdR?=
 =?utf-8?B?aTFPWnZZaHVoZ0daT0MzOVhYQVQ0ZW5rMk84ZEtDajV4Z1o0OWlscWs5cE9Q?=
 =?utf-8?B?bWRqamxqMmtEZVc4NDNKNTR4RjAram5wMkY0YUFWWHFKSDB0MC9pYkhuQk1t?=
 =?utf-8?B?ODltREk4elRKMlFwU281Wk4vQzZYd3pCMWJHWWJmMTV2RnRtTVp4WFhsVWRH?=
 =?utf-8?B?UlpVMGpJYVA1Zk5GdXJQRTlXL0hxbThDdzRyRjFQN09JQ2pydURIYklvY3BG?=
 =?utf-8?B?U1Z4aU9JSDhjdVBCMk1jVmFTQUlnZkY5SzRVUENzRUM4ZVlaTGxWWjU2cDZo?=
 =?utf-8?B?ZUcrcW9BU2g3ZEh0VC9tbnljN1lWNnNaUUg0bTVONmdKdjNTdG5vdVRlb3kv?=
 =?utf-8?B?a3EyaFFYRlhoM01Cd2gvS0xNTFMrcFg2aG5sQVZ6RityM0NOYmdOVVZDMFJu?=
 =?utf-8?B?T0pDeldTUTl3Y1Bxd1BtSHpqdktBaHhPY1dURHg1UE9MM1M0aDloVzBneEZS?=
 =?utf-8?B?MUlmSlBnV0Z6cVgyVFdBOE1KZWg4OG8wb1hmaWJHbG40Y3haa1pDc0t4em1w?=
 =?utf-8?B?V1VFelJ5SlVkL2xjN3BOd2xxcmlBS2pwaTlRQ1dCZmdKUTBNWVdmQnJNalBo?=
 =?utf-8?B?MTQ3ZG5EZklDSjE5bExCcWkyMlJHK3VHaFBUL1VRbWlGVGdOU3dEM1h1Q0gx?=
 =?utf-8?B?UzFZb0RYWkJWQ0pVcVR6eldVZDB1Ny9yaXVYVVI2cjNGWEt6QzVMTDRwbmc2?=
 =?utf-8?B?OUw4OU9Cc09UYTE1ZGx6SGtjVklNYUo0dzRoNExmZHAvUHJKS2lPMVhPYVFQ?=
 =?utf-8?B?cDNZdlJjeGoyZVFVUmxoOHhTUWZWa2RUQVhBd0Nmd0wzOXFMakhZbGVZZmJ0?=
 =?utf-8?B?VVhiNE5xMjhNRXFPTU5WSVVPbWJIcjJJajBDYndnaFE1Y0Z2WHlHZXMwNlRV?=
 =?utf-8?B?ZU92MnJBN21nYTlQd0FCa2ZRS0FnRVFPQzFYOHZBZnVOazRCYzR2YkJ6TzNp?=
 =?utf-8?B?SlRjRmtmWU9tYVpTYnNTR0REbkV3TGlIbDVtaWxlcXhpdnpvUWtXVXNFUFFa?=
 =?utf-8?B?SU5jTVJBUWJUWFJhUmlITmRTSmkwSytxUzAranJ2TkVYTDBPWjI2TXluUy9T?=
 =?utf-8?B?VEIwckEvOHFjcmRndXdBT1ovY0N2NWs5SG9LcE9xUFhZTzQ1aUpUZUxobzg3?=
 =?utf-8?B?bWZZTkRXTXI4ZTBkVnNQYWZKSmdqMEp0WkpaRThMYTN0MTdBSGthNy9qMGRo?=
 =?utf-8?B?Z1VjKzRsbm5xREI1QWt4cFRZMkpCZU9OUHcrNjlYbjJHUFIrWHRuUjBIemMv?=
 =?utf-8?B?L21OODBJd1NMeFc3NDVKeDlnY2JlbC82eFQyb1ZyYlFVOEF2dURtaEpGdXZ6?=
 =?utf-8?B?M0NIK0Y3Q01sZUdPUFpzdFBqbXVUR21XRnViMEgzV3BLMjZ4dmFTUFdORGNj?=
 =?utf-8?B?WkNZZTZEbWJJUkU0MmJwdDkrOEZCUWxVY2pnTTd1c3hQSXUvQUUvTVM1Tm5J?=
 =?utf-8?B?SzB1UlpiaS9ma09ZdGEvQmd1Mm1mWFY5c2RpSUw0WjJyeG9XamlwUC9BUENh?=
 =?utf-8?B?S0laNEh6ak5OZkdLOVBqUkhzVS9jNnJaUXFjVHRxYmZwamtrRlE3bFFPLzBB?=
 =?utf-8?B?c0RXaGdZK3pxblBzMS9MdzhQZzZ2MlJHdGtsc0RQWEZQK0pWL0F3Lzkybldj?=
 =?utf-8?B?TWYxdEdtWjg5cElPNDF4M3hKdmtxZytpVlVxUWxOOUNaSXowOFgvQWpSaXpi?=
 =?utf-8?B?eE9Wa0t1QkxCL0xuNzd0RXpnUk5jT0lGMS9SeTNnd2lNQTRoT0djazVpQVFv?=
 =?utf-8?B?ZWZoSHFmTW9JcC8zQWFvbWdvMzcrdHdqWGMyQ1JYUExXREJhL3NSZEYwQjVt?=
 =?utf-8?Q?GbFmUtVIgRQlT2NDhaVZMhU=3D?=
X-OriginatorOrg: nokia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 435598b3-e794-461a-75d6-08d9f2c42217
X-MS-Exchange-CrossTenant-AuthSource: AM7PR07MB6916.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Feb 2022 09:50:45.0672
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FfOLPvXQeHONiMb1iiLuOfhLmuTHmPvfi8uSWZ+VfIQbcaPwrPvPEaTQGGurzdIyCF8rAgK2dUtjWqpQNXPOuA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0701MB7054
X-Spam-Status: No, score=-1.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,FORGED_SPF_HELO,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Guenter,

Le 18/02/2022 à 07:58, Guenter Roeck a écrit :
> Add support for Texas Instruments TMP464 and TMP468 temperature sensor
> ICs.
>
> TI's TMP464 is an I2C temperature sensor chip. This chip is similar
> to TI's TMP421 chip, but with 16bit-wide registers (instead of
> 8bit-wide registers). The chip has one local sensor and four remote
> sensors. TMP468 is similar to TMP464 but has one local and eight
> remote sensors.
>
> Originally-from: Agathe Porte <agathe.porte@nokia.com>
> Cc: Agathe Porte <agathe.porte@nokia.com>
> Cc: Krzysztof Adamski <krzysztof.adamski@nokia.com>
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> ---
> v4:
> - Fixed reading n-factor information from devicetree
>    [Use of_property_read_u8 instead of of_property_read_s32 to read the
>     property value, and write n-factor value into the upper 8 bit of the
>     n-factor register]

Changing n-factor with DT seems to work:

temp2_input=38500 (nfactor=10)
temp2_input=35500 (nfactor=-10)

Driver probes just fine with this attribute set.

> +static int tmp464_probe_child_from_dt(struct device *dev,
> +				      struct device_node *child,
> +				      struct tmp464_data *data)
> +
> +{
> +	struct regmap *regmap = data->regmap;
> +	u32 channel;
> +	u8 nfactor;
> +	s32 val;

val is not used according to the compiler, and thus should be removed 
(module does not compile with -Werror)

PS: TMP464 samples will be sent by DHL today and should arrive to you on 
Feb, 23rd.

Best regards,

Agathe.

