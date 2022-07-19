Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C401557A365
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 17:43:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238334AbiGSPny (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jul 2022 11:43:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238235AbiGSPnw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 11:43:52 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CE335887C
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jul 2022 08:43:50 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id r2so21190425wrs.3
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jul 2022 08:43:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=NmXXZtQUscROskShGi5ApQFRMHLTFbjS4HwuHMm/I84=;
        b=pvlVbngw6KM3g6upOOZBcEY149F2PuDNOaFSzXUboE6byqwEefNRQAIGWTtSayWmw2
         bl7nn0yfmvFF1YYdAmR2zXDMpXPuDsp/fEYxVbuUPBe07DsGLdJFo1NkQbJ5NftynTl9
         MmpSOoqmb6+trpjJJdUSjDTjA3ACTzJP+bH7XdGZkE3xRsCm3SK0684JrxbiVFqgUwsQ
         1Wj7bYjYRieoASOpK48o327G2B1FgkSxpUdxlob2HGS38S5rhxUhcNV8YaG8pRkHS2MK
         T77j91Q1HXiiHNZXUoCUtm3UD6kLGRXMOKqbTn4y9pdEDFN5Ai+YE9nJtuOFADuw2kK2
         N0zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=NmXXZtQUscROskShGi5ApQFRMHLTFbjS4HwuHMm/I84=;
        b=UXl6FaFHoLpyacsqwvUSTV4fQi3ONuR8Cf3eIx8GEFXlYVf65LYFUHb5BIwsyLOi6g
         REmE1Rkjj0env+V2hrFkU08ssw4sm2hO5KMhXysY6h6guPfRC6DDbMi2XFv7tniwHshd
         WUdKzwB0AgbMaI9L1Qa7DbwC5wboN2sBP5lTGl/xf+9S36B2LypEpPHazoYfDkpySoCL
         bt1zV0hRdGpw4BB6OYgc7IfQ4sMHanqknaALXG2qBGRaBv7dctjsdrYgM6JNuI9eH+3d
         ndhQSeXC8hOM3nUrs+FWOd8uIHU7iGUalsBacz5Sj3B/hbIBt1dm1rl+rsFRCS0br3QP
         j7fA==
X-Gm-Message-State: AJIora/Cg8ryA4QzYQSjLiOlSwGpDGtGO4iLAqW9dOHsQ3GU7OpJdHMv
        L7CCegDBSRXlAKS0SQp9G4h32xbJR0eiWw==
X-Google-Smtp-Source: AGRyM1uzotpcXAdt14sD1BYa+k/svbItICtU/qB9rEDhsWagU8ivEogigo5szlDrZY/oUXRcykTFzA==
X-Received: by 2002:a5d:6c62:0:b0:21d:c697:87f2 with SMTP id r2-20020a5d6c62000000b0021dc69787f2mr20419150wrz.283.1658245428578;
        Tue, 19 Jul 2022 08:43:48 -0700 (PDT)
Received: from google.com (cpc155339-bagu17-2-0-cust87.1-3.cable.virginm.net. [86.27.177.88])
        by smtp.gmail.com with ESMTPSA id f7-20020a7bcd07000000b003a02cbf862esm19122568wmj.13.2022.07.19.08.43.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Jul 2022 08:43:48 -0700 (PDT)
Date:   Tue, 19 Jul 2022 16:43:45 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     linux-kernel@vger.kernel.org, Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        linux-input@vger.kernel.org
Subject: Re: [PATCH 1/1] HID: steam: Prevent NULL pointer dereference in
 steam_{recv,send}_report
Message-ID: <YtbRMUSa8KyOtd1x@google.com>
References: <20220708074009.621113-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220708074009.621113-1-lee.jones@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 08 Jul 2022, Lee Jones wrote:

> It is possible for a malicious device to forgo submitting a Feature
> Report.  The HID Steam driver presently makes no prevision for this
> and de-references the 'struct hid_report' pointer obtained from the
> HID devices without first checking its validity.  Let's change that.
> 
> Cc: Jiri Kosina <jikos@kernel.org>
> Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>
> Cc: linux-input@vger.kernel.org
> Fixes: c164d6abf3841 ("HID: add driver for Valve Steam Controller")
> Signed-off-by: Lee Jones <lee.jones@linaro.org>
> ---
>  drivers/hid/hid-steam.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)

Did anyone get a chance to look at this?

Would you like me to submit a [RESEND]?

> diff --git a/drivers/hid/hid-steam.c b/drivers/hid/hid-steam.c
> index a3b151b29bd71..fc616db4231bb 100644
> --- a/drivers/hid/hid-steam.c
> +++ b/drivers/hid/hid-steam.c
> @@ -134,6 +134,11 @@ static int steam_recv_report(struct steam_device *steam,
>  	int ret;
>  
>  	r = steam->hdev->report_enum[HID_FEATURE_REPORT].report_id_hash[0];
> +	if (!r) {
> +		hid_err(steam->hdev, "No HID_FEATURE_REPORT submitted -  nothing to read\n");
> +		return -EINVAL;
> +	}
> +
>  	if (hid_report_len(r) < 64)
>  		return -EINVAL;
>  
> @@ -165,6 +170,11 @@ static int steam_send_report(struct steam_device *steam,
>  	int ret;
>  
>  	r = steam->hdev->report_enum[HID_FEATURE_REPORT].report_id_hash[0];
> +	if (!r) {
> +		hid_err(steam->hdev, "No HID_FEATURE_REPORT submitted -  nothing to read\n");
> +		return -EINVAL;
> +	}
> +
>  	if (hid_report_len(r) < 64)
>  		return -EINVAL;
>  

-- 
Lee Jones [李琼斯]
Principal Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
