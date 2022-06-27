Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA02955B650
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Jun 2022 06:54:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229516AbiF0EyJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jun 2022 00:54:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230174AbiF0EyI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 00:54:08 -0400
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A4A8271F
        for <linux-kernel@vger.kernel.org>; Sun, 26 Jun 2022 21:54:07 -0700 (PDT)
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
        by mx0a-0016f401.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 25QMx4uw031126;
        Sun, 26 Jun 2022 21:53:49 -0700
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam04lp2041.outbound.protection.outlook.com [104.47.74.41])
        by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 3gwyqqdbvk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 26 Jun 2022 21:53:49 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EpLjcEk5kK/gTT9X6eT3XQMIbU/YuPT0AoJkjOjKpL9gzM8w1wi7KOUYChomZnO6m5J6JQtWCXbMClnG47uRNzCqk4OcXIIBwiqAAd+LjDAabNJknB+oWZrY3UwC8OUJIVTN3T0/KKiUok7Jdh0b3fsylGm3ro+X9LnKplMFWYPPwAVnUCLZ0vFKKT+ZoYM56PzGn5fOHNHH+62+/YJPAjJmxXSWJEZlPA5rkivgeAMdoD1iWavbRs1+Hd+ciBlz22DlpsM2IQVjAS9gH8cgUyNwKpaD6aHQ7of5VlIrbYr4okDjrrcR5lXKBlVmSodIfBSYpvcvKsEPZCf122jC5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FeL/16NeJmY4wZgJiNn+zFFatnARroGicsBfnA4zzlY=;
 b=J2kLd4m5Ma9V87KWvwR2Yzihi59eNHkzGyTy5FFplaBL7fDxmHFcQrpSTrR67tkFXpbluX0+rfi23EUIY5uuj4/+LarqFsDwTzp1xr/uulgbg3NB16qYEDGHsZwAajRIhLpY6F5tTS3rJo4awTqb6DkQUZBkSwHptj+nwfDt7JtARp8rr2RMLtePIJ2q+OaUdDhDZ8Ul6J0hzIbljzP6Qa+hoeBzgmBLBryUyqoS0jweAdA4/AWp30awiZRUy6gGJ8sKon3DjDg/Q517hzViKR9Rtr4QRmHJopQfUwIU3ytd8DgGerobuoQbRh2TSnPb9XVetU+sCuVjw9CmeIeGTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector1-marvell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FeL/16NeJmY4wZgJiNn+zFFatnARroGicsBfnA4zzlY=;
 b=PWxjOw1L8SGrbmQVmLUsfsyWiq/GCI2IpbnsTur7J8e3XvX12UcoWyUgQ/k2adWblcCMKhra8+ByD9rNy3WcDP6cfgl1mGqJE20CoQdNgI07sMS+e9BtU5BV9x/1bdyC4+oNGEzVg4FpRFR1aO7ADHh+un4DeaPTPEKeGSWorms=
Received: from BYAPR18MB2679.namprd18.prod.outlook.com (2603:10b6:a03:13c::10)
 by MWHPR18MB1661.namprd18.prod.outlook.com (2603:10b6:300:ce::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5373.18; Mon, 27 Jun
 2022 04:53:46 +0000
Received: from BYAPR18MB2679.namprd18.prod.outlook.com
 ([fe80::91d4:a49b:eab0:dfc1]) by BYAPR18MB2679.namprd18.prod.outlook.com
 ([fe80::91d4:a49b:eab0:dfc1%5]) with mapi id 15.20.5373.018; Mon, 27 Jun 2022
 04:53:46 +0000
From:   George Cherian <gcherian@marvell.com>
To:     David Laight <David.Laight@ACULAB.COM>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Sunil Kovvuri Goutham <sgoutham@marvell.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>
Subject: RE: [PATCH] genirq: Increase the number of interrupters
Thread-Topic: [PATCH] genirq: Increase the number of interrupters
Thread-Index: AQHYhq+KkGP/e7iu/kSnjqDwb3jSuq1c2HwAgAXc5uA=
Date:   Mon, 27 Jun 2022 04:53:45 +0000
Message-ID: <BYAPR18MB2679D8358A7668CDA534C1C7C5B99@BYAPR18MB2679.namprd18.prod.outlook.com>
References: <20220623031541.1716745-1-george.cherian@marvell.com>
 <7974b4d7782b4f8682547389d4f294f8@AcuMS.aculab.com>
In-Reply-To: <7974b4d7782b4f8682547389d4f294f8@AcuMS.aculab.com>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 181b4330-0484-40fd-0270-08da57f9047d
x-ms-traffictypediagnostic: MWHPR18MB1661:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: rPFKf7zdRFYTBQ+2A0dve5AAMNWIgJhnPqIMQMVhP3QBvbO3//y3P2WLlFcKpOq8RXXlW4JtwVTagl4vZPaczw64LZcfLXeaqpOjWgK5m665nWsVO15H3T0ay48Yg1ItefK8Jo0Z36HMPSvOC7kpdAwnkISE+OaBYWGsBMd0T5sVXRYuK5/5Dd4t36d0UZxwxqYDMGoBU5fofdJAWyo51u60Vw19qP0O3VqzphDrMBGt1MpT+A88Td6ufsCfOzrXBjAgDrfmMcTw66jfj17+iVIus7UUI8lkng6jNjYqSxZ0vKOwf/lWhNlvA0Tck0HtelEQWezBI2YjatPAt5qztLEYHhb17QahVyLB/ma05I+G3vCaa3dzbDmQgHgi8CD9/KGMfI3B9FJp+noTPvf1Dr0DksXXmOIdnXViY3UrjALgyxSaxqTT+87TnGVC9Aefqf2BkKRehcEbThltqWjeQrKSA7ciY8jvCvpl29wrYF73rRYZQNNsjY2WrBWO7VvZbN/TacNwhVuB3u4HMGNkUBlqAmhQz607bqmNkdw1XRA1TjPTNzfnSGWG0d/Vo9hea/0M6WnlOqN1pFtJe5ToQVawc5fzGCVcT+6T3+ikJG8PFfTtTVJ0K4IjogXAuPF9vh0DIOCtG+7bNxxnuwPLVCkRYhfD9AHLHxmGr9qNQ77LUuaqBlU6IS2MsxXNtyMR+77v/mRIkkWhvzi466xiwXqq1KCtnDkg6bXii2Il6pRnT3y5QqQN1jLqu6KKaojpdu5fUUm7qwcWHUOrFfoz41Tk+/0vFl4NEOSwYy0cUGg=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR18MB2679.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(39850400004)(346002)(136003)(366004)(376002)(396003)(53546011)(7696005)(6506007)(8936002)(54906003)(86362001)(41300700001)(38100700002)(83380400001)(122000001)(76116006)(64756008)(8676002)(66556008)(66946007)(2906002)(33656002)(71200400001)(316002)(9686003)(55016003)(186003)(66446008)(66476007)(478600001)(52536014)(4326008)(38070700005)(5660300002)(26005)(110136005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Y0U3S1BNVUd6eWp5empzTVhERE9nUlZIMGRlelRvRTFSQzNxb1NmWm9pZjFU?=
 =?utf-8?B?YU8wT1R4N0ZBUWwyZHp2bm45Y05VSnpZTklvVWszMnFrdnJwby9mYmRodll3?=
 =?utf-8?B?VVBwNXV2U21sMjN6RHhHb25ocTZEdUlJY1g4VGdFV0JoRk03Wm5WSkRzelZB?=
 =?utf-8?B?a09lejhsNHZkWEdZK3NHbDRXQk1QN2V2QWNQcFhHcXg5c1F5QnJWU0NzOC9V?=
 =?utf-8?B?WGJFY3kzZ2crejFyUXlFOUwvQ0J0b09CWG1iN3ViaTVwSTN6WGQ3djhEMnA0?=
 =?utf-8?B?QWxsYWU0VFUyVnk1UmpKdG55Wkpwdyt5VUVsdU9rU1pRRmdSN2VwV202UjBC?=
 =?utf-8?B?YjBQUVdDc0xIcGdYY2czWGtTL3grWE4vZ0FtNGxpUG9iSXVrNlRuZU1Jb09u?=
 =?utf-8?B?K0YxZFZLQVpUajBUV2x5R3FLNXRVMmxYNWRhRU9vcm5UQmxqS0Z4UEszVWNa?=
 =?utf-8?B?L3RpRlpiaGRWaGFCRUhQcGdpQURnV1A1VHVTbEZ4WmV2dnJLWmE0NkNvMGlx?=
 =?utf-8?B?Sk9VangvamliNEZSSG5CeG04R0FYOEIxYTZLRVI0ZURVdmpTUWdGSktWa01u?=
 =?utf-8?B?akg2MTRFUE5YcFg3Y1ZROTJRd043NkU0c0lSU2Ftb25LS05KT1dhNFFGckxh?=
 =?utf-8?B?cTd1RmVUOS9ZRWJaYnVSUTlTTER6eWxmOG1taXN5SnpZNnBiQWNkQy83anRC?=
 =?utf-8?B?T3lod3B6eGNncUhBeTBNM1hvckpXRldNbnU5TkxsUWpVeFpaeXpmT0xqWVQx?=
 =?utf-8?B?emw2b0h2LzZjaGczaS90TFJybmpRL1VaREh6OHNxSGNYWE9tV1VpNi9BZklj?=
 =?utf-8?B?NkhKK2EyajloT0M0UHVRMGFQT2ZKMzFuYjdJcHBzT3o4ckNZY3BpN1lSTkY4?=
 =?utf-8?B?QjRJT0Q4WnAwTWo1NmNKaEl4elQ1Ymo5VnFpaWpodFlGdzdGeEV4MUlSTnI2?=
 =?utf-8?B?Z3FHL2YrOWZQWHJQSDZDSjltMGp4UnhpdGNlaENTa2liaXZTdkRFMU82aSs0?=
 =?utf-8?B?Zlh5OXprOExDUXZ2cVNHUm5LdVNQa0FudE1DMS9JWWJUNkxBVHhaNlVRbEo3?=
 =?utf-8?B?Ky9XL0hwL29ncGJvcmw4Y3VqWVdveEpDSWYyWk1GbzRRT0gvK0Z3UDdmWTUv?=
 =?utf-8?B?SVFBNWh4R25yczN3NWtZWWcyYjlMaWpDY1I3N3dXcS9HV2o3ZU5BL2FOL1gr?=
 =?utf-8?B?Y2lHelM3MWtkK3FMdDNNc2FWNlVXVnZnT1ZlM25vMGtYVXpYU0pWaWI1V2c1?=
 =?utf-8?B?Z2E3RGhIR2xrOWM1RzM2dnVWaVZNZTY3MkcxWGJwdlgzaEsyMUNEZ2xQQklE?=
 =?utf-8?B?RU42cDJWbjl0eVEzZ2p4QUo4RVJndTFlc2RhOWZVaE5TazJIRy9KWVk0Rno2?=
 =?utf-8?B?N0poQ3ZLQUVWaHBpZnVWTnkwVWtSeEZwOFNaQnNKQXFaazRWandlWWY4TExp?=
 =?utf-8?B?ZVRDQ3hIN0FFb09ZcUpGQW5MV0h0cUFsd1VvcUpEU3BUeE5XemFQd0MxaSt5?=
 =?utf-8?B?WXRpbitEVmZHcXMzem1GelFacUIyTDh2dTBBM3NjbWZCS3EzSmZldzF4YWVL?=
 =?utf-8?B?RjVhQkpqNGkyRk5SYS9CSXE1TjJNR0c2ZWFaVm95TjFDbWx5a2tkN3hWMzNv?=
 =?utf-8?B?VzZ4QWwvdmJ4U3VMZ1B6S0VXaE5wNStka1dXaXdCWURtTmpDOTc2V0JnWlRT?=
 =?utf-8?B?QUhheFM5TDlWa0lYS2E1VWNnd2g0djQ2WUNIWkJLbWh2TzNGKzA0Qzh4UnUr?=
 =?utf-8?B?Q0xyWDEydUlvYWFqSEdyaVpjUitIOUpYSWcrZ3pvQ1R2RjJnc3U5dGg1WlhE?=
 =?utf-8?B?MXdCRWhJUkZNNUpNbmJLaHIrUEJUR25zSFBoMlhrRHkvTmlkSHhhTVV4czR4?=
 =?utf-8?B?RWF1TktXdkIrcUxmUTJFdVorUXh6d1B0azdiSE5KM1crQ0xOaGhuaTgydzJw?=
 =?utf-8?B?Yzh5UlpzM0JyTSttRm9ESktLSnBaZmN5SGdsYXdMaGViZXg5c0tTdGRaUzM5?=
 =?utf-8?B?NjVsSDROdlhJRUM0dEtrSmdVMGRIN0NYYzViQUlONy9lOHBudDMvQkVZTVds?=
 =?utf-8?B?a1ZkWkIySlJIWVpEWndWcTBvNG5weHVZMEJTSlExa3JadDBzWlh5MkZML3JK?=
 =?utf-8?Q?2SaFTAmGHxnLlEM4ItaGIYCdX?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR18MB2679.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 181b4330-0484-40fd-0270-08da57f9047d
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Jun 2022 04:53:45.9496
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kae2VZ6hig3pE+J9ta9kV69Kpw0dU7PwOTnMkhHOQO6xV21Rb8Uu5BTJGQo4euGhI9TpBdZCEzvYE0Dg1IecdA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR18MB1661
X-Proofpoint-GUID: mXQVrqNGipesxb7YREdGSry4dMbyKAWq
X-Proofpoint-ORIG-GUID: mXQVrqNGipesxb7YREdGSry4dMbyKAWq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-06-27_02,2022-06-24_01,2022-06-22_01
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogRGF2aWQgTGFpZ2h0IDxE
YXZpZC5MYWlnaHRAQUNVTEFCLkNPTT4NCj4gU2VudDogVGh1cnNkYXksIEp1bmUgMjMsIDIwMjIg
NDo0OCBQTQ0KPiBUbzogR2VvcmdlIENoZXJpYW4gPGdjaGVyaWFuQG1hcnZlbGwuY29tPjsgbGlu
dXgta2VybmVsQHZnZXIua2VybmVsLm9yZw0KPiBDYzogU3VuaWwgS292dnVyaSBHb3V0aGFtIDxz
Z291dGhhbUBtYXJ2ZWxsLmNvbT47IHRnbHhAbGludXRyb25peC5kZQ0KPiBTdWJqZWN0OiBSRTog
W1BBVENIXSBnZW5pcnE6IEluY3JlYXNlIHRoZSBudW1iZXIgb2YgaW50ZXJydXB0ZXJzDQo+IEZy
b206IEdlb3JnZSBDaGVyaWFuDQo+ID4gU2VudDogMjMgSnVuZSAyMDIyIDA0OjE2DQo+ID4NCj4g
PiBDdXJyZW50bHkgdGhlIG1heGltdW0gbnVtYmVyIG9mIGludGVycnVwdGVycyBpcyBjYXBwZWQg
YXQgODI2MCAoNjQgKw0KPiA+IDgxOTYpIGluIG1vc3Qgb2YgdGhlIGFyY2hpdGVjdHVyZXMgd2Vy
ZSBDT05GSUdfU1BBUlNFX0lSUSBpcyBzZWxlY3RlZC4NCj4gPiBUaGlzIHVwcGVyIGxpbWl0IGlz
IG5vdCBzdWZmaWNpZW50IGZvciBjb3VwbGUgb2YgZXhpc3RpbmcgU29DJ3MgZnJvbQ0KPiA+IE1h
cnZlbGwuDQo+ID4gRm9yIGVnOiBPY3Rlb24gVFgyIHNlcmllcyBvZiBwcm9jZXNzb3JzIHN1cHBv
cnQgYSBtYXhpbXVtIG9mIDMySw0KPiA+IGludGVycnVwdGVycy4NCj4gPg0KPiA+IEJ1bXAgdXAg
dGhlIHVwcGVyIGxpbWl0IGZyb20gODE5NiB0byA2NTUzNi4NCj4gDQo+IFRoaXMgc2VlbXMgdG8g
YWRkIDdrQiBvZiBzdGF0aWMgZGF0YSB0byB0aGUga2VybmVsIGp1c3Qgb24gdGhlIG9mZiBjaGFu
Y2UgdGhhdA0KPiBzb21lIHNwYXJzZSBpbnRlcnJ1cHQgbnVtYmVycyBhcmUgbGFyZ2UuDQo+IA0K
PiAJRGF2aWQNCj4gDQpIb3cgYWJvdXQgYWRkaW5nIGFub3RoZXIgQ09ORklHX1NQQVJTRV9JUlFf
RVhURU5ERUQgdG8gaW5jcmVhc2UgdGhlIGNvdW50Pw0KDQotR2VvcmdlDQo+ID4NCj4gPiBTaWdu
ZWQtb2ZmLWJ5OiBHZW9yZ2UgQ2hlcmlhbiA8Z2VvcmdlLmNoZXJpYW5AbWFydmVsbC5jb20+DQo+
ID4gLS0tDQo+ID4gIGtlcm5lbC9pcnEvaW50ZXJuYWxzLmggfCAyICstDQo+ID4gIDEgZmlsZSBj
aGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMSBkZWxldGlvbigtKQ0KPiA+DQo+ID4gZGlmZiAtLWdp
dCBhL2tlcm5lbC9pcnEvaW50ZXJuYWxzLmggYi9rZXJuZWwvaXJxL2ludGVybmFscy5oIGluZGV4
DQo+ID4gZjA5YzYwMzkzZTU1OS4uOWJiNDI3NTdkNGFmYyAxMDA2NDQNCj4gPiAtLS0gYS9rZXJu
ZWwvaXJxL2ludGVybmFscy5oDQo+ID4gKysrIGIva2VybmVsL2lycS9pbnRlcm5hbHMuaA0KPiA+
IEBAIC0xMiw3ICsxMiw3IEBADQo+ID4gICNpbmNsdWRlIDxsaW51eC9zY2hlZC9jbG9jay5oPg0K
PiA+DQo+ID4gICNpZmRlZiBDT05GSUdfU1BBUlNFX0lSUQ0KPiA+IC0jIGRlZmluZSBJUlFfQklU
TUFQX0JJVFMJKE5SX0lSUVMgKyA4MTk2KQ0KPiA+ICsjIGRlZmluZSBJUlFfQklUTUFQX0JJVFMJ
KE5SX0lSUVMgKyA2NTUzNikNCj4gPiAgI2Vsc2UNCj4gPiAgIyBkZWZpbmUgSVJRX0JJVE1BUF9C
SVRTCU5SX0lSUVMNCj4gPiAgI2VuZGlmDQo+ID4gLS0NCj4gPiAyLjI1LjENCj4gDQo+IC0NCj4g
UmVnaXN0ZXJlZCBBZGRyZXNzIExha2VzaWRlLCBCcmFtbGV5IFJvYWQsIE1vdW50IEZhcm0sIE1p
bHRvbiBLZXluZXMsDQo+IE1LMSAxUFQsIFVLIFJlZ2lzdHJhdGlvbiBObzogMTM5NzM4NiAoV2Fs
ZXMpDQoNCg==
