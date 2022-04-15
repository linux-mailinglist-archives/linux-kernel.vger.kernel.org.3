Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9416502B46
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Apr 2022 15:50:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354148AbiDONwX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Apr 2022 09:52:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231714AbiDONwS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Apr 2022 09:52:18 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2076.outbound.protection.outlook.com [40.107.94.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCE7C55214;
        Fri, 15 Apr 2022 06:49:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QmFc7N99aGpeydUFYrBo0VqNBMny/r/jdIuDDFYiHcRvIMfrzVkU2zBeAMIp1452qJSA8MB21BYBu1fFFCrcLqolK6ODZkGOgc8WS982LiH+4WUtAsM/JYMxEQAlkBWe2KANIm2NRXxtK4tXGf+dp6IZ3zw+RQm0YzMICIx/IuSDVhb3JfZm1oJ3Pu+RsFzKepf9CuRf3tseqQKEkhwnlQQQMLtZwEAU2S1lPvJnvM67eTSrWuY0nNl4SsBesIKBsiiauIkbxIyzN5hkUfUmdUrDrpSmYQvUFksC9nUDcUSflIbqvxxOPlNRuVCnVkyJlk6csZoCY9OPW1PqPwyr+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QYgDIEzNCC0o1mXK8w6IW4/B9W+QLaYMDydDrsVaDAc=;
 b=dekI5SIyi6iwyxyHxucXO/DKeeOqwOe5LORP/+dfLizbsnBhg55tanrChJY5IVdjFkPb92KUcWPFHu6lEtcExRndtw1WsFv6hmSCRmyObCqkeyblE3TNs3pI+IaFG2kFtI3L3Wj0CwIT0vMfbA9jqXZmvF+AoWhsEcqGZPDSiFJQM/YObYEjpDvGDjPlplgYeuBIL1vHd/WVTmyqsPh01N617B1nlSJOV9l3aU6Wuuu8DzacHoDlCpduUH5zYYQ9Fh7UAh/r1jfLuZLSAJ8vJinmcZsdrssChvLwJckd4bLTyLqEA5vtiGFeE9Qh+5bRsSBCGcVRXJgQP9Ec8oTsfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QYgDIEzNCC0o1mXK8w6IW4/B9W+QLaYMDydDrsVaDAc=;
 b=1VRbdEodW0ZspUulI+nBs8VGVmnKhKSBat6zK51kIxA3RRqNvZe11kdjWzNSJvWmkkPzYjZiG/dx3i/AuzR+AtzV+L4ukvpdcYiOHP0CHm2RTUrGM2TQP6nIByDRORlfFqEYa/mNASGd/aC1J0YbHpzMKGEkVmQSiSgpzyd1GJM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5229.namprd12.prod.outlook.com (2603:10b6:5:398::12)
 by DM6PR12MB3452.namprd12.prod.outlook.com (2603:10b6:5:115::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5164.18; Fri, 15 Apr
 2022 13:49:46 +0000
Received: from DM4PR12MB5229.namprd12.prod.outlook.com
 ([fe80::781d:15d6:8f63:a4e7]) by DM4PR12MB5229.namprd12.prod.outlook.com
 ([fe80::781d:15d6:8f63:a4e7%5]) with mapi id 15.20.5164.020; Fri, 15 Apr 2022
 13:49:46 +0000
Message-ID: <fe209f25-6119-cc26-2608-8aaccf11ac36@amd.com>
Date:   Fri, 15 Apr 2022 08:49:43 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Content-Language: en-US
To:     Jacky Li <jackyli@google.com>,
        Brijesh Singh <brijesh.singh@amd.com>,
        John Allen <john.allen@amd.com>
Cc:     Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Marc Orr <marcorr@google.com>, Alper Gun <alpergun@google.com>,
        Peter Gonda <pgonda@google.com>, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220414162325.1830014-1-jackyli@google.com>
From:   Tom Lendacky <thomas.lendacky@amd.com>
Subject: Re: [PATCH v2] crypto: ccp - Fix the INIT_EX data file open failure
In-Reply-To: <20220414162325.1830014-1-jackyli@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN6PR16CA0041.namprd16.prod.outlook.com
 (2603:10b6:805:ca::18) To DM4PR12MB5229.namprd12.prod.outlook.com
 (2603:10b6:5:398::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8955330a-06f0-46b0-6ce2-08da1ee6cd10
X-MS-TrafficTypeDiagnostic: DM6PR12MB3452:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB3452B09B7D5FD5C4EABADC6AECEE9@DM6PR12MB3452.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0dwF0aS5gx+b8XwWTWbJpYFbYlu48oZLa3zf1QyzucamG42C1VWwlfBP3yWQts8fcrQQ9hF13AOvF7leFjWH/+wIFvNK4F0lGtkMeKcgHNS2K0Hx4dbW1GV4SviedTR9hi4ojUXfV6DeBX58V82/YF8iRQeWn0nfJjLVfsxuTI0hNMHeFumOOJijVD74zNAM5L2SZeC4FB4WdQyejvTivCKFDpbxj/iKwQHve8LroYcCrGaCDdyW0E7I675IiZ4SpCCBEI/F8BJZvRDRl4mcQw/aTSyFJsw2hHGQKGPgKuGfsK29nlqPf7RCOlqoVu0ERiCezU+rjP2N02ULKwxEN597O9y+SJU4omguKirIVSL/tJVxbTS4gCnzVmBfzrKlfkmZFdt0ynb5V9rN0+5laR7HGvFVL+sNnpEGvC7VY+WliCQ/37tbSSCskvEeW/0cjWnC1EWJh59BkvisTfnKY1JGD4gidqfYqXuC0cdP9rNjeIxr5+TMZiLUJVc96UxL3Lzj3wOimh3MIKR7fPZVnAmXUbDozz8rvWjq3JD6WFmrSVRxQLoP1AKg28C+F6k/nBOo2H0Ta2B7yaCkfZ9LW6IatbzGXrB4mLGRzFXhbOZPA29757XPXGvuEP65hto9Q/dDGOofynOa0wxkg0VUYeI7T+PhlGedP69RdmPfpSF7QxMkTod76zHtnUuofNMvLsldbnIFTIjWhs/Eqodmxnhyy8z4tDV2Pe+6L3dfALo=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5229.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(31696002)(26005)(186003)(2616005)(6486002)(508600001)(6506007)(6666004)(38100700002)(2906002)(86362001)(6512007)(5660300002)(53546011)(83380400001)(66556008)(8676002)(66946007)(4326008)(6636002)(316002)(54906003)(110136005)(36756003)(66476007)(8936002)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VWFWMElzcjRXTEFYUElGVXNLSXl1V01UcmkwS0JJQVNZWjNaaU5ERURDVHVB?=
 =?utf-8?B?dDBUNUNMT1NJcHJHVU5HVE0rdHkxc2tPb2tPR2drRHkxY2ZJMm54dnJiMWlR?=
 =?utf-8?B?M1VKbkljQ3JxN1l6YVFjTGIxdC9kUVhWc3AwTXk0aDF6Yy9xSTFWcjRLQm1D?=
 =?utf-8?B?eSs4b0VZeFNMaGxqUzhMWVNFY0ZLb2c1N0ZmZzI4b1dhNmJlNXZ2bjZ3S25N?=
 =?utf-8?B?T2xvNEs3Rmthc3I4bzNMQ1lJRzZTcEIrMUxkd1Ixb21GY1JtR3FxNUFDODEx?=
 =?utf-8?B?eDFDOWtkWnBHYkU4VUdIWWtaMDU5dDRGK0xIOXRENDJwN1B3VGNpRGZnOEtn?=
 =?utf-8?B?MmxQWmlYZDFlLzZaczd1S3lQdmtiUzhaK281UXIxV3dOZ3pDMkU4VjZSQVdw?=
 =?utf-8?B?UXdEZC96SVdMYkx4L0NMMlo2SFdGeUo4LzlWbmFsSCtlV1ZJVUdUU204MGda?=
 =?utf-8?B?RW5qelNwUkxIMjMvSUlhamk3cHZBUE5oeWFIVlVYaVJmZDdzMUdIUGcxUnQr?=
 =?utf-8?B?QnlnY1d6SHk1S3FVS0JoU2liNGFUNSt4T3F1Mlo2dDU4ZytONGtDRlpDQVp3?=
 =?utf-8?B?Vk9QcW5IUE9RcUJ5WXB0RHJpMTJxUSttQU02QzkzbENPSEFHOUFCNkZqTXRJ?=
 =?utf-8?B?cC9WQ05mV3pwamQ2aWZIdHJaTkJ1R1FGWWNtTmJEMmxsOFlZOHN4Vk04WHVK?=
 =?utf-8?B?akFSQ015d1h6bEZSZU9EQmJ1dXN5S2JoUHBXOUswclJoVDVtYmx1Q0NKNGJB?=
 =?utf-8?B?TWt1bFU3Q2RmVi92U1QrN1JWYzdJK3R4cXNNc3pZREpaNG5yTkpTRG9DbHRM?=
 =?utf-8?B?QnRWQmd1Vi83dHRRbE4zdHVGdlBMSE9ld3crb3hFSW9zeGRuOXpaWGlGL2h4?=
 =?utf-8?B?R0dBV1dYdVd4eSsvWExmMitraHpDc3U1c0dsUnRtZjY0Z1Z1K1RGZUpQRTNS?=
 =?utf-8?B?VkJjSSszMXdreHBtYjcvV0oyVmxrZzh1eFpOTnhYdjM1OTg3U0o5N3FOanRz?=
 =?utf-8?B?L3NLdVYwSHozZkNHRE5mYWl3QTI4SEloNUdBK1YxdmRhVGlGRW03cStUQmc3?=
 =?utf-8?B?MzlzdHpScUFrd1FkaUJmR2s1a1B4Y1J3Rldkdlg4UWM3eDB6MWxuNHo5WXhU?=
 =?utf-8?B?R2IvMWZ1VDMwbERIbDU1WDQzbnhUdStrS3JwSHFnVGxQRnRhelpCcVdqZWpo?=
 =?utf-8?B?d01vTDhPMUlmT3BicGJCaG5VZGpHYjdjZ1hBZ3kyV3BONllnQk1ORFZKemZG?=
 =?utf-8?B?aER2c1Frb2xnYzZpV251SlphQ2pyOHhWdmZxdkI1Wm42TEpJLzY5YVo0eGhu?=
 =?utf-8?B?UUF2NW5CRzdQd1M1ODZhc2JDSXQySmcwaURIbE4zaG5ZS2pHTzY5emxhbW1h?=
 =?utf-8?B?VHU2ODNsenVzNndVcWs3RlRxWmU4K0FPK3VBSnhUVGthZ1JpT0xGa0JrTWpi?=
 =?utf-8?B?ajlJZWZhbUFMa0w4V2xBVHlWSCttN3dta2VQSXJMUDlOdmVZcFdSL0JmZzhV?=
 =?utf-8?B?TkJXZjlkejdJeHdDQ3pIejlWdXZLVmk2SzJVUy9FVlFCenBwdmxraE5BSDVE?=
 =?utf-8?B?eEgwMFlySTFMQkV4Rm9DMVVEVFpUZmJHOVYwNVZDMFYrdHcwb3hOR3lyUzV2?=
 =?utf-8?B?UExwREp5NFJ2MThzNDltenRZNmNXK2pVVGpxYVlPYjF5KzR3WWhXUnlNdHdW?=
 =?utf-8?B?SHd4dGNhWGN0aU1ueVBBV2JWaUxUbVFpK3JOaGsxRGcwV2t0d0pIbzRQU2Jz?=
 =?utf-8?B?RzVBOE81ZnJDczZZNzJhaFVnY0ZOK1lvaU1Jbmxva1JDNzFGZlVodW5MUkg1?=
 =?utf-8?B?YlRZY2RUbjJsWjFXREozUkZSNnlxNFFTRGZvUEs0eVE3MFVUNU1FWXlNRXB4?=
 =?utf-8?B?MlVxMHlhL1lJSlpBSk5mUDZxTkFxU3l4MHVnT1NXSStaL3dPY1ZEOElpZXdl?=
 =?utf-8?B?VFBBcWtPZTVJVW9Vc1JaSXM2cmI0V1YyaHBEUVpndkVPU3h3WkIzNnRxUTdI?=
 =?utf-8?B?MjdVSkxVbnp5N0NmeXQyWUpBTkxnVlF4WDk0dkkwcXhKUlRjcFRSNnRvZmF5?=
 =?utf-8?B?eENIK1hwbUF1dkpMZTE5SzUwUVl5OG5PMlJwWjQzYkhNLysvZHhjaXBQMmJL?=
 =?utf-8?B?Rzlva2FjdzFnNHdrQlZXUlRRV2hEeVFKMUswMVhneWZHc1pBNk9VMDhvaTBq?=
 =?utf-8?B?dUNnWERuT1IvenMyZ0d3UjE4S0h4VEx2ZndGc0VpT1BaVUx3ay9zb0ZBbXhD?=
 =?utf-8?B?UkFobVJZUzRWLzF4TG5mcERpTS9EaVRWSFhBTkpkNExMc1JBVkJWS1ppcng0?=
 =?utf-8?B?ZWdCQmxsZlRjYWtPQkdCdkp6dzk0alB1RVJqRGJSYmlOc1N4UmJsdz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8955330a-06f0-46b0-6ce2-08da1ee6cd10
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5229.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Apr 2022 13:49:45.9950
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HyNXXnGAmUI79rwUZwbZpSIMdsDfNIVzWTY2yUtbzDSpOSuLwmSdCjbAoWdt+Usu2B7i5Gmw/1uBOFks/jDF4Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3452
X-Spam-Status: No, score=-6.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/14/22 11:23, Jacky Li wrote:
> There are 2 common cases when INIT_EX data file might not be
> opened successfully and fail the sev initialization:
> 
> 1. In user namespaces, normal user tasks (e.g. VMM) can change their
>     current->fs->root to point to arbitrary directories. While
>     init_ex_path is provided as a module param related to root file
>     system. Solution: use the root directory of init_task to avoid
>     accessing the wrong file.
> 
> 2. Normal user tasks (e.g. VMM) don't have the privilege to access
>     the INIT_EX data file. Solution: open the file as root and
>     restore permissions immediately.
> 
> Fixes: 3d725965f836 ("crypto: ccp - Add SEV_INIT_EX support")
> Signed-off-by: Jacky Li <jackyli@google.com>
> Reviewed-by: Peter Gonda <pgonda@google.com>

Looks good, just a quick question. Should there be any type of access 
checks before switching credentials? Should we check access to /dev/sev or 
such? Or is the capability to load the module enough?

Thanks,
Tom

> ---
> Changelog since v1:
> - Added Fixes tag and Reviewed-By tag.
> 
>   drivers/crypto/ccp/sev-dev.c | 30 ++++++++++++++++++++++++++++--
>   1 file changed, 28 insertions(+), 2 deletions(-)
> 
