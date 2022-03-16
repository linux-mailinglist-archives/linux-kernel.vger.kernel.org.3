Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D8894DAE59
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Mar 2022 11:38:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355172AbiCPKkJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Mar 2022 06:40:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347519AbiCPKkI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Mar 2022 06:40:08 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3248B3BA41;
        Wed, 16 Mar 2022 03:38:54 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 22G82KJa018452;
        Wed, 16 Mar 2022 10:38:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type :
 content-transfer-encoding : in-reply-to : mime-version; s=corp-2021-07-09;
 bh=3g6Klz1rHjO6lrBetq9DxW9Joy4m9+OCPJb/1yuyUb4=;
 b=rIPWIxTCQfJDCjC/+3/p72cT1p8F3oHTVq1r7MuDh2yo5+iDdJMtfvKkAvAhdyzl19vb
 DUhqqFq6sLtcM2q0beeEx+9haYk0ScHKOT35fiyaudsbptxRncz+a8zO5UFJkeiECo33
 y41ePM35kvCtTeZPmMW9hU6xMmlmmEFAdPoO0iH0xIVIXWclROyJQzwRHTyMKCfJULRh
 o1FVWEZly3DULrLvndGf/t1L0+NoBB9YMl2YCO4+deIWkmomXEbXQ0y0KmqAwL6xE1y9
 PF2SH4CFwdELUyw6hKn1016q5K5Lm6AzLO/ou7cRp3fxwViL6UW2+bp4Y4RgrDy++rQ+ Wg== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3et5xwnhwg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 16 Mar 2022 10:38:50 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 22GAWHig012545;
        Wed, 16 Mar 2022 10:38:49 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam08lp2041.outbound.protection.outlook.com [104.47.73.41])
        by aserp3020.oracle.com with ESMTP id 3et64kk2uy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 16 Mar 2022 10:38:49 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EoWj6mmDxgqd9YinDe+uE2kojJ4e3dWES8Xwi8ZENm3HLHNakKYRquBZ8oahm8Hmsb3y4pUgP/BzgGu5mcdmNBBx3jGU58BGDWwJ7Pm5bSC0VVTfsAXzSU1ti6IgcVdQ9FM0emTb4OSy51rOyibzDbo+rZhTEAf6TtDYQCf9RxDD0iZC1dQ4Alul7H+IdYb137jW+l4onQ9OVLBNISdX5IZwlNXxHXku/KpN1YXCWNs38gYdgGT0he916Ryz1SfsAGHPvOLVchtz8AdWXivp8npO3/OLev7KmTxt0fgFNOCSNrrebJ6TI/i2uno9qljWrbzm6I6ifyU8CbGfZJXtWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mBR8nnsXPkUret0zmNeMPzGlQX9GGK8nDbl/IqSGFnc=;
 b=Hs3YHUBBZL9Iz5WUrjro7zv6P/LvKxz+6ISNSaNonJTTzBKWXKHw8a7TvNT376Wr3qQAiu7BqHfxbUanFxXGU72SnOk0gnQeffYS9sXHNmp7NBv3B/fmN9FYwYxucd6AFqHl0VuhdV26ndDi4PA5c0pNjCwq5kyXY/uzMzB6CWHvHlfczNrrKkhdgxLRbGQRRpy6xjhJGF2KczV0vACh4UcqyyLjvl+YqaKVhXk9XSkxXLic7gNC2cIo2OItIu/yNXg5IR+QTZg5RCDhYt2tb1xqTmduuwwtNpwuDD70TNz4tv4uBmiIuYIy4kWAOP+TISeMFG1eN2iJN/8viAhVKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mBR8nnsXPkUret0zmNeMPzGlQX9GGK8nDbl/IqSGFnc=;
 b=XSETGPpKbIHDUa0GnIydcgqlA37AQ/I35oL26e4GV+FRlH80WOPLoCzc0X2YCBOl4a9bG3m4duqdfTuykzo39oQRzDKPHtqQd4ZOqnlie3XDYFNHA4jNpj79rOH9SpD5AU/+WivHSfvGswr2Y132P6vLpPwmk1y5OcW683p9gBQ=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by BLAPR10MB5316.namprd10.prod.outlook.com
 (2603:10b6:208:326::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5081.14; Wed, 16 Mar
 2022 10:38:47 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::2c3d:92b5:42b3:c1c5]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::2c3d:92b5:42b3:c1c5%4]) with mapi id 15.20.5081.015; Wed, 16 Mar 2022
 10:38:47 +0000
Date:   Wed, 16 Mar 2022 13:38:34 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Pali =?iso-8859-1?Q?Roh=E1r?= <pali@kernel.org>
Cc:     Colin Ian King <colin.i.king@gmail.com>,
        Sebastian Reichel <sre@kernel.org>, linux-pm@vger.kernel.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] power: supply: bq2415x: Fix spelling mistake "vender" ->
 "vendor"
Message-ID: <20220316103834.GE1841@kadam>
References: <20220315223700.2961660-1-colin.i.king@gmail.com>
 <20220315224645.ytcf7y7awc3q2y6j@pali>
 <20220316103526.GV3293@kadam>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220316103526.GV3293@kadam>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JNAP275CA0030.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:4d::21)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7eb552fe-e45b-4a5c-11c4-08da073926dd
X-MS-TrafficTypeDiagnostic: BLAPR10MB5316:EE_
X-Microsoft-Antispam-PRVS: <BLAPR10MB531654F7FD96E9333693465D8E119@BLAPR10MB5316.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lpU0j0fKzcSJqxZxo7fGYuogTjQRBa6e35URhPZo68n/mvywEiZ4Q8MkjEI/YPyE3exI+MWWJzd2GRuf81BdpOztTWOFJwOIWyUxmJwOMeaiZpVpCCtS2HcLcDHBFupfSmK8CTDTBVF8+ewsVnbUS3D3BRYtW7arC/PJFMaEuePOInG+SWnCuEOGug5eeW1y2IdjnqOczUW9i2qbBgnb7V8IakQravBVui7dp7Q5o3kGQqwG5TddJ8FjVgqu3NX2W15ZMeeb+S6yTVhSQalKxUfbEMXnAbPikbCvxUhKnMB5+cyZ+xn/E3pWyC2y7mh32s1OH98NjthLSQ5SCjO1wBVMM/rj2r6C6qQgq+Q6Xvq/+cPy/JAlelPnqTQwr0wH6NH0/d1nziYo6OcgBskXL2eMeQi7uEX82S9upFZ8gJUYosg7d0jDJPDvCKVBjaOlzPDrbzqHPnsO1QnSijD5MVjd1ko7jA3LziAO/dJbymE+plsCWuDT1s0u7kbQVtmRoiLdeq3HpHWXsO1/Ysv0nyrhN7UXC0SKQs8VMGVgCoMUjqRcz6HELYA3b7zLYzKNv9gtYskj6eJZ+m6qNY+MFufJ+XF2jY6nF9GxFlqAToD5nc/kwvKRs1hzCQaV2jt8sWWO40iwESlx+/duoWQzEjQ2Z77ci3QerG2edoS0gx3CjjD1ZXGCzxvKSRP0rUAER1yN4uVEo1lfAkR9MdW5fwKnBZ3/avc+l3RlP25vAVNQ4XojTk3ZCN9BMBEiCukOAOOB/PlOpHMf2TZ+VySQtN7vvsoJ7pR4uE9QF5gAcFU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(366004)(2906002)(4744005)(966005)(6486002)(44832011)(26005)(186003)(5660300002)(1076003)(6666004)(8936002)(508600001)(52116002)(4326008)(86362001)(33656002)(6506007)(54906003)(9686003)(6512007)(316002)(33716001)(66946007)(66476007)(66556008)(8676002)(38350700002)(6916009)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?PHMBaNpfXq8QiSn/uk6f3If7z3Gp20Xv32fHNagIgniFzqHL2JWPtAGZil?=
 =?iso-8859-1?Q?T4aSQzXx4h50YhYbf6rddzxBwSPrpOwpsFARdJSkrjy/RnS2rKROm1iZWZ?=
 =?iso-8859-1?Q?09w6ECXWkvuMoifCfNL2AGgz09YODZvTrekKSRl87QcoYSQdTPtOjHP13Y?=
 =?iso-8859-1?Q?sRAnyi5D+ggW/ctr2RyRrSwpS5/QqRMbVjNgwn+w8jyTfhL4nN0rphGX2J?=
 =?iso-8859-1?Q?RT1bebjrl+KlNsY8mlXKmME91XqBOlBQCcXYlPO4TSqgyC/64OkwPewIIk?=
 =?iso-8859-1?Q?KrH03P19kDD84EHdM+LnxBmmLLuJcLRbx9kGNBA0QLSHnPwjdNag87y3tz?=
 =?iso-8859-1?Q?+zsUe/uy9r3lEMNFTUqk8BQpxB+voDX+90upkNNN2wEu9T/VWLIABOV2b3?=
 =?iso-8859-1?Q?VWcmalclgyjYKJ7975O+PtzhCUucOFY2jrzHf8odhGEs+Z5V3j6wz8V67d?=
 =?iso-8859-1?Q?X5OwbYj/HYCmMWv1sbWmsdZ1zqkYU4xNhByGZXiU7wnI+JsGKVVj1gn8kV?=
 =?iso-8859-1?Q?h1TasOhrRK1KhPMlzpWjVFn5NjS0G2R8P8fugWGb8UQsnm+OVQYgWOeFYu?=
 =?iso-8859-1?Q?FvMCPDVzHJ0ucWSZi97HcA4I3cwoNaYBL0/qzLnZgbmP+QeQtudfOiGU4L?=
 =?iso-8859-1?Q?jF12TmbmET8DReMuI1CzH1Tee4IyBrA4M7uzAcQAgmaha4HtCK6sIJERhB?=
 =?iso-8859-1?Q?p6HFoSWm5Tdp0bDAzObFT6ktNyPrhpfYHS5nbd9IpyW2esFcOtuuT3WHM+?=
 =?iso-8859-1?Q?p2oyky2z3A6Klc9/RZyN9wahEnB/zCfGxHRXBkrkz+o15lbRo3B48Tt3lm?=
 =?iso-8859-1?Q?e/MKjNlcoOOepfIBwSxHFTqp3nvfW+zHF24sHl1dpVEKz2BzR+WFuqmKK0?=
 =?iso-8859-1?Q?7DITup9PFe3mo+YOmxgD8Io+Pb98vigctefxU+m/g8AujL7uexI+NYJLv4?=
 =?iso-8859-1?Q?QeVUKwQKXjiOpaviIeYkj9PCUBFzD6XkJDDDxTDBKUqo293fRJPacYqiLU?=
 =?iso-8859-1?Q?Y47A9021LlFVorhelZgTFLQbV2gvJKEOlhxtRa/24OKmK6OPwr6IGNQUpC?=
 =?iso-8859-1?Q?xdAU4VY+VTvLQfkgrth/DvFf6xPZnUmFo9rrukcqypO8qauXX2MI0TrGMl?=
 =?iso-8859-1?Q?ygpC4S3tL2Wp5toDoGwrGQTERF5tcgD6hGydcLz9A03yDVrs++2o6UF+ya?=
 =?iso-8859-1?Q?lqsVTznFP8O6swlo4IDSiKlV+OtMrqD/B3+oTpLBms8NcoVll1eXwskh67?=
 =?iso-8859-1?Q?xB/TaUfAbgJA1mfoEP1dH4CxAgIESMBomoVZCrQ0Ep/vlf5xSHCXTqqOeC?=
 =?iso-8859-1?Q?VBlm6bHrV8w7wLKypP6NlT8v4LXr4s/AnXAFjlQP/XZPgJQTqruMjeVo5/?=
 =?iso-8859-1?Q?aRTjLELZ/AwjA3X0GiIrSjaBiFizzk+dkRpDyzNrzBbkt1xW6p/1v7RoY+?=
 =?iso-8859-1?Q?ieoPVGdJSfXC+IskIHaSMSeUKtWwZKofuzqmVBEQqUGx6+CSBHhUzx3tqC?=
 =?iso-8859-1?Q?zDbUyyu1PH0rMYDF4oklO9KWWLJqEEK3BhBznmIS6u7A=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7eb552fe-e45b-4a5c-11c4-08da073926dd
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Mar 2022 10:38:47.7273
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qzIlk8pW3uhR1dZObSSW7u5MEI7W5g2Rd7UBR7fKuWPNEtHco5EG5e5a7joBuXM+Yb07/EHYWoR0fzZ4p/qxwnVR2j7csR2F9LChVK55K+k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB5316
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10287 signatures=693139
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0
 malwarescore=0 mlxscore=0 suspectscore=0 spamscore=0 bulkscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2203160064
X-Proofpoint-GUID: ggSOm1X3NOgf7beFpD7E0B7t6dLv_Wi9
X-Proofpoint-ORIG-GUID: ggSOm1X3NOgf7beFpD7E0B7t6dLv_Wi9
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 16, 2022 at 01:35:26PM +0300, Dan Carpenter wrote:
> On Tue, Mar 15, 2022 at 11:46:45PM +0100, Pali Rohár wrote:
> > On Tuesday 15 March 2022 22:37:00 Colin Ian King wrote:
> > > There are several spelling mistakes in comments, function names
> > > and literal strings. Fix these.
> > 
> > I do not think that there are mistakes.
> > 
> > Please look at page 29 of the official bq24150 datasheet:
> > https://www.ti.com/lit/ds/symlink/bq24150.pdf
> > 
> 
> "Table 8. Vender/Part/Revision Register (Read only)"
> 
> Just because they spelled it wrong in the hardware spec doesn't mean we
> have to spell it wrong here.

Of course, there are times where spelling mistakes do have to be
preserved forever.  I forget the examples.  But here I think it's fine
to correct them.

regards,
dan carpenter

