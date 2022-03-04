Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9DD34CCFD6
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Mar 2022 09:21:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232932AbiCDIWH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Mar 2022 03:22:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229862AbiCDIWC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Mar 2022 03:22:02 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 486B1199D53;
        Fri,  4 Mar 2022 00:21:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1646382073; x=1677918073;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=LQtDDR5KzQSoMawxQ6M+iidyR2otYvidhWegN66Dwec=;
  b=WVi9BNCaOkz1srHn2XppiS5KgQFWTGP/4z7lcdFIjRgAHc93ZpZUdBaH
   3KZHSXnt0wKlbVucXeBUzFZAcfSj20FLf6qwQdwFocfHHXxj7FWbkT/7I
   k5sFHRYNHxrQS5kPq4O1KGWbfU2cqmgTXxh+zNG7ghtmlg9GSa4j0uUW5
   yBqQOBY+mIE0JeOEifGtpXvL47PpAvC2kW6kqSly367xNacVR88xQHvc0
   pKJCiiOEWcRfPDMEPFCO7iJSAITVU6Ze0+zmcWGl0yzsBf0fb/VAIlEdX
   2OJ+B8D3ENdo+yOSWSIp3y2kZeaKznSLVmkdFo2NfHzLWNWxKJZ1Ut3z3
   A==;
X-IronPort-AV: E=Sophos;i="5.90,154,1643698800"; 
   d="scan'208";a="150838586"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 04 Mar 2022 01:21:12 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Fri, 4 Mar 2022 01:21:11 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17 via Frontend Transport; Fri, 4 Mar 2022 01:21:11 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dU4GkGcKtmISo9fg8Iaesb5WnUOSGc/pGsyjDBQ5ewRF/IL4wQBA7OCF/P8Ub5f8Yurth6L6T0r1YnAuHID5A9m4zBTfy3Xi+r0OBhP1QT7mQvNP3AYwq75dEPEx7oqroyXUSyHlQUyqJVMQRGXfF58sQX6pUBn2JMVnuUQfkKYfg8V7Xbg/0zgq4GQYFYei2f17x9Y+J+mj9X6zsgXm4smBrYVN1hamR0R3WdWU7DJUaOISt56Jsxohvbq/rM6OG3uG1KLezhR12twatYlye651BARJE/ABe4vnYpqabLLgN+UQn4Rb70to2TFzq7AuFhXADItZG+MOZez8iuBJPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LQtDDR5KzQSoMawxQ6M+iidyR2otYvidhWegN66Dwec=;
 b=FVHg85UNgGu++tVNiKmOpc1tFedDE4bXD+0AiV/H9jy3QevU7leqntuF1fjI+ykLsWb0Ak3MYHTAqasCdeT6tmAHExouYIawStxutWIoOeHZYx4qWgBKK2KjA7LKhmUPG3VwjqIRoUSw0DMvRAavdMMPY1X/BX7YKrwN70uDlbWPMKry1iXjBGt9vX20oiv/PKo8Gs5HDiPtK2Vi2tCPe2uhHYNZb9MVomrQT1pYakJbTOR1xjYAiVmJ2TQpURv7N13Eeg4X6ghFKDw0MAswI7HjOni2f5R/LOA0plEfL8rIoNzYEqVl+yLzMsFjFelFl6+oyXYIPLikLstY8aQ6wg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LQtDDR5KzQSoMawxQ6M+iidyR2otYvidhWegN66Dwec=;
 b=QFLAgIaqpBd86jllsZaLnsUvkOHUZj/VBxunN77/ul7+HkMrJWTdhWUbVo+WxmIlA0OmMYDtq+iXBSEKPeL3Zc8CRMwE7GvzR9suEEzoBpsoAutW1lJwb4JDOMSLmC9kDLtPw091WJ4Kz2yACmz0DSWOqkJUA1qtuKG68pyYIX8=
Received: from CO1PR11MB4769.namprd11.prod.outlook.com (2603:10b6:303:91::21)
 by SN6PR11MB3118.namprd11.prod.outlook.com (2603:10b6:805:dc::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.13; Fri, 4 Mar
 2022 08:21:10 +0000
Received: from CO1PR11MB4769.namprd11.prod.outlook.com
 ([fe80::6d66:3f1d:7b05:660b]) by CO1PR11MB4769.namprd11.prod.outlook.com
 ([fe80::6d66:3f1d:7b05:660b%5]) with mapi id 15.20.5038.017; Fri, 4 Mar 2022
 08:21:09 +0000
From:   <Claudiu.Beznea@microchip.com>
To:     <michael@walle.cc>, <Kavyasree.Kotagiri@microchip.com>,
        <Nicolas.Ferre@microchip.com>
CC:     <arnd@arndb.de>, <olof@lixom.net>, <soc@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski@canonical.com>,
        <alexandre.belloni@bootlin.com>
Subject: Re: [PATCH v1 1/6] ARM: dts: lan966x: swap dma channels for crypto
 node
Thread-Topic: [PATCH v1 1/6] ARM: dts: lan966x: swap dma channels for crypto
 node
Thread-Index: AQHYL6DNbwSZBNGfnUCaEGdMugp8Yg==
Date:   Fri, 4 Mar 2022 08:21:09 +0000
Message-ID: <4de4a132-46d8-c8f7-dfe0-e9fae5dee808@microchip.com>
References: <20220303160323.3316317-1-michael@walle.cc>
 <20220303160323.3316317-2-michael@walle.cc>
In-Reply-To: <20220303160323.3316317-2-michael@walle.cc>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 724969fe-8fc8-45a0-1f94-08d9fdb7f00f
x-ms-traffictypediagnostic: SN6PR11MB3118:EE_
x-microsoft-antispam-prvs: <SN6PR11MB3118268376DE250B345B2E8287059@SN6PR11MB3118.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 6JyC21+HbFsJd5V4EL2ncoj1L+as89ofKHHxYzdxzbaTevKSX0w2QJe+7zdVU1PNepspWA/dUpw42vPe5l1wq3KoAgfy8+q7/gZNpQaMqfQojWo0LMBjXl82eGFSMnhRW/Nr9UdFa0MxCQz4AM6WoWEZx/greUEdEUZ8KF7gnDk5cYU3b6GqFNQUHzdcJr1LNDOBIeMIUarhlcL4c1BGEjzCwDV8ZfMg1PzPvqW8KiRenj5rfbbFthsuuFom4BGAmqfK8CAj8wQBANqyUYL/AsqhtKiP/1ULohASNhZ1gjppnMgG/dy/b04Oytcg/K8LLxYiKg0NxNgsMNMydChvN8UyNbJWBR34+hW0Jp9F150oW8EG1bZl1iQUKWTY5WJVrGROaPmRmxzB+oije7Mr61MsCfvr+kb6wMLAgP19KFqRKYQ1V0sObCAk75/1BQseFo3L8SWMlqxpdnmfQvfIbvANVs3Bjag7ANgg//Vjtl9DgKJtMWkIavnaqjfQ3bBlAnNi3yH/xqq3R5aauTmO9hyZpM28Ua13j83KXy7YbCe+IS4HAHIHhWyYzaBmajt2qeoR+M5il7NkcEUX+LJGLjcekfKe5IKfvw0zTWjdPW6wIydcB3B2NrRUlw7cSxuBc/19AwIA/6kfvfTkmgjiZfhRA6dyd4fjNPMPPwD9sZejr4G307tVZ/VRtWpGFFaJwz2Zc91AsSAT9GwlH45uMVJ3Hw6/TPB5pyg5b9h2SOebgC9ddS7UWwQ0vM5tPwmu1q3xaO13LkTrGEG5WCziNQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB4769.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(122000001)(7416002)(5660300002)(508600001)(38100700002)(38070700005)(8936002)(26005)(186003)(2616005)(71200400001)(6636002)(6506007)(6486002)(53546011)(6512007)(110136005)(54906003)(66946007)(4326008)(8676002)(64756008)(66446008)(66476007)(76116006)(66556008)(316002)(83380400001)(91956017)(2906002)(86362001)(31696002)(36756003)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?S21GaDRFQWRnMWdWckNzNm1lcFpXa2VqOVRZMVgzL1NPTlNuZzJxK2NqWDBp?=
 =?utf-8?B?UkhlMGZWeSt4NHcxdGcxUE01eGNXc2pjc1lRMzZxSDZyNUFnQ1lPV2tFRmxL?=
 =?utf-8?B?bUdPWkZQOU5OaGhQazEyN1BQRGxMU3dtenBnVnIxRlZ3S1FGbm1wNlcrZnBP?=
 =?utf-8?B?d29FdE1YZjZLNkI2bmR3aHhxZnNyb0dJbTRtV0QvVWRrNUQ5a3E2dUtYeXp3?=
 =?utf-8?B?dXRKb1JhckJ5UDcvenloTUlmOHhpV3VRVUNaWEhxOEJUdFZOVzhTek00TSt3?=
 =?utf-8?B?WjVQOEFMVHMxemtJZWdZbFlmMHRWZ3d0S2Izbk9PQmFaWnphM24xa1hKT1FH?=
 =?utf-8?B?ckZZMGRZMXV4SWt1VjVLQ1o3WUI5OHZPQ2xyS3BYQnl5TmtOVG0vTkpIRmpr?=
 =?utf-8?B?b2J4aC92K0FrdXQ0bGJFTTFsYStoUGlySjl6b2x3Vnk3S0M2cTVuM05OUG56?=
 =?utf-8?B?a1d5ZThYaGFXdW5FRVFIK3VrUGZoQWxEUzNiRlpSVzJWQ2xIdnppSkZNdEg0?=
 =?utf-8?B?Yjhwbklxd2tNVTBDamcxZWwvZGg2OFowWWE5VmoreXhtOHI3aEZKZThIaHZx?=
 =?utf-8?B?eWlnSU9hNThVN0lhdzZCYkdrZDJxMy9XakUyeHNpcEx4NEMrRFdoRm9BMnZq?=
 =?utf-8?B?WDdqQVNScnJSNnIvMy9MbjZaNnZIM3lKckMwVVNNck54SVBGSjBraFFqRjNs?=
 =?utf-8?B?cUI3ZFJYYlBya3pXQ2IzNDRjUFlKUW5IVWdyUWJGRFNmZGlrZUlWeGNxUm5B?=
 =?utf-8?B?SVpsV3ZFR3lVc1VVS2NIT1g0b1lNOHBBeVFnakg3MndFaEZUbERlTzlXcHdV?=
 =?utf-8?B?YmVVR1NlOWN0dHdwS0h5VzJpSnkrdjFEK1ZsVlU1UlpiL0NWQmFrbkNVVGNo?=
 =?utf-8?B?Y2s3SUJzczV5cGtuSlNXbGU2czZ1bXdBeVZvOVV1UkVTSGY1RlRPTzZRWHlE?=
 =?utf-8?B?T3hiY0ZoT2JKbUc1eUNCS093cjhQVHA0L1pYUkh5Z2llSml1SzdaYXZOdmNw?=
 =?utf-8?B?OWdLZ3FrQUZqSHNOUkNaeXh5ZWZiaVdtdzh1Zk8zWWgzeUdWVjNXL29IeUtM?=
 =?utf-8?B?N2pyWnE5blZKdkhKT0dXT3FFQWpld2xwaWY0ZXpxWmlFeHdXRFU1alIxZ2h2?=
 =?utf-8?B?S3Q5WkdVT0dyUmNKMDhTYmNWMGZKMWhqWkQ1T3AzajFVWGFjRDhlaTNVZ2ph?=
 =?utf-8?B?dlM2ZDZQaFNWSmh3Y3AxN3VmeVFabDJhc0Q5QjErNnlLei9OaWRpVnNySmFu?=
 =?utf-8?B?N0xaYTVuZzMzMm1qY0M4b2QxcXAyM0pWcTJzdnJSSmsvZjNsQ21Fc0R1a0VZ?=
 =?utf-8?B?UWVnOW5JWVRwMjJwNHBFMzZhK2dSVmE0NDl0QTBkeU5mY2VHZGd3QStHbFRB?=
 =?utf-8?B?alVtSEl0NWNCN01nOE13NDFzVlpyMUxrWEVxbWtKWmVSUlRmU2VWOWJJL1oz?=
 =?utf-8?B?UFBaa2ZWbVlhRWdCdktnbGM5aDE0MFRXNGluR2REV1NVcHRKS1hidnFtUVVS?=
 =?utf-8?B?c0RZczBybTR0dmZJenpPL1Z0Z3lqYmZsZlM2Y0syb2F1RkwwWGwzMmlROWlp?=
 =?utf-8?B?cW1FbjhwWktEWUwrS1NoUkhyL2xKS3ViMUNMTHVlTHJ0bHdBV1NwYzNJWklt?=
 =?utf-8?B?Q2tHZTc5OUlPMmd4M1FBZWNoc3o0d3dqN3BCa2VqZXZ3dHZvRGNuTktZWWov?=
 =?utf-8?B?OTkyVXJwMHh5UHRWRHlKYzlSOUhGZGJjU1pCYjNMTXArMm9oOVFRelA4cm1E?=
 =?utf-8?B?bGZLOGd1U29FQ0xJTU5vTS9VeGpXL29nUWdYNnJJRTJwTXdDTWlWVmtYQzJO?=
 =?utf-8?B?N1lLUFlXK1prQWYxRHNYSlEzQmpZNWF0cTB2cnIrTnpVUFJPNjZWU2lyUVVz?=
 =?utf-8?B?L3ptODBKTlorZHJsMzVOaG1vQzFzZjBtM21YS3VtODNES3NJS05Pbjdsb2hy?=
 =?utf-8?B?QTNieHRtd1diVFhZQ1YzZjR1OWhKT0ZxZXBIWnh4MEZhQmdCNWZuUjRzZkhT?=
 =?utf-8?B?THVBSjcrdVJEOHhvamlMcFpLSzhKa0krbXdoWlMxWFNPekVtUlVuWGt1dm9W?=
 =?utf-8?B?MlZjblp3RG9uYVpLSVZGMm9XUnM4MisrdlNwVmtkOFg1MmppV2VsaGRMbDZH?=
 =?utf-8?B?T3lDUnFGTHA2WVFvYUNiR1ZxSy9kV1NlR2Y5OVY2YjU3dStlY0dtRXhvQUk4?=
 =?utf-8?B?NXZZR1FNU0hoS0FiTnlZS2x4WWkzYlJPSTEvbzhCQ2RId0ZKQmJMaXNtQUNp?=
 =?utf-8?B?SjJZOWRpMy9vd1g1QmJXZEpnZjBBPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F226D1D55BBAD74DAF235751373CF631@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB4769.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 724969fe-8fc8-45a0-1f94-08d9fdb7f00f
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Mar 2022 08:21:09.6737
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bviEMunMa1lUz9iWGVr4B7srRIAeEq5B5Jqm7AZ7qpHl/T8LSVldEZoSJCsIEVPuY/TDzPKidHyr/2a5Lxoe9Gm1rEWW32cZRImM5RRwgmk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR11MB3118
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,T_SCC_BODY_TEXT_LINE,
        T_SPF_PERMERROR autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMDMuMDMuMjAyMiAxODowMywgTWljaGFlbCBXYWxsZSB3cm90ZToNCj4gRVhURVJOQUwgRU1B
SUw6IERvIG5vdCBjbGljayBsaW5rcyBvciBvcGVuIGF0dGFjaG1lbnRzIHVubGVzcyB5b3Uga25v
dyB0aGUgY29udGVudCBpcyBzYWZlDQo+IA0KPiBUaGUgWUFNTCBiaW5kaW5nIChjcnlwdG8vYXRt
ZWwsYXQ5MXNhbTlnNDYtYWVzLnlhbWwpIG1hbmRhdGVzIHRoZSBvcmRlcg0KPiBvZiB0aGUgY2hh
bm5lbHMuIFN3YXAgdGhlbSB0byBwYXNzIGRldmljZXRyZWUgdmFsaWRhdGlvbi4NCj4gDQo+IEZp
eGVzOiAyOTBkZWFhMTBjNTAgKCJBUk06IGR0czogYWRkIERUIGZvciBsYW45NjYgU29DIGFuZCAy
LXBvcnQgYm9hcmQgcGNiODI5MSIpDQo+IFNpZ25lZC1vZmYtYnk6IE1pY2hhZWwgV2FsbGUgPG1p
Y2hhZWxAd2FsbGUuY2M+DQoNClJldmlld2VkLWJ5OiBDbGF1ZGl1IEJlem5lYSA8Y2xhdWRpdS5i
ZXpuZWFAbWljcm9jaGlwLmNvbT4NCg0KPiAtLS0NCj4gIGFyY2gvYXJtL2Jvb3QvZHRzL2xhbjk2
NnguZHRzaSB8IDYgKysrLS0tDQo+ICAxIGZpbGUgY2hhbmdlZCwgMyBpbnNlcnRpb25zKCspLCAz
IGRlbGV0aW9ucygtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2FyY2gvYXJtL2Jvb3QvZHRzL2xhbjk2
NnguZHRzaSBiL2FyY2gvYXJtL2Jvb3QvZHRzL2xhbjk2NnguZHRzaQ0KPiBpbmRleCA3ZDI4Njk2
NDgwNTAuLjVlOWNiYzhjZGNiYyAxMDA2NDQNCj4gLS0tIGEvYXJjaC9hcm0vYm9vdC9kdHMvbGFu
OTY2eC5kdHNpDQo+ICsrKyBiL2FyY2gvYXJtL2Jvb3QvZHRzL2xhbjk2NnguZHRzaQ0KPiBAQCAt
MTE0LDkgKzExNCw5IEBAIGFlczogY3J5cHRvQGUwMDRjMDAwIHsNCj4gICAgICAgICAgICAgICAg
ICAgICAgICAgY29tcGF0aWJsZSA9ICJhdG1lbCxhdDkxc2FtOWc0Ni1hZXMiOw0KPiAgICAgICAg
ICAgICAgICAgICAgICAgICByZWcgPSA8MHhlMDA0YzAwMCAweDEwMD47DQo+ICAgICAgICAgICAg
ICAgICAgICAgICAgIGludGVycnVwdHMgPSA8R0lDX1NQSSA1MyBJUlFfVFlQRV9MRVZFTF9ISUdI
PjsNCj4gLSAgICAgICAgICAgICAgICAgICAgICAgZG1hcyA9IDwmZG1hMCBBVDkxX1hETUFDX0RU
X1BFUklEKDEzKT4sDQo+IC0gICAgICAgICAgICAgICAgICAgICAgICAgICAgICA8JmRtYTAgQVQ5
MV9YRE1BQ19EVF9QRVJJRCgxMik+Ow0KPiAtICAgICAgICAgICAgICAgICAgICAgICBkbWEtbmFt
ZXMgPSAicngiLCAidHgiOw0KPiArICAgICAgICAgICAgICAgICAgICAgICBkbWFzID0gPCZkbWEw
IEFUOTFfWERNQUNfRFRfUEVSSUQoMTIpPiwNCj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgIDwmZG1hMCBBVDkxX1hETUFDX0RUX1BFUklEKDEzKT47DQo+ICsgICAgICAgICAgICAgICAg
ICAgICAgIGRtYS1uYW1lcyA9ICJ0eCIsICJyeCI7DQo+ICAgICAgICAgICAgICAgICAgICAgICAg
IGNsb2NrcyA9IDwmbmljX2Nsaz47DQo+ICAgICAgICAgICAgICAgICAgICAgICAgIGNsb2NrLW5h
bWVzID0gImFlc19jbGsiOw0KPiAgICAgICAgICAgICAgICAgfTsNCj4gLS0NCj4gMi4zMC4yDQo+
IA0KDQo=
