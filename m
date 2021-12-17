Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E11AD478E71
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Dec 2021 15:51:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237584AbhLQOvg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Dec 2021 09:51:36 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:28573 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237552AbhLQOvf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Dec 2021 09:51:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1639752695;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7G7kLBf3cDTmAHD3fTDS43u/Jr145OqPL9rk19ivgYE=;
        b=QvvJ1jUH8XfVTe8m9RLIBpt7CXKetr1CWjTs75ewUF9oOoC1Xm6senUVu5B2HW/rLFlaNU
        DuWENRgfPBMwxkiOPaPbNrJBPUTCBI4QEs0xpd8hJasn8X8hfetvFx9RQP6b1qHwUDKRzj
        XiLiYdTi0e4n/2XdR8NXB/Wq7VknKqM=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-557-PT2Hkl4YNk6Rbe19wioBnw-1; Fri, 17 Dec 2021 09:51:33 -0500
X-MC-Unique: PT2Hkl4YNk6Rbe19wioBnw-1
Received: by mail-wm1-f69.google.com with SMTP id o18-20020a05600c511200b00332fa17a02eso1148833wms.5
        for <linux-kernel@vger.kernel.org>; Fri, 17 Dec 2021 06:51:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent
         :content-language:to:cc:references:from:organization:subject
         :in-reply-to:content-transfer-encoding;
        bh=7G7kLBf3cDTmAHD3fTDS43u/Jr145OqPL9rk19ivgYE=;
        b=k39wALuT3yWj2MGHefGhg7iiv6Sr+i6nLo84mpnzEWxz1W/QXZn2GBuOG262ASwUiz
         y6vyyFsQ/q6j1zRrauKNSahq9ZGalGR39R2kHU1M8+hp4RykTKye/HDo7CkuWofSudGz
         0cJfZ2Aw42qYWhCysrIrJHO/xjhwV6JAft1rRJ/3zyW8HvNgLSi6epI+gDzuEN859Rx4
         CQNKi1Dwn7SwGh4dqeQAlZ1Nnj8aJD0EZKuG1Xk0JzemdI8J9TSqqdDdn4ABmN47vP4V
         m/JgaqvwJegnEOs1liGTTg7GDRFN0dyRXMvfcmieRlEUrhQp26+5Fz/obuZX6B1JJ9Ig
         kdRQ==
X-Gm-Message-State: AOAM532aYPqhTRCTcviwgGw3CwJfJ8Ct03k5tmqc/4M+pXntDxFjUlMW
        XOrtVQWZTjS1lRYo3Pkk9t9py0t059tB/WFNzLk0II7T6ws5MXPZJgFGrW9DR9V6D3hHb7QPvwp
        66sA251/l7ToR1u/v7KAV+v8e
X-Received: by 2002:a5d:6785:: with SMTP id v5mr2885219wru.380.1639752692682;
        Fri, 17 Dec 2021 06:51:32 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzNytwfA2+wqF/zQUFyw6Kzo54wqJWMA415K6kBZSHpX1HJ4kxzLXiIcvCZ83/k5QSVwQrpfg==
X-Received: by 2002:a5d:6785:: with SMTP id v5mr2885198wru.380.1639752692369;
        Fri, 17 Dec 2021 06:51:32 -0800 (PST)
Received: from [192.168.3.132] (p4ff234b8.dip0.t-ipconnect.de. [79.242.52.184])
        by smtp.gmail.com with ESMTPSA id d2sm7258316wmb.31.2021.12.17.06.51.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Dec 2021 06:51:31 -0800 (PST)
Message-ID: <6e5ebc19-890c-b6dd-1924-9f25c441010d@redhat.com>
Date:   Fri, 17 Dec 2021 15:51:31 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Content-Language: en-US
To:     Michal Hocko <mhocko@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexey Makhalov <amakhalov@vmware.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, linux-mm@kvack.org,
        Dennis Zhou <dennis@kernel.org>,
        Eric Dumazet <eric.dumazet@gmail.com>,
        Oscar Salvador <osalvador@suse.de>, Tejun Heo <tj@kernel.org>,
        Christoph Lameter <cl@linux.com>,
        Nico Pache <npache@redhat.com>
References: <YbHfBgPQMkjtuHYF@dhcp22.suse.cz>
 <20211214100732.26335-1-mhocko@kernel.org>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH v2 0/4] mm, memory_hotplug: handle unitialized numa node
 gracefully
In-Reply-To: <20211214100732.26335-1-mhocko@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14.12.21 11:07, Michal Hocko wrote:
> Hi,
> this should be the full bundle for now. I have ended up with 4 patches.
> The primary fix is patch 2 (should be reasonably easy to backport to
> older kernels if there is any need for that). Patches 3 and 4 are mere
> clean ups.
> 
> I will repost once this can get some testing from Alexey. Shouldn't be
> too much different from http://lkml.kernel.org/r/YbHfBgPQMkjtuHYF@dhcp22.suse.cz
> with the follow up fix squashed in.
> 
> I would really appreciate to hear more about http://lkml.kernel.org/r/YbMZsczMGpChaWz0@dhcp22.suse.cz
> because I would like to add that information to the changelog as well.
> 
> Thanks for the review and testing.

Playing with memory hotplug only (only one hotpluggable node is possible with QEMU right now as only one will get added to SRAT with the hotplug range)

Start with one empty node:

#! /bin/bash
sudo qemu/build/qemu-system-x86_64 \
    --enable-kvm \
    -m 8G,slots=2,maxmem=16G \
    -object memory-backend-ram,id=mem0,size=4G \
    -object memory-backend-ram,id=mem1,size=4G \
    -numa node,cpus=0-1,nodeid=0,memdev=mem0 \
    -numa node,cpus=2-3,nodeid=1,memdev=mem1 \
    -numa node,nodeid=2 \
    -smp 4 \
    -drive file=/home/dhildenb/git/Fedora-Cloud-Base-33-1.2.x86_64.qcow2,format=qcow2,if=virtio \
    -cpu host \
    -machine q35 \
    -nographic \
    -nodefaults \
    -monitor unix:/var/tmp/monitor,server,nowait \
    -chardev stdio,id=serial,signal=off \
    -device isa-serial,chardev=serial

1. Guest state when booting

[    0.002506] SRAT: PXM 0 -> APIC 0x00 -> Node 0
[    0.002508] SRAT: PXM 0 -> APIC 0x01 -> Node 0
[    0.002510] SRAT: PXM 1 -> APIC 0x02 -> Node 1
[    0.002511] SRAT: PXM 1 -> APIC 0x03 -> Node 1
[    0.002513] ACPI: SRAT: Node 0 PXM 0 [mem 0x00000000-0x0009ffff]
[    0.002515] ACPI: SRAT: Node 0 PXM 0 [mem 0x00100000-0x7fffffff]
[    0.002517] ACPI: SRAT: Node 0 PXM 0 [mem 0x100000000-0x17fffffff]
[    0.002518] ACPI: SRAT: Node 1 PXM 1 [mem 0x180000000-0x27fffffff]
[    0.002520] ACPI: SRAT: Node 2 PXM 2 [mem 0x280000000-0x4ffffffff] hotplug
[    0.002523] NUMA: Node 0 [mem 0x00000000-0x0009ffff] + [mem 0x00100000-0x7fffffff] -> [mem 0x00000000
-0x7fffffff]
[    0.002525] NUMA: Node 0 [mem 0x00000000-0x7fffffff] + [mem 0x100000000-0x17fffffff] -> [mem 0x000000
00-0x17fffffff]
[    0.002533] NODE_DATA(0) allocated [mem 0x17ffd5000-0x17fffffff]
[    0.002716] NODE_DATA(1) allocated [mem 0x27ffd5000-0x27fffffff]
[    0.017960] Zone ranges:
[    0.017966]   DMA      [mem 0x0000000000001000-0x0000000000ffffff]
[    0.017969]   DMA32    [mem 0x0000000001000000-0x00000000ffffffff]
[    0.017971]   Normal   [mem 0x0000000100000000-0x000000027fffffff]
[    0.017972]   Device   empty
[    0.017974] Movable zone start for each node
[    0.017976] Early memory node ranges
[    0.017977]   node   0: [mem 0x0000000000001000-0x000000000009efff]
[    0.017979]   node   0: [mem 0x0000000000100000-0x000000007ffd5fff]
[    0.017980]   node   0: [mem 0x0000000100000000-0x000000017fffffff]
[    0.017982]   node   1: [mem 0x0000000180000000-0x000000027fffffff]
[    0.017984] Initmem setup node 0 [mem 0x0000000000001000-0x000000017fffffff]
[    0.017990] Initmem setup node 1 [mem 0x0000000180000000-0x000000027fffffff]
[    0.017993] Node 2 uninitialized by the platform. Please report with boot dmesg.
[    0.018008] Initmem setup node 2 [mem 0x0000000000000000-0x0000000000000000]
[    0.018011] On node 0, zone DMA: 1 pages in unavailable ranges
[    0.018031] On node 0, zone DMA: 97 pages in unavailable ranges
[    0.023622] On node 0, zone Normal: 42 pages in unavailable ranges

# numactl --hardware
available: 2 nodes (0-1)
node 0 cpus: 0 1
node 0 size: 3921 MB
node 0 free: 3638 MB
node 1 cpus: 2 3
node 1 size: 4022 MB
node 1 free: 3519 MB
node distances:
node   0   1 
  0:  10  20 
  1:  20  10 
# cat /sys/devices/system/node/online 
0-1
# cat /sys/devices/system/node/possible 
0-2


3. Hotplug a DIMM and online it to ZONE_MOVABLE

# echo online_movable > /sys/devices/system/memory/auto_online_blocks 


$ echo "object_add memory-backend-ram,id=hmem0,size=8G" | sudo nc -U /var/tmp/monitor ; echo
$ echo "device_add pc-dimm,id=dimm0,memdev=hmem0,node=2" | sudo nc -U /var/tmp/monitor ; echo


4. Guest state after hotplug

[  334.541452] Built 2 zonelists, mobility grouping on.  Total pages: 1999733
[  334.541908] Policy zone: Normal
[  334.559853] Fallback order for Node 0: 0 2 1 
[  334.560234] Fallback order for Node 1: 1 2 0 
[  334.560524] Fallback order for Node 2: 2 0 1 
[  334.560810] Built 3 zonelists, mobility grouping on.  Total pages: 2032501
[  334.561281] Policy zone: Normal

# numactl --hardware
available: 3 nodes (0-2)
node 0 cpus: 0 1
node 0 size: 3921 MB
node 0 free: 3529 MB
node 1 cpus: 2 3
node 1 size: 4022 MB
node 1 free: 3564 MB
node 2 cpus:
node 2 size: 8192 MB
node 2 free: 8192 MB
node distances:
node   0   1   2 
  0:  10  20  20 
  1:  20  10  20 
  2:  20  20  10 
# cat /sys/devices/system/node/online 
0-2
# cat /sys/devices/system/node/possible 
0-2
# cat /sys/devices/system/node/has_memory 
0-2
# cat /sys/devices/system/node/has_normal_memory 
0-1
# cat /sys/devices/system/node/has_cpu 
0-1


5. Unplug DIMM

$ echo "device_del dimm0" | sudo nc -U /var/tmp/monitor ; echo


6. Guest state after unplug

[  494.218938] Fallback order for Node 0: 0 2 1 
[  494.219315] Fallback order for Node 1: 1 2 0 
[  494.219626] Fallback order for Node 2: 2 0 1 
[  494.220430] Built 3 zonelists, mobility grouping on.  Total pages: 1999736
[  494.221024] Policy zone: Normal

# numactl --hardware
available: 2 nodes (0-1)
node 0 cpus: 0 1
node 0 size: 3921 MB
node 0 free: 3661 MB
node 1 cpus: 2 3
node 1 size: 4022 MB
node 1 free: 3565 MB
node distances:
node   0   1 
  0:  10  20 
  1:  20  10 
# cat /sys/devices/system/node/online 
0-1
# cat /sys/devices/system/node/possible 
0-2


7. Hotplug DIMM + online to ZONE_NORMAL

# echo online_kernel > /sys/devices/system/memory/auto_online_blocks 

$ echo "device_add pc-dimm,id=dimm0,memdev=hmem0,node=2" | sudo nc -U /var/tmp/monitor ; echo


8. Guest state after hotplug

# numactl --hardware
available: 3 nodes (0-2)
node 0 cpus: 0 1
node 0 size: 3921 MB
node 0 free: 3534 MB
node 1 cpus: 2 3
node 1 size: 4022 MB
node 1 free: 3567 MB
node 2 cpus:
node 2 size: 8192 MB
node 2 free: 8192 MB
node distances:
node   0   1   2 
  0:  10  20  20 
  1:  20  10  20 
  2:  20  20  10 

# cat /sys/devices/system/node/online 
0-2
# cat /sys/devices/system/node/possible 
0-2
# cat /sys/devices/system/node/has_memory 
0-2
# cat /sys/devices/system/node/has_normal_memory 
0-2
# cat /sys/devices/system/node/has_cpu
0-1



No surprises found so far. I'll be most offline for the next 2 weeks,
so an official review might take some more time.

-- 
Thanks,

David / dhildenb

