Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3EE27573C5C
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 20:10:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236546AbiGMSJx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 14:09:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbiGMSJv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 14:09:51 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2081.outbound.protection.outlook.com [40.107.237.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DD1124BD7;
        Wed, 13 Jul 2022 11:09:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f53khGLZc2JH2F1FmWbrFqy/LHMRpLj9A+9qVaFZ4Hr8e9DqYhw9y7QxTIMU8XNZyO34BW3WrCzqvNSr8Qa3RZL6NkKpBvakIPEX6sQQjaz6LxW8/gXHSYnm76UNDGfGvjm174QYW8/9gBeEW/H4VfxWt4LohAzuxSGtg9TqGEbXx//UqHHTQbNhIJk7l57xgoFpbOx6VZIsobvoske2mZtNLl12PzMFpWkGRgjBfguseFnr9Ccpz2Ot42McCx37CZmZ5YHtxJg83Ds2CmqajiB5ROWlh/uuaCEx6Kj7ltuK/o7OIcUgoOv5byRa8D6gSG4WOEw4lppminer0JVaaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3TEHqE+Yx77IV2Nw/M08Wzvml5U4n9Evx12EJw3QHJo=;
 b=MdZxrxOEGPTIgf72baaeQvfZ7SrqVflUOahwP+DSVCb9CG3ux8aKwByuMCcoo+0Vh/AGv41sBFXjyiM31j3kAwzRq4fmIz7MazxILtrT0bEhQa2Hjdrw4xcHQflqZWb8P9V0OPWnkQHWH6PvEDd4pYAdUlsqxYXXwj3g/RSdl4If8gyas61gsPF825Vu4O1JUJIfPM5rZwYWo/wzQgvRJXeDIZG0rC8iV6I4kGI3IuA0/ULWADpGnlug73ou3z7usaqVWQR/pmi9PO/sYu8Xw1WIMpG1MqndA8ajcVkLeLkCYz9hlSH6AmNfkg1QhYJDMk/XHr7qDSkphcx7lKumgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3TEHqE+Yx77IV2Nw/M08Wzvml5U4n9Evx12EJw3QHJo=;
 b=WiiOmN5Clkul4co3rOsiQcjtSbZ1fepegKTFtq0Ogr3nqWn99WiQ3WFTCcEdJUJnMDuVFWqHYKH1coZhqg/7JoNnqCIYtw5Wz8HwIyW5/dn5YCEc0SyJOqHBIIbSUxakS3msiWJC0pUkiFjR0rlDoEsGvttaFTbnskvndDTAunQ=
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by BN8PR12MB3075.namprd12.prod.outlook.com (2603:10b6:408:67::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.26; Wed, 13 Jul
 2022 18:09:45 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::1143:10a5:987a:7598]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::1143:10a5:987a:7598%6]) with mapi id 15.20.5417.026; Wed, 13 Jul 2022
 18:09:45 +0000
From:   "Limonciello, Mario" <Mario.Limonciello@amd.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux ACPI <linux-acpi@vger.kernel.org>
CC:     LKML <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Zhang Rui <rui.zhang@intel.com>
Subject: RE: [PATCH] Revert "ACPI / PM: LPIT: Register sysfs attributes based
 on FADT"
Thread-Topic: [PATCH] Revert "ACPI / PM: LPIT: Register sysfs attributes based
 on FADT"
Thread-Index: AQHYlt6pg3XR3900PEukKtbpmHOgDq18mZng
Date:   Wed, 13 Jul 2022 18:09:45 +0000
Message-ID: <MN0PR12MB61014EE8791B14B0AF864E48E2899@MN0PR12MB6101.namprd12.prod.outlook.com>
References: <2658707.mvXUDI8C0e@kreacher>
In-Reply-To: <2658707.mvXUDI8C0e@kreacher>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2022-07-13T18:09:19Z;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=b19d290c-2923-4e7b-a11f-17016162f250;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=1
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_enabled: true
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_setdate: 2022-07-13T18:09:44Z
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_method: Privileged
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_name: Public-AIP 2.0
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_actionid: 7442450b-d72b-46bc-811c-8df29b0984dd
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c3796356-c544-483a-aa95-08da64fade05
x-ms-traffictypediagnostic: BN8PR12MB3075:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: k1qUw4/QTp2j8Wdb+Ue/J60IIISnrvDCmIHqDif5Iwls5fEP1QUmKS0YGzzNOx+Vi2kEMIoGiFoxkmes73XxV/IdkP52YuAir/WIWXITDviJfGDENH29XhizQPVkYOJt3BlGgW3ZpOM3Ji876xUFhdstNFAo27YQiCymDicv2MkXo5qpT9hRIbR9lkSSb7+C18IWFx4gXraMCGuVSQ0PY9NBUrh0As09vr9k8fg4ZY3oUacCaM9qPzdFJMFUribuLiK1Qb1Xh3Cd7l8P+F5a07HWI+eg+cL0b2Z3auFDooE3r+zK4RdPmVQ4ByI1m6nB+ryHdIqlj08JocWvaCyQFSxvJBXAl0ohde7UvUtPXLIge3rXjJ2yEHgLL2zMLrvk7mKQC3F2UlD1H3aDu77eZX8x40HnEOIHiIYyAPt8nUFhepBPF1eNPzfUP+4YlKVauWjanszWx73QD+bKHZFjZ8lTHor24njpysOiae+r1aMZKxLjuqPORxPpqildESs2mXHLUHpkiZsT7JX6O+DH4BJZYTrbuAbaDyAFYKHmxpjwYxeRCaG5b2ExZPGsYA6Cd6wgqUS6N6gX1W6RkuY2IHaY78E685G9+vwfA5C7D8LeaqsikFtICR/qtNsihXstIVA1n0yWGMLop5e6iqXH6u9xO06w/rH1SzbHIY+IgtaIDSDkb4UmOKVkpihtY4S98lfjMJoIQES3Is61/MzLTsYUjD05S+OaS8JW5jKMgtBJbyvlwC3AWBWt9muAlEvHk7TRs1xBevPYXuNfkNYaAIAv7wyHAQXg2vgmho81Szecr/fSuameLDaKrD0U6vqF
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(396003)(366004)(39860400002)(346002)(136003)(376002)(4326008)(54906003)(38100700002)(2906002)(186003)(5660300002)(478600001)(110136005)(316002)(38070700005)(55016003)(41300700001)(71200400001)(9686003)(52536014)(122000001)(33656002)(64756008)(66476007)(53546011)(8936002)(66446008)(76116006)(66946007)(66556008)(8676002)(83380400001)(6506007)(7696005)(86362001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?c2tkNXpPVDJLSHRndU9SMGZOalhLVkhqLzdmY2VWRW1lZHU3NHp0MGNpbGZ2?=
 =?utf-8?B?SVVQMHdlL05GdG1KNU5jaGhqN1B3dHVWbzM3TU9SUFNTVGVIY1cxYld5SnEr?=
 =?utf-8?B?RUx5VStDN1RMd3FBcGVkMVFjK0ViZld2RVlVYUVHdGJUT1NNQnQ3M00xb1E2?=
 =?utf-8?B?SGV5MUNNNk02TDRJbTJzQWtqQTFQVUduQjhUcGhmQk9ON3Z1d0V1ZkJzdjhK?=
 =?utf-8?B?UDV5WlZENEVFUUdXUHNJMGlHZGlvYTA5Z0NJTzVtTXg4NVJPU2RvaVhSbmRq?=
 =?utf-8?B?QkZlenNESVVPTVpMc0NCeENVK0lrbktQUjFEL1p0RGZ5aXFGZnk1eCtSSStB?=
 =?utf-8?B?SmEwMlBYZGZyWGpSOEZxNDlOcHExdjhQZTk4TE4vSEpHb3J0RWU5eGhUWk83?=
 =?utf-8?B?Sm45RGhQVHZzdzZnQ0drM0U0dXJNbEpHOS9uQmhQcDdtbFZEblVFZkdndERX?=
 =?utf-8?B?WWhMdUdmRjN3UDVFV2VRMDRCSk4rUkwrOHhXQk5CaE5GdjEwQ2I2UkQzblBl?=
 =?utf-8?B?Wk5URVg2RytVek9RU2RkNkt6bXBVck9kMDZoVHhIVjlvRHpGeGxzeVhFbXdw?=
 =?utf-8?B?UkJMNHlUdncxNHJXVERIQUZEc2JUKzRaNFRTQzRiK2VsM1ZvZlM1clF2QXZ1?=
 =?utf-8?B?WnIvck5DR3JHYklYR3pBRm9jNE91aFFYWDF2ZTBkTlJTWkkxVjdVNUFkRDBx?=
 =?utf-8?B?MlB1K2IzUWxRbEo3R3FuNWkzVFZkenRCSXpzNDdydWhsY2tENjloR3lacHdP?=
 =?utf-8?B?MTFRRHlaNU9Ic25UVFBtakpZbG5qaWt3RWZUMnFhK0ZmYUxtbFA0L1RBWGxG?=
 =?utf-8?B?RWYwcW5mTlZ6TTVQb0lac2NqMEQ0bWFNMHArcVU0MWU0TnFrMkFmbnlGTDly?=
 =?utf-8?B?TmVzTXFldGFDaS9Mc2NPRHFObmd2cGtySXZBeGNYK2lyYm5rSUxwbkh4NUY5?=
 =?utf-8?B?NmtSR0NzYmI2R2tvbGFyNGljMWd6Rm13Rjd6L1pZWlRBWmtoVXV5eFdwWVFh?=
 =?utf-8?B?MWRzWFhMUG5JOW44ekpReThRR2cwRG5HenlKTWxiY2VJVHJudjBqTEs3Mytq?=
 =?utf-8?B?VG56TCswY2ZNT0N5VmpTbnEyRUE5cnVwZEtWanpIdHpqUllVQlluaVU5Qm1K?=
 =?utf-8?B?dFhHV28yZlN3ZzZEME9TdmFJUllCN1pBVHFHYU9qNkVPNDQxQ3RhcjRERlBn?=
 =?utf-8?B?bzNmQW9idHBxaVl6Y3FtbG1GVlR0VDUxUWJqWU1UTHQrSEVjaHQwSjRFcDFW?=
 =?utf-8?B?MU8zVk03RWYzSFduT2t3ZDNjYnF4UjRwdlMwTVJqL2gxV3lOeE4vWmx1dU5n?=
 =?utf-8?B?UVoyeWNXbFdjVmlxY0crazlKTVFTRnpkWUw3N3krTlJBbUplbDVhNjRmQklN?=
 =?utf-8?B?Y1NQbHI5L2Fyb2luSS9jR0lhS2ZNaGo1dHMvRjJYY1R0a3pyZVlaZnRPMHVW?=
 =?utf-8?B?NU9QYURXdVRqdFlJWTdyajJJRkpaZTZVRjl5UGJNeUt4K2srZ042VFRKalUw?=
 =?utf-8?B?cjVWVDZ4V3FOMGl5NkNRNi9RNnBvWVgvcXFqVGwvd2JNdDhRa200UGs0bHZZ?=
 =?utf-8?B?RExBc1ZSTHRyVjFqNW1GeDdoYmdDQ09sK2E5bGFCdWJHSG9hOUYzYjVTdkxz?=
 =?utf-8?B?M1F0dWpTdFJsQS9PbGNudEN4SWcxRWE0QTZaNzFtaFh0LytQMEpBdnJmeXpV?=
 =?utf-8?B?M1gzRUFvam9La0ZlWlpUZ25LdG1TaE12b2txbEpTUEI2Ykh4bU5RbUpkODFz?=
 =?utf-8?B?RnJoUElxNStWeEE0bWV2cHozV1hOS0FnNXd1ZkFzeUlpcDVLWUY3MGx5emVL?=
 =?utf-8?B?SHFKTVFMbmhid3FuRUMrQk5CREo4cS8rVDRHRlFrbVZLejlTbWk5bEpaZkIy?=
 =?utf-8?B?T3EvL0JJYVVoU2lLUlJvOFJDcHhiZE1WN0k4VitaTW9ZbFN6MlZrb2s1K2lW?=
 =?utf-8?B?OFVkUDRhNURNb3hBUHRYVUNTODJYZjZwVUc1TTRXWnlhRmVaai9BWE9mZ1FC?=
 =?utf-8?B?UkgwbXh1RURMTlRCWm45cTZUeGhIMkFaMS9US3o4UXZIUVBFOHlGa2p2Q3Jy?=
 =?utf-8?B?RUZJV3dldVI0UzhrZTM1UnpGZTlGMTlxdWFiQXgraG1ucU9uQXJONlN6Sk1S?=
 =?utf-8?B?NEhtQjVycnR4aUUyNVZ3YzRDcnphNzhHUXg0cWZTdkRQNTVyOFhsdGZ5bSs1?=
 =?utf-8?Q?wSCVjM9IEkByR02gtaQqusI=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c3796356-c544-483a-aa95-08da64fade05
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jul 2022 18:09:45.5548
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uVVcPTUpye2nnzS9hfVTnJH26SporrE6VqI4Lnc1kX0hDm6gTqT4v9x5Psrg7QgclVrOMM2PJ5n5h2gFM9+Ksg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB3075
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

W1B1YmxpY10NCg0KDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogUmFm
YWVsIEouIFd5c29ja2kgPHJqd0Byand5c29ja2kubmV0Pg0KPiBTZW50OiBXZWRuZXNkYXksIEp1
bHkgMTMsIDIwMjIgMTI6MzMNCj4gVG86IExpbnV4IEFDUEkgPGxpbnV4LWFjcGlAdmdlci5rZXJu
ZWwub3JnPg0KPiBDYzogTEtNTCA8bGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZz47IExpbnV4
IFBNIDxsaW51eC0NCj4gcG1Admdlci5rZXJuZWwub3JnPjsgU3Jpbml2YXMgUGFuZHJ1dmFkYQ0K
PiA8c3Jpbml2YXMucGFuZHJ1dmFkYUBsaW51eC5pbnRlbC5jb20+OyBaaGFuZyBSdWkgPHJ1aS56
aGFuZ0BpbnRlbC5jb20+Ow0KPiBMaW1vbmNpZWxsbywgTWFyaW8gPE1hcmlvLkxpbW9uY2llbGxv
QGFtZC5jb20+DQo+IFN1YmplY3Q6IFtQQVRDSF0gUmV2ZXJ0ICJBQ1BJIC8gUE06IExQSVQ6IFJl
Z2lzdGVyIHN5c2ZzIGF0dHJpYnV0ZXMgYmFzZWQgb24NCj4gRkFEVCINCj4gDQo+IEF1dGhvcjog
UmFmYWVsIEouIFd5c29ja2kgPHJhZmFlbC5qLnd5c29ja2lAaW50ZWwuY29tPg0KPiANCj4gUmV2
ZXJ0IGNvbW1pdCAxY2RkYTk0ODZmNTEgKCJBQ1BJIC8gUE06IExQSVQ6IFJlZ2lzdGVyIHN5c2Zz
IGF0dHJpYnV0ZXMNCj4gYmFzZWQgb24gRkFEVCIpLCBiZWNhdXNlIHdoYXQgaXQgZGlkIHdhcyBt
b3JlIGNvbmZ1c2luZyB0aGFuIGl0IHdvdWxkDQo+IGJlIHRvIGFsbG93IHRoZSBzeXNmcyBhdHRy
aWJ1dGVzIGluIHF1ZXN0aW9uIHRvIGJlIGNyZWF0ZWQgcmVnYXJkbGVzcw0KPiBvZiB3aGV0aGVy
IG9yIG5vdCB0aGUgcmVsZXZhbnQgZmxhZyB3YXMgc2V0IGluIHRoZSBGQURULg0KPiANCj4gSWYg
QUNQSV9GQURUX0xPV19QT1dFUl9TMCBpcyBub3Qgc2V0LCBpdCBuZWVkIG5vdCBtZWFuIHRoYXQg
TFBJVCBpcw0KPiBpbnZhbGlkIGFuZCBsb3ctcG93ZXIgUzAgaWRsZSBpcyBub3QgdXNhYmxlLiAg
SXQgbWVyZWx5IG1lYW5zIHRoYXQNCj4gdXNpbmcgUzMgb24gdGhlIGdpdmVuIHN5c3RlbSBpcyBt
b3JlIGJlbmVmaWNpYWwgZnJvbSB0aGUgZW5lcmd5DQo+IHNhdmluZyBwZXJzcGVjdGl2ZSB0aGFu
IHVzaW5nIGxvdy1wb3dlciBTMCBpZGxlLg0KPiANCj4gU2lnbmVkLW9mZi1ieTogUmFmYWVsIEou
IFd5c29ja2kgPHJhZmFlbC5qLnd5c29ja2lAaW50ZWwuY29tPg0KDQpSZXZpZXdlZC1ieTogTWFy
aW8gTGltb25jaWVsbG8gPG1hcmlvLmxpbW9uY2llbGxvQGFtZC5jb20+DQoNCj4gLS0tDQo+IGRp
ZmYgLS1naXQgYS9kcml2ZXJzL2FjcGkvYWNwaV9scGl0LmMgYi9kcml2ZXJzL2FjcGkvYWNwaV9s
cGl0LmMNCj4gaW5kZXggNDhlNTA1OWQ2N2NhLi41MDU0MGQ0ZDQ5NDggMTAwNjQ0DQo+IC0tLSBh
L2RyaXZlcnMvYWNwaS9hY3BpX2xwaXQuYw0KPiArKysgYi9kcml2ZXJzL2FjcGkvYWNwaV9scGl0
LmMNCj4gQEAgLTEwOSwxNyArMTA5LDExIEBAIHN0YXRpYyB2b2lkIGxwaXRfdXBkYXRlX3Jlc2lk
ZW5jeShzdHJ1Y3QNCj4gbHBpdF9yZXNpZGVuY3lfaW5mbyAqaW5mbywNCj4gIAkJaWYgKCFpbmZv
LT5pb21lbV9hZGRyKQ0KPiAgCQkJcmV0dXJuOw0KPiANCj4gLQkJaWYgKCEoYWNwaV9nYmxfRkFE
VC5mbGFncyAmIEFDUElfRkFEVF9MT1dfUE9XRVJfUzApKQ0KPiAtCQkJcmV0dXJuOw0KPiAtDQo+
ICAJCS8qIFNpbGVudGx5IGZhaWwsIGlmIGNwdWlkbGUgYXR0cmlidXRlIGdyb3VwIGlzIG5vdCBw
cmVzZW50ICovDQo+ICAJCXN5c2ZzX2FkZF9maWxlX3RvX2dyb3VwKCZjcHVfc3Vic3lzLmRldl9y
b290LT5rb2JqLA0KPiANCj4gCSZkZXZfYXR0cl9sb3dfcG93ZXJfaWRsZV9zeXN0ZW1fcmVzaWRl
bmN5X3VzLmF0dHIsDQo+ICAJCQkJCSJjcHVpZGxlIik7DQo+ICAJfSBlbHNlIGlmIChpbmZvLT5n
YWRkci5zcGFjZV9pZCA9PQ0KPiBBQ1BJX0FEUl9TUEFDRV9GSVhFRF9IQVJEV0FSRSkgew0KPiAt
CQlpZiAoIShhY3BpX2dibF9GQURULmZsYWdzICYgQUNQSV9GQURUX0xPV19QT1dFUl9TMCkpDQo+
IC0JCQlyZXR1cm47DQo+IC0NCj4gIAkJLyogU2lsZW50bHkgZmFpbCwgaWYgY3B1aWRsZSBhdHRy
aWJ1dGUgZ3JvdXAgaXMgbm90IHByZXNlbnQgKi8NCj4gIAkJc3lzZnNfYWRkX2ZpbGVfdG9fZ3Jv
dXAoJmNwdV9zdWJzeXMuZGV2X3Jvb3QtPmtvYmosDQo+IA0KPiAJJmRldl9hdHRyX2xvd19wb3dl
cl9pZGxlX2NwdV9yZXNpZGVuY3lfdXMuYXR0ciwNCj4gDQo+IA0K
