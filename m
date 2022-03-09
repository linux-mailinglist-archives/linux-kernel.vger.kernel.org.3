Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1B184D2778
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Mar 2022 05:07:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231788AbiCIDeW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 22:34:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231717AbiCIDeS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 22:34:18 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEED099690;
        Tue,  8 Mar 2022 19:33:18 -0800 (PST)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 228M8nP0016933;
        Wed, 9 Mar 2022 03:33:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : message-id : references : date : in-reply-to : content-type :
 mime-version; s=corp-2021-07-09;
 bh=o0bSxMKo3EDKC2BQ2fPQu76cK4E77Hvy+iGwPq0wVvE=;
 b=T70FhVgK17at8d+X3ndLmWekFfIP7xapQtbG5JnBcH2hsDOf1YbZw6kXhTA2XVzWiOGM
 8+yhOAyHpPcO7buRGVG0R/VNPXvkbIJZtwjlWc706YjNEnT99fh6bqUgM6Y69EJmLKzc
 Pgecb5X6jcKR6Mz1/oi0WEAy4j5UuYnJSpcOEbrW8zwEiUAu1JzYLenptoGamJKM7HHI
 6JOFx78T4fK4Hvet733z2OwEgDlsmykvWMBZJJcMt31XCCCgY9Kv2SuQQ6d42ibRlF3H
 vZfJPIDeuvfZ7oHAULWmJyMhmjuz6H2BBCos16oMsUvx7302E1duZJBhZFfjPldkvT5l Bw== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3ekx9cgmm9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 09 Mar 2022 03:33:09 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 2293VvN6185751;
        Wed, 9 Mar 2022 03:33:08 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2173.outbound.protection.outlook.com [104.47.56.173])
        by aserp3030.oracle.com with ESMTP id 3ekwwcjahq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 09 Mar 2022 03:33:08 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PDuV0V4EIMbJfGAhrYbpu5j4nv9ElZyyDZ8C9E7dRy3R+v1a63tHUhyeB/JMvfWGTxM+8X+CeW3yeL7kuoZ7Lvt4MMLrsZibEbINdnv4JSCzSyl/I/819UI9HkKdnlxsosax8ML1twSSCw7U87kUiJ9cCJp4/R/rxuWH+UK5iWkg6LcrCr+lW9tX80j8UriKvudEkzYh5ltWkVHqxOg3/W2fz2HwiSLuZUUkULqSrv5MONPqRD14Ja8UmxTBqXyJzp+HtatNW8vdGXABygpxrWrqHJQTBaIJEBf3UHWINtEi6je7Hb+IrX8nBIirdmPXnCWcaaOkdgOyaNgx5DaNbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o0bSxMKo3EDKC2BQ2fPQu76cK4E77Hvy+iGwPq0wVvE=;
 b=SjgR6P7MzVT+MKooVxdJeTjr1G1uwVVXsCYLOEYv3O/sBk6EJZ+hBbG4QrNRAXguvxZfYHSyBWnHBEmZeMGtr9vx5zQpdm2wBn/vjeQqLUqggaZHvcasVudWERMHBWljJNId4OCBT26bcxEeB3FAW5wTbhT2dTJ71iCi1/Uq5pn42Xxtdi2SChtdqwZfbtqmLbgI1T1r33Bjkul0h2BrxDunsF6/Wg9zuENYTGEMCxHjXzCorvo1AY7HQoTsq2OrNdku7pBcMj2kwvsN1/YNPEA+vxbGoGZS/9udXh50hzlWxlXHXx3sdTKXoNir7PoZvdP+lAljh97iNK2Wg+AKJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o0bSxMKo3EDKC2BQ2fPQu76cK4E77Hvy+iGwPq0wVvE=;
 b=dMOSDXL+dIc39iWfeyGNdsnkdJBfbUDRxCyj1hwlyWCi97Q59Bl6KmJlhRj//lJU/g97u2bt6mn2aIDzhXlsTz7lDLDBdj3XlpSq258rBNw2OUpyPPWiqehREkleOEVHppTx4djOfjM+6qSKtVjfTQP8YzUZDT6ynRQ7ax1Tj24=
Received: from SA2PR10MB4763.namprd10.prod.outlook.com (2603:10b6:806:117::19)
 by DM6PR10MB3259.namprd10.prod.outlook.com (2603:10b6:5:1a9::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.19; Wed, 9 Mar
 2022 03:33:06 +0000
Received: from SA2PR10MB4763.namprd10.prod.outlook.com
 ([fe80::a045:e293:518:7604]) by SA2PR10MB4763.namprd10.prod.outlook.com
 ([fe80::a045:e293:518:7604%3]) with mapi id 15.20.5038.026; Wed, 9 Mar 2022
 03:33:06 +0000
To:     Jianglei Nie <niejianglei2021@163.com>
Cc:     hare@suse.de, jejb@linux.ibm.com, martin.petersen@oracle.com,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] scsi: libfc: Fix use after free in fc_exch_abts_resp()
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
Message-ID: <yq135jrls0p.fsf@ca-mkp.ca.oracle.com>
References: <20220303015115.459778-1-niejianglei2021@163.com>
Date:   Tue, 08 Mar 2022 22:33:03 -0500
In-Reply-To: <20220303015115.459778-1-niejianglei2021@163.com> (Jianglei Nie's
        message of "Thu, 3 Mar 2022 09:51:15 +0800")
Content-Type: text/plain
X-ClientProxiedBy: BYAPR07CA0063.namprd07.prod.outlook.com
 (2603:10b6:a03:60::40) To SA2PR10MB4763.namprd10.prod.outlook.com
 (2603:10b6:806:117::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fecb51df-4bb2-48c8-d9a9-08da017d85d0
X-MS-TrafficTypeDiagnostic: DM6PR10MB3259:EE_
X-Microsoft-Antispam-PRVS: <DM6PR10MB32590B04FC5BE1F67A56039C8E0A9@DM6PR10MB3259.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: elJBYBGeqYufrHEX/+OhVxXFlsUWHmlf48IvAAgIfgbPMKkvjVQfDqplXrfYLV1wArXBTpe1EV1J9k9VTBrvCCTvSghYzfQakICvtm1kf3wNPdU2b7DN4Wb+lSFpazXcYyD+LQooPx7ns48pZf9bo1noPaZHwy0LJyXpf/y+1Yf0Zl7vqv/LoMazD+cFdiegCtJjS/F25HzJibpVsqEjA9ILCBgTiMWtB0UrYWZEVHJYZSjoZLodaVaUmj7bo6Mc4HBGDx21bGvTtwRk2KbVL3G694BqZTMU6Dx3NceBkzpeudRdXKC9Kq0WTfhch6VMowydj4otElSCduT9reimCz93Y0Ke8P8o1ukknR3yTjY/pdkuY/QwftXATm1kHxWUVVNJuJOCRKy5Ohf9JNr/R0xo3agjFT0dtCEB0qsZaLEJ3nDnDOT3p+NHvGgm4PtwJZm8u+U6arBi4sP3gYsLYZ8t7r/T50G3mVIBC4FjtasXKzufIsrj7mmBU4tNjUJI3CU1ixUUf3HVBk/g+nLnK5EzKUQRyu+Ic66wQ0Dt6bJHULJKmJMKwsRsmXTXhp2ozy+OFVGksS+pp22MzeMTOLNQ6h+d6DoJfp/W/MXqZZ/+E8Y3my7WDTCLonS0O8b7Ef5jpov8IJMR4W2m5sMTdTHNn4eRUT+YsLdF6UW2neVonKa4NUtAOXDPXCH1+D9oWQATAwB8GtVwciGpFqZRrw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA2PR10MB4763.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(26005)(186003)(2906002)(508600001)(316002)(6666004)(5660300002)(6506007)(8936002)(86362001)(6512007)(36916002)(558084003)(52116002)(6916009)(38350700002)(38100700002)(6486002)(8676002)(66476007)(66556008)(4326008)(66946007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?cme1205luoPwuJuYK0gkan/9fq+j928RCozLjebVvBq3xyyayxl3Bs49GrVC?=
 =?us-ascii?Q?c6C0d0x8yIvdJVMPQzluLhXKGB5/JsNBaKjG/rUi9NR9svDX7HgT/Pk0bvr1?=
 =?us-ascii?Q?A4x/dEpIkW/HZtOYqPVVry66kanlR2fr4SJgE5y1mb3qaNCscm4WWudDGDKW?=
 =?us-ascii?Q?rCrZJKTZlp9HNAxNQShv8sNpooP7e1DmzsBb6IoViarDTDolkj3HIEFPQx/V?=
 =?us-ascii?Q?D8A5zD7r87Cj5JPkrPDkPiFFF/65PT/7HSv54FdefW5/xdbB8u+jpM9FPMG2?=
 =?us-ascii?Q?3uDuR3NbcIREOgcwbKD0Or6qccM2twWWVCzCZ5AYL+OW/4gQVD+JHpidMFk5?=
 =?us-ascii?Q?HLqZOQcPQw2w5YLq/dSsFESPZaAdX651rHZlArhVLnbXQoGCrwHnxgdNT3Tp?=
 =?us-ascii?Q?EJwHhJe9tWEfdssCiK/7uwBotc0OFeXNdSnfoomFjE5+bRWJW5R0oEtvpKO0?=
 =?us-ascii?Q?qt94YAGjffwC119tSvFXZo/ldWQg3kCMayjmFBVA/AEEpGlWVRP3uRHSrLz7?=
 =?us-ascii?Q?APZqPCN18XLN2sW1HyZpJt7vWF1yIPOYkTv5q22pccgueqr+fbTE8nWS+jSp?=
 =?us-ascii?Q?5h3D87jNAVqAwU7NCzIK+I0h1DqxOZAjS87akGhrkdPXPd3Clr0jJXJafi9W?=
 =?us-ascii?Q?ZKB4vFqv1wHLTTRNyzNAFnvSdcPtZZ5r4BhXscsjTYi4iXWVI+EdOUZXV6TQ?=
 =?us-ascii?Q?0QqJ6MaYcdBRJ+3WVxyRZySzqttWXNA3HIbabuSDSNGTXmhRcTfypqV37suW?=
 =?us-ascii?Q?GdGGx4eP0JL/FrN0deeg5oet8gJ6qXGutpz8GHcX7OtSRne5O8zfVVECQhtp?=
 =?us-ascii?Q?MutVQ0wD7m5IxXK3jSzDQYDwL1UhjApV1a/DXbLTqVFY6jdnHlCUN/3zkUgj?=
 =?us-ascii?Q?SipMvCvbOsGDbtXjuhgcZ04bbySyQ47uC9oJW6Hvh5+etdtzyNaC8znyzts6?=
 =?us-ascii?Q?wkcpJkkowGrEq6auMRX7+FS3kdvP8rYJWAfJ7wu62sy0Lw/6hLE0wK2jPi4U?=
 =?us-ascii?Q?BpPWPB9LH+I6qKOLLohgJjmqFmNpA7d2kPX8+TjYcU0/uzHPiDBZuuhqDsXF?=
 =?us-ascii?Q?nd49lvF4qCKpHYSusoM70q7PJrxwpeqhfup0RrVBPXLlFF55nhoejdaF5pNY?=
 =?us-ascii?Q?Kta0U3fgUkKkhopW+pWh0TPi39zFrS85RplHdxzcJ8eH/+bAzN5rd1Vd4jMg?=
 =?us-ascii?Q?5goi4ViJsJvI+H/HpJ5ehqp4GXe/Yay1oA0ufFawoGHtReKPytiHIh+o/wC8?=
 =?us-ascii?Q?DTmexaomUb6RP91RTrG1wvucAECp8269ujxFo8jwnmu73pdEbQB+kjKwAHdU?=
 =?us-ascii?Q?9bM1cWe63tKjBUk3tHyzcI1lZZPpi2Y+PbwW6IHnE8hUiB4X1VFJnNUgsaAz?=
 =?us-ascii?Q?5FMt3n5cym9z3zs9bfxI16b0bmWp/5gmV+VUqg+9TdJj6gKNm+3/kU1YMQmF?=
 =?us-ascii?Q?fUdsHnTR7B58xmqmRSWy20gZvJBKZ+tvBYKBdl1bzME+cXq8k0U1O99/stMa?=
 =?us-ascii?Q?T/WLaEMbVECARBISC5uRsYFwdJhUCSKlO9UcAjoHAVDvIPYaq1kMF9OrnMBE?=
 =?us-ascii?Q?ugZkaTUABgU1xyuYYjl+WbVTDBGTVpDgCjytggKLcF2cQ5pbpZU/egW4azIu?=
 =?us-ascii?Q?18x5hg2YkXeLauJ7t5+tnW6TVAZu/hcRWss0wuqp8eaZbMhJWT6YO8kcpEFY?=
 =?us-ascii?Q?wJM9JyRA8qrtLJf5pBWBpDla57g=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fecb51df-4bb2-48c8-d9a9-08da017d85d0
X-MS-Exchange-CrossTenant-AuthSource: SA2PR10MB4763.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Mar 2022 03:33:05.5036
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: G2dkU9YwwxxRM/Z+hkc7hk4lddMXtpzu73prLPGB1hwYXTXiZt+/F0Y0FVAbtU2+qoWL1l76SKEMDVWDEiUAmi6tEfoQzUOLweKytesCLnI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB3259
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10280 signatures=690848
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=662 spamscore=0
 phishscore=0 bulkscore=0 adultscore=0 malwarescore=0 suspectscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2203090018
X-Proofpoint-ORIG-GUID: 06iQ0tM_Hq3D4muJvcZTBs0-wTQiQ7UE
X-Proofpoint-GUID: 06iQ0tM_Hq3D4muJvcZTBs0-wTQiQ7UE
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Jianglei,

> fc_exch_release(ep) will decrease the ep's reference count. When the
> reference count reaches zero, it is freed. But ep is still used in the
> following code, which will lead to a use after free.

Applied to 5.18/scsi-staging, thanks!

-- 
Martin K. Petersen	Oracle Linux Engineering
