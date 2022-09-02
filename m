Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 244C85AA405
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Sep 2022 02:04:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234765AbiIBAEX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 20:04:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230151AbiIBAEU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 20:04:20 -0400
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam07on2064.outbound.protection.outlook.com [40.107.212.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A38266F257;
        Thu,  1 Sep 2022 17:04:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CtQud74uHem+YitKNlohE14kDPVkim3e2Flf5BCbp+35se5vgNlSs7WfF6tDtYkRo+6ForSgLSJUiEh17FkGQHCDfLBHl/AUHMCt4SChWAVTdz3dWo3NSt/eM9U/3KMdVajVLr1WbFK98ngazrxfrmw98mvEbIFXTJn0Je+r2sZRrdPPNkxP2zhw5jReK/DbOcJGDM1fEhPt8cHT9Kbp93ppZz4+/MIrPK4ED4juARHE67dWv0qz8FMtC11BoX7KSQV1b9bOroXGA0M5mfTV3bMr2aIO0Q4qJyG3SJldtxA5G8tVooewikrYBYUn0HIPS8IItHGw5UxnCdv2ZF+E8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bvWmrL1/LijJLe6wjhEkqiH7KQU3uOpbAqNQqMlBvlU=;
 b=f2+szye6m5VjykIpac4mO1jFKnfCPIOfIiB7r0dRrrkOc4A5aFG14BhDAJmMi0wlVjBDppgCkjOa5jOVpuclntF7JHN+WitW2E+qXx60VUin4pKjfrFX2Nfk20RSZGIYaBB4of4ZIiEMmnqmYipblVCHXDr97HZd9EIMtCuGc+VvVsVVt4yTxEeHNkaDNvg8mIoZS0BBUI2MS+Zlp5n0KIncb4ECt7H+EyIiqiHn95yOWx3Eofku43QH2EiU7OyHnB7t9UOM5mUCGdcJgHM+8qpHnaPZZ8VCu5jjcJ2Rr0mptlTP60Wcs6Wibs6r/c0I1DlG4qyvqoTk5fLrTmgsyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bvWmrL1/LijJLe6wjhEkqiH7KQU3uOpbAqNQqMlBvlU=;
 b=bk96MykrnZhpFhy0eVNxHta/9rZzGPErGvFKgCJek2wfPb5p34r34LZVHWpM9YP9QFsGvnWlLzo2SYkT5BQYGUE9uqOHX4MS++/rRpN7Q6ZEg5RUW2CRUVJCoUTawOJhrl30bcf4g3kO/k37iNtlurT+1VuPn+X38Gw+/wXJiYI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BY5PR12MB3683.namprd12.prod.outlook.com (2603:10b6:a03:1a5::16)
 by BY5PR12MB4065.namprd12.prod.outlook.com (2603:10b6:a03:202::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.10; Fri, 2 Sep
 2022 00:04:12 +0000
Received: from BY5PR12MB3683.namprd12.prod.outlook.com
 ([fe80::3441:5a68:b4b7:e988]) by BY5PR12MB3683.namprd12.prod.outlook.com
 ([fe80::3441:5a68:b4b7:e988%6]) with mapi id 15.20.5566.021; Fri, 2 Sep 2022
 00:04:12 +0000
Message-ID: <bd7a8e2c-0d9f-fed5-4a5c-920817adbad2@amd.com>
Date:   Thu, 1 Sep 2022 17:04:07 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.13.0
Subject: Re: [PATCH v9 6/6] drivers: remoteproc: Add Xilinx r5 remoteproc
 driver
Content-Language: en-US
To:     Mathieu Poirier <mathieu.poirier@linaro.org>,
        Tanmay Shah <tanmay.shah@amd.com>
Cc:     bjorn.andersson@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, michal.simek@xilinx.com,
        ben.levinsky@xilinx.com, tanmay.shah@xilinx.com,
        michal.simek@amd.com, linux-remoteproc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <20220708013955.2340449-1-tanmay.shah@amd.com>
 <20220708013955.2340449-7-tanmay.shah@amd.com> <20220901202517.GB626605@p14s>
From:   Tanmay Shah <tanmays@amd.com>
In-Reply-To: <20220901202517.GB626605@p14s>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BY5PR20CA0033.namprd20.prod.outlook.com
 (2603:10b6:a03:1f4::46) To BY5PR12MB3683.namprd12.prod.outlook.com
 (2603:10b6:a03:1a5::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9fc42843-b0db-482a-a2ca-08da8c76aa7d
X-MS-TrafficTypeDiagnostic: BY5PR12MB4065:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ARrZpB6fD5cfy6Paapwzus2w11BNpqNy2Ypz85eC/HcZbse4e91+BAoBWxx4S4dRZF/gPK2oReubjT4A/I958p7okj1rbHQc7BC2KXdWG4V67/8XUSkbXLZmwWrgTsT7pA1FrYEITSENLI2ams0A7meXBprSUJoVt7KYlro3eSqISsHftpO8xE6CYfWYCkff8rQKKD7dKcD+crSBzZHHWCE4LSvCrf5BwXdKEd5jrs2H0NHkgwaWABgnk5WlPPaLjelYmJLEBPe8JB7uiSWRAZdaifoyha9qRjfqEb3DqwXUZ3nzzr6jM/02/TZvd3lhPMnelMiqgl+xbU/R+bt1cQTgEUzt76/WtgT8X07faI0yKXuPZgrLTXkJlXt/I0DFhw85WUqt84sYBlYEzOPWy2ZcTCMQJ+oxAZ8R2x9plL91qg4jut97j+tel5SYFpk3gpuP77M+JbgWIWgtoxD6mwQVw3sFmpR/UkzOfmPuuBCjsslzhgysp5y9xpS/e7aQBHX/iq42EejmGnCj7inhH87SQ/4HzBGWo4DPxfNJQqxF12c+WInRe0J0wWaVG0aDTu6w120ML40RrLDgkcRKcw+g1hdKmLS5Hn0XyRUUYuKrG2WfSY+0+J1hW7jjNIVt1JBDQOPq8+jeooESuCgaek75yx8sWAFh4oXw+3/dpDFc5S+0H4ggsaxGYyOpaltjevvUeGpjWuZ2fAmgLNpdYlHkM1JYfvSRYtd+KZWW7oagVAb2m7xkrNVibZU56K6cBq+OIkjMgCzoAyex1/Shtok2J30BDgnXvjaWd5JRUPw=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB3683.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(366004)(346002)(396003)(376002)(39860400002)(136003)(31696002)(316002)(38100700002)(26005)(6636002)(2616005)(30864003)(8936002)(2906002)(8676002)(66556008)(5660300002)(66946007)(4326008)(66476007)(186003)(110136005)(6486002)(83380400001)(6512007)(41300700001)(6666004)(478600001)(36756003)(6506007)(53546011)(31686004)(43740500002)(45980500001)(579004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VWZYdENidEF3ME95MjYwVDRtMU1LZmhsMk9Yci81Wm4yK2Vmb0ZGQk1qYzBP?=
 =?utf-8?B?M29XS1BSWCs5U2E4YUQwc3BFQ0FCU29ocVpER0JyUjAranRFTmh4ajFUOUUz?=
 =?utf-8?B?NzJDMjdXbWNocWZnZVlvenRrOFNwU1RvZ3p0MlBVbDI1UmlMdUFYbUF1ZW8x?=
 =?utf-8?B?NXdqUmpTRlZpeFJJSDRsSjRyR2xDaXBHa1YyYWI2M2ZHMUJKUHVvaWo4bWt1?=
 =?utf-8?B?REVXY0dJc01XMFNaaXliSGNGNVNXczI5WExmL1NEdlcxR2lqNnVzUnpjTEw3?=
 =?utf-8?B?VUpCR0s0RytlSFFYeDNqY0R4ZWx4T1ZvZU9CNzNaME1vWTVXeDBPbmw1K1Zk?=
 =?utf-8?B?SnNURThucVFKL29tdldCZHpUNkFvazBubE9va0paTmVHQlJOblBVVlpXQkZX?=
 =?utf-8?B?ZG1tTCthRXBlcVBOaStHY2t1K2tKUi9EaFFPZVFMYStDZGpKWHNqSUFyL3hN?=
 =?utf-8?B?dG5Kb1B4VWxiTVlXTHdRcmc4S1ZqcUxpZDR6d2RBQU13NzBlQ1ZZTWJKRVFi?=
 =?utf-8?B?b0hUMkc4eERVZXkwSkpqbnhoY0hzdEZGVCtKeEV2dDFCMVh5d2d0Q0FRcnN2?=
 =?utf-8?B?UzZKYWJoaWI5ZmFHcDBTL1NNRWtjT1ZNTFV5aEorR21Xa0lYUlAzb0hncm1h?=
 =?utf-8?B?bWR4M1hqcGQ4R2JwMmp2d3BWZFIrQTJVZDErOUhjZW5FMlJ0TTlWOWZkV3Vv?=
 =?utf-8?B?bkdUK29hd2gvOEdCRTlkam4xa3lNdy82SkVNK3lGMmg5OFFUMm9nMXd4dE1i?=
 =?utf-8?B?WGhpb3BGbEt3QUlicU5BMWk4WkJjY1c2Rm0wQVNJNytVczhZSnlGeXg3NCsw?=
 =?utf-8?B?bDZJR1p5TTNrWmIyM053ekJpMzRSakprcVY0NjZDTGJoSVJnNEZrbUVXUnh4?=
 =?utf-8?B?N2VNanNISVl0NmhPaDJJaXdIUm5jOWVibFVKK282TTZITlc4TDRDNjNDU205?=
 =?utf-8?B?SzFNcE5kRnVJSnRrT055Uk5rMFVXODhST2tORmxIdkxxNDRwZjFNMFZwZjR4?=
 =?utf-8?B?eXBCQjNQZ2pGR25sZ2RRcDhCOUsvK1hwUEt3bUxaNzZKd3h6U2dqcGczQ1VX?=
 =?utf-8?B?cnN5QWZsZWxsQTJCTU1jQmZGNm16blJaSWh2NzFaTE03VlE2MjlHcEVBVkQv?=
 =?utf-8?B?K3VXRnBrY1ZIbTFFMU0yYmNjalV4WVBtK0QrQ0ZCaG41anBrVEhlYkRaT1Y4?=
 =?utf-8?B?S3orZFFzdDFndnlUYWJiWGQyc2pmcFZRMW1LRlF4OVYvd0VxWU1DN2lrUFY1?=
 =?utf-8?B?UTlFUGNKOW1aZjRLZnMvOGM0RFFxcExOczJjbXNpdm5BMzByODBPL3lveXpM?=
 =?utf-8?B?UU5UVE1ZdVBNR3drWk41MVUrQXlQQyt6NVI4TVVVRWtrcmdWTys3ekwzWlZt?=
 =?utf-8?B?RGp0ZGE3c05tSC9Udm5SSjR4MG9lMjJ6NTZNbWFtV0cvVHBJZUxMdzF0UXla?=
 =?utf-8?B?K2ZkcTV2djB5TzArak9HL25nRUpXRXh2RDJPWk1mMmlmTlBJbzFUeDB0M2Nm?=
 =?utf-8?B?UEQ1dms5TmhDR1BhUVh3elgrZ1BZVUtEWVFTTFFjdGc4MFZlLzZCRTZNc2xx?=
 =?utf-8?B?YzBDUzlqL2dhSW01ZXhZckpwbWlUWE9rMG4yTXMyaUpjdXVKdG5ZTDVjZXdq?=
 =?utf-8?B?R1EzMjlad20yNStLTVRBbHNwU3hiZklyVER3QkExUmd4R3ZmTWNWNVAxakNs?=
 =?utf-8?B?TUZSQ1JOZ1BHSjlQQXZYZ0RuelA4ODExSDRZNzNYM09GUmVrZUo3amJoeFh2?=
 =?utf-8?B?S2E3MnI4dVc5WWRTNUVZRzdVdUFZZm15VEZIZzdRdTdrdVFLWC9UQUxiZ2tv?=
 =?utf-8?B?WTZZUjNoMlZXMHp3K1lJSS9mNExacTlGa3lCcE1uTlBjQytWamZSNTUyS2Rz?=
 =?utf-8?B?aHV5MGt6QU1FKzROK3N1M1BpTUhPcXoyQmxjMW1TM1dXRnc5N25DLytEdFZD?=
 =?utf-8?B?cThYNHlmTXV6cVYrWkhxdVBNSllGS1V4RVdRQStqV1ZlUC9PNXR2SjRMeTZv?=
 =?utf-8?B?Z3dBQ0RDTE9JQ1hLU2o5dmJnRDh6dEg4WWNjMzhXKzZIcWlSaUZ3QlNQcEg3?=
 =?utf-8?B?Z3o3SEVqZ3NLZ3VESlUvdFpPL1dzbHo1ZEJOdlZJUCtRZzZKcFE3ejR1NVlo?=
 =?utf-8?Q?hpV0rg9nU9W5Bu9swZZnFwfU/?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9fc42843-b0db-482a-a2ca-08da8c76aa7d
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB3683.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2022 00:04:12.3236
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VajcL5lU2A7NFVYX23dXDCpq99nLyonNYz9b+sVkQMkar+aPHXqxV9bSDzJ5rPT2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4065
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mathieu,

Thanks for reviews. Please find my comments below.

On 9/1/22 1:25 PM, Mathieu Poirier wrote:
> On Thu, Jul 07, 2022 at 06:39:55PM -0700, Tanmay Shah wrote:
>> From: Tanmay Shah <tanmay.shah@xilinx.com>
>>
>> This driver enables r5f dual core Real time Processing Unit subsystem
>> available on Xilinx Zynq Ultrascale MPSoC Platform. RPU subsystem
>> (cluster) can be configured in different modes e.g. split mode in which
>> two r5f cores work independent of each other and lock-step mode in which
>> both r5f cores execute same code clock-for-clock and notify if the
>> result is different.
>>
>> The Xilinx r5 Remoteproc Driver boots the RPU cores via calls to the Xilinx
>> Platform Management Unit that handles the R5 configuration, memory access
>> and R5 lifecycle management. The interface to this manager is done in this
>> driver via zynqmp_pm_* function calls.
>>
>> Signed-off-by: Ben Levinsky <ben.levinsky@xilinx.com>
>> Signed-off-by: Tanmay Shah <tanmay.shah@xilinx.com>
>> Signed-off-by: Tanmay Shah <tanmay.shah@amd.com>
>> ---
>>
>> Changes in v9
>>    - replace devm_rproc_alloc with rproc_alloc
>>    - %s/until/while/r
>>    - remove extra line
>>    - %s/i > -1/i >=0/r fix this throughout the driver
>>    - fix type of tcm_mode from int to enum rpu_tcm_comb
>>    - release &child_pdev->dev references in case of failure
>>    - remove zynqmp_r5_core_exit()
>>    - undefined memory-region property isn't driver failure
>>    - remove tcm bank count check from ops
>>    - fix tcm bank turn-off sequence
>>    - fix parse_fw function documentation
>>    - do not use rproc_mem_entry_init on vdev0buffers
>>    - declare variabls in reverse xmas tree order throughout    the driver
>>
>> Changes in v8:
>>    - None
>>
>> Changes in v7:
>>    - None
>>
>> Changes in v6:
>>    - None
>>
>> Changes in v5:
>>    - None
>>
>> Changes in v4:
>>    - Remove redundant header files
>>    - use dev_err_probe() to report errors during probe
>>    - Fix missing check on error code returned by zynqmp_r5_add_rproc_core()
>>    - Fix memory leaks all over the driver when resource allocation fails for any core
>>    - make cluster mode check only at one place
>>    - remove redundant initialization of variable
>>    - remove redundant use of of_node_put()
>>    - Fix Comment format problem
>>    - Assign offset of zynqmp_tcm_banks instead of duplicating it
>>    - Add tcm and memory regions rproc carveouts during prepare instead of parse_fw
>>    - Remove rproc_mem_entry object from r5_core
>>    - Use put_device() and rproc_del() APIs to fix memory leaks
>>    - Replace pr_* with dev_*. This was missed in v3, fix now.
>>    - Use "GPL" instead of "GPL v2" in MODULE_LICENSE macro. This was suggested by checkpatch script.
>>
>> Changes in v3:
>>    - Fix checkpatch script indentation warning
>>    - Remove unused variable from xilinx remoteproc driver
>>    - use C style comments, i.e /*...*/
>>    - Remove redundant debug information which can be derived using /proc/device-tree
>>    - Fix multilined comment format
>>    - s/"final fot TCM"/"final for TCM"
>>    - Function devm_kzalloc() does not return an code on error, just NULL.
>>      Remove redundant error check for this function throughout the driver.
>>    - Fix RPU mode configuration and add documentation accordingly
>>    - Get rid of the indentations to match function documentation style with rest of the driver
>>    - Fix memory leak by only using r5_rproc->priv and not replace it with new instance
>>    - Use 'i' for the outer loop and 'j' for the inner one as per convention
>>    - Remove redundant error and NULL checks throughout the driver
>>    - Use devm_kcalloc() when more than one element is required
>>    - Add memory-regions carveouts during driver probe instead of parse_fw call
>>      This removes redundant copy of reserved_mem object in r5_core structure.
>>    - Fix memory leak by using of_node_put()
>>    - Fix indentation of tcm_mem_map function args
>>    - Remove redundant init of variables
>>    - Initialize tcm bank size variable for lockstep mode
>>    - Replace u32 with phys_addr_t for variable stroing memory bank address
>>    - Add documentation of TCM behavior in lockstep mode
>>    - Use dev_get_drvdata instead of platform driver API
>>    - Remove info level messages
>>    - Fix checkpatch.pl warnings
>>    - Add documentation for the Xilinx r5f platform to understand driver design
>>   drivers/remoteproc/Kconfig              |   12 +
>>   drivers/remoteproc/Makefile             |    1 +
>>   drivers/remoteproc/xlnx_r5_remoteproc.c | 1055 +++++++++++++++++++++++
>>   3 files changed, 1068 insertions(+)
>>   create mode 100644 drivers/remoteproc/xlnx_r5_remoteproc.c
>>
>> diff --git a/drivers/remoteproc/Kconfig b/drivers/remoteproc/Kconfig
>> index 166019786653..5637a71c0677 100644
>> --- a/drivers/remoteproc/Kconfig
>> +++ b/drivers/remoteproc/Kconfig
>> @@ -352,6 +352,18 @@ config TI_K3_R5_REMOTEPROC
>>   	  It's safe to say N here if you're not interested in utilizing
>>   	  a slave processor.
>>   
>> +config XLNX_R5_REMOTEPROC
>> +	tristate "Xilinx R5 remoteproc support"
>> +	depends on PM && ARCH_ZYNQMP
>> +	depends on ZYNQMP_FIRMWARE
>> +	select RPMSG_VIRTIO
>> +	select ZYNQMP_IPI_MBOX
>> +	help
>> +	  Say y or m here to support Xilinx R5 remote processors via the remote
>> +	  processor framework.
>> +
>> +	  It's safe to say N if not interested in using RPU r5f cores.
>> +
>>   endif # REMOTEPROC
>>   
>>   endmenu
>> diff --git a/drivers/remoteproc/Makefile b/drivers/remoteproc/Makefile
>> index 5478c7cb9e07..91314a9b43ce 100644
>> --- a/drivers/remoteproc/Makefile
>> +++ b/drivers/remoteproc/Makefile
>> @@ -38,3 +38,4 @@ obj-$(CONFIG_ST_SLIM_REMOTEPROC)	+= st_slim_rproc.o
>>   obj-$(CONFIG_STM32_RPROC)		+= stm32_rproc.o
>>   obj-$(CONFIG_TI_K3_DSP_REMOTEPROC)	+= ti_k3_dsp_remoteproc.o
>>   obj-$(CONFIG_TI_K3_R5_REMOTEPROC)	+= ti_k3_r5_remoteproc.o
>> +obj-$(CONFIG_XLNX_R5_REMOTEPROC)	+= xlnx_r5_remoteproc.o
>> diff --git a/drivers/remoteproc/xlnx_r5_remoteproc.c b/drivers/remoteproc/xlnx_r5_remoteproc.c
>> new file mode 100644
>> index 000000000000..9865b51e0356
>> --- /dev/null
>> +++ b/drivers/remoteproc/xlnx_r5_remoteproc.c
>> @@ -0,0 +1,1055 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/*
>> + * ZynqMP R5 Remote Processor driver
>> + *
>> + */
>> +
>> +#include <dt-bindings/power/xlnx-zynqmp-power.h>
>> +#include <linux/dma-mapping.h>
>> +#include <linux/firmware/xlnx-zynqmp.h>
>> +#include <linux/kernel.h>
>> +#include <linux/module.h>
>> +#include <linux/of_address.h>
>> +#include <linux/of_platform.h>
>> +#include <linux/of_reserved_mem.h>
>> +#include <linux/platform_device.h>
>> +#include <linux/remoteproc.h>
>> +#include <linux/slab.h>
>> +
>> +#include "remoteproc_internal.h"
>> +
>> +/* settings for RPU cluster mode */
>> +enum zynqmp_r5_cluster_mode {
>> +	SPLIT_MODE = 0, /* When cores run as separate processor */
>> +	LOCKSTEP_MODE = 1, /* cores execute same code in lockstep,clk-for-clk */
>> +	SINGLE_CPU_MODE = 2, /* core0 is held in reset and only core1 runs */
>> +};
>> +
>> +/**
>> + * struct mem_bank_data - Memory Bank description
>> + *
>> + * @addr: Start address of memory bank
>> + * @size: Size of Memory bank
>> + * @pm_domain_id: Power-domains id of memory bank for firmware to turn on/off
>> + * @bank_name: name of the bank for remoteproc framework
>> + */
>> +struct mem_bank_data {
>> +	phys_addr_t addr;
>> +	size_t size;
>> +	u32 pm_domain_id;
>> +	char *bank_name;
>> +};
>> +
>> +static const struct mem_bank_data zynqmp_tcm_banks[] = {
>> +	{0xffe00000UL, 0x10000UL, PD_R5_0_ATCM, "atcm0"}, /* TCM 64KB each */
>> +	{0xffe20000UL, 0x10000UL, PD_R5_0_BTCM, "btcm0"},
>> +	{0xffe90000UL, 0x10000UL, PD_R5_1_ATCM, "atcm1"},
>> +	{0xffeb0000UL, 0x10000UL, PD_R5_1_BTCM, "btcm1"},
>> +};
>> +
>> +/**
>> + * struct zynqmp_r5_core - ZynqMP R5 core structure
>> + *
>> + * @dev: device of RPU instance
>> + * @np: device node of RPU instance
>> + * @tcm_bank_count: number TCM banks accessible to this RPU
>> + * @tcm_banks: array of each TCM bank data
>> + * @rmem_count: Number of reserved mem regions
>> + * @rmem: reserved memory region nodes from device tree
>> + * @rproc: rproc handle
>> + * @pm_domain_id: RPU CPU power domain id
>> + */
>> +struct zynqmp_r5_core {
>> +	struct device *dev;
>> +	struct device_node *np;
>> +	int tcm_bank_count;
>> +	struct mem_bank_data **tcm_banks;
>> +	int rmem_count;
>> +	struct reserved_mem **rmem;
>> +	struct rproc *rproc;
>> +	u32 pm_domain_id;
>> +};
>> +
>> +/**
>> + * struct zynqmp_r5_cluster - ZynqMP R5 cluster structure
>> + *
>> + * @dev: r5f subsystem cluster device node
>> + * @mode: cluster mode of type zynqmp_r5_cluster_mode
>> + * @core_count: number of r5 cores used for this cluster mode
>> + * @r5_cores: Array of pointers pointing to r5 core
>> + */
>> +struct zynqmp_r5_cluster {
>> +	struct device *dev;
>> +	enum  zynqmp_r5_cluster_mode mode;
>> +	int core_count;
>> +	struct zynqmp_r5_core **r5_cores;
>> +};
>> +
>> +/*
>> + * zynqmp_r5_set_mode - set RPU operation mode
>> + *
>> + * set RPU operation mode
>> + *
>> + * Return: 0 for success, negative value for failure
>> + */
>> +static int zynqmp_r5_set_mode(struct zynqmp_r5_core *r5_core,
>> +			      enum rpu_oper_mode fw_reg_val,
>> +			      enum rpu_tcm_comb tcm_mode)
>> +{
>> +	int ret;
>> +
>> +	ret = zynqmp_pm_set_rpu_mode(r5_core->pm_domain_id, fw_reg_val);
>> +	if (ret < 0) {
>> +		dev_err(r5_core->dev, "failed to set RPU mode\n");
>> +		return ret;
>> +	}
>> +
>> +	ret = zynqmp_pm_set_tcm_config(r5_core->pm_domain_id, tcm_mode);
>> +	if (ret < 0)
>> +		dev_err(r5_core->dev, "failed to configure TCM\n");
>> +
>> +	return ret;
>> +}
>> +
>> +/*
>> + * zynqmp_r5_rproc_start
>> + * @rproc: single R5 core's corresponding rproc instance
>> + *
>> + * Start R5 Core from designated boot address.
>> + *
>> + * return 0 on success, otherwise non-zero value on failure
>> + */
>> +static int zynqmp_r5_rproc_start(struct rproc *rproc)
>> +{
>> +	struct zynqmp_r5_core *r5_core = rproc->priv;
>> +	enum rpu_boot_mem bootmem;
>> +	int ret;
>> +
>> +	/*
>> +	 * The exception vector pointers (EVP) refer to the base-address of
>> +	 * exception vectors (for reset, IRQ, FIQ, etc). The reset-vector
>> +	 * starts at the base-address and subsequent vectors are on 4-byte
>> +	 * boundaries.
>> +	 *
>> +	 * Exception vectors can start either from 0x0000_0000 (LOVEC) or
>> +	 * from 0xFFFF_0000 (HIVEC) which is mapped in the OCM (On-Chip Memory)
>> +	 *
>> +	 * Usually firmware will put Exception vectors at LOVEC.
>> +	 *
>> +	 * It is not recommend that you change the exception vector.
>> +	 * Changing the EVP to HIVEC will result in increased interrupt latency
>> +	 * and jitter. Also, if the OCM is secured and the Cortex-R5F processor
>> +	 * is non-secured, then the Cortex-R5F processor cannot access the
>> +	 * HIVEC exception vectors in the OCM.
>> +	 */
>> +	bootmem = (rproc->bootaddr >= 0xFFFC0000) ?
>> +		   PM_RPU_BOOTMEM_HIVEC : PM_RPU_BOOTMEM_LOVEC;
>> +
>> +	dev_dbg(r5_core->dev, "RPU boot addr 0x%llx from %s.", rproc->bootaddr,
>> +		bootmem == PM_RPU_BOOTMEM_HIVEC ? "OCM" : "TCM");
>> +
>> +	ret = zynqmp_pm_request_wake(r5_core->pm_domain_id, 1,
>> +				     bootmem, ZYNQMP_PM_REQUEST_ACK_NO);
>> +	if (ret)
>> +		dev_err(r5_core->dev,
>> +			"failed to start RPU = 0x%x\n", r5_core->pm_domain_id);
>> +	return ret;
>> +}
>> +
>> +/*
>> + * zynqmp_r5_rproc_stop
>> + * @rproc: single R5 core's corresponding rproc instance
>> + *
>> + * Power down  R5 Core.
>> + *
>> + * return 0 on success, otherwise non-zero value on failure
>> + */
>> +static int zynqmp_r5_rproc_stop(struct rproc *rproc)
>> +{
>> +	struct zynqmp_r5_core *r5_core = rproc->priv;
>> +	int ret;
>> +
>> +	ret = zynqmp_pm_force_pwrdwn(r5_core->pm_domain_id,
>> +				     ZYNQMP_PM_REQUEST_ACK_BLOCKING);
>> +	if (ret)
>> +		dev_err(r5_core->dev, "failed to stop remoteproc RPU %d\n", ret);
>> +
>> +	return ret;
>> +}
>> +
>> +/*
>> + * zynqmp_r5_mem_region_map
>> + * @rproc: single R5 core's corresponding rproc instance
>> + * @mem: mem entry to map
>> + *
>> + * Callback to map va for memory-region's carveout.
>> + *
>> + * return 0 on success, otherwise non-zero value on failure
>> + */
>> +static int zynqmp_r5_mem_region_map(struct rproc *rproc,
>> +				    struct rproc_mem_entry *mem)
>> +{
>> +	void __iomem *va;
>> +
>> +	va = ioremap_wc(mem->dma, mem->len);
>> +	if (IS_ERR_OR_NULL(va))
>> +		return -ENOMEM;
>> +
>> +	mem->va = (void *)va;
>> +
>> +	return 0;
>> +}
>> +
>> +/*
>> + * zynqmp_r5_rproc_mem_unmap
>> + * @rproc: single R5 core's corresponding rproc instance
>> + * @mem: mem entry to unmap
>> + *
>> + * Unmap memory-region carveout
>> + *
>> + * return 0 on success, otherwise non-zero value on failure
>> + */
>> +static int zynqmp_r5_mem_region_unmap(struct rproc *rproc,
>> +				      struct rproc_mem_entry *mem)
>> +{
>> +	iounmap((void __iomem *)mem->va);
>> +	return 0;
>> +}
>> +
>> +/*
>> + * add_mem_regions
>> + * @r5_core: single R5 core's corresponding zynqmp_r5_core type instance
>> + * @rmem: reserved mem region parsed from dt node
>> + *
>> + * Construct rproc mem carveouts from carveout provided in
>> + * memory-region property
>> + *
>> + * return 0 on success, otherwise non-zero value on failure
>> + */
>> +static int add_mem_regions_carveout(struct rproc *rproc)
>> +{
>> +	struct rproc_mem_entry **rproc_mem;
>> +	struct zynqmp_r5_core *r5_core;
>> +	struct reserved_mem *rmem;
>> +	int i, num_mem_regions;
>> +
>> +	r5_core = (struct zynqmp_r5_core *)rproc->priv;
>> +	num_mem_regions = r5_core->rmem_count;
>> +
>> +	/* memory regions not defined */
>> +	if (num_mem_regions < 1)
>> +		return 0;
>> +
>> +	rproc_mem = kcalloc(num_mem_regions,
>> +			    sizeof(struct rproc_mem_entry *), GFP_KERNEL);
>> +	if (!rproc_mem)
>> +		return -ENOMEM;
>> +
>> +	for (i = 0; i < num_mem_regions; i++) {
>> +		rmem = r5_core->rmem[i];
>> +
>> +		if (!strncmp(rmem->name, "vdev0buffer", strlen("vdev0buffer"))) {
>> +			/* Register reserved memory for vdev buffer */
>> +			rproc_mem[i] = rproc_of_resm_mem_entry_init(&rproc->dev, i,
>> +								    rmem->size,
>> +								    rmem->base,
>> +								    rmem->name);
>> +		} else {
>> +			/* Register associated reserved memory regions */
>> +			rproc_mem[i] = rproc_mem_entry_init(&rproc->dev, NULL,
>> +							    (dma_addr_t)rmem->base,
>> +							    rmem->size, rmem->base,
>> +							    zynqmp_r5_mem_region_map,
>> +							    zynqmp_r5_mem_region_unmap,
>> +							    rmem->name);
>> +		}
>> +
>> +		if (!rproc_mem[i])
>> +			goto release_mem_regions;
>> +
>> +		dev_dbg(&rproc->dev, "reserved mem carveout %s addr=%llx, size=0x%llx",
>> +			rmem->name, rmem->base, rmem->size);
>> +	}
>> +
>> +	/*
>> +	 * Add carveouts only if all rproc mem enties are
>> +	 * successfully initialized
>> +	 */
>> +	for (i = 0; i < num_mem_regions; i++)
>> +		rproc_add_carveout(rproc, rproc_mem[i]);
>> +
>> +	kfree(rproc_mem);
>> +	return 0;
>> +
>> +release_mem_regions:
>> +	for (i--; i >= 0; i--)
>> +		kfree(rproc_mem[i]);
>> +	kfree(rproc_mem);
>> +	return -ENOMEM;
>> +}
>> +
>> +/*
>> + * zynqmp_r5_rproc_mem_unmap
>> + * @rproc: single R5 core's corresponding rproc instance
>> + * @mem: mem entry to unmap
>> + *
>> + * Unmap TCM banks when powering down R5 core.
>> + *
>> + * return 0 on success, otherwise non-zero value on failure
>> + */
>> +static int tcm_mem_unmap(struct rproc *rproc, struct rproc_mem_entry *mem)
>> +{
>> +	iounmap((void __iomem *)mem->va);
>> +
>> +	return 0;
>> +}
>> +
>> +/*
>> + * tcm_mem_map
>> + * @rproc: single R5 core's corresponding rproc instance
>> + * @mem: mem entry to initialize the va and da fields of
>> + *
>> + * Given TCM bank entry, this callback will set device address for R5
>> + * running on TCM and also setup virtual address for TCM bank
>> + * remoteproc carveout.
>> + *
>> + * return 0 on success, otherwise non-zero value on failure
>> + */
>> +static int tcm_mem_map(struct rproc *rproc,
>> +		       struct rproc_mem_entry *mem)
>> +{
>> +	void __iomem *va;
>> +
>> +	va = ioremap_wc(mem->dma, mem->len);
>> +	if (IS_ERR_OR_NULL(va))
>> +		return -ENOMEM;
>> +
>> +	/* Update memory entry va */
>> +	mem->va = (void *)va;
>> +
>> +	/* clear TCMs */
>> +	memset_io(va, 0, mem->len);
>> +
>> +	/*
>> +	 * The R5s expect their TCM banks to be at address 0x0 and 0x2000,
>> +	 * while on the Linux side they are at 0xffexxxxx.
>> +	 *
>> +	 * Zero out the high 12 bits of the address. This will give
>> +	 * expected values for TCM Banks 0A and 0B (0x0 and 0x20000).
>> +	 */
>> +	mem->da &= 0x000fffff;
>> +
>> +	/*
>> +	 * TCM Banks 1A and 1B still have to be translated.
>> +	 *
>> +	 * Below handle these two banks' absolute addresses (0xffe90000 and
>> +	 * 0xffeb0000) and convert to the expected relative addresses
>> +	 * (0x0 and 0x20000).
>> +	 */
>> +	if (mem->da == 0x90000 || mem->da == 0xB0000)
>> +		mem->da -= 0x90000;
>> +
>> +	/* if translated TCM bank address is not valid report error */
>> +	if (mem->da != 0x0 && mem->da != 0x20000) {
>> +		dev_err(&rproc->dev, "invalid TCM address: %x\n", mem->da);
>> +		return -EINVAL;
>> +	}
>> +	return 0;
>> +}
>> +
>> +static int add_tcm_carveout_split_mode(struct rproc *rproc)
>> +{
>> +	struct rproc_mem_entry **rproc_mem;
>> +	struct zynqmp_r5_core *r5_core;
>> +	int i, num_banks, ret;
>> +	phys_addr_t bank_addr;
>> +	struct device *dev;
>> +	u32 pm_domain_id;
>> +	size_t bank_size;
>> +	char *bank_name;
>> +
>> +	r5_core = (struct zynqmp_r5_core *)rproc->priv;
>> +	dev = r5_core->dev;
>> +	num_banks = r5_core->tcm_bank_count;
>> +
>> +	rproc_mem = kcalloc(num_banks,
>> +			    sizeof(struct rproc_mem_entry *), GFP_KERNEL);
>> +	if (!rproc_mem)
>> +		return -ENOMEM;
>> +
>> +	/*
>> +	 * Power-on Each 64KB TCM,
>> +	 * register its address space, map and unmap functions
>> +	 * and add carveouts accordingly
>> +	 */
>> +	for (i = 0; i < num_banks; i++) {
>> +		bank_addr = r5_core->tcm_banks[i]->addr;
>> +		bank_name = r5_core->tcm_banks[i]->bank_name;
>> +		bank_size = r5_core->tcm_banks[i]->size;
>> +		pm_domain_id = r5_core->tcm_banks[i]->pm_domain_id;
>> +
>> +		ret = zynqmp_pm_request_node(pm_domain_id,
>> +					     ZYNQMP_PM_CAPABILITY_ACCESS, 0,
>> +					     ZYNQMP_PM_REQUEST_ACK_BLOCKING);
>> +		if (ret < 0) {
>> +			dev_err(dev, "failed to turn on TCM 0x%x", pm_domain_id);
>> +			goto release_tcm_split;
>> +		}
>> +
>> +		dev_dbg(dev, "TCM carveout split mode %s addr=%llx, size=0x%lx",
>> +			bank_name, bank_addr, bank_size);
>> +
>> +		rproc_mem[i] = rproc_mem_entry_init(dev, NULL, bank_addr,
>> +						    bank_size, bank_addr,
>> +						    tcm_mem_map, tcm_mem_unmap,
>> +						    bank_name);
>> +		if (!rproc_mem[i]) {
>> +			ret = -ENOMEM;
>> +			zynqmp_pm_release_node(pm_domain_id);
>> +			goto release_tcm_split;
>> +		}
>> +	}
>> +
>> +	/*
>> +	 * Add carveouts only if all rproc mem enties are
>> +	 * successfully initialized
>> +	 */
>> +	for (i = 0; i < num_banks; i++)
>> +		rproc_add_carveout(rproc, rproc_mem[i]);
>> +
>> +	kfree(rproc_mem);
>> +	return 0;
>> +
>> +release_tcm_split:
>> +	/* If failed, Turn off all TCM banks turned on before */
>> +	for (i--; i >= 0; i--) {
>> +		pm_domain_id = r5_core->tcm_banks[i]->pm_domain_id;
>> +		zynqmp_pm_release_node(pm_domain_id);
>> +		kfree(rproc_mem[i]);
>> +	}
>> +	kfree(rproc_mem);
>> +	return ret;
>> +}
>> +
>> +static int add_tcm_carveout_lockstep_mode(struct rproc *rproc)
>> +{
>> +	struct rproc_mem_entry *rproc_mem;
>> +	struct zynqmp_r5_core *r5_core;
>> +	int i, num_banks, ret;
>> +	phys_addr_t bank_addr;
>> +	size_t bank_size = 0;
>> +	struct device *dev;
>> +	u32 pm_domain_id;
>> +	char *bank_name;
>> +
>> +	r5_core = (struct zynqmp_r5_core *)rproc->priv;
>> +	dev = r5_core->dev;
>> +
>> +	/* Go through zynqmp banks for r5 node */
>> +	num_banks = r5_core->tcm_bank_count;
>> +
>> +	/*
>> +	 * In lockstep mode, TCM is contiguous memory block
>> +	 * However, each TCM block still needs to be enabled individually.
>> +	 * So, Enable each TCM block individually, but add their size
>> +	 * to create contiguous memory region.
>> +	 */
>> +	bank_addr = r5_core->tcm_banks[0]->addr;
>> +	bank_name = r5_core->tcm_banks[0]->bank_name;
>> +
>> +	for (i = 0; i < num_banks; i++) {
>> +		bank_size += r5_core->tcm_banks[i]->size;
>> +		pm_domain_id = r5_core->tcm_banks[i]->pm_domain_id;
>> +
>> +		/* Turn on each TCM bank individually */
>> +		ret = zynqmp_pm_request_node(pm_domain_id,
>> +					     ZYNQMP_PM_CAPABILITY_ACCESS, 0,
>> +					     ZYNQMP_PM_REQUEST_ACK_BLOCKING);
>> +		if (ret < 0) {
>> +			dev_err(dev, "failed to turn on TCM 0x%x", pm_domain_id);
>> +			goto release_tcm_lockstep;
>> +		}
>> +	}
>> +
>> +	dev_dbg(dev, "TCM add carveout lockstep mode %s addr=0x%llx, size=0x%lx",
>> +		bank_name, bank_addr, bank_size);
>> +
>> +	/* Register TCM address range, TCM map and unmap functions */
>> +	rproc_mem = rproc_mem_entry_init(dev, NULL, bank_addr,
>> +					 bank_size, bank_addr,
>> +					 tcm_mem_map, tcm_mem_unmap,
>> +					 bank_name);
>> +	if (!rproc_mem) {
>> +		ret = -ENOMEM;
>> +		goto release_tcm_lockstep;
>> +	}
>> +
>> +	/* If registration is success, add carveouts */
>> +	rproc_add_carveout(rproc, rproc_mem);
>> +
>> +	return 0;
>> +
>> +release_tcm_lockstep:
>> +	/* If failed, Turn off all TCM banks turned on before */
>> +	for (i--; i >= 0; i--) {
>> +		pm_domain_id = r5_core->tcm_banks[i]->pm_domain_id;
>> +		zynqmp_pm_release_node(pm_domain_id);
>> +	}
>> +	return ret;
>> +}
>> +
>> +/*
>> + * add_tcm_banks()
>> + * @rproc: single R5 core's corresponding rproc instance
>> + *
>> + * Given R5 node in remoteproc instance
>> + * allocate remoteproc carveout for TCM memory
>> + * needed for firmware to be loaded
>> + *
>> + * return 0 on success, otherwise non-zero value on failure
>> + */
>> +static int add_tcm_banks(struct rproc *rproc)
>> +{
>> +	struct zynqmp_r5_cluster *cluster;
>> +	struct zynqmp_r5_core *r5_core;
>> +	struct device *dev;
>> +
>> +	r5_core = (struct zynqmp_r5_core *)rproc->priv;
>> +	if (!r5_core)
>> +		return -EINVAL;
>> +
>> +	dev = r5_core->dev;
>> +
>> +	cluster = dev_get_drvdata(dev->parent);
>> +	if (!cluster) {
>> +		dev_err(dev->parent, "Invalid driver data\n");
>> +		return -EINVAL;
>> +	}
>> +
>> +	/*
>> +	 * In lockstep mode TCM banks are one contiguous memory region of 256Kb
>> +	 * In split mode, each TCM bank is 64Kb and not contiguous.
>> +	 * We add memory carveouts accordingly.
>> +	 */
>> +	if (cluster->mode == SPLIT_MODE)
>> +		return add_tcm_carveout_split_mode(rproc);
>> +	else if (cluster->mode == LOCKSTEP_MODE)
>> +		return add_tcm_carveout_lockstep_mode(rproc);
>> +
>> +	dev_err(cluster->dev, "invalid cluster mode\n");
>> +	return -EINVAL;
>> +}
>> +
>> +/*
>> + * zynqmp_r5_parse_fw()
>> + * @rproc: single R5 core's corresponding rproc instance
>> + * @fw: ptr to firmware to be loaded onto r5 core
>> + *
>> + * get resource table if available
>> + *
>> + * return 0 on success, otherwise non-zero value on failure
>> + */
>> +static int zynqmp_r5_parse_fw(struct rproc *rproc, const struct firmware *fw)
>> +{
>> +	int ret;
>> +
>> +	ret = rproc_elf_load_rsc_table(rproc, fw);
>> +	if (ret == -EINVAL) {
>> +		/*
>> +		 * resource table only required for IPC.
>> +		 * if not present, this is not necessarily an error;
>> +		 * for example, loading r5 hello world application
>> +		 * so simply inform user and keep going.
>> +		 */
>> +		dev_info(&rproc->dev, "no resource table found.\n");
>> +		ret = 0;
>> +	}
>> +	return ret;
>> +}
>> +
>> +static int zynqmp_r5_rproc_prepare(struct rproc *rproc)
>> +{
>> +	int ret;
>> +
>> +	ret = add_tcm_banks(rproc);
>> +	if (ret) {
>> +		dev_err(&rproc->dev, "failed to get TCM banks, err %d\n", ret);
>> +		return ret;
>> +	}
>> +
>> +	ret = add_mem_regions_carveout(rproc);
>> +	if (ret)
>> +		dev_warn(&rproc->dev, "failed to get reserve mem regions %d\n",
>> +			 ret);
>> +
>> +	return 0;
>> +}
>> +
>> +static int zynqmp_r5_rproc_unprepare(struct rproc *rproc)
>> +{
>> +	struct zynqmp_r5_core *r5_core;
>> +	u32 pm_domain_id;
>> +	int i;
>> +
>> +	r5_core = (struct zynqmp_r5_core *)rproc->priv;
>> +
>> +	for (i = 0; i < r5_core->tcm_bank_count; i++) {
>> +		pm_domain_id = r5_core->tcm_banks[i]->pm_domain_id;
>> +		if (zynqmp_pm_release_node(pm_domain_id))
>> +			dev_warn(r5_core->dev,
>> +				 "can't turn off TCM bank 0x%x", pm_domain_id);
>> +	}
>> +
>> +	return 0;
>> +}
>> +
>> +static const struct rproc_ops zynqmp_r5_rproc_ops = {
>> +	.prepare	= zynqmp_r5_rproc_prepare,
>> +	.unprepare	= zynqmp_r5_rproc_unprepare,
>> +	.start		= zynqmp_r5_rproc_start,
>> +	.stop		= zynqmp_r5_rproc_stop,
>> +	.load		= rproc_elf_load_segments,
>> +	.parse_fw	= zynqmp_r5_parse_fw,
>> +	.find_loaded_rsc_table = rproc_elf_find_loaded_rsc_table,
>> +	.sanity_check	= rproc_elf_sanity_check,
>> +	.get_boot_addr	= rproc_elf_get_boot_addr,
>> +};
>> +
>> +/**
>> + * zynqmp_r5_add_rproc_core()
>> + * Probes ZynqMP R5 processor device node
>> + * this is called for each individual R5 core
>> + *
>> + * @cdev: Device node of each r5 core
>> + *
>> + * Return: zynqmp_r5_core object for success, error pointer in case of error.
>> + */
>> +static struct zynqmp_r5_core *zynqmp_r5_add_rproc_core(struct device *cdev)
>> +{
>> +	struct zynqmp_r5_core *r5_core;
>> +	struct rproc *r5_rproc;
>> +	int ret;
>> +
>> +	/* Set up DMA mask */
>> +	ret = dma_set_coherent_mask(cdev, DMA_BIT_MASK(32));
>> +	if (ret)
>> +		return ERR_PTR(ret);
>> +
>> +	/* Allocate remoteproc instance */
>> +	r5_rproc = rproc_alloc(cdev, dev_name(cdev),
>> +			       &zynqmp_r5_rproc_ops,
>> +			       NULL, sizeof(struct zynqmp_r5_core));
>> +	if (!r5_rproc) {
>> +		dev_err(cdev, "failed to allocate memory for rproc instance\n");
>> +		return ERR_PTR(-ENOMEM);
>> +	}
>> +
>> +	r5_rproc->auto_boot = false;
>> +	r5_core = (struct zynqmp_r5_core *)r5_rproc->priv;
>> +	r5_core->dev = cdev;
>> +	r5_core->np = dev_of_node(cdev);
>> +	if (!r5_core->np) {
>> +		dev_err(cdev, "can't get device node for r5 core\n");
>> +		return ERR_PTR(-EINVAL);
> Here @r5_rproc is leaked and r5_rproc->rproc never free'ed.

This function is only used in cluster_init.

r5_rproc->rproc is free'ed in release_r5_core label in 
zynqmp_r5_cluster_init function if this function fails.

This avoids multiple free of same resource.

>
>> +	}
>> +
>> +	/* Add R5 remoteproc core */
>> +	ret = rproc_add(r5_rproc);
>> +	if (ret) {
>> +		dev_err(cdev, "failed to add r5 remoteproc\n");
>> +		return ERR_PTR(ret);
> Same.
Same as above.
>
>> +	}
>> +
>> +	r5_core->rproc = r5_rproc;
>> +	return r5_core;
>> +}
>> +
>> +/**
>> + * zynqmp_r5_get_tcm_node()
>> + * Ideally this function should parse tcm node and store information
>> + * in r5_core instance. We will use hardcoded TCM information from
>> + * driver for now in this function.
>> + *
> It would be a good idea to explain _why_ hardcoded values are used.
It is explained in function, but will add in description too.
>
>
>> + * @cluster: pointer to zynqmp_r5_cluster type object
>> + *
>> + * Return: 0 for success and error code for failure.
>> + */
>> +static int zynqmp_r5_get_tcm_node(struct zynqmp_r5_cluster *cluster)
>> +{
>> +	struct device *dev = cluster->dev;
>> +	struct zynqmp_r5_core *r5_core;
>> +	int tcm_bank_count, tcm_node;
>> +	int i, j;
>> +
>> +	/*
>> +	 * ToDo: Use predefined TCM address space values from driver while
> I'm not sure why there is a "ToDo" here since this is exactly what you are
> doing.
Ack. ToDo needs to go.
>> +	 * system-dt spec is not final for TCM
>> +	 */
>> +	tcm_bank_count = ARRAY_SIZE(zynqmp_tcm_banks);
>> +
>> +	/* count per core tcm banks */
>> +	tcm_bank_count = tcm_bank_count / cluster->core_count;
>> +
>> +	if (tcm_bank_count <= 0)
>> +		return -EINVAL;
> As far as I can tell this can't happen and as such should be removed.

I kept this check for future, when we add TCM dt nodes. I will remove it.

>
>> +
>> +	/*
>> +	 * r5 core 0 will use all of TCM banks in lockstep mode.
>> +	 * In split mode, r5 core0 will use 128k and r5 core1 will use another
>> +	 * 128k. Assign TCM banks to each core accordingly
>> +	 */
>> +	tcm_node = 0;
>> +	for (i = 0; i < cluster->core_count; i++) {
>> +		r5_core = cluster->r5_cores[i];
>> +		r5_core->tcm_banks = devm_kcalloc(dev, tcm_bank_count,
>> +						  sizeof(struct mem_bank_data *),
>> +						  GFP_KERNEL);
>> +		if (!r5_core->tcm_banks)
>> +			return -ENOMEM;
>> +
>> +		for (j = 0; j < tcm_bank_count; j++) {
>> +			/*
>> +			 * Use pre-defined TCM reg values.
>> +			 * Eventually this should be replaced by values
>> +			 * parsed from dts.
>> +			 */
>> +			r5_core->tcm_banks[j] =
>> +				(struct mem_bank_data *)&zynqmp_tcm_banks[tcm_node];
>> +			tcm_node++;
>> +		}
>> +
>> +		r5_core->tcm_bank_count = tcm_bank_count;
>> +	}
>> +
>> +	return 0;
>> +}
>> +
>> +/**
>> + * zynqmp_r5_get_mem_region_node()
>> + * parse memory-region property from dt node and add
>> + * memory region carveouts
>> + *
>> + * @r5_core: pointer to zynqmp_r5_core type object
>> + *
>> + * Return: 0 for success and error code for failure.
>> + */
>> +static int zynqmp_r5_get_mem_region_node(struct zynqmp_r5_core *r5_core)
>> +{
>> +	struct device_node *np, *rmem_np;
>> +	struct reserved_mem **rmem;
>> +	int res_mem_count, i;
>> +	struct device *dev;
>> +
>> +	dev = r5_core->dev;
>> +	np = r5_core->np;
>> +
>> +	res_mem_count = of_property_count_elems_of_size(np, "memory-region",
>> +							sizeof(phandle));
>> +	if (res_mem_count <= 0) {
>> +		dev_warn(dev, "failed to get memory-region property %d\n",
>> +			 res_mem_count);
>> +		r5_core->rmem_count = 0;
>> +		return 0;
>> +	}
>> +
>> +	rmem = devm_kcalloc(dev, res_mem_count,
>> +			    sizeof(struct reserved_mem *), GFP_KERNEL);
>> +	if (!rmem)
>> +		return -ENOMEM;
>> +
>> +	for (i = 0; i < res_mem_count; i++) {
>> +		rmem_np = of_parse_phandle(np, "memory-region", i);
>> +		if (!rmem_np)
>> +			goto release_rmem;
>> +
>> +		rmem[i] = of_reserved_mem_lookup(rmem_np);
>> +		if (!rmem[i]) {
>> +			of_node_put(rmem_np);
>> +			goto release_rmem;
>> +		}
>> +
>> +		of_node_put(rmem_np);
>> +	}
>> +
>> +	r5_core->rmem_count = res_mem_count;
>> +	r5_core->rmem = rmem;
>> +	return 0;
>> +
>> +release_rmem:
>> +	for (i--; i >= 0; i--)
>> +		kfree(rmem[i]);
> Function of_reserved_mem_lookup() doesn't allocate a new reserved_mem structure,
> you get a reference to an existing one.  As such there is no need to explicitly
> free individual elements of the rmem array.
Ack.
>
>> +	devm_kfree(dev, rmem);
>> +	return -ENOMEM;
>> +}
>> +
>> +/*
>> + * zynqmp_r5_core_init()
>> + * Create and initialize zynqmp_r5_core type object
>> + *
>> + * @cluster: pointer to zynqmp_r5_cluster type object
>> + *
>> + * Return: 0 for success and error code for failure.
>> + */
>> +static int zynqmp_r5_core_init(struct zynqmp_r5_cluster *cluster,
>> +			       enum rpu_oper_mode fw_reg_val,
>> +			       enum rpu_tcm_comb tcm_mode)
>> +{
>> +	struct device *dev = cluster->dev;
>> +	struct zynqmp_r5_core *r5_core;
>> +	int ret, i;
>> +
>> +	ret = zynqmp_r5_get_tcm_node(cluster);
>> +	if (ret < 0) {
>> +		dev_err(dev, "can't get tcm node, err %d\n", ret);
>> +		return ret;
>> +	}
>> +
>> +	for (i = 0; i < cluster->core_count; i++) {
>> +		r5_core = cluster->r5_cores[i];
>> +
>> +		ret = zynqmp_r5_get_mem_region_node(r5_core);
>> +		if (ret)
>> +			dev_warn(dev, "memory-region prop failed %d\n", ret);
>> +
>> +		/* Initialize r5 cores with power-domains parsed from dts */
>> +		ret = of_property_read_u32_index(r5_core->np, "power-domains",
>> +						 1, &r5_core->pm_domain_id);
>> +		if (ret) {
>> +			dev_err(dev, "failed to get power-domains property\n");
>> +			return ret;
>> +		}
>> +
>> +		ret = zynqmp_r5_set_mode(r5_core, fw_reg_val, tcm_mode);
>> +		if (ret) {
>> +			dev_err(dev, "failed to set r5 cluster mode %d, err %d\n",
>> +				cluster->mode, ret);
>> +			return ret;
>> +		}
>> +	}
>> +
>> +	return 0;
>> +}
>> +
>> +/*
>> + * zynqmp_r5_cluster_init()
>> + * Create and initialize zynqmp_r5_cluster type object
>> + *
>> + * @cluster: pointer to zynqmp_r5_cluster type object
>> + *
>> + * Return: 0 for success and error code for failure.
>> + */
>> +static int zynqmp_r5_cluster_init(struct zynqmp_r5_cluster *cluster)
>> +{
>> +	enum zynqmp_r5_cluster_mode cluster_mode = LOCKSTEP_MODE;
>> +	struct device *dev = cluster->dev;
>> +	struct device_node *dev_node = dev_of_node(dev);
>> +	struct platform_device *child_pdev;
>> +	struct zynqmp_r5_core **r5_cores;
>> +	enum rpu_oper_mode fw_reg_val;
>> +	struct device **child_devs;
>> +	struct device_node *child;
>> +	enum rpu_tcm_comb tcm_mode;
>> +	int core_count, ret, i;
>> +
>> +	ret = of_property_read_u32(dev_node, "xlnx,cluster-mode", &cluster_mode);
>> +
>> +	/*
>> +	 * on success returns 0, if not defined then returns -EINVAL,
>> +	 * In that case, default is LOCKSTEP mode
>> +	 */
>> +	if (ret != -EINVAL && ret != 0) {
>> +		dev_err(dev, "Invalid xlnx,cluster-mode property\n");
>> +		return -EINVAL;
>> +	}
>> +
>> +	/*
>> +	 * For now driver only supports split mode and lockstep mode.
>> +	 * fail driver probe if either of that is not set in dts.
>> +	 */
>> +	if (cluster_mode == LOCKSTEP_MODE) {
> Why is are LOCKSTEP_MODE and LOCKSTEP_MODE defined when the same values were
> already added in xlnx-zynqmp.h in patch 3/6?

Actually LOCKSTEP_MODE defined in this driver is taken from dt-bindings 
of this driver. However, PM_RPU_MODE_LOCKSTEP defined in firmware 
represents value expected by firmware. They are not the same defines. 
LOCKSTEP_MODE = 1 which is defined as per xlnx,cluster-mode bindings and 
similar to ti cluster-mode bindings. PM_RPU_MODE_LOCKSTEP = 0 which is 
expected from firmware.


>    And why not add SINGLE_CPU_MODE
> there as well instead of duplicating things in enum zynqmp_r5_cluster_mode?


SINGLE_CPU_MODE just represents xlnx,cluster-mode value from 
dt-bindings. It is not supported in firmware.

There are multiple ways to configure r5 cluster in single-cpu mode.

1) Add new EEMI call which asks firmware to configure cluster in 
single-cpu mode.

or 2) use existing EEMI calls and configure cores from driver. As 
single-cpu-mode is not supported yet, I am not sure, how it will

be implemented or what its design will look like. So, I haven't modified 
anything in firmware driver related to single-cpu mode.


>> +		tcm_mode = PM_RPU_TCM_COMB;
>> +		fw_reg_val = PM_RPU_MODE_LOCKSTEP;
>> +	} else if (cluster_mode == SPLIT_MODE) {
>> +		tcm_mode = PM_RPU_TCM_SPLIT;
>> +		fw_reg_val = PM_RPU_MODE_SPLIT;
>> +	} else {
>> +		dev_err(dev, "driver does not support cluster mode %d\n", cluster_mode);
>> +		return -EINVAL;
>> +	}
>> +
>> +	/*
>> +	 * Number of cores is decided by number of child nodes of
>> +	 * r5f subsystem node in dts. If Split mode is used in dts
>> +	 * 2 child nodes are expected.
>> +	 * In lockstep mode if two child nodes are available,
>> +	 * only use first child node and consider it as core0
>> +	 * and ignore core1 dt node.
>> +	 */
>> +	core_count = of_get_available_child_count(dev_node);
>> +	if (core_count <= 0) {
>> +		dev_err(dev, "Invalid number of r5 cores %d", core_count);
>> +		return -EINVAL;
>> +	} else if (cluster_mode == SPLIT_MODE && core_count != 2) {
>> +		dev_err(dev, "Invalid number of r5 cores for split mode\n");
>> +		return -EINVAL;
>> +	} else if (cluster_mode == LOCKSTEP_MODE && core_count == 2) {
>> +		dev_warn(dev, "Only r5 core0 will be used\n");
>> +		core_count = 1;
>> +	}
>> +
>> +	child_devs = kcalloc(core_count, sizeof(struct device *), GFP_KERNEL);
>> +	if (!child_devs)
>> +		return -ENOMEM;
>> +
>> +	r5_cores = kcalloc(core_count,
>> +			   sizeof(struct zynqmp_r5_core *), GFP_KERNEL);
>> +	if (!r5_cores) {
>> +		kfree(child_devs);
>> +		return -ENOMEM;
>> +	}
>> +
>> +	i = 0;
>> +	for_each_available_child_of_node(dev_node, child) {
>> +		child_pdev = of_find_device_by_node(child);
>> +		if (!child_pdev) {
>> +			of_node_put(child);
>> +			ret = -ENODEV;
>> +			goto release_r5_cores;
>> +		}
>> +
>> +		child_devs[i] = &child_pdev->dev;
>> +
>> +		/* create and add remoteproc instance of type struct rproc */
>> +		r5_cores[i] = zynqmp_r5_add_rproc_core(&child_pdev->dev);
>> +		if (IS_ERR(r5_cores[i])) {
>> +			of_node_put(child);
>> +			ret = PTR_ERR(r5_cores[i]);
>> +			goto release_r5_cores;
> If we are here and i == 0, we are leaking a reference to child_pdev since the
> loop in release_r5_cores won't execute.
Ack. I will check if i == 0 and put_device() before jumping to 
release_r5_cores.
>
>> +		}
>> +
>> +		i++;
>> +
>> +		/*
>> +		 * If two child nodes are available in dts in lockstep mode,
>> +		 * then ignore second child node.
>> +		 */
>> +		if (i == core_count) {
>> +			of_node_put(child);
>> +			break;
>> +		}
> Instead of using the i to check the cores, simply break if cluster_mode ==
> LOCKSTEP_MODE.  That will avoid the fragile dance around the manipulation of
> variable i and simplify the release of resources in release_r5_cores.
>
Actually variable name "i" needs to be changed. I need that variable to 
track how many cores  are added successfully.

So, if first core is added and second core fails, then I can release 
resources allocated for first core successfully.

So, instead of "i" I can use meaningful variable name like "cores_added" 
or "cores_allocated".

>> +	}
>> +
>> +	cluster->mode = cluster_mode;
>> +	cluster->core_count = core_count;
>> +	cluster->r5_cores = r5_cores;
>> +
>> +	ret = zynqmp_r5_core_init(cluster, fw_reg_val, tcm_mode);
>> +	if (ret < 0) {
>> +		dev_err(dev, "failed to init r5 core err %d\n", ret);
>> +		cluster->core_count = 0;
>> +		cluster->r5_cores = NULL;
>> +		goto release_r5_cores;
>> +	}
>> +
>> +	kfree(child_devs);
>> +	return 0;
>> +
>> +release_r5_cores:
>> +	for (i--; i >= 0; i--) {
>> +		put_device(child_devs[i]);
>> +		rproc_del(r5_cores[i]->rproc);
>> +		rproc_free(r5_cores[i]->rproc);
>> +	}
>> +	kfree(r5_cores);
>> +	kfree(child_devs);
>> +	return ret;
>> +}
>> +
>> +static void zynqmp_r5_cluster_exit(void *data)
>> +{
>> +	struct platform_device *pdev = (struct platform_device *)data;
>> +	struct zynqmp_r5_cluster *cluster;
>> +	struct zynqmp_r5_core *r5_core;
>> +	int i;
>> +
>> +	cluster = (struct zynqmp_r5_cluster *)platform_get_drvdata(pdev);
>> +	if (!cluster)
>> +		return;
>> +
>> +	for (i = 0; i < cluster->core_count; i++) {
>> +		r5_core = cluster->r5_cores[i];
>> +		put_device(r5_core->dev);
>> +		rproc_del(r5_core->rproc);
>> +		rproc_free(r5_core->rproc);
>> +	}
>> +
>> +	kfree(cluster->r5_cores);
>> +	kfree(cluster);
>> +	platform_set_drvdata(pdev, NULL);
>> +}
>> +
>> +/*
>> + * zynqmp_r5_remoteproc_probe()
>> + *
>> + * @pdev: domain platform device for R5 cluster
>> + *
>> + * called when driver is probed, for each R5 core specified in DT,
>> + * setup as needed to do remoteproc-related operations
>> + *
>> + * Return: 0 for success, negative value for failure.
>> + */
>> +static int zynqmp_r5_remoteproc_probe(struct platform_device *pdev)
>> +{
>> +	struct zynqmp_r5_cluster *cluster;
>> +	struct device *dev = &pdev->dev;
>> +	int ret;
>> +
>> +	cluster = kzalloc(sizeof(*cluster), GFP_KERNEL);
>> +	if (!cluster)
>> +		return -ENOMEM;
>> +
>> +	cluster->dev = dev;
>> +
>> +	ret = devm_of_platform_populate(dev);
>> +	if (ret) {
>> +		dev_err_probe(dev, ret, "failed to populate platform dev\n");
>> +		kfree(cluster);
>> +		return ret;
>> +	}
>> +
>> +	/* wire in so each core can be cleaned up at driver remove */
>> +	platform_set_drvdata(pdev, cluster);
>> +
>> +	ret = zynqmp_r5_cluster_init(cluster);
>> +	if (ret) {
>> +		zynqmp_r5_cluster_exit(pdev);
>> +		dev_err_probe(dev, ret, "Invalid r5f subsystem device tree\n");
>> +		return ret;
>> +	}
>> +
>> +	ret = devm_add_action_or_reset(dev, zynqmp_r5_cluster_exit, pdev);
>> +	if (ret)
>> +		return ret;
>> +
>> +	return 0;
>> +}
>> +
>> +/* Match table for OF platform binding */
>> +static const struct of_device_id zynqmp_r5_remoteproc_match[] = {
>> +	{ .compatible = "xlnx,zynqmp-r5fss", },
>> +	{ /* end of list */ },
>> +};
>> +MODULE_DEVICE_TABLE(of, zynqmp_r5_remoteproc_match);
>> +
>> +static struct platform_driver zynqmp_r5_remoteproc_driver = {
>> +	.probe = zynqmp_r5_remoteproc_probe,
>> +	.driver = {
>> +		.name = "zynqmp_r5_remoteproc",
>> +		.of_match_table = zynqmp_r5_remoteproc_match,
>> +	},
>> +};
>> +module_platform_driver(zynqmp_r5_remoteproc_driver);
>> +
>> +MODULE_DESCRIPTION("Xilinx R5F remote processor driver");
>> +MODULE_AUTHOR("Xilinx Inc.");
>> +MODULE_LICENSE("GPL");
> There is a discrepency between the GPL-2.0 in the SPDS identifier and the above.
>
> More comments tomorrow or Tuesday.
>
> Thanks,
> Mathieu
>
>> -- 
>> 2.25.1
>>
