Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 416C7569B28
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jul 2022 09:03:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234895AbiGGHB5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jul 2022 03:01:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235131AbiGGHBj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jul 2022 03:01:39 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2054.outbound.protection.outlook.com [40.107.20.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53A9D32EF4;
        Thu,  7 Jul 2022 00:00:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d+FV5qfxmamj35Smf24uhvx8n0+LFNnckWH3AINKci5UTeOZ0dA9DyQnxMAJZf3ETOcSPsYSFjlMg1DyIrn61QQ80xVYNq4EyFQCU4msoj3A0QH3cagXKgf82JdSDlDFLmbpgHLkPTOpEkbJWB6xDsPmNZALccOJWXc5QtHwWH3nHTLfMyAuUIZZsWd2UoygpSkaS/BshHLEXxUB59SU2UnGT2/lL/9v05CdZBzhTw8toZNaEqlbiwBDCPLcYz9xp1XFFUJT2Epc3H0MwvJSYQTRXUcc4nuE8vyYefMF6bGYkWUE07kPaidsMtDH2WL4Ud24JRli/aY/Vj2c7y5brA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Fcz30QxnAHrExi4LozbWjX709gmoytW+wKPaJpNI7uA=;
 b=erOoqHprdbHHoNG6EieQg8SBRqmq9H3v3c0IJ2snTkwqSbfzSUKiSpPE+7V2ONV5pMK+3s2ftOFF2KShiSTiK7Aa811m4u6fUmu0cwsfPAN+P6YmtE+ui8bp3ZrPltdzMRDmcHWvSogCy9bD6cKz+KiRJhOgpKe9qeAeNUMkM5Fl8kVZUwjz3j61K6a8iI7r5NDA/+Ig4lJPNeII645aTvYVdjCo0bo7pFA27ZX96W2tOB4NcWKsBA1Ct3Ls9f+TmMcc0AJl1EzPlZJYajWbhAQtvL1y6RMUcchhVEpCFcAK3lm7xf+oGHa5eb36kb2+/VJ6DNgBWuK34O3UTydtlw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Fcz30QxnAHrExi4LozbWjX709gmoytW+wKPaJpNI7uA=;
 b=ciJiEkYwWpChsWz0hxwoztkS2l1P4lRxRBXU53PpwGb5AEmEGaD15MMmpQCcE1OioSAC7XA6WKku1LXXgSQYhw5Tvk/vCOB50lgA+ZGwEOTrBV2iky8Ozd/J7nhFM6YXe87GaTzfmuOaSxeDezo/fuAX/DFjhzhkfs2CnICcca2BX8DC2NGw6SghmgWiq0jRIhnaOLPWsI7is5VBkOcgilTLFkKImeiiWRPtPI11+SRSyYqhRmeriE6gY2LDKuDCQ65TT1CIC37NHw+r7VdfhmY018b0+9dhxL5HaJjm2O/wzh/Mipq9pCQP0rwZfJAkh7HeUiEf14oZogZowHC6lg==
Received: from DB9PR10MB5881.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:395::21)
 by AS8PR10MB4614.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:2ef::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.15; Thu, 7 Jul
 2022 07:00:21 +0000
Received: from DB9PR10MB5881.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8f3:281c:a9fb:16f4]) by DB9PR10MB5881.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8f3:281c:a9fb:16f4%5]) with mapi id 15.20.5417.016; Thu, 7 Jul 2022
 07:00:21 +0000
From:   "Starke, Daniel" <daniel.starke@siemens.com>
To:     Jiri Slaby <jirislaby@kernel.org>,
        "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 4/4] tty: n_gsm: fix missing corner cases in gsmld_poll()
Thread-Topic: [PATCH 4/4] tty: n_gsm: fix missing corner cases in gsmld_poll()
Thread-Index: AdiRzvl8PsH2OpxTSMGmLwMpnnFK4w==
Date:   Thu, 7 Jul 2022 07:00:21 +0000
Message-ID: <DB9PR10MB5881A05367C31A390EC3A042E0839@DB9PR10MB5881.EURPRD10.PROD.OUTLOOK.COM>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_a59b6cd5-d141-4a33-8bf1-0ca04484304f_Enabled=true;
 MSIP_Label_a59b6cd5-d141-4a33-8bf1-0ca04484304f_SetDate=2022-07-07T07:00:19Z;
 MSIP_Label_a59b6cd5-d141-4a33-8bf1-0ca04484304f_Method=Privileged;
 MSIP_Label_a59b6cd5-d141-4a33-8bf1-0ca04484304f_Name=restricted-default;
 MSIP_Label_a59b6cd5-d141-4a33-8bf1-0ca04484304f_SiteId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;
 MSIP_Label_a59b6cd5-d141-4a33-8bf1-0ca04484304f_ActionId=7a2a10cf-be41-42f4-bd2d-5e0b47d56914;
 MSIP_Label_a59b6cd5-d141-4a33-8bf1-0ca04484304f_ContentBits=0
document_confidentiality: Restricted
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 42f3ada6-86b7-4c54-5c57-08da5fe65bbc
x-ms-traffictypediagnostic: AS8PR10MB4614:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: KqckGRNwMnnZOqQ9xP4Vwbp8QavfRlO9WPy3HaGWsE9PiaRhh8ik7abniwKVp4AIjddzYv21S6wmoSy68XX625LAhVQkcO4fQOR0Y58ajjy1r0n1C98q56+c4/ON9XeVrbgNN7BijtNCCijWwH+XPRapV3YzBTu4xluSC2JK+qtagzn8QGL3bOnvm73tWsi7f/yoK1g80+uspXoKrBPtdPFbWEndmKWx3vFjxQjhxF0frC+xQp6RATjy+EliZP9PXOZ2F4kwxt0Cs535l1qYStzrBTRANbaayKgq3NNxpHh2vD+6BN48tE8FbAb/LXBg1cSUHF2/nT4tQ/Xffxs1h7hbFYyXkyzXgR+duOUVG3JbQ9eKkBXwPNBt59Vuhg3XA5NAOhQ1ukZu2NikH8XzcX+/TLDoPfGzD2LHzOmkDIDo8Rov4dJUX/CXcCqIo2+o3/I9SFuFLLXKwG5GTRmlTiZtjmIisROjZUsWFTV89w7akF7KtbDB3CRIY/qQmpgY0cd4UqKRcITTMDWT9pf/abhg4yqnc6VuSbSCcnT9mugBhLQ0uZtR4x0u8kvIOBXzPvxALaz7OWlCSK7OKi5JQVOxUHmF94z06qyZLPiK27hfX6qhNA4g+kO50A7StTcF7ZvoxtLftf0JL46CPGtPs8jRZ513/d3wjrKk+AqCcIGjOVbqdsquPNaTVvRmiyi6KhRNrHdOXj9pnAQMSq8w9QyGPmD1FjaQAGQ39U6OpEUenvpp9JRvIgFhbZXPimeauBbE+K3HJJJm9aDvagDuk8/2Bf0gvI903cUYO5S3n3D9A+JlLgR9jgWVPdk6yjRZ
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR10MB5881.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230016)(4636009)(136003)(39860400002)(346002)(396003)(376002)(366004)(26005)(66446008)(71200400001)(66476007)(8936002)(9686003)(4326008)(64756008)(76116006)(8676002)(478600001)(186003)(86362001)(316002)(5660300002)(6506007)(66556008)(52536014)(33656002)(66946007)(110136005)(7696005)(55016003)(4744005)(2906002)(55236004)(82960400001)(41300700001)(122000001)(38070700005)(38100700002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NnpuZzNnQlI3cFRsRytmazM5Q0F5Qmt1MHFHdkoycmptVFpFZ3F0L2RUM2ZF?=
 =?utf-8?B?N052LzRVcFVWRi8yWTB4UzZsZGQ2RnZBbmVHcEZBd1VPVU8yZEloMlg0dHhU?=
 =?utf-8?B?b1d2NFZ2eXc5WW51N0dSUGx0UG9OMzNRM01Oa0Mxa3ZaK2grckxuU29jbTNm?=
 =?utf-8?B?cTV2blhTaDkxVDZkcHNzVktlU3F2UWhEZ1o1Ym5PWG1CaFdZSnpkRU14UDU2?=
 =?utf-8?B?ZU5oanJTSlh6K3loV3BvRFIvL0l3OHp3bGtJbFVUT1F5YS9kcFhDbzhkaVpp?=
 =?utf-8?B?YW1Nd0xoMlpKRkd2V2RLRWVvMkI4MjY2dVkxVDIzRm1uLzBVajVnRFZoUTEv?=
 =?utf-8?B?cGRKdnYrb0R6cFMrZzgvVUZ1dExTU3l3dHRVUWNJYmtydElyeitJODFRdEhW?=
 =?utf-8?B?R3pjRlhiTmFxZXNEWFNsWE91Ymxla1Fjb01lenhQMjl2OEl1clp2NGVTRDIv?=
 =?utf-8?B?ZVBrcXh1Z2RtZVV1b1czalBOUXpSZlZYUTZhQVZ1WWJ2QlVaVVpodzJkUlRv?=
 =?utf-8?B?SHRnUjBWbHphM1V3b3F5MkxNMGlHc0E0dEhmaTFJTWdYaEQ1b2VDVkF5NzE0?=
 =?utf-8?B?VG5yOTZOU0laWjM2MllMak9zYTJsdWZRZnlwNllRM082Nmg3U0dRNUlCZFlp?=
 =?utf-8?B?ZjBsSE41MmpUbkhOZWY4ckorYXJEdG93MkZsMUF2bnhQbW9WU3NRZlZZNG0z?=
 =?utf-8?B?aEpidlJzTnMvTll0ZDYvUmpBaEY4SERYNmVxR0g4R056cGs5WU04S2Zua3ZO?=
 =?utf-8?B?eGVVQmw4N0xBME5GNVU0QWhZb0hsZExJSDZONVF4N1E1a2VTbTJyUFZMc3hS?=
 =?utf-8?B?K2lFbStxQVNDU1h1WUN6RmRTS0JLYnJKMFhDK1I4L0pzNUhwL3lKNmgxdDd0?=
 =?utf-8?B?eTN3ZDB2eWcxTGlsUTlFTW4wSk9WTzBxd1pIaE5KVWpZNHZINXEyUEJSVnBt?=
 =?utf-8?B?K3RVRUJHR2dORjc1c1QvaUpuQzBoOTZQbmk3bldwZWVDUmxES2JEdTVhMDRT?=
 =?utf-8?B?b3AzYW0yK1YvR1VscExuTnBmdlkzMVdxM1JVckxCb1QxRndYK1lPK1pPT2JC?=
 =?utf-8?B?UkpDamtsby9VaVVoNWpoQ1BwZlpQNlIxZVlVMzZIQWJEV1RLcWd3L2FTcHN1?=
 =?utf-8?B?K3VTQ1NIK0pIYVpDSHo5eFNYcXNvTE93ZW9VV3JBSGFuZS9nOGNGdm1DaHNV?=
 =?utf-8?B?dU9sRER1bCt6VG4vK2FYWnBvRWxOcWFCMnFQdzlUVWdGT0Z1NElFS1pKbE41?=
 =?utf-8?B?cVIxRzRoZlMzc3c2TkNVV3owTm9RUUZWWTJIVG1lK0tMRGIrUUJzZ2paZEZp?=
 =?utf-8?B?TWxkRWFrcy81MzBaalZEUnRnaTRDRjZuT2I4aFY0emh5VXpNTksrbXNQWS9S?=
 =?utf-8?B?NmROQTRoWTBtb2dJTkMyRUFDYlg0Ymt3c2hiQTM4TnBUVUZzd21LUXVPSEk5?=
 =?utf-8?B?c2doa2FOeElRWWx0czZWZXcxSmdqS0dKOWVtYmNseHpwdnd2Zmh4L2w1VkNo?=
 =?utf-8?B?eDFGaitUVGhwVFpFMERKd0l2QnVYVFdYd2ZQeHpLOCt2cFgvNkFmWnBUOS8x?=
 =?utf-8?B?Q0xzeG84enRUSHhWRnJlZnJjQUpsdDVWUmVWUzNrS3BrVk1nL254bTMrWXZI?=
 =?utf-8?B?M0krMjMvekgydmpYanc1YlBudWR5cENobnpuM0VDM1o3M0REK1N2L3FhV0wz?=
 =?utf-8?B?Um1iVm5xczBHbWhZSk56L1ZOdndwWTFMSEsrWGcxdmUvN3lnMkl4MXdDdkxm?=
 =?utf-8?B?S2k3UDQ3ZGRRQnpSVHc4QTh5ZmhlUUlWZEorWUdYTVhMcGVYbSsxU1A1VE9L?=
 =?utf-8?B?WmNHaDVlQkJCTVJ1SmJ4VHEwSnk3aWxad2EyZGlWcUd2STFEQklicnd3YlZm?=
 =?utf-8?B?ZUI0WGlPTEpvMHUwZXBNYjVudE90ajRhaDlaREhpdFNKL3FTVWRrUTMxeWt0?=
 =?utf-8?B?SU42M2FieUtKekIySHVzZzhwOURHaVo5VnpIOURXUkVaM0JKb000dnVaYWo4?=
 =?utf-8?B?MHRwY2dvN29ON25sYUExT3RHc2p5NkVEVmplK2NDZnV6U3ZvRXl3ZkpaeDc1?=
 =?utf-8?B?bjdvV1YvcTd5NThZdjl6cXFIR0d6M3JnQ0Z3dFFMajQ1VGR4cVlZeEMvWUZl?=
 =?utf-8?Q?wKzrNiB43Cvg7j3N+YyPSDwVi?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB9PR10MB5881.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 42f3ada6-86b7-4c54-5c57-08da5fe65bbc
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jul 2022 07:00:21.2378
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YVlc2tTozYyksPktBnmWkg3OX3XsKCZcgUKtzBRxeKzQlUqYHikAGbI74g1XJuqA00NNdEwprdUEnctEUir6TFbtsL0kkzFkp6bo4xxdxvU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR10MB4614
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiA+IEBAIC0zMDUxLDE0ICszMDUxLDIwIEBAIHN0YXRpYyBfX3BvbGxfdCBnc21sZF9wb2xsKHN0
cnVjdCB0dHlfc3RydWN0ICp0dHksIHN0cnVjdCBmaWxlICpmaWxlLA0KPiA+ICAgCV9fcG9sbF90
IG1hc2sgPSAwOw0KPiA+ICAgCXN0cnVjdCBnc21fbXV4ICpnc20gPSB0dHktPmRpc2NfZGF0YTsN
Cj4gPiAgIA0KPiA+ICsJaWYgKCFnc20pDQo+ID4gKwkJcmV0dXJuIEVQT0xMSFVQOw0KPiANCj4g
SG1tLCBob3cgY2FuIHRoaXMgaGFwcGVuPyBJdCdzIGEgdHR5IGJ1ZyBpZiBpdCBjYWxscyBsZCBv
cHMgYWZ0ZXIgTlVMTGluZw0KPiBkaXNjX2RhdGEuDQoNCkkgY2FuIHJlbW92ZSB0aGlzIGNoZWNr
IGlmIGl0IGlzIHJlZHVuZGFudC4gU2hvdWxkIEk/DQoNCkJlc3QgcmVnYXJkcywNCkRhbmllbCBT
dGFya2UNCg==
