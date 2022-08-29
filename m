Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66D4C5A4C12
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Aug 2022 14:39:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229712AbiH2Mjm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Aug 2022 08:39:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229629AbiH2MjW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Aug 2022 08:39:22 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2058.outbound.protection.outlook.com [40.107.243.58])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5A699C2FA;
        Mon, 29 Aug 2022 05:23:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aygMhV8UV6pIXcNGgBGJ5FvvZeTdLKMlqFpWm3kkQFwMtFBXJyYbNSs5Z1QNWHkfTDIBWQSp+j1dwFhDIcuTdAec7aWYkw5V7bWCTP8D0gY62NvZR+b1s80T7m97JQUD/S/gxjLEeIRJxMUT9YvEmVyEUrPCPmpPFfNmRdqgLY3E6qVX7+auW/WMveSBNoiQ4qWhBCIJ2i/DAgCECaoBbe2Ld3DcckXk4PR+N+Pu6KZs9ViLW8JXinMd+TGUgHKuY4VFP1AyS62MuP1u2Za3mz+dWxCQ7LgayBfrXMY/UtrlL3vMdp9kxixTf73dunEAf4iJLLGl30/4QgAQJaHCcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3U2JYEVsO+yeqFZQrpx5bdWbX54Dg+ZeUlEhZw7/vFI=;
 b=LhOX0dNWsCaImqOcUyVVYxSfbmJZuCEniwvo1gNInljit5pGpspSbrJRKdv8F4zYGzt6etiEB9WMp6yN20+GxcyDl5l61MolAzAY7NAzg5CE/A292wXcaEbg0scKinJD8S1A20GHewg5cKRHysOshSoydiTfybykzNHW5TeawUVXmtB9YHHAcYqZfcXpdhIxRd2JS4xCrNQ5je7P9vk8fW73/XE3skifN/bx1nUoLpc8C2XmnKlO/AH2C9O7N2Ga927YhUqxffYVdbKPt+G4OQEnkOGl6ylSRxiXc3sziwkp7+5hBjDbH2DXkzJXBS7LixjwEuDjIDiAfElcauiMMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3U2JYEVsO+yeqFZQrpx5bdWbX54Dg+ZeUlEhZw7/vFI=;
 b=4LHHi3Lo6T/5ssiP2liNcLe5mXon5fud0oHEsKIMRpuFpuuNScHnKou8BS4AXhxuEl6SEu7cBmjr4dW17Y79cwSBwUHpvFvwegpGVKM+jkPoBDPzAiCwDeDL5q5JdotJ1EDo4GR0eDJnUozG6qIBgSpoLt+xISpvf97/E9Tfw3Y=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by PH8PR12MB7135.namprd12.prod.outlook.com (2603:10b6:510:22c::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5546.21; Mon, 29 Aug
 2022 12:23:07 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::e00a:1f8c:dcd1:afc3]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::e00a:1f8c:dcd1:afc3%6]) with mapi id 15.20.5566.021; Mon, 29 Aug 2022
 12:23:07 +0000
Message-ID: <a514ace3-ee63-7556-1b89-cd76e6333015@amd.com>
Date:   Mon, 29 Aug 2022 07:23:04 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v7 2/3] thunderbolt: Modify tb_nvm major and minor size.
Content-Language: en-US
To:     Szuying Chen <chensiying21@gmail.com>, gregkh@linuxfoundation.org,
        mika.westerberg@linux.intel.com, andreas.noever@gmail.com,
        michael.jamet@intel.com, YehezkelShB@gmail.com,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Yd_Tseng@asmedia.com.tw, Chloe_Chen@asmedia.com.tw,
        Richard_Hsu@asmedia.com.tw
References: <20220829111059.665305-1-chensiying21@gmail.com>
 <20220829111059.665305-3-chensiying21@gmail.com>
From:   Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <20220829111059.665305-3-chensiying21@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN6PR16CA0054.namprd16.prod.outlook.com
 (2603:10b6:805:ca::31) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4acc479f-1ed3-40a6-33dc-08da89b93ac2
X-MS-TrafficTypeDiagnostic: PH8PR12MB7135:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: b8KZs01fnxD3R7DKifVVcBK82se/+BY7DhbTfqvbxc+fTHMbo3fnN525WjYYPGDYkU0gJXNKfGiWQu0rXmFkBIHHElyBpbCj5x2MaI+ByjN4gIMFBRzkpz0q0M+f+yTH8wD34+c7ffxIBQpMmqmhc5RCDdSxq1EQ5XAqLOwph06O84NcIiJUZbV8dM5fuw0+OjCegR2+3gi4yv8DzmVVKS5gNRRQI4AhfWsetKfSmuYcRUYtUx4bHifR3dzUwa8TEFbUNCRf0SIaWHya0yUg+CTrLzHZKldmKtf1MqHUAu6U43/dAC1qF9Fq9ZFiqXhnz4mRsuwDdpvOIPAez3RmA3aQBWcquc8N2Cu+/rgdWRc0vvbmOs4xRCjEECxlIPQSL/Z+GiROw/I57rWKVkQCK1b+qJFy1CDUaaTgUDkjlCUJMJH/ZJc50rTBN75z08gPXQG1a8opDSKHqy0OXL5ENvW9C6YpSz6tOmBcq1mQCHW1QcZdsqs5a4vXcaZPXpdVA8K54dnrxAyoXHLwcNAK1qLfiROMoH/zMOfX8AoOao9b9l7iZIads2yrBV5flnfk8O6T/zRKcRFGVEEldDXxhVua7XvbkYVdqHUBxxQyfZFBu6k3TYOgejvqDxl+U/rwFRysguPnXNxlHGCkhegPzVHfx9Ekk29ESihosxDZyGdMhGhIfKB0IL/Xv0VGqPIqF/mP7+2b+SapCQIPhgRvEWl+yd2ueptsYA/fja9n2mSiI0Kr+HoHcvJ+ukFaRrZCdpw9RICxzHmxj0Vcjh9/MgiDvkxg5+FQ8gnGtVVObiM=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(376002)(39860400002)(136003)(396003)(366004)(346002)(8676002)(5660300002)(66556008)(66946007)(31696002)(316002)(86362001)(44832011)(83380400001)(38100700002)(53546011)(478600001)(31686004)(186003)(7416002)(2616005)(6506007)(6666004)(6512007)(6486002)(36756003)(66476007)(2906002)(8936002)(41300700001)(4326008)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ejJGQ0VPS01zaGl1cU51eWNINkZLOStiWjEvR1puT1d0NmZLamVPS042ZWRJ?=
 =?utf-8?B?RDdjYXE3bGhOeEVHMWZGeUI2Q3lZMng5RnZod1FyK284NlNBZnNISnNyZDMr?=
 =?utf-8?B?VzhCQTlYTDJyZTR3eVVTZlVLQVJtQWhIbjVhbzlhWWxNYVhhSk5LZHQrRXdK?=
 =?utf-8?B?Z0puNjVmY2JUdXh4VTRtQzFYY0VyLzlqK3NtQ3RzT09jLzFJRjN6ZWR5a1ZM?=
 =?utf-8?B?MG5DdlNRdEhkdllZWElYOGRSdER2WlBrdktUZDBMaFZ6M0pMTlpsQmlzVkR1?=
 =?utf-8?B?M1h2eGtnN3QrTWFoczltcGs1VU9RNFhmZUpTeVd0Z05rUXdjd3lseTdOdnFE?=
 =?utf-8?B?Uy9hQWgzQXN5ejZVS2JzYTd4SFBlYnBaNFlDbFJYVnVSYytBWnp4ZEVDYWZJ?=
 =?utf-8?B?Vlp0Q25PZk5JQmxkRDA2UEhXZ3U1M0FsK0dma1c4MEhMcXNhTUpTRnJQa2Rh?=
 =?utf-8?B?QW5IZVRlSTFsV3FEMEMxQ2xLK1hXeVkzaHF2MXl1N09UclZEU3FPOFdLc3dQ?=
 =?utf-8?B?OUVKZ0h1YnNNOXRvb29QWjhCWENoUUdOcDcxbWZ1cEF0REc0ZGxLOTdpZ2JC?=
 =?utf-8?B?SThBMG1meDBnbHpnNzMrYXk1aXhpQUN0cG12bmZwUHliRmc3eXpjc0dNc1Y1?=
 =?utf-8?B?VlFid2d1KzhGZDdHVTNSVGlwNkNRZjkzbXdXR3VFOFYwSERPYTA5Q2E5L29F?=
 =?utf-8?B?SkVVOHQ1d1dsdHNMNjMzRUZIUFRzSFBXMUd1NDhiRG5kNTVvWWN0T0RIMS9y?=
 =?utf-8?B?YjNaRmFMcUpvaWl4NkxIQVZkUG44UGZXZm5nd0FaY3J3OVBpT29oT0JkYlBU?=
 =?utf-8?B?SWFKTjdiYko2TnExcnlwOU5QQkV0d2Y0OW9RZ1hYb25MdVVHNE84YlRNU1c0?=
 =?utf-8?B?dFNacVFBVHduTWJvcHI3THlzaDlGTk5odzRadTJHb0tjOW1FaEw3VUg2OFNr?=
 =?utf-8?B?R2Fwd0pEdDlmTVRQRk0zT0kwRVlkdVNETTJjMEduOXZ6TmpnNkdQMjVYeEl3?=
 =?utf-8?B?V0JBNnZHOXhQWS9lUDB1aE5VSFNtOGdWWkRJU1NxWFBwaE11NzlnQ1hKMk5D?=
 =?utf-8?B?M1dNVElxcTk3SG1uVS9kV1NPczQ2ZDk3a3hlcWxBMkpYRitSQzVuY0ttOWo3?=
 =?utf-8?B?VGpyTlhxb3FGd25hUlB1RGNkTXdpLzNZWGwzK2ZBMUR6UjNScmh0K1VNLzU3?=
 =?utf-8?B?dGlhTGV6QS9rQldxU3ZtYk9qa0JDY3JjRDlRWUtlc2RmcEhsb1NhZW9HMFQ0?=
 =?utf-8?B?MVBKTE5HeElBZE1QK2xaOEtUTVZVOEQzMEsrY3NaTDBINnhFaWh0cU52Qlo2?=
 =?utf-8?B?TG1EMDNJK2R3L0Q3d1hoYTZDenVuR2JUbGtNN3dHUXd3MnFnWlVlUXM1dW1K?=
 =?utf-8?B?d3ZLOHJjNkl5N3dYSnF1MTdFT2JZRHRPR3hyZUYvd3FrUU1Yam1lcXgxT3FX?=
 =?utf-8?B?ODVjSk9EUFB1ekNmT3VYeWhJZnZ1NzBPRHJ3UTcxanlETDBXMC9DNmd4a1Zh?=
 =?utf-8?B?dVp4WGJHaE5NdWhRNXlaNENiQ3BxRDQvZm9KWTZjNXJtYjBocU5aS0MxZlVC?=
 =?utf-8?B?SzVacGY3eWpmR01wQXJ1bVpCUHVRUnkwZkpMNnVheGZwSFQxTVJCdXRZbjE0?=
 =?utf-8?B?bStlbFpTUE1HbENhWENpNEN1R0YzNjBFMlFSdjZaWHNRd0V2a2IzS2xHdklY?=
 =?utf-8?B?bDJ6bzBwNUU2cGgwdTJIczVuK1lKSUhjZkUxSHg1bmtBQVVvN29DZldYa25T?=
 =?utf-8?B?aFNRK2NuajlNRXFRRUVraUZZcUVCSmQrVHROdTY1cmp3ZkFoWEdzS2lxSnIy?=
 =?utf-8?B?YmM4cTcwWi9kOTVCNFFIdHpPVHY4eElPNXV3VldSUjdOVXRKYUVpSFNXOTYr?=
 =?utf-8?B?Mi9SRWJ0Zy9TUERoQmVFOFFDUFB2NjhRSDRVSVZkTjJmMnhGVjZhNlpNL2ht?=
 =?utf-8?B?dTFJMFpRRDFITlNsVjEva08rUmNCUzlLNURBYm8zalFXaXNVb1Qyend2R1Jk?=
 =?utf-8?B?KzhPMmRkRmkrQy9aU1hzamZzN0NtVHNCdkJUcVJLRXpRM0k5WWtPbG5wVkpX?=
 =?utf-8?B?a1RwVDA2bFNFbXdFUkRPV2VPQndkZ0VvNThMaDkyZ2NlU2p3NWl0LzVMb05X?=
 =?utf-8?B?NCtINi82czBEU2pEQkJUQU1nMlRqU0l0MS9GZE9iRWxUcU1uejdGUW13ZFA3?=
 =?utf-8?Q?oImG7n8REXUBfEQRG9rvycQHQWujG9lXjOmqfZHNc92a?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4acc479f-1ed3-40a6-33dc-08da89b93ac2
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2022 12:23:07.5513
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3ga7SSgp4jS+x7fc/AzAmJOqcxp31SiD0OQSMswfb6e2lKWnjLvn3flQfzEie0JjS3LLcEdj+LFjNR+jZXdOsw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7135
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/29/22 06:10, Szuying Chen wrote:
> From: Szuying Chen <Chloe_Chen@asmedia.com.tw>
> 
> The patch modify tb_nvm->major and tb_nvm->minor size to u32 that support
> diffrent vendor's NVM version show.

s/diffrent/different/

I would suggest you explain the WHY of this patch.  I would have worded 
it something like this:

Intel's version can be stored in 2 bytes, but ASMedia's version requires 
8 bytes.  Extend the 'major' and 'minor' members of the tb_nvm structure 
to support both vendors.

> 
> Signed-off-by: Szuying Chen <Chloe_Chen@asmedia.com.tw>
> ---
> Modify tb_nvm->major and tb_nvm->minor size to u32.

The idea with the changelog below the cutline is supposed to help 
reviewers know what to focus on when reviewing from one patch to another.

In general it's best to specify what changed from which patch to which 
past the cut line.

For example if this was first patch version that introduced the change 
it should be something like:

v6->v7:
  * New patch based on suggestion by Mario


> 
>   drivers/thunderbolt/tb.h | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/thunderbolt/tb.h b/drivers/thunderbolt/tb.h
> index fc32737fcde4..9cf62d5f25d2 100644
> --- a/drivers/thunderbolt/tb.h
> +++ b/drivers/thunderbolt/tb.h
> @@ -50,8 +50,8 @@
>    */
>   struct tb_nvm {
>   	struct device *dev;
> -	u8 major;
> -	u8 minor;
> +	u32 major;
> +	u32 minor;
>   	int id;
>   	struct nvmem_device *active;
>   	struct nvmem_device *non_active;
> --
> 2.34.1
> 

