Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F5E655FAAA
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jun 2022 10:35:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232641AbiF2IfE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jun 2022 04:35:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232513AbiF2IfC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jun 2022 04:35:02 -0400
X-Greylist: delayed 63 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 29 Jun 2022 01:35:00 PDT
Received: from esa5.fujitsucc.c3s2.iphmx.com (esa5.fujitsucc.c3s2.iphmx.com [68.232.159.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90B8C3B57A
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jun 2022 01:35:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1656491700; x=1688027700;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=21ggC7PcCiZ7nBDyJAkDi30A3uC7KouQZmiJKeHyycs=;
  b=egm3MVj8TDRYkJHk9oIiJ9yIJmVoCBLYUeCOAgH3J0g3O6OUIGIAcBtV
   ZGKM6qUJS+juooPXxCcwesWTSDVxOX0j+CXfC6o+C0nCjJlTPLbMTNlcW
   IV3czDogd58XCO3CtX10s3yA/aP4QfaZm5eSxYgYIPvRq9XaZ3aF7vBDG
   4qyUepCW4Y/RHDHZgEujMjnahuI+GoESbZHuXs7LbEvKhLmiMFe7onTrL
   hkKsE9SHEfNiM20zN5FAtReyW+KEkzfgS364seO9a/2Bepp/Gd++V1SQ2
   o2cu/aX/b51mJCE0Sn0pnPN2nqL9/bquxOaMCZSqjhraFL8GUMaI8qWvk
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10392"; a="59351735"
X-IronPort-AV: E=Sophos;i="5.92,231,1650898800"; 
   d="scan'208";a="59351735"
Received: from mail-tycjpn01lp2171.outbound.protection.outlook.com (HELO JPN01-TYC-obe.outbound.protection.outlook.com) ([104.47.23.171])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jun 2022 17:33:50 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EPPQCglOo61p+MirYlv2QDDV7nxdOCDg/1ruTKFqNDAsBUaWWyJ1s7Tl4+75OSQcc8ogTDeir8sYv3cjWKbm+lUJGUEiAItJqBf89Gkux3l2FRA7Wz7U6aFpfBH1IiPD5y6dtNGdXh0jh8SwcoTD6FW7HHD64vfMyKfNbuRNLZPiBmBAPP2WgQzq/55bvz3Ilr6pvr1WzKIErtZugIjzuitoyV2kusmu2pSEqVgvSPVUCNij846OKYUUKr2Tl5g8QUrIEK6QwM1ks/kWUVt4gWK0Kn1b2ztzzoxYbb/HVciurduxXmPL/z6O/9ZgI1K4THIsyRGDEP6KzAc5WKXpqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iseMb2k9PvxKNT/Iz7ph7mhqBgQPuqfINTBXPTTgkHI=;
 b=m9Xa9tXVMJXkbutviLXLHdrCm0vwgiQfi5qOAxR7sepAIdwVZYBl/81ddK6KPtYA21mAQ3VLUtE67fUB8oxIAHlhIYlL1/FcP0fcOB8OBq/1OMIzSUNPewWCjw31pk5oGM6NybsoO4FNkh2io1crFTEDDmFkBZ8/pLW//xj3o7KCNrLxLsdxIeLoYvwxQiNEcESEHI7Yx4adglJDkz5xn+9IFh/sMy/D77WP9iH/+e9e5Nemv8AZfYjj4g1bAmiIFwRTK+1YYsGiAkFD3RSnAxzi24JYarl4U0ZV4UzkbzC2xxw5ZGE3Hlxz5tloWSihwYpLf+L/YHgijSi3JynicQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fujitsu.onmicrosoft.com; s=selector2-fujitsu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iseMb2k9PvxKNT/Iz7ph7mhqBgQPuqfINTBXPTTgkHI=;
 b=e8GcF3t00+9i0QX4XdgNSOmqp+C4isbVKmLfqXghvQZ7ZHrkuNG8uErjFIqQtgo4kkQto2++oYWGwmjb6vXZtEGa45p4ERvblO7z626tQY1k06mADyiskquVpDMhalThEwQiEn31KaISLKdpxflHE5kxy9jBWwf2aSP+J74gouE=
Received: from TYAPR01MB6330.jpnprd01.prod.outlook.com (2603:1096:402:3e::12)
 by TYAPR01MB5577.jpnprd01.prod.outlook.com (2603:1096:404:8055::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5373.17; Wed, 29 Jun
 2022 08:33:44 +0000
Received: from TYAPR01MB6330.jpnprd01.prod.outlook.com
 ([fe80::cd21:d921:e755:ef70]) by TYAPR01MB6330.jpnprd01.prod.outlook.com
 ([fe80::cd21:d921:e755:ef70%9]) with mapi id 15.20.5373.018; Wed, 29 Jun 2022
 08:33:44 +0000
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
        D Scott Phillips OS <scott@os.amperecomputing.com>,
        "lcherian@marvell.com" <lcherian@marvell.com>,
        "bobo.shaobowang@huawei.com" <bobo.shaobowang@huawei.com>,
        Jamie Iles <quic_jiles@quicinc.com>,
        Cristian Marussi <cristian.marussi@arm.com>,
        Xin Hao <xhao@linux.alibaba.com>,
        "xingxin.hx@openanolis.org" <xingxin.hx@openanolis.org>,
        "baolin.wang@linux.alibaba.com" <baolin.wang@linux.alibaba.com>
Subject: RE: [PATCH v5 04/21] x86/resctrl: Group struct rdt_hw_domain cleanup
Thread-Topic: [PATCH v5 04/21] x86/resctrl: Group struct rdt_hw_domain cleanup
Thread-Index: AQHYhle68z3EpKIpt0Wg+v62Ec3kEK1mDBuA
Date:   Wed, 29 Jun 2022 08:33:44 +0000
Message-ID: <TYAPR01MB6330E0E18CF4A229B38511648BBB9@TYAPR01MB6330.jpnprd01.prod.outlook.com>
References: <20220622164629.20795-1-james.morse@arm.com>
 <20220622164629.20795-5-james.morse@arm.com>
In-Reply-To: <20220622164629.20795-5-james.morse@arm.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_Enabled=true;
 MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_SetDate=2022-06-29T07:46:52Z;
 MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_Method=Standard;
 MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_Name=FUJITSU-RESTRICTED?;
 MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_SiteId=a19f121d-81e1-4858-a9d8-736e267fd4c7;
 MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_ActionId=73785fe8-245b-479f-82ec-3507e24a95ef;
 MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_ContentBits=0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 056c40b2-b8e4-4bdd-3f6d-08da59aa1464
x-ms-traffictypediagnostic: TYAPR01MB5577:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: QHwrZW9Vq/6jHh+q8kaqbJfoAUMYMt/BzeWrsDnslUr9EWpKRpEFCcrGskXqYEvptUW7wcFxJ5UeWweiIENvnYHcxjTA34hG9uf60CCWfnBJzbTSjSe0i7g109snN4Sw5uDvGNniGzgisKpECv1ptHa69zGC4OQT6Q9ReyMmOj45S2oh5+9HFKJORBzYeN4px8jwbpoQX0nmPkEdiIW4CWhjM8MbwbQyc9cPVMKCFnZwH09ezLhk4w4nm+pkGmXdyGtkmJX5e/DITzSNp8/iPDVmVm7S7t0u9SJ2jAyrhFd2yYICcV0LUeH+aEgmMoGaSpDmCu9O6sb7iIcPLS/8aqVVVgi7PBjaoILBumQFaajQYobltvVhzLA+QngcT1HnSMRDTAu3wzXPpZAmnTlpJ4NTbLSzMcnGZiGrO6S07e1ABK4kcXjs2jnAt7w3QJ6VHHYyIuBHRsXfwx7GeA69oqutY5FpziAA8B1eEyI7fk9MOh1QhfltTJRZP6WYSV+rQxg4jJaHzBoOW8hHt3pfmemaWy0LWDKO3RCh1/c3FFuC4JzJ7At6u1ACRnpqHTZJUv2EDDdtkVfr9DmbIx2mSc4VkGQHwaOcm7lXYgB1/UZJo2676n0geNm5IzPGgtlcXeIryvSrFMcv649agHZ7GKPnjqY2Gyhjbs8aVuGYAx+AysmOO+32OYyjxQMWvKNJ6b73I/Y5zQAiCs2uJNvY2vV8Qc5xNq1fQzP9AdwdGj0a5IpRRRrON0cJqiMBdz0UCZJPKnX6mP2EprL/XntouJNAVezlnCyunfARPYIvZNo=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYAPR01MB6330.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(136003)(376002)(396003)(346002)(39860400002)(366004)(110136005)(5660300002)(38100700002)(33656002)(2906002)(41300700001)(82960400001)(186003)(54906003)(85182001)(316002)(8676002)(66446008)(26005)(52536014)(83380400001)(86362001)(4326008)(71200400001)(76116006)(66946007)(6506007)(9686003)(64756008)(7416002)(8936002)(478600001)(66556008)(38070700005)(66476007)(122000001)(7696005)(55016003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-2022-jp?B?YTcvb21GZUFBYVEzSGIyYWUwczZPamlSRWNNRktjZmU4SzE5TENkajA3?=
 =?iso-2022-jp?B?eHhTNXYzbzY2ZlJtRUZsRTU5MnhPZVBWQVFrN3dwRFBzSjR2aDZxRHNw?=
 =?iso-2022-jp?B?aDlmYnhidDVvenNjckE0WFJlTWR5M3ZaOTEvYmV4OXhFR0hLMXkvSVg4?=
 =?iso-2022-jp?B?dkU3bkFEOVdsWWpHUlFUQ0lwSnpsdkZTVHhzSHM3YzArMmdxVDhReGtx?=
 =?iso-2022-jp?B?YnRtdmR1VXRqZzY5WDBQRXNhaE9KNUxXTWIvTFE0bW1nRFZYYnNHVXNL?=
 =?iso-2022-jp?B?Q3M3U3FuSkdhVng1ZFprNFpUdDF6OUFhWkZRNGdVS3BiQ24yZjdjVm56?=
 =?iso-2022-jp?B?V050NDhJMWRMVVhZMitkZG45MzAvYkZ5ZVRCMXpOeXVuN01YT1dTcVBW?=
 =?iso-2022-jp?B?WU1XNHptd2FMNDdKZXAxUzRuVEFLdEh5RU5MeWxiWit1YUNjVVNPY05B?=
 =?iso-2022-jp?B?RkdFcmU3Y0ZlcUg0S2pTbTVSMWh0d2JEUUxxRkFXOTRmRXJVcDNWS0gz?=
 =?iso-2022-jp?B?V1lmY0hpQXdCUnpZUURmYkQ1UE5YWEFnUmczZFFyTG1WNG5uZkhVUXpM?=
 =?iso-2022-jp?B?OUI4K2ZUcWxwQUp6ek5uWUZRWWVmbGxaNlVWT3k4UzVjOS9SSTkzMmwr?=
 =?iso-2022-jp?B?YTFYTVFEY21MTVl3TzZKRk5WSE1UV3FaTWN4U0NUU0x6Q2RMMy9DR081?=
 =?iso-2022-jp?B?SFRSSzd2RlhEblFvZTF0cnAyeWhnNWVRTFJHM0JTSHprQjRzTWVBTWhF?=
 =?iso-2022-jp?B?WGVhQ1Iva0ovc1d6MmcwMHhMayt2bDVpRm9heGNaVVROMFFzQjA0d3hI?=
 =?iso-2022-jp?B?a3pNYUgvckpDODJrZHl2VXVYdzRUM09lbUxSL0JyZklTVmgvT2NrQUY1?=
 =?iso-2022-jp?B?eGRzaFVtZGxCYTVlWUNBMDk4VDg3dkZpWlk0eGIzSG8rWmJsZlVXOWxH?=
 =?iso-2022-jp?B?UEtzWGlGc1lKaVdxdVhCa2dnWjRCem43Slh5ZGNqZGVKU3JGQWx0VkhM?=
 =?iso-2022-jp?B?RnYzVTdQdTB6WXV0S3cxNjZZYzh6a2llNFNFdUJqV2tJWEFmblk3eURa?=
 =?iso-2022-jp?B?NHNKQ20yWHZvNTFXZDRFV0pOdTRueXBEUkw5RUp5U0drUE95aU5xeEtP?=
 =?iso-2022-jp?B?c1NNTW5XZUQwWlJZck5kYWxxQVp5eHVJRExhTkttSHA5d0srR2hUdHBs?=
 =?iso-2022-jp?B?WmxVaHlxZHN5cWszb3RnYXc1bTdUUlNMMklxWEcwTUswRUlJNklCLzRT?=
 =?iso-2022-jp?B?MTFFeXAzUWc1RndNV20zVnd5ekVhK0Y5R0JSMHEraTlvSVhkaFd3T01o?=
 =?iso-2022-jp?B?U2VTamNuVU4rbVVxOGc0Q1RENFdSUk5rcHJ0RVhVSWw1N2dEZGtrUHV6?=
 =?iso-2022-jp?B?c0tHemJLNnRGbW5FTy9vWGJLNVI3bW1yd3VTa3ZZekJIVUZIbTQzUlhL?=
 =?iso-2022-jp?B?MWsxZC91UFQyMm5vcDNkZTI5UTJWYlRVeFRzQWNKSXAybitBTXEzbGZo?=
 =?iso-2022-jp?B?aXZWK0diUzZ4VGVnejd2ZnFqaUZ2WThDU3NIc3RmRE5hWGkwUmxjZW93?=
 =?iso-2022-jp?B?VGxSOGdRSFJRa0paN3VCelJYcU42VDYrK09BZzBJb1ZHaGFiMmpZNVoy?=
 =?iso-2022-jp?B?RGNudnMxYnc1WlNrYlhReTR5SWYyMWVReUhrbzRzeG5lRzRyNXg1Yy9S?=
 =?iso-2022-jp?B?cTJrYTV0NlFQRFZoRE5aK0p6YmE3Slp6TWJlNStoU0VrWHA4Zmpzait6?=
 =?iso-2022-jp?B?WDRBVGoxVTdYV2pGc1RhVE9kQUlZanZRS3p1KzNiTHA3SjRsN0R2czJD?=
 =?iso-2022-jp?B?NmE1ZndPS1dDd3RPalk4Q24yNmNDak9jUGhTbnJGYXZzMTZNcS96YnZm?=
 =?iso-2022-jp?B?YTNTaTdoMk1rU1dueThKQnRyaEpDZjJITGF3eHRmY3pxTnZTc3ZyUEx0?=
 =?iso-2022-jp?B?dFVTOGdzOWFvamNyZ2UvQ0ZDRXlKVkxHQjk5UnJjd2RFMnpvbDlyZ1VU?=
 =?iso-2022-jp?B?M1kyMFdvS3QzQ0xneVVzd0ovdC9OSlJxdWljS0RDQ2lXcXp3ekk5Y2hY?=
 =?iso-2022-jp?B?L2NVVG5Tdk9leERzUEZpT0lVenluVFZrSW1RRERRR3FCK3ovUGFaWncx?=
 =?iso-2022-jp?B?VGhTY1ZNOTdlaW11c0QyWDV4WTJJald5b1pWelQ5ZHQrSmFHMDIrNkUz?=
 =?iso-2022-jp?B?Z2QybXFid3hnRTJsSDhYOW5Sdkp1KzlINjdpTFBjcWY5aGJ2dmpXczdV?=
 =?iso-2022-jp?B?VUgvbzQ3TFFMMjBIT3ZuVXpLQWx4UnVLNFA0ajFCNWZQcGNzRno5N0Fv?=
 =?iso-2022-jp?B?RDlLcDY4aFRramlpaEw2VzNXcUZKTjNPNWc9PQ==?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYAPR01MB6330.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 056c40b2-b8e4-4bdd-3f6d-08da59aa1464
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jun 2022 08:33:44.7148
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7ks6QKfBVlrYrjjhjgEKCMZRwUnaQIwKg2D251iX6sf4Y4IY7DZcdsHIAt2pgSYUiCBh6VgDoW15DKdEXO4iq/lqQ3qE+Jw7Ntrf4RrtPxM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYAPR01MB5577
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi James,

> domain_add_cpu() and domain_remove_cpu() need to kfree() the child arrays
> that were allocated by domain_setup_ctrlval().
>=20
> As this memory is moved around, and new arrays are created, adjusting the
> error handling cleanup code becomes noisier.
>=20
> To simplify this, move all the kfree() calls into a domain_free() helper.
> This depends on struct rdt_hw_domain being kzalloc()d, allowing it to
> unconditionally kfree() all the child arrays.
>=20
> Reviewed-by: Jamie Iles <quic_jiles@quicinc.com>
> Tested-by: Xin Hao <xhao@linux.alibaba.com>
> Reviewed-by: Shaopeng Tan <tan.shaopeng@fujitsu.com>
> Tested-by: Shaopeng Tan <tan.shaopeng@fujitsu.com>
> Tested-by: Cristian Marussi <cristian.marussi@arm.com>
> Signed-off-by: James Morse <james.morse@arm.com>
> ---
> Changes since v2:
>  * Made domain_free() static.
>=20
> Changes since v1:
>  * This patch is new
> ---
>  arch/x86/kernel/cpu/resctrl/core.c | 17 ++++++++++-------
>  1 file changed, 10 insertions(+), 7 deletions(-)
>=20
> diff --git a/arch/x86/kernel/cpu/resctrl/core.c
> b/arch/x86/kernel/cpu/resctrl/core.c
> index 25f30148478b..e37889f7a1a5 100644
> --- a/arch/x86/kernel/cpu/resctrl/core.c
> +++ b/arch/x86/kernel/cpu/resctrl/core.c
> @@ -414,6 +414,13 @@ void setup_default_ctrlval(struct rdt_resource *r, u=
32
> *dc, u32 *dm)
>  	}
>  }
>=20
> +static void domain_free(struct rdt_hw_domain *hw_dom) {
> +	kfree(hw_dom->ctrl_val);
> +	kfree(hw_dom->mbps_val);
> +	kfree(hw_dom);
> +}
> +
>  static int domain_setup_ctrlval(struct rdt_resource *r, struct rdt_domai=
n *d)  {
>  	struct rdt_hw_resource *hw_res =3D resctrl_to_arch_res(r); @@ -488,7
> +495,7 @@ static void domain_add_cpu(int cpu, struct rdt_resource *r)
>  	rdt_domain_reconfigure_cdp(r);
>=20
>  	if (r->alloc_capable && domain_setup_ctrlval(r, d)) {
> -		kfree(hw_dom);
> +		domain_free(hw_dom);

domain_free(hw_dom) is executed when fails allocated hw_dom->ctrl_val=20
by kmalloc_array() in domain_setup_ctrlval(r, d),=20
but hw_dom->ctrl_val is freed in domain_free(hw_dom).

Also, hw_dom->mbps_val is not allocated at this time,
but it is freed in domain_free(hw_dom).

In addition=1B$B!$=1B(BI tested this patch series on Intel(R) Xeon(R) Gold =
6254 CPU with resctrl selftest.
It is no problem.

Best regards,
Shaopeng
>  		return;
>  	}
>=20
> @@ -497,9 +504,7 @@ static void domain_add_cpu(int cpu, struct rdt_resour=
ce
> *r)
>  	err =3D resctrl_online_domain(r, d);
>  	if (err) {
>  		list_del(&d->list);
> -		kfree(hw_dom->ctrl_val);
> -		kfree(hw_dom->mbps_val);
> -		kfree(hw_dom);
> +		domain_free(hw_dom);
>  	}
>  }
>=20
> @@ -547,12 +552,10 @@ static void domain_remove_cpu(int cpu, struct
> rdt_resource *r)
>  		if (d->plr)
>  			d->plr->d =3D NULL;
>=20
> -		kfree(hw_dom->ctrl_val);
> -		kfree(hw_dom->mbps_val);
>  		bitmap_free(d->rmid_busy_llc);
>  		kfree(d->mbm_total);
>  		kfree(d->mbm_local);
> -		kfree(hw_dom);
> +		domain_free(hw_dom);
>  		return;
>  	}
>=20
> --
> 2.30.2

