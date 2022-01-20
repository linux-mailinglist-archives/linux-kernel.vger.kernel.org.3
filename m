Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C0B864954A2
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jan 2022 20:10:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377407AbiATTKR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jan 2022 14:10:17 -0500
Received: from repost01.tmes.trendmicro.eu ([18.185.115.29]:42351 "EHLO
        repost01.tmes.trendmicro.eu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1346469AbiATTKL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jan 2022 14:10:11 -0500
Received: from 104.47.18.107_.trendmicro.com (unknown [172.21.175.6])
        by repost01.tmes.trendmicro.eu (Postfix) with SMTP id 090A6100004F9;
        Thu, 20 Jan 2022 19:10:10 +0000 (UTC)
X-TM-MAIL-RECEIVED-TIME: 1642705809.518000
X-TM-MAIL-UUID: 7089a83f-415f-413d-9908-6aaeb3da3983
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (unknown [104.47.18.107])
        by repre01.tmes.trendmicro.eu (Trend Micro Email Security) with ESMTPS id 7EC0A10000E3F;
        Thu, 20 Jan 2022 19:10:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UX+hHQzmYVNVBA4OmJ4/HNA9D9eSv4USdWwwbW4GcrjdNwSeze9cNp5OsOOe6jDEL8wlDieXJt6X7OAzRASK2oPQn3LNFu94xljb2Kib9nPcqR1GGgaW1/+c8kfAujO0G4pvcK0oYIbU/p4A3Rdg3Vb8H/nshwm9XutiW8GtbUR2aQWdfjbW8b/toRlvc2LX/sK0aI0MairiwEuaSmUgTAB14Ne7zky/iVtchqQ2/VsiXo7yMgNb0BvIQ/7zC2W5d4I4Qczzfc4769UBUU1O7ovuHuDbXwoZAu6X9QtF2EfQ4MeBK+2Tmkrmabtdj/Lw9VuD/qL37Ys4Tc2iNmZUYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XbncYZoSy9mWxZRDdeDoCbqgXW/tUQ5hTVRU/CfTljQ=;
 b=nXQ0/QGwUCM4dnJGNFWAU+pHIayLSp+IzfcjodvSynrxpmVSgzkcaI0DOG4lVDTFLtg62AF/X7dD3VQk8yBwREM4cdI9Ow1Azp4/K69kVAzvHkUqiOUsZTaZOxXY0ovJlCFeb3ZbefwYlOZjEbH2HSOLacdrweEMtN78lBOhARnoL8vg/4kJ1Tj/pSBaC32/luvIE+GcoM+uJ2+YuVl/upoSgPn8AHytqeoQ0lE4tSdwYjsGOAJh9vqwzorrBKFUqYCoROhL8RR10htu1hCREnhIXxrcAVkPz42lZiNhHOHV4PfV53DtYy81WKeiyK8TaGFiq3ZPoRSt0mLdUOOLYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=opensynergy.com;
Message-ID: <2f1ea794-a0b9-2099-edc0-b2aeb3ca6b92@opensynergy.com>
Date:   Thu, 20 Jan 2022 20:09:56 +0100
Content-Language: en-US
To:     Cristian Marussi <cristian.marussi@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        sudeep.holla@arm.com, james.quinlan@broadcom.com,
        Jonathan.Cameron@Huawei.com, f.fainelli@gmail.com,
        etienne.carriere@linaro.org, vincent.guittot@linaro.org,
        souvik.chakravarty@arm.com, igor.skalkin@opensynergy.com,
        "Michael S. Tsirkin" <mst@redhat.com>,
        virtualization@lists.linux-foundation.org
References: <20211220195646.44498-10-cristian.marussi@arm.com>
 <20211221140027.41524-1-cristian.marussi@arm.com>
 <f231094a-6f34-3dc1-237d-97218e8fde91@opensynergy.com>
 <20220119122338.GE6113@e120937-lin>
From:   Peter Hilber <peter.hilber@opensynergy.com>
Subject: Re: [PATCH v9 09/11] firmware: arm_scmi: Add atomic mode support to
 virtio transport
In-Reply-To: <20220119122338.GE6113@e120937-lin>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM8P190CA0019.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:20b:219::24) To AM9PR04MB8084.eurprd04.prod.outlook.com
 (2603:10a6:20b:3ec::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6e5d3780-7936-4dfc-82e6-08d9dc487961
X-MS-TrafficTypeDiagnostic: AM9PR04MB8456:EE_
X-Microsoft-Antispam-PRVS: <AM9PR04MB845626367FB15C74F98893208C5A9@AM9PR04MB8456.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ecXJVUXEVJtgGaOVBgfXsxExEcrYWge0o/EQYFmZT1hDAGP1WI+tsv0F2N4sp6P5GCiU5C3OvHLlzSeDDYRqQaURd2HujmnjeRgHzj6SwfR3Co5ZxW/qtJRUOCFhQXe1NqLzwgk15V+CGlhJnNjvzKZW04RXsE9i9FRt2R5yykFGtAp9m59YPUkbSCO05gkyv6FwKqbUfyt9EcOnyM7QLXa3N+vIHhjnYUFFNd14oqJ8gc/i043EO3o1/Y1z/zbB385Q+MZibpQHsD8KjhK+BD9uv2lunlsPzRaW1kaHisEHW3J960T/XeFTKRdbZfg1smhGKDo+6yWD0qGF9EnPdxbIVdpTiMDSxj+Tk31FxW435auOT7SE9+xTKLl6LKAIO955unCBC7QGGgrGidLwqkCDDxz7m2b3SNVlnfDSO1XmEQItrsk6ChZtoP0z6HEIUgbGkMUkgOHGWqD7OAxDRkafMY/M8AnubDnkbU2I234z158S7z1W4/r/koOoOQb+nlg3Z0lOEix3bjA0wKowTsI/SpQYqfHT/O8n2Ldo+QCJRI4yeUzPz6yuZLgaqXEXbKOsvp3YuusJhK/x3KhIAIxfmKh67xfYhj4wTuRhvBDrtvj9avMdcGyqSQYYp1BbUNkmObJID8Wd2KQZYImb3A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8084.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(39840400004)(136003)(376002)(346002)(396003)(2616005)(4326008)(38100700002)(508600001)(31696002)(7416002)(44832011)(31686004)(36756003)(42186006)(186003)(8936002)(86362001)(8676002)(53546011)(5660300002)(66556008)(6916009)(316002)(66476007)(66946007)(83380400001)(2906002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YVdERFVZVXZOby95WXVYN2tOOTZwYnd0MUEwSnlUYU1iay9qTEswdGxoKzVn?=
 =?utf-8?B?Z3FhYXVmeUUvVnJQT2NyU3JhdGdwK3hpLzdoVzBXOVlTdmNtajUvYUI2RHFt?=
 =?utf-8?B?T2lJWW5PM2Q0cEI0RDNlYk1ROG5SUW4zNnhKdVY1STU5VXhWc29KcGJLSkpm?=
 =?utf-8?B?RVVGZkhDQzBIR3JSTjVQM1BRSmFrRzNpQ0N1c3hKb1o3LytLN0JVdkh0UWNP?=
 =?utf-8?B?YmdqTHNrelpqNloxM29mVW9MRllaWXNqbEZ2blh6UUs4Y3FkcTAzblNzSEFD?=
 =?utf-8?B?Qi8rejlIbVVGSDQzRllQd05JcUFmMVBCRWg5ZEVGc2N4QXdiekhoY0tpQncx?=
 =?utf-8?B?cjJUaTFHaVRXL1dMenZrRDlsTVhNcVJKZ0xPUzdxU1ZUTzF2Z3prSGRVdzNZ?=
 =?utf-8?B?Zkl0bHlTM2JIN0xJYWNJY2x3bGZKOFBsZDBpSGJiU2E5WmRSQ1dyUFc0cWl2?=
 =?utf-8?B?YnErQWYwRk8ybHZycVhrUm5Nb0hZYStwS1NDSzNyMUZpckFOMFZVcnFXbWpT?=
 =?utf-8?B?T2twYVY1YjR4UXQ2QVdiQ1Z6bFFJcWxCTGNSWm55Mm9PU3ZjcVdpSzR0dEY5?=
 =?utf-8?B?T2dKQkYzaFZzUHduNy9wL0dnczdnMGdsTDV3VUdidUozSjJwd21xSVdTUXBR?=
 =?utf-8?B?ckJMbXMvbTQ1OWJmQXUwZmUzU1MraUdGVkVzQURKOXhGdGp2aEVHSm40VDJo?=
 =?utf-8?B?azE0REVXdUhmaFBsWnBGZzVaajZBNXQ4NVpVL3RWcTRpanRTNEttc0xhRzVJ?=
 =?utf-8?B?V0RLcHVydmtMVGZwQmxBazJENHVMajFJU0pNd25MaCt6WUNDK1U3OXRjV3Fu?=
 =?utf-8?B?Q3VaMkdKNG5KMDh2VjJxMWYwaDN3OU9hY2tscVI2d2d3NkxobkJHelJ1OHov?=
 =?utf-8?B?aU1xRGpFZnlvbjYvVnpzdkw3Qk8zbFlvbmxqZmxRVmdNODd4QnBSS28yMERh?=
 =?utf-8?B?ZCtBaTN1SWZtRFNmb1p2cURNUXRHdDlFY1lZUkpEWXhzNXVpZ2hUZWVTT0ZZ?=
 =?utf-8?B?NHBVL1B1L0xJQm5Hc2JvZ1ZrTlUwY1gxai9Nd1h2Njl1b1VrMjA1NjVXcy9F?=
 =?utf-8?B?Ny9RWlFBV3kvMVBIK2xyQzN1cjF5V2E4VFZyZ2lPdFFaZjJHUkFKYzJ3T2dj?=
 =?utf-8?B?VktwUUxtTTRidSthUkZpVGd2QUdxZGRWaXVBWHkwa3ZwWjMxYmRGZk13cm5T?=
 =?utf-8?B?MUp1ZktYQWt3L1o5RXlMTEhpdXViSDNBZ3h4TDVlK1FoNFkveGV6Tm5oMjJN?=
 =?utf-8?B?bVRDU2tObDFCZUc5MVp6LzFEVVFQUzJWNDN5dzhDWVpHOE03eVVsSUVvamly?=
 =?utf-8?B?UVlDeEFOR3YwMlFDeHRSTFp1aDQwN1BNamM4eGFKKzRCR1J5NzJkSnZqb2N5?=
 =?utf-8?B?MnVUeEwzOHk3WElXT2t0NEdSUFVNU01XYy9TSUVQUDBWZVcwN1E2YWNvZjZI?=
 =?utf-8?B?UXBZVmN1RnBQQWZKaVNEUUVxZkRmekVFSlNuU25zSXJTcHlvNmdYV3Fncm1V?=
 =?utf-8?B?aHdmWC8xQTNpRXNHTi9wdk16czBhVGY3UzBJUy95TUVuKy80d1piSjJFSlJV?=
 =?utf-8?B?OHRFWnBiVVZvZEIzV1RqZnRLKzI0c1h4WnVDN1NPWWJSVU96UU5XeEh2b1BC?=
 =?utf-8?B?TVlJN3F5Tit3azRlMDYrMWhDeCtlZDB2M1lwZTkxUEVSczBnYlN3VTRmWVVC?=
 =?utf-8?B?TEtOVHFucHE2UnVjSlhIS25sMkc5c0JxSXgzMXZOM2JmWis0UWErNldXZW1V?=
 =?utf-8?B?cEplRVFQdDhpdUhFbGwwSS9JRnV4czUyZnErMnR3TGVUUzROdlBVUk5XcElI?=
 =?utf-8?B?SCtCSitMaHhpYUJaUzdsMHdjQmRuV2R0NXgzQmJUNzhHalZnMmZSUzU2ZHla?=
 =?utf-8?B?Y3dpdUIweUpnaHNLVktlZTFWaEdZNmxaMEtqNThJOGVVTE43S0FCSmtJZURv?=
 =?utf-8?B?Si9yQTgyUk5IRDNZQldIeFEyS2lrVFEyTGp6eWFwNnZIWFhVbFFPQ0prU1c3?=
 =?utf-8?B?MnZNTHZ5UUhMcUR6Z2ljNVdSc0QyTkxHVWdWeGhibDQ1NDg4U3FLdElDTkVB?=
 =?utf-8?B?ZWNwVUJaNk9aQzJqZU04VGxkZjlmYm95TCsxWkMvWmVtbFZGSktiNlRPcm8w?=
 =?utf-8?B?WDB6dkRpTVB3VEdDa04zSDN4RkhCWCtzNlg5RFlTa29OZ1JXUkxGUGtXMFZs?=
 =?utf-8?B?NUJaSTVFWlo5N0U0UjNIVnlpTVdHb2h3V2RRQVJmMi9FK0E3N244NGhKNHFO?=
 =?utf-8?Q?cjIcmyR/5otYyLpmelWykWmP52VB4FoISRRTgAAGeQ=3D?=
X-OriginatorOrg: opensynergy.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e5d3780-7936-4dfc-82e6-08d9dc487961
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8084.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jan 2022 19:10:08.8542
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 800fae25-9b1b-4edc-993d-c939c4e84a64
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: b0FHDfuVvDNlyFd8eVU5Kiaah9lCsMe9WozMUQBzigC3R7nf5OTJjzkw6XaxfGTDAxcHN+NJQGdHjr6rbyo91Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8456
X-TM-AS-ERS: 104.47.18.107-0.0.0.0
X-TMASE-Version: StarCloud-1.3-8.8.1001-26666.002
X-TMASE-Result: 10--7.876700-4.000000
X-TMASE-MatchedRID: HLMPCFyIyBPmLzc6AOD8DfHkpkyUphL9TBkzBfi0S2rozDhGeQC9EhGG
        Vq+vrXC0IM1QSz4YfyzRzq1hrq+7fIEBch0HhZyDSJA7ysb1rf4BDya2JbH/+uZYcdJgScjxc8E
        5p4psr/4oaEw0vrcyU0FyCqXw8iTR7igYWrzLr2NmPsTq8ee41pGAt645FF0SC/U4++8MvOw9o/
        zfJjIK5By50jUz9JjaWptzQScjL90cKFYeDmCMalOCUA5CW4v2OhJ9m53n4aAiB4iMy2vMahaTU
        Fj6EqlNvYU7QFv6gDVNz/zGGCJXGLHUOxwKYaKnDcFFYSBeqVZF/jSlPtma/mn4AafOif9qusgS
        xXgjo54N8sUIX5KcWVgbIwmQJ5n4CGrFz5XLS3Qm2C2fR2e+ByYof8qPjr5V1R/ptYWR8C7OeXy
        tVjNb93MHjwPRUnk8v6hd06FmWtzHrBOag+OVTFb0VO9AmFFdDmTV5r5yWnq2ZO4LLn5VShuQ/T
        OvAfCtB1OwrpeKAlEKC1fDfIfRsBs7n0Ur0F2YwY28o+cGA5oiJN3aXuV/oS6Zl5fVYhDwBKbFt
        RGbqfGGM6cm519w3WDVH1LXrSptCpTi2aaDcciiVU7u7I4INX+ogtHzaKWZ0MT4bYTRBTf/utaJ
        EclLYbGP5wb+1U2+ef0ATglya9Xtd3sn1kwVE3TzPL3sqyAmBGvINcfHqhcFHDFnUY9n6l1Bh0X
        VM81jsmT19Td4iLsgk2UlrwLN1OW2YJaKXGMOfsrJIMK37At9LQinZ4QefL6qvLNjDYTwsuf7RW
        bvUtyrusVRy4an8XnN0DN7HnFmgaxrGsZBJbsETY0+7pEidiqOs/Te35gPvDQbJMqo9W8K4MA3J
        rQ9jpRMZUCEHkRt
X-TMASE-XGENCLOUD: 8513944a-74d0-4536-8c99-d00e745cfb8e-0-0-200-0
X-TM-Deliver-Signature: F6DF9BA8A15CE8540FA967CE027C630F
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=opensynergy.com;
        s=TM-DKIM-20210503141657; t=1642705809;
        bh=9KF2/1THB1Aujevph3wrFhr5C/ogcu31VgKjvBit6m4=; l=4163;
        h=Date:To:From;
        b=FypbcJZmAvXH/AkRdr/8Dl/zql7hrNaoMbtzu638ByDu4Ag3jZdZGD+a6GT0YYW0b
         OqUjvfA0qWEuy88ZkCbs19SUuBxzmCGSqOycV5g+TdQr5yWho2FJZqiaaLxv81YQLw
         9C3BU5HzOKe8FTwmH8OTwSsxMkj31rj0etWdNRVNqp3L1ngkfYjQMD8t+vMKA/YNV0
         KTGNYYvCPHds91+avclO0OZYzG8QjqHLuFP6GK3jKpJAWrKvbue9YdBTbfuCea0Y2E
         kNDjJYSIroZZ4v9qzKY8AtNg7nthy9y0CoxXEMRYF0zqOnkIoO7NZostu8L6hH7ZOY
         MulhAnWQ4GdMw==
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19.01.22 13:23, Cristian Marussi wrote:
> On Tue, Jan 18, 2022 at 03:21:03PM +0100, Peter Hilber wrote:
>> On 21.12.21 15:00, Cristian Marussi wrote:
>>> Add support for .mark_txdone and .poll_done transport operations to SCMI
>>> VirtIO transport as pre-requisites to enable atomic operations.
>>>
>>> Add a Kernel configuration option to enable SCMI VirtIO transport polling
>>> and atomic mode for selected SCMI transactions while leaving it default
>>> disabled.
>>>
>>
>> Hi Cristian,
>>
>> thanks for the update. I have some more remarks inline below.
>>
> 
> Hi Peter,
> 
> thanks for your review, much appreciated, please see my replies online.
> 
>> My impression is that the virtio core does not expose helper functions suitable
>> to busy-poll for used buffers. But changing this might not be difficult. Maybe
>> more_used() from virtio_ring.c could be exposed via a wrapper?
>>
> 
> While I definitely agree that the virtio core support for polling is far from
> ideal, some support is provided and my point was at first to try implement SCMI
> virtio polling leveraging what we have now in the core and see if it was attainable
> (indeed I tried early in this series to avoid as a whole to have to support polling
> at the SCMI transport layer to attain SCMI cmds atomicity..but that was an ill
> attempt that led nowhere good...)
> 
> Btw, I was planning to post a new series next week (after merge-windows) with some
> fixes I did already, at this point I'll include also some fixes derived
> from some of your remarks.
> 
>> Best regards,
>>
>> Peter
>>
[snip]>>> + *
>>> + * Return: True once polling has successfully completed.
>>> + */
>>> +static bool virtio_poll_done(struct scmi_chan_info *cinfo,
>>> +			     struct scmi_xfer *xfer)
>>> +{
>>> +	bool pending, ret = false;
>>> +	unsigned int length, any_prefetched = 0;
>>> +	unsigned long flags;
>>> +	struct scmi_vio_msg *next_msg, *msg = xfer->priv;
>>> +	struct scmi_vio_channel *vioch = cinfo->transport_info;
>>> +
>>> +	if (!msg)
>>> +		return true;
>>> +
>>> +	spin_lock_irqsave(&msg->poll_lock, flags);
>>> +	/* Processed already by other polling loop on another CPU ? */
>>> +	if (msg->poll_idx == VIO_MSG_POLL_DONE) {
>>> +		spin_unlock_irqrestore(&msg->poll_lock, flags);
>>> +		return true;
>>> +	}
>>> +
>>> +	/* Has cmdq index moved at all ? */
>>> +	pending = virtqueue_poll(vioch->vqueue, msg->poll_idx);
>>
>> In my understanding, the polling comparison could still be subject to the ABA
>> problem when exactly 2**16 messages have been marked as used since
>> msg->poll_idx was set (unlikely scenario, granted).
>>
>> I think this would be a lot simpler if the virtio core exported some
>> concurrency-safe helper function for such polling (similar to more_used() from
>> virtio_ring.c), as discussed at the top.
> 
> So this is the main limitation indeed of the current implementation, I
> cannot distinguish if there was an exact full wrap and I'm reading the same
> last_idx as before but a whoppying 2**16 messages have instead gone through...
> 
> The tricky part seems to me here that even introducing dedicated helpers
> for polling in order to account for such wrapping (similar to more_used())
> those would be based by current VirtIO spec on a single bit wrap counter,
> so how do you discern if 2 whole wraps have happened (even more unlikely..) ?
> 
> Maybe I'm missing something though...
> 

In my understanding, there is no need to keep track of the old state. We
actually only want to check whether the device has marked any buffers as `used'
which we did not retrieve yet via virtqueue_get_buf_ctx().

This is what more_used() checks in my understanding. One would just need to
translate the external `struct virtqueue' param to the virtio_ring.c internal
representation `struct vring_virtqueue' and then call `more_used()'.

There would be no need to keep `poll_idx` then.

Best regards,

Peter


> I'll have a though about this, but in my opinion this seems something so
> unlikely that we could live with it, for the moment at least...
> [snip]
