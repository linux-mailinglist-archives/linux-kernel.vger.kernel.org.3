Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25A395804C4
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jul 2022 21:51:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236703AbiGYTvK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jul 2022 15:51:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235738AbiGYTvI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jul 2022 15:51:08 -0400
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F36CB2A;
        Mon, 25 Jul 2022 12:51:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1658778665; x=1690314665;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=qIVgD8Se49dxTWDk79SdIIEIF9bh2i6MtI4B2d7+KmM=;
  b=C+f/7NRB4Hjp7vHtPRDpjTByXVxJXIcr7FleQ5Jua2x/ahoXRf0nuzvy
   WFTMKKvo7RT1z0k3omUZ7dUYruc4C2FCqTnl7GgNDd80lLBE8MqroASPi
   R4+gtqx7OgG2izXuUUAY8qIkbSNj+8FpIADyWLMMkTHD1TPTc2lFM1Zit
   RXZUPCv4d29+RfN0bnwqfLxVgZOzXsXneuaR6SqeM8e/zIAYHj+T4kdlb
   a/vzACvELfl2z24IUanHssr9NAQzl9WtWTJMK+Q9fDJBV+RCiwzMAAXu6
   Rxl5+f+6h9+lOjGmTZKLaCLQ4Uo5k8Kncx7m5xrXFGmvvObRYcUycGGEW
   g==;
X-IronPort-AV: E=Sophos;i="5.93,193,1654531200"; 
   d="scan'208";a="207486645"
Received: from mail-bn1nam07lp2044.outbound.protection.outlook.com (HELO NAM02-BN1-obe.outbound.protection.outlook.com) ([104.47.51.44])
  by ob1.hgst.iphmx.com with ESMTP; 26 Jul 2022 03:51:01 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HPDil6UbgiyVsC0kvQK7hS2fzKY3VK1aRvwewooSPn+vBwxMawmXea3KgNeG2pE5/xOKbndZy/ZoVjmRK8y/glX6xUEvTU8C02sa6qeS5I6ruI9PotmMUc9EiC/7BQZ2bmW0+KlEll2/ibnvvsJTIErF+oH9bh67hdqnp/aOVIERp7dKvznyd8DTFJenwyLCvREkM/O8I5T/m6tvzXux41Hsr0w/KHMedzDGF4IelsYZTgzdSCp0869zLmcOETV9II6uDk7Hd16kg6d39P2nX9qCZPNv2HFDh/ostMpqGmuPMDstLtuxU6QmGuRp2bqKE5r1rO2OFKJsyIIJXpQn3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qIVgD8Se49dxTWDk79SdIIEIF9bh2i6MtI4B2d7+KmM=;
 b=W8MJt8zgrthndFI20+O4CimkQPv3Xbon2tpXB90zs1zwLAInxdF2xBhyFbYRv1WUI0n6sAUJkOgMyMadiCMRbyioSMasgkJ6YhCxJs7vjxuFKxTKW3HVA4DnRTopmLM89BXhtByyXkkXwsofOwFaa1qQsHTW3Ql4awery4QadMqZfmfJp35031sz7ZaiHJjHjWIN4ELcIxqapZMjMnYDQWwKmq4TfhlV1p240gy7L/Pp/2XZZ2dVSap8Rak9zU1FZMh9leR1ybE4Ds8HVGQ6dj8rYAlnmBOTBqhQcbU6Yy6j0vG2bsVdmOr1O8rZxt4PlKqeLWAtQS/11RWnmgDGwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qIVgD8Se49dxTWDk79SdIIEIF9bh2i6MtI4B2d7+KmM=;
 b=F0CoPXk3pf5o/uJZCeidfh2vOQxuyqUiEFxSz+x+5wHnHAqe23Eep60xbATkNGlxJkr5Jypf0x1K+1eXXVLdofjhvu1M9KLVIzdyT6LcgzPYgw35GuOJ4wsSuXicRemCgqsbAl5ZO7/ZjuYMepieaYHdaogFurDQcJTTv79aduo=
Received: from DM6PR04MB6575.namprd04.prod.outlook.com (2603:10b6:5:1b7::7) by
 BY5PR04MB6948.namprd04.prod.outlook.com (2603:10b6:a03:220::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5458.18; Mon, 25 Jul
 2022 19:50:59 +0000
Received: from DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::5d26:82d8:6c89:9e31]) by DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::5d26:82d8:6c89:9e31%8]) with mapi id 15.20.5458.024; Mon, 25 Jul 2022
 19:50:59 +0000
From:   Avri Altman <Avri.Altman@wdc.com>
To:     "Asutosh Das (asd)" <quic_asutoshd@quicinc.com>,
        Can Guo <quic_cang@quicinc.com>,
        "bvanassche@acm.org" <bvanassche@acm.org>,
        "stanley.chu@mediatek.com" <stanley.chu@mediatek.com>,
        "adrian.hunter@intel.com" <adrian.hunter@intel.com>,
        "alim.akhtar@samsung.com" <alim.akhtar@samsung.com>,
        "beanhuo@micron.com" <beanhuo@micron.com>,
        "quic_nguyenb@quicinc.com" <quic_nguyenb@quicinc.com>,
        "quic_ziqichen@quicinc.com" <quic_ziqichen@quicinc.com>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "kernel-team@android.com" <kernel-team@android.com>
CC:     "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Daejun Park <daejun7.park@samsung.com>,
        Jinyoung Choi <j-young.choi@samsung.com>,
        Kiwoong Kim <kwmad.kim@samsung.com>,
        open list <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 1/2] scsi: ufs: Add Multi-Circular Queue support
Thread-Topic: [PATCH 1/2] scsi: ufs: Add Multi-Circular Queue support
Thread-Index: AQHYmz2OvInxSH8TlUq8qOHvad4nHq2MbQiAgALjEQCAADjhAA==
Date:   Mon, 25 Jul 2022 19:50:58 +0000
Message-ID: <DM6PR04MB65752C063B1C9D06A3CB44DAFC959@DM6PR04MB6575.namprd04.prod.outlook.com>
References: <1658214120-22772-1-git-send-email-quic_cang@quicinc.com>
 <1658214120-22772-2-git-send-email-quic_cang@quicinc.com>
 <DM6PR04MB65756C2EF5D9F23B5EC9E3A7FC939@DM6PR04MB6575.namprd04.prod.outlook.com>
 <a46700a8-585f-ddcb-ccaa-806afcb31ec3@quicinc.com>
In-Reply-To: <a46700a8-585f-ddcb-ccaa-806afcb31ec3@quicinc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0cfe716a-85d3-4a1f-6343-08da6e76ff04
x-ms-traffictypediagnostic: BY5PR04MB6948:EE_
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: rQX+NX3y10m4u1YAUFovPTRQpMdLUIEx5EtUf0cjKlYxsKhgaeKfVsHLVNK3Z64zg7czqCuCi2xZ5XU5UicE8s9QPDPaBS+sgLvg9wZ2JgA34eB0c7ZEPWOp3WE5A12m1+g5SBACY0rqTGnPcf3Fs3OJ5NCgSjv7r20YshWlDjufysbrTFDBsLskLHTAfickdfi9HxuWnVqDhWGeBW8xd89ibyARTuZefcjZDUfhf6F9crih7F8OdY1minTjZbNoG/XfGFyzacRfQHqW571tYeI0aUE9KHQ+wnG0J8PJHUXbXBJFB9oN8bhnIweFOp0Td4yql45PL7UX1y5K5j1IzUPcbr/bHwXJ36HhW6QrmU3YKtBNDoxskmxpwG6AlOud46T4Unczkj6Xp2rD/TStjp98PV6Rrx+9iZMQ/1ytzrDyPuSIpropVXO4lneBh4uZoQFd6uYz0ZnSrzwq7CIlDq2jhV2O9J9tcSQIMueOpOWgKPn77XfqRQ+7cTrjBHGSTGpcw//czvegpVkfeaZt31RaJpqasWN/3uRdwQ6BBIXGOWGTQPQlhuC1lJi62HEpGQ1VywwEPrJA2ZCj5LZMpalr9JOiORChXhfcz4uNQjcX/1I46/w0b0skxKuO7zIwodeob226/PW13uWJjsMuNgPI86T5xnra2RzuWnSMlSZsu7JCQseuJMzee9++vEe+32J5JeIK2g+HdPHseBPRZobGRdoUiuw2Dt6CI+qThTGPkChP0SqfKiz1F858USib31UZyf42aHRlRnfB708YbHhFTmrNIQiAyhX2YWsIUhZFtEpEKV3BYFrbKj6M7QK8XqP9xFgMo6VdO0maA0jzfg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR04MB6575.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(396003)(136003)(346002)(366004)(39860400002)(376002)(66946007)(2906002)(26005)(9686003)(41300700001)(478600001)(55016003)(7696005)(33656002)(53546011)(6506007)(4326008)(76116006)(110136005)(8676002)(71200400001)(54906003)(316002)(82960400001)(86362001)(122000001)(38100700002)(38070700005)(921005)(4744005)(7416002)(186003)(52536014)(66556008)(64756008)(66446008)(66476007)(5660300002)(8936002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?M3VlWFRUMHJBWHViTHJrMWV4K2FSeU91eml0TmtRakZyTFJzT2g2Z0ZZK0gr?=
 =?utf-8?B?WUVYT3FNa2ZrRnRWNm5iVjF6c1lONmpRa29CTzlOcTR0OEN5NU5NSzk1WWFK?=
 =?utf-8?B?bWswa0ZHUllqeEhINmFkRHZMQi9vamhCWGNTdEVQRHJmSVAxMEhLRzFoT0xu?=
 =?utf-8?B?cGUzZk1BQVQzWUVRZzFkemZRRktJQXJqekM5YjZYSXhGdzdIMytsTGRmbGgz?=
 =?utf-8?B?L1U2a3Q0b3NMbmZRZmV4MDZxSENpWmpSaG0zdmZDeUVPcWJWNHhYMkdiN1k5?=
 =?utf-8?B?Q1pxbWRyK0pyYWF0b2FoV0NvdXJ0UXkrWHQ0TGtROW5TTExOcFA0REFabzFR?=
 =?utf-8?B?YlYrVDRwL3RwN0hsSFVHbnd5VDBiTFIxUzNuaUFMa3c1dktBd3RHdHZONkxB?=
 =?utf-8?B?VjBCa2d1V2I2U3JqTm1EeTZJM2o4SXUrOHpxcnBwSlBVcDFndHorY1hVTmFl?=
 =?utf-8?B?SGFZYUcxcFJ4WXRzelVETGJTNzFiQXZYZ3lSMnVIYlZHUGpBQ002ZjVGNkFL?=
 =?utf-8?B?Uk1RSEIvMGNrc3FpcHh6ejlZcEdTNVZuKzUybTJMZzBsU1JuMmRpc3l3UTlG?=
 =?utf-8?B?ejdGdTJ6cEFBNW0va2NPeDVycnExUy9STHFoTHF3YWJGaGw0ZFpDQ3d5OWd2?=
 =?utf-8?B?bi9wZWxFR2pPVER1aTJ0ck0zSkQwYUdqL0d2NksyL2xERHlqNXJOR1o1eGtB?=
 =?utf-8?B?TkJUbHM3bnNUSFd3QXdQbThPMEVuZ0lrcnI5eG5VK21PcnFkWG9pbVVzZE8w?=
 =?utf-8?B?Y3FRSzIwMGxLTU9wR3FXb3ZYaXFkUEpEVzN4UFlZV1VsTUx5WlZrV1A4MUpt?=
 =?utf-8?B?K1VsbWY3MXJzWTZHa1BxSGZZMGd2NGdLTmtWNzVmS0RncmJENFdkTjVkbUJJ?=
 =?utf-8?B?eVNLRnoyMDRFTFdncFFkbjhpT01oQTA4QitxdU1FeklpSGpFSFB1OFkrN2JN?=
 =?utf-8?B?S0J6N3R6MCtPemtPZHNHWjY1WXI3b0s0QVp1UWxHTzN3MXpjdVJZQ1p5YmVw?=
 =?utf-8?B?a3IwY0RaMG1oSXU4ZTVFNUg0NTZBL0dUcVc1dGora1dJSnF6bk9yL2JxRDNM?=
 =?utf-8?B?TFRVZm14OEpmdkd1Zlk0aEtYTEVPUlphVmlLQnR3ZkEzL2dlMjkxU2VSZHhR?=
 =?utf-8?B?QWszZHpnSHdWSkIwU1pJRmZSYWhRbHk2NEh3ckhFazVSL2d5TUZaMCtYQ0cr?=
 =?utf-8?B?U0lnZXM5SGc0eGZLTk1STVpDYWJFVVJ0eTdhdzZwbkZ5aHZPaEE0YlJzbUxM?=
 =?utf-8?B?WE5MMXFXMFJWaEN6NDBjbllGODFQaWlOMnhLeVR2OEx2YzFmT0xxMFkxVGNa?=
 =?utf-8?B?Wk5zWDRyQ2c0Q1U3NW9xR1V0VVhxblFUWEZyMFhtbjBKTllSMndZV1pZbTZO?=
 =?utf-8?B?RUFhaCtmR2h6bnVHNS9NV25qcDVDT2VqVGI2NUxLamM0QlZIeVlITUVHQXNN?=
 =?utf-8?B?ODJhWGZwaEtxdHROUFZEVk4vdWxxS282a3hLOU94cEpMWU5nT08zOGZncXdQ?=
 =?utf-8?B?cVF6eklac3FpYTFXWWZGdlMxSjlpaXVha3pMSFhjVnlrU2ZKRUxjUXdjdlZs?=
 =?utf-8?B?a2p6eXVyNFVsZVBnZnhscUdvaktSekZrVDFOczFlOHduWGJzT3JHVDhrSWI2?=
 =?utf-8?B?ZGVHbjNqZXJPMzhDeXZFTDZpdGpuRjBySFBhb284eFVrUHIrckRhYkYxVUQ2?=
 =?utf-8?B?QmxYR0NYRGlXbzh1MCtibEVTLzFzOFU0dXdHQU1JOG0vNExodVZUbERYbnZj?=
 =?utf-8?B?OER1QzZoZlRMelFqY1BaRFVWZWN4NVFjY1RkVmVRdUE3d290MFVwb2hzdk54?=
 =?utf-8?B?NGxVVXVKeEtBWFJUaU9zaDdVbnhBR1M5MnFsR1hlanUwMzg3T0VWVWJSRis1?=
 =?utf-8?B?cndHSHM3QUNjU3NIRFAzckdJQW9QQ3p5Vld5cVpJc2ZxNjhaa0hjR1NpTDRj?=
 =?utf-8?B?Ujl1VnZ0SHo5bU9xUmQ5SVFLaGNnYzY1c1lSS1NseFZpeXE4WUtBdUhueC9Q?=
 =?utf-8?B?M0VNWHRRYloxd0NrUkYxTXp3SkhNYjlmc3puZGhFaHhSMU1WeE5leGhWQzBa?=
 =?utf-8?B?REZoZ2ZpVzhEdEd6ZjNaUmhHdkhZNU1nb2N3WnRIVDZtRVlRRGN1SHRHc0pq?=
 =?utf-8?Q?ZHZLNaECGPNz+Nfx+ckBIgx+c?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR04MB6575.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0cfe716a-85d3-4a1f-6343-08da6e76ff04
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Jul 2022 19:50:58.9864
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Gig8FRU4ygIUZ0ODSgjcRMHJ9PH7uELMEApjR4uXglWM1AQy7nIDe4cYpSixXLgBSfrLHlJInUsLUBQh6lzz0w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR04MB6948
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

IA0KPiBPbiA3LzIzLzIwMjIgMToyMiBQTSwgQXZyaSBBbHRtYW4gd3JvdGU6DQo+ID4+IC1zdGF0
aWMgdm9pZCB1ZnNoY2RfaG9zdF9tZW1vcnlfY29uZmlndXJlKHN0cnVjdCB1ZnNfaGJhICpoYmEp
DQo+ID4+ICtzdGF0aWMgaW50IHVmc2hjZF9ob3N0X21lbW9yeV9jb25maWd1cmUoc3RydWN0IHVm
c19oYmEgKmhiYSkNCj4gPj4gICB7DQo+ID4+ICAgICAgICAgIHN0cnVjdCB1dHBfdHJhbnNmZXJf
cmVxX2Rlc2MgKnV0cmRscDsNCj4gPj4gICAgICAgICAgZG1hX2FkZHJfdCBjbWRfZGVzY19kbWFf
YWRkcjsgQEAgLTM3MjEsNiArMzc2NCw5IEBAIHN0YXRpYw0KPiA+PiB2b2lkIHVmc2hjZF9ob3N0
X21lbW9yeV9jb25maWd1cmUoc3RydWN0DQo+ID4+IHVmc19oYmEgKmhiYSkNCj4gPj4gICAgICAg
ICAgaW50IGNtZF9kZXNjX3NpemU7DQo+ID4+ICAgICAgICAgIGludCBpOw0KPiA+Pg0KPiA+PiAr
ICAgICAgIGlmIChpc19tY3FfZW5hYmxlZChoYmEpKQ0KPiA+PiArICAgICAgICAgICAgICAgcmV0
dXJuIHVmc2hjZF9tY3FfbWVtb3J5X2NvbmZpZ3VyZShoYmEpOw0KPiA+PiArDQo+ID4+ICAgICAg
ICAgIHV0cmRscCA9IGhiYS0+dXRyZGxfYmFzZV9hZGRyOw0KPiA+Pg0KPiA+PiAgICAgICAgICBy
ZXNwb25zZV9vZmZzZXQgPQ0KPiA+PiBAQCAtMzc1OSw2ICszODA1LDggQEAgc3RhdGljIHZvaWQN
Cj4gdWZzaGNkX2hvc3RfbWVtb3J5X2NvbmZpZ3VyZShzdHJ1Y3QNCj4gPj4gdWZzX2hiYSAqaGJh
KQ0KPiA+Pg0KPiA+PiAgICAgICAgICAgICAgICAgIHVmc2hjZF9pbml0X2xyYihoYmEsICZoYmEt
PmxyYltpXSwgaSk7DQo+ID4gSWYgaXNfbWNxX2VuYWJsZWQsIGRvIHlvdSBzdGlsbCBjYWxsIHVm
c2hjZF9pbml0X2xyYj8NCj4gPg0KPiA+IFRoYW5rcywNCj4gPiBBdnJpDQo+ID4NCj4gPj4gICAg
ICAgICAgfQ0KPiBBbm90aGVyIGZ1bmN0aW9uIHVmc2hjZF9tY3FfaW5pdF9scmIoKSBpcyBjYWxs
ZWQuDQpCdXQgeW91IGFyZSBzdGlsbCBjYWxsaW5nIHVmc2hjZF9pbml0X2xyYiBhbnl3YXkuDQoN
ClRoYW5rcywNCkF2cmkNCg0KPiANCj4gLWFzZA0K
