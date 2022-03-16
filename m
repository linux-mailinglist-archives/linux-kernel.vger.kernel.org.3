Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EEE754DB02F
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Mar 2022 13:57:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355944AbiCPM6c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Mar 2022 08:58:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240134AbiCPM6b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Mar 2022 08:58:31 -0400
X-Greylist: delayed 63 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 16 Mar 2022 05:57:16 PDT
Received: from esa14.fujitsucc.c3s2.iphmx.com (esa14.fujitsucc.c3s2.iphmx.com [68.232.156.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F7A862A24
        for <linux-kernel@vger.kernel.org>; Wed, 16 Mar 2022 05:57:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1647435437; x=1678971437;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=ASCEP8DE9ofrrkazeNQHzvMxI5RxfpJKkirdgRtrNaU=;
  b=ZMs0/rTi+q6XSthNQqLUHHZUbiwOsO3jbMeWsOD4PmbB98PoaphBRtAx
   j40wVEkirZGseF27XcQU4agwgrfdIgCLh+tz5vPEKXJsFj3OCKtdcpBje
   C8xsVjK+8FyFRCE1Uazw15LtIeiAydfPTEbrm53PPDs0b5KLWufezGman
   I2i8Dr+FKdIJVD5zcaqUQnzRPr/8Lnm84PgjKfgmA/5+J1meYPNttdfg4
   EHTpu18zutQuh/Hj0hwvliKoN3xj9tVzKHV3yTAsVRjMlEDpA5r0di9IY
   Uj73A1XRB2p8iDfQcZu1Rv8GwzkW18gHmnIZnO2guOjXRHknddZP+BnTZ
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10286"; a="51712752"
X-IronPort-AV: E=Sophos;i="5.90,186,1643641200"; 
   d="scan'208";a="51712752"
Received: from mail-tycjpn01lp2169.outbound.protection.outlook.com (HELO JPN01-TYC-obe.outbound.protection.outlook.com) ([104.47.23.169])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2022 21:56:07 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BIrj6DO036h04kijm7ILHe1OtmVsL0R/3itGQ0iO7Jopishw1Bs9U6J8eOKX0FGebVg/f/GPphcmEhQXqxIlS9DXfcQTxirAwCJl2qXKTEJn1ohBdYCw28CPorSOLjOFm1Sb9d050nZO6b5B1EkQMsI8ZMrX4O9W7tXptZiN8lMcnBlk1sUE1l1meTgewFlt4uIXKOW7daDr4quX8KI7j94BdpuvA392GWBBLVsigSufihHh7Xgy/GZH2KJ88cnbyoNGnCi4u/Q8XnLMVTUOMxmgUQs/uoYawpor+jh5jXGmMueGm0sWf8mRSSO9GplnYncze+44jgXcJOtmO7ZESg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3BUbGlK4kBdgdnMVdmHDwzI4ZLBkI7z52okWownpUSM=;
 b=mWgC633Q8RPZ9n5qaRpurIAajTYB6EnmRmLRRAgrV0chU7YwxzfD4KgUlmORxbzUeoGtYiFm5f/XCKHh02MDgCto1onRW0RAQGw1tsEbOc8Qb94lZZP/ePIRg3vQkt61tlEMnGbfMf2YcBulTDYiALFJvkttmqK/R2vpK8fURfm9giUpAOEPJDTQ1aCj7Z9uk9s1l0LcuaAerfcd++51Sx3vJO7RwrXxnskeOq3JRWGo3OkvN/mWU8wdLdFvLvOSOx3OXUNqBY7/xFWTUcjHKs7iwb+pMq4LtAvOehSaQ/qm51inhpCaGCFeX8w1qWneA/HLuzMCOT8ZqBuE+ijujA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fujitsu.onmicrosoft.com; s=selector2-fujitsu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3BUbGlK4kBdgdnMVdmHDwzI4ZLBkI7z52okWownpUSM=;
 b=QH9HsjCEmE7LL540wIOHyy8HlmxNZUsYqgX4LJDw5Qmuozk8Mm1jCAYHO/PNPoLba+QAx3/vhFqJzD4On0wLYIxE8HH1+6gNohOmqxwvgHYeblJzPxCJdTtVXtrNPRDO3yeGquwb77NoB6xDwTZxxrBdB92bK4GGvLEu+/zzZY0=
Received: from OSBPR01MB2037.jpnprd01.prod.outlook.com (2603:1096:603:25::17)
 by TY2PR01MB3001.jpnprd01.prod.outlook.com (2603:1096:404:75::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5061.22; Wed, 16 Mar
 2022 12:56:02 +0000
Received: from OSBPR01MB2037.jpnprd01.prod.outlook.com
 ([fe80::885a:78d2:af39:629f]) by OSBPR01MB2037.jpnprd01.prod.outlook.com
 ([fe80::885a:78d2:af39:629f%4]) with mapi id 15.20.5081.014; Wed, 16 Mar 2022
 12:56:02 +0000
From:   "tarumizu.kohei@fujitsu.com" <tarumizu.kohei@fujitsu.com>
To:     'Jonathan Cameron' <Jonathan.Cameron@Huawei.com>
CC:     "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "will@kernel.org" <will@kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "bp@alien8.de" <bp@alien8.de>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "x86@kernel.org" <x86@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2 8/8] docs: ABI: Add sysfs documentation interface of
 hardware prefetch control driver
Thread-Topic: [PATCH v2 8/8] docs: ABI: Add sysfs documentation interface of
 hardware prefetch control driver
Thread-Index: AQHYNTHOMCQHTgw9FkykgSh5SDmtXqy/GdyAgALO5PA=
Date:   Wed, 16 Mar 2022 12:56:02 +0000
Message-ID: <OSBPR01MB203705485512925382FD3E1680119@OSBPR01MB2037.jpnprd01.prod.outlook.com>
References: <20220311101940.3403607-1-tarumizu.kohei@fujitsu.com>
        <20220311101940.3403607-9-tarumizu.kohei@fujitsu.com>
 <20220314163951.00002500@Huawei.com>
In-Reply-To: <20220314163951.00002500@Huawei.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7c22e1c4-ce6a-4b65-0fdf-08da074c53ae
x-ms-traffictypediagnostic: TY2PR01MB3001:EE_
x-microsoft-antispam-prvs: <TY2PR01MB30018984176316AE9768053280119@TY2PR01MB3001.jpnprd01.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: BCX5oiJKntRBUNBJFyRrbamjJVeQpScOIr7W5p1j3BGesRZ+PgPa0Kri7siKudc//veOFWI4hAh6sZt9H3ZDiZ/xB/BKtkpj4jFxR7NfKDvyIY0e/5jOMaI2UWttEPeBrv6uOJRdCTZPao/NPw/sN8XvLvzCAvzSXs+SHRZH+FP/qeVXiuDxbbCDjoNkGOxsvvnEQEQnANE0PAGYLiWul8r14Ld7n9VwlbRGcRJ9ingwRoPhq7SAJuTOlDUjxYuuiVCiShc22UiYvnZbqqjNqOwAkScuCLN009JDUREcwPNgblta5y+G0M1NdGWhfMZgVZflIjvPv5ye3iOFg5VEHr7rK5/kyDTqYB61LX114PeqHKx+W/XZBxG4l0zA7GvbST0ozFu8+e0AiE9nCVb/1tH21ft6+QQpOSm8INI1dlcq0J23wmv6C8V9kc+aClLQCX8zO5QgBqVahcc2xLVVsdAWqoxu8vQ5RU+T6RWOTqlviE3dpat7YUMZxiJbc3KH3SRMsf+/QGjrAhotg2/qYPVKw3/Ha7LaVBC5SQs+AUnMugVjXxT1jf5dTfMK2CUfy19v/b98sifolLwjBBtsJxKwRh3Pw4xtnt7OPtj6pXkxTw4c/mFTh54jYA1BRdMRYNwCM0gNJ13Q3NuFos8XE5DA8L0U7v7Ad1pqchNMrq92R0lX0d2q0ax1xX9YmAPQIh9bIFKDmJgGBZzaT2GR21EuYeaSqen4+jTsH2Af0efcsOUqkrYte3853l+t1jifdkhNV7yqtUbLm3ix9QMg8gy628Sy51Y2p/r8F7CGXVw=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSBPR01MB2037.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(86362001)(6916009)(9686003)(6506007)(7696005)(71200400001)(316002)(66476007)(66946007)(4326008)(64756008)(76116006)(54906003)(66556008)(66446008)(508600001)(8676002)(38100700002)(122000001)(82960400001)(966005)(8936002)(38070700005)(83380400001)(186003)(26005)(7416002)(85182001)(2906002)(5660300002)(52536014)(55016003)(33656002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-2022-jp?B?S0ZXYXEzNXBwK0sySE5GVE5pdUhuQWFNQkptSmlwclVtVW90enBFaWhz?=
 =?iso-2022-jp?B?MmRITFZtWW1CRDhFT3pPR2cyWHdtaVR4QTE5YnZmZ0EyTEVRVDZwdkx0?=
 =?iso-2022-jp?B?RmIzNkFRY0hPbUNwWE5HZ1E0QTQvd3BVaWU4Ni9YQTkra2tOeVNDOGpn?=
 =?iso-2022-jp?B?R0ZKaTc1c3RTNFBxY0I2cnMzdHZENWptbC9VM1hvRkxVOWc5a0g1MzNx?=
 =?iso-2022-jp?B?VElYUmFORGk4YnFCcHNvRXJHQ3JlRmxVd0NhTldqc2NDVWJuWTczRktX?=
 =?iso-2022-jp?B?djBQWGNVM2xYSDhwaEpHWUcwUXBIWXNqVnd3MEZCeldWWlJtWWNRV0Fs?=
 =?iso-2022-jp?B?TktSQVl2ZkdGYkhaQ3dldDhGeGVjdjFiN3lkdExkd3V4ejBxL2N2V1hi?=
 =?iso-2022-jp?B?NVh4UGQ3dkJPTUtVMS9iRGFuODMwcFBFa0UwZ1RqUWdoRzdlSW9ZdjUx?=
 =?iso-2022-jp?B?MUQxU01YZmVsNUR4THlPa3M0NU85SDBEeFVWenNkYU5FTnUrU1d4dkpn?=
 =?iso-2022-jp?B?cFYvSWNkaS9DbTBGM1lBYXFCZGtweWZzQlJkTDJvNlY4dy8yWEV5dHh3?=
 =?iso-2022-jp?B?bDVRUnZzbTV6QXZ4T0FPWFNBS3VNVlMzcnp2RkxCb1FZbnlkcHA5ZjM2?=
 =?iso-2022-jp?B?YjZLUEw2eDMrdnEzN04rTmJIV3hwOU82ZFdNbW9XQVhsY0NwL2FiNUZp?=
 =?iso-2022-jp?B?NUYzaVg3NXk5WkNpOUVMZEc1S2dzdVFZMmpGR2c4M1VBODhRQytMZ25G?=
 =?iso-2022-jp?B?aU5PMWxJb2xWYnJRRXdlcVJmRDAzbzk3SGtncFlLWWVuT2FSZXpKRGtD?=
 =?iso-2022-jp?B?Rzl3UXY1S2JBc2RFbHZURFhhenF3REVxUDZwemxNQ0pzT2hDWm5JY290?=
 =?iso-2022-jp?B?L3dTY3VCZTgzbGo5aXEvVnlPSm5YRUQ1NVJGak9OdkNxOWlHK2tZSCtD?=
 =?iso-2022-jp?B?VDNNVzZPUFNMdytjZDQxZHhCeXN3R1krdVAyanJkUjYwZy93SFNFREhO?=
 =?iso-2022-jp?B?OWNZeDRlOEw5eDRZalZ6bzVUMjBLdFBtMWVNam9yUk9TNzJVeTBqMExE?=
 =?iso-2022-jp?B?dVNORmc5YVFmeWdHbm9LMVdJbE5TNC9vT1VHTnF3SE9OVXV1c3ZseWVO?=
 =?iso-2022-jp?B?YXk0Y3JBc1pwblRSZURWTDJQM2dpZTdtNjJDYjFpMTRXa3d5bC8waTlF?=
 =?iso-2022-jp?B?eEhVVHBlc2ZieDVMRFMzMnB3UC9pUXExUGVqdDhuQ01NSStWVEpydjNI?=
 =?iso-2022-jp?B?c2JJTThtaEdBL1U5dDkyOHZVNjhPQ05QS0UvNUIwZU51Vk9zVzJrT2FK?=
 =?iso-2022-jp?B?SGpkYUxlMExocDdVRjcyRHR4RnlZWGRFUVZsT1FabEtsZEdtVHFQV0tW?=
 =?iso-2022-jp?B?VXlUNkFMWUxOeUZFM1NaUndjSHVYT2ZFUUI0MVhpTHZkZm1qQm5KeXJn?=
 =?iso-2022-jp?B?ZFJtb0lzemM0V1g0c1RoK1hBMkJXTHJWZ29TSmt6KysyUDBKLzBTdVRm?=
 =?iso-2022-jp?B?T1NJTG8yU2FQQWp4cWJJM2pyREFldGhIaFBiUVN3bjhMUnlNNTl2Ymlz?=
 =?iso-2022-jp?B?ZXpvOUR0ckNkNERTTjA2L1pFQzdGREdkb0RXNjJNc1FRWmN0UmVUait6?=
 =?iso-2022-jp?B?bStFRGxrVnh6WnovT0RsSGtzNjJhbjhyK0EwSVFsdk5WUmVHUkcwd3p0?=
 =?iso-2022-jp?B?UFY1RjZJWHlaYVV0N1dzK0FKd2RrUHJLazJCSEU0ZDRuQVpzRGxpR3lq?=
 =?iso-2022-jp?B?SDlJcjRBRzVGclpSaG5IL1NMU2g3RGpRR01hWHorVy8wYTRkZFdRZ3lK?=
 =?iso-2022-jp?B?eit4RlhxYTdHcHpqTHZQNFVwL1NUaVh6QzhOWW9kUnVvOEhDNUFFOWFT?=
 =?iso-2022-jp?B?MEt2M2lOWCtBTWc0S2QyMHBWaXVvdWNSd0tCRmdBd0ZpVzROSCtmZEVK?=
 =?iso-2022-jp?B?L0ZiRldKNSsvSzlENTB4QTgzVDJxMlpOZklxWUhXRzdzUkI1TFNNcUJk?=
 =?iso-2022-jp?B?MklwTXU4elBoeVJReTVvd29LcU1BeFNCTXRxU1dQdWlPMEp4SVRFYVNw?=
 =?iso-2022-jp?B?dUdwWWZvRklYd1BuYW5OZURmcHFvejR5U1hJQ0JJMjVkUlN2cEkyMi85?=
 =?iso-2022-jp?B?Uy8zVXRqNEFQZ01YZFp3NkxRMUtjbGJnPT0=?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSBPR01MB2037.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c22e1c4-ce6a-4b65-0fdf-08da074c53ae
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Mar 2022 12:56:02.8077
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: g/X/uaRUIGEZ8QF5+A6zdn1OJuCHbp4VCklxFsmb4FjXvV/ObKA2eBDGsG33XxBZ3uIzNQLWkdrhaAcG+Oo4fU1A0iaNMrR/SeWXF0MBg9w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY2PR01MB3001
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> H
> i,
>=20
> I'm going to review this with only a fairly basic knowledge of prefetcher=
s and with
> no particular design in mind (though I'll point at ARM docs because they =
are
> generally good and easy to find ;) Key thing on an ABI like this is to ma=
intain
> flexibility for other implementations.
>=20
> It makes me a bit nervous to see an interface for something like this bei=
ng defined
> with only a couple of implementations.  There are others with public
> documentation such as the ARM N2.
>=20
> https://developer.arm.com/documentation/102099/0000/The-Neoverse-N2--co
> re
>=20
> As is clear from below, not a lot of this is shared between CPUs so far s=
o it might
> make more sense to document them separately?

>=20
> I'd be tempted to have this as multiple blocks.  A lot of the documentati=
on is not
> generic to all of them and that approach tends to give documentation file=
s that are
> easier to add to later.

As you commented, there are no shared attributes between different CPUs.
Therefore, split the document into separate blocks on x86 and arm64.

> No need to say how this is implemented.  If someone wants to do it with a
> mailbox for a particular CPU that would be fine at the ABI level.
>=20
> > +		These files exists in every CPU's cache/index[0,2] directory,
>=20
> Can see where they are from above.  No need to repeat that bit.

I remove these descriptions in the next version.

> Perhaps
> "Attributes are only present if the particular cache implements the relev=
ant
> prefetcher controls".  Or maybe just "All controls are optional".

The former description is more accurate. I fix it in the next version.

> How likely is it that other prefetcher implementations will allow more th=
an two
> levels for this?  Can we define this ABI more broadly to allow that?  Ass=
uming
> such a scale might exist, this needs renaming to stream_detect_pretcher_s=
trength
> (as no longer on or off)
>=20
> Easiest way to do that would probably be to use a separate
> stream_detect_prefetcher_strength_available that lists possible values (o=
r min,
> step, max if that makes more sense).
> Here,
>=20
> 0 1
>=20
> With my very limited knowledge of the details, a multilevel approach woul=
d map
> better to controls like RPF_MODE in the N2
> IMP_CPUECTLR_EL1 register which has 4 levels for example (though I have n=
o
> input on whether those levels could map to 'strength'.
>=20

As you commented, the attribute 'strong' may require more than two
levels of type (strong or weak) in the future. In order to allow that,
I will reconsider the interface specification.

> Having two possible ways of representing 'auto' seems likely to cause tes=
ting
> complexity for no particular benefit. I'd just not allow one of them.

I modify it so that only 'auto' is allowed and 0 is prohibited in the next =
version.

> I would not list supported processors in here.  It will get out of sync i=
f this
> becomes popular and it should be easy to see if it is supported by whethe=
r the
> sysfs attribute exists or not.

I remove the description about supported processors, because it can be
determined by the sysfs attribute exists or not.

> > +
> > +			- "* Hardware Prefetcher Disable (R/W)"
> > +			    corresponds to the "hardware_prefetcher_enable"
> > +
> > +			- "* Adjacent Cache Line Prefetcher Disable (R/W)"
> > +			    corresponds to the
> "adjacent_cache_line_prefetcher_enable"
> > +
> > +			- "* IP Prefetcher Disable (R/W)"
> > +			    corresponds to the "ip_prefetcher_enable"
>=20
> I'm not sure on whether this should be here or not.  It seems like a path=
 to some
> very long documentation once 10+ processor families are supported.
> However, there may be no better place to put this information.

The current MSR specification is defined by a combination of the above
three type of prefetchers. Therefore, it is assumed that the amount of
sentences will not increase any more.

For reference, MSR 0x1A4 are classified into the following three types,
depending on the processor model.

* tyep A (INTEL_FAM6_BROADWELL, etc.)

[0]    L2 Hardware Prefetcher Disable (R/W)
[1]    L2 Adjacent Cache Line Prefetcher Disable (R/W)
[2]    DCU Hardware Prefetcher Disable (R/W)
[3]    DCU IP Prefetcher Disable (R/W)
[63:4] Reserved

* type B (INTEL_FAM6_XEON_PHI_KNL, etc.)

[0]    DCU Hardware Prefetcher Disable (R/W)
[1]    L2 Hardware Prefetcher Disable (R/W)
[63:2] Reserved

* type C (INTEL_FAM6_ATOM_SILVERMONT_D, etc.)

[0]    L2 Hardware Prefetcher Disable (R/W)
[1]    Reserved
[2]    DCU Hardware Prefetcher Disable (R/W)
[63:3] Reserved
