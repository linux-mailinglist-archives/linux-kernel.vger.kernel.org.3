Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B7F3480186
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Dec 2021 17:18:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234149AbhL0QSr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Dec 2021 11:18:47 -0500
Received: from mx3.molgen.mpg.de ([141.14.17.11]:37655 "EHLO mx1.molgen.mpg.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231254AbhL0QSq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Dec 2021 11:18:46 -0500
Received: from [192.168.0.2] (ip5f5aea86.dynamic.kabel-deutschland.de [95.90.234.134])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: pmenzel)
        by mx.molgen.mpg.de (Postfix) with ESMTPSA id 3A10361EA1922;
        Mon, 27 Dec 2021 17:18:45 +0100 (CET)
Message-ID: <41f9d4f9-eb3a-7a5d-3d69-5361dd9124fc@molgen.mpg.de>
Date:   Mon, 27 Dec 2021 17:18:44 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.1
Content-Language: en-US
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     linux-input@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Felix Singer <felixsinger@posteo.net>,
        Matt DeVillier <matt.devillier@gmail.com>
From:   Paul Menzel <pmenzel@molgen.mpg.de>
Subject: Upstream support of Google Chromebook keyboards (udev,
 xkeyboard-config)?
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Linux folks,


Installing a non-Chromium OS distribution like Debian on a Google 
Chromebook, in this case a Dell Latitude 5400 Chrome (google/sarien), 
not all keys work as expected.

1.  Non-working super key and two function keys on Google Chromebook 
Dell Latitute 5400 Chrome (google/sarien) [1]
2.  Wrong caps lock key and function key mappings on Google Chromebook 
Dell Latitute 5400 Chrome (google/sarien) [2]

Peter replied, this should be fixed in udev, so it’s not directly 
related to the Linux kernel, as the Linux kernel exposes the 
scancodes(?) just fine. But what is the upstream process for this in 
general? Chromium OS carries `91-chromeos-keyboard.rules` for example.

systemd/udev currently has an entry for two Google Chromebook models in 
`hwdb.d/60-keyboard.hwdb` [4]:

     ######################### FIXED MODEL DEVICES 
#############################
     # This section lists devices which require special handling in 
their key
     # code to keysym mapping by setting the xkb model.
     # The model must be an xkb compatible model (defined with 
XKB_FIXED_MODEL).

     # Chromebooks
     evdev:atkbd:dmi:bvn*:bvr*:bd*:svnHewlett-Packard*:pnFalco:pvr*
     evdev:atkbd:dmi:bvn*:bvr*:bd*:svnAcer*:pnPeppy:pvr*
      XKB_FIXED_MODEL="chromebook"

The Dell Chromebooks, unfortunately, also use the embedded controller 
with Dell’s proprietary firmware (Wilco(?)), and not Chrome EC making 
special handling necessary. `91-chromeos-keyboard.rules` has

     # Wilco keyboard (5220W-C) for Chrome OS
     SUBSYSTEM=="input", \
       ATTRS{idVendor}=="413c", ATTRS{idProduct}=="2510", \
       ENV{CROS_KEYBOARD_TOP_ROW_LAYOUT}="3", \
       ENV{ID_INPUT_KEYBOARD}="1"


Kind regards,

Paul


[1]: 
https://gitlab.freedesktop.org/xkeyboard-config/xkeyboard-config/-/issues/298
[2]: 
https://gitlab.freedesktop.org/xkeyboard-config/xkeyboard-config/-/issues/299
[3]: 
https://chromium.googlesource.com/chromiumos/overlays/chromiumos-overlay/+/783bd8563450d9e9e575323a83321fdc67e334bf/sys-fs/udev/files/91-chromeos-keyboard.rules
[4]: 
https://github.com/systemd/systemd/commit/d7d31692bf7cde5dce7f4ed3cae429a5b302a9f0?branch=d7d31692bf7cde5dce7f4ed3cae429a5b302a9f0
