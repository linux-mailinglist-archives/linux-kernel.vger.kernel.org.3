Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07BF44DD9B5
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Mar 2022 13:27:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236175AbiCRM2P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Mar 2022 08:28:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230274AbiCRM2K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Mar 2022 08:28:10 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FF111AA8FB;
        Fri, 18 Mar 2022 05:26:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1647606411; x=1679142411;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=mNY3NlyeoQiypkjyTPjahwYfDUO6UuHJ9i9Jt3gd22o=;
  b=2lsqhD2Om3w5+x7NZ1Bw3QY2fmmu8cnV1/PHrsm/RjPS8YJHnXl++oHv
   /VADqDU96QrMUvJapHE4mntAY0JwYPRF+VDaBXAIWfIT3egkgqoUsxqpD
   vZJfR9vAGlEP8PHVow5yb/3MRrnbSQ7xuEnnlqcT0IfO7AeYkZ1/6oOEf
   YBpFMNdyo0lcjvQ1OXdfjmjoLaBpt+lHiG9Bh5/s2rN6g3+DY5avn27yw
   GXbQw8Wu6ImVutwsCU/M71xRQNodIoLkyJFbTngYHGZg5Un0MgXlVCLMF
   RKqSWiXzhpguRdABeCZEjkHDTiDO5apJxSzweSaJ6ALrUgCsOrrwnZb3v
   g==;
X-IronPort-AV: E=Sophos;i="5.90,192,1643698800"; 
   d="scan'208";a="166291557"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 18 Mar 2022 05:26:51 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Fri, 18 Mar 2022 05:26:50 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17 via Frontend Transport; Fri, 18 Mar 2022 05:26:50 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nP/ev0DRnhrxkHVjRhVL8bNmeMezxr4y4ncrQAaxOPvvECHDwSyaLRe+rhtI8AkaUnw+P0pKFf/uZvnr9bpZGtbxdwA1kNB7xF7Rupur7r9nMcuOGNxdUWRmSFyGJIix31RyxTHMYSThlhImt42bAMjm962pjSz+C+a5iFs/CeZkHIwhvWHOjm3lKtJA9KglM5f3J6sxq5ThtALVMHJwWoFZdPzUQWNEfyrt7EiD8JlvrTPhaf6HXt+OLHXjVFyQ3jBlq3ev1cqaXNf7uBgAJVAz3AKJrS0Of+teDjJNUZKhfki08q8Lu8VDE63iscxrJUOUfigtLc4WbG7OFuVBZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mNY3NlyeoQiypkjyTPjahwYfDUO6UuHJ9i9Jt3gd22o=;
 b=mFzFSlmOZEys822JioXUSseLLbWr/DO1y5S/R6nue0UdRhZV8ByjBnW2wpAc6B7E7lx29Q6hXPKnAGCEdbgSSds5WrRrQ25uvRRBHGcv2vkX875q+t29e2P/cet34XOHZ9+wLb/flbU4XTtAolmqN/HJ0xoPPwlCgyhFrAndUQ3z0fLTsf059KsQewsLiM8rO7U9pfgLSTI9Xoq9CfAjZSSvDytRG3GVcq8Ulc3S2/msG5/lFby2cNX2g8QwsWXGAC/2p4Z6eiA9obXNEukSgJU2hWqz4cadWv0dynW+0Cad21FHCXJNa0R1TkUhjNSA24SI6bnqYqtFsqAmiLT0rA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mNY3NlyeoQiypkjyTPjahwYfDUO6UuHJ9i9Jt3gd22o=;
 b=Funi7CnLcJOPRxG0h6yBVHLjLMXTJCsir6w3MAWLWx5QijNrTFOeuJoIiUAJuu2AZ15xYfdjItR/DR7JLBhsnkFlIB/ODqEzhBgZe6EYYxh5EdNzvu9dcPj85e+yYkZJvxKHz6my1Ybd2ZdodhjryHkPPc8R3WXQXXGYXslWyq0=
Received: from PH0PR11MB4775.namprd11.prod.outlook.com (2603:10b6:510:34::22)
 by CO6PR11MB5585.namprd11.prod.outlook.com (2603:10b6:5:356::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5081.14; Fri, 18 Mar
 2022 12:26:44 +0000
Received: from PH0PR11MB4775.namprd11.prod.outlook.com
 ([fe80::6922:3b5f:7242:3f52]) by PH0PR11MB4775.namprd11.prod.outlook.com
 ([fe80::6922:3b5f:7242:3f52%6]) with mapi id 15.20.5081.017; Fri, 18 Mar 2022
 12:26:44 +0000
From:   <Claudiu.Beznea@microchip.com>
To:     <michael@walle.cc>
CC:     <Kavyasree.Kotagiri@microchip.com>, <Nicolas.Ferre@microchip.com>,
        <arnd@arndb.de>, <olof@lixom.net>, <soc@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski@canonical.com>,
        <alexandre.belloni@bootlin.com>
Subject: Re: [PATCH v1 6/6] ARM: dts: lan966x: add basic Kontron KSwitch D10
 support
Thread-Topic: [PATCH v1 6/6] ARM: dts: lan966x: add basic Kontron KSwitch D10
 support
Thread-Index: AQHYL6I5IDsWmNUwNUeQZG3vhMQHpw==
Date:   Fri, 18 Mar 2022 12:26:43 +0000
Message-ID: <a1c1674a-f0f7-87a9-458a-7d75858fcdba@microchip.com>
References: <20220303160323.3316317-1-michael@walle.cc>
 <20220303160323.3316317-7-michael@walle.cc>
 <b4aca5f1-38c0-8197-6914-0a39b7755180@microchip.com>
 <900be5239b96cd77493fbcfbe220989f@walle.cc>
 <1098e023-afb7-5453-cd3a-8b81b3d48f4f@microchip.com>
 <f8c115a1358305b9d190d2417e55f73c@walle.cc>
In-Reply-To: <f8c115a1358305b9d190d2417e55f73c@walle.cc>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 973de126-398e-49a8-4f42-08da08da9025
x-ms-traffictypediagnostic: CO6PR11MB5585:EE_
x-microsoft-antispam-prvs: <CO6PR11MB55850EAF7383585167FBB7B987139@CO6PR11MB5585.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: QdErhZwIu8dNgkgJ2ovZadszvTY5JduXYOGn5vqRVyMB3YnS7/CmybxlFBYfXvrtqTYyclFK8qZ9gxAAPQgLqGi6o/g5PxjX1n/Peuw0Sy9EsElXOFVPBbvlLRaMSTTyhLfSG5hmjVgCQWY1p9Q1+NdLln+B8aQdXiIZV8omPxOybY/tONK1Bwo31CFGFZR3hP/UZkH9Al+hMfiaQSxTf6TK/utGa/RRw+Vz7rECdcHlcc5MnCj3UGgbjFvHmflbiiGNxi+e7nw4OEKTs/t+VcZoPtEN1Y3MRH7Xmp7PGMSNPrL86WtOhNm1OdQX43kCfhBCBqPkbjyE+jRJiTA9QeWXMxrmH145HxPbDf12P4BAWmMZ0yeFqPOHLg8+xQ2mimALUxslPFVuVONSzfNZtwqx3+S0KcFGUv3ViNhn9UW5+l+KDCQQru3Jllyn15QZz45Fu/HRqdIcTcJlQZBTdxZbWNRCfaIcKfcBbUaa0ydVMHiQ7u/DgPH1HpaFTUltQKuekJ08aY6zYTax1M2ItFQdwHdLGTci8dSEDi8OYi7J5+vfFE43DDRjgr+xhpgZTEcxzup5lFs/jZM/WcZpJ+ih6GGVtAbDOzaIaBpGD6peaYpR4MddVjHYL0vwEbRNMn8ZZS+cvfj4wj62cxxYGAjPxv2SeD5ziSuzfnk2j4YrCHZCrXKEsU/eOLEIJdjBG4eXmLWgwUVcO1B1oicr/Nhn65dPMU4442IgFFUgnirqe+66u1i8y4DkKq5IYvD16ALRTPxqpeoxpodKwEz2Lg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB4775.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(76116006)(91956017)(2906002)(31696002)(36756003)(6486002)(31686004)(4326008)(66946007)(8676002)(64756008)(66446008)(66476007)(66556008)(86362001)(7416002)(38070700005)(5660300002)(83380400001)(8936002)(71200400001)(316002)(122000001)(2616005)(508600001)(38100700002)(6916009)(6512007)(26005)(186003)(53546011)(54906003)(6506007)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RW44ODJyWi9uMGQyNkxINkRZQWp5SXdzK0QvYlFYa0VTWGdGcW55QkNkMkUy?=
 =?utf-8?B?R3ZYMDlIZTB6UVFPcXFmY3ptTkJrSENvRUNqenNIanJNSTk4UTBGMFB3ZDF6?=
 =?utf-8?B?c3ZwVERIZmMxdnJFbFlvTnFnNXRySkMySUhBVUVaTVJseEwwdFdJV0M3bkdk?=
 =?utf-8?B?b2xXdVhDcjNIVVc5YmwyRkhjcmxGQ2J4L2licndqZjFFOW1pZ0pweFNacjNo?=
 =?utf-8?B?dDNGSVFYWk1xaDJVOENsYkVvL0VubDNtSmF6SDVTcXdrdVl4eTQ2amNUenZi?=
 =?utf-8?B?M2hPMlcwWEFUcEpWWHhLZWFnRjRaWXRqUGpTNjR0TXU1VzhVMUpQQmttVTFE?=
 =?utf-8?B?Z1c0VVAwRTM4SGJRMUNxOUFPQWJZeG9OY09uQXFHMkxlTjNpNUplNDFOY09l?=
 =?utf-8?B?TTVYeDlxUEp3RFd1SlBFeGl6OHJ0OVpQSDZKNVRwZ00vdU5naUgrcjMzRlF3?=
 =?utf-8?B?RElMRU5EL2hFNVY2SE5HUGsveTYxdWNtbEQyZTd5b1BiNFZNeCt2SmpGd2ZH?=
 =?utf-8?B?ZjRIdWt3VTZRcDRZWDM5V1ZNNk5mcHlmS0RkV0tuS3l4RUNKcGtmQUNsWjVl?=
 =?utf-8?B?UXd0bWkxWi9obW9LS3RlY3V6UHRUNFhGQVFUajVaTDlncXFMaE9RVkFERUcz?=
 =?utf-8?B?cy9HM0FHa0pSNzBQVmlWSzlCdDZUK2tsMFg1N0lFbnpadUtOckdhcURyaURu?=
 =?utf-8?B?L0ZSbm5CY0pOM2pnbHh0NCt1NGxmaktnRHo2Q2o3TDk4Vm41bkE5L28rSXRz?=
 =?utf-8?B?bXM2bFNsZHJuamN1ZGlHVXQ4NDdTdkNvMHUzemxmc3JqRWZyYkpHUVUycm1a?=
 =?utf-8?B?L1Y2d2p1L1dvUC82TnFmR1NzR0J0MVRzWG9RaldKb0JFd3d1aE5nbXdZVlF3?=
 =?utf-8?B?OFdCSWZqL0tEUHg1WTNYNVJISFRkVnJnYzk3M29TWWQvbkJFKzdUbHZ0eFhy?=
 =?utf-8?B?ZDhLVmpjK2FjZUpLc1JFakE0MHAwbjArbWZ6U29vTjZBcDdoNXVmaENsd1dy?=
 =?utf-8?B?QzZHMlRuOXcwNEp6eG41UUtBOUY4dTRVNVRXZ2VjY2xYazNycHF0L1RYd3g3?=
 =?utf-8?B?eXNzbEgzTXcrSHd0akF2Z2JvaXRaWCtkMm9HaHRpWkdFbWxxZGNhOHh1N3hQ?=
 =?utf-8?B?RU94YWMxR0t2R0ZYamVXMjhOWmlnM3Z4ZlBVMEZvTFhmbTBORHp2T0xJYllr?=
 =?utf-8?B?TUw3Rks4MnJmRENhbU9yT3k1dDBLQ3VmS010QVUydUxyWWwreExobEs4OGZu?=
 =?utf-8?B?VDgvWTFvdGthTUw0M3o2OEk4T3BTVlFDUklvVkJidFVsaCsramNMZXorU2pB?=
 =?utf-8?B?bjRadE1EcURCZzM0eTcrUk9MVWxkUE1MZ0xKUGRaampqOGp0cWVwRFg5U1A2?=
 =?utf-8?B?d3RXdzBtcVp6TGRTRThZMUtQdlpyNU02TjlSUUVzMklCUEx4Ty9ERW8zbXdM?=
 =?utf-8?B?ZWpGZ1ArUHIwM0ZNV3d3cHdYZVRBVzRJcXdLQkdhWlJOTktiaGplZzVRUU5F?=
 =?utf-8?B?RnpmQ1BqNkRYVHQ0dlo2YlIvSkh6YzBRVStOUXgyNVhLM2lZbkdCWVg2cXhS?=
 =?utf-8?B?enRmdlBkUVBWaXpSaDJxQk1BcU84Q256VGhpWXEvbXZZMU82Tm5zemNOZUNj?=
 =?utf-8?B?MHM0WlJrRzgxVldnZ3hxaTZtaVBjWk9xMkJ3ZUNsc0dhUXJMbVNNVVgwb0JN?=
 =?utf-8?B?TXJ2VjNZY2lsNkJGQmRiQ0pqS1p0aDRqQXUxcUpqZHRmcE1xVmxqQzFRRnVH?=
 =?utf-8?B?anFnaGtnUUVQN2dzOWtDVEk5VjNTblpVTHBrWnM3OUxVNGdnOXZrWXdxUk16?=
 =?utf-8?B?UzRhQ2VBT1Ntb2gvVkVXeGUzR3JkZHhibjRISzJ2eWNDd3p2UkJWd3RQeXhj?=
 =?utf-8?B?WGgyZU5pMzAzelIyVlpOV05yT3k3SHBmOHgvbmVHMFdLTy91b2R4UCtQMlk4?=
 =?utf-8?B?b0VSbHZ0M2FrYWcvQmVKSFN3NkFnWEFTVGJJVzI0eVc5L3FRRzJZSjVzR1Uv?=
 =?utf-8?B?aDFtWGxnQVRBPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <EF908D2E3AF860499F95BFF53B052A1A@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB4775.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 973de126-398e-49a8-4f42-08da08da9025
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Mar 2022 12:26:43.9183
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Vy9Zt9CnksAGniVdgwK3aL4i0Ds7GRBNvbiUPshXggNZoP6tO1K0DesY73LtaryR4QWyla2YspH/9SW+mWM014B49S30UYsIHytVDb/hjj4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR11MB5585
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,T_SCC_BODY_TEXT_LINE,
        T_SPF_PERMERROR autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMDcuMDMuMjAyMiAxNDoxNywgTWljaGFlbCBXYWxsZSB3cm90ZToNCj4gRVhURVJOQUwgRU1B
SUw6IERvIG5vdCBjbGljayBsaW5rcyBvciBvcGVuIGF0dGFjaG1lbnRzIHVubGVzcyB5b3Uga25v
dyB0aGUNCj4gY29udGVudCBpcyBzYWZlDQo+IA0KPiBBbSAyMDIyLTAzLTA3IDEzOjA3LCBzY2hy
aWViIENsYXVkaXUuQmV6bmVhQG1pY3JvY2hpcC5jb206DQo+PiBPbiAwNC4wMy4yMDIyIDEzOjE1
LCBNaWNoYWVsIFdhbGxlIHdyb3RlOg0KPj4+IEVYVEVSTkFMIEVNQUlMOiBEbyBub3QgY2xpY2sg
bGlua3Mgb3Igb3BlbiBhdHRhY2htZW50cyB1bmxlc3MgeW91IGtub3cNCj4+PiB0aGUNCj4+PiBj
b250ZW50IGlzIHNhZmUNCj4+Pg0KPj4+IEFtIDIwMjItMDMtMDQgMDk6MzEsIHNjaHJpZWIgQ2xh
dWRpdS5CZXpuZWFAbWljcm9jaGlwLmNvbToNCj4+Pj4gT24gMDMuMDMuMjAyMiAxODowMywgTWlj
aGFlbCBXYWxsZSB3cm90ZToNCj4+Pj4+IEVYVEVSTkFMIEVNQUlMOiBEbyBub3QgY2xpY2sgbGlu
a3Mgb3Igb3BlbiBhdHRhY2htZW50cyB1bmxlc3MgeW91DQo+Pj4+PiBrbm93DQo+Pj4+PiB0aGUg
Y29udGVudCBpcyBzYWZlDQo+Pj4+Pg0KPj4+Pj4gQWRkIGJhc2ljIHN1cHBvcnQgZm9yIHRoZSBL
b250cm9uIEtTd2l0Y2ggRDEwIE1NVCA2Ry0yR1Mgd2hpY2gNCj4+Pj4+IGZlYXR1cmVzIDYgR2ln
YWJpdCBjb3BwZXIgcG9ydHMgYW5kIHR3byBTRlAgY2FnZXMuIEZvciBub3cgdGhlDQo+Pj4+PiBm
b2xsb3dpbmcgaXMgd29ya2luZzoNCj4+Pj4+IMKgLSBLZXJuZWwgY29uc29sZQ0KPj4+Pj4gwqAt
IFNGUCBjYWdlcyBJMkMgYnVzIGFuZCBtdXgNCj4+Pj4+IMKgLSBTUEkNCj4+Pj4+IMKgLSBTR1BJ
Tw0KPj4+Pj4gwqAtIFdhdGNoZG9nDQo+Pj4+Pg0KPj4+Pj4gU2lnbmVkLW9mZi1ieTogTWljaGFl
bCBXYWxsZSA8bWljaGFlbEB3YWxsZS5jYz4NCj4+Pj4+IC0tLQ0KPj4+Pj4gwqBhcmNoL2FybS9i
b290L2R0cy9NYWtlZmlsZcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHzC
oMKgIDMgKy0NCj4+Pj4+IMKgLi4ubGFuOTY2eC1rb250cm9uLWtzd2l0Y2gtZDEwLW1tdC02Zy0y
Z3MuZHRzIHwgMTU5DQo+Pj4+PiArKysrKysrKysrKysrKysrKysNCj4+Pj4+IMKgMiBmaWxlcyBj
aGFuZ2VkLCAxNjEgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQ0KPj4+Pj4gwqBjcmVhdGUg
bW9kZSAxMDA2NDQNCj4+Pj4+IGFyY2gvYXJtL2Jvb3QvZHRzL2xhbjk2Nngta29udHJvbi1rc3dp
dGNoLWQxMC1tbXQtNmctMmdzLmR0cw0KPj4+Pj4NCj4+Pj4+IGRpZmYgLS1naXQgYS9hcmNoL2Fy
bS9ib290L2R0cy9NYWtlZmlsZSBiL2FyY2gvYXJtL2Jvb3QvZHRzL01ha2VmaWxlDQo+Pj4+PiBp
bmRleCAwODVjNDM2NDlkNDQuLjg2ZGQwZjk4MDRlZSAxMDA2NDQNCj4+Pj4+IC0tLSBhL2FyY2gv
YXJtL2Jvb3QvZHRzL01ha2VmaWxlDQo+Pj4+PiArKysgYi9hcmNoL2FybS9ib290L2R0cy9NYWtl
ZmlsZQ0KPj4+Pj4gQEAgLTczOSw3ICs3MzksOCBAQCBkdGItJChDT05GSUdfU09DX0lNWDdVTFAp
ICs9IFwNCj4+Pj4+IMKgwqDCoMKgwqDCoMKgIGlteDd1bHAtY29tLmR0YiBcDQo+Pj4+PiDCoMKg
wqDCoMKgwqDCoCBpbXg3dWxwLWV2ay5kdGINCj4+Pj4+IMKgZHRiLSQoQ09ORklHX1NPQ19MQU45
NjYpICs9IFwNCj4+Pj4+IC3CoMKgwqDCoMKgwqAgbGFuOTY2eC1wY2I4MjkxLmR0Yg0KPj4+Pj4g
K8KgwqDCoMKgwqDCoCBsYW45NjZ4LXBjYjgyOTEuZHRiIFwNCj4+Pj4+ICvCoMKgwqDCoMKgwqAg
bGFuOTY2eC1rb250cm9uLWtzd2l0Y2gtZDEwLW1tdC02Zy0yZ3MuZHRiDQo+Pj4+PiDCoGR0Yi0k
KENPTkZJR19TT0NfTFMxMDIxQSkgKz0gXA0KPj4+Pj4gwqDCoMKgwqDCoMKgwqAgbHMxMDIxYS1t
b3hhLXVjLTg0MTBhLmR0YiBcDQo+Pj4+PiDCoMKgwqDCoMKgwqDCoCBsczEwMjFhLXFkcy5kdGIg
XA0KPj4+Pj4gZGlmZiAtLWdpdA0KPj4+Pj4gYS9hcmNoL2FybS9ib290L2R0cy9sYW45NjZ4LWtv
bnRyb24ta3N3aXRjaC1kMTAtbW10LTZnLTJncy5kdHMNCj4+Pj4+IGIvYXJjaC9hcm0vYm9vdC9k
dHMvbGFuOTY2eC1rb250cm9uLWtzd2l0Y2gtZDEwLW1tdC02Zy0yZ3MuZHRzDQo+Pj4+PiBuZXcg
ZmlsZSBtb2RlIDEwMDY0NA0KPj4+Pj4gaW5kZXggMDAwMDAwMDAwMDAwLi45NTg2NzhkZWM3YWQN
Cj4+Pj4+IC0tLSAvZGV2L251bGwNCj4+Pj4+ICsrKyBiL2FyY2gvYXJtL2Jvb3QvZHRzL2xhbjk2
Nngta29udHJvbi1rc3dpdGNoLWQxMC1tbXQtNmctMmdzLmR0cw0KPj4+Pj4gQEAgLTAsMCArMSwx
NTkgQEANCj4+Pj4+ICsvLyBTUERYLUxpY2Vuc2UtSWRlbnRpZmllcjogKEdQTC0yLjArIE9SIE1J
VCkNCj4+Pj4+ICsvKg0KPj4+Pj4gKyAqIERldmljZSBUcmVlIGZpbGUgZm9yIHRoZSBLb250cm9u
IEtTd2l0Y2ggRDEwIE1NVCA2Ry0yR1MNCj4+Pj4+ICsgKi8NCj4+Pj4+ICsNCj4+Pj4+ICsvZHRz
LXYxLzsNCj4+Pj4+ICsjaW5jbHVkZSAibGFuOTY2eC5kdHNpIg0KPj4+Pj4gKw0KPj4+Pj4gKy8g
ew0KPj4+Pj4gK8KgwqDCoMKgwqDCoCBtb2RlbCA9ICJLb250cm9uIEtTd2l0Y2ggRDEwIE1NVCA2
Ry0yR1MiOw0KPj4+Pj4gK8KgwqDCoMKgwqDCoCBjb21wYXRpYmxlID0gImtvbnRyb24sa3N3aXRj
aC1kMTAtbW10LTZnLTJncyIsDQo+Pj4+PiAia29udHJvbixzMTkyMSIsDQo+Pj4+PiArwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgIm1pY3JvY2hpcCxsYW45NjY4IiwgIm1p
Y3JvY2hpcCxsYW45NjYiOw0KPj4+Pj4gKw0KPj4+Pj4gK8KgwqDCoMKgwqDCoCBhbGlhc2VzIHsN
Cj4+Pj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHNlcmlhbDAgPSAmdXNhcnQwOw0K
Pj4+Pj4gK8KgwqDCoMKgwqDCoCB9Ow0KPj4+Pj4gKw0KPj4+Pj4gK8KgwqDCoMKgwqDCoCBjaG9z
ZW4gew0KPj4+Pj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgc3Rkb3V0LXBhdGggPSAi
c2VyaWFsMDoxMTUyMDBuOCI7DQo+Pj4+PiArwqDCoMKgwqDCoMKgIH07DQo+Pj4+PiArDQo+Pj4+
PiArwqDCoMKgwqDCoMKgIGdwaW8tcmVzdGFydCB7DQo+Pj4+PiArwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoCBjb21wYXRpYmxlID0gImdwaW8tcmVzdGFydCI7DQo+Pj4+PiArwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoCBncGlvcyA9IDwmZ3BpbyA1NiBHUElPX0FDVElWRV9MT1c+Ow0K
Pj4+Pj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgcHJpb3JpdHkgPSA8MjAwPjsNCj4+
Pj4+ICvCoMKgwqDCoMKgwqAgfTsNCj4+Pj4+ICsNCj4+Pj4+ICvCoMKgwqDCoMKgwqAgaTJjbXV4
IHsNCj4+Pj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGNvbXBhdGlibGUgPSAiaTJj
LW11eC1ncGlvIjsNCj4+Pj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgICNhZGRyZXNz
LWNlbGxzID0gPDE+Ow0KPj4+Pj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgI3NpemUt
Y2VsbHMgPSA8MD47DQo+Pj4+PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBtdXgtZ3Bp
b3MgPSA8JnNncGlvX291dCAzIDIgR1BJT19BQ1RJVkVfSElHSD4sDQo+Pj4+PiArwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCA8JnNncGlvX291dCAz
IDMgR1BJT19BQ1RJVkVfSElHSD47DQo+Pj4+PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oCBpMmMtcGFyZW50ID0gPCZpMmM0PjsNCj4+Pj4+ICsNCj4+Pj4+ICvCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgIGkyYzRfMDogaTJjQDEgew0KPj4+Pj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHJlZyA9IDwxPjsNCj4+Pj4+ICvCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAjYWRkcmVzcy1jZWxscyA9IDwxPjsNCj4+
Pj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAjc2l6ZS1j
ZWxscyA9IDwwPjsNCj4+Pj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIH07DQo+Pj4+
PiArDQo+Pj4+PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBpMmM0XzE6IGkyY0AyIHsN
Cj4+Pj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCByZWcg
PSA8Mj47DQo+Pj4+PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqAgI2FkZHJlc3MtY2VsbHMgPSA8MT47DQo+Pj4+PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqAgI3NpemUtY2VsbHMgPSA8MD47DQo+Pj4+PiArwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoCB9Ow0KPj4+Pj4gK8KgwqDCoMKgwqDCoCB9Ow0KPj4+Pj4gKw0K
Pj4+Pj4gK8KgwqDCoMKgwqDCoCBzZnAwOiBzZnAwIHsNCj4+Pj4+ICvCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgIGNvbXBhdGlibGUgPSAic2ZmLHNmcCI7DQo+Pj4+PiArwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoCBpMmMtYnVzID0gPCZpMmM0XzA+Ow0KPj4+Pj4gK8KgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqAgbG9zLWdwaW9zID0gPCZzZ3Bpb19pbiAxIDAgR1BJT19BQ1RJVkVf
SElHSD47DQo+Pj4+PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBtb2QtZGVmMC1ncGlv
cyA9IDwmc2dwaW9faW4gMSAxIEdQSU9fQUNUSVZFX0xPVz47DQo+Pj4+PiArwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoCBtYXhpbXVtLXBvd2VyLW1pbGxpd2F0dCA9IDwyNTAwPjsNCj4+Pj4+
ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHR4LWRpc2FibGUtZ3Bpb3MgPSA8JnNncGlv
X291dCAzIDAgR1BJT19BQ1RJVkVfTE9XPjsNCj4+Pj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgIHR4LWZhdWx0LWdwaW9zID0gPCZzZ3Bpb19pbiAwIDIgR1BJT19BQ1RJVkVfSElHSD47
DQo+Pj4+PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCByYXRlLXNlbGVjdDAtZ3Bpb3Mg
PSA8JnNncGlvX291dCAyIDANCj4+Pj4+IEdQSU9fQUNUSVZFX0hJR0g+Ow0KPj4+Pj4gK8KgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgcmF0ZS1zZWxlY3QxLWdwaW9zID0gPCZzZ3Bpb19vdXQg
MiAxDQo+Pj4+PiBHUElPX0FDVElWRV9ISUdIPjsNCj4+Pj4+ICvCoMKgwqDCoMKgwqAgfTsNCj4+
Pj4+ICsNCj4+Pj4+ICvCoMKgwqDCoMKgwqAgc2ZwMTogc2ZwMSB7DQo+Pj4+PiArwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoCBjb21wYXRpYmxlID0gInNmZixzZnAiOw0KPj4+Pj4gK8KgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgaTJjLWJ1cyA9IDwmaTJjNF8xPjsNCj4+Pj4+ICvCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGxvcy1ncGlvcyA9IDwmc2dwaW9faW4gMSAyIEdQSU9f
QUNUSVZFX0hJR0g+Ow0KPj4+Pj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgbW9kLWRl
ZjAtZ3Bpb3MgPSA8JnNncGlvX2luIDEgMyBHUElPX0FDVElWRV9MT1c+Ow0KPj4+Pj4gK8KgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgbWF4aW11bS1wb3dlci1taWxsaXdhdHQgPSA8MjUwMD47
DQo+Pj4+PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB0eC1kaXNhYmxlLWdwaW9zID0g
PCZzZ3Bpb19vdXQgMyAxIEdQSU9fQUNUSVZFX0xPVz47DQo+Pj4+PiArwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoCB0eC1mYXVsdC1ncGlvcyA9IDwmc2dwaW9faW4gMCAzIEdQSU9fQUNUSVZF
X0hJR0g+Ow0KPj4+Pj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgcmF0ZS1zZWxlY3Qw
LWdwaW9zID0gPCZzZ3Bpb19vdXQgMiAyDQo+Pj4+PiBHUElPX0FDVElWRV9ISUdIPjsNCj4+Pj4+
ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHJhdGUtc2VsZWN0MS1ncGlvcyA9IDwmc2dw
aW9fb3V0IDIgMw0KPj4+Pj4gR1BJT19BQ1RJVkVfSElHSD47DQo+Pj4+PiArwqDCoMKgwqDCoMKg
IH07DQo+Pj4+PiArfTsNCj4+Pj4+ICsNCj4+Pj4+ICsmZmx4MCB7DQo+Pj4+PiArwqDCoMKgwqDC
oMKgIGF0bWVsLGZsZXhjb20tbW9kZSA9IDxBVE1FTF9GTEVYQ09NX01PREVfVVNBUlQ+Ow0KPj4+
Pj4gK8KgwqDCoMKgwqDCoCBzdGF0dXMgPSAib2theSI7DQo+Pj4+PiArfTsNCj4+Pj4+ICsNCj4+
Pj4+ICsmZmx4MyB7DQo+Pj4+PiArwqDCoMKgwqDCoMKgIGF0bWVsLGZsZXhjb20tbW9kZSA9IDxB
VE1FTF9GTEVYQ09NX01PREVfU1BJPjsNCj4+Pj4+ICvCoMKgwqDCoMKgwqAgc3RhdHVzID0gIm9r
YXkiOw0KPj4+Pj4gK307DQo+Pj4+PiArDQo+Pj4+PiArJmZseDQgew0KPj4+Pj4gK8KgwqDCoMKg
wqDCoCBhdG1lbCxmbGV4Y29tLW1vZGUgPSA8QVRNRUxfRkxFWENPTV9NT0RFX1RXST47DQo+Pj4+
PiArwqDCoMKgwqDCoMKgIHN0YXR1cyA9ICJva2F5IjsNCj4+Pj4+ICt9Ow0KPj4+Pg0KPj4+PiBB
bHRob3VnaCB0aGVyZSBpcyAxOjEgbWFwcGluZyBiL3cgaWRzIG9mIGZsZXhjb21zIGFuZCB0aGUg
ZW1iZWRkZWQNCj4+Pj4gYmxvY2tzDQo+Pj4+IChmbHhYIGhhcyB1c2FydFgsIGkyY1gsIHNwaVgp
IGFuZCB0aGVyZSBpcyBub3RoaW5nIHdyb25nIHdpdGggdGhlDQo+Pj4+IGFwcHJvYWNoDQo+Pj4+
IGhlcmUgSSBmb3VuZCBhIGJpdCBoYXJkIHRvIGZvbGxvdyBpZiB0aGUgY29ycmVzcG9uZGVudCBl
bWJlZGRlZCBibG9jaw0KPj4+PiAoaTJjLCBzcGksIHVzYXJ0KSBpcyBlbmFibGVkIG9yIG5vdC4N
Cj4+Pg0KPj4+IEkga25vdyBhbmQgSSBoYWQgdGhlIHNhbWUgZmVlbGluZywgYnV0IEkgZG9uJ3Qg
d2FudCB0byBoYXZlIHRoZQ0KPj4+IHN1Ym5vZGVzIChtYXRjaGVkIGJ5IG5hbWUpIGluIHRoZXNl
IG5vZGVzLsKgIEkuZS4gSSB3YW50IHRvIGF2b2lkDQo+Pj4gc29tZXRoaW5nIGxpa2U6DQo+Pj4N
Cj4+PiAmZmx4NCB7DQo+Pj4gwqDCoMKgwqDCoMKgIGF0bWVsLGZsZXhjb20tbW9kZSA9IDxBVE1F
TF9GTEVYQ09NX01PREVfVFdJPjsNCj4+PiDCoMKgwqDCoMKgwqAgc3RhdHVzID0gIm9rYXkiOw0K
Pj4+DQo+Pj4gwqDCoMKgwqDCoMKgIGkyY0A2MDAgew0KPj4+IMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgIHBpbmN0cmwtMCA9IDwmZmM0X2JfcGlucz47DQo+Pj4gwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqAgcGluY3RybC1uYW1lcyA9ICJkZWZhdWx0IjsNCj4+PiDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoCBzdGF0dXMgPSAib2theSI7DQo+Pj4gwqDCoMKgwqDCoMKgIH07DQo+Pj4gfTsN
Cj4+DQo+PiBBbGwgdGhlIG90aGVyIEFUOTEgRFRzIGFyZSB1c2luZyB0aGUgYWJvdmUgZm9ybWF0
ICsgdGhlIHNwZWNpZmljIGxhYmVsDQo+PiBpbg0KPj4gZnJvbnQgb2YgdGhlIHN1Ym5vZGUsIGUu
ZzoNCj4+DQo+PiDCoMKgwqDCoMKgIGkyY1g6IGkyY0A2MDAgew0KPj4NCj4+Pg0KPj4+IElmIHNv
bWVvbmUgcmVuYW1lcyB0aGUgc3Vibm9kZSBpbiB0aGUgZHRzaSwgaXQgbWlnaHQgZWFzaWx5IGJl
DQo+Pj4gb3Zlcmxvb2tlZCBpbiB0aGUgYm9hcmQgZmlsZXMuIEhhdmluZyB0aGUgaGFuZGxlIHdp
bGwgcmFpc2UgYW4NCj4+PiBlcnJvci4NCj4+DQo+PiBJZiB1c2luZyBsYWJlbCArIG5vZGUgbmFt
ZSBhcyBwb2ludGVkIGFib3ZlIHRoZXJlIHdpbGwgYmUgYW4gZXJyb3INCj4+IHRocm93bg0KPj4g
Zm9yIHlvdXIgc2NlbmFyaW8uDQo+IA0KPiBGYWlyIGVub3VnaC4gWW91J2xsIGdldCBhIGR1cGxp
Y2F0ZSByZWZlcmVuY2UgZXJyb3IgYXMgbG9uZyBhcw0KPiB0aGUgcmVmZXJlbmNlIGl0c2VsZiBp
c24ndCByZW5hbWVkIGVpdGhlci4NCj4gDQo+IEJ1dCB0byBtYWtlIGl0IHNob3J0LCB1bmxlc3Mg
eW91IGZvcmNlIG1lIHRvbywgSSdkIGxpa2UNCj4gdG8ga2VlcCB0aGUgY2hpbGQgbm9kZSBhcyBp
cyBhbmQgbm90IGFzIGEgc3Vibm9kZSBvZg0KPiB0aGUgZmxleGNvbS4gSSBqdXN0IGRvbid0IHdh
bnQgdG8gcmVwZWF0IHRoZSBuYW1lIGlmDQo+IHRoZXJlIGlzIG5vIHJlYXNvbiBhbmQgSSBsaXZl
IHdpdGggdGhlIGZhY3QgdGhhdCB0aGV5DQo+IGFyZSBub3QgbmVhciBlYWNoIG90aGVyIDopDQoN
ClRvIG1lIGl0IGVhc3kgdG8gZm9sbG93IHdpdGggdGhlIGN1cnJlbnQgYXBwcm9hY2ggYWRvcHRl
ZCBieSBhbGwgQVQ5MQ0KdGFyZ2V0cy4gSWYgeW91IGtub3cgdGhhdCBhbGwgZmxleGNvbVggc3Vi
bm9kZXMgaGF2ZSB0aGUgWCBpbiB0aGVpciBuYW1pbmcNCihlLmcuIGkyYzMsIHNwaTMsIHVhcnQz
IGFyZSBjaGlsZHMgb2YgZmxleGNvbTMpIHRoZW4gaXRzIGVhc3kgdG8gZm9sbG93IGl0DQphbHNv
LiBCdXQgMXN0IHRpbWUgb3BlbmluZyB0aGUgZHRzIGZpbGUgeW91IHByb2JhYmx5IGRvbid0IGtu
b3cgdGhpcy4NCg0KVGhhbmsgeW91LA0KQ2xhdWRpdSBCZXpuZWENCg0KPiANCj4gVGhhdCBmbGV4
Y29tLW1vZGUgY291bGQgYWxzbyBiZSBkZWR1Y2VkIGZyb20gdGhlIGVuYWJsZWQNCj4gY2hpbGRy
ZW4sIGJ0dy4NCj4gDQo+Pj4gQW5kIGJlY2F1c2UgdGhlIG5vZGUgcmVmZXJlbmNlcyBzaG91bGQg
YmUgc29ydGVkIGFscGhhYmV0aWNhbGx5DQo+Pj4gaXQgd2lsbCBiZSBjbHV0dGVyZWQgYXJvdW5k
IGluIHRoZSBmaWxlLiBZb3UgY291bGQgcmVuYW1lIHRoZQ0KPj4+IHJlZmVyZW5jZXMgdG8gZmx4
NF9pMmMgdGhvdWdoLiBCdXQgSSBkb24ndCBrbm93IGl0IGl0cyB3b3J0aA0KPj4+IHRoZSBlZmZv
cnRzLiBMZXQgbWUga25vdyB3aGF0IHlvdSB0aGluay4NCj4gDQo+IC1taWNoYWVsDQoNCg==
