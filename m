Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCA9E5B098D
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Sep 2022 18:04:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230006AbiIGQEP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Sep 2022 12:04:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229817AbiIGQDo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Sep 2022 12:03:44 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B24B8BD13B
        for <linux-kernel@vger.kernel.org>; Wed,  7 Sep 2022 09:02:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1662566518;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mjZOI71LK+daMvClxtX0jgkcMOcguy0S84WVN0vsB8g=;
        b=AU0q7Cnk1V6UYF4tmM54KiAN6B1gtDy9FkFgF6LzCqOOMrPev8mCPcNOtqYl0PvNzFm/L+
        LqRZ4HUyvbbLsATpvLQ5DJAkTvJ3dfrNj8truOYf8AunjMCGqRoLSgfYlVmQCocGq7/fYn
        f2JVAjVvKjxoEPXT12z7UX5z6ssasGM=
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-67-VFPjIzafPiCu2QNdhnYEwg-1; Wed, 07 Sep 2022 12:01:54 -0400
X-MC-Unique: VFPjIzafPiCu2QNdhnYEwg-1
Received: by mail-pg1-f198.google.com with SMTP id h5-20020a636c05000000b00429fa12cb65so7777175pgc.21
        for <linux-kernel@vger.kernel.org>; Wed, 07 Sep 2022 09:01:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:x-gm-message-state:from:to:cc:subject
         :date;
        bh=mjZOI71LK+daMvClxtX0jgkcMOcguy0S84WVN0vsB8g=;
        b=MhdxtF9CdOdpWzwqggtVmil5uBnD5IiRd2d0obv3cOJ8lTtX+DgYI3HSvcKAUVo0WL
         XfoAW9EcFxqBKt2KCfBMQtiSp9075eKDIzXx++MXI+8viaiJ5E6ywNT46eTuY00PceB3
         9z8BQM3bCsle/pyjNeqZeBXSSmF3uhR4fsKnuWrGq14SEryncl6CbQACLXB0BTmIcNbE
         wyUKzAGSohy+DkuerteI15vSQTuNmqF+sEYB6vQLf7ncgiFX/O7DW6fBQqlYflI1xFw6
         yu66jixl7K6DwdEYmfaujowvA/D2d5N3SVpbMv1fFG1qj9S5UJ788zlGfDRFdPf4RyLD
         NUTA==
X-Gm-Message-State: ACgBeo3xYpKs5ZdMJhF8xwmCdPFHFyGycKDh/2y74tSTPJDV33cFlYWy
        HmbHT5KmnBIfNTUsDZDosUyS5298MM+32j+chPjorZCJy1VOrhI2Q59sYWMyaGe2C6+wCsGpHEI
        SAkgD4eJjLtv/NT0FV6ERwWlP
X-Received: by 2002:a17:902:6ac8:b0:175:44b5:5264 with SMTP id i8-20020a1709026ac800b0017544b55264mr4590956plt.19.1662566511557;
        Wed, 07 Sep 2022 09:01:51 -0700 (PDT)
X-Google-Smtp-Source: AA6agR7AVvzae+3cjd7I1Cj1UQggFzwL2WKwIqHj3JQ/I/W3JFAE0SmOXU5px7BUFcsDQeafqZ8w7w==
X-Received: by 2002:a17:902:6ac8:b0:175:44b5:5264 with SMTP id i8-20020a1709026ac800b0017544b55264mr4590923plt.19.1662566511091;
        Wed, 07 Sep 2022 09:01:51 -0700 (PDT)
Received: from localhost ([240d:1a:c0d:9f00:4f2f:926a:23dd:8588])
        by smtp.gmail.com with ESMTPSA id v28-20020aa799dc000000b00536531536adsm12840105pfi.47.2022.09.07.09.01.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Sep 2022 09:01:50 -0700 (PDT)
Date:   Thu, 08 Sep 2022 01:01:47 +0900 (JST)
Message-Id: <20220908.010147.1900257605879402574.syoshida@redhat.com>
To:     almaz.alexandrovich@paragon-software.com
Cc:     ntfs3@lists.linux.dev, linux-kernel@vger.kernel.org,
        syoshida@redhat.com, rdunlap@infradead.org,
        syzbot+35b87c668935bb55e666@syzkaller.appspotmail.com
Subject: Re: [PATCH] fs/ntfs3: Avoid UBSAN error on true_sectors_per_clst()
From:   Shigeru Yoshida <syoshida@redhat.com>
In-Reply-To: <20220823144625.1627736-1-syoshida@redhat.com>
References: <20220823144625.1627736-1-syoshida@redhat.com>
X-Mailer: Mew version 6.8 on Emacs 28.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ping?

On Tue, 23 Aug 2022 23:46:25 +0900, Shigeru Yoshida wrote:
> syzbot reported UBSAN error as below:
> 
> [   76.901829][ T6677] ================================================================================
> [   76.903908][ T6677] UBSAN: shift-out-of-bounds in fs/ntfs3/super.c:675:13
> [   76.905363][ T6677] shift exponent -247 is negative
> 
> This patch avoid this error.
> 
> Link: https://syzkaller.appspot.com/bug?id=b0299c09a14aababf0f1c862dd4ebc8ab9eb0179
> Fixes: a3b774342fa7 (fs/ntfs3: validate BOOT sectors_per_clusters)
> Cc: Author: Randy Dunlap <rdunlap@infradead.org>
> Reported-by: syzbot+35b87c668935bb55e666@syzkaller.appspotmail.com
> Signed-off-by: Shigeru Yoshida <syoshida@redhat.com>
> ---
>  fs/ntfs3/super.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/ntfs3/super.c b/fs/ntfs3/super.c
> index 47012c9bf505..adc4f73722b7 100644
> --- a/fs/ntfs3/super.c
> +++ b/fs/ntfs3/super.c
> @@ -672,7 +672,7 @@ static u32 true_sectors_per_clst(const struct NTFS_BOOT *boot)
>  	if (boot->sectors_per_clusters <= 0x80)
>  		return boot->sectors_per_clusters;
>  	if (boot->sectors_per_clusters >= 0xf4) /* limit shift to 2MB max */
> -		return 1U << (0 - boot->sectors_per_clusters);
> +		return 1U << -(s8)boot->sectors_per_clusters;
>  	return -EINVAL;
>  }
>  
> -- 
> 2.37.2
> 

