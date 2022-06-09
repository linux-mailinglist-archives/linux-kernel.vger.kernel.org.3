Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CDFC54553A
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jun 2022 22:00:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240169AbiFIUAE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jun 2022 16:00:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233197AbiFIUAA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 16:00:00 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D05020F7D
        for <linux-kernel@vger.kernel.org>; Thu,  9 Jun 2022 12:59:59 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id z17so21969036pff.7
        for <linux-kernel@vger.kernel.org>; Thu, 09 Jun 2022 12:59:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=pernos.co; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OfFDHPBngLRjb8shihLod/N8EQQSRuroYX6SE8cdG/Y=;
        b=Pon0rWfCYD7F9W1TC70xHB3mQJu2UJxcG6ixnDi1sBQi1WaamGaPWN5x9aCkybmmM4
         Jfbnw5/oBqbbFtADDEXFGW5nGx3bqZctpgQYS04EqnA/sG3mrMfMP8+L2Dg9TcEogGoL
         tz28Mn+YdtCYcvyeSvd7rmbfoT3Ash6J4zDDw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OfFDHPBngLRjb8shihLod/N8EQQSRuroYX6SE8cdG/Y=;
        b=OuQnTxzLnDNkrXyDWwXhgx5diPeWIzI07ypxooAJexFXNvBJL9iAzd7vELQA8a1pGb
         qm0OUHHj0Mskzofg/Wz7q/Jigjp8CJe/zw+PxVTGhryM3t4rERGrA0G8pgk5xbyXH4p0
         gWehdSaCgzAnh/0exfK224AT3r/oGMONWKtEgWdVL4TqLgaYYmQ50g3SSLGLYHn8kZSA
         1QNrsIa93lLkqwa1cMxnNvbekrOGAQ/63Bu03D4X+LWdw5Qrc8rUp8YULppnRICUOciF
         piaGlZyxZ5DvExjRMtF/kmfVhnvytfdFrRQd7c+JL4hZugEtJ/m0eu3Gd2vs7BPm//oO
         PP5g==
X-Gm-Message-State: AOAM5327xEDyY7q+jaqOu/ScG/+v07+L53f/tISjLsS/KwpS6vcTGcLH
        wDp9YnDUXYulOTqxZTuEOt5JCqu40lPkCeOD5KbriA==
X-Google-Smtp-Source: ABdhPJwgRAZJPuHBvj6rFDzj8LpDA/TGtXSisPo4modrpcBjPptrmlAmX0u/x7Bxm1C6aJsglI7mJbcMrspFsb00L1o=
X-Received: by 2002:a62:140c:0:b0:51b:bd14:6859 with SMTP id
 12-20020a62140c000000b0051bbd146859mr42774765pfu.28.1654804798500; Thu, 09
 Jun 2022 12:59:58 -0700 (PDT)
MIME-Version: 1.0
References: <20220421150248.667412396@infradead.org> <20220421150654.817117821@infradead.org>
 <87czhap9dy.fsf@email.froward.int.ebiederm.org> <878rrrh32q.fsf_-_@email.froward.int.ebiederm.org>
 <87k0b7v9yk.fsf_-_@email.froward.int.ebiederm.org> <87k0b0apne.fsf_-_@email.froward.int.ebiederm.org>
 <87a6bv6dl6.fsf_-_@email.froward.int.ebiederm.org> <871qwq5ucx.fsf_-_@email.froward.int.ebiederm.org>
 <CALWUPBdFDLuT7JaNGSJ_UXbHf8y9uKdC-SkAqzd=FQC0MX4nNQ@mail.gmail.com>
 <YoXhfGGPKnT/YFC1@linutronix.de> <8735h54cur.fsf@email.froward.int.ebiederm.org>
 <CALWUPBdPO0ccBpFjQ-Lb5GsD=DcBw8ZyVwYVhLdpSeCcu2BSEg@mail.gmail.com> <877d5t4vqj.fsf@email.froward.int.ebiederm.org>
In-Reply-To: <877d5t4vqj.fsf@email.froward.int.ebiederm.org>
From:   Kyle Huey <khuey@pernos.co>
Date:   Thu, 9 Jun 2022 12:59:39 -0700
Message-ID: <CALWUPBe2T1-CVpuQ1tVrCZRB6uDK+rPBKqr=yxV+3n37ZrTpWA@mail.gmail.com>
Subject: Re: [PATCH 00/16] ptrace: cleanups and calling do_cldstop with only siglock
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>, rjw@rjwysocki.net,
        oleg@redhat.com, mingo@kernel.org, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, mgorman@suse.de,
        Will Deacon <will@kernel.org>, tj@kernel.org,
        linux-pm@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>,
        Richard Weinberger <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        linux-um@lists.infradead.org, Chris Zankel <chris@zankel.net>,
        Max Filippov <jcmvbkbc@gmail.com>,
        linux-xtensa@linux-xtensa.org, Jann Horn <jannh@google.com>,
        Kees Cook <keescook@chromium.org>, linux-ia64@vger.kernel.org,
        "Robert O'Callahan" <roc@pernos.co>,
        Richard Henderson <rth@twiddle.net>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Matt Turner <mattst88@gmail.com>,
        Jason Wessel <jason.wessel@windriver.com>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Douglas Anderson <dianders@chromium.org>,
        Douglas Miller <dougmill@linux.vnet.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 6, 2022 at 9:12 AM Eric W. Biederman <ebiederm@xmission.com> wrote:
>
> Kyle Huey <khuey@pernos.co> writes:
>
> > On Thu, May 19, 2022 at 11:05 AM Eric W. Biederman
> > <ebiederm@xmission.com> wrote:
> >>
> >> Sebastian Andrzej Siewior <bigeasy@linutronix.de> writes:
> >>
> >> > On 2022-05-18 20:26:05 [-0700], Kyle Huey wrote:
> >> >> Is there a git branch somewhere I can pull to test this? It doesn't apply
> >> >> cleanly to Linus's tip.
> >> >
> >> > https://kernel.googlesource.com/pub/scm/linux/kernel/git/ebiederm/user-namespace.git ptrace_stop-cleanup-for-v5.19
> >>
> >> Yes that is the branch this all applies to.
> >>
> >> This is my second round of cleanups this cycle for this code.
> >> I just keep finding little things that deserve to be changed,
> >> when I am working on the more substantial issues.
> >>
> >> Eric
> >
> > When running the rr test suite, I see hangs like this
>
> Thanks.  I will dig into this.
>
> Is there an easy way I can run the rr test suite to see if I can
> reproduce this myself?

It should be a straight forward
1. https://github.com/rr-debugger/rr.git
2. mkdir obj-rr && cd obj-rr
3. cmake ../rr
4. make -jN
5. make check

If you have trouble with it feel free to email me off list.

- Kyle

> Thanks,
> Eric
>
> >
> > [  812.151505] watchdog: BUG: soft lockup - CPU#3 stuck for 548s!
> > [condvar_stress-:12152]
> > [  812.151529] Modules linked in: snd_hda_codec_realtek
> > snd_hda_codec_generic ledtrig_audio rfcomm cmac algif_hash
> > algif_skcipher af_alg bnep dm_crypt intel_rapl_msr mei_hdcp
> > snd_hda_codec_
> > hdmi intel_rapl_common snd_hda_intel x86_pkg_temp_thermal
> > snd_intel_dspcfg snd_intel_sdw_acpi nls_iso8859_1 intel_powerclamp
> > snd_hda_codec coretemp snd_hda_core snd_hwdep snd_pcm rtl8723be
> > btcoexist snd_seq_midi snd_seq_midi_event rtl8723_common kvm_intel
> > rtl_pci snd_rawmidi rtlwifi btusb btrtl btbcm snd_seq kvm mac80211
> > btintel btmtk snd_seq_device rapl bluetooth snd_timer i
> > ntel_cstate hp_wmi cfg80211 serio_raw snd platform_profile
> > ecdh_generic mei_me sparse_keymap efi_pstore wmi_bmof ee1004 joydev
> > input_leds ecc libarc4 soundcore mei acpi_pad mac_hid sch_fq_c
> > odel ipmi_devintf ipmi_msghandler msr vhost_vsock
> > vmw_vsock_virtio_transport_common vsock vhost_net vhost vhost_iotlb
> > tap vhci_hcd usbip_core parport_pc ppdev lp parport ip_tables x_tables
> > autofs4 btrfs blake2b_generic xor raid6_pq zstd_compress
> > [  812.151570]  libcrc32c hid_generic usbhid hid i915 drm_buddy
> > i2c_algo_bit ttm drm_dp_helper cec rc_core crct10dif_pclmul
> > drm_kms_helper crc32_pclmul syscopyarea ghash_clmulni_intel sysfi
> > llrect sysimgblt fb_sys_fops aesni_intel crypto_simd cryptd r8169
> > psmouse drm i2c_i801 realtek ahci i2c_smbus xhci_pci libahci
> > xhci_pci_renesas wmi video
> > [  812.151584] CPU: 3 PID: 12152 Comm: condvar_stress- Tainted: G
> >     I  L    5.18.0-rc1+ #2
> > [  812.151586] Hardware name: HP 750-280st/2B4B, BIOS A0.11 02/24/2016
> > [  812.151587] RIP: 0010:_raw_spin_unlock_irq+0x15/0x40
> > [  812.151591] Code: df e8 3f 1f 4a ff 90 5b 5d c3 66 66 2e 0f 1f 84
> > 00 00 00 00 00 0f 1f 44 00 00 55 48 89 e5 c6 07 00 0f 1f 00 fb 0f 1f
> > 44 00 00 <bf> 01 00 00 00 e8 41 95 46 ff 65 8b 05 9
> > a c1 9a 5f 85 c0 74 02 5d
> > [  812.151593] RSP: 0018:ffffa863c246bd70 EFLAGS: 00000246
> > [  812.151594] RAX: ffff8bc0913f6400 RBX: ffff8bc0913f6400 RCX: 0000000000000000
> > [  812.151595] RDX: 0000000000000002 RSI: 00000000000a0013 RDI: ffff8bc089b63180
> > [  812.151596] RBP: ffffa863c246bd70 R08: ffff8bc0811d6b40 R09: ffff8bc089b63180
> > [  812.151597] R10: 0000000000000000 R11: 0000000000000004 R12: ffff8bc0913f6400
> > [  812.151597] R13: ffff8bc089b63180 R14: ffff8bc0913f6400 R15: ffffa863c246be68
> > [  812.151598] FS:  00007f612dda5700(0000) GS:ffff8bc7e24c0000(0000)
> > knlGS:0000000000000000
> > [  812.151599] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > [  812.151600] CR2: 000055e70715692e CR3: 000000010b4e8005 CR4: 00000000003706e4
> > [  812.151601] Call Trace:
> > [  812.151602]  <TASK>
> > [  812.151604]  do_signal_stop+0x228/0x260
> > [  812.151606]  get_signal+0x43a/0x8e0
> > [  812.151608]  arch_do_signal_or_restart+0x37/0x7d0
> > [  812.151610]  ? __this_cpu_preempt_check+0x13/0x20
> > [  812.151612]  ? __perf_event_task_sched_in+0x81/0x230
> > [  812.151616]  ? __this_cpu_preempt_check+0x13/0x20
> > [  812.151617]  exit_to_user_mode_prepare+0x130/0x1a0
> > [  812.151620]  syscall_exit_to_user_mode+0x26/0x40
> > [  812.151621]  ret_from_fork+0x15/0x30
> > [  812.151623] RIP: 0033:0x7f612dfcd125
> > [  812.151625] Code: 48 85 ff 74 3d 48 85 f6 74 38 48 83 ee 10 48 89
> > 4e 08 48 89 3e 48 89 d7 4c 89 c2 4d 89 c8 4c 8b 54 24 08 b8 38 00 00
> > 00 0f 05 <48> 85 c0 7c 13 74 01 c3 31 ed 58 5f ff d
> > 0 48 89 c7 b8 3c 00 00 00
> > [  812.151626] RSP: 002b:00007f612dda4fb0 EFLAGS: 00000246 ORIG_RAX:
> > 0000000000000038
> > [  812.151628] RAX: 0000000000000000 RBX: 00007f612dda5700 RCX: ffffffffffffffff
> > [  812.151628] RDX: 00007f612dda59d0 RSI: 00007f612dda4fb0 RDI: 00000000003d0f00
> > [  812.151629] RBP: 00007ffd59ad20b0 R08: 00007f612dda5700 R09: 00007f612dda5700
> > [  812.151630] R10: 00007f612dda59d0 R11: 0000000000000246 R12: 00007ffd59ad20ae
> > [  812.151631] R13: 00007ffd59ad20af R14: 00007ffd59ad20b0 R15: 00007f612dda4fc0
> > [  812.151632]  </TASK>
> >
> > - Kyle
