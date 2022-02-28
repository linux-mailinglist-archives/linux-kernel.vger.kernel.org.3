Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 080A04C6126
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Feb 2022 03:33:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232631AbiB1Cd4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Feb 2022 21:33:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232343AbiB1Cdw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Feb 2022 21:33:52 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B88E3AA7C;
        Sun, 27 Feb 2022 18:33:15 -0800 (PST)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 21RN94dP021511;
        Mon, 28 Feb 2022 02:33:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : message-id : references : date : in-reply-to : content-type :
 mime-version; s=corp-2021-07-09;
 bh=R8ySC4LZ1/0UkAGWzugbE9gUlmHvHbFCnSrUD6rG2v0=;
 b=C28NdlSD98/lEJFM6MkCSO/7wAWk/feAYyMCfjvM0V8oLbug3Kbf7qZxZXR0hZ1yjncL
 eDH1kBpgrGOp77Wwz8ZIN1nM7L99xYnQNl/vAyLyCPR9pAexbOqwBEoUj1DXQPyOF/au
 Oka3Y4JE2Rv7wcEefOKNb4nlqyBdMnSWFtsw/FdPDDDL+V3TL+9bUEd5q9BGblMcEYvM
 Eko45VabD7wfmoysUhUnQJFQIdZtgUiDMkDLqm4z36+qhnxnVrUe7bdTlqc7mR9R5A/q
 Aqn8OUOx0Ap5iCwx6AD0KqTXDdsM+6fvFNfR9CubU5Vzrw2+JylGwMEj7ZJzde4VpFmZ tw== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3efat1txew-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 28 Feb 2022 02:33:07 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 21S2VFeU087121;
        Mon, 28 Feb 2022 02:33:05 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam07lp2047.outbound.protection.outlook.com [104.47.51.47])
        by userp3020.oracle.com with ESMTP id 3efdnj9njh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 28 Feb 2022 02:33:05 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YMwwnw+Qpr3547nkZ4FO6vOp5xFa+fiiynRCCU1hp4PURntpkUezI1WUU6F3HLINziqwP6QPPY474OXwip0vu57jWs0WzSmFi0StcBNfwv13I2f2CY48gnBeVi7e6QRIVAImedm2A5v0a5aVIHgPwu1ctgID4AR9GbXduFex17j1cSzFcX8cAo81tehQX7cOtFP9XqrFBFZbRHiJIaseXwaiOEMstWD2cSpm1EWyX9YG8kmnDiaYuyBTt0rNLCec/gtfVlaydqHcShxxOFrj/HaU1exALBTmhixevK/UvE2F/LZ17I7xE8sEw68A8SnmuAR0TxWXPrUA+KyPZ/41Ig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R8ySC4LZ1/0UkAGWzugbE9gUlmHvHbFCnSrUD6rG2v0=;
 b=m902n5YsaSuS5+mO6j1uSvJkncjgYvBH1w32qisanUG1541lbZiqTbDLn45VoOxsENosdOLcV7qZhWO8uMLOFPJ/6so848tRENUFHiYRMm459hRdgayURgHz1CtrJb/0MgC3TM20E1ANFFrL2VEDvMOIGJkcfJyU7PPI2iZuV5YG4p6n4r13c2zpPu6gh+2fC81rPqMPtPCeu0AcBbBmaFhekx/z8l3JFAljVG49/pGtEgJNnGxg+6XFMt/szgI/AGzR2iGvmHxUuQnHVvfzEz3fR7pxuuIemJ+KNZZr2r3T4VU9sC1COeH/RnKdNICSdfXht4C732t2AD07UK7vPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R8ySC4LZ1/0UkAGWzugbE9gUlmHvHbFCnSrUD6rG2v0=;
 b=h6lELaPcwj4PXheI9MHX5Jo9M313Eb2HaLVPJAWS+jpKZHZ1VWEFipZeNgqQiEtbi0BEYR4cV1EH5awXK7NVsikeQhrzIQzIqVlV/Us3FTfJCWVX5yWeX0/VrawtT8gNH3UhME/Y8MrF6wGeqjtG3s2qipkQgqTN6OHRL7CTw+4=
Received: from PH0PR10MB4759.namprd10.prod.outlook.com (2603:10b6:510:3d::12)
 by DM5PR10MB2012.namprd10.prod.outlook.com (2603:10b6:3:113::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.24; Mon, 28 Feb
 2022 02:33:02 +0000
Received: from PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::180:b394:7d46:e1c0]) by PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::180:b394:7d46:e1c0%6]) with mapi id 15.20.5017.026; Mon, 28 Feb 2022
 02:33:02 +0000
To:     Khazhismel Kumykov <khazhy@google.com>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-doc@vger.kernel.org, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org, bvanassche@acm.org,
        Hannes Reinecke <hare@suse.com>
Subject: Re: [PATCH v2] scsi: docs: update notes about scsi_times_out
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
Message-ID: <yq14k4j90vd.fsf@ca-mkp.ca.oracle.com>
References: <20220219001601.3534043-1-khazhy@google.com>
Date:   Sun, 27 Feb 2022 21:33:00 -0500
In-Reply-To: <20220219001601.3534043-1-khazhy@google.com> (Khazhismel
        Kumykov's message of "Fri, 18 Feb 2022 16:16:01 -0800")
Content-Type: text/plain
X-ClientProxiedBy: SN4PR0701CA0017.namprd07.prod.outlook.com
 (2603:10b6:803:28::27) To PH0PR10MB4759.namprd10.prod.outlook.com
 (2603:10b6:510:3d::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4dc1ce32-0a66-4c19-0f22-08d9fa62a47e
X-MS-TrafficTypeDiagnostic: DM5PR10MB2012:EE_
X-Microsoft-Antispam-PRVS: <DM5PR10MB20125F36D0DE8A7AA1BCCA698E019@DM5PR10MB2012.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: w9rOYzEcxwFszk9RuMu8P5H97DSfSERk9rWAbmuQs6YCTn2Bj1aTaSALoA+wUjXSdOQN8esxoFREp9wlwoEa+vpzqUviyrncr+np8TwMsQfJKZre6lVLL/qpSlDDegz0fhEpBlaCZ2vQKFD6be/o9E1xDXyGQt5DZoqrHGyGqpOvnpyyisOciYIZaDxYBI8FgiwgJYdiDTzrQgj2aSK6VCwdSiwH5Vph1eb2wgjnm8Xr+8TA+ivKKa4saYJArglShCemwdCLehE7zT+VLI9ZuffW1VDEGd0t5WX712+z1mTmEaOvl2aiH7RkFBrUuDSXx5Gfdi2ceTSOb+/Frgi1mIDIoGHgvYPOmVZn/ovXalSrDanhm972kS+kR/MaL7s4jeuA1DUNA9yB6cGzuD1AvRfIV+07YF4B26UsSTF1O6grGpzAIGqBd8+gib6M7SP/28JIqUvMZRHuLbGisTHdcTg9UXmL6R18xUlw6Tbu0crcgwGm6QSs3cnlN+MKgxDV3Bx4gA+JUq2KsqMZArGWL6VRWHkokfl3l+zc7XJlUpyVaCNFbNRHOxnGgzdvlzER9TB+jrkw3cI4uPDkSMQSsbg89XFsAv3AiQKV+QtKQi6RZzxw1/Iavnztk14u37TW3YCnwjy+iJP249orZLWHSpmappj/U/WvKsAM+PSf8MJXYfPiALbX5optgnlz2yMqA2gbUD2TDWiGRmwynG/3uQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB4759.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(6512007)(316002)(66946007)(558084003)(66556008)(66476007)(86362001)(8676002)(4326008)(6486002)(6506007)(38350700002)(5660300002)(6916009)(52116002)(54906003)(36916002)(508600001)(26005)(186003)(2906002)(83380400001)(8936002)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?HnRbVt6wxzqJepryZbJOVZSCWcnsTyp9/fSANPbKy+Z7kexjovgrGaiaTZRC?=
 =?us-ascii?Q?n1eBpD2le/bxMeopL+OYqvWRbiUD4mbySmDAxn87i46p1X4olnGLfY3AOUHJ?=
 =?us-ascii?Q?W2oX1u1h+D4HBalh/3xfg8N9LEeS/PNTEUBH76uus+LFLZmQ+2C4Mxe7pSby?=
 =?us-ascii?Q?7q/2oCIwk/mzng4vfNtkMofWO7BO+ohzsKDYkyDRq0PK/qY/4AfETaErE8Jn?=
 =?us-ascii?Q?QQUiRcLcuZZJ3YiRcVD9NudtviBtFhlEDxABpFcILByYfhBQ/rWYK9jkrbMZ?=
 =?us-ascii?Q?Fbf0/tWwd3gb6ik3xSJ9VFeE25JZ4v8tM4MDxArnEC54ujPPf+NfQbWZuYn1?=
 =?us-ascii?Q?nsFjAG7qa646m7tva1xbyA/yPz4fB+HRzscJg9vGHTiTF1QtxxbpdSxIxRO8?=
 =?us-ascii?Q?2H3d9/8OTGD960dcsg7M0KrQrvtRnLxTCrtshlvcdqLq6tGTxn2SCRPZQogw?=
 =?us-ascii?Q?pjztxHJi826+6OtpJC2WpuVfDYkngeyUjCV+uQ7QB6azn008u1xjuPZGwiqX?=
 =?us-ascii?Q?LkYjGuSOdEd8OHA0NaaXuIzg+GEG+6LhPW87QR/KInKB0YRmR0HSkrVPrY98?=
 =?us-ascii?Q?TbrGAE95wCYukGIRVZ2PQJVl3GS9B6P8TSq464g+2dXklCquCO7QSrVl+hAS?=
 =?us-ascii?Q?FWC+Y6bimkhptnPHzwAq+Jdo1C30V/SJhlZJLNbN4vJlLHPTjK4YTDwKxX8b?=
 =?us-ascii?Q?aiwqiMxLqaOAKXRmlZ70D7oIcDn2YYO6mztMqqFjh8Fha0IOUF1AGZljR1Gv?=
 =?us-ascii?Q?IdJBmJxALBMP0NSRwn1apTndjUN1EQYkPoPswGQ7wLGayA2ExuJ+wmuDIElW?=
 =?us-ascii?Q?dAnjrtigZG4QVgtKLKyCpMcjrSBeLXb/gmGCd8Rnh63oM8WKLSTqhL8KPcU4?=
 =?us-ascii?Q?gdfeizwnNjpLC84hkRRA7D2MmbOrBSxZZeXVme2If5StKEVOvNlU/7rglUbO?=
 =?us-ascii?Q?kx+X4FBGIezDWXrICqpGC/ptY94Nmp7TXPXPVbJn0KFibvRFyR96Snr0k7x8?=
 =?us-ascii?Q?g2vv+Fqaq8VBiRqCKnQgeiXEwpZG3A7wwKNyPUhgQGyp6UWvRM1cetK7hzk4?=
 =?us-ascii?Q?37YbsLE2p1xBRy6/92cQJiRYbPy4dWT2qa9YLcpWYDKT2gmceOZL1UmbG1n9?=
 =?us-ascii?Q?E+gYfrCg5LsNJl/PQUCdjRAVv8S4jYBfoyorHFm81y5a0uaav00MKQhiOyE5?=
 =?us-ascii?Q?Eqkn07uk1dyeODdVJV4nRt5OsMP+n9EnVdguKV52yj1++1I9dPTVjRw1xFs2?=
 =?us-ascii?Q?aRQC2h8JWZMR8e5xQey+QJdI4J3EckzEawGu0Gx+yxPVxOLPbmbqMZBu7jA8?=
 =?us-ascii?Q?ik/v+Qtsj1Bu43mzwMXWXJ/xgXTy8up/u/5ULZ6NTHJs2OYKkgIhaMUlSTzJ?=
 =?us-ascii?Q?FGBb+9q6pgmzh6NhLvQPdY0CrJHhmaO3px5bBXBo0MsRwFVoxO7wMlR6wEUG?=
 =?us-ascii?Q?7JPgZiQi9i6qMVUZoA+aghkYHigraJKsAwJfyEQkSWELpA9EonftaU8SLluF?=
 =?us-ascii?Q?tcMYuzYHSdEcTYSpgMfLI57B57DIRfdahq5fnzZvVl6Jlr2OTZyiOlJVZZNe?=
 =?us-ascii?Q?iB5lr1ao2YV8DyJFpjeh2YM6OLvObr4JTKuC7FZkAQatCYPjZiHRdjR19AdX?=
 =?us-ascii?Q?dSuayzWNjPpJRoHXrQEPcbOiPy+SAcx0UgWQpCa/lQvkLh3p/t4l3O0pcqsr?=
 =?us-ascii?Q?Hvqbyw=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4dc1ce32-0a66-4c19-0f22-08d9fa62a47e
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB4759.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2022 02:33:02.4349
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: K0Tz5t90rAWnPPB5X6cUyRs4cnSTnA97N1tVyJiR5qL5X/J1T6O9UDSrh6n8S+6vzkTb/klsxTQjG0+5DTBoRQfN3PBr4JMSTidGr4RCq3g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR10MB2012
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10271 signatures=684655
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=882 bulkscore=0
 adultscore=0 phishscore=0 spamscore=0 suspectscore=0 malwarescore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2202280013
X-Proofpoint-GUID: 2ApnO1pC299tOtHpDQaWTBSnl3WuyifA
X-Proofpoint-ORIG-GUID: 2ApnO1pC299tOtHpDQaWTBSnl3WuyifA
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Khazhismel,

> Most importantly: eh_timed_out() is not limited by scmd->allowed,
> and can reset timer forever.

Applied to 5.18/scsi-staging, thanks!

-- 
Martin K. Petersen	Oracle Linux Engineering
