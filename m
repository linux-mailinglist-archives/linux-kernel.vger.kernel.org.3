Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86A7E509C39
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 11:33:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1387609AbiDUJ1P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 05:27:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1386678AbiDUJ1H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 05:27:07 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2076.outbound.protection.outlook.com [40.107.94.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AA5E27B06;
        Thu, 21 Apr 2022 02:24:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Dv6xTqMVbdd2RMs79yMDIwLC/KTUAQTCcgqXMRC+/df/1P/SNm17kMzz2podSH88n9yelaWSW60lrczngHFgLItPEVIGZZB4A4FOYxUNtY6HKKl38488nW4pVQp7pp1S7x9mlljs76yrD6Bf9ii6oSELiQ/Ufx57EqtJoPvj0cbvaYXgJZdr0VJpnvU3toQo4ynPd5QkklC3e6eB2XXpgxdZ0iTPN/4f2Hev7IvzEkdYj/tV7FSkMX92gcZL2Vaj+WaRjp5NAzM/x2qA882h9DMJb5w6ek/gONx5J6l6AScL97TmlwcAVcYbQxmtBKRECaEY2JAJxc8Rw4CCmXpXrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O0qm1MR23+JNAY07FG3ySRyEGvltrXW8ptWV0/x5bSQ=;
 b=Eb/GY/wbYJ2FzKU25OkLu6Jan7p6JgCgfk6xLiYkripIkDz852xiVQJMGZCanBt6WAeHB3Gs5+GbhtsVFpGYGnvQaAkrY+b60TxasAi7AVWOMYI+BDwfKp/cmMvdhCBHhShZB+iSS7EPlaUNgthcyzjmQXA67jML/BlI4tdEtqMAy9kxVk3oNqb4Zs4XulBUPs/lkM8IpwZElhOgA0IsuYmY1mI7SD1URGKl0fkiDhkMkQqxigjUkIfNh96J5Itlr5WzMGZxVQcG9zhJvTFMBFgCsFUAZpv6xuBY5G9AlxCkyFcQrmKpx2GmQm//C2wFGRUQ+LiR2P2pwDsuvKEqvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O0qm1MR23+JNAY07FG3ySRyEGvltrXW8ptWV0/x5bSQ=;
 b=nY1F2eH61ak634eOn2QLTSDAtfsPYztJsN043zUOjJMjN+EyZJ8eTRNAcL0FdQRaLsvji2gSeherKIM/eHG1g0z6M0aMumvhk4ofEskZp6hZm8iNNW9igOCEcThG0YlDq3qnmIIeV8tTm+SvvE4mykvx/eVg6c+mhk/16bQ+duU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5040.namprd12.prod.outlook.com (2603:10b6:5:38b::19)
 by MW5PR12MB5684.namprd12.prod.outlook.com (2603:10b6:303:1a1::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5164.20; Thu, 21 Apr
 2022 09:24:15 +0000
Received: from DM4PR12MB5040.namprd12.prod.outlook.com
 ([fe80::6480:2f5a:7cd7:e0c7]) by DM4PR12MB5040.namprd12.prod.outlook.com
 ([fe80::6480:2f5a:7cd7:e0c7%4]) with mapi id 15.20.5186.013; Thu, 21 Apr 2022
 09:24:15 +0000
Message-ID: <edc92502-872f-9115-383c-d2d5abab1125@amd.com>
Date:   Thu, 21 Apr 2022 14:54:03 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: Bug 215744 - input from the accelerometer disappeared, regression
 on amd_sfh on kernel 5.17
Content-Language: en-US
To:     Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Marco <rodomar705@protonmail.com>
Cc:     regressions@leemhuis.info, Basavaraj.Natikar@amd.com,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        regressions@lists.linux.dev, jkosina@suse.cz
References: <048ef583-4a8f-96b0-68a3-45ab9ec8d6df@leemhuis.info>
 <0499f8ae-6966-be4b-5af8-e7e568bfcd5f@amd.com>
 <6fe27103-5e35-5f16-d213-29bd71412f5b@leemhuis.info>
 <7dfb121f-848c-873e-f3cc-43239c264f21@amd.com>
 <0a33735c-dd43-4305-ff92-7b9ac2c6a0d9@leemhuis.info>
 <539ff0c5-a95b-836d-e1c6-39f64ee2a418@leemhuis.info>
 <056621a6-b6ac-90d9-c409-ba5d9404c868@amd.com>
 <-IeN6GQXuvFeZGmf-HSltWI3MN3V02oQzXAW0XR74vD62w_Fo_A6lSfJXrDgV2MTrHs9Id2Ce_r9J_zZCKx67DnVAWeFg3-ULIZ2GSm_ITQ=@protonmail.com>
 <xZsLVmWExSSYgHXHsfOKkB7SbLy-bltitpJznKV1HHsv2-_ZcSFArnir30v-7Eg8zqmGSMmZi3Cr7YHpB8tD_FVnBvf2W-VsmmFGdc7hlWw=@protonmail.com>
 <nqBA6pARHM6h_5hMj32zIxq_lgo2z8mmj7FPM5bXBv5DhWmh4K5Qv3MbKfAAi0tXlRy2IFYtfgyk2i_GPLIH5xsJ1hKBaLstHiNI1IEdUVc=@protonmail.com>
 <CAO-hwJL80Oz071zGj93MkZ4vn+ewdgExZhOBM5TyhTEvvhcqOg@mail.gmail.com>
From:   Basavaraj Natikar <bnatikar@amd.com>
In-Reply-To: <CAO-hwJL80Oz071zGj93MkZ4vn+ewdgExZhOBM5TyhTEvvhcqOg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN2PR01CA0165.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:26::20) To DM4PR12MB5040.namprd12.prod.outlook.com
 (2603:10b6:5:38b::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 95692051-351a-4dc2-98dc-08da2378b3ff
X-MS-TrafficTypeDiagnostic: MW5PR12MB5684:EE_
X-Microsoft-Antispam-PRVS: <MW5PR12MB5684076A9EEF65F0FE4CE619E6F49@MW5PR12MB5684.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FfZiouzEKWI8KIGapUBBLD+jzjGjkkzPxSoH0CkE8f/J1uxHSw+ZuFAbFrFGxE5o4Mwk3G7QFgAIMGO2f0fN6QyXbM/Cj2YAOduoiI3n7ddm6X+4znRei1gmatmBe/F6AWZTQUgrS0NaV1mXcdtlJoj+AY5zjR1iwlxakiQCynq6DYY8T3py10YOqhbtDExBEF0AHTum5IC9JBMOD8To5w7s9dP0AYThAn5wvd8v4xo9N8MINjshjXQngkpGlp0ik9aA4tbhiNBDjf53s6o/cQyDVTZp4E+7g1Nums/7KgWqcbuImxNOOCJ4m+/K5AGLJDpbTfEX9msoLowQ/ebHA1LgzRaFM47Tv0N39AUtI7sMhZZ7pc9gCeD4AOMSRJD2f8D1eabkxwqfJ0u0EWqIyeHtHnqHpD1ms1NhUbvqiB3wJQH6PW2mJJe5CgUQnte4N/FOrYEw5qdsW2DSs3KAOpusIPPiEg5vfmrcwoAxn9Lul7jwwPU1YkuonoREarGWnNVsEpmNmEx2Or3gIBuONAfSZBz+azqRr5R2F9tBdKozfqhAKDTxuOWuwVaNy5O2HseywlCINCq6EWFaPcxfnef+4mkNbG/dywxH8NClroh2LvdlGT0JHmRfV4ADIOusVhcThAtl1tB92udIP6nhs8JLbtbRHo2zx9m+LyO9G2FA1xFWl/TbQLSO4I3wicCqFHzYN6Mty1ZqvNH1g0NXspQSGlFZte06G2ijSZR9uMJmkxbNdPAUpLD0R1sHLwodlcR5Iq5e8aIux/OpN9epkenswUJSVZdqUnsPPUGTQ2C6dSZy+HkEm8jaMozBekh6Tu/zQGO7UH9QXV69sdlPcStrpPOlCUkvAWNAb/No2a8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5040.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(84040400005)(8936002)(2906002)(30864003)(45080400002)(6506007)(36756003)(6486002)(5660300002)(508600001)(6666004)(31696002)(966005)(83380400001)(316002)(66556008)(2616005)(4326008)(110136005)(66476007)(6512007)(26005)(38100700002)(66946007)(31686004)(186003)(8676002)(53546011)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eUIrWnVsSHB3eVJLdkg2RHRSMlNCMzhzQ2t1czJlTi9JQ2VOckN0WHBTMm9Y?=
 =?utf-8?B?V2owYTVPeGRYWjlTdWJRTUJMM250U1MxK2hQVEQrdDQvOFVCN1NKQTZXenVv?=
 =?utf-8?B?elVFcmx0MEJNZEpqZTRHUGhock5tVm15VjBDSzFHS3I1R24zWUdpb1owY0l2?=
 =?utf-8?B?WkcxZXJ4UmVUWWt4dGpKZE5pUTNpMWVOSFVESmhQcWxQUnQ2T2VCSzNvUHVz?=
 =?utf-8?B?YVY3SjIweVFaSDZYNHBTZCt2WFk3OWNvZHdXanZYc2x0Z29sR04rczErdUU4?=
 =?utf-8?B?elE5L2lscngxbW82MWZ5NWY5dlc0YUhPT0JlZDQwZHdocGl0dDBFZUdZR3M2?=
 =?utf-8?B?b2JrQ08weUZzenVpdkQ5V1ViZFpESTIrcFljVTZSdVA1SzZVWXFWSFhQY0dQ?=
 =?utf-8?B?bWxEQ21URHgyL3Nod1M2YkZkdjdyaXdFY2pUU1oyRDlIa01iRGRLSFNkWHBl?=
 =?utf-8?B?b2NEaVlma3c5b0pJQ2FQYmJuakVoSVljUTNkSDlNUk91L0YyKzdDcCtSY3px?=
 =?utf-8?B?MUg5eU8zQjZxYmtuNlFROEttVjcraVRFRnVwU0pOTy9NRWc3bGdHNGV3dzha?=
 =?utf-8?B?MDlqQ0QwUTE5RjlQU21VQU5XRGhYejdzOEljRkUwU2hyVlNnU3pQYWJWS0lY?=
 =?utf-8?B?OGM5UU1wVVNYVEVCQ3R3V3BST09jd3ZhTU9oV2pESGMyaW1jd2ZnTW9Ed0Z3?=
 =?utf-8?B?NXdQOTZPV3VXWExpREp5dE9WcUM1cHRjcVFsM2k1WGN3eEc1OWFIYUJrM0JV?=
 =?utf-8?B?c1QxNENxeVltT1NjUmEzbWpTWDRZNjFOa2ZRWjV4Y2lZbENudkxHVXZWSEdB?=
 =?utf-8?B?MXJLQU53TXhqMVdQSnJ1a0gzZUVyMVdpdHQ3b3hGTitqY2RQczIrK3h1Rzlz?=
 =?utf-8?B?UCt6V1BwMW1hTis5YXAvb2kzclpKTHhjbFRwNHBURS9NcTdwbmZNNUl6MzZs?=
 =?utf-8?B?VFc2Z2U2U3RjZnl3Qnd6YWVuOWRoY2g5WjYxUzRFdktORkRIRU1DcEs2WU9m?=
 =?utf-8?B?M2lzelFFcHphYmpsbmlqR0xTMS9pNUVXTlpIWGZHZjMxVzVVV1NwYitZYm01?=
 =?utf-8?B?UXFKSi85a2FuV2dJbHdpUCtITSs3am1wY3U3RlllKzA2SHRJY2pvUVVxYk9x?=
 =?utf-8?B?K3oxSURvYzdGem82V3VQN09TSmxEL1hHVWpPdDdvU3YvSVhONDA2VWRiZXVZ?=
 =?utf-8?B?VWNtaW1LU3loMVpVaUxNTTdyUThtR29kcDFmZlpQWWprakdKa2Nrd0wvMkJF?=
 =?utf-8?B?SldidzlLWEcySTkzeURBT2J5emJIanVBd25UZUgrMDdjVnFTd0xaTVZkU08r?=
 =?utf-8?B?dmFudzNRd0ZoMllUNkhCM2F4T1Y0MEpUV0p3Z3kzb0QwV3FJWVJMalAxWnBt?=
 =?utf-8?B?WWhQYUphaEp1VE5HUndNYWtCM2pJQ0ZTS0RrZlMwZ3VZUk5WZzJOR1ZvLzli?=
 =?utf-8?B?eTdYYVNWWnlwaEE2cW1RYUhxbXhSM0NUakNMY3BBQlhHQUlsb0Z2TmxxbGwv?=
 =?utf-8?B?WCswRGFuQnJ1ZXV5M2pIMGt2dFBkZVl0eDNNYU9XeHZZL0lpckxNejVYR3pz?=
 =?utf-8?B?eXhwaGxGRURSU0VnYjFXSEF1QUM3MWNxTEhMbjN0djE0VVFIaUNNcmR6SzJy?=
 =?utf-8?B?YzkvWEZycHB2dS9jRTJSd2dCVVJqL3gzVnNOWXoyYS9ISlg0SWdzNkFpc3Bs?=
 =?utf-8?B?SUlNMmk1cWdmZWkyTDB0YzFKVEdJbitYNlVNdnNTNWtweVNNQTJ4TVpVR2NF?=
 =?utf-8?B?emw5dTQvSGQ5Q3FnbmFZUTY4TFRGTTRpWlN0Ri9BM0JMR0toZkRpWEZmTlgv?=
 =?utf-8?B?RjNTMkpPL1FJVjBwamtsVHNLOURRK2dncVJyWElMeEhWbUlmem1HcVUrMlZZ?=
 =?utf-8?B?KzVwNGVpTk8xMzBPN2RKbEIwRmtnakZyTjhhNVpvZVhidjBRUXBqekVxallw?=
 =?utf-8?B?SmtQZTZQNEk5WEliRS9IeUswS3RvMSs3dzBOT2pPS0NWYkFTWkx3QmVGU0l1?=
 =?utf-8?B?d3hsSXFPbnNMRHY0YUVXMlRiUHh6WGpPR0RCdm13aCsvcWtQV0JUeFpwWFg5?=
 =?utf-8?B?UGtLRlVnV1czMjJFR094dFd1YlhSRjEydjlpTDNJVEpZM2NQeXIwVUFkbk80?=
 =?utf-8?B?NHlmUTFuYVl2alhwSi9veTRsSnh3VHRsM2FwNnNoQ1RvUXJhTkxjbG9Wei9k?=
 =?utf-8?B?TUU1cmlMb2V0MGxjRW9oL0VTQTNVM2FGZTk5eTM2MmxVVHZhM2s3eWFmcmYy?=
 =?utf-8?B?Q3JQV2JjSkF0TTVxQmlJV2srNWU2eEljQkx6aTc5VDdqQ2w4UTZENDEzZzhk?=
 =?utf-8?B?ZlhFMmNtZXF1RXVDQ0FTVEJJRzZoQitya2ZhaXZGUWN0UXMzV0NvQT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 95692051-351a-4dc2-98dc-08da2378b3ff
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5040.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Apr 2022 09:24:15.0828
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9izS6gsEELaa+NDN1MIMp428bkCSX7s/R6huSHhAUk2qC+wmHZU7mFXL+6QvzQZVJl7OW/uG6jPuCSvLqFqbeg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR12MB5684
X-Spam-Status: No, score=-5.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Benjamin,

BIOS/firmware confirmed that there is issue in ASUS BIOS/firmware.
I will update BIOS details in bug which resolves this BIOS/firmware issue.

Also issue is not seen in any other systems/laptops.

Thanks,
Basavaraj


On 4/21/2022 2:45 PM, Benjamin Tissoires wrote:
> Jiri, it seems you are pushing patches to the tree (or at least were),
> I would suggest reverting b300667b33b2 because there is obviously a
> regression, and we'll let Basavaraj figure out a better solution in a
> future release.
>
> Cheers,
> Benjamin
>
> On Sun, Apr 17, 2022 at 7:16 PM Marco <rodomar705@protonmail.com> wrote:
>> Any updates to this issue? The latest kernel 5.17.3 is still problematic for me.
>>
>> Inviato con l'email sicura di ProtonMail.
>> ------- Original Message -------
>> Il lunedì 4 aprile 2022 19:40, Marco <rodomar705@protonmail.com> ha scritto:
>>
>>
>>> I've added the three test cases (dmesg + sudo monitor-sensor on all three tests) on the bug report on bugzilla.kernel.org. One is with the stock kernel from arch, 5.17.1. The other two is using zen patches on top of 5.17. One is without the three reverts above mentioned. Sensor is missing still. Then my same custom configuration only with the three reverts applied. The sensor is back and working.
>>>
>>> If you need anything more, just let me know.
>>>
>>> Link to bugzilla: https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Fbugzilla.kernel.org%2Fshow_bug.cgi%3Fid%3D215744&amp;data=05%7C01%7CBasavaraj.Natikar%40amd.com%7Ce8b58d32f7f44e7290bb08da237787c8%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637861293540308810%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&amp;sdata=xA%2FLcZu8M1xEQsT3qJ5ESSEHybNFOVhoHchhuOryF8A%3D&amp;reserved=0
>>>
>>> Marco.
>>>
>>> Inviato con l'email sicura di ProtonMail.
>>> ------- Original Message -------
>>> Il lunedì 4 aprile 2022 16:26, Marco rodomar705@protonmail.com ha scritto:
>>>
>>>
>>>
>>>> I haven't tested this on the tip of the git tree, I can do this probably wednesday if it is needed.
>>>>
>>>> I'll post the output from sensors-detect shortly.
>>>>
>>>> Marco.
>>>>
>>>> Inviato da ProtonMail mobile
>>>>
>>>> -------- Messaggio originale --------
>>>> On 4 apr 2022, 16:04, Basavaraj Natikar < bnatikar@amd.com> ha scritto:
>>>>
>>>>>> On 4/4/2022 7:23 PM, Thorsten Leemhuis wrote:
>>>>>>
>>>>>>> On 04.04.22 09:25, Thorsten Leemhuis wrote:
>>>>>>>
>>>>>>>> On 04.04.22 09:18, Basavaraj Natikar wrote:
>>>>>>>>
>>>>>>>>> On 4/4/2022 12:05 PM, Thorsten Leemhuis wrote:
>>>>>>>>>
>>>>>>>>>> On 01.04.22 21:47, Basavaraj Natikar wrote:
>>>>>>>>>>
>>>>>>>>>>> Committed patch is disabling the interrupt mode and does not cause any
>>>>>>>>>>> functionality or working issues.
>>>>>>>>>>> Well, for the reporter it clearly does cause problems, unless something
>>>>>>>>>>> in testing went sideways.
>>>>>>>>>>> I also cross verified on 3 system and working fine on 5.17 and not able
>>>>>>>>>>> to reproduce or recreate.
>>>>>>>>>>> [...]
>>>>>>>>>>> ------------------------------------------------
>>>>>>>>>>>
>>>>>>>>>>> Looks like this is not regression. May be some hardware/firmware bug.
>>>>>>>>>>> Well, from the point of the kernel development process it afaics is a
>>>>>>>>>>> regression, unless the testing went sideways. It doesn't matter if the
>>>>>>>>>>> root cause is in fact a hardware/firmware bug, as what matters in the
>>>>>>>>>>> scope of the kernel development is: things worked, and now they don't.
>>>>>>>>>>> For details please check this file and read the quotes from Linus:
>>>>>>>>>>> can you help to answer the below questions:
>>>>>>>>>>> Me? No, I'm just the Linux kernels regression tracker trying to make
>>>>>>>>>>> sure all regressions are handled appropriately. :-D
>>>>>>>> Marco, can you help out here?
>>>>>>>> Marco replied in private and allowed me to forward his reply:
>>>>>>> ```
>>>>>>> I can't since, as mentioned previously, this is the only AMD laptop
>>>>>>> device that I have.
>>>>>>> I am sure this is a regression for me, even if the issue is firmware
>>>>>>> related. I have tested the 5.17 stock arch kernel and the sensor is
>>>>>>> gone. With the last three patches reverted the sensor is back and
>>>>>>> working fine.
>>>>>>>
>>>>>>> I would love to verify if the issue is hardware or software related, but
>>>>>>> being outside of AMD and with AMD not releasing any public information
>>>>>>> with datasheet/specification on their Sensor Fusion Hub I really can't
>>>>>>> say anything specific.
>>>>>>>
>>>>>>> This still remains a regression, since the hardware was working before
>>>>>>> and now it doesn't.
>>>>>>>
>>>>>>> By the way, I already have seen also this rework of this specific driver
>>>>>>> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Fgithub.com%2Fconqp%2Famd-sfh-hid-dkms&amp;data=05%7C01%7CBasavaraj.Natikar%40amd.com%7Ce8b58d32f7f44e7290bb08da237787c8%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637861293540308810%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&amp;sdata=dwq1ETuquRbWavl4Sb98TOesitSiQjeuq6hN2mxqamQ%3D&amp;reserved=0 that even added a still
>>>>>>> missing handler for the lid sensor switch for disabling touchpad and
>>>>>>> keyboard, and all efforts tried to merge it upstream with all sorts of
>>>>>>> issues.
>>>>>>>
>>>>>>> Regardless of everything, this is a driver supported in kernel by AMD
>>>>>>> engineers, so all of this doesn't matter. On my hardware this three
>>>>>>> patches break a previously working hardware.
>>>>>>> ```
>>>>>> Thank You Marco for the information.
>>>>>>
>>>>>> Could you please provide me below results for acceleration
>>>>>> by re-applying and reverting patch once again on same laptop.
>>>>>>
>>>>>> Did you attempt to test it multiple times on the tip of the git to see
>>>>>> if the problems goes away?
>>>>>>
>>>>>> if same test is performed multiple times with or without reverting patch
>>>>>> on same laptop on which issue is observed
>>>>>> we may see same working/issue behavior. if it is regressing then always
>>>>>> it should work with or without reverting patches on same laptop. is this
>>>>>> the case here?
>>>>>>
>>>>>> Thanks,
>>>>>>
>>>>>> Basavaraj
>>>>>>
>>>>>>> Ciao, Thorsten
>>>>>>>
>>>>>>>> Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
>>>>>>>>
>>>>>>>> P.S.: As the Linux kernel's regression tracker I'm getting a lot of
>>>>>>>> reports on my table. I can only look briefly into most of them and lack
>>>>>>>> knowledge about most of the areas they concern. I thus unfortunately
>>>>>>>> will sometimes get things wrong or miss something important. I hope
>>>>>>>> that's not the case here; if you think it is, don't hesitate to tell me
>>>>>>>> in a public reply, it's in everyone's interest to set the public record
>>>>>>>> straight.
>>>>>>>>
>>>>>>>>> Did you attempt to test it multiple times on the tip of the git to see
>>>>>>>>> if the problems goes away?
>>>>>>>>>
>>>>>>>>> if same test is performed multiple times with or without reverting patch
>>>>>>>>> on same platform (laptop/hardware/firmware) on which issue is observed
>>>>>>>>> we may see same working/issue behavior. if it is regressing then always
>>>>>>>>> it should work with or without reverting patches on same laptop. is this
>>>>>>>>> the case here?
>>>>>>>>>
>>>>>>>>> I don't see any regression here. I requested to retest with other
>>>>>>>>> hardware/platform/system also as per my above test (output) all working
>>>>>>>>> fine in 3 different platforms and not able to reproduce or recreate for
>>>>>>>>> my side on 5.17.
>>>>>>>>>
>>>>>>>>> Thanks,
>>>>>>>>>
>>>>>>>>> Basavaraj
>>>>>>>>>
>>>>>>>>>> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Fgit.kernel.org%2Fpub%2Fscm%2Flinux%2Fkernel%2Fgit%2Fnext%2Flinux-next.git%2Fplain%2FDocumentation%2Fprocess%2Fhandling-regressions.rst&amp;data=05%7C01%7CBasavaraj.Natikar%40amd.com%7Ce8b58d32f7f44e7290bb08da237787c8%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637861293540308810%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&amp;sdata=XBa%2Bf69TKahhgksrEvjgpEDFNwV453INzJ7pO6BGTHM%3D&amp;reserved=0
>>>>>>>>>>
>>>>>>>>>> Ciao, Thorsten
>>>>>>>>>>
>>>>>>>>>>> Just curious reverting this patch how it is working just suspecting
>>>>>>>>>>> firmware undefined behavior.
>>>>>>>>>>>
>>>>>>>>>>> If possible, please check on other platform/system also if same behavior
>>>>>>>>>>> occurs.
>>>>>>>>>>>
>>>>>>>>>>> Could you please provide me platform/system details so that I can check
>>>>>>>>>>> this behavior?
>>>>>>>>>>>
>>>>>>>>>>> Thanks,
>>>>>>>>>>> Basavaraj
>>>>>>>>>>>
>>>>>>>>>>> On 4/1/2022 1:36 PM, Thorsten Leemhuis wrote:
>>>>>>>>>>>
>>>>>>>>>>>> Hi, this is your Linux kernel regression tracker.
>>>>>>>>>>>>
>>>>>>>>>>>> I noticed a regression report in bugzilla.kernel.org that afaics nobody
>>>>>>>>>>>> acted upon since it was reported about a week ago, that's why I decided
>>>>>>>>>>>> to forward it to the lists and all people that seemed to be relevant
>>>>>>>>>>>> here. It looks to me like this is something for Basavaraj, as it seems
>>>>>>>>>>>> to be caused by b300667b33b2 ("HID: amd_sfh: Disable the interrupt for
>>>>>>>>>>>> all command"). But I'm not totally sure, I only looked briefly into the
>>>>>>>>>>>> details. Or was this discussed somewhere else already? Or even fixed?
>>>>>>>>>>>>
>>>>>>>>>>>> To quote from https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Fbugzilla.kernel.org%2Fshow_bug.cgi%3Fid%3D215744&amp;data=05%7C01%7CBasavaraj.Natikar%40amd.com%7Ce8b58d32f7f44e7290bb08da237787c8%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637861293540308810%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&amp;sdata=xA%2FLcZu8M1xEQsT3qJ5ESSEHybNFOVhoHchhuOryF8A%3D&amp;reserved=0 :
>>>>>>>>>>>>
>>>>>>>>>>>>> Marco 2022-03-25 15:22:19 UTC
>>>>>>>>>>>>>
>>>>>>>>>>>>> After updating to 5.17, the input from the accelerometer disappeared, completely. No devices available from IIO tree. First bad commit causing it is https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Fgit.kernel.org%2Fpub%2Fscm%2Flinux%2Fkernel%2Fgit%2Ftorvalds%2Flinux.git%2Fcommit%2Fdrivers%2Fhid%2Famd-sfh-hid%2Famd_sfh_pcie.c%3Fid%3Db300667b33b2b5a2c8e5f8f22826befb3d7f4f2b&amp;data=05%7C01%7CBasavaraj.Natikar%40amd.com%7Ce8b58d32f7f44e7290bb08da237787c8%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637861293540308810%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&amp;sdata=REu14KaEX0CrJgKvUedQ%2BXI%2Fw5Y156l%2BFEfCPMWbgGI%3D&amp;reserved=0. Reverting this and the the other two on top fixed this. Tried to not revert only the above mentioned commit, but it's still not working.
>>>>>>>>>>>>>
>>>>>>>>>>>>> Marco.
>>>>>>>>>>>>> Anyway, to get this tracked:
>>>>>>>>>>>> #regzbot introduced: b300667b33b2b5a2c8e5f8f22826befb3d7f4
>>>>>>>>>>>> #regzbot from: Marco rodomar705@protonmail.com
>>>>>>>>>>>> #regzbot title: input: hid: input from the accelerometer disappeared due
>>>>>>>>>>>> to changes to amd_sfh
>>>>>>>>>>>> #regzbot link: https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Fbugzilla.kernel.org%2Fshow_bug.cgi%3Fid%3D215744&amp;data=05%7C01%7CBasavaraj.Natikar%40amd.com%7Ce8b58d32f7f44e7290bb08da237787c8%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637861293540308810%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&amp;sdata=xA%2FLcZu8M1xEQsT3qJ5ESSEHybNFOVhoHchhuOryF8A%3D&amp;reserved=0
>>>>>>>>>>>>
>>>>>>>>>>>> Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
>>>>>>>>>>>>
>>>>>>>>>>>> P.S.: As the Linux kernel's regression tracker I'm getting a lot of
>>>>>>>>>>>> reports on my table. I can only look briefly into most of them and lack
>>>>>>>>>>>> knowledge about most of the areas they concern. I thus unfortunately
>>>>>>>>>>>> will sometimes get things wrong or miss something important. I hope
>>>>>>>>>>>> that's not the case here; if you think it is, don't hesitate to tell me
>>>>>>>>>>>> in a public reply, it's in everyone's interest to set the public record
>>>>>>>>>>>> straight.

