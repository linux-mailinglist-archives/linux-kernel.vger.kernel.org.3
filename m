Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8063E4A74E9
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Feb 2022 16:48:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345560AbiBBPsC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Feb 2022 10:48:02 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:36388 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233239AbiBBPsB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Feb 2022 10:48:01 -0500
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 212Fa9Mh022133;
        Wed, 2 Feb 2022 15:47:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : message-id : references : date : in-reply-to : content-type :
 mime-version; s=corp-2021-07-09;
 bh=B8+R82X8k5NkBmNTlsI/GcBiZqZVHCnk0yQICjtOgp0=;
 b=Pm6ZvZRD9h0t068EOIPmKBslt8HREEgmpSxP59XRduY7BKGyJJndvbeh5Mn/PHoriwQo
 3lrbylTWGvKxWmcHntH/GXeYZYJCpe0Eul4ft3O+bTQNmCnouOxXX3xA8lB3YbjsT3vl
 qGS3Gigl1iNFStp247PKG96aUPkGIsK4PDm9Y2Z2fBIbnMgOlN0qG5HcNHazAEADw33v
 LUcFNCOuboZDi7I6l1pLv2edcuVkqsA2u1ySpWD9+1Z5sYfuXkUwHYndblbZjbnxbNLz
 5u6ClRz2acUb/EYJgMSEWZM9+r+966+jjDivZPbTpKGogEGK5uIe1GrOSOSv4pLHJ4WX AA== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3dxnk2p010-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 02 Feb 2022 15:47:51 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 212FjRFk001203;
        Wed, 2 Feb 2022 15:47:49 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2172.outbound.protection.outlook.com [104.47.59.172])
        by userp3030.oracle.com with ESMTP id 3dvtq2wey2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 02 Feb 2022 15:47:49 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Yl1ghaPWTQsomHflVTclpxhnEtmY0N1et1xXRPu9zuC1s2CJvSpp9rEBkQwl3p3zdOnUAsO+8/dOt099uYhz9ouaipBVEuKqMEGVzmqLwNJKjz/X+6nln+rXDiBumpxFGOfQVukHoRSRxZhX01muh7Bwt2C17IAlmOHi+lmWOalxOKhGZ482kOw6SyC9q7Ez8n8kmOeiYRMMQErxiHyf8RWN9Z9As1Phcl2K/FQKAc2NiyXRCarDj7bVOKM5pO12PX/quS1JOGmFtFiPCS6r4vH9zONn1wtMsqJ5dM89Ed4zXy3x2vwVjWMkLvbLUNAdgyiLbW4BEV9MXKmkYnsyIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B8+R82X8k5NkBmNTlsI/GcBiZqZVHCnk0yQICjtOgp0=;
 b=C3lwfazb01smcVtZHBimYzq7K8KsnXlbUrHd9rTQkZSh50qdckFxQaCQGp2+XKWnukxdWhPsvNsni7GlKRtvf0rYehmKNe8ozhxJX0oIBfPiAna8i0WSjY/1aIuxVzVqcuQgrrfSFxOx8fZ3ksySGzg4b8XEOKfJmq/dTO9adVuAguYW4eX+cMdRCL4spZwfaSay3G39gPamYm1P1IegGZFpdQrt3pp8cvYydfjPLdYSc0ZOTIDX0RUjjNsf1K0pz/jvbwrYghhXlzjuZ0zs1jdbIs5co3ayorfvhlTsaXGv/xGr6ue3fqxj5QUi0GfznW1a3wMaRknbtqPsG9+xBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B8+R82X8k5NkBmNTlsI/GcBiZqZVHCnk0yQICjtOgp0=;
 b=SNb+qdtQDFjOC5nkjYm4Gl8nE2d2Nas2+PgEjRoWCUa3FzAEyfHzthvTreD+LYyAmbnQbXJ9gg8BaCaFuyobWi+Qd0SL+BUQ51y5C8VDEZaEdRr/AZ9LAEFfq6JQmrEpyd7YeiKqpkUr7dUyA7XvjPVzgwi/TAlkv6DO06FU3k8=
Received: from PH0PR10MB4759.namprd10.prod.outlook.com (2603:10b6:510:3d::12)
 by BYAPR10MB3157.namprd10.prod.outlook.com (2603:10b6:a03:14f::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.19; Wed, 2 Feb
 2022 15:47:47 +0000
Received: from PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::2d45:d1bd:ebb9:48d1]) by PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::2d45:d1bd:ebb9:48d1%4]) with mapi id 15.20.4951.012; Wed, 2 Feb 2022
 15:47:47 +0000
To:     Keith Busch <kbusch@kernel.org>
Cc:     Hannes Reinecke <hare@suse.de>, linux-nvme@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        axboe@kernel.dk, hch@lst.de, martin.petersen@oracle.com,
        colyli@suse.de
Subject: Re: [PATCHv2 7/7] nvme: add support for enhanced metadata
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
Message-ID: <yq1tudh2rue.fsf@ca-mkp.ca.oracle.com>
References: <20220201190128.3075065-1-kbusch@kernel.org>
        <20220201190128.3075065-8-kbusch@kernel.org>
        <aaf56d4b-8554-e677-119e-9d23c921fe0a@suse.de>
        <20220202154131.GA3077632@dhcp-10-100-145-180.wdc.com>
Date:   Wed, 02 Feb 2022 10:47:44 -0500
In-Reply-To: <20220202154131.GA3077632@dhcp-10-100-145-180.wdc.com> (Keith
        Busch's message of "Wed, 2 Feb 2022 07:41:31 -0800")
Content-Type: text/plain
X-ClientProxiedBy: SA0PR13CA0017.namprd13.prod.outlook.com
 (2603:10b6:806:130::22) To PH0PR10MB4759.namprd10.prod.outlook.com
 (2603:10b6:510:3d::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1cb2a036-5ef4-4b47-e1a5-08d9e6635c4f
X-MS-TrafficTypeDiagnostic: BYAPR10MB3157:EE_
X-Microsoft-Antispam-PRVS: <BYAPR10MB315757C65C8683594092C22A8E279@BYAPR10MB3157.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ght2y93WkvN7zpxjBf5wip9qDzJbcqNHvbri3CizreW9wj8hz4Ul568qayCcXK97qLJYTX5GX9iLB8iS3xr0QHRtfvhlTubggm55eep5RP0nm1wQnzHrQa2Z0ckCeKXN5rdEQrpSywsu5K3FgVbqPKLge/Onw8WdadbuJhctjvJKjnW//aGbr0R8vAVg9+kOTiFfZV1iyYg+v1H5OL73iukUH/1OHIrDht7nA1zpN8NB3b9ZHTfr7Ru9wweZ9oSgfNqvbOF4jAP4OQFLFKe5reDD1h5vqehCzWAHOYbvaRqZedMOlHgOOVPsTFu8X4tGK9LY7zCv0GT9cBOox003fFbZ/77lLtvEtLG0yGzmqbh1fbkz26jLtgvVf2xoBVNliRjHzlPqjh4ZKnCH7i530t7eT8KvOOMwb2Q7cxOD/uHm2Q3/3+DvkDME1AwlVOpcsNBArbvbzUSPTxEXHnHE6imu2o144PyepDiKx1/SeiyyDI6U5jSPGxmlBEop169MjWXN2g9DXJljYAGQ+5iGzCJqze4bg74OcI7KifE1RSWnX2zK07jberH9XHyBKfUxnu7KfabCxZzuelJ5vopsX+fpfdfeJFPGLb7c3sEwnITzzV6oXZcd+6vdYbcTOVMEbJxhgA8ZVKZTCboA6byokllffBhrQ5PpoO7RBu/AbVq6uBf+HovczyAjI+MCQvD5Ng7FEYApyHhddlTp1Snu0Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB4759.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(508600001)(6512007)(6486002)(6506007)(38350700002)(38100700002)(186003)(26005)(4744005)(2906002)(6916009)(66946007)(66556008)(66476007)(52116002)(36916002)(86362001)(316002)(8676002)(4326008)(8936002)(6666004)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?kwbYcyeSJ/Fw/V2Rca/VvQQcF5UzfqP7i4l4KTIrwO1ZJBh7B+FsO65krBux?=
 =?us-ascii?Q?e7KCuzpaKLTyG+2iidXvSVJlqBdNEN0NyxUbQLJK6LRc7fjkIwRbN8BGdTMj?=
 =?us-ascii?Q?M86YgGFsZtmBr3XRq7UmY+KXjmEvzpBIxXHwHXTF7bBABIzjyuKqT6g1fZ8q?=
 =?us-ascii?Q?2UOMlIqI7P2SwS9RBhXsiRyOP7VMrIlj7cFxxrb+WdAHIxUkcvDqm1IWiox4?=
 =?us-ascii?Q?19hmX7UolK8bf+s/bUeuzKOr9g2QdB+Lk3MqsqobU2M2vw3wD1y7BA9dx1oY?=
 =?us-ascii?Q?Q1Ivmg159daGAHkTRElomEmECNE20Nwo2jEMBN7ULU6/Y0QaTUXtiDhu1hVu?=
 =?us-ascii?Q?qm3GZCkAPv0vf55RiYm+zi9qXOGLQ4Tnwf3UA3wDKX0Bmv/I3yEiRnt+2mvW?=
 =?us-ascii?Q?tAEKEVLA6djjxsnOphwwbH1Mq1wwMHAjuaZpRXge6k09AMn52ne87li7pcgk?=
 =?us-ascii?Q?YwRojguTKCmx3cYGwRduzIGJlBd99D8Is7PgDmGH174fJf5Wk3DALdcNK+av?=
 =?us-ascii?Q?I6RNB2k3Q4l76Jbovccq0y++oQYV3mrEOKWVtYbUtNQu4AnUpNi5ek9kow27?=
 =?us-ascii?Q?zZgz9tDtvUbn69DgF9CsGM+qnitdP5hkWju7wzJ9gT/dz2TS62IV0bYyXYH7?=
 =?us-ascii?Q?u4xQ6waNIM6CNx+23LI8XpWawpw2XD1nBIWPvcqwdMWcVgTxkn494rSd5ong?=
 =?us-ascii?Q?G30gctYrZY0SAfLdiIszY5+AUknTUmMi022sNJhgTUM3FBA0r4Yjq0EjJXbR?=
 =?us-ascii?Q?I7zUfGC/s8pYggU5PeAwrVuCyok+iH/M08OMDtMkJIgsezK8meP8/bIUaib1?=
 =?us-ascii?Q?R4rK9KCTlHDpiCORSl9/uOgrbVv2S5BreYLGBhtTHkCw4mJgK/OQRhR5bamL?=
 =?us-ascii?Q?s5VrYDKiE1EZ3AKwKTzVdKn//KqrAa/9G0AGCKL7TQh3/FLIaHpyhfQJkugB?=
 =?us-ascii?Q?QOmEp7fURFgDoc3O6p8UkDeOoQ0XXPURo7BzF9PK13YPJgQKs4Ef+7kHLvsQ?=
 =?us-ascii?Q?2gFkizJyX0vKdUm7ZNfY4gd2kQpaQhCiGO2voGfT+gEBoYDq0/A+1mGZfUBr?=
 =?us-ascii?Q?/+NmzZ6QBXJurhSYfZeuJSD8bXloLv3ptFCOMEjw+OpwZhOCpfAUSfo8zc2+?=
 =?us-ascii?Q?XXztblhxEN7RliAV3fmCgGt1flRn/XymSfwLuXD4vDktjyN3RquTvJX0D7Kf?=
 =?us-ascii?Q?5fsr/ruTR3UiDmL+vhsrKhvRkJgZQGUSvkXZcPdCHVusfn+jeA0FjnDFWPa0?=
 =?us-ascii?Q?X/3ba7hGO8ewMbmO5zptSHDAhzhHiFmla2zf+7ZZY7JvqIN8p7JEqjtqeq/e?=
 =?us-ascii?Q?WP0cOwyxkcHLylDkM158ZpdMlclRs8wzOCxVN+4YmLaEQ374BcvGZmxXnYFo?=
 =?us-ascii?Q?KeIxsQDObSB0q2oSfRDIyLD+5OTCFd8kXOwxjv0u7+j+GYro5Fqj+PSdhmuX?=
 =?us-ascii?Q?4S0VRY27LfFtBuBXBbXtOrzElljEimDcXA/VLu/ADXGZgbTKk2A9hnvvVPe5?=
 =?us-ascii?Q?u85RzRgCYOhzoJ95TO5uPYu/VwYFwigxs6uleyW5JvrjcdSUW6J7kEhwlU7b?=
 =?us-ascii?Q?xlYaQk8snUqfAjrKBGB3PvPT+xH5KR8PLruvapLRsOG4gld5FofGY3l3yoLH?=
 =?us-ascii?Q?15BnCVndl94cY4wpUx1KJ3IvdwpzMUKsz2cUy2/rrSJlNHD0vab/Zq1u66I2?=
 =?us-ascii?Q?lYevww=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1cb2a036-5ef4-4b47-e1a5-08d9e6635c4f
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB4759.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Feb 2022 15:47:47.5788
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 17SjBoz3KteneKb+bznSAambSgUMdUwX6uG6Mr4tdnyYyy9VXo/FPK/uptng3hdxdg2nhx36nqdZ6ppMqMUT7Se4Jz02PWKNsluFLSLarao=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB3157
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10246 signatures=673430
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=863
 adultscore=0 malwarescore=0 bulkscore=0 suspectscore=0 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2202020087
X-Proofpoint-GUID: Fy1mNsSnOwBYEslvkD8RbDCtVNqExFaS
X-Proofpoint-ORIG-GUID: Fy1mNsSnOwBYEslvkD8RbDCtVNqExFaS
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Keith,

> For type1 and 2, I believe tag_size refers to the "application" tag,
> which is 2 bytes here.

Yep.

> The reason it is 8 bytes for type3 is because there is no ref tag, so
> that portion of the metadata becomes part of the opaque application
> tag_size.

Correct.

-- 
Martin K. Petersen	Oracle Linux Engineering
