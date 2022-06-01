Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E458C53AB81
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Jun 2022 19:05:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351847AbiFARFT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Jun 2022 13:05:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344702AbiFARFL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jun 2022 13:05:11 -0400
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55D949EB6D;
        Wed,  1 Jun 2022 10:05:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1654103105; x=1685639105;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=rMjlKmCohsQ8RCCyaPfudRbXSg+rIhCfXAdVbd8NmF8=;
  b=C8Eg0oIh3T60c2rk122NBb9olTMT5BgpUP7hZt6IfnaaMaDk7nZX/GBu
   Nu5Ei2bo9Id4BRU/G4ZkS7EQaenEHEp2mUHzkX6UqTvKcxLNVPklMoFRK
   Jp0OGWljhZ+GC1SEXZSJJnHLZLSIrH398Lzn6Z3J+7o68T8qqBrwkJaoh
   ZxCXFBDAznrHoCRe3NDl8/JvY3zjE5FUi4bghhv4GPnwY1GrrTgEt5V4b
   sN4cVM2nZYd62CfbOEOqsveu35MDGCUWbhJvH8qAQkZuXVrejZJcGsqEK
   a8EgdDOJqLRnM8JudYAFjq3mltP64Yq9gyt9tVbFrJfUxrNKHfITKyPvO
   A==;
X-IronPort-AV: E=Sophos;i="5.91,269,1647273600"; 
   d="scan'208";a="206873273"
Received: from mail-co1nam11lp2173.outbound.protection.outlook.com (HELO NAM11-CO1-obe.outbound.protection.outlook.com) ([104.47.56.173])
  by ob1.hgst.iphmx.com with ESMTP; 02 Jun 2022 01:05:04 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CIDMFwFA6OwMFk7nu3wIcPdA2KVhjMfLhvHOQQEOIm70m1IQGVHdqHmDVekAw+RG4lf9Si1ywnoN2uamFsV27HCdV7bMApOyM08KxFUUQcwHWY4jjDz+RPGC0g6Qi2EDOgQzg62j6WlQJR7iHolkk8quDbM8l9HZExXTWFsRpWiMOCe8Se9cMITSWkj5iUf4hb0dkQH4Lnrah8lOe+QZyC/Dh/v/c+uHwZrNVyBj8NonYtMJYbf9yOugxLvP+qjqX0wkxzFnegmKL9TFyzYeDbYQL+2YML6MBj/OwaRpB5eBQjtmFnk7uLFnidnHZNz/+6CBKQj0aqvdjukUs/yaOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rMjlKmCohsQ8RCCyaPfudRbXSg+rIhCfXAdVbd8NmF8=;
 b=ZgH0N7PhXwbMKKMDRIPJj2NTAb6iH/mMlB9+rVTcVG34zpmNspdpia5NbX6/xMNtLeGxlI7r7LX1KopZPDtvch31Go1RW0fJ4Xr+FzjYGDlOfyhZD/d28xBl3Yu1pMh3o5wMK6jk+/TtqcUJ/B0DIVq626NoBauNvNK/6MbgrGpMvaFbDgrsuuQf8Rt5dUkQxvjTzySlcABsdlQboImI8mJUi7HBmvbvJV1yeY2g5jqI9Vlrw3lBn3ahn3G65r3rxHzciIOIiOm4YQ2+wNkZ2IqZHjI8nb+g5OLPkaXxhT23uZukGuMGUbQoN3JQBVF0IuEwamsAjauG7oz3hyqK/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rMjlKmCohsQ8RCCyaPfudRbXSg+rIhCfXAdVbd8NmF8=;
 b=DHewXUCLkI3u0b3C6s7jNXbdNpuzqcucc+xrPGrK6+oPAYxMxMYqee2gP69lciWiLhPxj+yiSoqe4TnetSUvNDzfk/e6yhG+YOb6oPb0nGIy+o7YvzkHYc+rJ+OTcYh6Gi6mrXMltUELIwHYTsqtxgw1jKq42M/paS0hIyv+Ij4=
Received: from DM6PR04MB6575.namprd04.prod.outlook.com (2603:10b6:5:1b7::7) by
 BYAPR04MB5110.namprd04.prod.outlook.com (2603:10b6:a03:49::31) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5314.12; Wed, 1 Jun 2022 17:05:03 +0000
Received: from DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::cc4e:5a1e:e4a:e3fb]) by DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::cc4e:5a1e:e4a:e3fb%3]) with mapi id 15.20.5293.019; Wed, 1 Jun 2022
 17:05:03 +0000
From:   Avri Altman <Avri.Altman@wdc.com>
To:     Caleb Connolly <caleb.connolly@linaro.org>,
        "a5b6@riseup.net" <a5b6@riseup.net>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        "James E . J . Bottomley" <jejb@linux.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "~postmarketos/upstreaming@lists.sr.ht" 
        <~postmarketos/upstreaming@lists.sr.ht>,
        "phone-devel@vger.kernel.org" <phone-devel@vger.kernel.org>
Subject: RE: RE: [RESEND PATCH] scsi: ufs: sysfs: support writing boot_lun
 attr
Thread-Topic: RE: [RESEND PATCH] scsi: ufs: sysfs: support writing boot_lun
 attr
Thread-Index: AQHYcFYp99UCK0BeAUyoAx4mv1ya/K0v5+fAgAGxOoCAAKiPUIAAbjMAgAgiHeA=
Date:   Wed, 1 Jun 2022 17:05:03 +0000
Message-ID: <DM6PR04MB65751A3B1D0BA4467CADDA93FCDF9@DM6PR04MB6575.namprd04.prod.outlook.com>
References: <20220525164013.93748-1-a5b6@riseup.net>
 <DM6PR04MB65750969ACD36EEEB48374DFFCD69@DM6PR04MB6575.namprd04.prod.outlook.com>
 <8d25171a-5d86-9acc-0f94-1a3c6efdb360@riseup.net>
 <DM6PR04MB65752422396C86EAD4591701FCD89@DM6PR04MB6575.namprd04.prod.outlook.com>
 <a7f46ad1-6d9e-a38e-31cc-29fddfa2b496@linaro.org>
In-Reply-To: <a7f46ad1-6d9e-a38e-31cc-29fddfa2b496@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c0b910d1-52a4-4efb-769f-08da43f0defb
x-ms-traffictypediagnostic: BYAPR04MB5110:EE_
x-microsoft-antispam-prvs: <BYAPR04MB5110024DC0989682D4CAAECEFCDF9@BYAPR04MB5110.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: h5uUYT1O/YCOkJ3bHYRWsFy/KR9cFS3+K8hlS/Oi/Fl0UsQB/gFeBg9i0243YBnF+3f1Am2loG2QhuYkWFTq0OLuPos8vskI2YlCKVyXu9K4M+YDTm8p5wOxdaZzRkyU6ygXTTeHp0IkXg9EiZGFpLnP+cBC/EMZre/vAiBjw7uuiCqicjLSpGSFywN4NKZymt5ruzdw6xxf3FZFH6i0tHZz41xryqPVFRnDP3zvkj9YYKJy0IPjGsHunjovEUSjlgJsgyTCorW0L7Mq8KRxYmiMnAigtSofhAsopVFb1nK69WS4VpJcc1uFRpOCrLvV/ZEw1ays3T2J7f1LL2Ds+QOdZ8u90W/BWPxs60/gPFc00szK4oC7VlsqoAmHW2Zj45tIOq/WfC8I3H2nHBIdCuKa3j3n8ITjlWuTgZqIoeSrcZF1DS/Vo50u6i2x0CSW5VsGkefGxR8E5zSfieMIqmEQtgi9hHdIrkAG9Hn4OX6eC3MrgYHuSj9Go5lNzhG4m0zDlwxN/P1+CXLbNy/gA9W75D5kXNJnR3y1wpeTFSQpku489V9JiRVeiz1wF79deBESx8dqjfTafAM5ohy77y+pEfH6wo9cY3Xe+iJuW77l7iIItzwFe6py252yEhWIjVxD9R2q4i6CXgOWOc5dZYaT0HJtxXsW4zNiqsxFckJSsW/pQoFv2sgLIbqVNGswdSbG7EaXL2GFudGXQ1tNvcWef03di/fzkywN0o0uSB0w7PF8wzq9sSVeWkiuBCR8gjVMIfoNUxyC5sz/BlRFfeXi2hbOjW062Uh4tsYKyxU=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR04MB6575.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(33656002)(52536014)(8936002)(64756008)(186003)(66446008)(55016003)(122000001)(66476007)(66556008)(76116006)(38070700005)(82960400001)(86362001)(38100700002)(5660300002)(8676002)(6506007)(4326008)(508600001)(66946007)(53546011)(7696005)(26005)(110136005)(9686003)(54906003)(2906002)(316002)(71200400001)(83380400001)(966005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WHFRUzFHeW93aFFYa3ZvNUM0N2VmREE2R2FLOHlxQ0E2dmhTeVRIcDRtNFVu?=
 =?utf-8?B?emJYaE9HdlZIRXU5NUErWTNQZmM1bjlRWnpPR3Y3Wmsxd1NReDh3djB6bDFs?=
 =?utf-8?B?dnVOR1kvZGNwWlVScjRkdXZMRE5zdFpYa21OdktrSk1JTms5MCtHT21NWXVh?=
 =?utf-8?B?U3V5VU15U1dneTQreStITlB6SVdSUFRQRkJSclMvYmJCamVpa2JjTGdxNDdC?=
 =?utf-8?B?d1krZTc4TG5qb0tTWkN2L0JkVFNFS0ZLRHhrZTJsMm9ha0pjRWJueThpV01I?=
 =?utf-8?B?NXZEdGlmUWFIRTZUeng1UkZYekIxc3YwUmRyMk5VZXZmbklPdnNRLzR0bHlB?=
 =?utf-8?B?SWsxUnZBNUhZWGxhbjh6b296VTJiVGd4S0lPRmJBREhBU2t0bzhCQlBZNEdG?=
 =?utf-8?B?Y2l4TkdhdkZlRy9ZUUlyYm9aZGwzcU9XTXVEV0VaVjJwaUNFWUtDUHB1cXY1?=
 =?utf-8?B?T1ZwQnlldThKMkw3OWJhSS8zOStQMll0dWo3Q2wxcC94QXRXVVh4bklmUUhp?=
 =?utf-8?B?bFV6TTF4S3daRHNVUCtLUDY1VEt6Z3Y0cUY1YTZicnRjTko5UEN2Yk9aSWR0?=
 =?utf-8?B?U1JRbkJqNjdjOXdCcnVPcFRycDJXblJZbUVZUnlBcG51Zzc4MWN0ZERCblQx?=
 =?utf-8?B?YUxFanZlMnM0cFFBQ1NTR1Q3bU5OWXpRaitDZkFPS0t1TVpWaGZzOFpJaDl6?=
 =?utf-8?B?eW1TRHhMUXBuc1RGM05Wa2dvZTlGdk9sV0ZzdkZvTC9nZHkyVUp4cnVSRWlo?=
 =?utf-8?B?TW1PQTlJR3RoM2NVNU5sWTN1OHhSMnFpdEtqVWt0T0R4NG56Vyt4RXRNeVFo?=
 =?utf-8?B?Sm9QS09leVVla1A3UzVzNHlxbml5bTNlZXd6Z2MrSG1EQ3lLMDhVZEpVUG52?=
 =?utf-8?B?dHdZQnRyd001YmtTN3owSWRhRk1OczFDRmlzYVpUejh2VUhuMnJSdno1MFpY?=
 =?utf-8?B?MWVRS1V0QjVqOWo4eHpiSTFCU3FNaEp1Vm1NVndXd0U4bWxNdDRUdVlhTkZk?=
 =?utf-8?B?cEZxdlRrc1VDSi9FUUxFRDZxaERreThxOWdpSmRPRlVPQ3ljcUdRMjI5RXNu?=
 =?utf-8?B?enJ1c0VYazQ2NnNtb1p1U2hXVVdjQWt4bWlBQUlyZHFHbkVrSTZoU1UzWEpF?=
 =?utf-8?B?QlhXOERkSW95U2ZyOHdxSUFRdUNaMzMxWWpuS0VOZXZaU05xaGkvSXFTdDM1?=
 =?utf-8?B?aGFJaFE0bmgwWW81a2NuRG5yQnBXbysxUmNuNDNweHdzRGtuOXNoQUNXbkNl?=
 =?utf-8?B?TkJLOVh0RG9BYmVWSVIwdDJZUHhZUlZKSzBQeWZMbkJPRUN2S1R4UXVOWnlT?=
 =?utf-8?B?eVVoUFhxaWlwZ2dKSEl4UktMbnBPQjRNM21yNys4WXY0SWxDMjlwWXBTaW95?=
 =?utf-8?B?ODUralZwQ281MjU3eFNOVEtnSVhKSkdCVEdwUk9yNW4rQTJRMEl1TVY1NXNJ?=
 =?utf-8?B?bFd0MEFNSlNabGUyK1JaajN4b214VzgwRFd3cnAwT0dHZDFQbE8zenNSME41?=
 =?utf-8?B?UzNibDRiL3MwRHBQeEJyTzgxSzJ6bjMvOU5LMUhMK3dLMThXWVdZMTRzTHBE?=
 =?utf-8?B?STVreEtSczZCVnM0Wm1oOFR3eVd5MjBWbk16ZHZSOFovNjR3TUY1OWIrcmJS?=
 =?utf-8?B?cFFHNXpRTzdubjVtTFF2WFZMdnZBQi8zZnJCdG5FU3ByaVZDbVE5NGdzcUdy?=
 =?utf-8?B?RWlvUlhIdk9CdzY1VENBTy9IVFZ1NktNdk5kV2Jvc1Naa3lSUTBuYXhPRjBl?=
 =?utf-8?B?em40MkpQWk02S2NJc3pUWVlyYlc2WWk4eUJ1aVZ3cFhncDhudU4wOEFtOVFZ?=
 =?utf-8?B?UTI4YXVJcmdVVTZTaElGeEFHbmc2MUQ4K0hMZXc1Y2xnZ3BNc0NEOEN1R2Ny?=
 =?utf-8?B?NUE4UndBWUVObk5waTRaT2dFUlN1RHZGWGdnOGtBLzhQTUZEZThiMDlBUWk4?=
 =?utf-8?B?anhMVUVzaTF5eXBrOTBmMVRCdG8ydk5HOXYyRysxcktJQ0pCNHVGd0gyL0tY?=
 =?utf-8?B?SlIyOGdrVDBEWGphZVpyWnYvNTl6RWdxV1g3WHV2a0VIRkxNV1RLRytxcVor?=
 =?utf-8?B?dCtyenV4djNpNjR6dlF5QlFjS1ZLQlZ5WC9pQkhuS3VuelRJblJWVk0xTnpq?=
 =?utf-8?B?NlRnNXpEMFkwNGsrQ2syT2liaytDU2ZMU0hDNmJ0anlFam1oRG1sY0VEdGc1?=
 =?utf-8?B?dUVGZERxeU44QS9tdnFURncrZzdmV0c4VmdPR3dYendzZGxzRkhhNUU4bWNn?=
 =?utf-8?B?MHBRQnpZSEFRZVprREFsNWJtS3N1Ky85ZHQ5QzJMSFlvZ3k1WnVvYW1PU2xv?=
 =?utf-8?B?S3o2UzEzVHhJUDBrTDRIbGFwdU1UQVBpVXNqNW55Ry9XS2t3MFlIUT09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR04MB6575.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c0b910d1-52a4-4efb-769f-08da43f0defb
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Jun 2022 17:05:03.8267
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1y/8avT2jraZPCh8m4hHYNoTA7kFU3nRDMR97FsTVLB2HzoBevvBdJDj3soqPMrxaf5QvCDphJlDxKHqmd7eEA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB5110
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgQ2FsZWIsDQoNCj4gT24gMjcvMDUvMjAyMiAwNzoxNywgQXZyaSBBbHRtYW4gd3JvdGU6DQo+
ID4+DQo+ID4+IEhpLA0KPiA+Pg0KPiA+PiBNeSB1c2VjYXNlIGlzIGVuYWJsaW5nIGJvb3Qgc2xv
dCBzd2l0Y2hpbmcgb24gQW5kcm9pZCBBL0IgZGV2aWNlcywNCj4gPj4gd2hlcmUgdGhlIGFjdGl2
ZSBMVU4gaGFzIHRvIGJlIGNoYW5nZWQgaW4gb3JkZXIgdG8gZmFjaWxpdGF0ZSBlLmcuDQo+ID4+
IGR1YWwtYm9vdGluZyBBbmRyb2lkIGFuZCBtYWlubGluZSBMaW51eC4gQSBzaW1pbGFyIGludGVy
ZmFjZSBpcw0KPiA+PiBleHBvc2VkIGJ5IEFuZHJvaWQsIGFsYmVpdCB2aWEgaW9jdGwuIEkndmUg
dGVzdGVkIHRoaXMgcGF0Y2ggYW5kIGNvbmZpcm1lZCBpdA0KPiBlbmFibGVkIHRoZSBuZWNlc3Nh
cnkgZnVuY3Rpb25hbGl0eS4NCj4gPj4NCj4gPj4gT24gMjUvMDUvMjAyMiAyMTozNCwgQXZyaSBB
bHRtYW4gd3JvdGU6DQo+ID4+PiBIaSwNCj4gPj4+PiBFeHBhbmRzIHN5c2ZzIGJvb3RfbHVuIGF0
dHJpYnV0ZSB0byBiZSB3cml0YWJsZS4gTmVjZXNzYXJ5IHRvDQo+ID4+Pj4gZW5hYmxlIHByb3Bl
ciBzdXBwb3J0IGZvciBMVU4gc3dpdGNoaW5nIG9uIHNvbWUgVUZTIGRldmljZXMuDQo+ID4+PiBD
YW4geW91IHBsZWFzZSBlbGFib3JhdGUgd2h5IGlzIGl0IG5lY2Vzc2FyeT8NCj4gPj4+IFdoYXQg
dXNlIGNhc2UgYXJlIHlvdSBydW5uaW5nPw0KPiA+IE5BSyB3aXRoIHByZWp1ZGljZS4NCj4gSGkg
QXZyaSwNCj4gDQo+IENvdWxkIHlvdSBleHBsYWluIHdoeSB0aGUgTkFLIGhlcmU/IEJvb3QgTFVO
IHN3aXRjaGluZyBpcyB1c2VkIG9uIGEgbG90IG9mDQo+IGVtYmVkZGVkIGRldmljZXMgdG8gaW1w
bGVtZW50IEEvQiB1cGRhdGVzLCBBbmRyb2lkIGRldmljZXMgYXJlIGp1c3Qgb25lIHN1Y2gNCj4g
ZXhhbXBsZS4NClNvcnJ5IGZvciBub3QgZ2l2aW5nIGEgcHJvcGVyIGV4cGxhbmF0aW9uLg0KQXMg
YSBkZXNpZ24gcnVsZSwgc3lzZnMgYXR0cmlidXRlIGZpbGVzIHNob3VsZCBub3QgYmUgdXNlZCB0
byBtYWtlIHBlcnNpc3RlbnQgbW9kaWZpY2F0aW9ucw0KdG8gYSBkZXZpY2UgY29uZmlndXJhdGlv
bi4gVGhpcyBydWxlIGFwcGxpZXMgdG8gYWxsIHN1YnN5c3RlbXMgYW5kIHVmcyBpcyBubyBkaWZm
ZXJlbnQuDQoNCj4gDQo+IERpc3RyaWJ1dGlvbnMgbGlrZSBwb3N0bWFya2V0T1MgWzFdIGFpbSB0
byBzdXBwb3J0IHVwc3RyZWFtIExpbnV4IG9uIG1vYmlsZQ0KPiBkZXZpY2VzLCBwYXJ0aWN1bGFy
bHkgdGhvc2UgdGhhdCBhcmUgbm8gbG9uZ2VyIHN1cHBvcnRlZCBieSB0aGUgdmVuZG9yLiBCZWlu
Zw0KPiBhYmxlIHRvIG1ha2UgdXNlIG9mIGZlYXR1cmVzIGxpa2UgQS9CIHVwZGF0ZXMgaXMgc29t
ZXRoaW5nIHRoYXQgSSBleHBlY3QgbW9yZQ0KPiBkaXN0cmlidXRpb25zIHRvIGJlIGNvbnNpZGVy
aW5nIGluIHRoZSBmdXR1cmUsIGFzIHdlIHN0YXJ0IHRvIHNlZSBtb3JlIExpbnV4DQo+IGRldmlj
ZXMgd2l0aCBzdXBwb3J0IGZvciBmZWF0dXJlcyBsaWtlIHRoaXMuDQpDaGFuZ2luZyBhIFVGUyBk
ZXZpY2UgY29uZmlndXJhdGlvbiBjYW4gYmUgZG9uZSB1c2luZyB0aGUgdWZzLWJzZyBmcmFtZXdv
cmsuDQpUaGlzIGZyYW1ld29yayBwcm92aWRlcyBhIGNvbW1hbmQgcGFzc3Rocm91Z2ggaW50ZXJm
YWNlIHdpdGggdGhlIC9kZXYvdWZzLWJzZ1gNCmJzZyBub2RlLiBGb3IgZXhhbXBsZXMgb24gaG93
IHRvIHVzZSB0aGlzLCB5b3UgY2FuIHNlZSB0aGUgdWZzLXV0aWxzIHByb2plY3Q6DQpodHRwczov
L2dpdGh1Yi5jb20vd2VzdGVybmRpZ2l0YWxjb3Jwb3JhdGlvbi91ZnMtdXRpbHMNCg0KVGhhbmtz
LA0KQXZyaQ0KDQo+IA0KPiBJZiBzYWZldHkgaXMgYSBjb25jZXJuLCBvciBpZiB0aGUgdmFsdWVz
IGFyZSBkZXZpY2Ugc3BlY2lmaWMsIHdlIGNhbiBsb29rIGF0DQo+IHByb3RlY3RpbmcgdGhlIHdy
aXRlIGZ1bmN0aW9uYWxpdHkgYW5kIGNvbmZpZ3VyYXRpb24gYmVoaW5kIERUIHByb3BlcnRpZXMs
IG9yDQo+IGNvbWluZyB1cCB3aXRoIGFub3RoZXIgYWx0ZXJuYXRpdmUuDQo+IA0KPiBbMV06IGh0
dHBzOi8vcG9zdG1hcmtldG9zLm9yZw0KPiANCj4gS2luZCByZWdhcmRzLA0KPiBDYWxlYiAodGhl
eS9oZSkNCj4gDQo+ID4NCj4gPiBUaGFua3MsDQo+ID4gQXZyaQ0KPiA+DQo+ID4+Pg0KPiA+Pj4+
IFNpZ25lZC1vZmYtYnk6IE5pYSBFc3BlcmEgPGE1YjZAcmlzZXVwLm5ldD4NCj4gPj4+PiAtLS0N
Cj4gPj4+PiAgICBkcml2ZXJzL3Njc2kvdWZzL3Vmcy1zeXNmcy5jIHwgNjcNCj4gKysrKysrKysr
KysrKysrKysrKysrKysrKysrKysrKysrKystDQo+ID4+Pj4gICAgMSBmaWxlIGNoYW5nZWQsIDY2
IGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkNCj4gPj4+Pg0KPiA+Pj4+IGRpZmYgLS1naXQg
YS9kcml2ZXJzL3Njc2kvdWZzL3Vmcy1zeXNmcy5jDQo+ID4+Pj4gYi9kcml2ZXJzL3Njc2kvdWZz
L3Vmcy1zeXNmcy5jIGluZGV4IDVjNDA1ZmY3YjZlYS4uN2JmNWQ2YzNkMGVjDQo+ID4+Pj4gMTAw
NjQ0DQo+ID4+Pj4gLS0tIGEvZHJpdmVycy9zY3NpL3Vmcy91ZnMtc3lzZnMuYw0KPiA+Pj4+ICsr
KyBiL2RyaXZlcnMvc2NzaS91ZnMvdWZzLXN5c2ZzLmMNCj4gPj4+PiBAQCAtMTA0Nyw2ICsxMDQ3
LDcxIEBAIHN0YXRpYyBpbmxpbmUgYm9vbCB1ZnNoY2RfaXNfd2JfYXR0cnMoZW51bQ0KPiA+Pj4+
IGF0dHJfaWRuDQo+ID4+Pj4gaWRuKQ0KPiA+Pj4+ICAgICAgICAgICAgICAgICAgIGlkbiA8PSBR
VUVSWV9BVFRSX0lETl9DVVJSX1dCX0JVRkZfU0laRTsNCj4gPj4+PiAgICB9DQo+ID4+Pj4NCj4g
Pj4+PiArc3RhdGljIHNzaXplX3QgYm9vdF9sdW5fZW5hYmxlZF9zaG93KHN0cnVjdCBkZXZpY2Ug
KmRldiwNCj4gPj4+PiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgc3RydWN0
IGRldmljZV9hdHRyaWJ1dGUgKmF0dHIsDQo+ID4+Pj4gK2NoYXIgKmJ1Zikgew0KPiA+Pj4+ICsg
ICAgICAgc3RydWN0IHVmc19oYmEgKmhiYSA9IGRldl9nZXRfZHJ2ZGF0YShkZXYpOw0KPiA+Pj4+
ICsgICAgICAgdTMyIHNsb3Q7DQo+ID4+Pj4gKyAgICAgICBpbnQgcmV0Ow0KPiA+Pj4+ICsgICAg
ICAgdTggaW5kZXggPSAwOw0KPiA+Pj4+ICsNCj4gPj4+PiArICAgICAgIGRvd24oJmhiYS0+aG9z
dF9zZW0pOw0KPiA+Pj4+ICsgICAgICAgaWYgKCF1ZnNoY2RfaXNfdXNlcl9hY2Nlc3NfYWxsb3dl
ZChoYmEpKSB7DQo+ID4+Pj4gKyAgICAgICAgICAgICAgIHVwKCZoYmEtPmhvc3Rfc2VtKTsNCj4g
Pj4+PiArICAgICAgICAgICAgICAgcmV0dXJuIC1FQlVTWTsNCj4gPj4+PiArICAgICAgIH0NCj4g
Pj4+PiArICAgICAgIGlmICh1ZnNoY2RfaXNfd2JfYXR0cnMoUVVFUllfQVRUUl9JRE5fQk9PVF9M
VV9FTikpDQo+ID4+PiBDbGVhcmx5IGJCb290THVuRW4gaXMgbm90IGEgV0IgYXR0cmlidXRlLg0K
PiA+Pj4NCj4gPj4+PiArICAgICAgICAgICAgICAgaW5kZXggPSB1ZnNoY2Rfd2JfZ2V0X3F1ZXJ5
X2luZGV4KGhiYSk7DQo+ID4+Pj4gKyAgICAgICB1ZnNoY2RfcnBtX2dldF9zeW5jKGhiYSk7DQo+
ID4+Pj4gKw0KPiA+Pj4+ICsgICAgICAgcmV0ID0gdWZzaGNkX3F1ZXJ5X2F0dHIoaGJhLCBVUElV
X1FVRVJZX09QQ09ERV9SRUFEX0FUVFIsDQo+ID4+Pj4gKyAgICAgICAgICAgICAgIFFVRVJZX0FU
VFJfSUROX0JPT1RfTFVfRU4sIGluZGV4LCAwLCAmc2xvdCk7DQo+ID4+Pj4gKw0KPiA+Pj4+ICsg
ICAgICAgdWZzaGNkX3JwbV9wdXRfc3luYyhoYmEpOw0KPiA+Pj4+ICsgICAgICAgaWYgKHJldCkg
ew0KPiA+Pj4+ICsgICAgICAgICAgICAgICByZXQgPSAtRUlOVkFMOw0KPiA+Pj4+ICsgICAgICAg
ICAgICAgICBnb3RvIG91dDsNCj4gPj4+PiArICAgICAgIH0NCj4gPj4+PiArDQo+ID4+Pj4gKyAg
ICAgICByZXQgPSBzeXNmc19lbWl0KGJ1ZiwgIjB4JTA4WFxuIiwgc2xvdCk7DQo+ID4+Pj4gK291
dDoNCj4gPj4+PiArICAgICAgIHVwKCZoYmEtPmhvc3Rfc2VtKTsNCj4gPj4+PiArICAgICAgIHJl
dHVybiByZXQ7DQo+ID4+Pj4gK30NCj4gPj4+PiArDQo+ID4+Pj4gK3N0YXRpYyBzc2l6ZV90IGJv
b3RfbHVuX2VuYWJsZWRfc3RvcmUoc3RydWN0IGRldmljZSAqZGV2LA0KPiA+Pj4+ICsgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgc3RydWN0IGRldmljZV9hdHRyaWJ1dGUgKmF0
dHIsDQo+ID4+Pj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBjb25zdCBj
aGFyICpidWYsIHNpemVfdA0KPiA+Pj4+ICtjb3VudCkgew0KPiA+Pj4+ICsgICAgICAgc3RydWN0
IHVmc19oYmEgKmhiYSA9IGRldl9nZXRfZHJ2ZGF0YShkZXYpOw0KPiA+Pj4+ICsgICAgICAgdTMy
IHNsb3Q7DQo+ID4+Pj4gKyAgICAgICBpbnQgcmV0Ow0KPiA+Pj4+ICsgICAgICAgdTggaW5kZXgg
PSAwOw0KPiA+Pj4+ICsNCj4gPj4+PiArICAgICAgIGlmIChrc3RydG91aW50KGJ1ZiwgMCwgJnNs
b3QpIDwgMCkNCj4gPj4+PiArICAgICAgICAgICAgICAgcmV0dXJuIC1FSU5WQUw7DQo+ID4+PiBZ
b3UgbmVlZCB0byB2ZXJpZnkgdGhhdCBubyBvbmUgc2V0IGJCb290THVuRW4gPSAweDAgYmVjYXVz
ZSB0aGUNCj4gPj4+IGRldmljZSB3b24ndA0KPiA+PiBib290Lg0KPiA+Pj4gQmV0dGVyIGNoZWNr
IGV4cGxpY2l0bHkgdGhhdCBzbG90ICE9IGJCb290THVuRW4gYW5kIGl0cyBlaXRoZXIgMSBvciAy
Lg0KPiA+Pj4NCj4gPj4+IFRoYW5rcywNCj4gPj4+IEF2cmkNCj4gPj4+DQo+ID4+Pj4gKw0KPiA+
Pj4+ICsgICAgICAgZG93bigmaGJhLT5ob3N0X3NlbSk7DQo+ID4+Pj4gKyAgICAgICBpZiAoIXVm
c2hjZF9pc191c2VyX2FjY2Vzc19hbGxvd2VkKGhiYSkpIHsNCj4gPj4+PiArICAgICAgICAgICAg
ICAgdXAoJmhiYS0+aG9zdF9zZW0pOw0KPiA+Pj4+ICsgICAgICAgICAgICAgICByZXR1cm4gLUVC
VVNZOw0KPiA+Pj4+ICsgICAgICAgfQ0KPiA+Pj4+ICsgICAgICAgaWYgKHVmc2hjZF9pc193Yl9h
dHRycyhRVUVSWV9BVFRSX0lETl9CT09UX0xVX0VOKSkNCj4gPj4+PiArICAgICAgICAgICAgICAg
aW5kZXggPSB1ZnNoY2Rfd2JfZ2V0X3F1ZXJ5X2luZGV4KGhiYSk7DQo+ID4+Pj4gKyAgICAgICB1
ZnNoY2RfcnBtX2dldF9zeW5jKGhiYSk7DQo+ID4+Pj4gKw0KPiA+Pj4+ICsgICAgICAgcmV0ID0g
dWZzaGNkX3F1ZXJ5X2F0dHJfcmV0cnkoaGJhLA0KPiA+PiBVUElVX1FVRVJZX09QQ09ERV9XUklU
RV9BVFRSLA0KPiA+Pj4+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgUVVF
UllfQVRUUl9JRE5fQk9PVF9MVV9FTiwgaW5kZXgsIDAsICZzbG90KTsNCj4gPj4+PiArICAgICAg
IHVmc2hjZF9ycG1fcHV0X3N5bmMoaGJhKTsNCj4gPj4+PiArICAgICAgIGlmIChyZXQpIHsNCj4g
Pj4+PiArICAgICAgICAgICAgICAgcmV0ID0gLUVJTlZBTDsNCj4gPj4+PiArICAgICAgICAgICAg
ICAgZ290byBvdXQ7DQo+ID4+Pj4gKyAgICAgICB9DQo+ID4+Pj4gK291dDoNCj4gPj4+PiArICAg
ICAgIHVwKCZoYmEtPmhvc3Rfc2VtKTsNCj4gPj4+PiArICAgICAgIHJldHVybiByZXQgPyByZXQg
OiBjb3VudDsNCj4gPj4+PiArfQ0KPiA+Pj4+ICsNCj4gPj4+PiAgICAjZGVmaW5lIFVGU19BVFRS
SUJVVEUoX25hbWUsIF91bmFtZSkgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIFwN
Cj4gPj4+PiAgICBzdGF0aWMgc3NpemVfdCBfbmFtZSMjX3Nob3coc3RydWN0IGRldmljZSAqZGV2
LCAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgXA0KPiA+Pj4+ICAgICAgICAgICBzdHJ1
Y3QgZGV2aWNlX2F0dHJpYnV0ZSAqYXR0ciwgY2hhciAqYnVmKSAgICAgICAgICAgICAgICAgICAg
ICAgXA0KPiA+Pj4+IEBAIC0xMDc3LDggKzExNDIsOCBAQCBvdXQ6ICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIFwNCj4g
Pj4+PiAgICAgICAgICAgcmV0dXJuIHJldDsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgIFwNCj4gPj4+PiAgICB9ICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIFwNCj4gPj4+
PiAgICBzdGF0aWMgREVWSUNFX0FUVFJfUk8oX25hbWUpDQo+ID4+Pj4gK3N0YXRpYyBERVZJQ0Vf
QVRUUl9SVyhib290X2x1bl9lbmFibGVkKTsNCj4gPj4+Pg0KPiA+Pj4+IC1VRlNfQVRUUklCVVRF
KGJvb3RfbHVuX2VuYWJsZWQsIF9CT09UX0xVX0VOKTsNCj4gPj4+PiAgICBVRlNfQVRUUklCVVRF
KG1heF9kYXRhX3NpemVfaHBiX3NpbmdsZV9jbWQsDQo+ID4+IF9NQVhfSFBCX1NJTkdMRV9DTUQp
Ow0KPiA+Pj4+ICAgIFVGU19BVFRSSUJVVEUoY3VycmVudF9wb3dlcl9tb2RlLCBfUE9XRVJfTU9E
RSk7DQo+ID4+Pj4gICAgVUZTX0FUVFJJQlVURShhY3RpdmVfaWNjX2xldmVsLCBfQUNUSVZFX0lD
Q19MVkwpOw0KPiA+Pj4+IC0tDQo+ID4+Pj4gMi4zNi4xDQo=
