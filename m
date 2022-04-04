Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D92504F16BA
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Apr 2022 16:04:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376826AbiDDOGZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Apr 2022 10:06:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376819AbiDDOGW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Apr 2022 10:06:22 -0400
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam07on2063.outbound.protection.outlook.com [40.107.95.63])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D67E167F4;
        Mon,  4 Apr 2022 07:04:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Wo8yx8yr9f4EVrCo9d0jK6mVlwLechXMZxFWSyesFwINQTJkPTdvWlD8A9yeDVCxJu4q6k797kQpgb/uDhHT8OmRJ6Jx2ALP7Y42OvgxV2tk1+iQR2YAgK5MN6AVKoBxjoZMPuqTHNnrH90fhnaKmLSkSccwS2AJXPkvuDomMPiNirbcNbQJlMT/YRerKlrY1j8VR3fbgBhIg3okcceJd4Wk8sgusV2zAbh2hGQ+L/tYssL87Vt54z8eKIDEI4sLt7S03+ZP2wSkgOMy2pLkb8ERSdL3nmV9mSXyl5uSuqSoGqeJnKZrMCsqF/js5dVNf3BTGuzCdj6mAtDOYwSdtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qcBhrOOaq8iRPsPHVZ5B3zVEo8x01fPlB16rMkQUhb8=;
 b=UG4+7OdACeYa86qrh3NtkEF2pDxbwCJG4SmcQOHPAjytDuoGwdx/iR4+n59inBWBgPcnHuIxi/56jNFgfwjNdJZmk2upJgcbTb3S0I5IeYkTo9rGt7OpLJH8h8bJuPxZi8labsAVNIAOwhIltUYj2MrSwZfUsfNCpvkrhytaQ6An+hQUMYqca/5OYXNh6unD4H880vYRiPafWVi0L95wuSrPTkuFvC6fHgiawmRydA/TJGe0CKSbZoK3SXDBua4sHxsPnThJS0uZ2ZwMTkHHLA31HYx2D8cBOh/wA6Zk966LsTVBpj+avgA+PGnyeFUsRT2lQWqazWLC/O8/oyTHlg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qcBhrOOaq8iRPsPHVZ5B3zVEo8x01fPlB16rMkQUhb8=;
 b=mBN50vjQ2XEKYQqSuIuCAUygIbTrEaiva+bDYkKxPb7R5c0PEy5MVUaOjhD+kCtdFk2sLT/ES8rFuu+fv6URnqHngqq4iMs3uxdB/LbztiNe2e5KETJkuHDNM7a1AdUObiy2DyQHtSY9IyriOKP9VyMzecS3x+F60uD1UyIeF+o=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5040.namprd12.prod.outlook.com (2603:10b6:5:38b::19)
 by BL1PR12MB5333.namprd12.prod.outlook.com (2603:10b6:208:31f::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.31; Mon, 4 Apr
 2022 14:04:24 +0000
Received: from DM4PR12MB5040.namprd12.prod.outlook.com
 ([fe80::313b:8981:d79a:52d0]) by DM4PR12MB5040.namprd12.prod.outlook.com
 ([fe80::313b:8981:d79a:52d0%5]) with mapi id 15.20.5123.031; Mon, 4 Apr 2022
 14:04:23 +0000
Message-ID: <056621a6-b6ac-90d9-c409-ba5d9404c868@amd.com>
Date:   Mon, 4 Apr 2022 19:34:09 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: Bug 215744 - input from the accelerometer disappeared, regression
 on amd_sfh on kernel 5.17
Content-Language: en-US
To:     Marco <rodomar705@protonmail.com>,
        ",Thorsten Leemhuis" <regressions@leemhuis.info>,
        Basavaraj Natikar <Basavaraj.Natikar@amd.com>
Cc:     Jiri Kosina <jkosina@suse.cz>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        linux-input@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "regressions@lists.linux.dev" <regressions@lists.linux.dev>,
        Marco <rodomar705@protonmail.com>
References: <048ef583-4a8f-96b0-68a3-45ab9ec8d6df@leemhuis.info>
 <0499f8ae-6966-be4b-5af8-e7e568bfcd5f@amd.com>
 <6fe27103-5e35-5f16-d213-29bd71412f5b@leemhuis.info>
 <7dfb121f-848c-873e-f3cc-43239c264f21@amd.com>
 <0a33735c-dd43-4305-ff92-7b9ac2c6a0d9@leemhuis.info>
 <539ff0c5-a95b-836d-e1c6-39f64ee2a418@leemhuis.info>
From:   Basavaraj Natikar <bnatikar@amd.com>
In-Reply-To: <539ff0c5-a95b-836d-e1c6-39f64ee2a418@leemhuis.info>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN2PR01CA0180.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:26::35) To DM4PR12MB5040.namprd12.prod.outlook.com
 (2603:10b6:5:38b::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5578dfe3-ff2b-45c9-f6d1-08da164405d4
X-MS-TrafficTypeDiagnostic: BL1PR12MB5333:EE_
X-Microsoft-Antispam-PRVS: <BL1PR12MB5333A14D1C1CE0879FD558ECE6E59@BL1PR12MB5333.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: v6yvWHwWSz6mH5r6FbICIrLBm6M8cxvePKhsLJ8yZz453cDXCBAB4KLUTAVOEMNHmOY2lF41AGc0K3Fd6oL5J1r+jwxFPDVWBkR6yqqXjGKqkTEf9Xqbi9TJQ+UlkSxQSPe3ZRfmP+67pPTk1x5z7g6dut00psG8+KDSKL5uZV6NYswSKIUwG3LhRJMBJkEdrCfhJH3i9jV4M/0OEk/Tu+OTviQHWFGAqNygGRadlhTtfcGee9sIU1XPKzhGHqwfttiH+NRKWHUNNbf58PGMdZoFm/CfemNwdsU0g8g6WDaAbJN9DeKf4vYAZuax/hVcCZpUpHzP9G24fXZKRxRzES6EH7rQajQljUobPqNTvUM9+JB3aEAE8b8j/+cLw2AJKb+oPdwN5VaYOK73kgAXdBr8m3q1lx25L48Eyz83OHSkG4hVcqbjcJchVp1bgjxqvDHgE/bU79w5JFgSSMOpWiC7HyAYqrululVA5H6raQKFKgk/lu6BLJZg8ogcMzZQz4P9RVjqxq+iY49tVqV6+rqhf7dNahPdG8cRuwdBZWEC3a7S046bTgKrvMA9PG4Kut2UyXqn9Ju37u+TNfZ96ctSsOLIyAl79/tjty7j+9znmyDWU9hH0KCSY//OC/AgwnZ7GoUvewGFSsvfe51lMpFpiNEYTIO4DWgV8TE4G1n20KMEnxqFxADVfnR8ZchHWK08WIKDo9A8m1lq3zlde3ouOKeQRhk43NFIsorNYiRoytTJjigWha0/Wxvpe1f5+K59q5b6O6Hht2V3d4BzTzuZgNvk0M9WVBAcRtZKEdrzDftxSdxz7qGLeXxu8lkZwAAp6dLL56VoKp4BWQthQ+pYeGSvf0pYbfx75KMkcZs=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5040.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(84040400005)(66476007)(4326008)(54906003)(8676002)(5660300002)(6512007)(966005)(6666004)(110136005)(6506007)(31686004)(45080400002)(6636002)(316002)(508600001)(6486002)(83380400001)(66556008)(186003)(26005)(53546011)(36756003)(66946007)(38100700002)(2616005)(31696002)(8936002)(2906002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZTF3ZWNnaktqLzVqZ2IxMEF5YnVyYlFRa3R2SDVYYTYwdE1DVDJyUTJoV1Aw?=
 =?utf-8?B?ZllBTXc0T2NzQWhlWW9CYkNrOWo0OWMvR0FpQi9aZFFoZTRkK0hIR1lES2Jz?=
 =?utf-8?B?Z0pIU0JKc0V5L2dYWVNta0g1WTdoWnlzNjRLc2RPUzZMVTYvVklzREZ4UWNL?=
 =?utf-8?B?RHh0WE9HYTRCRWU2eUNSbHNFRmVxOGwvK1N1SHhKRU83aTZlVUkvdzhLUy9O?=
 =?utf-8?B?Wjhoc3UrdW01dURpbXNYMmcyNjFUcmViQndiL0NwU2dKWEpaQlpyWWZkT2JK?=
 =?utf-8?B?UTRVWlhaUFJIMEM3M2hybkd3SmJoUkNFaU43SFc1L2pUbTQyeEZFdjVYU0Z4?=
 =?utf-8?B?S21oVW5udURmZ1pWcGtyeFpib3VJWUNBRks1aFBWQUcxbXluRlRWazQ0c2Nm?=
 =?utf-8?B?aTdlY05iZDkyYjlhckl2djQzcDVLY1dvQ2dKV3ZHMGhsNUNoeHAvQ3h0em9q?=
 =?utf-8?B?cHpPUTllK004dXZPT3kzM1A1U2xUUVVWQ3hwbFo1VGYwc29nNkwySEF4QXRq?=
 =?utf-8?B?Y1RJZ1kyKzdEaFA4M1kwR2VYWllGNmxVSmFaZ0t2WmZ6NForR3R5d3kvdExj?=
 =?utf-8?B?SkNkL1NpVkp2QTNtU3RlWVVwRnRrdFliQ1V2T3EybHJVdEZvNi9lamEyWmMy?=
 =?utf-8?B?TU9rR0Z5dzY0T0lRR3QvTk10b2F4UlpqU3A2K1p0VW1DbjNuMHNzT2orTzBR?=
 =?utf-8?B?endEM3dIK2dQNzliWFI2UlpDeDgrZUpta0VzVkZjWlhUMnFXb0pBaHhUbzV6?=
 =?utf-8?B?N3dpR3o2am8zU3hxcHJ4bXJyYk9MZFRjMC9FS0g0STNJRmxHeEkrektmUnBV?=
 =?utf-8?B?VkpaSmc5c21welFFZ09MOEh3c3ZkWW1qUlJ3TE55SzJvNEswRWpubG9IbEF5?=
 =?utf-8?B?K242NU12a245SzViaXdEZ2gyOENzTHp5R2t6dVJMZjNsQjhIemZlZ0JyRlVs?=
 =?utf-8?B?SWhLQk1haDlxeTUzaU5kMkZ2TkZXdHBJVWVIUnJBOW9WWTY2MS9HSGRJZlRD?=
 =?utf-8?B?NStVdkFvTWI3OXZSOUs2b0l6ZHVURmIvN0o5ZHp4Z1hDN1h4dFQyVkZ0NTFW?=
 =?utf-8?B?c2w0aWlJK2JuOFNyU1JIVmhEdE5XbWtoY290VnpRaW81KzVDNmM1TXRMV1FQ?=
 =?utf-8?B?SlhRRXpXWkE2NXhJZm91NDhvR09ScXhPR010M3JTYTZyLzEzbTZiTU93eHBv?=
 =?utf-8?B?aVRob20zUG8wOXFma0NnaGtsOStXZEdyTCs1NWVGSlNlT2VtOXRQK3NLLzZP?=
 =?utf-8?B?WnY2TUZLUE9PUHJTY09STCtuWlhvdThJWTMzanJ4Y0FwVDlGSXYvTEdXRUJt?=
 =?utf-8?B?MkhZVG9UMTRTQUhzNlR0TllFSzVEOXJpcmVQemIzT29CRkk2dTZ5K014OGY4?=
 =?utf-8?B?WWVTNFpnaEc4V043TEEzOFhId3ZPRDJwZ1BDK3NrS1dNZm5sSjh4ZXZXRVVj?=
 =?utf-8?B?K0VRL0pVTldIWGZ3dkZ2RGxOTFRlclc3c3ZVZnJHaTNwbnVuYjBCVUhqS1hs?=
 =?utf-8?B?MmlGcDlBQkVYR0VocWw5a0Qrc2pjZm1UM1dhbWVteVRmOEk4dStuSFV1eVR6?=
 =?utf-8?B?OVJUV2tGYUZGWWZDaEdRNmhHZk9TMUZuOStBVVZCRmFEeTkybHJqZUZMWi9E?=
 =?utf-8?B?UkxsODBTbW9VQStBeDdtWkxmZFVGblhONnFCT3pBeU5VTzRzbHRkTGpmek1j?=
 =?utf-8?B?UGZmVjQwbGlHTXRkakQxTmFMWC9tb2ZUalMwZFRNdkVPVDJZMm00RytOa3BN?=
 =?utf-8?B?bUJEMXJyVlJ1QkNKS0lPR0lCck1nSVNkYmRQQ1BNTHc5elFjNkE4Q25VbDdZ?=
 =?utf-8?B?SCtBSUxDWFQvR3VUc2hUaUp2K2RtOEMzb2M3eVNqU1FTak9xQ0VHYTFJdVpu?=
 =?utf-8?B?MStIVjVmVlhWVDNKMk9DK0NPcGc2UUcza2xzYkx0T2pmc083ODhORENOVmlz?=
 =?utf-8?B?a1R6TDBxcFoxUVRvRHhidWJZaGNDR1pDN3JHMnlzdnRBOXE0Y0luUlVmUzNj?=
 =?utf-8?B?TVlPMHRWUFgzVzdrdEdIeFpuZ0FFbUltRzl0UFlLS2tqeExSTkEvTzNqeU1v?=
 =?utf-8?B?VXZBSmpkRlptV2x0cko1bDlIVkZxZnArMTBhbzZlRyttR0JnMWlLMGx2Nlov?=
 =?utf-8?B?S3kraFI0Slh2NjFkTzluek04endja1BKV2d6d3NUZXh3VmI4VmxJYmVVRkRJ?=
 =?utf-8?B?QU5iNXdveGhrayt3ZVRlaXBjNjRlVVU3dFBRK1AzZ0xxVmQvRjluM3p6NmVa?=
 =?utf-8?B?ZTFrS1VNL2JnVHVvbEJaSEZVcGZqR0k2TGk3NC95b3hvVG9jQ3o0ajlwdXM1?=
 =?utf-8?B?cFArbUM5bVdwc2hUWlU3RHB2NzE2YnRPQjN3UW9uOXdjQlc5UVZOZz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5578dfe3-ff2b-45c9-f6d1-08da164405d4
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5040.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Apr 2022 14:04:23.9351
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JdIUcNrijOI7xylMdaCZWvz2Y36c4NIgXdDrAiWrXGaInDxC3HfpVpYsyTiIogNkOXREvpDC4jH5wx4kf6G+IA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5333
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/4/2022 7:23 PM, Thorsten Leemhuis wrote:
> On 04.04.22 09:25, Thorsten Leemhuis wrote:
>> On 04.04.22 09:18, Basavaraj Natikar wrote:
>>>
>>> On 4/4/2022 12:05 PM, Thorsten Leemhuis wrote:
>>>> On 01.04.22 21:47, Basavaraj Natikar wrote:
>>>>> Committed patch is disabling the interrupt mode and does not cause any
>>>>> functionality or working issues.
>>>> Well, for the reporter it clearly does cause problems, unless something
>>>> in testing went sideways.
>>>>
>>>>> I also cross verified on 3 system and working fine on 5.17 and not able
>>>>> to reproduce or recreate.
>>>>> [...]
>>>>> ------------------------------------------------
>>>>>
>>>>> Looks like this is not regression. May be some hardware/firmware bug.
>>>> Well, from the point of the kernel development process it afaics is a
>>>> regression, unless the testing went sideways. It doesn't matter if the
>>>> root cause is in fact a hardware/firmware bug, as what matters in the
>>>> scope of the kernel development is: things worked, and now they don't.
>>>> For details please check this file and read the quotes from Linus:
>>> can you help to answer the below questions:
>> Me? No, I'm just the Linux kernels regression tracker trying to make
>> sure all regressions are handled appropriately. :-D
>>
>> Marco, can you help out here?
> Marco replied in private and allowed me to forward his reply:
>
> ```
> I can't since, as mentioned previously, this is the only AMD laptop
> device that I have.
> I am sure this is a regression for me, even if the issue is firmware
> related. I have tested the 5.17 stock arch kernel and the sensor is
> gone. With the last three patches reverted the sensor is back and
> working fine.
>
> I would love to verify if the issue is hardware or software related, but
> being outside of AMD and with AMD not releasing any public information
> with datasheet/specification on their Sensor Fusion Hub I really can't
> say anything specific.
>
> This still remains a regression, since the hardware was working before
> and now it doesn't.
>
> By the way, I already have seen also this rework of this specific driver
> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Fgithub.com%2Fconqp%2Famd-sfh-hid-dkms&amp;data=04%7C01%7CBasavaraj.Natikar%40amd.com%7C05891d0582f94d68e7f908da164272ca%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637846771908092322%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000&amp;sdata=nAmJdcP2ALl9cEaejWezLb9B3bU5Omp72Z6kjTbaBRY%3D&amp;reserved=0 that even added a still
> missing handler for the lid sensor switch for disabling touchpad and
> keyboard, and all efforts tried to merge it upstream with all sorts of
> issues.
>
> Regardless of everything, this is a driver supported in kernel by AMD
> engineers, so all of this doesn't matter. On my hardware this three
> patches break a previously working hardware.
> ```

Thank You Marco for the information. 

Could you please provide me below results for acceleration
by re-applying and reverting patch once again on same laptop.

Did you attempt to test it multiple times on the tip of the git to see
if the problems goes away?

if same test is performed multiple times with or without reverting patch
on same laptop on which issue is observed
we may see same working/issue behavior. if it is regressing then always
it should work with or without reverting patches on same laptop. is this
the case here?

Thanks,

Basavaraj


> Ciao, Thorsten
>
>> Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
>>
>> P.S.: As the Linux kernel's regression tracker I'm getting a lot of
>> reports on my table. I can only look briefly into most of them and lack
>> knowledge about most of the areas they concern. I thus unfortunately
>> will sometimes get things wrong or miss something important. I hope
>> that's not the case here; if you think it is, don't hesitate to tell me
>> in a public reply, it's in everyone's interest to set the public record
>> straight.
>>
>>> Did you attempt to test it multiple times on the tip of the git to see
>>> if the problems goes away?
>>>
>>> if same test is performed multiple times with or without reverting patch
>>> on same platform (laptop/hardware/firmware) on which issue is observed
>>> we may see same working/issue behavior. if it is regressing then always
>>> it should work with or without reverting patches on same laptop. is this
>>> the case here?
>>>
>>> I don't see any regression here. I requested to retest with other
>>> hardware/platform/system also as per my above test (output) all working
>>> fine in 3 different platforms and not able to reproduce or recreate for
>>> my side on 5.17.
>>>
>>> Thanks,
>>>
>>> Basavaraj
>>>
>>>> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Fgit.kernel.org%2Fpub%2Fscm%2Flinux%2Fkernel%2Fgit%2Fnext%2Flinux-next.git%2Fplain%2FDocumentation%2Fprocess%2Fhandling-regressions.rst&amp;data=04%7C01%7CBasavaraj.Natikar%40amd.com%7C05891d0582f94d68e7f908da164272ca%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637846771908092322%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000&amp;sdata=9ORA2inmfocvEJ%2FXOov67q2ebzZrcuguViSPV%2B58yA0%3D&amp;reserved=0
>>>>
>>>> Ciao, Thorsten
>>>>
>>>>> Just curious reverting this patch how it is working just suspecting
>>>>> firmware undefined behavior.
>>>>>
>>>>> If possible, please check on other platform/system also if same behavior
>>>>> occurs.
>>>>>
>>>>> Could you please provide me platform/system details so that I can check
>>>>> this behavior?
>>>>>
>>>>> Thanks,
>>>>> Basavaraj
>>>>>
>>>>> On 4/1/2022 1:36 PM, Thorsten Leemhuis wrote:
>>>>>> Hi, this is your Linux kernel regression tracker.
>>>>>>
>>>>>> I noticed a regression report in bugzilla.kernel.org that afaics nobody
>>>>>> acted upon since it was reported about a week ago, that's why I decided
>>>>>> to forward it to the lists and all people that seemed to be relevant
>>>>>> here. It looks to me like this is something for Basavaraj, as it seems
>>>>>> to be caused by	b300667b33b2 ("HID: amd_sfh: Disable the interrupt for
>>>>>> all command"). But I'm not totally sure, I only looked briefly into the
>>>>>> details. Or was this discussed somewhere else already? Or even fixed?
>>>>>>
>>>>>> To quote from https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Fbugzilla.kernel.org%2Fshow_bug.cgi%3Fid%3D215744&amp;data=04%7C01%7CBasavaraj.Natikar%40amd.com%7C05891d0582f94d68e7f908da164272ca%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637846771908092322%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000&amp;sdata=pLGKHCV1ZNrXghGdDFG16sguRA8xi0VzUSG%2Fbw%2FQsBw%3D&amp;reserved=0 :
>>>>>>
>>>>>>>  Marco 2022-03-25 15:22:19 UTC
>>>>>>>
>>>>>>> After updating to 5.17, the input from the accelerometer disappeared, completely. No devices available from IIO tree. First bad commit causing it is https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Fgit.kernel.org%2Fpub%2Fscm%2Flinux%2Fkernel%2Fgit%2Ftorvalds%2Flinux.git%2Fcommit%2Fdrivers%2Fhid%2Famd-sfh-hid%2Famd_sfh_pcie.c%3Fid%3Db300667b33b2b5a2c8e5f8f22826befb3d7f4f2b&amp;data=04%7C01%7CBasavaraj.Natikar%40amd.com%7C05891d0582f94d68e7f908da164272ca%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637846771908092322%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000&amp;sdata=L36JFc%2BnejM4bJXfNui49v2uJKrS4cJnU93dpEhXPms%3D&amp;reserved=0. Reverting this and the the other two on top fixed this. Tried to not revert only the above mentioned commit, but it's still not working.
>>>>>>>
>>>>>>> Marco.
>>>>>> Anyway, to get this tracked:
>>>>>>
>>>>>> #regzbot introduced: b300667b33b2b5a2c8e5f8f22826befb3d7f4
>>>>>> #regzbot from: Marco <rodomar705@protonmail.com>
>>>>>> #regzbot title: input: hid: input from the accelerometer disappeared due
>>>>>> to changes to amd_sfh
>>>>>> #regzbot link: https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Fbugzilla.kernel.org%2Fshow_bug.cgi%3Fid%3D215744&amp;data=04%7C01%7CBasavaraj.Natikar%40amd.com%7C05891d0582f94d68e7f908da164272ca%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637846771908092322%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000&amp;sdata=pLGKHCV1ZNrXghGdDFG16sguRA8xi0VzUSG%2Fbw%2FQsBw%3D&amp;reserved=0
>>>>>>
>>>>>> Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
>>>>>>
>>>>>> P.S.: As the Linux kernel's regression tracker I'm getting a lot of
>>>>>> reports on my table. I can only look briefly into most of them and lack
>>>>>> knowledge about most of the areas they concern. I thus unfortunately
>>>>>> will sometimes get things wrong or miss something important. I hope
>>>>>> that's not the case here; if you think it is, don't hesitate to tell me
>>>>>> in a public reply, it's in everyone's interest to set the public record
>>>>>> straight.
>>>>>>
>>>
>>>

