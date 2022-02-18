Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F69B4BBCCF
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Feb 2022 17:01:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237504AbiBRQBE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Feb 2022 11:01:04 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:41022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237402AbiBRP7a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Feb 2022 10:59:30 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 324152B4D9D;
        Fri, 18 Feb 2022 07:59:03 -0800 (PST)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 21IFqpO3014965;
        Fri, 18 Feb 2022 15:58:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=zvLTiSpUUU1YwDj/RSoT3xGG4McjR4UNj9+wn7bL0Ag=;
 b=NCpJI+joyp9VmM91DJ4Rua8NpvzMOrdeoCTDslPEUvXVFIAidj2XdUqVdZsAKqZ6Kiw4
 JpVjuj3lSNMTpYIxO506duudPo/0vE1qf48MzuDbUsDAfqhydFdK2A4+X0XCEMXO12AM
 Ji8YNEBbe/UZFpmMCFz+sIUNa2s2XVOEowXj3ln6K8JYctld2ZA25S+5h3u8Fr28I5+v
 LyM7hxRIVUglZZJmh/VIQsXbAtpMzF5/ukyFoeaE9dQ+pQkp9xFrjPsW2Qt7rHYYsmrX
 COMyjfuZQnVw43UTv7DNqrWW5eldyvCZz5d2T+HU7YiaEnjE9seEgjxiUAG/s6rznVFS aA== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3e8n3fh6ws-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 18 Feb 2022 15:58:25 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 21IFvKhF055304;
        Fri, 18 Feb 2022 15:58:12 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam07lp2044.outbound.protection.outlook.com [104.47.51.44])
        by userp3030.oracle.com with ESMTP id 3e8nm187rt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 18 Feb 2022 15:58:11 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lOUk4zhxLueGRJZ6MZK5lzCfoTZnvXpMWNs88+me2nf6iyTq+aVOdPYSxsiGDD+okTXW5gj/iYkMIQVsvNjQrD9ajdNekc8xraQfiljm5JmxaL43jWQqh2Aop4NgNUO600cKkK643bNxhB1pka+IIlJRozzT2bxnhuLvyAee7Rk/gkLgwyAbwrDMULr6fbzyGpFnovs1/KiBRmOkPxl/OLxifgUbp2U+7AS3sn4g6/lPyImuAY7xNp/khZuB2uVd/UAng3oT6oHuJ4esYX44+u18Gg2re8bsS9xGQbUBDc0QIHH4V6UOqxrHPn4bDmr4dbKVQle2Fii6Q75X1iMELw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zvLTiSpUUU1YwDj/RSoT3xGG4McjR4UNj9+wn7bL0Ag=;
 b=MAoDC/Dg+vMsg/6xy4mLUB3qs6znPV2oEmut/65YzbdnOnyDYbS6H9MUlYQ9b82kpejcRtRvcJrr0a4oir4z4TxE/ZRcGmd+cPlq2UGqaGdnw858k3W04pwntXiowLZvhueeqGKIJTrH/WgRoY3RRekCtZ8Cv+0V43kBAIA/Na/d08dmhMYLiz7/Au+bv5lNwVJ8C+5qWiumTs5lVQTEPmsyxCIAHDbQR+/mN49trMBR9y+NYfvHetMLVN+VOySBWenDPb83GbS7QOR2/ZC1AgJFi+1NaYTfWFBON7jxZKc1O9kM83xW86AJ38wzdbddr7VOiqEXnPVSude7C6XRfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zvLTiSpUUU1YwDj/RSoT3xGG4McjR4UNj9+wn7bL0Ag=;
 b=iqhMApE/33NS7fdgczTVK0/myR+nT91LT9t2hFKjwrQ4DjhVxx4J8Oy7sFF6SYwLedXMz5SN/TSN7o1iieSLHNoVYed3S4Dlcu0/XD7gE7zxjVc5kUGUtxI8bicZon1Q9A9xFzIyo4IhgbWcLZIEdoCupdvib3UIMOkqjrsezI4=
Received: from BY5PR10MB3793.namprd10.prod.outlook.com (2603:10b6:a03:1f6::14)
 by DS7PR10MB5312.namprd10.prod.outlook.com (2603:10b6:5:3a9::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.16; Fri, 18 Feb
 2022 15:58:08 +0000
Received: from BY5PR10MB3793.namprd10.prod.outlook.com
 ([fe80::398e:10a4:6887:4e18]) by BY5PR10MB3793.namprd10.prod.outlook.com
 ([fe80::398e:10a4:6887:4e18%5]) with mapi id 15.20.4995.022; Fri, 18 Feb 2022
 15:58:08 +0000
From:   Ross Philipson <ross.philipson@oracle.com>
To:     linux-kernel@vger.kernel.org, x86@kernel.org,
        linux-integrity@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-crypto@vger.kernel.org, kexec@lists.infradead.org
Cc:     iommu@lists.linux-foundation.org, ross.philipson@oracle.com,
        dpsmith@apertussolutions.com, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, hpa@zytor.com, luto@amacapital.net,
        nivedita@alum.mit.edu, kanth.ghatraju@oracle.com,
        trenchboot-devel@googlegroups.com
Subject: [PATCH v5 02/12] Documentation/x86: Secure Launch kernel documentation
Date:   Wed, 16 Feb 2022 22:54:35 -0500
Message-Id: <1645070085-14255-3-git-send-email-ross.philipson@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1645070085-14255-1-git-send-email-ross.philipson@oracle.com>
References: <1645070085-14255-1-git-send-email-ross.philipson@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0PR03CA0288.namprd03.prod.outlook.com
 (2603:10b6:a03:39e::23) To BY5PR10MB3793.namprd10.prod.outlook.com
 (2603:10b6:a03:1f6::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 23d29fad-c814-4474-d710-08d9f2f774c4
X-MS-TrafficTypeDiagnostic: DS7PR10MB5312:EE_
X-Microsoft-Antispam-PRVS: <DS7PR10MB53121FD42BA691A384F8D4A4E6379@DS7PR10MB5312.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nez6ukbao7eYcU4806YEZ5h8ihcWtkY5g1fHmn8jnmi3K/wMSMFTUFsHTqjrlEVpKQsgIm5KB9QYdiL7RdJEIyGb/0iFhH+kzCrpCcRtc6uGtA8aJSePLdalkjcSMWspuU7TP1qmW2wt22M+0lCOcw8pK9ztz4LL1jk0EWEd1j8o2GGgd7gGLYqK0VIZ+kOXYdE4slcaQboxZhozOMyvxf6YEj77Z1W34lnSzPWwbfF4I05BZ0pAJzTtr/2WnJGrLFx22fPs/+txw7jmDIuwuHLwyw9fKa/F5BU9DIAr+yTuk/R3DmqXRztrzH3yLsQ149wz9447JAFPbmyRInlZzaDJ3RBM7Cnb7ceOJ/BVZes49jVWeXmgibnt4Lqv++zwvVMawmM+0oivfo7gJHsoLrIOZNVyoCuZp2P5tGh6FzJp5AeA/XV9H2aGq3G1A0QNQyn3DjXqU5BMQdztmafYnDc7gEgJsbMc9WqtQD1hEMoKQ2XOcZqVxXKalPoRRwNwTYFGAP4iXfMVP2pq2NnyK43NyMr2f3EhhKfVvoUqfIEjs+MhNFSMn4qfJJGyqVAj+bVVHnHnttPIRc+1yvL03U0sSySNUt8duGvKnCeGqUkhrZgWHL3hH7JC3c2PN5puQe18eNZvF4AtfFB5HmOmPoTl8MFXlPcW8cCWp3Gfamg/YZSN8qDMBF8jQr8iakFVoxyfY5O726Gme/NGQnaBSy2/izUBqRekEJB/ERWvj3qBG6rcA7Lo44+LAEm/8jMY9SfJQVZi1MwqVYKbf2MOUAhgUOGC7teAgX9lCATjzVdZX3hfAhl2d7UmuYf9WcLn3s1s0BP63OxHqIrKu9dQo6rQz6kNxI/p+BPXl1T0HTQUfbbu657KPQWCNobnsV71TZ6OdYageDgzlpK9Mt6mEw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB3793.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(30864003)(44832011)(26005)(186003)(8676002)(4326008)(38350700002)(38100700002)(66476007)(66946007)(66556008)(508600001)(2616005)(6486002)(316002)(966005)(7416002)(36756003)(6666004)(5660300002)(8936002)(83380400001)(2906002)(6512007)(6506007)(52116002)(86362001)(15398625002)(43620500001)(559001)(579004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?b1d1cmRpbFFjVjNoQnZUWVFSOTNQVHphY1J1bWZVKzZoZGlwdVk4dVdCblhX?=
 =?utf-8?B?SmUxTVhXdnJKSmxvUUF6RnVCcmVIaVFzU2QwUXMrMmU2QjNCTkRCQ05rN2g1?=
 =?utf-8?B?U2xDdStsTnk5R01MR0Fsc2ppM0xjOTFNQzVFMTdUV1poTnVDVFhoMEs5eWdy?=
 =?utf-8?B?QmQxVllERWRpSmF1REwvUktPUm5yVHhCc2dKVGRQeG9TTnJYdzA3NFhud09l?=
 =?utf-8?B?N1VUN1BHUDlYOFJuUHRjWGFxbGNiTzZoeGRKNTlCblcwY2tNZTNtem1mYmJ3?=
 =?utf-8?B?Q2E4Ly9vd3VyWTI4b3BuMWtLR3Z1NU9LMFZVY1pGTDFEcGtoSWhnc3FyQThV?=
 =?utf-8?B?M1k2bkVzRnFvSmpaMmlKYTZ1eWFlSGJmejFpcTZiOFp4M2ZqVlVjNkpHc1hk?=
 =?utf-8?B?bFRLT1FZeExnaXAyWjQyVktWSDJxK21FUWVtcitHemFmRmE0SHhFMkk0d0JZ?=
 =?utf-8?B?bHlWTGNvRnM3cUFBc2lWU0tjVmR2bWJ0YWpubUxGUjFXZkhISWhqR1pHN1dD?=
 =?utf-8?B?Rnl1NFpNTk5nbVpxT0h2WXh1TkxNL3loeHdIVnJmRWtYOTlUY2F1dGdXZkxX?=
 =?utf-8?B?dmRpSnB2emNBdzZqdk92SEUvQXZhYTlsWS8rcGpHcitHSzRVbTBESE9aay9y?=
 =?utf-8?B?SldhOUZUMHdVQ3Z0T2RTc3FQL201VWNmMktuVEg0MktrNHlEeTJUcGdaQWpo?=
 =?utf-8?B?NmdWKzJDdHIxZ1Z5eklHOFhmbXA1cC84UkczbURWMXhxMk5hNnJxSHZ3Tno2?=
 =?utf-8?B?eGdIVnFhenpXYXVlUVN6N2Q3aHZUdU5vempXcVc3YlN4VUYxSVVDd3lnbHJI?=
 =?utf-8?B?U29DT1VTOEduVDlGWXRDNUpsSEZXbFdZSm52YmpXSVdPbzFIOHF1aWVEc2Jt?=
 =?utf-8?B?bVkzQzJMcE5EbjVVYW5FQUtFallUbmNEbHFSSjVmSFhCV1d5bTVYcVJnOW5H?=
 =?utf-8?B?c2tjN2tsK01nalBGcHlPSTl1SFZjbzB5RmtrZEZwdkRiZWQ3M2RVdklzaWU3?=
 =?utf-8?B?MDZIaFBpZVJNeE5YcEtLVCthOGhXZkJHNmNPblE1S0pYRUthVC9FYmdyQnkv?=
 =?utf-8?B?ZTcwNnNVTDFKMkI4bzhWaFFzS2hlakFUSlEzdWdyOVJJenRLQ3p4UFBIVkxE?=
 =?utf-8?B?dTF2MHh2c0N1WkF6RHFGc2greE9WWVpGMjZmbWFKWXdZbUorNG5abW9HRzV4?=
 =?utf-8?B?QTVPa0VGU3UrYVk4NzkxM3F0dmdXNHZyVU4yNk5Mc2xWakZJclQyTnhIS3lX?=
 =?utf-8?B?ekR2OW9qK3JEU1dVcHJHdmZ4NlEwUFFqOEl5RWlGTEdORmpVS2lETG1mczFG?=
 =?utf-8?B?UHJ1T1E2NFRWcjBMOFE2UjJXQnd6T0xadGFteVgvWDBIWUh0Qlg5MHY2Nm9t?=
 =?utf-8?B?bVpHVTArUXgrRkgxd1RjUE1FWGgyclRDNGZNVXczVnJ1OXRsdTcreTlJS0lY?=
 =?utf-8?B?V1dSSTBWd3VVMDN0RGJUMWFhRUoxczZldjdlTzBFbzU4c1MvY05jdVgvbjdo?=
 =?utf-8?B?dG5BNFZkM25RQXoyeU40V0p2SUlyekd5ZXZ4MFNEUEdseUFEdGdoMWZqVU9R?=
 =?utf-8?B?dkUybmg5ZncxeHY3c2lmSTkrQ1hTNkg0YURSWjVWR0lvcUphVlVZUzNXRnNM?=
 =?utf-8?B?cmRyM20rWU5KNjM4VkRGalA5QzhlUzRONlhsMDcvRmdSclhoc0Z4ZklXNWhK?=
 =?utf-8?B?c0l6WWx0WlBoVXVQb2pOZjR0bDljd0VUWHFLaEhTQ3FZK1lQRG5xMkpMRGtM?=
 =?utf-8?B?OEhld0NBaTE4VlV4MFJWMUdLaG1WYk1KSXc3cSsxeWFKY2x4TnFNWm53c202?=
 =?utf-8?B?SlZNNloyNGFQWjJwajAvM1lTKzRpMld1WWIrcUpTaTNOV0VtUmJXVjNzcWdr?=
 =?utf-8?B?RlVnb0tnL3FQS2d1Ym8xZ2Y4UDNBNU43YkE4ME5kcUljY093c28vSURzdG9h?=
 =?utf-8?B?cnM5Q2dZaTJJQldlc3ZFV29kNGR3dXova29UTmowUW1helpjTFREdW10c2Vo?=
 =?utf-8?B?bWdBS0FJRmp6ZE5kN1VPR1QwR2lwMjlqR1Y0MTlreGJRY2ZQQjhYOVduUGk4?=
 =?utf-8?B?UU5WT1NoSitoN0JoWnhYM2ZuckkybU9mdlhwUloyeXBiTjNQRzE0TEh3WlZP?=
 =?utf-8?B?dGl3Z1N6KzNiN2tJQWpyYWdyV0R2MlQ1Nk9HNFhWVitjZDZqK1JFaTJvUDdN?=
 =?utf-8?B?QWFvbC9oc2VLZnRJOThQMFJMQzFnUGRQNERIL1dCTm5MRDlZbURkQldFWEI2?=
 =?utf-8?Q?hvnQ2so9uXB7cfP8Ha1nUv29YVCboBLEaeDzRYIyUs=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 23d29fad-c814-4474-d710-08d9f2f774c4
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB3793.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Feb 2022 15:58:08.1724
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zzdbckMer9+fL0ymUvUS562p3IiExmQZLrR+bhFEdjvU1KXXE2OArqhde+HUXTL3Hmx7kZHYn52zw6jf9Xn/a6Q/ke24ug9dyuyRLwhzMXI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB5312
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10261 signatures=677564
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 phishscore=0 adultscore=0
 mlxlogscore=999 mlxscore=0 suspectscore=0 spamscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2201110000
 definitions=main-2202180103
X-Proofpoint-GUID: 3jUlINah4WOEIfawpJjPKOueE0t3zFyL
X-Proofpoint-ORIG-GUID: 3jUlINah4WOEIfawpJjPKOueE0t3zFyL
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DATE_IN_PAST_24_48,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Introduce background, overview and configuration/ABI information
for the Secure Launch kernel feature.

Signed-off-by: Daniel P. Smith <dpsmith@apertussolutions.com>
Signed-off-by: Ross Philipson <ross.philipson@oracle.com>
---
 Documentation/security/index.rst                   |   1 +
 Documentation/security/launch-integrity/index.rst  |  10 +
 .../security/launch-integrity/principles.rst       | 313 ++++++++++++
 .../launch-integrity/secure_launch_details.rst     | 552 +++++++++++++++++++++
 .../launch-integrity/secure_launch_overview.rst    | 214 ++++++++
 5 files changed, 1090 insertions(+)
 create mode 100644 Documentation/security/launch-integrity/index.rst
 create mode 100644 Documentation/security/launch-integrity/principles.rst
 create mode 100644 Documentation/security/launch-integrity/secure_launch_details.rst
 create mode 100644 Documentation/security/launch-integrity/secure_launch_overview.rst

diff --git a/Documentation/security/index.rst b/Documentation/security/index.rst
index 16335de..e8dadec 100644
--- a/Documentation/security/index.rst
+++ b/Documentation/security/index.rst
@@ -17,3 +17,4 @@ Security Documentation
    tpm/index
    digsig
    landlock
+   launch-integrity/index
diff --git a/Documentation/security/launch-integrity/index.rst b/Documentation/security/launch-integrity/index.rst
new file mode 100644
index 00000000..28eed91d
--- /dev/null
+++ b/Documentation/security/launch-integrity/index.rst
@@ -0,0 +1,10 @@
+=====================================
+System Launch Integrity documentation
+=====================================
+
+.. toctree::
+
+   principles
+   secure_launch_overview
+   secure_launch_details
+
diff --git a/Documentation/security/launch-integrity/principles.rst b/Documentation/security/launch-integrity/principles.rst
new file mode 100644
index 00000000..73cf063
--- /dev/null
+++ b/Documentation/security/launch-integrity/principles.rst
@@ -0,0 +1,313 @@
+=======================
+System Launch Integrity
+=======================
+
+This document serves to establish a common understanding of what is system
+launch, the integrity concern for system launch, and why using a Root of Trust
+(RoT) from a Dynamic Launch may be desired. Through out this document
+terminology from the Trusted Computing Group (TCG) and National Institue for
+Science and Technology (NIST) is used to ensure a vendor nutrual language is
+used to describe and reference security-related concepts.
+
+System Launch
+=============
+
+There is a tendency to only consider the classical power-on boot as the only
+means to launch an Operating System (OS) on a computer system, but in fact most
+modern processors support two methods to launch the system. To provide clarity a
+common definition of a system launch should be established. This definition is
+that a during a single power life cycle of a system, a System Launch consists
+of an initialization event, typically in hardware, that is followed by an
+executing software payload that takes the system from the initialized state to
+a running state. Driven by the Trusted Computing Group (TCG) architecture,
+modern processors are able to support two methods to launch a system, these two
+types of system launch are known as Static Launch and Dynamic Launch.
+
+Static Launch
+-------------
+
+Static launch is the system launch associated with the power cycle of the CPU.
+Thus static launch refers to the classical power-on boot where the
+initialization event is the release of the CPU from reset and the system
+firmware is the software payload that brings the system up to a running state.
+Since static launch is the system launch associated with the beginning of the
+power lifecycle of a system, it is therefore a fixed, one-time system launch.
+It is because of this that static launch is referred to and thought of as being
+"static".
+
+Dynamic Launch
+--------------
+
+Modern CPUs architectures provides a mechanism to re-initialize the system to a
+"known good" state without requiring a power event. This re-initialization
+event is the event for a dynamic launch and is referred to as the Dynamic
+Launch Event (DLE). The DLE functions by accepting a software payload, referred
+to as the Dynamic Configuration Environment (DCE), that execution is handed to
+after the DLE is invoked. The DCE is responsible for bringing the system back
+to a running state. Since the dynamic launch is not tied to a power event like
+the static launch, this enables a dynamic launch to be initiated at any time
+and multiple times during a single power life cycle. This dynamism is the
+reasoning behind referring to this system launch as being dynamic.
+
+Because a dynamic launch can be conducted at any time during a single power
+life cycle, they are classified into one of two types, an early launch or a
+late launch.
+
+:Early Launch: When a dynamic launch is used as a transition from a static
+   launch chain to the final Operating System.
+
+:Late Launch: The usage of a dynamic launch by an executing Operating System to
+   transition to a “known good” state to perform one or more operations, e.g. to
+   launch into a new Operating System.
+
+System Integrity
+================
+
+A computer system can be considered a collection of mechanisms that work
+together to produce a result. The assurance that the mechanisms are functioning
+correctly and producing the expected result is the integrity of the system. To
+ensure a system's integrity there are a subset of these mechanisms, commonly
+referred to as security mechanisms, that are present to help ensure the system
+produces the expected result or at least detect the potential of an unexpected
+result may have happened. Since the security mechanisms are relied upon to
+ensue the integrity of the system, these mechanisms are trusted. Upon
+inspection these security mechanisms each have a set of properties and these
+properties can be evaluated to determine how susceptible a mechanism might be
+to failure. This assessment is referred to as the Strength of Mechanism and for
+trusted mechanism enables for the trustworthiness of that mechanism to be
+quantified.
+
+For software systems there are two system states for which the integrity is
+critical, when the software is loaded into memory and when the software is
+executing on the hardware. Ensuring that the expected software is load into
+memory is referred to as load-time integrity while ensuring that the software
+executing is the expected software is the runtime integrity of that software.
+
+Load-time Integrity
+-------------------
+
+It is critical to understand what load-time integrity establishes about a
+system and what is assumed, i.e. what is being trusted. Load-time integrity is
+when a trusted entity, i.e. an entity with an assumed integrity, takes an
+action to assess an entity being loaded into memory before it is used. A
+variety of mechanisms may be used to conduct the assessment, each with
+different properties. A particular property is whether the mechanism creates an
+evidence of the assessment. Often either cryptographic signature checking or
+hashing are the common assessment operations used.
+
+A signature checking assessment functions by requiring a representation of the
+accepted authorities and uses those representations to assess if the entity has
+been signed by an accepted authority. The benefit to this process is that
+assessment process includes an adjudication of the assessment. The drawbacks
+are that 1) the adjudication is susceptible to tampering by the Trusted
+Computing Base (TCB), 2) there is no evidence to assert that an untampered
+adjudication was completed, and 3) the system must be an active participant in
+the key management infrastructure.
+
+A cryptographic hashing assessment does not adjudicate the assessment but
+instead generates evidence of the assessment to be adjudicated independently.
+The benefits to this approach is that the assessment may be simple such that it
+is able to be implemented as an immutable mechanism, e.g. in hardware.
+Additionally it is possible for the adjudication to be conducted where it
+cannot be tampered with by the TCB. The drawback is that a compromised
+environment will be allowed to execute until an adjudication can be completed.
+
+Ultimately load-time integrity provides confidence that the correct entity was
+loaded and in the absence of a run-time integrity mechanism assumes, i.e
+trusts, that the entity will never become corrupted.
+
+Runtime Integrity
+-----------------
+
+Runtime integrity in the general sense is when a trusted entity makes an
+assessment of an entity at any point in time during the assessed entity's
+execution. A more concrete explanation is the taking of an integrity assessment
+of an active process executing on the system at any point during the process'
+execution. Often the load-time integrity of an operating system's user-space,
+i.e. the operating environment, is confused to be the runtime integrity of the
+system since it is an integrity assessment of the "runtime" software. The
+reality is that actual runtime integrity is a very difficult problem and thus
+not very many solutions are public and/or available. One example of a runtime
+integrity solution would be John Hopkins Advanced Physics Labratory's (APL)
+Linux Kernel Integrity Module (LKIM).
+
+Trust Chains
+============
+
+Bulding upon the understanding of security mechanisms to establish load-time
+integrity of an entity, it is possible to chain together load-time integrity
+assessments to establish the integrity of the whole system. This process is
+known as transitive trust and provides the concept of building a chain of
+load-time integrity assessments, commonly referred to as a trust chain. These
+assessments may be used to adjudicate the load-time integrity of the whole
+system. This trust chain is started by a trusted entity that does the first
+assessment. This first entity is referred to as the Root of Trust(RoT) with the
+entities name being derived from the mechanism used for the assessment, i.e.
+RoT for Verification (RTV) and RoT for Measurement (RTM).
+
+A trust chain is itself a mechanism, specifically a mechanism of mechanisms,
+and therefore it too has a Strength of Mechanism. The factors that contribute
+to a trust chain's strength are,
+
+  - The strength of the chain's RoT
+  - The strength of each member of the trust chain
+  - The length, i.e. the number of members, of the chain
+
+Therefore to provide the strongest trust chains, they should start with a
+strong RoT and should consist of members being of low complexity and minimizing
+the number of members participating as is possible. In a more colloquial sense,
+a trust chain is only as strong as it weakests link and more links increase
+the probability of a weak link.
+
+Dynamic Launch Components
+=========================
+
+The TCG architecture for dynamic launch is composed of a component series that
+are used to setup and then carry out the launch. These components work together
+to construct a RTM trust chain that is rooted in the dynamic launch and thus
+commonly referred to as the Dynamic Root of Trust for Measurement (DRTM) chain.
+
+What follows is a brief explanation of each component in execution order. A
+subset of these components are what establishes the dynamic launch's trust
+chain.
+
+Dynamic Configuration Environment Preamble
+------------------------------------------
+
+The Dynamic Configuration Environment (DCE) Preamble is responsible for setting
+up the system environment in preparation for a dynamic launch. The DCE Preamble
+is not a part of the DRTM trust chain.
+
+Dynamic Launch Event
+--------------------
+
+The dynamic launch event is the event, typically a CPU instruction, that triggers
+the system's dynamic launch mechanism to begin the launch. The dynamic launch
+mechanism is also the RoT for the DRTM trust chain.
+
+Dynamic Configuration Environment
+---------------------------------
+
+The dynamic launch mechanism may have resulted in a reset of a portion of the
+system. To bring the system back to an adequate state for system software the
+dynamic launch will hand over control to the DCE. Prior to handing over this
+control, the dynamic launch will measure the DCE. Once the DCE is complete it
+will proceed to measure and then execute the Dynamic Launch Measured
+Environment (DLME).
+
+Dynamic Launch Measured Environment
+-----------------------------------
+
+The DLME is the first system kernel to have control of the system but may not
+be the last. Depending on the usage and configuration, the DLME may be the
+final/target operating system or it may be a boot loader that will load the
+final/target operating system.
+
+Why DRTM
+========
+
+It is a fact that DRTM increases the load-time integrity of the system by
+providing a trust chain that has an immutable hardware RoT, uses a limited
+number of small, special purpose code to establish the trust chain that starts
+the target operating system. As mentioned in the Trust Chain section, these are
+the main three factors in driving up the strength of a trust chain. As can been
+seen by the BootHole exploit, which in fact did not effect the integrity of
+DRTM solutions, the sophistication of attacks targeting system launch is at an
+all time high. There is no reason a system should not employ every integrity
+measure hardware makes available. This is the crux of a defense-in-depth
+approach to system security. In the past the now closed SMI gap was often
+pointed to as invalidating DRTM, which in fact was nothing but a strawman
+argument. As has continued to be demonstrated, if/when SMM is corrupted it can
+always circumvent all load-time integrity, SRTM and DRTM, because it is a
+run-time integrity problem. Regardless, Intel and AMD have both deployed
+runtime integrity for SMI and SMM which is tied directly to DRTM such that this
+perceived deficiency is now non-existent and the world is moving forward with
+an expectation that DRTM must be present.
+
+Glossary
+========
+
+.. glossary::
+  integrity
+    Guarding against improper information modification or destruction, and
+    includes ensuring information non-repudiation and authenticity.
+
+    - NIST CNSSI No. 4009 - https://www.cnss.gov/CNSS/issuances/Instructions.cfm
+
+  mechanism
+    A process or system that is used to produce a particular result.
+
+    - NIST Special Publication 800-160 (VOLUME 1 ) - https://nvlpubs.nist.gov/nistpubs/SpecialPublications/NIST.SP.800-160v1.pdf
+
+  risk
+    A measure of the extent to which an entity is threatened by a potential
+    circumstance or event, and typically a function of: (i) the adverse impacts
+    that would arise if the circumstance or event occurs; and (ii) the
+    likelihood of occurrence.
+
+    - NIST SP 800-30 Rev. 1 - https://nvlpubs.nist.gov/nistpubs/Legacy/SP/nistspecialpublication800-30r1.pdf
+
+  security mechanism
+    A device or function designed to provide one or more security services
+    usually rated in terms of strength of service and assurance of the design.
+
+    - NIST CNSSI No. 4009 - https://www.cnss.gov/CNSS/issuances/Instructions.cfm
+
+  Strength of Mechanism
+    A scale for measuring the relative strength of a security mechanism
+
+    - NIST CNSSI No. 4009 - https://www.cnss.gov/CNSS/issuances/Instructions.cfm
+
+  transitive trust
+    Also known as "Inductive Trust", in this process a Root of Trust gives a
+    trustworthy description of a second group of functions. Based on this
+    description, an interested entity can determine the trust it is to place in
+    this second group of functions. If the interested entity determines that
+    the trust level of the second group of functions is acceptable, the trust
+    boundary is extended from the Root of Trust to include the second group of
+    functions. In this case, the process can be iterated. The second group of
+    functions can give a trustworthy description of the third group of
+    functions, etc. Transitive trust is used to provide a trustworthy
+    description of platform characteristics, and also to prove that
+    non-migratable keys are non-migratable
+
+    - TCG Glossary - https://trustedcomputinggroup.org/wp-content/uploads/TCG-Glossary-V1.1-Rev-1.0.pdf
+
+  trust
+    The confidence one element has in another that the second element will
+    behave as expected`
+
+    - NISTIR 8320A - https://nvlpubs.nist.gov/nistpubs/ir/2021/NIST.IR.8320A.pdf
+
+  trust anchor
+    An authoritative entity for which trust is assumed.
+
+    - NIST SP 800-57 Part 1 Rev. 5 - https://nvlpubs.nist.gov/nistpubs/SpecialPublications/NIST.SP.800-57pt1r5.pdf
+
+  trusted
+    An element that another element relies upon to fulfill critical
+    requirements on its behalf.
+
+    - NISTIR 8320A - https://nvlpubs.nist.gov/nistpubs/ir/2021/NIST.IR.8320A.pdf
+
+  trusted computing base (TCB)
+    Totality of protection mechanisms within a computer system, including
+    hardware, firmware, and software, the combination responsible for enforcing
+    a security policy.
+
+    - NIST CNSSI No. 4009 - https://www.cnss.gov/CNSS/issuances/Instructions.cfm
+
+  trusted computer system
+    A system that has the necessary security functions and assurance that the
+    security policy will be enforced and that can process a range of
+    information sensitivities (i.e. classified, controlled unclassified
+    information (CUI), or unclassified public information) simultaneously.
+
+    - NIST CNSSI No. 4009 - https://www.cnss.gov/CNSS/issuances/Instructions.cfm
+
+  trustworthiness
+    The attribute of a person or enterprise that provides confidence to others
+    of the qualifications, capabilities, and reliability of that entity to
+    perform specific tasks and fulfill assigned responsibilities.
+
+    - NIST CNSSI No. 4009 - https://www.cnss.gov/CNSS/issuances/Instructions.cfm
diff --git a/Documentation/security/launch-integrity/secure_launch_details.rst b/Documentation/security/launch-integrity/secure_launch_details.rst
new file mode 100644
index 00000000..2f6acd6
--- /dev/null
+++ b/Documentation/security/launch-integrity/secure_launch_details.rst
@@ -0,0 +1,552 @@
+===================================
+Secure Launch Config and Interfaces
+===================================
+
+Configuration
+=============
+
+The settings to enable Secure Launch using Kconfig are under::
+
+  "Processor type and features" --> "Secure Launch support"
+
+A kernel with this option enabled can still be booted using other supported
+methods. There are two Kconfig options for Secure Launch::
+
+  "Secure Launch Alternate Authority usage"
+  "Secure Launch Alternate Detail usage"
+
+The help indicates their usage as alternate post launch PCRs to separate
+measurements for more flexibility (both disabled by default).
+
+To reduce the Trusted Computing Base (TCB) of the MLE [1]_, the build
+configuration should be pared down as narrowly as one's use case allows.
+The fewer drivers (less active hardware) and features reduces the attack
+surface. E.g. in the extreme, the MLE could only have local disk access
+and no other hardware support. Or only network access for remote attestation.
+
+It is also desirable if possible to embed the initrd used with the MLE kernel
+image to reduce complexity.
+
+The following are a few important configuration necessities to always consider:
+
+KASLR Configuration
+-------------------
+
+Secure Launch does not interoperate with KASLR. If possible, the MLE should be
+built with KASLR disabled::
+
+  "Processor type and features" -->
+      "Build a relocatable kernel" -->
+          "Randomize the address of the kernel image (KASLR) [ ]"
+
+This unsets the Kconfig value CONFIG_RANDOMIZE_BASE.
+
+If not possible, KASLR must be disabled on the kernel command line when doing
+a Secure Launch as follows::
+
+  nokaslr
+
+IOMMU Configuration
+-------------------
+
+When doing a Secure Launch, the IOMMU should always be enabled and the drivers
+loaded. However, IOMMU passthrough mode should never be used. This leaves the
+MLE completely exposed to DMA after the PMR's [2]_ are disabled. The current default
+mode is to use IOMMU in lazy translated mode but strict translated mode is the preferred
+IOMMU mode and this should be selected in the build configuration::
+
+  "Device Drivers" -->
+      "IOMMU Hardware Support" -->
+          "IOMMU default domain type" -->
+              "(X) Translated - Strict"
+
+In addition, the Intel IOMMU should be on by default. The following sets this as the
+default in the build configuration::
+
+  "Device Drivers" -->
+      "IOMMU Hardware Support" -->
+          "Support for Intel IOMMU using DMA Remapping Devices [*]"
+
+and::
+
+  "Device Drivers" -->
+      "IOMMU Hardware Support" -->
+          "Support for Intel IOMMU using DMA Remapping Devices [*]" -->
+              "Enable Intel DMA Remapping Devices by default  [*]"
+
+It is recommended that no other command line options should be set to override
+the defaults above.
+
+Intel TXT Interface
+===================
+
+The primary interfaces between the various components in TXT are the TXT MMIO
+registers and the TXT heap. The MMIO register banks are described in Appendix B
+of the TXT MLE [1]_ Development Guide.
+
+The TXT heap is described in Appendix C of the TXT MLE [1]_ Development
+Guide. Most of the TXT heap is predefined in the specification. The heap is
+initialized by firmware and the pre-launch environment and is subsequently used
+by the SINIT ACM. One section, called the OS to MLE Data Table, is reserved for
+software to define. This table is the Secure Launch binary interface between
+the pre- and post-launch environments and is defined as follows::
+
+        /*
+         * Secure Launch defined MTRR saving structures
+         */
+        struct txt_mtrr_pair {
+                u64 mtrr_physbase;
+                u64 mtrr_physmask;
+        } __packed;
+
+        struct txt_mtrr_state {
+                u64 default_mem_type;
+                u64 mtrr_vcnt;
+                struct txt_mtrr_pair mtrr_pair[TXT_OS_MLE_MAX_VARIABLE_MTRRS];
+        } __packed;
+
+        /*
+         * Secure Launch defined OS/MLE TXT Heap table
+         */
+        struct txt_os_mle_data {
+                u32 version;
+                u32 boot_params_addr;
+                u64 saved_misc_enable_msr;
+                struct txt_mtrr_state saved_bsp_mtrrs;
+                u32 ap_wake_block;
+                u32 ap_wake_block_size;
+                u64 evtlog_addr;
+                u32 evtlog_size;
+                u8 mle_scratch[64];
+        } __packed;
+
+Description of structure:
+
+=====================  ========================================================================
+Field                  Use
+=====================  ========================================================================
+version                Structure version, current value 1
+boot_params_addr       Physical address of the zero page/kernel boot params
+saved_misc_enable_msr  Original Misc Enable MSR (0x1a0) value stored by the pre-launch
+                       environment. This value needs to be restored post launch - this is a
+                       requirement.
+saved_bsp_mtrrs        Original Fixed and Variable MTRR values stored by the pre-launch
+                       environment. These values need to be restored post launch - this is a
+                       requirement.
+ap_wake_block          Pre-launch allocated memory block to wake up and park the APs post
+                       launch until SMP support is ready. This block is validated by the MLE
+                       before use.
+ap_wake_block_size     Size of the ap_wake_block. A minimum of 16384b (4x4K pages) is required.
+evtlog_addr            Pre-launch allocated memory block for the TPM event log. The event
+                       log is formatted both by the pre-launch environment and the SINIT
+                       ACM. This block is validated by the MLE before use.
+evtlog_size            Size of the evtlog_addr block.
+mle_scratch            Scratch area used post-launch by the MLE kernel. Fields:
+ 
+                        - SL_SCRATCH_AP_EBX area to share %ebx base pointer among CPUs
+                        - SL_SCRATCH_AP_JMP_OFFSET offset to abs. ljmp fixup location for APs
+=====================  ========================================================================
+
+Error Codes
+-----------
+
+The TXT specification defines the layout for TXT 32 bit error code values.
+The bit encodings indicate where the error originated (e.g. with the CPU,
+in the SINIT ACM, in software). The error is written to a sticky TXT
+register that persists across resets called TXT.ERRORCODE (see the TXT
+MLE Development Guide). The errors defined by the Secure Launch feature are
+those generated in the MLE software. They have the format::
+
+  0xc0008XXX
+
+The low 12 bits are free for defining the following Secure Launch specific
+error codes.
+
+======  ================
+Name:   SL_ERROR_GENERIC
+Value:  0xc0008001
+======  ================
+
+Description:
+
+Generic catch all error. Currently unused.
+
+======  =================
+Name:   SL_ERROR_TPM_INIT
+Value:  0xc0008002
+======  =================
+
+Description:
+
+The Secure Launch code failed to get an access to the TPM hardware interface.
+This is most likely to due to misconfigured hardware or kernel. Ensure the
+TPM chip is enabled and the kernel TPM support is built in (it should not be
+built as a module).
+
+======  ==========================
+Name:   SL_ERROR_TPM_INVALID_LOG20
+Value:  0xc0008003
+======  ==========================
+
+Description:
+
+The Secure Launch code failed to find a valid event log descriptor for TPM
+version 2.0 or the event log descriptor is malformed. Usually this indicates
+that incompatible versions of the pre-launch environment and the MLE kernel.
+The pre-launch environment and the kernel share a structure in the TXT heap and
+if this structure (the OS-MLE table) is mismatched, this error is often seen.
+This TXT heap area is setup by the pre-launch environment so the issue may
+originate there. It could be the sign of an attempted attack.
+
+======  ===========================
+Name:   SL_ERROR_TPM_LOGGING_FAILED
+Value:  0xc0008004
+======  ===========================
+
+Description:
+
+There was a failed attempt to write a TPM event to the event log early in the
+Secure Launch process. This is likely the result of a malformed TPM event log
+buffer. Formatting of the event log buffer information is done by the
+pre-launch environment so the issue most likely originates there.
+
+======  ============================
+Name:   SL_ERROR_REGION_STRADDLE_4GB
+Value:  0xc0008005
+======  ============================
+
+Description:
+
+During early validation a buffer or region was found to straddle the 4GB
+boundary. Because of the way TXT does DMA memory protection, this is an
+unsafe configuration and is flagged as an error. This is most likely a
+configuration issue in the pre-launch environment. It could also be the sign of
+an attempted attack.
+
+======  ===================
+Name:   SL_ERROR_TPM_EXTEND
+Value:  0xc0008006
+======  ===================
+
+Description:
+
+There was a failed attempt to extend a TPM PCR in the Secure Launch platform
+module. This is most likely to due to misconfigured hardware or kernel. Ensure
+the TPM chip is enabled and the kernel TPM support is built in (it should not
+be built as a module).
+
+======  ======================
+Name:   SL_ERROR_MTRR_INV_VCNT
+Value:  0xc0008007
+======  ======================
+
+Description:
+
+During early Secure Launch validation an invalid variable MTRR count was found.
+The pre-launch environment passes a number of MSR values to the MLE to restore
+including the MTRRs. The values are restored by the Secure Launch early entry
+point code. After measuring the values supplied by the pre-launch environment,
+a discrepancy was found validating the values. It could be the sign of an
+attempted attack.
+
+======  ==========================
+Name:   SL_ERROR_MTRR_INV_DEF_TYPE
+Value:  0xc0008008
+======  ==========================
+
+Description:
+
+During early Secure Launch validation an invalid default MTRR type was found.
+See SL_ERROR_MTRR_INV_VCNT for more details.
+
+======  ======================
+Name:   SL_ERROR_MTRR_INV_BASE
+Value:  0xc0008009
+======  ======================
+
+Description:
+
+During early Secure Launch validation an invalid variable MTRR base value was
+found. See SL_ERROR_MTRR_INV_VCNT for more details.
+
+======  ======================
+Name:   SL_ERROR_MTRR_INV_MASK
+Value:  0xc000800a
+======  ======================
+
+Description:
+
+During early Secure Launch validation an invalid variable MTRR mask value was
+found. See SL_ERROR_MTRR_INV_VCNT for more details.
+
+======  ========================
+Name:   SL_ERROR_MSR_INV_MISC_EN
+Value:  0xc000800b
+======  ========================
+
+Description:
+
+During early Secure Launch validation an invalid miscellaneous enable MSR value
+was found. See SL_ERROR_MTRR_INV_VCNT for more details.
+
+======  =========================
+Name:   SL_ERROR_INV_AP_INTERRUPT
+Value:  0xc000800c
+======  =========================
+
+Description:
+
+The application processors (APs) wait to be woken up by the SMP initialization
+code. The only interrupt that they expect is an NMI; all other interrupts
+should be masked. If an AP gets some other interrupt other than an NMI it will
+cause this error. This error is very unlikely to occur.
+
+======  =========================
+Name:   SL_ERROR_INTEGER_OVERFLOW
+Value:  0xc000800d
+======  =========================
+
+Description:
+
+A buffer base and size passed to the MLE caused an integer overflow when
+added together. This is most likely a configuration issue in the pre-launch
+environment. It could also be the sign of an attempted attack.
+
+======  ==================
+Name:   SL_ERROR_HEAP_WALK
+Value:  0xc000800e
+======  ==================
+
+Description:
+
+An error occurred in TXT heap walking code. The underlying issue is a failure to
+early_memremap() portions of the heap, most likely due to a resource shortage.
+
+======  =================
+Name:   SL_ERROR_HEAP_MAP
+Value:  0xc000800f
+======  =================
+
+Description:
+
+This error is essentially the same as SL_ERROR_HEAP_WALK but occurred during the
+actual early_memremap() operation.
+
+======  =========================
+Name:   SL_ERROR_REGION_ABOVE_4GB
+Value:  0xc0008010
+======  =========================
+
+Description:
+
+A memory region used by the MLE is above 4GB. In general this is not a problem
+because memory > 4Gb can be protected from DMA. There are certain buffers that
+should never be above 4Gb though and one of these caused the violation. This is
+most likely a configuration issue in the pre-launch environment. It could also
+be the sign of an attempted attack.
+
+======  ==========================
+Name:   SL_ERROR_HEAP_INVALID_DMAR
+Value:  0xc0008011
+======  ==========================
+
+Description:
+
+The backup copy of the ACPI DMAR table which is supposed to be located in the
+TXT heap could not be found. This is due to a bug in the platform's ACM module
+or in firmware.
+
+======  =======================
+Name:   SL_ERROR_HEAP_DMAR_SIZE
+Value:  0xc0008012
+======  =======================
+
+Description:
+
+The backup copy of the ACPI DMAR table in the TXT heap is to large to be stored
+for later usage. This error is very unlikely to occur since the area reserved
+for the copy is far larger than the DMAR should be.
+
+======  ======================
+Name:   SL_ERROR_HEAP_DMAR_MAP
+Value:  0xc0008013
+======  ======================
+
+Description:
+
+The backup copy of the ACPI DMAR table in the TXT heap could not be mapped. The
+underlying issue is a failure to early_memremap() the DMAR table, most likely
+due to a resource shortage.
+
+======  ====================
+Name:   SL_ERROR_HI_PMR_BASE
+Value:  0xc0008014
+======  ====================
+
+Description:
+
+On a system with more than 4G of RAM, the high PMR [2]_ base address should be set
+to 4G. This error is due to that not being the case. This PMR value is set by
+the pre-launch environment so the issue most likely originates there. It could also
+be the sign of an attempted attack.
+
+======  ====================
+Name:   SL_ERROR_HI_PMR_SIZE
+Value:  0xc0008015
+======  ====================
+
+Description:
+
+On a system with more than 4G of RAM, the high PMR [2]_ size should be set to cover
+all RAM > 4G. This error is due to that not being the case. This PMR value is
+set by the pre-launch environment so the issue most likely originates there. It
+could also be the sign of an attempted attack.
+
+======  ====================
+Name:   SL_ERROR_LO_PMR_BASE
+Value:  0xc0008016
+======  ====================
+
+Description:
+
+The low PMR [2]_ base should always be set to address zero. This error is due to
+that not being the case. This PMR value is set by the pre-launch environment
+so the issue most likely originates there. It could also be the sign of an attempted
+attack.
+
+======  ====================
+Name:   SL_ERROR_LO_PMR_MLE
+Value:  0xc0008017
+======  ====================
+
+Description:
+
+This error indicates the MLE image is not covered by the low PMR [2]_ range. The
+PMR values are set by the pre-launch environment so the issue most likely originates
+there. It could also be the sign of an attempted attack.
+
+======  =======================
+Name:   SL_ERROR_INITRD_TOO_BIG
+Value:  0xc0008018
+======  =======================
+
+Description:
+
+The external initrd provided is larger than 4Gb. This is not a valid
+configuration for a Secure Launch due to managing DMA protection.
+
+======  =========================
+Name:   SL_ERROR_HEAP_ZERO_OFFSET
+Value:  0xc0008019
+======  =========================
+
+Description:
+
+During a TXT heap walk an invalid/zero next table offset value was found. This
+indicates the TXT heap is malformed. The TXT heap is initialized by the
+pre-launch environment so the issue most likely originates there. It could also
+be a sign of an attempted attack. In addition, ACM is also responsible for
+manipulating parts of the TXT heap so the issue could be due to a bug in the
+platform's ACM module.
+
+======  =============================
+Name:   SL_ERROR_WAKE_BLOCK_TOO_SMALL
+Value:  0xc000801a
+======  =============================
+
+Description:
+
+The AP wake block buffer passed to the MLE via the OS-MLE TXT heap table is not
+large enough. This value is set by the pre-launch environment so the issue most
+likely originates there. It also could be the sign of an attempted attack.
+
+======  ===========================
+Name:   SL_ERROR_MLE_BUFFER_OVERLAP
+Value:  0xc000801b
+======  ===========================
+
+Description:
+
+One of the buffers passed to the MLE via the OS-MLE TXT heap table overlaps
+with the MLE image in memory. This value is set by the pre-launch environment
+so the issue most likely originates there. It could also be the sign of an attempted
+attack.
+
+======  ==========================
+Name:   SL_ERROR_BUFFER_BEYOND_PMR
+Value:  0xc000801c
+======  ==========================
+
+Description:
+
+One of the buffers passed to the MLE via the OS-MLE TXT heap table is not
+protected by a PMR. This value is set by the pre-launch environment so the
+issue most likey  originates there. It could also be the sign of an attempted
+attack.
+
+======  =============================
+Name:   SL_ERROR_OS_SINIT_BAD_VERSION
+Value:  0xc000801d
+======  =============================
+
+Description:
+
+The version of the OS-SINIT TXT heap table is bad. It must be 6 or greater.
+This value is set by the pre-launch environment so the issue most likely
+originates there. It could also be the sign of an attempted attack. It is also
+possible though very unlikely that the platform is so old that the ACM being
+used requires an unsupported version.
+
+======  =====================
+Name:   SL_ERROR_EVENTLOG_MAP
+Value:  0xc000801e
+======  =====================
+
+Description:
+
+An error occurred in the Secure Launch module while mapping the TPM event log.
+The underlying issue is memremap() failure, most likely due to a resource
+shortage.
+
+======  ========================
+Name:   SL_ERROR_TPM_NUMBER_ALGS
+Value:  0xc000801f
+======  ========================
+
+Description:
+
+The TPM 2.0 event log reports an unsupported number of hashing algorithms.
+Secure launch currently only supports a maximum of two: SHA1 and SHA256.
+
+======  ===========================
+Name:   SL_ERROR_TPM_UNKNOWN_DIGEST
+Value:  0xc0008020
+======  ===========================
+
+Description:
+
+The TPM 2.0 event log reports an unsupported hashing algorithm. Secure launch
+currently only supports two algorithms: SHA1 and SHA256.
+
+======  ==========================
+Name:   SL_ERROR_TPM_INVALID_EVENT
+Value:  0xc0008021
+======  ==========================
+
+Description:
+
+An invalid/malformed event was found in the TPM event log while reading it.
+Since only trusted entities are supposed to be writing the event log, this
+would indicate either a bug or a possible attack.
+
+.. [1]
+    MLE: Measured Launch Environment is the binary runtime that is measured and
+    then run by the TXT SINIT ACM. The TXT MLE Development Guide describes the
+    requirements for the MLE in detail.
+
+.. [2]
+    PMR: Intel VTd has a feature in the IOMMU called Protected Memory Registers.
+    There are two of these registers and they allow all DMA to be blocked
+    to large areas of memory. The low PMR can cover all memory below 4Gb on 2Mb
+    boundaries. The high PMR can cover all RAM on the system, again on 2Mb
+    boundaries. This feature is used during a Secure Launch by TXT.
diff --git a/Documentation/security/launch-integrity/secure_launch_overview.rst b/Documentation/security/launch-integrity/secure_launch_overview.rst
new file mode 100644
index 00000000..229c2b4
--- /dev/null
+++ b/Documentation/security/launch-integrity/secure_launch_overview.rst
@@ -0,0 +1,214 @@
+======================
+Secure Launch Overview
+======================
+
+Overview
+========
+
+Prior to the start of the TrenchBoot project, the only active Open Source
+project supporting dynamic launch was Intel's tboot project to support their
+implementation of dynamic launch known as Intel Trusted eXecution Technology
+(TXT). The approach taken by tboot was to provide an exokernel that could
+handle the launch protocol implemented by Intel's special loader, the SINIT
+Authenticated Code Module (ACM [2]_) and remained in memory to manage the SMX
+CPU mode that a dynamic launch would put a system. While it is not precluded
+from being used for doing a late launch, tboot's primary use case was to be
+used as an early launch solution. As a result the TrenchBoot project started
+the development of Secure Launch kernel feature to provide a more generalized
+approach. The focus of the effort is twofold, the first is to make the Linux
+kernel directly aware of the launch protocol used by Intel, AMD/Hygon, Arm, and
+potentially OpenPOWER. The second is to make the Linux kernel be able to
+initiate a dynamic launch. It is through this approach that the Secure Launch
+kernel feature creates a basis for the Linux kernel to be used in a variety of
+dynamic launch use cases.
+
+.. note::
+    A quick note on terminology. The larger open source project itself is
+    called TrenchBoot, which is hosted on GitHub (links below). The kernel
+    feature enabling the use of the x86 technology is referred to as "Secure
+    Launch" within the kernel code.
+
+Goals
+=====
+
+The first use case that the TrenchBoot project focused on was the ability for
+the Linux kernel to be started by a dynamic launch, in particular as part of an
+early launch sequence. In this case the dynamic launch will be initiated by a
+boot loader with associated support added to it, for example the first targeted
+boot loader in this case was GRUB2. An integral part of establishing a
+measurement-based launch integrity involves measuring everything that is
+intended to be executed (kernel image, initrd, etc) and everything that will
+configure that kernel to execute (command line, boot params, etc). Then storing
+those measurements in a protected manner. Both the Intel and AMD dynamic launch
+implementations leverage the Trusted Platform Module (TPM) to store those
+measurements. The TPM itself has been designed such that a dynamic launch
+unlocks a specific set of Platform Configuration Registers (PCR) for holding
+measurement taken during the dynamic launch.  These are referred to as the DRTM
+PCRs, PCRs 17-22. Further details on this process can be found in the
+documentation for the GETSEC instruction provided by Intel's TXT and the SKINIT
+instruction provided by AMD's AMD-V. The documentation on these technologies
+can be readily found online; see the `Resources`_ section below for references.
+
+.. note::
+    Currently only Intel TXT is supported in this first release of the Secure
+    Launch feature. AMD/Hygon SKINIT and Arm support will be added in a
+    subsequent release.
+
+To enable the kernel to be launched by GETSEC a stub, the Secure Launch stub,
+must be built into the setup section of the compressed kernel to handle the
+specific state that the dynamic launch process leaves the BSP. Also the Secure
+Launch stub must measure everything that is going to be used as early as
+possible. This stub code and subsequent code must also deal with the specific
+state that the dynamic launch leaves the APs as well.
+
+Design Decisions
+================
+
+A number of design decisions were made during the development of the Secure
+Launch feature. The two primary guiding decisions were:
+
+ - Keeping the Secure Launch code as separate from the rest of the kernel
+   as possible.
+ - Modifying the existing boot path of the kernel as little as possible.
+
+The following illustrate how the implementation followed these design
+decisions:
+
+ - All the entry point code necessary to properly configure the system post
+   launch is found in st_stub.S in the compressed kernel image. This code
+   validates the state of the system, restores necessary system operating
+   configurations and properly handles post launch CPU states.
+ - After the sl_stub.S is complete, it jumps directly to the unmodified
+   startup_32 kernel entry point.
+ - A single call is made to a function sl_main() prior to the main kernel
+   decompression step. This code performs further validation and takes the
+   needed DRTM measurements.
+ - After the call to sl_main(), the main kernel is decompressed and boots as
+   it normally would.
+ - Final setup for the Secure Launch kernel is done in a separate Secure
+   Launch module that is loaded via a late initcall. This code is responsible
+   for extending the measurements taken earlier into the TPM DRTM PCRs and
+   setting up the securityfs interface to allow access the TPM event log and
+   public TXT registers.
+ - On the reboot and kexec paths, calls are made to a function to finalize the
+   state of the Secure Launch kernel.
+
+The one place where Secure Launch code is mixed directly in with kernel code is
+in the SMP boot code. This is due to the unique state that the dynamic launch
+leaves the APs in. On Intel this involves using a method other than the
+standard INIT-SIPI sequence.
+
+A final note is that originally the extending of the PCRs was completed in the
+Secure Launch stub when the measurements were taken. An alternative solution
+had to be implemented due to the TPM maintainers objecting to the PCR
+extensions being done with a minimal interface to the TPM that was an
+independent implementation of the mainline kernel driver. Since the mainline
+driver relies heavily on kernel interfaces not available in the compressed
+kernel, it was not possible to reuse the mainline TPM driver. This resulted in
+the decision to move the extension operations to the Secure Launch module in
+the mainline kernel where the TPM driver would be available.
+
+Basic Boot Flow
+===============
+
+Pre-launch: *Phase where the environment is prepared and configured to initiate the
+secure launch in the GRUB bootloader.*
+
+ - Prepare the CPU and the TPM for the launch.
+ - Load the kernel, initrd and ACM [2]_ into memory.
+ - Setup the TXT heap and page tables describing the MLE [1]_ per the
+   specification.
+ - Initiate the secure launch with the GETSET[SENTER] instruction.
+
+Post-launch: *Phase where control is passed from the ACM to the MLE and the secure
+kernel begins execution.*
+
+ - Entry from the dynamic launch jumps to the SL stub.
+ - SL stub fixes up the world on the BSP.
+ - For TXT, SL stub wakes the APs, fixes up their worlds.
+ - For TXT, APs are left halted waiting for an NMI to wake them.
+ - SL stub jumps to startup_32.
+ - SL main does validation of buffers and memory locations. It sets
+   the boot parameter loadflag value SLAUNCH_FLAG to inform the main
+   kernel that a Secure Launch was done.
+ - SL main locates the TPM event log and writes the measurements of
+   configuration and module information into it.
+ - Kernel boot proceeds normally from this point.
+ - During early setup, slaunch_setup() runs to finish some validation
+   and setup tasks.
+ - The SMP bring up code is modified to wake the waiting APs. APs vector
+   to rmpiggy and start up normally from that point.
+ - SL platform module is registered as a late initcall module. It reads
+   the TPM event log and extends the measurements taken into the TPM PCRs.
+ - SL platform module initializes the securityfs interface to allow
+   access to the TPM event log and TXT public registers.
+ - Kernel boot finishes booting normally
+ - SEXIT support to leave SMX mode is present on the kexec path and
+   the various reboot paths (poweroff, reset, halt).
+
+PCR Usage
+=========
+
+The TCG DRTM architecture there are three PCRs defined for usage, PCR.Details
+(PCR17), PCR.Authorities (PCR18), and PCR.DLME_Authority (PCR19). For a deeper
+understanding of Detail and Authorities it is recommended to review the TCG
+DRTM architecture.
+
+Primarily the Authorities is expected to be in the form of a cryptographic
+signature of a component in the DRTM chain. A challenge for Linux kernel is
+that it may or may not have an authoritative signature associated with it and
+Secure Launch intends to support a maximum number of configurations. To support
+the Details/Authority scheme Secure Launch is built with the concept that
+the runtime configuration of a kernel is the "authority" under which the user
+executed the kernel. By default the authority for the kernel is extended into
+PCR.Authorities with a Kconfig option to have it extended into PCR.DLME_Authority.
+
+An extension Secure Launch introduces is the PCR.DLME_Detail (PCR20) PCR.
+Enabling the usage of this PCR is set through Kconfig and results in any DRTM
+components measured by the kernel, e.g. external initrd image, to be extended
+into the PCR. When combined with Secure Launch's user authority being stored in
+PCR.DLME_Authority allows the ability to seal/attest to different variations of
+platform details/authorities with user details/authorities. An example of this
+was presented in the FOSDEM - 2021 talk "Secure Upgrades with DRTM".
+
+Resources
+=========
+
+The TrenchBoot project including documentation:
+
+https://github.com/trenchboot
+
+Trusted Computing Group's D-RTM Architecture:
+
+https://trustedcomputinggroup.org/wp-content/uploads/TCG_D-RTM_Architecture_v1-0_Published_06172013.pdf
+
+TXT documentation in the Intel TXT MLE Development Guide:
+
+https://www.intel.com/content/dam/www/public/us/en/documents/guides/intel-txt-software-development-guide.pdf
+
+TXT instructions documentation in the Intel SDM Instruction Set volume:
+
+https://software.intel.com/en-us/articles/intel-sdm
+
+AMD SKINIT documentation in the System Programming manual:
+
+https://www.amd.com/system/files/TechDocs/24593.pdf
+
+GRUB pre-launch support patchset (WIP):
+
+https://lists.gnu.org/archive/html/grub-devel/2020-05/msg00011.html
+
+FOSDEM 2021: Secure Upgrades with DRTM
+
+https://archive.fosdem.org/2021/schedule/event/firmware_suwd/
+
+.. [1]
+    MLE: Measured Launch Environment is the binary runtime that is measured and
+    then run by the TXT SINIT ACM. The TXT MLE Development Guide describes the
+    requirements for the MLE in detail.
+
+.. [2]
+    ACM: Intel's Authenticated Code Module. This is the 32b bit binary blob that
+    is run securely by the GETSEC[SENTER] during a measured launch. It is described
+    in the Intel documentation on TXT and versions for various chipsets are
+    signed and distributed by Intel.
-- 
1.8.3.1

