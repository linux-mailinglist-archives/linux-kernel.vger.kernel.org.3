Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B322A566366
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jul 2022 08:51:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229762AbiGEGvT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jul 2022 02:51:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229485AbiGEGvQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 02:51:16 -0400
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE0E2F73;
        Mon,  4 Jul 2022 23:51:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1657003874; x=1688539874;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=7lZSwUbPzxesQbBttSNluTVCsLURgj4w8OTmWX/RnNA=;
  b=UCHH1Ljil45x3dHdetJ9iHczXu4cXMN8vlspys61CNFM4j7B8uBiIIno
   I5Ssml8Dl9bdie3AjgqIHsL8/9ELjbH++NCMq53dQig9n4+7I7gxw91cu
   Zx+an1hiQ9blqIgaAN26wAxBMifubz/ABBJ0lzyCTwraIBXrgIuTupAty
   6grsD+YEOiKAd+6W3tUIqpN312PhhokXRkQH9Lcqtv3UaJNPRp8zmgCIy
   5zeau6masIpJNiUM9zVlHHCw1xAEnLrxYXFd7h5MU6r34+O6ZU0O5Qv5g
   u3xM4adxxuMjedavfAOPW0DsrdleUL1q4buHUETzxVvv+yGdy/3AvZqlK
   Q==;
X-IronPort-AV: E=Sophos;i="5.92,245,1650902400"; 
   d="scan'208";a="204825135"
Received: from mail-mw2nam12lp2046.outbound.protection.outlook.com (HELO NAM12-MW2-obe.outbound.protection.outlook.com) ([104.47.66.46])
  by ob1.hgst.iphmx.com with ESMTP; 05 Jul 2022 14:51:12 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fbB05uIqamnUEVs3i8uHe9i2Y+IFPBwqli9SdbEOYGCFBgzaci1GBsXv8U/OcnkNc+ExncZqEmzQW4SzQ0h8TFomHSDPt4iHLxt4TBZrzuMUA/3PYg74fk+GRnw8c1IAfDBhq/w9sMDbB4UbGhCZC8EN5vwbQUIjT1iFuRNI3Qo+AmPilb8YdNzjje4qdHpsBeNsRB0vacXbvmJYHEyLcJhR6vD+Ld7cCXnSE49rdPNXiLOKlg2wIQvKB3WtNyaomH8f9zdbDUw4SIMxBf4v5VN95ftA9lDXXbEAqh8MZWga+DR3pwOnL0tCHsNquC4lVUTttQhLhrtGzz2ywgT1+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7lZSwUbPzxesQbBttSNluTVCsLURgj4w8OTmWX/RnNA=;
 b=F9XrXikx3BKT5xBoL1DEWnXe4VrxheDdA+FIMf7LIBzPivLk2xAWdt2WHVPTMmy3pojUeUGBo+ORggNIUGZU1VBZwKvWR122blSull8X8i4e2RcacOJmzVFAnUxbPhp+jaTocScWI4WWQF/zd/f2k76bPZx2AOHHnyXpe17SjuDUlAvkNsG+QKGH69MFKMu0LgO9x/Pqq4pwhZvhL6es0NIBuw5hM3ZKEdmVoK+4hAmfddRhU0jQ6jY4NF08oZFpGS5A8Sb87MwM6A7ZR1qDUU/XYIGm5HzCHMwVlOlxqbVf0kKOgsDY2W4pJl7npGYgLf+iauklN4tuZ1XVF2Ma2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7lZSwUbPzxesQbBttSNluTVCsLURgj4w8OTmWX/RnNA=;
 b=p3NwSaNI7/dzg1AvITX7d/eu3lDl7jOi/nTroxc6n7mwGVAMhA3oEOFBvATXO+i9uCaQOZWXf8s4aMtd7dmxGHo89PP9iArqi32ztJMQZ6hGHZcx0fivw3zlkcrwlctZljOaCxbBHYTdk30Bq+iWDPJgzwXe1bcwyX/UJfv8x/E=
Received: from DM6PR04MB6575.namprd04.prod.outlook.com (2603:10b6:5:1b7::7) by
 DM6PR04MB4236.namprd04.prod.outlook.com (2603:10b6:5:a4::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5395.20; Tue, 5 Jul 2022 06:51:10 +0000
Received: from DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::5d26:82d8:6c89:9e31]) by DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::5d26:82d8:6c89:9e31%9]) with mapi id 15.20.5395.021; Tue, 5 Jul 2022
 06:51:10 +0000
From:   Avri Altman <Avri.Altman@wdc.com>
To:     Seunghui Lee <sh043.lee@samsung.com>,
        "alim.akhtar@samsung.com" <alim.akhtar@samsung.com>,
        "bvanassche@acm.org" <bvanassche@acm.org>,
        "jejb@linux.ibm.com" <jejb@linux.ibm.com>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "grant.jung@samsung.com" <grant.jung@samsung.com>,
        "jt77.jang@samsung.com" <jt77.jang@samsung.com>,
        "dh0421.hwang@samsung.com" <dh0421.hwang@samsung.com>,
        "junwoo80.lee@samsung.com" <junwoo80.lee@samsung.com>,
        "jangsub.yi@samsung.com" <jangsub.yi@samsung.com>,
        "cw9316.lee@samsung.com" <cw9316.lee@samsung.com>,
        "sh8267.baek@samsung.com" <sh8267.baek@samsung.com>,
        "wkon.kim@samsung.com" <wkon.kim@samsung.com>,
        "seunghwan.hyun@samsung.com" <seunghwan.hyun@samsung.com>
Subject: RE: [PATCH] scsi: ufs: no sw reset after last linkstartup fail
Thread-Topic: [PATCH] scsi: ufs: no sw reset after last linkstartup fail
Thread-Index: AQI5aYjeE/9Eh4/d2WnB5RXwuc7qWwHvC5v0rJzc7OCAAUgekA==
Date:   Tue, 5 Jul 2022 06:51:10 +0000
Message-ID: <DM6PR04MB6575621775F19168CC21F7DBFC819@DM6PR04MB6575.namprd04.prod.outlook.com>
References: <CGME20220630041602epcas1p3f3427b4ceac68f8325d3f89bc8635603@epcas1p3.samsung.com>
        <20220630044804.6080-1-sh043.lee@samsung.com>
 <000001d88f96$ccd299d0$6677cd70$@samsung.com>
In-Reply-To: <000001d88f96$ccd299d0$6677cd70$@samsung.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7e1d419e-590c-4af5-6baa-08da5e52becc
x-ms-traffictypediagnostic: DM6PR04MB4236:EE_
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /UKOWkzsXlOQYpwYixJp/3xIpbA8Ml0e+OMoadn1ARJ4+L53PEGOFzwMiwcLCi6pAVFT0HSb47wWMiOR2i4iP1ZRyR9Wx4NA+Kr1Ji99XjCXmc6eeqJ/ATC2tcZFVnmi8aS+668jDt7oNlkrYF+wG2okGPNRrlaYGWy2d3Co80TejTAYYBwj07kBVfpfXDcLeaEt/PvAeI7y8gW/Ea3xnmcvzxBsXOVCNYbB9bssV8LcEtuK8jDQYTZzts1R8TXs48WzwNzC/2P/4loGyeLDKAUzShLucCQlPj9YmNozQl7TwwmTWEe16JJcKSqg8bybf5qPdVpv9qvMDf780XxyGwlIvZrJn8pb1cvqO+ouvTnNdPBCQhHPu9yZNLM6TbFojvSbqV+cweSX/en6CuB1SIep/4A9PLt9BOWval2C6MizLBm+2OLZbqEl2x06EJLhE5A3k4KMA5CCLPEFbC03b07qFgyscfUz9PKZjj5QuDwcC0n+Nkozrm6u81sEx3e/Xgg69XlsJsMQPWX0iKQ5j7Xx7d5hLzB8ToW1FjfAiOIttXfzr8Q6n+88wipG+fPplRjziLUFimY5zlpGZHhNIUfU0+12fdgxQwLQGAzmQAUXaWYc01zL7LWF4l75algSmiyF+044GFAmXyLVMyHwwwlxSAslPma2a4LxpzGVrV8673yiVriodnLHEXgZ9/TS3v/xcl1j6PHeUmc4kRNw2zcf6JwOLcF9PD4RQIoLYT8ViAEWD8SRMkFLflZ+vl/CnVvK2VW/AjxAhBQrEp4wA3dqfcuv8Km8S5MqfK8QbQFDab6phjYFUvtT7bCYWmGl
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR04MB6575.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(396003)(366004)(376002)(346002)(39860400002)(136003)(8936002)(5660300002)(7416002)(55016003)(52536014)(478600001)(9686003)(2906002)(38070700005)(82960400001)(83380400001)(33656002)(38100700002)(53546011)(6506007)(86362001)(66946007)(110136005)(76116006)(66476007)(66556008)(71200400001)(54906003)(64756008)(316002)(66446008)(4326008)(8676002)(186003)(26005)(41300700001)(122000001)(7696005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SGMvWTdVR2l6UjlFM3dKbWNTVHpkcXNYaW1BemFDSGVxWmpFV2E2TXc3cmhC?=
 =?utf-8?B?SzcreGtMUUV4VFh3YnIzTzRkYzZsSGhTNFVueDdMTVZwM3lOcUYyYWdYQmxX?=
 =?utf-8?B?MEJZRFhQK05jSWJZclBHSmhaNzBySHAzdWoyUzNkWHhxZFdMalNNekJwUCtq?=
 =?utf-8?B?WFNzd3Vmc0ZpbGhGVndrVEdaR1ZoNHF1TlJ4cGJuWlJNR0Y1a3hEYTkvQnJD?=
 =?utf-8?B?eVJHdjl0SncvZDhVM1NTUURjNWRtTGhMMDloYlJnRnI5TzJqWXAyZURsaTZI?=
 =?utf-8?B?OW9EZ2lRNjBnUkJ5Z2FHSVBzSEdTSGorSzhuTWpuLzh1MVVLYU9oQ0ZxVk1u?=
 =?utf-8?B?bmNNUGcyQ3NhcnRhSU9QWE5XZitlZ0w4WDl0dVJoWVlyc0VkN3NMVFNpdHAv?=
 =?utf-8?B?M055aktxQ2dDb2gveVhzbEt4RTJRNU9XKzZCY1FZWHZnWnFpa3VZT1FML2F1?=
 =?utf-8?B?YVNoNm0vdUpWR1FRMXFNMzZIYUtaam56Rm0zbjgwZXNOV0ppeEpUand5aDVp?=
 =?utf-8?B?aFduK1JKZ2IydWNHaUM4TEp2UzF1S05aOWMvM3htSkVKMnF4ZFJvZ1lmMEdl?=
 =?utf-8?B?SFlpZlVEa2pLTzQ3cm9OaWlZdWRqRVRELzhab3h4QTB4OVJVMnRSaE9OWXk3?=
 =?utf-8?B?bnQ3RC80ODdjT0NFbjJzekpFdHNTeHVIVW1kRlZEMVpabjdqNlNCWXA3b0Rj?=
 =?utf-8?B?RExka0NYUk5vMExBNTBSeGZKb0hiOWl0eW9oVkV4Si84SG1LODVuTU8waGY2?=
 =?utf-8?B?R1V3ZHZxcXJ4aUNramFIZHdCeS9OZ242OVROQ3o2dEFBcVRlVnBvdE1lTjhZ?=
 =?utf-8?B?WHFyVlgwQjg5SnMxTGw2eG9LemZ2WTRRdkJ5ZlZKNWdhbWhOMFJtRGNOeHZE?=
 =?utf-8?B?blRyTVMxZ2gxNFk0SHVzSm9xbmZhS2ZWU1BVYjR2RkZhNWFxa0xoUXNZUmFP?=
 =?utf-8?B?LzdReTdUVjRWb0FuOGVzMHROekJZNFIwMEhKQUV5ait6dDRMTG5Ta2JnbjNh?=
 =?utf-8?B?QmRiaWV1enlEU3hENHMvbENsQ2RsY2xVNy9EdEVwSm1RQTRqdGcvY0NMU3lI?=
 =?utf-8?B?aTRIZ1h0OVZEYVcxNGwyOU1yV0N5L05kK0NVMlFGRWt0dXZiSDZsbkxJS3B4?=
 =?utf-8?B?aFpidTVBN1VuWXRiL0NNMXRpL091RmJZL3pHMmRxSzg3bVBiODdtd0dlaFFW?=
 =?utf-8?B?dUxheDliclJBY055TGQ1cEtsdUEzU0I3Z0tBSUtyWDNpQStqcDdoRkdsRkZy?=
 =?utf-8?B?bDhJdnR3SVowaWxuK3REVnZlMXVMQ2tOZlFsWU9peVc4SWNLemRGdVlEeVMx?=
 =?utf-8?B?NEFQYkh4YXdkQzhuOEpaeVhLUGswZTJIT1BkQTBqaFpKenZSWk14dlhlT1dp?=
 =?utf-8?B?citkQ2x5c3hXcE8rVDJtbU1ValBEMVcvTUExSnF2MUtuT25XRllobkpMOVU3?=
 =?utf-8?B?MHRlZ0lDLzlNNE5mUFF1Wld3RmJNU3B1TC9KZ1Jib0dDc2JKRTE1ZWM4WFRm?=
 =?utf-8?B?K05kMTMrTzJpVzBhOHRPNm9PaFZTb3hjVlRFSVNTVUJEUnhCVUNyRGlyWThV?=
 =?utf-8?B?OUJISXJRekRZSTdaeUZpc05RdG13bm5UVndMMEdra1lDa0FUa3J4RkdyS3lk?=
 =?utf-8?B?NmF4cEpLNTZSbVFDVk9IU1Z2YTZwVDNVVG9LdThDb0UvcGJOY1c1Q3FkcDNS?=
 =?utf-8?B?OStIOGJaS2FOZ0s4TnlKa082SGxNdFphbUdMaW8rWlBpREo0a2dSZnRONFVi?=
 =?utf-8?B?S2Z3V0V4eVpZNUFzRnRWWUFMaWZOOXZnWWFxUnlUTXZtNDFSenZrU0hsVmc2?=
 =?utf-8?B?aWlzcmNQdTN5TFdrM2xpQkgxckN2dkdXeU9sS2ZmZlQ3SmxZOFZqaHlHS1h0?=
 =?utf-8?B?QU9uVDRMVmQyemhxVmw4bUR5cFRkWi9ETmVEaC8ySGhyRytaUDZIeWVwcTZp?=
 =?utf-8?B?V2U5SjhwTE4zTEx0MEd0WFNPbW8zTXJ2K1lGa3JMRVJ6YkpZSTI1WXJyQjc5?=
 =?utf-8?B?ajJuTVVoamVta1N4aWcveGxSOE5VOEl0b3NScjBhZTVFZGxHTlR2aUdjeDF2?=
 =?utf-8?B?QjFnMjltL1VTUjNtMGg4NG9tKzh3SzdyaWdFZFV4ajhTQjRqNllKZXVTZzBB?=
 =?utf-8?Q?+uWpY4RwpVkbEsclXUeJZiGuw?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR04MB6575.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e1d419e-590c-4af5-6baa-08da5e52becc
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jul 2022 06:51:10.7587
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: H1NC7DxZDXOOb0FOPXwbSWt+kpkKKpCECaT5qG3DjmcFv+8wZ3c+YmGAh4S659CQOekXP+VuXZrnRZ1CXQGRBA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR04MB4236
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

IA0KPiBBcyB3ZSBrbm93LCB0aGUgdWZzIGhvc3QgY29udHJvbGxlciBpcyBkaXNhYmxlZCBhbmQg
ZW5hYmxlZCBpbiB0aGUNCj4gdWZzaGNkX2hiYV9lbmFibGUoKS4gU28sIGhvc3QgY29udHJvbGxl
ciByZWdpc3RlcnMgYXJlIGNsZWFyIGFmdGVyIHN3IHJlc2V0Lg0KPiANCj4gT25jZSB0aGUgaG9z
dCBmYWlscyB0byBsaW5rIHN0YXJ0dXAgMyB0aW1lcywgYWxsIGhvc3QncyBjb250cm9sbGVyIGNh
biBiZSBjbGVhciBkdWUNCj4gdG8gZXhlY3V0aW5nIGxhc3QgdWZzaGNkX2hiYV9lbmFibGUoKShz
L3cgcmVzZXQpLg0KPiBUaGF0J3Mgd2h5IHdlIG5lZWQgdG8gc2tpcCBsYXN0IHN3IHJlc2V0IHRv
IGdldCB2YWxpZCBob3N0IHJlZ2lzdGVyIHZhbHVlcy4NCj4gDQo+IEJlZm9yZQ0KPiAodWZzaGNk
X2RtZV9saW5rX3N0YXJ0dXAoKSAtPiB1ZnNoY2RfaGJhX2VuYWJsZSgpIC0+IHJldHJpZXMtLSkg
KiAzIHRpbWVzLg0KPiANCj4gQWZ0ZXINCj4gKHVmc2hjZF9kbWVfbGlua19zdGFydHVwKCkgLT4g
aWYgcmV0cmllcyBpcyAwLCBicmVhay4gLT4gIHVmc2hjZF9oYmFfZW5hYmxlKCkNCj4gLT4gcmV0
cmllcy0tKSAqIDMgdGltZXMuDQo+IEluIHRoaXMgY2FzZSwgdWZzaGNkX3ByaW50X2hvc3Rfc3Rh
dGUoKSwgdWZzaGNkX3ByaW50X3B3cl9pbmZvKCksDQo+IHVmc2hjZF9wcmludF9ldnRfaGlzdCgp
IGFyZSB2YWxpZC4NCklmIHlvdSBmaW5kIGl0IG5lY2Vzc2FyeSB0byBlbGFib3JhdGUgdGhlIGNv
bW1pdCBsb2csIHdoeSBub3QgZG8ganVzdCB0aGF0Pw0KQWxzbyBtYXliZSBtYWtlIHRoZSB0aXRs
ZSBtb3JlIGluZGljYXRpdmUgb2Ygd2hhdCB5b3Ugd2FudCB0byBhY2hpZXZlOg0KInNraXAgbGFz
dCBoY2kgcmVzZXQgdG8gZ2V0IHZhbGlkIHJlZ2lzdGVyIHZhbHVlcyIgb3Igc29tZXRoaW5nLg0K
DQpUaGFua3MsDQpBdnJpDQoNCg0KPiANCj4gPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0K
PiA+IEZyb206IFNldW5naHVpIExlZSA8c2gwNDMubGVlQHNhbXN1bmcuY29tPg0KPiA+IFNlbnQ6
IFRodXJzZGF5LCBKdW5lIDMwLCAyMDIyIDE6NDggUE0NCj4gPiBUbzogYWxpbS5ha2h0YXJAc2Ft
c3VuZy5jb207IGF2cmkuYWx0bWFuQHdkYy5jb207DQo+IGJ2YW5hc3NjaGVAYWNtLm9yZzsNCj4g
PiBqZWpiQGxpbnV4LmlibS5jb207IG1hcnRpbi5wZXRlcnNlbkBvcmFjbGUuY29tOyBsaW51eC0N
Cj4gc2NzaUB2Z2VyLmtlcm5lbC5vcmc7DQo+ID4gbGludXgta2VybmVsQHZnZXIua2VybmVsLm9y
Zw0KPiA+IENjOiBncmFudC5qdW5nQHNhbXN1bmcuY29tOyBqdDc3LmphbmdAc2Ftc3VuZy5jb207
DQo+ID4gZGgwNDIxLmh3YW5nQHNhbXN1bmcuY29tOyBqdW53b284MC5sZWVAc2Ftc3VuZy5jb207
DQo+IGphbmdzdWIueWlAc2Ftc3VuZy5jb207DQo+ID4gY3c5MzE2LmxlZUBzYW1zdW5nLmNvbTsg
c2g4MjY3LmJhZWtAc2Ftc3VuZy5jb207DQo+IHdrb24ua2ltQHNhbXN1bmcuY29tOw0KPiA+IFNl
dW5naHVpIExlZSA8c2gwNDMubGVlQHNhbXN1bmcuY29tPg0KPiA+IFN1YmplY3Q6IFtQQVRDSF0g
c2NzaTogdWZzOiBubyBzdyByZXNldCBhZnRlciBsYXN0IGxpbmtzdGFydHVwIGZhaWwNCj4gPg0K
PiA+IEhvc3QgZHJpdmVyIHJlc2V0cyB0aGUgaG9zdCh1ZnNoY2RfaGJhX2VuYWJsZSkgYWZ0ZXIg
bGFzdCBsaW5rc3RhcnR1cA0KPiA+IGNvbW1hbmQgZmFpbGVkLiBBbGwgb2YgdGhlIG1lbWJlciBv
ciBob3N0IGR1bXAgYWZ0ZXIgbGlua3N0YXJ0dXAgZmFpbCBhcmUNCj4gPiByZXNldCB2YWx1ZSBi
ZWNhdXNlIG9mIHN3IHJlc2V0Lg0KPiA+DQo+ID4gU2lnbmVkLW9mZi1ieTogSnVud29vIExlZSA8
anVud29vODAubGVlQHNhbXN1bmcuY29tPg0KPiA+IFNpZ25lZC1vZmYtYnk6IFNldW5naHVpIExl
ZSA8c2gwNDMubGVlQHNhbXN1bmcuY29tPg0KPiA+IC0tLQ0KPiA+ICBkcml2ZXJzL3Vmcy9jb3Jl
L3Vmc2hjZC5jIHwgMiArLQ0KPiA+ICAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDEg
ZGVsZXRpb24oLSkNCj4gPg0KPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3Vmcy9jb3JlL3Vmc2hj
ZC5jIGIvZHJpdmVycy91ZnMvY29yZS91ZnNoY2QuYyBpbmRleA0KPiA+IDdjMWQ3YmI5YzU3OS4u
MmNkYzE0Njc1NDQzIDEwMDY0NA0KPiA+IC0tLSBhL2RyaXZlcnMvdWZzL2NvcmUvdWZzaGNkLmMN
Cj4gPiArKysgYi9kcml2ZXJzL3Vmcy9jb3JlL3Vmc2hjZC5jDQo+ID4gQEAgLTQ3NTMsNyArNDc1
Myw3IEBAIHN0YXRpYyBpbnQgdWZzaGNkX2xpbmtfc3RhcnR1cChzdHJ1Y3QgdWZzX2hiYQ0KPiAq
aGJhKQ0KPiA+ICAgICAgICAgICAgICAgICogYnV0IHdlIGNhbid0IGJlIHN1cmUgaWYgdGhlIGxp
bmsgaXMgdXAgdW50aWwgbGluayBzdGFydHVwDQo+ID4gICAgICAgICAgICAgICAgKiBzdWNjZWVk
cy4gU28gcmVzZXQgdGhlIGxvY2FsIFVuaS1Qcm8gYW5kIHRyeSBhZ2Fpbi4NCj4gPiAgICAgICAg
ICAgICAgICAqLw0KPiA+IC0gICAgICAgICAgICAgaWYgKHJldCAmJiB1ZnNoY2RfaGJhX2VuYWJs
ZShoYmEpKSB7DQo+ID4gKyAgICAgICAgICAgICBpZiAocmV0ICYmIHJldHJpZXMgJiYgdWZzaGNk
X2hiYV9lbmFibGUoaGJhKSkgew0KPiA+ICAgICAgICAgICAgICAgICAgICAgICB1ZnNoY2RfdXBk
YXRlX2V2dF9oaXN0KGhiYSwNCj4gPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICBVRlNfRVZUX0xJTktfU1RBUlRVUF9GQUlMLA0KPiA+ICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICh1MzIpcmV0KTsNCj4gPiAtLQ0KPiA+IDIu
MjkuMA0KPiANCg0K
