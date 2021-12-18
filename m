Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6FFBA479826
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Dec 2021 03:18:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231685AbhLRCSs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Dec 2021 21:18:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229709AbhLRCSr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Dec 2021 21:18:47 -0500
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2191C061574;
        Fri, 17 Dec 2021 18:18:46 -0800 (PST)
Received: by mail-pf1-x432.google.com with SMTP id l6so1666066pfu.0;
        Fri, 17 Dec 2021 18:18:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=aQbYOaNOGsOWo3uhKpDPTCV/GN+BYcoAoahcmgVbBUs=;
        b=BYhDj7XiiWX8v19wSaQcKAc+exmCAz73zH3QINDGhFyA9aKag/D9NKjoV2xPj16ZHt
         ywY7LqKEd8xf3bdw2zYKqrDCFYQaidey/eULdw+m2Be7p91saF0Ui6hW8bau2JiNAAeY
         g7u6bUJkzcvAZ4DmAle6cGx6XRMb4QTrd/YZeZK0Pb2o4P/aZ5GragKLhHhhvdfFbw6y
         zZ16BAibkVEw4bca1Wbh6uPnuATq/RjMrWLf4UjQ/TOJbkgFPMMH2Jj0K3m8Apz6kJCw
         wiE2TTVmTZjFE33HEZBW9ITj1Pps9TvS1vGUi1BWSptwv9C/CDXlSMV6W8mqHgUOPRob
         7Ntw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=aQbYOaNOGsOWo3uhKpDPTCV/GN+BYcoAoahcmgVbBUs=;
        b=lnc97LGxE5WU+GCGlEje3UJNfWsWcGOfea57CzL3u0Cwwh7QYNrSsV9Q5xjh4XoibB
         btZT8BtTbAVlKu8+wu2KZgCh2MbjLgR1oFIQqBVAuWtkNX1jXAo9qoi/C5cU4OZxy/zM
         FKRrCbQXmkoj/6oe3UyhQUWLsiTZyCjaPApkaBIBCYVlmGugvB3e2XK14vRqQ8htRRDe
         VYzZjNi8Q7JLoU4rEIGVr+CPgczStgcZOxoxI2LwW02lCOKViou8QjvokfatVaKyAr/V
         zQQY5aeYC/FjSMJju7zLQriSM763LdJDpYhZYk/J60Mb0yBfwxi4vgjCajXYVKKfF7Bb
         i9CA==
X-Gm-Message-State: AOAM530D/csxmgr/3q5j05rPzwbtMwnuOHD2h7KkoIzR6nWyMD+W2LDM
        XqFotphKkAbsT87wA9zrmoI=
X-Google-Smtp-Source: ABdhPJycJooP2uxit88PfsqLWlu7qYUZZx3nltAeWNCehVT4/8WUDu13bWVGIn8JwTH3W8z6x+L3Pw==
X-Received: by 2002:a05:6a00:1308:b0:4a2:75cd:883a with SMTP id j8-20020a056a00130800b004a275cd883amr5820048pfu.84.1639793925932;
        Fri, 17 Dec 2021 18:18:45 -0800 (PST)
Received: from localhost.lan ([2400:4070:175b:7500::7a7])
        by smtp.gmail.com with ESMTPSA id n3sm9765126pgc.76.2021.12.17.18.18.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Dec 2021 18:18:45 -0800 (PST)
Received: from x2.lan (localhost [127.0.0.1])
        by localhost.lan (Postfix) with ESMTPSA id 0A668900908;
        Sat, 18 Dec 2021 02:18:43 +0000 (GMT)
From:   Vincent Pelletier <plr.vincent@gmail.com>
To:     Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jens Axboe <axboe@kernel.dk>,
        Salah Triki <salah.triki@gmail.com>,
        Dean Anderson <dean@sensoray.com>,
        Andrew Gabbasov <andrew_gabbasov@mentor.com>,
        Wesley Cheng <wcheng@codeaurora.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] usb: gadget: f_fs: Clear ffs_eventfd in ffs_data_clear.
Date:   Sat, 18 Dec 2021 02:18:40 +0000
Message-Id: <f79eeea29f3f98de6782a064ec0f7351ad2f598f.1639793920.git.plr.vincent@gmail.com>
X-Mailer: git-send-email 2.34.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ffs_data_clear is indirectly called from both ffs_fs_kill_sb and
ffs_ep0_release, so it ends up being called twice when userland closes ep0
and then unmounts f_fs.
If userland provided an eventfd along with function's USB descriptors, it
ends up calling eventfd_ctx_put as many times, causing a refcount
underflow.
NULL-ify ffs_eventfd to prevent these extraneous eventfd_ctx_put calls.

Also, set epfiles to NULL right after de-allocating it, for readability.

For completeness, ffs_data_clear actually ends up being called thrice, the
last call being before the whole ffs structure gets freed, so when this
specific sequence happens there is a second underflow happening (but not
being reported):

/sys/kernel/debug/tracing# modprobe usb_f_fs
/sys/kernel/debug/tracing# echo ffs_data_clear > set_ftrace_filter
/sys/kernel/debug/tracing# echo function > current_tracer
/sys/kernel/debug/tracing# echo 1 > tracing_on
(setup gadget, run and kill function userland process, teardown gadget)
/sys/kernel/debug/tracing# echo 0 > tracing_on
/sys/kernel/debug/tracing# cat trace
# tracer: function
#
# entries-in-buffer/entries-written: 3/3   #P:1
#
#                                _-----=> irqs-off
#                               / _----=> need-resched
#                              | / _---=> hardirq/softirq
#                              || / _--=> preempt-depth
#                              ||| / _-=> migrate-disable
#                              |||| /     delay
#           TASK-PID     CPU#  |||||  TIMESTAMP  FUNCTION
#              | |         |   |||||     |         |
 smartcard-openp-436     [000] .....  1946.208786: ffs_data_clear <-ffs_data_closed
 smartcard-openp-431     [000] .....  1946.279147: ffs_data_clear <-ffs_data_closed
 smartcard-openp-431     [000] .n...  1946.905512: ffs_data_clear <-ffs_data_put

Warning output corresponding to above trace:
[ 1946.284139] WARNING: CPU: 0 PID: 431 at lib/refcount.c:28 refcount_warn_saturate+0x110/0x15c
[ 1946.293094] refcount_t: underflow; use-after-free.
[ 1946.298164] Modules linked in: usb_f_ncm(E) u_ether(E) usb_f_fs(E) hci_uart(E) btqca(E) btrtl(E) btbcm(E) btintel(E) bluetooth(E) nls_ascii(E) nls_cp437(E) vfat(E) fat(E) bcm2835_v4l2(CE) bcm2835_mmal_vchiq(CE) videobuf2_vmalloc(E) videobuf2_memops(E) sha512_generic(E) videobuf2_v4l2(E) sha512_arm(E) videobuf2_common(E) videodev(E) cpufreq_dt(E) snd_bcm2835(CE) brcmfmac(E) mc(E) vc4(E) ctr(E) brcmutil(E) snd_soc_core(E) snd_pcm_dmaengine(E) drbg(E) snd_pcm(E) snd_timer(E) snd(E) soundcore(E) drm_kms_helper(E) cec(E) ansi_cprng(E) rc_core(E) syscopyarea(E) raspberrypi_cpufreq(E) sysfillrect(E) sysimgblt(E) cfg80211(E) max17040_battery(OE) raspberrypi_hwmon(E) fb_sys_fops(E) regmap_i2c(E) ecdh_generic(E) rfkill(E) ecc(E) bcm2835_rng(E) rng_core(E) vchiq(CE) leds_gpio(E) libcomposite(E) fuse(E) configfs(E) ip_tables(E) x_tables(E) autofs4(E) ext4(E) crc16(E) mbcache(E) jbd2(E) crc32c_generic(E) sdhci_iproc(E) sdhci_pltfm(E) sdhci(E)
[ 1946.399633] CPU: 0 PID: 431 Comm: smartcard-openp Tainted: G         C OE     5.15.0-1-rpi #1  Debian 5.15.3-1
[ 1946.417950] Hardware name: BCM2835
[ 1946.425442] Backtrace:
[ 1946.432048] [<c08d60a0>] (dump_backtrace) from [<c08d62ec>] (show_stack+0x20/0x24)
[ 1946.448226]  r7:00000009 r6:0000001c r5:c04a948c r4:c0a64e2c
[ 1946.458412] [<c08d62cc>] (show_stack) from [<c08d9ae0>] (dump_stack+0x28/0x30)
[ 1946.470380] [<c08d9ab8>] (dump_stack) from [<c0123500>] (__warn+0xe8/0x154)
[ 1946.482067]  r5:c04a948c r4:c0a71dc8
[ 1946.490184] [<c0123418>] (__warn) from [<c08d6948>] (warn_slowpath_fmt+0xa0/0xe4)
[ 1946.506758]  r7:00000009 r6:0000001c r5:c0a71dc8 r4:c0a71e04
[ 1946.517070] [<c08d68ac>] (warn_slowpath_fmt) from [<c04a948c>] (refcount_warn_saturate+0x110/0x15c)
[ 1946.535309]  r8:c0100224 r7:c0dfcb84 r6:ffffffff r5:c3b84c00 r4:c24a17c0
[ 1946.546708] [<c04a937c>] (refcount_warn_saturate) from [<c0380134>] (eventfd_ctx_put+0x48/0x74)
[ 1946.564476] [<c03800ec>] (eventfd_ctx_put) from [<bf5464e8>] (ffs_data_clear+0xd0/0x118 [usb_f_fs])
[ 1946.582664]  r5:c3b84c00 r4:c2695b00
[ 1946.590668] [<bf546418>] (ffs_data_clear [usb_f_fs]) from [<bf547cc0>] (ffs_data_closed+0x9c/0x150 [usb_f_fs])
[ 1946.609608]  r5:bf54d014 r4:c2695b00
[ 1946.617522] [<bf547c24>] (ffs_data_closed [usb_f_fs]) from [<bf547da0>] (ffs_fs_kill_sb+0x2c/0x30 [usb_f_fs])
[ 1946.636217]  r7:c0dfcb84 r6:c3a12260 r5:bf54d014 r4:c229f000
[ 1946.646273] [<bf547d74>] (ffs_fs_kill_sb [usb_f_fs]) from [<c0326d50>] (deactivate_locked_super+0x54/0x9c)
[ 1946.664893]  r5:bf54d014 r4:c229f000
[ 1946.672921] [<c0326cfc>] (deactivate_locked_super) from [<c0326df8>] (deactivate_super+0x60/0x64)
[ 1946.690722]  r5:c2a09000 r4:c229f000
[ 1946.698706] [<c0326d98>] (deactivate_super) from [<c0349a28>] (cleanup_mnt+0xe4/0x14c)
[ 1946.715553]  r5:c2a09000 r4:00000000
[ 1946.723528] [<c0349944>] (cleanup_mnt) from [<c0349b08>] (__cleanup_mnt+0x1c/0x20)
[ 1946.739922]  r7:c0dfcb84 r6:c3a12260 r5:c3a126fc r4:00000000
[ 1946.750088] [<c0349aec>] (__cleanup_mnt) from [<c0143d10>] (task_work_run+0x84/0xb8)
[ 1946.766602] [<c0143c8c>] (task_work_run) from [<c010bdc8>] (do_work_pending+0x470/0x56c)
[ 1946.783540]  r7:5ac3c35a r6:c0d0424c r5:c200bfb0 r4:c200a000
[ 1946.793614] [<c010b958>] (do_work_pending) from [<c01000c0>] (slow_work_pending+0xc/0x20)
[ 1946.810553] Exception stack(0xc200bfb0 to 0xc200bff8)
[ 1946.820129] bfa0:                                     00000000 00000000 000000aa b5e21430
[ 1946.837104] bfc0: bef867a0 00000001 bef86840 00000034 bef86838 bef86790 bef86794 bef867a0
[ 1946.854125] bfe0: 00000000 bef86798 b67b7a1c b6d626a4 60000010 b5a23760
[ 1946.865335]  r10:00000000 r9:c200a000 r8:c0100224 r7:00000034 r6:bef86840 r5:00000001
[ 1946.881914]  r4:bef867a0
[ 1946.888793] ---[ end trace 7387f2a9725b28d0 ]---

Fixes: 5e33f6fdf735 ("usb: gadget: ffs: add eventfd notification about ffs events")
Signed-off-by: Vincent Pelletier <plr.vincent@gmail.com>

---
Changes since v1:
- moved assignment from ffs_data_reset to ffs_data_clear
- moved epfiles assignment from ffs_data_reset to ffs_data_clear
- added "Fixes", but did not CC Robert Baldyga as their email address
  bounces
---
 drivers/usb/gadget/function/f_fs.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/usb/gadget/function/f_fs.c b/drivers/usb/gadget/function/f_fs.c
index e20c19a0f106..a7e069b18544 100644
--- a/drivers/usb/gadget/function/f_fs.c
+++ b/drivers/usb/gadget/function/f_fs.c
@@ -1773,11 +1773,15 @@ static void ffs_data_clear(struct ffs_data *ffs)
 
 	BUG_ON(ffs->gadget);
 
-	if (ffs->epfiles)
+	if (ffs->epfiles) {
 		ffs_epfiles_destroy(ffs->epfiles, ffs->eps_count);
+		ffs->epfiles = NULL;
+	}
 
-	if (ffs->ffs_eventfd)
+	if (ffs->ffs_eventfd) {
 		eventfd_ctx_put(ffs->ffs_eventfd);
+		ffs->ffs_eventfd = NULL;
+	}
 
 	kfree(ffs->raw_descs_data);
 	kfree(ffs->raw_strings);
@@ -1790,7 +1794,6 @@ static void ffs_data_reset(struct ffs_data *ffs)
 
 	ffs_data_clear(ffs);
 
-	ffs->epfiles = NULL;
 	ffs->raw_descs_data = NULL;
 	ffs->raw_descs = NULL;
 	ffs->raw_strings = NULL;
-- 
2.34.0

