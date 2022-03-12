Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 288914D7027
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Mar 2022 18:35:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232329AbiCLRgq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Mar 2022 12:36:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229491AbiCLRgo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Mar 2022 12:36:44 -0500
X-Greylist: delayed 461 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sat, 12 Mar 2022 09:35:36 PST
Received: from mout.web.de (mout.web.de [217.72.192.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 844BFB6D02;
        Sat, 12 Mar 2022 09:35:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1647106534;
        bh=6mcROxHAGXWh/FUu2BJ36fPef+LX/8PghG9Tmr0b0WA=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=THI4fGXd56x9D6r/kH4RHW1yQD7m9JX7MClRq9+MdgiB4UJc5sMGB4guoljo/un8K
         vkTWlFO4peFPhl76e0eXTw1lraR1vUmQ0WMXJzYJqJFgyQKMEh/zxgF+NN4pqq35ZZ
         LTpuRUH5R+J8Udprw7PHxXt2KDMIIaEcEZ7mICaI=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from michael.fritz.box ([87.123.244.4]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MvKbj-1oJx7T3Ill-00r8Zc; Sat, 12
 Mar 2022 18:22:42 +0100
From:   Michael Estner <michaelestner@web.de>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     kernel-janitor-commits@vger.kernel.org,
        Michael Estner <michaelestner@web.de>,
        Johan Hovold <johan@kernel.org>, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] drivers: usbtouchscreen: use kzalloc
Date:   Sat, 12 Mar 2022 18:22:30 +0100
Message-Id: <20220312172232.13146-1-michaelestner@web.de>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <Michael Estner <michaelestner@web.de>
References: <Michael Estner <michaelestner@web.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Kcj35b2wqF9YIzlfBk9rA8pn7ZwsQXyx6fMOKj+voFwJrSPXMf+
 oCo/BgVqzffb/3kZdx4T+q9r2jm/3ealX1ppRUrxtn+3wDyTriN0kIjxGVg8P2AKhYAOgrN
 JMn0t8Hcfbq/GvJhpXtAbfMpqCLCmLDGvhGlFTWS/RuQwP0jdaBQhZf76h1gf6X6zJbznB1
 qQiBEPPAyBBIYyWdEho6Q==
X-UI-Out-Filterresults: notjunk:1;V03:K0:oJwQaIhGQEE=:yhoeEclAhZSHdKBcSqmAOq
 +K82ccNLAtjdj2Y+8QKM1u53ck4VHl7Yno1i53aF55kHCjTaTLhsf2FmKbJaRbvViMQPuE7iT
 /kz+OOLAkFtT4smOwbhBe/6Zs4BZ/2+PxOrGSp/1mNlO1ODPVKIAqiK+qexSq2ypakz3bP8V7
 B3YuBTF2qjSMRdJGyEoX7Q0BAUcGWlqCdeWGDnWzeqnvYEcGutrwNQHFy2uPy7BV6fAalqt0c
 D0lQJ/GbgRFXPY+072zqf9uSZQprNAlpoiMZWmb4IHOIU6LA9k1uHTXA4C+BZPAynuJNu4jyZ
 tdOYxQnsKDGfFVLJXaz2cEwCRxvWO/DD3JVm23MTHnAXlsDpNgrE1cFCjnYQlcDdtZ7efxpip
 C0gfksJvLdzu2dJYKaZTRwnnJrwRkORFZomezsvO9SIfZrnAAgHQW0QP7Y9ul80n2eTKRDgn3
 Ox06D6AkkxpisDvJ70n+Fi76u6bTjrMZcrSHcd7dWOGc6AiR8on+gMMChQ2i6VrExApIi3oMm
 5is6iBoAgDCzISoR/l47U4/8Tzw4QQgtKXeOc8ClwAtTH6nmLehLcJdnzr52QafKZQjHw7tPE
 VdUvKGYg0Bxwu3/shxSiA/YnwJznFTgCFxgNQF2mP0GXYh4LsRmK16afCS8AI7Pu5NW34DA+f
 Te52yIpK3Z7n5hOsVMmTHscSXGz+OrWmyJoPQ8Wx94Ihg9PozOM9CvVb8tKe+VUFHkwCBkbGa
 1mYs5ZbR0O6VfQsY+iSZ22cQdToQDSGWyFSGcYX8wXoBM2ZzlkiNo2+Eq/Jkj17JMg5FtdH8B
 vBueYFtD2lnDelLCni/Z5ruYvK7HOzveGjuSZT5ck69bApP364xFeyF2mckDHJLnPm9idSAKR
 GKIoGb7msqvTtl5to0rAzJK3+hdOZqhhEF+RtK74QDsl1/YPJvvIVuLPcGrMVlMIUKKiSu69c
 DdYp0QcvYq3nFRFaO1IXYi60VlI6SbTAdY2KxT+kOJPPm+h5KfwQkUGV0qzlAwpsMg9ViHrZk
 nDDZwV4W4icymu5QR1G0/th3RPYZT/hvslBczMEtQfN3dyex7F5xBtRz+NZVc2OAnl5RIx34/
 CQatzF7vKPKbXM=
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use kzalloc instead of kmalloc + memset.

The semantic patch that makes this change is:
(https://coccinelle.gitlabpages.inria.fr/website/)

Signed-off-by: Michael Estner <michaelestner@web.de>
=2D--
 drivers/input/touchscreen/usbtouchscreen.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/input/touchscreen/usbtouchscreen.c b/drivers/input/to=
uchscreen/usbtouchscreen.c
index 43c521f50c85..159e1ac6198a 100644
=2D-- a/drivers/input/touchscreen/usbtouchscreen.c
+++ b/drivers/input/touchscreen/usbtouchscreen.c
@@ -975,7 +975,7 @@ static int nexio_init(struct usbtouch_usb *usbtouch)
 	if (!input_ep || !output_ep)
 		return -ENXIO;

-	buf =3D kmalloc(NEXIO_BUFSIZE, GFP_NOIO);
+	buf =3D kzalloc(NEXIO_BUFSIZE, GFP_NOIO);
 	if (!buf)
 		goto out_buf;

@@ -998,7 +998,6 @@ static int nexio_init(struct usbtouch_usb *usbtouch)

 	/* read replies */
 	for (i =3D 0; i < 3; i++) {
-		memset(buf, 0, NEXIO_BUFSIZE);
 		ret =3D usb_bulk_msg(dev, usb_rcvbulkpipe(dev, input_ep),
 				   buf, NEXIO_BUFSIZE, &actual_len,
 				   NEXIO_TIMEOUT);
=2D-
2.25.1

