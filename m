Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFCEE58B8C7
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Aug 2022 02:49:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232680AbiHGAtl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 Aug 2022 20:49:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232431AbiHGAth (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Aug 2022 20:49:37 -0400
Received: from conuserg-09.nifty.com (conuserg-09.nifty.com [210.131.2.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1634E01D;
        Sat,  6 Aug 2022 17:49:35 -0700 (PDT)
Received: from grover.sesame ([133.106.62.9]) (authenticated)
        by conuserg-09.nifty.com with ESMTP id 2770mJ2l003955;
        Sun, 7 Aug 2022 09:48:19 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-09.nifty.com 2770mJ2l003955
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1659833300;
        bh=Bw/XbE6HWw29rVtZscyI7nO0jB5sZzJbaSCrdVk4scY=;
        h=From:To:Cc:Subject:Date:From;
        b=x558DUGsMf5z9xEL1+Z9IIUzXCl8xCR1gI0YcaZBhO/ZvtBjx4pY4r9MTu93VDzus
         GAQZYjqo36v0pUACG2v0qqqARKd0kibvH+RcDG0QzcDdGjPeEdm6ivhsxjotSuJ64j
         eCX2UvlrXi7uKbIlFdBQA7ArdqEkyHcx83d5KeJ7/iSwQjamSJpkxochcjVPNYLJRn
         fHfiSCsC5bpUic638mQ+8TLMej+iizVrIgONT6YK3QQ0dcNcBKn/e1/48KglNAJb+L
         /nf8E391qu6TCs2iJjS0VmSdrT65eQkL8WAK8sBkuWhHO1nJgkHSq4cttmBNaht1Ae
         VD4+u2RmOIp+w==
X-Nifty-SrcIP: [133.106.62.9]
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-kbuild@vger.kernel.org
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        Ingo Molnar <mingo@kernel.org>, Rob Herring <robh@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] kbuild: remove the target in signal traps when interrupted
Date:   Sun,  7 Aug 2022 09:48:09 +0900
Message-Id: <20220807004809.69076-1-masahiroy@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_SOFTFAIL,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When receiving some signal, GNU Make automatically deletes the target if
it has already been changed by the interrupted recipe.

If the target is possibly incomplete due to interruption, it must be
deleted so that it will be remade from scratch on the next run of make.
Otherwise, the target would remain corrupted permanently because its
timestamp had already been updated.

Thanks to this behavior of Make, you can stop the build any time by
pressing Ctrl-C, and just run 'make' to resume it.

Kbuild also relies on this feature, but it is equivalently important
for any build systems that make decisions based on timestamps (if you
want to support stop/resume reliably).

However, this does not always work as claimed; Make immediately dies
with Ctrl-C if its stderr goes into a pipe.

  [Test Makefile]

    foo:
            echo hello > $@
            sleep 3
            echo world >> $@

  [Test Result]

    $ make                         # hit Ctrl-C
    echo hello > foo
    sleep 3
    ^Cmake: *** Deleting file 'foo'
    make: *** [Makefile:3: foo] Interrupt

    $ make 2>&1 | cat              # hit Ctrl-C
    echo hello > foo
    sleep 3
    ^C$                            # 'foo' is often left-over

The reason is because SIGINT is sent to the entire process group.
In this example, SIGINT kills 'cat', and 'make' writes the message to
the closed pipe, then dies with SIGPIPE.

A typical bad scenario (as reported by [1], [2]) is to save build log
by using the 'tee' command:

    $ make 2>&1 | tee log

Again, this can be problematic for any build systems based on Make, so
I hope it will be fixed in GNU Make. The maintainer of GNU Make stated
this is a long-standing issue and difficult to fix [3]. It has not been
fixed yet as of writing.

So, we cannot rely on Make cleaning the target. We can do it by
ourselves, in signal traps.

As far as I understand, Make takes care of SIGHUP, SIGINT, SIGQUIT, and
SITERM for the target removal. I added the traps for them, and also for
SIGPIPE just in case cmd_* rule prints something to stdout or stderr
(but I did not observe an actual case where SIGPIPE was triggered).

[Note 1]

The trap handler might be worth explaining.

    rm -f $@; trap - $(sig); kill -s $(sig) $$

This lets the shell kill itself by the signal it caught, so the parent
process can tell the child has exited on the signal. Generally, this is
a proper manner for handling signals, in case the calling program (like
Bash) may monitor WIFSIGNALED() and WTERMSIG() for WCE (Wait and
Cooperative Exit) [4] although this may not be a big deal here because
GNU Make handles SIGHUP, SIGINT, SIGQUIT in WUE (Wait and Unconditional
Exit) and SIGTERM in IUE (Immediate Unconditional Exit).

[Note 2]

Reverting 392885ee82d3 ("kbuild: let fixdep directly write to .*.cmd
files") would directly address [1], but it only saves if_changed_dep.
As reported in [2], all commands that use redirection can potentially
leave an empty (i.e. broken) target.

[Note 3]

Another (even safer) approach might be to always write to a temporary
file, and rename it to $@ at the end of the recipe.

   <command>  > $(tmp-target)
   mv $(tmp-target) $@

It would require a lot of Makefile changes, and result in ugly code,
so I did not take it.

[Note 4]

A little more thoughts about a pattern rule with multiple targets (or
a grouped target).

    %.x %.y: %.z
            <recipe>

When interrupted, GNU Make deletes both %.x and %.y, while this solution
only deletes $@. Probably, this is not a big deal. The next run of make
will execute the rule again to create $@ along with the other files.

[1]: https://lore.kernel.org/all/YLeot94yAaM4xbMY@gmail.com/
[2]: https://lore.kernel.org/all/20220510221333.2770571-1-robh@kernel.org/
[3]: https://lists.gnu.org/archive/html/help-make/2021-06/msg00001.html
[4]: https://www.cons.org/cracauer/sigint.html

Reported-by: Ingo Molnar <mingo@kernel.org>
Reported-by: Rob Herring <robh@kernel.org>
Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

If you are happy to help test this patch, that will be appreciated.

Without applying this patch,

    $ make -j<nr-proc> 2>&1 | tee log

Then, you will see an error reported in [1].
You may need to repeat it dozen of times to reproduce it.
The more CPU cores you have, the easier you will get the error.

Apply this patch, and repeat the same.
You will no longer see that error (hopefully).


 scripts/Kbuild.include | 23 ++++++++++++++++++++++-
 1 file changed, 22 insertions(+), 1 deletion(-)

diff --git a/scripts/Kbuild.include b/scripts/Kbuild.include
index ece44b735061..9432a7f33186 100644
--- a/scripts/Kbuild.include
+++ b/scripts/Kbuild.include
@@ -100,8 +100,29 @@ echo-cmd = $(if $($(quiet)cmd_$(1)),\
  quiet_redirect :=
 silent_redirect := exec >/dev/null;
 
+# Delete the target on interruption
+#
+# GNU Make automatically deletes the target if it has already been changed by
+# the interrupted recipe. So, you can safely stop the build by Ctrl-C (Make
+# will delete incomplete targets), and resume it later.
+#
+# However, this does not work when the stderr is piped to another program, like
+#  $ make >&2 | tee log
+# Make dies with SIGPIPE before cleaning the targets.
+#
+# To address it, we cleans the target in signal traps.
+#
+# Make deletes the target when it catches SIGHUP, SIGINT, SIGQUIT, SIGTERM.
+# So, we cover them, and also SIGPIPE just in case.
+#
+# Of course, this is unneeded for phony targets.
+delete-on-interrupt = \
+	$(if $(filter-out $(PHONY), $@), \
+		$(foreach sig, HUP INT QUIT TERM PIPE, \
+			trap 'rm -f $@; trap - $(sig); kill -s $(sig) $$$$' $(sig);))
+
 # printing commands
-cmd = @set -e; $(echo-cmd) $($(quiet)redirect) $(cmd_$(1))
+cmd = @set -e; $(echo-cmd) $($(quiet)redirect) $(delete-on-interrupt) $(cmd_$(1))
 
 ###
 # if_changed      - execute command if any prerequisite is newer than
-- 
2.34.1

