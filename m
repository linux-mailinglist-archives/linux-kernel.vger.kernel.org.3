Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1E244BAF75
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Feb 2022 03:16:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231425AbiBRCOz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Feb 2022 21:14:55 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:56944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231467AbiBRCOy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 21:14:54 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27EED25E5E7;
        Thu, 17 Feb 2022 18:14:39 -0800 (PST)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 21HMNnS9013831;
        Fri, 18 Feb 2022 02:14:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=qp+AwiVa/O8HRKqnJsWGv0ZJlzf7Rvs6D4zLyIxdrMI=;
 b=Hut+uZJOsOsRO7en4odVpz9lVQG1rUT4naPcSk/QNwaHbCsqcef736lnzUlt8IMviS/l
 P05+slHx7mGkpNM73ZQTJLsi4o9TB/FGa+deOySNIOHqLuYls05QUUnr9y81JHg20/SB
 G5Z5kslzM1ANmLpze+njzbSLTV4oUO7mvT5Oi9NvB2KBkBhYUjwJXLkINH3E5aO1lAgS
 vRplZpmIZaduV3tpoww0hwzLkXC7FJBPXhmZiF53i+91GR391F4+eVlHAocusz7rOHrg
 N5CmWCAmQMpHQ61A/4MlkdSaRUlfA5Mi8Ug+BuCrUb9AxaruOMk6nJxCWuaHx3s7YXJE OQ== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3e8nr980be-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 18 Feb 2022 02:14:10 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 21I2AbEv102006;
        Fri, 18 Feb 2022 02:14:09 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2044.outbound.protection.outlook.com [104.47.66.44])
        by userp3020.oracle.com with ESMTP id 3e8n4ws7fm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 18 Feb 2022 02:14:09 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G1I/4X/QGsldWnPjJiwHglW6Nc2lJqjQ88xmGZHF5/BmHRpln9ABT4DhOgzGf+0R3YXPcTsxtqHMe6Ju0AHFCG6ph1djN5Mb3ZlWC6EHBxO3GaP0e/3bjZTgDYviFz5fuhOsH+nBJiJtxtzvY0EFifOf8fhpUb4KqtTjz/4RpZsoluJWc8tdalKxviS6B5qywk6Ju5hFhCvkkP/7rGGW3L5WPXwbm1nBvU+Jt2xeNIwyS0bjZJVqX3II4BXSSn+uH+WsZ72xE7s9ZQJ0U/qYQj0iUk7IzOGMs3Dmm72hatIYFIGBUFBNwrK+/pfcOE7jlGp4AHKtXXgzn9zjdVsqrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qp+AwiVa/O8HRKqnJsWGv0ZJlzf7Rvs6D4zLyIxdrMI=;
 b=aCCpy/mDIxnPgQ9XVvelYDuY/5QJ3FhFclzRnIZgSYPA1CvKaVgQZqVhzRO2r5F990BvUN+c2zVroP93j3dZimypJcUMWjC9ojlxYHduCTxYTvs7mUyIdldBW5I0Y1BRB5voQ7xWAaxfjSk2IFKDbipLcxin+cu8TqdYlI2+HgWtVBBaxxC9o/dhLfdHRUh89/I43kSQIDWcsvjmIT1OqlzW8Nd+zn10QED8Phjy9rwQGBC/Aq/yrO2fFn1yIfke7pjh9hphuFYpFM/0EtupjyZ199ut2QkRPvWm50Malk4KBvhdBIAutWxX8vQGNNcIh9C2q2mpfPBmCt82Lsu+qA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qp+AwiVa/O8HRKqnJsWGv0ZJlzf7Rvs6D4zLyIxdrMI=;
 b=XQimlcHziS0B6X2H1ekFuZnMvm08asm8kM/JSSqBLV4K1w+Y40cJbW8XXvLONCZBVzKA6SHY0qaL+387C1d8Borxqkz4+KTA5ijr00EJ6BDSIdmVLozPFS9rrGjSXFCcU1qvKqi7fKVS+0O05BgUjGRV+2oxDZb2SpfKXA4RPLw=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by DM5PR10MB1788.namprd10.prod.outlook.com (2603:10b6:4:8::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4975.19; Fri, 18 Feb 2022 02:14:07 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::899e:951a:8129:8ef1]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::899e:951a:8129:8ef1%4]) with mapi id 15.20.4975.019; Fri, 18 Feb 2022
 02:14:07 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
CC:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: build failure after merge of the maple tree
Thread-Topic: linux-next: build failure after merge of the maple tree
Thread-Index: AQHYI9g37Zz9MPmrFEiH0tDWqouFcayYkq6A
Date:   Fri, 18 Feb 2022 02:14:07 +0000
Message-ID: <20220218021357.usqqjqnokqw27onn@revolver>
References: <20220217192722.1447f4a9@canb.auug.org.au>
In-Reply-To: <20220217192722.1447f4a9@canb.auug.org.au>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ec744af8-e003-4d6c-a46d-08d9f28457bc
x-ms-traffictypediagnostic: DM5PR10MB1788:EE_
x-microsoft-antispam-prvs: <DM5PR10MB1788E00AB2229DAA1677A608FD379@DM5PR10MB1788.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1824;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: mQpT5TKUKukpbG4oOc0lK5C+3TRpdm3DCIyFBMsl+pU+XYBSYBPqVJ4XYlup1XM30ms8xCuqk4Q7qFDj0fgVLmK2GzV18rpqgrWHaxybVV8yHKK7baMdRR+d1EEmRt5zO7pABfrGr3DaAZ2sOxYFIrMsBvFg96k6qH3oTlDKmmtH6/RY/8XzMlWwbxiECeinuoL2pmp3Bq8KkBIZVNdUPwsGIGEjtBdDilUaMBj3ayeXrbiRIhBehqEPvbzj0S6GQFcIyVvLQ5fJncUyt2/q2J5RZg0yNxy3yRBlabl27PjOFlbuSQP8AVO9VVjv7+KiKTeJ42WsWqRmAZAg+KvyWf3p9NKoRCVGkwdyg9C2S5KKkZnIe9L4yuUBqzdEVe6M+cX0de1+bk/eoziABVOSxa/1qmIG+zk4dicCVsvEGlYKLNmuhqCD0uv2871HCcl5Lep2XdwYOMADd/dXU7WM7Bc6eLCIcmRplHrnGokTjpItM8lRCL1LLhdJSHeZwzqldgoPtNr942GUqtl7AyB5gSKJfXepg8RCBiUAsGrvkcS5b3bJrOZNu+q/ygwPe4p05OQVtVCiEzUCpdm+zqaaC3BckaU60UyUIAj2ruoNtQ6j1wM4iQSVQujUg+IwzBKWqfCjx9LDxRfUPNv8DB2xferA3u5uXHM8JghL8yMbJSL07yo0HjPC+aorr0RW7ZVv/w+tiijEzf1wKSJjvt+3WA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(366004)(122000001)(86362001)(38100700002)(38070700005)(508600001)(6486002)(44832011)(316002)(6916009)(2906002)(66476007)(66946007)(66446008)(64756008)(76116006)(54906003)(8936002)(66556008)(5660300002)(83380400001)(6512007)(33716001)(1076003)(4744005)(6506007)(9686003)(8676002)(4326008)(91956017)(26005)(186003)(71200400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?VjnDWwUxp1nHAhHtsk3xw9D8uoG1fXry1YYeCWUc7/MW1Rc+ouFmsPnpRK8K?=
 =?us-ascii?Q?FPy4z+bHdqWMgU6dHn7bb8zz1IiWNQDrp9pC38QBIH0rjX5YAU6w/cjziW7m?=
 =?us-ascii?Q?G0RDa5lO7XVsgwPG2oiU7/5KB0tjl0/wD9UmAHhQbUlfqY3UcFl+/X/vEr94?=
 =?us-ascii?Q?+E2ovxG13PFzBHYu//WzZz/fW98j68rfgkQiOQmn23Fv8vRYfukScS/850+i?=
 =?us-ascii?Q?u3eTeLTLgJiGU+EOKRFn3bEs5lNsPyzETkz/t5ZuHzCm6MAnzC+81JdkM8uk?=
 =?us-ascii?Q?94DfIwll2Pm8KokjCxZVkx7dYfnxRVXkhbRcw2M9IIS+qtrW6UGZA6eNKa1V?=
 =?us-ascii?Q?xutREv2+aIOUbx3BZq9K58dxjtbvZueS+Y33MsUrVjWZfXqPW8C0XTxZz5G2?=
 =?us-ascii?Q?vrc1/2JCjlkfCTT1KKECojFpki7No6F5+Q9qhrOBiVJLBBQgspVwznnMfGF4?=
 =?us-ascii?Q?ivyQL8E2XTJnSy630vjeNQX83kRox+MnGDtNJBtUXh4pIt4LAmAPBFGBVLdy?=
 =?us-ascii?Q?apFz6PGBKGU9vv5oAre/DClwkrWaHNjPnwsbPZMuPKTAzn97DuL2jzM7T2Pt?=
 =?us-ascii?Q?rqhktJM3a6d/a7s+ElUiHKwhU/Td7RTtCvbXBoAY0j7gR6OqwzqqBUQKUVp0?=
 =?us-ascii?Q?2b9pnk4yxJb3Q4jwDM4z6F6kdIu4uGYIFkTPonJfed2m2lCrqDBYv6QQ6gGn?=
 =?us-ascii?Q?vclNDCz24tm0b9l+Xs5Qyo3f9Ygnhktqxfw7Cda8Hy6FBL1IvT7FDadX7LUy?=
 =?us-ascii?Q?7FglFbnuwL1BOyw62rtD1yY992gTzgnhkyIIOxx2NmGhyt0GJHd1WG2si/2k?=
 =?us-ascii?Q?+KGyHu6Xo0skSctOtZlFtVjMCfPhWX0LPcG8etH2Y+uTEnD49XS1HRriYMgJ?=
 =?us-ascii?Q?/sB90ehqrnaKLqqJvmRNF+X4192QGbRIC398jKFdGJwsNnfI493zVKLZGSdr?=
 =?us-ascii?Q?CIgtzFZ7f0uxWjDh30mYCUl50sU3N3qwhchcFKf5rQ3etTDx+Ebv19oJFh00?=
 =?us-ascii?Q?/Mzp2tKSiU3vGImkuFOcLFovq4DxJsf0GWsah3SwDs6szbmO2npPPGkEq5FL?=
 =?us-ascii?Q?20+43sk11Td0BLhoWC93jP6UmjbYqO/UoPNSV7is0wgb2B8dG4p0Z0xnazyp?=
 =?us-ascii?Q?/GNmq/BZSqBHrZJguT/qdwJ74zLI7ATRJOu3R2MKPOXxerRQltxn2Qav/Wz5?=
 =?us-ascii?Q?9i3L5abFxVquND4uDVojTtPJubc9WOlWfapTk99MFblTrwNbNic0qAbu34Rl?=
 =?us-ascii?Q?KYXwqZXzQwDcD7lq6b24BLLQk/TupG/PQBIfrCpHD9gjXywSbkt9vp1l6D2n?=
 =?us-ascii?Q?0OZXIS/Gt/vxcQP3YtnbTHO3EfOzyo/t7llqIYVhp2uQAkK6Q185fcCLtILa?=
 =?us-ascii?Q?7Zg8n70w6Gs5RZAcRtVf8DEntOLGSdZyJPGDnoNTISbZjN+XdFe7G+U9p495?=
 =?us-ascii?Q?HAfOgjlIA61esFs2xrm4V/zLH/38eTXEzn52tEjnZQkEGhhdaWWwBMghxDs7?=
 =?us-ascii?Q?ID3cK2LlAfkLS4sllAy9Hjo6zbpTh9BxZfpvgsKzlGT8/i0JVoxebzY8IU+W?=
 =?us-ascii?Q?FHs9Yt+JsS8qZ7khXiq5zX7VmRK6yAsOy5DPc9KfjaoS0CzR8nDknzUTvzx1?=
 =?us-ascii?Q?MENummleYTds64Qh7uLh75Q=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <929662DE54AD424DBFA93D3E1C968933@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ec744af8-e003-4d6c-a46d-08d9f28457bc
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Feb 2022 02:14:07.0596
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UgepD0GG6v1AqLRyrd/IiVtyDEKcs9qTzr2mAXQKFa222Yfwh/clhhuS5mfk6vrmfDkLJAc6S/hZ6hUJmlAgiQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR10MB1788
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10261 signatures=677564
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 suspectscore=0 spamscore=0
 phishscore=0 bulkscore=0 mlxlogscore=906 mlxscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2201110000
 definitions=main-2202180011
X-Proofpoint-GUID: WcKqpJoh8Tf9Af8uGO-bUB2rPpnE8ajc
X-Proofpoint-ORIG-GUID: WcKqpJoh8Tf9Af8uGO-bUB2rPpnE8ajc
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stephen,

I've fixed up the frame size below and the internal maple tree frame
sizes and pushed fixes.

Thanks,
Liam

* Stephen Rothwell <sfr@canb.auug.org.au> [220217 03:27]:
> Hi all,
>=20
> After merging the maple tree, today's linux-next build (powerpc
> allyesconfig) failed like this:
>=20
> In file included from /home/sfr/next/next/mm/damon/vaddr.c:762:
> /home/sfr/next/next/mm/damon/vaddr-test.h: In function 'damon_test_three_=
regions_in_vmas':
> /home/sfr/next/next/mm/damon/vaddr-test.h:85:1: error: the frame size of =
2720 bytes is larger than 2048 bytes [-Werror=3Dframe-larger-than=3D]
>    85 | }
>       | ^
> cc1: all warnings being treated as errors
>=20
> Caused by commit
>=20
>   42672fae77a4 ("damon: Convert __damon_va_three_regions to use the VMA i=
terator")
>=20
> I have dropped the maple tree for today.
>=20
> --=20
> Cheers,
> Stephen Rothwell

