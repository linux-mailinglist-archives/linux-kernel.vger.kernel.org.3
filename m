Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39D8B4C851F
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Mar 2022 08:28:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232440AbiCAH24 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Mar 2022 02:28:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229667AbiCAH2z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Mar 2022 02:28:55 -0500
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FEBD3F336;
        Mon, 28 Feb 2022 23:28:14 -0800 (PST)
Received: by mail-pg1-x52e.google.com with SMTP id 195so13721403pgc.6;
        Mon, 28 Feb 2022 23:28:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=cp8fbBANLe0K+M1kpWxlR+LeRW3CNaTx+3mtH3zcvek=;
        b=IBfxRmNwbTnjq5JlHr8h62F6vQiGrQMdo+l/QD8OKKsUMkkwGZbIIHNbJiVswDDTAL
         v33TnJcESYWOvVH5kdiPP4RTBHsp4x9x3tW6VihhoJEEabvAvsc9b/mJRYbTBRzBLE8X
         GHfVIe+xt0gjC5mQ4PhFeVN08cGtZACQMu85M3nA9pJGkf7jenztRj71cHDAxk1RB+E6
         DdFVihVxlAjDoh4PMgh75Pg+YaRtAYN/vpQC+wj8BvF4W+AHTKpzApD9Bo5MIH0gtAOe
         S+GMrBVaWm4aALk8G5dyGVNute1r6zqKfBDotEmfZTMiXlvwo/a+tnz6Fygr66tZQDqM
         ufRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=cp8fbBANLe0K+M1kpWxlR+LeRW3CNaTx+3mtH3zcvek=;
        b=HBEJugg3bv+8VIuLSkgJZu7Cbx2b23rZPzJ2X9qLvdFHrhmv/eoT8//+HVZEiOaPM+
         atWUj++Jjr3+wfJaIf5+AWBIT0PGnCQrm5Kmq1k1K2qL2IQzFJbAkYoUVVij5WmVbSTG
         K7p1zf1QmjEsS9Hr/Tepal4dmv02xsXCOgHnG5molaYty7t0kWMn4PO8nuDohjcv7vN2
         rqHtqyQtQOOahoBu/26Mh2+HHut6A7rJf55Udyx+yasBTT4C3Av5QsmEi+9d4s0TpnGz
         CXzECmhwWk+hQUBihdcGsfUVKYscjgNLLb/s6XdCgrHS4MrW8F8CrJGhOVwbh9YibnCm
         7adg==
X-Gm-Message-State: AOAM533Whlu3jatsmpDGypfZ8UkkRuGQTTJq7/7d5qIVtrHkd/BCl6Op
        uAreqtizbbUl2dksfbrMZvxxrEc0U2M=
X-Google-Smtp-Source: ABdhPJz2JKov9sS2w/kDuZlSupNbrPEYGSG9l9r6ou9CKbXjNHTYJ17AjYuv7PSJZmrIhEVgXDc/fA==
X-Received: by 2002:a05:6a00:1709:b0:4c8:42df:c87c with SMTP id h9-20020a056a00170900b004c842dfc87cmr25985526pfc.5.1646119694015;
        Mon, 28 Feb 2022 23:28:14 -0800 (PST)
Received: from google.com ([2620:15c:202:201:c174:264:5e49:f2cb])
        by smtp.gmail.com with ESMTPSA id c18-20020a056a00249200b004df81f5ab5dsm16637715pfv.173.2022.02.28.23.28.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Feb 2022 23:28:13 -0800 (PST)
Date:   Mon, 28 Feb 2022 23:28:11 -0800
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     William Mahon <wmahon@chromium.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        William Mahon <wmahon@google.com>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Jiri Kosina <jikos@kernel.org>, linux-input@vger.kernel.org
Subject: Re: [PATCH v3] HID: Add mapping for KEY_DICTATE
Message-ID: <Yh3LC8WtLdgQNyQI@google.com>
References: <20220218215531.1.I5dbf50eb1a7a6734ee727bda4a8573358c6d3ec0@changeid>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220218215531.1.I5dbf50eb1a7a6734ee727bda4a8573358c6d3ec0@changeid>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 18, 2022 at 09:59:08PM +0000, William Mahon wrote:
> Numerous keyboards are adding dictate keys which allows for text
> messages to be dictated by a microphone.
> 
> This patch adds a new key definition KEY_DICTATE and maps 0x0c/0x0d8
> usage code to this new keycode. Additionally hid-debug is adjusted to
> recognize this new usage code as well.

Jiri, Benjamin, OK for me to pick it up?

> 
> Signed-off-by: William Mahon <wmahon@google.com>
> ---
> 
>  drivers/hid/hid-debug.c                | 1 +
>  drivers/hid/hid-input.c                | 1 +
>  include/uapi/linux/input-event-codes.h | 1 +
>  3 files changed, 3 insertions(+)
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
> index 225ec87d4f22..4db5d41848e4 100644
> --- a/include/uapi/linux/input-event-codes.h
> +++ b/include/uapi/linux/input-event-codes.h
> @@ -612,6 +612,7 @@
>  #define KEY_ASSISTANT		0x247	/* AL Context-aware desktop assistant */
>  #define KEY_KBD_LAYOUT_NEXT	0x248	/* AC Next Keyboard Layout Select */
>  #define KEY_EMOJI_PICKER	0x249	/* Show/hide emoji picker (HUTRR101) */
> +#define KEY_DICTATE		0x24a	/* Start or Stop Voice Dictation Session (HUTRR99) */
>  
>  #define KEY_BRIGHTNESS_MIN		0x250	/* Set Brightness to Minimum */
>  #define KEY_BRIGHTNESS_MAX		0x251	/* Set Brightness to Maximum */
> -- 
> 2.35.1.473.g83b2b277ed-goog
> 

-- 
Dmitry
