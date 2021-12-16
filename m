Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E10247719B
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Dec 2021 13:25:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236205AbhLPMZF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Dec 2021 07:25:05 -0500
Received: from mail-bn8nam11on2048.outbound.protection.outlook.com ([40.107.236.48]:61665
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S234229AbhLPMZE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 07:25:04 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AMqn81kqsQ6FcfiJuE3Hjq6FKAHuIz3hn9YZvQdS/wUzsl/dJqvOQ8DvEP8Qn/epfvLlVgETngipZGNfn96K5WeOrvwCqLqCFdh2+gsMa8+tuvivNj/Duwasd8fDkCuHSUHmrQ+F0CpNqHkvx6OBuMoasRH28yfgQB0ZJ9XbdorZUf9piEtuHZdhxy48bINrB667AOeeu3zyfI3Q54eo6H5AfwoXvmyvG0EPjFyCp16A3gcguCbF4amtoVSkhebyxRfsqoWJv5cWpCGZ9M2s9YLJpL5CcovexoineZ5gRCE3Te3ro1X/4Yc1443hl0m2Wo4IJeWcEODBM1RL2btwEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c3NF4ulhFoqoQW4PXvPB1LbyWMSTUUs7MXwhRMx1v5A=;
 b=VXP1t+Lgd3dCMB9xS+8c52fvX1FA0VO2RbWSCUFHHdFK7DpmXZEaxinmOUXtgfMZg7aOK0nulP6MM6oA0DiMVNpx0tIp5HDHISwkOPsRy0R/+62CSWUwW4xTKcSOTMgXx+K3fcf0ULuZ/OItZcTMtxUQwvQABPzYgx1tPkreRaYjxEog/op+2I8dYX6WXyPpjozKjSRSUY1Kgozwfm4+Gs1X06mzEjgfdRAqkegWtkjKGrGpf5KouhtSPimC7xqjb9DgIT65h516qds1AoMUUvynQAPnBROSdXJhlWlAwc11AY2mo3FUeyyZLJDWOm7PTTrMn1ZMgaw2GTbKqE8LuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c3NF4ulhFoqoQW4PXvPB1LbyWMSTUUs7MXwhRMx1v5A=;
 b=URK6dzrySNg4wQ0MZeJcOcxxBcEBaASRNCmlnULZ+vB/nfvXKHOlGyx0ZItGxzsZykioHPtrlMGZTqE6ke9pYGDvZmFy5Byg0xKaKdTVzJRbY2QTV6a7ZFR47yfWuJUfkKzMwGCd02pzR7JbioLf+TSVrgAlMTGear7wNwLnw0o=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3627.namprd12.prod.outlook.com (2603:10b6:5:3e::18) by
 DM6PR12MB2681.namprd12.prod.outlook.com (2603:10b6:5:41::30) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4801.14; Thu, 16 Dec 2021 12:25:01 +0000
Received: from DM6PR12MB3627.namprd12.prod.outlook.com
 ([fe80::2437:1c64:765e:2fb6]) by DM6PR12MB3627.namprd12.prod.outlook.com
 ([fe80::2437:1c64:765e:2fb6%5]) with mapi id 15.20.4778.018; Thu, 16 Dec 2021
 12:25:01 +0000
Message-ID: <3ec805fc-07cc-6091-551a-771dffe459d0@amd.com>
Date:   Thu, 16 Dec 2021 17:54:45 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [PATCH] ASoC: max98357a: Add mixer control to mute/unmute speaker
Content-Language: en-US
To:     Mark Brown <broonie@kernel.org>
Cc:     alsa-devel@alsa-project.org, Vijendar.Mukunda@amd.com,
        Alexander.Deucher@amd.com, Basavaraj.Hiregoudar@amd.com,
        Sunil-kumar.Dommati@amd.com, Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        open list <linux-kernel@vger.kernel.org>
References: <20211208185850.1555996-1-AjitKumar.Pandey@amd.com>
 <YbETxcwa83U8WXTO@sirena.org.uk> <YbEYVq+uvIcoxqko@sirena.org.uk>
From:   Ajit Kumar Pandey <AjitKumar.Pandey@amd.com>
In-Reply-To: <YbEYVq+uvIcoxqko@sirena.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BMXPR01CA0006.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:b00:d::16) To DM6PR12MB3627.namprd12.prod.outlook.com
 (2603:10b6:5:3e::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: eb6ddd03-2078-48fb-4aab-08d9c08f148e
X-MS-TrafficTypeDiagnostic: DM6PR12MB2681:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB26815492D57703419DC19CE982779@DM6PR12MB2681.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OmuLmvo9f/wAPDyoAsRqzQ+vp2jFlw7lPAdRFwbRJdgpNsWq036KQdh5r8H5vIWRaySNPjf0przegZ2twyakHZJjF/VEGH1iW/+0mCOuACcLYGdqdBYuwPTooliY2BB6kEuQq/VgC3elmh2XxYhywmedQ54uUtOZswz8Kcd91SDWyV2V4Rj5chCgJSvEPMYm4z5KSIPVBaTYkMd5glrBLdFxx45iUms/YaqOFMpekJp78BNA97I6aRPEvgbzPUfakJH//DZ9KRGShjb35ASabcEuRQ4r43B8nDWk9mVluQPzZXAZsXo6MDWChIqXhVN4rlHH9rEc9jEq++nVaegOCat9DlztSl5J2aRq2XbOk97b7gun1XvF8qb4AbsvnO02hMfrCPzY89uq+MdJaO7bBxfXOIKa1J8YW4DCFj7rmlQmCepEQAxGDAv9ZkVaNu+Hs8xq1x1gg8BdzxeWhXrBNxkDPnLmHu+1pCLrIzgCjyYRCRvVADsds+GB0a1KUdz6rDuI99WV579cEEg85FWx6Dy7Sj28po4am5JGwuXBGwiqPajUYuuzZUuVBawViNlnFYD0A7Q9ef5pe0fwsIz27CJTvNqCKj8XNYal9NqVlc67LIqZG2JVFP2XvoHuzcQ2m+CAtZKoIuiCnwPtbN/apkNddeJIVj99+ZIv1VmAHBZy1dBABwUqzDGQqDYHSbo7/tlh/o8TfNHsgJGLMD/+5v6Q6iIJPExpbqRibFn3qG/p5DeIyhMyD2E1ox2A8zvLfQ3BsfNyXpNUspd3zzxpDf5cyOIMeLSmCDwGZNheYWCqinGrFPmM88Az84beJVnB
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3627.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(66556008)(26005)(966005)(2906002)(5660300002)(6916009)(66476007)(508600001)(6486002)(8936002)(86362001)(31696002)(2616005)(8676002)(6666004)(38100700002)(66946007)(36756003)(186003)(6512007)(54906003)(53546011)(6506007)(4326008)(316002)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SzBMQkVSNFlTdzZjREowSk9KSCtBQ0tOdWxKai94dlhpVzhrVWR4b25YeUJ0?=
 =?utf-8?B?RGpNZm1ZZ0lMazluL0Z3RlhpeVJYUWtGSlowMkp6MllxT2VGcVJwcFJoVkVt?=
 =?utf-8?B?ZWRsMW91bFlta0dGUFBVWDNLQlRlc1J5ZTk3MEVxbCswZytzVytFUmJmbWtx?=
 =?utf-8?B?SnVPVXRKZWRWVG85SExNZFR4WXMwSGpBOXFrZzIrbS9meVVDdy9lZ1BZSWtW?=
 =?utf-8?B?UCs4K2U2N2hSWG1jdkRrNitKNnNSU1d5c1g2RStaRnd1TEpWK3pmbWFwdno0?=
 =?utf-8?B?RGZzZzEwZFhoVEt4YnNZcS9xaXBMdzVINmF2dGpZaTQ3blVFYm92a1dTbnhu?=
 =?utf-8?B?Y29CZ2R1K0IvcXhXSTlRWDY0blRIVTdtYUh4dFcrdkQvekNiZGlHaVFlVm5z?=
 =?utf-8?B?eXVCZDdYS3FrQXBuMHl6eVZvVDhTZUZtM2tqYnczM1A4NmlSWjJDYk5jaGZD?=
 =?utf-8?B?TTZSUWpOMGN5Z2czb05ITFl1ZDZNRUVPMUJ1dlVOb094Si9OOW5OU3VwNGFE?=
 =?utf-8?B?OWNyb0FwaUdZaTluOVZDb29Hb0VJajNBdkQ0MThxOXhybUVLZTRkZmQraUpr?=
 =?utf-8?B?VldlUURBcEx1T0dvZjh4RTBOeUIwanY5dHdrSjZzOXNDMFROakZidzRJdjhv?=
 =?utf-8?B?VlBlelZMYXpZWlROUDNlUkdoaW1iNVVwcStlRllrcFVoU1NUbkswenA4OFRN?=
 =?utf-8?B?ODJTZW9XSk5oWjY2RlNmekY5UW9HUDBaWEVOOUhtUmFNMjAwSnJHNTBkN0Rk?=
 =?utf-8?B?SkdJelVpdGdSZ2xmeWhUZ1ZWS3ZIa3NsT0NkcTlMNFpNL1ZVMmtzWUx2Njdq?=
 =?utf-8?B?L1ZZSjRVZXVZZGdrN0R2ajVlbVFmdmZKbU1IaHZ6ekt4U1BYTVpicHVoSlRu?=
 =?utf-8?B?MXVKVVFpbHdhWW1wYSsvS0lscEtaQk8xaHZaZSs0ejVDL0NEVGZVaWlnVVdl?=
 =?utf-8?B?b3FFSXMraURIM3RVbzhFVnFxMXNVanZ1R0tBT04zclRJU0xyZHhWaGZkWG5V?=
 =?utf-8?B?cGxZT29NcEFlakM1YmEyVDY4TEhlc0FqTW1QWGc2L0dhWjVwRlNZcTZ0SThL?=
 =?utf-8?B?VlNJYzJkeW44WEdhUU5vaHZWMGdtQTZheGgvSXR0VGxLMzVxbi9vYUd5Z2JD?=
 =?utf-8?B?MW05b1hLMkhxRjZQRWM4cnlndHYzRnhjZWtncHhlZi9vQjRSL255aTVXdEZh?=
 =?utf-8?B?bnV6YmI2SFVVbjFWNWh5cVloU2xwdlVLb1cxU0FuaS90VUdEaWNSOGVsM3V2?=
 =?utf-8?B?STJjZDdsQm1GQ3ExdlNtdFZ3Nk8rNXVCdkpXa3ZzVWJBdzE4bVpJNzNPK2Nt?=
 =?utf-8?B?ZTloUkNiQnNZc1hXc0NlRXh6VFE0Y0hHem8rNUxTZE9HTTVUMzNuRmtralBF?=
 =?utf-8?B?Y3I3ZjJISEdjWmtRdGhscjh2dDB2cklIYStVajNvU3lXaUdybFRQSkU5U28z?=
 =?utf-8?B?YVhqQnZGWStMdWNpMXFpWXVkK2VTV3FlbStQOHUya3grUFdoVG5KSzJ0VEdO?=
 =?utf-8?B?VVlZem5HWkpYRnlFRGRVTVZlQlRaMm9JVGlNNGVoMmpRcnpaQlkzVEd3ek12?=
 =?utf-8?B?ZXk4MmhBcTdRM1FqOTdUOHc5Qk1YRWp5d0pXMEMrZU9WaDIwaEtCUkdmRlFz?=
 =?utf-8?B?bzhmSmdWZE5XOXVvakVMYktBRE9kUXhwV2srWDZML3BzVjZzb0RZSTU0dE1t?=
 =?utf-8?B?SDlXZUt1OUl2T2drN1FKZEMzdTRDZGhLckdVWFhkSndhcjlMdkM5Vmh5Q2Yy?=
 =?utf-8?B?cUVNdTNPay90N0pteFdka0tzcUVpc3lIbTNqZ09lUi9PeUdJTjBxL3lvUkpp?=
 =?utf-8?B?OGlnNkpqUS95bXhUYXFjNTlINEJIbzljeTFOK21DYXJ0OVFaQTV3U3NJK3ho?=
 =?utf-8?B?R2ZaYXpuM1N2Q216bTE5R3hiOTd3d3JEdG85TTJYZjY2M1hwR2xJZW5SM2lt?=
 =?utf-8?B?TTFLU1RxL2NWMG5kZnJFVE8xZks0Q3FnMEhsZi9jVmVFb1JzNTRPbUhqYkpt?=
 =?utf-8?B?RTdvTy9IRExsU3VxbEI2U01RbEdmalRwNGwxVzJvelR2aGNkb2l0WTgzNWZo?=
 =?utf-8?B?ZTV6Y0Ntb0pOOGIrdXJEUUgwcTZsMGRUaVcwSXp0d2JkOXhTNFdoMStxemR3?=
 =?utf-8?B?L1BYNFplaS9rN0Zlc3NTTDcwallVa0FZdkVCQkhwSEUzMm5welJRUCtaN2Nl?=
 =?utf-8?Q?RUZzRfBdA9obF92DVG359D8=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eb6ddd03-2078-48fb-4aab-08d9c08f148e
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3627.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Dec 2021 12:25:01.0959
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: s0mzxR/mXJtxNV6Dgs6okkBbKCfwQoMA/8dlkTYVjMC0oSnELIQSMERpQ/evr0XsI+9rW04hpWqYjnDRSflKCg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2681
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 12/9/2021 2:10 AM, Mark Brown wrote:
> Actually now I look again the only control interface this driver has is
> GPIOs but it does expose a digital interface with constraints as input
> so doesn't fit within simple-amplifier.  However this is just powering
> off the amplifier to achieve mute rather than a separate mute control so
> it'd probably be better to use a SND_SOC_DAPM_PIN_SWITCH() for the
> Speaker widget to do this, this would also end up addressing Jaroslav's
> thing with the naming as a side effect.  Sorry about the confusion there.

Thanks for suggestion. We tried using SND_SOC_DAPM_PIN_SWITCH() for the 
speaker widget and it invoke dapm_event callback based on switch i.e 
max98357a_sdmode_event() but codec driver isn't enabling/disabling gpios 
in such event callback instead they are doing that in dai_ops trigger 
callback. In our platform single I2S controller instance (cpu-dai) is 
connected to two different endpoints with a single PCM device, hence we 
want to switch or enable/disable output based on Machine driver controls 
only.

Initially we thought to configure gpio within sdmode_event callback but
there was some pop noise issue reported in one platform with that change
hence reverted. Check 
https://patchwork.kernel.org/project/alsa-devel/patch/20200721114232.2812254-1-tzungbi@google.com/#23502085
So we thought of exposing a mixer control to enable/disable amp from UCM
in our platform without breaking existing functionality. Please let us
know any other alternative way if possible.
