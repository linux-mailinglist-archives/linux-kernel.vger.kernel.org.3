Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DEDF051DF0A
	for <lists+linux-kernel@lfdr.de>; Fri,  6 May 2022 20:22:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356616AbiEFSZr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 May 2022 14:25:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346024AbiEFSZn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 May 2022 14:25:43 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2088.outbound.protection.outlook.com [40.107.236.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED715289BA;
        Fri,  6 May 2022 11:21:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HV5oLB1MZw9EraiN3hYhKCOG5KEqQ1fuiZaBeRRreljlfC034veF675Ru5e0kTCtWNCSGipHpDv1uEa3Gehw1IC5w2G4X6++3r8UkK8OPOJVHIvl/rQhn9wPTqE27jMUZxMmBjJPtDl12QvweQiZdeDxEWjvgwXtyrDH4ivapoGGRwSssRoBJl02Kkdr4rnwgIdpNL/If6hVpaHPcU7eAw4deGEHUxTliMB+J1gWGhSIgaDHU2jJUK/pg4HnUz7EU73gtTqkKBY77kUOd6Thbj6T8sii7c8j+x7hvhppF3YB5WedOcdeoQRtL957d9M3HeTBRbIYFUUAWF4Rs3KFiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5o6S7nFKlkU2yjIxILxPGroh2JFaA2FRk7RoI0UtD8Q=;
 b=E4a7G3vMkaAMoXRz0HjJwwKX84I6x0gmyOujNXg+zUJoiYLaH0HzORBDB8lIl4DY6Jk3AcPVUlErNhOc52a5MNVbQImu7p8D7IxG2tlUKGatbVHtPZ6+IsSXoDtZ1OBmMx2eniuRn695B2YWBp9czubUokWsSUyxGsAElPGpYgxBN0eig9fxKXi1HqsdM9tuxYVeg7NYJYoUGalR7psoNxiX5cJUZfjRT5tmDX36WOL6uBw2KO4kW8/ls7ZekkMid3WA/+U5Gjx+mgVd8MmW3csIe4SR5lYPy58dqreAUgH6HZKm1nT6VmCczw/lDwg0xUwX+n09F8b+35rIFgCLRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5o6S7nFKlkU2yjIxILxPGroh2JFaA2FRk7RoI0UtD8Q=;
 b=iYcLM0Y4iTzeeBOSgrWWcRKF6vZfd9roOQ60WvzVAuLnMYc7a5dznBHxC3Q4RcFtpRIm72uFm0m9A8mmpnIS8pKjqcrdWG7dK2Oml3l91tVMVOKGKoQjlswHKf+mC4T7+b5nqrLXfUju/0SkKUQ2xMQdAJkUbFXCZPC1oIAuspLm+C6Q0+QcO5GFhRwGx9iQfNMS32vD+XydJ4IT/L+FzfaN3xsT9uglpU41NbCQcMZaGNGSRNv7gzTBjl/auy96O8wuHODrZQ8gAuMhb3zqdkuud4qeWRiTswI/TvgrCy/aqtAm0ZrfIG0q3MqK6D4iBYoCtPFJgXKEPXTAPsWsgg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BY5PR12MB4116.namprd12.prod.outlook.com (2603:10b6:a03:210::13)
 by CY4PR12MB1720.namprd12.prod.outlook.com (2603:10b6:903:121::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.25; Fri, 6 May
 2022 18:21:58 +0000
Received: from BY5PR12MB4116.namprd12.prod.outlook.com
 ([fe80::b998:eed3:9088:780c]) by BY5PR12MB4116.namprd12.prod.outlook.com
 ([fe80::b998:eed3:9088:780c%9]) with mapi id 15.20.5206.028; Fri, 6 May 2022
 18:21:58 +0000
Message-ID: <6044d225-e794-3454-302a-320d0899ca27@nvidia.com>
Date:   Fri, 6 May 2022 11:21:59 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 2/2] hte: uninitialized variable in hte_ts_get()
Content-Language: en-US
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
References: <YnU2p2CoNkcxBUKN@kili>
X-Nvconfidentiality: public
From:   Dipen Patel <dipenp@nvidia.com>
In-Reply-To: <YnU2p2CoNkcxBUKN@kili>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR02CA0044.namprd02.prod.outlook.com
 (2603:10b6:a03:54::21) To BY5PR12MB4116.namprd12.prod.outlook.com
 (2603:10b6:a03:210::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2eac8eef-dbbf-4eaf-a73c-08da2f8d4e69
X-MS-TrafficTypeDiagnostic: CY4PR12MB1720:EE_
X-Microsoft-Antispam-PRVS: <CY4PR12MB172023BE9D1209936765CF87AEC59@CY4PR12MB1720.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: p0YKE3ydVP8xYpw395lweN+ughJIpQI/0K2wGL/iza/lyIuYEqRPRDZbUZOPFWWYQd8kyRe8+u+8Xn0bIPjCnSTQLkemJ0cTkVKitEGSwzjnDpH3MovymREpBYfRfkB+bEfghPJj/E7FH8fC1SORwyANLYDtQi+GupnvG4MdP6G12k5j86vWt5yNdUaEqkKUEukI3cHQIqeD9JsOuVQsGTF/E0x2b5xMKJEyTcS0DyfJVkNU4Du6nWK1SF7tIZHHQjtvNqs0V05z9yXFiCsF5xXCyeNDtzLYVPuYa0CkSkuYmPkz2MPG3mRQr2xYAU6sT+/DTVT4gr/mP/iVsmEnt4E7l6+wHKJuMo9cMWS2oIveAN1gywkL1XQiP7HIuFp3L1Ws0hfhnu3P3slDypChHkwcw92YX7CK2fIJONfdgqLo9q40V8NT9A4k2gBX8p/D7GuYOK90epSAXIW6OMydMDlCh+0DjiKg4m1xCDoKwO6iH9NQ5mPSzfyRJRAJTKthzDOGQDwoFRV8BRGohI8NCDrNi7TEVeod/aCLJfdAylrHZHRnGwdtaIXxIe7XeIhXkOdGsHExYnVBYKXpeWsrWKWg1x9YuVOxPw34ff4dMnE/fYYD2XQ6a206+8Vo8hGtFDAENc6nOD/7s4XBqVn7q5R5dJgjsBHK3NddmwNAVAvFs1ySuJlZMScQ3HZzCk8+cbEYMY8WVYDAEkz77nb4F3TjqJcQlmt8V6ZaXJtfNlUZzHZirzyf8vl9EgEGmnwm
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB4116.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(6916009)(316002)(8676002)(4326008)(38100700002)(66946007)(66476007)(66556008)(36756003)(86362001)(186003)(26005)(4744005)(2616005)(6512007)(6506007)(8936002)(83380400001)(5660300002)(31696002)(2906002)(53546011)(31686004)(6486002)(508600001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?N0dKcnJqdlVncDVRekRBREJSQnFiLy9TUk5tcFQwb3VNK1RSZTFqTUNXU3RK?=
 =?utf-8?B?WS9DWklnTnV0WURReElkRTdrZWdFdzRmbHN4N1g1WnJhQmFjZVBQRjcvSjgy?=
 =?utf-8?B?cVM0VFNyN2lFb0NxQlVGMmpSbDMvYi84Z3VVb2FReFUvb05ISzgzNGxTaDU0?=
 =?utf-8?B?U21kcUNJS0hPNmxxck0zaWtrMm93K2p1VTJidVVYc3Eyc2tCZ0xYRWlrSWpn?=
 =?utf-8?B?VWR1WUwxRkZwbzFNZVJMMHJOQUhSL2JtRHpIYkhhY0RHUVBhMTFmem9lZ1Z3?=
 =?utf-8?B?UDBjVlpEd29BQ2M3ODM0WkdDb2hNdmpXcjFqcE5WeHFMOE1jRnNwL3o0L2pF?=
 =?utf-8?B?UGNDNkZUZy9hYm80RFRaOVNhSmkwL2s5Uk5ndXE4OTVlbnhONm5KcTBpOVVq?=
 =?utf-8?B?T2ZjNXc3TXNobWRXUEdwU05mZ3kwTlFWalAvVGp1OTVYa3pUZDZLQmJZOWNs?=
 =?utf-8?B?SFJQQnltZ1A1TCtqcTAxRjc0N2taQ2trS1djcFFvL01rU0lMaUZXRkM2TUc1?=
 =?utf-8?B?TEFQYWRDY0c2UGpldUJmMkt2WWdVWEx5eG5lb0l4TFZMQUVveWNZMXloMFRH?=
 =?utf-8?B?UmtYM0Z4N20xeVRVbjh5QTdSbkJFRXRVRXpTWWFaL0IzSzI4cDFMRUhwbk5J?=
 =?utf-8?B?ajJ1ellaVTZKZS9wMDJybWp5UHRITjgwNmYzc2JHdUhBRGF6K1l3KzFCc2dy?=
 =?utf-8?B?cGlYLzRZWlZEVHlsUDh5MjZIUEtDK0JRZHltUjBUYmFNdS9XR2hFaGRRaDF3?=
 =?utf-8?B?MThKV0Z0SG5kUDByM1BmdnpRSnFBeEljTHlIL0VRMUdVcE1VMHU3TitTYnJu?=
 =?utf-8?B?RHNuTjZQcEpjOGlHS3ZJRmhPVmU3YXJCSUpTZDROZXRoTWo0YUpNUjJ6aGZi?=
 =?utf-8?B?QUVQOTRhQnFiak1vY3BqYzFsZzNqWnpsTXZ5ZWtYRWRrOG5QbGdsZDNDUXhU?=
 =?utf-8?B?RHNaSjkzL2ZsazI1MzUxaXZ4ajdNQU5EeitrZ3B2eEVsSGtxWFhLM2FoSzlR?=
 =?utf-8?B?TmFtTElpeXpFY1l1MFczRkFORnFkcGJqeU5aaStybmRtbGlCWjE5bGFCbmp6?=
 =?utf-8?B?TU02OHB5azUwY2pHYlA0a1B4TU5tRGNTOGFHL3BKNDBVcHBlaEljTllpZFNN?=
 =?utf-8?B?N2xaZXh5a1M1dWdXOVp3VjRqNzkvdmFTMkVMVkZtZ2dCbERYU0FWRGZXWm4w?=
 =?utf-8?B?Y0tOOEZFTlBSWHlYbWovMnMrWWNHN3ArSmtDY0k4MDJRWnVlK3dmaEdjSFBo?=
 =?utf-8?B?MEVTSW81WThYdE10Yk8xM1RZOTh4UEpuNTNaMitKeERmdXpUUk1WbFVxV284?=
 =?utf-8?B?c3c0Y0hKTE9NTVlMcm8vdCtzUjhLSEEwVkpiangzcEJ5S1pBSEloeHcycjUv?=
 =?utf-8?B?eXdpU2tQU2FrN2p1ZkdhdFRVTldYOXUzSXdjYjJsaWlqallFeFZWUnpYT1VZ?=
 =?utf-8?B?bHB6c3RuYTNJYjlRKzdkTXRBV010akMwaXNUQis4Vit1Ri92MWxtWXZTN0Ev?=
 =?utf-8?B?ajFIRG0xTUxlRzJwZUkwOTNNTW9rY2JLVXVlcTlTZUsyS1M1NUtZNWdyem41?=
 =?utf-8?B?NWJxVlFiYXFVbFM4WGR3K2hvK0V5cWlsQXYycmVLMUgyb0ltWDcxU1V1MEVl?=
 =?utf-8?B?R0lHNWRwWGN2bDUvRXhiUHp6Z0RBRXlzQ2trT1VCdHBYOHoyQUNCZlJubUdH?=
 =?utf-8?B?aXFZKzRVaGtDbnJxLzE3T2pSYWF6N2xadkFQYjNZc05NU2tJamZQdG9UaFBv?=
 =?utf-8?B?VGM3SElsVW8xeThkeHVSQStNMTlwODEyWkFSTm8vTFdvRDhHQ1ZMUWxsMEVn?=
 =?utf-8?B?dVRCL1c4OFhJY3crS1EyZmEzZG05NWZxYjVuWkZlWXpaQnQyUjU0V0pHNkU2?=
 =?utf-8?B?cTFhVUlWeHVKa0xKaW5mRGdvSEdHMFdvSHJSTmtJREVsZDJZZ3JzUzVQeXFx?=
 =?utf-8?B?Q3VOczh2b01SVitiN1BuMFp6YUc3SHA2U3NVTDgyUmZ5ekw0eXNENzdGUTJr?=
 =?utf-8?B?N1p5MnhLUFlJeTJGZ2MvQW10OE1pcU5HUlA5S1ZVWkdDZnBJMVpyNWtLM1RL?=
 =?utf-8?B?QU1WUGhWcFE4N0pHSmJ3T3BZUncwaGlwMWdvS1dUNFVMMlRycGlWSGtJVG55?=
 =?utf-8?B?VUY5SlNia1BCZEtqa1RiSVVKd2pIMit3U0N3bTEyMjFzSjEyV0VKcHphQ0ZM?=
 =?utf-8?B?MHlpOGVhT1lMWGFsVHF0UGVINGhpZzFjcXV6cm5CVVJBWXBVZkdYYWlUNkRE?=
 =?utf-8?B?UHdXUEdmYVdhL0JtT0lxc2QyWWd3b0VTY0FyaVp4SGQ4bWY2KzZHZ1o5Q1hm?=
 =?utf-8?B?NTR1b3QycHZuR0tIVVgrOFVPUTBqWnE0TmdmWjY2cmNJNzhiMnk2UT09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2eac8eef-dbbf-4eaf-a73c-08da2f8d4e69
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB4116.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2022 18:21:58.0193
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bCK1tmz1jayqeT38oE/5WEDJJKxvnurXtSljQMofmvy1Vqpmlk7L86OV96aGFXSebym138mrqJetKiSJyf4swQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1720
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

Acked-by: Dipen Patel

On 5/6/22 7:54 AM, Dan Carpenter wrote:
> The "free_name" variable is sometimes used without being initialized.
>
> 31ab09b42188 ("drivers: Add hardware timestamp engine (HTE) subsystem")
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> ---
>  drivers/hte/hte.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/hte/hte.c b/drivers/hte/hte.c
> index a14c5bf290ff..7c3b4476f890 100644
> --- a/drivers/hte/hte.c
> +++ b/drivers/hte/hte.c
> @@ -572,7 +572,7 @@ int hte_ts_get(struct device *dev, struct hte_ts_desc *desc, int index)
>  	struct of_phandle_args args;
>  	u32 xlated_id;
>  	int ret;
> -	bool free_name;
> +	bool free_name = false;
>  
>  	if (!desc)
>  		return -EINVAL;
