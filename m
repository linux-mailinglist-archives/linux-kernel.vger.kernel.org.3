Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C4695A3018
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Aug 2022 21:37:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344659AbiHZTgn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Aug 2022 15:36:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344613AbiHZTgk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Aug 2022 15:36:40 -0400
Received: from mx0a-00230701.pphosted.com (mx0a-00230701.pphosted.com [148.163.156.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32D12D2E97;
        Fri, 26 Aug 2022 12:36:39 -0700 (PDT)
Received: from pps.filterd (m0297266.ppops.net [127.0.0.1])
        by mx0a-00230701.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27QG5ms8017483;
        Fri, 26 Aug 2022 12:36:18 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=pfptdkimsnps;
 bh=heaObNCSkcM2XYgpqFhZQjnu3U6FlKKRaHo5XX1IJ10=;
 b=jTKG/OhPOxYpo7VYki15jSLJvurlTxDt2Q7wCuPHBVuwXj2WxBybL1JBAePAn9nVMmsm
 ZsFHBWnN5XZG5EDhAEsVPyk/smmVMHoVWpfHWaavnfq/37R4CVz4cLkFkFa7bH4BCdWO
 6vp/LZUVj6Bs0X1NyleJphCoFnKmmdhLCTZe4soFxOdTtPyI+gg2AEvPgUDfdxmKSR6s
 EUWQLANtDrJAT2TE/9bFg6kufDAyEqtNKHtapbvbZl6ec9ETwdyH4fUU8dVzINcAiYah
 5bVyof3ED+Y+3nIHWwL0cPXaH8ZzLypYlZ7+cIk4bz8jsbEF5MRl4jB5ZRHTFn2ajrcA nw== 
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.73.133])
        by mx0a-00230701.pphosted.com (PPS) with ESMTPS id 3j51wvpkf9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 26 Aug 2022 12:36:18 -0700
Received: from mailhost.synopsys.com (sv2-mailhost2.synopsys.com [10.205.2.134])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 283F340083;
        Fri, 26 Aug 2022 19:36:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1661542578; bh=heaObNCSkcM2XYgpqFhZQjnu3U6FlKKRaHo5XX1IJ10=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=OKu3msSCTupIq3aZHFR/9zq4kQZ8+SVjjfkss2LSRlYYJHokTRO1+miOXNYRlSCks
         sv+sTBGsy5tJeuXMG5h1vYpMT5OYhn00TWbu4SoI97cEI7bb0GfvKdTstm5pbPJoEF
         iZtWvq1dcjTgWHEEj+MdX0I/3uJPk4FaBhMxgMNuWwrKG3Qd5JhZtDRgLfgY6Hs548
         rfRDZBYnfeNH4sa3xCuJhHtikmrZJFMzpCb+3N1H0vTpXDncT45VvUd8DGzoV1vWFk
         42mWHhg25dQXVH8xOGe3aUdOJvcuZ1AzHzfW/LW4aM2W80azf3CYCrnRED1naZb7to
         vkU/b0fIHdZgA==
Received: from o365relay-in.synopsys.com (us03-o365relay3.synopsys.com [10.4.161.139])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (verified OK))
        by mailhost.synopsys.com (Postfix) with ESMTPS id B6F8FA0099;
        Fri, 26 Aug 2022 19:36:15 +0000 (UTC)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04lp2049.outbound.protection.outlook.com [104.47.73.49])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
        by o365relay-in.synopsys.com (Postfix) with ESMTPS id 6FBBE801FD;
        Fri, 26 Aug 2022 19:36:14 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=thinhn@synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
        dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.b="JH9ZkeLS";
        dkim-atps=neutral
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X0P0vhEXdnxARVaC8Xotgq6668v51fxeqKvow1vCF2Y3K6qbX+Nj29IuC0wDwdkoElaQAC2GDbseVVrY0sCoN2jamxF5BNl45m0XkG0KcUBpH/3qqzIQGh70WaHQXsd81IVitrtv9JONeeFPokVhGk7dKe9AN5AbVXCepT4kOgtCGYQEiw2grBn0GhxZ44PI1BdmN1IORL7sKiMvLfBcXjQfinAOOqqe4iNdUFubL+AHkJDcd5MeyhbBseTWF4Gy0mXWXhvApWE5LzoSE6I2RfHEcmjNenPyi4Eod0vXSGwepBTNy43KmHut8zJJNMDpbqzDAnXyXimptxLIdzH3cg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=heaObNCSkcM2XYgpqFhZQjnu3U6FlKKRaHo5XX1IJ10=;
 b=M4nN7a+rtOxTVBJr8cI1bBFFY4ocqRWSoSD6PBmtJHHA13i/8xXsmMxDlchq63d7T87zq3GeOxOfrUDVacUYjn3OVLjva3Cj1nwXCURweL2aOCavJn9OCKpJlp6jbDhuEXBk/uFFjb5SPcmv9sToTVukwkOU5O9N/zo3GXc+TQgrV9nvKfsbxjrS48aGpBtv1qNB5mDzEjWsuS9TMPFwoBert2HBP847/RijrMaPwwBnWw2o/CT5HyxBV47c+Az/ZtiZyLAYXlieCrYCHiNn91L2/M4SnQxJ30yn/xwyDKpMAkP1/GFxbZ9cPJvodMeeSStwP+Na2ZisGNqqTrofSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=heaObNCSkcM2XYgpqFhZQjnu3U6FlKKRaHo5XX1IJ10=;
 b=JH9ZkeLSDmUoddJD+Kaj2Ept9jkTlOdP9npHnCC62uPX7PJyzEis0cCqo2TIIpbhanZXZqY7YByzPOhG+IdsVDAn8i+H4IHro7Eejl90B/ouesQk3d1wm0/1cWBjx+toLnMoFrmo2Nd1xqwCoE5zTlDwfAPpNTTPgXqGcSMUs0M=
Received: from BYAPR12MB4791.namprd12.prod.outlook.com (2603:10b6:a03:10a::12)
 by MW4PR12MB7381.namprd12.prod.outlook.com (2603:10b6:303:219::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.15; Fri, 26 Aug
 2022 19:36:09 +0000
Received: from BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::69ee:633:f068:3ca1]) by BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::69ee:633:f068:3ca1%3]) with mapi id 15.20.5566.016; Fri, 26 Aug 2022
 19:36:09 +0000
X-SNPS-Relay: synopsys.com
From:   Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
CC:     Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "target-devel@vger.kernel.org" <target-devel@vger.kernel.org>,
        Dmitry Bogdanov <d.bogdanov@yadro.com>,
        Nicholas Bellinger <nab@linux-iscsi.org>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        John Youn <John.Youn@synopsys.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        Andrzej Pietrasiewicz <andrzej.p@samsung.com>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v2 00/25] usb: gadget: f_tcm: Enhance UASP driver
Thread-Topic: [PATCH v2 00/25] usb: gadget: f_tcm: Enhance UASP driver
Thread-Index: AQHYmw6F3vPaFvUH1UezRNMH+EVsTq3BPaKAgACSZwA=
Date:   Fri, 26 Aug 2022 19:36:08 +0000
Message-ID: <20220826193602.2zyzdtcfzx6xxfga@synopsys.com>
References: <cover.1658192351.git.Thinh.Nguyen@synopsys.com>
 <Ywil0y5I/oXjPJp9@linutronix.de>
In-Reply-To: <Ywil0y5I/oXjPJp9@linutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f82ddfe2-706c-4ba0-aba2-08da879a39c5
x-ms-traffictypediagnostic: MW4PR12MB7381:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 3tEt20gwP2TmiLs8mG3N9MerccqwiVOWyydOjPzHSjRH9forTQNWqiwRyvWbzcgFfDxiy3sg2fm7SIwL6evHqt5S5VB7GrTpPjf6xEtcFqTQs6bUI1RpXvapEszzar4Kd+AgtpgBVTwmEeHkPP1iVzj0xGVPTi6ZhAHkuoAMZQyLffGaAx2KdJeQLb8FIjB1+kIYQpRtcoSxXGjakjBR2lEhQRE2UUM4CPTgJe8hUY7GMoBk3y72SGwa0ftG+Nb0vPJEqFvvXTkAK8X7d4LCzYGwefa3JeG7vb3eC/SsCpYJJBwigaFpeTPQJzjWxlAAQRXC5k4lissZnjuBZSrxyb/6hkKKMYCl31CJto7tK2R95GYQz1XhjUrANc1q3WNZ3FMSs3YE//lj2dI87EGcgUCgbIjuQmxRjpYoEkGWUKM3qEsYurvxuhoZfArG+kfOsxE35RjVOllVIT9POOcZqnUtaK/f0ya+5iOzm8QUxvZEbQ7j2wHCYHmYNAh4ADzXW27+ZmcP0gaiMSUzUsqJpdgTdLRJsq527CEz0s7oZglXYHwuaLjwKtBKIrBKhBlp3N7+IN9Upbfd6XRIYbIvwAHK4OPvdCAILYwbPqAywEvVGIwA+AYp5gJX1RHCQClyRmfL2co7628xUAhPXQPpqc7xTX7UIUOFGo+gEFcTQuHR5P5iNog6M8+X0ALihR7tqjDThVqIvQiNf9inhNwOSgJHiL7ikwx8Ped6EvFLerV+oNJ4CW51Bd0OjmofJRk5rQlSvV5aisx28Vz108weGg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB4791.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(396003)(366004)(136003)(39860400002)(376002)(346002)(186003)(36756003)(2616005)(6506007)(26005)(6512007)(122000001)(2906002)(53546011)(38070700005)(41300700001)(1076003)(478600001)(38100700002)(86362001)(7416002)(8936002)(6486002)(5660300002)(6916009)(54906003)(66476007)(316002)(8676002)(66446008)(66556008)(71200400001)(76116006)(4326008)(64756008)(66946007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?M25WMXYzNm50aW9oNWZNUjV1WTdPNkN6YW5WUStjVFVmdGpGTzRDN251MVJh?=
 =?utf-8?B?QnVNZEFIRkdrQ08wMUdsVlloOGsxYk1VdE9GS3dYQlpyZkxLUFpObzVFRElQ?=
 =?utf-8?B?ZGdub3lGbFpBSEcvUjl3djlwRHR1QmdmN3VuQW13bkxPdTc3V1MyVUJIWDlY?=
 =?utf-8?B?TW02Zy9IMFVIWmpJQjI1MVAyaGhxMFVUUmo1RHcwUzNqQVNzMWNScTBGVHp1?=
 =?utf-8?B?bTVpdDRTVGRYZm0rYzY1UTlTeFg5Vng2NFM5TmJOQnZvVXJPbitnMkNEdVVS?=
 =?utf-8?B?NmxLdzhFa3Flc0VMOUVlaXNxUUtnaUtDaVZvc3hzS1hUUFNua3dnNk01S0lD?=
 =?utf-8?B?OUhuOFJBOW5USkRydkRyMDRoUzJMK0FoK1E5TVAzZjVJd1gyb1dGekZpUzA0?=
 =?utf-8?B?UklMaU4wOHlaWGxBdVRhSWZXaDhZakNmdjljNGc1VDFLWEcwNzBuZkJuL1lr?=
 =?utf-8?B?a2xjYU1CWC9jWXk2ZklmMHZxZlJuZyszbDJQYVc0N3Q1b3JQUUZ3a0VaeTdG?=
 =?utf-8?B?c0JFMUpaL2hGRk9KR2p0REVwMksyN1FxL3hrMjhVRGFvY3NvazZBRHFSTWRn?=
 =?utf-8?B?S25ZWXl2SUx2dTBwd1pVSU05VUsyOUFnOFF3YUZTRVU2b0ZkZGw0UmRnNUdt?=
 =?utf-8?B?MFBwYjlFVUV2M2JNL3JRQjUzQXgxMURsem9wZGtzRVFZLzhtOGJHclpveEwv?=
 =?utf-8?B?bytIRHZFeDZUSmw4UWJua29mclovZVBpMDRkWHArL28wdVo0R0x3K1ZXZHIz?=
 =?utf-8?B?K3U0V0xiTFFYRlZMVlZvbzd0VW9kc1lqZ1dqdyt3d3M2OEJKRjRxSnIzNjJV?=
 =?utf-8?B?ZEp0bmhFWk5SOElvUzVCYXFmZDMrWmMvNzRzVzNnc21QWUhEQzNIZWpuaFp1?=
 =?utf-8?B?VDFaejhYTTBVbC8zMEtPclZwemlJTkJ2L0pNZm5qYW50SGh5aUt1ZitGRkZh?=
 =?utf-8?B?QTFJME1NZFl0cEpRb3V4ZVRCUlNEYmh6NXFWenV6LzY0aWdoWUpmMVp1MTFo?=
 =?utf-8?B?MjJtbXNKa3hWd3RYMEZGdlhYYnZhdWVsNEZUQkcrbUUyM0x4WGRiaHhxZWFO?=
 =?utf-8?B?bDgrWlZPNEgzN29yMU51dUhlbjRpM2dXSW1ydWN5TDYyZWNmRTZyQ0RXZzkv?=
 =?utf-8?B?UkhNeFlxYUlrYzFoREo3Y0VaTU9YcExOSXhiVTNWZTQ3d011RUZzdmx1MVhm?=
 =?utf-8?B?T2JkZ24rVzdZQXdYbHlHbWxnYTVNeTd6VGNDV3hzWmVXZHFwK0F3ZnVyYVNq?=
 =?utf-8?B?azZqNU83dGMxajhlN3dWdEh2WnIrOVorYlE1L29wVGFUaVBzMSt0NUlVdFVk?=
 =?utf-8?B?KzAwMlZ1aWh4aWJjZTMyc1Nod2JvdytEaWsyRnRHdFZZNGE5bG1WUTgrOE5h?=
 =?utf-8?B?TjNLVE1jVTVYbCs0ZmdreWhWdDVFQU9LUGh4bGVPMGgxWlBabnNINjNyMzVw?=
 =?utf-8?B?L1Y1WGFKN3JFOWRIZElJMVcrU3UvbTdLcXhQMVpmN1RWTmg1S3ZVVjM2aGZG?=
 =?utf-8?B?VnJPZ1FRMEhmajRPWVZGTE9ZMGh5WUtvOHk5RnJJc2F4a05zbUVUdU8yckth?=
 =?utf-8?B?SVpzODdDY1pibWEra0JBSGt5YktXMGlxWkJPbVlSaXJIZ0o1N0NJU3RPcW5M?=
 =?utf-8?B?alppZmFoQmNwSnRvemV5WjRQVTdXditwTnBUeitSUUlRRFp1bjZjdXJoQmlC?=
 =?utf-8?B?bUVxYk53aDY3bmxERzA5YTRJUzFMNEtVc1B0Tkw3UXhFbTdxRzdra040VC9h?=
 =?utf-8?B?bkF0bTNWL0pZNmw5dG1wY1lwUWdMMHUvVTZtOFFUSTJSRjJxMkFpTVU0Ui85?=
 =?utf-8?B?VXFOU09FQloyTlNQK1d4akFZYXpudUh1RCtHOHpYcjl1YnZocWhHTEpjOFAz?=
 =?utf-8?B?ejdtS2xOd2JSK2p2ZVVIYzNoQWJNYlB0MjYyek14ZUlENTJCcjlWYnFIaVBl?=
 =?utf-8?B?dnRWSVdvenVOTllGRGxWUEpXRFZtLzdDd21GaWF6Qlh4d2FrM2ZTejlvM0dX?=
 =?utf-8?B?MTN6UzVpMEhmamlQMWlWdEU3NC9Wc0FpSVF4VUM5R1Q5UmtSSWFIcHVFSko2?=
 =?utf-8?B?UGYzcHVUWW80YXJjVTlCbDJHQjVjTGpIaFB1ME9reFpCblhTTWthaXM3N2xp?=
 =?utf-8?Q?Cu79z3lqBBEowdZfcYYW8jgKx?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <DD1B63A264E9A34EB0848D7FD8052556@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4791.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f82ddfe2-706c-4ba0-aba2-08da879a39c5
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Aug 2022 19:36:09.0159
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MLlyspbQAOsxf+tHTGgQ1vX+uLhORVZT+4dkUWRNkPsvlm7iNKylLf2RwcXedrQWl2JO3y137322/K/B/jofEQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7381
X-Proofpoint-ORIG-GUID: ISJtIi66y5JfW3L2Rr_XWfciMdwMoO4P
X-Proofpoint-GUID: ISJtIi66y5JfW3L2Rr_XWfciMdwMoO4P
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-26_10,2022-08-25_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam policy=outbound_active_cloned score=0
 lowpriorityscore=0 adultscore=0 malwarescore=0 phishscore=0 spamscore=0
 suspectscore=0 mlxlogscore=474 impostorscore=0 clxscore=1015
 priorityscore=1501 mlxscore=0 bulkscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2207270000
 definitions=main-2208260078
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gRnJpLCBBdWcgMjYsIDIwMjIsIFNlYmFzdGlhbiBBbmRyemVqIFNpZXdpb3Igd3JvdGU6DQo+
IE9uIDIwMjItMDctMTggMTg6MjY6MDEgWy0wNzAwXSwgVGhpbmggTmd1eWVuIHdyb3RlOg0KPiA+
IFRoZSBMaW51eCBVQVNQIGdhZGdldCBkcml2ZXIgaXMgaW5jb21wbGV0ZSBhbmQgcmVtYWluZWQg
YnJva2VuIGZvciBhIGxvbmcgdGltZS4NCj4gPiBJdCB3YXMgbm90IGltcGxlbWVudGVkIGZvciBw
ZXJmb3JtYW5jZSBlaXRoZXIuIFRoaXMgc2VyaWVzIGFkZHMgc29tZSBvZiB0aGUNCj4gPiByZXF1
aXJlZCBmZWF0dXJlcyBmb3IgdGhlIFVBU1AgZHJpdmVyIHRvIHdvcmsuIEl0IGFsc28gbWFrZXMg
c29tZSBjaGFuZ2VzIHRvDQo+ID4gdGhlIHRhcmdldCBjb3JlLg0KPiANCj4gU29tZSBwYXRjaGVz
IGhlcmUgaGF2ZSBmaXhlczogdGFncyBhbmQgYXJlIGluIHRoZSBtaWRkbGUgb2YgdGhlIHNlcmll
cy4NCj4gSWYgdGhleSBhcmUgaW5kZWVkIGZpeGVzIHdoaWNoIGFyZSBuZWVkZWQgZm9yIHRoZSBk
cml2ZXIgZnVuY3Rpb24NCj4gcmVnYXJkbGVzcyBvZiB0aGUgb3RoZXIgY2hhbmdlcywgd2hpY2gg
YXJlIHBhcnQgb2YgdGhlIHNlcmllcywgdGhlbiB0aGV5DQo+IHNob3VsZCBiZSBtb3ZlZCB0byB0
aGUgZnJvbnQgb2Ygc2VyaWVzIF9vcl8gc3VibWl0dGVkIGluZGVwZW5kZW50bHkgYXMNCj4gaW4g
ImxldHMgZmlyc3QgZml4IHRoZSBicm9rZW4gdGhpbmdzIGFuZCB0aGVuIG1ha2UgaXQgcHJldHR5
Ii4NCj4gDQo+IEFsbCBpbiBhbGwgSSBhbSBoYXBweSB0byBzZWUgdGhhdCBzb21lYm9keSBpcyBs
b29raW5nIGludG8gdGhlIHRhcmdldA0KPiBVU0IgZ2FkZ2V0Lg0KPiANCg0KVGhhbmtzIGZvciB0
aGUgcmV2aWV3cyENCg0KSSBjYW4gbW92ZSB0aGUgY29tbWl0cyB3aXRoIGZpeGVzIHRhZyBhcm91
bmQuIEJ1dCBmb3IgdGhlIGRyaXZlciB0byB3b3JrDQpwcm9wZXJseSBhZ2FpbnN0IGRpZmZlcmVu
dCBPU2VzIChhbmQgbWF5YmUgZXZlbiBmb3IgTGludXgpLCBtb3N0IG9mIHRoZQ0KY2hhbmdlcyB3
aXRob3V0IHRoZSBmaXhlcyB0YWdzIGFyZSBhbHNvIG5lZWRlZCBhbmQgbm90IGp1c3QgdG8gbWFr
ZSBpdA0KInByZXR0eSIuDQoNClRoZXJlIGFyZSBzdGlsbCBtb3JlIHdvcmsgZm9yIGZfdGNtLCBi
dXQgdGhpcyBzZXJpZXMgKHBsdXMgdGhlIGZpeGVzDQpzZXJpZXMgaW4gdGFyZ2V0KSBpcyBlbm91
Z2ggZm9yIHRoZSBkcml2ZXIgdG8gd29yayBwcm9wZXJseS4NCg0KVGhhbmtzLA0KVGhpbmg=
