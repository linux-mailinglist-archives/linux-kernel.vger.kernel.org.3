Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B16484FB38F
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Apr 2022 08:18:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244873AbiDKGUI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Apr 2022 02:20:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235930AbiDKGUG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 02:20:06 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2064.outbound.protection.outlook.com [40.107.94.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4432F3CFDA;
        Sun, 10 Apr 2022 23:17:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mSXzgTZ6zBKlMGxNvuy/I1qt1eUQgyJsl7HiixqLp86V5nlbiXrqjFEWgrzbjlij+h1jzJQpYsGzW8v+EFVuzrlLzAqmmCxf+Cb98SKpDZXH1FYNFiAbZoKayno/TgXk14iwwc3I8L5T8ey9m8vK3t9LKcYhPKABfzFM4Tp7CL9EiDdldqQmaA7kTOOfhju2wrwvRj9KBdijTbw2xH7OH/OEMtEeA4iTerfuh5wg0gitm6NCN+lxtBOO1s8rzs8E50Mvmfa8Va0cIbk8sLFKwRNMHP4x8qpmRXZjnvJhzJKZB8WFT8JuO+oNlPiqSzuvghfZ4dRZ+tsutyahMY4LZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lbx/JqC9AaaibPr5GtqZ5XnlBzbHkknKO/YmoNzTHz8=;
 b=lw4euTKHCAzeK7btbeiVS6NAqpHF6SEpVxAQxHSJfArHSFmeet0n3ekp8O+kxRDa02ixCmWGdSJ8PmY+Wyn+Q8lKXeFxIovc6FhmjSmKn7HrAhmmD6OVFLWhOT72VTIz06pc6E19RUWmOGi/VS1S39PiAy+ma0xhuibfMV3HEvJsWs9L/pLsTbi8vl5VW1/aFbHDGhf00SgyIhp/SKz4PtmOCOAHwkt/WGQg7V6cRgK34DDQUP4Su+t0YaaM2sVJb6EOAOTnyVhLoEtHeE4Sx7MmmmE7uH348Dw3IeaJv8gjHJH0SW4NHUxBdAaCVC1EdMdWoNf5SMOAE9kMGOeOOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lbx/JqC9AaaibPr5GtqZ5XnlBzbHkknKO/YmoNzTHz8=;
 b=M/eyhQO7+Bps68e26Ddh80YI4ZCUf3kRJ7d9s93mFEMHubqVViQHLZXYZModQmBNsop+XtdGqeJwB90/bn1wH65sh2I2G1gsOOosH+IUC47gaT16hgB5mrgnrF/pM5y3UdU+8K9L+j8aoSXUDxr/wAiS6QViu4K//SZvLXb/aHoMzbZZwslXzVGSZl9/VAkelXg/3uFIKiwdpWrMTO//pxHXawkte6/08BJpI5S6xX/aUW0yqTXsGWk3ueaOdnOE1frKPd1EEL+ihQGIQpgEhKaocKf6+9GSsZSWe6Vh7PW3Au6aHkVvTTZ0DfDahhpHWmpM7vuMBb4asMiv+FvQ7w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SA0PR12MB4349.namprd12.prod.outlook.com (2603:10b6:806:98::21)
 by BN9PR12MB5164.namprd12.prod.outlook.com (2603:10b6:408:11d::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5144.29; Mon, 11 Apr
 2022 06:17:51 +0000
Received: from SA0PR12MB4349.namprd12.prod.outlook.com
 ([fe80::e15c:41ca:1c76:2ef]) by SA0PR12MB4349.namprd12.prod.outlook.com
 ([fe80::e15c:41ca:1c76:2ef%4]) with mapi id 15.20.5144.029; Mon, 11 Apr 2022
 06:17:51 +0000
Message-ID: <583c656f-02d2-9bd9-b381-916abc2eb97a@nvidia.com>
Date:   Mon, 11 Apr 2022 11:47:37 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [Patch v6 2/4] memory: tegra: Add MC error logging on tegra186
 onward
Content-Language: en-US
To:     Dmitry Osipenko <digetx@gmail.com>, krzysztof.kozlowski@linaro.org,
        thierry.reding@gmail.com, jonathanh@nvidia.com, robh+dt@kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-tegra@vger.kernel.org, krzysztof.kozlowski+dt@linaro.org
Cc:     vdumpa@nvidia.com, Snikam@nvidia.com
References: <20220406052459.10438-1-amhetre@nvidia.com>
 <20220406052459.10438-3-amhetre@nvidia.com>
 <158816cb-9509-5962-11ea-e06aee991e14@gmail.com>
From:   Ashish Mhetre <amhetre@nvidia.com>
In-Reply-To: <158816cb-9509-5962-11ea-e06aee991e14@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MA0PR01CA0015.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:80::7) To SA0PR12MB4349.namprd12.prod.outlook.com
 (2603:10b6:806:98::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7153da23-cd45-4d8c-ac72-08da1b8301d6
X-MS-TrafficTypeDiagnostic: BN9PR12MB5164:EE_
X-Microsoft-Antispam-PRVS: <BN9PR12MB5164E3B3AA4540B9B986A66ECAEA9@BN9PR12MB5164.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Q5UswLBeZ04LTancWQiJhvp5wKPQSVQB9ZsS0r/YI/tvaTaVWvSBYOx5PWimce4uvn04Q5dxBH2yNGGU9jWS5qPKwnpQ/+mkG8PvFh720IZ6iW11DYJRFW232OKeWfnyrZM6kz38uqSN5Hr36qnep+ZqoP7quDZ3lt6BIFTCATszKWfThwLZBHrJq+OaRkfG0BujI/Dk4UbRcB1r1tPVUmskXS6OEBjxr3xeZO1ZEGjd0hUr36LdV/lhFLXGUxhZWRskCi3/FPHEGEXPY9rxVYF85HCJQ2Y40hxcOQE35cSDuY9Oe9h2lt4tgTMnokFWVpZW1SOAfjEW4YCHJAeEW4is4MX1lMFlSWOV/RITCm4j/c3izBFKx3AWMeJiZEahNyK9epFm328MDTShgfiCl9hEcQcYeX6WBJJnFylgkA7tB+vya7b5v85KiH1vzcWWnRkv+F3u8yoaeJktOdFwNQUxW7ZRbww6DG6lpPcKKlDo8xzVeZS3b5YK0E1680fJP+0d/v+SUO7N85D5MI8xhBe8mV/KaGDLKUozxUfsUFZ38Cu1PcWcRW2wQxi916SaQQ7chXSXTI3IfYxxzp2zx8lj8WONgkewze0LVek1MiFhK9CzS5d7WmO/+3OeQ85pplTxJ63uWrDYsGahfqLK6jG9u2+ctYHlU97EGKeyQSR0FIDfcxgE8WTOLc3lHamX0vdQaxyjeAcNRpe4oVt6G6opDA+G5HrkABGkZps+XpI=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA0PR12MB4349.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(66556008)(66946007)(8676002)(66476007)(4326008)(86362001)(38100700002)(31696002)(8936002)(5660300002)(2906002)(83380400001)(6512007)(6506007)(6666004)(53546011)(107886003)(55236004)(2616005)(316002)(6486002)(31686004)(508600001)(36756003)(186003)(26005)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eFE0U0NDVDI5N0lSaTBMWFBzZXc3eGR6RmhvUFVuZjUydit5eFdRRXIrUDha?=
 =?utf-8?B?Tm9EMEFQWUxKMytkVmJoZk9oc21tNXNBWHRwNE1NdUFsS0tUc3hsN0Zlcmwv?=
 =?utf-8?B?MFlGRG8vdktjbDVCd2FVMVNDZ3c5bksyVmlMWkR3aE82OU8vSlU2WTVJUGc0?=
 =?utf-8?B?SlJ1My9obElqeTZuaWhsU3hOMG1hSVdKdmJDYXRxU0xnTkRtYXlNV3hpMC9p?=
 =?utf-8?B?dDF1Zis3QzlCcXJLRmpncXZNaVc2WGdkWDJrWWoyTldZR0JZYzJXLzlMcmRx?=
 =?utf-8?B?bGFIdjZySzdTMzBBQ1pzWUhqSVdQWWVPZzVLNHZralZpWHlRcUxEekp0cTBj?=
 =?utf-8?B?V212aURtbmZzazRxR2hPOC9Hc2k1VWptc3hudktac2dQZGxVcllodCtXcVlO?=
 =?utf-8?B?b0FXSnVmMHRpQUMwUGZRaFNFQVM2OFZQWXcrZXJmN09vNHZOQUpTaDZZNDRG?=
 =?utf-8?B?MDRJN1IrRDVwek10VUJta1U0MGVvVWxvT3NCdzRXbmhFZmFJMHJIUytaWlAw?=
 =?utf-8?B?Ui82NmJWRFQ2SDBsUVNueW5JbmJvNUZEb2l2WGdMZWF2UFNscGRrTFhNTHJj?=
 =?utf-8?B?cFF5N1dKc0M1d21kajJiOFhkNnRXdVgzMmtVeDFETlpJc2JLYnBUbDg0YlJO?=
 =?utf-8?B?VWFzVFhkRWJQcVZxa1l0NCs4T0xGT0FJMWRUQTR1bUhjcmsrTUJhVHpPYWVx?=
 =?utf-8?B?MUxseW55YzI5QWFSbmw0YWZhQXB6ZElSRjV6elU5T2dyRHIzbHA5N0dmTGVM?=
 =?utf-8?B?SWJzQ3F6aEkrQkkvdlNxWTZ4RklyelVQUThmTHkyRkpXL3lvMU5tbzVTbldt?=
 =?utf-8?B?eGcxbjgwM1luSzNaeExkU2R1aG9JODNsMFUwdnhVU1o5QkZxUFdQSmhkc0pJ?=
 =?utf-8?B?d21mbDI3VjBQWHp3WVFRWXcvVGl1dEkvUEFqVUI5OEg2aFFpUSsyenh6SGVi?=
 =?utf-8?B?OGRTRXpsUmlGOWZZeUNkQUx6ZFRCRUMyMkpHUU1PbU04czM3L0Y2WEdiNG1z?=
 =?utf-8?B?TlNFYlZNZVg3d25Fa1ZwNkQ5aURKSWN5dVp3NHE3UENaelhWcW54cW13KzR6?=
 =?utf-8?B?ZFdHRWVEYWxya2tzckJEaHFHVUNmQlhNR1dBRGJNL3h0clBCbjFCc2d5QWxa?=
 =?utf-8?B?Zk5jWlBGM2taMnJGaFJtRnFTNVJnMzJhdUhjK2lVY0ZrbzdFeTlSZ2pLaHI2?=
 =?utf-8?B?ZFVPOG1Wb0ZWYitYTmpwanhXVWcrTjk1TDNKSWdDaEw3S0dJNU5Ub0h3K0s5?=
 =?utf-8?B?Q2h5MEpkZDduS2lwQlg1N3BMMzkrQmkwV29ITzlxdit4cDNIMGFoSXdLYjhG?=
 =?utf-8?B?K0dPNVhkSlMyTjNGL2p6MVhtY3Y3cUpLNzgzOEZWOFpGY2plT2RGSUFRbEJt?=
 =?utf-8?B?djZPcDZaUUVJcElMWkR1eG9SSE5ob0NWTjgvVHdWNi9tRGFhekRSdFZSL2p1?=
 =?utf-8?B?dmxSS2ZKT3hxdlViN0R2ZUpndDd0akZneFpWWmU2dkZ0OHgvZ3Y1Q0FBbmNq?=
 =?utf-8?B?TEhqRlBJSmVEMy9kZnZzVTYrVGpleHpZMlc5aDhZT2J4VzlhaUZrNTVaaENk?=
 =?utf-8?B?eUlFTzFRWFB1N3dycnRFclVrQ2liL3RyYUQvRWFtcllIMUZyYXgxNk8vUlVF?=
 =?utf-8?B?UUp2QkpacUhIRXBDODVqbnlLeFY3V050ZThPU1hPT0t0UFVVMFMzODFVb09a?=
 =?utf-8?B?UngxL0dNdGlLb0V4MEFZSFNkelRZTWRNc3Z5S3dtWGEzVmRzN0ZIWmYrMWJ3?=
 =?utf-8?B?SzAydy8vRTFXMWduaktrWFQ1UE1HQnU5ZFlHSlpUS3dyOVBFaW9pYjNlend6?=
 =?utf-8?B?MUJoKzlyZnVrWnBwS0dLWW5GWGRKTjg4WlJzTkIvY0hkUTY1TENwaU5xL0h3?=
 =?utf-8?B?dmhNNEZPS1VsL3VIMHNHRGc5dU5weVVzTzVpU0RwZWNOSmpzNDFCdFgxSXdE?=
 =?utf-8?B?QUQ4YlpmeXdTK0ZuMjExNEtBY283MDBNekJYVndVUC93cGpqT0JyTXlBZ3Vu?=
 =?utf-8?B?R1pOUHZYMUprOUlkcEo2NHJrNjBMMmlJNklDbjcveDdTVFhxNG1GUWF1OFZx?=
 =?utf-8?B?ZWJDMnZrRUxJcnBBeEFjMFE0Q2ZXNlBWVlFodHBGZlpPSDY3VmxFZ3Z1c2la?=
 =?utf-8?B?VkNUV0pUdHlhNkFtZzQ1MjJRclJMYWs2NVdSZDdseHVvWWRScnZ3TEp5RWth?=
 =?utf-8?B?UitmdkRXSDRibHFmdjJIL3JBbmIyV0o3RmphOGRIZHU0T3pxTUYwdWRmd2R1?=
 =?utf-8?B?N3JwYUdvaTM5b04vcURvdnNuUnQ0OGMydEw0Um5sZFBZejBjek42RTlxem9H?=
 =?utf-8?B?RnIzNWpPZ1dZeDd0N1NtYjJTUXFIYk96YWppKytMSXZRTWROSFl3UT09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7153da23-cd45-4d8c-ac72-08da1b8301d6
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB4349.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Apr 2022 06:17:51.5932
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Z9RrqrXOsXEyH1zGy3Pa+BIZ49B5cf2erQpT/mRoU7Dj7ZePYPyAUsQ+jvo0Aj6XWdWxIemn1F5ePhcS4GFNWA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5164
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/10/2022 8:25 PM, Dmitry Osipenko wrote:
> External email: Use caution opening links or attachments
> 
> 
> 06.04.2022 08:24, Ashish Mhetre пишет:
>>        /* clear interrupts */
>> -     mc_writel(mc, status, MC_INTSTATUS);
>> +     if (mc->soc->num_channels) {
>> +             u32 status_chan_bit;
>> +
>> +             mc_ch_writel(mc, channel, status, MC_INTSTATUS);
>> +             status_chan_bit = BIT(channel) << mc->soc->status_reg_chan_shift;
> 
> s/status_reg_chan_shift/global_intstatus_channel_shift/
> 
Okay, I'll update in v7.

>> +             mc_ch_writel(mc, MC_BROADCAST_CHANNEL, status_chan_bit, MC_GLOBAL_INTSTATUS);
> and maybe add a one-line mc_channel_to_global_intstatus(mc, channel) helper
> 
> mc_ch_writel(mc, MC_BROADCAST_CHANNEL,
>               mc_channel_to_global_intstatus(mc, chan),
>               MC_GLOBAL_INTSTATUS);
> 
Okay, I'll add helper for getting status bit from channel and use it.

>> +     } else
>> +             mc_writel(mc, status, MC_INTSTATUS);
> 
> Missing braces after "else", "./scripts/checkpatch.pl --strict" should warn about this.
> 
I didn't run checkpatch.pl with "--strict". I will run from next time
and address this.

> Otherwise this patch looks okay at a quick glance.

Thanks Dmitry. I'll address these comments.

