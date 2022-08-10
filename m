Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 742AE58E8AD
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Aug 2022 10:25:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231403AbiHJIZT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Aug 2022 04:25:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231732AbiHJIZK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Aug 2022 04:25:10 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E00A685F8A
        for <linux-kernel@vger.kernel.org>; Wed, 10 Aug 2022 01:25:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1660119908; x=1691655908;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=enKEeCmnBtnB4DpPADfdTznOpxGVUtmYAfJmaVsJ1JA=;
  b=CN21MGhTF1q35MPvU0xaMaJdzrl6mo77vbmhf939ya0Ev2Yqa2d/yge1
   IR/w06Q1NgzN5pS7hrCe5iZHqSdelHY7ScWEzie50EoHTj0jX3gMx92JC
   jT/G9sq3BpIXYPwuJVuhMBLTqXbt+I9hcirgA+p8R2vw7W82oDx9jT0pC
   dWdVxeuoGJzLKNBolKHwCVDf2zUY2t25sXSR5kJAfBMyXqsgXFJUS6TR8
   u1+Kpo6nhBt/zeTc7DL9pJy8Y8DvcDByKZMUM9g/FPuYhD5jhho5D/jci
   jiQByQOh0IkbLBu69fZN4lMuFsiIwg+JDQL+1Pt9ejsW0ousWxxZee3lL
   Q==;
X-IronPort-AV: E=Sophos;i="5.93,226,1654585200"; 
   d="scan'208";a="108378679"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 10 Aug 2022 01:25:07 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Wed, 10 Aug 2022 01:25:06 -0700
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28 via Frontend Transport; Wed, 10 Aug 2022 01:25:06 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P/8feKUbnUxwB3lDDrFCHHA1kXYujeCBj305qZ9AgpdhcGd1fKN0co/GQ+teLjp68Am0dVwWYR8sZZedV3J9/Iy9VjTZLTP//ZrHN4h+RfBc8u7985SJ8MphN6hKdrq8Fg391jMWzmqLIbtbKd6Jm51Pgj7Smc/SidjoLZ+AoqRXFr0xQZZSJxFTTJXCMJLN+YySmnAhfgB1gPAkRU5VhAYYCIA06i1qAFeN4naFiadDIrUb7quxwiFteujzd5MrVqOGA2CmiArpBoTct+yYXQZbQ7y4VJ8ebuQoMNl8T90VHwbAwxd6v390bIGeFb6Gl8mnOJDSY4cvCaMP4pqm7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=enKEeCmnBtnB4DpPADfdTznOpxGVUtmYAfJmaVsJ1JA=;
 b=MG/UCMSKTDlXptMK9j7kqR/mELaz0qJI4Scyi44KJpnt8Kq4oWSw/rWj9MBw8r+gSrHiBD3Y+VXL3yV29p3AtQ9TqFjnXG9LzPYoUF+QgemzhtSxP8DU7dzYAtgz4Bx0WHgE5e/Fi0JRnfEIyWBCv2rzRSbS2XkqUosVS3yucTPsjWHJclsQ37kvl2WU+2wLZAcKHJ+XTzWn8cedHqNBJmgWhUCkQr37xsHSYvgmf/Y5kGJZ2n54OQzeWOqpAx1byI1l/CjtS4SWJdO6WaRxlroUB15ZsZ5FBtPN2Uh0/3GddGDtlLT5oL0BkJPDshfF2JmNwppmmhmcSmgFzpmhOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=enKEeCmnBtnB4DpPADfdTznOpxGVUtmYAfJmaVsJ1JA=;
 b=t08Eq4WQZMsDTSGZfJL4OFidIS4wIwEtzZWonHSG/y/m8cJcsc24xXovyVPJrZm0PhWY+8Ec2vur4NzxJaVzDiT/vI8rLV6UrniPBsAsYYW9pDBnPx+ORJlLWWv1PZ3tILAStEDn4B0n7ms6EM+ZJPybmpd0ucK/3t+x8wnS53I=
Received: from DM4PR11MB6479.namprd11.prod.outlook.com (2603:10b6:8:8c::19) by
 DM6PR11MB4676.namprd11.prod.outlook.com (2603:10b6:5:2a7::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5525.10; Wed, 10 Aug 2022 08:25:02 +0000
Received: from DM4PR11MB6479.namprd11.prod.outlook.com
 ([fe80::1cf7:6d4b:5e26:3f56]) by DM4PR11MB6479.namprd11.prod.outlook.com
 ([fe80::1cf7:6d4b:5e26:3f56%8]) with mapi id 15.20.5504.020; Wed, 10 Aug 2022
 08:25:01 +0000
From:   <Tudor.Ambarus@microchip.com>
To:     <sudip.mukherjee@sifive.com>, <pratyush@kernel.org>,
        <michael@walle.cc>, <miquel.raynal@bootlin.com>, <richard@nod.at>,
        <vigneshr@ti.com>
CC:     <greentime.hu@sifive.com>, <jude.onyenegecha@sifive.com>,
        <william.salmon@sifive.com>, <adnan.chowdhury@sifive.com>,
        <ben.dooks@sifive.com>, <linux-mtd@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 2/3] mtd: spi-nor: add SFDP fixups for Quad Page
 Program
Thread-Topic: [PATCH v2 2/3] mtd: spi-nor: add SFDP fixups for Quad Page
 Program
Thread-Index: AQHYrJASR2XJCCWNYkmLP3pHpwj/WK2nzD6A
Date:   Wed, 10 Aug 2022 08:25:01 +0000
Message-ID: <498c33a8-014f-e542-f143-cba5760fafdd@microchip.com>
References: <20220809201428.118523-1-sudip.mukherjee@sifive.com>
 <20220809201428.118523-3-sudip.mukherjee@sifive.com>
 <361fa56d-617c-ee92-151e-5d8fe0a29e53@microchip.com>
In-Reply-To: <361fa56d-617c-ee92-151e-5d8fe0a29e53@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 18cb6606-8666-481a-1baa-08da7aa9d214
x-ms-traffictypediagnostic: DM6PR11MB4676:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: MfHB1Tz0FnupqAEaBWNgHnl9u4UFSMmmjLFNtoCqC2a9uoJjccRs8OhfIQRE33v0cwOn5UubgnC813At5quGbyHXeg3RULrDaX7jLjaN8bHFKaPKXDl37jsaO/NpEWyVAdtm6h/Y11jyRce0ScToYd+IHQlFGpHHe5zWvYpeLTTykTFQVgJJ9vjH1t9gshzMGZBesNn1llP1h7U0AcZCPfzdSFoWfroQv/JTXXo/OXZB5DbzNQ75qcOfg7ymJ5eG379/u/k9dgkoHQfvobOhdbrSg2zfqF7loWUhR4GTib74b6Aw1F/ggtEy+XJg9l78ZVJprIHGOO3yZzYVP9ch+iO6nkTjQi1NFhkm35BXlpMVAc9f/pPZC/ZCwfZRqZuGDphesE7m89oSkUBkwstKdaRu4KTuOhZL2odBRFpabXATxAYOetERH3Wwf5VbKZSW03PnXyNpcTDLU/m+yQRwiTschwN84+1aCuii+eFHtpKPk0WSpjRHbxj8Cfj5oPVkzuQa3WIbPdSSi+QXQW5MQRxik+WrgSiJqEVmrP9J6F5I52JGDqCQTVbjpNIc1qvzPri37ESJuqgnP7bt9HQdAsONNdf555UWRdWTASeONBpMReQ1yxl3LX7HOZ1f286bRveXYQfV+akR4mN6pd6qsobh7aPUKDZ8Iy499act5p7pT7pygWq16UinuPbqricL7DgxO7dCAQhHdT1oLnVMw6AzlDIhu2gg8S0YkJsFhe95rK2eZfyhTDcC/fIytwvpK+wBmJmqp6IScckfzVZLiAVme7yMzBxQsDDcVaE+rMral+k5FQZO65ZQq3BS0UokiCcn1XJHvUNHsF2PadZEP1nk8cl7BUDs/+/Gu1cUrQ8ZSpB0PtWz51JGPKIRTAFvIv8xU9MMYUG1RJ120UZNntV03vMUDUYEWDpzv+Ni/F8=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6479.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(346002)(136003)(396003)(366004)(39860400002)(376002)(36756003)(53546011)(122000001)(5660300002)(186003)(7416002)(2906002)(38100700002)(2616005)(6506007)(6512007)(8676002)(66556008)(316002)(66446008)(64756008)(966005)(66946007)(76116006)(31696002)(71200400001)(86362001)(54906003)(110136005)(4326008)(26005)(91956017)(8936002)(31686004)(38070700005)(41300700001)(478600001)(66476007)(6486002)(43740500002)(45980500001)(352734003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ejBWeGQ0cUtoaXVXaTd2VWh1TUNHN1dqRWcreUFNTnEydVRSdWxidTlPNVRF?=
 =?utf-8?B?V01DL09Od2o5THRtbFM3RHE4dkViNFkraXhSMDNzaGl0NHF3NUY1d3oxK0hR?=
 =?utf-8?B?MktuOThOaHBVOTNXWHVvWkg4VDhKQjZJNnhnaHZXM3d4VURaVEJtdkpiMGNn?=
 =?utf-8?B?T0YwcVJJbnpsbEt0ODY3YmtXeHZ3eURad3RoZStKT3JsbHpwdmF1VFRUa3Zx?=
 =?utf-8?B?R2hMMWhuZVJFQWgycFpwQkExZGxhNm5iU051Y3RyWk9wUHBjbDdPMzcrT2Mz?=
 =?utf-8?B?Tlp2WnYxQWZ3ZjZjNkJ0dG14S1dKUmowRGdsMDdGZkQwdFdueGs5bUdjVlpC?=
 =?utf-8?B?azB3YXZ5eG1vOXhZdm1TUzJoNkZROWh1WjN4RUJGZ1dCYWlYaDRPVmFiQndZ?=
 =?utf-8?B?MndlaFoyU2l1WkphcS93K080ajZxaEhibXBGbnYxWm5rNmZna3FvYjh4VG9m?=
 =?utf-8?B?SjNJSU54MjNTWkp6UmVyMWEyZ2V2TWI1M204a2o1cDNxU1J3YTRWZG9xdWc4?=
 =?utf-8?B?VzBSSG9nNlRieUw5YVVLUVVhVlNrbmhYMnlXRENMb2cvWWIxRGxZaUYrWG8r?=
 =?utf-8?B?WXA4ZzZ3S1FVTktGMDhudGQ4N3ZtekFHaUU3UzlXKzNlUVo2bmhnOGFGWm5h?=
 =?utf-8?B?WVBrK2xac05BVmdxVk1yNFF3R3BST2QwN1hWTXlQS1htVjVoWm92dmFlSkx2?=
 =?utf-8?B?b25KMG40RVhaYXVROWRCZnZBVnhBZEJDSUZaVXF5NlU3Y2NaWFBZcVNtK0Ft?=
 =?utf-8?B?UVIydHJ6SUFnRTVrWUVmVGMvQnc4YU5FNmE2MUJDSlBycXVibU92ZS92clp1?=
 =?utf-8?B?SGpsa2RaWTNTV0NrZklEeXNxYk90MUoweGRaRVJ2Tk5OMnBFUU1lV3BtQnVO?=
 =?utf-8?B?TmxpQU9lSUREdDFvcllOZCtzOUxrQzFZYkJPWFR1WUtaRFBzOTV1ZkJhT2w0?=
 =?utf-8?B?OTNEeEZOZm9Ua0E1ODlpblJyeXFJU2pQSGlsejBzdzBSYmNIdW90VmtlMDdI?=
 =?utf-8?B?ODBGS3UwcG5MM25XV29zNld1Wk5PVkNTa0xzakVLa0NoUnRhSUF1NWExcUsy?=
 =?utf-8?B?WVJBWDV4MVYrS1ZIR09aNzBQYUZtdG1YRnRqdlVQU20rSmlncytpeFMwVVZU?=
 =?utf-8?B?ellvNkhIKy95bGpoV0wvNFdoTlRuWXJNWnVuOGNaZTh2YWNIZTk3eHIzZ2ZO?=
 =?utf-8?B?a09zNFBqREFVbkNxMXlRZ3lSUzZxaHA1UXkwWFl1VkVyRmpmR0xhZ2FBZmJN?=
 =?utf-8?B?MFBTYkhuOEZGSXNWTW96a1BnZzRNOWVIS3lCU25JeEtnaGp2N1pGK1ltakZO?=
 =?utf-8?B?RGJ2UEpUR3VBYVpsZzJ1RWs0TUo4ZUhaZ1ZaZjBGbjl0b3RQby9nUElqK1ZG?=
 =?utf-8?B?di9EQnp5aFpvMlJFK2hMMExBaVVzNjIzUVQxbVRsTXdaTi9IQ0UrajB6Q0gw?=
 =?utf-8?B?Q3lHQTNwTUlianV1UUZSdjY3eUxxazBhbmZOVmNvR0N5MjdUOC9MSUZWUWsx?=
 =?utf-8?B?TUpZUE9ucVpNOVkwMlJtK2Z5L29CUnFVcXVnQmdPWFQ0UnRuRlRzZVNlWFNo?=
 =?utf-8?B?Vk1GOHNpbXhKaFU5TGhFU0dITUE5cjVySDFSTXhPdW9maFBLWUxqRjZHaEsy?=
 =?utf-8?B?SG5BTlB0YlNrWmFNMzNEMGt2R3ZKZnJlL0lVT01JblZLdGpldjUzWHlMVGdO?=
 =?utf-8?B?M0plZ2hYV2Z4UFE1REtwREFXVjBLbGUvNko4UXozRnYwVEVuOGJYMTlaWm5r?=
 =?utf-8?B?UDRNR1ZqSGlMelkwanVUK2hHN3JPN0hsa1NKSEVaQ2FPd2NIbGIwWnk3OHBk?=
 =?utf-8?B?VFRiT1BMRzJUaVZvQ0Y3YVpLeTVIWVVhNGpzaTNjYklsaWNWM0VzdWtWZmNp?=
 =?utf-8?B?TXhndDdlakdoRmdDK1lxWDlnRURKbm0zRHloNmQ2MEp3dTAvUktYYi9pamk3?=
 =?utf-8?B?U0tCakxVeHVmQm9hdWxWUnhjL1FyZmRCWmZPdTZUd3o1RTVtS1NBbmFzaHNP?=
 =?utf-8?B?Y2krYmwyQWNwQ1hhaWpjUXFTT2RZdmdpMGNtT0RuNUpVVFJyandFYWhySllM?=
 =?utf-8?B?d1p5enJJOENhYXByNnkvUFRUenlzb3RCektLOE9aSGFxZlhuaVRNQVVLYlFS?=
 =?utf-8?B?Yzd4R29SSDZDYWI2ckp5TGNLS2tLckVYMHFoSkpRRnlyQ2kxSE5zUDBhOWhP?=
 =?utf-8?B?TkE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <7FAE8904AA9E564B822E388538B064D4@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6479.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 18cb6606-8666-481a-1baa-08da7aa9d214
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Aug 2022 08:25:01.8785
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Tpp4cLNkEIPg/p6qLy0HXAJmlG2y02SVHHhkmNF0ogE7/dsIUQ2uIf0WUyivgehnEwr35KFZD4WakRCZpHnO/PVa9eCh9SMHKXSexyPpbwE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4676
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gOC8xMC8yMiAxMTowNiwgVHVkb3IuQW1iYXJ1c0BtaWNyb2NoaXAuY29tIHdyb3RlOg0KPiBF
WFRFUk5BTCBFTUFJTDogRG8gbm90IGNsaWNrIGxpbmtzIG9yIG9wZW4gYXR0YWNobWVudHMgdW5s
ZXNzIHlvdSBrbm93IHRoZSBjb250ZW50IGlzIHNhZmUNCj4gDQo+IE9uIDgvOS8yMiAyMzoxNCwg
U3VkaXAgTXVraGVyamVlIHdyb3RlOg0KPj4gRVhURVJOQUwgRU1BSUw6IERvIG5vdCBjbGljayBs
aW5rcyBvciBvcGVuIGF0dGFjaG1lbnRzIHVubGVzcyB5b3Uga25vdyB0aGUgY29udGVudCBpcyBz
YWZlDQo+Pg0KPj4gU0ZEUCB0YWJsZSBvZiBzb21lIGZsYXNoIGNoaXBzIGRvIG5vdCBhZHZlcnRp
c2Ugc3VwcG9ydCBvZiBRdWFkIElucHV0DQo+PiBQYWdlIFByb2dyYW0gZXZlbiB0aG91Z2ggaXQg
aGFzIHN1cHBvcnQuIFVzZSBmaXh1cCBmbGFncyBhbmQgYWRkIGhhcmR3YXJlDQo+PiBjYXAgZm9y
IHRoZXNlIGNoaXBzLg0KPj4NCj4+IFNpZ25lZC1vZmYtYnk6IFN1ZGlwIE11a2hlcmplZSA8c3Vk
aXAubXVraGVyamVlQHNpZml2ZS5jb20+DQo+PiAtLS0NCj4+ICBkcml2ZXJzL210ZC9zcGktbm9y
L2NvcmUuYyB8IDkgKysrKysrKysrDQo+PiAgZHJpdmVycy9tdGQvc3BpLW5vci9jb3JlLmggfCAy
ICsrDQo+PiAgMiBmaWxlcyBjaGFuZ2VkLCAxMSBpbnNlcnRpb25zKCspDQo+Pg0KPj4gZGlmZiAt
LWdpdCBhL2RyaXZlcnMvbXRkL3NwaS1ub3IvY29yZS5jIGIvZHJpdmVycy9tdGQvc3BpLW5vci9j
b3JlLmMNCj4+IGluZGV4IGYyYzY0MDA2ZjhkNy4uNzU0MjQwNDMzMmE1IDEwMDY0NA0KPj4gLS0t
IGEvZHJpdmVycy9tdGQvc3BpLW5vci9jb3JlLmMNCj4+ICsrKyBiL2RyaXZlcnMvbXRkL3NwaS1u
b3IvY29yZS5jDQo+PiBAQCAtMTk2Miw2ICsxOTYyLDEyIEBAIHNwaV9ub3Jfc3BpbWVtX2FkanVz
dF9od2NhcHMoc3RydWN0IHNwaV9ub3IgKm5vciwgdTMyICpod2NhcHMpDQo+PiAgICAgICAgIGlm
IChub3ItPmZsYWdzICYgU05PUl9GX0JST0tFTl9SRVNFVCkNCj4+ICAgICAgICAgICAgICAgICAq
aHdjYXBzICY9IH4oU05PUl9IV0NBUFNfWF9YX1ggfCBTTk9SX0hXQ0FQU19YX1hfWF9EVFIpOw0K
Pj4NCj4+ICsgICAgICAgaWYgKG5vci0+ZmxhZ3MgJiBTTk9SX0ZfSEFTX1FVQURfUFApIHsNCj4+
ICsgICAgICAgICAgICAgICAqaHdjYXBzIHw9IFNOT1JfSFdDQVBTX1BQXzFfMV80Ow0KPj4gKyAg
ICAgICAgICAgICAgIHNwaV9ub3Jfc2V0X3BwX3NldHRpbmdzKCZwYXJhbXMtPnBhZ2VfcHJvZ3Jh
bXNbU05PUl9DTURfUFBfMV8xXzRdLA0KPj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgIFNQSU5PUl9PUF9QUF8xXzFfNCwgU05PUl9QUk9UT18xXzFfNCk7DQo+PiArICAg
ICAgIH0NCj4gDQo+IHNldHRpbmcgU1BJTk9SX09QX1BQXzFfMV80IHNob3VsZCBiZSBkb25lIGlu
IHNwaV9ub3JfbGF0ZV9pbml0X3BhcmFtcygpLg0KPiBzcGlfbm9yX2xhdGVfaW5pdF9wYXJhbXMo
KSBpcyB1c2VkIHRvIGFkanVzdCB0aGUgb3BzIHN1cHBvcnRlZCBieSB0aGUgZmxhc2gNCg0KXiBz
L3NwaV9ub3JfbGF0ZV9pbml0X3BhcmFtcy9zcGlfbm9yX3NwaW1lbV9hZGp1c3RfaHdjYXBzDQoN
Cj4gd2l0aCB0aGUgb25lcyBzdXBwb3J0ZWQgYnkgdGhlIGNvbnRyb2xsZXIuDQo+IA0KPj4gKw0K
Pj4gICAgICAgICBmb3IgKGNhcCA9IDA7IGNhcCA8IHNpemVvZigqaHdjYXBzKSAqIEJJVFNfUEVS
X0JZVEU7IGNhcCsrKSB7DQo+PiAgICAgICAgICAgICAgICAgaW50IHJkaWR4LCBwcGlkeDsNCj4+
DQo+PiBAQCAtMjQ0Niw2ICsyNDUyLDkgQEAgc3RhdGljIHZvaWQgc3BpX25vcl9pbml0X2ZpeHVw
X2ZsYWdzKHN0cnVjdCBzcGlfbm9yICpub3IpDQo+Pg0KPj4gICAgICAgICBpZiAoZml4dXBfZmxh
Z3MgJiBTUElfTk9SX0lPX01PREVfRU5fVk9MQVRJTEUpDQo+PiAgICAgICAgICAgICAgICAgbm9y
LT5mbGFncyB8PSBTTk9SX0ZfSU9fTU9ERV9FTl9WT0xBVElMRTsNCj4+ICsNCj4+ICsgICAgICAg
aWYgKGZpeHVwX2ZsYWdzICYgU1BJX05PUl9RVUFEX1BQKQ0KPj4gKyAgICAgICAgICAgICAgIG5v
ci0+ZmxhZ3MgfD0gU05PUl9GX0hBU19RVUFEX1BQOw0KPj4gIH0NCj4+DQo+PiAgLyoqDQo+PiBk
aWZmIC0tZ2l0IGEvZHJpdmVycy9tdGQvc3BpLW5vci9jb3JlLmggYi9kcml2ZXJzL210ZC9zcGkt
bm9yL2NvcmUuaA0KPj4gaW5kZXggODViMGNmMjU0ZTk3Li43ZGJkZjE2YTY3YjQgMTAwNjQ0DQo+
PiAtLS0gYS9kcml2ZXJzL210ZC9zcGktbm9yL2NvcmUuaA0KPj4gKysrIGIvZHJpdmVycy9tdGQv
c3BpLW5vci9jb3JlLmgNCj4+IEBAIC0xMzAsNiArMTMwLDcgQEAgZW51bSBzcGlfbm9yX29wdGlv
bl9mbGFncyB7DQo+PiAgICAgICAgIFNOT1JfRl9JT19NT0RFX0VOX1ZPTEFUSUxFID0gQklUKDEx
KSwNCj4+ICAgICAgICAgU05PUl9GX1NPRlRfUkVTRVQgICAgICAgPSBCSVQoMTIpLA0KPj4gICAg
ICAgICBTTk9SX0ZfU1dQX0lTX1ZPTEFUSUxFICA9IEJJVCgxMyksDQo+PiArICAgICAgIFNOT1Jf
Rl9IQVNfUVVBRF9QUCAgICAgID0gQklUKDE0KSwNCj4gDQo+IHlvdSB3b24ndCBuZWVkIHRoaXMN
Cj4+ICB9Ow0KPj4NCj4+ICBzdHJ1Y3Qgc3BpX25vcl9yZWFkX2NvbW1hbmQgew0KPj4gQEAgLTUy
MCw2ICs1MjEsNyBAQCBzdHJ1Y3QgZmxhc2hfaW5mbyB7DQo+PiAgICAgICAgIHU4IGZpeHVwX2Zs
YWdzOw0KPj4gICNkZWZpbmUgU1BJX05PUl80Ql9PUENPREVTICAgICAgICAgICAgIEJJVCgwKQ0K
Pj4gICNkZWZpbmUgU1BJX05PUl9JT19NT0RFX0VOX1ZPTEFUSUxFICAgIEJJVCgxKQ0KPj4gKyNk
ZWZpbmUgU1BJX05PUl9RVUFEX1BQICAgICAgICAgICAgICAgICAgICAgICAgQklUKDIpDQo+IA0K
PiBObywgYXMgSSBwcmV2aW91c2x5IHNhaWQsIFNQSV9OT1JfUVVBRF9QUCBzaG91bGQgYmUgZGVj
bGFyZWQgYXMgYQ0KPiBpbmZvLT5mbGFncywgbm90IGFzIGluZm8tPmZpeHVwX2ZsYWdzLg0KPiAN
Cj4+DQo+PiAgICAgICAgIHU4IG1mcl9mbGFnczsNCj4+DQo+PiAtLQ0KPj4gMi4zMC4yDQo+Pg0K
PiANCj4gDQo+IC0tDQo+IENoZWVycywNCj4gdGENCj4gX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fDQo+IExpbnV4IE1URCBkaXNjdXNzaW9uIG1h
aWxpbmcgbGlzdA0KPiBodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZv
L2xpbnV4LW10ZC8NCg0KDQotLSANCkNoZWVycywNCnRhDQo=
