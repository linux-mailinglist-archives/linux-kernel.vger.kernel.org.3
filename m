Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0512850FB3A
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 12:43:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349174AbiDZKqq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 06:46:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349200AbiDZKqG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 06:46:06 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2084.outbound.protection.outlook.com [40.107.93.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A1ABC4;
        Tue, 26 Apr 2022 03:37:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nchbj9JQfZLLPIYPXNgDHJvcvuO7v1RBIrBCbjiuXwGnqScP4+zRjTJwvIq0Q1WQmeSPMnbYl18jMd/r37najWe0ZANTHEK3PrmL3v89SI+rP//g7oLU/i3cTg8/UMS0gu8/aHOIvDXKIWOSrpbExmBOijCuY9ZH5YWgMvA862ZSA8w4ikWuD9OSJ1Erb9qwZ9FDUqadL7hrDscUy9FYHV6xGrgVYD+0uzTUGA+CyBlo960GruI4unMke1j5voOE8+1TQkDplJXCXRFtpvdsjsgMNKYuQ3iK8JUlqQRwJHL3ZDMh2gcMhANbAck+jiB4BweUKx88UDZhUJB1RmF9xA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9CsADcSUQmWmNxpPOKbqKvgmZ6/h3HMjwpJZ/PybEvY=;
 b=Z7QVhUPiOwuWsgOaTSHx6IkjTqLftRaaDCDAIBfKEmdx3FKiHqMwtrLSLHPK032Zj8LBz83rGHdI1GjpiEyrO1LWjIKMSL+gNBDGyD+NUgUKXgML42/cuIKyB8zHl1m/py8RD5N81s+16Jm9iUIgLs0zQqdzjXRGshkzuc0lYxvNSc9gtKchGR1aolpk0ibq26XXHw0EAQk9MPG2RRYaNpxnj3m18/DXL5vE7Tlcnjp4aLgGJymXv8zy29msZj/v/8fjBHRSemiVXFxhDFr7pL1rp2Rnxzuza2G9W6NG1F2Xtpn9WtyUfTzkhy5zRciu86n89pi7TTerI4m+SNOaSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=infradead.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9CsADcSUQmWmNxpPOKbqKvgmZ6/h3HMjwpJZ/PybEvY=;
 b=pFT6kJsgC0tvpu35fDJ5AYlm3fdnPUVmVRsvOleFaSsGKGxwkmh2Xa2uixQcmEXVt3BYxJv/THpHa2P7TTSym9Yee9DsrZjymKjUM9z6tzYa3ENvmFMbxp/P+P3ibJNbiTugE5Zk2An8uecQjgoMv6RqdvHotns/9O8GwJZTUAM=
Received: from DM6PR13CA0029.namprd13.prod.outlook.com (2603:10b6:5:bc::42) by
 MN2PR12MB4992.namprd12.prod.outlook.com (2603:10b6:208:3c::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5186.15; Tue, 26 Apr 2022 10:37:15 +0000
Received: from DM6NAM11FT017.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:bc:cafe::7b) by DM6PR13CA0029.outlook.office365.com
 (2603:10b6:5:bc::42) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.6 via Frontend
 Transport; Tue, 26 Apr 2022 10:37:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT017.mail.protection.outlook.com (10.13.172.145) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5186.14 via Frontend Transport; Tue, 26 Apr 2022 10:37:14 +0000
Received: from rric.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Tue, 26 Apr
 2022 05:37:10 -0500
Date:   Tue, 26 Apr 2022 12:37:07 +0200
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
Subject: Re: [PATCH 4/6] perf/tool: Parse non-cpu pmu capabilities
Message-ID: <YmfLU/VMQI0g0Ck0@rric.localdomain>
References: <20220425044323.2830-1-ravi.bangoria@amd.com>
 <20220425044323.2830-5-ravi.bangoria@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20220425044323.2830-5-ravi.bangoria@amd.com>
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ce2a2b87-8a62-48a8-8713-08da2770baab
X-MS-TrafficTypeDiagnostic: MN2PR12MB4992:EE_
X-Microsoft-Antispam-PRVS: <MN2PR12MB4992C1CC86AFB32A388F6B1B9CFB9@MN2PR12MB4992.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2xqh61tHWwanEuPnHmIoQM9SGcNsGrhKk+EWge4K9RlbRWkWm80MKhkiqTJQy0pMv4F1Qo8DuTBOgeHT/HD46n8uLiWDDUoX/Vcq29wUYOi2G5BVy2U2D4jrmD5MCAyZiE3yXYtJXczunmlhq0Zm1MiwSIOhyrJ+vyngctAUrONOHBeM2WuSD9cuUwqQ+P1iOmNszoJM4jzTgJ8dBDf3E+jFLR4q3XvDYz5O2cV3TeKhs3SM5hBsnczFhSXMD+6Ec9Z09ZTShX2jdr1IGj2O0E3vp57a3usPE9skiMWOem+L/IBbFMjGoMG8fZi1chIqdkTwvDze7GeKIlsIsiDlPWpkaAbEysalRFOzYDosgOM7q8SmYIdwD/MCfQtUwfDy08xbYMoh8BfPRJEMxvbGEJn6zru81JQTQNr5yr1qtqa+z4usN7VrwL0fgxqWHnj6u96Tu6A9f+JQV+s+GKr3Aaow+iAGconcby/t6HP40PVFu2q01FqKCku1XwPLNK22PAThpM+sUHaKwuDvndq2haJ2gTzOzacRZ2drJeZkzeanaPPSrh1SC+4X2y2aee+FkVuYmxuTiurlb5PgTLw/1frgbyVdfnCuv4/Nz69cmCI+2M0ZESSGyNMdkBVJwfAQMiF1ENszUV6PGOUN54LkjItfl+DPC6hp5KeU/aaCbyckTd49ABaOwvfw9rfmzqIhPKiM3K5vv9Yka1Vg1BL09Q==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(36840700001)(40470700004)(46966006)(82310400005)(16526019)(70586007)(70206006)(8676002)(186003)(4326008)(426003)(5660300002)(336012)(26005)(6636002)(6666004)(9686003)(53546011)(316002)(7696005)(54906003)(81166007)(356005)(6862004)(47076005)(55016003)(2906002)(7416002)(36860700001)(4744005)(40460700003)(508600001)(8936002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Apr 2022 10:37:14.6876
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ce2a2b87-8a62-48a8-8713-08da2770baab
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT017.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4992
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25.04.22 10:13:21, Ravi Bangoria wrote:

> diff --git a/tools/perf/Documentation/perf.data-file-format.txt b/tools/perf/Documentation/perf.data-file-format.txt
> index f56d0e0fbff6..dea3acb36558 100644
> --- a/tools/perf/Documentation/perf.data-file-format.txt
> +++ b/tools/perf/Documentation/perf.data-file-format.txt
> @@ -435,6 +435,24 @@ struct {
>  	} [nr_pmu];
>  };
>  
> +	HEADER_PMU_CAPS = 32,
> +
> +	List of pmu capabilities (except cpu pmu which is already
> +	covered by HEADER_CPU_PMU_CAPS)
> +
> +struct {
> +	u32 nr_pmus;
> +	struct {
> +		u8 core_type;	/* For hybrid topology */
> +		char pmu_name[];
> +		u16 nr_caps;
> +		struct {
> +			char name[];
> +			char value[];
> +		} [nr_caps];
> +	} [nr_pmus];
> +};
> +

This looks quite a bit complex and special.

Why not just reusing struct nr_cpu_pmu_caps (id 28)? Rename it and
introduce macros for backwards compatability if needed.

pmu_name is already encoded in sysfs and core_type could be a caps
value?

-Robert
