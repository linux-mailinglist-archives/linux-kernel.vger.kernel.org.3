Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E67D4B9CDB
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Feb 2022 11:14:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239063AbiBQKNl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Feb 2022 05:13:41 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:57822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239057AbiBQKNj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 05:13:39 -0500
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2106.outbound.protection.outlook.com [40.107.21.106])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F7F2143469
        for <linux-kernel@vger.kernel.org>; Thu, 17 Feb 2022 02:13:25 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B7qXrTJ7b7TfhdjAgsBbPIV8s8Ubcsxaw7dJda2MPmVtU9UumGdqluKJekc7yO1akMq2HvTZdrSAX4BQmxbsUAk2TjPSiHBOohdjUQOkIrRD9jm3YgyLuW2XlSGYeNrfVQOHyBA6FEKLHOgUJD0lr3/GuuNR9DftXUe2Oggva2Btbaf5o9+ARsPR77BPTbGLNnXV/Dzmms8T2RBwIIjT+7yCpzhk0coQ5MLB5NTaoPWKzwpnePmoslyZBxA6za9TyqsvXBd8gvJTjdqv3W6nUd4MhW1y9M2jchh/IoBrQfyJFX9qFaFzmtmfh2p7SQL7t0m7PhbtQy2EftbSYoiggQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nop71IUL8AdpfiiArzG91g/MDBmLsKO3Gcj0ct2TJPU=;
 b=AHzTitSIU9eHJhWKyBHlElf8XCoCljJLsNhDpzehcqqggra1bqbbyatXWfudtls61RBz22RktMdJmOcsezu3lDt0N4rAM8qrtMiAYXlLR3PG2mrKziqvf3jbVDgt1In4X+wn/Dz0CtgWbATtK6wkFmmqKTVX00kIEvqwTACC8t9SznpN57ojdNKkT1SmVul16F2DfV5cYf4rIuVniwVXayUmNijXa57Delc/C/6N0Akcy4UTaPXYT9VfnMcuiaCvVsgm9M7gjqadHcvVurF5pIbuj1uS280u67ycbYN1sEN5XKTp1NgCvvZ7IJsUfgrQBIBP9swJknuqjLudf1M6vA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nop71IUL8AdpfiiArzG91g/MDBmLsKO3Gcj0ct2TJPU=;
 b=vG40rEl8ijBKsJmuzJ4Xd70I4qRxjOqsJ6dk51IgQpZpcPriadGvx7duocyFH2AqJ+qu5g3Vnld9F5l3zQBF0avCeIFyc7y8eFIIyEQ2U90sRiGa2DX1nFbgXQge++N6QDO1uZKL8eDGzzxKo6c7vIIDRO78fxQOR1WC2YIFHVU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from DB6PR0802MB2374.eurprd08.prod.outlook.com (2603:10a6:4:8a::21)
 by VE1PR08MB5853.eurprd08.prod.outlook.com (2603:10a6:800:1a5::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.16; Thu, 17 Feb
 2022 10:13:22 +0000
Received: from DB6PR0802MB2374.eurprd08.prod.outlook.com
 ([fe80::57c:1b85:7b36:55bf]) by DB6PR0802MB2374.eurprd08.prod.outlook.com
 ([fe80::57c:1b85:7b36:55bf%5]) with mapi id 15.20.4995.017; Thu, 17 Feb 2022
 10:13:22 +0000
Subject: [PATCH RESEND v2] dm: Fix use-after-free in dm_cleanup_zoned_dev()
References: <c64d2143-284e-7621-440c-971e3405b4d8@virtuozzo.com>
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        "agk@redhat.com" <agk@redhat.com>,
        "snitzer@redhat.com" <snitzer@redhat.com>,
        "dm-devel@redhat.com" <dm-devel@redhat.com>,
        linux-kernel@vger.kernel.org
From:   Kirill Tkhai <ktkhai@virtuozzo.com>
X-Forwarded-Message-Id: <c64d2143-284e-7621-440c-971e3405b4d8@virtuozzo.com>
Message-ID: <d209a0b1-2514-79a0-257a-22bcb372785a@virtuozzo.com>
Date:   Thu, 17 Feb 2022 13:13:20 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
In-Reply-To: <c64d2143-284e-7621-440c-971e3405b4d8@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AS8PR07CA0035.eurprd07.prod.outlook.com
 (2603:10a6:20b:459::27) To DB6PR0802MB2374.eurprd08.prod.outlook.com
 (2603:10a6:4:8a::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 25a8552c-e3eb-4a32-06e5-08d9f1fe208d
X-MS-TrafficTypeDiagnostic: VE1PR08MB5853:EE_
X-Microsoft-Antispam-PRVS: <VE1PR08MB5853B1DA1482E10B82A69509CD369@VE1PR08MB5853.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:172;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: i0Kq2n03eHoZk6kTKH7v/ZmWAYTTPyxrCQLJu68hl6BYaeaDy5NVcfJ/5DxV0FGH/mDsmxUWvwPNK1C1aDwQoC6RhoMu+kNSmf2sy5EmHNeKyE4zinbSzoQMvJtsWu/+rh+JM1rHwBV/zg39rq6OnJiBYpiJrOk4dcmzoHtajoPHtn+ivKpaF3FRFeqEzE8p/FDItaD2vbTd2yla/2CUkDPiwogVQ8ZGGJ2s0dWwvkMhwiL0nzePS/Ps/OLO1AcnvIEHpd+b/3assv9DwGkXVoS6R5UQce2+NaMlvqKLmToezhb5otJknSzdmvMt54rtxrcGMkLL+c2kftWNxphBDhX2ePIfQdBlquYNBOG4mN84mDWMdD1FBEArvGCBVd7hDcVzRkZiojBI+JlRlkXj6omNZxQJG2BYwo/TMocNgS/CR3626mGniugCGXPbpbq2+IoC1nPTD1b7fVEvSGEa912YDrU/KzcWF/v5Ejg98my4qUDlCgvlScAw0qjJyKfOyo4bdXsHNVdorMdgILn9FB0Q2nx2dGU+IIYVhM+5B4UwXuCzftTk23CUi28XIkdfFi9H/cBesfRbZmAEgtwIJ60jQUw8egokIWkHOasaG769fhI7g/3WIbE5mTPvsqSk1t9hfX1DsXtqwaDAZWU6xnSUyWPV2OLls9J/ZKsZqR71KaqrRgYLgIpML91SEvasNTQCnwHFvEJrLXnklDd1S1F0RmCK81Gv+sENNWDlOm8d07wcDnL8BBmku7g4yqr3lX315oaug/QNmfWvY7JpKp2Kq/StKjnX8VnNgTO0C1g=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB6PR0802MB2374.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(2616005)(186003)(26005)(31686004)(52116002)(6512007)(6506007)(508600001)(316002)(110136005)(36756003)(6486002)(8936002)(2906002)(83380400001)(86362001)(66476007)(66556008)(66946007)(8676002)(5660300002)(31696002)(38100700002)(38350700002)(21314003)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Z2hlbVM3L1FHdmhFaitJRlhKSmthaVJNMThXWFppZHpEclFCcThSYUptR21r?=
 =?utf-8?B?WXNJTERuTFBqb0hFYmJ6ZmpReXNibFo4dXNVaENQUVZ6OTkwb0lMZWx5bjlP?=
 =?utf-8?B?KzczTW4wVFJHRVVFNTZSSTBYejBrOHM4Q3Vrd1BjSXZLSlA1NHdUUldqanpp?=
 =?utf-8?B?MDRqSVdOSUhJUGNJWEc1V2RIZTBLZmJpQ2M5ZzlvNGJQcEszZC9TKzRlWG1J?=
 =?utf-8?B?Sm5UY2dDSEVud29zNFg3T2JSK3daRHAzTnkvRTd6UnR6d3dpL2dpQ1BiOS8y?=
 =?utf-8?B?cVhCODBFVURTbFBZRkRlTW5pTkxGdUZVWk5Ob2hjMEpXVzliN2VaWXpFNWVj?=
 =?utf-8?B?TUdnMHhXVSs4T1dKZ2xEQkFQZGhoYlMrenQxM21iM3JuUG1LRGt3YWJPM3dT?=
 =?utf-8?B?VVBaM3hudXBmdjNWdThCV3VNekx2MkNhTzg3Wi9KRnFMUThNM0t5bjFadDNm?=
 =?utf-8?B?eTRpNS9iUDl0L0thUjNyK2g5UDRyMGdYeEdtSncva1lrejBOd3RNN3d3OVV6?=
 =?utf-8?B?T1g4Q3QxR28vdWtsNzRTSVAyd1p0NElyd3dMUmMwUm9HQXZoaFR4cjh6ZjUv?=
 =?utf-8?B?TndQLzdSYm9uOFoxb0RRK1QycnRPK3Ewd09WQURCVjljWVJBZFdsRnc2a3hu?=
 =?utf-8?B?dWFKd01QWVUzcGk4dGhwckhRUXdtejhhKzJFeWZleS83a2xKQ0J6a21HT2E5?=
 =?utf-8?B?VE5ua3UzQThvQkEyL2U1WXZacFZpb1hQbjhiVDFkTzBTK3JRZkU3SWNGMnBa?=
 =?utf-8?B?bHg2a1BpQUh4SUNha0c4cnlKdGIxeEZLQVRHMExLUlRFa2JsemlTdjErWmdU?=
 =?utf-8?B?K2o4REs0bXEwQm1OTlFDYWp0K2RxM2FiSDFEdDFSOHVzOEZiTnQ3WUdPMnJE?=
 =?utf-8?B?R2d6TmhwUHAyZmFod3RyQ0dweGhuRVIvSnVBejRudWhBUWFDVlM4SStFdlVQ?=
 =?utf-8?B?Qyt3UVpCNDQ4ektOMWxGU3BldDl5b0MzK21Eb045M0VRdHBKSFUySExlckhR?=
 =?utf-8?B?TVBzQy9GWE1BOUthU0doNTVzSSt2ZkwwWGJJSkZyUDFKZVExanZibE1tWWN5?=
 =?utf-8?B?cGliR2FSVjhoUkUwTS9OYlpQZnVCaUhsOWs3ZnNtK0FMYXR4OGtSWlBicG01?=
 =?utf-8?B?cWtxRGVkZUlWYmczUHM0OVF5ZGFyWDkrSEQ3Zzd1bmx2aDRBSHpDUW1hS0FB?=
 =?utf-8?B?UCtXejUrcEdiNWp2WWZjcUh6eDFkdGxTN010SklpUWN6NmlIWnptcTg5blU4?=
 =?utf-8?B?ZDZ5ZUZPZU9OZDdybW83V3NvVTh1cEFCMVN6Z2FlYWQ0Zi9keFc2MHdWc1g3?=
 =?utf-8?B?TzVkNlFwTzRZSnJBbUg0UFBoNTc4cTRLRUxRL25qNDBaZE1mKzZVdTRXV2wv?=
 =?utf-8?B?VnJXcjlZS2MwejJPS1lCUm5JVXdkWEs3NXA4eDZqTVFXMjRZSjNQd3psWHZI?=
 =?utf-8?B?dWRBVlRTc24wOTVGOU5XK3pLL0xkNHM4RkFwcFIxOTdQWStTRisySXVQOGJt?=
 =?utf-8?B?czJMTjJSclZBVGViMGJCMzJQbHloVlN6aHQ2OGxKajlEaUFGdFpxTlpKOFpY?=
 =?utf-8?B?RXJycnZITU1vNzZ2bWxySHUyUjdtVlZ0R1I2ZXB1dU1NajZQNGkwV0lHaUVF?=
 =?utf-8?B?WDhUZ1llSUFOdGZDZWF0SFR5UENBcFRHalZGa0I2VEMrMjkzTmZTUFhXRytB?=
 =?utf-8?B?Z0lYblljbVM1VmwyeWNpdjJoZHhLQ3ArdzFqQStKREF1MVRCL2pRa0wzdmJj?=
 =?utf-8?B?WHhIOTNkbjRncFNJWGE4Z2JKclF0bmpuRmNPa25tUFJYWVdwWXEyci9BZEtC?=
 =?utf-8?B?bkhiYXV4SjhjWGJTK2Y1NndiZzgxdW9vZlJQN0d2MisxS0dwenhZYkdSYXJr?=
 =?utf-8?B?dXNRTit5NHhCUG1hOEVhTzNmY2RKanBFTDU5anE0WUpxS3RUdm54MTB0SVhP?=
 =?utf-8?B?VkMxakRLSktVYUIxVnBMeXY5bDRrbXdldmJZY2RtS20rNGlTcmtsTy9POTd3?=
 =?utf-8?B?S0J4MXJDYjN1K05ldmlVMUhBV1RNZ0ltWHliU1AyaGFLbTVZZmJJb2FuQ21a?=
 =?utf-8?B?T2pYdjh0eHpnQlZqTFlOUzdIbnA4eStrWWU5NWUwT1JOMVVzZ0dLWWJ5VVla?=
 =?utf-8?B?Mmd4RllFc0xRelhFUlByeWtpdGh6ODVhTmNEcXl5ZjI5dGJrbnU2THdqWlU0?=
 =?utf-8?Q?IywYfD2cH5CnDQMVpPQFFO4=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 25a8552c-e3eb-4a32-06e5-08d9f1fe208d
X-MS-Exchange-CrossTenant-AuthSource: DB6PR0802MB2374.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Feb 2022 10:13:22.2236
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yXFElfsFCMPhhV8NlyvVpzP+3RsNfPBIHJz3mlCWCnyxg95A3QagM2YORiH52dMUCxMvBZCpD+4c5HgSX4Q9Dw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR08MB5853
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


dm_cleanup_zoned_dev() uses queue, so it must be called
before blk_cleanup_disk() starts its killing:

blk_cleanup_disk->blk_cleanup_queue()->kobject_put()->blk_release_queue()->
->...RCU...->blk_free_queue_rcu()->kmem_cache_free()

Otherwise, RCU callback may be executed first,
and dm_cleanup_zoned_dev() touches freed memory:

 BUG: KASAN: use-after-free in dm_cleanup_zoned_dev+0x33/0xd0
 Read of size 8 at addr ffff88805ac6e430 by task dmsetup/681

 CPU: 4 PID: 681 Comm: dmsetup Not tainted 5.17.0-rc2+ #6
 Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.14.0-2 04/01/2014
 Call Trace:
  <TASK>
  dump_stack_lvl+0x57/0x7d
  print_address_description.constprop.0+0x1f/0x150
  ? dm_cleanup_zoned_dev+0x33/0xd0
  kasan_report.cold+0x7f/0x11b
  ? dm_cleanup_zoned_dev+0x33/0xd0
  dm_cleanup_zoned_dev+0x33/0xd0
  __dm_destroy+0x26a/0x400
  ? dm_blk_ioctl+0x230/0x230
  ? up_write+0xd8/0x270
  dev_remove+0x156/0x1d0
  ctl_ioctl+0x269/0x530
  ? table_clear+0x140/0x140
  ? lock_release+0xb2/0x750
  ? remove_all+0x40/0x40
  ? rcu_read_lock_sched_held+0x12/0x70
  ? lock_downgrade+0x3c0/0x3c0
  ? rcu_read_lock_sched_held+0x12/0x70
  dm_ctl_ioctl+0xa/0x10
  __x64_sys_ioctl+0xb9/0xf0
  do_syscall_64+0x3b/0x90
  entry_SYSCALL_64_after_hwframe+0x44/0xae
 RIP: 0033:0x7fb6dfa95c27
 Code: 00 00 00 48 8b 05 69 92 0c 00 64 c7 00 26 00 00 00 48 c7 c0 ff ff ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 b8 10 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 39 92 0c 00 f7 d8 64 89 01 48
 RSP: 002b:00007fff882c6c28 EFLAGS: 00000206 ORIG_RAX: 0000000000000010
 RAX: ffffffffffffffda RBX: 00007fb6dfb73a8e RCX: 00007fb6dfa95c27
 RDX: 00007fb6e01d7ca0 RSI: 00000000c138fd04 RDI: 0000000000000003
 RBP: 00007fff882c6ce0 R08: 00007fb6dfbc3558 R09: 00007fff882c6a90
 R10: 00007fb6dfbc28a2 R11: 0000000000000206 R12: 00007fb6dfbc28a2
 R13: 00007fb6dfbc28a2 R14: 00007fb6dfbc28a2 R15: 00007fb6dfbc28a2
  </TASK>

 Allocated by task 673:
  kasan_save_stack+0x1e/0x40
  __kasan_slab_alloc+0x66/0x80
  kmem_cache_alloc_node+0x1ca/0x460
  blk_alloc_queue+0x33/0x4e0
  __blk_alloc_disk+0x1b/0x60
  dm_create+0x368/0xa20
  dev_create+0xb9/0x170
  ctl_ioctl+0x269/0x530
  dm_ctl_ioctl+0xa/0x10
  __x64_sys_ioctl+0xb9/0xf0
  do_syscall_64+0x3b/0x90
  entry_SYSCALL_64_after_hwframe+0x44/0xae

 Freed by task 0:
  kasan_save_stack+0x1e/0x40
  kasan_set_track+0x21/0x30
  kasan_set_free_info+0x20/0x30
  __kasan_slab_free+0xfb/0x130
  slab_free_freelist_hook+0x7d/0x150
  kmem_cache_free+0x13c/0x340
  rcu_do_batch+0x2d9/0x820
  rcu_core+0x3b8/0x570
  __do_softirq+0x1c4/0x63d

 Last potentially related work creation:
  kasan_save_stack+0x1e/0x40
  __kasan_record_aux_stack+0x96/0xa0
  call_rcu+0xc4/0x8f0
  kobject_put+0xd9/0x270
  disk_release+0xee/0x120
  device_release+0x59/0xf0
  kobject_put+0xd9/0x270
  cleanup_mapped_device+0x12b/0x1b0
  __dm_destroy+0x26a/0x400
  dev_remove+0x156/0x1d0
  ctl_ioctl+0x269/0x530
  dm_ctl_ioctl+0xa/0x10
  __x64_sys_ioctl+0xb9/0xf0
  do_syscall_64+0x3b/0x90
  entry_SYSCALL_64_after_hwframe+0x44/0xae

 The buggy address belongs to the object at ffff88805ac6e180
  which belongs to the cache request_queue of size 2992
 The buggy address is located 688 bytes inside of
  2992-byte region [ffff88805ac6e180, ffff88805ac6ed30)
 The buggy address belongs to the page:
 page:000000000837df3c refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x5ac68
 head:000000000837df3c order:3 compound_mapcount:0 compound_pincount:0
 flags: 0xfffffc0010200(slab|head|node=0|zone=1|lastcpupid=0x1fffff)
 raw: 000fffffc0010200 0000000000000000 dead000000000122 ffff888001e58280
 raw: 0000000000000000 00000000800a000a 00000001ffffffff 0000000000000000
 page dumped because: kasan: bad access detected

 Memory state around the buggy address:
  ffff88805ac6e300: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
  ffff88805ac6e380: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 >ffff88805ac6e400: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                                      ^
  ffff88805ac6e480: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
  ffff88805ac6e500: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ==================================================================

Fixes: bb37d77239af "dm: introduce zone append emulation"
Signed-off-by: Kirill Tkhai <ktkhai@virtuozzo.com>
Reviewed-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
---
v2: Split long commit message line and delete [xxx] time prefix from kernel output.

 drivers/md/dm.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/md/dm.c b/drivers/md/dm.c
index dcbd6d201619..d472fe5dbc1d 100644
--- a/drivers/md/dm.c
+++ b/drivers/md/dm.c
@@ -1607,6 +1607,7 @@ static void cleanup_mapped_device(struct mapped_device *md)
 		md->dax_dev = NULL;
 	}
 
+	dm_cleanup_zoned_dev(md);
 	if (md->disk) {
 		spin_lock(&_minor_lock);
 		md->disk->private_data = NULL;
@@ -1627,7 +1628,6 @@ static void cleanup_mapped_device(struct mapped_device *md)
 	mutex_destroy(&md->swap_bios_lock);
 
 	dm_mq_cleanup_mapped_device(md);
-	dm_cleanup_zoned_dev(md);
 }
 
 /*

