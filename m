Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62F794B2FEA
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 22:57:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353759AbiBKV5y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Feb 2022 16:57:54 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:34796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242801AbiBKV5v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Feb 2022 16:57:51 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A37BC6E;
        Fri, 11 Feb 2022 13:57:50 -0800 (PST)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 21BJ4vMK019126;
        Fri, 11 Feb 2022 21:57:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : message-id : references : date : in-reply-to : content-type :
 mime-version; s=corp-2021-07-09;
 bh=YbddxBhbrfjhPsTFE71hF0ekl8SzHpXmbvIin9MP8o8=;
 b=lO2f//72KWe0LbcfMocNFpci9BZs8Dq/9v7P06mfoSjFMPOZTzgCgsI0jkC9B9rCo+5q
 1I72gU8fQUmBs0BNUuFTeWhcBwxAYeAhiI8qE98hngl1U9pyfaAdin/uZoVg9fnGFXS5
 m8tQrU3PWPr4a/aJdSdIEOkoj7tOWLEg2s2AURPYLVI2nCKEQBwMuMIhxwWtaHUnMNnQ
 8CATYbN0Q04pMrU4k8ZlWVRHfkQlKQrbi/z25fZGgxVBhdop4ZV3u2iKyzXCq4c0lWvB
 7ksVf2am2AfsyuPWtyfn5CocELm+o+m41E7eeBmQ8fwNCUw83uMdXmp0qgis9QZELa5K uw== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3e5gt4a7jq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 11 Feb 2022 21:57:31 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 21BLoGm5087368;
        Fri, 11 Feb 2022 21:57:31 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2109.outbound.protection.outlook.com [104.47.58.109])
        by aserp3030.oracle.com with ESMTP id 3e51rw0wr5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 11 Feb 2022 21:57:30 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jj8NrRYmGridw6F6zUZpblg0DDTGh5ZtuYON6o6+4kopZiA+aHHEEofcT1wPNUkDjnj2Pp6GVW84hPGh/4Ra0M7eBwWdxs75q5nKWEJe7pJLCwrYRjlGXGDgdMf3cJptPxF2N3HM8nczc+cd5Qr3dKR7w4DyT+etgDV1t5sq4BW4s3BUs2LZnMYmZ9X8UVRCdAUiZJS+DFdjf+Jj3TvJSrEN1olww0xcNaViwgQiezpyQlihQ/jG79Wh0Ce23SlVN5HkLuOtr6z3BAFeB6r/9UeVMkYFmPfKwnkqCISXX/EX97dqbHZFiKA6j6YrI6e/YYotlL0lsi8h9aosM0Frng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YbddxBhbrfjhPsTFE71hF0ekl8SzHpXmbvIin9MP8o8=;
 b=ZXKmQhDUw/Vi26jTwFM2LbSnI461TDRTc4+U5HTNhD/wstI3M1glBPpg3iGHg6c/ahVv8gosQfyB4YnpIuWqpQCuads6VralYQiqFe4z3u+MRz/rYPSxq8B65GcL1NDVNbHCatgYa+tQhD085ZYMkNLCiBXYVX+SlJwvXuebk/aDz/vOx7HxpV1a/AWchLZcD46EuUSzx5IIA+5hJqolp3DKlotBd2HxE5/rzw7OitvxvYv2hqKhaRMo5NfAz5toHlLv7sA+ALoo8ih4VThIdyH0pGO+jNQmwjl9cNlsjc4wNwweVyLfnorje0oubkdNaH33BoHBxbB1kv79ctnLjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YbddxBhbrfjhPsTFE71hF0ekl8SzHpXmbvIin9MP8o8=;
 b=YbEE6OaGhWVTrAZRxeCD1TODwNiMsqbj1dATFwrGbxNWhVUDL3ojwlEUVQdZmbsJygPZ+qpvarktuZY9+jf8LHyM4J33OAsBjyGb8Xxpf8Jqp9HeAttN3wOOTfHip6ailid33wJevoolEf3TRHpxT9uiAejQ0SkhVYnk+N3/8/M=
Received: from CO1PR10MB4754.namprd10.prod.outlook.com (2603:10b6:303:91::24)
 by PH7PR10MB5831.namprd10.prod.outlook.com (2603:10b6:510:132::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.12; Fri, 11 Feb
 2022 21:57:29 +0000
Received: from CO1PR10MB4754.namprd10.prod.outlook.com
 ([fe80::40f6:dc10:6073:2090]) by CO1PR10MB4754.namprd10.prod.outlook.com
 ([fe80::40f6:dc10:6073:2090%5]) with mapi id 15.20.4975.014; Fri, 11 Feb 2022
 21:57:29 +0000
To:     John Garry <john.garry@huawei.com>
Cc:     <jejb@linux.ibm.com>, <martin.petersen@oracle.com>,
        <artur.paszkiewicz@intel.com>, <jinpu.wang@cloud.ionos.com>,
        <damien.lemoal@opensource.wdc.com>, <chenxiang66@hisilicon.com>,
        <linux-scsi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linuxarm@huawei.com>, <hch@lst.de>
Subject: Re: [PATCH 0/2] scsi: libsas: Drop SAS_TASK_AT_INITIATOR
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
Message-ID: <yq1pmntoyma.fsf@ca-mkp.ca.oracle.com>
References: <1644489804-85730-1-git-send-email-john.garry@huawei.com>
Date:   Fri, 11 Feb 2022 16:57:26 -0500
In-Reply-To: <1644489804-85730-1-git-send-email-john.garry@huawei.com> (John
        Garry's message of "Thu, 10 Feb 2022 18:43:22 +0800")
Content-Type: text/plain
X-ClientProxiedBy: BY3PR03CA0026.namprd03.prod.outlook.com
 (2603:10b6:a03:39a::31) To CO1PR10MB4754.namprd10.prod.outlook.com
 (2603:10b6:303:91::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b70d1623-7dda-4bf8-b9d0-08d9eda97f48
X-MS-TrafficTypeDiagnostic: PH7PR10MB5831:EE_
X-Microsoft-Antispam-PRVS: <PH7PR10MB58319B785F5F7C601DD731CA8E309@PH7PR10MB5831.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5516;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kf/FvlYfRY+XJXOdu4Btdb8V+cvGV7eTwZoZn/cpDwkfpXsBxc1Y4WQ5GpaBz9dCK3ULJBygAhIwel4qVSKBrzRtfrL8MEXDyDgo+X6t94zl9tXQHdOQ89uXTZcZb7oqz4DrqLscxZLggZEGfoNZtzZvlbvbNr7hfmHA+BiWhP8Dn2grwIgfhc2fmbaJbuCIZGBf2vYUejShTT92avh4GWP0n5Ju9NX+v13NvHG1LEVaYOnh76wYXYJnWa/41a/Pf1G8oCuzPvu1fnTLh8bq5/r+MatKG4L9waTSeIVVdxBXFtQqHnEZhJogRNneDfW5Tv/Xb5i/RzOzcyuH3Va/wHUaxrmYznnMN4oIaIfqJ4VH6Zg6kBxyqFTlGHmOQP65k67oUhiWe4t7o10ijBTvbXEO9sW0d21w9tH6hfGxQL8apHLYw8zE8Mh6yBNNNS5i6+6T/uEQCsKR5e2JHUYcY5lydohbGYyxh9nYlUyh90r/wtKBx0Ln+zWgHxEk7PkIICnSF3HaPSwnC8KPMHC1W67liV7psuh8AFR0dgHrMqe02nTgVfwO9j0fJsZm6eh9Q4PY5Hyng+GYbbVr4xKIR6Vy2VR4aP3TBp5+FYsdf5SXkSW+i9psdXwlf401FkOx5HH/jh5ROVvZauec9K6TNZd6pRAPuepg8yZx67987pCtorp++1JIPs2CLHr6m0XNBlWAt5CELLei1lOa2Y3PIQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4754.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(26005)(508600001)(7416002)(66476007)(38100700002)(5660300002)(66556008)(2906002)(38350700002)(316002)(54906003)(4326008)(66946007)(8936002)(558084003)(52116002)(6486002)(36916002)(86362001)(6666004)(8676002)(6916009)(186003)(6512007)(6506007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?kSUGhLlpNT1MyI8dEcDiFzpfKuYUzTJmF8UI906t9PuTIEsdFnpW1RbfTJaB?=
 =?us-ascii?Q?w5zW7Pzs+guLu52QTTm8j4id2efX63KlGMlRRrGxZHQkykHWf7gsgtFjJOnL?=
 =?us-ascii?Q?uh/2toSOUbPxfGMAtGlBKb9IRQLIRdrhzQlVzU8g9jHz7NVnbDS/uet3v3mV?=
 =?us-ascii?Q?Wc/m38JTKNUUOLH0cC6BeJD+7t1W51KW8RzZ5RavWbiiMZPYt0FZgJksaPXV?=
 =?us-ascii?Q?lU8fm8vlf1SU+AN9ROCOskCGJMO9WPhFUr9gDF/bKhxph9Sb9ZoD03nfRXUR?=
 =?us-ascii?Q?GjvEbOtoixsf9dWERs+ApP0Tue3jta75iB4Kv25CkVKdnA1pWfAzF4IVkN44?=
 =?us-ascii?Q?dsdWrED/mZGw5xt3sPjxOfJBRJyHe68DQOhmdoamKXK7d2YT9U9AXVNrLdpw?=
 =?us-ascii?Q?zUXaYfBHO8Hoe9dtKfVVXF+btsFN9rnsVP5R07pmnRIqTjoqr/NEuQgngy+t?=
 =?us-ascii?Q?Q6yUNTeaF1RlFegR8Q7BckVM2OicgRng+BEZKo1HbAtuwB1gh807PhgBD1uI?=
 =?us-ascii?Q?e0I4ZHahZNVTKOs3h4GRMO4B+izV/t8tLLw0RQTgCi4lqU0uPqgJvIlc1047?=
 =?us-ascii?Q?w0vCOJ9MyRzel8Nk3tPSYHtugMAtq3V8B7pz8OAKqqKzWXfrJRiLMlIavRx0?=
 =?us-ascii?Q?zBFDnmSGv0BwslKEkDn9fgQK+qG39JhPjO+id0fEsGSof3BTrOWGc8rYeD7O?=
 =?us-ascii?Q?CeoFkVpKlbvdqls3tHEjWHrNG19ZI32tVsiUabBiPW2PpQ+j3hpKr7HKftJ4?=
 =?us-ascii?Q?O39fw3EOGJbeVcEETxBaOCVhJH3gLU0BqRaucK9TVZAciBP/+ZeenFg9Jy3l?=
 =?us-ascii?Q?DoTxMtb8aBKmGlOn0PgsDgdBBrHpsgaPzSJU6Ja3GQWSSunNB5DvGUfSge/A?=
 =?us-ascii?Q?mxl2THvM0DtLPx4hwoghrRoTxXCl3XNlO6+Fmkd7oNiYl1FSjgKBnlsYIoK9?=
 =?us-ascii?Q?Z87+LeBABYjfZlD08x8hjHIhkYK37CQatfk+ifgFdJNYe8X3ZWcVbREQ84Rv?=
 =?us-ascii?Q?EjTrM0s+SOmF3deZQvP0CWt30SvK1hH//j2QvDCtOwCYQadAjDSRciONNYNM?=
 =?us-ascii?Q?tzz3Poh0M3Z3O5NwILSq/V13pii6qFHaSxk5GUzqIr65FhOZjUruyTkokWws?=
 =?us-ascii?Q?oBGgdlZ/MVdbNxE1asUfZ/ubHfbEvTTkm0aIc88uWzhuA6mAfmX6v/tPq5d/?=
 =?us-ascii?Q?fVEi7JQGsGKjspTuNyqKyaL7SiKSk0811rqLjBFrj6jbCXqDO8YopJADqOLq?=
 =?us-ascii?Q?t0UG2PMt8HxB7HiqmFYritZI01mYJcbasOcXt8maj0R+rfgTNKnQcLC01TDo?=
 =?us-ascii?Q?tOgT4AejtobcHA59j+tFF+XMHEowOIIW8qQgqCI0LOEtcGgW0COU8gdMvUk+?=
 =?us-ascii?Q?WWQAAyOoDt46NtL7x/f9yidxytSvHFZ/cKnGADjbf4tE05zyRpiMaYTOaYHJ?=
 =?us-ascii?Q?Ol+8VmShpwVcJebp9515EuRQwLBjPZnH9m7HNWYGAj0MYw2u8DgYBxnsVYk6?=
 =?us-ascii?Q?c4N4GNujT/CkLvpA1WtVUrp0dLR993hJ7GzKCNLSzMz8LfrtLnJ762hj2n5K?=
 =?us-ascii?Q?JXKsFMh5AjqSd9h34upOC8H1qNMSwDmSPSUNEf59VkAC4EgQThFjSPCA7EqF?=
 =?us-ascii?Q?2che3Parfzi6fVteSfhduuBWFdoE57H8Gv8UDJw+2/OQQSgc/TiYjgvyqFx0?=
 =?us-ascii?Q?niOOsw=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b70d1623-7dda-4bf8-b9d0-08d9eda97f48
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4754.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Feb 2022 21:57:29.1457
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: K/p8uvPBpogoecDVRQWQKwSs1pqmZPUYUNyODcnxI1+UrkOEYDMckD7EzX3+uuKvL+Qg2vO9qqjEm4dR6HWHs4T5irlM+lnULkOfO50YT8U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB5831
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10255 signatures=673431
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=878 phishscore=0
 suspectscore=0 adultscore=0 malwarescore=0 bulkscore=0 spamscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2202110109
X-Proofpoint-GUID: DAGKnFIKTFnEl0XDTj6IAKUU0vofvzWB
X-Proofpoint-ORIG-GUID: DAGKnFIKTFnEl0XDTj6IAKUU0vofvzWB
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


John,

> Apart from some isci driver code, flag SAS_TASK_AT_INITIATOR is only
> set, so drop usage in that driver and then everywhere else.
>
> This solves a use-after-free in the pm8001 queue path.

Applied to 5.18/scsi-staging, thanks!

-- 
Martin K. Petersen	Oracle Linux Engineering
