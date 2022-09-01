Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C5F45A9B99
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 17:27:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234325AbiIAP0X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 11:26:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233496AbiIAP0O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 11:26:14 -0400
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2083.outbound.protection.outlook.com [40.107.22.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2261B66134
        for <linux-kernel@vger.kernel.org>; Thu,  1 Sep 2022 08:25:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c7tUAWpFjogCG7EaSXXhXtWUqaqjfr31iUZNDQ2uzQfiyDI1OXVgrdriHTVP0W6k2O0JHXNuL596J06IMYDEpNTNwJbvCKTbuQyp7BunmcITt8y4PqawvhicMSekQybOg02LtTwf2ek5KPSqLNIw466DmQUiwK7kHeIN+m+6OXq3rux8xP6JuDAegWtPzfmIYYTnz8EfE2o0y1Upe8e96ouNlKAn6uDAiQqvt2Zkcq2jXqIgq3iuD5B7Q4N2WFCJtPVzQgn/DB2EIob6f+XJl6ia5wfQyFxyrZPjR9holAZD7KvVZoO/6Tex8Oho8JEjzJpO+IuHNKWVVDjxI4N6Sg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jyyvXG9ILCB1oOAl7jBlhgLa82NwdqOv+U0/8rfFhQk=;
 b=jxd3Fq4JaSuHmx5o9pN0WaLiHpSsP6pK6w9aIRWO8+ejaV3MEEOOrn6IvsBCwnXTGyo5qOxYLfRLrMjqo3x8EZV+cWpTA3V5noExcip//ueqiQfaihyJhRlkUvIhXV6w81/b5ArjLlg1X56JD+FTVLYjcLq4cy6UiVq3uCKAyyhVTMmBUxJsLhAOZo5b07772ZPhK5Suj8qTiTitVGO9ujyxLBIW25zcmTDy+jZz7FsxPLnt8oderilyv7uhxMfoZW7RqhBbDpdRnUS+TEoxDcF/bDf405URdZZsR8T1Q7o4ZVNLP/XpgYKIMPNglKoGq5fA1HmK7uWmtoi5JuKOMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=seco.com; dmarc=pass action=none header.from=seco.com;
 dkim=pass header.d=seco.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seco.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jyyvXG9ILCB1oOAl7jBlhgLa82NwdqOv+U0/8rfFhQk=;
 b=uKNb8monVE9Z8h6TgXKEFnlpi0ZHmDSBfD1V5XqcyynqGTmBInel3N3xH95LYht+NE/bVA+PF6/si97JwA/zGo4My4k1bBee+ohzAg+/jk/h99PKJOkzjpa4JTh8t2iTCRAaRFLXDe32gGz4TMktNVWeW2sLJFLIofGUySDS4g3ZPpHSIKEhVPyuEcpG3jCaRPbCJToI79deAk8nJ52USA4PPdokXxzR8CXr0wP1aJ207oYD4MJItm8P972gjy29/YoGLGFEmFL0UOLJ/eGOgTNe8V/KuDoqFgwUwkupdypBsfbvcfZ7kxuc8iQZg+Ajvhid97Xtx6MiLacminU7aw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=seco.com;
Received: from DB7PR03MB4972.eurprd03.prod.outlook.com (2603:10a6:10:7d::22)
 by DB8PR03MB6315.eurprd03.prod.outlook.com (2603:10a6:10:136::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.10; Thu, 1 Sep
 2022 15:25:46 +0000
Received: from DB7PR03MB4972.eurprd03.prod.outlook.com
 ([fe80::ecaa:a5a9:f0d5:27a2]) by DB7PR03MB4972.eurprd03.prod.outlook.com
 ([fe80::ecaa:a5a9:f0d5:27a2%4]) with mapi id 15.20.5566.019; Thu, 1 Sep 2022
 15:25:46 +0000
Subject: Re: retire_capture_urb: Corrected urb data len
To:     Takashi Iwai <tiwai@suse.de>
Cc:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        alsa-devel@alsa-project.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <68a97d61-21bf-b45e-f6ed-c0906dd4b197@seco.com>
 <87ilmfj72j.wl-tiwai@suse.de> <9d41eda1-1172-ea60-dd87-b3e38a529170@seco.com>
 <87r110iz8w.wl-tiwai@suse.de>
From:   Sean Anderson <sean.anderson@seco.com>
Message-ID: <53306c0f-e5ef-44ee-b90c-a3ea61ca454c@seco.com>
Date:   Thu, 1 Sep 2022 11:25:41 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <87r110iz8w.wl-tiwai@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BL1PR13CA0445.namprd13.prod.outlook.com
 (2603:10b6:208:2c3::30) To DB7PR03MB4972.eurprd03.prod.outlook.com
 (2603:10a6:10:7d::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ca630bae-59ad-4644-1bae-08da8c2e3dc0
X-MS-TrafficTypeDiagnostic: DB8PR03MB6315:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vz5p95hCD1FFj644Nhrh0anJHxpVIl3oKFNmFx9oaFMQ5/O9GANjUWM0MZWSVxd8i7yoDnODO6MwqdYRewrHTDdZfAsdHO6MdWcQxnQPFSkUAOXo4Xms70pzSHWHOs1axCVZMWcl1qV3PknK4WwRFrX/gzzQssxSkzqulNesiT46cLliRaDMt4tx13ymcpUy2bUGQqdgV+BoFL7t9j/dZrSb2XpLqDocJ45lxnRZtU/Sr6WvfE9+Np2WbCZu2d8cyugkVn0o6YLDiGrBYA/ti5tjSezv0D8Uctv2m7xAOWkOTBP/LgjhNadTh0LNrn/9hPRSZhTAO+7m9VF7IXiaj0ehkYyuy0ZQpKXv3SOYaDZVNr5KoSJBn+mKSZUWpP9YUR2tBkx+E+ILmNV6zHFb31wXj5tZUSxqLUEWrVA4fiYgYFWphGqUl/ri5ypaLi5bLFZ4EvUHGLxxF7xsHvLaS6ATeu10GsD0IwXaF805PVuRjmMS1UBwkQcjOgi3UVnZdetQEsDFSpyV3TC8HAQvEenBaXhFa9dc/HPAUP6dZi8ywwB2PFv99VD0PPk8qPeLYY4hkVeYaB/QtvIBcFbSdTQXEjj9GPup50+4dAXprsHe3jUQdTtLi2LE8U+iHFJnQr7U8O6NECTgxUg/ASvIPaCw119CV2Sbc2Ps2R0xpmft8QHZRPiyMGo1AM9jL5BRspbgmMEu18BrCY4rbJbjzhl9WypBqJyPo2gnnGbKWNPgG5wYwVXItIJxevqe2A/K9AXyp+xJdTEhA6GvWmSKoTPmW66iUybW+8QIK5e3KXhOz/WbcYLgzxv33CcL1E2iUxjKrCRi73coTbNodxKjFw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB7PR03MB4972.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(136003)(376002)(346002)(396003)(366004)(39850400004)(8936002)(44832011)(36756003)(38350700002)(38100700002)(6916009)(6666004)(478600001)(66476007)(66946007)(66556008)(6486002)(54906003)(41300700001)(5660300002)(31686004)(316002)(8676002)(4326008)(6506007)(2616005)(186003)(6512007)(26005)(2906002)(83380400001)(53546011)(52116002)(86362001)(31696002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VFo4eHNCME5FNTJlY0hZVHVGS1hkRkFPYjF3bGNEWTFPU0JMRTQrT1FGdEFC?=
 =?utf-8?B?bU15VEdvS1lIWXpEaktNS2Z4RWZJb3B1ME5aRE1Hc1JlclFHRnhHejdVVWlO?=
 =?utf-8?B?TGdEeGo0RkM2QjRUazlsRzVnOXNtaWUwS1gwSldRYSt3WVAzMEhQa2diSmFl?=
 =?utf-8?B?UXB1ME5VU2tnMThVdnF5U3FSbGFINVI1cWdrQ2ZrRXJFbWg4RkxMbDNsV1VH?=
 =?utf-8?B?WUd3Z0ZITnZWcU9DTlpRaUQ5cUJqd0pZcytMYWNhKzE2Ukk5TVdzUlZZUngv?=
 =?utf-8?B?UHpsc3VEdVI0amNCMnBjWUovZGdCVDEvd3JQb3hCb2d2eEFKdnd6YVl2dlNK?=
 =?utf-8?B?WFgxSkdFMWU2YWFyMDQzKys0YTZVcjNGTzFMNmw2STZBUDVBa1FZbkZkZXZv?=
 =?utf-8?B?SWF5M3JqUmVRUmV5VEV0VXFMV093SS93MWRaOHpnMklXLzdCNnJKVWNiaG9p?=
 =?utf-8?B?dnN5cTNaK2lCNkVCMldOSnFRdFRKZ2ZTQm83RTVKV0lLUzdTVkJNT0JkTEhn?=
 =?utf-8?B?QnIyUERGOXlhUmRSZUhNVWZuRGlwa1J5bzBNZVpwSVdTMEZXUGdxT3FpaHd2?=
 =?utf-8?B?eUJ5czlqazNLL1VOekdzUXc1NTNWTUVaSkpYQ3VqUzBLRDV3VXJXMEhGWk05?=
 =?utf-8?B?Z2NkeVZySWRSd0ora3lCd2VjQUtyMjlRK2txV29RSnZ0aW5NcVJqcTNlODc1?=
 =?utf-8?B?dDNGUkN0eE15cUYzWTFMdS9DUjdkVkUvYmp0NmFlSjBIdmtFeXdxS1hyT3Zi?=
 =?utf-8?B?R3RSUGtEUFJoS00xalI4SnZMNmMwNzRURkQrWjA5dmxjc2VaODc4d1ViU0xl?=
 =?utf-8?B?bkRmVTIwUzZxN0ZlM1puZ0M2ZThEbTgxZGtFRW1nOS9oRENSbWt6TCs0RE5N?=
 =?utf-8?B?MkYvVlJYWG02NzZTOW9TTTRXdXpYRXY4Q3VSWFMvYzZJeGRzdlNMR2R2K2hk?=
 =?utf-8?B?SnFzSElTeXo4SHVyZ0tqeUJ2MnJWWE5seEg0eCszeHFOMGdnTFhCOTlPQVJE?=
 =?utf-8?B?dFJzbjBBZTVsSzRIaXViRzZ6QWhUMUIzaVRnKzExdWw4ckg4VWZZbGJ1cWcz?=
 =?utf-8?B?NEM0OXBkZDlWa2J3b3hTYUthQit0RzAwajdhMjZPV0Vpc0Y5Mmh0d3Q2TmJQ?=
 =?utf-8?B?K09vTW53SHBuWGhQL1h1U2dBZ0tGVG9NVHVHcmtPVzRMTGpzYmpEQldtZnF0?=
 =?utf-8?B?ay9Ja3JxUnpTUHpNTE9hMW9vRWM4aGJxTG51ZkxWT0hvQm5FN3YvWU0zTDl6?=
 =?utf-8?B?cG1xTXJHOVQzdEovRWd3anNWSVRqdVRWM05xYXBub1lyMXZWRkF3dTZmUkl1?=
 =?utf-8?B?Wk5oNVhqckRoWk9SZU4vNHpyODBYMmxib2ppeGk5NWZSRXF1N1pKUHpGWmpB?=
 =?utf-8?B?cmdEOVZCNG9tb3RTdUpVWFczYWhKT1dZK3lhd1dNdFhXckRSTzR4SkNFUGFW?=
 =?utf-8?B?eDFkdHdQRU1HQkQ0cWtJTGtzRlNhYm02YTNYcTY3UlBQYVVKUk82YU1LYXhr?=
 =?utf-8?B?MEt6dTZhN0JGWVBXUUVyT1N5dEJ5RnQ3Q01Oek1ueG1kUG9JU0RocWpya0s2?=
 =?utf-8?B?eXJ2QW5DSUxQN0s2N2tVRS92OUhyM01DVldSZWpKdjlKK0wzUjUvYVJQWlFU?=
 =?utf-8?B?WmQyNFk4U2t5bkM0L05ObzQwNnUwTFluTHZUY1haemdpWmcrQlNMTFBlWjZ4?=
 =?utf-8?B?VWViMUJsaVpPTGhpMUNvL0t5UGpmS3JNbkdZMDJ1ZnYxSkxneXQ3bHlGeDUz?=
 =?utf-8?B?Qk9oTkpTZll5eXVyVExJanZJV3dvYVozamlQc0tqcy9JYVNjTDFkQ3hSakdI?=
 =?utf-8?B?b3hYaUJxVXVybkh1aVEwUXNmZ0t1OWhEUFNUZHdrVUJnWVhNcVZiWGNzM1Vy?=
 =?utf-8?B?YTFpNVdkZ2FYZHFDYzNEcXhvNVIwWFhkWDV4SWtsY3FyYjQzZUxHcmFpaFJ5?=
 =?utf-8?B?NWVPSlo2TzBvbGpKb3hKZ1hvK1lQYjhhZmp3SFB5MEdkRW42YnFBdG5zci9B?=
 =?utf-8?B?cEhYcjYwNElPZ0tSOEo0RUVSTDRwVXhEbk5PL2VPY0VNL3NJZ1EwOEhEY0hO?=
 =?utf-8?B?T0xjMFpiNGcrdXZhQTE5YUF5eU5VdytpUU95MnVGYld2S05QQm1pWUtkVWpk?=
 =?utf-8?B?dVFKT01MUFo2STB1YklGUjQ0Z29GaE1xYzNybGZEZTFNOElhaFBxK1lhY2xJ?=
 =?utf-8?B?NUE9PQ==?=
X-OriginatorOrg: seco.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ca630bae-59ad-4644-1bae-08da8c2e3dc0
X-MS-Exchange-CrossTenant-AuthSource: DB7PR03MB4972.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2022 15:25:46.1855
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bebe97c3-6438-442e-ade3-ff17aa50e733
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DuV7JB9QSZDFEc8TSL4ACBInT2oRw9RDE/nq8w7pq/xmPaPR/pO/np9iRO6IJ13EG65+5OVXkdzlLs15+IGy1g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR03MB6315
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/28/22 3:49 AM, Takashi Iwai wrote:
> On Fri, 26 Aug 2022 20:57:53 +0200,
> Sean Anderson wrote:
>> 
>> On 8/26/22 12:36 PM, Takashi Iwai wrote:
>> > On Fri, 26 Aug 2022 18:22:24 +0200,
>> > Sean Anderson wrote:
>> >> 
>> >> Hi all,
>> >> 
>> >> I have a "FiiO DigiHug USB Audio" sound card (1852:7022) [3]. I have had
>> >> no problems with the audio, but I did notice a large number of message
>> >> like 
>> >> 
>> >> retire_capture_urb: 4992 callbacks suppressed
>> >> 
>> >> in my dmesg [1]. This is caused by the "Corrected urb data len."
>> >> warning.
>> > 
>> > What exact values are shown there?
>> 
>> Unfortunately, as detailed below, I was unable to turn off ratelimiting.
>> 
>> > The problem is that your hardware
>> > (likely a buggy firmware) returns the unaligned size of bytes as the
>> > data.  Maybe it's worth to replace dev_warn_ratelimited() there with
>> > dev_warn() and take all warnings once.  Then we can see what kind of
>> > values are delivered from the hardware.
>> 
>> I'll have an attempt at that next week
>> 
>> >> The patch adding this warning [2] makes it seem like
>> >> this warning should be an uncommon occurance. However, based on the
>> >> number of suppressed callbacks, this seems to be happening at a rate of
>> >> around 500 Hz.
>> >> 
>> >> Is this buggy hardware? Or is this a bug in the driver? Does there need
>> >> to be a quirk? Or perhaps the warning above should be a debug instead?
>> > 
>> > There is no quirk for that.  As long as the device works with that
>> > workaround (except for messages), we can simply add a quirk to not
>> > warn but always apply the workaround silently for such devices.
>> 
>> OK. I wasn't sure what the correct resolution would be.
> 
> Actually I was wrong: the existing quirk QUIRK_FLAG_ALIGN_TRANSFER
> should cover that.
> 
> Could you try to pass quirk_flags=0x04 for the corresponding card slot
> (the option takes an array) to snd-usb-audio module?  Alternatively,
> try to pass quirk_alias=18557022:0e510408 to snd-usb-audio?

I tried both options, but neither worked.

--Sean
