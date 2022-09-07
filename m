Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 120635B0090
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Sep 2022 11:35:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230153AbiIGJfT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Sep 2022 05:35:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbiIGJfQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Sep 2022 05:35:16 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79A8D481E9;
        Wed,  7 Sep 2022 02:35:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1662543316; x=1694079316;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=R52SMc0N/CUCkrh1eC3/dWM80ezpOy5znFIB5vArcx8=;
  b=Ree26RvT3Tk3XJdA9XblNqXkaolXMS0qHVK7ELnAzlr54BJ7g8as/AnQ
   5VQZB3hhQn5W2zhWXH/WUlnDKIWV13iii/icF0ncZJH7SsKKFxMWbWDZh
   TCDv85oQZysjBV2NFnfeSe6CtSVDVmf/VDpM0J3Rpq62HLwty2NMkiJNv
   CRb488EE9WlYuf0CVSPAeJ9Aq2MraD3RphejWJ4njxu1R2hzwQHCCtpwK
   GLTLm+MJ5TELAcrE99QhePpWflar+rzv/Yb2PnpD0Or0ZEnvv15znOXCT
   z0a0rnLCcnGsAtB5DxYJQKG1k7KWhbSnP9O86Br/YtEJ+hVFr1YqzwcbB
   w==;
X-IronPort-AV: E=Sophos;i="5.93,296,1654585200"; 
   d="scan'208";a="172734290"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 07 Sep 2022 02:35:15 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Wed, 7 Sep 2022 02:34:59 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12 via Frontend Transport; Wed, 7 Sep 2022 02:34:59 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VrzZhroMrCDwTp2JLGnBixXvIdRYf3HwtEv9jkDSrA6J1r+aDNQheR5JSL6EOZ00AKem2MVqGO66rj3c3OSCmr8IBhtr0Gt0kpH2V8MqQSVZg4eT42VKewD33WUR8WWCoDZTMKnxG6nE1fBuSK9t6BVKG2ZNZGM/Tl+K+qquFptNdsBQeHxDwz2QPOSFaR/dpyDw1UHQCd6RxLob++snqMCr7KFRWNJ+FaXV3MvaITRjBIqDzoavcVNsRnPvFi8C357Lo4+KzbBX1EMTfDsysddwtv0W/+Shyt7j7Q2r+mzB8JiHDz5e62LJlan/9rMEjV0wBwqXIWNN0rt7J6gTbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R52SMc0N/CUCkrh1eC3/dWM80ezpOy5znFIB5vArcx8=;
 b=A7vEdkG2bV5UFhTuk6RTr0RO2juRa8V9QROlX3X3RebvbUfDyuEYM2EXqroXgszBnGPJu20UObSKtY7dhT1jOSlqov0lASKOrh2ZeroEMZKc6uOrgw/6ym01UPSKist0aDYQJhuqT3CsRBL0F98Bob4iNW+snzpjqauzlGJbdMH+C47quMzZagW+7eEa5HAJ9Vp3m5rhQdOND7zKthO3rNMvKiu6dBviZ++zJmdyIBlHgy4P1RQP6irzdnILGA0iWqgRPo3A9xc6coIKRiV4JARLPJS+7vW9Jt7F6Nz2BeNeRoWNV/5REYj/mpgH4HE6cUXKf3Ztd7ZTkr4bwhBF7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R52SMc0N/CUCkrh1eC3/dWM80ezpOy5znFIB5vArcx8=;
 b=ptDoB1Ak4Vdw/mMmYDzWfbauRmoBoFPYiuuWyDuuuoqh7PazwlKeoauVHpKV/iW/djX8jjXV7BtUJgKKVt45+wYc+KHRhYkb+rBn+b/SKtdzfzAunB+0K8hEHWqNH7lI3jFqdXsayD3em3q+kJ8/VhnGhNHxxqdv7f3b79xGhLs=
Received: from BYAPR11MB2758.namprd11.prod.outlook.com (2603:10b6:a02:c9::11)
 by BN6PR11MB1810.namprd11.prod.outlook.com (2603:10b6:404:fc::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.14; Wed, 7 Sep
 2022 09:34:54 +0000
Received: from BYAPR11MB2758.namprd11.prod.outlook.com
 ([fe80::6852:5740:4bc9:d1b4]) by BYAPR11MB2758.namprd11.prod.outlook.com
 ([fe80::6852:5740:4bc9:d1b4%7]) with mapi id 15.20.5588.014; Wed, 7 Sep 2022
 09:34:54 +0000
From:   <Sergiu.Moga@microchip.com>
To:     <ilpo.jarvinen@linux.intel.com>
CC:     <lee@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <Nicolas.Ferre@microchip.com>,
        <alexandre.belloni@bootlin.com>, <Claudiu.Beznea@microchip.com>,
        <richard.genoud@gmail.com>, <radu_nicolae.pirea@upb.ro>,
        <gregkh@linuxfoundation.org>, <broonie@kernel.org>,
        <mturquette@baylibre.com>, <sboyd@kernel.org>,
        <jirislaby@kernel.org>, <admin@hifiphile.com>,
        <Kavyasree.Kotagiri@microchip.com>, <Tudor.Ambarus@microchip.com>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-spi@vger.kernel.org>,
        <linux-serial@vger.kernel.org>, <linux-clk@vger.kernel.org>
Subject: Re: [PATCH v2 10/13] tty: serial: atmel: Only divide Clock Divisor if
 the IP is USART
Thread-Topic: [PATCH v2 10/13] tty: serial: atmel: Only divide Clock Divisor
 if the IP is USART
Thread-Index: AQHYwfjRXhbMZsrryUK29CT7m7Xt663TsyiAgAADFgA=
Date:   Wed, 7 Sep 2022 09:34:54 +0000
Message-ID: <f07937e5-ee39-9fbe-57ad-e804d2daa3a9@microchip.com>
References: <20220906135511.144725-1-sergiu.moga@microchip.com>
 <20220906135511.144725-11-sergiu.moga@microchip.com>
 <6f7b4eb6-678a-dd4d-4927-31ae309ca49f@linux.intel.com>
In-Reply-To: <6f7b4eb6-678a-dd4d-4927-31ae309ca49f@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e3eae523-a460-4653-3b40-08da90b4388f
x-ms-traffictypediagnostic: BN6PR11MB1810:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ICiy2TkhvKgTOJxuqTSoAFCnl/i+uXG2KQcLl3kpjEx7wu2rwGDL6SPKSlxOpoCAlp7M4Uag+kLZcaAIckgHWdcXZc1pi9Vq5at67KeF6vNXcoFob0UCotKJZdrxSmvqU0k95aRi+rGXSYnjJweImf4kFzgqAtyg8+3yM7R6osq8qxuFg15E8K4x+cOaGAVuTqwM2iQ+DwPrV6+6xXjCHF+bvOkZI1dP0265vn1Rt60nokTHX7RHj6xlpq3MQfgKv7DWJoDgey5p93v092Bdx/Df+T2A7CKMmTe5Nv4iAjWLO1+Ta+41JakNoe9cjveKcAPh7kvZPDLgTjpS8MyjhsgTNNGSI2AOtBVlYK6gpB0sbGnn7+6l163spZ532zezd1SHaQHfeGKWqtnw9RQrpZbAe6nhKbsUW/7RzzlqVYBDDOwQP4iQCq4QZh5luUaGdrSm8cWPUfbO3v4307y2/VTx+9mKL4CyQbWSkuPW7Lg8Wo8FAjXjuNjjpbU10xT13UrW3bMgXbBNxAUKlSBmg8/h4Ld6MBWW0Lq4PqODXatnbErpSENuMDNnoF3Zg06sOkq/3WY42pZJqek06Rprt2NtkOv1GPbVnmiVQwE2Lc76jsCGqADsJ8azdYFBdTHOKbspKDQxi05z9hXL2AjjJLw/mzg/5Lv7NNQ6rJQH5f1gqUshE+BqvCH9lwHWHD1gqrxXEcUr4RkKOwU8JFSMbkBQjPJRdCJf19UpJTYymirgR/XxzIWNecdScRpvDiWmmIlvr5LmaGAoxUQt97lFgVxdA5JnCUnxSNowua6oqt0=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB2758.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(376002)(366004)(39860400002)(396003)(136003)(346002)(6512007)(53546011)(41300700001)(66574015)(6506007)(26005)(186003)(83380400001)(31686004)(478600001)(6486002)(36756003)(71200400001)(7416002)(66556008)(66946007)(8936002)(5660300002)(76116006)(38070700005)(2906002)(6916009)(122000001)(31696002)(2616005)(86362001)(66476007)(91956017)(4326008)(54906003)(8676002)(38100700002)(64756008)(66446008)(316002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZytTT1ZGdGFJalBkR3NiNTlWUERWQkE0WUZUQUZOYVo4dEM1UU1abG4xNUVT?=
 =?utf-8?B?Tmt5anBDVHZma1gvNmdibFZ2TEtMWlR5Tk1oNlNtWmxTbGZWckJuWFc1UUNy?=
 =?utf-8?B?NUU0S3czaUtQeGZlMzBOSUNodTFlbnMyWWIybjhZTERma2NzMStKb2VxdGRp?=
 =?utf-8?B?QWRmR1dRSFptc1RLdXkvUGVNanJNb3NVYVZ0V2IwU1FSRUdOWGJweEp6Z29E?=
 =?utf-8?B?cElKS3hBQW1ycnRDck9hVThPbVlCc1QvMEx1Q2hWYlA0OVpwNlNlUHc2Ui9T?=
 =?utf-8?B?K3M4U3lXWmtYS0xpYVVzUXdFWWV6RlZZRHBWVTR2UXcvejhhUCtwSVY2cGtw?=
 =?utf-8?B?em9rVVo5OUt3QTZFQjZKaU5SNWFVZHZkQi9BZCtuRTBrajZubVhXSjdnY3F4?=
 =?utf-8?B?UzAvV3N5LzhnaVdzYXBBQmZQVDNnNjhsTENhYVovWWo2SEl5dFFxTE9TOG45?=
 =?utf-8?B?a3Y3QUd3VHh6dDVmVkRKYzZ1NHo0R3J2OW9odG9YbEFRcmpjOWlsb2NrbEQ1?=
 =?utf-8?B?U21iWDRBR1VGS3dRa05VR2pCb1UzWEhIZHA4MEZYamkrOU5Sb21HUGV0VzhV?=
 =?utf-8?B?SmlHLzZXYTR4enVrNXBVZjdGamNqSlgrQ09pRHNwanVRVEZhSTZHaGlsQ1dp?=
 =?utf-8?B?dXh1NTNzL0hGQm13dmkxZ1hsMGhLZ0crVHlscHNlVHpVY0RzWWZEd283UENJ?=
 =?utf-8?B?T2trb3d4T0ZWMWs5NmE5NU5selhyZDNYdHI4VmJEV1BJSFJjYXVGRlg5S0w3?=
 =?utf-8?B?WENRVTdVQ2dlODhaazlvVHV6QnZCRkNJc1ZsNHhQZ0VmR04yWXF2SGw1UmVV?=
 =?utf-8?B?aXRxVHQ3TzlxQ1lFajM5SFdNblBNWWUvVWpDLzFHL3BBeHl4NkhrcVp2QlZD?=
 =?utf-8?B?WjFUMGxMeWxaMUg1Y0l2WFlVRUtqUUNzaHQ5RVc2b3pMYWNoWmI1cjRLZUdq?=
 =?utf-8?B?d053NXNhVjhtbXZPem01d0NEeW5GRWFOQklRQ2lKbzJyQVc1d01yWjF6U3Yx?=
 =?utf-8?B?TWt6WlZYeGRLQUkrelErZkpmUi80TGNEbXM1cVgrcjFwdndFeVJ5RFdrTDZl?=
 =?utf-8?B?K2EzK21sUW9pWkkxdXZldXZYT29OMUcvbEdRTWZOTlpBLzNocTBBRDZMWTc0?=
 =?utf-8?B?QmtVa1ErV045cWdhVGdZc2o2dENlbWxTTjJtSjZJMDA5d3AxRTdHVkttWG1L?=
 =?utf-8?B?TzA2bnF2WkJtQ3NsWWF1cWhHVXNTalUzekgrL3RheG5VcVJ3L1RnWkNTV282?=
 =?utf-8?B?SlFka3EyN2Y0dHRnaVI2QjlDdkZZSTNLQ0JQOTJsbDZla1JudnJGNXBQS2J2?=
 =?utf-8?B?MDRacmpRSDB1YnhMSVd0Y1Q2SXkxWVlGa09oNGcwOXVpMS9IMlNVTk5KKzJ3?=
 =?utf-8?B?cWN3ai92c01hdUZyWC9FdmVlZ1ZQaFRsK3c1a2ZLV29lY2orWGlMaFpJNkox?=
 =?utf-8?B?Zll2ejYwbE5MMzQ5dFVRSFhJTzdLMzljeUxlMGh2TEhqdnREMGNjd0Y2NTN3?=
 =?utf-8?B?dVJwdDRWdnl1ZnlNRmhaQ2liNkJicDFqc1U5RFppa0hoNnd3dU9pajhuZWY3?=
 =?utf-8?B?N3cvU3BIZitxL3oxc3BwVHdKaDhYbDNCOGF1RWhDVld6T0NpbFBXWHF0MUIx?=
 =?utf-8?B?VXVTcXJpZ3JxTkF6QmpKaUkxYU9zQyszRGQzMlgrOGYra3lYRzdYOThsUnpi?=
 =?utf-8?B?WVNkN1IvdTYvVGlnd1Q0RlF1cStUbWh1WHJDMWczVWIyMmU0OFZWekdUeTNo?=
 =?utf-8?B?eHR1TlU1QU9SQWlZZ1g2K01mcWd0djZoemRpYzd3L090UlI1RFNqYUNXRTNv?=
 =?utf-8?B?NGVZaWtKOVlmQmRZbTNOUE83TGFEVDRPVkd2R3RnN3ZWWStpUG1JWkY3aExG?=
 =?utf-8?B?TXJqN3JNSVdQb1VZLzZHOUVvYTlNQUF2dFdpczZPM3EyU1p0cSsxQmdBVEd2?=
 =?utf-8?B?U3NmZXBkdHRhTW10d1lWRTRtd1FzejlkVFJHOXVOc2FPWkRQeUxnZXg4Wkh4?=
 =?utf-8?B?ZUtBZHFvdWdQdXZoQVk3WGRhTTNpVVZRdERMRTZwVTJUbC9WS1RGTnhNZHdK?=
 =?utf-8?B?N1VVaDRUdW9CRmhmb1lSdHRGTXR5N3BZUjBDSDdidUpCazRrb2UrQUtScFNp?=
 =?utf-8?Q?AOZFQ7uJUYQubj/ISn5QoZapl?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <606817D342AD1D48B0EDF088942A4CB3@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB2758.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e3eae523-a460-4653-3b40-08da90b4388f
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Sep 2022 09:34:54.3614
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JpK/wLJ0U3r7zBLfLqPIl5CiF+BEniqtW0v6zENpjNCYb0j62/K+woWglWZCnSqq7YypFPk94U5nVpnBMmXkHWS1EBxe1zG8R0MKHEw4YP4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR11MB1810
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMDcuMDkuMjAyMiAxMjoyMywgSWxwbyBKw6RydmluZW4gd3JvdGU6DQo+IE9uIFR1ZSwgNiBT
ZXAgMjAyMiwgU2VyZ2l1IE1vZ2Egd3JvdGU6DQo+IA0KPj4gTWFrZSBzdXJlIHRoYXQgdGhlIGRy
aXZlciBvbmx5IGRpdmlkZXMgdGhlIGNsb2NrIGRpdmlzb3IgaWYgdGhlDQo+PiBJUCBoYW5kbGVk
IGF0IHRoYXQgcG9pbnQgaXMgVVNBUlQsIHNpbmNlIFVBUlQgSVAncyBkbyBub3Qgc3VwcG9ydA0K
Pj4gaW1wbGljaXQgcGVyaXBoZXJhbCBjbG9jayBkaXZpc2lvbi4gSW5zdGVhZCwgaW4gdGhlIGNh
c2Ugb2YgVUFSVCwNCj4+IGdvIHdpdGggdGhlIGhpZ2hlc3QgcG9zc2libGUgY2xvY2sgZGl2aXNv
ci4NCj4+DQo+PiBTaWduZWQtb2ZmLWJ5OiBTZXJnaXUgTW9nYSA8c2VyZ2l1Lm1vZ2FAbWljcm9j
aGlwLmNvbT4NCj4+IC0tLQ0KPj4NCj4+DQo+PiB2MSAtPiB2MjoNCj4+IC0gTm90aGluZywgdGhp
cyBwYXRjaCB3YXMgbm90IGhlcmUgYmVmb3JlIGFuZCBpcyBtYWlubHkgbWVhbnQgYXMgYm90aCBj
bGVhbnVwDQo+PiBhbmQgYXMgYSB3YXkgdG8gaW50cm9kdWNlIGEgbmV3IGZpZWxkIGludG8gc3Ry
dWN0IGF0bWVsX3VhcnRfcG9ydCB0aGF0IHdpbGwgYmUNCj4+IHVzZWQgYnkgdGhlIGxhc3QgcGF0
Y2ggdG8gZGlmZXJlbnRpYXRlIGJldHdlZW4gVVNBUlQgYW5kIFVBUlQgcmVnYXJkaW5nIHRoZQ0K
Pj4gbG9jYXRpb24gb2YgdGhlIEJhdWRyYXRlIENsb2NrIFNvdXJjZSBiaXRtYXNrLg0KPj4NCj4+
DQo+Pg0KPj4NCj4+ICAgZHJpdmVycy90dHkvc2VyaWFsL2F0bWVsX3NlcmlhbC5jIHwgMTMgKysr
KysrKysrKysrLQ0KPj4gICAxIGZpbGUgY2hhbmdlZCwgMTIgaW5zZXJ0aW9ucygrKSwgMSBkZWxl
dGlvbigtKQ0KPj4NCj4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3R0eS9zZXJpYWwvYXRtZWxfc2Vy
aWFsLmMgYi9kcml2ZXJzL3R0eS9zZXJpYWwvYXRtZWxfc2VyaWFsLmMNCj4+IGluZGV4IDc0NTBk
Mzg1MzAzMS4uNmFhMDFjYTU0ODljIDEwMDY0NA0KPj4gLS0tIGEvZHJpdmVycy90dHkvc2VyaWFs
L2F0bWVsX3NlcmlhbC5jDQo+PiArKysgYi9kcml2ZXJzL3R0eS9zZXJpYWwvYXRtZWxfc2VyaWFs
LmMNCj4+IEBAIC0xNTAsNiArMTUwLDcgQEAgc3RydWN0IGF0bWVsX3VhcnRfcG9ydCB7DQo+PiAg
ICAgICAgdTMyICAgICAgICAgICAgICAgICAgICAgcnRzX2xvdzsNCj4+ICAgICAgICBib29sICAg
ICAgICAgICAgICAgICAgICBtc19pcnFfZW5hYmxlZDsNCj4+ICAgICAgICB1MzIgICAgICAgICAg
ICAgICAgICAgICBydG9yOyAgIC8qIGFkZHJlc3Mgb2YgcmVjZWl2ZXIgdGltZW91dCByZWdpc3Rl
ciBpZiBpdCBleGlzdHMgKi8NCj4+ICsgICAgIGJvb2wgICAgICAgICAgICAgICAgICAgIGlzX3Vz
YXJ0Ow0KPj4gICAgICAgIGJvb2wgICAgICAgICAgICAgICAgICAgIGhhc19mcmFjX2JhdWRyYXRl
Ow0KPj4gICAgICAgIGJvb2wgICAgICAgICAgICAgICAgICAgIGhhc19od190aW1lcjsNCj4+ICAg
ICAgICBzdHJ1Y3QgdGltZXJfbGlzdCAgICAgICB1YXJ0X3RpbWVyOw0KPj4gQEAgLTE4MjUsNiAr
MTgyNiw3IEBAIHN0YXRpYyB2b2lkIGF0bWVsX2dldF9pcF9uYW1lKHN0cnVjdCB1YXJ0X3BvcnQg
KnBvcnQpDQo+PiAgICAgICAgICovDQo+PiAgICAgICAgYXRtZWxfcG9ydC0+aGFzX2ZyYWNfYmF1
ZHJhdGUgPSBmYWxzZTsNCj4+ICAgICAgICBhdG1lbF9wb3J0LT5oYXNfaHdfdGltZXIgPSBmYWxz
ZTsNCj4+ICsgICAgIGF0bWVsX3BvcnQtPmlzX3VzYXJ0ID0gZmFsc2U7DQo+Pg0KPj4gICAgICAg
IGlmIChuYW1lID09IG5ld191YXJ0KSB7DQo+PiAgICAgICAgICAgICAgICBkZXZfZGJnKHBvcnQt
PmRldiwgIlVhcnQgd2l0aCBodyB0aW1lciIpOw0KPj4gQEAgLTE4MzQsNiArMTgzNiw3IEBAIHN0
YXRpYyB2b2lkIGF0bWVsX2dldF9pcF9uYW1lKHN0cnVjdCB1YXJ0X3BvcnQgKnBvcnQpDQo+PiAg
ICAgICAgICAgICAgICBkZXZfZGJnKHBvcnQtPmRldiwgIlVzYXJ0XG4iKTsNCj4+ICAgICAgICAg
ICAgICAgIGF0bWVsX3BvcnQtPmhhc19mcmFjX2JhdWRyYXRlID0gdHJ1ZTsNCj4+ICAgICAgICAg
ICAgICAgIGF0bWVsX3BvcnQtPmhhc19od190aW1lciA9IHRydWU7DQo+PiArICAgICAgICAgICAg
IGF0bWVsX3BvcnQtPmlzX3VzYXJ0ID0gdHJ1ZTsNCj4+ICAgICAgICAgICAgICAgIGF0bWVsX3Bv
cnQtPnJ0b3IgPSBBVE1FTF9VU19SVE9SOw0KPj4gICAgICAgICAgICAgICAgdmVyc2lvbiA9IGF0
bWVsX3VhcnRfcmVhZGwocG9ydCwgQVRNRUxfVVNfVkVSU0lPTik7DQo+PiAgICAgICAgICAgICAg
ICBzd2l0Y2ggKHZlcnNpb24pIHsNCj4+IEBAIC0xODYzLDYgKzE4NjYsNyBAQCBzdGF0aWMgdm9p
ZCBhdG1lbF9nZXRfaXBfbmFtZShzdHJ1Y3QgdWFydF9wb3J0ICpwb3J0KQ0KPj4gICAgICAgICAg
ICAgICAgICAgICAgICBkZXZfZGJnKHBvcnQtPmRldiwgIlRoaXMgdmVyc2lvbiBpcyB1c2FydFxu
Iik7DQo+PiAgICAgICAgICAgICAgICAgICAgICAgIGF0bWVsX3BvcnQtPmhhc19mcmFjX2JhdWRy
YXRlID0gdHJ1ZTsNCj4+ICAgICAgICAgICAgICAgICAgICAgICAgYXRtZWxfcG9ydC0+aGFzX2h3
X3RpbWVyID0gdHJ1ZTsNCj4+ICsgICAgICAgICAgICAgICAgICAgICBhdG1lbF9wb3J0LT5pc191
c2FydCA9IHRydWU7DQo+PiAgICAgICAgICAgICAgICAgICAgICAgIGF0bWVsX3BvcnQtPnJ0b3Ig
PSBBVE1FTF9VU19SVE9SOw0KPj4gICAgICAgICAgICAgICAgICAgICAgICBicmVhazsNCj4+ICAg
ICAgICAgICAgICAgIGNhc2UgMHgyMDM6DQo+PiBAQCAtMjI4MiwxMCArMjI4NiwxNyBAQCBzdGF0
aWMgdm9pZCBhdG1lbF9zZXRfdGVybWlvcyhzdHJ1Y3QgdWFydF9wb3J0ICpwb3J0LCBzdHJ1Y3Qg
a3Rlcm1pb3MgKnRlcm1pb3MsDQo+PiAgICAgICAgICAgICAgICBjZCA9IHVhcnRfZ2V0X2Rpdmlz
b3IocG9ydCwgYmF1ZCk7DQo+PiAgICAgICAgfQ0KPj4NCj4+IC0gICAgIGlmIChjZCA+IDY1NTM1
KSB7ICAgICAgIC8qIEJSR1IgaXMgMTYtYml0LCBzbyBzd2l0Y2ggdG8gc2xvd2VyIGNsb2NrICov
DQo+PiArICAgICAvKg0KPj4gKyAgICAgICogQlJHUiBpcyAxNi1iaXQsIHNvIHN3aXRjaCB0byBz
bG93ZXIgY2xvY2suDQo+PiArICAgICAgKiBPdGhlcndpc2UsIGtlZXAgdGhlIGhpZ2hlc3QgcG9z
c2libGUgdmFsdWUgZm9yIHRoZSBjbG9jayBkaXZpc29yLg0KPj4gKyAgICAgICovDQo+PiArICAg
ICBpZiAoYXRtZWxfcG9ydC0+aXNfdXNhcnQgJiYgY2QgPiA2NTUzNSkgew0KPiANCj4gU2hvdWxk
IHRoaXMgYmUgY2QgPiBBVE1FTF9VU19DRCA/DQo+IA0KPj4gICAgICAgICAgICAgICAgY2QgLz0g
ODsNCj4+ICAgICAgICAgICAgICAgIG1vZGUgfD0gQVRNRUxfVVNfVVNDTEtTX01DS19ESVY4Ow0K
Pj4gKyAgICAgfSBlbHNlIHsNCj4+ICsgICAgICAgICAgICAgY2QgJj0gNjU1MzU7DQo+IA0KPiBB
VE1FTF9VU19DRD8NCg0KDQpZZXMsIGl0IHdvdWxkIHNlZW0gdGhhdCB3b3VsZCBiZSByaWdodC4g
SXQgZGlkIG5vdCBjcm9zcyBteSBtaW5kIHRvIA0KY2hlY2sgd2hldGhlciB0aGVyZSBhbHJlYWR5
IHdhcyBzb21ldGhpbmcgcHJlLWRlZmluZWQgb3Igbm90IHNpbmNlIHRoZSANCmNvZGUgYWxzbyBw
cmV2aW91c2x5IHVzZWQgNjU1MzUuDQoNCj4gDQo+PiAgICAgICAgfQ0KPj4gKw0KPj4gICAgICAg
IHF1b3QgPSBjZCB8IGZwIDw8IEFUTUVMX1VTX0ZQX09GRlNFVDsNCj4+DQo+PiAgICAgICAgaWYg
KCEocG9ydC0+aXNvNzgxNi5mbGFncyAmIFNFUl9JU083ODE2X0VOQUJMRUQpKQ0KPj4NCj4gDQo+
IC0tDQo+ICAgaS4NCj4gDQoNCg0KVGhhbmtzLA0KCVNlcmdpdQ0K
