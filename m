Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31E5C520DE6
	for <lists+linux-kernel@lfdr.de>; Tue, 10 May 2022 08:32:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237141AbiEJGgd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 May 2022 02:36:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237123AbiEJGgb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 May 2022 02:36:31 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 88F172265DE
        for <linux-kernel@vger.kernel.org>; Mon,  9 May 2022 23:32:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1652164353;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=a3h5h7vFFNlEkouniwaXqhbwXvv2DW4g4x627EWieto=;
        b=OiUwloX2ZgjGQ72MHKT6JrdAoLZ8Z0c+W/JQTET+mxhDvkr/0/N0Dq1Kuqi1v5L4C3adUP
        37tVCvwF6zsdrcsw3UjbXWqBYqKwgIw46G02tk8gHJnnVdJ2h+reExa1tsIdwDuu1zni1c
        H9QsDN/bvu5HFd+Xw47uToQJ7N+HW5E=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-267-miO6wHJWN--cceZldgnQfw-1; Tue, 10 May 2022 02:32:32 -0400
X-MC-Unique: miO6wHJWN--cceZldgnQfw-1
Received: by mail-qt1-f197.google.com with SMTP id d8-20020a05622a05c800b002f3bb450e94so12312762qtb.2
        for <linux-kernel@vger.kernel.org>; Mon, 09 May 2022 23:32:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=a3h5h7vFFNlEkouniwaXqhbwXvv2DW4g4x627EWieto=;
        b=i1imLcXpclFmJ7Qm2BzNV590Gm3LvD03qvDaPsfRxjNFNGK2dk8tffmJ/bTRzyvY9T
         +DpkAOlZGsMSztTBRQEBmoN/e446CwnYqG0cG88Obx1PsBiYaMLrmyDB1QGmmsTNs3n0
         H+aMoEmA3I2ykDVL8fX8+MYHNXPOfOlzQc/Iz3Md6LnuGPVArmEl7qb7QgYx2kk+TpsB
         PiTUPYU8DTI6vy4d6WBf7ML1nqHfFI0UN76JsVfkroxOcQvzpo1oi9o6ciVnCxMwLYAn
         UeS6i1Lxsw9dlyyn5lVI8BPoStf5+VuVML74yGNDWBKeJu9x4kmMisXhe+7xcnDQ4nA6
         r0jg==
X-Gm-Message-State: AOAM531b9Rb6PTdTGNnfA+hrtLaidNXXFN5fM7SFHRXrD7TAWiSNQOXr
        wPZxfWzPzFiS4UbV/PisVu9cL3haatqHFN+EZlTYMHfk/xbRFlIo6OcqoM1hXWG0RznVaT9mCEv
        ALV2cRFayf1EpJ/1knWV6fua1
X-Received: by 2002:a05:620a:71a:b0:6a0:15d6:60cc with SMTP id 26-20020a05620a071a00b006a015d660ccmr14022726qkc.413.1652164351027;
        Mon, 09 May 2022 23:32:31 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyCznRrStrZANhqjTjRkWY2UTyw291k+9lD6DNcirlWqCKs5lhcy8i5x30DpJuXS3vWIlTlQg==
X-Received: by 2002:a05:620a:71a:b0:6a0:15d6:60cc with SMTP id 26-20020a05620a071a00b006a015d660ccmr14022721qkc.413.1652164350778;
        Mon, 09 May 2022 23:32:30 -0700 (PDT)
Received: from zlang-mailbox ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id c65-20020a379a44000000b0069fc13ce1eesm8315164qke.31.2022.05.09.23.32.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 May 2022 23:32:30 -0700 (PDT)
Date:   Tue, 10 May 2022 14:32:23 +0800
From:   Zorro Lang <zlang@redhat.com>
To:     Ojaswin Mujoo <ojaswin@linux.ibm.com>
Cc:     fstests@vger.kernel.org, riteshh@linux.ibm.com,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] common/rc: Modify _require_batched_discard to improve
 test coverage
Message-ID: <20220510063223.dogoows5t7cxpnul@zlang-mailbox>
Mail-Followup-To: Ojaswin Mujoo <ojaswin@linux.ibm.com>,
        fstests@vger.kernel.org, riteshh@linux.ibm.com,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220401055713.634842-1-ojaswin@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220401055713.634842-1-ojaswin@linux.ibm.com>
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 01, 2022 at 11:27:13AM +0530, Ojaswin Mujoo wrote:
> A recent ext4 patch discussed [1] that some devices (eg LVMs) can
> have a discard granularity as big as 42MB which makes it larger
> than the group size of ext4 FS with 1k BS. This causes the FITRIM
> IOCTL to fail on filesystems like ext4.
> 
> This case was not correctly handle by "_require_batched_discard" as
> it incorrectly interpreted the FITRIM failure as fs not supporting
> the IOCTL. This caused the tests like generic/260 to incorectly
> report "not run" instead of "failed" in case of large discard
> granularity.
> 
> Fix "_require_batched_discard" to use a more accurate method
> to determine if discard is supported.
> 
> [1] commit 173b6e383d2
>     ext4: avoid trim error on fs with small groups
> 
> Signed-off-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
> ---
>  common/rc | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/common/rc b/common/rc
> index e2d3d72a..97386342 100644
> --- a/common/rc
> +++ b/common/rc
> @@ -3858,7 +3858,13 @@ _require_batched_discard()
>  		exit 1
>  	fi
>  	_require_fstrim
> -	$FSTRIM_PROG $1 > /dev/null 2>&1 || _notrun "FITRIM not supported on $1"
> +
> +	$FSTRIM_PROG $1 2>&1 | grep -q "not supported"
> +	RET=$?

Better to use global variable carefully in common functions, if it's not
necessary, I'd recommend using "local ret" at here.

From my experience, the *quiet (-q)* grep does "exit_on_match" directly,
it won't wait the write process, if the write process is still writing but
the grep has exited, then it'll cause broken pipe, and the write process
exit with failure.

It doesn't always happend, it depends. So I'd like to use "${PIPESTATUS[1]}"
or write it as 'grep -q "not supported" <($FSTRIM_PROG $1 2>&1)', to make sure
we just care about the "grep" result.

> +	if [ "$RET" = "0" ]
> +	then
> +		_notrun "FITRIM not supported on $1"
> +	fi
>  }
>  
>  _require_dumpe2fs()
> -- 
> 2.27.0
> 

