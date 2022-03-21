Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B533B4E2801
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Mar 2022 14:45:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348079AbiCUNrS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Mar 2022 09:47:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243433AbiCUNrP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 09:47:15 -0400
Received: from mx0b-000eb902.pphosted.com (mx0b-000eb902.pphosted.com [205.220.177.212])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DE749548A;
        Mon, 21 Mar 2022 06:45:49 -0700 (PDT)
Received: from pps.filterd (m0220297.ppops.net [127.0.0.1])
        by mx0a-000eb902.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 22L4KRQ7008210;
        Mon, 21 Mar 2022 08:45:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garmin.com; h=message-id : date :
 mime-version : subject : from : to : cc : references : in-reply-to :
 content-type : content-transfer-encoding; s=pps1;
 bh=95z+FGk7D1+nwOQMHmasgA6GEnLT2eUOR+PVNQrEkJU=;
 b=dp61NaOvpuLYAxP+sLrSO2LPrCnzrCtfJVO2D9bQ1/C4c1CBqJrea8MqCzi9rWPkm23D
 XeQZQM2/XLHFSAynZp9vnd5zb4xOk0kTYxRuetYhJWuaUk+++tAB1xj0qYQ2zXCJ8AHk
 gDoetiinvPx86WXkQpOZXRjdesoinbV8R6QHIxt7XzYl4wrEZXk+GniXS2tMxJKZgt7U
 2L9q2b4tPiqdY9WtF27JAX25U5AXiy0MNVooMM37O1BDA500TTin8L8Ohb9kp09L3H8l
 MrKoJIXybFoJWqNgh4gdv5MltUuc/0CTj/Sqo6fOKgd9lP3mweoYAQ8+f8QBj8hNmCRO TA== 
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2170.outbound.protection.outlook.com [104.47.59.170])
        by mx0a-000eb902.pphosted.com (PPS) with ESMTPS id 3ew9cdk2ua-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 21 Mar 2022 08:45:48 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VQY+Bb4wo0PtUUT3Rs9KDaE8T1TeTSmGg808Z9+RO0IPvZhVbY+HyjThOsqYho7grKLkMhaRCm+4IxbRMnvOAK3iIMYhDPpG2zd+Re66etBM0lmufYmcExDaLiVZ0b5/dZVKseYj1bLWIymaABkLu9HxxkV/4L7B8tGwnzV9LlheMFifwg+bTI6Hl8p1RVXWQv47qJJdbBvfGPN7PS5SW7xjilLyozOhzkD10GGUfWroJl5r9uuOu8vlFJvJQrxxjOXbMTz6f+5DZb6bgeJ/g+cbxtndATcHm7TnRsvpAMxXltq1eo9YFmnVB/JjCTNi3NNmiuVAL1yEB6HGF7/OjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=95z+FGk7D1+nwOQMHmasgA6GEnLT2eUOR+PVNQrEkJU=;
 b=UtxriuHOvgPp5X2t1lrha+++EbzFk0B4yk+5IYYNaUZPFM/d1OMOPCI4bInQb1GZVPSIx4t7jG/r8os5q/Na1Qg00wwS6NFa+E3xdyJEMzFolFZRlyoS/0z5KpwI1OIN/fYvIU6Wjpp4QiZfrJ6Q1+malt4yfpClhI65oJyzZa2QKwAoH2xN/ySt3ca1xoZnBSCf1xG5m0iwNt19u3Os0OQA4Es53PLzuAzIgjGWTrkoPYW729LoETayLJaKggMoJEG5JLoS77ceD9JW0Hk/iB5pw0d7S9iJFMFeQp+3Zt/XLaAe8cWvizeM+Io6b4sw9p0fX/ZDNphA0V/vpyoC9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 204.77.163.244) smtp.rcpttodomain=gmail.com smtp.mailfrom=garmin.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=garmin.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garmin.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=95z+FGk7D1+nwOQMHmasgA6GEnLT2eUOR+PVNQrEkJU=;
 b=QqNmxThKjKoUYiXxiKWKuAm/hzR3gijK4icX7sXv/o4YdZwMEWhiSRrGmNAUn+VVM4Sk6+gsz9nG4YiQ+BfOBoRHn87hjmBcqO9czAfKr8S+wfKyHAwb1WuHrP1PGNIjiGVwrLmFWbh3+6QEHQDXAB0SLUimLSRz0MwMiRFbY1PBjAxykt72fuSB0s8G81e5D2hm4xYqbX5X7hh9pXI/rLUBw7BJJ/0BXIDY/pjIEh2u78aSFnrwGtHEXh5DFAUZ1dyfxgaweatY0q/UDw5vfr/kwwinmBBlMWfMhK4Tbi48ARqWolhC1jHl0/WfM8ZCWuqAZRo86aqSytdK5r1djA==
Received: from BN6PR13CA0051.namprd13.prod.outlook.com (2603:10b6:404:11::13)
 by CH2PR04MB6678.namprd04.prod.outlook.com (2603:10b6:610:a1::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5081.16; Mon, 21 Mar
 2022 13:45:45 +0000
Received: from BN7NAM10FT046.eop-nam10.prod.protection.outlook.com
 (2603:10b6:404:11:cafe::1a) by BN6PR13CA0051.outlook.office365.com
 (2603:10b6:404:11::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.16 via Frontend
 Transport; Mon, 21 Mar 2022 13:45:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 204.77.163.244)
 smtp.mailfrom=garmin.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=garmin.com;
Received-SPF: Pass (protection.outlook.com: domain of garmin.com designates
 204.77.163.244 as permitted sender) receiver=protection.outlook.com;
 client-ip=204.77.163.244; helo=edgetransport.garmin.com;
Received: from edgetransport.garmin.com (204.77.163.244) by
 BN7NAM10FT046.mail.protection.outlook.com (10.13.156.122) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5081.15 via Frontend Transport; Mon, 21 Mar 2022 13:45:44 +0000
Received: from OLAWPA-EXMB12.ad.garmin.com (10.5.144.16) by
 olawpa-edge4.garmin.com (10.60.4.228) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Mon, 21 Mar 2022 08:45:41 -0500
Received: from [10.30.196.25] (10.5.209.17) by OLAWPA-EXMB12.ad.garmin.com
 (10.5.144.16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.2375.24; Mon, 21 Mar
 2022 08:45:43 -0500
Message-ID: <754bd2ad-59ef-a850-92e4-35c00c4d6c98@garmin.com>
Date:   Mon, 21 Mar 2022 08:45:36 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH v2] input: Add Marine Navigation Keycodes
Content-Language: en-US
From:   Shelby Heffron <Shelby.Heffron@garmin.com>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
CC:     <linux-input@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20210622235708.8828-1-matthew.stephenson2@garmin.com>
 <20220126211224.28590-1-Shelby.Heffron@garmin.com>
 <Yg9EmVAHpEpmnLok@google.com>
 <20556881-1d16-4718-f28c-4a32946d2ecb@garmin.com>
In-Reply-To: <20556881-1d16-4718-f28c-4a32946d2ecb@garmin.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: OLAWPA-EXMB3.ad.garmin.com (10.5.144.15) To
 OLAWPA-EXMB12.ad.garmin.com (10.5.144.16)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 22cd81bb-c60b-48eb-ce38-08da0b4118f5
X-MS-TrafficTypeDiagnostic: CH2PR04MB6678:EE_
X-Microsoft-Antispam-PRVS: <CH2PR04MB6678F501E264FC46F3D5D989F2169@CH2PR04MB6678.namprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cHCeLCLuNYGYpIEjqoDquBXEvK7AtDPwMeheAiTYPJ6iuw3/AL0R7JjeJF5F0YtyP/CkjPDSkXphW97FH7VetBHqVvsEsouQR0zqp4uizscXhjReEgCc4tZJvGEcyhUGCESVWPpnb5HIH4NkuvE0YbPHlTAWByNsWUJEND1msxEjwfq4csorVT5Kea7LsCAICgBvUAZcRX6jIS5LDQvyzaiShfnRNI+tpYSAKJLo8JxJkH6lSXBCinnIGec/TQ/v8YIhXvZbwLLewe2y10Ze0bJC96ByaX4YFFfhc8VXmMr0QHjIWoAvYIeECOrG29U2y5nrXEjfXuRo5ST54sTRhFFBg3y8d6QZ9dlO2RIWDBOq/sCOji8TlcHDEOXtY19CdBEN96SoFEWeQoI84uEkVzjyX7kUB4CKSfTTybFsXJs2SHyOqTNQVkw+VvkQ6RZyfz3EU7Fa8qOG8jWr9NoREaNs+4VdmvB85+dKO34VJfOrsATPI4Rxw3BPcNoff34Wx3LgrM9qX/nqFGNISsrWyK+iQYoXrD/9nwyE18cXzxLSdqM34vji54ygqt+bQJ3okS4um5Rumbc5H3bkf28FQauCE8Aq1DYv4YLJIzlVl1GvEJu1t/5wxcDAApB+cdW1Mm0zsBv3q0ie05WUfM+7Zd1iHlNuyhRtcib/bPKnh0jzkJshyy9TcdZn79GS/Rm/dqonz/BBWHRRQoLvniYf+A==
X-Forefront-Antispam-Report: CIP:204.77.163.244;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:edgetransport.garmin.com;PTR:extedge.garmin.com;CAT:NONE;SFS:(13230001)(46966006)(36840700001)(40470700004)(54906003)(316002)(16576012)(6916009)(36860700001)(70586007)(4326008)(8676002)(426003)(70206006)(82310400004)(508600001)(2616005)(336012)(186003)(26005)(83380400001)(40460700003)(31686004)(47076005)(6666004)(5660300002)(36756003)(4744005)(8936002)(356005)(7636003)(31696002)(86362001)(2906002)(43740500002);DIR:OUT;SFP:1102;
X-OriginatorOrg: garmin.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Mar 2022 13:45:44.4794
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 22cd81bb-c60b-48eb-ce38-08da0b4118f5
X-MS-Exchange-CrossTenant-Id: 38d0d425-ba52-4c0a-a03e-2a65c8e82e2d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=38d0d425-ba52-4c0a-a03e-2a65c8e82e2d;Ip=[204.77.163.244];Helo=[edgetransport.garmin.com]
X-MS-Exchange-CrossTenant-AuthSource: BN7NAM10FT046.eop-nam10.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR04MB6678
X-Proofpoint-GUID: lhQVuLmexhTeOQ2gudnQK02bUvDptC_L
X-Proofpoint-ORIG-GUID: lhQVuLmexhTeOQ2gudnQK02bUvDptC_L
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.850,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-03-21_06,2022-03-21_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 mlxscore=0
 adultscore=0 spamscore=0 priorityscore=1501 suspectscore=0 malwarescore=0
 bulkscore=0 lowpriorityscore=0 impostorscore=0 phishscore=0
 mlxlogscore=826 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2203210088
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Dmitry,

Please let me know if you have any further suggestions for this patch
after the more detailed description of our system.

Thank you.

________________________________

CONFIDENTIALITY NOTICE: This email and any attachments are for the sole use=
 of the intended recipient(s) and contain information that may be Garmin co=
nfidential and/or Garmin legally privileged. If you have received this emai=
l in error, please notify the sender by reply email and delete the message.=
 Any disclosure, copying, distribution or use of this communication (includ=
ing attachments) by someone other than the intended recipient is prohibited=
. Thank you.
