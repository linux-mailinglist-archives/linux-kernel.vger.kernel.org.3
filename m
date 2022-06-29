Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB317560470
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jun 2022 17:24:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233605AbiF2PYD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jun 2022 11:24:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232753AbiF2PYB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jun 2022 11:24:01 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 894DE1DA52
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jun 2022 08:24:00 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 25TFEFcv008903;
        Wed, 29 Jun 2022 15:23:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-type : content-transfer-encoding :
 mime-version; s=corp-2021-07-09;
 bh=4B1u+ZOzjpnuv4UcW0fo3RUxY4gWIe84cvgV8t+XeVc=;
 b=w5xQsPCRvfzVa7LGA0gEbqT6ymaEV4FOx5SSu3ics0ASHW3Jq13dnhAGiAVdUXBqvehe
 Zf2UcoIulUPo7f7hVOFyI8xK8bUzwR4IGmhRhWWBRKTw70mYEc4g0hzhoM68eKDPMf99
 PuXPqkVY6X5McKlg1i2m2fEew4B3sTxXSDCy6/XRY53WUNcZynBXQ+kLHRi4jIauE/cc
 S6E9xrT3Q3lYg86oCj8A1PfznNl5wmQSn1kb/0l4h+iC0PT4jIMGbOLRhVGYnG1wtRAj
 +FVwftcpPSav1u69FBNBurmQb+n8TVquKoEgS9isKLSEhNXLXWMZk9L20wrYr8MvHcni iw== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3gwsyshfkk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 29 Jun 2022 15:23:53 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 25TFGsTN016936;
        Wed, 29 Jun 2022 15:23:52 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2168.outbound.protection.outlook.com [104.47.55.168])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3gwrt3duhd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 29 Jun 2022 15:23:52 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KcYLc9jVdtWPRcyeTe6RomzE+jSD/WWFXgE8lFluxgA4WBi1Oe6zeRBUeEOopn8EDM5pEQJbaI+k9EpCyshsZroNYkj0YZ2Csy51LgdSLw2SAJ7fpbexqhyzJBXsP6hdX/Hk1Py2w13C1pNLokBFxnEwMLmKz4NJ3FPQIjyPXlLvIG7LcRdkTgutmMRXkf4yrKmFibMn4LdQ6nNmcKlTdtRLVzadrZGhnyJuC/I9xYhY8RHtMeDOBBGO/uxIdDtoYpT2XXwnNmrRCRgWeoSI0Q6iKwnZtxNIkrql/U3Ya3zJGE1QhTGbP38dtm34f/IzDyJNu4UZPHm37QyI4aoWzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4B1u+ZOzjpnuv4UcW0fo3RUxY4gWIe84cvgV8t+XeVc=;
 b=obm2cwwUK7EUi60B/z4tect/zWWzmVhIlcC03AvMUaaqsVTZbPimzfajNNTcoowlJkDUnS80GBx5iU+g/X81WEpBWc0AOYgfN/15a7NSWVoygrTkC/Ak6wNgDq2gxtnoipV5vFL5tkW+iX/OSdhNt3T39T1oTvDEb63M47Ri8JiV4SRnvntci5SxtzPqU2JL0Y+tnXOU8TJjkUv3crUb0A8p91Blg7HJ0GwWnbQ74NbvuiX0CtntUPZq8g5Di5qL7zVXTgcYpgruZhZaczzoZr3jqAbqSytEQ3LZmcnCESJ1sF1yFNiNqS+VdbMnKXaekt7o8u3K1C86gzY3zjfz+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4B1u+ZOzjpnuv4UcW0fo3RUxY4gWIe84cvgV8t+XeVc=;
 b=ISgLo/OfOtXPvG0MzylU5WKAJKQ1JMrnD97EdscjxeYckzZHlXD/H2K6QRpdYaTfPbRiCt5zpn9dVlS4p+0O51e8RJ2d3e0zhSr8bNJlPmPbyArpwiTi6oqD5DXOrojItJrBCc8Yw2gqhVmrrS4m/OuLFz1vxr39YqGSN+UFoF8=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by MWHPR1001MB2382.namprd10.prod.outlook.com (2603:10b6:301:2f::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.14; Wed, 29 Jun
 2022 15:23:50 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::f59a:175d:d24:949c]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::f59a:175d:d24:949c%7]) with mapi id 15.20.5373.018; Wed, 29 Jun 2022
 15:23:50 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
CC:     Yu Zhao <yuzhao@google.com>
Subject: [PATCH Fix 0/2] maple_tree: mas_spanning_rebalance() patches
Thread-Topic: [PATCH Fix 0/2] maple_tree: mas_spanning_rebalance() patches
Thread-Index: AQHYi8w7XECxXFjgTEaDxU3Vqbf3AQ==
Date:   Wed, 29 Jun 2022 15:23:49 +0000
Message-ID: <20220629152340.3451959-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.35.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 70062e31-67ca-4552-ea06-08da59e35e49
x-ms-traffictypediagnostic: MWHPR1001MB2382:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: N8f88oG3A6u+eG7IXrCfrcKwblYAGAz16bqN4qYutpZmJzwa8zKdrfgQs06cdOoVOnRnV2NF+U7UzPHJ2tFTEv23Z/gCd5Gds+jNY/QNJNuSy5JUVoaRzCqvlTI5coi1ELxzMDTA3M9KudbVfuBbyMX97H35vgIu9UTVnz6uH/45b2yr066UV0hI+Nfcgy9I4wOvWbnXMBws1sMVpvM5nvZHwGDj/cveSoX2p4PN/bvmk317w3PI1rGQf5I9lkjyfwryktkEEr/gA1+HAh0Z66hju09U/nR7JEdQL2dSi/8oBuhZHcm4BjfgYtuK+6B+S3Rvx4j6kexxJkIWCNEX9czVM5+7rNMi5uqSqD1DPT2i+2W9cU3xK5xPsT0s9F/f/fyFYblA3ir8N/R1MenvlxD6p9ASPq1npSSiVxBnAydhSLNHSoLt8688yHdDVmnzYJkDjuTzung7w12H7Z9WVcRDpIv3jG2tDevTGRebswHWVgyC4PjjuC1sZk+z/4+F9S8dRQvwzi0KB/Aa9n4fk0rex9Wofwfof61gDDhyK40OsRfLaIMY3hGzOVjo/s1rTh1dD0E4ZgLoNZrvtvYsfqMiV2ttxvl7it8CdV+8tsBlnL/Mvo92k6HJt2LaDm/OsboQmum5isAW9bTgGic5gOcyryXhm8YD0mT8e8oF2ZuYrymSfllX1SNvQZAoorS8wUdVMWgLo72GuxRCVL+BmMy+yOs+ZHgnxs5BUhC4Rk2vDsUSsASb6NWXoba3jIXf+VaLsRGGc601cNVV5pP4Nyx+MDiT2oF0yzM0lLNKFjM=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(376002)(346002)(366004)(39860400002)(396003)(136003)(6512007)(2616005)(186003)(26005)(1076003)(83380400001)(36756003)(38100700002)(6506007)(2906002)(41300700001)(38070700005)(110136005)(122000001)(44832011)(4744005)(5660300002)(8936002)(478600001)(64756008)(91956017)(71200400001)(6486002)(76116006)(4326008)(8676002)(66556008)(66446008)(66476007)(66946007)(316002)(86362001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?0o46SMfOTcv0k9c2VpbzH/IbsxXjvniexm0gDF26HI3bAghLTk+4CCTzYg?=
 =?iso-8859-1?Q?GV7kEZIfFz/2Ftuu6JEYodamN0ztdxMrIDADFc3p4hl5aqmTrtFnW4S6Az?=
 =?iso-8859-1?Q?s+D09z1qrqx9v6XzhEAFr4XVFjq6KM2uMClcENB1v2hdG9drrjYzWI/2Si?=
 =?iso-8859-1?Q?qML2SbOvXZxX9ox+UxKJcO1siofbTf6N5lQGMf2OYXEy7TRpJ3e3hXrEKQ?=
 =?iso-8859-1?Q?7GrUrMefKJH9P110p3k+gprVT/DvDN6JQdlB3WaGRwI6Gft6dJeqZHpnfi?=
 =?iso-8859-1?Q?VfZQIkUhERYrW+JS9cmg9zWLqu1GZ+02Kn9Hqu4LA07NYFUn8ZxPFbLPGN?=
 =?iso-8859-1?Q?GMh4YUTPThx9gHAyGFenquY2R6aSU/WOyJ4ehMHYms6hco6GLsA7452zOX?=
 =?iso-8859-1?Q?W1oLgiJfOIr4mfDDVUpYEAITw5S+vQNMZMDDPSL2qrmaJcmEmZb+7EXxp3?=
 =?iso-8859-1?Q?VXg0EN0PxetzWPJV/0AK4NAsGKSOiGd93FbHZEgqlvCMFYGeFChb1jmxVz?=
 =?iso-8859-1?Q?RH/04bSbOHx53ncA2Ib1uTbLZgHk8plDbdk9xJZr9MTMs9JV6W+90RZLF5?=
 =?iso-8859-1?Q?PcSIhM42K/hDrTkTecEREvIuii3qn/89S9PibPxOg6g1CBmiD+GEmRt8ZO?=
 =?iso-8859-1?Q?3ArcBQ0DpjDT/soXcHdOMB+zJjJb5xbUPucPP2p5BRvA9891kFMfCS0jUd?=
 =?iso-8859-1?Q?WcF17+B6YM7VnxGrinPz2xg3utMsLHWGHxhv1hn2nDS9yFcE1s5O4zxwHU?=
 =?iso-8859-1?Q?vW/E10Z0GYttmmcp2KCb+Jmkt1phxjs41hVfHkmSHjQiy2/QURmyl9j6VF?=
 =?iso-8859-1?Q?mWH11UIrlRg8+5yEyFb3yA24jki3PAx2IgUJW7zhbLnrMIBllLAGhWom5+?=
 =?iso-8859-1?Q?hajevhieiInON2mC9uH/88W+gE0VJVMNl7eWSp5FIs57OorcWBGWeiBSFf?=
 =?iso-8859-1?Q?zQL/2MQsWYz+0lCKRNlifneCQQQjD5MHN8L3nv47T7n/pFXPgRFhetZpoq?=
 =?iso-8859-1?Q?PONgzMen5gDIhBJhBQ67fyQzSW2cIVdwZQQRRd/WJNs3kjX/R//kLVQRuV?=
 =?iso-8859-1?Q?QbDQwRxeKjreY40D8jecZoK0A8bIXtMM/LCtke37wf9iCRYIpLG447Na2u?=
 =?iso-8859-1?Q?sHW6HBZ7lOA3Luxb51sPFQ11ibLQlD7wvGvvrzzHL6tsWT0HA0Iv9JghPA?=
 =?iso-8859-1?Q?oFn2MyiyNEnYYSxcWPyAqPBHMXT7AJHgt2xWv/LlcdyJIB8rXxq/wn5tQH?=
 =?iso-8859-1?Q?7897tTwdGG2Gk928CwY1gxyR+LvXhNzLo5kvHH2OYUKPpHuOY7HjHyzA0H?=
 =?iso-8859-1?Q?sNGCU1YhI0ewnPuUPUmZx/LtaG304AwIjy/P+uSnwzcHMVaJL8BEZQzaM5?=
 =?iso-8859-1?Q?23wucpNRJcxJplKAgK4q+wl+1B9iJ4cAZsmiEdgNMOcVkBtv1etl5HWNwX?=
 =?iso-8859-1?Q?qcJpNXmEoFyQvI0JcmaX/A30eFctPou+Qhk6PdcCopCII2MHoTukmBBLw1?=
 =?iso-8859-1?Q?NHwOXmOFv/z7masuZ9xzAItTca/LfGBGndYta7pDwuI5lkl389T8QsLtWM?=
 =?iso-8859-1?Q?V1KCL5q8X7yBM8CQWKi2xWUYvPxdeTrEfawhXeZmgCdvG78OwBpl5J+7ml?=
 =?iso-8859-1?Q?KdNl5KulOGSiZ7PHqeGHS36GG5QZ4MquTOYs4dGMyLAbFSJJTz3bFKDg?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 70062e31-67ca-4552-ea06-08da59e35e49
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jun 2022 15:23:50.0072
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lcsJ7qVFZK8Ztn1UY92n6rWgoiR+YCdWDam4kuKaGNDUAixpgz7RtrtYHSlL+0lTRJXFTWEtwSEu2gyj5XJ6MQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1001MB2382
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.517,18.0.883
 definitions=2022-06-29_17:2022-06-28,2022-06-29 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 spamscore=0
 malwarescore=0 suspectscore=0 mlxlogscore=966 adultscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2204290000
 definitions=main-2206290056
X-Proofpoint-ORIG-GUID: rKo5GDSJFPpRBck3tdyYmZ5WoS0Z3fhJ
X-Proofpoint-GUID: rKo5GDSJFPpRBck3tdyYmZ5WoS0Z3fhJ
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew,

Please apply these to the maple tree series after the indicated 'fixes'
patches.  This fixes a soft lockup reported by Yu and adds a testcase to
the test_maple_tree suite.

Thanks,
Liam

Liam R. Howlett (2):
  maple_tree: Fix mas_spanning_rebalance() corner case
  test_maple_tree: Add test for spanning store to most of the tree

 lib/maple_tree.c      |  5 +++--
 lib/test_maple_tree.c | 10 +++++++++-
 2 files changed, 12 insertions(+), 3 deletions(-)

--=20
2.35.1
