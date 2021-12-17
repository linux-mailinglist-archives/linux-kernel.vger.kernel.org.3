Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ACD7947881C
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Dec 2021 10:51:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234147AbhLQJvY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Dec 2021 04:51:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231277AbhLQJvY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Dec 2021 04:51:24 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE7AAC061574;
        Fri, 17 Dec 2021 01:51:23 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8C62B620A2;
        Fri, 17 Dec 2021 09:51:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 702EAC36AE5;
        Fri, 17 Dec 2021 09:51:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1639734683;
        bh=42ES+pkzLEfhP4yjsuXoF4sMsBiBLRo7s6O4AeSrOnA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=008DYAiUqZT9BIrujIt9PMB5MiWxj90JdZzEwbpu/uqIZKLjRN9GoaCT1G4EKFEGU
         k5VzLTPsu9UShOMzAobE+xlDKRclhko+3XSo1rDIy/L6KqvYsvrTJ/FJp0GJP20tQO
         4tUvFBcRQq2A6YixafBImuSPJaZi1BciAIpwQlJw=
Date:   Fri, 17 Dec 2021 10:51:20 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Vincent Pelletier <plr.vincent@gmail.com>
Cc:     Felipe Balbi <balbi@kernel.org>, Jens Axboe <axboe@kernel.dk>,
        Salah Triki <salah.triki@gmail.com>,
        Dean Anderson <dean@sensoray.com>,
        Andrew Gabbasov <andrew_gabbasov@mentor.com>,
        Wesley Cheng <wcheng@codeaurora.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] usb: gadget: f_fs: Clear ffs_eventfd in ffs_data_reset.
Message-ID: <YbxdmB1gYAiOZrtN@kroah.com>
References: <96948a63d1a33da63b4f226e89ea90d21e9b0f82.1639528369.git.plr.vincent@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <96948a63d1a33da63b4f226e89ea90d21e9b0f82.1639528369.git.plr.vincent@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 15, 2021 at 12:32:49AM +0000, Vincent Pelletier wrote:
> ffs_data_reset is called from both ffs_fs_kill_sb and ffs_ep0_release, so
> it ends up being called twice when userland closes ep0 and then unmounts
> f_fs. If userland provided an eventfd along with function's USB
> descriptors, ffs_data_clear (via ffs_data_reset) ends up calling
> eventfd_ctx_put as many times, causing a refcount underflow warning
> (as of 5.15 at least). NULL-ify ffs_eventfd to prevent these extraneous
> eventfd_ctx_put calls.
> 
> For completeness, ffs_data_clear actually ends up being called thrice, the
> last call being before the whole ffs structure gets freed, so when this
> specific sequence happens there is a second underflow happening (but not
> being reported):
> 
> /sys/kernel/debug/tracing# modprobe usb_f_fs
> /sys/kernel/debug/tracing# echo ffs_data_clear > set_ftrace_filter
> /sys/kernel/debug/tracing# echo function > current_tracer
> /sys/kernel/debug/tracing# echo 1 > tracing_on
> (setup gadget, run and kill function userland process, teardown gadget)
> /sys/kernel/debug/tracing# echo 0 > tracing_on
> /sys/kernel/debug/tracing# cat trace
> # tracer: function
> #
> # entries-in-buffer/entries-written: 3/3   #P:1
> #
> #                                _-----=> irqs-off
> #                               / _----=> need-resched
> #                              | / _---=> hardirq/softirq
> #                              || / _--=> preempt-depth
> #                              ||| / _-=> migrate-disable
> #                              |||| /     delay
> #           TASK-PID     CPU#  |||||  TIMESTAMP  FUNCTION
> #              | |         |   |||||     |         |
>  smartcard-openp-436     [000] .....  1946.208786: ffs_data_clear <-ffs_data_closed
>  smartcard-openp-431     [000] .....  1946.279147: ffs_data_clear <-ffs_data_closed
>  smartcard-openp-431     [000] .n...  1946.905512: ffs_data_clear <-ffs_data_put
> 
> Warning output corresponding to above trace:
> [ 1946.284139] WARNING: CPU: 0 PID: 431 at lib/refcount.c:28 refcount_warn_saturate+0x110/0x15c
> [ 1946.293094] refcount_t: underflow; use-after-free.
> [ 1946.298164] Modules linked in: usb_f_ncm(E) u_ether(E) usb_f_fs(E) hci_uart(E) btqca(E) btrtl(E) btbcm(E) btintel(E) bluetooth(E) nls_ascii(E) nls_cp437(E) vfat(E) fat(E) bcm2835_v4l2(CE) bcm2835_mmal_vchiq(CE) videobuf2_vmalloc(E) videobuf2_memops(E) sha512_generic(E) videobuf2_v4l2(E) sha512_arm(E) videobuf2_common(E) videodev(E) cpufreq_dt(E) snd_bcm2835(CE) brcmfmac(E) mc(E) vc4(E) ctr(E) brcmutil(E) snd_soc_core(E) snd_pcm_dmaengine(E) drbg(E) snd_pcm(E) snd_timer(E) snd(E) soundcore(E) drm_kms_helper(E) cec(E) ansi_cprng(E) rc_core(E) syscopyarea(E) raspberrypi_cpufreq(E) sysfillrect(E) sysimgblt(E) cfg80211(E) max17040_battery(OE) raspberrypi_hwmon(E) fb_sys_fops(E) regmap_i2c(E) ecdh_generic(E) rfkill(E) ecc(E) bcm2835_rng(E) rng_core(E) vchiq(CE) leds_gpio(E) libcomposite(E) fuse(E) configfs(E) ip_tables(E) x_tables(E) autofs4(E) ext4(E) crc16(E) mbcache(E) jbd2(E) crc32c_generic(E) sdhci_iproc(E) sdhci_pltfm(E) sdhci(E)
> [ 1946.399633] CPU: 0 PID: 431 Comm: smartcard-openp Tainted: G         C OE     5.15.0-1-rpi #1  Debian 5.15.3-1
> [ 1946.417950] Hardware name: BCM2835
> [ 1946.425442] Backtrace:
> [ 1946.432048] [<c08d60a0>] (dump_backtrace) from [<c08d62ec>] (show_stack+0x20/0x24)
> [ 1946.448226]  r7:00000009 r6:0000001c r5:c04a948c r4:c0a64e2c
> [ 1946.458412] [<c08d62cc>] (show_stack) from [<c08d9ae0>] (dump_stack+0x28/0x30)
> [ 1946.470380] [<c08d9ab8>] (dump_stack) from [<c0123500>] (__warn+0xe8/0x154)
> [ 1946.482067]  r5:c04a948c r4:c0a71dc8
> [ 1946.490184] [<c0123418>] (__warn) from [<c08d6948>] (warn_slowpath_fmt+0xa0/0xe4)
> [ 1946.506758]  r7:00000009 r6:0000001c r5:c0a71dc8 r4:c0a71e04
> [ 1946.517070] [<c08d68ac>] (warn_slowpath_fmt) from [<c04a948c>] (refcount_warn_saturate+0x110/0x15c)
> [ 1946.535309]  r8:c0100224 r7:c0dfcb84 r6:ffffffff r5:c3b84c00 r4:c24a17c0
> [ 1946.546708] [<c04a937c>] (refcount_warn_saturate) from [<c0380134>] (eventfd_ctx_put+0x48/0x74)
> [ 1946.564476] [<c03800ec>] (eventfd_ctx_put) from [<bf5464e8>] (ffs_data_clear+0xd0/0x118 [usb_f_fs])
> [ 1946.582664]  r5:c3b84c00 r4:c2695b00
> [ 1946.590668] [<bf546418>] (ffs_data_clear [usb_f_fs]) from [<bf547cc0>] (ffs_data_closed+0x9c/0x150 [usb_f_fs])
> [ 1946.609608]  r5:bf54d014 r4:c2695b00
> [ 1946.617522] [<bf547c24>] (ffs_data_closed [usb_f_fs]) from [<bf547da0>] (ffs_fs_kill_sb+0x2c/0x30 [usb_f_fs])
> [ 1946.636217]  r7:c0dfcb84 r6:c3a12260 r5:bf54d014 r4:c229f000
> [ 1946.646273] [<bf547d74>] (ffs_fs_kill_sb [usb_f_fs]) from [<c0326d50>] (deactivate_locked_super+0x54/0x9c)
> [ 1946.664893]  r5:bf54d014 r4:c229f000
> [ 1946.672921] [<c0326cfc>] (deactivate_locked_super) from [<c0326df8>] (deactivate_super+0x60/0x64)
> [ 1946.690722]  r5:c2a09000 r4:c229f000
> [ 1946.698706] [<c0326d98>] (deactivate_super) from [<c0349a28>] (cleanup_mnt+0xe4/0x14c)
> [ 1946.715553]  r5:c2a09000 r4:00000000
> [ 1946.723528] [<c0349944>] (cleanup_mnt) from [<c0349b08>] (__cleanup_mnt+0x1c/0x20)
> [ 1946.739922]  r7:c0dfcb84 r6:c3a12260 r5:c3a126fc r4:00000000
> [ 1946.750088] [<c0349aec>] (__cleanup_mnt) from [<c0143d10>] (task_work_run+0x84/0xb8)
> [ 1946.766602] [<c0143c8c>] (task_work_run) from [<c010bdc8>] (do_work_pending+0x470/0x56c)
> [ 1946.783540]  r7:5ac3c35a r6:c0d0424c r5:c200bfb0 r4:c200a000
> [ 1946.793614] [<c010b958>] (do_work_pending) from [<c01000c0>] (slow_work_pending+0xc/0x20)
> [ 1946.810553] Exception stack(0xc200bfb0 to 0xc200bff8)
> [ 1946.820129] bfa0:                                     00000000 00000000 000000aa b5e21430
> [ 1946.837104] bfc0: bef867a0 00000001 bef86840 00000034 bef86838 bef86790 bef86794 bef867a0
> [ 1946.854125] bfe0: 00000000 bef86798 b67b7a1c b6d626a4 60000010 b5a23760
> [ 1946.865335]  r10:00000000 r9:c200a000 r8:c0100224 r7:00000034 r6:bef86840 r5:00000001
> [ 1946.881914]  r4:bef867a0
> [ 1946.888793] ---[ end trace 7387f2a9725b28d0 ]---
> 
> Signed-off-by: Vincent Pelletier <plr.vincent@gmail.com>
> ---
>  drivers/usb/gadget/function/f_fs.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/usb/gadget/function/f_fs.c b/drivers/usb/gadget/function/f_fs.c
> index e20c19a0f106..437141a11ec6 100644
> --- a/drivers/usb/gadget/function/f_fs.c
> +++ b/drivers/usb/gadget/function/f_fs.c
> @@ -1791,6 +1791,7 @@ static void ffs_data_reset(struct ffs_data *ffs)
>  	ffs_data_clear(ffs);
>  
>  	ffs->epfiles = NULL;
> +	ffs->ffs_eventfd = NULL;

Shouldn't this be happening in ffs_data_clear() instead?  After the call
to eventfd_ctx_put() as that is when the file descriptor is properly
dropped.

thanks,

greg k-h
