Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADB4A4AD96E
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Feb 2022 14:18:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234885AbiBHNS0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Feb 2022 08:18:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231326AbiBHMo5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Feb 2022 07:44:57 -0500
X-Greylist: delayed 62 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 08 Feb 2022 04:44:55 PST
Received: from esa.hc3962-90.iphmx.com (esa.hc3962-90.iphmx.com [216.71.142.165])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBCD9C03FEC0;
        Tue,  8 Feb 2022 04:44:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qccesdkim1;
  t=1644324295; x=1644929095;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=jhG61g6kz9te8m9hVw4Q9HWrew2xJ6mtgjV3NxNeTq4=;
  b=hdUe+DwZURljhXyYJo9I3h7YdEzmW/kpgLIUxSucuN/vgnGZXIdgntVU
   tlqqCZ5VGKQQiW6zaBcyqdvnEJTkbpAaw/YcJmaKiz8TtD0lossYTW/WD
   TAyBFxL2m8o9W7O/JRzjEFZuiOaUF0RapeufGj+Y+qU5Eh9/syTSCwXXK
   g=;
Received: from mail-dm6nam11lp2174.outbound.protection.outlook.com (HELO NAM11-DM6-obe.outbound.protection.outlook.com) ([104.47.57.174])
  by ob1.hc3962-90.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2022 12:43:52 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lK2Fs58GMCF+zkGgaQ/kxtFC+nrJriDvCvH65vuS2aJVgH7EWDeVeF39cr8777Q0rrAEO3on+HDsPMdww2qx5RT6h4h4eQbdA6GZ6n85hrnzp6hMlx7ENA19WrY4WKc6xRpGohUKBNdfLRqQMkTp2Jlx11iNsC/wnQc2ZO9xq2oUE7J76Nzc5l1viasBK7AUiCKxV5dwX9kVsATF6v64l+FwLwafTczvjE/BUW2qOsqa+kBaqUKBZ3BPeNJnosKN5ZJNn6LSdtxdHN9+htuMRpomXG0c5G7P5tRUI1/l8wZI8VDlePg4Ah3htjQS5qGFni/Vc6UtYly/lUTht6uwnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jhG61g6kz9te8m9hVw4Q9HWrew2xJ6mtgjV3NxNeTq4=;
 b=nV4D8/HiJeW/XNov5gMG7fMssqH/tIw6F7VrD22oFKVTz3Jgjp+1YFYy0qoPtQF4zsncTVIa5VIK7tvuT+AFCkCf2qz/jLazJMCGwyle0Qt7WdYhkyQ8PyecIT8n40QBtXiFoEATc3PKM5XaV6yojSCieOPoc4N9O0x7+pMm0rU71Mh3RNFnyUgZtqsM5C+oZZJ8OPgH7rVK9xcyQ/PiASkS2l5S/peABnr9s7vtD9nL3OrEVe9PYtt3NjcZ+YI8uihUFqETZVnji8jj9W6JI6Brg4KXHU5RjGt2nc/h+C9CBw91pPn3VHPQ1Poz6prHbeb+EL8jyDjMJlmpGUcp+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from DM6PR02MB5148.namprd02.prod.outlook.com (2603:10b6:5:48::21) by
 SN6PR02MB4688.namprd02.prod.outlook.com (2603:10b6:805:99::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4951.17; Tue, 8 Feb 2022 12:43:50 +0000
Received: from DM6PR02MB5148.namprd02.prod.outlook.com
 ([fe80::fd14:f3bb:506c:4fa9]) by DM6PR02MB5148.namprd02.prod.outlook.com
 ([fe80::fd14:f3bb:506c:4fa9%4]) with mapi id 15.20.4951.019; Tue, 8 Feb 2022
 12:43:50 +0000
From:   "Dikshita Agarwal (QUIC)" <quic_dikshita@quicinc.com>
To:     Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        "Dikshita Agarwal (QUIC)" <quic_dikshita@quicinc.com>
CC:     "linux-media@vger.kernel.org" <linux-media@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "vgarodia@codeaurora.org" <vgarodia@codeaurora.org>
Subject: RE: [PATCH] Add check for READ ONLY flag
Thread-Topic: [PATCH] Add check for READ ONLY flag
Thread-Index: AQHYGZM6GzYGUfERzkeFd/d4R+cnj6yJnrAAgAAA71A=
Date:   Tue, 8 Feb 2022 12:43:50 +0000
Message-ID: <DM6PR02MB5148FA037A4AA01893698CDDF32D9@DM6PR02MB5148.namprd02.prod.outlook.com>
References: <1643957268-6365-1-git-send-email-quic_dikshita@quicinc.com>
 <37c856c6-caa3-b908-9cda-25a50a50ef03@xs4all.nl>
In-Reply-To: <37c856c6-caa3-b908-9cda-25a50a50ef03@xs4all.nl>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=quicinc.com;
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2b713d37-3202-45fd-e395-08d9eb00a821
x-ms-traffictypediagnostic: SN6PR02MB4688:EE_
x-ld-processed: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d,ExtAddr
x-microsoft-antispam-prvs: <SN6PR02MB4688E133FF43DA2D12A8977C8F2D9@SN6PR02MB4688.namprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: hWXL5wyCiUe59k9jlg0QF5X7qCqGtKNnHASrII/u2QMGTJngT0Dvq6EV1/ooGVJVqWv2zR455gd3V6dG1gKwFtj/SEGX0n6dbOl6fSTl8ifliLuAvoofbum024+dci94BRMjmtRVSoYoEWOIXOzEsHPhlP0x1k4JuZ5006eXILe2kEzYCv/yR/7I4Lnaebtc6tON0vh0NMthuUc3A0FGSuWGvnn4hRc4wfqa17FMOIqZpWTwjEDlVBTztMuATFCrhcGrptZ9AeySpWra3nEIDHb6MPRfGvWZ0JlLsW/rLgEbR4giJFBzZWtrgG+K6cdH1Wapfj18W4olWIniw+WbMQJOc568X8uNTduSm/9MPglRLv7qidVNDs0ATarUwObxva3Irszoua42pxC2lsMj785Vckw75vsxlj7sR0CpZjb/4RWV1jVO8+f1JKRflzMMZjYo4gPVIi8gN4ZsGeUWGUSWxXuK6+rO+kkMEbP0+TwMEJ3z2LIIxuo1RPq3urfC67MMCAzRXi0fc3Jnk0ZQ78tYSF3HIS9Y/kPPiQpTTocQ9V2Bb5nhVgnO+Lq8iU+AB9okJtVL5N2/ekU4PjJ9iF6zEuJKEz0gWpWYd9vz6cH2KfgvSopN1mFbgbKk6kPN+DAIebYtiR98Ed73fHp+NO2FY5oinmalEIv2hFxVkcq4dRgVsg55fsW2Vd7mwyzNX0+GkWghD2cu0+X0+xXQIQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR02MB5148.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(86362001)(55016003)(186003)(83380400001)(110136005)(316002)(54906003)(508600001)(122000001)(38100700002)(6506007)(7696005)(66946007)(8676002)(8936002)(4326008)(66446008)(66476007)(66556008)(64756008)(33656002)(2906002)(26005)(5660300002)(71200400001)(38070700005)(9686003)(76116006)(53546011)(52536014);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cHB1Tlk5WWc4WWdNNnJ3dWJHZXAvTUdDdklVQ0xndms1Z1gzV1RsVW9ybWtq?=
 =?utf-8?B?M2YzaUlCU1hlZnF2YWJ2N1ZraUdWakdReFQwZDNEVU9SZkNPNmtvblJDL3hD?=
 =?utf-8?B?a1FXbG9vbnNCcWwzRktFSWVxSElSYXRiNjFmQjVLUUw3TGZ2YnZtODBmWERG?=
 =?utf-8?B?Rk5oT1ZOZElZYXR1OW9IVkE5MzFkMi9WMFBlRlZMZFViemJ4NUxMYUpqY3NV?=
 =?utf-8?B?MnZzbDNCMVM2QlBEd0JGMGV6TGExS1ZjNHVldzZHQ0hteWdDM3MzU2lzQmJK?=
 =?utf-8?B?cTNlY1M3SmI3dHBPTXg5cUdXYjd0cGFtbFNRSmJMeG1sZVpNQ1lzbmI4eW9z?=
 =?utf-8?B?WkpaaE1rSWJlRFJ4dWhjSEJwL2F5SmJDMGIrVzE1SStlR0x4RnJ1eFY3b1RO?=
 =?utf-8?B?N3grWkJ5UC92UEMyOXdKZEJVRElIb1RmTk1HdlR1eUk4M0hvY1lLNEhUejE1?=
 =?utf-8?B?UFI5cmMxMEJlWXk2aWVWR2ZzY1orOEN1aHNGK25BWVVpVmVtVWVpRmk3RWQv?=
 =?utf-8?B?SkFFcitQVXZ3aW92MzVUM0JlQTRqbG5kVXF5OXNsZzYrY2J5dUhWTTBYeWJr?=
 =?utf-8?B?WHNBSUJyZWdmWnlwSnZ2aDhkbnpTY1JrajVialBTSHc3b28wWVN1ME1iL3RK?=
 =?utf-8?B?ekl5eldUb09HY2hKMEh4NjR4SU9nZ2M2a016Z2lWZlhZTDc2YkNrZXVhMzh3?=
 =?utf-8?B?MFdBcHQ0cUVLVXJUbnQwY2JjS3FZS2R0UmttSWpaOVRnWXhVbHhHOUx4VGZo?=
 =?utf-8?B?VUZKK2dhaTJQc0VxVHJKem5EU2RMQ09Yb1FxODArZnRZSFVGNTVyN3BoR1FC?=
 =?utf-8?B?a2xQbTlyMC83Q1JHb0Zyc0pGa081cktqRzcwUTZUTGtBSXlpelk3L21FZEpY?=
 =?utf-8?B?RG1CMVRBM0F5ZnMxTnNMMGhkV0psbUY0cTVlQVBuNGNXQWVLUVJRVHh5YUFt?=
 =?utf-8?B?MjFLb1ZyU0Ezd09wSzdWWG1LUHpsN20zVnlrVWF1YTlOL2h3THRyeTZ2cVlk?=
 =?utf-8?B?NnRURDdEU3QvSGJwVVdjNW9EN2ZXY21zMGhpa1hiVUNhclVyTlkwOU5FQnFm?=
 =?utf-8?B?a0UvOXhFQkNOVlM5ZXZqNHZTZ3ZjWGJQV1Y0eURVTTZ5Nk5IN0szWjR4dUdB?=
 =?utf-8?B?T2grbks3SHVaRDJ0MSt6dDhlSzVwYUtJYVlPQ1o3d3EvK3ZBVVdUSkp6QXNo?=
 =?utf-8?B?K3VpZGFjc1hPc0RDcXRycFhzMndBcGQ1ZXhnR2o4TXZieTkzeldlSGNIK2R2?=
 =?utf-8?B?YVZOT1FTNjRiK2FCQS9hUm5PSmJDUTZ0U0lKTEdVemxzSk40Q2tBdzlENzNS?=
 =?utf-8?B?OTc1RmUvSCtsQnhoZ1BLK1RKMExyR3FicTViK3g4OXZIdEp0dTdYVGpiU2o1?=
 =?utf-8?B?eG5pM3NIdXhaYldRVDVYaEVPZVIrM3R4T2lmQ1cxbWJ5dUQyMzVxUVRQWnIr?=
 =?utf-8?B?MUlFdTVEWmMwWXcwYTNQRWZxMTdMTzVMdVY3SmVGbmlhUWE3VlJVVUR1U1Zi?=
 =?utf-8?B?Nk1sbXFScjNyMkkwc3FHZCtXSDFNKzBKZ3ZJTEdlc0t3RGhDV0w0RXVvSnd4?=
 =?utf-8?B?OUQ2aS9yb25GMDk0K2VOUEN5cGxRUThpTzhCdU91SS8wU1NKaHVXMEMrc0hK?=
 =?utf-8?B?RHk4bU5YcExLQ1RjbXZ2YUtxZlBTN0p2Syt4aWwxaW0xa2d4NGZSUDNVdGsw?=
 =?utf-8?B?dDdUZGtSeVlXc2hpd014MHR0Tythd3hMaDZkUDFTOHdBT1JFT0dTVGtVWTlP?=
 =?utf-8?B?dHJYbDdpYTVIYm83Vms4eml5eUJTaUZ3YjFCUWdUbEpYLy9WQXdPRkNEQlZB?=
 =?utf-8?B?Uzg4dEl5c3FTU1hoTnFyTHZML0xMbTQ3c2tjOXdtaTEybjV6a2ttSFFaeExp?=
 =?utf-8?B?MGJleGxDOXBRNkR1NFBFSGlMZWhrOVFxemgwRVc5ajVreVlvWW5TcFNnaGNn?=
 =?utf-8?B?Y2w1bkVWQVk4dWpvbklENmlEOFkwUUNQUGYvV3VteVBVanRLQ0lTQ0VCa0Jw?=
 =?utf-8?B?MFJ1eldCRUd0VGxaRnh5Vmk5aHVxZERBZFdLdm9kbmxKYnlmS1NDOGJWWU5j?=
 =?utf-8?B?cVZSWStOZXdOd0RRTU1lSS9adFdLSTMvMjAyek9xM0J1NzFsR3Y3WUYzZjJs?=
 =?utf-8?B?dnZxN3kxYXRaTUJCTGx2ZC9Zc1Ryalk4RDJYb1B2d1B3eEFjaWlqOTYvNkVF?=
 =?utf-8?B?VnBGVWhDaGtKenBrY0t1Q3JHb1pSejcwN3NDVEJIVDhUVFZaT0p2UjNmNjdS?=
 =?utf-8?B?RzhPeC9EcXJlSENGYVBKZ25janpnPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: quicinc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR02MB5148.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b713d37-3202-45fd-e395-08d9eb00a821
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Feb 2022 12:43:50.2175
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: H56dfUZmK/HPWeeUltoqrskYFzg/pXMYyNjkTkQzcYWtslb5OIigT8eKwbSJOcZmijHhZq+muDaaSw2b5V9KwV1zPgj4i24B+Q3dptgRAcY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR02MB4688
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

VGhhbmtzIEhhbnMgZm9yIHJldmlldy4NCkkgc2VudCBhIHYyIGFkZHJlc3NpbmcgaXQuDQoNClRo
YW5rcywNCkRpa3NoaXRhIEFnYXJ3YWwNCg0KLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCkZy
b206IEhhbnMgVmVya3VpbCA8aHZlcmt1aWwtY2lzY29AeHM0YWxsLm5sPiANClNlbnQ6IFR1ZXNk
YXksIEZlYnJ1YXJ5IDA4LCAyMDIyIDY6MTAgUE0NClRvOiBEaWtzaGl0YSBBZ2Fyd2FsIChRVUlD
KSA8cXVpY19kaWtzaGl0YUBxdWljaW5jLmNvbT4NCkNjOiBsaW51eC1tZWRpYUB2Z2VyLmtlcm5l
bC5vcmc7IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7IHZnYXJvZGlhQGNvZGVhdXJvcmEu
b3JnDQpTdWJqZWN0OiBSZTogW1BBVENIXSBBZGQgY2hlY2sgZm9yIFJFQUQgT05MWSBmbGFnDQoN
CldBUk5JTkc6IFRoaXMgZW1haWwgb3JpZ2luYXRlZCBmcm9tIG91dHNpZGUgb2YgUXVhbGNvbW0u
IFBsZWFzZSBiZSB3YXJ5IG9mIGFueSBsaW5rcyBvciBhdHRhY2htZW50cywgYW5kIGRvIG5vdCBl
bmFibGUgbWFjcm9zLg0KDQpPbiAyLzQvMjIgMDc6NDcsIERpa3NoaXRhIEFnYXJ3YWwgd3JvdGU6
DQo+IEFkZCBhIGNoZWNrIGZvciBWNEwyX0NUUkxfRkxBR19SRUFEX09OTFkgdG8gYXZvaWQgcmVx
dWVzdCB0ZXN0aW5nIGZvciANCj4gc3VjaCBjb250cm9scy4NCg0KTWlzc2luZyBTaWduZWQtb2Zm
LWJ5IQ0KDQpSZWdhcmRzLA0KDQogICAgICAgIEhhbnMNCg0KPiAtLS0NCj4gIHV0aWxzL3Y0bDIt
Y29tcGxpYW5jZS92NGwyLXRlc3QtYnVmZmVycy5jcHAgfCAzICsrLQ0KPiAgMSBmaWxlIGNoYW5n
ZWQsIDIgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQ0KPg0KPiBkaWZmIC0tZ2l0IGEvdXRp
bHMvdjRsMi1jb21wbGlhbmNlL3Y0bDItdGVzdC1idWZmZXJzLmNwcCANCj4gYi91dGlscy92NGwy
LWNvbXBsaWFuY2UvdjRsMi10ZXN0LWJ1ZmZlcnMuY3BwDQo+IGluZGV4IGZhOGMzN2MuLmI4ZGU3
YWYgMTAwNjQ0DQo+IC0tLSBhL3V0aWxzL3Y0bDItY29tcGxpYW5jZS92NGwyLXRlc3QtYnVmZmVy
cy5jcHANCj4gKysrIGIvdXRpbHMvdjRsMi1jb21wbGlhbmNlL3Y0bDItdGVzdC1idWZmZXJzLmNw
cA0KPiBAQCAtMjAzMiw3ICsyMDMyLDggQEAgaW50IHRlc3RSZXF1ZXN0cyhzdHJ1Y3Qgbm9kZSAq
bm9kZSwgYm9vbCB0ZXN0X3N0cmVhbWluZykNCj4gICAgICAgICAgICAgICBpZiAocWN0cmwudHlw
ZSAhPSBWNEwyX0NUUkxfVFlQRV9JTlRFR0VSICYmDQo+ICAgICAgICAgICAgICAgICAgIHFjdHJs
LnR5cGUgIT0gVjRMMl9DVFJMX1RZUEVfQk9PTEVBTikNCj4gICAgICAgICAgICAgICAgICAgICAg
IGNvbnRpbnVlOw0KPiAtICAgICAgICAgICAgIGlmIChxY3RybC5mbGFncyAmIFY0TDJfQ1RSTF9G
TEFHX1dSSVRFX09OTFkpDQo+ICsgICAgICAgICAgICAgaWYgKHFjdHJsLmZsYWdzICYgVjRMMl9D
VFJMX0ZMQUdfV1JJVEVfT05MWSB8fA0KPiArICAgICAgICAgICAgICAgICBxY3RybC5mbGFncyAm
IFY0TDJfQ1RSTF9GTEFHX1JFQURfT05MWSkNCj4gICAgICAgICAgICAgICAgICAgICAgIGNvbnRp
bnVlOw0KPiAgICAgICAgICAgICAgIGlmIChpc192aXZpZCAmJiBWNEwyX0NUUkxfSUQyV0hJQ0go
cWN0cmwuaWQpID09IFY0TDJfQ1RSTF9DTEFTU19WSVZJRCkNCj4gICAgICAgICAgICAgICAgICAg
ICAgIGNvbnRpbnVlOw0K
