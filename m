Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76A164F8E1B
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Apr 2022 08:26:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235055AbiDHGFl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Apr 2022 02:05:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231520AbiDHGFi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Apr 2022 02:05:38 -0400
Received: from gnuweeb.org (gnuweeb.org [51.81.211.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CA773204A
        for <linux-kernel@vger.kernel.org>; Thu,  7 Apr 2022 23:03:33 -0700 (PDT)
Received: from [192.168.223.80] (unknown [182.2.73.51])
        by gnuweeb.org (Postfix) with ESMTPSA id BA5C27E326;
        Fri,  8 Apr 2022 06:03:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gnuweeb.org;
        s=default; t=1649397812;
        bh=KrOYdo5Z2+PXbxSsFnAJsN1oFQ9hfpK2+h2kjEhfxag=;
        h=Date:To:Cc:References:From:Subject:In-Reply-To:From;
        b=lR820LzVvDWdFKocNNw5SrWSWGFndxlEkWOLgHReZQ5lpIaf1h1JYtfiVlt6lZi2L
         hAmiraLCKpXp70hCy5x4Hjaz9ay4Fn2de93oqanOM7LMmGQr65gXiHyr6YEyspstjG
         SUqOQA8xBJLfQDcUBau0SOVXgew3JAIKIVMw+x0HUzehvGC/epOf64LmKc/Ovff6Us
         7hh7EX1/fkQmu+g5cpZ6TV+y3TYVqDGn2FFHIsi1GAPssc5YKRIzsYv+UlaXACeNVa
         RasGqAr4bQAh8+Nm4h791IBURbOmPyPIyGl9Y2Xp2l0wAlafea3LIaeGBtFsHaMy0t
         sUbz5HR6sphnw==
Message-ID: <e1f9421d-e9dd-589c-bf88-407533e40797@gnuweeb.org>
Date:   Fri, 8 Apr 2022 13:03:23 +0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Content-Language: en-US
To:     Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc:     Ben Segall <bsegall@google.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Mel Gorman <mgorman@suse.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Vincent Guittot <vincent.guittot@linaro.org>
References: <b86541ea-7d96-5a24-1b65-37c24c70d3ff@gnuweeb.org>
 <f71d132d-02a0-918c-ab2b-3234d0d492a4@arm.com>
 <675544de-3369-e26e-65ba-3b28fff5c126@gnuweeb.org>
 <000457c2-57af-95e3-7dff-2cbd99f0de5f@arm.com>
 <7f4b3fbf-c7c6-22cb-019b-520ad6a663aa@gnuweeb.org>
 <786190b3-b2cb-464d-9808-325d774c62a5@arm.com>
From:   Ammar Faizi <ammarfaizi2@gnuweeb.org>
Subject: Re: [Linux 5.18-rc1] WARNING: CPU: 1 PID: 0 at
 kernel/sched/fair.c:3355 update_blocked_averages
In-Reply-To: <786190b3-b2cb-464d-9808-325d774c62a5@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/7/22 5:52 PM, Dietmar Eggemann wrote:

[...]

> Looks like 21.10 finally abandoned legacy cgroup v1 and switched to v2
> completely, which is now mounted under /sys/fs/cgroup .
> 
> So your /sys/fs/cgroup/cgroup.controllers should contain `cpu`.
> 
> Can you check if any of the cpu.max files under /sys/fs/cgroup has
> something else then `max 100000` ?

I only see "max 100000" at the moment. Not sure if it may change when I
do other activities anyway. If you need more information, I can always
send it, so feel free to ask.

> Background is that if this is the case, cgroups (i.e. cfs_rqs) might be
> throttled and this could be related to what you see. I haven't
> stress-test it so far with active CFS BW ctrl (cfs_rq throttling).

root@integral2:~#
root@integral2:~# cat /sys/fs/cgroup/cgroup.controllers
cpuset cpu io memory hugetlb pids rdma
root@integral2:~#
root@integral2:~# ls /sys/fs/cgroup
cgroup.controllers      cgroup.subtree_control  cpu.stat             io.cost.qos       memory.pressure                sys-kernel-config.mount
cgroup.max.depth        cgroup.threads          dev-hugepages.mount  io.pressure       memory.stat                    sys-kernel-debug.mount
cgroup.max.descendants  cpu.pressure            dev-mqueue.mount     io.stat           -.mount                        sys-kernel-tracing.mount
cgroup.procs            cpuset.cpus.effective   init.scope           machine.slice     proc-sys-fs-binfmt_misc.mount  system.slice
cgroup.stat             cpuset.mems.effective   io.cost.model        memory.numa_stat  sys-fs-fuse-connections.mount  user.slice
root@integral2:~#
root@integral2:~# cd /sys/fs/cgroup/
root@integral2:/sys/fs/cgroup#
root@integral2:/sys/fs/cgroup# more $(find | grep cpu.max) | cat
::::::::::::::
./sys-fs-fuse-connections.mount/cpu.max.burst
::::::::::::::
0
::::::::::::::
./sys-fs-fuse-connections.mount/cpu.max
::::::::::::::
max 100000
::::::::::::::
./sys-kernel-config.mount/cpu.max.burst
::::::::::::::
0
::::::::::::::
./sys-kernel-config.mount/cpu.max
::::::::::::::
max 100000
::::::::::::::
./sys-kernel-debug.mount/cpu.max.burst
::::::::::::::
0
::::::::::::::
./sys-kernel-debug.mount/cpu.max
::::::::::::::
max 100000
::::::::::::::
./-.mount/cpu.max.burst
::::::::::::::
0
::::::::::::::
./-.mount/cpu.max
::::::::::::::
max 100000
::::::::::::::
./dev-mqueue.mount/cpu.max.burst
::::::::::::::
0
::::::::::::::
./dev-mqueue.mount/cpu.max
::::::::::::::
max 100000
::::::::::::::
./user.slice/cpu.max.burst
::::::::::::::
0
::::::::::::::
./user.slice/cpu.max
::::::::::::::
max 100000
::::::::::::::
./sys-kernel-tracing.mount/cpu.max.burst
::::::::::::::
0
::::::::::::::
./sys-kernel-tracing.mount/cpu.max
::::::::::::::
max 100000
::::::::::::::
./init.scope/cpu.max.burst
::::::::::::::
0
::::::::::::::
./init.scope/cpu.max
::::::::::::::
max 100000
::::::::::::::
./system.slice/irqbalance.service/cpu.max.burst
::::::::::::::
0
::::::::::::::
./system.slice/irqbalance.service/cpu.max
::::::::::::::
max 100000
::::::::::::::
./system.slice/systemd-update-utmp.service/cpu.max.burst
::::::::::::::
0
::::::::::::::
./system.slice/systemd-update-utmp.service/cpu.max
::::::::::::::
max 100000
::::::::::::::
./system.slice/systemd-sysusers.service/cpu.max.burst
::::::::::::::
0
::::::::::::::
./system.slice/systemd-sysusers.service/cpu.max
::::::::::::::
max 100000
::::::::::::::
./system.slice/system-systemd\x2dfsck.slice/cpu.max.burst
::::::::::::::
0
::::::::::::::
./system.slice/system-systemd\x2dfsck.slice/cpu.max
::::::::::::::
max 100000
::::::::::::::
./system.slice/run-user-1000-doc.mount/cpu.max.burst
::::::::::::::
0
::::::::::::::
./system.slice/run-user-1000-doc.mount/cpu.max
::::::::::::::
max 100000
::::::::::::::
./system.slice/snap-bare-5.mount/cpu.max.burst
::::::::::::::
0
::::::::::::::
./system.slice/snap-bare-5.mount/cpu.max
::::::::::::::
max 100000
::::::::::::::
./system.slice/systemd-udevd-control.socket/cpu.max.burst
::::::::::::::
0
::::::::::::::
./system.slice/systemd-udevd-control.socket/cpu.max
::::::::::::::
max 100000
::::::::::::::
./system.slice/lvm2-monitor.service/cpu.max.burst
::::::::::::::
0
::::::::::::::
./system.slice/lvm2-monitor.service/cpu.max
::::::::::::::
max 100000
::::::::::::::
./system.slice/run-snapd-ns-snap\x2dstore.mnt.mount/cpu.max.burst
::::::::::::::
0
::::::::::::::
./system.slice/run-snapd-ns-snap\x2dstore.mnt.mount/cpu.max
::::::::::::::
max 100000
::::::::::::::
./system.slice/systemd-journal-flush.service/cpu.max.burst
::::::::::::::
0
::::::::::::::
./system.slice/systemd-journal-flush.service/cpu.max
::::::::::::::
max 100000
::::::::::::::
./system.slice/run-qemu.mount/cpu.max.burst
::::::::::::::
0
::::::::::::::
./system.slice/run-qemu.mount/cpu.max
::::::::::::::
max 100000
::::::::::::::
./system.slice/containerd.service/cpu.max.burst
::::::::::::::
0
::::::::::::::
./system.slice/containerd.service/cpu.max
::::::::::::::
max 100000
::::::::::::::
./system.slice/systemd-sysctl.service/cpu.max.burst
::::::::::::::
0
::::::::::::::
./system.slice/systemd-sysctl.service/cpu.max
::::::::::::::
max 100000
::::::::::::::
./system.slice/packagekit.service/cpu.max.burst
::::::::::::::
0
::::::::::::::
./system.slice/packagekit.service/cpu.max
::::::::::::::
max 100000
::::::::::::::
./system.slice/snapd.apparmor.service/cpu.max.burst
::::::::::::::
0
::::::::::::::
./system.slice/snapd.apparmor.service/cpu.max
::::::::::::::
max 100000
::::::::::::::
./system.slice/systemd-udevd.service/cpu.max.burst
::::::::::::::
0
::::::::::::::
./system.slice/systemd-udevd.service/cpu.max
::::::::::::::
max 100000
::::::::::::::
./system.slice/systemd-udevd-kernel.socket/cpu.max.burst
::::::::::::::
0
::::::::::::::
./system.slice/systemd-udevd-kernel.socket/cpu.max
::::::::::::::
max 100000
::::::::::::::
./system.slice/whoopsie.service/cpu.max.burst
::::::::::::::
0
::::::::::::::
./system.slice/whoopsie.service/cpu.max
::::::::::::::
max 100000
::::::::::::::
./system.slice/cron.service/cpu.max.burst
::::::::::::::
0
::::::::::::::
./system.slice/cron.service/cpu.max
::::::::::::::
max 100000
::::::::::::::
./system.slice/acpid.socket/cpu.max.burst
::::::::::::::
0
::::::::::::::
./system.slice/acpid.socket/cpu.max
::::::::::::::
max 100000
::::::::::::::
./system.slice/thermald.service/cpu.max.burst
::::::::::::::
0
::::::::::::::
./system.slice/thermald.service/cpu.max
::::::::::::::
max 100000
::::::::::::::
./system.slice/dev-nvme0n1p6.swap/cpu.max.burst
::::::::::::::
0
::::::::::::::
./system.slice/dev-nvme0n1p6.swap/cpu.max
::::::::::::::
max 100000
::::::::::::::
./system.slice/docker.service/cpu.max.burst
::::::::::::::
0
::::::::::::::
./system.slice/docker.service/cpu.max
::::::::::::::
max 100000
::::::::::::::
./system.slice/polkit.service/cpu.max.burst
::::::::::::::
0
::::::::::::::
./system.slice/polkit.service/cpu.max
::::::::::::::
max 100000
::::::::::::::
./system.slice/systemd-remount-fs.service/cpu.max.burst
::::::::::::::
0
::::::::::::::
./system.slice/systemd-remount-fs.service/cpu.max
::::::::::::::
max 100000
::::::::::::::
./system.slice/networkd-dispatcher.service/cpu.max.burst
::::::::::::::
0
::::::::::::::
./system.slice/networkd-dispatcher.service/cpu.max
::::::::::::::
max 100000
::::::::::::::
./system.slice/rtkit-daemon.service/cpu.max.burst
::::::::::::::
0
::::::::::::::
./system.slice/rtkit-daemon.service/cpu.max
::::::::::::::
max 100000
::::::::::::::
./system.slice/snap-snap\x2dstore-558.mount/cpu.max.burst
::::::::::::::
0
::::::::::::::
./system.slice/snap-snap\x2dstore-558.mount/cpu.max
::::::::::::::
max 100000
::::::::::::::
./system.slice/snap-gtk\x2dcommon\x2dthemes-1519.mount/cpu.max.burst
::::::::::::::
0
::::::::::::::
./system.slice/snap-gtk\x2dcommon\x2dthemes-1519.mount/cpu.max
::::::::::::::
max 100000
::::::::::::::
./system.slice/libvirtd-admin.socket/cpu.max.burst
::::::::::::::
0
::::::::::::::
./system.slice/libvirtd-admin.socket/cpu.max
::::::::::::::
max 100000
::::::::::::::
./system.slice/bluetooth.service/cpu.max.burst
::::::::::::::
0
::::::::::::::
./system.slice/bluetooth.service/cpu.max
::::::::::::::
max 100000
::::::::::::::
./system.slice/lvm2-lvmpolld.socket/cpu.max.burst
::::::::::::::
0
::::::::::::::
./system.slice/lvm2-lvmpolld.socket/cpu.max
::::::::::::::
max 100000
::::::::::::::
./system.slice/home.mount/cpu.max.burst
::::::::::::::
0
::::::::::::::
./system.slice/home.mount/cpu.max
::::::::::::::
max 100000
::::::::::::::
./system.slice/snap-core-12941.mount/cpu.max.burst
::::::::::::::
0
::::::::::::::
./system.slice/snap-core-12941.mount/cpu.max
::::::::::::::
max 100000
::::::::::::::
./system.slice/accounts-daemon.service/cpu.max.burst
::::::::::::::
0
::::::::::::::
./system.slice/accounts-daemon.service/cpu.max
::::::::::::::
max 100000
::::::::::::::
./system.slice/systemd-tmpfiles-setup.service/cpu.max.burst
::::::::::::::
0
::::::::::::::
./system.slice/systemd-tmpfiles-setup.service/cpu.max
::::::::::::::
max 100000
::::::::::::::
./system.slice/dev-disk-by\x2did-nvme\x2deui.0000000001000000e4d25c928d835401\x2dpart6.swap/cpu.max.burst
::::::::::::::
0
::::::::::::::
./system.slice/dev-disk-by\x2did-nvme\x2deui.0000000001000000e4d25c928d835401\x2dpart6.swap/cpu.max
::::::::::::::
max 100000
::::::::::::::
./system.slice/dev-disk-by\x2duuid-37a29cd2\x2d7d0f\x2d4a23\x2d9ffc\x2dac7768fd19c7.swap/cpu.max.burst
::::::::::::::
0
::::::::::::::
./system.slice/dev-disk-by\x2duuid-37a29cd2\x2d7d0f\x2d4a23\x2d9ffc\x2dac7768fd19c7.swap/cpu.max
::::::::::::::
max 100000
::::::::::::::
./system.slice/wpa_supplicant.service/cpu.max.burst
::::::::::::::
0
::::::::::::::
./system.slice/wpa_supplicant.service/cpu.max
::::::::::::::
max 100000
::::::::::::::
./system.slice/system-modprobe.slice/cpu.max.burst
::::::::::::::
0
::::::::::::::
./system.slice/system-modprobe.slice/cpu.max
::::::::::::::
max 100000
::::::::::::::
./system.slice/libvirtd.service/cpu.max.burst
::::::::::::::
0
::::::::::::::
./system.slice/libvirtd.service/cpu.max
::::::::::::::
max 100000
::::::::::::::
./system.slice/systemd-journald-dev-log.socket/cpu.max.burst
::::::::::::::
0
::::::::::::::
./system.slice/systemd-journald-dev-log.socket/cpu.max
::::::::::::::
max 100000
::::::::::::::
./system.slice/ModemManager.service/cpu.max.burst
::::::::::::::
0
::::::::::::::
./system.slice/ModemManager.service/cpu.max
::::::::::::::
max 100000
::::::::::::::
./system.slice/console-setup.service/cpu.max.burst
::::::::::::::
0
::::::::::::::
./system.slice/console-setup.service/cpu.max
::::::::::::::
max 100000
::::::::::::::
./system.slice/virtlockd.socket/cpu.max.burst
::::::::::::::
0
::::::::::::::
./system.slice/virtlockd.socket/cpu.max
::::::::::::::
max 100000
::::::::::::::
./system.slice/snap-firefox-1154.mount/cpu.max.burst
::::::::::::::
0
::::::::::::::
./system.slice/snap-firefox-1154.mount/cpu.max
::::::::::::::
max 100000
::::::::::::::
./system.slice/alsa-restore.service/cpu.max.burst
::::::::::::::
0
::::::::::::::
./system.slice/alsa-restore.service/cpu.max
::::::::::::::
max 100000
::::::::::::::
./system.slice/systemd-journald.service/cpu.max.burst
::::::::::::::
0
::::::::::::::
./system.slice/systemd-journald.service/cpu.max
::::::::::::::
max 100000
::::::::::::::
./system.slice/qemu-kvm.service/cpu.max.burst
::::::::::::::
0
::::::::::::::
./system.slice/qemu-kvm.service/cpu.max
::::::::::::::
max 100000
::::::::::::::
./system.slice/php8.0-fpm.service/cpu.max.burst
::::::::::::::
0
::::::::::::::
./system.slice/php8.0-fpm.service/cpu.max
::::::::::::::
max 100000
::::::::::::::
./system.slice/systemd-udev-trigger.service/cpu.max.burst
::::::::::::::
0
::::::::::::::
./system.slice/systemd-udev-trigger.service/cpu.max
::::::::::::::
max 100000
::::::::::::::
./system.slice/system-systemd\x2dbacklight.slice/cpu.max.burst
::::::::::::::
0
::::::::::::::
./system.slice/system-systemd\x2dbacklight.slice/cpu.max
::::::::::::::
max 100000
::::::::::::::
./system.slice/power-profiles-daemon.service/cpu.max.burst
::::::::::::::
0
::::::::::::::
./system.slice/power-profiles-daemon.service/cpu.max
::::::::::::::
max 100000
::::::::::::::
./system.slice/unattended-upgrades.service/cpu.max.burst
::::::::::::::
0
::::::::::::::
./system.slice/unattended-upgrades.service/cpu.max
::::::::::::::
max 100000
::::::::::::::
./system.slice/plymouth-quit-wait.service/cpu.max.burst
::::::::::::::
0
::::::::::::::
./system.slice/plymouth-quit-wait.service/cpu.max
::::::::::::::
max 100000
::::::::::::::
./system.slice/systemd-rfkill.socket/cpu.max.burst
::::::::::::::
0
::::::::::::::
./system.slice/systemd-rfkill.socket/cpu.max
::::::::::::::
max 100000
::::::::::::::
./system.slice/ssh.service/cpu.max.burst
::::::::::::::
0
::::::::::::::
./system.slice/ssh.service/cpu.max
::::::::::::::
max 100000
::::::::::::::
./system.slice/syslog.socket/cpu.max.burst
::::::::::::::
0
::::::::::::::
./system.slice/syslog.socket/cpu.max
::::::::::::::
max 100000
::::::::::::::
./system.slice/virtlockd-admin.socket/cpu.max.burst
::::::::::::::
0
::::::::::::::
./system.slice/virtlockd-admin.socket/cpu.max
::::::::::::::
max 100000
::::::::::::::
./system.slice/colord.service/cpu.max.burst
::::::::::::::
0
::::::::::::::
./system.slice/colord.service/cpu.max
::::::::::::::
max 100000
::::::::::::::
./system.slice/plymouth-read-write.service/cpu.max.burst
::::::::::::::
0
::::::::::::::
./system.slice/plymouth-read-write.service/cpu.max
::::::::::::::
max 100000
::::::::::::::
./system.slice/run-user-1000-gvfs.mount/cpu.max.burst
::::::::::::::
0
::::::::::::::
./system.slice/run-user-1000-gvfs.mount/cpu.max
::::::::::::::
max 100000
::::::::::::::
./system.slice/virtlogd-admin.socket/cpu.max.burst
::::::::::::::
0
::::::::::::::
./system.slice/virtlogd-admin.socket/cpu.max
::::::::::::::
max 100000
::::::::::::::
./system.slice/tmp-.tmpfs.mount/cpu.max.burst
::::::::::::::
0
::::::::::::::
./system.slice/tmp-.tmpfs.mount/cpu.max
::::::::::::::
max 100000
::::::::::::::
./system.slice/libvirt-guests.service/cpu.max.burst
::::::::::::::
0
::::::::::::::
./system.slice/libvirt-guests.service/cpu.max
::::::::::::::
max 100000
::::::::::::::
./system.slice/systemd-initctl.socket/cpu.max.burst
::::::::::::::
0
::::::::::::::
./system.slice/systemd-initctl.socket/cpu.max
::::::::::::::
max 100000
::::::::::::::
./system.slice/NetworkManager.service/cpu.max.burst
::::::::::::::
0
::::::::::::::
./system.slice/NetworkManager.service/cpu.max
::::::::::::::
max 100000
::::::::::::::
./system.slice/lm-sensors.service/cpu.max.burst
::::::::::::::
0
::::::::::::::
./system.slice/lm-sensors.service/cpu.max
::::::::::::::
max 100000
::::::::::::::
./system.slice/snapd.service/cpu.max.burst
::::::::::::::
0
::::::::::::::
./system.slice/snapd.service/cpu.max
::::::::::::::
max 100000
::::::::::::::
./system.slice/gdm.service/cpu.max.burst
::::::::::::::
0
::::::::::::::
./system.slice/gdm.service/cpu.max
::::::::::::::
max 100000
::::::::::::::
./system.slice/snap-core-12834.mount/cpu.max.burst
::::::::::::::
0
::::::::::::::
./system.slice/snap-core-12834.mount/cpu.max
::::::::::::::
max 100000
::::::::::::::
./system.slice/systemd-machined.service/cpu.max.burst
::::::::::::::
0
::::::::::::::
./system.slice/systemd-machined.service/cpu.max
::::::::::::::
max 100000
::::::::::::::
./system.slice/switcheroo-control.service/cpu.max.burst
::::::::::::::
0
::::::::::::::
./system.slice/switcheroo-control.service/cpu.max
::::::::::::::
max 100000
::::::::::::::
./system.slice/ufw.service/cpu.max.burst
::::::::::::::
0
::::::::::::::
./system.slice/ufw.service/cpu.max
::::::::::::::
max 100000
::::::::::::::
./system.slice/systemd-random-seed.service/cpu.max.burst
::::::::::::::
0
::::::::::::::
./system.slice/systemd-random-seed.service/cpu.max
::::::::::::::
max 100000
::::::::::::::
./system.slice/dbus.socket/cpu.max.burst
::::::::::::::
0
::::::::::::::
./system.slice/dbus.socket/cpu.max
::::::::::::::
max 100000
::::::::::::::
./system.slice/systemd-journald-audit.socket/cpu.max.burst
::::::::::::::
0
::::::::::::::
./system.slice/systemd-journald-audit.socket/cpu.max
::::::::::::::
max 100000
::::::::::::::
./system.slice/libvirtd-ro.socket/cpu.max.burst
::::::::::::::
0
::::::::::::::
./system.slice/libvirtd-ro.socket/cpu.max
::::::::::::::
max 100000
::::::::::::::
./system.slice/snapd.seeded.service/cpu.max.burst
::::::::::::::
0
::::::::::::::
./system.slice/snapd.seeded.service/cpu.max
::::::::::::::
max 100000
::::::::::::::
./system.slice/snap-snapcraft-7010.mount/cpu.max.burst
::::::::::::::
0
::::::::::::::
./system.slice/snap-snapcraft-7010.mount/cpu.max
::::::::::::::
max 100000
::::::::::::::
./system.slice/dev-disk-by\x2dpartuuid-7f986e8c\x2d0f7f\x2d4f9f\x2db792\x2d8207b9dcd5de.swap/cpu.max.burst
::::::::::::::
0
::::::::::::::
./system.slice/dev-disk-by\x2dpartuuid-7f986e8c\x2d0f7f\x2d4f9f\x2db792\x2d8207b9dcd5de.swap/cpu.max
::::::::::::::
max 100000
::::::::::::::
./system.slice/uuidd.socket/cpu.max.burst
::::::::::::::
0
::::::::::::::
./system.slice/uuidd.socket/cpu.max
::::::::::::::
max 100000
::::::::::::::
./system.slice/run-snapd-ns.mount/cpu.max.burst
::::::::::::::
0
::::::::::::::
./system.slice/run-snapd-ns.mount/cpu.max
::::::::::::::
max 100000
::::::::::::::
./system.slice/rsyslog.service/cpu.max.burst
::::::::::::::
0
::::::::::::::
./system.slice/rsyslog.service/cpu.max
::::::::::::::
max 100000
::::::::::::::
./system.slice/systemd-modules-load.service/cpu.max.burst
::::::::::::::
0
::::::::::::::
./system.slice/systemd-modules-load.service/cpu.max
::::::::::::::
max 100000
::::::::::::::
./system.slice/snap-gnome\x2d3\x2d38\x2d2004-99.mount/cpu.max.burst
::::::::::::::
0
::::::::::::::
./system.slice/snap-gnome\x2d3\x2d38\x2d2004-99.mount/cpu.max
::::::::::::::
max 100000
::::::::::::::
./system.slice/blk-availability.service/cpu.max.burst
::::::::::::::
0
::::::::::::::
./system.slice/blk-availability.service/cpu.max
::::::::::::::
max 100000
::::::::::::::
./system.slice/snap-firefox-1188.mount/cpu.max.burst
::::::::::::::
0
::::::::::::::
./system.slice/snap-firefox-1188.mount/cpu.max
::::::::::::::
max 100000
::::::::::::::
./system.slice/boot-efi.mount/cpu.max.burst
::::::::::::::
0
::::::::::::::
./system.slice/boot-efi.mount/cpu.max
::::::::::::::
max 100000
::::::::::::::
./system.slice/systemd-tmpfiles-setup-dev.service/cpu.max.burst
::::::::::::::
0
::::::::::::::
./system.slice/systemd-tmpfiles-setup-dev.service/cpu.max
::::::::::::::
max 100000
::::::::::::::
./system.slice/run-user-1000.mount/cpu.max.burst
::::::::::::::
0
::::::::::::::
./system.slice/run-user-1000.mount/cpu.max
::::::::::::::
max 100000
::::::::::::::
./system.slice/systemd-fsckd.socket/cpu.max.burst
::::::::::::::
0
::::::::::::::
./system.slice/systemd-fsckd.socket/cpu.max
::::::::::::::
max 100000
::::::::::::::
./system.slice/kerneloops.service/cpu.max.burst
::::::::::::::
0
::::::::::::::
./system.slice/kerneloops.service/cpu.max
::::::::::::::
max 100000
::::::::::::::
./system.slice/avahi-daemon.socket/cpu.max.burst
::::::::::::::
0
::::::::::::::
./system.slice/avahi-daemon.socket/cpu.max
::::::::::::::
max 100000
::::::::::::::
./system.slice/cpu.max.burst
::::::::::::::
0
::::::::::::::
./system.slice/dev-disk-by\x2dpath-pci\x2d0000:00:0e.0\x2dpci\x2d10000:e1:00.0\x2dnvme\x2d1\x2dpart6.swap/cpu.max.burst
::::::::::::::
0
::::::::::::::
./system.slice/dev-disk-by\x2dpath-pci\x2d0000:00:0e.0\x2dpci\x2d10000:e1:00.0\x2dnvme\x2d1\x2dpart6.swap/cpu.max
::::::::::::::
max 100000
::::::::::::::
./system.slice/libvirtd.socket/cpu.max.burst
::::::::::::::
0
::::::::::::::
./system.slice/libvirtd.socket/cpu.max
::::::::::::::
max 100000
::::::::::::::
./system.slice/systemd-journald.socket/cpu.max.burst
::::::::::::::
0
::::::::::::::
./system.slice/systemd-journald.socket/cpu.max
::::::::::::::
max 100000
::::::::::::::
./system.slice/cpu.max
::::::::::::::
max 100000
::::::::::::::
./system.slice/snapd.socket/cpu.max.burst
::::::::::::::
0
::::::::::::::
./system.slice/snapd.socket/cpu.max
::::::::::::::
max 100000
::::::::::::::
./system.slice/snap-core20-1405.mount/cpu.max.burst
::::::::::::::
0
::::::::::::::
./system.slice/snap-core20-1405.mount/cpu.max
::::::::::::::
max 100000
::::::::::::::
./system.slice/kmod-static-nodes.service/cpu.max.burst
::::::::::::::
0
::::::::::::::
./system.slice/kmod-static-nodes.service/cpu.max
::::::::::::::
max 100000
::::::::::::::
./system.slice/cups-browsed.service/cpu.max.burst
::::::::::::::
0
::::::::::::::
./system.slice/cups-browsed.service/cpu.max
::::::::::::::
max 100000
::::::::::::::
./system.slice/openvpn.service/cpu.max.burst
::::::::::::::
0
::::::::::::::
./system.slice/openvpn.service/cpu.max
::::::::::::::
max 100000
::::::::::::::
./system.slice/docker.socket/cpu.max.burst
::::::::::::::
0
::::::::::::::
./system.slice/docker.socket/cpu.max
::::::::::::::
max 100000
::::::::::::::
./system.slice/dev-disk-by\x2did-nvme\x2dINTEL_SSDPEKNW512G8H_BTNH128109LJ512A\x2dpart6.swap/cpu.max.burst
::::::::::::::
0
::::::::::::::
./system.slice/dev-disk-by\x2did-nvme\x2dINTEL_SSDPEKNW512G8H_BTNH128109LJ512A\x2dpart6.swap/cpu.max
::::::::::::::
max 100000
::::::::::::::
./system.slice/apport.service/cpu.max.burst
::::::::::::::
0
::::::::::::::
./system.slice/apport.service/cpu.max
::::::::::::::
max 100000
::::::::::::::
./system.slice/cups.service/cpu.max.burst
::::::::::::::
0
::::::::::::::
./system.slice/cups.service/cpu.max
::::::::::::::
max 100000
::::::::::::::
./system.slice/upower.service/cpu.max.burst
::::::::::::::
0
::::::::::::::
./system.slice/upower.service/cpu.max
::::::::::::::
max 100000
::::::::::::::
./system.slice/snap-core20-1376.mount/cpu.max.burst
::::::::::::::
0
::::::::::::::
./system.slice/snap-core20-1376.mount/cpu.max
::::::::::::::
max 100000
::::::::::::::
./system.slice/apparmor.service/cpu.max.burst
::::::::::::::
0
::::::::::::::
./system.slice/apparmor.service/cpu.max
::::::::::::::
max 100000
::::::::::::::
./system.slice/systemd-resolved.service/cpu.max.burst
::::::::::::::
0
::::::::::::::
./system.slice/systemd-resolved.service/cpu.max
::::::::::::::
max 100000
::::::::::::::
./system.slice/binfmt-support.service/cpu.max.burst
::::::::::::::
0
::::::::::::::
./system.slice/binfmt-support.service/cpu.max
::::::::::::::
max 100000
::::::::::::::
./system.slice/udisks2.service/cpu.max.burst
::::::::::::::
0
::::::::::::::
./system.slice/udisks2.service/cpu.max
::::::::::::::
max 100000
::::::::::::::
./system.slice/acpid.service/cpu.max.burst
::::::::::::::
0
::::::::::::::
./system.slice/acpid.service/cpu.max
::::::::::::::
max 100000
::::::::::::::
./system.slice/snap-snapcraft-7201.mount/cpu.max.burst
::::::::::::::
0
::::::::::::::
./system.slice/snap-snapcraft-7201.mount/cpu.max
::::::::::::::
max 100000
::::::::::::::
./system.slice/dbus.service/cpu.max.burst
::::::::::::::
0
::::::::::::::
./system.slice/dbus.service/cpu.max
::::::::::::::
max 100000
::::::::::::::
./system.slice/systemd-timesyncd.service/cpu.max.burst
::::::::::::::
0
::::::::::::::
./system.slice/systemd-timesyncd.service/cpu.max
::::::::::::::
max 100000
::::::::::::::
./system.slice/NetworkManager-wait-online.service/cpu.max.burst
::::::::::::::
0
::::::::::::::
./system.slice/NetworkManager-wait-online.service/cpu.max
::::::::::::::
max 100000
::::::::::::::
./system.slice/system-getty.slice/cpu.max.burst
::::::::::::::
0
::::::::::::::
./system.slice/system-getty.slice/cpu.max
::::::::::::::
max 100000
::::::::::::::
./system.slice/snap-snap\x2dstore-557.mount/cpu.max.burst
::::::::::::::
0
::::::::::::::
./system.slice/snap-snap\x2dstore-557.mount/cpu.max
::::::::::::::
max 100000
::::::::::::::
./system.slice/keyboard-setup.service/cpu.max.burst
::::::::::::::
0
::::::::::::::
./system.slice/keyboard-setup.service/cpu.max
::::::::::::::
max 100000
::::::::::::::
./system.slice/virtlogd.socket/cpu.max.burst
::::::::::::::
0
::::::::::::::
./system.slice/virtlogd.socket/cpu.max
::::::::::::::
max 100000
::::::::::::::
./system.slice/systemd-user-sessions.service/cpu.max.burst
::::::::::::::
0
::::::::::::::
./system.slice/systemd-user-sessions.service/cpu.max
::::::::::::::
max 100000
::::::::::::::
./system.slice/dm-event.socket/cpu.max.burst
::::::::::::::
0
::::::::::::::
./system.slice/dm-event.socket/cpu.max
::::::::::::::
max 100000
::::::::::::::
./system.slice/avahi-daemon.service/cpu.max.burst
::::::::::::::
0
::::::::::::::
./system.slice/avahi-daemon.service/cpu.max
::::::::::::::
max 100000
::::::::::::::
./system.slice/systemd-logind.service/cpu.max.burst
::::::::::::::
0
::::::::::::::
./system.slice/systemd-logind.service/cpu.max
::::::::::::::
max 100000
::::::::::::::
./system.slice/snap-gnome\x2d3\x2d38\x2d2004-87.mount/cpu.max.burst
::::::::::::::
0
::::::::::::::
./system.slice/snap-gnome\x2d3\x2d38\x2d2004-87.mount/cpu.max
::::::::::::::
max 100000
::::::::::::::
./system.slice/setvtrgb.service/cpu.max.burst
::::::::::::::
0
::::::::::::::
./system.slice/setvtrgb.service/cpu.max
::::::::::::::
max 100000
::::::::::::::
./proc-sys-fs-binfmt_misc.mount/cpu.max.burst
::::::::::::::
0
::::::::::::::
./proc-sys-fs-binfmt_misc.mount/cpu.max
::::::::::::::
max 100000
::::::::::::::
./machine.slice/cpu.max.burst
::::::::::::::
0
::::::::::::::
./machine.slice/cpu.max
::::::::::::::
max 100000
::::::::::::::
./dev-hugepages.mount/cpu.max.burst
::::::::::::::
0
::::::::::::::
./dev-hugepages.mount/cpu.max
::::::::::::::
max 100000
root@integral2:/sys/fs/cgroup#


-- 
Ammar Faizi
