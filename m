Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 117064EA62A
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Mar 2022 05:40:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231842AbiC2DmP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Mar 2022 23:42:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230284AbiC2DmM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Mar 2022 23:42:12 -0400
Received: from mx0a-000eb902.pphosted.com (mx0a-000eb902.pphosted.com [205.220.165.212])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68844692AA;
        Mon, 28 Mar 2022 20:40:30 -0700 (PDT)
Received: from pps.filterd (m0220296.ppops.net [127.0.0.1])
        by mx0a-000eb902.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 22T2hnWc016113;
        Mon, 28 Mar 2022 22:40:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garmin.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pps1;
 bh=VjoPx5LTKAMGV5nyWuXtTjAE239uDy2ltNla0qwtaic=;
 b=DvANNHNMimFydYGP7po5XsILsIVshvffTCvREOW+ulp090ohCGpe9Sghh50FubOSr13v
 0t06OwwROe9bzuvHMLakYn06CR2DdhSlSmRUG8i1EOqdAxOkp2SXh8yB03f918peSJwS
 jliiCd/GbQBSkZR8zZp935ENLQ8jw5K+aWg4sFusEXTmLs8PAE1qVxZ3L4mtO+8QbMkg
 JbeFiihvsyYx10N0TsphGyRZ5ZPH1fDbB/i8TM8Dxnnw3dcjSYqowSdEe4kanDC22WUc
 qmg/XuyuotP+OPtF2ybyhWUonr8aHcRDQPC8fdY4SuIqqvSANax8yK8r1CYoSZoY+khC 8A== 
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2170.outbound.protection.outlook.com [104.47.59.170])
        by mx0a-000eb902.pphosted.com (PPS) with ESMTPS id 3f2075m3vf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 28 Mar 2022 22:40:29 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZkWL2vCcYeGgDB0Xz/He4G5rHJh0paGhLy3hozvGhjzTXQSZtWXUPJ4sLKbkgyH8TVv4Z+HgZRsbobBxHWAlyQNT65G79e80WQYnYvB03xZkY4GESN+VqgI1LQ0v5pjiyIXVem6beKTVuShKRXYfuG6ngi+Xi0yEqramFbNkLojoYF9DLbZdrpF0ARax1sz1KWFQ2AEToNGmJ/Lk97JVfBS+L6pSTiQ06FloX2zJGFUJ7slLGv9cS4BRLhDLA0YU3wXcJNqmFf6BEqXMXXE0m2uLFHcMLunNPjJs03PPd+7IHl4vWWtIzMiWTJxYio5HDOq1pyuGZ4nciwTvyS98CA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VjoPx5LTKAMGV5nyWuXtTjAE239uDy2ltNla0qwtaic=;
 b=EOfAwXC3qFgZZWjSCoSigueI4UqKSLItIBynyifbY8dXFjk7SPsWnynfugyt2cMJPPJcHaytfmsBvhfOtO/OJgKe0HdpK/iCQ0EaQ0+M07Z+/EYup7fl0cZVLqZXQ6AbEbARez/+J2RG+AvSQKaqf2GkTUWmpXUjCIZ2zTuKb+KasdRarH4EJhtfUW4k69j2hgJGOlNdP3lArq9Hz4JPOlwuEQ4AupK0c4W1iWM01oSogxH5ToziCWKMZzvQgFRfG9jSLijlFIu6w5O+Kj/6JwCGmJudOwYghD1qzgi0ADOxW1ZnqilZhOHvm7LDdTHcei5LmwG5mkW1rBZT2fhDUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=temperror (sender ip
 is 204.77.163.244) smtp.rcpttodomain=gmail.com smtp.mailfrom=garmin.com;
 dmarc=temperror action=none header.from=garmin.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garmin.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VjoPx5LTKAMGV5nyWuXtTjAE239uDy2ltNla0qwtaic=;
 b=THGp2CiNjzLxCm63T5ZVGkyi5irQ4CaY3KnRwiXeDpfKBkerMBAagrscl1NwqyauvCZ1Cmud061otTguwJ1SwCou+7ScUkGQajpitVJiHk2qHOXIlh179aka0xbkQJ1seTzMdz5xhZdmklhEQW6H/ZzNzcoPXAmRXxSDKzA1V0wQTWMI86XZbO5q4VwgLmPn7T+repDrVxZohzvdo8LS6Nb+RR+bd/GHR9pnT/hPy2ZBP9yyjaVQgcJMzRVPcrYQwv1P9mesdkuubgajgbw4hlwsBUkPR1Wwq6eWFEHLJ+ew0DYgknVqoEHW1b0nVfxMMEtZq/eK2fboMl1whICVJQ==
Received: from BN6PR16CA0042.namprd16.prod.outlook.com (2603:10b6:405:14::28)
 by DM5PR04MB1245.namprd04.prod.outlook.com (2603:10b6:4:42::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.18; Tue, 29 Mar
 2022 03:40:25 +0000
Received: from BN7NAM10FT047.eop-nam10.prod.protection.outlook.com
 (2603:10b6:405:14:cafe::52) by BN6PR16CA0042.outlook.office365.com
 (2603:10b6:405:14::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.18 via Frontend
 Transport; Tue, 29 Mar 2022 03:40:25 +0000
X-MS-Exchange-Authentication-Results: spf=temperror (sender IP is
 204.77.163.244) smtp.mailfrom=garmin.com; dkim=none (message not signed)
 header.d=none;dmarc=temperror action=none header.from=garmin.com;
Received-SPF: TempError (protection.outlook.com: error in processing during
 lookup of garmin.com: DNS Timeout)
Received: from edgetransport.garmin.com (204.77.163.244) by
 BN7NAM10FT047.mail.protection.outlook.com (10.13.156.126) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5102.18 via Frontend Transport; Tue, 29 Mar 2022 03:40:24 +0000
Received: from OLAWPA-EXMB12.ad.garmin.com (10.5.144.16) by
 olawpa-edge5.garmin.com (10.60.4.229) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Mon, 28 Mar 2022 22:40:16 -0500
Received: from [10.30.196.25] (10.5.209.17) by OLAWPA-EXMB12.ad.garmin.com
 (10.5.144.16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Mon, 28 Mar
 2022 22:40:23 -0500
Message-ID: <531dfd9a-267e-dce0-0aed-cda8ccdf7853@garmin.com>
Date:   Mon, 28 Mar 2022 22:40:16 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH v2] input: Add Marine Navigation Keycodes
Content-Language: en-US
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
CC:     <linux-input@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20210622235708.8828-1-matthew.stephenson2@garmin.com>
 <20220126211224.28590-1-Shelby.Heffron@garmin.com>
 <Yg9EmVAHpEpmnLok@google.com>
From:   Shelby Heffron <Shelby.Heffron@garmin.com>
In-Reply-To: <Yg9EmVAHpEpmnLok@google.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: OLAWPA-EXMB1.ad.garmin.com (10.5.144.23) To
 OLAWPA-EXMB12.ad.garmin.com (10.5.144.16)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 55acdc06-dc9e-422f-6cac-08da1135db9e
X-MS-TrafficTypeDiagnostic: DM5PR04MB1245:EE_
X-Microsoft-Antispam-PRVS: <DM5PR04MB12455756DF40B5468FB03BE3F21E9@DM5PR04MB1245.namprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /kxHFv4RFfdxS5YBZt3DsGjz5BGyDuFY501DKNz7v+790wRsSKYVSgRQc0IkjEaExQHb8JYWKJ5pP1pSgynWifXuaJwt5Rsz+fZt0NNC/N8U3XOf+iv5sJ9P/2zAm7NmbX0VYs53hUjnw5Kby9nWG3EKXo7Wt0hHlPLv1AAY7EaUSRh0mKCyOLhEa8rtBC0gTkL4HpN7Lt+Rtx4cTJGvMxZSJimNjbT84IaZLq4DJwd8sjrfTi+cn6Q19jN4kwnFjJaaeDnmo3V0/aKmz0+z6Y3VDtXacukuoHOfwdLbZcVF2hKixXSuE3MxGrlZZItyJOUqNH5q+ZVucU17WDyvk4DAu7o8C3GdJCYRBQF+5taW3Djz6bdusTvY87JayWejkS0M5D+eaxQu7ezbyLaKr8OhDpfDhqNy06Cd08l446YOZDp1lQDQ9ge+mOx3PIS4vqI6jhru5baIp47d04cUJuEtBh/wPOeyhKO7upfXxCraajLKVUF1hoDss0hedb2wOzVDuhTJWYerEG2CPLqDO31d1WtIqC1V6C8M0c/xZY73JlWwx67J2RjvCVvFwHNt4HO5Z08bNnHeA3X14KHnYHpI4x0LB7b0lxvyrsxyumOdW2mzNB9DHtqRibBLUGlJN/oWWECgHGe3Ox/z6JzyDzCv4vA03IZv9iVWOvVawH1/Mb5bSI9QRAEbJQJ9kTH2liI/ieAVLjbcFx1FRHkkfg==
X-Forefront-Antispam-Report: CIP:204.77.163.244;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:edgetransport.garmin.com;PTR:extedge.garmin.com;CAT:NONE;SFS:(13230001)(46966006)(36840700001)(40470700004)(31696002)(316002)(86362001)(8676002)(6916009)(47076005)(7636003)(70586007)(82310400004)(54906003)(16576012)(356005)(40460700003)(70206006)(4326008)(5660300002)(336012)(26005)(36860700001)(63370400001)(63350400001)(2906002)(186003)(6666004)(4744005)(83380400001)(426003)(2616005)(508600001)(31686004)(36756003)(8936002)(43740500002);DIR:OUT;SFP:1102;
X-OriginatorOrg: garmin.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Mar 2022 03:40:24.0784
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 55acdc06-dc9e-422f-6cac-08da1135db9e
X-MS-Exchange-CrossTenant-Id: 38d0d425-ba52-4c0a-a03e-2a65c8e82e2d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=38d0d425-ba52-4c0a-a03e-2a65c8e82e2d;Ip=[204.77.163.244];Helo=[edgetransport.garmin.com]
X-MS-Exchange-CrossTenant-AuthSource: BN7NAM10FT047.eop-nam10.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR04MB1245
X-Proofpoint-ORIG-GUID: FMcisUfcmaBXghi1ZPs9xt3PqSUw4p7v
X-Proofpoint-GUID: FMcisUfcmaBXghi1ZPs9xt3PqSUw4p7v
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.850,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-03-29_01,2022-03-28_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011
 lowpriorityscore=0 adultscore=0 priorityscore=1501 phishscore=0
 spamscore=0 mlxlogscore=786 bulkscore=0 suspectscore=0 impostorscore=0
 mlxscore=0 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2203290021
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dmitry,

Please let me know if you think that any additional changes are needed
on this patch.

Thank you.

________________________________

CONFIDENTIALITY NOTICE: This email and any attachments are for the sole use=
 of the intended recipient(s) and contain information that may be Garmin co=
nfidential and/or Garmin legally privileged. If you have received this emai=
l in error, please notify the sender by reply email and delete the message.=
 Any disclosure, copying, distribution or use of this communication (includ=
ing attachments) by someone other than the intended recipient is prohibited=
. Thank you.
