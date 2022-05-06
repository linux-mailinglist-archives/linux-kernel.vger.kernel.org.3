Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3513451DF15
	for <lists+linux-kernel@lfdr.de>; Fri,  6 May 2022 20:25:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351512AbiEFS3Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 May 2022 14:29:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230050AbiEFS3W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 May 2022 14:29:22 -0400
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam07on2064.outbound.protection.outlook.com [40.107.95.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 874EB4616C;
        Fri,  6 May 2022 11:25:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X5j50jCCfFRUYSBgpWRo8WYINllHB5FQF3eBv2HCsZgu20EAotq0SzwrRX+8Y7PxaEnRntpFQVcOK0wCI9EgeCc7itaE/7+oX7CoUW16ewNoa9r4ZxOb4ZsvH729ffjvqgmubPzWJlEua7TUYqJel1ziNumHv1kYagjKbP1RyjRyyT0RqQq+Ae1EzHS3KTS+RHloLy2U459kVpmUlYG+Zu82ZJTysqa/dE0FKHg00aXS4CfK2EqqqrT+rqOKxTb3RnAWnjyvzBXVq+eUP3Eq3tqC5posGZMaLl++o9xpgKgK9yRopqj2ZpPHSEbWKmi6mUFO0ll3CVGWXCOTCerqqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=brOoYI9LbTbK9ZeyRCKEf7LQPxCcXKDBLcFWVioCF0s=;
 b=WgZxYMAN+y/xK6FKL7oowDmGx1TcEWOAkexgOKGMLV+XL5XyBERXMdNAhPYeOPfNM5NNP+dZMQHw4I+ImpSI6kmHuG9TdpB+DuEEWbxesneOuUYI8X00db0s0lqwswi2OZ0F3dUo2CTsWLZBm4sF0/hR0ypAad+92VaFn1bLwFTTu/E/UCHdLNkT9CZUnEe8rtuxFCCnLiENXgep4Hu69GhngdEb8SFoyT8BXCspJ3573fSVZGMn58bGh7jVUDpEFmXXLahB8HaJlk8+1BZtuVXTctfV9qGOZD939TOqgntcjMEPYFQgg8E797mPbHKHyAX5awjsmbIqcdvmOvxK6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=brOoYI9LbTbK9ZeyRCKEf7LQPxCcXKDBLcFWVioCF0s=;
 b=VbrTfiXAr4bX5S8mDrqXQpA0IEg3kv2Gy2jzMGBKLjlL3lI29n0hBE13s6FGJke0zO3WaE0NTOaz43grTe036iohgt0ySohpdJlC1plUPw3vtEmL82Su7j//ttx6ihvXpHE8uPq/XC+dJNXaj54iXlf3lcX8rxw150b+fLOO7G6sXAqzweEoA27YjPulkBrEfNKbY+0VIrjowmb4G8D4872dIJFhB3un/z5KHGQMx8VlaaVOURmCtWY53rBouZ9iDZPlhwCcDCYP0pMAbICq2gsdi4cEWaTyqj8Ya04Pw48m2g53O8T5SQlC/Y0MBNkVLAhRCyvCoASs0M9x65NRyQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BY5PR12MB4116.namprd12.prod.outlook.com (2603:10b6:a03:210::13)
 by CH2PR12MB4053.namprd12.prod.outlook.com (2603:10b6:610:7c::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.24; Fri, 6 May
 2022 18:25:34 +0000
Received: from BY5PR12MB4116.namprd12.prod.outlook.com
 ([fe80::b998:eed3:9088:780c]) by BY5PR12MB4116.namprd12.prod.outlook.com
 ([fe80::b998:eed3:9088:780c%9]) with mapi id 15.20.5206.028; Fri, 6 May 2022
 18:25:29 +0000
Message-ID: <6e5ae4c2-abe2-048a-21b5-783f1c77bb08@nvidia.com>
Date:   Fri, 6 May 2022 11:25:29 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 1/2] hte: fix off by one in hte_push_ts_ns()
Content-Language: en-US
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Thierry Reding <treding@nvidia.com>, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
References: <YnU2gHe+QZOAuNyV@kili>
From:   Dipen Patel <dipenp@nvidia.com>
In-Reply-To: <YnU2gHe+QZOAuNyV@kili>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY3PR10CA0007.namprd10.prod.outlook.com
 (2603:10b6:a03:255::12) To BY5PR12MB4116.namprd12.prod.outlook.com
 (2603:10b6:a03:210::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c6bbad61-b4ff-4318-386d-08da2f8dcc16
X-MS-TrafficTypeDiagnostic: CH2PR12MB4053:EE_
X-Microsoft-Antispam-PRVS: <CH2PR12MB405351003D179285355A2F85AEC59@CH2PR12MB4053.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5nKrvkYLIm2mctLhygkRIxJCpcZBEfis5h2/Wd4nby76za+KUZmYMcmcuyKVXRJp9taBEAEOsShsSi3w4/UbuwQ4HvyEn6HFBcyU2rR+J16jn7WW2yaarJc7zp6BP3DTPy5OWN42W3UWu+VrQ+qQTacDrrUGnluxFQfcCVzp0EWcVPDuMuluqUwqonFu41i0Pc4OxpnoFvmwbKy6gy4AoQraBIi7HA5XLHfFTbxi7+alkg86rJUJWw3J5NZfXyuxqptHEG5Ghata3jkB1l0MPcUUOnvuHBKkNMsjT39rJC2nb6VNJ34hnMr9E3NUI1TQVD24gpKvP/Mt9XVs1ekMRTprjVH77QS9fLOkhINPFfNZbk6jqSj0q2ob0vcGiS4jugxNBU1HwMNUArHnjJg+A+mOg19LRSUl/Bf0AMpEzLIMF0Jo1UVyUUS+0e/uZUfSYOPp5IhJ9ngjDAghZnAg+OuxhbtyHfSzIneKOgA/vFKm+x/eUiYdkk4BUEr//JPpmCRCD6/6Hm4PQvKaHehCYBBPjuLcdikxJ/9X1tri4DLLZdJ/Q0Kdo1Pr6iSvqqRJSYvBxiZfyUNqCxNXIDFPG30nTRWM63uezgBGz7o192TSIRjd/F1itsj53dm00mS3lQQmqOSCH8wUg1Gwa682e07BGcDKFXWjxCmgnaTMvyUIY4SmbGpfDOzCD7NpPpkQnyquVyFQG9lm4n4QPPFz5elwFADg4bYSPwttsKRk7MIgRiNCx9DVwfgeMJAFQomf
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB4116.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(8936002)(66556008)(66946007)(26005)(4744005)(86362001)(8676002)(4326008)(66476007)(31686004)(6486002)(2906002)(6512007)(36756003)(53546011)(316002)(6916009)(6506007)(508600001)(2616005)(83380400001)(5660300002)(38100700002)(31696002)(186003)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TDRYVXEwUWVvQ1BUZE9iZVdCaXhYYXJOdUlMTStGRWtoMW91TkZuclZUVGZr?=
 =?utf-8?B?eUxsU0xWOTl1MEV1cWE1VS94WGNVYmlKbFdUZGhuZkl2WDdPM3ZSak40bkFO?=
 =?utf-8?B?UUwycDh2cTFrdFZOWE91anBGT2o0bjVnY1BGM0N1cjFPeEhYOUdBdVV3aTY5?=
 =?utf-8?B?d0trNVFsN3NDazVXLy82M29XMzQ1Z3hybUhneTJiRXdPSGVCLzlSV2NXSFMv?=
 =?utf-8?B?RmY1Yk0wbDhuUFE4YzVHN3l5eTBrdWFHcXpHTnByalh6QnRZSEJFV0JkbTVL?=
 =?utf-8?B?ODl6SkM0S2xVdnFoQXpVNExHQjMzNDNreHVqVzRSWDRSTkVoeFZ2bU8zS0NH?=
 =?utf-8?B?Y1c2dHhMVEU3MloxbVlvY0l0aFpVdkNZMmREOGpuOTR6bW1XMHUxRlVja1hG?=
 =?utf-8?B?WFZpR3Y0d2ZBeHU0TExKRmk2Y0ZQTHJiNW9laUtqNWlLUjgzYWs3K210TXZF?=
 =?utf-8?B?OGI5N2xhZW5aeVV1M2wvMWhEcDhCb3lPTERDbms3YXZCT0FWNk05di9ITUJO?=
 =?utf-8?B?VDMrdEs0RFpQTkJOaUtybGpBUUxXVEl1b2diUmlabTRrVFNHVStoQnVXbHhi?=
 =?utf-8?B?M282eEtEaVhjWVlrRnlKN2kzUU5xRU1JZTdScVA0UXZvTmRBcUNLRTIwMy9t?=
 =?utf-8?B?Y0FldVhWY0hodmR0dWx1OVdudEFhK2d5TUJyNjYwWkFiOExBeWpiVUVDTTdE?=
 =?utf-8?B?bGpjRjNoREtlNzR6NFFNa3hMUElSeWJocWVyclJUNW1PcGpBVEwwYTlQSWda?=
 =?utf-8?B?UWd5azBVeGRDYW03T0x3bHlnN0ZoVnFuUUFVLzBQcjlKZTBMdWRQajBpWGRm?=
 =?utf-8?B?MG1VVGMxbTc4K3kzNWFMdXlUcEs3Z250OTF1VmZXMmgrM0xLdjFvRDVwV2xZ?=
 =?utf-8?B?K2V4cDJXLy8xS1RYdzBDMXdDeUNmcWVTdFhDeGRzQWxyRFJ3VmdUalRFN2Np?=
 =?utf-8?B?OTg5ZU5PRjE2eENudUorbjl4ajQzRDVKc3h5SThzNUpLaUw0MVN6UVErVVB3?=
 =?utf-8?B?dVdmZjZKSE5uRGNHbTlsK0dFSGk1aWR3NDQrS1Zzb0o2ZE1aNVNhTjVEQk1m?=
 =?utf-8?B?Q3Fra0lYSnNxTFA2dWl2Q0thei9jaVpxZnAxbUdmTDJEL2h4ZVFNM1liYk5r?=
 =?utf-8?B?UjBBay9YaGF3Y3BvZG9ZbWlkYk9RaWxyVkhvSTR5Q3NHNnM3a2kzc1k0OXpH?=
 =?utf-8?B?K2FNdTJvL0NVN3h3cE1rdEZnMHI5OVhRdjZwRUhqSTFpMmJGbStSaGxDTWQv?=
 =?utf-8?B?K2dDdWJ3anF0SWNzdUpzVmdSbUg3bEJxTzdNalNiZnFld3RNakxKSWVhQW52?=
 =?utf-8?B?YnFWUFBRVFdUeTdrUm5Ta2V1NUhBd0VIMmJuR3o4U25PZk1SblhzUFFmWG1u?=
 =?utf-8?B?V21ZanRYRXBaN0RqRW9tZ1RCZWFWdytHTUdLM3NGQUNRZTI3RFkwQ3QvM2Rk?=
 =?utf-8?B?RzZRbUhZd2REUHhPM2pXdXhzQjFIRkl1ZTR2aEQ3RldiVThVTi81a1lkQjFQ?=
 =?utf-8?B?SS9xU3hzb0dnYlB1aEkySFlUd3BhVEpqK3kyMC95YjZXUjFKSjhLNU8yTWhV?=
 =?utf-8?B?WnpOMnBka2oybTVmaW9Uck9Hc0ZaSTRaK2FZVTNxRG96N2xLQXBkYlVaUnFp?=
 =?utf-8?B?a3ZBSW04dGVoVVlzSW0rcTdWZEFheEJqWnZXcWVRb2tlVVhCTHEvWVpWam1q?=
 =?utf-8?B?dUV1SVF1eTN5bzAzM2ZROS9XS2FDemVSd2g5UjBURXlHQU5QV3J5ZmVxK2hM?=
 =?utf-8?B?MGRKRXZ4MlhsRFhPZzJ0Zk43NHVqWGhxOXpQV3U3U1dKVGV4am9TYzZXQmkx?=
 =?utf-8?B?OGNLU0ppcC93ZUlZbzBFR3h0R1E1dXRNUEl2cEQyQm91MWpRTnJpaDdvZ3ZQ?=
 =?utf-8?B?ZCtTdjdHY0V3MEthT2c2QjFubGZTTkFlRDB5b3JGQnNtMWZpMm9VTVZIZWph?=
 =?utf-8?B?OGp2bCtQNnppbkdoTnd6OStLY0tRRDlsM0dNUkxzUUMyK0FsQS9FWC9XWlFU?=
 =?utf-8?B?TVlPNGNaaWVmY2pQT29ndWFmZ1M2aUVlVWNFcm9uOTJURDZhSG9iQVo1VGc4?=
 =?utf-8?B?Ni85a1ZmL1JwSkF1ejU5dWN1Nm9FYWw2YUpPSEpKV2RaTlJXVmt2L3BwQ3Bj?=
 =?utf-8?B?S1pGZmtXTXE0UHh1d0NTTTRiN3dVT2lxWi9NY1dzZXBHL1ZIdXNPUUJPT3dW?=
 =?utf-8?B?L2Nna1dVYmhuVG1NTlBRNXR0S0hxWkhRVEptRWpNcWd3RERCblJMYno3R3RP?=
 =?utf-8?B?QkJXU1dKTUcxSE9xcjYwcjJQYllNNWszc1JLazlpN1RicWQyM0dESFB3T0Qw?=
 =?utf-8?B?UGo5MjRiMStVMnZneVl5MEtEVHVrS0FmOU9LTy9sajNrbllCRXlvZz09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c6bbad61-b4ff-4318-386d-08da2f8dcc16
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB4116.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2022 18:25:28.8811
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mrRQoljztsT6pG8Zduc7i76nfsZLXYADQHbkwjyl/1nUBIGGtVbLZHCno1c9KYXv0vT7dT/KpaJa2TppshQ2yg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4053
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

good catch. Thanks.

Reviewed-by: Dipen Patel

Acked-by: Dipen Patel

On 5/6/22 7:53 AM, Dan Carpenter wrote:
> The &chip->gdev->ei[] array has chip->nlines elements so this >
> comparison needs to be >= to prevent an out of bounds access. The
> gdev->ei[] array is allocated in hte_register_chip().
>
> Fixes: 31ab09b42188 ("drivers: Add hardware timestamp engine (HTE) subsystem")
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> ---
>  drivers/hte/hte.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/hte/hte.c b/drivers/hte/hte.c
> index 891b98ad609e..a14c5bf290ff 100644
> --- a/drivers/hte/hte.c
> +++ b/drivers/hte/hte.c
> @@ -811,7 +811,7 @@ int hte_push_ts_ns(const struct hte_chip *chip, u32 xlated_id,
>  	if (!chip || !data || !chip->gdev)
>  		return -EINVAL;
>  
> -	if (xlated_id > chip->nlines)
> +	if (xlated_id >= chip->nlines)
>  		return -EINVAL;
>  
>  	ei = &chip->gdev->ei[xlated_id];
