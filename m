Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FE674CB1A9
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Mar 2022 23:01:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242034AbiCBWCY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Mar 2022 17:02:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236858AbiCBWCW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Mar 2022 17:02:22 -0500
X-Greylist: delayed 460 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 02 Mar 2022 14:01:35 PST
Received: from arashi.greysector.net (arashi.greysector.net [51.68.141.79])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CE47CD5D7;
        Wed,  2 Mar 2022 14:01:35 -0800 (PST)
Received: from sakura.greysector.net (37.30.40.30.nat.umts.dynamic.t-mobile.pl [37.30.40.30])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by arashi.greysector.net (Postfix) with ESMTPSA id AF61A138D;
        Wed,  2 Mar 2022 22:53:51 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 arashi.greysector.net AF61A138D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=greysector.net;
        s=default; t=1646258032;
        bh=+6+RkQe0MbTJpTJIkhDXme85iXcXoTeHCmwWM/geZs0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=cDlbIZisp0syaJrp1y3e6Dq1/NN9jfTlDd1EBbl0Dkfoy54wJac3QCN0rK0tu+xdr
         H690dWwottkioWtg3OwoUmmiDGiMSJIocVD2ehYFde341AiE2IJggBvDdRnOIrv4tG
         OUKZiV6j6eatDggjEz+q82YbrpHp9hw1L8qoN+r4=
Date:   Wed, 2 Mar 2022 22:53:49 +0100
From:   Dominik Mierzejewski <dominik@greysector.net>
To:     Song Liu <song@kernel.org>
Cc:     Thorsten Leemhuis <regressions@leemhuis.info>,
        linux-raid <linux-raid@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "regressions@lists.linux.dev" <regressions@lists.linux.dev>,
        Jens Axboe <axboe@kernel.dk>
Subject: Re: Bug 215605 - [5.14 regression] BUG: unable to handle page fault
 while running badblocks (fsck.ext4 -c) on a raid5 md array
Message-ID: <Yh/nbZYmYD6SpZV9@sakura.greysector.net>
References: <53e7de78-4d27-5089-f159-0d443b354666@leemhuis.info>
 <35bafd68-b340-dfaa-dd5f-d45843104f91@leemhuis.info>
 <CAPhsuW44tX0rBpy5c63HgTtRSF=UAAsgv8ZuYE_QTLhi6syXaA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <CAPhsuW44tX0rBpy5c63HgTtRSF=UAAsgv8ZuYE_QTLhi6syXaA@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

On Tuesday, 01 March 2022 at 01:24, Song Liu wrote:
> On Mon, Feb 28, 2022 at 1:43 AM Thorsten Leemhuis
> <regressions@leemhuis.info> wrote:
> >
> > [CCing Jens]
> >
> > Hi, this is your Linux kernel regression tracker. Top-posting for once,
> > to make this easily accessible to everyone.
> >
> > What's up here? Below regression was reported two weeks ago and I
> > forwarded it nearly a week ago, nevertheless the reporter afaics didn't
> > get a single reply. Is the issue discussed somewhere else and I just
> > missed it? Is the report not accurate for some reason or missing
> > something important? Or did the report fall throug the cracks?
>=20
> Sorry for the late reply. I was on vacation last week.

No problem, thanks for responding.

[...]
> > On 22.02.22 09:59, Thorsten Leemhuis wrote:
> > > Hi, this is your Linux kernel regression tracker.
> > >
> > > I noticed a regression report in bugzilla.kernel.org that afaics nobo=
dy
> > > acted upon since it was reported about a week ago, that's why I decid=
ed
> > > to forward it to the lists and add a few relevant people to the CC. To
> > > quote from https://bugzilla.kernel.org/show_bug.cgi?id=3D215605
> > >
> > >>  Dominik Mierzejewski 2022-02-14 10:36:36 UTC
> > >>
> > >> Created attachment 300450 [details]
> > >> kernel-5.16.8 dmesg with crash
> > >>
> > >> I'm experiencing kernel crash when running badblocks (fsck.ext4 -c) =
on a raid5 md array in my Intel Atom-based NAS box (Thecus N5550):
> > >> [  720.911993] kernel: BUG: unable to handle page fault for address:=
 ffffdbc681023bc8
> > >> [  720.912073] kernel: #PF: supervisor read access in kernel mode
> > >> [  720.912120] kernel: #PF: error_code(0x0000) - not-present page
> > >> [  720.912166] kernel: PGD 11ffc6067 P4D 11ffc6067 PUD 0
> > >> [  720.912213] kernel: Oops: 0000 [#1] PREEMPT SMP NOPTI
> > >> [  720.912256] kernel: CPU: 1 PID: 1406 Comm: badblocks Not tainted =
5.16.8-200.fc35.x86_64 #1
> > >> [  720.912321] kernel: Hardware name: Intel Corporation Milstead Pla=
tform/Granite Well, BIOS CDV W Series 05 08/27/2015
> > >> [  720.912400] kernel: RIP: 0010:kfree+0x58/0x3e0
> > >> [  720.912449] kernel: Code: 80 4c 01 e5 0f 82 84 03 00 00 48 c7 c0 =
00 00 00 80 48 2b 05 4a 96 3b 01 48 01 c5 48 c1 ed 0c 48 c1 e5 06 48 03 2d =
28 96 3b 01 <48> 8b 45 08 48 8d 50 ff a8 01 48 0f 45 ea 4
> > >> 8 8b 55 08 48 8d 42 ff
> > >> [  720.912598] kernel: RSP: 0018:ffff9db4008efaf8 EFLAGS: 00010286
> > >> [  720.912648] kernel: RAX: 00006d7bc0000000 RBX: ffff9284c5214800 R=
CX: ffff9284c3758ff8
> > >> [  720.912708] kernel: RDX: ffff9283c1102740 RSI: ffffffffc07af091 R=
DI: ffff9db4008efd58
> > >> [  720.912767] kernel: RBP: ffffdbc681023bc0 R08: ffff9db4008efb88 R=
09: ffff9284c3759000
> > >> [  720.912826] kernel: R10: 0000000000000028 R11: ffff9284c213db48 R=
12: ffff9db4008efd58
> > >> [  720.912885] kernel: R13: ffff9284c213da00 R14: ffff9284c375f000 R=
15: ffff9db4008efd58
> > >> [  720.912945] kernel: FS:  00007f73e6669740(0000) GS:ffff9284dbc800=
00(0000) knlGS:0000000000000000
> > >> [  720.913012] kernel: CS:  0010 DS: 0000 ES: 0000 CR0: 000000008005=
0033
> > >> [  720.913062] kernel: CR2: ffffdbc681023bc8 CR3: 000000005c2cc000 C=
R4: 00000000000006e0
> > >> [  720.913122] kernel: Call Trace:
> > >> [  720.913150] kernel:  <TASK>
> > >> [  720.913179] kernel:  raid5_make_request+0xb31/0xb90 [raid456]
> > >> [  720.913247] kernel:  ? do_wait_intr_irq+0xa0/0xa0
> > >> [  720.913292] kernel:  ? __blk_queue_split+0x30a/0x470
> > >> [  720.913339] kernel:  md_handle_request+0x119/0x180
> > >> [  720.913386] kernel:  md_submit_bio+0x67/0xa0
> > >> [  720.913425] kernel:  __submit_bio_fops+0x91/0x160
> > >> [  720.913468] kernel:  submit_bio_noacct+0xd7/0x2c0
> > >> [  720.913510] kernel:  __blkdev_direct_IO_simple+0x198/0x290
> > >> [  720.913576] kernel:  ? __fpu_restore_sig+0x193/0x570
> > >> [  720.913623] kernel:  ? sysvec_apic_timer_interrupt+0xaf/0xd0
> > >> [  720.913676] kernel:  ? __blkdev_direct_IO_simple+0x290/0x290
> > >> [  720.913728] kernel:  generic_file_read_iter+0x9b/0x160
> > >> [  720.913775] kernel:  new_sync_read+0x105/0x180
> > >> [  720.913820] kernel:  vfs_read+0xf1/0x190
> > >> [  720.913858] kernel:  ksys_read+0x4f/0xc0
> > >> [  720.913896] kernel:  do_syscall_64+0x38/0x90
> > >> [  720.913936] kernel:  entry_SYSCALL_64_after_hwframe+0x44/0xae
> > >> [  720.913985] kernel: RIP: 0033:0x7f73e676d772
> > >> [  720.914024] kernel: Code: c0 e9 b2 fe ff ff 50 48 8d 3d da 2e 0c =
00 e8 b5 f9 01 00 0f 1f 44 00 00 f3 0f 1e fa 64 8b 04 25 18 00 00 00 85 c0 =
75 10 0f 05 <48> 3d 00 f0 ff ff 77 56 c3 0f 1f 44 00 00 48 83 ec 28 48 89 5=
4 24
> > >> [  720.914166] kernel: RSP: 002b:00007fff1b8fcbb8 EFLAGS: 00000246 O=
RIG_RAX: 0000000000000000
> > >> [  720.914231] kernel: RAX: ffffffffffffffda RBX: 0000000000000040 R=
CX: 00007f73e676d772
> > >> [  720.917149] kernel: RDX: 0000000000040000 RSI: 00007f73e65d3000 R=
DI: 0000000000000004
> > >> [  720.920078] kernel: RBP: 0000000000001000 R08: 00000000015105c0 R=
09: 0000000000000080
> > >> [  720.922980] kernel: R10: 00007fff1b8fca00 R11: 0000000000000246 R=
12: 00000015105c0000
> > >> [  720.925875] kernel: R13: 0000000000000004 R14: 00007f73e65d3000 R=
15: 0000000000040000
> > >> [  720.928795] kernel:  </TASK>
> > >> [  720.931704] kernel: Modules linked in: sctp ip6_udp_tunnel udp_tu=
nnel rpcrdma rdma_cm iw_cm ib_cm ib_core sit tunnel4 ip_tunnel rfkill ipt_R=
EJECT nf_reject_ipv4 iptable_filter xt_nat iptable_nat nf_nat iptable_mangl=
e nf_conntrack_pptp xt_CT iptable_raw xt_multiport xt_set ip6t_REJECT nf_re=
ject_ipv6 xt_LOG nf_log_syslog xt_limit xt_state xt_conntrack nf_conntrack =
nf_defrag_ipv6 nf_defrag_ipv4 ip6table_filter ip6_tables ip_set_hash_netpor=
t ip_set_hash_net ip_set drivetemp it87 nfnetlink hwmon_vid vfat fat iTCO_w=
dt intel_pmc_bxt iTCO_vendor_support at24 raid456 async_raid6_recov async_m=
emcpy async_pq async_xor async_tx intel_powerclamp raid1 coretemp snd_hda_c=
odec_realtek snd_hda_codec_generic ledtrig_audio snd_hda_codec_hdmi snd_hda=
_intel snd_intel_dspcfg snd_intel_sdw_acpi snd_hda_codec snd_hda_core snd_u=
sb_audio i2c_i801 gma500_gfx i2c_smbus snd_usbmidi_lib joydev snd_hwdep snd=
_rawmidi snd_seq_device mc snd_pcm lpc_ich i2c_algo_bit snd_timer drm_kms_h=
elper snd cec soundcore nfsd auth_rpcgss
> > >> [  720.931885] kernel:  nfs_acl lockd grace drm fuse sunrpc zram ip_=
tables hid_logitech_hidpp serio_raw r8152 sata_sil24 video mii hid_jabra e1=
000e hid_logitech_dj
> > >> [  720.952122] kernel: CR2: ffffdbc681023bc8
> > >> [  720.955651] kernel: ---[ end trace de2c3d5b971ae71d ]---
> > >> [  720.959186] kernel: RIP: 0010:kfree+0x58/0x3e0
> > >> [  720.962723] kernel: Code: 80 4c 01 e5 0f 82 84 03 00 00 48 c7 c0 =
00 00 00 80 48 2b 05 4a 96 3b 01 48 01 c5 48 c1 ed 0c 48 c1 e5 06 48 03 2d =
28 96 3b 01 <48> 8b 45 08 48 8d 50 ff a8 01 48 0f 45 ea 48 8b 55 08 48 8d 4=
2 ff
> > >> [  720.966472] kernel: RSP: 0018:ffff9db4008efaf8 EFLAGS: 00010286
> > >> [  720.970238] kernel: RAX: 00006d7bc0000000 RBX: ffff9284c5214800 R=
CX: ffff9284c3758ff8
> > >> [  720.973993] kernel: RDX: ffff9283c1102740 RSI: ffffffffc07af091 R=
DI: ffff9db4008efd58
> > >> [  720.977723] kernel: RBP: ffffdbc681023bc0 R08: ffff9db4008efb88 R=
09: ffff9284c3759000
> > >> [  720.981464] kernel: R10: 0000000000000028 R11: ffff9284c213db48 R=
12: ffff9db4008efd58
> > >> [  720.985228] kernel: R13: ffff9284c213da00 R14: ffff9284c375f000 R=
15: ffff9db4008efd58
> > >> [  720.988995] kernel: FS:  00007f73e6669740(0000) GS:ffff9284dbc800=
00(0000) knlGS:0000000000000000
> > >> [  720.992774] kernel: CS:  0010 DS: 0000 ES: 0000 CR0: 000000008005=
0033
> > >> [  720.996535] kernel: CR2: ffffdbc681023bc8 CR3: 000000005c2cc000 C=
R4: 00000000000006e0
>=20
> I tried a few things (injecting badblocks, etc.) but still could not
> reproduce this issue.
>=20
> Hi Dominik,
>=20
> Could you please share more information about the array?

Please note that I repaired the array by stopping it and reassembling
without badblocks maps:
# mdadm --assemble -U force-no-bbl /dev/md126 /dev/sdb1 /dev/sdc1 /dev/sdd1=
 /dev/sde1 /dev/sdf1

I ran fsck on it and repaired multiple-owned blocks. It's been running
smoothly since then, even under kernel 5.16.9. I'm not sure the
following information will be useful now.

>    mdadm --detail /dev/mdXXX

# mdadm --detail /dev/md126
/dev/md126:
           Version : 1.2
     Creation Time : Sat Oct 19 22:39:14 2019
        Raid Level : raid5
        Array Size : 11720531968 (10.92 TiB 12.00 TB)
     Used Dev Size : 2930132992 (2.73 TiB 3.00 TB)
      Raid Devices : 5
     Total Devices : 5
       Persistence : Superblock is persistent

     Intent Bitmap : Internal

       Update Time : Wed Mar  2 22:29:09 2022
             State : clean=20
    Active Devices : 5
   Working Devices : 5
    Failed Devices : 0
     Spare Devices : 0

            Layout : left-symmetric
        Chunk Size : 512K

Consistency Policy : bitmap

              Name : any:nas
              UUID : 4fef0683:8f39a12d:eb69f742:b501ef53
            Events : 71011

    Number   Major   Minor   RaidDevice State
       6       8       17        0      active sync   /dev/sdb1
       1       8       33        1      active sync   /dev/sdc1
       7       8       49        2      active sync   /dev/sdd1
       3       8       65        3      active sync   /dev/sde1
       5       8       81        4      active sync   /dev/sdf1

>    mdadm --examine /dev/<devices>

# mdadm --examine /dev/sdb1
/dev/sdb1:
          Magic : a92b4efc
        Version : 1.2
    Feature Map : 0x1
     Array UUID : 4fef0683:8f39a12d:eb69f742:b501ef53
           Name : any:nas
  Creation Time : Sat Oct 19 22:39:14 2019
     Raid Level : raid5
   Raid Devices : 5

 Avail Dev Size : 5860266895 sectors (2.73 TiB 3.00 TB)
     Array Size : 11720531968 KiB (10.92 TiB 12.00 TB)
  Used Dev Size : 5860265984 sectors (2.73 TiB 3.00 TB)
    Data Offset : 264192 sectors
   Super Offset : 8 sectors
   Unused Space : before=3D264112 sectors, after=3D911 sectors
          State : clean
    Device UUID : 506215d3:7893b583:1b956e6a:532d7751

Internal Bitmap : 8 sectors from superblock
    Update Time : Wed Mar  2 22:29:09 2022
       Checksum : b8ce0df8 - correct
         Events : 71011

         Layout : left-symmetric
     Chunk Size : 512K

   Device Role : Active device 0
   Array State : AAAAA ('A' =3D=3D active, '.' =3D=3D missing, 'R' =3D=3D r=
eplacing)
# mdadm --examine /dev/sdc1
/dev/sdc1:
          Magic : a92b4efc
        Version : 1.2
    Feature Map : 0x1
     Array UUID : 4fef0683:8f39a12d:eb69f742:b501ef53
           Name : any:nas
  Creation Time : Sat Oct 19 22:39:14 2019
     Raid Level : raid5
   Raid Devices : 5

 Avail Dev Size : 5860266895 sectors (2.73 TiB 3.00 TB)
     Array Size : 11720531968 KiB (10.92 TiB 12.00 TB)
  Used Dev Size : 5860265984 sectors (2.73 TiB 3.00 TB)
    Data Offset : 264192 sectors
   Super Offset : 8 sectors
   Unused Space : before=3D264112 sectors, after=3D911 sectors
          State : clean
    Device UUID : 9ab16a47:b23435f3:9231fd6b:e7d709d4

Internal Bitmap : 8 sectors from superblock
    Update Time : Wed Mar  2 22:29:09 2022
       Checksum : 20c43ebb - correct
         Events : 71011

         Layout : left-symmetric
     Chunk Size : 512K

   Device Role : Active device 1
   Array State : AAAAA ('A' =3D=3D active, '.' =3D=3D missing, 'R' =3D=3D r=
eplacing)
# mdadm --examine /dev/sdd1
/dev/sdd1:
          Magic : a92b4efc
        Version : 1.2
    Feature Map : 0x1
     Array UUID : 4fef0683:8f39a12d:eb69f742:b501ef53
           Name : any:nas
  Creation Time : Sat Oct 19 22:39:14 2019
     Raid Level : raid5
   Raid Devices : 5

 Avail Dev Size : 5860266895 sectors (2.73 TiB 3.00 TB)
     Array Size : 11720531968 KiB (10.92 TiB 12.00 TB)
  Used Dev Size : 5860265984 sectors (2.73 TiB 3.00 TB)
    Data Offset : 264192 sectors
   Super Offset : 8 sectors
   Unused Space : before=3D264112 sectors, after=3D911 sectors
          State : clean
    Device UUID : 44265974:c83d899d:9bab17f4:59a0786e

Internal Bitmap : 8 sectors from superblock
    Update Time : Wed Mar  2 22:29:09 2022
       Checksum : 1a8ffefc - correct
         Events : 71011

         Layout : left-symmetric
     Chunk Size : 512K

   Device Role : Active device 2
   Array State : AAAAA ('A' =3D=3D active, '.' =3D=3D missing, 'R' =3D=3D r=
eplacing)
# mdadm --examine /dev/sde1
/dev/sde1:
          Magic : a92b4efc
        Version : 1.2
    Feature Map : 0x1
     Array UUID : 4fef0683:8f39a12d:eb69f742:b501ef53
           Name : any:nas
  Creation Time : Sat Oct 19 22:39:14 2019
     Raid Level : raid5
   Raid Devices : 5

 Avail Dev Size : 5860266895 sectors (2.73 TiB 3.00 TB)
     Array Size : 11720531968 KiB (10.92 TiB 12.00 TB)
  Used Dev Size : 5860265984 sectors (2.73 TiB 3.00 TB)
    Data Offset : 264192 sectors
   Super Offset : 8 sectors
   Unused Space : before=3D264112 sectors, after=3D911 sectors
          State : clean
    Device UUID : 722420f5:3d9c05e0:71bad4ca:add63b08

Internal Bitmap : 8 sectors from superblock
    Update Time : Wed Mar  2 22:29:09 2022
       Checksum : 4e53a0c5 - correct
         Events : 71011

         Layout : left-symmetric
     Chunk Size : 512K

   Device Role : Active device 3
   Array State : AAAAA ('A' =3D=3D active, '.' =3D=3D missing, 'R' =3D=3D r=
eplacing)
# mdadm --examine /dev/sdf1
/dev/sdf1:
          Magic : a92b4efc
        Version : 1.2
    Feature Map : 0x1
     Array UUID : 4fef0683:8f39a12d:eb69f742:b501ef53
           Name : any:nas
  Creation Time : Sat Oct 19 22:39:14 2019
     Raid Level : raid5
   Raid Devices : 5

 Avail Dev Size : 5860266895 sectors (2.73 TiB 3.00 TB)
     Array Size : 11720531968 KiB (10.92 TiB 12.00 TB)
  Used Dev Size : 5860265984 sectors (2.73 TiB 3.00 TB)
    Data Offset : 264192 sectors
   Super Offset : 8 sectors
   Unused Space : before=3D264112 sectors, after=3D911 sectors
          State : clean
    Device UUID : 6c2badc9:f7803c8b:9ee398c0:b4e7497d

Internal Bitmap : 8 sectors from superblock
    Update Time : Wed Mar  2 22:29:09 2022
       Checksum : 38e9c6af - correct
         Events : 71011

         Layout : left-symmetric
     Chunk Size : 512K

   Device Role : Active device 4
   Array State : AAAAA ('A' =3D=3D active, '.' =3D=3D missing, 'R' =3D=3D r=
eplacing)


Regards,
Dominik

--=20
Fedora   https://getfedora.org  |  RPM Fusion  http://rpmfusion.org
There should be a science of discontent. People need hard times and
oppression to develop psychic muscles.
        -- from "Collected Sayings of Muad'Dib" by the Princess Irulan
