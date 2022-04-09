Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E97B34FA61E
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Apr 2022 11:03:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236095AbiDIJFh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Apr 2022 05:05:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229875AbiDIJFe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Apr 2022 05:05:34 -0400
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B3232BC0;
        Sat,  9 Apr 2022 02:03:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1649495005; x=1681031005;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=QBoqVqahDGSGENbPwemtpBtZGzASjLCNohPllSBnwqo=;
  b=Oy1sUbnwKSrXRcRlcBRRrzw0le/kHAKI+icGjA/MWoneBOsMu4uZPupp
   x2BXKHEtyWPPAuPfiBk+XD2WfE1JYN5xxyZEO//w223fFvCi24tt4UrrP
   qFojnHSbTAWPOHa8AoRVwIhqhAHSMak/Z8U3mRXeq0z+KFaPwp9EJUxOM
   +SLXYbRpWamFMJTTSKSHxgKuciugk3BrqKL7gwOGgpFwJCPt72HyRMKsb
   Xjk9QStJr5fkMqnm87pbrmWw57/UC7PzpSYFPEFQ4mmxQRT2zlIDqTIzC
   IBqHIjsAjbTkYy7MdI8nIkzKfOlQIYpr33iqoZno1YcbqWkRg4w/rFGWi
   g==;
X-IronPort-AV: E=Sophos;i="5.90,247,1643644800"; 
   d="scan'208";a="202360776"
Received: from mail-mw2nam10lp2107.outbound.protection.outlook.com (HELO NAM10-MW2-obe.outbound.protection.outlook.com) ([104.47.55.107])
  by ob1.hgst.iphmx.com with ESMTP; 09 Apr 2022 17:03:23 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E7qiBCyPXn0bWaq89LxcVo2Nr3LJCPEc5NrjdOHG+GCSA+L2gssUWQKKOehHx8YIUN0tQGVGEledglr0u1rWbEIN8EI3e2R5fMRj8IuvLBYfA5rnGYPbGVp9bqzPdZ1EtGcDfB7hj4rk6DKqEB01msk6kX1vONorkg86u2PABHxrvmcpPEJtZWgJHju/DGxyuorXaVvZoJsY8lqC6kMmGV4witOd2b2P2JUzty8iRUX7tVMnIfCl0MM1ha0aXau8J2HQCK0A7SlrTUxv0/EaS/VYl0AB0gzhvoa35rqWsQc95nXO3o6rBvwRHeOSpymPvPRSs47AiQnDjb+AW8sRTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QBoqVqahDGSGENbPwemtpBtZGzASjLCNohPllSBnwqo=;
 b=Um0WFAEHLrJ40rm+tw6DXK4UeYGWd1MUdjgteCEkp4s5FImT0/OCEP+5PPxs3csc6JKBNeg02/e9V65KbdNPLHD1PgZfEWStPPjisqn6l2wZWq/Nz2E9FVLFGQFPrbxsdaPZHHfqpK0jdCRIRagzLP9LWeUGtxUeB+qpMi5ed7NBL0IFx6CkNlVd0D6ie145L6L+eaQCeuJB6ilmsUP2r2VSBLjNJX57pgnMo/ySGS5UTaDrNAnempFhj2aXcmNx44RgZ1A1qyWsf8Gn22yVIUpI0QmDRgd7bElm4MyvmMHU/n127+zJZ3i9taEuuz9EPm/DJI6H9PRk+BHqXsFBfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QBoqVqahDGSGENbPwemtpBtZGzASjLCNohPllSBnwqo=;
 b=JSl96MQNjOpjKGYebUPa2riJfoRIlbV6oaJoZ6o9/doyZBqMiKqSiFPgO2l3+SoGWkvOB9lPrLWMDUDmQXCJntuM4fuaz004PxMPRiVeGfcslQt/gxkdE3q+uvE4WqyssgEKyjsyDJ/kxFxt4vApN6Mu6+RYqHdIJCZ8Mup4BEs=
Received: from DM6PR04MB6575.namprd04.prod.outlook.com (2603:10b6:5:1b7::7) by
 MWHPR04MB0575.namprd04.prod.outlook.com (2603:10b6:300:7e::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5144.26; Sat, 9 Apr 2022 09:03:21 +0000
Received: from DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::6997:f415:556b:532b]) by DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::6997:f415:556b:532b%6]) with mapi id 15.20.5144.027; Sat, 9 Apr 2022
 09:03:21 +0000
From:   Avri Altman <Avri.Altman@wdc.com>
To:     Bean Huo <huobean@gmail.com>,
        "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
        "adrian.hunter@intel.com" <adrian.hunter@intel.com>
CC:     "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "jakob.rossler@nokia.com" <jakob.rossler@nokia.com>,
        "sperson@micron.com" <sperson@micron.com>,
        Bean Huo <beanhuo@micron.com>
Subject: RE: [PATCH v1] mmc-utils: Add General command CMD56 read support
Thread-Topic: [PATCH v1] mmc-utils: Add General command CMD56 read support
Thread-Index: AQHYS3IuzGSpa8VMXkGTy5wsoWR50aznRZ5Q
Date:   Sat, 9 Apr 2022 09:03:21 +0000
Message-ID: <DM6PR04MB6575816F943FB2F0D4099CDFFCE89@DM6PR04MB6575.namprd04.prod.outlook.com>
References: <20220408174832.303915-1-huobean@gmail.com>
In-Reply-To: <20220408174832.303915-1-huobean@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 149183f5-fad2-4a55-33d8-08da1a07cbff
x-ms-traffictypediagnostic: MWHPR04MB0575:EE_
x-microsoft-antispam-prvs: <MWHPR04MB0575DD2A1B2C51D04C52875BFCE89@MWHPR04MB0575.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: c4k2uc3odyS937R3geQdV2FQhq4ZpRmt3K0g+ttHGm/K1bRX67ciWjPyUcx305ejjudGoJWEGzf8pjzZFkoCw65EfnzoFslnGwhG/c3E6v0rGH8nm7iWsxEG7HhjfgXzQ7BJ0X0ng9m/tr664NSkQks5c3GWIbo+L8EHO1wUmypkhnxsnFb3JD3loYqCECCgw7hSPYxzlXjrHmwY4iVVlkwV4ygLLw//F67OIzqyGW9JNhl4W2Bb8NXCGctT5cxkibOT8B1sE6CO4UwuBCzcRvkwABON+8GrMYT+Za2SxDqvjh74njaF1ECXeYe/2sEMTW8P/53bwIy5XyRrB4DaNYuPPY65pIusEIw42rmcscDyB8rDg6SzV2fYk1xyAgeenEuBG5mIsOgfTqP07lj7G+G0VMSL084cNtkj5D2sEVPSWqEMSbET5+MSl5R/xiW5i15N2eZJWK8aZSgmyNGkmi6Ua6qgWIlpcvku1XXG8KRp4FPBtTvNfyvvWFBbwfxu/BDIuTaqAuFvyLUl4EumJdFRFOKwNBD2d5DAzbFFQw+4B1IQ+/LmZQC31rrDXUpZKPxQQE6QfMQ5W1wQqipHPG3w1I2KEZLx2VwiQd1K9lMZn02wwDf7/4KyX023w6P4daIcOynqDOsbOJZ8M4EcpsKH9G6ZPSIGQJ6T1wRr+NfC/YsAJivDSvJ87PAMDPQvwtevMu0UtWI5DBcfWLC2Qg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR04MB6575.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(86362001)(33656002)(8676002)(6506007)(2906002)(66446008)(5660300002)(38070700005)(54906003)(8936002)(52536014)(55016003)(82960400001)(122000001)(110136005)(508600001)(71200400001)(316002)(26005)(186003)(9686003)(7696005)(38100700002)(66476007)(66946007)(76116006)(64756008)(83380400001)(4326008)(66556008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?YXEwVDZxTzdNK2plZTk0aVpqUENTT2tnRW4zMVdxK1VHN2J4TUhpNmlhWUdi?=
 =?utf-8?B?enNTTWs2UHVqNUYrSTRHQW9IRmQ2US9zYi8rbnZyOXJ3c0xmbXpRS0ZnNi9n?=
 =?utf-8?B?bm5PVTlHN2dqaStrcHdJMzBDWTFnVVVvZkJIR3R0d3Zwc093Q2l1M0FtNmFE?=
 =?utf-8?B?RFFHQ3dBUm15RW5BeEJFUjdBMWtoMFl2c0NpVjRhRTc3ZGQ3a2VvbDhTZkk1?=
 =?utf-8?B?S2FTbzBCcXpoMERTSDhzaEd5czlBWUlLMVI3em5OVGNGQ1pvR1RXNVRHZzFH?=
 =?utf-8?B?ZlJaTk8rVkNCTURyd1VlaEpZU3hTbFVWYjJObWJDN1l2eDFhTHNwN3N4WmdD?=
 =?utf-8?B?d05yQ08vZE84ODRkZW5vb0RlcmJpanphM1ZHNEFrOHd4NEZyUUJMaW9jV3Rp?=
 =?utf-8?B?emRzcDl5NWh3aERwMUw0Ry9SVXowejdQb1ppWjRPVGQzQTRjczk4V25UTi8r?=
 =?utf-8?B?VWVBcnlMTzZ0MDhhZElmUjlsalk3RDhROVpXM0s5NDlkSXhVcEZWMWJsamlY?=
 =?utf-8?B?ZjM0UVgrOEMrT2NId0piMTBLSEQ3Z1I3WUNFVDJDa3JYelVUa2Y5TmpBZGpu?=
 =?utf-8?B?VGdNS2lGN0hscUJPMDRMeDRPY3poMlBIbTFCR3owREduMTh4Mmc2WEx4cy9m?=
 =?utf-8?B?SG4vYWY1d3p0SUJ3SkUxSmlwdXpkaGVxSzVpRDBKb0NkY0lyajJIbWpVMnZz?=
 =?utf-8?B?WGtMRUlRcnVZTzRaUEs0Yy8xNzJ3Zyt4anB2Vk5OcWRYbHVjWGZ4YmRYMDV6?=
 =?utf-8?B?MnUyM0Nud3BLeGxqL0x3dXA5cjRVL2xHRjJUQVVuL2Z6Ym1jYWxuelpuUG9k?=
 =?utf-8?B?MnJjUVdPWUVSdmtFREZjNVQ5MHN4KytJOUg3OXhwZm1yRFpqV2V4TVp4b3ps?=
 =?utf-8?B?aWFaK0ZRMW80Nmw0dVQ2MWd6TTRxMWxpOHlzUFhBQ3F4STlQMHFpVm1IM3dh?=
 =?utf-8?B?MU1UQUdzdTFKYTNhUjJlWnJqMkV5RDc4TElXcG45OEd3TG1Qa21VZ3E0V3Vs?=
 =?utf-8?B?TnFTNXhHRnN2V0dQbjljaGNYdGtrWEdZN1ptNi9SZHBpc3IvZHFjSFlJOUhT?=
 =?utf-8?B?N0tQN0RjZGlUTE1LK1RiZnNXb0hWY1RINUl5UnRBSy9ib2gyczRPZVFOSXhV?=
 =?utf-8?B?alBCUytBeWI1dzhhNDhCbHpDTndUQTN2K0FVVkluNDJVd1N0S2s1eS84YWI1?=
 =?utf-8?B?Vzh1eERuUm5yZnp3RG95V2FYN1VaOFpzbDNLekwzajFpNmJpYWU0d0NzNWRn?=
 =?utf-8?B?M2pvRk5EVVVlczZSblFRUVQ4VlpiT25iY1dHa1VTeWZjZjVkSHVPeFNRRlZ1?=
 =?utf-8?B?WFdjTUVsckJnWXNtTlAyd1VoR2cvd1dhUDZteitVK2dEZVNyTnJZbGlpSVdw?=
 =?utf-8?B?aEV4RndzeTJkSmZ1R2gvNmFibmhWNWJ5N21nWjM1MHgxSThvN0NkNWlFTDRO?=
 =?utf-8?B?RzJTZmRnUmVJazI4NGxQS1FUTVcxdnc0NFo5QjNrVW5lZ3pIU3pZY3M0ZHVY?=
 =?utf-8?B?bWpsZHN6M3hqbGlxcmw3WWtKalFkelNJMzJZeU13U0FUT0Q0MjRDYk9NMUpS?=
 =?utf-8?B?WituTitNMjcxaCs2Tmo3ODU3Y1JmOEpuc0NiZ2czR05YWEFLakRCbEpjTDBz?=
 =?utf-8?B?TzFCby9vYkE0S3luWWFuRXI4YTJqYVdsVlBiTFZabGtYallwVy9QV2oyNGNw?=
 =?utf-8?B?eDVDOHdSUVJqNmY0aTB4Z0grUHFObUxQY1NNVUJuYUVWZHczRVBiNFZ2MHVD?=
 =?utf-8?B?K0N6cGZEeXlZUEJiU1JGL0ErMFpLUjV5aXl3akJXVzFTYVpuVEZzbHVZTHY0?=
 =?utf-8?B?NncrUEdxY2hXRUJKaTFNOFRORUZjQlRRNnZ5aFQyVmpBV2dIdVcwSzRwVEtN?=
 =?utf-8?B?dDZFWHJKOG1ZbXZxcEowdG5FYkVPNkN1UG1QUk9LK01TZzVWVlhESHExMEcx?=
 =?utf-8?B?L2ZWSGJGUUZRWHQvNGpkbytvTUNCNWwwS2RnOFd1ZmxySko1QkRrR2M2aUIy?=
 =?utf-8?B?ZCt6MGpadVhRQ0lwMXN0cE0xQnBZeXU3T2R6dU5keXVrbm1mV21JUU9lcnhZ?=
 =?utf-8?B?Vy9FajRPUXVIclduSURXUFRubEVzZW5tRUNGWnc1b1dkbmhacVd0SDFXcktH?=
 =?utf-8?B?cEcvaXFEQkRWT3d3NytpcTlHL0djc0NIanVCb1JEYkhBUVAzZHAwQm5QcWQr?=
 =?utf-8?B?Yjl4V2F1U3paQlpmOTJWbURqU3ZscmVWSlNUc04zSXZvcXlXbmpVelpkdzNu?=
 =?utf-8?B?cUtZVjZGZlNnellmSG9Zc2pFYTU3eTltSGlIRWMwV1VNK1BCQ1pRZXo5L1o2?=
 =?utf-8?B?MFdZbGYwOG9ia1NiU3dnMStqbWpIbnh2QUV4REM0QjN5dWdBOXJsQT09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR04MB6575.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 149183f5-fad2-4a55-33d8-08da1a07cbff
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2022 09:03:21.4845
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2WAL0rcsDDLSrPt7QotpQNaxooj095BThcW2ILjDxIngLeOeKIYtEiGayaOCmuyS6HjVY68lQK7Lfp9dV8e0ew==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR04MB0575
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

IA0KPiBGcm9tOiBCZWFuIEh1byA8YmVhbmh1b0BtaWNyb24uY29tPg0KPiANCj4gTWljcm9uIGVN
TUMgb2ZmZXJzIGFuIGFkZGl0aW9uYWwgc2V0IG9mIGNvbW1hbmRzIHRoYXQgZ28gYmV5b25kIHRo
ZSBKRURFQw0KPiBEZXZpY2UgSGVhbHRoIFJlcG9ydC4gVGhlc2UgYWRkaXRpb25hbCBERVZJQ0Ug
SEVBTFRIIGNvbW1hbmRzIGFyZQ0KPiBpbXBsZW1lbnRlZCB1c2luZyB0aGUgZ2VuZXJpYyBDTUQ1
NiBjb21tYW5kIGFuZCB0aGV5IHJldHVybiBhIHNpZ25pZmljYW50DQo+IGFtb3VudCBvZiB1c2Vm
dWwgaW5mb3JtYXRpb24gYWJvdXQgdGhlIHN0YXR1cyBvZiB0aGUgTkFORCBkZXZpY2UuIFN1Y2gg
YXMgYmFkDQo+IGJsb2NrIGNvdW50ZXJzLCBibG9jayBlcmFzZSBjb3VudGVycyAsZXRjLiBGb3Ig
bW9yZSBpbmZvcm1hdGlvbiwgcmVmZXIgdG8gVE4tRkMtDQo+IDMyOiBlwrdNTUMgRGV2aWNlIEhl
YWx0aCBSZXBvcnQuDQo+IA0KPiBTaW5jZSB0aGUgQ01ENTYgaXMgc3BlY2lmaWVkIGluIEpFREVD
LCB0byBtYWtlIENNRDU2IHVuaXZlcnNhbCB1c2VkIGFuZCBsZXQNCj4gbW9yZSB1c2VycyBvZiBt
bWMtdXRpbHMgZ2V0IHRoZSBiZW5lZml0IGZvciB0aGlzLiBJIGFkZCBDTUQ1NiByZWFkLCBhbmQg
bGV0IHRoZQ0KPiB1c2VyIHRvIGlucHV0IHRoZSBDTUQ1NiBhcmd1bWVudCwgYWxzbywgaGVyZSBJ
IGRpZG4ndCBhZGQgZGF0YSBwYXJzaW5nLCBqdXN0IHByaW50DQo+IHJhdyBkYXRhLCBzaW5jZSBp
dCBpcyB2ZW5kb3Itc3BlY2lmaWMuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBCZWFuIEh1byA8YmVh
bmh1b0BtaWNyb24uY29tPg0KPiAtLS0NCj4gIG1tYy5jICAgICAgfCAgNyArKysrKysrDQo+ICBt
bWMuaCAgICAgIHwgIDIgKysNCj4gIG1tY19jbWRzLmMgfCA1Mg0KPiArKysrKysrKysrKysrKysr
KysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrDQo+ICBtbWNfY21kcy5oIHwgIDEg
Kw0KPiAgNCBmaWxlcyBjaGFuZ2VkLCA2MiBpbnNlcnRpb25zKCspDQo+IA0KPiBkaWZmIC0tZ2l0
IGEvbW1jLmMgYi9tbWMuYw0KPiBpbmRleCBlYjI2MzhiMTIyNzEuLmVhNDY1ZTU5ZmRmMyAxMDA2
NDQNCj4gLS0tIGEvbW1jLmMNCj4gKysrIGIvbW1jLmMNCj4gQEAgLTIzNyw2ICsyMzcsMTMgQEAg
c3RhdGljIHN0cnVjdCBDb21tYW5kIGNvbW1hbmRzW10gPSB7DQo+ICAgICAgICAgICAgICAgICAi
c2VjdXJlLXRyaW0xIHwgc2VjdXJlLXRyaW0yIHwgdHJpbSBcbiIsDQo+ICAgICAgICAgTlVMTA0K
PiAgICAgICAgIH0sDQo+ICsgICAgICAgeyBkb19nZW5lcmFsX2NtZF9yZWFkLCAtMiwNCj4gKyAg
ICAgICAiZ2VuX2NtZCByZWFkIiwgIjxhcmc+IDxkZXZpY2U+XG4iDQo+ICsgICAgICAgICAgICAg
ICAiU2VuZCBHRU5fQ01EIChDTUQ1Nikgd2l0aCBzcGVjaWZpYyA8YXJnPiB0byAgPGRldmljZT4g
dG8gcmVhZA0KPiB2ZW5kb3JcbiINCj4gKyAgICAgICAgICAgICAgICJzcGVjaWZpYyBkYXRhLiA8
YXJnPiBtdXN0IGJlIDMyIGJpdHMgbGVuZ3RoIGhleCBudW1iZXIgcHJlZml4ZWQgd2l0aA0KPiAw
eC8wWC5cblxuIg0KPiArICAgICAgICAgICAgICAgIk5PVEUhOiBCZWNhdXNlIHRoaXMgb3B0aW9u
IGlzIG9ubHkgdXNlZCB0byByZWFkLCB0aGUgYml0MCBpbiA8YXJnPg0KPiBtdXN0IGJlIDEiLA0K
PiArICAgICAgIE5VTEwNCj4gKyAgICAgICB9LA0KPiAgICAgICAgIHsgMCwgMCwgMCwgMCB9DQo+
ICB9Ow0KPiANCj4gZGlmZiAtLWdpdCBhL21tYy5oIGIvbW1jLmgNCj4gaW5kZXggMjVkNjg2NGFj
NzZmLi5iNjIxMzc0YTFlZDEgMTAwNjQ0DQo+IC0tLSBhL21tYy5oDQo+ICsrKyBiL21tYy5oDQo+
IEBAIC00MSw2ICs0MSw4IEBADQo+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICBbMV0gRGlzY2FyZCBFbmFibGUNCj4gICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgIFswXSBJZGVudGlmeSBXcml0ZSBCbG9ja3MgZm9yDQo+ICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBFcmFzZSAob3IgVFJJ
TSBFbmFibGUpICBSMWIgKi8NCj4gKyNkZWZpbmUgTU1DX0dFTl9DTUQgICAgICAgICAgICA1NiAg
IC8qIGFkdGMgIFszMToxXSBzdHVmZiBiaXRzLg0KPiArICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgWzBdOiBSRC9XUjEgUjEgKi8NCj4gDQo+ICAjZGVmaW5lIFIx
X09VVF9PRl9SQU5HRSAgICAgICAgICgxIDw8IDMxKSAgICAgICAvKiBlciwgYyAqLw0KPiAgI2Rl
ZmluZSBSMV9BRERSRVNTX0VSUk9SICAgICAgICAoMSA8PCAzMCkgICAgICAgLyogZXJ4LCBjICov
DQo+IGRpZmYgLS1naXQgYS9tbWNfY21kcy5jIGIvbW1jX2NtZHMuYw0KPiBpbmRleCA0OWQzZTMy
NGQyNjYuLjZlMDA2YjEwZDRmZCAxMDA2NDQNCj4gLS0tIGEvbW1jX2NtZHMuYw0KPiArKysgYi9t
bWNfY21kcy5jDQo+IEBAIC0yOTgxLDMgKzI5ODEsNTUgQEAgb3V0Og0KPiAgICAgICAgIHJldHVy
biByZXQ7DQo+ICAjZW5kaWYNCj4gIH0NCj4gKw0KPiAraW50IGRvX2dlbmVyYWxfY21kX3JlYWQo
aW50IG5hcmdzLCBjaGFyICoqYXJndikgew0KPiArICAgICAgIGludCBkZXZfZmQ7DQo+ICsgICAg
ICAgX191OCBidWZbNTEyXTsNCj4gKyAgICAgICBfX3UzMiBhcmc7DQo+ICsgICAgICAgY2hhciAq
ZGV2aWNlOw0KPiArICAgICAgIGNoYXIgKmVuZHB0cjsNCj4gKyAgICAgICBpbnQgcmV0ID0gLUVJ
TlZBTCwgaTsNCj4gKyAgICAgICBzdHJ1Y3QgbW1jX2lvY19jbWQgaWRhdGE7DQo+ICsNCj4gKyAg
ICAgICBpZiAobmFyZ3MgIT0gMykgew0KPiArICAgICAgICAgICAgICAgZnByaW50ZihzdGRlcnIs
ICJVc2FnZTogZ2VuX2NtZCByZWFkIDxhcmc+IDwvcGF0aC90by9tbWNibGtYPlxuIik7DQo+ICsg
ICAgICAgICAgICAgICBleGl0KDEpOw0KPiArICAgICAgIH0NCj4gKw0KPiArICAgICAgIGRldmlj
ZSA9IGFyZ3ZbMl07DQo+ICsgICAgICAgZGV2X2ZkID0gb3BlbihkZXZpY2UsIE9fUkRXUik7DQo+
ICsgICAgICAgaWYgKGRldl9mZCA8IDApIHsNCj4gKyAgICAgICAgICAgICAgIHBlcnJvcigiZGV2
aWNlIG9wZW4gZmFpbGVkIik7DQo+ICsgICAgICAgICAgICAgICBleGl0KDEpOw0KPiArICAgICAg
IH0NCj4gKyAgICAgICBhcmcgPSBzdHJ0b2woYXJndlsxXSwgJmVuZHB0ciwgMTYpOw0KPiArICAg
ICAgIGlmIChlcnJubyAhPSAwIHx8ICplbmRwdHIgIT0gJ1wwJyB8fCAhYXJnJjB4MSkgew0KPiAr
ICAgICAgICAgICAgICAgZnByaW50ZihzdGRlcnIsICJXcm9uZyBBUkcsIGl0IHNob3VsZCBiZSBI
ZXggbnVtYmVyIGFuZCBiaXQwIG11c3QgYmUNCj4gMVxuIik7DQo+ICsgICAgICAgICAgICAgICBn
b3RvIG91dDsNCj4gKyAgICAgICB9DQpPbmUgbGluZSBzcGFjZQ0KPiArICAgICAgIG1lbXNldCgm
aWRhdGEsIDAsIHNpemVvZihpZGF0YSkpOw0KPiArICAgICAgIGlkYXRhLndyaXRlX2ZsYWcgPSAw
Ow0KPiArICAgICAgIGlkYXRhLm9wY29kZSA9IE1NQ19HRU5fQ01EOw0KPiArICAgICAgIGlkYXRh
LmFyZyA9IGFyZzsNClByYWN0aWNhbGx5IGFyZyBpcyBub3QgbmVlZGVkLCBiZWNhdXNlIGJpdHNb
MS4uMzFdIGFyZSBtZWFuaW5nbGVzcy4NCk1heWJlIGp1c3Qgc2V0OiBpZGF0YS5hcmcgPSAxOw0K
DQpUaGFua3MsDQpBdnJpDQo=
