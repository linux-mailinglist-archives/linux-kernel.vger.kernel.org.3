Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E1065A19BA
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Aug 2022 21:42:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243706AbiHYTmp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Aug 2022 15:42:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230418AbiHYTmn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 15:42:43 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2054.outbound.protection.outlook.com [40.107.92.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE4D6B1BB6;
        Thu, 25 Aug 2022 12:42:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NKl4UFOky49QiwNGlHs7W6CYRYd03Fu/fXD9DU3Lfy2xoKyr3z2VEF5JbO3/XPMDRZWSIzjURy1jYy5v+VbBMSZoCpbQ0Zw6cltBfXoiStFBiIH4sGG8nWGMFk28ySO4P4HAcb0LjyVI9+mwpDXsexT9fh5CTLB6XQi+mzedOlJleiB5+TYqfBjlP/zAfuZ3t+qPs5ua3tgSwguk/RSTLWOfLVkbDcSG3mMcncIp351cr8rFAfCpUzHA5RCAhZD6l5H4LWCmsXQd0XnX+RACZw33GD0htlkIYFBpcs9zOlOwyoOXdJjmQ2AMqxOFmN1aTG9s15gUrl1uZ7eEC8o7nQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YzFRQbZOf11OJZMVpcsogGh6o+cQsTxyIoO4m9dvT2A=;
 b=iNG+3thHeqLty1Hs8E0GWYeiM5J/OT55AEFSeEE95waduPHsict4+MhZijvsTaKLSupwUISvrO4xQjH1nHiTW8zu/xp8oA2DHn3TUxCtcAlOVbAyzKgXtIcztalBez4gwK3vOEHYtfJit0XuCO4RUHVoQyWEFrv//eiq2N3lQ45EXCSbxLZl9cDUsgPGxrLcTAkD0Sib5uJHdSS21EVuJp6U4iPrxvjQw7B4wndLjpE55RVw+MU+PyHlDjHA4vV32IZTySRfhS/m4pR1wWoRt4mtyS+aQzJEZgRdCkG4IP/ezSiaX8AacpLuabJTqbBqfMGZI0+bGjrCYSFUMorgRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YzFRQbZOf11OJZMVpcsogGh6o+cQsTxyIoO4m9dvT2A=;
 b=nz7YCA+YXCd32Gzfo7zFRnHXcgSMCsvs/whY1/Aijv7lxlSuwTgdoiV3FvgzUpcTfd9OQmsUc6FpDUcd5mPtA9fdxrH9dcGPDSH3/uMCSlZ4ZJ/3mYpZVnNLwWJddR6Sk4DSxB1ZSD/BEPZis/YYQaSZisMk7apVtNHbvacZYgk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5229.namprd12.prod.outlook.com (2603:10b6:5:398::12)
 by PH7PR12MB6717.namprd12.prod.outlook.com (2603:10b6:510:1b0::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.15; Thu, 25 Aug
 2022 19:42:39 +0000
Received: from DM4PR12MB5229.namprd12.prod.outlook.com
 ([fe80::c175:4c:c0d:1396]) by DM4PR12MB5229.namprd12.prod.outlook.com
 ([fe80::c175:4c:c0d:1396%4]) with mapi id 15.20.5566.015; Thu, 25 Aug 2022
 19:42:39 +0000
Message-ID: <154049f7-a021-b1af-cc74-92d3c27a6729@amd.com>
Date:   Thu, 25 Aug 2022 14:42:37 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v2 2/2] crypto: ccp - Fail the PSP initialization when
 writing psp data file failed
Content-Language: en-US
To:     Jacky Li <jackyli@google.com>,
        Brijesh Singh <brijesh.singh@amd.com>,
        John Allen <john.allen@amd.com>
Cc:     Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Marc Orr <marcorr@google.com>, Alper Gun <alpergun@google.com>,
        Peter Gonda <pgonda@google.com>, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel test robot <lkp@intel.com>
References: <20220816193209.4057566-1-jackyli@google.com>
 <20220816193209.4057566-3-jackyli@google.com>
From:   Tom Lendacky <thomas.lendacky@amd.com>
In-Reply-To: <20220816193209.4057566-3-jackyli@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR04CA0096.namprd04.prod.outlook.com
 (2603:10b6:610:75::11) To DM4PR12MB5229.namprd12.prod.outlook.com
 (2603:10b6:5:398::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9a9d2b9e-6e2f-4b1a-80bc-08da86d1f7c7
X-MS-TrafficTypeDiagnostic: PH7PR12MB6717:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: P4lksrOaOaXB/AxSVHncgrRPxpi1OpA8lnKnm84gfcH1PUazYedBe77AlXYz4wPHIHmnyzrg8TNxtHxDvpDblBo9XOTJwIsh/BpmBXG2ES9W7igFRRGjOg1WHwvOdn3AxTfCQnRxm/TO0vgpHq0ZoTGzpxy95n1ABYEYldX66u3N6uN9wxurYPpoR6MfvI/eKFpe6TT5bIJRPO/fn5oqTRnicxRX/TtIgihaps7m+jxI6pykO/H/SbdH65QS3qLhsdeGdd/TpjFX0IzBqsokFpuhvNij46hqbgY416F7n85r2pNv2KEU3+8MOo3ktVUdTgtEMWSMDUUJSsyJtPneXDCMmwxzrfAa2kG0tIp2GwrDyF9kd7mXtm9ThE8HRHh7+pbWQAwvFkB9W73rjya4ikTa1m4+yAHFZCz577EmWd6EnOr9kQS92rihkkHmDgIoTwOoKKEtsmqUIFkmwhyfo8s+glqy4y0rqwtTG98kE4bYRUST3DdVUpeFpi9m0Flec9Pz6g015PIMMYJ6Ps6y+JUOM9DD0usegS0k5m55dzmACDxaoabZsmXgyc1HiT4W04FcbKNH2ictlkYljG0eXCKFgxrTuoJ8mPZgKq78vNmGK6Y0vJ35I/tltniIPdsW1VJunoQp1zrAocDkNCB1F7+CVRbUcNrWvAIAcfb/jECKol4ufcVFzsj1RJndM6uZFwwKqCIJiSIGp2YsyQ/0ZfVrVIptF7Moex1Glrmv3FNAQ7g0xwnciDsHqq94EDJw2s6GrgftBhktWgs/COpoQaeWDuZGY+oRovcS3oYYIZk=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5229.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(39860400002)(376002)(366004)(346002)(136003)(396003)(5660300002)(86362001)(8936002)(2616005)(6486002)(478600001)(31696002)(6506007)(26005)(2906002)(83380400001)(6512007)(186003)(41300700001)(53546011)(38100700002)(36756003)(54906003)(31686004)(6636002)(110136005)(66476007)(66556008)(316002)(66946007)(4326008)(8676002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TmZkZzRiNCsxRW5KMDhRdXhuMXV1b3h4WXd4VnZnWlhPMWpRNFF6UHNEYW43?=
 =?utf-8?B?bVJMTlBxTy9VR1JXMGFEM3VpdThCVkNKOWhGdG44RXdLeTQxQXhTVmNFcG8z?=
 =?utf-8?B?NWh5NE5GeitmVCtLVnFLcjFlQmtGcEwxQzJnUGlRNllPVjV4cGlsRjY5dUFt?=
 =?utf-8?B?UUIyZ3dMQ2xjWkpKVC8yNjd6TWFBUnhIb3cxVTVzVmdKelFkTC9zSVBQeUQ1?=
 =?utf-8?B?OTZBY2xxd05VeUtFS1JOc0hqcVhzMXZLTmFVckhOWWRFVGd4eTVaQy9yUkRJ?=
 =?utf-8?B?MUlZbUhPWW9RN1NVMURJWlhhL3cxdVFwVk94bHh1OW90YUplL29hOTVLdEhS?=
 =?utf-8?B?VE1veVd1cjZFaUF0YVVPcGVtaVRHdnFZV1FnanF3TEJ4cDVVQ2NBbHpxZ25V?=
 =?utf-8?B?TFlteTNRRjdMYXNGZ3MweWU3aG9mN2tVMmU5M3JHdUZWUUkyUUh1bnR2eEI4?=
 =?utf-8?B?bU0vOERrVlFlWTBaWk80WEpSUlJnYnB2ZHRnSEdnUGpselFNc2xRNUE5UTVI?=
 =?utf-8?B?dXUycUhUNnFlK1QxOUFXNUVvUlRyUGRmanZqTmhnU3hyNTEzcWhvbkU3MlBO?=
 =?utf-8?B?anF2QzROYk1KUXBZaFpPcXZSNXVTSlFXdjYxckpDWnZlWmpMMzBkaStMVlp1?=
 =?utf-8?B?cUlxTllqZDA2YS9BQjBBZWVnZm1tZ3BBWERqVFBjKzJ0bnhFNXBCdmU4d3ZX?=
 =?utf-8?B?YWZ5TW8vQm52cFg0TzJTYU90aTBEMlg0WmMraWFYN01aVUdVbTFmMTY3ZUV2?=
 =?utf-8?B?cE5tbWhmMGRBRHh2RTVTaHlKSnBEc1k5UjAzYkRobE9CS2FrTmpma1R0ZlVW?=
 =?utf-8?B?a2E2NGZ1NGJVYjRsQ1ZUK1l3Sk1mczdKb3ovT1MvWWd1aDQzNndEeWlGbTls?=
 =?utf-8?B?cmdoclEyVHVPYUExQTBCNllRck8xRkFkR2YxUTZVcFBxcDhhZjV3Y1laQmxE?=
 =?utf-8?B?UVVxK3R1TDA1d1lrcGdKOUt3Nnh3NEM4ajh0ZDJLKzhFTzBabWtObUNvbXZU?=
 =?utf-8?B?UDQ2WXM3QlREYXpyY3haL0R6d2FNanl2cmNYNUppQkdWeEZOWVN0Z1E1M3I5?=
 =?utf-8?B?ZkFhT1B6NU8xa0JyZTZ0V2NBYlRSTzl0UWdEN1V5WDU5MVB0NGdGcUZ4T0xz?=
 =?utf-8?B?M2N5bzQzcnd3UGFvZnhTT2R2ZkNiZzFIMkV2ZXY3WFVranNaSEEzeEl1TUF3?=
 =?utf-8?B?WHNZODRzUjdKdnVnWkdoN2hyYXJiL1MrVFhqa1o2UWJ1VDRBU1M0Z0tkYkRZ?=
 =?utf-8?B?bGlSS3dyeXBSOTVFZmFoQ1JRWk9VcW1GK0t4Vml6Vy9QcEc2bkZkbjBTYjYw?=
 =?utf-8?B?S3lFT082YmRaTnRaR21vWHROZTBpNFBTQ01zL280aUVMMWhkbERUQWEwZTNT?=
 =?utf-8?B?VC9sZmJwd0xyNloxeVNLZWtHNlU5WThUMDFVRklkVWVLVkNEMStpZWlVZTJj?=
 =?utf-8?B?S3NFQmtzblRpUzUybHZzZFkyVFVCd0kzQjdaRms0TEhxN1A3enhQazRQbzJw?=
 =?utf-8?B?UzhaRGhkNXU4cGM1MWNnYW9rZWV5RUZ3S3hiaGowTmE5YlYzTHJCVHdFV2E5?=
 =?utf-8?B?UGpWWUU1aUVrcXpMUXhsUGd3SmkvY2dMa1Uwbnl2RFNHcitWaitKVmh4T0gy?=
 =?utf-8?B?MENJK3g1L2ZiT2ZWZzQrVk03SVlHd1pkT1dXWkFxVWczRzRadDVpc3IzVkUv?=
 =?utf-8?B?WWpPUFBCZ1B6NCtMQ2lteDRBeXR5WnhNUERIZ0c3c0xwY0E4RkRpTjVyWmpl?=
 =?utf-8?B?OWU1eGV1TUNIT3VaMllOMGdwQ2NZRXgrTFNLaFF2TjFOZnYzZWFLeVlmRDlT?=
 =?utf-8?B?SXhPVi9Vb2xvNmF1QytzbkwwTUhBMCtxcUE2UWx2UFZ3alFPNDRkWXVNNDEx?=
 =?utf-8?B?Q0FKVi9sZ0FrRkE0U0l0Mng5bnlRWEkvaUNPTGFSR3ZrRFpPaWlQeWJURWVN?=
 =?utf-8?B?ejhaMUhJQm4xSERyaWcwVE1IOWpvd1lMWkFPQXBwTUxvdkEvSUVZVlh5OWFo?=
 =?utf-8?B?WW9XVXByY1hSL2gxYk04WXl3dzdwT3pQZWhNbXVtamxJSDRWQlB4MmpQSGtp?=
 =?utf-8?B?dGhFKzBrRUN2aGJmS0FjQkFWaldzeGZaZmdkS1NHTVlOYzRqLzYveWFKa1gv?=
 =?utf-8?Q?V4NdZI9diMZrU6VPzUWqeCW5k?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a9d2b9e-6e2f-4b1a-80bc-08da86d1f7c7
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5229.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2022 19:42:39.0773
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: B64UNQK3+jSaG11s/clAG+x5bxyh1C5wDskJopXbH4YnBEMzbGd/vafrds6osEsn3mYrYRiuSghDvmBO+wO3vQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6717
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
> Currently the OS continues the PSP initialization when there is a write
> failure to the init_ex_file. Therefore, the userspace would be told that
> SEV is properly INIT'd even though the psp data file is not updated.
> This is problematic because later when asked for the SEV data, the OS
> won't be able to provide it.
> 
> Fixes: 3d725965f836 ("crypto: ccp - Add SEV_INIT_EX support")
> Reported-by: Peter Gonda <pgonda@google.com>
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Jacky Li <jackyli@google.com>

Acked-by: Tom Lendacky <thomas.lendacky@amd.com>

> ---
> Changelog since v1:
> - Add a blank line after the variable declaration.
> - Fix the string format of the error code.
> 
>   drivers/crypto/ccp/sev-dev.c | 26 +++++++++++++++-----------
>   1 file changed, 15 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/crypto/ccp/sev-dev.c b/drivers/crypto/ccp/sev-dev.c
> index fb7ca45a2f0d..ab1f76549ef8 100644
> --- a/drivers/crypto/ccp/sev-dev.c
> +++ b/drivers/crypto/ccp/sev-dev.c
> @@ -237,7 +237,7 @@ static int sev_read_init_ex_file(void)
>   	return 0;
>   }
>   
> -static void sev_write_init_ex_file(void)
> +static int sev_write_init_ex_file(void)
>   {
>   	struct sev_device *sev = psp_master->sev_data;
>   	struct file *fp;
> @@ -247,14 +247,16 @@ static void sev_write_init_ex_file(void)
>   	lockdep_assert_held(&sev_cmd_mutex);
>   
>   	if (!sev_init_ex_buffer)
> -		return;
> +		return 0;
>   
>   	fp = open_file_as_root(init_ex_path, O_CREAT | O_WRONLY, 0600);
>   	if (IS_ERR(fp)) {
> +		int ret = PTR_ERR(fp);
> +
>   		dev_err(sev->dev,
> -			"SEV: could not open file for write, error %ld\n",
> -			PTR_ERR(fp));
> -		return;
> +			"SEV: could not open file for write, error %d\n",
> +			ret);
> +		return ret;
>   	}
>   
>   	nwrite = kernel_write(fp, sev_init_ex_buffer, NV_LENGTH, &offset);
> @@ -265,18 +267,20 @@ static void sev_write_init_ex_file(void)
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
> @@ -291,10 +295,10 @@ static void sev_write_init_ex_file_if_required(int cmd_id)
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
> @@ -367,7 +371,7 @@ static int __sev_do_cmd_locked(int cmd, void *data, int *psp_ret)
>   			cmd, reg & PSP_CMDRESP_ERR_MASK);
>   		ret = -EIO;
>   	} else {
> -		sev_write_init_ex_file_if_required(cmd);
> +		ret = sev_write_init_ex_file_if_required(cmd);
>   	}
>   
>   	print_hex_dump_debug("(out): ", DUMP_PREFIX_OFFSET, 16, 2, data,
