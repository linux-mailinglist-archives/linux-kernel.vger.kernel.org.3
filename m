Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0232955A069
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Jun 2022 20:08:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231526AbiFXR4i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Jun 2022 13:56:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229784AbiFXR4g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jun 2022 13:56:36 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2055.outbound.protection.outlook.com [40.107.220.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D2D69585;
        Fri, 24 Jun 2022 10:56:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XVxbTGAHeIwh8E6BEFg+xbASM8HQtn3jl/lcGOBylmC/VoXQBwi801pRQdWkwkz3MZ6A4nLXkZI2176I7fotCopTiVpk0Nm77ccOgNjVX41vqw4qNDOe3YVfC2Tap2xwfzLylx5KSFyKeNrDt++uP4rTNnJgVVzRmBolYfw/Qqs5/I2I198bGNENVzuITHFSTMHRWkU72KSH2V9PwNcaoQknLAJnqZFDsV+WeNeDco3wU0mO/Hmqm4WyOe0H+fqmLor5A1IFeaFx9gqRS3uN2Mx4G9bebzJ3pRZDm6o/v2hIpbE5cfK/VL8ptoXJZBdxYCqCEAs+1YHWalnwXVWaKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0LEZFZsXpmMyZ9IpMunZUUKdxWwfktVzht3jtHjCt7g=;
 b=GM3D0EgjxVTxBm8dEMFGPy0E+ZWvEwjDkMTM5qNEBCg3p8B9whf+urz3MglCDV6v75JTjlxLBS3rtEr7EPmpGdAcvhuORCgPxXvDhKKQsR4mv4upp/dTQnzFaPyZHDC47hPi2I3fdv6ZMVhoOwnwdfd7NYmz33gV20uvzthJcBYxb8WLnZLJAFGGWad6m9yMtWePShKJg8Bz90dPJF0wXkvWqS8yhbUfpnzAKOZIZRu9Z7ejeUxnsa92rpyfVfemi37h6PtIU1/cLfH1nxu3f4LgtEtS1KEVsdB0O2O/HABlLDJ+oSTsAJVDAKYwGHqFNXrTVv77wf10nEgkVq8U7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0LEZFZsXpmMyZ9IpMunZUUKdxWwfktVzht3jtHjCt7g=;
 b=rZvmBbXwTyJVBDwLKlW2oa03kcZgTbsUO9ZinAat08FJmHCbg6QcaeEbCLcA8cTybt557w+SC4/jdR+ePgLuIU5qVj8TIK86n/8/BOAI/of87i93N/QGl+akbFH8HmDNpCWQtgANNahTtSS9DLkw0Gyx3wDeP3kWZNMCllXMl6M=
Received: from DM4PR12MB5278.namprd12.prod.outlook.com (2603:10b6:5:39e::17)
 by MWHPR1201MB0032.namprd12.prod.outlook.com (2603:10b6:301:4f::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.18; Fri, 24 Jun
 2022 17:56:33 +0000
Received: from DM4PR12MB5278.namprd12.prod.outlook.com
 ([fe80::bd3b:532c:bc96:c60a]) by DM4PR12MB5278.namprd12.prod.outlook.com
 ([fe80::bd3b:532c:bc96:c60a%9]) with mapi id 15.20.5373.017; Fri, 24 Jun 2022
 17:56:33 +0000
From:   "Yuan, Perry" <Perry.Yuan@amd.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
CC:     "Huang, Ray" <Ray.Huang@amd.com>,
        "Limonciello, Mario" <Mario.Limonciello@amd.com>,
        Len Brown <lenb@kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Fontenot, Nathan" <Nathan.Fontenot@amd.com>,
        "Su, Jinzhou (Joe)" <Jinzhou.Su@amd.com>,
        "Huang, Shimmer" <Xinmei.Huang@amd.com>,
        "Du, Xiaojian" <Xiaojian.Du@amd.com>,
        "Meng, Li (Jassmine)" <Li.Meng@amd.com>,
        Linux PM <linux-pm@vger.kernel.org>
Subject: RE: [PATCH] ACPI: bus: Fix osc_sb_cppc_not_supported check
Thread-Topic: [PATCH] ACPI: bus: Fix osc_sb_cppc_not_supported check
Thread-Index: AQHYh8H418IBBTS8p0Wqf3y4PWnIga1euqKAgAAc91A=
Date:   Fri, 24 Jun 2022 17:56:33 +0000
Message-ID: <DM4PR12MB527818C9841B5E7F7CA45F929CB49@DM4PR12MB5278.namprd12.prod.outlook.com>
References: <20220624115940.272422-1-Perry.Yuan@amd.com>
 <CAJZ5v0igFJgTH9yVCVyuGHmkbonBYh18KKi4X+TYDVaZRwNzxg@mail.gmail.com>
In-Reply-To: <CAJZ5v0igFJgTH9yVCVyuGHmkbonBYh18KKi4X+TYDVaZRwNzxg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2022-06-24T17:55:15Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=2c004e57-456a-4fa6-a558-2d81acbba13f;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=1
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_enabled: true
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_setdate: 2022-06-24T17:56:30Z
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_method: Standard
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_name: General
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_actionid: 3c15ea1a-1ed5-401a-99a5-427987f55d7b
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 09d9fe28-3e6b-4cea-596f-08da560ae027
x-ms-traffictypediagnostic: MWHPR1201MB0032:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: eDbQaAAduCzbZ38/Ht7dWFQS7Avem35riN8en29RTFENU3EwOseo+fq8cjL+MEvi9gAIBN/huhdnYSFo1Q5UkpIEMXkioJrg/NwC5VAJKwO2k5f/uNB6wJcL5X6PSPE8gCsiW6pwGimjH43xV+SyTD/2PWlYviZovr0wswGpCAKOXqYYx92PARa1DWR6e5nZinxqCsVb+I2TO88bZltgORmUYhGJlD4U7lyp9juVX1MruGC/HC3i8Jq97aTaNyjOl48sqYdkCP4RfFvJ2jHUBLp5+VWgf+ZnF4eI4t1kqyZ/3rYm8ufXYwMSBYNBTWXeLYLE2QqZu+huLarq7I5GhnvZVboPyyVwjDh8BTEc22wPlUKdvsujrPDQoJZVb5Ip6mzK2husaRMif+C8cWbbDJ9O15zGhKjd1tmCXcYDlay2XNIy8CrxElqiUm5vYKfHEL9Xrjz1m3w3gw0xeyi0Ah+1RudYy8imNrIBz+kTUrM6ca20WfZRQvMV/QZsBl0UDxCy/om6H3vQ9G6xUEG4A2Fca3xRpaY1woq4KZoJEM33vEQx1dDdmDbSf9HPZdi+DXP83BviiC45kwsWsPaogAU5TsVOarn3jVMYvPfORoNRMwNyK7QRIooGaVsJgU7a5DIOKPZPVyiJgkhABimEhfOc2cnGtgD7SbWD8fFPC82jKx0bbIARc0J1KoVBMu+ZYwKP3RaDFu5y57f/ApuJEaAQfk7Lu7qZMLXWNi5zRuD27yuzqvg3L3J6mByuP2Fs0k5IJI3xEownH35cNavUc2sMYbmyaQeKmkwu1uNCqzM=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5278.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(39860400002)(136003)(376002)(366004)(396003)(346002)(8676002)(66446008)(41300700001)(66556008)(55016003)(64756008)(33656002)(83380400001)(66946007)(66476007)(122000001)(4326008)(186003)(38070700005)(6916009)(5660300002)(76116006)(38100700002)(8936002)(86362001)(26005)(71200400001)(7696005)(52536014)(316002)(478600001)(2906002)(6506007)(9686003)(53546011)(54906003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?M0JDemVrMHFwNVZoZHpDUGlzRzM1S0Z2aHNWc2g0V1haWjk0OTltQ3hOMkN2?=
 =?utf-8?B?WjZtUlNmTWhHclg0QUxvNGo5b2I2WVFjN0xZN0tXT3NhS21CNTZyYTRSeG9S?=
 =?utf-8?B?SnJORGhxamx6YTc2TnNldWJ6M1ZUV0hxcEJCMTBvR1AyTElwR1F2K000b1ow?=
 =?utf-8?B?Z2YzM053Y294RGZINlJBaDRqc1FSMGZ3WjJ4UU9SMk4zVHQ5ejBvclNRTFF5?=
 =?utf-8?B?Ykx1Rk9veFNxdDNEL2RPQnFlVnNnZjFEMmY4NWtCK2xIMFVUSzZBZWFxTHlM?=
 =?utf-8?B?dnBZdTgxR2dHVDdFWTduU1U4N1ZmSU16Q0tNd2xLQVRhWkpSVThqTkZxQ2NZ?=
 =?utf-8?B?WUN4Zm9aTlZOeHowM00zV1RuU1l5cFcwSFdWSzEvZVZNdzlOd0QzWGt0dDAz?=
 =?utf-8?B?TG9vblZiNkRweGZEd0F3R1c5aFhva1krcUNvcFU4OFh5eGR3YlVRd3ZqSUdj?=
 =?utf-8?B?RTRBVTc0eXpzWkJnaFM1OFdiV0FiRG5qL0d1bkd1SE5mblN4bW5uRERtTHBa?=
 =?utf-8?B?YUc1alpOd0hFS2JBVU5uM3c2TmJ5OXBtTGM1dlFuZHhZVGhFdHR5dytIcG42?=
 =?utf-8?B?Sys1YndyMFV0SFNyMWxUa1lOZm1FQjRWOHpSYmREalY3bXhWUzUrMWpMQ1pu?=
 =?utf-8?B?Yk50c3pxdjNBSmF0cnpEOUd0M2VxV0Uvd1QrejU1djVZbUVQOFlGVWFEaWF0?=
 =?utf-8?B?R3huRzRaRVhLT0lReC9BTUdSZENIT0docWxDeFJ5U3hrWlVwY0xCSThWKzV3?=
 =?utf-8?B?SW1qSmZEWmJwNTNXK1MwemtyWFhhSHB4Y2E2WVAyU3VIR1U2YVplWDQvRW5q?=
 =?utf-8?B?bTJ0Ti9GYzZLS0ZqSkFWTk1heVE3OHRUaEpLL0J3TGF1d29yMGVTa0ZXYVE2?=
 =?utf-8?B?Q0c2RFV5b2kvWVlLcnFRR09mSWRoeWdUZGQ2ekh5REZpbUhOdWExVTk3MWht?=
 =?utf-8?B?TXQ0VTk5NXIvZjE4aHB1ck13aE1JU042MGhGeDV1Y0o0eTVabDVNTTFEVEp6?=
 =?utf-8?B?OHVuYi9MZkR3RjRVeXh6Q2x4UFUvaWh5V2pjN2tGaTkvS1pOY3JnVWt1bE1U?=
 =?utf-8?B?Rm03N1hGVUkwc05YUFNXckoyWVVMYkNHeVdkeUs2a2N2aWJUTjN5RXJaYzh0?=
 =?utf-8?B?TVRnUmRFYUpCbWtHeU1WZkkyaHZ2aHc2MEQ3MXhOMG51cWZjMDgvZnB6bEdR?=
 =?utf-8?B?eERQVFBVd2tCSzNMNFFhVmxYZzNKb2w2blRPUmZIUVhQSkZRUW9KTlMyWngx?=
 =?utf-8?B?UFZqTUd4eWpXTjZYOTNIUlBsRzd3SnQ2bjc5NnZVaFVoa0d4NVRYSUtrOUV1?=
 =?utf-8?B?QlE2dDdSbSs3dE8veDBSMjQ5OTIrUmdYRE1GZGlhUnpheGo4UjJwbUF1SEVm?=
 =?utf-8?B?L2JZMHg1a3d1OFZoQmNmN2FRQjBzbzF2SmFwOFdnVm1PKzRLaFdaYzF6U3NC?=
 =?utf-8?B?SnNNa1o3QlJBNEpxd1hjSWx3OGZNV2NHZEZZQ2ZyU2JOWFhhUUgrQTFGbjgv?=
 =?utf-8?B?ZUlQQVg1a2NxaXlRQURyaloyTFhLMlREQTVsdzByL2R6azY5dUdXL0ZkaVFB?=
 =?utf-8?B?MW9qSGc1NXY2ZTY1QmFlUk9RaUc2aEdBcGkxdFV3Y0hmcmljOUhzbTVUN2JG?=
 =?utf-8?B?TmxpYWRXa2U4SUtVSVJrT1F1SDg1Y2tvOUtBbFY2VnJKUnltcTIzWFdncHRr?=
 =?utf-8?B?NVRiM1FsVVNlUEZVVVpnZ2hDTzNkNnpQWWd4WCtwalhYeURhQklYZGZhRHFD?=
 =?utf-8?B?VXBDelVTWnlHanhaRFhOTmpzSmRzd2lta25xZkh5dTUvNGhDKzZzTXpoQmxl?=
 =?utf-8?B?OXIyZ3puY0dsUXlSUVNJRTdpL1N3SThQaGFXWFlVanF3LzM0UnVDVXdIZGdF?=
 =?utf-8?B?aVMwd2ZNUGdtMnhVbi9EOWVtMThJWFdUNlpSc3hFcUtRQU93dlhqbjZFbjRR?=
 =?utf-8?B?cnJxaG9NK241RlpKR3lGbzloekIzYzhzZkpCNFlmdWVDUlRvTURZWTBqY0d6?=
 =?utf-8?B?ZVNvdzV6Uld0ZWY2dWdqWGg0SkprZmxLUHlKRlVyTTAyaVBZL0FOY09ETy9D?=
 =?utf-8?B?SXB2VWRTeU1ZWWtqZzZuUFBPdkt4Vi9ES2RGSFQ5N0JhUjJLSUgvUHF6ZGJD?=
 =?utf-8?Q?pzevLLr8LjSi4hvH218/WRmav?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5278.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 09d9fe28-3e6b-4cea-596f-08da560ae027
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jun 2022 17:56:33.6527
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8NRV4vRzOOzEOEbZvjkf9YFRl+nsrNBi3FN8VbiL7IZQqNMSTcPib7r9F4LE4V5Rp3Mf65U4hIs5FJPrYqqFww==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1201MB0032
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

W0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEdlbmVyYWxdDQoNCkhpIFJhZmFlbDoNCg0KPiAtLS0t
LU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBSYWZhZWwgSi4gV3lzb2NraSA8cmFmYWVs
QGtlcm5lbC5vcmc+DQo+IFNlbnQ6IFNhdHVyZGF5LCBKdW5lIDI1LCAyMDIyIDEyOjEyIEFNDQo+
IFRvOiBZdWFuLCBQZXJyeSA8UGVycnkuWXVhbkBhbWQuY29tPg0KPiBDYzogSHVhbmcsIFJheSA8
UmF5Lkh1YW5nQGFtZC5jb20+OyBMaW1vbmNpZWxsbywgTWFyaW8NCj4gPE1hcmlvLkxpbW9uY2ll
bGxvQGFtZC5jb20+OyBSYWZhZWwgSi4gV3lzb2NraSA8cmFmYWVsQGtlcm5lbC5vcmc+OyBMZW4N
Cj4gQnJvd24gPGxlbmJAa2VybmVsLm9yZz47IE1pa2EgV2VzdGVyYmVyZw0KPiA8bWlrYS53ZXN0
ZXJiZXJnQGxpbnV4LmludGVsLmNvbT47IEFDUEkgRGV2ZWwgTWFsaW5nIExpc3QgPGxpbnV4LQ0K
PiBhY3BpQHZnZXIua2VybmVsLm9yZz47IExpbnV4IEtlcm5lbCBNYWlsaW5nIExpc3QgPGxpbnV4
LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc+Ow0KPiBGb250ZW5vdCwgTmF0aGFuIDxOYXRoYW4uRm9u
dGVub3RAYW1kLmNvbT47IFN1LCBKaW56aG91IChKb2UpDQo+IDxKaW56aG91LlN1QGFtZC5jb20+
OyBIdWFuZywgU2hpbW1lciA8WGlubWVpLkh1YW5nQGFtZC5jb20+OyBEdSwNCj4gWGlhb2ppYW4g
PFhpYW9qaWFuLkR1QGFtZC5jb20+OyBNZW5nLCBMaSAoSmFzc21pbmUpIDxMaS5NZW5nQGFtZC5j
b20+Ow0KPiBMaW51eCBQTSA8bGludXgtcG1Admdlci5rZXJuZWwub3JnPg0KPiBTdWJqZWN0OiBS
ZTogW1BBVENIXSBBQ1BJOiBidXM6IEZpeCBvc2Nfc2JfY3BwY19ub3Rfc3VwcG9ydGVkIGNoZWNr
DQo+IA0KPiBbQ0FVVElPTjogRXh0ZXJuYWwgRW1haWxdDQo+IA0KPiBPbiBGcmksIEp1biAyNCwg
MjAyMiBhdCAyOjAwIFBNIFBlcnJ5IFl1YW4gPFBlcnJ5Lll1YW5AYW1kLmNvbT4gd3JvdGU6DQo+
ID4NCj4gPiBUaGUgcGF0Y2ggZml4cyB0aGUgb3NjX3NiX2NwcGNfbm90X3N1cHBvcnRlZCB2YXJp
YWJsZSBjaGVja2luZw0KPiA+IE90aGVyd2lzZSB0aGUgY3BwYyBhY3BpIGRyaXZlciB3aWxsIGJl
IGZhaWxlZCB0byByZWdpc3RlciBjYXVzaW5nIEFNRA0KPiA+IHBzdGF0ZSBkcml2ZXIgZmFpbGVk
IHRvIGxvYWQgd2hlbiBjYWxsaW5nIGFjcGlfY3BjX3ZhbGlkKCkNCj4gPg0KPiA+IEZpeGVzOiBj
NDJmYTI0YjQ0NygiQUNQSTogYnVzOiBBdm9pZCB1c2luZyBDUFBDIGlmIG5vdCBzdXBwb3J0ZWQg
YnkNCj4gPiBmaXJtd2FyZSIpDQo+ID4gU2lnbmVkLW9mZi1ieTogUGVycnkgWXVhbiA8UGVycnku
WXVhbkBhbWQuY29tPg0KPiA+IC0tLQ0KPiA+ICBkcml2ZXJzL2FjcGkvYnVzLmMgfCAyICstDQo+
ID4gIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMSBkZWxldGlvbigtKQ0KPiA+DQo+
ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvYWNwaS9idXMuYyBiL2RyaXZlcnMvYWNwaS9idXMuYyBp
bmRleA0KPiA+IDRkN2M1MWEzM2IwMS4uOTczMWU0YTFlMzM4IDEwMDY0NA0KPiA+IC0tLSBhL2Ry
aXZlcnMvYWNwaS9idXMuYw0KPiA+ICsrKyBiL2RyaXZlcnMvYWNwaS9idXMuYw0KPiA+IEBAIC0z
NTksNyArMzU5LDcgQEAgc3RhdGljIHZvaWQNCj4gYWNwaV9idXNfb3NjX25lZ290aWF0ZV9wbGF0
Zm9ybV9jb250cm9sKHZvaWQpDQo+ID4gICAgICAgICB9DQo+ID4NCj4gPiAgI2lmZGVmIENPTkZJ
R19BQ1BJX0NQUENfTElCDQo+ID4gLSAgICAgICBvc2Nfc2JfY3BwY19ub3Rfc3VwcG9ydGVkID0g
IShjYXBidWZfcmV0W09TQ19TVVBQT1JUX0RXT1JEXSAmDQo+ID4gKyAgICAgICBvc2Nfc2JfY3Bw
Y19ub3Rfc3VwcG9ydGVkID0gIShjYXBidWZfcmV0W09TQ19TVVBQT1JUX0RXT1JEXSAmJg0KPiA+
ICAgICAgICAgICAgICAgICAgICAgICAgIChPU0NfU0JfQ1BDX1NVUFBPUlQgfCBPU0NfU0JfQ1BD
VjJfU1VQUE9SVCkpOw0KPiANCj4gVGhpcyBjZXJ0YWlubHkgaXMgbm90IGEgY29ycmVjdCBmaXgs
IGJlY2F1c2UgaXQgY2F1c2VzIG9zY19zYl9jcHBjX25vdF9zdXBwb3J0ZWQNCj4gdG8gYWx3YXlz
IGJlIHRydWUgaWYgY2FwYnVmX3JldFtPU0NfU1VQUE9SVF9EV09SRF0gaXMgbm90IHplcm8uDQo+
IA0KPiA+ICAjZW5kaWYNCg0KVGhhdCBpcyB0cnVlLCBJIHdpbGwgc2VuZCBhbm90aGVyIGZpeCBz
b2x1dGlvbiBzb29uLg0KDQpQZXJyeSAgDQoNCj4gPg0KPiA+IC0tDQo+ID4gMi4yNS4xDQo+ID4N
Cg==
