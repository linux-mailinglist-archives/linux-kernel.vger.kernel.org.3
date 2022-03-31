Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B3A34ED452
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Mar 2022 09:00:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231608AbiCaHCd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Mar 2022 03:02:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230463AbiCaHCa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Mar 2022 03:02:30 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2053.outbound.protection.outlook.com [40.107.244.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 017391EE8F7;
        Thu, 31 Mar 2022 00:00:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nczkmHb3KeXtiZ2AudzfZ4UlZBiiFTJiReDmNJAXX3Bt7Bp9w7xNA70eYDXIgoZPpj7aV3Bw4JE0YGGoWQCv0ThvyYuEDNMh/dYspPj+zovZpOjaq1pjr0fD5K2/TbkX7oYv1vs1AYElJVaXa/X+/Y+/s9MOXqcMbCZ2rtNntk6nsA5ypyEZIPDfbpOvhE3rw3F55hBF0jvQyHiWTn+9S9iE+8sDFw2Y2KBiOUojIYTO6P1TXy7KYPcbdz2l9kP1p/nQ2/8GGEmJPBzRMEzU8nC+YK6Niw5L6LAJ43zH0lvrWzhGDUbfODO/Qh7JPXOmqfZeW9w8ktLyx/ro/4dYGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qeu5vCOhQL8VfRrfNcTI5X8v1W1CN/Ul859YGrUQBkg=;
 b=S2nfHxjU7ofNeIa9EtRqmsjQ80Tv2ETva9pwV6ddRYZGYnEUR0owyuhjRRXlakxtKeDd4DAaPqOuzEgSsYfY8BFAKBLEssJYcWIk2O6PFJ/UY4rCUnumRcHdKjZunPuFB9Kg1wWpbOqiFTePBmJqB/FSOCYj+59vAMV0wSJw/ERk2fEQ2Qmcc2Qi3/nHWcqt/Y4gO41yQOUGRYUcQPfKVivkPd+8Bt7sxBxdq7pf7qpziSgi7cIloBW7kxjFvI1FGuliT4rpgC07dkXHlzgYCXFJ8KUJleZf9zlAfpaUTaTWEyrXbvbx4R+3ShVpZ4gRciEEeUh7R78NUpCj0fxhfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qeu5vCOhQL8VfRrfNcTI5X8v1W1CN/Ul859YGrUQBkg=;
 b=e9P5i6Et11jmM7L2w3BE8ipXfF7aw5E9i7MkraCBuAEFDhX4vAIcgEEzkBb4g4orFh4vsIwdr3A+oardGNG6TLxqiV10wp3SQQF/T5MRITZcaauE/LNNRWnvd8RaP86YwBuN2Z1EQVI66H3g7wRzDT212o6sE2pfHpHy/Mvvf7MFO8XvZ3PU7teKSRGtB6UxM+WCt2JqzAH9ptVsAO4+7pq4KWxOx0/ItO7pWjdwz8gnHaStbXtdWWXBqDOPNfXLmr/+zdYb9mQzJesDmPcnCM+Z4bcI0llOWrWvKhg8u9D2bo00p1lJ1KVoc2/t5/hUHd1ZYRqOuqhgknfleJqtaw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CO6PR12MB5444.namprd12.prod.outlook.com (2603:10b6:5:35e::8) by
 BY5PR12MB4020.namprd12.prod.outlook.com (2603:10b6:a03:196::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.21; Thu, 31 Mar
 2022 07:00:42 +0000
Received: from CO6PR12MB5444.namprd12.prod.outlook.com
 ([fe80::10ef:dc56:bb21:76f6]) by CO6PR12MB5444.namprd12.prod.outlook.com
 ([fe80::10ef:dc56:bb21:76f6%4]) with mapi id 15.20.5123.019; Thu, 31 Mar 2022
 07:00:42 +0000
Message-ID: <cfc6a2ac-1489-e221-f262-aab0ad5b701c@nvidia.com>
Date:   Thu, 31 Mar 2022 08:00:35 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [Patch v2 2/4] dt-bindings: arm: tegra: Add bindins for
 nvidia,tegra-ccplex-cluster
Content-Language: en-US
To:     Sumit Gupta <sumitg@nvidia.com>, rafael@kernel.org,
        viresh.kumar@linaro.org, robh+dt@kernel.org, krzk+dt@kernel.org,
        treding@nvidia.com, linux-pm@vger.kernel.org,
        linux-tegra@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     ksitaraman@nvidia.com, sanjayc@nvidia.com, bbasu@nvidia.com
References: <20220330143819.27476-1-sumitg@nvidia.com>
 <20220330143819.27476-3-sumitg@nvidia.com>
From:   Jon Hunter <jonathanh@nvidia.com>
In-Reply-To: <20220330143819.27476-3-sumitg@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO2P265CA0516.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:13b::23) To CO6PR12MB5444.namprd12.prod.outlook.com
 (2603:10b6:5:35e::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 15234587-dd2e-46ad-7221-08da12e42b88
X-MS-TrafficTypeDiagnostic: BY5PR12MB4020:EE_
X-Microsoft-Antispam-PRVS: <BY5PR12MB4020425CB0630D3A77BC3D6ED9E19@BY5PR12MB4020.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: B8RJLzBPn8U5evqVVogVKnLK+PR0nk+LbgUuMwgz1otSAudwAdnyGyGYhwMuDPDxjSzDuS6WgYWQQnIjJXICJui0OBwTF+CeOgIpFWw7cFdpZfPnDmHRxno5KLjqAJ7/5/vxpZhpADKalETnZ9uttn8SkadkbKPXDSWV9NM1oX+bNgxqreJoCkgLZ6KPFtbkma0CzTKylLZpiDwtFob1D1biSzlhpXr0YJsWNpPFSw72rvbGTwHhgxRfqmxAIoanDfXN9YQUt8RFlL7HSEczQ+RD4rScOz2WkyW6agiERXDczQfqFjCTRgBBs9YZwveCUvdEaNtfxJVI+a8DEiDINz2Wsft//GN9IsFO3t7gWvY+U7ochM/qw5XgM/gmSL4iwgKDWBVp5KbLIohgls4csu4Q6E6daMwqOXClATTev+/oRq1X30mx3ChP+T5bpoQ4sa1fomk78CSN3Nqh0RU8XzybuoZg1SrbkaQyn9OcMi7cun4E+ZehQNIU39OYa0IwTtrle6wnWOO0qoJeDFwRJf30kMzLdrnLVHngVgbfOo9vb3kmNOa7FK5TeuBxIw/tPbTSpmOdhhJbgWIEzxf7GoLrSg48SbeuBlsDnUJRj5pny6ub3iTjiqadynE7sosa8/UYF9gf6KrExRnv4N5QPh+89Xwsg5IMBjozyEoDWhXdLEgUa0xP4POcyMSNtMcr9lfo+6YvfZ3Ps3estFbQvMlw2xZh0RGUWnEPxlcjFq6sBvxX7u8Ksl+R51CL5jl7JyAc8RCfaOyIWGiw+w7q4J+Ax0zIX+tmJXGHkHwH7nNdictCEl8KdBnn62w27F1KEO+dbdfNIujVKCs6LtILNGkODOEQ0w3mZHXW2vnbnV8HnaSJZiXeApeD5NE/1XGD
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR12MB5444.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(31696002)(86362001)(2906002)(6512007)(26005)(186003)(53546011)(316002)(8676002)(66556008)(921005)(38100700002)(66946007)(83380400001)(66476007)(5660300002)(6486002)(4326008)(36756003)(55236004)(508600001)(8936002)(31686004)(6506007)(2616005)(107886003)(6666004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?T3U2ZUFxZ0VsNjU0Q2g2djVtSEk5aVZZS3dsOTgyK3dOTmNNODhjVy92UHd1?=
 =?utf-8?B?UlFWYURsSjhjL0lMdEVnbHdlN2JNSWhDazVuZnVoakpoamlXZVY3dWRXdlU2?=
 =?utf-8?B?NDNLQzErNEk4eGVGY1p0d1R1U1JBR1dmZzcvblpyMG0vTktyRkpzQmQrQ0dH?=
 =?utf-8?B?ekRJb1FuaE0vSHdVTzUvNjdxdnNUZEFJM0NVQ0w0MmVpWmV0TjRlc25nRHBy?=
 =?utf-8?B?cTVSQW9pcC8wczVSemNkV09rWDFrMjZ3QTM3K3BSdnl3YWE0ZUhGeVlNVHFu?=
 =?utf-8?B?ZHJYMzRGYVFVVTg1Y3lVZVViNlNNNFNmcVVqNjU1WGFyWlJKY004eTBaM2Ex?=
 =?utf-8?B?WXY1QWFNcUVuNkR2YjNlK2cyN3U3Vm5hU21qNDMzdlBlOFZTUy9mbnJIcW5B?=
 =?utf-8?B?VVZoaWxPSi91bkF5S05hM2pkR1d0TjdnazcxRkg2NEFLZWFxakhBWS9wRXNW?=
 =?utf-8?B?ZFRNeWlWTlI2QUFFMCt0OHJGTWYyNlBURWxHOVR1dnhFREdwYU9UUjZaOFM1?=
 =?utf-8?B?R0JVdVJ1NENHTVViSnN2YnBJUlpYUWhyMG5wZkU5WmN0T3kyemJUay9YMzNk?=
 =?utf-8?B?dDNKQndCWHRFZlN3QWE4cnJwY2R1blBrREdlOWphMFFOZ0hMb0NIc0FsbUlW?=
 =?utf-8?B?aHBPckc2WEJneERLcFBBM2VNd0ZhajJEQ3BGSndvd3ljZE9pTjVWaUxxVXVL?=
 =?utf-8?B?RVdQdWl6eXdLU0NPTS9hcmV1aThNMDNFRHVYaWZEMXpocldkY2pwM28zUk5B?=
 =?utf-8?B?Qm1pTmNQWWFmMDFKOUZLV1d5eHg1NGMweDhrSjBXYWlMMzhPQXB6dXZ4bXo1?=
 =?utf-8?B?VFdJUzR0b1Ivam5BR1JxMm9TZGdWNnBuTFd4S0lYM0ZMWS93aFhielcydmdz?=
 =?utf-8?B?U3hsVW40Z3plalU5Vy90THgzNkJ0azhuNzN5WHRjSGJSWG9nS1N6TjJFODU2?=
 =?utf-8?B?cy8wT0ZQRlQ4QnYwSFNPWTZ6OEYxaWZFN25ENUwvVjdpRElrNVRvRitKeWZ0?=
 =?utf-8?B?eno5TEFCaDNDSFZaMkY0RDJRODVDQzE5T0ZXL1prZUQwZ2xqa1dsK3lFcWpN?=
 =?utf-8?B?OEZPN2hua0hJYWRHOGNCZDJwLzJPTFpVcVhLTWVhYmV2M1BhR0JaTVMrRExp?=
 =?utf-8?B?VkdLTE1KWEI4VUdwWjJ5RGovTHlGK2xVV1NqUThUcXYvaS9QNEhvWHBQZ3ZC?=
 =?utf-8?B?T0NwQzdPNmo3S0hYV3h3OHNlTGwwWEVyWnhacnZVcmd2WFBiWWJseW9EdEp2?=
 =?utf-8?B?bjV1MW1xWlNkVDB6cFVpSXI3QnFuSU1ITlA0bDZqNHptL2dIdjluVVJZNU1G?=
 =?utf-8?B?U1BSeHVNZUlMeHlOSFppZnFqWGZCb1VFV0pDMm5uYVRqdGtsV0tlb2ZZTVhK?=
 =?utf-8?B?Si9rV1A0bC9wam5OdUJFNGdSN1d1Q00rTUJJK0s0aU00R0dVYjBFazZvSjZa?=
 =?utf-8?B?djdtSGlMOE1VRU5BeldmUXBrMFdOYWVhSzBzQzFDckg1dGtTSTZlOFV3NzY1?=
 =?utf-8?B?cGJPd0M1NGVFeEVlQ3M1RXgzdkczVi9QcGR1VWxnanJvZHQzQVN1cTh2ZlI1?=
 =?utf-8?B?dENiRkxkL2V2Rk9yeXV3RmJPOGVJNjc1QnlLSzRtanppSnp0NGJoM2pGMGc2?=
 =?utf-8?B?VDNBOTh5SWh5U3ZwL1laQkd1NmorWHNRSTdCTlM1QUw1Wk14MzVCaU41TW9J?=
 =?utf-8?B?WStpOFFGMUNtSzNXODYrUWpRUnpLUndRMkdQTVJyVmRMOFFNSkFUdWtzblh6?=
 =?utf-8?B?VlBsLzBlbVZYVnU2Z0doYk5pVlY5TWN1S05zTEFZMnB1cGZ2NnRrVlhONHNE?=
 =?utf-8?B?WktVNHZubG9UWUVMU2pwbHBvRHBvUFlxWndYSnZHaHllcnZJT3hIREZOTjBF?=
 =?utf-8?B?YVlXRmRKMVFJWE9vczZNUkVIRFFWZjRoT1BhR1IrRU1rcVhrc1kzTVNQZ2Mx?=
 =?utf-8?B?Wk80UkFzdmwrVnVpQVN0NVpFQ2hhZkVNVllzOHFoTVRoRTR6ajNyNFU1dlk3?=
 =?utf-8?B?TzRCbWdFUWNLS1VXemYwLy9SWlFNN2o3aktabmRXWDNldVorTjVrczFUUmF4?=
 =?utf-8?B?bHE3c1V6OXRqUlRocTlzOXNBMTNIT2F1S2RWSks1ZFBZNkp6L3ZTdStBODdt?=
 =?utf-8?B?clpKMW9maXlGWm1rTUJsVGVyU2w5UEs4Vm13eW8va3F6VGVDZngwd0VIWHow?=
 =?utf-8?B?Tk9sUWtVWTJiWkFYYjJzMVg2QWdmS1BLbFZEZzFoK1VlTjVCZTJKeW5LWERX?=
 =?utf-8?B?N2dHRjRUUTNhVHVMV0lLdlRPNFBiZjJOMnNjWWJjOER3aEZKdlBJeVRraEtu?=
 =?utf-8?B?NDZxMHFJbjI4cnprU2tLYUE0ZDg2dDdMcGx1WXAwZTBEWVZhWG9lQT09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 15234587-dd2e-46ad-7221-08da12e42b88
X-MS-Exchange-CrossTenant-AuthSource: CO6PR12MB5444.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Mar 2022 07:00:42.0895
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aJTFn0eUmP+nZOKpMXM6dfaaUBd97p4BqVQ0gMg/a/fOj9X2hW8gpXOOTpgU/O3jngGzny0wS+E+dAIRXd2/fg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4020
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Please update the subject to be something like ...

"dt-bindings: Document Tegra CCPLEX Cluster"

On 30/03/2022 15:38, Sumit Gupta wrote:
> The Tegra CCPLEX_CLUSTER area contains memory-mapped

Here you have CCPLEX_CLUSTER and ...

> registers that initiate CPU frequency/voltage transitions.
> 
> Signed-off-by: Sumit Gupta <sumitg@nvidia.com>
> ---
>   .../tegra/nvidia,tegra-ccplex-cluster.yaml    | 52 +++++++++++++++++++
>   1 file changed, 52 insertions(+)
>   create mode 100644 Documentation/devicetree/bindings/arm/tegra/nvidia,tegra-ccplex-cluster.yaml
> 
> diff --git a/Documentation/devicetree/bindings/arm/tegra/nvidia,tegra-ccplex-cluster.yaml b/Documentation/devicetree/bindings/arm/tegra/nvidia,tegra-ccplex-cluster.yaml
> new file mode 100644
> index 000000000000..74afa06f695e
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/arm/tegra/nvidia,tegra-ccplex-cluster.yaml
> @@ -0,0 +1,52 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: "http://devicetree.org/schemas/arm/tegra/nvidia,tegra-ccplex-cluster.yaml#"
> +$schema: "http://devicetree.org/meta-schemas/core.yaml#"
> +
> +title: NVIDIA Tegra CPU_CLUSTER area device tree bindings

... here we have "CPU_CLUSTER" and ...

> +
> +maintainers:
> +  - Sumit Gupta <sumitg@nvidia.com>
> +  - Mikko Perttunen <mperttunen@nvidia.com>
> +  - Jon Hunter <jonathanh@nvidia.com>
> +  - Thierry Reding <thierry.reding@gmail.com>
> +
> +description: |+
> +  The Tegra CCPLEX_CLUSTER area contains memory-mapped

.. then we have CCPLEX_CLUSTER again. Let's have a consistent name such 
as 'CPU COMPLEX CLUSTER' (admittedly a mouthful but that is what is 
means). I don't think we need the '_' in the name.

> +  registers that initiate CPU frequency/voltage transitions.
> +
> +properties:
> +  $nodename:
> +    pattern: "ccplex@([0-9a-f]+)$"
> +
> +  compatible:
> +    enum:
> +      - nvidia,tegra186-ccplex-cluster
> +      - nvidia,tegra234-ccplex-cluster
> +
> +  reg:
> +    maxItems: 1
> +
> +  nvidia,bpmp:
> +    $ref: '/schemas/types.yaml#/definitions/phandle'
> +    description: |
> +      Specifies the bpmp node that needs to be queried to get

s/bpmp/BPMP

> +      operating point data for all CPUs.
> +
> +additionalProperties: true
> +
> +required:
> +  - compatible
> +  - reg
> +  - nvidia,bpmp
> +  - status
> +
> +examples:
> +  - |
> +    ccplex@e000000 {
> +      compatible = "nvidia,tegra234-ccplex-cluster";
> +      reg = <0x0 0x0e000000 0x0 0x5ffff>;
> +      nvidia,bpmp = <&bpmp>;
> +      status = "okay";
> +    };

-- 
nvpublic
