Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 892B150343E
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Apr 2022 07:49:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229829AbiDPCYs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Apr 2022 22:24:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229931AbiDPCYa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Apr 2022 22:24:30 -0400
Received: from mail-oa1-x36.google.com (mail-oa1-x36.google.com [IPv6:2001:4860:4864:20::36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02F4EBC1E
        for <linux-kernel@vger.kernel.org>; Fri, 15 Apr 2022 19:22:00 -0700 (PDT)
Received: by mail-oa1-x36.google.com with SMTP id 586e51a60fabf-dacc470e03so9451757fac.5
        for <linux-kernel@vger.kernel.org>; Fri, 15 Apr 2022 19:21:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=NYONr+AFm2fCZTaj4r8wiIPrJ05AY/b2ZvfTRaJ/zOk=;
        b=Y82TPRjKvXw5A3p0jgGetMRUQsz82x8nctcpPl89tuxGOEpml5s9bRYf7r8fQykCSu
         bf2DSWe7ihyOLvgOh8Nws0s1ngVq1Dx5HO++KMOhXtxR8Kmd67jUP+dt6GqcTT0rWylL
         B6svIOzE5zozGCgRbKfOs2BEfvdIUrooR0wPs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=NYONr+AFm2fCZTaj4r8wiIPrJ05AY/b2ZvfTRaJ/zOk=;
        b=anVJFabcvJyha3UIrbbz9w6454BvoUz5NsOHI/lkDicTvjfLcnAmePxNlF+OzDuaDI
         zQkFkIDv5UuQUbkgBS5sjKA5EfvY96xbH7x+iIHl3zlh6eGzZ37X7wsXKLqfezYOQCcD
         29dq5j0/tlX3OgJ3E9fb8gMBzCIzmzdV9iKNPG+9Roso05nmx4zuiPX3dhMbJHLBA+wQ
         UH+na0XqeDJv8y9SR5h2W7UnDkrarixVZcU8k1WQc5kq3HoyuKPmKPYeZE+r7p4MRRfH
         M7XFzBfwx0WkWPIy6pWhaKrw3sDCoSk7qqaRMFO1iHoo/Iqg0IXuHtRV0uRy98HcwT/o
         DIxA==
X-Gm-Message-State: AOAM530ucc4nmsCuNV3MA2jO2h8Yos/2FF3ZmtW1qfYSqX7H5vA3i6Uu
        jr4UtdcHqHCvxEFD2RDk/RrGbSRb3e3TOA==
X-Google-Smtp-Source: ABdhPJxt5D6aE+sxh0PRA/fim3Hj0Z54qM9liaCFo3BWU7ZRz/wp6GzYikl4T/Ot0etDtdmLN26pUw==
X-Received: by 2002:a17:90a:9294:b0:1b9:48e9:a030 with SMTP id n20-20020a17090a929400b001b948e9a030mr6816647pjo.200.1650071141253;
        Fri, 15 Apr 2022 18:05:41 -0700 (PDT)
Received: from google.com ([240f:75:7537:3187:9147:3fb7:c742:81c2])
        by smtp.gmail.com with ESMTPSA id e16-20020a63ee10000000b0039d1c7e80bcsm5473311pgi.75.2022.04.15.18.05.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Apr 2022 18:05:40 -0700 (PDT)
Date:   Sat, 16 Apr 2022 10:05:33 +0900
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        Jaska Uimonen <jaska.uimonen@linux.intel.com>,
        =?iso-8859-1?Q?P=E9ter?= Ujfalusi 
        <peter.ujfalusi@linux.intel.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, Takashi Iwai <tiwai@suse.com>,
        Tomasz Figa <tfiga@chromium.org>,
        Mark Brown <broonie@kernel.org>,
        Ricardo Ribalda <ribalda@chromium.org>,
        sound-open-firmware@alsa-project.org
Subject: Re: out-of-bounds access in sound/soc/sof/topology.c
Message-ID: <YloWXZE/JjsIWAGH@google.com>
References: <Ylk5o3EC/hyX5UQ0@google.com>
 <8eeb08ec-4836-cf7d-2285-8ed74ccfc1cb@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8eeb08ec-4836-cf7d-2285-8ed74ccfc1cb@linux.intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On (22/04/15 11:00), Pierre-Louis Bossart wrote:
> > Now control data allocations looks as follows
> > 
> > 	scontrol->size = struct_size(scontrol->control_data, chanv,
> > 				     le32_to_cpu(mc->num_channels));
> > 	scontrol->control_data = kzalloc(scontrol->size, GFP_KERNEL);
> > 
> > Which is sizeof(sof_ipc_ctrl_data) + mc->num_channels * sizeof(sof_ipc_ctrl_value_chan)

[..]

> 
> I checked the v5.10.111 code and I see the same code, with the max_size being used for sof_control_load_bytes() and no channel-based arithmetic.
> 
> Can I ask how you found out about this problem, is this the result of a warning/error reported by a software tool or based on your reviews of the code?

I some KASAN warnings, confirmed. This appears to be when control_data is
allocated as control_data.chanv

	scontrol->size = 92 + 1 * sizeof(sof_ipc_ctrl_value_chan)

but being dereferenced as it was control_data.data, so the 8 bytes
"payload" is being used as a 32 bytes "payload".

I'd say the first one is scarier than the second one. This should be
two data->size and one data->data accesses in sof_process_load()

        if (ipc_data_size) {
                for (i = 0; i < widget->num_kcontrols; i++) {
                        memcpy(&process->data[offset],
                               wdata[i].pdata->data,
                               wdata[i].pdata->size);
                        offset += wdata[i].pdata->size;
                }
        }

    [   21.493203] ==================================================================
    [   21.493254] BUG: KASAN: slab-out-of-bounds in sof_widget_ready+0x1710/0x20a8 [snd_sof]
    [   21.493276] Read of size 4 at addr ffff888101d25865 by task udevd/2538
    
    [   21.493317] CPU: 6 PID: 2538 Comm: udevd Tainted: G     U            5.10.111 #20 f82fe8812f39d1966e2c6a66cfdb6cc00489a69b
    [   21.493364] Call Trace:
    [   21.493424]  dump_stack+0xb1/0x111
    [   21.493478]  print_address_description+0x25/0x4fe
    [   21.493521]  ? printk+0x76/0x96
    [   21.493568]  kasan_report+0x14f/0x190
    [   21.493639]  ? sof_widget_ready+0x1710/0x20a8 [snd_sof 35e04f225667e77b61e030d236a681f127c4c356]
    [   21.493708]  ? sof_widget_ready+0x1710/0x20a8 [snd_sof 35e04f225667e77b61e030d236a681f127c4c356]
    [   21.493756]  check_memory_region+0x17f/0x183
    [   21.493825]  sof_widget_ready+0x1710/0x20a8 [snd_sof 35e04f225667e77b61e030d236a681f127c4c356]
    [   21.493910]  ? sof_route_unload+0xb8/0xb8 [snd_sof 35e04f225667e77b61e030d236a681f127c4c356]
    [   21.493959]  soc_tplg_dapm_widget_elems_load+0x14c2/0x1758
    [   21.494035]  ? soc_tplg_dapm_graph_elems_load+0x320/0x320
    [   21.494079]  snd_soc_tplg_component_load+0x309/0x5d7
    [   21.494156]  snd_sof_load_topology+0x78/0x115 [snd_sof 35e04f225667e77b61e030d236a681f127c4c356]
    [   21.494228]  sof_pcm_probe+0xa4/0xd7 [snd_sof 35e04f225667e77b61e030d236a681f127c4c356]
    [   21.494277]  snd_soc_component_probe+0x3b/0x99
    [   21.494321]  soc_probe_component+0x2a3/0x4fc
    [   21.494365]  snd_soc_bind_card+0x83c/0xfe3
    [   21.494426]  devm_snd_soc_register_card+0x48/0x83
    [   21.494474]  platform_drv_probe+0x88/0xac
    [   21.494519]  really_probe+0x1b2/0x4f1
    [   21.494565]  driver_probe_device+0x98/0xd7
    [   21.494609]  device_driver_attach+0x71/0x96
    [   21.494651]  __driver_attach+0xda/0xe5
    [   21.494691]  ? driver_attach+0x2d/0x2d
    [   21.494733]  bus_for_each_dev+0xcc/0x102
    [   21.494779]  bus_add_driver+0x1cb/0x2e3
    [   21.494827]  driver_register+0xd7/0x19c
    [   21.494867]  ? 0xffffffffc0c60000
    [   21.494909]  do_one_initcall+0x158/0x30c
    [   21.494967]  ? intel_bw_atomic_check+0x3ef/0x67b
    [   21.495014]  do_init_module+0xe5/0x2dc
    [   21.495060]  load_module+0x3d0b/0x411a
    [   21.495129]  ? __kasan_slab_free+0x128/0x144
    [   21.495175]  __se_sys_finit_module+0x13e/0x166
    [   21.495227]  do_syscall_64+0x43/0x55
    [   21.495272]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
    [   21.495314] RIP: 0033:0x7ee05f706899
    [   21.495362] Code: 48 8d 3d 9a bd 0c 00 0f 05 eb ad 66 0f 1f 44 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 9f 85 0c 00 f7 d8 64 89 01 48
    [   21.495404] RSP: 002b:00007ffc67d1a128 EFLAGS: 00000246 ORIG_RAX: 0000000000000139
    [   21.495464] RAX: ffffffffffffffda RBX: 0000000000000004 RCX: 00007ee05f706899
    [   21.495500] RDX: 0000000000000004 RSI: 00007ee05f7f8adb RDI: 0000000000000018
    [   21.495537] RBP: 00007ffc67d1a190 R08: 000056d1041460d0 R09: 00007ffc67d1a190
    [   21.495572] R10: 00000000003ebf60 R11: 0000000000000246 R12: 0000000000020000
    [   21.495608] R13: 000056d102cbf6b0 R14: 0000000000000000 R15: 00007ee05f7f8adb
    
    [   21.495659] Allocated by task 2538:
    [   21.495680]  stack_trace_save+0x89/0xb8
    [   21.495698]  kasan_save_stack+0x36/0x56
    [   21.495715]  __kasan_kmalloc+0xf5/0x10c
    [   21.495734]  __kmalloc+0xf4/0x2d2
    [   21.495762]  sof_control_load+0x17c/0xaf9 [snd_sof]
    [   21.495782]  soc_tplg_dapm_widget_elems_load+0xfa5/0x1758
    [   21.495801]  snd_soc_tplg_component_load+0x309/0x5d7
    [   21.495828]  snd_sof_load_topology+0x78/0x115 [snd_sof]
    [   21.495854]  sof_pcm_probe+0xa4/0xd7 [snd_sof]
    [   21.495873]  snd_soc_component_probe+0x3b/0x99
    [   21.495890]  soc_probe_component+0x2a3/0x4fc
    [   21.495907]  snd_soc_bind_card+0x83c/0xfe3
    [   21.495925]  devm_snd_soc_register_card+0x48/0x83
    [   21.495944]  platform_drv_probe+0x88/0xac
    [   21.495963]  really_probe+0x1b2/0x4f1
    [   21.495981]  driver_probe_device+0x98/0xd7
    [   21.495998]  device_driver_attach+0x71/0x96
    [   21.496015]  __driver_attach+0xda/0xe5
    [   21.496033]  bus_for_each_dev+0xcc/0x102
    [   21.496051]  bus_add_driver+0x1cb/0x2e3
    [   21.496073]  driver_register+0xd7/0x19c
    [   21.496095]  do_one_initcall+0x158/0x30c
    [   21.496112]  do_init_module+0xe5/0x2dc
    [   21.496129]  load_module+0x3d0b/0x411a
    [   21.496146]  __se_sys_finit_module+0x13e/0x166
    [   21.496164]  do_syscall_64+0x43/0x55
    [   21.496183]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
    
    [   21.496212] The buggy address belongs to the object at ffff888101d25800
                    which belongs to the cache kmalloc-128 of size 128
    [   21.496232] The buggy address is located 101 bytes inside of
                    128-byte region [ffff888101d25800, ffff888101d25880)
    [   21.496247] The buggy address belongs to the page:
    [   21.496270] page:000000001cb121a9 refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x101d24
    [   21.496287] head:000000001cb121a9 order:1 compound_mapcount:0
    [   21.496305] flags: 0x8000000000010200(slab|head)
    [   21.496329] raw: 8000000000010200 ffffea0004268c80 0000000700000007 ffff888100043680
    [   21.496351] raw: 0000000000000000 0000000080200020 00000001ffffffff 0000000000000000
    [   21.496366] page dumped because: kasan: bad access detected
    
    [   21.496390] Memory state around the buggy address:
    [   21.496408]  ffff888101d25700: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
    [   21.496424]  ffff888101d25780: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
    [   21.496440] >ffff888101d25800: 00 00 00 00 00 00 00 00 00 00 00 00 05 fc fc fc
    [   21.496455]                                                        ^
    [   21.496472]  ffff888101d25880: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
    [   21.496488]  ffff888101d25900: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
    [   21.496501] ==================================================================

The seconds one is sof_get_control_data()

		*size += wdata[i].pdata->size;

    [   20.174619] ==================================================================
    [   20.174672] BUG: KASAN: slab-out-of-bounds in sof_widget_ready+0x1485/0x1f15 [snd_sof]
    [   20.174694] Read of size 4 at addr ffff88813f66aa64 by task udevd/2525
    
    [   20.174735] CPU: 6 PID: 2525 Comm: udevd Tainted: G     U            5.10.111 #15 0affb963ab1ae58c88daed12d4caa605c5149ad7
    [   20.174768] Call Trace:
    [   20.174797]  dump_stack+0xb1/0x111
    [   20.174823]  print_address_description+0x25/0x4fe
    [   20.174844]  ? printk+0x76/0x96
    [   20.174866]  kasan_report+0x14f/0x190
    [   20.174898]  ? sof_widget_ready+0x1485/0x1f15 [snd_sof ed49f3db2df0d72704365322eabcc747c7cbe78c]
    [   20.174929]  ? sof_widget_ready+0x12cb/0x1f15 [snd_sof ed49f3db2df0d72704365322eabcc747c7cbe78c]
    [   20.174958]  ? sof_widget_ready+0x1485/0x1f15 [snd_sof ed49f3db2df0d72704365322eabcc747c7cbe78c]
    [   20.174980]  check_memory_region+0x17f/0x183
    [   20.175010]  sof_widget_ready+0x1485/0x1f15 [snd_sof ed49f3db2df0d72704365322eabcc747c7cbe78c]
    [   20.175048]  ? sof_route_unload+0xb8/0xb8 [snd_sof ed49f3db2df0d72704365322eabcc747c7cbe78c]
    [   20.175072]  soc_tplg_dapm_widget_elems_load+0x14c2/0x1758
    [   20.175108]  ? soc_tplg_dapm_graph_elems_load+0x320/0x320
    [   20.175128]  snd_soc_tplg_component_load+0x309/0x5d7
    [   20.175163]  snd_sof_load_topology+0x78/0x115 [snd_sof ed49f3db2df0d72704365322eabcc747c7cbe78c]
    [   20.175196]  sof_pcm_probe+0xa4/0xd7 [snd_sof ed49f3db2df0d72704365322eabcc747c7cbe78c]
    [   20.175220]  snd_soc_component_probe+0x3b/0x99
    [   20.175240]  soc_probe_component+0x2a3/0x4fc
    [   20.175261]  snd_soc_bind_card+0x83c/0xfe3
    [   20.175288]  devm_snd_soc_register_card+0x48/0x83
    [   20.175310]  platform_drv_probe+0x88/0xac
    [   20.175331]  really_probe+0x1b2/0x4f1
    [   20.175352]  driver_probe_device+0x98/0xd7
    [   20.175372]  device_driver_attach+0x71/0x96
    [   20.175392]  __driver_attach+0xda/0xe5
    [   20.175410]  ? driver_attach+0x2d/0x2d
    [   20.175429]  bus_for_each_dev+0xcc/0x102
    [   20.175451]  bus_add_driver+0x1cb/0x2e3
    [   20.175473]  driver_register+0xd7/0x19c
    [   20.175492]  ? 0xffffffffc0ec8000
    [   20.175512]  do_one_initcall+0x158/0x30c
    [   20.175539]  ? intel_bw_atomic_check+0x3ef/0x67b
    [   20.175561]  do_init_module+0xe5/0x2dc
    [   20.175582]  load_module+0x3d0b/0x411a
    [   20.175615]  ? __kasan_slab_free+0x128/0x144
    [   20.175636]  __se_sys_finit_module+0x13e/0x166
    [   20.175659]  do_syscall_64+0x43/0x55
    [   20.175681]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
    [   20.175699] RIP: 0033:0x78e6c3948899
    [   20.175722] Code: 48 8d 3d 9a bd 0c 00 0f 05 eb ad 66 0f 1f 44 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 9f 85 0c 00 f7 d8 64 89 01 48
    [   20.175741] RSP: 002b:00007ffff7b907a8 EFLAGS: 00000246 ORIG_RAX: 0000000000000139
    [   20.175768] RAX: ffffffffffffffda RBX: 0000000000000004 RCX: 000078e6c3948899
    [   20.175785] RDX: 0000000000000004 RSI: 000078e6c3a3aadb RDI: 0000000000000017
    [   20.175802] RBP: 00007ffff7b90810 R08: 00005a58cc4cde40 R09: 00007ffff7b90810
    [   20.175818] R10: 00000000003ebf60 R11: 0000000000000246 R12: 0000000000020000
    [   20.175834] R13: 00005a58cb0486b0 R14: 0000000000000000 R15: 000078e6c3a3aadb
    
    [   20.175865] Allocated by task 2525:
    [   20.175885]  stack_trace_save+0x89/0xb8
    [   20.175903]  kasan_save_stack+0x36/0x56
    [   20.175920]  __kasan_kmalloc+0xf5/0x10c
    [   20.175940]  __kmalloc+0xf4/0x2d2
    [   20.175966]  sof_control_load+0x17c/0xaf4 [snd_sof]
    [   20.175986]  soc_tplg_dapm_widget_elems_load+0xfa5/0x1758
    [   20.176005]  snd_soc_tplg_component_load+0x309/0x5d7
    [   20.176032]  snd_sof_load_topology+0x78/0x115 [snd_sof]
    [   20.176058]  sof_pcm_probe+0xa4/0xd7 [snd_sof]
    [   20.176076]  snd_soc_component_probe+0x3b/0x99
    [   20.176093]  soc_probe_component+0x2a3/0x4fc
    [   20.176109]  snd_soc_bind_card+0x83c/0xfe3
    [   20.176127]  devm_snd_soc_register_card+0x48/0x83
    [   20.176145]  platform_drv_probe+0x88/0xac
    [   20.176162]  really_probe+0x1b2/0x4f1
    [   20.176179]  driver_probe_device+0x98/0xd7
    [   20.176197]  device_driver_attach+0x71/0x96
    [   20.176214]  __driver_attach+0xda/0xe5
    [   20.176232]  bus_for_each_dev+0xcc/0x102
    [   20.176249]  bus_add_driver+0x1cb/0x2e3
    [   20.176267]  driver_register+0xd7/0x19c
    [   20.176285]  do_one_initcall+0x158/0x30c
    [   20.176302]  do_init_module+0xe5/0x2dc
    [   20.176319]  load_module+0x3d0b/0x411a
    [   20.176336]  __se_sys_finit_module+0x13e/0x166
    [   20.176353]  do_syscall_64+0x43/0x55
    [   20.176371]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
    
    [   20.176400] The buggy address belongs to the object at ffff88813f66aa00
                    which belongs to the cache kmalloc-128 of size 128
    [   20.176420] The buggy address is located 100 bytes inside of
                    128-byte region [ffff88813f66aa00, ffff88813f66aa80)
    [   20.176434] The buggy address belongs to the page:
    [   20.176457] page:0000000032124a7f refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x13f66a
    [   20.176475] head:0000000032124a7f order:1 compound_mapcount:0
    [   20.176493] flags: 0x8000000000010200(slab|head)
    [   20.176517] raw: 8000000000010200 dead000000000100 dead000000000122 ffff888100043680
    [   20.176539] raw: 0000000000000000 0000000080200020 00000001ffffffff 0000000000000000
    [   20.176554] page dumped because: kasan: bad access detected
    
    [   20.176578] Memory state around the buggy address:
    [   20.176596]  ffff88813f66a900: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 04 fc
    [   20.176614]  ffff88813f66a980: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
    [   20.176631] >ffff88813f66aa00: 00 00 00 00 00 00 00 00 00 00 00 00 04 fc fc fc
    [   20.176646]                                                        ^
    [   20.176664]  ffff88813f66aa80: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
    [   20.176680]  ffff88813f66ab00: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
    [   20.176694] ==================================================================
