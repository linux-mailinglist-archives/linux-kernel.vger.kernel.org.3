Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 519B74E91E5
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Mar 2022 11:50:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239487AbiC1Jv4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Mar 2022 05:51:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238391AbiC1Jvx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Mar 2022 05:51:53 -0400
Received: from esa.hc3962-90.iphmx.com (esa.hc3962-90.iphmx.com [216.71.140.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D7CF517D8;
        Mon, 28 Mar 2022 02:50:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=qti.qualcomm.com; i=@qti.qualcomm.com; q=dns/txt;
  s=qccesdkim1; t=1648461013; x=1649065813;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=rYXC/FK8jh9LuO/brDKQpq2M693SOZ4oMXJbXXWk5ug=;
  b=tDuyb2Ytyho+ie3FFLulpr+uQ/bSUzGENAetQ/Tdgjj3VGTCOfrSfpZK
   c46UV9ucuYyY7j5xo+dDSfGYella9nlvjLLTCIIm8dekeKbZGNjkADSmt
   XKLF/m8CSbsxtdXWl7i8iHDAAgNq++wZqjQdSAjpf4ho56hcbJakeM0fU
   c=;
Received: from mail-bn7nam10lp2100.outbound.protection.outlook.com (HELO NAM10-BN7-obe.outbound.protection.outlook.com) ([104.47.70.100])
  by ob1.hc3962-90.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Mar 2022 09:50:10 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A2SRI+uhJrroxfhzkBDeSn44NLrDB8xcfDTQcf7h+KFm6q6zA/jg97XwmJlitD9/zXOdieMG8Rt+3CrFAvfuboxEbRndleisRfFgJ0zHgGT68ike+f93nL92JwlwMe7QwJXQmb3KUDe+ZhOvQsXnb6Tli354MV2dJ1YZpkUgkf23I2p8EWOkomPCipMr9FFC6SxVXPhyK4Q2OOAIE1KConNSUE2XFCHs73EwPB7sWDCUYKUlE6iyrFJB0Lrkioc+k1ZKecvopLw3AXdKN9bHjLieXPwfY/LxeprAaw1iQQwJK7Ap7NRfPLBw8n2bMaQzuhiyNAHjpzhWwHlKBfCJiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rYXC/FK8jh9LuO/brDKQpq2M693SOZ4oMXJbXXWk5ug=;
 b=hWNhnT0DiulCTyrwxfJxsNjIHgUc0+BspdmLMafmzwvciysxIoF23sQkix58v5234dV1H5eirsBG6deKjb0yZeTueYf3ap1zlh/y2c+SFzG7kHOnhQ0W43Q3gOsuRId3GTUyMKPDpO5nGTrX9eaZSnvNUC7cPfYl09cBqeEfWwMt0dFU0QTGuxUPESjRLo4xGbOd7gvpEdo/v6YFc28cilei2/TrPMUQmm6DExpKSdgDmH5f/Orhn72SioDn23CpUCCaUiySBpg/nBRHgi0ufKb18qJUIycC0AYkZI3Z1BYrmQHpmE3BFdeypwLbJ7I1CKIQpyBPolmRsm4Feqvy/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=qti.qualcomm.com; dmarc=pass action=none
 header.from=qti.qualcomm.com; dkim=pass header.d=qti.qualcomm.com; arc=none
Received: from BL0PR02MB4564.namprd02.prod.outlook.com (2603:10b6:208:4d::13)
 by MWHPR0201MB3546.namprd02.prod.outlook.com (2603:10b6:301:76::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.22; Mon, 28 Mar
 2022 09:50:03 +0000
Received: from BL0PR02MB4564.namprd02.prod.outlook.com
 ([fe80::9c32:a1d2:b88b:466d]) by BL0PR02MB4564.namprd02.prod.outlook.com
 ([fe80::9c32:a1d2:b88b:466d%6]) with mapi id 15.20.5102.023; Mon, 28 Mar 2022
 09:50:03 +0000
From:   "Vijaya Krishna Nivarthi (Temp)" <vnivarth@qti.qualcomm.com>
To:     Doug Anderson <dianders@chromium.org>,
        "Vijaya Krishna Nivarthi (Temp) (QUIC)" <quic_vnivarth@quicinc.com>
CC:     Andy Gross <agross@kernel.org>,
        "bjorn.andersson@linaro.org" <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        quic_msavaliy <quic_msavaliy@quicinc.com>
Subject: RE: [PATCH V2] arm64: dts: qcom: sc7280-idp: Configure cts sleep
 pinctrl to bias-bus-hold
Thread-Topic: [PATCH V2] arm64: dts: qcom: sc7280-idp: Configure cts sleep
 pinctrl to bias-bus-hold
Thread-Index: AQHYQFGBY8WdfMmg2kGrTD3pXPuGDKzQLLQAgARhLHA=
Date:   Mon, 28 Mar 2022 09:50:03 +0000
Message-ID: <BL0PR02MB4564B8AEF61404D16771699CFA1D9@BL0PR02MB4564.namprd02.prod.outlook.com>
References: <1648217145-725-1-git-send-email-quic_vnivarth@quicinc.com>
 <CAD=FV=X2mF45Fsi+2eSRPfUKa9LCmYSkv8E586aGxPTxC0JsWw@mail.gmail.com>
In-Reply-To: <CAD=FV=X2mF45Fsi+2eSRPfUKa9LCmYSkv8E586aGxPTxC0JsWw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=qti.qualcomm.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a09d3c2b-ebf4-4a10-766a-08da10a0553e
x-ms-traffictypediagnostic: MWHPR0201MB3546:EE_
x-ld-processed: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d,ExtAddr
x-microsoft-antispam-prvs: <MWHPR0201MB35468D64E8CAD55B8975AE6EFA1D9@MWHPR0201MB3546.namprd02.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: oIwfQxocpg4Iy5Q0zqBPwBsKCnfjZojtxIgJeD+PD2P/5V6tI8bz78wabPSMuEF3WSjeEuZhZooQNPyAWLwVEVB7KDd2GH5SlmW9w5Tk7Uf8IQsvIG0/4nvzY5kfMMFV69Oe70Valpq6krpnVP2tALaubr88Zmj+b/jvQ5yM3sTKi+ygeUvZdqGBc1EkHV+KAxeYsSi7Wp9seLIKz0H2veagNYC16fjVcCSqkvd3sdfGiwOHZMJGaTCbDkIqtqJNvPWAo2khWM3FumFWQQdKk+CfWTsULP62UOA0KqlHtJGUgUySe9HrUJkVlv7Zo7E8NAnWmLrh1z5B/ksrpVONFFP/ETKOFeGaaewB0t5UJ4V0I87zuyi8nDxcg3OgqeD+Br1kdRaDWMFKTBYbYEjY4xm3pYgObA7nLbN0CO4CCLmAgdsXb9PCnxsFjANq61omhFKwsUztBKxovw8jIr3ztAhmuzlkzeRDp0mDOGadpYbeMjteVOKXucT2k5PAmDbk1i+zJEw7QOvrVZJiSlwhKTV/Sn3J6ywuqMRGKPd7NyznyAkE8KJ8kLJ4by6qq/iBv6fZUEgPWPlOPiMjsd41TeaSuCswIQCoVjZuM7ivYNSfPNdHXK7w71vanDMM+fpstCJtOo0zOpxQP4mpQFn8Ek2me6UTOBeD8aNga/W0WwfaEWaRjpHjGOjVEfXLgB7vD2i3MOWykUNKukWRRvM6rg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR02MB4564.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(6506007)(7696005)(9686003)(33656002)(71200400001)(107886003)(83380400001)(316002)(54906003)(110136005)(508600001)(55016003)(53546011)(2906002)(122000001)(5660300002)(66556008)(86362001)(76116006)(38100700002)(66446008)(26005)(186003)(66476007)(64756008)(8676002)(52536014)(66946007)(38070700005)(4326008)(8936002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZE55Ty8zOXdJOUdaMXVGZWhvdjZuY1JPTXpCWi8xejJLYXZJcUxFRS9mSWJ3?=
 =?utf-8?B?bnc5SGlxOXB4TDlSeUh1aU1XSG5ocHd0QkY5SURpQUt4VEUvS0Iyc2dLaEpF?=
 =?utf-8?B?aFhHZnV1UjF0UmxmVXVGc2ZvZXlLdnRuaDQyT0wrbHlzd0hqbnNuNDdsOE5k?=
 =?utf-8?B?NG05Y1ZuN1F5Z0g3YXdpcnArR2dJWjhPZjRJZ0w0N1VzWTJoK3AwMWsxQjVN?=
 =?utf-8?B?NERTcnl4UjcxellQNHk1ZEc0R2h0RERBRjJrVlY4THhuYWwwb0NnZ1FqK2x3?=
 =?utf-8?B?V3NMRjVEZm8vZ1RQUXNhTjdmNUNRbUlBY1FjYWJVWGhKRVdSdVBYaHN3dUpa?=
 =?utf-8?B?b3JpYkE2bHEwckllUmdOamZDaEI2dEFJNzlFSDJpWHRSWk1LdTlsaVA3aWRG?=
 =?utf-8?B?TWlEbzE4VE9VT0s4N1R4QjRuZnI0a0wvYjZwRnNxaVNnZkZ1d2l4QTFvaDhk?=
 =?utf-8?B?aklEUUNXN2R6VENZdUpiZlZCeHpJQ1BBL0NLSTAybkplZnhTUDhydzN0bk5G?=
 =?utf-8?B?cnp0bCtOWWNsSCtldWcyUGc0dFh0MklEV0VlQWJhNWltd1JKaEVLYjB2Uk5T?=
 =?utf-8?B?b1hnR0VYQkpxcU1PUnMzR0NHQ1ErK0pVbG1yWHhqY1dSWEhVSUt1MDczTHU2?=
 =?utf-8?B?TFpZOFpGMmZtYS9XVmc2ZmRsUWNmanJuekhYTEFrSE96RVZjQ1VTeU40aEZL?=
 =?utf-8?B?dTMwL2Rpa2lWdWFJdjRmRzIrazRrcWVscm96NXNBUFZaZlBXRUdOdGlJL3FK?=
 =?utf-8?B?Qng5VEpnaDlRL2FOUFdKcE9rUTZoOU5wanBoT3NkYTc0ektES3Nnejg2ZzNl?=
 =?utf-8?B?VkNzamxLeENmWlNYMm9jWWxtdmQ3RU9WMVdFR2FuK1QzRjFQZVlNTmlxNnZR?=
 =?utf-8?B?aUtQQmEwQ2NWV0ZidldsUGxUWHEzQWNoa1BmV1E3Y0pMeDNKRWdnbUxubFdM?=
 =?utf-8?B?K3FKa2h3QTg1OHFwZVhTSnA1WTZqUFlDSERWd2MwNWtrNldBcnVxSGRJeG0x?=
 =?utf-8?B?Qk1XZVN1MEh3NFRzbEY2ejR3ajNzOS9Kc3B4cTd3aW0rUGs4MVVoaFJBUVdR?=
 =?utf-8?B?T05qTDhsMGROM3VrbTRWSUdCTU1scXp3RStUa285eXdBYm5vUFRYL2hPMEo2?=
 =?utf-8?B?VVdscjdrOEVBRkhVaUlzRTh0SWEzUHBTQ2dkdWJEU0JUWTA3VFdQV1RBYXFD?=
 =?utf-8?B?aVVQa3E3aTQxN2pwSlFXYUF3RGlaeGhiRDNBOFpJMXVUcUdKcTJVN3RCVE9H?=
 =?utf-8?B?dzZxejhPTDJ4VE94L2VZVHh2ZWV1K2tMTHkrdW14Nm83MFZ3WUM5RmJCYzVC?=
 =?utf-8?B?YVVWSDJGZjN5dFp4NXMvNlJNVVZrSWVDT3JWLytKSktCNG1FRlMxcVZ5WHFr?=
 =?utf-8?B?V0NubGk5MGRkOERURG50WnRWQWZMOUZQdE1iVXc0TUs4RXd2MS9hbUVBSHBM?=
 =?utf-8?B?dmZGVnFaRmFOZmpUQURYNjRqUHVkUHJqc0J3eHU4S2FJSHlUbDJPM0syV0M3?=
 =?utf-8?B?R04xaStRQjdYS2hNdmwvZ2FpWk5PMmtjdVV1dklrbEZyZFNHc1F5VVVqcWpk?=
 =?utf-8?B?TFJIcFNTa3Z5NVowVWk5SEJWMVFJOFRNa1MvWWpaQVd5UEFGNTg3cVNWbDVD?=
 =?utf-8?B?S2Z5eXZKZmVienVnVVFLUVZWVERrNDlIdWlSMHMvb2MwZTFKd0k2TnE5QzdK?=
 =?utf-8?B?Skl4dnYvSHRKS3QrTlJNWmFsR0QxVjdHSWFFV1I4c0lIRUR6K0U4NG9aZktj?=
 =?utf-8?B?dmJna0hrVFQxWDhZbUhGQ3VFa1pQOUVxaloxVXZqdVFIR2NnaHNhRVFFekEz?=
 =?utf-8?B?MDhXME04R0VmdytDNE9BdzZNK2Q1eUxvaThHSFNJUDh1Y3NQQjVkYWlzcVNv?=
 =?utf-8?B?TTBjWDhYTUlMVlNKb1FnRlNaVElIMU5IR3orN1VaaFFBRXY3dm5jY2xVRmZx?=
 =?utf-8?B?NGprSHFXVkNnS003all1VGFobUJMdXIrUllqMFhXdkVXSGViTERJSjlxeEho?=
 =?utf-8?B?RGljN2prVk1yVmk4T2FQdGdBbTZZN29VK3BtWFBScjhQL2dCTGNBSUpNMnVv?=
 =?utf-8?B?S3ZkOUtCU2p4QzE0aU9WUlJxWVhkZG42ZDJTbHFGSWg2dDMxdHF3ZitYWSt2?=
 =?utf-8?B?aHk4V0JZa296dCs2VGFwNmZoWUZOZUozQ09LYlA0TytYdFpBKzF1YXFNZlcr?=
 =?utf-8?B?SW9EcnZqdnVOcHJIQ0VYQmFVZVdIbDh5NlNOM0MyS2xqZmVVRThxdzB6Qm9o?=
 =?utf-8?B?Mm5wNzNCcWJQVlBLTWgzb29idW9xaFhaL2hNNzJmK0t1dHE4UEJVcHRBNzhC?=
 =?utf-8?B?ZFNhbVpVN09nNU9aN3FvNjIrbmVmeW0vRU9hNThzRnJKMEJwOG5GZ3N6amRQ?=
 =?utf-8?Q?0jAMCv8xY8suJwnw=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: qti.qualcomm.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL0PR02MB4564.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a09d3c2b-ebf4-4a10-766a-08da10a0553e
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Mar 2022 09:50:03.6065
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: J+AKSM0A/EzE0cG8/Um85DgiLxnbu7/t/tZZ/F4NTr208k4rBrWY4Ik5fASqYXY//oWbVYxXt8F5OrtZTXnBe/3xuDrYwTY062v0j/JC4LM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR0201MB3546
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

VGhhbmsgeW91IHZlcnkgbXVjaC4NCg0KU28sIHdlIHVuZGVyc3RhbmQgd2UgY291bGQgY29uZmln
dXJlIGJvdGggZGVmYXVsdCBhbmQgc2xlZXAgc3RhdGVzIG9mIGN0cyBwaW4gdG8gYmlhcy1idXMt
aG9sZC4NCldlIHdpbGwgdGVzdCB0aGlzIGNoYW5nZSBmb3IgcG93ZXIgaW1wYWN0IG9uIHNjNzI4
MCBhbmQgcG9zdCBhbiB1cGRhdGUuDQpGb3Igc2M3MTgwLCB3ZSB3aWxsIGNoZWNrIGFuZCBnZXQg
YmFjay4NCg0KDQotLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KRnJvbTogRG91ZyBBbmRlcnNv
biA8ZGlhbmRlcnNAY2hyb21pdW0ub3JnPiANClNlbnQ6IEZyaWRheSwgTWFyY2ggMjUsIDIwMjIg
ODoxMyBQTQ0KVG86IFZpamF5YSBLcmlzaG5hIE5pdmFydGhpIChUZW1wKSAoUVVJQykgPHF1aWNf
dm5pdmFydGhAcXVpY2luYy5jb20+DQpDYzogQW5keSBHcm9zcyA8YWdyb3NzQGtlcm5lbC5vcmc+
OyBiam9ybi5hbmRlcnNzb25AbGluYXJvLm9yZzsgUm9iIEhlcnJpbmcgPHJvYmgrZHRAa2VybmVs
Lm9yZz47IGxpbnV4LWFybS1tc20gPGxpbnV4LWFybS1tc21Admdlci5rZXJuZWwub3JnPjsgb3Bl
biBsaXN0Ok9QRU4gRklSTVdBUkUgQU5EIEZMQVRURU5FRCBERVZJQ0UgVFJFRSBCSU5ESU5HUyA8
ZGV2aWNldHJlZUB2Z2VyLmtlcm5lbC5vcmc+OyBMS01MIDxsaW51eC1rZXJuZWxAdmdlci5rZXJu
ZWwub3JnPjsgcXVpY19tc2F2YWxpeSA8cXVpY19tc2F2YWxpeUBxdWljaW5jLmNvbT4NClN1Ympl
Y3Q6IFJlOiBbUEFUQ0ggVjJdIGFybTY0OiBkdHM6IHFjb206IHNjNzI4MC1pZHA6IENvbmZpZ3Vy
ZSBjdHMgc2xlZXAgcGluY3RybCB0byBiaWFzLWJ1cy1ob2xkDQoNCldBUk5JTkc6IFRoaXMgZW1h
aWwgb3JpZ2luYXRlZCBmcm9tIG91dHNpZGUgb2YgUXVhbGNvbW0uIFBsZWFzZSBiZSB3YXJ5IG9m
IGFueSBsaW5rcyBvciBhdHRhY2htZW50cywgYW5kIGRvIG5vdCBlbmFibGUgbWFjcm9zLg0KDQpI
aSwNCg0KT24gRnJpLCBNYXIgMjUsIDIwMjIgYXQgNzowNiBBTSBWaWpheWEgS3Jpc2huYSBOaXZh
cnRoaSA8cXVpY192bml2YXJ0aEBxdWljaW5jLmNvbT4gd3JvdGU6DQo+DQo+IFdMQU4gcmFpbCB3
YXMgbGVha2luZyBwb3dlciBkdXJpbmcgUkJTQy9zbGVlcCBldmVuIGFmdGVyIHR1cm5pbmcgQlQg
b2ZmLg0KPiBDaGFuZ2Ugc2xlZXAgcGluY3RybCBjb25maWd1cmF0aW9uIHRvIGhhbmRsZSBzYW1l
Lg0KPg0KPiBTaWduZWQtb2ZmLWJ5OiBWaWpheWEgS3Jpc2huYSBOaXZhcnRoaSA8cXVpY192bml2
YXJ0aEBxdWljaW5jLmNvbT4NCj4gLS0tDQo+IHYyOiB1c2VkIGJpYXMtYnVzLWhvbGQgYXMgcGVy
IHJldmlldyBjb21tZW50cw0KPiB2MTogaW50aWFsIHBhdGNoIHVzZWQgYmlhcy1kaXNhYmxlDQo+
IC0tLQ0KPiAgYXJjaC9hcm02NC9ib290L2R0cy9xY29tL3NjNzI4MC1pZHAuZHRzaSB8IDYgKysr
LS0tDQo+ICAxIGZpbGUgY2hhbmdlZCwgMyBpbnNlcnRpb25zKCspLCAzIGRlbGV0aW9ucygtKQ0K
DQpObyBvYmplY3Rpb25zIGZyb20gbWUgbm93LiAuLi5idXQgd2Ugc2hvdWxkIHByb2JhYmx5IGJl
IGNoYW5naW5nIF9hbGxfIG9mIHRoZW0/IC4uLmFuZCBieSAiYWxsIiBJIG1lYW4gX2JvdGhfIHRo
ZSBzbGVlcCBhbmQgd2FrZSBzdGF0ZSBvZiB0aGUgcGlucyBhbmQgdGhpcyBjb25maWcgYWNyb3Nz
IGFsbCB0aGUgZGV2aWNlcy4gSW4gdGhlIHZlcnkgbGVhc3QgYWxsIHRoZQ0Kc2M3MjgwIG9uZXMs
IGJ1dCBtYXliZSBldmVuIHRoZSBzYzcxODAgb25lcy4NCg0KJCBnaXQgZ3JlcCAiQ29uZmlndXJl
IGEgcHVsbC1kb3duIG9uIENUUyIgLS0gYXJjaC9hcm02NC9ib290L2R0cw0KYXJjaC9hcm02NC9i
b290L2R0cy9xY29tL3NjNzE4MC1pZHAuZHRzOiAgICAgICAgICAgICAgICAgKiBDb25maWd1cmUg
YQ0KcHVsbC1kb3duIG9uIENUUyB0byBtYXRjaCB0aGUgcHVsbCBvZg0KYXJjaC9hcm02NC9ib290
L2R0cy9xY29tL3NjNzE4MC1pZHAuZHRzOiAgICAgICAgICAgICAgICAgICAgICAgICAqDQpDb25m
aWd1cmUgYSBwdWxsLWRvd24gb24gQ1RTIHRvIG1hdGNoIHRoZSBwdWxsIG9mDQphcmNoL2FybTY0
L2Jvb3QvZHRzL3Fjb20vc2M3MTgwLXRyb2dkb3IuZHRzaTogICAgICAgICAgICAqIENvbmZpZ3Vy
ZSBhDQpwdWxsLWRvd24gb24gQ1RTIHRvIG1hdGNoIHRoZSBwdWxsIG9mDQphcmNoL2FybTY0L2Jv
b3QvZHRzL3Fjb20vc2M3MTgwLXRyb2dkb3IuZHRzaTogICAgICAgICAgICAgICAgICAgICoNCkNv
bmZpZ3VyZSBhIHB1bGwtZG93biBvbiBDVFMgdG8gbWF0Y2ggdGhlIHB1bGwgb2YNCmFyY2gvYXJt
NjQvYm9vdC9kdHMvcWNvbS9zYzcyODAtaGVyb2JyaW5lLWhlcm9icmluZS1yMC5kdHM6ICAgICAg
Kg0KQ29uZmlndXJlIGEgcHVsbC1kb3duIG9uIENUUyB0byBtYXRjaCB0aGUgcHVsbCBvZg0KYXJj
aC9hcm02NC9ib290L2R0cy9xY29tL3NjNzI4MC1oZXJvYnJpbmUtaGVyb2JyaW5lLXIwLmR0czoN
CiAgKiBDb25maWd1cmUgYSBwdWxsLWRvd24gb24gQ1RTIHRvIG1hdGNoIHRoZSBwdWxsIG9mDQph
cmNoL2FybTY0L2Jvb3QvZHRzL3Fjb20vc2M3MjgwLWlkcC5kdHNpOiAgICAgICAgKiBDb25maWd1
cmUgYQ0KcHVsbC1kb3duIG9uIENUUyB0byBtYXRjaCB0aGUgcHVsbCBvZg0KYXJjaC9hcm02NC9i
b290L2R0cy9xY29tL3NjNzI4MC1pZHAuZHRzaTogICAgICAgICAgICAgICAgKiBDb25maWd1cmUg
YQ0KcHVsbC1kb3duIG9uIENUUyB0byBtYXRjaCB0aGUgcHVsbCBvZg0KYXJjaC9hcm02NC9ib290
L2R0cy9xY29tL3NjNzI4MC1xY2FyZC5kdHNpOiAgICAgLyogQ29uZmlndXJlIGENCnB1bGwtZG93
biBvbiBDVFMgdG8gbWF0Y2ggdGhlIHB1bGwgb2YgdGhlIEJsdWV0b290aCBtb2R1bGUuICovDQph
cmNoL2FybTY0L2Jvb3QvZHRzL3Fjb20vc2M3MjgwLXFjYXJkLmR0c2k6ICAgICAgICAgICAgICAq
IENvbmZpZ3VyZSBhDQpwdWxsLWRvd24gb24gQ1RTIHRvIG1hdGNoIHRoZSBwdWxsIG9mDQoNCi1E
b3VnDQo=
