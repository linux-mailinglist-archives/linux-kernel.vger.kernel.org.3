Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93BF75B00A7
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Sep 2022 11:37:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229568AbiIGJh4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Sep 2022 05:37:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229692AbiIGJhx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Sep 2022 05:37:53 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6ADA3B286B;
        Wed,  7 Sep 2022 02:37:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1662543467; x=1694079467;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=wLO5840TPCwUvctukO81qjmSTEh6U/LsHGBAv48T/80=;
  b=TxYBJBYT1+BbXsCcEysnewCIFxDfvXVe7SRMKbeWG6jW4AEgSX4e2Y0c
   9tRRjXJPs8QIOS/ka73qA/h0+lwdiog3OHw8OOSzk6JkZlyYC9Z1l1xRm
   aJz7fPPLpheLg+Hz3IAemBbnUb2GuftSaImuOW+RO6J6toZc7rBteziys
   Dxic0hb62wNaE9bnhD7Rl+NW7iUb2ctprrNkfj9yCdtx70D9g1gcx8Rmb
   oaEPQ/bvdhxZ2LqSSIeS/kweDoBZfpEn6J4q/p++5DpBR8doYVL6uqCf5
   dfQ+FPlNkSAG0hUxL6xQ1gU83RNQeWyDVJBGdR5C+lLamubFSCVzF0zPs
   A==;
X-IronPort-AV: E=Sophos;i="5.93,296,1654585200"; 
   d="scan'208";a="189763363"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 07 Sep 2022 02:37:44 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Wed, 7 Sep 2022 02:37:43 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.12 via Frontend
 Transport; Wed, 7 Sep 2022 02:37:43 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n+Mg5Cy4Hb4kVGw428abLAKbXvnKPe5VOWgBsk6Ho8hP7IAQAtGPHuIYV68o5nb0xnj4XQro4X/7LvsRofDAXP7YUqA3IPvD4ziFFoTRkclJRy6UHw1NWNDnefrch3XEduSogyukj1kd9VCoaaMsI9/Q6EjgJDiugzfsOXf2sNajqu2jT1zkKtjkVhIqJR4Quxc9n9+xThRFLsoNWYNfIEjJ/Z3JIY9C9BsL7iE7R+pfV4KSAB3SOsPzvNL7oHVzGjV9uylqsI8j7dJxu/zfcB1HMqTI+QCpRREdhDcR74qbNHAwUZejUNAKVhdb13W9L1FHAqJkYFW7n4CWc3PeYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wLO5840TPCwUvctukO81qjmSTEh6U/LsHGBAv48T/80=;
 b=eD47X7dB1fF7FurEgIvPQYMwE4uk7IHZIswG6lphvKCDBmMUlxVX+ricvFnZ5vwdPVcckcAoLU62qXa8zt55xGaR3tWidXblaklQ0ETmGT8n6rMQxpd4uwVBrYHm0dg+LQE2Ooo3NEJlS8BIu+KbZ7E23p5UPUoTGwyx70bsSUWBvwzC24wCQHKU1lm5uh6rXnpXPKF7VddpjU8bSBc32GqacWbbQFAPFbSKKfFOA8pIQNtsq2CkiGOd8tPPSWTj1gzrSmd51aMQnYb9Mm51gEK4e0GWCiH5gQi58ozUavZ0Uomf3/5qUkGr5HxT0auU1MlrjLsqe4PD/3YIk5K+qA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wLO5840TPCwUvctukO81qjmSTEh6U/LsHGBAv48T/80=;
 b=Z9S/ml3rM6o3RBVxi0HZKwWFxF9Q5UBpp0hiop74+cYKdOqc+XYRwA39cjobnKnBEbzImIJh/O7z5aUEpyKlnyiRKLNRDrHT9brA9sMiLYPQ1BJoUuFKFakvRwWYzQ3Lfuu/Awwa8csFRBzC2MGc974UFFHbh2OYHLO87ROHxLU=
Received: from BYAPR11MB2758.namprd11.prod.outlook.com (2603:10b6:a02:c9::11)
 by BN6PR11MB1810.namprd11.prod.outlook.com (2603:10b6:404:fc::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.14; Wed, 7 Sep
 2022 09:37:38 +0000
Received: from BYAPR11MB2758.namprd11.prod.outlook.com
 ([fe80::6852:5740:4bc9:d1b4]) by BYAPR11MB2758.namprd11.prod.outlook.com
 ([fe80::6852:5740:4bc9:d1b4%7]) with mapi id 15.20.5588.014; Wed, 7 Sep 2022
 09:37:38 +0000
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
Subject: Re: [PATCH v2 08/13] tty: serial: atmel: Define GCLK as USART
 baudrate source clock
Thread-Topic: [PATCH v2 08/13] tty: serial: atmel: Define GCLK as USART
 baudrate source clock
Thread-Index: AQHYwfilA8AvMZ0L2US8xgGmCsPoQK3Tsl8AgAAEowA=
Date:   Wed, 7 Sep 2022 09:37:38 +0000
Message-ID: <30d9a39c-0630-89e6-43da-47a8be4d1277@microchip.com>
References: <20220906135511.144725-1-sergiu.moga@microchip.com>
 <20220906135511.144725-9-sergiu.moga@microchip.com>
 <5d3e3a73-8b13-fb23-a32c-565046ec3c27@linux.intel.com>
In-Reply-To: <5d3e3a73-8b13-fb23-a32c-565046ec3c27@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0e253e2d-1150-4ce3-aa9b-08da90b49a7d
x-ms-traffictypediagnostic: BN6PR11MB1810:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 7LTYCUqnaQw7bJuhmGhRxnc7UjTGSgNoFWCQaEHRtHN9hPmYul0IHYwjRNnFOGKbsuIdgPiFNMAviyXmROqT5Cwv/lFxNcAQQvrTjvnpwRmSDlv8eQURaG+t7UYKoSEcZnQZf5yjgF5NlrJkzdiMHwL/NwNNLNrdbrwrBWZGrg/ZHmm8N39UlKrIWm2BIKNLnK/28zLr8eYq20sgtw5dldP0o55RJkR/AAE2E4Fn4MA9+Wrb2AhRt0Y9m21AMJpTbY6Diz07Ha16F1zyeIjg6Xip6pu5zKhc2I1c2SYp3T/MnXKE2dHXsQueMfDW3UnJ8cnYReEFHrhp0XqCZ4H4eoIERZeffErOWtdM39IbBkyuogT3Af+uJUcBzV+rjslWcS0/F8C0H0yy0R491MefGovHJTNNR8pTAtDbdwAfN+2nly+DkEgImaqUYkwkV8wFa4J9cV6ojBQHiYsA72Pq7s6Wdu8gdixK0p+7jnfkWwqAqzC54nDNdxdVE3Ca0leotFkOqGYRe7eMcYG2SHnZAYsEv7AS84jNtSeP7UWN/F6Lqlh93GiY85g/uwTZCgiJOCYe2VGis60HJSE2c6K/DInlCLPQMBrY/P0nyK0Qr9aQF+DE/iXzwI3kMu0GM30PPl1CmoldOKZmoOrg+R6XRZUH9HTsbP0wmSucooCC0m1DibfAdtedl5jcfbHArJXI4oeys/abjKQgye5M9aduYknfO8vkJiP4DJm5NPeHTqAt8tI4vZP8WjIDYY8F/t5Ev8WeXeeT6PlR/Y0KLNtC9C/Iripbk0cxLSPTNLaavDI=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB2758.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(376002)(366004)(39860400002)(396003)(136003)(346002)(6512007)(53546011)(41300700001)(66574015)(6506007)(26005)(186003)(83380400001)(31686004)(478600001)(6486002)(36756003)(71200400001)(7416002)(66556008)(66946007)(8936002)(5660300002)(76116006)(38070700005)(2906002)(6916009)(122000001)(31696002)(2616005)(86362001)(66476007)(91956017)(4326008)(54906003)(8676002)(38100700002)(64756008)(66446008)(316002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?d0ZyYmV0RnlObFpWVWVmcWpzMmxsdVd3OFRLSzNtZE84SnNMa1k2TWY0dmRC?=
 =?utf-8?B?RnNHRWhrclVtUDJ2VGgxQ0tKVHVDdkY4RmRRc0l1ZEVGNStqV3hDMmhQazZB?=
 =?utf-8?B?b256L1dRSGtqUDZ1MEFIQTgrTlZ4NEErdG5uYnZJMG1yZkZ1L25kZ1NFRmdD?=
 =?utf-8?B?SHJCQzM0T2NFdktCdmZBQU1vTzRKNnFyUm9US25Da3d0WVlNbEZzZjlSZDJ5?=
 =?utf-8?B?cXdLaWpoM0ljaTc1V1ZUY0Y2OGw1R05OZHpRMFM0QVVFdWFISVUrdnArUXBJ?=
 =?utf-8?B?RUdhZEo2eGdRT2ZoNnhmNEdybXR0U3daYm52dm9GejlXamhmWEdZZG1aZGRL?=
 =?utf-8?B?U0RCN2Ewc0plUlJFdktneTVhY0FHd2I5bWxnKzhOcmJMZjUybFA4VjE3elkr?=
 =?utf-8?B?WmFFdnpZb1RQMUhtajFmZ3pTQUVRbXJ3aWpWMVRma0IxN2piMFl1Zk1YSVor?=
 =?utf-8?B?eWw5UTVUU0psZWVJQUM4ZjRnOURZQnJIb0xwRFk5eVlVWmIwc2UyVXF2QjRh?=
 =?utf-8?B?WmFsRnJkMXlvcWQrVGZpcE50RW9yVFM1UFREUERsbTZteFdkeUZ1NWRWQVFO?=
 =?utf-8?B?SEdWQkpKZVIvY0lEanlXRy9iS2kyVFJDMFJYYUQweXQ3Q21pZUpucEZyRFBU?=
 =?utf-8?B?d3d4Mzd2OC9GdEVuWnJMR1VpNjMzSDZDb21zQnR5ZW9RMHJpZGF3ditUcStN?=
 =?utf-8?B?MFdGYzJIczhTd25VNGVjeTIwRzUwT3lqTVhuVStyN3dBN0txUHVRVkRwbWlV?=
 =?utf-8?B?Q05PWEhOcVgrZ3FwbVVXbWRWeHRpdFBzd2lmVFBVR3lLVFFHMjJqODB0YVl6?=
 =?utf-8?B?R1JFcloyRHZKM1ZtRDBrdUJPNzNyVExRSDVJNTZDMzQyS00wODRLQW9nZUw2?=
 =?utf-8?B?N3FpQWtudHJrSlgzdVpEQk9EWE50TlY4T3RIWGxBK0VnN0swNHFmd29ub2ht?=
 =?utf-8?B?ek9mYzdVWFZWRllUdUE3NnNnTm9RV0p0UlhGMkovczQrcGsyUFNmbmRsZ29Z?=
 =?utf-8?B?YzVGNHN4LzFYV1pxQXNVd1cvbkpVTmxORjdCdEl0VmRWaGlqYTNlY2FBT0xU?=
 =?utf-8?B?SWhrcUFjcmNkem5rckdITURGdDgzWFluN1NwMTdYbmQ3NEZTWTNSVDNlaGFs?=
 =?utf-8?B?RHZ0Q2hnTk8yREdxSHhweTBabGdnajN1cjVhaHg2TU15dkorcTZHK2N1Q1ZW?=
 =?utf-8?B?OEU0M2ZhZm41T0NDMFBHK2QrM3ZSVEx1NUEvQjAyMTRJRENsbjNxSytWeC9B?=
 =?utf-8?B?bmQ5WWhXcXBwMnlDa2ljeTJrb3pzVEw1MG12L2pKbElRWU9ibzhYdlY5Sms1?=
 =?utf-8?B?ZThYTEovV2hsL1dwNi9iSXRFN1V4Nkt2dHhCbVF3dUxScHE4WENkelVBaHVZ?=
 =?utf-8?B?WnFUdEc3U3liTm52QnBTU0dXYjduYTVzNjd5OENpUTVKWFB2a2dxTGh3bWZk?=
 =?utf-8?B?cDR2VHI4a1lKVUpsYXVvT01OdlA1cEFzZXFrN0hJQlJCUkhIZlJqSTFZKy9M?=
 =?utf-8?B?MFZTSWFBR0RIZE9ad0RlWVFQa3U5QkJjZ3RQWVZFZEpsdkgwYUdaa0ZvVVN2?=
 =?utf-8?B?S0J0VFdGUm5ZUWN1L1JYVlpVa0g3T2lSNS9pbGM5Tk5IWStZeUpUMVBwdkU3?=
 =?utf-8?B?MlBhVmFDNVNxQXByMGRMMjNac0p4OHh5MzZLdFRCQmJIRzduQ0tLSlZoQVVK?=
 =?utf-8?B?YjdWTG1KaGU4VXBXRnVtMGRtYVl6ckU1Y1NlczJTRk9NWndBZTVobkpaMDRl?=
 =?utf-8?B?ZXBlZmdsK25venJQeksrMmhQdnY1TmlISzhqQlhZL1NzOTF2YlZpeUFKSlBN?=
 =?utf-8?B?TjlRY1NXaCtHVGFSY1l1dHhDWFk1R2tOdXE0eE9jYmI2TmwzdThlWnc2dkxw?=
 =?utf-8?B?ZFhXQVUyT3p4bHBBUjJQT1NIS1Z2alg0cnNrWWlQZmZzKzcwWXdsZlAzWnFC?=
 =?utf-8?B?UXRFNnYwMVRMOEZCbWloMWpDSEczejE3WjNkRXZKWitzaDZaL2RqdGw1cjJX?=
 =?utf-8?B?VDREM0Y5UzJDaFhVOGdKdDZycnV1N0syL2JiOFVXajBUYVdiUndWOE1taEh6?=
 =?utf-8?B?OWJ4aVJTMXJBY0VhbDlMSjFaZU5uZUZGNnV6QU5INmE5VHNBZktyRExiTEFX?=
 =?utf-8?Q?brdqMIzY73q560knUZO3TfR7a?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <47853BBB9C78C74AADACBFA8E15E2205@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB2758.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e253e2d-1150-4ce3-aa9b-08da90b49a7d
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Sep 2022 09:37:38.6317
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6TshXzvswRUQOcpFwsZaHcOo+K4qDaTXQIRziCnx+tCFL9MopXvHWjQpFC7sdDH6Zs/RcZvAkhIWCuZqdMbXRNhUYwBagcAu2K15Hr6eyd0=
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

T24gMDcuMDkuMjAyMiAxMjoyMSwgSWxwbyBKw6RydmluZW4gd3JvdGU6DQo+IE9uIFR1ZSwgNiBT
ZXAgMjAyMiwgU2VyZ2l1IE1vZ2Egd3JvdGU6DQo+IA0KPj4gRGVmaW5lIHRoZSBiaXQgdGhhdCBy
ZXByZXNlbnRzIHRoZSBjaG9pY2Ugb2YgaGF2aW5nIEdDTEsgYXMgYSBiYXVkcmF0ZQ0KPj4gc291
cmNlIGNsb2NrIGluc2lkZSB0aGUgVVNDTEtTIGJpdG1hc2sgb2YgdGhlIE1vZGUgUmVnaXN0ZXIg
b2YNCj4+IFVTQVJUIElQJ3MuDQo+Pg0KPj4gU2lnbmVkLW9mZi1ieTogU2VyZ2l1IE1vZ2EgPHNl
cmdpdS5tb2dhQG1pY3JvY2hpcC5jb20+DQo+PiAtLS0NCj4+DQo+Pg0KPj4gdjEgLT4gdjI6DQo+
PiAtIE5vdGhpbmcsIHRoaXMgcGF0Y2ggd2FzIG5vdCBoZXJlIGJlZm9yZQ0KPj4NCj4+DQo+Pg0K
Pj4gICBkcml2ZXJzL3R0eS9zZXJpYWwvYXRtZWxfc2VyaWFsLmggfCAxICsNCj4+ICAgMSBmaWxl
IGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspDQo+Pg0KPj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvdHR5
L3NlcmlhbC9hdG1lbF9zZXJpYWwuaCBiL2RyaXZlcnMvdHR5L3NlcmlhbC9hdG1lbF9zZXJpYWwu
aA0KPj4gaW5kZXggMGQ4YTBmOWNjNWMzLi43MGQwNjExZTU2ZmQgMTAwNjQ0DQo+PiAtLS0gYS9k
cml2ZXJzL3R0eS9zZXJpYWwvYXRtZWxfc2VyaWFsLmgNCj4+ICsrKyBiL2RyaXZlcnMvdHR5L3Nl
cmlhbC9hdG1lbF9zZXJpYWwuaA0KPj4gQEAgLTQ5LDYgKzQ5LDcgQEANCj4+ICAgI2RlZmluZSAg
ICAgIEFUTUVMX1VTX1VTQ0xLUyAgICAgICAgIEdFTk1BU0soNSwgNCkgICAvKiBDbG9jayBTZWxl
Y3Rpb24gKi8NCj4+ICAgI2RlZmluZSAgICAgICAgICAgICAgQVRNRUxfVVNfVVNDTEtTX01DSyAg
ICAgICAgICAgICAoMCA8PCAgNCkNCj4+ICAgI2RlZmluZSAgICAgICAgICAgICAgQVRNRUxfVVNf
VVNDTEtTX01DS19ESVY4ICAgICAgICAoMSA8PCAgNCkNCj4+ICsjZGVmaW5lICAgICAgICAgICAg
ICBBVE1FTF9VU19VU0NMS1NfR0NMSyAgICAgICAgICAgICgyIDw8ICA0KQ0KPiANCj4gVGhpcyB3
b3VsZCBiZSBGSUVMRF9QUkVQKEFUTUVMX1VTX1VTQ0xLUywgMikgZnJvbSBsaW51eC9iaXRmaWVs
ZC5oLg0KPiANCj4gVGhleSBzaG91bGQgYWxsIGJlIGNvbnZlcnRlZCB0byB1c2UgRklFTERfUFJF
UCgpLCBJTUhPIChpbiBhIHNlcGFyYXRlDQo+IHBhdGNoKS4NCj4gDQo+PiAgICNkZWZpbmUgICAg
ICAgICAgICAgIEFUTUVMX1VTX1VTQ0xLU19TQ0sgICAgICAgICAgICAgKDMgPDwgIDQpDQo+PiAg
ICNkZWZpbmUgICAgICBBVE1FTF9VU19DSFJMICAgICAgICAgICBHRU5NQVNLKDcsIDYpICAgLyog
Q2hhcmFjdGVyIExlbmd0aCAqLw0KPj4gICAjZGVmaW5lICAgICAgICAgICAgICBBVE1FTF9VU19D
SFJMXzUgICAgICAgICAgICAgICAgICgwIDw8ICA2KQ0KPj4NCj4gDQo+IC0tDQo+ICAgaS4NCj4g
DQoNCg0KWWVzLCBJIGd1ZXNzIHRoYXQgaXMgYSBnb29kIGlkZWEuIEFmdGVyIHRoZXNlIGFkZGl0
aW9uYWwgDQptYWNyby1kZWZpbml0aW9ucyBhcmUgdXBzdHJlYW1lZCwgSSB3aWxsIHRyeSB0byBz
ZW5kIHNvbWUgcGF0Y2hlcyBmb3IgDQp0aGUgY29udmVyc2lvbi4NCg0KVGhhbmtzLA0KCVNlcmdp
dQ0K
