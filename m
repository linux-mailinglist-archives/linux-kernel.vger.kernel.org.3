Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7EB8E4DA4AD
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Mar 2022 22:34:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351986AbiCOVgF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Mar 2022 17:36:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345007AbiCOVgA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Mar 2022 17:36:00 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2082.outbound.protection.outlook.com [40.107.244.82])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5A6C1FA4C;
        Tue, 15 Mar 2022 14:34:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iGdcfUxEEY0DF9R42nBCOutaD1+1q4vGmUj5G3nMrdIkwjzTmXpsvEfG8qmIASO/XjlXhk/VOWnLcu0TS8RpO4H0jlgMQTGL/BwCs5Rzd2V2mK7IaMh/FLIQjLEvZ/OsDd/hPG3kpyZkYjZckpVr+5ABkKNrvOAcdX+Qh5mk6tuL5NE5ljhr/pmm0eQnrHShr9hHjZpfyNmWhB2PGNcr214okB4AhGvVq99+eGLigfO3QUFszRquRMPhHdL0YHQsQW+wQTDfE7tOHBZJXdsGrgeuQj9jyU6muYlT8si6t0QCUq5+B4tBqUALa4dLbLF7OfZ+ANZKiZGtfqAhAZVHlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uyS3WMrMilfCvDh4PVBr4FD5uFpkSFGjPy5t0px64Qo=;
 b=TRfhLYpbSaB9ixvs88CM0T3N1pbgylbiKoNtNDjeqGWfuHSSv4lcWOFpQZiMo/smSYeIAhdU8ECPZmoL2FJZtfKAMxV694qcEzWcBFlm8m4atOWZn8k1mmpqoznThrCr8mnZzCg2R6g0CstrONVXMI1ZKO3SPA5DI4qKd4s8zGheSFUF5ulSKviRs4bzOo+cHe6KyD1XIB9SGJRA2zlpdnb41GhrEydflepnQcxe3kRy1bdKeUtm4+4VZF7jvzVbqlSh4AZKc1BkdLEpz7duiRPBM+oZA8u8vNea9CJP7ni+RQHAYcZru9noGlFLAnpfPNtf4Rh3Zwg4GvWuidItVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uyS3WMrMilfCvDh4PVBr4FD5uFpkSFGjPy5t0px64Qo=;
 b=o3DIErxBkinx+oJb44NXqpczzu5FopKxbqQsyY/8v8Gf4rlI54DuIZw63D7mjsu/AaMKGpgs9R2aUjW7jylqyrQdZx66/zkpakUkZvZfjyRlEoTOZO2m3aSO15K3gg2gTfouuYUyR5V5EEZr98U8gYbrxN01nwKX37Ax+kU/7Y0=
Received: from BL1PR12MB5157.namprd12.prod.outlook.com (2603:10b6:208:308::15)
 by CY4PR1201MB0136.namprd12.prod.outlook.com (2603:10b6:910:1a::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5061.22; Tue, 15 Mar
 2022 21:34:45 +0000
Received: from BL1PR12MB5157.namprd12.prod.outlook.com
 ([fe80::692d:9532:906b:2b08]) by BL1PR12MB5157.namprd12.prod.outlook.com
 ([fe80::692d:9532:906b:2b08%5]) with mapi id 15.20.5081.014; Tue, 15 Mar 2022
 21:34:45 +0000
From:   "Limonciello, Mario" <Mario.Limonciello@amd.com>
To:     Robin Murphy <robin.murphy@arm.com>,
        Christoph Hellwig <hch@infradead.org>,
        "christian@kellner.me" <christian@kellner.me>,
        Mika Westerberg <mika.westerberg@linux.intel.com>
CC:     Michael Jamet <michael.jamet@intel.com>,
        "open list:THUNDERBOLT DRIVER" <linux-usb@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        Yehezkel Bernat <YehezkelShB@gmail.com>,
        "open list:AMD IOMMU (AMD-VI)" <iommu@lists.linux-foundation.org>,
        Andreas Noever <andreas.noever@gmail.com>,
        Will Deacon <will@kernel.org>
Subject: RE: [PATCH 2/2] thunderbolt: Use pre-boot DMA protection on AMD
 systems
Thread-Topic: [PATCH 2/2] thunderbolt: Use pre-boot DMA protection on AMD
 systems
Thread-Index: AQHYOIlZtJo3mK3DGEGeq+l4FbKrMqzAp92AgAABGzCAABUbgIAAB/CAgAAxs8A=
Date:   Tue, 15 Mar 2022 21:34:45 +0000
Message-ID: <BL1PR12MB51578AB77BB9632691105DE4E2109@BL1PR12MB5157.namprd12.prod.outlook.com>
References: <20220315162455.5190-1-mario.limonciello@amd.com>
 <20220315162455.5190-2-mario.limonciello@amd.com>
 <YjDDUUeZ/dvUZoDN@infradead.org>
 <BL1PR12MB5157D7B7734122684D47923AE2109@BL1PR12MB5157.namprd12.prod.outlook.com>
 <21d33a75-8c0e-7734-b3d1-dbe33cfe0ab0@arm.com>
 <7d588dfa-aa57-7be1-9cbb-61897f81bf99@amd.com>
In-Reply-To: <7d588dfa-aa57-7be1-9cbb-61897f81bf99@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2022-03-15T21:34:22Z;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=5ad6a501-fdd9-4c39-8c74-19a96c40dd80;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=1
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_enabled: true
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_setdate: 2022-03-15T21:34:43Z
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_method: Privileged
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_name: Public-AIP 2.0
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_actionid: 05ca9292-ce11-44af-ab7d-cf0edf3d66ea
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f38fd51e-d978-4b74-0c3d-08da06cb9fc9
x-ms-traffictypediagnostic: CY4PR1201MB0136:EE_
x-microsoft-antispam-prvs: <CY4PR1201MB0136B1DB2E17ABEF0E13A0CAE2109@CY4PR1201MB0136.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: nYn1zAaraDbKrmpYHT5mvt9oZhP3MGlsJS7ylocRkv1mR5T87ZzHU+3AF+SViYuihYYV3DCFEHVQpuCROSteTV2njiuxFDr94sbd0J+NfsbTaRc04Jn3GYgprjD8wA+uaJ0SB8Is5o/JAWe9b7WqlSx4Xfb94X27vFVUW0ehyEYRYbU3D3hVnblQzxSZfWafsILYvQLrsGFuQnpszD87j6h14Vmn51vdwkIgiiP//O7sZ7F3WpAchJZo0g89OEPZ6LDri/phSXV/RVyJJUl932H7swBOsl5ciXRf+8fmoYdLYE7A+pV2s8WWhLFBL9ZjAK6WJcnnoiHKimFPdm+v8DO1jsDwtmMFAzScoApZjIznXrKTwIClIKmjZyUiS1ElwbMM2wF3XxrYxlM6uxcgdDQsvdwwXBjudL4tTDbSwRA6uz1TNd7EmF+zRFn+CGiE27PWAeCTPIDRklIgNt29mRaoVkFAEw1OQMCFg8815VnOt2zx0PElK84vzltSCyc4Pd4HlNytWxxypcbPxpQhEGtOStQJuIVIVz4WSGMVz7/dyDh9MFGpkl2LCMXXN+hUwcVrphNylj2/B/D99EVkynph5LbU6wAQ8i1U5yD1ZGzztCTJrfaxl6W+A5luWNC/RQtnoB/zOlFbSIYiZ0K3c3UiWdA9rqTWRDAuRzj06lf7N8UgPlbjSXdlPhPOjAybyA5FEol2tgGzxcyrtgNvZP3CdC7vMm4k9cFRmXvmRGI6KdIvPofFjUF1rYvN4fyiqpWEA3NIbUCZatN88pTwSHqTr+FIsnYr8/Ek/Z4dOQRoeV3lC4CneIJUmwWssyJXPuBMxNw/Lb1NNPxIRfYXHA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5157.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(54906003)(110136005)(316002)(2906002)(33656002)(55016003)(66946007)(76116006)(38070700005)(508600001)(45080400002)(71200400001)(66476007)(52536014)(7416002)(966005)(5660300002)(8936002)(38100700002)(64756008)(122000001)(8676002)(4326008)(66446008)(66556008)(86362001)(9686003)(7696005)(6506007)(83380400001)(186003)(53546011);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ek12cmFzODNGZ0xFTm9mWGpiU2NqZ2J1VVk1bkRzakMrMElSaUpvT2dxb3BN?=
 =?utf-8?B?Y0hreEtIbG85aU1MZS9IOU81UGhqVlhqZWV6SEpVVGJjcEV0MUl4ZkVmaTAr?=
 =?utf-8?B?LzF3ZityS1dIdXRYR3loY0xheEZncFV0NURpeWNPYitJN0Faa21aNjJMbWY5?=
 =?utf-8?B?K3NvSHVrejFQWW5LZVBpUm1INS9uNysyMHFlcnBEMCtLbW1zTUMvY2RncWlk?=
 =?utf-8?B?ejBERDczYWQvdVBTbGpWTjFTSU5KTFBmbEZJajluYXUraGtlSnRwcVNBQVBB?=
 =?utf-8?B?ZHBNR3gxUDlGVElBcDN5bkZIeEVTcDlKdjhWaURveExzMGk1MThRaGpjeEZX?=
 =?utf-8?B?SmsxUDhFZnp4NEF2dEdPa0dZMlBEMUdMSm9BUEZCUERvMmd1OVVxd01hMy9L?=
 =?utf-8?B?a1IrMlVXRUhSR2crWjFKM3JZdmVRZWtqdFZuNEF0T3JJR0JoWEVQZTVGanpT?=
 =?utf-8?B?aERjd3I2WU5OdGYxRUdaeUhMQy9ZZ3NEbVNUSmxwbUpuSlBWWUp5cGk1Wndp?=
 =?utf-8?B?UG40dEJwbHFvSVlnNUVrWkxCa255dTdaWDMyRThhT2RZZkNTcWlpZWlSb2tr?=
 =?utf-8?B?T01CUDVSRWVvUHZPOTJCL0FJeVJTKzVPSDJ4OGRBeFdESldHd1ZyYUUzQmZQ?=
 =?utf-8?B?K0FKMmMxam5WbkhUOVNielF5ZGdEODZORzd5eUxJdjE1UldqMjZhYmZ6bUY0?=
 =?utf-8?B?RU9tTkp4blRCS2NvMndIL3RsdUhuTDIwcWtwbFRGVlMxSURxbUp6dEZFWmp0?=
 =?utf-8?B?MkFLdHNMWnRISzM0c1RYazF1amdxZk5Wc2sweERIWXBESkUyL2FoWnpRaEJv?=
 =?utf-8?B?OWt2WGNhYisvY0dlc2NRN1lzTzdRNWYzUm4vZmRNeXptbXdkbHJQUzlpbVFy?=
 =?utf-8?B?NXJZZ1E5V3pJSkVab1dQVGpNWXVzR2VVZElmbDJSVURxRHg4S2lKUVpHdkpH?=
 =?utf-8?B?UVpwdDJVUldZMUdsZW43WmkwZjNVb3AvQ2dkc0pBTWlqQlA3cHJnbzgyWXIv?=
 =?utf-8?B?eURWaWp6WlBiWEFlai91V2lxaEdtMk9kSGFWeVBleTg2QWx0cW5TbWZUTk1w?=
 =?utf-8?B?eW83aDR5RC9lMTgrYXFlRnB6WlhOU0s4QkFTNGNUWHNBQ1BoelY3UFdEdDZo?=
 =?utf-8?B?SXFUaWJiVDJpRGxYZ1ZubERVaGxHcnV2NFN5UUZqeURtUVkwYXhhQlp4ZU92?=
 =?utf-8?B?dVJCZ2tiQlozOU1uL2QvTnhEM3V0dWFNQlVQb3lxTk5NYWNtVnRPKzdXcFRq?=
 =?utf-8?B?MVovK0RseGpCTnpxUlVBMVFFdExFU3RJUWxwVmlwK1dvbHlPT1h2eC9BRnBH?=
 =?utf-8?B?WGpYWWxvYmtRS0xJUVE5ajZjY2wwQkVhZzFXbkFnb2JucHVJcEs1OVVXWm5F?=
 =?utf-8?B?RTgreFpwT0JqQTY2Zm9hcmJtSUt2T2JwNW1FVEZ0QW5WL3BXQ2UwYzVWQ3NN?=
 =?utf-8?B?Zyt4elk4VjZBWEovcGZ4cENxNDYzM1ZIOG1WcVpwOUFmbVU5SW8rRjQvK0t4?=
 =?utf-8?B?QW1CUnhqdXRMR21LcFZ1VGNwVWxNK0pSYmVuSDViYWd0Z0tObElDamFCQ0FJ?=
 =?utf-8?B?Y3F3a3c2MWJHK1ZjZ0srSmx0WENOSG1wK3RidE52OVlvUStRWituV0Zkb2dh?=
 =?utf-8?B?N0JtczkvWjN4RFlsUGw1ZE0wUG1ibDVEUksvT1RjeGpzVFdtTVUzaTZwSTJC?=
 =?utf-8?B?aWFHVWhnUStzN1p0d2RqUVBZN1h6YXFBaEhjYjdCa0ZTUkswazgyN2JyMHQv?=
 =?utf-8?B?elJSYTI5R3YyWXUzWlJLWTlZZG1sQWtJNGRVRkJjNUJjckJ0TXVMSzNZQk51?=
 =?utf-8?B?a3lESS9CU29QVEFkcHE5SlRxM1NJUVE3VnZxd0EycklGRDI4TC8xZTZqYmdo?=
 =?utf-8?B?WjZPbkt4YjEyVzBTdGR3T2lieFNCVEhDeUg4bTR0YnJwM04xY0FuZGNiQ1Ew?=
 =?utf-8?B?M0hJZXloa3d2ci85U1F0VkRWVWFsbmk3ZGduYWRuZWFuTmhablZJU2YzbUdz?=
 =?utf-8?B?NHVDaUJPdlo2MXZYNFcwSUt3eEhVc0xwcVlTVVVXTmJGdE5rWnZsVEI5elZ5?=
 =?utf-8?Q?YVGj1D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5157.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f38fd51e-d978-4b74-0c3d-08da06cb9fc9
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Mar 2022 21:34:45.3196
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jNR91JxuXViNP5V9SnfIYPCJl4dlIxSYKZ27I0JxRbcQtLjVdl+EIIRBLsmYPKfCwI6+Q+IHvtm7lOtiSrJyWQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR1201MB0136
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

W1B1YmxpY10NCg0KDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogTGlt
b25jaWVsbG8sIE1hcmlvDQo+IFNlbnQ6IFR1ZXNkYXksIE1hcmNoIDE1LCAyMDIyIDEzOjM2DQo+
IFRvOiBSb2JpbiBNdXJwaHkgPHJvYmluLm11cnBoeUBhcm0uY29tPjsgQ2hyaXN0b3BoIEhlbGx3
aWcNCj4gPGhjaEBpbmZyYWRlYWQub3JnPjsgY2hyaXN0aWFuQGtlbGxuZXIubWU7IE1pa2EgV2Vz
dGVyYmVyZw0KPiA8bWlrYS53ZXN0ZXJiZXJnQGxpbnV4LmludGVsLmNvbT4NCj4gQ2M6IE1pY2hh
ZWwgSmFtZXQgPG1pY2hhZWwuamFtZXRAaW50ZWwuY29tPjsgb3BlbiBsaXN0OlRIVU5ERVJCT0xU
DQo+IERSSVZFUiA8bGludXgtdXNiQHZnZXIua2VybmVsLm9yZz47IG9wZW4gbGlzdCA8bGludXgt
DQo+IGtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc+OyBZZWhlemtlbCBCZXJuYXQgPFllaGV6a2VsU2hC
QGdtYWlsLmNvbT47DQo+IG9wZW4gbGlzdDpBTUQgSU9NTVUgKEFNRC1WSSkgPGlvbW11QGxpc3Rz
LmxpbnV4LWZvdW5kYXRpb24ub3JnPjsNCj4gQW5kcmVhcyBOb2V2ZXIgPGFuZHJlYXMubm9ldmVy
QGdtYWlsLmNvbT47IFdpbGwgRGVhY29uDQo+IDx3aWxsQGtlcm5lbC5vcmc+DQo+IFN1YmplY3Q6
IFJlOiBbUEFUQ0ggMi8yXSB0aHVuZGVyYm9sdDogVXNlIHByZS1ib290IERNQSBwcm90ZWN0aW9u
IG9uIEFNRA0KPiBzeXN0ZW1zDQo+IA0KPiArIENocmlzdGlhbiBLZWxsbmVyIChCb2x0IHVzZXJz
cGFjZSBtYWludGFpbmVyKQ0KPiANCj4gT24gMy8xNS8yMDIyIDEzOjA3LCBSb2JpbiBNdXJwaHkg
d3JvdGU6DQo+ID4gT24gMjAyMi0wMy0xNSAxNjo1NCwgTGltb25jaWVsbG8sIE1hcmlvIHZpYSBp
b21tdSB3cm90ZToNCj4gPj4gW1B1YmxpY10NCj4gPj4NCj4gPj4NCj4gPj4+IE9uIFR1ZSwgTWFy
IDE1LCAyMDIyIGF0IDExOjI0OjU1QU0gLTA1MDAsIE1hcmlvIExpbW9uY2llbGxvIHdyb3RlOg0K
PiA+Pj4+IC3CoMKgwqDCoCAqIGhhbmRsZWQgbmF0aXZlbHkgdXNpbmcgSU9NTVUuIEl0IGlzIGVu
YWJsZWQgd2hlbiBJT01NVSBpcw0KPiA+Pj4+IC3CoMKgwqDCoCAqIGVuYWJsZWQgYW5kIEFDUEkg
RE1BUiB0YWJsZSBoYXMgRE1BUl9QTEFURk9STV9PUFRfSU4NCj4gc2V0Lg0KPiA+Pj4+ICvCoMKg
wqDCoCAqIGhhbmRsZWQgbmF0aXZlbHkgdXNpbmcgSU9NTVUuIEl0IGlzIGVuYWJsZWQgd2hlbiB0
aGUgSU9NTVUgaXMNCj4gPj4+PiArwqDCoMKgwqAgKiBlbmFibGVkIGFuZCBlaXRoZXI6DQo+ID4+
Pj4gK8KgwqDCoMKgICogQUNQSSBETUFSIHRhYmxlIGhhcyBETUFSX1BMQVRGT1JNX09QVF9JTiBz
ZXQNCj4gPj4+PiArwqDCoMKgwqAgKiBvcg0KPiA+Pj4+ICvCoMKgwqDCoCAqIEFDUEkgSVZSUyB0
YWJsZSBoYXMgRE1BX1JFTUFQIGJpdHNldA0KPiA+Pj4+IMKgwqDCoMKgwqDCoCAqLw0KPiA+Pj4+
IMKgwqDCoMKgwqAgcmV0dXJuIHNwcmludGYoYnVmLCAiJWRcbiIsDQo+ID4+Pj4gLcKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqAgaW9tbXVfcHJlc2VudCgmcGNpX2J1c190eXBlKSAmJg0KPiA+
Pj4gZG1hcl9wbGF0Zm9ybV9vcHRpbigpKTsNCj4gPj4+PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoCBpb21tdV9wcmVzZW50KCZwY2lfYnVzX3R5cGUpICYmDQo+ID4+Pj4gK8KgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqAgKGRtYXJfcGxhdGZvcm1fb3B0aW4oKSB8fCBhbWRfaXZyc19y
ZW1hcF9zdXBwb3J0KCkpKTsNCj4gPj4+DQo+ID4+PiBZaWtlcy7CoCBObywgdGhlIHRodW5kZXJi
b3QgY29kZSBkb2VzIG5vdCBoYXZlIGFueSBidXNpbmVzcyBwb2tpbmcgaW50bw0KPiA+Pj4gZWl0
aGVyIGRtYXJfcGxhdGZvcm1fb3B0aW4gb3IgYW1kX2l2cnNfcmVtYXBfc3VwcG9ydC7CoCBUaGlz
IG5lZWRzDQo+ID4+PiBhIHByb3BlciBhYnN0cmF0aW9uIGZyb20gdGhlIElPTU1VIGNvZGUuDQo+
ID4+DQo+ID4+IFRvIG1ha2Ugc3VyZSBJIGZvbGxvdyB5b3VyIGFzayAtIGl0J3MgdG8gbWFrZSBh
IG5ldyBnZW5lcmljIGlvbW11DQo+ID4+IGZ1bmN0aW9uDQo+ID4+IFRoYXQgd291bGQgY2hlY2sg
ZG1hci9pdnJzLCBhbmQgc3dpdGNoIG91dCB0aHVuZGVyYm9sdCBkb21haW4uYyB0byB1c2UNCj4g
Pj4gdGhlDQo+ID4+IHN5bWJvbD8NCj4gPj4NCj4gPj4gSSdtIGhhcHB5IHRvIHJld29yayB0aGF0
IGlmIHRoYXQgaXMgd2hhdCB5b3Ugd2FudC4NCj4gPj4gRG8geW91IGhhdmUgYSBwcmVmZXJyZWQg
cHJvcG9zZWQgZnVuY3Rpb24gbmFtZSBmb3IgdGhhdD8NCj4gPg0KPiA+IEJ1dCB3aHk/IEVpdGhl
ciBJT01NVSB0cmFuc2xhdGlvbiBpcyBlbmFibGVkIG9yIGl0IGlzbid0LCBhbmQgaWYgaXQgaXMs
DQo+ID4gd2hhdCdzIHRvIGdhaW4gZnJvbSBndWVzc2luZyBhdCAqd2h5KiBpdCBtaWdodCBoYXZl
IGJlZW4/IEFuZCBldmVuIGlmDQo+ID4gdGhlIElPTU1VJ3MgZmlybXdhcmUgdGFibGUgZGlkIHRl
bGwgdGhlIElPTU1VIGRyaXZlciB0byBlbmFibGUgdGhlDQo+ID4gSU9NTVUsIHdoeSBzaG91bGQg
dGhhdCBiZSBUaHVuZGVyYm9sdCdzIGJ1c2luZXNzPw0KPiBBIGxvdCBvZiB0aGlzIGNvbWVzIGZy
b20gYmFnZ2FnZSBmcm9tIGVhcmx5IFRodW5kZXJib2x0IDMgaW1wbGVtZW50YXRpb24NCj4gb24g
c3lzdGVtcyB3aXRoIElDTSAoSW50ZWwncyBGVyBDTSkuIE9uIHRob3NlIHN5c3RlbXMgdGhlcmUg
d2FzIGENCj4gY29uY2VwdCBvZiAiU2VjdXJpdHkgTGV2ZWxzIi4gIFRoaXMgbWVhbnQgdGhhdCBk
b3duc3RyZWFtIFBDSWUgZGV2aWNlcw0KPiB3ZXJlIG5vdCBhdXRvbWF0aWNhbGx5IGF1dGhvcml6
ZWQgd2hlbiBhIFRCVDMgZGV2aWNlIHdhcyBwbHVnZ2VkIGluLiAgSW4NCj4gdGhvc2UgY2FzZXMg
dGhlcmUgd2FzIG5vIGd1YXJhbnRlZSB0aGF0IHRoZSBJT01NVSB3YXMgaW4gdXNlIGFuZCBzbyB0
aGUNCj4gc2VjdXJpdHkgd2FzIHBhc3NlZCBvbiB0byB0aGUgdXNlciB0byBtYWtlIGEgZGVjaXNp
b24uDQo+IA0KPiBJbiBMaW51eCB0aGlzIHdhcyBhY2NvbXBsaXNoZWQgdXNpbmcgdGhlICdhdXRo
b3JpemVkJyBhdHRyaWJ1dGUgaW4NCj4gL3N5cy9idXMvdGh1bmRlcmJvbHQvZGV2aWNlcy8kTlVN
L2F1dGhvcml6ZWQuICBXaGVuIHRoaXMgd2FzIHNldCB0byAxDQo+IHRoZW4gdGhlIFRCVDMgZGV2
aWNlIGFuZCBQQ0llIHRvcG9sb2d5IGJlaGluZCBpdCB3b3VsZCBiZSBlbnVtZXJhdGVkLg0KPiAN
Cj4gRnVydGhlciBkb2N1bWVudGF0aW9uIGV4cGxhaW5pbmcgaG93IHRoaXMgd29ya3MgaXMgYXZh
aWxhYmxlIGhlcmU6DQo+IGh0dHBzOi8vd3d3Lmtlcm5lbC5vcmcvZG9jL2h0bWwvbGF0ZXN0L2Fk
bWluLQ0KPiBndWlkZS90aHVuZGVyYm9sdC5odG1sI3NlY3VyaXR5LWxldmVscy1hbmQtaG93LXRv
LXVzZS10aGVtDQo+IA0KPiAoSW50ZWwgYmFzZWQpIFBsYXRmb3JtcyBmcm9tIDIwMTgrIHcvIFRC
VDMgc3RhcnRlZCB0byB1c2UgdGhlIElPTU1VDQo+IGNvbnNpc3RlbnRseSBhdCBydW50aW1lIGJ1
dCBoYWQgdGhpcyBleGlzdGluZyBpbXBsZW1lbnRhdGlvbiBvZiBzZWN1cml0eQ0KPiBsZXZlbHMg
dG8gd29ycnkgYWJvdXQuICBGdXJ0aGVybW9yZSB0dW5uZWxzIGNvdWxkIGJlIGNyZWF0ZWQgcHJl
LWJvb3QsDQo+IGFuZCBzbyB0aGUgdGh1bmRlcmJvbHQgZHJpdmVyIG1heSBvciBtYXkgbm90IHJl
LWNyZWF0ZSB0aGVtIGJhc2VkIG9uDQo+IHBvbGljeS4NCj4gDQo+IFNvIGEgbmV3IGF0dHJpYnV0
ZSB3YXMgY3JlYXRlZCAiaW9tbXVfZG1hX3Byb3RlY3Rpb24iIHRoYXQgdXNlcnNwYWNlDQo+IGNv
dWxkIHVzZSBhcyBwYXJ0IG9mIGEgcG9saWN5IGRlY2lzaW9uIHRvIGF1dG9tYXRpY2FsbHkgYXV0
aG9yaXplDQo+IGRldmljZXMuICBFeHBvcnRpbmcgdGhpcyBhdHRyaWJ1dGUgaXMgdmVyeSBzaW1p
bGFyIHRvIHdoYXQgTWljcm9zb2Z0DQo+IGRvZXMgdG8gbGV0IHRoZSB1c2VyIHNlZSB0aGUgc2Vj
dXJpdHkgb2YgdGhlIHN5c3RlbS4NCj4gDQo+IGh0dHBzOi8vZG9jcy5taWNyb3NvZnQuY29tL2Vu
LXVzL3dpbmRvd3MtaGFyZHdhcmUvZGVzaWduL2RldmljZS0NCj4gZXhwZXJpZW5jZXMvb2VtLWtl
cm5lbC1kbWEtcHJvdGVjdGlvbg0KPiANCj4gSW4gTGludXggdG9kYXkgc29tZSB1c2Vyc3BhY2Ug
c29mdHdhcmUgImJvbHQiIGhhcyBhIHBvbGljeSBpbmNsdWRlZCBieQ0KPiBkZWZhdWx0IHRoYXQg
d2lsbCBhdXRvbWF0aWNhbGx5IGF1dGhvcml6ZSBUQlQzIGFuZCBVU0I0ICh3LyBQQ0llKQ0KPiBk
ZXZpY2VzIHdoZW4gaW9tbXVfZG1hX3Byb3RlY3Rpb24gaXMgc2V0IHRvIDEuDQo+IA0KPiA+DQo+
ID4gRnVydGhlcm1vcmUsIGxvb2tpbmcgYXQgcGF0Y2ggIzEgSSBjYW4gb25seSBjb25jbHVkZSB0
aGF0IHRoaXMgaXMNCj4gPiBlbnRpcmVseSBtZWFuaW5nbGVzcyBhbnl3YXkuIEFGQUlDUyBpdCdz
IGxpdGVyYWxseSByZXBvcnRpbmcgd2hldGhlciB0aGUNCj4gPiBmaXJtd2FyZSBmbGFnIHdhcyBz
ZXQgb3Igbm90LiBOb3Qgd2hldGhlciBpdCdzIGFjdHVhbGx5IGJlZW4gaG9ub3VyZWQNCj4gPiBh
bmQgdGhlIElPTU1VIGlzIGVuZm9yY2luZyBhbnkga2luZCBvZiBETUEgcHJvdGVjdGlvbiBhdCBh
bGwuIEV2ZW4gb24NCj4gPiBJbnRlbCB3aGVyZSB0aGUgZmxhZyBkb2VzIGF0IGxlYXN0IGhhdmUg
c29tZSBlZmZlY3Qgb24gdGhlIElPTU1VIGRyaXZlciwNCj4gPiB0aGF0IGNhbiBzdGlsbCBiZSBv
dmVycmlkZGVuLg0KPiANCj4gVGFrZSBhIGxvb2sgYXQgdGhlIE1pY3Jvc29mdCBsaW5rIEkgc2hh
cmVkIGFib3ZlLiAgVGhleSBhbHNvIG1ha2UgcG9saWN5DQo+IGRlY2lzaW9ucyBiYXNlZCBvbiB0
aGUgaW5mb3JtYXRpb24gaW4gdGhlc2UgdGFibGVzLg0KPiANCj4gPg0KPiA+IEkgYWxyZWFkeSBo
YXZlIGEgcGF0Y2ggcmVmYWN0b3JpbmcgdGhpcyB0byBnZXQgcmlkIG9mIGlvbW11X3ByZXNlbnQo
KSwNCj4gPiBidXQgYXQgdGhlIHRpbWUgSSB3YXNuJ3QgbG9va2luZyB0byBjbG9zZWx5IGF0IHdo
YXQgaXQncyB0cnlpbmcgdG8gKmRvKg0KPiA+IHdpdGggdGhlIGluZm9ybWF0aW9uLiBJZiBpdCdz
IHN1cHBvc2VkIHRvIGFjY3VyYXRlbHkgcmVmbGVjdCB3aGV0aGVyIHRoZQ0KPiA+IFRodW5kZXJi
b2x0IGRldmljZSBpcyBzdWJqZWN0IHRvIElPTU1VIHRyYW5zbGF0aW9uIGFuZCBub3QgYnlwYXNz
ZWQsIEkNCj4gPiBjYW4gZml4IHRoYXQgdG9vIChhbmQgdW5leHBvcnQgZG1hcl9wbGF0Zm9ybV9v
cHRpbigpIGluIHRoZSBwcm9jZXNzLi4uKQ0KPiA+DQo+ID4gUm9iaW4uDQo+IA0KPiBUaGlzIHBh
dGNoIHNlcmllcyBzdGVtcyBmcm9tIHRoYXQgaGlzdG9yeS4gIFRvIGdpdmUgdGhlIGJlc3QgZXhw
ZXJpZW5jZQ0KPiB0byBlbmQgdXNlcnMgeW91IHdhbnQgaG90cGx1Z2dlZCBkZXZpY2VzIHRvIGJl
IGF1dG9tYXRpY2FsbHkgYXV0aG9yaXplZA0KPiB3aGVuIHNvZnR3YXJlIHNheXMgaXQncyBzYWZl
IHRvIGRvIHNvLg0KPiANCj4gVG8gc3VtbWFyaXplIHRoZSBmbG93Og0KPiAqIFVzZXIgcGx1Z3Mg
aW4gZGV2aWNlDQo+ICogVVNCNCBDTSB3aWxsIHF1ZXJ5IHN1cHBvcnRlZCB0dW5uZWxzDQo+ICog
VVNCNCBDTSB3aWxsIGNyZWF0ZSBkZXZpY2VzIGluIC9zeXMvYnVzL3RodW5kZXJib2x0L2Rldmlj
ZXMgZm9yIG5ldw0KPiBwbHVnZ2VkIGluIFRCVDMvVVNCNCBkZXZpY2UNCj4gKiAiYXV0aG9yaXpl
ZCIgYXR0cmlidXRlIHdpbGwgZGVmYXVsdCB0byAiMCIgYW5kIFBDSWUgdHVubmVscyBhcmUgbm90
DQo+IGNyZWF0ZWQNCj4gKiBVc2Vyc3BhY2UgZ2V0cyBhIHVldmVudCB0aGF0IHRoZSBkZXZpY2Ug
d2FzIGFkZGVkDQo+ICogVXNlcnNwYWNlIChib2x0KSByZWFjdHMgYnkgcmVhZGluZw0KPiAvc3lz
L2J1cy90aHVuZGVyYm9sdC9kZXZpY2VzL2RvbWFpblgvaW9tbXVfZG1hX3Byb3RlY3Rpb24NCj4g
KiBJZiB0aGF0IGlzIHNldCB0byAiMSIsIGJvbHQgd2lsbCB3cml0ZSAiMSIgdG8gImF1dGhvcml6
ZWQiICBhbmQgVVNCNA0KPiBDTSB3aWxsIGNyZWF0ZSBQQ0llIHR1bm5lbHMNCj4gKiBJZiB0aGF0
IGlzIHNldCB0byAiMCIsIGJvbHQgd2lsbCBzZW5kIGFuIGV2ZW50IHRvIEdVSSB0byBzaG93IGEg
cG9wdXANCj4gYXNraW5nIHRvIGF1dGhvcml6ZSB0aGUgZGV2aWNlDQo+ICogQWZ0ZXIgdXNlciBh
Y2tzIHRoZSBhdXRob3JpemF0aW9uIHRoZW4gaXQgd2lsbCB3cml0ZSAiMSIgdG8NCj4gImF1dGhv
cml6ZWQiIGFuZCBVU0I0IENNIHdpbGwgY3JlYXRlIFBDSWUgdHVubmVscw0KPiANCj4gDQo+IE1p
a2EsDQo+IA0KPiBJIHdvbmRlciBpZiBtYXliZSB3aGF0IHdlIHJlYWxseSB3YW50IGlzIHRvIG9u
bHkgdXNlIHRoYXQgZmxvdyBmb3IgdGhlDQo+IGF1dGhvcml6ZWQgYXR0cmlidXRlIHdoZW4gdXNp
bmcgVEJUMyArIElDTSAob3IgSU9NTVUgZGlzYWJsZWQgYXQNCj4gcnVudGltZSkuICBJZiB3ZSdy
ZSB1c2luZyBhIFVTQjQgaG9zdCwgY2hlY2sgSU9NTVUgdHJhbnNsYXRpb24gbGF5ZXINCj4gYWN0
aXZlIGxpa2UgUm9iaW4gc3VnZ2VzdGVkIGFuZCB0aGVuIGF1dG9tYXRpY2FsbHkgYXV0aG9yaXpl
IGZyb20gdGhlIENNLg0KPiANCj4gVGhvdWdodHM/DQo+IA0KPg0KIA0KSSBwdXQgYW4gUkZDIHRv
Z2V0aGVyIHdpdGggd2hhdCB0aGlzIGlkZWEgbG9va3MgbGlrZSwgY29tbWVudHMgd2VsY29tZS4N
Cmh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2xpbnV4LXVzYi8yMDIyMDMxNTIxMzAwOC41MzU3LTEt
bWFyaW8ubGltb25jaWVsbG9AYW1kLmNvbS9ULyN1DQo=
