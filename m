Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7010573CDF
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 21:03:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236870AbiGMTDU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 15:03:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230169AbiGMTDS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 15:03:18 -0400
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2066.outbound.protection.outlook.com [40.107.95.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1032A2CDEA;
        Wed, 13 Jul 2022 12:03:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JwQcNUwawK33jN1Q7Y5eFCa7FtQFuCRsXoITcy/HePAwwxqcL0BbFAt3C9yoo8Jf/g7tlMMHRFcRmkqMP/oxoqwLRBjkZ7vAAUeB3XnVKeuOcH5IiOEUh+Cq0LtfcSY6eznZ6vBX313QmaB+gMSX4CQ+mRlk6opuk+5nmGXbhppiWYjDO1vEAXFzoyDnCTgtGTi2UfACi+GecrZ2VnonvwhHthrnYwixVgoixs6AKVzBY6Fbd2uh5SiXkTumZCF9t0qJxgPJME2MiXxZKVcUnAAumB1DTlD9crrBbNN4L6n6pA1IjDgNIqDGtSuLsbF68Z1+ioMcE47w9FlvXLdFrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0qLcowUayFa5tKcFopBERaFYmAEaUAhoRs05ubyEO1k=;
 b=DB5CACK+UIiRZiNHQndEiAW9KADnpJvM79QZqi1NaqQS69WJL5ausFs4N4YRMTGFTbZOMEuLT7sDJjBaAFPj+yh1MxsqwpsYwqQ76fkeeNxoH/iWtQy+9+RlnfD4bXN2Ct4H2V0Cv7Ks4rwww5jIu2xLgj4a71fBgeyOYSIYAL2Q+LYBdx0UXd+DEv++iiZg/ICHJ5Hs+fRRAvNkvX/IMnE4khVJtQnrc+cVuCyK4qOS4ul7ymdyANz/frevjm3VcJ1A2wRXxSeP68UJyqaxx+mgX9V2GVZts2yBJp/YGLHAHWqJ+NOGAj1sqEh199jj34OTLhAaBkeCoDrjuZchJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0qLcowUayFa5tKcFopBERaFYmAEaUAhoRs05ubyEO1k=;
 b=aIptYjck11LWK0Hs8YtLKNEnIYLV9ZDcJ2ztzRz/SeYVENq2BDKnDWMKJUaRq8EmKaMX220RNS/YUHX9DbRYtupb0GxQOjYxG39mU4RBnED0J86tuLlb3hX9gMlYIFeBEDRcz2BFkeSZjsebJJO9/IX7Wtd/XVjUKcqK1aUuTHI=
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by BYAPR12MB4615.namprd12.prod.outlook.com (2603:10b6:a03:96::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.25; Wed, 13 Jul
 2022 19:03:14 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::1143:10a5:987a:7598]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::1143:10a5:987a:7598%6]) with mapi id 15.20.5417.026; Wed, 13 Jul 2022
 19:03:14 +0000
From:   "Limonciello, Mario" <Mario.Limonciello@amd.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux ACPI <linux-acpi@vger.kernel.org>
CC:     LKML <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Zhang Rui <rui.zhang@intel.com>
Subject: RE: [PATCH] ACPI: PM: s2idle: Use LPS0 idle if ACPI_FADT_LOW_POWER_S0
 is unset
Thread-Topic: [PATCH] ACPI: PM: s2idle: Use LPS0 idle if
 ACPI_FADT_LOW_POWER_S0 is unset
Thread-Index: AQHYlumLA8XUEouiPUCdM2woElBNXq18pm9Q
Date:   Wed, 13 Jul 2022 19:03:14 +0000
Message-ID: <MN0PR12MB610152ECD61BC244484643E3E2899@MN0PR12MB6101.namprd12.prod.outlook.com>
References: <12037674.O9o76ZdvQC@kreacher>
In-Reply-To: <12037674.O9o76ZdvQC@kreacher>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2022-07-13T18:55:37Z;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=ef71260a-cafb-42a1-b870-7e272f818733;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=1
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_enabled: true
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_setdate: 2022-07-13T19:03:12Z
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_method: Privileged
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_name: Public-AIP 2.0
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_actionid: a1283664-19be-4f3e-b14f-bc055e8cf458
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e09f0a99-4570-42c5-0533-08da65025676
x-ms-traffictypediagnostic: BYAPR12MB4615:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: T/4IDf0fQ2MSY/2dU1gkLPplj//U07Tj6h6ejJbdLPho2RQtTixLLSVc0jRsOewTxO0Gfil6CBQM/scno1m3pfhBL4pzYkswtRBFROPZTT/7lZBple4P8s3FsXlmlN1aF/B5EzFvuxVHVKuSK2i2mmd2AnO1H/Vf9J56tvncbf+ZS7uFxM3MHB/6mFt7PPTgo3s0ihHKB7sVokVQOC0akz8uTkN2gVeDuZosjsyzDTiHyJZaADsuWD4s8TGtRdtcSQN+sYcus9HoI8AEA30lsxNId0Raf6YfwVt+pht8AoMLRbQhNUXf1ADIa1H/WulQ439GlGUVbls3CMTmgJTFrhB3KORDUK/6cGWt8/5F9jU1+cBkxe9LEgWPmqJMryerwqpj7eaHapAxhj/994WdOFbrxHLw8V1xcwqXRLDP2ZFtePngaDsTC5Ld4k/AMGNJQmp/ZVRJKhyJOw9bQkjUuuB7OOJpGihiGQUtxuej+s/TI0xb0awLkYoUZ1dBEQFhWjaF0SevYgE9CWkbdmq4DZZemFYxzGTPBN+5eHDfSfa/AjQMChQxumgZMxxijH0HAAnOzGpEJuie5HbZCIkMLRP4O5eQXQM6tYwn02C7eNMCyLGJvh6pbd2KXP7i2uoNRnsljN74oQJ4oF6TSjANVsWuM26S9fPZtFmFGa7+A6KUabEdxxPQwwMSZBMcMIjmavwKEKzQfI/ey4iPVDS7n53tsHEUWCFm914UFnjCEhCaRSiIPU5aURo1JCcsECAJrJ9Kn/rQHRC6/YPsoeYRSNqrDkdPrLCGYGouw6b8hl12TVAmfcPv+Z5GlV/nPo2VQrukzYWxAvuQk2oW6dSUuouwlBgcfn9q+X/EFxEsSHM=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(396003)(136003)(39860400002)(366004)(346002)(376002)(8676002)(2906002)(41300700001)(66556008)(71200400001)(54906003)(66446008)(478600001)(64756008)(316002)(76116006)(9686003)(110136005)(7696005)(4326008)(5660300002)(66946007)(52536014)(84970400001)(55016003)(66476007)(8936002)(38100700002)(86362001)(33656002)(6506007)(122000001)(83380400001)(186003)(38070700005)(53546011);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dFppR05YMWJ0Z25mM1k0TFllaG4xci9QcFVPdmRUeEx0T0xLTVZpeCtuYjM2?=
 =?utf-8?B?dTNHUWp2MUtpbndpdWYwREhXSXdFL1ZXd242YnN0Z1F0bnlmRzM0alJJdFVD?=
 =?utf-8?B?RU1aK1p6U3ZUR01tTjBXNHk0ZkhnZUFyREJWR3hsb3NIUndOeEZ1VjNMbFBC?=
 =?utf-8?B?dnZSOU5PdGk5M3VtYWVBLzFsMzZYbFVZSVNkU1RwbEQ0YTRja2cxaVBnNWZ6?=
 =?utf-8?B?SEdQbWFXekRWOE1qQTVwRzJTbFNCQmc2clZmbVdoSzZ2U3BVNGJiRHJTYm9h?=
 =?utf-8?B?MWRWd3hmNDJ1UUNzS3h5dTlKcmlhVGhZV1VlWG0wYlQwR25IZGFPMFBvZmt5?=
 =?utf-8?B?MnpqS3dRSFRIMWs2MUhPSlZHSlBNTC9Wd1RxYzFua1h5dk83SEYxbjl2a3dS?=
 =?utf-8?B?aFFyK21QM3c1NmY4MXVudk5JWDh4OHMzcVU3RDdBcWNMaVJtOStFQWhlMmZ3?=
 =?utf-8?B?K3ZYc0JoUFAyb0ZnRjhwaGhpWjlRSEtmK1hyVjFyaTRRMnR1NjNSNWtqeW92?=
 =?utf-8?B?TTFBZmpveHhoaXlVQWt4OTNoTTdZVmExVmNEbUk4ekJOWDNCOWlJYU8yVk45?=
 =?utf-8?B?MjBCNWkzdFBBZEdxS1l3TVJjbHk5TVdZOTA1dWlQNk9vTGVUSWtLZ1M0Q1Zh?=
 =?utf-8?B?ekNzZGoxTHBFQ1FLNklTTTVoYVdnSDkxWnl0UHhJcWwyeFFLVTRVUnNvV0Z0?=
 =?utf-8?B?Y0s2YUIyMkE0WjdFUCtYVDVvdVpwaUlwZ1I4d3c0TlBUMUFtQWJSNEtpWjdV?=
 =?utf-8?B?Y0pVUURDNndwWjFRaWd4eHZwb2NaTVhRa3doNXdhUkdON1cvcHM1K1RyZm5U?=
 =?utf-8?B?R0V5VG1kVzF3QUVvalhDdHRndzk0Z3cvZ241RWVhN2ZoWndUZWFuUzFTUTZq?=
 =?utf-8?B?YisrV21nU3V3bVQ0djVISllYczFWNFM0a1dYdXArais1UEFHZWU3NENkS2M1?=
 =?utf-8?B?TElPVkZPeHIrUVRaYVNuWmFXMk5CdUp5WjN2TDZVMEF4VWtKWXhTd1FRdXBU?=
 =?utf-8?B?SWMzRTdoT1RDZElGSHEwNEtObHBpcWs0citEZm9xcnd1blpISithRU16alZJ?=
 =?utf-8?B?cnk4V1FiMVdZVWEyUWpUZm9zaEh5YVJVZGlxWDJudFVKQStidjdKaDM0RENZ?=
 =?utf-8?B?Si9DcEZIT2tRdzlBT2lENXphYXRLWlN2RlZsYm05bDI2dW9KMHpPUStVVW0r?=
 =?utf-8?B?c2xVQkZ2dEZpbSt3bWFHVWZoZkliWElmait0Uk9Db1RTQ1NmZXJIOFFRRkxN?=
 =?utf-8?B?dUhDSnJ0Q0ZaY3N2MFpuNXJYYWFXN0l6QXZTd2tSWGppbDBON2tQMzJ6d29T?=
 =?utf-8?B?QzN6Zk5DdEV0QUk2U1hxay9TVEdYeDFXWDZDNWFVQUJ0eTIyS2ZuQXZDbUtw?=
 =?utf-8?B?OEN5dy9zeWRRdUQ0ME4xc0FZV29KRlJ2elFmc2txTzZTVnZ2Z3EraTR0M1F2?=
 =?utf-8?B?N0paZTRrNGprOWJZRHpPdEdoeE9KczVNYy93UTlUQzZhVlBqa21yYlUwQXI1?=
 =?utf-8?B?UytQN3lrNnRhQmVlTnpqWFJ2ZGNYOW5UNG9yRjBwWWtkR2d5TGg2MUlhOXRt?=
 =?utf-8?B?OWdNdHBtSGFEeGxnQ3V4M2RSbHhuQkNWR3pDMmI2c1R0bjhFU2R5Q2l4Yys5?=
 =?utf-8?B?ckZGNU9jQUdIcFEzQXJkZmRjSER0bG5NNmErTHF2Y3VIMmFBTWVQY1Q2Q05C?=
 =?utf-8?B?dUd5V0QrakhheE5VZVpFUG4vcllhaVNhYy8xOGNHd1BSNmxLbUlrMUdabDl5?=
 =?utf-8?B?dXNYM2ovcmtkdDVJYk9IbGFWZUs1ZlcyWTI5WEhCTGR3am9QZFpjOWlhSkpn?=
 =?utf-8?B?MkJZR2pSejQxNkJaWnZ0S1VmdTNBaVBzdG1UdnR3UndyM0JPZFJ6WDR3anhT?=
 =?utf-8?B?WnFBMThtUkw2bUdMS3IyV2hwcFRaMTJSYlZzRGNDdmNxR0NZZzE0U0l4b2R0?=
 =?utf-8?B?dm1NSVBjTS9pRlo3MDNwS3c4QTM2cFJRQlZ6WGdNWS9SNys4TEhtOG1rdGIx?=
 =?utf-8?B?TS9TdlJaaDVUaWRjMFV6UjR4OWdjcFBMc2tvN0s0cmVUVmZaOXBjQnNXUVZM?=
 =?utf-8?B?REF1RUd4RXdOcE9EZVVxSnoxZHBiditxMVlyL1dzNHUxTEVEVW5yZlZyOHhW?=
 =?utf-8?B?N2NMUTRzc2R6T2lOeEVWUTloNUUrdHdBdGZyT0hPZ20yK1JWNW5jNzJuMlFm?=
 =?utf-8?Q?5klAkykBTVUQoRYKFkIa6Bo=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e09f0a99-4570-42c5-0533-08da65025676
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jul 2022 19:03:14.0636
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1ebDbRsNipVjDUsRT1/ZirJCOrZ7wBdP2q+gfLX/uJ5lGPqyCqfc8X+Rg1jMeanunOMxCabz0R+KYiSpJgihrQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB4615
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
bHkgMTMsIDIwMjIgMTM6NTENCj4gVG86IExpbnV4IEFDUEkgPGxpbnV4LWFjcGlAdmdlci5rZXJu
ZWwub3JnPg0KPiBDYzogTEtNTCA8bGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZz47IExpbnV4
IFBNIDxsaW51eC0NCj4gcG1Admdlci5rZXJuZWwub3JnPjsgU3Jpbml2YXMgUGFuZHJ1dmFkYQ0K
PiA8c3Jpbml2YXMucGFuZHJ1dmFkYUBsaW51eC5pbnRlbC5jb20+OyBaaGFuZyBSdWkgPHJ1aS56
aGFuZ0BpbnRlbC5jb20+Ow0KPiBMaW1vbmNpZWxsbywgTWFyaW8gPE1hcmlvLkxpbW9uY2llbGxv
QGFtZC5jb20+DQo+IFN1YmplY3Q6IFtQQVRDSF0gQUNQSTogUE06IHMyaWRsZTogVXNlIExQUzAg
aWRsZSBpZg0KPiBBQ1BJX0ZBRFRfTE9XX1BPV0VSX1MwIGlzIHVuc2V0DQo+IA0KPiBGcm9tOiBS
YWZhZWwgSi4gV3lzb2NraSA8cmFmYWVsLmoud3lzb2NraUBpbnRlbC5jb20+DQo+IA0KPiBJZiB0
aGUgUE5QMEQ4MCBkZXZpY2UgaXMgcHJlc2VudCBhbmQgaXRzIF9EU00gYXBwZWFycyB0byBiZSB2
YWxpZCwNCj4gdGhlcmUgaXMgbm8gcmVhc29uIHRvIGF2b2lkIHVzaW5nIGl0IGV2ZW4gaWYgQUNQ
SV9GQURUX0xPV19QT1dFUl9TMA0KPiBpcyB1bnNldCBpbiB0aGUgRkFEVCwgYmVjYXVzZSBzdXNw
ZW5kLXRvLWlkbGUgbWF5IGJlIHRoZSBvbmx5IHdheSB0bw0KPiBzdXNwZW5kIHRoZSBzeXN0ZW0g
aWYgUzMgaXMgbm90IHN1cHBvcnRlZCBieSB0aGUgcGxhdGZvcm0sIHNvIGRvIG5vdA0KPiByZXR1
cm4gZWFybHkgZnJvbSBscHMwX2RldmljZV9hdHRhY2goKSBpbiB0aGF0IGNhc2UuDQo+IA0KPiBI
b3dldmVyLCBzdGlsbCBjaGVjayBBQ1BJX0ZBRFRfTE9XX1BPV0VSX1MwIHdoZW4gZGVjaWRpbmcg
d2hldGhlciBvcg0KPiBub3Qgc3VzcGVuZC10by1pZGxlIHNob3VsZCBiZSB0aGUgZGVmYXVsdCBz
eXN0ZW0gc3VzcGVuZCBtZXRob2QuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBSYWZhZWwgSi4gV3lz
b2NraSA8cmFmYWVsLmoud3lzb2NraUBpbnRlbC5jb20+DQo+IC0tLQ0KDQpSZXZpZXdlZC1ieTog
TWFyaW8gTGltb25jaWVsbG8gPG1hcmlvLmxpbW9uY2llbGxvQGFtZC5jb20+DQoNCj4gIGRyaXZl
cnMvYWNwaS94ODYvczJpZGxlLmMgfCAgIDExICsrKysrLS0tLS0tDQo+ICAxIGZpbGUgY2hhbmdl
ZCwgNSBpbnNlcnRpb25zKCspLCA2IGRlbGV0aW9ucygtKQ0KPiANCj4gSW5kZXg6IGxpbnV4LXBt
L2RyaXZlcnMvYWNwaS94ODYvczJpZGxlLmMNCj4gPT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PQ0KPiA9PT09PT09PT0NCj4gLS0tIGxpbnV4
LXBtLm9yaWcvZHJpdmVycy9hY3BpL3g4Ni9zMmlkbGUuYw0KPiArKysgbGludXgtcG0vZHJpdmVy
cy9hY3BpL3g4Ni9zMmlkbGUuYw0KPiBAQCAtMzY5LDkgKzM2OSw2IEBAIHN0YXRpYyBpbnQgbHBz
MF9kZXZpY2VfYXR0YWNoKHN0cnVjdCBhY3ANCj4gIAlpZiAobHBzMF9kZXZpY2VfaGFuZGxlKQ0K
PiAgCQlyZXR1cm4gMDsNCj4gDQo+IC0JaWYgKCEoYWNwaV9nYmxfRkFEVC5mbGFncyAmIEFDUElf
RkFEVF9MT1dfUE9XRVJfUzApKQ0KPiAtCQlyZXR1cm4gMDsNCj4gLQ0KPiAgCWlmIChhY3BpX3My
aWRsZV92ZW5kb3JfYW1kKCkpIHsNCj4gIAkJLyogQU1EMDAwNCwgQU1EMDAwNSwgQU1ESTAwMDU6
DQo+ICAJCSAqIC0gU2hvdWxkIHVzZSByZXZfaWQgMHgwDQo+IEBAIC00MjEsMTAgKzQxOCwxMiBA
QCBzdGF0aWMgaW50IGxwczBfZGV2aWNlX2F0dGFjaChzdHJ1Y3QgYWNwDQo+ICAJCWxwaV9kZXZp
Y2VfZ2V0X2NvbnN0cmFpbnRzKCk7DQo+IA0KPiAgCS8qDQo+IC0JICogVXNlIHN1c3BlbmQtdG8t
aWRsZSBieSBkZWZhdWx0IGlmIHRoZSBkZWZhdWx0IHN1c3BlbmQgbW9kZSB3YXMNCj4gbm90DQo+
IC0JICogc2V0IGZyb20gdGhlIGNvbW1hbmQgbGluZS4NCj4gKwkgKiBVc2Ugc3VzcGVuZC10by1p
ZGxlIGJ5IGRlZmF1bHQgaWYgQUNQSV9GQURUX0xPV19QT1dFUl9TMCBpcw0KPiBzZXQgaW4NCj4g
KwkgKiB0aGUgRkFEVCBhbmQgdGhlIGRlZmF1bHQgc3VzcGVuZCBtb2RlIHdhcyBub3Qgc2V0IGZy
b20gdGhlDQo+IGNvbW1hbmQNCj4gKwkgKiBsaW5lLg0KPiAgCSAqLw0KPiAtCWlmIChtZW1fc2xl
ZXBfZGVmYXVsdCA+IFBNX1NVU1BFTkRfTUVNICYmDQo+ICFhY3BpX3NsZWVwX2RlZmF1bHRfczMp
DQo+ICsJaWYgKChhY3BpX2dibF9GQURULmZsYWdzICYgQUNQSV9GQURUX0xPV19QT1dFUl9TMCkg
JiYNCj4gKwkgICAgbWVtX3NsZWVwX2RlZmF1bHQgPiBQTV9TVVNQRU5EX01FTSAmJg0KPiAhYWNw
aV9zbGVlcF9kZWZhdWx0X3MzKQ0KPiAgCQltZW1fc2xlZXBfY3VycmVudCA9IFBNX1NVU1BFTkRf
VE9fSURMRTsNCj4gDQo+ICAJLyoNCj4gDQo+IA0K
