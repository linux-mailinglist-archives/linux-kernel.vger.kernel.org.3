Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC8124E51EF
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Mar 2022 13:11:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233826AbiCWMNL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Mar 2022 08:13:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233134AbiCWMNJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Mar 2022 08:13:09 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B98CD3FBD4
        for <linux-kernel@vger.kernel.org>; Wed, 23 Mar 2022 05:11:39 -0700 (PDT)
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 22NCAsOH027421
        for <linux-kernel@vger.kernel.org>; Wed, 23 Mar 2022 12:11:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : subject :
 date : message-id : content-type : content-transfer-encoding :
 mime-version; s=pp1; bh=07xa+p+vbCCIr1tRoYlbLT4W5EI/n8VjfondYcbnlUs=;
 b=e2U22MCSIduuPpwCR6l8SoCq05pr6ALiEm9r6FnfnVYR8B9X0n6ihh7rPYKm2743WZJr
 s99ooGHJbB+ApByuUMA6NrTcZYpZIwJ+KABYq5W18I0DD+0RloJp4pEEoo+kgsBWe1/M
 rJ+/8VvNUN8Fn1EONPe/VEWzLtUmPTcSUnNwG/4vda3gGsZE93bohV8XVEY7FiVaobhg
 JFc7Ie55pmCNIC70d6kUjESo85Fel1J7dHoj3N5bFaEe8xwS9mYIEyuJGiXbVQjEF6wt
 9deKR08Cr+3JrSBOO8l+R5ZuWCVdain1TzbESUNY5XhmuvqMYc3dxYozFmaWCxVqCYuf og== 
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2108.outbound.protection.outlook.com [104.47.55.108])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3eyvrb050p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 23 Mar 2022 12:11:39 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JIgajH1bsZSZYkH6NCeATT63kFXiCV86VOGVbHo5YfArLHKqidol0ul15nrB0sKylWZG3ifECcGNH1mT5ScEW9X5pNOMmJQHTth6jMgrG+lRhHzXeo7fM+uCfIXSq72O9Oeg8bFuLSW/eMqdONhmp6EpLyHKXb8sW5t8Tp5mPewlkvFpL7Essp4lBtDWxj0iXX8qv+LBiy6IfDHaI6/Awfnkk44OJO+/PAZxCRAmWQNPfJYn2XamPapjft3A++iTtLi2ZHZLffLM6DQpkSFuGUpF3iUBNpYpMzlvGjtxf9GbH79st4D8fvFYfjctlgv1S+3FH0q6y3CX14uVFMbz5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=07xa+p+vbCCIr1tRoYlbLT4W5EI/n8VjfondYcbnlUs=;
 b=AzIoJCTvhBDb6B/85zr5DhTLr8Ts5NlRJP0TripcWFpm39w8JBeecfH/aPA3KeVAQwbs7fHBxkCkB0gvQAXLeyMlCfOfKXAurKiaA6j9c3rDYfMjP86sn52gwNDhnri6ZjHW7gm595QOPgS+2NUKd9JsFpL4yNr/lGV/84aXVqY7/4asrwixWDZmgH6cr/vuU5/R1o+Cu+43n1d2iAYRdtwpsH+Ow+TsJyjnf8kMWWdOF6avD9AWq0Me1OFdZzd2Nd9Zdd0USDuG+ec9Srq7ZiozeTwrv2H91wxlb2XOQTXuLRTrAoPov77e0nLYdv2qMu1KKboNLChZ4YstHmCoig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=il.ibm.com; dmarc=pass action=none header.from=il.ibm.com;
 dkim=pass header.d=il.ibm.com; arc=none
Received: from DM6PR15MB2603.namprd15.prod.outlook.com (2603:10b6:5:1b0::10)
 by SA1PR15MB4675.namprd15.prod.outlook.com (2603:10b6:806:19e::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.17; Wed, 23 Mar
 2022 12:11:38 +0000
Received: from DM6PR15MB2603.namprd15.prod.outlook.com
 ([fe80::2047:9a5b:3129:a252]) by DM6PR15MB2603.namprd15.prod.outlook.com
 ([fe80::2047:9a5b:3129:a252%5]) with mapi id 15.20.5102.017; Wed, 23 Mar 2022
 12:11:38 +0000
From:   Constantine Gavrilov <CONSTG@il.ibm.com>
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: io_uring_enter() with opcode IORING_OP_RECV ignores MSG_WAITALL in
 msg_flags
Thread-Topic: io_uring_enter() with opcode IORING_OP_RECV ignores MSG_WAITALL
 in msg_flags
Thread-Index: AQHYPq7kX9AJdFCHNE2/rpx8u402Uw==
Date:   Wed, 23 Mar 2022 12:11:38 +0000
Message-ID: <DM6PR15MB2603BF2AA241ECB50ED6E167FA189@DM6PR15MB2603.namprd15.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 99bb5063-d4e8-4844-a2f8-08da0cc64835
x-ms-traffictypediagnostic: SA1PR15MB4675:EE_
x-microsoft-antispam-prvs: <SA1PR15MB46751CC64529799C12B33807FA189@SA1PR15MB4675.namprd15.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: z3ZmiYna6cAJsYpwY89zQ0/VUzYVJF9+Jb/R/WODqIE44JDbTCsbGmESw08o3fCQOM8c7xTp32dfOvjBwi2380B0aOByV78jcJLgFKdhBsXTKnIFken2NJfmgH5X4REeZ9lRfIlXshqLxztHNs71y+QxY4a7Y+FmBtM7BFSZdVPjIgGL2oB64rOWvdSlbMVEe3swahFTs2pwO6/mCn4lIvaunKwZKSR55+BEFKK/StBdV5CexO9ms0Da0V7mFxxWeMHpzUvF7CAC2fWjECC/z/UEYBCDVcQfqjhvPrLrxc9nZj6VgbLHDrVBJsvtjTsKAHcMSRyKLLpPqY7/mt0O8hC0qz9uZw7oRX6GsrFOKyWXN7gwPYyjwE3S7R04y6AUAamutHTVwpfTF0kHwEVvUHqMCshU13z5a0t9qtGbiOnmuEedqEbmO4e6FVIQ5n4eGrZYZq0cttYlsBh9QgzETtjLMcBvbKR1FpNgbgb0PjbfbEMiinX7uq5gBeQrTW2ZxinKdSd3a3DRrXtiE9mMU9TM78bsRpU0K8e09LepnRnRP5jk5cTbdaFzugGrptKuUjk9qTI4+lI8j7DDTemkp35iZl2pD6vE6h69wsK+K51+9eHAT9MuTZB1wD8MUePCUtvZNZujd7I02wYbe3s53sUibpyUsdCr3cm7GTOurr0f3rBF5ZYkD5IZC+esb5acADCI/v/N5JBqk8uVSeBGaA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR15MB2603.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(66476007)(38100700002)(66446008)(76116006)(8676002)(66556008)(64756008)(316002)(66946007)(6916009)(33656002)(55016003)(38070700005)(508600001)(2906002)(86362001)(71200400001)(91956017)(52536014)(122000001)(8936002)(5660300002)(186003)(4744005)(9686003)(6506007)(7696005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?BD5FDgJ2HnDc46PqqZDWKgCLQU/b9IOn5slbszt0iVTje0jcHWmUgVrX0q?=
 =?iso-8859-1?Q?ZGqKCtpIVG8a+ulsj3OFcxRL0QNa0e1NQoPq67CxZqazi+hY5mYYYvZUlS?=
 =?iso-8859-1?Q?IkZKLIGFWozaAjNGYeByRoxxcgDdVaVydyAtUNJLxQEaUK/lA+l8hccQZb?=
 =?iso-8859-1?Q?IvRE0i4jKU+DSKG8jdYeavYXSpxDrlBMoT7Artg+TU2+4ZRhUDSr+sfVat?=
 =?iso-8859-1?Q?3zZ4tAYKDMiQ4cN8aLr85nzvTdfLI6xaJd0B8Sa0dFYJAJTuCpM395BeeS?=
 =?iso-8859-1?Q?8U2+GECjOTe/+q3UrbTEKCU6y+XS37ugOHQVoJ1Z1R/O8yeOotDtOeUEXl?=
 =?iso-8859-1?Q?Ic+izttldzUbvvFfGyjHEY0CVhinSXPixXhqJ+OHM2OggWlscdKxPUAKgs?=
 =?iso-8859-1?Q?hj+ExaRgtBLHEvbw2kNt1M038DBqjWxfuAlWuabqoi2KBeClO6+YgShp9s?=
 =?iso-8859-1?Q?wQ4Bro+ELoGwfcka+VPhZEs/gtyUEZJOF4cSys1QczcmNJ6ITKAaZ5Ujcd?=
 =?iso-8859-1?Q?DiZO6mxDp+GScK0MJ+JAeRgmc/vx4lcUD0SXushGr0beIoN1hY68bRai4h?=
 =?iso-8859-1?Q?VFLtFDJGDYhAb6IB8XFzOPBc5u660C/OGWYDltzfP22g7m8vsK2OP1Cn37?=
 =?iso-8859-1?Q?ZZlZepl0bFE9HfRJk2pVcriqh6h+OJhtj9QhpxbOsTxWEZaBIamtczK8Ms?=
 =?iso-8859-1?Q?q7aB5s2jxEVWyIzAGwnlGhN+PoCZqaBTEjz7ya0TlusZoozNPWJITp8dM3?=
 =?iso-8859-1?Q?WT5u6LLCJiRn2Sr8gmQEp/Myr29ybRdfI3BPKHip19sqP5uoYc/skeUT4A?=
 =?iso-8859-1?Q?ovAu80OvIwau2DKKYEh730S9GlwNUZMRAu0Dd4lcHsgkFOsmKeOUnGyens?=
 =?iso-8859-1?Q?gDSvg5mtYBHxM+vvNAg47ViJXWKWXah9bLYXzKzXtWELk8rb4rblvRzueu?=
 =?iso-8859-1?Q?XAfkmDxf8Q+pqLA5g18jOFWhuvRuPy4fSg9XEVWXk/kVzxltfFgnyifsnH?=
 =?iso-8859-1?Q?Qouw2klPyz/8tIvfWuiX7DXUlwxuWC5Kv+2My/cJM09/NIotf7jKmxMWHt?=
 =?iso-8859-1?Q?Wj7HheF0PCuX9b4yFriFjAQy4+h9XsEmWdLwcMuMG2vXetLg5gF1dshT5t?=
 =?iso-8859-1?Q?Ix7LgkIDzu2efiOhZNEsxwTlBio0yBBGpPf+QAtvN2OgTpXqJa4bsKA6Gu?=
 =?iso-8859-1?Q?sCtq2+QWPWdDir3RZQ4QodL3Cnl5wGxNT6FFDUFxkOsAopNTe7aP39SLb/?=
 =?iso-8859-1?Q?zvU8cybhGgnZGYYKGZsB6mrrnuKi7wL1dfkyaHJepqAujzENfY1e+in7ou?=
 =?iso-8859-1?Q?JjV3r41YoRK1v0I+QUKnDD8d9UOGSICBK5pMDdPTdj6nNgK+EUq60/+ONy?=
 =?iso-8859-1?Q?lV+OPYMpf4Aqqz16FWNIpNxfOHqPx4vjEn9rlZO/At6SEjVvLwqn1Vy6X3?=
 =?iso-8859-1?Q?8ulVxiK2u7Lzb8o8Qg5Fp7viWQU4VGzM17q27wk8T+NLTMFTIrdjHjRYxL?=
 =?iso-8859-1?Q?qD0pUUBpEiYTbJakpF/BlkveLCIwkuxHTtKPe1XrVr9y2jToL1wHT7idPm?=
 =?iso-8859-1?Q?koE6PA0ckYyQ2vw0sbyERpQqa4wL?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: il.ibm.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR15MB2603.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 99bb5063-d4e8-4844-a2f8-08da0cc64835
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Mar 2022 12:11:38.0254
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fcf67057-50c9-4ad4-98f3-ffca64add9e9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mJxMkOpb3UQ7jVqjs7DD4TRpoyagTw5KPN/qWfpOdIjnriCEFMytrqb0Ig1ThFDIs/fdC12QLgBjo7pVG4FsLw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR15MB4675
X-Proofpoint-GUID: g6qLVSaFtF5_bRCq5OFG1sz4TDv1JdkS
X-Proofpoint-ORIG-GUID: g6qLVSaFtF5_bRCq5OFG1sz4TDv1JdkS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.850,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-03-23_07,2022-03-22_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 clxscore=1015
 priorityscore=1501 lowpriorityscore=0 phishscore=0 spamscore=0 bulkscore=0
 adultscore=0 mlxscore=0 impostorscore=0 malwarescore=0 mlxlogscore=713
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2203230069
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I get partial receives on TCP socket, even though I specify MSG_WAITALL =0A=
with IORING_OP_RECV opcode. Looking at tcpdump in wireshark, I see =0A=
entire reassambled packet (+4k), so it is not a disconnect. The MTU is =0A=
smaller than 4k.=0A=
=0A=
From=0A=
 the mailing list history, looks like this was discussed before and it =0A=
seems the fix was supposed to be in. Can someone clarify the expected =0A=
behavior?=0A=
=0A=
I do not think rsvmsg() has this issue.=0A=
=0A=
-- =0A=
----------------------------------------=0A=
Constantine Gavrilov=0A=
Storage Architect=0A=
Master Inventor=0A=
Tel-Aviv IBM Storage Lab=0A=
1 Azrieli Center, Tel-Aviv=0A=
----------------------------------------=0A=
