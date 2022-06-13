Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9ADAF549DF7
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jun 2022 21:46:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243993AbiFMTqT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jun 2022 15:46:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243372AbiFMTqA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jun 2022 15:46:00 -0400
Received: from esa.hc3962-90.iphmx.com (esa.hc3962-90.iphmx.com [216.71.142.165])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C6AF8A32C;
        Mon, 13 Jun 2022 11:16:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qccesdkim1;
  t=1655144198; x=1655748998;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=jXMby7ky8RMM65JCPiLlVzx4SZxXFd77kqQqHN8wdck=;
  b=j1ipEAv9GB+A0tjV0i+2D/aT2UKSG/FLxToaZmABafB8R5JzblkTbzup
   O4d4SG44FxljM2PoocYG+pQ35RLgyO0tQZOMp9lHh4riZtSfMZfCiDxwI
   fvZcp7ta0y/G42GkxuOEaSx2G0rXFrAPQjnYuz9EwLeIvttYZgD2w5xnE
   A=;
Received: from mail-mw2nam10lp2102.outbound.protection.outlook.com (HELO NAM10-MW2-obe.outbound.protection.outlook.com) ([104.47.55.102])
  by ob1.hc3962-90.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jun 2022 18:16:37 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ONQizLbMqlckfJM84XDDMovBVLsSwkJjDLcd7XLyPT85revLGm+1TWWIcdIpZikWNpzgyXhS5zOABSRerH5krxf38zKTyCNBQQu9Inj1fZE7wbyWq8l93lMFRLvYifWGayz2UYrappe6smAHqt7NQv5Cvi9p8puF5e3qDoFxz+ah2dQNAXxa0f/gk01TDHhQ+PeWMsa/kzSv9o5EhSCWd40m95A2kQ7jIRoVJwE+54flK9U18nVW8xNrOLpvCaNyyhR+LK7Dcg8JBMVdGvXBuK2FVvILKJj+trxDy3sfMAZs4xc+ucHKx5WtJGfX0DvbeEinYNm3tLVjJlESrknwqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jXMby7ky8RMM65JCPiLlVzx4SZxXFd77kqQqHN8wdck=;
 b=nV9zBfy+JZHGx9wprcyjDu0moduOpgNtkR7/mdexHTOcU3eqnejYUZCsTCbOGs9nniAXvNV1Tqr7X73Q6QGtFEVQPXq0cf2kl35jEv3prF8ic7NgBL9siG4goqFBWl3fA8c/rOpZ4GZoMq+F9Izm3iOosj8EYrYnFmAX2MpOGE1daEl09Z2Qnk4RUNOfgwwnYO7nZOpba1OIx+WyyrcqCEZerRToEqyR7rxJWk8CtashKsIqeLBuCCJ/19wuBK/9etd9BWrmbQi92yXWSm44UXu9m7TzKa0LGX/TEICIf/yQSHF9YF1VqWI4xI0KEgVS5xlBq70Yo1uFZXmNSNUfYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=quicinc.com; dmarc=pass action=none header.from=quicinc.com;
 dkim=pass header.d=quicinc.com; arc=none
Received: from BYAPR02MB4565.namprd02.prod.outlook.com (2603:10b6:a03:15::17)
 by DM5PR02MB2825.namprd02.prod.outlook.com (2603:10b6:3:108::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5332.15; Mon, 13 Jun
 2022 18:16:34 +0000
Received: from BYAPR02MB4565.namprd02.prod.outlook.com
 ([fe80::8953:311b:6d81:3bd2]) by BYAPR02MB4565.namprd02.prod.outlook.com
 ([fe80::8953:311b:6d81:3bd2%7]) with mapi id 15.20.5332.020; Mon, 13 Jun 2022
 18:16:34 +0000
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
Thread-Index: AQHYdRrKW5lyYlSVJ024eBGmtoqqRK05XvEAgAFQ0mOAA1kLt4AEzQpIgAGIppyAAcghDIAB83QAgADYewCABMNeAA==
Date:   Mon, 13 Jun 2022 18:16:34 +0000
Message-ID: <BYAPR02MB456586D44A034C5933A89CFEFAAB9@BYAPR02MB4565.namprd02.prod.outlook.com>
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
 <BL0PR02MB45641E7841A666F867D0185EFAA69@BL0PR02MB4564.namprd02.prod.outlook.com>
 <CAD=FV=WAEhncR462eT06KYuqmqx6QHb7wkvd1gxbsXqFRA06Ew@mail.gmail.com>
In-Reply-To: <CAD=FV=WAEhncR462eT06KYuqmqx6QHb7wkvd1gxbsXqFRA06Ew@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=quicinc.com;
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4a0945ac-bdad-4a64-9333-08da4d68d96c
x-ms-traffictypediagnostic: DM5PR02MB2825:EE_
x-ld-processed: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d,ExtAddr
x-microsoft-antispam-prvs: <DM5PR02MB282576ACEA11DF50B9D2C90C86AB9@DM5PR02MB2825.namprd02.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: otRS4TYQduIbgzTELiVItIMw1YtwFjOUnobL2ltG382hK0zjFfQNy2yLT9BdLBFK6WJt/bpGCfyq+WMM4Fub8nGPYyV6//3PBRdGsjDNOSd6nBe9g7Iil5vhaH27kstyllXP5P6eRwz4ga8ADpPILBI5a7qoWZxJ0QLqVsyXuLM4X4m/rYXGH1DimCgQzeKRcEsqAHHh6INwbg5F6Wc62Uk0Z/MzTwZcF/TX1uCXEb1B1qiC2T7QxThQsZWUJjXDja0Y4u9KHYZK8Ewbia9I6sPbPNnW6N6hZzM2GrET8q0MOi1sSlWyIfkaXMCQ/y/fnPktAtovvkwu2om8sZmpYbZ4mdwdn0c4fwMWyw6S+qsAgY597HURzy2iN6LtT2qyO/CklTiWyYfmn1ESBTIbXmDixzvqFUgXDwI6TGEHDwjq9RgLdCIGjzFxQQhizVa+aWBBwDEB/SPXKHAbwYHqVyGA/KlznR3hOpqkAgGRVKBMbnRXPKhZvYiCXJfScvzToj/SEHpMY7AngNKnqayAz+IddVoq43IfLs+HbweC1gBRTTY9jPO9+UMJZBjd6H1ZlcPLvCckxQIgRTqnOniR+reJi/Y1O3TK+C4tkKZAJ+8Oe5czaaDQvRe6GDcs9tY76tydYeJiTrmmBpgLtRb06uOYG8johMhPZRqEVXVbpDzGzKL5XG1JuZnxcADGpxvIV+YYt9iAM4RASxqPVtqOgg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR02MB4565.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(366004)(38100700002)(6506007)(7696005)(52536014)(33656002)(5660300002)(83380400001)(7416002)(55016003)(76116006)(8676002)(508600001)(66946007)(86362001)(8936002)(2906002)(71200400001)(122000001)(38070700005)(186003)(64756008)(26005)(66556008)(110136005)(54906003)(66476007)(66446008)(4326008)(9686003)(316002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cGtHMmtwWTU4NldLOURJb1FUcDNqZk1pTFRKbGFCRU5PUDdHODlSaXBQaDc3?=
 =?utf-8?B?ck5SWEdUbE03bFJiYml3Rkg5UXJiK1ZKY3VIbDFKT2VKempjYzBGUGdpNCtG?=
 =?utf-8?B?T2N6d1E0L3pId24vZm44QjV0ZVVubjR0WXovVm5hSE5TNDA3bEJ6U0lvMkFY?=
 =?utf-8?B?WUsrb0JUMXBHQmE2ZkFTaTU3aUpUNitML29IYklVYko0MVdQOHNIaU5uVFQw?=
 =?utf-8?B?VHNHOVN1azdGOUdtZkJ4Slg1MGNGcitIMGg1dEhST2I2UUdrYldhTjVWSUVZ?=
 =?utf-8?B?QlVHcmV6NW05ZXFzbW5qanY4bjNBbzc5MUVVNU95Y3lXa0JiRm5vcDlsUlZC?=
 =?utf-8?B?M2lRS0hYTDRVWER1ditJRjYzTWduU3Mvak5EekFNLzI1eTVSQ1pIRktBUzZm?=
 =?utf-8?B?eXRueHpVWEpRMFBXMnI0ZHVoS0tBdytQZHVWQUw3SDFSNFhEYjZONmthaXUv?=
 =?utf-8?B?dWJ0Wm0vZEFDaWt0ZUIxWlJJY1JMb2ZSRHNiV2dVSE5wMTJDbVlxVWp1eGJZ?=
 =?utf-8?B?TmZEMk9GOHZTaUVFdXg5VWIyNlZJV2drYk8vcWhhQXZsdGVzcjZGN1ZZcmlz?=
 =?utf-8?B?Y0pqYk5Vc0ZRbWp2c0ptZGtMOE9RMlVtY3k3SkJvV3M1QkVNRWkzdUo5V3dn?=
 =?utf-8?B?MHBzaHBmUXdLVlFpUExSSzl1amF0cFpTRHhneUhXSktjU1JmT3o5SWlwelBl?=
 =?utf-8?B?eFlscTlzMVZ3UWJaMmY1UEd6NEhpTlM1aVNWSUk5TlhTT0RZOFltUXBHUE41?=
 =?utf-8?B?YmZ6U1VFQXg2VXR3S2FZclkzZUhscFFjaklxbmFScGpTalNFY3VnRzZaclhz?=
 =?utf-8?B?WStIb2s0OTYwMC9rUDBWbG9Ed3ZRSmhIb3ArTDVHczUzaDNvYlZRVVh0dkxX?=
 =?utf-8?B?TkQvbHlLdXZTS0N4WVFySGZnekpvTitTMmlGY09EZExJeEp5QkVOSUFPN2dn?=
 =?utf-8?B?Q1B6RDBRQjI0MnZZKys0SFpRYW1pYzdUTHJ1eUd4RjB4UVpOamt2ZStNS2Jh?=
 =?utf-8?B?bjk2b3BZN05OY1ZCMUtPbGtwVGZzZkFnR1VRSmd1TmZZcUtMQTVVbzA0a0Rt?=
 =?utf-8?B?cmhLVzRpUkxqTnF1eTVnZnQ0ZVI5YklTT2thMnZ4YmNISWd2aFVXNUZETGRn?=
 =?utf-8?B?bmo3eW1oRHFvN1ZWY2dMV0hjeU0rbEY2NXZWa0dUeU1jM1FTa3FGZ3ZzS0ZE?=
 =?utf-8?B?bUd5S3VMb2ZVZVNmVmxqOFVrOXFwbGk3YjBxK2g3Vmg4WVB4WHM0RURDWFBZ?=
 =?utf-8?B?Skg1K1RBbno1WjUzUC9MVTBLNDJlUWN1RGZwU1l5VlJNbG1zdG1Dem5lQjhV?=
 =?utf-8?B?RTl2SXdlMkYzRTFvTjcrMERrc25SdUhiQWVtZTdmWUl6ZGtHRUE4RzRJbU1W?=
 =?utf-8?B?Y0hZUE5IbmhOaGJ1UjVLUTJsSzVrMzVFOXRLc0tuRlBNU1UxbkxmRVowL252?=
 =?utf-8?B?STNJRjQ3K094dHY1QTBEL1p1MTFKSWpHSjZqdmpCZXBmWUNxMWRJSWVhMmJt?=
 =?utf-8?B?N0QvSHhXeWhqcWNIeUFiY2xZem51UFZCWGFJL0JVTnE4ZUNaNHRwd05ua3F1?=
 =?utf-8?B?UFZvQ0FBWEVzdFQvbEw1UnVqM1NaVTJpSmlvdkd0SnFPdXVtQitzQjZ4dzVC?=
 =?utf-8?B?YjU3NUgwaHZOc0htWm41UTFmc1cxWk1uK2c4OU9hQUpPVXlkc1JnSVFXMU5r?=
 =?utf-8?B?UkxhOC9IRmNCQ0d0VXBSRVBQY3VoMTk4S2hxY2hoaDdsMXZzTnVSQkxCRjQr?=
 =?utf-8?B?Q3hKbzhpYXQrMnV0cDFuUWhJZWNWVHM2NXBLTzVmVnQ5NXFveENnNWR0TjZE?=
 =?utf-8?B?Q3ZRcENOeEpSNStwSVdHVjdVRDFlTCtRWmIzUWg1Y1E4NUFTZzd6NzhIakNn?=
 =?utf-8?B?ZWs3VnNWcy9hQTFXTGVnWGk4cnJqZDQ5Y1ZYUkQyWDYyWlNNVDJoYUJ4RU54?=
 =?utf-8?B?ZkpwVHZHRW9XZm12MTk5UVp0WmpOSzRuZkwxZFVwdzZkLzBEYVdPU1VhVlNk?=
 =?utf-8?B?bjVDeWpnMk9ZZkFFVmQrb1d5VUNKMXVuamNIRng1UVZFOEJ5NC95cGRtb3pu?=
 =?utf-8?B?d2tvOThkazhsbmhqNElCWCtCRkFIOHpueUtBVmxZVldQOWxsb3dZYVRuZzR5?=
 =?utf-8?B?dTlvWWNCWDAyWW9wQlZoRDFnSGdTb2FpVERCbEtDcFc2MXhuQ3B5MjlhSDQ0?=
 =?utf-8?B?SWdIakJqdDVCeFJjUHFzQXpxa1M5TDVkRERVMXRZVlltOG9qWWlVa1VwL21y?=
 =?utf-8?B?dWFjbzhNK09IZnNoNURJL1ZOTE9vQjFVYXN6NjI2NUN3US9haE9WRnR3VGVS?=
 =?utf-8?B?NUJ4U08xaUZQaVU4bStValRTQUxmQVYxdmxhWmV3T3k5b1NBcE90QT09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: quicinc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR02MB4565.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a0945ac-bdad-4a64-9333-08da4d68d96c
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jun 2022 18:16:34.5430
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZXVQkY1GdYWRkJb50W4dOVY3fxpG4cfzaxESBnLfxyg31FPOENhLHQUXOtkloebCkzCodJ4B9U2Fd/mp/XWPw8KCydHHx+LnSrvc8KxtzE8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR02MB2825
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksDQoNCg0KPiA+ID4NCj4gPiA+ICAgICBzZXJfY2xrID0gMDsNCj4gPiA+ICAgICBtYXhkaXYg
PSBDTEtfRElWX01TSyA+PiBDTEtfRElWX1NIRlQ7DQo+ID4gPiAgICAgZGl2ID0gMTsNCj4gPiA+
ICAgICB3aGlsZSAoZGl2IDwgbWF4ZGl2KSB7DQo+ID4NCj4gPg0KPiA+IGRpdiA8PSBtYXhkaXYg
Pw0KPiANCj4gQWgsIHN1cmUuDQoNClRoYW5rIHlvdS4NCg0KPiANCj4gDQo+ID4gPiAgICAgICAg
IG11bHQgPSAodW5zaWduZWQgbG9uZyBsb25nKWRpdiAqIGRlc2lyZWRfY2xrOw0KPiA+ID4gICAg
ICAgICBpZiAobXVsdCAhPSAodW5zaWduZWQgbG9uZyltdWx0KQ0KPiA+ID4gICAgICAgICAgICAg
YnJlYWs7DQo+ID4gPg0KPiA+ID4gICAgICAgICB0d29fcGVyY2VudCA9IG11bHQgLyA1MDsNCj4g
PiA+DQo+ID4gPiAgICAgICAgIC8qDQo+ID4gPiAgICAgICAgICAqIExvb3AgcmVxdWVzdGluZyAo
ZnJlcSAtIDIlKSBhbmQgcG9zc2libHkgKGZyZXEpLg0KPiA+ID4gICAgICAgICAgKg0KPiA+ID4g
ICAgICAgICAgKiBXZSdsbCBrZWVwIHRyYWNrIG9mIHRoZSBsb3dlc3QgZnJlcSBpbmV4YWN0IG1h
dGNoIHdlIGZvdW5kDQo+ID4gPiAgICAgICAgICAqIGJ1dCBhbHdheXMgdHJ5IHRvIGZpbmQgYSBw
ZXJmZWN0IG1hdGNoLiBOT1RFOiB0aGlzIGFsZ29yaXRobQ0KPiA+ID4gICAgICAgICAgKiBjb3Vs
ZCBtaXNzIGEgc2xpZ2h0bHkgYmV0dGVyIGZyZXEgaWYgdGhlcmUncyBtb3JlIHRoYW4gb25lDQo+
ID4gPiAgICAgICAgICAqIGZyZXEgYmV0d2VlbiAoZnJlcSAtIDIlKSBhbmQgKGZyZXEpIGJ1dCAo
ZnJlcSkgY2FuJ3QgYmUgbWFkZQ0KPiA+ID4gICAgICAgICAgKiBleGFjdGx5LCBidXQgdGhhdCdz
IE9LLg0KPiA+ID4gICAgICAgICAgKg0KPiA+ID4gICAgICAgICAgKiBUaGlzIGFic29sdXRlbHkg
cmVsaWVzIG9uIHRoZSBmYWN0IHRoYXQgdGhlIFF1YWxjb21tIGNsb2NrDQo+ID4gPiAgICAgICAg
ICAqIGRyaXZlciBhbHdheXMgcm91bmRzIHVwLg0KPiA+ID4gICAgICAgICAgKi8NCj4gPiA+ICAg
ICAgICAgdGVzdF9mcmVxID0gbXVsdCAtIHR3b19wZXJjZW50Ow0KPiA+ID4gICAgICAgICB3aGls
ZSAodGVzdF9mcmVxIDw9IG11bHQpIHsNCj4gPiA+ICAgICAgICAgICAgIGZyZXEgPSBjbGtfcm91
bmRfcmF0ZShjbGssIHRlc3RfZnJlcSk7DQo+ID4gPg0KPiA+ID4gICAgICAgICAgICAgLyoNCj4g
PiA+ICAgICAgICAgICAgICAqIEEgZGVhZC1vbiBmcmVxIGlzIGFuIGluc3RhLXdpbi4gVGhpcyBp
bXBsaWNpdGx5DQo+ID4gPiAgICAgICAgICAgICAgKiBoYW5kbGVzIHdoZW4gImZyZXEgPT0gbXVs
dCINCj4gPiA+ICAgICAgICAgICAgICAqLw0KPiA+ID4gICAgICAgICAgICAgaWYgKCEoZnJlcSAl
IGRlc2lyZWRfY2xrKSkgew0KPiA+ID4gICAgICAgICAgICAgICAgICpjbGtfZGl2ID0gZnJlcSAv
IGRlc2lyZWRfY2xrOw0KPiA+ID4gICAgICAgICAgICAgICAgIHJldHVybiBmcmVxOw0KPiA+ID4g
ICAgICAgICAgICAgfQ0KPiA+ID4NCj4gPiA+ICAgICAgICAgICAgIC8qDQo+ID4gPiAgICAgICAg
ICAgICAgKiBPbmx5IHRpbWUgY2xvY2sgZnJhbWV3b3JrIGRvZXNuJ3Qgcm91bmQgdXAgaXMgaWYN
Cj4gPiA+ICAgICAgICAgICAgICAqIHdlJ3JlIHBhc3QgdGhlIG1heCBjbG9jayByYXRlLiBXZSdy
ZSBkb25lIHNlYXJjaGluZw0KPiA+ID4gICAgICAgICAgICAgICogaWYgdGhhdCdzIHRoZSBjYXNl
Lg0KPiA+ID4gICAgICAgICAgICAgICovDQo+ID4gPiAgICAgICAgICAgICBpZiAoZnJlcSA8IHRl
c3RfZnJlcSkNCj4gPiA+ICAgICAgICAgICAgICAgICByZXR1cm4gc2VyX2NsazsNCj4gPiA+DQo+
ID4gPiAgICAgICAgICAgICAvKiBTYXZlIHRoZSBmaXJzdCAobG93ZXN0IGZyZXEpIHdpdGhpbiAy
JSAqLw0KPiA+ID4gICAgICAgICAgICAgaWYgKCFzZXJfY2xrICYmIGZyZXEgPD0gbXVsdCArIHR3
b19wZXJjZW50KSB7DQo+ID4gPiAgICAgICAgICAgICAgICAgc2VyX2NsayA9IGZyZXE7DQo+ID4g
PiAgICAgICAgICAgICAgICAgKmNsa19kaXYgPSBkaXY7DQo+ID4gPiAgICAgICAgICAgICB9DQo+
ID4NCj4gPiBNeSBsYXN0IGNvbmNlcm4gaXMgd2l0aCBzZWFyY2ggaGFwcGVuaW5nIG9ubHkgd2l0
aGluIDIlIHRvbGVyYW5jZS4NCj4gPiBEbyB3ZSBmYWlsIG90aGVyd2lzZT8NCj4gPg0KPiA+IFRo
aXMgcmVhbCBjYXNlIGhhcyBiZXN0IHRvbGVyYW5jZSBvZiAxLjklIGFuZCBzZWVtcyBjbG9zZS4N
Cj4gPg0KPiA+IFsgICAxNy45NjM2NzJdIDIwMjIwNTMwIGRlc2lyZWRfY2xrLTUxMjAwMDAwDQo+
ID4gWyAgIDIxLjE5MzU1MF0gMjAyMjA1MzAgcmV0dXJuaW5nIHNlcl9jbGstNTIxNzQwMDAsIGRp
di0xLCBkaWZmLTk3NDAwMA0KPiA+DQo+ID4gUGVyaGFwcyB3ZSBjYW4gZmFsbGJhY2sgb24gMXN0
IGNsb2NrIHJhdGU/DQo+IA0KPiBJIGRvbid0IGZlZWwgc3VwZXIgY29tZm9ydGFibGUganVzdCBi
bGluZGx5IGZhbGxpbmcgYmFjayBvbiB0aGUgMXN0IGNsb2NrIHJhdGUuIEl0DQo+IGNvdWxkIGJl
IHdpbGRseSAobW9yZSB0aGFuIDUlKSB3cm9uZywgY2FuJ3QgaXQ/DQo+IA0KPiBJTU86DQo+ICog
SWYgeW91J3JlIG5vdCBjb21mb3J0YWJsZSB3aXRoIDIlLCB5b3UgY291bGQgYWx3YXlzIHBpY2sg
MyUgb3IgNCUuDQo+IEFzIEkgc2FpZCwgbXkgcmFuZG9tIHdlYiBzZWFyY2ggc2VlbWVkIHRvIGlu
ZGljYXRlIHRoYXQgdXAgdG8gNSUgd2FzDQo+IHBlcmhhcHMgT0suDQo+ICogSXQncyBwcm9iYWJs
eSBvdmVya2lsbCwgYnV0IHlvdSBjb3VsZCBhYnN0cmFjdCB0aGUgd2hvbGUgc2VhcmNoIG91dCBh
bmQgdHJ5DQo+IHNlYXJjaGluZyBvbmNlIGZvciAyJSBhbmQgdGhlbiB0cnkgNCU/DQo+DQoNCk9r
LCBJIHdpbGwgaW1wbGVtZW50IGEgZnVuY3Rpb24gdGhhdCBzZWFyY2hlcyB3aXRoaW4gYW4gaW5w
dXQgdG9sZXJhbmNlLg0KQW5kIGhhdmUgYSBjb25kaXRpb25hbCAybmQgY2FsbCB0byBzYW1lIHdp
dGggaGlnaGVyIHRvbGVyYW5jZSBvZiA1JS4NClRoaXMgd291bGQgbWVhbiB0aGF0IHdlIHdpbGwg
c3RpbGwgcnVuIHRocm91Z2ggMiBsb29wcyBpbiBzb21lIGNhc2VzLCBidXQgdGhhdOKAmXMgb2su
DQpUaGFuayB5b3UuDQogDQo+IA0KPiAtRG91Zw0K
