Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 772AA4E2769
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Mar 2022 14:21:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347827AbiCUNWo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Mar 2022 09:22:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244257AbiCUNWm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 09:22:42 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2083.outbound.protection.outlook.com [40.107.236.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CE7F66213;
        Mon, 21 Mar 2022 06:21:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Pms2GVqw5ZmrHhVcFe31NmwTdpIv4FgyXFBWL9vyTH32O3utjOHBnLEENOkfXOpMy0UY5K8PdbEa/1LPFjWBegcIo/eLdQqZY2gkU7DoY4WHFftTPhfjLdtVLfVVnBrrvH+HAka8IO40QSCSzlQ3fnQAZXExSr1OdMVGWlPfAfjGcV2v57AtvrOkeQ9FXGoerR3xk9FarWE58u38RjoBvCN3XAEg8D7gYugTugUftPFatKKELRTlckED2Py3b049hvPFkDewNDLz/xLniNsgGhcmxMChvbAdrIsDCX8X/LH5rkumpYu0Sv/mT+hSttCrgncqXoVfuTrX1yFlqSuPBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LV5+Af7517RVVFlSS2v6pLEQNYf2vCKGB4CbYBqXaqM=;
 b=bvoyOmN+NW6ztkC8UTSzGjZxZJLplCNuY2uGNOlfHeMLJs3pJBZhPJrL/aS4aXNdzFnbi5Zym+tuh5g7QLjCiM7OZBf7VN5amEWF0GrwQKratEe1b3vhR7g4PipAtFK1ckD8o6NFtu1MXw3TVKt3V9Z7rLJfLdXGyENsHJC0gAnWwJz/ayrulTWF80v8w5RkkD/MXMRCUEe+r3RAo3EUpJXdTgmco+HIUL8hovQ3X0+gZ3UkzB1zoZorogYAVfH1grq5jLPDPAIybjKopUlvorhxRZWoYQwow3MqSRXamRJ82keyfMLDGyVQp1R7XpvSgo5XuYYW8zLXLsyES3FP8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LV5+Af7517RVVFlSS2v6pLEQNYf2vCKGB4CbYBqXaqM=;
 b=1PAr0S3jvvZ4oeljbnwqSwIAqgkVXrCFxqZKAfyx66GD4LVPZpF5CMpex9es/b/C2P1b1kdv3EDVW4xIJOB94W/qmUosh9S7OgNOSci29P07o3GJnLy3dmy5hNBKrNUS9fbMeUgVUAqaqB7mdh4Cawr/E6ONs+geftMws7WOGtg=
Received: from BL1PR12MB5157.namprd12.prod.outlook.com (2603:10b6:208:308::15)
 by SN6PR12MB2701.namprd12.prod.outlook.com (2603:10b6:805:6f::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5081.18; Mon, 21 Mar
 2022 13:21:14 +0000
Received: from BL1PR12MB5157.namprd12.prod.outlook.com
 ([fe80::692d:9532:906b:2b08]) by BL1PR12MB5157.namprd12.prod.outlook.com
 ([fe80::692d:9532:906b:2b08%5]) with mapi id 15.20.5081.023; Mon, 21 Mar 2022
 13:21:12 +0000
From:   "Limonciello, Mario" <Mario.Limonciello@amd.com>
To:     Robin Murphy <robin.murphy@arm.com>,
        "mika.westerberg@linux.intel.com" <mika.westerberg@linux.intel.com>
CC:     "joro@8bytes.org" <joro@8bytes.org>,
        "baolu.lu@linux.intel.com" <baolu.lu@linux.intel.com>,
        "andreas.noever@gmail.com" <andreas.noever@gmail.com>,
        "michael.jamet@intel.com" <michael.jamet@intel.com>,
        "YehezkelShB@gmail.com" <YehezkelShB@gmail.com>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "hch@lst.de" <hch@lst.de>
Subject: RE: [PATCH v2 2/2] thunderbolt: Make iommu_dma_protection more
 accurate
Thread-Topic: [PATCH v2 2/2] thunderbolt: Make iommu_dma_protection more
 accurate
Thread-Index: AQHYOu+lUdyxWySMNUuJeS+suvjzA6zFr+rwgAP/aQCAAAOwAIAAI47Q
Date:   Mon, 21 Mar 2022 13:21:12 +0000
Message-ID: <BL1PR12MB515731B8F62C45156037CF8CE2169@BL1PR12MB5157.namprd12.prod.outlook.com>
References: <cover.1647624084.git.robin.murphy@arm.com>
 <0dd14883930c9f55ace22162e23765a37d91a057.1647624084.git.robin.murphy@arm.com>
 <DM4PR12MB51683722CF9A553563D0C721E2139@DM4PR12MB5168.namprd12.prod.outlook.com>
 <YjhaViFzmEjBgmmu@lahna> <fd86c2cf-3068-1bea-2a6f-46cabb019062@arm.com>
In-Reply-To: <fd86c2cf-3068-1bea-2a6f-46cabb019062@arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2022-03-21T13:19:53Z;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=f31c7994-a437-426b-859f-969cdcc67817;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=1
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_enabled: true
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_setdate: 2022-03-21T13:21:11Z
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_method: Privileged
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_name: Public-AIP 2.0
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_actionid: 2e276c30-4fbc-4d1d-a66b-d1a1f8804847
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d42ae7ac-060b-4753-8b66-08da0b3dabd1
x-ms-traffictypediagnostic: SN6PR12MB2701:EE_
x-microsoft-antispam-prvs: <SN6PR12MB2701D623F2226ECE4969E809E2169@SN6PR12MB2701.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: nkbo5iW432hz+wGMSUIjvEfDmREDfigHhKBUFyb4ZtSDY00gVU8kaaqMIZ6i7Ay/SerL60Lwrx9Q2x+s7zQRjxKXeNnUxeJ+VO04EXAP7CD3A+o13uvpGODaGn17tNoKx0qBJP2UDwH4Qy2QKx+PFQ8JiA3Kzu3xUeJ+qsjMqXhgzM7l17Xpmo03agSXhPXa7/Zgw1lget9FeAmyygZo2LTc6FVRerMmq1Cc3Mdvld9VJxyjVj+fxg7gIQUdRFNjfzkeqS1V7eZi8NX7zU0Z88vXSFPHtcZSkAUKlU2nV9OMlGzoWJ9CpLDd0UrsdTr0+vc8/UXB617NksykOpRktnoJo5CeyF8QEPlfTTL1KEVRwZzEAeyvygPYgtZk3BWBkNaEA4xzAoRboOH9AI8cmHqtxKVWPSnCVPC6B+AYMPDf+aX4PuO+hyM5bE/rVswkBVUmyzHdh1hrgysFBpJh8AZET3mrQAovtYw8lnxFY/VtUb7rUWmLfXWfJ3WZINfCx9ZXt+i+eZ7DidGdBTBmsiHBsKqqW/EYUu/mK8UR9CJOKg0NNU/7V1RS6luwQSI7WhxFrm2zXct1acgoU5oqWnltw9+yp6Yy562vASpqhEYv1SNFsFood5ie5ueJoWcqypr1tueD0FHXpdvzMvjee3UphjPnAKxFI5Uk/ip+jPFQKnu9LSYzjxMfHRQka2Jubct492b78bQwp8kx5ZMJzQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5157.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(83380400001)(66476007)(66446008)(66556008)(316002)(64756008)(4326008)(71200400001)(54906003)(110136005)(76116006)(38070700005)(66946007)(8676002)(9686003)(86362001)(8936002)(186003)(2906002)(508600001)(5660300002)(52536014)(55016003)(38100700002)(122000001)(7416002)(7696005)(33656002)(6506007)(53546011);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZUIrb1o1UEZNbjY2WkxBUlBORXoyNTZJY095TDJUcGRkbmtRT2t3SmRSZ3BK?=
 =?utf-8?B?YlZKK0JsUThUZjdtQ1ZUWXpUSFZYMloydXNZMENPNTNnM3E2TENuMUhhNDZQ?=
 =?utf-8?B?UHFUZU9uOGZweUtDUVU2cUcxeDZjOTFoSDAzbE45Q21FTW9Xd0ZQNTdMWUFI?=
 =?utf-8?B?ekJBOWYzeU5kUCtTenluSitxbGdkbnhGZkhMV1pnM3dmcFphUmJQc1F4cTY2?=
 =?utf-8?B?Qk9Edm5tWmNBVnUzNTBBUlJGNCtjbUR4dHo2end2eVBvazJYWGUrcmM4Zmhs?=
 =?utf-8?B?TW1SSldkTmxhSElDUkRvdVVtaVo2ZCs2MHhya1BUTDNCeVpYd04vRXBZT2tx?=
 =?utf-8?B?UTNYVEtJdHJMV1E2bXRYalh4bVNlczFFM280aUlyMXpYUnNVcmxNZFJpeHBB?=
 =?utf-8?B?RjdUOTVTRmN2WUlXaHh1dVFlVDBlWXlJVVVDZ2VRVE5BM0lYdlordlk3QVV6?=
 =?utf-8?B?bHp4WXhEZUl2R0hHUW4wdU94S05vT04wZkdBelVuRms5SFVtb0VPc3hZcUJK?=
 =?utf-8?B?eWFxdjRkbXNqYjJsaTVERDlJV0FKemdRUTcwUUcyNE5RbUp6bzV2N2ZjalFK?=
 =?utf-8?B?Vlo1aDJIcHNKeU5sOHk4YW8vUThBSjBqdnZPTVF4NzgzVktZRlpyeVFueVhH?=
 =?utf-8?B?WmE2eTdESUR3ODlvaGF2a3ovQlplclQzeUI4MzFJSzZnYkZBdHh4SE5pSGhr?=
 =?utf-8?B?SzhMcWhqR0hvakUyUUM3YzZwdUphUjB2RDNkTlFPZzdVZzJkV1ZkM3I3WVBv?=
 =?utf-8?B?eitjQlVHa0M3MjdxUUZMRmhmeWxxRkJHTU1DMkFrZGFOeFI5VURhd0E1dTFJ?=
 =?utf-8?B?alM5R1VTZ0YvYjZLeTJ1SURNbnBzeWZ5TXRDS0h1SVJGMEJRamxoam00VTAw?=
 =?utf-8?B?c3BpeWNGeUFacERCQVpQQWNKY1dpelBkK0pzcXNFeEFxUUdNY3BSTERSN2I5?=
 =?utf-8?B?Wk1GVGc1Qnhad2ZidGRianZlak4rTW81a2M5b3dhaEJGSXFWdFl0TEVrc1gw?=
 =?utf-8?B?NjlsLzJ3U2M1Mk9oTnczcVNKeThSTGxvQTJ0cWxYRTIzalVxZlY4VFR1cTlS?=
 =?utf-8?B?TEl4YkxJLzhWN09yRDB6R21aSWx6a3ppKzB0L3h3NVlEdGppV29UV1VlVXRC?=
 =?utf-8?B?UDFzOFdWWmowUThoYjBKYmJFTnRSSDRtTk40MkxYWmhQc1BMa1NuTkZnTFEy?=
 =?utf-8?B?WFl5aEJVWGU2NkFjaDQ4Y1ZXbW5zVmlxREFia3VTdnZrZXh1Nmc4dlF5K0hI?=
 =?utf-8?B?VmphTWgwVVFHdDVJL0lkTkllaTcrZGhXWndQZy9JajZpZWw0SmFCNG83WlA0?=
 =?utf-8?B?V0IwZnI2dUo1ajVjcU53d1NBVXJydEpJa2dta3JUWmJDRUdPdHZFdUd3Mm9E?=
 =?utf-8?B?aVdCSmhnOFBtQWs1MVVZT0VMWVQ0eHc0ZnAzQ21rMWk0WmtPL1dCL0J0c2pJ?=
 =?utf-8?B?cjRTS3JkeEVDVE5FT21iRWN5MG1kMjdZbER4QkJjSmpHeSsrQWMrbHU3dlgx?=
 =?utf-8?B?U1pNL1BsQkpTejRtS1VNaFFPWEcyejZEdUNmS0Y0TCtwT093c3NPKzYwdkhs?=
 =?utf-8?B?a0N6UGQwbEptU2wraG5wNnlsb2RlWGR4eVp3d3Q3L2lQN25sY0ZkTzFkV1Rv?=
 =?utf-8?B?RU5ScjZCNWxkaTRDSGt5dHB3clp4WlNUK3RKdmc3d1RkMkdQSS9xSEt2VnQ2?=
 =?utf-8?B?ckxTN2JMSmhwREdreTArdHZmVXNCT1FiTkZzeFhXcFNUK3dGZGg4U05uS0FE?=
 =?utf-8?B?T0lRSitobVQvaTdiQVIrbTBaaTM5TzNGbVMwQzJ4YTI1Uy9DL2dEMlRlNG1j?=
 =?utf-8?B?RmhqNWZOZ2dEZjIwUzhwVzgxMFJPT3hIejdEaEI2eXN5bU03a0syODlMTGV4?=
 =?utf-8?B?Y3BiMFZ3STU2c0p5SjlvWnhqK2ZhUlFXVitReXdQUFhBcmRJQi8waVdqckIw?=
 =?utf-8?B?RkU2WW5hcTQ0azIrZlhGT0JtUDZNM2tCbWZpMGl6Z0dCK000V0xHYTlWZHlL?=
 =?utf-8?Q?aPpcv6TasVXB4CLI4oxmlSyRZnQmk0=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5157.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d42ae7ac-060b-4753-8b66-08da0b3dabd1
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Mar 2022 13:21:12.7862
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: L7Pr3qn8w/5mHk/R5qI+LiTPy2F++x+4V4I/4IHOWxIO3sEz0hTy9wb90uV7tW2aZLrsUg/7ahayXzky8bsgXA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB2701
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

W1B1YmxpY10NCg0KDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogUm9i
aW4gTXVycGh5IDxyb2Jpbi5tdXJwaHlAYXJtLmNvbT4NCj4gU2VudDogTW9uZGF5LCBNYXJjaCAy
MSwgMjAyMiAwNjoxMg0KPiBUbzogbWlrYS53ZXN0ZXJiZXJnQGxpbnV4LmludGVsLmNvbTsgTGlt
b25jaWVsbG8sIE1hcmlvDQo+IDxNYXJpby5MaW1vbmNpZWxsb0BhbWQuY29tPg0KPiBDYzogam9y
b0A4Ynl0ZXMub3JnOyBiYW9sdS5sdUBsaW51eC5pbnRlbC5jb207IGFuZHJlYXMubm9ldmVyQGdt
YWlsLmNvbTsNCj4gbWljaGFlbC5qYW1ldEBpbnRlbC5jb207IFllaGV6a2VsU2hCQGdtYWlsLmNv
bTsgaW9tbXVAbGlzdHMubGludXgtDQo+IGZvdW5kYXRpb24ub3JnOyBsaW51eC11c2JAdmdlci5r
ZXJuZWwub3JnOyBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnOw0KPiBoY2hAbHN0LmRlDQo+
IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjIgMi8yXSB0aHVuZGVyYm9sdDogTWFrZSBpb21tdV9kbWFf
cHJvdGVjdGlvbg0KPiBtb3JlIGFjY3VyYXRlDQo+IA0KPiBPbiAyMDIyLTAzLTIxIDEwOjU4LCBt
aWthLndlc3RlcmJlcmdAbGludXguaW50ZWwuY29tIHdyb3RlOg0KPiA+IEhpIE1hcmlvLA0KPiA+
DQo+ID4gT24gRnJpLCBNYXIgMTgsIDIwMjIgYXQgMTA6Mjk6NTlQTSArMDAwMCwgTGltb25jaWVs
bG8sIE1hcmlvIHdyb3RlOg0KPiA+PiBbUHVibGljXQ0KPiA+Pg0KPiA+Pj4gQmV0d2VlbiBtZSB0
cnlpbmcgdG8gZ2V0IHJpZCBvZiBpb21tdV9wcmVzZW50KCkgYW5kIE1hcmlvIHdhbnRpbmcgdG8N
Cj4gPj4+IHN1cHBvcnQgdGhlIEFNRCBlcXVpdmFsZW50IG9mIERNQVJfUExBVEZPUk1fT1BUX0lO
LCBzY3J1dGlueSBoYXMNCj4gPj4+IHNob3duDQo+ID4+PiB0aGF0IHRoZSBpb21tdV9kbWFfcHJv
dGVjdGlvbiBhdHRyaWJ1dGUgaXMgYmVpbmcgZmFyIHRvbyBvcHRpbWlzdGljLg0KPiA+Pj4gRXZl
biBpZiBhbiBJT01NVSBtaWdodCBiZSBwcmVzZW50IGZvciBzb21lIFBDSSBzZWdtZW50IGluIHRo
ZQ0KPiBzeXN0ZW0sDQo+ID4+PiB0aGF0IGRvZXNuJ3QgbmVjZXNzYXJpbHkgbWVhbiBpdCBwcm92
aWRlcyB0cmFuc2xhdGlvbiBmb3IgdGhlIGRldmljZShzKQ0KPiA+Pj4gd2UgY2FyZSBhYm91dC4g
RnVydGhlcm1vcmUsIGFsbCB0aGF0IERNQVJfUExBVEZPUk1fT1BUX0lOIHJlYWxseQ0KPiBkb2Vz
DQo+ID4+PiBpcyB0ZWxsIHVzIHRoYXQgbWVtb3J5IHdhcyBwcm90ZWN0ZWQgYmVmb3JlIHRoZSBr
ZXJuZWwgd2FzIGxvYWRlZCwgYW5kDQo+ID4+PiBwcmV2ZW50IHRoZSB1c2VyIGZyb20gZGlzYWJs
aW5nIHRoZSBpbnRlbC1pb21tdSBkcml2ZXIgZW50aXJlbHkuIFdoaWxlDQo+ID4+PiB0aGF0IGxl
dHMgdXMgYXNzdW1lIGtlcm5lbCBpbnRlZ3JpdHksIHdoYXQgbWF0dGVycyBmb3IgYWN0dWFsIHJ1
bnRpbWUNCj4gPj4+IERNQSBwcm90ZWN0aW9uIGlzIHdoZXRoZXIgd2UgdHJ1c3QgaW5kaXZpZHVh
bCBkZXZpY2VzLCBiYXNlZCBvbiB0aGUNCj4gPj4+ICJleHRlcm5hbCBmYWNpbmciIHByb3BlcnR5
IHRoYXQgd2UgZXhwZWN0IGZpcm13YXJlIHRvIGRlc2NyaWJlIGZvcg0KPiA+Pj4gVGh1bmRlcmJv
bHQgcG9ydHMuDQo+ID4+Pg0KPiA+Pj4gSXQncyBwcm92ZW4gY2hhbGxlbmdpbmcgdG8gZGV0ZXJt
aW5lIHRoZSBhcHByb3ByaWF0ZSBwb3J0cyBhY2N1cmF0ZWx5DQo+ID4+PiBnaXZlbiB0aGUgdmFy
aWV0eSBvZiBwb3NzaWJsZSB0b3BvbG9naWVzLCBzbyB3aGlsZSBzdGlsbCBub3QgZ2V0dGluZyBh
DQo+ID4+PiBwZXJmZWN0IGFuc3dlciwgYnkgcHV0dGluZyBlbm91Z2ggZmFpdGggaW4gZmlybXdh
cmUgd2UgY2FuIGF0IGxlYXN0IGdldA0KPiA+Pj4gYSBnb29kIGJpdCBjbG9zZXIuIElmIHdlIGNh
biBzZWUgdGhhdCBhbnkgZGV2aWNlIG5lYXIgYSBUaHVuZGVyYm9sdCBOSEkNCj4gPj4+IGhhcyBh
bGwgdGhlIHJlcXVpc2l0ZXMgZm9yIEtlcm5lbCBETUEgUHJvdGVjdGlvbiwgY2hhbmNlcyBhcmUg
dGhhdCBpdA0KPiA+Pj4gKmlzKiBhIHJlbGV2YW50IHBvcnQsIGJ1dCBtb3Jlb3ZlciB0aGF0IGlt
cGxpZXMgdGhhdCBmaXJtd2FyZSBpcyBwbGF5aW5nDQo+ID4+PiB0aGUgZ2FtZSBvdmVyYWxsLCBz
byB3ZSdsbCB1c2UgdGhhdCB0byBhc3N1bWUgdGhhdCBhbGwgVGh1bmRlcmJvbHQgcG9ydHMNCj4g
Pj4+IHNob3VsZCBiZSBjb3JyZWN0bHkgbWFya2VkIGFuZCB0aHVzIHdpbGwgZW5kIHVwIGZ1bGx5
IHByb3RlY3RlZC4NCj4gPj4+DQo+ID4+DQo+ID4+IFRoaXMgYXBwcm9hY2ggbG9va3MgZ2VuZXJh
bGx5IGdvb2QgdG8gbWUuICBJIGRvIHdvcnJ5IGEgbGl0dGxlIGJpdCBhYm91dA0KPiBvbGRlcg0K
PiA+PiBzeXN0ZW1zIHRoYXQgZGlkbid0IHNldCBFeHRlcm5hbEZhY2luZ1BvcnQgaW4gdGhlIEZX
IGJ1dCB3ZXJlIHByZXZpb3VzbHkNCj4gc2V0dGluZw0KPiA+PiBpb21tdV9kbWFfcHJvdGVjdGlv
biwgYnV0IEkgdGhpbmsgdGhhdCB0aG9zZSBjb3VsZCBiZSB0cmVhdGVkIG9uIGENCj4gcXVpcmsN
Cj4gPj4gYmFzaXMgdG8gc2V0IFBDSSBJRHMgZm9yIHRob3NlIHJvb3QgcG9ydHMgYXMgZXh0ZXJu
YWwgZmFjaW5nIGlmL3doZW4gdGhleQ0KPiBjb21lDQo+ID4+IHVwLg0KPiA+DQo+ID4gVGhlcmUg
YXJlIG5vIHN1Y2ggc3lzdGVtcyBvdXQgdGhlcmUgQUZBSUNULg0KPiANCj4gQW5kIGV2ZW4gaWYg
dGhlcmUgYXJlLCBhcyBhYm92ZSB0aGV5J3ZlIG5ldmVyIGFjdHVhbGx5IGJlZW4gZnVsbHkNCj4g
cHJvdGVjdGVkIGFuZCBzdGlsbCB3b24ndCBiZSwgc28gaXQncyBhcmd1YWJseSBhIGdvb2QgdGhp
bmcgZm9yIHRoZW0gdG8NCj4gc3RvcCB0aGlua2luZyBzby4NCg0KSSB3YXMgbWVhbmluZyB0aGF0
IGlmIHRoaXMgc2l0dWF0aW9uIGNvbWVzIHVwIHRoYXQgd2UgY291bGQgdGFnIHRoZSBQQ0kgSURz
IGZvcg0KdGhvc2Ugcm9vdCBwb3J0cyBhcyBFeHRlcm5hbEZhY2luZyBpbiBkcml2ZXJzL3BjaS9x
dWlya3MuYyBzbyB0aGF0IHRoZSBwcm90ZWN0aW9uDQoiaXMiIGVuYWN0ZWQgZm9yIHRoZW0gZXZl
biBpZiBpdCB3YXMgbWlzc2luZyBmcm9tIHRoZSBmaXJtd2FyZS4NCg0KPiANCj4gPj4gSSdsbCBz
ZW5kIHVwIGEgZm9sbG93IHVwIHBhdGNoIHRoYXQgYWRkcyB0aGUgQU1EIEFDUEkgdGFibGUgY2hl
Y2suDQo+ID4+IElmIGl0IGxvb2tzIGdvb2QgY2FuIHJvbGwgaXQgaW50byB5b3VyIHNlcmllcyBm
b3IgdjMsIG9yIGlmIHRoaXMgc2VyaWVzIGdvZXMNCj4gPj4gYXMgaXMgZm9yIHYyIGl0IGNhbiBj
b21lIG9uIGl0cyBvd24uDQo+ID4+DQo+ID4+PiBDQzogTWFyaW8gTGltb25jaWVsbG8gPG1hcmlv
LmxpbW9uY2llbGxvQGFtZC5jb20+DQo+ID4+PiBTaWduZWQtb2ZmLWJ5OiBSb2JpbiBNdXJwaHkg
PHJvYmluLm11cnBoeUBhcm0uY29tPg0KPiA+Pj4gLS0tDQo+ID4+Pg0KPiA+Pj4gdjI6IEdpdmUg
dXAgdHJ5aW5nIHRvIGxvb2sgZm9yIHNwZWNpZmljIGRldmljZXMsIGp1c3QgbG9vayBmb3IgZXZp
ZGVuY2UNCj4gPj4+ICAgICAgdGhhdCBmaXJtd2FyZSBjYXJlcyBhdCBhbGwuDQo+ID4+DQo+ID4+
IEkgc3RpbGwgZG8gdGhpbmsgeW91IGNvdWxkIGtub3cgZXhhY3RseSB3aGljaCBkZXZpY2VzIHRv
IHVzZSBpZiB5b3UncmUgaW4NCj4gPj4gU1cgQ00gbW9kZSwgYnV0IEkgZ3Vlc3MgdGhlIGNvbnNl
bnN1cyBpcyB0byBub3QgYmlmdXJjYXRlIHRoZSB3YXkgdGhpcw0KPiA+PiBjYW4gYmUgY2hlY2tl
ZC4NCj4gPg0KPiA+IEluZGVlZC4NCj4gPg0KPiA+IFRoZSBwYXRjaCBsb29rcyBnb29kIHRvIG1l
IG5vdy4gSSB3aWxsIGdpdmUgaXQgYSB0cnkgb24gYSBjb3VwbGUgb2YNCj4gPiBzeXN0ZW1zIGxh
dGVyIHRvZGF5IG9yIHRvbW9ycm93IGFuZCBsZXQgeW91IGd1eXMga25vdyBob3cgaXQgd2VudC4g
SQ0KPiA+IGRvbid0IGV4cGVjdCBhbnkgcHJvYmxlbXMgYnV0IGxldCdzIHNlZS4NCj4gPg0KPiA+
IFRoYW5rcyBhIGxvdCBSb2JpbiBmb3Igd29ya2luZyBvbiB0aGlzIDopDQo+IA0KPiBIZWgsIGxl
dCdzIGp1c3QgaG9wZSB0aGUgb3RoZXIgaGFsZi1kb3plbiBvciBzbyBzdWJzeXN0ZW1zIEkgbmVl
ZCB0bw0KPiB0b3VjaCBmb3IgdGhpcyBJT01NVSBjbGVhbnVwIGFyZW4ndCBhbGwgcXVpdGUgYXMg
aW52b2x2ZWQgYXMgdGhpcyB0dXJuZWQNCj4gb3V0IHRvIGJlIDopDQoNClRoYW5rcyBhIGxvdCBm
b3IgdGhpcyBlZmZvcnQhDQoNCj4gDQo+IENoZWVycywNCj4gUm9iaW4uDQo=
