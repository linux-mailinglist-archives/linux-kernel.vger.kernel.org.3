Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EEAFE495999
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jan 2022 06:52:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378569AbiAUFwN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jan 2022 00:52:13 -0500
Received: from mail-mw2nam10on2089.outbound.protection.outlook.com ([40.107.94.89]:17888
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230443AbiAUFwL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jan 2022 00:52:11 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e7lm45TxN2b63w544MCu5G7qUsIB1MwNjOZj6dydSdmBOiZ2mXBN3sKsreeJazjk9x2CdmOmfNIpjRe0xnQwUbihhx4vbF+r5e6ZttkMTtuCzkonmFPNu4E3+C7LQIlNRLgo2OjykeykDea6h9kZ7Alzy8wx/TqjNHhCHX61lV9c/XPBcKfjcke9tR2GjST4R00vAKU3hNmbZhpvvGHqtmXRuXk1TjKw6a7Xj9I5KewLq9A/njpRCV3KgAcTARxkJQ+nhKQkaLNqg1GwDIiZAZB0/PO/wX575JtJ6j0AMSFNarnQNi9mOTgyXOAQ6gknr0AzH/FPi2UjMK6/zpnZQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hfnLFNvK1K1yHR7JWcv3hhOn1ppHAYeVdfSF7iY4+7w=;
 b=ZRlMi0fAxhAsG4XeFbiXJdNfqzCS1uU/8tiwXEAXqiV7kQ+GAubNtoMPoTs3dHzYWOaTsZQpP/azVWT6UD4F2AMLxLtquhiwgi5LAF/q0se1Gyk2YI9JVJagHjVwirKO6veHcSm+q//aHVk7QXXCT77jsvsMhIdaPhV75kJO4Qa5qMJk2Mr+IAMUQpg864fo00NGpdcSpdQJ5buURjlvpgHy+2BzFANmCuIiDVXcynkLzBMD5OSYXMvMgpEvcTEmiL4qnIgsF+IcIxtQxCee/GT1COeR5dHL2+iKQlIsw5VE7L6EU0AATgN3Z8lpJOehexy5Hds6qvSb4v6ZDC7bPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.235) smtp.rcpttodomain=canonical.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hfnLFNvK1K1yHR7JWcv3hhOn1ppHAYeVdfSF7iY4+7w=;
 b=aSGR+8FbfnzWLVUUanQ07hvVtIx64Z3U9e9DDSj1H0l/4r1U4BKE/WoPJ4NplFJNgO//wA89zf0Igw/fSbKUmoHIDxLKy3eSYY009bdA4XcuIifwL3tunnS2jA6nhB1FpW/8JO3XaBJh2KemBuxa4lzvpMciSPYbv7SxiVsfeW0PabZBNwMxszjR7HctpssoXteZ86eHiBf8/tJ/gGHN1C866oojiQHCfvaB7ZMJISefPmoIobHz3R/98417t580jFV3KOlNEJDYEaO13/+fIQxp9ItHus3VknEoVbkrF6kt0lMLo5UOn0uENcmO4xcvI3W9qoxKrBzfxm/qsb9dDg==
Received: from CO2PR18CA0058.namprd18.prod.outlook.com (2603:10b6:104:2::26)
 by DM5PR12MB1945.namprd12.prod.outlook.com (2603:10b6:3:10f::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.12; Fri, 21 Jan
 2022 05:52:08 +0000
Received: from CO1NAM11FT035.eop-nam11.prod.protection.outlook.com
 (2603:10b6:104:2:cafe::bf) by CO2PR18CA0058.outlook.office365.com
 (2603:10b6:104:2::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.12 via Frontend
 Transport; Fri, 21 Jan 2022 05:52:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.235)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.235 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.235; helo=mail.nvidia.com;
Received: from mail.nvidia.com (12.22.5.235) by
 CO1NAM11FT035.mail.protection.outlook.com (10.13.175.36) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4909.7 via Frontend Transport; Fri, 21 Jan 2022 05:52:07 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by DRHQMAIL107.nvidia.com
 (10.27.9.16) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Fri, 21 Jan
 2022 05:52:06 +0000
Received: from [10.40.163.9] (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.986.9; Thu, 20 Jan 2022
 21:52:03 -0800
Message-ID: <d679cd46-d74b-46e2-bfbe-d54b56e39a7b@nvidia.com>
Date:   Fri, 21 Jan 2022 11:21:57 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [Patch V2] memory: tegra: Add MC error logging on tegra186 onward
Content-Language: en-US
To:     Dmitry Osipenko <digetx@gmail.com>, <thierry.reding@gmail.com>,
        <jonathanh@nvidia.com>, <linux-tegra@vger.kernel.org>,
        <krzysztof.kozlowski@canonical.com>, <linux-kernel@vger.kernel.org>
CC:     <Snikam@nvidia.com>, <vdumpa@nvidia.com>
References: <1642669368-20605-1-git-send-email-amhetre@nvidia.com>
 <cd7a212e-71ff-90a6-d3dc-1391567fc113@gmail.com>
From:   Ashish Mhetre <amhetre@nvidia.com>
In-Reply-To: <cd7a212e-71ff-90a6-d3dc-1391567fc113@gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.126.230.35]
X-ClientProxiedBy: HQMAIL107.nvidia.com (172.20.187.13) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5bafa94c-307e-491a-6b73-08d9dca228fe
X-MS-TrafficTypeDiagnostic: DM5PR12MB1945:EE_
X-Microsoft-Antispam-PRVS: <DM5PR12MB194532366ADE86F93C6F8E1DCA5B9@DM5PR12MB1945.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5236;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4dJ648RO9AGbi0AhuHb1waSyCbP7JBztlQbxl5uQC5yqIX3qEt2EdKVrbMJLS6m26V7hIwUP3DfxRFFQTVraEO3LE3LsKPLGAWsH30Z3qVXjVpR9/oyqV/R2ND+ATe/nlEqdJ1hKB9YjyE1thoaCf/HDV3mUxoimqdlXgHn4t9QdCykd46RpDXcPy0LQHupNCBGql8iVHLthYY2fkolmnAx9d46RVQAFDFtxalbxk9H6ydV4XLODF7vSqhCaoQ/otfAFf6DWGCi4C9DXGzFujlAlPXd70CgIAWBtZVDRDoFWymSR0uCMzD5+30y2DxxtTUw6UpRgHFMg1PQ4EIkWCI/89FLWccdKb5szcLjuIM3kSpGCdNfPOf5Ee77kUx0ruiBYlqqyRHWXYZEDV7TZ+mwZllGQbknFwyqXkpsgqeDxPxuzFWYMZ2wXFLUfQCgnML06Q5Pfd2svBHPYkzn0AloRMuf5nX79pT3SotxZgXpvuUNZiVpeo27XiIKWjU9SN5wut7q9DnrwjRbGBzVJqKlPBfAV41dcg/8NcnwvdckJjJnsnNngTNkhs6ZQrEdWQJGQX9udd1XIOiXc10CXSrb+OwOqkt3Ta9Dx6V5beuMfjrT16uopFBwy1PVggz+y9wZWUE0RFl7eU7QJV9hcKL3tJZ1SK6gRVBJeR4sTLC/gAHE5q3eYgVwjT5L4HLOhAIDDRhyq6Lyze55n9j6ZuqvgnK1vx56plfSn22MdbM8yQB40mKUgTrt2WFgsw89dupmZirEzypSWsLDAaMNFKeXzYz/2Yzo7HCwBprdChPwWaPvM1FIzpbqPoJvrqqJHNTT1Jiygul7xWIzNGu769g==
X-Forefront-Antispam-Report: CIP:12.22.5.235;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(4636009)(46966006)(40470700002)(36840700001)(4744005)(6666004)(2616005)(40460700001)(2906002)(336012)(81166007)(426003)(47076005)(82310400004)(36860700001)(70586007)(26005)(54906003)(70206006)(186003)(16526019)(16576012)(36756003)(53546011)(107886003)(110136005)(316002)(8676002)(356005)(8936002)(86362001)(31696002)(5660300002)(508600001)(4326008)(31686004)(36900700001)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jan 2022 05:52:07.9117
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5bafa94c-307e-491a-6b73-08d9dca228fe
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.235];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT035.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1945
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/20/2022 6:29 PM, Dmitry Osipenko wrote:
> External email: Use caution opening links or attachments
> 
> 
> 20.01.2022 12:02, Ashish Mhetre пишет:
>> @@ -521,23 +535,64 @@ static irqreturn_t tegra30_mc_handle_irq(int irq, void *data)
>>
>>        for_each_set_bit(bit, &status, 32) {
>>                const char *error = tegra_mc_status_names[bit] ?: "unknown";
>> +             u32 status_reg = MC_ERR_STATUS, addr_reg = MC_ERR_ADR;
> 
> No need to initialize these variables, since they are always initialized
> by the further code.
> 
> Please write it like this:
> 
> u32 addr_hi_reg = 0, status_reg, addr_reg;
Okay, I will remove initialization.

