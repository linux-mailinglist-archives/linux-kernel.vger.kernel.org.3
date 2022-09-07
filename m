Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 745B15AFD0A
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Sep 2022 09:04:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229577AbiIGHEX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Sep 2022 03:04:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbiIGHET (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Sep 2022 03:04:19 -0400
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFBAC7820A
        for <linux-kernel@vger.kernel.org>; Wed,  7 Sep 2022 00:04:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1662534258; x=1694070258;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=ZHEmNNnlthgeXQu2hFpfLO+O9WCiNLugXIjDHAMLUng=;
  b=Wk3+QPOzbRRWX515EeVlsbn9fd9rL1eD6hhFzxLndbcSLUh/77yNf2S3
   H4CpGaM/RxdtG7qVx5m8GQRt2ce0u8bCSYXaA8srUvjSsXQWsSAPnTDW7
   hzkAqvYymY5kuhx+SkYOZLkWwSHhk5f6fdMf9ReC4JDJLN8rnIGj/j131
   i+cglS4wHIxKOmSdJzBL9EKxeJwDfw0sk4Z5J/f6CUAjS3AQrly/MhRe0
   hXXuCiztD0jnE5cZzjVcIYum326YYTzPJoVxOZhdP6w4x1jkSUZVNxZGY
   p3QWDMsv1C6recMlbOFjgwwmltmOUPJVGdtwiRfd9YKhn2+KPYTFVpnMd
   Q==;
X-IronPort-AV: E=Sophos;i="5.93,296,1654531200"; 
   d="scan'208";a="322820998"
Received: from mail-mw2nam12lp2043.outbound.protection.outlook.com (HELO NAM12-MW2-obe.outbound.protection.outlook.com) ([104.47.66.43])
  by ob1.hgst.iphmx.com with ESMTP; 07 Sep 2022 15:04:17 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B07Be4lUmeZEj7L1jamo88cLoo3cGAuspXoWF2lXYXJlYRAtUHrgbwMX5Jx4hwyGUMbdzprIAFpSjB/gaKvYpErPvQ2iGpP9yTgPUnjQ/YKRoADUbFkCLHwlMawACCiKfAsxec8ZuJUzQCi7VJ4bGtPj7I4Qi9S9r3bSMuGX0LHK28W7sJA98cR1f3yB7URZLhIh9bW/AE0JorPMUNiuLf+lof1OwUR4Gx8I7bo6AOJ/Rl+f/b+36Z80Lp8u1ea0v5rTqu+6TfUkteMVZE2b4bYVHrnwmOV8xyq/XMRKA+T2rff6MzhiDMuwFjO7jZ2ARm+yeunop4DrZ5Rj/N2ksg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZHEmNNnlthgeXQu2hFpfLO+O9WCiNLugXIjDHAMLUng=;
 b=nHip6GMecjaxbHaA++lhUIatmmuD/vgtXAqqWeHi4+cNBVjdREvCirXIWDkrPGejBQd+QN3zEndEzQN53SqwwBsWoZ9J7x/umltb6OZyKVr8G0RUPkfolKilayyO3SY7UQPQ15mKwJl7IKEi8+JeeshiZgzOPWwky/X/IX8HzUo3fG7EzyKmkav34Cty2cAUyclO98URJw8CFUNki9kkR0YvihJVW9yzLtd3AbSkthPoY/SEd+aE+/VcVJsqUhzcF2EG8CilWPBx5LSRbnfvhEZL6tdoCafdQxa1z3QNz1RF62PsGU5oc6AVz8de/uyKNqggqWJ1dYmjoLS1HV1c+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZHEmNNnlthgeXQu2hFpfLO+O9WCiNLugXIjDHAMLUng=;
 b=HtaHlexLcialXLomg63QdADxbrLDpV0gfIdLpiW90GyQq8G6kMiyTyxm4Rj3axfBtOSKu+6xng6M68+L2FwfnYLpsygBfPSjq9qlg0noo5d72rEAB0m47rmCf0lOyzeAb5ga7GjaTDeV4d02bb8SPj4Asfg745QeyjFg5KCUelc=
Received: from BY5PR04MB6520.namprd04.prod.outlook.com (2603:10b6:a03:1c6::18)
 by BN6PR04MB0341.namprd04.prod.outlook.com (2603:10b6:404:18::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.16; Wed, 7 Sep
 2022 07:04:12 +0000
Received: from BY5PR04MB6520.namprd04.prod.outlook.com
 ([fe80::bc24:4048:67fe:b8b2]) by BY5PR04MB6520.namprd04.prod.outlook.com
 ([fe80::bc24:4048:67fe:b8b2%5]) with mapi id 15.20.5588.018; Wed, 7 Sep 2022
 07:04:12 +0000
From:   Dennis Maisenbacher <dennis.maisenbacher@wdc.com>
To:     Chaitanya Kulkarni <chaitanyak@nvidia.com>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
CC:     Niklas Cassel <Niklas.Cassel@wdc.com>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [PATCH v2] nvmet: fix mar and mor off-by-one errors
Thread-Topic: [PATCH v2] nvmet: fix mar and mor off-by-one errors
Thread-Index: AQHYwcPQigesd+7hxkuVbGTy44IuN63S8p0AgAALrACAAEV9gIAAakmA
Date:   Wed, 7 Sep 2022 07:04:12 +0000
Message-ID: <B683848E-46D3-403D-91BE-CE0C4B3C5841@wdc.com>
References: <20220906073929.3292899-1-Dennis.Maisenbacher@wdc.com>
 <d3b4ef13-62fc-1bf4-3a5d-3cc740df82b8@nvidia.com>
 <8154fb0a-4cda-a4bc-29ef-8435a3edb264@opensource.wdc.com>
 <36b16998-3720-cc30-3ee8-b4d92c3b266d@nvidia.com>
In-Reply-To: <36b16998-3720-cc30-3ee8-b4d92c3b266d@nvidia.com>
Accept-Language: en-GB, en-US
Content-Language: en-GB
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Microsoft-MacOutlook/16.64.22081401
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 22430eca-e642-4255-6afb-08da909f2b2b
x-ms-traffictypediagnostic: BN6PR04MB0341:EE_
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: mEuQUOCp55GeRWUK9mIyOpCxFXFDfYNVSqvfQ+usFZO+fSmBMKVNmofaS5y7Jbybdkpz/lTke8ahszdeK2iII0MXZbDQqx1Dl6cs4lL4uaJYySNTYFXnsfzH8MEexCN8A8qo1Vqie4kN1296hUhkDUO6aMWsAyrLC3slofOVUAxB3c4bMnZI164Im7MraUtezj2ax6sY3pFuU7vok1SmWMs+AHoDnmQgxd+MATFSaLjQ9FBuBHrhHmVupoz+onOTXtimZHv1W6DP1dEzKFXDv/tT/VkF7x3FhiXC+WkvSq3oUwpjdxvVHNcDWbhHm67MKGqgFApD/9PmBbTKkGxu3DbmfMq7fQ9YIiRCEdwPl6HHChNlseNm4K4dX87Q2l81/KnQ6pheFA8CqBeZJCPWDMUb7VH8okw4oPM6KIcbmfgPgQSm/jhhXlu96iaJ7ixP49+a014XCsEMvQBlqqEn5luksarlWh9jk7RZ6fUUegKB/jP/qo57x+QYLKWiuvikvbAS1RH6QkMFRgxm8R3za9FaId7b9+nUv+QfTxHw75B3y7YV0py+hWuCZVHCC753ASz67NKj9dBd5cbZniemcH0TF3NWm/+e5JKVbhtntwKwgORQIG+OK83979MqQzcQFtgCjTqLtfqiCcBr3Ow1H1Y6GrCFlHqp5gjuJCLRMrRt5V37kw9i3xCHx9oQcSvFa6vGPOtRehopT/FU/3mvE1z9b1ZyeJo9gyu4TaZN79No7sqkITjY05oDcCYjzDyCt1sHBYBLbvYkSvUWqktZQlF6L+3a+h03/GeCxI/ClJo=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR04MB6520.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(346002)(376002)(39860400002)(396003)(366004)(136003)(122000001)(6506007)(186003)(478600001)(38100700002)(2616005)(6512007)(83380400001)(71200400001)(26005)(6486002)(2906002)(8936002)(66476007)(41300700001)(66556008)(66446008)(76116006)(44832011)(86362001)(91956017)(66946007)(36756003)(5660300002)(4326008)(8676002)(64756008)(54906003)(33656002)(82960400001)(38070700005)(316002)(110136005)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Z3NlRXFEdjVFNzkwNWpwZTFlNDd3R2pKU2I5cEw1WHBERHJCckRMZm5tbGNv?=
 =?utf-8?B?blBTbmZnNkp0cU1RK0MrdERBMktEVUd0Wnh0NUFDdTA4d0NVeTB5OTFhdTdp?=
 =?utf-8?B?RDNpUFlEYm1xT2VuK0trTW8zVS8wemg0ZktpK0VQOCsxUGhFVE5INWprMXFC?=
 =?utf-8?B?REpFb3VtdEhtNnIyRGducml2YjUrY3NsREk5cmhGMUh5QnBQVjdwQ1BOZWRa?=
 =?utf-8?B?Szd5VnJTS2VCZFU1dGVlTzJxbTJReHpReE9RUThVSUJBZTlWR1M0OUZyVnZE?=
 =?utf-8?B?aXp1bEdVRW83eHFlSlJLSFArdEdBYjY4WnlWeGJOYmNSQWZOUk1kQk1Zb0d3?=
 =?utf-8?B?alROeGFHTWtjK0VsN1J4T0U4SmNDYlE3bmVyVmZHYzZZcWpMR1R3QXpjZkF3?=
 =?utf-8?B?WWF3eTRHUnkxZ0FpeHJmU2YyUTBBOTErWTBFU2V2VlYyaDdXTXNkY2VqWlZ5?=
 =?utf-8?B?cWQ1MjNWZEJhV2VpTUxQRERrUU1kV3JmN2d5UEswYmpiL0ZpMkhPNFYzaEVp?=
 =?utf-8?B?NnQ1ZE1RUXR5Smx3RE13bXUwU1lucEhPNHg2VFNEMVdYNzhtLzUwbXl6cFFh?=
 =?utf-8?B?UHFLRTE5dlBoUDJ4OXlTeUlQc0lPa2p4SmFSbDVydENYYkhDQ3hTT3V2QUtJ?=
 =?utf-8?B?eWFHZGJnYTF3ZS9aRjRMaXZla1lmVkJoZkJSeVlJMnJURkJmVDRtQUJIOU16?=
 =?utf-8?B?Qnd1UzdEREFiT2NwSWxFVTM1V1E4dHpBUXliTTQrRVRxTDlPMjVLUFJTRmlo?=
 =?utf-8?B?KzZSMUs1Zzg1VU1sMVBDdldPcnVzSHNDZmM2QnhWWTRYTkE2SmZpV203N09V?=
 =?utf-8?B?K0ZyRzQrWnU2YnFYQThnMlJrMlFlZ2xzWC9FNStaRkZKRnVWTjRlZEZMZkpo?=
 =?utf-8?B?Q0Zod0JKSGZNRzduWWxyV0VqUnRWM1pUNmRHbm9rdU1oWGRYdVVtK01tYndQ?=
 =?utf-8?B?UGNuZmZWc3RGdXpSWHR3eTdYRTV4MGs3RUR4cXNGQnZ0WDh1VEdzclg0Tlpv?=
 =?utf-8?B?ME5hMUtGbHlCTUtFMjh3M3h0OTZCV0VJYkFvVXRNcEV0REszVjlFRmpzMWxn?=
 =?utf-8?B?dE85Y1huNytGZHZJV29ZM3NpaU1Mb3NnREFubkozQ2prYzNkYjRWdi9hZUtF?=
 =?utf-8?B?M1hnY2RpMGtYRjlGZVlXbVJBUTcwSDRKaW5SNnV4Z2Myd1lWWU8ybFdLSjk5?=
 =?utf-8?B?dnJjVTVIZXNweEFLbWY5MmF0NEJYOUhVY1VHZnRnLzE0UFMyaU1MdFE3RjdK?=
 =?utf-8?B?c2dLT2grNGpRRDgycGp1eUFoRTA0alVHbzdLUWdsU0FkMjFRQ0R0ekIxOWZr?=
 =?utf-8?B?c3gxSTBLNDluWjJJZ2YrVU5hV01GU0JnY2pYTFpkbWN6S3lBNnlvUHYrNmdu?=
 =?utf-8?B?KzR5ZHpnc1VCTk92Sk1zQ2FlL3p1NnJxQlVQSHNONUpGdVhONnJRdk53blg1?=
 =?utf-8?B?ampQa0t4QTkrcjNFVDB3c3J5c3BOV2c5SSt0SEVId1VLYzMvbnZnWWliWDZh?=
 =?utf-8?B?UCtra3I2bDB3dGdGaXZFSGNBVUFWL2tEWjczWC9jbTdNYnhlOUVsWWdpci9Q?=
 =?utf-8?B?SmJGeDZxVWM0VjFyaUwvL1J6WXhnUW4wRkpXQjBnM2hBa2pheHJHaHhoMWxP?=
 =?utf-8?B?WW13NDl0aitpeDlQTW9aNWdEekJDdHhiS3dUR0Z5czgxRGtwMXZNQTduNWhX?=
 =?utf-8?B?Wk5sSkhvMFhYZjZhSW0vUTJUN2x5ZTRVSk0ra1BvdExFT0VBZHgrbzJZZGJZ?=
 =?utf-8?B?Q3BLaG96Vmc4RFhva2FEQmxoaGIycGJqbkUrYXF1NnYwZHByT2dHOE9OMnNH?=
 =?utf-8?B?K3BuUCtGS3luU2NvM3NPVW0yMUpmT3V0ZEh2bUZHWEFMK2tJSEV1TDJUQzZ2?=
 =?utf-8?B?Si9VMTZVcEJ0VkRWZ2FoYjFza3cvMFk0WGxPbkt5dmt3b3dtRVRDNXV6eTNi?=
 =?utf-8?B?aTQ3Z01JZUg3c25QY2hZL1gwbFpNK3FIUWZzVjJrSjZ5NHZLcm1YbUpNdndR?=
 =?utf-8?B?eUJkTEk1Y1lWd0pVVkhCRDZUQjVNK3FOT21TdWFYcytQYTVvd05WdkpJVXd0?=
 =?utf-8?B?RmNVVHcyV0ZxTFNScnowajE0b09UQzR3YmVQeFdJMEtkNWp0dnBlS2lENjRU?=
 =?utf-8?B?LzZwK2xCZStsT01IditFUjNsbDFwRlJMNlNGeDZDYVdmYi81SW1BSVJvejVp?=
 =?utf-8?B?Y3c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <8D30C11BF72E884BA74A5E589DD59D3F@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR04MB6520.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 22430eca-e642-4255-6afb-08da909f2b2b
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Sep 2022 07:04:12.4343
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ta6XOR65deXSVJCjHDlagLYuYEcCiSzmpTQLJVw6cIzCLSh0zrQ3qFqkTnE3w6eyJUlY5ScgO/NW/eGi1Ux0Ukv5vjqQUJn3Ho8t4kTsXEg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR04MB0341
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Pj4+PiAgICAgaWYgKGxlMzJfdG9fY3B1KHJlcS0+Y21kLT5pZGVudGlmeS5uc2lkKSA9PSBOVk1F
X05TSURfQUxMKSB7DQo+Pj4+ICAgICAgICAgICAgIHJlcS0+ZXJyb3JfbG9jID0gb2Zmc2V0b2Yo
c3RydWN0IG52bWVfaWRlbnRpZnksIG5zaWQpOw0KPj4+PiBAQCAtMTMwLDggKzEzMSwyMCBAQCB2
b2lkIG52bWV0X2V4ZWN1dGVfaWRlbnRpZnlfY25zX2NzX25zKHN0cnVjdCBudm1ldF9yZXEgKnJl
cSkNCj4+Pj4gICAgIHpzemUgPSAoYmRldl96b25lX3NlY3RvcnMocmVxLT5ucy0+YmRldikgPDwg
OSkgPj4NCj4+Pj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgcmVxLT5ucy0+
Ymxrc2l6ZV9zaGlmdDsNCj4+Pj4gICAgIGlkX3pucy0+bGJhZmVbMF0uenN6ZSA9IGNwdV90b19s
ZTY0KHpzemUpOw0KPj4+PiAtICAgaWRfem5zLT5tb3IgPSBjcHVfdG9fbGUzMihiZGV2X21heF9v
cGVuX3pvbmVzKHJlcS0+bnMtPmJkZXYpKTsNCj4+Pj4gLSAgIGlkX3pucy0+bWFyID0gY3B1X3Rv
X2xlMzIoYmRldl9tYXhfYWN0aXZlX3pvbmVzKHJlcS0+bnMtPmJkZXYpKTsNCj4+Pj4gKw0KPj4+
PiArICAgbW9yID0gYmRldl9tYXhfb3Blbl96b25lcyhyZXEtPm5zLT5iZGV2KTsNCj4+Pj4gKyAg
IGlmICghbW9yKQ0KPj4+PiArICAgICAgICAgICBtb3IgPSBVMzJfTUFYOw0KPj4+PiArICAgZWxz
ZQ0KPj4+PiArICAgICAgICAgICAtLW1vcjsNCj4+Pj4gKyAgIGlkX3pucy0+bW9yID0gY3B1X3Rv
X2xlMzIobW9yKTsNCj4+Pj4gKw0KPj4+PiArICAgbWFyID0gYmRldl9tYXhfYWN0aXZlX3pvbmVz
KHJlcS0+bnMtPmJkZXYpOw0KPj4+PiArICAgaWYgKCFtYXIpDQo+Pj4+ICsgICAgICAgICAgIG1h
ciA9IFUzMl9NQVg7DQo+Pj4+ICsgICBlbHNlDQo+Pj4+ICsgICAgICAgICAgIC0tbWFyOw0KPj4+
PiArICAgaWRfem5zLT5tYXIgPSBjcHVfdG9fbGUzMihtYXIpOw0KPj4+Pg0KPj4+DQo+Pj4gYWJv
dmUgMTQgbGluZXMgb2YgY29kZSBjYW4gYmUgc2ltcGxpZmllZCBhcyBpbiA0LTUgbGluZXMgOi0N
Cj4+DQo+PiBTaW1wbGlmaWVkID8gSXQgaXMgbXVjaCBoYXJkZXIgdG8gcmVhZCBpbiBteSBvcGlu
aW9uLi4uDQo+Pg0KPj4+DQo+DQo+dGhlcmUgYXJlIHR3byBpZiAuLi4gZWxzZSAuLi4gZG9pbmcg
aWRlbnRpY2FsIHRoaW5ncyBvbiBzYW1lIGRhdGENCj50eXBlIHUzMiBhbmQgaXRzIHJldHVybiB0
eXBlIGlzIGFsc28gc2FtZSBsZTMyLA0KPmlmIG15IHN1Z2dlc3Rpb24gaXMgaGFyZCB0byByZWFk
IHRoZW4gY29tbW9uIGNvZGUgbmVlZHMNCj50byBiZSBtb3ZlZCB0byB0aGUgaGVscGVyIGFzIGl0
IGlzIG5vdCBjbGVhciB0aGUgbmVlZCBmb3INCj5jb2RlIGR1cGxpY2F0aW9uIGZyb20gY29tbWl0
IG1lc3NhZ2UuDQoNCkZvciBteSB0YXN0ZSB0aGUgY29uZGl0aW9uYWwgb3BlcmF0b3Igd291bGQg
aGF2ZSBsb29rZWQgbGlrZSBhIGdvb2QNCnRyYWRlb2ZmIGluIHRoaXMgY2FzZS4gSXQgY29uZGVu
c2VzIHRoZSBjb2RlIGFuZCB2ZXJib3NlbHkgY29udmVydHMgYSAwIHRvDQpVMzJfTUFYLiBBIG5l
dyBoZWxwZXIgd291bGQgaGF2ZSByZWFkIGxpa2UgdGhlIGNvbmRpdGlvbmFsIG9wZXJhdG9yLg0K
DQpDaHJpc3RvcGggYWxyZWFkeSBhcHBsaWVkIHRoZSBwYXRjaC4gSW4gYW55IGNhc2UgdGhhbmtz
IGZvciB5b3VyIGNvbW1lbnRzISANCg0KRGVubmlzDQoNCg==
