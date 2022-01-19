Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 334364933B3
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jan 2022 04:41:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351353AbiASDlU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jan 2022 22:41:20 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:30276 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1344436AbiASDlT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jan 2022 22:41:19 -0500
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 20INx7Ub002453;
        Wed, 19 Jan 2022 03:41:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : message-id : references : date : in-reply-to : content-type :
 mime-version; s=corp-2021-07-09;
 bh=WphCpKpejgvJznspZjZXi8wCZyvDpAUCgD1jEFUR9b0=;
 b=YFEgpegJq8NPuEKv9y0UIfZ0C03uCHmAmq8/Ri3lXbCuFnXkWiEmh1S6s5830JJocolr
 xDBbEtQFpAJEiXQ6ItpGCQq1rUPYEzPIYc34E416GTCyVvz8aJLbUQ8d+UTjPSerJXU0
 Mkl8NPxZfkj3YOf5WAv/3boRDNSkO6YduN7OYVLOEVEZNhZ1c8M7npqsNibydYJHTGpt
 l294dA89slgwnLGH3g7EiLq0qhcpeFtgshr2o/frodBKxAtyagjBIFSByg1p4lt8GHLj
 W9JJYV1Yyd1yq5PvkBmOb2XEb05imSM/JzyLWIrruxaj3p7eDm+mRQAdVV+qTmK2SKG3 rg== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3dnc5f3smj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 19 Jan 2022 03:41:08 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 20J3ecmr150874;
        Wed, 19 Jan 2022 03:41:06 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2174.outbound.protection.outlook.com [104.47.58.174])
        by userp3030.oracle.com with ESMTP id 3dkkcygefk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 19 Jan 2022 03:41:06 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RI4OX/R6yIFSk7Xr8eWZ6c88Rf2Ff0w1EdwzbPznj0WArCkvDs3vLOca5aZt+Rk2MkMy38elcuwC+E8S6NBcomo6eLZ0QuBOhuC+oOSldgSec6/nlqh9dei71+PkUl+/Xl3Y5MdZUTwXRG6w36eYXTCJIdhAQaTXjeuTBQf8OA4P9OUEQW53486cpGm5/MkNEEEyaiYEfv3IYgEETuvriirDM5yoSTkW54rNeFULcoo5bqswpWDH6gaKOkVleDZ85dVkngN7QLYV/xauQvtLa2akZVRFqaD4NXaCdt3nP8Ww4NDkhVyjQNYDMXHLXkKAZK+FnxhmmR4mDS0xiO1oJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WphCpKpejgvJznspZjZXi8wCZyvDpAUCgD1jEFUR9b0=;
 b=bNqdMJMMRiJrRssJp7ElxT1rtk07OuornUd9+hb/6kOUcRwEbM5O9KZpXkDWMgpCq5PQ3g0h0mcgVYNYw55nln9viyrEueVL3w+MxJCoaHNHRpeCxwR12V85mjAX7yiaLIoqTepQYnCeAjBzuEAnN3NU9xZ5EArsysuZOgn4IkolYBVAWaDjGCstPdXpc/CKKLKKZaUHn18sxHVTuiY8yuZ5XgjmZINfTPDHKBWRyVLMwWNp8XbOCKX0MgHd9U9pCkpq+onIcaCzZ0mTCsHdmsQGaO08dWR1cbUdbK5bXhW1bdXO4iar6qpVza8pGRpkOPWV/Q5dZ0D/twCxqKydQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WphCpKpejgvJznspZjZXi8wCZyvDpAUCgD1jEFUR9b0=;
 b=NP/6vW9uJetzlqpdvQAVLIWvhl8lI/okCfaFzrkd2G0amFE9XPYgceldNDEdnOsOGiHdL0VvkVLKPUe6wummMv+NIm2fhVVaUPsTH7AhhETkzmCU8kxmRcQCMF6LX9OUbNYbuO9swwGHb/l4kbHAfxGXw2596kj4jW73z7noom4=
Received: from PH0PR10MB4759.namprd10.prod.outlook.com (2603:10b6:510:3d::12)
 by SJ0PR10MB5695.namprd10.prod.outlook.com (2603:10b6:a03:3ee::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.13; Wed, 19 Jan
 2022 03:41:04 +0000
Received: from PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::1053:7ae3:932b:f166]) by PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::1053:7ae3:932b:f166%7]) with mapi id 15.20.4888.014; Wed, 19 Jan 2022
 03:41:04 +0000
To:     John Garry <john.garry@huawei.com>
Cc:     <jinpu.wang@cloud.ionos.com>, <jejb@linux.ibm.com>,
        <martin.petersen@oracle.com>, <damien.lemoal@opensource.wdc.com>,
        <Ajish.Koshy@microchip.com>, <linux-scsi@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <Viswas.G@microchip.com>,
        <vishakhavc@google.com>, <ipylypiv@google.com>,
        <Ruksar.devadi@microchip.com>,
        <Vasanthalakshmi.Tharmarajan@microchip.com>
Subject: Re: [PATCH v2] scsi: pm8001: Fix bogus FW crash for maxcpus=1
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
Message-ID: <yq11r14mlyy.fsf@ca-mkp.ca.oracle.com>
References: <1642508105-95432-1-git-send-email-john.garry@huawei.com>
Date:   Tue, 18 Jan 2022 22:41:02 -0500
In-Reply-To: <1642508105-95432-1-git-send-email-john.garry@huawei.com> (John
        Garry's message of "Tue, 18 Jan 2022 20:15:05 +0800")
Content-Type: text/plain
X-ClientProxiedBy: SN4PR0501CA0100.namprd05.prod.outlook.com
 (2603:10b6:803:42::17) To PH0PR10MB4759.namprd10.prod.outlook.com
 (2603:10b6:510:3d::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a2d2b945-d9d7-487d-18a6-08d9dafd84ee
X-MS-TrafficTypeDiagnostic: SJ0PR10MB5695:EE_
X-Microsoft-Antispam-PRVS: <SJ0PR10MB56955AF2FA67B0E903E9F47B8E599@SJ0PR10MB5695.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0HQUOxRp5d8gKMs2vWLWg3OfH/DF4rgfZQcfJRnh12jP2v937KUTtnw8ct3+XgRQc1y5ezOj4sj5Psib8JeoWwz95VEfCnQDM+uxvhWYXZO1Kj36fFNx68DrrJlhOCp8r7sZeRnqIo6wOLWkL8An3QtcDTjcaqVQRcINmbTUUBopyMjpikvYhbjhUUZqsA6PacqPdjAQw0JA+jXE9QZVJruoAZDc9Y0uhmCLwnrjcVoNOWD1dFhk+MXLMaJui9SfXiHhIY+fo9quc9v84uwQdaQBVatIyHZcpKVBlDW07l6KGnKGifsq1nloK7JI2ngy1wPVul7/hR34c+Jk9Rb+aJe8a8DOt0G7fbMDekdrgRD5xt2E4zmJnodL7oRXpQgw7njuh5Gk6Xy8feJ3DLDoQ4E8DlrJktzdoG9pUj9rn8k0fzIIBI5QrmixaeNvbhnndWBPVvjferes/pceJi1q7llopeXLKYziim34N1Ds+kXupPds2gpMlgXuWR9JQ5+Uvbf+Po05yTb4afG18ab4VQ0DoeMKageyG9KsKxpGDtcj5cnDDmgbXC3f8vQUu+Nms5l4XF7myiUF8cUhsmNlSyX3rgvEmhW3j9Iu6op2j4N+sXQSBvxvYzTTI5OVZ4Hht1NZoYfEVKHYEHH8aDA3opVy+9xRcASwM4HjLscfUmoTsVEmHNt6F+uBwpgdXpI4p92Jig6XSEnyWJNBUCJthQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB4759.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(6486002)(6512007)(4326008)(8676002)(558084003)(26005)(7416002)(6506007)(186003)(2906002)(8936002)(66946007)(66556008)(5660300002)(316002)(54906003)(508600001)(66476007)(38350700002)(52116002)(38100700002)(6916009)(86362001)(36916002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?mMohVf4eNc4XfDlPUzdOt0bHkfLcY5UQWbjiZvC6ehs3fIy0t/fiOITISanm?=
 =?us-ascii?Q?wudMumidNq2x+j+8Ot1/FkCTc/4t4unwrB1nldg+VnYdfIUucTncCfkWq8h7?=
 =?us-ascii?Q?K2ooL9Wk3lCTCssf51QZja/9787BHJ3J0vREvFgvuaqQ+V1qUgoVCmsxNJeW?=
 =?us-ascii?Q?1FlxFxT7H2dxNDqm8DD4BmxcjIcY8ocdH21o6OcJRQue9NVnSxKdXIkklkpK?=
 =?us-ascii?Q?KGvhPeHmz+CyT7Yw3yQKYVUQP+PiKg0KFbTnqdivnE3JGUBMUTZcfwkmbYGT?=
 =?us-ascii?Q?+xq35ULvQBBLfnlzsLhtoibDc35AnT6VUadxLrIjNt6q5fP7f+7ab3dA8h7X?=
 =?us-ascii?Q?JAEcCHprSOVovwrmlKZBHTrB+zsrW98p8WNMYcnje2DKbj9v5rAXkJfGlWLz?=
 =?us-ascii?Q?GVYQZ2ury0kEdx70E4b5bbK07DNcvsTRmftSSvepcniDzGUs90cJmUJE4ci3?=
 =?us-ascii?Q?LJFgg+IyuG/4ONP+k/shpZ/5IlOC92vJmYSxmbW0FqHBChNB8JDgsUhLdpSg?=
 =?us-ascii?Q?M3ZbIoSpvCwOhRYO7hRpAAo2e2EKzsHO5wq2J7sst7R5J9RHU77kL3VNtYVC?=
 =?us-ascii?Q?end1EqxMGrdvscrTsN1QKF/SYtio63FDnZhZBX2okY9SgkMIGF9gOC40ej2R?=
 =?us-ascii?Q?GhkG0T+S9ej7cHeJvNu5C84ecgfUKg3DfUN9LIyjY1B9K7Mm5chtJkvXH6ee?=
 =?us-ascii?Q?2TvBbHClSJquElf8oRV+7tJB4LgjYyVVAZm8B+I/YlECxhpkAAjrgozd2qiZ?=
 =?us-ascii?Q?ZtFNkykjlrfSxPW14PvVG/J2pien/hWUR+IeoeOgVVfLcPyHVfP8hJPwWWzU?=
 =?us-ascii?Q?PhfWPIaaIsfBKtPYnRL9jNI0I2htbM0QZchawAztMWh02CZ0ntNrg3GLl+ul?=
 =?us-ascii?Q?Waeo15JMsfYbOgldIUryegHWLIW7GNXVZEpa72rMfFgbRV/CpNc+3MHH5p3J?=
 =?us-ascii?Q?j+992/sBAdiKeqe9obg+CGlA4ESj+2tAaEIF/GgkZNjmJKuPjdJ+25Kv2b/O?=
 =?us-ascii?Q?uyD3NdwF0dI/IppP9XhurnPo8xIriRpx0vuXoFGD4jxK1HVrwaeZSEy/MEKT?=
 =?us-ascii?Q?uT7HGRRfcfTLcEFltyhIqOynz2xleBtduAQqVf0uRfwGQuVL3hBDgIyd073F?=
 =?us-ascii?Q?bfwFFVn1YE8HBaKM0aoJlAAOxiGmhNGqWANy9/IrNFkmq4JzGVqcKZL2PMk8?=
 =?us-ascii?Q?csZqLtYEQlzqPQXTnOHUJEJ94cGLQTZXxsGBNCEGq3qoTUZ5w45JdFfaLmqJ?=
 =?us-ascii?Q?QaL7pN/iV7DWE/Bn395phAe37C2Dp7lIQ2L0xlln+cKQP1BtzTRMhc/Z+U2m?=
 =?us-ascii?Q?Hz4L6yLz4Tsam3m5AJKo2eq9zwnbSX2Zlp7mQCRVls/j/cb3cYId+KXaU9dT?=
 =?us-ascii?Q?yOWzq9lSRhV/BkWaaPiFghTRHiLWX9cLQLcVXVk7GUFvxQXYtvIecSD1k+ZG?=
 =?us-ascii?Q?SCdDDrhxaf6iY/wLNWn5a2JxdpEnTp1KKp5wNzl0DLo9EhSmfCwruhWyf+I9?=
 =?us-ascii?Q?xZ/c0tfAMzjn2TcedT6TVUsixy+LmPVX0UZHEmY0UrlF6ZB5yGjNQKngOf+o?=
 =?us-ascii?Q?0DlhZYph4inCM493nBD/ykU2f8fcjVyQhkfHmMYAdWYiNIBojfYqaItXdQtV?=
 =?us-ascii?Q?1naA8YDQeS1MLmUin8SIWXk7NsQIzizavAjITcAOtq6mm+q47W8P1+2cWxY5?=
 =?us-ascii?Q?+Efvdw=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a2d2b945-d9d7-487d-18a6-08d9dafd84ee
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB4759.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jan 2022 03:41:04.2506
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: E8Vxqy/IwamepiHhbmdVhgUXmspfQRUIXChEI9J7WestL2wM60EKNSik4NvzwIUfU/keLeIphT8JEtEwlPSvLzkhqVwJ0oXfG1y6dLYuXlA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB5695
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10231 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 bulkscore=0
 malwarescore=0 adultscore=0 phishscore=0 mlxscore=0 spamscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2201190016
X-Proofpoint-GUID: RFaxPt-x8tQPjm7F_xNnx6TL39RnqXfz
X-Proofpoint-ORIG-GUID: RFaxPt-x8tQPjm7F_xNnx6TL39RnqXfz
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


John,

> According to the comment in check_fw_ready() we should not check the
> IOP1_READY field in register SCRATCH_PAD_1 for 8008 or 8009
> controllers.

Applied to 5.17/scsi-staging, thanks!

-- 
Martin K. Petersen	Oracle Linux Engineering
