Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE64E59AF41
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Aug 2022 19:43:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346844AbiHTRnd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 Aug 2022 13:43:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346819AbiHTRna (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Aug 2022 13:43:30 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B42D313CDA;
        Sat, 20 Aug 2022 10:43:28 -0700 (PDT)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27KHhOZZ015597;
        Sat, 20 Aug 2022 17:43:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=qcppdkim1;
 bh=igXLeHv93aBaayrwbG+HSAtIn5SsmECRQtHtOiMQlF4=;
 b=U1+eqCBJKntlQ12lKQAd0boH9VWdNWVXE1AXypuT2hQN0UPpKmJMNWYk4Acku4JlJoxX
 0z1Q6NN+EVjsc03XVsE92JtxX6ANJdgLcwpS6FrIduorfX1K9wU2Ps8nBMEkXRjM3UQw
 /AfJVk3GNAQPo2bBz9YvJ2kqCxmJALehK5X0wrGXiYCXfDrP5fM30AatdR4B9MkvNQzD
 vx68F+pt1Bry4u38zT5DmeQaIm46LKWShSvzNTtTCRh1a/Oe+Tshvmw8tk80raG1s9GF
 Za9l5lVs3o7VUQIS0xI1nmxSXA4UBr+sSxPDrciGaQtkCenfdn/mtP6CaaqR40bbQBE4 Vw== 
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam04lp2177.outbound.protection.outlook.com [104.47.73.177])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3j2vwsgh7t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 20 Aug 2022 17:43:24 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JezsCQ1TPGLiUyi2Pa/VfcwSH2zNLIlw0LRFgRxZnqSahxgh7IW8E0QI9Qhi2rVUSHpCR4qsqw0qiguZbBDWxjEWG8iSrIUP9SxZiR6W63QVHf4eB2d1QZxfB8IfYQprsUCIw9MHJnThmnR88Ba1uMh7qy32pG0Rxr79HyqcXnH6yseuj1f9IxxcL93rR3S/851j58hR7PMSvW0tUxhN1ek2KX/QdKMhYeZwIFRFwxNDZ5KYeXDsM7JvjQHAFmGK2zuwrselJk7IH4E4IydpOpgzTlDxbYFD2SqXc/btt2BAGv3SVA9FsjJbgAJ3LASkZlZFIubX4q6OdqFK+dbZpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=igXLeHv93aBaayrwbG+HSAtIn5SsmECRQtHtOiMQlF4=;
 b=O4Lyd3p+mE224aUeEvU4Hwxj7EorXyE8Y7m348DXvB5v1atLi0OkRHbMXaVvGHLGML8TtXY8Sl5OqFbh+f1JcN280e/oEF7pQZm8G+ieJCCHG2Wd9cXibktEi5oSb4pr4hoeZoQZIdwVMtYFNjN5nUezFGf0SEGmQX55lG3B7Nyq/6FS1H9D3Pi6WgFFxX6qUc86xDhonUwK26lsWZ+Up6sCrW7CFX2kRgR/MTzwNgtaGknSHtDIdCZ/mqNnwrN/iIuGlHzSd5ZDtH+vnxs3uTp++dkefro8Q8oNnhC0GZsduPqpIQvchCgZqaGomjLMFJPKR95YrqJkzM3+P9h1Bw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=quicinc.com; dmarc=pass action=none header.from=quicinc.com;
 dkim=pass header.d=quicinc.com; arc=none
Received: from BN7PR02MB4194.namprd02.prod.outlook.com (2603:10b6:406:f8::18)
 by BL3PR02MB8148.namprd02.prod.outlook.com (2603:10b6:208:35f::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5525.19; Sat, 20 Aug
 2022 17:43:21 +0000
Received: from BN7PR02MB4194.namprd02.prod.outlook.com
 ([fe80::2940:82a9:edbf:233d]) by BN7PR02MB4194.namprd02.prod.outlook.com
 ([fe80::2940:82a9:edbf:233d%7]) with mapi id 15.20.5546.019; Sat, 20 Aug 2022
 17:43:21 +0000
From:   Brian Cain <bcain@quicinc.com>
To:     Wolfram Sang <wsa+renesas@sang-engineering.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "linux-hexagon@vger.kernel.org" <linux-hexagon@vger.kernel.org>
Subject: RE: [PATCH] hexagon: move from strlcpy with unused retval to strscpy
Thread-Topic: [PATCH] hexagon: move from strlcpy with unused retval to strscpy
Thread-Index: AQHYs0V3x9WrQKrb90exUEFxRtwz1K24EgUA
Date:   Sat, 20 Aug 2022 17:43:21 +0000
Message-ID: <BN7PR02MB4194E17163F8221AB873ECDEB86F9@BN7PR02MB4194.namprd02.prod.outlook.com>
References: <20220818205938.6192-1-wsa+renesas@sang-engineering.com>
In-Reply-To: <20220818205938.6192-1-wsa+renesas@sang-engineering.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9efd4f51-1570-4575-2e6c-08da82d379bb
x-ms-traffictypediagnostic: BL3PR02MB8148:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: iWHhC4NZkw4rvF7bTDZxSmdec1XpzxOqdNo+CD43xYJj1zY68kdF/toX93vlvOtykNIWR7NfvCGOiiAUhTfIV5Au/QHDDDWzE9EPUQaiUKsGBiFQnXaOBr7rJWQTPkp7J6UPswFv7FyUqToEbaB5j2JVcWLT+8XK4Yf1IxOEmUpnh3pJ0diOv0URgkl1VUr1bKnRpw8BbUczz/OJNvu2Tb4/28hovLqmrFIiIxV4nMSJk93YA4XZkq9uzBhSu4z67CDiO3kJWbqlnBUVe2WoRRJrKVQkIPXgKk+4bgkNLlX/7s9aY0qSM4QyTaCgzWbp6V43S1HK6Gjvd0xI9FXbgL5+CY+q+Dh+QGCRYPbWSnp4BTdGc7fYbpMIo8sofadmTrls4LaBnEFh05PMouxzxNDkI7wnVR9BPzkI7aMRBlPk5svx9Wd8sW6HC4QBGgfWGNuZDlKJphINpVhUwzLgYs4NPsZJci2u+V5Ie1BlCrUq3y+VbIgyIsthr8xiGP9AM8uzwKnEkNm80nqeclg0QgpVoe4BAnqljdG6ND1qgU8LrZGg/hYAjIsj88nywyoXQNGONqUZPNL4awu2SF3ibtdM+5tkl9qDLDBPwdDhfMFFVmNftcAbYAN/thQOPinp+C92QRcvtjHizFIDhbdq/ddveqZgvqWquCEtthyhTqts/0pBs9AtEFaCsWB0ljMtaLzOivrFaGMhr3vip3STVRgQNnNhTH0jLySUn5JtPhUmIc/dSvVXMdWpsmwY1rzIp51ILDImGEdEIQJTu0uv7ClxdBe54FD0WJqGhGx+n2U=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN7PR02MB4194.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(376002)(366004)(396003)(346002)(39860400002)(136003)(41300700001)(66946007)(558084003)(71200400001)(76116006)(110136005)(316002)(478600001)(4326008)(64756008)(66476007)(52536014)(55016003)(2906002)(8936002)(8676002)(66446008)(66556008)(26005)(9686003)(38070700005)(86362001)(186003)(33656002)(6506007)(7696005)(5660300002)(122000001)(83380400001)(38100700002)(156123004);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?YH3xwlMcI2oAgGrJfRDK7sKbpVo9tpUHrrU+b1eXFOKFc9pvz4t4p2uV+rid?=
 =?us-ascii?Q?VddLNdA9q9plBnXvmPWvu4G6y6sOWRo9LVhq75FHoIEx52jso9o92DztsxSK?=
 =?us-ascii?Q?fBzSXtC4fxCr39ii2tS6VJ+PrTIYr5760QN+TWyA7NHynDCHPanbhtlpJ6eI?=
 =?us-ascii?Q?HNZ7LcpQKSrHZToayCkuOeFQfRi6yuealapt/9hUgS4SYi5TKd2Sg2Ru3yke?=
 =?us-ascii?Q?e4c8rMHytjc8jiIQiS3XU83DejTncaVeV1u2pIoLNSBthPcE4fBEdUbiCylB?=
 =?us-ascii?Q?3sMB97ZC6gfK+2F4vMiDATUQPEzrzMmwZwfO9Kzf5Kbvl/T9CAAs+ErEJHaJ?=
 =?us-ascii?Q?HVf2OqeoA3DOYfGvIpuRAfvhCBZnQlvxe8qrPfzlCfmzXbjNgqyqOxTz/xxr?=
 =?us-ascii?Q?oyQ0MXroRuUMKAv3a5ap/SQwf8v+nHUSFRwufQqLamjajlS7QxHENgTKUp5f?=
 =?us-ascii?Q?gJTWl1zaxmcCK5O8ttsqNFG1jp9P9SxQOPL+Kixfuf2CU2Cndecj7N2rl068?=
 =?us-ascii?Q?2nQpEOALuZd7A4wDvFIxslQNIe8+Fn7jc1rzzpm03/ggP+3jrSE50JuZgEJu?=
 =?us-ascii?Q?Q4MvLYagRezVAESYTxNax+I0B8EWnYb4JesYgXbp9ZZEG9ahcota529HTqhd?=
 =?us-ascii?Q?bAIcTO/AIHlZsAhhWZZb1Ags91dKKL/AaelKjGD30UHE56HYOA7GqcSJ6meY?=
 =?us-ascii?Q?61yVfEzvkpPmU+sZ+zlOXUCAiuSk80z2cRay5TrR5PE08w18AL1+3SrE3P6h?=
 =?us-ascii?Q?cKKW30WCvZvwjY8C+NAXx7mpVBlACXAtWQVgTiR08sehrpS5VUTkWcGWMefl?=
 =?us-ascii?Q?jEFlA02M87xBYSTgEhKvw9FlJFrVUr2VleVLjE0aaRcPH5r+I6NM4m3YLXvO?=
 =?us-ascii?Q?3KJaklTibBUl1tlOvS/DgSdoeuuFQwG5C5isbelsO+HPs3zK/ZQXXVhy1ht/?=
 =?us-ascii?Q?BfQcnRTJj7AFnYg2hEKdceuT12TnmSCTdzTFHDBlklX0KgzWrlnMWhW7e7WT?=
 =?us-ascii?Q?7q3uQLDe6HMUz8ABJ3/x8Xn6Lr/r0T1w4q55t4JRuowNZdZlp6gvy4jj3Kov?=
 =?us-ascii?Q?VBuqQCCBzuDunK9VbYxxBRTQD20lnCaFk/PuYouzrChuk+TXPKCvbk2o3MLA?=
 =?us-ascii?Q?SMfWHtpYckOH6vI5xCpzbQyqu2DGA03x3pJIAiysCfowmLJkhp9Z16gyxsD6?=
 =?us-ascii?Q?jqw3dRoK4hUcdyfzWg1Jj0VqRDfhoQn3HLpHIcLtJk+NJ+/4Drj+aDA02Xc1?=
 =?us-ascii?Q?z3nI3xxvawNCRbEfoF/UUibOPKLg1W1OOaJDJVVgpQtKdwBfJ9t26itRTe19?=
 =?us-ascii?Q?zjpndb8XWl2TcVxKUqyP8lXfitFfvJKwyefQuJ6smvPDjuKI5GDcJ8mfkd95?=
 =?us-ascii?Q?mUlmbWBWMl4/9oIYXgK/xahYWfGxojoq0VWHXPWdc/Y4wXNPz7cNF+p4VZAT?=
 =?us-ascii?Q?CssxjkwqRbv2cTnGqgJO6zeJG/SYv5YtUIM1aA1m3hnPg0ChGsxqW+S+bXNs?=
 =?us-ascii?Q?C9+DJsfUukiDRtEjGhc/YiV6e5+e6p6wegOfDXlij4+0+yMfJshOTualyfjF?=
 =?us-ascii?Q?qW3eaWonsSGN+BTiz/sbJZzPTzKNnn7BXHTpF08O?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: quicinc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN7PR02MB4194.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9efd4f51-1570-4575-2e6c-08da82d379bb
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Aug 2022 17:43:21.7898
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: IggYwrTSs4b3ckGvU44wjYJw63Mg/iszoTACZ7zlJm9iSyLWrejEFGVTVndrfxh8rjxVKacvu/Neyg9bg+HOHg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR02MB8148
X-Proofpoint-GUID: _ZfF5y32QIWMm7gpphRWJk_TDQ60aHR6
X-Proofpoint-ORIG-GUID: _ZfF5y32QIWMm7gpphRWJk_TDQ60aHR6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-20_08,2022-08-18_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 bulkscore=0
 priorityscore=1501 spamscore=0 mlxlogscore=640 malwarescore=0 phishscore=0
 impostorscore=0 mlxscore=0 adultscore=0 clxscore=1011 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2207270000
 definitions=main-2208200075
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Wolfram Sang <wsa+renesas@sang-engineering.com>
...
> Follow the advice of the below link and prefer 'strscpy' in this
> subsystem. Conversion is 1:1 because the return value is not used.
> Generated by a coccinelle script.

Acked-by: Brian Cain <bcain@quicinc.com>
