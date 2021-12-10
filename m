Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C939146FB44
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Dec 2021 08:27:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237490AbhLJHap (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Dec 2021 02:30:45 -0500
Received: from mail-dm6nam12on2076.outbound.protection.outlook.com ([40.107.243.76]:7521
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S237455AbhLJHao (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Dec 2021 02:30:44 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=csZmUTibawcxob9L+PUHaUBxRzrAYCe1nR3+8pCOKUd7zR5eND56MEU2+ZYrF6dHHWaEUdLvPtlCAyUr+Y11RI4tiE0BYmgEQ5ozvyXAouL/+O7iImXUXy3mq65i6st7M/+ay1KWBAsSvisww6yEh1oeUUtW8yB1qll/dfF7FV+Z591fNBwvp7tMzTyjxsmGLrRTngMqw8F+yO/HxztphL5CTR8bTUonvN/dexjaCamPEFQYzO1JCWGX62DsIl94rjhJL4ada03c/D2gCmXEgjGcyktquH3zUYlN882G42AElwXd63VLKafujdiOKRhdfqFJIOnfZeTbVZzYZGIX3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SmyB7R1zV+uQhONuwsyKDbarGIPh75PlXmgfq4S9gpw=;
 b=DpIAnBLILd26+1WtWmoB40v25DY9WSQGuKEoShlakO9tGFrAyypHSUclED2LsThFsrYS8Sv/3DZrFnZF+JLBqHgvz/aXUxxUdxyvdkexL4fuR5auNcgHo6eWmj1LhIpSzB6F2XznOMTTJG2dcdbvm4LWjlbKIKZMUA0K4ILSEvRpp2e2owY6j8eOcCC/6Q6sXtUROzOWjDVhvChaIGZaRanFtmc/Y/R/eP0zj4L2cRKRoTHm4eFDxedLtYQB17wSkbwj+74E5nM3h5CrftRTP9+4hK5IQS1SMkPLlWyEWZ3kgBezzUyu9SGVsTG5iuK8Sedr4DHWTzul3ZcESgSAuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 203.18.50.12) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SmyB7R1zV+uQhONuwsyKDbarGIPh75PlXmgfq4S9gpw=;
 b=XEdD/gvZSscILeNMd5qE0NFKjCcq7TAJDe2gx9SVqRuwDMvUqy387Bi1C0DUl7EAWgbPvjg8uaMMw15Xylo25asJgX7d4KvVs5QtQBp9+3hD8x1vrx8KW1RcIeUAJsruwwtn18Hsdw4Z65pIRpuKDjUr4kXFaK5I3VJO1kVn7acYYoLQcp3cxOSs3l5gF3gVLl2/o1unpohaOeuuvL3h95IHPVZCasD26IvNw836+EVgc13xdE+C/IictjlYWVyo5j4Zunuis+ncYWJwH7RrQJlo741XLMhCP62XVhYA3EWakZcGu5DD8G+xDCiqNxqob3AaORT8RQ9tf3SZYst/wA==
Received: from DM5PR19CA0045.namprd19.prod.outlook.com (2603:10b6:3:9a::31) by
 BN6PR12MB1681.namprd12.prod.outlook.com (2603:10b6:405:7::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4755.21; Fri, 10 Dec 2021 07:27:08 +0000
Received: from DM6NAM11FT030.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:9a:cafe::60) by DM5PR19CA0045.outlook.office365.com
 (2603:10b6:3:9a::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.11 via Frontend
 Transport; Fri, 10 Dec 2021 07:27:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 203.18.50.12)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 203.18.50.12 as permitted sender) receiver=protection.outlook.com;
 client-ip=203.18.50.12; helo=mail.nvidia.com;
Received: from mail.nvidia.com (203.18.50.12) by
 DM6NAM11FT030.mail.protection.outlook.com (10.13.172.146) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4778.13 via Frontend Transport; Fri, 10 Dec 2021 07:27:08 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by HKMAIL101.nvidia.com
 (10.18.16.10) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Fri, 10 Dec
 2021 07:27:06 +0000
Received: from [10.41.21.79] (172.20.187.5) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.986.9; Thu, 9 Dec 2021
 23:27:01 -0800
Subject: Re: [Patch Resend v1 5/8] dt-bindings: arm: tegra: Add NVIDIA
 Tegra234 CBB2.0 binding
To:     Rob Herring <robh@kernel.org>
CC:     <linux-tegra@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <thierry.reding@gmail.com>, <robh+dt@kernel.org>,
        <linux-kernel@vger.kernel.org>, <jonathanh@nvidia.com>,
        <jsequeira@nvidia.com>, <bbasu@nvidia.com>, <vsethi@nvidia.com>,
        Sumit Gupta <sumitg@nvidia.com>
References: <20211209172206.17778-1-sumitg@nvidia.com>
 <20211209172206.17778-6-sumitg@nvidia.com>
 <1639083359.670183.3925943.nullmailer@robh.at.kernel.org>
From:   Sumit Gupta <sumitg@nvidia.com>
Message-ID: <e46a73c0-df70-fd8d-82e2-b29a8f6fb917@nvidia.com>
Date:   Fri, 10 Dec 2021 12:56:58 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <1639083359.670183.3925943.nullmailer@robh.at.kernel.org>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [172.20.187.5]
X-ClientProxiedBy: HQMAIL101.nvidia.com (172.20.187.10) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b652056c-5843-4198-4e23-08d9bbae7969
X-MS-TrafficTypeDiagnostic: BN6PR12MB1681:EE_
X-Microsoft-Antispam-PRVS: <BN6PR12MB16814901135FCA0010A2D501B9719@BN6PR12MB1681.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gE0sXuif52nGrmZ52DE8jhv4bamZrUduqbefR7MFe+NBXlSJWk4hGHH6FO4PKPFtbHSSEjUqeYecxpZYPXqARj6YeforHmsN7/UwMsupupUAxK1QRNYt92TQ8lENty04fUqSkr/37bkhXiBxT9e7HEcDK5Vz66qiKiG5jWa2KjJiJGCfVKdNH2cRJ7LyO/3UEqGXE4lp/ZyCxV4tT0b7WN0x45QVbPBtHLaJapoGgTo3B8noayD3Eb43QZaatHgBtvjp6f/sh6PAi+r8U/hZJ0sijkdPPU6nZHLUWWzTNFUZoYkpmDwZFLx8wVxaOHaYbn41ILz89IMpXLSLMF9lS0UjvsaQHaDkSGoAuaeRYxFTk+5cEITNRdB6Uex9ctZPmH8eZzHKbt4S3CO6n/Jci78yuWPBaUQWyQ/Sw6ITjbkSn4aORpB8PFyRWsmax3uZbsj38LBCykLf1y9UZHRenOt+4NiDN1lK9xAesa5EwFKngZ81sFBnsIbjYSaQyktwbeABfGgcHKecL6tFwCgY/SoD3dYfPEKNrbA11NlA89f7Ao+q1BLCfxQHeGpORfl3BGu1xtB95zsYTxrJZu/UFLqaQMlSpbfFvk3Hl7dg0lzwYeusHS/VhSiG8V3WlMKrpTimBQ72kc0+arnYNAclaBFKfRuRm2Ab7i13a+S+AaiTFZWmGunkyamkaX5cerx/Cf8q+eP3I2W0eD/P4IP5HMTUIvGctvDX+MY0P+7NvAfO2E/op0WEz54afBqemf+oABy+7vG5OksGrzp42V5nYggbCdzXqOMy8uBJHLCtTlm1kP7JJhfaX7d1SAdIkF8flQogmYckl/mKGpOCEYZVUqNMUNTpzKFFmYHwLPln5H4PtxZnP378vXYszej6QcGHjvyFjNlkNUMXYYCOHIBCQmP0OePTpsgJvZAqfQufAuM=
X-Forefront-Antispam-Report: CIP:203.18.50.12;CTRY:HK;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:hkhybrid01.nvidia.com;CAT:NONE;SFS:(4636009)(46966006)(36840700001)(40470700001)(2906002)(82310400004)(40460700001)(31686004)(6916009)(5660300002)(47076005)(36860700001)(70586007)(107886003)(86362001)(70206006)(4326008)(356005)(31696002)(16576012)(8676002)(26005)(316002)(34020700004)(36756003)(83380400001)(186003)(16526019)(8936002)(508600001)(2616005)(966005)(7636003)(336012)(54906003)(6666004)(426003)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Dec 2021 07:27:08.0909
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b652056c-5843-4198-4e23-08d9bbae7969
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[203.18.50.12];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT030.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1681
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Rob,

>> Add device-tree binding documentation to represent CBB2.0 (Control
>> Backbone) error handling driver. The driver prints debug information
>> about failed transaction on receiving interrupt from CBB2.0.
>>
>> Signed-off-by: Sumit Gupta <sumitg@nvidia.com>
>> ---
>>   .../arm/tegra/nvidia,tegra234-cbb.yaml        | 80 +++++++++++++++++++
>>   1 file changed, 80 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/arm/tegra/nvidia,tegra234-cbb.yaml
>>
> My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
> on your patch (DT_CHECKER_FLAGS is new in v5.13):
Ok. Will check and correct this in v2.

>
> yamllint warnings/errors:
> ./Documentation/devicetree/bindings/arm/tegra/nvidia,tegra234-cbb.yaml:73:1: [error] syntax error: found character '\t' that cannot start any token (syntax)
>
> dtschema/dtc warnings/errors:
> make[1]: *** Deleting file 'Documentation/devicetree/bindings/arm/tegra/nvidia,tegra234-cbb.example.dts'
> Traceback (most recent call last):
>    File "/usr/local/bin/dt-extract-example", line 45, in <module>
>      binding = yaml.load(open(args.yamlfile, encoding='utf-8').read())
>    File "/usr/local/lib/python3.8/dist-packages/ruamel/yaml/main.py", line 434, in load
>      return constructor.get_single_data()
>    File "/usr/local/lib/python3.8/dist-packages/ruamel/yaml/constructor.py", line 119, in get_single_data
>      node = self.composer.get_single_node()
>    File "_ruamel_yaml.pyx", line 706, in _ruamel_yaml.CParser.get_single_node
>    File "_ruamel_yaml.pyx", line 724, in _ruamel_yaml.CParser._compose_document
>    File "_ruamel_yaml.pyx", line 775, in _ruamel_yaml.CParser._compose_node
>    File "_ruamel_yaml.pyx", line 889, in _ruamel_yaml.CParser._compose_mapping_node
>    File "_ruamel_yaml.pyx", line 773, in _ruamel_yaml.CParser._compose_node
>    File "_ruamel_yaml.pyx", line 848, in _ruamel_yaml.CParser._compose_sequence_node
>    File "_ruamel_yaml.pyx", line 904, in _ruamel_yaml.CParser._parse_next_event
> ruamel.yaml.scanner.ScannerError: while scanning a block scalar
>    in "<unicode string>", line 71, column 5
> found a tab character where an indentation space is expected
>    in "<unicode string>", line 73, column 1
> make[1]: *** [Documentation/devicetree/bindings/Makefile:25: Documentation/devicetree/bindings/arm/tegra/nvidia,tegra234-cbb.example.dts] Error 1
> make[1]: *** Waiting for unfinished jobs....
> ./Documentation/devicetree/bindings/arm/tegra/nvidia,tegra234-cbb.yaml:  while scanning a block scalar
>    in "<unicode string>", line 71, column 5
> found a tab character where an indentation space is expected
>    in "<unicode string>", line 73, column 1
> /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/arm/tegra/nvidia,tegra234-cbb.yaml: ignoring, error parsing file
> warning: no schema found in file: ./Documentation/devicetree/bindings/arm/tegra/nvidia,tegra234-cbb.yaml
> make: *** [Makefile:1413: dt_binding_check] Error 2
>
> doc reference errors (make refcheckdocs):
>
> See https://patchwork.ozlabs.org/patch/1565951
>
> This check can fail if there are any dependencies. The base for a patch
> series is generally the most recent rc1.
>
> If you already ran 'make dt_binding_check' and didn't see the above
> error(s), then make sure 'yamllint' is installed and dt-schema is up to
> date:
>
> pip3 install dtschema --upgrade
>
> Please check and re-submit.
>

