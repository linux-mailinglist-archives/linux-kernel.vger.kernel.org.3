Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 973074B9D8A
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Feb 2022 11:48:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239078AbiBQKsv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Feb 2022 05:48:51 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:41998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230033AbiBQKsu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 05:48:50 -0500
Received: from mslow1.mail.gandi.net (mslow1.mail.gandi.net [217.70.178.240])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 505581ED1DB;
        Thu, 17 Feb 2022 02:48:35 -0800 (PST)
Received: from relay10.mail.gandi.net (unknown [IPv6:2001:4b98:dc4:8::230])
        by mslow1.mail.gandi.net (Postfix) with ESMTP id 8FCBAC5625;
        Thu, 17 Feb 2022 10:35:31 +0000 (UTC)
Received: (Authenticated sender: hadess@hadess.net)
        by mail.gandi.net (Postfix) with ESMTPSA id 08D12240006;
        Thu, 17 Feb 2022 10:35:24 +0000 (UTC)
Message-ID: <93e5dc0bbeb0b44c9b225946b3ab81d3af3a1789.camel@hadess.net>
Subject: Re: [PATCH] HID: Add mapping for KEY_APP_LAUNCHER
From:   Bastien Nocera <hadess@hadess.net>
To:     William Mahon <wmahon@chromium.org>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     William Mahon <wmahon@google.com>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Jiri Kosina <jikos@kernel.org>, linux-input@vger.kernel.org
Date:   Thu, 17 Feb 2022 11:35:24 +0100
In-Reply-To: <20220217053354.1.I3a7746ad05d270161a18334ae06e3b6db1a1d339@changeid>
References: <20220217053354.1.I3a7746ad05d270161a18334ae06e3b6db1a1d339@changeid>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.3 (3.42.3-1.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2022-02-17 at 05:33 +0000, William Mahon wrote:
> The App Launcher key is used to bring up the Launcher menu.
> 
> This patch adds a new key definition KEY_APP_LAUNCHER and maps
> 0x0c02a28
 
Is this a typo? It's not the same format as in your other patch.

KEY_DASHBOARD as used in the Mac keyboard drivers looks like a good
match for KEY_APP_LAUNCHER. If not, it would be good to explain why in
the commit message.

See 437184ae8bd1ef923a40b009e37801deae66ad55 for the KEY_DASHBOARD
addition.

> usage code to this new keycode. Additionally hid-debug is adjusted to
> recognize this new usage code as well.
> 
> Signed-off-by: William Mahon <wmahon@google.com>
> ---
> 
>  drivers/hid/hid-debug.c                | 1 +
>  drivers/hid/hid-input.c                | 2 ++
>  include/uapi/linux/input-event-codes.h | 2 ++
>  3 files changed, 5 insertions(+)
> 
> diff --git a/drivers/hid/hid-debug.c b/drivers/hid/hid-debug.c
> index 01135713e8f9..36a42ad3b7bc 100644
> --- a/drivers/hid/hid-debug.c
> +++ b/drivers/hid/hid-debug.c
> @@ -930,6 +930,7 @@ static const char *keys[KEY_MAX + 1] = {
>         [KEY_SCREENSAVER] = "ScreenSaver",
>         [KEY_VOICECOMMAND] = "VoiceCommand",
>         [KEY_EMOJI_PICKER] = "EmojiPicker",
> +       [KEY_APP_LAUNCHER] = "AppLauncher",
>         [KEY_BRIGHTNESS_MIN] = "BrightnessMin",
>         [KEY_BRIGHTNESS_MAX] = "BrightnessMax",
>         [KEY_BRIGHTNESS_AUTO] = "BrightnessAuto",
> diff --git a/drivers/hid/hid-input.c b/drivers/hid/hid-input.c
> index eccd89b5ea9f..7c89260826b2 100644
> --- a/drivers/hid/hid-input.c
> +++ b/drivers/hid/hid-input.c
> @@ -1162,6 +1162,8 @@ static void hidinput_configure_usage(struct
> hid_input *hidinput, struct hid_fiel
>  
>                 case 0x29d:
> map_key_clear(KEY_KBD_LAYOUT_NEXT); break;
>  
> +               case 0x2a2:
> map_key_clear(KEY_APP_LAUNCHER);    break;
> +
>                 case 0x2c7:
> map_key_clear(KEY_KBDINPUTASSIST_PREV);             break;
>                 case 0x2c8:
> map_key_clear(KEY_KBDINPUTASSIST_NEXT);             break;
>                 case 0x2c9:
> map_key_clear(KEY_KBDINPUTASSIST_PREVGROUP);                break;
> diff --git a/include/uapi/linux/input-event-codes.h
> b/include/uapi/linux/input-event-codes.h
> index 311a57f3e01a..fdf43cf14125 100644
> --- a/include/uapi/linux/input-event-codes.h
> +++ b/include/uapi/linux/input-event-codes.h
> @@ -651,6 +651,8 @@
>  #define KEY_DATA                       0x277
>  #define KEY_ONSCREEN_KEYBOARD          0x278
>  
> +#define KEY_APP_LAUNCHER               0x27c
> +
>  #define BTN_TRIGGER_HAPPY              0x2c0
>  #define BTN_TRIGGER_HAPPY1             0x2c0
>  #define BTN_TRIGGER_HAPPY2             0x2c1

