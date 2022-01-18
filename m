Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A451D492B9C
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jan 2022 17:53:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346602AbiARQxi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jan 2022 11:53:38 -0500
Received: from mail-eopbgr80083.outbound.protection.outlook.com ([40.107.8.83]:48868
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1346450AbiARQxe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jan 2022 11:53:34 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l4sMq7gx4i8d1iXMyTzsl0xWvM1bTjcoo3jz1VuHh/KeFXG4E0bMU01ZdL9rHrz7rAXOHb1HzTXQrOdVPA53jurUEpsEo3dvK9b15erYjz0+XKd3AeWBGILQ3eTq2ovd7m6t2M/n2GkjxKFE02ZHiU0uL+7QGkXiaOdXH0FPEkaDaJA+nIRHLJ8YyXAG4euQn3tEsz+ArcsMblF/91Iop6pXLTvgDdDkaSd5fSOqmwJDZVyBkIpOGQEtiM1Ilq/3twH67Qj4uUUC7NQv6CvWwOTqNHLnMrXnqLWsKJFIEculECp38DjvbnzWB24kfe0QNP3hf7sC2xfgRyHh7OTP9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w3tYqaqXxd6BG0QvJYXtxU5bjQ6UydXoo0d2qiN+DbQ=;
 b=CmfZiIM8/hkMfgP7sFCRwPx8lxz8Ij3wEQkuRxHEfz+F7ZqPgqaRNxA20ooBXelbCynMutvKZ196oEud8VZqjEM0xtdG8l49rotz49TiGco1EW4Yl4cH/LYsarkkAHqGHt7C7rXd69/rGWcIFuxgDskLfV2nir+fwjmk7E8L2STaMZ30Y2r7lCOAqDHdeODIUbw/8SLt1MmI58cj8HWZzj1mK6N4PBj0QQeMefuQv6/krDjS6/ocjZPlHWODD80VS3VItRfGEvegrNWij/zbcmDnAWg3kamhBRSDRHUr0xUM57Qo++L6QTVRFseuPHfU74+rJz/N9qiW+6jbQNu8lA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=seco.com; dmarc=pass action=none header.from=seco.com;
 dkim=pass header.d=seco.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seco.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w3tYqaqXxd6BG0QvJYXtxU5bjQ6UydXoo0d2qiN+DbQ=;
 b=mdfBy25sc/6EnuZo6tESbme+5dArQ/fpODp4wRaHYHJgZ8gTqkzfBnh/6572YMrUF3J9KJZJxrnXFxSdLPG9jo2tolXriJmp7E45E7gOKTfw1lrlmrziiMGt+9YX6vkRsky9NLhPkfu5B/fQnCciuv3MUzxz/ogy4YpfL1+t7yHyvUTS+FaGrRYst+8+a01LeXFwm/b+OzrTGJLs5zkWEGamwiNdwKo2nIxVWCCkEWlS4HfAyK68/MqWV81+ytsPFmq+Ud4Xf75iv08NcEZHm/kRXlvxUEyvsWIvCieRy3fazmW/vWVb6mjvfcrYZWWlydVYKiBmjTStHwwKLWsTFw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=seco.com;
Received: from DB7PR03MB4523.eurprd03.prod.outlook.com (2603:10a6:10:19::27)
 by AM7PR03MB6216.eurprd03.prod.outlook.com (2603:10a6:20b:137::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.10; Tue, 18 Jan
 2022 16:53:29 +0000
Received: from DB7PR03MB4523.eurprd03.prod.outlook.com
 ([fe80::d47e:81b0:256:3005]) by DB7PR03MB4523.eurprd03.prod.outlook.com
 ([fe80::d47e:81b0:256:3005%4]) with mapi id 15.20.4888.014; Tue, 18 Jan 2022
 16:53:29 +0000
From:   Sean Anderson <sean.anderson@seco.com>
Subject: Re: [PATCH 2/6] usb: dwc3: Get clocks individually
To:     Robert Hancock <robert.hancock@calian.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "bjagadee@codeaurora.org" <bjagadee@codeaurora.org>,
        "balbi@kernel.org" <balbi@kernel.org>,
        "baruch@tkos.co.il" <baruch@tkos.co.il>
References: <20220114233904.907918-1-sean.anderson@seco.com>
 <20220114233904.907918-3-sean.anderson@seco.com>
 <1c242d0114554b72f8f0b1f6507973a0dea50b3d.camel@calian.com>
Message-ID: <614267d5-4cfa-94d4-3f2a-c2467b3b9cd6@seco.com>
Date:   Tue, 18 Jan 2022 11:53:25 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <1c242d0114554b72f8f0b1f6507973a0dea50b3d.camel@calian.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BL1P222CA0028.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:208:2c7::33) To DB7PR03MB4523.eurprd03.prod.outlook.com
 (2603:10a6:10:19::27)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 830181f9-2af7-4386-8a4a-08d9daa30d67
X-MS-TrafficTypeDiagnostic: AM7PR03MB6216:EE_
X-Microsoft-Antispam-PRVS: <AM7PR03MB6216327BB78EE3A6AFFE342196589@AM7PR03MB6216.eurprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Q4Qj9oIJ/wAjBBAl1umARClMriBcpAnEHKJDQ9yXcbtShRJ2uCGgVL90PiKY/sQJGQncbV4sYRfDhytzsYoF6Es0/QJGk/nspG6FAYZOoZDPMdnL/kw2hVlgy5Ngt/6RAkKZSdolpO5fKhRhDMRt5NQSFWnHiRIWh3USFNpQBQil+EWYWJxjf4MFhkq98RRNgjqIDsQIkA0dqXqi5rdj20vyzZAIZDEEO+rfii5O/O6hg5BQjs5kCIfCN+/ouitboOA9VUuT2NmkGJ883sxN21iGSzUKY5ZWzv/AF4NE+wvP1y/AdqHsdHljAekgfzJfdtnIVJ+7taka13nTiCM59llSoQ7vMsP7E33oAF+PH+TN4y8kJZ/BAlD0h7Ks8miOdalzYlne1VE6msU/6eVVM+xIxCBb2w2LxRFtpchUntCUL6K6sFf0jBIhtznJVYldp2pOoEXRm1nhYMsPlpiUIKi0YCrAEZnj3ClOQytuKCa9Tf/2rOtw3lbffUu8BSIBOcuteJ8j28clCc+P5jyezmQHTPKcrm+9lDXGI2/EgLJML980hqn8B61fUL2f4Zt2ZIrzRIgEPJIZ4NXfUKBzayhHMVzXWY03J0BFXAPzm6CsEVVfLqcpMjvwDReK1bb/XeGs8Aupe5XUMTNseBRA3a3KmkfqksBOmgFLrzT6HpSTUV6Is2QN6JlTrhxvC+PcjUCi5pAK3OXD7uyrJO4/ez0TxKu8wZTZmIlgCM/rkX4iQ31F5lkCIUEEbVZqAi/MjZkRjzx1HGzCXiWf3/scfw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB7PR03MB4523.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(4326008)(8936002)(44832011)(36756003)(26005)(38350700002)(54906003)(86362001)(66476007)(186003)(66556008)(6486002)(316002)(110136005)(508600001)(66946007)(6512007)(6666004)(2906002)(38100700002)(8676002)(2616005)(52116002)(5660300002)(31696002)(53546011)(83380400001)(6506007)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QUN3ZTR6ZkZXT3VNVjYyQXZ6N2NQZTVFb0lFTWFIWm1vd2RoZ1VYbHkvVXY3?=
 =?utf-8?B?Mm1hQnZhTW5NNW1VS0dtcDJWaldETVk2M29FU0xlR0xTdEdxdk1aT2xXU09M?=
 =?utf-8?B?MkZpV29hMndJWEZ0NHAzYWo1ZGp2Y3VUVlJxdTBHRHRhMXRhYnpHbEVuU3NK?=
 =?utf-8?B?aXcvK2docHZTc21jUUk2T1c5SjFMQ3I3Z0xBd2ZGdXZBMW1NSWlYWTRJSmVt?=
 =?utf-8?B?cEEvY2JlSzliUVkwR2tpcVI1TkgyRXB3UUd1U2ZtaWwrMVExaVE0aElhby9n?=
 =?utf-8?B?Yk44MjFONHYrZG8wU3VQM1A0VVZOU3dBOTZqMmVrQXhSK3Y1bVhFVmcwZVhj?=
 =?utf-8?B?aVA3aHROY2NEaHdQL3JGQ1dpUEZhK003QlI1ajNyajNucHBiTWJ4R0VPcWg1?=
 =?utf-8?B?U2dLWEFmekxscjJLdFc4dWFDNHMzaG1MaE1EMlBFdFMvWXRHMkcyczlaUStz?=
 =?utf-8?B?Vi9HUUgzRXJTZzQ5MElSS1VIRnNZV3U2YjY2Z3hLTEZCdllVSSswVzU2ampY?=
 =?utf-8?B?azd6MU01b3dPZXo4YTBsWFdYSlhSL01vNWg5MG52RW9DZnAvbi85WVZ6R0pt?=
 =?utf-8?B?cVlqakJwOFdNUmJGaXV4a0FJUDhTM2JYbjhPYVN6Kzl0YjNKUnNENkErcnI5?=
 =?utf-8?B?VmtGKzExZFRvTk5aZWFsOEZTam11NHJnQVZLbEhZUDNhYjN1NDhIRFJRNzl2?=
 =?utf-8?B?b3hnRmFWWTFyeWZQZTlEMnVQK3AzMDRKTEkvSHhjSnRVeHJodUtmV0dkUG5O?=
 =?utf-8?B?Y3lyc2VPS3pZR3RXbkNldUJVQmwrMVEyd1ljYm5YRkFKaUozR0FjeVJ0MjhT?=
 =?utf-8?B?MStDaCtXZUpZSkpMbzhrYUEvaWRnSnJ6WDVzVjF5bXZObmRIQXgzQVRzVXBI?=
 =?utf-8?B?blRxYUc4bkowOUQ2ekRXV0tPY2l1cnkwZ2Fqb0JGVDAvQXI1dGJuWkVGZWdL?=
 =?utf-8?B?TUtkTDR2ejlheTRXbHJYaExja3lkemJyaEFHRjJCNzRNem9jRkF5c29DNnlr?=
 =?utf-8?B?cVUyd3BYZFhEOXRSMmFJTlRJdmkzaTRBNmh1S2xVeU8zZUtSSjhmVU80dG9S?=
 =?utf-8?B?UStmNHdOWnFPS09iQkU4NUZGNXJaTU9vZStURTk3K2ZGTHBjQmswakhOSlZ2?=
 =?utf-8?B?dHlmQVdNM2liQ25jMTFTaG84UVYvem90MVdwMDlZcFluK0V5N1FIcjhQQXor?=
 =?utf-8?B?RWVDaHdtMmhaYnA0MC8wSGZkM2NwS2FhSnVnL2VJNU5PMXJhdnBPb2FOYzlT?=
 =?utf-8?B?cXQxZkdiaGFRak1KMjZmRDhuV3dxeDBPT3VFNTlFcXgycm8vY0RLQlRPbGRL?=
 =?utf-8?B?cEpWQnllZEtrVWw3S3NTZHhSWHVzTlAwNFRCZFU0aEhQMVRNQ21Od01JVVpk?=
 =?utf-8?B?NGo5UzNhZElhMzI5UTVBY21XZVNwU1pwbTNuNzhjTUFuR1p6YXV0L1hvL0R0?=
 =?utf-8?B?TWZWc2pRdk53Rlk5QjF0N0JITkxpQnV6dTBWcnk2S3ozdmpPSlp4a2wwZS9k?=
 =?utf-8?B?STBSRlhORkQ2TC9HVVE2L2kyUEsxTVVpMktvdDBhS0pnT3c2VTJ2OEk5Wml6?=
 =?utf-8?B?MVBlUXg3Rk0zd0Q3RGtRNkM2ckowZ2l5bXRkODlQaUsxUXIxbENkTnJiSXIr?=
 =?utf-8?B?M3BCT2twdHh6WU1HbVJ3RTB3WktoaVV4YVhUYVlhTTdIWjJKUlRpV2NmQ3k5?=
 =?utf-8?B?Njl3Rm5pV3dkc2VkbUZhTHZhb1A4UFVzN1Y4bmlkVGszL2NXYlVabzczVmZj?=
 =?utf-8?B?a0ZrUVRKMEZXRzlFWUx5dFIzOUxCN1lxMWVTcnF2MHJsZlNSSXBvaW9GN2xv?=
 =?utf-8?B?NXZucTd0ejhwRmpocTBJV2FZYXlWbFhaM1JxdDM5cHZYcmNvK3VROGZxVzU1?=
 =?utf-8?B?T0lSMzhDeHFtMVhVUFdSUU9pdEFtVmY0dkZvdGZtTWZsKzk2dGp2NnB1Uy9m?=
 =?utf-8?B?bHBWaS82MUwxbTA1d0tDcG1EOEw4UENCSHVHMXljZDZXR2lzVXBqRFhEV2E5?=
 =?utf-8?B?TW52YU94dHRodVFRb20yYW9nMjRLTnpnNTEyMDVZMEVEeWI2bjE0S09VM2lV?=
 =?utf-8?B?L2VHS2syTm9ZbzJGOGJwOG9Dd3FtYnhIcnhJRTBmVmxKeWRwUVJtSmVub0hS?=
 =?utf-8?B?UGdkdlE5NHkwWFpWTmJROG11ZGx6N1N4NGFxNHZBaTcvWXZoMG5kTDF6eWt6?=
 =?utf-8?Q?zoTNB3gVanw7C/HFpO2FRLY=3D?=
X-OriginatorOrg: seco.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 830181f9-2af7-4386-8a4a-08d9daa30d67
X-MS-Exchange-CrossTenant-AuthSource: DB7PR03MB4523.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jan 2022 16:53:28.9830
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bebe97c3-6438-442e-ade3-ff17aa50e733
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: w3koFZxjg4xMdRGp8BGwyzLh/+ulbUEhYiJDIYvEdd0Z6ZbNY5YeT4rF+74Fyod9pNBuVaYYGiBgXY7wMbtd3g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR03MB6216
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,

On 1/14/22 8:04 PM, Robert Hancock wrote:
> On Fri, 2022-01-14 at 18:39 -0500, Sean Anderson wrote:
>> Instead of grabbing all clocks in bulk, grab them individually. This will
>> allow us to get the frequency or otherwise deal with discrete clocks. This
>> may break some platforms if they use a clock which doesn't use one of the
>> documented names.
>
> Another approach would be to keep the bulk get and prepare_enable and just
> search through the clocks in the bulk data to find the "ref" clock, i.e.
> something like:
>
> 		for (i = 0; i < dwc->num_clks; ++i)
> 			if (!strcmp("ref", dwc->clks[i].id)) {
> 				ref_clk_rate = clk_get_rate(dwc->clks[i].clk);
> 				break;
> 			}
>
> That's probably simpler than all the extra complexity to get each of the clocks
> individually and release them in the right order.

Hm, maybe. But in the future, we may want to access other clocks as
well. E.g. perhaps PM might be enhanced by treating the bus/suspend
clock specially for some modes. I think grabbing the clocks up front
will make later patches easier to write.

--Sean
