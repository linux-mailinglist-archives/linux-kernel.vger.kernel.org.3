Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EACED4B8689
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Feb 2022 12:18:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231374AbiBPLTC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Feb 2022 06:19:02 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:55600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229486AbiBPLS6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Feb 2022 06:18:58 -0500
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-eopbgr70089.outbound.protection.outlook.com [40.107.7.89])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DB893A6;
        Wed, 16 Feb 2022 03:18:45 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kVuLkFePo+O4vpVPiqT02GhWkHoYITXg05kvZhgZ2qj4hPbPxvA6aNugowzy3mTpTgSTwd3KdB2MDoiaCXo3Q12oKOWlXf5XpJ45ccjmGmnFtKetHGrtOP2Z87pWXO69pddRyzW6eltUOttBGQWEjP2igtkW+tSf/Z0xCk1cKnuZUTxghuW6MrPzzpDkihSwBYRFvIAioXX3NcFOxShyd2yY5Lesm4zeyfVJXotuwpz4SXSeZJ21tvi1/oPCk69tjGvTUpZtOVbB+P84g6rrk2p5uh+jTmjDsgjMSCRGxBxGlAjFfIy3YX1pV7dR+H2ObarpKQqT2IMhbghZIFqe+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7xGo+edj9OT9bvqFlhkz8SWq2rBrrVOKffW7uRTyhwA=;
 b=FcMacYOpssmSao8ToegfK7KhsZ/ChfaXCagILuZ6or1/u/vcwkmLq8vuJ++ghxciW2jrxPrWgpq0iEkEnqT6WhdK0NdBn1I33BstLBBVuJN1T1FqSSv5BWS7u6iWUgHp62V8cSRtSlcql41RD9bvuRGowVZjQgJbcLS1h/hZE2LUZJ6SixwguueL3axP0QukoCaMkhYVdIPPcSiy4iGBDbiWiC07zctFPNRMoHpyP1VkwlzbO5avvkpwmVIVyiku6kRoCrfW8hjJGGt5u9578RnAscXCBGb2UoQ45dEwy/76PLzeimsbNbOQ7RAYsfq/ZehLrl5otC+3P+cWBOfaow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ipetronik.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7xGo+edj9OT9bvqFlhkz8SWq2rBrrVOKffW7uRTyhwA=;
 b=OQA+De2LdX3sKAWWEXpBd5/H3YO7vL6wDBaUfOH0btuWk49tEEC8Ygq7JF9zVTkIeUYgdGngeQUISLSxxeNwL+noE2TxlhmCGCk93OVhb6Yb7GSODJkreIRdJ8HRDRVGnJKpH3aV6r6IDmRrD1lyc4KsZKlw2aFijnvys4SATSsYUN2S8Li6ghfcKUj2gPHanGTGhDwrwiancxHBXullcIJLX5WEyr30z/RPAcBDrs/MVsvvtjshLCRC9EzZnizxq6i5mcBB3ITJgAp017eG0KAhH1rGUIqnr6yCb5ixRgbYXQPdors1ympQISJv0sQQvddXXhCS6GRaelYeFhiG3Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=ipetronik.com;
Received: from AM9P193MB1572.EURP193.PROD.OUTLOOK.COM (2603:10a6:20b:307::12)
 by AS8P193MB1413.EURP193.PROD.OUTLOOK.COM (2603:10a6:20b:39b::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.11; Wed, 16 Feb
 2022 11:18:42 +0000
Received: from AM9P193MB1572.EURP193.PROD.OUTLOOK.COM
 ([fe80::f127:41d:4d91:9dc0]) by AM9P193MB1572.EURP193.PROD.OUTLOOK.COM
 ([fe80::f127:41d:4d91:9dc0%8]) with mapi id 15.20.4995.016; Wed, 16 Feb 2022
 11:18:42 +0000
Date:   Wed, 16 Feb 2022 12:18:41 +0100
From:   Markus =?utf-8?Q?Bl=C3=B6chl?= <Markus.Bloechl@ipetronik.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
        Sagi Grimberg <sagi@grimberg.me>,
        linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, Stefan Roese <sr@denx.de>
Subject: Re: [RFC PATCH] nvme: prevent hang on surprise removal of NVMe disk
Message-ID: <20220216111841.jaunxn6blouzjleg@ipetronik.com>
References: <20220214095107.3t5en5a3tosaeoo6@ipetronik.com>
 <20220215191731.GB25076@lst.de>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220215191731.GB25076@lst.de>
X-ClientProxiedBy: AM0PR10CA0118.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:208:e6::35) To AM9P193MB1572.EURP193.PROD.OUTLOOK.COM
 (2603:10a6:20b:307::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ed799b0c-8fba-4066-312f-08d9f13e16d4
X-MS-TrafficTypeDiagnostic: AS8P193MB1413:EE_
X-Microsoft-Antispam-PRVS: <AS8P193MB1413010291100038AF01382492359@AS8P193MB1413.EURP193.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:179;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oT3U4USBMRieohPeykkSCKdVZU7hfynvyPil2GS3jo7iAmKBcTUPAcF5WjdLqhX3XElmOb0TrMVmfsUmDE3/JrsBMgs2ys3fZDnu6sWaGRtzyiYXb1LSv+9zBbQo9ig1Kb4LGI9IihRpPcnWbLANTz1FsPWGANlW7SB/LoNt4Hg9hBf+mKO5arnZnnJ2XR3fb768D0VrNMDrU3TOvoO5AwaqKNFRhCH+wXMIl1olXusD4ezGlZC8pr275IszKFkXT4K67H7vSHZdRLjLjQlS/W0NsXR6/zeeYh0T+/3PjTViP2SZJvaBgSwAZ+nCzH0nHElGoEJjavXhreQMEorCfCJGou9U3NWcMuE2B84U6uHBZeg4ws6Ys0hkm4mQPXNZ7YCfKx0zdbEOZTFMp7PQ7a+VNeR4WFXvADz/oHMJvV8iZgjUa/jmv09ILS5nv1o4CPGqM0fypFKRPeXD15GmTI2DMh40pBxf7IBxCEYfIkQuNpCqvS3G6ed3avZIPWq9kW4833CWqX3g/5tMIfESikMJBcGMO3G5ZLZt3FwnawrUz1YXGEmmKnF9Yie43TzaTFkElf4d6vzXPjPUxCNdlUtfZI6mrfOWvQ5RtVswxR6rct3jl5OY9VQGC2vqTyqJdIIJWHOOeNKHroARoijFWA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9P193MB1572.EURP193.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230001)(366004)(6506007)(86362001)(66556008)(36756003)(6486002)(508600001)(52116002)(6512007)(1076003)(38100700002)(316002)(54906003)(83380400001)(2906002)(4744005)(8936002)(5660300002)(8676002)(6916009)(4326008)(186003)(66476007)(2616005)(66946007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Q0tNaHk0M3RWejRseWU4cUNPM0FmQVoyREpVYWNMM3JxbFk2T05ndmdVdERS?=
 =?utf-8?B?MVB0TGJWV3NCci8ydlh4ems4TGhCZW1mR1NOUW81TkFhVVJhY2kreko2QitM?=
 =?utf-8?B?ZXBxcGNBancrd1lvRCsvQWxHTVBScGFrUmM4aXNhemhGeEQ4YWF2dVRXZXlQ?=
 =?utf-8?B?Y1JpcjQvT0tGSDJObEFrZFVjVXU2MDFuZ01ad3cwdkJjRzRwL1h4RUdySE02?=
 =?utf-8?B?U0lTV012TkNaQ2xIbzJOVWFqRmVpeUI3K21NbG9MZFh4a2g3WnF6Yyt4ZTNh?=
 =?utf-8?B?dHpHZnJkN2FEWFRzSGxEYXN2Z3RnZFQ1T1U5TWJkQU9BRHlWQzlrZjFoU01T?=
 =?utf-8?B?RzlPTnNWN04yVEhmcVhEUmE4R0d4Z2NScVlKYTJ6Ym1raHpRYVZCQ2xOVzQ1?=
 =?utf-8?B?eU15WXJhdFFUNEorYjFHdjlENlRObGJleVJPL3lOaUNjdHpPUDBPODU2cjRX?=
 =?utf-8?B?ZjRmcVduMWN1aW0weWhtdjM4TGxCR1JwdkZRYmJhWW9XOEg1eHdDRFVQalNZ?=
 =?utf-8?B?eFJQMll5ZU1HbERjN0ZTd2lLMzF0S213NnpRL0puRTNTMTlUeFdOTmszak5y?=
 =?utf-8?B?aU1QRitUOTA4N1l3ZTQrMThFUDZOMmp2M3gycFd2YmVvbEJsUXVKeE8xeXZw?=
 =?utf-8?B?QmdFUVpJSjM3TUxVQVd2QkJKUnJYZHdaVlFrR3JtYis1czV1V0lLUHRtMU0v?=
 =?utf-8?B?dmpOeFM1Q1VJdDhrTDN2MHN0a3J5QWh6ZFFTQUVUcjFVeU91U2VnRWlGN0p5?=
 =?utf-8?B?ZGNkM3RSUkZZVy9HRWJqbjV2ZW1JSG10amduRG9ncVhFcWhzek1zR3Y2MVUv?=
 =?utf-8?B?UktPdmZhR3ZkZC9nWkZXZHQ4TXhpTGNvcDhVM2VUU2hWeDB6ajU4dWU0V25s?=
 =?utf-8?B?N241dDNVVEhZdThwOTEzOW13anlxUkR5MHhUaDJOYTZ3cXZSbDdNM0hzWGRU?=
 =?utf-8?B?MEVwS1dWK0M3K01ZbTVVNStHTExWbDdBbUNWcUQ0TlgxWVhBakNkVzBaeVNB?=
 =?utf-8?B?OStFeUpacVBwLzQxTkxiNmlKWVNNbG8rYnpyeEN2Uk9mVm11THNZS3E3NWlI?=
 =?utf-8?B?NytyVWFNQ2V0amtXT21ZWEZKTVIzWnltOGx3Uy9NMkhyTzRiNWp1ZUUwR3gz?=
 =?utf-8?B?T3BlekQ4eHkvSHFyM29nazlJMjJYR1RLWUEvY0U2QnAwbktxY3B0ZUI2SnVv?=
 =?utf-8?B?OVNPakQ3OWhCcGtxaXJYMndSaXlPRDBLMkp1anRId251cjg4dzZLQnNrWHZF?=
 =?utf-8?B?QysvVmJzRVdOZ2JoWGhuL1pRMVQ4bTgxZHlpYzRuT0FHNkVUd3ZXV0pSdC9J?=
 =?utf-8?B?Z3dtazRiQjlnb1djTFRKVVNueTRCaXFJaXJxd0ZabWxxd0xYTmtkU0FKZ0Qz?=
 =?utf-8?B?U0pnMVRYZDBFd1NvVmd5NS8vS09kS0VWMFU2RmI2NWdLdXR3eERtSGUrUDVs?=
 =?utf-8?B?ckRkRnpGbjFHWUFoN09UamNEdWRSendmeHdrT3AzOUNib3l2WW9hZ1Y2SWhD?=
 =?utf-8?B?NlRnSTE1SWVHVVB6OFNSYXBkMXlQYUtmc3FsNklHZWlKU0dwT08rZC9VaXpo?=
 =?utf-8?B?NkhIMkV4Nkg4a2wzTXNyVytZM21HeHo5SElDNyt5dmkvdWd4ZjJPRmRNUk5y?=
 =?utf-8?B?UjF2Tzl5cXpxVnBEWEtpcktlVkVqSU42aEs2clhEVXg2OENjbzg4VlVtNlVR?=
 =?utf-8?B?MGNocnd6VXZGOUtJdzBnQ3NDbjlCelFsRlBQbk9DMkI1SnhEN1BIcHhPUXFR?=
 =?utf-8?B?VWYrdUxRc0lxTnZ1cjR1QUlBNGJ3WEhzOXIzbW8wcjZKZGZ2Y0JSaVRJOUJo?=
 =?utf-8?B?MGN6TXZoeWV0T3ArSnp0NjlDVERSQmhuK25GTjh3bUhuMm5sUzI3VCtHeUVG?=
 =?utf-8?B?SmFqTFNrOFByZWQwcGgwRWlMQ2Evb1hJUHYwYzg5UDBzRDl1MzZncFNrOURy?=
 =?utf-8?B?RjluSktHMVNyOHpBd3F5QVdPTGJVVkh1WWVuQ1hpSkw3YzdONnlIT20ydGdI?=
 =?utf-8?B?QTBNUXRkSUQrbnJtZlBEM3FZaFNaRUtweXBZdHgrYzhMblJvUHRzNGFJSHl4?=
 =?utf-8?B?UlJVcGRWb0lWcVk2NHRJeVNPd0tubHEwSmdzNWQ0Uk5lMVNNSEF6c1pSaGRZ?=
 =?utf-8?B?V2NsZGJvSFdzWFpzUGVWS3Jnc2NyYnBnUkZtbmVnT2FzKzllbmJwbTZHMGQ1?=
 =?utf-8?B?ajJGa1hUY0hhMnRrQk1RcGYzcElpVXY3NXhEcTZvS3ZiaU9QMVVmQ09QZDhG?=
 =?utf-8?B?dU1DNU53UWdzT2xLdzh2Z0N6UGpHMll0a0NxelkvSkpOQ0g4REtIMjF3MElp?=
 =?utf-8?B?Mi95RitKWXI5VTYraHhlVzRFQ25ZZi8rQ3NEMEZlTEVoaHNJaG5sUT09?=
X-OriginatorOrg: ipetronik.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ed799b0c-8fba-4066-312f-08d9f13e16d4
X-MS-Exchange-CrossTenant-AuthSource: AM9P193MB1572.EURP193.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Feb 2022 11:18:42.5406
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 982fe058-7d80-4936-bdfa-9bed4f9ae127
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FvMAkNxoXoB92hmewYmela7pyHGLHzxelLmnB2mSKSatRND14+xRbu0xFX/HJS4DXSgYSC7JGCbQZKIuTRysttO/sP04WdSEdWg3GZyZGeo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8P193MB1413
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 15, 2022 at 08:17:31PM +0100, Christoph Hellwig wrote:
> On Mon, Feb 14, 2022 at 10:51:07AM +0100, Markus Blöchl wrote:
> > After the surprise removal of a mounted NVMe disk the pciehp task
> > reliably hangs forever with a trace similar to this one:
> 
> Do you have a specific reproducer? At least with doing a
> 
> echo 1 > /sys/.../remove
> 
> while running fsx on a file system I can't actually reproduce it.

We built our own enclosures with a custom connector to plug the disks.

So an external enclosure for thunderbolt is probably very similar.
(or just ripping an unscrewed NVMe out of the M.2 ...)

But as already suggested, qemu might also be very useful here as it also
allows us to test multiple namespaces and multipath I/O, if you/someone
wants to check those too (hotplug with multipath I/O really scares me).

