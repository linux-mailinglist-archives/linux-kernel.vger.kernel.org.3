Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBBD857E05D
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jul 2022 12:57:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235104AbiGVK5g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jul 2022 06:57:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235061AbiGVK5e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jul 2022 06:57:34 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2063.outbound.protection.outlook.com [40.107.94.63])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 410CBBB8D7
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jul 2022 03:57:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h0WfX3e9FCX1TM4Vx0tR3Dqf93Ddclx93ZbtsAUQINLKUeItDZCLBH47pUq8wxhxWGtCktXUlbBXIE4gy6TloXR53ubG55mPHZ7FBfoEIvf6iiSS1tYVZ5AxeL3dfc+bpGM/2YFhqDTbkA1B5owjwaYq/Yi/orXYCkHeKUl96JjuTXw2QHosQ9pmTcLjtQMUryXJmLQloUFLhLo1+FZVcFYDbG8JZkksmH9ktqr7GH6kULSEr8OIlyfvLWoNhLwxiJV5AGM6AoKTJb1WEDYwCVUvROCLkJqTUTBMjU0zFchMvbtJeaF+RI34MNtVXtrwukeJsH8sgRqEEJGWekT8tA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pRX9tV8X0fP/W+yWZgoYhNhuYUrGRwqUyIvTwRSK6Bg=;
 b=l+8qtDdCXXGPGrk46zFnnT3aCuwvC9Knlc6t/KcnPsgQvkYA3upgI3wstFgFXr3b9j6ZY9nywb98EOp7FnoF49zN/saHWe06v/z+LEsgpoiq18qlcuJ1Puu61GBTH06NWo20LzSo3nUyZMug1w3cY74VeoWS0A2Uv1B8jaT0UTsd2W3xGg3Bjic0IJ/SLtGQeQBmkUgunFCGJovClsxL1JeRlgTLUsJArdW25jVQ8oWSMt6rwbmgOuPY92vtcZzS799+8hA3y+a/JZUtvBa8MGnq/98IjCySfA5DUVyqMeYrD1EGXfC6MfFI7mSR1gI6pgRxnb+ZCNQQ5SQzRI2pPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pRX9tV8X0fP/W+yWZgoYhNhuYUrGRwqUyIvTwRSK6Bg=;
 b=C8zs1Z7T9D4yYydA5j1UoPXL7k1vSITyVeCp58qoJJhhqX1uXqCDy0mPyQ4iCBtPtz/ijCGwGUML/FOPIyrKAOoQx4zVadpdpya4/+W+3L49ZERoHL7XG/rl4LzIRKdbS58TrAuKfnOxOoI4rwbOb/gitMOrUHdp28vUcFS9A40=
Received: from MN2PR12MB3661.namprd12.prod.outlook.com (2603:10b6:208:169::31)
 by BN6PR1201MB2545.namprd12.prod.outlook.com (2603:10b6:404:b1::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5458.19; Fri, 22 Jul
 2022 10:57:28 +0000
Received: from MN2PR12MB3661.namprd12.prod.outlook.com
 ([fe80::1451:3811:47b6:23]) by MN2PR12MB3661.namprd12.prod.outlook.com
 ([fe80::1451:3811:47b6:23%5]) with mapi id 15.20.5458.019; Fri, 22 Jul 2022
 10:57:28 +0000
From:   "Saba Kareem, Syed" <Syed.SabaKareem@amd.com>
To:     Randy Dunlap <rdunlap@infradead.org>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
CC:     "Deucher, Alexander" <Alexander.Deucher@amd.com>,
        "Hiregoudar, Basavaraj" <Basavaraj.Hiregoudar@amd.com>,
        "Dommati, Sunil-kumar" <Sunil-kumar.Dommati@amd.com>,
        "Mukunda, Vijendar" <Vijendar.Mukunda@amd.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Ajit Kumar Pandey <AjitKumar.Pandey@amd.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        Lucas Tanure <tanureal@opensource.cirrus.com>,
        Julian Braha <julianbraha@gmail.com>,
        Bard Liao <bard.liao@intel.com>,
        open list <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 5/5] ASoC: amd: enable RPL Platform acp drivers build
Thread-Topic: [PATCH 5/5] ASoC: amd: enable RPL Platform acp drivers build
Thread-Index: AQHYnMj9sPxp+cb6ZE652tQl6C0d1a2I20eAgAFeAcA=
Date:   Fri, 22 Jul 2022 10:57:28 +0000
Message-ID: <MN2PR12MB36611F7FD471355CF40E2491FC909@MN2PR12MB3661.namprd12.prod.outlook.com>
References: <20220721061035.91139-1-Syed.SabaKareem@amd.com>
 <20220721061035.91139-5-Syed.SabaKareem@amd.com>
 <9d2da296-80a8-f632-27a4-42cd91cdff3e@infradead.org>
In-Reply-To: <9d2da296-80a8-f632-27a4-42cd91cdff3e@infradead.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2022-07-22T10:55:20Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=9bffecca-8d3e-464f-ae00-9cf4b3c539d3;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=1
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_enabled: true
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_setdate: 2022-07-22T10:57:25Z
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_method: Standard
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_name: General
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_actionid: 3c3698c5-a7b5-4ca2-85d4-2f283a6b472a
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 22751ec4-ba07-48c5-99e6-08da6bd0f7cb
x-ms-traffictypediagnostic: BN6PR1201MB2545:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: TwtkAzBvzIoeYJ/gdQKcntVNj2tsa88DGdIG2LhrAt2smTs6lH/QpDZrUJ6Tmb9ai3UAnwfJFbBahtWt3cJlolQqTuKs309G+iByzRexSyJu5ch65RgVfvzaln5SuKDaUE926pfs/0g8Jp5w5fMtxbJinwLwnU+5TkuTx4kZXrV1LhYmeHs5HJW+XITPkIsUCRDESkV4mhJ06HVjOjHmkKhGsO4UNJM5b3kNrPvkBDugNd8NzdBd99LUMBnC9+zyI/atzcO5pSEhEu9M/s9o7m5HvygYSsOP5b0yxo0u+TL8mYeTK1/h1GmxyoXoO+qNLyoYCGZGe8TA9m2p9mCSnzpbr4il5THyHoTYaucpgzQ4l14lZunxDSg/xU3xjPMKvH0t7Mwp+NffqeRw94lbFXvZDf+DR4OxoE+eAsaCAWYFkhfVoXEHRaSuQOdEKHhjHAz/ahMj0DtKacPvub5P378BrXUtr/01TECw/ss2EV+lNQtzpRip5I4KzePHlPV4pp+fthOerWoZ+lgvlAZCFjjYdmQK6yB0nKTYLgj41ktVvx3igDn9UE5N3yJDaV2HcBsR2w419UsTsBU/wh9w/FIIZYo6rxjlSP6bA8Ldse2L5RgN75NWMZDuTQxufB888g0xdhu5I8tfE6pajoOYtpRBGGbn4KSJ694HzU9kr0CdLOz6jMhbcjTtw47pYI/o6i7gtJW943ppSh5uwZ7guq2at/8YicwmruKpL3UGdJNmVxDFkXQWr9opRS84KhmCfwl2EUebz7DJs/2kch5g2axOaXCPzxvq29hD/GHRpKk=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB3661.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(346002)(376002)(366004)(396003)(39860400002)(136003)(9686003)(26005)(2906002)(6506007)(7696005)(53546011)(52536014)(5660300002)(8936002)(7416002)(76116006)(71200400001)(478600001)(186003)(41300700001)(110136005)(122000001)(38100700002)(83380400001)(86362001)(8676002)(38070700005)(55016003)(4326008)(66446008)(66946007)(64756008)(54906003)(316002)(66556008)(66476007)(33656002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RTkzckRTYjFVVW91L21KL0twRlliVzV2Uy9LUGdvbnNBWVU3aE9qRlg3RTF1?=
 =?utf-8?B?ekRjQi84QUFjQTZSM21QeEpjdVMvRmg0UC9RVkV0VFpENHpJSlkrRjdqQXNk?=
 =?utf-8?B?cENaTFkrMDVuRUZUNGFrczRIRHpzalQvc3NCbk85bWxBcHRZdkR6Z2lWVUp4?=
 =?utf-8?B?RmZ1cE9EakJpeUIvWWo0b0IvMFRXb0VFc3czTm9VYzZUZzI1N2M5LzN6Y3NQ?=
 =?utf-8?B?R1JFdkZ1c3R5UTcySXlhanZkWHRzYlBqRmtya2pxaEFrK1hUUFJuQllnMWMv?=
 =?utf-8?B?aXVud3RKL2RIZzY2azlqdnhLaGF2MTFxQjh5T1VzYWQ2QTNkcHhRdjNjSjhI?=
 =?utf-8?B?d3I2bi82UjJsKzQvQVQzeStNU1dvKzNyVG1kZ2VERkh6Mlg3bmMvdGpxbXlt?=
 =?utf-8?B?WTVQaUdrTGJiUWtqTDRJakJPcE1JdU1XU0xXZzl6S0I1RzI5eWpLWGFQdVk5?=
 =?utf-8?B?S3pPL0hyNGRuMUZlL2JlWG55UE5STGRUV2NXTmhQU3d1TExzaWFGSERoTTNx?=
 =?utf-8?B?dGFVaUkzMjJFUTkxMWNuVVB1YnhNcE9MMkpqcWpLckh4SlpIUHRqY0lkbG1w?=
 =?utf-8?B?TjEyRm1NYjNPcUxmNE5BS0sraHpSejdROThuQ3pWVWUraU5ydE1SU0QzT21I?=
 =?utf-8?B?S0JvNHZSNzF4YlZHWWhTWWh2V3ZjVWFSZ1NabTd5WWtiTm1TcXdmWjh3QzlW?=
 =?utf-8?B?eGlaVkpURDdsQ3lDdHE3TnF6N3JEa0N2R3lKU0dDMWFGdUcxSjIrNDA4SXJz?=
 =?utf-8?B?QVRUVk9UeEQyc1dQRlY1dEhrS1JoTkIzMGNIUlBPUlpOc1RuOEp0RXNYNnhX?=
 =?utf-8?B?Y3hxR0kzMDN6RzMrYlYzWnlOSldtQXlaT3JEMHliRllodnQ5MzJPYUlBN1Vi?=
 =?utf-8?B?MG5oS0NXdlJKRXIzb2lLNGtYUFZ2UHFOVS9uRWtnNmcwYWtMSWFMbm1rRGpv?=
 =?utf-8?B?NHBQVGZ5ZmxiU1ErMXhUdjhTRDYyTXMzTEFRVVZCbGdHTHRObUhuNjkwb2J6?=
 =?utf-8?B?SnRWQ3hFRVYzdXluQlFxMjVwWkJzU2ZrOHZ4WmJMVFU2a0FzaTF4L2ZrVVAx?=
 =?utf-8?B?RUZ4eWR3M2VRRlVOaUEzTWZYSDNWNjdPbmlFNVI1d1QrbjJCZ1NjT04zMjVJ?=
 =?utf-8?B?K1NvNHhyS3VDUS9ndSs4cEY3V1FRb2NRYkVXQnFQY3ZKR3h4TGVvYm95ZUQ1?=
 =?utf-8?B?Rm1DeEhMdnB2VzRxN0cyQnJ6RzZpV0ozcy9oMlFjZzkxVkJtMDVOVjR3ek1m?=
 =?utf-8?B?REpJVnJQU05HM3VKRjhGeFJrUUNaZVk5bm4zMGx3YnlQWXBMb2RWbldaSmVw?=
 =?utf-8?B?Z1Q2YjUyb08rOEU2NXVCQStvdi9YbWllNW15cWVGRWlLL1hselU1a2k0WFl2?=
 =?utf-8?B?QXc0SGF1RTR3RlNQVDNuN3E2WXBUbVZseUJLbi9yM2hmTHBzd1lITTIwSGdi?=
 =?utf-8?B?UHBUUWFJTnlDalRpVU5lTmh3WWdpcHVPbVQwNHU2VE5oanpUY2h2L2dZNEk4?=
 =?utf-8?B?UTRrZElmMEdlRFdmVkJJZG12MzB2UHFnK3doZlprVmRzZEE0dXZ6NlpwUFhQ?=
 =?utf-8?B?NDlDdWhvTUQrVjltcDFnSElDZy90WjNJb1NTSDFMdHRXeVM0MSszTG8zb0Vv?=
 =?utf-8?B?czM3MW1YT0dQMzdpTWR4clg0S1laUlJBQ0lZdTBwbDQvcUI2VW1SaUE2OXFi?=
 =?utf-8?B?TE91SE1YcTFUYVNma0t3a2J0c1lCb05TVGhnTmo0NXNJc1pOQzNmMmJRRXpJ?=
 =?utf-8?B?MG9OblRabjRFb3RrV3hNYm43ZjQ0NDJrMGMrRkpMZHBDMExvZGxRZEpUK3hQ?=
 =?utf-8?B?d21RWkkyRm4xSVJhMG9taTdmMG5WNlFJYktSd3VjdlRtMUZQMVkxMy9rcXpo?=
 =?utf-8?B?REt4dm1tcjhXQTBWUFRaY2R4YWdicW1aa2hWV0VHRS9QV3A1aTR3MFFvZlM2?=
 =?utf-8?B?anQwQiswUEFiSHFrSVpEVEc3UzJQTS9MNWkxbER2SWhZZGwwQjA5Ym9yajlK?=
 =?utf-8?B?OWM5NlcvaC9UNWtqQ3dFREhrcmpqTzlhYjYySGZMVHpYcExJTnFpUDkwdGtJ?=
 =?utf-8?B?SFhHNmlLRE1xRm15eXNLeDZZMlRsZHZWMUdTNDBHR2VwWkRkL0F5MDBrWWFJ?=
 =?utf-8?Q?VTnMySRKFM17ssn0uDu5lGK5G?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3661.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 22751ec4-ba07-48c5-99e6-08da6bd0f7cb
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jul 2022 10:57:28.0562
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: T+R/1GcwG8m5+wWZJJeDtAYj2/Z/uyHdmtz8a5nnyAWXTsnB+u92voAywnnLlM+CHkMVHfOwvr7rAriiX8NiWg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR1201MB2545
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

W0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEdlbmVyYWxdDQoNCg0KDQotLS0tLU9yaWdpbmFsIE1l
c3NhZ2UtLS0tLQ0KRnJvbTogUmFuZHkgRHVubGFwIDxyZHVubGFwQGluZnJhZGVhZC5vcmc+IA0K
U2VudDogVGh1cnNkYXksIEp1bHkgMjEsIDIwMjIgNzozMiBQTQ0KVG86IFNhYmEgS2FyZWVtLCBT
eWVkIDxTeWVkLlNhYmFLYXJlZW1AYW1kLmNvbT47IGJyb29uaWVAa2VybmVsLm9yZzsgYWxzYS1k
ZXZlbEBhbHNhLXByb2plY3Qub3JnDQpDYzogRGV1Y2hlciwgQWxleGFuZGVyIDxBbGV4YW5kZXIu
RGV1Y2hlckBhbWQuY29tPjsgSGlyZWdvdWRhciwgQmFzYXZhcmFqIDxCYXNhdmFyYWouSGlyZWdv
dWRhckBhbWQuY29tPjsgRG9tbWF0aSwgU3VuaWwta3VtYXIgPFN1bmlsLWt1bWFyLkRvbW1hdGlA
YW1kLmNvbT47IE11a3VuZGEsIFZpamVuZGFyIDxWaWplbmRhci5NdWt1bmRhQGFtZC5jb20+OyBM
aWFtIEdpcmR3b29kIDxsZ2lyZHdvb2RAZ21haWwuY29tPjsgSmFyb3NsYXYgS3lzZWxhIDxwZXJl
eEBwZXJleC5jej47IFRha2FzaGkgSXdhaSA8dGl3YWlAc3VzZS5jb20+OyBBaml0IEt1bWFyIFBh
bmRleSA8QWppdEt1bWFyLlBhbmRleUBhbWQuY29tPjsgUGllcnJlLUxvdWlzIEJvc3NhcnQgPHBp
ZXJyZS1sb3Vpcy5ib3NzYXJ0QGxpbnV4LmludGVsLmNvbT47IERhbmllbCBCYWx1dGEgPGRhbmll
bC5iYWx1dGFAbnhwLmNvbT47IEx1Y2FzIFRhbnVyZSA8dGFudXJlYWxAb3BlbnNvdXJjZS5jaXJy
dXMuY29tPjsgSnVsaWFuIEJyYWhhIDxqdWxpYW5icmFoYUBnbWFpbC5jb20+OyBCYXJkIExpYW8g
PGJhcmQubGlhb0BpbnRlbC5jb20+OyBvcGVuIGxpc3QgPGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5l
bC5vcmc+DQpTdWJqZWN0OiBSZTogW1BBVENIIDUvNV0gQVNvQzogYW1kOiBlbmFibGUgUlBMIFBs
YXRmb3JtIGFjcCBkcml2ZXJzIGJ1aWxkDQoNCltDQVVUSU9OOiBFeHRlcm5hbCBFbWFpbF0NCg0K
SGktLQ0KDQpPbiA3LzIwLzIyIDIzOjEwLCBzeWVkIHNhYmFrYXJlZW0gd3JvdGU6DQo+IGRpZmYg
LS1naXQgYS9zb3VuZC9zb2MvYW1kL0tjb25maWcgYi9zb3VuZC9zb2MvYW1kL0tjb25maWcgaW5k
ZXggDQo+IDljMmZlZjJjZTg5Zi4uMDhmNTI4OWRhYzU0IDEwMDY0NA0KPiAtLS0gYS9zb3VuZC9z
b2MvYW1kL0tjb25maWcNCj4gKysrIGIvc291bmQvc29jL2FtZC9LY29uZmlnDQo+IEBAIC0xMTcs
MyArMTE3LDEzIEBAIGNvbmZpZyBTTkRfQU1EX0FDUF9DT05GSUcNCj4gICAgICAgIGRyaXZlciBt
b2R1bGVzIHRvIHVzZQ0KPg0KPiAgc291cmNlICJzb3VuZC9zb2MvYW1kL2FjcC9LY29uZmlnIg0K
PiArDQo+ICtjb25maWcgU05EX1NPQ19BTURfUlBMX0FDUDZ4DQo+ICsgICAgICAgIHRyaXN0YXRl
ICJBTUQgQXVkaW8gQ29wcm9jZXNzb3ItdjYuMiBSUEwgc3VwcG9ydCINCj4gKyAgICAgICAgZGVw
ZW5kcyBvbiBYODYgJiYgUENJDQo+ICsgICAgICAgIGhlbHANCj4gKyAgICAgICAgICBUaGlzIG9w
dGlvbiBlbmFibGVzIEF1ZGlvIENvcHJvY2Vzc29yIGkuZSBBQ1AgdjYuMiBzdXBwb3J0IA0KPiAr
b24NCg0KSWYgdGhhdCAiaS5lIiBpcyBzdXBwb3NlZCB0byBtZWFuICJ0aGF0IGlzIiwgdGhlbiBp
dCBzaG91bGQgYmUgImkuZS4iLg0KT3IgZG9lcyBpdCBtZWFuIHNvbWV0aGluZyBlbHNlIGhlcmU/
DQoNCkl0IGlzIGEgdHlwbyBtaXN0YWtlLiBXaWxsIGNvcnJlY3QgaXQuDQo+ICsgICAgICAgICAg
QU1EIFJQTCBwbGF0Zm9ybS4gQnkgZW5hYmxpbmcgdGhpcyBmbGFnIGJ1aWxkIHdpbGwgYmUNCj4g
KyAgICAgICAgICB0cmlnZ2VyZWQgZm9yIEFDUCBQQ0kgZHJpdmVyLg0KPiArICAgICAgICAgIFNh
eSBtIGlmIHlvdSBoYXZlIHN1Y2ggYSBkZXZpY2UuDQo+ICsgICAgICAgICAgSWYgdW5zdXJlIHNl
bGVjdCAiTiIuDQoNCi0tDQp+UmFuZHkNCg==
