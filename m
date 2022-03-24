Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EEEE94E60E0
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Mar 2022 10:09:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349129AbiCXJKW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Mar 2022 05:10:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238181AbiCXJKQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Mar 2022 05:10:16 -0400
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27FBEDF1C;
        Thu, 24 Mar 2022 02:08:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1648112923; x=1679648923;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-transfer-encoding:mime-version;
  bh=vqcfcvXiTWB0cVwVXYsoKc8Cffoj4kZyPDb+v7IOLC0=;
  b=pZfRvm4T78wI0L8F1SnzP13eyflFld41sPDluTlAVi9yBkB6yhaKnhOs
   xC5AlO6GEW7C7HwoY5GpEN5o2cd4T2DMuMHzb3sY/qlrBtr0yuSLltzxV
   P65zOJFrJPrcBAqKUUPAa1/DRykVZdyHSULuhi/7bMeYTps55YednwKi7
   okwS9TrPikkw2cmMPfGDeTGArs3qAIT8ymEAu3zBc1GnLIz6VYi0I/Q6w
   nV7lgzvZgaSg4xTzkTS6RJ/vSV3RXETwkAiN/RjoV8PrQlcfDcroz7ix+
   5HBxjvyK6tb8ak9M9OMeW3GTut8P96V/U+vO4eZzBIBcvvqV3GfVCLy9T
   A==;
X-IronPort-AV: E=Sophos;i="5.90,206,1643644800"; 
   d="scan'208";a="197071758"
Received: from mail-dm6nam12lp2169.outbound.protection.outlook.com (HELO NAM12-DM6-obe.outbound.protection.outlook.com) ([104.47.59.169])
  by ob1.hgst.iphmx.com with ESMTP; 24 Mar 2022 17:08:41 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PhfJRrbaFS9hBKLZBTNCCbo6cuAOQZkNoKai/NIT/R1qJO+yAq3/4v4ZcT5jF/VFOVFWEZjJVlTv946WvzkKFCfnQGSl50GZTmcJ9znEKqvYUCbbqwi7AjB6MWnB+H1XTkNoB6XTSruvXpMZdRQ3Y7Nb3R0c9ufuIRyEKiP1r7J53wBWocL0UQhyq1D2oPQx/hlZg5mXTUTqtGVabYfYfsjbSt31P/OyMMTEB7pFfEFIMHG7depXTHuvjmfrE4QxkVGY34Wr7CFwAAP2Qildhlui9Zo5Lma74/vi2nm0FXwPGWiT5kGviWlqT8AOeSqajRVtI74jsDouWP4SlriW/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vqcfcvXiTWB0cVwVXYsoKc8Cffoj4kZyPDb+v7IOLC0=;
 b=cFbbj+vdNvSVEGT/l4RWCWE105p4/+ABGX5Gw1ZoQ6eKyWUjsygrv2p3SMh7Ibkyri0Svk6MxY0hV9UOfq/KLRel8qwy8t2LQqFQtXYtcGwfcRZaNlzfBsz1PMW1YxKgQWgqaBqFdXkkNT0joZOpGyFJZfakoRHULk25aUqQOMugBh5kDUeY2IQisBk6egK9JL9WsILue0ynzNmdx+PanBo4SdPnU7FysBW7xOdN/W9WLeDzYQ+4GLqlT1Q40dAHAPxFkqxP1p2m+AcSbZ6xKr0EY0IySKFMn4gtgS9jtRBNkue0ZhhsDeQD1THBUDUA+jrTDJglpgWGMvJOltzO7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vqcfcvXiTWB0cVwVXYsoKc8Cffoj4kZyPDb+v7IOLC0=;
 b=wxP8rgq1atkZz18d6R/cuqQMfsP6dbdqvuWnTq8ewM0VnZENydDncGRUj2bOwLE7Y6U+bQolvspRVof56UYyYoytQgSJ6aN27yVWccvXda+d61kzRLYxMo/Ci3eHBK/i47rfuJhFxZ1PjdPOzQDd1ITMjMXguhrH9WTVYxWUS04=
Received: from DM6PR04MB6575.namprd04.prod.outlook.com (2603:10b6:5:1b7::7) by
 BYAPR04MB5911.namprd04.prod.outlook.com (2603:10b6:a03:10c::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.16; Thu, 24 Mar
 2022 09:08:39 +0000
Received: from DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::941d:9fe8:b1bd:ea4b]) by DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::941d:9fe8:b1bd:ea4b%5]) with mapi id 15.20.5102.017; Thu, 24 Mar 2022
 09:08:39 +0000
From:   Avri Altman <Avri.Altman@wdc.com>
To:     "keosung.park@samsung.com" <keosung.park@samsung.com>,
        ALIM AKHTAR <alim.akhtar@samsung.com>,
        "jejb@linux.ibm.com" <jejb@linux.ibm.com>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>,
        "bvanassche@acm.org" <bvanassche@acm.org>,
        "beanhuo@micron.com" <beanhuo@micron.com>,
        Daejun Park <daejun7.park@samsung.com>,
        "adrian.hunter@intel.com" <adrian.hunter@intel.com>,
        "cang@codeaurora.org" <cang@codeaurora.org>,
        "asutoshd@codeaurora.org" <asutoshd@codeaurora.org>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] scsi: ufs: core: Remove unused field in struct ufs_hba
Thread-Topic: [PATCH] scsi: ufs: core: Remove unused field in struct ufs_hba
Thread-Index: AQHYP03r9K7h5H8Pi0SLdKGSAwmn6qzOPqbw
Date:   Thu, 24 Mar 2022 09:08:38 +0000
Message-ID: <DM6PR04MB6575A32911BCCE58E2FA96F7FC199@DM6PR04MB6575.namprd04.prod.outlook.com>
References: <CGME20220324070146epcms2p577d43ce3e7cbd36aa964f3842e49b2ba@epcms2p5>
 <413601558.101648105683746.JavaMail.epsvc@epcpadp4>
In-Reply-To: <413601558.101648105683746.JavaMail.epsvc@epcpadp4>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b912a90f-f83e-404d-f9a8-08da0d75e29c
x-ms-traffictypediagnostic: BYAPR04MB5911:EE_
x-microsoft-antispam-prvs: <BYAPR04MB5911939C8206610F6165B9D9FC199@BYAPR04MB5911.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: tkoiROqr53hBWB0vDjru08lX8TBPWkRVgK65eyXSJkt8p5aOtf4Hcqd9F74B0XFyKSOVzECAUGTjbph9BPm+0YeGcLwEu8XWTosiEs1pMU1fETaYqcFyluHpOU0aXZj9hPWFjFRNTDaTH4g1xPuuAC+ZNwJuT9ptoPCjWn8drddZKA78cLQIQWlo0sLbAyrgHH+0yyEDMo42jNBdIkxGef5jyaDyGU/1278UI4LEIGd8YePzdvnZqL/V5UH31WbOcDM9OyJvG4TzCdoxJkQTK2oQPJ8LZ5Ky3br2r2mICdC4Gbnw94RieSUqdYiHBOUCWGnP0xNcTLTMHT+Z7bJaJpUQ2xAL58LK2EW7/jzvFUHRgGY41g8XyKXD9wNCf2yxm733f2+bu4xjdqNQ1IAMJKzh5V9rNnY2CEkKuB/LCrSYB3bnWxfHEkzxtAdSqk00uqnENppnNo7wAfR/oGqzn9+6Zv7XuNQFe0+jyyhSzcr8jwYViUBJyE71AHsLn8sTJsBWMmcooYbG6p/YmbMzZkQrOT9Hsm1d9ozX/JfIU4guKs1Zf5nT5q7WXtOMGjXJQH1gDXj+h6xGjAaOD6zJIhtLlyEsdb76sPaQiUGthBEOL52pG9BMKoqFLwH+3UJItRusZQ3nY6n9yhVQGyB8+K+7jdJEf7R6noXgKOTI5GFq9dqYGOmBDWSZMZ/PY14AFjrkB/8BFpkYB+HegXBDh4xygsOb19pX2kvK+9qImzY=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR04MB6575.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(921005)(86362001)(38070700005)(508600001)(110136005)(186003)(26005)(316002)(83380400001)(55016003)(4744005)(71200400001)(5660300002)(6506007)(8936002)(7416002)(82960400001)(122000001)(52536014)(7696005)(66446008)(66476007)(9686003)(66556008)(66946007)(76116006)(33656002)(64756008)(8676002)(38100700002)(2906002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VDB0V0JlS3VpME5mTis5enpiczhJWVd3cG5hMEJHRENBTnlCdlllb1hRQmIy?=
 =?utf-8?B?QVdtOVJtckl4VmJLdXY5YVRCNG1qZUpGZnBUUmkrNEVkbDEwZ0hLUUluT2dH?=
 =?utf-8?B?akx5YS9zS25ReDJ0NU9JdjJlTnpyNjZ2TjB3WE0wNmlnMGovZUhXK3UzZFE0?=
 =?utf-8?B?VzNUVjFmQ0xIblZKaTRLREozTFB4aDYwekI2M3ZtRVFYNHB5cktZSTJTNFAr?=
 =?utf-8?B?NjZVdXQ5ZWNwRkpsMTZFajN6VVlXSUlrb1llSld1TG1Cb1lNcWwrb2I2VG9Z?=
 =?utf-8?B?MWNZVFN0OEUzYnhGZGVBMXYySmtCYVUvNFMrelMwRkY2czdETXp6RkNjZHAy?=
 =?utf-8?B?K0dyZUJXTEhpcm8wc3hpMjMreGhzK2NQcHBOK09NTHVtbEtEZkl6NDVxTVNu?=
 =?utf-8?B?OWJodkdnbkRtREU5bTZNcUs2ck9UaXhUUEtVSWdsMlAyVkprQ1l0NjNWS29B?=
 =?utf-8?B?MU5VQ0xaVDBtMU9kNXBvT3NwUWpxK3NqbXNpOXpYTWQ1OWtsUjRCWUNDSWFT?=
 =?utf-8?B?dDduaHpKbUlHYTVWaWVDekdFSEJ3S3JsSnMzc3d5UVprR2d3aFd3VDdPZ2gx?=
 =?utf-8?B?V2VWMmdRRWNaelpEY3VVUU9jdkorNjJWZlNYMlpIUElFWUZWN3RCM1B1NWs1?=
 =?utf-8?B?TkRUQW9xbXZIL2xSQ3ZTdXJXN2lONjhsNGxNWEU2WlFyb1k5WHNBZmpTMTdN?=
 =?utf-8?B?eGVlM1RldVczRC9CRVB1YnA4K01EaFJRQXo2cTNkWFNlZ2pzQnczQTFINGM1?=
 =?utf-8?B?NmRvUE5UL29wK2gySHJtTEJ0QXBIZ29rZmxXZDVVNi90UFkvTDFESjVpQTBZ?=
 =?utf-8?B?dWRWck94TE5vdC8ydkEwU1VFd1daaDduQk1CZXBycXNRRkJBQ1VVSXRQNmE4?=
 =?utf-8?B?dThLUERrSmg2OUR6dWx6OWdGV3VWYk5IQnFkRVFJNVgyUkgwTzZmMEJBNFE3?=
 =?utf-8?B?UE1EZThoeThNTFlsenBMdFZYZElmaVJBa1ZlM1VUUU9iSkZkcEpyZ2hlWXpZ?=
 =?utf-8?B?U2NlQTBjK2srM1p0N3IzWWtUdkUzKzlDSGZRcEpMbFFuRCszeHdEdmRpa1BD?=
 =?utf-8?B?bWxCOW1Pb2ovTy8wZ2NMTjBzUzZ6TzhDY2J5djFWU3RtTU44Zkd4dVZ2T0xi?=
 =?utf-8?B?Q3cxWjVpblh2dmZJQ2tVQzZxRTh6ZHNwNmNFNWM3Zlk0SCsycHJxTng3cEdK?=
 =?utf-8?B?T2ZFVVJCNUlpbTAyZnZvYSsvSStNdDhGYlYzS1JEeFNVZDlkakdqT1RHN1oz?=
 =?utf-8?B?WVBhanFZcGo0dmVqdzZyTEphaC8wQmcySHF2ZTJtaVpnTlNOSmVSUkJRbWVS?=
 =?utf-8?B?MGFjOEpHNFhJRzFnK1I1T2NiRWtFTnNDWjlZN21Ed2Zja3ZnaEh0VmVTY0VZ?=
 =?utf-8?B?V3NCQVhkNCswK01ucEtXcnB2WXRPNytkaWZGZmJBWDZ1NXBvd0hoNXMxYXBy?=
 =?utf-8?B?MDlTWEkzNmV6Z1hhN1lNYnlkWVkwZzNJam9wWHByOGI1VktwZjZPYjJpaWJa?=
 =?utf-8?B?TDloRkhBMHFCVm15VEdIbUFLa3BLNldyWXRzaUpwemMreHNTWGtPVm9zaDFX?=
 =?utf-8?B?QTh6bmU3VXhDdmMyczYzOEorL1dDNlVPSnF2bmg2QUhEL2pJQ3NtcnZwVm5s?=
 =?utf-8?B?M1lIVDJneUVqc3NBU0dIbktiaXMxWUF1RmtwWmhXU2NZT0lIaHVJLzVEc0Zv?=
 =?utf-8?B?YXJTZE4xM3U4NVI0QnJZSkhYT2JFd0JBb3ZXandzVnhUaUdnUkE5UVU5T29U?=
 =?utf-8?B?NloxYmUvcitpbjV0eWJKSE9RU1BkbXlySER2czRhbkxHMWtCeDRQNnpqL0VG?=
 =?utf-8?B?R1cxa05EUEJOK3Q0dWF3UFRpQ0lSRDZpbTljZlFmWUY3SnZubE1VVkcwaG5j?=
 =?utf-8?B?SkQxSVFvMzZ0NCtQcCtRbDBENWJiVHhkbDhSNW0vZXVnUkhmaVlPVnhpdUV1?=
 =?utf-8?Q?g0MXFahpvblzPqPI/TPA31zFY0vByY1O?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR04MB6575.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b912a90f-f83e-404d-f9a8-08da0d75e29c
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Mar 2022 09:08:38.9838
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gEnrNkAuVjlkhlY/YmPyNTjSEnEs3B0qVMUlkKWGr9iAwb8K1opDxVdsoNZORP9o91jVfMyoQckS6gsmkqRSqQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB5911
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBSZW1vdmUgdW51c2VkIGZpZWxkICJycG1fbHZsX2F0dHIiIGFuZCAic3BtX2x2bF9hdHRyIiBp
biBzdHJ1Y3QgdWZzX2hiYS4NCj4gQ29tbWl0IGNiYjY4MTNlZTc3MSAoInNjc2k6IHVmczogc3lz
ZnM6IGF0dHJpYnV0ZSBncm91cCBmb3IgZXhpc3Rpbmcgc3lzZnMNCj4gZW50cmllcy4iKSByZW1v
dmVkIGFsbCBjb2RlIHVzaW5nIHRoYXQgZmllbGQuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBLZW9z
ZW9uZyBQYXJrIDxrZW9zdW5nLnBhcmtAc2Ftc3VuZy5jb20+DQpBY2tlZC1ieTogQXZyaSBBbHRt
YW4gPGF2cmkuYWx0bWFuQHdkYy5jb20+DQoNCj4gLS0tDQo+ICBkcml2ZXJzL3Njc2kvdWZzL3Vm
c2hjZC5oIHwgMiAtLQ0KPiAgMSBmaWxlIGNoYW5nZWQsIDIgZGVsZXRpb25zKC0pDQo+IA0KPiBk
aWZmIC0tZ2l0IGEvZHJpdmVycy9zY3NpL3Vmcy91ZnNoY2QuaCBiL2RyaXZlcnMvc2NzaS91ZnMv
dWZzaGNkLmggaW5kZXgNCj4gODhjMjBmMzYwOGMyLi45NGY1NDViZTE4M2EgMTAwNjQ0DQo+IC0t
LSBhL2RyaXZlcnMvc2NzaS91ZnMvdWZzaGNkLmgNCj4gKysrIGIvZHJpdmVycy9zY3NpL3Vmcy91
ZnNoY2QuaA0KPiBAQCAtODIwLDggKzgyMCw2IEBAIHN0cnVjdCB1ZnNfaGJhIHsNCj4gICAgICAg
ICBlbnVtIHVmc19wbV9sZXZlbCBycG1fbHZsOw0KPiAgICAgICAgIC8qIERlc2lyZWQgVUZTIHBv
d2VyIG1hbmFnZW1lbnQgbGV2ZWwgZHVyaW5nIHN5c3RlbSBQTSAqLw0KPiAgICAgICAgIGVudW0g
dWZzX3BtX2xldmVsIHNwbV9sdmw7DQo+IC0gICAgICAgc3RydWN0IGRldmljZV9hdHRyaWJ1dGUg
cnBtX2x2bF9hdHRyOw0KPiAtICAgICAgIHN0cnVjdCBkZXZpY2VfYXR0cmlidXRlIHNwbV9sdmxf
YXR0cjsNCj4gICAgICAgICBpbnQgcG1fb3BfaW5fcHJvZ3Jlc3M7DQo+IA0KPiAgICAgICAgIC8q
IEF1dG8tSGliZXJuYXRlIElkbGUgVGltZXIgcmVnaXN0ZXIgdmFsdWUgKi8NCj4gLS0NCj4gMi4x
Ny4xDQoNCg==
