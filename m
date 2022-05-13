Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E051525F4B
	for <lists+linux-kernel@lfdr.de>; Fri, 13 May 2022 12:08:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379299AbiEMKGl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 May 2022 06:06:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230453AbiEMKGj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 May 2022 06:06:39 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF1726160F;
        Fri, 13 May 2022 03:06:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1652436397; x=1683972397;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=9hL5NVtq0WTSzwsOF7mJk9ciEbZ7dyr3kKquOVpMT1g=;
  b=IGHNRuec33cl+RqpDbFD5uVtjNWBKfM87r3VBoltALo6nA+dlv4PNMC7
   5AxKir6V8QpdUT/VKyhj77u8heBxYsNavo1QT2BK6u1zIYTbsNe8hSG3s
   gC1OwNBTw02uv8f+tSAFL2bbRibwbH2D58qg6ksZ3GmqT+flRvoRKDySh
   QiSMY1zNI0bJuqcOQfCfOoauuDxhBwIFEKLQxetBYKwy8c5J9UcdXdSCF
   OMg+Uq64I7/cxvsXiGRsQbCFQa0KxXZrJBhS5xPzguytV2pqfNqQXjyjy
   15ML3M/HgXBXcniFGdE4BTVEH9x7dlks9dlABy4ezKFWQkf57+o+464s+
   w==;
X-IronPort-AV: E=Sophos;i="5.91,221,1647327600"; 
   d="scan'208";a="155930495"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 13 May 2022 03:06:36 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Fri, 13 May 2022 03:06:35 -0700
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17 via Frontend
 Transport; Fri, 13 May 2022 03:06:35 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Rpo1MDinmVPA1R38Bk9UOUb5AS9kVDw869Rxk1ZNgL7Ly8XJoK3npstuXUY3orreUDBXtvOWjELZTI7SKpGmC2LEd5MixdIAUZ44EHIm2OX9oIdUlPOsjlI07x0NLqmGEZxWSbnqP65TMPQoGvIOHpK8qPFqVTnGMoFw+TLxW6anQ0+Xcx+ghhw95lyLIqpxz6EjiVP9KwawscL8ikFC3ufnpYGy2ml0FmRHVhr3VtIJ83TO6xH1X5aUeLf1rPHgUcKyNQMXlKZWwxahT9cr3vRSKPZwbuknFQ0uBvXelgVZWs1A9IwxBGorYoX2DnWUB55BvxDQr5eMHcAX0Zs/Fg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9hL5NVtq0WTSzwsOF7mJk9ciEbZ7dyr3kKquOVpMT1g=;
 b=nW46UOFqzw+XWEQd1j5e29tMHxksrJ467OQHlbs1bNlgllQ9epHpcuEvp7XEaWzhotK0BDxOyyQRRe/g5onfo48r9HtBT8TPny5z5oVPP3lj1Pn4SJ4akQUYvVfOt6YiycecVfB+r6eAv5JMZ9AeSnaPEKFHQQwxi9mIJYukVR5/ykpYl212+X4MjhI2PgGmMLyxtTiYjRZzBWP69Y22ZUYR3iWEnT/knWZp2pMq8s1XlY+c6JPAbFj9DWDjsjx5zFyeF1e0Zyb2q91ktluWVUZo8Pt48hZ0n/uvT35Ii2lRbtwrIFvF1KclbphKOQxtY1QBMGagdODfz/vxCxJr6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9hL5NVtq0WTSzwsOF7mJk9ciEbZ7dyr3kKquOVpMT1g=;
 b=AeNXXoNzEZssnOYW60fJlZXaI6o9DOMgexnfO0pnW0cI9xj2hnQuYuVpqaJWzyPbE8+HhXGxpG1uBnj2TpC8bIVsaGCWXXdKeHr/FA363Nm2lV9fk/kMqKyAD3u+grY6gDcAIwA9AcKAhUb3X1NmJv4sLPmmCf8gKdnApCFrL6s=
Received: from CO1PR11MB4769.namprd11.prod.outlook.com (2603:10b6:303:95::10)
 by BYAPR11MB2694.namprd11.prod.outlook.com (2603:10b6:a02:c7::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.23; Fri, 13 May
 2022 10:06:33 +0000
Received: from CO1PR11MB4769.namprd11.prod.outlook.com
 ([fe80::e906:3e8d:4741:c0f0]) by CO1PR11MB4769.namprd11.prod.outlook.com
 ([fe80::e906:3e8d:4741:c0f0%6]) with mapi id 15.20.5250.015; Fri, 13 May 2022
 10:06:32 +0000
From:   <Claudiu.Beznea@microchip.com>
To:     <krzysztof.kozlowski@linaro.org>, <srinivas.kandagatla@linaro.org>,
        <robh+dt@kernel.org>, <krzk+dt@kernel.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/2] dt-bindings: microchip-otpc: document Microchip OTPC
Thread-Topic: [PATCH 1/2] dt-bindings: microchip-otpc: document Microchip OTPC
Thread-Index: AQHYZdBf287PvcEoQUmQslcb1o7LPQ==
Date:   Fri, 13 May 2022 10:06:32 +0000
Message-ID: <f016d03c-54db-d983-1634-da9215db011f@microchip.com>
References: <20220510094457.4070764-1-claudiu.beznea@microchip.com>
 <20220510094457.4070764-2-claudiu.beznea@microchip.com>
 <75ce6291-77c7-c932-e8bb-a8bbae02431d@linaro.org>
 <c840c598-0413-5f40-0807-e3c314531f0a@microchip.com>
 <b5c586de-a3ae-0774-e0bf-e21852b65fa9@linaro.org>
 <59b47f0b-6201-3814-e17f-1435ce5c2dad@microchip.com>
 <6ce3c0b1-3f6a-24f6-bcf2-4d4125a97604@linaro.org>
 <706eb7b4-07ce-ffd2-3366-5656ddba21d6@microchip.com>
 <04a95089-cd39-2628-f333-0da24e55a967@linaro.org>
In-Reply-To: <04a95089-cd39-2628-f333-0da24e55a967@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: bd036275-a9e8-4e6d-3db1-08da34c841d3
x-ms-traffictypediagnostic: BYAPR11MB2694:EE_
x-microsoft-antispam-prvs: <BYAPR11MB2694081D48DE8B2DCC30866787CA9@BYAPR11MB2694.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: JfWCDIQI8aZX6NBbEle4futGtdiQ55SW3WbxLxF5Bc+edZy9dQF3RSk9HpNva/4TE0Cnxo0M4SsFK+qHRF6l+MMuOB8ZqPUiMBhcVbo2rvcUvpqCAts6tTVmkKJMfLlh5ahMlLbQDMGuHZ9x2O+qrCQKD2Uh3269jM4T/Ni+o+lwAUKpCQvvozoMWdRW+tWD4RkjbWCfqRsYKSYTPo+lw8m+JkuuVgqtE1RADvKpM7QBcVYfKpWVSAZpMkfMk1iTYKAzNKJtz4W9fE1wDF81pCZ4VJkClCEV3Zux+b4jD640S9njp4qd0exQdVWDxLVd0hWrFpSnzaXKPTN5SqU2We+d48v6cFNyJmiWZziHz9r8r0cztnhMjmNIAr2OfZez/RUIJlaVuOdZyHLzA8rYYva+q2rYzFQ1F0sJwdFrLmU3jJWgXucM9UiPRfbaAY4M007E8xxFc1mIYn9ttakdZ8JictHpihk3mdMXdoeVoUTY5BXezZh0ZtzbjpOvADoI6pILdH3tC0V0p3gnL6ovl7LD0VYz7tRS68j25dIfhqIHJrJUWQ3uWcqjSgGZX0hYhi9qDDLSx+sADpjMoXlYnuEuaFK04CeYjHYvA7vWNx22bHTCe9vEEmNK/uRxDdMccoHiaS/3fxjJhwPbh7BBPKt38+J/tA0YVNcYURo9fY78d1z2wtFGnxt2dCqgFyW/rCdIOkQH0cu+P1H7BQn22J5An8algf4xA2eqHWnyZgD6Y8PeZSIZpW0d6HlPUiE3RQ9/0lZGC+3V6FII9cgbiA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB4769.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(91956017)(2616005)(66446008)(508600001)(66476007)(66946007)(66556008)(64756008)(76116006)(8676002)(83380400001)(4326008)(186003)(6486002)(26005)(6512007)(86362001)(71200400001)(316002)(54906003)(53546011)(110136005)(6506007)(31686004)(31696002)(122000001)(8936002)(36756003)(2906002)(5660300002)(38070700005)(38100700002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MTBSZkxORjJWNVl0NHk1c3hZUS9vNHRNeFNMS3JreEVGa1Y0WG9CNmltajZu?=
 =?utf-8?B?RHJjR2R3anVhY3IwaHZ2UkUwWEcySlVrNUtwWUl0b2VwZGZoUGJXdjBwYjVE?=
 =?utf-8?B?NG51enJtNnJhUnMxTFA0SXV2WjZmL05MSU1OUDNuRmprYzBmSTNCMlNNU2s3?=
 =?utf-8?B?T0UyRTFmZWlycTNmajVIemhJK1hTV0Qxc3VFdVA0L25qQmJGTXpxT2Rrc2Vh?=
 =?utf-8?B?WEplSzkxd3ZLZEFicGE2V1FON3RJbCtvQ01hQzJ3SlZiV3VZbllZditjelBl?=
 =?utf-8?B?eCtjYUtEM1NjQW80U1RWV1dpZXdMYlBhOG8zZHVZNkNxTDJKYWVCaFE3V3BL?=
 =?utf-8?B?b0hWVS85NVFSTndwV21kamtPTHcrL3FQbjhkRjRDVjVjYlJtNjU2cXlaMHRF?=
 =?utf-8?B?Nno1dWVBR0FiVVFibTlxWTI3ZWFiWmZ4bXZ6ZTFqS2NuNnNCWlkzc2lmK29v?=
 =?utf-8?B?c0VRNG41bTcvNjBIRVQ3aW1odWVoeGNPUmo0TnZGVk1LSUVDbkZ6S1JtVkYr?=
 =?utf-8?B?OUdNbVNEMXJ5U0dKNEJsVnZhTCt4azdKc1ZMRmVCKytNQzhoQzMwcWpLeCt4?=
 =?utf-8?B?R0NLRnpJU0s4U3hiSzhEenNoc2wwNW1xMkZ3SFc1emZBWjUzZzdWY21Udytk?=
 =?utf-8?B?NnNNVzVlbHlYNmJNSlAwdERqaEo1VitSVnFVaDYvV3BYWjFSVzZ0ZERhRG1z?=
 =?utf-8?B?MFc1NklZalRaK2w5ZmQ4Ym0yOUNtSS9mZUJDS1ZFVGt0N3lNUlpaTCtnMmhT?=
 =?utf-8?B?SHluQUZZR2gxdTVqQ0xOZG10UTNNUEdjWUc2SExDbjNjYUhsNC9oWnBleXZP?=
 =?utf-8?B?dmlid05ZNStrRTh5ZE9vcmg4SG5sK0doU1Fjc3FZallqRGxScUZoV1pydVJq?=
 =?utf-8?B?Qk5Ec3ViVGZGRlRJQ291N2VidTRYYWxJQXY1U0NoQU1lbnozbDJJNVVWZFE5?=
 =?utf-8?B?VXBxTDhsTmxwOHFpRGVsdm1LbHdIbHVWSk96QllaOUt3R0lmdjlyUW9jMCtk?=
 =?utf-8?B?THJJMHJmK3ZJQUFCMnBTZEViUlRBWmRndWYvK293aWVsVEo4eEJLUFBoRnRV?=
 =?utf-8?B?VEozbEJOTFFSVUR6MnhDa0FkSDNSMU9aTzJRZnFrRS9TOVZEc3VURmhILy95?=
 =?utf-8?B?aUMzT0thaEpvYTVuU21Tc3BzME5WcWdSSnI5d044UFFCLzRsM2dhSFJPRFBp?=
 =?utf-8?B?RU1mQ2lJSVRZYThkK1ROYUZaTFhBeU1tUkRYMWVsOFdLVHJQVDNKd25qTGwx?=
 =?utf-8?B?N1kzeXRXUTY4ei9qOUk2eTh4VHF3VE1zUzN4RzNOZlZYajU0eUV6MUZralVw?=
 =?utf-8?B?WXhrWWNzT2VSTmRQdWFIYXhGRFlmUlVucTFRWFd1cVBGa3lsdDZtaTV6bkJV?=
 =?utf-8?B?RFo2S2MxYjQwYkk4UUtkVnFrYXQ3T0ZwUGVHRGRDVG5jVDY1YU44dzBLQVI5?=
 =?utf-8?B?Tkg3U3N0VXA0MTBBQ3JTcUhaSnJkeEpIVm1DTVQyN0gvZDk3Y1E4REFkNHdZ?=
 =?utf-8?B?OFB1bGNlRlpBQ2FESkhkNEVkeVhxZHdNUkFvWmpGVUc5MG9WdjRiMmR6Nmc3?=
 =?utf-8?B?WmluakF5ckNKQzNKRlFVQXpjb1d1VzRDYXN4c25WdU9iY0ZGRTBGdHo4UGI0?=
 =?utf-8?B?b2t2UzcvR3RqTGMxNWdwcjN4REQrQ2NSZDZmdS9vMWM0T3RJREtkRTZ3R2dQ?=
 =?utf-8?B?OEswVE9ZdmlQeE5FWC9XZllweTNJem9FU0JVNjdEc1JKTGt0T1QyQkpBMDdN?=
 =?utf-8?B?Y1dIaVBMSU11R0RJejV5WWR5Rk1xbWk1cWZ3dU1MMXRIQS9BRlU3amsyNFdS?=
 =?utf-8?B?MDBYaklWcFViSzQ3aWtrWERHODAxM0pSM2NvblpWSUF4Wm1yZWtBMERZbVNX?=
 =?utf-8?B?dU05RFp3TW4ya1NTZkNMc3loY08rRlBvcmlSd0c2VGlsczMxYWRlSW4waFpz?=
 =?utf-8?B?a29DUmR0ZTlUbU5qcWdaRUxPRmpveU41RnF6bkV5NkpHeE5OTEh3WUIzdnBy?=
 =?utf-8?B?bUFEQ1JoT25GQW04cDdRTWRLOUowTnVoa0tOUm40UndraVBLd25tWGg0eUNk?=
 =?utf-8?B?L2FKTXo1bVdqQXdPaEZLNXFKK2svbW1rTUtFK01jU1Z5RGFqa2pvVkZjeXky?=
 =?utf-8?B?OGNscFhHNkdrc2NBTVk5Vm5CZjhFRjBCMUJlaDMrWHJuZU9kSHVZVmFubElh?=
 =?utf-8?B?Y1NRUjFtejgvTndLUmowbFZ0SW1aVUJMVWRVeHBPUVA2cWYxaUVNQkozSjZW?=
 =?utf-8?B?azIzUUtjTXJ3VHF3UWZPUGJDWkFSeHRCVmpDODVWc2ducVNLSS9EamFrbjZQ?=
 =?utf-8?B?N0drNXFJYUNnT051dmRkaDY4RjJpamRRVkhxQTlsRnlUUjBPdWRwVEloYzRF?=
 =?utf-8?Q?8dxTHFsRPAsxHts8=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C86FFBB4D80C20469D167DF8CFF6441B@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB4769.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bd036275-a9e8-4e6d-3db1-08da34c841d3
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 May 2022 10:06:32.8500
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: riMulexLbj1ZaLtN3Qikz1aMLH9F+U6Z1K/33iF+1Fgh4ev23vk9I2cvV7rj11m915mryTueiaGWZn4b89wibC60oo7DaYafyZYK9w/guMk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR11MB2694
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMTMuMDUuMjAyMiAxMDo0OSwgS3J6eXN6dG9mIEtvemxvd3NraSB3cm90ZToNCj4gRVhURVJO
QUwgRU1BSUw6IERvIG5vdCBjbGljayBsaW5rcyBvciBvcGVuIGF0dGFjaG1lbnRzIHVubGVzcyB5
b3Uga25vdyB0aGUgY29udGVudCBpcyBzYWZlDQo+IA0KPiBPbiAxMi8wNS8yMDIyIDE4OjA0LCBD
bGF1ZGl1LkJlem5lYUBtaWNyb2NoaXAuY29tIHdyb3RlOg0KPj4gT24gMTIuMDUuMjAyMiAxODoz
NSwgS3J6eXN6dG9mIEtvemxvd3NraSB3cm90ZToNCj4+PiBFWFRFUk5BTCBFTUFJTDogRG8gbm90
IGNsaWNrIGxpbmtzIG9yIG9wZW4gYXR0YWNobWVudHMgdW5sZXNzIHlvdSBrbm93IHRoZSBjb250
ZW50IGlzIHNhZmUNCj4+Pg0KPj4+IE9uIDEyLzA1LzIwMjIgMTc6MzEsIENsYXVkaXUuQmV6bmVh
QG1pY3JvY2hpcC5jb20gd3JvdGU6DQo+Pj4NCj4+Pj4+DQo+Pj4+PiBNYWNybyBpcyBhIG5pY2Ug
aWRlYSBpZiBpdCBjYW4gYmUgc3RhYmxlLiBJIHVuZGVyc3Rvb2QgdGhhdCBsZW5ndGggb2YNCj4+
Pj4+IHBhY2tldHMgZGVwZW5kcyBvbiBoYXJkd2FyZSwgc28gdGhpcyBwYXJ0IGNvdWxkIGJlIHN0
YWJsZS4gQnV0IHdoYXQNCj4+Pj4+IGFib3V0IG51bWJlciBvZiBwYWNrZXRzLCBzbyB0aGUgT1RQ
X1BLVF9TQU1BN0c1X1RFTVBfQ0FMSUJfTEVOIGJlbG93Pw0KPj4+Pg0KPj4+PiBUaGUgT1RQX1BL
VF9TQU1BN0c1X1RFTVBfQ0FMSUJfTEVOIGhlcmUgaXMgdGhlIGxlbmd0aCBvZiB0aGVybWFsDQo+
Pj4+IGNhbGlicmF0aW9uIHBhY2tldC4gVGhpcyBsZW5ndGggaXMgZml4ZWQgYW5kIHdpbGwgbm90
IGJlIGNoYW5nZWQuDQo+Pj4+DQo+Pj4+IEFmdGVyIHRoZXNlIDIgcGFja2V0cyAocHJvdmlkZWQg
YnkgTWljcm9jaGlwKSB1c2VyIG1heSBmdXJ0aGVyIGZsYXNoIGFueQ0KPj4+PiBudW1iZXIgb2Yg
cGFja2V0cyBhbmQgdXNlIHRoZW0gYXMgdGhleSB3aXNoLg0KPj4+Pg0KPj4+PiBEcml2ZXIgaXMg
aW4gY2hhcmdlIG9mIHNjYW5uaW5nIHRoZSBOVk1FTSBmb3IgdGhlIGF2YWlsYWJsZSBwYWNrZXRz
IGFuZA0KPj4+PiBwcmVwYXJlIGEgbGlzdCB3aXRoIHRoZWlyIElEcyBhbmQgdGhlaXIgc3RhcnRp
bmcgb2Zmc2V0cyBpbiBOVk1FTSBtZW1vcnkNCj4+Pj4gc3VjaCB0aGF0IHdoZW4gaXQgcmVjZWl2
ZXMgYSByZWFkIHJlcXVlc3QgaXQgd2lsbCBiZSBhYmxlIHRvIGRlY29kZSB0aGUNCj4+Pj4gcGFj
a2V0IG9mZnNldCBiYXNlZCBvbiBwYWNrZXQgaWRlbnRpZmllci4NCj4+Pj4NCj4+Pj4gSW4gY2Fz
ZSBkaWZmZXJlbnQgbnVtYmVyIG9mIHBhY2tldHMgYXJlIGF2YWlsYWJsZSBpbiBOVk1FTSBmb3Ig
ZGlmZmVyZW50DQo+Pj4+IGtpbmQgb2Ygc2V0dXBzIChib2FyZHMpIHRoZXNlIGNvdWxkIGFsc28g
YmUgcmVmZXJlbmNlZCBpbiBib2FyZCBzcGVjaWZpYyBEVA0KPj4+PiB1c2luZyBPVFBfUEtUKCkg
bWFjcm8gYW5kIHdpdGggcHJvcGVyIGxlbmd0aCAod2hpY2ggd2lsbCBkZXBlbmQgb24gd2hhdA0K
Pj4+PiB1c2VyIGZsYXNoZWQpLg0KPj4+Pg0KPj4+Pj4gWW91IHdyb3RlICJCb290IGNvbmZpZ3Vy
YXRpb24gcGFja2V0IG1heSB2YXJ5IGluIGxlbmd0aCIsIHNvIGl0IGNvdWxkIGJlDQo+Pj4+PiBj
aGFuZ2VkIGJ5IE1pY3JvY2hpcD8NCj4+Pj4NCj4+Pj4gWWVzLCBiZXR3ZWVuIGNoaXAgcmV2aXNp
b25zIGl0cyBsZW5ndGggY291bGQgYmUgY2hhbmdlZC4NCj4+Pg0KPj4+IENoaXAgcmV2aXNpb25z
IGxpa2UgZGlmZmVyZW50IGJvYXJkIGNvbXBhdGlibGVzIHRodXMgZGlmZmVyZW50DQo+Pj4gYmlu
ZGluZ3MvbWFjcm8gdmFsdWVzPw0KPj4NCj4+IE5vdCBuZWNlc3NhcmlseS4gSXQgbWF5IGhhcHBl
biB0aGF0IG9ubHkgUk9NIGNvZGUgdG8gYmUgdXBkYXRlZCAoMXN0IHN0YWdlDQo+PiBib290bG9h
ZGVyKSBlbmQgZXZlcnl0aGluZyBlbHNlIG9uIExpbnV4IHNpZGUgdG8gYmUgYWJsZSB0byBydW4g
YXMgaXMuIE9yDQo+PiB0byBqdXN0IGZpeCBzb21lIGJ1Z3MgaW4gZGlmZmVyZW50IElQcy4gVGhp
bmdzIHRoYXQgd2lsbCBub3QgbmVjZXNzYXJpbHkNCj4+IG5lZWQgYWRkaW5nIG5ldyBjb21wYXRp
YmxlcyBmb3IgdGhlIG5ldyBjaGlwLiBBbmQgaXQgbWF5IGhhcHBlbiB0aGF0IG5ldw0KPj4gY2hp
cCByZXZpc2lvbnMgdG8gYmUgcG9wdWxhdGVkIG9uIHByZXZpb3VzIGJvYXJkIHJldmlzaW9ucy4N
Cj4+DQo+Pj4gQ2hpcCByZXZpc2lvbnMgbGlrZSBkaWZmZXJlbnQgYm9hcmQgY29tcGF0aWJsZXMg
dGh1cyBkaWZmZXJlbnQNCj4+PiAqbWFjcm8qIHZhbHVlcz8NCj4+DQo+PiBJZiB5b3UncmUgcmVm
ZXJyaW5nIHRvIHRoZSBPVFBfUEtUX1NBTUE3RzVfVEVNUF9DQUxJQl9MRU4gbWFjcm8sIHRoaXMg
aXMNCj4+IGVzdGFibGlzaGVkIHRoYXQgd2lsbCByZW1haW4gZml4ZWQgYi93IHJldmlzaW9ucy4g
VGhpcyBpcyB0aGUgbGVuZ3RoIG9mIHRoZQ0KPj4gMm5kIHBhY2tldCBpbiBOVk1FTSAodGhhdCBp
cyBvZiBpbnRlcmVzdCBmb3IgdGhlcm1hbCBtYW5hZ2VtZW50KS4NCj4+DQo+PiBPbmx5IHRoZSBs
ZW5ndGggb2YgdGhlIDFzdCBwYWNrZXQgbWF5IGNoYW5nZS4gQW5kIGFkZHJlc3NpbmcgdGhlIE5W
TUVNIHdpdGgNCj4+IHBhY2tldCBpZCBiYXNlZCBpbmRleCBzaG91bGQgdGFrZSBjYXJlIG9mIHRl
bXBlcmF0dXJlIGNhbGlicmF0aW9uIE5WTUVNIERUDQo+PiBiaW5kaW5nIHRvIHdvcmsgYWxsIHRo
ZSB0aW1lLg0KPj4NCj4+PiBJZiBub3QsIHRoZW4gbWF5YmUgYmV0dGVyIHNraXAgdGhlIGxlbmd0
aCBvdXQgb2YNCj4+PiBiaW5kaW5ncyBhbmQganVzdCBwcm92aWRlIHRoZSBmaXJzdCBtYWNyby4N
Cj4+DQo+PiBBcyBmYXIgYXMgSSBrbm93IHRoZSBsZW5ndGggaXMgcGFydCBvZiB0aGUgd2F5IHRo
ZSBOVk1FTSBjZWxscyBhcmUNCj4+IGRlc2NyaWJlZCBpbiBEVDogaXQgbmVlZHMgdGhlIG9mZnNl
dCBpbiBtZW1vcnkgKGZvciB0aGUgZGF0YSB0byBiZQ0KPj4gcmV0cmlldmVkKSBhbmQgaXRzIGxl
bmd0aC4NCj4gDQo+IEluIERUIHllcywgYnV0IG5vdyB5b3UgcHV0IHRoZSBsZW5ndGggaW4gdGhl
IGJpbmRpbmdzLiBJdCBtZWFucyBEVFMgbXVzdA0KPiBoYXZlIGV4YWN0bHkgdGhhdCB2YWx1ZSBh
bmQgY2Fubm90IHVzZSBhbnl0aGluZyBtb3JlLiBJdCdzIHRoZSBzYW1lIGFzDQo+IGhhcmQtY29k
aW5nIHVuaXQgYWRkcmVzc2VzIGluIHRoZSBiaW5kaW5ncy4NCg0KSSBzZWUuIEkgd2lsbCBwcm92
aWRlIG9ubHkgdGhlIE9UUF9QS1QoKSBtYWNybyBpbiBiaW5kaW5ncyBhcyB5b3Ugc3VnZ2VzdGVk
Lg0KDQpUaGFuayB5b3UsDQpDbGF1ZGl1IEJlem5lYQ0KDQo+IA0KPiANCj4gQmVzdCByZWdhcmRz
LA0KPiBLcnp5c3p0b2YNCg0K
