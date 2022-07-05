Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9DC756783B
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jul 2022 22:14:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229878AbiGEUOt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jul 2022 16:14:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229508AbiGEUOr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 16:14:47 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EF0CB52
        for <linux-kernel@vger.kernel.org>; Tue,  5 Jul 2022 13:14:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1657052084; x=1688588084;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=2TyEkr7k74JmtxwSNV5r/yyeP6m98K3SYOds55tZPd0=;
  b=fLl20B3mxzl6J/nkhY4z80NLg96pfxpfkeiGXdJu2GNNoef8n128EonI
   7vQ07NgFs2CQeRLLKbYK2SYMLckuPeq4Sn23N3VNXWWdi5TVtn6/VHXf9
   hukC3U/Y5FUSZcqdOE1clbm/idBtn1Djmp8lbxq+RcESoS90mGQuwpGge
   +HpoBnkRI6OBXXytWn3BmzxTPfm9/b9hatIqA1A38TyuC5aACyfHtiHwQ
   br1/YRjYOFwOCInFkDWhxcJ7EGwOGjBgsfVYBpEtnCwlsyaWdN+A9RqYo
   k6E0J7S0z3CBGSD+oMN272+BDv4RoKF7VuE3hhs9mDsgZ18O0JxM/k8T1
   g==;
X-IronPort-AV: E=Sophos;i="5.92,247,1650956400"; 
   d="scan'208";a="103144624"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 05 Jul 2022 13:14:43 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Tue, 5 Jul 2022 13:14:43 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17 via Frontend Transport; Tue, 5 Jul 2022 13:14:43 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Tm1OeMsSZtQXOq7zp92WG2tapa5V2MQEVxinrBDvXk3ALWZY4fxNYvzIQaEsgXOLnccDf3bpymnUtVc92SvWo/Zwy9wPpIM8iczBL665hF3m8f0JQP/e1MSkKn9Lc2AO820h0D2bnaJbPQxVDQBa8S2uzjNqH15nL6zWSkwY3KB13o59ah8jhdNs9pWwAEX+HxXLMMFq8NVjWy2n/i4BQRv7OYgWnnAQ3kjzj9n7URyxmSoBRNeRLwXft2ThklCZxQ2frg6830M5WJrBOl5oBSpNHBB18j94Pd4w0TwE+OXlRBJkgb5QnhwiyEPD2M18ozROLibXLAmR9xhFIgWcHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2TyEkr7k74JmtxwSNV5r/yyeP6m98K3SYOds55tZPd0=;
 b=SZHnEDgPAeb1CNmzX8aU0pVzCR4NR9KnM0JOjsEkCRNSTWY6V3BaCQnFnyv1AMi0CDs+NG3oPccZOCQOfyBAAjXVV3AxDYe11Xpeh40Szrxt1z7KB8TUiDB1A7nOtlmnDvXiv1CCO9MAqMYchYFMXVAPcsYEO29MWHkpgIg862YCoDIYe86/vm5rrif6A4IETqVQUYvi55xjU2ZhpFcVzX8xKSuzoWx/tEww1biz3Nsggam63sk8GDwaiOm5Zzf2avS8uZ/fWgslhLGaxdOKUhucvjAWbgEWPePoCYd8VxzpbxXf12bT6DtWLWnUOo/G/b+T3RModemYdcEQgpJ48w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2TyEkr7k74JmtxwSNV5r/yyeP6m98K3SYOds55tZPd0=;
 b=QwFiTG5rY13JJeFbwQPHWU5P6ibNAMiDj/9/RhHO8J3ErgbzQ5P6aroQmn620tF2xOv1LR4Ljzhb4zsp0Nu8WSU+AOiC6GtxND7vONhOGktgGP+sdbZJJCs/cr3UUtlMm4D/KADasEXB7+Mz7bXwYHMC86+HeXXspyhLWtzgvSM=
Received: from CO1PR11MB5154.namprd11.prod.outlook.com (2603:10b6:303:99::15)
 by SJ0PR11MB5772.namprd11.prod.outlook.com (2603:10b6:a03:422::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.20; Tue, 5 Jul
 2022 20:14:38 +0000
Received: from CO1PR11MB5154.namprd11.prod.outlook.com
 ([fe80::699b:5c23:de4f:2bfa]) by CO1PR11MB5154.namprd11.prod.outlook.com
 ([fe80::699b:5c23:de4f:2bfa%4]) with mapi id 15.20.5395.021; Tue, 5 Jul 2022
 20:14:38 +0000
From:   <Conor.Dooley@microchip.com>
To:     <sudeep.holla@arm.com>, <Conor.Dooley@microchip.com>
CC:     <Brice.Goglin@inria.fr>, <linux-kernel@vger.kernel.org>,
        <gregkh@linuxfoundation.org>,
        <Valentina.FernandezAlanis@microchip.com>,
        <vincent.guittot@linaro.org>, <dietmar.eggemann@arm.com>,
        <wangqing@vivo.com>, <robh+dt@kernel.org>, <rafael@kernel.org>,
        <ionela.voinescu@arm.com>, <pierre.gondois@arm.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-riscv@lists.infradead.org>, <kernel@esmil.dk>
Subject: Re: [PATCH v6 00/21] arch_topology: Updates to add socket support and
 fix cluster ids
Thread-Topic: [PATCH v6 00/21] arch_topology: Updates to add socket support
 and fix cluster ids
Thread-Index: AQHYj48tVAbdjlL6mUiIMD866kQSr61uUUaAgAFk5gCAAG9PAIAAESSAgAAB9YA=
Date:   Tue, 5 Jul 2022 20:14:38 +0000
Message-ID: <d4b7bfbe-c6a5-c0a9-8aae-7d04682a5271@microchip.com>
References: <20220704101605.1318280-1-sudeep.holla@arm.com>
 <6a647b6b-c913-b9d7-a23e-b17a8034c5c8@microchip.com>
 <507c6b64-fc23-3eea-e4c1-4d426025d658@inria.fr>
 <da1cf1aa-7291-92cd-4b62-0af0d0d12277@microchip.com>
 <20220705200737.unxj2hdcowdjdkt2@bogus>
In-Reply-To: <20220705200737.unxj2hdcowdjdkt2@bogus>
Accept-Language: en-IE, en-US
Content-Language: en-IE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8ccb5e1a-549a-453c-a0f2-08da5ec2fc9e
x-ms-traffictypediagnostic: SJ0PR11MB5772:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 92vkWQomd+ram6VYzDT3mywYHepSYpyNV9/2ibJA62ruAbINrUiu/VUNAyTJa1Ex+X+atLvfDwHr5b7+aOHaQl476lrX6IHLZ5I+SMY3YjNPu0Eu5pCuI0IGAR9b9l+P84SOl5n50u9dd7xH6zprh4AgcZcb+9xCAI9yw0fvRL0zCjD4wGE6JTFHOoHSRHAsdHoDYQZyEv1mqDqTxbv9dtGhMMlZWYTNMyq9+KbHN0B7b6c0uFq23OCBChleNKxOvaLGAFXuvGIA1WRocKHdK/iQT56ggwVAHq5S3pyqTYG6eunPxMLD/yoQ2gs1uS8jUMcw0IVCq4BXBaciYlc5J2kzOD7PQD78KHEh+6xV43sjQ3akv9btxKrG3FLWgYWYJ9Mk4XDIAGicg8duE3nI0YKny8+ZP+++uGbdDf4uQa2GRCsiEQczW8VxOvrDr1QaPfNGOmiDiYoCJL0YOyZ23L+iveI0TtO1FhqfJS44u+aTKW0XKNeBbHOUAWH/dP4C5Gcumvnw9jaD+7XoZqZWzYymAZnkXFYXTZgeQuUNgsu1C80Ne8GWcGIDoP2VhxTrSNvtYcncXTHqjKodyzTH3+GztaLyah7VIJB/jJs3xLQdNHZLZTCmuQxA8OT8M8X7nDfxhwQ4WzDNID/nrzGjmu6yFKBeHZcUxORsRA94tqeggZxPyBVMMr2jv340Il2udxS8dk0Tv/4CA9ItiOmNPG1hLnpgWwgmuh5TXX5pAe+/gk+LY1P/OJIYB+XgpoB6hOtfp5i8Tg9FjmlzLDg4fQgnEHFg87TYpBR4U9z5GXOkDpq+g7hk4EaraOI0z1W6rKCytZqyqJEN3YBJMZTe+1MgjSMK2p5wyMZotZu70NO/jmpmQRfQEEePpUjPamIPNQ+gQZJctbYxsYFe1e1rmGYev9TdmpINcBrzi4/6tTCg+fzZj0rXbGmUQ1JGmlDR
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5154.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(366004)(376002)(39860400002)(136003)(396003)(346002)(186003)(83380400001)(110136005)(66446008)(66946007)(66556008)(7416002)(66476007)(76116006)(38100700002)(91956017)(5660300002)(54906003)(8676002)(316002)(8936002)(41300700001)(6506007)(53546011)(26005)(6512007)(71200400001)(2906002)(122000001)(478600001)(966005)(38070700005)(6486002)(86362001)(31686004)(36756003)(2616005)(31696002)(64756008)(4326008)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TlFON0szTFNYd2N6dTVrRit4NUo3anlYdElFdXVvM205dVN5SmhZTnR6OEd6?=
 =?utf-8?B?RnFHWDFiNmZPMFphT05aTWZLd2VrdmQveWp1MjFibENpVVhiTWhGKzB5QnUz?=
 =?utf-8?B?TFRIcUQ1OUxGK0o4YkxCa1F0YzY5Tk16ejA0NjBuT1F3bWgxUUdQOEpUWjVT?=
 =?utf-8?B?d3dKbzZxUzhDSWE2MkhQaUp1aDg1enU2cS9taUlwTy9TWTVGeGZrbDBueGpI?=
 =?utf-8?B?WGpsNlVRWlRYWmV3bjd4L2tWTjRMajd0bitXR2R6OG01QTBTZFAwVkhlVEZC?=
 =?utf-8?B?eXRKbm9yczE1N2x2c21uZGVyUXNkZmdFMlY5TER5b1hPSHZXZ3ExZk1nMlcv?=
 =?utf-8?B?dFR1QUE5UEwyOUFhZStzTXpNRHpmRlpHQkhSUkQ5TzYxUGlpeXFXRzNWTU1y?=
 =?utf-8?B?MEh4TWVxLzJGK3dRK3I5aUtjUWVTakJHMjd2T2QwZFBVbDJqZkFjZFpOcFlO?=
 =?utf-8?B?YzhpTWRtZkg1K2NNbEgzVHZtMWhScHFMVElTVmlEcVlNR2J6Tk5lRDd0dUFr?=
 =?utf-8?B?MlVwY1FjcWRHU21HL1RMeitlcnJIZURWMFRmTGRmYkJ5OVl5cE80S09LYldR?=
 =?utf-8?B?aHN4Nzc1YTV3UGR0KzFrWHBLZW16V0dFQ3hTWEZNMEM1cmVKZ05TMG1rdThD?=
 =?utf-8?B?QWFKZ24wTTdOdUtXTWZhV1FlY0grMFh0a2lyVjVocDgvQ0NJa3oySnBoTWRt?=
 =?utf-8?B?MnhvSEZDVzhYZ3VpNzdpYXFqVFZGcjdqNHR2blFuZ2g1TENDUGh2SG0vZ3lT?=
 =?utf-8?B?NzBzcWFPOGlzYTVFRjU5dEFGcXZuVXhHeDlMWTljd0dLSlRXTnBpRDFuNll0?=
 =?utf-8?B?RFU5b0lPaExwOXh3bnN2eWorWCtoMkxhMktib1YyNFowT1BuSVNkaGxnRXhE?=
 =?utf-8?B?YUhPZTh2NFdKTFVYNXd5M3YwNFJUM0VjZ1FleGhsVWxBcUJPNWlzSlJTYkQz?=
 =?utf-8?B?VC9GWEd3YkZ2ZzVOR1djR0tlUXVjUThId2VOUzNISzQ1b3ZBMFNzcFVWYzJ5?=
 =?utf-8?B?a0s2QzJMQUIwam9wL0ZTNlIwc1VCVmIveUxETDQ3R1kyekl2TWt2MUZkQ2Mx?=
 =?utf-8?B?ODU3eHNyOVNQSTJDZkJ0NXI0Tk5HSCtBaFppNzRmQWlTcTBkNVhWa0M1cGd6?=
 =?utf-8?B?S2oyZk1ZamN6TGd5SmhDNktYNHhSV0VKTmJnekplTTdxMkd3NXIrTWx5ZnEr?=
 =?utf-8?B?Z1NsVzcyRzFaazR1czZaQnVGUGIrcytITkd1YW9NaWdYN29ZTVBxZUU0aTJJ?=
 =?utf-8?B?b2tVRXpWL3QxL3k5UmIzSTh0MXdUUnpyNmtKQ0orbW5XdlUwaGNJejNqdUJ3?=
 =?utf-8?B?b3c0U1J4WUxJeDlSZXVaSmNUNm5tcURIVGJ2aG1jeUFhdHlSZitKVStxQnRw?=
 =?utf-8?B?UFNOaXFIWDQ1cmc3T3o5b0VwWXBLVm4vOW5aT1lkRUlzbVZJTitLSXhCVTJK?=
 =?utf-8?B?VHBPR3prZjZrMTN1U3hXeUVaL04yS2d2TlBUbWdFNlZoS0xJUDRPNlVlQVA2?=
 =?utf-8?B?NlJkenNWZEVVRVU3MllCcW9zRWxUT2ZtbWkxeUh4YUJwNEdHR2V0MlI0TDlS?=
 =?utf-8?B?cnJSMGtRWkZNQ05MTWp3d2owUmFNQjJnYnFIKzZNR3Jrd0pYNmROdXAzL3FW?=
 =?utf-8?B?WFc0Q3REYld5OERPdTNNWGlQSGZES2p5ajZnemZvYXN2dmd5eVNFLy9KUkIw?=
 =?utf-8?B?UllldXF1WjRVMXJjTlV1NzhRRHltenc2emRpQW9kUE1PQk5KekpUbWhuWGhj?=
 =?utf-8?B?TXdHdXpVZFV6TGtGMzVjNVNMOFRrOXJ6V1BWWjBtYmp3dEpuWHB1Y1p0SDhj?=
 =?utf-8?B?ajFzNXNKcUJrSXNLdlBER2VPeG5KZzhYZzRsOVRqUW9TNEhwdHF3cWc4dk12?=
 =?utf-8?B?WlB6eFNRbWZ2WGRZSDY2VVFFNTczK3ZLcTR1ZnFydUV4amlRV2RPYlU2cXdu?=
 =?utf-8?B?TVFXd0c4eGNOeXd6RU1YNEMxamV1QWpkRFpjU3JiOGFwb1dWYmxub0tyV0hC?=
 =?utf-8?B?dDVJVXZBM3ZSOXpWSzdaZWFoSUMrSDZ0bnBxMWJveGhWdkV5VzZiRzl2NVBH?=
 =?utf-8?B?bS9uRGpONDFPNXZjYi9NSmtTQStMWXRZK2N0QmFxcVBpYVd4ZHdOS29tWElD?=
 =?utf-8?B?dW5xZ25BOGFTSVFIYktJbVFTNk5rZ0VtL05CcWNGSEZ2RE94ZWVyMTlFbnBJ?=
 =?utf-8?B?Rmc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <01FE9C67F5489B4B903DEF85AF955017@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5154.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ccb5e1a-549a-453c-a0f2-08da5ec2fc9e
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jul 2022 20:14:38.0954
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TIpYSAIzykfzU7Sq1P6DhVyUnmHMQRI057qgBw5huURhzDUd5tT6XXXZB32TOLkU9J7/UfI2tn8IbktWkT5Wc+eusyc5EVPlTkNEtBImzrs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5772
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCk9uIDA1LzA3LzIwMjIgMjE6MDcsIFN1ZGVlcCBIb2xsYSB3cm90ZToNCj4gT24gVHVlLCBK
dWwgMDUsIDIwMjIgYXQgMDc6MDY6MTdQTSArMDAwMCwgQ29ub3IuRG9vbGV5QG1pY3JvY2hpcC5j
b20gd3JvdGU6DQo+PiBbQWRkaW5nIGJhY2sgdGhlIENDIGxpc3QgZnJvbSB0aGUgb3JpZ2luYWwg
dGhyZWFkXQ0KPj4NCj4+IE9uIDA1LzA3LzIwMjIgMTM6MjcsIEJyaWNlIEdvZ2xpbiB3cm90ZToN
Cj4+PiBbWW91IGRvbid0IG9mdGVuIGdldCBlbWFpbCBmcm9tIGJyaWNlLmdvZ2xpbkBpbnJpYS5m
ci4gTGVhcm4gd2h5IHRoaXMgaXMgaW1wb3J0YW50IGF0IGh0dHBzOi8vYWthLm1zL0xlYXJuQWJv
dXRTZW5kZXJJZGVudGlmaWNhdGlvbiBdDQo+Pj4NCj4+PiBFWFRFUk5BTCBFTUFJTDogRG8gbm90
IGNsaWNrIGxpbmtzIG9yIG9wZW4gYXR0YWNobWVudHMgdW5sZXNzIHlvdSBrbm93IHRoZSBjb250
ZW50IGlzIHNhZmUNCj4+Pg0KPj4+IEhlbGxvIENvbm9yDQo+Pj4NCj4+PiBJIGFtIHRoZSBtYWlu
IGRldmVsb3BlciBvZiBod2xvYyBbMV0gd2hpY2ggaXMgdXNlZCBieSBtYW55IHBlb3BsZSB0bw0K
Pj4+IGRldGVjdCB0aGUgdG9wb2xvZ3kgb2Ygc2VydmVycy4gV2UncmUgc3RhcnRlZCB0byBzZWUg
c29tZSB1c2VycyBvZiBod2xvYw0KPj4+IG9uIFJJU0MtViBhbmQgd2UgZ290IHNvbWUgcmVwb3J0
cyBhYm91dCB0aGUgdG9wb2xvZ3kgZXhwb3NlZCBieQ0KPj4+IExpbnV4L3N5c2ZzIGJlaW5nIHdy
b25nIG9uIHNvbWUgcGxhdGZvcm1zLg0KPj4+DQo+Pj4gRm9yIGluc3RhbmNlIGh0dHBzOi8vZ2l0
aHViLmNvbS9vcGVuLW1waS9od2xvYy9pc3N1ZXMvNTM2IHNheXMgSGlGaXZlDQo+Pj4gVW5tYXRj
aGVkIHdpdGggU2lGaXZlIEZyZWVkb20gVTc0MCBydW5uaW5nIExpbnV4IDUuMTUgZXhwb3NlcyBh
IHNpbmdsZQ0KPj4+IGNvcmUgd2l0aCA0IHRocmVhZHMgaW5zdGVhZCBvZiA0IGNvcmVzLCB3aGls
ZSBTdGFyRml2ZSBWaXNpb25GaXZlIHYxDQo+Pj4gd2l0aCBKSDcxMDAgcnVubmluZyA1LjE4LjUg
Y29ycmVjdGx5IGV4cG9zZXMgMiBjb3Jlcy4NCj4+DQo+PiBBbmQgd2l0aCBTdWRlZXAncyBwYXRj
aGVzIGFwcGxpZWQgSSBnZXQgKG5leHQtMjAyMjA3MDQpOg0KPj4gIyBod2xvYy1jYWxjIC1OIGNv
cmUgYWxsDQo+PiAxDQo+PiAjIGh3bG9jLWNhbGMgLU4gcHUgYWxsDQo+PiA0DQo+PiBPbiBhIFBv
bGFyRmlyZSBTb0MgKHNvIHRoZSBzYW1lIGFzIGEgU2lGaXZlIFU1NDApLg0KPj4gU28gdW5mb3J0
dW5hdGVseSwgdGhlc2UgcGF0Y2hlcyBhcmUgbm90IHRoZSBmaXggeW91IHNlZWshDQo+Pg0KPiAN
Cj4gTm90IHN1cmUgd2hhdCB5b3UgbWVhbiBieSB0aGF0ID8NCg0KTm90aGluZyBtZWFuaW5nZnVs
IHJlYWxseSwganVzdCBzYXlpbmcgdGhhdCB0aGlzIHBhdGNoc2V0DQp3YXMgdW5yZWxhdGVkIHRv
IHRoZSBwcm9ibGVtIGhlIHJlcG9ydGVkIGhpcyByZXNwb25zZSB0bw0KaXQuDQoNCj4gDQo+PiBX
cmFja2VkIG15IGJyYWlucyBmb3IgYSBiaXQsIGJ1dCBjb3VsZCBub3Qgc2VlIGFueSBkaWZmZXJl
bmNlcw0KPj4gYmV0d2VlbiB0aGUgVTc0MCBhbmQgdGhlIEpINzEwMC4gQ3VscHJpdCBzZWVtcyB0
byBiZSB0aGUgbGFjaw0KPj4gb2YgYSBjcHUtbWFwIG5vZGUgKHdoaWNoIGlzIG9ubHkgcHJlc2Vu
dCBpbiB0aGUgZG93bnN0cmVhbSBkdCkuDQo+Pg0KPiANCj4gSW5kZWVkLCB0aGUgdG9wb2xvZ3kg
ZGVwZW5kcyBvbiAvY3B1LW1hcCBub2RlLiBIb3dldmVyIG9uIEFSTTY0IHdlIGRvDQo+IGhhdmUg
ZmFsbGJhY2sgc2V0dGluZ3MgaW4gYWJzZW5jZSBvZiAvY3B1LW1hcCBub2RlIHNvIHRoYXQgaXQg
aXMgaGFuZGxlZA0KPiBjb3JyZWN0bHkuIEkgd2Fzbid0IHN1cmUgd2hhdCB3YXMgb3IgY2FuIGJl
IGRvbmUgb24gUklTQy1WIGFzIC9jcHUtbWFwDQo+IGlzIG9wdGlvbmFsLg0KPiANCj4+IEkndmUg
c2VudCBwYXRjaGVzIGZvciB0aGUgdXBzdHJlYW0gZGV2aWNldHJlZXM6DQo+PiBodHRwczovL2xv
cmUua2VybmVsLm9yZy9saW51eC1yaXNjdi8yMDIyMDcwNTE5MDQzNS4xNzkwNDY2LTEtbWFpbEBj
b25jaHVvZC5pZS8NCj4+DQo+IA0KPiBJIHdpbGwgdGFrZSBhIGxvb2suDQo+IA0KPj4+IERvZXMg
aXQgZGVwZW5kIGEgbG90IG9uIHRoZSBwbGF0Zm9ybSBiZWNhdXNlDQo+Pj4gZGV2aWNlLXRyZWUg
YW5kL29yIEFDUEkgYXJlbid0IGFsd2F5cyBwcm9wZXJseSBmaWxsZWQgYnkgdmVuZG9ycz8NCj4g
DQo+IEFic29sdXRlbHkuDQo+IA0KPj4+IERvZXMgaXQgZGVwZW5kIGEgbG90IG9uIHRoZSBMaW51
eCBrZXJuZWwgdmVyc2lvbj8NCj4gDQo+IElkZWFsbHkgbm90IG11Y2gsIGJ1dCBoZXkgd2UgaGFk
IHNvbWUgaXNzdWVzIG9uIEFybTY0IHRvbyB3aGljaCB0aGlzIHNlcmllcw0KPiBpcyBhZGRyZXNz
aW5nLg0KPiANCj4+PiBTaG91bGQgSSBleHBlY3Qgc2lnbmlmaWNhbnQgaW1wcm92ZW1lbnRzIGZv
ciBib3RoIGluIHRoZSBuZXh0IG1vbnRocz8NCj4gDQo+IE5vdCBtdWNoIGluIHRvcG9sb2d5IG9y
IG5vdGhpbmcgcGxhbm5lZC4gSSBoYXZlIG5vIGlkZWEgb24gTlVNQQ0KPiANCj4gDQo+IEhpIENv
bm9yLA0KPiANCj4gSSB3b3VsZCBoYXZlIHByZWZlcnJlZCB5b3UgdG8gYWRkIG1lIHRvIHRoZSBv
cmlnaW5hbCB0aHJlYWQgYW5kIHJlZmVycmVkDQo+IHRoaXMgdGhyZWFkIGZyb20gdGhlcmUuIEkg
ZG9uJ3Qgd2FudCB0byBkZXJhaWwgdGhlIGRpc2N1c3Npb24gaW4gdGhpcw0KPiB0aHJlYWQgYXMg
bm90aGluZyBtdWNoIGNhbiBiZSBkb25lIGhlcmUuDQoNClRoaXMgaXMgdGhlIG9yaWdpbmFsIHRo
cmVhZCEgSXQgd2FzIGp1c3Qgb25lIG9mZi1saXN0IGVtYWlsIHRoYXQgd2FzIGENCnRvIG1lIG9u
bHkgcmVzcG9uc2UgdG8gdGhpcyBhcmNoX3RvcG9sb2d1IHRocmVhZCB0aGF0IHlvdSBjYW4gc2Vl
IGhlcmUNCg0KQnV0IHllYWggLSBzaG91bGQgaGF2ZSBDQ2VkIHlvdSBvbiB0aGUgY3B1LW1hcCBz
dHVmZiB0b28uDQo=
