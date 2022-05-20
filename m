Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A30AB52E391
	for <lists+linux-kernel@lfdr.de>; Fri, 20 May 2022 06:19:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235494AbiETETr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 May 2022 00:19:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234784AbiETETn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 May 2022 00:19:43 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2083.outbound.protection.outlook.com [40.107.220.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFE421498C2;
        Thu, 19 May 2022 21:19:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LT6xGYHxruPr4IYms99gqYEefJ6PL+MLIFzePYXrTM6E1dXL6RJpJw5XL2eviwAMNdQGjAYWeNnz/5yBsMhEyUh/M9dJYCcJyrp6nEuGlDUhkgHy/YAtLtw53QLIHqSXcALJM+alKhhPOmYlCflBmwCeSuP5fIjCP0YDTlBJvqbnGJQGIO9S2lf0VdFlV+ieYfVYku7cjsRfKTBsAtM2QNM7yUS+x0CfCOc5MOJslBzROojzsbpz0SfSleu4h/xMw+cC9/xlochxmYPztWFGw2oP02v09mDHI8SSHGVgCYmKNw/QbfstN487gUXJo59aYMUwu7hcImnYwL9WVoTmfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6wV4/XnJd+3ErxRNnh2Ow1o/bWSqAnyzLrZDYnNZv0s=;
 b=MIWMX0LZWDv6kpvoJY5T3qRmBCqltm2ryVDrQl4Wi25zIHqfaXoNT6OkZeSYg7dze208OtV3a5JC+iqt8uy8/0rgdzJCVBY8KVnxkdRKT0ufdopVmh4xJiQSO4nOTtx3hVeQnwzAuB0gy8SQ05px2aroC9/PBy3eqXaHwi3ThaO5rf07aWPVwV3bP868hpzt98zCfTaj0pNtqgH3sPvjk5O3kGEh+/z3HHLWiPFZganbKk/egYF4TUJsvQyItbiQSwEOqkXh0dpuHGcTRECqNgTTs6l5S8rbTtzt99PPJftZiE1osslLhoiefaWmy2OCZizxUr6hwReJLQW+TUy8sg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6wV4/XnJd+3ErxRNnh2Ow1o/bWSqAnyzLrZDYnNZv0s=;
 b=BeYAq0nB/O2xoaDLOK/T+Vu+kWtiGRsSyGL5gdOpXorB10hZ2QE1zhQRE12lmdBc8pdL7gfcfaRzslgMvRyZebU7B/39yQ/mxL/KrEM/PhQef2G0qgok/gXBYxrPtcK1jN2lhVfA2NrGp9CaffzRb63lJQFbOpN0bmntKDxxbo7baC8RlCg1RxtaGky/7QXUL0tJpPc2fXIxesfqBYL1lU5UIijFmO4gTEVu/1D1hBjNDulzdLxvouoVR60ea90J1kDCRH6ua+eeMdEkoIluaVqOSs+XyBAgFlLCpRpuyAXQ47N8eSDd3k5iGKg5nYpQI/yfpnesx0QBgEYp5z+5Ew==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY4PR12MB1576.namprd12.prod.outlook.com (2603:10b6:910:10::9)
 by MN2PR12MB4014.namprd12.prod.outlook.com (2603:10b6:208:16d::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5250.18; Fri, 20 May
 2022 04:19:40 +0000
Received: from CY4PR12MB1576.namprd12.prod.outlook.com
 ([fe80::16b:eff7:847b:19e7]) by CY4PR12MB1576.namprd12.prod.outlook.com
 ([fe80::16b:eff7:847b:19e7%10]) with mapi id 15.20.5250.018; Fri, 20 May 2022
 04:19:39 +0000
Message-ID: <90680cfb-c611-63cd-ab5f-5afb86c91cec@nvidia.com>
Date:   Fri, 20 May 2022 09:49:26 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH 1/6] ASoC: tegra: Add binding doc for OPE module
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        broonie@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, thierry.reding@gmail.com,
        catalin.marinas@arm.com, will@kernel.org, perex@perex.cz,
        tiwai@suse.com
Cc:     jonathanh@nvidia.com, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <1652895372-29885-1-git-send-email-spujar@nvidia.com>
 <1652895372-29885-2-git-send-email-spujar@nvidia.com>
 <049173a1-0fa6-510b-9169-ebe869b8a3b3@linaro.org>
From:   Sameer Pujar <spujar@nvidia.com>
In-Reply-To: <049173a1-0fa6-510b-9169-ebe869b8a3b3@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA1PR01CA0112.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:1::28) To CY4PR12MB1576.namprd12.prod.outlook.com
 (2603:10b6:910:10::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8dfb085d-a150-4178-fddd-08da3a17f4b9
X-MS-TrafficTypeDiagnostic: MN2PR12MB4014:EE_
X-Microsoft-Antispam-PRVS: <MN2PR12MB4014CE32B2177CAFDF7C24BCA7D39@MN2PR12MB4014.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: O76k09rGZBBcsFHdItQFHRaxcj0fr/GVirb+t+5tXF7e12h37fL1ADVx355bJ+PPSvLIg01YOjHctzVyiWxnhC80aPHa2bK8Gp23SaQQyDcg05vwVocC1c+RSYvyMwiR3l35cOHXBWRayauLtnzsGVR6v3Vhcj33XnAGQ100PR7hqcxmEsPJ8VWtH10XR3F5POENvTVnpzc6wNI3YRii/HIVJ2g39xo2dSvOJp+3ka0aqUDdWgPkpiJ/3yIM5IO33h6cpEBPnaQOsfnWFWYV3kIERToHeyP+8fBQFdg+eetKYshvc36hvYAqbLL1MhFWk2/ixntJ9OAznug9C0Y/Vq+8/3rBOk2whqnNL0QaBpWshId7UIK3kNJhBBgkXg6v8+RZhoP3QgUCif5maftIVbvIcEkysDDlvudDjV3btpSGpnQqurZAV59Lv/rq9qSrK0wnSXwy3IugCzexlXsjIuxkGMtQhKAcfacSlXWBwOu4cBDul4NeJ077ag8+IUDfAk4wlFlWlWDtiNENXok/BTuyQ1ABF+Fn0JAQ2r1VFW6hXIedIHZt9oP8Q/CGoJaJKrZl+r8H7Hxq+Ef6Z1Eg2PxWLweXr6DJcFEP9sFRQRkzyfuIBzEoQPqlkkNHz1EAeQ7tbB50Rr7QneM6qUwgry1a1Bdo894QOAlOu1BLolsL9WIYOh1DNcBp7h5lkTnOAAjj9co0n9rr8d7QiAyC0y5nwkvIXxGqakF5RvGrFE3I+rhGwD5CBiM+RDs4AwjuaI+hYUQ9i0pqq5uid4eQeA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR12MB1576.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(6512007)(26005)(8676002)(4326008)(5660300002)(2906002)(6486002)(6666004)(6506007)(7416002)(2616005)(38100700002)(8936002)(508600001)(86362001)(53546011)(316002)(31696002)(31686004)(66556008)(66476007)(36756003)(66946007)(186003)(21314003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cjlVYzNJNGFkTzdKSDlneTZ4MFJybmlhTFU1Zi9mQkxrRUVOb3FKQ1BDN0cz?=
 =?utf-8?B?N3k0Tzg1OVJvNFhPRW9BYmgvdE91YnZjbU0xLzFUVVRPWGJueTVxRVNKTGdq?=
 =?utf-8?B?TExjYTUvVXc1UFZUTDcyT1RWdzJPOS9kRTBUV3BZUDhHYnlGVE4wdkluaVF6?=
 =?utf-8?B?d3MzdUt2TjZ6V0FnTGRVVGxtR21samR3ZUc4QnNseklPMGlmTnNXeEQ4QzNk?=
 =?utf-8?B?U3dIb2NZQUMwNC9GU2E2ZFNjS3hOM1Q4SWxYd1FsNEh0SUc0VTdDVy81eTY0?=
 =?utf-8?B?Z0QyaW5ZTDllSWZBcFNla1l0ajhhc0F0OEhCdnpxS1JDdnJUamFyaDFOSkxu?=
 =?utf-8?B?ekVEY1o2YUhtOEFoSTdYTTdlQnFkZjVwNHNvSU9aVnQwWUh5ckQrdFhZZU04?=
 =?utf-8?B?ZE41ZlY4SFRmWkV4eXVYdTNkWi9LeWlmQktvOU9FeUM3bERRRSs0OGRJcTlh?=
 =?utf-8?B?cWlyVTZIYStVSXhjbWtDelJJclpnY3IxcWdXQXFqQk5SZ3BmdjdDMnRzWG00?=
 =?utf-8?B?dkt6Qm1sVlVPcElac2xVTlZqNG50c1l3RmRBUXlKL0UweFdXSDY0QmVTdnBF?=
 =?utf-8?B?aktNTnIxbEdlL3pJMklnOSttUFoyUVlBZExGMjAvNkptVGpaT0pOMk9jNm8r?=
 =?utf-8?B?b3ltL1IrK0lwY3NMRmpjYzZVOFlkbEFoTzNHL2pGVElya2labFlTVVo2STZJ?=
 =?utf-8?B?Z1BZa2YxYVd6Y1pDWEpYWXBuNFg5TEhOdWx4MW5kaDZVbkx5WFdyZENITzEx?=
 =?utf-8?B?U0t1RGFMaGMvR1QzMVBzdC9Bd2xVakNMMitVR2c0UHRXZkJNUHFWdmN2aVJr?=
 =?utf-8?B?Z0RRVW9TWU9BL1M2UDI4azF6MTd2YW9uaElENHc4R0V0ZTFSZnZra2REOVNr?=
 =?utf-8?B?cDk4SlFrckRXVGpsMFp0MG1DWDQwUHpGQkVHMXlZb05qQWg5VlBBUHJRNGZQ?=
 =?utf-8?B?Y2FpSk1Jd0FUeFdmaFlLMGV3YVpPUDRtclgvNkw2aWw3T21VczNZWXJkeEt4?=
 =?utf-8?B?MERQSDhjWlhGRmpEeUhjVmFqNUVYejJjQUFaYzJGTlgrWVlQSWxrOC8reEMx?=
 =?utf-8?B?dzZVREYvL2lvVTZKalRUK1BXeTdHOHN2SnRVS2tSL3Zmd3haM1lhM1huWE11?=
 =?utf-8?B?OFF3NUJmM2cxT0xWMkxxaUtUUkpFcElHbEJPZTBJUjJsUWtzVHpYMWcwM1VV?=
 =?utf-8?B?bjU0Y1F3Wkx6KzVhVXI1bWMyblhONFIxdlJ5Q00zeXdxcWx1em0rUC9qMGlG?=
 =?utf-8?B?TXowdWdjbDVTTWFTK3ZzaTZTLzlPTklBSE0zT24ydHc3L3AwaTdDRnNzZy9D?=
 =?utf-8?B?dm9IZW5pQkluNVFTVkZQbzlWeVVMSC9aelZjS1VDRitjRlQ5Rk1RQmJySDkw?=
 =?utf-8?B?SnFhcm0rZDRzMkt0UUZreHVjM0xFWWM2TGNOSEE0eTJWSEFUWWtVbEZUZVUv?=
 =?utf-8?B?OFY1WDU0Sm9Fdit6K09YTEp3UVhBbmNaQTdoUytQWUs0YTBmdmtnbmcvNjdZ?=
 =?utf-8?B?cU51eDFrSytuUDFwS2NxOEsrQXgybTdqWVJLcGtNZXlEbit4WEVvODdSUGZi?=
 =?utf-8?B?Z1JQd1lVV1cxY3IzUGhxNFdjTlFPenl1bVhzT01BOTN2UDg0eitKS3ZLeWYr?=
 =?utf-8?B?Z3IzblM2dTJpeEV4S2g4VEppMlRPM2xITHlnMzZ5clV5SHZNUmtUSkppcHFP?=
 =?utf-8?B?R3RYNlJIdmZUSjJvMjB2eHFITHVGOXErWUdFdHIzbGlJaFdwZmNLNG5ubjhR?=
 =?utf-8?B?c1puTE9NbHdyempMRzNPeGhvR1Y0VDNtTUFQNmFWd0RjeWJKK0ZLZERVZm1N?=
 =?utf-8?B?d24yUDBSa3pUMGxCSTZLNWtLME9MaStDMDNVdjh1RHM1ZUVYMXVFZm1BeHhT?=
 =?utf-8?B?QWhkQUwzR3lhZVNCNlRDamp0UmhxZTN2Y1BSUWNEWTd3SWs0a1UzZWFCdFhs?=
 =?utf-8?B?NlhjUzE3djdsem5HRFdNL3JUUjY0N3pWcXM4UlVGanQ3MEZPMDJyK0dCd3l4?=
 =?utf-8?B?bXZVZkxieXR1Y24yUEVrN0VxQTNubnVhc0F5MmR3bEh2dnZQeHVLcFR4N1JS?=
 =?utf-8?B?Ulhub29NdCtlUTBnU0FsdUhQRlI5MnpaZmNxTlF5cm0xYmRtOStTNDhUNjVP?=
 =?utf-8?B?Y0VyZnpGbFQyU25qVGdpY2Jha0hZYVBYMnY4b01XdUtnSzlTYnFEd2hTeHE4?=
 =?utf-8?B?aXhJN0tsbnhCeUtLUTJCQ3ZsSHZ6eWZHT1pnc0trUTltbk94ZU9tZlJlYW9H?=
 =?utf-8?B?dlN3eThaQzRUV21oUy8xK25oWm5Cb0ZnSFZXcmczdnFWc1JKdXNUUEo4dnJN?=
 =?utf-8?B?Rm5VSXBuOGcwNkwwMzJ1K3dEOUlPbitYUGpSTEtpZTRJZVJIcGxPdz09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8dfb085d-a150-4178-fddd-08da3a17f4b9
X-MS-Exchange-CrossTenant-AuthSource: CY4PR12MB1576.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 May 2022 04:19:39.4897
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XF5EvtqDwxU1hJTgS+gqWkdfA/jCer+vHhHCGiXl0cLdwx6Cki2weWwyG6BHrwmXqNj6esUJMBPtitzqo6+KHg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4014
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks Krzysztof for review.


On 19-05-2022 17:10, Krzysztof Kozlowski wrote:
> On 18/05/2022 19:36, Sameer Pujar wrote:
>> +description: |
>> +  The Multi Band Dynamic Range Compressor (MBDRC) is part of Output
>> +  Processing Engine (OPE) which interfaces with Audio Hub (AHUB) via
>> +  Audio Client Interface (ACIF). MBDRC can be used as a traditional
>> +  single full band or a dual band or a multi band dynamic processor.
>> +
>> +maintainers:
>> +  - Jon Hunter <jonathanh@nvidia.com>
>> +  - Mohan Kumar <mkumard@nvidia.com>
>> +  - Sameer Pujar <spujar@nvidia.com>
>> +
>> +properties:
>> +  $nodename:
>> +    pattern: "^mbdrc@[0-9a-f]*$"
> Why? We enforce only generic names in shared schemas and this is neither
> shared schema nor is it generic name.

Idea was to keep these node names consistent across DT files and parent 
node can allow a given list of child nodes with strict checks. Does name 
like "dynamic-range-compressor@xxx"

>
>> +
>> +  compatible:
>> +    oneOf:
>> +      - const: nvidia,tegra210-mbdrc
>> +      - items:
>> +          - enum:
>> +              - nvidia,tegra234-mbdrc
>> +              - nvidia,tegra194-mbdrc
>> +              - nvidia,tegra186-mbdrc
>> +          - const: nvidia,tegra210-mbdrc
>> +
>> +  reg:
>> +    maxItems: 1
>> +
>> +required:
>> +  - compatible
>> +  - reg
>> +
>> +additionalProperties: false
>> +
>> +examples:
>> +  - |
>> +
> No need for space

will remove


>> +
>> +  compatible:
>> +    oneOf:
>> +      - const: nvidia,tegra210-ope
>> +      - items:
>> +          - enum:
>> +              - nvidia,tegra234-ope
>> +              - nvidia,tegra194-ope
>> +              - nvidia,tegra186-ope
>> +          - const: nvidia,tegra210-ope
>> +
>> +  reg:
>> +    maxItems: 1
>> +
>> +  "#address-cells":
>> +    const: 1
>> +
>> +  "#size-cells":
>> +    const: 1
>> +
>> +  ranges: true
>> +
>> +  sound-name-prefix:
>> +    pattern: "^OPE[1-9]$"
>> +
>> +  ports:
>> +    $ref: /schemas/graph.yaml#/properties/ports
>> +    properties:
>> +      port@0:
>> +        $ref: audio-graph-port.yaml#
>> +        unevaluatedProperties: false
>> +        description: |
> No need for |

will remove.


>
>> +    ope@702d8000 {
> I would suggest generic node name, if it is possible.

May be "processing-engine@xxx" ?


> peq@702d8100 {
> Generic node name, so this is "equalizer", I guess?

Yes, I can use this name.

