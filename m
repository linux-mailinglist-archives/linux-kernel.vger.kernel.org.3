Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF95258377F
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jul 2022 05:24:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237914AbiG1DYt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jul 2022 23:24:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230233AbiG1DYq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jul 2022 23:24:46 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBD6852442
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jul 2022 20:24:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1658978686; x=1690514686;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=dJfddUInH/6CnXag8t+WDA2YaQjsEHLZJJUCm+oVRHE=;
  b=XYEtnoptxi2+676HolGpRq9GtWrcQR039xtRTaQxJE3J3o5yAymrdv84
   6FxkdDW5BDui85okpDirvYflh/vBJaRmjw4SAmQBXPTQtShJsDO8eevbv
   J3UiLHeOoSJ9PkE6P14tEfg1Jy6AuBKz58qfkkP5qhSxUqOshJjXchVL0
   NMbsnrWN/r5DsjSrCOk7oXBhu4ZZ5NvLcUhV+N0sG0VkAXxyatuFsisbk
   vv5obRBbXDh6O7SCFSg4MEIEx1hFNEWIrQdTTCuMsVAgvkQm+q44rN9ra
   eJlhZ3/iLBVr++tK5cI+gZnEAsuuKWANVin2DRd+8Iugtpq2992U58NMy
   A==;
X-IronPort-AV: E=Sophos;i="5.93,196,1654585200"; 
   d="scan'208";a="173924716"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 27 Jul 2022 20:24:45 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Wed, 27 Jul 2022 20:24:44 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17 via Frontend
 Transport; Wed, 27 Jul 2022 20:24:44 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bVtQjyJiOKzOY4qTbf2S9FzEUljx7PxRWoxeY59AznXg1XQbVQoN6i0PFo4BamlFd9qViTAIhf2ZknFXfEYRNDgztRBPIi63RE5Mp7qnKcPfogcgkqBfZlnWec2VY8YJFaOk7MOpdDBHXC1cCQS7gx/Dy5VylAEiZlH7+Zfe8knvGz6m12O6Yh4iZ5oPjdUx8zOYxLNHRwpgLvU1A73Zu3vfO3a8+8txlwlrYfO3JOn+rfno7gRqnGDBsvTkd14Y/LCURScDaRLqI9/hwzDsZfyTdNjdX4DqbL8A9ym7y/yOmIm6Co5Ub8aRIuTiBqz1qEwIzjPtU0Vh27dEODyHMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dJfddUInH/6CnXag8t+WDA2YaQjsEHLZJJUCm+oVRHE=;
 b=Mto2eBF0mjtrXkhLPXZwyWMhHvzyRzK9DQglzzgFgcLhpv4hZuzVFNhynIqy/lB78a/RLTfpMEGxrXfWVKrSsVqnECuesU4KQ9pFRlwfHstg+yP3+L1MBcow03aZ5Gc16PVM5hsvwEZszLjln4EFr5tg3lDTvfGqpU20u3IbU7yO4RSk9FPFfGhxCGtGLx+ZiTKD1WD4ECYs70jsYG5CHpGqKwi/oL5pzQsWADbV0bx6pUt2O0wztl0UgMP13W8Y3YiaBSkQE31GNPMwD9C0BsEj2sgYmMlqfAhYLVyDAiYkyhTQrp8tOr2N/o7rqA6WYAGpapc6fb9iBGcMv3Lr8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dJfddUInH/6CnXag8t+WDA2YaQjsEHLZJJUCm+oVRHE=;
 b=DS/Lw3oiiaDP/qWZdMywM1H0CresPHcAwnwMkUpIs8/U2/U2z+BnsX7t0BzfXofICcY4mwBGrx4HZAfqxgVznYRRxOn6RUiYtxs9YDdBU60XtiwKhIMBhnNiHpN4uFUgOI5CMpqUQrHwO02lqF4wx6by3UsKHTspxPfDjhVaSl8=
Received: from DM4PR11MB6479.namprd11.prod.outlook.com (2603:10b6:8:8c::19) by
 PH0PR11MB5176.namprd11.prod.outlook.com (2603:10b6:510:3f::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5458.19; Thu, 28 Jul 2022 03:24:36 +0000
Received: from DM4PR11MB6479.namprd11.prod.outlook.com
 ([fe80::7549:c58c:5e93:7c35]) by DM4PR11MB6479.namprd11.prod.outlook.com
 ([fe80::7549:c58c:5e93:7c35%5]) with mapi id 15.20.5458.023; Thu, 28 Jul 2022
 03:24:36 +0000
From:   <Tudor.Ambarus@microchip.com>
To:     <michael@walle.cc>, <p.yadav@ti.com>, <miquel.raynal@bootlin.com>,
        <richard@nod.at>, <vigneshr@ti.com>, <quic_c_sbhanu@quicinc.com>
CC:     <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/2] mtd: spi-nor: introduce SNOR_ID3()
Thread-Topic: [PATCH 1/2] mtd: spi-nor: introduce SNOR_ID3()
Thread-Index: AQHYmzRwuAFPdIe45ECo1RhI0CKwA62TLLWA
Date:   Thu, 28 Jul 2022 03:24:36 +0000
Message-ID: <41e6b74d-6973-60da-1556-82a1e879ffd4@microchip.com>
References: <20220510140232.3519184-1-michael@walle.cc>
 <20220510140232.3519184-2-michael@walle.cc>
 <160ddac1-6d0a-c922-1380-09e7823a285e@microchip.com>
In-Reply-To: <160ddac1-6d0a-c922-1380-09e7823a285e@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: cc4a9a2c-6617-4bcf-7492-08da7048b2cf
x-ms-traffictypediagnostic: PH0PR11MB5176:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: woBgKgHhBo6lnJFuj8jJ9SuSDfI2T8bLRxqEKiXQGqyZjlN6gBT5UPUGMs3lxj8r1KGQfBOgmIBj1chX6iF7pVTpxD6XVAg0Yc3o753A6twjftRxWt2fKWQOfXho3qswA/ro5X6Oj3eIYPqIIpLff3wM8r86S9klbIuQeXZEEAmF60+LCE7rXQD9bt/Q9zisHt2d/8geoRTpbvp8V76X43eWnAJTCII6n8J3hOiSwPFzK2iExNjW1yQxqyQHaWuEnsKy9vWx80n59VOanV0aTbvzA9lxK6SmU50ynAr2FNtBVOha5PXMxLX/7MBqcATplruGaJpaSqGNqDrH8nhuuWgwM+CX0dT4bnraw08OMEXYgUz9O0N4SJiJVihZPDVuXc6DHci/cU0Z/KvpUtkTUBmAZ7K34GGqu2jlE4tWo4b9/CCVi0bbtWiKtue0y+XnNTtYprRhCrT78uvL6eF0U0PXcs8I+lATU4l/Iw/RncijnNTbn05Dcm07wY4dsp3RqpWowdd6eIOfQApDVIMkmPTe74BtG5ZwQNJoSaZiY0j/fE+LbOE/6e8X+4FboyT8XwjKGJmcIg3QqA6YHK+aW1jrsHU51z1i2K7ttHAgensblsaLIkppg1tHOhkFervHgQAbl+3LqL6ckd6m6IHrh60W0lNV4RkXltuCJf5gpmWo4PIduRpcWds5JavzQ+Wq/2fhLgBLKqYol7R+JQw9Nm/D2i66TsNeqEPBjW5TU69BXRd0MMu7swKynG0e3qgj5kjrjRUQryeLTdzlsYqLTagnNUHxTh8fH4mVVJUaiXqVuaPMx0Rso+wKyshMo22N5jzJPlzrf1Zqh7Ct3QrOQEmS2mAD0PoCzn9bvQMDd8kOuAVLUTZ+CNPcEqMrmTQFSfRfAbw+IjgzDpVHyHHa3Q==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6479.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(366004)(376002)(39860400002)(346002)(396003)(136003)(86362001)(6506007)(478600001)(6512007)(41300700001)(71200400001)(53546011)(26005)(31696002)(54906003)(316002)(83380400001)(110136005)(31686004)(186003)(66446008)(91956017)(38070700005)(66556008)(2616005)(966005)(66476007)(8676002)(4326008)(76116006)(6486002)(64756008)(66946007)(38100700002)(8936002)(5660300002)(2906002)(36756003)(122000001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?M0pkNWExaUhlNDZKU0R6QTdyNEZjd3NwVWxyc3F4c3JXbmw3VVlsdGEreTEv?=
 =?utf-8?B?cXVCc0cvKzVvRk5FOHM2RjZpaTA2bUVWdjM1dmp6RFJKN1RUUGVjWHRuQ0dF?=
 =?utf-8?B?VlVzZEtYdVB5a1NqcllScGxMRGNKcHBjQkFFSTBpejZpTTRNSG0rbjlZaFZC?=
 =?utf-8?B?TThDbHVNWG1zbVM1SlVjUEI5SklkeWVKQm1KYm96SUdQYVl5RkJiT3BQdXov?=
 =?utf-8?B?Qnc1d05OelE4ZmRBcE1oNFpQYlhSTGFzaTFzWHE2K1hPUEhwSFp2S2l4bDR0?=
 =?utf-8?B?Vlc1dTdST2xybEsxUENFRW5ZUmZobVIweTQrSzVyOUk5eWt6R3B5dG1FVmdm?=
 =?utf-8?B?ZFZOUWZTeS92ZnU3a2oremZaWEQzYmJyS1lKaGMzeGdINllmZVl5RUxkZTFR?=
 =?utf-8?B?dS9MOWFOcHFka2NHalJOMjFNVWdqbUVFbnVwenVxSUI3a0pwVlZISlFiTVg1?=
 =?utf-8?B?N0FHT094RmVubU54T0ZXRkJNTVpOMUZmbmNtcWVvS29ybllYTmNxMmN6cVhW?=
 =?utf-8?B?RmxYRk94OS8raG9NVDZLSEY5dFRpOURjdThuN2RFN2hYWlA4UE1QYVhjells?=
 =?utf-8?B?Z3d0L2tPSWM5Mit0TFVPdHRjNS9IYXVUb2xiZTZqSk9LTGlIMWhLN3RNR1Js?=
 =?utf-8?B?azdpZVBFMm8vL0FJRUwyRmhVU2NFeUhzT3dCVmdDMktyQ1ZjT290UEtIRWh3?=
 =?utf-8?B?TzZIeGs5VHB6TU84WGZpazhmRHZERlNIaE1teUJNZjRML1FaSEwzWkR6NGd1?=
 =?utf-8?B?NXdNNlNmLy9lSVVCSmpnOGZMbkYvVGllaVVDajl2TDF1VUJ2L1dRckpIQm8x?=
 =?utf-8?B?bVNSbFNocHBrakxON2hvS0dwcFM2UkNDb3JPRDl3NXgveHkrQjBwQWlYVmg4?=
 =?utf-8?B?d0dCY2hNcktJYzJvUXE1MXVWQ2ZEaWV3YzJuMmF3OGFYUElLVjIxV3piMzJh?=
 =?utf-8?B?N2s0d1UrUDlaRUJJY1ZENVJlVjJHeE9VQlYvdzlqeDZsTFdRUGRwYlJKZXhR?=
 =?utf-8?B?NGp4WkJENkJDN21qbi81STdxaVZRMUxFUlZlMVR2SEI2QkhYTVJlZkhZaDI5?=
 =?utf-8?B?S1dBbWdWaFZTR3ErVDl1THA1dkZmUzBsWmhEbmRhZHlWVUVwRFhWY01CTkk3?=
 =?utf-8?B?L1BuZWY5b01lZjhlUSt1dTVGa3kwYWxML096c3FkaXd0WE5SaUpKaFFlWEVs?=
 =?utf-8?B?YlAvTEZ1cTdWNVp6ZTh3emVDY2UwYk91WFhLNXlGaVAyWWMwck9ZOTZ6YmRn?=
 =?utf-8?B?UGQ1V1NGM2lVTWVhVjVFb0lwQkVRNzBpYkV1UjRybE9jUDBxbE5WMzBVcDE5?=
 =?utf-8?B?YUVoKzVUbDF0VURRQk9oM1VIVDg5U0hGaXZyMnJPby9sSG12RkpTYzgrQmNz?=
 =?utf-8?B?dWFpb2dsR2haRVYvaEsvamJrUUtrM21ldVRCc0NVaWJTWnEzblRQZkRlbU55?=
 =?utf-8?B?TGtSbEp6eVVscDVDMXhOTUFWYUVFbzFLR0wwMFRIM0R4bmdVTkNZRUhJdGxm?=
 =?utf-8?B?RExrWitkYXd0N05DUFJjRDRkYTM4WW5QZjhiTUMxdmtFdHpBNW8xdERKSDJ2?=
 =?utf-8?B?MXBzMFVjNkQ1WWYrNDc0YnI2dFZWaGNtY0dUSHh3WFVPVGZmNUNnUEFmaVBF?=
 =?utf-8?B?UmF3Q2VjZTN1THE3OVg1RXZzRWx2SXovMHpDZGlwdk9iclBMRlE1SHZ2S3J2?=
 =?utf-8?B?T0tvbXE5NUF5ZXY2RWRHaW9DN2I0eXl1NEd4K1NRUXZsWkxNeWNKREREZE1W?=
 =?utf-8?B?TUMvR2o2enVyZmJ3N3JyTkhZbjhkaDdMQkp5YzBYMzJUWjk1Um9sVHBBVmxa?=
 =?utf-8?B?Skd5QnhCb0krREMzS0RQWlpOQk9Xc2lkWE1TVnBUckpDb3hmUjF3aDlWZERM?=
 =?utf-8?B?ek9tK3dua3dzQ2E2emxielRBa3Y2N2JYUW12eEpIemhBb2drZEcvMWRqdzVo?=
 =?utf-8?B?YmhyZDN5VFlPVW1lR2habS83U0Fia2lEWVg0MCtXWFpZM2VmazM0akcrZkw0?=
 =?utf-8?B?TTVBUkVHejBFTWpnVXY1ZEFPMWk4VytVaVA1TVBuUksrenRtSXg5YlF1dkk0?=
 =?utf-8?B?ZGM5aWJzcE81S01WR0ZWVDVpQ04vMCtSWUxTMHlYZm1yRThRYmdpSXFYY2dt?=
 =?utf-8?Q?Tgppycep782UXvr2Nf7ES20PR?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <EFEBF9EB9C66AD4C8F6604D4B1D16E9F@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6479.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cc4a9a2c-6617-4bcf-7492-08da7048b2cf
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jul 2022 03:24:36.5774
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dE/mq2zt9oYyy28JPtRTi/IOJkUsOqKyddUgLv42dnxwIJ4SRVgKyn5IP3tndRtX187yR7nipcOnF2Dv3Pv9Tn36XIiX6aG8cD6WqQSqmrY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5176
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gNy8xOS8yMiAwODo1NywgVHVkb3IuQW1iYXJ1c0BtaWNyb2NoaXAuY29tIHdyb3RlOg0KPiBF
WFRFUk5BTCBFTUFJTDogRG8gbm90IGNsaWNrIGxpbmtzIG9yIG9wZW4gYXR0YWNobWVudHMgdW5s
ZXNzIHlvdSBrbm93IHRoZSBjb250ZW50IGlzIHNhZmUNCj4gDQo+IE9uIDUvMTAvMjIgMTc6MDIs
IE1pY2hhZWwgV2FsbGUgd3JvdGU6DQo+IA0KPiBIaSENCj4gDQo+PiBFWFRFUk5BTCBFTUFJTDog
RG8gbm90IGNsaWNrIGxpbmtzIG9yIG9wZW4gYXR0YWNobWVudHMgdW5sZXNzIHlvdSBrbm93IHRo
ZSBjb250ZW50IGlzIHNhZmUNCj4+DQo+PiBVcCB1bnRpbCBub3csIGZsYXNoZXMgd2VyZSBkZWZp
bmVkIGJ5IHNwZWNpZnlpbmcgdGhlIEpFREVDIElELCB0aGUNCj4+IHNlY3RvciBzaXplIGFuZCB0
aGUgbnVtYmVyIG9mIHNlY3RvcnMuIFRoaXMgY2FuIGJlIHJlYWQgYnkgcGFyc2luZyB0aGUNCj4+
IFNGRFAsIHdlIGRvbid0IGhhdmUgdG8gc3BlY2lmeSBpdC4gVGh1cyBwcm92aWRlIGEgbmV3IG1h
Y3JvIFNOT1JfSUQzKCkNCj4+IHdoaWNoIGp1c3QgdGFrZXMgdGhlIEpFREVDIElEIGFuZCBpbXBs
aWNpdGx5IHNldCAucGFyc2Vfc2ZkcCA9IHRydWUuIEFsbA0KPj4gbmV3IGZsYXNoZXMgd2hpY2gg
aGF2ZSBTRkRQIHNob3VsZCB1c2UgdGhpcyBtYWNyby4NCj4gDQo+IEkgbGlrZSB0aGUgaWRlYSwg
YnV0IHlvdSBuZWVkIHRvIHJlZmluZSBpdCBhIGJpdC4NCj4gWW91ciBhc3N1bXB0aW9ucyBhcmUg
dHJ1ZSBvbmx5IGZvciBmbGFzaGVzIHRoYXQgYXJlIGNvbXBsaWFudCB3aXRoIFNGRFAgcmV2QiBv
cg0KPiBsYXRlciBiZWNhdXNlIHBhcmFtcy0+cGFnZV9zaXplIGlzIGluaXRpYWxpemVkIGJ5IHF1
ZXJ5aW5nIEJGUFQgRFdPUkQgMTEuIEkgdGhpbmsNCj4gaXQgd291bGQgYmUgZ29vZCB0byBzcGVj
aWZ5IHRoaXMgaW4gdGhlIGNvbW1lbnQgc2VjdGlvbi4gQWxzbywgSSB0aGluayB5b3UgaW50cm9k
dWNlDQo+IGEgYnVnIGluIHNwaV9ub3Jfc2VsZWN0X2VyYXNlKCkgd2hlbiBDT05GSUdfTVREX1NQ
SV9OT1JfVVNFXzRLX1NFQ1RPUlMgaXMgbm90DQo+IHNlbGVjdGVkLiB3YW50ZWRfc2l6ZSB3aWxs
IGJlIHplcm8sIHdpbGwgeW91IHNlbGVjdCBhbiBpbnZhbGlkIGVyYXNlIHR5cGU/DQo+IFdvdWxk
IHlvdSBwbGVhc2UgcmVzdWJtaXQ/DQo+IA0KPiBUaGFua3MsDQo+IHRhDQo+IA0KPj4NCj4+IFNp
Z25lZC1vZmYtYnk6IE1pY2hhZWwgV2FsbGUgPG1pY2hhZWxAd2FsbGUuY2M+DQo+PiAtLS0NCj4+
ICBkcml2ZXJzL210ZC9zcGktbm9yL2NvcmUuYyB8IDcgKysrKystLQ0KPj4gIGRyaXZlcnMvbXRk
L3NwaS1ub3IvY29yZS5oIHwgOSArKysrKysrKysNCj4+ICAyIGZpbGVzIGNoYW5nZWQsIDE0IGlu
c2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0pDQo+Pg0KPj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMv
bXRkL3NwaS1ub3IvY29yZS5jIGIvZHJpdmVycy9tdGQvc3BpLW5vci9jb3JlLmMNCj4+IGluZGV4
IDQwMmIzN2NkYmNlYS4uMjkzMjllZDBhOTM0IDEwMDY0NA0KPj4gLS0tIGEvZHJpdmVycy9tdGQv
c3BpLW5vci9jb3JlLmMNCj4+ICsrKyBiL2RyaXZlcnMvbXRkL3NwaS1ub3IvY29yZS5jDQo+PiBA
QCAtMjEwNCw4ICsyMTA0LDExIEBAIHN0YXRpYyBpbnQgc3BpX25vcl9zZWxlY3RfcHAoc3RydWN0
IHNwaV9ub3IgKm5vciwNCj4+ICAgKiBzcGlfbm9yX3NlbGVjdF91bmlmb3JtX2VyYXNlKCkgLSBz
ZWxlY3Qgb3B0aW11bSB1bmlmb3JtIGVyYXNlIHR5cGUNCj4+ICAgKiBAbWFwOiAgICAgICAgICAg
ICAgIHRoZSBlcmFzZSBtYXAgb2YgdGhlIFNQSSBOT1INCj4+ICAgKiBAd2FudGVkX3NpemU6ICAg
ICAgIHRoZSBlcmFzZSB0eXBlIHNpemUgdG8gc2VhcmNoIGZvci4gQ29udGFpbnMgdGhlIHZhbHVl
IG9mDQo+PiAtICogICAgICAgICAgICAgICAgICAgICBpbmZvLT5zZWN0b3Jfc2l6ZSBvciBvZiB0
aGUgInNtYWxsIHNlY3RvciIgc2l6ZSBpbiBjYXNlDQo+PiAtICogICAgICAgICAgICAgICAgICAg
ICBDT05GSUdfTVREX1NQSV9OT1JfVVNFXzRLX1NFQ1RPUlMgaXMgZGVmaW5lZC4NCj4+ICsgKiAg
ICAgICAgICAgICAgICAgICAgIGluZm8tPnNlY3Rvcl9zaXplLCB0aGUgInNtYWxsIHNlY3RvciIg
c2l6ZSBpbiBjYXNlDQo+PiArICogICAgICAgICAgICAgICAgICAgICBDT05GSUdfTVREX1NQSV9O
T1JfVVNFXzRLX1NFQ1RPUlMgaXMgZGVmaW5lZCBvciAwIGlmDQo+PiArICogICAgICAgICAgICAg
ICAgICAgICB0aGVyZSBpcyBubyBpbmZvcm1hdGlvbiBhYm91dCB0aGUgc2VjdG9yIHNpemUuIFRo
ZQ0KPj4gKyAqICAgICAgICAgICAgICAgICAgICAgbGF0dGVyIGlzIHRoZSBjYXNlIGlmIHRoZSBm
bGFzaCBwYXJhbWV0ZXJzIGFyZSBwYXJzZWQNCj4+ICsgKiAgICAgICAgICAgICAgICAgICAgIHNv
bGVseSBieSBTRkRQLg0KPj4gICAqDQo+PiAgICogT25jZSB0aGUgb3B0aW11bSB1bmlmb3JtIHNl
Y3RvciBlcmFzZSBjb21tYW5kIGlzIGZvdW5kLCBkaXNhYmxlIGFsbCB0aGUNCj4+ICAgKiBvdGhl
ci4NCj4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL210ZC9zcGktbm9yL2NvcmUuaCBiL2RyaXZlcnMv
bXRkL3NwaS1ub3IvY29yZS5oDQo+PiBpbmRleCA2MTg4Njg2OGNkMDIuLmZhYjMwMzhjNGY0YSAx
MDA2NDQNCj4+IC0tLSBhL2RyaXZlcnMvbXRkL3NwaS1ub3IvY29yZS5oDQo+PiArKysgYi9kcml2
ZXJzL210ZC9zcGktbm9yL2NvcmUuaA0KPj4gQEAgLTU2Myw2ICs1NjMsMTUgQEAgc3RydWN0IGZs
YXNoX2luZm8gew0KPj4gICAgICAgICAgICAgICAgICAgICAgICAgLm5fcmVnaW9ucyA9IChfbl9y
ZWdpb25zKSwgICAgICAgICAgICAgICAgICAgICAgXA0KPj4gICAgICAgICAgICAgICAgIH0sDQo+
Pg0KPj4gKyNkZWZpbmUgU05PUl9JRDMoX2plZGVjX2lkKQ0KDQpIb3cgYWJvdXQgU0ZEUF9JRDMg
YW5kIFNGRFBfSUQ2IGluc3RlYWQ/DQoNCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgXA0KPj4gKyAgICAgICAgICAgICAgIC5pZCA9IHsgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgXA0KPj4gKyAgICAgICAgICAgICAgICAg
ICAgICAgKChfamVkZWNfaWQpID4+IDE2KSAmIDB4ZmYsICAgICAgICAgICAgICAgICAgICAgXA0K
Pj4gKyAgICAgICAgICAgICAgICAgICAgICAgKChfamVkZWNfaWQpID4+IDgpICYgMHhmZiwgICAg
ICAgICAgICAgICAgICAgICAgXA0KPj4gKyAgICAgICAgICAgICAgICAgICAgICAgKF9qZWRlY19p
ZCkgJiAweGZmLCAgICAgICAgICAgICAgICAgICAgICAgICAgICAgXA0KPj4gKyAgICAgICAgICAg
ICAgICAgICAgICAgfSwgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgXA0KPj4gKyAgICAgICAgICAgICAgIC5pZF9sZW4gPSAzLCAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgXA0KPj4gKyAgICAgICAgICAgICAgIC5wYXJzZV9zZmRw
ID0gdHJ1ZSwgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgXA0KPj4gKw0KPj4g
ICNkZWZpbmUgUEFSU0VfU0ZEUCAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgXA0KPj4gICAgICAgICAucGFyc2Vfc2ZkcCA9IHRydWUsICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgXA0KPj4NCj4+IC0tDQo+PiAyLjMw
LjINCj4+DQo+IA0KPiBfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX18NCj4gTGludXggTVREIGRpc2N1c3Npb24gbWFpbGluZyBsaXN0DQo+IGh0dHA6
Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8vbGludXgtbXRkLw0KDQoNCi0t
IA0KQ2hlZXJzLA0KdGENCg==
