Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F16C47994B
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Dec 2021 08:17:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232236AbhLRHQ6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Dec 2021 02:16:58 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:41008 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232199AbhLRHQ5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Dec 2021 02:16:57 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 24719B80123;
        Sat, 18 Dec 2021 07:16:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85883C36AE1;
        Sat, 18 Dec 2021 07:16:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639811814;
        bh=RSpFIWd9FTkwqBB/oPQAKZKNaOc+nNVCAJLZA7EDQJc=;
        h=References:From:To:Cc:Subject:Date:In-reply-to:From;
        b=e9mU++Jv8oHvqoa45fXOiYk8kRu2q5qVPCE4/iTyknAvGMnBzmpWuMCTG8DEp10nU
         C9KK8BD+MUHhE/L1Hx9NtJMMl0dEtHS6coDI6KHNl6ADJGjT7JbDzk7ufhd/UsXK9Z
         W1AB1wOXiNi/MvujsKf0i2/dQMRzAKzrGbOfY2+r+2QIHH0rbFGLXql6M8bZUqtxpm
         9eY+Rz3YkbFS3yCxLX2tQhdMBdoRZqtOevAnj7eFwMkhPzPENy6gDuMDeZIXVEGWOh
         S40/kFsmgZKcLAxQl0m3GXRuXXjAUnJ2CgpoqsTa+17Fsj1dYZgl50otFj3f/ht9jS
         1GvwhhByLiJMA==
References: <20211217125757.1193256-1-balbi@kernel.org>
 <20211217125757.1193256-3-balbi@kernel.org>
 <92001103-6b29-7ad9-eea3-34fd30c5f767@postmarketos.org>
User-agent: mu4e 1.6.10; emacs 28.0.90
From:   Felipe Balbi <balbi@kernel.org>
To:     Alexey Minnekhanov <alexeymin@postmarketos.org>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC/patch 2/2] arm64: boot: dts: qcom: surface duo: add
 minimal framebuffer
Date:   Sat, 18 Dec 2021 09:15:30 +0200
In-reply-to: <92001103-6b29-7ad9-eea3-34fd30c5f767@postmarketos.org>
Message-ID: <87lf0i4c2l.fsf@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

Alexey Minnekhanov <alexeymin@postmarketos.org> writes:
> @@ -472,6 +483,14 @@ &pon_resin {
>  	linux,code = <KEY_VOLUMEDOWN>;
>  };
>  
> +&reserved_memory {
> +	splash_region: splash_region@9c000000 {
> +		/* We expect the bootloader to fill in the size */
> +		reg = <0x0 0x9c000000 0x0 0x0>;
>
> 0x2400000 should be here as size, maybe?

bootloader is filling that up, but sure I only used this to get the size
and base address from bootloader. I could just hardcode the values now
that I know them :-)

>
> 	 cont_splash_mem: memory@9c000000 {
> 		reg = <0x0 0x9c000000 0x0 0x2400000>;
> 		no-map;
> 	};
>
> FWIW, example above (with similar simple-framebuffer
> node) worked fine for my sm8150 based device.

Oh okay. So it's likely to be something specific to our bootloader.

-- 
balbi
