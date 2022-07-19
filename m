Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E15FA579494
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 09:52:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237000AbiGSHwj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jul 2022 03:52:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234348AbiGSHwi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 03:52:38 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D9E61DA47;
        Tue, 19 Jul 2022 00:52:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1658217157; x=1689753157;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=xCveIQ8/JG/ookDlbO7I3u59hP8R61D0NHE4QEoCLpk=;
  b=P50Lwuwsa4N4yBySlBq6gRNcYPBVgz9fVpbNpUkqA0YEJoPTb1kKtPDR
   /t4DN+HTk0ObjT3T6vyEUzrSzUGeQ+GdgkJrh8ITNbnacpqWb0TaGIOBr
   vWoLJAbHf7JAkI8NtFN+vvNDKTyTN0Gb2qANIpek5Gj0CT0ch6giTV4UF
   Y+neh7bo71KuSHy7c30P0vXX5RbbbaXowbxMLbujNnpYX48Ml1rQPtED0
   zKbj1Sh/J8sOdPafQ2UsDJYwUeesVrY69YGm7ITpl7PUTLnVKohmohIFI
   My58ujBM444MfAaECw8XPRxzkjrQwPeHWgfje6oefbnzx7MlYytbXmOIl
   g==;
X-IronPort-AV: E=Sophos;i="5.92,283,1650956400"; 
   d="scan'208";a="105086134"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 19 Jul 2022 00:52:36 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Tue, 19 Jul 2022 00:52:36 -0700
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17 via Frontend
 Transport; Tue, 19 Jul 2022 00:52:35 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PKfhkeUHFcTrbipruZ8XkiQEgLjDY7f4Iz7Xg0ftXvrZz87nTcqmzr/0INqqxRdKL8pF6blcwsFkYC4N2DgTzF4cAijCeMImwZXzuCinZ0VxSBHc4fHhOHqvihHZ1jSBmub9e4Uu2zLaYZzW5ZdpTTZdo3vzsRqvmHwt0CbkR+BVKRyQuCzJHXo8yzXezAU1cbvG5I7QRu/i2leAryWCc9h+6ey5Qc95iOKb0+u1659QAObO7lXiOcdIBG++Zy6h5SNpf59OYDkdXn4EGzFSyaXTsoA8yUfdNd3iW+DpvaZ37Gag1O4Hgxg5CcjKBeyL6zn8fsX0hx3IC+3Y3BCyqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xCveIQ8/JG/ookDlbO7I3u59hP8R61D0NHE4QEoCLpk=;
 b=YDz7bNGWLSrdRVeAE+LLx2XKbA0GXCXdI8HQpedWoykkDy5l56cqS+ARj0QxBdFHZ+d3QvcFrlw2KgK63UhJplzXflu8G81MDNV5Jlq1N04cQ8dzefXHNu3ELur4DL7CaAKfOt7Eml4yH4MZKrhn+nROqfSYoeOdovYMPf5iwoCZwNWJAx3XopPQdGY9tqj5wFRbXGCu8CIqWeEr3t5k3qLCY1nKoCrUUYLWxrttRS9ROCBjYYdzUDrCyIYWgqrNHjLrrABqeXXnAvqTNjZQwFnCJYdM2UBcwvEIczI84IiOr1m6k+OQw4whbcNtgaaZQJeX5V1aJkU0fdZa8XcjVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xCveIQ8/JG/ookDlbO7I3u59hP8R61D0NHE4QEoCLpk=;
 b=jqYNdlFLDx6GmNVYUklNoQCYCFUuX90gea1CqcjE6C+fpenmUvq7tZraLHU1rpK5TyWn46nw3mk+G/CH1n/eFs7h4W5HEbh+8rbBdedk35Kjd+0PSdbphUeVP+lyb9yK81Xp5sGbLzkXAclHkDNbsqrmSpWT+rhgrbACGPJ9mWc=
Received: from BN6PR11MB1953.namprd11.prod.outlook.com (2603:10b6:404:105::14)
 by DM5PR1101MB2156.namprd11.prod.outlook.com (2603:10b6:4:51::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.17; Tue, 19 Jul
 2022 07:52:30 +0000
Received: from BN6PR11MB1953.namprd11.prod.outlook.com
 ([fe80::5c8c:c31f:454d:824c]) by BN6PR11MB1953.namprd11.prod.outlook.com
 ([fe80::5c8c:c31f:454d:824c%8]) with mapi id 15.20.5438.023; Tue, 19 Jul 2022
 07:52:29 +0000
From:   <Claudiu.Beznea@microchip.com>
To:     <Horatiu.Vultur@microchip.com>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <Nicolas.Ferre@microchip.com>, <UNGLinuxDriver@microchip.com>,
        <maxime.chevallier@bootlin.com>
Subject: Re: [PATCH 1/3] ARM: dts: lan966x: Add gpio-restart
Thread-Topic: [PATCH 1/3] ARM: dts: lan966x: Add gpio-restart
Thread-Index: AQHYm0R+zLj/0xqhjU+WeLkBtZOTmA==
Date:   Tue, 19 Jul 2022 07:52:29 +0000
Message-ID: <3e0b7137-08d1-fef2-86b5-a48419dd2101@microchip.com>
References: <20220718212921.1506984-1-horatiu.vultur@microchip.com>
 <20220718212921.1506984-2-horatiu.vultur@microchip.com>
In-Reply-To: <20220718212921.1506984-2-horatiu.vultur@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2d4f294a-3fad-415a-b87f-08da695ba160
x-ms-traffictypediagnostic: DM5PR1101MB2156:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: sP719cSjENCWaANcCjS8cjCdmvnVX2am4djn6StpmknZqbUiWp5K2kG0g5Ae8e9o0u1lQ6KIydsHxKdLkIr4H1oRl400/4p73R3xtI8XcMP21SHMVC2mO5n2kXQIrGUXD6B/8s3x3VDhtRlp0SIQb5qGLWivBjzXP/sXHt1O5uL0zREy3VBrXreBgkLEES1qROJG0j7/hkdU/1VEudAWi6hIDD0mufzZ+oJLxZppjGOKukS9a9rRBjNtsq6Tqd+3Q3uNifkAvAdpAB6Sl3OenhxZH8pUCqemGpc9+7zaT5kfBRuhCPBi073EEbknzsdUz4mJnZ68hgYZ+2navxDTfhh/d4gBjrqaVV4U27glCDwb+swTiPhfqsrptHZa6l+PKAwSSlHbcR0x15hkoy7qw6ZJjpQtHhLANm2qWe+WWkZkL2Kjy0DTkE/g0jQCzSL9zk6RdP078f/vb1L2ja7hwtzwkfl3vF7KkL31fOBSI4WmGhisKvQx1AiJ1SUQmg0PPeEKhFggrhrlhALdyQ6ntZHTRb8tVM1hwLhU6CI1LJY+rF0jtsTFVe1IKf9XJbj2/6NJuNwLjhpT8mxx17AeGRAKXYpd/xrjbgLlPyU3+nQIZKQfzZZ8pjxHv1WTMGe86LUlBKvnXM9LV/yF+2D5Khk/wR/hYF6DBf94eVdzQG7k69H/IN1v1Vyfn6njw9SGrjtJBud9YN2cKQVqaYktzXLRLbyvqzDLodWh5d2r24sJkdgcWNxrw+AqMLydUwecMQpm7nxzsxWJ+IiGkwbswM/6mNrEUbfN1IfjqBP3D6hHVH3J0feOYo82CQdSyNL7qBWxn9ex7RIrJHf5j/MvWIb+PCDecABAC6/6r/RRYhEHgBKthZ/fBnWbK5AZ2RGr
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN6PR11MB1953.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(376002)(136003)(346002)(366004)(396003)(39860400002)(4326008)(8676002)(76116006)(66946007)(66556008)(8936002)(64756008)(66446008)(66476007)(316002)(38070700005)(54906003)(122000001)(86362001)(110136005)(31686004)(38100700002)(36756003)(2906002)(91956017)(186003)(26005)(6486002)(5660300002)(53546011)(6506007)(41300700001)(71200400001)(478600001)(31696002)(2616005)(6512007)(4744005)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TTEyM0hjVDFhUS90MHdudjlNUGxEdVMyL2YvK050emtIc1lkS3BlM0xlR3VU?=
 =?utf-8?B?VkROdXJMeFNab3lNc1RIdXRTWUt5K3ZVZ2VNOHNuV0lBV3dGaWk2UHJWV3k0?=
 =?utf-8?B?R3hNc1NiT0FtY3RpTTVUQ3VUc21uTGVrTkp4b3JhOUJ0UDRCNkk3eG5oQ2h6?=
 =?utf-8?B?OXJCbXZQbTI2dG9hWk1wL1pMZDdYQXhibFBVdjhYcW5IK0FyK0U2ZkZucnBk?=
 =?utf-8?B?bnJPY2FwMkFsK2FYQjlwam1tL2ZncTZ2VVRKckx0ZFNCbkpndDQ1eHBJMU0r?=
 =?utf-8?B?djVQVnFJYlJaV3N1cTJqRHBWNU5JajN2aktST3NMWkJIaFBMOVhvdHhSenVw?=
 =?utf-8?B?SWtIS054a0xVeVNHMzVRWGxKSTNxMXREUEhiOHl1TGZKa3c0b2tockZhWVJx?=
 =?utf-8?B?NXVoSXhyak15REdJcCtMZmhRTDB6ZjZONmx2WTQ5SGpSbHpsZ2tIT25rVnA1?=
 =?utf-8?B?emk2TGxCTUk5RnQ5MnpKUmU0aUJLNzFGZkpGU0hxWjNHLzNLVk05b3dIdXR1?=
 =?utf-8?B?MWF0Q3IvMnZmVWhwRVVVMzE4L3M1elFBTEJOWjNVdjkrZ2hIVVVjK3ErMTV6?=
 =?utf-8?B?UXhjZnAyTDM3eHp3YWFVS2NCbDFqd0pYSTViZVY5RVZIOW9hck0yYWVidHFH?=
 =?utf-8?B?alhsK1N2bHh6UTh6RHlIdmRzbWFXVSt4T1BxYkhEcWpybXBHOG5XdlFSRDZE?=
 =?utf-8?B?dEFoNVFWWnJYc2VPa3ZyNks0aFF2cnZhK3dIVmJZMU5WUk0zS0t0WkF5Rmd3?=
 =?utf-8?B?VkhNMUpPbHR0ZVVST3lySDVnSHNyK2pKdTVhU0k1Ty84MGkvZzg5SHJEQzVl?=
 =?utf-8?B?SnJjb0crNm5ZeG9jRzVjOElZcFVBVVRKV1lBU01nSVRXUDNTVTZ5SmJoMnds?=
 =?utf-8?B?RVhEUjFrY005a29TaXNVck1OOHNFTElmSW9majdLMm1UVkpnaFNzcFEwVzdm?=
 =?utf-8?B?U1pDT0RweG1ES3V5YmRsTUROVHBXSjEyME9UeVdIVmZrTmtveGZCekt2NnZs?=
 =?utf-8?B?Sk5aSHhUUExCN0Z5Rlk5c1htRWViWXVvRmk0YW1uR3lGT3hzYWJVQ0YwZThm?=
 =?utf-8?B?blFLS3ZaT1JUU0NGUXJGOUFZWFEybGdXVXh4R0NHSTkwNjliUFptdFhUdWN3?=
 =?utf-8?B?aDI1Y2YxcUU2bHpUaHQ4L29YY0w5QmVOc2MwNnVFSHAxTG1Gbnd0Y2dFS283?=
 =?utf-8?B?RVpER29PZHBnU2JXNmJ3blZldTNIVmpBbWhnUUhGRW9pYnNPdVVEMHZHZFVL?=
 =?utf-8?B?NUNwQk5MR0ZSTkZlcUtVckppNzV6WVoyZFlqcjV2TWJuQ3VjUDI2eFJ1bDd3?=
 =?utf-8?B?ZzJyTjZlQ3JiOEh3Z2x5c01oUlJjTE1ZeUEvd0RVb2lBZ1VZbHRkM0hSTzNM?=
 =?utf-8?B?bnlHWTgxRkZRRzMweG9iS045WVZ6VW96UWZvdmVhejd6L3ZKamQxellTS0Yv?=
 =?utf-8?B?Y2ZOd05DbTBsc1pvOFV2cTRYaTZWMmJlYURabTcrZTJ2eDlEMkRHQ2xHSVox?=
 =?utf-8?B?YUFBa3N3dW5HTWtDRHZySm9ibDBVdDVSTUo4dXFLM1luSkdJYkg0c2hQNXhw?=
 =?utf-8?B?eXN3enVTMVRUck5MNFVEVC84cUdFY1VRUGUwdVVMVlZKMW4wa01uSWpPL0gy?=
 =?utf-8?B?WjQ1N3VSRWJ2Mkd6VkJ6c0VUM2w0ZWluZ0JBdzNyYmI0QVdXUmhaR2N2dXA5?=
 =?utf-8?B?c2Q2M1F4SWFKSytFRlRrNlVYSXNXZmJLOFdETnNSUiswRGhnRnZnRzBZQUVr?=
 =?utf-8?B?d21yR3VVYlljMXRWWEtYQldaa1c4R3FQYkhhRkVGc2dkd010Nng4TWdUeDlH?=
 =?utf-8?B?NGhsVmJlcnkrVHVpWk5NaXdaWXh4Vi9WVFRwSitqdE1UWWxxdnB2QlZqSmZa?=
 =?utf-8?B?dVNENm1PdlQ1RzdhS1VMalNhSy9DdXhaZThpNnBtWkhjVFlGQWJJN0tiMGpy?=
 =?utf-8?B?QThoSnM5TzFZcUpQWWlVZGpKbjBwaVRJNElPVnFIR1NTaFNzRkFDK2NrK0w2?=
 =?utf-8?B?TjJxOTZ6QUtBeHQzUUVoc3JvU0ZKenI5UkhvaUlUbkJCeHNjK0svSUcwMzFY?=
 =?utf-8?B?ekNaZEpjd2pIWWRIakdYeDJHckxpVlhEcXBLdS8vcnp4SmFsU2lDR2VJRzFJ?=
 =?utf-8?B?N21kR3NzbGU1Ui9ST00wZFB2cGN1VlFscWVrYVdSZXpadTBpZS9tZithcmJP?=
 =?utf-8?B?RHc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <2D0806A26371EC4EA441024CF650B6C1@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN6PR11MB1953.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d4f294a-3fad-415a-b87f-08da695ba160
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Jul 2022 07:52:29.6601
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9WQwmntOfZcEVLUf3xLoQkzyMMsWvKtzH4bjOMf9TtnFiGHHDAz8RaZMUf2LDu2IsN1vnKKvij19jMNGIliqXeJNpQYxtuAomkI+bMeDHYw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1101MB2156
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMTkuMDcuMjAyMiAwMDoyOSwgSG9yYXRpdSBWdWx0dXIgd3JvdGU6DQo+IFRoZSBwY2I4Mjkx
IGNhbiBiZSByZWJvb3RlZCBieSB0b2dnbGluZyB0aGUgR1BJTyA1Ni4gVGhlcmVmb3JlIGVuYWJs
ZQ0KPiB0aGlzIGluIERULg0KPiANCj4gU2lnbmVkLW9mZi1ieTogSG9yYXRpdSBWdWx0dXIgPGhv
cmF0aXUudnVsdHVyQG1pY3JvY2hpcC5jb20+DQo+IC0tLQ0KPiAgYXJjaC9hcm0vYm9vdC9kdHMv
bGFuOTY2eC1wY2I4MjkxLmR0cyB8IDYgKysrKysrDQo+ICAxIGZpbGUgY2hhbmdlZCwgNiBpbnNl
cnRpb25zKCspDQo+IA0KPiBkaWZmIC0tZ2l0IGEvYXJjaC9hcm0vYm9vdC9kdHMvbGFuOTY2eC1w
Y2I4MjkxLmR0cyBiL2FyY2gvYXJtL2Jvb3QvZHRzL2xhbjk2NngtcGNiODI5MS5kdHMNCj4gaW5k
ZXggZDU2ZDIwNTRjMzhkLi4wMmZiZjczNzFhOGQgMTAwNjQ0DQo+IC0tLSBhL2FyY2gvYXJtL2Jv
b3QvZHRzL2xhbjk2NngtcGNiODI5MS5kdHMNCj4gKysrIGIvYXJjaC9hcm0vYm9vdC9kdHMvbGFu
OTY2eC1wY2I4MjkxLmR0cw0KPiBAQCAtMTYsNiArMTYsMTIgQEAgY2hvc2VuIHsNCj4gIAlhbGlh
c2VzIHsNCj4gIAkJc2VyaWFsMCA9ICZ1c2FydDM7DQo+ICAJfTsNCj4gKw0KPiArCWdwaW8tcmVz
dGFydCB7DQo+ICsJCWNvbXBhdGlibGUgPSAiZ3Bpby1yZXN0YXJ0IjsNCj4gKwkJZ3Bpb3MgPSA8
JmdwaW8gNTYgR1BJT19BQ1RJVkVfTE9XPjsNCg0KQ291bGQgeW91LCBwbGVhc2UsIGFkZCBhbHNv
IHBpbmN0cmwtbmFtZXMsIHBpbmN0cmwtMCBmb3IgdGhpcyBncGlvPw0KDQo+ICsJCXByaW9yaXR5
ID0gPDIwMD47DQo+ICsJfTsNCj4gIH07DQo+ICANCj4gICZncGlvIHsNCg0K
