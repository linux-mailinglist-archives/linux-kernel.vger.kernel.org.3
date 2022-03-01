Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 529204C9059
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Mar 2022 17:30:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236201AbiCAQbT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Mar 2022 11:31:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235233AbiCAQbR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Mar 2022 11:31:17 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 429C13F8B9;
        Tue,  1 Mar 2022 08:30:36 -0800 (PST)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 221EConE021768;
        Tue, 1 Mar 2022 16:30:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : message-id : references : date : in-reply-to : content-type :
 mime-version; s=corp-2021-07-09;
 bh=yZFEYd5Fy6g9Lsnx1DIVUbNWknvqmQIqvSTFVD5qdDU=;
 b=kjUIvDFEZxOYyX2oDRZ5ivScwG8a1XTcWFuHImOg/PHqrZRFYZscBN9EbVdo1iyZ6ZfJ
 /eg32mqhZdPMn/jt1ax+A8awYb/D6G5l3N/48OV1fTduVANNIwn0fJFT4y+L5PHmIy8Q
 s52gKrL60V+XwilS+7Xsqmr5Q9dbt38kDwRbJmlWDGrRvGOTWxnGDtpYDe2HoZVvKYjM
 /wVDN6L610+vkdtszyu5lCq2As2TL7XBfnwqAjLKok5QB/QZ+EW12RoUsBhR8NTwvytI
 O3TqHAmovL2v3+ig6ZYif06TgJcOn9CBAu8Ed3LRPH0v7ofm3vFJKxaHasOQXBRFU8vm /Q== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3ehdaysjnk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 01 Mar 2022 16:30:29 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 221GK7Js056858;
        Tue, 1 Mar 2022 16:30:28 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2048.outbound.protection.outlook.com [104.47.66.48])
        by userp3030.oracle.com with ESMTP id 3ef9axqm98-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 01 Mar 2022 16:30:28 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HZ6T+mCjOIahHTvUTXLSdk+r34y4c9Zv8HtMqDaqakJ92Ln1rC7j5EhunrJweeDUoyRpDOlEBGmJJJfYmASxrORE9NJIKazspBrDz0cUokMnJmbXZXHbiHzCvccpFpLEFqDBpcNBvFhmz6eG9yoYgD4kQSDpR6F822NOUZ6itawvpcFlZJIedezS1CvOiJWaV9e/9G8QdCsL9CKY0YgEUhLJkwC3bv6XCNWU4TShUA6umawIKNKlPTd2VcGs/1ILkF9Y995ZHBD6URGRMxMacA7voDhGhwK0cxJSh6u+Dz6spO91LhrsLdb2B3SZaC9C+d7feDmi3OtnzoUtnTCHQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yZFEYd5Fy6g9Lsnx1DIVUbNWknvqmQIqvSTFVD5qdDU=;
 b=nZB4ZVxQr7hq5eJ3CEnQ+dcfsr/Q86HCMXGWsAr/BKXZfs4+pzMvbTwanHMsMZ+RrNKewUqPxrrGiZrmYchBhDQyKSldbBIbMKfRCfrBxBPkog+FcYoTYswnkWmv2FW49rM8LgKikgeXTaaxg1rb7HglCzi8qLC1pwTSDghegq/nkkI7jCODzzBchaGqvgotIpr5Vf6sVH+S+6NdyXERfy7dMChWHuqEBL5guhVg2Ngurqgpaj7ZcxSBBlaYkL7swT66oy/5T5eQNPYLC1rFzH82ldZTE6vnw+vPYgJOvDKlLnMYPR0tYAucXMdpumYCdeGUQ4rZwJkUlJ4EIpZ6Kw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yZFEYd5Fy6g9Lsnx1DIVUbNWknvqmQIqvSTFVD5qdDU=;
 b=cn4gy8skyVFXGdzbpcJlyXfDCd8EOiqXK3kee+LNM6VLJgCgYJISkZhTw3AfVPqQPbKRV8zhGzilUDaEOYr5GklMrqdv1kMsWsxkQo22jJr6dSn9/lC5DuGHed0hhHoqgE2ick6xEpIzaFtXX/LUiH6AptKPzeCcSD2vfSjJcvY=
Received: from PH0PR10MB4759.namprd10.prod.outlook.com (2603:10b6:510:3d::12)
 by CY4PR10MB1862.namprd10.prod.outlook.com (2603:10b6:903:125::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.25; Tue, 1 Mar
 2022 16:30:25 +0000
Received: from PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::180:b394:7d46:e1c0]) by PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::180:b394:7d46:e1c0%6]) with mapi id 15.20.5017.027; Tue, 1 Mar 2022
 16:30:25 +0000
To:     Akihiko Odaki <akihiko.odaki@gmail.com>
Cc:     Stefan Hajnoczi <stefanha@redhat.com>,
        linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        Jens Axboe <axboe@kernel.dk>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH] virtio-blk: Assign discard_granularity
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
Message-ID: <yq1k0dd4pde.fsf@ca-mkp.ca.oracle.com>
References: <20220224093802.11348-1-akihiko.odaki@gmail.com>
        <YhypTNtWpcgh3gb2@stefanha-x1.localdomain>
        <e306700c-3153-9422-974c-1f5f10e232d6@gmail.com>
Date:   Tue, 01 Mar 2022 11:30:23 -0500
In-Reply-To: <e306700c-3153-9422-974c-1f5f10e232d6@gmail.com> (Akihiko Odaki's
        message of "Tue, 1 Mar 2022 14:43:55 +0900")
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0331.namprd03.prod.outlook.com
 (2603:10b6:a03:39c::6) To PH0PR10MB4759.namprd10.prod.outlook.com
 (2603:10b6:510:3d::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c83d37a5-722d-4190-2c3d-08d9fba0ca42
X-MS-TrafficTypeDiagnostic: CY4PR10MB1862:EE_
X-Microsoft-Antispam-PRVS: <CY4PR10MB1862400E19C03DC40084B94F8E029@CY4PR10MB1862.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: eUa8QpazFh2SWGmCFN7mrSqNFPIYy9SY2Eg5fkDvrd1zIlz3wNfvivmO12/lx2BCPbq0T/aYA8rFIR3VyY3DB80JOYJ2s3TteV1Dg6LAuL+bbAVf8jWnQ7OiwGNnWGknucoIXT52fjY2kku9QUHf54+Lg1pVFLXzICeUTCoEIvBmxQmSp5o1I0yVDazgYbSAEeQ8MI5Lo876KmAM3EqHy6HVellW+ya6C8B04sjMUWsnTzXdOXWi2RJHl9VnHY06puQjP/R96pb1WWB1tnvYBtnjkRd3x07h8mRY+vfMS5QD0CFlyiCZstY3v0xxUmlOfuzvAiQTtnsBawAPg2L0Yix2zvMyGzC69LuekDO0RLVyTlxcC2wVwyjn0W7gyTeuLg5Fuw2tPceaxcb495GvjEQQZxtizCDJdwi+c5gWWDuj/MB2ahaDWt2500n1eqHIot0/Y2A5YxdNTIi0KIcWGfy+JdVxxLlQI8OHPbvdeq3FxunOjdtAB8nvHC9EPMWHdcTyxG/JfSCmFmPWYK9Wf+gPGsm0e9Q+9x6sN9TUvIzdRG/1MdgqW9vBO66mLAX8BaZMIOSXHCquKJWnFHSHllHNQ0VrBTXrby4FWEMUfhePOKJ8xzS1ybxJrjnG4QKauqj+N+T/hBmwd2z0w637M2ACfVzkAWf5HBtdOr1S6aQ1rz8QcEKfXdb8MBwX2iHwwA6oUDe4LSPYmCyiL7dc+w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB4759.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(86362001)(4744005)(8936002)(36916002)(316002)(52116002)(186003)(6506007)(26005)(6512007)(6916009)(54906003)(83380400001)(66556008)(4326008)(8676002)(66476007)(38350700002)(2906002)(508600001)(66946007)(6486002)(5660300002)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?pEaMEpxb6flHy1tRmh4WY81POADyAk0hFRU9wAv46s1RGe9pl6G/jsQw3/uR?=
 =?us-ascii?Q?2Bg2egUQ9gdeognkKnEsY5KjTzjOs66C2q+Uw1NsjA+YZP9Bp0PRU6fUOf5/?=
 =?us-ascii?Q?9CqDtW2nGjkA7SM66oTlI86oZiB2PfeFwH0y4E/FXTmeTh9Cg+P0XPOcEPc9?=
 =?us-ascii?Q?fbLtAK81ENn5tA2LkJ+Q4pc4DkjYHGzL/LlwBcJfUqNYk90THS5TMDepbnPy?=
 =?us-ascii?Q?dzNbJjNKI1atCwjZxD5+1uBUOAJYrfVTCPNvvs0KAfOLObOZv8Fuh4AaYbRC?=
 =?us-ascii?Q?Sx+iZDmK4oQZfk2z5T0wHKIcKYKk/7XsYMTCguGIR9kkmAW+EjeA2qaVkLnu?=
 =?us-ascii?Q?eby9hlTtCJTHDcz5/xDDvLnQ9uvsDdos3FgQ+GYUcnwLsfn83LtJgl80rWen?=
 =?us-ascii?Q?J3MJekxnoIcyHK7f2/THNlyLLvNpjN8PKdEtFB0ROgD79K7arpFp6Xun1K4G?=
 =?us-ascii?Q?ajapcmOupE3XXSeURpJFGnBbKGMxh17dbOW8ZhDjxLNlrQKb1VNX3vulXpNv?=
 =?us-ascii?Q?oVltEbVdoZOPWOqRSIfOeE15X0roSBgnaDOcEtwrU9Rzzqar0VFATDa5mCdB?=
 =?us-ascii?Q?NPO+tDmQjqWkQhvzvwkz0EXP29xxQP9FTnnReiqFduofXcAiSFWsnm5M/SRh?=
 =?us-ascii?Q?2kXJoRxBnfst/eNY6JHbkmAJ5XwVJ5JATK+Mf5B/vjcZG6LGEPccvA0mJHP6?=
 =?us-ascii?Q?vqvesy/nI9OFIY86j6sECOGVRpyz3L4azvBeVOCp0A91CErETcY2dOZ3Mkwd?=
 =?us-ascii?Q?EYAKFPiUa3bRBYV6s6dpwPg6K/5XjXqxD2jpHZhtCRY+Rk0un/BYMMWEVXxX?=
 =?us-ascii?Q?c7m0HWcsG+OUft2o9LxHOl68UV1uJ2CmCpns9Hkfd3XH6/z+5gzl0cETDeVk?=
 =?us-ascii?Q?DSGh/bSTeYqD9d8+1jEFgoVX8xoiNpsYvHcA8uwQJlEz4GcxpDhRzjUiTPDD?=
 =?us-ascii?Q?nrtVxgLGi30ZCCR+wc3GvxGI/Tnbs1m6FrqDhqYWahYL94npS2af2ZXPeGRw?=
 =?us-ascii?Q?S8J+IWHUGe03PJQb7qGns7johtxqLjRNRyJ3W7XTswmWdUwDG5BEC1TyBEpZ?=
 =?us-ascii?Q?nsW+BcQimpSVarXuHwNneRMQywNshNuxIArPVjjPH1TcQ+xBWXgTi5U6UEc5?=
 =?us-ascii?Q?JAYxjJsZxpx7RYzEqvL9GxGcraLjXI4fdsf9Cj6IVSMCH7ewYfNaYQGa0/q2?=
 =?us-ascii?Q?OjITzopoxAFhEDAwRuayZ/jgxH3sWnZ+zBreCvHO+1tCFZEL0oiTNZC3ciUf?=
 =?us-ascii?Q?WRpjwzIwmNKHahL4lj7zswmwRr/k2HQ+BxrQ6FVyKf8/iw3tdMMc4+CPS52O?=
 =?us-ascii?Q?H5bNdrT6h3o+4/4ySoBwWV6WKfzs1+cpfs1Jn8oMOd/ENLL6wxzKfq0qxj08?=
 =?us-ascii?Q?QsEmLmD7YoWKli83QZw7ISu7/OBPQ81r7Ab1Nw4Eequ2c4tCDe1cEd42iP3W?=
 =?us-ascii?Q?2hCSLh1PuRtAdt/0mdq1sOsjZxt/idQdOMd8SP0R4PozVEDBBK3X611sanyI?=
 =?us-ascii?Q?yUKmG7Qn9QkNaohIu3Pyc2vvjjDkmckdn7C9w8CXCvX1nHO7+OFI7F3S7BDY?=
 =?us-ascii?Q?6X1WQ1aPUo+alnhGxF1qQUlUPDArgjcO5sMAeBQo0lRu+4sOg3WLhtXqQXrk?=
 =?us-ascii?Q?YhOJlbKrDT+gDAApCARspk1dbGfwIvBWdh0D1LgZPiV4rgaXk3iQXz/p2GZR?=
 =?us-ascii?Q?v5LZbQ=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c83d37a5-722d-4190-2c3d-08d9fba0ca42
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB4759.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Mar 2022 16:30:25.7871
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: m7EC1J0T6rOmelESaBcvnDWn12L3rMh+H3WmQKmQT6IYm01QDC7z6CGzm/vbPhLANa7XqWAXlf9clvVU4J2Rwpe0VYIgpEDy1en9AiqOEMM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR10MB1862
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10273 signatures=685966
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 bulkscore=0 malwarescore=0
 mlxscore=0 phishscore=0 suspectscore=0 adultscore=0 mlxlogscore=941
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2201110000
 definitions=main-2203010087
X-Proofpoint-GUID: pXB-YClmdUvMVhNIgwhqB0xpGp6ozR-F
X-Proofpoint-ORIG-GUID: pXB-YClmdUvMVhNIgwhqB0xpGp6ozR-F
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Akihiko,

> I'd like to leave this patch as is since I cannot deny the possibility
> that the host has a different alignment offset for discarding and
> other operations.

That's correct.

SCSI explicitly reports separate values for physical block alignment and
"discard" alignment. The queue limits reflect this distinction.

While it is not super common for these two to be different, it does
happen. There are several disk arrays that do not have an internal
allocation unit (discard granularity) which is a power of two, for
instance.

I am not particularly happy that we have to deal with two distinct types
of alignment in the stack but that is the reality of the hardware we
have to support.

-- 
Martin K. Petersen	Oracle Linux Engineering
