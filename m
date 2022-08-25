Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9794F5A19B6
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Aug 2022 21:42:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243480AbiHYTmH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Aug 2022 15:42:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232070AbiHYTmF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 15:42:05 -0400
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2079.outbound.protection.outlook.com [40.107.101.79])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3A02BE4D9;
        Thu, 25 Aug 2022 12:42:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Jyt5SQt0n5cuTvWg6qv28ajpkWyzc3IaBWGaDGB1tSSancg82A6r7jNWV33hDuZa2huZlD0eZUeo6H3aTkqU/34YZtPpnbHjwFXARhOCe9eQKhim+weZfTBQI/cp3V1L388s45PuSoY92G5YCDC/B3UNzFoSbSoHMskUFncjFSQsUxBj0yAj213z2t6LV3yqplzta9u7XgF1rEvnKTCpwLGMUy9jYERppTQfsKQA1/tWvhsfeif78PnXRCqOD1YRVOQstDKXVDTT8W4MO2HPgSpijl2Jvd4JdtuhuSfX1OwiXg7XWNNAOvO1O2PlEe36F7wViALCUb/ngzXl068jwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4KpZVDckR6q+xmCedZDNoj82MQ8j/5Bn5IvqpNeVA5Y=;
 b=jV9wXim2qhWROCEODaZ0uejeuKuWyUt4eXt0wq1Rqt3kS8ICSY0RDydSBi0HzAn1Pj73nWL6iuciWB3CFhKwWNcUBp8+ZM74XpRmCGuXV7bMS/il6vz5tcXaUNZ2zseivDq13o47c9pSmtf0qOCTjxChKifR0luxAkNKNKAwKgRxc2/zp+BdDrHBMo10q1vsCRgwRAMKWceoNKqGsc29gKL2ujRc9y6xyOO7849h8N6gYrgz3ftGnrccgVNZ8BRh/t1vv5ryCnOXrD9Vs8nWx9qn/jAkarar4yEHw+zZVfFrrezsRTZaKKSsrKFDZ4Z+IcnYd8isFffla1l8+5j+1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4KpZVDckR6q+xmCedZDNoj82MQ8j/5Bn5IvqpNeVA5Y=;
 b=uNC+kCwDL7836WjPpvh5lnnV3ZY+1wS5teXBby48ZS0jTK5Vu6wDAHGy4W0FQBuj7gfJCqu7rF3o7xSMq1AV6rlZTcv5eK+uokkJtxEoKSy9ds9Mpd3OMXFyyF1L33woXNNmvYj/CLw4EGCyRDu1oG+PE5NSP5mh24CamQcv8wQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5229.namprd12.prod.outlook.com (2603:10b6:5:398::12)
 by PH0PR12MB7012.namprd12.prod.outlook.com (2603:10b6:510:21c::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.15; Thu, 25 Aug
 2022 19:41:59 +0000
Received: from DM4PR12MB5229.namprd12.prod.outlook.com
 ([fe80::c175:4c:c0d:1396]) by DM4PR12MB5229.namprd12.prod.outlook.com
 ([fe80::c175:4c:c0d:1396%4]) with mapi id 15.20.5566.015; Thu, 25 Aug 2022
 19:41:59 +0000
Message-ID: <912e3a42-8084-1c90-6e6e-82308dab28c6@amd.com>
Date:   Thu, 25 Aug 2022 14:41:56 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v2 1/2] crypto: ccp - Initialize PSP when reading psp data
 file failed
Content-Language: en-US
To:     Jacky Li <jackyli@google.com>,
        Brijesh Singh <brijesh.singh@amd.com>,
        John Allen <john.allen@amd.com>
Cc:     Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Marc Orr <marcorr@google.com>, Alper Gun <alpergun@google.com>,
        Peter Gonda <pgonda@google.com>, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220816193209.4057566-1-jackyli@google.com>
 <20220816193209.4057566-2-jackyli@google.com>
From:   Tom Lendacky <thomas.lendacky@amd.com>
In-Reply-To: <20220816193209.4057566-2-jackyli@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR04CA0105.namprd04.prod.outlook.com
 (2603:10b6:610:75::20) To DM4PR12MB5229.namprd12.prod.outlook.com
 (2603:10b6:5:398::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3a06a38d-212c-4b0b-4c6b-08da86d1dff7
X-MS-TrafficTypeDiagnostic: PH0PR12MB7012:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: o49dzCkefsc9OzPkBnpgPTijkcf8rx9q+FaqBaJeqWEUvXpj6uFrLBFNKdhWCF8HnSzT3Peyr9oDJZIo3xMRJhkgEMObcKVRytfMiO6UVUU+yyWxA5smun2649lAaVhEUmvXdm+XeYEyy7feF4Yihc5GXJEQy/rhwFHXf8S8dM7ILqbJCYSCLYNhlVcdTfzHSOa+NMMI7tPVJ4EfQUXSPRDd8FXg6ddfisvgK3yQRbtbrWb7E5i2BetL/uFLIfuF4uzhtNwVGnyvgjHmnbV24ZoJ0TQptx2fQVVE+6Ds69fW3zxREEB86+v0cWWPfya2iyY6JBoeLw+p4IvDK3PwDCkojG/KibF0VpfQ0T+zsfOvizng2wq6+z1ftd+Zt7Vg0//83qabnp4TUBvfMlUC0N4P0nYmqqiaA8j7v455MI/7jakpirMQWclCgTdpwrdgGPAmoLQUp2X1zLKTr8zHf+N2XN0LUMBNcnXXB0f/do8JrQ6X4YttS52lJWPbrH9hcg2xhE+CQVWPSZvA59c2b0aDjy8yhmYzgDPmpskclpvDaRtOpHSUEAs8VIU1cMpkxVYiAm40fuInyuBI+xqOZ53uYRJdjA+e3NcioNTk0mbWdBIeFhJN5LALQ5g2gsRUCMGhjxr157BLKoGtIDVCzzDOVFfNLOiCcRX5aAW/RghDCZka8wo/8zZOpIfQ80wZWC5K5QuNSQncU8CeWtcBq5WMyOGviJ9Xu5F3gJIPuRzGTJCR4HC5sodAgh7R6cWdxfRmZNA3mmswYLcpIwve9rUKKRKntxVkRNeoAPZ+DNE=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5229.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(346002)(366004)(39860400002)(136003)(376002)(396003)(8676002)(5660300002)(2616005)(4326008)(66476007)(66556008)(110136005)(66946007)(38100700002)(36756003)(31696002)(86362001)(31686004)(26005)(6666004)(6512007)(8936002)(41300700001)(6486002)(478600001)(6506007)(186003)(6636002)(54906003)(2906002)(316002)(53546011)(83380400001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZS9HYzRkN2hJMkQzb1FoN2VFVkJQQ2pXdnVONVVSUmNqTm9oUmVvRHliQnZ2?=
 =?utf-8?B?c1EwMExCQnlDZDZsSmNWU3FBaERUZTlOOGdTWnE3UjhzRU8wTnhYVmJZV1NQ?=
 =?utf-8?B?RWswUUJyN04rSG5ZSXUyd2g5bEYvdm1udU01UXpNdTlOK00yM3NqNzN4dTJu?=
 =?utf-8?B?NWZlaktheXMwTXVpU0FUR2tvRHpxMmxtcmk5ckdjcE5zLzE2QkpYbEYweFpy?=
 =?utf-8?B?cEVGSUw5Q2htQUlTaWNScXV2dGcrdEhsd3lXdzNxdTVpN2Fsd2h1VFFtZnEr?=
 =?utf-8?B?LytBaWwyd0pFTDNzZUhwdGFreVBNTjFRT2FNaDZneFZGcGJYbjM3b3FIbjgx?=
 =?utf-8?B?RFcvaEhFckR3MzJTYUY0VWw1R3ZySENQcStNOW0xbzVLaHBYVEdJVmx0N2Zu?=
 =?utf-8?B?YVZFQkVXMis0WXFsWlcvUHp3K2x1eThxUUdhaGZ4TjR0Qks2RDV2dWhXTW9N?=
 =?utf-8?B?Vi9sT1FPWjZKQ05GQmtCVDgycjVLazNPVngyRERrRzEyTldvRktjRnptUVRU?=
 =?utf-8?B?aEw1QjgvSzdQekdmVElRZ1c3OXYzS0g2bkJhVGRhdmxMR3ZPZFBHL0FSOFRS?=
 =?utf-8?B?c01rM1ZQUVU1dU02YTZPU3V4UUR6anhGb0xFRHJXYlhpY2gxQjdSa1JOREcy?=
 =?utf-8?B?ZjFSbmxmVFh5czdMWEZDblVNR2NjTWRyNmV2ck1FQjVnTUo1WFhuem5vSmFi?=
 =?utf-8?B?SlRWaHZ1TStBZzhKeHVwNlE1NU5aM1JwUlRkZ0FMNG5lenVRQmI5elpINlYx?=
 =?utf-8?B?NGZGcGMxNVQrQWNHY3phVHdXekRjd2xSVUs0b1lwdHN3QmJPQU9LWGkvMGFn?=
 =?utf-8?B?Nnhid2VQMnFpVWk2SVRzYTV0YXhWUmtlcVhETWxlMUJBTmFrQ2dOM3ZJWDhq?=
 =?utf-8?B?cnd5VGRZeVpyQXpFVzVhZmVVeDFlNlVpOS85dkpyUGtCczZSS0FLYmhTK2dq?=
 =?utf-8?B?eFQ4czdUa0pwME16LzlPOVd6T3JKYkRrQ20yUjdDVzBpNW9FM2xiMjRQWXQw?=
 =?utf-8?B?b2wzRnV4ZGtia1JnVHdjMGVDaTlSMEFYbWJiVkEzN2hWMUtNY3dvR0t2VTVu?=
 =?utf-8?B?SzBwUEtQRE1pZTNwT3Q0aDF6OWgvUVVndElzdis3eEZtTk9kQ29UTjFrM2Z2?=
 =?utf-8?B?U21MT1pZdE5aSzRCdS9ZeVA0c0s3ZmFHUDZLZzZnN1FCbHdtU0xZQzlGSU5G?=
 =?utf-8?B?bVpvZWtFQlVpYlZwOGdQaTNwMFQwK20yQXF1VFhmdDhzZUluY1JyOXJwa2dX?=
 =?utf-8?B?YU1FT3djQXpuM3RGeFRyTGk1azVucWVQN1dSQUJ0a3pLOFpoNXJjTE0xYzNs?=
 =?utf-8?B?ZHJwRmVGUXNMbEwwalNSeGZkb0NnMkFRL1N2M0JlL3Q2eW5sd1Zod1NjYkxP?=
 =?utf-8?B?ZDExR1VGQmgxSlAvcVZweTA3Rm05WVFrREZPMWVDUnNFUjl2NnRYTDJ4T0xx?=
 =?utf-8?B?aHpCZ0xhRDE5YXRZNndCc3NlV0d5bUR4OXQvU2FiNG5FSDlsNllUalc0d3Zp?=
 =?utf-8?B?cVFuK2l2ajZLYkNqN2ZuZEUyV1N1bHYzbHY1YkxtZmZab01GS1QyUENDRGdu?=
 =?utf-8?B?R2Z4RFFQQU5rUVduSVdicHNoQXFoSFVOdW4zclFZSEkxZVFMcGV3Z3U0VjNz?=
 =?utf-8?B?Z3dqcmpxUy9JdnllaDQwUzViQ0w0VjFmaG9mTUc4UzFGN3hSSDdVN2pGb2V1?=
 =?utf-8?B?UnVudjcvQmVTTHZCQTgya2NxUTZPSzk5MlVLNUVhQlE3bWdwZXBnM3ppUWRV?=
 =?utf-8?B?a1B0dWdHaDdvWVNzUFBkZm9KSkpISFFMbFRkejdkUmRHWkI4V25sTEx0Zjda?=
 =?utf-8?B?bnBGVHVSOFpLbkVFbVVZeC9pZ2V6ZnlhTjcrV0JvT04xWThzT25od3MyQlVR?=
 =?utf-8?B?QkJVSEdPYkk5eXo4VFdMdHJzRFl4TFhJZE00NVFERnVodWJnY29LeWdLdWth?=
 =?utf-8?B?TVBpblZPWGE5a3lYR1BWTWRJci9hYzYzQkJYbkUzZ3NaeEVVSXhTWk9iUjJz?=
 =?utf-8?B?bnhneXQ3czdFOERia25wUW1kWm9pY2hvQzhJRlNXemJLNGV0Zkczb2hzTkxQ?=
 =?utf-8?B?MWtCNzl3MEhLb2RTRWJXVDFMSlpuWi90ZXBlNkRBSm9heHFIbjd2S0FRa3Fy?=
 =?utf-8?Q?s7vs6avQEdPlGxj3D5tGsg+O+?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a06a38d-212c-4b0b-4c6b-08da86d1dff7
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5229.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2022 19:41:59.1565
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Y/02IqixQZLUJmNlt4X73AOSidNxKql23rNs5CutcDuRgTOZ7pFRz4HsZEC6ny8w6d23+VNav80QBqjPhM5Sdw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7012
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/16/22 14:32, Jacky Li wrote:
> Currently the OS fails the PSP initialization when the file specified at
> 'init_ex_path' does not exist or has invalid content. However the SEV
> spec just requires users to allocate 32KB of 0xFF in the file, which can
> be taken care of by the OS easily.
> 
> To improve the robustness during the PSP init, leverage the retry
> mechanism and continue the init process:
> 
> Before the first INIT_EX call, if the content is invalid or missing,
> continue the process by feeding those contents into PSP instead of
> aborting. PSP will then override it with 32KB 0xFF and return
> SEV_RET_SECURE_DATA_INVALID status code. In the second INIT_EX call,
> this 32KB 0xFF content will then be fed and PSP will write the valid
> data to the file.
> 
> In order to do this, sev_read_init_ex_file should only be called once
> for the first INIT_EX call. Calling it again for the second INIT_EX call
> will cause the invalid file content overwriting the valid 32KB 0xFF data
> provided by PSP in the first INIT_EX call.
> 
> Co-developed-by: Peter Gonda <pgonda@google.com>
> Signed-off-by: Peter Gonda <pgonda@google.com>
> Signed-off-by: Jacky Li <jackyli@google.com>
> Reported-by: Alper Gun <alpergun@google.com>
> ---
> Changelog since v1:
> - Add the message to indicate the possible file creation.
> - Return 0 when the file does not exist in sev_read_init_ex_file().
> - Move sev_read_init_ex_file() before the first call to INIT_EX.
> - Rephrase the last paragraph of the commit message.
> 
>   .../virt/kvm/x86/amd-memory-encryption.rst    |  5 ++-
>   drivers/crypto/ccp/sev-dev.c                  | 36 +++++++++++--------
>   2 files changed, 24 insertions(+), 17 deletions(-)
> 
> diff --git a/Documentation/virt/kvm/x86/amd-memory-encryption.rst b/Documentation/virt/kvm/x86/amd-memory-encryption.rst
> index 2d307811978c..935aaeb97fe6 100644
> --- a/Documentation/virt/kvm/x86/amd-memory-encryption.rst
> +++ b/Documentation/virt/kvm/x86/amd-memory-encryption.rst
> @@ -89,9 +89,8 @@ context. In a typical workflow, this command should be the first command issued.
>   
>   The firmware can be initialized either by using its own non-volatile storage or
>   the OS can manage the NV storage for the firmware using the module parameter
> -``init_ex_path``. The file specified by ``init_ex_path`` must exist. To create
> -a new NV storage file allocate the file with 32KB bytes of 0xFF as required by
> -the SEV spec.
> +``init_ex_path``. If the file specified by ``init_ex_path`` does not exist or
> +is invalid, the OS will create or override the file with output from PSP.
>   
>   Returns: 0 on success, -negative on error
>   
> diff --git a/drivers/crypto/ccp/sev-dev.c b/drivers/crypto/ccp/sev-dev.c
> index 9f588c9728f8..fb7ca45a2f0d 100644
> --- a/drivers/crypto/ccp/sev-dev.c
> +++ b/drivers/crypto/ccp/sev-dev.c
> @@ -211,18 +211,24 @@ static int sev_read_init_ex_file(void)
>   	if (IS_ERR(fp)) {
>   		int ret = PTR_ERR(fp);
>   
> -		dev_err(sev->dev,
> -			"SEV: could not open %s for read, error %d\n",
> -			init_ex_path, ret);
> +		if (ret == -ENOENT) {
> +			dev_info(sev->dev,
> +				"SEV: %s does not exist and will be created later.\n",
> +				init_ex_path);
> +			ret = 0;
> +		} else {
> +			dev_err(sev->dev,
> +				"SEV: could not open %s for read, error %d\n",
> +				init_ex_path, ret);
> +		}
>   		return ret;
>   	}
>   
>   	nread = kernel_read(fp, sev_init_ex_buffer, NV_LENGTH, NULL);
>   	if (nread != NV_LENGTH) {
> -		dev_err(sev->dev,
> -			"SEV: failed to read %u bytes to non volatile memory area, ret %ld\n",
> +		dev_info(sev->dev,
> +			"SEV: could not read %u bytes to non volatile memory area, ret %ld\n",
>   			NV_LENGTH, nread);
> -		return -EIO;
>   	}
>   
>   	dev_dbg(sev->dev, "SEV: read %ld bytes from NV file\n", nread);
> @@ -410,17 +416,12 @@ static int __sev_init_locked(int *error)
>   static int __sev_init_ex_locked(int *error)
>   {
>   	struct sev_data_init_ex data;
> -	int ret;
>   
>   	memset(&data, 0, sizeof(data));
>   	data.length = sizeof(data);
>   	data.nv_address = __psp_pa(sev_init_ex_buffer);
>   	data.nv_len = NV_LENGTH;
>   
> -	ret = sev_read_init_ex_file();
> -	if (ret)
> -		return ret;
> -
>   	if (sev_es_tmr) {
>   		/*
>   		 * Do not include the encryption mask on the physical
> @@ -439,7 +440,7 @@ static int __sev_platform_init_locked(int *error)
>   {
>   	struct psp_device *psp = psp_master;
>   	struct sev_device *sev;
> -	int rc, psp_ret = -1;
> +	int rc = 0, psp_ret = -1;

This change doesn't look necessary, but not worth having you submit a v3.

Acked-by: Tom Lendacky <thomas.lendacky@amd.com>

>   	int (*init_function)(int *error);
>   
>   	if (!psp || !psp->sev_data)
> @@ -450,8 +451,15 @@ static int __sev_platform_init_locked(int *error)
>   	if (sev->state == SEV_STATE_INIT)
>   		return 0;
>   
> -	init_function = sev_init_ex_buffer ? __sev_init_ex_locked :
> -			__sev_init_locked;
> +	if (sev_init_ex_buffer) {
> +		init_function = __sev_init_ex_locked;
> +		rc = sev_read_init_ex_file();
> +		if (rc)
> +			return rc;
> +	} else {
> +		init_function = __sev_init_locked;
> +	}
> +
>   	rc = init_function(&psp_ret);
>   	if (rc && psp_ret == SEV_RET_SECURE_DATA_INVALID) {
>   		/*
