Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B7F153577B
	for <lists+linux-kernel@lfdr.de>; Fri, 27 May 2022 04:21:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234032AbiE0CVD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 May 2022 22:21:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231713AbiE0CUz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 May 2022 22:20:55 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2063.outbound.protection.outlook.com [40.107.20.63])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A601DFF49
        for <linux-kernel@vger.kernel.org>; Thu, 26 May 2022 19:20:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TredF4WBD5BkB+TyrftXNAFAG2mx2C2B1PvaBPtZ8GJ8T8yQ9bbydm3gNfIlZ69m7qRU1hZbYGBt4F2m3ukwy1j56NeTrc09OaoUIgqiPmpip27nYN9Eu/h0NO5j3p19NZ96PezDCf0EPiSFiUS2qE8j2s0SMUiGbiWIwsvOuiGwM1SYj7HPz0pj2Fwlrl1tMEoJxjNvaECO3cDbsj1UDQjZjneULIti0MY++q8Slw/lK3tzdZs/tSeTDpC6Kjvjjj2S6o0WXlz4f4852AlByp1y6RAaxNEh3zNtPuuk+AKNQwBr8E4tXWKz0K80XkABNUJBVh8RTu74LTpDsZul3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l0g5wSQGhqSfzez1yqylIO4RblPasR7mAvVDF5tZFcM=;
 b=Z6CGLoCbfEVrkj9OxyKp3g/NrpILgvqnxRBIOSOkk7QqwL7wvMDu1Wo+LvYTjdJwBq9BEUw60gBdfxw5wRBHMP73sit+qAJdFxqdmaQkCt7t0Q+4/OU9Q9mNJjjQqCiTnFu92TvcZjriekOCW2nDB0GrRYFen1fVnegI21lhhDgVt340AeA6MpvLIWqhsPqUJozbQbh46tgnBgiB8D3jx+i8kwXvPboYktfMVJ+9IVjslFydQ6re8rw3Bw5djR8UTei0j7cc7XaDHHYpP37R6WnQkQXlFBGy4vTCnFANVDAmFuEEsTqbSsezwZ6tD+cV5prkX7inYovz7mTH68iRmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l0g5wSQGhqSfzez1yqylIO4RblPasR7mAvVDF5tZFcM=;
 b=RHnurEX6wlCbfsbCJJIJvOWU3CgTmnTkqaXExRGtPuH5xeJuR58IJffMIW7BVx06Z+5Xa3pbJmKdyH2uZnVJSKRoI9r7AImz+JTB3PU7oI4uuhdqBBBP5cRsOYai6P8BMbJyz8FESoseFhFhgix3Vq/y+Wqb1Ci8llcXb+7cO2s=
Received: from AM6PR04MB6407.eurprd04.prod.outlook.com (2603:10a6:20b:d9::10)
 by AM5PR0402MB2913.eurprd04.prod.outlook.com (2603:10a6:203:9a::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5293.13; Fri, 27 May
 2022 02:20:50 +0000
Received: from AM6PR04MB6407.eurprd04.prod.outlook.com
 ([fe80::c10d:df80:bee4:891e]) by AM6PR04MB6407.eurprd04.prod.outlook.com
 ([fe80::c10d:df80:bee4:891e%5]) with mapi id 15.20.5293.013; Fri, 27 May 2022
 02:20:50 +0000
From:   Manjunatha Venkatesh <manjunatha.venkatesh@nxp.com>
To:     Greg KH <gregkh@linuxfoundation.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "will@kernel.org" <will@kernel.org>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        "mb@lightnvm.io" <mb@lightnvm.io>,
        "ckeepax@opensource.cirrus.com" <ckeepax@opensource.cirrus.com>,
        "mst@redhat.com" <mst@redhat.com>,
        "javier@javigon.com" <javier@javigon.com>,
        "mikelley@microsoft.com" <mikelley@microsoft.com>,
        "jasowang@redhat.com" <jasowang@redhat.com>,
        "sunilmut@microsoft.com" <sunilmut@microsoft.com>,
        "bjorn.andersson@linaro.org" <bjorn.andersson@linaro.org>,
        "rvmanjumce@gmail.com" <rvmanjumce@gmail.com>,
        Ashish Deshpande <ashish.deshpande@nxp.com>
Subject: RE: [EXT] Re: [PATCH v3] [PATCH v3] uwb: nxp: sr1xx: UWB driver
 support for sr1xx series chip
Thread-Topic: [EXT] Re: [PATCH v3] [PATCH v3] uwb: nxp: sr1xx: UWB driver
 support for sr1xx series chip
Thread-Index: AQHYX9ps1KkzJWf0/0iPw/iG6eo9xK0QqrIAgCFh/iA=
Date:   Fri, 27 May 2022 02:20:50 +0000
Message-ID: <AM6PR04MB6407EAA64AC011F2F1F431998FD89@AM6PR04MB6407.eurprd04.prod.outlook.com>
References: <20220504171337.3416983-1-manjunatha.venkatesh@nxp.com>
 <YnQjhoVsaI6IteIe@kroah.com>
In-Reply-To: <YnQjhoVsaI6IteIe@kroah.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 10c3ae18-210a-42f6-4318-08da3f87846f
x-ms-traffictypediagnostic: AM5PR0402MB2913:EE_
x-microsoft-antispam-prvs: <AM5PR0402MB29133B28846C7C49CB038A228FD89@AM5PR0402MB2913.eurprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: DI3zgyVAz4BMewWJ/drzhk0gGYrsolF70/wTWQAoE5Z064K2/EPXNVpwffVke/lFmeX9BIYyEhWVXHQagK4Rj/ZlHiSZZROoZuFsXSKo+VocGEIdnwuFnArnLeKTg8/RXx+3atI8me7QYpXAMjyzFbFuYQ26Y5jhLhHFASnAwuWHoMpgYjbkbDdDHYQISSCUGWLscGjcbKt77ZbxYDg3p+C1C11xmA8opRYfk9IwUpyK4UTG2tE06iv+uHjYSF/CSqvEc17rC/O4LKKa/TDT31qwpy7lftdSAcxfNtfT0l0/tBrnU8bNAzQdibt/6oKHBfmoMTkbPfphd7lnBrIrfGkaFF6fYwCiDOZOx/TIqbtP9VaaEFi8pTqhzX140Q4bHq8kZlGd0w1hZPSdOU1z4Hbox0V3Fm+60IGzOGGs1Z2fSC8Z30e4B4DTb4o8Jkd1Dx8QGs9kBBi6ZHHbCJ/OsEh8DBw+cu4U9b5BcWw1pmEkM8Maf4U59hB1lgrErlCFO2FFNyShXVAXAENWeTash7xuUYhIyiwSqy7KVn5UVNme7Cc+XcYf+OIWP88KHmA/TBKS1KS+1akSgJCt2DpJSu2ojmK8jcnYye9+/VkZ9WweIcckv5TupR9iu4arRl/wAyF7+kFw6SbbRS86Eq9rskjjMVnfWdtYdK3vgldPdTnv7KRHf1NRKz3dm1IKUIheT48qmT8LI2l0ZckcPKsF+3/5ibUPCefVFc6TETZPFlr0j99s1iV2y+wnzw0XMkmiIzQXDXR+9FjD7CxHFlJuO7PYQ+YhPPgeTiL6+57GRSwcM0n4Nt32gSiY2/OoX3PKpH38OSIJ3AJfPIzROVJogVIjV5rQa4IhvB+84slj0tBWICljK4xIJWrh8uTk5nsE
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB6407.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(30864003)(966005)(45080400002)(2906002)(44832011)(7416002)(6506007)(52536014)(8936002)(316002)(7696005)(86362001)(76116006)(8676002)(55016003)(4326008)(66556008)(66946007)(55236004)(53546011)(26005)(508600001)(9686003)(66446008)(66476007)(64756008)(38070700005)(71200400001)(33656002)(54906003)(122000001)(6916009)(38100700002)(83380400001)(186003)(99936003)(5660300002)(32563001)(473944003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?9BZuAW2sOwKVPtRdNlAl6Kc7zrfCSFU3i0e+CEL5vIyucD+9/y7Gu1KK83q0?=
 =?us-ascii?Q?5ee2drg5QDm2quVsAe9VdkpLQ0JPpEjJcoBUxVLyQM+TDDpfj7sBimAWEygV?=
 =?us-ascii?Q?q7qNaSGiE/FJMBs8fWOSpIPMzY7B8LN0OOyQmPedQnxsFQq7QW5WQe+aZ7ji?=
 =?us-ascii?Q?gpzOwp2SGFH5dkI83ENe4O5THMbDDOmAiDti0WjkSbuDyQflsKnsaV2Zb4i/?=
 =?us-ascii?Q?B3Y/TQNccmbJQfzuQwd3ZLCrLVxIEkHd/JRCJjicZJs15RJIUETzMfxr6Tjh?=
 =?us-ascii?Q?TtteeDvMr3JjcdIbgbY6cSlwYi9cCEtfklgia4sFqH7aH4yns7TA3MHUO2Ia?=
 =?us-ascii?Q?KPqYTnw8onhahNymdTtmrblKGk5/1YQhPN475eCkUW9MVLc2yeJ95VcEcfXW?=
 =?us-ascii?Q?QFI8wSGAcSEq5FghHDyDRdgmHMU4qrS/JpBSB2ptbZ49FG/YKw2tt5XyPerl?=
 =?us-ascii?Q?PDWH186uEsC+bqtoP1p3BBSLldmvIxgxFcs4Lev6JXfmLA1s7oRVcAxQSHdi?=
 =?us-ascii?Q?ZzGwEC/D3brufm+WiaPqnGwTbzCuZ6aOeSDH22XM9hHD8hdTlSJUae8uWaPd?=
 =?us-ascii?Q?C4WX3kLAtt9lHrIEHByAnYWuikiK/mQMT5vdBajTmCNoQAR1viXzH2h6Igz7?=
 =?us-ascii?Q?myQt1I1cZxo9B6j0FZkztdLDMmjBHKPDpqPre+lomJHrOJPpzplYYXrbUyT6?=
 =?us-ascii?Q?JZl4phZG8YVjJ8A7UgW0RAAEDNN1xvuO4aITjmYMTiT6sMetWEJICHme+IcZ?=
 =?us-ascii?Q?qDvAe8WxOeqsNoGOvnEydJ3Mh52KvolfKOl5I3m59Yu6Dq+C8d/CHNRVnWrK?=
 =?us-ascii?Q?W3bp31/eva4CHfJrfzWYmFEUii2M0ebDPInysGYop7DKr0k9S4+5Q2epfEI6?=
 =?us-ascii?Q?62S//st4iNL6+sq0zvS7ftOPMHoPoSpgaSfVYwBhSwNaeJOKSviWwUkxGo2u?=
 =?us-ascii?Q?NzixL34yeOIiOrcU89Ra07YKsS3AKQN8Xi/LUWMw0TvUZjnniIqDXRKxw2j1?=
 =?us-ascii?Q?2WFzqjnStbTqep/qdlym7wJbron147n8l1Ls9p7tOYe5M9q62Wvd4nBUOUiO?=
 =?us-ascii?Q?8944v3kt80QIeo9xnNjXHogbC9TNZx4lV5i0978E8HzYS0alHQs0FK1XgN5G?=
 =?us-ascii?Q?JzwfLD5BJiFxhSmCZIUL94A46ZweGl4KwNbwgLMWwCPZwmvq2cfO4GYDYUaM?=
 =?us-ascii?Q?lIr6KJWxbDCTpqcglIQMr/hxgi0mgdikWve+OESbK1IMTmMfAUWOd5uu5sA8?=
 =?us-ascii?Q?zyjqSrIVxtTtehJtpGeV3AFB6C/2JMqWtW00kshYQmdiULv0yZ+Bkp5bRxUS?=
 =?us-ascii?Q?Ipx5WStz4M/5HU0tY+BqricE3f6bUWe+rZJghKj9U96ylTrGzIJdezH6MHKF?=
 =?us-ascii?Q?ohf0losSWaX36tdHYiqMksMMrjD4L0OC3eBXNmXGxMTksDMMUvVvRaiuLx+1?=
 =?us-ascii?Q?MV0WWq75GYxpag8pHlJAoDFQwzWbHXHH+jgIg7wzWMo5LFdpFrmvU1v6UvQF?=
 =?us-ascii?Q?MjnlktK0ODbIDO82gqLT/QWf2GfZfyEhtImKJzVs7s6C1eP5/+X3RsMyMk79?=
 =?us-ascii?Q?bjjoz3WERli3mLTEwtOXa4KcKoEfEnudc6MTZl/D2NVeLJUj0p2Se4igfvjy?=
 =?us-ascii?Q?tPWvof/YrpKGx8jb7+MQaMHL2pecSFoUjKrUqxnoad7Q/KE/eN0S+Im6jmwA?=
 =?us-ascii?Q?t7WL9xjiBts2LsiZ6Db1F0mLQiEGCU0iQFiXfggSr7/VduO83isGgNahKrb5?=
 =?us-ascii?Q?s2mph/moIc2eILz7cGfLPE0vZQT3YkE=3D?=
Content-Type: multipart/signed;
        protocol="application/x-pkcs7-signature";
        micalg=SHA1;
        boundary="----=_NextPart_000_000F_01D8719E.799D6800"
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB6407.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 10c3ae18-210a-42f6-4318-08da3f87846f
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 May 2022 02:20:50.1209
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1/AnQIpMF0HdsAQ/Fy0NPUN6x6SOpfqBpJQOlfJxkyW8QVhMPLCMUD384a+T3TocpL+faPa2pxYlA/N9rkciij1KIaVoEEYOFw52W13mrOc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR0402MB2913
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

------=_NextPart_000_000F_01D8719E.799D6800
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit



> -----Original Message-----
> From: Greg KH <gregkh@linuxfoundation.org>
> Sent: Friday, May 6, 2022 12:51 AM
> To: Manjunatha Venkatesh <manjunatha.venkatesh@nxp.com>
> Cc: linux-kernel@vger.kernel.org; will@kernel.org; axboe@kernel.dk;
> mb@lightnvm.io; ckeepax@opensource.cirrus.com; mst@redhat.com;
> javier@javigon.com; mikelley@microsoft.com; jasowang@redhat.com;
> sunilmut@microsoft.com; bjorn.andersson@linaro.org;
> rvmanjumce@gmail.com; Ashish Deshpande <ashish.deshpande@nxp.com>
> Subject: [EXT] Re: [PATCH v3] [PATCH v3] uwb: nxp: sr1xx: UWB driver
> support for sr1xx series chip
> 
> Caution: EXT Email
> 
> On Wed, May 04, 2022 at 10:43:37PM +0530, Manjunatha Venkatesh wrote:
> > Ultra-wideband (UWB) is a short-range wireless communication protocol
> >
> > sr1xx is a new driver that supports the integrated UWB for Nxp SoCs,
> > especially the sr1xx series and depends on the SPI module.
> >
> > sr1xx driver works with Nxp UWB Subsystem(UWBS) which is FiRa
> Complaint.
> 
> What is the Nxp UWBS and where can it be found?  You have custom ioctls
> here with no public user so we really can't take them, right?
> 
 The sr1xx driver work the SR1XX Family of UWBS, and uses UWB Controller
 Interface (UCI).  The corresponding details are available in the FiRa
 Consortium Website (https://www.firaconsortium.org/).
                    The IOCTLs are used to,
                    1. Switch between and control communication to UWBS in
HBCI and UCI Mode
                    2. Reset control from user space need custom IOCTL

> > Corresponding UCI details available in Fira Consortuim website.
> 
> Have a link for this?
> 
Yes, Its available in the FiRa Consortium Website
(https://www.firaconsortium.org/)

> > sr1xx is flash less device  and it requires firmware download on every
> > device boot.
> 
> Too many spaces in that sentence?
> 
> Lots of devices need firmware, that's not a big deal if you are using the
> firmware api, right?  Wait, you are not using that api, so how is the
firwmare
> being downloaded?
> 
The HBCI Mode (sr1xx BootROM Code Interface) is used both to access low
level information from ROM which would be interesting to User Space,
as well as upload new Firmware to the RAM of the UWBS and same
sequence need to follow on every reboot(Since its flash less device).
Having 3 types of communication (HBCI, UCI, linux firmware download)
potentially  
       adds extra complexity in maintenance, and hence limiting the
interfaces.
 

> > Internally driver will handle two modes of operation.
> > 1.HBCI mode (sr1xx BootROM Code Interface)
> >   Firmware download uses HBCI ptotocol packet structure which is
> >   Nxp proprietary,Firmware File(.bin) stored in user space context
> >   and during device init sequence pick the firmware packet in chunk
> >   and send it to the driver with write() api call.
> 
> That's not ok, use the standard in-kernel firmware download api please.
> 
Clarified in previous comment

> >   Firmware acknowledge for every chunk packet sent and same thing
> >   is monitored,in user space code(HAL layer).
> 
> What does a HAL layer have to do with anything here?
>
Re-clarified / briefly mentioned that payload is processed in User Space.  
(details on what is happening in User Space is not coupled with this
discussion. 
Sorry for confusing by introducing HAL layer in this thread).
 
> >   If any error Firmware download sequence will fail and reset the
device.
> >   If firmware download packet sent successfully at the end device will
> >   send device status notification and its indication of device entered
> >   UCI mode.Here after any command/response/notification will follow
> >   UCI packet structure.
> 
> Again, just use the normal fiwmare download logic and you will not need to
> worry about any of the above.  For obvious reasons you don't want us to
> take a custom firmware api for every individual device that Linux supports
as
> that would be crazy :)
> 
Agreed but users of SR1XX UWBS would like to use low level
HBCI Mode of communication as well and hence driver would get more
Complicated if we use 3 different modes of communication 
(UCI, HCI, firmware download).

> > 2.UCI mode (UWB Command interface)
> >   Once Firmware download finishes sr1xx will switch to UCI mode packet
> >   structure.Here this driver exchange command/response between user
> space
> >   and sr1xx device.
> 
> Please have someone proof read this changelog before you resend.
>
Yes, will get it reviewed internally before next patch submission.
 
> >   Any response or notification received from sr1xx through SPI line
> >   will convey to user space.User space(UCI lib) will take care of
> >   UCI parsing logic.
> 
> As I said when we met to talk about this driver, why do you have a custom
> api/interface at all?  Why can you not just use the normal user/kernel api
for
> SPI devices?
> 
> You should not need any read/write/ioctl api for this driver at all, it's
just a
> simple spi driver from what I can tell.  This should not be complex to
> implement at all.
>
The IO Handshake needed with SR1XX Family of SOCs cannot use the RAW SPI
Module's APIs and hence custom APIs are added for communication with the
UWBS,
With this will get required throughput for UWBS use cases to  avoid multiple
round trip between user  and kernel mode.
 
> >   Its IRQ based driver and sr1xx specific irq handshake mechanism logic
> >   implemented to avoid any race condition between write and read
> >   during ranging sequence.
> 
> I do not understand this sentence at all, sorry.
> 
Reworded the description of the patch message.

> >   UCI mode Write is same as HBCI mode sequence whatever command
> received
> >   from user space will send to the sr1xx via SPI line.
> >   In UCI mode read api called first and waiting on the IRQ line status
> >   in order to avoid missing of interrupts after write sequence.
> >
> >   This driver needs dts config update as per the sr1xx data sheet.
> >   Corresponding document will be added in
> >   Documentation/devicetree/bindings/uwb
> 
> We can not take drivers with dts requirements without the dts updates as
> well, as you know.  Please make that the first patch in the series and
properly
> cc: the needed DT maintainers.  For that reason alone I couldn't take this
> patch if I wanted to.
>
Yes, Will commit the device tree document before next driver patch
submission.
 
> > Link:
> > https://eur01.safelinks.protection.outlook.com/?url=https%3A%2F%2Flore
> > .kernel.org%2Fr%2F20220315105205.2381997-1-
> manjunatha.venkatesh%40nxp.
> >
> com&amp;data=05%7C01%7Cmanjunatha.venkatesh%40nxp.com%7C8e62ec
> ff820c45
> >
> dd323508da2ee73a4f%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C1%7
> C637873
> >
> 867912779711%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJ
> QIjoiV2luM
> >
> zIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C2000%7C%7C%7C&amp;sdata=nlJ
> 91nGGyk
> > CapiWWaze8doyEOIGD37CH36YKCVktkfI%3D&amp;reserved=0
> 
> What is this a link to?
> 
As part of commit message given correct link as shown below but somehow its
showing differently after submission.
Link:
https://lore.kernel.org/r/20220315105205.2381997-1-manjunatha.venkatesh@nxp.
com

> > Signed-off-by: Manjunatha Venkatesh <manjunatha.venkatesh@nxp.com>
> > ---
> 
> You forgot to list what changed from previous versions below the --- line
like
> the documentation asks you to do.  Please fix that for the next
submission.
> My patch bot normally would just reject the change for that reason alone,
> documentation matters :)
> 
> 
Yes, Will correct this in the next patch submission

> >  MAINTAINERS               |   6 +
> >  drivers/misc/Kconfig      |  15 +
> >  drivers/misc/Makefile     |   1 +
> >  drivers/misc/sr1xx.c      | 784
> ++++++++++++++++++++++++++++++++++++++
> >  include/uapi/misc/sr1xx.h |  79 ++++
> >  5 files changed, 885 insertions(+)
> >  create mode 100644 drivers/misc/sr1xx.c  create mode 100644
> > include/uapi/misc/sr1xx.h
> >
> > diff --git a/MAINTAINERS b/MAINTAINERS index
> > edc96cdb85e8..2896d401dbc4 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -21888,3 +21888,9 @@ S:    Buried alive in reporters
> >  T:   git
git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
> >  F:   *
> >  F:   */
> > +
> > +UWB
> 
> Note, this is NOT generic UWB.  This is a single spi device driver, right?
> 
Yes, Will correct this in the next patch submission

> > +M:   manjunatha.venkatesh@nxp.com
> 
> No real name?
> 
Yes, Will update this in the next patch submission
> > +S:   Maintained
> > +F:   drivers/misc/sr1xx.c
> > +F:   include/uapi/misc/sr1xx.h
> 
> Please read the top of this file for how to correctly find where to place
your
> new entry.
> 
Yes, Will update this in the next patch submission

> > diff --git a/drivers/misc/Kconfig b/drivers/misc/Kconfig index
> > 41d2bb0ae23a..1ca97d168f26 100644
> > --- a/drivers/misc/Kconfig
> > +++ b/drivers/misc/Kconfig
> > @@ -483,6 +483,21 @@ config OPEN_DICE
> >
> >         If unsure, say N.
> >
> > +config NXP_UWB
> > +        tristate "Nxp UCI(Uwb Command Interface) protocol driver
support"
> > +        depends on SPI
> > +        help
> > +        This option enables the UWB driver for Nxp sr1xx
> > +        device. Such device supports UCI packet structure,
> > +        FiRa complaint.
> > +
> > +
> > +
> > +        Say Y here to compile support for sr1xx into the kernel or
> > +        say M to compile it as a module. The module will be called
> > +        sr1xx.ko
> > +
> > +
> 
> Why all the extra blank lines?
> 
> And are you sure you indented the help properly?  Why no tabs like the
rest
> of this file?  Did you run checkpatch.pl on your patch first?
> 
>
Yes, run check patch tool but didn't caught any warnings, anyway will cross
check this and will correct it in next patch submission.
 
> >  source "drivers/misc/c2port/Kconfig"
> >  source "drivers/misc/eeprom/Kconfig"
> >  source "drivers/misc/cb710/Kconfig"
> > diff --git a/drivers/misc/Makefile b/drivers/misc/Makefile index
> > 70e800e9127f..bbd4dd17cabc 100644
> > --- a/drivers/misc/Makefile
> > +++ b/drivers/misc/Makefile
> > @@ -60,3 +60,4 @@ obj-$(CONFIG_XILINX_SDFEC)  += xilinx_sdfec.o
> >  obj-$(CONFIG_HISI_HIKEY_USB) += hisi_hikey_usb.o
> >  obj-$(CONFIG_HI6421V600_IRQ) += hi6421v600-irq.o
> >  obj-$(CONFIG_OPEN_DICE)              += open-dice.o
> > +obj-$(CONFIG_NXP_UWB)                += sr1xx.o
> > diff --git a/drivers/misc/sr1xx.c b/drivers/misc/sr1xx.c new file mode
> > 100644 index 000000000000..100c36031fd2
> > --- /dev/null
> > +++ b/drivers/misc/sr1xx.c
> > @@ -0,0 +1,784 @@
> > +// SPDX-License-Identifier: GPL-2.0-only
> > +/*
> > + * SPI driver for UWB SR1xx
> > + * Copyright (C) 2018-2022 NXP.
> > + *
> > + * Author: Manjunatha Venkatesh <manjunatha.venkatesh@nxp.com>  */
> > +#include <linux/kernel.h> #include <linux/miscdevice.h> #include
> > +<linux/module.h> #include <linux/mutex.h> #include <linux/spinlock.h>
> > +#include <linux/delay.h> #include <linux/fs.h> #include
> > +<linux/gpio.h> #include <linux/init.h> #include <linux/interrupt.h>
> > +#include <linux/io.h> #include <linux/irq.h> #include
> > +<linux/jiffies.h> #include <linux/list.h> #include <linux/of_gpio.h>
> > +#include <linux/platform_device.h> #include <linux/device.h> #include
> > +<linux/poll.h> #include <linux/regulator/consumer.h> #include
> > +<linux/sched.h> #include <linux/slab.h> #include <linux/spi/spi.h>
> > +#include <linux/uaccess.h> #include <uapi/misc/sr1xx.h>
> 
> Do you really need all of these?  If so, great, but I think that's way too
many
> for a simple driver like this.
> 
> 
Cross verified this list and only few required from this list and will
update
the same in the next driver patch submission

> > +
> > +static int sr1xx_dev_open(struct inode *inode, struct file *filp) {
> > +     struct sr1xx_dev *sr1xx_dev = container_of(
> > +             filp->private_data, struct sr1xx_dev, sr1xx_device);
> 
> Odd line break, please run checkpatch.pl.
> 
> I'm not going to review the driver contents based on my above comments as
> this needs lots of reworking and most of the code here can go away.
>
Yes, Will cross check these things before next driver patch submission
 
> One meta-comment though, your uapi .h file:
> 
> > --- /dev/null
> > +++ b/include/uapi/misc/sr1xx.h
> > @@ -0,0 +1,79 @@
> > +/* SPDX-License-Identifier: GPL-2.0-only
> > + *
> > + * Header file for UWB sr1xx device
> > + * Copyright (C) 2018-2022 NXP.
> > + *
> > + * Author: Manjunatha Venkatesh <manjunatha.venkatesh@nxp.com>  */
> > +
> > +#include <linux/types.h>
> > +
> > +#define SR1XX_MAGIC 0xEA
> > +#define SR1XX_SET_PWR _IOW(SR1XX_MAGIC, 0x01, long) #define
> > +SR1XX_SET_FWD _IOW(SR1XX_MAGIC, 0x02, long)
> > +
> > +#define UCI_HEADER_LEN 4
> > +#define HBCI_HEADER_LEN 4
> > +#define UCI_PAYLOAD_LEN_OFFSET 3
> > +
> > +#define UCI_EXT_PAYLOAD_LEN_IND_OFFSET 1 #define
> > +UCI_EXT_PAYLOAD_LEN_IND_OFFSET_MASK 0x80 #define
> > +UCI_EXT_PAYLOAD_LEN_OFFSET 2
> > +
> > +#define SR1XX_TXBUF_SIZE 4200
> > +#define SR1XX_RXBUF_SIZE 4200
> > +#define SR1XX_MAX_TX_BUF_SIZE 4200
> > +
> > +#define MAX_RETRY_COUNT_FOR_IRQ_CHECK 100 #define
> > +MAX_RETRY_COUNT_FOR_HANDSHAKE 1000
> > +
> > +/* Macro to define SPI clock frequency */ #define SR1XX_SPI_CLOCK
> > +16000000L #define WAKEUP_SRC_TIMEOUT (2000)
> > +
> > +/* Maximum UCI packet size supported from the driver */ #define
> > +MAX_UCI_PKT_SIZE 4200
> > +
> > +struct sr1xx_spi_platform_data {
> > +     unsigned int irq_gpio; /* SR1XX will interrupt host for any ntf */
> > +     unsigned int ce_gpio; /* SW reset gpio */
> > +     unsigned int spi_handshake_gpio; /* Host ready to read data */
> > +};
> > +
> > +/* Device specific macro and structure */ struct sr1xx_dev {
> > +     wait_queue_head_t read_wq; /* Wait queue for read interrupt */
> > +     struct spi_device *spi; /* Spi device structure */
> > +     struct miscdevice sr1xx_device; /* Char device as misc driver */
> > +     unsigned int ce_gpio; /* SW reset gpio */
> > +     unsigned int irq_gpio; /* SR1XX will interrupt host for any ntf */
> > +     unsigned int spi_handshake_gpio; /* Host ready to read data */
> > +     bool irq_enabled; /* Flag to indicate disable/enable irq sequence
*/
> > +     bool irq_received; /* Flag to indicate that irq is received */
> > +     spinlock_t irq_enabled_lock; /* Spin lock for read irq */
> > +     unsigned char *tx_buffer; /* Transmit buffer */
> > +     unsigned char *rx_buffer; /* Receive buffer */
> > +     unsigned int write_count; /* Holds nubers of byte written */
> > +     unsigned int read_count; /* Hold nubers of byte read */
> > +     struct mutex
> > +             sr1xx_access_lock; /* Lock used to synchronize read and
write */
> > +     size_t total_bytes_to_read; /* Total bytes read from the device */
> > +     bool is_extended_len_bit_set; /* Variable to check ext payload Len
*/
> > +     bool read_abort_requested; /* Used to indicate read abort request
*/
> > +     bool is_fw_dwnld_enabled; /* Used to indicate fw download mode */
> > +     int mode; /* Indicate write or read mode */
> > +     long timeout_in_ms; /* Wait event interrupt timeout in ms */ };
> > +
> > +/* Power enable/disable and read abort ioctl arguments */ enum {
> > +PWR_DISABLE = 0, PWR_ENABLE, ABORT_READ_PENDING };
> > +
> > +enum spi_status_codes {
> > +     TRANSCEIVE_SUCCESS,
> > +     TRANSCEIVE_FAIL,
> > +     IRQ_WAIT_REQUEST,
> > +     IRQ_WAIT_TIMEOUT
> > +};
> > +
> > +/* Spi write/read operation mode */
> > +enum spi_operation_modes { SR1XX_WRITE_MODE,
> SR1XX_READ_MODE };
> 
> 
> You have loads of things in here that should NOT be exposed to userspace
at
> all (your structure?)
> 
> Does this even build properly if you have the header check build option
> enabled?  I would be amazed if it did.
> 
> Anyway, you do not need a uapi .h file from what I can tell, so it
shouldn't be
> needed for your next version.
> 
Yes, Will remove this header file and move all this contents to .c file
itself in the next patch submission.

> thanks,
> 
> greg k-h

------=_NextPart_000_000F_01D8719E.799D6800
Content-Type: application/pkcs7-signature;
	name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
	filename="smime.p7s"

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
AS2GgchsZGFwOi8vL0NOPU5YUCUyMEVudGVycHJpc2UlMjBDQSUyMDUsQ049TkxBTVNQS0kwMDA1
LENOPUNEUCxDTj1QdWJsaWMlMjBLZXklMjBTZXJ2aWNlcyxDTj1TZXJ2aWNlcyxDTj1Db25maWd1
cmF0aW9uLERDPXdiaSxEQz1ueHAsREM9Y29tP2NlcnRpZmljYXRlUmV2b2NhdGlvbkxpc3Q/YmFz
ZT9vYmplY3RDbGFzcz1jUkxEaXN0cmlidXRpb25Qb2ludIYvaHR0cDovL253dy5wa2kubnhwLmNv
bS9jcmwvTlhQRW50ZXJwcmlzZUNBNS5jcmyGL2h0dHA6Ly93d3cucGtpLm54cC5jb20vY3JsL05Y
UEVudGVycHJpc2VDQTUuY3JsMIIBEAYIKwYBBQUHAQEEggECMIH/MIG7BggrBgEFBQcwAoaBrmxk
YXA6Ly8vQ049TlhQJTIwRW50ZXJwcmlzZSUyMENBJTIwNSxDTj1BSUEsQ049UHVibGljJTIwS2V5
JTIwU2VydmljZXMsQ049U2VydmljZXMsQ049Q29uZmlndXJhdGlvbixEQz13YmksREM9bnhwLERD
PWNvbT9jQUNlcnRpZmljYXRlP2Jhc2U/b2JqZWN0Q2xhc3M9Y2VydGlmaWNhdGlvbkF1dGhvcml0
eTA/BggrBgEFBQcwAoYzaHR0cDovL253dy5wa2kubnhwLmNvbS9jZXJ0cy9OWFAtRW50ZXJwcmlz
ZS1DQTUuY3J0MA0GCSqGSIb3DQEBCwUAA4IBAQCXkrEk/n54wjg2JrtcnTKg0LPqXzR1CR+L3OI6
4anIZ8etcCMkKecXBWNVGjTEBzF+WrMeLQdupFJrZnntBqibo1+1cM1DOG6QkG1n+kq7JDRsl4Ty
jHWp6v1xuV+4QwIkKHURPiePWpanLrGRiUSYosUDoh4Sc93LFb6gc8PSYe115oWVYeMjWhnnl+Sg
LMXlZ6DtPU/lOO+wjAG7VW4Q9zNUtoDPLgobOZRulywDgkEc2qDHSvmYneia+OMDeLiCtgtazTMx
lZvYHOYvRtQRoj/P/Zu57jhRaBncmbkEKKdVwFddNEhzUoeY8wyO6IMEXVIYycd2jaDxZoe/UFRS
MIIH/zCCBuegAwIBAgITLQAHTNY9heLFOPC4lgAAAAdM1jANBgkqhkiG9w0BAQsFADCBtjEcMBoG
A1UEAwwTTlhQIEVudGVycHJpc2UgQ0EgNTELMAkGA1UECwwCSVQxETAPBgNVBAoMCE5YUCBCLlYu
MRIwEAYDVQQHDAlFaW5kaG92ZW4xFjAUBgNVBAgMDU5vb3JkLUJyYWJhbnQxEzARBgoJkiaJk/Is
ZAEZFgN3YmkxEzARBgoJkiaJk/IsZAEZFgNueHAxEzARBgoJkiaJk/IsZAEZFgNjb20xCzAJBgNV
BAYTAk5MMB4XDTIxMTIyNzE0MjkwNVoXDTIzMTIyNzE0MjkwNVowgZoxEzARBgoJkiaJk/IsZAEZ
FgNjb20xEzARBgoJkiaJk/IsZAEZFgNueHAxEzARBgoJkiaJk/IsZAEZFgN3YmkxDDAKBgNVBAsT
A05YUDELMAkGA1UECxMCSU4xFjAUBgNVBAsTDU1hbmFnZWQgVXNlcnMxEzARBgNVBAsTCkRldmVs
b3BlcnMxETAPBgNVBAMTCG54cDY3MzQwMIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEA
p7zXO6Xoj+J9wqA4JA8F5Im0yO25omqi0gPQnLONC50qyK5UvkMOdQuLKXNGrL17YiQTZ8eC60j1
cwrauplXCP0X+g6o9s37Zij2uyW0CJN6wO5vvxagPrxRUUmK0GcQS+7R54VPnmv6gddxZyZ1hR1t
YaQOWDjFHdikN9ftfHZoiPPrzKkyKfqWLnzaPg5+w7jeTsMX9bn5plCYL6gLr5NfwxyXX1bfzQXs
iZpnFkSmNE1zQ6lQyFs468skEfXSLwzfnjD8kNKeS42uWUoU+QOBQKH+piDoCiORxSE9uH/2SLGz
lcjHuDQVVG8Rc9eNq9VBCRXTlSCDKBmiokrelQIDAQABo4IEHjCCBBowPAYJKwYBBAGCNxUHBC8w
LQYlKwYBBAGCNxUIhYLAfoGO9FWG7YU4guuZS5qSVj+F5opuhLXhfgIBZAIBOjATBgNVHSUEDDAK
BggrBgEFBQcDBDAOBgNVHQ8BAf8EBAMCBSAwDAYDVR0TAQH/BAIwADAbBgkrBgEEAYI3FQoEDjAM
MAoGCCsGAQUFBwMEMIGUBgkqhkiG9w0BCQ8EgYYwgYMwCwYJYIZIAWUDBAEqMAsGCWCGSAFlAwQB
LTALBglghkgBZQMEARYwCwYJYIZIAWUDBAEZMAsGCWCGSAFlAwQBAjALBglghkgBZQMEAQUwCgYI
KoZIhvcNAwcwBwYFKw4DAgcwDgYIKoZIhvcNAwICAgCAMA4GCCqGSIb3DQMEAgICADBVBgNVHREE
TjBMoCwGCisGAQQBgjcUAgOgHgwcbWFuanVuYXRoYS52ZW5rYXRlc2hAbnhwLmNvbYEcbWFuanVu
YXRoYS52ZW5rYXRlc2hAbnhwLmNvbTAdBgNVHQ4EFgQUdH4BRLKqLMTKyMlAAYTawrUaIeYwHwYD
VR0jBBgwFoAUWJVg7k5072Uiqr3tGakreo4XnQcwggFGBgNVHR8EggE9MIIBOTCCATWgggExoIIB
LYaByGxkYXA6Ly8vQ049TlhQJTIwRW50ZXJwcmlzZSUyMENBJTIwNSxDTj1OTEFNU1BLSTAwMDUs
Q049Q0RQLENOPVB1YmxpYyUyMEtleSUyMFNlcnZpY2VzLENOPVNlcnZpY2VzLENOPUNvbmZpZ3Vy
YXRpb24sREM9d2JpLERDPW54cCxEQz1jb20/Y2VydGlmaWNhdGVSZXZvY2F0aW9uTGlzdD9iYXNl
P29iamVjdENsYXNzPWNSTERpc3RyaWJ1dGlvblBvaW50hi9odHRwOi8vbnd3LnBraS5ueHAuY29t
L2NybC9OWFBFbnRlcnByaXNlQ0E1LmNybIYvaHR0cDovL3d3dy5wa2kubnhwLmNvbS9jcmwvTlhQ
RW50ZXJwcmlzZUNBNS5jcmwwggEQBggrBgEFBQcBAQSCAQIwgf8wgbsGCCsGAQUFBzAChoGubGRh
cDovLy9DTj1OWFAlMjBFbnRlcnByaXNlJTIwQ0ElMjA1LENOPUFJQSxDTj1QdWJsaWMlMjBLZXkl
MjBTZXJ2aWNlcyxDTj1TZXJ2aWNlcyxDTj1Db25maWd1cmF0aW9uLERDPXdiaSxEQz1ueHAsREM9
Y29tP2NBQ2VydGlmaWNhdGU/YmFzZT9vYmplY3RDbGFzcz1jZXJ0aWZpY2F0aW9uQXV0aG9yaXR5
MD8GCCsGAQUFBzAChjNodHRwOi8vbnd3LnBraS5ueHAuY29tL2NlcnRzL05YUC1FbnRlcnByaXNl
LUNBNS5jcnQwDQYJKoZIhvcNAQELBQADggEBAIWDtPl3vqfcKFS2gAim5XDqwJCsCxOZa5mmK/Vt
w24BwnWwW70GekjvhLB8PztMeH062TygwPEinQWs2hzkI+3zx+aSXKZ9DKNbAFTpgE8er/oOHxdp
InmBKbUc6bKyhoL375CqXFKmxURMBrd8Br6E2oohwiaXXrrF0xwpRvMJnmwOWJqjWQ8Ylfkk2vw9
qxljFjmJIwoFg8AcZSUUZkreafnQD1J0eX+uFJ0rnFGhhm0I0jaH1U3UPQzYXHQ2z4pqPUgQnKSH
cBoxU7I6BAsmYD28hrMz4rExkDduHu0TjjW+dIWZRC++mf2BzxKu/dUZMsm/ThrpWN6r9QHgUIEx
ggSzMIIErwIBATCBzjCBtjEcMBoGA1UEAwwTTlhQIEVudGVycHJpc2UgQ0EgNTELMAkGA1UECwwC
SVQxETAPBgNVBAoMCE5YUCBCLlYuMRIwEAYDVQQHDAlFaW5kaG92ZW4xFjAUBgNVBAgMDU5vb3Jk
LUJyYWJhbnQxEzARBgoJkiaJk/IsZAEZFgN3YmkxEzARBgoJkiaJk/IsZAEZFgNueHAxEzARBgoJ
kiaJk/IsZAEZFgNjb20xCzAJBgNVBAYTAk5MAhMtAAauTLON50nAGANuAAAABq5MMAkGBSsOAwIa
BQCgggK5MBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTIyMDUyNzAy
MjA0NlowIwYJKoZIhvcNAQkEMRYEFC1geM9QddgSjCe7MqbMd8QfRWurMIGTBgkqhkiG9w0BCQ8x
gYUwgYIwCwYJYIZIAWUDBAEqMAsGCWCGSAFlAwQBFjAKBggqhkiG9w0DBzALBglghkgBZQMEAQIw
DgYIKoZIhvcNAwICAgCAMA0GCCqGSIb3DQMCAgFAMAcGBSsOAwIaMAsGCWCGSAFlAwQCAzALBglg
hkgBZQMEAgIwCwYJYIZIAWUDBAIBMIHfBgkrBgEEAYI3EAQxgdEwgc4wgbYxHDAaBgNVBAMME05Y
UCBFbnRlcnByaXNlIENBIDUxCzAJBgNVBAsMAklUMREwDwYDVQQKDAhOWFAgQi5WLjESMBAGA1UE
BwwJRWluZGhvdmVuMRYwFAYDVQQIDA1Ob29yZC1CcmFiYW50MRMwEQYKCZImiZPyLGQBGRYDd2Jp
MRMwEQYKCZImiZPyLGQBGRYDbnhwMRMwEQYKCZImiZPyLGQBGRYDY29tMQswCQYDVQQGEwJOTAIT
LQAHTNY9heLFOPC4lgAAAAdM1jCB4QYLKoZIhvcNAQkQAgsxgdGggc4wgbYxHDAaBgNVBAMME05Y
UCBFbnRlcnByaXNlIENBIDUxCzAJBgNVBAsMAklUMREwDwYDVQQKDAhOWFAgQi5WLjESMBAGA1UE
BwwJRWluZGhvdmVuMRYwFAYDVQQIDA1Ob29yZC1CcmFiYW50MRMwEQYKCZImiZPyLGQBGRYDd2Jp
MRMwEQYKCZImiZPyLGQBGRYDbnhwMRMwEQYKCZImiZPyLGQBGRYDY29tMQswCQYDVQQGEwJOTAIT
LQAHTNY9heLFOPC4lgAAAAdM1jANBgkqhkiG9w0BAQEFAASCAQBYb/dZRAV6321jqRgAQEj0ZXgr
U/sKOv+3TASubvDj4llJ2X9olcRgKx8U4qSiibv2SA0ljchscapTTC34nUFyiGz/8iPf8RVYJdT9
+XQwMaiHU3eEhSw5LyYBOiQlq0xXthoMJ8RIDK451M4DwTXOYk/BslRTMunVJYMCMraXGmbFjoDr
kS2TYrLbB1Nov/fcJyWOgY1ck9gJYQM4LkBVsFr5rX1qVk2j9Sjme9UpyN78/3zaq/LVK4TiJtNj
gyDmMBwgmz57oCFBztPDG2UD8NsWmOW8oa+YQB7gaKc0pX7NpVpJuYHorkspuPdt61SWahim06Vy
LMO5+MvL6/DkAAAAAAAA

------=_NextPart_000_000F_01D8719E.799D6800--
