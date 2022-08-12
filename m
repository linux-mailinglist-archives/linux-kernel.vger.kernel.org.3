Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97C7C591504
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Aug 2022 19:38:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239586AbiHLRi1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Aug 2022 13:38:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233434AbiHLRiY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Aug 2022 13:38:24 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2064.outbound.protection.outlook.com [40.107.244.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42067B2761;
        Fri, 12 Aug 2022 10:38:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HBMOPf4n3xXUxoUtUNPa/TtZl0tNR0OrpMdxM1f322/ZEJyV3WpGFoMLix4smnhYdusjgNRtddFA3FWR8gBV1CRuIRup7Du1xV82o47Yg2lRadHXpiRJhblAgIWPGe441Mjgo2PGaWBqM9H49sxdVTrdeOMHQe98f/Avjb/A1yezoqH042W3BkVYY91qTSm/YEvZAOlqQUd+s4c3/7Q+vO/HAuGAKP1qcQn8OYXK5vEHjz4YhhUyOuxoY6BTtpCo29VbSIJgTqPsIyJbyIDof8QJJFLsSATrdYxUmB848D9/98YRCHJ8momRnekS49IndUHt1ZUnQ7oXf+4umXMvtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YXsypJMKVtjrv2PkKuMZtFr/RZd7EFxBQa0zxwMo448=;
 b=j4Jgnfr3smmC5Pg6uQKdhbh4avWtrI2QlwCbR7k4Ky+XWT2mopKW+iUghjpawJ8R0kCgwLqNfnygvQ77mxwIqk2X5e3QOgd+mU7QbN6bSCLsCCIVEpPOpmgcohcETQgvnU5D23/voNEReNJ6hVJFOLsysHdPrI1DMsd9e2B8FG7nz9yjZ2YOqNHE5RJJx1S+SE0pV9aQyQlutuM86SgabHZjNVOR4DLI4X6JURsTpxF1BZ1dGxkNwj2z/Hd5X9jqG6E0Jm/GCWr/Wlk6K+xO6sDU+b1QvfrPd+7aDFLm4fkmWWVi1ymHuZqhx73Pdbdt9KbTZ0vvm1Ii53MaFwh84Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YXsypJMKVtjrv2PkKuMZtFr/RZd7EFxBQa0zxwMo448=;
 b=pmvy53JEvT39FCVxyECN9WZQsguei5VrrmTr0c8R62XSmKtAuyEdC+pT859zu4kWhJHzXt6GTTjGcYOHaP9N1uzvAYHEE43AxYTtYOm55grU9vVeOJvSb4gfpbQfP5vG8wm7xN//bLgyZ7DO9mPU0DAxr9ZeVQ2dZyKve5ae/T00NmR96M7HZAa7umZsrazsT5RviRbP+2odDibL51W1vihSFGRbLBPH/bEOAqPvdC5pAgX71mENafmVLfE/hp5QiQi2lssoJRhEITszkOMKgw+oVo1wmaud+ZBD1Pd6ymXm7uv+rzL0K+lUDzCQ5ozlNMvGJP9P26Am5IH2+Vsqeg==
Received: from BL0PR12MB4659.namprd12.prod.outlook.com (2603:10b6:207:1d::33)
 by MN2PR12MB3245.namprd12.prod.outlook.com (2603:10b6:208:103::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.15; Fri, 12 Aug
 2022 17:38:22 +0000
Received: from BL0PR12MB4659.namprd12.prod.outlook.com
 ([fe80::e033:3f08:d8d6:1882]) by BL0PR12MB4659.namprd12.prod.outlook.com
 ([fe80::e033:3f08:d8d6:1882%7]) with mapi id 15.20.5482.016; Fri, 12 Aug 2022
 17:38:22 +0000
From:   Chaitanya Kulkarni <chaitanyak@nvidia.com>
To:     Shaomin Deng <dengshaomin@cdjrlc.com>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>
CC:     "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "target-devel@vger.kernel.org" <target-devel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] scsi: core: Remove repeated word "calling" in
 target_core_pscsi.c
Thread-Topic: [PATCH] scsi: core: Remove repeated word "calling" in
 target_core_pscsi.c
Thread-Index: AQHYrZmK/L0D97bYKkCCFyyeQSO2TK2riW6A
Date:   Fri, 12 Aug 2022 17:38:22 +0000
Message-ID: <5f3e9f1d-ad3d-80a9-9b76-e58c76801690@nvidia.com>
References: <20220811153923.17278-1-dengshaomin@cdjrlc.com>
In-Reply-To: <20220811153923.17278-1-dengshaomin@cdjrlc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7b9141a4-1bf3-4466-d337-08da7c8973e5
x-ms-traffictypediagnostic: MN2PR12MB3245:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: DTHcTJdzNjf0DSbZ4GT04eF6/6xjYG6mX/LBHDMZGqnvbQtjeDSzL8zleSSb+pKjbQdOKKOxqlmPh3VA/X6XttdZGT49oqJBGsRUtUMM/nlNc6WzyQ/yfJZKGwYa1XJDDGMnV+R324jA27B0iJqssR2lI7SEqybdgfZ1gEKcyRuu/mlum4kq6iwan6bPHyfl6PMrGvGLWwkKQA2ihHIsI2VNCUriE04BcGOqq81hRsinqh3kA/UPV5ID+mwgyZ7VJ3xwkhQukYMpn79HsoYsR2p0Y7uZHq5iKOQbQBFY9P3sePgjTQ6UPQOHYWvBr8I6IaksLJcurg68Sy/26qnZ/I1+Oxvj7jN/xRjehOEb8KBo8uAnP0LAuM9PLKyR50vfOD3Epp3dXc8tlqe8Lsk6GohAiUtr6k0jy8hEgdGm44NMYdcH6OKhZJQUdTF5B38Tbe8l8FWOD4vbGv1YYi3iSFWdcVvYlm0zDYGKxRaZi+ewSYBw+jkceUuG1mAj0wxy5LWWe0O20hOJ0++owBtVQogXdcGpMHSg+0tBCVA6EXtAVhW1IJHcOjs4i8IIwxSQr2QDedwZOTBfmkVrcxgsbt6JsAIExfJgJfHdPOOTFPGa9gfuoLcYSDzLfT2CkOLfuuxG1yFdqjkCtAMs9jmG9BFIS3ytCEm/27GXGA+YASOBcEffgetNg7TK6g5L0CfD7dQOWTXs4WTQGieu/iu4aAswgWXLwu3DIMFfSffy3e1wSl+YB7uONOHwiEcrtxeNLQAeEJR24hU6Uu3PlNSq+MlDX/ZGwuQzE4EWidJasjzTtsQJXTiXWKst7Wf1fS5UPvKlrT4AC1s0fzmLNSqEtl1EubKmax1WbN9Gf115O8A=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB4659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(136003)(346002)(396003)(376002)(366004)(39860400002)(31686004)(31696002)(2906002)(66446008)(66476007)(66556008)(91956017)(86362001)(76116006)(66946007)(64756008)(4326008)(8676002)(36756003)(6486002)(54906003)(316002)(478600001)(110136005)(38070700005)(71200400001)(41300700001)(558084003)(122000001)(186003)(6512007)(6506007)(2616005)(53546011)(5660300002)(8936002)(38100700002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?d3dMNlZlWG4yNDB0Nkp2c0NQbHlqUlc0YWlBdlIzNTJQeStaVnFrVDhnQXBF?=
 =?utf-8?B?NmtnTllLSUI2MHgrQkt3Qk4wcGdtODUwMU1qajJmbnVVdDVqdUZFSnJyUUpI?=
 =?utf-8?B?ZkcrZWp2QUhVb3BmWWRjTUk0YjVndXlVc2l6OTYyUVl6Vm5nRWhycXg5Y0NJ?=
 =?utf-8?B?N2hFbHdPZ0QzZitrcDVTaTB1YUZYR054K3BCUVZWUWI5Vk9LR09nVTRwZmRh?=
 =?utf-8?B?SStjcFBqRml5R2VKWStsaW5FekJ5cWZyc0xGQjNnc1pJb0xVc2ZWSEFyZzZD?=
 =?utf-8?B?SzF0VGJsWllJOW81QmlOdVpOM2xLVnJBcUt3WHh3aTdITmdPcjlsSlRqN1JX?=
 =?utf-8?B?b1JTdDFKbUY3aXJxQWNRVTkrM29UalZFV056b3ZiL0djbCtYYU9CdGoxdC9M?=
 =?utf-8?B?eEdhc3FBYlp2Y29aUmJoV1VUUUxXNVhaL3N5VmcrcFVHRkppdTUvTEhTSG9S?=
 =?utf-8?B?NGFwc2dhVU5ia0cvRXI4V2YyUEErSTlicEJnWmdUVXZJT2xDWVRqTHlZek9K?=
 =?utf-8?B?bk9hZzUyaGpZVzBIYzQxWGZ2M0RUVk1kQ0pWVTBhb09uUmx2cUp0dkc5Y2p0?=
 =?utf-8?B?YWl0Ukt1NHQ3RlRXd3JtbkM2RXEvby9lYlZ6ek1VOVduM3ZFcEdoWmd0eUF1?=
 =?utf-8?B?M0hPZ1Q5MytwVEUyeUlxMjZYMzVGNTJTQ1kzN3VSaERWd05odC91Y0tWNk1C?=
 =?utf-8?B?VGh5Tk1PUDBPOU82MXMwNEtpQk15SXdVWmhQMjVkRWZlbGhqMkxRZFFzcUQ1?=
 =?utf-8?B?K2xMblF0cTNGSkhocCt1cmh0T0RzMmYzcVA4cktqTkJEbDAyS0hSZldld0Q4?=
 =?utf-8?B?eGloYTlZRUYwK0Z5RzVZRHMvVHJsYUhGeHQrbmhxM1NzSGx3VVM5ekZiQ0dG?=
 =?utf-8?B?d1BrUDFPZUpwUFFMZ1FmMjkyL3luemFkV2VFelNSbmpkMDhKKy9FYVZFbVRs?=
 =?utf-8?B?UzJyYjRPVmQrVnZZY0Z5YUs1M0JzdEFTaGhTMG9rQkVlRVM3VitUc1IraUVa?=
 =?utf-8?B?emFUbndDNFNRVndiV24xZ28xekVlSE9NVTdkdEtMWEY3NU5jTmhPZ1JWajhs?=
 =?utf-8?B?VXhDS25MaDlWeFVxY04wZVYyMGNmbjBZRnBsNjRrbXB1S1g3SjQxUWZtczN3?=
 =?utf-8?B?N1RmYnVCcm0rcXplc0pyajJNSGZhTm96dm9aeGJyaG9aa3NDWW1HdFdYdGRX?=
 =?utf-8?B?M3U1VFJtTmJPU1FWc3VvNjY2ZHVGV3pRWUJ0VjBBNnVyVmM2TFVSQk1pRDRE?=
 =?utf-8?B?ejAvRitHL3lyalh1QVlZeENpcGVPcUlZcUlXQXJiSXBpY3lhNFF2dFU1Ykc5?=
 =?utf-8?B?Tlc2MndsbU14V2lIK01KdlZvMFFxWHNyU3FuNitvL1RLaWVBRHJ1V1FHa2I5?=
 =?utf-8?B?cXJDeGFoY3BJWlZWZnNqMU9YbUNYclZTdmhlQ2hqNzQyWHpONG1iN0ZqTVhh?=
 =?utf-8?B?bjVLcXpqNHVWcElBZzFvNi9YcDV3NzN1NEZXWDlJT3JSZXBtUXdkVCsyTjQz?=
 =?utf-8?B?YndvSXBmR2tUd3RiNXhLY1dhSWtKdmEvZWt4Ni9XVVIzcjZRN0s1NFcyZzlG?=
 =?utf-8?B?Y2dtTXQ1dmhHVmNkQ0V3WHVvanRybDBJL1FKd3FRODkrR1ZXU0JnbHVYL1pI?=
 =?utf-8?B?dlNoNUpFZmw3c0N3a1luNmFRU3IrWnRhMkh0bitSOUZJbEpzOTZXd0ZqRE85?=
 =?utf-8?B?Tk5Tb3dHREtYOStTSlVkVVZ2YTR2S1lSTkhoWkNzc2oydWdGanBLRS9DZUlX?=
 =?utf-8?B?QUdTWnlwbGU5cDJJS2V2UCs5dTh1UDRNOENSV1g5NjFWSWxSemYrK0FBSWJM?=
 =?utf-8?B?UzZSdmFqY0gyMHh6NERtNk5seFM4aU01TVVoUERIZmpNNCt3RW9UWTFBSi9j?=
 =?utf-8?B?VnA0NHM2bzUzYnRST3BqaEN2aG9JaXQ3TTFoOXdENmdQODZ4MCsrRVAvRTRk?=
 =?utf-8?B?d01YaHU3WmpMamt4TkVKTERBd3JoWHlJaUdoSVE5MmorMkJUNTJmMmNzYThy?=
 =?utf-8?B?RThtbjlFZ3VCVDM3bm8vdnZ0Wk5iems5Q09GV3ViZXVTdHpZbkRHYzQ5dnVk?=
 =?utf-8?B?OUk3ZUxQWkNqUG9FOXg1SWpKTkxIOXJwNm5sVUpsdkx1cE56YWRBbWtjTUIx?=
 =?utf-8?B?cXVsbjhyaGJUOUZPQnUxVDAwRW9vK3AxTnRENGREdjU0WHBoY2lkbmxQb2Vv?=
 =?utf-8?Q?G/Ekpg3f/6fIUpN47WZqhD2t7wW05BNVoVwOsiYpEn4B?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <82B4454D7313BD4BBF54EC44222D28E4@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB4659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b9141a4-1bf3-4466-d337-08da7c8973e5
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Aug 2022 17:38:22.2839
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: czNmdSh55HKAh01F5AibtNB4mZJHPxH2cVIA0WT1yDheghJptYZPmr0cZIyfERbdyNJ38y6cPqZ6DH0rXukK8w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3245
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gOC8xMS8yMiAwODozOSwgU2hhb21pbiBEZW5nIHdyb3RlOg0KPiBUaGVyZSBpcyByZXBlYXRl
ZCB3b3JkLCBzbyByZW1vdmUgaXQuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBTaGFvbWluIERlbmcg
PGRlbmdzaGFvbWluQGNkanJsYy5jb20+DQoNCg0KTG9va3MgZ29vZC4NCg0KUmV2aWV3ZWQtYnk6
IENoYWl0YW55YSBLdWxrYXJuaSA8a2NoQG52aWRpYS5jb20+DQoNCi1jaw0KDQoNCg==
