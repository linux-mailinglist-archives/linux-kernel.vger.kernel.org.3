Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E67FE479A5E
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Dec 2021 11:40:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231700AbhLRKkB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Dec 2021 05:40:01 -0500
Received: from mga09.intel.com ([134.134.136.24]:33065 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229480AbhLRKj7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Dec 2021 05:39:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1639823999; x=1671359999;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=z5fOWF5wvY0dB4uobJDhQY9I2aumoUl1pyVlOoO/6SM=;
  b=VwZ6eWFXYyt+zs5YXl6icJQxb55DDb5eo4abwFtZOENXwP6rg7tfx+S8
   TL1cel2tnAFOq4+YJ5ZSXZVYSUIaEiehIGWNT0r2p27UgvlWrP79ieNev
   W3c9dWUoQc5BY59rNQTJWch8YFX7AaDJe2jvVXA9D/koDpUlhPgQHyYbd
   rnX8uUS9/sLFCNrQxI7IwCs3hjb2RH1epyv0ZpY2k8ctADjWy1L7EaAqS
   5hV6sXQgLOXcVMXz62KjAyAq+C8DaPNc7Iejows8B+++kstsEBxI1naEV
   IPKgNRdNxWz7CIjChJA3AJ/KiknAvQHcbf5V4SmDKb3gROxGQqO/iOohn
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10201"; a="239723598"
X-IronPort-AV: E=Sophos;i="5.88,216,1635231600"; 
   d="scan'208";a="239723598"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Dec 2021 02:39:57 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,216,1635231600"; 
   d="scan'208";a="606154122"
Received: from orsmsx606.amr.corp.intel.com ([10.22.229.19])
  by FMSMGA003.fm.intel.com with ESMTP; 18 Dec 2021 02:39:57 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX606.amr.corp.intel.com (10.22.229.19) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Sat, 18 Dec 2021 02:39:56 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20 via Frontend Transport; Sat, 18 Dec 2021 02:39:56 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.168)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.20; Sat, 18 Dec 2021 02:39:56 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SuDMmdQNrmqIqXVQHTE3bCSj3yadW/g0iSqGGGwnwse7TmsNoUPMdcmtvlyKRVO6iprBxbEiM0grfi1NVUJmP3DMzTokkXNbM3VoLgWnPKJgrbAUVW/abBZ+HN2Hokr6sVGSRar6h9I2WTcTzPNOgAKqbz/rwwU0FCiDnNbGlcLyCqPQpTLCQylBB/8atRN+ugMTCHJdl6e0Yd3cGB3SVXl1IVhukdUmNDpkcUxl6Ad9cxHx/YLYpJRwAuV5X2Tw6oaB9HAkmeS3A0C+SZU/ck4zUCHmmmDENBPz6p3Og903eZ2yQZGKKwft/KvqF6Bx6bYMqEzbJ0AuKWInYI6yHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7OczE2q/3vq/UsqUAN8WFyXAJsiG1AmtAiFjgmX1yOI=;
 b=JrvSRgHMkINqnL0Obsdrm5RQsc6zfa/UI2QJM6ZhMrVP4zYSeOjVOUSOsFBKdFHylcpZ9VXy/D8/JuIMjOcna3ExH1sHHTrCxTOqvLGh9fAXoh0Qr8YqCu8lMT2YxPsjVRo9wSIvsY4LEWf0M69xi1ilyk7mmHHk9GMzVHwSpJmbv4JZWSszpD+3g/6drPZBirj6B3EO0e82E4+pC4clGoHDDMR3lhDjsrRLe9BGdxMcaNs1kiTJ+w2to/kz4lV3BJM9zyWmn6zE61q+i6jUwRkKe6tZO/vtRClvnsYFRbyIxtSRM1BwmZ+egaUapBdvOs4gUwMgoZ0cNI52gNEmLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB4820.namprd11.prod.outlook.com (2603:10b6:303:6f::8)
 by MWHPR11MB1645.namprd11.prod.outlook.com (2603:10b6:301:b::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4801.15; Sat, 18 Dec
 2021 10:39:54 +0000
Received: from CO1PR11MB4820.namprd11.prod.outlook.com
 ([fe80::99e7:e9ce:ff26:49cb]) by CO1PR11MB4820.namprd11.prod.outlook.com
 ([fe80::99e7:e9ce:ff26:49cb%5]) with mapi id 15.20.4801.017; Sat, 18 Dec 2021
 10:39:54 +0000
Message-ID: <b11156b7-e912-5b65-3b2f-4fd940727bc9@intel.com>
Date:   Sat, 18 Dec 2021 18:39:46 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.4.0
Subject: Re: [LKP] Re: [x86/mm/64] f154f29085:
 BUG:kernel_reboot-without-warning_in_boot_stage - clang KCOV?
Content-Language: en-US
To:     Borislav Petkov <bp@suse.de>
CC:     Carel Si <beibei.si@intel.com>, Joerg Roedel <jroedel@suse.de>,
        LKML <linux-kernel@vger.kernel.org>, <x86@kernel.org>,
        <lkp@lists.01.org>, <lkp@intel.com>, <bfields@fieldses.org>,
        <llvm@lists.linux.dev>
References: <20211209144141.GC25654@xsang-OptiPlex-9020>
 <YbjIoewxGaodXHKF@zn.tnic> <20211215070012.GA26582@linux.intel.com>
 <Ybm96seTxl+pWjTX@zn.tnic> <009391a5-468b-2a5d-1f12-44d2e3104bd6@intel.com>
 <YbsPwyLnejLQMbTb@zn.tnic> <20211216115838.GA23522@linux.intel.com>
 <e48b72d4-558a-ed7c-43cd-0cb70091be11@intel.com> <YbyIJYzqtHPKRMFt@zn.tnic>
From:   Yin Fengwei <fengwei.yin@intel.com>
In-Reply-To: <YbyIJYzqtHPKRMFt@zn.tnic>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: HK2PR0302CA0014.apcprd03.prod.outlook.com
 (2603:1096:202::24) To CO1PR11MB4820.namprd11.prod.outlook.com
 (2603:10b6:303:6f::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 44024e7a-af66-4857-0073-08d9c212ba41
X-MS-TrafficTypeDiagnostic: MWHPR11MB1645:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-Microsoft-Antispam-PRVS: <MWHPR11MB1645C8D88FD96BE7F3D1407EEE799@MWHPR11MB1645.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4125;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kfzyyWGgRpPnm+i6WSOZFD6Xj0td2RqyZiGHau/1BOG85oLMdE2QDEyMUzMe6AW9i4gEvV6s88NLoQ0vrU8mBSxYB27RyHLouuZhEXIpKyqbFQXn2apog/A5mpetmGzzZJiOWxaT+NqW+GCWvFIX0By6QTPT2hwRR6OzHEgzWzTS1iLwvZIPuU3dFSUIeVfcalE1bC8cmlrZJOGmrIrbdUF/WcsR1ftg0NaaeMU2vfu/q1tKzCaomT+iE+3kSyC508rOlNdMutFVtM/QZHPPeOkMzw3eNPkvTydhue8YKZWNylIWVAg6WEFBF51ClkVan3EWYQazEzl4EFvq43T8sgyiLWWzSJ4ZTuKPkupxVH3ehDjWR+OnUtMrKgKK4+6C6YIrBxl9cWCm/LrzRLHKdOc69kmxIGpthSpWnqLZiYrFPTkbNhcmx9cq1+3w1jxcBZKtSR70aLvzMjcZzlClvcNJqIxIR2d78Fk1LF/6IOP2V2Pc9tx+WLAGyOVWoC9TfHSHK69o3CP4gNMn+3sd/Yuo8p16Jlgk+FIV3h13LEhmurG0Dikdwyn7HG+EgJTm27CrM/JHCaPY6X1D1TJ1lXF0xCqZvFXX4OHEEsrxyF9DXEaLvDh0DXSCGkP6EO3XkaaWFYW7iybyX4Ig7hGm+OOu+zvFXafu/tXi/i4suI4okALWhX4sJW/RDjO/T+/BUSIOcWV+/J+WPGCXkkpOfBaEn+kXKMAdiv5cNBSw/99KNcSIAggOj2A23HXTzEdwZi34HE5muYnZ1fG/jqKx3PUxWr+IBeBUDHCMDRSdAOZR0KM2vyJWfcAysGOo/NzgCzRsYrq7EgUeZfK8SLfVbTfDAGmaI+xVKBzjtSKOOmY=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB4820.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(316002)(966005)(54906003)(8936002)(6506007)(38100700002)(6916009)(508600001)(186003)(6486002)(26005)(8676002)(4326008)(66476007)(66556008)(30864003)(66946007)(5660300002)(53546011)(6512007)(6666004)(2616005)(36756003)(31686004)(66574015)(2906002)(83380400001)(86362001)(31696002)(82960400001)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?N2N3Z2VPMURuMENMQ3ArL3Q4RzlFL2NmdEkzazBzMm8vZ2JBMzJsTk9YTEYw?=
 =?utf-8?B?VkhRWUFGTVhlWXZ0OVc0Vy9zVC9GOGkyM3hyZlRXSEZScXpRL1JOTVdrelpC?=
 =?utf-8?B?NUVva21YTEVhU3JpbzV0MThyVFRscjFERzR2ekpjNktZZWd2TGhXMFBzSG9p?=
 =?utf-8?B?akFvZ1RKVHNjWVRmSlY1YWFCanVJT3R2S0x1QWtGNENCNzJXcDRsRUZGenlr?=
 =?utf-8?B?M2tXbFNKMEF3OERHVmx3aitUaFU4d2xPRVowUy9wdFVDWEtaelFrR1dBMTdz?=
 =?utf-8?B?SFdMNjdSVGJ1V29mcVVrSStvQk1DVGw0dFArUWtmRGJUVEdGaHBHZGJrS2FU?=
 =?utf-8?B?UCtoV0JjeTljNlAvbWJsZ1ZIVmN5UUE0ZGVIUytpQmV2a1VjNEJ3bDVDWlEw?=
 =?utf-8?B?Nko3YlNwSnpwc3h1dUFCVm84Sjg4OEIvSTdWVDlxQlFDUDNwbHk3bUp2eGg4?=
 =?utf-8?B?c3dhYWNIZERNUkJJOEFvczl5K3VIbkljYmQ2d1JIZm83dmZsenFPR2tPeEVl?=
 =?utf-8?B?K1p1ejFtNjZtVGdyZnIrbDhPTDM3UlRhUFlTQW5TZHBmVytvOVhmRDBjOTZB?=
 =?utf-8?B?U0tYejdHdVlUdjNSNEpkblJrS0x0Q2xWbFR3RjRzNGhWb0VEQVp0OEl6S3lM?=
 =?utf-8?B?QkhORndvNU4vVW9sRnFhYUtYbFlDNHpXWm53RWdOUE9GL3g3Uk5PSy96Z3Qz?=
 =?utf-8?B?V3NURENOZnlrcTlXZUxjczRUTWtzTC8yeUNjL1ZRS3gwWWwxd2Jvem93ODE5?=
 =?utf-8?B?dlg1UFhhdEFxUTg5MFVGY3I2WXVaeWRLbEpoT2ZFQk5PWHFQRGpONFh2TVpS?=
 =?utf-8?B?Q0pCcHRNNWwxV1RhQXRtVWtibStGWmpKWDVzM29yakRndXprbkdVb25JZW9n?=
 =?utf-8?B?OWFOM3Faanh2cjE4R3FSd3pJL0tCYXJvWFgvZEdycGtaam1WMWRUT0UvUFk0?=
 =?utf-8?B?azl4MDQ1NDBCaVNQSFhqeTRKUCtpV3Z2UGV6eXJuSjQrWmc5bzFBMThwOFBD?=
 =?utf-8?B?MCtXUDJlYnhBSDJMNU9mV2FucXFwMUY0WXRWMERESWh5MzIyTUl6U2o0dFpt?=
 =?utf-8?B?WVhnWWlaZU1TMitHbDA5T2c1TlFlOGZXU043RVU2NXVnOVBzYjlJOFRzbEtt?=
 =?utf-8?B?V3ByVkE5cnpLdDlxNWpqclc1WEVORUl1ZXBGUERLeTdzTFV2Tk1tcEJDbFlT?=
 =?utf-8?B?UXU2dHo4ckdNU0tQTmxQZEJQSlloZk4xOEJrbS80bUVOTWxzSENRdE5TY0hG?=
 =?utf-8?B?VC9LWjE0SXpNdkloWHVEd01ScG41dXE2U1hCRE9wVTY4bnBPamNpcWlLa1VJ?=
 =?utf-8?B?cmc4enV2cFlpclhUVytSRjdnb3RLWWlnYU9aYzVHRVlHbDVlcUJHMmJwNlhu?=
 =?utf-8?B?YXMwVnJweUIrejlaL1EvNHZvQVovck5uNWhtRFRYWVI3amRBOGlUb1cyTlBn?=
 =?utf-8?B?QUJ1Z2pkVy90RFVVWms4NGh1a0Z6ZWFKWUM4dVhXRFc5T2VmVFUyUWgrbGRX?=
 =?utf-8?B?RkxBRDkydnZFaVNTTW5hVzdoeitya1J0WkFuUGs2a3hYZTEwci9kOTRlQlJX?=
 =?utf-8?B?eDhRQk5QUk01THY1SlFFS1YrZUNHd1Nhb0RCMysyYU1lMkl5ZHp4cGkvd0N3?=
 =?utf-8?B?cE94cGVWUi9nNTJRVDJVQUVnQ21CQlpIejVnck9FMkp5SHVvQk9SeXAyTVVl?=
 =?utf-8?B?RmhqOVV0K0NDamxqWVJORGRTS3kzQThMTG14ZmUvMnJ5Z3pZcDhZU3lhU05n?=
 =?utf-8?B?djl4VFJRVDBYNkhuaVNaNzZLaERQeWRESWdqSU16Rm5nZXlra3JUcTkvTHpw?=
 =?utf-8?B?NWFUZzBLU2xSRlZQaGQ2MWVUWHA5TWdiWElzUzFZVlFFMDFveXhrTHpudmU2?=
 =?utf-8?B?cUZjYzRSU203d21XaVdtdHFCelFReHF6OG1YQ0hQQWF5NUV0Smw1L0VSQ2Y2?=
 =?utf-8?B?WC9zTUFKeVZ2R2RZdVpoU09OT0o4ZVFWMFdPcU8rNXptTENGSTc5K1lvMlli?=
 =?utf-8?B?d0xqSStJSW1JSmM0UmdLRStwVnFSVllhM0FhWW1wTyt0TWZvbXBLSTFoaVlu?=
 =?utf-8?B?U1NkcDdnd3RySzNmZTZJU1dMa3dPa1dBR0FITUgzV0F1c2Rnb2pNbVZWREdL?=
 =?utf-8?B?bmJJVnd6WG1jZHliUTdiOStpUWpmOEhtc3BHYlNZbUFOVVhPaXowMUI4c2Nl?=
 =?utf-8?Q?m9vQd8BwxWwVNeKi3L+sRhg=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 44024e7a-af66-4857-0073-08d9c212ba41
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB4820.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Dec 2021 10:39:54.2469
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hTpQ/Y/DL0M9zJMXIJ8OwZw87HlzPQi3MKMKGy146DQcCAA6/KtS4cGl7k41UjATCdPfxpzj13/k7BQCl+vZYg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR11MB1645
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Boris,

On 12/17/2021 8:52 PM, Borislav Petkov wrote:
> Add Bruce and clang folks to the party.
>=20
> On Thu, Dec 16, 2021 at 08:21:15PM +0800, Yin Fengwei wrote:
>> Hi Boris,
>>
>> On 12/16/2021 7:58 PM, Carel Si wrote:
>>> Hi Boris,
>>>
>>> On Thu, Dec 16, 2021 at 11:06:59AM +0100, Borislav Petkov wrote:
>>>> On Thu, Dec 16, 2021 at 03:04:16PM +0800, Yin Fengwei wrote:
>>>>> The testing was with Qemu.
>>>>
>>>> This is hardly what I asked for.
>>>>
>>>>> And we found that the hang is related with clang-14.
>>>>
>>>> I saw that already.
>>>>
>>>>> The original report showed the kernel is built with clang-14:
>>>>>         # build kernel
>>>>> 	cd linux
>>>>> 	cp config-5.16.0-rc3-00003-gf154f290855b .config
>>>>> 	make HOSTCC=3Dclang-14 CC=3Dclang-14 ARCH=3Dx86_64 olddefconfig prep=
are modules_prepare bzImage modules
>>>>> 	make HOSTCC=3Dclang-14 CC=3Dclang-14 ARCH=3Dx86_64 INSTALL_MOD_PATH=
=3D<mod-install-dir> modules_install
>>>>
>>>> I saw that too.
>>>>
>>>>> Looks like KASAN related stub generated by clang-14 (KASAN_SHADOW_OFF=
SET and asan_report).
>>>>> This function is early function called before kasan_init.
>>>>>
>>>>> Looks like we need to disable KASAN_SANITIZE for arch/x86/kernel/cpu/=
common.c. So clang-14 will
>>>>> be happy with this kind of early TLB flush? Thanks.
>>>>
>>>> Ok, I don't understand: I asked for how exactly to reproduce and wheth=
er
>>>> you can send me your vmlinux you built with your clang-14. What I get =
is
>>>> some possible explanation about what might be happening.
>>>>
>>>> So what do you expect me to do? Say, "oh, sure, you're right, send me =
a
>>>> patch" without even being able to see for myself what the root cause i=
s?
>>>>
>>>> What if it is not the kernel's fault but clang-14 is miscompiling crap
>>>> as in so many other cases?
>>>>
>>>> I built clang-14 and built with your .config and it works here fine. S=
o
>>>> why does yours fail?
>>>>
>>>> Or what's the point of all this?
>>
>> I had concern that our report is an invalid report because you can't rep=
roduce
>> it in your side. If that's the case, it could waste more your time. That=
's why
>> I did check and shared what I got. I am very sorry if I did it wrong.
>=20
> Sure, you can always add your analysis but I'd like to reproduce myself
> too. So, in the future, please answer the questions and then feel free
> to add your analysis - I'll gladly have a look.
Thanks a lot for sharing this. Lessons learnt here. Will follow this
rule exactly in the future.

>=20
> Which wasn't that far from the truth, btw.
>=20
> But it isn't KASAN but GCOV profiling. Or is it KCOV profiling which
> clang does.
>=20
> That thing adds some counting glue to native_write_cr4():
>=20
> (my comments from the actual singlestepping in qemu start with '##' below=
)
>=20
> 	movq	$__llvm_gcov_ctr.48+8, %rbx				##  mov    $0xffffffff8837d3c0,%rbx
> .LBB8_1:                                # %set_register
>                                         # =3D>This Inner Loop Header: Dep=
th=3D1
>=20
> 	jmp	.Ltmp42
> 	...
>=20
> .Ltmp42:                                # Block address taken
> .LBB8_7:                                # %if.end79
>         movq    %rbx, %rax						## 0xffffffff8837d3c0
>         shrq    $3, %rax						## 0x1ffffffff106fa78
>         movabsq $-2305847407260205056, %rcx     # imm =3D 0xDFFFFC0000000=
000	## 0xdffffc0000000000
>         cmpb    $0, (%rax,%rcx)
>         je      .LBB8_9
>=20
> so the memory address CMP accesses is something as nonsensical as
>=20
>   0xfffffbfff106fa78
>=20
> so I'm guessing we need to setup something for that __llvm_gcov_ctr to
> deref properly but I haven't dug deeper.
>=20
> The important thing is that this triggers with clang-13 and -14. gcc is
> fine with the same config but that probably is because gcc does other
> profiling - gcov - I guess. Looking at the resulting asm, it has a bunch
> of those counter increments:
>=20
>         incq    __gcov0.native_write_cr4+88(%rip)       # __gcov0.native_=
write_cr4[11]
>=20
> but no weird memory references.
>=20
> So, clang folks, what's up?
>=20
> The fix is simple but I'd like to understand first why does this fail
> only with clang, 13 and newer.
>=20
> (I mean, melver pointed me to
>=20
>   380d53c45ff2 ("compiler_attributes.h: define __no_profile, add to noins=
tr")
>=20
> which explains why 13 and newer).
>=20
> Btw, joro, that second hunk is I think needed too because a couple of
> lines earlier we set up the cr4 shadow so I think you should use it
> instead of touching the hw CR4.
>=20
> ---
> diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
> index 0083464de5e3..79b3d67addcc 100644
> --- a/arch/x86/kernel/cpu/common.c
> +++ b/arch/x86/kernel/cpu/common.c
> @@ -384,7 +384,7 @@ void native_write_cr0(unsigned long val)
>  }
>  EXPORT_SYMBOL(native_write_cr0);
> =20
> -void native_write_cr4(unsigned long val)
> +void __no_profile native_write_cr4(unsigned long val)
>  {
>  	unsigned long bits_changed =3D 0;
> =20
> diff --git a/arch/x86/kernel/head64.c b/arch/x86/kernel/head64.c
> index 75acb6027a87..68d2b7f9a913 100644
> --- a/arch/x86/kernel/head64.c
> +++ b/arch/x86/kernel/head64.c
> @@ -483,7 +483,7 @@ asmlinkage __visible void __init x86_64_start_kernel(=
char * real_mode_data)
>  	/* Kill off the identity-map trampoline */
>  	reset_early_page_tables();
> =20
> -	__native_tlb_flush_global(native_read_cr4());
> +	__native_tlb_flush_global(this_cpu_read(cpu_tlbstate.cr4));
> =20
>  	clear_bss();
> =20
>=20
>=20
> Leaving in the rest for the newly added folks.
I tried this fix and it works fine in my local env. Will test it also in ou=
r
test box once we back to office. Thanks.

Regards
Yin, Fengwei

>=20
>> If you don't want to use lkp tool to reproduce the issue, following comm=
and
>> could be used as well:
>>
>> Use Qemu command so only kernel image need be downloaded:
>> qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp 2 -m 16G -s -S -ker=
nel vmlinuz-5.16.0-rc3-00003-gf154f290855b -nographic -append "console=3Dtt=
yS0 earlyprintk=3DttyS0,115200"
>> to reproduce it.
>>
>>
>>
>> Regards
>> Yin, Fengwei
>>
>>
>>
>>>>
>>>> I mean, if you cannot send me what I ask for, you can say so. Then I c=
an
>>>> ignore this whole report altogether and waste my time somewhere else.
>>>
>>> We have uploaded vmlinuz, modules.cgz, config as well as other related =
file to:
>>> https://download.01.org/0day-ci/lkp-qemu/pkg/linux/x86_64-randconfig-a0=
13-20211207/clang-14/f154f290855b070cc94dd44ad253c0ef8a9337bb/
>>>
>>> Machine types can refer to:
>>> https://zerobin.net/?e107cf7b56495d80#MQLh14wUT9Osv1tWCwiQx/okkAN48Nq+d=
rVPE0PiNPw=3D
>>>
>>> If there's any other msg needed, pls feel free to propose, thanks.
>>>
>>> Below are our full steps to reproduce the issue:
>>>
>>> # download lkp-tests
>>> $ git clone https://github.com/intel/lkp-tests.git
>>>
>>> $ cd lkp-tests/
>>>
>>> # download vmlinuz
>>> $ wget https://download.01.org/0day-ci/lkp-qemu/pkg/linux/x86_64-randco=
nfig-a013-20211207/clang-14/f154f290855b070cc94dd44ad253c0ef8a9337bb/vmlinu=
z-5.16.0-rc3-00003-gf154f290855b
>>>
>>> # dowmload modules.cgz
>>> $ wget https://download.01.org/0day-ci/lkp-qemu/pkg/linux/x86_64-randco=
nfig-a013-20211207/clang-14/f154f290855b070cc94dd44ad253c0ef8a9337bb/module=
s.cgz
>>>
>>> # download job-script which is attached
>>>
>>> # run lkp qemu
>>> lkp-tests$ sudo bin/lkp qemu -k vmlinuz-5.16.0-rc3-00003-gf154f290855b =
-m modules.cgz job-script
>>>
>>> ~/lkp-tests/pkg/lkp-src ~/lkp-tests
>>> x86_64
>>> =3D=3D> Making package: lkp-src 0-1 (Thu 16 Dec 2021 07:26:22 PM CST)
>>> =3D=3D> Checking runtime dependencies...
>>> =3D=3D> Checking buildtime dependencies...
>>> =3D=3D> WARNING: Using existing $srcdir/ tree
>>> =3D=3D> Removing existing $pkgdir/ directory...
>>> =3D=3D> Starting build()...
>>> make: Entering directory '/home/carel/lkp-tests/bin/event'
>>> klcc  -D_FORTIFY_SOURCE=3D2  -c -o wakeup.o wakeup.c
>>> klcc  -Wl,-O1,--sort-common,--as-needed,-z,relro -static -o wakeup wake=
up.o
>>> rm -f wakeup.o
>>> strip wakeup
>>> make: Leaving directory '/home/carel/lkp-tests/bin/event'
>>> =3D=3D> Entering fakeroot environment...
>>> x86_64
>>> =3D=3D> Starting package()...
>>> =3D=3D> Creating package "lkp-src"...
>>> 103987 blocks
>>> renamed '/home/carel/.lkp/cache/lkp-x86_64.cgz.tmp' -> '/home/carel/.lk=
p/cache/lkp-x86_64.cgz'
>>> =3D=3D> Leaving fakeroot environment.
>>> =3D=3D> Finished making: lkp-src 0-1 (Thu 16 Dec 2021 07:26:24 PM CST)
>>> ~/lkp-tests
>>> 12 blocks
>>> result_root: /home/carel/.lkp//result/boot/1/vm-snb/debian-10.4-x86_64-=
20200603.cgz/x86_64-randconfig-a013-20211207/clang-14/f154f290855b070cc94dd=
44ad253c0ef8a9337bb/0
>>> downloading initrds ...
>>> use local modules: /home/carel/.lkp/cache/modules.cgz
>>> /usr/bin/wget -q --timeout=3D1800 --tries=3D1 --local-encoding=3DUTF-8 =
http://0day.sh.intel.com:80/~lkp/osimage/debian/debian-10.4-x86_64-20200603=
.cgz -N -P /home/carel/.lkp/cache/osimage/debian
>>> 440459 blocks
>>> /usr/bin/wget -q --timeout=3D1800 --tries=3D1 --local-encoding=3DUTF-8 =
http://0day.sh.intel.com:80/~lkp/osimage/deps/debian-10.4-x86_64-20200603.c=
gz/run-ipconfig_20200608.cgz -N -P /home/carel/.lkp/cache/osimage/deps/debi=
an-10.4-x86_64-20200603.cgz
>>> 1773 blocks
>>> /usr/bin/wget -q --timeout=3D1800 --tries=3D1 --local-encoding=3DUTF-8 =
http://0day.sh.intel.com:80/~lkp/osimage/deps/debian-10.4-x86_64-20200603.c=
gz/lkp_20210707.cgz -N -P /home/carel/.lkp/cache/osimage/deps/debian-10.4-x=
86_64-20200603.cgz
>>> 2321 blocks
>>> /usr/bin/wget -q --timeout=3D1800 --tries=3D1 --local-encoding=3DUTF-8 =
http://0day.sh.intel.com:80/~lkp/osimage/deps/debian-10.4-x86_64-20200603.c=
gz/rsync-rootfs_20200608.cgz -N -P /home/carel/.lkp/cache/osimage/deps/debi=
an-10.4-x86_64-20200603.cgz
>>> 6856 blocks
>>> exec command: qemu-system-x86_64 -enable-kvm -fsdev local,id=3Dtest_dev=
,path=3D/home/carel/.lkp//result/boot/1/vm-snb/debian-10.4-x86_64-20200603.=
cgz/x86_64-randconfig-a013-20211207/clang-14/f154f290855b070cc94dd44ad253c0=
ef8a9337bb/0,security_model=3Dnone -device virtio-9p-pci,fsdev=3Dtest_dev,m=
ount_tag=3D9p/virtfs_mount -kernel vmlinuz-5.16.0-rc3-00003-gf154f290855b -=
append root=3D/dev/ram0 user=3Dlkp job=3D/lkp/jobs/scheduled/vm-snb-192/boo=
t-1-debian-10.4-x86_64-20200603.cgz-f154f290855b070cc94dd44ad253c0ef8a9337b=
b-20211208-23538-lnvkeg-5.yaml ARCH=3Dx86_64 kconfig=3Dx86_64-randconfig-a0=
13-20211207 branch=3Dtip/x86/mm commit=3Df154f290855b070cc94dd44ad253c0ef8a=
9337bb BOOT_IMAGE=3D/pkg/linux/x86_64-randconfig-a013-20211207/clang-14/f15=
4f290855b070cc94dd44ad253c0ef8a9337bb/vmlinuz-5.16.0-rc3-00003-gf154f290855=
b vmalloc=3D128M initramfs_async=3D0 page_owner=3Don max_uptime=3D600 RESUL=
T_ROOT=3D/result/boot/1/vm-snb/debian-10.4-x86_64-20200603.cgz/x86_64-randc=
onfig-a013-20211207/clang-14/f154f290855b070cc94dd44ad253c0ef8a9337bb/3 LKP=
_LOCAL_RUN=3D1 selinux=3D0 debug apic=3Ddebug sysrq_always_enabled rcupdate=
.rcu_cpu_stall_timeout=3D100 net.ifnames=3D0 printk.devkmsg=3Don panic=3D-1=
 softlockup_panic=3D1 nmi_watchdog=3Dpanic oops=3Dpanic load_ramdisk=3D2 pr=
ompt_ramdisk=3D0 drbd.minor_count=3D8 systemd.log_level=3Derr ignore_loglev=
el console=3Dtty0 earlyprintk=3DttyS0,115200 console=3DttyS0,115200 vga=3Dn=
ormal rw  ip=3Ddhcp result_service=3D9p/virtfs_mount -initrd /home/carel/.l=
kp/cache/final_initrd -smp 2 -m 3144M -no-reboot -watchdog i6300esb -rtc ba=
se=3Dlocaltime -device e1000,netdev=3Dnet0 -netdev user,id=3Dnet0 -display =
none -monitor null -serial stdio
>>> early console in setup code
>>> early console in extract_kernel
>>> input_data: 0x0000000006ffc2e0
>>> input_len: 0x000000000260cb2b
>>> output: 0x0000000001000000
>>> output_len: 0x00000000079e7da4
>>> kernel_total_size: 0x0000000008a2c000
>>> needed_size: 0x0000000008c00000
>>> trampoline_32bit: 0x000000000009d000
>>> Physical KASLR using RDTSC...
>>> Virtual KASLR using RDTSC...
>>>
>>> Decompressing Linux... Parsing ELF... Performing relocations... done.
>>> Booting the kernel.
>>>
>>>>
>>>> --=20
>>>> Regards/Gruss,
>>>>     Boris.
>>>>
>>>> SUSE Software Solutions Germany GmbH, GF: Ivo Totev, HRB 36809, AG N=
=C3=BCrnberg
>=20
