Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1875E5A0F92
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Aug 2022 13:50:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241289AbiHYLur (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Aug 2022 07:50:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241179AbiHYLuo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 07:50:44 -0400
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2061.outbound.protection.outlook.com [40.107.100.61])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 963F74D253;
        Thu, 25 Aug 2022 04:50:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jv1uWfj3L6KnJAfIwv++/DTSohWXm4TBiZkQ2v3dizdp7vZCM1dzlJnje4YgjGEknpro62QsFRYY2dRHerZbjytboawrFjufyT59GPkVLx+B+mj0/cx2IxJOb4ebT++jXH8jZHPrSW1Uk0Nw3qr4N1BR89Avg0IPfqlTF+e4gjlqyeCt+zQBlClobWtY+w0le1a+HPGdBLMpGB7Add1ib4Tb9aH/OczyyrtO+kj8n/UC1pKQN4ouH81jkL9tQluF93bpBiZcV0Cs0xG5dw8I7N5YZSmNLc844saDd+z8eZSdbMr8g/fMOGJSDy/FSXVhcIsgFe0zqzsECoHlnWsHNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uTFVtYylq9PnAHw0f5eR32dhk1SqDrOaPuIIrI/RDfU=;
 b=VMcgDkOP8d7OCPbWqlvf5SYtZG7EOiDVZWBZYm29wXokE/+wenrUsZJ89fqXBMefgDYzFxVAcJNRMczKAgLngWDFn09a5OMZHV/uITGmPocq3Us8quDCLzlerxGrqO/zcOG6F03Xyl8+JT1Lt5yrTqljtcOg3aWLW8NQFwYjXDnCY7vqt4JPBDh6TksVI5x3aNQuO0bN43kZgh+WwCgMhrjpF9nE5LnNWlkvQDFRsXtN6q8e8lLHmNXFP9CtPFPE3M79ALKUVyfSzKrpK2NJTUpU375PBc+7Q4VB28oJ+Y5Me5zAqKTKieBmyCaSfXFY1Udz5RsqvPQaOf0nKRMjTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uTFVtYylq9PnAHw0f5eR32dhk1SqDrOaPuIIrI/RDfU=;
 b=a99kOpy/rEOFEz9etKhyoedtVMJbKS9XcRI9Iy7iBJS9gG4eEcbMFTC75dJz5XlhIxRMKCLQudwojlxfGBWREdTOWtuSNh3jzCk31M4CnYh/zPOSbQ/MyWPYGMV+uet7uA6RQ88UJctA2HbLWOvHzhkhd2eCqzZctz7ylKkZhcY=
Received: from DM4PR12MB5040.namprd12.prod.outlook.com (2603:10b6:5:38b::19)
 by DS7PR12MB6190.namprd12.prod.outlook.com (2603:10b6:8:99::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.15; Thu, 25 Aug
 2022 11:50:39 +0000
Received: from DM4PR12MB5040.namprd12.prod.outlook.com
 ([fe80::ec56:2877:8bd7:afcd]) by DM4PR12MB5040.namprd12.prod.outlook.com
 ([fe80::ec56:2877:8bd7:afcd%4]) with mapi id 15.20.5566.015; Thu, 25 Aug 2022
 11:50:39 +0000
From:   "Natikar, Basavaraj" <Basavaraj.Natikar@amd.com>
To:     Thorsten Leemhuis <regressions@leemhuis.info>,
        "Limonciello, Mario" <Mario.Limonciello@amd.com>
CC:     "hi2@n101n.xyz" <hi2@n101n.xyz>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "regressions@lists.linux.dev" <regressions@lists.linux.dev>
Subject: RE: [Regression] Bug 216371 - acpi wake up with black screen with msg
 "amd_gpio AMDI0030:00: failed to get iomux index"
Thread-Topic: [Regression] Bug 216371 - acpi wake up with black screen with
 msg "amd_gpio AMDI0030:00: failed to get iomux index"
Thread-Index: AQHYuG9vXWdOAsqSq0SBcMFaCRLura2/gB1g
Date:   Thu, 25 Aug 2022 11:50:39 +0000
Message-ID: <DM4PR12MB5040F801358EDA9A82A80DBDE6729@DM4PR12MB5040.namprd12.prod.outlook.com>
References: <849a07ba-a53c-3f10-e2ec-25421c1e40ee@leemhuis.info>
In-Reply-To: <849a07ba-a53c-3f10-e2ec-25421c1e40ee@leemhuis.info>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=350aad50-ffa2-4606-b40e-709610fea2d6;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2022-08-25T11:47:46Z;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f176b694-927f-4356-2890-08da8690081a
x-ms-traffictypediagnostic: DS7PR12MB6190:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: es7NPzOEf+xUC5C19upfu05aDc4ZLhd31pA2PXOrhWpqFsSvI/MquNPDhXkqNkjG/ikpkb+Xx7ShYPID/IOVdxKF5WvcNvdxzWpltRk6S2+1N6DaOIoPAV3VT2iOY12DSxepb9xW09RxOyKPOMsmMttsnh8owQWu805tGNj+/M3OQVOahot/qkSi3pnsxbkY873UykiLOoXg+7HrC+uFwdy4cHsAMa3GednNl6y3ryplaQYZ92Ve72sFdZqym9OyIkNg+MqHpmqEFnpODjP0P1wDPBWsuMGy+FgHg0zSjvsyxB1diNNtMpSHtGKZ9x3SQe1eulS+1NcfyjDO9hQpv88ZnmrkM05C3EZOfmgPHhrcWoCgd2AOyTbm3iPU+yqc4SQAjvofcVrQCPjLyQBfGFYheP+gKZukDeyfy9HoKhsPFWNEkTc1+I8AURVWbnLxfEGH5goiq8CBsA3LBD4ba8xr9yxf3Dn8XNwWvo0sDMHkw9dS5y0TypCFkQSDWZiwci65ZPrLIneW6uix2oluXBGF3FFAesdDAo3vbEo8OsUoq7ZMrOj+W5/U4Kt1GaDPQOFoFP0WEVlLGk3q7J+PKyZUMhjo7TXYAUV0FeydL5GOykKHKawpJOTyyjU7I76oL0D65vWe5M5EQDHyWQ6I2t95JdxS2x8QtMKFZabE2Kjj0wsQ4e5q8WABgjbb7qO45vXQCb/XIKKKah8RReTIW8cI5QcTR0x+MENth2tRYIA7USg7DleeS70W8hTPbfw3lsw5lje/dliV58GhKfxGBKHUWH+qjqioBC6u884ChnY=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5040.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(366004)(396003)(346002)(39860400002)(136003)(376002)(45080400002)(76116006)(66946007)(64756008)(66446008)(8676002)(86362001)(66476007)(55016003)(66556008)(38070700005)(316002)(110136005)(6636002)(54906003)(52536014)(83380400001)(478600001)(966005)(186003)(38100700002)(122000001)(7696005)(71200400001)(53546011)(6506007)(9686003)(41300700001)(33656002)(2906002)(5660300002)(4326008)(8936002)(26005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WUoyMHR3ZjFZRzdiSGJFMDB0OEhsQWdaV2ZvdGh0Y293aFYzY2hrZGVERjY1?=
 =?utf-8?B?c2lKRFh1N3QrZFdaL3RGYVB4Nm9oUFh2cStqZTVCYnZsZy9LYmpIT281RGxp?=
 =?utf-8?B?MmdPb3dOQ3FURXlCTEdNVFJQQ1Mvd3hKUVdTcG9Wc3p5eWQwN3hNWXo0S0Zi?=
 =?utf-8?B?VUpVRnV3cWJMNDJ3TVFQRmxHd2JMUEVCMURJb0tZRFBoYWlIaUFBcWkvdm1X?=
 =?utf-8?B?MXNQZHNEb0kxVXpxbkV4WHhHTG5ZZzljVy9ETUZaTDl5RFlkSk1URUg4SDY5?=
 =?utf-8?B?VC81VlZDQWtEK2RPc0lZUkdnMmRVUHpGZktXT0c4RWJEOWdDV3VkSUxtYTNV?=
 =?utf-8?B?YkROdkR1Nm9aemZyKytDU1JMaU5BVWNzRWpORHByNDVXREZ0WE8wcDlTKzNN?=
 =?utf-8?B?UnNzK3h6ZG8zaTB6TzVUQmlCVFI2WmJiaHJGUU5sbzlFUDM5d0pyc1loRGIz?=
 =?utf-8?B?WWZDQU0vSTB1S3pGWHl0TEFSRVJRTHBrWTk4dmhKU1lLWktQc1pCR2FPMm9Z?=
 =?utf-8?B?K3N6bFVvdE9QelZuVnZiOEVxWmdwUGJxVFVja1FOUUZNUnpXanhqaGJxUzVY?=
 =?utf-8?B?M25EcG9tR2krT0FQS3E4Zi8rTlNDZkwxL2M5YXV2RXgrNm84Z2MrdzBRQmJx?=
 =?utf-8?B?YmtkNTM4cHhFY05KWUFyNThoNlAyOEtreURFai9WS0lqRFQ2YUFydUplN1NU?=
 =?utf-8?B?aloySWwyWFNKUVM2bGZwN2VaQ21GVVRyVUxOTlFUNXNneVk5T0k4ZnBzNzV4?=
 =?utf-8?B?S2NjQW5vdkNJMzlCQ0tzcnBOSEVieGdlVWFBdDBTTkNpVHIvYnBORENwb2FU?=
 =?utf-8?B?STg2YXZxUFRpS0s4TmpMSXlSUGtjNXBQQ1ZlcmI1MzM4dittMTdwYU04d1My?=
 =?utf-8?B?dHBMcGRleG9mRE8xYU9JMk44T2JMRUk3eEtLalJDU25Wb1pza2E0ejYvaXZD?=
 =?utf-8?B?U21nSHpDaWZTaW5Lc1gvVlo4M0NvU3kzWjk3bWdsYi9iMHNxRFZkK0pLS2Qw?=
 =?utf-8?B?R1R4U3JNbHJ3UGs3dTlRVHEvOW9KQi9pUE9Cb2dGTWlack5ZQXhaM0hYTmNh?=
 =?utf-8?B?a3RvQnppZWRiVlhDNWZVSDYzeS9JUmkvY2FIT3FCVmRJNmFHbHdrY0J2Um95?=
 =?utf-8?B?MVZTbTc4aDFOQTlyMlZLRGZjSVRHWVJwdmpCNVRFd2YyNHZ1THYrZ0dYNzJK?=
 =?utf-8?B?eE1uTnJJMnFlSVRhb2hXTWVHb0FNelYwdlZPTmNBNlR4Z3JIK2xUbW9MWDFm?=
 =?utf-8?B?VXhOTmh3bm1sTENocldRYkdmM29aS3FzSTN2dGxkOG5EMTA1aXlzems1Y2ov?=
 =?utf-8?B?RklEUWpoRkFjSTlYME9BdDl5bk1TQ0RGbXJBT05pbnh6WDhyWW1KTTRIaVFH?=
 =?utf-8?B?bFZRbmJObTYwdXorRzVnUjQxdWdsd0xDcERmL1hFazVrRFE1VmdVczd5aVNj?=
 =?utf-8?B?RkVLaTZHclBQcUhnTGh0VGVxeitrZlZSYWZVRnB5SHZDUUdYOFZ4dHVDM0Js?=
 =?utf-8?B?QmxZOXJDcHBsMmwwNlcvZndCdUloWElOekp4d0NzQmkveXhSUm9vTnpBVnNu?=
 =?utf-8?B?c01ZTG5PUUFSUFBZeGhNYWRpL3dmZFRDVk5TbWRwa0hQS0FyeG1tdEVBMnVq?=
 =?utf-8?B?YmFzUG51aGVhc0ZBYzZBbTBkQXdzS2FoNXpqay8wUmg2NExtbGE2ZmhWaUt1?=
 =?utf-8?B?NDVrdkUxZHp4QXZCb3lPV2U4MFpLcjc1TXlMVUVnOHVSZFJHRjRwc0NtQ0c3?=
 =?utf-8?B?SFdqRnZPMFVMVmh2TjZvSUhmUTg5RE1oTmg0cWhIR003THhtUDMyb3hVRnBK?=
 =?utf-8?B?cWc3SGpTQXZpN3FqaGFxbFV6bS8wbnFNb0tvYUU4eER0eit5TVZFc0F4TnFE?=
 =?utf-8?B?UFowa1NpQnBxZDZUQXRLNW51WmdScTMxMFhzSnhpTyswbjJKcE9xMk5FZEZE?=
 =?utf-8?B?dTQrRmJvOXVybXZzN3ZVYzNGOVU3MXZRM3U0TnM5Q1BpRFozUStJdEFheWoz?=
 =?utf-8?B?RVRjMERYQk5CVGpjWEFRYVJUOFBPRE5DZS9LT2xMVG1GVCtBUXU3TUt3cUsv?=
 =?utf-8?B?Uk9xZHlJSlhxUFRVNlRlaXhKYkNOMDNwSUkyK3IyZkhHSlRaQWhQR05nMHVl?=
 =?utf-8?Q?THSHQpKTNDrfSbtxhD/IQwfZJ?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5040.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f176b694-927f-4356-2890-08da8690081a
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Aug 2022 11:50:39.5402
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3QaDYL94DKB8XOtV7YkS+ehX02lnyQVQT+vcHrw3ZWoeOXte3eRtv0+J3FXXc/XGG2tuz31tBvGNchaBb6ca1g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6190
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

W0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEdlbmVyYWxdDQoNClllcyB0aGlzIGVycm9yIG1lc3Nh
Z2UgaXMgYWRkaXRpb25hbCBtZXNzYWdlIHRoYXQgaXQgc3VwcG9ydHMgZ3BpbyBub3QgYW4gaW9t
dXguIE5vdCByZWxlYXRlZCB0byBhbnkgZnVuY3Rpb25hbGl0eSBjaGFuZ2VzLg0KSSB3aWxsIGNo
YW5nZSBlcnJvciBtZXNzYWdlIHRvIGluZm8gbGlrZSAgIklPTVVYIG5vdCBzdXBwb3J0ZWQiLg0K
V2hpY2ggaXMgdW5yZWxhdGVkIHRvIGFjcGkgd2FrZSB1cCB3aXRoIGJsYWNrIHNjcmVlbiBpc3N1
ZS4NCg0KVGhhbmtzLA0KQmFzYXZhcmFqDQoNCg0KDQotLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0t
LQ0KRnJvbTogVGhvcnN0ZW4gTGVlbWh1aXMgPHJlZ3Jlc3Npb25zQGxlZW1odWlzLmluZm8+DQpT
ZW50OiBUaHVyc2RheSwgQXVndXN0IDI1LCAyMDIyIDQ6MTMgUE0NClRvOiBOYXRpa2FyLCBCYXNh
dmFyYWogPEJhc2F2YXJhai5OYXRpa2FyQGFtZC5jb20+OyBMaW1vbmNpZWxsbywgTWFyaW8gPE1h
cmlvLkxpbW9uY2llbGxvQGFtZC5jb20+DQpDYzogaGkyQG4xMDFuLnh5ejsgb3BlbiBsaXN0OkdQ
SU8gU1VCU1lTVEVNIDxsaW51eC1ncGlvQHZnZXIua2VybmVsLm9yZz47IExLTUwgPGxpbnV4LWtl
cm5lbEB2Z2VyLmtlcm5lbC5vcmc+OyByZWdyZXNzaW9uc0BsaXN0cy5saW51eC5kZXYNClN1Ympl
Y3Q6IFtSZWdyZXNzaW9uXSBCdWcgMjE2MzcxIC0gYWNwaSB3YWtlIHVwIHdpdGggYmxhY2sgc2Ny
ZWVuIHdpdGggbXNnICJhbWRfZ3BpbyBBTURJMDAzMDowMDogZmFpbGVkIHRvIGdldCBpb211eCBp
bmRleCINCg0KSGksIHRoaXMgaXMgeW91ciBMaW51eCBrZXJuZWwgcmVncmVzc2lvbiB0cmFja2Vy
Lg0KDQpJIG5vdGljZWQgYSByZWdyZXNzaW9uIHJlcG9ydCBpbiBidWd6aWxsYS5rZXJuZWwub3Jn
IHRoYXQgYWZhaWNzIG5vYm9keSBhY3RlZCB1cG9uIHNpbmNlIGl0IHdhcyByZXBvcnRlZC4gVGhh
dCdzIHdoeSBJIGRlY2lkZWQgdG8gZm9yd2FyZCBpdCBieSBtYWlsIHRvIHRob3NlIHRoYXQgYWZh
aWNzIHNob3VsZCBoYW5kbGUgdGhpcy4NCg0KVG8gcXVvdGUgZnJvbSBodHRwczovL25hbTExLnNh
ZmVsaW5rcy5wcm90ZWN0aW9uLm91dGxvb2suY29tLz91cmw9aHR0cHMlM0ElMkYlMkZidWd6aWxs
YS5rZXJuZWwub3JnJTJGc2hvd19idWcuY2dpJTNGaWQlM0QyMTYzNzEmYW1wO2RhdGE9MDUlN0Mw
MSU3Q0Jhc2F2YXJhai5OYXRpa2FyJTQwYW1kLmNvbSU3QzY2ODA5Yjk5MGE1NjQyMDA4NzRjMDhk
YTg2ODY5MDM4JTdDM2RkODk2MWZlNDg4NGU2MDhlMTFhODJkOTk0ZTE4M2QlN0MwJTdDMCU3QzYz
Nzk3MDIwOTc1NzI0NDgyNCU3Q1Vua25vd24lN0NUV0ZwYkdac2IzZDhleUpXSWpvaU1DNHdMakF3
TURBaUxDSlFJam9pVjJsdU16SWlMQ0pCVGlJNklrMWhhV3dpTENKWFZDSTZNbjAlM0QlN0MzMDAw
JTdDJTdDJTdDJmFtcDtzZGF0YT1wRU85TGMwcXdQNUxIaG9odUZIQWc5b2F3bjNUV3MlMkJNOWVu
WGw5ZSUyQmElMkJFJTNEJmFtcDtyZXNlcnZlZD0wIDoNCg0KPiAgbmVvZSAyMDIyLTA4LTE3IDAx
OjUwOjQxIFVUQw0KPg0KPiBqdXN0IHVwZ3JhZGUgZnJvbSA1LjE4IHRvIDYuMC4wLXJjMQ0KPg0K
PiBgYWNwaXRvb2wgLXNgDQo+IHRvIHNldCB0byBzbGVlcCwgaXQgc2VlbXMgYSBsaXR0bGUgc2xv
dy4NCj4NCj4gdGhlbiB3YWtlIHVwLCBibGFjayBzY3JlZW4sDQo+DQo+IGV2ZXJ5dGhpbmcgd29y
a3MgZmluZSBiZWZvcmUuDQo+DQo+IEFNRCAzOTAwWA0KPg0KPiBbcmVwbHldIFviiJJdIENvbW1l
bnQgMSBuZW9lIDIwMjItMDgtMjIgMDI6Mzk6MTIgVVRDDQo+DQo+IGRtZXNnDQo+DQo+IGFtZF9n
cGlvIEFNREkwMDMwOjAwOiBmYWlsZWQgdG8gZ2V0IGlvbXV4IGluZGV4DQpTZWUgdGhlIHRpY2tl
dCBmb3IgZGV0YWlscy4NCg0KUGxlYXNlIGxvb2sgaW50byB0aGUgaXNzdWUgaWYgeW91J3JlIGFt
b25nIHRoZSBtYWluIHJlY2lwaWVudHMgb2YgdGhpcyBtYWlsIChhbmQgbm90IGp1c3QgQ0NlZCku
IEkgaG9wZSBJIHBpY2tlZCB0aGUgcmlnaHQgcGVvcGxlIHRvIHNlbnQgdGhpcyB0bywgaWYgbm90
LCBqdXN0IGxldCBldmVyeW9uZSBrbm93IChhbmQgYXBvbG9naWVzISkuIEJhc2F2YXJhaiwgdW5s
ZXNzIG15IHF1aWNrIGFuYWx5c2lzIG9mIHRoZSBzaXR1YXRpb24gd2VudCBoYXl3aXJlIGl0IHNl
ZW1zIHRoYXQgeW91IHJlY2VudGx5IGFkZGVkIGNvZGUgd2l0aCB0aGUgZXJyb3IgbWVzc2FnZSBu
b3RpY2VkIGJ5IHRoZSByZXBvcnRlci4NCg0KQW55d2F5LCB0byBlbnN1cmUgdGhpcyBpcyBub3Qg
Zm9yZ290dGVuIGxldHMgZ2V0IHRoaXMgdHJhY2tlZCBieSB0aGUgdGhlIExpbnV4IGtlcm5lbCBy
ZWdyZXNzaW9uIHRyYWNraW5nIGJvdDoNCg0KI3JlZ3pib3QgaW50cm9kdWNlZDogdjUuMTkuLnY2
LjAtcmMyDQpodHRwczovL25hbTExLnNhZmVsaW5rcy5wcm90ZWN0aW9uLm91dGxvb2suY29tLz91
cmw9aHR0cHMlM0ElMkYlMkZidWd6aWxsYS5rZXJuZWwub3JnJTJGc2hvd19idWcuY2dpJTNGaWQl
M0QyMTYzNzEmYW1wO2RhdGE9MDUlN0MwMSU3Q0Jhc2F2YXJhai5OYXRpa2FyJTQwYW1kLmNvbSU3
QzY2ODA5Yjk5MGE1NjQyMDA4NzRjMDhkYTg2ODY5MDM4JTdDM2RkODk2MWZlNDg4NGU2MDhlMTFh
ODJkOTk0ZTE4M2QlN0MwJTdDMCU3QzYzNzk3MDIwOTc1NzI0NDgyNCU3Q1Vua25vd24lN0NUV0Zw
Ykdac2IzZDhleUpXSWpvaU1DNHdMakF3TURBaUxDSlFJam9pVjJsdU16SWlMQ0pCVGlJNklrMWhh
V3dpTENKWFZDSTZNbjAlM0QlN0MzMDAwJTdDJTdDJTdDJmFtcDtzZGF0YT1wRU85TGMwcXdQNUxI
aG9odUZIQWc5b2F3bjNUV3MlMkJNOWVuWGw5ZSUyQmElMkJFJTNEJmFtcDtyZXNlcnZlZD0wDQoj
cmVnemJvdCBpZ25vcmUtYWN0aXZpdHkNCg0KVGhpcyBpc24ndCBhIHJlZ3Jlc3Npb24/IFRoaXMg
aXNzdWUgb3IgYSBmaXggZm9yIGl0IGFyZSBhbHJlYWR5IGRpc2N1c3NlZCBzb21ld2hlcmUgZWxz
ZT8gSXQgd2FzIGZpeGVkIGFscmVhZHk/IFlvdSB3YW50IHRvIGNsYXJpZnkgd2hlbiB0aGUgcmVn
cmVzc2lvbiBzdGFydGVkIHRvIGhhcHBlbj8gT3IgcG9pbnQgb3V0IEkgZ290IHRoZSB0aXRsZSBv
ciBzb21ldGhpbmcgZWxzZSB0b3RhbGx5IHdyb25nPyBUaGVuIGp1c3QgcmVwbHkgLS0gaWRlYWxs
eSB3aXRoIGFsc28gdGVsbGluZyByZWd6Ym90IGFib3V0IGl0LCBhcyBleHBsYWluZWQgaGVyZToN
Cmh0dHBzOi8vbmFtMTEuc2FmZWxpbmtzLnByb3RlY3Rpb24ub3V0bG9vay5jb20vP3VybD1odHRw
cyUzQSUyRiUyRmxpbnV4LXJlZ3RyYWNraW5nLmxlZW1odWlzLmluZm8lMkZ0cmFja2VkLXJlZ3Jl
c3Npb24lMkYmYW1wO2RhdGE9MDUlN0MwMSU3Q0Jhc2F2YXJhai5OYXRpa2FyJTQwYW1kLmNvbSU3
QzY2ODA5Yjk5MGE1NjQyMDA4NzRjMDhkYTg2ODY5MDM4JTdDM2RkODk2MWZlNDg4NGU2MDhlMTFh
ODJkOTk0ZTE4M2QlN0MwJTdDMCU3QzYzNzk3MDIwOTc1NzI0NDgyNCU3Q1Vua25vd24lN0NUV0Zw
Ykdac2IzZDhleUpXSWpvaU1DNHdMakF3TURBaUxDSlFJam9pVjJsdU16SWlMQ0pCVGlJNklrMWhh
V3dpTENKWFZDSTZNbjAlM0QlN0MzMDAwJTdDJTdDJTdDJmFtcDtzZGF0YT1YTCUyQlNhT2xISVgy
M01RWXpWNVpqZWZVZEJBSGlBJTJGTkV6OWZyQVJ5OXBzcyUzRCZhbXA7cmVzZXJ2ZWQ9MA0KDQpS
ZW1pbmRlciBmb3IgZGV2ZWxvcGVyczogV2hlbiBmaXhpbmcgdGhlIGlzc3VlLCBhZGQgJ0xpbms6
JyB0YWdzIHBvaW50aW5nIHRvIHRoZSByZXBvcnQgaW4gYnVnemlsbGEsIGFzIHRoZSBrZXJuZWwn
cyBkb2N1bWVudGF0aW9uIGNhbGxzIGZvcjsgYWJvdmUgcGFnZSBleHBsYWlucyB3aHkgdGhpcyBp
cyBpbXBvcnRhbnQgZm9yIHRyYWNrZWQgcmVncmVzc2lvbnMuDQoNCkNpYW8sIFRob3JzdGVuICh3
ZWFyaW5nIGhpcyAndGhlIExpbnV4IGtlcm5lbCdzIHJlZ3Jlc3Npb24gdHJhY2tlcicgaGF0KQ0K
DQpQLlMuOiBBcyB0aGUgTGludXgga2VybmVsJ3MgcmVncmVzc2lvbiB0cmFja2VyIEkgZGVhbCB3
aXRoIGEgbG90IG9mIHJlcG9ydHMgYW5kIHNvbWV0aW1lcyBtaXNzIHNvbWV0aGluZyBpbXBvcnRh
bnQgd2hlbiB3cml0aW5nIG1haWxzIGxpa2UgdGhpcy4gSWYgdGhhdCdzIHRoZSBjYXNlIGhlcmUs
IGRvbid0IGhlc2l0YXRlIHRvIHRlbGwgbWUgaW4gYSBwdWJsaWMgcmVwbHksIGl0J3MgaW4gZXZl
cnlvbmUncyBpbnRlcmVzdCB0byBzZXQgdGhlIHB1YmxpYyByZWNvcmQgc3RyYWlnaHQuDQo=
