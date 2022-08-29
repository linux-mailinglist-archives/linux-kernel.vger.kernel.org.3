Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2BD25A56B2
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 00:05:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229775AbiH2WFr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Aug 2022 18:05:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229561AbiH2WFp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Aug 2022 18:05:45 -0400
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD7FF33E09;
        Mon, 29 Aug 2022 15:05:43 -0700 (PDT)
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
        by m0001303.ppops.net (8.17.1.5/8.17.1.5) with ESMTP id 27TKdrJs024754;
        Mon, 29 Aug 2022 15:05:42 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : mime-version; s=facebook;
 bh=ZcYmNFLxXsRWF4znixJUyLr3Q0wc/lyozG3+ZPl9yJ4=;
 b=greskHZZT/pA/p+wjTXpeyGmNzF6vN9B5fHEbLcPYXT5gn8sbvJqcxnVR0uBR5Bqvgo0
 5X7H7ambJEJ0lY6P5xO6+jVhu2orogNwGVywredfhalMqF+4p5P5kM8bnc7qq8Fulw8v
 QNO3TGuHpJldSE08SgnRYkTrcXhDmxdNMnI= 
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2175.outbound.protection.outlook.com [104.47.56.175])
        by m0001303.ppops.net (PPS) with ESMTPS id 3j7exyd1x8-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 29 Aug 2022 15:05:42 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XYec2DwJpeKBcfxkDABbb+swgPesZAlaAT8m4xAvi/NHggl+tyZTkv1e3PohgZXQqhX8hwIgQPgwrxnmJneW893rlcB5xJzqP4HxIX2vWOKv4czI2iXaP+gsMLq1UnOvVndb1EXbpWkfNAKqb/gGjeFCM6Fcvh2KUrQzxjhS6D80XWSz1e5i08oZt7MB9eskt8105aJVNkq5P1uPX9gwFZu+ki+VoOONbqQUDkbw0cfKeF8bFTJ3fHtTjN3rauaDE59ghCO3KcAywCs5Q75zZKS92YMIVloXTMaE7buBHiAHXE9XzavFUQItimi/vMVQsMiI7WSwKS3qLxgmnozWFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZcYmNFLxXsRWF4znixJUyLr3Q0wc/lyozG3+ZPl9yJ4=;
 b=Cyyj4K6/bvKnILMfQrK/7KdgyK6E0mUSkpgDxRYGegjekLfp/XsPP2oUEcFNZV3fJNYJbXWTGoP8IzudeNRtvJmIpDoZ4BUGfE2IHb91J9Cf/vwXBR/OKR02/vx3qGqEoqbysziw03z7XkLZsnmgj/+K1FhU2hmmpOUyJ0IuNkNXahw1ZPIjv1c890TmTvpyVouvFxmUZayehHhLTnSpIbm6ZZFChlhJoAerSUmeaBjpnuISPW+ZFGKFhTiaiXsyX48FYqKyhdus3iT1K6SLW3Z+GfI5bzGTsW65zYa0/GErac5AK2EFI+uM4UeXNnhXvMx6iKWJnSEBys14JARYKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from CY4PR15MB1781.namprd15.prod.outlook.com (2603:10b6:910:1f::13)
 by DM6PR15MB2921.namprd15.prod.outlook.com (2603:10b6:5:144::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.19; Mon, 29 Aug
 2022 22:05:06 +0000
Received: from CY4PR15MB1781.namprd15.prod.outlook.com
 ([fe80::351d:e6bc:a9e4:4118]) by CY4PR15MB1781.namprd15.prod.outlook.com
 ([fe80::351d:e6bc:a9e4:4118%12]) with mapi id 15.20.5566.021; Mon, 29 Aug
 2022 22:05:06 +0000
From:   "Alex Zhu (Kernel)" <alexlzhu@fb.com>
To:     Bagas Sanjaya <bagasdotme@gmail.com>,
        "corbet@lwn.net" <corbet@lwn.net>
CC:     "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Kernel Team <Kernel-team@fb.com>
Subject: Re: [PATCH v4] docs: admin-guide/mm: Improve grammar on MM concepts
 documentation
Thread-Topic: [PATCH v4] docs: admin-guide/mm: Improve grammar on MM concepts
 documentation
Thread-Index: AQHYtpbbdCVpzKzPj0aoefkHiWC7Zq27zP0AgAqsnoA=
Date:   Mon, 29 Aug 2022 22:05:06 +0000
Message-ID: <1A48A718-5327-4D76-8D4D-1058B341220B@fb.com>
References: <20220823021941.4021897-1-alexlzhu@fb.com>
 <a2d5343b-a159-3e6a-67f8-868e85f51222@gmail.com>
In-Reply-To: <a2d5343b-a159-3e6a-67f8-868e85f51222@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 644c3e47-8173-4c66-1a17-08da8a0a8829
x-ms-traffictypediagnostic: DM6PR15MB2921:EE_
x-fb-source: Internal
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: af+GWCTkdfSzx1EXwTMjsdWeekoNK8nBFOTkPF7dxa1ZANugwYfo6XwQqUXYj98P7A/P0i2XCO6i7Hys0Nppb8WLKFcfnyZwBJTdpRGVo+3q+RZRNCBBCxY21w1AO1hK3Lc5zah1SNxcEEdkX2kpVPomEky48u4ssVAcv9LjzO934Jc3eDt/ZYrXE6nIa5fWPMNE1mqqChw5xGfEG/QWlGEvNlLYdQzPwNTJU9QOKMaK7ptCU+ubBJ6hF7P4a8TSqRaZfBC5aSFXKXMfC0k+xkXMd7adbow9u9t2z2jIyWpN6fROS3/Lv9u2gIbmM8Fi0c2a4yqukwAEMpWq12EZ9Sb4eZ6SJHOtNRbTHOuxdjCXWqWLTphFG/sOMJyUmY3fKY1ViaPuDAubV6SXf4CXjyjYaSwP8I5FapAK7kNzxAozbNfNPbrCLeZ02GNP+MkXT7U43z1PNX0uccioz6REm9CkwaYAcMWxx2q5sJ2Z7l360fI5jjTKy1vuMrcrH9WFKLYkcBEmKzG2JAv+L7ThmUYlobG/kupgeGcLOCqzx+t227ZZHNgK9ermhaafz7g0Mj1nXQ499uDKw47aFzIYGWlHPoiPGuWsl+q8Mwqwx3kkFF3Dj56TWh+OwNinqGJASNxbWTRuPzRe9we3l2ojTjgPxxGeg7oAsjwar+hzb3PARcBy99F4f+GdmwObKhQcyIbklqua91yc5ve2pHuZUci63Ozeb3/PPLwvRQu8chvsOLcHYYLf0+iUndQFB+B5uedHr8K8Q4p+8i3CARClRDymmJYKeNu4v9u/XsTmTqw=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR15MB1781.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(396003)(346002)(376002)(136003)(366004)(39860400002)(186003)(41300700001)(6486002)(478600001)(2616005)(2906002)(4326008)(53546011)(33656002)(6512007)(86362001)(6506007)(71200400001)(36756003)(8676002)(110136005)(4744005)(64756008)(66446008)(54906003)(66556008)(38070700005)(66476007)(91956017)(8936002)(76116006)(66946007)(5660300002)(316002)(38100700002)(122000001)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?AbixmuwuVyJAA+KvvWbx8uSPQi/VOIqBDemmSD2SZ1NVRBVXuelU5wXxKOzT?=
 =?us-ascii?Q?Si4xXX0wAU507XK156eVrWODDmOAHLpEOe4dQvTVwm6PejLV9+0GA9cpEGsq?=
 =?us-ascii?Q?p4HC1/zJplJRVaD/wVA4gVGg6Q0Q6wm9AqO4QXYr+YYXD1zT/+6K+3f+zgHb?=
 =?us-ascii?Q?M0BVeL+vtdY9dPyyzGWRMBUDIhx0lCgm2+DAj94JdJo0k0vZQWshKANAXEDj?=
 =?us-ascii?Q?d345vkL9An8PCtMZqsaGd1mFQSlLoJi428kyItbSFJtY2oh1RNhQrh0UNVKF?=
 =?us-ascii?Q?iyDAKXM/fPSFkpXKOczvnNUGWeMscj0tywJYe9sLk2NuQ7bxN6OCynprrmFF?=
 =?us-ascii?Q?ckj+inrLBTsHhHtqDa9m6SYdmuwKw3w/BHnXoMTxoMIlBDWfGDm3dP8xaUkM?=
 =?us-ascii?Q?94yg/foBzBJcQInY5ePYZV9/+8BcQQMqVECttni2wjBvd1CeEombTgkvrygL?=
 =?us-ascii?Q?JfqxJpUawIH7XNMtaDo88f0YUyGeOtejdkJN9Z4QsVz2sXGgKXmQg2OZVEPh?=
 =?us-ascii?Q?tYUOu7J/lFQbTPzk6x6PISgelsbOgEBUZDucI+yWK9oTY5myIT1Zycb/A/cN?=
 =?us-ascii?Q?n4Aii3I7NupTlSsBLaqcgIGN8ihf0R9snxoUfR6V0aTUoHmbdjym/dKCG+fi?=
 =?us-ascii?Q?um4NSFdsapVUCJKhAHFpGww1YUVxD3zjQLxD6BJkaM0TUCzuIqa18fLgyPtw?=
 =?us-ascii?Q?7rKQJT1SZClY13XoLAdEWIOuSat0fhQNbRUdggDR4E2HV8pG7rQP1jXgwCyN?=
 =?us-ascii?Q?8YLGEkLByobczLH4jxjK70+iNEEtQxuoD9dAP41hwkkQdzWUhnjq4Ahkldl0?=
 =?us-ascii?Q?uYY99eRDsmKzaTcBjnRuOgeuolTNx92jIMF5sY5MzJ1Hh53XafDstbDnM2nS?=
 =?us-ascii?Q?yJSBVOs61UR7+pG+G5IyNdi5PWJkU9idymbBy13ws1eElrqvnDcDdFCK4VJ7?=
 =?us-ascii?Q?LE5/ttoe+9XqrgwKEm9dE/IODsytZdTpFnSc8VXE+1zFnzpmoIaPrCQO/9WR?=
 =?us-ascii?Q?JgHV4A4DHuWcWYge6NpQT8AKR3hq9lyPLSMyKUVWI7wGwxg1HDQ591b/AN1K?=
 =?us-ascii?Q?ItzEXW1wV30A5gUo5cUaT0eSyAFQI03talcUWfpeR2c8dVkerO9fbqKWR2uv?=
 =?us-ascii?Q?knv8vbF6yP8Ysri7NRu9FWG+nw5hBz0b0QQYvqLsBrv0qOt6toIjG+pVzRgw?=
 =?us-ascii?Q?0onbiYE896ECU0CYymocuckfjWCdoVrrvOYpXEk687dpskaprNpJ6vSIyesx?=
 =?us-ascii?Q?yZPVQ+wUFMLXdBGqQtnxtcoe0PGkv/0PI1n4sUA3FJT2TrkzjgM/2HXyo31A?=
 =?us-ascii?Q?UqIVTCWVUTZAky6w1lMrcJA083SYNl4QNZB9yx31KIg/Wm3eQhGjWTwHzjnP?=
 =?us-ascii?Q?LZFNaSFOZQLa06lJELNI8pPm01buYizFedMQw3rpADJNidgrqcLrW27hN+w7?=
 =?us-ascii?Q?XOBy/N7IMWtkndYNUCX+DUk0RWCCVD2BcwuSN3TwPBzq3IQqgypJGXAfuRlm?=
 =?us-ascii?Q?lOQJNrpAzsAp/uZiYLOb2GupnJUBGzi86BGgGydICFYMeHTeo/W8axY9xGFz?=
 =?us-ascii?Q?p9Hto+0DdU8WXkR6wcU+ozRaxBsA7QRd1yyH13vp2xRQxc40JfdFkJH3MkcH?=
 =?us-ascii?Q?NmV+0kM/OoHkJ3taxlY6e7g=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <71B09078C4BFD341B357E4B3FF121A39@namprd15.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: fb.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY4PR15MB1781.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 644c3e47-8173-4c66-1a17-08da8a0a8829
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Aug 2022 22:05:06.4891
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: utMpWnfVKYtnX1bJL08RN9Uh0+o9JANQUuyWcWRzhB7kF3W6iH1XqWyBdarDoeA3
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR15MB2921
X-Proofpoint-GUID: 7vqOGNQjBl1MeVadHK3dnDSZRlNE26iD
X-Proofpoint-ORIG-GUID: 7vqOGNQjBl1MeVadHK3dnDSZRlNE26iD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-29_11,2022-08-25_01,2022-06-22_01
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Aug 22, 2022, at 8:04 PM, Bagas Sanjaya <bagasdotme@gmail.com> wrote:
> 
> On 8/23/22 09:19, alexlzhu@fb.com wrote:
>> From: Alexander Zhu <alexlzhu@fb.com>
>> 
>> Improve grammar on MM concepts documentation.
>> 
>> Signed-off-by: Alexander Zhu <alexlzhu@fb.com>
>> ---
>> Changelog: 
>> 
>> Changes in v4:
>> -Adjust changelog to be below the dashes
>> 
>> Changes in v3:
>> -Correct punctuation based on previous comment
>> 
>> Changes in v2:
>> -Correct the subject
>> -Adjust the description
>> 
> 
> Nicely done. LGTM.
> 
> Reviewed-by: Bagas Sanjaya <bagasdotme@gmail.com>
> 
> -- 
> An old man doll... just what I always wanted! - Clara

