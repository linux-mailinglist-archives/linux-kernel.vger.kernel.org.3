Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49FA652F16B
	for <lists+linux-kernel@lfdr.de>; Fri, 20 May 2022 19:19:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352113AbiETRTJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 May 2022 13:19:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352108AbiETRTH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 May 2022 13:19:07 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93BEE1862A9
        for <linux-kernel@vger.kernel.org>; Fri, 20 May 2022 10:19:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
        Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=mYBo9IPynpe0pl+mZeNGkr1lS3oG/UutDNomBlexN9o=;
        t=1653067145; x=1654276745; b=tGCy8e1bDWeQti+hcpfsP1Yeb+YmnMkDICYU/k0nyUs7J+r
        jdZyWwMbiYmPb2KPi/e3Q4wlUS/oOvX+ixPsLmNTQ1nEryYch/jUr/no5HwsFtQXkAB6+4HdG1F0/
        PtQboCuePaL8/85i3uJumboElIJXMQoX6gikLd3miYQO3FTs3Ns9UM7J3Wozpqw6XDts936GGGGZw
        /H2Icr9rEBqLOhm9wEJ0P1YKKsn9wgXVX4MXC80Jdl+Qp3CILMo95f0stt8sYrIhNv+YCJ8s/rn/g
        88J7RNiU78QQckBHQyec+VIFeT2XfbffGrG0ahqfICStjz1A9aFPfckZaklSANgg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.95)
        (envelope-from <johannes@sipsolutions.net>)
        id 1ns6Gk-00HR5C-0z;
        Fri, 20 May 2022 19:18:30 +0200
Message-ID: <32824a71109fe3387d582abbf56601fb08bdc9ef.camel@sipsolutions.net>
Subject: Re: [PATCH 1/1] um: fix error return code in winch_tramp()
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Nathan Chancellor <nathan@kernel.org>,
        Thorsten Leemhuis <regressions@leemhuis.info>
Cc:     Richard Weinberger <richard@nod.at>,
        Zhen Lei <thunder.leizhen@huawei.com>,
        Jeff Dike <jdike@addtoit.com>,
        anton ivanov <anton.ivanov@cambridgegreys.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Eduard-Gabriel Munteanu <maxdamage@aladin.ro>,
        linux-um <linux-um@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        regressions <regressions@lists.linux.dev>
Date:   Fri, 20 May 2022 19:18:28 +0200
In-Reply-To: <Yoe5/HwL9DXhaw7Z@dev-arch.thelio-3990X>
References: <20210508032239.2177-1-thunder.leizhen@huawei.com>
         <Yjt31seiNv18HYrf@dev-arch.thelio-3990X>
         <1b03d888-cea3-3e6f-087f-daeb5642a975@leemhuis.info>
         <1087614384.239493.1649583213699.JavaMail.zimbra@nod.at>
         <YlRp9KR1mp3/4Txo@thelio-3990X>
         <1287561645.244713.1649702724736.JavaMail.zimbra@nod.at>
         <e9597cbc-cabb-facf-deb6-662d40cf16a3@leemhuis.info>
         <Yoe5/HwL9DXhaw7Z@dev-arch.thelio-3990X>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.1 (3.44.1-1.fc36) 
MIME-Version: 1.0
X-malware-bazaar: not-scanned
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2022-05-20 at 08:55 -0700, Nathan Chancellor wrote:
> On Fri, May 20, 2022 at 08:08:01AM +0200, Thorsten Leemhuis wrote:
> > On 11.04.22 20:45, Richard Weinberger wrote:
> > > ----- Urspr=C3=BCngliche Mail -----
> > > > Von: "Nathan Chancellor" <nathan@kernel.org>
> > > > I attempted to print out the error code but it seems like there is =
no
> > > > output in the console after "reboot: System halted". If I add an
> > > > unconditional print right before the call to os_set_fd_block(), I s=
ee it
> > > > during start up but I do not see it during shutdown. Is there some =
way
> > > > to see that console output during shutdown?
> > >=20
> > > I think in this case the easiest way is attaching gdb with a breakpoi=
nt.
> >=20
> > I noticed this in my list of open regressions. It seems there wasn't an=
y
> > progress to get this regression fixed (please let me know in case I
> > missed something), but I guess nobody considered it urgent which is
> > likely not that much of a problem in this case.
>=20
> Yes, sorry, I tried to get gdb to reveal something but I couldn't get it
> to work then I had to move onto other work. We have worked around this
> for the time being but it would still be nice to figure out what is
> going on here; I am just not sure when I am going to have time to
> participate in that process.
>=20

This fixes it for me, can you check it?

diff --git a/arch/um/drivers/chan_user.c b/arch/um/drivers/chan_user.c
index 6040817c036f..25727ed648b7 100644
--- a/arch/um/drivers/chan_user.c
+++ b/arch/um/drivers/chan_user.c
@@ -220,7 +220,7 @@ static int winch_tramp(int fd, struct tty_port *port, i=
nt *fd_out,
 		       unsigned long *stack_out)
 {
 	struct winch_data data;
-	int fds[2], n, err;
+	int fds[2], n, err, pid;
 	char c;
=20
 	err =3D os_pipe(fds, 1, 1);
@@ -238,8 +238,9 @@ static int winch_tramp(int fd, struct tty_port *port, i=
nt *fd_out,
 	 * problem with /dev/net/tun, which if held open by this
 	 * thread, prevents the TUN/TAP device from being reused.
 	 */
-	err =3D run_helper_thread(winch_thread, &data, CLONE_FILES, stack_out);
-	if (err < 0) {
+	pid =3D run_helper_thread(winch_thread, &data, CLONE_FILES, stack_out);
+	if (pid < 0) {
+		err =3D pid;
 		printk(UM_KERN_ERR "fork of winch_thread failed - errno =3D %d\n",
 		       -err);
 		goto out_close;
@@ -263,7 +264,7 @@ static int winch_tramp(int fd, struct tty_port *port, i=
nt *fd_out,
 		goto out_close;
 	}
=20
-	return err;
+	return pid;
=20
  out_close:
 	close(fds[1]);


Kind of obvious, really. :)

johannes
