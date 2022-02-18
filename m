Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 392B94BB2B5
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Feb 2022 07:52:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231690AbiBRGxG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Feb 2022 01:53:06 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:42182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231190AbiBRGxC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Feb 2022 01:53:02 -0500
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26BD064EC;
        Thu, 17 Feb 2022 22:52:44 -0800 (PST)
Received: by mail-pf1-x434.google.com with SMTP id g1so1634885pfv.1;
        Thu, 17 Feb 2022 22:52:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=4kxvlRun+Imi9T/nP5g/X9NLUQYTYZxhlZYumdyAvBY=;
        b=ZvaWixAWWeNFmXqUn0DD6pmgM0YVqKRD3E380dJ8UrI8Em+p2LQuSJesUn4PMjyMcq
         jlhgnFdZkzoQK4TuwaJL2Ge75dFcOPEBoFPaYptKFyqtjRtUhxz4duKFHIB64KnPlQBn
         NfQ6S2/4h+bbxVnDTyYMqm9OZwrMk/KB2GHgQBYGemghPc9L8QfIbxe81q1LmiiY6jhZ
         gsIJpfy8sYfQbL2R1ZtMqjrTptKTKPUk1rMHrX3pCAd+olyghr3sVDxVxi0jh/lk8UBJ
         cezzOofyuBj2PecLwxbsPOn28iZLi8BKOudstllxt1US2PgJ9c2wDluSGqoZSG6g8gfv
         FWlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=4kxvlRun+Imi9T/nP5g/X9NLUQYTYZxhlZYumdyAvBY=;
        b=A3MVxqgZcaG9fk1BtKAiIE3VwDApSIj1Y+QO2YMyBJZt0vE/ntLSvYDazZ3hlnPYtN
         shinDwkV+SftNXPb/UN7oP8AwKdrPTd62FwMa4IyRW6s5kNquuL083fO2dbM2V0KXZDw
         yklrAdxxROZt2nHagwtMM2m3i8zaD2y43EWXnpeQmOJ129cuteHStrKIyRYEG4h50f+K
         0xGAwAFiaw9VRYDDSig2jfKRCkkPzowS+ZN+ecEQCNR1sXz0FO0J2PtUAvIqxa4I6vht
         SwyBOfqVnLE8vnx4jL52ZSBl6DJkwbOnzIrX6Z/FGrtV23MWF+iJG/7KeotBUtl0JiWn
         gOUA==
X-Gm-Message-State: AOAM532jojuMJzdvO+PlUtbADWIlg9eoArD+YiSxAaW4W+e6NTsdm1r0
        sAkwBFhYLm2Zl3jDfl2zuk9khKOiI94=
X-Google-Smtp-Source: ABdhPJzJxCOiRb8MJiHYObMQ3guEwDZo7mdXJiKZM+q5hMQdrnJFrlT2oS4cZKQ9lzHf08Ohul5vYA==
X-Received: by 2002:a63:8bc9:0:b0:365:3b6:47fb with SMTP id j192-20020a638bc9000000b0036503b647fbmr5216443pge.147.1645167163870;
        Thu, 17 Feb 2022 22:52:43 -0800 (PST)
Received: from google.com ([2620:15c:202:201:9800:6e8c:a0db:87e7])
        by smtp.gmail.com with ESMTPSA id a29sm9716273pgl.24.2022.02.17.22.52.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Feb 2022 22:52:42 -0800 (PST)
Date:   Thu, 17 Feb 2022 22:52:40 -0800
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     William Mahon <wmahon@chromium.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        William Mahon <wmahon@google.com>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Jiri Kosina <jikos@kernel.org>, linux-input@vger.kernel.org
Subject: Re: [PATCH v2] HID: Add mapping for KEY_DICTATE
Message-ID: <Yg9CODr8mR99+EVO@google.com>
References: <20220218015136.1.I5dbf50eb1a7a6734ee727bda4a8573358c6d3ec0@changeid>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220218015136.1.I5dbf50eb1a7a6734ee727bda4a8573358c6d3ec0@changeid>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 18, 2022 at 01:51:45AM +0000, William Mahon wrote:
> Numerous keyboards are adding dictate keys which allows for text
> messages to be dicated by a microphone.
> 
> This patch adds a new key definition KEY_DICTATE and maps 0x0c/0x0d8
> usage code to this new keycode. Additionally hid-debug is adjusted to
> recognize this new usage code as well.
> 
> Signed-off-by: William Mahon <wmahon@google.com>
> ---
> 
>  drivers/hid/hid-debug.c                | 1 +
>  drivers/hid/hid-input.c                | 1 +
>  include/uapi/linux/input-event-codes.h | 2 ++
>  3 files changed, 4 insertions(+)
> 
> diff --git a/drivers/hid/hid-debug.c b/drivers/hid/hid-debug.c
> index 26c31d759914..8aa68416b1d7 100644
> --- a/drivers/hid/hid-debug.c
> +++ b/drivers/hid/hid-debug.c
> @@ -969,6 +969,7 @@ static const char *keys[KEY_MAX + 1] = {
>  	[KEY_ASSISTANT] = "Assistant",
>  	[KEY_KBD_LAYOUT_NEXT] = "KbdLayoutNext",
>  	[KEY_EMOJI_PICKER] = "EmojiPicker",
> +	[KEY_DICTATE] = "Dictate",
>  	[KEY_BRIGHTNESS_MIN] = "BrightnessMin",
>  	[KEY_BRIGHTNESS_MAX] = "BrightnessMax",
>  	[KEY_BRIGHTNESS_AUTO] = "BrightnessAuto",
> diff --git a/drivers/hid/hid-input.c b/drivers/hid/hid-input.c
> index 112901d2d8d2..ce2b75a67cb8 100644
> --- a/drivers/hid/hid-input.c
> +++ b/drivers/hid/hid-input.c
> @@ -992,6 +992,7 @@ static void hidinput_configure_usage(struct hid_input *hidinput, struct hid_fiel
>  		case 0x0cd: map_key_clear(KEY_PLAYPAUSE);	break;
>  		case 0x0cf: map_key_clear(KEY_VOICECOMMAND);	break;
>  
> +		case 0x0d8: map_key_clear(KEY_DICTATE);		break;
>  		case 0x0d9: map_key_clear(KEY_EMOJI_PICKER);	break;
>  
>  		case 0x0e0: map_abs_clear(ABS_VOLUME);		break;
> diff --git a/include/uapi/linux/input-event-codes.h b/include/uapi/linux/input-event-codes.h
> index 225ec87d4f22..9aa994cbcd60 100644
> --- a/include/uapi/linux/input-event-codes.h
> +++ b/include/uapi/linux/input-event-codes.h
> @@ -660,6 +660,8 @@
>  /* Select an area of screen to be copied */
>  #define KEY_SELECTIVE_SCREENSHOT	0x27a
>  
> +#define KEY_DICTATE			0x27b

Please use 0x24a keycode, move after KEY_EMOJI_PICKER definition, and
add a comment:

/* Start or Stop Voice Dictation Session (HUTRR99) */

Thanks.

-- 
Dmitry
