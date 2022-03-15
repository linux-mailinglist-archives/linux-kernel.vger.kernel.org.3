Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 791824DA210
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Mar 2022 19:08:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350956AbiCOSIv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Mar 2022 14:08:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233153AbiCOSIt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Mar 2022 14:08:49 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F9B659A6C;
        Tue, 15 Mar 2022 11:07:37 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 22FHveOf023635;
        Tue, 15 Mar 2022 18:07:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : message-id : references : date : in-reply-to : content-type :
 mime-version; s=corp-2021-07-09;
 bh=rh0OXGLEydgtBJLlrAblswCidGeDvkZzKXDI13FrWWc=;
 b=IIwWtBjf+xm7U/sHsJIGz7Xzu8KhHMy4A7lnbKCKWnZ6IWBDh9Cx6uJAOIK+zL8HdRIF
 7CSImXVamlas8QW6eLfQ+awD4YWI13dKtpHqLKus3oqNoywiguBqXWRmspugthWNEZVF
 XpRzUGCd8KQatgKd7kg6fL578LcFBr6Z19Qv0JPyiIOLWWfJ81PKCJbTeRE6x/eTb+we
 QfL63/NlEjWXljXq5XRiM0XcW/L4pXNzWbs91WEwT4Fz9yBzlW/VHKt8TraHrzHVz8rZ
 q1X2ByCMbUj0svMijPMlWnz2Iq6hfzr2BtiYjoEeA/q9Bcx6Tc1rmNcH2GX2gJN2GKDP 7g== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3et52pv1u5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 15 Mar 2022 18:07:33 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 22FI6PW6100827;
        Tue, 15 Mar 2022 18:07:32 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2171.outbound.protection.outlook.com [104.47.57.171])
        by aserp3020.oracle.com with ESMTP id 3et64k5pq2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 15 Mar 2022 18:07:32 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RboTCZlXOheLgzIFhkdiS5Jzpa9JjergNwgTUJcXx7/ypcqwE2dAbgJXiEAQqOmY4LJun3GjJSyTcYBP/tWmu994YVf21pDPBWmC/5bq/1Df0hF9x2iVkVYIgPaxGLwO83qhrNQGvFzP/UIls6PQdMGzodNC5HCnR5rr80f3aBd1geUGDbOjPykjfVufhZ/u1jM97UJqY3VM8nXbV3rcuML0T8JQmvEpr/8s4tVmpHuuXqIJI9ZHzm/1JSPdJRhs179/gni47hN45L5Ci6rUt0SUO6lzxmX7RIq26OzpijhbV9OwyTHO27uKoBdXvhrp4Gvk5e+vt65zjmoWE914GQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rh0OXGLEydgtBJLlrAblswCidGeDvkZzKXDI13FrWWc=;
 b=NxC0r0b/6LxBRcK1NBT+ccMFUa1IvTH9Oz6QJg33iKhViu5YxH/rFZNRebdeEazgTVmwY/oiq3kHz4G1R/t4cQNphEoSnPlYN4PZCUFP1T0DLCIwaAMlgpD2+FUCdTbtEu3iHAAmbnTL7wVyLMk6UykUCJo95ZA7k/SZRZYztGqaqI7N9sVVZyh07+ZB5iA33lyo+bUAtAhXLOtCZMrkblpBS+E3IQabLA5yMqh1OB8nL33Cfn4SE7ksK+pFPlstTtzHo8lEsgHBnjp760SHuQIc7Viz+dqCuBP8DpGDXjZIbICWMkApmSbWbx77mvX+0igQUpd2Oxi+80Jy0npEOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rh0OXGLEydgtBJLlrAblswCidGeDvkZzKXDI13FrWWc=;
 b=0T6B67OID1hLyYp9VKXJAyiUrw3/DDVN5A64R6BRPiir42NcAutia55qJPSs5O4NFbvxlrIXZNiOi4+4p7vEmZ8uHCamDCZqss7StS9l5rABxs4bkJzeUK6kUFEYMQs+FWd2sWMtXZ1ASeoYm4tXHGeiAqcZRnfckbuFpAcUdnQ=
Received: from PH0PR10MB4759.namprd10.prod.outlook.com (2603:10b6:510:3d::12)
 by CY4PR10MB1813.namprd10.prod.outlook.com (2603:10b6:903:11e::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5081.14; Tue, 15 Mar
 2022 18:07:31 +0000
Received: from PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::48e3:d153:6df4:fbed]) by PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::48e3:d153:6df4:fbed%4]) with mapi id 15.20.5061.029; Tue, 15 Mar 2022
 18:07:31 +0000
To:     Lukas Bulwahn <lukas.bulwahn@gmail.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] scsi: scsi_ioctl:drop needless assignment in sg_io()
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
Message-ID: <yq1czinay3s.fsf@ca-mkp.ca.oracle.com>
References: <20220315061520.30745-1-lukas.bulwahn@gmail.com>
Date:   Tue, 15 Mar 2022 14:07:28 -0400
In-Reply-To: <20220315061520.30745-1-lukas.bulwahn@gmail.com> (Lukas Bulwahn's
        message of "Tue, 15 Mar 2022 07:15:20 +0100")
Content-Type: text/plain
X-ClientProxiedBy: BYAPR11CA0059.namprd11.prod.outlook.com
 (2603:10b6:a03:80::36) To PH0PR10MB4759.namprd10.prod.outlook.com
 (2603:10b6:510:3d::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 57afc0f4-a172-4714-dd98-08da06aeac2a
X-MS-TrafficTypeDiagnostic: CY4PR10MB1813:EE_
X-Microsoft-Antispam-PRVS: <CY4PR10MB1813C1CFC08450207F2F84F28E109@CY4PR10MB1813.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TqqygIQaGvTjOtNMg3UukQiKb5GOZPxxuLnjtsxf0Fx6rJziJqjSOwQckYg5Uqvee67aHHqF8Z/gfWMGuM3CiZPd//h6MrPmQEdBqHvvagWXto5NWnSxSilFKgd4z2Ev0PZ1Alj6tmkzjGwn2SCttpvaPFrOmSinhV3/6qQSJOWWPIbtjGhxrntKoAzfJ9I0FHln6NdV/MQPidrtC0Mr0OHpZfQgRY07bhOCcvEmzAOHtVTi8PpqMfr5QsWi9IkhXIyZrtnaBHy/pmkOB+mcVobX6VQOxjF1vGTczr7HyuIwchCBUTmPmkEOXAV4oS5LEd4aQxLkLyb/1Qvlut/nm97Tcqvpv3RokALX1ICN56rPRqH4HRWXOB3fXfSUbSn8A1Kdl7f2Ltqf2J57+F8mMSPvqlUZ7+4acgvcr71cf4ixbP29mxldVP6NG9U7BvRcgh+8tuXoJIcxE2pjrC2jHWTqBt9vUO/nNuRmaQOZkQ1xs5qwm2tb6Hr6FSz/uiL63f52Foa4nozdPhehKlEZDsnxfseQJ7tfGoMD7HL7G0p/EGVGfiHkn3JdVTRGOGZO+AyY6pv2KjQTJjhA9sWdR6xNu4aAF6VrL4QsCerdMYpyHqFcTxRH/suGYN4M2nCBn+y9E3WRGrO6XB4OZ4IwKYDqwRvD97zvXB9mCKPoiQ4BphbNv/I/ERJ/DcjHvvETqtuIWf/Cs6E9Gd4YGG178w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB4759.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(6666004)(508600001)(66946007)(66476007)(8676002)(4326008)(66556008)(186003)(26005)(86362001)(5660300002)(38100700002)(36916002)(52116002)(6506007)(6486002)(8936002)(6916009)(6512007)(4744005)(2906002)(316002)(83380400001)(38350700002)(54906003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?dVLZUrwBws5fA3AFldF1+nMslExAITpNr/wWFU7PAFahTfKs6xti0n8+Pf6f?=
 =?us-ascii?Q?abfq963Yh+szBl9adD40h+hSZFMDR+UH2Yoa+Y/CI4YlcjeAuKyq7O1lkq6t?=
 =?us-ascii?Q?mWX3seqNkdQ5RS0fOEC1O8tpfuD+zDK8BJOeWsi0010liP7jFCan+kYC1Gxm?=
 =?us-ascii?Q?YuQzxpKSPelVe/IYwkuJbepYREI9t8pICAPt4edAePibqdM+gxqnMMjWgJ64?=
 =?us-ascii?Q?WqTA5FWUakHlz+iRCQAZ6u2I8Lwfb6It9ALMMlymv3ldpaKzU7KZ1IB8WNDD?=
 =?us-ascii?Q?8Z1Mh8y7nx3qqsNeK7i+tGpzus9MekTTYk+swYQb7OCOvGX90P0/cIKAUq2b?=
 =?us-ascii?Q?k0d6MfOiSx8bRNShsr70bHvQlGp/qK9Y4hIW3hgVhpa1UhCBB2mYuATrDcEa?=
 =?us-ascii?Q?MlwxDsd499n31HxtKdBGTv7uIYDY951WCwlN3mKldI8TkmtSW9xrPBN2aOBx?=
 =?us-ascii?Q?LYmfOFN+4nnRAmgMG0zlUmHq6w9gIqoq19cSJb1FxpdyXRfac8uLOTvteXjq?=
 =?us-ascii?Q?eiLKtvnIBTzys+8v/xegqc6Oqb55qVmIlQLwlCI60Nn+or1RS4p1j5h81Cm4?=
 =?us-ascii?Q?1Ch04Dv0HFIhKBdzPmhJiASv64VPe//OdQ88IrmLEWG1dqcpS1xfQYtBsdEI?=
 =?us-ascii?Q?m094ocoMkis33MAKCakorXjxEpf1ZrbDyFZhMvU5k/i93Tee3MPfI1ApB8LC?=
 =?us-ascii?Q?zexH1Pxhwd4KWyaigMXEmko2zvkvKo2SfBSpUy/d1W6cU4qCiC+PdlGtLaYl?=
 =?us-ascii?Q?wHu231zuy4mplPwZMLHcDwi27Yc7ZGSJ1ZlcW6Pm8dBtXF/XGO9FFjrKr3nM?=
 =?us-ascii?Q?2Rc43P2aY6PFaow5e/61nD33Tua3hY6hr7Rbf5pfRuuaJNE9rsdfLWHat5Nn?=
 =?us-ascii?Q?+1kxz3ETFHdqV3cXE5TRGg++ClXy/dZhUr246jQAtT9y1yA27hB64DVicYrk?=
 =?us-ascii?Q?zA3zVa5sG4X1Hn3+7Qf7LA+N7D0Qm4a5b/iGj2fnpPtb0QY6EZp2e2tqQ0lA?=
 =?us-ascii?Q?C1xx/BHMniTLU/r3lJxSsOBDJTOOt1ixY6MWV+CwdMf13nMErr2FaTrclrMI?=
 =?us-ascii?Q?n/5wKiL4UzS/HYDpgxiHJFjybsi4UpQtFQthuIK29MqbkIqqe4NNpa9LHQJd?=
 =?us-ascii?Q?WbcquyeEgaChLJ+dQqYWdZ0FeS6bFR1F4qs0o6r8kvmu/x938Yy5jgkwO5mO?=
 =?us-ascii?Q?8n9e38+SlKnDt7FZHnynUe3s2ygfx1kcGZU7zrtW6KWgmuZfvwayDyp4YpVd?=
 =?us-ascii?Q?uwO6YMsMbIXTXWis/UQyRL3saTJWRJ/ZLFzO0mc3AV+r6D8gwJU4Dnoytrl7?=
 =?us-ascii?Q?O2Z1ljN9LfjTmFzNnisEf1gOG8lXVTxoL8R2XX07AT9+PfH1TFy/42wj2REv?=
 =?us-ascii?Q?lJPKGfvbvVjzv2z63sB8joWp7Rf98+v09Ubgk0rrhxx+M6nAIy0tx2iexWzx?=
 =?us-ascii?Q?/vjOZe37WBsUpLxvg5ZDUsoD8AAKNqgJH5f7UomgME3CWJutcWZiJQ=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 57afc0f4-a172-4714-dd98-08da06aeac2a
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB4759.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Mar 2022 18:07:31.0006
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: U7+E4ykjnshfeVdMV+gFoCtErkzkbCUJPhts2wKyVXMHeRNckOeswHouiVmvJ2DJTz+ofJ349R0xVqd6LS2LpVPOm4eq2qHvlFlo9kBU/qU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR10MB1813
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10287 signatures=693139
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0
 malwarescore=0 mlxscore=0 suspectscore=0 spamscore=0 bulkscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2203150108
X-Proofpoint-GUID: Fuxt593wg2CfoVTh_OVQsKlwLvYtGtN2
X-Proofpoint-ORIG-GUID: Fuxt593wg2CfoVTh_OVQsKlwLvYtGtN2
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Lukas,

> Commit ce70fd9a551a ("scsi: core: Remove the cmd field from struct
> scsi_request") refactored sg_io(), so that it does not allocate
> directly and hence does not return -ENOMEM in its error case. That
> makes a remaining assignment of -ENOMEM to the return variable
> needless.

Applied to 5.18/scsi-staging, thanks!

-- 
Martin K. Petersen	Oracle Linux Engineering
