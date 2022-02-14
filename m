Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21D254B5511
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Feb 2022 16:43:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355967AbiBNPnH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Feb 2022 10:43:07 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:39520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243798AbiBNPnF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 10:43:05 -0500
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2062.outbound.protection.outlook.com [40.107.237.62])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9643E4968F;
        Mon, 14 Feb 2022 07:42:57 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V6ePiIrgdM5oy591SMceLKEcZ6WJsciSRcRrGChQohANPUTwaHOe2ynFNaBEyxY1YXwiwW4r9zRkw8ZOjx7NivtgK3SnVWiu1DAJTHBBVdQbdAJUwqKLjQ+peiaGqcspWtygNoTnsUpRFtAOUjVG3e8XlGC7a2CM73XtQX0Bw32aJR5o3d/Wrjr+93gNrZQqpW814PwbhgWZtCsiczbrRSEKnq/bAFO3JiGKarOjsFejvyk7Q50RYHBud0GoNFmdE1Oz0GTuKVkAGLz5oWC7SdwY7osz2WjelyjWSjjwB7CzllP6y6LU0o9xc07z+99i7R3MoVm0YgO2sV3xufT+Gg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kPgLiXLoa32umhIDLTwkDs0ipQOl2drw2QoiK2sNwxk=;
 b=OcCzMT6SdG3FZm5pqFYhOjgGw5hXKmQMSUOiyXrUSKm7Pzfx/1FPH14V3654BobHCHoC+wJ803RM0/lHMWa55KHzRogGlcrotzwYLvkidqntNMxgwzAqpIt12SK+55uVCJzEFADjKNOl3t4jafQnf0WBiSKfRCnh9B15rWppfdWe49mRlb8ZYGbnH4mebjwWS38fFdXpXNwyUy2ji5QrqY26RojoBxHOnsuO6QF1x0OteblMMlVRAidEOERw5SvSQd+/3RsQ2aUeBDSYEi0IpD0ibazv4jvSXC/7ctNS7OshD1Ju2C0umCO85/82ONn4TJwctcQdls9YzNMQqcYSlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kPgLiXLoa32umhIDLTwkDs0ipQOl2drw2QoiK2sNwxk=;
 b=otgGEl5leGl38XJf3dGJJLQ2bpVhsee/mLYGO3ptpmEIVSR9JjFx42SI2mRBpgCwyTEH85vQdmobffrfgRY5NbsS+NiGvcIeAsoTDmhGtQxhWdz1oaYqS0rHtdRssW30e9RIUeZVRhfBomFDHViUbyGqxbqRndMOLA5T7GQQ8bW03lmFqMrbwyarDRAWfLvvqa6D/eeWSC/kBnZmO0Il6KklQhD3FVkEe46oVpS/Io72fla8n/gjn/KBmKzP5ShjAIcv0II7cMsbGzNz0um1BhvoFFU4M78mFRX1dLrFsLvn7a7Cv8RiT741uj5ViMFkR3gVdzcfxC4hXa4N9+lQDg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CO6PR12MB5444.namprd12.prod.outlook.com (2603:10b6:5:35e::8) by
 MN2PR12MB2862.namprd12.prod.outlook.com (2603:10b6:208:a9::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4975.18; Mon, 14 Feb 2022 15:42:55 +0000
Received: from CO6PR12MB5444.namprd12.prod.outlook.com
 ([fe80::b120:5877:dc4b:1a7e]) by CO6PR12MB5444.namprd12.prod.outlook.com
 ([fe80::b120:5877:dc4b:1a7e%8]) with mapi id 15.20.4975.011; Mon, 14 Feb 2022
 15:42:55 +0000
Message-ID: <dea35c3e-c5ff-b7ba-7498-fc67493d96b7@nvidia.com>
Date:   Mon, 14 Feb 2022 15:42:48 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH] mailbox: tegra-hsp: Flush whole channel
Content-Language: en-US
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jassi Brar <jassisinghbrar@gmail.com>
Cc:     Mikko Perttunen <mperttunen@nvidia.com>,
        Pekka Pessi <ppessi@nvidia.com>, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220214153256.162261-1-thierry.reding@gmail.com>
From:   Jon Hunter <jonathanh@nvidia.com>
In-Reply-To: <20220214153256.162261-1-thierry.reding@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO2P265CA0444.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:e::24) To CO6PR12MB5444.namprd12.prod.outlook.com
 (2603:10b6:5:35e::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 95f76ec2-7c4b-407a-79ee-08d9efd0ab33
X-MS-TrafficTypeDiagnostic: MN2PR12MB2862:EE_
X-Microsoft-Antispam-PRVS: <MN2PR12MB286241FFDE4DAA41C8E7C9BCD9339@MN2PR12MB2862.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: t+Ws9tdt19utzqOTO4vPO6+wVLkSGzZ97Jzf3m0TLQaF18jQU/JkT0lxGslcE1qslVnc/SvowL23Byix8dgsKK9YWI0bvYN7vY6J9Hml1dEk0YRtJaVU2pOJH+D0xWgOal+snW5czuLTCieLgOF28YZ89cuhcUAzmop2IXNk+VBPR79Aar15IB7tfnC503+ITqTdX2ZrSzJQrbxcafZ0LdwW0lYvOT9Ims0YJS0R4mCygtRIzerEDMb6lKFqJ7ZWk8n5b5w3qcRvdBjtaKI3Stpc5H+5/cm/bFAckP9RkH21QTnrg9J/37+gLvovDDzD241ZyliAfRixWH+8SV8UjxmBLf4KOeSnubby8Mg3bnZ+SV1pgz55w5Mkxfmy4CPN23LAMKTEo4aWoZ1g8hFMn9P9JdWGbouzOQ59o33/W6/XvX0l7BxJA5b4Rp16KKXjLu6/udvJiz+U/1h+qHe6jJEnVrZcc8PwS+MOtnpZC5WLOcWRNSGNY1FZosSGhpKt18VLBfrC11lGYAIvKml1CpaMRSg++qRzMGR2I9DBtKatI22V8x9F9rgize6ifdEeNeyC0wNZWL127dkUXro8CTePyC1dUnluhp028Cs35rgtF2f166GvQByYs0ie/cSPALbNEkY0xka20/tvdQyeSkCCS3ndWtDa602o/09Y1vAkYyOGzZLEUgReh7oa6/Ib0Hobyc/jf8KbeW8uoh/6rBYNRWqZ62L2E7rhfazaGP4=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR12MB5444.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(36756003)(2616005)(5660300002)(15650500001)(31696002)(2906002)(186003)(26005)(8936002)(55236004)(53546011)(66556008)(66946007)(8676002)(4326008)(66476007)(38100700002)(6506007)(508600001)(316002)(54906003)(110136005)(6666004)(86362001)(31686004)(6512007)(6486002)(83380400001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dHBDRWozQzNxeFc3MTJaUmdGaGI4Z3lpT3FLY01xTEJQLy8ycHJQVGtybm05?=
 =?utf-8?B?dTNuTXhiTW43K05GZnBkcVVZYnFTWVhaSFJHcnJ2NEtZMCt1cUUzdFJ6NDNS?=
 =?utf-8?B?NW1ETkE4aXVOZVIxN3BScTBaWFluZDhTeGk1QlZWd1RLckRDNmI5clRoN2Jl?=
 =?utf-8?B?czFuRjNhdmpRbjdSZ2FFYWlMVzNKN2d3QXZjRG1hcjRtRDlWdTRwSVB5ZDZq?=
 =?utf-8?B?OUYxUWd5UlVabllBSGlIOVMrMTlUc1AvVDdmaUs5Vm1acTFxSXUzZG5id29x?=
 =?utf-8?B?M1Bwa3V4OFRDaitya2MwMmhwU2l1bHpHc2Naa2J0M1o3bmU1NnYrTWpLcUdM?=
 =?utf-8?B?Y0RzRjRxNjZUSFcwMHAyeDdiTFFHdE5rV1FIYllmMzJad0pTWStYZzR5Q0lC?=
 =?utf-8?B?M3pwdUhMckY5T05pcUNCc3p1eWtKQnd6b1RwUGJDSUJ3NW1HN0Yrc0wxV3hZ?=
 =?utf-8?B?SHAxNngrM1lua0VpUlB0ZWlxbFMrZXBlZ1lxbDdnc0s2Rjd5T0M2Mmd1cXZM?=
 =?utf-8?B?UnpjUFNjMUdQMjBWOHpLY0p6TGlXODVLM3VYWXc1STJLZy9MNHdQcW1Edldl?=
 =?utf-8?B?QjZVb3hnaGsxRVVSckNOVStZTFltSTFBbXdCNzZlb2RMbXRaQjNkSWVQZlg3?=
 =?utf-8?B?dFI4MVlDKy9KNThjakdyN01lWGo1MDZsZHNvTXB5UFpjZnhzUGlzTFVsK1BO?=
 =?utf-8?B?eFZTS2hmTndPbG5vWEpqL25nSFhzRjBqVENOUFhZMC83WHlnTXh4dmxJc1Ay?=
 =?utf-8?B?cGFOZ3dsNXJ6YkRIYkVoS045WWRRUDYwMlVaMUZZS2hrMGx5NTg5VWZsRGJi?=
 =?utf-8?B?eGp1TGZ0SHFvVVhhazJUc2d1UDR4eHhLQ3A3TVRETlRlSTNTakY3Kzd0eVZ2?=
 =?utf-8?B?SU5XRmR5V3FyZ1JYd3FXZzhkWk0xU3RjeTlobDNGNFR0SVdFVlRYNVNQd29o?=
 =?utf-8?B?UFMwdmI1MXVqRGc2R1NRZnVkazlPZnBGeUdLYXNtMTBCS1JmczJ0ZVl3UnR0?=
 =?utf-8?B?bWxqRzJKWldTbkRaMFRYY3JrRkVWc1hDOGQxU2pXUUUxNjhpbG56MzBaVGFJ?=
 =?utf-8?B?cHBxbTFxemVFZGhGV0Fyck5rVHlvTFRQNHFqTFMvUzlzbndiMk1NMHFxcXdx?=
 =?utf-8?B?SVdLQjRHeWhOZHQ1TDVpM282b0lYRUNMWDB2RzY1NURUMWlFWDBIdGFHeWpL?=
 =?utf-8?B?UEZDSTQxSFI0MnpvaWJQNTlpVjRJNUtyYmZnaUU5RGhIWEsxMzMyNUVFRWlx?=
 =?utf-8?B?UTlvRlE1TzFmaStqd0RRbERiVHNSUFJYUWVyZERhVmRJYVNnWERtdXhzYVhr?=
 =?utf-8?B?UjJmeVpPV0ZKSnErYTRIU3VHMXFzZisrNW9MRWpHWVJjNW8vMkhGK05ZQVNZ?=
 =?utf-8?B?dDlJdFdxcGtyOHYydWJhaTcvVE5aT2FENW93ZFNvWVJKVkVDbTVpYVd3Mmx3?=
 =?utf-8?B?MHJpcVVrL2lJSkJjY1RaRXJNakFmLzhUUHJHWEE2d3RxQnVObjFmMHlwUXJ1?=
 =?utf-8?B?bk8yR0lBSXg3cWF6ZmV3anpkclR4SDNodWExbndNMXg1QzBwaEtrYmNtZmlk?=
 =?utf-8?B?cnhUTkhKN1JaY2lFbDI2ZGhwMmFCVGZvS0QrRVdPK3V4ZG1qYnVaTndjem1T?=
 =?utf-8?B?OHkrbkFaWHA4YTI1cG5uZW00d3NKK1E0WXYxTm1MVkFGVTZLZk4rV2c1bXdP?=
 =?utf-8?B?QmozUkxGcjJrUU5nTWc1b1lCblU4anRTM1FYdDlRQkt1NmRudG5WTmkyQnM1?=
 =?utf-8?B?ZVl2NC9hd2hycmNDNnExS0o1YjZFVDhjcjFnVWlXLzlsa0hQQTNoWHk2RTF6?=
 =?utf-8?B?T1JYVkNUVmR6UHo5ZU9hTGs4Uk42ZFk2K2FNRWdhcms2WUlXUXZYc0N4M3hD?=
 =?utf-8?B?ZEliV1J0SXdiVWdOUWx5S0MwOFpDa01KM0UrUXg3aGdMcEdObFJmSEh3TjJM?=
 =?utf-8?B?MlB2OUhUbWM5NmliczJwU3RiSzR4ZVhFQWN6YnIyeU5aY3ozSmRxVTZOUlJx?=
 =?utf-8?B?WStjOGJFem5KQ0ttUVNTTFZuVVJEU2MyRWw0ZGVTWU94b1F6Zm05eTBVd1Zl?=
 =?utf-8?B?b1B4b051a29WOG1pV2RVWVJoVTN6ZlpvZEVPNGdnU005dmFQcDdNYkZjR29N?=
 =?utf-8?B?UWJkeG13S0E1MURnMVpBazlrR08rUFUyOGoyU3dzdzdTbGtmaTdlSFZDa3k2?=
 =?utf-8?Q?oMpKyY/kgtvt3FUo73EH6Fw=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 95f76ec2-7c4b-407a-79ee-08d9efd0ab33
X-MS-Exchange-CrossTenant-AuthSource: CO6PR12MB5444.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Feb 2022 15:42:55.7158
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XIOeUflUc8BipkPs9vtLqvpZAAgehjFeYZcibzMEZESapsjZRK6590/QTpxsNIHWpGwBhDYYGgr4lo9VPX5HwQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB2862
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 14/02/2022 15:32, Thierry Reding wrote:
> From: Pekka Pessi <ppessi@nvidia.com>
> 
> The txdone can re-fill the mailbox. Keep polling the mailbox during the
> flush until all the messages have been delivered.
> 
> Signed-off-by: Pekka Pessi <ppessi@nvidia.com>
> Signed-off-by: Thierry Reding <treding@nvidia.com>
> ---
>   drivers/mailbox/tegra-hsp.c | 5 +++++
>   1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/mailbox/tegra-hsp.c b/drivers/mailbox/tegra-hsp.c
> index acd0675da681..78f7265039c6 100644
> --- a/drivers/mailbox/tegra-hsp.c
> +++ b/drivers/mailbox/tegra-hsp.c
> @@ -412,6 +412,11 @@ static int tegra_hsp_mailbox_flush(struct mbox_chan *chan,
>   		value = tegra_hsp_channel_readl(ch, HSP_SM_SHRD_MBOX);
>   		if ((value & HSP_SM_SHRD_MBOX_FULL) == 0) {
>   			mbox_chan_txdone(chan, 0);
> +
> +			/* Wait until channel is empty */
> +			if (chan->active_req != NULL)
> +				continue;
> +
>   			return 0;
>   		}
>   


Thanks!

Tested-by: Jon Hunter <jonathanh@nvidia.com>

Maybe worth mentioning that this fixes an annoying issue with the TCU 
(Tegra Combined UART) where the output is getting truncated. I think we 
should add the following fixes tag and mark for stable too.

Fixes: 91b1b1c3da8a ("mailbox: tegra-hsp: Add support for shared mailboxes")

Jon

-- 
nvpublic
