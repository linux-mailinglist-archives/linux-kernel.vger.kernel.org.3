Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B471854627D
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Jun 2022 11:33:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242784AbiFJJds (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Jun 2022 05:33:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348565AbiFJJda (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jun 2022 05:33:30 -0400
Received: from esa.hc3962-90.iphmx.com (esa.hc3962-90.iphmx.com [216.71.142.165])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 872D1B879;
        Fri, 10 Jun 2022 02:33:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qccesdkim1;
  t=1654853609; x=1655458409;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=3DMqVoYgd7Lui/BS5V2QvFSdB5jMpj3moPRWICO8P8g=;
  b=BT9eiWtwSRhcaZ0+1XiKvCP2vMW8+I6n2QbDQnqP4ng//hViVFg0MX8T
   MszaczNFQvV//jUgGiORAd6+AWA44uu8rxNtJsP56R29qm3uT3IIBOfA/
   ASAASLLOoCuDxHhkKNDsbaFflTLRC3nemaZ4wNpRnqDUiLo/6Uc+QI3C0
   Q=;
Received: from mail-bn8nam11lp2171.outbound.protection.outlook.com (HELO NAM11-BN8-obe.outbound.protection.outlook.com) ([104.47.58.171])
  by ob1.hc3962-90.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2022 09:33:27 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Lhw3rLZQOumNYQvN/BbYMUHz2B7wAmi2lC9mdFU0DtU94YZsWVh3fSGMetXIQlQoN4XZmDmafA0afubgG0xgVwXx1tJGh1/vqD3GSWCFjGPZjrLOr10WXHTi/GEKK1UIXSvQB/MFKk6wjcDASNMy0xTjBAzIXuOO36MK0PnxQeiAtVjoASFlZFFhrC+ek4GqdMTcVSCgsS34430iOiyxu9STm+D75sKcyOK6EMbnvnOTi2OBuOonX4sOlhfmo+XfJuZS7I98o94oBSEnvIztKuPJMc9EUqu4pceVzcWCEdrwxWJzl5qWJiuFUPniuRvo4/fHe4R0QxTg6iOPuJJLBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3DMqVoYgd7Lui/BS5V2QvFSdB5jMpj3moPRWICO8P8g=;
 b=mazt9q+vbMf8i26HrkderNa95i5mDn0xGYjhP14EWVuIKgzNnFkJlSSzn70zcbosyzdUV9BA2cL8nmvQOluxJf+Kq1qVSmJZD2SXxpv/f9Sug0GW95hKrCh8BlBKm7yRcJAYnRoR11Sl6GY8q7GeE+PDjQpUhxeFMQN92u2zWVFG9P+d1p3VUqEQfGKAz++Lc4SToFdofvwXYoj5s9PHhKU3GRZriMgG5pDsgYhHAfa9GPhWkTKNAu5J8608YWHyJR5X7t8FKeDkLic+0d5wJTgMCCLOucq2DxRD9FyLO/s7z2n+wMgUjUYyziioqWbC7o5Mw8d/E3oIfeR5CGFPmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=quicinc.com; dmarc=pass action=none header.from=quicinc.com;
 dkim=pass header.d=quicinc.com; arc=none
Received: from BL0PR02MB4564.namprd02.prod.outlook.com (2603:10b6:208:4d::13)
 by BN0PR02MB8014.namprd02.prod.outlook.com (2603:10b6:408:16d::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5332.13; Fri, 10 Jun
 2022 09:33:20 +0000
Received: from BL0PR02MB4564.namprd02.prod.outlook.com
 ([fe80::508d:2d15:ef0f:4f60]) by BL0PR02MB4564.namprd02.prod.outlook.com
 ([fe80::508d:2d15:ef0f:4f60%7]) with mapi id 15.20.5314.020; Fri, 10 Jun 2022
 09:33:14 +0000
From:   "Vijaya Krishna Nivarthi (Temp) (QUIC)" <quic_vnivarth@quicinc.com>
To:     Doug Anderson <dianders@chromium.org>,
        "Vijaya Krishna Nivarthi (Temp) (QUIC)" <quic_vnivarth@quicinc.com>
CC:     Andy Gross <agross@kernel.org>,
        "bjorn.andersson@linaro.org" <bjorn.andersson@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "Mukesh Savaliya (QUIC)" <quic_msavaliy@quicinc.com>,
        Matthias Kaehlcke <mka@chromium.org>,
        Stephen Boyd <swboyd@chromium.org>
Subject: RE: [PATCH] tty: serial: qcom-geni-serial: minor fixes to
 get_clk_div_rate()
Thread-Topic: [PATCH] tty: serial: qcom-geni-serial: minor fixes to
 get_clk_div_rate()
Thread-Index: AQHYdRrKW5lyYlSVJ024eBGmtoqqRK05XvEAgAFQ0mOAA1kLt4AEzQpIgAGIppyAAcghDIAB83QA
Date:   Fri, 10 Jun 2022 09:33:14 +0000
Message-ID: <BL0PR02MB45641E7841A666F867D0185EFAA69@BL0PR02MB4564.namprd02.prod.outlook.com>
References: <1654021066-13341-1-git-send-email-quic_vnivarth@quicinc.com>
 <CAD=FV=UF3x5RHrQH-m1X-4kQSsKiufLnkew=VuJz7W9EAi3GHQ@mail.gmail.com>
 <5d950007-7a92-a41b-e569-79e806adb06a@quicinc.com>
 <CAD=FV=Xm1LJEoU5dKa5pMgqsHuAXuFVpdHvc1REULhAKTPbGnQ@mail.gmail.com>
 <ad393ad2-a247-3c61-5033-185d39b5596d@quicinc.com>
 <CAD=FV=XD+LozhkJZp0C7RUO01T-XuqBA-SJ0EQeyvGk0CxC3JQ@mail.gmail.com>
 <e677fd02-011f-4f4e-fa73-17dc96aea7d0@quicinc.com>
 <CAD=FV=UzjnEjMTLTRVXTrz6aoiBymJtnJ1o8dzPN9hn0Be3tng@mail.gmail.com>
 <da18c508-f32e-fece-6392-e6a95f7c7968@quicinc.com>
 <CAD=FV=Wytm9EYu=4ndN+En2AFEgPK9NjrUMbFPA_h6TwyxGCYA@mail.gmail.com>
 <765a170c-d335-d626-0609-7d0f3967b71d@quicinc.com>
 <CAD=FV=X2wTUH50MqFu=4WifvbTG+df-oYqQBRWeSPES7M2fxNw@mail.gmail.com>
In-Reply-To: <CAD=FV=X2wTUH50MqFu=4WifvbTG+df-oYqQBRWeSPES7M2fxNw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=quicinc.com;
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8ce3e39b-d049-4a95-0e46-08da4ac43e2c
x-ms-traffictypediagnostic: BN0PR02MB8014:EE_
x-ld-processed: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d,ExtAddr
x-microsoft-antispam-prvs: <BN0PR02MB801474CD2E4BD2287E380AC286A69@BN0PR02MB8014.namprd02.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: LKYpH2SVRENjowx3cogG32zGzzm6qZ5z5NNoUzJsmxP8pOFKnBvTA6HbnhsybVFSzGVwjxjzGn8u0GbV4jMrTmaTWwTvLvRoRl1XCvZ8lvqT0xBALz1Ybda79RkCzRgdM2Bf3VVrAIBM+MjOX84SFFaLD91+TwF+cZc/PpdZ8UFDB1FMBKubcdJphKE/D/U5qUHR+T4xTCL6Tbeni9oCvc10s2W36bi53oQklzBdny34s19Pu64A1mL+Y0e+SZ+ZNDUHY0L95b3fzjDuk84/iOhSsFHeP1gu/pXIbJIoc7R8AvSVCVTI8Q5GHSzJekc9owaD82OwCb33JOzvSIYGF4Qlxjpx8cwfx99rRpSqy7T+dPmErfrsWNXnkfoDklWT04Ml0FrvjQ5HVwXFD1YrXxUU2eGKf9/tVkr0F6m+tEm5ETlcG9G3wbv6A5RA1Q6t87Y3H1kXBvlhDDjwpFcbun3/+AG5FZtPxziRh+qbL8+8X2gmdnx/omkCfo6YCfK+RAfXvLWar/8U81h2Y8BJI/qqujyTTcUioj1PDLja3GIsP8c8tKBGj25FJMo9TLuTC62/alW6LpRfEZopUC4zRfZlDae6c6TrvpmpBSgg4F4RO2a5GWeVAIKOKmRbBIm4m6OQe0Qxt9o8Gsjxd6iSA4LJsxrnD29fiGc46OkqaGbR22pqRGRjh55B9g3mh7EqtJviNyYdCPpmQEevjc1rQA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR02MB4564.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(508600001)(33656002)(8676002)(4326008)(186003)(9686003)(7696005)(6506007)(83380400001)(2906002)(38100700002)(26005)(38070700005)(5660300002)(316002)(122000001)(52536014)(8936002)(71200400001)(55016003)(7416002)(86362001)(66556008)(64756008)(76116006)(66476007)(66946007)(66446008)(110136005)(54906003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WEw4WkxBeXE5b05MdWkxNWhDOXR6NG9mUWtTdGVBZTNrbTBKVWJRN0xTMmpY?=
 =?utf-8?B?cGljU2hwWEtDSGFuS21NVnFGd3k0SHZlVkxocnh2MVdONGErM3JuNWcxSXVJ?=
 =?utf-8?B?V2tsN0twMXp4clNtRDQwODJITXdsSVZza3RoSTN1QkpEa2dablpuR2RaMW1k?=
 =?utf-8?B?eENFSkdpNXh3Nm5uNk9FcExJSWZTd09oMDZZVUVSTDRLdlVVY1dNbmNXZ0w4?=
 =?utf-8?B?aEFGT09xS28vL25iRm1nOXVhcWExaHFQRzY5ZXowZUxPQWM3OE0xVHFZVWdi?=
 =?utf-8?B?SGRLYTdIR3BQc2FEMFkrcUpubFBYVUsxSFdHaldEMWxnMHl3WUV5QUNwTU1j?=
 =?utf-8?B?RUdGNlo1L0FvcTEwMU5lUUNqNmN3NmRJRXM1M1hBaE9IK1YxV2lyTVhyalRt?=
 =?utf-8?B?NXVaU1Q5dVJpWTNrMUVGUGV5SjZ2bTBZSng2TitKdFBBTVNrOVYvVVRFRExD?=
 =?utf-8?B?Wi9WMzNwMUhwWFpXcHhNbktRY3FJNXNSTDRGNHk5cjZvU3VKaEF4VGEzeUUv?=
 =?utf-8?B?S0MzaFZDdHEvSExuR2pNZWJRZnFJL2xaaCtBV3lpaVI1UFNRQjQvUTZqMjh5?=
 =?utf-8?B?ZjMydm1qbUt0ZTFod2lDZGM0dzl3Rm1jcVBTaXovTjh4cmNNQWVMNHpjL3l1?=
 =?utf-8?B?bzZydUEzSTZRbW90OWRDMk9UeWxmdjJJZnpReHVkUVlhTlpHRGFQcGIrQ040?=
 =?utf-8?B?WjVBUjVjTGZHdXFycnBLWGlXM0xNWFNERFk5QThLRmVrREcxL05vVEt4UDJv?=
 =?utf-8?B?M3BhRlhQeWFieHZXemYvcnM0Q2xsRSt1ak14d1puaXZjV25UTXdOKzJ4NUV4?=
 =?utf-8?B?NGYrTmRTY0QyZ3ozMXZMQ2ZwL2VSY2FVUGJjQUlsZFRoZ2lqQUFpZm1OR09z?=
 =?utf-8?B?VFFSWnF5b3lMRldFOFFndlBqTnZ3aGZzVGNWQ1pLc1MyOGVvV0JienQ2U29k?=
 =?utf-8?B?TmpvazRRemZzbFhKdEJ2UG0wUk1kd0VVNlE0cTVnT1JoZUNaWEFNNzYvbllC?=
 =?utf-8?B?ZkZTVjdsSUdlcUJHYXdlRHQ0bjQrakg5akxOeUdJNlNwRVgvNHJZQm4rN2Ft?=
 =?utf-8?B?dU9GeFF5U090bFE4QkhKRGtkNERtY0tVTDVjQ2RUNTFlT3hCWXZtUHNpSGUz?=
 =?utf-8?B?aTVORXZLcXVnbStEV1RkY0d5TUl6a2RLS1pjOWJiZzlrNHlLbU5LTjY3Vi9l?=
 =?utf-8?B?YlkzdWwyTHhsVTBSbVhTWTNYcE4yMUxTTlVFa0liajhMMWNLVTEvbWRva3Yz?=
 =?utf-8?B?Z3FvbUkwaFRhU3lZYnZGTHRxdUZTRUNKK3REMWtqdjB6aEVSMElJSHZqMDJB?=
 =?utf-8?B?VkpQQm1ZS0ZReGpIWlh6OGxNYUJRNWN5b25pblp3Q1JuSVV6RGRpdG11djl3?=
 =?utf-8?B?TFo5eS9zZFJJY2huM0h5NnZoQ2VEaVdPbm1Rd2p2bms3Y0FpTDdLWFNBUUNn?=
 =?utf-8?B?NXJUMXR5UTVYckFVQjRTU1MyZW45dlAyQUwyYytqSEpSUC9PTU5idUdPQm5n?=
 =?utf-8?B?d0dnZ25XVnRYT1FpejdTVWRMSU1jZ0JYNFh6dHlLTmFvNzhacXpqdVU1eXoy?=
 =?utf-8?B?SDl0SXJzS1ZHaHBQdmtpaW4yV3M0aDdjQ0RTSW9kbzNCMUJvZU1CQW9QU0JC?=
 =?utf-8?B?VnYwY2FZR2s2UUMxOEthYTBybTdNa1hiV0dsbXJmYzY0VDhveFVQSVFxVmZO?=
 =?utf-8?B?WnZDR20zODZmbUtrVGc1ZHI3M2Q5SjFpcE8xS2xZR0R6RS8wS3BrTFV2UW1H?=
 =?utf-8?B?SEtJZWh3S3dmUXJwTUxiU1lIZ0tzR3VVdkVpS3dWTDh2SW5Scy9STkhxSDlD?=
 =?utf-8?B?VWF2YjFreGlnVzFIT0hrREJXdWprdlBpV1R1MWhJdldJdTVCQ2NIRzVvMzdH?=
 =?utf-8?B?SlRLc2dCK1M3RDk3NmlidHJTTWxOSHFaakJEWFNMc21LSzkyZC9LbytEOU16?=
 =?utf-8?B?Z1VWc0REWHJrMzQ2c1hlUnFtL01WUVFZZElXQVBTWXdhTEtKL29veXZBQWZV?=
 =?utf-8?B?ZmZQSWJJY2RVTUdPb3BmaVQ2WFFWYm1qKzFRQkRVd3JjUXIyVlRHTnU0dm05?=
 =?utf-8?B?MEFMYjl0NktsKzdhN2k3N3ZDd0lZclVRaFZKbjI0QzE1VHZ5UEs3V2ZLUG9H?=
 =?utf-8?B?U2JmSnFiaXpBb2JxQkNWTm9naVd1clRjaEhteHFCc0lhL2ljRUlJdTc4UTR6?=
 =?utf-8?B?bFFwUVc0c3V5WFNtbGE0anZCbUtic0JTL0hKdmZwajBWRTZqM21NYkkwWGY2?=
 =?utf-8?B?NnFwODF0VWhPQkkzQzRFVVN2T2Q3SGdNNGVWa2NQVzBCbDlGZ2VCNXk4d3Ni?=
 =?utf-8?B?bUpDU2d3NmFsMTQ2WnpEbEtaK0VOWk1iemdxOTRmTXpFWG5qcHdHUT09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: quicinc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL0PR02MB4564.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ce3e39b-d049-4a95-0e46-08da4ac43e2c
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jun 2022 09:33:14.3310
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KIgczWWMYcOTUEAqUmE5df2sKLS+uThrJng1Or6r6T4HQf47Rh1mV4oIDTIXzOjqSBmvsMUGFwM+3i3XVFcYdPk5bV6U1LVQ3NaC8NjVeLw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR02MB8014
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksDQoNClJlLXNlbmRpbmcgKDJuZCBhdHRlbXB0KSBhcyBlbWFpbHMgYXJlIGJvdW5jaW5nLi4u
DQoNCg0KPiA+DQo+ID4gQnV0IHRoZW4gb25jZSBhZ2Fpbiwgd2Ugd291bGQgbGlrZWx5IG5lZWQg
MiBsb29wcyBiZWNhdXNlIHdoaWxlIHdlIGFyZQ0KPiA+IG9rIHdpdGggZ2l2aW5nIHVwIG9uIHNl
YXJjaCBmb3IgYmVzdF9kaXYgb24gZmluZGluZyBzb21ldGhpbmcgd2l0aGluDQo+ID4gMiUgdG9s
ZXJhbmNlLCB3ZSBtYXkgbm90IHdhbnQgdG8gZ2l2ZSB1cCBvbiBleGFjdCBtYXRjaCAoZnJlcSAl
DQo+ID4gZGVzaXJlZF9jbGsgPT0gMCApDQo+IA0KPiBBaCwgaXQgdG9vayBtZSBhIHdoaWxlIHRv
IHVuZGVyc3RhbmQgd2h5IHR3byBsb29wcy4gSXQncyBiZWNhdXNlIGluIG9uZSBjYXNlDQo+IHlv
dSdyZSB0cnlpbmcgbXVsdGlwbGllcyBhbmQgaW4gdGhlIG90aGVyIHlvdSdyZSBidW1waW5nIHVw
IHRvIHRoZSBuZXh0DQo+IGNsb3Nlc3QgY2xvY2sgcmF0ZS4gSSBkb24ndCB0aGluayB5b3UgcmVh
bGx5IG5lZWQgdG8gZG8gdGhhdC4gSnVzdCB0ZXN0IHRoZSAocmF0ZSAtDQo+IDIlKSBhbmQgdGhl
IHJhdGUuIEhvdyBhYm91dCB0aGlzIChvbmx5IGxpZ2h0bHkgdGVzdGVkKToNCj4gDQo+ICAgICBz
ZXJfY2xrID0gMDsNCj4gICAgIG1heGRpdiA9IENMS19ESVZfTVNLID4+IENMS19ESVZfU0hGVDsN
Cj4gICAgIGRpdiA9IDE7DQo+ICAgICB3aGlsZSAoZGl2IDwgbWF4ZGl2KSB7DQoNCg0KZGl2IDw9
IG1heGRpdiA/DQoNCg0KPiAgICAgICAgIG11bHQgPSAodW5zaWduZWQgbG9uZyBsb25nKWRpdiAq
IGRlc2lyZWRfY2xrOw0KPiAgICAgICAgIGlmIChtdWx0ICE9ICh1bnNpZ25lZCBsb25nKW11bHQp
DQo+ICAgICAgICAgICAgIGJyZWFrOw0KPiANCj4gICAgICAgICB0d29fcGVyY2VudCA9IG11bHQg
LyA1MDsNCj4gDQo+ICAgICAgICAgLyoNCj4gICAgICAgICAgKiBMb29wIHJlcXVlc3RpbmcgKGZy
ZXEgLSAyJSkgYW5kIHBvc3NpYmx5IChmcmVxKS4NCj4gICAgICAgICAgKg0KPiAgICAgICAgICAq
IFdlJ2xsIGtlZXAgdHJhY2sgb2YgdGhlIGxvd2VzdCBmcmVxIGluZXhhY3QgbWF0Y2ggd2UgZm91
bmQNCj4gICAgICAgICAgKiBidXQgYWx3YXlzIHRyeSB0byBmaW5kIGEgcGVyZmVjdCBtYXRjaC4g
Tk9URTogdGhpcyBhbGdvcml0aG0NCj4gICAgICAgICAgKiBjb3VsZCBtaXNzIGEgc2xpZ2h0bHkg
YmV0dGVyIGZyZXEgaWYgdGhlcmUncyBtb3JlIHRoYW4gb25lDQo+ICAgICAgICAgICogZnJlcSBi
ZXR3ZWVuIChmcmVxIC0gMiUpIGFuZCAoZnJlcSkgYnV0IChmcmVxKSBjYW4ndCBiZSBtYWRlDQo+
ICAgICAgICAgICogZXhhY3RseSwgYnV0IHRoYXQncyBPSy4NCj4gICAgICAgICAgKg0KPiAgICAg
ICAgICAqIFRoaXMgYWJzb2x1dGVseSByZWxpZXMgb24gdGhlIGZhY3QgdGhhdCB0aGUgUXVhbGNv
bW0gY2xvY2sNCj4gICAgICAgICAgKiBkcml2ZXIgYWx3YXlzIHJvdW5kcyB1cC4NCj4gICAgICAg
ICAgKi8NCj4gICAgICAgICB0ZXN0X2ZyZXEgPSBtdWx0IC0gdHdvX3BlcmNlbnQ7DQo+ICAgICAg
ICAgd2hpbGUgKHRlc3RfZnJlcSA8PSBtdWx0KSB7DQo+ICAgICAgICAgICAgIGZyZXEgPSBjbGtf
cm91bmRfcmF0ZShjbGssIHRlc3RfZnJlcSk7DQo+IA0KPiAgICAgICAgICAgICAvKg0KPiAgICAg
ICAgICAgICAgKiBBIGRlYWQtb24gZnJlcSBpcyBhbiBpbnN0YS13aW4uIFRoaXMgaW1wbGljaXRs
eQ0KPiAgICAgICAgICAgICAgKiBoYW5kbGVzIHdoZW4gImZyZXEgPT0gbXVsdCINCj4gICAgICAg
ICAgICAgICovDQo+ICAgICAgICAgICAgIGlmICghKGZyZXEgJSBkZXNpcmVkX2NsaykpIHsNCj4g
ICAgICAgICAgICAgICAgICpjbGtfZGl2ID0gZnJlcSAvIGRlc2lyZWRfY2xrOw0KPiAgICAgICAg
ICAgICAgICAgcmV0dXJuIGZyZXE7DQo+ICAgICAgICAgICAgIH0NCj4gDQo+ICAgICAgICAgICAg
IC8qDQo+ICAgICAgICAgICAgICAqIE9ubHkgdGltZSBjbG9jayBmcmFtZXdvcmsgZG9lc24ndCBy
b3VuZCB1cCBpcyBpZg0KPiAgICAgICAgICAgICAgKiB3ZSdyZSBwYXN0IHRoZSBtYXggY2xvY2sg
cmF0ZS4gV2UncmUgZG9uZSBzZWFyY2hpbmcNCj4gICAgICAgICAgICAgICogaWYgdGhhdCdzIHRo
ZSBjYXNlLg0KPiAgICAgICAgICAgICAgKi8NCj4gICAgICAgICAgICAgaWYgKGZyZXEgPCB0ZXN0
X2ZyZXEpDQo+ICAgICAgICAgICAgICAgICByZXR1cm4gc2VyX2NsazsNCj4gDQo+ICAgICAgICAg
ICAgIC8qIFNhdmUgdGhlIGZpcnN0IChsb3dlc3QgZnJlcSkgd2l0aGluIDIlICovDQo+ICAgICAg
ICAgICAgIGlmICghc2VyX2NsayAmJiBmcmVxIDw9IG11bHQgKyB0d29fcGVyY2VudCkgew0KPiAg
ICAgICAgICAgICAgICAgc2VyX2NsayA9IGZyZXE7DQo+ICAgICAgICAgICAgICAgICAqY2xrX2Rp
diA9IGRpdjsNCj4gICAgICAgICAgICAgfQ0KDQpNeSBsYXN0IGNvbmNlcm4gaXMgd2l0aCBzZWFy
Y2ggaGFwcGVuaW5nIG9ubHkgd2l0aGluIDIlIHRvbGVyYW5jZS4NCkRvIHdlIGZhaWwgb3RoZXJ3
aXNlPw0KDQpUaGlzIHJlYWwgY2FzZSBoYXMgYmVzdCB0b2xlcmFuY2Ugb2YgMS45JSBhbmQgc2Vl
bXMgY2xvc2UuDQoNClsgICAxNy45NjM2NzJdIDIwMjIwNTMwIGRlc2lyZWRfY2xrLTUxMjAwMDAw
DQpbICAgMjEuMTkzNTUwXSAyMDIyMDUzMCByZXR1cm5pbmcgc2VyX2Nsay01MjE3NDAwMCwgZGl2
LTEsIGRpZmYtOTc0MDAwDQoNClBlcmhhcHMgd2UgY2FuIGZhbGxiYWNrIG9uIDFzdCBjbG9jayBy
YXRlPw0KDQpUaGFuayB5b3UuDQoNCj4gDQo+ICAgICAgICAgICAgIC8qDQo+ICAgICAgICAgICAg
ICAqIElmIHdlIGFscmVhZHkgcm91bmRlZCB1cCBwYXN0IG11bHQgdGhlbiB0aGlzIHdpbGwNCj4g
ICAgICAgICAgICAgICogY2F1c2UgdGhlIGxvb3AgdG8gZXhpdC4gSWYgbm90IHRoZW4gdGhpcyB3
aWxsIHJ1bg0KPiAgICAgICAgICAgICAgKiB0aGUgbG9vcCBhIHNlY29uZCB0aW1lIHdpdGggZXhh
Y3RseSBtdWx0Lg0KPiAgICAgICAgICAgICAgKi8NCj4gICAgICAgICAgICAgdGVzdF9mcmVxID0g
bWF4KGZyZXEgKyAxLCBtdWx0KTsNCj4gICAgICAgICB9DQo+IA0KPiAgICAgICAgIC8qDQo+ICAg
ICAgICAgICogdGVzdF9mcmVxIHdpbGwgYWx3YXlzIGJlIGJpZ2dlciB0aGFuIG11bHQgYnkgYXQg
bGVhc3QgMS4NCj4gICAgICAgICAgKiBUaGF0IG1lYW5zIHdlIGNhbiBnZXQgdGhlIG5leHQgZGl2
aWRlciB3aXRoIGEgRElWX1JPVU5EX1VQLg0KPiAgICAgICAgICAqIFRoaXMgaGFzIHRoZSBhZHZh
bnRhZ2Ugb2Ygc2tpcHBpbmcgYnkgYSB3aG9sZSBidW5jaCBvZiBkaXZzDQo+ICAgICAgICAgICog
SWYgdGhlIGNsb2NrIGZyYW1ld29yayBhbHJlYWR5IGJ5cGFzc2VkIHRoZW0uDQo+ICAgICAgICAg
ICovDQo+ICAgICAgICAgZGl2ID0gRElWX1JPVU5EX1VQKHRlc3RfZnJlcSwgZGVzaXJlZF9jbGsp
Ow0KPiAgICAgICAgIH0NCj4gDQo+ICAgICByZXR1cm4gc2VyX2NsazsNCg==
