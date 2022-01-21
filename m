Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4DD6049599B
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jan 2022 06:53:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378578AbiAUFxO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jan 2022 00:53:14 -0500
Received: from mail-dm6nam11on2087.outbound.protection.outlook.com ([40.107.223.87]:52320
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230443AbiAUFxH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jan 2022 00:53:07 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hhEd9PZa6XK5/+GUkplA0OwQAlB1LBuKFvaYbM5AveqT6rmn5t8InxXT/UB6qb4KITDmp7EglXQctn0bTeb9e8cauYh1LBq9sSkGrv1peKBULZ/dvcsCecDIiVwu6vYWPflobW22vfYvTclT1wxz5VkR/MRGr86BXdloy3D2sZjBBt90tSUY3Oq+BKpRYLqxn3WwD4O8IH/gV81+oaBjjitTc2/IO0BelNCR7ObTTbfKboMLXITdTD23UTsgQt0djaQK6WjNjefbQFFFV1goMS/OB1KgV2RhYboIMqBSFkLWI4meOjLgq8z3PhH2roPy+VliUKD+9sNUmJL/re9U4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c+O5Bgj9LV5pnnzauc9BB7IaLtBMbqRc2CnpxokRU0Q=;
 b=cxl0qyXJbyA7CghQhC1WvGD2WGfwiNQdNlVQ0QbAFSN2ONvnotSgIWjQSk3keyWjJNVm3BbqpebyTHgkFowHQSSYkGuaj/dGI4nWvee7bzSE4i145fZb7tjnVzryPvO7c8/EhjiZsSkpalZmuJ3etPgiyBCX3VWuu5wScFva2gnDzszj57/vqSugsJ7DqtTLWS8kmVuoJVWGFybUKMlxPO81l6QFlS8gisVIPvtanRK4qrpbII0PWi+dw0OVRpB+YuewPhVyaT/SU8bxEODlkbq8/xHTCbif4EVth78QCvLfCe6SIP8oGR2vYpenCh5Vk5L58ZS5V5ooDtvR4GfGvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.234) smtp.rcpttodomain=canonical.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c+O5Bgj9LV5pnnzauc9BB7IaLtBMbqRc2CnpxokRU0Q=;
 b=NzNqrMyHqiYg9/WEDxurUM5wZioYF9+ciZwxG2BJuG3gbtVEi4iPcDWdNL7iTdC2Tdbae+nJhqnmGuSOOJGDu7EGp0Npbv5IvS/5ZJdu2cKHS4Mo6sEsXUUiRks+urTgJHNtXDpFcHClKNyuV+n3/fmNp6pSWsKYnPAn+GzZPSKAkjIuMxuP7W5zidsXtsyWzmwg7RoISVabv78JDgp0D9586KTT5f0k3HefO5Fk/glicJ9LqLANluuHldu98RM8vAXooaAn3it93/4mG9zUbFym0eeoJK63FGxoN57Kwji7fMKmeqIWziuWZJC+Q2nL1GhCvvXI5ufWTVgUzd9sGA==
Received: from MWHPR07CA0006.namprd07.prod.outlook.com (2603:10b6:300:116::16)
 by MW2PR12MB2364.namprd12.prod.outlook.com (2603:10b6:907:b::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.10; Fri, 21 Jan
 2022 05:53:05 +0000
Received: from CO1NAM11FT057.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:116:cafe::d4) by MWHPR07CA0006.outlook.office365.com
 (2603:10b6:300:116::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.11 via Frontend
 Transport; Fri, 21 Jan 2022 05:53:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.234)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.234 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.234; helo=mail.nvidia.com;
Received: from mail.nvidia.com (12.22.5.234) by
 CO1NAM11FT057.mail.protection.outlook.com (10.13.174.205) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4909.7 via Frontend Transport; Fri, 21 Jan 2022 05:53:05 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by DRHQMAIL101.nvidia.com
 (10.27.9.10) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Fri, 21 Jan
 2022 05:53:02 +0000
Received: from [10.40.163.9] (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.986.9; Thu, 20 Jan 2022
 21:52:59 -0800
Message-ID: <25d1a334-5746-a53e-dbc0-f384333d14e1@nvidia.com>
Date:   Fri, 21 Jan 2022 11:22:56 +0530
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
 <1ef23e26-fcde-e2b7-d4d7-c4fc68c1ca90@gmail.com>
From:   Ashish Mhetre <amhetre@nvidia.com>
In-Reply-To: <1ef23e26-fcde-e2b7-d4d7-c4fc68c1ca90@gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.126.230.35]
X-ClientProxiedBy: HQMAIL107.nvidia.com (172.20.187.13) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0e70a1bd-b449-46e0-6308-08d9dca24b0c
X-MS-TrafficTypeDiagnostic: MW2PR12MB2364:EE_
X-Microsoft-Antispam-PRVS: <MW2PR12MB2364C40D2EB1EC07EAA47AF8CA5B9@MW2PR12MB2364.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: W8nrmGQL8gH5WpgLnAN3wv9Oq1XJuQ+j3mDqlXm/9OgU6ppRZVklNhavlndMQhFIfoNMN9asTTqVIiwWPyHN0hrrUxi50PDCS/udW1GAxboWbgTrfpsrhzHX4lE2zTBeiqyx95Tt8GloK37nJnZY52ZDNUNGv2+bIk1Xfv02gNnkgod3hSc36BaXV6qaEjjwR0aHWU0MQWibs89S1tGWV4/La1LxfWp99WkVr+AamitfN+IRGf6obUaVtajV1hJMrP1L9R71Ffydk0+TMdzQ5DRM3jSj7TTVuLO56AokjBpqiVMtVniyXdNXpUW5yRKajJsL49UcAT48H53Tb3r7vt+ZaRf+HWKxisbCTX9cmmi8If/cHu5L2Ms2jCFN6x8w80T/wUruspsvrXFdKAGPJDpxbqZmTFd49o2uW84omYCgylhDptSeBJTqXD0+A4GGqeluT/UDgDALhipNYF4ZaNJpO4VkFrgtsAdis4u25ndk4SeHZ9B2ymp/AyFnCqdfFN4FDb/syruotuCBwOzIfCDKbkKrbcLTZBVMLl0U0g2JuCEkcqg9rorBDXgT6SLzsSR1OfKyXaZb5Qtx/pJTPyvedPEPtdTax7OMP+UgkGm41a2QuF4XmNweiRXjtTrnxC/SzHnxSQnffLIij3dhv/OMiWq4eBDGbFxweqcj8JyrvCq49j8BcPusqp2ep6TfQAkIs+s7ncah/Pl/NkX5wWR8Hi5a4Qu8TWu4XN8yOZ38ZFXML9pUbZYIEkJZNSbfGGu7aOp+i4qtOceA7/mRW+uNHaisRtl+haWQO7IOMFJQAvvpbqfR9Y9jFsgIAYJArwDlIp2kNxYbN34iiUPzOA==
X-Forefront-Antispam-Report: CIP:12.22.5.234;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(4636009)(46966006)(36840700001)(40470700002)(356005)(5660300002)(81166007)(16526019)(31696002)(36860700001)(53546011)(107886003)(508600001)(26005)(110136005)(4326008)(186003)(47076005)(31686004)(2906002)(54906003)(8676002)(336012)(40460700001)(426003)(4744005)(70206006)(316002)(6666004)(82310400004)(36756003)(86362001)(8936002)(70586007)(2616005)(16576012)(43740500002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jan 2022 05:53:05.0457
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e70a1bd-b449-46e0-6308-08d9dca24b0c
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.234];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT057.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR12MB2364
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/20/2022 6:36 PM, Dmitry Osipenko wrote:
> External email: Use caution opening links or attachments
> 
> 
> 20.01.2022 12:02, Ashish Mhetre пишет:
>> +             default:
>> +                     status_reg = MC_ERR_STATUS;
>> +                     addr_reg = MC_ERR_ADR;
>> +#if defined(CONFIG_ARCH_TEGRA_194_SOC) || \
>> +    defined(CONFIG_ARCH_TEGRA_234_SOC)
>> +                     addr_hi_reg = MC_ERR_ADR_HI;
>> +#endif
> 
> I'd add new "has_addr_hi_reg" field to struct tegra_mc_soc and use it
> instead of the ifdefs.
> 
> if (mc->soc->has_addr_hi_reg)
>          addr_hi_reg = MC_ERR_ADR_HI;
That's a good idea. I'll implement it in that way in next version.

