Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 724844A70E6
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Feb 2022 13:38:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244930AbiBBMhw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Feb 2022 07:37:52 -0500
Received: from mail-vi1eur05on2089.outbound.protection.outlook.com ([40.107.21.89]:22017
        "EHLO EUR05-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231748AbiBBMht (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Feb 2022 07:37:49 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JAcUln2UJ6++f8RFeNtUDU4wbMM8wEjvq6r2H6nxcXcd3eDGFnHlge3KarvtIbrpyPkzBbuR8dS3KVBruT/mUQnsqxBzpRIzvNlEWfsblJyFLIXjHOzxJfhi24MYP+t2pMWFbp/z4AY8vnpYakbbipQu2q3suWX4Q27/tFO/IjE4gW1JJMku6t6v+7bZH1wnjWaP2wERELXRr1Z8r7aoTZa0lV/x2mZ5yvQQr74O1nRdp+yyfo3Ygxxu9iEXASVQ+8+H6zcZPzn7MEoKUeH2I/qyn9OtBtfP0HyGRMJRiTliN8RQnu5OzrZmbYouL0rX2nL8JTdgR7XIo9nbL8yb/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OXg7BUROgtGtd3tL5eyo4Xqui42PqCaQRbyk9yHG4XI=;
 b=CxkHKmKupK9Dzmn7B3rThr85fqR5mtEymR/WRycIAn7+D18XXmx9pkRYl35qpZQwYBfC9kfo0LnmZ/lwH+wSLJjC7mSIZQNKf5FPCnqJBiArn29nH4zvQtyJPN1Y4CuCI/0XBvNVvP+fLI3R2IxaCUrP6IeU92hKZjJ0csRc4JL1aIbt25jTp2GDoUf61mVRcnbItHuuUmLIq0W/Y4Qb3aQld19JTxuX45EZ0Ifq6ofl66Zyf2e9cdYN1BvwL7qYqDYl3z3uWBBH5AiJzmmRWNwX+W6kyEGOH93fjVgkMJ5fpTFzUao6T6vdbVxHPbOEuFZmhF5AJZtcsobmoTrb/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OXg7BUROgtGtd3tL5eyo4Xqui42PqCaQRbyk9yHG4XI=;
 b=hHlsaw66BvuxhVWRVh/AwOoXGVypeVjc1uSN5Jf4ae+bOKWnCszSLlxv1klk9wwf+EaBumCYxXhJAVEKNCwQneP9URxVamtmbM6ONbKIpC8dK8wlXafvTfVGNC4DhKRQVC3WzkjF8COC28qIULcTS9/kS7E9uTSLLBJchARariQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VI1PR0402MB3405.eurprd04.prod.outlook.com (2603:10a6:803:3::26)
 by AM9PR04MB8650.eurprd04.prod.outlook.com (2603:10a6:20b:43d::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.12; Wed, 2 Feb
 2022 12:37:48 +0000
Received: from VI1PR0402MB3405.eurprd04.prod.outlook.com
 ([fe80::f826:3bf6:b77d:5a53]) by VI1PR0402MB3405.eurprd04.prod.outlook.com
 ([fe80::f826:3bf6:b77d:5a53%7]) with mapi id 15.20.4930.022; Wed, 2 Feb 2022
 12:37:48 +0000
Message-ID: <e9e0cd5b-906d-8817-e73b-90a6c042f576@nxp.com>
Date:   Wed, 2 Feb 2022 14:37:44 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: [PATCH v2] soc: dpio: fix cleanup on error
Content-Language: en-CA
To:     Leo Li <leoyang.li@nxp.com>
Cc:     "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Youri Querry (OSS)" <youri.querry_1@oss.nxp.com>,
        Ioana Ciornei <ioana.ciornei@nxp.com>
References: <20211004115323.7454-1-laurentiu.tudor@nxp.com>
 <20211007122442.4nyof6jf3w6s4shy@skbuf>
From:   Laurentiu Tudor <laurentiu.tudor@nxp.com>
In-Reply-To: <20211007122442.4nyof6jf3w6s4shy@skbuf>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM3PR05CA0104.eurprd05.prod.outlook.com
 (2603:10a6:207:1::30) To VI1PR0402MB3405.eurprd04.prod.outlook.com
 (2603:10a6:803:3::26)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 846615d2-ca86-441f-876a-08d9e648d176
X-MS-TrafficTypeDiagnostic: AM9PR04MB8650:EE_
X-Microsoft-Antispam-PRVS: <AM9PR04MB865090F669B1AEC222E63748EC279@AM9PR04MB8650.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: X2G3o/6sCMDgQLEqvqEEiREpBSLPLq25FsZD5bG0UxXyVGm6D6yGFR0ojhJH3DVMZKok+abzpTg7GNxYoIn6cjbZW9sOriVm2mgCFTOF4l82+NA9rurr4+jhiwZJjhzkB2JhD/Qx7XQ7Pz36Tm8OYu+eZ4E20khhJ0eZCHg2RvgHEOo8VTHuPmfqJVJvblaOxLQdGTTGfDgvAVGdF9M6m+Xc3tLFAArw3Dxv7XyzxZmyK6djaDiptMw7ksd0JYsrv4n93hi8XXfmQsU2ttTbooQxg1WqAhwt/mCO0x/DKfHcuy05xXrU/Ls/2NIwUe3P53bmIJAj5XSEP2cQ6LcuBMAdx5iL9LJGQAyw4EqLNbbgdNk3alFTbx4EjMscQlHbpXc8OZ4WOybKNSiCg3OwBz8S+y0nJE7xDB9at0Qo2aDdT4wUMtiPRal4aBCDO/gye3xc67gu+t0RoQPqTc64EVt9fXna8CZ2wnbLvL1SJmq7QgKGTKn/aU3/zdmnal+jckbRbs2HGhbzbw2tcdrG2ZgepHv/818sEStNdMQpKeTyYTeNFyqQlRfl1tK0h2vBJXEGyKJFsj97NhuKmwY4dtHTxveyASJ7ALEcV0cLOqcZHzAZD+P2LtlE2Ghhywo3g77nGUN8uiJdL3JOV/FuBcUI9eNlYYMbJnEEaU3qOjglQTHt9+RedwWt7SQk0xCuzXhpKGdcpgy1nmeW0u10U2/DhF6Q7w7hOilXoh8LrlFWnMgYIdKAoZdSe0yszE1W/QeANtQH1jrZENzgHAcKpQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR0402MB3405.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(44832011)(54906003)(86362001)(31696002)(316002)(6636002)(38350700002)(38100700002)(37006003)(83380400001)(6666004)(6506007)(6512007)(53546011)(5660300002)(6862004)(66556008)(26005)(186003)(6486002)(508600001)(2906002)(4326008)(8936002)(31686004)(8676002)(2616005)(36756003)(66476007)(52116002)(66946007)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bmlRTUVSbWNUTmhKdTlDdzA0NjRhTDBpZnpOeFRLejhRK2hFT2RCWlIrcTFK?=
 =?utf-8?B?ODhYUjZqYUdzMDhsQ29IdEVkUVhreTNnU3VHWmw1SEJoTnMzcTFWRVV4Unla?=
 =?utf-8?B?T09oV3VnVDZkYUFHMjJkTUNPd1JoM3lwR1Q0M1YyZVhhWnpWY3dqOXB5SWFH?=
 =?utf-8?B?eWM4S1JPZDMrSGZtbmJWdVkyZWlnNCtwTWZhTjhCdlEwZVlKcTIxdnlKOVZF?=
 =?utf-8?B?YzRoK2tzeDRyU1NBbUJBRzBVNit6Y3ZaMmxVcFpWaU5xRmJnTzl1OGdWMllx?=
 =?utf-8?B?Nmt5Y1N0UFdCTzA2Y0dudUVMMnFOS0tqbDE2KzJSQXBzcy9iUmIrM0g3Rm9u?=
 =?utf-8?B?ZFFOWnRJNVNWeGhuZXljY1pvUjg5UGZCd01ybXV6cGdwMVYrQVhuS3UybkNk?=
 =?utf-8?B?dlVUZEJ1bnZNN0FsTG0rQ1g4U0dMaE93YTJZZVF4N0dYWmRBTldZRkRSenV2?=
 =?utf-8?B?U3JqOE5kek1sSi9LeDJiSzNKUForWVNORzJ1VjN2MnNUamhqSzZtNVYxU3Bq?=
 =?utf-8?B?L2J5SHBmVTlLQ2h6UFJtekY0RlFvOE5VZitEUFFZcnk0citoNml0TE5odE9z?=
 =?utf-8?B?LytkYldSRk5rT2ZQSFUwZlBwSmhLWFhDeDVxb240TzV4WFFYVFpBZmxid210?=
 =?utf-8?B?aFdtTTBUVVZCdmhncXB1Y3ZNcHJmMmRlSXVpaEIrWWJFQk9NNmtLTU1IOGRT?=
 =?utf-8?B?RzJiVjFIVGNDc2NHb3orZ2pSQjB6S3MzUnVHbkZLcU5kNHJDZTBtQnZESFo0?=
 =?utf-8?B?MFp3TE1EZCtod2lPMXEvcnVza2taUHFTK1phWmFjYlVsK21qd2RKcEVZOE5Q?=
 =?utf-8?B?aWhRUmI5eFVpZ2htbU9VRVIxeXl0RWI4c0ZQTjNyRU14SFhQcElacDdBNlg4?=
 =?utf-8?B?ZnFwb3R1VlU2eWVWTmdNTDJFMEEwTTJGQVRwVWoxb0VDUjRNNzJiREhSSEpI?=
 =?utf-8?B?cFMrcjI1VzNlcW1QejB5YXdGY0pBRU8xNm85QnpYRDFQWENoeWUzZjBNYzZn?=
 =?utf-8?B?NC8rSktHbWN4b1U2Y0NQeENBbHhtV0RzeFBpVFZ3ZmRLUFRrL0lzelVjNElR?=
 =?utf-8?B?WmRwNlpRbnJsUWtMN1dHV01pYXRsVFhsQ1R5L0t5RFVuWXdYNmZhYnY5ZjZR?=
 =?utf-8?B?ZnZHaXpxVnJDSTNLaEdhZElxWHJ3am1KZXJOS0dPYmNydXQwN0tZdXVQT2hw?=
 =?utf-8?B?dS9uMHM0WTRIeEdnbGIzWUdZWVUxeWpEcEUvRDJ1dFRIckNFM3ZQVzJZcGJ5?=
 =?utf-8?B?d2ZPSjRDWkVKK1g3WWp0OTFOQXRWWk91ODhJUldWc0tPSzhEV2h0eWsyMCtG?=
 =?utf-8?B?bUlUa1MyNWtUdG90cWdraWtjTEZzZVRoN1ErZWhPT2FZM1M1eHFLZ3ZyOTlv?=
 =?utf-8?B?UC9DL2hubEN4cHN3c0hYWkd6N2NLM2k4SnpBVzIwOWdGTWJVRk5yQUxhenVl?=
 =?utf-8?B?Nm9xQXhYTWVEanNBYVRONXRoNzRINnl4dzVleC85Qi9rdGoxdEcydVowWXhJ?=
 =?utf-8?B?Q05KYU01N3VxbTk4WW1odjJuRDltZUJNd2xXbUJqZzhmeURvUXN4T2FRemUv?=
 =?utf-8?B?Umx4TVU4NGNpNWh5eG1oc2hUcnUrM29Rc2RHR1lqNk9rek5QQmRBTGVFVERQ?=
 =?utf-8?B?UXl5TmVqYkxkb1BkWW82NStDTWRKRkJ0aFgzZ0N1T2g2T29QUVdoMUwvV3hr?=
 =?utf-8?B?alI5SkFKWitHV0Jldnd5d1J6THIyMEg3MEdJQ3lzbGFaRW5tVW1LUEJIa0pZ?=
 =?utf-8?B?elRUb1Vncy8rbWI0OXNwQVZRQkZsdHdSNlVUTjJvOFMzVm9WTElxYTRJUGRm?=
 =?utf-8?B?ZjVXWmVhQUFvQ25MQnpKQng4NWptMWtMTy9GcThQSXhFcTd3R3I4blI0M3lP?=
 =?utf-8?B?empHRGRtZDBVR2IrT2VoNE5EdWdETDJpZUFmbTdWWFhGeG5KbVB1VlpSK20v?=
 =?utf-8?B?N3lMekhnRWI0MmR6WUt5TmNrS3Jqc0NqYzJvYjJrNTFSZUcxTGlRTzU5RFgw?=
 =?utf-8?B?emZUdWM1cjhtdk1sczM0Z0RydEJVa2FYWTBSbmxCYmRORlVFSm8yT2YyMWVn?=
 =?utf-8?B?cGx0RXlaOHBwWko3Smh1dm82dzNUWWlZYjhVT1JyY1R3emdRNzlwbjUra2FY?=
 =?utf-8?B?UzRTMzE2bWNvcFNTZ3BBSkFrdFBPWTE4RjBmdDJPRWZrYVVuZFNWWHJZbWNi?=
 =?utf-8?Q?Pg/1FUOMLm4VYANfIzNTGAY=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 846615d2-ca86-441f-876a-08d9e648d176
X-MS-Exchange-CrossTenant-AuthSource: VI1PR0402MB3405.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Feb 2022 12:37:47.9156
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6lY+COW+p+OpT/zrvRws6hBdwGPlMl/BggvZpabb3ROrSC3yz+NLzY3ceNwQELYV/iu0pt49y3iwkS/yRIEYVg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8650
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Leo,

Kind reminder.

---
Best Regards, Laurentiu

On 10/7/2021 3:24 PM, Ioana Ciornei wrote:
> On Mon, Oct 04, 2021 at 02:53:23PM +0300, Laurentiu Tudor wrote:
>> dpaa2_io_service_register() adds an element to a linked list but
>> doesn't remove it on the error path, leading to the below kasan
>> use-after-free splat. Fix it.
>>
>> ==================================================================
>> BUG: KASAN: use-after-free in dpaa2_io_service_register+0xb8/0x1d4
>> Write of size 8 at addr ffff05d2b13af028 by task kworker/u32:2/151
>>
>> CPU: 9 PID: 151 Comm: kworker/u32:2 Not tainted 5.14.0-rc1-00222
>> Hardware name: NXP NXP LX2160ARDB Platform, BIOS EDK II Apr 16 2021
>> Workqueue: events_unbound deferred_probe_work_func
>> Call trace:
>>   dump_backtrace+0x0/0x2a4
>>   show_stack+0x1c/0x30
>>   dump_stack_lvl+0x68/0x84
>>   print_address_description.constprop.0+0x74/0x2b8
>>   kasan_report+0x1e0/0x24c
>>   __asan_store8+0xa8/0xd0
>>   dpaa2_io_service_register+0xb8/0x1d4
>>   dpaa2_eth_probe+0x93c/0x21cc
>>   fsl_mc_driver_probe+0x3c/0x80
>>   really_probe.part.0+0xec/0x480
>>   __driver_probe_device+0xd4/0x180
>>   driver_probe_device+0xf8/0x1e0
>>   __device_attach_driver+0x120/0x190
>>   bus_for_each_drv+0xec/0x15c
>>   __device_attach+0x168/0x250
>>   device_initial_probe+0x18/0x24
>>   bus_probe_device+0xec/0x100
>>   deferred_probe_work_func+0xe8/0x130
>>   process_one_work+0x3b8/0x650
>>   worker_thread+0xa4/0x72c
>>   kthread+0x1f8/0x210
>>   ret_from_fork+0x10/0x18
>>
>> Allocated by task 1192:
>>   kasan_save_stack+0x2c/0x60
>>   __kasan_kmalloc+0x90/0xb4
>>   dpaa2_eth_probe+0x830/0x21cc
>>   fsl_mc_driver_probe+0x3c/0x80
>>   really_probe.part.0+0xec/0x480
>>   __driver_probe_device+0xd4/0x180
>>   driver_probe_device+0xf8/0x1e0
>>   __device_attach_driver+0x120/0x190
>>   bus_for_each_drv+0xec/0x15c
>>   __device_attach+0x168/0x250
>>   device_initial_probe+0x18/0x24
>>   bus_probe_device+0xec/0x100
>>   device_add+0x570/0xca0
>>   fsl_mc_device_add+0x360/0x8f0
>>   fsl_mc_obj_device_add+0x140/0x16c
>>   dprc_scan_objects+0x2c4/0x480
>>   dprc_probe+0x48/0x17c
>>   fsl_mc_driver_probe+0x3c/0x80
>>   really_probe.part.0+0xec/0x480
>>   __driver_probe_device+0xd4/0x180
>>   device_driver_attach+0x70/0xf0
>>   bind_store+0xf8/0x160
>>   drv_attr_store+0x50/0x6c
>>   sysfs_kf_write+0x94/0xb0
>>   kernfs_fop_write_iter+0x19c/0x264
>>   new_sync_write+0x1c4/0x2bc
>>   vfs_write+0x30c/0x390
>>   ksys_write+0xc4/0x170
>>   __arm64_sys_write+0x48/0x60
>>   invoke_syscall+0x60/0x190
>>   el0_svc_common+0x84/0x130
>>   do_el0_svc+0x88/0xa4
>>   el0_svc+0x24/0x34
>>   el0t_64_sync_handler+0xa8/0x130
>>   el0t_64_sync+0x198/0x19c
>>
>> Freed by task 1192:
>>   kasan_save_stack+0x2c/0x60
>>   kasan_set_track+0x2c/0x40
>>   kasan_set_free_info+0x2c/0x50
>>   __kasan_slab_free+0xdc/0x140
>>   kfree+0xd4/0x360
>>   dpaa2_eth_probe+0x11b4/0x21cc
>>   fsl_mc_driver_probe+0x3c/0x80
>>   really_probe.part.0+0xec/0x480
>>   __driver_probe_device+0xd4/0x180
>>   driver_probe_device+0xf8/0x1e0
>>   __device_attach_driver+0x120/0x190
>>   bus_for_each_drv+0xec/0x15c
>>   __device_attach+0x168/0x250
>>   device_initial_probe+0x18/0x24
>>   bus_probe_device+0xec/0x100
>>   device_add+0x570/0xca0
>>   fsl_mc_device_add+0x360/0x8f0
>>   fsl_mc_obj_device_add+0x140/0x16c
>>   dprc_scan_objects+0x2c4/0x480
>>   dprc_probe+0x48/0x17c
>>   fsl_mc_driver_probe+0x3c/0x80
>>   really_probe.part.0+0xec/0x480
>>   __driver_probe_device+0xd4/0x180
>>   device_driver_attach+0x70/0xf0
>>   bind_store+0xf8/0x160
>>   drv_attr_store+0x50/0x6c
>>   sysfs_kf_write+0x94/0xb0
>>   kernfs_fop_write_iter+0x19c/0x264
>>   new_sync_write+0x1c4/0x2bc
>>   vfs_write+0x30c/0x390
>>   ksys_write+0xc4/0x170
>>   __arm64_sys_write+0x48/0x60
>>   invoke_syscall+0x60/0x190
>>   el0_svc_common+0x84/0x130
>>   do_el0_svc+0x88/0xa4
>>   el0_svc+0x24/0x34
>>   el0t_64_sync_handler+0xa8/0x130
>>   el0t_64_sync+0x198/0x19c
>>
>> The buggy address belongs to the object at ffff05d2b13af000
>>   which belongs to the cache kmalloc-1k of size 1024
>> The buggy address is located 40 bytes inside of
>>   1024-byte region [ffff05d2b13af000, ffff05d2b13af400)
>> The buggy address belongs to the page:
>> page:0000000091873dc7 refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x22313a8
>> head:0000000091873dc7 order:3 compound_mapcount:0 compound_pincount:0
>> flags: 0xbfffc0000010200(slab|head|node=0|zone=2|lastcpupid=0xffff)
>> raw: 0bfffc0000010200 0000000000000000 dead000000000122 ffff05d1000028c0
>> raw: 0000000000000000 0000000000100010 00000001ffffffff 0000000000000000
>> page dumped because: kasan: bad access detected
>>
>> Memory state around the buggy address:
>>   ffff05d2b13aef00: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
>>   ffff05d2b13aef80: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
>>> ffff05d2b13af000: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>>                                    ^
>>   ffff05d2b13af080: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>>   ffff05d2b13af100: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>> ==================================================================
>>
>> Signed-off-by: Laurentiu Tudor <laurentiu.tudor@nxp.com>
> 
> Reviewed-by: Ioana Ciornei <ioana.ciornei@nxp.com>
