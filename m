Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDC5E506554
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 09:06:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345046AbiDSHIq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 03:08:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233346AbiDSHIp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 03:08:45 -0400
Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.109.102])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30DF8FFA
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 00:06:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
        t=1650351961;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6j/gdi8z0pVyMqFwRfcg1p0g9h2uQu2FPygDYpQQ1/s=;
        b=G/Pd32vebQnkSk71fPWtd3WCFXpNtZucvqXme4sHCj/+lMJVHJiK52EI9D/4vQs213uFLd
        A0CX8qUo5KEMK6e72nDqQnA2OjeRFqHhhhuVjzXNHCbMqZSwUgHiRh/JuhlMqJ3p8G7mmN
        wdK/C+6Jt+7cqUvpiTxylo/7U5NMF+E=
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
 (mail-am6eur05lp2104.outbound.protection.outlook.com [104.47.18.104]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-29-olcVLhWGOwGsogCt3nL8nQ-1; Tue, 19 Apr 2022 09:05:58 +0200
X-MC-Unique: olcVLhWGOwGsogCt3nL8nQ-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d3SJ5owV0VmAk7QT6oEmuS6T4/YpNUST3rUUTHFLQTjfXqaAHagwig+cMaTZkQaJpm/PpFyk5bY1K7QEQCODnbJo5GKEgr3j4mLaVnSXjU2nTnxa9dAwND29LwRiIaewuhrFjEX0TlfK4viD8TBvp9Eumw+ploMPevgESdpUjuUzDgezBy35DKm8M5E+hSDb+7OpgIZz7BO+6YJBvm+s5veu+hetgOnt7BsUkJyhoyVUCmOXueSd7c/tcfbn7S0zhJXjYX6+kQrNtFKDCpwoawMhb00/rVPInUOi4tOR3IjBDxhNislsBu9n5AYyxjFziKj1+Rp+T7hj3dQmuXv4aw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xwCHwdVXl8FBsOqHcPAPvcM8JRshdD6lp8qCKzHSGgM=;
 b=SMl0+q9qgBrVe/RISUUq/rR9OY7C3o9TiC8t5EHgSMcRud3knRXdbFRXmCT58FY7JBu1KljEuJ6kz61owJU13d4Q+5kV2McciqrHQ6NDUkqMEAppdSxXkOaXCYeGnwGKgFXww1f8rcQJEW+T5rEukwH8wTsBZnAQRhkNr9Xrt0LVGb14IxQWjV+vt0zIK13cbbeYp8rmCmf4hbHHqaaDcaHHZk1zHtp4FUEXbVBEAgKOTglvjfbhwOzXsTYedGDlLBEEHAPjiOpFDrtmncM9bRVyP6t15UFkzAYdRmNyld13RSZlCF6BOiQlYEpeeYNcIttgNf0LK8bN5hIAwpU4zQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from VI1PR0401MB2526.eurprd04.prod.outlook.com
 (2603:10a6:800:58::16) by DB7PR04MB4042.eurprd04.prod.outlook.com
 (2603:10a6:5:25::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5164.20; Tue, 19 Apr
 2022 07:05:56 +0000
Received: from VI1PR0401MB2526.eurprd04.prod.outlook.com
 ([fe80::8c82:19c5:ce96:491b]) by VI1PR0401MB2526.eurprd04.prod.outlook.com
 ([fe80::8c82:19c5:ce96:491b%4]) with mapi id 15.20.5164.025; Tue, 19 Apr 2022
 07:05:56 +0000
Message-ID: <9f2752b5-8717-8ea3-1462-69bcfe42bb0e@suse.com>
Date:   Tue, 19 Apr 2022 09:05:53 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH v2 0/2] USB: Quiesce interrupts across pm freeze
Content-Language: en-US
To:     Evan Green <evgreen@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     Thomas Gleixner <tglx@linutronix.de>,
        Mathias Nyman <mathias.nyman@intel.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        Rajat Jain <rajatja@chromium.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Razvan Heghedus <heghedus.razvan@gmail.com>,
        Wei Ming Chen <jj251510319013@gmail.com>,
        Youngjin Jang <yj84.jang@samsung.com>,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
References: <20220418210046.2060937-1-evgreen@chromium.org>
From:   Oliver Neukum <oneukum@suse.com>
In-Reply-To: <20220418210046.2060937-1-evgreen@chromium.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: AM6P194CA0084.EURP194.PROD.OUTLOOK.COM
 (2603:10a6:209:8f::25) To VI1PR0401MB2526.eurprd04.prod.outlook.com
 (2603:10a6:800:58::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: aee74fbd-b88d-4499-75ee-08da21d30ce9
X-MS-TrafficTypeDiagnostic: DB7PR04MB4042:EE_
X-Microsoft-Antispam-PRVS: <DB7PR04MB40427B9D2D43E7BDD20A5165C7F29@DB7PR04MB4042.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IaSmkUoRdL7dYqZzuNyIcbSxfBWouzffY88U92/gxxbmJAQvMR0lUdw0vUwm5o02mRqE/oB2ipptfnNQ3jMuKyE9X1mj1tlSpFL+47Kh/iOngIuDpKtbKSaQbW32AwOMLntbwVJp7VqMDLgh3lKO9HdGQBT0TmMeT4jOZicZh8l8AUj4Ycj1PZeaES+BnySMSq/dBO0iQ4UAgcIs4RZWCuQw+fRM1zj37hpMeijdTo24bskpA5AzT2HDNyc9zBwDTclW66awJo6DslV4P8F98J195XDWQEWESGQT5Eia6LFmPdHlWIPs5gPVsY7viGhgISfAW70i0r8q+LAnFTdkYwXkJIdCZbL5VOV8AQQ2Mn7RLoi2ckaSed72UItDm7Oci4VNmOjgbvXWWrxGqySi0M/k79+qQS/EUnpuWI2LxREGURz66thP6og6fSngppa6Q/PUKYas+6ZcpLP3vlwSqqQeqY6bWFqhSeYvjAiCPbHqeLIV5g+pfDqbWJ51DMilKG9wBdOGyrpc5qSt5vR4NWRLlfc2Ll2nYtBSmj+iBXcLRQUS9MHvYu9WA7gtUOyML1FQxJv0GgDgj6NVprdua1Of4k2BYypyf8DLi9pi4PmHb2VlDGW39hO8VCcSNxjJGv9DUY8yXNwQSIlUBQmE79VcS2n8LnmAYgI019zMaomTmu5BOSuUiXU3m56mZXLrkGZrOEkyHo04ubBgVPxUH47vq8VPh/0yf/TuFSdq0wc=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR0401MB2526.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(86362001)(83380400001)(6666004)(66946007)(31696002)(316002)(38100700002)(6486002)(186003)(2616005)(110136005)(5660300002)(8676002)(54906003)(7416002)(66476007)(66556008)(4326008)(508600001)(8936002)(6506007)(36756003)(31686004)(2906002)(6512007)(53546011)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?eI7eos02jf04aLMdV6mDqxTG7e7kf0oYlmzX0pfxtJtXZBX8DHrchN1WOi+Z?=
 =?us-ascii?Q?SVFN+3MIv98bF969aO56S5Y83JbMa3tjb48lbGRRkLmrUuzdjCv7riHfru39?=
 =?us-ascii?Q?AF992AJOpJjQP1AZOdf5j7FoEI7FcUuIOAGJ5t6iRN3WvTRcRd428xlFKjW5?=
 =?us-ascii?Q?1roO80AGEH3kFJyJQ5DAdvAYJ9mucG3bs/57mxtBFzA8CTaNV4OkAqybz9DH?=
 =?us-ascii?Q?vV9Byl5hTOQyB5skp+CncooEYNTuy3Ul76rPTpW2bjYONKYjC+6U5t7zjpI6?=
 =?us-ascii?Q?FHjW0MbKMxbU2PiLpnZNMo0vJ5oTq0bM5JOKms8lfIjenMzYGwSMK3bGHFgx?=
 =?us-ascii?Q?VnZoy4p/CyOr4T/XNpTSBCC0f4grYtDQE3sww1Yi2Cjuv/XllI4N7b8OY8Ej?=
 =?us-ascii?Q?0SGflokThkg5cs2DNuMG7/7+LzEwMxa3F7ue2S6JNV0FP4sWp247kX5W5cze?=
 =?us-ascii?Q?4v4jhreRAWW87JeXlU5qe8w0YLpmNrJjfe7nr+a/6kK5+7kX6/VV3aoDsv4V?=
 =?us-ascii?Q?YazIL/IcFVY/dcLp+SDMJKfQa9F+R7UZ/spjzbxuGtmHJ+hzprCFwV8htbpU?=
 =?us-ascii?Q?PQ8tvAcDjgCh8dEmTRgPkzG4LHPDrdMi5mqWBA1ORXZMRe//zIG0ApAsVOqi?=
 =?us-ascii?Q?eIfMCEY+m85IDr8p1GM/39RhRk5z3V7+bqDt/zY1dInmEsL7CuW6rsqOek05?=
 =?us-ascii?Q?fg/N5YQWIVA/c0Vf4EoaDVBlx9FiTWHxH6gPRuDAWrC+SVWJHzkVgXyyNEU3?=
 =?us-ascii?Q?N8wVjDYQc//bVeEEnY9Ft9ufv7owHTBpnszZnAzW1YNST4EHgUPPCmPhfnHo?=
 =?us-ascii?Q?6nMTGaxRBGy9Bzs534fvgaf0FjRJFSzun3h3qzaAJCGNj4n7ah4OAYWEBqKM?=
 =?us-ascii?Q?8qCRf/3GGEEk90Z0ldpsaxpXQUMiUQXLXjDc2J/LxID6dQn+toHvIYOwxMD8?=
 =?us-ascii?Q?oqtname0TekZ4Yij31JlYzZLFzbe4OJFr7Upzb1+Agc7ID+ZruvchCjpz2Yq?=
 =?us-ascii?Q?xBkprW2xCedf0HrsMNylUKDWnykzF/pfgfH3mDbzfMeP9d/oaKo3o/GCRKfE?=
 =?us-ascii?Q?E12hGwtxExDufDUPFNuR+yVoDHbSsRaVrf3veWSvwxTtqqfzlZdwCFjGAIjB?=
 =?us-ascii?Q?km0uA2sExIX9/xI/7NyTZ3XFCA+kvijjb+7laiF8MLnzDhDKy2ZKBdxuZln/?=
 =?us-ascii?Q?aIs9gc6RiauC0/pV0+ZW/13uHdCmZ5vMyNIjNn7rASqBNqB9C4R8bqeLfWNd?=
 =?us-ascii?Q?x07lDmcQIGcvupxrIiLYmK8Zj141ve96ZBrTW7LASbZ82auUVTDSjCp+VlmX?=
 =?us-ascii?Q?/twKpeLGY/PZtUE6P0TXkelajczVF5dCvaHfzNk8/CFpB4ddKWNaHw7DLz2q?=
 =?us-ascii?Q?ApyueFf5rXHdEJBDPH6bzC5IYnNYNnjGhurQFSiayAU0UJmSVG1SrVizjmxI?=
 =?us-ascii?Q?TaI3fxqVrr4A5mHCjOPQr2iBVQDQx01Fsymxeia1SfS24hGfPg0xI8DlvhkI?=
 =?us-ascii?Q?oraPTmKQIJO1loXOJ7rtxRGPCr5uc63GcgWRMhqs15MrcDepqYG1Es/4wnAC?=
 =?us-ascii?Q?mMVzJhPtG6NlhlFe+7bnsSM6wMeESDqhif/1U1c02SUtIq1gclud7hSkZf1S?=
 =?us-ascii?Q?WaGXxDGhdCu2hrbbverNU2jOTINDJKsK0qTuREq7EqHH4sfZIk37fjLVyUDu?=
 =?us-ascii?Q?CAehksIjS2x5DukerOZ3U+u2c54xK2om4wMZ2EJ2A5OuDy2WmzrKWY1k22Zi?=
 =?us-ascii?Q?e05oCZo1lUT5XOK2f7sCUA9RvM5+EQG+GezyCxuWP34F76MPf1yijL0FnneY?=
X-MS-Exchange-AntiSpam-MessageData-1: YyzqN8D5iLa4jQ==
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aee74fbd-b88d-4499-75ee-08da21d30ce9
X-MS-Exchange-CrossTenant-AuthSource: VI1PR0401MB2526.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Apr 2022 07:05:56.6507
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 27tvvyhjpgpggc5S7ot4Zrik3fCu0SdIvepGNzYtKL2zZJvKH+1uKzdCoEZ/ARBUmWBivxKrabhiunGR1O3cVg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR04MB4042
X-Spam-Status: No, score=-6.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 18.04.22 23:00, Evan Green wrote:
> The documentation for the freeze() method says that it "should quiesce
> the device so that it doesn't generate IRQs or DMA". The unspoken
> consequence of not doing this is that MSIs aimed at non-boot CPUs may
> get fully lost if they're sent during the period where the target CPU is
> offline.
>
> The current behavior of the USB subsystem still allows interrupts to
> come in after freeze, both in terms of remote wakeups and HC events
> related to things like root plug port activity. This can get controllers
> like XHCI, which is very sensitive to lost interrupts, in a wedged
> state. This series attempts to fully quiesce interrupts coming from USB
> across in a freeze or quiescent state.
>
> These patches are grouped together because they serve a united purpose,
> but are actually independent. They could be merged or reverted
> individually.
Hi,

sorry for being a bit late in this discussion. There was something that
I didn't remember immediately.

We have a set of quirky devices that need HID_QUIRK_ALWAYS_POLL.
They have the nasty firmware bug that, if you suspend them without
remote wakeup, they will crash or reset themselves.
I am afraid that has an obvious relevance to your cool patches.
I am not completely sure how to deal with this. It seems to me that the
quirk will need to be shifted from HID to core USB and thaw() needs to
be translated into usb_device_reset() + reset_resume() for them,
but I am not really sure about the optimal mechanism.

=C2=A0=C2=A0=C2=A0 Regards
=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 Oliver

