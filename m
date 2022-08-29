Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D582D5A56BF
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 00:07:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229957AbiH2WHY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Aug 2022 18:07:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229992AbiH2WHU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Aug 2022 18:07:20 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E01D3A2ABC
        for <linux-kernel@vger.kernel.org>; Mon, 29 Aug 2022 15:07:18 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id l5so5436851pjy.5
        for <linux-kernel@vger.kernel.org>; Mon, 29 Aug 2022 15:07:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc;
        bh=k2Isl7E2TJrjz9RWvaLb1hVmrU1bdckrw7QzjwxtCok=;
        b=kgkdmJX7EizEvIXDuh3PyH9dF4tkinwEbVoInAmpJDW2RpLs7hLMkXJ04kArFIK4uw
         xJinRNSts20Fpeyl0cWOYrfKmZ93mkCktWz28aG7myBx5tzDJ3gL5KlNzCWRomOCtDQZ
         RUyqDuIw0xjEQayVF6Ia5ksfmxWePWZW1oRRQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=k2Isl7E2TJrjz9RWvaLb1hVmrU1bdckrw7QzjwxtCok=;
        b=KxCHePPrXj/PgENPpLLeUFLckL0TCXvlL+PpP6sW36pZepd1sS8CBZI7mtfiz+WC7e
         /yP7Vx5CmKsszDW9BE0fAxzCvM7rW+ZOXNKNzN2tWtFvgRJvlpUvDvUny602g4G7Aiss
         1P4CpLGO5SXA363HhiSTq2Dq3t3hWdZkk/8PZBZWcVpzEh9w2m6M2gqFmDX+c7IAoNSY
         3qJzKYdFEOHdaW72ER9NOXnHv7DhrIvqexP7FBz01bxp1AgpEgBKvQdjaMfbjX/saqEN
         48HN4f0NGCbwlrSFsXvpzAloHq4VmnfYhKEYVECHdTxo18FQAbwNSvmSXjlCIxa8zlh6
         ODcg==
X-Gm-Message-State: ACgBeo0PObd4tSNPhclVxoRt0mxt4vH7C+gomd5PJrJdFxybqCG5VneB
        1algCBI9E2GzzUf0HlkXqePUnA==
X-Google-Smtp-Source: AA6agR4KrLR6NM3om4AqBBqcBSC2Rv/4c/jLw32zl1wdhvYKXC6KOo0sBiRaKJGSYNPNPGv75DjJ2Q==
X-Received: by 2002:a17:902:c94d:b0:16d:c10a:650e with SMTP id i13-20020a170902c94d00b0016dc10a650emr17851903pla.29.1661810838390;
        Mon, 29 Aug 2022 15:07:18 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id md10-20020a17090b23ca00b001f24c08c3fesm7324164pjb.1.2022.08.29.15.07.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Aug 2022 15:07:17 -0700 (PDT)
Date:   Mon, 29 Aug 2022 15:07:16 -0700
From:   Kees Cook <keescook@chromium.org>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH][next] ALSA: hda/hdmi: Replace zero-length array with
 DECLARE_FLEX_ARRAY() helper
Message-ID: <202208291507.FBA7EF4@keescook>
References: <Yw01A+TvF1FWQ588@work>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yw01A+TvF1FWQ588@work>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 29, 2022 at 04:52:03PM -0500, Gustavo A. R. Silva wrote:
> Zero-length arrays are deprecated and we are moving towards adopting
> C99 flexible-array members, instead. So, replace zero-length array
> declaration in union audio_infoframe with the new DECLARE_FLEX_ARRAY()
> helper macro.
> 
> This helper allows for a flexible-array member in a union.
> 
> Link: https://github.com/KSPP/linux/issues/193
> Link: https://gcc.gnu.org/onlinedocs/gcc/Zero-Length.html
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
