Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4EBC55739C4
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 17:10:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236697AbiGMPKJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 11:10:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231137AbiGMPKH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 11:10:07 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCF132CDEB;
        Wed, 13 Jul 2022 08:10:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1657725005; x=1689261005;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=dq45Yf0ulqU5faEOkiQB+mL95EXY0OL4Q2wSPGgsbD8=;
  b=YmCpIE8iLWiM8VCkK6fvtgOXJDnCN9Xr4XCcHCFkpwcjtjHpujPJisCB
   4y/bezrxGkRx6wNpNt6xMkuAtTh+WrT21URX4kfWXlFCsPxtSsNIKUaDg
   tLrqBnZ8SschZOM3IcowQWtvigvbgP/JmwZDQ+PH8p1VhjBbxsGp9KYOI
   CFQo0nVW5+cFlh/0xBQfwHg8MtJoYGP8C8szAyi7iQu6sF0VLvR6shbH1
   5VMbpWs9Yye+8h+7gL9kgfnXoZ3GlBa4ml5dCqlmUNijs2nnZaUePTFGj
   RGON6p4EglV/WVJxuvhu+7m+K5M/8kKahTCY8vuivCM+pEUZzTh2CJ9No
   w==;
X-IronPort-AV: E=Sophos;i="5.92,267,1650956400"; 
   d="scan'208";a="172220028"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 13 Jul 2022 08:10:05 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Wed, 13 Jul 2022 08:10:01 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17 via Frontend Transport; Wed, 13 Jul 2022 08:10:01 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EYh8BhKlk89EHQa+zq5tqnqp2TiC3aJtot0otLYym2cu77RZFcOZpBuXrljMtHzUvr4Q8ky5t6MhsH3i1hX+rxRX19rcxW0A+gB85l4xlwn6hJ7onk4XTuNioFCcoyaveE+WuIh9dhI8EvVqg2JiGBPWxaHGBm+9Fy87FtLlQ1lcjU7PWq/adp9NR88jp2C2y1xnorwAAtyYoKlWfdpOLw5mKwge+gRTMsOew9gNrXS0RIzCXK+NJ/enoK7GqB4ehlzibCkh0YR3WLtTR5dpmten8Y31cVr9M2P20QvN5+euigKyLIbTjacYkbFuKWKbQsUqAVF0c0Xs4iQ/jq50nA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dq45Yf0ulqU5faEOkiQB+mL95EXY0OL4Q2wSPGgsbD8=;
 b=Q9OD/TauOmsXgesEZKhbWT7uPRryfLZtG18aVD2cznGzg/3ZxWJ2BZe43iQB1z3PxMo8u97K5M4WGFEW207zkFVCam0VDdEMlxiSzPpRQT0UBYV5wFl0AG9h0+cLw225PEXPc8zBvJVPzgH4k9ybzp6qAszqE/e/aYb4Pr3ZdyZfP1QngVvDq1+IupSKrC1BUgm+F3omQyvXmDcv8ahhWFMUqv6+q4Jf8aBrdDfFjL0rt3hMU69/1yvXDTcVCqKzYvjJqpyjYle3X2BzrQ8+TZEkxyRAkIQRvlE+c4++fVwIA7gGDJo8VI3HTtfBD4GXRjQnyuAs5FVn6SOX/X+rKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dq45Yf0ulqU5faEOkiQB+mL95EXY0OL4Q2wSPGgsbD8=;
 b=mMWkNMW6KKpJVv0l8C3E8HDBi3zSkh26DYw4w6bPFHsH4OQO/Yq0JjPxQ1XLiOgcU/WS7VCIYyGnZpC4OxR8xFLEGoGxqUDILccVmHX9vD0+TXGG5rvRVGRB20+TQ9sNiKYiFmK0hVUTi+eDQ19mSJojUC4IwdQ8afVBuTDw7NU=
Received: from PH0PR11MB5160.namprd11.prod.outlook.com (2603:10b6:510:3e::8)
 by BL3PR11MB6433.namprd11.prod.outlook.com (2603:10b6:208:3b9::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.12; Wed, 13 Jul
 2022 15:09:51 +0000
Received: from PH0PR11MB5160.namprd11.prod.outlook.com
 ([fe80::6090:db2c:283b:fe69]) by PH0PR11MB5160.namprd11.prod.outlook.com
 ([fe80::6090:db2c:283b:fe69%8]) with mapi id 15.20.5417.026; Wed, 13 Jul 2022
 15:09:51 +0000
From:   <Conor.Dooley@microchip.com>
To:     <uwu@icenowy.me>, <Conor.Dooley@microchip.com>, <kernel@esmil.dk>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <paul.walmsley@sifive.com>, <palmer@dabbelt.com>,
        <aou@eecs.berkeley.edu>, <anup@brainfault.org>
CC:     <devicetree@vger.kernel.org>, <linux-riscv@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1 2/2] riscv: dts: starfive: add the missing monitor core
Thread-Topic: [PATCH v1 2/2] riscv: dts: starfive: add the missing monitor
 core
Thread-Index: AQHYlVY+6t1yOzd6XkeyUffI8zZgA618XkoAgAAIQICAAAHzAIAAAggA
Date:   Wed, 13 Jul 2022 15:09:51 +0000
Message-ID: <6f6fae32-e3dc-4b9b-21b1-cc2ab0c67de6@microchip.com>
References: <20220711184325.1367393-1-mail@conchuod.ie>
 <20220711184325.1367393-3-mail@conchuod.ie>
 <e8543838cd221ab6699da16c985eed7514daa786.camel@icenowy.me>
 <55e9da06-ccdb-f8e5-b5b9-8125b5fbb58a@microchip.com>
 <822ceff8a6e7f41179abde307ce59c2120684294.camel@icenowy.me>
In-Reply-To: <822ceff8a6e7f41179abde307ce59c2120684294.camel@icenowy.me>
Accept-Language: en-IE, en-US
Content-Language: en-IE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 015ae90b-979f-42b0-0777-08da64e1bbfa
x-ms-traffictypediagnostic: BL3PR11MB6433:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 3CKwlX79D828zyIowL8yssEonrFJY/TcCxseDx7Hw2AxA+bGBa+X3OqO4I0eQYpkQwxcvOpfrzRliN+OUfsYFoPq0h7Cx5dN63p6rbfm1weiHsNnMhS8+IbDfvLUX1Ji9fDgmcpyE7SMYgK60uqdphuyYuxi4+DlPdsIwIBmvz18DCiPIoMxFOKPygt4H8hQJOfM8EP19K+coJnwMg9d6wbtDzKb1YZs58AslvxKhhc0lwlRVMqfGUq+dx+Jnej4cWVS5Ow7qlFtIt7fogv4ZzUKn6nDrj+WmCYuN5yyLnqsF2w+D1KO7Tftoes6RqMa88QvAhQi1I4nYQEeDnwfXkObN5M6YFcMCpx2tLIQ13smuhxxpXmJMN5sOp1/61BYKUI8pM31CxLhcU6GC6bZkEV42h9rsdoP1QGdJkcgcrIqxw1fLdgfaElAyQm3xy3SMPO4k59hShKYFsgzsZrrJnQ3sRH5a40V+QcHXPEd79frY7+Ds2X8TRC1lNppb2ju1nZ0oLMsZRrAK1LuSqJ76JBp7bOuaYrEsiTLcrIBHUxEUpgxF9TTOrmsrC8jG6ddaU73WKU1JQsfSRQ3DSM6KTlGcZjy6EDYOxsXWf2Y+/pO0OVeUbr3I57nU2XSsz9V7RPxsqLloF+ZJPLgLyQZ533GUNLsIDCrl+huSkatFnJh7xeTNR3V1esWow8O9wmdkoMYPLGFT3bBH+LqQ8Q3lQJTz2AIgRrud3CLsVnJo+hZjuA8cLeMgOHj5iAsOhTW9/UqXzT9iNZUIVwAx+NXJdxfUVvW43EPh41pFn5VEOYsISUkjMA+qRsn/3rX/I29VaOjcB2GoyzL0nzR63u1UvI+/Om6SJOrvX7uNQ9P39/sFSSYGpaKyGn2iwsY5m8G
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5160.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(136003)(346002)(396003)(366004)(39860400002)(376002)(54906003)(83380400001)(110136005)(6486002)(91956017)(31696002)(478600001)(2906002)(71200400001)(86362001)(66446008)(66476007)(64756008)(66946007)(66556008)(31686004)(122000001)(36756003)(53546011)(4326008)(8676002)(2616005)(76116006)(6506007)(38100700002)(316002)(38070700005)(7416002)(5660300002)(26005)(186003)(6512007)(41300700001)(8936002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?THRPdzh2ZHFZOTZEdUlneWY2dGNTTnFHODNFTi8vcUx6SFhjSytRRytvVVBH?=
 =?utf-8?B?ZmdGUEFDelQwZUdaamdZQVc3NnBDV2EzanFrOU4vanF0a1B2R0dQdUQ2NFNq?=
 =?utf-8?B?WmhYZXJXcmIzZ2drV1hPeTl6cmkyQkxxYmhoNGcvLzQ0OEovY2hIU3U2YlRv?=
 =?utf-8?B?d1JsT2daczFFSVBLS1RLbzJEV3F4WHVHRzlCaUpoazAwVXh6Q1VHQUN5dzFP?=
 =?utf-8?B?WFMzb1ZYTDJPZ3kxc3NKUGNCTEhsOUpTbWE5UGxuemRPVkVhYlYvQjhQaUZn?=
 =?utf-8?B?c01oc1pQYkx0WnZ1THZhZWNjTUQwS3pHZGZaR0FOSE5hcVdJa1ZkaE5ZNjRS?=
 =?utf-8?B?L01KYjNmQ05QdGhJSnNOZk0rRnFXYWpRMzZCQS82WGJaZEkvTURxRHloWXVa?=
 =?utf-8?B?NDlaRGlpTmQ4QmtpbmM3WmhMaS8yeXNxeGxPN0NuZkpWUzVhMGVudnZmWjBD?=
 =?utf-8?B?VFUySnNZMi9OTnpqMVVBYWVNRUVVUWg5K2JVM2VjS0I2QTQ1VVp5TWlMd0hr?=
 =?utf-8?B?T0c3SnlFdnhlVDM4dnF5SlZMdDBhaDA3NWhLUk5EUzBpQzdqNTVYa2YxSFJT?=
 =?utf-8?B?WERyV1R4dVJBYzV2Rk8yd0x4akF6a2dXbFpHWW1KUzVVR09ueDM4bGVsVTFj?=
 =?utf-8?B?MzhwVFUwNW9WVzI4OElNSUNkRXJXdCtxRGV4ODFNZGFEQnhhaldsTkxBa0Nn?=
 =?utf-8?B?L1d6K0hMWWE5ZVZKOXAzdVN4ZXo1OU1FZVV6ZHZSRDZoL1BZV2ZFbXJMaUpq?=
 =?utf-8?B?SVM1SEpSNFUzTU13NXF6TVVCOFM4bUNsVVRTOTRhTTlrcS93NzQvdlgxanpp?=
 =?utf-8?B?aFRtWnNwL0VMUXNta3FtcWdDUWFxVCtzMHZMWkYyTy81cEFZUXpvWEVsQUti?=
 =?utf-8?B?VkJzWDNEUXRCUCtoaGplMm1XL1NCNEJYS041NlhKU3ZZN0wyb3pQK2lONjJI?=
 =?utf-8?B?c0Z1aTVLdjFQTHFvMUpqQUZxMnZtaXhyc0xUMTArMHRGeHlHS2d2bkhSNDA2?=
 =?utf-8?B?dE91Z01Ca0ltWDNKaTdQSi8ydk1PMmpzRXhVampiVEp2eUx4dEdzbERRcjM2?=
 =?utf-8?B?MUVNS1ZSYnFoOCtSZGJoVXJMRmIzc2ZReUlRaWwwdGZUQVJVTXNheXdaSXp3?=
 =?utf-8?B?YnBhSEdydkc1a2lMaURyWlNJa0RTVlJSTDk2SlpLajQ4S0MxZElWREplV2ty?=
 =?utf-8?B?VzZ1RytnU0UwTWVCZkJCNUV6dno1WjZGMDFlOG9wMFp0Vm5mcjBiNlZzY2Uy?=
 =?utf-8?B?YUQ0eFVjNU1PUHFtdDJtckdmMmZ4M2VzS0Jqa3NHMWR3TVU4SGFYYnArVmdn?=
 =?utf-8?B?bno5all2ai9VdWNPUHZNOFpuTUhRQmc1ZE12MGxXTkRKc0djM1lqZS9tbnds?=
 =?utf-8?B?dGo0TWh5NjI4b2JMQURPcU5VQytHYTFlcWJqSEFUbWI3dHFCU0dLZkw0V3Jz?=
 =?utf-8?B?YWZMZlo0RE42aS90bUlTRGhPWHYzdHA5QWlGU3h2NSt5Wjk1QkUvbHRmUVNu?=
 =?utf-8?B?anFQaXpUcWxrM1FFYzVNTTJDUHBvaVg4UzljUzdKMENDM2VQRFd2OXZxTnJp?=
 =?utf-8?B?K2twRGJpY1lrQ0xkTEVTREZTbUJQSEZwbjAzckRsWEpScTlReXFTTlVJNVNz?=
 =?utf-8?B?cnV2emVUT1RGaU82cVRKZ25tRnVXT3huMzFrRDRSK1J4d2VzNDh5QWxQZEdX?=
 =?utf-8?B?SlNhSkhzKy95ZzdOcW16RmVGblJTR0RGaGdReDFodEVaRHRJVlJZY01sYi9P?=
 =?utf-8?B?aE9pNnBzaHZWbXJaMTBSSUZFRWp5QndIeVIvY1NvSjN4c1BWWTBnVFFIcFg4?=
 =?utf-8?B?TnFvNTUwNmlvNmNZMFFGRllYYXUrQnlBWWpOYzV4Y2Myays2MnZac3lUaG53?=
 =?utf-8?B?YXZzcUx6NjdETEdYbS9KQUhIY2s4WUI2enRERWJpYzdVYjd5T29Gc3M0L2lQ?=
 =?utf-8?B?aEdZdFo3dHJXZ0FKRWFxNndkT1MrcG9IRTBiUXlGcCsvU0hxQ3NzNXNmb2lz?=
 =?utf-8?B?UlBSY2g2M1pQZ1g1cXNqcGxvSE9SWkxwNDkvSWlZeDBrNGVzUW54VUgzcWFX?=
 =?utf-8?B?K0Y0VEVhaXZSdHBNMWhJOUlsd242S3JGeUFlcSt1OHpoa3R0ZXNidFRvVDUz?=
 =?utf-8?B?OVFpOTRzTUVmaFVwOE1xYnFaZkY1OG5FN0ZocCtWNVk5SlpXSXJ2WHRkYytw?=
 =?utf-8?B?MVE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <73947B697B53F143BEA7A0B7B53E0D83@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5160.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 015ae90b-979f-42b0-0777-08da64e1bbfa
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jul 2022 15:09:51.0178
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: c6WhsguEig+cvp6ctmUlLjOODKpxLXk8QKBf50qLYah714a0t4X7/sw9/ImDdRzrOYkimIKVfmBYACagzbXT8VO0aOGRsNU9hDIiOBArpnk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR11MB6433
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCk9uIDEzLzA3LzIwMjIgMTY6MDIsIEljZW5vd3kgWmhlbmcgd3JvdGU6DQo+IOWcqCAyMDIy
LTA3LTEz5pif5pyf5LiJ55qEIDE0OjU1ICswMDAw77yMQ29ub3IuRG9vbGV5QG1pY3JvY2hpcC5j
b23lhpnpgZPvvJoNCj4+IE9uIDEzLzA3LzIwMjIgMTU6MjYsIEljZW5vd3kgWmhlbmcgd3JvdGU6
DQo+Pj4NCj4+PiDlnKggMjAyMi0wNy0xMeaYn+acn+S4gOeahCAxOTo0MyArMDEwMO+8jENvbm9y
IERvb2xleeWGmemBk++8mg0KPj4+PiBGcm9tOiBDb25vciBEb29sZXkgPGNvbm9yLmRvb2xleUBt
aWNyb2NoaXAuY29tPg0KPj4+Pg0KPj4+PiBUaGUgSkg3MTAwIGhhcyBhIDMyIGJpdCBtb25pdG9y
IGNvcmUgdGhhdCBpcyBtaXNzaW5nIGZyb20gdGhlDQo+Pj4+IGRldmljZQ0KPj4+PiB0cmVlLiBB
ZGQgaXQgKGFuZCBpdHMgY3B1LW1hcCBlbnRyeSkgdG8gbW9yZSBhY2N1cmF0ZWx5IHJlZmxlY3QN
Cj4+Pj4gdGhlDQo+Pj4+IGFjdHVhbCB0b3BvbG9neSBvZiB0aGUgU29DLg0KPj4+Pg0KPj4+PiBT
aWduZWQtb2ZmLWJ5OiBDb25vciBEb29sZXkgPGNvbm9yLmRvb2xleUBtaWNyb2NoaXAuY29tPg0K
Pj4+PiAtLS0NCj4+Pj4gwqBhcmNoL3Jpc2N2L2Jvb3QvZHRzL3N0YXJmaXZlL2poNzEwMC5kdHNp
IHwgMjENCj4+Pj4gKysrKysrKysrKysrKysrKysrKysrDQo+Pj4+IMKgMSBmaWxlIGNoYW5nZWQs
IDIxIGluc2VydGlvbnMoKykNCj4+Pj4NCj4+Pj4gZGlmZiAtLWdpdCBhL2FyY2gvcmlzY3YvYm9v
dC9kdHMvc3RhcmZpdmUvamg3MTAwLmR0c2kNCj4+Pj4gYi9hcmNoL3Jpc2N2L2Jvb3QvZHRzL3N0
YXJmaXZlL2poNzEwMC5kdHNpDQo+Pj4+IGluZGV4IGM2MTdhNjFlMjZlMi4uOTJmY2U1YjY2ZDNk
IDEwMDY0NA0KPj4+PiAtLS0gYS9hcmNoL3Jpc2N2L2Jvb3QvZHRzL3N0YXJmaXZlL2poNzEwMC5k
dHNpDQo+Pj4+ICsrKyBiL2FyY2gvcmlzY3YvYm9vdC9kdHMvc3RhcmZpdmUvamg3MTAwLmR0c2kN
Cj4+Pj4gQEAgLTY3LDYgKzY3LDIzIEBAIGNwdTFfaW50YzogaW50ZXJydXB0LWNvbnRyb2xsZXIg
ew0KPj4+PiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIH07
DQo+Pj4+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB9Ow0KPj4+Pg0KPj4+PiArwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBFMjQ6IGNwdUAyIHsNCj4+Pj4gK8KgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGNvbXBhdGlibGUgPSAic2lmaXZlLGUy
NCIsICJyaXNjdiI7DQo+Pj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoCByZWcgPSA8Mj47DQo+Pj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoCBkZXZpY2VfdHlwZSA9ICJjcHUiOw0KPj4+PiArwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgaS1jYWNoZS1ibG9jay1zaXplID0gPDMyPjsN
Cj4+Pj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGktY2Fj
aGUtc2V0cyA9IDwyNTY+Ow0KPj4+PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqAgaS1jYWNoZS1zaXplID0gPDE2Mzg0PjsNCj4+Pj4gK8KgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHJpc2N2LGlzYSA9ICJydjMyaW1hZmMiOw0K
Pj4+PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgc3RhdHVz
ID0gImRpc2FibGVkIjsNCj4+Pj4gKw0KPj4+PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqAgY3B1Ml9pbnRjOiBpbnRlcnJ1cHQtY29udHJvbGxlciB7DQo+Pj4+
ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqAgY29tcGF0aWJsZSA9ICJyaXNjdixjcHUtaW50YyI7DQo+Pj4+ICvCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgaW50ZXJydXB0
LWNvbnRyb2xsZXI7DQo+Pj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgI2ludGVycnVwdC1jZWxscyA9IDwxPjsNCj4+Pj4gK8Kg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIH07DQo+Pj4+ICvCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIH07DQo+Pj4+ICsNCj4+Pj4gwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgIGNwdS1tYXAgew0KPj4+PiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgIGNsdXN0ZXIwIHsNCj4+Pj4gwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgY29yZTAgew0KPj4+
PiBAQCAtNzYsNiArOTMsMTAgQEAgY29yZTAgew0KPj4+PiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBjb3JlMSB7DQo+Pj4+IMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoCBjcHUgPSA8JlU3NF8xPjsNCj4+Pj4gwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgfTsNCj4+Pj4g
Kw0KPj4+PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgIGNvcmUyIHsNCj4+Pj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgY3B1ID0gPCZF
MjQ+Ow0KPj4+PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgIH07DQo+Pj4NCj4+PiBTb3JyeSBidXQgSSB0aGluayB0aGlzIGNoYW5n
ZSBtYWtlcyB0aGUgdG9wb2xvZ3kgbW9yZSBpbmFjY3VyYXRlLg0KPj4+DQo+Pj4gVGhlIEUyNCBj
b3JlIGlzIHZlcnkgaW5kZXBlbmRlbnQsIGp1c3QgYW5vdGhlciBDUFUgY29yZSBjb25uZWN0ZWQN
Cj4+PiB0aGUNCj4+PiBzYW1lIGJ1cyAtLSBldmVuIG5vIGNvaGVyZW5jeSAoRTI0IHRha2VzIEFI
Qiwgd2hpY2ggaXMgbm90DQo+Pj4gY29oZXJlbmN5LQ0KPj4+IHNlbnNpYmxlKS4gRXZlbiB0aGUg
VEFQIG9mIGl0IGlzIGluZGVwZW5kZW50IHdpdGggdGhlIFU3NCBUQVAuDQo+Pj4NCj4+PiBBbmQg
YnkgZGVmYXVsdCBpdCBkb2VzIG5vdCBib290IGFueSBwcm9wZXIgY29kZSAoaWYgYSBkZWJ1Z2dl
ciBpcw0KPj4+IGF0dGFjaGVkLCBpdCB3aWxsIGRpc2NvdmVyIHRoYXQgdGhlIEUyNCBpcyBpbiBj
b25zaXN0ZW50bHkgZmF1bHQgYXQNCj4+PiAweDANCj4+PiAobXR2ZWMgaXMgMHgwIGFuZCB3aGVu
IGZhdWx0IGl0IGp1bXBzIHRvIDB4MCBhbmQgZmF1bHQgYWdhaW4pLA0KPj4+IHVudGlsDQo+Pj4g
aXRzIGNsb2NrIGlzIGp1c3Qgc2h1dGRvd24gYnkgTGludXggY2xlYW5pbmcgdXAgdW51c2VkIGNs
b2Nrcy4pDQo+Pj4NCj4+PiBQZXJzb25hbGx5IEkgdGhpbmsgaXQgc2hvdWxkIGJlIGltcGxlbWVu
dGVkIGFzIGEgcmVtb3RlcHJvYw0KPj4+IGluc3RlYWQuDQo+Pg0KPj4gTWF5YmUgSSBhbSBtaXNz
aW5nIHNvbWV0aGluZywgYnV0IEkgZG9uJ3QgcXVpdGUgZ2V0IHdoYXQgdGhlIGRldGFpbA0KPj4g
b2YgaG93IHdlIGFjY2VzcyB0aGlzIGluIGNvZGUgaGFzIHRvIGRvIHdpdGggdGhlIGRldmljZXRy
ZWU/DQo+PiBJdCBpcyBhZGRlZCBoZXJlIGluIGEgZGlzYWJsZWQgc3RhdGUsIGFuZCB3aWxsIG5v
dCBiZSB1c2VkIGJ5IExpbnV4Lg0KPj4gVGhlIHZhcmlvdXMgU2lGaXZlIFNvQ3MgJiBTaUZpdmUg
Y29yZWNvbXBsZXggdXNlcnMgdGhhdCBoYXZlIGEgaGFydA0KPj4gbm90IGNhcGFibGUgb2YgcnVu
bmluZyBMaW51eCBhbHNvIGhhdmUgdGhhdCBoYXJ0IGRvY3VtZW50ZWQgaW4gdGhlDQo+PiBkZXZp
Y2V0cmVlLg0KPj4gVG8gbWUsIHdoYXQgd2UgYXJlIGNob29zaW5nIHRvIGRvIHdpdGggdGhpcyBo
YXJ0IGRvZXMgbm90IHJlYWxseQ0KPj4gbWF0dGVyIHZlcnkgbXVjaCwgc2luY2UgdGhpcyBpcyBh
IGRlc2NyaXB0aW9uIG9mIHdoYXQgdGhlIGhhcmR3YXJlDQo+PiBhY3R1YWxseSBsb29rcyBsaWtl
Lg0KPiANCj4gVGhlIEUyNCBpcyBub3QgaW4gdGhlIGNvcmUgY29tcGxleCBhdCBhbGwuIEl0J3Mg
anVzdCBhIGRlZGljYXRlIENQVQ0KPiBjb25uZWN0ZWQgdG8gYW5vdGhlciBidXMgKHdlbGwgYXMg
SSBzYXcgdGhlIGRvY3VtZW50IHNheXMgdGhlIEUyNCBidXMNCj4gaXMgbWF4aW11bSAyRywgSSBk
b3VidCB3aGV0aGVyIGl0J3MgdGhlIHNhbWUgYnVzIHdpdGggdGhlIFU3NCBvbmUpLg0KPiANCj4g
VGhlIFU3NCBNQyBvbmx5IGFsbG93cyBTNSBtYW5hZ2VtZW50IGNvcmVzIHRvIGJlIHBhcnQgb2Yg
aXQsIG5vdCBFMjQuDQoNClNvIGlzIHRoZSBjb3JyZWN0IHRvcG9sb2d5IG1vcmUgbGlrZToNCmNw
dS1tYXAgew0KICAgICAgICBjbHVzdGVyMCB7DQogICAgICAgICAgICAgICAgY29yZTAgew0KICAg
ICAgICAgICAgICAgICAgICAgICAgY3B1ID0gPCZVNzRfMD47DQogICAgICAgICAgICAgICAgfTsN
CiAgICAgICAgICAgICAgICBjb3JlMSB7DQogICAgICAgICAgICAgICAgICAgICAgICBjcHUgPSA8
JlU3NF8xPjsNCiAgICAgICAgICAgICAgICB9Ow0KICAgICAgICB9Ow0KICAgICAgICBjbHVzdGVy
MSB7DQogICAgICAgICAgICAgICAgY29yZTAgew0KICAgICAgICAgICAgICAgICAgICAgICAgY3B1
ID0gPCZFMjQ+Ow0KICAgICAgICAgICAgICAgIH07DQogICAgICAgIH07DQp9Ow0KIA0K
