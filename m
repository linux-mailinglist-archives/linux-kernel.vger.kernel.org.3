Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FB1659FDAF
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Aug 2022 16:59:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238600AbiHXO7j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Aug 2022 10:59:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237404AbiHXO7g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Aug 2022 10:59:36 -0400
Received: from mx0b-002e3701.pphosted.com (mx0b-002e3701.pphosted.com [148.163.143.35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0D7789804;
        Wed, 24 Aug 2022 07:59:35 -0700 (PDT)
Received: from pps.filterd (m0134425.ppops.net [127.0.0.1])
        by mx0b-002e3701.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27OEsnFY019454;
        Wed, 24 Aug 2022 14:59:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pps0720;
 bh=I94g1vQ9WtsGqRzaK889kWjLfZK4p4bzys64rOuxARo=;
 b=pByZ8la4tVtqEL0tCBB++ArIcmXh3i2jydXNkRfxi36Un309dNg8jewJ2u6/YYuA2kIw
 ekEV7HmLjJjqoe9bcqiMxOVvwBkbeix/f46y5Hw9wEO+8kOnr5bA5IQuQDIbyV903NCb
 GEDtk0F3TFfDoIdzwf96Y3n6l1YOepSVu41x5o7YV/odSbeKg4qoH4L5mfWKcpTS1DjI
 8MJhBF0Bqh3Xkyjm0EPU6kJKGy7lZvmzsP4sBiDNCWxCwB5d+V2TiDAehVZ/RKDFZrNi
 iINmlXP421N2CIKW5OrNZa2/rkf2b2LwCYCOrO0zDMnvtcz4SllO1WuaGmBqITuJ4cM4 GA== 
Received: from p1lg14878.it.hpe.com (p1lg14878.it.hpe.com [16.230.97.204])
        by mx0b-002e3701.pphosted.com (PPS) with ESMTPS id 3j5p5ng2rc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 24 Aug 2022 14:59:24 +0000
Received: from p1wg14923.americas.hpqcorp.net (unknown [10.119.18.111])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by p1lg14878.it.hpe.com (Postfix) with ESMTPS id 2D07848376;
        Wed, 24 Aug 2022 14:58:01 +0000 (UTC)
Received: from p1wg14925.americas.hpqcorp.net (10.119.18.114) by
 p1wg14923.americas.hpqcorp.net (10.119.18.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.15; Wed, 24 Aug 2022 02:57:50 -1200
Received: from p1wg14920.americas.hpqcorp.net (16.230.19.123) by
 p1wg14925.americas.hpqcorp.net (10.119.18.114) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.15
 via Frontend Transport; Wed, 24 Aug 2022 02:57:50 -1200
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (192.58.206.38)
 by edge.it.hpe.com (16.230.19.123) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.15; Wed, 24 Aug 2022 02:57:50 -1200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CSLYmo/hde+aAMYaE0nU6bPFwlRMUi+6mA1JnPdoTg46h/XLpEI7325Kr90ZDKhUs1IzyJxht5lgGuFbzAWkbHa7xnwFzUexMVQFaHTUjvwuGozkWpkz+pLrRNofEmZljdx6tLpmm76zinRNZpusAdHDsSUEmqD9f+YLMIXjVC4QyWeAB8ofIywxo3D9jo1g46XQzEwMaOmvThim+m6yAOkqSOuwNG2+BIFsXYS+A2FslJjGHE2OZqNHPJKDiO14urHkoNiFLkVktuBie4K5wiBxRnaCX1Inwz7zayxgEk62fGhAbLidYAZVyp2WKNAebiGhvgPKc1RwdaxEiIAsOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I94g1vQ9WtsGqRzaK889kWjLfZK4p4bzys64rOuxARo=;
 b=k2zDGkg3zcO1EYrcfqrVAjeZpHHJ0b83HiXB/GdSKFyC7We5/7caPwpopihCilubxFbKG1OfouBYHaxh9ZVOwAZDJfvOvUcMHo+CXOH8eQhK2xnujZy+yunIBrQDXhshhzsq4Z6vG/gtQDxWg7tOOOulKded1oTPKuboeWDOSp/58f1ISSaaFKP8gqjwxJw3TJIIfiW8S6RrWbIh0J+eMgevnhGdc+WFDpeKf3EzJfgUwFV/jynBNcZ2tnOAvo5GK8NaaCsSKQ31GQbnOjNrro2h8QI72BfYSJXCPutsGklhm85jo9kyBGsSfqF6tAqkzclpW827WQFmuhaNij+Bvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hpe.com; dmarc=pass action=none header.from=hpe.com; dkim=pass
 header.d=hpe.com; arc=none
Received: from MW5PR84MB1842.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:303:1c4::18)
 by PH7PR84MB1680.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:510:153::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.15; Wed, 24 Aug
 2022 14:57:49 +0000
Received: from MW5PR84MB1842.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::1cc2:4b7b:f4c5:fbb4]) by MW5PR84MB1842.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::1cc2:4b7b:f4c5:fbb4%5]) with mapi id 15.20.5525.011; Wed, 24 Aug 2022
 14:57:49 +0000
From:   "Elliott, Robert (Servers)" <elliott@hpe.com>
To:     'Guanjun' <guanjun@linux.alibaba.com>,
        "herbert@gondor.apana.org.au" <herbert@gondor.apana.org.au>
CC:     "zelin.deng@linux.alibaba.com" <zelin.deng@linux.alibaba.com>,
        "xuchun.shang@linux.alibaba.com" <xuchun.shang@linux.alibaba.com>,
        "artie.ding@linux.alibaba.com" <artie.ding@linux.alibaba.com>,
        "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v1 1/9] crypto/ycc: Add YCC (Yitian Cryptography Complex)
 accelerator driver
Thread-Topic: [PATCH v1 1/9] crypto/ycc: Add YCC (Yitian Cryptography Complex)
 accelerator driver
Thread-Index: AQHYt6DIoYTZkmXG+US+1DA83fb3r62+IYQw
Date:   Wed, 24 Aug 2022 14:57:49 +0000
Message-ID: <MW5PR84MB184271E7C3085CB1004ED6A6AB739@MW5PR84MB1842.NAMPRD84.PROD.OUTLOOK.COM>
References: <1661334621-44413-1-git-send-email-guanjun@linux.alibaba.com>
 <1661334621-44413-2-git-send-email-guanjun@linux.alibaba.com>
In-Reply-To: <1661334621-44413-2-git-send-email-guanjun@linux.alibaba.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 17e14311-7d89-4169-c3d0-08da85e1031f
x-ms-traffictypediagnostic: PH7PR84MB1680:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 7z80y1ra6T86NJ1Is7X181icvmK0rmYU4J1xEwahvA/KUoYx/NBcqKpJ124I267WM3zBFWhOY89XaxyEyFBE/WVPk9uaeVPtVs0q54HQhoHuSVWXAfQKBD0rQTW51++x7at5+/3LIeNKnZPYFvd7j7mXIDioPQ7uLqHA+GOq4/XnkzWnYlOJAcF/FbQzLI/6thHs7s6Cm+Pny3vqm4tpoP/0CqYf9E+Y8+oUAw+MKYNl/37cJnBob95gCYmnnk0oEjwtWj6ki1AJOeoBjnmPdkwAjknDvJOi/Pl/oFWSAibHz2dopRfaK1E+hJ41txacavAM89VZjHVhGm4M6kiHX5t7iv7MU8tFfSgdxloAEsUnFtM4is1ByGxeGpUcLrZEZCX26JWjmLDiaYYHkXA+AQZZwJHnDMtCKmkEnaw2uNOQAbFPFvQHAcALgxnX1tyMTBPZjGNw6fAE4he1dZAPMxswlv5QCEaVqDf3zLVLSLIrtOeVBzjRHa4Aw2JKSaUUy7/6WfZCnh7aFPM/bfPmzDa+iSKBNYXBqFZOugJRPlnzs2kn5y+k8YpZPnL8nLFf6ZPg2Uw6tETc+Yf0oqfm1TNu5d4SiKa11Tj050fqM95x+OSR3Y+mICl50ZUCm+sjpKvYf5YQ9sGqeW36uxxFD/g9PIOfxL93+iDZHCX0e0HSapv+mE8sQrTam4tXSyzPLuWDO+KUZ6TyVBKYmyZZ/3dyWqqBxzViTS/Kb7RYE71WQYBLtwzY8sgUV9CUNgmMrGTF1tJXsh7TGEvDObmd7g==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW5PR84MB1842.NAMPRD84.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230016)(366004)(136003)(39860400002)(396003)(376002)(346002)(66556008)(54906003)(55016003)(86362001)(110136005)(8676002)(4326008)(66446008)(64756008)(38100700002)(66476007)(186003)(66946007)(76116006)(7696005)(316002)(41300700001)(53546011)(6506007)(26005)(9686003)(82960400001)(38070700005)(478600001)(71200400001)(8936002)(122000001)(52536014)(83380400001)(2906002)(5660300002)(33656002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?jrryLsnjGhgX6i16V2oF66pdF92WtJ7GDAc+zQf2cLtt9LjknV1uyPX1nKxZ?=
 =?us-ascii?Q?gGLjSztUuCeKGiEotGDChnCZiEs3QaD7A4aklyHKaX5Exn0Q9uYYsBk0QIpI?=
 =?us-ascii?Q?7khss27ZTUmp56epYUUzsyUFEBS8JPzOvrbBxJjPaSB79/QdrN15HOhX71IV?=
 =?us-ascii?Q?EYNKE8ca9XRKauPqST5dHMeEI7+oxQFb21djdN54byk1Lz/bNgXZIeebAK86?=
 =?us-ascii?Q?iWZP+wbkh4qP3ykkR9XA/m5psjU670HTwwNec1F0dwHSPWyUESnNMexVnzYB?=
 =?us-ascii?Q?dsib1JPcMvNLxM2zc6KuNin0aal83hQ0JO3dlTOkHiBgrlXH/woGy9WjPjz2?=
 =?us-ascii?Q?fXR7AIibC3rKIuFKXQH6SNk0bPFMjClg/vvOavAFUXFKd7F6BAPdPRcKebyh?=
 =?us-ascii?Q?iDnWDK0GMy+1HnCErtetDFCXguZKWKRc8WOnSN/+l726xh8Py+/RikKTSxCA?=
 =?us-ascii?Q?ip+td9AtRfKlt3FZkyCYWbpU3rGsLsUMGWsKzoFLDDZKc8zM6oCx95ol1WLv?=
 =?us-ascii?Q?LCHVJPo9j3YNVo+oYIg/3SZT4hZRwtFq0p+OUrtdfYOg9XRDIh3mvzgXoL3B?=
 =?us-ascii?Q?dkWYC/vTqlVjfUUNUjsLC6kdXRbGQtX3207wjBslzLPHg51ivZFnIvjiGYFU?=
 =?us-ascii?Q?pJ4eIfCmggI6bx0swPRCw+9msMCCdwLFPn8L9R2h1E4UFJ5Ku51K5sHR78nD?=
 =?us-ascii?Q?5g9oMZk0VtiQbh8WaXz9whFuo2R+vmGF2ULJ4H8qU9wkbEzioC8nvEODIiAN?=
 =?us-ascii?Q?7DbhBPYmwAJI+7GsG650VwjB/D/PyuVtVfFLwyQfTEs0NDLZlX5pIkLgAUZO?=
 =?us-ascii?Q?dP5fg+tw9JnVL+LbBabwq1ymF3Knkc49r3d2DXl4PBBKjtxkwbAeD9KbOchS?=
 =?us-ascii?Q?kbvc6bvLdkcNNkE7k+AGMFcCRa9s3LaT8XWBazhgqXnOL81nWrTJjYpq74fV?=
 =?us-ascii?Q?oxXTYbG58TRE5PSceRNOFbFamzqlriqxPSaJ+OF+uarNIKD0MIDL+WZsoS4O?=
 =?us-ascii?Q?Cpe4S5f+Xjlmkt2YMs8hGArUHe6YEOUxXfpjdX6v9NcJDdIbXyRBTLzpVe9w?=
 =?us-ascii?Q?//yLagWUhAD0CEu4TMEBWNjrF6BnCL5SzNJ/yc3sjMPy7ZhRSPeGK3dflJOm?=
 =?us-ascii?Q?zoE7AvjA1FcCC+mFUg0r7Oj4Pn3JYZ5yGRzgFQm8JFYZzOTug1JyszngZHea?=
 =?us-ascii?Q?snEazwaHw7sVcIOIZMRs3BIsxV27zD6B7evbsPHbv4RN0ETZLVM3OSsQ7M26?=
 =?us-ascii?Q?pcPWCvPI2rZVNCdSxOasE3CdUuEpcWU2aJA8wjRHHoIi6w78N281X1FF2NRN?=
 =?us-ascii?Q?TUkfjC5tYEvQc2o1bbaIy2mY2hCTphAbHldyQSA89mMQ/VIovqtUtr+KBJLU?=
 =?us-ascii?Q?bUjp465VEoxW15Yt7iqDHFA+1OWg4pyZLDZfkFzWzE9BLCnoK8VtEzej6AyV?=
 =?us-ascii?Q?oCACZ9ToAtwMDejWU62BjayRatl3oaxNkHgRwfB3+ndODFOyN2Z01DJ/1e3U?=
 =?us-ascii?Q?z/bFrhpAkA87CQw/YdiXxkw3xgKEEO6bJd2WmBe1Zcwk8wNzdpl4Us6VqDU3?=
 =?us-ascii?Q?nTm5RMz3Tqfpw/neOIs=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW5PR84MB1842.NAMPRD84.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 17e14311-7d89-4169-c3d0-08da85e1031f
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Aug 2022 14:57:49.2739
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 105b2061-b669-4b31-92ac-24d304d195dc
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: IbRP8so/hcqTdgVVp46hHAsB8BHcXwKQo/VY6F7nmFWlvhivPEfq9kQxYF9R6iFB
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR84MB1680
X-OriginatorOrg: hpe.com
X-Proofpoint-GUID: 8Kn2qjEsHbhWPtVeIIqZ9XMd29S7RM7O
X-Proofpoint-ORIG-GUID: 8Kn2qjEsHbhWPtVeIIqZ9XMd29S7RM7O
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-24_08,2022-08-22_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 clxscore=1011
 phishscore=0 bulkscore=0 priorityscore=1501 impostorscore=0 suspectscore=0
 spamscore=0 mlxlogscore=999 malwarescore=0 mlxscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2207270000
 definitions=main-2208240057
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: 'Guanjun' <guanjun@linux.alibaba.com>
> Sent: Wednesday, August 24, 2022 4:50 AM
> To: herbert@gondor.apana.org.au
> Subject: [PATCH v1 1/9] crypto/ycc: Add YCC (Yitian Cryptography Complex)
> accelerator driver
>=20
...
> diff --git a/drivers/crypto/Kconfig b/drivers/crypto/Kconfig
> index 3e6aa31..d739354 100644
> --- a/drivers/crypto/Kconfig
> +++ b/drivers/crypto/Kconfig
> @@ -799,6 +799,8 @@ source "drivers/crypto/hisilicon/Kconfig"
>=20
>  source "drivers/crypto/amlogic/Kconfig"
>=20
> +source "drivers/crypto/ycc/Kconfig"
> +
>  config CRYPTO_DEV_SA2UL
>  	tristate "Support for TI security accelerator"
>  	depends on ARCH_K3 || COMPILE_TEST

This menu isn't perfectly sorted, but since the new entry is for
"Alibaba YCC", putting this at the top of the file would be
better positioned for eventual sorting.

Naming the directory alibaba/ rather than ycc/ might be more
welcoming for future drivers, too.

...
> diff --git a/drivers/crypto/ycc/Kconfig b/drivers/crypto/ycc/Kconfig
> +++ b/drivers/crypto/ycc/Kconfig
> @@ -0,0 +1,8 @@
> +config CRYPTO_DEV_YCC
> +	tristate "Support for Alibaba YCC cryptographic accelerator"
> +	depends on CRYPTO && CRYPTO_HW && PCI
> +	default n
> +	help
> +	  Enables the driver for the on-chip cryptographic accelerator of
> +	  Alibaba Yitian SoCs which is based on ARMv9 architecture.
> +	  If unsure say N.


