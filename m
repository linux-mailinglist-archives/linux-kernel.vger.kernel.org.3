Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D7CA4B9072
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Feb 2022 19:40:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237716AbiBPSks (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Feb 2022 13:40:48 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:50956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230455AbiBPSko (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Feb 2022 13:40:44 -0500
Received: from julia1.inet.fi (mta-out1.inet.fi [62.71.2.194])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9D1DE2ABD0C
        for <linux-kernel@vger.kernel.org>; Wed, 16 Feb 2022 10:40:30 -0800 (PST)
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
X-RazorGate-Vade: gggruggvucftvghtrhhoucdtuddrgedvvddrjeeigdduudehucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuuffpveftnecuuegrihhlohhuthemuceftddtnecunecujfgurhepkfffgggfvffhufgtgfesthekredttdefjeenucfhrhhomhepkfhlkhhkrgcurfhruhhsihcuoehilhhkkhgrrdhprhhushhisehpphdrihhnvghtrdhfiheqnecuggftrfgrthhtvghrnhepjeejvdetjeeukeeghedvledvheehiedvfeehhfeiudekveekleejveeiieffvdelnecukfhppeekgedrvdehuddrudelgedrudeigeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhephhgvlhhopegludelvddrudeikedruddrudeftdgnpdhinhgvthepkeegrddvhedurdduleegrdduieegpdhmrghilhhfrhhomhepoehprhhushhilhdqudesmhgsohigrdhinhgvthdrfhhiqecuuefqffgjpeekuefkvffokffogfdpnhgspghrtghpthhtohepuddprhgtphhtthhopeeolhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgqe
Received: from [192.168.1.130] (84.251.194.164) by julia1.inet.fi (9.0.019.26-1) (authenticated as prusil-1)
        id 61E9A0DF0097D74A for linux-kernel@vger.kernel.org; Wed, 16 Feb 2022 20:40:26 +0200
Message-ID: <b66cf1eb-1945-ee84-4941-06d20311c961@pp.inet.fi>
Date:   Wed, 16 Feb 2022 20:40:25 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
To:     linux-kernel@vger.kernel.org
Content-Language: en-US
From:   Ilkka Prusi <ilkka.prusi@pp.inet.fi>
Subject: Splat in 5.16.10: drm_syncobj_find_fence
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

There's a splat in drm_syncobj_find_fence which has been around for a 
while: at least since 5.16.7.

Linux version 5.16.10 (gcc (Debian 11.2.0-16) 11.2.0, GNU ld (GNU 
Binutils for Debian) 2.38) #1 SMP PREEMPT Wed Feb 16 15:22:16 EET 2022

$ scripts/decode_stacktrace.sh ./vmlinux < ~/splat/51610drm
[11417.480491] WARNING: CPU: 5 PID: 23918 at 
drivers/gpu/drm/drm_syncobj.c:400 drm_syncobj_find_fence 
(drivers/gpu/drm/drm_syncobj.c:400)
[11417.480501] Modules linked in: uinput(E) snd_seq_dummy(E) 
snd_hrtimer(E) snd_seq(E) nfnetlink(E) binfmt_misc(E) nls_ascii(E) 
nls_cp850(E) vfat(E) fat(E) amdgpu(E) snd_hda_codec_realtek(E) 
snd_hda_codec_generic(E) ledtrig_audio(E) snd_usb_audio(E) 
snd_hda_codec_hdmi(E) snd_hda_intel(E) snd_usbmidi_lib(E) 
snd_intel_dspcfg(E) intel_rapl_msr(E) snd_rawmidi(E) 
intel_rapl_common(E) gpu_sched(E) snd_hda_codec(E) drm_ttm_helper(E) 
ttm(E) snd_seq_device(E) iosf_mbi(E) mc(E) hid_sony(E) ff_memless(E) 
input_leds(E) edac_mce_amd(E) drm_kms_helper(E) snd_hda_core(E) 
kvm_amd(E) snd_hwdep(E) joydev(E) snd_pcm(E) syscopyarea(E) kvm(E) 
snd_timer(E) snd(E) sysfillrect(E) soundcore(E) ccp(E) irqbypass(E) 
sysimgblt(E) fb_sys_fops(E) sg(E) evdev(E) wmi_bmof(E) k10temp(E) 
crct10dif_pclmul(E) crc32_pclmul(E) rng_core(E) ghash_clmulni_intel(E) 
efi_pstore(E) aesni_intel(E) tiny_power_button(E) crypto_simd(E) 
acpi_cpufreq(E) cryptd(E) button(E) rapl(E) nfsd(E) auth_rpcgss(E) 
nfs_acl(E) lockd(E)
[11417.480549]  grace(E) fuse(E) msr(E) sunrpc(E) configfs(E) 
ip_tables(E) x_tables(E) ipv6(E) autofs4(E) efivarfs(E) raid10(E) 
raid456(E) async_raid6_recov(E) async_memcpy(E) async_pq(E) async_xor(E) 
xor(E) async_tx(E) raid6_pq(E) libcrc32c(E) raid1(E) raid0(E) 
multipath(E) linear(E) md_mod(E) hid_generic(E) usbhid(E) hid(E) 
crc32c_intel(E) xhci_pci(E) i2c_piix4(E) xhci_hcd(E) usbcore(E) 
sd_mod(E) igb(E) t10_pi(E) usb_common(E) dca(E) wmi(E) thermal(E)
[11417.480581] CPU: 5 PID: 23918 Comm: GameThread Tainted: G            
E     5.16.10 #1
[11417.480584] Hardware name: Gigabyte Technology Co., Ltd. X570 AORUS 
ELITE/X570 AORUS ELITE, BIOS F21 08/20/2020
[11417.480587] RIP: 0010:drm_syncobj_find_fence 
(drivers/gpu/drm/drm_syncobj.c:400)
[11417.480593] Code: 66 66 48 31 c0 8b 0d e8 4f ba 00 85 c9 0f 84 a1 fd 
ff ff 65 48 8b 04 25 80 ee 01 00 8b 90 50 08 00 00 85 d2 0f 84 8a fd ff 
ff <0f> 0b e9 83 fd ff ff 49 83 3e 00 0f 85 49 ff ff ff 89 45 88 e8 94
All code
========
    0:    66 66 48 31 c0           data16 data16 xor %rax,%rax
    5:    8b 0d e8 4f ba 00        mov 0xba4fe8(%rip),%ecx        # 0xba4ff3
    b:    85 c9                    test   %ecx,%ecx
    d:    0f 84 a1 fd ff ff        je     0xfffffffffffffdb4
   13:    65 48 8b 04 25 80 ee     mov    %gs:0x1ee80,%rax
   1a:    01 00
   1c:    8b 90 50 08 00 00        mov    0x850(%rax),%edx
   22:    85 d2                    test   %edx,%edx
   24:    0f 84 8a fd ff ff        je     0xfffffffffffffdb4
   2a:*    0f 0b                    ud2            <-- trapping instruction
   2c:    e9 83 fd ff ff           jmp    0xfffffffffffffdb4
   31:    49 83 3e 00              cmpq   $0x0,(%r14)
   35:    0f 85 49 ff ff ff        jne    0xffffffffffffff84
   3b:    89 45 88                 mov    %eax,-0x78(%rbp)
   3e:    e8                       .byte 0xe8
   3f:    94                       xchg   %eax,%esp

Code starting with the faulting instruction
===========================================
    0:    0f 0b                    ud2
    2:    e9 83 fd ff ff           jmp    0xfffffffffffffd8a
    7:    49 83 3e 00              cmpq   $0x0,(%r14)
    b:    0f 85 49 ff ff ff        jne    0xffffffffffffff5a
   11:    89 45 88                 mov    %eax,-0x78(%rbp)
   14:    e8                       .byte 0xe8
   15:    94                       xchg   %eax,%esp
[11417.480596] RSP: 0018:ffffc900049fbab0 EFLAGS: 00010202
[11417.480599] RAX: ffff8882ede29800 RBX: 0000000000000002 RCX: 
0000000000000001
[11417.480601] RDX: 0000000000000001 RSI: ffff8881cfb9f980 RDI: 
000000012a05f200
[11417.480603] RBP: ffffc900049fbb40 R08: 0000000000000000 R09: 
0000000000000001
[11417.480605] R10: 0000000000000000 R11: 0000000000000000 R12: 
ffff8881170dd780
[11417.480606] R13: 00000000000004e2 R14: ffffc900049fbb58 R15: 
0000000000000001
[11417.480608] FS:  000000007a47f640(0000) GS:ffff88842e940000(0000) 
knlGS:0000000067e50000
[11417.480611] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[11417.480613] CR2: 00007f98b802f0b8 CR3: 0000000207da4000 CR4: 
00000000001506e0
[11417.480614] Call Trace:
[11417.480617]  <TASK>
[11417.480620] ? find_held_lock (kernel/locking/lockdep.c:5130)
[11417.480626] ? amdgpu_ctx_wait_prev_fence 
(drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c:652) amdgpu
[11417.480777] ? amdgpu_syncobj_lookup_and_add_to_sync 
(drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c:1013) amdgpu
[11417.480914] amdgpu_syncobj_lookup_and_add_to_sync 
(drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c:1013) amdgpu
[11417.481038] amdgpu_cs_ioctl 
(drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c:1061 
drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c:1176 
drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c:1343) amdgpu
[11417.481188] ? amdgpu_cs_find_mapping 
(drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c:1316) amdgpu
[11417.481326] drm_ioctl_kernel (drivers/gpu/drm/drm_ioctl.c:788)
[11417.481333] drm_ioctl (drivers/gpu/drm/drm_ioctl.c:886)
[11417.481337] ? amdgpu_cs_find_mapping 
(drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c:1316) amdgpu
[11417.481473] ? __pm_runtime_resume (drivers/base/power/runtime.c:1135)
[11417.481476] ? lock_release (kernel/locking/lockdep.c:5315 
kernel/locking/lockdep.c:5657)
[11417.481481] ? _raw_spin_unlock_irqrestore 
(./arch/x86/include/asm/irqflags.h:139 
./include/linux/spinlock_api_smp.h:151 kernel/locking/spinlock.c:194)
[11417.481486] amdgpu_drm_ioctl 
(drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c:2498) amdgpu
[11417.481622] __x64_sys_ioctl (fs/ioctl.c:52 fs/ioctl.c:874 
fs/ioctl.c:860 fs/ioctl.c:860)
[11417.481627] do_syscall_64 (arch/x86/entry/common.c:50 
arch/x86/entry/common.c:80)
[11417.481631] entry_SYSCALL_64_after_hwframe 
(arch/x86/entry/entry_64.S:113)
[11417.481634] RIP: 0033:0x7f990b3a2b07
[11417.481638] Code: 3c 1c e8 1c ff ff ff 85 c0 79 87 49 c7 c4 ff ff ff 
ff 5b 5d 4c 89 e0 41 5c c3 66 0f 1f 84 00 00 00 00 00 b8 10 00 00 00 0f 
05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 39 83 0c 00 f7 d8 64 89 01 48
All code
========
    0:    3c 1c                    cmp    $0x1c,%al
    2:    e8 1c ff ff ff           call   0xffffffffffffff23
    7:    85 c0                    test   %eax,%eax
    9:    79 87                    jns    0xffffffffffffff92
    b:    49 c7 c4 ff ff ff ff     mov    $0xffffffffffffffff,%r12
   12:    5b                       pop    %rbx
   13:    5d                       pop    %rbp
   14:    4c 89 e0                 mov    %r12,%rax
   17:    41 5c                    pop    %r12
   19:    c3                       ret
   1a:    66 0f 1f 84 00 00 00     nopw   0x0(%rax,%rax,1)
   21:    00 00
   23:    b8 10 00 00 00           mov    $0x10,%eax
   28:    0f 05                    syscall
   2a:*    48 3d 01 f0 ff ff        cmp $0xfffffffffffff001,%rax        
<-- trapping instruction
   30:    73 01                    jae    0x33
   32:    c3                       ret
   33:    48 8b 0d 39 83 0c 00     mov    0xc8339(%rip),%rcx # 0xc8373
   3a:    f7 d8                    neg    %eax
   3c:    64 89 01                 mov    %eax,%fs:(%rcx)
   3f:    48                       rex.W

Code starting with the faulting instruction
===========================================
    0:    48 3d 01 f0 ff ff        cmp    $0xfffffffffffff001,%rax
    6:    73 01                    jae    0x9
    8:    c3                       ret
    9:    48 8b 0d 39 83 0c 00     mov    0xc8339(%rip),%rcx # 0xc8349
   10:    f7 d8                    neg    %eax
   12:    64 89 01                 mov    %eax,%fs:(%rcx)
   15:    48                       rex.W
[11417.481641] RSP: 002b:000000007a47e218 EFLAGS: 00000246 ORIG_RAX: 
0000000000000010
[11417.481646] RAX: ffffffffffffffda RBX: 000000007a47e290 RCX: 
00007f990b3a2b07
[11417.481648] RDX: 000000007a47e290 RSI: 00000000c0186444 RDI: 
0000000000000097
[11417.481651] RBP: 00000000c0186444 R08: 00007f98b802f140 R09: 
000000007a47e468
[11417.481653] R10: 000000007ec92d10 R11: 0000000000000246 R12: 
00007f98b802f100
[11417.481656] R13: 0000000000000097 R14: 0000000000000000 R15: 
00007f98b802efa0
[11417.481660]  </TASK>

--

  - Ilkka


