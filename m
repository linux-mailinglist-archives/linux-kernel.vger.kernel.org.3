Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4778056A75F
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jul 2022 18:06:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235202AbiGGQGO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jul 2022 12:06:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229685AbiGGQGM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jul 2022 12:06:12 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2086.outbound.protection.outlook.com [40.107.244.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D203423BDA
        for <linux-kernel@vger.kernel.org>; Thu,  7 Jul 2022 09:06:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=khKqJhuPtOcbVxO1POVmwWx/G7AYIaBd98jXEP17iqLc7eXeBIp7cA5jYA0UDQ+cYUFsex2CpGF4z6jGGaf/xRlrwrFzgReyb9/OtD9Do4oUeMgFREFY7dNCzj91JlOmIspVTvjmM/YIW9PQ99QE01WsL1X4qkBOnrhSLtorOmtNCbQMK4SfbUHQqzNqXPW+wuWABKp2JflccLhk97SpUH2mUL8uRffrP9cFl7H1b9/t/BVO3FboR29PGcOPoB7BMxJhjSy+U9CshhK3KkjDTX72eYZ+axtkk716WNQLpOk773sn9GDk//o6vw+Il4lJ7q0pGulRIEenmv6aiHPaqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M1IvBZXnST9yHLtz9qDUoDTXq8ohjIeLfscKg/Sh0is=;
 b=Bx/sm7fUbx1oQ9gzszGuFC6Yaw34gjFK767a/4Yqjr+oDVlmGJCm9rXXLz2+xivIuNuZwQQQvDAdV5JBvx6ENyPdMogQvGwQ9flHxtGlWQ4x+JXJ3iKO/n2Eib/BlqVyFuvBN/UY9dLkF7TpphTsyISF6rDsaNtGl4k4paqzgI+YTl6fjvmIzixOlNuBprX/BkUQw9TTBzeGKTRt/q2i95PgNZ2rLrjeceOsdGUuBSsBCfmcsQdmZz1Q6vuJJq6BsCf/lWiJnxVHorfS5Jq23Lflos4egIbr9QOVKbZ9zdlRnaXpqp+9P5C4Hrge3uzfhGR2ddMa28ssRrry22a2vQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M1IvBZXnST9yHLtz9qDUoDTXq8ohjIeLfscKg/Sh0is=;
 b=lQ7gGd1OXSE8RfquGrWWphXNPfVtpUHBpd6HqkWkK9K1VZZ+QmVHk77vQytVyFxBTCOaSk7Vq6f5qJ1gDnh6efdSRt58JgXYuhb1C5dU3di7en0njDCB9c8xJa3v+RBXcfpCjSvO03fO1r4WKLishzM3gAcZiXMZFHe1kb+Q1GQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4171.namprd12.prod.outlook.com (2603:10b6:5:21f::18)
 by BN8PR12MB3267.namprd12.prod.outlook.com (2603:10b6:408:9e::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.16; Thu, 7 Jul
 2022 16:06:06 +0000
Received: from DM6PR12MB4171.namprd12.prod.outlook.com
 ([fe80::e127:3aff:e853:414d]) by DM6PR12MB4171.namprd12.prod.outlook.com
 ([fe80::e127:3aff:e853:414d%3]) with mapi id 15.20.5395.021; Thu, 7 Jul 2022
 16:06:06 +0000
Subject: Re: [PATCH 3/3] ASoC: amd: acp: Add legacy audio driver support for
 Rembrandt platform
To:     Randy Dunlap <rdunlap@infradead.org>, broonie@kernel.org,
        alsa-devel@alsa-project.org
Cc:     Vijendar.Mukunda@amd.com, Basavaraj.Hiregoudar@amd.com,
        Sunil-kumar.Dommati@amd.com, venkataprasad.potturu@amd.com,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Ajit Kumar Pandey <AjitKumar.Pandey@amd.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Arnd Bergmann <arnd@arndb.de>,
        Akihiko Odaki <akihiko.odaki@gmail.com>,
        Jia-Ju Bai <baijiaju1990@gmail.com>,
        Syed Saba kareem <ssabakar@amd.com>,
        Yang Yingliang <yangyingliang@huawei.com>,
        Meng Tang <tangmeng@uniontech.com>,
        =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        open list <linux-kernel@vger.kernel.org>
References: <20220624194821.287462-1-Vsujithkumar.Reddy@amd.com>
 <20220624194821.287462-4-Vsujithkumar.Reddy@amd.com>
 <6a210c39-2a04-2d39-9d5f-51b4e777b81d@infradead.org>
From:   "Reddy, V sujith kumar" <vsujithkumar.reddy@amd.com>
Message-ID: <472517b9-523e-36a2-9f00-e718ba0708f3@amd.com>
Date:   Thu, 7 Jul 2022 21:35:52 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
In-Reply-To: <6a210c39-2a04-2d39-9d5f-51b4e777b81d@infradead.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-ClientProxiedBy: PN3PR01CA0106.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:9b::14) To DM6PR12MB4171.namprd12.prod.outlook.com
 (2603:10b6:5:21f::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fa8d97c9-6273-4aa5-eac4-08da6032997f
X-MS-TrafficTypeDiagnostic: BN8PR12MB3267:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: H/2hEFDifdk1mMnh8vegohV15l2oMD6/wb9Swf0RDqz5a6jbdMVaOBP4fv0hrWH1MaVCedAMZI8h1hYoTc/U2nrEvt3Lh0TWA5nGD4eEixByOOY07p0A8V3hR2OnmcG284Of5W+DqWSRH7frjS9LLkMyEHV9IuxvH4smmB8FhXZdpYNfmbDZ6w4rJsURDJJtq4SAE22+DIvn83cpz+gJgVUixZCgwZQl1md98/95Ya1nRBBrJmPcZDi0L0f38lBqExFWO2MvhUge+BHl6E3KHpOPzbZKhV8CgVLraSCj41NIiCI1lVnKr49+9C4NlVH5POH14TWAUEZxn1G3evrO3a9JcZLwRCeZMlRswGJ9tQ+CrF5V0MJsVL4WPXlHB7mP41IRsse0HHGEDRMVw/FTSPERZFauMKfyHbMEKj4m3fUQ0qho2gZ57LEs1sBULnGzkGaY9wNNg9GSa8KuWftf9ERY1OOEuba+JHDnCGmIl35/V/ILFMhB1bo2ww6mpfM3p+crS8PckQsp9+XxIOIVf9wrGiPrnS58VUlVq/iBXKX20Fg3ebQJbbl1/bRa8AYZzc6oxMWyimvmPrGj5hNuEWhfnRzLPBUAsctcpTl3F1OLXcOXLxuAshzNQqsCuUhSDToJg2hZqDnxToQXaq+RcjYQosUZ8nWjvH03n56GiyaG5xw9JQcVFXv+ER/yts+cqLTiKpUyFRyIGyUuxHZzF7xadtemxyEhiq1Iyhd6taZf7ys78NITrjQOZzkv6RtdmWL6Bgvq1P9qJ1qPgZEfs+lU19A/Nclk1k+3F6mUVvHsPQn6uGaWxE6Nlg2Q/mSRisQeemP+s0ppiaLatk6/wrzlI2n6qMQos/vBNEOfxxg=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4171.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(376002)(39860400002)(346002)(396003)(366004)(136003)(54906003)(31696002)(66946007)(6486002)(26005)(86362001)(478600001)(36756003)(316002)(6506007)(31686004)(53546011)(6512007)(41300700001)(6666004)(66556008)(4326008)(8676002)(66476007)(186003)(38100700002)(2616005)(2906002)(8936002)(5660300002)(7416002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Z3UvZkYxY3hMdUxnQ29vcUVkR1NyeGNDNHAzejN0TkxlVTF2QkdoRjJySTh6?=
 =?utf-8?B?VW85bTdTanMwSjcreDZDRXNKYjlpdDI5UHNEZUoxRmFtaDBHS3l0dFpvRHZl?=
 =?utf-8?B?WHhqWlVRbE95ZVJuaTUxRU1XR1drckl5eFh6Wm9kNVM1WndzUzRKT28wNkF0?=
 =?utf-8?B?M2h2NmorUlN4aTdqTnprSzlyb05oWkNseXNsYWJacUhXc1F4YTNzcVBQejZR?=
 =?utf-8?B?dWk3bWZDSDk1R2VScXFJS1lYMVE4UEY4bmQwQXdRWGlwNWpJcmFNOWRETWZ3?=
 =?utf-8?B?bEVNNWY5eVpCOGhuenpINGRUMk40UU5YbGZHc2hCRGNpS0RqWktVdmN5a1lr?=
 =?utf-8?B?K1owMVcxQnVuQTNyaTFWeXFkbTBlRExZTE0rVzlocWh3VzYyTzBqSkJycVln?=
 =?utf-8?B?eVRwWjRPZmNzdHFnLzFKeTVDVlZIWlFSOXk0cUxnZFhHcmtMZ250ZmJzNFBI?=
 =?utf-8?B?SSsramRtd1hhK0dwb2lPbXFDUDFHQWw0NzhxWnN1UFVZVUIxVFYyN1Qvbk44?=
 =?utf-8?B?aFd3STlSdXg5a0JRZlJkL296SE5jYzVRNm9QOHgzMDBpNU9ZSHNhd25wNlBv?=
 =?utf-8?B?anV0cW51K2svVzNlMUJWQkVQemV2OTBTblhiQjN3ajYvdVZ1WXdQd2lPSFVU?=
 =?utf-8?B?RU1KZHRzR0dSeFJRMnFzZUJhU1o2b016SElCakFYTVpHUVlhdFR6UUpXK0lw?=
 =?utf-8?B?MHZmR2N5Nmt2dzlaUlhKaWNZNGRVVUhLVXJUczZ3dHFrYWFERTdjeDkrQmtt?=
 =?utf-8?B?TkZkQXJVY3RBL2oyb0NhRGZOU25pRUxpUWZsU3VHRjBpSmNPb1JqV21xbW9j?=
 =?utf-8?B?ak82NmxVRUxCVWg4amRlT0s1b01LSTlxbHBibVVDN0pQOTJ3akNNa2ljZnF2?=
 =?utf-8?B?dk1pd3BPcnpyeXhVb053bkxSblpkZFhMWnVZbUxCQzhWTmtZTFhya0hzWWJj?=
 =?utf-8?B?SDByNG1pVXUxT1JsZnJqWXZjemdKL1VMSGxFekVRajBvRXFMZmJQZlBkV01s?=
 =?utf-8?B?bXhXU293MWUyLzdEckVIZ1JNazAvaUs4bnBEL0ZSUUNLK1ZTTkhUbjdRZldT?=
 =?utf-8?B?bzBBc3J1cmowbGxGM1JFejhMc090ZmhWd3RBZm9VRnN4RVE4dUZHaWllYzN3?=
 =?utf-8?B?b0RRRGRzbHVvWVQrQzBLWnYvWnZLeXpXRjEreHp1alo2b0xQTjFDdmVtRi9K?=
 =?utf-8?B?ZUQyQXVRTmlEcjNUZTNTQlUvUVFycFUzc1htMnZhQ3hUYU9sMzdpekxqYVI5?=
 =?utf-8?B?SWdZNEMyem1kZHNYd2hSWFFRejRpcCtGdkxGYitOTFFQcktMQ3M0MFNUM3J0?=
 =?utf-8?B?Y0VpZ3R4RWFxazVicFBSTmZySXFJQ2JHYUtiN00rZSsvdnJvNFRKUjNkR2hl?=
 =?utf-8?B?VG9NOGhUVGN2K1JlN1NSdXA1bzZKMW5mUnBSY0hLSXRRWlZ1M0N1bjFrV1V0?=
 =?utf-8?B?ckZUSXVVTkRLTG5hbXgyQ3lYSlR1UTR1Rm9VazBMZVRDdUdFZlJvSVI1YllW?=
 =?utf-8?B?RHVQNmc1WFlqSk42NlVNQ3FRRTBZUVFVcnptWVR3bTlUZ28rUExDc2R4cVRJ?=
 =?utf-8?B?dmNpRFl6R3k1cDRqRjIrZ2FZTVlkN1prZlR6Y3JSZ1EvVkhqc3hWYkpTcFRj?=
 =?utf-8?B?VTZRTFpSTStldHIyN252QzJ2cjNQb3hmYjlCT3FMcExvZW53QXNiUVZ3SVYw?=
 =?utf-8?B?MUJQZjJ3THhpTzAvTnFPM2NBRktRaHhmVllZRVNVY1RvUmRjMXdyRzQrcVpC?=
 =?utf-8?B?ZndhTzBvUHladld6TDBQcTZhRmE5andSVHUrSXNMT3ROMys0aVpQa0JCYk1u?=
 =?utf-8?B?MllQZFFLYUJ3RThwSjQ5UjFod1JNRi85MW1sR3F6VmE2OEI5K2VjWVlyMzlh?=
 =?utf-8?B?TjYrYnRXWjBQekp0eUdsdUdVdk50TmptVENNZXE1RmhIY01paURsRGJ2cGlh?=
 =?utf-8?B?MUdzL2crcFp5bDJRUWd5YmxyajRVYXYvb0RtRzlCL3FPMjZFU1dkdFRuRGZP?=
 =?utf-8?B?QTRRK3FLYUhSelpjZloxejFPVlREVktveG4vdE16ckdyR3VtcFFnY3d4eWZU?=
 =?utf-8?B?ejZCTkdDVG9ybTJ5OW5GdEJqZ01pQjcrWXloaDVpT3FRV2tQbnRuZCtSRjVN?=
 =?utf-8?Q?vWf83GbNmrLkMEM5iO0D9Juv+?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fa8d97c9-6273-4aa5-eac4-08da6032997f
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4171.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2022 16:06:06.8005
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pfuHtivNQmKOYWionh0sLZBaAUaH4/43B726NIbzKPpWv/UjJpSkJme8KD7XL3ng
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB3267
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 6/25/2022 4:34 AM, Randy Dunlap wrote:
> [CAUTION: External Email]
>
> Hi--
>
> On 6/24/22 12:48, V sujith kumar Reddy wrote:
>> diff --git a/sound/soc/amd/acp/Kconfig b/sound/soc/amd/acp/Kconfig
>> index 7e56d2644105..abc089f38b6c 100644
>> --- a/sound/soc/amd/acp/Kconfig
>> +++ b/sound/soc/amd/acp/Kconfig
>> @@ -40,6 +40,17 @@ config SND_AMD_ASOC_RENOIR
>>        help
>>          This option enables Renoir I2S support on AMD platform.
>>
>> +config SND_AMD_ASOC_REMBRANDT
>> +        tristate "AMD ACP ASOC Rembrandt Support"
>> +        select SND_SOC_AMD_ACP_PCM
>> +        select SND_SOC_AMD_ACP_I2S
>> +        select SND_SOC_AMD_ACP_PDM
>> +        depends on X86 && PCI
>> +        help
>> +          This option enables Rembrandt I2S support on AMD platform.
>> +       Say Y if you want to enable AUDIO on Rembrandt
>> +       If unsure select "N".
>
Done
> Documentation/process/coding-style.rst says:
>
> 10) Kconfig configuration files
> -------------------------------
>
> For all of the Kconfig* configuration files throughout the source tree,
> the indentation is somewhat different.  Lines under a ``config`` definition
> are indented with one tab, while help text is indented an additional two
> spaces.
>
>
> so please indent as expected, and consistently.
>
> --
> ~Randy
