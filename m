Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9969A4BD751
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Feb 2022 08:44:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346389AbiBUHkw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Feb 2022 02:40:52 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:39756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346392AbiBUHku (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Feb 2022 02:40:50 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 162AC13CC9;
        Sun, 20 Feb 2022 23:40:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1645429224; x=1676965224;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=9FvXFAhTihOTg4NvPe6BCa8Mz4dcPTBKDcSjyhBT87k=;
  b=u3E3947hlhpC96Ht/b1MkYEgnpLAMHQHPpbe7trk+mph292VhUI0wC7c
   eNMPB6MuBzXB+1eDA12nhQXCjWXVRJ5e7Dyx4QnZRB/Qc3kufu5ILixnl
   coJiEWAWzFnX8M+kcQX4fJXPiRqR+NGTBC49biAVCGGWn8cPLncfUS8Au
   ze0cbACxrBGlpLmu2/iWGjv68r0RGeiR/4zZ2RnXSyrMSRNZuQ8KIORUe
   WxUbF+6hgClqKfaW6qHCURvRUR63QRBcBsAyNw/59OeJldf1qXaf20fe1
   ShDGwwwvtfinNHO41HeMvxW1wvchKzgK6uMaEhjt/pY5S0YWDh73CuPKP
   g==;
X-IronPort-AV: E=Sophos;i="5.88,385,1635231600"; 
   d="scan'208";a="162964495"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 21 Feb 2022 00:40:23 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Mon, 21 Feb 2022 00:40:23 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17 via Frontend
 Transport; Mon, 21 Feb 2022 00:40:23 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iIiAdgWyc1OEArxw+H/h2VKJLZE9FQSxdsEKkiHBzOBJpDkpxETMT2qN2JmjWeTcTZxLJjquY/UN9cZQSGhTNIAwY61mwN+Qv496qIPWESjQCxwxTptYj2A19Hxy1jt1kpoXsJfHmTlkDL3wfgAArh83WWYRS2YvZobrc+1ZDh92nm+YGbavbCKciw9iA06cuDbRUS7ZG9PcXMybwgs9qPG4JSb4wcNPKlTDx47blmJoqkl8GKyo/w3qcdSUI5wyQtUHBBwHFYF0GpPsmv43ce0IXCiaklWlXQ2OdTmu1J6EihpB2pr1xCvwCKkIn52KUVaffnK09VXKZzKSfPBZAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9FvXFAhTihOTg4NvPe6BCa8Mz4dcPTBKDcSjyhBT87k=;
 b=lQDskBzRBtthLxr7vaD+2YcCU6DOSQ4Rkr8oCesvwmlwCNQ7GW2XCiRsr+TuRTF5Z59jUqtiB2jOm2t9wdPQjTsPeqqNCR5qxKALNyEtVoBB9UD3ufSIe1ZwN0zI1RR1GE8Tr/ecHVXeraNM6CmagtMKx4RCPa0hvsKTD7AE76WJQWi5v7E9L74QzdJBRAnyVN91vx6Kznpw4XSO9U1mJu3McIOcam15vwJyq8zMOSTTj8MHNi02dnGEWIVtsrJhw32QG64+0BWnMIz40xcSxzdZ3Z3+X978Fr6rKoW3kHAoJQf96LC76cM4IjUSWWmEpQ61Vppj6bbQgKXg3qleDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9FvXFAhTihOTg4NvPe6BCa8Mz4dcPTBKDcSjyhBT87k=;
 b=eNJfdr4YcOrJ+eRxTCJLs7nyVqphl0K3tQT+fOTeQ5cKqMUsQ30uveED0sAawMeEdc3ExSsW0jayrSZY4r7aW99PzmqqWEbftropQJN/3OKhr7hwtq3ybenTQmBJG2tX6TiKiy5JjTP+bIW8qLJLNxNw8v+Kcp/8dUDIxtEHV+Q=
Received: from PH0PR11MB5160.namprd11.prod.outlook.com (2603:10b6:510:3e::8)
 by MWHPR11MB1759.namprd11.prod.outlook.com (2603:10b6:300:111::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.16; Mon, 21 Feb
 2022 07:40:17 +0000
Received: from PH0PR11MB5160.namprd11.prod.outlook.com
 ([fe80::d46c:fea3:ae31:aec]) by PH0PR11MB5160.namprd11.prod.outlook.com
 ([fe80::d46c:fea3:ae31:aec%4]) with mapi id 15.20.4995.016; Mon, 21 Feb 2022
 07:40:17 +0000
From:   <Conor.Dooley@microchip.com>
To:     <robh+dt@kernel.org>
CC:     <linus.walleij@linaro.org>, <Lewis.Hanly@microchip.com>,
        <Daire.McNamara@microchip.com>, <Ivan.Griffin@microchip.com>,
        <atishp@rivosinc.com>, <brgl@bgdev.pl>, <jassisinghbrar@gmail.com>,
        <thierry.reding@gmail.com>, <u.kleine-koenig@pengutronix.de>,
        <lee.jones@linaro.org>, <a.zummo@towertech.it>,
        <alexandre.belloni@bootlin.com>, <paul.walmsley@sifive.com>,
        <palmer@dabbelt.com>, <aou@eecs.berkeley.edu>,
        <geert@linux-m68k.org>, <krzysztof.kozlowski@canonical.com>,
        <linux-gpio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-pwm@vger.kernel.org>,
        <linux-rtc@vger.kernel.org>, <linux-riscv@lists.infradead.org>
Subject: Re: [PATCH v7 02/11] dt-bindings: soc/microchip: add info about
 services to mpfs sysctrl
Thread-Topic: [PATCH v7 02/11] dt-bindings: soc/microchip: add info about
 services to mpfs sysctrl
Thread-Index: AQHYIaqkHPhj/CJJS0mllLGUxxwpeKydqiqA
Date:   Mon, 21 Feb 2022 07:40:17 +0000
Message-ID: <24cf0030-069f-4b6e-41f9-452dd96ca0b3@microchip.com>
References: <20220214135840.168236-1-conor.dooley@microchip.com>
 <20220214135840.168236-3-conor.dooley@microchip.com>
In-Reply-To: <20220214135840.168236-3-conor.dooley@microchip.com>
Accept-Language: en-IE, en-US
Content-Language: en-IE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8f614a89-03d4-45e6-8f8f-08d9f50d67cf
x-ms-traffictypediagnostic: MWHPR11MB1759:EE_
x-microsoft-antispam-prvs: <MWHPR11MB1759CAC306051A4917D25936983A9@MWHPR11MB1759.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: jJgSWxwGpiJbpZ1HrrXJiD2v/nl/BbyOGOmfZaxQBH9rHWahZmB7/TdL23QOT7+4yZRKMvjUZkrF2k36XbdEi7lidsEPGXpmrbONO2eOLOeOSTWUDXRnK6Tn4zNj8pZQL403cdenbcp5vBCrypPfY2XrwfGtaVkEl5nhe/VVDvKE5ljaQ919Kvo+Mypmkiq2Jh5RVxy7xjRtOeJqOrmMU2gAyyZBMN2uMqMc2phlVp2y8fOk9tYZs1Q7z4jCTwMwJG5IjsaV4w9owk7D9rGY6eyjmNZTL2LVh+occWEmf0ioYTHLKZSWuGSWcYr0CfdQK0X3J8cyCnGnyp/s0AH8tx6eCfxpzjgYMydPAzosPoGBmr2v0KY5cRjdY3kQNq9YouYA9g9z9GLOX9p5ac9AsMh9mo30uVOJYKNvIfPYwSd1p4bY0l/orFwBMCOMXQwipgyGlfyQptVEKCH8q7YEQWh5987Ne8L/qZbLyAuoj2Ms3FB7R0xG+AWHWdqUKG/EGWOThTIZzsk9W5YrPKlSnmBXuR5sa9TsWin3sP0luc+HHytelVbYgIufY/VDacMx90Xhiaoj7B87kxvgGpyYEm4ec35azgipxEjLPdh/Gc37UBS26LhazYszUTJ0Yv+YDNuYbmGtGwzUZvC/8gFUUneUmKse3n14QYDOotzBM1XNCbrJejO4EnuTDmnwbGj41dSD88XPhoADOOSSDdoR/zeVLSuqzGlsEkuuMabORfy3Qo4v3Gu+0+u5yjc8R2H2l074Co1XJNCexi2GwiIj0YLzNykpxLKyMwyY1Qus6tFkdKbT3j83VHwhe33OfkKSO+2TJ91E4cLlzLQvDaf8fbFBUXdeCkbW2icrGbSNUmw=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5160.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(71200400001)(86362001)(186003)(26005)(6506007)(2906002)(53546011)(122000001)(38070700005)(31686004)(36756003)(38100700002)(316002)(508600001)(54906003)(66476007)(8676002)(66556008)(91956017)(66446008)(4326008)(64756008)(966005)(66946007)(76116006)(6486002)(6512007)(8936002)(31696002)(7416002)(2616005)(5660300002)(83380400001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cEpxMGd5cDIwa1RmMkVDNzFkc1hXcmJteW1WSUtWemlmYThwWHY2MXJVaTEz?=
 =?utf-8?B?SWlsVHA5aTJaTDIxVTJPWUN3WXRWM1BxWFFJakVjTnBXUGFxaFUzL2JVcnVx?=
 =?utf-8?B?WUlwMWFGTnJLNy9wT2dlZmJDVFllN2NEanZTTzhZQ2pHU3hCNklJSXlKaVVn?=
 =?utf-8?B?T3U3dk9ETFRwL1YxMCtUSi8vYVk2T21JOWtIYk8xWDdpUklPdnltdGN0TkFM?=
 =?utf-8?B?ZmRGQjJzQ3JGVExmVEpENWJ3azVMQ3NVUXp6eFRHaldvcXhBWW43QXQ1VTk5?=
 =?utf-8?B?UWlqakw3UjFCaVkzVGlxQ0VNUVNNMm5YY0NncHVodldKekpwVy90LzQ5NVpn?=
 =?utf-8?B?ZHpMNjRUN0FxR0h1VDM1L3ZWbWpqZXpXencyRFlqMVRCMVh6bWZsQVZBWTc4?=
 =?utf-8?B?bVdMNEhibXE3TXd4RUFUYlFaSkU3R0IwTDNveTZrUmo0Snl0TkdWdDFIc1U0?=
 =?utf-8?B?VEE1a0FsajRMNnFrV1VQc3o0R1VSaTNEUk93cGNRMlcvbi9pS1RhYlo2WjhT?=
 =?utf-8?B?MFhZcUR1R3FaVTloWHZjbkczRERmUHUySnRPdjFNZFRzSEZ5bjRIU3FwR0pV?=
 =?utf-8?B?RnNMdEYyVlRueERQZ21QTFhPb0NTc2YxZDFjS2w1T0wxRktTQWJOUXdoVDE4?=
 =?utf-8?B?WTc2QkJ1V1o5NGJFY3I0Rlh4QkxyY0hrVnUwTC84cjEyNW8vajhnaDhIVHZ2?=
 =?utf-8?B?OVJoZUs0eTBoZnpaT0ZqTjVFRVdRK0FvNUNYbFhjSG1jQUxpRFBHSUp2VWZV?=
 =?utf-8?B?a3dEV0xoTDN6eDRCTkppRWtWR2Z0Zjh6TzFqdUo5bEdwNnFLaVlKbWQzMWlF?=
 =?utf-8?B?L3JHWGF6R3B3WSt3aDlpNmZuUjZpWjQ5aU1lMVA1T21JMGtFbVc1Q0JkSk5y?=
 =?utf-8?B?QXc4OWh1WFpBam5VVjU1ZGluRXFvZVB0dUI2ZUI0ZUVqUkRsdHpGQmR6QnhZ?=
 =?utf-8?B?bmhJRHFoUm9leEZSbjBBRDZ1b3dmd2lyVEFyak9sMUhYNXgzQTlDVVNnNFJF?=
 =?utf-8?B?UjQvbjNZaFVudzJmSjVyOE1rR1luYzNWZDRMQ29yd2MzK0hkRi9IeXdVQTBY?=
 =?utf-8?B?alZOYWJIbjhUTkQzTTJiUTVvMGNhdzhNOVliRFJLQUdPbm5WcFRmTk9GVTFm?=
 =?utf-8?B?TTgrTFZtTHgvSDZYUWQvaTBQN0xkSFk2QTJJT0pITG45ek9ndDdxMmEzSVRi?=
 =?utf-8?B?Y3BWTkIyUnBCUjdaK3g3R1FTTENiR0RnMGovYmtpcURSNkc1NW1CWjk0b3NF?=
 =?utf-8?B?MHNNN2pjaTdidkxCNVgvUTJGY2Q3QmluUThJK3FlVEpQR0xyRGN4ZVBsSjFN?=
 =?utf-8?B?QmZEcm1JV2FFWkpFWXZmNWs3cFRKRlNGMVRzYWRPbWhaaU1KS3d0Ujd5d2VV?=
 =?utf-8?B?eEJBNE91MU5DTjEvb0FsWllFKzdPWTZObHBvRUJJTG9ZQ2JJZ2pNRXJ6em9P?=
 =?utf-8?B?d3UxNzcvT3Z1ODA4TDlyZVdlNVhrMy8zbXI5c3pRaDFCMTkzeEdJb1VGcmIr?=
 =?utf-8?B?ZzNIVm9IYVVSc1pRTk5ocWJQdHdRWkxlTlBLZjBUNEVhNnNuazFyT3JKK0xI?=
 =?utf-8?B?V25YOGRLcS9MKzBZTU9YNm1OVjR5VXVHd3FCTG1ocityelY1SE1CcXRWa2wz?=
 =?utf-8?B?eEhaWFZJSGZkKzY3bEIxVkpCcFZ0Zzc3U29BWWtwTHBkSUl1WDYzSW9SSTVE?=
 =?utf-8?B?c3BMaGx0NUxXUDdmOG1kMWVacGx2bW5JSHFjcXpjZzNMK0pPWWJLNW82VWUx?=
 =?utf-8?B?cSs3ZXpwL0hvdHdYREtORk1tR1BWTXFRRzNaSjBRYlFNZEplc3N0aytiWVpJ?=
 =?utf-8?B?VG1Zb3pEdlg2WGhEU3cwR0VCSjdGWGYvVG4yWmIwWXhDMk95b0tFV0ZEbUpN?=
 =?utf-8?B?Tkd3YVlGUSttU1I3WnJrSC91QUg4V1c4dkRpckw3WFd1SWllelYzMHFJdTR2?=
 =?utf-8?B?bEhodzd1cDYrbUh6anlyK2xHVUdWNkFucWVVTG0zc2JabS9DaGc5Qlpra05I?=
 =?utf-8?B?U2dhaUdnb2NwQ2xtQ1VzbU1BNmtDcjEwRy84YktuS1NCTHRhR0VkZjRTa3p2?=
 =?utf-8?B?eVVSTEhzdlU3cTNaQnY2RGVvZmI0WXZKSFo2dWNMOHV3YmF1V0R4SkxpUEo2?=
 =?utf-8?B?azRGb096eldpdGU0N21ySC9IbFhad0pqdmxETE5BRC9PWEE1bTNNWHlNOURo?=
 =?utf-8?B?ZDJmbWtoc3ZsdGV2WERwT2Y3S0lIaUNxdGtVbm80VmovNmZDY3A4NVNKT08x?=
 =?utf-8?B?L3FxL3dNZVk5bVcxWU05S29vQWt3PT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <54D7DDBF0E8616448751790D8B057A44@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5160.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f614a89-03d4-45e6-8f8f-08d9f50d67cf
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Feb 2022 07:40:17.3265
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9MKXQmQNAA0Ia9y1N0gaVzqeFdTonOC8zCp9OxolQQiFQ8tkAXgxkju1OoBAXK25brxwuDSz7rcnAGNssPMR6Pvlmhr4LhOgz/y+oW1ZGDo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR11MB1759
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGV5IFJvYiwNCkkgcmVtb3ZlZCB0aGUgY2hpbGRyZW4gYW5kIGFkZGVkIGEgbGluayB0byB0aGUg
ZG9jdW1lbnRhdGlvbiBmb3IgdGhlIA0Kc2VydmljZXMuIENvdWxkIHlvdSB0YWtlIGEgbG9vayBh
bmQgc2VlIGlmIHRoaXMgdmVyc2lvbiBtZWV0cyB5b3VyIGFwcHJvdmFsPw0KVGhhbmtzLg0KQ29u
b3INCg0KT24gMTQvMDIvMjAyMiAxMzo1OCwgY29ub3IuZG9vbGV5QG1pY3JvY2hpcC5jb20gd3Jv
dGU6DQo+IEZyb206IENvbm9yIERvb2xleSA8Y29ub3IuZG9vbGV5QG1pY3JvY2hpcC5jb20+DQo+
IA0KPiBUaGUgc2VydmljZXMgYWN0dWFsbHkgcHJvdmlkZWQgYnkgdGhlIHN5c3RlbSBjb250cm9s
bGVyIGFyZSBub3QNCj4gZG9jdW1lbnRlZCBzbyBhZGQgc29tZSB3b3JkcyBhYm91dCB3aGF0IHRo
ZSBzeXN0ZW0gY29udHJvbGxlciBjYW4NCj4gYWN0dWFsbHkgZG8uIEFkZCBhIGxpbmsgdG8gdGhl
IG9uZWxpbmUgZG9jdW1lbnRhdGlvbiB3aXRoIHRoZSBzcGVjaWZpYw0KPiBkZXRhaWxzIG9mIGVh
Y2ggaW5kaXZpZHVhbCBzZXJ2aWNlLg0KPiBBbHNvLCBkcm9wIHRoZSB1bm5lZWRlZCBsYWJlbCBm
cm9tIHRoZSBleGFtcGxlLg0KPiANCj4gU2lnbmVkLW9mZi1ieTogQ29ub3IgRG9vbGV5IDxjb25v
ci5kb29sZXlAbWljcm9jaGlwLmNvbT4NCj4gLS0tDQo+ICAgLi4uL3NvYy9taWNyb2NoaXAvbWlj
cm9jaGlwLG1wZnMtc3lzLWNvbnRyb2xsZXIueWFtbCAgfCAxMSArKysrKysrKy0tLQ0KPiAgIDEg
ZmlsZSBjaGFuZ2VkLCA4IGluc2VydGlvbnMoKyksIDMgZGVsZXRpb25zKC0pDQo+IA0KPiBkaWZm
IC0tZ2l0IGEvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3NvYy9taWNyb2NoaXAv
bWljcm9jaGlwLG1wZnMtc3lzLWNvbnRyb2xsZXIueWFtbCBiL0RvY3VtZW50YXRpb24vZGV2aWNl
dHJlZS9iaW5kaW5ncy9zb2MvbWljcm9jaGlwL21pY3JvY2hpcCxtcGZzLXN5cy1jb250cm9sbGVy
LnlhbWwNCj4gaW5kZXggZjY5OTc3MmZlZGYzLi5iMGRhZTUxZTFkNDIgMTAwNjQ0DQo+IC0tLSBh
L0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9zb2MvbWljcm9jaGlwL21pY3JvY2hp
cCxtcGZzLXN5cy1jb250cm9sbGVyLnlhbWwNCj4gKysrIGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0
cmVlL2JpbmRpbmdzL3NvYy9taWNyb2NoaXAvbWljcm9jaGlwLG1wZnMtc3lzLWNvbnRyb2xsZXIu
eWFtbA0KPiBAQCAtMTAsOSArMTAsMTQgQEAgbWFpbnRhaW5lcnM6DQo+ICAgICAtIENvbm9yIERv
b2xleSA8Y29ub3IuZG9vbGV5QG1pY3JvY2hpcC5jb20+DQo+ICAgDQo+ICAgZGVzY3JpcHRpb246
IHwNCj4gLSAgVGhlIFBvbGFyRmlyZSBTb0Mgc3lzdGVtIGNvbnRyb2xsZXIgaXMgY29tbXVuaWNh
dGVkIHdpdGggdmlhIGEgbWFpbGJveC4NCj4gLSAgVGhpcyBkb2N1bWVudCBkZXNjcmliZXMgdGhl
IGJpbmRpbmdzIGZvciB0aGUgY2xpZW50IHBvcnRpb24gb2YgdGhhdCBtYWlsYm94Lg0KPiArICBQ
b2xhckZpcmUgU29DIGRldmljZXMgaW5jbHVkZSBhIG1pY3JvY29udHJvbGxlciBhY3RpbmcgYXMg
dGhlIHN5c3RlbSBjb250cm9sbGVyLA0KPiArICB3aGljaCBwcm92aWRlcyAic2VydmljZXMiIHRv
IHRoZSBtYWluIHByb2Nlc3NvciBhbmQgdG8gdGhlIEZQR0EgZmFicmljLiBUaGVzZQ0KPiArICBz
ZXJ2aWNlcyBpbmNsdWRlIGhhcmR3YXJlIHJuZywgcmVwcm9ncmFtbWluZyBvZiB0aGUgRlBHQSBh
bmQgdmVyZmlmaWNhdGlvbiBvZiB0aGUNCj4gKyAgZU5WTSBjb250ZW50cyBldGMuIE1vcmUgaW5m
b3JtYXRpb24gb24gdGhlc2Ugc2VydmljZXMgY2FuIGJlIGZvdW5kIG9ubGluZSwgYXQNCj4gKyAg
aHR0cHM6Ly9vbmxpbmVkb2NzLm1pY3JvY2hpcC5jb20vcHIvR1VJRC0xNDA5Q0YxMS04RUY5LTRD
MjQtQTk0RS03MDk3OUE2ODg2MzItZW4tVVMtMS9pbmRleC5odG1sDQo+ICAgDQo+ICsgIENvbW11
bmljYXRpb24gd2l0aCB0aGUgc3lzdGVtIGNvbnRyb2xsZXIgaXMgZG9uZSB2aWEgYSBtYWlsYm94
LCBvZiB3aGljaCB0aGUgY2xpZW50DQo+ICsgIHBvcnRpb24gaXMgZG9jdW1lbnRlZCBoZXJlLg0K
PiAgIA0KPiAgIHByb3BlcnRpZXM6DQo+ICAgICBtYm94ZXM6DQo+IEBAIC0yOSw3ICszNCw3IEBA
IGFkZGl0aW9uYWxQcm9wZXJ0aWVzOiBmYWxzZQ0KPiAgIA0KPiAgIGV4YW1wbGVzOg0KPiAgICAg
LSB8DQo+IC0gICAgc3lzY29udHJvbGxlcjogc3lzY29udHJvbGxlciB7DQo+ICsgICAgc3lzY29u
dHJvbGxlciB7DQo+ICAgICAgICAgY29tcGF0aWJsZSA9ICJtaWNyb2NoaXAsbXBmcy1zeXMtY29u
dHJvbGxlciI7DQo+ICAgICAgICAgbWJveGVzID0gPCZtYm94IDA+Ow0KPiAgICAgICB9Ow0KDQo=
