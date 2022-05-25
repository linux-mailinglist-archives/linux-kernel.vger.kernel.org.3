Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BCB55338C9
	for <lists+linux-kernel@lfdr.de>; Wed, 25 May 2022 10:49:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235936AbiEYItl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 May 2022 04:49:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230024AbiEYItj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 May 2022 04:49:39 -0400
X-Greylist: delayed 4138 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 25 May 2022 01:49:38 PDT
Received: from gofer.mess.org (gofer.mess.org [88.97.38.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1828753B6C;
        Wed, 25 May 2022 01:49:38 -0700 (PDT)
Received: by gofer.mess.org (Postfix, from userid 1000)
        id 8478A101CCD; Wed, 25 May 2022 09:49:36 +0100 (BST)
Date:   Wed, 25 May 2022 09:49:36 +0100
From:   Sean Young <sean@mess.org>
To:     Jiri Slaby <jirislaby@kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [GIT PULL for v5.18-rc1] media updates
Message-ID: <Yo3toKslhxi24w3p@gofer.mess.org>
References: <20220322101406.459e2950@coco.lan>
 <a0470450-ecfd-2918-e04a-7b57c1fd7694@kernel.org>
 <Yo3ddVHgBBlvJEdh@gofer.mess.org>
 <8093277c-5098-e5e3-f606-486de5b2f67b@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="h3J3ZAFSc2DcqDuO"
Content-Disposition: inline
In-Reply-To: <8093277c-5098-e5e3-f606-486de5b2f67b@kernel.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--h3J3ZAFSc2DcqDuO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, May 25, 2022 at 10:09:38AM +0200, Jiri Slaby wrote:
> Be it umaintained or not, it's still in distributions (the above is from
> opensuse build system) and it is broken now. Every single distributor now
> would have to go and fix this.

I am happy to help out with this issue, since lircd upstream does not accept
patches. I've attached a patch for your perusal. 


Sean

--h3J3ZAFSc2DcqDuO
Content-Type: text/x-diff; charset=us-ascii
Content-Disposition: attachment; filename="lirc.patch"

diff --git a/daemons/lircd.cpp b/daemons/lircd.cpp
index 4cceab7e..9f4ee0cc 100644
--- a/daemons/lircd.cpp
+++ b/daemons/lircd.cpp
@@ -488,9 +488,8 @@ static int setup_hardware(void)
 
 	if (curr_driver->fd != -1 && curr_driver->drvctl_func) {
 		if ((curr_driver->features & LIRC_CAN_SET_REC_CARRIER)
-		    || (curr_driver->features & LIRC_CAN_SET_REC_TIMEOUT)
-		    || (curr_driver->features & LIRC_CAN_SET_REC_FILTER)) {
-				ret = setup_frequency() && setup_timeout();
+		    || (curr_driver->features & LIRC_CAN_SET_REC_TIMEOUT)) {
+			ret = setup_frequency() && setup_timeout();
 		}
 	}
 	return ret;
@@ -2180,13 +2177,6 @@ void loop(void)
 			const char* button_name;
 			int reps;
 
-			if (curr_driver->drvctl_func
-			    && (curr_driver->features & LIRC_CAN_NOTIFY_DECODE)
-			) {
-				curr_driver->drvctl_func(DRVCTL_NOTIFY_DECODE,
-							 NULL);
-			}
-
 			get_release_data(&remote_name, &button_name, &reps);
 
 			input_message(message, remote_name, button_name, reps);
diff --git a/tools/lirc-lsplugins.cpp b/tools/lirc-lsplugins.cpp
index ba67a3cb..6251ac65 100644
--- a/tools/lirc-lsplugins.cpp
+++ b/tools/lirc-lsplugins.cpp
@@ -57,8 +57,7 @@
 	"#    c: LIRC_CAN_SET_SEND_CARRIER\n" \
 	"#    d: LIRC_CAN_SET_SEND_DUTY_CYCLE\n" \
 	"#    t: LIRC_CAN_SET_TRANSMITTER_MASK\n" \
-	"#    C: LIRC_CAN_MEASURE_CARRIER\n" \
-	"#    D: LIRC_CAN_NOTIFY_DECODE\n"
+	"#    C: LIRC_CAN_MEASURE_CARRIER\n"
 
 const struct option options[] = {
 	{ "plugindir",	  required_argument, NULL, 'U' },
@@ -303,8 +302,7 @@ static void format_features(struct driver* hw, line_t* line)
 		 get(LIRC_CAN_SET_SEND_CARRIER, 'c', hw),
 		 get(LIRC_CAN_SET_SEND_DUTY_CYCLE, 'd', hw),
 		 get(LIRC_CAN_SET_TRANSMITTER_MASK, 't', hw),
-		 get(LIRC_CAN_MEASURE_CARRIER, 'C', hw),
-		 get(LIRC_CAN_NOTIFY_DECODE, 'D', hw)
+		 get(LIRC_CAN_MEASURE_CARRIER, 'C', hw)
 		 );
 	line->features = strdup(buff);
 }

--h3J3ZAFSc2DcqDuO--
