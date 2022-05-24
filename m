Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 392195329CB
	for <lists+linux-kernel@lfdr.de>; Tue, 24 May 2022 13:57:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237074AbiEXL4b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 May 2022 07:56:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237073AbiEXL4W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 May 2022 07:56:22 -0400
Received: from esa.hc3962-90.iphmx.com (esa.hc3962-90.iphmx.com [216.71.142.165])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1056F1E3D4;
        Tue, 24 May 2022 04:56:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qccesdkim1;
  t=1653393379; x=1653998179;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=V7tS8ynfU6w5iK3J7XC98YOP1So9Rz/wV1TXvb3JqhE=;
  b=Hn3Kt75i8utb/Iq575Mplq5QpF3Dh3FBETqchQkQjF1eR3oKpeAxU+Z5
   Qa3RIJeUKJGnO0cNrQRjVlXhLpBOkC7aARVWOcI9JgjPhnkKR/f52NFKR
   mzWV8k4R6q0pIDRLAaipnpYBhwALTy54i43GpZzu8j0aJ4CaKfAO0RSD1
   U=;
Received: from mail-mw2nam12lp2042.outbound.protection.outlook.com (HELO NAM12-MW2-obe.outbound.protection.outlook.com) ([104.47.66.42])
  by ob1.hc3962-90.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 May 2022 11:56:18 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mFqio/C/+lswIdtBGkAeMo4e0+hFiZPtGvLGYxn13fkkTYBNaES6WsLBLpsGKpotwucgQi1QmSGYZx3/nUfMCgAHuZAtgj/aFj6JhdXYL53lAYC5Uffs2sf60d/hFm6j/AM2T1C2FTtHyPrUGlrqqwALgtO2CDK7WExe+dVqkU3fo7gFO80zYQAdOhgORiMMeroDA0Mctf4X0xAfqUf2gX/HPIA8XPNZIeiW8qnlBAST25eS5GDBRWyOzGjMURjcVuSycmV1hLeG5oZ8FHi8VrN2Q8NxTT7rkq0FLXMFBzlm9klNG+ECluPJYSvCyOlZbvoY1fZGHrrTFZEmgcmOkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V7tS8ynfU6w5iK3J7XC98YOP1So9Rz/wV1TXvb3JqhE=;
 b=ZHsnLDukwuhpsRwgENDV7nJ0FsSna7VvjAq3BxfmipG/5UJWdYycUlcsTSiYlT7JLvF9n2djF4iJvGhi1UypJOS3EgdL9t6dRr4noxWM1olvljgseaZxoYfvRkGgell2GopnfgfV1oK15s7Ekv83O+nLEy2IHX0rvNJ/06LUZRVgYbfIL7S7osvc+DUYPfBp9/WMe4iA8sFMMqvWNeg0a1y7XjoPvah1Dg4j+4LhUPaZQHgga7BAfpd9b5K7xaqmi6H5tLyrM3cjh3Y+x77S2FaxDxYQNFfuaMKZz3xl8eyeGAwFGfhTL/lhe2pAkUwok7kb4svUZ3Qh0Q/v+KgAWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=quicinc.com; dmarc=pass action=none header.from=quicinc.com;
 dkim=pass header.d=quicinc.com; arc=none
Received: from MWHPR0201MB3466.namprd02.prod.outlook.com
 (2603:10b6:301:7b::26) by SN6PR02MB5247.namprd02.prod.outlook.com
 (2603:10b6:805:72::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.19; Tue, 24 May
 2022 11:56:16 +0000
Received: from MWHPR0201MB3466.namprd02.prod.outlook.com
 ([fe80::9cea:75bd:9c0c:2865]) by MWHPR0201MB3466.namprd02.prod.outlook.com
 ([fe80::9cea:75bd:9c0c:2865%5]) with mapi id 15.20.5273.022; Tue, 24 May 2022
 11:56:16 +0000
From:   "Kamasali Satyanarayan (Consultant) (QUIC)" 
        <quic_kamasali@quicinc.com>
To:     'Ulf Hansson' <ulf.hansson@linaro.org>,
        "Sarthak Garg (QUIC)" <quic_sartgarg@quicinc.com>
CC:     "u.kleine-koenig@pengutronix.de" <u.kleine-koenig@pengutronix.de>,
        "YehezkelShB@gmail.com" <YehezkelShB@gmail.com>,
        "rmk+kernel@armlinux.org.uk" <rmk+kernel@armlinux.org.uk>,
        "t.scherer@eckelmann.de" <t.scherer@eckelmann.de>,
        "s.shtylyov@omp.ru" <s.shtylyov@omp.ru>,
        "sensor1010@163.com" <sensor1010@163.com>,
        "sartgarg@codeaurora.org" <sartgarg@codeaurora.org>,
        "hns@goldelico.com" <hns@goldelico.com>,
        "uic_kamasali@quicinc.com" <uic_kamasali@quicinc.com>,
        "tiantao6@hisilicon.com" <tiantao6@hisilicon.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "'quic_spathi@quicinc.com'" <quic_spathi@quicinc.com>
Subject: RE: [PATCH V1] mmc: sdhci-msm: Add wakeup functionality support for
 sdio cards
Thread-Topic: [PATCH V1] mmc: sdhci-msm: Add wakeup functionality support for
 sdio cards
Thread-Index: AQHYWU2EfqgIMsk+TUiOhuILUulq5K0CyVgAgCtOmDw=
Date:   Tue, 24 May 2022 11:56:16 +0000
Message-ID: <MWHPR0201MB34661086E86F830C6831CC99E3D79@MWHPR0201MB3466.namprd02.prod.outlook.com>
References: <1650964225-6705-1-git-send-email-quic_spathi@quicinc.com>
 <CAPDyKFoq2zJwTT6JrnvEjh0VvJLkt6PKhk9KhwVjTF0Eq3jOYw@mail.gmail.com>
In-Reply-To: <CAPDyKFoq2zJwTT6JrnvEjh0VvJLkt6PKhk9KhwVjTF0Eq3jOYw@mail.gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=quicinc.com;
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 570b8396-dbaa-4e58-38ab-08da3d7c6849
x-ms-traffictypediagnostic: SN6PR02MB5247:EE_
x-ld-processed: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d,ExtAddr
x-microsoft-antispam-prvs: <SN6PR02MB52477C212C0931C7A0BB48BE9FD79@SN6PR02MB5247.namprd02.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Xe8c8XPIS+f51UM+qPnqekSo2BrRq/GESnWWWipaWKlqwszcS5bJNToOK0xi6qfFcx2VxmZr5ZOwqUIcwA1TUZN6SR0PCrFz8P4SWUH2/3ekp4cV61vjTTLhD6ogSDlp8mNrz0fFBVbB2MVvwjGHsw+q73Fs+WoFTFTTK+mybhxnnRLSxULDHYLhlhcBBzO0Z+GpHDQVqY8qjn/eAO7dQOe3fmFLKXQKJCwZKVgGdrEHMVopb+5GFhF6Ie9vh2NRB2pq5VPJDN4gjXvBJ0nqbXeRhRQlt7kJcOZU5SQdeuEpACP5zqPWgeqb69XTDS+yE0wCdLPJPbHXXjN1flQxTWkJXtT01yQoLgrWJD6lWiDA7XOySh8DYr+Xq2THgdJ8pWxJrQ+omx85SlYxzIK8ozWitsYD/tmhqCv9UapiCZyOhCRYN4Gx6ekmy5ol+AmVf6oEMtQyb16Gp4NNTagvdFjFAcl7SES3yyV+bCglaazuT7jUmaUnv9zKW0nzNjzfnMvp+Q4SY9rMDs81BM3myMnEnAofEZ1+dJkay2yLD5XAstFqiexRi6rN2RT7LvrNDauaBxsq5zALXq8m2MIf/zRy4mjy/tBO/wAzX6L2xuaN2whIKi48wZH4K1hbs2vc5EI+QEfZMdEtYvImFYWEBAldNmr5T4ifyO8PmGlaz4OHSdE2y29L1rY24ngj2EdGYuAX1UGbfFXGNEp19a0MCQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR0201MB3466.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(7416002)(52536014)(55016003)(508600001)(9686003)(5660300002)(38100700002)(4326008)(66446008)(66946007)(6506007)(6636002)(76116006)(7696005)(33656002)(66556008)(54906003)(8936002)(71200400001)(64756008)(2906002)(8676002)(66476007)(107886003)(186003)(38070700005)(26005)(316002)(83380400001)(122000001)(53546011)(110136005)(86362001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?YWJzT3NtbHJyNjlOM2VUUlY2bFIxQWtmMzRWdzd4U1VZRklnUCt2WVlRVjhm?=
 =?utf-8?B?TzZPSC82RzR4b3ZPRm8rZUZMU2ZkQ2VLQ1FjTVpaTStGNmFvb3lSS0RLZXd2?=
 =?utf-8?B?Y3BMTzlBZ1UwVXEzKzU5MlFRbnFXdnFJczV1QVIwUnNmODM1MDhxajdRWXcv?=
 =?utf-8?B?eTBiNEZLQU9uU2FxY2g3eW14VlJWc0xWWi9DR2NXWWdqWGRodXVyYVlndWMy?=
 =?utf-8?B?Q1ZtTzBMOWxzZ3liTzdCdGFhd0hYQTNHdEsxT05xV3J1VWplbEExT0N4cFF6?=
 =?utf-8?B?NlNlbHp4bDZ2TG9reE9SQ2VmMkpWWVh0V05TaTJTb0hjUkhnTXQrOGxoa3NG?=
 =?utf-8?B?QnFjeTYwaDlJaGpNT2lYem9UdlBjMDdTNlR0UlJKY05qSUVOVFc4Tm1jc3Ix?=
 =?utf-8?B?MFpUdmZFdW9rZGNJZ1M1ZG9DWGN5ZlU2Sm90cnhhLzdsdzhrcUY5SGtvQnBU?=
 =?utf-8?B?dlpBaXBvemlKL1JVZnlub205WXJLdUhoQkl3d0dvaFQyM3RWL1Q0aXd5MGdo?=
 =?utf-8?B?U1Nha0tPaGVUcVhZQ2Nrd0R4S1NrQUQ1aEdkQjc0Z3pjZ1BWRnRESDdpRHZn?=
 =?utf-8?B?d0lrVzdzRWRsUk1FS3hiVklCanNnYk10cGlKeEthMG5nTjczUHJyeDlZbWFr?=
 =?utf-8?B?ZDZXV3pCS3psYzFvYmEwaldvMU1ubjRjeDkzd3NvQ0xwVXFxcVhUTTVtTlNJ?=
 =?utf-8?B?TVpBZG9PQ0VDNUZRUXowY0F4TFRpdlM4cDUzSjNwcGVzTTQ5SkdGV1FXSFhj?=
 =?utf-8?B?RXFGeHB1M0xXb3JLZFRQRkFHbmEzT1ZkRXlYTWIxWWlFVEM1T01vMm1DdVdK?=
 =?utf-8?B?YS9ZamRhQ0VQWmpJOE4yNXBXT1UyTUlxd0NYZFlTbTMxSCt1TWtaUi9jcE1h?=
 =?utf-8?B?SHpCY1MwUnZQQ1F2czNxVTJYWjdlQThLR1c1MzdKdWUxWE8vWkh1eWcrdDRj?=
 =?utf-8?B?cjNlSUlxQmJXdmtnNmpDcmdPQmI1R3B0NlVTM2xTN0gzL05xbVhuckxiR3ps?=
 =?utf-8?B?SkNrY1FteFhPbGlDYkx1Q2VVYWR5UUFmWG5UTlJ6eXNETlVyVzIwVU5mdUNG?=
 =?utf-8?B?anVBOTVrNDUzT2NrZHhneVdSZHMyWkQ2TVU0bGQ2RHR2RjBRWHpFL3ByQndT?=
 =?utf-8?B?c2dJYkEzNmQvTFkxME5qNmpoMVlrYjM1T1RBeHZ4Tno4TTY0elFBcXpNQ1hM?=
 =?utf-8?B?UUFZb0podE1wVWV4QXp0NWt5R09wUEJwOEJqNjdlcXVsQWNTZE45dmN0c1Y2?=
 =?utf-8?B?MkxMcVYzUTkwVnB4Qk0wY2dQWW84UnF5Nm1sL0NHU0w3R0g2NGhYVTl0aC92?=
 =?utf-8?B?WklOWk5tenBHWE1LSVQ5akN5dzFKQ21Mblc0TmNPLzcxVVFOVitvdXg1MEhy?=
 =?utf-8?B?NVdnRVduZCtlRDlKUldaTjl0ckRKNlFmZHpJYXgrdmttWmN6TnR2TzdmWWdx?=
 =?utf-8?B?aDZJVHNxbkdqUWgwZCtyM2tMWlI5VEZGWEVwUThvTWN4K1NCN2N6S0c3VDg0?=
 =?utf-8?B?VHMyS1k2Q2Nqdk1ZcVQ4eGhDbHBKenRzSWlqalVyVThYQ09ydE5sUmJkU0lQ?=
 =?utf-8?B?WTdwaVJ0bUNmSEZNLzRwcEw3RU0xMGNMNTVld2g2MUY1RUY3RDhZRU8vWUxG?=
 =?utf-8?B?UElueTFNcjM3c1NwS1JISlJjY0s1UWtLUStNaXp5SmE4c3VMeGZHbmtkVFZ4?=
 =?utf-8?B?dEtYU3M4a29GVHlMY3RNZ1BTMElJWXhYMnpwTmJHVHoyanhaNklWWXRuQ3Vq?=
 =?utf-8?B?aktCS3VDS1NFZERiQlpFZk1GYVR1OVc0OU1Ba1h4QlJYSmwzZ0pjWkNzdGxL?=
 =?utf-8?B?OHA0L0FTL3owb1FubFdQdThyN3N3RDVVdENrcms4WnZId1RBcnE5NW14Sysv?=
 =?utf-8?B?M3ZmbG5jWnVCMnIyb09PTFFWa1phL2F2a0tVbDlOTkJjMmp4QnhDQ09pR1Jy?=
 =?utf-8?B?c0tSa2NEdDArbmsxbE4xV1N3TWtHZEFhZ0lIRTlDVUhtOHAzOWljY3gxa2lV?=
 =?utf-8?B?WnNTYWxSZGFtTTdGQnBmTEV6RWswa2pwSjhOTDZVeldrK2llU09PeXR0NUFl?=
 =?utf-8?B?dVp3V0R3b3hVQW5YMVVSc05qYjF6RlNzbDd1MzhsRXdyZUFjakZGTVFoOVo2?=
 =?utf-8?B?RWNPZGdNT0IvM3dBOTkrNzBLNmh0RzhUN0V6a3ZsMnJ1UzZjbXI4OEtoNlhC?=
 =?utf-8?B?elh1azd1aHlpSVArME5sZitBd0ZyL1JPMGNvYkNqQm1jSUR5b2ppWk83eUZV?=
 =?utf-8?B?bytBTGoxZ0tKbi96T3ZGaExYZ2tyOWh6UUlySWhIZllmMFNmT3lpS1lVRDlP?=
 =?utf-8?B?T3VHbHJrMzJiaTlZaVdld2ZEd0xrUXlVSWl0ZHRPOVN3anZmYzc4dz09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: quicinc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR0201MB3466.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 570b8396-dbaa-4e58-38ab-08da3d7c6849
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 May 2022 11:56:16.0589
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZtHCziOaPmOsPLvt/rd5EaIy9gvSDLKqUbiehej3fmGmv5YeqicHjgOqz9aiHTTjaNmC/XSVycYNh9edu8kVfp2MWaI61L+w2/V3UeR5vQg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR02MB5247
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksDQpUaGVzZSBwYXRjaGVzIHdpbGwgYmUgZnVydGhlciB0YWtlbiBieSBTYXJ0aGFrLg0KDQpU
aGFua3MsDQpTYXR5YQ0KDQotLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KRnJvbTogVWxmIEhh
bnNzb24gPHVsZi5oYW5zc29uQGxpbmFyby5vcmc+IA0KU2VudDogV2VkbmVzZGF5LCBBcHJpbCAy
NywgMjAyMiA0OjA2IEFNDQpUbzogcXVpY19zcGF0aGkgPHF1aWNfc3BhdGhpQHF1aWNpbmMuY29t
Pg0KQ2M6IHUua2xlaW5lLWtvZW5pZ0BwZW5ndXRyb25peC5kZTsgWWVoZXprZWxTaEJAZ21haWwu
Y29tOyBybWsra2VybmVsQGFybWxpbnV4Lm9yZy51azsgdC5zY2hlcmVyQGVja2VsbWFubi5kZTsg
cy5zaHR5bHlvdkBvbXAucnU7IHNlbnNvcjEwMTBAMTYzLmNvbTsgc2FydGdhcmdAY29kZWF1cm9y
YS5vcmc7IGhuc0Bnb2xkZWxpY28uY29tOyB1aWNfa2FtYXNhbGlAcXVpY2luYy5jb207IHRpYW50
YW82QGhpc2lsaWNvbi5jb207IGxpbnV4LW1tY0B2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LWtlcm5l
bEB2Z2VyLmtlcm5lbC5vcmc7IEthbWFzYWxpIFNhdHlhbmFyYXlhbiAoQ29uc3VsdGFudCkgKFFV
SUMpIDxxdWljX2thbWFzYWxpQHF1aWNpbmMuY29tPg0KU3ViamVjdDogUmU6IFtQQVRDSCBWMV0g
bW1jOiBzZGhjaS1tc206IEFkZCB3YWtldXAgZnVuY3Rpb25hbGl0eSBzdXBwb3J0IGZvciBzZGlv
IGNhcmRzDQoNCk9uIFR1ZSwgMjYgQXByIDIwMjIgYXQgMTE6MTAsIFNyaW5pdmFzYXJhbyBQYXRo
aXBhdGkgPHF1aWNfc3BhdGhpQHF1aWNpbmMuY29tPiB3cm90ZToNCj4NCj4gRnJvbTogU2FydGhh
ayBHYXJnIDxzYXJ0Z2FyZ0Bjb2RlYXVyb3JhLm9yZz4NCj4NCj4gVGhpcyBhZGRzIGV4dGVybmFs
IEdQSU8gd2FrZXVwIHN1cHBvcnQgdG8gc2RoY2ktbXNtIGRyaXZlciBmb3Igc2RpbyANCj4gY2Fy
ZHMuDQoNClRoZXJlIGlzIG5vdCBhIHNpbmdsZSBsaW5lIGNoYW5nZWQgaW4gdGhlIHNkaGNpLW1z
bSBkcml2ZXIsIHNvIEkgYW0gbm90IHN1cmUgd2hhdCB0aGlzIGlzIGludGVuZGVkIHRvIGZpeC4N
Cg0KSSBhc3N1bWUgdGhpcyBpcyBhIGRvd25zdHJlYW0gcGF0Y2ggeW91IHdhbnQgdG8gdXBzdHJl
YW0sIHdoaWNoIGlzIGEgZ29vZCB0aGluZyB0aGF0IHdlIGFsbCBhcHByZWNpYXRlLiBIb3dldmVy
LCBiZWZvcmUganVzdCBwb3N0aW5nIGEgcGF0Y2ggZnJvbSBkb3duc3RyZWFtIGNvZGUsIHBsZWFz
ZSBoYXZlIGEgbG9vayBhdCB0aGUgY29tbWl0IG1lc3NhZ2UgYW5kIGxldCBpdCBleHBsYWluIHdo
YXQgYW5kIHdoeSB5b3Ugd2FudCB0byBjaGFuZ2UgdGhpbmdzLg0KDQpJIGFtIGRlZmVycmluZyB0
byByZXZpZXcgdGhpcywgdW50aWwgeW91IHBvc3QgYSB2ZXJzaW9uIHdpdGggYSBwcm9wZXIgY29t
bWl0IG1lc3NhZ2UuIFNvcnJ5Lg0KDQpLaW5kIHJlZ2FyZHMNClVmZmUNCg0KPg0KPiBBbHNvIGVu
YWJsZXMgY2xrIGdhdGluZyBvbmx5IGluIHN5c3RlbSBTdXNwZW5kL1Jlc3VtZSBmb3IgU0RJTyBj
YXJkLg0KPg0KPiBBbHNvIGFkZCB0aGUgYmVsb3cgZml4ZXMgZnJvbSA0Ljkga2VybmVsIDoNCj4N
Cj4gYzM2MzIyNGI6IEZpeCB3YWtldXAgZnVuY3Rpb25hbGl0eSBmb3IgU0RJTw0KPiA2MWZjNWJm
NjogUmVtb3ZlIGZsYWcgTU1DX1BNX1dBS0VfU0RJT19JUlEgaW4gbW1jX3Jlc3VtZV9ob3N0DQo+
IGE3YTJhODJlOiBTZXQgc2Rpb19wZW5kaW5nX3Byb2Nlc3NpbmcgZGVmYXVsdCBzdGF0ZSB0byBm
YWxzZS4NCj4NCj4gU2lnbmVkLW9mZi1ieTogU2FydGhhayBHYXJnIDxzYXJ0Z2FyZ0Bjb2RlYXVy
b3JhLm9yZz4NCj4gU2lnbmVkLW9mZi1ieToga2FtYXNhbGkgPHF1aWNfa2FtYXNhbGlAcXVpY2lu
Yy5jb20+DQo+IFNpZ25lZC1vZmYtYnk6IFNyaW5pdmFzYXJhbyBQYXRoaXBhdGkgPHF1aWNfc3Bh
dGhpQHF1aWNpbmMuY29tPg0KPiAtLS0NCj4gIGRyaXZlcnMvbW1jL2NvcmUvYnVzLmMgIHwgNyAr
KysrKysrDQo+ICBkcml2ZXJzL21tYy9jb3JlL3NkaW8uYyB8IDEgKw0KPiAgMiBmaWxlcyBjaGFu
Z2VkLCA4IGluc2VydGlvbnMoKykNCj4NCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvbW1jL2NvcmUv
YnVzLmMgYi9kcml2ZXJzL21tYy9jb3JlL2J1cy5jIGluZGV4IA0KPiA1OGE2MGFmLi5hNDc1ZmUx
IDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL21tYy9jb3JlL2J1cy5jDQo+ICsrKyBiL2RyaXZlcnMv
bW1jL2NvcmUvYnVzLmMNCj4gQEAgLTM2NCw2ICszNjQsMTMgQEAgaW50IG1tY19hZGRfY2FyZChz
dHJ1Y3QgbW1jX2NhcmQgKmNhcmQpICAjZW5kaWYNCj4gICAgICAgICBjYXJkLT5kZXYub2Zfbm9k
ZSA9IG1tY19vZl9maW5kX2NoaWxkX2RldmljZShjYXJkLT5ob3N0LCAwKTsNCj4NCj4gKyAgICAg
ICBpZiAobW1jX2NhcmRfc2RpbyhjYXJkKSkgew0KPiArICAgICAgICAgICAgICAgcmV0ID0gZGV2
aWNlX2luaXRfd2FrZXVwKCZjYXJkLT5kZXYsIHRydWUpOw0KPiArICAgICAgICAgICAgICAgaWYg
KHJldCkNCj4gKyAgICAgICAgICAgICAgICAgICAgICAgcHJfZXJyKCIlczogJXM6IGZhaWxlZCB0
byBpbml0IHdha2V1cDogJWRcbiIsDQo+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
bW1jX2hvc3RuYW1lKGNhcmQtPmhvc3QpLCBfX2Z1bmNfXywgcmV0KTsNCj4gKyAgICAgICB9DQo+
ICsNCj4gICAgICAgICBkZXZpY2VfZW5hYmxlX2FzeW5jX3N1c3BlbmQoJmNhcmQtPmRldik7DQo+
DQo+ICAgICAgICAgcmV0ID0gZGV2aWNlX2FkZCgmY2FyZC0+ZGV2KTsNCj4gZGlmZiAtLWdpdCBh
L2RyaXZlcnMvbW1jL2NvcmUvc2Rpby5jIGIvZHJpdmVycy9tbWMvY29yZS9zZGlvLmMgaW5kZXgg
DQo+IDI1Nzk5YWMuLjk1MDIzMTggMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvbW1jL2NvcmUvc2Rp
by5jDQo+ICsrKyBiL2RyaXZlcnMvbW1jL2NvcmUvc2Rpby5jDQo+IEBAIC0xMDk2LDYgKzEwOTYs
NyBAQCBzdGF0aWMgaW50IG1tY19zZGlvX3Jlc3VtZShzdHJ1Y3QgbW1jX2hvc3QgKmhvc3QpDQo+
ICAgICAgICAgbW1jX3JlbGVhc2VfaG9zdChob3N0KTsNCj4NCj4gICAgICAgICBob3N0LT5wbV9m
bGFncyAmPSB+TU1DX1BNX0tFRVBfUE9XRVI7DQo+ICsgICAgICAgaG9zdC0+cG1fZmxhZ3MgJj0g
fk1NQ19QTV9XQUtFX1NESU9fSVJROw0KPiAgICAgICAgIHJldHVybiBlcnI7DQo+ICB9DQo+DQo+
IC0tDQo+IDIuNy40DQo+DQo=
