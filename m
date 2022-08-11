Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDC3E58F641
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Aug 2022 05:04:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233911AbiHKDEm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Aug 2022 23:04:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233269AbiHKDEh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Aug 2022 23:04:37 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2069.outbound.protection.outlook.com [40.107.237.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 506812181F;
        Wed, 10 Aug 2022 20:04:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QNKbGcImclFwSfClPQkfZV8/9fAOyN7szx9n1YkLBiWyFFCN2fdG9xU0xcHJ8qUrwZjapUPaKuraxChjUiGIL4n2i7S7UndWgJxL0Mr7Iu4xPjw9bW0MYi+yOpVBiJtfSBHYxnqzPerqdz64Z8waKzTMflwOqeYt7054q49qXlCs91HWzAKzhljxjZGmrp4xiIfYYZlKsh9LB3CQzqcbSvY6Ql1mLwlP40lY/CnbdBU2kJAhLihI616Bk9RoIBqn3zBA8wosytHHLfm1KIZPnrxfsd8Ii32wBr+Ad4rOVXkgNU1p5yxtfXTKb6gd5gk1sZWhI4tQjyS8BuSy/tkWgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=upfnd7PFmxS8fmkLvBR4UHL4m8IeYw9YaEsGpnhXFag=;
 b=BUh5cr5tMyH4ZgapqKs42tJR5heKRV6AjwoADhpU/vMEWHTdFQsZsA/MaDiFhaiB/PqjQt/5aNKgDsREjvJy8XJxop3ftnyanWGiitpeB52D4NM7Ru9Sh+MsU+XON9cnSF/n+4J+Iexnybt+6l22qPWS0NvlDM0Ea8LD6EVxoYohniOiBrLQbpGR39U7xSek/vPr/PNHxC4OwmGVRyAQian9O4yZX4AU/XjMkxuCo00IBqqmXf+Um/dci+Uyjj4owLxk/jWR9KrfaFJtLQBpFnt+Ks+/44/rR2GeDJ7gvI21fns4VA88GKZGArIrEBhZieOQSsh8brE/JhMbLBrTfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=tw.synaptics.com; dmarc=pass action=none
 header.from=tw.synaptics.com; dkim=pass header.d=tw.synaptics.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Synaptics.onmicrosoft.com; s=selector2-Synaptics-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=upfnd7PFmxS8fmkLvBR4UHL4m8IeYw9YaEsGpnhXFag=;
 b=Sh92IthdFa0C3D6RB/xXGKdjwlNrOYas0Xw0dPlG+aO+Sw4qCDSIjzL8x4NXyvmzDUAPs2VrYi68JliIZizK2rjuqorh1U0y/Yoj8EbUWZxjHsKkEfC2NdY2F5hVT7Q1meK4Y9wCsBC7Z4u4iy+DavOPqjwNKG89ayB/vtqW1jQ=
Received: from PH0PR03MB5848.namprd03.prod.outlook.com (2603:10b6:510:30::19)
 by SN4PR03MB6782.namprd03.prod.outlook.com (2603:10b6:806:215::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.14; Thu, 11 Aug
 2022 03:04:32 +0000
Received: from PH0PR03MB5848.namprd03.prod.outlook.com
 ([fe80::60b1:a766:c174:65ca]) by PH0PR03MB5848.namprd03.prod.outlook.com
 ([fe80::60b1:a766:c174:65ca%8]) with mapi id 15.20.5504.020; Thu, 11 Aug 2022
 03:04:32 +0000
From:   Marge Yang <Marge.Yang@tw.synaptics.com>
To:     Hans de Goede <hdegoede@redhat.com>,
        margeyang <marge.yang@synaptics.corp-partner.google.com>,
        "dmitry.torokhov@gmail.com" <dmitry.torokhov@gmail.com>,
        "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "benjamin.tissoires@redhat.com" <benjamin.tissoires@redhat.com>
CC:     Derek Cheng <derek.cheng@tw.synaptics.com>,
        Vincent Huang <Vincent.huang@tw.synaptics.com>,
        David Chiu <David.Chiu@tw.synaptics.com>
Subject: RE: [PATCH V2] HID: HID-rmi - ignore to rmi_hid_read_block after
 system resumes.
Thread-Topic: [PATCH V2] HID: HID-rmi - ignore to rmi_hid_read_block after
 system resumes.
Thread-Index: AQHYq51oAm+xFIO8AEmCl7ya7nOwLq2n6/eAgAEZbXA=
Date:   Thu, 11 Aug 2022 03:04:31 +0000
Message-ID: <PH0PR03MB5848C566BA8FAF1929669E89A3649@PH0PR03MB5848.namprd03.prod.outlook.com>
References: <1660014544-1009-1-git-send-email-marge.yang@synaptics.corp-partner.google.com>
 <a68bb582-d916-d5f9-3ed6-401a63f46ce6@redhat.com>
In-Reply-To: <a68bb582-d916-d5f9-3ed6-401a63f46ce6@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNcbXlhbmdcYXBwZGF0YVxyb2FtaW5nXDA5ZDg0OWI2LTMyZDMtNGE0MC04NWVlLTZiODRiYTI5ZTM1Ylxtc2dzXG1zZy00ZmQwYTA2MS0xOTIyLTExZWQtODJkNi1mODU5NzE0OTljZGNcYW1lLXRlc3RcNGZkMGEwNjItMTkyMi0xMWVkLTgyZDYtZjg1OTcxNDk5Y2RjYm9keS50eHQiIHN6PSIzNTE3IiB0PSIxMzMwNDY2MDY2ODc1NzY5NzMiIGg9Ino5NU11eGZTQ2RvUWRYTDVIUFRrTXVtK09kUT0iIGlkPSIiIGJsPSIwIiBibz0iMSIvPjwvbWV0YT4=
x-dg-rorf: true
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=tw.synaptics.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4dd72720-2e58-406e-2bd9-08da7b46369a
x-ms-traffictypediagnostic: SN4PR03MB6782:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: FeGEAnK69VXehOxZU/6Gp/8LvF9wkE+hUmG9SPmh25xNiitcnwJr3GL9tb+wh/1aEN/ToQcw6yhKcXRhJA5U2MWDG8PkLy+PlKjbsQbyHoaJ0cThbO7tkdJSKYPNBehN7hOOnqbhldT4VWEEG4Lw7Y3lBCYbZjZQAQSqOjLvEIaiV5Dk2VHzSXSAfpJs6igIcK57GjXIJn7L+t45k6NVdK11EzNj67H6dLKOfNIbd1mFRrHbw0t+chxp6bmtcD7lIOzSQCM6wrIOALG+DKepKbxnYOYNnZAHG3z+8DSy5dWxtkFPa189HDbjiMrrGDCOvzLZTqhiZdn6x8VNsSPUcndItmcLJtiLKD8jAkSasiPVyIafz3XYRtVkMISBzTND+Ol00SS4hFf2c4OzR5bbc2UKDOmXtEnDr0r9NIQxk+szkJ3fdOKzHTclxW03GUVB2uImeWJU995aAX4gcovZ4XcR5nLI94JN4rubE9TtXRRN6COsoP0kopVlpoyhui72S6Ga+NPL9a+8CeqErJP41y0mM9eywOb2IxhL1sdzZe5hW93Vy1l5isrwb0oRyM94FjORX5pGdGzJRlsmcGigTQ4Zf4lAWxMijHPS/IbTe+PiAKBQCYTBUGyqwFbDTQwlY2lghSPRnDqlHvEPHDuuZ7R/tqly0+RAyV1Y1AbjrifXYHl4VE30Wcf2s39OqMesBTtwp9H0UuaZwSWVz7Xr1FmpY6Ji2mVNqor7GzSoUmhcK7RDEv/Cx+D3MQL9HDkWaWAz7OfTSNSXdz3Gd0xrla8zDZxghejKKml8xvQbN/7O+VV6WB9P/RFKK5i/qKC+
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR03MB5848.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(396003)(136003)(366004)(346002)(376002)(39860400002)(83380400001)(122000001)(38070700005)(86362001)(66476007)(76116006)(55016003)(66556008)(8676002)(4326008)(38100700002)(66946007)(64756008)(33656002)(66446008)(110136005)(52536014)(54906003)(186003)(478600001)(316002)(41300700001)(2906002)(26005)(6506007)(107886003)(7696005)(71200400001)(53546011)(8936002)(9686003)(5660300002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZzQ5UGdnL29yTGdFMktiMmJQQ0JCQkJ4ejFMTldWRVJlR2RKMXRDNVFqV3ha?=
 =?utf-8?B?bW50elpNWFZSa0dpYjdGS1d1aGt6YXJLeXpqRmY1dERUM2pHb0RiT0lPVUsz?=
 =?utf-8?B?NmQ4b241WVlOOS90bVhkTDZTU2gwd0I2bnlQZEJLQXp0TklXSDFMaGxOZkl4?=
 =?utf-8?B?UERLcno1dVpQbm5iV2ExMGplMlN2cHRzMXhWSEZydURjMzZqUWZKUWJhMkpy?=
 =?utf-8?B?YVN2ODVpcUI5NnljSi9LbWs4MUpmaVBrMGFobTVjWkVNZ3FlUWFxaXg5V0hq?=
 =?utf-8?B?cWhtSlYwZEZrZVhqeXFiL0FKRm5PMmtIQTZjN090TS9VRFpqbmdDekgxNVlE?=
 =?utf-8?B?LytWdzVvdHdkcDJUTlZ6OTlkTHJzSGtjaGlLTEx6eDZlOHlHOHkxTlZuTjFC?=
 =?utf-8?B?bmZxTHgvVUl2RHU3dmRqaGN1OUFOSmhqWVJ5ZW9TUTRrbldYUzNnZ2JWN0sr?=
 =?utf-8?B?dGYvUVFXR050OEVwT1VCZ3ZJbFptVnVOVlNVY0EwejNnOWVvWXNodXRTOWZl?=
 =?utf-8?B?WEFlQ0o1ekRiMXN0Zk81azFacmZISnArbXZWSHBXZXVwbDJoSW52b2VreXBC?=
 =?utf-8?B?MXRDVm5jMVNZMTBBKzBOV2JkMUR0WTAwTWJUU0c3WWJSUXlmMUEzQmpCOGJ0?=
 =?utf-8?B?MXhpU2l2c05YcmhZb21MK2owVURXeG9EYmU5U2lRdzhlNy83allpNmxCaHo5?=
 =?utf-8?B?ZDNBaTVWQUFPcmNmNjZnRjVqVFA4cXlDMWFhVTFKRUF3a2VHbVBJZ2lrT2RO?=
 =?utf-8?B?T0xLeHFoWG9kc0dLTE1LczliN0FuTnViajJpRGJRRnUrT1lRT3RyS1hpNjVu?=
 =?utf-8?B?UEZWSUw5L3hDL1B5RG1ZbE1ETEJob0JoRWhEZ1Rubk41UzJ0eFhoYk5yQ0Jp?=
 =?utf-8?B?RDZ4ZU9Hc1B1S2YyRGR5dWIyb05hS0c3bm1DMkYyM05VMjRqeGY5YXJleDFk?=
 =?utf-8?B?S2loeERrZmRZMnRISDlHZTRBT3dheWx3d2xncyttUld2WGFvaENhUzh2bGJU?=
 =?utf-8?B?d0Q0S3VBOXJmRndFa2ZLemlES2FTRlFRc1Q1bnd2eXZJQU55ajZ0UXJKaVlM?=
 =?utf-8?B?Y1RZMkNPd2pQNzZNQXkrSEJpcUF4RFFaZkMzQkF1bzluOTRrV3oveHFyaFBo?=
 =?utf-8?B?YVJMTHJuTHNIdURWOS9OR3kzOWRwc0tSYWZIZnNIZXdJWGl5WjdZVDB6RXZ6?=
 =?utf-8?B?clJzZFA4Q2ZUZitmUmlmYVdVc09DTzB5aXBCcE8vSFV1RTlYOTNUYW9HUkpK?=
 =?utf-8?B?cFJtZzQzYVBzRTFQbCtOQUw1WjZiUm1BWnRJUHJmSVFKWGIxRjJFVHMrM1V3?=
 =?utf-8?B?anJGL1VKRFcwYVBUVUUvcXRoSmx4TEpFMGpMQmZtSTVNeUVzT0RkZ1VqUWJr?=
 =?utf-8?B?bG53SXBkNGZ0MXF0ZWpsbWVyKy8xK2JJV0g4ZHJmY0xPbTYrVm1pbEVtRUow?=
 =?utf-8?B?a0lOU0ZWOHc1VVN2MlE2Sk5SRHo1UlUyTXpKb1JzZDRVSHlydzZubWhGd2NG?=
 =?utf-8?B?SGVoQmpOZG9vblY5YlBBREdQS3VWVDhlcTZFSlcxVWppSVVxdGk1NlM0VG5I?=
 =?utf-8?B?LzJSQUViZUlibnUraUxJVkU5NisxOFJHcnp0R3U4b0VKM2o2YTM4ak0rcUlM?=
 =?utf-8?B?RHlJa2JTNHlWZmhweGlaR2g0UlFHMGFxd0g2TVpNY0l5WTB3cHBHY0ZrZEtZ?=
 =?utf-8?B?ZE1Xai8rY0FXSkVUeDVtSTJxRTFBcEJ6dEUyTnR0QkVaSlpWRVZvRVAwV0Rv?=
 =?utf-8?B?WEpXbENybzRpb0dDN0ZQdzUvWVY5bThSdW1Ta2l6Wm1WM21FUy8yZTVMeWl3?=
 =?utf-8?B?QjhDSHE2NlZudGoyVHZ1WGVZSDVjUHhBZ2VIUHhRdXdqNTBMNmZjNnp0WE43?=
 =?utf-8?B?ZURiZHNNcUEvd0FGMzRrQkx5alVSWkRYNndkRE54UkpiT3dPaEFud3k5YUh5?=
 =?utf-8?B?QS9DdXl3cW9wZEkrZG5seHI0aXpMVmtucEZuZjM3alVWSkJGbEtlNkRBbUZk?=
 =?utf-8?B?NjBjNkpGVldLVThvc1pxMm9PQ2lqOEsxeVRqczJBNWRxZ25QRURGZEVYQ1JI?=
 =?utf-8?B?Ti9zbWRteHNnNXdtREMxd2xPZHM4elAxVmdUUXFWWlQxSTZnOEE1RFErOEhD?=
 =?utf-8?Q?ru2G2vwzmTg9Z7TKyeEsJS7IV?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: tw.synaptics.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR03MB5848.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4dd72720-2e58-406e-2bd9-08da7b46369a
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Aug 2022 03:04:31.9878
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 335d1fbc-2124-4173-9863-17e7051a2a0e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: foK9bWQzg1GdP/56uyNtQOpckkK9ad5ekXjDo0tITWOW8pwtj0wMRsDFO2Rop9fLnlNpoTAutLeEXj1tZ/rNEw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR03MB6782
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgSGFucywNCglUaGFua3MgZm9yIHlvdXIgc3VnZ2VzdGlvbi4NCgkNCglpZiAoeHBvcnQtPmln
bm9yZW9uY2UgPT0gMSkgew0KDQpJIGhhdmUgbW9kaWZpZWQvdmVyaWZpZWQgaXQgYW5kIHNlbnQg
M3JkIHZlcnNpb24uDQoNClRoYW5rcw0KTWFyZ2UgWWFuZw0KDQotLS0tLU9yaWdpbmFsIE1lc3Nh
Z2UtLS0tLQ0KRnJvbTogSGFucyBkZSBHb2VkZSA8aGRlZ29lZGVAcmVkaGF0LmNvbT4gDQpTZW50
OiBXZWRuZXNkYXksIEF1Z3VzdCAxMCwgMjAyMiA2OjEyIFBNDQpUbzogbWFyZ2V5YW5nIDxtYXJn
ZS55YW5nQHN5bmFwdGljcy5jb3JwLXBhcnRuZXIuZ29vZ2xlLmNvbT47IGRtaXRyeS50b3Jva2hv
dkBnbWFpbC5jb207IGxpbnV4LWlucHV0QHZnZXIua2VybmVsLm9yZzsgbGludXgta2VybmVsQHZn
ZXIua2VybmVsLm9yZzsgYmVuamFtaW4udGlzc29pcmVzQHJlZGhhdC5jb20NCkNjOiBNYXJnZSBZ
YW5nIDxNYXJnZS5ZYW5nQHR3LnN5bmFwdGljcy5jb20+OyBEZXJlayBDaGVuZyA8ZGVyZWsuY2hl
bmdAdHcuc3luYXB0aWNzLmNvbT47IFZpbmNlbnQgSHVhbmcgPFZpbmNlbnQuaHVhbmdAdHcuc3lu
YXB0aWNzLmNvbT4NClN1YmplY3Q6IFJlOiBbUEFUQ0ggVjJdIEhJRDogSElELXJtaSAtIGlnbm9y
ZSB0byBybWlfaGlkX3JlYWRfYmxvY2sgYWZ0ZXIgc3lzdGVtIHJlc3VtZXMuDQoNCkNBVVRJT046
IEVtYWlsIG9yaWdpbmF0ZWQgZXh0ZXJuYWxseSwgZG8gbm90IGNsaWNrIGxpbmtzIG9yIG9wZW4g
YXR0YWNobWVudHMgdW5sZXNzIHlvdSByZWNvZ25pemUgdGhlIHNlbmRlciBhbmQga25vdyB0aGUg
Y29udGVudCBpcyBzYWZlLg0KDQoNCkhpLA0KDQpPbiA4LzkvMjIgMDU6MDksIG1hcmdleWFuZyB3
cm90ZToNCj4gRnJvbTogTWFyZ2UgWWFuZyA8bWFyZ2UueWFuZ0BzeW5hcHRpY3MuY29ycC1wYXJ0
bmVyLmdvb2dsZS5jb20+DQo+DQo+IFRoZSBpbnRlcnJ1cHQgR1BJTyB3aWxsIGJlIHB1bGxlZCBk
b3duIG9uY2UgYWZ0ZXIgUk1JIGRyaXZlciByZWFkcyANCj4gdGhpcyBjb21tYW5kKFJlcG9ydCBJ
RDoweDBBKS4NCj4gSXQgd2lsbCBjYXVzZSAiRGFyayByZXN1bWUgdGVzdCBmYWlsIiBmb3IgY2hy
b21lYm9vayBkZXZpY2UuDQo+IEhlbmNlLCBUUCBkcml2ZXIgd2lsbCBpZ25vcmUgcm1pX2hpZF9y
ZWFkX2Jsb2NrIGZ1bmN0aW9uIG9uY2UgYWZ0ZXIgDQo+IHN5c3RlbSByZXN1bWVzLg0KPg0KPiBT
aWduZWQtb2ZmLWJ5OiBNYXJnZSANCj4gWWFuZzxtYXJnZS55YW5nQHN5bmFwdGljcy5jb3JwLXBh
cnRuZXIuZ29vZ2xlLmNvbT4NCj4gLS0tDQo+ICBkcml2ZXJzL2hpZC9oaWQtcm1pLmMgfCAxNCAr
KysrKysrKysrKystLQ0KPiAgaW5jbHVkZS9saW51eC9ybWkuaCAgIHwgIDIgKysNCj4gIDIgZmls
ZXMgY2hhbmdlZCwgMTQgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkNCj4NCj4gZGlmZiAt
LWdpdCBhL2RyaXZlcnMvaGlkL2hpZC1ybWkuYyBiL2RyaXZlcnMvaGlkL2hpZC1ybWkuYyBpbmRl
eCANCj4gMzExZWVlNTk5Y2U5Li5iMDhiNzRiMGMxNDAgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMv
aGlkL2hpZC1ybWkuYw0KPiArKysgYi9kcml2ZXJzL2hpZC9oaWQtcm1pLmMNCj4gQEAgLTIwMyw3
ICsyMDMsMTMgQEAgc3RhdGljIGludCBybWlfaGlkX3JlYWRfYmxvY2soc3RydWN0IHJtaV90cmFu
c3BvcnRfZGV2ICp4cG9ydCwgdTE2IGFkZHIsDQo+ICAgICAgICAgICAgICAgaWYgKHJldCA8IDAp
DQo+ICAgICAgICAgICAgICAgICAgICAgICBnb3RvIGV4aXQ7DQo+ICAgICAgIH0NCj4gLQ0KPiAr
ICAgICBpZiAoKCEheHBvcnQpICYmICh4cG9ydC0+aWdub3Jlb25jZSA9PSAxKSkgew0KDQpUaGUg
dG9wIG9mIHRoaXMgZnVuY3Rpb24gaGFzOg0KDQogICAgICAgc3RydWN0IHJtaV9kYXRhICpkYXRh
ID0gY29udGFpbmVyX29mKHhwb3J0LCBzdHJ1Y3Qgcm1pX2RhdGEsIHhwb3J0KTsNCg0KYW5kIGRh
dGEgZ2V0cyBkZXJlZmVyZW5jZWQgdW5jb25kaXRpb25hbGx5IGluIHZhcmlvdXMgcGxhY2VzLCBz
byB0aGVyZSBpcyBubyBuZWVkIGZvciB0aGUgeHBvcnQgY2hlY2ssIHBsZWFzZSBjaGFuZ2UgdGhp
cyB0byBqdXN0Og0KDQogICAgICAgIGlmICh4cG9ydC0+aWdub3Jlb25jZSA9PSAxKSB7DQoNCk90
aGVyd2lzZSB0aGlzIGxvb2tzIGdvb2QgdG8gbWUgbm93Lg0KDQpSZWdhcmRzLA0KDQpIYW5zDQoN
Cg0KPiArICAgICAgICAgICAgIGRldl9lcnIoJmhkZXYtPmRldiwNCj4gKyAgICAgICAgICAgICAg
ICAgICAgICJpZ25vcmVvbmNlICglZClcbiIsDQo+ICsgICAgICAgICAgICAgICAgICAgICB4cG9y
dC0+aWdub3Jlb25jZSk7DQo+ICsgICAgICAgICAgICAgeHBvcnQtPmlnbm9yZW9uY2UgPSAwOw0K
PiArICAgICAgICAgICAgIGdvdG8gZXhpdDsNCj4gKyAgICAgfQ0KPiAgICAgICBmb3IgKHJldHJp
ZXMgPSA1OyByZXRyaWVzID4gMDsgcmV0cmllcy0tKSB7DQo+ICAgICAgICAgICAgICAgZGF0YS0+
d3JpdGVSZXBvcnRbMF0gPSBSTUlfUkVBRF9BRERSX1JFUE9SVF9JRDsNCj4gICAgICAgICAgICAg
ICBkYXRhLT53cml0ZVJlcG9ydFsxXSA9IDA7IC8qIG9sZCAxIGJ5dGUgcmVhZCBjb3VudCAqLyBA
QCANCj4gLTQ2OCw4ICs0NzQsMTIgQEAgc3RhdGljIGludCBybWlfcG9zdF9yZXN1bWUoc3RydWN0
IGhpZF9kZXZpY2UgKmhkZXYpDQo+ICAgICAgIHJldCA9IGhpZF9od19vcGVuKGhkZXYpOw0KPiAg
ICAgICBpZiAocmV0KQ0KPiAgICAgICAgICAgICAgIHJldHVybiByZXQ7DQo+IC0NCj4gKyAgICAg
Ly8gQXZvaWQgdG8gcmVhZCBybWlfaGlkX3JlYWRfYmxvY2sgb25jZSBhZnRlciBzeXN0ZW0gcmVz
dW1lcy4NCj4gKyAgICAgLy8gVGhlIGludGVycnVwdCB3aWxsIGJlIHB1bGxlZCBkb3duDQo+ICsg
ICAgIC8vIGFmdGVyIFJNSSBSZWFkIGNvbW1hbmQoUmVwb3J0IElEOjB4MEEpLg0KPiArICAgICBk
YXRhLT54cG9ydC5pZ25vcmVvbmNlID0gMTsNCj4gICAgICAgcmV0ID0gcm1pX3Jlc2V0X2F0dG5f
bW9kZShoZGV2KTsNCj4gKyAgICAgZGF0YS0+eHBvcnQuaWdub3Jlb25jZSA9IDA7DQo+ICAgICAg
IGlmIChyZXQpDQo+ICAgICAgICAgICAgICAgZ290byBvdXQ7DQo+DQo+IGRpZmYgLS1naXQgYS9p
bmNsdWRlL2xpbnV4L3JtaS5oIGIvaW5jbHVkZS9saW51eC9ybWkuaCBpbmRleCANCj4gYWI3ZWVh
MDFhYjQyLi4yNGY2M2FkMDA5NzAgMTAwNjQ0DQo+IC0tLSBhL2luY2x1ZGUvbGludXgvcm1pLmgN
Cj4gKysrIGIvaW5jbHVkZS9saW51eC9ybWkuaA0KPiBAQCAtMjcwLDYgKzI3MCw4IEBAIHN0cnVj
dCBybWlfdHJhbnNwb3J0X2RldiB7DQo+ICAgICAgIHN0cnVjdCBybWlfZGV2aWNlX3BsYXRmb3Jt
X2RhdGEgcGRhdGE7DQo+DQo+ICAgICAgIHN0cnVjdCBpbnB1dF9kZXYgKmlucHV0Ow0KPiArDQo+
ICsgICAgIGludCBpZ25vcmVvbmNlOw0KPiAgfTsNCj4NCj4gIC8qKg0KDQo=
