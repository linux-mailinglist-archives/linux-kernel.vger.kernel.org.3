Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBC824B09E2
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Feb 2022 10:50:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239058AbiBJJtZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Feb 2022 04:49:25 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:36528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239020AbiBJJtM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Feb 2022 04:49:12 -0500
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2102.outbound.protection.outlook.com [40.107.215.102])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB760F2B;
        Thu, 10 Feb 2022 01:49:07 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kVbSPz6GYbXrf9vcR8pE2DWdx++KeEc54iOZrCkYsRyWDXgD9yz4n1n0YkwTq1GIvfPyxGGxXp6m8zMKh9o+JPIP7M4TsFR6/vqVstddlIRaAtWoULz2WKoNfZWYImq0gn1CNbmw6hEZi1ElGjF5cSI26dioMQBmiTPE3kFTaU4EBjzgP6edjTW4ENTopYnut1f6EuEGIvblVcE2uaOhjR5gCaFadz57b/GpHzCWCF/M5s/3PNVE0QsBcQ69i7nIcpl2P6CfHXiP66B6jSKQieX1Wxd0meGaa1As1/p5CAy6spfh7aYWMIeR6Lnnm0576WmE1fYWs9mYTQrdfZSmyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Wjenw7PPNTlniGRWGRSoxgZMQ4nszbWdGAziG157IdE=;
 b=iaQ+Z0/Qlcly485A6F+Vpc5b9MjmM5ysZRxY4QBMO1nPy2ZiLt40Nyk212J386QI3mQ16RgSj7Zz06ILljHWYR5zYv83syCZdwjvZVzlG5SzVfX2Ynpgm69qqJ81b0nXMHOk4MQsYc4Psn78Cum7RNXjKXeq7HKdKP9Kl/CwK+G0ekJ7bHpFtNB6vV1oosv2AW2S4AJte8i6QV2KbQxzP7uSFkRgQz2MYu/0+c3bNkehIBwh3/k6AwqeM2zV0y/L7kfUn5aVwrIsgEwwSomMWUJzVWejOMa55Ga8ggRyGhTJU/Qk9CynDwhTcaYDsuPF5D6YT7Y424wplXnqyW8aEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo0.onmicrosoft.com;
 s=selector2-vivo0-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Wjenw7PPNTlniGRWGRSoxgZMQ4nszbWdGAziG157IdE=;
 b=h7qPYhm3wam4FjZiHkeAnjYbnQ/tvNYejxZuRHMS7hv3Puq171x6mncrJOkBzpOI8FrmOgbOs5SeWe4dpsHYbpdHaHgzjv7VFXpAUyuo4YJ6JoX9d9i6Oauo2E/9GxVBk+Xo/VwnxIhSA95TCSugjwKDUTDZSG+fSGn1Y79GKpw=
Received: from SL2PR06MB3082.apcprd06.prod.outlook.com (2603:1096:100:37::17)
 by SG2PR06MB2729.apcprd06.prod.outlook.com (2603:1096:4:1d::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.17; Thu, 10 Feb
 2022 09:49:02 +0000
Received: from SL2PR06MB3082.apcprd06.prod.outlook.com
 ([fe80::80b4:e787:47a9:41bb]) by SL2PR06MB3082.apcprd06.prod.outlook.com
 ([fe80::80b4:e787:47a9:41bb%4]) with mapi id 15.20.4975.011; Thu, 10 Feb 2022
 09:49:01 +0000
From:   =?utf-8?B?546L5pOO?= <wangqing@vivo.com>
To:     Kieran Bingham <kieran.bingham@ideasonboard.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-media@vger.kernel.org" <linux-media@vger.kernel.org>
Subject: RE: [PATCH] media: wl128x: use time_after_eq() instead of jiffies
 judgment
Thread-Topic: [PATCH] media: wl128x: use time_after_eq() instead of jiffies
 judgment
Thread-Index: AQHYHljHfm2hX2VjskOsoS6Rqq8kYKyMh0QAgAABUDg=
Date:   Thu, 10 Feb 2022 09:49:01 +0000
Message-ID: <SL2PR06MB3082B56339A867AD4A40A409BD2F9@SL2PR06MB3082.apcprd06.prod.outlook.com>
References: <1644481960-15049-1-git-send-email-wangqing@vivo.com>
 <ADgA3gADE5Odu0AZoB0xW4rP.9.1644485925064.Hmail.wangqing@vivo.com.@PDE2NDQ0ODU5MTg1Ni4zMzU0MDY2LjYxMjMzMzM5MzQ1MDQ2NTE3NzFATW9uc3RlcnNhdXJ1cz4=>
In-Reply-To: <ADgA3gADE5Odu0AZoB0xW4rP.9.1644485925064.Hmail.wangqing@vivo.com.@PDE2NDQ0ODU5MTg1Ni4zMzU0MDY2LjYxMjMzMzM5MzQ1MDQ2NTE3NzFATW9uc3RlcnNhdXJ1cz4=>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
suggested_attachment_session_id: 88976327-726b-5b74-fd59-583f647f8272
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a22fb8f5-646a-4874-3f63-08d9ec7a9152
x-ms-traffictypediagnostic: SG2PR06MB2729:EE_
x-microsoft-antispam-prvs: <SG2PR06MB2729E25E1FD8CB96F86A7702BD2F9@SG2PR06MB2729.apcprd06.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: aCwvlkzNIibz1NzDbQgVLWucfbWG4UWJvxhs/pfQPkmpXgoMy696D8YA9u2EBS16/0DidK5zIsYnJT6oXuA8UVaMk7I1jA4drQwiDOp8j/JQiOG+/KPKvYt796qCsLinJUgGohPtVwVW+S0yCqnUiux+kTP7amtGMGe1+acjDqKF2wahP7X3e28fSuuXEycWCHPXIc6mR0B1fs6kTFrdgYo34HMP/rn05pnkrxFMkpJswjZcCjSusvNipUvsqdCS6CouIKtP8abJIUbjE/5aaMpGfiv5Hx/H66A4f4GbHV3z3plN+CZJgwDB1pvVoQ730DypWECawf2pGXjbbbSYJn0zssQ2lqt6RY6BQ/fjlNRCDneYgLvJ80WOsD3TfqU3qoUOaXDHzPSRYbF5qW903GW8tkclCFWgal1K9D5tP4W8mnvw+p8sSF6joWRBevVFYp68Fe7CgoA/VM9PzyKybPLShM4/ilW4cwhPHRIDAxGNThBcBdKQnBdONMMtLGeSUmT1NNI8f4gZSS3pMqLjq7x6VZTWLk/dV9oPXf2F6cMofqym86aXccvydy0DCRTsgSB5uIDP8Er0jjCduYv9BR4rd5fl6yIwnt+M0hIrexun7Di5TFEhtySuftDaAGx0gnwOkJgK8vXq9s8K+CWHkXpHglRKOm3uaHc3yUPhD28p9c/pU5hZ7Cc9n3pYOn50vAMhTUp79gAGgTSc7zwhNu7VMLEmGRzusTjmCkkYoZY=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SL2PR06MB3082.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(122000001)(38070700005)(33656002)(85182001)(9686003)(110136005)(6506007)(7696005)(83380400001)(76116006)(55016003)(38100700002)(2906002)(86362001)(5660300002)(316002)(508600001)(8936002)(66946007)(71200400001)(66476007)(52536014)(66556008)(64756008)(26005)(186003)(66446008)(8676002)(91956017)(21314003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?LzZpa2szOVN1Ri9LYjhVWlhiTFEzMEtWMm15cGszZTRPMUtLYU9aQjNqdi9i?=
 =?utf-8?B?REFYQlo1QmE0MHcwNlRVVnZjRmZEMUF2cXVhdEM5eDB1VFhkWDUyWlNHczJk?=
 =?utf-8?B?OUl5UzkzMlRydjQ0VVYrQjdUZVlWMkxyb3h2ZG41dXFBa2VjbGl3d09Cc1lI?=
 =?utf-8?B?NFMvUzlncVVBaE8vZzJxQTNjb2VRMEZ0ZUJtTTZyanBrU1paZHBMN0dLUHlN?=
 =?utf-8?B?SGZycnZ6blNEdzgwV3NnN0NNUkF3UkRjZThQeTdWTytyWHVCbkZGUFNIOUJ0?=
 =?utf-8?B?amw3SUkxbEhKRlFkL3pBMGZvVXM1UDM5eUxRREFrdlBHQ0owZFpNYW8ydjRI?=
 =?utf-8?B?ajJSR29pNThhSGVyaTNvUEhSNzBSbkhiYzNmWkVDRjEwcFF4WXp2bnMxZkZp?=
 =?utf-8?B?c0VTMWFGYmg2aTFUa0FMRkVjdlp6UFM1clV4aXNYbWtNYm5pSlQ5ZUZCVzdl?=
 =?utf-8?B?dTJiQ1B5anZPcjV3U3BNWVNLU1h0MDJuZm1TRm4wdE5RTFdNMlFndUpzbHhU?=
 =?utf-8?B?Q3NRRGVFdjlxTjF1RThrcFlubXlCY0sraGExUTBLS2wxVlIvZjgvVmlYQzIr?=
 =?utf-8?B?REJvZXh4TENEekVDUXhqUXI1SGE0elQ3cldYSjJSYXhUVDJ0dyt6R0h0eTFO?=
 =?utf-8?B?YnhWZ3pqQjBJajU3cXY0OVcva1pWQXZtUXNnNy9xSXgydTE1U0V4cTBYMVlL?=
 =?utf-8?B?TFVINWVDbEVHdk5UcWdtdlFqSTlIWDdFMnB4ZzA0S0ZrN1NuYnhjL0dXNHd1?=
 =?utf-8?B?bUJjcGhVazJteTl0VXljaU1RM1FLWmhzTFgxcUdOVzRiOE05bk9YblJ1Nlg4?=
 =?utf-8?B?R1M4WVhoMG5NOGYyaklCeU11Z0ZjY2JQNmNRc2ZjN0l3RkkzcCtVQ3M1eDha?=
 =?utf-8?B?NW13Z1Z3UnB6K1VGcVErU3JwRmVRRVAxU0gwcEJWZFNOeDRFdGRYSDZ3OW1I?=
 =?utf-8?B?NkxPZ0Q5czlWOUwrUElHZXF2aVhia1pHUHhmNVB0eThZdGRPOWZLR0Y1ajRE?=
 =?utf-8?B?NmZUbVFyVDRMOG80QzYwdkU4ZG96bDFXekRFd0ZWNUFsTE11RW8wMXJqUWc0?=
 =?utf-8?B?SFptbkN5UVVqcTFkUXZnM1FUdGZDNXcxUDNnVVNxTnhiTk1QOWFYeFVWM2Y4?=
 =?utf-8?B?bGNPOVdTc3V3SjY2aFFvUmR6VUl4M2w0eDZzRGZTdEg3R3pBaG5pbngxdUVk?=
 =?utf-8?B?c2lKekhnL2h1cHZBTXB0dzN6UGJ4elJLVFNOdkRlRCszTERGRGpPY0QxOGpu?=
 =?utf-8?B?UmVKQU5seFJuZVVEUzIwUlJsN09ocjNaUm50cVdMU1NXV0dWU0JBemNaR2pJ?=
 =?utf-8?B?UTFjeDN6ejFyUTZhbXpoVHdHSWVjVUVhZ3AvZ1dPRFJhbmZHK1hXcHF4WlNG?=
 =?utf-8?B?TVArTVl2cElaRDh3VU9OdHRPSDVuYnNZZXZYbzcyd2FCZlE3NmdsS2dyRjl6?=
 =?utf-8?B?dHZRcTNnUXphUjAxOW9QRlViVUIxdDVQRDROaWdoQklBNStycG5XTmExWDBa?=
 =?utf-8?B?Uk9WNlN4UE5aR0k1TzNBOFVWdmtkSVltNUdWWUQzK0VnL0pvak1yYmFwNnZi?=
 =?utf-8?B?UGdjaEFsWHVwMkRPemtuaEJtL09BS1B1NGpJVWhzNUZjM2Y1Ump2eFR6a2Ja?=
 =?utf-8?B?Tnd1Q21XcFd2dXBqaXlnUXF2RTREbTNFTWZCbElEVU41NDhXenU0aENCZW5D?=
 =?utf-8?B?Z0JyaTVNQ25XdkNNSWdwMnFza1h4b2gvNVA2aGhHUG13bnphWVlMcmNFN3hY?=
 =?utf-8?B?Qnp5ZW00VlJ0Q1hnSzBlUC9nTDgycUpBY1I1dDlVYUIxSlJJMGJ6eFplanRC?=
 =?utf-8?B?Wi84aHNYY2tCV1lhWXJRRnhWUlhmbXg4MHd1Vk8xUEMwMzVXb2ttOGhlL2RE?=
 =?utf-8?B?cnByZXZHOENMOTVqVUs1a0JjR2lXK0xWZHFLMDI1SHdNbTRvTU9jL3pTSVZ2?=
 =?utf-8?B?M1FxeTMzdHBwcUJMNythSC9jbUtDcjR5YzVQZW0rWjYreWcyemg1YWRrWGtm?=
 =?utf-8?B?TDN3MWJ5Z2JUeFN5M21PVmNqUUVLczFxeFZnTWd0bnllclJiYk9Ob1ZsTXdp?=
 =?utf-8?B?aFkxWmVJQklRVTQzclhXVUpkWFNZU0h4RmVvSkp0ZTY3aUhEczJielE0NDE5?=
 =?utf-8?B?RWs2L0ViRUNhZnJZeEtBKzROZllvZmwwOVdPSVZJdVdiRklkQlRmcW9DV3NX?=
 =?utf-8?B?Z2c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SL2PR06MB3082.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a22fb8f5-646a-4874-3f63-08d9ec7a9152
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Feb 2022 09:49:01.6637
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2OUM+EzUWTHRf9ywy8tfiCS8KP6eAsAuqnYIuLoDwymgxJB6WdVAgImt46il+Ow91VdpG/hD3rME67yCx6cpkQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SG2PR06MB2729
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Pgo+SGksCj4KPkFsbCBvZiB0aGVzZSBwYXRjaGVzIHlvdSd2ZSBqdXN0IHNlbnQgc2F5ICJVc2Ug
dGltZV9hZnRlcl9lcSgpIiBpbiB0aGUKPnN1YmplY3QsIGJ1dCBJIGhhdmVuJ3QgeWV0IHNlZW4g
YSB1c2FnZSBvZiB0aGF0Lgo+Cj5Db3VsZCB5b3UgbWFrZSB5b3VyIHBhdGNoIHN1YmplY3QgcmVm
bGVjdGl2ZSBvZiB0aGUgdHJ1ZSBjaGFuZ2VzIGluIGVhY2gKPnBhdGNoIHBsZWFzZT8KPgo+QmF0
Y2hpbmcgdGhlbSBpbiBhIHNlcmllcyBhcyBzdWdnZXN0ZWQgYnkgSm9lIHdvdWxkIGJlIGhlbHBm
dWwgdG9vLgo+CgpNeSBmYXVsdCwgSSB3aWxsIGNvcnJlY3QgYW5kIGJhdGNoIHRoZW0gaW4gYSBz
ZXJpZXMgZm9yIFYyCgo+UXVvdGluZyBRaW5nIFdhbmcgKDIwMjItMDItMTAgMDg6MzI6MzkpCj4+
IEZyb206IFdhbmcgUWluZyA8d2FuZ3FpbmdAdml2by5jb20+Cj4+IAo+PiBJdCBpcyBiZXR0ZXIg
dG8gdXNlIHRpbWVfeHh4KCkgZGlyZWN0bHkgaW5zdGVhZCBvZiBqaWZmaWVzIGp1ZGdtZW50Cj4+
IGZvciB1bmRlcnN0YW5kaW5nLgo+PiAKPj4gU2lnbmVkLW9mZi1ieTogV2FuZyBRaW5nIDx3YW5n
cWluZ0B2aXZvLmNvbT4KPj4gLS0tCj4+wqAgZHJpdmVycy9tZWRpYS9yYWRpby93bDEyOHgvZm1k
cnZfY29tbW9uLmMgfCAzICsrLQo+PsKgIDEgZmlsZSBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKyks
IDEgZGVsZXRpb24oLSkKPj4gCj4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL21lZGlhL3JhZGlvL3ds
MTI4eC9mbWRydl9jb21tb24uYyBiL2RyaXZlcnMvbWVkaWEvcmFkaW8vd2wxMjh4L2ZtZHJ2X2Nv
bW1vbi5jCj4+IGluZGV4IDYxNDI0ODRkLi5hNTk5ZDA4Cj4+IC0tLSBhL2RyaXZlcnMvbWVkaWEv
cmFkaW8vd2wxMjh4L2ZtZHJ2X2NvbW1vbi5jCj4+ICsrKyBiL2RyaXZlcnMvbWVkaWEvcmFkaW8v
d2wxMjh4L2ZtZHJ2X2NvbW1vbi5jCj4+IEBAIC0yMyw2ICsyMyw3IEBACj4+wqAgI2luY2x1ZGUg
PGxpbnV4L2Zpcm13YXJlLmg+Cj4+wqAgI2luY2x1ZGUgPGxpbnV4L21vZHVsZS5oPgo+PsKgICNp
bmNsdWRlIDxsaW51eC9ub3NwZWMuaD4KPj4gKyNpbmNsdWRlIDxsaW51eC9qaWZmaWVzLmg+Cj4+
wqAgCj4+wqAgI2luY2x1ZGUgImZtZHJ2LmgiCj4+wqAgI2luY2x1ZGUgImZtZHJ2X3Y0bDIuaCIK
Pj4gQEAgLTM0Miw3ICszNDMsNyBAQCBzdGF0aWMgdm9pZCBzZW5kX3Rhc2tsZXQoc3RydWN0IHRh
c2tsZXRfc3RydWN0ICp0KQo+PsKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHJldHVy
bjsKPj7CoCAKPj7CoMKgwqDCoMKgwqDCoMKgIC8qIENoZWNrLCBpcyB0aGVyZSBhbnkgdGltZW91
dCBoYXBwZW5lZCB0byBsYXN0IHRyYW5zbWl0dGVkIHBhY2tldCAqLwo+PiAtwqDCoMKgwqDCoMKg
IGlmICgoamlmZmllcyAtIGZtZGV2LT5sYXN0X3R4X2ppZmZpZXMpID4gRk1fRFJWX1RYX1RJTUVP
VVQpIHsKPj4gK8KgwqDCoMKgwqDCoCBpZiAodGltZV9hZnRlcihqaWZmaWVzLCBmbWRldi0+bGFz
dF90eF9qaWZmaWVzICsgRk1fRFJWX1RYX1RJTUVPVVQpKSB7Cj4KPkl0IGxvb2tzIGxpa2UgdGhl
cmUgYXJlIHNwZWNpZmljIG1hY3JvcyBmb3Igd29ya2luZyB3aXRoIGppZmZpZXMgdG9vLgo+Cj5T
aG91bGQgdGhpcyBiZSAKPsKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB0aW1lX2lzX2FmdGVyX2pp
ZmZpZXMoZm1kZXYtPmxhc3RfdHhfamlmZmllcyArIEZNX0RSVl9UWF9USU1FT1VUKSB7Cj4KPkFs
dGhvdWdoIHRoYXQgaXMgaW4gZmFjdCAyIGNoYXJhY3RlcnMgbG9uZ2VyIDstUwoKQWNjZXB0IGl0
LCB0aGFua3MKClFpbmcKPgo+Cj4tLQo+S2llcmFuCj4KPgo+PsKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgIGZtZXJyKCJUWCB0aW1lb3V0IG9jY3VycmVkXG4iKTsKPj7CoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBhdG9taWNfc2V0KCZmbWRldi0+dHhfY250LCAxKTsKPj7C
oMKgwqDCoMKgwqDCoMKgIH0KPj4gLS0gCj4+IDIuNy40Cj4+
