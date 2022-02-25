Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0EF554C4DEB
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Feb 2022 19:36:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230389AbiBYShG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Feb 2022 13:37:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229536AbiBYShD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Feb 2022 13:37:03 -0500
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam07on2060.outbound.protection.outlook.com [40.107.95.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 041CD223212
        for <linux-kernel@vger.kernel.org>; Fri, 25 Feb 2022 10:36:30 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PGwkSGQkL+rfxlZeAr4fJnL6UAwf4Kodz+cRi/VTSweBOP84btAbPen0BZCYuRzmUvDQo85W2NEguT4UZ68rn+MNIqO3xA1Joe5oakWAiW6SfgS+2m3fgUJ9ibRpB8yP0mh+qmwxYByYayGeryWfLBxXcuyyoCvyXSCC8JjCpghgaMuRRaDYT6BlI1St07/L94UT+C4Yhv7yGBQHW5lPYO0Oe3dplYWl5M242pNg4yZhaKQ8B4f+7av3x/L9ayNQqopn5qpOCouqDhNu4MOMaHLZSI3Jv0QqI4w1f8jpgosCYeLOm7tLSS75XOAgPY7O1hz7d+otvJgcHqAoLlVcvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AluFW2Dhp/HMVeBWJkAzchlb6L9BE/BCuW76qOJgLJE=;
 b=eJdikICJS8g6E1v+DCKu/fT6hVHh4uFn8ZYujOopo3L35iWTHEP6hqJPQra43le5bTXpwTGUNdvxKzCmBTY6aJKA1dzpC87pBE08A7KItWkQ2vo1CYMPRRPv93J2fbHwodKvy0eVWCkyHvr37cWtaCaPzZRX4CCwYBl1vrfys5qIRPglIeRSnYr4HEyzIfU3hTv4wtoCwUGKDFfNRh0rrrZviEnBHTfhVv6A+3tDV3ky0iwMSVEh/MpYcBL427OpcYXcJtgf8m7eeppWg89+MlmWhRjgqKQDvLzs7f1Qj+LVCgP9fNEntWdyAvhqrCXl/HHcKysMTvSLV1a0HkH0jg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AluFW2Dhp/HMVeBWJkAzchlb6L9BE/BCuW76qOJgLJE=;
 b=wh2Buqv0ppUJLTUEjc6POTNI5jExtJhTwSlJqJw3G+UK0d+3iuuevZBWbYclPl8xJ8uv0oTmzpuX7a0Z081nIkXdRhvCO2BjUZaiWD0svZO7bVM7TnpTo8j6aFCbQNgd+5gIV2BoBXGcb7Qobktcsm63AO8oEeLpTBhzc1Sivno=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4123.namprd12.prod.outlook.com (2603:10b6:5:21f::23)
 by SJ0PR12MB5487.namprd12.prod.outlook.com (2603:10b6:a03:301::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.24; Fri, 25 Feb
 2022 18:36:27 +0000
Received: from DM6PR12MB4123.namprd12.prod.outlook.com
 ([fe80::497e:ae36:b6ef:86b2]) by DM6PR12MB4123.namprd12.prod.outlook.com
 ([fe80::497e:ae36:b6ef:86b2%6]) with mapi id 15.20.5017.026; Fri, 25 Feb 2022
 18:36:27 +0000
Message-ID: <d4b3f072-198b-0656-0b0c-134ccbac0d58@amd.com>
Date:   Sat, 26 Feb 2022 00:02:53 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: (subset) [PATCH 1/9] ASoC: amd: vg: fix for pm resume callback
 sequence
Content-Language: en-US
To:     Mark Brown <broonie@kernel.org>, alsa-devel@alsa-project.org
Cc:     Takashi Iwai <tiwai@suse.com>, Alexander.Deucher@amd.com,
        krisman@collabora.com,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Jaroslav Kysela <perex@perex.cz>, Sunil-kumar.Dommati@amd.com,
        Liam Girdwood <lgirdwood@gmail.com>,
        open list <linux-kernel@vger.kernel.org>, wtli@nuvoton.com
References: <20220223071959.13539-1-Vijendar.Mukunda@amd.com>
 <164570533555.1194769.3668536221336070255.b4-ty@kernel.org>
From:   "Mukunda,Vijendar" <Vijendar.Mukunda@amd.com>
In-Reply-To: <164570533555.1194769.3668536221336070255.b4-ty@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BM1PR01CA0114.INDPRD01.PROD.OUTLOOK.COM (2603:1096:b00::30)
 To DM6PR12MB4123.namprd12.prod.outlook.com (2603:10b6:5:21f::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 75a35db8-c2c8-4a16-3d9e-08d9f88dbb66
X-MS-TrafficTypeDiagnostic: SJ0PR12MB5487:EE_
X-Microsoft-Antispam-PRVS: <SJ0PR12MB54877B5ABD2F429B7C8A3E98973E9@SJ0PR12MB5487.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3bnJDSVvjAek6BPUkgO45KiFWfyRnlsJjjSg+XoQz1GirbuFJm6AYnRhK8kHdPUprt+cNSA7WRDfFAYYShK+qnc5D7YAkZDPJLc49UZUG3ZwMQQyh3UMAIr8vvUaMr49Htzexr7a0MGQYKyXPzknILAeMbhqtaAYqKpzqDT+ke7fwbW1LCrEhfyjbm/V5kNShTYi6DHGYUzd/U8UwU4VSFf6effU8oPtPKGxqAoZZI/ZZyNSTBid6KQo5VsmO35vo4OwVhduSVHkP3kMQADL0EUXyqsQUqQZoARopF1HIF/A36X3P+8VHf966nEgzt1FTm5lSxCEzHiEKLsTw81CqV0EUSGQsf7slVIyEc8X1RPnO2XJVwLljc2stbDbru5if6ULZIVWqc/AC0pF0RMihL802EIKqt9jWXq/6W4hIx7FAosYxGnqJR0QmOHU9EOivzDNRXTNB0/Bs+tQkUu3KoXlJVwG+oj8fRKUMipHZbsUZuEFB1SdVwaVZvdMubRthjrYZHrN3tjc/GQxZ2hYGt/+lhAeKFLC3XMETNkVT3jlB+WbbvlSKQvEjJD+k2D6l2dHHvaT1V/VIzzH5K0fZtpJpYVFdzjh28k7+yjKJoX3zIE7cWd6lbQObVe6djLQEZSqtr3mEMJ+oCWiA2zQIl+jc821XhHxsc3eUjsMathcSLSyomFHg67O5L3732khWs1ubFDAdA5E/qKAjNx+1Jg7xuoU86FOU6QUO+ai5j/Su0E+UvJEl2CdFYS4z0D5vNUnfSIzTYriS9OksdQdr4/1Ej1ncGw96Tpz0lItIrCNkPuhRflPXdD4JTtlnlfV
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4123.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(6506007)(38100700002)(31696002)(45080400002)(966005)(6486002)(2906002)(508600001)(86362001)(6512007)(53546011)(316002)(5660300002)(6666004)(2616005)(8936002)(54906003)(4326008)(36756003)(26005)(186003)(66946007)(83380400001)(66476007)(66556008)(8676002)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NVVXaUUyUXB3YWY2dEZ5dUQ4NFdvT21sQncrRE11R01mNjBTK2hNRTNEZEYx?=
 =?utf-8?B?NDNyVlYzditPN3V2VmVrUnlXcnlvN0RqNHcxcnNiQTRJUFdMMnVVMWdBOTNl?=
 =?utf-8?B?aytNaytCaXB0aWFLUEhDTVZFSzR2L05DTEZqQnhha0lHNjJXRWRzMThjTmxl?=
 =?utf-8?B?M2JuTXExN29yM0FGejNuQjdXbm1aZk5jSkVYWVFDMjJmMGlRRnZseDJwZXdp?=
 =?utf-8?B?b3FlNWVyc1EwL1RiSkd6YmJKMDgzTlBhYWtWem5Hd1J3bEZoVjQvVHFtV2tp?=
 =?utf-8?B?QlVDL05iQUFhQnlGWitXU2FwRmhvZzM2dTFmd3hXVDVqa3RyUk9LUGZ1cS9x?=
 =?utf-8?B?akhKbzNPdlRpWjRXOXZJUUhmcWl6czNPWjJYK1IvSjVhc1NzV1g3eTQvS3c1?=
 =?utf-8?B?bmtzSGdhY1J5OEhYdDNhblBSTDZwQks0Z2tBU2ZBRUw1WFo0dVZBcklVN1lE?=
 =?utf-8?B?akdFTWFia0l6UVR0dnNNdGFNb3hPL2QycFl5VFk5NU1KaWNvaEJRL0N4Z29C?=
 =?utf-8?B?RTFlbHVLd1VGLytwZUg0Y3d3MithR3E0WWdjQTRUNUxhQmlWN2pacHQ1Qjc5?=
 =?utf-8?B?Rkg5bGdWd2hZSjRtbC95QmswVmVsR2JEeGo0VUJIbXBpVU55MDBxdGF5VXc2?=
 =?utf-8?B?eFR4SG82dFU0M0I1SC8zSW1STlNTeFNVd1Q3ZXF5SFk3UWdWMlo4V3FUN0hY?=
 =?utf-8?B?R2pObEdnY084YUFIRmcvMXliMVVRdGVBV3ZaeWtSNWRhckVDY3VBY0NWNVlS?=
 =?utf-8?B?aXdJQ1k2RmZKbUc5U045Si9kazAvNXlZMTBRYnJTR3RyQ1R4U2Q3aE5meDBp?=
 =?utf-8?B?Lzl2Z3pyb0xER3pwNUs1c25GZDdnN2V5dUVoSW1pTzNkN3FibytNVFlNVVox?=
 =?utf-8?B?ZlZmTW5admQwWk9VaTVEQnVRQW9WUE1vYXZSbGczKzZ1TUt0eVRTT3pzeHh4?=
 =?utf-8?B?d0V1NTdSSWg2VUIxY2RxVmdLdUlhQkFDOHlGT0piUGVVQnlsaUJjWi9sMjhE?=
 =?utf-8?B?dHJuUXhWSHVIRkpRcjJRckY3YzhMajZaZmtaN040YUVCd3RxNVZNZXRtYi9G?=
 =?utf-8?B?QmFQRy9iaGtnV2hLcVBBWWhvTjFCK2hZTlQxTThXN2hFSGthTHptYmk3bksv?=
 =?utf-8?B?bEYxeURYYk9ERWFDWWJGdjlkOGJnYmlUekw2bTkydnhTUnFWSS9leStVT0Ix?=
 =?utf-8?B?S1VacXVOa3Z1SjdZZ0FXNDlLV0V5Q1VwaU5KTld5bDBPSlN3bjh2Y3NqSjRJ?=
 =?utf-8?B?QUNiUkNOYTZTajZnckVlRFpYampZZWhTWnhRQy9BM1Q1azlsdHFZTFlwaTNK?=
 =?utf-8?B?d25VSTZFQlNTRW9GZEdhMXZ0aHZwRU1OMkpPR3ZlM29FaVRkUUhObmxjVnQ0?=
 =?utf-8?B?OUxsYzQ1N0NrV3dWcktRUGFmSy82bGl0RWpsVUMwS2l5N21NcEtRRFF3ZXlP?=
 =?utf-8?B?YWpRYm5PMzFDNjd1UW02dFFBL21EU2FUU0Y2d1hvUWpYMTRjZ3FKNk16VU1p?=
 =?utf-8?B?cXZrclo5SzhhMlJKcmhucHp5dHZ6UVlFNk1YNjlzQ284YXdlbGpKaWxua09y?=
 =?utf-8?B?dXBUT3RMRHNyeW5vQThxNE5WYjdQeVlRRzY3cHRxNXBmNEt2eTV0VUZZS2ov?=
 =?utf-8?B?WmJGM2dtdVBMRnp3WkdYcCtHeVZQZlJVTFl5em1rUzVuZ1NaM1liakZNYWRk?=
 =?utf-8?B?NWVOblZEVDhIanVyeUNNNk8wM09Mb2I1WkdIRnAxMlRPNTYxVWZJQVJSbDRa?=
 =?utf-8?B?Yzl3NEVGa0d5bXBpc055S0NzT3ZKNHlHR0J0aWllWnlDUTA2VFVkOEVSenR3?=
 =?utf-8?B?UEJqbndzcVNzL1JSenk4QU1ET2s5c25jZXljOGtzQjBtUklvZkcwNjR6ekVN?=
 =?utf-8?B?cW1LQlpUTkNHMTJnNlZJYThGTDdWV0ZZdmxSZ3ZyRXdwamZhdmtwUktUZzRt?=
 =?utf-8?B?eDBrSklINGE5Um5Jb296eEVJT1ZqaWx0MHFRa2xkdFcydkdSaXdIZFBqWkJI?=
 =?utf-8?B?cklFT01hdXVXSjU0NlhVQmRQQXYrVG4zM011aFUxbUZaVUpvNmpRQUMxLzhH?=
 =?utf-8?B?QWtkNTlPWmVuaHZPWFpBUHBtQXVYd1o3UUJuQUlOYkNFTU96S01EVzZaZVdV?=
 =?utf-8?B?ZGZVeGlpMEcwNDZZK3VNMElpWitQRVNvQXo2NkYraS9yaVVxa2xRaU45NzBX?=
 =?utf-8?Q?OYvGOYGl0dcgTh+2IoUkyO0=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 75a35db8-c2c8-4a16-3d9e-08d9f88dbb66
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4123.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2022 18:36:27.3075
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rmoGqOSFowk12IzpPKArtyJs51UszVqJWJPQFmfaeTaE1L3IIWTBfp5sL3WEHyJM4D8peKcBbzm1vPuvPC+iEw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB5487
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2/24/22 5:52 PM, Mark Brown wrote:
> On Wed, 23 Feb 2022 12:49:30 +0530, Vijendar Mukunda wrote:
>> The previous condition is used to cross check only the active
>> stream status for I2S HS instance playback and capture use cases.
>>
>> Modified logic to invoke sequence for two i2s controller instances.
>>
>>
> 
> Applied to
> 
>    https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Fgit.kernel.org%2Fpub%2Fscm%2Flinux%2Fkernel%2Fgit%2Fbroonie%2Fsound.git&amp;data=04%7C01%7CVijendar.Mukunda%40amd.com%7C3a19f223da704ef29da308d9f7904df5%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637813021442156506%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000&amp;sdata=EfbRAjgpLmD0cuSsnfJVtdRIP1OqVPh3pxcTD6AKx6c%3D&amp;reserved=0 for-linus
> 
> Thanks!
> 
> [1/9] ASoC: amd: vg: fix for pm resume callback sequence
>       (no commit info)
This patch hasn't been applied to tree.
Should I re-send the patch ?

--
Vijendar
> [2/9] ASoC: amd: vangogh: refactor i2s master mode clock sequence code
>       commit: 5ca4cf2c83dac27768f1d7d3e2404f5a17830ca5
> [3/9] ASoC: nau8821: enable no_capture_mute flag
>       commit: aa9753a4677d0a2c53e7e46ca173c985a3f7b83e
> [4/9] ASoC: amd: vg: update platform clock control sequence
>       commit: 9a617f0e109cfba2017d76f807ebb3a00c47bdca
> [5/9] ASoC: amd: vg: apply sample bits pcm constraint
>       commit: 0c38cc1dd17e766eada0aa44be4c1a47bcbb7bc3
> [6/9] ASoC: amd: vg: update acp init and deinit sequence
>       commit: a9230ccc0c6f5fca0b94f57729dc61e0a6098a0a
> 
> All being well this means that it will be integrated into the linux-next
> tree (usually sometime in the next 24 hours) and sent to Linus during
> the next merge window (or sooner if it is a bug fix), however if
> problems are discovered then the patch may be dropped or reverted.
> 
> You may get further e-mails resulting from automated or manual testing
> and review of the tree, please engage with people reporting problems and
> send followup patches addressing any issues that are reported if needed.
> 
> If any updates are required or you are submitting further changes they
> should be sent as incremental updates against current git, existing
> patches will not be replaced.
> 
> Please add any relevant lists and maintainers to the CCs when replying
> to this mail.
> 
> Thanks,
> Mark
