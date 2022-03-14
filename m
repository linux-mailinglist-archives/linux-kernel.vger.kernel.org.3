Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76AD14D8068
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Mar 2022 12:10:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237750AbiCNLME (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Mar 2022 07:12:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231800AbiCNLMC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Mar 2022 07:12:02 -0400
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98B8D13E3B;
        Mon, 14 Mar 2022 04:10:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1647256253; x=1678792253;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=wVgWiVqCAK1uXACrQ+pj3AuaCP6PecOxyZ17+r35ats=;
  b=e+qasLI4YUT3Et8TSGAu0bdZu5ZwenkYv4MwOv1gOIzOu4ivB7cheieO
   uNu8lWOoo9fzpVWFIZlF+zk8ZVlF5zfdhurFcc8cDGJ5J+0xxCl9gje3T
   mXjuknsHvyRA4ttXoKdIrzcojb21vhR5CCvcjXKp0xTQFnq1QXHAyBljL
   Z/2vc1TVkD29brIbOoxPjMtN07hZhnwCT6NRC5Yhkq4zFseLzpdbvEMba
   DLL0rv2q+ptRlSUh5rTy+9RMtyr2lijLGRLU5FjzdbYJaEN7XvRfVQ83E
   cI7c4qyJF2m9UlFiJtptt6KmjBrcfEoG98RRDcLy9QQtJG5xvQgv1R8Jg
   g==;
X-IronPort-AV: E=Sophos;i="5.90,180,1643644800"; 
   d="scan'208";a="196239151"
Received: from mail-dm6nam12lp2175.outbound.protection.outlook.com (HELO NAM12-DM6-obe.outbound.protection.outlook.com) ([104.47.59.175])
  by ob1.hgst.iphmx.com with ESMTP; 14 Mar 2022 19:10:51 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j16BnMwwQl3Lw9nXV+PYqbyxzOrcVw6T+eCJu8Puz0ovi0wMw2n8EASygY9w9uZ2Dz7p62UGUNTaEMT2VL2nfVJjwhE+DaCBYIWyI+KXtT4dIOOFm5K4sl2KuWlVlh0HxG/3IlKGOnJpL4CMoAw6YNW4d/fkFpcafTnsXV4Gdb9Whk1F71m5zEH/v3hh5i+2SlqOzMhQVsOgyweV2/Y5Iio7XiX+5sOpPIkie2oodViNAAxsZ0ekWjWV2ehjvcbtZKiNSnnkAHUNgj7QARSM+6VR2UAOnDGYCP5FB6SylAIlPKySr+bZF+sI9p+fTctYt+bAsMWBJpsX6v5oQUgPuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wVgWiVqCAK1uXACrQ+pj3AuaCP6PecOxyZ17+r35ats=;
 b=ZbZM2zHnMuZHMaO7cK0uSnmkQEOXM/s2oeQo1/zOA5wjFa/fY1CCTpgFDaDRTYabrbd73DfciglPqFwdN80dhb3wpkL6mHgZ9SKDzdGKFx3TrLSF+4RXLFFWhjKH2Dl9zqNEr2EDdsjesTnX+vsSsh4tI2GwuzURaNVVoyre/HmEh8nKCvuWlTe610sH0/e8NEMbj2QAIhUc41DPD/aYfABVmnKcBIm1a2YNcRQY/fJ+v4fUbuBl6TT8W1AXyGPy6PUsIC4NjQHPaWRbrar26xdsGOwIhE5Nw9riYKJDfhA4zS5jA+8cZRS62NoZeq+IZetZMJFTZR+qNgOqZ+CNvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wVgWiVqCAK1uXACrQ+pj3AuaCP6PecOxyZ17+r35ats=;
 b=Rzv+Kje5m7ABI9bsphi11E+oVoGPAzovWwvwXHBrgDjlFkzN3TT9nDuhmVVUaPG7okjVzUBG7VGz0M0rsnoC8GY/JejtnV81jNOmAGXMaswcQpTa77688KWdLyWDeCUCDUAjQIiFsHOd5GI7fmE4eIrLwAKK8sMTAn+wXaCfa7w=
Received: from DM6PR04MB6575.namprd04.prod.outlook.com (2603:10b6:5:1b7::7) by
 BN7PR04MB5330.namprd04.prod.outlook.com (2603:10b6:408:b::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5061.25; Mon, 14 Mar 2022 11:10:49 +0000
Received: from DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::941d:9fe8:b1bd:ea4b]) by DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::941d:9fe8:b1bd:ea4b%4]) with mapi id 15.20.5061.028; Mon, 14 Mar 2022
 11:10:49 +0000
From:   Avri Altman <Avri.Altman@wdc.com>
To:     Michael Wu <michael@allwinnertech.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
        "beanhuo@micron.com" <beanhuo@micron.com>,
        "porzio@gmail.com" <porzio@gmail.com>
CC:     "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        allwinner-opensource-support 
        <allwinner-opensource-support@allwinnertech.com>
Subject: RE: [PATCH] mmc: block: enable cache-flushing when mmc cache is on
Thread-Topic: [PATCH] mmc: block: enable cache-flushing when mmc cache is on
Thread-Index: AQHYNcu0Jgralp1XlUCNRLBRM2Fhq6y+dQaAgAAo/4CAAB2sIA==
Date:   Mon, 14 Mar 2022 11:10:49 +0000
Message-ID: <DM6PR04MB657569F6C9B1B58D1E0E08CEFC0F9@DM6PR04MB6575.namprd04.prod.outlook.com>
References: <20220312044315.7994-1-michael@allwinnertech.com>
 <83edf9a1-1712-5388-a3fa-d685f1f581df@intel.com>
 <88e53cb9-791f-ee58-9be8-76ae9986e0e2@allwinnertech.com>
In-Reply-To: <88e53cb9-791f-ee58-9be8-76ae9986e0e2@allwinnertech.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: cbd749ed-ee34-45d4-b975-08da05ab4bca
x-ms-traffictypediagnostic: BN7PR04MB5330:EE_
x-microsoft-antispam-prvs: <BN7PR04MB533092AC726777C4CC887266FC0F9@BN7PR04MB5330.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 77kQ7yVnjPMGrkTB0g5PtsR0DT+P1FoiEbxEtY8IiFPwGSXL3JmzHGL4JdxWbKvlyEvylya65Ne1JCBrdsB7LVloS6n74Hu8TllKg50O/2iRJIITNyJDc8G7CyBs84RMtx0/rJeNQ+jwK6L67j5OkcYHR9oSiA2HELv4YXZajsUKJwonw7xhvTqtZRIYxv6Pu4PkVbcBjkc1oHx2n8a3HWo3YogAtfVAFabLIWE619mvzNCYjwGURUwZc7HeeMy/irHrMoPpqzVWx8waFiihbLWZLoc50W/puCkn08wchpm+4fmxwGKGRsfWrhv2QAOssVRB+pZuHVEdDOVPx3InR5Ix58b0Jz41S56d03disNQhZnNfiJm+a4GVsqBu7I5oKgJEOI0z88fVjUkEJq0PgkMhVOtYTM8jl2IwtF3TBh3DvUVpL8feMhr1fCpYgSO0isFalQ96zXGYqSTdw4x+tFsGdeWZ7FaW3xXU847HiyWlRRXJewz6+KaGvXu67r8+amwZPNEdfKo7xzXHaj/gROktlXC/sIRTTMcmrJRbOdcTyyL5zwmj1aGtcbcvnqkdsZN2ZFOjt/3OJmEEjr4NWydki6rTFY7p4turWmzNv3mkm5yt4cRPXMXwE3xLsFCCCTaeasqXETDeapjf/g+O2wmBGSZQrScC6/UWYihxzsuxs+s0cdt/mK0Oikh4KCDmGfQ9quW3/QNoU2VniA9+ug==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR04MB6575.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(4744005)(5660300002)(66946007)(66556008)(66476007)(66446008)(76116006)(4326008)(8676002)(64756008)(54906003)(110136005)(33656002)(316002)(52536014)(8936002)(83380400001)(55016003)(38070700005)(82960400001)(71200400001)(186003)(26005)(122000001)(9686003)(508600001)(86362001)(6506007)(7696005)(2906002)(38100700002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SDBXM3N1RWYvM3pUYjdZV1RvZm1mbk1JNWNmbVVENHg3RUxKMXNwMUNzcHFk?=
 =?utf-8?B?cUpMRFQvZ3Fab2YvQS9OSENNTS9KVTFLUzN5R2dkbllFS3NVUmVBWXkxc0Zr?=
 =?utf-8?B?eTVBNFVYdzBoVHdyZkFmVlVUR3d0Tzhjb2NiY0h0bWF6aUJ0K3EwQjh1NlVw?=
 =?utf-8?B?Q0x4Mkh4WHhTRHhWREhyZlJyWUpyRlZzRi8rUkcySXNCUVV2eTl6V2M3RkZU?=
 =?utf-8?B?MWhDS0ltcGlTbVJkdlJWNzFIcjBXUnRYekxVN1FWRGM1UVEvQ0MweFJTU0FC?=
 =?utf-8?B?K2RubWI4MTMxQ1FFbHdsWVpEeU90WHpkM1FsM0lEa0pZdDFLbjdZSFlDSnhE?=
 =?utf-8?B?TlBvbGZrOXFhaWp1TnZScTFxbVBGdzhpd3BqSTF2WkdPU0E4d2tVWXI4QXdX?=
 =?utf-8?B?NVQ4dkVlMHl4ZUdQdW9RSVNuSjJia2ZSZWVYeE5LRUxRVnNIWGpDTlFyelk4?=
 =?utf-8?B?VTRrUmpIRmF3V1ZjZUVsbVpJaFRJRStoVnludHExQitaQ29NdjI2R2ZsdmNY?=
 =?utf-8?B?L29SbjY0VkNLZWNsK3Q1b2h1bDFOWkVhcTRHM3dGSVFjWkUvUE5kcE0zbm9w?=
 =?utf-8?B?MU9PZ3JFbjg0OTlxRklNUE1xRkFuOFhXbllhdXhWS1hjL3V5clNsaHM5dkI5?=
 =?utf-8?B?WFluV2JBOWZoeEFpU2k3NTFsNktGTC85Ykw3aWh4bG4wVEFUYzJNYWo5QW9D?=
 =?utf-8?B?cExJYnRIWmdhcDdYOUlJUGI3Q0hvTjN5eFZQOXZJVTZkUll0TnlLdmpQaGw0?=
 =?utf-8?B?SVRYcjROdHlxSVZHUk43MmNqRnJlakFNdC9DRFZjbTB4Q0MrUWp0K0JGcVB1?=
 =?utf-8?B?ZkprQ0kwQ1NkOXliK3JoU21LVWdXSjNvWEFzRlJ4dVF5MjFPRzJydHd6c2ZU?=
 =?utf-8?B?NlNtRTVyY1dPNVdPdXJGYzNMRGkwU1NiS0VjUm5rZW1IQXFiSG50M2p2cGV1?=
 =?utf-8?B?OTV5akhlVGdNYWVDN1pEVy8vRVNYRkswcElpU1doZDMvRGs4Q3M5VS8ramYz?=
 =?utf-8?B?UjE3WW1NVCtsM0JKV1ZzUUVXNDQ5RVQ0cEc2dVpzTDhvaGo2UkptWDg4Y0Rq?=
 =?utf-8?B?d2ZTY2JnVHA4dS9ES2NETmRQM0VZUmVwc245Z1hxd3FoTDZaNGx2bEovYlFM?=
 =?utf-8?B?VXVYcUY0QndZVnFvU1BmTWFST21qaHN2cEgvbXYyMW91RldKRXpFYnllVmha?=
 =?utf-8?B?NG10ZU9SbTF2dFhkakw2MEVTZ0kwNDZqWnQ5SllkcG1ELzlqOGRKZWppWGYz?=
 =?utf-8?B?ekNlampuenFBcmkxR01KN3RsRkloVyt1TXk4UjFqTXlNdVE2L3UvUGMyQ2tD?=
 =?utf-8?B?M3RLVm9ONC9lR2QrMmwvcEN4T0ZsWTRybjRZRXJacUx5S0ZOa21PZWF0dWx4?=
 =?utf-8?B?eURza2RpSDRKb2VrRkNqakZyV2JTcXRxcHFnSmZOc2VDdStqTW56Um1oQWpa?=
 =?utf-8?B?dmphaTdaNFJhS01xcHJpWTBPUmVXa25wSHZpRDBJL2FsNmlBNUs0Q29rRWRp?=
 =?utf-8?B?dWxRcmZPTklTSXFOV21ZeUlvWHBZR1VMTlBYZk0wOEsza2pGRkR5ZHdLZXU1?=
 =?utf-8?B?SUNOYmtLazhsMGxqeWJ6OEc5UlZpeExlb1c2ajVyc08vcEVOUFI5TWdjRkpa?=
 =?utf-8?B?OVViU0FVV2g1ZDY5SmlDRnhJWUJSaHRtSm1RZFZJdXpLWDUzcFhoQ294Qkx0?=
 =?utf-8?B?MDFRSFgyc2piL0dHd0RnVGp2czB5eUpUOU1yOEttRFpYakJhakV5VXNTOHJS?=
 =?utf-8?B?UVo5dDlPWlkwcGduTUlINDVZQ2hYaUJhcm95RWY4N25WK0hyWXRTNmR2aE9F?=
 =?utf-8?B?cTMwY01LQ2pPN1dnSWZqRCt1L2tHejRYcDBMTXp3eHdEenpBUDlyUUVPQ2Fw?=
 =?utf-8?B?eU05M2VxeEF2ZXlraERKSFBZRmd5VGZIbW1BRE1sUG5VVGZycmZWblpEMjZH?=
 =?utf-8?Q?MBIRCKlixX4eH+cRJ29KsR3ZfNNahyce?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR04MB6575.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cbd749ed-ee34-45d4-b975-08da05ab4bca
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Mar 2022 11:10:49.4063
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QFr1ryCsS1QQZ6/HqiScqOczwDpqnyiUhASNjU6l0c84Zy35JthqgWpBCTfF+CLBnTr6s5u6RG01z89DUlyY2Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR04MB5330
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiA+IFNlZW1zIGxpa2Ugd2Ugc2hvdWxkIGluZm9ybSBibG9jayBsYXllciBhYm91dCBTRCBjYXJk
IGNhY2hlIGFsc28NCj4gPg0KPiANCj4gSSBzYXcgYW5vdGhlciBtYWlsIGJ5IEF2cmkgQWx0bWFu
LCB3aGljaCBzYXlzIGZldyBkYXlzIHdpbGwgYmUgbmVlZGVkIHRvIGFzaw0KPiBpbnRlcm5hbGx5
LiBTaGFsbCBJIHdhaXQgb3IgbWFrZSBhbm90aGVyIGNoYW5nZSBoZXJlIG9uICdpbmZvcm0gYmxv
Y2sgbGF5ZXINCj4gYWJvdXQgU0QgY2FyZCBjYWNoZSc/DQpIZXJlIGlzIHdoYXQgb3VyIFNEIHN5
c3RlbSBndXlzIHdyb3RlOg0KIiBJbiBTRCB3ZSBkb27igJl0IHN1cHBvcnQgcmVsaWFibGUgd3Jp
dGUgYW5kIHRoaXMgZU1NQyBkcml2ZXIgbWF5IG5vdCBiZSB1dGlsaXppbmcgdGhlIGNhY2hlIGZl
YXR1cmUgd2UgYWRkZWQgaW4gU0Q1LjAuDQogVGhlIG1ldGhvZCBvZiBjYWNoZSBmbHVzaCBpcyBk
aWZmZXJlbnQgYmV0d2VlbiBTRCBhbmQgZU1NQy4iDQoNClNvIGFkZGluZyBTRCBzZWVtcyB0byBi
ZSBvdXQgb2Ygc2NvcGUgb2YgdGhpcyBjaGFuZ2UuDQoNClRoYW5rcywNCkF2cmkNCg0KPiANCj4g
Pj4NCj4gPj4gICAgICBzdHJpbmdfZ2V0X3NpemUoKHU2NClzaXplLCA1MTIsIFNUUklOR19VTklU
U18yLA0KPiANCj4gLS0NCj4gQmVzdCBSZWdhcmRzLA0KPiBNaWNoYWVsIFd1DQo=
