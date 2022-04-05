Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 660834F46FF
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 01:26:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1384108AbiDEUzh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Apr 2022 16:55:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1573099AbiDER7U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 13:59:20 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18852E7F4A
        for <linux-kernel@vger.kernel.org>; Tue,  5 Apr 2022 10:57:21 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id d5so24595111lfj.9
        for <linux-kernel@vger.kernel.org>; Tue, 05 Apr 2022 10:57:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hBgkgZVxUFaHHWVT8MJPRfMm0CbtM8C9QcwHO150roA=;
        b=cikBVFVsqfHRfiS3Za+lqvw+SF2Z6x/1MAsZHBWiKm3TYeQxJz3Y0V9vvb2Vr+8BwK
         Jn1ZJp1uro8v3++kb/aq9ZfjZVI6oa3qIicCw98cuFEYl/dIeN/oj/xmGC4g2dqmIZqm
         GU6YFirBWWt7ZxKJZRVr7StDOW++mx3rKhSt9xa1tOiTMyk7a+nTs04xo1uxfG6hIxBI
         GOHsndkoLejoUUhZfN2WHf48bDJKSJQKfeGOyi6KSg4cZaKaVNFoY9HZ/jDgCuSjRyqh
         Ls/cOFBuFDhnoL/DtPqxcNbIKqg9dVW60GggP6esN5jq3IZPfcDGEh5dDc4zL/J2B6rJ
         ptow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hBgkgZVxUFaHHWVT8MJPRfMm0CbtM8C9QcwHO150roA=;
        b=Y67w+k73jl3VuQIHlas7fwDq78wWnQMPcvPSR6d2i+psm5TCQ6HgPwob/ejiWMIuxF
         YkFmxH4ZJsrJ/AsHuxIzbbQgpEKbltwYd9x++eIZxLRkqGXouRqg+0f9ygsXjQSsyiKh
         9y6TxfbmLwOQDd5DJsGn4k8OOTTsxOvbHDFVFxrv/1YaVRKARcqcOyYcgn7ckktYfbTM
         x/rAnVpUQsDRUSzcjeNveVrDU3RCzhnK3b3B6/91YmVv0DuRdLvU4aISLkOPGOyKi9Zw
         +ghTDgf2jPwzPVKklIQCg90FfvW6OhzZp3AGbLWTGYkO9bgv25E4pmM4H4S3g2/YdaV5
         +3xQ==
X-Gm-Message-State: AOAM532s2IYReHF9s89JwLm555S7dl7ZnGd+WcTrHorTkmUbor2vn+2N
        xLc1vc5QSlG61FmXEYj1s5JiJsfAIPplVrwACLpddQ==
X-Google-Smtp-Source: ABdhPJz2VaFmMYt5PGtt9rPGIZ+g8Of7B0s0umeXy0XDUFW7BCfGgvKZYRvQKJox0fPHoaedJxkrhq2IosfOwyw+srk=
X-Received: by 2002:a05:6512:33d4:b0:44a:9971:de48 with SMTP id
 d20-20020a05651233d400b0044a9971de48mr3392619lfg.392.1649181439072; Tue, 05
 Apr 2022 10:57:19 -0700 (PDT)
MIME-Version: 1.0
References: <20220401230640.3196196-1-trix@redhat.com>
In-Reply-To: <20220401230640.3196196-1-trix@redhat.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Tue, 5 Apr 2022 10:57:07 -0700
Message-ID: <CAKwvOdng7CbqGrDH+WYwY0aAkjpW8mT428m4p=K8VTTD8ddV0Q@mail.gmail.com>
Subject: Re: [PATCH] iwlwifi: mvm: initialize seq variable
To:     Tom Rix <trix@redhat.com>
Cc:     luciano.coelho@intel.com, kvalo@kernel.org, davem@davemloft.net,
        kuba@kernel.org, pabeni@redhat.com, nathan@kernel.org,
        johannes.berg@intel.com, emmanuel.grumbach@intel.com,
        dan.carpenter@oracle.com, linux-wireless@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 1, 2022 at 4:06 PM Tom Rix <trix@redhat.com> wrote:
>
> Clang static analysis reports this issue
> d3.c:567:22: warning: The left operand of '>' is
>   a garbage value
>   if (seq.tkip.iv32 > cur_rx_iv32)
>       ~~~~~~~~~~~~~ ^
>
> seq is never initialized. Call ieee80211_get_key_rx_seq() to
> initialize seq.
>
> Fixes: 0419e5e672d6 ("iwlwifi: mvm: d3: separate TKIP data from key iteration")
> Signed-off-by: Tom Rix <trix@redhat.com>

Thanks for the patch!
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>

> ---
>  drivers/net/wireless/intel/iwlwifi/mvm/d3.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/d3.c b/drivers/net/wireless/intel/iwlwifi/mvm/d3.c
> index a995bba0ba81..9b190b3ce6c1 100644
> --- a/drivers/net/wireless/intel/iwlwifi/mvm/d3.c
> +++ b/drivers/net/wireless/intel/iwlwifi/mvm/d3.c
> @@ -563,6 +563,7 @@ static void iwl_mvm_wowlan_get_tkip_data(struct ieee80211_hw *hw,
>                 }
>
>                 for (i = 0; i < IWL_NUM_RSC; i++) {
> +                       ieee80211_get_key_rx_seq(key, i, &seq);
>                         /* wrapping isn't allowed, AP must rekey */
>                         if (seq.tkip.iv32 > cur_rx_iv32)
>                                 cur_rx_iv32 = seq.tkip.iv32;
> --
> 2.27.0
>


-- 
Thanks,
~Nick Desaulniers
