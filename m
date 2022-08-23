Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F167259E97E
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Aug 2022 19:33:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232469AbiHWRYT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Aug 2022 13:24:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243612AbiHWRVn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Aug 2022 13:21:43 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 401EEBA173;
        Tue, 23 Aug 2022 07:56:03 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27NDvFck023318;
        Tue, 23 Aug 2022 14:55:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=L1x3QAm0+58oVSJNOcAwpZHL45mayvY77+SvOezQurg=;
 b=EJP6ETwnjgSI94dy2vMeYb6YGEaki7Cc2s6slLSWlU4QBKAPev1RRLPPA5CY4o4uatpx
 SJ4vROpYtJcFHcMjqmiMCKM/2BZi0snoPuX9d8i4R05PUYSHs2XZXt/Eh+GyVkeXfcr8
 PP3YQ95GO/Nnq8SF+YHAtweFWd6LAJxrdw6argZiJtpizpj9B8sKfVLBeNTEFwYryYXy
 oRK2Pv/Uf0ObnHTHj36JdG179e3OocJuag7hsjaQqSOC3Kf4QZMpG1SNGMcG2eENPiG3
 tN3/PEhJmkY8a7YS1FNeE1AtmbQ+B0CuVe2WKUMyhzdklVxOUoLuGBqqsAob7t4PquEd cw== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3j4eu6ada1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 23 Aug 2022 14:55:36 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 27NEmxDQ005788;
        Tue, 23 Aug 2022 14:55:36 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2168.outbound.protection.outlook.com [104.47.55.168])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3j3mq34fvg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 23 Aug 2022 14:55:36 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DwXGuJ1jg/7WJlXwrJxFEjO5PQCAA3ujufwtcMdsgXL2fcD5Q0gUKYj7XT+TAskfWclh6HeyEx5Ht2PjSiKzw59K9buNILyDIbk4rWso7FpWYLqAbQ9b4kJOkyrLnnXZ2h8MLtwKlpvFOHh1zbjnBYj/KWh2eRaP56+/hafPZwolrF0qlVP2QRe0lIZiyEDuGP0fTFowGq3hax/wr7JHdx9KpidGHKriEFFXDIdzZzkJBplT5OxGYyekWz2d209M2OyPsESLNsZbLhQvlzkZr4b3yKd13vbCF2s0JT/zZpJ9Bk1v88YTZH2I3nZI61YImd0J6/EhnL6e/rVVi82gxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L1x3QAm0+58oVSJNOcAwpZHL45mayvY77+SvOezQurg=;
 b=IQyOqe/cAfNjsnhA7/IV4msYxd9p2+lzaW299fElCXGuBdCNk1Sajnf+yPDfCUKmhZDT0XdLgLQ5NT5dpiV8O5siV2RTPevz/yM3Ss//y9k7DQEPC8JkjMxo2P36JfeSD/bMYkr9YJ3vaQvw3fYPGCsRdcekefL22u8D2uLRxz1rdy3BA/B9vJ/856AvYF23CrJ8T9nTF7z97AsXfXV0KV3jELdD4IMqgEg1n7nQIqkPiN2Mtj3nppAbLh2FLCYHE7tTayeQncK/+ASXHep9IorzUlZfzLY4LQEvNWbhcxZ3cOldZ0f9LeikbOW1w5Db1DIzgcYYkEblnPGbpknt/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L1x3QAm0+58oVSJNOcAwpZHL45mayvY77+SvOezQurg=;
 b=NjpTYt2qVm6sNVvpTgDFh7iW5z5zUNkTpJA89SW2y9KWIzXwY/bD6DKb7W3T15cr8ojhVMthI/bSYwdXgQOQVuDFiVh+/37YaBQqu5xub34dWKj2ZnfKeCZbIHGKNIaRufdbh1gCcEQ2w9qcMEzi4XMZJOs5ZCyhCm/Ijejuxfo=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by BL0PR10MB2980.namprd10.prod.outlook.com (2603:10b6:208:7d::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5546.20; Tue, 23 Aug
 2022 14:55:34 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::3d34:ebb5:d9df:98b3]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::3d34:ebb5:d9df:98b3%5]) with mapi id 15.20.5546.023; Tue, 23 Aug 2022
 14:55:34 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
CC:     Andrew Morton <akpm@linux-foundation.org>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: build warnings after merge of the mm tree
Thread-Topic: linux-next: build warnings after merge of the mm tree
Thread-Index: AQHYtqQUZld9YgUOc0KxzXR5odM+9628k3iA
Date:   Tue, 23 Aug 2022 14:55:33 +0000
Message-ID: <20220823145525.vm6dzmb6m76pat6w@revolver>
References: <20220823135428.021ab1de@canb.auug.org.au>
In-Reply-To: <20220823135428.021ab1de@canb.auug.org.au>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4caeb367-d7b9-48c8-5dbb-08da85178813
x-ms-traffictypediagnostic: BL0PR10MB2980:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 4c2BKlhblzk8fqZyPICHPEcixupXC6fcA4NbQ3Ok51bKnPWvhl3MqaeUfE9ajlT1otJEWyMKY7aaqr3n9bWUyBaHeGa61xo9L9/gAFG1YNpMm6lhd2Wt6kN/4UpNrS2uGscKGqwskoztBD7r65b+MUiE7sm6gbiMmW8r5xfPJHiqh0itU9EH9iKMWOoyqLrCZaGt5Bj+8cCWMOedFcQ5sI7R/vl7IBXv6nI2CTjxILBo3rW2gA87DtnR/65o+TQLeJpk8414m+AcgpErPBNfE+e1OVGWQuIZDHPmK7EXbOXERV+Br/oPr5HkIfMLddrTqamh3bZ1g5XEDRZva0fckdyur5UWtsHNDoneySHpgljIJAIXw/VtyrZwxHB/8ayLoq+R6YrfEmqIBMQiE7c06VC7l/XLTtkzxfbNYgyyhN5a7lYSdVKB/duH35tOm+cxyux3tghM23V8lwnJ+8o2bOmVcqkp5q0IDmAgQsTA3oGNYLb7xsydFQHWp6CfS0lnixJgk9ANJuzTb/Yec6PmdgB8Z8CXYqB9diT+V2YoZVfFOpQojOnjqi8wDQFavSMzTPvptMurKsr+OmL00G5ypV1MTtsqFWDsRvtLRL1ombosQ2VOoTB64mXaGxKlIE8N/dyIMML79R47Q3nwSU/H8QESIn25XKy2f4Ww2pJSfi631fzA+blSiyo38yNR0ufS5E2Pi4YxXi2WFcQ1JvIkl7REnXd8mdE8phNBy2g1ZQwc5JqiMOssWk2Rj4yl7i5K
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(7916004)(396003)(136003)(39860400002)(366004)(346002)(376002)(91956017)(122000001)(41300700001)(6916009)(38100700002)(316002)(5660300002)(44832011)(186003)(38070700005)(86362001)(71200400001)(8936002)(2906002)(478600001)(54906003)(66446008)(66556008)(66476007)(64756008)(9686003)(8676002)(83380400001)(1076003)(6512007)(4326008)(6506007)(6486002)(66946007)(26005)(76116006)(33716001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?W8qNPiBVjv3CmxajOtVMvsS2lWeSq5jImJ4JxxMk6P/y3L9WcLVeaznt3ieb?=
 =?us-ascii?Q?D0mDDthf4gGo3Y4+vly/z0GHHieVHhbmv0U4vLh3MdtSXRucaLmTVabilKb5?=
 =?us-ascii?Q?D0E08AE9VvPu4oOPTKhceSLjP8ROTpnjxWpNbt11pHRngh2fEmum+uH56PR/?=
 =?us-ascii?Q?81hitlY4xZha6JUkWXpg9oGjKfkasZvarG1DKxDPv2g9vS+ymM+MbVucxX5O?=
 =?us-ascii?Q?E1dBHNXiqTtKptAmSd4SjKH4MHz21uwOMj1nMHDz/w1v3MkMYGrIbs3fmFFD?=
 =?us-ascii?Q?+S0qE0qOUZSeAQ+aRy0UA5JWlgO2fvPNwZD0l8QiiS4wjfveMdvG5dujJalU?=
 =?us-ascii?Q?UcU12vzqhlC3nyyvaDWf3HIuw2BxYko/IEbj/scrRoLBKbE9fvWDr9cxdIwf?=
 =?us-ascii?Q?43+DQp4Wx3nWWMarqievyGyUicmfmMeQ2mQ7wazhDbR4UQVxMVwDKl9sUtpR?=
 =?us-ascii?Q?JKZloDfI86E9Xkzdw3+cDDXY/Iw907pacMOp6xQToxwTcuSVSy6Y+uaMUL8I?=
 =?us-ascii?Q?Ntrl5WIP3b2zisP9Sjk+v2qkgV+x9qKKRP/7pDa/FFa3xjdNTeyDxtewFlVD?=
 =?us-ascii?Q?77pqGnk8Pp2iq1D3OnWq9SNRlpzKTcH6gEigX41A4wlWD5G4wyLzN7N4ybWt?=
 =?us-ascii?Q?QXv4g8Kk7w9eGFDSnGJ+Kl84zUa3EtUIlYSbctVP35p6/0Mgmvl3K74SMVzH?=
 =?us-ascii?Q?gKIiJvDVDb/023lL7bLkjf6O1begay0lGL06U7Dr0IrKM6cN/t8m+ClCOqUy?=
 =?us-ascii?Q?W1N75cxIm5M0GO3z+wsqUkCLRYcgWi15YxizSdrtMKJzBENEFVoexfjr/QTy?=
 =?us-ascii?Q?B/MFDL0+i2SL3P5Be73OXS2THvjmT9r4lkeT7n7oOcQoGuWzqiW95f2JWgnm?=
 =?us-ascii?Q?g57ypST52zol9Z12i+UIU1NmEwRz5wPXoifkzciJVbEeB++P4acP2kuopf6y?=
 =?us-ascii?Q?5irbRUd077eJzUvVJX0sIcu1ng8t/w6omSVUAV5xMdZp314a4jmwp6QY/f+J?=
 =?us-ascii?Q?Np9tu6T7ojSW5Ze3KRHqWmT+dvRvh4jB1kJnMvl2LKiuoFF0DBkYXSiJB4wk?=
 =?us-ascii?Q?tQ3aivN+rJNYsv71iwgUX0rCGaUiaBelmrEkq7z6Bd/GyD35UIcLYPv5EBh+?=
 =?us-ascii?Q?e1JJn8YtT5MBAAO+lx1fvH5fhD+P1aS1DtfwavklgnehNbv/LTeK7h282Okq?=
 =?us-ascii?Q?zjy7YYwWEXjgA2fuiQLNJz4xhzz8vJ7cMVq66PnlwNACm0R56l29A9bprmPL?=
 =?us-ascii?Q?FBzzoTBRzPBUeN+hB+j/T+CKPDGvM7MF1b2x+roGf6FXkQhjg8yo4ZfqzH+L?=
 =?us-ascii?Q?ORq2tipHy29gjAfj4BgIRt7DjOhiKTO9WvPCo9WMplgdjQ7Bp1QIWABMfyoE?=
 =?us-ascii?Q?lNiQQ4GKtBBPYbfXkr9dozlvQFuyP6d4bSD51DAceh2lqqxtWHbG51jUTJ8c?=
 =?us-ascii?Q?KTBN9BOSuhHTxbF1c7g3D47vIO6rUBrdwnPwAjQozYH08H6hL5zGu3dnZ4KA?=
 =?us-ascii?Q?ZxyLqN1a32zJmOKoYBtt+Wfcf83KFrf0KiN5OK31dyiurl55mKTXdXT2KbaE?=
 =?us-ascii?Q?SI0gwHdCZQkCZPk8APbdjRUh3zM6Cd5pXEu5O4EDACg/ix+ALBf5zP4Y6loX?=
 =?us-ascii?Q?Jg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <283544387497D748A1592EDB075F1FAE@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4caeb367-d7b9-48c8-5dbb-08da85178813
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Aug 2022 14:55:33.9590
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UxSTztYVFJmBnFR/E6EoyLpejdH4D0vxXggAqFNT2w+YhBYJlIgWg5b4Wb1vycJq+slD+XxNE6HWhw34+Kn1og==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR10MB2980
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-23_05,2022-08-22_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 adultscore=0 bulkscore=0
 mlxlogscore=999 spamscore=0 phishscore=0 suspectscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2207270000
 definitions=main-2208230061
X-Proofpoint-GUID: eJYbdeYxaZBCf00XC1lQXoCdbqqFTfCm
X-Proofpoint-ORIG-GUID: eJYbdeYxaZBCf00XC1lQXoCdbqqFTfCm
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Stephen Rothwell <sfr@canb.auug.org.au> [220822 23:54]:
> Hi all,
>=20
> After merging the mm tree, today's linux-next build (htmldocs) produced
> these warnings:
>=20
> include/linux/maple_tree.h:230: warning: Function parameter or member '__=
flags' not described in 'MTREE_INIT'
> include/linux/maple_tree.h:230: warning: Excess function parameter 'flags=
' description in 'MTREE_INIT'
> include/linux/maple_tree.h:243: warning: Function parameter or member '__=
flags' not described in 'MTREE_INIT_EXT'
> include/linux/maple_tree.h:243: warning: Function parameter or member '__=
lock' not described in 'MTREE_INIT_EXT'
> include/linux/maple_tree.h:243: warning: Excess function parameter 'flags=
' description in 'MTREE_INIT_EXT'
> include/linux/maple_tree.h:243: warning: Excess function parameter 'lock'=
 description in 'MTREE_INIT_EXT'
> include/linux/maple_tree.h:523: warning: Function parameter or member '__=
mas' not described in 'mas_for_each'
> include/linux/maple_tree.h:523: warning: Function parameter or member '__=
entry' not described in 'mas_for_each'
> include/linux/maple_tree.h:523: warning: Function parameter or member '__=
max' not described in 'mas_for_each'
> include/linux/maple_tree.h:523: warning: Excess function parameter 'mas' =
description in 'mas_for_each'
> include/linux/maple_tree.h:523: warning: Excess function parameter 'entry=
' description in 'mas_for_each'
> include/linux/maple_tree.h:523: warning: Excess function parameter 'max' =
description in 'mas_for_each'
> include/linux/maple_tree.h:658: warning: Function parameter or member '__=
tree' not described in 'mt_for_each'
> include/linux/maple_tree.h:658: warning: Function parameter or member '__=
entry' not described in 'mt_for_each'
> include/linux/maple_tree.h:658: warning: Function parameter or member '__=
index' not described in 'mt_for_each'
> include/linux/maple_tree.h:658: warning: Function parameter or member '__=
max' not described in 'mt_for_each'
> include/linux/maple_tree.h:658: warning: Excess function parameter 'tree'=
 description in 'mt_for_each'
> include/linux/maple_tree.h:658: warning: Excess function parameter 'entry=
' description in 'mt_for_each'
> include/linux/maple_tree.h:658: warning: Excess function parameter 'index=
' description in 'mt_for_each'
> include/linux/maple_tree.h:658: warning: Excess function parameter 'max' =
description in 'mt_for_each'
>=20
> Introduced by commit
>=20
>   96ba2a9525fb ("Maple Tree: add new data structure")
>=20

Thanks.  I forgot to update the docs when I updated the arguments.  I'll
send out a patch shortly.
