Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 45FAF4789E9
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Dec 2021 12:30:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235353AbhLQLaH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Dec 2021 06:30:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229817AbhLQLaG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Dec 2021 06:30:06 -0500
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com [IPv6:2607:f8b0:4864:20::b2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9983FC061574;
        Fri, 17 Dec 2021 03:30:06 -0800 (PST)
Received: by mail-yb1-xb2d.google.com with SMTP id v64so5464415ybi.5;
        Fri, 17 Dec 2021 03:30:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=aOBPWhZYKzkWKLVOthhY+WUZqiQzKnfV0++kMV9Fubw=;
        b=HMl1SUR/V4uAidtCVooWbZET7ARV3TI9hoUQp9I+OBKHP6bce2t4PadxH0Q0ZUcADY
         CPZfYSpO8SP2ZAtvuoZQ3Xb5ZYSQZ6eoAUvEcpdbhjlrb7oMaj/ZnPeMfAFC2tAZCb7u
         UlFC+AnWS65Ek3Q6T2s1UiGqx1FtjLQB35eEOonj8hilNUx3PDa5ykD17ReowcP0/hTu
         wLK0pV+aMuFPXkRGRYKuxmzfCCf8EFVQNY8r5TIgKwPcHAr2pFNej4hGXi94XPlktkX1
         HsO4ieZNwncUi/ME5DlnJ3uI8FIqN3IW8VvLQf9C3ik1mR+6rxoUYc4g+R6FCCam9ukE
         kT/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=aOBPWhZYKzkWKLVOthhY+WUZqiQzKnfV0++kMV9Fubw=;
        b=0RutrrlQJYbEzoEuLJdf77Dd544FzQ30gzj1LRsxhs4o3vhSsY0jVPU+dRsxX8gDBW
         pnwSGpPBp3NscgQC3wKtxOAYgerEkL9esnSwPFW1wccla5jHbvjkqtLkEL9fac0zhIQw
         k4YeoZbua0/gDG/fHV1ublpxHKa2htUAIXSogVnIQjCE0xzWO+9OUfd1u71eWDGgLP76
         csyReEA/I+ynKBrnVW/EgktA2uL92g7xwpxcyLjlBuwrnrMC9Gc5ueWK76YfGzPH9paV
         Y5j2b+8q5NuWpQU9N5M6kShacAU6nUeuR85UjA/NPpoSHDzkfP/3T3y3RFr3kKTZS6DM
         8W+g==
X-Gm-Message-State: AOAM533tY4WAgBQY+dlvX77DLwhyiKsbOfbfPeK3VCjgHM4n5wSTvJ1/
        ZJpu0c6vLNh7/VpIyHOBDYEcQ/s1kxGG5lCzLnw=
X-Google-Smtp-Source: ABdhPJw06sDmSxIers+PVy3dXC2nJgUu03KM6T+ZT0SLdrUovQPKlRuq3seVJz/qZ1n3UdpBe+t17pX5TiuknVPmwOQ=
X-Received: by 2002:a25:8b04:: with SMTP id i4mr4070101ybl.663.1639740605811;
 Fri, 17 Dec 2021 03:30:05 -0800 (PST)
MIME-Version: 1.0
References: <96948a63d1a33da63b4f226e89ea90d21e9b0f82.1639528369.git.plr.vincent@gmail.com>
 <YbxdmB1gYAiOZrtN@kroah.com>
In-Reply-To: <YbxdmB1gYAiOZrtN@kroah.com>
From:   Vincent Pelletier <plr.vincent@gmail.com>
Date:   Fri, 17 Dec 2021 20:29:54 +0900
Message-ID: <CAF78GY0pX35672aVZOzgsUdXA5PmnOiydHkmRiiC2=fk+atV7g@mail.gmail.com>
Subject: Re: [PATCH] usb: gadget: f_fs: Clear ffs_eventfd in ffs_data_reset.
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Felipe Balbi <balbi@kernel.org>, Jens Axboe <axboe@kernel.dk>,
        Salah Triki <salah.triki@gmail.com>,
        Dean Anderson <dean@sensoray.com>,
        Andrew Gabbasov <andrew_gabbasov@mentor.com>,
        Wesley Cheng <wcheng@codeaurora.org>,
        USB list <linux-usb@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 17, 2021 at 6:51 PM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Wed, Dec 15, 2021 at 12:32:49AM +0000, Vincent Pelletier wrote:
> > ffs_data_reset is called from both ffs_fs_kill_sb and ffs_ep0_release, =
so
> > it ends up being called twice when userland closes ep0 and then unmount=
s
> > f_fs. If userland provided an eventfd along with function's USB
> > descriptors, ffs_data_clear (via ffs_data_reset) ends up calling
> > eventfd_ctx_put as many times, causing a refcount underflow warning
> > (as of 5.15 at least). NULL-ify ffs_eventfd to prevent these extraneous
> > eventfd_ctx_put calls.
> >
> > For completeness, ffs_data_clear actually ends up being called thrice, =
the
> > last call being before the whole ffs structure gets freed, so when this
> > specific sequence happens there is a second underflow happening (but no=
t
> > being reported):
> >
> > /sys/kernel/debug/tracing# modprobe usb_f_fs
> > /sys/kernel/debug/tracing# echo ffs_data_clear > set_ftrace_filter
> > /sys/kernel/debug/tracing# echo function > current_tracer
> > /sys/kernel/debug/tracing# echo 1 > tracing_on
> > (setup gadget, run and kill function userland process, teardown gadget)
> > /sys/kernel/debug/tracing# echo 0 > tracing_on
> > /sys/kernel/debug/tracing# cat trace
> > # tracer: function
> > #
> > # entries-in-buffer/entries-written: 3/3   #P:1
> > #
> > #                                _-----=3D> irqs-off
> > #                               / _----=3D> need-resched
> > #                              | / _---=3D> hardirq/softirq
> > #                              || / _--=3D> preempt-depth
> > #                              ||| / _-=3D> migrate-disable
> > #                              |||| /     delay
> > #           TASK-PID     CPU#  |||||  TIMESTAMP  FUNCTION
> > #              | |         |   |||||     |         |
> >  smartcard-openp-436     [000] .....  1946.208786: ffs_data_clear <-ffs=
_data_closed
> >  smartcard-openp-431     [000] .....  1946.279147: ffs_data_clear <-ffs=
_data_closed
> >  smartcard-openp-431     [000] .n...  1946.905512: ffs_data_clear <-ffs=
_data_put
> >
> > Warning output corresponding to above trace:
> > [ 1946.284139] WARNING: CPU: 0 PID: 431 at lib/refcount.c:28 refcount_w=
arn_saturate+0x110/0x15c
> > [ 1946.293094] refcount_t: underflow; use-after-free.
> > [ 1946.298164] Modules linked in: usb_f_ncm(E) u_ether(E) usb_f_fs(E) h=
ci_uart(E) btqca(E) btrtl(E) btbcm(E) btintel(E) bluetooth(E) nls_ascii(E) =
nls_cp437(E) vfat(E) fat(E) bcm2835_v4l2(CE) bcm2835_mmal_vchiq(CE) videobu=
f2_vmalloc(E) videobuf2_memops(E) sha512_generic(E) videobuf2_v4l2(E) sha51=
2_arm(E) videobuf2_common(E) videodev(E) cpufreq_dt(E) snd_bcm2835(CE) brcm=
fmac(E) mc(E) vc4(E) ctr(E) brcmutil(E) snd_soc_core(E) snd_pcm_dmaengine(E=
) drbg(E) snd_pcm(E) snd_timer(E) snd(E) soundcore(E) drm_kms_helper(E) cec=
(E) ansi_cprng(E) rc_core(E) syscopyarea(E) raspberrypi_cpufreq(E) sysfillr=
ect(E) sysimgblt(E) cfg80211(E) max17040_battery(OE) raspberrypi_hwmon(E) f=
b_sys_fops(E) regmap_i2c(E) ecdh_generic(E) rfkill(E) ecc(E) bcm2835_rng(E)=
 rng_core(E) vchiq(CE) leds_gpio(E) libcomposite(E) fuse(E) configfs(E) ip_=
tables(E) x_tables(E) autofs4(E) ext4(E) crc16(E) mbcache(E) jbd2(E) crc32c=
_generic(E) sdhci_iproc(E) sdhci_pltfm(E) sdhci(E)
> > [ 1946.399633] CPU: 0 PID: 431 Comm: smartcard-openp Tainted: G        =
 C OE     5.15.0-1-rpi #1  Debian 5.15.3-1
> > [ 1946.417950] Hardware name: BCM2835
> > [ 1946.425442] Backtrace:
> > [ 1946.432048] [<c08d60a0>] (dump_backtrace) from [<c08d62ec>] (show_st=
ack+0x20/0x24)
> > [ 1946.448226]  r7:00000009 r6:0000001c r5:c04a948c r4:c0a64e2c
> > [ 1946.458412] [<c08d62cc>] (show_stack) from [<c08d9ae0>] (dump_stack+=
0x28/0x30)
> > [ 1946.470380] [<c08d9ab8>] (dump_stack) from [<c0123500>] (__warn+0xe8=
/0x154)
> > [ 1946.482067]  r5:c04a948c r4:c0a71dc8
> > [ 1946.490184] [<c0123418>] (__warn) from [<c08d6948>] (warn_slowpath_f=
mt+0xa0/0xe4)
> > [ 1946.506758]  r7:00000009 r6:0000001c r5:c0a71dc8 r4:c0a71e04
> > [ 1946.517070] [<c08d68ac>] (warn_slowpath_fmt) from [<c04a948c>] (refc=
ount_warn_saturate+0x110/0x15c)
> > [ 1946.535309]  r8:c0100224 r7:c0dfcb84 r6:ffffffff r5:c3b84c00 r4:c24a=
17c0
> > [ 1946.546708] [<c04a937c>] (refcount_warn_saturate) from [<c0380134>] =
(eventfd_ctx_put+0x48/0x74)
> > [ 1946.564476] [<c03800ec>] (eventfd_ctx_put) from [<bf5464e8>] (ffs_da=
ta_clear+0xd0/0x118 [usb_f_fs])
> > [ 1946.582664]  r5:c3b84c00 r4:c2695b00
> > [ 1946.590668] [<bf546418>] (ffs_data_clear [usb_f_fs]) from [<bf547cc0=
>] (ffs_data_closed+0x9c/0x150 [usb_f_fs])
> > [ 1946.609608]  r5:bf54d014 r4:c2695b00
> > [ 1946.617522] [<bf547c24>] (ffs_data_closed [usb_f_fs]) from [<bf547da=
0>] (ffs_fs_kill_sb+0x2c/0x30 [usb_f_fs])
> > [ 1946.636217]  r7:c0dfcb84 r6:c3a12260 r5:bf54d014 r4:c229f000
> > [ 1946.646273] [<bf547d74>] (ffs_fs_kill_sb [usb_f_fs]) from [<c0326d50=
>] (deactivate_locked_super+0x54/0x9c)
> > [ 1946.664893]  r5:bf54d014 r4:c229f000
> > [ 1946.672921] [<c0326cfc>] (deactivate_locked_super) from [<c0326df8>]=
 (deactivate_super+0x60/0x64)
> > [ 1946.690722]  r5:c2a09000 r4:c229f000
> > [ 1946.698706] [<c0326d98>] (deactivate_super) from [<c0349a28>] (clean=
up_mnt+0xe4/0x14c)
> > [ 1946.715553]  r5:c2a09000 r4:00000000
> > [ 1946.723528] [<c0349944>] (cleanup_mnt) from [<c0349b08>] (__cleanup_=
mnt+0x1c/0x20)
> > [ 1946.739922]  r7:c0dfcb84 r6:c3a12260 r5:c3a126fc r4:00000000
> > [ 1946.750088] [<c0349aec>] (__cleanup_mnt) from [<c0143d10>] (task_wor=
k_run+0x84/0xb8)
> > [ 1946.766602] [<c0143c8c>] (task_work_run) from [<c010bdc8>] (do_work_=
pending+0x470/0x56c)
> > [ 1946.783540]  r7:5ac3c35a r6:c0d0424c r5:c200bfb0 r4:c200a000
> > [ 1946.793614] [<c010b958>] (do_work_pending) from [<c01000c0>] (slow_w=
ork_pending+0xc/0x20)
> > [ 1946.810553] Exception stack(0xc200bfb0 to 0xc200bff8)
> > [ 1946.820129] bfa0:                                     00000000 00000=
000 000000aa b5e21430
> > [ 1946.837104] bfc0: bef867a0 00000001 bef86840 00000034 bef86838 bef86=
790 bef86794 bef867a0
> > [ 1946.854125] bfe0: 00000000 bef86798 b67b7a1c b6d626a4 60000010 b5a23=
760
> > [ 1946.865335]  r10:00000000 r9:c200a000 r8:c0100224 r7:00000034 r6:bef=
86840 r5:00000001
> > [ 1946.881914]  r4:bef867a0
> > [ 1946.888793] ---[ end trace 7387f2a9725b28d0 ]---
> >
> > Signed-off-by: Vincent Pelletier <plr.vincent@gmail.com>
> > ---
> >  drivers/usb/gadget/function/f_fs.c | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/drivers/usb/gadget/function/f_fs.c b/drivers/usb/gadget/fu=
nction/f_fs.c
> > index e20c19a0f106..437141a11ec6 100644
> > --- a/drivers/usb/gadget/function/f_fs.c
> > +++ b/drivers/usb/gadget/function/f_fs.c
> > @@ -1791,6 +1791,7 @@ static void ffs_data_reset(struct ffs_data *ffs)
> >       ffs_data_clear(ffs);
> >
> >       ffs->epfiles =3D NULL;
> > +     ffs->ffs_eventfd =3D NULL;
>
> Shouldn't this be happening in ffs_data_clear() instead?  After the call
> to eventfd_ctx_put() as that is when the file descriptor is properly
> dropped.

This was my initial intent while debugging, but when preparing this
submission I realised epfiles is in the same boat, and
ffs_data_reset is where it is getting set to NULL.
So I followed the pattern.

If preferred, I can move both to ffs_data_clear, as I think it would
make the code more obviously correct (...and it may have made
this bug more obvious and maybe avoided it entirely).
The only reason I can think of for the current state is to avoid one
NULL (two with my change) writes when the structure will be freed
rigth after, when the caller is ffs_data_put. I don't think this makes
much of a difference, though.

Regards,
--=20
Vincent Pelletier
