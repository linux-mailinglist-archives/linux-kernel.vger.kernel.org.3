Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1242B578CD0
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jul 2022 23:35:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235514AbiGRVf1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 17:35:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235506AbiGRVfH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 17:35:07 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BBAA2A42C;
        Mon, 18 Jul 2022 14:35:06 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id z23so23709646eju.8;
        Mon, 18 Jul 2022 14:35:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=J6ZIGc2HV5YmZU5DGZhmz/AP+TVHMADu3pWfcRh2v0s=;
        b=m7Tl7T9/OyjJvd+9D1eqmh7crzxzb6OgL81SkUfiwRYWFAYfAberpMobJnd5ITS24B
         Nk+yk7LDpWUKUkP+fGeJA91Z5gjhhFp75pDPbv5o/0HCn6MoG8KAVQMBsL2l6nMmd907
         dxzk8DnIZiQYuQy9u+E6mtyQd3rErsjq0P62GqMzNcDNuO3veZZVURdoJ8pHMUPoI7GX
         q/YSToZtSIgpVTgtNn0G0oJ45Ve5yp1zTC0ZqmKnFG4cK+VZEW4fUrI1KGR9SGJiE4pj
         mgX97wWyHzYhGzYJ9NUgvKQAWZ7Y91lxCJzOG75nRDXviKCCAuWVPzPRizBeXaJG4e2E
         4mJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=J6ZIGc2HV5YmZU5DGZhmz/AP+TVHMADu3pWfcRh2v0s=;
        b=P0uXbvKvSnd0IDxJFbIsh9VcX6MkRCczrxyXhwL0rzHMzI3kVaVsukytwYaYMm+A18
         QAyZrBPc8Fu23XsyqJZHPtW53Lsh+c+TE0ZVz+VS5W7KVC5eLVatsbt8JrLM3UMvX2Du
         76JtgvBuUdFChmWX1cL+KKVRs31jZLihCy60DZxcJYgWgwLV3dOCEfdna/w6B9Zzcjpn
         oTSW+KQxnrpPYGs1jEk048Um4dkv8pEblK3LV6TVIT1SdDCQMPpSCL1Gc50j6tRsyuVM
         a6qMP7SEfQgNzn82BCc70n/JQJKmjtpc4ADyrGtOLSNGyz3OYQfsP1BJJH58GqPScVMV
         nGfg==
X-Gm-Message-State: AJIora9QcDCJh9rI9nunvfqxYLGliYSG27A0ujDMgBfUk/bBqA+4UrVJ
        H5/qgQ9vQveEUeY5YdyrbZ8S4o5B7bEbTbLy7ZMyuKBHq2WW4Q==
X-Google-Smtp-Source: AGRyM1ulBzWb8ZQg7Ay8ExigBgLDI+3zpugLNpCTS3LAik9v8BxhnqY04og52i7yyhBimfnuhWebaya7pjCAk+ctxRs=
X-Received: by 2002:a17:907:3f04:b0:72f:227e:11ed with SMTP id
 hq4-20020a1709073f0400b0072f227e11edmr8818746ejc.40.1658180104446; Mon, 18
 Jul 2022 14:35:04 -0700 (PDT)
MIME-Version: 1.0
From:   nyanpasu <nyanpasu256@gmail.com>
Date:   Mon, 18 Jul 2022 14:34:53 -0700
Message-ID: <CAL57YxZNutUVxBtvbVWKMw-V2kqeVB5kTQ5BFdJmN=mdPq8Q8Q@mail.gmail.com>
Subject: Bug: Elan v3 touchpad's reported size is half of actual touch coordinates
To:     linux-input@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I noticed that on Linux 5.18.11, on my laptop (Dell Inspiron 15R SE
7520) with an Elan v3 touchpad (dmesg says "with firmware version
0x450f02"), the reported size of my touchpad (in userspace by calling
mtdev_configure() and libevdev_get_abs_maximum(), in kernel space
elantech_device_info::x_max/y_max, either way 1470 by 700) is half
that of the actual touch range (2940 by 1400), and the upper half of
my touchpad reports negative values. As a result, with the Synaptics
X11 driver set to edge scrolling mode, the entire right half of my
touchpad has x-values past evdev's reported maximum size, and acts as
a giant scrollbar!

The bug arises due to an error in drivers/input/mouse/elantech.c
(which has been unchanged since 2021, in both torvalds and
dtor/input).

In this file, elantech_init_ps2() first calls
elantech_query_info(struct psmouse *psmouse, struct
elantech_device_info *info), which calls elantech_set_properties() to
initialize info->hw_version = 3, then on version 3 touchpads requests
ETP_FW_ID_QUERY to initialize info->x_max and y_max.

Afterwards, elantech_init_ps2() calls elantech_setup_ps2(struct
psmouse *psmouse, struct elantech_device_info *info), which calls
elantech_set_absolute_mode(struct psmouse *psmouse), which if
(etd->info.set_hw_resolution) (true on my machine), writes 0x0b to
etd->reg_10 and sends it to the hardware.

The problem is that elantech_setup_ps2() ->
elantech_set_absolute_mode() sets up absolute mode and doubles the
hardware resolution (doubling the hardware's maximum reported x/y
coordinates and its response to ETP_FW_ID_QUERY), *after*
elantech_query_info() fetches the touchpad coordinate system size
using ETP_FW_ID_QUERY, which gets cached and reported to userspace
through ioctl(fd, EVIOCGABS(ABS_X/Y), ...). So the touchpad size
reported to userspace (and used to subtract vertical coordinates from)
is half the maximum position of actual touches.

I've considered and implemented multiple possible fixes to this issue.

The easiest solution (or hack) is for elantech_set_absolute_mode() to
first write reg_10 to hardware, then if (etd->info.set_hw_resolution)
is true, call elantech_query_info() a second time. However this
re-requests device firmware version etc. and rewrites state, which I
dislike because it could theoretically change fields in
elantech_device_info you didn't mean to.

You can't enable absolute mode first before calling
elantech_query_info(), because elantech_query_info() is responsible
for probing hardware and identifying if it's v3, and
elantech_set_absolute_mode() depends on it.

You *could* make elantech_query_info() only query the hardware version
before returning, then enable absolute mode before calling a new
function to identify the touchpad size. I did not take this approach
because I didn't know how much code to move from elantech_query_info()
into a new function called after elantech_set_absolute_mode()
(everything up to ETP_ICBODY_QUERY probably not, ETP_FW_ID_QUERY
definitely should be, and probably elantech_get_resolution_v4's
ETP_RESOLUTION_QUERY for consistency). I think it's safe to move only
"query range information" and possibly "check for the middle button:
DMI matching or new v4 firmwares", and elantech_get_resolution_v4()
(for consistency), to after elantech_set_absolute_mode(). However,
this change affects the order of hardware commands on all hardware
(not just the v3 Elan I have), and I cannot verify it works on other
Elan touchpads.

The most surgical fix I could think of (minimizing changes to behavior
from the current Linux driver), is fetching *only* ETP_FW_ID_QUERY
(touchpad size) a second time after elantech_set_absolute_mode()
enables absolute mode and double-size mode. I have a local clone of
Linux, which I edited to split out the ETP_FW_ID_QUERY request into a
helper function elantech_query_range_v3(), which gets called by
elantech_query_info() before boosting resolution, and by
elantech_set_absolute_mode() after/if it boosts resolution. I built
drivers/input/mouse and installed the resulting psmouse.ko, which
fixes the bug (the touchpad size reported to userspace is 2940 by
1400, matching the range of touch events) and fixes edge scrolling.
Should I submit this patch (alongside patches removing
elantech_data::y_max/width which are redundant with
elantech_data::info.y_max/width) or not?

However I do not know how the Windows Dell/Elan v3 driver (or other
hardware versions' drivers) initialize the touchpad and driver,
specifically what order it sends various queries. I only have an Elan
v3 touchpad (no other Elan hardware/driver pairs, just Alps and
Synaptics) to study, do not have a logic analyzer to read the commands
off the wire (though perhaps I could rig one up fast enough for PS/2
using a Pi's GPIO pins), and have not tried decompiling that driver in
Ghidra (which may not be clean-room safe, but I don't know if the
current driver is clean-room or not, since elantech.rst mentions
"name[s] given in the Dell-provided driver"). Is it critical to match
the Windows driver's command order, or can we use any order that
works?

(Out of curiosity, given that PS/2 runs at <20 KHz and the Elan driver
is written with blocking calls, is mouse processing code run in a
dedicated kernel thread to avoid blocking other kernel tasks? I'm not
an experienced kernel developer but a drive-by contributor, so I don't
quite know how kernel concurrency works.)

(Note I'm not subscribed to linux-input or linux-kernel, please CC me
in replies.)
