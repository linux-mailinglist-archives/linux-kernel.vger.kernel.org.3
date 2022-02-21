Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27CF04BDF4F
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Feb 2022 18:49:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357145AbiBUMCA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Feb 2022 07:02:00 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:60162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357241AbiBUMB4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Feb 2022 07:01:56 -0500
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2087.outbound.protection.outlook.com [40.107.94.87])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64A85201A3;
        Mon, 21 Feb 2022 04:01:20 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GEHrwLhn3UDOdC9pHm97MZR0tEgkmF0sRHHZMZkKvJjAQI7YP5yH4Q5wp0+DwUfs6OdWrJmKXn+rDdqWuCO1lS+V3dco5Z11Atu4chg3E+Zav00R+DriD4Q6E5zWD2Y82zwJW3Q78pnX2xFXkGi7fN7kzalGg6Jg98TvQ3EIRMcI5lKk6EoKOtBpeU/hDtmPUPYKpUB5xCb109f/VnLGa5KaOqcHQtFRCHQWGQ2SkFjaD0bTbMjbkiXHl+vujLh3KamuqWS+dNwHPQ6RxVu2zgsKupLO4Vb2hHc7+KKsBp1IBmdbboIf9OqT4+uJONM1Sip1NNa1TftKOg9NmzzjAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oYujKGwb5O+LtgyZc+by5xvbqb412mL2zWbMB69DA78=;
 b=cdndoWZTTQpqDhxgEYpVuRtFh5sRHvIo3lWN6URgGKxdR6oC/Q66DV+oofz29hZA9GzcnElV1U+PTYBr8An2PWS+EeOC2PKryRlwiE4ych7PneubWx4faTl0ftl6GNyiRyyW+1SWW5HzYif9+jeyEF0FTERfxg2zqwIOXOHKaYfDGHopJyihjbILgDYLiTdtrHFxwPQkyu79msE/acgAS0QEnBdWu4barSYPgN+psRA8kM4qSmzTkL6sht12hn6pOTi6OVQ6c8AYbIEmspsfXo7cImEW5kFWxFiJNljkEjM7wATXTMGrIxVhBWZqFCcPvrDwh+L9joI3GV7FmJPvgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oYujKGwb5O+LtgyZc+by5xvbqb412mL2zWbMB69DA78=;
 b=a3sPaE46BVRXXyDjBZHpXtZ+xAdPJHHTeKh9WIez1nTELavju2mDzPtTkjHsSoGE/1lIEm/0n0XhLV4mA2RwcnGAaXD4jhDEdgQOZEk1UGtLNw3T+G9mhgixyvR7rszcptj2kriITJZvrbxt147NusBrtKFTZMAi2nr6yEvmKXDpsFHWtjPqL8bbdWPYVmc8ba586/tNoCOafiUWDziybQ1zQHwCQ33f6zsM9vgJyyuORDiaN9o229ryF9/bE9RvSzc1YBBgHsYQs4RkoEjpEIsTtUQbjfnzzp8D5nPD3/Y3KKaWCK+VY2aSHcCWxVG/jVwdw0+scQvNzPKfbpNUNA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CO6PR12MB5444.namprd12.prod.outlook.com (2603:10b6:5:35e::8) by
 DM6PR12MB3483.namprd12.prod.outlook.com (2603:10b6:5:11f::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4995.22; Mon, 21 Feb 2022 12:01:18 +0000
Received: from CO6PR12MB5444.namprd12.prod.outlook.com
 ([fe80::3df2:54be:277e:7ed7]) by CO6PR12MB5444.namprd12.prod.outlook.com
 ([fe80::3df2:54be:277e:7ed7%5]) with mapi id 15.20.4995.027; Mon, 21 Feb 2022
 12:01:18 +0000
Message-ID: <9580f660-2a11-40e4-2986-f05703822d72@nvidia.com>
Date:   Mon, 21 Feb 2022 12:01:10 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v3 2/4] hwmon: (lm90) Use hwmon_notify_event()
Content-Language: en-US
To:     Dmitry Osipenko <digetx@gmail.com>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>
Cc:     linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org,
        linux-tegra@vger.kernel.org
References: <20210618215455.19986-1-digetx@gmail.com>
 <20210618215455.19986-3-digetx@gmail.com>
From:   Jon Hunter <jonathanh@nvidia.com>
In-Reply-To: <20210618215455.19986-3-digetx@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM5PR04CA0006.eurprd04.prod.outlook.com
 (2603:10a6:206:1::19) To CO6PR12MB5444.namprd12.prod.outlook.com
 (2603:10b6:5:35e::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0779bf0e-6b2e-4f39-abc7-08d9f531de3f
X-MS-TrafficTypeDiagnostic: DM6PR12MB3483:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB34835BAAD3DDD2DE9E1159ECD93A9@DM6PR12MB3483.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4Xz0sT/1Ouz1EEMLv8UebAp4c4Bjnwt0v4tEdCAdrX1+9hxvarmCfZGxCmjyYRaQuSHuj+qV8JBoXIs6J/Rf+lVZfn+Mdf/elVS/eL94gYW6qBom1KZ4JwkIEhZ5WC1q3H2LsYGWGOe0RLlT1+fl/VjuoUwldOTg8XQx4jOIXSashQ0UWVZkgoy8s/g53VHHcDbDrpbB5Pts5hwXGJV+wwLq2S6dWbDDAKJ4tQRZkoxGEWyQG7yNXqw93MdsWqBen14BY5vY581RV9VADQfqhZir93mEU3gPfRnyCP/0pVCZYwt3zxXuC6r9mS+0IyeMtvoUO/Za4V/FKIImNjL6CzDSrLduOXBv0QbVnOtzd+TqPX1dBevxN3xn7YCYQbgJplzTG78WM3TRkBRcXhq8wqwG+Uhdh8fJhyRyGYsYRkNuNuuvbIBbepjcCb5hvplhrvdO0vf3tj5bKuYpTGFWYMC0bO4JfzFCcHbN0tbcfKJKP6fKNmauqegtTCP8cW+tDHFFK/GutAW3K1mCNdymHy2Z1JXovaE6E0PXlb2FCnaWUZwFm0N+TX28tqvXvuW/NrwoW6TohE211tqnRHduj+tRc2Q/v3socVzdV4g7VvS09V3ZS7AOXsCFPCtlLrkstdQafARkqIJoyZ4u9Dyh/G+0jZuhnUf/W/xES+dEqqq+xHO9n0rff1akhnF7t79M/v58RlqB67DCLDMPdYa9EFF3TlUCFTME4WUkZnP303w=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR12MB5444.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(6486002)(110136005)(31696002)(86362001)(8676002)(4326008)(316002)(66946007)(66556008)(66476007)(26005)(186003)(2616005)(83380400001)(508600001)(5660300002)(45080400002)(55236004)(6666004)(6512007)(6506007)(53546011)(2906002)(31686004)(38100700002)(8936002)(36756003)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Sm9jamRpSjJGUlZJWGJBYzVDVFdCYjF5NktBelZFU3hjck5uRVVuMUpaMFhk?=
 =?utf-8?B?M3ZaeEJ0VXNWL28zY3kvaHN3QVM5dk1DRjU4YWdOMVY5cGhnK3pTZ2xpd1hq?=
 =?utf-8?B?ZVNUK1AvRXdhN0k5ZlV6YXN0VUg0cGlmU1RpUXBVRGFuZkpkTWdzMHlPTCtK?=
 =?utf-8?B?bUtadWY4Skd4L3VJYnZYVG9PY2tNZ2lwRXhPRkJlTWVmRUt6a0FSWVBiZE4y?=
 =?utf-8?B?TGVMTGxxeUlzMUh6bXZ4b29wSTFSSEw3UmhGSFdOdU9aRXdMQjBSYUx5dnBj?=
 =?utf-8?B?c28yLzJKRTY4ekFDUGtyczl1SjBVaURIOXoyTFdRbDQ5VE00NDlrbGVUd3lE?=
 =?utf-8?B?WXpOT1FEd3pRa1lYcHJoZjl4VXNaRlRWcFhrVEhUb1pBdFZWVVg5eDB6Snpl?=
 =?utf-8?B?NkJnL21OT2p0WkI1WnFoRlJRSlJyMnJLcHM0aHJ3dWY5VHRZQ2ZaK2J1MUdx?=
 =?utf-8?B?dWpXQnR5eC9BR2hkbmtoeXZJOU01cVlobTB0V1VBQWo3NVFObFBodlVZR0lJ?=
 =?utf-8?B?U0g1ZVM3TlMyVm1PajRJTFZtRmxyQkxiTWE4QXZjT09CSUc4UGI2aTJFSkh2?=
 =?utf-8?B?eWFiNHFkNjA1S1lLRUVwOHM0Zm9VWWk4UU1PS0NnQTBHcmhFeDY3RytkaDRq?=
 =?utf-8?B?NWF3QjdxNEQyZVBCQTRvdDRnVG1YY2tnMlZlWENOL1Z4Q1JBKzRSckgra1pa?=
 =?utf-8?B?ZmhCbGVNSTVkVzdyaU9lMTJrUmY4ckpVZEtuSlR0dmJGbld6NE1oOVNlZDRC?=
 =?utf-8?B?N1lLVUN2N1NTZkw2SEhid2RmSVJkcDNpTy9CSVFBby9yUWx6MGRnOExEOXlH?=
 =?utf-8?B?V0xTYXdqMDBFZVgzQ1BiY0pEYi9iRWFYK01PTG9sQ1o5YWlVNFJObjRZelcy?=
 =?utf-8?B?S2tQUWJuTUNZMWlQRi9GUUp1eTNSZUlMSnBLVC9YN1dWUE5YNHFtbi9MaUt3?=
 =?utf-8?B?UW1LRGRJWStCcitzei9BWnRscW85LzRFdzFmRWVWVzBkNEV1Ty9UK3JsTGp3?=
 =?utf-8?B?OUxFODBzczAvbUdiYmd4dU9BMFgvYlFGRVpNcVhZQkR4REloOVp0elJ2U2J5?=
 =?utf-8?B?L1l0UjRuMSs1ak1SWE1PQ25pZ2ZaR2o3enI2YUs5NVBWMFZLcHNONzhEY1hS?=
 =?utf-8?B?a3NleVBpNFphcGJsY0IyQVovMzVaMHRjQ2ZxOFBoWTBtaG9ZQWZYWVFEOWkv?=
 =?utf-8?B?eTFYeVgxaWJPbnJ3aEpFSUpsOFQ2LzQ4UjZJOGJ4K05OallhNGNsQWVBMjZk?=
 =?utf-8?B?b3I5d0o3QTVzbWNPL09VMnRnRFppVW1GUHV0NjhVTXVTUEE5WGZrbGJkZU91?=
 =?utf-8?B?aGtzU2dpWTNnaHlyTm9vdjJsaGg3S3FlZDdybUJMMWgzZUFWOXIyTEpXMVEz?=
 =?utf-8?B?TjVQNDVLTEZueFFUUnZZTGdvdnU3dkRYN01UOThqT0xFMDFiNmRNM2hScTgr?=
 =?utf-8?B?QVpIS3VlS1VFRmlJQWhOR3FFc0ZCZ1Y3M1hBbmFsTVVNekFHdFBVSXRkem5n?=
 =?utf-8?B?YUNra0NKZmpjZkVjbTRuU09ZRG91ajRjRGh5RlBBZXlCMHZ1ejJKSTRjNFpP?=
 =?utf-8?B?STFJM2dxeXoxeTZ2WFpkQUJLMjZ5QXFkdjNEbjZwa1BQYzhFRXZxa3hSZjZu?=
 =?utf-8?B?RFFscWpsdVlmbGUyRUNNdXNZdVFpTDd1RGtDMXIrZDBTdk5mSHpRbWVid05P?=
 =?utf-8?B?YmRLUmhic1lqZ3dDNGMrMzJ5UE9oemd5aWk4UVNyOVl1YUg1VEdFQlh3cmh6?=
 =?utf-8?B?QUcydXpLVnU0bE1uVWYzZDRneEQ0ak9paFNQVVA5OW5qcGovSlR5VVkxTlpU?=
 =?utf-8?B?c1RJVC9CUVYxdVpJa3RIVDFObitRcnY4T1BBaGZhZjY5cWhlOUIvYUlDcjBQ?=
 =?utf-8?B?ZnI1Z3JnelRlK0l4NWt1Tk8ydGxDMjMxREh5OGU3a2lRUFQ3b094YmpSbCta?=
 =?utf-8?B?UkdIUEVSaWpTalBhd0tUWnMzV0VYMzBiZVN0cDhGNEEwZGVCVzk5VE95ZlhY?=
 =?utf-8?B?OG1GUEh3VDBRR2ZCK2EyckMybEpXa3hXSlY1Nm0rOG9OVUE5VEtmZzV6eW1Q?=
 =?utf-8?B?b09vYUhwUzVLd0tpUS95NWc0VDB4bjBGQXowbk1YMThhMU5hT21PaE12RU5s?=
 =?utf-8?B?ajBEWjRjODZSOG5Wc28zbFB2bVRuZjBHTXFUbEpBYitVYlFLOTVvOXB2a2xC?=
 =?utf-8?Q?AXiH22O1s9yDpfRjUk+wzw4=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0779bf0e-6b2e-4f39-abc7-08d9f531de3f
X-MS-Exchange-CrossTenant-AuthSource: CO6PR12MB5444.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Feb 2022 12:01:18.4759
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nCiw5VWSL7I39k6FSZkIGmSewrO3/4yiSHkYjdHLJOTplit0OpmmFbDixJ9/Iss7Mf/zspT+21QtO4WWYpYeZg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3483
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dmitry,

On 18/06/2021 22:54, Dmitry Osipenko wrote:
> Use hwmon_notify_event() to notify userspace and thermal core about
> temperature changes.
> 
> Suggested-by: Guenter Roeck <linux@roeck-us.net>
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> ---
>   drivers/hwmon/lm90.c | 44 +++++++++++++++++++++++++++++++++-----------
>   1 file changed, 33 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/hwmon/lm90.c b/drivers/hwmon/lm90.c
> index 2e057fad05b4..e7b678a40b39 100644
> --- a/drivers/hwmon/lm90.c
> +++ b/drivers/hwmon/lm90.c
> @@ -465,6 +465,7 @@ enum lm90_temp11_reg_index {
>   
>   struct lm90_data {
>   	struct i2c_client *client;
> +	struct device *hwmon_dev;
>   	u32 channel_config[4];
>   	struct hwmon_channel_info temp_info;
>   	const struct hwmon_channel_info *info[3];
> @@ -1731,22 +1732,41 @@ static bool lm90_is_tripped(struct i2c_client *client, u16 *status)
>   
>   	if ((st & (LM90_STATUS_LLOW | LM90_STATUS_LHIGH | LM90_STATUS_LTHRM)) ||
>   	    (st2 & MAX6696_STATUS2_LOT2))
> -		dev_warn(&client->dev,
> -			 "temp%d out of range, please check!\n", 1);
> +		dev_dbg(&client->dev,
> +			"temp%d out of range, please check!\n", 1);
>   	if ((st & (LM90_STATUS_RLOW | LM90_STATUS_RHIGH | LM90_STATUS_RTHRM)) ||
>   	    (st2 & MAX6696_STATUS2_ROT2))
> -		dev_warn(&client->dev,
> -			 "temp%d out of range, please check!\n", 2);
> +		dev_dbg(&client->dev,
> +			"temp%d out of range, please check!\n", 2);
>   	if (st & LM90_STATUS_ROPEN)
> -		dev_warn(&client->dev,
> -			 "temp%d diode open, please check!\n", 2);
> +		dev_dbg(&client->dev,
> +			"temp%d diode open, please check!\n", 2);
>   	if (st2 & (MAX6696_STATUS2_R2LOW | MAX6696_STATUS2_R2HIGH |
>   		   MAX6696_STATUS2_R2THRM | MAX6696_STATUS2_R2OT2))
> -		dev_warn(&client->dev,
> -			 "temp%d out of range, please check!\n", 3);
> +		dev_dbg(&client->dev,
> +			"temp%d out of range, please check!\n", 3);
>   	if (st2 & MAX6696_STATUS2_R2OPEN)
> -		dev_warn(&client->dev,
> -			 "temp%d diode open, please check!\n", 3);
> +		dev_dbg(&client->dev,
> +			"temp%d diode open, please check!\n", 3);
> +
> +	if (st & LM90_STATUS_LLOW)
> +		hwmon_notify_event(data->hwmon_dev, hwmon_temp,
> +				   hwmon_temp_min, 0);
> +	if (st & LM90_STATUS_RLOW)
> +		hwmon_notify_event(data->hwmon_dev, hwmon_temp,
> +				   hwmon_temp_min, 1);
> +	if (st2 & MAX6696_STATUS2_R2LOW)
> +		hwmon_notify_event(data->hwmon_dev, hwmon_temp,
> +				   hwmon_temp_min, 2);
> +	if (st & LM90_STATUS_LHIGH)
> +		hwmon_notify_event(data->hwmon_dev, hwmon_temp,
> +				   hwmon_temp_max, 0);
> +	if (st & LM90_STATUS_RHIGH)
> +		hwmon_notify_event(data->hwmon_dev, hwmon_temp,
> +				   hwmon_temp_max, 1);
> +	if (st2 & MAX6696_STATUS2_R2HIGH)
> +		hwmon_notify_event(data->hwmon_dev, hwmon_temp,
> +				   hwmon_temp_max, 2);


We observed a random null pointer deference crash somewhere in the
thermal core (crash log below is not very helpful) when calling
mutex_lock(). It looks like we get an interrupt when this crash
happens.

Looking at the lm90 driver, per the above, I now see we are calling
hwmon_notify_event() from the lm90 interrupt handler. Looking at
hwmon_notify_event() I see that ...

hwmon_notify_event()
   --> hwmon_thermal_notify()
     --> thermal_zone_device_update()
       --> update_temperature()
         --> mutex_lock()

So although I don't completely understand the crash, it does seem
that we should not be calling hwmon_notify_event() from the
interrupt handler.

BTW I have not reproduced this myself yet, so I have just been
reviewing the code to try and understand this.

Jon

[ 7465.595066] Unable to handle kernel NULL pointer dereference at virtual address 00000000000003cd
[ 7465.596619] Mem abort info:
[ 7465.597854]   ESR = 0x96000021
[ 7465.599097]   EC = 0x25: DABT (current EL), IL = 32 bits
[ 7465.600338]   SET = 0, FnV = 0
[ 7465.601526]   EA = 0, S1PTW = 0
[ 7465.602705]   FSC = 0x21: alignment fault
[ 7465.603885] Data abort info:
[ 7465.605017]   ISV = 0, ISS = 0x00000021
[ 7465.606171]   CM = 0, WnR = 0
[ 7465.607301] user pgtable: 64k pages, 48-bit VAs, pgdp=00000001041f1800
[ 7465.608490] [00000000000003cd] pgd=0000000000000000, p4d=0000000000000000, pud=0000000000000000
[ 7465.609814] Internal error: Oops: 96000021 [#1] PREEMPT SMP
[ 7465.610991] Modules linked in: bridge stp llc snd_soc_tegra210_admaif snd_soc_tegra_pcm snd_soc_tegra210_mixer snd_soc_tegra210_mvc snd_soc_tegra210_i2s snd_soc_tegra210_dmic sn
d_soc_tegra210_adx snd_soc_tegra210_sfc snd_soc_tegra210_amx snd_soc_tegra210_ahub tegra210_adma snd_soc_rt5659 snd_soc_rl6231 pwm_tegra tegra_aconnect snd_hda_codec_hdmi rfkill snd_hda_tegra snd_hda_codec at24 phy_tegra194_p2u snd_hda_core lm90 snd_soc_tegra_audio_graph_card tegra_bpmp_thermal snd_soc_audio_graph_card snd_soc_simple_card_utils pwm_fan crct10dif_ce pcie_tegra194 cec drm_kms_helper drm ip_tables x_tables ipv6
[ 7465.632232] CPU: 2 PID: 433 Comm: irq/140-lm90 Tainted: G           O      5.16.0-tegra-g9d109504d83a #1
[ 7465.636285] Hardware name: Unknown NVIDIA Jetson AGX Xavier Developer Kit/NVIDIA Jetson AGX Xavier Developer Kit, BIOS v1.1.2-901d3c52 02/07/2022
[ 7465.650457] pstate: 60400009 (nZCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
[ 7465.656210] pc : mutex_lock+0x18/0x60
[ 7465.660134] lr : thermal_zone_device_update+0x40/0x2e0
[ 7465.665117] sp : ffff800014c4fc60
[ 7465.668781] x29: ffff800014c4fc60 x28: ffff365ee3f6e000 x27: ffffdde218426790
[ 7465.675882] x26: ffff365ee3f6e000 x25: 0000000000000000 x24: ffff365ee3f6e000
[ 7465.683485] x23: ffffdde218426870 x22: ffff365ee3f6e000 x21: 00000000000003cd
[ 7465.690816] x20: ffff365ee8bf3308 x19: ffffffffffffffed x18: 0000000000000000
[ 7465.697982] x17: ffffdde21842689c x16: ffffdde1cb7a0b7c x15: 0000000000000040
[ 7465.705320] x14: ffffdde21a4889a0 x13: 0000000000000228 x12: 0000000000000000
[ 7465.712493] x11: 0000000000000000 x10: 0000000000000000 x9 : 0000000000000000
[ 7465.719580] x8 : 0000000001120000 x7 : 0000000000000001 x6 : 0000000000000000
[ 7465.727099] x5 : 0068000878e20f07 x4 : 0000000000000000 x3 : 00000000000003cd
[ 7465.734348] x2 : ffff365ee3f6e000 x1 : 0000000000000000 x0 : 00000000000003cd
[ 7465.741347] Call trace:
[ 7465.744207]  mutex_lock+0x18/0x60
[ 7465.747427]  hwmon_notify_event+0xfc/0x110
[ 7465.751358]  0xffffdde1cb7a0a90
[ 7465.754574]  0xffffdde1cb7a0b7c
[ 7465.757705]  irq_thread_fn+0x2c/0xa0
[ 7465.760937]  irq_thread+0x134/0x240
[ 7465.764850]  kthread+0x178/0x190
[ 7465.768083]  ret_from_fork+0x10/0x20
[ 7465.771748] Code: d503201f d503201f d2800001 aa0103e4 (c8e47c02)
[ 7465.777865] ---[ end trace f0b3723991411538 ]---

