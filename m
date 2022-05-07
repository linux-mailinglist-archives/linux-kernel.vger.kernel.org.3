Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9439951E584
	for <lists+linux-kernel@lfdr.de>; Sat,  7 May 2022 10:16:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1446074AbiEGIUW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 May 2022 04:20:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1446083AbiEGIUL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 May 2022 04:20:11 -0400
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C2D85838A
        for <linux-kernel@vger.kernel.org>; Sat,  7 May 2022 01:16:25 -0700 (PDT)
Received: by mail-pg1-x531.google.com with SMTP id g184so5434357pgc.1
        for <linux-kernel@vger.kernel.org>; Sat, 07 May 2022 01:16:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=idVYGXtFtIYXbD4diMzv44fhyusigdC9ymPPyiEa4fU=;
        b=YkMuW6w3LJLPY8hqfnwOzbmQzRI+9TJX7xo3XtWW+byYW4msua8cUQhwEZ45NyWBB2
         aVelMQryw0+PknSAzroHFoN8+qsMO9V2DlI1AGeKzCgQaGgDAW5BM4TxFwnp8YUCxiru
         YJ2fPcslpe9WHXdO/b4tQwM/RhQe5Bf2OoG/c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=idVYGXtFtIYXbD4diMzv44fhyusigdC9ymPPyiEa4fU=;
        b=USTa0mE+ygF77nFMcQfJWx3bqgYmrbViF91sk5/VRaxT63t0MxOgpd+URIbcDKAYWt
         CRijmcznfEVuED3wkOWpM3s/Kga3NpIluvBHRiq7CTMWy7u6O6fWepYQmG0kVxvOcJ2U
         KDl6FC9UcYL+zdvAkdNQY8r0iy7p0JQRPWz4SycOTrZkxUzmm2rDU0BpnV7hz2pJ3jc5
         jDwJaCa019+DJI/A/ffVpj+TKQ54WJaj9mJc7ZH0HXVF4Pa8D7oNfvNcYkEEkZdu1fpP
         OeHRq1sN2cB6JBcxm0KjtnxLDUDHGgWzliCccD1JIcEHa2RB0ESjza9tLPbLWAAZsUII
         PpYQ==
X-Gm-Message-State: AOAM533HXWugZbnyvljy5kTVJmLeg+TQ9n8zSorYn+Awe6iFplNM3VtI
        +mhYloEqSlZfxnTNTI2Q2m/2Uw==
X-Google-Smtp-Source: ABdhPJwG5MlyM0SHoqpNwrzltkE25qDsC6TpJlnHRyC6+fUj7zjzSKMW/Tu252LlrQ9GEa9hSXRzoA==
X-Received: by 2002:a63:a06:0:b0:3c2:3345:bf99 with SMTP id 6-20020a630a06000000b003c23345bf99mr6016622pgk.477.1651911384751;
        Sat, 07 May 2022 01:16:24 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id l65-20020a622544000000b0050dc762818dsm4719584pfl.103.2022.05.07.01.16.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 May 2022 01:16:24 -0700 (PDT)
Date:   Sat, 7 May 2022 01:16:23 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Miguel Ojeda <ojeda@kernel.org>
Cc:     Brendan Higgins <brendanhiggins@google.com>,
        linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kunit: take `kunit_assert` as `const`
Message-ID: <202205070116.BC6B4E33@keescook>
References: <20220502093625.GA23225@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220502093625.GA23225@kernel.org>
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 02, 2022 at 11:36:25AM +0200, Miguel Ojeda wrote:
> The `kunit_do_failed_assertion` function passes its
> `struct kunit_assert` argument to `kunit_fail`. This one,
> in turn, calls its `format` field passing the assert again
> as a `const` pointer.
> 
> Therefore, the whole chain may be made `const`.
> 
> Signed-off-by: Miguel Ojeda <ojeda@kernel.org>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
