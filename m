Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4523F508DFF
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Apr 2022 19:07:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380868AbiDTRJ4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Apr 2022 13:09:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377175AbiDTRJx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Apr 2022 13:09:53 -0400
Received: from mx0b-002e3701.pphosted.com (mx0b-002e3701.pphosted.com [148.163.143.35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3A3A63CF;
        Wed, 20 Apr 2022 10:07:06 -0700 (PDT)
Received: from pps.filterd (m0134423.ppops.net [127.0.0.1])
        by mx0b-002e3701.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 23KETEEt010817;
        Wed, 20 Apr 2022 17:06:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pps0720;
 bh=VknNuVq5K7JkYNrG7SBVaBf2rILV59DM059g70bLVyU=;
 b=N5Fo+xJmerPT811/FlY2xAMmVJkpyUQI7zZ24yy4s9r496ERJUKssVv1mETCbjWhHuWO
 xZj7+2eGOLEZVWXfQKCiRR40JbjDN14vcubIUYKedyD/rGwCcvEpRA4C8peGCHuX29Ut
 0LzA+55LaCfXBCK5arBN8T/bk8SktRr0RrvSMJFtGLrgzkyBi9nKtnhpC5uV7otp1F7i
 LthrRgTMsP5urNR+NLT4xE/zlG61jptQxihdkzS23+PZz/7/jZ4cF7lZZKZ8vD0tAjkn
 GcaG49GPQTt48Y5rfgNXXajF9AaPEkgLuN5xiD9+SSFWO9M4PV07NUQwEQtJ45kqctad IQ== 
Received: from p1lg14881.it.hpe.com (p1lg14881.it.hpe.com [16.230.97.202])
        by mx0b-002e3701.pphosted.com (PPS) with ESMTPS id 3fjbb0pk50-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 20 Apr 2022 17:06:47 +0000
Received: from p1wg14923.americas.hpqcorp.net (unknown [10.119.18.111])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by p1lg14881.it.hpe.com (Postfix) with ESMTPS id DCB46805E6B;
        Wed, 20 Apr 2022 17:06:46 +0000 (UTC)
Received: from p1wg14925.americas.hpqcorp.net (10.119.18.114) by
 p1wg14923.americas.hpqcorp.net (10.119.18.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.15; Wed, 20 Apr 2022 05:06:14 -1200
Received: from p1wg14919.americas.hpqcorp.net (16.230.19.122) by
 p1wg14925.americas.hpqcorp.net (10.119.18.114) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.15
 via Frontend Transport; Wed, 20 Apr 2022 05:06:14 -1200
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (192.58.206.38)
 by edge.it.hpe.com (16.230.19.122) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.15; Wed, 20 Apr 2022 05:06:14 -1200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KBb3Fy/8V5IdDrMOj6i5aC+nhZ9XGxu0p520jMzFj2K/LVpfphqrWjUfb78FevVHIgcUXsc+1w8zY7ko9w1ccW0KdFj7guqQ3yUssTPW23lFy6o4B1KFjRzumf80i69lmkiRd7/5XnfWmLvJSM/DT/J0cUD88Bo2ZfAUdscrAj0eZE6r2eWo2hXMgXqvV6ihV6nzeDDxHMewFTUZFkzbsDo/OlOlkxLI35cFzhujKn8JU9ne9svvkxEQgokuDTNF0VuhJWkr2Sn3B/41bzNBLXsUKjk3CbeJqmqZv3bhciynlcsULVAW6ShNAiWDa8N5d4fyc4t4hXq6uDw7sddBsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VknNuVq5K7JkYNrG7SBVaBf2rILV59DM059g70bLVyU=;
 b=hoZMnGFPLxwLTkkQIv4+BHNydlnaNd8LwW7UdmMpRPUOvHnLNvp4Yf+tEoWST5emfPRjqoYH2vJuRFrzOikkbIC6tZfvgKJzGdlJTTRv3pihI4Azis3IqWSJV0rq6zNht/k0rLLmm55GDkGAp+W2qvpViYFq5SIzyx5Eb77v9qwvFe3sCToGLPZA5tv7mHpsYQKYpZ7PEs3ALAix0RqHaJkEOHVMNY2oN39NUpnrYpZB2D0QfB6IFXkCYHQHKJmgN0VdqKjq46bbbFgT1wTiXEWCpQ/8bEWNAwA2rUaQslCLke/+uBfL3F9tn2LcsFkV4zYzuEzWyAd6+2NSBZDY8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hpe.com; dmarc=pass action=none header.from=hpe.com; dkim=pass
 header.d=hpe.com; arc=none
Received: from PH0PR84MB1718.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:510:172::21)
 by PH7PR84MB1912.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:510:157::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5164.20; Wed, 20 Apr
 2022 17:06:12 +0000
Received: from PH0PR84MB1718.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::6055:1602:5a0a:1562]) by PH0PR84MB1718.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::6055:1602:5a0a:1562%8]) with mapi id 15.20.5164.025; Wed, 20 Apr 2022
 17:06:11 +0000
From:   "Hawkins, Nick" <nick.hawkins@hpe.com>
To:     Guenter Roeck <linux@roeck-us.net>,
        "Verdun, Jean-Marie" <verdun@hpe.com>,
        "Harders, Nick" <nicholas.harders@hpe.com>,
        "joel@jms.id.au" <joel@jms.id.au>, "arnd@arndb.de" <arnd@arndb.de>
CC:     Wim Van Sebroeck <wim@linux-watchdog.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>
Subject: RE: [PATCH v4 03/11] drivers: wdt: Introduce HPE GXP SoC Watchdog
Thread-Topic: [PATCH v4 03/11] drivers: wdt: Introduce HPE GXP SoC Watchdog
Thread-Index: AQHYVMdWx7zdvHoUBkeDq1OHdlBlSaz488AAgAAPxsA=
Date:   Wed, 20 Apr 2022 17:06:11 +0000
Message-ID: <PH0PR84MB17181ADC802E69F91A583B6488F59@PH0PR84MB1718.NAMPRD84.PROD.OUTLOOK.COM>
References: <20220420150156.47405-1-nick.hawkins@hpe.com>
 <20220420150156.47405-3-nick.hawkins@hpe.com>
 <565f92d7-78d1-7623-4c13-70d49eed5821@roeck-us.net>
In-Reply-To: <565f92d7-78d1-7623-4c13-70d49eed5821@roeck-us.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 07155df5-b091-43a4-41aa-08da22f0123b
x-ms-traffictypediagnostic: PH7PR84MB1912:EE_
x-microsoft-antispam-prvs: <PH7PR84MB191269326831C28CD3304D7D88F59@PH7PR84MB1912.NAMPRD84.PROD.OUTLOOK.COM>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: odVQ/a6GwwVbT8kBMK4Bs8dbMlicKAEUIw1Rk0jL2wOrmymfDgEJXAE83G+LHF+WHXyHCgoUDL+Ky9F+rG/hghALcXhVuwUyhKNm/HLV3LGiGU+4gButfCqgBcLr0hV4try4a1oaK3fEl5onV/D4vK2lRkicpl+x5uMN0oZKNtTHdvekkWWafp1E2dD4qIZZbdysDhGS+P7A76neaPOr2D7HOv7UtxYrBnvgHWjUwhzihGFnJsXc66S0Cc3MRkpQX9JdQDtEe/uJeO0l8EiRXzODOYEArrRLideSCipjJDrPlnRppQ3kg1QQnjpZvci0VakYqs3KI0IENcX7d02SY/dhZqop3Dx9W6sRXjrGTBeokmgJYuq/RrcN7RC+LhHzjz0sD5cvBP/tgFExm4UuSGUIRzHajQy/AQuS5yQxThEuuGlYoBwellsO9Ggh+JHfGTnLh600vMhWiQFkLLzqgRPfqvb32ezTtMvqs2h5Lm44xMXvPg47pbdMrQR8ty9vU1cPx3Du1guCzQe1YSaCDLqh/n0WTDLtLlAyH2yiI1RKniEJCDaLuZVO/Pu7pDhqJl19TVpRFvoyh+7Yx0OU5Ezx6lH1+CxJszDOPkSuaqAjG4Mg8POkSW00tvE2Z/lUDtxMEUjyG6stta4wSGDwkXXKJ80xjD+mVJawmn9rDRiV7yjGedT0F1j3S2QN51QdATkOi7ai9DIGYEBpjv7rnw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR84MB1718.NAMPRD84.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230001)(366004)(6506007)(186003)(38070700005)(5660300002)(110136005)(26005)(53546011)(316002)(82960400001)(83380400001)(7696005)(122000001)(76116006)(9686003)(38100700002)(8936002)(508600001)(2906002)(54906003)(55016003)(4326008)(8676002)(86362001)(64756008)(66946007)(66446008)(66476007)(66556008)(71200400001)(33656002)(52536014);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dDVaYXlueTJtWjRueUxBeEppNU5RUXB5OEpGbVdORkNqSVp1V2cvRURRVTlN?=
 =?utf-8?B?RFBtZmRSa3BwRURzREg5bnBNaWR6RENlRGZBOFlDbVkxVGJIMGo0bjl1NjNi?=
 =?utf-8?B?VkM1bTQ3NFF5Vk1JbnhaN1MxVEM5MFExSzNmUDhVUHB3bWJqU2xUZGk2YTcy?=
 =?utf-8?B?cHlrcko1WmkvT25rM2NUQ3BoTEpHVngvVHZGTlA4VGlnZ3U3M0RrbDEweDc3?=
 =?utf-8?B?eUlCZEQ1SVdzdEhOQzF1d2pvdUxZZ3E2TEt5QmdJdVVoemVSRC9GNFpQM2hv?=
 =?utf-8?B?aUZpUUpheVdmcmhvNGpKd1RXR2Q2QVcya3JIODlIUUhMdVRSaGZidE9MZmJZ?=
 =?utf-8?B?Rm1UYUlSOFdSQWk2U0c4bU05ZTNJa09tUlNQWHJXVm1iZ3JkSkx6VmhQT21E?=
 =?utf-8?B?MXZkTzZ4VzNtZVNFbVVmbmV1NWhEQ054Yk9Pc1lmb0NjYk53RmFDUmd1REh4?=
 =?utf-8?B?NDQ4dzQ1ODFpL1dLMXYzSXNDVExxWDh0aGtwYnN0Z2dNNnhmMXI2VytQaTJn?=
 =?utf-8?B?am51QmNDYUE0clpvSjYvOHZNMHhET1l0cm1XaTZuNjM1S3hnNlBDM0JUbnRt?=
 =?utf-8?B?aVdheWwrRGc4WkF4WmxTdE80eE1PQm5EL0Y1R2VhWjdiTDh0WnlTTjRCTWFs?=
 =?utf-8?B?a01YOHl5bG1ZZmpxOUcxaS85d3ZaSmJMTEEzMzVuV2h3TjNiY3F4VW5NTVIy?=
 =?utf-8?B?aEpGU1B0MDRueUU4cUNDWjRkS1YwL0Q0MjRZeXQ2MUVPeWdjSHlMY3lYRW8y?=
 =?utf-8?B?b1JLdmluT0ZtS1p6U0xZSDdYZ0ZFTS94NGY5RGdjbG55aWZKdlBuRU5ZeVJx?=
 =?utf-8?B?dlZycU5OTWVyeU5LVVZiSUlqaE5PdUtrSU5jT3BLN1NTNWpwL25yVFZxNk90?=
 =?utf-8?B?ZDErWFptMzZpajRyQ3MveFpPWHAyMXFSdEM5eXduRXFuWUtGSlpmOFc2VUc0?=
 =?utf-8?B?RXhCeTg5K2FmaE4xZWJ3dk9WN0VKVWxiVkxKNWlwZlQwZS9nMTBOYmFhY3Zn?=
 =?utf-8?B?MXZJb0htRG1ydThndngwNGVDQzVzUFF2bnM0ejU2NlZKQlNiMDBWMEZDNFRK?=
 =?utf-8?B?UlRQWVd5WDlub0N3cjhRekVEWHlVRUdCMldNcHU4YjZ6YUlkVWNKdUhWQmR4?=
 =?utf-8?B?VE1SRndrTm9VTTAxcndhaTBJbmR3eHpERWZ5bVNwRWZtWmhoUVMyR1Q5bXFm?=
 =?utf-8?B?b01VWWgzbDhhM3huUFI0d3pha1JMUDZNYUNVTVBMUlIvcXFSTHVhMWlFeHZE?=
 =?utf-8?B?akJWTDJPY2lxNm5yMGdQSW1ybk0xRy9XN0RmN1l1Q1piTEpNbU1TQnFKa1pq?=
 =?utf-8?B?aWg2WXdBa3NiRjdqa0hoZVQ2OFJWbjJObm9UdDNhQVNwN0FuUm5SQVVDckVa?=
 =?utf-8?B?cWp5c0EzK29WTE9BUlZTQkZKbTErQ00wYzNxN2FnR2V5SUV6VWg3andyTG5z?=
 =?utf-8?B?cldtREFUMWlxL1lFcVU1UjZJMXVCaHorUHp4bFptVTBGcUFXTk5iLzFCQVli?=
 =?utf-8?B?WVhiTzQ3SGFlakV2dE5PTUVqaTFTcGJ3bzRJNHVzeUpYL2lpVjVKVW5LZjFS?=
 =?utf-8?B?ZlRDQ0JkaitEbU9JNXJiTlRXVVJtWFh3a0xmWkJRd0pPdlBPRnhlOHhVQTVP?=
 =?utf-8?B?UzI4SFdqb3QvbWZ1aVFFODNCQ2szVHgzVUpwMTVMS0VZVkpHbDdoWFlWdE9k?=
 =?utf-8?B?azJyMnF4Ny9jZGk5VHNOSDcrTXdENHI1b3hKeUh1dDgxZ2xtZnN0VlJ6NVAx?=
 =?utf-8?B?MEFwT0p1UC96NVI2bGhReDFCTkh6S2Y1Q3BUTEFJSzhmSUpCUDhyUVVBU2p0?=
 =?utf-8?B?bmYvY2NlNVJ1RTFzZUxZTVFORFlPT2MwM1pVQUZkN240Z1lHb2RsVDJzTXJo?=
 =?utf-8?B?ejN3aXA3QzJtbGRJQzlMcFBKbWQreHlCSDV2Y1ZGYnF0ZkNiVFFWL3g3Sk1Y?=
 =?utf-8?B?cjhmVExMekRyUzczM3NibHRvd3VRVVhBS3pXUytDMDV3NzJtbVBoOG9XSzVC?=
 =?utf-8?B?amtZMHlSK1ZFTmFHbmN3ZTZPRHAwZW5uSTV0R2lVQ2o2LzQxeEhLZm1GcEU0?=
 =?utf-8?B?UkFXKzNuWk1uSm1hTUkvT2tzYml2bkttM084bnRvWlVrdFdjQlA2cCtjazVQ?=
 =?utf-8?B?dEFxVGsveWlEZ3JqT1BzKzBZUWRYVU03MkFhVmQ4SGFqQmd2b1dPUnAvREpB?=
 =?utf-8?B?cjYzSGJOSUhadUVLRXh6NE1Nd21pVUNxSmJkWitqTjd1ZmJlMFd4ekhLaTd0?=
 =?utf-8?B?NWY3c3NqMXRibGpuUGZGZ28rNXZzTzh2TE56Q2R5QWREZ2hwMW1pSTB5OFpU?=
 =?utf-8?Q?B1qbwHt8JtxY/RK6/w?=
Content-Type: text/plain; charset="utf-8"
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR84MB1718.NAMPRD84.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 07155df5-b091-43a4-41aa-08da22f0123b
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Apr 2022 17:06:11.8296
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 105b2061-b669-4b31-92ac-24d304d195dc
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xkorTcUBwd0V0vBLTinOp1FKPlXep12pqJsREdqLIfJC6S/zvnyLddt6cLgL81Q7tG+Zju0aTWn3o+omoioBnA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR84MB1912
X-OriginatorOrg: hpe.com
X-Proofpoint-GUID: enBdeWg0fph33aKNMBXygw0sVDaF5e0C
X-Proofpoint-ORIG-GUID: enBdeWg0fph33aKNMBXygw0sVDaF5e0C
Content-Transfer-Encoding: base64
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-04-20_05,2022-04-20_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 lowpriorityscore=0 spamscore=0 bulkscore=0 phishscore=0 adultscore=0
 priorityscore=1501 impostorscore=0 mlxlogscore=999 clxscore=1015
 suspectscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2204200101
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCi0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQpGcm9tOiBHdWVudGVyIFJvZWNrIFttYWls
dG86Z3JvZWNrN0BnbWFpbC5jb21dIE9uIEJlaGFsZiBPZiBHdWVudGVyIFJvZWNrDQpTZW50OiBX
ZWRuZXNkYXksIEFwcmlsIDIwLCAyMDIyIDEwOjUzIEFNDQpUbzogSGF3a2lucywgTmljayA8bmlj
ay5oYXdraW5zQGhwZS5jb20+OyBWZXJkdW4sIEplYW4tTWFyaWUgPHZlcmR1bkBocGUuY29tPjsg
SGFyZGVycywgTmljayA8bmljaG9sYXMuaGFyZGVyc0BocGUuY29tPjsgam9lbEBqbXMuaWQuYXU7
IGFybmRAYXJuZGIuZGUNCkNjOiBXaW0gVmFuIFNlYnJvZWNrIDx3aW1AbGludXgtd2F0Y2hkb2cu
b3JnPjsgbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZzsgbGludXgtd2F0Y2hkb2dAdmdlci5r
ZXJuZWwub3JnDQpTdWJqZWN0OiBSZTogW1BBVENIIHY0IDAzLzExXSBkcml2ZXJzOiB3ZHQ6IElu
dHJvZHVjZSBIUEUgR1hQIFNvQyBXYXRjaGRvZw0KDQpPbiA0LzIwLzIyIDA4OjAxLCBuaWNrLmhh
d2tpbnNAaHBlLmNvbSB3cm90ZToNCj4gPiBGcm9tOiBOaWNrIEhhd2tpbnMgPG5pY2suaGF3a2lu
c0BocGUuY29tPg0KPiA+IA0KPiA+IEFkZGluZyBzdXBwb3J0IGZvciB0aGUgSFBFIEdYUCBXYXRj
aGRvZy4gSXQgaXMgbmV3IHRvIHRoZSBsaW51eCANCj4gPiBjb21tdW5pdHkgYW5kIHRoaXMgYWxv
bmcgd2l0aCBzZXZlcmFsIG90aGVyIHBhdGNoZXMgaXMgdGhlIGZpcnN0IA0KPiA+IHN1cHBvcnQg
Zm9yIGl0LiBUaGUgR1hQIGFzaWMgY29udGFpbnMgYSBmdWxsIGNvbXBsaW1lbnQgb2YgdGltZXJz
IG9uZSANCj4gPiBvZiB3aGljaCBpcyB0aGUgd2F0Y2hkb2cgdGltZXIuIFRoZSB3YXRjaGRvZyB0
aW1lciBpcyAxNiBiaXQgYW5kIGhhcyANCj4gPiAxMG1zIHJlc29sdXRpb24uIFRoZSB3YXRjaGRv
ZyBpcyBub3cNCg0KPiAgRHJvcCAibm93Ii4NCg0KSSBoYXZlIGNvcnJlY3RlZCB0aGlzLg0KDQo+
ID4gY3JlYXRlZCBhcyBhIGNoaWxkIGRldmljZSBvZiB0aW1lciBzaW5jZSB0aGUgc2FtZSByZWdp
c3RlciByYW5nZSBpcyANCj4gPiB1c2VkLiBUaGlzIHdhcyBkb25lIGR1ZSB0byBjaGFuZ2VzIHJl
cXVlc3RlZCB3aXRoIHRoZSBkZXZpY2UgdHJlZS4NCj4gPiANCg0KPiBEcm9wIGxhc3Qgc2VudGVu
Y2U7IGl0IGlzIHBhcnQgb2YgdGhlIGNoYW5nZSBsb2cgYW5kIHNob3VsZCBzdGF5IHRoZXJlLg0K
DQpJIGhhdmUgY29ycmVjdGVkIHRoaXMuDQoNCj4gPiAtLS0NCg0KPiBDaGFuZ2VzIG1hZGUgaW4g
djMgYW5kIHY0IGFyZSBtaXNzaW5nLg0KRml4ZWQsIEkgd2lsbCBmaXggdGhpcyBvbiB0aGUgcmVz
dCBvZiB0aGUgcGF0Y2hlcyBvbiB0aGlzIHNldC4NCj4gPiArY29uZmlnIEdYUF9XQVRDSERPRw0K
PiA+ICsJdHJpc3RhdGUgIkhQRSBHWFAgd2F0Y2hkb2cgc3VwcG9ydCINCj4gPiArCWRlcGVuZHMg
b24gQVJDSF9IUEVfR1hQDQo+ID4gKwlzZWxlY3QgV0FUQ0hET0dfQ09SRQ0KPiA+ICsJaGVscA0K
PiA+ICsJICBTYXkgWSBoZXJlIHRvIGluY2x1ZGUgc3VwcG9ydCBmb3IgdGhlIHdhdGNoZG9nIHRp
bWVyDQo+ID4gKwkgIGluIEhQRSBHWFAgU29Dcy4NCj4gPiArDQoNCj4gQWRkIHNvbWV0aGluZyBs
aWtlOg0KDQo+IFRvIGNvbXBpbGUgdGhpcyBkcml2ZXIgYXMgYSBtb2R1bGUsIGNob29zZSBNIGhl
cmU6IHRoZQ0KPiBtb2R1bGUgd2lsbCBiZSBjYWxsZWRneHBfd2R0Lg0KDQpUaGlzIGhhcyBiZWVu
IGNoYW5nZWQuIEkgd2lsbCBsb29rIHRocm91Z2ggdGhlIHJlc3Qgb2YgdGhlIG90aGVyIEtjb25m
aWdzIHRvIG1ha2Ugc3VyZSB0aGlzIHN0YXRlbWVudCBpcyB0aGVyZS4NCg0KVGhhbmtzIGZvciB0
aGUgZmVlZGJhY2ssDQoNCi1OaWNrIEhhd2tpbnMNCg==
