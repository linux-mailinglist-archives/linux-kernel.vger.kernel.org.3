Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FEA25251F3
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 18:05:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356228AbiELQFD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 12:05:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356180AbiELQE4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 12:04:56 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 102A561615;
        Thu, 12 May 2022 09:04:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1652371495; x=1683907495;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=w42JLM9Wyf6y8519BjvIA3XZsoPn1vSQOXp5i9tMXzc=;
  b=w5EQyU/+n78MycZNthR/5V1Ril33akcEpzjLxoYcBj2ukUVd9UUeDveq
   52fAEBY+ZqyBURZq8XWz4gMllQkliVmTZUoeNsT00lRxTPDzY1BViYJih
   StgaZuYwPuFYd+1yq+YsTFxE05bpExhcOtTvpfOK5xbUSwJ7r6hVi7BFL
   pRhQPDbvo5RMwNKE3M0J6vHDN0XkRfTYOkeTb5t71lBrb3P3Nv7IjtfO4
   441rOJF4a6x73SmjUa/6ieqJ4JX+Qh0FcHi5ZKx8IEfIO78/bdZwBqdd2
   0gHFwjcWAE8cgvO+Hb89GtQRWGzUVbB/gkbXf779PH+nh8EQKiiILsI+b
   w==;
X-IronPort-AV: E=Sophos;i="5.91,220,1647327600"; 
   d="scan'208";a="155817031"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 12 May 2022 09:04:54 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Thu, 12 May 2022 09:04:52 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17 via Frontend
 Transport; Thu, 12 May 2022 09:04:52 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ihYcoG2AG/bhjDflgUYmBqk0V9n/Jyxy5VpZUJD/PjdbIGYu8ZfMYOBK4hkSA/Z/XHr8D87ViYRPHi7n89kbaIZvi07PohyRZa/prUoFNXOKxj+tmzTzhqfkTcI/L2mJM9f8qih9qAYKFZBW8G08E4nE+7YDtLv7f2oygtVKjAe2YmE6vh8efk7Eh/lh8vUzP6k9r4Z29/Nf14w639JzJRzBJhaVHaczz0untTfirZ6jaGYdtaecqX9uJhOvGLNcQYJMtn2e9OXLfbQqOqGEyOP+UmYQ83I1EX8iMEA52a+WY/R35FIzqvVexeb97ucXRvm4/C+EAkOORXlEdoI0rA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w42JLM9Wyf6y8519BjvIA3XZsoPn1vSQOXp5i9tMXzc=;
 b=bJbU/psDdC9FyqFjT77tb772cQkNBApnX85s73EifAxYCRD1dEd6TM+U+xsDyHX20VhPuXBCoQl8xu40wX3pulKLMuGboqLAyV3p7a7ctZf/ZNZ8Gij8s30CVSoGmNfgLMjJmPQClavEtFVG2/syvDlbrk8S5t8PxoU7T9/lK5MfTz4HBsQ8L9WGkAcWa3L/FKCorpAPQUXBTngFsqyjoPJexFbEtc7QlBhjd1WSN8olULVpUpJn7InE6QRqGUW92vyt2BsRMC3qpAmaPpKkev5jU/Zcilm4YBT2jcE7QznsGgUXi9Ztg8Ow0VDARj6SKs7wAqTbh5fX4nS2Ncpr+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w42JLM9Wyf6y8519BjvIA3XZsoPn1vSQOXp5i9tMXzc=;
 b=cIcFIdAHJi90uxcT3WgN6zJAjhTJE+DzJ1g1u/rFtXCYtG85+zoCNmjyc5/1YAUFlmzuDw7wblI196PXVW3k08YBKss+TKGUwstox0A2i3gOS8QwZLk3PADO8Zx6P2Sw9FKXLjfVFow8mEThkMJ7hRUOxGsZdfag7p+oPiBLMCE=
Received: from CO1PR11MB4769.namprd11.prod.outlook.com (2603:10b6:303:95::10)
 by DM6PR11MB2635.namprd11.prod.outlook.com (2603:10b6:5:c5::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.21; Thu, 12 May
 2022 16:04:48 +0000
Received: from CO1PR11MB4769.namprd11.prod.outlook.com
 ([fe80::e906:3e8d:4741:c0f0]) by CO1PR11MB4769.namprd11.prod.outlook.com
 ([fe80::e906:3e8d:4741:c0f0%6]) with mapi id 15.20.5250.014; Thu, 12 May 2022
 16:04:48 +0000
From:   <Claudiu.Beznea@microchip.com>
To:     <krzysztof.kozlowski@linaro.org>, <srinivas.kandagatla@linaro.org>,
        <robh+dt@kernel.org>, <krzk+dt@kernel.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/2] dt-bindings: microchip-otpc: document Microchip OTPC
Thread-Topic: [PATCH 1/2] dt-bindings: microchip-otpc: document Microchip OTPC
Thread-Index: AQHYZdBf287PvcEoQUmQslcb1o7LPQ==
Date:   Thu, 12 May 2022 16:04:48 +0000
Message-ID: <706eb7b4-07ce-ffd2-3366-5656ddba21d6@microchip.com>
References: <20220510094457.4070764-1-claudiu.beznea@microchip.com>
 <20220510094457.4070764-2-claudiu.beznea@microchip.com>
 <75ce6291-77c7-c932-e8bb-a8bbae02431d@linaro.org>
 <c840c598-0413-5f40-0807-e3c314531f0a@microchip.com>
 <b5c586de-a3ae-0774-e0bf-e21852b65fa9@linaro.org>
 <59b47f0b-6201-3814-e17f-1435ce5c2dad@microchip.com>
 <6ce3c0b1-3f6a-24f6-bcf2-4d4125a97604@linaro.org>
In-Reply-To: <6ce3c0b1-3f6a-24f6-bcf2-4d4125a97604@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8963af8a-14db-41dd-3aa1-08da34312397
x-ms-traffictypediagnostic: DM6PR11MB2635:EE_
x-microsoft-antispam-prvs: <DM6PR11MB2635718609C5BF75E5A224B687CB9@DM6PR11MB2635.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 9DwqwwD56wA9iOPE1SxHBqimZE2cGMJh/umMouup0QJTQjPMP41CkUItjW2JAJXLbpxml+vQvgIVeELhVJmMHtirdKBNGVodevJDqY+SMu8BSN8M8mlbBeMz5cTQn1+S14ignELTxFp6hAcrZ/v3qSp2ubySj4sISnOLo5dlklFVO5ebQ3CXO5PNFUA3CbgyhLZ5HAyhJGOc63WqzPlVCa2xWihFCQjtVf9NLkz1MAALoknNKQtPO0plQgbdT22+WvLkgc4bIcHJSJleUDmpqxvLYNznJ1jQpA17tkQW1QDQ4Bvx8j1PTNnUdaiPgIomdr8h/RsLbUiyLryvhUq7mgTW7ndHnsbyCVqQp+NwuMMbzl4DxWb8OkBFTOkHmpYAXmqw17+lpIKF8vUMA8kCfjKsjgAIIovNfYdDi0VegGXoaubPyERAdXy4aXFfwL/cQqmDhqlku6GcAqS+kTnEiYTXediTEGZNKSGyk9dxp/WdY5AhtvrancACbVn640PbxicfeRExpvrwZ1vP0Bf4GQ7bvxsSnhOI968cQFsuna4rfsqJAwfr9y270JqLaD9m0U75yShtuCjZsQ6S8/bJvBU94ZieMPZi8YOap73IAmvMjuLP0bOrKyP2egxgiUlNlu82TpakDEeKDmezwuWyVQ13lzViRmWtql2rU6F2vGZ8LPS7d68VlxZXNFqn+NL8pMIua5z286ntWC+UhLlzLweFu/a1MWFldnv2D4ckWyw2J6iVqAMUwFBoSKIudFmp5stvvMAS5g5japitzLJ6DCO26SV0KCQEuIEOhBp4W+ZQ/ARrEN//ix5tNnqvdzNSQNC98J7Td+C0GVZQM1XmRIJXnWrlCPqqGI00O+qI2Sw=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB4769.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(966005)(38100700002)(186003)(83380400001)(5660300002)(36756003)(31686004)(2616005)(8676002)(86362001)(8936002)(31696002)(4326008)(54906003)(110136005)(66446008)(64756008)(66946007)(76116006)(66556008)(66476007)(316002)(26005)(6506007)(508600001)(71200400001)(53546011)(122000001)(6512007)(2906002)(38070700005)(6486002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dkp6emFia3NBL2ZydzNldEpnTE8xSmFyMHUxSFpHR3R1MlJhZ255T1NmUDl2?=
 =?utf-8?B?eXRkT01aUEdLYUhiOXNsdUU2dWhhUHVUNE9NUUtUZzZYOFhMejZUa0cvUkc0?=
 =?utf-8?B?cVhtZmlrMFJWNzRGVkFTcUVoQmxnZUE3QVRyY0UwajUyQ2xEM1ZPL0FBMWgw?=
 =?utf-8?B?dGNjYjE5KzJhc2VLekU5NXhUN0dWdFUzUlJ6SjBQSlhycmdsR3VZNmhRTWNK?=
 =?utf-8?B?VWFtV0dwMFRYdlpOK21iWnU4c3RwSzIrRTJ3blk1RUVCVTlTVlo4ZDBPSi80?=
 =?utf-8?B?Sy9mYm5wTStmQzlwa2NqUXBEUGQ2b2FCZW1GeDlBUzZId3BJeFVWMkxMb3Rk?=
 =?utf-8?B?UGE4TzBnWk4xc0RtclY2M2E0QUNsVlpnazAxQmhUQ1cxbTF3MTJGaHFEcENj?=
 =?utf-8?B?cTFSOXNieDVzVXdrYzZqRGZGUW5lMVJUODgySmxRSjJGaWk1UjhjVEtCSjY0?=
 =?utf-8?B?K2RxQUI3UlpDL1p0TkkxVk5QQU1aelhjODV0ZlR2UHA4N2tDZll1THN6aFlD?=
 =?utf-8?B?TzVOUE8xYjA1OVVjQUlVMDMrNHRncW5BWHFoSzJmUk5NcDhUZDY5N3dzLzFm?=
 =?utf-8?B?K21NMW8wUU0wVFhRZC9hV2w1U2hnU3I5MG1vaHY1bUZ3enBhQkFtdndKc3ll?=
 =?utf-8?B?SFlsejFWckJkWStVcXhIRC90Rk56ZnlXL01lS3oyb2lzemtNWDZBN0dCekUr?=
 =?utf-8?B?SkpWT2lKTElUZlc5UUxMRGFmZkV0QXBXSjgxUjRueEhrbjhhR0RrMGJDVjdT?=
 =?utf-8?B?bS9INE1hYjlpY1NQWm56Nlgra0wvZXhXZmJsMnYxQUhmMG5jczd5VEdtaXFC?=
 =?utf-8?B?QnlobDYrRTMxOWRlb1MrN2ZRc25mTXIxS081eC9FNTkxb1lJSERyeGZjc0Jl?=
 =?utf-8?B?TmVodXd4SXZXZ3FDR0hkNzhxeUFabHV2WE90ekFVRnVRZmdCR1dGdzBOY3JQ?=
 =?utf-8?B?YnlPQ2hUbGhNR0c4U2g5MHQ5YUhoR2RLRlQwaVBKWFA3UU11VGFKTWp2WkEz?=
 =?utf-8?B?Q0QzaVBUYUV0dFJFOEJRQytQUm4yRmJ4Vkp6TUNvaGFYbE1MUEtXZTFLejdu?=
 =?utf-8?B?c3lhWmVHNEdFMG9wWUgrMmpRSVoyU01CZVBtWTdTNmwxZ01JUVBEa1BRSXFv?=
 =?utf-8?B?UkM5VERSVUpGM1B5MjJxaithSmZ5cEg1YkRBNkt4VzZJS3RhVm9XSWdiNWZZ?=
 =?utf-8?B?eFgrR1UyTzVLNERUNUp5b1RySjdYUUp5eWVMU3pNazYyZzZCRzF3UGhVUGpj?=
 =?utf-8?B?YmhLb25DMzRQM2orVFltZEtNcGE2MVhqR0ZmZWxLVG9VS1g5SExQeWhxczNR?=
 =?utf-8?B?Ny9TZG1OVlU3TGdLdWVoYXJKNkdRV1JpYjVyZGUrU21XTjNHZjhBUjY2NExv?=
 =?utf-8?B?ZFFRTWxtdDE5NlVTeFc5ZGFhbVZxMG9BeDQ4YnFDbGMyNENZaG05bU1nR01J?=
 =?utf-8?B?WTdRUXhkZ1B2WU9FQUJ4RGRFRzRxTkp2M2xCYjcxOVZUZXYwN0VFOFhUVFN4?=
 =?utf-8?B?eVJYRnhuZ3NOZGFtRXRQeUYwYUhqTUR1Tk9yc2oyQm1sRk5KSGlyUlVqeDhZ?=
 =?utf-8?B?elA1VUhsNUFRZExDNHAyR1IvTnEzWjhEeCtOS3pVdDBUZy9vV0ZoQjl2VVZY?=
 =?utf-8?B?ZDYrZTdOV2luNGVlcWZnSEUrczdkMTkreUtHSzlQeko4cWdLWmU5YVdhV0dj?=
 =?utf-8?B?Y3dCdTZhOW5aeVhHMVVQZDBPUFYvbm1nZFdYNFJyRThXUzlGYUUyYXFtcEVF?=
 =?utf-8?B?TzYxbHpPTG1jVWdRckx6S1VCTkZ6eGIyY1hmQ0RMbHBZUzA3YmV0NDJ2RXF4?=
 =?utf-8?B?THVXSWY0WkxlcVFSYjlHMzcwNWcydEtrUnRZVjRzamZVcEtWRkVVVGh6dzNJ?=
 =?utf-8?B?akYyTFNhVVQ1SW0wNUdLcGVpR3hnRXJ1elBTSWF1NnpZMkNSd2ZDblE2N0RC?=
 =?utf-8?B?U3ZwcTJ1KzM5SlFCcGNYbG5wakpUYm5HdTZLZWpEWll6cHhTeFNVOTRtaWlj?=
 =?utf-8?B?SEdocnV3M284aVBEdkxUOURmaTc0RjZ5UXg1TER5WkdnS1ZtcnFicytLaHZp?=
 =?utf-8?B?RDdsd2g5UlFmR0xrNkpFZUhIVXNiYWdwT1pDYTM3V3NQOFRsekF0ekg4a1oz?=
 =?utf-8?B?QTNKU1JHRmk3amRjQ09BQ3lxV1pUV04zejVncG1aaloyMEI1dXR3R3NvaHNl?=
 =?utf-8?B?U0xqaWpPSzhZd3lHdFA0ZG1XWmJNSjhPM2hPYlhrWGllSkVpclhxd0Z5WjFi?=
 =?utf-8?B?dWpkSnNWZzFJNkplYjFXK0FsclVVVGl3RzkzSlRsWUVmVUpTdHZaeTY1SDdm?=
 =?utf-8?B?QTNaL0R6NWJHZC9idE40UThpT0VaVndCeExRcmprenY3TDlrODRXZlF6SXIv?=
 =?utf-8?Q?ttn1zEDHcfb9noJM=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <4E22DE5BF696BA4A8011B8E5176F39E6@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB4769.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8963af8a-14db-41dd-3aa1-08da34312397
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 May 2022 16:04:48.0876
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yo9qlfdcLoY6PNVjXetXpNhRIXvxQBfoBJ8uWyT2t1mnZq0ekuQcYh7JTtqiDfZ+7UNEu/vzo1WaxKhLUmFbfFaen608WaT8/1BU8YpCYfA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB2635
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMTIuMDUuMjAyMiAxODozNSwgS3J6eXN6dG9mIEtvemxvd3NraSB3cm90ZToNCj4gRVhURVJO
QUwgRU1BSUw6IERvIG5vdCBjbGljayBsaW5rcyBvciBvcGVuIGF0dGFjaG1lbnRzIHVubGVzcyB5
b3Uga25vdyB0aGUgY29udGVudCBpcyBzYWZlDQo+IA0KPiBPbiAxMi8wNS8yMDIyIDE3OjMxLCBD
bGF1ZGl1LkJlem5lYUBtaWNyb2NoaXAuY29tIHdyb3RlOg0KPiANCj4+Pg0KPj4+IE1hY3JvIGlz
IGEgbmljZSBpZGVhIGlmIGl0IGNhbiBiZSBzdGFibGUuIEkgdW5kZXJzdG9vZCB0aGF0IGxlbmd0
aCBvZg0KPj4+IHBhY2tldHMgZGVwZW5kcyBvbiBoYXJkd2FyZSwgc28gdGhpcyBwYXJ0IGNvdWxk
IGJlIHN0YWJsZS4gQnV0IHdoYXQNCj4+PiBhYm91dCBudW1iZXIgb2YgcGFja2V0cywgc28gdGhl
IE9UUF9QS1RfU0FNQTdHNV9URU1QX0NBTElCX0xFTiBiZWxvdz8NCj4+DQo+PiBUaGUgT1RQX1BL
VF9TQU1BN0c1X1RFTVBfQ0FMSUJfTEVOIGhlcmUgaXMgdGhlIGxlbmd0aCBvZiB0aGVybWFsDQo+
PiBjYWxpYnJhdGlvbiBwYWNrZXQuIFRoaXMgbGVuZ3RoIGlzIGZpeGVkIGFuZCB3aWxsIG5vdCBi
ZSBjaGFuZ2VkLg0KPj4NCj4+IEFmdGVyIHRoZXNlIDIgcGFja2V0cyAocHJvdmlkZWQgYnkgTWlj
cm9jaGlwKSB1c2VyIG1heSBmdXJ0aGVyIGZsYXNoIGFueQ0KPj4gbnVtYmVyIG9mIHBhY2tldHMg
YW5kIHVzZSB0aGVtIGFzIHRoZXkgd2lzaC4NCj4+DQo+PiBEcml2ZXIgaXMgaW4gY2hhcmdlIG9m
IHNjYW5uaW5nIHRoZSBOVk1FTSBmb3IgdGhlIGF2YWlsYWJsZSBwYWNrZXRzIGFuZA0KPj4gcHJl
cGFyZSBhIGxpc3Qgd2l0aCB0aGVpciBJRHMgYW5kIHRoZWlyIHN0YXJ0aW5nIG9mZnNldHMgaW4g
TlZNRU0gbWVtb3J5DQo+PiBzdWNoIHRoYXQgd2hlbiBpdCByZWNlaXZlcyBhIHJlYWQgcmVxdWVz
dCBpdCB3aWxsIGJlIGFibGUgdG8gZGVjb2RlIHRoZQ0KPj4gcGFja2V0IG9mZnNldCBiYXNlZCBv
biBwYWNrZXQgaWRlbnRpZmllci4NCj4+DQo+PiBJbiBjYXNlIGRpZmZlcmVudCBudW1iZXIgb2Yg
cGFja2V0cyBhcmUgYXZhaWxhYmxlIGluIE5WTUVNIGZvciBkaWZmZXJlbnQNCj4+IGtpbmQgb2Yg
c2V0dXBzIChib2FyZHMpIHRoZXNlIGNvdWxkIGFsc28gYmUgcmVmZXJlbmNlZCBpbiBib2FyZCBz
cGVjaWZpYyBEVA0KPj4gdXNpbmcgT1RQX1BLVCgpIG1hY3JvIGFuZCB3aXRoIHByb3BlciBsZW5n
dGggKHdoaWNoIHdpbGwgZGVwZW5kIG9uIHdoYXQNCj4+IHVzZXIgZmxhc2hlZCkuDQo+Pg0KPj4+
IFlvdSB3cm90ZSAiQm9vdCBjb25maWd1cmF0aW9uIHBhY2tldCBtYXkgdmFyeSBpbiBsZW5ndGgi
LCBzbyBpdCBjb3VsZCBiZQ0KPj4+IGNoYW5nZWQgYnkgTWljcm9jaGlwPw0KPj4NCj4+IFllcywg
YmV0d2VlbiBjaGlwIHJldmlzaW9ucyBpdHMgbGVuZ3RoIGNvdWxkIGJlIGNoYW5nZWQuDQo+IA0K
PiBDaGlwIHJldmlzaW9ucyBsaWtlIGRpZmZlcmVudCBib2FyZCBjb21wYXRpYmxlcyB0aHVzIGRp
ZmZlcmVudA0KPiBiaW5kaW5ncy9tYWNybyB2YWx1ZXM/DQoNCk5vdCBuZWNlc3NhcmlseS4gSXQg
bWF5IGhhcHBlbiB0aGF0IG9ubHkgUk9NIGNvZGUgdG8gYmUgdXBkYXRlZCAoMXN0IHN0YWdlDQpi
b290bG9hZGVyKSBlbmQgZXZlcnl0aGluZyBlbHNlIG9uIExpbnV4IHNpZGUgdG8gYmUgYWJsZSB0
byBydW4gYXMgaXMuIE9yDQp0byBqdXN0IGZpeCBzb21lIGJ1Z3MgaW4gZGlmZmVyZW50IElQcy4g
VGhpbmdzIHRoYXQgd2lsbCBub3QgbmVjZXNzYXJpbHkNCm5lZWQgYWRkaW5nIG5ldyBjb21wYXRp
YmxlcyBmb3IgdGhlIG5ldyBjaGlwLiBBbmQgaXQgbWF5IGhhcHBlbiB0aGF0IG5ldw0KY2hpcCBy
ZXZpc2lvbnMgdG8gYmUgcG9wdWxhdGVkIG9uIHByZXZpb3VzIGJvYXJkIHJldmlzaW9ucy4NCg0K
PiBDaGlwIHJldmlzaW9ucyBsaWtlIGRpZmZlcmVudCBib2FyZCBjb21wYXRpYmxlcyB0aHVzIGRp
ZmZlcmVudA0KPiAqbWFjcm8qIHZhbHVlcz8NCg0KSWYgeW91J3JlIHJlZmVycmluZyB0byB0aGUg
T1RQX1BLVF9TQU1BN0c1X1RFTVBfQ0FMSUJfTEVOIG1hY3JvLCB0aGlzIGlzDQplc3RhYmxpc2hl
ZCB0aGF0IHdpbGwgcmVtYWluIGZpeGVkIGIvdyByZXZpc2lvbnMuIFRoaXMgaXMgdGhlIGxlbmd0
aCBvZiB0aGUNCjJuZCBwYWNrZXQgaW4gTlZNRU0gKHRoYXQgaXMgb2YgaW50ZXJlc3QgZm9yIHRo
ZXJtYWwgbWFuYWdlbWVudCkuDQoNCk9ubHkgdGhlIGxlbmd0aCBvZiB0aGUgMXN0IHBhY2tldCBt
YXkgY2hhbmdlLiBBbmQgYWRkcmVzc2luZyB0aGUgTlZNRU0gd2l0aA0KcGFja2V0IGlkIGJhc2Vk
IGluZGV4IHNob3VsZCB0YWtlIGNhcmUgb2YgdGVtcGVyYXR1cmUgY2FsaWJyYXRpb24gTlZNRU0g
RFQNCmJpbmRpbmcgdG8gd29yayBhbGwgdGhlIHRpbWUuDQoNCj4gSWYgbm90LCB0aGVuIG1heWJl
IGJldHRlciBza2lwIHRoZSBsZW5ndGggb3V0IG9mDQo+IGJpbmRpbmdzIGFuZCBqdXN0IHByb3Zp
ZGUgdGhlIGZpcnN0IG1hY3JvLg0KDQpBcyBmYXIgYXMgSSBrbm93IHRoZSBsZW5ndGggaXMgcGFy
dCBvZiB0aGUgd2F5IHRoZSBOVk1FTSBjZWxscyBhcmUNCmRlc2NyaWJlZCBpbiBEVDogaXQgbmVl
ZHMgdGhlIG9mZnNldCBpbiBtZW1vcnkgKGZvciB0aGUgZGF0YSB0byBiZQ0KcmV0cmlldmVkKSBh
bmQgaXRzIGxlbmd0aC4NCg0KVGhhbmsgeW91LA0KQ2xhdWRpdSBCZXpuZWENCg0KPiANCj4gDQo+
IA0KPiBCZXN0IHJlZ2FyZHMsDQo+IEtyenlzenRvZg0KPiANCj4gX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX18NCj4gbGludXgtYXJtLWtlcm5lbCBtYWlsaW5n
IGxpc3QNCj4gbGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnDQo+IGh0dHA6Ly9s
aXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8vbGludXgtYXJtLWtlcm5lbA0KDQo=
