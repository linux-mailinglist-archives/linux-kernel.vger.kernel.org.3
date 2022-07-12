Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AACAE571BE8
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 16:03:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230285AbiGLODt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jul 2022 10:03:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229510AbiGLODp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 10:03:45 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10402E02B;
        Tue, 12 Jul 2022 07:03:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1657634622; x=1689170622;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=2B6a7B27j6G+mG48B/lmx6CJCZOTJ2qKLHvnCQwLwiA=;
  b=gR6V1ORGJFFDTF3u3LsjX3g+IvOuOYOfmXtFc5tLEcsOr5HACvV1G1QA
   +Hnzi6rpZZM6pQ/CHYZUK6RnOb+jMtSkHtCMbn1L5HINNW3v61JNJXVJu
   0ga9UjWdfotsoR1kQTgscyvbQgd+5z/ZomMi4fW8+8SaKR9wr4oZ7SbSo
   SHg33C5DQszYpLkvgW0mh0nd9966FVWjsBVGO4RNt9tx/Q/nmUPuJbv/s
   jxXe2kmTZyXs3XtjJ05KjawAo3v5NFn4CMvcND9vX45RcUw/9u31ZQVqT
   stZ4CI6ERRBtpWvGdTGeMLDkCZQvyJ0WgYt4FXjZgdgXAh1fJspt7Exai
   g==;
X-IronPort-AV: E=Sophos;i="5.92,265,1650956400"; 
   d="scan'208";a="171767958"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 12 Jul 2022 07:03:41 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.87.72) by
 chn-vm-ex02.mchp-main.com (10.10.87.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Tue, 12 Jul 2022 07:03:40 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17 via Frontend
 Transport; Tue, 12 Jul 2022 07:03:40 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h6ZQI7JKheXm3/el5IrTOtvYXztM6dN9RrgGTe9uGOkcdro1mEHbvGsO8EDGI0lEOrV9j7z0CSeQEw86NsDE2UE5mya2K9XLpc3gqPkYkraMZQ/ZE+So1QMlh3ZkLnQEiMPd/RElQjvyeuA3y7MvfeHGn+gMmwa8bgCeqpnleq9SJ6mdAOVQZFQWU1bC8rU7p5GzxPwL0ztu9EvhNWklApgxC2nS3rDaaFyeELeHKYJygtyYcVrUCzGNmbZGVJLTPlMmAvjml1jopv6cm1SWkq6+eI7H4gMmXOi5cE+8bU8vNNOkRJJHrmKGX0bb+tAz1DKcD/oXR1ZCw5Zd6zxFgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2B6a7B27j6G+mG48B/lmx6CJCZOTJ2qKLHvnCQwLwiA=;
 b=ksPsV06Kq4HaYUrBiO84yp+jEnwcwOfCVb5bh2xOsAdQULw0RAw9gpUUd19Vdf6Tfm9V+P2nOnj23TPbwmRLPxAeMOM4+LMbymFVY8ytA++ZbnnB/t3CQqF37gYiR0tvb1T+RBWn9mT27UfTZWR/mhYaQ35n3veFsOEebz3QXYRJOogkQqdLqEm4+OPWescm3N1Tw9rdvC88Bz5B30/vLdVPNuI/hn3sxTJotIwyGXRottKWQ4HRSuK0OBSNA8OWuRsjc/k/DZ1aL+zkPwgetKHNOzh4wRgEhL+ra4s7ECt+RAO+aTQgzwMrk+uT6OMI860qq9TRbbXVr/598UEeeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2B6a7B27j6G+mG48B/lmx6CJCZOTJ2qKLHvnCQwLwiA=;
 b=AgUc0T8AoGkctcwXhTyF9ABSEdaa5bMN0kVEF94MSYk0wrCRdcWe74u4//93poMeHiKNCWmdSEp5W7eDzIuEK0mWljxjl9TqbAlXwK9c/ES71V7JWc2hXiCGH1lLIar8JXheOfqyl5zVFkhHUxpCUISfXLOUaxnEjGAQog/CyEY=
Received: from CO1PR11MB5154.namprd11.prod.outlook.com (2603:10b6:303:99::15)
 by BN6PR11MB1492.namprd11.prod.outlook.com (2603:10b6:405:b::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.16; Tue, 12 Jul
 2022 14:03:34 +0000
Received: from CO1PR11MB5154.namprd11.prod.outlook.com
 ([fe80::8d4a:1681:398d:9714]) by CO1PR11MB5154.namprd11.prod.outlook.com
 ([fe80::8d4a:1681:398d:9714%5]) with mapi id 15.20.5417.026; Tue, 12 Jul 2022
 14:03:33 +0000
From:   <Conor.Dooley@microchip.com>
To:     <yangyingliang@huawei.com>
CC:     <Daire.McNamara@microchip.com>, <broonie@kernel.org>,
        <linux-spi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-riscv@lists.infradead.org>
Subject: Re: [PATCH -next 2/2] spi: microchip-core: switch to use
 devm_spi_alloc_master()
Thread-Topic: [PATCH -next 2/2] spi: microchip-core: switch to use
 devm_spi_alloc_master()
Thread-Index: AQHYlfWKEaKO0rADDkGuzfTu66tTVK16xHiA
Date:   Tue, 12 Jul 2022 14:03:33 +0000
Message-ID: <87581e76-ceb7-9efa-d6dd-5ad4fe66111a@microchip.com>
References: <20220712135357.918997-1-yangyingliang@huawei.com>
 <20220712135357.918997-2-yangyingliang@huawei.com>
In-Reply-To: <20220712135357.918997-2-yangyingliang@huawei.com>
Accept-Language: en-IE, en-US
Content-Language: en-IE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a1a28cc6-c6e5-4b61-fe23-08da640f4ef3
x-ms-traffictypediagnostic: BN6PR11MB1492:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: zcxViPA+mq8DtMjvq7nL1QaopzshXMLf917KlQZp4W0kyiU3TSqKBbRL+pd/mhM697x5JCpxieE+eYQlUoBFq63b3TfO9y+XCm9bMQBUK0yyWgmXyP5+DMNJPMpqqH7cWfpRYca+5WPxJr9pkQmHzrK8eYc16zJzgjJ1iBkiEaAoiEPqBSfmrH3N6aFmAnzsh6PPFifACTFL6TRQnS0acByasagxNvmNZajNUztZWZezH5Fjkxqsv3/Rb7VjdyJ/N7Nb2CDqKY2+OSi7t9CEMp2ncJg1MqdJ1iuSiUOsWIrmMoSJcHed8pSDTC7bj2vNqJSwDbvXNtS+dQEZv0eiCXHvbNMygZY5eUJAV7/PKEyUeq1xnyvzN/6x3ibvQVFlfBY/Ucgef0SZ+5kXkOX+RCcswfyh17rCfer7QaVkgmn2LrWbFDNvZJKPgSoGWQEh7lj5Qz9QOVUKasLuFAeVel6vGpbtaboV3A6O6wLkBH84Iq7ZOSYl+sTAbQav4MBVbnk3CkQ5p+olHrXl/DVuK6gLQjxmzoikob0vfQvcALdtAI6RaTl7iDKlob0RbHeWT4eYD2Ks/H7YdJAz5vydl/P33SAqPiFCKErD9gsWp84yCsGv4latPcS9M8e6yDE+M05cg6ZFJIIH+NpJ5RyMJ0SLMux1qV1ruxw7KnFon3Wye5OHBGVIBASnoE1hzzzARLdA4mAx+cw/8czZAkqualeln/Vm7foSBxW8QJz5Q16G5LfM1dkFrNvbeB6ctwsmm9occooeDhl8c9GSCSkj2e8YD9sRYVosF+kmZycUWQle037hK9dywqqYatyZCd3N+1UBgm9FZn0yj32kzs2VTqXN/ohL239hlTBLLxWGxl7k6+9OonkyXkRxjZ2rgtUb
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5154.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(366004)(396003)(376002)(136003)(346002)(39860400002)(41300700001)(2906002)(86362001)(316002)(38100700002)(478600001)(31696002)(6506007)(6512007)(53546011)(26005)(966005)(71200400001)(38070700005)(6486002)(122000001)(5660300002)(54906003)(6916009)(66446008)(66476007)(8676002)(31686004)(64756008)(36756003)(83380400001)(66556008)(91956017)(8936002)(186003)(2616005)(66946007)(4326008)(76116006)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?THlxcTQ4akM1Yk1OcnpkNkd3SHljYUxYVXpZMzRqbU5ZVklHSzA2b3FKVFRF?=
 =?utf-8?B?SDZCYkpQTmxtTVJzYWhKMzFLNDZ6Tk5Hb0h3QVhGOHM4aGllWXVSNjdYc05u?=
 =?utf-8?B?NjA4ZWN2eW95cnRoeWZZTXBQQndGVENsYzNpZkh3aEI1SWRVUVR0WXQ2V3Z0?=
 =?utf-8?B?UzVuUkVnalVaVmRrSzNWSDhRb1NrMzhNMHNyYVo2NERKdzMrTzh5S1p4NEZw?=
 =?utf-8?B?VGV2OW53dFpaenNaRFQxeWZlK2NCYzlpNVJTYXRndEhnTlA4SUtnbU9UT3Qx?=
 =?utf-8?B?Y0Nhem13TzRlSUxUZUFOOWszdlBEUlNPOHJHblFHWStsSjJTTmlaeTMrUG1R?=
 =?utf-8?B?c1hVZjdaRi96YkJ4WDVUODh3RUFQTVUrdXh5MVJ4NlM1Y0VZQTRsK2d6VVRk?=
 =?utf-8?B?TFdmTEsrYXowMy9ZZE16VWIzNGZMaXZEZTNEUUpha2dMbWJYNVF1N0J1MUxy?=
 =?utf-8?B?aUJHUHFXTUR4K0owUjhOMXRKMkJCQ0VsUlUxdm1xNWZXbEp4cDZDZmlIK0Mx?=
 =?utf-8?B?cGVmS2daOHcyY2FrYm82VitvOGg3L0ZOZEZHWks2R1hOWDFzRCtDL1l1ank5?=
 =?utf-8?B?MHlqbmZOTFYzbGNmckg4WUk4c3NCaEZHcDJGcnZGTWs5Um0zSnVkL1BQTlNt?=
 =?utf-8?B?SWJlUUFSZWhCZzVYUXhPMlZsWS9GLzczRDRiT1dDZEdSTEs2QWxLVTA0SURy?=
 =?utf-8?B?aWRCUUY2bHpxN0plNHhoWlRkYUxtWEk2ekRLdXlPcnNQMFR4SGZJY2krTWU5?=
 =?utf-8?B?U2JFT3hqRXUwV3BPdEtSYnFhMTg0Q1luR3oweFJQc0JzTER2UEZjcnBzeTFS?=
 =?utf-8?B?Sk1FZG9FVWVQQmhrejNqaWE3TFJYZWtuS2dHR3JkbmxQS0RHSXAxamhNbHNO?=
 =?utf-8?B?QjZRZmRkMmk1Tk9MSGdORTlCaTlMbkloUUlDTFM3UkVxSzJ4WmIvWTBWa09a?=
 =?utf-8?B?VTR0d0htWGNRSFlPTnprVXZYOTRRcVA2aUNvRFpQbWhxSHowOG12aDQ3N3p1?=
 =?utf-8?B?SXJONC9IaDZFWFMxUjVhdmY2M1NNVnptSlFLbERHTm1FUHR5cWo3cEErTHdX?=
 =?utf-8?B?NnZiNWNTbkh4MXFkY2ZhOU1KT1h4Vk5VN01idkdGcTNRb0tTb2pzcUFuajBs?=
 =?utf-8?B?WU9qTkU0OFlGVjVVNkZjV0Q1N1YrSHhCUHg5dHI4eG52NnYzVGJQS01FWFRQ?=
 =?utf-8?B?UXZ4akVYcVVYSVVZd2dMaXI2UFNEcmxLMlUzMThveG5LZVFUR2N5RGFSOUpm?=
 =?utf-8?B?NDBFK2VoZFVpUk5kUzNGM2dqaEF6ODFxMHNnUk41dkEzQ0JaandmWDdaa2w4?=
 =?utf-8?B?dHZRMXNQY3JVZGJnWENJNWFNTFhVQ3RHVUZYWFovYTQvRCtyNTVaMERTakZD?=
 =?utf-8?B?d1hTSTMxMGoycFhSKzhEY2pnN0hkL09pS1psN0NnSmprTHVyazJOTHRGUnZa?=
 =?utf-8?B?WmFMVHRSRFJLSDFTSFE3SDZ0N0Ztd3hxM2tTOWxkZ0hESHNxUk9ZMHFsQTdE?=
 =?utf-8?B?V1JabWpwbTM4ajdKTzRtY3p5TC9yYjNwN3lWdm10cHJCRWtPTVltb0NjcUNH?=
 =?utf-8?B?dVRWUnEwRWU4dk1CWXdxeENqOVJ0OTNubVRvSkJzTUJtTEdNNkdkQ2tONEZy?=
 =?utf-8?B?Myt1V3VMOHozWnZVTlpnNzB3eXB0YlBBWGdNZ2RRQ1YwZU1waHgwdnljaGg0?=
 =?utf-8?B?V2lOQm5vSHBicHJ1QW80SnM2dkg5cXlVMHlZcWxvOWZCTVpuSlJyNEYzc3My?=
 =?utf-8?B?eVpVdXlYK2FYVW9iR2VNcnZTeTlyQnlJTHVPUEEyRTZORmk1OVl3M0hwa2pL?=
 =?utf-8?B?MHRjWVR4dm9KN2R4OVZGUHFqODVWKzFJZDAra0VKMTlCYWJNL3dCWkh3Q0Nl?=
 =?utf-8?B?L2pWNjFPWEp1WUxPQjh4MVMveUFWeFZ3SVV2SEg3c1FYYlFHdkxQWitBSUda?=
 =?utf-8?B?YWI0eU1WUDVwdGJrdUhkeVUwR2R2MUhuQUk0cTZFOWxMN2hreU90ZEFwUUVr?=
 =?utf-8?B?eHJFdEd3RWpCcGQ2R3JtS3FVQW1lQmxmeGJnb3BWN0xWOHZzUFJhbWp3UjQ3?=
 =?utf-8?B?Qi9rWFh3aWNodGVEa2FLeFpZVE15WHRUL25tRHM5MWVKZjNtYmxRRzZDN2d1?=
 =?utf-8?Q?UkcgchvmOYNGJAcs9FyFAHFyE?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <995BD8C15AFB924C9930BBCC7BF1FD8C@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5154.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a1a28cc6-c6e5-4b61-fe23-08da640f4ef3
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Jul 2022 14:03:33.7778
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /Kp+3uDrv4tRCnuAT2c/3QRadxvL/EMKVpXqa2f2EwD2xtNX18w+8qONJISKS/0yhyi1j/6IYsI4Q9QiJW2S07ZUtovv6TYj94JSPLN+jcQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR11MB1492
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMTIvMDcvMjAyMiAxNDo1MywgWWFuZyBZaW5nbGlhbmcgd3JvdGU6DQo+IFtTb21lIHBlb3Bs
ZSB3aG8gcmVjZWl2ZWQgdGhpcyBtZXNzYWdlIGRvbid0IG9mdGVuIGdldCBlbWFpbCBmcm9tIHlh
bmd5aW5nbGlhbmdAaHVhd2VpLmNvbS4gTGVhcm4gd2h5IHRoaXMgaXMgaW1wb3J0YW50IGF0IGh0
dHBzOi8vYWthLm1zL0xlYXJuQWJvdXRTZW5kZXJJZGVudGlmaWNhdGlvbiBdDQo+IA0KPiBFWFRF
Uk5BTCBFTUFJTDogRG8gbm90IGNsaWNrIGxpbmtzIG9yIG9wZW4gYXR0YWNobWVudHMgdW5sZXNz
IHlvdSBrbm93IHRoZSBjb250ZW50IGlzIHNhZmUNCj4gDQo+IFN3aXRjaCB0byB1c2UgZGV2bV9z
cGlfYWxsb2NfbWFzdGVyKCkgdG8gc2ltcGlmeSBlcnJvciBwYXRoLg0KDQpIZXkgWWFuZywNClRo
YW5rcyBmb3IgdHJ5aW5nIHRvIGZpeCBteSBtaXN0YWtlcyENCg0KRm9yZ2l2ZSBteSBpbm5vY2Vu
Y2UgaGVyZSwgYnV0IHdoeSBpcyBpdCBva2F5IHRvIHJlbW92ZSB0aGUNCnNwaV9tYXN0ZXJfcHV0
KCkgaW4gcmVtb3ZlKCkgYnV0IG5vdCB0aGUgb25lIGluIHRoZSBlcnJvciBwYXRoIG9mDQp0aGUg
cHJvYmUgZnVuY3Rpb24/DQoNCklmIHRoZSBkZXZtX2FkZF9hY3Rpb25fb3JfcmVzZXQoKSBpbiBk
ZXZtX3NwaV9yZWdpc3Rlcl9jb250cm9sbGVyKCkNCmZhaWxzIHdvbid0IHRoZSBzYW1lIHRoaW5n
IGFwcGx5IHRvIHRoZSBwcm9iZSBlcnJvciBwYXRoPw0KDQpJT1csIEkgdGhpbmsgdGhpcyBwYXRj
aCBuZWVkcyBhIGZpeGVzIHRhZyB0b28gYi9jIGl0IGFsc28gZml4ZXMgYQ0KcmVmY291bnQgdW5k
ZXJmbG93LiBQbGVhc2UgY29ycmVjdCBtZSBpZiBJIGFtIG1pc3VuZGVyc3RhbmRpbmcuDQoNCk9u
ZSBvdGhlciBjb21tZW50IGJlbG93Lg0KDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBZYW5nIFlpbmds
aWFuZyA8eWFuZ3lpbmdsaWFuZ0BodWF3ZWkuY29tPg0KPiAtLS0NCj4gICBkcml2ZXJzL3NwaS9z
cGktbWljcm9jaGlwLWNvcmUuYyB8IDIwICsrKysrKystLS0tLS0tLS0tLS0tDQo+ICAgMSBmaWxl
IGNoYW5nZWQsIDcgaW5zZXJ0aW9ucygrKSwgMTMgZGVsZXRpb25zKC0pDQo+IA0KPiBkaWZmIC0t
Z2l0IGEvZHJpdmVycy9zcGkvc3BpLW1pY3JvY2hpcC1jb3JlLmMgYi9kcml2ZXJzL3NwaS9zcGkt
bWljcm9jaGlwLWNvcmUuYw0KPiBpbmRleCBjMjY3NjczNDMxNzYuLjFhMjRlNDdmODMwNSAxMDA2
NDQNCj4gLS0tIGEvZHJpdmVycy9zcGkvc3BpLW1pY3JvY2hpcC1jb3JlLmMNCj4gKysrIGIvZHJp
dmVycy9zcGkvc3BpLW1pY3JvY2hpcC1jb3JlLmMNCj4gQEAgLTUxMyw3ICs1MTMsNyBAQCBzdGF0
aWMgaW50IG1jaHBfY29yZXNwaV9wcm9iZShzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNlICpwZGV2KQ0K
PiAgICAgICAgICB1MzIgbnVtX2NzOw0KPiAgICAgICAgICBpbnQgcmV0ID0gMDsNCj4gDQo+IC0g
ICAgICAgbWFzdGVyID0gc3BpX2FsbG9jX21hc3RlcigmcGRldi0+ZGV2LCBzaXplb2YoKnNwaSkp
Ow0KPiArICAgICAgIG1hc3RlciA9IGRldm1fc3BpX2FsbG9jX21hc3RlcigmcGRldi0+ZGV2LCBz
aXplb2YoKnNwaSkpOw0KPiAgICAgICAgICBpZiAoIW1hc3RlcikNCj4gICAgICAgICAgICAgICAg
ICByZXR1cm4gZGV2X2Vycl9wcm9iZSgmcGRldi0+ZGV2LCAtRU5PTUVNLA0KPiAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICJ1bmFibGUgdG8gYWxsb2NhdGUgbWFzdGVyIGZv
ciBTUEkgY29udHJvbGxlclxuIik7DQo+IEBAIC01MzUsMzYgKzUzNSwzMiBAQCBzdGF0aWMgaW50
IG1jaHBfY29yZXNwaV9wcm9iZShzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNlICpwZGV2KQ0KPiAgICAg
ICAgICBzcGkgPSBzcGlfbWFzdGVyX2dldF9kZXZkYXRhKG1hc3Rlcik7DQo+IA0KPiAgICAgICAg
ICBzcGktPnJlZ3MgPSBkZXZtX3BsYXRmb3JtX2dldF9hbmRfaW9yZW1hcF9yZXNvdXJjZShwZGV2
LCAwLCAmcmVzKTsNCj4gLSAgICAgICBpZiAoSVNfRVJSKHNwaS0+cmVncykpIHsNCj4gLSAgICAg
ICAgICAgICAgIHJldCA9IFBUUl9FUlIoc3BpLT5yZWdzKTsNCj4gLSAgICAgICAgICAgICAgIGdv
dG8gZXJyb3JfcmVsZWFzZV9tYXN0ZXI7DQo+IC0gICAgICAgfQ0KPiArICAgICAgIGlmIChJU19F
UlIoc3BpLT5yZWdzKSkNCj4gKyAgICAgICAgICAgICAgIHJldHVybiBQVFJfRVJSKHNwaS0+cmVn
cyk7DQo+IA0KPiAgICAgICAgICBzcGktPmlycSA9IHBsYXRmb3JtX2dldF9pcnEocGRldiwgMCk7
DQo+ICAgICAgICAgIGlmIChzcGktPmlycSA8PSAwKSB7DQo+ICAgICAgICAgICAgICAgICAgZGV2
X2VycigmcGRldi0+ZGV2LCAiaW52YWxpZCBJUlEgJWQgZm9yIFNQSSBjb250cm9sbGVyXG4iLCBz
cGktPmlycSk7DQo+IC0gICAgICAgICAgICAgICByZXQgPSAtRU5YSU87DQo+IC0gICAgICAgICAg
ICAgICBnb3RvIGVycm9yX3JlbGVhc2VfbWFzdGVyOw0KPiArICAgICAgICAgICAgICAgcmV0dXJu
IC1FTlhJTzsNCg0KQWxzbyB0aGVzZSBjYW4gbm93IGJlY29tZSBkZXZfZXJyX3Byb2JlIGZvciBm
dXJ0aGVyIHNpbXBsaWZpY2F0aW9uPw0KVGhhbmtzLA0KQ29ub3IuDQoNCj4gICAgICAgICAgfQ0K
PiANCj4gICAgICAgICAgcmV0ID0gZGV2bV9yZXF1ZXN0X2lycSgmcGRldi0+ZGV2LCBzcGktPmly
cSwgbWNocF9jb3Jlc3BpX2ludGVycnVwdCwNCj4gICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICBJUlFGX1NIQVJFRCwgZGV2X25hbWUoJnBkZXYtPmRldiksIG1hc3Rlcik7DQo+ICAgICAg
ICAgIGlmIChyZXQpIHsNCj4gICAgICAgICAgICAgICAgICBkZXZfZXJyKCZwZGV2LT5kZXYsICJj
b3VsZCBub3QgcmVxdWVzdCBpcnE6ICVkXG4iLCByZXQpOw0KPiAtICAgICAgICAgICAgICAgZ290
byBlcnJvcl9yZWxlYXNlX21hc3RlcjsNCj4gKyAgICAgICAgICAgICAgIHJldHVybiByZXQ7DQo+
ICAgICAgICAgIH0NCj4gDQo+ICAgICAgICAgIHNwaS0+Y2xrID0gZGV2bV9jbGtfZ2V0KCZwZGV2
LT5kZXYsIE5VTEwpOw0KPiAgICAgICAgICBpZiAoSVNfRVJSKHNwaS0+Y2xrKSkgew0KPiAtICAg
ICAgICAgICAgICAgcmV0ID0gUFRSX0VSUihzcGktPmNsayk7DQo+ICAgICAgICAgICAgICAgICAg
ZGV2X2VycigmcGRldi0+ZGV2LCAiY291bGQgbm90IGdldCBjbGs6ICVkXG4iLCByZXQpOw0KPiAt
ICAgICAgICAgICAgICAgZ290byBlcnJvcl9yZWxlYXNlX21hc3RlcjsNCj4gKyAgICAgICAgICAg
ICAgIHJldHVybiBQVFJfRVJSKHNwaS0+Y2xrKTsNCj4gICAgICAgICAgfQ0KPiANCj4gICAgICAg
ICAgcmV0ID0gY2xrX3ByZXBhcmVfZW5hYmxlKHNwaS0+Y2xrKTsNCj4gICAgICAgICAgaWYgKHJl
dCkgew0KPiAgICAgICAgICAgICAgICAgIGRldl9lcnIoJnBkZXYtPmRldiwgImZhaWxlZCB0byBl
bmFibGUgY2xvY2tcbiIpOw0KPiAtICAgICAgICAgICAgICAgZ290byBlcnJvcl9yZWxlYXNlX21h
c3RlcjsNCj4gKyAgICAgICAgICAgICAgIHJldHVybiByZXQ7DQo+ICAgICAgICAgIH0NCj4gDQo+
ICAgICAgICAgIG1jaHBfY29yZXNwaV9pbml0KG1hc3Rlciwgc3BpKTsNCj4gQEAgLTU4Myw4ICs1
NzksNiBAQCBzdGF0aWMgaW50IG1jaHBfY29yZXNwaV9wcm9iZShzdHJ1Y3QgcGxhdGZvcm1fZGV2
aWNlICpwZGV2KQ0KPiAgIGVycm9yX3JlbGVhc2VfaGFyZHdhcmU6DQo+ICAgICAgICAgIG1jaHBf
Y29yZXNwaV9kaXNhYmxlKHNwaSk7DQo+ICAgICAgICAgIGNsa19kaXNhYmxlX3VucHJlcGFyZShz
cGktPmNsayk7DQo+IC1lcnJvcl9yZWxlYXNlX21hc3RlcjoNCj4gLSAgICAgICBzcGlfbWFzdGVy
X3B1dChtYXN0ZXIpOw0KPiANCj4gICAgICAgICAgcmV0dXJuIHJldDsNCj4gICB9DQo+IC0tDQo+
IDIuMjUuMQ0KPiANCg0K
