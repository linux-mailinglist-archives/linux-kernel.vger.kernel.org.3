Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FDA8543259
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jun 2022 16:18:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241021AbiFHORz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jun 2022 10:17:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241005AbiFHORx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jun 2022 10:17:53 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B25411E7BC9;
        Wed,  8 Jun 2022 07:17:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1654697872; x=1686233872;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=T2lUCLKVpLxdU4xTt3dS4oTelQPgB1klM8q5RoYVrjg=;
  b=tMeiCWWcWal/tzWm+QJrvmg7ANjxF8wqPO1iWmjw3DcPz8TVWaQAbeME
   3se07cLe7+vr2bClQ+H9rvYrrNotYQd7KxoLN9+L8hY7YF5koFmBRPEnu
   UUnkHodqiOh0cpViJ1UiIRvpnUwgkvKdyxgWCFFbjzRwkN8vJflCSx+Lp
   Epk34KsHctbVFeK+h5St7P3782FdpBLtWLDEZWcjcojm+ZZlSJvp39RXT
   jxiaYu7Lv+uwXMDbcc2IHYEuyZhYwjjjMtsEUvjSzN+tjYrF1fftWE8EV
   AMqmAu1UvqGfkHUB4vuqC9JIjLrJJPOQZf291wfYaiq4PkVjqigXOS2MT
   g==;
X-IronPort-AV: E=Sophos;i="5.91,286,1647327600"; 
   d="scan'208";a="167280718"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 08 Jun 2022 07:17:47 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Wed, 8 Jun 2022 07:17:46 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17 via Frontend Transport; Wed, 8 Jun 2022 07:17:45 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WvKOLx5cF+OVXL9s/8mkJhnphE4/JzwGhC2128y+giHVuVQXOXLDrc9QLyPdlC0YWbMtb2c79L7DLFX3RkCjZl9a/a6k9DKqg9+3TsRZjaWZnLW0sN+xHbbkEW8GzrqBOtpXMxtRaZ++l7U1IdK+zSB/N09hyhlDW1XmdlgLdz4qj5wxZT8037K808EaCk4XIIVGrOZnKRmHQNtO8NM3Qu5CWwUnZVYqIiN5YdrEJnCVYni37UiF20ot72o3pjO/l/Cf/9yOmLR2QxKMdi0yacIx4b00aZb6kTpDmCn0Usjl44TeR6zprGAS+u2DHpW51ctMdmY8tVEaWKsAqpwU4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T2lUCLKVpLxdU4xTt3dS4oTelQPgB1klM8q5RoYVrjg=;
 b=IRzkTPHAudrtxPf2QuqwOtFrn4dJzHDMjYypspBmvzaLD2BE1pjbVyjpCV23CfrTyrFc9j2XCVSvqWo9gYBjiXihEbzh5Cd+21tT20p6qBBu+tu+RLAYwsoLpMLLIdv2T4w7a5kAbKgUJNej0GBm9QheuDpfJxTWMo+eVpU3nB3N4wxeimw1Y44H5SLlbaU0+vXQwVVzQ2lTT1Fu6yMDOpON3EQshIzu3NclFi078XSe1qeoikLI6x7vV4TVrFyJzbLyboYL/TLNrmtrzUzOPsiV9P1/AOGNt7rxlh89C6lt+/0Z+uHaOIAJpLA78PCmVsCIgWB+Fm0JPxKV3lvyhQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T2lUCLKVpLxdU4xTt3dS4oTelQPgB1klM8q5RoYVrjg=;
 b=SDskUKA8skXYxseViVwmtGZ0CyQ82IHMIwf4DoxnA1DrQOlm7iKdB86BKia1GKNpjanRhexfeJ85870huiU7kFaiL4D+LrWaiGkLc9cbHqxx24mvHehjQDGquRKTy39ImW6oh2zqy03Zq7v3pOufKXhjuFk4YfaT5FhR3voCGKQ=
Received: from BN6PR11MB1953.namprd11.prod.outlook.com (2603:10b6:404:105::14)
 by BL1PR11MB5397.namprd11.prod.outlook.com (2603:10b6:208:308::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5332.12; Wed, 8 Jun
 2022 14:17:41 +0000
Received: from BN6PR11MB1953.namprd11.prod.outlook.com
 ([fe80::5cfe:8088:aa93:fce8]) by BN6PR11MB1953.namprd11.prod.outlook.com
 ([fe80::5cfe:8088:aa93:fce8%3]) with mapi id 15.20.5332.012; Wed, 8 Jun 2022
 14:17:41 +0000
From:   <Claudiu.Beznea@microchip.com>
To:     <Kavyasree.Kotagiri@microchip.com>
CC:     <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <UNGLinuxDriver@microchip.com>,
        <krzysztof.kozlowski+dt@linaro.org>, <Nicolas.Ferre@microchip.com>,
        <alexandre.belloni@bootlin.com>
Subject: Re: [PATCH v2 3/3] mfd: atmel-flexcom: Add support for lan966x
 flexcom chip-select configuration
Thread-Topic: [PATCH v2 3/3] mfd: atmel-flexcom: Add support for lan966x
 flexcom chip-select configuration
Thread-Index: AQHYewpD6TYRiClo40O9i0W3EvVFaw==
Date:   Wed, 8 Jun 2022 14:17:40 +0000
Message-ID: <c3a17994-72dd-8b64-4ddd-9deb3c793e24@microchip.com>
References: <20220607144740.14937-1-kavyasree.kotagiri@microchip.com>
 <20220607144740.14937-4-kavyasree.kotagiri@microchip.com>
 <9cf14336-16c3-5df5-b235-3f988d8b5151@microchip.com>
 <CO1PR11MB4865879F14D49AF7550C2D1192A49@CO1PR11MB4865.namprd11.prod.outlook.com>
In-Reply-To: <CO1PR11MB4865879F14D49AF7550C2D1192A49@CO1PR11MB4865.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0ff674db-2504-4979-7503-08da4959a5cc
x-ms-traffictypediagnostic: BL1PR11MB5397:EE_
x-microsoft-antispam-prvs: <BL1PR11MB539723F9CC4C1FC9B85F865887A49@BL1PR11MB5397.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: jA+BTcKNcGqG7b/bq3VVsbqVKxr2aRCrgWkIjgww7XFiHAWghnpGuXn5BE1n3TgUS8csFfwY+MLrzu1ydo7YZjGaEAIU9515P0LLNx2FvSpD908qzinzVg7hxu2KBL2JTU3d52uih8Xz5L0ejNj/F1HvDo1Rdm2ZorIMzDPMb5gLW1OKWTwFlp6ExhzfVzTAtM0mlvNGbaT5diahOGwgfabXoJgRO8ke85L8b4+YF9GAEOmnI+b9IyEjvyIc1ATteNnno44bvcj+XsGuMFjsUCCv3HYb8qrChzwdR1FzEeZtjB/DGUoOE2ulSHwUGdod3JAoF53UT3iz20IMNc7WYIt9kwoTnTZiy2KmPJu6i0D6pei+2eZ6NKdUB7qI/HPrPfMoHWnIDFmE5yzkSDqFg/bFXWjr/77Lhh8w7RHsO8NjDtsPogTB17Miiocu0UIcqsIedjQm6xqTFUjCjI4wSaW33JCvU8OomfYIZs7G1UChDLs4kfvLAVwM+n3j9vqZKQQMVCUil9XIVAOAaXRFfc9nf9zZodi2STjzwrZjaxQt9j5gipSKUWZudg5wiZ1IrJbpHyK2yBU8WdklDF6zlBMsgBt0NI0GL47dViblP8VKWlrb9DAsE+acuOXFRcWmRbzB2W+jBzESqFHcGtQc3VB7tl54C/9Bh0w855s8YWdFrsfZNkKEBoapUwM/66lmlcSZ0uQ19k2FGrnwlHZBSLUUMLRfOvjvS4YvPpekt8YNYozQSYs0/PoUa13DO0fRiBqoNwZ0E/masdP6FU6clcycNmjzeNtNnJr1KBURIi/F/sXVbrPc+tM/Mm8x+WHUWurNmdnzUZJGpDwkpcpjOYLNzmkCvJLVmp0EsnqZtWiOw8Lq5HZAsIPp2bljraCKc8Fl1Tq5XjfGXkPZ/hSsZQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN6PR11MB1953.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(6512007)(26005)(31696002)(71200400001)(6506007)(2906002)(6486002)(45080400002)(508600001)(966005)(2616005)(6862004)(186003)(86362001)(53546011)(83380400001)(8936002)(36756003)(5660300002)(38100700002)(122000001)(38070700005)(316002)(6636002)(37006003)(54906003)(91956017)(76116006)(66946007)(66476007)(66556008)(4326008)(66446008)(31686004)(8676002)(64756008)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UWJPNXRuNkJNelNOZUk2VnB5NHd1Vy9BZWJheFk0bElmYlZ3QzErakZpR1FM?=
 =?utf-8?B?TlN6clRud05yQUdBdTEycUJhVUtNeFFMcURTSTJQYVh6b0U2N0w2U2Q2VGdw?=
 =?utf-8?B?dTJWNXlwc3VCRkpxV3QxV1lidHdVa3N6VzhsZ3dzTGhZNjlodFNpQ21ObVZL?=
 =?utf-8?B?UWhuR1VZYUZvMzNtR0Vld2hGL24xdVRNejVRdGdVK3VjRUxSUjZ2MGJ2OWcz?=
 =?utf-8?B?K0NRczY1OXJJdW91VkpkaE84ZWRac0JDMVlMNlNYNFQ2OWIwNTJ6ckJKdmVD?=
 =?utf-8?B?WXJvaGhuN2hQa0tDMFFsMnJVMlVNbTEwY3hwMW4wWnJoV1RSS1M3cjk1ODE5?=
 =?utf-8?B?MXZQdDhqc1hMMnVlbHZxV2RndWwrdTNhQkt1MGVWNXN5ejZ4Myt3SUIzU292?=
 =?utf-8?B?TDZLSEZxWkNsNHdwaVZtTkRsdUV5bTdxbWZnVnIwOU1LTkk4S05UdndaSU5z?=
 =?utf-8?B?cDJXZkRRT2NYZE9kYVNlSmtkbWkwZUpIb09TNW1SK0NBU2R5ZHdOei9jVVUy?=
 =?utf-8?B?a1EveXhMYkpMa002UXNCOEZpSThXb0l1QUFwK09YSFNiam10NlVnMG1VTVBU?=
 =?utf-8?B?dmZuc0dzRlp4WGUxOGtnK3ZXaXE4ZTlXV2t4bkN0M0VDd0s5YWRBSFBPTXJ5?=
 =?utf-8?B?ME5YTE45L01hWXpUQ3ZUbTZJNkF4b0xKSXc4aXBmdWFEdmVJaS9vY1h5S05q?=
 =?utf-8?B?WllReHp0RzlHUG9QT2J1S0Q0MktpNHpEQkJQQWJieXhKdnN3SEFGUDI3cThu?=
 =?utf-8?B?aWhRNHRheHB6R2pJcTVmWFpkbnFzQ0QwdWlQOWdqb251d3JDWHpUTy9PMzE1?=
 =?utf-8?B?L2NWUEFRWXBiRGJwa0thZ0Z0RnkzQkJGU3JhQmpxNStYRUU5eGFlajRhYjNz?=
 =?utf-8?B?blBLa3psN0xsNzA3Sk9VVDJmaWFBRFNtRCt3UzhXQWlBcUNCVXFrdXZvMVo5?=
 =?utf-8?B?SXk1dldvZS8wTE5QTlNnVERabm14TjRhQkJBVXNGUzJoN21GNndoaFJOLy9S?=
 =?utf-8?B?SllXcHh0U1ZJRmFvTnhCZGNQNTNHQlBEQjQ5WkR1aUFnS1k1dGx1NloyK1BL?=
 =?utf-8?B?VzE4aXhha0o1RDk3b3VsaWxTNFgvWWR5NHJDdGx1d3ZXWVdPZmVBYm9aL3hL?=
 =?utf-8?B?b24rVXZUS3JMUGRxU2hIeUJxMjZxYk42QVJoYmNGMC9HaGxjRHdEeTBwU2Ji?=
 =?utf-8?B?UDhGQ2szSDh2WXNLNE8vK0ViVnY4eEZ6dnlpdDRHWHBqemhERXpPcFFZZ0ZY?=
 =?utf-8?B?UElxT2Q2U0tUbmRDMkpVT0Y0TTJ5TDlEN2FNWkIvUmFROWNRUEp4bWQ4NFdJ?=
 =?utf-8?B?ZTZLQktWRkJURU1JNmdIQlBHV3dSVnY3QlFadmYyRzlWd0lUNWg0NUFrTU1C?=
 =?utf-8?B?Y2ZNY0wzY25IS2tWYzRKNFBRTVdpaWFROFR5L2FpbWl4ZmtWeUhlMkJlT1lq?=
 =?utf-8?B?eTZoMnRSNzFzVzBxWGptWTNTdlJkME9uQXZOYStlbHMzZzZFalhEZUx5MXZw?=
 =?utf-8?B?SGVQVUlkSXlVems1OFNZUTRwNHZ6MWIxOTNCY1FTRHk4Q1UyMnNTbW5WeVVv?=
 =?utf-8?B?VFFPckpPYkZOVFBGL2NTeldEZnNkZmZ4ZHNxbE9kN1BKc1BUeWtwQ2JOd1Zn?=
 =?utf-8?B?ZzFJWUViaVpVbGJqNnZGQ2VRUVh5WGNnRXpQZ1NOdVBKSG1BeTB4eDg2TVBo?=
 =?utf-8?B?Nm43dHQzNWUwUWpNTzlNZEY2VU9Tc28vRysxcld5WlNPTDYzVzhSd0ZtbnQw?=
 =?utf-8?B?SjllaUJER3FTYzE4WVQveWxrRkp3blhKdnMwazVvaDFTOGZlVG40Q0FPN2lx?=
 =?utf-8?B?SVl5TG5jOFhmU2lHY29zTGYvTURDNk1hcEVLRy9PeTI5NU1qcXYxWGZ2R01Z?=
 =?utf-8?B?cC9iZHY5dG9jQXJQRjdPbEppMlRoK04xWkNyczl3a2tkVlR1SzFqeEozdWlV?=
 =?utf-8?B?MGpURm1aOUVXalptVnJ4UXorMzUyYlVnRC9XQVpLSTJ5dDNUR0VBcUxTOFNr?=
 =?utf-8?B?VTcvL0xYTGJ4dDFFZ0k2RlF5T0JSWG9vOHl1M0gvSzRmRkR0cUtKWDViNW5s?=
 =?utf-8?B?eVYxUUwyY0xpa2lMUzZZbVg4MlQ1ZXFUeHJoZ3l6Z0REMkphQnB5MVlxeU5S?=
 =?utf-8?B?TUtnTzAxaVVNZm50dllYL3N0S0lld0RUS2Z1MFd4NnNxbHAyeUdKQXlIc2tk?=
 =?utf-8?B?MEdUMm50UCsrUHBhc01yemhQWlJURnZvSzVCUld4WEx0ajNqOWVmQzl4TG5i?=
 =?utf-8?B?YWJiNlRkUGZ6MjNWcDhDcE9HTno2SXoxQlM0aFh1T0N2Y2hyelVHOERxbDRM?=
 =?utf-8?B?Z1Rta0NmbVVFekRRbTNFa1hlZFdvZ0NpcE9EVHFkT3JxNHN0bUlkcERSMStX?=
 =?utf-8?Q?oBG10pYJEkpTFrkk=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <82D1244313A4814C961227319F7F766A@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN6PR11MB1953.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ff674db-2504-4979-7503-08da4959a5cc
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jun 2022 14:17:40.8434
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ntyp/MPoCbDqyK6ShQa6uF/qVJU0ZtatlPbbgwxbTiLvwpTj/SPEuCR/NdlbCKEXlwEsacyOPZAy5IaoIRPc//hXVKmjT1B2jTmoaErmOSY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR11MB5397
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMDguMDYuMjAyMiAxMToyMCwgS2F2eWFzcmVlIEtvdGFnaXJpIC0gSTMwOTc4IHdyb3RlOg0K
Pj4+IExBTjk2NnggU29DIGhhdmUgNSBmbGV4Y29tcy4gRWFjaCBmbGV4Y29tIGhhcyAyIGNoaXAt
c2VsZWN0cy4NCj4+PiBGb3IgZWFjaCBjaGlwIHNlbGVjdCBvZiBlYWNoIGZsZXhjb20gdGhlcmUg
aXMgYSBjb25maWd1cmF0aW9uDQo+Pj4gcmVnaXN0ZXIgRkxFWENPTV9TSEFSRURbMC00XTpTU19N
QVNLWzAtMV0uIFRoZSB3aWR0aCBvZg0KPj4+IGNvbmZpZ3VyYXRpb24gcmVnaXN0ZXIgaXMgMjEg
YmVjYXVzZSB0aGVyZSBhcmUgMjEgc2hhcmVkIHBpbnMNCj4+PiBvbiBlYWNoIG9mIHdoaWNoIHRo
ZSBjaGlwIHNlbGVjdCBjYW4gYmUgbWFwcGVkLiBFYWNoIGJpdCBvZiB0aGUNCj4+PiByZWdpc3Rl
ciByZXByZXNlbnRzIGEgZGlmZmVyZW50IEZMRVhDT01fU0hBUkVEIHBpbi4NCj4+Pg0KPj4+IFNp
Z25lZC1vZmYtYnk6IEthdnlhc3JlZSBLb3RhZ2lyaSA8a2F2eWFzcmVlLmtvdGFnaXJpQG1pY3Jv
Y2hpcC5jb20+DQo+Pj4gLS0tDQo+Pj4gdjEgLT4gdjI6DQo+Pj4gIC0gdXNlIEdFTk1BU0sgZm9y
IG1hc2ssIG1hY3JvcyBmb3IgbWF4aW11bSBhbGxvd2VkIHZhbHVlcy4NCj4+PiAgLSB1c2UgdTMy
IHZhbHVlcyBmb3IgZmxleGNvbSBjaGlwc2VsZWN0cyBpbnN0ZWFkIG9mIHN0cmluZ3MuDQo+Pj4g
IC0gZGlzYWJsZSBjbG9jayBpbiBjYXNlIG9mIGVycm9ycy4NCj4+Pg0KPj4+ICBkcml2ZXJzL21m
ZC9hdG1lbC1mbGV4Y29tLmMgfCA5Mw0KPj4gKysrKysrKysrKysrKysrKysrKysrKysrKysrKysr
KysrKysrLQ0KPj4+ICAxIGZpbGUgY2hhbmdlZCwgOTIgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlv
bigtKQ0KPj4+DQo+Pj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvbWZkL2F0bWVsLWZsZXhjb20uYyBi
L2RyaXZlcnMvbWZkL2F0bWVsLWZsZXhjb20uYw0KPj4+IGluZGV4IDMzY2FhNGZiYTZhZi4uYWM3
MDBhODViNDZmIDEwMDY0NA0KPj4+IC0tLSBhL2RyaXZlcnMvbWZkL2F0bWVsLWZsZXhjb20uYw0K
Pj4+ICsrKyBiL2RyaXZlcnMvbWZkL2F0bWVsLWZsZXhjb20uYw0KPj4+IEBAIC0yOCwxNSArMjgs
NjggQEANCj4+PiAgI2RlZmluZSBGTEVYX01SX09QTU9ERShvcG1vZGUpCSgoKG9wbW9kZSkgPDwN
Cj4+IEZMRVhfTVJfT1BNT0RFX09GRlNFVCkgJglcDQo+Pj4gIAkJCQkgRkxFWF9NUl9PUE1PREVf
TUFTSykNCj4+Pg0KPj4+ICsvKiBMQU45NjZ4IGZsZXhjb20gc2hhcmVkIHJlZ2lzdGVyIG9mZnNl
dHMgKi8NCj4+PiArI2RlZmluZSBGTEVYX1NIUkRfU1NfTUFTS18wCTB4MA0KPj4+ICsjZGVmaW5l
IEZMRVhfU0hSRF9TU19NQVNLXzEJMHg0DQo+Pj4gKyNkZWZpbmUgRkxFWF9TSFJEX1BJTl9NQVgJ
MjANCj4+PiArI2RlZmluZSBGTEVYX0NTX01BWAkJMQ0KPj4+ICsjZGVmaW5lIEZMRVhfU0hSRF9N
QVNLCQlHRU5NQVNLKDIwLCAwKQ0KPj4+ICsNCj4+PiArc3RydWN0IGF0bWVsX2ZsZXhfY2FwcyB7
DQo+Pj4gKwlib29sIGhhc19mbHhfY3M7DQo+Pj4gK307DQo+Pj4gKw0KPj4+ICBzdHJ1Y3QgYXRt
ZWxfZmxleGNvbSB7DQo+Pj4gIAl2b2lkIF9faW9tZW0gKmJhc2U7DQo+Pj4gKwl2b2lkIF9faW9t
ZW0gKmZsZXhjb21fc2hhcmVkX2Jhc2U7DQo+Pj4gIAl1MzIgb3Btb2RlOw0KPj4+ICAJc3RydWN0
IGNsayAqY2xrOw0KPj4+ICB9Ow0KPj4+DQo+Pj4gK3N0YXRpYyBpbnQgYXRtZWxfZmxleGNvbV9s
YW45NjZ4X2NzX2NvbmZpZyhzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNlICpwZGV2KQ0KPj4+ICt7DQo+
Pj4gKwlzdHJ1Y3QgYXRtZWxfZmxleGNvbSAqZGRhdGEgPSBkZXZfZ2V0X2RydmRhdGEoJnBkZXYt
PmRldik7DQo+Pj4gKwlzdHJ1Y3QgZGV2aWNlX25vZGUgKm5wID0gcGRldi0+ZGV2Lm9mX25vZGU7
DQo+Pj4gKwl1MzIgZmx4X3NocmRfcGluc1syXSwgZmx4X2NzWzJdLCB2YWw7DQo+Pj4gKwlpbnQg
ZXJyLCBpLCBjb3VudDsNCj4+PiArDQo+Pj4gKwljb3VudCA9IG9mX3Byb3BlcnR5X2NvdW50X3Uz
Ml9lbGVtcyhucCwgIm1pY3JvY2hpcCxmbHgtc2hyZC0NCj4+IHBpbnMiKTsNCj4+PiArCWlmIChj
b3VudCA8PSAwIHx8IGNvdW50ID4gMikgew0KPj4+ICsJCWRldl9lcnIoJnBkZXYtPmRldiwgIklu
dmFsaWQgJXMgcHJvcGVydHkgKCVkKVxuIiwgImZseC1zaHJkLQ0KPj4gcGlucyIsDQo+Pj4gKwkJ
CQljb3VudCk7DQo+Pj4gKwkJcmV0dXJuIC1FSU5WQUw7DQo+Pj4gKwl9DQo+Pj4gKw0KPj4+ICsJ
ZXJyID0gb2ZfcHJvcGVydHlfcmVhZF91MzJfYXJyYXkobnAsICJtaWNyb2NoaXAsZmx4LXNocmQt
cGlucyIsDQo+PiBmbHhfc2hyZF9waW5zLCBjb3VudCk7DQo+Pj4gKwlpZiAoZXJyKQ0KPj4+ICsJ
CXJldHVybiBlcnI7DQo+Pj4gKw0KPj4+ICsJZXJyID0gb2ZfcHJvcGVydHlfcmVhZF91MzJfYXJy
YXkobnAsICJtaWNyb2NoaXAsZmx4LWNzIiwgZmx4X2NzLA0KPj4gY291bnQpOw0KPj4+ICsJaWYg
KGVycikNCj4+PiArCQlyZXR1cm4gZXJyOw0KPj4+ICsNCj4+PiArCWZvciAoaSA9IDA7IGkgPCBj
b3VudDsgaSsrKSB7DQo+Pj4gKwkJaWYgKGZseF9zaHJkX3BpbnNbaV0gPiBGTEVYX1NIUkRfUElO
X01BWCkNCj4+PiArCQkJcmV0dXJuIC1FSU5WQUw7DQo+Pj4gKw0KPj4+ICsJCWlmIChmbHhfY3Nb
aV0gPiBGTEVYX0NTX01BWCkNCj4+PiArCQkJcmV0dXJuIC1FSU5WQUw7DQo+Pj4gKw0KPj4+ICsJ
CXZhbCA9IH4oMSA8PCBmbHhfc2hyZF9waW5zW2ldKSAmIEZMRVhfU0hSRF9NQVNLOw0KPj4+ICsN
Cj4+PiArCQlpZiAoZmx4X2NzW2ldID09IDApDQo+Pj4gKwkJCXdyaXRlbCh2YWwsIGRkYXRhLT5m
bGV4Y29tX3NoYXJlZF9iYXNlICsNCj4+IEZMRVhfU0hSRF9TU19NQVNLXzApOw0KPj4+ICsJCWVs
c2UNCj4+PiArCQkJd3JpdGVsKHZhbCwgZGRhdGEtPmZsZXhjb21fc2hhcmVkX2Jhc2UgKw0KPj4g
RkxFWF9TSFJEX1NTX01BU0tfMSk7DQo+Pg0KPj4gVGhlcmUgaXMgc3RpbGwgYW4gb3BlbiBxdWVz
dGlvbiBvbiB0aGlzIHRvcGljIGZyb20gcHJldmlvdXMgdmVyc2lvbi4NCj4+DQo+IGh0dHBzOi8v
bG9yZS5rZXJuZWwub3JnL2xpbnV4LWFybS1rZXJuZWwvUEgwUFIxMU1CNDg3MjRERTA5QTUwRDY3
RjFFQTlGQkUwOTJEODlAUEgwUFIxMU1CNDg3Mi5uYW1wcmQxMS5wcm9kLm91dGxvb2suY29tLw0K
DQoicHJldmlvdXMgdmVyc2lvbiIgbWVhbnQgZm9yIG1lIHRoaXMgdGhlIG9uZSBhdCBbMV0uLi4g
QW5vdGhlciBwb2ludCB0aGF0DQp0aGUgdmVyc2lvbmluZyBvZiB0aGlzIHNlcmllcyBpcyBiYWQu
DQoNClRoZSBxdWVzdGlvbiB3YXMgdGhlIGZvbGxvd2luZzoNCg0KIkkgbWF5IG1pc3Mgc29tZXRo
aW5nIGJ1dCBJIGRvbid0IHNlZSBoZXJlIHRoZSBhcHByb2FjaCB5b3UgaW50cm9kdWNlZCBpbiBb
MV06DQoNCisJCQllcnIgPSBtdXhfY29udHJvbF9zZWxlY3QoZmx4X211eCwgYXJncy5hcmdzWzBd
KTsNCisJCQlpZiAoIWVycikgew0KKwkJCQltdXhfY29udHJvbF9kZXNlbGVjdChmbHhfbXV4KTsN
CiINCg0KQXMgSSBoYWQgaW4gbWluZCB0aGF0IHlvdSBzYWlkIHlvdSBuZWVkIG11eF9jb250cm9s
X2Rlc2VsZWN0KCkgYmVjYXVzZSB5b3VyDQpzZXJpYWwgcmVtYWluIGJsb2NrZWQgb3RoZXJ3aXNl
IChidXQgSSBkb24ndCBmaW5kIHRoYXQgaW4gdGhlIGNvbW1lbnRzIG9mDQpbMV0pLiBBbmQgSSBk
b24ndCBzZWUgc29tZXRoaW5nIHNpbWlsYXIgdG8gbXV4X2NvbnRyb2xfZGVzZWxlY3QoKSBiZWlu
Zw0KY2FsbGVkIGluIHRoaXMgcGF0Y2guDQoNClsxXQ0KaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcv
bGludXgtYXJtLWtlcm5lbC81ZjlmY2MzMy1jYzBmLWM0MDQtY2Y3Zi1jYjczZjYwMTU0ZmZAbWlj
cm9jaGlwLmNvbS8NCg0KPiBBcyBwYXJ0IG9mIGNvbW1lbnRzIGZyb20gUGV0ZXIgUm9zaW4gLSBJ
bnN0ZWFkIG9mIHVzaW5nIG11eCBkcml2ZXIsIFRoaXMgcGF0Y2ggaXMgaW50cm9kdWNpbmcgDQo+
IG5ldyBkdC1wcm9wZXJ0aWVzIGluIGF0bWVsLWZsZXhvbSBkcml2ZXIgaXRsc2VsZiB0byBjb25m
aWd1cmUgRmxleGNvbSBzaGFyZWQgcmVnaXN0ZXJzLiANCj4gQmFzZWQgb24gdGhlIGNoaXAtc2Vs
ZWN0KDAgb3IgMSkgdG8gYmUgbWFwcGVkIHRvIGZsZXhjb20gc2hhcmVkIHBpbiwgd3JpdGUgdG8g
dGhlDQo+IHJlc3BlY3RpdmUgcmVnaXN0ZXIuIA0KPiBJZiB5b3Ugc3RpbGwgaGF2ZSBhbnkgcXVl
c3Rpb25zLCBwbGVhc2UgY29tbWVudC4NCj4gDQo+Pj4gKwl9DQo+Pj4gKw0KPj4+ICsJcmV0dXJu
IDA7DQo+Pj4gK30NCj4+PiArDQo+Pj4gIHN0YXRpYyBpbnQgYXRtZWxfZmxleGNvbV9wcm9iZShz
dHJ1Y3QgcGxhdGZvcm1fZGV2aWNlICpwZGV2KQ0KPj4+ICB7DQo+Pj4gIAlzdHJ1Y3QgZGV2aWNl
X25vZGUgKm5wID0gcGRldi0+ZGV2Lm9mX25vZGU7DQo+Pj4gKwljb25zdCBzdHJ1Y3QgYXRtZWxf
ZmxleF9jYXBzICpjYXBzOw0KPj4+ICAJc3RydWN0IHJlc291cmNlICpyZXM7DQo+Pj4gIAlzdHJ1
Y3QgYXRtZWxfZmxleGNvbSAqZGRhdGE7DQo+Pj4gIAlpbnQgZXJyOw0KPj4+IEBAIC03NiwxMyAr
MTI5LDUxIEBAIHN0YXRpYyBpbnQgYXRtZWxfZmxleGNvbV9wcm9iZShzdHJ1Y3QNCj4+IHBsYXRm
b3JtX2RldmljZSAqcGRldikNCj4+PiAgCSAqLw0KPj4+ICAJd3JpdGVsKEZMRVhfTVJfT1BNT0RF
KGRkYXRhLT5vcG1vZGUpLCBkZGF0YS0+YmFzZSArDQo+PiBGTEVYX01SKTsNCj4+Pg0KPj4+ICsJ
Y2FwcyA9IG9mX2RldmljZV9nZXRfbWF0Y2hfZGF0YSgmcGRldi0+ZGV2KTsNCj4+PiArCWlmICgh
Y2Fwcykgew0KPj4+ICsJCWRldl9lcnIoJnBkZXYtPmRldiwgIkNvdWxkIG5vdCByZXRyaWV2ZSBm
bGV4Y29tIGNhcHNcbiIpOw0KPj4+ICsJCWNsa19kaXNhYmxlX3VucHJlcGFyZShkZGF0YS0+Y2xr
KTsNCj4+DQo+PiBDb3VsZCB5b3Uga2VlcCBhIGNvbW1vbiBwYXRoIHRvIGRpc2FibGUgdGhlIGNs
b2NrPyBBIGdvdG8gbGFiZWwgc29tZXRoaW5nDQo+PiBsaWtlIHRoaXM6DQo+PiAJCXJldCA9IC1F
SU5WQUw7DQo+PiAJCWdvdCBjbGtfZGlzYWJsZV91bnByZXBhcmU7DQo+Pg0KPj4+ICsJCXJldHVy
biAtRUlOVkFMOw0KPj4+ICsJfQ0KPj4+ICsNCj4+PiArCWlmIChjYXBzLT5oYXNfZmx4X2NzKSB7
DQo+Pj4gKwkJZGRhdGEtPmZsZXhjb21fc2hhcmVkX2Jhc2UgPQ0KPj4gZGV2bV9wbGF0Zm9ybV9n
ZXRfYW5kX2lvcmVtYXBfcmVzb3VyY2UocGRldiwgMSwgTlVMTCk7DQo+Pj4gKwkJaWYgKElTX0VS
UihkZGF0YS0+ZmxleGNvbV9zaGFyZWRfYmFzZSkpIHsNCj4+PiArCQkJY2xrX2Rpc2FibGVfdW5w
cmVwYXJlKGRkYXRhLT5jbGspOw0KPj4+ICsJCQlyZXR1cm4gZGV2X2Vycl9wcm9iZSgmcGRldi0+
ZGV2LA0KPj4+ICsJCQkJCVBUUl9FUlIoZGRhdGEtDQo+Pj4gZmxleGNvbV9zaGFyZWRfYmFzZSks
DQo+Pj4gKwkJCQkJImZhaWxlZCB0byBnZXQgZmxleGNvbSBzaGFyZWQgYmFzZQ0KPj4gYWRkcmVz
c1xuIik7DQo+PiAJCQlyZXQgPSBkZXZfZXJyX3Byb2JlKC4uLik7DQo+PiAJCQlnb3RvIGNsa19k
aXNhYmxlX3VucHJlcGFyZTsNCj4+PiArCQl9DQo+Pj4gKw0KPj4+ICsJCWVyciA9IGF0bWVsX2Zs
ZXhjb21fbGFuOTY2eF9jc19jb25maWcocGRldik7DQo+Pj4gKwkJaWYgKGVycikgew0KPj4+ICsJ
CQljbGtfZGlzYWJsZV91bnByZXBhcmUoZGRhdGEtPmNsayk7DQo+Pj4gKwkJCXJldHVybiBlcnI7
DQo+PiAJCQlnb3RvIGNsa19kaXNhYmxlX3VucHJlcGFyZTsNCj4+PiArCQl9DQo+Pj4gKwl9DQo+
Pj4gKw0KPj4NCj4+IGNsa191bnByZXBhcmU6DQo+Pj4gIAljbGtfZGlzYWJsZV91bnByZXBhcmUo
ZGRhdGEtPmNsayk7DQo+PiAJaWYgKHJldCkNCj4+IAkJcmV0dXJuIHJldDsNCj4+Pg0KPj4+ICAJ
cmV0dXJuIGRldm1fb2ZfcGxhdGZvcm1fcG9wdWxhdGUoJnBkZXYtPmRldik7DQo+Pj4gIH0NCj4+
Pg0KPj4+ICtzdGF0aWMgY29uc3Qgc3RydWN0IGF0bWVsX2ZsZXhfY2FwcyBhdG1lbF9mbGV4Y29t
X2NhcHMgPSB7fTsNCj4+PiArDQo+Pj4gK3N0YXRpYyBjb25zdCBzdHJ1Y3QgYXRtZWxfZmxleF9j
YXBzIGxhbjk2NnhfZmxleGNvbV9jYXBzID0gew0KPj4+ICsJLmhhc19mbHhfY3MgPSB0cnVlLA0K
Pj4+ICt9Ow0KPj4+ICsNCj4+PiAgc3RhdGljIGNvbnN0IHN0cnVjdCBvZl9kZXZpY2VfaWQgYXRt
ZWxfZmxleGNvbV9vZl9tYXRjaFtdID0gew0KPj4+IC0JeyAuY29tcGF0aWJsZSA9ICJhdG1lbCxz
YW1hNWQyLWZsZXhjb20iIH0sDQo+Pj4gKwl7DQo+Pj4gKwkJLmNvbXBhdGlibGUgPSAiYXRtZWws
c2FtYTVkMi1mbGV4Y29tIiwNCj4+PiArCQkuZGF0YSA9ICZhdG1lbF9mbGV4Y29tX2NhcHMsDQo+
Pj4gKwl9LA0KPj4+ICsNCj4+PiArCXsNCj4+PiArCQkuY29tcGF0aWJsZSA9ICJtaWNyb2NoaXAs
bGFuOTY2eC1mbGV4Y29tIiwNCj4+PiArCQkuZGF0YSA9ICZsYW45NjZ4X2ZsZXhjb21fY2FwcywN
Cj4+PiArCX0sDQo+Pj4gKw0KPj4+ICAJeyAvKiBzZW50aW5lbCAqLyB9DQo+Pj4gIH07DQo+Pj4g
IE1PRFVMRV9ERVZJQ0VfVEFCTEUob2YsIGF0bWVsX2ZsZXhjb21fb2ZfbWF0Y2gpOw0KPiANCg0K
