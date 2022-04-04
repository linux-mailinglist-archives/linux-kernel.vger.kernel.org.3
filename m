Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB5744F0F65
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Apr 2022 08:31:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377441AbiDDGcW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Apr 2022 02:32:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234820AbiDDGcR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Apr 2022 02:32:17 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2054.outbound.protection.outlook.com [40.107.220.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D4D4237E2
        for <linux-kernel@vger.kernel.org>; Sun,  3 Apr 2022 23:30:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TLlXTZkOLiLIikTd0l+e6kp7iqf636SjAk6buAp0TpuJKnuqOnrphaxDyYIdenqs3V/k1IgTtII67DUIikffZy/qUO1iA5pEWxl9jIXPB4CWZuCVT5kgpOBsceTtEeT3BZiZ/jUoC4ZM6rBFQGDGMQp7xkrvruqlqOT8MGcoyk3yZqg4CiPRj6sonFvMpIk21IOnZAE3Uzh0Peg3kXOhTOwheb3++MKARlWk3cZqsTSw3CSbgahHqjKxde4gxSJRyPaShXa4u9zapBbxyy6l3BiJbdIBFhu4CHfLwORfbZe2G4e5xu2rrNwM+YQ2ORcHREFu9r6aA3s3nr06jaT0Zw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O5ZSYNPmskNA0/CROlgNVYKuHTtRD0EEZQU3d7T591M=;
 b=FFG1MdePLXo79QbezfPi8me3hWHt5YZBMqkZF73NmrGHYOw7CF/Xni+AMGXKGeFOLmrJ3a33H1CgWyeWfgcM6FYJuC8c8o6tI/7EhyF4rUYWACw+173IElCzATX/KwqnWK5x9tUccZJ9bTOEJgVO7UEs4B5TtuWzaDWDfrCjnlAni8cIA6DfdmHiWKFKhprT1NV2I2Zi8QwzE6Mk8slrdaU0uDKwmrh15Tx66VlGP50cs/uSxLU7UW7JFcrHssAxBuOwPMwfm4+gCBz7eCJ9kggW/CuME1Dr6vVphAgRhlV8ehNUd1eaABjgudnPVeLbUzTsf01behpHag0TApt8lw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O5ZSYNPmskNA0/CROlgNVYKuHTtRD0EEZQU3d7T591M=;
 b=tfE++kDv6E1q+sWRLNGdQhbZ1TYvtHkDtyD41WnAzLscAK/M0f1YsoPf/zJQMjhojGVnE8o7Rr3YEiXEj4anQua784iM4xD48+pSzqgCt2nazVMpfJqvHtxuLVyd419lrwG/oHKL+XRxu0FducHQ7utSxRlAHaw28Z8R83AWNvw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3587.namprd12.prod.outlook.com (2603:10b6:408:43::13)
 by BN8PR12MB2897.namprd12.prod.outlook.com (2603:10b6:408:99::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.31; Mon, 4 Apr
 2022 06:30:17 +0000
Received: from BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::404f:1fc8:9f4c:f185]) by BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::404f:1fc8:9f4c:f185%6]) with mapi id 15.20.5123.031; Mon, 4 Apr 2022
 06:30:17 +0000
Message-ID: <f3bc34e1-0eaf-84ef-486e-b7759e60b792@amd.com>
Date:   Mon, 4 Apr 2022 08:30:09 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [Bug][5.18-rc0] Between commits ed4643521e6a and 34af78c4e616,
 appears warning "WARNING: CPU: 31 PID: 51848 at
 drivers/dma-buf/dma-fence-array.c:191 dma_fence_array_create+0x101/0x120" and
 some games stopped working.
Content-Language: en-US
To:     Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        daniel.vetter@ffwll.ch, thomas.hellstrom@linux.intel.com,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>
References: <CABXGCsNVp=R5zC9B3PXWJ5nddtt3gkRzDsAsRKvhXq7exGjSAg@mail.gmail.com>
From:   =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
In-Reply-To: <CABXGCsNVp=R5zC9B3PXWJ5nddtt3gkRzDsAsRKvhXq7exGjSAg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AS9PR06CA0266.eurprd06.prod.outlook.com
 (2603:10a6:20b:45f::15) To BN8PR12MB3587.namprd12.prod.outlook.com
 (2603:10b6:408:43::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 74699044-24ee-419d-c770-08da160495ba
X-MS-TrafficTypeDiagnostic: BN8PR12MB2897:EE_
X-Microsoft-Antispam-PRVS: <BN8PR12MB2897642EB9251C6408BD181183E59@BN8PR12MB2897.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Zq3H+SSbzbh8MNQQl5DMC92D71j1Vr1/w4IVLuJYWnHZ757fJ36MDEHITXXdlnrdkaZ4lkdg+Su4s5owDDFehelqjjGUgvmLM132gddusdiODurVHXsDUdpT6irB94B7S6Ntx5z8v/HS+4feAkFuz7nwqy5aOXk/ePesEN7JfX66YDJFHMaNaok7yWD79YScWnvQ0YrSfjErx9bJ7J6DHudDqigIY/czmHEF9gEjk5eciO1gK8Punqoyf1wSfXbaURwfJ/LQi7rZ/2sDLwiJt2PpiG/Ehg0JwS7DXbNzDSeQk0SEpysZ7qMWj+WruXODCg9L4k2ckpLtyF+ftp+5oOBfuKfYXSwugT+i5sp6DklFf7XmiwPzvvzb/yYkhBlGTycVpobPpywzhRlMvNbHH9pDRnlTesnDa41TxVcwqO7i8WSReR68JEkKLjmJNkJAgTaESuefxs8spSPepBnpEbHvLJaI7f+vkzLs8xjRElyA25Xcseyh+Ew3OsnBwtf8Ezf6QBeo8YjBCYjLK6oJ7VnoiItqqh7DsoPCTUHtuBLNjML/W2uIw5DQ5mcwIFrMe7f+QicZm9dTI22NKCGAYLdjhipANhgeWwf/ISQyf/UZp0NSb4HMd+og+f1cNo4E1oV3sg4CpebT9ZwqdFXP9qVlNFwhUhL8Wk+t20pch7C6cC+uG66x57SFAYqGY8VixQuBq4SuIV5W9VRACCFK7y/R5InGe7bWU2156UhqsXTpS9m56NTGjSyr4CbNGvGvV1b3XCUHyI3hZ1kjk1idhCsu1iCVnIjZBCGFxnaUaSz+xXdwVXRzt1833mWO7VYhZmu19xFm+8Kce6/Y715VEQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR12MB3587.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(66476007)(66556008)(66946007)(8676002)(26005)(66574015)(186003)(2616005)(6666004)(45080400002)(508600001)(83380400001)(31696002)(86362001)(38100700002)(6512007)(6486002)(966005)(316002)(36756003)(110136005)(31686004)(6506007)(4001150100001)(2906002)(5660300002)(8936002)(30864003)(43740500002)(45980500001)(460985005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cTZIYjdWb2RmeENXYmFpTGhMZXJScjdLOFRJRGRwbklBa0hQSkVnMmF4VmQr?=
 =?utf-8?B?YXdLVHAxcmxGWnF4TDBKS0RzbG5GNU54WWZHRFZqTW1IekY2WFlPbitrSXZE?=
 =?utf-8?B?aVg1ZURodmY3cGtLNU1RMkg0V3pYdXFNM2I5R2JYNDZEbTVJWXRWSS9iengw?=
 =?utf-8?B?alRwWTFveE1zZkRFeWZYVmRJeUI5Ri9GVzJHNWdnckpTRUx3Nmw2aTUrL3FW?=
 =?utf-8?B?T1VVRll4NjFJOXowRWpuYndJRlFnOUdkY0VvR1J2U3lGdjZWNHZidEF4RDB3?=
 =?utf-8?B?QUl4YkdUTnFjRjJPTjRwcnllOHdKcW5COVovcU9rbjlSY0t3YzVhUzVZTW50?=
 =?utf-8?B?SitkWlhIeEQwQWE5aGliNEtGbGI2dHg2R3hBWVNjajV0Uk5qeUQrRFVrRG9L?=
 =?utf-8?B?T0JPckxwd0QwcktCcGlGK21BZmxDK2FjV2J1eVFoR0xoN2xXcUJIeTU2QW83?=
 =?utf-8?B?KzRlaUxLbGtTSFVrUjFmY3JzekpKUFdZeVVQZWpXMS9STEdvSVdadmpHa3hS?=
 =?utf-8?B?ZjRUa1RwMVNoT3QzcG1wM2MyZXRzMUl0c2pnUzBWQ3VlTWRuZFA0WUFlREdm?=
 =?utf-8?B?Nzg1REtLY0ZaTkdpQ0tQRDJ0ajEyek15Zk9pWGwrRVdqUit3S0dOLzEzWTFP?=
 =?utf-8?B?bG5QMzl3WlNrVFluYUpVZWNrd3JFL0FpNkpiWTNJV29JeEQ1UlUwTDBQd0sw?=
 =?utf-8?B?cWdIdVBpNWhIQUxxR3RXaElZMERuRGZlb2QwS2xhVkRLcGoyaFFkeEdNek12?=
 =?utf-8?B?d251QzRkVU9GUW9sNUVVVTlQU094MGxHaUl3VjBnTjJBdElkVm1PbEdpdDNT?=
 =?utf-8?B?WjF4MldxTDRKRXRZZGZLOU81dUxBYTJDT29Cajg3ZnpJQlV0SE8vVEVSOU5t?=
 =?utf-8?B?QjkyWXM0cnk5Q1k4OWtxSzA0akhRUnZnblR6RklISU5WNDBJOXZoSDBPSkM2?=
 =?utf-8?B?Nzk4VjdGekxVSXpVNmhtR1BlaVh3dE9rclFQbEhMWlo3dStyV05hbjVjVUFN?=
 =?utf-8?B?Y21QOURsU01OdDd5NnFoTmJIMENMbVlZNnFkOWJXUVE5UHVwZTJJaDl2SWdx?=
 =?utf-8?B?VEZOY3FzajF2QjdmOGhDaFNTcFFpMzVEbDVOUWh6OUUvSmRMWjZBUFArYU9z?=
 =?utf-8?B?VXVhSWdUZ1hIRlJFSVpQZkFRREt5RDBpMmhsczIwUC9scEJxQm5scXIzeVkw?=
 =?utf-8?B?OTJ6QmZhS3RZY3FuOFAzQmt0NVp3SnIxQm5xWTJuLzBoRGtoRWNoTnBhS0h2?=
 =?utf-8?B?TjVpTjkzUGlvMFc4OWNuL21NcE5aL3lkWERxN09sc21KY1pZWlJ5QWpDYXVN?=
 =?utf-8?B?aEJ1NkYxdjQwbjkwMG9kQnpybWk4cW0rRFNMVzNDYmQ2QVlGZEhBbGpWcTc3?=
 =?utf-8?B?TCt2aFFEUXBPQ0k3Y2t6ZFVHditpZkpiZ3lNY2wyQkoxTkxjTGYrRVNWa0lP?=
 =?utf-8?B?bS9YTUwxMS9LaFF3bFZOT3prVXpVUHFRekFnaDJTZWdEL0UxNGt5OU5SWjdP?=
 =?utf-8?B?aldreHhlVDhQNDFkdlJtRlcxYXVvUmhCY2lzdzQ2WFcxSjR0ZXVjSlQrS2oy?=
 =?utf-8?B?dUJkcHRUWURBOXppQU5iRTY3S0V1aDR6SXFyRUxzbmxXaGROdUtmT2dGcXNP?=
 =?utf-8?B?MTJOcE00TUFCSXBpVEJUQXIrNmxRdlRvVXEvbG9KZTZJV1VoS0kxcnk5eG9a?=
 =?utf-8?B?S2VaNDdVdFc2cjhyNEFkcjM2d2pwbU5nOTA4TXNTQjJycjBycnBRWXQ2dno1?=
 =?utf-8?B?Z2pjWFMzQTJ1UDdSVjBiS0RjMnRBRWZkZkh1bHZnOHpHRklBeTV6N1lPNjRu?=
 =?utf-8?B?ZHJhUU1OYkhTeDZ3TGJtVFRzYUtQMWRuVzV0aGJLU0pFQ29zck5JV2hkYWxV?=
 =?utf-8?B?ZGtzMjgwUWk2dk5KTHg2VHVJeWZWUWRnelhqYkdaTFZEMzhOT2xVT1NVZjZi?=
 =?utf-8?B?MElOMUFyUWkwWEZ0NnByVHcwTDh2S3JLNXM0V2pNQlBJL2tqU0FxWEhvUitn?=
 =?utf-8?B?SENnOEVtQTU2bzhQUHFJb2xEK2FINXViVndrK2dpeDRIZVc3T2I0RmF4eFRt?=
 =?utf-8?B?VC9jMFFVbk1INFU4YkxQY0Y4K3BxSUJpZnBmN3dPL2w3LzBLUGtSdTg4ODJS?=
 =?utf-8?B?cUJxaTArOTVqczVMRmhCZTI1RHJhd0xKdE9LT0M1bW40cTdLTFJMV2VxSU5P?=
 =?utf-8?B?V256TGI2VWplQ01sZGZBUHE4UDVJeXIxTnpXNDZaWEJGajE1MlN4NGthZEs2?=
 =?utf-8?B?aWprWTdFcUlLUURuT012VU56WjZjN3hQaUl3K0EybG5hdVhXUHFNalYxVE1q?=
 =?utf-8?B?UnFXdERMbHdybks5Q2s1anZFb1FrNTFoNmZrYWlPUlFwM1FyWVNiQT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 74699044-24ee-419d-c770-08da160495ba
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3587.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Apr 2022 06:30:17.7041
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1MMxAew2GWTiwS4iI0zIl1GEMWa+tdj/l1egie+L8FrLXqWOTHuiCPGWDoRNPmhT
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB2897
X-Spam-Status: No, score=-5.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mikhail,

those are two independent and already known problems.

The warning triggered from the sync_file is already fixed in 
drm-misc-next-fixes, but so far I couldn't figure out why the games 
suddenly doesn't work any more.

There is a bug report for that, but bisecting the changes didn't yielded 
anything valuable so far.

So if you can come up with something that would be rather valuable.

Regards,
Christian.

Am 03.04.22 um 20:39 schrieb Mikhail Gavrilov:
> Hi,
> Between commits ed4643521e6a and 34af78c4e616 something was broken.
> I noted that kernel log flooded with warning message "WARNING: CPU: 31
> PID: 51848 at drivers/dma-buf/dma-fence-array.c:191
> dma_fence_array_create+0x101/0x120" when some games are running:
> "Resident Evil Village", "Marvel's Avengers", "The Dark Pictures
> Anthology: House of Ashes".
>
> [16999.958726] ------------[ cut here ]------------
> [16999.958731] WARNING: CPU: 31 PID: 51848 at
> drivers/dma-buf/dma-fence-array.c:191
> dma_fence_array_create+0x101/0x120
> [16999.958738] Modules linked in: xone_gip_chatpad(OE)
> xone_gip_gamepad(OE) xone_gip_common(OE) ff_memless tls uinput rfcomm
> snd_seq_dummy snd_hrtimer snd_seq_midi snd_seq_midi_event nft_objref
> nf_conntrack_netbios_ns nf_conntrack_broadcast nft_fib_inet
> nft_fib_ipv4 nft_fib_ipv6 nft_fib nft_reject_inet nf_reject_ipv4
> nf_reject_ipv6 nft_reject nft_ct nft_chain_nat nf_nat nf_conntrack
> nf_defrag_ipv6 nf_defrag_ipv4 ip_set nf_tables nfnetlink qrtr bnep
> sunrpc binfmt_misc iwlmvm vfat intel_rapl_msr fat intel_rapl_common
> snd_hda_codec_realtek mac80211 snd_hda_codec_generic ledtrig_audio
> snd_hda_codec_hdmi libarc4 snd_hda_intel edac_mce_amd snd_intel_dspcfg
> snd_usb_audio snd_intel_sdw_acpi btusb kvm_amd snd_hda_codec btrtl
> btbcm iwlwifi btintel snd_hda_core snd_usbmidi_lib uvcvideo snd_hwdep
> kvm iwlmei snd_rawmidi videobuf2_vmalloc xone_dongle(OE)
> videobuf2_memops xone_gip_bus(OE) snd_seq btmtk videobuf2_v4l2
> videobuf2_common snd_seq_device irqbypass bluetooth cfg80211 snd_pcm
> rapl videodev
> [16999.958799]  eeepc_wmi asus_wmi snd_timer sparse_keymap
> platform_profile ecdh_generic video wmi_bmof pcspkr snd k10temp
> i2c_piix4 joydev mc soundcore rfkill mei acpi_cpufreq zram
> hid_logitech_hidpp hid_logitech_dj amdgpu drm_ttm_helper ttm
> crct10dif_pclmul ccp crc32_pclmul ucsi_ccg iommu_v2 crc32c_intel
> typec_ucsi gpu_sched ghash_clmulni_intel sp5100_tco drm_dp_helper
> typec igb nvme nvme_core dca wmi scsi_dh_rdac scsi_dh_emc scsi_dh_alua
> ip6_tables ip_tables dm_multipath ipmi_devintf ipmi_msghandler fuse
> [16999.958862] CPU: 31 PID: 51848 Comm: GWT.exe Tainted: G    B   W
> OEL   --------- ---
> 5.18.0-0.rc0.20220401gite8b767f5e04097a.15.fc37.x86_64 #1
> [16999.958865] Hardware name: System manufacturer System Product
> Name/ROG STRIX X570-I GAMING, BIOS 4204 02/24/2022
> [16999.958867] RIP: 0010:dma_fence_array_create+0x101/0x120
> [16999.958871] Code: 45 85 e4 75 10 eb 2a 48 81 fa c0 aa 52 ab 74 1a
> 83 e8 01 72 1c 48 63 d0 48 8b 54 d5 00 48 8b 52 08 48 81 fa 60 aa 52
> ab 75 dd <0f> 0b 83 e8 01 73 e4 48 83 c4 08 48 89 d8 5b 5d 41 5c 41 5d
> 41 5e
> [16999.958874] RSP: 0018:ffffb03c071f7e08 EFLAGS: 00010246
> [16999.958877] RAX: 0000000000000001 RBX: ffff98fdb03c6d00 RCX: 0000000000510e99
> [16999.958879] RDX: ffffffffab52aac0 RSI: ffff98fdb03c6d10 RDI: ffff98fdb03c6d00
> [16999.958880] RBP: ffff98fa31c59e40 R08: 0000000000000001 R09: 0000000000000000
> [16999.958882] R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000002
> [16999.958883] R13: 0000000000000000 R14: ffff98fdb03c6d40 R15: 0000000000000001
> [16999.958885] FS:  000000004789f640(0000) GS:ffff9907ea600000(0000)
> knlGS:0000000029b70000
> [16999.958887] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [16999.958888] CR2: 00007ff41eee8000 CR3: 000000002856a000 CR4: 0000000000350ee0
> [16999.958890] Call Trace:
> [16999.958893]  <TASK>
> [16999.958897]  sync_file_ioctl+0x83d/0x9f0
> [16999.958904]  __x64_sys_ioctl+0x8d/0xc0
> [16999.958908]  do_syscall_64+0x3a/0x80
> [16999.958913]  entry_SYSCALL_64_after_hwframe+0x44/0xae
> [16999.958917] RIP: 0033:0x7ff5e850b29f
> [16999.958941] Code: 00 48 89 44 24 18 31 c0 48 8d 44 24 60 c7 04 24
> 10 00 00 00 48 89 44 24 08 48 8d 44 24 20 48 89 44 24 10 b8 10 00 00
> 00 0f 05 <89> c2 3d 00 f0 ff ff 77 18 48 8b 44 24 18 64 48 2b 04 25 28
> 00 00
> [16999.958943] RSP: 002b:000000004789d540 EFLAGS: 00000246 ORIG_RAX:
> 0000000000000010
> [16999.958946] RAX: ffffffffffffffda RBX: 00007ff5d5637040 RCX: 00007ff5e850b29f
> [16999.958948] RDX: 000000004789d740 RSI: 00000000c0303e03 RDI: 0000000000000260
> [16999.958949] RBP: 0000000000000260 R08: 0000000000000001 R09: 0000000000000000
> [16999.958951] R10: 0000000000000000 R11: 0000000000000246 R12: 000000004789d740
> [16999.958953] R13: 0000000000000000 R14: 00000000c0303e03 R15: 0000000000000000
> [16999.958958]  </TASK>
> [16999.958959] irq event stamp: 0
> [16999.958961] hardirqs last  enabled at (0): [<0000000000000000>] 0x0
> [16999.958964] hardirqs last disabled at (0): [<ffffffffaa0e88c1>]
> copy_process+0x9f1/0x1e20
> [16999.958968] softirqs last  enabled at (0): [<ffffffffaa0e88c1>]
> copy_process+0x9f1/0x1e20
> [16999.958971] softirqs last disabled at (0): [<0000000000000000>] 0x0
> [16999.958974] ---[ end trace 0000000000000000 ]---
>
>
> The games "Forza Horizon 5", "Forza Horizon 4", "Cyberpunk 2077",
> "Ghostwire: Tokyo" stopped working. When these games crashed I again
> saw the same warning message as above [2]. Difference only in thead
> name and addresses.
>
> [  643.442353] ------------[ cut here ]------------
> [  643.442358] WARNING: CPU: 24 PID: 7824 at
> drivers/dma-buf/dma-fence-array.c:191
> dma_fence_array_create+0x101/0x120
> [  643.442364] Modules linked in: uinput rfcomm snd_seq_dummy
> snd_hrtimer snd_seq_midi snd_seq_midi_event nft_objref
> nf_conntrack_netbios_ns nf_conntrack_broadcast nft_fib_inet
> nft_fib_ipv4 nft_fib_ipv6 nft_fib nft_reject_inet nf_reject_ipv4
> nf_reject_ipv6 nft_reject nft_ct nft_chain_nat nf_nat nf_conntrack
> nf_defrag_ipv6 nf_defrag_ipv4 ip_set nf_tables nfnetlink qrtr bnep
> sunrpc binfmt_misc iwlmvm snd_hda_codec_realtek mac80211
> snd_hda_codec_generic vfat fat ledtrig_audio snd_hda_codec_hdmi
> intel_rapl_msr snd_hda_intel intel_rapl_common snd_intel_dspcfg
> libarc4 snd_intel_sdw_acpi snd_hda_codec edac_mce_amd snd_usb_audio
> iwlwifi snd_hda_core btusb uvcvideo snd_usbmidi_lib btrtl snd_hwdep
> snd_rawmidi btbcm videobuf2_vmalloc xone_dongle(OE) kvm_amd
> videobuf2_memops xone_gip_bus(OE) iwlmei videobuf2_v4l2 snd_seq
> btintel kvm eeepc_wmi btmtk asus_wmi snd_seq_device sparse_keymap
> videobuf2_common irqbypass platform_profile rapl bluetooth snd_pcm
> cfg80211 video pcspkr wmi_bmof k10temp i2c_piix4
> [  643.442406]  videodev snd_timer snd ecdh_generic joydev mc
> soundcore rfkill mei acpi_cpufreq scsi_dh_rdac scsi_dh_emc
> scsi_dh_alua dm_multipath zram hid_logitech_hidpp hid_logitech_dj
> amdgpu crct10dif_pclmul crc32_pclmul crc32c_intel drm_ttm_helper ttm
> iommu_v2 ucsi_ccg ccp ghash_clmulni_intel gpu_sched typec_ucsi
> sp5100_tco typec drm_dp_helper igb nvme nvme_core dca wmi ip6_tables
> ip_tables ipmi_devintf ipmi_msghandler fuse
> [  643.442427] CPU: 24 PID: 7824 Comm: GameThread Tainted: G    B   W
> OEL   --------- ---
> 5.18.0-0.rc0.20220325git34af78c4e616.7.fc37.x86_64 #1
> [  643.442430] Hardware name: System manufacturer System Product
> Name/ROG STRIX X570-I GAMING, BIOS 4204 02/24/2022
> [  643.442432] RIP: 0010:dma_fence_array_create+0x101/0x120
> [  643.442434] Code: 45 85 e4 75 10 eb 2a 48 81 fa c0 6a 52 a8 74 1a
> 83 e8 01 72 1c 48 63 d0 48 8b 54 d5 00 48 8b 52 08 48 81 fa 60 6a 52
> a8 75 dd <0f> 0b 83 e8 01 73 e4 48 83 c4 08 48 89 d8 5b 5d 41 5c 41 5d
> 41 5e
> [  643.442436] RSP: 0018:ffffb0c783ea7e08 EFLAGS: 00010246
> [  643.442437] RAX: 0000000000000001 RBX: ffffa0fe03e4d800 RCX: 0000000000003b48
> [  643.442439] RDX: ffffffffa8526ac0 RSI: ffffa0fe03e4d810 RDI: ffffa0fe03e4d800
> [  643.442440] RBP: ffffa0fb81c33e00 R08: 0000000000000001 R09: 0000000000000000
> [  643.442441] R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000002
> [  643.442442] R13: 0000000000000000 R14: ffffa0fe03e4d840 R15: 0000000000000001
> [  643.442443] FS:  000000007b59f640(0000) GS:ffffa10a68a00000(0000)
> knlGS:000000007a4f0000
> [  643.442445] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [  643.442446] CR2: 00007f632016f000 CR3: 00000003787f8000 CR4: 0000000000350ee0
> [  643.442448] Call Trace:
> [  643.442449]  <TASK>
> [  643.442453]  sync_file_ioctl+0x83d/0x9f0
> [  643.442457]  __x64_sys_ioctl+0x8d/0xc0
> [  643.442461]  do_syscall_64+0x3a/0x80
> [  643.442464]  entry_SYSCALL_64_after_hwframe+0x44/0xae
> [  643.442466] RIP: 0033:0x7f6377f0b29f
> [  643.442484] Code: 00 48 89 44 24 18 31 c0 48 8d 44 24 60 c7 04 24
> 10 00 00 00 48 89 44 24 08 48 8d 44 24 20 48 89 44 24 10 b8 10 00 00
> 00 0f 05 <89> c2 3d 00 f0 ff ff 77 18 48 8b 44 24 18 64 48 2b 04 25 28
> 00 00
> [  643.442486] RSP: 002b:000000007b59d540 EFLAGS: 00000246 ORIG_RAX:
> 0000000000000010
> [  643.442488] RAX: ffffffffffffffda RBX: 000000007f068600 RCX: 00007f6377f0b29f
> [  643.442489] RDX: 000000007b59d740 RSI: 00000000c0303e03 RDI: 000000000000011c
> [  643.442490] RBP: 000000000000011c R08: 0000000000000001 R09: 0000000000000000
> [  643.442491] R10: 0000000000000000 R11: 0000000000000246 R12: 000000007b59d740
> [  643.442492] R13: 0000000000000000 R14: 00000000c0303e03 R15: 0000000000000000
> [  643.442495]  </TASK>
> [  643.442496] irq event stamp: 0
> [  643.442497] hardirqs last  enabled at (0): [<0000000000000000>] 0x0
> [  643.442500] hardirqs last disabled at (0): [<ffffffffa70e8a5e>]
> copy_process+0x9fe/0x1ed0
> [  643.442503] softirqs last  enabled at (0): [<ffffffffa70e8a5e>]
> copy_process+0x9fe/0x1ed0
> [  643.442505] softirqs last disabled at (0): [<0000000000000000>] 0x0
> [  643.442507] ---[ end trace 0000000000000000 ]---
>
> Before 5.18 git34af78c4e616 I also saw warning message. But this
> message was another [1] "WARNING: CPU: 29 PID: 6282 at
> kernel/dma/debug.c:1162 debug_dma_map_sg+0x329/0x380". And it not
> affected for working the listed games.
>
>
> [  572.507688] ------------[ cut here ]------------
> [  572.507754] DMA-API: amdgpu 0000:0b:00.0: mapping sg segment longer
> than device claims to support [len=516096] [max=65536]
> [  572.507761] WARNING: CPU: 29 PID: 6282 at kernel/dma/debug.c:1162
> debug_dma_map_sg+0x329/0x380
> [  572.507768] Modules linked in: uinput rfcomm snd_seq_dummy
> snd_hrtimer snd_seq_midi snd_seq_midi_event nft_objref
> nf_conntrack_netbios_ns nf_conntrack_broadcast nft_fib_inet
> nft_fib_ipv4 nft_fib_ipv6 nft_fib nft_reject_inet nf_reject_ipv4
> nf_reject_ipv6 nft_reject nft_ct nft_chain_nat nf_nat nf_conntrack
> nf_defrag_ipv6 nf_defrag_ipv4 ip_set nf_tables nfnetlink qrtr bnep
> sunrpc binfmt_misc snd_hda_codec_realtek snd_hda_codec_generic iwlmvm
> intel_rapl_msr ledtrig_audio snd_hda_codec_hdmi intel_rapl_common vfat
> fat snd_hda_intel snd_intel_dspcfg snd_intel_sdw_acpi snd_hda_codec
> mac80211 edac_mce_amd snd_hda_core snd_usb_audio snd_usbmidi_lib
> snd_hwdep snd_rawmidi btusb kvm_amd btrtl snd_seq btbcm libarc4
> snd_seq_device btintel snd_pcm kvm iwlwifi uvcvideo xone_dongle(OE)
> btmtk videobuf2_vmalloc xone_gip_bus(OE) videobuf2_memops eeepc_wmi
> videobuf2_v4l2 asus_wmi iwlmei bluetooth sparse_keymap irqbypass
> videobuf2_common snd_timer platform_profile rapl video pcspkr wmi_bmof
> videodev k10temp
> [  572.507848]  i2c_piix4 snd cfg80211 joydev ecdh_generic mc
> soundcore rfkill mei acpi_cpufreq scsi_dh_rdac scsi_dh_emc
> scsi_dh_alua dm_multipath zram hid_logitech_hidpp hid_logitech_dj
> amdgpu crct10dif_pclmul crc32_pclmul crc32c_intel ucsi_ccg
> drm_ttm_helper ghash_clmulni_intel ttm sp5100_tco igb ccp typec_ucsi
> nvme iommu_v2 typec gpu_sched nvme_core dca wmi ip6_tables ip_tables
> ipmi_devintf ipmi_msghandler fuse
> [  572.507889] CPU: 29 PID: 6282 Comm: GameThread Tainted: G        W
> OEL   --------- ---
> 5.18.0-0.rc0.20220324gited4643521e6a.6.fc37.x86_64 #1
> [  572.507893] Hardware name: System manufacturer System Product
> Name/ROG STRIX X570-I GAMING, BIOS 4204 02/24/2022
> [  572.507895] RIP: 0010:debug_dma_map_sg+0x329/0x380
> [  572.507899] Code: 5c 24 10 8b 4c 24 18 48 8b 54 24 20 48 89 c6 44
> 8b 44 24 2c 48 c7 c7 90 40 84 9f 4c 89 5c 24 10 4c 89 4c 24 08 e8 57
> d6 c9 00 <0f> 0b 4c 8b 5c 24 10 4c 8b 4c 24 08 8b 15 75 4d 31 02 85 d2
> 0f 85
> [  572.507902] RSP: 0018:ffffb748d2917b50 EFLAGS: 00010282
> [  572.507906] RAX: 000000000000006e RBX: ffff9e1ad45540d0 RCX: 0000000000000000
> [  572.507908] RDX: 0000000000000001 RSI: ffffffff9f8a4b50 RDI: 00000000ffffffff
> [  572.507910] RBP: ffff9e1bfb936ea0 R08: 0000000000000000 R09: 00000000fff7ffff
> [  572.507913] R10: ffffb748d2917980 R11: ffff9e29ee2fffe8 R12: 0000000000000001
> [  572.507915] R13: 0000000000000004 R14: 0000000000000002 R15: ffff9e1ad22fe900
> [  572.507917] FS:  00007fb5dd637fc0(0000) GS:ffff9e29a9e00000(0000)
> knlGS:0000000067fe0000
> [  572.507919] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [  572.507922] CR2: 00007fb5db8af000 CR3: 00000002b492e000 CR4: 0000000000350ee0
> [  572.507924] Call Trace:
> [  572.507926]  <TASK>
> [  572.507934]  __dma_map_sg_attrs+0xb8/0xf0
> [  572.507939]  dma_map_sgtable+0x19/0x30
> [  572.507943]  amdgpu_bo_move+0x57c/0x6f0 [amdgpu]
> [  572.508064]  ? amdgpu_ttm_tt_populate+0x74/0x90 [amdgpu]
> [  572.508177]  ttm_bo_handle_move_mem+0x8c/0x190 [ttm]
> [  572.508186]  ttm_bo_validate+0xd7/0x150 [ttm]
> [  572.508191]  ? ww_mutex_lock+0x38/0xa0
> [  572.508197]  amdgpu_gem_userptr_ioctl+0x178/0x290 [amdgpu]
> [  572.508296]  ? amdgpu_bo_vm_destroy+0x80/0x80 [amdgpu]
> [  572.508399]  ? amdgpu_gem_create_ioctl+0x330/0x330 [amdgpu]
> [  572.508494]  drm_ioctl_kernel+0xa1/0x150
> [  572.508503]  drm_ioctl+0x21c/0x410
> [  572.508508]  ? amdgpu_gem_create_ioctl+0x330/0x330 [amdgpu]
> [  572.508605]  ? lock_release+0x14f/0x460
> [  572.508611]  ? _raw_spin_unlock_irqrestore+0x30/0x60
> [  572.508615]  ? lockdep_hardirqs_on+0x7d/0x100
> [  572.508619]  ? _raw_spin_unlock_irqrestore+0x40/0x60
> [  572.508624]  amdgpu_drm_ioctl+0x4a/0x80 [amdgpu]
> [  572.508719]  __x64_sys_ioctl+0x8d/0xc0
> [  572.508725]  do_syscall_64+0x3a/0x80
> [  572.508730]  entry_SYSCALL_64_after_hwframe+0x44/0xae
> [  572.508733] RIP: 0033:0x7fb5dd50b29f
> [  572.508754] Code: 00 48 89 44 24 18 31 c0 48 8d 44 24 60 c7 04 24
> 10 00 00 00 48 89 44 24 08 48 8d 44 24 20 48 89 44 24 10 b8 10 00 00
> 00 0f 05 <89> c2 3d 00 f0 ff ff 77 18 48 8b 44 24 18 64 48 2b 04 25 28
> 00 00
> [  572.508756] RSP: 002b:000000000027f680 EFLAGS: 00000246 ORIG_RAX:
> 0000000000000010
> [  572.508760] RAX: ffffffffffffffda RBX: 000000007f09bd10 RCX: 00007fb5dd50b29f
> [  572.508762] RDX: 000000000027f730 RSI: 00000000c0186451 RDI: 00000000000000bd
> [  572.508764] RBP: 000000000027f730 R08: 00007fb5dd5f7b00 R09: 0000000000000070
> [  572.508766] R10: 0000000000000000 R11: 0000000000000246 R12: 00000000c0186451
> [  572.508769] R13: 00000000000000bd R14: 000000000000000e R15: 000000007dcc0000
> [  572.508780]  </TASK>
> [  572.508782] irq event stamp: 4594699
> [  572.508784] hardirqs last  enabled at (4594707):
> [<ffffffff9e17a17e>] __up_console_sem+0x5e/0x70
> [  572.508788] hardirqs last disabled at (4594714):
> [<ffffffff9e17a163>] __up_console_sem+0x43/0x70
> [  572.508791] softirqs last  enabled at (4594478):
> [<ffffffff9e0f2cb1>] __irq_exit_rcu+0xd1/0x160
> [  572.508795] softirqs last disabled at (4594473):
> [<ffffffff9e0f2cb1>] __irq_exit_rcu+0xd1/0x160
> [  572.508798] ---[ end trace 0000000000000000 ]---
> [  577.607889] ------------[ cut here ]------------
> [  577.608030] WARNING: CPU: 27 PID: 6485 at
> drivers/gpu/drm/drm_syncobj.c:400 drm_syncobj_find_fence+0x224/0x2c0
> [  577.608045] Modules linked in: uinput rfcomm snd_seq_dummy
> snd_hrtimer snd_seq_midi snd_seq_midi_event nft_objref
> nf_conntrack_netbios_ns nf_conntrack_broadcast nft_fib_inet
> nft_fib_ipv4 nft_fib_ipv6 nft_fib nft_reject_inet nf_reject_ipv4
> nf_reject_ipv6 nft_reject nft_ct nft_chain_nat nf_nat nf_conntrack
> nf_defrag_ipv6 nf_defrag_ipv4 ip_set nf_tables nfnetlink qrtr bnep
> sunrpc binfmt_misc snd_hda_codec_realtek snd_hda_codec_generic iwlmvm
> intel_rapl_msr ledtrig_audio snd_hda_codec_hdmi intel_rapl_common vfat
> fat snd_hda_intel snd_intel_dspcfg snd_intel_sdw_acpi snd_hda_codec
> mac80211 edac_mce_amd snd_hda_core snd_usb_audio snd_usbmidi_lib
> snd_hwdep snd_rawmidi btusb kvm_amd btrtl snd_seq btbcm libarc4
> snd_seq_device btintel snd_pcm kvm iwlwifi uvcvideo xone_dongle(OE)
> btmtk videobuf2_vmalloc xone_gip_bus(OE) videobuf2_memops eeepc_wmi
> videobuf2_v4l2 asus_wmi iwlmei bluetooth sparse_keymap irqbypass
> videobuf2_common snd_timer platform_profile rapl video pcspkr wmi_bmof
> videodev k10temp
> [  577.609566]  i2c_piix4 snd cfg80211 joydev ecdh_generic mc
> soundcore rfkill mei acpi_cpufreq scsi_dh_rdac scsi_dh_emc
> scsi_dh_alua dm_multipath zram hid_logitech_hidpp hid_logitech_dj
> amdgpu crct10dif_pclmul crc32_pclmul crc32c_intel ucsi_ccg
> drm_ttm_helper ghash_clmulni_intel ttm sp5100_tco igb ccp typec_ucsi
> nvme iommu_v2 typec gpu_sched nvme_core dca wmi ip6_tables ip_tables
> ipmi_devintf ipmi_msghandler fuse
> [  577.609688] CPU: 27 PID: 6485 Comm: GameThread Tainted: G        W
> OEL   --------- ---
> 5.18.0-0.rc0.20220324gited4643521e6a.6.fc37.x86_64 #1
> [  577.609697] Hardware name: System manufacturer System Product
> Name/ROG STRIX X570-I GAMING, BIOS 4204 02/24/2022
> [  577.609704] RIP: 0010:drm_syncobj_find_fence+0x224/0x2c0
> [  577.609714] Code: 70 90 9f e8 1e 1c 76 ff e8 29 0f 50 00 8b 15 cf
> d6 af 01 85 d2 74 15 65 48 8b 04 25 80 1e 02 00 8b 80 78 0e 00 00 85
> c0 74 02 <0f> 0b 4c 89 e7 e8 62 e9 ff ff 49 89 45 00 48 85 c0 0f 85 2e
> fe ff
> [  577.609722] RSP: 0018:ffffb748d2d8fac0 EFLAGS: 00010202
> [  577.609731] RAX: 0000000000000001 RBX: 0000000000000002 RCX: ffff9e1c51140000
> [  577.609738] RDX: 0000000000000001 RSI: ffffffff9f81a22d RDI: ffffffff9f8bb1ce
> [  577.609744] RBP: ffffb748d2d8fb40 R08: 0000000000000002 R09: 0000000024924a83
> [  577.609751] R10: 0000000000000001 R11: 0000000000000000 R12: ffff9e1c74a3bf80
> [  577.609757] R13: ffffb748d2d8fb50 R14: 0000000000000011 R15: 0000000000001388
> [  577.609765] FS:  000000007d2af640(0000) GS:ffff9e29a9600000(0000)
> knlGS:000000007a4b0000
> [  577.609772] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [  577.609778] CR2: 00007fb5bb69b000 CR3: 00000002b492e000 CR4: 0000000000350ee0
> [  577.609786] Call Trace:
> [  577.609791]  <TASK>
> [  577.609801]  ? find_held_lock+0x32/0x80
> [  577.609811]  ? sched_clock_cpu+0xb/0xc0
> [  577.609824]  ? lock_release+0x14f/0x460
> [  577.609842]  amdgpu_syncobj_lookup_and_add_to_sync+0x24/0xb0 [amdgpu]
> [  577.610175]  amdgpu_cs_ioctl+0xcb5/0x20b0 [amdgpu]
> [  577.610476]  ? __lock_acquire+0x387/0x1ee0
> [  577.610554]  ? amdgpu_cs_find_mapping+0xe0/0xe0 [amdgpu]
> [  577.610845]  drm_ioctl_kernel+0xa1/0x150
> [  577.610865]  drm_ioctl+0x21c/0x410
> [  577.610880]  ? amdgpu_cs_find_mapping+0xe0/0xe0 [amdgpu]
> [  577.611208]  ? lock_release+0x14f/0x460
> [  577.611220]  ? _raw_spin_unlock_irqrestore+0x30/0x60
> [  577.611232]  ? lockdep_hardirqs_on+0x7d/0x100
> [  577.611242]  ? _raw_spin_unlock_irqrestore+0x40/0x60
> [  577.611260]  amdgpu_drm_ioctl+0x4a/0x80 [amdgpu]
> [  577.611548]  __x64_sys_ioctl+0x8d/0xc0
> [  577.611564]  do_syscall_64+0x3a/0x80
> [  577.611576]  entry_SYSCALL_64_after_hwframe+0x44/0xae
> [  577.611584] RIP: 0033:0x7fb5dd50b29f
> [  577.611614] Code: 00 48 89 44 24 18 31 c0 48 8d 44 24 60 c7 04 24
> 10 00 00 00 48 89 44 24 08 48 8d 44 24 20 48 89 44 24 10 b8 10 00 00
> 00 0f 05 <89> c2 3d 00 f0 ff ff 77 18 48 8b 44 24 18 64 48 2b 04 25 28
> 00 00
> [  577.611622] RSP: 002b:000000007d2ad3f0 EFLAGS: 00000246 ORIG_RAX:
> 0000000000000010
> [  577.611632] RAX: ffffffffffffffda RBX: 000000007d2ad6b8 RCX: 00007fb5dd50b29f
> [  577.611639] RDX: 000000007d2ad4d0 RSI: 00000000c0186444 RDI: 00000000000000bd
> [  577.611645] RBP: 000000007d2ad4d0 R08: 00007fb54c038b60 R09: 000000007d2ad490
> [  577.611651] R10: 000000007fe71860 R11: 0000000000000246 R12: 00000000c0186444
> [  577.611657] R13: 00000000000000bd R14: 000000007d2ad690 R15: 00007fb54c038c20
> [  577.611692]  </TASK>
> [  577.611698] irq event stamp: 7565
> [  577.611703] hardirqs last  enabled at (7573): [<ffffffff9e17a17e>]
> __up_console_sem+0x5e/0x70
> [  577.611713] hardirqs last disabled at (7580): [<ffffffff9e17a163>]
> __up_console_sem+0x43/0x70
> [  577.611722] softirqs last  enabled at (7416): [<ffffffff9e0f2cb1>]
> __irq_exit_rcu+0xd1/0x160
> [  577.611731] softirqs last disabled at (7409): [<ffffffff9e0f2cb1>]
> __irq_exit_rcu+0xd1/0x160
> [  577.611739] ---[ end trace 0000000000000000 ]---
>
> Unfortunately git bisect is not did not provide expected result due to
> the large number of failed builds [3].
>
> git bisect says that the code that prints the warnings was added by
> Christian König.
>
> $ git blame drivers/dma-buf/dma-fence-array.c -L 181,201 e8b767f5e04097a^
> Blaming lines:   9% (21/221), done.
> 0fd9803b985e5 drivers/dma-buf/dma-fence-array.c (Christian König
> 2022-01-19 11:40:21 +0100 181)          * containers or otherwise we
> run into recursion and potential kernel
> 0fd9803b985e5 drivers/dma-buf/dma-fence-array.c (Christian König
> 2022-01-19 11:40:21 +0100 182)          * stack overflow on operations
> on the dma_fence_array.
> 0fd9803b985e5 drivers/dma-buf/dma-fence-array.c (Christian König
> 2022-01-19 11:40:21 +0100 183)          *
> 0fd9803b985e5 drivers/dma-buf/dma-fence-array.c (Christian König
> 2022-01-19 11:40:21 +0100 184)          * The correct way of handling
> this is to flatten out the array by the
> 0fd9803b985e5 drivers/dma-buf/dma-fence-array.c (Christian König
> 2022-01-19 11:40:21 +0100 185)          * caller instead.
> 0fd9803b985e5 drivers/dma-buf/dma-fence-array.c (Christian König
> 2022-01-19 11:40:21 +0100 186)          *
> 0fd9803b985e5 drivers/dma-buf/dma-fence-array.c (Christian König
> 2022-01-19 11:40:21 +0100 187)          * Enforce this here by
> checking that we don't create a dma_fence_array
> 0fd9803b985e5 drivers/dma-buf/dma-fence-array.c (Christian König
> 2022-01-19 11:40:21 +0100 188)          * with any container inside.
> 0fd9803b985e5 drivers/dma-buf/dma-fence-array.c (Christian König
> 2022-01-19 11:40:21 +0100 189)          */
> 0fd9803b985e5 drivers/dma-buf/dma-fence-array.c (Christian König
> 2022-01-19 11:40:21 +0100 190)         while (num_fences--)
> 0fd9803b985e5 drivers/dma-buf/dma-fence-array.c (Christian König
> 2022-01-19 11:40:21 +0100 191)
> WARN_ON(dma_fence_is_container(fences[num_fences]));
> 0fd9803b985e5 drivers/dma-buf/dma-fence-array.c (Christian König
> 2022-01-19 11:40:21 +0100 192)
> b3dfbdf261e07 drivers/dma-buf/fence-array.c     (Gustavo Padovan
> 2016-06-01 15:10:03 +0200 193)         return array;
> b3dfbdf261e07 drivers/dma-buf/fence-array.c     (Gustavo Padovan
> 2016-06-01 15:10:03 +0200 194) }
> f54d1867005c3 drivers/dma-buf/dma-fence-array.c (Chris Wilson
> 2016-10-25 13:00:45 +0100 195) EXPORT_SYMBOL(dma_fence_array_create);
> d5b72a2123dfa drivers/dma-buf/dma-fence-array.c (Philipp Zabel
> 2017-03-17 17:34:49 +0100 196)
> d5b72a2123dfa drivers/dma-buf/dma-fence-array.c (Philipp Zabel
> 2017-03-17 17:34:49 +0100 197) /**
> d5b72a2123dfa drivers/dma-buf/dma-fence-array.c (Philipp Zabel
> 2017-03-17 17:34:49 +0100 198)  * dma_fence_match_context - Check if
> all fences are from the given context
> d5b72a2123dfa drivers/dma-buf/dma-fence-array.c (Philipp Zabel
> 2017-03-17 17:34:49 +0100 199)  * @fence:              [in]    fence
> or fence array
> d5b72a2123dfa drivers/dma-buf/dma-fence-array.c (Philipp Zabel
> 2017-03-17 17:34:49 +0100 200)  * @context:            [in]    fence
> context to check all fences against
>
> Christian can you lit the light on what's going on here?
> Thanks.
>
> [1] https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Fpastebin.com%2FtSWvLBus&amp;data=04%7C01%7Cchristian.koenig%40amd.com%7Cbc778b55f1b94b98191508da15a149f9%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637846080776251302%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000&amp;sdata=bs0G%2B7g8baraTiYldT0DmIaAMfxLxTGJZ%2Fj18OJqD4w%3D&amp;reserved=0
> [2] https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Fpastebin.com%2FVqNmYDm2&amp;data=04%7C01%7Cchristian.koenig%40amd.com%7Cbc778b55f1b94b98191508da15a149f9%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637846080776251302%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000&amp;sdata=ndYV9JGqqj7Qc4QLcRv2My%2BuKN4Y8GlDll6I0CNrZEg%3D&amp;reserved=0
> [3] https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Fpastebin.com%2FefHf3UF3&amp;data=04%7C01%7Cchristian.koenig%40amd.com%7Cbc778b55f1b94b98191508da15a149f9%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637846080776251302%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000&amp;sdata=ohOOaYemQAX%2FQOPEjuA6wXZn6h%2FlU5s2Ol9RssrOBUU%3D&amp;reserved=0
>

