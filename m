Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34B0150FBF5
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 13:28:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243305AbiDZLbL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 07:31:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232244AbiDZLbI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 07:31:08 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2070.outbound.protection.outlook.com [40.107.220.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDCE6178586;
        Tue, 26 Apr 2022 04:28:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PyXnxMIFbY2c2F2rqaev4WreGGxdJVbMI7k4I8BEs0EvrtctZFWHbEKYDKRKpnxs6Te4qOx1n00GaAy1vmYL1UK4qIikQt1kG3Qin0S0H9uUsAMq69oOMUWfX5bHuWCgW2KgGcHUv0ob95SVSmUjBzGVopYlQuPv0x+K13/D2rmjdEfILPSICnVKcLcZXM0a3vj27RxBbF5ZdDEY32Te4NPoM8YZM72XqWnpW7zD6l/GQp4arP3NbaFNuV/EqKTlXJHSRP2OarCcxvmyW0DqB4j9M8yqWcWBTadsMgTI/InocdDn7+6JCyqholvzq/Uivq2FDNUKc4Re+qAtWdae6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uAET7Dg37TkZ/zmaYsWk7N1vya0XY0r5ynIPcqLITYA=;
 b=JFg2T6jKnN75J+KBo/2xEAUOlHpWE9CYxmQ34f9SbzDRYHmeWVx8Pbqe0eTcW2yFkJbTXp79ItiJebrPngT5gNBlsH5280XOXfbpqLeNvKP2G02yMRXyBYPQf/XqgAUuOLUzhQp8ezXE1HeTQJ/KPi9KZboMN9/i1wMPsOzGEFJqcp/ME5mqzFGg+LLzSFj5SkziEg4c9SNrnfukdN2mk9R873GYH+wFZJo1PambZiRwg/UXqgEBr25W+7nxaw52EG8Re1ojGi7e15setKbpQuJurzAyU1/45SJBnbsKae1DQLzSHChdiLareJYs+LYuelRgpHfwV27Eojf0ezgWGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=infradead.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uAET7Dg37TkZ/zmaYsWk7N1vya0XY0r5ynIPcqLITYA=;
 b=LsIeuPUhcTubI3nv59a2vDAPWjd77yjn3xlz3rCHtSDV/U5stWIJ0e/VwbU41CtefhtyD8JsHwzMK3XBOQo4QZ+SSOSpNbgpYuw0pCQxKkHB1vSi5lgzQibewjPYnQtmGUbZcek+JQZacr0Rv0bDz0m8WT6o7ND0Pd+1LiKTbXI=
Received: from MW4PR04CA0312.namprd04.prod.outlook.com (2603:10b6:303:82::17)
 by DM6PR12MB2825.namprd12.prod.outlook.com (2603:10b6:5:75::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.20; Tue, 26 Apr
 2022 11:27:58 +0000
Received: from CO1NAM11FT059.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:82:cafe::5b) by MW4PR04CA0312.outlook.office365.com
 (2603:10b6:303:82::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.13 via Frontend
 Transport; Tue, 26 Apr 2022 11:27:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT059.mail.protection.outlook.com (10.13.174.160) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5186.14 via Frontend Transport; Tue, 26 Apr 2022 11:27:57 +0000
Received: from rric.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Tue, 26 Apr
 2022 06:27:54 -0500
Date:   Tue, 26 Apr 2022 13:27:51 +0200
From:   Robert Richter <rrichter@amd.com>
To:     Ravi Bangoria <ravi.bangoria@amd.com>
CC:     <peterz@infradead.org>, <acme@kernel.org>, <mingo@redhat.com>,
        <mark.rutland@arm.com>, <jolsa@kernel.org>, <namhyung@kernel.org>,
        <tglx@linutronix.de>, <bp@alien8.de>, <irogers@google.com>,
        <yao.jin@linux.intel.com>, <james.clark@arm.com>,
        <leo.yan@linaro.org>, <kan.liang@linux.intel.com>,
        <ak@linux.intel.com>, <eranian@google.com>,
        <like.xu.linux@gmail.com>, <x86@kernel.org>,
        <linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <sandipan.das@amd.com>, <ananth.narayan@amd.com>,
        <kim.phillips@amd.com>, <santosh.shukla@amd.com>
Subject: Re: [PATCH 6/6] perf/tool/amd/ibs: Fix comment
Message-ID: <YmfXN3mi5eGdMHqM@rric.localdomain>
References: <20220425044323.2830-1-ravi.bangoria@amd.com>
 <20220425044323.2830-7-ravi.bangoria@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20220425044323.2830-7-ravi.bangoria@amd.com>
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 228fbd6c-47d1-452d-fe31-08da2777d09b
X-MS-TrafficTypeDiagnostic: DM6PR12MB2825:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB282554F8939330C50D5C8D6B9CFB9@DM6PR12MB2825.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HsB0QXkq73wJPtCIK9aliM7okRwL1E86L3IsNmItnMx09cvQeXPiUnizhjXuIbULOM0CbMDVqTRu9MTMIZJJOuh1f8t67W+4JYuYl32ZwIReX55p7yfzli2NOotoA7Vw61J2AgVCqIsWSHkx+5+mYXCzjU3M3SRqshkMIok6uZP8H985CQCUsowgFKt8+mH3Tu5cXTwXwVtAVEm4rQEz2AiM6VrzUQmGbspHq6FFKRUiSOIRuGwePq8Vgr/ptwSOSLRSn2GbRULdFvRBpwBJH7VqwelPNuU6eV+/0ewCrrVELcejSVW+eMZssg4P0AT/rY+mPGUb/ppdQDqqxMwvPCsrwdN1dLJi54m0fxIj5twyBp9z+XTkUEfGAbdUuR6xIlf22joSlJzKBL8aE6Dt7MfgxToUewhno0eWsQBa19cB4frc2l4JEQdmDZMOlSMu43219LPQvZgqiTuIkCVAXQf43svsPnkkj3LMSg6aqTHSQmg+PrxYodEdeLF/mEHq/y7NSLLu8UwGGLMrxZTHSoIx2g37x5YjPq5amwsTe4btmLy79naiPPhZx48l3SRkcuOPR2WzM7OMwk2IBCLZy7DnIkhPiyX3QfPRIWQn/54o1aQ6pYEZiwCWj4IqsO7blhiiNY4pn60nIwe15uJujKUOtQywv0p2hIcNWnfuIqwgz3FM0n3cdKVSFmnG90MTrPvgYYANJlX1OzHWTXPPSg==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(46966006)(36840700001)(40470700004)(81166007)(54906003)(356005)(6862004)(47076005)(40460700003)(8936002)(508600001)(2906002)(7416002)(55016003)(36860700001)(5660300002)(4326008)(336012)(8676002)(186003)(426003)(70586007)(70206006)(16526019)(82310400005)(558084003)(26005)(6636002)(6666004)(7696005)(316002)(53546011)(9686003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Apr 2022 11:27:57.8790
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 228fbd6c-47d1-452d-fe31-08da2777d09b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT059.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2825
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25.04.22 10:13:23, Ravi Bangoria wrote:
> s/IBS Op Data 2/IBS Op Data 1/ for MSR 0xc0011035.
> 
> Signed-off-by: Ravi Bangoria <ravi.bangoria@amd.com>

Looks good.

-Robert
