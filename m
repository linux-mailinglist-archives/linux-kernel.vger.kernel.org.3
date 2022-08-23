Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA6C759EC52
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Aug 2022 21:31:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231592AbiHWTaM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Aug 2022 15:30:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231877AbiHWT3y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Aug 2022 15:29:54 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 417FF396;
        Tue, 23 Aug 2022 11:18:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1661278671;
        bh=MqkG7FvKa/Y0ge/2gjNlCceo9f+qY9FbpVc/If9+cqU=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
        b=IXS6s4MD5CojzSwSz1ijJfmLhypeTsudNj/8ESO3fIsCf3BSQf41prxMoq6nyH5cG
         MWJymrSSzFx7M4QpgNzfrTkTZZNfYfIWW3BkMhR6GpW7ONJPegcCRcggGz6/BxI7wY
         hEbjwAWx/0EzB34H0ljsFPfbpsX8mxoH6EsnxOGQ=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from esprimo-mx.users.agdsn.de ([141.30.226.129]) by mail.gmx.net
 (mrgmx005 [212.227.17.190]) with ESMTPSA (Nemesis) id
 1MEV3I-1ogVz30y1C-00FzL9; Tue, 23 Aug 2022 20:17:51 +0200
From:   Armin Wolf <W_Armin@gmx.de>
To:     jdelvare@suse.com, linux@roeck-us.net
Cc:     linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] hwmon: (gpio-fan) Fix array out of bounds access
Date:   Tue, 23 Aug 2022 20:17:42 +0200
Message-Id: <20220823181742.5793-1-W_Armin@gmx.de>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:8PfkXy7Cie+0s0eZmsqd0RHmUKSw58VqNqm7ATz5/dKg8btZZo+
 nxxNOgRXH6X6GAgVvG2l//PmlE0lYnbhc/Lsi2l8sV9K0zxO4x6OKHJ6wg88eQCkIyArzLI
 JS/EA2aUfZqxpqVIjcmLO3Xa9cI5g9TfXdDEGYn3LmTox0Qcu1II/zxPUg+5qPSGmXYqTwh
 AWRhf4CC/+QIg+pJfeZ3Q==
X-UI-Out-Filterresults: notjunk:1;V03:K0:/KCB1qO42BY=:VL4iQAlD8Ta8nbZcWU5SAX
 RG2rqqG+nGmqZpEpysrmhMw7ifi3Xy2pzmZ+xkXzFEAhoTcfwZ+3nmc+DPhnxXLWGCbnVk3ar
 zW8beX/8D36FWmd9Z5tu+rA+ld1uUU99SUBO8vV5NTLbXTXir5nT4rip7RF6IF1jzvpFdgfAd
 itCscWPdLwjoL5n/M/0UWSUzNkBvFWs7XUt/PHtNgYgBCgFE74H8uazYQ1VIQlE7QVIdLecyQ
 wS45aYFfHduQQPmR0FytSwfOxUTfXfDkU/aAD4S7/V7GLH/68yEw0Uc+ZwWQZfr/Ebf4jGj56
 hJIZfJU67w3zAUUx2FZnUVmnY47CJ+ED58sOYSTA/zLyXPbtmpmaZm1v9NzrXzsxgHAO+x+ZJ
 MA2d35Lp3kiRldLcHavJOVGq/Zaiv8xhX1laVentc6mDcSYLpeXLhGSYEKtZkHbAJhroRf0PQ
 1Mps2rk1jpSkcwVWsAdH4/C+WaWc4dMp8aOBkihr+wCRXyrKxowKaeKkjZYBdb9+sbrgU4Pvu
 xw+kGSYamj5Gszq/R5lHeDlZKKXJ7T5eAAmPr8C++PvPo2nR/hrPMoTWdEPfSpjwehVaYIuA/
 HbSsRfSGeVuc+0VlzHcOt5KvMIfo+SXwseD/hdR4cr5tYXaT4qlsuEsHVqtqY3vWzqL/wcpdI
 qQn8k2+ajKNB4wrhtM42/cUIvjLTbqhtxVoEa1E40tZbLwmbZr0stDNGtvdDVC+4X1eaFNFat
 QrXaFQh510aewR+SKvFhCDFwL84ghgShh/UaJ/G2wv+MUCQ1pHpGP8UWXxfG+zgTf/UmSURpe
 TH6CSt9cSUB3RzmPaAPmMWgwVeYOH8m16eqxB4BSzZ61s4eE0QHVkRG5sxF4YZmpx5M4WRjcp
 dHhASgXvBDHrO+9e1feODOF1YgIGwhsUiONVdkjgGSkL6SlF37kL7J6dT0zXFcSs42d/8bdIb
 jo5j86akwMKbCT8iGmMsLdAA4+Exf8xFG+SrrwLpSrQRymFcLOKYPWMNDf0PfaTGL49DLFplS
 RtJdPhSEl9xbakI6R+rPj0Wc+vdcNlDLiH+i8TIXHOZ+R9PP/PVjj50ExfYcnTdbT/122EKwG
 BgqODEKyd8/VUilvwcrVSzaudCMTdYf4itNmOpC4mwou1MP1itN1H2ThA==
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When set_fan_speed() is called with speed_index being
greater than num_speed or less than 0, an array out of bounds
access occurs. This can be exploited by setting the state of
the thermal cooling device to arbitrary values, causing for example
a kernel oops when unavailable memory is accessed this way.

Example kernel oops:
[  807.987276] Unable to handle kernel paging request at virtual address f=
fffff80d0588064
[  807.987369] Mem abort info:
[  807.987398]   ESR =3D 0x96000005
[  807.987428]   EC =3D 0x25: DABT (current EL), IL =3D 32 bits
[  807.987477]   SET =3D 0, FnV =3D 0
[  807.987507]   EA =3D 0, S1PTW =3D 0
[  807.987536]   FSC =3D 0x05: level 1 translation fault
[  807.987570] Data abort info:
[  807.987763]   ISV =3D 0, ISS =3D 0x00000005
[  807.987801]   CM =3D 0, WnR =3D 0
[  807.987832] swapper pgtable: 4k pages, 39-bit VAs, pgdp=3D0000000001165=
000
[  807.987872] [ffffff80d0588064] pgd=3D0000000000000000, p4d=3D0000000000=
000000, pud=3D0000000000000000
[  807.987961] Internal error: Oops: 96000005 [#1] PREEMPT SMP
[  807.987992] Modules linked in: cmac algif_hash aes_arm64 algif_skcipher=
 af_alg bnep hci_uart btbcm bluetooth ecdh_generic ecc 8021q garp stp llc =
snd_soc_hdmi_codec brcmfmac vc4 brcmutil cec drm_kms_helper snd_soc_core c=
fg80211 snd_compress bcm2835_codec(C) snd_pcm_dmaengine syscopyarea bcm283=
5_isp(C) bcm2835_v4l2(C) sysfillrect v4l2_mem2mem bcm2835_mmal_vchiq(C) ra=
spberrypi_hwmon sysimgblt videobuf2_dma_contig videobuf2_vmalloc fb_sys_fo=
ps videobuf2_memops rfkill videobuf2_v4l2 videobuf2_common i2c_bcm2835 snd=
_bcm2835(C) videodev snd_pcm snd_timer snd mc vc_sm_cma(C) gpio_fan uio_pd=
rv_genirq uio drm fuse drm_panel_orientation_quirks backlight ip_tables x_=
tables ipv6
[  807.988508] CPU: 0 PID: 1321 Comm: bash Tainted: G         C        5.1=
5.56-v8+ #1575
[  807.988548] Hardware name: Raspberry Pi 3 Model B Rev 1.2 (DT)
[  807.988574] pstate: 20000005 (nzCv daif -PAN -UAO -TCO -DIT -SSBS BTYPE=
=3D--)
[  807.988608] pc : set_fan_speed.part.5+0x34/0x80 [gpio_fan]
[  807.988654] lr : gpio_fan_set_cur_state+0x34/0x50 [gpio_fan]
[  807.988691] sp : ffffffc008cf3bd0
[  807.988710] x29: ffffffc008cf3bd0 x28: ffffff80019edac0 x27: 0000000000=
000000
[  807.988762] x26: 0000000000000000 x25: 0000000000000000 x24: ffffff8007=
47c920
[  807.988787] x23: 000000000000000a x22: ffffff800369f000 x21: 0000000019=
99997c
[  807.988854] x20: ffffff800369f2e8 x19: ffffff8002ae8080 x18: 0000000000=
000000
[  807.988877] x17: 0000000000000000 x16: 0000000000000000 x15: 000000559e=
271b70
[  807.988938] x14: 0000000000000000 x13: 0000000000000000 x12: 0000000000=
000000
[  807.988960] x11: 0000000000000000 x10: ffffffc008cf3c20 x9 : ffffffcfb6=
0c741c
[  807.989018] x8 : 000000000000000a x7 : 00000000ffffffc9 x6 : 0000000000=
000009
[  807.989040] x5 : 000000000000002a x4 : 0000000000000000 x3 : ffffff8003=
69f2e8
[  807.989062] x2 : 000000000000e780 x1 : 0000000000000001 x0 : ffffff80d0=
588060
[  807.989084] Call trace:
[  807.989091]  set_fan_speed.part.5+0x34/0x80 [gpio_fan]
[  807.989113]  gpio_fan_set_cur_state+0x34/0x50 [gpio_fan]
[  807.989199]  cur_state_store+0x84/0xd0
[  807.989221]  dev_attr_store+0x20/0x38
[  807.989262]  sysfs_kf_write+0x4c/0x60
[  807.989282]  kernfs_fop_write_iter+0x130/0x1c0
[  807.989298]  new_sync_write+0x10c/0x190
[  807.989315]  vfs_write+0x254/0x378
[  807.989362]  ksys_write+0x70/0xf8
[  807.989379]  __arm64_sys_write+0x24/0x30
[  807.989424]  invoke_syscall+0x4c/0x110
[  807.989442]  el0_svc_common.constprop.3+0xfc/0x120
[  807.989458]  do_el0_svc+0x2c/0x90
[  807.989473]  el0_svc+0x24/0x60
[  807.989544]  el0t_64_sync_handler+0x90/0xb8
[  807.989558]  el0t_64_sync+0x1a0/0x1a4
[  807.989579] Code: b9403801 f9402800 7100003f 8b35cc00 (b9400416)
[  807.989627] ---[ end trace 8ded4c918658445b ]---

Fix this by checking speed_index and return if it is out of bounds.

Tested on a Raspberry Pi 3.

Fixes: d6fe1360f42e ("hwmon: add generic GPIO fan driver")
Signed-off-by: Armin Wolf <W_Armin@gmx.de>
=2D--
 drivers/hwmon/gpio-fan.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/hwmon/gpio-fan.c b/drivers/hwmon/gpio-fan.c
index befe989ca7b9..1d6facee44e0 100644
=2D-- a/drivers/hwmon/gpio-fan.c
+++ b/drivers/hwmon/gpio-fan.c
@@ -128,6 +128,9 @@ static int __get_fan_ctrl(struct gpio_fan_data *fan_da=
ta)
 /* Must be called with fan_data->lock held, except during initialization.=
 */
 static void set_fan_speed(struct gpio_fan_data *fan_data, int speed_index=
)
 {
+	if (speed_index >=3D fan_data->num_speed || speed_index < 0)
+		return;
+
 	if (fan_data->speed_index =3D=3D speed_index)
 		return;

=2D-
2.30.2

