Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1EF91586392
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Aug 2022 06:35:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239434AbiHAEf2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Aug 2022 00:35:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238580AbiHAEfX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Aug 2022 00:35:23 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04B736372;
        Sun, 31 Jul 2022 21:35:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1659328514;
        bh=S/P/oJi+HDi2Ki9y66Mg4i/0i6XEUUjcEs7pNllRhCk=;
        h=X-UI-Sender-Class:Date:From:To:Cc:Subject:References:In-Reply-To;
        b=JPsC9+8hY3tM8hmwXukacDoFoEP7gzxrYEtY2CQen4d3EdAXOVX8BrTMHziELDiO9
         ZoA16TAbE1jo2ZkMX9pIIsEuRymXi0rMf85Q1HLVefs3JKWWQVZmY7oHdsBmfAQ2VX
         SrjhZe7TaqmIEQaR7AVaM5xzVej1phCEPkst0X9E=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from ls3530 ([92.116.150.19]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MwQXH-1nQH9r1T1R-00sMkY; Mon, 01
 Aug 2022 06:35:14 +0200
Date:   Mon, 1 Aug 2022 06:34:26 +0200
From:   Helge Deller <deller@gmx.de>
To:     Zheyu Ma <zheyuma97@gmail.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Helge Deller <deller@gmx.de>,
        Linux Fbdev development list <linux-fbdev@vger.kernel.org>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [BUG] video: fbdev: arkfb: Found a divide-by-zero bug which may
 cause DoS
Message-ID: <YudX0t/P94a0LKtr@ls3530>
References: <CAMhUBjkps_2EAkbCpGuLiWVFObLkLuj=3UqbxcuENUNXMkbS9Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMhUBjkps_2EAkbCpGuLiWVFObLkLuj=3UqbxcuENUNXMkbS9Q@mail.gmail.com>
X-Provags-ID: V03:K1:yUB3w75aSGm2mOn7ZhOy/2gxfdGzu5mErxKQlgmB5aiqpnpRB5p
 4l5MRF3xIsLdz+h/weJLLMHMHvOT1cmfskgVY6iW5hXzZvF7htka+V3T5/BdenwLtQmwO2+
 mlFYIiH2ap3WGw7UYK6SlhJoGNDqmmAwbCoxfI7KwT+L1TYJXjpQE+dRwietqyk0XZL1VQF
 JLNdi5Tft5rtvM3w9wZWg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:IJ/efF9VVnE=:EDGZxZFr90uVcWBRz2orbz
 54IyND+N+1epoY8rd9cGhwwMPmHqHM568b9m2l7YqiCO88gE2ItpR12I8kLQ0AErDm0ZHJJlv
 8LyjHlO9/lbvwOYW0+4xMPKsHXO6XzI88Ui5zi/XLQlavcQ7fHozhot3zWmWMOeMjWgWzdvcN
 43uNGpi1eg9N2ciLkMkt06j6lO1YDjQG6J3q1uq/OScQRuhcukdXIu8Hw/66UxWaFpCfVbdgC
 3MSpoSkWEWDbo2h4pgyntlbYbab857HJkXuHhLR1Hya9sHrDK/yRiap+C6yOmxsX50r4N7kpw
 5baGC1LtXLEaB1uwo2zEIgIyAx6PsmbdsB4/8EeL2q0mEPVzt9agkNFnTtOO//WI7MGg6Aqql
 veEXR5zpSrbhJBli5WnECGzaEz+Xc4uqu+UXCTNEqaAuXobL4v+IqwooOSASm5qpaqNHEYnTw
 nDvfHT0oc9btsiz4nsEoOkuafKJVez2OQsd3AP0hC3zsjRC3QlK6C2/pg1cAY+f3YOmL/xnq3
 lT+u6lQfRtPgOjYHogDrVO5Wkdv0NOUgnPGAhLkCS7rH6qWRiPyHu1brZS8tnyHyTw/QJkWzG
 198EugQZBuCEYE6TaKUwFVASPQtk1bi9DF2+p+sO1DgBn3uu7cTggfRfBzUS3jLY4Opb8Whrv
 aj4tnlR9RIPESuobMi3R8E7OUdSRVZLv8dZgxNy7wi+GL+k63vyZq5oVb4EK/Np37yugS7YaL
 pKK6JxwoG00KlnNwju2FFbRUmN7H3CkjwOj+8QYA4/On5RZNr4Kc7kKBJoOHcGieivmHWQmbj
 PfWcDDhBrQx2Yp92vrEAQngj4lMQ2boFkGrZho9tw+nCj+j3AjBP/YfOQ29KYD7JXyZATMt4C
 ATwWPxEX59cZOsMOFsYv5zbUrktwYhXpMN6aOz/u8jz87VYoBjryrNj7lYi0TJ7D8soVE43JO
 5g7jK0JYmLmcnRqcuXiQzIA6tuajbRYdpJGlXTS1muleKJSa2E0hyq/hvz7e8NAYIkWHOiHWT
 hRFEb/kZvYRO/l8n8kT5ICa/q4GPzjzwrYIFHkzmffEEst/9GvtmyLdIBziyA51XGKK+DJHvM
 y5rN/1GX3Z7rkLa28H3ADkzzwKNmdOZLj8/BYW6v8NxQ1nhcsw8z2TdpQ==
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Zheyu Ma <zheyuma97@gmail.com>:
> I found a bug in the arkfb driver in the latest kernel, which may cause =
DoS.
>
> The reason for this bug is that the user controls some input to ioctl,
> making 'mode' 0x7 on line 704, which causes hdiv =3D 1, hmul =3D 2, and =
if
> the pixclock is controlled to be 1, it will cause a division error in
> the function ark_set_pixclock().

You are right.
I see in:
  drivers/video/fbdev/arkfb.c:784: ark_set_pixclock(info, (hdiv * info->va=
r.pixclock) / hmul);
with hdiv=3D1, pixclock=3D1 and hmul=3D2 you end up with (1*1)/2 =3D (int)=
 0.
and then in
  drivers/video/fbdev/arkfb.c:504: rv =3D dac_set_freq(par->dac, 0, 100000=
0000 / pixclock);
you'll get a division-by-zero.

> The easiest patch is to check the value of the argument 'pixclock' in
> the ark_set_pixclock function, but this is perhaps too late, should we
> do this check earlier? I'm not sure, so I'll report this bug to you.

Yes, I think it should be done earlier.

Geert always mentioned that an invalid pixclock from userspace should be
rounded up to the next valid pixclock.
But since I don't have that hardware, I'm not sure how this can be done
best for this driver.

Do you have the hardware to test?
If so, could you check the patch below?
It should at least prevent the division-by-zero.
If it works, I'm happy if you could send a final patch...

Helge

diff --git a/drivers/video/fbdev/arkfb.c b/drivers/video/fbdev/arkfb.c
index eb3e47c58c5f..ed76ddc7df3d 100644
=2D-- a/drivers/video/fbdev/arkfb.c
+++ b/drivers/video/fbdev/arkfb.c
@@ -781,7 +781,12 @@ static int arkfb_set_par(struct fb_info *info)
 		return -EINVAL;
 	}

-	ark_set_pixclock(info, (hdiv * info->var.pixclock) / hmul);
+	value =3D (hdiv * info->var.pixclock) / hmul;
+	if (!value) {
+		fb_dbg(info, "invalid pixclock\n");
+		value =3D 1;
+	}
+	ark_set_pixclock(info, value);
 	svga_set_timings(par->state.vgabase, &ark_timing_regs, &(info->var), hmu=
l, hdiv,
 			 (info->var.vmode & FB_VMODE_DOUBLE)     ? 2 : 1,
 			 (info->var.vmode & FB_VMODE_INTERLACED) ? 2 : 1,
