Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 982B94E6F4F
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Mar 2022 09:11:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353672AbiCYINO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Mar 2022 04:13:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231436AbiCYINL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Mar 2022 04:13:11 -0400
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam07on2069.outbound.protection.outlook.com [40.107.212.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF670CC51E;
        Fri, 25 Mar 2022 01:11:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cBBhIe6soHgbuRok2AtLzQDJJH1Sm8SKsnP1eSNnhy3GpFUjxJnAPQDN94DW6PJVd4kuAhlsRzbPvt42AQmH3LfjeyRNF9zOn2K3aWjVP3WwgI8TEyhyQZvqbsr8GlX2xugyOr0xuWpu5lV9/lkLXjESE1Y+sBIiZKuc+E/dwPqtUanVOmPkqFSk99LKNS328Y5NFRgNzi97NZCK0vZXoVSqoRHkcINuqii4pudwibR2SmLpQLVFoRZWoITta5jl2WN7Um58xmqlpWbLm29xicnGkTOyX0AzxOcYWrlE3oNhdC7+kbAvZA2Rrnp8XeX+JTIxxqF764R0S3oA+00Bvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=esofCthFgtvx2pcFiOhG4+JrnOtTNDEPFWrOtCHvy3k=;
 b=DgbrlkXB8yfRFCyPnbX/8tuaUzimhRFgBTfg1eoTCJf7Ekotp8lYghh3Pe2l+FWFJqFscFAVZK0WA8hcMzk+CNdvOAVlC4T57mze/Wd6Ky+J6x1EBh9zEwPBRjOevXfC0CRXDEVDJoup6yo+FUAhtTn/j/+8+iB5JUYXA8endYeMe61J/2KA1JS7GOS4SqE3mXiX+1ZRh/oOslSaDqQC3MerBU2t9u4EV5hWxI+hUouAwySDlVvZhAd3gSR0T2oJl9SqZ9vJHXQyA6isppE66XBb2CeEfoUu4LNh9pInaveQe8iz23w7x7EZc2aEHURDXq0aVJwaBTzRAFq8NQBHYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=esofCthFgtvx2pcFiOhG4+JrnOtTNDEPFWrOtCHvy3k=;
 b=VV6ye3DF7gQ4c0l+Tzuf5Ex0qHbCSXdR4IGAXcSIC7Vxgw+zg++iAoICdApCenucZ+jQXuZio7ejnpc60RDmPhi+RbJKutpZ9/cAjcD+GW8Cwx76UsJO3Q0288XC5B+VAkOJs2jZNfwZEQXb2dN7lL39MDdfPN03TxbVQ1NPAjM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3587.namprd12.prod.outlook.com (2603:10b6:408:43::13)
 by PH7PR12MB5976.namprd12.prod.outlook.com (2603:10b6:510:1db::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5081.18; Fri, 25 Mar
 2022 08:11:36 +0000
Received: from BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::404f:1fc8:9f4c:f185]) by BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::404f:1fc8:9f4c:f185%6]) with mapi id 15.20.5102.017; Fri, 25 Mar 2022
 08:11:36 +0000
Message-ID: <96625b4d-b95c-0383-ef0a-342144212a61@amd.com>
Date:   Fri, 25 Mar 2022 09:11:30 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: linux-next: build warning after merge of the amdgpu tree
Content-Language: en-US
To:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Alex Deucher <alexdeucher@gmail.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
References: <20220325190758.733238b3@canb.auug.org.au>
From:   =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
In-Reply-To: <20220325190758.733238b3@canb.auug.org.au>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0043.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:48::8) To BN8PR12MB3587.namprd12.prod.outlook.com
 (2603:10b6:408:43::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d23e90ed-799f-420b-d89e-08da0e371478
X-MS-TrafficTypeDiagnostic: PH7PR12MB5976:EE_
X-Microsoft-Antispam-PRVS: <PH7PR12MB5976858F0271D9622EDD5068831A9@PH7PR12MB5976.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9V0l2z1BXwj9rhNK+5LTZPgxgijQXq/OlaSY5r9VOZuM8jQAY/XL/x++HTfH+zSZBgsRfhl1vnpHGIqpC4pBC+4gr5KUTmGk50UuSp3sZo7Hx5AD9FeDEb1KlPT9P3U9wwSNDJmfelMKaHw1AdjOMHjAPttN4414yh5x4QNcLpoPl+S3ayzPAhV1I2A+gO1Ra+TPfglVkJaDyivJSSxaBQQyvSAhQMGencNuSkT+xpuVEVGJabnL5z1YL0FrulobXWJpa1cenbyDaxTknYSs+BbJ9QkjaH2d0muE5prPsBNmICe8QmY29ErUf+iNs+2u7cy1orqJFKqMZJuIsw9HNSs1BNStu9f5f9hzRUlCvc/j23kjBS0EWp++xydV7SJUzaRodNt2BQJkswMcbd0gsTiqQHCq0zSA0z0nF7zSSWIleNLuFai8F/PlfHAq/68zo/iQ6K2xi7faWWVUk3MGt++toxsFdx4yAGkMBTy38zBULpeeraSAVyKLtLExy0Wfzxy4yPgXpG77gJhruRuZM5VtiZyyfzhSEN5YiXAxUo4FxormjQBltrnn+55V9JL6TfYPvouvPbQ69Zmof7Hni4CZDL49qjq7AV/1lZI3/fTnY+XPJlXygqKI2YyeFD9FCBa7pJaCXzZ73O9UkwnQqyLsiY8n9mNHpR3Kvxeo3Y72cOLxBFTHNfX3397ZsGbKkSirZbMSqvqcHrUZF9zW8QrukzMaprblggcWO1i9z0ssATA619cQER1DGdLaAm6j
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR12MB3587.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(8936002)(31696002)(508600001)(5660300002)(83380400001)(31686004)(4326008)(2616005)(66556008)(26005)(316002)(66476007)(66946007)(8676002)(186003)(38100700002)(86362001)(110136005)(54906003)(2906002)(4744005)(36756003)(6666004)(6512007)(6506007)(6486002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OWdOYjUvcUdPblZMK0hwY1BmL1psLzUzakhxOVhKTjFneEtFOU15c2ZSbHVo?=
 =?utf-8?B?cGlnSFo4Wjh4SjBIV0RIWUxIU0gzdGFhWnZsUzRWMmVOQ3NOOVc3LzhPUU1M?=
 =?utf-8?B?UnFCYWZGS2tGZ1ZSZmpubjVRT1R0cHZvK3QvN2VlcFVDU3IrRUQwS3gwN0pY?=
 =?utf-8?B?QVpGemlqQlEwbzBwbFp1OFAyS0h1MU1ZbWFUamVmMTRzSkl1Nm52V1QzYlRJ?=
 =?utf-8?B?dnE5MlA4TGhHdlhqek94WWR4em9aYVFSR3pRdFRGSVdKazhPUG1sNzNaZGVj?=
 =?utf-8?B?bGxJdS9yd2hyb2F3dWVNblpYNGpPV3pWWUNSTWNkS1d6ZTdmalZaUE1BYkpm?=
 =?utf-8?B?SksvRXJFZ2tRUWhQUHphb2hTemU3KzE2bWUvdGxhbTlkN05sRWtZU29pU2gw?=
 =?utf-8?B?MnJZclFCaEV1UFVEV0hmRVRiMjRXcTFIZkZrQTlLdmlkbUVnRlVIbzl5OG4x?=
 =?utf-8?B?NEd3aW5HaUFacnFwbzFCY3JaU2cxbjZvekVGaVpUTURXMVBSWitWVjVFSzhl?=
 =?utf-8?B?NG5rQW5LNXZFYjIydnZIWnpONTJLaCtvRUgyWEVFK3BUdSthM0JrS2gzdlJ3?=
 =?utf-8?B?TmJTMnMrVjNhNUc2Q2UweHVnNFpJdnRCdVAxdkx0eUlPRytmNjZwUjNiYThn?=
 =?utf-8?B?b0Njc01xVDk5TEFkWHpkYlpzQzlhTVk3YnkxODIvUE14YVY5TDVOa3VmREV3?=
 =?utf-8?B?SGwxWGpXaVI3SUtHeDAwSUR1WWFjeU5zUkdIbjFHZHpQM0JFdmlVVkhFQkVt?=
 =?utf-8?B?Z2JCeks0ZUdXN09rNjJrUm5mWStNZ3B3b3V3ZkI0Um9XamlsZEUxbC9QN1Q2?=
 =?utf-8?B?UTR5a1RJY0NWaEtkbGs0bW52b0FHdWNPMW9VRHFodCtLakFpNmM4WkdUMGN6?=
 =?utf-8?B?SnpnY0pTU2J4eVg4NHZiMXdlN2FWelZaaFh3WXNCZzBPNnhmOG13YnlSK1dm?=
 =?utf-8?B?bXBieElMSUVWOHljN2YxZTA4YUt5TE1aUDBqdFNERFZUNG1tK3h0N2hhdm5F?=
 =?utf-8?B?czFXYXNNbGlxeXZFNTRwcmFqa2hIUGtWdW13ckVXT2ExYlBGN1BBSVJKV2Jh?=
 =?utf-8?B?OU1EV2dVaVdRQmp5S3ByVjVLNUo1ZnBPUWlNa2tpYUZ3dXN6OVV3aW9Xb0cz?=
 =?utf-8?B?Y2dxaVlCamFBbGhRQmNvdUtOZjBkU2VmQUo3cVNQNUJ1NDIwT1JTVWdSZzdT?=
 =?utf-8?B?d2hmQVNlTmFCak1UMG5vamZscFNkUGJCRW1UcEVRZG03TU9ZTkJQNmErNHZX?=
 =?utf-8?B?cVJTcnVXU2RqN2ZMQ3kvZ3Q5Zjh6WnhNSlZ6ZTVRYlVLYk81QXpubmRnTWt5?=
 =?utf-8?B?UjMxMVpxUjBKZnNEOThXT2sweFFJbS9RZDhSajdjc0tuUHk1NHViSlAvc1Vz?=
 =?utf-8?B?RVZPWjJtdUdKM0RpNEhHT3NrdkluNzBXM2Z0YjEydkhaRzFidksrTGxkSjdX?=
 =?utf-8?B?aGVIMnl3UVo5YUwxRDVWYUpoTjZiNVE1ak9XL3ZqUTBYL0VUQ0FFVzJ4TzNL?=
 =?utf-8?B?RVd2OWxiUDM3KzdHcG5uc2VkNXJTcWk0T0hUWGNKZldkOU1oL3NxQXJpOTJ0?=
 =?utf-8?B?UnBwQXlEVlk0aVkvZ1U1d2twQmlzMUhMRmtlZFhqa0h0cmtHUUdGMFh1QzE2?=
 =?utf-8?B?VTVRQ1hvRWhjM2pxNGJ1anpMeFA0UHV5dnMrQkFQeVhvSEgxak4rN2xOQTd4?=
 =?utf-8?B?dllKcVgrR0ZKRXpLZm9sSVJLVDJ5MWR2SGtxNGZLT3pkd1F3Z0h3ZkdQOWpY?=
 =?utf-8?B?NjFsVXlMbG9ncm9JaDlLbDB2ZUVHZ3RkN0pzWitCTEZQUFk3U1RpZmpqZTNq?=
 =?utf-8?B?K28zTDdrc2JyaHNmcmd3VFB6Ry9uemI1U0lzaGhOeGQ1S3hBSXZ3UElVT0xr?=
 =?utf-8?B?YUxNR3h6ZlNqSStaRG85SHNyRGlZVUFuZ2cvbCs5WXVnelkrbEl6d1dtT0lL?=
 =?utf-8?Q?iGsg45XynTvEs1yRhNMXbItPybsefa79?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d23e90ed-799f-420b-d89e-08da0e371478
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3587.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2022 08:11:35.8613
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WLChe8XQTsL5SVpwSv6qzN5bAVfC1DVNcL6jIQoZpPc4MPfSCmx1dRGyeNw+z9Fd
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5976
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for the notice, going to take a look.

Christian.

Am 25.03.22 um 09:07 schrieb Stephen Rothwell:
> Hi all,
>
> After merging the amdgpu tree, today's linux-next build (htmldocs)
> produced this warning:
>
> drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c:94: warning: cannot understand function prototype: 'struct amdgpu_vm_tlb_seq_cb '
>
> Introduced by commit
>
>    0de6faf15895 ("drm/amdgpu: rework TLB flushing")
>
> Presumably caused by the kerneldoc like comment above the struct
> definition.
>

