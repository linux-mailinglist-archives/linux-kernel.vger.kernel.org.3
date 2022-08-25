Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D8495A10C1
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Aug 2022 14:40:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241982AbiHYMkq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Aug 2022 08:40:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241945AbiHYMkn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 08:40:43 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1395848CA0;
        Thu, 25 Aug 2022 05:40:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1661431242; x=1692967242;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=W8J8A0DRYPkq5HScnpEibzi+s6o1MEKDL9pUFm8FnWU=;
  b=eIxweeSSxvdg3xTaOtjyhgcJW4lfls2/tO5BVKVfOQF8/I1XEn9MIKsh
   bVgTeLzrS/d6+mH9hejS8wieiBnSWUiIEnYLfb1lOOiGh3p4lOkk+topB
   r8pQvNOCB7ax3lPmBfz4/1rLOKYyw9BaDJg7KFhWOJKSc/cJZzWFbl75x
   QyXisjioaXML6UsagIfl+pJvh97wMLN4mzmxLjLnETn9KFqfdSMwKA2Wf
   GsfdM5i2durgSxiM/if1uv5RuDlldAB4QawYQt74a0ICOTtesW1vZnrPZ
   abNZ6Co+R89zFUlwX123ateJLq3Mo7c+2A5I5y6QfDMPX227LyU+unw++
   A==;
X-IronPort-AV: E=Sophos;i="5.93,263,1654585200"; 
   d="scan'208";a="188013045"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 25 Aug 2022 05:40:41 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Thu, 25 Aug 2022 05:40:41 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12 via Frontend Transport; Thu, 25 Aug 2022 05:40:40 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RGLiC/7yoSdSKZI7PhIzMyEvLcnn40deceAksClTy5uG3gRkrXSEIw69FopmSR4uoMH7P5W4tGbJKFIRK3bIaYo4/b+OMTCCmZrNbA/pBknx5Ynq0BywXxkbThgY1FE3eyoVZkpEyOVVylaQse7+qCVZElXElnIp3l8zqDexxwfYXzuJSFUsKQ1iY2hvDEFMKL6N0jNlO0clXMxPDZ+KObvz7pX9Dz87HwVzhB5p3T8ZvNdhz3L779o2JUOItE24NrKEEQ/EHKhcpukREkVTIJfDVM5sRBwX5txTbI8Mz2ZRepgSrke1Lmk50ws62YJ+y8s5aVPro7Z2OoWLdPWKIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W8J8A0DRYPkq5HScnpEibzi+s6o1MEKDL9pUFm8FnWU=;
 b=WmqFS+fKBQDBr6Jck/TAZNihGTQEAk94++4xLXTzft+BsiLZEWEqPbo8polHC/feQDkYhOzpFwrKNkzuT/5uLcWbe2zVTgYlbLlZQc4MFugo3JbuxXxskb6T9M6jGMqKj3LAb9EM17GivdKraywUPjw7QttVGJVoEoKlRFTYGimYh3y6LwsjuOJb/WJAj4CuBW7uTfXu+f0CNJFQAmkHszK7GWSqO/36y+544rm0aXYwcY/ZB47TqBTnQalIK3JVKZ/bFq/dD7ng7hdHCvmdGaDrd3j8xx0PkxdXUs5VOUHAl5TjGBZPGYU8xoGB6O4UgS/FAIQpg439Tl5OHKnm4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W8J8A0DRYPkq5HScnpEibzi+s6o1MEKDL9pUFm8FnWU=;
 b=qCIH01J2l3icHjnuaXgxV8tLtaa1fNNyfnEJlWlXXx2k0tLD9gXLQpvMv9eKLuZONpmlS/sEcDzY8jYpltXPlZoXIiW/24AJJmqQjrtnDlZSuGQfyA3HFsfhwvTFcUc/T3d11wQlGgPiS55oTLLyzUSI30EnpMqZb98vVV6VNqI=
Received: from CO1PR11MB5154.namprd11.prod.outlook.com (2603:10b6:303:99::15)
 by SN7PR11MB7092.namprd11.prod.outlook.com (2603:10b6:806:29b::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.15; Thu, 25 Aug
 2022 12:40:39 +0000
Received: from CO1PR11MB5154.namprd11.prod.outlook.com
 ([fe80::ac89:75cd:26e0:51c3]) by CO1PR11MB5154.namprd11.prod.outlook.com
 ([fe80::ac89:75cd:26e0:51c3%9]) with mapi id 15.20.5566.015; Thu, 25 Aug 2022
 12:40:39 +0000
From:   <Conor.Dooley@microchip.com>
To:     <krzysztof.kozlowski@linaro.org>, <mail@conchuod.ie>,
        <linus.walleij@linaro.org>, <brgl@bgdev.pl>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>
CC:     <linux-gpio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] dt-bindings: gpio: mpfs-gpio: allow parsing of hog child
 nodes.
Thread-Topic: [PATCH] dt-bindings: gpio: mpfs-gpio: allow parsing of hog child
 nodes.
Thread-Index: AQHYtNXjrXcUZeoA+U+yOP8cMQNzh62/jagAgAAFigCAAAFZgIAAAXcA
Date:   Thu, 25 Aug 2022 12:40:39 +0000
Message-ID: <4d841831-7940-00be-9150-55892c638d31@microchip.com>
References: <20220820204130.1380270-1-mail@conchuod.ie>
 <0ecf1664-03a2-71ac-b967-6905b96c7ce0@linaro.org>
 <e94c1de8-e5e3-2325-38f9-1606c9369aef@microchip.com>
 <109c37f0-8b1a-40d0-7b86-dde80fb77081@linaro.org>
In-Reply-To: <109c37f0-8b1a-40d0-7b86-dde80fb77081@linaro.org>
Accept-Language: en-IE, en-US
Content-Language: en-IE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e915c511-ee53-44a8-6b0a-08da86970433
x-ms-traffictypediagnostic: SN7PR11MB7092:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: quMLXsT3yeTLm8srjS4lyYLyN4GAiVHUCo/tTffe1W1yoNV70CqayDDXCZijRj40X3E4+amNqmXIvl9685AnZZYgmeuYIJIJezr4pK1gY3nEtPgbMqWLzwIrA+vla6nbX0x8FMvc2ZIZqdhXx5Mv3j3VVDDpIUp8VyTXwG7GiPPynDMBPzFAqyBhzVzqfsYd0bAQOeXwl/1BNvky0wKyOjB38sbAtR3/+AuI8JQaRD5gCGceXSTe5gO/8QlBocj9kqCXU2l6cmbo45sRW3xgqA0qD7uOu5ktW1MCVeaLiElhEMxsUMPt7GPoFc1FJBY7mfvqOD+s5F5aXjgTyKauodh3YzgmtfYLTfLcrLCClCM6z6V3F98m+1IwuPzTrxpSTGOpL2QJpoEfZo+yVqY/aB1P6jMYQMA3m6QWERYU7WZ8wC8aE2tcBpoUrwZr43iItS5X8Rl+NiUCPkCDt7nYxkTuEPo7dyxdyatqDQPLyLtiCmDSmxn4HPx5+7c0d/r74Vc/rKam/maCu1ktG0ChWr0wxYNzWkSxD8zV0TEeWZU6eQr1THhacoOylLj/TdTuKYitWs+zuMYPxsCmOKpXN4Icq4swyKB6iku6HNEan07Twau2v2jjPY8u/4sp3n5IDe9U7VFYiKe3v9hxdYqv4Fz0OPBkkZ2qdSkszo5T1zfVPh7uQmuwDETJbDYJPAke2LvOArlF2yMCKyO/2NkoJiPYfKcsuhNYn66xuuqMXD0PkbYmQELZxHuNTesYJRfc8NzpJPrW+Is/0EkKgtkgELcgz8NMPhYu1LklaUxurV+Q3R1zPz8hIpSFPVIbgEGZ72ETjcBbE2Vor0sekekcNKp5a40t+iduzN5hrxIxWvs=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5154.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(346002)(39860400002)(366004)(376002)(396003)(136003)(66556008)(66446008)(66476007)(66946007)(91956017)(4326008)(8676002)(64756008)(31686004)(36756003)(2906002)(110136005)(76116006)(54906003)(5660300002)(316002)(8936002)(71200400001)(26005)(6512007)(41300700001)(2616005)(186003)(38100700002)(31696002)(122000001)(86362001)(6506007)(53546011)(966005)(6486002)(478600001)(38070700005)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?aXFLMkw5aDVsdFROVld6RFpMQ0hhZHpaSU54WkZ3TVNGeEVxbGtPd2pDK3FE?=
 =?utf-8?B?S2tkalVWVkU4OHpTbGxlZk9ZVWJlbGQyZmdjek1MaHZja2hUc2JyVS9YTFBl?=
 =?utf-8?B?K2RveC9Hd0JNUEFPRUdOaDhxTVN3cmRNbXhseFdtWnZLQzNlWkZuZmg4cnlR?=
 =?utf-8?B?ZmNkOGRKMmtVNW9jc245d1FScHArVkljTHprZWk0T2tWNldJSDBSRis2Y1Bi?=
 =?utf-8?B?dlNEVkNVNkFpck9kSG51U1BsRGQzVG53N0t2Y2J5YllFamNCZ3JMMEZQeHRi?=
 =?utf-8?B?ZTkrK3pMUWYwYjA0MTZGWWZNNjNJc0Fwd0ZvZ0RiZExWaGxVVS81ZkgrRDNE?=
 =?utf-8?B?a3dzNk5Ec0EzYUFxVWFwa1VSZFdWcnlFdWdFUG51bkx2SUYxMGNTbUN5SFVF?=
 =?utf-8?B?ejdtRlQvWTVCVkovQVY2RFVFL0FNZWxQb2J4NVVxMWZvbjlLS1dyOGRPMG5D?=
 =?utf-8?B?LzVUUlh4dnZWdVRvd1cxaVZYNmd1czhzeE9nekNTeDZoRjBCRUF2SFpJMGhK?=
 =?utf-8?B?dE56RitjTnVSd3dJUWVIVm5LQzk4MW5sZ05IZmlLQnVxbkFwcWFJNzRVcjJi?=
 =?utf-8?B?b2VwZWtDMldXSzNBQXB3VlQvUW43WFV1MjB1ZnBSQlA2Y05WS0R4T2ZUbHRJ?=
 =?utf-8?B?WkdJS2J4UDJFcnJ5emE2Ym8vZ2Zaa3hQb0RuWnNQUk4vVWNGcndBaEZZU2dm?=
 =?utf-8?B?WDdEZXNuc2FVNkgzL1hEMXhHYks2VURWcWxVSVhIdUdpUzJMQTlhRm9sRFpj?=
 =?utf-8?B?OG96Rk4zTXFoR3pPQndTbVpzZzRzamNITitjUUluMXo2dEtkT0JhUXpLdVRU?=
 =?utf-8?B?aGRDY05TK2xkMWlkT3QvNm1BbmR3NHpGTkkyWS9EbGJZZ0ZvbElMT3RndU1i?=
 =?utf-8?B?azNMeW40bUR1T253NWF0Z3NNVUV5ZGx5dDMxUUZKeXVmazlFOFNmdGQ0bXlv?=
 =?utf-8?B?YzFQb2c4ejM4aVFPdGttdlpTb1ZGN0d5K3A0elQxai9sY3NFM2pCajJmdGMy?=
 =?utf-8?B?aktlL09KWkMvMStaYkJLTllWNUpUendoYmk5SGZBZFhxSzRKd2szcmo2SEFH?=
 =?utf-8?B?eGhUVGhnUGNBdG9uQ1BCanVrWjdyMmFHdEsrT0Y0dC9qWnBEOXlPcm85cENx?=
 =?utf-8?B?Y2JIMkRmSHRUOUg2S2lHTTdqTXlzZ1RYQTBkZmFyV25KZHlGR3ZtL1ZhbVpi?=
 =?utf-8?B?UE8yYWZKRXU5MHplbjZBQmhNcERGQjVNYzlLOEFoV2EvYXhIL2E3eHJ2ZlBm?=
 =?utf-8?B?L2x2L2lPbkVseU9xQTM0aWpUdEJ6dDVMaFJ2SEUwTmoyRE1vOVZ2VjFQdE9F?=
 =?utf-8?B?SWxTZlhhZ2lhU2pPYU8vcVZycFoyeFhFSXo0d1dlckx2UFNlNEFKaTR5ajFR?=
 =?utf-8?B?MldLcURhbS9iVXFRenphcDlKMWcvVjFRdURmcStWZzZBNkJqR0lkUWgrS00v?=
 =?utf-8?B?R0FrYU5SWjBMV1UrUHQxMi9GVldtN0xtVUNkaE05Y1dIdEoweW1scmlDdXpT?=
 =?utf-8?B?cXBZL056RnlVY3h0NmhWR1pId3dyYm9KcjcxcndkREl1c2dsWDZ0MkdnMzFD?=
 =?utf-8?B?QlYxWVF3bEhweEY1OEJtWS9BVzFmeTUraGxFUXljVVdFYk9OYnRoUDBRbC9r?=
 =?utf-8?B?MUp1UW5OanRNK1BtWE9iRUlqWXUwS1k0TTQ2OWFkVnRzWSs2bEhtcENmdTNw?=
 =?utf-8?B?TnF1YllxUzJkTGRUSkk2TkhTOHFsaDM5R1ZrRVRDamR4cHZyMzhnZlh3eiti?=
 =?utf-8?B?eWZGTWlwbW5vWDRMWjkvdG9sZW9pdVpZMThQRW1rbEwzVVpUcU1NSFB4V1lB?=
 =?utf-8?B?QjlFVzFLKzEwejBwazV1bzZiYnhBK3hMbHF2MHpPQWhtUmtwakFKMzdlV2Zs?=
 =?utf-8?B?bWxrbkdCWkFQenR2Tm1takJuc0Q4Wk9CSk82eWF1YzZjeENrNXNrL2VTVkFt?=
 =?utf-8?B?M0Z4THBBWHZPV09YVG5SMTZ0VytHYzhvM2FuN2pieTJBUHJXR2k5REJtTmZ5?=
 =?utf-8?B?V1VCWjFLejJyOHFjSlo1eTlyT1ZHRWRVTlZncmF5aDh4dW03UDBXR2ZFU0Vw?=
 =?utf-8?B?dmNHQU0rYXlNN2NOc1pIaG9ocWVOTmQvQklpM2wzc3VnN1pqRWI1SUtNMGV5?=
 =?utf-8?Q?EXz4DXVJu2p7AFDBYo0WhS2hC?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <98138874DD05FC4C80FB13C7D87EEA00@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5154.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e915c511-ee53-44a8-6b0a-08da86970433
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Aug 2022 12:40:39.4540
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4hNAkmQqA+hiUsLT1m/GUzTjTFdadMA5XLh51gMCDAkAmOPW2duTWVbpExdYi+SNCHp/Q6Gm9PzpVEHFtjJ57/jv27OjTkpxz9suFhug4Iw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB7092
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMjUvMDgvMjAyMiAxMzozNSwgS3J6eXN6dG9mIEtvemxvd3NraSB3cm90ZToNCj4gRVhURVJO
QUwgRU1BSUw6IERvIG5vdCBjbGljayBsaW5rcyBvciBvcGVuIGF0dGFjaG1lbnRzIHVubGVzcyB5
b3Uga25vdyB0aGUgY29udGVudCBpcyBzYWZlDQo+IA0KPiBPbiAyNS8wOC8yMDIyIDE1OjMwLCBD
b25vci5Eb29sZXlAbWljcm9jaGlwLmNvbSB3cm90ZToNCj4+IE9uIDI1LzA4LzIwMjIgMTM6MTAs
IEtyenlzenRvZiBLb3psb3dza2kgd3JvdGU6DQo+Pj4gRVhURVJOQUwgRU1BSUw6IERvIG5vdCBj
bGljayBsaW5rcyBvciBvcGVuIGF0dGFjaG1lbnRzIHVubGVzcyB5b3Uga25vdyB0aGUgY29udGVu
dCBpcyBzYWZlDQo+Pj4NCj4+PiBPbiAyMC8wOC8yMDIyIDIzOjQxLCBDb25vciBEb29sZXkgd3Jv
dGU6DQo+Pj4+IEZyb206IENvbm9yIERvb2xleSA8Y29ub3IuZG9vbGV5QG1pY3JvY2hpcC5jb20+
DQo+Pj4+DQo+Pj4+IFRoZSBTRCBjYXJkIGFuZCBlTU1DIG9uIFBvbGFyRmlyZSBTb0MgYmFzZWQg
ZGV2IGJvYXJkcyBhcmUgc29tZXRpbWVzDQo+Pj4+IHN0YXRpY2FsbHkgbXV4ZWQgdXNpbmcgYSBH
UElPLiBUbyBmYWNpbGl0YXRlIHRoaXMsIGVuYWJsZSBncGlvLWhvZw0KPj4+PiBjaGlsZCBub2Rl
IHByb3BlcnRpZXMuDQo+Pj4+DQo+Pj4+IFNpZ25lZC1vZmYtYnk6IENvbm9yIERvb2xleSA8Y29u
b3IuZG9vbGV5QG1pY3JvY2hpcC5jb20+DQo+Pj4+IC0tLQ0KPj4+PiAgICAuLi4vYmluZGluZ3Mv
Z3Bpby9taWNyb2NoaXAsbXBmcy1ncGlvLnlhbWwgICAgIHwgMTggKysrKysrKysrKysrKysrKysr
DQo+Pj4+ICAgIDEgZmlsZSBjaGFuZ2VkLCAxOCBpbnNlcnRpb25zKCspDQo+Pj4+DQo+Pj4+IGRp
ZmYgLS1naXQgYS9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvZ3Bpby9taWNyb2No
aXAsbXBmcy1ncGlvLnlhbWwgYi9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvZ3Bp
by9taWNyb2NoaXAsbXBmcy1ncGlvLnlhbWwNCj4+Pj4gaW5kZXggMTEwNjUxZWFmYTcwLi42NzA0
YTdhNTJjZDAgMTAwNjQ0DQo+Pj4+IC0tLSBhL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5k
aW5ncy9ncGlvL21pY3JvY2hpcCxtcGZzLWdwaW8ueWFtbA0KPj4+PiArKysgYi9Eb2N1bWVudGF0
aW9uL2RldmljZXRyZWUvYmluZGluZ3MvZ3Bpby9taWNyb2NoaXAsbXBmcy1ncGlvLnlhbWwNCj4+
Pj4gQEAgLTQ0LDYgKzQ0LDI0IEBAIHByb3BlcnRpZXM6DQo+Pj4+DQo+Pj4+ICAgICAgZ3Bpby1j
b250cm9sbGVyOiB0cnVlDQo+Pj4+DQo+Pj4+ICtwYXR0ZXJuUHJvcGVydGllczoNCj4+Pj4gKyAg
Il4uKy1ob2coPzotWzAtOV0rKT8kIjoNCj4+Pg0KPj4+IFdoYXQgaXMgdGhpcyBwYXR0ZXJuIGFi
b3V0OiAiKD86IiA/DQo+Pg0KPj4gTWUgYmVpbmcgYSBwZWRhbnQgSSBzdXBwb3NlLiAiKCkiIGlz
IGEgY2FwdHVyZSB3aGlsZSAiKD86KSIgaXMgYSBtYXRjaC4NCj4+IEhvd2V2ZXIsIGl0IGRvZXMg
c2VlbSBsaWtlIGpzb24tc2NoZW1hIHN1Z2dlc3RzIHVzaW5nICIoKSI6DQo+PiBodHRwczovL2pz
b24tc2NoZW1hLm9yZy91bmRlcnN0YW5kaW5nLWpzb24tc2NoZW1hL3JlZmVyZW5jZS9yZWd1bGFy
X2V4cHJlc3Npb25zLmh0bWwNCj4+DQo+PiBJIGRvbid0IG1pbmQgJiBuZWl0aGVyIGRvZXMgdGhl
IHNjaGVtYSBjaGVja2VyLg0KPiANCj4gVXNlIHdoYXQgZXhpc3Rpbmcgc291cmNlcyBhcmUgZG9p
bmcsIHNvICJeListaG9nKC1bMC05XSspPyQiDQoNCg0KV2lsbGRvIDopDQoNCg==
