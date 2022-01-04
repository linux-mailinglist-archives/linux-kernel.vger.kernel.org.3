Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C9B24844A2
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jan 2022 16:32:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234879AbiADPcF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jan 2022 10:32:05 -0500
Received: from mx3.molgen.mpg.de ([141.14.17.11]:52445 "EHLO mx1.molgen.mpg.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S234854AbiADPcC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jan 2022 10:32:02 -0500
Received: from [192.168.0.3] (ip5f5aecde.dynamic.kabel-deutschland.de [95.90.236.222])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: pmenzel)
        by mx.molgen.mpg.de (Postfix) with ESMTPSA id 50CFC61EA1928;
        Tue,  4 Jan 2022 16:32:00 +0100 (CET)
Message-ID: <2dc1017e-7e81-83d0-73f3-c2b144aefe74@molgen.mpg.de>
Date:   Tue, 4 Jan 2022 16:31:59 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.1
Subject: Re: Upstream support of Google Chromebook keyboards (udev,
 xkeyboard-config)?
Content-Language: en-US
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     linux-input@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Felix Singer <felixsinger@posteo.net>,
        Matt DeVillier <matt.devillier@gmail.com>
References: <41f9d4f9-eb3a-7a5d-3d69-5361dd9124fc@molgen.mpg.de>
 <YdOOElXuwxkKlU59@google.com>
From:   Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <YdOOElXuwxkKlU59@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Dmitry,


Am 04.01.22 um 01:00 schrieb Dmitry Torokhov:

> On Mon, Dec 27, 2021 at 05:18:44PM +0100, Paul Menzel wrote:

>> Installing a non-Chromium OS distribution like Debian on a Google
>> Chromebook, in this case a Dell Latitude 5400 Chrome (google/sarien), not
>> all keys work as expected.
> 
> Looking at the issues you are referencing you are flashing a 3rd party
> firmware on the device so I am unable to comment on behavior of that
> firmware, however:

Not quite, I only flash the RW_LEGACY section, so only the payload is 
changed as the vendor firmware unfortunately does not ship with a 
depthcharge alternative making booting another operating system 
impossible. (Or I missed something.)

>> 1.  Non-working super key and two function keys on Google Chromebook Dell
>> Latitute 5400 Chrome (google/sarien) [1]
> 
> There is no "super" key on Chromebooks.

Sorry for mixing the terminology. (On the identical in design Dell 
Latitude 5400 it is that key.)

> The "globe" key you see is supposed to select next keyboard layout.

Oh, interesting choice.

> This is the udev hwdb entry that we have for Sarien/Arcada devices in
> our tree: >
> # Copyright 2019 The Chromium OS Authors. All rights reserved.
> # Distributed under the terms of the GNU General Public License v2
> 
> #
> # Special keyboard mapping for the Sarien project. The keyboard emits both
> # function and action scan codes depending on Fn-modifier key.
> 
> evdev:atkbd:dmi:bvn*:bvr*:bd*:svnDell*:pnSarien:pvr*
> evdev:atkbd:dmi:bvn*:bvr*:bd*:svnDell*:pnArcada:pvr*
>   KEYBOARD_KEY_ea=back
>   KEYBOARD_KEY_e7=refresh
>   KEYBOARD_KEY_d5=full_screen
>   KEYBOARD_KEY_d6=scale

(As I was unfamiliar with `scale`, after pressing it, you see an 
overview of the currently opened windows on the current virtual desktop.)

>   KEYBOARD_KEY_95=brightnessdown
>   KEYBOARD_KEY_91=brightnessup
>   KEYBOARD_KEY_a0=mute
>   KEYBOARD_KEY_ae=volumedown
>   KEYBOARD_KEY_b0=volumeup
>   KEYBOARD_KEY_8b=switchvideomode
>   KEYBOARD_KEY_d8=sleep
>   KEYBOARD_KEY_d4=kbd_layout_next
> 
> (Note that on Chrome OS we are transitioning from F1-F10 being primary
> key codes emitted by the kernel to what we call "action" codes - back,
> refresh, etc).

Thank you, in what Chromium repository is that file? Do you know the 
reason, why these are not upstreamed to udev/systemd?

>> 2.  Wrong caps lock key and function key mappings on Google Chromebook Dell
>> Latitute 5400 Chrome (google/sarien) [2]
> 
> There is no CapsLock on Chromebooks either. We are using "search" or
> "launcher" key which is actually Left Meta in place of CapsLock.

Yes, that is what I described in the bug report.

>> Peter replied, this should be fixed in udev, so it’s not directly related to
>> the Linux kernel, as the Linux kernel exposes the scancodes(?) just fine.
>> But what is the upstream process for this in general? Chromium OS carries
>> `91-chromeos-keyboard.rules` for example.
>>
>> systemd/udev currently has an entry for two Google Chromebook models in
>> `hwdb.d/60-keyboard.hwdb` [4]:
>>
>>      ######################### FIXED MODEL DEVICES #############################
>>      # This section lists devices which require special handling in their key
>>      # code to keysym mapping by setting the xkb model.
>>      # The model must be an xkb compatible model (defined with XKB_FIXED_MODEL).
>>
>>      # Chromebooks
>>      evdev:atkbd:dmi:bvn*:bvr*:bd*:svnHewlett-Packard*:pnFalco:pvr*
>>      evdev:atkbd:dmi:bvn*:bvr*:bd*:svnAcer*:pnPeppy:pvr*
>>       XKB_FIXED_MODEL="chromebook"
> 
> Yes, that is the right place for it. You submit a PR against systemd
> with the new mappings.

 From `/usr/share/X11/xkb/symbols/inet` from *xkb-data* 2.33-1:

```
partial alphanumeric_keys
xkb_symbols "chromebook" {
         include "level3(ralt_switch)"
         key <FK01> {    [ XF86Back ] };
         key <FK02> {    [ XF86Forward ] };
         key <FK03> {    [ XF86Reload ] };
         key <FK04> {    [ F11 ] };
//        key <FK05> {    [ F5, F5, F5, F5 ] }; // Overview key
         key <FK06> {    [ XF86MonBrightnessDown ] };
         key <FK07> {    [ XF86MonBrightnessUp ] };
         key <FK08> {    [ XF86AudioMute ] };
         key <FK09> {    [ XF86AudioLowerVolume ] };
         key <FK10> {    [ XF86AudioRaiseVolume ] };
         key <BKSP> {    [ BackSpace, BackSpace, Delete ] };
         key <UP>   {    [ Up, Up, Prior, Up ] };
         key <DOWN> {    [ Down, Down, Next, Down ] };
         key <LEFT> {    [ Left, Left, Home, Left ] };
         key <RGHT> {    [ Right, Right, End, Right ] };
         key <LWIN> {    [ Super_L, Super_L, Caps_Lock, Super_L ] };
```

This layout is different from the one used on google/sarien. How many 
different layouts are there, and how do you organize them in Chromium OS?

>> The Dell Chromebooks, unfortunately, also use the embedded controller with
>> Dell’s proprietary firmware (Wilco(?)), and not Chrome EC making special
>> handling necessary. `91-chromeos-keyboard.rules` has
>>
>>      # Wilco keyboard (5220W-C) for Chrome OS
>>      SUBSYSTEM=="input", \
>>        ATTRS{idVendor}=="413c", ATTRS{idProduct}=="2510", \
>>        ENV{CROS_KEYBOARD_TOP_ROW_LAYOUT}="3", \
>>        ENV{ID_INPUT_KEYBOARD}="1"
> 
> This is only needed on Chrome OS to let Chrome know how to map the
> "action" scancodes back to F1-F10 when they are chorded with "launcher"
> key. This is Chrome on Chrome OS-specfic behavior and is of no interest
> to other parties.

Thank you for the clarification.


Kind regards,

Paul
