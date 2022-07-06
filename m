Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 217CF569283
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jul 2022 21:19:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234149AbiGFTTN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jul 2022 15:19:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233680AbiGFTTL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 15:19:11 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2059.outbound.protection.outlook.com [40.107.93.59])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF07B24F32
        for <linux-kernel@vger.kernel.org>; Wed,  6 Jul 2022 12:19:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eNThaMrUpaHd8trbrAi0C6OZ6lot5a/WLgtwDdcxsaATIJaetpTyEKFy++VGSw8eO+PFek0mKgpVsId8HpKvZ3Aiy1gJYpX6DIeE2VY79JieqRmyIZRanizPx/tKJ0ACwVXxEHLt/J0ETrtSUd4eVtOdP4snddcAmVPhi+NRpRar3JBSJwc6xG1xd9f21x/HeC6U9mBNuIEj+1OE4FEUPluQAqW8mOtJnKqiXlIoki7+xUNT/S1Da+iATarLP8D24dZCrzyabDTso4D5n+IhZue7FxqJ2Y8yHaG9L3SfDNJFNiJ3OCL0530Jn1zuJG/zIw76wGYjhZAWcQULfjzVQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SatsY24or/0/iPeK45BZ+1aDXJVqbmT5yo+R8cl+YGg=;
 b=XNsLjn6bMW4OuMWFo+ew08Lg2Z0BPWs5K3XwHyb+GuQMalK9ddAIrSFbqMz/Cbq2sT92m0O9VsLJRaZLfJj2/QBJ+AMTD8mb8T3gophp7xHwqGYdb0RrN4mkx2yy3c4ufX6oMMFWyIzGCDDME1o3pRssxw6EUO1S+xDokLQGU5XtgMhk2gGJGdDX7SOKP9X7sICZJKE+ENJu1sxO/Xp+o/43X3t8gikA73VW5Z7ko5CDNI8Bahs1dLjsWECBHDKwXX6G/rKy8OQ7IKgbkW6XDoNjk0P1rKToEWrYgSYjXiAZeBPkq8HfqPLsLk6MwlB46FI1gVTc0xSDN2RTU6jtrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SatsY24or/0/iPeK45BZ+1aDXJVqbmT5yo+R8cl+YGg=;
 b=PXKfOpVWtVDYqEq03bzjgDCaHIi0eAVm31l245MloRdCRrN2uuYh/JWLG4p7PcYuKvjr1P6waK0fnJ3lhfp3pgeaWkE8AdsmuPZCV+aGyQaViWZqbkI8hISlIIIjoK7lBzEZov2fiYLjEfw4dxWe8iJTu0DCHD9CauMQyV8Hpao=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4123.namprd12.prod.outlook.com (2603:10b6:5:21f::23)
 by MN2PR12MB3615.namprd12.prod.outlook.com (2603:10b6:208:c9::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.15; Wed, 6 Jul
 2022 19:19:00 +0000
Received: from DM6PR12MB4123.namprd12.prod.outlook.com
 ([fe80::6d50:f6c5:cea4:1d95]) by DM6PR12MB4123.namprd12.prod.outlook.com
 ([fe80::6d50:f6c5:cea4:1d95%6]) with mapi id 15.20.5395.021; Wed, 6 Jul 2022
 19:19:00 +0000
Message-ID: <3ce00e2e-6fe5-2f7a-8aab-d630a7235d61@amd.com>
Date:   Thu, 7 Jul 2022 00:51:25 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [ammarfaizi2-block:broonie/sound/for-next 328/352]
 sound/soc/soc-acpi.c:58:36: warning: initialization of 'struct acpi_device *'
 from 'int' makes pointer from integer without a cast
Content-Language: en-US
To:     kernel test robot <lkp@intel.com>
Cc:     kbuild-all@lists.01.org,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
References: <202207070102.kkRe03MS-lkp@intel.com>
From:   "Mukunda,Vijendar" <vijendar.mukunda@amd.com>
In-Reply-To: <202207070102.kkRe03MS-lkp@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0237.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:eb::19) To DM6PR12MB4123.namprd12.prod.outlook.com
 (2603:10b6:5:21f::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 51234fa4-8fb4-458a-f901-08da5f846138
X-MS-TrafficTypeDiagnostic: MN2PR12MB3615:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fgLoLGTEVSemMiHASc07UVEU0R9AwgcRF7W2SSUxnOmaoEywHScKdPG1lP5ifVX7vFhh9Q2OtGc2lb4lGEw6S1EKDWksL7gkF2Dd47PZJatG3/H2mS3nvqD63FUlhjMs7b9uLtgGc28HpDjQ/LuM/bPZmTJh0/EzhfhAum0oS+CyHPhUxkWNIxMcvAoYxSL+ALwPVujUJsYenJdkRovXOiHKe1oX4pXO6Kta93DgYYIBSi/nhjhdSGiQXWYwsdynpW9J4irQox7PoJpy4wEgxP9wyjBIxOOXXu6c/QPKYeUPfnly2E654Sbvu6MEhN1oEc1noLdnoM3kez8tgI36FAdg8TPBG8d6oXPd+ROohVrvaQySvq2TUPS90Vk37ARmmvQBYga66pobC1+Aq3ubXlRkE1ZN7crx+D89E29CHfDU042PJTY7qlsjY6CG/XqQsNzx3z6TEbyKxTMOTU7Dj/t3h48EGpoiNEGPBNV1YVnEQ0w3quMmeV9v7iJEtCgJuWEEdfGzZrOrKTyuHNOpW3g+tlSdbAHQOYH6p/wsVImHfGEpkQ3QsN5KKjoJ2ZMmD1khNXmM11S4d+QLClDMOGU26N4Foo/yh7nhXqmHcwIgX+M5gjlzH7FzDau+sC/rMuJw5cWpSS4ejG+iHZVjmbhqZI3Fax1MkpKBfMnpQ3qCeuwOKSImhqpuZOwMXZsxIKFS76IUCKIBQNSWQtu3cmXmKOGWyRpvtiNITggN0kgaRDrcdgnGcCLcq7rXOC1GOjZC358mvgZ93a3gLE0e6AnBjMo23DmHqB1/yrzsrwLvj+z+L+lFip1ZECvW4ffnJGejquiuM6gE6A2IPXZRc9uHL+z/PPph7FEvEQK+fP3bDfj9vysPUlFrdQvTKo+MLgbgU6ZMs0+KlJtyTwhYd07bnY+HjFf0oHmpPiijdE4=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4123.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(346002)(366004)(396003)(39860400002)(376002)(136003)(186003)(6512007)(26005)(2616005)(86362001)(316002)(45080400002)(38100700002)(31686004)(5660300002)(53546011)(41300700001)(6506007)(6666004)(31696002)(8676002)(478600001)(66556008)(2906002)(66476007)(66946007)(4326008)(83380400001)(6916009)(54906003)(30864003)(966005)(6486002)(36756003)(4001150100001)(8936002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cjZZMDFldTExSm1TeFdDOEZUVEIyM2dnN0o4RkNJdVJlYVVncmNHMnJsZHRQ?=
 =?utf-8?B?TmxUMXRxUTlKdE1xVXNqVHJXUFdnbElQU2pOOFF5MjlLbkhBd0IrSkN2Zm14?=
 =?utf-8?B?K3dwaGw3Z1p3WDZxQ29lTHlvSkN4cGpldnk4eHlqRlk4dXYvZDkzMkVPWkVj?=
 =?utf-8?B?Z1I1OTRLQnNVcnFIb2RCZG5XN2h6dUo4Wm5Tb253bUdqSXZWeC9aam9pSWV5?=
 =?utf-8?B?azU3b2VKL2IzQWYvbHUvZzB0aFRTblVMUXdXamVKamMzbzN3VDhOK3A0WUdN?=
 =?utf-8?B?clkwTUtXTG9Fc1NldTRsckMvTzNtWk5uemg2SGlQWkF4cHVya0RZcVZFUUVa?=
 =?utf-8?B?YUNtNWVBcHFzc3NtODdkWWpjQzZHYW1USGR1OXcvWlFLK1dSYWhYamJ4Q3I1?=
 =?utf-8?B?dncyTGNqMEgzQk1PY2tsSHd3MThwNFFOcGFia0pFeDhxRGhKMG1oVXNhcWM5?=
 =?utf-8?B?aWZKMTUvVEZIUnJrNkl4dXZIbjFDaHR4SXA5MXV3VXdoSlMycGJ0MG1vcU5U?=
 =?utf-8?B?YjcyY0w3bFliSWVsd3ZvRlFEVTgyWlRkenFWbUtGdmhBWEYyUURPa003b081?=
 =?utf-8?B?VlUyUHVFL1VwTGVUZlZMaU02d2ZaNmxmOTNjai9ObDg1ZVVzbkNuU3NuNXRV?=
 =?utf-8?B?NkFsTUhaMTkrc0hHV1VpWFBlZWp1V2hEVysyQ01BcURJZ0kxT21GbzNZWFFl?=
 =?utf-8?B?bTR2UG1FUmt2cXczTVllTFBBN3hxWXN3MnVpZkozZEtDbjZYVUJVZFVOZDRT?=
 =?utf-8?B?YlVMUyt5Y00vV2Y0a2xJT2JjSGZ1K0Y3am5XZm1IVzhXc0czM1ZVc2QwbGJC?=
 =?utf-8?B?dWk1cG1OUWN3SzVEK1hlclJsZWpDT1RJVm1zalVoU1FNVWdIaURRSCtSNFNB?=
 =?utf-8?B?SURqckUzdlkxNG45aGVVbWllN25tWWJ3a2dkZEQ3bkhIOGJ6Y25LZ1k0ODQx?=
 =?utf-8?B?ZFJhL2Y3MHFXc05OSGNpNC9pQVAvU3hyN0dnRE42S0ZrVjJYb016cFlRYS9Q?=
 =?utf-8?B?Nkh2U3B0MzEzd3R4bEpsWGY0M09aSGxWNkdweW4yZy9VLzRQRGM2YkVDaWxp?=
 =?utf-8?B?WTBaVEU1aXUwTXF5MTJLVHU5clcvZ0kyQ1hmQTF5UEl0L1BiT2Q3VzlXZ1Y3?=
 =?utf-8?B?TTArelZrVjJpV2pSUGlzNUdqdUJHdVhidUw1QmIvcmhIQnVUMHJIaXBDbUx3?=
 =?utf-8?B?bXExeTFtbWtCbEU2YmJYWERERTU5QzdpM3V2SVYzMkNBMnhNNHlaOHV0Y0o3?=
 =?utf-8?B?R0Y0VlNRVGszakR6elRIOTVkRXBITnIyVnN5ODdWT3h2MmJ1OG5VLzVSN2pT?=
 =?utf-8?B?NnM5b1BVY1FmbzJMbFROMzB1YUJFdW1GbXpxeDdzOGRlenlnM0FDTGJMSml1?=
 =?utf-8?B?dGh0cGhQTzYxY2h2cFF0SzA0bWtSdklFZUU1V2lEL2kwTC9BNzFkTWVNbDgz?=
 =?utf-8?B?ZDU5NnlUOWtUeGx4dUNPV0Y5bG1LNHNHRmFPeFZmMTZaSXdRdm5lNWx5NmdG?=
 =?utf-8?B?MTc3bHBJU0hKZUJQRnZEaUhtUHU5RGwrelFtVk8xSkM1UlB3MjZIbFZGYlk2?=
 =?utf-8?B?b29Tc1dDZUJHMDBYYXpEMUdBNWxBTjkyN0JTdG5zV1ByM2EwaHhUaHhtRmJu?=
 =?utf-8?B?S3hMZkt6QTFCaXhDQVVuMS9NcDJycnpWRERoRmt2TUY0aHJZT1lyaTRJZ29K?=
 =?utf-8?B?cjd1ZGxacCtpbWprOUg2dHZVQWpCcndYMVlobWFETnliamZycUxQUmpvTTdS?=
 =?utf-8?B?dnVQTDdlUFZmQjNFOEVIS0lWcEt2Qm9QbW9vTUl3SFdSQ21IdEpMWlM3S3Iw?=
 =?utf-8?B?Z0oydjY5TWs2MkZDdGhaMVExR3ZhOS9DSXkxODlLdXJGU1pXZi80UENaRmE0?=
 =?utf-8?B?Slh6TlNLWUhSclpnVEd0OC9xa1ZCcGV6VVhSZ1VDZ1dVaDI1emxabUxtNWhJ?=
 =?utf-8?B?WWVNWWdFdFZhUmVxVEl1U2hZamwrVXc4Ny9XNTFIWllEc1l3Sk5NR29MclRV?=
 =?utf-8?B?dEdUZ0xlNjB0S3VVVm1LQXh2dWRMajdLLy9xQ1hFZkNvWGlsWEpjK2RIaHpw?=
 =?utf-8?B?Q2NXaWxWVHRqc044RUZBYlFXTzVwdFdQL0UvM2sxajRoYWs3UVczTy9ZRnR6?=
 =?utf-8?Q?bsJLuBIlRea9aaGaiEAfOFfB0?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 51234fa4-8fb4-458a-f901-08da5f846138
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4123.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jul 2022 19:19:00.1386
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: paiI8ZUOVUEPh7THBcexO0OniMisKCkGPLhJ1VVf/TnqEZ/QyJ3XRDcD5d4OASqBa/IAhSuxqWr27CLzRb9zUw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3615
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/6/22 11:11 PM, kernel test robot wrote:
> tree:   https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Fgithub.com%2Fammarfaizi2%2Flinux-block&amp;data=05%7C01%7CVijendar.Mukunda%40amd.com%7Cef10db08c5534596339908da5f76dfa5%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637927261404326072%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&amp;sdata=4nJNUAze7X8XcRNnQMsVjN4fcOxaryEqbHl%2Fxt4EWs8%3D&amp;reserved=0 broonie/sound/for-next
> head:   6abb4d7d17ffe320e9b7e22f474e5631c0464524
> commit: f94fa84058014f81ad526641f1b1f583ca2cf32f [328/352] ASoC: amd: enable machine driver build for Jadeite platform
> config: alpha-allyesconfig (https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Fdownload.01.org%2F0day-ci%2Farchive%2F20220707%2F202207070102.kkRe03MS-lkp%40intel.com%2Fconfig&amp;data=05%7C01%7CVijendar.Mukunda%40amd.com%7Cef10db08c5534596339908da5f76dfa5%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637927261404326072%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&amp;sdata=xT%2B7AxR7Er7aOpEfVpsZAAyN%2FYjlPQIfiUJnvy%2BCYH4%3D&amp;reserved=0)
> compiler: alpha-linux-gcc (GCC) 11.3.0
> reproduce (this is a W=1 build):
>         wget https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Fraw.githubusercontent.com%2Fintel%2Flkp-tests%2Fmaster%2Fsbin%2Fmake.cross&amp;data=05%7C01%7CVijendar.Mukunda%40amd.com%7Cef10db08c5534596339908da5f76dfa5%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637927261404326072%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&amp;sdata=4wY5Qb%2BnNN9N4dpLqvjmQhjR%2BonqxNSdeI1i733u7wY%3D&amp;reserved=0 -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Fgithub.com%2Fammarfaizi2%2Flinux-block%2Fcommit%2Ff94fa84058014f81ad526641f1b1f583ca2cf32f&amp;data=05%7C01%7CVijendar.Mukunda%40amd.com%7Cef10db08c5534596339908da5f76dfa5%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637927261404326072%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&amp;sdata=WF9J9A5GimbiqqQiHNsj3InTKUrdQ%2BnzymYIP81bsDo%3D&amp;reserved=0
>         git remote add ammarfaizi2-block https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Fgithub.com%2Fammarfaizi2%2Flinux-block&amp;data=05%7C01%7CVijendar.Mukunda%40amd.com%7Cef10db08c5534596339908da5f76dfa5%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637927261404326072%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&amp;sdata=4nJNUAze7X8XcRNnQMsVjN4fcOxaryEqbHl%2Fxt4EWs8%3D&amp;reserved=0
>         git fetch --no-tags ammarfaizi2-block broonie/sound/for-next
>         git checkout f94fa84058014f81ad526641f1b1f583ca2cf32f
>         # save the config file
>         mkdir build_dir && cp config build_dir/.config
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross W=1 O=build_dir ARCH=alpha SHELL=/bin/bash sound/soc/
> 
> If you fix the issue, kindly add following tag where applicable
> Reported-by: kernel test robot <lkp@intel.com>
> 
> All warnings (new ones prefixed by >>):
> 
>    sound/soc/soc-acpi.c:34:1: error: redefinition of 'snd_soc_acpi_find_machine'
>       34 | snd_soc_acpi_find_machine(struct snd_soc_acpi_mach *machines)

JD platform Machine driver has ACPI dependency. With out ACPI CONFIG
enabled, ACP machine driver shouldn't be compiled.
Will modify the ACPI dependency as "depends on SND_SOC_AMD_ACP && ACPI"
and push the new patch.

-
Vijendar
>          | ^~~~~~~~~~~~~~~~~~~~~~~~~
>    In file included from sound/soc/soc-acpi.c:9:
>    include/sound/soc-acpi.h:38:1: note: previous definition of 'snd_soc_acpi_find_machine' with type 'struct snd_soc_acpi_mach *(struct snd_soc_acpi_mach *)'
>       38 | snd_soc_acpi_find_machine(struct snd_soc_acpi_mach *machines)
>          | ^~~~~~~~~~~~~~~~~~~~~~~~~
>    sound/soc/soc-acpi.c: In function 'snd_soc_acpi_find_package':
>    sound/soc/soc-acpi.c:58:36: error: implicit declaration of function 'acpi_fetch_acpi_dev'; did you mean 'device_match_acpi_dev'? [-Werror=implicit-function-declaration]
>       58 |         struct acpi_device *adev = acpi_fetch_acpi_dev(handle);
>          |                                    ^~~~~~~~~~~~~~~~~~~
>          |                                    device_match_acpi_dev
>>> sound/soc/soc-acpi.c:58:36: warning: initialization of 'struct acpi_device *' from 'int' makes pointer from integer without a cast [-Wint-conversion]
>    sound/soc/soc-acpi.c:64:25: error: invalid use of undefined type 'struct acpi_device'
>       64 |         if (adev && adev->status.present && adev->status.functional) {
>          |                         ^~
>    sound/soc/soc-acpi.c:64:49: error: invalid use of undefined type 'struct acpi_device'
>       64 |         if (adev && adev->status.present && adev->status.functional) {
>          |                                                 ^~
>    sound/soc/soc-acpi.c:80:26: error: implicit declaration of function 'acpi_extract_package' [-Werror=implicit-function-declaration]
>       80 |                 status = acpi_extract_package(myobj,
>          |                          ^~~~~~~~~~~~~~~~~~~~
>    sound/soc/soc-acpi.c: At top level:
>    sound/soc/soc-acpi.c:95:6: error: redefinition of 'snd_soc_acpi_find_package_from_hid'
>       95 | bool snd_soc_acpi_find_package_from_hid(const u8 hid[ACPI_ID_LEN],
>          |      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>    In file included from sound/soc/soc-acpi.c:9:
>    include/sound/soc-acpi.h:44:1: note: previous definition of 'snd_soc_acpi_find_package_from_hid' with type 'bool(const u8 *, struct snd_soc_acpi_package_context *)' {aka '_Bool(const unsigned char *, struct snd_soc_acpi_package_context *)'}
>       44 | snd_soc_acpi_find_package_from_hid(const u8 hid[ACPI_ID_LEN],
>          | ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>    sound/soc/soc-acpi.c:109:27: error: redefinition of 'snd_soc_acpi_codec_list'
>      109 | struct snd_soc_acpi_mach *snd_soc_acpi_codec_list(void *arg)
>          |                           ^~~~~~~~~~~~~~~~~~~~~~~
>    In file included from sound/soc/soc-acpi.c:9:
>    include/sound/soc-acpi.h:51:41: note: previous definition of 'snd_soc_acpi_codec_list' with type 'struct snd_soc_acpi_mach *(void *)'
>       51 | static inline struct snd_soc_acpi_mach *snd_soc_acpi_codec_list(void *arg)
>          |                                         ^~~~~~~~~~~~~~~~~~~~~~~
>    cc1: some warnings being treated as errors
> 
> 
> vim +58 sound/soc/soc-acpi.c
> 
> 8ceffd229f0ef1 sound/soc/intel/common/sst-match-acpi.c Vinod Koul           2016-02-08  54  
> 7feb2f786a46d3 sound/soc/soc-acpi.c                    Pierre-Louis Bossart 2017-10-12  55  static acpi_status snd_soc_acpi_find_package(acpi_handle handle, u32 level,
> 3421894765a345 sound/soc/intel/common/sst-match-acpi.c Pierre-Louis Bossart 2016-11-12  56  					     void *context, void **ret)
> 3421894765a345 sound/soc/intel/common/sst-match-acpi.c Pierre-Louis Bossart 2016-11-12  57  {
> ff4865b3c8cd74 sound/soc/soc-acpi.c                    Rafael J. Wysocki    2022-01-26 @58  	struct acpi_device *adev = acpi_fetch_acpi_dev(handle);
> 59ce3233a538fc sound/soc/soc-acpi.c                    Pierre-Louis Bossart 2021-04-16  59  	acpi_status status;
> 7feb2f786a46d3 sound/soc/soc-acpi.c                    Pierre-Louis Bossart 2017-10-12  60  	struct snd_soc_acpi_package_context *pkg_ctx = context;
> 3421894765a345 sound/soc/intel/common/sst-match-acpi.c Pierre-Louis Bossart 2016-11-12  61  
> 3421894765a345 sound/soc/intel/common/sst-match-acpi.c Pierre-Louis Bossart 2016-11-12  62  	pkg_ctx->data_valid = false;
> 3421894765a345 sound/soc/intel/common/sst-match-acpi.c Pierre-Louis Bossart 2016-11-12  63  
> ff4865b3c8cd74 sound/soc/soc-acpi.c                    Rafael J. Wysocki    2022-01-26  64  	if (adev && adev->status.present && adev->status.functional) {
> 3421894765a345 sound/soc/intel/common/sst-match-acpi.c Pierre-Louis Bossart 2016-11-12  65  		struct acpi_buffer buffer = {ACPI_ALLOCATE_BUFFER, NULL};
> 3421894765a345 sound/soc/intel/common/sst-match-acpi.c Pierre-Louis Bossart 2016-11-12  66  		union acpi_object  *myobj = NULL;
> 3421894765a345 sound/soc/intel/common/sst-match-acpi.c Pierre-Louis Bossart 2016-11-12  67  
> 3421894765a345 sound/soc/intel/common/sst-match-acpi.c Pierre-Louis Bossart 2016-11-12  68  		status = acpi_evaluate_object_typed(handle, pkg_ctx->name,
> 3421894765a345 sound/soc/intel/common/sst-match-acpi.c Pierre-Louis Bossart 2016-11-12  69  						NULL, &buffer,
> 3421894765a345 sound/soc/intel/common/sst-match-acpi.c Pierre-Louis Bossart 2016-11-12  70  						ACPI_TYPE_PACKAGE);
> 3421894765a345 sound/soc/intel/common/sst-match-acpi.c Pierre-Louis Bossart 2016-11-12  71  		if (ACPI_FAILURE(status))
> 3421894765a345 sound/soc/intel/common/sst-match-acpi.c Pierre-Louis Bossart 2016-11-12  72  			return AE_OK;
> 3421894765a345 sound/soc/intel/common/sst-match-acpi.c Pierre-Louis Bossart 2016-11-12  73  
> 3421894765a345 sound/soc/intel/common/sst-match-acpi.c Pierre-Louis Bossart 2016-11-12  74  		myobj = buffer.pointer;
> 3421894765a345 sound/soc/intel/common/sst-match-acpi.c Pierre-Louis Bossart 2016-11-12  75  		if (!myobj || myobj->package.count != pkg_ctx->length) {
> 3421894765a345 sound/soc/intel/common/sst-match-acpi.c Pierre-Louis Bossart 2016-11-12  76  			kfree(buffer.pointer);
> 3421894765a345 sound/soc/intel/common/sst-match-acpi.c Pierre-Louis Bossart 2016-11-12  77  			return AE_OK;
> 3421894765a345 sound/soc/intel/common/sst-match-acpi.c Pierre-Louis Bossart 2016-11-12  78  		}
> 3421894765a345 sound/soc/intel/common/sst-match-acpi.c Pierre-Louis Bossart 2016-11-12  79  
> 3421894765a345 sound/soc/intel/common/sst-match-acpi.c Pierre-Louis Bossart 2016-11-12  80  		status = acpi_extract_package(myobj,
> 3421894765a345 sound/soc/intel/common/sst-match-acpi.c Pierre-Louis Bossart 2016-11-12  81  					pkg_ctx->format, pkg_ctx->state);
> 3421894765a345 sound/soc/intel/common/sst-match-acpi.c Pierre-Louis Bossart 2016-11-12  82  		if (ACPI_FAILURE(status)) {
> 3421894765a345 sound/soc/intel/common/sst-match-acpi.c Pierre-Louis Bossart 2016-11-12  83  			kfree(buffer.pointer);
> 3421894765a345 sound/soc/intel/common/sst-match-acpi.c Pierre-Louis Bossart 2016-11-12  84  			return AE_OK;
> 3421894765a345 sound/soc/intel/common/sst-match-acpi.c Pierre-Louis Bossart 2016-11-12  85  		}
> 3421894765a345 sound/soc/intel/common/sst-match-acpi.c Pierre-Louis Bossart 2016-11-12  86  
> 3421894765a345 sound/soc/intel/common/sst-match-acpi.c Pierre-Louis Bossart 2016-11-12  87  		kfree(buffer.pointer);
> 3421894765a345 sound/soc/intel/common/sst-match-acpi.c Pierre-Louis Bossart 2016-11-12  88  		pkg_ctx->data_valid = true;
> 3421894765a345 sound/soc/intel/common/sst-match-acpi.c Pierre-Louis Bossart 2016-11-12  89  		return AE_CTRL_TERMINATE;
> 3421894765a345 sound/soc/intel/common/sst-match-acpi.c Pierre-Louis Bossart 2016-11-12  90  	}
> 3421894765a345 sound/soc/intel/common/sst-match-acpi.c Pierre-Louis Bossart 2016-11-12  91  
> 3421894765a345 sound/soc/intel/common/sst-match-acpi.c Pierre-Louis Bossart 2016-11-12  92  	return AE_OK;
> 3421894765a345 sound/soc/intel/common/sst-match-acpi.c Pierre-Louis Bossart 2016-11-12  93  }
> 3421894765a345 sound/soc/intel/common/sst-match-acpi.c Pierre-Louis Bossart 2016-11-12  94  
> 
> :::::: The code at line 58 was first introduced by commit
> :::::: ff4865b3c8cd746ef72f59bdd485848b4cebd43d ALSA: Replace acpi_bus_get_device()
> 
> :::::: TO: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> :::::: CC: Takashi Iwai <tiwai@suse.de>
> 

