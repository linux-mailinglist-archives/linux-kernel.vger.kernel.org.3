Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8997D4CCBC9
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Mar 2022 03:39:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232868AbiCDCkJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Mar 2022 21:40:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232738AbiCDCkD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Mar 2022 21:40:03 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 569CE45ACD;
        Thu,  3 Mar 2022 18:39:17 -0800 (PST)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 2240ZbZ6028323;
        Fri, 4 Mar 2022 02:39:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : message-id : references : date : in-reply-to : content-type :
 mime-version; s=corp-2021-07-09;
 bh=Jw2r1B3QDoOrcTh6QjS8F+mwFQbmB4nI/3MuNnRkSMs=;
 b=HTPR3/gjtyMs7UyJOo9bZN2QGFVTQxfXV74CXt3ANrE43p2Hn++SXjAE7/P2Q6Slw48F
 v2+TwT8nsYK9VUCpjfWAbDLFrSejQ3uncAo8LcPB6mE89GF/t5wAjOvOiBykvrFYJa3n
 QTrLrIT6hFdsTV4Fu1D9Gn48XreZFGeOUfBf3wjScRKr2pxMyTAUWs2VSouUtwS04jdY
 164Yk+8smxY5o4mMyyyb7GN86qo68LofMtVVf0CXcHPx+5jw1UR8101m2B1pYRfXGZmH
 Hgp09J2IfAKIwO1xFC6g10hr8Tj8ugPO+A2pBc2YqSbeKkOQSIC7Q8voN2dafx5GYKjc og== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3ek4hw0kjb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 04 Mar 2022 02:39:00 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 2242ZZro193997;
        Fri, 4 Mar 2022 02:38:58 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2174.outbound.protection.outlook.com [104.47.55.174])
        by userp3020.oracle.com with ESMTP id 3ek4jfy4p5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 04 Mar 2022 02:38:58 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ly523pPYuw1D9jdNtKmxFhf7YtlHV6E6mEYubMainCQ286OFIneUnXO1R96P1whmBa2vcEoUYE8cDrkUAwWZO3wWCq8br1hn570p8BiZBVVvkZ7kaOJrlDJlRG5G9uccKkUR4byZ0CVINiz7e5wYFimTp+0K+9LpF0Y9ie++ODhrkDhvhubfVJUmDrRVq5QgR8Cf9KHuUXm0LWvShXrzSnNTnPQ30fWFuqUDlJ4rZJaL8pwDBr5CjotVKsDtWXNKR5rM/WJxTr7f42eLDVPBpDAkzjMDUNkVgAJrtEREEyN1VYF0IFBSD2o59g67EJ0mA4z6ydpu/0bOR+kfmqjCgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Jw2r1B3QDoOrcTh6QjS8F+mwFQbmB4nI/3MuNnRkSMs=;
 b=cdDvJFnEJennGNTyfUlPy75881d36uaEXua1Ixl5Mk+BeI5+DEMuB0HFABYPgpckFMnFFP9X6Jjm1kzPywCRaZwteQAhvruHvsrL8jGd28azrNWLL1KxfvrpCJUnevHgXrQElR7Wref4oLLVyEQJFmh+2pjIDa5FIjiYJjARugQkZ0YyPeDjCz6rcXTv/sjSqjfMb2Ex3EPCCWESPrpSh6mxT6OLs5k9f7oQASLDwCXBkVegWlR1fq+Bh1wFEamoJhE7CprsK/TQtNg+6oniVKUxG1H9IOo0HrN2uUiQvyezICwdAavYSaBVggXUTXWDuD9K46c2ZO/DJV9hGeXtwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Jw2r1B3QDoOrcTh6QjS8F+mwFQbmB4nI/3MuNnRkSMs=;
 b=uXEOnBfU0UdiWJ6CkQDccCNamtXFNqfo9qNXp6iRBRlnFVC4RRsh9Em4Sbeft/N4r7uudlXQSpvmOv9KjPmL5yP93aw2w2yxfNn30A56s03f5j+Y4OqC0MDBlP7kyWk35wkpccGW2cAUgwtmt3sM7v3BOF6laNtycnF+eYt5DSY=
Received: from CO1PR10MB4754.namprd10.prod.outlook.com (2603:10b6:303:91::24)
 by MN2PR10MB3328.namprd10.prod.outlook.com (2603:10b6:208:127::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.13; Fri, 4 Mar
 2022 02:38:54 +0000
Received: from CO1PR10MB4754.namprd10.prod.outlook.com
 ([fe80::b51c:77eb:39b5:f67d]) by CO1PR10MB4754.namprd10.prod.outlook.com
 ([fe80::b51c:77eb:39b5:f67d%3]) with mapi id 15.20.5038.016; Fri, 4 Mar 2022
 02:38:54 +0000
To:     Keith Busch <kbusch@kernel.org>
Cc:     linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        axboe@kernel.dk, hch@lst.de, martin.petersen@oracle.com,
        Hannes Reinecke <hare@suse.de>,
        Klaus Jensen <its@irrelevant.dk>
Subject: Re: [PATCHv4 8/8] nvme: add support for enhanced metadata
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
Message-ID: <yq1v8wuv3v4.fsf@ca-mkp.ca.oracle.com>
References: <20220303201312.3255347-1-kbusch@kernel.org>
        <20220303201312.3255347-9-kbusch@kernel.org>
Date:   Thu, 03 Mar 2022 21:38:52 -0500
In-Reply-To: <20220303201312.3255347-9-kbusch@kernel.org> (Keith Busch's
        message of "Thu, 3 Mar 2022 12:13:12 -0800")
Content-Type: text/plain
X-ClientProxiedBy: DM6PR02CA0052.namprd02.prod.outlook.com
 (2603:10b6:5:177::29) To CO1PR10MB4754.namprd10.prod.outlook.com
 (2603:10b6:303:91::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7750cb8f-349e-48e0-87da-08d9fd881ff0
X-MS-TrafficTypeDiagnostic: MN2PR10MB3328:EE_
X-Microsoft-Antispam-PRVS: <MN2PR10MB3328117D0D54294F9B11F8398E059@MN2PR10MB3328.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FZwlOEOJ44skkSsnu90aP/fTC3QObjybz9aA0x6W04PN5Mdw56bHWCIZS+8Mxn/vvo+/bCPYTBv1fXOF+FRrBY2dVl7MId+AufvzdvgKWRe2LsBgg8c40q1uTLQ4/d6+rbz+esyGaQMKvsXejytcSl9/0edYGMT/i/tdiPs47I9t5spAXeWdCLB18c2I1nxAfQt82AdQ/K0tLwvkNdFH4EI3snKDPO5C4Bd4iAzgVZMzjW7OOTwaUooG6NQKkGmCnRsE2dEMMy4YVE/CtrSz0XJ75SGKKv/ukfk4hcKgGb4UlS/M5FKGX5uA0M1J8PlffJBLata3++YJdM6x5Hybc9a9QskBoSSRmWdMED+DVNsBp4Tulx/CSZ8GPpS1qbOtwWjRPZhTycIewnlwuzvklJ4Q0IkI9f6hG4nQt9Wve51DRHJnduZu4JiE7IBIuMDuv+XYll2wgOeKz/eGNxChBYSL0IsKrOVUZofQQaVezFVLo6av8Nu7Hi8x3bo0U3Ciq8VEPM/2omLyb1VrMIHsUOP/Mv/27AwUFl4byulnObR/Zfj8PUXC97JhxUbZfTRIfLXQgzU95id3Dpox1bjx9zu73kPtlKLHKmCXm/TApUa1Rlsx4LoTgTtPM18jGhu1MvgxaSIEdHF7BJ5Gz9vfQPVF1b38gBxxu3DosVUOqbCcSO4QITBSS6M389l+5Yki4dRRCnH4e4e+O+8i7dTtPw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4754.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(83380400001)(6512007)(86362001)(26005)(186003)(8676002)(4326008)(66946007)(66556008)(66476007)(54906003)(6486002)(2906002)(508600001)(5660300002)(6916009)(38350700002)(38100700002)(4744005)(52116002)(36916002)(6506007)(316002)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?sNyDvV+MAcrxkpI9x/V8vEs49mJdUUi0TIzi65O9CJTnF6ysvF+etrCy+tQI?=
 =?us-ascii?Q?oyMrvPj5fbBX8zAxni5BoKrE18AWGzcQ+swjYhQpXPkuelqYgd7syU07VVIV?=
 =?us-ascii?Q?kXhm/9dKwUNfjuDh2dvP8ECaf1+jTC1+PaDR2QeAMecQLPKlr0pt1HeWVccD?=
 =?us-ascii?Q?eSXFYrzfMEfe1BmA9IzBg8uHUPbmVrEXjkuC2Eaoyzumrs35hGBp6+bONZz1?=
 =?us-ascii?Q?t+29FQBZ8FpBLqJ2LEUI1As0VkJtca9K2SlJ88Edm4tWa1XGIMB2/4TgEh2b?=
 =?us-ascii?Q?60UWuFueT7BWEJ/U/Hml8SZWrhwAwidKxWZAzhz5T4CfoLAHr2SZQX4ZGRca?=
 =?us-ascii?Q?KxPmaqhSrXlOEKPl6SYOPFd+tI++pnNQsm/MWcsnI7vFPeBy5yHvU2oaEq7I?=
 =?us-ascii?Q?v7Bz2mot3FJB/pxjEKVRCgZ6QT1i8S8roH1yMiElsd9rbIaksLjAK7egqEWg?=
 =?us-ascii?Q?iZGpgQL9ht6nSAjgnouiV1qfT4ws+B48kc8BWInMVpqiUje4E18tZvqKaGej?=
 =?us-ascii?Q?21LnZ55CAQ7XLFIwb2g8xtkzLKpK+ZmALGHIl9JHCJQ0JZSLo43/T8VPqvPp?=
 =?us-ascii?Q?AnELjp/wFscyJicXH9UyLuGyWWd3UFO/cpPnXzQkrq2r8zDWTLlMeiAgL5lA?=
 =?us-ascii?Q?OvqnobvOfICHnhPXhLXHFBywcAlc7KJxFBw7O2kvzN4VgVuADQYNKB/LAP0J?=
 =?us-ascii?Q?yg2vJfWhQImVNtHquUvfs5/204WzR3VRtJCVDs+tNXFwgfoU+w8v/YpUTYOH?=
 =?us-ascii?Q?rgcsq43f9e34GJSB7XUFbAObxQTL8Y4tEu9ztKCKy7E34mrguowjEQ98brkj?=
 =?us-ascii?Q?jakNabaraUXfUQf/qPd3ta71d5E0CvbV5wOFhBIMjgd1fxnvexids4e7H2+X?=
 =?us-ascii?Q?lao3H6k8asPvKIMPiYpmfSlyG0JojFuE4oIx/d+aC6CnVwzfuBjyBCyfz33H?=
 =?us-ascii?Q?v/W4XL1+rUJPYMKUZLIajAU9y/+AHhu72R9ucusL3SO0e8+tfM/KaWGGsTdl?=
 =?us-ascii?Q?yeo+rZktfPgmtOQHOOc6+Z3EsIz2A0Jrrj14GQ3OVBpJl6Roq/T++Ch9keNh?=
 =?us-ascii?Q?8g+hHrM0HkbC/ndsXOIwbPTtv7weY5CVbzNLEfH5jiO442l0lTm4YUqH2cae?=
 =?us-ascii?Q?WxLZ7Gs0r4edl3h3tEEc+sfXiaUbHzR4VRlG8FqCbmLvgGG0blA1ZsUgoeFA?=
 =?us-ascii?Q?QlfnkAOW+C+m7qzn1N5JzQkTmtlOvBqVlLpC2ydVB3iGTYZ3ZtKB9AnKRLwV?=
 =?us-ascii?Q?j4DhHVmOJU8SiiN1TEL9ViX67g1NDT/UDua+fNAhNTOODX8nYh44mUo41zPJ?=
 =?us-ascii?Q?t5dI3Dak0NN6zHRN9XPrxREoK9+nWaQhHpRsTbys+79uZ90W1HsaCUZktS/M?=
 =?us-ascii?Q?94B+ar9hyplhy+4blLMlJidXCsZdodBiLUDiy80Ztat27oNnkPCBgJF6F1Ba?=
 =?us-ascii?Q?VIk5AXmAXQejCJtGzM1zGvgRxSwGGnafgi9kzyaMqHnZiip1Ew2AOlZwUiOY?=
 =?us-ascii?Q?9VvUeaiO7oWzQdtzyfx+exY/wkEbAoCYX9gWdHaStvkth7vN0+pT7VJ3PZGj?=
 =?us-ascii?Q?LW4Icp4CyW420VoWkq370Mib42dH3sYuwGsNNrOmLuC3ToYw4AKWwPvBN9Cb?=
 =?us-ascii?Q?XRijN4vUyycYJ3HuERr7tqYJBWgpzyiN+bUoXYauZnt86mMSb3QTRBmJEMCI?=
 =?us-ascii?Q?1tHtBQ=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7750cb8f-349e-48e0-87da-08d9fd881ff0
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4754.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2022 02:38:54.4122
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Erp2YU7yEFxDSUdy2heZ1BlL2kkrjTSoUuIMEvFPV7T4tJ5M01sWGOiBvd0TY0zv2TLHaI1e9WH9MoCLDr8FuzPn2w9K8neL6CbbydY7sK0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB3328
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10275 signatures=686983
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxlogscore=927
 adultscore=0 spamscore=0 phishscore=0 suspectscore=0 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2203040008
X-Proofpoint-ORIG-GUID: IBy2xBhf2TuT-guvuSA_v13_ybqWjwbR
X-Proofpoint-GUID: IBy2xBhf2TuT-guvuSA_v13_ybqWjwbR
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Keith,

> NVM Express ratified TP 4068 defines new protection information
> formats.  Implement support for the CRC64 guard tags.
>
> Since the block layer doesn't support variable length reference tags,
> driver support for the Storage Tag space is not supported at this
> time.

Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>

-- 
Martin K. Petersen	Oracle Linux Engineering
