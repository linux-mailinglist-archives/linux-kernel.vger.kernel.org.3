Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26E8458DCEE
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Aug 2022 19:16:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242637AbiHIRQB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Aug 2022 13:16:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237621AbiHIRPw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Aug 2022 13:15:52 -0400
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E58B31135
        for <linux-kernel@vger.kernel.org>; Tue,  9 Aug 2022 10:15:51 -0700 (PDT)
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
        by m0089730.ppops.net (8.17.1.5/8.17.1.5) with ESMTP id 2799864c027838
        for <linux-kernel@vger.kernel.org>; Tue, 9 Aug 2022 10:15:51 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : mime-version; s=facebook;
 bh=W8GWFJwaX64mgbo2q4i/mvfFPlKpe9yHPzp+nn8L1nM=;
 b=qShNvwJDjYPwndZmwe8MX28wPgVVeRfwnsZjRH5snpSUo3W2XVaLLcnCFZuVbXpLcf3B
 lsBcrG6D+0VkxJwPBDh5uc4RNoCM2RfTsVsho8hejwxTu+jWVtk9ykpS/XYyENfNLF/V
 cHgH1rX2ivk74oCr91BGen6eJdEyZAqWJaM= 
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2109.outbound.protection.outlook.com [104.47.55.109])
        by m0089730.ppops.net (PPS) with ESMTPS id 3hump6ug5r-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Tue, 09 Aug 2022 10:15:51 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F/2CawvOJrVki28MXjMymJoANvgC9bFMCug7lpHCc1hOgIZcQFXmerqyyd7VsQruWPUceJ1q49t0IICg0Otf83pYo1cf4PXQCk80cP4iJ+UMdEY/0devUnwvr7zG7TTib9fUnAUWvvr1NT6/z7IVQgqzldfwj84b1wSHbMLRyx/pqzkANQHLfvObrbVlkXImKhNrg4ks7T9/EUIJjQpcpsKxMpfrjiSSRHZueERGXAUe5ju8p9lbE2+ITUwMKfLhWPwMev+MMY6qNYVjblVpBos4IXAgqItga8egwgQMkeRLtw+2QhyzBEERB7L2xZsRB9d0EpF4c3SKhlpsHRazqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W8GWFJwaX64mgbo2q4i/mvfFPlKpe9yHPzp+nn8L1nM=;
 b=KZxp/KMPIrrBS5lqJiY3rUHgA4dfQhW5kwWnS8hCX1TSX8UrNQDKEwtLzlgXIwFoWcZO1hbPtM7HhdpPKUeKhulOEnQf57sH8IILVl1/aN55VuDOAVDUZwBwz3YAqSfTjy8B/NJM1uQr5NZ5RmT26af7pR1FjC27SsK+t8Wk6adC3jZhRldBbEJLafjuSBRw10L5uTTbOEfW96dS6rCWd1kjU4SqbuKE2Ixj43UbJOIc1HH7TKXVicYsoufM7kyOtOIqdWDFuS1ZRt8Q0MQ5BQhwqhBxVXDDQ4WZT6GEP0Y0uj0iSkyjKRJ+nQ1vZvHInKwTaMaWbt+WwnjdOql4Rg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from CY4PR15MB1781.namprd15.prod.outlook.com (2603:10b6:910:1f::13)
 by BYAPR15MB2805.namprd15.prod.outlook.com (2603:10b6:a03:14e::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5525.10; Tue, 9 Aug
 2022 17:15:47 +0000
Received: from CY4PR15MB1781.namprd15.prod.outlook.com
 ([fe80::351d:e6bc:a9e4:4118]) by CY4PR15MB1781.namprd15.prod.outlook.com
 ([fe80::351d:e6bc:a9e4:4118%12]) with mapi id 15.20.5504.020; Tue, 9 Aug 2022
 17:15:47 +0000
From:   "Alex Zhu (Kernel)" <alexlzhu@fb.com>
To:     Yang Shi <shy828301@gmail.com>
CC:     Rik van Riel <riel@fb.com>, Kernel Team <Kernel-team@fb.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "willy@infradead.org" <willy@infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>
Subject: Re: [PATCH v3] mm: add thp_utilization metrics to
 /proc/thp_utilization
Thread-Topic: [PATCH v3] mm: add thp_utilization metrics to
 /proc/thp_utilization
Thread-Index: AQHYqPrSmG3WqzybNUurgyMbb9mveq2gpnsAgAAD8ACAAAWRgIAAB5EAgASWfICAAAsqAIABevqAgAABMAA=
Date:   Tue, 9 Aug 2022 17:15:47 +0000
Message-ID: <1F8B9D85-A735-4832-AD58-CA4BD474248D@fb.com>
References: <20220805184016.2926168-1-alexlzhu@fb.com>
 <Yu1mcD6Jp4fCVEMi@casper.infradead.org>
 <0b16dbac6444bfcdfbeb4df4280354839bfe1a8f.camel@fb.com>
 <Yu1uabedm+NYnnAj@casper.infradead.org>
 <CA8C72B6-E509-4FB0-BEAA-C4368EB7A419@fb.com>
 <CAHbLzkp27aP4JYLPLzv2vtyzVe63bkhuZhw1jnxTF1Buvt4rew@mail.gmail.com>
 <fc108f58a4616d5d7d092a7c1f150069a92ee40c.camel@fb.com>
 <CAHbLzkqpn2ExBJuPD8sYJrEDCUU9=FE3GFh8kL3Bmax0KytKPw@mail.gmail.com>
In-Reply-To: <CAHbLzkqpn2ExBJuPD8sYJrEDCUU9=FE3GFh8kL3Bmax0KytKPw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: bf5979b6-1b00-439c-d31f-08da7a2acd0f
x-ms-traffictypediagnostic: BYAPR15MB2805:EE_
x-fb-source: Internal
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: SHC9P6Occ41B4j+FtbIrMYzgZOXT+fmsNmhpPzY6xhVeMMsKcbwFC79hxgAuFFTuowKTGHVYqXzOmQWLeRyBSco5zyfUJT9iDeJBuYr1h4yhJ0u1oJVSdto0cIbTjV6Przq739U97CvDt/RIrXyC/5Hx/qON/zruc5nH2Tt10N64dKeKuTBChiYVreMEjnP6S1ALsR6ph7zEFob8WM2qHGbkR3DCcdrM2GKOiSiVjdavcrj3ryHKysSWbLTg0dKA/OEh+g1zDB2aFkiyeKEofDm9+Xte16mm+LzbPZsseSeZj+xcU3VE2udW7M6oU82ttoYjoU62av5V3FQHnT8t2UhQor50uBzaNiYJSItJf3A95l56thpdn629WhzPU/izUzWINwifr3FVDOyguVtmJyHmBCe+M8B7N4HWc94/qKHLCW92DHcNIhrNdeFZn9D8dQ9N+e78ok7aahdWhkEx/iuysJ/c9QAstvipj8U1LDWnYY0OFG05SUDfQT3XHXqNuVZHyWrnvUcQMplhrvxcghrM5QE6ZAPwpcM8VaoyxobxWEx2tvhLMPd5ccPTVDvnb+5EpXOnUeoG32l9dsMElmQd9ziZ9ula4wBBmHlAEpBSQFldkEEwnKVjANnl6UaID6WlkgsBJCQIpjsXhXjz9V4VQ4Vz0Zw4KFnEywUMCvw+ieWzS5bVBRpLhfYozIiD7k1hfR4vmc71OUyA2jV9YAiH/OBX0h19jA3KDwfA1WxgNzob2YY6inw+KxnvEqxiPwN6JrIkY7BZoZpe+iXxdy8qJlSq4+oL788jxLbZuUX54l9PfOn2bJfIESHGgB11P9CI4fNNN+Gk/cTufJIRTA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR15MB1781.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(346002)(396003)(39860400002)(366004)(136003)(376002)(8676002)(66446008)(66476007)(478600001)(4744005)(66946007)(91956017)(64756008)(122000001)(71200400001)(36756003)(8936002)(66556008)(76116006)(38100700002)(316002)(54906003)(6916009)(41300700001)(5660300002)(2906002)(4326008)(6486002)(33656002)(186003)(6506007)(2616005)(83380400001)(6512007)(86362001)(38070700005)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?DgRZjDAfd86pLpHMX+/pOcwjuIrR7dSPsbIqC5hMlZ0fUsLB2A0fWjUFERE8?=
 =?us-ascii?Q?6o1n4TK4teZsnFasTxFE8BcosVvzio8d/U2chWj7jUqS1Ls/PfZGCZ/RaL8F?=
 =?us-ascii?Q?1llO1wWT+JG4wdbo9Sv6IIR+COao+m6WbZIhOvvQ0jSinpHQ4BI42tXY7DNI?=
 =?us-ascii?Q?nNGKwq1+MHe80CVR8wgvpfwVIj5bRYaOOOlQkVXtJM4j4eKoHnojOOON6F4t?=
 =?us-ascii?Q?IZZ7L5M7ZidD77GNJunHUno9f6z917SteVb3dzH4ZQzPFhuLGse+LnPdz5zr?=
 =?us-ascii?Q?WRutqp9OyPC3gmZwa4NmIAMzymw77GcbqtgOt0L3I4abOYd+N9W98U/RLrCQ?=
 =?us-ascii?Q?RmsAE4vr/4Q6R6nvBH+gIPai9Qrj+XnlAIqrUELxiDgrZhLHrA1sdi5f2lp0?=
 =?us-ascii?Q?tNwuCtE3NKp3OKDyxy4w9VZqerhFUNDGZP3tFeWM99qk+vALNImNauyKLZIl?=
 =?us-ascii?Q?wANfa4050Lu7+8hbwN849fF18vVK54Qy/BNhhYPImZZJRTCB4mxhiE0JKHU2?=
 =?us-ascii?Q?pyDMAcq3KQ9RT4lE2VVxR4gDasSbWKUNT1rLEDvcGDFIs7YbGSBnKZfrRofH?=
 =?us-ascii?Q?c5lqvADIDMaqVSepG/yI/x++vAG786x/Aefj67rWW0fpf89TAoAP8f7SAdQi?=
 =?us-ascii?Q?8bjvdzRzC9qiNpWS6HbDrQmNnJZIEsdJefV/lTd/walK2ObWUwWhin6nR1ui?=
 =?us-ascii?Q?oFsQEdFVRXynCKClaA+8rnI8rFZ0Jbu0zDv/DCrd5FquY8MWkvWOaUJcStzt?=
 =?us-ascii?Q?LzRG4HT6l0MmhmpGgjT93uazuZ5jbwla+NflC1rOWQihref6qfZMLy6FLKTK?=
 =?us-ascii?Q?N40I6T6Z1ZuKv4riI5DMb2MHl/vEAsqKEIqNTIwI1i6Z7sG+eC8K8vb/Euyj?=
 =?us-ascii?Q?5vXxrhYwSXugSc1vOIbxk5aR3HvExheSugCRQ8R9PmbDs5q+mcenhAOAde2j?=
 =?us-ascii?Q?ScEzJjhzlGDZq2gJYLQlukmGiCz8VWhY4O1gvzfIxd9ASKgFxCDDWx3Dr7LF?=
 =?us-ascii?Q?Xz0g+Nr+2j+NGJP0ebVl04R3rWR38YD1HGCrJU7umDMo82JPOmkVdrpVSbdy?=
 =?us-ascii?Q?XiCzZeG0jppB07nnxOL0rVYo/ayzuYf3FQMtIayqRblG7VTiIfWuhdSOPdoU?=
 =?us-ascii?Q?8Zmg880HuH0yZvG7BQgO75QkGRJqOn53S9IhFF6In52KkLp9+EPhPBDsbfYY?=
 =?us-ascii?Q?QR1MC6dFeBzAdti8RqM750Iv/m/cLtD2jL/HHkwJINwkDr5mm2LV/OuilB7s?=
 =?us-ascii?Q?nf/TcsDOJZd9hzqjebZ247Jyi2b0Ae6K7XkEVgrCpSbkULvnU2OTX6rYKaDq?=
 =?us-ascii?Q?5MESRZFK3vKzTqokyes0mQOpRpTyQVSF5jxJS9i0PYrsWVpRajrZao6K1us1?=
 =?us-ascii?Q?SmX79xhys/4CGag3qAEleTIDUxENdCy/FE/7aProQnY8Kh2DdhUotSmr4tfQ?=
 =?us-ascii?Q?jWEHkyHl8a5uPFit1AA1QMYkIvnd7sZwtZ+9BJGdnRQ2QABrf3FgSmXSzmuf?=
 =?us-ascii?Q?KVHd10xCSx7vO81DPlvYUfy1MfFbR7AEgeA7mHcefUVdfoNlKMys4tERcPkK?=
 =?us-ascii?Q?M2JD90qs3KYb5VvrYbU8utO02+Xbpja5pOTB+jXVqBTbFCOnqfabC4fMUx9l?=
 =?us-ascii?Q?emRtHV/gDsZW5PN6Jmr4zBg=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <8E18FCD70DFE004CAF4A0FA9AA8817D8@namprd15.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: fb.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY4PR15MB1781.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bf5979b6-1b00-439c-d31f-08da7a2acd0f
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Aug 2022 17:15:47.3771
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xHKH0qDgWy9kxianIm8tAQJfGz123qJfE2x1WUTMldFWXZ2cAcqphtddpPfchqiP
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2805
X-Proofpoint-GUID: fokOhcRVTubSa2fxwiiT6Fq4P7JBiIjb
X-Proofpoint-ORIG-GUID: fokOhcRVTubSa2fxwiiT6Fq4P7JBiIjb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-09_05,2022-08-09_02,2022-06-22_01
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> OK, it is hard to tell what it looks like now. But the THPs on the
> deferred split list may be on the "low utilization split" list too?
> IIUC the major difference is to replace zero-filled subpage to special
> zero page, so you implemented another THP split function to handle it?
> 
> Anyway the code should answer the most questions.

They can indeed end up on both lists. This did have to be handled when 
implementing the shrinker. 

We free the zero filled subpages, while modifying the existing split_huge_page()
function. Will follow up that change in another patch. 

