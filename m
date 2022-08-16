Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4ACC7595E7D
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Aug 2022 16:44:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235343AbiHPOoX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Aug 2022 10:44:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229536AbiHPOoU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Aug 2022 10:44:20 -0400
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C49644DB77;
        Tue, 16 Aug 2022 07:44:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1660661058; x=1692197058;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=jtqMi2H52fvN5JnFnJdPUrfKao0StL0sDv10UuTQIpY=;
  b=nRydgYVM0zTxmxT3xhcub1eqswWGBeWdKOb+sma+70Qvc7ox8y1mMR6f
   wwKnicAbcM5xVNhmf8UqehJAluhePWc3/cCBq5s1UY4g4Y6hlKeqKTNfP
   Cqzek1YID1qY/veSV3eHC/xQ5ZQC2Ee6lCBrWP8Qn355TarCy7TM+j98s
   o6Cg22Perjz0shJqPVf8LedIecY1aYQfEsFWXKZSPIxWVqT2ULvbDiLLo
   G+jJjhU/xfAlJCtBeXZ/3ioMQkSfQgdsAHdk7sbKQNQ6yCvsURYnkzydA
   kEwSqEbf4HVXXGGzk/P+IbqdMuW1Jeb/idqz6zLPcRl51MPiN12mCa7LF
   w==;
X-IronPort-AV: E=Sophos;i="5.93,241,1654531200"; 
   d="scan'208";a="313118398"
Received: from mail-mw2nam10lp2101.outbound.protection.outlook.com (HELO NAM10-MW2-obe.outbound.protection.outlook.com) ([104.47.55.101])
  by ob1.hgst.iphmx.com with ESMTP; 16 Aug 2022 22:44:16 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Zuo03Uf9iIsqV5T6Ndrxc9XXL6nGNJzptAn553EMadc1sMKD0awZhvSG0HbJNCnImzKvM1e+H0mfyBll7qeefPoCEues6FzEKodR9Pc8EY386K+u+XQaB9x6SiaCLlJv+UY9f66CFS9VR6nLfQXCARyiTnzUftNplWHBj/2kpsWUIa3F7Jx8JFmUv2hEfBN0L4HuJxwKnYvn78fe60azWsJEtDisZ86Btgx05btwBxYkuvNR6MEVbrEjRc1tjYjOdvx8lIf40c/heORDRvVIHpXALEQTsBfN4ZZQ+XRrieV6eaT5wurrZ1soZBH6/pRKdyytrjDLOu8ir+tA3uZrJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jtqMi2H52fvN5JnFnJdPUrfKao0StL0sDv10UuTQIpY=;
 b=HQ7d1tQn99kuMSyykwGgRKngoBkQ7XotDwf4gj59LO7EyaUscWusCmNc/RzO56pKBu/uflVEV/qVZ78hEy9+ywOjpuuj6YXLs58UitdM9M08egoqQsDDFPJ9rh+whTJR3PyGkxJO5/kAnZiqYJp3snlb52Bz6gbNjtc0iLDR2GX06Kea8xzLNeDAKjE7Ob5gHLVX8BpEWhIut7mlK/GWJpLIaL1Es2vudzTNALKIbXyh/qtr+KU6BXQsqBcCnvs4+orM6LagVn7r8ArmNeV5iIphr0ECYS7ipG4orgwkBrdjP8Aact8c9SQJ9Gny/qPJ90cqllWJ+ZkvievE1BwWig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jtqMi2H52fvN5JnFnJdPUrfKao0StL0sDv10UuTQIpY=;
 b=d3HcdveYtj3dvp79CRdO3xlWncN+IyoajNN06mvIDdC9lMJaWzOf63a+YJUBGN+1EGtx8TYxvoC9AGmfllaQ0685P25wH8iRD9CnAUV7DfDY06+fl64ArU7uyvB+RU7Qx06e1PdqjBlFH1FE9puW3oDtmT9T4Y66I5YLq3TWQ9U=
Received: from BY5PR04MB6327.namprd04.prod.outlook.com (2603:10b6:a03:1e8::20)
 by DM5PR04MB0346.namprd04.prod.outlook.com (2603:10b6:3:6f::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5504.14; Tue, 16 Aug 2022 14:44:14 +0000
Received: from BY5PR04MB6327.namprd04.prod.outlook.com
 ([fe80::d025:4966:3f9b:9117]) by BY5PR04MB6327.namprd04.prod.outlook.com
 ([fe80::d025:4966:3f9b:9117%8]) with mapi id 15.20.5525.011; Tue, 16 Aug 2022
 14:44:14 +0000
From:   Arthur Simchaev <Arthur.Simchaev@wdc.com>
To:     Daniil Lunev <dlunev@chromium.org>
CC:     "martin.petersen@oracle.com" <martin.petersen@oracle.com>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "beanhuo@micron.com" <beanhuo@micron.com>,
        Avi Shchislowski <Avi.Shchislowski@wdc.com>
Subject: RE: [PATCH] scsi: ufs-bsg: Remove ufs_bsg_get_query_desc_size
 function
Thread-Topic: [PATCH] scsi: ufs-bsg: Remove ufs_bsg_get_query_desc_size
 function
Thread-Index: AQHYhKDynvKkVtaQm0SrWhB5D1T9dq2kYf+AgA2Q4OA=
Date:   Tue, 16 Aug 2022 14:44:14 +0000
Message-ID: <BY5PR04MB6327431615BFFFD735EB2502ED6B9@BY5PR04MB6327.namprd04.prod.outlook.com>
References: <1655727966-31584-1-git-send-email-Arthur.Simchaev@wdc.com>
 <YvBK/8yeohLhu2Za@google.com>
In-Reply-To: <YvBK/8yeohLhu2Za@google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3ff86272-1980-4ac1-8def-08da7f95c9fa
x-ms-traffictypediagnostic: DM5PR04MB0346:EE_
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Ji7I1aexV9cvZ70487KxVb4DZlyLSlOfy/5v4ogLfpGA8yFxIttdmUA+CAGNBgrBjPL4XhmFK/EH9vGWnyX1TWcVpPlVBmg/xhfAATkfqv0GhYk6r3pJ7ZzBqQJl6+g3y7JMxWVR6VoT468fbYubiTgv8FrkumHCR3lNYG/egMPGkmkllvGeQYCPomijTI1ARh17xxpmvuiMlCSDViAXqXn2X9h7D9xPNIIZg5zpmbiDEIuLpsaUp4D5bCJ3mksRbFDqyP+0J2xqNiNiCyyxxltB1obLlFvbEY38xeCYbsc5XizXsXWzKVo0hlRe+DxLnLTC0Q+90bNTLB17kEv5b+phqd08KCT+NtDvb7ds91oUB2pgQ2yK0Ezy8Wsl9i05Or+UtTMkdShlRp9C/XmgRvX9/ZqHwvBY6+h16hLOrAyk2Poupq6cxm6WbU3S9VzcvwEctlmiKGthLfpBn1ID9zh2onMT9oji3wVNkhRoLRuF9jvmCEsZGsQgqg/XQEEh2lAxphO0obkBIZ3IFz+sVySwjK/2I/ir+F8YIC6nRZ66yO2+qk3wlJi4PrJmS23fDe54tpGcAZGVJGOfKqxbA4PuWxLNRfIsvhZbTOY6q1pL2vc9L4JoUfNWsVhx7HLut25sF7AS3zRFnXnAbUnG5YDxEMPd051dkXRQNh045TmuJsB7eZr0bk5lI+ap00us6n4hhUevutfgHBW6NGTYRjJpfCnNMdoaF1TBOXvbZ48L750q3/FRpj1+KG3km9x5/7aJ5f+LLq3uBcJiHAKriONpaWZTbin12sxVULWhUQ6xOJCkZn/a1MVqqxJfnApo
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR04MB6327.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(39860400002)(136003)(376002)(366004)(346002)(396003)(83380400001)(76116006)(66946007)(6916009)(8676002)(8936002)(4326008)(66556008)(9686003)(66446008)(64756008)(2906002)(26005)(52536014)(33656002)(41300700001)(5660300002)(7696005)(6506007)(478600001)(86362001)(66476007)(122000001)(38100700002)(38070700005)(186003)(82960400001)(316002)(55016003)(71200400001)(54906003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?F6e4x5ahqONlVJmpsu3Iq3GJHKTGKcDCfBDwE10aehMN1SbMis5m9dQzIYF8?=
 =?us-ascii?Q?ElH2FZAt28elLMsIt1MprDvYBvAUmO0NbyxVhDYK0ezZBY9BIECIkWO8aQXK?=
 =?us-ascii?Q?OlNC9ul0+rEuCRsCp9ZelHP27X5vQM0KJRabxCIou2DWmeaMRgc695ONMw3I?=
 =?us-ascii?Q?ebbMLz4EvyBoNxqHFoIl/UsvgE+HR+6amCM4fyPD3/U+7Vdpx6Jhq1aYFBmB?=
 =?us-ascii?Q?bRlsMWTIJlqbK4Tql4d4WU+VN/dSnHFJSLySz0xniF60kF9aZwUfleEyrg84?=
 =?us-ascii?Q?peVcc3HRXdkSqUz3ct9Lymgof983IcI/kfU6FmbUfX4QCr6bWIinHfyYyDwQ?=
 =?us-ascii?Q?Pc0l5hTH3mQQMhdH7IsaLmyUpsejLIEcGnG7EjfqKbL96+3VfJzEQDPpBpZa?=
 =?us-ascii?Q?NwlzmwbQBxaMAgQXsdYSWzF2xTqsntbPDswTyRVpTB4VW9lJPCtyxaJUQ2um?=
 =?us-ascii?Q?c3qZy0fTmglpoToJnS2U6cvL5iGHPU/nTsc1O7STPZ5h9YilI5nv4loqMgLx?=
 =?us-ascii?Q?CtVN8rTywoQ/EbD1P+Wn8G8xeWwVEKn35k71NnbYDn4xa7dDVvp6SVsLHxx9?=
 =?us-ascii?Q?NgavgyXWGSFfxghpi5ZdmC5MskXm9K4vRy6FQ1ZnFWP94+gLDwI3KVROENIP?=
 =?us-ascii?Q?uLF0K4Q3AW6XMyfnnUn6PH1urDb9hOwrMBnNJAs07VH6Q8OQM8arCRytbiNv?=
 =?us-ascii?Q?Rky5aVe7I7b/uMfKOlmoMVOGYUiEENMY9u4MEuMyEuUIr5OrOM+6hXrEwJan?=
 =?us-ascii?Q?QZ9E1t93WNBu6pHvLs9GDH0l1szy+gSp2nU+war+jJHnsnSz//WoL8R4HaFl?=
 =?us-ascii?Q?Xe+mv+XjwNDQDIECnG19w/l6xu8MKXaOYpuNXb3DvWBG3x0+nOEJAftYci18?=
 =?us-ascii?Q?tw09JCFuQtHlvUXXWVlYVhEC86caOrsry0NWzBvqdA6F4BzuqSTgp9m4rjtu?=
 =?us-ascii?Q?PDzEMDYMtKjtnAkRINhRgCj9vST8M0NCNvb3g6Rp4nmxEGK1JsVoRMl8a9MG?=
 =?us-ascii?Q?mw/QHJTpjRWYcr/1LL/Y6L/NKqNgcXqyaA/osH9RdyvArNE01od07Qr3gTKb?=
 =?us-ascii?Q?GdDqlEyigQa4qLxw7yPJA8ktj6+TaCCxa9E5J0RrmGKiqpeT+C+uJFr5u6o0?=
 =?us-ascii?Q?wzPOuBlEFEVeEGJSPLzLXE/Oj/lfXKUvJ8vXhfLM4yPNzww+3vXMnp58H5pV?=
 =?us-ascii?Q?pFWAfJzXiBZrIYzAcV7A5LZ9bVXVFZDoKFLGutsBYoRWE9ACM4QFrBudTd3z?=
 =?us-ascii?Q?XZD35rlu2s8B/gGJbA4lbzO8J+c5OacwZU+bxOMO/lSAr+U4tP81NfKGhHsD?=
 =?us-ascii?Q?AK7HDVMYLF9VC60LdotpuySKJwcXcFF1b5B1dCdyEsdUAj0szZas/WnBxIml?=
 =?us-ascii?Q?gxdJ4zz99VHxIxV5WzKntw/9ZWGEoYktmgvkYe/qfJ52mIqcAfWkF7xCDDjV?=
 =?us-ascii?Q?qGA+YHHrAuYV8khbl1MvGCEQMXEAZGmjU/qX61m52PkjW+xmaCZ9td+uj6yT?=
 =?us-ascii?Q?0C41kuJcLP4q6gXItu3ooh2Y5U02Uxfj1Hmnbz9DLgusfMa4+UN5qggsjaKD?=
 =?us-ascii?Q?KKdTxqrA47qlQTQ+yXK5a4W1GLoEb2JoEZ6muUzC?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?LGv65ohrmUBMUyYENnThpwV1sw1YD2qSnAOVCwxsTnOi4RvU6ekLpEwMEwcP?=
 =?us-ascii?Q?7bLPrc215cahRd0xui4Xp8GORWKWZMmva0z7+23QIrptLLMXQMAc3j/9Eq0n?=
 =?us-ascii?Q?vJ+QJYF6c07Z1zEJcMgJQH5Pzick4vZsFuOf9j/Rxglc6YSsTs3rqblFjsJc?=
 =?us-ascii?Q?3vDV+r518Ia/JQbwQaqrgw12YC8o9gA/L0iod1Kov78NzaxeILaCS+i8uDlO?=
 =?us-ascii?Q?KmSJmz9RiG6tDjlxeaggHIZCQqT/Sr5MGMXlvGIgf6h7Lq7UkuZQ5zXHEcVz?=
 =?us-ascii?Q?md0+NSOiQSsl8ZbD4G6wL84zB0Oaho4C3o/bX5HBGCO3TE8pQS48yPrh7AEl?=
 =?us-ascii?Q?1Zb6fhyyt5FA/ZuMlc14sjCxM37KPE7QGaezjUGl7Edd7yvtUor8m8p5PX4Q?=
 =?us-ascii?Q?sgKO7TpBAZtYmDdU6APMoARRqdBOYjsvgXcjycyHWBB6/QGTKdUZo25xdLzf?=
 =?us-ascii?Q?ltWtWztBDl28ctp9fCpu2LMdJVjOj2jcBFDma8cqoPjS6ep9XMzvXtqcNZlO?=
 =?us-ascii?Q?xWfCXgY06HSCB/A/tOsExkSzyWDDoMKQRWL4jvc6t2/IXtjtF1fanXXt7YGQ?=
 =?us-ascii?Q?/j4s/RSl9K/kh37xEWpVKUt8uhBPIcStCzuGK7VSCgJN0UO0GXFH2N40X0v/?=
 =?us-ascii?Q?Cu7Ayc+eEQAoeddlto7luuzBv9MimXabkuS9ZKnoFMbaR/dWWLTobxEhXyM4?=
 =?us-ascii?Q?HVInLFJtJbe8R4xv4oYkoapcU3xwNPG2SHYhawqxFvSeFfldS07PIFs9/Lny?=
 =?us-ascii?Q?E90MqJuHSXZQ/YVg8Oi1SoFBj/hRtPXT2SvzUOEUxR8gRUBp0EgOTyOqt+S6?=
 =?us-ascii?Q?mrJGYlmBeCY8nmNYBNIlBGGgG4Smj04EUGXgFH4EuZXGVF288SvfhT1IrwRl?=
 =?us-ascii?Q?NtsV12WYQqd+lRs2faN+R/HtThMjPiBQnlsYjTW9mmoSaKH9qgrlRV68kcB7?=
 =?us-ascii?Q?PdzRbuSubp9jsXvqLIeipsp1kqGL98eHRzziFHvCnQ0=3D?=
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR04MB6327.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ff86272-1980-4ac1-8def-08da7f95c9fa
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Aug 2022 14:44:14.1529
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: oyZoDTcSECqkXcgkWOSA2Q05oCopUjw1rFNe7Tbwo/lQkYX+yhqL1FHDCjxpRG/DspDKckJVboGtKSxiO4Vhyw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR04MB0346
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Daniil,
Thanks a lot for your review.

> Can you clarify what you mean "hard-coded"? The descriptor size is initia=
lized
> as QUERY_DESC_MAX_SIZE, and updated in `ufshcd_update_desc_length`,
> which is
> called with the actual size upon finishing `ufshcd_read_desc_param`.
>=20
> The function you are removing - `ufs_bsg_get_query_desc_size` - doesn't s=
eem
> to
> reject requests on incompatible size, only to restrict the size of the qu=
ery.
> The way the code is written - if I read it right - will lead to truncatio=
n of
> the response if the size of the requested response is less than the actua=
l
> descriptor size, but otherwise you should get full descriptor back.
>=20
> Can you provide a specific example where you see the problem to arise?

Reading a new UFS descriptors will be rejected due to hard coded descriptor=
 definitions
in ufshcd_map_desc_id_to_length invoked from ufs_bsg_get_query_desc_size.=20
For example FBO descriptor published in Jedec UFS 4.0 spec and already exis=
t in some UFS devices.
Or others reserved descriptors which can be used as vendor's descriptor.
We should be able to read any UFS descriptor of any size (up to QUERY_DESC_=
MAX_SIZE).
According to the spec, the device will return the actual size.

The ufs bsg driver should not impose any such limitation. It's one of its d=
esign guidelines.
E.g. as done for the attributes, flags the kernel doesn't check it size(for=
 attributes is the max - 4 bytes),=20
nor access (read/write).
And just returns an appropriate error code should an error occur.


Regards
Arthur

Regards
Arthur

