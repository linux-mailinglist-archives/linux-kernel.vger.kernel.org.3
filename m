Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBB05568656
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jul 2022 13:04:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232377AbiGFLEw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jul 2022 07:04:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229531AbiGFLEu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 07:04:50 -0400
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2050.outbound.protection.outlook.com [40.107.104.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B68DD248F3;
        Wed,  6 Jul 2022 04:04:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SYt7VbiH8JBQe/pkhRGG35M6Ssq7F0XuIb6voUwnKCDctpD9/rpXkEC3WI7DdF3ldbjKKHCY3zoQ38qjoxESXHHFV65ZJl0go2HT4uUBQcH4PtjftzXjA4kTUHq47NRZP3wzg5Ct7AliO0eSYxX0COHymurMFpli4l9ZeVIODJcQ2tQ32bIEOP7SU0Lo2QfjzGJJpBSbT0ag+bS2cnBOBrUMZZhhy8tz6PIgVyMJ64oVlOvf1aZxxvP1EensIRWscwxjIg/iGHXrl0bZM43EOB5Zz9QPSK2kAGf2XinIjdfm3tgsnGm0qLWHp65DlFheOwwTyG8Us/taH304p62pcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LDeHh8w3A7xVNY6Jd+Dsu79dfJfEbDaRQxVSC5GXFXo=;
 b=EahLNsJnjU5vq9mHeeG0T7ItSKao3abHymowUPt5V5itKgK5ocxm4EK4EbawHPBR6h510jluuFCC55o6Q0ebDgLc41mMsrDcq+UU0rbw6lk4VpnKhagMpW1sf3W9LSONw00CPzv7B4Xm4GDE+CeD2/pEth7HixnYPrLD2dp+auErFb5HNRb8WUi4DfilE1qt1zGgmZFYUH4W+xtB2mNlDFVESzn2RAdWYsDftJKIoDSwUj/wUXjX0HUZm/XVNcbsswMoa2SCUTAxjIHyOU9sor4bObbmkruhKNr+u4QmmVv7JNiwxe9uS+64ZbRyrQJ+gKicf/2L59177A5jVZiWnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LDeHh8w3A7xVNY6Jd+Dsu79dfJfEbDaRQxVSC5GXFXo=;
 b=gVFwVumginRuiMnXhTH5DN0VDe0egb6rssvnxMeIT+h/lR3pZdEcHtft/Ta0O49r+bGgxqWvvtxVd0epVu27AraAPpHVH5GAQXkEr55RKl5ji61wTIPPnMPfvSP057gupNna2fiuhjGB1znsBIdVLxvyotAP9GXVPJlLQld5C4Idg9B8T9sCMtYOsYu114w/5NxAJwBRcAn0fx3oIcvCWXa+JEOFc9n5G3kQsu33zCN6Jc445Klyo39gNzhwB+4+nskDfGZxiXwd/isgY2fslvEqzFRTPRNmL49v79ibWN3lf11RHjxK1wSWpsksgQ3ilpggHjBmCdp3pU6Gr5EMjA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from VI1PR0401MB2526.eurprd04.prod.outlook.com
 (2603:10a6:800:58::16) by VE1PR04MB6462.eurprd04.prod.outlook.com
 (2603:10a6:803:11c::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.21; Wed, 6 Jul
 2022 11:04:46 +0000
Received: from VI1PR0401MB2526.eurprd04.prod.outlook.com
 ([fe80::21d5:a855:6e65:cf5d]) by VI1PR0401MB2526.eurprd04.prod.outlook.com
 ([fe80::21d5:a855:6e65:cf5d%12]) with mapi id 15.20.5395.021; Wed, 6 Jul 2022
 11:04:45 +0000
Message-ID: <815866b5-842e-4829-5ed8-26a5f1e856a4@suse.com>
Date:   Wed, 6 Jul 2022 13:04:43 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH] char: misc: make misc_open() and misc_register() killable
Content-Language: en-US
To:     Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        Greg KH <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
        Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org,
        Wedson Almeida Filho <wedsonaf@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Arjan van de Ven <arjan@linux.intel.com>
References: <YsKW6VvWqvcMRBSl@kroah.com>
 <100f445e-9fa8-4f37-76aa-8359f0008c59@I-love.SAKURA.ne.jp>
 <YsLIepAXeBKT0AF/@kroah.com>
 <01a93294-e323-b9ca-7e95-a33d4b89dc47@I-love.SAKURA.ne.jp>
 <YsL5pUuydMWJ9dSQ@kroah.com>
 <617f64e3-74c8-f98b-3430-bd476867e483@I-love.SAKURA.ne.jp>
 <5665ccb2-b92b-9e1f-8bb5-a950986450ec@I-love.SAKURA.ne.jp>
 <YsRHwy6+5gask+KT@kroah.com>
 <064bbe2a-c18e-203e-9e01-b32fe9baa390@I-love.SAKURA.ne.jp>
 <7ddb25ff-60e5-75be-8080-2a7465cca68c@I-love.SAKURA.ne.jp>
 <YsUtBERm94k/iZTy@kroah.com>
 <a6d98824-56c8-6d92-bb1b-eb065b57cb81@I-love.SAKURA.ne.jp>
From:   Oliver Neukum <oneukum@suse.com>
In-Reply-To: <a6d98824-56c8-6d92-bb1b-eb065b57cb81@I-love.SAKURA.ne.jp>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM6PR10CA0070.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:209:80::47) To VI1PR0401MB2526.eurprd04.prod.outlook.com
 (2603:10a6:800:58::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ed5f81c7-1bc3-442f-588c-08da5f3f5602
X-MS-TrafficTypeDiagnostic: VE1PR04MB6462:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: u5LWRboBoGnQZpV+t1mwQeSaLwODiSLVQr0S42fkRTQJ62e06nAkItT3Nzp3pm7mTERdFFQLKiXHpCI7AORwNIqdpFVMBLLr7WcBtRboMvgbFbZM40GluFBuauKfLobylMN9Kg8bG5UfTuLqFcw1XRVXvisOSeJ3pHCROQueTCWugcGrXNVTBYiSXC1NKu3L16ChUh3cqEVfwS1HwGrLiOjBSi0d9JoNoMGKhEeLirWioophogUJYrjR4DCbpWtPTBI6WO1/UT47xgmr6FkOXl8WEx0zsmy3UNfoQDT27bUJmo/t8TPhBxa2mrKV+BavbW4ih+MNlQ53cUW+rofM1BBT0KYNA0LqtrJ4bcXS+f3HOtfORrNX0ldOxaPiyNQgvq7HYUeeTAbFdTuMVAs7AszG5yU8r40uJWGGQ2J510B/7RwaW4fH4t8IByLqqCCnZe4luJFG20NpIKiM3V0dlv/qjr+rS6qDGWuk8IVUPoyLeRHuisYpTSSP006YD2tqh67KsFHdZ69lTPooayfdJ5BKMDcSA2lm6ub+ALDHR+4QJtUnx71mNWhTvMOkc4nGFAbeAkDRkedoa0fFNS7VhDnVRu6HV3oiX6fKkeyOZa9SF7DP04pLhEouqiSupA8VEJ1Udvg/4d4auK58XsPaUa3UEsROVzlPK/NND3+MiabXKNeGXISBCdM7OqMyFHH+V92Aoa1TfYODdmpAoGqUaxlcPmVcqaU28pa5c1rTVa44g4zlYAT0PVYTlhFXZEonsyNkH8PMMQfhjuRJA1fCa00t8RLHxZo8wGZURButuucLRuW8gRp8Yp41bzXKXKl0ojdsHhJ5k9wdWuUyo6wpXg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR0401MB2526.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(346002)(39860400002)(136003)(396003)(366004)(376002)(186003)(7416002)(6506007)(83380400001)(41300700001)(2906002)(54906003)(110136005)(53546011)(316002)(36756003)(31686004)(38100700002)(6486002)(8936002)(31696002)(5660300002)(86362001)(2616005)(66556008)(478600001)(66946007)(6512007)(4326008)(8676002)(66476007)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?b0VsYkp0clBpVDA2VEkwdFFZVWlqVTJjUVVpYjBVRjBvYVFLQ3hoMWd3Skxu?=
 =?utf-8?B?OGl2YktHZ1JSaUY4R2E1K1FWM0EwQzh4eEJVMmZPTlhHYkdGU1ZFUlBoSzVa?=
 =?utf-8?B?T1NQdGNGN0ZVQUpCWFZxTjFOcFlHdVBJK3pRZy9VSDg3enpzUGdtRjViVU9k?=
 =?utf-8?B?WUxtRnRKdVI2NkpjNEIwdmdPY0F0OEpWalZvSXF4eitTR0NoV2pqNnBabnV4?=
 =?utf-8?B?Q1RkVVI4M0lhcWFqbzhiZUpwMmh1MTF4aHJadjJrTFMzZmU3Q2s2QUZjNk5j?=
 =?utf-8?B?KzNNOHZEQU01NkdpRXczWW9BOGZHTUw1Z0F2R3ZtZHVmdk82dkppMThxT2w3?=
 =?utf-8?B?d1preGl1YWVLSW9SWGhiendUTGp4R0RSWGNuMU9mcEhMelEwRUZkaW1mZENG?=
 =?utf-8?B?Q2o4TUdUOEgreS9uZmd3bG94T2Uwbi8zQktRZWs3V1JDR3h3c3d0Z0pIU3gx?=
 =?utf-8?B?QmgybHpHazRrVWlENzk3amk3RXp3VTczdFUyazVMeWlFWHJ2SnhJSU00U0Vk?=
 =?utf-8?B?VDFxWDkvcDNaUVZDOXBjLzh5cENKZ3pXdSs1czdLQ200TWd0QVYyMnFNUHc3?=
 =?utf-8?B?ekk4RldvTDJHOTZFTUpya3IzelVOdXlmVkZnZFBzNzU0cmx2WVVjb3ZtYmtB?=
 =?utf-8?B?V1pZYksvcHl2ZXlXMWpzY00xbTN0UjdrV1BiOGI4QXZxS20xYzI4d0FXb0Ju?=
 =?utf-8?B?aklGeVhWYjAvOGhHY2lLMGNPY0FrUTNSY1FtSG9OKzFRM0YvSWN0aUNDN0Ju?=
 =?utf-8?B?VXpyekVwcjFuZ09qMnJ3RHl4TnNIQVFRNmsvYmhVc1ZPTXFlZEZ2M3R4N1lN?=
 =?utf-8?B?bTh6Y1NHWHAxOUdReXlqZjFaeTNJWFNZNjFYb0FQVDRIY2hGT0tHNC9sdGd4?=
 =?utf-8?B?YTRBaFE2OXNVMDM2N1NjdVJONHNhTEVKRHdoTCtWc2FaaXZXMlBMejdiWDdM?=
 =?utf-8?B?WUsxNEIwYVYwZHNYalI4cXUyUzhtMFVhTldZQ3Zna0tnc2RXS0FEYnh6aWZz?=
 =?utf-8?B?UnJwT3U3RDh0K28xODlxQi9FY1VZWGxHQUdGUzZnWmRJRm5FYUlzQTZ5SHMx?=
 =?utf-8?B?ZGh1dzJwcjhqNUNvSW9ncS9CTHdBK3JYRTRJeVNPNFkwcmpGOWp0cnFFeDRV?=
 =?utf-8?B?bXdpRmt6bE9RZERLcXpDd1BsU1Y2RUIwbHgwNFBnWW5XT2hXZkI2UHNSb3lj?=
 =?utf-8?B?WnYwQmlWa0lZejA3QXZldFkwR0kxRVZhM0lHK1hJQWlrMHlPeEphR015eU9E?=
 =?utf-8?B?N1lOaXZCbnVEMmhFbmxjcitBOWEzeEdUYVpObm1qYml6RUJla3FEREIzejRa?=
 =?utf-8?B?RWQrZGpaMVVaZUJCQ1I3dmNESTZxd2REV1BTMVE4VnhvZCtzOUI0NjVoZHlq?=
 =?utf-8?B?ejc5ZnU2emRSQjI4RFB6VTNPbDhhNkhPTmNjWGpCUVBnSm5MOUVXK2J4MFUy?=
 =?utf-8?B?b3MyZWVhR1RFSmpWL0xoK0tmVzIxOFdHUzJiQUs2cFBxaFNoRHBocHNsalRC?=
 =?utf-8?B?aVZnVU1BcmdZZE5PckdsTENON2wzcU9VMjJ0S1FHUHhCeGtLS3JYM1NpaGpT?=
 =?utf-8?B?MnBzanNnbDhFYjFwR1laeldSUmMwMGNPRjhycmt5Z2g5WjNCbEttM3l3aDZk?=
 =?utf-8?B?a29TdEdsQlBRT0pRNS83N2tBb0V4azFMSzU5b2JWOW5peHUycFR4YkFoK1BW?=
 =?utf-8?B?VmxBL1RaZHJxdWtKTWZjSjVYNERpbWlXZkIxcVhxaVpPT29rcDBiNEp5U3cw?=
 =?utf-8?B?Sm9kRnRybi9aOW5HbGtRbUhhZThUeFZzYk5GeURqcmIwbjBBM3NSVlRqVi9W?=
 =?utf-8?B?dE9oTTF3RGtEZHZ5SUlVU1NhMklhZ05GOG10dEh1ZXRrcXNzemVXZ3FNcmh2?=
 =?utf-8?B?Ymd1YW1vakN5a21CTmpFUWJ5MlFrbDJ1bWwzZUJjQzR5RjhuRWpzZDE0dVlT?=
 =?utf-8?B?ZFgxNXVJTUQ5NkhqWXVvN2M0L0tCOHo0V1hNZnUzV0h2NFl4UlJRM2MrMjVm?=
 =?utf-8?B?WEVhZHpMTFVycTVINy8zY20xcVhoc3d4Um9BejIyczNCdkhtMWszTlBEV01F?=
 =?utf-8?B?anppRTZQMkRxNVpYaDFIVTJaWlZsV08xNXRlWlRSYXQvdTc4RlNZaFZxb0th?=
 =?utf-8?B?OE1xMXFkRWJUSUVySzV5Z0FPbFpLaWxoa2tvTm5Ua1ZiY0xGQ2E4K0toY1NN?=
 =?utf-8?Q?5T4xG6jOiA8LHTeiv/gOFTo4ApsvB+C17+2k0aHBX7Y0?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ed5f81c7-1bc3-442f-588c-08da5f3f5602
X-MS-Exchange-CrossTenant-AuthSource: VI1PR0401MB2526.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jul 2022 11:04:45.8794
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xHg9w8KViPIRk/jjtvPAm5BNy826HRiA7uGCmfEN/6xQF/2BG6XxxzGJynHXj3vEdGraIJseQDzGPX7cfgdKHg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB6462
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 06.07.22 12:26, Tetsuo Handa wrote:
> On 2022/07/06 15:34, Greg KH wrote:
>> On Wed, Jul 06, 2022 at 03:21:15PM +0900, Tetsuo Handa wrote:
>>> How should we fix this problem?
>>
>> We can decrease the timeout in usb_stor_msg_common().  I imagine that if
>> that timeout is ever hit in this sequence, then all will recover, right?

Not really. The timeout there is supposed to come from the SCSI layer
in the general case.

>> Try decreasing it to a sane number and see what happens.
> 
> Yes, all recovers with below diff.
> 
> ------------------------------------------------------------
> diff --git a/drivers/usb/storage/transport.c b/drivers/usb/storage/transport.c
> index 1928b3918242..d2a192306e0c 100644
> --- a/drivers/usb/storage/transport.c
> +++ b/drivers/usb/storage/transport.c
> @@ -164,7 +164,7 @@ static int usb_stor_msg_common(struct us_data *us, int timeout)
>   
>  	/* wait for the completion of the URB */
>  	timeleft = wait_for_completion_interruptible_timeout(
> -			&urb_done, timeout ? : MAX_SCHEDULE_TIMEOUT);
> +			&urb_done, timeout ? : 5 * HZ);
>   
>  	clear_bit(US_FLIDX_URB_ACTIVE, &us->dflags);
>  
> ------------------------------------------------------------
> 
> But
> 
>>> Anyway,
>>>
>>>         /*
>>>          * Resuming.  We may need to wait for the image device to
>>>          * appear.
>>>          */
>>>         wait_for_device_probe();
>>>
>>> in snapshot_open() will sleep forever if some device became unresponsive.
>>>
> 
> wait_for_device_probe() in snapshot_open() was added by commit c751085943362143
> ("PM/Hibernate: Wait for SCSI devices scan to complete during resume"), and
> that commit did not take into account possibility of unresponsive hardware.
> 
>    "In addition, if the resume from hibernation is userland-driven, it's
>     better to wait for all device probes in the kernel to complete before
>     attempting to open the resume device."
> 
> It is trivial to make e.g. atomic_read(&probe_count) == 10, which means that
> acceptable timeout for usb_stor_msg_common() may be no longer acceptable timeout
> for wait_for_device_probe(). Unlike flush_workqueue(), wait_for_device_probe()
> can wait forever if new probe requests keep coming in while waiting for existing
> probe requests to complete. Therefore, I think we should introduce timeout on
> wait_for_device_probe() side as well.
> 
> I would like to propose below changes in 3 patches as fixes for this problem.
> Since there are 13 wait_for_device_probe() callers, maybe we want both killable
> and uninterruptible versions and pass timeout as an argument...
> 
> ------------------------------------------------------------
>  drivers/base/dd.c               |    3 ++-
>  drivers/char/misc.c             |    9 ++++++---
>  drivers/usb/storage/transport.c |    2 +-
>  3 files changed, 9 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/base/dd.c b/drivers/base/dd.c
> index 3fc3b5940bb3..67e08b381ee2 100644
> --- a/drivers/base/dd.c
> +++ b/drivers/base/dd.c
> @@ -723,7 +723,8 @@ void wait_for_device_probe(void)
>  	flush_work(&deferred_probe_work);
>  
>  	/* wait for the known devices to complete their probing */
> -	wait_event(probe_waitqueue, atomic_read(&probe_count) == 0);
> +	wait_event_killable_timeout(probe_waitqueue,
> +				    atomic_read(&probe_count) == 0, 60 * HZ);

You cannot just let a timeout go unreported.

>  	async_synchronize_full();
>  }
>  EXPORT_SYMBOL_GPL(wait_for_device_probe);
> diff --git a/drivers/char/misc.c b/drivers/char/misc.c
> index ca5141ed5ef3..6430c534a1cb 100644
> --- a/drivers/char/misc.c
> +++ b/drivers/char/misc.c
> @@ -104,7 +104,8 @@ static int misc_open(struct inode *inode, struct file *file)
>  	int err = -ENODEV;
>  	const struct file_operations *new_fops = NULL;
>  
> -	mutex_lock(&misc_mtx);
> +	if (mutex_lock_killable(&misc_mtx))
> +		return -EINTR;
>  
>  	list_for_each_entry(c, &misc_list, list) {
>  		if (c->minor == minor) {
> @@ -116,7 +117,8 @@ static int misc_open(struct inode *inode, struct file *file)
>  	if (!new_fops) {
>  		mutex_unlock(&misc_mtx);
>  		request_module("char-major-%d-%d", MISC_MAJOR, minor);
> -		mutex_lock(&misc_mtx);
> +		if (mutex_lock_killable(&misc_mtx))
> +			return -EINTR;
>  
>  		list_for_each_entry(c, &misc_list, list) {
>  			if (c->minor == minor) {
> @@ -178,7 +180,8 @@ int misc_register(struct miscdevice *misc)
>  
>  	INIT_LIST_HEAD(&misc->list);
>  
> -	mutex_lock(&misc_mtx);
> +	if (mutex_lock_killable(&misc_mtx))
> +		return -EINTR;

This usually runs in the context of a kernel thread, does it not?
What could kill that?

>  
>  	if (is_dynamic) {
>  		int i = find_first_zero_bit(misc_minors, DYNAMIC_MINORS);
> diff --git a/drivers/usb/storage/transport.c b/drivers/usb/storage/transport.c
> index 1928b3918242..d2a192306e0c 100644
> --- a/drivers/usb/storage/transport.c
> +++ b/drivers/usb/storage/transport.c
> @@ -164,7 +164,7 @@ static int usb_stor_msg_common(struct us_data *us, int timeout)
>   
>  	/* wait for the completion of the URB */
>  	timeleft = wait_for_completion_interruptible_timeout(
> -			&urb_done, timeout ? : MAX_SCHEDULE_TIMEOUT);
> +			&urb_done, timeout ? : 60 * HZ);

No, I am sorry, but there are SCSI commands that can run for more than
60 seconds. Formats, rewinding tapes, ...It seems to me you need to look
at the SCSI scanning code.

	Regards
		Oliver

