Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 530E15711D7
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 07:30:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231396AbiGLFaC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jul 2022 01:30:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbiGLF37 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 01:29:59 -0400
Received: from esa18.fujitsucc.c3s2.iphmx.com (esa18.fujitsucc.c3s2.iphmx.com [216.71.158.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36499655B5
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 22:29:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1657603798; x=1689139798;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=66qYjxYRoWDx+69q5/N1NNNqVjEmu3rfzaWZ1lBvP1g=;
  b=VXXk/R4Ti6AKEMFfFB9cK88XhAqISLrkJ780mqUIYxKRQjztEFE9iRiV
   BQhWzxBrlrG+xMv/WIZhm2nxLa7siYcxDx+B1qo3rWQlpO9G+EDQWEtvE
   uiyEgKXQdWXdHFt7jD6DNPv7fl3AVjyhUHLHbzzEl0IP1iJp+nLUHAcv9
   8pRvgTmkdzGo6mU0KX8TMJ5jCI/qkymItO2nFnkt6xFV+mTT1z+aI7dnz
   cO/qSLQgnsKwNk+de4PWE/KdgpyucZ8s14ASvsCMPxIox4fZPpuj6i+8w
   2pYJWqZsjN4eWsTLb1OS3yd7+JJsUEpvTZlcbaLMnhJqklFJ0UEQCZn2l
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10405"; a="61599297"
X-IronPort-AV: E=Sophos;i="5.92,264,1650898800"; 
   d="scan'208";a="61599297"
Received: from mail-tycjpn01lp2177.outbound.protection.outlook.com (HELO JPN01-TYC-obe.outbound.protection.outlook.com) ([104.47.23.177])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jul 2022 14:29:54 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EwF9jMmH8Yyr7TCxxU0rsMFOc898oDJBiQ5jIv12LlKvdUb33VRLWmZ6FedJxNhCixfkStus7YfXqnC6bzIBerQ/yKIcDgL2ASyKhVkOVYtFk/4ZXpv81evd2NySZsXbSc75vCHp+3y80jSkoOUnOcI+c9q1d67Xakp0O6qHzLW+YKk0QZPi37AY9raWahgXwJpkK4Ex7soTzg+yrPvtWpaRUsdCMCQyAGAC9WwyppRJhlRQjL3gkRadMXTMtpViWzumiqQp6SWxs0zEhUlkzRfzvEf9KjV6NlU+M+w+fAr/cOGECNYr5ytC39WLfn0AvQzVRBMGFg6FGoZhCnuLVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XAKB3BkJZIDMjwGGf4qcnN6rBV2h9+vMkBxCDilC68Y=;
 b=FMj7VBhHhDVxVnk+ULSRzps3njyeyR5ethlGvIafWopbYrUdeWNOWO+2L3TGHdMTNyBjYtbbw2gnpeK0R3Gzhi52ezTMb2dzf52OLyeRBk0lc1gFteiKHInY0PMAxU5rWZgeIirUwsHUMh66qU6UiRpyJJlU52GopWEcZm0krtiC19jvoLl4C6+2ZFutg09KqNk3kP8dGZrvplcrHqu/uCZi/a8on9i2eml4Sut3kuq9HdkLFlChpPvkDvJrGfqoGRIjUNMC4b7qhfFiimumfN2+Yge1cjwUSpBa9dAdOxRzymvIQ0zuAmihY0+xpMh+YLZMoNhiIESJSlmDQATLDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fujitsu.onmicrosoft.com; s=selector2-fujitsu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XAKB3BkJZIDMjwGGf4qcnN6rBV2h9+vMkBxCDilC68Y=;
 b=bIj+Txuv17O3qQeVjBitn4CYcD5kigm/VtKKmgqkLiV+rRFoHpFlDxaty9nI3Sq68dX1628QRwkTVrB5lSvoOQ1Dj7Eh2cMVNd9MTsScq/+vivdp/IwjXgh3J0nKeqC8nGup/tRsHDDwH2Me9XuGV3si5hYdBDVkTZNDXXacEIg=
Received: from TYAPR01MB2031.jpnprd01.prod.outlook.com (2603:1096:404:2::12)
 by OSBPR01MB4502.jpnprd01.prod.outlook.com (2603:1096:604:7c::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.16; Tue, 12 Jul
 2022 05:29:51 +0000
Received: from TYAPR01MB2031.jpnprd01.prod.outlook.com
 ([fe80::8d4:191d:4d98:721]) by TYAPR01MB2031.jpnprd01.prod.outlook.com
 ([fe80::8d4:191d:4d98:721%6]) with mapi id 15.20.5417.026; Tue, 12 Jul 2022
 05:29:51 +0000
From:   "itaru.kitayama@fujitsu.com" <itaru.kitayama@fujitsu.com>
To:     'Anshuman Khandual' <anshuman.khandual@arm.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
CC:     "german.gomez@arm.com" <german.gomez@arm.com>,
        "james.clark@arm.com" <james.clark@arm.com>,
        "suzuki.poulose@arm.com" <suzuki.poulose@arm.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] drivers/perf: arm_spe: Fix consistency of
 SYS_PMSCR_EL1.CX
Thread-Topic: [PATCH] drivers/perf: arm_spe: Fix consistency of
 SYS_PMSCR_EL1.CX
Thread-Index: AQHYla5bgqrtlTiPgUqr049Gonl2V616NTvg
Date:   Tue, 12 Jul 2022 05:29:51 +0000
Message-ID: <TYAPR01MB2031EDAB65B9F7514AE6C06081869@TYAPR01MB2031.jpnprd01.prod.outlook.com>
References: <20220712051404.2546851-1-anshuman.khandual@arm.com>
In-Reply-To: <20220712051404.2546851-1-anshuman.khandual@arm.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_Enabled=true;
 MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_SetDate=2022-07-12T05:29:49Z;
 MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_Method=Standard;
 MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_Name=FUJITSU-RESTRICTED?;
 MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_SiteId=a19f121d-81e1-4858-a9d8-736e267fd4c7;
 MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_ActionId=3a1e2a8f-3c0a-45f0-939c-ca928bc7538d;
 MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_ContentBits=0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 30db7213-6ea2-4525-2fc0-08da63c78b2b
x-ms-traffictypediagnostic: OSBPR01MB4502:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: QSE2Vqhoac1ddxewXN9NRvSt4q8Ec6xWKnlEkO2+nLIzinoswBavWtRlMNc6LYUAe+/Z69M68YjXYdyPQh4Yl69+j7eJTlYrg+68sxYPdY8OLQN7IiITqxj5hqMHyhsNXqUGCnDRHco+EgVDW6DtAKcJbNUJaxeNoJNnmFvXVgmeGJJxQA1TZVjOPUYBPnc2RLY1kilGVVksoM4Lazt0gZmQ4/1MBEEXmkr8oKZ9VyiI87ha1JPnAw2dNnDehut8ugGDEZkS3ixFLORZQYqOsCQDH+dGNPDjBANdt7Avqhu6FcZ7MxbX4zy1xqNAeTvFeG5bItYscOy3Mn2VaNroEIC+DNVtetc31x/YoDDOmI3vdEuJWwTY4ULo4AE/TrPsU2jRcAZpYofFPdG51KOPmo8YJENIwK9RBjTNxZTMYk9t6nCWiNW9iLCvgxbW5Eu4KdJvz0yQqGXmC1agM97gfuteTD9O+VTVhGOCg07n0CWqSLrukyVE9O4QCDvi8LJSVrw+VVmkkvj/fpWh56OG5jQj9xBFlUAA/IhNt2e+uCJqlM/aDz+HDBlHOs/L7+dT70sWRlaoTT+3x465xrDR1n9+PSGNV8bQZjKgXqzsEsqjOQcWdiMU755QNkhrRvJJwYgQN8osncIB4R8elALbVJPXd+nzSceCU0D/FT05f8hzEOdRpW4Yh0EK6sBjR//b0uJwywU9v4cnrNn6myqbNM8If96eDfb/tOFX66M7HPtn7QoP0QlfvUvLOSICmZEzCe2YP6+9iTOet8Ne+YMuJub3EE4LP0mLtEWKRO0F5T7qG9yXtgXJCj1CVi9WFkNeGx+2rNPj198WDpm7lHew0JGFmbZc2qHSIErMBi/3oG39by3jV5UmTTJk9xjToClJ
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYAPR01MB2031.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(136003)(366004)(39860400002)(376002)(346002)(396003)(186003)(85182001)(478600001)(66556008)(66446008)(82960400001)(55016003)(83380400001)(38070700005)(66476007)(122000001)(38100700002)(66946007)(76116006)(26005)(71200400001)(54906003)(41300700001)(6506007)(7696005)(110136005)(2906002)(966005)(64756008)(9686003)(53546011)(86362001)(52536014)(316002)(5660300002)(8936002)(33656002)(8676002)(4326008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-2022-jp?B?ZWIxd0dvTUdxb2RVR2hiVkNwRWpWaWVLZ3BqUWV0RTdkbzVZck5GZ05E?=
 =?iso-2022-jp?B?bk42d0FzRUcyOW5nL054NFFzSkpRSGJMNHpxb0E1SFNhSjhydHE0YnlC?=
 =?iso-2022-jp?B?VTJNVFhwT1ZSbWJ1VDFPaTB4T0JjejhoZXJ4YkdrSGMraFRpc2hMMFA4?=
 =?iso-2022-jp?B?M3lNaFVFQVJhZUREbGtPcDdQYlpTMGlOYWFSNU13L09XY3RlOU9FY2pB?=
 =?iso-2022-jp?B?VlppanBJTmFZNlFCb3BUTDNTU21wTHY5YWtHSDIwajFMRENObjQxSkZV?=
 =?iso-2022-jp?B?YnZqQVp0bE1wYTVWb0hCSnJLWGdXUDk5V29Pemd1Y0JaWTFBTktWQzha?=
 =?iso-2022-jp?B?U2M3d2JnVVRFaEZDSXROVnMzdlFMakxKR0haN0J0OHA2eDlIbUZveDg4?=
 =?iso-2022-jp?B?QjFkNkorUGlSMmZENExNU2lNMkRQenhRSXhuYzN1dFh5ajNCZTdhMkxl?=
 =?iso-2022-jp?B?OUhOeFVISkorNGVyajhaOW85LzQ4WEJ6U2VCTFlhREtWUTVvcjQyOUgy?=
 =?iso-2022-jp?B?anBOVktFcEJOTFVNdUNoQ215OVhuTjBxeGhiN3BMaWNXaHlkTGlFWXpx?=
 =?iso-2022-jp?B?UHhGTlFlenNoNTJuOFZCUU1QVnNSZzIvVlBLNEt3YVlieEVCblNNYzhw?=
 =?iso-2022-jp?B?emtNeDZhYi9xc1FvdTlCTGxZYkt3NXg3ajVERzdzN0dsczM3RzJndUdo?=
 =?iso-2022-jp?B?THYycjhUaEIzUFZkY2U5b0lCV2NOV2daVFZjVEh3YUxnUDlIVmVtRkMv?=
 =?iso-2022-jp?B?TGVHcmV6Rm9rT2g2ejFQeXdRK1RTaVFsY3Z4YXdwNVI2ejNZNE1LQ0pK?=
 =?iso-2022-jp?B?UzVIWUZsQTB6YVlUVmJibmkvVDEyUlFYRkNQZXFvUmNXRGhNQ0JNSmVq?=
 =?iso-2022-jp?B?UW9sZVBlTEcvVCtyZE41ckZERjdYU1VMRHpNdHV3WjNYem5UK2lPYmRr?=
 =?iso-2022-jp?B?V1NGRXNpcXhDVEkyK0l1VzNnbGE4QWFUUDdnNUdPaHBpdjg1YVNlMU9X?=
 =?iso-2022-jp?B?cXZLK2hsTWhOMEtXVjF5UHEzMkJCcnczdURZcDlEMW1RSFcwcTVSa01h?=
 =?iso-2022-jp?B?R1NRSm1OVVRqVk1HSm1YRVdHT3RENG5LWTE3cE1CdEtYYWVoSHl3QnZP?=
 =?iso-2022-jp?B?d1BkOUFIS0RJMUNLaWZuSzE5NGZDOUpSa2NLQTRjQllqOU42K09QbDZD?=
 =?iso-2022-jp?B?MkFqMUdVdEZRTnBkZkRUOUkrWXZ4MEoxS2FkZmJQVGJPczhPQlVUTkdn?=
 =?iso-2022-jp?B?ZHg0Ty9GQ2lIWWpiUFJiRDlxK3RqTnhuajhBbi93cGp1TVgzdkJFNzJq?=
 =?iso-2022-jp?B?UU5qTFdyZ1BrQ3BwUlFpQnpmd0FyZ0NmcVZmU240V3M0Sys0Y0c3SU5K?=
 =?iso-2022-jp?B?dXlCNE5mZlJKTHB6cjRpbkNySm5DWE1wQ1BPSmxhd3B1Wms5UXVHV2V3?=
 =?iso-2022-jp?B?cTdOLzJWOUlNZ2x5ZWk0ekdCOTJscW94RHVDQVp6aUFsSFJOU205eWVL?=
 =?iso-2022-jp?B?MnUwcUltTGhMN0pVMUdrRVFYdTVkaEFkVlpYaHV5QWlZZytCQ09JOW1X?=
 =?iso-2022-jp?B?anh5ejlSY1RWZlNRUkdaTVVxWC9CMlNMbHhjYnEwdlNkWFpscEtrWmt5?=
 =?iso-2022-jp?B?UUs1bkVGT1dTVWlxM0RFcmlFZGxUSUNabzdRR1hEbXFWRE44dzlEM0FH?=
 =?iso-2022-jp?B?ODRTeEkyU3A4U3pROWtNOTRIbjdoQVF4eWxzNXZtbFBKb3d1Y2NsSEtR?=
 =?iso-2022-jp?B?WHF4V2hNL244ZXVuTUw1UnFUaVl3bks2azRRZ1ZTci9KRHpVTHVjMjQv?=
 =?iso-2022-jp?B?WHJ6ZUNxUGE5M2ZVeGJOLytCVXlBM2QxdHBXckpZZllrd0Q0UjZMVm5E?=
 =?iso-2022-jp?B?enpLQ1J5dUpTZzhGT0RkZGhoTUNyNlhGcWQxTlVYelZ5S0dVRHNiRG5G?=
 =?iso-2022-jp?B?akFsWGEzditUL0NiTlVCUklFM1ZNS0VRVG02VTB3K2VYVVdtZG1jSWhS?=
 =?iso-2022-jp?B?SVowaG5sM0VkRUhRcHV5eEhzb3lra2VnL29WMS83emVzejAyWTZzVnhT?=
 =?iso-2022-jp?B?N0tIaWxyMFg3aHovSXdxWmZQbW00QUZTRTNsaWdkM0JkTkhxWEtMWTNY?=
 =?iso-2022-jp?B?dHdvMFE2YldvVVFRYWtiRnE2VkhmdlMxbGs3MzA4MHRoWkZOaGpkakZV?=
 =?iso-2022-jp?B?bWZpaTFQV1NDRW9KS2ZiM1pzR2N4S2JTL29lbHBmODdqSWYyVHRkY1R1?=
 =?iso-2022-jp?B?cXZiM2RxdENqREZPamxLenRHaTJUN3VQQnc1ZC9qQkdFOW1VT0FoVmR6?=
 =?iso-2022-jp?B?bzFPS0g5c3NHK2FLMlBvNFoxeHQ4a3lLblE9PQ==?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYAPR01MB2031.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 30db7213-6ea2-4525-2fc0-08da63c78b2b
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Jul 2022 05:29:51.0539
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: stPQW//ruQ+noLU5fI5MkWq2tOLuaiPq/Fk65I9kEKY5/N7Lyr86RtpUq2dgopBq4pu7i8SMxbBPQYeyiSXBeeNDnLmAWCy8v4n4A//3px8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSBPR01MB4502
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Anshuman,
Do you make your git tree public so we can pull and examine?

Thanks,
Itaru.

-----Original Message-----
From: linux-arm-kernel <linux-arm-kernel-bounces@lists.infradead.org> On Be=
half Of Anshuman Khandual
Sent: Tuesday, July 12, 2022 2:14 PM
To: linux-arm-kernel@lists.infradead.org
Cc: german.gomez@arm.com; james.clark@arm.com; suzuki.poulose@arm.com; Ansh=
uman Khandual <anshuman.khandual@arm.com>; Will Deacon <will@kernel.org>; M=
ark Rutland <mark.rutland@arm.com>; linux-kernel@vger.kernel.org
Subject: [PATCH] drivers/perf: arm_spe: Fix consistency of SYS_PMSCR_EL1.CX

The arm_spe_pmu driver will enable SYS_PMSCR_EL1.CX in order to add CONTEXT=
 packets into the traces, if the owner of the perf event runs with required=
 capabilities i.e CAP_PERFMON or CAP_SYS_ADMIN via perfmon_capable() helper=
.

The value of this bit is computed in the arm_spe_event_to_pmscr() function =
but the check for capabilities happens in the pmu event init callback i.e a=
rm_spe_pmu_event_init(). This suggests that the value of the CX bit should =
remain consistent for the duration of the perf session.

However, the function arm_spe_event_to_pmscr() may be called later during t=
he event start callback i.e arm_spe_pmu_start() when the "current" process =
is not the owner of the perf session, hence the CX bit setting is currently=
 not consistent.

One way to fix this, is by caching the required value of the CX bit during =
the initialization of the PMU event, so that it remains consistent for the =
duration of the session. It uses currently unused 'event->hw.flags' element=
 to cache perfmon_capable() value, which can be referred during event start=
 callback to compute SYS_PMSCR_EL1.CX. This ensures consistent availability=
 of context packets in the trace as per event owner capabilities.

Cc: Will Deacon <will@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
---
This applies on v5.19-rc6 and built on an earlier version posted by German =
https://lore.kernel.org/all/20220117124432.3119132-1-german.gomez@arm.com/

 drivers/perf/arm_spe_pmu.c | 25 +++++++++++++++++++++++--
 1 file changed, 23 insertions(+), 2 deletions(-)

diff --git a/drivers/perf/arm_spe_pmu.c b/drivers/perf/arm_spe_pmu.c index =
db670b265897..011e98428233 100644
--- a/drivers/perf/arm_spe_pmu.c
+++ b/drivers/perf/arm_spe_pmu.c
@@ -39,6 +39,26 @@
 #include <asm/mmu.h>
 #include <asm/sysreg.h>
=20
+/*
+ * event.hw.flags remain unused for events created for this
+ * PMU driver. A single bit there i.e BIT(0), could be used
+ * to remember initiating process's perfmon_capable() value
+ * which can be subsequently used to enable SYS_PMSCR_EL.CX
+ * thus enabling context information in the trace.
+ */
+#define SPE_PMU_HW_FLAGS_CX			BIT(0)
+
+static void event_hw_flags_set_cx(struct perf_event *event) {
+	if (perfmon_capable())
+		event->hw.flags |=3D SPE_PMU_HW_FLAGS_CX; }
+
+static bool event_hw_flags_has_cx(struct perf_event *event) {
+	return !!(event->hw.flags & SPE_PMU_HW_FLAGS_CX); }
+
 #define ARM_SPE_BUF_PAD_BYTE			0
=20
 struct arm_spe_pmu_buf {
@@ -272,7 +292,7 @@ static u64 arm_spe_event_to_pmscr(struct perf_event *ev=
ent)
 	if (!attr->exclude_kernel)
 		reg |=3D BIT(SYS_PMSCR_EL1_E1SPE_SHIFT);
=20
-	if (IS_ENABLED(CONFIG_PID_IN_CONTEXTIDR) && perfmon_capable())
+	if (IS_ENABLED(CONFIG_PID_IN_CONTEXTIDR) &&=20
+event_hw_flags_has_cx(event))
 		reg |=3D BIT(SYS_PMSCR_EL1_CX_SHIFT);
=20
 	return reg;
@@ -710,7 +730,8 @@ static int arm_spe_pmu_event_init(struct perf_event *ev=
ent)
 		return -EOPNOTSUPP;
=20
 	reg =3D arm_spe_event_to_pmscr(event);
-	if (!perfmon_capable() &&
+	event_hw_flags_set_cx(event);
+	if (!event_hw_flags_has_cx(event) &&
 	    (reg & (BIT(SYS_PMSCR_EL1_PA_SHIFT) |
 		    BIT(SYS_PMSCR_EL1_CX_SHIFT) |
 		    BIT(SYS_PMSCR_EL1_PCT_SHIFT))))
--
2.25.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
