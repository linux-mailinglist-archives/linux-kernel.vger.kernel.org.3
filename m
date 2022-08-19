Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B524599460
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Aug 2022 07:22:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243004AbiHSFRN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Aug 2022 01:17:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238548AbiHSFRK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Aug 2022 01:17:10 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 470A6D3458
        for <linux-kernel@vger.kernel.org>; Thu, 18 Aug 2022 22:17:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660886229; x=1692422229;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=wmIgUkyGgG8wOUmxNoAYjmKwrG5akrCjFUGUa4qnpCw=;
  b=kCAmxxINMyr9ZfBbZKFP8P0Lpu06qH7p12uo4vHS4wt0EpxUHTVj+QVZ
   W6a2b6/Oq8//eEqbyFVD6GaeLwhv+s+8ciKWu5s5HhG5hYg8xLmcdKW9j
   hlvpkMGMLQ9tF1R+70b5RCAd1kWUxF8GZdEUrgIxFXvFVzGb9Ddy8xr62
   A3PxUJTskIoJXrS3oS9o9Vl1A9hJWrMafmXSSAfAKFsUbNrYJYPPtwAsH
   Inj61jQjmW2rtDcE6wtByjXQuV1JMehcCqB0N5m0dkTOaYDQeu0Tqk5Nt
   5NtteWmk7DLtAOTgtKcbVjMIFjEt2WTORtg+J0EiD35zGVyCXHe2vyRMS
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10443"; a="379232270"
X-IronPort-AV: E=Sophos;i="5.93,247,1654585200"; 
   d="scan'208";a="379232270"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Aug 2022 22:17:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,247,1654585200"; 
   d="scan'208";a="611243964"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga007.fm.intel.com with ESMTP; 18 Aug 2022 22:17:08 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Thu, 18 Aug 2022 22:17:08 -0700
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Thu, 18 Aug 2022 22:17:07 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28 via Frontend Transport; Thu, 18 Aug 2022 22:17:07 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.177)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.28; Thu, 18 Aug 2022 22:17:07 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZsgseMbymaPe5vnD6O5QUd3AS5LEpKDjF/jykeSdKvkT7pou7svghDfprPzhronMLwpRakGLmMLqRCtOn3ZNv+KYu3Nkxm7EM5g9Psjc+71oJ/D4JlOZRzCL2EqgohWRlESw9uHnjXa/XDS2ICJjJDQOoCrwJqwvXvrzbvppPKGg3i2aqXScjDnwn7S1DrUwI3VNuRTAwanbR6KD2GCFX3+g6gLyIJY2d7ccQ8pN5k3rPbzIeCz7r6fEgc7iL3SexdL1hhIgOsoqkfUAH35SlDey3TBw7h+WOCR/z8ecBkTs7NbztmUgjtS4A33DPdaTPIqXLA443gzXspw7Hf+N6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j3gjkVwbkDM28Unvtr3hsenZAKqOQzMDeNpwUELJ6rE=;
 b=abWYTX6m4PxADpnR9jisqhI3ue9fMm43AzHzGccqK9xkCHph/EDLr6/B014FhwqyOjDTfIbounhgzpYKUsyl77MyrhWjKYLK2lMSBgr1qn8NGbW8SPhY8rcrqSc9c8KqJ6K4pGzmt8JHPb0gcMX6dIJqFJkSEbQTxwn1rYq8d8TfpgYuhDVScn9QqB5xapTyXi5ClVrbhV+oVJ2MbBebNcAgF7Uq26fuzELNJWfNkc5czvPXdxUgx4HOM2a+udz7HTWMefTWK9L0Bd1f18Fqj4ZT+7U4ljfSqif8W8M8iq4Dr2vnKleR4mIczzXPlzfRg14sdVld/xeowhUs0vz4HA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CY5PR11MB6187.namprd11.prod.outlook.com (2603:10b6:930:25::11)
 by DM5PR11MB1243.namprd11.prod.outlook.com (2603:10b6:3:8::23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5525.11; Fri, 19 Aug 2022 05:17:05 +0000
Received: from CY5PR11MB6187.namprd11.prod.outlook.com
 ([fe80::584f:2178:c6be:abf3]) by CY5PR11MB6187.namprd11.prod.outlook.com
 ([fe80::584f:2178:c6be:abf3%5]) with mapi id 15.20.5525.011; Fri, 19 Aug 2022
 05:17:05 +0000
From:   "Hu, Robert" <robert.hu@intel.com>
To:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "Lutomirski, Andy" <luto@kernel.org>,
        "Peter Zijlstra" <peterz@infradead.org>
CC:     "x86@kernel.org" <x86@kernel.org>,
        Kostya Serebryany <kcc@google.com>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Taras Madan <tarasmadan@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        "H . J . Lu" <hjl.tools@gmail.com>,
        Andi Kleen <ak@linux.intel.com>,
        "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Zhang, Weihong" <weihong.zhang@intel.com>
Subject: RE: [PATCHv6 08/11] selftests/x86/lam: Add malloc and tag-bits test
 cases for linear-address masking
Thread-Topic: [PATCHv6 08/11] selftests/x86/lam: Add malloc and tag-bits test
 cases for linear-address masking
Thread-Index: AQHYsF3If32HtSIwQEOGc+Dp2EkM1K21gXIg
Date:   Fri, 19 Aug 2022 05:17:05 +0000
Message-ID: <CY5PR11MB618704AA299ED39704B9BD14E06C9@CY5PR11MB6187.namprd11.prod.outlook.com>
References: <20220815041803.17954-1-kirill.shutemov@linux.intel.com>
 <20220815041803.17954-9-kirill.shutemov@linux.intel.com>
In-Reply-To: <20220815041803.17954-9-kirill.shutemov@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-version: 11.6.500.17
dlp-reaction: no-action
dlp-product: dlpe-windows
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 39b9810a-e753-4c4c-453f-08da81a20e71
x-ms-traffictypediagnostic: DM5PR11MB1243:EE_
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 0SyC9+Ek9x5Bva4VSuLVUZ2nJGW/qWKJLzhUxHSEnVg64FgPsUqBOB5bY8I00qBTZRn6RGvWsMMLqKo7IqTMJLpyDyxZ6pRND4C8CJ6vbFuS5bckc7mMuLHtImKiZ6ns6KyXjr+HOlFlnVnfaupPDBjRzJIZR7z8mux/rjzmV9f3IsC2qHO36Eyz7eX/SoVTbX9cHMEe/Mmjr0BzkCM8UUCv9VCzUhBiV4Ip0wx72M22rhcHVqKdWnRS95IaUzeDhz26Vl6W65M194YaijSenISg6tFjZNg88RDO/zzbnckJNp4kn/Geke1XwC84dOZuEpFAPESUY1gzRsUHFo/dBjI6oLU+BUtLGy/7y29cnhZP9meWw4ETNxpWb7KyS++LijFJWed+NgsxBEQBycEdmme0SdCuiUyQvBhKL+KkPWB+g9ZGAb1BjxsW2svPX6RZs8dvEMBDHbjo9NBcQyE5hMJoIXBXfTUUNibf1IMt3V00NOUKf7lwjYV66FjFfDZg/1v5uA9Sjg0ZBOYsx7lYMU5XqTEu92A71yrIs2DIFqq+AJmPL3RmOqLdHjl6sfETyUNTxy0Q5EPRv5sB8szeFE27bhSTDiHFqxaIVLuY9O9F1GrdrqTf+queI47BB4adm3CmFFxBURDHxzlsdMqn4craG2Eh+4phKnQYSEwrEz0uMOCPQuoGYe+9aTf1aiSvL5C7i4OxiBraETKCi1gJO8Lvj4am4JIf2rrG5iap8S9P5DDSG+GGsdAlhcMODnx63QWACGcvyGrPFaytsFQ/Eg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR11MB6187.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(376002)(39860400002)(346002)(366004)(136003)(396003)(6506007)(53546011)(30864003)(82960400001)(7696005)(38070700005)(2906002)(33656002)(55016003)(186003)(38100700002)(122000001)(9686003)(26005)(110136005)(7416002)(54906003)(316002)(71200400001)(76116006)(66476007)(66946007)(41300700001)(8936002)(83380400001)(5660300002)(52536014)(478600001)(86362001)(64756008)(4326008)(8676002)(66556008)(66446008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?8CaVwW5Gx0FF+ufRs7aET6pLkHWlRAvetwkaTReo/EC5j6FE/ozEDRdMYXDB?=
 =?us-ascii?Q?wqz3wNPBYESqhrjw+CSUzShEo5leisyw2lMSoff1eoiFF45ZQrL8o8iVNLTN?=
 =?us-ascii?Q?/KWAIzMlvLJt6wGEwwXwPjxNbKqU3zfAJVVrzXV5JVUOD75ftBHjsus5v3TE?=
 =?us-ascii?Q?TX8krXw5KkFOe3Og7DdwyrkOlpv3Ufmaao7fAacs2zC+3IQxq8exJcoHNDJc?=
 =?us-ascii?Q?32zLXOyL7q8FgAJJIh4SGX1j5TnckMopM5A3vlfvQg1XdJlyuuvZC8nu21sH?=
 =?us-ascii?Q?kXrLGQYKdqpxHal2/Q4EzPa4bXPwun8ok0sX7vQTlrmCD4dhHnZ3ChYxOxhM?=
 =?us-ascii?Q?0HZnC/wXhWxicbGzVXQttmGQFgvrTx0bUhzwu/8cCUrRqM9XGE8YgWU3/z30?=
 =?us-ascii?Q?lJITwpbqSPHu1+TlnqdjwWXfH/Ky8nD/kGDld18BM1sHChtQrKCBkA9hggwp?=
 =?us-ascii?Q?o2z9I1WfVMr97798HVcV18HYEF2Qk6Nc0E1cpt7ehvtA4bBRdz7KSNJvO75N?=
 =?us-ascii?Q?nyjKwt5mWpfQwpU0G/6J1ENahRYX9B+DCa2g67I0+IHohTgeswTwR7yqyXuN?=
 =?us-ascii?Q?6xSENs7mw84EvnDGkPrmFBBnGk19tqpIW5XxLUWAtOjTsj3rPnkE8tRzZoeN?=
 =?us-ascii?Q?nCIpTNfIYGD1PCBHnYbSOUvsPOxXxVM59SH8shhIg81pWdplPEVA5AN++UP2?=
 =?us-ascii?Q?LYtAvB/gvrY31KRsjdZ/prpec91JDkrVV5yTshTq4gqq7Ij/qCcyE5/T9aRu?=
 =?us-ascii?Q?Z5cw+ne5JGBZ1irPc8ehAUgp8YLOVXl8kyg2+f/ycxq9lXT29CKjuFedI9Cu?=
 =?us-ascii?Q?A74CoiIATa3zCMi9qYpeXyyGvCeeE+zzQxmGCMWcFWsgG3v7mp4fsbnbOekP?=
 =?us-ascii?Q?aQRLMWn8d9QNTQJbL/RL919kAO6jkeis75FdzYK3NucaKafVUOSXmPnGk01t?=
 =?us-ascii?Q?3v2rrbqYOmIQQql4ymPkP0yyE1HVpEjnBbpvbsrKlXQ0+BHEv332ngDrGJz0?=
 =?us-ascii?Q?n1GsKgYM9T08JGbsZ4xsvsB4jgBwYKMouwf60NO7uHOe/FrKF5lpmDJiweq8?=
 =?us-ascii?Q?enkGSZs+iL672CcQ6X6wvhoDQc4A5ynDzOMVRgI6mJIKNkb9urh8ezy6MV3x?=
 =?us-ascii?Q?6ZeAnrIwVuly2d0Fo+OpGGhnRUbwdTqT4ZN8T5WsnutrghXdKY0Rra5/vFf4?=
 =?us-ascii?Q?AISBBHwIK8q0MtSwKAmM4WeCALufJxouctmCkj6PDLrj0BdOW+3NBrs/3d06?=
 =?us-ascii?Q?U5v5UHgi0QiXWdwHKdJTWKIi4m4AS/6QGOc+ZD+irPfz5b1Y5072OAVmcocP?=
 =?us-ascii?Q?mvIxbTaay0LawGU/r67AHHAZ/4x7leodCqfdXAyIu1NOByGDVe3BRdWbkdSD?=
 =?us-ascii?Q?z6+f273GXZJDMN3B7kI1JhFDB/7H8ZuINrYm7e9+h8u03O4OVPPZAnSJ1Px8?=
 =?us-ascii?Q?crGnIN4+i3FI2TNZ/L2i4X9lgNxlbSuC6yF+FkZABZ6VfCyFVFgRaZhBqb5h?=
 =?us-ascii?Q?IDF7pkYiIbal3jLVxCyufe3hJF3UJ2VjW6PDX/nSXBDL0JnH15+cMuYkoRsd?=
 =?us-ascii?Q?O81ZWhJsikXWxcuBmo8hZfknZyUkkHDb1E1urnqM?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY5PR11MB6187.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 39b9810a-e753-4c4c-453f-08da81a20e71
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Aug 2022 05:17:05.3179
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TI6PnYTsnWVEFWO6FHPjtfcbe1vaL/sPnknDd61/z8y4tBOg23V+96yD5k+Ya6qhJ8yvaNjN/ytSB45+zcoy6g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR11MB1243
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> -----Original Message-----
> From: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> Sent: Monday, August 15, 2022 12:18
> To: Dave Hansen <dave.hansen@linux.intel.com>; Lutomirski, Andy
> <luto@kernel.org>; Peter Zijlstra <peterz@infradead.org>
> Cc: x86@kernel.org; Kostya Serebryany <kcc@google.com>; Andrey Ryabinin
> <ryabinin.a.a@gmail.com>; Andrey Konovalov <andreyknvl@gmail.com>;
> Alexander Potapenko <glider@google.com>; Taras Madan
> <tarasmadan@google.com>; Dmitry Vyukov <dvyukov@google.com>; H . J . Lu
> <hjl.tools@gmail.com>; Andi Kleen <ak@linux.intel.com>; Edgecombe, Rick P
> <rick.p.edgecombe@intel.com>; linux-mm@kvack.org; linux-
> kernel@vger.kernel.org; Zhang, Weihong <weihong.zhang@intel.com>; Kirill =
A .
> Shutemov <kirill.shutemov@linux.intel.com>
> Subject: [PATCHv6 08/11] selftests/x86/lam: Add malloc and tag-bits test =
cases
> for linear-address masking
>=20
> From: Weihong Zhang <weihong.zhang@intel.com>
>=20
> LAM is supported only in 64-bit mode and applies only addresses used for =
data
> accesses. In 64-bit mode, linear address have 64 bits. LAM is applied to =
64-bit
> linear address and allow software to use high bits for metadata.
> LAM supports configurations that differ regarding which pointer bits are
> masked and can be used for metadata.
>=20
> LAM includes following mode:
>=20
>  - LAM_U57, pointer bits in positions 62:57 are masked (LAM width 6),
>    allows bits 62:57 of a user pointer to be used as metadata.
>=20
> There are two arch_prctls:
> ARCH_ENABLE_TAGGED_ADDR: enable LAM mode, mask high bits of a user
> pointer.
> ARCH_GET_UNTAG_MASK: get current untagged mask.
> ARCH_GET_MAX_TAG_BITS: the maximum tag bits user can request. zero if
> LAM is not supported.
>=20
> The LAM mode is for pre-process, a process has only one chance to set LAM
> mode.
> But there is no API to disable LAM mode. So all of test cases are run und=
er child
> process.
>=20
> Functions of this test:
>=20
> MALLOC
>=20
>  - LAM_U57 masks bits 57:62 of a user pointer. Process on user space
>    can dereference such pointers.
>=20
>  - Disable LAM, dereference a pointer with metadata above 48 bit or 57 bi=
t
>    lead to trigger SIGSEGV.
>=20
> TAG_BITS
>=20
>  - Max tag bits of LAM_U57 is 6.
>=20
> Signed-off-by: Weihong Zhang <weihong.zhang@intel.com>
> Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> ---
>  tools/testing/selftests/x86/Makefile |   2 +-
>  tools/testing/selftests/x86/lam.c    | 317 +++++++++++++++++++++++++++
>  2 files changed, 318 insertions(+), 1 deletion(-)  create mode 100644
> tools/testing/selftests/x86/lam.c
>=20
> diff --git a/tools/testing/selftests/x86/Makefile
> b/tools/testing/selftests/x86/Makefile
> index 0388c4d60af0..c1a16a9d4f2f 100644
> --- a/tools/testing/selftests/x86/Makefile
> +++ b/tools/testing/selftests/x86/Makefile
> @@ -18,7 +18,7 @@ TARGETS_C_32BIT_ONLY :=3D entry_from_vm86
> test_syscall_vdso unwind_vdso \
>  			test_FCMOV test_FCOMI test_FISTTP \
>  			vdso_restorer
>  TARGETS_C_64BIT_ONLY :=3D fsgsbase sysret_rip syscall_numbering \
> -			corrupt_xstate_header amx
> +			corrupt_xstate_header amx lam
>  # Some selftests require 32bit support enabled also on 64bit systems
> TARGETS_C_32BIT_NEEDED :=3D ldt_gdt ptrace_syscall
>=20
> diff --git a/tools/testing/selftests/x86/lam.c b/tools/testing/selftests/=
x86/lam.c
> new file mode 100644
> index 000000000000..4c6c6dbf7db6
> --- /dev/null
> +++ b/tools/testing/selftests/x86/lam.c
> @@ -0,0 +1,317 @@
> +// SPDX-License-Identifier: GPL-2.0
> +#include <stdio.h>
> +#include <stdlib.h>
> +#include <string.h>
> +#include <sys/syscall.h>
> +#include <time.h>
> +#include <signal.h>
> +#include <setjmp.h>
> +#include <sys/mman.h>
> +#include <sys/wait.h>
> +#include <inttypes.h>
> +
> +#include "../kselftest.h"
> +
> +#ifndef __x86_64__
> +# error This test is 64-bit only
> +#endif
> +
> +/* LAM modes, these definitions were copied from kernel code */
> +#define LAM_NONE                0
> +#define LAM_U57_BITS            6
> +/* arch prctl for LAM */
> +#define ARCH_GET_UNTAG_MASK     0x4001
> +#define ARCH_ENABLE_TAGGED_ADDR 0x4002
> +#define ARCH_GET_MAX_TAG_BITS   0x4003
> +
> +/* Specified test function bits */
> +#define FUNC_MALLOC             0x1
> +#define FUNC_BITS               0x2
> +
> +#define TEST_MASK               0x3
> +
> +#define MALLOC_LEN              32
> +
> +struct testcases {
> +	unsigned int later;
> +	int expected; /* 2: SIGSEGV Error; 1: other errors */
> +	unsigned long lam;
> +	uint64_t addr;
> +	int (*test_func)(struct testcases *test);
> +	const char *msg;
> +};
> +
> +int tests_cnt;
> +jmp_buf segv_env;
> +
> +static void segv_handler(int sig)
> +{
> +	ksft_print_msg("Get segmentation fault(%d).", sig);
> +	siglongjmp(segv_env, 1);
> +}
> +
> +static inline int cpu_has_lam(void)
> +{
> +	unsigned int cpuinfo[4];
> +
> +	__cpuid_count(0x7, 1, cpuinfo[0], cpuinfo[1], cpuinfo[2], cpuinfo[3]);
> +
> +	return (cpuinfo[0] & (1 << 26));
> +}
> +
> +/*
> + * Set tagged address and read back untag mask.
> + * check if the untagged mask is expected.
> + */
> +static int set_lam(unsigned long lam)
> +{
> +	int ret =3D 0;
> +	uint64_t ptr =3D 0;
> +
> +	if (lam !=3D LAM_U57_BITS && lam !=3D LAM_NONE)
> +		return -1;
> +
> +	/* Skip check return */
> +	syscall(SYS_arch_prctl, ARCH_ENABLE_TAGGED_ADDR, lam);
> +
> +	/* Get untagged mask */
> +	syscall(SYS_arch_prctl, ARCH_GET_UNTAG_MASK, &ptr);
> +
> +	/* Check mask returned is expected */
> +	if (lam =3D=3D LAM_U57_BITS)
> +		ret =3D (ptr !=3D ~(0x3fULL << 57));

[Hu, Robert]=20
Any special reason not "bool ret"?

> +	else if (lam =3D=3D LAM_NONE)
> +		ret =3D (ptr !=3D -1ULL);
> +
> +	return ret;
> +}
> +
> +static unsigned long get_default_tag_bits(void) {
> +	pid_t pid;
> +	int lam =3D LAM_NONE;
> +	int ret =3D 0;
> +
> +	pid =3D fork();
> +	if (pid < 0) {
> +		perror("Fork failed.");
> +		ret =3D 1;
[Hu, Robert]=20
In this fault case, at last you "return lam", which inited as 0, not your i=
ntended "ret".

> +	} else if (pid =3D=3D 0) {
> +		/* Set LAM mode in parent process */
[Hu, Robert]=20
pid =3D=3D 0 is child process?

> +		if (set_lam(LAM_U57_BITS) =3D=3D 0)
> +			lam =3D LAM_U57_BITS;
> +		else
> +			lam =3D LAM_NONE;
> +		exit(lam);
> +	} else {
> +		wait(&ret);
> +		lam =3D WEXITSTATUS(ret);
> +	}
> +
> +	return lam;
> +}
> +
> +/* According to LAM mode, set metadata in high bits */ static uint64_t
> +get_metadata(uint64_t src, unsigned long lam) {
[Hu, Robert]=20
This function looks like not "get metadata", but "embed metadata" to canoni=
cal address.
Naming looks confusing. Perhaps embed_metadata()?

> +	uint64_t metadata;
> +
> +	srand(time(NULL));
> +	/* Get a random value as metadata */
> +	metadata =3D rand();
> +
> +	switch (lam) {
> +	case LAM_U57_BITS: /* Set metadata in bits 62:57 */
> +		metadata =3D (src & ~(0x3fULL << 57)) | ((metadata & 0x3f) <<
[Hu, Robert]=20
Looks like "0x3fULL << 57" is frequently used across LAM selftests, why not=
 name a macro
for it?

> 57);
> +		break;
> +	default:
> +		metadata =3D src;
> +		break;
> +	}
> +
> +	return metadata;
> +}
> +
> +/*
> + * Set metadata in user pointer, compare new pointer with original point=
er.
> + * both pointers should point to the same address.
> + */
> +static int handle_lam_test(void *src, unsigned int lam) {
> +	char *ptr;
> +
> +	strcpy((char *)src, "USER POINTER");
> +
> +	ptr =3D (char *)get_metadata((uint64_t)src, lam);
> +	if (src =3D=3D ptr)
> +		return 0;
> +
> +	/* Copy a string into the pointer with metadata */
> +	strcpy((char *)ptr, "METADATA POINTER");
> +
> +	return (!!strcmp((char *)src, (char *)ptr)); }
[Hu, Robert]=20
Why "!!" here? now that function return type is int and strcmp() returns in=
t.

> +
> +
> +int handle_max_bits(struct testcases *test) {
> +	unsigned long exp_bits =3D get_default_tag_bits();
> +	unsigned long bits =3D 0;
> +
> +	if (exp_bits !=3D LAM_NONE)
> +		exp_bits =3D LAM_U57_BITS;
> +
> +	/* Get LAM max tag bits */
> +	if (syscall(SYS_arch_prctl, ARCH_GET_MAX_TAG_BITS, &bits) =3D=3D -1)
> +		return 1;
> +
> +	return (exp_bits !=3D bits);
> +}
> +
> +/*
> + * Test lam feature through dereference pointer get from malloc.
> + * @return 0: Pass test. 1: Get failure during test 2: Get SIGSEGV  */
> +static int handle_malloc(struct testcases *test) {
> +	char *ptr =3D NULL;
> +	int ret =3D 0;
> +
> +	if (test->later =3D=3D 0 && test->lam !=3D 0)
> +		if (set_lam(test->lam) =3D=3D -1)
> +			return 1;
> +
> +	ptr =3D (char *)malloc(MALLOC_LEN);
> +	if (ptr =3D=3D NULL) {
> +		perror("malloc() failure\n");
> +		return 1;
> +	}
> +
> +	/* Set signal handler */
> +	if (sigsetjmp(segv_env, 1) =3D=3D 0) {
> +		signal(SIGSEGV, segv_handler);
> +		ret =3D handle_lam_test(ptr, test->lam);
> +	} else {
> +		ret =3D 2;
> +	}
> +
> +	if (test->later !=3D 0 && test->lam !=3D 0)
> +		if (set_lam(test->lam) =3D=3D -1 && ret =3D=3D 0)
> +			ret =3D 1;
> +
> +	free(ptr);
> +
> +	return ret;
> +}
> +
> +static int fork_test(struct testcases *test) {
> +	int ret, child_ret;
> +	pid_t pid;
> +
> +	pid =3D fork();
> +	if (pid < 0) {
> +		perror("Fork failed.");
> +		ret =3D 1;
> +	} else if (pid =3D=3D 0) {
> +		ret =3D test->test_func(test);
> +		exit(ret);
> +	} else {
> +		wait(&child_ret);
> +		ret =3D WEXITSTATUS(child_ret);
> +	}
> +
> +	return ret;
> +}
> +
> +static void run_test(struct testcases *test, int count) {
> +	int i, ret =3D 0;
> +
> +	for (i =3D 0; i < count; i++) {
> +		struct testcases *t =3D test + i;
> +
> +		/* fork a process to run test case */
> +		ret =3D fork_test(t);
> +		if (ret !=3D 0)
> +			ret =3D (t->expected =3D=3D ret);
> +		else
> +			ret =3D !(t->expected);
> +
> +		tests_cnt++;
> +		ksft_test_result(ret, t->msg);
> +	}
> +}
> +
> +static struct testcases malloc_cases[] =3D {
> +	{
> +		.later =3D 0,
> +		.lam =3D LAM_U57_BITS,
> +		.test_func =3D handle_malloc,
> +		.msg =3D "MALLOC: LAM_U57. Dereferencing pointer with
> metadata\n",
> +	},
> +	{
> +		.later =3D 1,
> +		.expected =3D 2,
> +		.lam =3D LAM_U57_BITS,
> +		.test_func =3D handle_malloc,
> +		.msg =3D "MALLOC:[Negtive] Disable LAM. Dereferencing pointer
> with metadata.\n",
> +	},
> +};
> +
> +
> +static struct testcases bits_cases[] =3D {
> +	{
> +		.test_func =3D handle_max_bits,
> +		.msg =3D "BITS: Check default tag bits\n",
> +	},
> +};
> +
> +static void cmd_help(void)
> +{
> +	printf("usage: lam [-h] [-t test list]\n");
> +	printf("\t-t test list: run tests specified in the test list, default:0=
x%x\n",
> TEST_MASK);
> +	printf("\t\t0x1:malloc; 0x2:max_bits;\n");
> +	printf("\t-h: help\n");
> +}
> +
> +int main(int argc, char **argv)
> +{
> +	int c =3D 0;
> +	unsigned int tests =3D TEST_MASK;
> +
> +	tests_cnt =3D 0;
> +
> +	if (!cpu_has_lam()) {
> +		ksft_print_msg("Unsupported LAM feature!\n");
> +		return -1;
> +	}
> +
> +	while ((c =3D getopt(argc, argv, "ht:")) !=3D -1) {
> +		switch (c) {
> +		case 't':
> +			tests =3D strtoul(optarg, NULL, 16);
> +			if (!(tests & TEST_MASK)) {
> +				ksft_print_msg("Invalid argument!\n");
> +				return -1;
> +			}
> +			break;
> +		case 'h':
> +			cmd_help();
> +			return 0;
> +		default:
> +			ksft_print_msg("Invalid argument\n");
> +			return -1;
> +		}
> +	}
> +
> +	if (tests & FUNC_MALLOC)
> +		run_test(malloc_cases, ARRAY_SIZE(malloc_cases));
> +
> +	if (tests & FUNC_BITS)
> +		run_test(bits_cases, ARRAY_SIZE(bits_cases));
> +
> +	ksft_set_plan(tests_cnt);
> +
> +	return ksft_exit_pass();
> +}
> --
> 2.35.1

