Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 376554B8422
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Feb 2022 10:26:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232042AbiBPJTw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Feb 2022 04:19:52 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:37408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231768AbiBPJTu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Feb 2022 04:19:50 -0500
X-Greylist: delayed 435 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 16 Feb 2022 01:19:35 PST
Received: from refb02.tmes.trendmicro.eu (refb02.tmes.trendmicro.eu [18.185.115.61])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3E7F228C88
        for <linux-kernel@vger.kernel.org>; Wed, 16 Feb 2022 01:19:35 -0800 (PST)
Received: from 104.47.18.105_.trendmicro.com (unknown [172.21.19.198])
        by refb02.tmes.trendmicro.eu (Postfix) with ESMTPS id 67483100816B9
        for <linux-kernel@vger.kernel.org>; Wed, 16 Feb 2022 09:12:20 +0000 (UTC)
Received: from 104.47.18.105_.trendmicro.com (unknown [172.21.175.6])
        by repost01.tmes.trendmicro.eu (Postfix) with SMTP id 63A1B100018F9;
        Wed, 16 Feb 2022 09:12:18 +0000 (UTC)
X-TM-MAIL-RECEIVED-TIME: 1645002737.667000
X-TM-MAIL-UUID: 7dab05f6-a733-4e49-aed1-23ce011c0cff
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (unknown [104.47.18.105])
        by repre01.tmes.trendmicro.eu (Trend Micro Email Security) with ESMTPS id A315010000407;
        Wed, 16 Feb 2022 09:12:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ro96Q90qSagR4/PYmtWjQt2xxEjitzeQvfWvixnqJ4FqiO8HYfic5njMMZ0H0OMIdfMxktGt83VYA2XraXZw8JtiVXizmV3AIclZ7OHBpIsx0QBFxVhGJoBDqpJPGF0eC8yOjtxUOOFdzaJkllXL3sAn+Ch9AhFjAdS/p0h6FzzvoV8Tt0XkPRV1T4mrGZAEMYJ3NBKrHbUUhptaK/oEwpKzYCbs8M4M/V5kcAQVQdPGuhB4dIY7Klk6lCcEISuSRp0foSW7pwANqMXNuFoytRDQ74D/eUcaXPP18kHp97/L00O5+1oFJMY42Lrsb+PnyXWN4COkcfFWmO1xyagr5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ouf+9zHIB50sxj5vL0cFDI2H93oSy/XTmOlmFPf8d9E=;
 b=d5Bp3fiheaqTBu58R6diTByWeYLKAjwVv8kq1rjnTWrvLq0QUceCwEr8oaEV8k63kgevU9hTb4ezs61fPGeE913RRrXsI0QuTrKahlLM9xycJ+nZvG7S7zLiXX7yjaaDG7/Y+8pnlIygw9eFOlMKhRqykwOgnlKsfHvBCQmO11hc3gXRHTQPSnIDKe5e8XwwkIugxNBo/7kbT1dfhMmcj9Ib8u3Cd0PXgCFbW+h/dvC41WCZaOiFvQX6IDj9/09USCT0GqtWHEktVaOhTSObykGOA1hcLbOzY0PFwyvgLNJPY5bFMQYXQB1RYeMAX00G6JU3CAoX5yQFdwFvub3QMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=opensynergy.com;
Message-ID: <6c3920d9-798b-2a5a-46d1-011152002251@opensynergy.com>
Date:   Wed, 16 Feb 2022 10:12:10 +0100
From:   Peter Hilber <peter.hilber@opensynergy.com>
To:     Cristian Marussi <cristian.marussi@arm.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     sudeep.holla@arm.com, james.quinlan@broadcom.com,
        Jonathan.Cameron@Huawei.com, f.fainelli@gmail.com,
        etienne.carriere@linaro.org, vincent.guittot@linaro.org,
        souvik.chakravarty@arm.com, igor.skalkin@opensynergy.com,
        "Michael S. Tsirkin" <mst@redhat.com>,
        virtualization@lists.linux-foundation.org
References: <20220213195832.27932-1-cristian.marussi@arm.com>
 <20220213195832.27932-4-cristian.marussi@arm.com>
Content-Language: en-US
Subject: Re: [PATCH v4 3/8] firmware: arm_scmi: Add atomic mode support to
 virtio transport
In-Reply-To: <20220213195832.27932-4-cristian.marussi@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM6P191CA0004.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:209:8b::17) To AM9PR04MB8084.eurprd04.prod.outlook.com
 (2603:10a6:20b:3ec::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 630b1c34-1886-4a61-f5cf-08d9f12c6c6c
X-MS-TrafficTypeDiagnostic: DB6PR0402MB2936:EE_
X-Microsoft-Antispam-PRVS: <DB6PR0402MB2936DE92D53E5F6ABC089E0A8C359@DB6PR0402MB2936.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tNFPErLogYUaWIz3l4tZCpFTPR4d9QVzze0CKXZDr+i+CI1JnmO5lwmBW2Pwf8aQr4vIXd/4FGcyarnqW9jxqMXjEo8bp4SFFj5gPF7PY5oJ83mbIqWjOqPheswZKPAfPb2SHAcYzXPv5tti1Fr/MGs1EMfnSV3tSyXlHb+rT+Uw6YxClc4VveEKGIfe5kzIN7vCf25hMJ4EX4eHWfhX7LNJvEYk7952UYh9Z7YrTDAsWTQWDBGHViZPsAfa9HdnIgW8dc+oz5ALB8Y+Ka8xiruc4KTHz5F0ohbKsdIMxRAUpQsUyv81JPpMGCfsZJD+AZpPwyk918kBKwmZ7YYq1NdeREKQkjeBNSH707ddgNexIjW1DEeYkLsdiq+0Fa3E8oOq2j4divUUtmAKmD/tMMwVUqzTxKQj3ZHhvJ2VrNXSjJF66g2X2A6cQ/yym7ZRPJM2h430i6/LmnmGyA2yCATuCXJyeRL7qNgI4OJS6/UEr+axeRQf9tI3TRC/1Vc5RKGz6mn02vnz2WsGDXSuhKWvxOZX9J1tYRqN7g8w7fyDl5HueSISpfl56XAemuziCK4OaPxmqzxgC2GUYb1kaKMW63Cte9wTBaDpwer2W/piBIQ9MkxkFRthJK7GqTwQlrCQGJg5UDxtmamH+kKRJw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8084.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(5660300002)(42186006)(66476007)(316002)(66556008)(53546011)(86362001)(4326008)(8676002)(66946007)(83380400001)(36756003)(31696002)(38100700002)(31686004)(44832011)(2616005)(2906002)(8936002)(186003)(508600001)(30864003)(7416002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SVptZlBuVjNlRE4yaVFVd0Nkb3NlajZZSEdkb1ArWFYxdWpTNHRYbHN4Mzll?=
 =?utf-8?B?dWIrQ29DYllubldoNk1jZk1tcitUMEZYYW0xYmlabnE3RW9TK3lVcW5veUJN?=
 =?utf-8?B?SGRscUZvWVh0ZkttNWE5UmxVOEFQd1VoUlRMdWRKQWh4Q1pTaVhxdUtJRDda?=
 =?utf-8?B?L0xXZ29oOFFBWFh4RVZaZ3kvdzFRWTV0bEMzOEltRWk1TG9sZHNxZzFxVDg2?=
 =?utf-8?B?S2VjQ1prUmEzbS9XeUVyaVorWU5GV3RGdUNHaFhrSm9XWUFibytFQWFLc2FO?=
 =?utf-8?B?aUswL3Nub3E2ZVl1NlB5R1V6V1oxblhWUXQ3cWdBRUEwQllZa1o5dzIyT3ls?=
 =?utf-8?B?UlN6R1Bsc3pvaVdDUitwMmZVU3pyRWppc3JUNXovenl5WC9lVlo4YlVXTmRr?=
 =?utf-8?B?ZFQ1K1F2NXVWOWczVExvK0xlOGZBM1VZblMwWlErN0RXdDVhRlVmc2NDZTZx?=
 =?utf-8?B?a3JycHNEbzV0amw1U2lqNmx4NWpjZ0ZLYnF3VWtWbVprVGM0bmZpN3diZzlK?=
 =?utf-8?B?c3AzekZjKzBCS1dnT2lWVnAzRUVKSkRMNUlzUEl3clNsNTdIZDRLTTViMzZu?=
 =?utf-8?B?UHZyUG43L1N0UUZGUHlzb2tSbnVSeXArMDRNbDZ1RkpjZVVJVVRhTk9qaWx2?=
 =?utf-8?B?SEIwZlExb2NRdU4vbVFsT2o0UG02bUdTZU9RQjNOVWlzQkpRZ3EzOFQ1bitJ?=
 =?utf-8?B?Yi85Y3NnTWFDcHlmVDZyT2xUbTVrNWoxeWIrRGN1S1g1NmlSUnVOdW4xWmRK?=
 =?utf-8?B?Y2dqQmJqS3IvTk9VMmp2SHNxR3lDUDhiWXlXcEsydDIyTUNFVkY4ckpRdEtN?=
 =?utf-8?B?QjQ3YnVZUXBGczdDSzc1T3NWVW52a0ZOdHROOGgvTWtZc3Z6eVhDV0Y5cGg2?=
 =?utf-8?B?NjliUG14Sks5QXdwNFB4RDgyUFRqNzEvWlpLT3E2R0ZHVFFld3EweEVkekxo?=
 =?utf-8?B?Z2Y1VHJEdzVMVTllcCtaNzdUREhTbW94Nmh2Z2Rodm5DWnQzWFZWQURoY0tH?=
 =?utf-8?B?MXFFYythWHR4SWI4T0NJVmNGaENkcmZyNTNOWURiR0lHMUxmRVpVTjZKUXpS?=
 =?utf-8?B?dm8rSjRNK2FzQkREMVBPaHlTekFIUXExUm5PTFJ5aHBWdWNjdHpjNVRBeEp5?=
 =?utf-8?B?eDE5Z2hXaTBHSHpQb0JsU1JNdjVZME9pbWpZZXlpTEhndDUzTEViaHJUeEFG?=
 =?utf-8?B?VGcyTktpekd5ZEtMQmsxK241ay9aTC96MXdESnNwUTdTaDRWaTNQa0FxOWp3?=
 =?utf-8?B?VlQ0MjRWMlhRRlJIaWxVOVF6RlQ3UHl0c3NIQk9OVHlRWEtlalpZSGFwUnhz?=
 =?utf-8?B?ZVdLeGRHeHN4bWNDd0MrdEZiTU1ocmt6OWhocHRyTUgxTEQ5dFZUYVRtOFl3?=
 =?utf-8?B?LzcwcWJUL1RwQ0lzUjU3bVRPOHFMZzlibEV3R0hweFA0QkpibVkrMjFSdGYx?=
 =?utf-8?B?czZkNjd1MUFON2tVOWxWSTM0WVM1dGhMdllqcy85bWxkbGZkOGt0VGhMOWRn?=
 =?utf-8?B?NkN2aENlbTJ6U3NaM2JWT2VwUXNybkNsY1h0UFpwaUtoMmNVSThwSVRqc1RH?=
 =?utf-8?B?Tjd3d3QzbEJhTmZUVmNaMU9VSHpoZXd0WWM2NmlmekpZREppbDVpU0tVbEUv?=
 =?utf-8?B?NXVzZ3JnRUtzZ25tRlAyT0trUWtUd3hRYjdOcm5mSGZyMWhvMXFwSGVIelI5?=
 =?utf-8?B?SHFHRVVlWGVvb29GZXVYelNIVUtId24zQXdJbW1CS3NPZkdzeStoSHhEaWM1?=
 =?utf-8?B?bEI0UWdja29MTmIyVmVBWnlFZDRGbHJFVnFMc05wSjJDd2plS2dNSmJuVHZu?=
 =?utf-8?B?YVJqSGczYzNWbzIrMTU3UitkNDR2TGRTWHp2bDZEM0gwUm1vdmk3Y01OdjBX?=
 =?utf-8?B?a3F5clpmTWhkRTVEZGszcHBJcFpRdGVXWndyQXZ0WGtoVVZNVk5VNHM3ZGk0?=
 =?utf-8?B?QmQ4UEZxa1VLUjRrNFljWnV1aVRqT0Y2SDRvd1JMRmlEY1VPMXNaWGdxSFc3?=
 =?utf-8?B?eXk2THVEaHJxWm4xYUl1c0NLM3dBZlY4SUtDL2tZUGhtSWU4b0lRc0FUVEVK?=
 =?utf-8?B?TlJjL2xVaUl5QWplZ2hTd1YrZnlsOGJhNWVnRWxiMHJEdUt0cGtvTFJKcVZE?=
 =?utf-8?B?MjMyUDZYc2w2NjJrMGgrV2VYUUh6VHlQYzBHNWRWekJBTkNXZmRldU9lTjJl?=
 =?utf-8?B?NnFSaHNrTVBlYjcwQWE0eWU4NHFpMnFzaE5UcjZaRWUwdldzT0NQbS92cmd5?=
 =?utf-8?Q?XUVKUyH9CqMZ41q1pWb28G2CiWkLCGClQF9zmDc6ak=3D?=
X-OriginatorOrg: opensynergy.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 630b1c34-1886-4a61-f5cf-08d9f12c6c6c
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8084.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Feb 2022 09:12:15.2685
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 800fae25-9b1b-4edc-993d-c939c4e84a64
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ve+umHt2keZRS88wXxMsvvTIlFPbOKsx+9+02RiaZheOF+/Me+Uq0PRWkFFRCxmFPABtd1+Ge53gU+Bms3gGbQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0402MB2936
X-TM-AS-ERS: 104.47.18.105-0.0.0.0
X-TMASE-Version: StarCloud-1.3-8.8.1001-26718.006
X-TMASE-Result: 10--26.810800-4.000000
X-TMASE-MatchedRID: IeZYkn8zfFr/9O/B1c/Qy65i3jK3KDOoC/ExpXrHizzozDhGeQC9Ei1s
        QGcqD7UtTxtConjUegf08edkgvdYLIIokrTYtYlKuLt50vtxBA4RMzHw4jihuQzvg1/q1MH2F6O
        OkTiGnXsl14a7266m34kGHsog1/afNtywwIf5ksUdZEkR8Y/meUXmpVQIaHBPuqWf6Nh7tmFyYy
        YBymq600lEFjVj/aAsP0y1Pz0bU7lxTrZJ5tXplP7FEhWgo0y8tOtXYgbXjddCbDVw9++PqaHqk
        E8v+LvquqcfFYLigUk+ta/415QhvuvsZywOYvoWVnzlQiaE21oJlr1xKkE5ucC5DTEMxpeQfiq1
        gj2xET8qqtDuUtwyfMXsLs82j9m1kkkoO5MnH8sB6/aPodnUlv2rswKZpHnRJwONCfZCxNr4e/Z
        QnTz3TvFf8BZZau/zFgTymD6TsUX1dbp49A+Bwguw+MVcHJpKFlIP4ZuPPchHpEd1UrzmFfIr4I
        Zl1TqPvqvtzy85XwfFegnzY30iYLgmXJUrLAZXBDoR8w7C9OakLKKtVfPgyqBp/T5dSs2T4VbSI
        3XTpLw5DMj/FS1NXHsvh3HjP7RA6biOAxfBSkaAO0kpgKezRDRgv1Ik+59fSMg2Oe/b8EyqL3xF
        H9EqVX+eBHl01dQsCnp+pjL19ZrIW5a7efE77RmCYUYerLHrndls9F9zmi0cCkgotCl7hC2ICLw
        E7H6XrU9Cd6sBqbpCHX9yHrVBsW6aIrCFAYY9C8FMH3T6F77DvsJEJ3LgvHGYPIreWK3dD2VMA3
        hbGfGNMoTLhhOqpAHk/roBXG21k6AYSaDLmp9+yskgwrfsC30tCKdnhB58vqq8s2MNhPCy5/tFZ
        u9S3Ku6xVHLhqfxvECLuM+h4RB+3BndfXUhXQ==
X-TMASE-XGENCLOUD: ee6eeed0-65d8-4fb3-8af5-c55253e5b8f1-0-0-200-0
X-TM-Deliver-Signature: FD93331BA250134235F02C31438D93C4
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=opensynergy.com;
        s=TM-DKIM-20210503141657; t=1645002738;
        bh=CzocQM7dbDuXck41N9wGZvV/u4b+Uo1dJRCKOgGbyH0=; l=20118;
        h=Date:From:To;
        b=itwKJuCD9BUq5M1lPPFPHXpeWQKr884V/UhroqcpJ1c/0Hk8UnPxXIOE2tM+F20kX
         8HnKUSgnsECsIg/Y7+f5W0MhJppCXIa0N3y8vTv603wEf38UieflupOi+tCTJCuocz
         IhFnX+7QwhZUX14FOmPZZUtNT94EDox9LZHfDf9ZmX1N/jF3sSdhKhJP0L0n7uAziN
         Zr9emHobcP/Mtqnh2Co213/Bg7gfelwFTn1grz0ISWp20uA2DivzxZDJ21f3YDsvWV
         qUxxlcTCo69PadJHERxXdhyGM4q6V0STVRXTGaL1a2x253hOiMwVilEHAEWBlbpqlq
         rNAR6zllEqW+Q==
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13.02.22 20:58, Cristian Marussi wrote:
> Add support for .mark_txdone and .poll_done transport operations to SCMI
> VirtIO transport as pre-requisites to enable atomic operations.
> 
> Add a Kernel configuration option to enable SCMI VirtIO transport polling
> and atomic mode for selected SCMI transactions while leaving it default
> disabled.
> 

Hi Cristian,

please find some minor remarks below.

Best regards,

Peter

> Cc: "Michael S. Tsirkin" <mst@redhat.com>
> Cc: Igor Skalkin <igor.skalkin@opensynergy.com>
> Cc: Peter Hilber <peter.hilber@opensynergy.com>
> Cc: virtualization@lists.linux-foundation.org
> Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
> ---
> v1 --> v2
> - shrinked spinlocked section within virtio_poll_done to exclude
>   virtqueue_poll
> - removed poll_lock
> - use vio channel refcount acquire/release logic when polling
> - using new free_list accessors
> - added new dedicated pending_lock to access pending_cmds_list
> - fixed a few comments
> 
> v0 --> v1
> - check for deferred_wq existence before queueing work to avoid
>   race at driver removal time
> - changed mark_txdone decision-logic about message release
> - fixed race while checking for msg polled from another thread
> - using dedicated poll_status instead of poll_idx upper bits
> - pick initial poll_idx earlier inside send_message to avoid missing
>   early replies
> - removed F_NOTIFY mention in comment
> - clearing xfer->priv on the IRQ tx path once message has been fetched
> - added some store barriers
> - updated some comments
> ---
>  drivers/firmware/arm_scmi/Kconfig  |  15 ++
>  drivers/firmware/arm_scmi/driver.c |   9 +-
>  drivers/firmware/arm_scmi/virtio.c | 277 ++++++++++++++++++++++++++++-
>  3 files changed, 291 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/firmware/arm_scmi/Kconfig b/drivers/firmware/arm_scmi/Kconfig
> index d429326433d1..7794bd41eaa0 100644
> --- a/drivers/firmware/arm_scmi/Kconfig
> +++ b/drivers/firmware/arm_scmi/Kconfig
> @@ -118,6 +118,21 @@ config ARM_SCMI_TRANSPORT_VIRTIO_VERSION1_COMPLIANCE
>  	  the ones implemented by kvmtool) and let the core Kernel VirtIO layer
>  	  take care of the needed conversions, say N.
>  
> +config ARM_SCMI_TRANSPORT_VIRTIO_ATOMIC_ENABLE
> +	bool "Enable atomic mode for SCMI VirtIO transport"
> +	depends on ARM_SCMI_TRANSPORT_VIRTIO
> +	help
> +	  Enable support of atomic operation for SCMI VirtIO based transport.
> +
> +	  If you want the SCMI VirtIO based transport to operate in atomic
> +	  mode, avoiding any kind of sleeping behaviour for selected
> +	  transactions on the TX path, answer Y.
> +
> +	  Enabling atomic mode operations allows any SCMI driver using this
> +	  transport to optionally ask for atomic SCMI transactions and operate
> +	  in atomic context too, at the price of using a number of busy-waiting
> +	  primitives all over instead. If unsure say N.
> +
>  endif #ARM_SCMI_PROTOCOL
>  
>  config ARM_SCMI_POWER_DOMAIN
> diff --git a/drivers/firmware/arm_scmi/driver.c b/drivers/firmware/arm_scmi/driver.c
> index c2e7897ff56e..dc972a54e93e 100644
> --- a/drivers/firmware/arm_scmi/driver.c
> +++ b/drivers/firmware/arm_scmi/driver.c
> @@ -648,7 +648,8 @@ static void scmi_handle_notification(struct scmi_chan_info *cinfo,
>  
>  	unpack_scmi_header(msg_hdr, &xfer->hdr);
>  	if (priv)
> -		xfer->priv = priv;
> +		/* Ensure order between xfer->priv store and following ops */
> +		smp_store_mb(xfer->priv, priv);
>  	info->desc->ops->fetch_notification(cinfo, info->desc->max_msg_size,
>  					    xfer);
>  	scmi_notify(cinfo->handle, xfer->hdr.protocol_id,
> @@ -680,8 +681,12 @@ static void scmi_handle_response(struct scmi_chan_info *cinfo,
>  		xfer->rx.len = info->desc->max_msg_size;
>  
>  	if (priv)
> -		xfer->priv = priv;
> +		/* Ensure order between xfer->priv store and following ops */
> +		smp_store_mb(xfer->priv, priv);
>  	info->desc->ops->fetch_response(cinfo, xfer);
> +	if (priv)
> +		/* Ensure order between xfer->priv clear and later accesses */
> +		smp_store_mb(xfer->priv, NULL);
>  
>  	trace_scmi_rx_done(xfer->transfer_id, xfer->hdr.id,
>  			   xfer->hdr.protocol_id, xfer->hdr.seq,
> diff --git a/drivers/firmware/arm_scmi/virtio.c b/drivers/firmware/arm_scmi/virtio.c
> index a147fc24c4c0..9fa337a4e464 100644
> --- a/drivers/firmware/arm_scmi/virtio.c
> +++ b/drivers/firmware/arm_scmi/virtio.c
> @@ -3,8 +3,8 @@
>   * Virtio Transport driver for Arm System Control and Management Interface
>   * (SCMI).
>   *
> - * Copyright (C) 2020-2021 OpenSynergy.
> - * Copyright (C) 2021 ARM Ltd.
> + * Copyright (C) 2020-2022 OpenSynergy.
> + * Copyright (C) 2021-2022 ARM Ltd.
>   */
>  
>  /**
> @@ -42,6 +42,10 @@
>   * @cinfo: SCMI Tx or Rx channel
>   * @free_lock: Protects access to the @free_list.
>   * @free_list: List of unused scmi_vio_msg, maintained for Tx channels only
> + * @deferred_tx_work: Worker for TX deferred replies processing
> + * @deferred_tx_wq: Workqueue for TX deferred replies
> + * @pending_lock: Protects access to the @pending_cmds_list.
> + * @pending_cmds_list: List of pre-fetched commands queueud for later processing
>   * @is_rx: Whether channel is an Rx channel
>   * @max_msg: Maximum number of pending messages for this channel.
>   * @lock: Protects access to all members except users, free_list.

... and also doesn't protect pending_cmds_list.

> @@ -54,6 +58,11 @@ struct scmi_vio_channel {
>  	/* lock to protect access to the free list. */
>  	spinlock_t free_lock;
>  	struct list_head free_list;
> +	/* lock to protect access to the pending list. */
> +	spinlock_t pending_lock;
> +	struct list_head pending_cmds_list;
> +	struct work_struct deferred_tx_work;
> +	struct workqueue_struct *deferred_tx_wq;
>  	bool is_rx;
>  	unsigned int max_msg;
>  	/* lock to protect access to all members except users, free_list  */

... and also doesn't protect pending_cmds_list.

> @@ -62,6 +71,12 @@ struct scmi_vio_channel {
>  	refcount_t users;
>  };
>  
> +enum poll_states {
> +	VIO_MSG_NOT_POLLED,
> +	VIO_MSG_POLLING,
> +	VIO_MSG_POLL_DONE,
> +};
> +
>  /**
>   * struct scmi_vio_msg - Transport PDU information
>   *
> @@ -69,12 +84,17 @@ struct scmi_vio_channel {
>   * @input: SDU used for (delayed) responses and notifications
>   * @list: List which scmi_vio_msg may be part of
>   * @rx_len: Input SDU size in bytes, once input has been received
> + * @poll_idx: Last used index registered for polling purposes if this message
> + *	      transaction reply was configured for polling.
> + * @poll_status: Polling state for this message.
>   */
>  struct scmi_vio_msg {
>  	struct scmi_msg_payld *request;
>  	struct scmi_msg_payld *input;
>  	struct list_head list;
>  	unsigned int rx_len;
> +	unsigned int poll_idx;
> +	enum poll_states poll_status;
>  };
>  
>  /* Only one SCMI VirtIO device can possibly exist */
> @@ -117,6 +137,7 @@ static void scmi_vio_channel_cleanup_sync(struct scmi_vio_channel *vioch)
>  {
>  	unsigned long flags;
>  	DECLARE_COMPLETION_ONSTACK(vioch_shutdown_done);
> +	void *deferred_wq = NULL;
>  
>  	/*
>  	 * Prepare to wait for the last release if not already released
> @@ -127,10 +148,19 @@ static void scmi_vio_channel_cleanup_sync(struct scmi_vio_channel *vioch)
>  		spin_unlock_irqrestore(&vioch->lock, flags);
>  		return;
>  	}
> +
>  	vioch->shutdown_done = &vioch_shutdown_done;
>  	virtio_break_device(vioch->vqueue->vdev);
> +	if (!vioch->is_rx && vioch->deferred_tx_wq) {
> +		deferred_wq = vioch->deferred_tx_wq;
> +		/* Cannot be kicked anymore after this...*/
> +		vioch->deferred_tx_wq = NULL;
> +	}
>  	spin_unlock_irqrestore(&vioch->lock, flags);
>  
> +	if (deferred_wq)
> +		destroy_workqueue(deferred_wq);
> +
>  	scmi_vio_channel_release(vioch);
>  
>  	/* Let any possibly concurrent RX path release the channel */
> @@ -163,6 +193,8 @@ static void scmi_virtio_put_free_msg(struct scmi_vio_channel *vioch,
>  {
>  	unsigned long flags;
>  
> +	msg->poll_status = VIO_MSG_NOT_POLLED;
> +
>  	spin_lock_irqsave(&vioch->free_lock, flags);
>  	list_add_tail(&msg->list, &vioch->free_list);
>  	spin_unlock_irqrestore(&vioch->free_lock, flags);
> @@ -233,6 +265,7 @@ static void scmi_vio_complete_cb(struct virtqueue *vqueue)
>  			virtqueue_disable_cb(vqueue);
>  			cb_enabled = false;
>  		}
> +
>  		msg = virtqueue_get_buf(vqueue, &length);
>  		if (!msg) {
>  			if (virtqueue_enable_cb(vqueue)) {
> @@ -263,6 +296,40 @@ static void scmi_vio_complete_cb(struct virtqueue *vqueue)
>  	}
>  }
>  
> +static void scmi_vio_deferred_tx_worker(struct work_struct *work)
> +{
> +	unsigned long flags;
> +	struct scmi_vio_channel *vioch;
> +	struct scmi_vio_msg *msg, *tmp;
> +
> +	vioch = container_of(work, struct scmi_vio_channel, deferred_tx_work);
> +
> +	if (!scmi_vio_channel_acquire(vioch))
> +		return;
> +
> +	/* Process pre-fetched messages */
> +	spin_lock_irqsave(&vioch->pending_lock, flags);
> +
> +	/* Scan the list of possibly pre-fetched messages during polling. */
> +	list_for_each_entry_safe(msg, tmp, &vioch->pending_cmds_list, list) {
> +		list_del(&msg->list);
> +
> +		/* Channel is acquired here and cannot vanish */
> +		scmi_rx_callback(vioch->cinfo,
> +				 msg_read_header(msg->input), msg);
> +
> +		/* Free the processed message once done */
> +		scmi_virtio_put_free_msg(vioch, msg);
> +	}
> +
> +	spin_unlock_irqrestore(&vioch->pending_lock, flags);
> +
> +	/* Process possibly still pending messages */
> +	scmi_vio_complete_cb(vioch->vqueue);
> +
> +	scmi_vio_channel_release(vioch);
> +}
> +
>  static const char *const scmi_vio_vqueue_names[] = { "tx", "rx" };
>  
>  static vq_callback_t *scmi_vio_complete_callbacks[] = {
> @@ -330,6 +397,19 @@ static int virtio_chan_setup(struct scmi_chan_info *cinfo, struct device *dev,
>  
>  	vioch = &((struct scmi_vio_channel *)scmi_vdev->priv)[index];
>  
> +	/* Setup a deferred worker for polling. */
> +	if (tx && !vioch->deferred_tx_wq) {
> +		vioch->deferred_tx_wq =
> +			alloc_workqueue(dev_name(&scmi_vdev->dev),
> +					WQ_UNBOUND | WQ_FREEZABLE | WQ_SYSFS,
> +					0);
> +		if (!vioch->deferred_tx_wq)
> +			return -ENOMEM;
> +
> +		INIT_WORK(&vioch->deferred_tx_work,
> +			  scmi_vio_deferred_tx_worker);
> +	}
> +
>  	for (i = 0; i < vioch->max_msg; i++) {
>  		struct scmi_vio_msg *msg;
>  
> @@ -397,6 +477,18 @@ static int virtio_send_message(struct scmi_chan_info *cinfo,
>  
>  	spin_lock_irqsave(&vioch->lock, flags);
>  
> +	/*
> +	 * If polling was requested for this transaction:
> +	 *  - retrieve last used index (will be used as polling reference)
> +	 *  - bind the polled message to the xfer via .priv
> +	 */
> +	if (xfer->hdr.poll_completion) {
> +		msg->poll_idx = virtqueue_enable_cb_prepare(vioch->vqueue);
> +		msg->poll_status = VIO_MSG_POLLING;
> +		/* Ensure initialized msg is visibly bound to xfer */
> +		smp_store_mb(xfer->priv, msg);
> +	}
> +
>  	rc = virtqueue_add_sgs(vioch->vqueue, sgs, 1, 1, msg, GFP_ATOMIC);
>  	if (rc)
>  		dev_err(vioch->cinfo->dev,
> @@ -406,8 +498,11 @@ static int virtio_send_message(struct scmi_chan_info *cinfo,
>  
>  	spin_unlock_irqrestore(&vioch->lock, flags);
>  
> -	if (rc)
> +	if (rc) {
> +		/* Ensure order between xfer->priv clear and vq feeding */
> +		smp_store_mb(xfer->priv, NULL);
>  		scmi_virtio_put_free_msg(vioch, msg);
> +	}
>  
>  	scmi_vio_channel_release(vioch);
>  
> @@ -419,10 +514,8 @@ static void virtio_fetch_response(struct scmi_chan_info *cinfo,
>  {
>  	struct scmi_vio_msg *msg = xfer->priv;
>  
> -	if (msg) {
> +	if (msg)
>  		msg_fetch_response(msg->input, msg->rx_len, xfer);
> -		xfer->priv = NULL;
> -	}
>  }
>  
>  static void virtio_fetch_notification(struct scmi_chan_info *cinfo,
> @@ -430,10 +523,173 @@ static void virtio_fetch_notification(struct scmi_chan_info *cinfo,
>  {
>  	struct scmi_vio_msg *msg = xfer->priv;
>  
> -	if (msg) {
> +	if (msg)
>  		msg_fetch_notification(msg->input, msg->rx_len, max_len, xfer);
> -		xfer->priv = NULL;
> +}
> +
> +/**
> + * virtio_mark_txdone  - Mark transmission done
> + *
> + * Free only completed polling transfer messages.
> + *
> + * Note that in the SCMI VirtIO transport we never explicitly release timed-out
> + * messages by forcibly re-adding them to the free-list inside the TX code path;
> + * we instead let IRQ/RX callbacks eventually clean up such messages once,
> + * finally, a late reply is received and discarded (if ever).
> + *
> + * This approach was deemed preferable since those pending timed-out buffers are
> + * still effectively owned by the SCMI platform VirtIO device even after timeout
> + * expiration: forcibly freeing and reusing them before they had been returned
> + * explicitly by the SCMI platform could lead to subtle bugs due to message
> + * corruption.
> + * An SCMI platform VirtIO device which never returns message buffers is
> + * anyway broken and it will quickly lead to exhaustion of available messages.
> + *
> + * For this same reason, here, we take care to free only the polled messages
> + * that had been somehow replied and not by chance processed on the IRQ path,
> + * since they won't be freed elsewhere; possible late replies to timed-out
> + * polled messages will be anyway freed by RX callbacks instead.
> + *
> + * @cinfo: SCMI channel info
> + * @ret: Transmission return code
> + * @xfer: Transfer descriptor
> + */
> +static void virtio_mark_txdone(struct scmi_chan_info *cinfo, int ret,
> +			       struct scmi_xfer *xfer)
> +{
> +	struct scmi_vio_channel *vioch = cinfo->transport_info;
> +	struct scmi_vio_msg *msg = xfer->priv;
> +
> +	if (!scmi_vio_channel_acquire(vioch))
> +		return;
> +
> +	/* Must be a polled xfer and not already freed on the IRQ path */
> +	if (!xfer->hdr.poll_completion || !msg) {
> +		scmi_vio_channel_release(vioch);
> +		return;
>  	}
> +
> +	/* Ensure msg is unbound from xfer anyway at this point */
> +	smp_store_mb(xfer->priv, NULL);
> +
> +	/* Do not free timedout polled messages */
> +	if (ret != -ETIMEDOUT)
> +		scmi_virtio_put_free_msg(vioch, msg);
> +
> +	scmi_vio_channel_release(vioch);
> +}
> +
> +/**
> + * virtio_poll_done  - Provide polling support for VirtIO transport
> + *
> + * @cinfo: SCMI channel info
> + * @xfer: Reference to the transfer being poll for.
> + *
> + * VirtIO core provides a polling mechanism based only on last used indexes:
> + * this means that it is possible to poll the virtqueues waiting for something
> + * new to arrive from the host side, but the only way to check if the freshly
> + * arrived buffer was indeed what we were waiting for is to compare the newly
> + * arrived message descriptor with the one we are polling on.
> + *
> + * As a consequence it can happen to dequeue something different from the buffer
> + * we were poll-waiting for: if that is the case such early fetched buffers are
> + * then added to a the @pending_cmds_list list for later processing by a
> + * dedicated deferred worker.
> + *
> + * So, basically, once something new is spotted we proceed to de-queue all the
> + * freshly received used buffers until we found the one we were polling on, or,
> + * we have 'seemingly' emptied the virtqueue; if some buffers are still pending
> + * in the vqueue at the end of the polling loop (possible due to inherent races
> + * in virtqueues handling mechanisms), we similarly kick the deferred worker
> + * and let it process those, to avoid indefinitely looping in the .poll_done
> + * busy-waiting helper.
> + *
> + * Note that, since we do NOT have per-message suppress notification mechanism,
> + * the message we are polling for could be alternatively delivered via usual
> + * IRQs callbacks on another core which happened to have IRQs enabled while we
> + * are actively polling for it here: in such a case it will be handled as such
> + * by scmi_rx_callback() and the polling loop in the SCMI Core TX path will be
> + * transparently terminated anyway.
> + *
> + * Return: True once polling has successfully completed.
> + */
> +static bool virtio_poll_done(struct scmi_chan_info *cinfo,
> +			     struct scmi_xfer *xfer)
> +{
> +	bool pending, ret = false;
> +	unsigned int length, any_prefetched = 0;
> +	unsigned long flags;
> +	struct scmi_vio_msg *next_msg, *msg = xfer->priv;
> +	struct scmi_vio_channel *vioch = cinfo->transport_info;
> +
> +	if (!msg)
> +		return true;
> +
> +	/* Processed already by other polling loop on another CPU ? */
> +	if (msg->poll_status == VIO_MSG_POLL_DONE)
> +		return true;
> +
> +	if (!scmi_vio_channel_acquire(vioch))
> +		return true;
> +
> +	/* Has cmdq index moved at all ? */
> +	pending = virtqueue_poll(vioch->vqueue, msg->poll_idx);
> +	if (!pending) {
> +		scmi_vio_channel_release(vioch);
> +		return false;
> +	}
> +
> +	spin_lock_irqsave(&vioch->lock, flags);
> +	virtqueue_disable_cb(vioch->vqueue);
> +
> +	/*
> +	 * Process all new messages till the polled-for message is found OR
> +	 * the vqueue is empty.
> +	 */
> +	while ((next_msg = virtqueue_get_buf(vioch->vqueue, &length))) {
> +		next_msg->rx_len = length;
> +		/* Is the message we were polling for ? */
> +		if (next_msg == msg) {
> +			ret = true;
> +			break;
> +		}
> +
> +		if (next_msg->poll_status == VIO_MSG_NOT_POLLED) {
> +			any_prefetched++;
> +
> +			spin_lock(&vioch->pending_lock);
> +			list_add_tail(&next_msg->list,
> +				      &vioch->pending_cmds_list);
> +			spin_unlock(&vioch->pending_lock);
> +		} else {
> +			/* We picked another currently polled msg */
> +			smp_store_mb(next_msg->poll_status, VIO_MSG_POLL_DONE);

What if the polling is just about to time out? Then no thread of execution
might pick up the message and feed back the buffers.

> +		}
> +	}
> +
> +	/*
> +	 * When the polling loop has successfully terminated if something
> +	 * else was queued in the meantime, it will be served by a deferred
> +	 * worker OR by the normal IRQ/callback OR by other poll loops.
> +	 *
> +	 * If we are still looking for the polled reply, the polling index has
> +	 * to be updated to the current vqueue last used index.
> +	 */
> +	if (ret) {
> +		pending = !virtqueue_enable_cb(vioch->vqueue);
> +	} else {
> +		msg->poll_idx = virtqueue_enable_cb_prepare(vioch->vqueue);
> +		pending = virtqueue_poll(vioch->vqueue, msg->poll_idx);
> +	}
> +
> +	if (vioch->deferred_tx_wq && (any_prefetched || pending))
> +		queue_work(vioch->deferred_tx_wq, &vioch->deferred_tx_work);
> +
> +	spin_unlock_irqrestore(&vioch->lock, flags);
> +
> +	scmi_vio_channel_release(vioch);
> +
> +	return ret;
>  }
>  
>  static const struct scmi_transport_ops scmi_virtio_ops = {
> @@ -445,6 +701,8 @@ static const struct scmi_transport_ops scmi_virtio_ops = {
>  	.send_message = virtio_send_message,
>  	.fetch_response = virtio_fetch_response,
>  	.fetch_notification = virtio_fetch_notification,
> +	.mark_txdone = virtio_mark_txdone,
> +	.poll_done = virtio_poll_done,
>  };
>  
>  static int scmi_vio_probe(struct virtio_device *vdev)
> @@ -487,6 +745,8 @@ static int scmi_vio_probe(struct virtio_device *vdev)
>  		spin_lock_init(&channels[i].lock);
>  		spin_lock_init(&channels[i].free_lock);
>  		INIT_LIST_HEAD(&channels[i].free_list);
> +		spin_lock_init(&channels[i].pending_lock);
> +		INIT_LIST_HEAD(&channels[i].pending_cmds_list);
>  		channels[i].vqueue = vqs[i];
>  
>  		sz = virtqueue_get_vring_size(channels[i].vqueue);
> @@ -576,4 +836,5 @@ const struct scmi_desc scmi_virtio_desc = {
>  	.max_rx_timeout_ms = VIRTIO_MAX_RX_TIMEOUT_MS,
>  	.max_msg = 0, /* overridden by virtio_get_max_msg() */
>  	.max_msg_size = VIRTIO_SCMI_MAX_MSG_SIZE,
> +	.atomic_enabled = IS_ENABLED(CONFIG_ARM_SCMI_TRANSPORT_VIRTIO_ATOMIC_ENABLE),
>  };


