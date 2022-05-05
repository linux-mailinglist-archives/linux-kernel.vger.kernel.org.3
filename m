Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A08251C202
	for <lists+linux-kernel@lfdr.de>; Thu,  5 May 2022 16:12:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380462AbiEEOQM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 May 2022 10:16:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377567AbiEEOQH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 May 2022 10:16:07 -0400
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2108.outbound.protection.outlook.com [40.107.104.108])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D463D5A0AD;
        Thu,  5 May 2022 07:12:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LENngSBLn5+Qcq6fgH7aUygVnU+SYmleJOy5kWM2//VPpbMuDN+7dfKlF+smVa9xIBQotWAwixKUL7KCrjQChlFFUonh/jhxButecBo1HE2GwD9Sa8UbWQyDwHA10Nf/cxj0pVSPKP+vuRWWEdznRM3NAYqjAKlIS6uDrocWzWHGlbyrkfv9TVwtz+cnTND1CN4IF8KsN6/WT0q82DYGOSmhT3oy6Gnptczq1V9+gVrmMUvjnKeBGWXCqPpi5hTD/QVBj7g67p2f4dJ79u68ekPwyFNGmYvcfmy2U3SHGAfbyVCulW6BwWrXkaAM3OUZLURSClq0oUn6BpE7DtJ23g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Lm20hye1KxmbhuzWQYP7bzbnFYFAVtpHJ6tBURDSQHU=;
 b=Mkwm32SYBfdBWqpe7uLO7TKX4G4J6edg+uATDRPCV/4EwCnxKTy7iJ+Hmq4aB0jvNud+U2yYkOwKrwD+LuGndGZcc1Qy+AR9B4gVjgAvMAmFqXwAqfPY9OEk1LqLGz61y+OIGMO8IQ3OGCv/0/uuEg4VO1g0aJjMiMd1u7VFWjZGyUNcn2aXCz1AtYnnam+c17DNAReQxQcrHqZZ94uydXFBraoaBCKWHEudpbGSJ/6TqmDR+lYojlGLGPogZaGrR1EtVYRh/eIrXvFeLMr0hNUu/01FZ9cobCnTwxv/YBhglvAXYtXxr5GgGIAtw7cCdOJ2IqPwSRRqRFZ+91LIRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=leica-geosystems.com.cn; dmarc=pass action=none
 header.from=leica-geosystems.com.cn; dkim=pass
 header.d=leica-geosystems.com.cn; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=leica-geosystems.com.cn; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Lm20hye1KxmbhuzWQYP7bzbnFYFAVtpHJ6tBURDSQHU=;
 b=io7GCc4QgkJiUxr8vXCIzNOk53/fSTYGdXMS22+egQuB2riiiMNpuvdycalSp15tlsuehb7EvUTTmQN/M7q1OsKjBmE5GQD/YtHXmUe9iPtIrLzRmrk50BJaRt6XRcU8r3+d+XpzsPclUjSV9qCJtp8gfr4t+era35AwK8v9qwE=
Received: from AM9PR06MB7844.eurprd06.prod.outlook.com (2603:10a6:20b:3aa::24)
 by AM5PR0601MB2611.eurprd06.prod.outlook.com (2603:10a6:203:49::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.12; Thu, 5 May
 2022 14:12:18 +0000
Received: from AM9PR06MB7844.eurprd06.prod.outlook.com
 ([fe80::8134:c1a1:e76e:69cb]) by AM9PR06MB7844.eurprd06.prod.outlook.com
 ([fe80::8134:c1a1:e76e:69cb%9]) with mapi id 15.20.5206.027; Thu, 5 May 2022
 14:12:18 +0000
From:   LI Qingwu <qing-wu.li@leica-geosystems.com.cn>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
CC:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Tomas Melin <tomas.melin@vaisala.com>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        Rob Herring <robh@kernel.org>
Subject: RE: [PATCH V3 3/5] iio: accel: sca3300: modified to support multi
 chips
Thread-Topic: [PATCH V3 3/5] iio: accel: sca3300: modified to support multi
 chips
Thread-Index: AQHYX7v4bVOKaOhjskeAv8mb3SYOX60OxKiAgAACZbCAAALSgIABiGgA
Date:   Thu, 5 May 2022 14:12:18 +0000
Message-ID: <AM9PR06MB7844C01CA580F046FA570B43D7C29@AM9PR06MB7844.eurprd06.prod.outlook.com>
References: <20220504133612.604304-1-Qing-wu.Li@leica-geosystems.com.cn>
 <20220504133612.604304-4-Qing-wu.Li@leica-geosystems.com.cn>
 <CAHp75VeseZ2ChtbafmbgVavS4KvCvrQ4+XSRkeiJSyqr8__dSw@mail.gmail.com>
 <AM9PR06MB7844E8FE0EDF712C769271DAD7C39@AM9PR06MB7844.eurprd06.prod.outlook.com>
 <CAHp75VfEK_TXXA3NdGgjis7duHgoDo4aSOZntdO0wEGLw0sQ7g@mail.gmail.com>
In-Reply-To: <CAHp75VfEK_TXXA3NdGgjis7duHgoDo4aSOZntdO0wEGLw0sQ7g@mail.gmail.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=leica-geosystems.com.cn;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5866b854-f493-4b04-9692-08da2ea14393
x-ms-traffictypediagnostic: AM5PR0601MB2611:EE_
x-microsoft-antispam-prvs: <AM5PR0601MB2611D71DB61577CD0095FBE1D7C29@AM5PR0601MB2611.eurprd06.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: dWg8EJrr/iklO2FvxDk5fSwuFOyA52tBTlwuC1yAkYqg+DvoLwD0VwA2ry+WzXiuUOmNAwyIq9/91g7hS0QMGh44qu9tQYMu+a6rojxmFl/66r252s4U4ynMLu7PDcPb3QWT8LBBTaZbyicPqzYcoE7ZDC6Z7Lq0YrSS9cOxEtV/NW75CHaC1JVfsOxn7m3WBV/AfDPUhfAnNnPO/wfYuwXGJd/YxA7agjFYEL2/507UXDz3ItUCNL6FhfdWwVji966VRcQ37Tw89ygoDhUoajj3fSTc72bx/KvZkqHp5FSoXl8A6FtodI0GmlXSqCpMqL+JBlk5hSK7zfeglp0V85WacdoyJvAM7maLx+Pt/FixXC8k1cRs2uWdv4ZUH/ChGWMVgZirUWjMMwAkVKY57mSssy8NPeNDUSFeYxCy4gz683Tbs+hhlS4lTVdcZJXi7A/1Nt+M0iaKcPONhkPUZervbQ3ZPlagfoJE9kduAdE2h9hpf4I1nwtrW1jR9YLrHiR1P5gzwf6paL1+/TgTWb1e0/fsU9ydMVpHyYzjmCldt7GuC0zJ6qTCsaZ/IzuWGPbBOcHZjeTpeA+NPhrM9tojSEPVf0rhIRVzuAMJ5qFLFDzGb+970tLLtsM4AJA7Gspf4anWvKUxsAlgwM2XfWQLax0K6cSvn0AtC+oGlSglv354WuojzE0HmwSJY+jVF68/U9C1Gzo+3UmRcRfc7Q==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR06MB7844.eurprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(86362001)(55016003)(508600001)(6916009)(54906003)(9686003)(186003)(316002)(45080400002)(53546011)(26005)(7696005)(71200400001)(6506007)(38070700005)(122000001)(38100700002)(33656002)(2906002)(66446008)(52536014)(4326008)(76116006)(66556008)(5660300002)(8936002)(8676002)(66946007)(66476007)(64756008)(83380400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?L3BYWjNHN1NOSlg5ZGVBUTdMMTN0Q3FxcWQyd3hNbnhtQ0o4MGs4VHZ0c2xk?=
 =?utf-8?B?VmVwY3psWk9GS0xLZ3FyUnJhN0FwcDZTQS9DYm9FVVBBcUNZUTNjSkhnNC96?=
 =?utf-8?B?UHNsUURleVVob2h6bVF5TEdtYmNGTUdjWmo5TFFPQ1V3ZDhjUy9ENlB4N204?=
 =?utf-8?B?ZHM3N0drTFZQVTJqS1JFcmJYSUZmcDZEOXBNWWxGZThUTVpXN290MExCaS9V?=
 =?utf-8?B?U0tUejErc2tydXlkYmNlZFE0M0ZRRGlYbE12OUNJMVpSZEdnby9kYUQ5N3Zt?=
 =?utf-8?B?K0JMNDBVdVYvMm9OVUZ5a1lxbFREZFd3dUQwWFZmUWlMRnltV1ppWTBreFp3?=
 =?utf-8?B?aG4rYkZyKzM0WEdRcEFEQXR2M3VqZVRCeVUwMGFldE9pRGI3UVBBaG9EeWlT?=
 =?utf-8?B?NWtlU0tVM05RQ1JQMjhXV0FKQVpDSmtPM21XVGFRUlU1ZjQxYlM2TTdwdnlo?=
 =?utf-8?B?MGNWZDRFSG56MThtNXF0Zjcvd0NNRlEvaHZveWM1UGozSVZEVEd6OGh0V3BY?=
 =?utf-8?B?SzZqekpBUkFHcjczQktNc0V1c1VqeWIvdXFsbDM2NGloQkF4SkJ0WEZyUzJR?=
 =?utf-8?B?WDM2UWJtZSt5NHFyWWxNNlZneW00cTNKQ0t1dXNQODNNZDlXeEpIdFhFTmZs?=
 =?utf-8?B?Y2IrZmE5UGExMHpwemEyeWdKNnBIdUtnUkF0Y3pveEgvU3dTZFMweVBUMUJM?=
 =?utf-8?B?Y214TkI5S3JueXJXNVBidzFQeE9rYVBNMkZPcktlcjllSlRDSTkxcCs3WDJj?=
 =?utf-8?B?aVBwQ0lwUm45bGtDZ2d3N1JPU3YrMlhUZ21IaCtzVmFQdmk1NUlOTDBPSytG?=
 =?utf-8?B?ZEF6L1VNbmtTdlljZ3ZUNkRzdGU3Y2xoWDcxanU1Y01DQnpqdC9NUDExVVg4?=
 =?utf-8?B?NUZHZ0RJVWFqN0R4OGdadDJxSnJSQUFTWXZsMVVTV3UxQ21pbjh0YTEyK2E1?=
 =?utf-8?B?dzYyaG9VREsyWXhiWDNFeVhXMUNkc3Rkc0k3Yit4cUV3dDJ5QU1YTFh5ODV3?=
 =?utf-8?B?c3lSV3NIdGVtNjR2NERoMlQwTlpGTUczK3lCRDRCem5SZEVXaHVMcE4zK2sz?=
 =?utf-8?B?eG9XNmJkYUhVYWpTWUZ5SUV0OGZWUStIOTBvRFRSK0lHNmFjaFA5TzNqb2RX?=
 =?utf-8?B?WkhjVFdmdDR0b2JkNlBjTEhtWEFiUEZ5MmEyaTNWUEVKWHFPTTFzdUhXRU1R?=
 =?utf-8?B?a3AwR1RQUnovS3lFTmhFRXc3UGVQbEtra016UkV6bXRkY1RtZ1p4dWFJeXR3?=
 =?utf-8?B?empyTFp6M1pDei92RTFYR2drU050R1UxTG9FMmV3b0Z4QTFDUnIvSFhwckdj?=
 =?utf-8?B?VzBPWjF4d3VjQ3RyUE5xNGc3R29yd3BVZG85UUkvNk52WHRINGdXQ0FGSFg5?=
 =?utf-8?B?ZE5EZFo0cllOZktJaFNRNkpka1A0S2FWb1oxamJzZmNmYWZSWHBsWXBxOHNL?=
 =?utf-8?B?dXRpSE9xMjUyazNXMnNCNWhzM3pyTWI1YzRxeWFsdUgwWGpyUlI5N2VsNDJn?=
 =?utf-8?B?VHZTSlVXZVN6N1pKK1NPWVBmWVl3eXR3NEpRb1h0bnNNTlR3Lyt2Q0grY2k2?=
 =?utf-8?B?SWdnUWJua1l4a0gyV2I4SjVnT3lrK05qZnI3MXFYWS9mZ3Q1OHhRMDF6TE4w?=
 =?utf-8?B?WjVOSWF3Z2h0VFJNaGQ2YWZuTTJaZjJRQ3lJaHltait1UVFFUlRQbHBoZnpD?=
 =?utf-8?B?YkluelVlWm5iWVQzZ2p2WTJsUkRnYjJoWUFNeUxWOVllU242bU1nNERqZGlr?=
 =?utf-8?B?UVBhSGt2QzlFTVlucFVJSDJCcUtYOGZ1dHI2VXBqTEpEcXpFVzBHeVVjdUQ5?=
 =?utf-8?B?REVpZnZyc0lsSW8vRnA4d1RoNHBRK3hBOGs0R3I3ejBBZkFEbDA2c0VyNXho?=
 =?utf-8?B?UnpMaldIU2s1R0dEZkxGZWxIZmFHaHVLRE0zelFKQ1VkMm5uS1ZlQmRsWjJs?=
 =?utf-8?B?ZGxqcDRrSEp6d1JvTXkrdmxwNmRGUERsdnlKKzE2SExTSzBDczN4dFNzSTNn?=
 =?utf-8?B?Z3JSb0NrMHpodGxvVU1ZY2tkUm1XbTN1MUU0anRlUWE1S1BYT3IyaTNUbVZV?=
 =?utf-8?B?NjRoZ1BESXBIc0ZDUTk0a3NuSGcrbm8vYXdpaHd1MWcxdU9YL2VrV3hiL3U1?=
 =?utf-8?B?eHgzOUczNFBhbk04WFoyajVEM2lNQS9NSnBOTGtCWWlyNnpsb2xWM3A2azIy?=
 =?utf-8?B?NUlwbExheTF3UkcyRlpEL085UFdaSy8rcUluMFB1Wm9mNzFGM2prYXp6SXl3?=
 =?utf-8?B?N2NYTmQ1S21MNUxGZ1hJODM2VFRjMjNBZXlORlVkem9Fa0RWc2srSkhKaHhH?=
 =?utf-8?B?amxQaUphWnBaQ0YrQVROYnYwV1BmTHdOeEtwVURFUjNucEhtOW9INFB6ZzB0?=
 =?utf-8?Q?XT1axzd+CXN/lwBerJ+frLpGuzYCzyiZ6s3jL?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: leica-geosystems.com.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM9PR06MB7844.eurprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5866b854-f493-4b04-9692-08da2ea14393
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 May 2022 14:12:18.4208
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 1b16ab3e-b8f6-4fe3-9f3e-2db7fe549f6a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Wky66O408nIpy7PB1Xn+MuY6SQUzp0nMj5xgU31sYYs1ipSCMD2y5odLoWCofAoFP0UAvwI8lID44FphLeP7qOSOHj7Yz77YBBMSx/44zeNkFRLVRmj0kn9Sv0f8D4YH
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR0601MB2611
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogQW5keSBTaGV2Y2hlbmtv
IDxhbmR5LnNoZXZjaGVua29AZ21haWwuY29tPg0KPiBTZW50OiBXZWRuZXNkYXksIE1heSA0LCAy
MDIyIDEwOjM5IFBNDQo+IFRvOiBMSSBRaW5nd3UgPHFpbmctd3UubGlAbGVpY2EtZ2Vvc3lzdGVt
cy5jb20uY24+DQo+IENjOiBKb25hdGhhbiBDYW1lcm9uIDxqaWMyM0BrZXJuZWwub3JnPjsgTGFy
cy1QZXRlciBDbGF1c2VuDQo+IDxsYXJzQG1ldGFmb28uZGU+OyBSb2IgSGVycmluZyA8cm9iaCtk
dEBrZXJuZWwub3JnPjsgVG9tYXMgTWVsaW4NCj4gPHRvbWFzLm1lbGluQHZhaXNhbGEuY29tPjsg
ZGV2aWNldHJlZSA8ZGV2aWNldHJlZUB2Z2VyLmtlcm5lbC5vcmc+OyBMaW51eA0KPiBLZXJuZWwg
TWFpbGluZyBMaXN0IDxsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnPjsgbGludXgtaWlvDQo+
IDxsaW51eC1paW9Admdlci5rZXJuZWwub3JnPjsgUm9iIEhlcnJpbmcgPHJvYmhAa2VybmVsLm9y
Zz4NCj4gU3ViamVjdDogUmU6IFtQQVRDSCBWMyAzLzVdIGlpbzogYWNjZWw6IHNjYTMzMDA6IG1v
ZGlmaWVkIHRvIHN1cHBvcnQgbXVsdGkgY2hpcHMNCj4gDQo+IFRoaXMgZW1haWwgaXMgbm90IGZy
b20gSGV4YWdvbuKAmXMgT2ZmaWNlIDM2NSBpbnN0YW5jZS4gUGxlYXNlIGJlIGNhcmVmdWwgd2hp
bGUNCj4gY2xpY2tpbmcgbGlua3MsIG9wZW5pbmcgYXR0YWNobWVudHMsIG9yIHJlcGx5aW5nIHRv
IHRoaXMgZW1haWwuDQo+IA0KPiANCj4gT24gV2VkLCBNYXkgNCwgMjAyMiBhdCA0OjM1IFBNIExJ
IFFpbmd3dQ0KPiA8cWluZy13dS5saUBsZWljYS1nZW9zeXN0ZW1zLmNvbS5jbj4gd3JvdGU6DQo+
ID4gPiBGcm9tOiBBbmR5IFNoZXZjaGVua28gPGFuZHkuc2hldmNoZW5rb0BnbWFpbC5jb20+DQo+
ID4gPiBTZW50OiBXZWRuZXNkYXksIE1heSA0LCAyMDIyIDEwOjIwIFBNIE9uIFdlZCwgTWF5IDQs
IDIwMjIgYXQgMzozNiBQTQ0KPiA+ID4gTEkgUWluZ3d1IDxRaW5nLXd1LkxpQGxlaWNhLWdlb3N5
c3RlbXMuY29tLmNuPiB3cm90ZToNCj4gDQo+IC4uLg0KPiANCj4gPiA+ID4gK3N0cnVjdCBzY2Ez
MzAwX2NoaXBfaW5mbyB7DQo+ID4gPiA+ICsgICAgICAgY29uc3Qgc3RydWN0IGlpb19jaGFuX3Nw
ZWMgKmNoYW5uZWxzOw0KPiA+ID4gPiArICAgICAgIGNvbnN0IGludCAoKmFjY2VsX3NjYWxlX3Rh
YmxlKVsyXTsNCj4gPiA+ID4gKyAgICAgICBjb25zdCBpbnQgKmFjY2VsX3NjYWxlX21vZGVzX21h
cDsNCj4gPiA+ID4gKyAgICAgICBjb25zdCB1bnNpZ25lZCBsb25nICpzY2FuX21hc2tzOw0KPiA+
ID4gPiArICAgICAgIGNvbnN0IGludCAqYXZhaWxfbW9kZXNfdGFibGU7DQo+ID4gPiA+ICsgICAg
ICAgY29uc3QgaW50ICpmcmVxX21vZGVzX21hcDsNCj4gPiA+ID4gKyAgICAgICBjb25zdCBpbnQg
KmZyZXFfdGFibGU7DQo+ID4gPiA+ICsgICAgICAgY29uc3QgdTggbnVtX2FjY2VsX3NjYWxlczsN
Cj4gPiA+ID4gKyAgICAgICBjb25zdCB1OCBudW1fYXZhaWxfbW9kZXM7DQo+ID4gPiA+ICsgICAg
ICAgY29uc3QgdTggbnVtX2NoYW5uZWxzOw0KPiA+ID4gPiArICAgICAgIGNvbnN0IHU4IG51bV9m
cmVxczsNCj4gPiA+ID4gKyAgICAgICBjb25zdCB1OCBjaGlwX2lkOw0KPiA+ID4NCj4gPiA+IFdo
eSBkbyB5b3UgaGF2ZSBjb25zdCBxdWFsaWZpZXIgb24gYWxsIG1lbWJlcnM/ICBUaGUgbGFzdCBv
bmUgaXMNCj4gPiA+IHVuZGVyc3RhbmRhYmxlLCBidXQgdGhlIHJlc3QsIGVzcC4gcG9pbnRlcnMg
c2hvdWxkIGJlIGp1c3RpZmllZC4NCj4gPiBCZWNhdXNlIEkgdGhvdWdodCBpdCB3YXMgc3RhdGlj
IGFuZCBoYXMgZml4IHZhbHVlIGZvciBlYWNoIGNoaXAsIHVuYWNjZXB0YWJsZQ0KPiBmb3IgeW91
Pw0KPiANCj4gQnV0IHdoeSBjb25zdCBxdWFsaWZpZXI/IFdoYXQgaXMgdGhlIHBvaW50IG9mIGl0
IGZvciBleGFtcGxlIGZvciB1OCBtZW1iZXJzIGlmDQo+IHRoZSBlbnRpcmUgb2JqZWN0IGlzIHF1
YWxpZmllZCBhcyBjb25zdCBiZWxvdyBpbiB0aGUgc2FtZSBwYXRjaD8NCj4gDQo+IE9uIHRvcCBv
ZiB0aGF0LCBwbGVhc2UgZXhwbGFpbiB3aGF0IGluIHlvdXIgb3BpbmlvbiB0aGUgImNvbnN0IC4u
Lg0KPiAqZm9vIiBnaXZlcyB1cywgYW5kIHdoYXQgd2Ugd2lsbCBsb3NlIGlmIHdlIHJlbW92ZSB0
aGUgImNvbnN0IiBwYXJ0IG91dCBvZiB0aGVtLg0KDQpBaCwgeW91IGFyZSByaWdodCwgdGhvc2Ug
Y29uc3QgYXJlIHVubmVjZXNzYXJ5IGZvciBub25wb2ludGVyIG1lbWJlcnMuDQpmb3IgdGhlIHBv
aW50ZXJzLCB0aGUgY29udGV4dHMgdGhhdCB0aGUgcG9pbnRlciBwb2ludHMgdG8gYXJlIHN0aWxs
IHdyaXRhYmxlLg0Kd2hhdCBhYm91dCBpZiBJIHJlbW92ZSBhbGwgdGhlIGNvbnN0IGZyb20gbm9u
cG9pbnRlciBhbmQga2VlcCBpdCBmb3IgdGhlIHBvaW50ZXJzPw0KTGlrZe+8mg0KY29uc3Qgc3Ry
dWN0IGlpb19jaGFuX3NwZWMgKmNoYW5uZWxzOw0KY29uc3QgaW50ICgqYWNjZWxfc2NhbGVfdGFi
bGUpWzJdOw0KY29uc3QgaW50ICgqaW5jbGlfc2NhbGVfdGFibGUpWzJdOw0KY29uc3QgaW50ICph
Y2NlbF9zY2FsZV9tb2Rlc19tYXA7DQpjb25zdCBpbnQgKmluY2xpX3NjYWxlX21vZGVzX21hcDsN
CmNvbnN0IHVuc2lnbmVkIGxvbmcgKnNjYW5fbWFza3M7DQpjb25zdCBpbnQgKmF2YWlsX21vZGVz
X3RhYmxlOw0KY29uc3QgaW50ICpmcmVxX21vZGVzX21hcDsNCmNvbnN0IGludCAqZnJlcV90YWJs
ZTsNCmNvbnN0IGNoYXIgKm5hbWU7DQp1OCBudW1fYWNjZWxfc2NhbGVzOw0KdTggbnVtX2luY2xp
X3NjYWxlczsNCnU4IG51bV9hdmFpbF9tb2RlczsNCnU4IG51bV9jaGFubmVsczsNCnU4IG51bV9m
cmVxczsNCnU4IGNoaXBfaWQ7DQpib29sIGFuZ2xlOw0KDQoNCg0KPiANCj4gPiA+ID4gKyAgICAg
ICBjb25zdCBjaGFyICpuYW1lOw0KPiA+ID4gPiArfTsNCj4gDQo+IC0tDQo+IFdpdGggQmVzdCBS
ZWdhcmRzLA0KPiBBbmR5IFNoZXZjaGVua28NCg==
