Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7F9C535D99
	for <lists+linux-kernel@lfdr.de>; Fri, 27 May 2022 11:48:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350674AbiE0Jsj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 May 2022 05:48:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233600AbiE0Jsh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 May 2022 05:48:37 -0400
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2A1B1053CC;
        Fri, 27 May 2022 02:48:35 -0700 (PDT)
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
        by mx0b-0016f401.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24R8bIO4028812;
        Fri, 27 May 2022 02:42:41 -0700
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 3gau9d06cw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 27 May 2022 02:42:41 -0700
Received: from m0045851.ppops.net (m0045851.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 24R9TOib031092;
        Fri, 27 May 2022 02:42:41 -0700
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2177.outbound.protection.outlook.com [104.47.55.177])
        by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 3gau9d06cv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 27 May 2022 02:42:41 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kQhAb28tDGMWYMrb4bVS97xrj54uX5pYFeDwjqATCCHyXarwDuWzyFXPOTJCWrirFBxRfotvbDw5lVrc453/0IjmLhJFFiIE108w6V+9g+ANw1p6EE5H1lTRIsYrtauNAC9R6hajMRLKX++jFkG6FWRwqnGhXxlfFM69VpRFEKYabJWuyem1XlHRFu0oQlkmJ7d+eU73qMM6C6GEA7hhjn6b7znPgDsE/X1vZGcKIyXplk+Qu8iaPiWvWQAGbliUw+s+RNoAgDPyyhNVncVdmNuKy1jNRVhzV9KglKLjU2k3mRwpxoptCCREsC4ki66/4Y2xJjXsgrvxdsB1tNcfKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2xAhG7e6mN2jZDlvs6JfnISadiV8koTokZLr4h9TyUg=;
 b=YnrXq+1lZIdeOEz+B0sy0/E7FCAAfi80z2buVw0KoouVKN+unOAX0lJnsxPgRgbMeai84gmMZxu0cm9626Ym9/Nd+h365B0jS1HYIRzg8df3Vwrdo1nG+4mnc53covxrjd3s7aggUiRh9sW8qoamLpvuQWSu0WOa2bnoPmokpbUmlAYCBSzOzPfraq/1wx+uG0CbtZj0l9oI1DdrDS2cOouvvUxxnp0Ur6NdFBa+hugcgWR8vCz6D2TnKBsZX2RBFf9bIEigE+25Px2TS4ADx/1eXOrr8GZnhaatJ/wpQfS++bTnav0FuYl+GZf29sLcxmwSsWaASJ9u49HDOGdosg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector1-marvell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2xAhG7e6mN2jZDlvs6JfnISadiV8koTokZLr4h9TyUg=;
 b=eKvPTWoB4yL5HU88RPYuqe8B7jz1cehFez4TKu41CgX5bCtD4sAhcZEFgPxqKMcsRs2mZSzsAwv2X/7/dqYdyLmTKIhB4Xx/0fIaF5kfwc/738jyJ9/hU2sM4RkT8T/PFBcqAD34hP+8pxm1YFxLYthPSmtQP2xdwF6R8Mlfy6Y=
Received: from PH0PR18MB4425.namprd18.prod.outlook.com (2603:10b6:510:ef::13)
 by DM5PR18MB0939.namprd18.prod.outlook.com (2603:10b6:3:32::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5293.13; Fri, 27 May 2022 09:42:39 +0000
Received: from PH0PR18MB4425.namprd18.prod.outlook.com
 ([fe80::e4ab:7780:fb1a:8fda]) by PH0PR18MB4425.namprd18.prod.outlook.com
 ([fe80::e4ab:7780:fb1a:8fda%6]) with mapi id 15.20.5293.016; Fri, 27 May 2022
 09:42:38 +0000
From:   Shijith Thotton <sthotton@marvell.com>
To:     Dan Carpenter <dan.carpenter@oracle.com>
CC:     Arnaud Ebalard <arno@natisbad.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Boris Brezillon <bbrezillon@kernel.org>,
        "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
        Jerin Jacob Kollanukkaran <jerinj@marvell.com>,
        Sunil Kovvuri Goutham <sgoutham@marvell.com>,
        Srujana Challa <schalla@marvell.com>,
        "David S. Miller" <davem@davemloft.net>,
        Harman Kalra <hkalra@marvell.com>,
        Yang Yingliang <yangyingliang@huawei.com>,
        Kees Cook <keescook@chromium.org>,
        Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
        open list <linux-kernel@vger.kernel.org>
Subject: RE: [EXT] Re: [PATCH] crypto: octeontx2: fix potential null pointer
 access
Thread-Topic: [EXT] Re: [PATCH] crypto: octeontx2: fix potential null pointer
 access
Thread-Index: AQHYcZ+WFeoConjOvkuT00xCknB1x60yYvIAgAAVW7A=
Date:   Fri, 27 May 2022 09:42:38 +0000
Message-ID: <PH0PR18MB4425D53564C735899CDCD6D4D9D89@PH0PR18MB4425.namprd18.prod.outlook.com>
References: <da89ba20819ad3ca6b99f9ef056f2bc1b076dc6d.1653632699.git.sthotton@marvell.com>
 <20220527082352.GP2168@kadam>
In-Reply-To: <20220527082352.GP2168@kadam>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a1779b23-d952-4a4a-f781-08da3fc53cb5
x-ms-traffictypediagnostic: DM5PR18MB0939:EE_
x-microsoft-antispam-prvs: <DM5PR18MB0939167ADF8BDECACC2DFCAAD9D89@DM5PR18MB0939.namprd18.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: QWycI/8lxqw0CAbwMFlepv1DLisr9zp52fXE9/7KZwn9UhrJ9ftpICbhZ6bJ06GmTv5CmOkzpy1uQPoNjRbQSykm2IH4gx4ZJA7mH0GJIijSnaoGrQP2FPmBVOZ17CL8At8ZWPP0EP9XPEeEbGfKG4/L88Ljk4D6In8SU1jbu8lBrqS+U/X4KYmz5sKiKJFxQKvT0BTDKO+5+Du9RuyAD+smUWE81Gu7yMB/x0cloNjEG3HCJxXgYLCdF2F7AiHnF2V2cfI67nDd4Q2fChfJUmeMYyepMOZzftjkrqQ3i+AXV4gGEUHO0izlPATZz+j2OTKBPim9NHtx5fvkEzwpXOAi8hvmrJ/coQDZN9yHKqudybAvmZlo5VdIYLhkl9JG+m8rP0vWIEzRqO0MQGD3QFNB1WkQcNfrmF3Vsd6GtQT47a8K616CcH33xnWVao7NXRl+4PgD/6MdfU6FIC/Kq0vULkMuvyP0bvjhaXk8FMHSFJk1G4gEDShevfl1UO7KhxHO8PZhhibbt/ukyHp1yspwXSblEYXTbAi4GJSKMapMBstVOMAQ5zmPXUxwRlVE60hrv54rPHPvEOEwo3vW95MtqfxO8PT/7v/A1cwS/HZcTMV+9tbdaEnhhnBLdiuVryYb4eOetjtJd5FzptzGZMcxF9QQNLVGKtQdvVLXBg7DYrWrWe/hBpA7RAbEgEyxApcW1itvtlIlsUSdFanuTA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR18MB4425.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(7416002)(33656002)(52536014)(2906002)(6916009)(86362001)(6506007)(26005)(9686003)(4744005)(122000001)(8936002)(7696005)(54906003)(38070700005)(38100700002)(316002)(71200400001)(186003)(66556008)(66946007)(66446008)(66476007)(8676002)(64756008)(4326008)(508600001)(55016003)(76116006)(5660300002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?RErqqi08WS+dFhJhVyvZUaX8ZWzF9Sd3MZkW5gA6l0LZ9hxzAkPforTX26re?=
 =?us-ascii?Q?NlDcf+lJC8DgdbR+LfzDQa4C37lyT9WFcqMCCgIiD+yQgbKvN4olwxNyBoEC?=
 =?us-ascii?Q?rESQb5T38IA5uQ7udEZnfi87KZDq+bksaEiL5cMPYv/N09S5g4XxtnHV2vZw?=
 =?us-ascii?Q?RDNqA2Er3ADR7Jo3ed856VZ+21GVc638SAPNjTf40kSK74AWwSdK3gP3k38A?=
 =?us-ascii?Q?a2qJf5VJ2VJ3u1rJYYQ7IvNF9EkxLE2chRQDGd1QP8tcJEkDVrlILDyqKZCK?=
 =?us-ascii?Q?hJ6DHFcnBn48z/tvNYXv7VOt2Qceslm4U9nHbCGo8Gkk/hGOXJiBJKkM1MfA?=
 =?us-ascii?Q?VUXviurgBnClc0CrTFEGSVEYw9aakKcZVzJ11Im7oUXiCC0c1WD5t2jQBnGA?=
 =?us-ascii?Q?8MlASqcgYRtC16MwtLFFEWR8H1MW0IJIpLA2rFsZGTs7naKJb06YPrj0+kC4?=
 =?us-ascii?Q?l8+mPD9e/QZpQojGJ5OpGwc4FATrYuOdxyV4NiY0OooH5+gwxljoQ3FtXFeG?=
 =?us-ascii?Q?RaMXGicswJ2aLJG5i7ewysVUxlo8ccWDibmDrudODyqnOt4/frX4Q5+mh8Qk?=
 =?us-ascii?Q?RWmodT7LKaLQIrT5mQrfSb/pG2l614ap5Ut+c/l4VzM/wCD23QlZqr1FvAdL?=
 =?us-ascii?Q?hz3zH1i6NFddTBFy2tWyQMz03xMgmYt+u3zMWzqyP4+FZbEChf+Nq7TJ8Ibu?=
 =?us-ascii?Q?nPHa6enqxAYH65bi/SW7DwKxwHNq3D+FPrHaEg3VN8GsDeV7gsix1aJ7hJOZ?=
 =?us-ascii?Q?g9Tfq4W52ShHdFOf5U06JzrPIFkKTClGsFRt6u4e/OblwOktnqW1/2heO7Da?=
 =?us-ascii?Q?Xkj1k73/6mcjKymGTCzbDXetYqLPCNWj3o8EOpA2JRK5ej2lQRX4qT7R+i99?=
 =?us-ascii?Q?ZKTQdunOLYCkHrIVP718xICR437rMu+DhvBN8p910xP/z3x2XShXQHw2ZqFG?=
 =?us-ascii?Q?B4aZIWVUGmgpVPztsLZEoDJaogS1OZRpaSxBnQUTEsmpAQACQpxPy4p7Wrpk?=
 =?us-ascii?Q?OZXJg4XfaSirYbYa++HOVv4Ar8KIIEvOuO9fXvK9DFodRRHA1W6tykprDr2n?=
 =?us-ascii?Q?X/yZuPmYzXN0B+egyoKEs7Zyt4nrCE6IxX1reEAee2gb0aTYImmfNOEODhMy?=
 =?us-ascii?Q?3kJk/vk9ES90Ohw04CI8u6NWF7SCK9OsUXr8KaqR64aukCFD30hU34p0LMeO?=
 =?us-ascii?Q?KGWYXmUBghHyZnzDopBH1dfldJnOTV0ogfrDkkrCa4WrXBnZhx3M4/pW62f6?=
 =?us-ascii?Q?KuC+ZGdntfmCICKh7ooG2nbBe31Xo41S3DutxI4Pudutl8BGkxED+KSuzFtS?=
 =?us-ascii?Q?Y9yQk5q6lcpxpaf0okiwLnkpxMx8vfl/A4388w9V8gynGx2uPsS/VDb4+JCO?=
 =?us-ascii?Q?BF2w4VB0GyIVtsMt/tOcxyiUCFbB5k3rDF5CFV0c6YrH61ymTSUhdVGN9x1b?=
 =?us-ascii?Q?y0T86gymCBKh7tMp8ag2cV66ytRLGUiXub2UdobBczR75i9e87UrpeqiYL5j?=
 =?us-ascii?Q?ibafL7720sJ+oX1Bo8JCoVpafYedI897QVmDkw4iErp7wO0xDxOrvOobk0+f?=
 =?us-ascii?Q?QFdi9aBcqBPGJMCRpVHZvlwwGBA+RrKG+Z/cbu7J8FX69HG4mu2/YyBGYwl3?=
 =?us-ascii?Q?0JIZxo72/Q/KtodZKdSrzjVIcgb91RKfT/pgzimQ39fMKCBJqUchRddigIr9?=
 =?us-ascii?Q?HNKT6Jx9AXIts/DZCeBC20NSaOMgkUPwBz1B6lT4zulKIfJGtvcnUJ5FybfN?=
 =?us-ascii?Q?kOqIipShXA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR18MB4425.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a1779b23-d952-4a4a-f781-08da3fc53cb5
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 May 2022 09:42:38.5699
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: a8g/3TIpv3+qCUvzVnxKRxusB9XrItbazj83EISd33ixPbOaQ6FhY/K1KVfOhzgttSi9jQneoqtWkclflbAZHQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR18MB0939
X-Proofpoint-GUID: k17D2LFnaBBLo1BHEKKy5J1TK1DnVmyp
X-Proofpoint-ORIG-GUID: 1iolz-WtDEFvnEQtuz24mDf3TEkv-W2V
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.874,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-05-27_03,2022-05-25_02,2022-02-23_01
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>> diff --git a/drivers/crypto/marvell/octeontx2/otx2_cptpf_ucode.c
>b/drivers/crypto/marvell/octeontx2/otx2_cptpf_ucode.c
>> index 9cba2f714c7e..b91401929fc6 100644
>> --- a/drivers/crypto/marvell/octeontx2/otx2_cptpf_ucode.c
>> +++ b/drivers/crypto/marvell/octeontx2/otx2_cptpf_ucode.c
>> @@ -1605,7 +1605,11 @@ int otx2_cpt_dl_custom_egrp_create(struct
>otx2_cptpf_dev *cptpf,
>>  		if (!strncasecmp(val, "se", 2) && strchr(val, ':')) {
>>  			if (has_se || ucode_idx)
>>  				goto err_print;
>> -			tmp =3D strim(strsep(&val, ":"));
>> +			tmp =3D strsep(&val, ":");
>> +			if (tmp !=3D NULL)
>> +				tmp =3D strim(tmp);
>> +			else
>> +				goto err_print;
>
>The check is not needed here, but if it were then the better way to
>write this would be:
>
>		tmp =3D strsep(&val, ":");
>		if (!tmp)
>			goto err_print;
>		tmp =3D strim(tmp);
>
>Always to error handling, not success handling.  checkpatch.pl --strict
>will complain about the !=3D NULL.
>

Will change the check as mentioned.

Thanks,
Shijith
