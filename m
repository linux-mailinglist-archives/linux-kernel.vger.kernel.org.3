Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 325554C9BE6
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Mar 2022 04:15:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239271AbiCBDQV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Mar 2022 22:16:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229517AbiCBDQS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Mar 2022 22:16:18 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67111AEF16;
        Tue,  1 Mar 2022 19:15:36 -0800 (PST)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 2222X2pM006516;
        Wed, 2 Mar 2022 03:15:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : message-id : references : date : in-reply-to : content-type :
 mime-version; s=corp-2021-07-09;
 bh=5ilU3kDGApcWwN5oACwCZ+zIm2hYdwN87vSg3n9ngNs=;
 b=SvJGfcrc07yd7mqnWDdc18lxpXQTFwsURKQIjSqxbklDEJlw9GM/WXnRxiuWB1YPfhDm
 WudM17a2dSLpcWLesv9F5edA6MMPwBEgYlYWzva9TgCQLJX7B5hHIO5RCXxnjih5P/YW
 kjwRdfRAJO2uh+l1ljVStCXgx+3Q0fIcWR5MEpCV9Y1ZavBE9MsVXz6YPVGqxgIF8X/W
 0rIcg0bk2uSpLaDWL8B43IV3jK3m6dcJKRuR0eGnE+WVcnun7OufhqbIqKX2YQnhLnl+
 Ii7oOjYOaCzj2QL0lX5YtGbmdOhQIqsjZeA1jeWkK/j4x8kukjEOmSj6Ei3gnpptDtUX xQ== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3ehh2ejfw6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 02 Mar 2022 03:15:23 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 222320dd164154;
        Wed, 2 Mar 2022 03:15:22 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2173.outbound.protection.outlook.com [104.47.57.173])
        by userp3030.oracle.com with ESMTP id 3ef9ayqsdt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 02 Mar 2022 03:15:22 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P0S6FsoYWtrV5N3MAezsnMrAAJTcH7RJv6fCcj1AJyeL6xp2lYQJ+D5lIbGkYAigoyBBgxPK30z5o3TzWot9sBc8lmREaF+CFfJSgpyGhoYW5D9QY+lbAQdYhYrco9WIgoTFuakrxMAIdO/Ls6tUtCxh17De7sm+rF9E6X+ksYhf1E4GG0DIxh30aAwaSSGa+o4B1t/aqN8gv0GLz2Oo/fffM/+2hhHaZxE36F/QqKg/Kj6QyX2yp2fVUy8b8ZzZR1dyoOssYMQtFDYVdhw9nCpLoNN2KQaB1mzMB/CfD16IR9NnjJODfpafgq49DWrkMadDKSUfDsNA9U5k58b+tw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5ilU3kDGApcWwN5oACwCZ+zIm2hYdwN87vSg3n9ngNs=;
 b=NhBwL52HB2gx2Q20v51D3vfbY56PX94g0cKmpE2mBkaVrwiODR/2QpPIizGEZDA5kP6uk73NAIXJCIVnE1lxnGsFsyQtZOa1A223VTHGeyOb97sNS4CiMF/LVMisdrVnsVtnIhUaBxaSm3CLy8+VwX+OHDy7uBIysAtf7xuVtzTydlEH6AtYI5LB4gWt2YZy2DPmgsW0mJ2WRwBjhg7c+yvh1bgTgRuyfHZkEypaTUbbvXl0Jld5bo4ZiPhuAuqpCBKm7RMecrdGOAipjj8wNKsQw42iiodKmt0uKTnDiqz9v5KfSaXWB8iaD1kDk1hs0+dq930jFeH7a0i7It3alQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5ilU3kDGApcWwN5oACwCZ+zIm2hYdwN87vSg3n9ngNs=;
 b=p4n/1QpeoFiNq5aNd79J1jpt16RqLa1gcKK5AXJoIrBcSGlubCoGFXGp8WVan3LxhML/2MiwtRejadBniKyOvVBtIq125P2TT990leVbghyogOrtrEi9Ox/U/PAIfGO3KJDP9104pkCKoTDprd9GvVMXnJ496ImC2QH7j8J1KJg=
Received: from PH0PR10MB4759.namprd10.prod.outlook.com (2603:10b6:510:3d::12)
 by MN2PR10MB3630.namprd10.prod.outlook.com (2603:10b6:208:116::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.26; Wed, 2 Mar
 2022 03:15:20 +0000
Received: from PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::180:b394:7d46:e1c0]) by PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::180:b394:7d46:e1c0%8]) with mapi id 15.20.5038.014; Wed, 2 Mar 2022
 03:15:20 +0000
To:     Christoph Hellwig <hch@lst.de>
Cc:     Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org,
        linux-block@vger.kernel.org, linux-crypto@vger.kernel.org,
        x86@kernel.org, linux-kernel@vger.kernel.org, axboe@kernel.dk,
        martin.petersen@oracle.com, colyli@suse.de,
        Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCHv3 08/10] block: add pi for nvme enhanced integrity
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
Message-ID: <yq1r17l12l5.fsf@ca-mkp.ca.oracle.com>
References: <20220222163144.1782447-1-kbusch@kernel.org>
        <20220222163144.1782447-9-kbusch@kernel.org>
        <20220225161430.GB13845@lst.de>
Date:   Tue, 01 Mar 2022 22:15:18 -0500
In-Reply-To: <20220225161430.GB13845@lst.de> (Christoph Hellwig's message of
        "Fri, 25 Feb 2022 17:14:30 +0100")
Content-Type: text/plain
X-ClientProxiedBy: DS7PR05CA0068.namprd05.prod.outlook.com
 (2603:10b6:8:57::20) To PH0PR10MB4759.namprd10.prod.outlook.com
 (2603:10b6:510:3d::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: cb5cbb2b-7637-4835-8233-08d9fbfae1ea
X-MS-TrafficTypeDiagnostic: MN2PR10MB3630:EE_
X-Microsoft-Antispam-PRVS: <MN2PR10MB36305182343FBF7FE8936A628E039@MN2PR10MB3630.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 83GMGgTSoarTXe47Ld148R7UUEWMHjha8vuFMXyERx1r17cMSUhizTnrDH9F9LHwYSLjXC7B6cDycdIQjnHFxhbWrP/kH9y9oosSA7LIcEdhuSZ1B2i1rhqYgSsZQ7XeovCi00YcbBdjHjvVrnU0tHY8faDtapxkRO1pIVhR/5bSGrYsaBO3Y2ALSoMuwSbDe15PjpdZzhu3IeoFfk3L3TIV84p1axBv/JDst4dBk92JMkACxCEZarY33xYUB7C/LU6PGjUZPIijr5/X3OqGmo1ezOOhikBAXrToqDwk2tNMPEmNtW+D89NSW93ByhxJI1MFSG1saPXJxH89L8XHoPpnqLasqTtopvoZn8edoc+MDb03+PiL4qQFEihCjyU9S529aeDv9UUZOkwJ96uw6nJzvP9qoPHfhv7d4fOARaSKGjAA93sQ+U5ylMbuK4uGqPt3YlNNO3z/JBWVbEKvwbNIvweshBgIuCPRJgdkyF2fD64LjQJMoO6IbHBVN4ngskyhpkHrkghGB7rUTqXSmin1yTB3SBl4VsQGxMc8VQ5azp3YQXfNzJchEQcotyIQYwTKzdADat+lYuJhRBT2dEYefAEn6v/Vw9nMvx9vohfNtw3337M/jPRw4x5kR/Ng4tiIO7WVY/zMxHP8xOI3ohvupg7cesdZIHMF/lyVbZeN+Xwzz4XTKjxQKKuVjlTRIbnhn/rbn/ZtopO3LQx0rA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB4759.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(6512007)(7416002)(5660300002)(6486002)(2906002)(83380400001)(54906003)(6916009)(508600001)(86362001)(52116002)(8936002)(6506007)(186003)(26005)(38100700002)(38350700002)(316002)(8676002)(66556008)(66476007)(66946007)(4326008)(36916002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?fn0xfw55QJpo/Eit7fwhs+k+GBMYozvbRtzZKZUzW1efkrutdnODI8Fm4Fnq?=
 =?us-ascii?Q?TZ4n3++NaKsIh0Q6uPo0b2mseRairjR6CL2laqtbBgt0jls1SZsXnYcQZ50E?=
 =?us-ascii?Q?BYr8P5Y9oICL8BXjdoEd/ttNK6Xj6+a+tVXkb/XhpDpZRhqjZXcV3meDtllF?=
 =?us-ascii?Q?7/3xxjZWljxcWTRtWD1/Q9V6RkLd76Aa/ryex1F2p1dRS67ZON7KH3ufRDFp?=
 =?us-ascii?Q?bCQhgTpd6Kb8zqQqrSIgr+fJdojslcQldyamOBGY87D6/XfMDxQtoLp1+iQn?=
 =?us-ascii?Q?2Y5v+2YGiEgyoMlAu349MGp3Qcxe5c11bJFpBXCPvK+/XSBdhRsi1a/P4LwM?=
 =?us-ascii?Q?bdTcip2p4ZQhyPtRvGTUV+TjIPPYCDofdV0YN9Gn1DQmCqA1BGJclOPILcdB?=
 =?us-ascii?Q?6cp7WDOvqnCQUrmL8yEVqR8T0nmuEB45W4Q3dEstS9qOHZ9TF+ORdtMDfuxS?=
 =?us-ascii?Q?nzlRwRr0RPgLJCEbYQZjI6hbV8KdzYBbRae+C1T8JjNkzo23exslAojaAUDZ?=
 =?us-ascii?Q?2qjg2xS2Q/JoiNU/4v1kzgGu46RD6REur68AR8yE0R03D8R6m4WrwD6IcvyK?=
 =?us-ascii?Q?44EsD7n5JnwKqd3+lxI2OoT7ggR9UbcaZ5T5vA1mWpI2UeTB0JW0jGfP0SrK?=
 =?us-ascii?Q?xIxqqtQwx0NMDYd+5p9nqQQSx0UZ/9Ob/5Xm29CnFRAlI8cmaZ9Lx9ayK2uE?=
 =?us-ascii?Q?TmjluabiqZJ4Ls36CH1+z9ShoQSOZp6U8zkMfqmUyX3uNrHJhtpbKqOc+Fn1?=
 =?us-ascii?Q?Zkbk4uV4vw1tpWZIEN1jBAMJZHzTOGgPUtBEvigRe/7VzjM900JTsBrKP6Ol?=
 =?us-ascii?Q?u2wde3w8vZFnGduwqiu1DxjOx89FFWDOcB1WRTPXGA/+oh1fo0oHRo5SFDbz?=
 =?us-ascii?Q?Myd/wIeam2AiGO5lXbIYsobYDM7UGqrsIPQ6aKO8q182q3HXMfbz8pv8+qH5?=
 =?us-ascii?Q?mL+k45L3d/Bsa0WsnUyep2Oe4cJ+jpbzaj5LaLfr/nQiKd9RoyfPWbRC7Wds?=
 =?us-ascii?Q?O2rHe4PmZVX6OpehcSr2Q7H5Xfa+aM3ugbg/adPpS9SZJCfInV2kYWHyaHwc?=
 =?us-ascii?Q?iE5/fpx7ol31K7KyJ2Fog6DqztQbIGX5QiMB9tmSfwCvvzS5vFIKcRuWX3hG?=
 =?us-ascii?Q?MPKI+vc71X21YPBcPxBKDt6Ri5tLYvAKRp15ve50a6irezb6Wpl9xEIqOu0p?=
 =?us-ascii?Q?7ezWInH5m6qALf6przQdd76mHD4eN3lptsvUw+QNBsjSLS374ktvnG+AKYm2?=
 =?us-ascii?Q?/wmQm4yymRA2Te79UCYRaU1Mn00oUQsGSisVGm5ircq0qUn+ma+S9N7LbLgM?=
 =?us-ascii?Q?1SM8OCeejlYqIFrUjLEIL2POMAbtTe5+Te5jLaDUpcA+rGXbGVMXzD54u18q?=
 =?us-ascii?Q?9UYBHTJtEMoe417OrqOuKsbRXwidJijT9wFKLlDtMsxGD/XNxqjUa3/7NaoO?=
 =?us-ascii?Q?6h61pgWnhzdVrCterv6+2cWUpDoFzFrlPFjZ6UAhIj+UrQ/7CUtxJjfrwWHE?=
 =?us-ascii?Q?hMYz9M7AFHjBFjBZtz2+kohNfMA9SnISdCFradJd3ARs0UHSqakl9G6j8kIW?=
 =?us-ascii?Q?DKjGhL+NW3hLnfQsGaiwumJfiaNu8sR+GbAkccMNz0MUX3cmTUP4vkpqw3Zc?=
 =?us-ascii?Q?yTB5tEnwaDQT5P0+Hms4b7bqYN1VBBWZUQKZt62yAxuHZxdqJutImVJPPfGd?=
 =?us-ascii?Q?+Yjvtg=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cb5cbb2b-7637-4835-8233-08d9fbfae1ea
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB4759.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Mar 2022 03:15:20.1523
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AmCYdtndfz8zOgMGqJe89PmdK3C84wl8J9SmlE4AApd0I6D0rLVxTAbAj++zBk2OVw708VvnITE+2XU28nK9lQ4ofnIn5ZI31n+GjHaKOyA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB3630
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10273 signatures=685966
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 bulkscore=0 malwarescore=0
 mlxscore=0 phishscore=0 suspectscore=0 adultscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2201110000
 definitions=main-2203020012
X-Proofpoint-ORIG-GUID: M_FwxMclyNNAcPEFmLh84b4AjgCtVTTN
X-Proofpoint-GUID: M_FwxMclyNNAcPEFmLh84b4AjgCtVTTN
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Christoph,

>> +static blk_status_t nvme_crc64_generate(struct blk_integrity_iter *iter,
>> +					enum t10_dif_type type)
>
> Shouldn't the naming be something more like ext_pi_*?  For one thing
> I kinda hate having the nvme prefix here in block layer code, but also
> nvme supports the normal 8 byte PI tuples, so this is a bit confusing.

The rationale behind the original t10 prefix was that the format was
defined by the T10 organization. At the time a T13 format was also on
the table. So from that perspective, using nvme_ here is correct. I do
like ext_ better, though.

I don't particularly appreciate the way the new formats were defined in
NVMe. I would have preferred new types instead of this "just like type N
except for all these differences" approach. But that comes from NVMe
completely missing how DIX removed all the format type knowledge from
the controller/device and instead put the burden on the driver to tell
the device what and how to check.

In any case: Naming is hard, the code looks fine to me.

Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>

-- 
Martin K. Petersen	Oracle Linux Engineering
