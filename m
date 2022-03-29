Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 582EB4EA948
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Mar 2022 10:31:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233963AbiC2IdU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Mar 2022 04:33:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231682AbiC2IdR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Mar 2022 04:33:17 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2044.outbound.protection.outlook.com [40.107.236.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0002769498;
        Tue, 29 Mar 2022 01:31:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CkecLf1qr5jhSnIFglFe9CLNuUWDjXE9OAQHsVXS1gz2lZ6jD1GNqwew5qsts8EB9CxCOMbGwGJXJgyYlc4emW59tCHLXIX9pmmDdEXi2PCzDcorpdGqfT9VBJNsHwLnPPCskHcuQSWSfGAU8AYPtzfRF6+ja2GVyBx4VGXM+oqv1ABNx2I09Kr2mPrfV02PBGSbukcYemI5y0+qJG/3BEsIOYf4CHtIB8zcFMi21JQRI9+MZI9I+lJq0dgv78YP/yar6GDDRkcu/qU7/zfnLhnCPNIKKL17KOhArV/zcatl0J3W06x8h7jG5sl304tq988Q5cjy/GhT1Lw7OLFOCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wmtO6gaJPWpn5FyHdTGG0+CPHi3zhFNWhKm1Z4ymczI=;
 b=GFPO3O+TPctqC7Kk4+lXRqf1Ub7ACPSsnwndEPk6sqjG4k2LH/gItDwKIc2LU1ME8qXgEoc0UKB+WZfoIWvOahYqmxBH+MBIl2BY8v0lleGPiJgKvuR9pTJKH/kanaEF9RbOuYH3Ac4wunEXlMxPxs8RCsJso6goCMzqq/seeo+F6f6pYFZ0Zace8kzMp4URirlpgUc0mz0/UNt3MhwfAWh820ZXA6QQAkY9MYx0G4P8fj7N/2UsCwTSiIE/q6QJUuAFpULcxnHje/FPPFv3x7vZ6yqOtPgOnBxvvK8ttrgYdSfcmFQf8CODSAcMg3UaTotgD1IGnZH7kiqmowZQ9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wmtO6gaJPWpn5FyHdTGG0+CPHi3zhFNWhKm1Z4ymczI=;
 b=UbVoIsCgOHzjXfspqkMyW1KXD5WZqYPJC5WECwGWEBpa6gjrqUOQuSfZIOeQsMkgW0c6ssRQ+d1LCZG2E26fiCjtVzXeVWWZlqZxHQh7Su8DEGJNGYn/aasrNWLfSrRgJiMx3QtmlTyMr/IF3pP/GV5x/on271BjjublwvaGCAYEZ3pazNPqAgr0GeagwZ1DSiZnvPQp4aNjrw78A3ZLu7vZmG+kqLAWs6C1lghGT2yq9PbmzgzRRbfnpTCNtZlV6zosRKFHdAIOAoZvpmnnclUJNHxyRt8mAEuh4exEF7zxMFbaqzof0WFEvxzrIZJ0cuf6HMjYwKJs4UrDyrx8Nw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM5PR12MB1579.namprd12.prod.outlook.com (2603:10b6:4:c::21) by
 BYAPR12MB2869.namprd12.prod.outlook.com (2603:10b6:a03:132::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.19; Tue, 29 Mar
 2022 08:31:32 +0000
Received: from DM5PR12MB1579.namprd12.prod.outlook.com
 ([fe80::55b6:14a1:6fa5:3955]) by DM5PR12MB1579.namprd12.prod.outlook.com
 ([fe80::55b6:14a1:6fa5:3955%11]) with mapi id 15.20.5102.023; Tue, 29 Mar
 2022 08:31:32 +0000
Message-ID: <dadc2846-38fa-c169-5dca-55bd5cbfd39d@nvidia.com>
Date:   Tue, 29 Mar 2022 14:01:15 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
From:   Sameer Pujar <spujar@nvidia.com>
Subject: Re: [RFC PATCH v2 4/6] ASoC: soc-pcm: tweak DPCM BE hw_param() call
 order
To:     Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        broonie@kernel.org, lgirdwood@gmail.com, robh+dt@kernel.org,
        krzk+dt@kernel.org, perex@perex.cz, tiwai@suse.com,
        peter.ujfalusi@linux.intel.com,
        pierre-louis.bossart@linux.intel.com
Cc:     oder_chiou@realtek.com, devicetree@vger.kernel.org,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        jonathanh@nvidia.com, thierry.reding@gmail.com,
        linux-tegra@vger.kernel.org
References: <1648448050-15237-1-git-send-email-spujar@nvidia.com>
 <1648448050-15237-5-git-send-email-spujar@nvidia.com>
 <51c8d2541ccff2689b9164ab9b671b0b2514e65f.camel@linux.intel.com>
Content-Language: en-US
In-Reply-To: <51c8d2541ccff2689b9164ab9b671b0b2514e65f.camel@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MAXPR0101CA0027.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:d::13) To DM5PR12MB1579.namprd12.prod.outlook.com
 (2603:10b6:4:c::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e89d693c-576e-448d-20ca-08da115e8784
X-MS-TrafficTypeDiagnostic: BYAPR12MB2869:EE_
X-Microsoft-Antispam-PRVS: <BYAPR12MB28695864AF7F44278648D30FA71E9@BYAPR12MB2869.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NgU+ZI54fP4BFjft2nlUPWRlfQSvArOpIURItBhcegBx+zPsVqmyEu9RkN/9eHbzRKSbgP1V+LIjbCtIEI3+P75KX7ArqdFwyGbi9WlGhiZBq6fWnz+8OveA8zRoNnSuKF5psfYOlYFDdGLrI+meNw7tTWnxg3pL7/nGFbbnWUWwGQ8456zET2iUFgPWF2q7Fam6IeqTnP01DIZXf4+7+Vy6tJdiGDXP8QPS5af9hjqVTtyzJ33Ogz0jWfCTU3QoASiJo1JXRD3XGBO7u8mMJJuMhhcSSCJggViyqw3ELPvCXmp6YYRwzhAoCvvHw+1cqapyHtlG2JzmaQvp9z6qwybu5iulTOcVQnggYqX++kiOrT+DbUwRpJZmrneJjYNVecZEgIlK1DZ/O4dgIVIRxqwVJkyGG5H+x7MiaFa4RPVp38RyUBpwiOYZkPmP7I0KKsoCr72LzF/vK6gcs6mMj7BeHpoGvor5oBBipdWl48tef7EFNqJ7FP49W0SsjxNN0+zB3JfrsuGWhhJeZ/Rp96cUYCJwmrjDC8SpUNz2P2Vr+YD0rnMhODCFrEdOoQMPUqL6Xt1VCjtW5TDnLUb9rIfAkkDh7uE1jxkgUrfSvNQk+MvErvZAyO6rkfYQa2WG1vvpPwlp9AXeVBGWkFo9TcO8Ci6J5sz2JB9+8nEv/WOWfIz/YsiYyVJu1App09WGsvBtrsSBheqJvTEPp0B24YRkhhcd170b6nOuyIFMRA4=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR12MB1579.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(2906002)(36756003)(316002)(66946007)(31686004)(5660300002)(6666004)(53546011)(8676002)(508600001)(6512007)(4326008)(6506007)(7416002)(6486002)(8936002)(66476007)(66556008)(38100700002)(86362001)(83380400001)(26005)(31696002)(186003)(2616005)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VmNXRWFuT0hNREpKYTh1eFpCcFpoQnVaZFhwSWNKbkJVd3RPUVFtSnFhejIy?=
 =?utf-8?B?NzVYVGl6Ymw4bFJmZkNMbmVTb0RWaExZODQzOW85bjk4YXNJVlptcjVRZzAx?=
 =?utf-8?B?ZWlGc1Z0dEdFOTlRL2tHa25xeTg2UmVYL084N2VCTHFTbHRRd2QxbE1BVk41?=
 =?utf-8?B?d0FEelk2TE0xamxLS2pOS0FLcXRLd1RUblRLR21yU1BaRG00bjNVWmxWaW1U?=
 =?utf-8?B?emNmU3FGR0FsVndHYWJPYlRBV2RGcXJpUmMvYWpJblNEeElJSTJyVU0yYStu?=
 =?utf-8?B?WWtGckR5N1hYWUk0Z1pkWGEzSWl3NjByVTl4aVpOOGFiQ0Jib3BWUk1QazNE?=
 =?utf-8?B?bFRIdFdvTmdEcU5neEUwUFM5M21Oa2p3YUtvTmVCNGxQcTJUS0V0bjZ0K3o5?=
 =?utf-8?B?cWZzTHlGT2tCcjdVaUVjSk1oSVRFQnN5T3RaSmtjTTRqc1ZqLzliU2xzbnVt?=
 =?utf-8?B?VW5vTXF1ZkQvVmVFeGlPamgwM1l0azV0NFRuUHRWQ2J3NldDQVB1RjRWTW1l?=
 =?utf-8?B?STBaVUJmdDNadmZQSTRjR1FLLytFeFJJZGovQXBRcmNrckx0YkVTcjM2a1V2?=
 =?utf-8?B?VTkxcjhwSTZKSGx4TklKSGlnSTR6NXNhc3BVQnU4ZU1TZFlCeUNCYVBjQVZZ?=
 =?utf-8?B?TmtXY3dpTlNxSVFBTUtUL0sxdTBsQk1iRjJqZ3NIa3I1RnZhWElLTmdETk1a?=
 =?utf-8?B?OTRORS84YVQzQk8yREZWYUdlODZlR3o3VVV5dk0yeWN0SlJ6QjNuT0xjTndM?=
 =?utf-8?B?cjBsYmVUWnl3RG5ZSVpBT1pSTWp2K1JHbXR5SzBXRXNkUng3d20xV25EVnht?=
 =?utf-8?B?OWJ3aEZLNjRZTTBteXpoaTdpQzYzcnNsVlNWbS9ySlpSWGl6M25BWlYwTmVP?=
 =?utf-8?B?WHRhL2wwUnJOMTh1dW1KTlRGcjNIL1NkY2tZQmFNN08xNnNWaTM5dUF1WWl5?=
 =?utf-8?B?TFRFaWlXdzNkL0JaaGMzV2h0dDJndzBnQzVsZWFteWE0ekEvR0JRbWNGeC9I?=
 =?utf-8?B?L1kxUm1xZjQySHc2L0ZZckVxZmtpNTdJMitwbEZRSDd0bFFDMnkzSW56Rnk0?=
 =?utf-8?B?MEFKaWZhTTI3WlBMYzJsbW9EdjZQVU8rcXU4djZLMHA4NGlqaUoxaXAwOVBH?=
 =?utf-8?B?ZDkvQzVWTTAzbDRQVFlVcXV2eG1IVXp1Z0Fydzd1emxCMmYzRHNmZGp3YmxM?=
 =?utf-8?B?eWhMclBCVlJVdnErWmh2NVdTdFF6ZmZGNS9TSDAyZEhlaGtld01WdVdpOFBt?=
 =?utf-8?B?WjM4aUZTdXl6eEM1dDFCNEZsL1hvOWJxR0trYkVEandBc1ZWYzFId1NMTFVC?=
 =?utf-8?B?TncxbGtqZUF1NlE4UkpzNk9ncmJINTdKZjJ5OXJwN0Rvazl4dGxjTUVVMW1w?=
 =?utf-8?B?NE02STRQRldHeVErUDNZN2lVRlB2d1I2STFKNFRPMlNLVTFqU0dUN1VENEdZ?=
 =?utf-8?B?ZXVMTlRhMzFsTE0zNGV4ZUNuWXR0bDRXM3M2cnJxYjdqWmo4dEtHcHNJRnNG?=
 =?utf-8?B?VXlaTEhaRzRTQS93UzRZTXNpaW9vMU95enZ6bzlpSEFmeXF3Nm04bW5nWWU5?=
 =?utf-8?B?N2VlQVJESThraHo2Y1VHUDhsZ0xVeExyZnpNbTZuTDFhMGo3aC84TXhMSGJO?=
 =?utf-8?B?YjEyNXlIU0MwY3JZdmEzK2ZwZGdzVkQ2cVA1bWJHNVBrNGRWcFR3U3IycjRz?=
 =?utf-8?B?MmVHTm5Qd0k5dktSaG9OcWhrYzA1YnUvUm43QXZMTTVMbnF1RUxKWmhya2JF?=
 =?utf-8?B?YjJKeHBLMFFQTXE3amhUVkRHaytGR3NiYW51dEJaVDZ3Z3NBZ1c5UnRuNnBQ?=
 =?utf-8?B?bnJWWDhscE9Cam14L2lSekNYb2NpS1FEb3dHM3hqNmg3cHNCZWlKMndKSExG?=
 =?utf-8?B?UDB1dzN1MXlST1Q5TDNPK0xZTm1BZDAwRmFyZzFjR2RaWDhkOGFVT3dBYmZx?=
 =?utf-8?B?b3hxZnU4Z0VXY3Y4WUEzSEZjYzRlL0svdEY5OSsxR2FWa1ZrYTg2aHVTc1hZ?=
 =?utf-8?B?RXB4dEUvc25FbXpsTWI0SDRDTE5FYVdHSjE3d3NiYi9nL0RLeVJuMERwTi9v?=
 =?utf-8?B?RWdLRlJFbzV5MFNaTWQzbFkzQjBHdXNoOE1FT2Mzd09hRnRqMnQ4bXd0TFlR?=
 =?utf-8?B?b01GM2VvWk1aclg2QVZiZWYrUDNsSHg0dC82Z25mclhvOWhkNGpvNmU4Wlln?=
 =?utf-8?B?US9LbCtXYnRqNXFPRkFHY1dTaUhiV2pZalZBWTVmSTJBRkY1MmtSWnNNb0Jx?=
 =?utf-8?B?cjgrcGJJSHViNkhSL2JKMyt3OUo1bGNSV2RIenpjMzZiVmc5RDU3Z3JaaS9N?=
 =?utf-8?B?TGxDNlg3c1BSWEhIY3FubTZ3Q1J2ZFVYQjNmTWxDSnNackovTDhXZz09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e89d693c-576e-448d-20ca-08da115e8784
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB1579.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Mar 2022 08:31:32.8277
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MV8qLhynRE7qxp2xRKQ2agIgjlugYQ0DwXCKbtLV3hQsJIJODzNcZy5gEzWJ/TGResYQfZ+mdVQ56/O1K+MyoA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB2869
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


On 28-03-2022 20:59, Ranjani Sridharan wrote:
> On Mon, 2022-03-28 at 11:44 +0530, Sameer Pujar wrote:
>> For DPCM links, the order of hw_param() call depends on the sequence
>> of
>> BE connection to FE. It is possible that one BE link can provide
>> clock
>> to another BE link. In such cases consumer BE DAI, to get the rate
>> set
>> by provider BE DAI, can use the standard clock functions only if
>> provider
>> has already set the appropriate rate during its hw_param() stage.
>>
>> Presently the order is fixed and does not depend on the provider and
>> consumer relationships. So the clock rates need to be known ahead of
>> hw_param() stage.
>>
>> This patch tweaks the hw_param() order by connecting the provider BEs
>> late to a FE. With this hw_param() calls for provider BEs happen
>> first
>> and then followed by consumer BEs. The consumers can use the standard
>> clk_get_rate() function to get the rate of the clock they depend on.
>>
>> Signed-off-by: Sameer Pujar<spujar@nvidia.com>
>> ---
>>   TODO:
>>    * The FE link is not considered in this. For Tegra it is fine to
>>      call hw_params() for FE at the end. But systems, which want to
>> apply
>>      this tweak for FE as well, have to extend this tweak to FE.
>>    * Also only DPCM is considered here. If normal links require such
>>      tweak, it needs to be extended.
>>
>>   sound/soc/soc-pcm.c | 60
>> ++++++++++++++++++++++++++++++++++++++++++++++++++++-
>>   1 file changed, 59 insertions(+), 1 deletion(-)
>>
>> diff --git a/sound/soc/soc-pcm.c b/sound/soc/soc-pcm.c
>> index 9a95468..5829514 100644
>> --- a/sound/soc/soc-pcm.c
>> +++ b/sound/soc/soc-pcm.c
>> @@ -1442,6 +1442,29 @@ static int dpcm_prune_paths(struct
>> snd_soc_pcm_runtime *fe, int stream,
>>        return prune;
>>   }
>>
>> +static bool defer_dpcm_be_connect(struct snd_soc_pcm_runtime *rtd)
>> +{
>> +     struct snd_soc_dai *dai;
>> +     int i;
>> +
>> +     if (!(rtd->dai_link->dai_fmt & SND_SOC_DAIFMT_FORMAT_MASK))
>> +             return false;
> Is this check necessary?

By default the link has "SND_SOC_DAIFMT_CBC_CFC". When no format 
(I2S/RIGHT_J etc.,) is specified, the links are mostly internal and the 
normal order can be followed.

>> +
>> +     if ((rtd->dai_link->dai_fmt &
>> SND_SOC_DAIFMT_CLOCK_PROVIDER_MASK) ==
>> +         SND_SOC_DAIFMT_CBC_CFC) {
>> +
>> +             for_each_rtd_cpu_dais(rtd, i, dai) {
>> +
>> +                     if (!snd_soc_dai_is_dummy(dai))
>> +                             return true;
>> +             }
>> +     }
>> +
>> +     return false;
>> +}
>> +
>> +#define MAX_CLK_PROVIDER_BE 10
>> +
>>   static int dpcm_add_paths(struct snd_soc_pcm_runtime *fe, int
>> stream,
>>        struct snd_soc_dapm_widget_list **list_)
>>   {
>> @@ -1449,7 +1472,8 @@ static int dpcm_add_paths(struct
>> snd_soc_pcm_runtime *fe, int stream,
>>        struct snd_soc_dapm_widget_list *list = *list_;
>>        struct snd_soc_pcm_runtime *be;
>>        struct snd_soc_dapm_widget *widget;
>> -     int i, new = 0, err;
>> +     struct snd_soc_pcm_runtime *prov[MAX_CLK_PROVIDER_BE];
>> +     int i, new = 0, err, count = 0;
>>
>>        /* Create any new FE <--> BE connections */
>>        for_each_dapm_widgets(list, i, widget) {
>> @@ -1489,6 +1513,40 @@ static int dpcm_add_paths(struct
>> snd_soc_pcm_runtime *fe, int stream,
>>                    (be->dpcm[stream].state !=
>> SND_SOC_DPCM_STATE_CLOSE))
>>                        continue;
>>
>> +             /* Connect clock provider BEs at the end */
>> +             if (defer_dpcm_be_connect(be)) {
>> +                     if (count >= MAX_CLK_PROVIDER_BE) {
> What determines MAX_CLK_PROVIDER_BE? why 10? Can you use rtd->num_cpus
> instead?

There is no specific reason as why it cannot be more than 10. I mostly 
thought it would be a fair assumption to have these many clock providers 
for audio paths. I will check if such limitation can be avoided. I 
cannot rely on "rtd->num_cpus", since in my case there are two different 
rtds one acting as provider and other as consumer.

