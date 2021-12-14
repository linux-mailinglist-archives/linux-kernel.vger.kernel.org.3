Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A395473BFC
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Dec 2021 05:31:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233951AbhLNEbK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 23:31:10 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:49110 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229513AbhLNEbJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 23:31:09 -0500
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1BE2B8Go004563;
        Tue, 14 Dec 2021 04:31:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : message-id : references : date : in-reply-to : content-type :
 mime-version; s=corp-2021-07-09;
 bh=9qxChM2q+0MSkO9SS53NHir9yM6D7aCN8NCdEcioHm0=;
 b=iBTO/4eJ63X28ubvFD2ZPFADqgAOBOKome9kATJ69kNBTBOTLh9C4+uCJdLK+IUK10uN
 LCqMK16u+cDJYWB+VxDgwyz/liI9hsM1mwKz0xVzlzjl5PC7S1EWAv+yLmLiWfdRrH5N
 YHosg2/myfxCrVDyvK2ahodvHFtk1IncXzZlz9lHYNv79wiO5V2oodKoWzui3i56+rs3
 2chaTN3YDVf2y55GfFahV3lVc849n3KpISBUoDMX7LyeMp3x36A7UX3wm5jWXhqU9eyu
 06/6hhHm2XRt7dJ5WQRJtnBgT6UdNs6StBPee4peB46PR1hxMuI5AyQjwjcmnIzCKGD3 3g== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3cx3mrtp9f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 14 Dec 2021 04:31:06 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1BE4P2t4149900;
        Tue, 14 Dec 2021 04:31:05 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2177.outbound.protection.outlook.com [104.47.59.177])
        by userp3020.oracle.com with ESMTP id 3cvnep91md-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 14 Dec 2021 04:31:05 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OdAMHFF0oee9ROk2/iIJlm4L8NBn0c28O1lxlmt26iiYC9nj1PQouVHpLQE/+15jBD9J3YPCfEy1YeWnkTAlN4ZAJWv303mmTN2cHaVNcIvZPcn1hM/4bApHlKGjlEfSjVaDSMjuGXTT6E1zNQIMMIRMPrXpE6J29jTHHf3XCYQmaNGtFZeRpLNBtuujiF8rriOD1LUNvBlAfNl2adYTFqBzs01SyKty5aXYaiNUjq1X8ujNS5PynvxOzEJlq0BORR6W68kNHDm0mCFJG810uYtFR5QtbhEQNaT94Jd4EhUfwl/c1J/6IUO6WH8jE0SvHp3fmI0xilYJ6wth855YOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9qxChM2q+0MSkO9SS53NHir9yM6D7aCN8NCdEcioHm0=;
 b=JIGOo2CbnA1fk1rJeGayCCgNTHBWhI4HfFBuJ9of2srkyNee0+uuleIwt+MPH9N+JcPvKJmZivUkkBCX7w0p582aMxrQ+d+RyECP/4YDtMIBq48KA9racMgy5pzgJXIhSdM9ZjNZaVmPdQMokJSPEynlnHEy/rxSta1nTXqBnSfCWqwxIL83wFCQGmhXGP+XYdIl87a6HAQEqsiX+fMNhknVwWx3CqTt1sIW1PcZ/PU2kyeuKrhJSfnVmtORUX7jK5+vOuTKAkfICUKkrAVczbGl1nLxmvkZDArjVakUp7jT6r9hfjcdcTola++rTY+Pn6plzf99wcPNnsAZundLGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9qxChM2q+0MSkO9SS53NHir9yM6D7aCN8NCdEcioHm0=;
 b=Pj6hqUxVqlEGqE5Ll4RAKeKzWwMkeBsQjcTvT9oHtXEtqruixYePGOKuOfMroAHRVa/yoTc35OdrmzbtASaeANHUPyKfmjOu7JDaagKjLWn1pODrfGmPN7iMj2a3l7xD01ds45ZS7WtVyvYoe23I3YBkEQFHoTThf4P+noDA938=
Received: from PH0PR10MB4759.namprd10.prod.outlook.com (2603:10b6:510:3d::12)
 by PH7PR10MB5771.namprd10.prod.outlook.com (2603:10b6:510:127::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.12; Tue, 14 Dec
 2021 04:31:03 +0000
Received: from PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::f4fb:f2ea:bda5:441e]) by PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::f4fb:f2ea:bda5:441e%6]) with mapi id 15.20.4778.018; Tue, 14 Dec 2021
 04:31:03 +0000
To:     Kees Cook <keescook@chromium.org>
Cc:     James Smart <james.smart@broadcom.com>,
        Dick Kennedy <dick.kennedy@broadcom.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH] scsi: lpfc: Use struct_group() to initialize struct
 lpfc_cgn_info
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
Message-ID: <yq1y24nolj8.fsf@ca-mkp.ca.oracle.com>
References: <20211208195957.1603092-1-keescook@chromium.org>
Date:   Mon, 13 Dec 2021 23:31:01 -0500
In-Reply-To: <20211208195957.1603092-1-keescook@chromium.org> (Kees Cook's
        message of "Wed, 8 Dec 2021 11:59:57 -0800")
Content-Type: text/plain
X-ClientProxiedBy: BLAPR03CA0032.namprd03.prod.outlook.com
 (2603:10b6:208:32d::7) To PH0PR10MB4759.namprd10.prod.outlook.com
 (2603:10b6:510:3d::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5426f79e-a3f9-47bd-0544-08d9beba89ac
X-MS-TrafficTypeDiagnostic: PH7PR10MB5771:EE_
X-Microsoft-Antispam-PRVS: <PH7PR10MB577176FBADC3F7917D46B2F58E759@PH7PR10MB5771.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3173;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7YS/EZ7jGU4hewrPVk+ECW1uZLdVYJaeFn9XKkWR+ZGFDN01iAEdHV5PdiGdTDKzwGtBPukyxOUlaJhJuDyzYxKbOdD9Opfs0WhRmlpZkZzND1U5Ty8Dj5O2/nVISnEz6YMO7vNPag9Vigjsq9omLgkmpF2R96Djv7ev+QfHb5XRNHsvuZFLp1Il4uAvJ5pn1zSwmxg+LY72zwfyIpt/ZD9g7FdM2wUvtiofUWo6smd9IxUB4LY/o2U3JsIxfZeuJC7beLg2SdTgRgLc8dzKH1VDU4+hWcQwQlcqYByAAWwvaUGQQDlCnUmh5Xe3jTALX1SfJZEBR+HDQI6s/U4lnFFyD/7ucZDiuNp49coRKlPB/FsWumF7+0QVoC0e71ePuOhebVm6vuEb6Yq79rf22dqo6pbJUhXetWNb9m6TLfJbD/scIwikj3UpQI7g6wZ4aDFJdLZJo2GMrktVab6OStbGoBY1GZwdPm5aHKzWfl77ZLtzAR73XqDiUa0n8eknQpUHyQEjtsHWs8nYbQ4atH8w2Y+AVOAhsHr1y3/JkSm0RXn9fn6FN/iMAo5B7SMPwPx4GarivZpm/+xaLQmqjacxq0vvQurOnGAeFj6P3E07FWN/G/zhhS0wQvi4PiqhZ/0dDTr5YvFJWz5/tk12pi7Kdmc0vExWar0Mpz+9HnM4iP8FGkBQR9QuOKO5a85nfSa1PsK6V+UBO/9vHf0XOA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB4759.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(2906002)(508600001)(38100700002)(6512007)(8936002)(36916002)(66476007)(52116002)(5660300002)(66946007)(66556008)(86362001)(6486002)(38350700002)(8676002)(54906003)(6916009)(316002)(186003)(6506007)(26005)(4326008)(558084003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?szJrhBmKI1nwQA3/LQmOH5Gkn0yumnC1nbeGO4o4jnbPSx78n3ZMQRV+1seL?=
 =?us-ascii?Q?CeU2GuBvRRL9HgBL4hDyohFLQfUF8/0dlPDT4WV713byHlVXrg2VzykAGUBX?=
 =?us-ascii?Q?VX4EWwbWE4fJTr0UDGA4qmnnI6niohW/xB4n/eGt7RiRlQ538ea+BFcGfrVN?=
 =?us-ascii?Q?9nXg/kumP4By9dzMhLOi8KSL2yXImSQX2dNrI68q4sWh4Cy033Ppu7Q1ZWPg?=
 =?us-ascii?Q?jorBh26ilbBKxEHPoFipdY4iaLKxWu+nFEbDnFOWLKGbwLCF+0g6n9UfBG6y?=
 =?us-ascii?Q?IpzXHaAZR3TNUQLT+zJdAQNsD5Qi2SppQDfaY5g/4Q5vuoNeAXl/U7Xbzp9C?=
 =?us-ascii?Q?sT3h9vusErBrTcbGxsPCF3icW9XcoxHDM0SNYdpXGeXvmJ9byCim0OA3C/TR?=
 =?us-ascii?Q?J/hTNubGd3cfJyE4YvU19E2A7YJ/ciQWXLI+Qh3trJvmz9ICYc88VDTHu8St?=
 =?us-ascii?Q?LI6IktLQc0T18VpGS4S1RQADM++hUOgp2MH08jqkdRaKrwupM2mkSOsCHHo9?=
 =?us-ascii?Q?hNogQB1NK+mxLuAOAYlrUwN6Mlmt4Kv9lhDrOowQAQ/V53+dG/Ke4StWKft/?=
 =?us-ascii?Q?P6EiKpkt6Saui6uwkZ/n896hTXh2K8VKRGQ9xOGuZkpe6D8klQrSP0ikyrTM?=
 =?us-ascii?Q?lvEaItf6iQmZuzh9oLjHHH1V4SjgBKNIZy1zuWoucRj7bIcMVNB8n+ZX7fDH?=
 =?us-ascii?Q?bgd4r3npCrQKx4is+OFzjOoZiIR3WjaUCzfBGo+bDbFf9KRV60XeB09hSHfB?=
 =?us-ascii?Q?ySPH1yk+Zq8EZ+eGP5bE+7NnA2WkN7+vFE0+UWRlQBCWxWhI2lJwrxpi1PA4?=
 =?us-ascii?Q?R9/wzxjCjR8Um9I9qDucJQ61Faq9ikjgSPZPVFlLe9aUEr0uoHvQa8cC+e7i?=
 =?us-ascii?Q?9/SMjxAYCKTUsLIEpzpj21v07NUqwW59nOKPWd2eemLnbMjDwL85DvuxT9kI?=
 =?us-ascii?Q?zlGV0wkO7Rvt9lbwEw3IeMU5RmcoYfRw9FdRf0+CfBnd+ChsPRS0HCoPhpUB?=
 =?us-ascii?Q?epdynJryrKC4Y4Xdye3Y68LlnGGVjllZ73tDlg4aHcqdOLLe0D0Uhy/dMhKA?=
 =?us-ascii?Q?ooXLqWHOhqiutLdiecRpHSI0Lr0LyZH1TfZYF49JDcauWrztOEjDE7YmZ3UV?=
 =?us-ascii?Q?4gyhDk3PKrub9jfrK/RV84uE/1L9qASW8rSTPbICvp7K4KvyoQhLWox91xCh?=
 =?us-ascii?Q?Ik6hxZ5ONfRbapfZ4ldIxgnA8nnnXywBInmJeF965vXyn9fqlqrHVCX8MdIM?=
 =?us-ascii?Q?i8jKUkIqpPzvE0ENP8UDyU4hgqyRTPawChyyUyRHCZqsXFGPxGxUvFvNLMlM?=
 =?us-ascii?Q?O4+Lz8ojGBM5miauj9VQ6pUPfP3XR4AAnftInx5UtdGlPJsVqcqt8/NAionP?=
 =?us-ascii?Q?XzMNVn29eY0Fq3lAjl9m4ISQ9fnY1nIrl5qSyoca2Tr2lbp+wesoZgdeN7oj?=
 =?us-ascii?Q?vlbyBbx3wL2gF4tATucL+ZEIS3qQ5PMHVY4dnK5AHg59SY8nzQJDv9v6lC12?=
 =?us-ascii?Q?ST+lQtEx5oixOUyzOdmHtIPvZQGzjnOXzPuSO9PkBRurPMBxbJglfKlIqWbM?=
 =?us-ascii?Q?jjZ1DlAzG9lVPg6NpfhQ4KYgzJT/7cjh9IXVoh6dszFqvMua1p4nlJDOQX69?=
 =?us-ascii?Q?RLPN68OmzVLACJLhXTOq3bA22Z7D4WTTSE66y7rRxdpf3rdzxOecFp+utgA7?=
 =?us-ascii?Q?n5hqmg=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5426f79e-a3f9-47bd-0544-08d9beba89ac
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB4759.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Dec 2021 04:31:03.3676
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FgA8gpbZVqiQ/uCKkOBXMw8y0gcFI7j3BqqxPMD8iU6Phx5Vr9jGTxhrxMM31HbrXv0fmpfprYQoiRXpSjHe2CAF0bin+XSgYBMNA+Ahoac=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB5771
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10197 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 adultscore=0
 malwarescore=0 bulkscore=0 spamscore=0 mlxlogscore=898 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2112140022
X-Proofpoint-ORIG-GUID: kiqt4-Go3OkIT0JvKHbJSjzQGJcYHEaW
X-Proofpoint-GUID: kiqt4-Go3OkIT0JvKHbJSjzQGJcYHEaW
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Kees,

> In preparation for FORTIFY_SOURCE performing compile-time and run-time
> field bounds checking for memset(), avoid intentionally writing across
> neighboring fields.

Applied to 5.17/scsi-staging, thanks!

-- 
Martin K. Petersen	Oracle Linux Engineering
