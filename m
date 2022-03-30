Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C0054EBB86
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Mar 2022 09:13:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243680AbiC3HOB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Mar 2022 03:14:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243654AbiC3HN7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Mar 2022 03:13:59 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CAC914A90F
        for <linux-kernel@vger.kernel.org>; Wed, 30 Mar 2022 00:12:15 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 22U6nWwi019526;
        Wed, 30 Mar 2022 07:12:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2021-07-09;
 bh=IrPhoTe0Cf9NxieC4ZE6ZEfjqnf9qig+vygVKNwf3Yg=;
 b=Fo4bk8FfFcVF8rUFrPkcwmfdX3hhnRbAVbeKfN5K27XPncU7ZcPRD0qqEns483ty3b8F
 KMjiIxj7AqKy+T0KzBrkd3ypxFZA/upttFmDbxOMl6Yh3dupp7wI6JaCwdhqBUpca4uB
 mgdpvzZp/XaJbs3Jn33QmJ9eYNx6qcEB2eSDBDzqpQhdX6TC1DXVdLqwlwwJn3WtXrjD
 5oSa39NpeAVUoyTfd08F3ZZH0u5zuRpiYHWjb4vpGjL/X7nV4jnSd8/wpi21iGedqkh2
 4U+Ygi2ptZq0do6rQ/Y+8dh/ysiOg0k9mJJ4xCI2/DnAmPGd0/CJIvti2c3JjF3bIDKJ og== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3f1se0gmy0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 30 Mar 2022 07:12:06 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 22U7C5c8164201;
        Wed, 30 Mar 2022 07:12:05 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2103.outbound.protection.outlook.com [104.47.58.103])
        by aserp3020.oracle.com with ESMTP id 3f1tmynt7t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 30 Mar 2022 07:12:05 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W2NhiEMC78LcAvX6BedP+4bYyznDqYT3iNqG0v6lle2Ch5esq1aKG703RWu6/4pRdm0NLYMhXLkgziQfHdxmLFu3PgDO/eqFoagM3MVWHnNvAyEqNF0g78SDaB3rQbJZYXCmU7nAmCtBrprv7+lR9iroCsd7ya4ZYPgsCCQEksoeTQFvXXDZ9iXbzdcoIGye8fjMRe4TThEDvEkaFRgTWrewREUIVfCq662vf6nD7fJmEo6xWH4pXRx/qLlmnRLlJIqjhec1C2zkxyNd0QrlgWNAQI2zbesF/z4fLSUTekeP2y0sa24pzEcxzRajRRGvvXr1RXKBbi5dIv5jcGoGuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IrPhoTe0Cf9NxieC4ZE6ZEfjqnf9qig+vygVKNwf3Yg=;
 b=Y0+hl3qgNQ6XfDptzmEHpT/cM/ZnjWQoMvCH0Fwd1hTOqan3lNKnrAcOeiN7tFeIGeOorc9JCfo39sI6HiSlHF8fQTmtjnGLBhOF1jVeNzd7UebwQ4N/ak6zC4yQI9Fl2+3mVuLU9OMhGOuV+6ylZ36EgMatR2weQI/2K6Pz1WEQnLFCkhS12aU+IgfJJg0ieK+7+1n7E+ZUOj+lpEp2z/C4LNMsuaH+mYFvtYu1EWVWkO8gHvupVgqk2Sjz3/FscIoUo7zx6ifTOkqnpNSeNkvp6fvtNd8jws2SeGzZTNeq0XlCGm0M0XbmtNKDIaGOTUwCXadzfD5/AUgkqBpGTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IrPhoTe0Cf9NxieC4ZE6ZEfjqnf9qig+vygVKNwf3Yg=;
 b=oj6hZOOaFYUoOEYaLytL7fcbOgcX8v4NjSIetYIJK/TVc68tmGp71MKT4IjPnYqHYLZARL5rbWlhOMC/iSuYX16VivM5qS0WSzlH6F6S+R24ke/jNV9HZpTDXVdtKhujk2mOwPF26ANR2CqpmrK+sDkmwT0w4pGTk47o2tb54v0=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by DM6PR10MB3659.namprd10.prod.outlook.com
 (2603:10b6:5:17c::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.17; Wed, 30 Mar
 2022 07:12:04 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::d4e7:ee60:f060:e20c]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::d4e7:ee60:f060:e20c%7]) with mapi id 15.20.5081.025; Wed, 30 Mar 2022
 07:12:04 +0000
Date:   Wed, 30 Mar 2022 10:11:00 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Charlie Sands <sandsch@northvilleschools.net>
Cc:     gregkh@linuxfoundation.org, Larry.Finger@lwfinger.net,
        phil@philpotter.co.uk, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: r8188eu: Fix sparse endianness warnings.
Message-ID: <20220330071100.GG3293@kadam>
References: <YkPK/QmLAp3BkygY@sckzor-linux.localdomain>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YkPK/QmLAp3BkygY@sckzor-linux.localdomain>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: MR1P264CA0051.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:501:3e::26) To MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: eb353b7f-55cd-40f0-336f-08da121c9771
X-MS-TrafficTypeDiagnostic: DM6PR10MB3659:EE_
X-Microsoft-Antispam-PRVS: <DM6PR10MB36592BDD3F2E7C80669F25998E1F9@DM6PR10MB3659.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7hZLUp6ZT7ZNehusZexXx80l0IKlkm/bnXbWlKdX9qQzcDtAEeBHu8nMUBTnVd7eiJoRaCe5zSCjK1MBLjlt6xqMzQR4cpRxmcd4lJnNZquhidP5Ipios8gOZ6vQ1IyXOP7SW09PuVLSGdv6ueQ9eJgw3BI7lKjAsvEQFE5eYon9aLiU9vjHihb4eE4eWkZb68+44jOw8mSlWS4aQelBemTBBDdpcJ31bRIvlxO2d2l+PJV8ReluXD8AsZia3HFFxGrSAGrt9WbP8wxe8p4XT9Sxgf3lZb9GbjBJEv/W7Ws4AT9Sii3Bssgpe3hYSiO2iqzI3REfwES/bdVpxsB453SKHXWh8o7/yrLZk05lvPNmGJXDfoWTqWmbWsCT4VttA01KJeiF2ZT3m77IwOaeey8qcRHe0kZ4VmUV1M/q47sP754GXzbNYFjFA7nhUJ2kqU41WqItziL7dwN1t6yslVsm1NvDt/DyL9y/JgjJKDPzyhfi9rFwM5PzHkrpDVDe656DB/bnYIk1pSOyqlKat73syQRcwXSeLsbaNlQhz0Xtd1pRXCESGqqGK5ne3AFbkhMJBSbJ9gj4u+RuKMxKxEYRh1bCYmMeI7JtRO1fECAuMkAommfnuRio4vsHWXKJwMfZhVLySVNdpLGt7ygPMZew87m+heH7X53XfxorPOqbI3Z16qo3Kid0Mf/ik/4DVSZ4AduvRmilFHUTFvLsDA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(366004)(52116002)(44832011)(6666004)(86362001)(26005)(4744005)(6506007)(5660300002)(2906002)(8936002)(83380400001)(186003)(6512007)(9686003)(66476007)(38350700002)(66556008)(316002)(38100700002)(6916009)(66946007)(508600001)(33716001)(6486002)(4326008)(33656002)(1076003)(8676002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?OKgFBvOoa+GGfvBIg1Q2p8eZB6RagN2FG6BqdpWojBwhL+C2CHhjJ7h8Kocb?=
 =?us-ascii?Q?agEQmDP4cLOfN2zjUykqn5pS3756fKZBvacqr6cLHyWYEm18bqEsltSPSGKn?=
 =?us-ascii?Q?AUgsObmVrlQXqRaNTnIeL3bSGROMdDKag1Prix1XgjuFaMW7iETV5tFCaVGP?=
 =?us-ascii?Q?CpWxxp8PMnZhPkMTNNrtSFEm7daax4l8wBE7tFFjhEkusRwR6YpoX0Gz5byk?=
 =?us-ascii?Q?IL4kOz00rEZlKb425w1Vb+EEKaE0G/XFnHMwG3XnYxO/qCuTv45P2YocQ6Bv?=
 =?us-ascii?Q?oY0A0/cuUWL3yFGrJOEZ2YEhmX7RgZKp+ZWPvEMGRJgA7VBtlbk0hET3DFTN?=
 =?us-ascii?Q?KQ4teTp652DhHXhp2p+dc3ZnMuRs1xH/lQyH4gu+SW9vwzBlfxgR6rIRYxk8?=
 =?us-ascii?Q?oHtyfhnPeHT+9WwMGZERQw0FWfojOmX1t3DLNX/TNIsNwHGjfMhVtl700UZu?=
 =?us-ascii?Q?IXW0Mbx6Rr5yqRPZgwMkrESEaShCE2xFvFLlxdhYqD97r+L1yPaxd2Vayo9L?=
 =?us-ascii?Q?VyJrze/zvO0ejbmuGUMAe024MmVDZGglQcuNBKvzxNkbsjEG3e/ttkPrBQEM?=
 =?us-ascii?Q?XxFRbyfoUc6oAhUT+sKD+ugsSO+ezEzU4E+FQSqJkeVXLbgd9DyXsqXobmtq?=
 =?us-ascii?Q?dm80QgKdy8mpXhL+umKhNrt4SfkDianWe1eRPDbIRFxnnrDnl/HlfW6Mx+kQ?=
 =?us-ascii?Q?qJgS6rDdTnE3GSDF2zoKg1orCu2EH2lueQ4IkemKRA13eu5WEBSLRXjpbpab?=
 =?us-ascii?Q?iJrOYJ3UKDaDMl2bRW1AIGmCv7x1UaAwzdXH4C9fDf4OBxcJ8wTB0dzkGUg7?=
 =?us-ascii?Q?+0BjhkPVMvhkwH07m3UidQV0Js1WfhpPteghqoLE/6pjTlVs4HE06LmqvaNc?=
 =?us-ascii?Q?EErT+OL514E+QmoCvxFLrEbZL6/KJ64ZiBfO8FT6+foeBAgi6KAQ/UvubCuL?=
 =?us-ascii?Q?mZTDjnfYh2VoZnDd2SyQgbZSnRvUcrLqpDl7zFo6oGQkD3XrddkXPHdXJpoT?=
 =?us-ascii?Q?n5OsNdGZgdnblkJDPzfut8fTWpnOgs2nFIvuIz/rhDvXA4QhbjInbwFpA+lD?=
 =?us-ascii?Q?xN7m/zl6Efy/vsmSek/s8dFGAAW0k2Iy0kUxknCCLh9LxElSBNUCMIPXvNJo?=
 =?us-ascii?Q?fSBbDCR5jd9jISwwch9ppgqa+UtHebsS6SOagj6qhxjCAxtqong4rQyY4kAw?=
 =?us-ascii?Q?QEezCubttusFwS9oO2EA0HVmnyV19iYxZEpcicBE5d8h9Vd9cebeEYGh4Xeb?=
 =?us-ascii?Q?nI/OLUkVZttMafVS0ngRgyO0Jcz5iSfCfDgO8rUYSOa3aZ+leP5yJI6ypq9G?=
 =?us-ascii?Q?Y+VCAZACULzG6BJGX8UeFniiUvIjwFdKkDKGTsJla9O+NalzFUS4hgvczVaj?=
 =?us-ascii?Q?3SvSjsBrVTq+yBcEEuSqpWJrU0OYYjK5VULjW0sSOUrrCsyFJsxKbd6fj16B?=
 =?us-ascii?Q?MCQSS6cAzULwL5saf6PtHFp+5S1eNSV4j5qXHojhG/qYeYfALL5NSCorP9Al?=
 =?us-ascii?Q?ndYggKdy+rwIPuhPQ8N3ppRR+3D/JKx/0ZZK1eqgxaeuy44fhmUdCmJO213A?=
 =?us-ascii?Q?ksiO2TkYfGDYqtzTpgVRAus0JRMc106fNCrI1ZcPVtxx1cZmww0015I6cCid?=
 =?us-ascii?Q?3nmKEIJ8mNF83kCamvwgZEnC8jJUhkFg9487KpBvDeug03UQfMcCjC5vrrCA?=
 =?us-ascii?Q?fSF/LbZlV+fcwTPNSCXRyTElV5CBiJpopf9TLOT4kFgXawJoqfT8gvrQq2pe?=
 =?us-ascii?Q?C7Mez6zCIUpQjdblKZ0DdtdjTAPzw7k=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eb353b7f-55cd-40f0-336f-08da121c9771
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2022 07:12:03.9258
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: u91VnZCrEAZq/Teuh/hJb4fADxRmG0MuCAj9MQqNgI4TFZ8nUhIFWAIjYmtuZHbU4EfMKN6l8B3WgUPP+7R4DHFvSG8tiR48D7dbBJMELXA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB3659
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10301 signatures=695566
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 malwarescore=0 spamscore=0
 phishscore=0 adultscore=0 mlxlogscore=999 suspectscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2203300035
X-Proofpoint-ORIG-GUID: 03_lfuKYW6xJKtaG3yOa4VLS4hdbA-5k
X-Proofpoint-GUID: 03_lfuKYW6xJKtaG3yOa4VLS4hdbA-5k
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 29, 2022 at 11:14:05PM -0400, Charlie Sands wrote:
> This patch fixes sparse warnings about the endianness of different
> integers in the driver.
> 
> Signed-off-by: Charlie Sands <sandsch@northvilleschools.net>

Thanks!  This is a bugfix though so it needs a fixes tag.

Fixes: 15865124feed ("staging: r8188eu: introduce new core dir for RTL8188eu driver")

Otherwise:

Reviewed-by: Dan Carpenter <dan.carpenter@oracle.com>

It's surprising that this code works at all.  I maybe have said before
that I suspect the pppoe stuff has not been well tested.

regards,
dan carpenter

