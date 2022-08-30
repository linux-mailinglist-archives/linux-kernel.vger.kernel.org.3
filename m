Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 494F95A58D8
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 03:12:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229796AbiH3BLf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Aug 2022 21:11:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229564AbiH3BLd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Aug 2022 21:11:33 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8986882FB8;
        Mon, 29 Aug 2022 18:11:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1661821870;
        bh=sqXP0v6Z96JElGFIbYl2yYTdi9tNspPEckmIFuQDY58=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
        b=NVGUNDKzkP962XNPO30JmvIv6J7+tSOiO+1UnxqPbpZ2UsbSyGAUbLshum+D7vepE
         Bj8QKjEM7HZN52lM96cXChY2DjzemvqOvjZiipfWYFBXvb1007e0odl5e3d4dFvybi
         nkelW2l0tHFa8GDbnRb54xJftd2ozUwKCktRnZ+4=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from esprimo-mx.fritz.box ([141.30.226.119]) by mail.gmx.net
 (mrgmx105 [212.227.17.168]) with ESMTPSA (Nemesis) id
 1MFKGP-1odY5H1Evx-00FiSL; Tue, 30 Aug 2022 03:11:10 +0200
From:   Armin Wolf <W_Armin@gmx.de>
To:     jdelvare@suse.com, linux@roeck-us.net
Cc:     linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] hwmon: (gpio-fan) Fix array out of bounds access
Date:   Tue, 30 Aug 2022 03:11:01 +0200
Message-Id: <20220830011101.178843-1-W_Armin@gmx.de>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:7okLH/Ptl2wvo41H2lbx/E8akG/raigpW9ja3Ng9TZxc6ocOr+7
 q1BHrgalZ1WpM8iiax9yBcMSl02W8LhyuJ72CN5wQRA1XGViJgOFfki82LzYmC9NZ+ZXu4/
 dvTL6/X+r3/mZZOOZQGFbi5S54IJL1u6wKXu9XdalSU0hx3HOLYDPxUqLyZqhdH1nOHfhO/
 3cugGCHf/C+cO/vifyY8w==
X-UI-Out-Filterresults: notjunk:1;V03:K0:ArYh0+K39Xk=:76yMYR7rG6u+TVyUB8VWW9
 7ncjV/+aWDUtiy+ByRK096uCXkJWGkZYMBaCE4G7Xpx9KUGcYstgz3oecTFIjcwlZnlV+4g1N
 8hKSOsz8r1/FcJkcql77xooshFoS67XpIjbrMyRiutZxpWwx/r7jtf8lhKTGlj2PodTV0A+VY
 LSutMA3eGyx5td+yBECynl8UDQsBGb7NpJYdrB3KJsg9HrTUw8yGw1jwbyEev3AfZ4uIqksR9
 DksyCviTWLlRBbXP81fm8tf4OTZBL4mThMQRJtBTFYM1EonT/VBGxMbP9dsR4uyarc6u156wc
 NeCqLtOgxTFROoAio0KL2CQy3OO/hE3ZnML4lm/SgFwO0EpdWJkc3kkxoN2WgcilurQPxLP3f
 9zRh3gocrKvnQ8HIxs+CWdqgxUq/wvvxvzZcuVq7fx5hFekxtYYCDLSKZr0DRrDHPIkhObn+n
 ljfU82vjkSJJCWQ9RSM81XbgGr8aFvwm9xCGNSkSl/kAMzJJxpAGfLOltGHjtDLr5g+nNm/7z
 rARg0iGrg19rhKl4h7I86TUxzevtOqKijn4ebiJJsWCV1dQlLsVhf1Rf1qZccSn27J0oysJ8n
 LafxoTymTYzM+/YgK0cRoFdCJQlhylmzkDSCTpZSHeQHbBOz4Yeujv/ozMFPQsCE5yqIP/864
 6rSzgHkI+KLL/dCs6oH3ApHb/iaZ/SadpCGb4H162N02JDwhjQs5Q3KfBfusk9h0Dadgtalfr
 f1eM4ltTqOkHRO7Z2dAWHBPwILMei2EUHUOJ8JBZXLXGsrdzts/Wx61LjmxzRVdGZtGS3zKGk
 /iJ7e2B3tDlLHikPG5VZcNHa56HDgr+VYZKnD05SeNNL5ds7FnWcfHkjDJjUmchaho0rtKnLh
 uJ9aEc4M1A5VaJJbRKL6y9JVNEBpTz4dF/+PKPRTo7Foy6V/gVblxeKR+Is/9dTdUukKTUi2n
 AfYf1uCqkCf1IKzJ0j/n7TQ4PiXd5I1RwTuyFukuauUwPoXjhmM8g33Hp8QugnoWnryrXAXlQ
 b9HMAeaSx37MxPIZWkFjlleArXrMg13kjvEQ1pfjnTy4P3+rSPh8Tui2N4q6xTxCLweD3sJKH
 R+1S0QHUXopRxNaZjPUWx1pH1DCTEwwU6Zag8XKqniUpLixs2dVbkpYPg==
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The driver does not check if the cooling state passed to
gpio_fan_set_cur_state() exceeds the maximum cooling state as
stored in fan_data->num_speeds. Since the cooling state is later
used as an array index in set_fan_speed(), an array out of bounds
access can occur.
This can be exploited by setting the state of the thermal cooling device
to arbitrary values, causing for example a kernel oops when unavailable
memory is accessed this way.

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

Fix this by checking the cooling state and return an error if it
exceeds the maximum cooling state.

Tested on a Raspberry Pi 3.

Fixes: b5cf88e46bad ("(gpio-fan): Add thermal control hooks")
Signed-off-by: Armin Wolf <W_Armin@gmx.de>
=2D--
Changes in v2:
- move check to gpio_fan_set_cur_state()
- reword commit message
=2D--
 drivers/hwmon/gpio-fan.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/hwmon/gpio-fan.c b/drivers/hwmon/gpio-fan.c
index befe989ca7b9..fbf3f5a4ecb6 100644
=2D-- a/drivers/hwmon/gpio-fan.c
+++ b/drivers/hwmon/gpio-fan.c
@@ -391,6 +391,9 @@ static int gpio_fan_set_cur_state(struct thermal_cooli=
ng_device *cdev,
 	if (!fan_data)
 		return -EINVAL;

+	if (state >=3D fan_data->num_speed)
+		return -EINVAL;
+
 	set_fan_speed(fan_data, state);
 	return 0;
 }
=2D-
2.30.2

