Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 545E54BE517
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Feb 2022 19:00:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355742AbiBULOw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Feb 2022 06:14:52 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:41396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355746AbiBULOI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Feb 2022 06:14:08 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C3C12608;
        Mon, 21 Feb 2022 02:50:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1645440642; x=1676976642;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=OWtnR0z7h2auQ2keSyoyB2quS3uX2a7XUKPGeuoXLko=;
  b=eTvVlars7EcWRcL2yNLJZ0Mjym+zc7qq8n+rXgbFcZI8j2gP+8VL1PTp
   ogPNmOLaz4wYzlx4Nc0ENe/k1ZJ260/yPKNe6LypC3gx9mVXoqVHjDoJj
   EpQFgkQku++BBnDh1gHkCKLJuGj5nRH56OtO0tqO5aJwhXhB3Mj09ipoq
   gC9qvUh4auSUSHznZ3aqEcH3SdAMYaeMD1tyAJiQkFKodkYJDaJ4gFqty
   HXH3b3c1oGv+VO5kJ1ZPx4yLwfSOqWEjnm6cAzAHMI3P4n8dBuFmRwxrG
   geb6Pf/SU60k8zP8QDCGsb26uXtJKQ36UdgTQI3UEFeEFdj8X8zfhtN2a
   w==;
X-IronPort-AV: E=Sophos;i="5.88,385,1635231600"; 
   d="scan'208";a="146700184"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 21 Feb 2022 03:50:41 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Mon, 21 Feb 2022 03:50:40 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17 via Frontend Transport; Mon, 21 Feb 2022 03:50:40 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YSYNSDpe4nqaaAGdqtaCoNJLjqeVBtulMbRFsy9Ur+I7ma9hRi75fc5LY4emn7vISoy3xeYuO06u0GNc8Z4w62JQHs0p/h6F8hTyfy97p92ZQGFZl3RIHHajKGXk4hC7o3CwzYN8YGH79TRybcWFtz6jb5CXVXMgAaQY6v1OSSOoTznEeDhFRUF+Y+BRM1ckcDUyPsZvFGS3bTlZP+Tj+bzQhHK97WXJP+5XW/RstwdjiQfWs5RQYxedc15FbKp5JrQpZSwb8F9hB+rdLnThR5BQU5Ox4NE/XRr31uBbVsCBA8isdRyhJnHNIIp5vILID6GPRcJwc3F+cA90JtXSXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OWtnR0z7h2auQ2keSyoyB2quS3uX2a7XUKPGeuoXLko=;
 b=i0Yin+BEhXhmWV2+ckVBJFUVvoWbIMrXeS3dkrrbYshlALfZNYINsqFRL6fe5spOAmztAFktEI0zp2KmxaHriUwKHdVituhB4skQXR6iw/o3ihLHsaAfgAE1Eaio5puywjtGeNCWKsdjNcFUuGtqSA4kwKcLG2brBFvNdoCMOlvPtidqWD34PgDLmcWo0nwfEqmTgtusELG/mikAtpaHMNJaPmA/6Pztzehs5HneyH2T6H27RNu02c9kyXvg0lrTrUwb5cS16EJroAcKjzT9xIJLUcY8s9LhV/rO/LF3v/3+00kHXd0E49vEgZbPzjtxqPcpw+3ThLQ9w+OZ13sZOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OWtnR0z7h2auQ2keSyoyB2quS3uX2a7XUKPGeuoXLko=;
 b=jIZZFFfEy9wgMHo1MgCMQa9cw1gF2/ihvSBDCfBHD7+F6SmkckjGxIjfgNRTvkPz8EQ6mDFvN+s3aIXEMjEVr8f3tALsAYcP/Zat/xqM0Nt5UoqtdR/0vQ9lF2qXoDOFRxRo/zUgZ8fT2v+u3r5inmDbv52rFm2r+Nwc/STdKBA=
Received: from CO1PR11MB4769.namprd11.prod.outlook.com (2603:10b6:303:91::21)
 by SJ0PR11MB4973.namprd11.prod.outlook.com (2603:10b6:a03:2de::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.17; Mon, 21 Feb
 2022 10:50:35 +0000
Received: from CO1PR11MB4769.namprd11.prod.outlook.com
 ([fe80::b952:cac0:826c:f0be]) by CO1PR11MB4769.namprd11.prod.outlook.com
 ([fe80::b952:cac0:826c:f0be%6]) with mapi id 15.20.4995.027; Mon, 21 Feb 2022
 10:50:34 +0000
From:   <Claudiu.Beznea@microchip.com>
To:     <mpm@selenic.com>, <herbert@gondor.apana.org.au>,
        <Nicolas.Ferre@microchip.com>, <alexandre.belloni@bootlin.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-crypto@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 0/7] hwrng: atmel - add runtime pm support
Thread-Topic: [PATCH v2 0/7] hwrng: atmel - add runtime pm support
Thread-Index: AQHYJxDaQQPUfr6BPUavzzCp+dBeJQ==
Date:   Mon, 21 Feb 2022 10:50:34 +0000
Message-ID: <7ff5d30b-619f-96e3-710b-8c4cbbd7202a@microchip.com>
References: <20220221075928.563806-1-claudiu.beznea@microchip.com>
In-Reply-To: <20220221075928.563806-1-claudiu.beznea@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 54f16a52-b13d-463f-3676-08d9f527fd2d
x-ms-traffictypediagnostic: SJ0PR11MB4973:EE_
x-microsoft-antispam-prvs: <SJ0PR11MB49734E09C3455A6009177F2F873A9@SJ0PR11MB4973.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: REXB3yS1xGgFQMqL5s5AV6jfnQU0Gew6kg15zL04JX88x4Amzuh/pYzY53AQ4po92bd56uJtJl4aTpD8leFw3a/866nAW++NYH/HvxfWg7baQwyIFgiQ+bkSp2f/p+gVzrdAvAG+7buBtWwjGQAhycCkUJBR2o109BZ9O09aJyTmACw7Kbm2cxOMEWUsbef9JwAW+6mpNTFEw1ulsz80ss4JSiLn96tS3HhsLQo8V7avKI3OJQIaEKJtQa2E0oYNbA1nlLioyydhT9oNl5E+hXfQsaPL3LxJiuRSQ0u1nGsKuHKRvnlIfPhY6rQGam+yTv5e3McmYwmS+U8/VeZFsa1+3oTXnw9rWzgYmtbL2gk7m+FkgBJw/b7HwcDNt9AemenGDAZynEGYkHOn8JF9sb+lyXTNgTJJ0R62A1h4RAwIepuls8QmQEepVsiEoYpvyt/VEUl7tx2Je/B8wTWBeeyu5lHHz93HJGSKizblmUF2NFfJgU28jEC85L7voieBLH7FykdA+ZNdsua12FtJrNS8vST1XvvkIgFgJdjuQOKvtlEd5k1BSxtQwCmypdPqWYbKkvy0GGC4e0cUpOaDOvyDpZc6wrO46ZWHbIPhk1bQ2ogvFhmxZpYWBLKL1lPIiceZdOI/iCeqLRllmFO1O1V8un1IuILWFamE+BmZf1SaBdZVCLjWNLy5BPXrfMpBdcLwSSaIZfUzcXL+PcB5JPP0dV7xts2CL7EAfcwbpKNL9I57MbYQtLjtTziAvNEsFeYbxNXMpwcHs4tVGjABCQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB4769.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(4744005)(2906002)(186003)(26005)(122000001)(38100700002)(2616005)(31686004)(5660300002)(36756003)(8936002)(4326008)(66556008)(54906003)(66476007)(6486002)(38070700005)(508600001)(76116006)(66946007)(110136005)(66446008)(8676002)(91956017)(64756008)(71200400001)(6512007)(6506007)(83380400001)(316002)(31696002)(53546011)(86362001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UEFLbFdlWWxjdWVFaFhHVEJCaEV1VDdic3NIVm1rTTRjRkZJMlMxa1dFSXF6?=
 =?utf-8?B?aFJLQ3BGLzR2UDRUUHNzcW5wU2Y5L0E2Ymtkb2UxVEJoSjRGSWdtd0VnNFRU?=
 =?utf-8?B?ZTRldTQ2L1VaYlVIaWpGbGJQVHVjdU1DVGR3cXhwdDRKQ01CU1NVY0lnK2k5?=
 =?utf-8?B?TXdTSXF2YVpRalhzVy9Gd2svaTlyc0tESzFlQXZhTFFUK1I1N3BYaW5hbFdJ?=
 =?utf-8?B?MGQ3SVNXRk9EOGNYTXl5QVJNWEtzK1NJN1lMbzc5N2QvNzcwQXNXK2xhNTNM?=
 =?utf-8?B?ZERmTFNnQi9yZXppWnF5MmgrRTdrTUYzWXJ2SFBTbFpibWZ2Nkxhb2dlR3VM?=
 =?utf-8?B?ZWpaVXRTL0hmaGl3NGdvUWNWTU9GR2RKd2QwbFR1Y3VvclM4Z3RnbS96ajc3?=
 =?utf-8?B?Tjh2T05OZUxJd216SjdrT2lkQnZOWkp6UlpSR3dXWVBWM1doM21CYTZoa0gx?=
 =?utf-8?B?aWV6c0l6RFQ2R1c4Nmp3SGdrUkk0SEYzMzFHYnpyaFhROC9tRzQrWWZrNmlP?=
 =?utf-8?B?aFVoR2ZkdWo1d3pwbVVEak5Zb0RqSFRtTXovWlV5OWpwVlB1REFlRzlrZGVV?=
 =?utf-8?B?NGI2Y3ozb0pJeHRHUnppN2QzN1VZdWs4c3NtNlgrZ2ZCMkJwV1o5L1M0S1Ro?=
 =?utf-8?B?U1dWL3BjK2JYUjRZQUxBc1pybnJKK1lnaTdvckV4NFVVdHVRTC90VC93MHZN?=
 =?utf-8?B?NkZvSXNEK1lHVHdyTEt4WmZHdWFjMUt0eEJTU3U2L3dqVTZibDZYQjgyWE9R?=
 =?utf-8?B?dVN0L3FWQW51VWVRbDhUWEZKdlR1K1RTOFhyamFNU0lvNUlvcS8vZWg0SzJ0?=
 =?utf-8?B?bnRtV0JkOUNpRG1uL3Z6VHo4T1JhZ2VRaEQ5UnFobmRETldtZ2tDR0ltWERj?=
 =?utf-8?B?VE1WVkZrNUV4KzBnWGZKSFlESGtFRkwxbHZUNDIyZ01hU2FPTU1WWi9XcnZl?=
 =?utf-8?B?VGkxaEJUaGdYakIxcXdaOWUxVG9FUzE5eGJCdk9QWWYwaFptUmVqSUkvak5P?=
 =?utf-8?B?VGJYckhISGY1RS9kb2o3T3pvV2NWeUFtKy8xOWtUUE95aFFITy9pZ0VacXlX?=
 =?utf-8?B?UXhVaEZtNHE5RTUrYXA1dFgrZU5BOThZWFJDRG5aamVvWWpaZlB6ZVc1OGh2?=
 =?utf-8?B?T3FheHRRc0YrQ25jaVQ3SXdCMTNlcytjRVhYNmVWbDRmR0FUbVpnczV0UVBx?=
 =?utf-8?B?WTY1L1k0R1FhbmR5YmF0RXQ2N2RYbEhzRjJ0b0NGaGd3eXVMTVRWVDRpdHNR?=
 =?utf-8?B?dTVvU3dRV1RtVnQ1SlpMMWZ5T1JpVWJmaG5wQ0xValhDVU1kT0c5YUt5MHVl?=
 =?utf-8?B?L25XQWduSG0wVnpnMThaRkRXUzBHSFJ4SUcvcjMzVUtuUHZobnBvaDZhYStr?=
 =?utf-8?B?QWdHOUVKYWtTdlJDeWUzMS83RDU4dDhFR096U3BHK2FHTDM5dm5WekRGZFg2?=
 =?utf-8?B?Z0RsRUpueFVPNndXYkErbXlLWlBiK2xEVXNqQzFqSWkrVUpQK3hmQ3ZhOFZp?=
 =?utf-8?B?dHc2dFFxK3A0ZjFRQ2lZVUM4MGdOZVdWWUVmdU5IVFBBQUNTamxTVHFscXZr?=
 =?utf-8?B?eGFiakhxS2dIUUhTeWJaUmZ6NGFWalRYcFd3ZUcycHhDR2ZBSUlxdjlYckVJ?=
 =?utf-8?B?eU5zMHU0U2FTaVhaUUphdFMyUFhQSElwRVUyZWlzM1F1ZFFHdUVsV1JGU1Ri?=
 =?utf-8?B?TTA5NkJxSTZpY25ZaVhLa3FHRHpFZk9qZkZDcy96NVJlOU10T0JVVWlBZGx2?=
 =?utf-8?B?T080akdvSXVmY3VJcWRacTFla3V5NTR4RS9zeS92ZVY3MFdGNEE1TE5NSG5L?=
 =?utf-8?B?ZHZhT0JhblBJRjIwN1N6b1ArVU1VaDNFbHpHUU41WXVsSmNDd2Vla3FyQjF0?=
 =?utf-8?B?ZGRCQ0lLZ1FERG5tL3AvNFpqK1FnY0g3S1I1YXBSdkdHcm55VW11NE5JT1Fj?=
 =?utf-8?B?R2cxeWtjV1YyQmZRZ0lGL0tiOEk5b2R4eHJPd0RZRXd4V2h1WGNndEJvNThr?=
 =?utf-8?B?RGg4bDhZZ3JYbzNWQnZDR2VBWk5IelR6SGlWMTV5SmNoelVpZDBuZkF2K1ZN?=
 =?utf-8?B?aEdUNi9tdTQxSG1GVURPdzhBTGhibWV6b2tXOGtBZHVuTjh0Wjh4akE5Snp1?=
 =?utf-8?B?U0xueHRXaU94bSs2UFozN0JNaXZ1OWRtcXk3WHhOZU8vYnc3dloreXVBd2ZJ?=
 =?utf-8?B?OWFzejFyV2ZXdGFsMCsyUTZlUkVzUEZ2VzJmdlY4MHNwcGZ3aEhFenBZd1ZQ?=
 =?utf-8?B?ZkxZMTIyRXNIRHhEQVJoMjg4TmxRPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F5795FA74397E1438736A201B6333AE9@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB4769.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 54f16a52-b13d-463f-3676-08d9f527fd2d
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Feb 2022 10:50:34.8982
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dEDDKQQmsDwWMnPhjY+KMgRkRwepTR3PRxyrxPXlBloG6Bu/1K6OWqhrMNM3nYKyIAz/Olbh6pZQF41KDVLcU7SYVO3Zc/AmGviHyB+xzhM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB4973
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMjEuMDIuMjAyMiAwOTo1OSwgQ2xhdWRpdSBCZXpuZWEgd3JvdGU6DQo+IEhpLA0KPiANCj4g
VGhpcyBzZXJpZXMgYWRkcyBydW50aW1lIFBNIHN1cHBvcnQgZm9yIGF0bWVsLXJuZyBkcml2ZXIu
IEFsb25nIHdpdGgNCj4gdGhpcyBzb21lIGNsZWFudXAgYW5kIGZpeGVzIHBhdGNoZXMgd2VyZSBh
ZGRlZCB0byB0aGUgc2VyaWVzLg0KPiANCj4gVGhhbmsgeW91LA0KPiBDbGF1ZGl1IEJlem5lYQ0K
DQpGb3Jnb3QgdG8gbWVudGlvbiBoZXJlOg0KDQpDaGFuZ2VzIGluIHYyOg0KLSBzL2h3cm5kL2h3
cm5nIGluIHBhdGNoIHRpdGxlcw0KDQo+IA0KPiBDbGF1ZGl1IEJlem5lYSAoNyk6DQo+ICAgaHdy
bmc6IGF0bWVsIC0gYWRkIHdhaXQgZm9yIHJlYWR5IHN1cHBvcnQgb24gcmVhZA0KPiAgIGh3cm5n
OiBhdG1lbCAtIGRpc2FibGUgdHJuZyBvbiBmYWlsdXJlIHBhdGgNCj4gICBod3JuZzogYXRtZWwg
LSByZW5hbWUgZW5hYmxlL2Rpc2FibGUgZnVuY3Rpb25zIHRvIGluaXQvY2xlYW51cA0KPiAgIGh3
cm5nOiBhdG1lbCAtIG1vdmUgc2V0IG9mIFRSTkdfSEFMRlIgaW4gYXRtZWxfdHJuZ19pbml0KCkN
Cj4gICBod3JuZzogYXRtZWwgLSB1c2UgX19tYXliZV91bnVzZWQgYW5kIHBtX3B0cigpIGZvciBw
bSBvcHMNCj4gICBod3JuZzogYXRtZWwgLSBhZGQgcnVudGltZSBwbSBzdXBwb3J0DQo+ICAgaHdy
bmc6IGF0bWVsIC0gcmVtb3ZlIGV4dHJhIGxpbmUNCj4gDQo+ICBkcml2ZXJzL2NoYXIvaHdfcmFu
ZG9tL2F0bWVsLXJuZy5jIHwgMTQ4ICsrKysrKysrKysrKysrKysrKy0tLS0tLS0tLS0tDQo+ICAx
IGZpbGUgY2hhbmdlZCwgOTEgaW5zZXJ0aW9ucygrKSwgNTcgZGVsZXRpb25zKC0pDQo+IA0KDQo=
