Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C4E24C47E5
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Feb 2022 15:52:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241863AbiBYOvJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Feb 2022 09:51:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232351AbiBYOvG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Feb 2022 09:51:06 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD51A2028BE
        for <linux-kernel@vger.kernel.org>; Fri, 25 Feb 2022 06:50:34 -0800 (PST)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 21PEkRoo017395;
        Fri, 25 Feb 2022 14:50:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=wtMcplV92eIAPvgkUSFMiLNZjK8JQoeVLSn5X/F8Z54=;
 b=XT+ZXTJIaZQnTvfJdBGLsN9nwIFba5Ip5krcgOKDP6YLBEhf3ZXx8NJ5ID3DbrPt9p5b
 339oUC6D7XG+SbymLgAUbJHJN+WHf2Sh1uSGHqkkLiA0yqroJxBL0ql5R+EKGZTAMd4X
 bSYPol6K7LINmX5fIt7TH+CnEPYmc3I1Q3zLpGkeolE+R0lXFwAwfzs3Z1CCmyRDY6kN
 /unZeDPshiDqNbFhPi72nUlZDVGbSXkH/9/zAUmrVEEg3cBZ0vQ9Kp0RdvlVuxMmbCkS
 eGdSu3jayseY3SWzwLaqJF/1rXCUF3GNr1RaWL1WjaJRqeaYd+Qv8c/IQTAg9JntGFSQ 1w== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3eexar9923-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 25 Feb 2022 14:50:29 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 21PEjihB157313;
        Fri, 25 Feb 2022 14:50:28 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2049.outbound.protection.outlook.com [104.47.66.49])
        by userp3030.oracle.com with ESMTP id 3eanp09x3m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 25 Feb 2022 14:50:28 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dGGVUuvVUFOO7Xo34GaLhSNjwy726PWrWBF4okjjl4fTuPBhdlYxxfePaPcOmitU6qlloW0PncOupn1HF8R2v4URjvquC6mOFb/bE4/EjzF34V7IOF6jWbGmVqx46oNVNIciYsJGKvfOGPKYqQwcn6ZQTvcpfu6ClSCHWgHCep2tp+GpUGdfa3zPyaum1qvHjvwvHy6Y5aNgFa3NOF0FhbRNq+z2S/6mF4+fdfn2e1DdCqUqYeHqoJOa3N+fM9OZtlDUmN31Lp5L91OPRxTg851QGWyBEbZJ1XyJs4t/1TO6/OdXDXSKLcuEtf36HUPSZkKbAYVHPr7qO+3ouFqCaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wtMcplV92eIAPvgkUSFMiLNZjK8JQoeVLSn5X/F8Z54=;
 b=CXRfTmXuWt+FFGnhSzC++7d+LHlc/XMB4Zx+WJ+KUQc01+BMyuU8CB7gR5ZP33XcuHnW4/Cd55jGUyrQPQQs8RkJhfOfTQoCRB0PcBfwxBuBhlc4eH23h9qlrH6n5xgg8cM3UD5W5wp1WIPFd/6TtBNq86w0jjCQHfMPl+jTgZphns5hFmV5L1iJe9YE/bitXT6OWZD/kCr1P7Z+lQXpUSyvqZQjcTYFPlOPDi0HPZruuwZIUrU6/gU5tFfHZUPYLRa64yqbQiIF4+v5xBGBegI0rCOljG5DMdggFkzML54Z7y4S91LOMAl8+AYelAwPJUBEru9sl/jO7EPNzdyaKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wtMcplV92eIAPvgkUSFMiLNZjK8JQoeVLSn5X/F8Z54=;
 b=T+vK0MYd1r+qX7ja37TCowvAYm+kElgotJIvjtoM5HsB2UCXaUookyU5XscrFHxzXi9IwTmsvG2qMXopsOoH647WWnVugMsIWf5Xf/vSS4eCR1QPOelpN7GDLTWzNkUE8jXObFbo/9VeeppdN2M8XpRsNwvucNVMJ5PGkW8sycA=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by CH0PR10MB5260.namprd10.prod.outlook.com (2603:10b6:610:c4::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.22; Fri, 25 Feb
 2022 14:50:25 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::8df4:1db9:57f2:a96a]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::8df4:1db9:57f2:a96a%3]) with mapi id 15.20.5017.024; Fri, 25 Feb 2022
 14:50:25 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     Wan Jiabing <wanjiabing@vivo.com>
CC:     "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "jiabing.wan@qq.com" <jiabing.wan@qq.com>
Subject: Re: [PATCH] lib: maple_tree: fix boolreturn.cocci warning
Thread-Topic: [PATCH] lib: maple_tree: fix boolreturn.cocci warning
Thread-Index: AQHYKhFTJ75OJX6FSEy2/owFJii3WaykWd6A
Date:   Fri, 25 Feb 2022 14:50:25 +0000
Message-ID: <20220225145017.32ev2rjtf2b673rg@revolver>
References: <20220225063101.891725-1-wanjiabing@vivo.com>
In-Reply-To: <20220225063101.891725-1-wanjiabing@vivo.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9b35bbfb-bbf5-40fe-d682-08d9f86e286b
x-ms-traffictypediagnostic: CH0PR10MB5260:EE_
x-microsoft-antispam-prvs: <CH0PR10MB5260C4CB27366738368133CAFD3E9@CH0PR10MB5260.namprd10.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: SIJvrNfYexqmKy/0pvnvLl0tDditffaoTiKcOCM4louXzdk1HF91Jmd03EJYiXnkMenwwAjpMGDFcKW/RfUgvWr3yEe/6sss4TKNrgnGXUIoUX52bnq8GxZqzG3s3LgEpsKmI0Ep2Gz2+1+/PthiUxdeBbLmh2VIcCWsrk6Ai4qucGBnKNziw2tj/QotBaohvZQqDtMW+tvWYa/bTkFDpJLfL7ZlXqOn5TyvM6ODD2sbX+IcskzUvFjdv7ikrP4RQ4+vB9gcdnxVWtj99GoR7mSKEl94mR4BdO6KvxZoID70C5fjMFlyEKqxLZnG9jMnz+VT790hy502U5xs2WE/SFSarZnmbWraqV+TnRS+MlQ4oJoH6oMK0CVM8EPglvl7D0F5yjLOaUvNYl/HOm325v1nRseIEIdATiGkFo92yf1gQu7JfI+x1cpdJ5WolQ0WuJDLK1bjf3DseCxfKcVYL5I/VSjqBb+3XXt+1HcthBSYkDa3evWbcgR20RiYmtnFRiZ+qOFed78UTlW7yrcbVmAdU/IIvugXqNfluKBX+KI9JYIQ6gAlG/IDrUZNVRtwpJomIKYp6fs6LFtHI0df8B565Nz9bhTtYQdW1BfRik7VtCky34eqNwF3up8hn/BEjlitspJmgtGRN0sRreDyME+RZ9pl2dCKIJqqxlmkX7fwT86Klyl3y+Dsfv6Wwcwn1iMLSFe70pXGRoW5BONe1Q==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(366004)(71200400001)(38070700005)(44832011)(2906002)(76116006)(91956017)(316002)(4326008)(38100700002)(6916009)(8676002)(54906003)(64756008)(66476007)(66556008)(66446008)(66946007)(33716001)(122000001)(86362001)(508600001)(8936002)(26005)(6486002)(5660300002)(6512007)(9686003)(1076003)(186003)(6506007)(83380400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?CMgtcrnMz/6GlsrIXk3XpzSrmjRhKgBsXacNzWeWp8/CarRQ3Uexnc9ySci9?=
 =?us-ascii?Q?YOInda0QuTX9bbeClsycud9IoG6gRr9q1DeIWJM5zNYgbX4jA/Ws3LrrmOJ6?=
 =?us-ascii?Q?M8DuLXbwIFr2pLZriOZvG9CuDXTnyU8JuKUrEwVq0eGijdkJuydXXP3kKmRp?=
 =?us-ascii?Q?fw8PZCVAKMn1nRHmtRIZ9XWWMwGUFedmZtuHRG7oP3EdHaJpLSBQOmBKDU24?=
 =?us-ascii?Q?jPZas5AIqzWlAdFv0/AGCKviWsSrtoNxp8w9x66yOV7GBwYQg9rjC8gZsqGl?=
 =?us-ascii?Q?K1KmMbHbbLUcGqqj1nZqN7oyx1yKmuo55ZRL6e3x2WDdup08le+ZBsRyQtB8?=
 =?us-ascii?Q?RXSJaUtHFQVfeBJxlAlQQfZCBu1emqLA2DO7lt4c39vH7lzwcDxabmHWPHDy?=
 =?us-ascii?Q?RWkR2q26Z/3zDxxERR83QTu4BGdPraxw8E2K83L77XRH/hcdV+xsprIEE4uV?=
 =?us-ascii?Q?q9RON0fK/U3ygwp9fkKqGJAU5wHPQHCmCCzCmjezbdulCBsQVuoJDxoFTtaI?=
 =?us-ascii?Q?/A/U4/UJErG/Tj0GGAqwlE2ebP5Qu3CrKLPxGbDJGoZIjH63q07jA6TfjfbZ?=
 =?us-ascii?Q?CkaL0aLdxT9BNvc2cb/+tfS1gaHOQZdjAhVIvGksZYLdY8T1wJ6n17hqeH/u?=
 =?us-ascii?Q?lk19XZJEOzTxlkkqNsVXujYzQbI75KVW0vrqdvNALChfnxVQMPlNjLlWmbzM?=
 =?us-ascii?Q?EAxRw7YhybL8qaG7rUjYZfn+q3G4wPRugw0R+ctywsYHXdraW4JGbLviYUNb?=
 =?us-ascii?Q?NwWFxcS64oYokcN+hEtEO/K71jyp5VT8OaMGT5btKO5rhk5hK90b1thgjTPc?=
 =?us-ascii?Q?zqicxu2Qy3Zm4exMfBJFgBho2aNJl6PQ2q6GapCn79DLEV9ToDbDedLbivzs?=
 =?us-ascii?Q?RdtXmQW/DQ1fSdZSmAyJKwrdXcoaIhf+GakK9C1Owj6z2qeN2PjL89ck1XLs?=
 =?us-ascii?Q?zA/ylD4Y+/PV5yNbn9Wb5W4l+u0nn5OesIxDPvyaulcT4SGizufD9bG3b5Rx?=
 =?us-ascii?Q?OzWC3LJibBNfP5BlrAJ7SbwzKMEI9/zGx6fFxFuSiyODBxm0Ok+z9gcEUegR?=
 =?us-ascii?Q?O+k8n6cUzRBqRGnTctfbAR3XOlKtxFFx4/5rM1RDS+fO7Iwg7+K2YJAHnrar?=
 =?us-ascii?Q?HDkygK34P6sXGCbVMq1lZxr9qoCqIcnXPKhlsATjctuJSEoYIEZT/ZwA+gki?=
 =?us-ascii?Q?NBJw2/0Y8xgk+uMKiD6rC0po7W9LXX6h7pD6BYYeycgW/Cnt5H04PwoAHKBu?=
 =?us-ascii?Q?XZ62hD8Qm9LgxeamnLN5lbKCO/gAGXh1KogE0fCwl6y+SWbA1+rA/Omht2Bp?=
 =?us-ascii?Q?+k17Y1ckorGV8MoEjlHw/uaREMYDPdTicu6DcxiXXhfiIGM3L+OUqTUoqxpy?=
 =?us-ascii?Q?l7NddJOcWldJAhuhNpSHb2SridWJmDKS5txvYv85EYDNOdqWiaZaLqSa1fao?=
 =?us-ascii?Q?/WP9Y+sktVbTheUZFRJZtJ23Y+ma0W3AIR2Z6B9QSJ2LfUuNwfpHQhKhSkdG?=
 =?us-ascii?Q?lWP29jF1jHO0xOArmgZzaNFLUwyidx3d5VZIX39jgvRShDbeuDV2BwGLI4iQ?=
 =?us-ascii?Q?tkQ3WcgIQLJUVEPNIzsfYOTjPlnXSY4OAK9MuDNJzEY43Cu6MmTcrhBL3aFo?=
 =?us-ascii?Q?1dJfcFYVTtA2hjdA0Hud7+g=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <0AC04034E4C53B4A85AAB2202B99A1E2@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b35bbfb-bbf5-40fe-d682-08d9f86e286b
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Feb 2022 14:50:25.7257
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0Kb/eINXau1NVXo6q3kunrdMmMci3T5DTH3gMb6Tc04oEOtAb/J0VvW42gMm9HRUAf23H+wF+cHRJV/9qfMCoQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB5260
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10268 signatures=684655
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 suspectscore=0 adultscore=0
 malwarescore=0 phishscore=0 mlxlogscore=999 mlxscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2201110000
 definitions=main-2202250086
X-Proofpoint-ORIG-GUID: 5EsmNtSKFIhkmNNDd8l7YBoci5Y2WRrz
X-Proofpoint-GUID: 5EsmNtSKFIhkmNNDd8l7YBoci5Y2WRrz
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Thanks for the report, I will make this change in linux-next

Liam

* Wan Jiabing <wanjiabing@vivo.com> [220225 01:31]:
> Fix following coccicheck warning:
> ./lib/maple_tree.c:4177:9-10: WARNING: return of 0/1 in function
> mas_wr_append with return type bool.
>=20
> Signed-off-by: Wan Jiabing <wanjiabing@vivo.com>
> ---
>  lib/maple_tree.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>=20
> diff --git a/lib/maple_tree.c b/lib/maple_tree.c
> index 5f7295ba0309..933483726b85 100644
> --- a/lib/maple_tree.c
> +++ b/lib/maple_tree.c
> @@ -4174,7 +4174,7 @@ static inline bool mas_wr_append(struct ma_wr_state=
 *wr_mas)
>  		mas->offset =3D new_end;
>  		wr_mas->pivots[end] =3D mas->index - 1;
> =20
> -		return 1;
> +		return true;
>  	} else if ((mas->index =3D=3D wr_mas->r_min) && (mas->last < wr_mas->r_=
max)) {
>  		if (new_end < node_pivots)
>  			wr_mas->pivots[new_end] =3D wr_mas->pivots[end];
> @@ -4185,9 +4185,9 @@ static inline bool mas_wr_append(struct ma_wr_state=
 *wr_mas)
> =20
>  		wr_mas->pivots[end] =3D mas->last;
>  		rcu_assign_pointer(wr_mas->slots[end], wr_mas->entry);
> -		return 1;
> +		return true;
>  	}
> -	return 0;
> +	return false;
>  }
> =20
>  static inline void mas_wr_modify(struct ma_wr_state *wr_mas)
> --=20
> 2.35.1
> =
