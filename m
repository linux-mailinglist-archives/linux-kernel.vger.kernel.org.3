Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C88550FDFE
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 14:59:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349640AbiDZNBM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 09:01:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242868AbiDZNBD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 09:01:03 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B53317B3BB;
        Tue, 26 Apr 2022 05:57:55 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 23QCKC9K022262;
        Tue, 26 Apr 2022 12:57:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : message-id : references : date : in-reply-to : content-type :
 mime-version; s=corp-2021-07-09;
 bh=W0VIsgLh2pj7RNdLcV9deihF8/9yYWMc6SLhBwMxR4E=;
 b=zaSmAww043DKXHlSjKnXyhJLT7hdLn9krPLBVVFw08O/rheKWjDnBkvduR662t5NWn9K
 FOwBf2qNTefju3/+Qe8t8NhpWyiddxuOApaPAeiYapVscubWylzkx6wdR23D+Iaig9N7
 jfgDmx6u5zM3JLGA6t8+KLA+BlCp0BUgYigrNgfyeUAtPEQTX77eoRJadZ5aP97K0vM5
 un8jWafmyV/oEGZoRPGlMqh0Bh6mJvamuHeAMnuGKo9brVB9rEMhiUWJR6j1tx5nEKUN
 2q0h8BpJnsaLN0PRvHMn0B0I7Nr6Wi3Yq9m9BBBFu1RZcuC5zgsp3AyzMRCaAXLSfN0Q 4w== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3fmaw4e2cs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 26 Apr 2022 12:57:43 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 23QCj5VK014642;
        Tue, 26 Apr 2022 12:57:42 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2046.outbound.protection.outlook.com [104.47.66.46])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3fm7w3bkan-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 26 Apr 2022 12:57:42 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HFVLIef/tHiF0TGwAj+4Dl+OWjfRXYmzPBIIh3JlPxujBmOGzlL7TwPoni3YHp1QnRZNsY0ReplWVqKBOF8boJUHpCUQNHD7Y7ToyRBKnPx3hY3xjfqxBzbxHmE/r6UhxfbJT0Jc2SJttanOYJCJHZzPThA3ytgQclfXWj7JuvNcMpkc5sgY3gpoKRjAuNZBpFWOHLcRGec3wHA8MKwWu12RYFRU70NCY5rcf8adO/MQucEJz9fgyAV+/dufYml05gOzIBqkf6fyNsX3sERM2Ca11SnMITQQ0u/+CDV73k7Va+ylJX6yxFgU4FwkP+9lb1hKzmNLByPHd6MGFrTXJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W0VIsgLh2pj7RNdLcV9deihF8/9yYWMc6SLhBwMxR4E=;
 b=XXTzEu3SfIm+DKjZFr1b9+RZU8Ch6PKeHL3iuRUjGTkv/6BiTVyRXw1I27nB62J7Fb1zdwUUXhK2crHTW03EHOQ5w66BBr4UJXQrpZpbC0Wsmqbx+wx3hJyH5DohU1fUyOHH5NN8hzJ5FffvfeNryWEtBYI6eEIkf7cny6wyjiFxFLXr1y90C6kpuWBS0r7CRq1ZhPsEyCzRj6kKvAsV7XBnWzN0NwHUn5NUE+bCjllej12urukO+Pf1VQsTl1vSewV7f8FicUdKMG1wcnse0+N39uOI6GEFadMrQhW/nBky1IahZVMfjnA/+fY9fWQMbE40NZZFnetgZ9ERozwnrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W0VIsgLh2pj7RNdLcV9deihF8/9yYWMc6SLhBwMxR4E=;
 b=R41jWJtzHqcv4fPKJ0QG/5DD1T2iCMtzC5LumN7nW9SdfZLKePjaPddpkUaPFvRArYIxDvWuF9vbiUBo7A5V+YgQcnqxrPZlZnhhZkpuqwzWh0/jQiFsKNLhdRuMujkpU+Sbum4qaFtExIaSqlHsFJNDLHPkC1z3jJHEe3dzppE=
Received: from PH0PR10MB4759.namprd10.prod.outlook.com (2603:10b6:510:3d::12)
 by MWHPR10MB1712.namprd10.prod.outlook.com (2603:10b6:301:8::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.14; Tue, 26 Apr
 2022 12:57:40 +0000
Received: from PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::d1db:de4e:9b71:3192]) by PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::d1db:de4e:9b71:3192%9]) with mapi id 15.20.5186.021; Tue, 26 Apr 2022
 12:57:40 +0000
To:     Guo Zhengkui <guozhengkui@vivo.com>
Cc:     Nilesh Javali <njavali@marvell.com>,
        GR-QLogic-Storage-Upstream@marvell.com (supporter:QLOGIC QLA2XXX
        FC-SCSI DRIVER), "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org (open list:QLOGIC QLA2XXX FC-SCSI DRIVER),
        linux-kernel@vger.kernel.org (open list),
        zhengkui_guo@outlook.com
Subject: Re: [PATCH] qla2xxx: edif: remove unneeded variable
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
Message-ID: <yq17d7ct32d.fsf@ca-mkp.ca.oracle.com>
References: <20220426074334.9281-1-guozhengkui@vivo.com>
Date:   Tue, 26 Apr 2022 08:57:38 -0400
In-Reply-To: <20220426074334.9281-1-guozhengkui@vivo.com> (Guo Zhengkui's
        message of "Tue, 26 Apr 2022 15:43:34 +0800")
Content-Type: text/plain
X-ClientProxiedBy: SA0PR11CA0139.namprd11.prod.outlook.com
 (2603:10b6:806:131::24) To PH0PR10MB4759.namprd10.prod.outlook.com
 (2603:10b6:510:3d::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 05552106-3515-477a-fa1e-08da278458b6
X-MS-TrafficTypeDiagnostic: MWHPR10MB1712:EE_
X-Microsoft-Antispam-PRVS: <MWHPR10MB17127121F1B7EE51615783358EFB9@MWHPR10MB1712.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wQCHAxqt5r1pXhe78oGnww1mS4aFzKs0vKTY6gJpmmluBXn4u/lgkvglbUTsg3oMS7wxhGObB8hm0Ss+R5Q2kAK1hQLFU1+w8osu+F1/qSzV0AV/6Rwkp4rkVCLSKbFoEf24FQvSin4rl9PpZapKA8EoD+78CIK54X4pzYBTK2QfhHqV5UPHTsHq3zh+07yD5W/W0fZMFYGzfKfnEuaDdFduEriufM1LcjgmOQlVeZC7pc0d3PJYSK4GS98qCyvMho7XR1z8asx32LGDpNAyUEbb6+Eyrm54g5QFM/Y7HUlNAalAtuL7LFOa+wMqKOu+SwAr2gCVvWqJV3+4mYmwXQnWEF0laXysuiJ5b0fBWrh1gewkSQTX30R8uwD3wqWfAs26yL0NmFI8HhfsHXsk7sK/amaNTpfGWg8dKgrrzl8x/5JAU85nXsMCH53TJXC6fn8k/lLArQHAM2bsYOEnLutuWl6k40wpUwSSCnKLVW0hW5HD0E/regBfQuZtzUWnNpORF5gOHiO74KmATlRUc0MMNdvSVW5AKNThiohEG3S2EEx+oFrOAK2/2f//HLU/+eAiqmajeM83scuy08l6QA1lXyYchsqAa1oOrIymtbeu3CyWIXDKozN8B22pMFy9ts0gfjizD3Zd/HmcKCNnenVw5GnFc0EJSdzxo7hff89NCoHPDKQ7fn2hIJFGkYkS10PFShCUaJTbFIyI8mY65A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB4759.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(66946007)(508600001)(316002)(8936002)(66476007)(8676002)(6916009)(54906003)(186003)(5660300002)(6512007)(558084003)(86362001)(66556008)(38100700002)(38350700002)(4326008)(6486002)(2906002)(83380400001)(26005)(6506007)(52116002)(36916002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?r7ziB6rYbsmMwfmFhx8JDAfxwdbqUefCPcu4x9BjfNt43ZTM2uf792KWdNUv?=
 =?us-ascii?Q?qA1MK2jAzUDoWcAaH37HPxLs+x9m/KCvO0h0ME02kifGW+k7nmXnDl7lqjA7?=
 =?us-ascii?Q?ocR2vcmXbXRU86MEJ1rfcpRfjn+Q8sF71PCQaqK56rAU1pMMTpAzfzszRmaj?=
 =?us-ascii?Q?VUMArD20G3JHHWegBzZB8yJ/9AT06di/TnWPtmdasTEEQju2CXalsW+g0SFf?=
 =?us-ascii?Q?nGmVjPxJiuUyEa2wEQPgzW2bHNo9bo7a0HGrfCeH1Kc/qw79kCNVazm0aRfm?=
 =?us-ascii?Q?2CXCokhh3hNCqAx7Ct7SUzkyTC9uuHihXqP7jzYh+SoPr+gIVPhKSwP8G2C9?=
 =?us-ascii?Q?nCWU5aAAb73VKHTyLMumv82ejNokf9jcy5I91UqBRSvZCPNASCD0QD3gbPww?=
 =?us-ascii?Q?tdQ8Pt4B2NOzd6lx2ynjok40k1ElQZL6JG5YBGc1rPN9SfiCt0XCRsdnuV8m?=
 =?us-ascii?Q?XKdcTrNXBsv8nQW+90g/v+NukW3ZJXRRTg0DQqwL4wugitCZHj8ciRqp7GYP?=
 =?us-ascii?Q?J8GQGDNMQc9TtElP/nV9yZmn+qroZ1arw2jkQcrAfH3qqqmNU5HCb67goI7B?=
 =?us-ascii?Q?X0BKSPeRcykbvpBZSfinGr0ksSEV8qH+wS/EuUvfBpyWg3G1q/omxCRlE+2D?=
 =?us-ascii?Q?hwgrxJHvyqlokANro87s4JiJpBfU0u4MaTzbGIeVM09fdus2Rz2CJmVxZrUw?=
 =?us-ascii?Q?PcTN5vXa+Iapq4qKg77uSIH0tZa4D81h1l33NaRxbwy7z92JLwHoMUxCbEGr?=
 =?us-ascii?Q?HbYLYrqwf+FECAcAj9r2DhXFl8zlICUQMsRD1yPfH5MPa9rBvDqTyEIqDlqN?=
 =?us-ascii?Q?8yaXjRc+79cem97cWNTgsudjmNAscha571aXOccxn/jbNJNJN1DsYYy1IdkT?=
 =?us-ascii?Q?45Q89FkAsf83fr2S99tNW8eIP9DUvY+AZPezzNzI4fgf9Vt+CSfWlLWzXEk1?=
 =?us-ascii?Q?JCQp6Fu/0IihHVlznLZMqhu06WPpwvjJfkksq9OHyy9x0s0drjdf2tNRxQdp?=
 =?us-ascii?Q?UgPaLQ3fgVtUzJVKD3L5vFtC5mUm0PDUTCaTd118FcXGJTi7cTkwcy4ub+2C?=
 =?us-ascii?Q?Jk8Wxsne3vTFtTEDI00Hogtm1Cn/hP9NhBAe2tOhUqcKUtYtYHDkpCa7U/nB?=
 =?us-ascii?Q?iTuaaXebEc8K7Q4dzUM80ClO39tybyViIb8Wl9+f52YvRaR0q2rS1KcAf9E5?=
 =?us-ascii?Q?BiiL39SRRfRcXrB2O5VRvqx91xj6fElM5KPYby5uhJlJJ3ZThidr2Sjpq6oZ?=
 =?us-ascii?Q?IguaMwOZL1vZ0/Y0ANDPomAHrxALC5fceSslFjbP8kmFnN9T65R2iQ81v5Ne?=
 =?us-ascii?Q?Rjxh5lVNXWg0REfgZqUEl3+FksnT79C4kgrzkr7nswwz+2TbMJFXqqWdwzKj?=
 =?us-ascii?Q?4seLs2pB3cXWiK2L+mPVn9ji8Qnj94MD8tK0z2hVyONaL08EoaOQ2YHwBJLZ?=
 =?us-ascii?Q?hXU9kn7f5rGM2teufHSIkZnXfr5xFqPtXJNgCpT38edHMvamxQr9X9Plry7u?=
 =?us-ascii?Q?mE/IIUC6rvBS7ZYbAE+78TERTQbzEYmHCB0HgbgW4Chn4S1eQOemkPwHKgFJ?=
 =?us-ascii?Q?U5pnGL01n49wt8yXswsibD3wQ6hm+Khe3tmvQTKcWaA0j/taqUcr7Oj9VLxP?=
 =?us-ascii?Q?QMKSkLUDOn0Y5M9saFOrFjRmTDg7V3SvFv4nhKA03TtX658BLS+fV7NAj5Lv?=
 =?us-ascii?Q?0TS1cM9YJroBkEt5WwOfRy3hXwiRcaym4Rv4i9Xujqld6WoTT6WxYkIBYnQz?=
 =?us-ascii?Q?4LlRq5V0zOIcF9FvwZt9LChga11pDoY=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 05552106-3515-477a-fa1e-08da278458b6
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB4759.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Apr 2022 12:57:40.5305
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yUYcXT8NUzg+K98Lp3w1jTLAuzVITupEL0uzszanQJ3NmgJw0U1Y6enSK4V+SlcknFfo6HiXonGlSKIXpebMQUZTOOtM6IuR3tRqxmdgds4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR10MB1712
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.858
 definitions=2022-04-26_02:2022-04-26,2022-04-26 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 spamscore=0 adultscore=0
 mlxscore=0 bulkscore=0 suspectscore=0 malwarescore=0 mlxlogscore=865
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2204260082
X-Proofpoint-GUID: nmlLmHUSPqJ88kMzXr6tAn930dl-Dumf
X-Proofpoint-ORIG-GUID: nmlLmHUSPqJ88kMzXr6tAn930dl-Dumf
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Guo,

> Fix the following coccicheck warning:
>
> drivers/scsi/qla2xxx/qla_edif.c:660:11-15: Unneeded variable: "rval".
> Return "0" on line 761.

Applied to 5.19/scsi-staging, thanks!

-- 
Martin K. Petersen	Oracle Linux Engineering
