Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D2DE55D1EE
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:10:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239806AbiF0RJG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jun 2022 13:09:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239784AbiF0RIz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 13:08:55 -0400
Received: from beige.elm.relay.mailchannels.net (beige.elm.relay.mailchannels.net [23.83.212.16])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB2CA14D26;
        Mon, 27 Jun 2022 10:08:52 -0700 (PDT)
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id E0F4E8E22A7;
        Mon, 27 Jun 2022 17:08:51 +0000 (UTC)
Received: from pdx1-sub0-mail-a264.dreamhost.com (unknown [127.0.0.6])
        (Authenticated sender: dreamhost)
        by relay.mailchannels.net (Postfix) with ESMTPA id CA2208E2337;
        Mon, 27 Jun 2022 17:08:45 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1656349731; a=rsa-sha256;
        cv=none;
        b=dSRKaH/VBsuIR/EKNCYc3/LOlXwbBYNbowhQjlqwKwtxh+4p4rLUnjNg+E/+e/29VbJfdH
        dWjDaGAyc35RhSB8aS3DRV5mlMalPyoZloTU0frGWcYYhlx/6DLy7qb/R8/VNrRyqvTw3Y
        3Dm9iXGopKgWdxstd/fQM8fh+IJ3gtAMa1HOgctqgoNEoiD4bbCJhPqkhLhVzp2mHFRWvO
        8vU/6ZcNytOxxJsV+wIRuUb1DA4u2wBgEYW+uJKZ13S1OKaHB4vY7INS9AXgWzOHCtvHJW
        cdlCjMe8BI9oplNnHmkC0qUgOje8PQfylrdjV/Ul+pfG7YZ71JsNcRRVtGmiKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
        s=arc-2022; t=1656349731;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references:dkim-signature;
        bh=A7rki0r08AUT6i9LuNpWaBSxJsAW+yxPZqeTseOKr+4=;
        b=dCnkX5l/x5H/D37l8ajU6rkF0/GfQJBNLcM9sBoZ5mdNwYJCW0gij4FlKCHyvgRY+McMwf
        /2FtvNWpKN0n53JINSt4yvHGRLfWckQGXuDVDzt0UkTjQtJHjzXDP8mPuOFTv+2oXozhPb
        kadqX6BV5O+1248qjJCOy8NJiCEeIKt1UM2YpPwbeQKY0TQ3bgtxZN4U65/ow4/hy1zQE/
        Zw8/1HjpXgKHGLJViz/Ir9HceevuTVvIiVA8hAfmVnn2xbkjGA+/8aYwncCVuDbvD6SeO0
        fg7V6cMv+Gv/lAO9wtWyranOfKqPF4T+rM9QdLDhBfZnETXLaYawg9S3YGb7Og==
ARC-Authentication-Results: i=1;
        rspamd-689699966c-64ltc;
        auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Tank-Glossy: 6a948fd5697b681b_1656349731544_2004021686
X-MC-Loop-Signature: 1656349731544:1516900649
X-MC-Ingress-Time: 1656349731543
Received: from pdx1-sub0-mail-a264.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
        by 100.98.242.248 (trex/6.7.1);
        Mon, 27 Jun 2022 17:08:51 +0000
Received: from offworld (unknown [104.36.31.105])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: dave@stgolabs.net)
        by pdx1-sub0-mail-a264.dreamhost.com (Postfix) with ESMTPSA id 4LWvMF0fxgz1HG;
        Mon, 27 Jun 2022 10:08:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
        s=dreamhost; t=1656349721;
        bh=A7rki0r08AUT6i9LuNpWaBSxJsAW+yxPZqeTseOKr+4=;
        h=Date:From:To:Cc:Subject:Content-Type:Content-Transfer-Encoding;
        b=ldvzY8nksHVe2/GUGV428zwNVO5iNGArcT7KFGpIylrjHs3uaS8wGc9m/QWmBbfbG
         u1TynMspXB0zToXWkZ0JkP65qx77V3h24FBBnlmI7A6i/QlflmXLFsELbjORuuAFez
         CTMiDaEkcCkXxbhzO6fdv6p/JjG5lSMpijlaymqjg4HtIUCZChrk7HphLvbF59zORy
         NPGjKCYJqkR/aGvC1JbzE/AHvL+bUkNebNkmSpa3h/FQL4LDUS9vNZSsXpOSnpuvTx
         AH5cInpT4D7gBGzr4GfRs8enaNidCDZCZu4BAi+e3PWLftC5qupr2Cy62XjuGEgFf6
         PllX0X13QMiqQ==
Date:   Mon, 27 Jun 2022 10:08:38 -0700
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     syzbot <syzbot+ce3408364c4a234dd90c@syzkaller.appspotmail.com>
Cc:     aldas60@gmail.com, gregkh@linuxfoundation.org,
        keescook@chromium.org, linux-kernel@vger.kernel.org,
        linux-staging@lists.linux.dev, linux-usb@vger.kernel.org,
        nathan@kernel.org, syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] WARNING: locking bug in hfa384x_usbctlx_completion_task
Message-ID: <20220627170838.y7kbvazgpd52xd6d@offworld>
References: <000000000000e3fc8905e2608d4f@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <000000000000e3fc8905e2608d4f@google.com>
User-Agent: NeoMutt/20220429
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It's nice to see this sort of stuff actually tested :)

On Sun, 26 Jun 2022, syzbot wrote:

>------------[ cut here ]------------
>DEBUG_LOCKS_WARN_ON(1)
>WARNING: CPU: 1 PID: 21 at kernel/locking/lockdep.c:231 hlock_class kernel=
/locking/lockdep.c:231 [inline]
>WARNING: CPU: 1 PID: 21 at kernel/locking/lockdep.c:231 hlock_class kernel=
/locking/lockdep.c:220 [inline]
>WARNING: CPU: 1 PID: 21 at kernel/locking/lockdep.c:231 check_wait_context=
 kernel/locking/lockdep.c:4727 [inline]
>WARNING: CPU: 1 PID: 21 at kernel/locking/lockdep.c:231 __lock_acquire+0x1=
356/0x5660 kernel/locking/lockdep.c:5003
>Modules linked in:
>CPU: 1 PID: 21 Comm: kworker/1:0 Not tainted 5.19.0-rc3-syzkaller-00071-g1=
05f3fd2f789 #0
>Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Go=
ogle 01/01/2011
>Workqueue: events hfa384x_usbctlx_completion_task

Sorry about that, the below should fix it. Thanks.

---8<-------------------------------
=46rom: Davidlohr Bueso <dave@stgolabs.net>
Subject: [PATCH] staging/wlan-ng: get the correct struct hfa384x in work ca=
llback

hfa384x_usbctlx_completion_task() is bogusly using the reaper BH when
in fact this is the completion_bh. This was reflected when trying
to acquire the hw->ctlxq.lock and getting a failed lockdep class
initialized to it.

Reported-by: syzbot+ce3408364c4a234dd90c@syzkaller.appspotmail.com
Fixes: 9442e81d7e7 (staging/wlan-ng, prism2usb: replace completion_bh taskl=
et with work)
Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>
---
  drivers/staging/wlan-ng/hfa384x_usb.c | 2 +-
  1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/wlan-ng/hfa384x_usb.c b/drivers/staging/wlan-n=
g/hfa384x_usb.c
index 33844526c797..02fdef7a16c8 100644
--- a/drivers/staging/wlan-ng/hfa384x_usb.c
+++ b/drivers/staging/wlan-ng/hfa384x_usb.c
@@ -2632,7 +2632,7 @@ static void hfa384x_usbctlx_reaper_task(struct work_s=
truct *work)
   */
  static void hfa384x_usbctlx_completion_task(struct work_struct *work)
  {
-	struct hfa384x *hw =3D container_of(work, struct hfa384x, reaper_bh);
+	struct hfa384x *hw =3D container_of(work, struct hfa384x, completion_bh);
	struct hfa384x_usbctlx *ctlx, *temp;
	unsigned long flags;

--
2.36.1
