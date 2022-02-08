Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D33004AD798
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Feb 2022 12:38:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358993AbiBHLgq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Feb 2022 06:36:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237464AbiBHLXH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Feb 2022 06:23:07 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 60D35C03FEC9
        for <linux-kernel@vger.kernel.org>; Tue,  8 Feb 2022 03:23:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1644319385;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=edM7JDVjtERgfYkxuZCgmW/p1Vp5nVGhJLvorv93djQ=;
        b=XviUcggY03vlWHyZMBM/jkEupoDGu1aQ/Jzs4xf49ObuK0Arw7OIt30cLzZBg71KzJ3JiG
        oNEST0toDz1zFJkRELaGgVRGsO2K4c6CQfrcHlcs6joM283QQCh8WPG4UeQhoB1i357Nev
        gGXcnHOEkxHDtq5OCa8CaEIExqWbIW0=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-26-czsWPJ6iPcKgr7C0jqccSQ-1; Tue, 08 Feb 2022 06:23:04 -0500
X-MC-Unique: czsWPJ6iPcKgr7C0jqccSQ-1
Received: by mail-wm1-f69.google.com with SMTP id bg16-20020a05600c3c9000b0034bea12c043so906667wmb.7
        for <linux-kernel@vger.kernel.org>; Tue, 08 Feb 2022 03:23:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=edM7JDVjtERgfYkxuZCgmW/p1Vp5nVGhJLvorv93djQ=;
        b=RNTHX5pdQQa9fZkhAg7Dt/vKmidE1uZqdd5tZAiUVXW1g1/ha7ZfHQp233Hz2qXpwi
         PBSNrcnmbuPbEgqxaawkYGt6ZUt1Vj2LFXiKGytYD7LlpPDAaVvG/dfy5vkiP8ZJSHhf
         3H7dz4o8wqWWU2btJebhmBXrO7Os4cYxpRmvyZ2OZtQeLF6xjVgqUgqTKGj1doK1ZGhi
         qlotTg9wNGEEu/D1WErivTNosWLF7/h7yq4y+MjQNY6/fIQE+Q7f/t3bWMFmza9F5xJb
         Cp2F42Xr9KmJdXh6vtYjbEefsF7EUiIX0b+m+rBLId2WhlskVjx0wXpuvKdcHLV8OfuL
         URLA==
X-Gm-Message-State: AOAM532HNUjLlYPY69+K/nNXFQjlZeGbvyJ7TblDi8V4Xty9kVDpJ93O
        1jeWXAyAwGHgXn0g1OomLDG2X2luWo0lwibxGkK0BESIkN5iWBecH28gQRgakcUnJaCQfTQfG4B
        GZDG/Dt4MIC61+DwdAc7b68ui
X-Received: by 2002:a5d:6d85:: with SMTP id l5mr3062010wrs.129.1644319383033;
        Tue, 08 Feb 2022 03:23:03 -0800 (PST)
X-Google-Smtp-Source: ABdhPJz9TF+OHMeiCMsJIdPvQrmYFcFIZ9euYh42L+d8/rEgpS+CimvW/tTNsLrdZ0MmzavEaWHnaQ==
X-Received: by 2002:a5d:6d85:: with SMTP id l5mr3061995wrs.129.1644319382867;
        Tue, 08 Feb 2022 03:23:02 -0800 (PST)
Received: from ?IPv6:2a0c:5a80:1204:1500:37e7:8150:d9df:36f? ([2a0c:5a80:1204:1500:37e7:8150:d9df:36f])
        by smtp.gmail.com with ESMTPSA id g22sm1776197wmh.7.2022.02.08.03.23.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Feb 2022 03:23:02 -0800 (PST)
Message-ID: <b8da5fe94d200b5a282f1246ccd585dc2d6f5785.camel@redhat.com>
Subject: Re: [PATCH 1/6] drivers/mfd: sensehat: Add Raspberry Pi Sense HAT
 to simple_mfd_i2c
From:   Nicolas Saenz Julienne <nsaenzju@redhat.com>
To:     Charles Mirabile <cmirabil@redhat.com>,
        linux-kernel@vger.kernel.org
Cc:     Serge Schneider <serge@raspberrypi.org>,
        Stefan Wahren <stefan.wahren@i2se.com>,
        Mattias Brugger <mbrugger@suse.com>,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, fedora-rpi@googlegroups.com,
        Lee Jones <lee.jones@linaro.org>,
        Mwesigwa Guma <mguma@redhat.com>,
        Joel Savitz <jsavitz@redhat.com>
Date:   Tue, 08 Feb 2022 12:23:01 +0100
In-Reply-To: <20220203002521.162878-2-cmirabil@redhat.com>
References: <20220203002521.162878-1-cmirabil@redhat.com>
         <20220203002521.162878-2-cmirabil@redhat.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.3 (3.42.3-1.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2022-02-02 at 19:25 -0500, Charles Mirabile wrote:
> This patch adds the compatible string for the Sense HAT device to
> the list of compatible strings in the simple_mfd_i2c driver so that
> it can match against the device and load its children and their drivers
> 
> Co-developed-by: Mwesigwa Guma <mguma@redhat.com>
> Signed-off-by: Mwesigwa Guma <mguma@redhat.com>
> Co-developed-by: Joel Savitz <jsavitz@redhat.com>
> Signed-off-by: Joel Savitz <jsavitz@redhat.com>
> Signed-off-by: Charles Mirabile <cmirabil@redhat.com>
> ---
>  drivers/mfd/simple-mfd-i2c.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/mfd/simple-mfd-i2c.c b/drivers/mfd/simple-mfd-i2c.c
> index 51536691ad9d..f916a9c84563 100644
> --- a/drivers/mfd/simple-mfd-i2c.c
> +++ b/drivers/mfd/simple-mfd-i2c.c
> @@ -64,6 +64,7 @@ static int simple_mfd_i2c_probe(struct i2c_client *i2c)
>  
>  static const struct of_device_id simple_mfd_i2c_of_match[] = {
>  	{ .compatible = "kontron,sl28cpld" },
> +	{ .compatible = "raspberrypi,sensehat" },

Nice!

>  	{}
>  };
>  MODULE_DEVICE_TABLE(of, simple_mfd_i2c_of_match);

-- 
Nicolás Sáenz

