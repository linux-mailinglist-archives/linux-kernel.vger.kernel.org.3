Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B33004D9602
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Mar 2022 09:16:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345800AbiCOIRr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Mar 2022 04:17:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345802AbiCOIRp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Mar 2022 04:17:45 -0400
Received: from esa12.fujitsucc.c3s2.iphmx.com (esa12.fujitsucc.c3s2.iphmx.com [216.71.156.125])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 960F14BFD7
        for <linux-kernel@vger.kernel.org>; Tue, 15 Mar 2022 01:16:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1647332194; x=1678868194;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=F6SzdgWeTeGJ2VBIM9Ae87r6J2RLvElXpx2w7vXCGYI=;
  b=vuS5YGY92WlN81NCnOfDG/b5xwsYUinUDE5sms5Nhoe3kNXO0BvPnRtp
   vPNhQQY85fx8prjMPvUOMjCjuG0XugB3hzRnBNVGZYnaGRQIa+iicEKwj
   QWw3m6z4AVXiL3tE79nspQpnHxQsYBVxOimFJFCESNIHR3PdPRs09vXrP
   r5ApZPdJZ22vPXa638PekKT2XhCOI+t27GOFPr8fbHzVp7FTAh4y0flJO
   VgtPWn1XcbFBS+SFJEn9gw/0dJWstPqwFpbwg18xXUZrdke771IRrDddJ
   WT8WNUBTS8icRuMq8OchOS3yLQUT0TgsTFGCZ6ZQs3iH1sa3QOdp9xX84
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10286"; a="51918367"
X-IronPort-AV: E=Sophos;i="5.90,182,1643641200"; 
   d="scan'208";a="51918367"
Received: from mail-tycjpn01lp2171.outbound.protection.outlook.com (HELO JPN01-TYC-obe.outbound.protection.outlook.com) ([104.47.23.171])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Mar 2022 17:16:28 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jd+L0PNP/joWCWLIbkKKal6MtcAQdzeaDKYr/0xkNQxngthqzvwP796DCjaYGFs+Nn5xj16e6DA5q1SitwBVa1MaXOnFe/8qoJB19pn0cOCw+k62gctbagDragFEgQSmpTffOrq70Rx+TD2tUHmKpiEEbOwRJesVe/BWZ1ItjY3UsfHnCvz8PRjbiP3i4XSjtycXo1+eJ3RXvsYKs52E9kQmtyphYE6+dALD1FFLBYu5MSaZDiNxPjKf8mc1z1cCmS0//8i0j+BrrjxYYbybHKlot5IPeC/JWJ8Vyv05mwBcpDsI8df6LO0V3JvtZwDO0vDEnAUzXCL6/Ol54fSx1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pvWJnt/OxafZBgK+JH/POG70gSdLbf0ZaR0J0rJpX2o=;
 b=N/hRKc86lGZ10BCnpMMM6HuzyaNeZO51bdGaT5Fo7jdTiSpltNEdwAoNwhx5cv9X2rFT0/W13CYmVI2ieiUA2rXU5vjdtaNZEHZ6I8ZZxVBfr6v8TMyllIeySpHEjsmINx5VX0PpUtAZSkmBbz8bJDoa2RqTBYsvlzJdIxezkBw5GZmtvuhvhf4Ni84zUSZVMmX+0Pd9CyjLuydWsKIhYrelShxlnYZdDJkc//Y/9XdNZVAzzQ1q2XBrBTE4cewWmCTzg9kHBqpA5VbrPqWb9mdfeH9cyXq+JQi4ataWbBHSl3h+iFuloqFAZ+4O9ULqd3lkno0kf9kiPC7Eo6275g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fujitsu.onmicrosoft.com; s=selector2-fujitsu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pvWJnt/OxafZBgK+JH/POG70gSdLbf0ZaR0J0rJpX2o=;
 b=oBdUsV+HEhJ3Q+vEQywRBY4AYsSzcSzynXnt+lU2PYiNtDqsEEWgt24K7pZqR1IkYg0K3yTOtV81VwtmQeW+UJHOtjlIylNnuIOpybcBEaw+hLdv/5EZAGbfTBW7pIVsKdj/zeg+wvulaj9V5COQWntMKayk9Yjs4GkGAGrkUYE=
Received: from TYAPR01MB6330.jpnprd01.prod.outlook.com (2603:1096:402:3e::12)
 by OS0PR01MB5860.jpnprd01.prod.outlook.com (2603:1096:604:bc::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5061.26; Tue, 15 Mar
 2022 08:16:23 +0000
Received: from TYAPR01MB6330.jpnprd01.prod.outlook.com
 ([fe80::a0bc:5f46:d925:2d8b]) by TYAPR01MB6330.jpnprd01.prod.outlook.com
 ([fe80::a0bc:5f46:d925:2d8b%5]) with mapi id 15.20.5061.028; Tue, 15 Mar 2022
 08:16:23 +0000
From:   "tan.shaopeng@fujitsu.com" <tan.shaopeng@fujitsu.com>
To:     'James Morse' <james.morse@arm.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Fenghua Yu <fenghua.yu@intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        H Peter Anvin <hpa@zytor.com>,
        Babu Moger <Babu.Moger@amd.com>,
        "shameerali.kolothum.thodi@huawei.com" 
        <shameerali.kolothum.thodi@huawei.com>,
        Jamie Iles <jamie@nuviainc.com>,
        D Scott Phillips OS <scott@os.amperecomputing.com>,
        "lcherian@marvell.com" <lcherian@marvell.com>,
        "bobo.shaobowang@huawei.com" <bobo.shaobowang@huawei.com>
Subject: RE: [PATCH v3 00/21] x86/resctrl: Make resctrl_arch_rmid_read()
 return values in bytes
Thread-Topic: [PATCH v3 00/21] x86/resctrl: Make resctrl_arch_rmid_read()
 return values in bytes
Thread-Index: AQHYJCtY+VN679+cZkeDd1+2G02/r6zAQPcw
Date:   Tue, 15 Mar 2022 08:16:22 +0000
Message-ID: <TYAPR01MB633065F1A136E518E518DB198B109@TYAPR01MB6330.jpnprd01.prod.outlook.com>
References: <20220217182110.7176-1-james.morse@arm.com>
In-Reply-To: <20220217182110.7176-1-james.morse@arm.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_Enabled=true;
 MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_SetDate=2022-03-15T08:14:13Z;
 MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_Method=Standard;
 MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_Name=FUJITSU-RESTRICTED?;
 MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_SiteId=a19f121d-81e1-4858-a9d8-736e267fd4c7;
 MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_ActionId=a9fa9a2f-2772-4648-9d54-194006f26bde;
 MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_ContentBits=0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 472dc817-7c79-4e8f-0e53-08da065c17e4
x-ms-traffictypediagnostic: OS0PR01MB5860:EE_
x-microsoft-antispam-prvs: <OS0PR01MB5860F329DF7F6A9D3A3B1A838B109@OS0PR01MB5860.jpnprd01.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ryc/1AElZaz0nvMPktUhBfNRqYqhewAUzGFSvRF/0Y6zpZEADYmfwyoX4/W17+htv8lGSbuNlfMTB3A6VR/T3v5MMsbCPzFCrxtBBv5VJwQ993a6fzKJJPt4zC6bbVoqYWMBUsato9XmvcVW+OYT23/9X7s8kmfpazsXr8CjD3oAGEYAi2PA5Hmsjm5N6S5gE2XqKRO2kftPCHNdNOi7cWZqb3hvMyTJSTD7GeMWtHObbxHctP1abMM4Bf/HTI2odmesaH41EDKb8I1p9WPCrQAF5xTOG79yIOrloduCU0Y26SM8CpRCIPauIK23a5vfwoBdk+qS64dDEqeN7JmPATZX70ILycQfGk4j/GBH3aTb1/CQVmXyVxIRDQQqVUhk7z+2E9sEdq8z7rXHFXO/daLcO+DamO8gbDRrdVbTg3mmRbLiSvddBOQOOLRKJcnMW6ZnuAMdQPrjuGCr3r1tJ/DPkujUJfCHLjd8b9C7vY/e7yVFEc/jcDOR1x412IuIiCUSR/aIpGeYhy0c4c7V7uQlL909tK5osMdWdV19dgkA96/yngn4OE4iaT7AhX/oqtx00ktvCk7TGo8UnYy3WJpBOchLdXwlUQNW6X/Skqee+TSsFIjXM8DQdxmCC1IO5t61gRhEyrOGbRGT6X6a7RO9UfWsALEfwFniGyS67W1mdEAcPQOqfzoOzaR1FIUcUFEwebFwNivPyqIlKa+qNro1tMbkhKl8A4WQS75+aGHtHcV+8nU91jcfViaZynyc/sEFLtJB170aWVEC1ZCaVsTw3t+W8pY7SUQQo8ITg+uK/PgrULz7JHf/e7yyNMA4o+dt0AI/L5Ji9TKWNtItJQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYAPR01MB6330.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(82960400001)(122000001)(38100700002)(508600001)(55016003)(38070700005)(8936002)(86362001)(966005)(52536014)(7416002)(5660300002)(4326008)(54906003)(33656002)(71200400001)(110136005)(316002)(76116006)(66946007)(64756008)(66446008)(66476007)(8676002)(66556008)(26005)(186003)(85182001)(83380400001)(7696005)(2906002)(6506007)(9686003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-2022-jp?B?YWFkMmNnV0lKbGVCZnJ5ekZYdWdxZW40STVtVzVvdTFsWWRpV0RvdWlU?=
 =?iso-2022-jp?B?bGRqSUYxbGtQUGFhVkg4SmNybU9TTlQyM3BXN01veWdsZmRPejV5Smlk?=
 =?iso-2022-jp?B?V2hKMDNHQjU2L3l5djdhWmhYUG15VEtESXBLUU82eERYNTR6d0pzQ25v?=
 =?iso-2022-jp?B?Um5SaHRIUWVSQzYwcEpBcThhZmI5NUZoTmZmNjBwZEp3MUxtb3V0Ykx1?=
 =?iso-2022-jp?B?V2JRU1QyZ05KMnByUmVKSUNPWnNQOFYybnlvQ2xLYjlwMVAybVdUNmFy?=
 =?iso-2022-jp?B?eU5zbE5iblBCMXRjbForcHB1UnlvLzB1RUdqNm51NWJJQUhtM0xSYjB0?=
 =?iso-2022-jp?B?SnUyMVFrS25QcEk0TUhtWUNseTZUOWhnckxOK2czTjQ4SjZRaGJIZ2Fy?=
 =?iso-2022-jp?B?ZUk4MmxNcnpMVHpXNmVaUmpuaXphdHV2ZGxiS3l1dVRWd1NScUxrR3pL?=
 =?iso-2022-jp?B?N2d6TzNQNzR1Rlh3SHdZTFZJU25BRERuZGJWa3U3UlFrS2tVcGtWcWd5?=
 =?iso-2022-jp?B?UHNhMWhNT0dqNnRHQ3R2em1PbzQyc3NPRk1nbktqSW9sQmJPZ3pZb1BY?=
 =?iso-2022-jp?B?UmhtSWxybUVGbmRlVnI2Z2JrZXVHdHhrQmpzZFhyRWtxZXBNZlQvWTkw?=
 =?iso-2022-jp?B?UVJVY3orNUFIU01ENFRoUHp5OG1uTzU4d2tRZlM0bFB0aW9NT0JhY3Rj?=
 =?iso-2022-jp?B?SWtPd2Y5blhzcjBjUWo2d3RTKzM3VFpEeHd6dG0xY1pMNlZ3TFdvSlVi?=
 =?iso-2022-jp?B?NmF4Y1lkeDA2U0F6ci9teXBIdE55S1puRURMV1hLV0ZIY2NVM3FwTmxJ?=
 =?iso-2022-jp?B?S0FiWVdwNkErb2QwNTFUQUlJcXBGck9UT3hySGFBSkkwUko3ZnNWNnNw?=
 =?iso-2022-jp?B?TVFBUDE0eUlydFhPRVYrZWJuN3FXQjFxVWFvRFNHQ3FyYVFIRFVKNlBZ?=
 =?iso-2022-jp?B?VnJHaUhwLzhLTUU3S1JtTWp0TEcwYWk2cjVTSVh3V2ptRjJNRERBRU5v?=
 =?iso-2022-jp?B?NHVIVUZ2bDRRUVZBZlBFbzdYa0lrckFwaVNIOWhRUDBQRHVZaHZvbjlC?=
 =?iso-2022-jp?B?d29GVU03MklxWGVQL1FDa0xwUUo1QnRGVjFGbVZKZmdlc3AyN2JaSk8v?=
 =?iso-2022-jp?B?b2x0dmdvWktxa2tQWkR2dFBNQXBEZUJDdVVUZHJiOWp1dEpYS3h4OWpm?=
 =?iso-2022-jp?B?WDJQQnlSaWZjMC8waDB3SCtWK04vUXpXYnpNWXlmekxuS3dhOXNsSHNu?=
 =?iso-2022-jp?B?ajNsNjhkZXh2WEtSYkYzdGZVRGgwMjBPbGJPRlFuZHRQcmxITFVXdW9a?=
 =?iso-2022-jp?B?d0dlWXZYc0VPUnB4QnFGRFV3TVhsVUlIR3pXY3BRU3FlMTB5Q1FIbXNp?=
 =?iso-2022-jp?B?Q2NDblBvcWM1ZXVmQS9zWFg2YVNNZWhNTkQ2N2drWW5XUkZ4VnRoZDZD?=
 =?iso-2022-jp?B?QmpsWFN0eFVveDMyRWxTcGZBMkNXQlNrZFg4UytlZy9mMkV3Q3VaeWcr?=
 =?iso-2022-jp?B?T3kvZ01EL25PME1YME9ua2xpTEpZcGpIOXhWblAyakFsNWhCcm11a1hO?=
 =?iso-2022-jp?B?enM1UzRtd0RubjM1OTRRSDNjNnhMbElZVFRzTWxiVmU5ZjMyRWRJQTk5?=
 =?iso-2022-jp?B?OTViY2kyNmtDYTMrZnJraEFPaUJ3dlI5VW5lMCtPdnVZVVZxeEM4NnVz?=
 =?iso-2022-jp?B?RjBqZU9yMkxvOWFmK0pYZGc1eE1uUDlnSzBjZVlCelJNOFp2a1BJQ2NM?=
 =?iso-2022-jp?B?cTJZb0Q0TWY0eGlxVW40eFR5YnlRUW9RbWI5bFo1d1hhdWRVVnlVbHp0?=
 =?iso-2022-jp?B?OVJPN2hHdU1WQmdyMkhxY0RDWDJzdks5U0RFZ1BPN2dpdWRhN1UyQXRl?=
 =?iso-2022-jp?B?V0c5SFdHdDNESjVld29JRDcvL2p6am5uaExFbjZlcHJPMTNZSmpsdWYy?=
 =?iso-2022-jp?B?NDJnSXlZdWVLWnpnV0JWQnJnK3ZYNlluQUhSYnl3TFc5ZnQrSm1ZY1ZG?=
 =?iso-2022-jp?B?Yzg4alhqVFIyMXdLVjZZVlk2SkJwSnhkVzlRb0NqTm1JZFBSUDBONXky?=
 =?iso-2022-jp?B?cmQ5Vlo2dkhPMTA4OWFpUWVFVXBLaUx3emlsOGt0WnliVVE0VG5RNDFy?=
 =?iso-2022-jp?B?VldlV2lkckU2aFlqRzlxM3Z2dDVHOFFnPT0=?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYAPR01MB6330.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 472dc817-7c79-4e8f-0e53-08da065c17e4
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Mar 2022 08:16:23.0801
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GXo1qMgbOT9sCLE979cX45xehBwWp1Gp/eS9kFnnSWFp1Pl1emv9wmLlLzlySBi3+KXhc8F/auGJ01HIahwvV6DrbMLXP+dWpLCr+UqzRYQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS0PR01MB5860
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi James,

> Changes in this version? Expanded the commit message of patch 12, and mad=
e
> a few things static, as reported by the kbuild robot.
>=20
> ---
> The aim of this series is to insert a split between the parts of the moni=
tor code
> that the architecture must implement, and those that are part of the resc=
trl
> filesystem. The eventual aim is to move all filesystem parts out to live =
in
> /fs/resctrl, so that resctrl can be wired up for MPAM.
>=20
> What's MPAM? See the cover letter of a previous series. [1]
>=20
> The series adds domain online/offline callbacks to allow the filesystem t=
o
> manage some of its structures itself, then moves all the 'mba_sc' behavio=
ur to
> be part of the filesystem.
> This means another architecture doesn't need to provide an mbps_val array=
.
> As its all software, the resctrl filesystem should be able to do this wit=
hout any
> help from the architecture code.
>=20
> Finally __rmid_read() is refactored to be the API call that the architect=
ure
> provides to read a counter value. All the hardware specific overflow dete=
ction,
> scaling and value correction should occur behind this helper.
>=20
>=20
> This series is based on v5.17-rc1, and can be retrieved from:
> git://git.kernel.org/pub/scm/linux/kernel/git/morse/linux.git
> mpam/resctrl_monitors_in_bytes/v3
>=20
> [0] git://git.kernel.org/pub/scm/linux/kernel/git/morse/linux.git
> mpam/resctrl_merge_cdp/v7 [1]
> https://lore.kernel.org/lkml/20210728170637.25610-1-james.morse@arm.com
> /
>=20
> [v1]
> https://lore.kernel.org/lkml/20210729223610.29373-1-james.morse@arm.com
> /
> [v2]
> https://lore.kernel.org/lkml/20211001160302.31189-1-james.morse@arm.com
> /
>=20
> Thanks,
>=20
> James Morse (21):
>   x86/resctrl: Kill off alloc_enabled
>   x86/resctrl: Merge mon_capable and mon_enabled
>   x86/resctrl: Add domain online callback for resctrl work
>   x86/resctrl: Group struct rdt_hw_domain cleanup
>   x86/resctrl: Add domain offline callback for resctrl work
>   x86/resctrl: Remove set_mba_sc()s control array re-initialisation
>   x86/resctrl: Create mba_sc configuration in the rdt_domain
>   x86/resctrl: Switch over to the resctrl mbps_val list
>   x86/resctrl: Remove architecture copy of mbps_val
>   x86/resctrl: Abstract and use supports_mba_mbps()
>   x86/resctrl: Allow update_mba_bw() to update controls directly
>   x86/resctrl: Calculate bandwidth from the previous __mon_event_count()
>     chunks
>   x86/recstrl: Add per-rmid arch private storage for overflow and chunks
>   x86/recstrl: Allow per-rmid arch private storage to be reset
>   x86/resctrl: Abstract __rmid_read()
>   x86/resctrl: Pass the required parameters into
>     resctrl_arch_rmid_read()
>   x86/resctrl: Move mbm_overflow_count() into resctrl_arch_rmid_read()
>   x86/resctrl: Move get_corrected_mbm_count() into
>     resctrl_arch_rmid_read()
>   x86/resctrl: Rename and change the units of resctrl_cqm_threshold
>   x86/resctrl: Add resctrl_rmid_realloc_limit to abstract x86's
>     boot_cpu_data
>   x86/resctrl: Make resctrl_arch_rmid_read() return values in bytes
>=20
>  arch/x86/kernel/cpu/resctrl/core.c        | 117 ++++--------
>  arch/x86/kernel/cpu/resctrl/ctrlmondata.c |  75 +++++---
>  arch/x86/kernel/cpu/resctrl/internal.h    |  61 +++----
>  arch/x86/kernel/cpu/resctrl/monitor.c     | 211
> ++++++++++++++--------
>  arch/x86/kernel/cpu/resctrl/pseudo_lock.c |   2 +-
>  arch/x86/kernel/cpu/resctrl/rdtgroup.c    | 205
> +++++++++++++++++----
>  include/linux/resctrl.h                   |  62 ++++++-
>  7 files changed, 478 insertions(+), 255 deletions(-)
>=20
> --
> 2.30.2

I tested this patch series on Intel(R) Xeon(R) Gold 6254 CPU with resctrl s=
elftest.
It is no problem.

Reviewed-by: Shaopeng Tan <tan.shaopeng@fujitsu.com>
Tested-by: Shaopeng Tan <tan.shaopeng@fujitsu.com>

