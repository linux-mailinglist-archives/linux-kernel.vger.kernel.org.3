Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3352350F93F
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 11:58:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348076AbiDZJ5A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 05:57:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348016AbiDZJ4s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 05:56:48 -0400
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01on2118.outbound.protection.outlook.com [40.107.113.118])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D762340E0
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 02:14:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j28MsCG9JQYysQNk3idPiNwHujsiqhdL9BxzOGf4QpEmG6Cax/jLwlkBqJ2q1FzCVEij960q5hg3QUe1q6e8xxXUfDmhUJ0vnF0FbsNQG7+O6uiz76KgKNmX/85UbU/VOM7AZRjPSzAK4ClbnkRRvG1RrZHCN3Ey47CkKeFIGMPQaiu5MwcSddqW6ppnjB18yuOYCZjGqJJsDWIn+cdJwVdpXFCC4dWS4KVguzEZUOHZyAF14hVZDwh0okt+TIRsCHvlbIsN9sym1q1/JbuGEgh5Z0i/pJ4tNUGyA6cv+FtJ+kXZFIdMO/LGSLuMmbonKoSzB5XR5mR0v5hmpEw3sA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ai7oqJQIPPY9UISaDZ4EhDpDMOXSFkabrYddM/PnsgQ=;
 b=QU/2yc5GbplsCyXCZlOb8hXNsn5OsfizKZ/gbXEuH75qX/lylP5SyaCySTnKM7q0R2a79a6rsf1fP0H9HiPc+KnZGsD3er+BcoTJtDwXev8mA/ABrj3PAfi+cKFYW8jMXtX85BY4yKK8I3NaV5RNHp0FZYIpListrZcIfcsSCy32bjSut099Ka2F1+7jPytBGy5aUE7uw2uxNFPMtM+1cGGmkmxnvLUiVn5D2IlYXhDNYAhSWicr6YjCZXFnyEPeHVdnQ7iV9Up737yXNSD81EnINEx/IZzedNytKgHw3dTcCC3Zz6ST5d1yDMvdwbIwXBOhoClhM4a9tn42Fr4eHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=dm.renesas.com; dmarc=pass action=none
 header.from=dm.renesas.com; dkim=pass header.d=dm.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dm.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ai7oqJQIPPY9UISaDZ4EhDpDMOXSFkabrYddM/PnsgQ=;
 b=aFlMbLy/01njrwVSspNiyovdUylJKA2ueDFQznXOXf4YMDr1/uZ5+tG8WjG1T1nZFVtxDxacTl/YNEtC7KFbqqwsnpqywr7brE3ydNTnvZ5ATgj99iDn5tRwU+kYQBbkqQhhgQQNfj4qxVH2p0/kKFkEvFvtd2ZB1BtLgJYe7/c=
Received: from OSAPR01MB5060.jpnprd01.prod.outlook.com (2603:1096:604:6e::17)
 by TYAPR01MB3870.jpnprd01.prod.outlook.com (2603:1096:404:c5::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.13; Tue, 26 Apr
 2022 09:14:34 +0000
Received: from OSAPR01MB5060.jpnprd01.prod.outlook.com
 ([fe80::15ba:6d34:ba18:2a8a]) by OSAPR01MB5060.jpnprd01.prod.outlook.com
 ([fe80::15ba:6d34:ba18:2a8a%5]) with mapi id 15.20.5186.021; Tue, 26 Apr 2022
 09:14:34 +0000
From:   DLG Adam Thomson <DLG-Adam.Thomson.Opensource@dm.renesas.com>
To:     Helmut Grohne <helmut.grohne@intenta.de>,
        Support Opensource <Support.Opensource@diasemi.com>,
        Lee Jones <lee.jones@linaro.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        DLG Adam Thomson <DLG-Adam.Thomson.Opensource@dm.renesas.com>,
        Mark Brown <broonie@kernel.org>,
        Wolfram Sang <wsa@the-dreams.de>
Subject: RE: [PATCH v2 1/2] mfd: da9062: enable being a
 system-power-controller
Thread-Topic: [PATCH v2 1/2] mfd: da9062: enable being a
 system-power-controller
Thread-Index: AQHYVhEXwh76FFVKcEK/P5A/Qdaum60B7szg
Date:   Tue, 26 Apr 2022 09:14:34 +0000
Message-ID: <OSAPR01MB5060E32302F81F37D17B08A2B0FB9@OSAPR01MB5060.jpnprd01.prod.outlook.com>
References: <ca76e2bb2f5d47ad189fa1a40bb6dd8a5dc225d2.1650606541.git.helmut.grohne@intenta.de>
In-Reply-To: <ca76e2bb2f5d47ad189fa1a40bb6dd8a5dc225d2.1650606541.git.helmut.grohne@intenta.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=dm.renesas.com;
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f0017b80-2ed5-4064-b18a-08da27652e3e
x-ms-traffictypediagnostic: TYAPR01MB3870:EE_
x-microsoft-antispam-prvs: <TYAPR01MB3870A2C222E3FF9EF8AE30D6C1FB9@TYAPR01MB3870.jpnprd01.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 6cMvA4+ZmaieIPoAd9qUZDcYxYF435dZ5GTN9NgrG9x0Y937fVhhnr8hC+OA/59ej9aHDBl26dDwn+bOLUvht1vU29EbehHTlNy6b83Wf4p/B88OUXtYY6WZMOAPLaqlL29m2HjqEOWfKwiE/ZJHbVoVHLkhc+RZWRNIAbZH7ClQfXz7N4WtPku+Fdcz1B4PA2VY88yM7dqsnwDPb/w8kmcnSYfKQn+oCNXFgRZo5CavAxL8kyRpcO3hqPchsSgftuEugWKSUyTzD08iZiQalwADkdD/EL0rpWU1u77JvarSBNCz8a0M9/ChKaqxNguIcX9UXUd8kUd74otxS86YAa5jbzCR5cL/sYMHq1Lm2Zf1fHarRtIJTJJ7o8wF2RAkQeERliDLX3Fg4JeAYHrjb4GDLE1YBCk/q/eRETHXQAUcXn9JE2enSPwxfyfnemrJQMYi8KBP5K8PPBTyZw8os+ySydY5hWxHUSV2R8qgU+QYxFIGBFqB8iEZwVx3CCkZtZgv0M5VZ1jLgM3TyGOp7zsDOeVR+T9Yro/HcSq4BW/gf8waKvniaoWIAzBpMSkQMM0VB4dcIQj1al3BNFrz6+ffjOjeTBNJkKgS/duXSRoS/wK4xnEM4mFSMjbWk+gLGpN80IVRIrN3Q4loIacyO1WQz4TbI/vCam7dMjS3XvPxRMJwRMb7iqkmgnotG6GNLMGKiaddfGRjGlsLfW8Pq9LFKhetVBPozTNfi+7MucVqAqvTIAbtzWHBNUmBjjXLnCjXQK+6kX0TlnmfnaAW97JozQZ/C4l7OP1Cf/4D+nY=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSAPR01MB5060.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(9686003)(7696005)(71200400001)(4326008)(66476007)(110136005)(54906003)(76116006)(2906002)(33656002)(38100700002)(122000001)(55016003)(38070700005)(6506007)(86362001)(8676002)(316002)(66556008)(53546011)(64756008)(66946007)(83380400001)(186003)(26005)(966005)(508600001)(5660300002)(66446008)(8936002)(52536014);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?T0dLWlE2OElrcUxvbXd1d3FTaTl1bkxBTzY4YzN2aUVUOXIzekpmVmNRYVF6?=
 =?utf-8?B?NGp0TlFndHgxYkp6Sk1jTnNzcFZuazFXQTFEYnoyMVRKWUdaSTdZRUtmbEFW?=
 =?utf-8?B?Rzl2WHZYS3R2OTZzSWU5VUc0SVlrTWR1UkJZWit4RVJOYXlNVWRUeXJYSkVq?=
 =?utf-8?B?STZQZ0Y1MVJuallNdlkwd0Zvejg4K3Z4TFRnYlRibzBZcVQrSnhEbE9JdGJD?=
 =?utf-8?B?dXhDdjQzdWNiQnEzb1Nwdis2WWdoNVlGaGtmYXVod3lJbFAydDVEbmY1UVln?=
 =?utf-8?B?MjZWU21LQ1ZBOGlGa3RIOWdydDUxVDdnam9CRHgwR1I4dHJ3d1lLM0NobStr?=
 =?utf-8?B?NzFUZDZjdlZjTUpQUW9PNFNEOEdlRm5MaXFGZGNtVUF4NWFrZ21ZckxrQmNC?=
 =?utf-8?B?M0dzdE5YZ0lQOHgzUU1CQXN2c0tqMUxxd0l5SUloVzZncXZkM1JhOE52dmsw?=
 =?utf-8?B?SmtVcWQvT0tSRUlCdVhXNUkwN1R6QnRTR1JmMFB4ZExJbDVLWWJiWDl0MUhP?=
 =?utf-8?B?SGlXSHc2VXJSK2FZQ0Z0NGUySHJyaW5mMy9rc0kvZmt2d0ZiWjlRK3crUlJ4?=
 =?utf-8?B?M2x1eDRSMXZpM1FielNPRFUzbWJSdHNTMDhJT2F4SHdTdEo2OG5WUVBRUEdx?=
 =?utf-8?B?S1B3NUVydFExS0NkM1dXMWhmcjdzYzZUd2JkakdSd3VFVFhnb2FOdGZFaVhY?=
 =?utf-8?B?Qzc4R1crM2RsWEp2ZnRLdEYzc1ZSNmw2bStxRzE1ZFJ3aFJtSFIrRjdtaFZQ?=
 =?utf-8?B?Y0xWcExSUEFVajFNQ1FiY1dnMnUvUEwyU2czdFJXeHhFTThPTWZGZmZ0ejdu?=
 =?utf-8?B?Z2V3WGdaSlF1N3QzRnp4NVFLc3VHUDV4VW0vNkdxUXh0WUsrbUwrY2hJSUJS?=
 =?utf-8?B?YklTRTdqL0lWbGZRSG5xSCtFWGIrZGNnREJjWGNmUFRxV0tJY0g3MlFKUWJR?=
 =?utf-8?B?VWZuVkl4WXl0cGJSOGx0SHpuL1Zod1BxYnh5YWlrTEh0ODkzeXhONjdLb0Ru?=
 =?utf-8?B?SkMxcmEzZFVIT0lIblh1UmlhdmppNWpEcFpQQmtyRlhleHpLTmR2M1BzL3Zn?=
 =?utf-8?B?RmV4SWFzSVZ5ZU9iV1F6K3BZUDJiL0RiMFlHTVBMQm94QlRGbG1vZ044WTJJ?=
 =?utf-8?B?bXowakdMTGN2M1Jrd2FvNFVnVzh4K3grUzJ4NTBTSzV3WWFpbXFzSkttSDAw?=
 =?utf-8?B?cEtSa2Fpb0kvL0Y2UE92SENDL0Y1TEE5NUVNMWhtenZ1WTZvRGtUdytBbDFj?=
 =?utf-8?B?QllHK3ROUGtnSGVaYWxNN2JXSnFiTzBJcy8wZ01LY2pSWlZ0cTd5Smw5Q0hi?=
 =?utf-8?B?MUNxZmFsS1BNQzB5c2RLTG1Eb0VvM212VWxmUkpqOUc2SDlwSXdnZVFIOXhs?=
 =?utf-8?B?VkNDNi9qMGlVbUs1UVY4RUovaWowRHpzcTdUYWY5VkFRcXJveFZWRDRiOEU1?=
 =?utf-8?B?VWtaWDBHa0VsU08vZ3dhaFZCWWhGNDFHSzgrVDducHIwWVlSU1FoektqdnBD?=
 =?utf-8?B?V1UzeUtnZUdlVGNSenA2R2JSdjVrTTl6U2h0TnJ0Z3Y5L2h5b0lzU2cyTnRE?=
 =?utf-8?B?TGVDWFE0M2tyOGF2WDJmRFZVVkdkWExYWThFeFFuT3JSTHhSWXVRblhDdndY?=
 =?utf-8?B?YU9hZmoyK0NZOU85U3JwNVV6bzF1MHRMZWJjcXNXTlMxVVZKQmlWanB2RHJJ?=
 =?utf-8?B?Slc2U1ZHYlI4Q1FoaENFenFEd0VwZ1NHYVVGNmtKR0t5Z2hwbEw4aXl2OTNX?=
 =?utf-8?B?TjZQUFJHMFJReDhvRWVLaHMxRXZkcUZrL3hMQUxpSlVURXovc2VGMTE2Q2FE?=
 =?utf-8?B?M0tlbFcxb3oxN2ZNRG9KV1dvNStENGcwd01SRW1OYUNGakpIdkpZRGJBbkNR?=
 =?utf-8?B?b0Y5YmlNKzduYTA3Yi8zTGRxSEFhZWN3VmFMcG82eDM4bk9nVDJjQys4b2lj?=
 =?utf-8?B?RXZuWENzeDZ5L2dMQ0ZlYmFnSTRaaDVkelRtSTVPN1l3QkZMcDlRbkpHWTA5?=
 =?utf-8?B?TUsyakxJRDRubFlFREhHQVNPdDllY0dnNXUwOFFOMTRCUDkrOWhuemk0R1U4?=
 =?utf-8?B?OENoUlZMTFEvS2RML3JUbzd2bVVXazJSQXVsRnVvOGRoU0IvZm03STZ3dFY1?=
 =?utf-8?B?WDEraU14czlhTG5FTDRJN3gwM0hHeVJIRC90K1NxbHNRVC8ycHlIYllYTDdQ?=
 =?utf-8?B?czNhL295L2ttaUdoVEQ5Um5aUmpGdmk4cW1TTHNTSXRvOVJPZy9kZEJpQ0RQ?=
 =?utf-8?B?eTV6M0tiWUJJRlZrMDJrUGxmVTdVRXFPN3FkOWJ6N1U3Vm1KQzFoNEd4Wm4x?=
 =?utf-8?B?WkFPR2ZBMDhJZ3h4a08vSzJiVVVCRU01VllqMFlaVjRLWW1wZHZRSTVWc1Rw?=
 =?utf-8?Q?Nj0eYP9Plytt+oXI=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: dm.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSAPR01MB5060.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f0017b80-2ed5-4064-b18a-08da27652e3e
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Apr 2022 09:14:34.7074
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cQNzKZbuEGtFfxaPsnMPA2DRPCQ2HbjmV55UMbFXEDEKQbDcJ0rck0AJJZIN1iCXCrC1kJl1bnWR4MAXBnFmw1rBgnFxnqB/dkH4r2es774=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYAPR01MB3870
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMjIgQXByaWwgMjAyMiAwNzoxNywgSGVsbXV0IEdyb2huZSB3cm90ZToNCg0KPiBUaGUgREE5
MDYyIGNhbiBiZSB0aGUgZGV2aWNlIHVzZWQgdG8gcG93ZXIgdGhlIENQVS4gSW4gdGhhdCBjYXNl
LCBpdCBjYW4NCj4gYmUgdXNlZCB0byBwb3dlciBvZmYgdGhlIHN5c3RlbS4gSW4gdGhlIENPTlRS
T0xfQSByZWdpc3RlciwgdGhlIE1fKl9FTg0KPiBiaXRzIG11c3QgYmUgemVybyBmb3IgdGhlIGNv
cnJlc3BvbmRpbmcgKl9FTiBiaXRzIHRvIGhhdmUgYW4gZWZmZWN0LiBXZQ0KPiB6ZXJvIHRoZW0g
YWxsIHRvIHR1cm4gb2ZmIHRoZSBzeXN0ZW0uDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBIZWxtdXQg
R3JvaG5lIDxoZWxtdXQuZ3JvaG5lQGludGVudGEuZGU+DQo+IC0tLQ0KPiAgZHJpdmVycy9tZmQv
ZGE5MDYyLWNvcmUuYyB8IDMxICsrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysNCj4gIDEg
ZmlsZSBjaGFuZ2VkLCAzMSBpbnNlcnRpb25zKCspDQo+IA0KPiBUaGlzIHNlcmllcyBlZmZlY3Rp
dmVseSBpcyBhIHJlYmFzZWQgcmVzZW5kLiBUaGUgZWFybGllciBwb3N0aW5nIHdhcw0KPiBodHRw
czovL2xvcmUua2VybmVsLm9yZy9hbGwvMjAyMDAxMDcxMjA1NTkuR0E3MDBAbGF1cmV0aS1kZXYv
LiBBdCB0aGF0IHRpbWUsDQo+IEFkYW0gVGhvbXNvbiBjcml0aXNpemVkIHRoZSB1c2Ugb2YgcmVn
bWFwIGFuZCBpMmMgaW5zaWRlIGEgcG1fcG93ZXJfb2ZmIGhvb2sNCj4gc2luY2UgaXJxcyBhcmUg
ZGlzYWJsZWQuIEhlIHJlYWNoZWQgb3V0IHRvIExlZSBKb25lcywgd2hvIGFza2VkIE1hcmsgQnJv
d24gYW5kDQo+IFdvbGZyYW0gU2FuZywgYnV0IG5ldmVyIGdvdCBhbnkgcmVwbHkuIEkgbm90ZWQg
dGhhdCBhIGZhaXIgbnVtYmVyIG9mIG90aGVyDQo+IGRyaXZlcnMgZG8gdXNlIHJlZ21hcCBhbmQg
aTJjIGRlc3BpdGUgdGhpcyBpc3N1ZS4gSW4gdGhlIG1lYW4gdGltZSwgbW9yZQ0KPiBpbnN0YW5j
ZXMgd2VyZSBhZGRlZDoNCj4gICogZHJpdmVycy9tZmQvYWNlci1lYy1hNTAwLmMgdXNlcyBpMmMN
Cj4gICogZHJpdmVycy9tZmQvbnR4ZWMuYyB1c2VzIGkyYw0KPiAgKiBkcml2ZXJzL21mZC9yazgw
OC5jIHVzZXMgcmVnbWFwIGFuZCBpMmMNCj4gR2l2ZW4gdGhhdCB3ZSBwcm9jZWVkZWQgd2l0aCBh
Y2NlcHRpbmcgdGhlIHVzZSBvZiBpMmMgYW5kIHJlZ21hcCBpbnNpZGUNCj4gcG1fcG93ZXJfb2Zm
IGhvb2tzLCBJIHRoaW5rIHdlIGNhbiBwcm9jZWVkIHdpdGggdGhpcyBwYXRjaCBhcyB3ZWxsLg0K
PiANCj4gSGVsbXV0DQoNCkkgc3RpbGwgaGF2ZSBjb25jZXJucywgYnV0IG1heWJlIGl0J3MgdXAg
dG8gdGhlIGludGVncmF0b3Igb2YgYSBwbGF0Zm9ybSB0bw0KZGV0ZXJtaW5lIGlmIHRoaXMgYXBw
cm9hY2ggZm9yIHBvd2Vyb2ZmIGlzIHZhbGlkIGFuZCB1c2FibGUsIGFsdGhvdWdoIEkgc3RpbGwN
CnRoaW5rIGl0IHdvdWxkIGJlIGdvb2QgdG8gaGF2ZSBjaGVja3Mgc29tZXdoZXJlIGFzIHRvIHdo
ZXRoZXIgYSBwbGF0Zm9ybSBjYW4NCmFjdHVhbGx5IHBlcmZvcm0gYXRtb2ljIEkyQyBhY2Nlc3Mg
d2hlbiBJUlFzIGFyZSBkaXNhYmxlZC4gSG93ZXZlciwgd2l0aG91dA0KZnVydGhlciBpbnNpZ2h0
IHJpZ2h0IG5vdzoNCg0KUmV2aWV3ZWQtYnk6IEFkYW0gVGhvbXNvbiA8RExHLUFkYW0uVGhvbXNv
bi5PcGVuc291cmNlQGRtLnJlbmVzYXMuY29tPg0K
