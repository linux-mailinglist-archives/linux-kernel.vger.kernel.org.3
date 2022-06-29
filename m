Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DE2D55FFE5
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jun 2022 14:33:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233025AbiF2MdA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jun 2022 08:33:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232499AbiF2Mc5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jun 2022 08:32:57 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2076.outbound.protection.outlook.com [40.107.244.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A93D515FEB;
        Wed, 29 Jun 2022 05:32:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ABOPwF7kxneXpoRJfhjp+2sbkn2gIVxdeUKHJhqAn1efCvY3kcA4myReqcecEOBziADnH93DzPgBDAZn7WPddpCn2JXc3m58sDhR2TZJsU9+XJMei13ZBmbyjmEycR6qO1eVYQ2S53N1Btc3GEAqNxhYOBh3wh0CH493hvnHvmqjo88W7+TYiXbV00/OrRkfIaYPyHCbHwar1z71LyT80SMbhiO/wdTr5UxgkpISBaM1rXsv+hBS3bxHFZuqWRYNfvkEoZvBLqGSIW7dE+dh7rWl3zSLJD309DRR4fMrPwHdt7K2FKRD+ZsdBH4gNtVs3ohmaPgZxi7ZD+V1RM8M3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=um+XwB/UYgKVV8ILPdhNcfC3KVSJ5+IDjjTuxiwiphE=;
 b=HyQXVQmLlijFHjIGod0PBtodq2YuguAsLli/ys6iMffPEfbIwSe4QWTWV5PXtEGlmBWmnQK8qNJ8dY+1Obt1Q7/yp//Ck3VljKFER/rbbhy7q5rBcMIp7s5/+zcJDP59GinzMiFcZjrFu95baUpVaqPb2hycbHr8ziC306pfkskOYL9iEIbpGQiFHbcbnpa323KpwSf68f7iLbyiRalTG51Ffn2+Qv/5RhNPHm9yqy/X1VNV3Cz22jAFknO/t/C52LpYkmO88TEtGAOCg8qPuoFpqCwAPGaCmcmBg3oGusr8mzWh+lI1siz/yOyhuy4mzoyx0SEnpQkUxIz+zTipew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=um+XwB/UYgKVV8ILPdhNcfC3KVSJ5+IDjjTuxiwiphE=;
 b=Gs7fDuBCj0ecJqdQgjhRIicJbfd+cGYKnLy7qyLZq5AWF+9YjxpHkwtbNdxc/HM8cRHFgwqsfxjRSk/wbFDDDEx+tFAlEs/uOpyHISVIpvHe4PstzlFtRP9cjEW6FxsIR9WFhB6ekohvocohdqBLr9/vhdRRSzc5WgbADR51zdk=
Received: from BYAPR12MB3527.namprd12.prod.outlook.com (2603:10b6:a03:13c::12)
 by SJ0PR12MB5438.namprd12.prod.outlook.com (2603:10b6:a03:3ba::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.14; Wed, 29 Jun
 2022 12:32:54 +0000
Received: from BYAPR12MB3527.namprd12.prod.outlook.com
 ([fe80::4ce:4e7:1404:cb4c]) by BYAPR12MB3527.namprd12.prod.outlook.com
 ([fe80::4ce:4e7:1404:cb4c%5]) with mapi id 15.20.5373.018; Wed, 29 Jun 2022
 12:32:54 +0000
From:   "Rao, Appana Durga Kedareswara" 
        <appana.durga.kedareswara.rao@amd.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Appana Durga Kedareswara rao <appana.durga.rao@xilinx.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "michal.simek@xilinx.com" <michal.simek@xilinx.com>,
        "derek.kiernan@xilinx.com" <derek.kiernan@xilinx.com>,
        "dragan.cvetic@xilinx.com" <dragan.cvetic@xilinx.com>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
CC:     "git (AMD-Xilinx)" <git@amd.com>, "git@xilinx.com" <git@xilinx.com>
Subject: Re: [PATCH 3/4] dt-bindings: misc: tmr-inject: Add device-tree
 binding for TMR Inject
Thread-Topic: [PATCH 3/4] dt-bindings: misc: tmr-inject: Add device-tree
 binding for TMR Inject
Thread-Index: AQHYirIsL8QELzw1W0+GzCxO6cGXFa1mKyMAgACBiYA=
Date:   Wed, 29 Jun 2022 12:32:53 +0000
Message-ID: <b9b3fd68-d750-d977-d6ac-5c80882b062b@amd.com>
References: <20220628054338.1631516-1-appana.durga.rao@xilinx.com>
 <20220628054338.1631516-4-appana.durga.rao@xilinx.com>
 <7f7d7aa1-0aa2-0ee1-762d-e47aaa5548e2@linaro.org>
Accept-Language: en-US
Content-Language: en-GB
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Microsoft-MacOutlook/16.50.21061301
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2c3b0a0d-cd60-45f4-2509-08da59cb7d36
x-ms-traffictypediagnostic: SJ0PR12MB5438:EE_
x-ld-processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: S20tBj03ZrJYbgPzdtuMnVBMxTqhilseERXuOV7nxeeJbZpslCjawNPHp6B29oy0/pmaYipWJogDmFzEBxjMXin2r1dQjF7LAB7KEahYpuTxTruL3g7fTrYa2kW56FYmt8iJay0/xHlmg2Vd6C6szMxA+4YZ0WPSmDP90c769FvP5nVVmwIw2fFfKU2EVNYJmi5/Mt+QlDuWaTJ1IY76qWZXvWG/Oz2Dg199yUNtiH/TLQU/BjzqAy4USrti+Dusl2tdEq6FaHWzZrj572X69tBazA0eMedrXNBexttRZMuYwYDnxuQhdRuLInfMar25mBDfYiEpHaoPFw6S5/3A61z0D67DiFVYSdIYiYn1IpV2HF4ksX6I5DQ3bSt/SRaqSUtXmjGnQ/Pyvlpg5UZywDMJJ8zmrhZgwoodWCFoSyPAPEXlz8ag8b5W/+X2R/Q1yWblz68HBCsCGALLLtOlSSfAF6lIcytLVQSX74dSucelC1nlsuVypcxRC9hYdjPGzX7pNWTvLulMmD5R/x93VAeVRIbTHHf2g6G8/Dl9gQEw4hzBykX+Urc+xoTrc6dWyUonk+SX+EuuhWQoz8bEAG+6i9O3RJYv2iPN5voPVHX3JK6X0OH6RQgJd1IsrCvT9+iI6aAHqW2kEcffrNOcDJRQj8qFBpgc4kRDYjKRWbJh5KIYbM6zoC8N/q/Fk2k9x4bSwLgI5ta7GWHDVP9kGKroeSjs9nizH7YfLE8XzgOGgFS6bxFmeP4RCRb1tUT7DFauBOA/B1vzY8npaGeO6BlDCfSQA2E6a0REt8wqV14Eapib6zM7tcxGdJ+NlzAMGqZb0ocrky30E+5W83DuGuoAdNEcHfr0GwqE0Hcdue4=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB3527.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(136003)(346002)(366004)(396003)(376002)(39860400002)(8936002)(8676002)(64756008)(66476007)(26005)(76116006)(4326008)(122000001)(5660300002)(66556008)(66446008)(91956017)(66946007)(6486002)(6512007)(478600001)(71200400001)(921005)(53546011)(38100700002)(54906003)(110136005)(316002)(31696002)(186003)(6506007)(36756003)(31686004)(86362001)(107886003)(2616005)(2906002)(41300700001)(4744005)(38070700005)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NmluTnkybVRpY0l5b0R1bVliNlZFMTFDLzVVWTNkQzRKT1VjZTFBTURMMEZF?=
 =?utf-8?B?WXZJbnRpKzIybFhsdTdiUDlpRDB3SEg2eSt6SGNub1E5c29iVnJlZUlzMU12?=
 =?utf-8?B?b1NadlpQWDJGNEFYUVRrNkN2UHJLb25YNjEvRzZxeExMS2JvN3U1Mis5S2li?=
 =?utf-8?B?Ymo2RDhya3dqRXRZcDFYLzh6cVgwLzNWT201ZW55V2FxbW9lM0ZSYXErcytq?=
 =?utf-8?B?UG55UGh6MnFKb29SdGdhbkNPOEthdUtWVVZtVGtLTjVVeDBrM2NVR3dsZ1ha?=
 =?utf-8?B?aDVFM2g2T0xtMkRlTXJaRFNhS2M4QldMSlZvVW90aU1Gc0RLNkQ3MXo5ak1z?=
 =?utf-8?B?K2JQbzJSZHhhNlYxTmFKc1E0VkMybmdlMm1CbDJYK2s1Q1ZxS2dNb3RBZDAv?=
 =?utf-8?B?eGNIT2UrQmFIelgza090bC9DY0RGWmdlVkZ1TGIwUHhsb0tvVXh3clA5UTVC?=
 =?utf-8?B?bGV1MFM4NWRaYWVNUEVNNVdjSlBneVlUVEVsdDNnN3lNTzQ3Z3dCZzdCa0lY?=
 =?utf-8?B?b0NaaitGcUkwVFpUZVVRZjhZY3c5WU5GOVlCdmYzNlExc1BpOUNPa0ZzZzhT?=
 =?utf-8?B?c29PQUFsUU5ZeXRGeTgzV0dGYjFrLzhSeityY2p4SHo4OEc4Smo5UWZjZ3E1?=
 =?utf-8?B?UjFBRDZvd1d1RXV6ckpldlBsTEs4T1I5Z0doL2VaZ1VDMVVJdXBZQ3FNcmdF?=
 =?utf-8?B?NFI2aXJRZ21nUDJWRzkzazhOSUVUbDlJSFU0S1R2UnE0YTQwejlYa3IwZFMz?=
 =?utf-8?B?MjNDTnBodDdqbzhsdVFlUDMvKytuNXlhckVTZHBpdlNma2t3b2ZwWSs5SENV?=
 =?utf-8?B?SGZMZDlzakFRVG0rSjdnM1ZIL0NkeHNCcytoajVFMjhBZFNYc0FRVlRDbHlj?=
 =?utf-8?B?TVVveWJUa1BIZW44YWx3QmVVcEcvZGlENklkckJlaE9vRXQvM1dTQzVyRVRi?=
 =?utf-8?B?ZXh4YitFd01KRUdXdDhKZTNSTnE0Tm5oYmZzckUzY3hhRm15K3dnaXRqYWwx?=
 =?utf-8?B?Y200RE9BYjNQZzE5L1p0c1YrNWtEUWRETXVFOWxLeVdCTHowYVV5RVhncU1Z?=
 =?utf-8?B?RGo5aWIyeDlpanlHd2d1SXB6ZXRRZjZmaU5EbWlKL3V4QklVQzRTYXFLd2FH?=
 =?utf-8?B?S2h2UVZXdlgrd0NMZklPdE1wS214Qk1HRWY4Zi9iUFVGY2FLQUwzTGdlcTIv?=
 =?utf-8?B?aU1IQU5qU25OM29ibUk4U3VSQ1dXamZhRXFoNndJYXhJY2o3UHlBUmNrWU90?=
 =?utf-8?B?TlRJYzdwNXEzc1RKdGtEYzBDVWsxdGlLZjczWHlJZUxlNFR2dkZDRFI0b3BH?=
 =?utf-8?B?TUhXUXR3RjFsd1ZQdnhqZnUwclV3R3lCcnphSFRKRUU0VWNoaDZZSFNqaGRD?=
 =?utf-8?B?MGdHS09Vd0FwRmZvWXZ3YlVzQkx1ejZVQ3hIVlJPOGxWQlpnLzVRbTM1OU5B?=
 =?utf-8?B?Y2tLaFB4S0YvMTJqWTZuN0QwT3lxWXQ5WWxMK294dkdYbUZIb3RSYWNVRXE5?=
 =?utf-8?B?T2Z2SFZ6NjEwSG9HWTdjQjhiMXdCS0FtOGp1YTgwcGZQT0tvZGlDOEtPRmtQ?=
 =?utf-8?B?VDdUVWl2SFdheGdWaFgyWUVkRGFGVmdBUS9CSDZxMEw2R0RzS3QwSENLei9F?=
 =?utf-8?B?aVdhMjkxL1dDckhGNVZiSjUyNUhIdG0vS0dBOFdHMThaeFJRcEhhUnNGWHhC?=
 =?utf-8?B?cDV3RHZLWTd2UExvWUFScXp6OHZKdCtQd01LRm1FaXc2dWIzT2hnekhEMFVj?=
 =?utf-8?B?WHlpdFJON2lPUkRaNDlNbC9KcXo5VFRscjZzUHUxbkFtQmxzVXYwdkJpS0dG?=
 =?utf-8?B?R0xQTG1DOVljaS9sd21KSWFGQi9PU2VMbTN0VDN1NlpxUk4wcHFTUUhiQU95?=
 =?utf-8?B?bXNUb3RET1Zzc25xenVVRHZJVmVmZFRPbzlrdjdjSmkwS1A3QXR5MTQrQmg0?=
 =?utf-8?B?QTZkVWlJS1hyczF0QTAzWjNKQlpSaXY4SXRsaHFlKzFPbnUyZFdHS2ppVUgw?=
 =?utf-8?B?OWNZM2l4dDdIdVRCQ2t6ZXdYSXl4YUVKSG5KK2NOc20yMXJHUGtNdGVmaFhV?=
 =?utf-8?B?OHdIcTV6Qkx4Z1luNlQ1VzlDWTJVS29IQ0d5QUZEL3hjdjJ0cVBwd2RiUTVx?=
 =?utf-8?Q?EksODBBr6L7I3NLHjoUBuAX+V?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <1B784581F87A5D499514D3E022F495E9@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB3527.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c3b0a0d-cd60-45f4-2509-08da59cb7d36
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jun 2022 12:32:53.9655
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: b8fWAIEJ+rVCZ9cLCN2yQ99BFUh6NfesR46IwiA/v6psP6z78zFTrhQUDOI5W04t
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB5438
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksDQoNCk9uIDI5LzA2LzIyIDM6MzkgcG0sIEtyenlzenRvZiBLb3psb3dza2kgd3JvdGU6DQo+
IE9uIDI4LzA2LzIwMjIgMDc6NDMsIEFwcGFuYSBEdXJnYSBLZWRhcmVzd2FyYSByYW8gd3JvdGU6
DQo+IA0KPiAoLi4uKQ0KPiANCj4+ICsgIC0gY29tcGF0aWJsZQ0KPj4gKyAgLSByZWcNCj4+ICsg
IC0geGxueCxtYWdpYw0KPj4gKw0KPj4gK2FkZGl0aW9uYWxQcm9wZXJ0aWVzOiBmYWxzZQ0KPj4g
Kw0KPj4gK2V4YW1wbGVzOg0KPj4gKyAgLSB8DQo+PiArICAgIHRtci1pbmplY3RANDRhMzAwMDAg
ew0KPj4gKyAgICAgICAgICAgIGNvbXBhdGlibGUgPSAieGxueCx0bXItaW5qZWN0LTEuMCI7DQo+
IA0KPiBBaCwgYW5kIG9uZSBtb3JlIC0gd3JvbmcgaW5kZW50YXRpb24uIFVzZSA0IHNwYWNlcyBm
b3IgRFRTIGV4YW1wbGUuDQoNClN1cmUgd2lsbCBmaXggaW4gdjIuDQoNClJlZ2FyZHMsDQpLZWRh
ci4NCg0KPiANCj4gDQo+IEJlc3QgcmVnYXJkcywNCj4gS3J6eXN6dG9mDQoNCg==
