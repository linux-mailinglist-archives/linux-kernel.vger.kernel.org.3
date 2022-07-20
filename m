Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5196D57B4B5
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jul 2022 12:45:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231722AbiGTKpp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jul 2022 06:45:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229644AbiGTKpm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jul 2022 06:45:42 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95F3F5F109
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jul 2022 03:45:41 -0700 (PDT)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26KAdUxH006451;
        Wed, 20 Jul 2022 10:45:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=qcppdkim1;
 bh=jKpljJl5f1xVNrNRB8F/Nf3CWlAB23BRHEXk+00/2Fs=;
 b=mIQMWQlWHbBScpeRdpPiIrb1gfYZ0568g3J1/ArAT5PheVaXTnLY6/99lr0zfU1eFuZL
 Qmcs+bVQlUUSdyoTldsiLghmstVi9cOV3kvzbJ/BSCcGpvBVDHGTqx7UnDmEMaJbSPMF
 QeC7KR9WjcXBfc0WdooWA6BRT9IS544a60Pdgw9QtLw11bcUEBVc4HV8IzuOxvBGh1jl
 LQ0kpusiE//5iudjXl0FBC5ATBZF7HeGTwii3v6XL2O7R/AsQOwIHjFiAFGM9LTdOyMN
 ZA9QKv8eDxLTNH6lMERmpkGAMtsWzNHHEDIPG05YGYyOGri4gWsNnhz02HG3qGiywrR7 QA== 
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam02lp2048.outbound.protection.outlook.com [104.47.56.48])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3hebfv0s8j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 20 Jul 2022 10:45:36 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WC7uwasnd0+eDgwhxNwE3w4+aCMKBzMTqcZ2S/QdEMwgoW4D06hajl/DDJ/8gcf5IlNSp6bNxy7ONu55XQnAMKdBE78HguKXO99ySU3FEPK9Oat2VVNxNR2UD5rjR+saEe3CF9e7AjzkSwUxYLmVbCu01XgvxtTM9E1nVG3r1yHBMzKKkW5vgl4UwjNL2HewZm8IhA9hzW8P6uGWBNvwWZeISgvFbF0SD0IqOdywmzrwAGK2lsbjvtUJjAobwS/K9ulEFWR0d7XdMUtAUfDnh0XK3LV7B5pb9+T4eQeDkyKPjHYw+YXpo+eH0QJhaGfWQf8aL83sPeFuKaPwbwGSTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jKpljJl5f1xVNrNRB8F/Nf3CWlAB23BRHEXk+00/2Fs=;
 b=fPlG+kpKUU6SHQ4FrzDjm8XbAO6gdgtiMQrW59Eif35jI9coPLKNXrrENiRuR2f0YZXxM64Ml/RiTRqn6xX/8skMoHc5cMc7gEXibgoTjikdDhphfh6quISariPzDtPABb4qTz01yiGeA2gqb/5qj8uVeq2l6qBXhXlCi8QOhOkBOFYWCfMU94yHS4o+ImkquZUDVhERqpJK1l8qYdTfhbySheHY7aKe0AAf8SWAgY53HjmtzqWgEiuky22+S5ET/6e8WIHRLuB9wZvlhbt43ycFxJOOwokLefoRsBOjntfrVoPVNdxZsEFcB8QWpgBMDyDwWpEZtiTYa2JKwn3lAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=quicinc.com; dmarc=pass action=none header.from=quicinc.com;
 dkim=pass header.d=quicinc.com; arc=none
Received: from CO6PR02MB8753.namprd02.prod.outlook.com (2603:10b6:303:135::18)
 by BYAPR02MB5096.namprd02.prod.outlook.com (2603:10b6:a03:6b::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.21; Wed, 20 Jul
 2022 10:45:33 +0000
Received: from CO6PR02MB8753.namprd02.prod.outlook.com
 ([fe80::54b2:4297:d620:affd]) by CO6PR02MB8753.namprd02.prod.outlook.com
 ([fe80::54b2:4297:d620:affd%9]) with mapi id 15.20.5438.024; Wed, 20 Jul 2022
 10:45:33 +0000
From:   "Kassey Li (QUIC)" <quic_yingangl@quicinc.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        "Kassey Li (QUIC)" <quic_yingangl@quicinc.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Sasha Levin <sashal@kernel.org>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Minchan Kim <minchan@kernel.org>
Subject: RE: [PATCH] mm/cma_debug.c: align the name buffer length as struct
 cma
Thread-Topic: [PATCH] mm/cma_debug.c: align the name buffer length as struct
 cma
Thread-Index: AQHYm1AssKvX2GcRnUi/HpkM3uT0Da2GynYAgABJtKA=
Date:   Wed, 20 Jul 2022 10:45:33 +0000
Message-ID: <CO6PR02MB8753B9C4BAA3ABF34508DBABEF8E9@CO6PR02MB8753.namprd02.prod.outlook.com>
References: <20220719091554.27864-1-quic_yingangl@quicinc.com>
 <20220719161836.b0ad5cdfb0aec0c04a862122@linux-foundation.org>
In-Reply-To: <20220719161836.b0ad5cdfb0aec0c04a862122@linux-foundation.org>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c507c541-5b67-4d4a-996e-08da6a3cf8fa
x-ms-traffictypediagnostic: BYAPR02MB5096:EE_
x-ld-processed: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: v8gAd7tEl213eEyKmXbH/EQvLn4uuV6/B3mrK2ATZ02j9LM5zeGzkVez9uBvx3hXZAZBJgx5TmAFN3PSE8FDTDkF9TCtw7osj3N1ieiDls4YZU+ENPEP0vFwUfJE8JRkxIV+wz0oWs9eVGCXwydtS2UuaIpQ/X+ccw5RBBzWKo96caijm+3zGw1AAJMetvRVpZ1NlQLkwGc1GIuIwIz6lMQvWqXSUnKrfWbvrQYWlbUrH6oryDKRLcn5JpIwrA5PYKFOlZpb7AOCg8QO5dR+a535lL4JTNITaZbq6Qhfq6wmJaHhhc1j9aQpnNIwoPlzaGezP+L6f8D5cQkEugN2s9X3RdhTOizcgerke09MruGf3/hrhz6IGocLxEwEbAuFoHUOsx+pBRuiqJ0fe/8K6bwB0EdvqbnsmXWPzY0fCMpDv1Fj3oy7Q5BNIjcG7ImnXgcC3NifcyaruTRJ5aXfHJ1G8ysJAJC98ar32XnMua2YZ/+QpHT3sL/EdejMHhHZpzSdZsCoEgdTcgc6hqR9tEhs/N/0SLycHbnz2iI+qFN7WNeoENXKYHcYb4cop4ABrZ3nnx/0HMwpne0SEMxjNQbsjfhgNrSTv1gws464wgIORoPdyiNLU/ly3332PR1jP0+cDwUtrbtr1alMJrP+2BO0Z8ALHKl4/h+TFKEMrwCWVG2/JWnJI7cz3jlSNlmTc99Ik+/klAVSeDVBXjdUPDvAapONim8l+0BYnTzZNwPBm/uo1ZepDapptFm2Fx2C/IXokKKW7qaBhqjOMBZLrQb0LHgX1zq6+tN6Zju9clCdLMKUnssb2GD64L0Z97Ei
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR02MB8753.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(39860400002)(376002)(366004)(346002)(136003)(396003)(6506007)(9686003)(83380400001)(122000001)(186003)(41300700001)(2906002)(26005)(71200400001)(5660300002)(8676002)(76116006)(66476007)(66556008)(86362001)(33656002)(110136005)(4326008)(66946007)(8936002)(52536014)(38100700002)(64756008)(54906003)(53546011)(66446008)(316002)(478600001)(7696005)(38070700005)(55016003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?cMPtNpbm31/xOz3v1b2OAZ7syEjAMejqI72x6u61MQ5F+Cv0jvgf2qO7eN0b?=
 =?us-ascii?Q?eBAGKyJGskKtMhYXS77XwvCMBprX+9hYCnKJTvOaS62Wg/FGo+9xbMfwj9I9?=
 =?us-ascii?Q?ks84reNBdE+26wEZZQyBm721outdXZb6nIw3ZCIwXUfUG8oFTuBkHp7gCx1U?=
 =?us-ascii?Q?bKmu/n5TLqebnP9BZkCjui4IQrXt8yegNdSu19glu0fCsDNYF3kPA9uwYUn8?=
 =?us-ascii?Q?NYnda/cvz7YHGL9DG92THevI9yJQphdkECR/OSDGjfTGQ45RGUkEEsCt5Qpc?=
 =?us-ascii?Q?WMWMxi1PdzuS4XHSBzUotHc4FT8HscFJyRhFFhLkqF65udSWA2fsGmVwlFdK?=
 =?us-ascii?Q?rRbjziUovYFXQZ8f/pPF7DYuB6z2XKlu6SWtcsVzi5vzki7GEOdlIMSWuMVo?=
 =?us-ascii?Q?ssdctVXcp9znPnPB0sHHDiOOHAGXq1/UMffZlYMYfKnTvE/pU155f3d+sNvE?=
 =?us-ascii?Q?g9Elt/Hf3Qn5GHWOJ6a25UmzjbUKX+1/dmPogZs6L3iUxbjaHpGpxGWrHoT6?=
 =?us-ascii?Q?WQP+l+tAvHXVPGiTDFneImG5a6RZ7x2KvQqzxgMiz2Bo4qX0B8Wdd4Bel+2r?=
 =?us-ascii?Q?3WqXIrOE+0Ps+9P4b8EChAR7h7VfARnI3mx0RKON+uUOv5xZ+rVUJxkrEdfd?=
 =?us-ascii?Q?ycaa40KbGLwJM3A8P1RxOJJrAXFen8u6CEnOC9PO/po7KXqOtBpiArUBDebR?=
 =?us-ascii?Q?6Yh2RdTF5AapQzgq0x/A35iAXc7/YA9wny7ETAgk1svQa78GIyTiisAuo4o4?=
 =?us-ascii?Q?JXMkU/Y/8/QsR1p9ngDeFnTl43cfRuD9QA/DVoj0wpKEg1ssaLd86fMPBzuY?=
 =?us-ascii?Q?9CGDcQZyiUpsj0Cj4HERO5yWFFVZFcylU4FxjdHYDcLrJqowrtSawgUWvgn7?=
 =?us-ascii?Q?T2dL+zw3U8MSRJucty1XGA2N4ai/WROL5bSYCddyVzMTWbKVaLkmqMU/A6z7?=
 =?us-ascii?Q?mAr/04f0intRzXX8zqurDiYZnx4hL8ceDHhOLY2qnuFhWwbGIujfOECM3hg2?=
 =?us-ascii?Q?Rdyf3HLPywPxsA75WPGeNZypzGka67TMTnGRdmmSt3QGHmX7nxaf1S5hSaDF?=
 =?us-ascii?Q?XMeyEkoZdmLBjU6LRDenHnKvfTwWxzoOgRr5h4GNQdmVvJGXaActVe7em2xP?=
 =?us-ascii?Q?tJmZNOmYIraTp4Yi6bVphbCoS2lQxjRUDAeu2X9FTh1oYPkxHk9GzStAat0k?=
 =?us-ascii?Q?v2SikRKJtx6XNbsKxgKM7smLAMpLLljkABpZG4Ga1S6z8RnrsxXCQzLmOpNt?=
 =?us-ascii?Q?YnlqFxpqjjBP4mZ1DQGtqO92b7orVpd1LgMJKY/vzqhAN+SBdbD+2JmVkxa5?=
 =?us-ascii?Q?Usb7rk7Gq/YWEv0tSOSfkVErqVcUGNYpeV1qpVCTx4GdyWW7VsaSVwIGSUzV?=
 =?us-ascii?Q?axPziiAhgc8uH4qez3hOkyRFcgf//uw7CF5Eqlu+8EgkTADcpCaBwjbNXrsd?=
 =?us-ascii?Q?BxSPsr6DtAEDj2i6Yi7tcV4JhRtfVML8IbPviirOcmsqTMttY6mcpakntR5d?=
 =?us-ascii?Q?i/+oKuERSl7ZcuwiHMbbRY6ODs6oHS5BHVstiOFNOQvJAkCW7XrBJWr3vNzK?=
 =?us-ascii?Q?Lmhi7C/We0xNY4ufA84xmNix+Af1XsxNv5R0cICQ?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: quicinc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO6PR02MB8753.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c507c541-5b67-4d4a-996e-08da6a3cf8fa
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jul 2022 10:45:33.3945
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sUOoYvvs7WyQbt2fl4H7cyU1N7x3vwWTwS155Z1llZVGzENGlZf1l82saDBvMiIZJTmAo90n7XB1OgNEpjMQ9LbpIMF003PdGKgvlkGxo+E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR02MB5096
X-Proofpoint-GUID: 3vypyVyoOK88HbdP7TmxFQQWsUOatnIv
X-Proofpoint-ORIG-GUID: 3vypyVyoOK88HbdP7TmxFQQWsUOatnIv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-20_05,2022-07-20_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 mlxlogscore=735
 impostorscore=0 malwarescore=0 clxscore=1011 phishscore=0
 priorityscore=1501 spamscore=0 adultscore=0 suspectscore=0 mlxscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2206140000 definitions=main-2207200044
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Andrew:=20

Is it the case that the output is never >16 chars anyway?  If so, we'll be =
OK.   =20
>> Yes.  I verified on my device by giving cma.name length l< 16 and >16 bo=
th. Result is OK.   I mean > 16 showed correctly with this patch.=20
>> without this patch, cma.name > 16, only showed 16 characters.=20

Best Regards
Kassey

This technical data may be subject to U.S. and international export, re-exp=
ort, or transfer ("export") laws. Diversion contrary to U.S. and internatio=
nal law is strictly prohibited.

-----Original Message-----
From: Andrew Morton <akpm@linux-foundation.org>=20
Sent: Wednesday, July 20, 2022 7:19 AM
To: Kassey Li (QUIC) <quic_yingangl@quicinc.com>
Cc: linux-kernel@vger.kernel.org; Sasha Levin <sashal@kernel.org>; Joonsoo =
Kim <iamjoonsoo.kim@lge.com>; Minchan Kim <minchan@kernel.org>
Subject: Re: [PATCH] mm/cma_debug.c: align the name buffer length as struct=
 cma

On Tue, 19 Jul 2022 17:15:54 +0800 Kassey Li <quic_yingangl@quicinc.com> wr=
ote:

> Signed-off-by: Kassey Li <quic_yingangl@quicinc.com>
> ---
>  mm/cma_debug.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/mm/cma_debug.c b/mm/cma_debug.c index=20
> 2e7704955f4f..c3ffe253e055 100644
> --- a/mm/cma_debug.c
> +++ b/mm/cma_debug.c
> @@ -163,7 +163,7 @@ DEFINE_DEBUGFS_ATTRIBUTE(cma_alloc_fops, NULL,=20
> cma_alloc_write, "%llu\n");  static void cma_debugfs_add_one(struct=20
> cma *cma, struct dentry *root_dentry)  {
>  	struct dentry *tmp;
> -	char name[16];
> +	char name[CMA_MAX_NAME];
> =20
>  	scnprintf(name, sizeof(name), "cma-%s", cma->name);

Seems logical.  But as CMA_MAX_NAME=3D64, this could result in alteration o=
f the output: less truncation of the original name.

Is it the case that the output is never >16 chars anyway?  If so, we'll be =
OK. =20


