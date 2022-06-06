Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D049E53EB52
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Jun 2022 19:09:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238996AbiFFN3E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jun 2022 09:29:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238969AbiFFN3C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jun 2022 09:29:02 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3900FDFAF;
        Mon,  6 Jun 2022 06:29:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1654522141; x=1686058141;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=82sYhChfsr0OsazsahOm+KhgJ8hhFOe/MkuMcLURYEY=;
  b=vQVPom3GUch5yR83psX0HohhFZtPo6crervSJFqtgRbULiZmyHizIUrF
   2+e/I0wG2R/O890qNHFZM+XkqWab1S2WAi0JuHHsZpUD+mrijK7gJtNk8
   M1dcNU2V+5yifgsmh5j2u6YK0ufo/9sZy2zqmLlYfD01B1SIl9vddMxQy
   4WdrDjgyraHyCsuoSXxZG/wnrzILfS7p6c0SqgwPJ9i/A6uhY+dtx1Hh8
   D3jsNNrzxbFzct6Qdxf/bHOk9GoH5mnXl1UxPHV2R9mm0ewiDj4TpdnMS
   19warFICrjYQ3wPoCZttjG/tArRX8qhi2xxQ+PKevAYQqID04P6fvNSzH
   A==;
X-IronPort-AV: E=Sophos;i="5.91,280,1647327600"; 
   d="scan'208";a="98737121"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 06 Jun 2022 06:29:00 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Mon, 6 Jun 2022 06:29:00 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17 via Frontend
 Transport; Mon, 6 Jun 2022 06:29:00 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KIW0V//1eoFhrap/tQ9/NHoiJXIiXoqFSA0bjinUZWD/DLOfxXexyvuyFlm2MffiUpmvVKyV0uMjXEdYGQbWlnDtRXVg/IUaKJBZJ6KFh5uWdkFL6mM4LGz/pBbvtYYMw/tSBXSSDGeO7yI+GmDdiJWmsmvvfxUBJENIf9aN590afk1tGt7gtVOGO2JMCs9a3fwzz/nWezJtrTXy5JcexHtzGWpvtMlX+COUyFJIx+hAf9m13Mpk4vlO4/C1IzCPOh8Buv8JNiEXEPlqAGQgz5m3EbinmISxOkBIBPLukObIUNnzBUFuYjkpjuScQ8RW1kFZNgYbFBkAxN8Sur2H2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=82sYhChfsr0OsazsahOm+KhgJ8hhFOe/MkuMcLURYEY=;
 b=G4orw6zIBkxHGmfdTCMbB8ytP1U3YggEVXsvNd89dhVkEyURV+WwwBuWTBvFFRumOdqtRXw2TmNs2fe0FVH+QUn34O61SLoX8rQPC3bLv6xON3JLxWfvfdnauG/eaQqyAqbUeoPl7DKr9WE9a311/9Z5OIcXP/yYIMYE6WYAykVQJ3NtLNe/Pr4X0tbUaKVXk51UfHut1x4CpjlhZ3f46LqzkVQwbiwehbZEZ4Kx5lJX7MAIkVwUC8IbwcLVZAyE2TOyn3KHHR1/7GGHNQKhbQOYGfROZXILBY1yBP0+u5jAwgiDiy1Bvm2fuHsNXSGyockGzMKAAK6ZKTY9QazHnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=82sYhChfsr0OsazsahOm+KhgJ8hhFOe/MkuMcLURYEY=;
 b=A2DnwehtfNLLsPtMH6rZLY3rSlOOxpFRn0XsK5sJWBACU7+bgamQKayrt0j/TpGoPcar1IGEAHXmq0EupQTVMeZK4olNLUUuyDVMp7Z2yJrDqp0hYU2y54PHShldWytmcBjzn+hMbNOFzo24/uD2e2/+qxW/giXdBEfcBaiWzw8=
Received: from CO1PR11MB4865.namprd11.prod.outlook.com (2603:10b6:303:9c::9)
 by MWHPR11MB0061.namprd11.prod.outlook.com (2603:10b6:301:65::37) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.13; Mon, 6 Jun
 2022 13:28:49 +0000
Received: from CO1PR11MB4865.namprd11.prod.outlook.com
 ([fe80::ed35:677f:b973:ac96]) by CO1PR11MB4865.namprd11.prod.outlook.com
 ([fe80::ed35:677f:b973:ac96%8]) with mapi id 15.20.5314.017; Mon, 6 Jun 2022
 13:28:49 +0000
From:   <Kavyasree.Kotagiri@microchip.com>
To:     <krzysztof.kozlowski@linaro.org>, <robh+dt@kernel.org>,
        <Nicolas.Ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <Claudiu.Beznea@microchip.com>, <UNGLinuxDriver@microchip.com>
CC:     <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 2/3] dt-bindings: mfd: atmel,flexcom: Add new compatible
 string for lan966x
Thread-Topic: [PATCH 2/3] dt-bindings: mfd: atmel,flexcom: Add new compatible
 string for lan966x
Thread-Index: AQHYd0QmWAaHYSMcPkGcGHHu1K0zWK1CXQwAgAAGZuA=
Date:   Mon, 6 Jun 2022 13:28:49 +0000
Message-ID: <CO1PR11MB48656331826CDEA9DFB6A11092A29@CO1PR11MB4865.namprd11.prod.outlook.com>
References: <20220603121802.30320-1-kavyasree.kotagiri@microchip.com>
 <20220603121802.30320-3-kavyasree.kotagiri@microchip.com>
 <1764f3ce-608f-e55c-d977-18fb95e4a0fe@linaro.org>
In-Reply-To: <1764f3ce-608f-e55c-d977-18fb95e4a0fe@linaro.org>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8c19dabc-18e9-4eeb-c201-08da47c07dbc
x-ms-traffictypediagnostic: MWHPR11MB0061:EE_
x-microsoft-antispam-prvs: <MWHPR11MB00616B77F37E8F99F254572292A29@MWHPR11MB0061.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: tgY0NrG5ofFjBmgbBLVZKKpwopD0f4YOcSg0HHz3lP7DuUR0t32rDMj7+Gae2vxMX8HI9rEdoRWuVxSL+csnIacXLwVDepnUuIf65IU3kw3I3kg6Bq/53ZXCMmFkhn0Cc2VADnlR6ora/4MOgTLjbNclYgATAmUz9cFqF6XVW12RUgEzvaA46MXfPDrUBjk9pPVqR941lDh2N5WAm75nX6llKiLmPBICn+O7GHSR27SENM41ZweRTq+VB/vo/QTTpLqdXrSv5AF9aC1TnukQagR1ppWTsC4CZvHt3gG8+Pp9k7obAz37e4bPTPmN4VZj46fA2+y5NlBq0ZdWVR3GhBjE07kaTrle5YNGc+L0hDTu9pV7LFX4yg9QmDjfNs6NMXqnfL6rg3IptIkMoMBOooO9/AVSUvqR+w3N1zW8Qgtv1k2xUy4p0jvULsy0YaZGQY3RdWXi67/mzk/P9xWuuf/oj/EdAJt6arC5dYzlEDhReemXCfxcILJb4d0sfgVk47l1p+woWbb2cPVQHKSRm3tLzNeImsDaIIbig430ZsfdTxwjRkiO6VFWVGu/zEvpSfg/oCZUBH2vIF+VNGSOv8ExWD/NrtVIVC1DOnI99Nlq9AOV5HZEwZqiQ+o3q7Cd4g4zZL4ahlV1AWa86ci97/XN59NoJXvCd8d5Xa9HBAKt5meYYd8kTEG6AJUGUSmlqLnE1fsZ8RxLw+5nFyECVA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB4865.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(6636002)(7696005)(38100700002)(55016003)(6506007)(54906003)(83380400001)(71200400001)(64756008)(5660300002)(86362001)(2906002)(52536014)(4326008)(122000001)(316002)(8676002)(33656002)(66446008)(38070700005)(186003)(508600001)(8936002)(66556008)(66946007)(76116006)(66476007)(110136005)(26005)(9686003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SCtIc3BWdFRuKzdSTVJHTnhBdW9oWWFIOTBCUzhiTVVJcHA2YnlSN3VBNFhm?=
 =?utf-8?B?WERmSGdlWFlDSEROZmVsMjVYVmV0dms0eWJQUEhkRUZpNEZXdE1aK29ac1V1?=
 =?utf-8?B?REc0SThlZHhER3VLZlB6SVAxdHA4WXN2c0tlb0xwclN2MkxCcGt0S2pxQklD?=
 =?utf-8?B?RlFTQnlEempzSDNyLzM3VUFOSTFONzJha1lpR1B0bExWWnBLRnV6dDY5VFFI?=
 =?utf-8?B?U1BUZHFNejFUYVFkcFJDZXJFdEhsSjBpWWI2eUNYMDhZT0lRQytuNHJFalRu?=
 =?utf-8?B?bFdjbFM3WTRNa1ZLWmFjbTJ2VjBoVXRpcFdtdStOL0ZpUlBhTFpCTDhxNHpn?=
 =?utf-8?B?Wmxrd3p1TUY4NVkzM0pvQ2p1dXJJd3RqWGlYZ1dMMlpsT0Y4QUQ1amRXVEQz?=
 =?utf-8?B?VWplV25wNlFsN3REVTlBcUQ3VDhMdEEwTFgwSkhsdHZqK0NoalBkWC9hV0RE?=
 =?utf-8?B?S3pFbHlGY1BRYml5cHVneHNlYS9TbHBNU3ppTXlwbjEyY1NkYkZKNEdFNDNL?=
 =?utf-8?B?bVIvNmVJNXB4QVNyZ2Y0aXBGRHZzYjhXYk1Xd3VKWTk0a1hvOVJzTU45RWZJ?=
 =?utf-8?B?eDdWSEFuZWpuRHdzN3BsMzBSZHlZV2xzZUdBMC9DdDVSTGd3bndGcHJoc1lR?=
 =?utf-8?B?TjV4K2lSTE9PMkdZRlNrU0pYWDZZaDdHYmVQNVR1U3EwUFhzNUJhMGtGR3pP?=
 =?utf-8?B?RGJuS3hPYjdscGZSVmhPN1Z5Rng0ZGZ2ZW95SWM0S0VlYVg4SWlTdVRJa3ZU?=
 =?utf-8?B?SlV3YkEzM09scWlsVWVnOUI2Q0ZoMDZqbzZmdlJyckNZSXYyTTZMWGw1dk1M?=
 =?utf-8?B?SmlocGZqbWptM01HMHVHRXJxUVlLcVVzakFaeTM0M1Y0WTQrQkp5ZGx6dHBI?=
 =?utf-8?B?TEZ5Ni9hRW5JSllpM0ZiUnF6WE1HZ1BIb2MrWnd3VTFkWlAzRGY5YmtQaHBM?=
 =?utf-8?B?ck5vSjRSVHJYaVlDblBsQmNsTXc3cFNRN3Q0Qzk2Vms2bEN0YXU1V1VaM0N4?=
 =?utf-8?B?ZVFqbEpia3FXaEpKT1l5VVpVL1pveWMzelpscFEvY3NhYjdXaUtkbFpPT25F?=
 =?utf-8?B?MVgwOXFQc3Fod08rdUg2V2pGZ0tra0ZjWXVETmNmUWZBQ3BCZXdIRVFaN2dp?=
 =?utf-8?B?andNN2Vsb1RVM25tcm9WY1I4SFZIVy9vRWNnZ0pvWTUrdXlLZVBHMzEvZExO?=
 =?utf-8?B?MHljbmVIWkZoMFhSZW4wTFdBRG1oYmFSY3IyTGlBMkpwdUxseE91K21XQ1Zt?=
 =?utf-8?B?MDFKWXFjOHF4cjR4SklWbkhBaFVOOGtsVUZkeFA3M0s3TWxpRjNtbEpMcEtJ?=
 =?utf-8?B?clpvOUNPMWJhV1VnU2xPQW43YWZEQU8xRGxzU0NkNklCK2lKVEdPNWYrMDFH?=
 =?utf-8?B?dFlnNWtaOVdXK2JTc2lZV3p0OEZGMUE3VExJNXdSazB3NGNHZzZ0RWF4bjZJ?=
 =?utf-8?B?YXAxM2w5Y2c3NmlFWFZhNFdmTFRoak5KSjFjMWlOeVlFSC94U01wVWoraHJF?=
 =?utf-8?B?eFl4MWR0MmE1bDVXbGFSN05xdWtubDN3SFVZKzJ2K2NzKzJLRzZGY2w5YTgy?=
 =?utf-8?B?YmNEYTFGekZZSEtOR0M2YlhHRDNVSW45cnBQYWhVbDF4WTZHT3Vwb1hVT0FS?=
 =?utf-8?B?VUlvakw3dkRuS3hLaS9rbDNiai9EdTdNU0doUExBOGNKUjBWSE1ySjR5Y2N3?=
 =?utf-8?B?Wll2dWJQaitLa2orODBWVmNuR2l0Mi8yUUp1eUwrWlRtNFVRQnNhcjJ3Ritv?=
 =?utf-8?B?NzZRNVdOVWVNUnBUSGxjazhkbVl3SlpDM01PV05KSGVUUU5zVFlFWWYwVUc2?=
 =?utf-8?B?NWRVam5DUWJ0VG5YV1pUYmd2MDJ5Y3BXOUVjeDI5MmV4dHVkS0J0bWFsQlNX?=
 =?utf-8?B?V2FFa0gwck9LbXdWdGxXSURzSE41QlF0RS9jS1NEeEFBa2FTQk91WHRnaXA2?=
 =?utf-8?B?RHZwSVhyS0ZaeloyUzcxS3RXL3dJdW5pdTQ0VXpSTitaUmRnaUE1bWdlaGdP?=
 =?utf-8?B?MjRkenZSWTQ5RExZSW12SktxUGljV3N2ZklpZHVkcU4wSXdQYW1aS3JGeDBr?=
 =?utf-8?B?RzdPdHBheXJGRWlwRkZjT3BQN3MzbE11ckJ4emszb1J0TElMMUYzZFZ0Z1Rk?=
 =?utf-8?B?clQ3RWVNWmtmMHAyNldsQXJkcmF1bVg1eWd4TG1FTG5MbzNoYk9VNGRCS2cz?=
 =?utf-8?B?UkcvWVo2TlFxcHoyT3VPT1V4T21SRWZkUU95MlpYaHVYKzNvaGdrSzlPNklr?=
 =?utf-8?B?N1FkNXpvNjI3QVpCWHZLTTZPOFhybUNtT0tVd1JjLzFHS1NOOGk2UmFKOStI?=
 =?utf-8?B?bDdGTk1tODRzVGZEaU42RmVKc1hmOExWMmcyZmNEYThRR2R6WHlwZVRJakxC?=
 =?utf-8?Q?zbwUCW6rqF3U8HXg=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB4865.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c19dabc-18e9-4eeb-c201-08da47c07dbc
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jun 2022 13:28:49.4693
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yfP2TfMzv048g1xkfWbrCe+muB6vc6O5COaDlW2wO9eOTXicQTxD8P4kfZXVG5G8+4U+8vHTDq7uUPqGXgP96adw7yiJrINE+9yTRaqLNUEL38/J4Pk2DpmJQbMbbvJ/
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR11MB0061
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiA+IExBTjk2NnggU29DIGZsZXhjb21zIGhhcyB0d28gb3B0aW9uYWwgSS9PIGxpbmVzLiBOYW1l
bHksIENTMCBhbmQgQ1MxIGluDQo+ID4gZmxleGNvbSBTUEkgbW9kZS4gQ1RTIGFuZCBSVFMgaW4g
ZmxleGNvbSBVU0FSVCBtb2RlLiBUaGVzZSBwaW5zDQo+ID4gY2FuIGJlIG1hcHBlZCB0byBsYW45
NjZ4IEZMRVhDT01fU0hBUkVEWzAtMjBdIHBpbnMgYW5kIHVzYWdlDQo+IGRlcGVuZHMgb24NCj4g
PiBmdW5jdGlvbnMgYmVpbmcgY29uZmlndXJlZC4NCj4gPg0KPiA+IFNpZ25lZC1vZmYtYnk6IEth
dnlhc3JlZSBLb3RhZ2lyaSA8a2F2eWFzcmVlLmtvdGFnaXJpQG1pY3JvY2hpcC5jb20+DQo+ID4g
LS0tDQo+ID4gIC4uLi9iaW5kaW5ncy9tZmQvYXRtZWwsZmxleGNvbS55YW1sICAgICAgICAgICB8
IDIxICsrKysrKysrKysrKysrKysrKy0NCj4gPiAgMSBmaWxlIGNoYW5nZWQsIDIwIGluc2VydGlv
bnMoKyksIDEgZGVsZXRpb24oLSkNCj4gPg0KPiA+IGRpZmYgLS1naXQgYS9Eb2N1bWVudGF0aW9u
L2RldmljZXRyZWUvYmluZGluZ3MvbWZkL2F0bWVsLGZsZXhjb20ueWFtbA0KPiBiL0RvY3VtZW50
YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9tZmQvYXRtZWwsZmxleGNvbS55YW1sDQo+ID4gaW5k
ZXggMjIxYmQ4NDBiNDllLi42MDUwNDgyYWQ4ZWYgMTAwNjQ0DQo+ID4gLS0tIGEvRG9jdW1lbnRh
dGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL21mZC9hdG1lbCxmbGV4Y29tLnlhbWwNCj4gPiArKysg
Yi9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvbWZkL2F0bWVsLGZsZXhjb20ueWFt
bA0KPiA+IEBAIC0xNiw3ICsxNiw5IEBAIGRlc2NyaXB0aW9uOg0KPiA+DQo+ID4gIHByb3BlcnRp
ZXM6DQo+ID4gICAgY29tcGF0aWJsZToNCj4gPiAtICAgIGNvbnN0OiBhdG1lbCxzYW1hNWQyLWZs
ZXhjb20NCj4gPiArICAgIGVudW06DQo+ID4gKyAgICAgIC0gYXRtZWwsc2FtYTVkMi1mbGV4Y29t
DQo+ID4gKyAgICAgIC0gbWljcm9jaGlwLGxhbjk2NngtZmxleGNvbQ0KPiANCj4gWW91ciBuZXcg
djEgaXMgaGVyZSB3b3JzZSB0aGFuIG9sZCB2Miwgd2hlcmUgdGhpcyB3YXMganVzdCBzaW1wbGUN
Cj4gZXh0ZW5zaW9uIG9mIGV4aXN0aW5nIGVudW0uIFdoeSBkaWQgeW91IGNoYW5nZSBpdD8NCj4g
DQpJIGludHJvZHVjZWQgbmV3IGNvbXBhdGlibGUgc3RyaW5nIGZvciBsYW45NjZ4IGFuZCBhbHNv
IEkgaGF2ZSBuZXcgRFQgcHJvcGVydGllcyANCiJtaWNyb2NoaXAsZmx4LXNocmQtcGlucyIgYW5k
ICJtaWNyb2NoaXAsZmx4LWNzLW5hbWVzIi4NCj4gDQo+IEJlc3QgcmVnYXJkcywNCj4gS3J6eXN6
dG9mDQo=
