Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9839D58C5B6
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Aug 2022 11:36:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235886AbiHHJgl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Aug 2022 05:36:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242015AbiHHJgi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Aug 2022 05:36:38 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2084.outbound.protection.outlook.com [40.107.223.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4177113CF6;
        Mon,  8 Aug 2022 02:36:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=auVUfxgwFfmksCwWLgHTvL1Gw5mShAI/V6ME2vwwYjczLURvrcy3nWVozAdsGkh9HVdJCus4TJcnRP7D9VRyo2/sq5louy3jpLiQ2ySHpu/lc3eD59rQYonn3WFcwDdDXEwSoDKYcqFqh09U0x+DtzfkNUoxPiEmG2ru/KMx+T0779IX9o8gwLtcRTmciW9DEQojqowac0ZDSdnmVfJDuAnGp7ERkrtnLDTD9pE+pt4eI0Fbf8Yy1KK8LFyyZcfvWgXiUpPUNuJgofJkkIlJ8fPgXdtI3FX1/Fr5YvuCrP0kZNQkNomAyymenrQAe2ScL5wbpebMDoZQ/64E1SBQ/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+AyUIF4Ddn5kz44BlCi6k+h+S44Ue3UbgnaeHiyMV7o=;
 b=BGZjVj2Hi1izfYcHsseBP0w0yq5Zcbi2R0QQFm4ziREI0YbKkZxjs/fAmMdjNIjHIXNppxXMOqMkBd9BGR4TfDPjxnQ/2Ne8CswAOaqYKzN3T7QkTeuSXu432dM+J+J34VR1uuV7MphF105C/KuTst/G2mctnOIOTOBkbent4jTaYJ/lHAg9IZ+ek04iBOZ5XhGjK1g0GgLTbIxb5VlmoMP4UXhwdURFFGL+pVnLxJbgfk5doDaRnfWEhZf9BDHCRQpT/lP3bVTu0ZOFHn43M3WULH0CAtOxg68n3udHPTK12Ikt7dPbgpoqQqDKkHZp1WgH8a5IcrcAu3HaJRmpDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=tw.synaptics.com; dmarc=pass action=none
 header.from=tw.synaptics.com; dkim=pass header.d=tw.synaptics.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Synaptics.onmicrosoft.com; s=selector2-Synaptics-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+AyUIF4Ddn5kz44BlCi6k+h+S44Ue3UbgnaeHiyMV7o=;
 b=M5h+BfocHX0HkoyO0qMxDUibbKIR0mIaoO55ukBx2Twe+/SabD4v2mwt7xEhH/6qtE5gxB97jFK6lE/0/Rzkc1Xhmct2KDk0s+stSHrX4rYdKd+TXQNHUXud11aR6M/YZ+/YIQCAR8YfxG+ILPmy5m3MYtrS/CJQagzCA3w0y9M=
Received: from PH0PR03MB5848.namprd03.prod.outlook.com (2603:10b6:510:30::19)
 by MN2PR03MB5245.namprd03.prod.outlook.com (2603:10b6:208:1e6::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.14; Mon, 8 Aug
 2022 09:36:34 +0000
Received: from PH0PR03MB5848.namprd03.prod.outlook.com
 ([fe80::60b1:a766:c174:65ca]) by PH0PR03MB5848.namprd03.prod.outlook.com
 ([fe80::60b1:a766:c174:65ca%8]) with mapi id 15.20.5504.020; Mon, 8 Aug 2022
 09:36:34 +0000
From:   Marge Yang <Marge.Yang@tw.synaptics.com>
To:     Hans de Goede <hdegoede@redhat.com>,
        margeyang <marge.yang@synaptics.corp-partner.google.com>,
        "dmitry.torokhov@gmail.com" <dmitry.torokhov@gmail.com>,
        "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "benjamin.tissoires@redhat.com" <benjamin.tissoires@redhat.com>,
        Marge Yang <Marge.Yang@tw.synaptics.com>
CC:     "derek.cheng@tw.synaptcs.com" <derek.cheng@tw.synaptcs.com>,
        Vincent Huang <Vincent.huang@tw.synaptics.com>
Subject: RE: [PATCH] HID: HID-rmi - ignore to rmi_hid_read_block after system
 resumes.
Thread-Topic: [PATCH] HID: HID-rmi - ignore to rmi_hid_read_block after system
 resumes.
Thread-Index: AQHYqwZUXeo8/uu+vUqrcpU3ezQMya2kuP4AgAABZ5A=
Date:   Mon, 8 Aug 2022 09:36:34 +0000
Message-ID: <PH0PR03MB5848811A9EC856635CD1E519A3639@PH0PR03MB5848.namprd03.prod.outlook.com>
References: <1659949639-3127-1-git-send-email-marge.yang@synaptics.corp-partner.google.com>
 <7507e07a-5094-f129-b75a-69cc32147543@redhat.com>
In-Reply-To: <7507e07a-5094-f129-b75a-69cc32147543@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNcbXlhbmdcYXBwZGF0YVxyb2FtaW5nXDA5ZDg0OWI2LTMyZDMtNGE0MC04NWVlLTZiODRiYTI5ZTM1Ylxtc2dzXG1zZy05NGE2Y2JhYS0xNmZkLTExZWQtODJkNS1mODU5NzE0OTljZGNcYW1lLXRlc3RcOTRhNmNiYWItMTZmZC0xMWVkLTgyZDUtZjg1OTcxNDk5Y2RjYm9keS50eHQiIHN6PSIzMzQ5IiB0PSIxMzMwNDQyNDk5MDU4MDU4MTUiIGg9InF5VHYzRzF5S1NSakxtWkRYT2J6S1hWZndMZz0iIGlkPSIiIGJsPSIwIiBibz0iMSIvPjwvbWV0YT4=
x-dg-rorf: true
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=tw.synaptics.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 794849b6-6c5b-45de-202c-08da79217bc5
x-ms-traffictypediagnostic: MN2PR03MB5245:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: oL6qsr3t+o8d5RG0sexmkL/P00yyl/trYTZSnX/pb/n9LVkuQGvrAu5gLFfV5dbWvw7Y4StKs+xQm81FAFGrTVvsWuL33Btp6kvmTZEeINVEwaIex5i44MRgGVChyTF7haT7XqDu0oEr7QsnghwKw2MXAAyv0a6GWQBv8ZFy3FA/i9B3jMlCZ3aBw/4ei3L0qd9IdgZT0Wz9uEdrKP4zRHHzpApKU6ZqAZonH07SGtaGhkXFXwiXymv0JjIGdHPT1XTS2G6YzWerogJUtWfg/EuomF9g935D5H0jKv/tC4d/LN5dWQsUTpkTio75kqo5q1E+js3DOfuYOhaGpoMwoT/nxINr0LHLWvfKpkAIUGv83dUOz6PqLpQ2x1ekwGjg+0KnI6oriSUQNPUqcXwW+IYSkQwzXRj7N5CsSqGX2eJcGBKFzv0GmC9yetO/L4VRmzSOBAiXYX9pIK46oa1dwd2tvBsW401OxLTY/b+SKfqdJvvzGUqqYSx6/+Me414qZwvPG1G2bHZZVBAzR3r9SrSzWcEqb24wq8RCLnSFAGLNiSTXki6ol5FqBANbYRKgC1XPby0cPBj4nh8Hx52jMZJM4QV9tJRcVDyOh4oibftAdZfPUOobvggG4TJua6K6gxAJk7QT5fVNsBIqavUupHc0bnCfXwiaVYb+RiHUtOmSf74vbchFQ2g2iR5Wq26wvn/V5LtOoNDu9YTPzJX5QMLiDG0X7xwxDs+BAfwssuVWirNseOJrQtG2UgjEG+DAE9S4QLRJav0Cilsf9F8f+/T5/HynI+vzlRRA2CfssWD2eHDl0djzlXj5IXJ2fH7W
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR03MB5848.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(136003)(396003)(346002)(39860400002)(366004)(376002)(6506007)(41300700001)(53546011)(9686003)(26005)(7696005)(86362001)(5660300002)(71200400001)(52536014)(8936002)(478600001)(2906002)(33656002)(83380400001)(55016003)(107886003)(38070700005)(38100700002)(122000001)(186003)(8676002)(66446008)(4326008)(316002)(64756008)(110136005)(66556008)(66476007)(54906003)(76116006)(66946007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ekIyZmQwMHI3dFM5UVRPV3Y1N1U1WFZlbVdIR0JDWExlNFpaOENYOWdZVzRK?=
 =?utf-8?B?UFJYRXpvYUJVMlFvajRSNExKQURwR2lkSUdQS1RzOFh4blVyUFNsaE5ZeFBL?=
 =?utf-8?B?dEJ6VXA1bjk5Z05JeWRPQ20wbXdkOE80UElNSnJTdXR4eE5jUUkvMWNqVEZ5?=
 =?utf-8?B?SFBQUkxMajdkZU5YNkdXdkEzRmRDKy9GVDdWc0NIRDcrT0JLSDhIWXo5aVNV?=
 =?utf-8?B?ek1qa0VEL3NHdjJQeHRmM010WDVKN3psekNhQTcxTE52eFJqYit4SUtKM0o1?=
 =?utf-8?B?UGtYTjhDNXZYSGZKVjEwU09nd01reStuVDJGdXhpMVdjMEtySXp1WUxPbEJQ?=
 =?utf-8?B?Mlgza0NPUHRiZkgvQnZaSTVXVzhTNzVVQzZLL21jN1lJamplR3I2RERRZUVw?=
 =?utf-8?B?dkxtMHlnN0pDTmtjMjBIbWVzUjBYOHdQR1RJRjFtaDdVakJORWV2aDJhTGdF?=
 =?utf-8?B?VExHcCtQbytjNFBNV1JDamJvZll0aVJyZDl0Ri9YcU9MTG1sdW0waFFHeWhw?=
 =?utf-8?B?eHhHZS9LZ050aUUyZXY1eDFrUFJvSjBFNk54VDcxRXg4ZGR6Y3FRdmJHcFlm?=
 =?utf-8?B?SzVJSm9qMDdmMGpvOGpHUmMvYkF5SW1GQ3BnR1FZYTI3R0JCSWVBRml6K1VR?=
 =?utf-8?B?UjkvdVBzWHYzTFVmUU15RVU1and3TWRNY1RTTWJncGRiWWRaN29aSEx4MlBB?=
 =?utf-8?B?V0V4enc1c1FrVCt5SHJpaWVJanpONkVSeE1VaWg5c21jbEFydHNobWlrdGNG?=
 =?utf-8?B?T3M3dzFLQWpPYkE3M1hsVG5HUW9odlRzeG1SS3dCYklaOVhybVNXZmpMNEIz?=
 =?utf-8?B?Tk0rSEIxVk10WjNXSGw4NW82bWowSVdPbCtVKzZ5YUhtaEpKUktPRmJsR2Vh?=
 =?utf-8?B?ZTMzclpxcWdnMFk0bTRHUFBweHNsY2hiNXV1dENKVTVEOTQraWFIYTZMUHFL?=
 =?utf-8?B?dnVjcWgyQUwybWV5MkwrM3VPT1pMMVFMSVhFSFVGdUFQSGhBaGdhQXZtR3pH?=
 =?utf-8?B?N2dmWWg4MGd1TmRRekp2aWNJN3VjcHA3ZUdmdnpTWmFvSHhac1NraGR0OWRn?=
 =?utf-8?B?bTJsU2Rkam13MXVPdFNDK0srMFp5VWxtQ1Ixakh2eU0zTUFyYXhzWmtsUm1w?=
 =?utf-8?B?T0JscXlGUHFzdWVidmpCdW1BMzlBbnlBdURiOG56QkZyRk9LL3lVRDVvUjNO?=
 =?utf-8?B?OUhQRWxFQ1RhU1R5dmJncDdTNmRUYTgyR1ZrU2pFSVdqYzdCVEltU2NYWHg3?=
 =?utf-8?B?VUV4WFZlL1B3cm5lTTA4L3ZTSDlKeUowWWxjY0YzWVh3M2dmdlQyVnR4YkZG?=
 =?utf-8?B?Qm84NHdRTHpsUGk5YVZiZHBaL3lYcmt1NzZZTEx6TnNLV0JJV2YrdDNmeS9N?=
 =?utf-8?B?cjQrQWlnOXByNnE5TjAyQWYxYktnTWVGcEtuZldzTk9YYzFja0cvTTlmY3hs?=
 =?utf-8?B?ZEFOeGpKaWFxTzR1bUpXZWlFMlgzdnREUkpPbko4YStYbGNFSkVuY3ltMEdj?=
 =?utf-8?B?NGdiNUgxemdLajdMM0QwTkJUN2pGbmI2anhxNldQQ0w2NmNXVWRNcktsY2d1?=
 =?utf-8?B?OEQ2NzljRXl6d3M0SjNsTS9BaG80MzlNVkZvd0lSNFJ5cks4aHY1Umx5RUFR?=
 =?utf-8?B?RzNaaS9uWE1MNTFReXlxbFdOMU9wc2lydWdKUGpCL3VqNXNOa3BIUnhGM1p0?=
 =?utf-8?B?VHJqU3h0U040MFh4Vm9ITnVzcmV4eGZaTkFVT0w2cTZqT0l3Z25zUHovWGdQ?=
 =?utf-8?B?RXorL28rTk9KNlJubmhEZTZXTnRLTk9iSjJ2VFRyNmdaS0IxUi9SR2R3L2lY?=
 =?utf-8?B?OGVyWmtXR3dUQlVmVVBqanIzVXBYQTl4ZEFBYnl5RHk5NDA3TmV2TWovKzBo?=
 =?utf-8?B?YVFqMnNXQXJTUnlIc0ZGVXFVTFpvdFYvbTVRZGkrdTZoTjdnU25TTVd3U0Rp?=
 =?utf-8?B?d0dHV0FwUTA0WGVpT1BkQ3ZGOHJyVmd1MEcwUm03YUFCWG02T0paeHJNbTBq?=
 =?utf-8?B?Rjh1dlhucEgyZDJzWEJ0NVlmeVFPZ3hoTDEzZjVabzZLenJncDBWeEYvL0pI?=
 =?utf-8?B?alZmWmdCeW12ZUpObTVWVFhCelFTTGMrZ3pYNGNuWFB0a09vdktuMFNWQ2JN?=
 =?utf-8?Q?ZSA0vDa3BlE6ZaTShG3zzTi2Q?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: tw.synaptics.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR03MB5848.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 794849b6-6c5b-45de-202c-08da79217bc5
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Aug 2022 09:36:34.3275
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 335d1fbc-2124-4173-9863-17e7051a2a0e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ccIPk7zA5U3LA+d8r1pvBDecwiS2KC36t90Jx/NrgW1xqwVlkTOfgaba1QGfKNsfuqpHSYT8Jk0Bq95VWOuakg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR03MB5245
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgSGFucywNCglGb3IgU3luYXB0aWNzIEZXIGRlc2lnbiwgdGhlIGludGVycnVwdCBHUElPIHdp
bGwgYmUgcHVsbGVkIGRvd24gYWZ0ZXIgUk1JIGRyaXZlciByZWFkcyB0aGlzIGNvbW1hbmQoUmVw
b3J0IElEOjB4MEEpLg0KIkRhcmsgcmVzdW1lIiB0ZXN0IGNhc2Ugb24gQ2hyb21lYm9vayBkZXZp
Y2Ugd2lsbCBkZXRlY3QgYW5vdGhlciBpbnRlcnJ1cHQgKG5vdCBmaW5nZXIgZGF0YSkgZHVyaW5n
IHRoZSBwcm9jZXNzIG9mIHJlc3VtZSBmdW5jdGlvbi4NCiJEYXJrIHJlc3VtZSIgdGVzdCBjYXNl
IHdpbGwgZmFpbC4NCkhlbmNlLCB0aGlzIGlzc3VlIHNob3VsZCBoYXBwZW4gb24gUk1JIG1vZGUg
b2YgYWxsIFN5bmFwdGljcyBkZXZpY2VzDQoNClRoYW5rcw0KTWFyZ2UgWWFuZw0KDQotLS0tLU9y
aWdpbmFsIE1lc3NhZ2UtLS0tLQ0KRnJvbTogSGFucyBkZSBHb2VkZSA8aGRlZ29lZGVAcmVkaGF0
LmNvbT4gDQpTZW50OiBNb25kYXksIEF1Z3VzdCA4LCAyMDIyIDU6MTYgUE0NClRvOiBtYXJnZXlh
bmcgPG1hcmdlLnlhbmdAc3luYXB0aWNzLmNvcnAtcGFydG5lci5nb29nbGUuY29tPjsgZG1pdHJ5
LnRvcm9raG92QGdtYWlsLmNvbTsgbGludXgtaW5wdXRAdmdlci5rZXJuZWwub3JnOyBsaW51eC1r
ZXJuZWxAdmdlci5rZXJuZWwub3JnOyBiZW5qYW1pbi50aXNzb2lyZXNAcmVkaGF0LmNvbQ0KQ2M6
IE1hcmdlIFlhbmcgPE1hcmdlLllhbmdAdHcuc3luYXB0aWNzLmNvbT47IGRlcmVrLmNoZW5nQHR3
LnN5bmFwdGNzLmNvbTsgVmluY2VudCBIdWFuZyA8VmluY2VudC5odWFuZ0B0dy5zeW5hcHRpY3Mu
Y29tPg0KU3ViamVjdDogUmU6IFtQQVRDSF0gSElEOiBISUQtcm1pIC0gaWdub3JlIHRvIHJtaV9o
aWRfcmVhZF9ibG9jayBhZnRlciBzeXN0ZW0gcmVzdW1lcy4NCg0KQ0FVVElPTjogRW1haWwgb3Jp
Z2luYXRlZCBleHRlcm5hbGx5LCBkbyBub3QgY2xpY2sgbGlua3Mgb3Igb3BlbiBhdHRhY2htZW50
cyB1bmxlc3MgeW91IHJlY29nbml6ZSB0aGUgc2VuZGVyIGFuZCBrbm93IHRoZSBjb250ZW50IGlz
IHNhZmUuDQoNCg0KSGksDQoNCk9uIDgvOC8yMiAxMTowNywgbWFyZ2V5YW5nIHdyb3RlOg0KPiBG
cm9tOiBNYXJnZSBZYW5nIDxtYXJnZS55YW5nQHN5bmFwdGljcy5jb3JwLXBhcnRuZXIuZ29vZ2xl
LmNvbT4NCj4NCj4gVGhlIGludGVycnVwdCBHUElPIHdpbGwgYmUgcHVsbGVkIGRvd24gb25jZSBh
ZnRlciBSTUkgZHJpdmVyIHJlYWRzIA0KPiB0aGlzIGNvbW1hbmQoUmVwb3J0IElEOjB4MEEpLg0K
PiBJdCB3aWxsIGNhdXNlICJEYXJrIHJlc3VtZSB0ZXN0IGZhaWwiIGZvciBjaHJvbWVib29rIGRl
dmljZS4NCj4gSGVuY2UsIFRQIGRyaXZlciB3aWxsIGlnbm9yZSBybWlfaGlkX3JlYWRfYmxvY2sg
ZnVuY3Rpb24gb25jZSBhZnRlciANCj4gc3lzdGVtIHJlc3VtZXMuDQoNClRoaXMgc291bmRzIGxp
a2UgaXQgaXMgYW4gaXNzdWUgaW4gb25lIHNwZWNpZmljIHRvdWNocGFkIG1vZGVsLCB5ZXQgeW91
IGFyZSBjaGFuZ2luZyB0aGUgY29kZSB0byBpZ25vcmUgdGhlIGZpcnN0IHJlYWRibG9jayBjYWxs
IG9uIHJlc3VtZSBvbiAqYWxsKiBtb2RlbHMgPw0KDQpSZWdhcmRzLA0KDQpIYW5zDQoNCg0KPg0K
PiBTaWduZWQtb2ZmLWJ5OiBNYXJnZSANCj4gWWFuZzxtYXJnZS55YW5nQHN5bmFwdGljcy5jb3Jw
LXBhcnRuZXIuZ29vZ2xlLmNvbT4NCj4gLS0tDQo+ICBkcml2ZXJzL2hpZC9oaWQtcm1pLmMgfCAx
NiArKysrKysrKysrKysrLS0tDQo+ICAxIGZpbGUgY2hhbmdlZCwgMTMgaW5zZXJ0aW9ucygrKSwg
MyBkZWxldGlvbnMoLSkNCj4NCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvaGlkL2hpZC1ybWkuYyBi
L2RyaXZlcnMvaGlkL2hpZC1ybWkuYyBpbmRleCANCj4gMzExZWVlNTk5Y2U5Li4yMzZhMzhiZmNm
OWEgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvaGlkL2hpZC1ybWkuYw0KPiArKysgYi9kcml2ZXJz
L2hpZC9oaWQtcm1pLmMNCj4gQEAgLTEwMSw3ICsxMDEsNyBAQCBzdHJ1Y3Qgcm1pX2RhdGEgew0K
PiAgfTsNCj4NCj4gICNkZWZpbmUgUk1JX1BBR0UoYWRkcikgKCgoYWRkcikgPj4gOCkgJiAweGZm
KQ0KPiAtDQo+ICtpbnQgaWdub3Jlb25jZTsNCj4gIHN0YXRpYyBpbnQgcm1pX3dyaXRlX3JlcG9y
dChzdHJ1Y3QgaGlkX2RldmljZSAqaGRldiwgdTggKnJlcG9ydCwgaW50IA0KPiBsZW4pOw0KPg0K
PiAgLyoqDQo+IEBAIC0yMDMsNyArMjAzLDEzIEBAIHN0YXRpYyBpbnQgcm1pX2hpZF9yZWFkX2Js
b2NrKHN0cnVjdCBybWlfdHJhbnNwb3J0X2RldiAqeHBvcnQsIHUxNiBhZGRyLA0KPiAgICAgICAg
ICAgICAgIGlmIChyZXQgPCAwKQ0KPiAgICAgICAgICAgICAgICAgICAgICAgZ290byBleGl0Ow0K
PiAgICAgICB9DQo+IC0NCj4gKyAgICAgaWYgKGlnbm9yZW9uY2UgPT0gMSkgew0KPiArICAgICAg
ICAgICAgIGRldl9lcnIoJmhkZXYtPmRldiwNCj4gKyAgICAgICAgICAgICAgICAgICAgICJpZ25v
cmVvbmNlICglZClcbiIsDQo+ICsgICAgICAgICAgICAgICAgICAgICBpZ25vcmVvbmNlKTsNCj4g
KyAgICAgICAgICAgICBpZ25vcmVvbmNlID0gMDsNCj4gKyAgICAgICAgICAgICBnb3RvIGV4aXQ7
DQo+ICsgICAgIH0NCj4gICAgICAgZm9yIChyZXRyaWVzID0gNTsgcmV0cmllcyA+IDA7IHJldHJp
ZXMtLSkgew0KPiAgICAgICAgICAgICAgIGRhdGEtPndyaXRlUmVwb3J0WzBdID0gUk1JX1JFQURf
QUREUl9SRVBPUlRfSUQ7DQo+ICAgICAgICAgICAgICAgZGF0YS0+d3JpdGVSZXBvcnRbMV0gPSAw
OyAvKiBvbGQgMSBieXRlIHJlYWQgY291bnQgKi8gQEAgDQo+IC00NjgsOCArNDc0LDEyIEBAIHN0
YXRpYyBpbnQgcm1pX3Bvc3RfcmVzdW1lKHN0cnVjdCBoaWRfZGV2aWNlICpoZGV2KQ0KPiAgICAg
ICByZXQgPSBoaWRfaHdfb3BlbihoZGV2KTsNCj4gICAgICAgaWYgKHJldCkNCj4gICAgICAgICAg
ICAgICByZXR1cm4gcmV0Ow0KPiAtDQo+ICsgICAgIC8vIEF2b2lkIHRvIHJlYWQgcm1pX2hpZF9y
ZWFkX2Jsb2NrIG9uY2UgYWZ0ZXIgc3lzdGVtIHJlc3VtZXMuDQo+ICsgICAgIC8vIFRoZSBpbnRl
cnJ1cHQgd2lsbCBiZSBwdWxsZWQgZG93bg0KPiArICAgICAvLyBhZnRlciBSTUkgUmVhZCBjb21t
YW5kKFJlcG9ydCBJRDoweDBBKS4NCj4gKyAgICAgaWdub3Jlb25jZSA9IDE7DQo+ICAgICAgIHJl
dCA9IHJtaV9yZXNldF9hdHRuX21vZGUoaGRldik7DQo+ICsgICAgIGlnbm9yZW9uY2UgPSAwOw0K
PiAgICAgICBpZiAocmV0KQ0KPiAgICAgICAgICAgICAgIGdvdG8gb3V0Ow0KPg0KDQo=
