Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65DFE58F396
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Aug 2022 22:37:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233392AbiHJUhe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Aug 2022 16:37:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232579AbiHJUha (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Aug 2022 16:37:30 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2074.outbound.protection.outlook.com [40.107.93.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E593E67151;
        Wed, 10 Aug 2022 13:37:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bpH85MzNV2pGL5T6v17YM+c105/kO25TEe3knqs/b0FlLwuJzOe9FSwH3QoAb5m5bunct66ZrU/kQRH/00HI8szOR0YRGTUXBS+goPRwUvPlavS+p+/jfsutXjJuKH4KasRXklomd8jktkK3kiUYA+dwotuCCc3BgKHCh96BYz63Y78VkeWWonMxExUILiEGB+I10hUdWSrnG4rUKGnUgtoGHsnnGpfn7AUQ3BmR7Yoezp5TBseGxAE8jnbZ0ygFoXCxcLly9cIBG6cU6OISr4BNLYFuAm6Yh+QaFIiqfgXmLiReeXocoImnf2Ltv18DnfZ4kqUXZY4JhTNHaYp8QQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0luXxKcaKNYrBJ9Te7ktrAH7T5eK6RWJscfv/fgQdeM=;
 b=dVoswaob2iNSxNR0/9bU1jxgOt6XV5QKIRBMLWiPmNYtcBRpGEx8Dm/sImzmuXUpKCzzaoSAef+IqJO5FFIBjgtkqANW0iWMwII4EcPcmRLDryJsAuD3i9bNhqtAVzcBVWoYyF5AYe+qqPlsE4bUuRNnzoQQLZ9iE5BadTsZLDBscNSB8PFVcI3ww4s3PRqvFmef7iPe1Yje7q/xEqNqwGMmpew4sXRAhIgppuh8q95GbXzWuUE0X7bw19nkClN4okGWNRvqzI2z22y/BZlGVn+ZjKC2OMfvFDP5uxy8kMEA7qpPRhIjqfMb5YTzqfqm1eKHUwupbm6bP/4N91Ceng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0luXxKcaKNYrBJ9Te7ktrAH7T5eK6RWJscfv/fgQdeM=;
 b=jtpbF7CefRK1DothAqhGSS7BRxqvxx8zp6VX6/F7mUFBPKihbuXvkBOgkH2y1suvwmfxwPVZU9REDRLru9azVBRqG5Z2h7aX3GXem6IKtzA/8EfseyO/4YS2FGbeWuz1HRKvI1MCTgbJUEhzPVjQ+3sdgIRvC023zwj+KoinTa8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5221.namprd12.prod.outlook.com (2603:10b6:208:30b::9)
 by CY4PR1201MB0006.namprd12.prod.outlook.com (2603:10b6:903:d3::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.16; Wed, 10 Aug
 2022 20:37:27 +0000
Received: from BL1PR12MB5221.namprd12.prod.outlook.com
 ([fe80::219f:8080:9607:b847]) by BL1PR12MB5221.namprd12.prod.outlook.com
 ([fe80::219f:8080:9607:b847%7]) with mapi id 15.20.5525.010; Wed, 10 Aug 2022
 20:37:27 +0000
Message-ID: <5f52ffe6-03a4-a5bf-9c57-2c3951922a35@amd.com>
Date:   Wed, 10 Aug 2022 15:37:25 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 2/2] crypto: ccp - Fail the PSP initialization when
 writing psp data file failed
Content-Language: en-US
To:     Jacky Li <jackyli@google.com>,
        Brijesh Singh <brijesh.singh@amd.com>,
        John Allen <john.allen@amd.com>
Cc:     Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Marc Orr <marcorr@google.com>, Alper Gun <alpergun@google.com>,
        Peter Gonda <pgonda@google.com>, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220802185534.735338-1-jackyli@google.com>
 <20220802185534.735338-3-jackyli@google.com>
From:   Tom Lendacky <thomas.lendacky@amd.com>
In-Reply-To: <20220802185534.735338-3-jackyli@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DM6PR07CA0108.namprd07.prod.outlook.com
 (2603:10b6:5:330::14) To BL1PR12MB5221.namprd12.prod.outlook.com
 (2603:10b6:208:30b::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 56de8714-7976-4a16-4772-08da7b1023a9
X-MS-TrafficTypeDiagnostic: CY4PR1201MB0006:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vVXRlb0SnS6sgxy8PNPrSjaPJUm4SDLcuQzwxIM/aQkprgZm0vGgDHzewV6olr8ae2fbZXP24xyp/r5eIg+hBcS6eTBJ0xGPcPZTgwD6KiH+Fm0V/r4+tRftJbB0aUGmeZ6/PU3S0fMRkK1WCVOKveKa7FrOsUeQyWR9XFSxD/rv6lj6jqqCckZ8YQjD9pCU0XkB1xegg5ZRO8LvrkLE19w3wzqhVR1D4BS6f7rbSLSIqe58xk6GTAURr/s5p0AVmcvMDP47d87WILs8pOKRlUPU0VzvfdsGLimRpbU7adzD8OsoyJ+xHaB2QqmiQNLHwa5mMgDn/SYZvzyXNbWYxFM1FDUl48e8inHTkFKBzAu0vGPkVwCc4ogAMTL4YSIEqEGJ0FTtfWvQ2jCF6HGNbfy+QgNT2EcGfzOVlgIoNSyEB38zMNUsgIGwV9MnKSfqYPkd3h02x5vKke8LWo/RHqZXVikRo0iX10Pv4QjymkZdsFvvONYdlgjeGPdC3Co0rgyobiqDrGuwD8M/VzcoDAk0RKqwSV0NKEWtk4iV/MmF0jwtTvIjrlqb/aN03SBRymXcqfwlfsSawczjvUtYTPOxIFLGfXjnNavOW7/vmWpNP5S26e+5SPUKD5tttFemNH+TCSG1cxCAnoBCBRzojnmLMa/FT3h/Ll5Bjk4MBgpLA5Cwx31druILb/nBe/lOhwZ1ZDWX5K80M6lbNUigyvw7uiOgecbGJQ5yAnX/G6zzn90yJl3MbigOLcYnxm4Wf6f8rIRi71TBHGH/pObVgIi0Old+kdPrioVuaxhxZLd1EVnX7mTkgVvomp89+ehwWWrhMV+H/+/1mNVcs5BpAg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5221.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(376002)(346002)(366004)(136003)(39860400002)(396003)(36756003)(26005)(83380400001)(31686004)(6512007)(4326008)(2616005)(186003)(6636002)(86362001)(53546011)(41300700001)(110136005)(2906002)(316002)(66556008)(66476007)(38100700002)(6486002)(6506007)(5660300002)(31696002)(66946007)(54906003)(8676002)(8936002)(478600001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cGFPSytic0JGNDU3VjRJN0dsN3hsMGt0dHBpb3RhcHlMZnVTSU9MZmNaYUJx?=
 =?utf-8?B?Zi9IellMWkdkVGN6cXV3clpGUEd2eVg2SUl6YjgrTlVXaTFNN3ZNS2JHUHRE?=
 =?utf-8?B?UVNwWlZMWm52bDg0Qk9panM0VWxWR1pqVmdYWDNQNVdhZFh1bi9RejlweGVO?=
 =?utf-8?B?bStuUVBmejhYZFJYMXBDajMrd0lBSlVHaENwWk1NRUVUQkVBZnRmdXpXQnpk?=
 =?utf-8?B?RUpFelFVWXhBSk1Nb29QaEZtUkU2RWpRWDNDNE5rYTl2bEtOQlAvYkhuSFRI?=
 =?utf-8?B?MTVJc3NIZncyWXBwQnkzYUZjZUo5Z2VyeDYyUmRUR0VRTmZDNDJXSDl4bjVq?=
 =?utf-8?B?OWowZ1FlUDFETW5kTWxxeU9zeXJaSWtra2NXOVJleFF2dW5IVURNTms0dVVQ?=
 =?utf-8?B?cjAyZzBSOVpaYWViWXNuUS9xWnZVcEo5SE9ad1RwNnhiRVR2b3dnaFUzSnhs?=
 =?utf-8?B?QnU4M1FaY21JS2RnNGpWSTRhc09JZlp1dTVjeVJybk5XMlNVZ3lrcFVHRno2?=
 =?utf-8?B?VEZ4b2ZaZ0s0YTQ1QVdJZDBYaks2STBNclhsbE5vVnBqbThEQUFPUXNFRXNF?=
 =?utf-8?B?dEplMk1WdHdyVjB0cUZ1Qk9lZlNyQkMxNHIwV1dyMllnVEk0NWV4NWIzSVl3?=
 =?utf-8?B?N1ZrZFdmUXNUSkNwWTROQTdmd3BFNHZydlBPYlNnUWo3NFYrd0ZEOVRZdjRW?=
 =?utf-8?B?RENwd3RXSmM2OVgyaGtiTDRVQXhYUkVsVkdvSm9EVVBldGR1ekljVHZFdVNP?=
 =?utf-8?B?Q0ROYTJ3ZTQ2dE03WkdVaGpuQXR1ZGppdGFsQ2FxUjhETldFL3JBV1dTUlpY?=
 =?utf-8?B?NW1aVHAxbU0zaTNYWll4VU1MV1RWcVNoZ0dpNDJlUmk2dURIbGtCbUVMenFY?=
 =?utf-8?B?dXhseG5GZ2xMMVd5N2c0WXp0K1YxTXlyRmJRazEyblBlOUxvd3RuZDFBUWVx?=
 =?utf-8?B?R0xYOFFvd3hqblFIME8rS1YySldPZCtGRWQydGFCdTRYbkFhQ281UDl1cG9F?=
 =?utf-8?B?eFRHbE14NkxNVTVPSWRNWUsvVXE2UWtrVjVoelNxOUgvWGtBSk9Sa29WeXB1?=
 =?utf-8?B?d3NESmU2QzB5TTJnMTF5S2Zkc1RJZi8xRWhUbmRLU09OYVl0S0d2a25XM3hI?=
 =?utf-8?B?dmpsSjRXMWhaZXhjRlNCdFNrTWNYaG5TWTRSSmw4RnRCOU9PSnZESXZnOHp4?=
 =?utf-8?B?NzJSZzU1SjdjV0ZqcU4wTnBiZHR0a0plS0RpRlAzckpCcHRzRFhCdVVvVFlI?=
 =?utf-8?B?dmNiTTBYeHNSbDVldStXOEVqcW1pVGtnSkVXQmM5QjNqM0xRSVRya3lUaGdu?=
 =?utf-8?B?RzJPMkdvd0ZySzlEQURSdnR4WWNoVlFvUmJQRGxqcVMrMThkaDAyZG1ZUGI5?=
 =?utf-8?B?V3E1RHJ2MytHNTl4V0hFMllRQUliWVZyMStDblZ2V3RrV1A3bkUzTTF3Wnd0?=
 =?utf-8?B?TWd0RUUzTWJDMEl3bm1RcEdTSHhyMk9DR3IvS25HK1N2bWRZcUJQRk5vNkZP?=
 =?utf-8?B?SlcxTGdXYWhETWVweHgvdVN0a2EzbDdpT0YyalJaZjhJZXl0SEttYkcvZU9Z?=
 =?utf-8?B?NGRFdjNCZ1hvV0lZVFZnSlNRRHc1TEJkN0RzaWlhbHRVRDZ4WkJKMlIyQkZa?=
 =?utf-8?B?WlRieWxiQUd1UlU1Ti9SU1g4ellxYU55cFVlUmlaWGV2OUpIWG1RQTZRUlpO?=
 =?utf-8?B?Z2hBODY1ZDlMbHZLeWgydzVXMGtWc1VUcGF4MmpjQTVTOTdhWnYwcHVGeGZx?=
 =?utf-8?B?TmdUVVNWSFZuczY4dGVTWVJiMHgvZXBSU3pKUkMxSnZpV2t5NW1JMVNQMXZQ?=
 =?utf-8?B?VkRSL21CTVBlTnNTY3pqMHdocXN4Z2VxRG5tSDl4SC9CWWdJN2h2c1hReUdz?=
 =?utf-8?B?MEFDclh0ODFZRm9qUlZPOGhwTk03eXZEbm5JOWdYVHJkMndPam1zZmliYmVp?=
 =?utf-8?B?blkxS1ZucEtXZUFPdFBwNFNIeHF4cWNxZ0UydXcwN0R0UDFyRi9qMzk2UTd1?=
 =?utf-8?B?SnZtQkNWNEp1cGdZME11MTlIOFduKzY5b3pYRFZnWEs4T3BLUXErb0E5Szkv?=
 =?utf-8?B?cXdINVE4bW45MjVYVzZ2aUE1UE1rdVYrZnc1TDI3bXZhYnF3Sm4rMkcrUnRx?=
 =?utf-8?Q?vDSl2+Hkn+rBtDYSpAxMt8RnM?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 56de8714-7976-4a16-4772-08da7b1023a9
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5221.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Aug 2022 20:37:27.5911
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4VeStcw3MfUx4QqiadC31zOxWR2jh+XWGiZLB4MFpcj7JVH668gc1k5mQnm6N7LSIe8JSt6mEIX+jVnebTGyJg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR1201MB0006
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/2/22 13:55, Jacky Li wrote:
> Currently the OS continues the PSP initialization when there is a write
> failure to the init_ex_file. Therefore, the userspace would be told that
> SEV is properly INIT'd even though the psp data file is not updated.
> This is problematic because later when asked for the SEV data, the OS
> won't be able to provide it.
> 
> Fixes: 3d725965f836 ("crypto: ccp - Add SEV_INIT_EX support")
> Reported-by: Peter Gonda <pgonda@google.com>
> Signed-off-by: Jacky Li <jackyli@google.com>
> ---
>   drivers/crypto/ccp/sev-dev.c | 23 +++++++++++++----------
>   1 file changed, 13 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/crypto/ccp/sev-dev.c b/drivers/crypto/ccp/sev-dev.c
> index 5bb2ae250d38..fd6bb01eb198 100644
> --- a/drivers/crypto/ccp/sev-dev.c
> +++ b/drivers/crypto/ccp/sev-dev.c
> @@ -233,7 +233,7 @@ static int sev_read_init_ex_file(void)
>   	return 0;
>   }
>   
> -static void sev_write_init_ex_file(void)
> +static int sev_write_init_ex_file(void)
>   {
>   	struct sev_device *sev = psp_master->sev_data;
>   	struct file *fp;
> @@ -243,14 +243,15 @@ static void sev_write_init_ex_file(void)
>   	lockdep_assert_held(&sev_cmd_mutex);
>   
>   	if (!sev_init_ex_buffer)
> -		return;
> +		return 0;
>   
>   	fp = open_file_as_root(init_ex_path, O_CREAT | O_WRONLY, 0600);
>   	if (IS_ERR(fp)) {
> +		int ret = PTR_ERR(fp);

Please put a blank line after the variable declaration.

>   		dev_err(sev->dev,
>   			"SEV: could not open file for write, error %ld\n",
> -			PTR_ERR(fp));
> -		return;
> +			ret);

You'll need to fix the kernel test robot report here.

Thanks,
Tom

> +		return ret;
>   	}
>   
>   	nwrite = kernel_write(fp, sev_init_ex_buffer, NV_LENGTH, &offset);
> @@ -261,18 +262,20 @@ static void sev_write_init_ex_file(void)
>   		dev_err(sev->dev,
>   			"SEV: failed to write %u bytes to non volatile memory area, ret %ld\n",
>   			NV_LENGTH, nwrite);
> -		return;
> +		return -EIO;
>   	}
>   
>   	dev_dbg(sev->dev, "SEV: write successful to NV file\n");
> +
> +	return 0;
>   }
>   
> -static void sev_write_init_ex_file_if_required(int cmd_id)
> +static int sev_write_init_ex_file_if_required(int cmd_id)
>   {
>   	lockdep_assert_held(&sev_cmd_mutex);
>   
>   	if (!sev_init_ex_buffer)
> -		return;
> +		return 0;
>   
>   	/*
>   	 * Only a few platform commands modify the SPI/NV area, but none of the
> @@ -287,10 +290,10 @@ static void sev_write_init_ex_file_if_required(int cmd_id)
>   	case SEV_CMD_PEK_GEN:
>   		break;
>   	default:
> -		return;
> +		return 0;
>   	}
>   
> -	sev_write_init_ex_file();
> +	return sev_write_init_ex_file();
>   }
>   
>   static int __sev_do_cmd_locked(int cmd, void *data, int *psp_ret)
> @@ -363,7 +366,7 @@ static int __sev_do_cmd_locked(int cmd, void *data, int *psp_ret)
>   			cmd, reg & PSP_CMDRESP_ERR_MASK);
>   		ret = -EIO;
>   	} else {
> -		sev_write_init_ex_file_if_required(cmd);
> +		ret = sev_write_init_ex_file_if_required(cmd);
>   	}
>   
>   	print_hex_dump_debug("(out): ", DUMP_PREFIX_OFFSET, 16, 2, data,
