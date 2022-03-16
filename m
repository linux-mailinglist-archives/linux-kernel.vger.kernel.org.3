Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C353E4DAE52
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Mar 2022 11:35:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355165AbiCPKhH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Mar 2022 06:37:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231461AbiCPKhF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Mar 2022 06:37:05 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AFC646161;
        Wed, 16 Mar 2022 03:35:51 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 22G7x9j8018404;
        Wed, 16 Mar 2022 10:35:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type :
 content-transfer-encoding : in-reply-to : mime-version; s=corp-2021-07-09;
 bh=3x2d3g6DUqnPgVCPh8J2f4VQz7RuVXrq3dZgpinKjiw=;
 b=bNf+etPJWNYIEBtNy+dKvsnrIoP+V211YUzg90jwKlmbuipnvFSODLpTgwBukWHMEt9P
 qW/+YExa26SeXbX2WYuWc7SIbu8JhKaILZ/ez68VtoHhKJDhAENVE7yCHVMx/9a6ylsR
 S7Q2gDW10RXW/w8uU7ZzZY1X++G4O6njle+HVcuBRTOnYTKXmJJ/UX3/vpIBXFqM21RO
 F0y837FH4TfH4H2Hr/iLvco/HstvedsvoBQ2WZLhZKqZFbjzrwXEr+S2SCleM9VgofcF
 8KklREYeJkQFYF3N00Yl4JRoHSAUG90NuvyV2rRKzggcs6BpRP99NamzYYoZwCCRAaMr xQ== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3et5xwnhs1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 16 Mar 2022 10:35:48 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 22GAWCmL142662;
        Wed, 16 Mar 2022 10:35:46 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2173.outbound.protection.outlook.com [104.47.56.173])
        by userp3020.oracle.com with ESMTP id 3et658kv3s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 16 Mar 2022 10:35:46 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MAo747zg6BGU0ysa0FiFVzGGsqE/qIPKmwtMQUPyuOnlF5fBN0DSxBfo2m679OWbntKQf5zhBNAb3Oid+uQKbZjP+ChMQwSIZF7cOgmkpeM+fDWVCZMnFzSyacRZTBdc8hkwxPAEBzgQ9drMTHnvGetC1Tpe3EchxxDAPm3pxe6/OPooAkSBdhnQSxPwl+vqflViqaAAiBOTE4hjVxkR2sXFQsSOLREp0Jvn27GhZVddxRD+sj4/VV20yE4ibeqCODaApfSr2u4AW/yhLu3RJygQx3pLFc/sQWZsa1kyCFpPt2fpn39uyeCgo4VofLC5w8R0OppoYHL2x4coUAWdcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K94hRQBbQuxm1AUSHPl6XTrIfqAPxFwQN9piMYOp7sI=;
 b=g2WO31ZL/e46nga2nZSeEow5qLasTY1RxDX9MYVPx5CPAoGZ2abj1QMvaGwmtx4G/xizGmrAe/YpGkfXqP89dA5EEkEnLdLxMCAM6WOXUD39jLYj/G5CALF9wFL9sw4/vJrbD47rK7ygdmtDC1hbiMUxJMsscpq9RWrlYvPJQTBCD50kC9aILE3GZvMmx169UW8wVEzdd2BTwu+bLxcFQpEkibvegZ1bk6fal3sE18FsCpp4pBYy6M4iBEJ9Ac4unjcFRLb7StGPE3FSCwvQb5mQJJvtaPBAz1/mVJBFcZbI72jhcO//ZyvAvHfTmDZz+4AkHbqgBVwgx+GkIb5wFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K94hRQBbQuxm1AUSHPl6XTrIfqAPxFwQN9piMYOp7sI=;
 b=OlOAVSPPJk0FoxoUgIkCQ295A/a/LMCx+SUN/KEh0wlh+De0U+6fEjmocQnCX2JgUwx1pgFAzYAxccZXJ4xh02eEJHomlRaDC+Fp3CllFsK8H3Gqt4wvizpunXKZp0hlD0Z98Ce4qKQ3HRyXZ4SGaafdNBw/thyjh6rp3rk64qA=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by MN2PR10MB3645.namprd10.prod.outlook.com
 (2603:10b6:208:113::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5081.14; Wed, 16 Mar
 2022 10:35:44 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::2c3d:92b5:42b3:c1c5]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::2c3d:92b5:42b3:c1c5%4]) with mapi id 15.20.5081.015; Wed, 16 Mar 2022
 10:35:44 +0000
Date:   Wed, 16 Mar 2022 13:35:26 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Pali =?iso-8859-1?Q?Roh=E1r?= <pali@kernel.org>
Cc:     Colin Ian King <colin.i.king@gmail.com>,
        Sebastian Reichel <sre@kernel.org>, linux-pm@vger.kernel.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] power: supply: bq2415x: Fix spelling mistake "vender" ->
 "vendor"
Message-ID: <20220316103526.GV3293@kadam>
References: <20220315223700.2961660-1-colin.i.king@gmail.com>
 <20220315224645.ytcf7y7awc3q2y6j@pali>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220315224645.ytcf7y7awc3q2y6j@pali>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JNAP275CA0030.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:4d::21)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b6f64132-15d8-4e47-4de2-08da0738b971
X-MS-TrafficTypeDiagnostic: MN2PR10MB3645:EE_
X-Microsoft-Antispam-PRVS: <MN2PR10MB36451B3374CAEF23C976FF498E119@MN2PR10MB3645.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: txV9+uHPyFcy+UJGdelFHytwqbhdDxLLYFnLxf3g30wB3e4SjQrLq6bKmoRXbVg+dRItVbRm2g4QAiIv513WMXp+LVxtxUJEDS6hlJ+/10y70r9tgUaG6L4E5NqmTBbyc0POM/oqyG/qE5wBMw9ItTbTe2OQIqueuwkVTQBMjCdWaQDtrE6r1dPBkS0D2eEfMfWSPXhdeaG4tAsWS0yjKY0QOvJeB7uyQgPXa1YNXIUPT6sez/5ZQG4PzsJS3U0n99buvmYul5MvG48RcCJLZXmBk05D9J40gzRL+jKS4KQk33UEpjFQNG7EhKM12kwBZpY2OzQQpAmNuyj3TG4RQMEKqfx1ThM91FO5zeUnd02kZkUcK8E0gIxwAsWEnyFOyiQtkp/UDn09k/6rcEyesmaSWbQjd5PNWTQi+PgJoD72bV3YpshqRCSKodi5MG92UvPkEt1sXIMg4Buz5NsrdkG6Ln32R13zJ1E8RnuVEtyuTihFUc12Z4oB76fGOZrQfr/n53pRyPbN2Rn46Urgm62paE6sDLEZwAZ7Vm5gVlNr8Ih2HEixdstz2Sig5ni11i/MyW1tstiRGWR9bc47tUHJIbETQzkPdPstGa9VKUeVgG7zMMbdmNfBTwN/1pfYgvGNxb+9U6DojeaLUexW9r1D2SHwj4zWr3nmq6oehFtPtnSUFrS/cJRyxbLJzZFgv7KWpO8aYEt9z4kfJfabN1nFt2PLaYfPQ9nXfiuM0OaR6jcOgT9C8iC8gJBqptBk13OG5Pr3/WUoxhBUCAKCRA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(366004)(6512007)(9686003)(52116002)(6506007)(508600001)(966005)(6666004)(33656002)(5660300002)(38350700002)(38100700002)(6486002)(2906002)(44832011)(4744005)(316002)(1076003)(86362001)(54906003)(6916009)(66556008)(66476007)(8936002)(33716001)(66946007)(8676002)(4326008)(186003)(26005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?qlhKW5ryCAMMeE33+41WqjrijXj0PeC2llMAq3my6JJ8R3vAZR0wBDSM0g?=
 =?iso-8859-1?Q?y5Cg3brmL92py0+30bioYQiI/f9yBM0Fz9bTWm3Kz1Dj4KBPrlOKVZ8t5s?=
 =?iso-8859-1?Q?XzZ53eqyyljwayzkIZFqs9Q7717dB7KIraqHhoJx2lQRLk4B7pP0vnOIpx?=
 =?iso-8859-1?Q?EEB0u+GQgoqWpl7crsajBRE1S/CFEX1k5thTZZeUIcvDdk373rW5n/4USx?=
 =?iso-8859-1?Q?M/G0zq9fn2hyh++LkozV30BvH+Jq4rH3LxTdvLmcpaFh/cd8ptGLnsrwQH?=
 =?iso-8859-1?Q?Zj0UJH7Lkx9uVnZzOW7MxHnbxETP13ESBlWji3wc45qOaKZNGw675HYhdT?=
 =?iso-8859-1?Q?n5DasJs1ef0UMz5DhQHaVBUTkoMc39sUEJ7/RJzpk3WcL46OC1RAdzRQuS?=
 =?iso-8859-1?Q?HMcuxU7XMH9BFWhQ5HwjZG0sZ6VkPkEgmZPBZ/6FU9osS7/0g/DpthwL85?=
 =?iso-8859-1?Q?sg5nlct3/SPenAD5ErJCjhZ8g6t0Q75wDfEMMd1k8GLKkLBOEOyTJF2zTe?=
 =?iso-8859-1?Q?H6tjZh+glK2nwQ0cycfuim4kLR9JJtsq4BzrBo60LphA8E1+LPtbB4mfH3?=
 =?iso-8859-1?Q?tHZSvMC7woV85vYlgRTWUQwCdzrLbgp0hoZJgMRPnfxlQARoF6GzV6mx87?=
 =?iso-8859-1?Q?6lMHdd2mbYXqxWctkSfC3U4ni8JNhXIQwXEzUu7r+/7TGzlQSB1Nl2nJKw?=
 =?iso-8859-1?Q?Er8BpLTF3GzWjV5q7wo6fwkZSOtzkAJyMtCNowk4OfW1/BznV9EPQhTVdt?=
 =?iso-8859-1?Q?d+dQIswbdHymoA3vPWQOjfZYuvyiROf+VZdiOHsryoOJyaQgiqNakEXFJj?=
 =?iso-8859-1?Q?xiREPbUISox8yJEe996lz3YXmYIxCxQo+49Y1N1XcuwcjK0wnnzTIfmxtu?=
 =?iso-8859-1?Q?TBSHNSw+/Pr5vsvT6wWxmflwYbCgEP1shpa7Tk1q5HxUYa2gGzRjM3ZfOu?=
 =?iso-8859-1?Q?OFeANsaiLekJH2L56+avFLkobjvdYadCWp4TiOEe6HZkRLVXi23Hzou3r/?=
 =?iso-8859-1?Q?vMC6nyK0squbhMbmhaJ3xhQC3fWev09OP2psn9q35CL/U6ZvyF0rNsqba7?=
 =?iso-8859-1?Q?ewVQ5w2t17J9cmdD+V1jrvW1yYb8ZXocr/NwDgVJKPGsTM97sQibbXvJJx?=
 =?iso-8859-1?Q?4CLihXoLAPM6NizfWE2YqDapwkQZEx3nDeeviqvmCYejrn/yJiMk9XmEnL?=
 =?iso-8859-1?Q?6805DO+I9HPzLy1hJ9P5u93RhKDav4NpkCp04fDba0pbPDM06M1kgs1Sld?=
 =?iso-8859-1?Q?T8Y6GEA5pgRYByLgp9R6LBNVWtYP2IzHasY+XErpFk7ArOAE302wv/bXyh?=
 =?iso-8859-1?Q?h8SOBb1Pyh4kw4/xrWBi3TjBTOaepBOLqLpIBPUR4A4+51I8ymd57X3n7Q?=
 =?iso-8859-1?Q?oAxRKZwQ9WJ5pLZXY4pO0hDv0axWIXjs9ecMFHC/fhZuGJ4PibFTwM/j+I?=
 =?iso-8859-1?Q?ujpD7Q1b/eelccoprYpJCkhE7u2Dce0CCkjy+pmH8klf7V2JJVYqIxfHEA?=
 =?iso-8859-1?Q?aPUbXx4HKeKU3Lxx1MZlpadHqYN1WQknKUL9WQjWpkeQ=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b6f64132-15d8-4e47-4de2-08da0738b971
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Mar 2022 10:35:43.9463
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kU/x/VFqrx3aQQ7/U2yG05EuKNtWb6Gyx1Ym/itfAgp23eI4ycx63E8fEb/OfO1CX8fBt4dWprmQ8LbqV/tN9ys1XXyJrKjrWMeTfnjSLek=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB3645
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10287 signatures=693139
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 spamscore=0
 malwarescore=0 adultscore=0 bulkscore=0 mlxscore=0 mlxlogscore=999
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2203160064
X-Proofpoint-GUID: LRxJEh4MustTzcZbp6LATWbiFDztbrGV
X-Proofpoint-ORIG-GUID: LRxJEh4MustTzcZbp6LATWbiFDztbrGV
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 15, 2022 at 11:46:45PM +0100, Pali Rohár wrote:
> On Tuesday 15 March 2022 22:37:00 Colin Ian King wrote:
> > There are several spelling mistakes in comments, function names
> > and literal strings. Fix these.
> 
> I do not think that there are mistakes.
> 
> Please look at page 29 of the official bq24150 datasheet:
> https://www.ti.com/lit/ds/symlink/bq24150.pdf
> 

"Table 8. Vender/Part/Revision Register (Read only)"

Just because they spelled it wrong in the hardware spec doesn't mean we
have to spell it wrong here.

regards,
dan carpenter

