Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 798A64C21CE
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Feb 2022 03:46:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230146AbiBXCpn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Feb 2022 21:45:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230077AbiBXCpl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Feb 2022 21:45:41 -0500
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2088.outbound.protection.outlook.com [40.107.223.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7DB3235876
        for <linux-kernel@vger.kernel.org>; Wed, 23 Feb 2022 18:45:10 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BrKQo8K4aGea6JylptsZGYEdtH9vzr/qRDGPbeKSpT4WNL6lHfeo2FF54I2/Z+wbkDiwGBHEBH516TYblwLJe3zbD+3Cq0Nouk9C0PBzwZZBT/11865h+6Si5bSWRhb+75EwGuLwfPI20SrjtDhq+vKUZ9Snl++xHJKp3jD/GaaTR89fXRSyN43lVHFbptsEAi2tBbuOqNbYVMEMds2FQj4U2zyRw5dzQp0g3iyy9rbj5AW/cL3R4T/+Do+i//iLgpOIoilDsQSdCqRcnpM2KFSs+1g/ZkrdkPW1Ig/EyPHtUC21p+5ENl9zyp+NMqsxsQ9jrwLq6iqzevfmQokRZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IM4yBvPqYkBorLCjG4Y+5GMxvs8KyhDgCE1So35GOsU=;
 b=Va8p6qcWoa5FtS0dhGaz7ucOfuP3D53RzBGj/5uOrSC3pqAP+Ke6ER0vGSMWR1l5sqEusMgZ4xniXGwngo2mRgvo+JUrCoG1xjfdzRANaLU2KrlRz1rK38fiXRplth3zDYMWgKAFRAbh0C4e5Q125lR3+mfy+GgNu2q+wQKCsGTPvBBCF2+o2vXxMQxuzGYAheRErXYUPprlG+YvabcADWot0c6zaLyIKrUIiStwidTV9hcnz++h07o7ySpuEz78mUQ7e1RRare2UmewnZp3Ypd/XjDw9xU2lo/Ops6Fat0Evw33u4nPDqGGSsbctyHIGUSvipsHwOUU4/wsBmo1dw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IM4yBvPqYkBorLCjG4Y+5GMxvs8KyhDgCE1So35GOsU=;
 b=d6zwvwmkGq5rRcfu60mTMgAIlg9Lb5j+l7KS11E50ydO13kexUgAeLLkyxdXMffiL79OSBbJOfipycOvqBeCDIKIOAPsxxExy9ix0FyE4/bCFGzyatssyWtVjkHIb/jPVKDdNpiOFUNsI+7455P0j5O0hRZgEqQo14ywjL0pbnU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4123.namprd12.prod.outlook.com (2603:10b6:5:21f::23)
 by SN1PR12MB2589.namprd12.prod.outlook.com (2603:10b6:802:2c::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.17; Thu, 24 Feb
 2022 02:45:08 +0000
Received: from DM6PR12MB4123.namprd12.prod.outlook.com
 ([fe80::2cd2:1c35:be98:aba5]) by DM6PR12MB4123.namprd12.prod.outlook.com
 ([fe80::2cd2:1c35:be98:aba5%6]) with mapi id 15.20.4995.027; Thu, 24 Feb 2022
 02:45:08 +0000
Message-ID: <d1f912c9-3b3b-6851-fac9-80a33c2af4f0@amd.com>
Date:   Thu, 24 Feb 2022 08:11:34 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH 1/9] ASoC: amd: vg: fix for pm resume callback sequence
Content-Language: en-US
To:     kernel test robot <lkp@intel.com>, broonie@kernel.org,
        alsa-devel@alsa-project.org
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        Alexander.Deucher@amd.com, Sunil-kumar.Dommati@amd.com,
        krisman@collabora.com, wtli@nuvoton.com,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        open list <linux-kernel@vger.kernel.org>
References: <20220223071959.13539-1-Vijendar.Mukunda@amd.com>
 <202202240237.RkL3TEe3-lkp@intel.com>
From:   "Mukunda,Vijendar" <Vijendar.Mukunda@amd.com>
In-Reply-To: <202202240237.RkL3TEe3-lkp@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BM1PR01CA0160.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:b00:68::30) To DM6PR12MB4123.namprd12.prod.outlook.com
 (2603:10b6:5:21f::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4c13a2c2-8bfe-4391-afb6-08d9f73fab37
X-MS-TrafficTypeDiagnostic: SN1PR12MB2589:EE_
X-Microsoft-Antispam-PRVS: <SN1PR12MB258944B2A3D9978401942843973D9@SN1PR12MB2589.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SsvIBbGzgoUHA0XE0PvyWHknILpxfD3b8POTse1DGElgRo//TSx7hxKKzbhbDkROjwumn0sQ+zxZd67eXJd6h9QxwbsvtSiPyqpIKYmoc5o+QTCXiLdG7/P00/cg2i8aPDqwgV/iyKgPZXop41avcx/bFO4ZvrCALmHE7g0oOaSYTUCaBA1cUDALUoZXSxemFI8psuwdDGbG6zcI3YZ1rnKTq2zU9S6qwzaWBIXBk69aAc3tZ5VusPEnjng4jbNIpVDTWOvst4V5MsLN/cmXf8Nsu+t1nEEagHgG8qdRiqLyXyYtMn2s8tt8DcjLo+NL4R2FbRW5uTEe81yIJ5pi1SysMzIBDgyxOc/ftOSBRE4WTVPuEFsUaDB3RzVCuL2FmugbS8uypCbSZxPD3WKaUR5ILqjpAf0vHKACehrCMMbP7AlvNqFNlH8TBYUnomarig31ZbiLb40FpzThJu08P7JyhUzw1YtEMlVH/atMXzYQVewiyFReN3rdgL+23G0gKcPCsJfVIbcLUTbYOs/btBzQFrck8jgAbPVfJK4YNyp7iYFTCI0OiSzRLJKqr/TTWtI8HnkPhSnfJWqTbiIxHJsckVV16J4UK7ZC7aCvvRgrwDDFVXwP2D0WBZNzvyrUEjFZ8uwdDY70mWeFCS6r85BSSukneGaVHiwON13m4ZZ8T1DfSgOdsMpYIbkH6LkzUGBfB/AduM/su2LYoltpTjQqp65Ie6Bqdqf6yQ7CcqTxvEQxNWDDP7A6odpbKJyoi80W95GCP1E3B8YBUD7PqubODGve5rlydUxYo6d2iC10TIJwQvyhRv96oDYHie5MvaxD7PsB9jPavRl7RELa3k9M84xKwhmQhn7S4JYsw+M=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4123.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(2906002)(36756003)(7416002)(86362001)(6512007)(54906003)(5660300002)(31686004)(31696002)(30864003)(38100700002)(8936002)(66946007)(66556008)(66476007)(4326008)(316002)(45080400002)(8676002)(6486002)(966005)(508600001)(6666004)(53546011)(6506007)(186003)(2616005)(83380400001)(26005)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VTdYYlVKaGRMY1JMd1lYNmdvanFEcjc2UTlpVndGbGtVall1Q0VBbmYwMGNh?=
 =?utf-8?B?TnVpeW0xVFVraVU1K3p4VEs4YmlxS1dzbndxbmJ4U1U0RE5VQUhvRTRRWU9B?=
 =?utf-8?B?K091ZUkwTW9uaGwzcC8rV1BrWE94OFpLbWY3a0JERHBUMVVxWW85K0lQZlNz?=
 =?utf-8?B?UElnL2RjdGhKTlNGZnBZV1dTb2poVUxTWDVmL0FZcHYvUm9Xd3FtL3ZBbWtl?=
 =?utf-8?B?d002bVZlbE9DTWVyM2g2d2xhNWVlWnF1NnYrMENxSDlSSDNic3g4V3dQa1px?=
 =?utf-8?B?VlkrY3BWaXdpOUFMYUN5ck1LRVZ2ek5YbDRwT2c1T0tOYitoSnBNeXlYRmVV?=
 =?utf-8?B?ODZ2UUtIdC9wenFWWndrYlJYVWdSUFI4R2xVTUljL2x5QXAzakFEZCtabVk0?=
 =?utf-8?B?KzAvWWpnTjR5akxwVHFvblVxeHBFb0JEbkFTWFdnS21Mdzd1K3orWitFa0tR?=
 =?utf-8?B?MDlSekxJa053dFRiRGxUSTMrakxsTGcybkhnTjZyWFByYy90SWVSNkEvbVB2?=
 =?utf-8?B?U3VoUHpwZUJSZjF0U3BRYUZNMTF3TEdvL00rVkpCdVBZMnZaQmQ0cVBXUXJk?=
 =?utf-8?B?c1Q3eW03eWlhVDFGZCsvRXdzVEVXMnBUbXNNR0J3QVdZemJFV2E5WjlwMkNY?=
 =?utf-8?B?TjBCWGVVTW1UbGRQRmQvdjZzTDZlb2pKcS9KTnluTnI4dGpuWDl5ejI3QUFR?=
 =?utf-8?B?OEk0UjN3enV1eXBuQkxuK1pMaGsyYkcyNWVtbExjRlUrUW9TdTlaSTV3S29Z?=
 =?utf-8?B?bmhhd0hDWWRreCsxR215MlY5eWV1NkdobXNJa3B4bVJFVjF3WVFDQmZWQkg2?=
 =?utf-8?B?aGFwalJ4elY0NVdsNi91NkpoL25XRnBKWEdoNFpoUnBMUDJPbHZlS0FXZGQ3?=
 =?utf-8?B?cmlZNkYxVnpBcE5TQ2JyMVBoaldKQmZsQTg3NHY2emhuRWE5WElQM1IzN2c2?=
 =?utf-8?B?YkszUk9rb0pLMElVNXV5N3N5V2dwc3lEK29aYnRJUDd0NEJFcGU3Q3VZd1ZC?=
 =?utf-8?B?WVFhVXpZMlJ5YU8zNzgxd1NWV1ZTQ0xGRk1KZ0hlYTFMUllSK1U0Q2NkQWhm?=
 =?utf-8?B?VUp6cWNlRjZzQ0lLanUvQ1VyWEtrQTdHWkFMSi9mdmNzR3BFeDFiT2t4ajV5?=
 =?utf-8?B?bHZPYm01aWlBNjNSZFp3RG9YblJSK3ZiSFdINEF3S3ovbGVaZUs0M2UwMkdk?=
 =?utf-8?B?UXk4RWp3SkQ3NjMwaVkvSThkUzdkNzZBQXZmTnd2LzdQRXRTcmhyVmMybzEr?=
 =?utf-8?B?UUk1QjUxQzZmcG1oekZOY1NXT1Z6Q0ltanZ4cVF2Wk8vQXIwQ0VWNC9ZNTBN?=
 =?utf-8?B?WXZiY0hxTjRhaXA1MnF1c0xyUERhbHVUa1NGc3NLbTc1NWNvUGFaYlFnNitq?=
 =?utf-8?B?alFwR0RlbTNheFhQZERzVWthUCs3QVdhbW1QNEZGcmd1YmlJaXVXMkVtWmM4?=
 =?utf-8?B?RnhkVHVxTm5OU0cxMEUvSEUxTmZIVjAxRmlMUk0vYU1lamxLZHVvT2cyL1g0?=
 =?utf-8?B?TzFoSS9LYStZcmJzaVZaaHgrNW1FNEpFaTdYNTIwc1Vab2pvZFpTRTBaay9G?=
 =?utf-8?B?TS9nWVpvRWdPRzVDRWhxb1Zma29ULy9kMGY4Skl5QjhXc25JREZ3dEZFR1lY?=
 =?utf-8?B?eGhNOHl6R21uZnZvVHRXbm85N0lGbHFJdEErM0h6V1pGbnIrZFpGZU9uUU5o?=
 =?utf-8?B?cnBLaVUweTE3bmdmMTBRSnZ2WU9nMm16RkxZVnVSZXNvdUVvYjBCaG91WnRL?=
 =?utf-8?B?MkxldzBWbVVNTjI2Uko3SzRpWXNKcXU0SzNaSUQ2UkIzZ0xtNlVkZ0dPWEI3?=
 =?utf-8?B?R1djTk05Yi9pMGNpN3Y2Vmo3OUExdjVDZyt1QUo1UGFIblo1K251U3czOGhZ?=
 =?utf-8?B?OCtoMFlvUFVPNTJEZDk5eE1JZk1GK0c3TDJLWGg2OC8wZFFubUNuZTlWaHBK?=
 =?utf-8?B?dy9pQis2dUJVOTU2cWVMWjN2N1NqTzlXNnJjMC9ZNFpFaXBXTzdRdElObVlH?=
 =?utf-8?B?dG42Y3J0SzdSNVZFR015dDBCMHVFMitzUzFSMlBiMFIyYTlablh2ckVNVGly?=
 =?utf-8?B?T0ZtY3pXbmxzSXBOOExlOTBmbUlwSzNTSS9hMVJxb2hZaWgvMks4U0NKeUl4?=
 =?utf-8?B?MHd2THRLQ1ozVjd1Z2dsRnF2MVJYNWNvMkJ5aUxvbHRzTEVXNlU3RE1DMExM?=
 =?utf-8?Q?S3r3pLqvvcJLCQIvrZ/MuX4=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c13a2c2-8bfe-4391-afb6-08d9f73fab37
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4123.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2022 02:45:08.2524
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /TKcBqWTWcnuzl18UutE0jsriFKw1b0/1CAqlk4/hI2QIXms5lOBPWtMF9DoUVYsCaRchjaCaO5T/w2k+HSeCQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR12MB2589
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2/24/22 12:04 AM, kernel test robot wrote:
> Hi Vijendar,
> 
> Thank you for the patch! Perhaps something to improve:
> 
> [auto build test WARNING on broonie-sound/for-next]
> [also build test WARNING on v5.17-rc5 next-20220222]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Fgit-scm.com%2Fdocs%2Fgit-format-patch&amp;data=04%7C01%7CVijendar.Mukunda%40amd.com%7Cc74e88a43d8949965f6208d9f6fb2b64%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637812380936350652%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000&amp;sdata=tOnbpasVg9EKIUUSTSE9EnqOdVFnodqU9BSzRO%2FBa5w%3D&amp;reserved=0]
> 
> url:    https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Fgithub.com%2F0day-ci%2Flinux%2Fcommits%2FVijendar-Mukunda%2FASoC-amd-vg-fix-for-pm-resume-callback-sequence%2F20220223-152636&amp;data=04%7C01%7CVijendar.Mukunda%40amd.com%7Cc74e88a43d8949965f6208d9f6fb2b64%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637812380936350652%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000&amp;sdata=by5tZtZsWgFaNQJHqido5zIm1Tg8O8y%2B68j0C%2BOmUb8%3D&amp;reserved=0
> base:   https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Fgit.kernel.org%2Fpub%2Fscm%2Flinux%2Fkernel%2Fgit%2Fbroonie%2Fsound.git&amp;data=04%7C01%7CVijendar.Mukunda%40amd.com%7Cc74e88a43d8949965f6208d9f6fb2b64%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637812380936350652%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000&amp;sdata=k%2FF9xSFs3Fac1KgZZv90CEnJBqcXcjJDybN%2Bqr%2BZwwk%3D&amp;reserved=0 for-next
> config: x86_64-randconfig-a014 (https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Fdownload.01.org%2F0day-ci%2Farchive%2F20220224%2F202202240237.RkL3TEe3-lkp%40intel.com%2Fconfig&amp;data=04%7C01%7CVijendar.Mukunda%40amd.com%7Cc74e88a43d8949965f6208d9f6fb2b64%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637812380936350652%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000&amp;sdata=krN1Mcd%2FibIB8NRSE04gaJz16jeZw1w73IDF0okDXz8%3D&amp;reserved=0)
> compiler: clang version 15.0.0 (https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Fgithub.com%2Fllvm%2Fllvm-project&amp;data=04%7C01%7CVijendar.Mukunda%40amd.com%7Cc74e88a43d8949965f6208d9f6fb2b64%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637812380936350652%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000&amp;sdata=zwlf3eJdzR8Dvq5ASaL0Z52iBKdZoSYlA6sFsGFCYPc%3D&amp;reserved=0 d271fc04d5b97b12e6b797c6067d3c96a8d7470e)
> reproduce (this is a W=1 build):
>         wget https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Fraw.githubusercontent.com%2Fintel%2Flkp-tests%2Fmaster%2Fsbin%2Fmake.cross&amp;data=04%7C01%7CVijendar.Mukunda%40amd.com%7Cc74e88a43d8949965f6208d9f6fb2b64%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637812380936350652%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000&amp;sdata=lvpnbsE%2BZ3BXnAPPlExpMlIhW5%2FQ0P%2FExu%2FPCiVjwM4%3D&amp;reserved=0 -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Fgithub.com%2F0day-ci%2Flinux%2Fcommit%2F43c5f728cf59371b29569d941fb2ef2bdc3a279d&amp;data=04%7C01%7CVijendar.Mukunda%40amd.com%7Cc74e88a43d8949965f6208d9f6fb2b64%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637812380936350652%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000&amp;sdata=e3LH9P7U2tUfWkkKbJlK%2B%2BH4cWI0gb8%2FMaPAoH8K1Ek%3D&amp;reserved=0
>         git remote add linux-review https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Fgithub.com%2F0day-ci%2Flinux&amp;data=04%7C01%7CVijendar.Mukunda%40amd.com%7Cc74e88a43d8949965f6208d9f6fb2b64%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637812380936350652%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000&amp;sdata=g3SHzCHLx%2FcKKgHT0dXL3eX4%2BghrUVsboYstFOsMyPE%3D&amp;reserved=0
>         git fetch --no-tags linux-review Vijendar-Mukunda/ASoC-amd-vg-fix-for-pm-resume-callback-sequence/20220223-152636
>         git checkout 43c5f728cf59371b29569d941fb2ef2bdc3a279d
>         # save the config file to linux build tree
>         mkdir build_dir
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash sound/soc/amd/vangogh/
> 
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
> 
> All warnings (new ones prefixed by >>):
> 
>>> sound/soc/amd/vangogh/acp5x-pcm-dma.c:430:20: warning: variable 'frmt_val' set but not used [-Wunused-but-set-variable]
>            u32 val, reg_val, frmt_val;
>                              ^
>>> sound/soc/amd/vangogh/acp5x-pcm-dma.c:430:11: warning: variable 'reg_val' set but not used [-Wunused-but-set-variable]
>            u32 val, reg_val, frmt_val;
>                     ^
>    2 warnings generated.
> 
will fix it and post the patch.

> 
> vim +/frmt_val +430 sound/soc/amd/vangogh/acp5x-pcm-dma.c
> 
> 361414dc1f07b7 Vijendar Mukunda 2021-07-21  425  
> 361414dc1f07b7 Vijendar Mukunda 2021-07-21  426  static int __maybe_unused acp5x_pcm_resume(struct device *dev)
> 361414dc1f07b7 Vijendar Mukunda 2021-07-21  427  {
> 361414dc1f07b7 Vijendar Mukunda 2021-07-21  428  	struct i2s_dev_data *adata;
> 43c5f728cf5937 Vijendar Mukunda 2022-02-23  429  	struct i2s_stream_instance *rtd;
> 361414dc1f07b7 Vijendar Mukunda 2021-07-21 @430  	u32 val, reg_val, frmt_val;
> 361414dc1f07b7 Vijendar Mukunda 2021-07-21  431  
> 361414dc1f07b7 Vijendar Mukunda 2021-07-21  432  	reg_val = 0;
> 361414dc1f07b7 Vijendar Mukunda 2021-07-21  433  	frmt_val = 0;
> 361414dc1f07b7 Vijendar Mukunda 2021-07-21  434  	adata = dev_get_drvdata(dev);
> 361414dc1f07b7 Vijendar Mukunda 2021-07-21  435  
> 361414dc1f07b7 Vijendar Mukunda 2021-07-21  436  	if (adata->play_stream && adata->play_stream->runtime) {
> 43c5f728cf5937 Vijendar Mukunda 2022-02-23  437  		rtd = adata->play_stream->runtime->private_data;
> 361414dc1f07b7 Vijendar Mukunda 2021-07-21  438  		config_acp5x_dma(rtd, SNDRV_PCM_STREAM_PLAYBACK);
> 43c5f728cf5937 Vijendar Mukunda 2022-02-23  439  		acp_writel((rtd->xfer_resolution  << 3), rtd->acp5x_base + ACP_HSTDM_ITER);
> 43c5f728cf5937 Vijendar Mukunda 2022-02-23  440  		if (adata->tdm_mode == TDM_ENABLE) {
> 43c5f728cf5937 Vijendar Mukunda 2022-02-23  441  			acp_writel(adata->tdm_fmt, adata->acp5x_base + ACP_HSTDM_TXFRMT);
> 43c5f728cf5937 Vijendar Mukunda 2022-02-23  442  			val = acp_readl(adata->acp5x_base + ACP_HSTDM_ITER);
> 43c5f728cf5937 Vijendar Mukunda 2022-02-23  443  			acp_writel(val | 0x2, adata->acp5x_base + ACP_HSTDM_ITER);
> 43c5f728cf5937 Vijendar Mukunda 2022-02-23  444  		}
> 43c5f728cf5937 Vijendar Mukunda 2022-02-23  445  	}
> 43c5f728cf5937 Vijendar Mukunda 2022-02-23  446  	if (adata->i2ssp_play_stream && adata->i2ssp_play_stream->runtime) {
> 43c5f728cf5937 Vijendar Mukunda 2022-02-23  447  		rtd = adata->i2ssp_play_stream->runtime->private_data;
> 43c5f728cf5937 Vijendar Mukunda 2022-02-23  448  		config_acp5x_dma(rtd, SNDRV_PCM_STREAM_PLAYBACK);
> 43c5f728cf5937 Vijendar Mukunda 2022-02-23  449  		acp_writel((rtd->xfer_resolution  << 3), rtd->acp5x_base + ACP_I2STDM_ITER);
> 43c5f728cf5937 Vijendar Mukunda 2022-02-23  450  		if (adata->tdm_mode == TDM_ENABLE) {
> 43c5f728cf5937 Vijendar Mukunda 2022-02-23  451  			acp_writel(adata->tdm_fmt, adata->acp5x_base + ACP_I2STDM_TXFRMT);
> 43c5f728cf5937 Vijendar Mukunda 2022-02-23  452  			val = acp_readl(adata->acp5x_base + ACP_I2STDM_ITER);
> 43c5f728cf5937 Vijendar Mukunda 2022-02-23  453  			acp_writel(val | 0x2, adata->acp5x_base + ACP_I2STDM_ITER);
> 361414dc1f07b7 Vijendar Mukunda 2021-07-21  454  		}
> 361414dc1f07b7 Vijendar Mukunda 2021-07-21  455  	}
> 361414dc1f07b7 Vijendar Mukunda 2021-07-21  456  
> 361414dc1f07b7 Vijendar Mukunda 2021-07-21  457  	if (adata->capture_stream && adata->capture_stream->runtime) {
> 43c5f728cf5937 Vijendar Mukunda 2022-02-23  458  		rtd = adata->capture_stream->runtime->private_data;
> 361414dc1f07b7 Vijendar Mukunda 2021-07-21  459  		config_acp5x_dma(rtd, SNDRV_PCM_STREAM_CAPTURE);
> 43c5f728cf5937 Vijendar Mukunda 2022-02-23  460  		acp_writel((rtd->xfer_resolution  << 3), rtd->acp5x_base + ACP_HSTDM_IRER);
> 43c5f728cf5937 Vijendar Mukunda 2022-02-23  461  		if (adata->tdm_mode == TDM_ENABLE) {
> 43c5f728cf5937 Vijendar Mukunda 2022-02-23  462  			acp_writel(adata->tdm_fmt, adata->acp5x_base + ACP_HSTDM_RXFRMT);
> 43c5f728cf5937 Vijendar Mukunda 2022-02-23  463  			val = acp_readl(adata->acp5x_base + ACP_HSTDM_IRER);
> 43c5f728cf5937 Vijendar Mukunda 2022-02-23  464  			acp_writel(val | 0x2, adata->acp5x_base + ACP_HSTDM_IRER);
> 361414dc1f07b7 Vijendar Mukunda 2021-07-21  465  		}
> 361414dc1f07b7 Vijendar Mukunda 2021-07-21  466  	}
> 43c5f728cf5937 Vijendar Mukunda 2022-02-23  467  	if (adata->i2ssp_capture_stream && adata->i2ssp_capture_stream->runtime) {
> 43c5f728cf5937 Vijendar Mukunda 2022-02-23  468  		rtd = adata->i2ssp_capture_stream->runtime->private_data;
> 43c5f728cf5937 Vijendar Mukunda 2022-02-23  469  		config_acp5x_dma(rtd, SNDRV_PCM_STREAM_CAPTURE);
> 43c5f728cf5937 Vijendar Mukunda 2022-02-23  470  		acp_writel((rtd->xfer_resolution  << 3), rtd->acp5x_base + ACP_I2STDM_IRER);
> 361414dc1f07b7 Vijendar Mukunda 2021-07-21  471  		if (adata->tdm_mode == TDM_ENABLE) {
> 43c5f728cf5937 Vijendar Mukunda 2022-02-23  472  			acp_writel(adata->tdm_fmt, adata->acp5x_base + ACP_I2STDM_RXFRMT);
> 43c5f728cf5937 Vijendar Mukunda 2022-02-23  473  			val = acp_readl(adata->acp5x_base + ACP_I2STDM_IRER);
> 43c5f728cf5937 Vijendar Mukunda 2022-02-23  474  			acp_writel(val | 0x2, adata->acp5x_base + ACP_I2STDM_IRER);
> 43c5f728cf5937 Vijendar Mukunda 2022-02-23  475  		}
> 361414dc1f07b7 Vijendar Mukunda 2021-07-21  476  	}
> 361414dc1f07b7 Vijendar Mukunda 2021-07-21  477  	acp_writel(1, adata->acp5x_base + ACP_EXTERNAL_INTR_ENB);
> 361414dc1f07b7 Vijendar Mukunda 2021-07-21  478  	return 0;
> 361414dc1f07b7 Vijendar Mukunda 2021-07-21  479  }
> 361414dc1f07b7 Vijendar Mukunda 2021-07-21  480  
> 
> ---
> 0-DAY CI Kernel Test Service, Intel Corporation
> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.01.org%2Fhyperkitty%2Flist%2Fkbuild-all%40lists.01.org&amp;data=04%7C01%7CVijendar.Mukunda%40amd.com%7Cc74e88a43d8949965f6208d9f6fb2b64%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637812380936350652%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000&amp;sdata=1hoLSE%2FHFOWzCDQLh174RuY5n6EZ7lnHu%2B0bSXoZUAA%3D&amp;reserved=0
