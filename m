Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FAF7527EAB
	for <lists+linux-kernel@lfdr.de>; Mon, 16 May 2022 09:37:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241128AbiEPHgr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 May 2022 03:36:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241390AbiEPHg3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 May 2022 03:36:29 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 13D6510A8
        for <linux-kernel@vger.kernel.org>; Mon, 16 May 2022 00:36:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1652686585;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=HBr6RsK832/kNhjiBHy048AvZza2SX5/1dw9zvCd9GU=;
        b=i2Zr9x1f2ZDr2ocLcB6gMsU1JLmh1J3pvH86nmewkPZJNLwtM7MrEBKtFWd1puQaADOLyv
        HR0dHEtpMhdLeih5zKe0ece3RTXcfoXnW1EQKtdL21S8VcVZacBD60TLzlg7eBQ/E/BLq8
        5hWypyZ7yRkrPlMFR5eUm0/utxP7OkI=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-483-OxjFbfpzPo-17r0W2hsgUQ-1; Mon, 16 May 2022 03:36:24 -0400
X-MC-Unique: OxjFbfpzPo-17r0W2hsgUQ-1
Received: by mail-qv1-f72.google.com with SMTP id bu6-20020ad455e6000000b004563a74e3f9so11545900qvb.9
        for <linux-kernel@vger.kernel.org>; Mon, 16 May 2022 00:36:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=HBr6RsK832/kNhjiBHy048AvZza2SX5/1dw9zvCd9GU=;
        b=7uJOIsMAor+VSXc25WzkFyMQ7wD4Y/V2VHivB1o5BonN26J/btYbOVxCUODsH5OT9r
         po/sMmuUVGRwehNG3RopMUrAMhJjLfOd/5Ofan/uUkipJeGHFDHGKGRZHEPqFekW/fDy
         MzAb5QFBI7PtlEIwPk6Bs6axgm4Kc8qZVInoL+W1jBp5XeWHaJII+pyPXjnBc9q14Hbv
         b1+p5VdwNU9z8Oh/4shDlWA0C1GsvhH/NJkXA4YJNJ0fBZrALemvCIt7YMhLzyjIRO5g
         zMAc+Z3nAX1MA8t0R7xlFn3SPgIv8KCV22ry3xNx1H2dF4cI+etscsnS65WP8p/EY1pJ
         Yj8Q==
X-Gm-Message-State: AOAM531G4hdPawwdkH+J5533W8XjNG4brOdn0BvjOhMXyW6KNbOk64Tx
        e90eBStVh0KOYEGCf4RhDgdrKzJPchb9AD3scOIytR2XkK/NQuUbnpC/Tp18epUPe9CPYommHLI
        dOrSrjmNUMpDZdTW8tCHaP8hh
X-Received: by 2002:ac8:4e8c:0:b0:2f3:d53a:add3 with SMTP id 12-20020ac84e8c000000b002f3d53aadd3mr14235512qtp.300.1652686583193;
        Mon, 16 May 2022 00:36:23 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy1KfBFNUSFZm0cKhHb5K+b2Dizh0DvtxGYxSxl+tPRDFBtmmgziUdhDE+xynjbHIki+pPA1g==
X-Received: by 2002:ac8:4e8c:0:b0:2f3:d53a:add3 with SMTP id 12-20020ac84e8c000000b002f3d53aadd3mr14235496qtp.300.1652686582917;
        Mon, 16 May 2022 00:36:22 -0700 (PDT)
Received: from zlang-mailbox ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id v6-20020ae9e306000000b0069fc13ce23esm5424130qkf.111.2022.05.16.00.36.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 May 2022 00:36:22 -0700 (PDT)
Date:   Mon, 16 May 2022 15:36:16 +0800
From:   Zorro Lang <zlang@redhat.com>
To:     Ojaswin Mujoo <ojaswin@linux.ibm.com>
Cc:     fstests@vger.kernel.org, riteshh@linux.ibm.com,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] common/rc: Modify _require_batched_discard to improve
 test coverage
Message-ID: <20220516073616.x3sauzctypcxstet@zlang-mailbox>
Mail-Followup-To: Ojaswin Mujoo <ojaswin@linux.ibm.com>,
        fstests@vger.kernel.org, riteshh@linux.ibm.com,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220516063951.87838-1-ojaswin@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220516063951.87838-1-ojaswin@linux.ibm.com>
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 16, 2022 at 12:09:51PM +0530, Ojaswin Mujoo wrote:
> A recent ext4 patch discussed [1] that some devices (eg LVMs) can
> have a discard granularity as big as 42MB which makes it larger
> than the group size of ext4 FS with 1k BS.  This causes the FITRIM
> IOCTL to fail.
> 
> This case was not correctly handled by this test since
> "_require_batched_discard" incorrectly interpreted the FITRIM
> failure as SCRATCH_DEV not supporting the IOCTL. This caused the test
> to report "not run" instead of "failed" in case of large discard granularity.
> 
> Fix "_require_batched_discard" to use a more accurate method
> to determine if discard is supported.
> 
> [1] commit 173b6e383d2
>     ext4: avoid trim error on fs with small groups
> 
> Signed-off-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
> Reviewed-by: Ritesh Harjani <riteshh@linux.ibm.com>
> ---
> 
> Changes since v1 [1] 
> 
> *  Changed $RET to a local variable
> *  Fixed the grep command 
> 
> [1]
> https://lore.kernel.org/all/20220401055713.634842-1-ojaswin@linux.ibm.com/
> 
>  common/rc | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/common/rc b/common/rc
> index e2d3d72a..f366e409 100644
> --- a/common/rc
> +++ b/common/rc
> @@ -3858,7 +3858,13 @@ _require_batched_discard()
>  		exit 1
>  	fi
>  	_require_fstrim
> -	$FSTRIM_PROG $1 > /dev/null 2>&1 || _notrun "FITRIM not supported on $1"
> +
> +	grep -q "not supported" <($FSTRIM_PROG $1 2>&1)
> +	local ret=$?
> +	if [ "$ret" = "0" ]

Oh I forgot to ask why we need to add a variable (ret), to record the return
value at here. Why can't use "$?" directly? e.g.

  grep -q "not supported" <($FSTRIM_PROG $1 2>&1)
  if [ $? -eq 0 ]

Others look good to me.

Thanks,
Zorro

> +	then
> +		_notrun "FITRIM not supported on $1"
> +	fi
>  }
>  
>  _require_dumpe2fs()
> -- 
> 2.27.0
> 

