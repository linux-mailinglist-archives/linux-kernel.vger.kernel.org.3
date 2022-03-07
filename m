Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D18BF4CFBE9
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Mar 2022 11:50:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241538AbiCGKvL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Mar 2022 05:51:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242493AbiCGKtU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Mar 2022 05:49:20 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C5AB27152;
        Mon,  7 Mar 2022 02:09:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1646647753; x=1678183753;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=THwEtvqwulAP1xU54RtB6qSaOR5I0M6GFXdMT0mM2+I=;
  b=JiLTv/U/pH/xTet+u3OLKODQk3BAxk1eMkJAdD2XVDt/6KNU8EdyTWbY
   kGkrSPg0MOM9vK8Dw37I9PjaX+zaRrW3rx9Vh1hUoBNAo5e1LnyEkbejM
   hWg7XJqArts3yP2BiDxtzfX9fq/rTJe0vQUhDsdyYyZADyTe5Sc3NPOtx
   zxHxL73T0sAueX6a3FwEdJ9V3YRLYJs8025O4rxDXFqBzhRtkt246nLm6
   NUuWvmZ0SkFKtJKZviQdbcOHS3FyGWU2e5OcILK3x8JJWJe5F2p13A7wa
   U2MsnSOPDhNcKecdKwwP/Y+0hBekGTFZvC664wBVEbe60R4UsrAnaP/JV
   w==;
X-IronPort-AV: E=Sophos;i="5.90,161,1643698800"; 
   d="scan'208";a="155475580"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 07 Mar 2022 03:09:13 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Mon, 7 Mar 2022 03:09:12 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17 via Frontend Transport; Mon, 7 Mar 2022 03:09:12 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OoS7YXXIQ5lnfMBJot+HTIQaJjSz9oXtw2/+Crt4BKQgvmQOU1c3yQHTjLHs6HT3Z6KruC6jOyJZajETsvAc2gyVyWoHeFxvXmNr/XdSqUy6+A8B5KCErbWnrUQTC9XK2zbbtmD5+kAkPiHEB7nS9zXXUzX2K2WUm8K8lRG33LH7q0zQnasmjtZYGY9G0O3e+OMNC1AyBf7MZLoQW0Y6+BNRAXVReonfXy+j/jnZXMEcqw6tx0DVdHVXyUHh1SG1IW+zmPoXKvXLUY712uzFjkPsCiVa0jiMME0m5e9nndnMP6JNJBHFSz7rmWKJlvKxb5Hq9RKAMG7D3k1qp+sv1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=THwEtvqwulAP1xU54RtB6qSaOR5I0M6GFXdMT0mM2+I=;
 b=LEmGs6SR91ZVrvlEJcufiHa5fn1NbvYFQ//CqIAMqS2/yUEMB0xaaUzLnNDL8NXmt9v6QTgtsUA/LPbRTd3jWVJc2lemO34pWtjRFvJWgD9RPiXd6XnW5OAq70+9ln9meY/OQQ6BFGEVAHTXZdj0pPLNAHhKW8w//AN+8HhXdwEl2+4K2AsN4QUJsLVO+GMrMADHnnqhGUcp6epmHsyGVqcRq28JG8nuFHGkotSHVgjKwPpek/lxsHF7Mkc8YRrjJtogdR7sp/7yK/RoYJS+CKx8sRT6K9wFLk9YMbi6E/RH30FFrSxuIK/QnAlyz3w/SROLLpVegz03IeY0T2p7Kg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=THwEtvqwulAP1xU54RtB6qSaOR5I0M6GFXdMT0mM2+I=;
 b=KhNkK8wCvAmB/BNdce1SYGRS6QQjZgDDT0ixJu+vIbUpTEvhOs3ndY3ywfBYpPZGvNyR3F25A6bABx8heAnKpu+1L+FfVnW9/nkirNQRJaNByhKaTMpVXnJmSYDXHHNGz3V/HWZns1A4eB9ZMamDMJU7/QW/YEH4Eue2JzYpxhw=
Received: from DM8PR11MB5687.namprd11.prod.outlook.com (2603:10b6:8:22::7) by
 DM6PR11MB3020.namprd11.prod.outlook.com (2603:10b6:5:69::32) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5038.14; Mon, 7 Mar 2022 10:09:11 +0000
Received: from DM8PR11MB5687.namprd11.prod.outlook.com
 ([fe80::fc32:96a4:933f:194f]) by DM8PR11MB5687.namprd11.prod.outlook.com
 ([fe80::fc32:96a4:933f:194f%4]) with mapi id 15.20.5038.026; Mon, 7 Mar 2022
 10:09:10 +0000
From:   <Codrin.Ciubotariu@microchip.com>
To:     <krzysztof.kozlowski@canonical.com>, <alsa-devel@alsa-project.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
CC:     <lars@metafoo.de>, <broonie@kernel.org>, <perex@perex.cz>,
        <tiwai@suse.com>, <robh+dt@kernel.org>,
        <Nicolas.Ferre@microchip.com>
Subject: Re: [PATCH 2/6] ASoC: add DT bindings for Microchip PDMC
Thread-Topic: [PATCH 2/6] ASoC: add DT bindings for Microchip PDMC
Thread-Index: AQHYL/Q80blLxhzU8EasY6BR2ADNqayxWd2AgAJdAQA=
Date:   Mon, 7 Mar 2022 10:09:10 +0000
Message-ID: <92ba07cb-ab42-41b9-d988-d4318a7de728@microchip.com>
References: <20220304181756.1894561-1-codrin.ciubotariu@microchip.com>
 <20220304181756.1894561-3-codrin.ciubotariu@microchip.com>
 <9e6bfc9b-63d0-d4b3-90af-4bf06cdb27f2@canonical.com>
In-Reply-To: <9e6bfc9b-63d0-d4b3-90af-4bf06cdb27f2@canonical.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6f60f039-7b22-40c9-a083-08da00228663
x-ms-traffictypediagnostic: DM6PR11MB3020:EE_
x-microsoft-antispam-prvs: <DM6PR11MB302012429D6C98DC8EDEE07FE7089@DM6PR11MB3020.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: hzEYM6GvuqiR3Hd4iqsTvhlM42X0gSYA8YUL41Sh4CCOOWEK3QJaz7baTaDcblJE+Pr4DngSFMIVk1wzaMU6zfJZg0B4jQQudWn4ibq/DdlFIPzCFpD2O4129k/Nz39xAZs+++buvjVrTEiTI7gV+h8bsdNzVpGDCLW/jm2LDOOfKxTpu5FOI2jyqSt8cyOgdZ2LDFqnBfwR8v6B69XUVKrUQ94Uh2Gi0bTiXT25t+wHyg3knljSwK5uX88H5scZMlYNaUrDs+UfqpgADYjHyoJRKrynKcw24CBeffCi8I29r/lVBGrTtnGbgplIwY/vFpYH9kVPE2AQ5oHuqYRO2gvPMcLGmJEV/Esu8rZ0l1Fid6sOqALhJCAyxzNfiAbIjxLCpEnk0exqJs9C8ZKfKxYgWPKzeeHOg6dW8Fh6rEieypJtF5V/G21moQWEspZA6MCGKROTTGyiEQSdh83ReppxtdyNsGWZgWKW8jQReEVZ7aJItDDrh4dkJZpWPfzBXvFkMaQUmKOTfVxxDjHSSLGFzjo5KZR7nTYOpVX4cSRos/V75Q999SD4Imp4FLvAFYmkHrxYAV+aE2Y+PtgdMhueaGwKFTU5MjC4rT3IvW2xcNfZt6mFTlBNzZ92m633N4lfdqePPoRqP3jh+6VgBT+ac3cmhVvcVmnGHIEqLbFHnBjqBYIv2cfDE21HkfeNgU4rl3TWNv15uv0Wn4G0Qe/RDCaOS+DWNW7E+/3WeHrHxPPBPU4pF6BmVFaoUavPULadKzgran9Dj10YkyH6tA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR11MB5687.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(122000001)(110136005)(38070700005)(38100700002)(36756003)(54906003)(66556008)(66446008)(31686004)(316002)(71200400001)(2616005)(66946007)(4744005)(7416002)(5660300002)(86362001)(508600001)(6506007)(8936002)(53546011)(6512007)(186003)(26005)(107886003)(2906002)(66476007)(31696002)(64756008)(91956017)(4326008)(76116006)(8676002)(6486002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MjY3bnl2dDdUQVB4ZWVHVjI0SHNQekdOZTNTNjBwZjFiSGNnUW9FSEgrV2VU?=
 =?utf-8?B?a0lIZFQwcVpHOHBRYlpEZUVid1NRVFVRdE5DRzQ2akVINnlPN3k1MzIwT0tW?=
 =?utf-8?B?SnNrWGdvWUtlMTIySmNwU1NKeHBUZzdydGlTSDVxVkxRZUtOeUUxbVd2MDFO?=
 =?utf-8?B?SmNLeVZOdnIycmhYcVNmb25UQ0RFMitPeDBoaUFBTTB0WUZsMitMN25OWUZq?=
 =?utf-8?B?MFpwblV5WG96ZlZzQUJjV3Fjcm9QYUY0eEcrNDZZQWlva2FuTFU5YzRTUTlM?=
 =?utf-8?B?VFdxMXdZUkJlamxETjVkK2dyckk5UEt6THd6aTJmUnkwSE1jNSt6U0M5d2pB?=
 =?utf-8?B?L0lDTWhDYm9Cb3R5YVk2M21QVU5KVmxjblkyaWhrUW9HV2JIaCtpZ2ZmaEk0?=
 =?utf-8?B?TU1MbjZhMFUrUE8wTFlkNHdYUmIxN2twRFVEa0IrRnI2T21hckU3TC9oSzBD?=
 =?utf-8?B?bjVvN1kvOUFSRWk0REJVS2RoREI0b05hVzdLN2lvaEdMUVVsSTBUSmFKL2Jl?=
 =?utf-8?B?MjliUDhFVGh0YlRkM2wyZldUb0txdGZ0MlNvTnN0NDFRRUp4aUduM2MxS3Js?=
 =?utf-8?B?eUJFckR4TFY0MTBEWU9MNEhLeTFvZkFTZlNzM05tRHRHbWxsRFJ6SmRsWld5?=
 =?utf-8?B?TWh6Wk1USmZZTURPWCtsZjBxNlpjZEozTXRuR29xUlFudGJNWUUxREFyc1Rl?=
 =?utf-8?B?R3NIYXpkVGhiVVhOSmZsREQ3ZktxamlSWFptSm8rQisvNjBIQXZkRHpJT2xG?=
 =?utf-8?B?WGczUWF6LzJkVVYwQ00rYXcvcUgvL205WndOMGxJeVdQbTh6NU5HRmk5bExs?=
 =?utf-8?B?cStDdU5oQ1FkZzFIVlppeFAwTkVOYlJMczJaa3Vla3JuZkU0MDlyZ2JvVU1Y?=
 =?utf-8?B?M1o0ZWNYM0tZeVA4ZDZ1dmRQZDlOREZmdEx5TExTMnBmdnZpMEpOSkphVmVt?=
 =?utf-8?B?VHdKRmZucVVGRlZiVXpOR21iYURwMGM3RXkxNE9jY0FsZUZCSEd0WkhWck5p?=
 =?utf-8?B?T1lNeUNndjJGRjcwWmxGalB2VTErd3RUeGxGbm51WnkwZ3NXL3dCVnJya1Mr?=
 =?utf-8?B?ajlnQ3dEYTlNb0ppOUhPNjd5ZHdYZU5xR0FBZFc3YWdvUFBHWjVreS91YW5Z?=
 =?utf-8?B?dmNoOEc3dlRxSzFyRENZL2k3M0k3QXhydEVIa3hmYlc1ajdHRmNkQnA1ZlNQ?=
 =?utf-8?B?R21VSi9kRjNTcm93ZDFPV2Y1algvdSt1V04zdzFiVFVPLzc1UFd1dTVvanNr?=
 =?utf-8?B?aTNsK1FQUTljSWV3U1VqZkdHK0N0bFFVZXg4NTBFRGNJZzFlWUs0VzlXU3dr?=
 =?utf-8?B?QnVQL2Q5WXJrSURPSnFBWHpQTG9QTUg5MER2amVuTkRscFViM0NhNk44Y3ht?=
 =?utf-8?B?NGM2T2FsNldibFFsblJwdGVGMitMTko4SWtDZFBadEduK0hKOWVwR2lSZXZs?=
 =?utf-8?B?TUxhbGNsSVk3OVNpVVB6WW9Hbys4Qkh4MjVaenF4WlZyOU5iblMzRk1pRU4r?=
 =?utf-8?B?b3lrNzhEMWhubDdvK01pZGJrbkFyVk9xVHZhcDJyU1JBNFEzS0YwVklGdkVR?=
 =?utf-8?B?K2J0Wmt5UFpMSXRualhPRmZSQTlGeTBoZDF5NmRXcFVKVGtUeDROYXFSZTBH?=
 =?utf-8?B?MThxTVJwVFAxM05ZaUYxUHZjZVZJNG5uR1dHTFZEbnBRREF4TmtIL2FLcDZ5?=
 =?utf-8?B?OHRBQlZVMTRpRldQNjl4djlqemQ2Yzd1RW5ybDBkYnQraUZ4SGJlSGhSSVFi?=
 =?utf-8?B?dCthV3BkOHlyVzVFUk90VTZreGlrbUtsYnRDUWo4dzZtMU5rdUNIemdPNnVP?=
 =?utf-8?B?aWpZbTAyM0oxaTFRbUJ3K0p0RDhiMTFwTG90aXBwQkh1QWQ4eUp0Vk95a1R1?=
 =?utf-8?B?Q1NkSkpKUDZXTWRoT1Y2blNWWlE0NmFOVkRWVGRFQUtmek1UdFdWTzFoOWRs?=
 =?utf-8?B?TzJ4dHZ2SEh1dGxUNGJEdkZQUEdpTzVzSGlSR2FzMTgrTy9RUGF6MTR4MUZ5?=
 =?utf-8?B?dGF3cE9LYnQ3d1FMWm5aZkdSQ1JsKzN4UFBOWTVRazFHT0ZMSWRDelZyK2o2?=
 =?utf-8?B?OEZYa0ZUWndGOXFlTSt1TUFHZG9saUlKVUJmdHBlQjVxWjRBdkJxeXBoSXFE?=
 =?utf-8?B?YzlXUWxaekhoRlkvWWtWbzNDaXpqZkU3UE5xa0ZXcUVjUEtWYjBmMVNvQzNG?=
 =?utf-8?B?QUYzS2dRcG5WYjBDRmNKSEtNRElCMlN1eWFHOXVyMHZ1NjMvaXRYQU8vdHUy?=
 =?utf-8?B?UWhCMC91OHpRTzRBNkd4TTJSeUFnPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <37203E75CF4DCF4BB05D22F3412B5037@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR11MB5687.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f60f039-7b22-40c9-a083-08da00228663
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Mar 2022 10:09:10.9117
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9fWq3sq4epuNvhkfNK+1ygNNtePq502TD2t1T0548KvHbvl0iWKqZG8tWDPO248Mpr75sYWR7RcE/WeIEVbMJngKKA+UjL1Ov5Umvji+dew=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB3020
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,T_SCC_BODY_TEXT_LINE,
        T_SPF_PERMERROR autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMDYuMDMuMjAyMiAwMDowMywgS3J6eXN6dG9mIEtvemxvd3NraSB3cm90ZToNCj4gDQo+IE9u
IDA0LzAzLzIwMjIgMTk6MTcsIENvZHJpbiBDaXVib3Rhcml1IHdyb3RlOg0KPj4gVGhpcyBwYXRj
aCBhZGRzIERUIGJpbmRpbmdzIGZvciB0aGUgbmV3IE1pY3JvY2hpcCBQRE1DIGVtYmVkZGVkIGlu
DQo+PiBzYW1hN2c1IFNvQ3MuDQoNCi4uLnNuaXAuLi4NCj4gDQo+IEJlc3QgcmVnYXJkcywNCj4g
S3J6eXN6dG9mDQoNCkhpIEtyenlzenRvZiwNCg0KSSBqdXN0IHNlbnQgdjIgd2lsbCB3aXRoIChJ
IGhvcGUpIGFsbCB5b3UgY29tbWVudHMgYWRkcmVzc2VkLiBUaGFuayB5b3UgDQpmb3IgeW91ciBy
ZXZpZXdzIQ0KDQpCZXN0IHJlZ2FyZHMsDQpDb2RyaW4NCg==
