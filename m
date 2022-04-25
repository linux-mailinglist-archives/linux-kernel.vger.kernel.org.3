Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7EC550D7DA
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 05:48:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240437AbiDYDun (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Apr 2022 23:50:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240634AbiDYDu2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Apr 2022 23:50:28 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A71D3B9;
        Sun, 24 Apr 2022 20:47:07 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id b15so13647129pfm.5;
        Sun, 24 Apr 2022 20:47:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=7VhljdC5qfgvF8YkpQHi5caMI2K36nYGNnMwDGsYTi4=;
        b=PLJQOMoBO2sR0lbBytKX+x7YhWEmudhd6tkz1e0TrsQQhULjx++oJMZBbvkoeraHC9
         GXOUe7XeiXg7WQmzb/Fzq4r99noiAAr0b0tTsPq3Lh0YDE/MZ1NBHrmLsjmY99IVxQYI
         Xswdw1cHjnQ4CDHMUELJV4e5TBeJfxk4PwnASI+dq80Yt4WoV0GRfacTgWJ0Dpxjomz7
         nReMFscLp28UFfVU3cr0iigUYQW4CFOGqds+ZPAA5bhvfN5yyymEhSXQxzeKO/gr9tAj
         vgyWi/BsG6EE7zzSBSID0RLUYb01vRZqkQq5lJ/T2eBKcXAhl7oxG1milmieGth+opj8
         svZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=7VhljdC5qfgvF8YkpQHi5caMI2K36nYGNnMwDGsYTi4=;
        b=51a6EkVmrIxzqD+OJLUcDew/aypCd6hktYcrfxaf0dT/uXfmQye2sKy6mNXFFKjY3D
         oHSFNbkuIayFMzScsq3XNnaFiQHtQeggQPocwyO2nogvcltdea1H/794nvynH9TST9s/
         jsqb5Q7T11hcyOXeTHhicNJssv1dPdCmNJeWktt15HfgImePgIiUwIvcwKni6zSBpZEz
         0+cly4eeNm+ZUQS25fFPrJlQUqbjqvilvzljDlZdVCcswILWpyaXyHeSImSkoKt1i29w
         jD5TbyWQHSfOGN0hS+FJK+Oa5g0XLhhipjzRa6SOJANrhgMCYd+cfEuWvoUGm/FtkIuC
         1aWg==
X-Gm-Message-State: AOAM5326DNYJxSc82fBK/oUAqa7GKrKXpFkV6CNZ3Ad/vfztj+D0wLLH
        HicmD/Rr6z2Rp7N9EF6ZVE4=
X-Google-Smtp-Source: ABdhPJyzITr4L56y2maJflc4flrw3rp7brBf35hCOREn6LkiCOJKjLCoM5NRBv3jnt8R81I7BCISGA==
X-Received: by 2002:a05:6a00:856:b0:50a:431b:c298 with SMTP id q22-20020a056a00085600b0050a431bc298mr16683814pfk.75.1650858426733;
        Sun, 24 Apr 2022 20:47:06 -0700 (PDT)
Received: from google.com ([2620:15c:202:201:282a:d50e:e0fc:c145])
        by smtp.gmail.com with ESMTPSA id 9-20020a631449000000b003aabd688921sm8025285pgu.13.2022.04.24.20.47.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Apr 2022 20:47:05 -0700 (PDT)
Date:   Sun, 24 Apr 2022 20:47:03 -0700
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     linux-kernel@vger.kernel.org, patches@lists.linux.dev,
        linux-input@vger.kernel.org, chrome-platform@lists.linux.dev,
        Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        Douglas Anderson <dianders@chromium.org>,
        Hsin-Yi Wang <hsinyi@chromium.org>
Subject: Re: [PATCH 1/2] Input: cros-ec-keyb: Only register keyboard if
 rows/columns exist
Message-ID: <YmYZt7WQC17aE1fS@google.com>
References: <20220413033334.1514008-1-swboyd@chromium.org>
 <20220413033334.1514008-2-swboyd@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220413033334.1514008-2-swboyd@chromium.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stephen,

On Tue, Apr 12, 2022 at 08:33:33PM -0700, Stephen Boyd wrote:
> If the device is a detachable, we may still probe this device because
> there are some button switches, e.g. volume buttons and power buttons,
> registered by this driver. Let's allow the device node to be missing row
> and column device properties to indicate that the keyboard matrix
> shouldn't be registered. This removes an input device on Trogdor devices
> such as Wormdingler that don't have a matrix keyboard, but still have
> power and volume buttons. That helps userspace understand there isn't
> a keyboard present when the detachable keyboard is disconnected.
> 
> Cc: Benson Leung <bleung@chromium.org>
> Cc: Guenter Roeck <groeck@chromium.org>
> Cc: Douglas Anderson <dianders@chromium.org>
> Cc: Hsin-Yi Wang <hsinyi@chromium.org>
> Signed-off-by: Stephen Boyd <swboyd@chromium.org>
> ---
> 
> I tried to use mkbp info to query the number of rows and columns, but my
> EC firmware doesn't have commit 8505881ed0b9 ("mkbp: Separate MKBP_INFO
> host command from the keyboard driver") so it always returns 8 and 13
> for the rows and columns. Sigh. With updated firmware we could query it,
> or we could rely on DT like we do already.
> 
> Originally I was setting the properties to 0, but
> matrix_keypad_parse_properties() spits out an error message in that case
> and so it seems better to delete the properties and check for their
> existence instead. Another alternative would be to change the compatible
> to be "google,cros-ec-keyb-switches" or something that indicates there
> are only switches and no matrix keyboard.
> 
>  drivers/input/keyboard/cros_ec_keyb.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/drivers/input/keyboard/cros_ec_keyb.c b/drivers/input/keyboard/cros_ec_keyb.c
> index 6534dfca60b4..ac9a953bff02 100644
> --- a/drivers/input/keyboard/cros_ec_keyb.c
> +++ b/drivers/input/keyboard/cros_ec_keyb.c
> @@ -537,6 +537,15 @@ static int cros_ec_keyb_register_matrix(struct cros_ec_keyb *ckdev)
>  	u32 key_pos;
>  	unsigned int row, col, scancode, n_physmap;
>  
> +	/*
> +	 * No rows and columns? There isn't a matrix but maybe there are
> +	 * switches to register in cros_ec_keyb_register_bs() because this is a
> +	 * detachable device.
> +	 */
> +	if (!device_property_read_bool(dev, "keypad,num-rows") &&
> +	    !device_property_read_bool(dev, "keypad,num-cols"))

Why are we abusing device_property_read_bool() for properties that are
not flags instead of using device_property_present()?

> +		return 0;
> +
>  	err = matrix_keypad_parse_properties(dev, &ckdev->rows, &ckdev->cols);
>  	if (err)
>  		return err;
> -- 
> https://chromeos.dev
> 

Thanks.

-- 
Dmitry
