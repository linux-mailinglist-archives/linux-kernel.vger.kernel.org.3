Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 958804C5A12
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Feb 2022 09:29:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230155AbiB0I3X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Feb 2022 03:29:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229769AbiB0I3W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Feb 2022 03:29:22 -0500
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [IPv6:2a01:488:42:1000:50ed:8234::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B5043EA93
        for <linux-kernel@vger.kernel.org>; Sun, 27 Feb 2022 00:28:45 -0800 (PST)
Received: from ip4d144895.dynamic.kabel-deutschland.de ([77.20.72.149] helo=[192.168.66.200]); authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1nOEv3-0002s9-Qx; Sun, 27 Feb 2022 09:28:41 +0100
Message-ID: <79949bb0-0b7c-5e70-f554-45f40256e325@leemhuis.info>
Date:   Sun, 27 Feb 2022 09:28:41 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: regression: Build failure of mainline kernel with qcom_defconfig
Content-Language: en-BS
To:     Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>
Cc:     Daniel Vetter <daniel.vetter@ffwll.ch>,
        Javier Martinez Canillas <javierm@redhat.com>,
        Jani Nikula <jani.nikula@intel.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        "regressions@lists.linux.dev" <regressions@lists.linux.dev>
References: <YhofdlzadzRmy7tj@debian>
From:   Thorsten Leemhuis <regressions@leemhuis.info>
In-Reply-To: <YhofdlzadzRmy7tj@debian>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1645950525;1eb2e7fe;
X-HE-SMSGID: 1nOEv3-0002s9-Qx
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[TLDR: I'm adding the regression report below to regzbot, the Linux
kernel regression tracking bot; all text you find below is compiled from
a few templates paragraphs you might have encountered already already
from similar mails.]

Hi, this is your Linux kernel regression tracker. Top-posting for once,
to make this easy accessible to everyone.

Thanks for the report.

To be sure below issue doesn't fall through the cracks unnoticed, I'm
adding it to regzbot, my Linux kernel regression tracking bot:

#regzbot ^introduced 9d6366e743f37d36ef69347924ead7bcc596076e
#regzbot title drm: fb_helper:  Build failure of mainline kernel with
qcom_defconfig
#regzbot ignore-activity

Reminder for developers: when fixing the issue, please add a 'Link:'
tags pointing to the report (the mail quoted above) using
lore.kernel.org/r/, as explained in
'Documentation/process/submitting-patches.rst' and
'Documentation/process/5.Posting.rst'. This allows the bot to connect
the report with any patches posted or committed to fix the issue; this
again allows the bot to show the current status of regressions and
automatically resolve the issue when the fix hits the right tree.

I'm sending this to everyone that got the initial report, to make them
aware of the tracking. I also hope that messages like this motivate
people to directly get at least the regression mailing list and ideally
even regzbot involved when dealing with regressions, as messages like
this wouldn't be needed then. And don't worry, if I need to send other
mails regarding this regression only relevant for regzbot I'll send them
to the regressions lists only (with a tag in the subject so people can
filter them away). With a bit of luck no such messages will be needed
anyway.

Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)

P.S.: As the Linux kernel's regression tracker I'm getting a lot of
reports on my table. I can only look briefly into most of them and lack
knowledge about most of the areas they concern. I thus unfortunately
will sometimes get things wrong or miss something important. I hope
that's not the case here; if you think it is, don't hesitate to tell me
in a public reply, it's in everyone's interest to set the public record
straight.

On 26.02.22 13:39, Sudip Mukherjee wrote:
> Hi Arnd, All,
> 
> We recently noticed that arm "qcom_defconfig" failed to build with the error:
> 
> arm-linux-gnueabi-ld: drivers/gpu/drm/panel/panel-edp.o: in function `panel_edp_probe':
> drivers/gpu/drm/panel/panel-edp.c:843: undefined reference to `drm_panel_dp_aux_backlight'
> 
> I have done a bisect and it points to:
> 9d6366e743f3 ("drm: fb_helper: improve CONFIG_FB dependency")
> 
> Here is the complete bisect log:
> 
> # bad: [df0cc57e057f18e44dac8e6c18aba47ab53202f9] Linux 5.16
> # good: [8bb7eca972ad531c9b149c0a51ab43a417385813] Linux 5.15
> git bisect start 'v5.16' 'v5.15'
> # good: [2219b0ceefe835b92a8a74a73fe964aa052742a2] Merge tag 'soc-5.16' of git://git.kernel.org/pub/scm/linux/kernel/git/soc/soc
> git bisect good 2219b0ceefe835b92a8a74a73fe964aa052742a2
> # good: [206825f50f908771934e1fba2bfc2e1f1138b36a] Merge tag 'mtd/for-5.16' of git://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux
> git bisect good 206825f50f908771934e1fba2bfc2e1f1138b36a
> # bad: [4e1fddc98d2585ddd4792b5e44433dcee7ece001] tcp_cubic: fix spurious Hystart ACK train detections for not-cwnd-limited flows
> git bisect bad 4e1fddc98d2585ddd4792b5e44433dcee7ece001
> # good: [dbf49896187fd58c577fa1574a338e4f3672b4b2] Merge branch 'akpm' (patches from Andrew)
> git bisect good dbf49896187fd58c577fa1574a338e4f3672b4b2
> # bad: [0ecca62beb12eeb13965ed602905c8bf53ac93d0] Merge tag 'ceph-for-5.16-rc1' of git://github.com/ceph/ceph-client
> git bisect bad 0ecca62beb12eeb13965ed602905c8bf53ac93d0
> # bad: [304ac8032d3fa2d37750969cd4b8d5736a1829d9] Merge tag 'drm-next-2021-11-12' of git://anongit.freedesktop.org/drm/drm
> git bisect bad 304ac8032d3fa2d37750969cd4b8d5736a1829d9
> # good: [f78e9de80f5ad15719a069a4e6c11e2777122188] Merge branch 'for-linus' of git://git.kernel.org/pub/scm/linux/kernel/git/dtor/input
> git bisect good f78e9de80f5ad15719a069a4e6c11e2777122188
> # good: [806acd381960008700c15c3dc616d578e9558853] Merge tag 'amd-drm-fixes-5.16-2021-11-03' of https://gitlab.freedesktop.org/agd5f/linux into drm-next
> git bisect good 806acd381960008700c15c3dc616d578e9558853
> # bad: [f8ca7b74192b2e64bdfb89fb63c1d33b92bc899d] Merge tag 'drm-misc-next-fixes-2021-11-10' of git://anongit.freedesktop.org/drm/drm-misc into drm-next
> git bisect bad f8ca7b74192b2e64bdfb89fb63c1d33b92bc899d
> # good: [cecbc0c7eba7983965cac94f88d2db00b913253b] drm/i915/hdmi: Turn DP++ TMDS output buffers back on in encoder->shutdown()
> git bisect good cecbc0c7eba7983965cac94f88d2db00b913253b
> # bad: [14d9a37c952588930d7226953359fea3ab956d39] Revert "drm/imx: Annotate dma-fence critical section in commit path"
> git bisect bad 14d9a37c952588930d7226953359fea3ab956d39
> # good: [5591c8f79db1729d9c5ac7f5b4d3a5c26e262d93] drm/udl: fix control-message timeout
> git bisect good 5591c8f79db1729d9c5ac7f5b4d3a5c26e262d93
> # bad: [9d6366e743f37d36ef69347924ead7bcc596076e] drm: fb_helper: improve CONFIG_FB dependency
> git bisect bad 9d6366e743f37d36ef69347924ead7bcc596076e
> # good: [e0e6d1ea18c804de51b47fa65092c4cf2000604c] MAINTAINERS: dri-devel is for all of drivers/gpu
> git bisect good e0e6d1ea18c804de51b47fa65092c4cf2000604c
> # first bad commit: [9d6366e743f37d36ef69347924ead7bcc596076e] drm: fb_helper: improve CONFIG_FB dependency
> 
> 
> And, indeed reverting "9d6366e743f37d36ef69347924ead7bcc596076e" on top of
> 9137eda53752 ("Merge tag 'configfs-5.17-2022-02-25' of git://git.infradead.org/users/hch/configfs")
> fixes the build.
> 
> I will be happy to test any patch fxing this issue.

-- 
Additional information about regzbot:

If you want to know more about regzbot, check out its web-interface, the
getting start guide, and the references documentation:

https://linux-regtracking.leemhuis.info/regzbot/
https://gitlab.com/knurd42/regzbot/-/blob/main/docs/getting_started.md
https://gitlab.com/knurd42/regzbot/-/blob/main/docs/reference.md

The last two documents will explain how you can interact with regzbot
yourself if your want to.

Hint for reporters: when reporting a regression it's in your interest to
CC the regression list and tell regzbot about the issue, as that ensures
the regression makes it onto the radar of the Linux kernel's regression
tracker -- that's in your interest, as it ensures your report won't fall
through the cracks unnoticed.

Hint for developers: you normally don't need to care about regzbot once
it's involved. Fix the issue as you normally would, just remember to
include 'Link:' tag in the patch descriptions pointing to all reports
about the issue. This has been expected from developers even before
regzbot showed up for reasons explained in
'Documentation/process/submitting-patches.rst' and
'Documentation/process/5.Posting.rst'.

