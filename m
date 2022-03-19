Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B6E44DE4FA
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Mar 2022 02:22:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241724AbiCSBXg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Mar 2022 21:23:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229580AbiCSBXf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Mar 2022 21:23:35 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCE0C2F09EF
        for <linux-kernel@vger.kernel.org>; Fri, 18 Mar 2022 18:22:15 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id t22so8447715plo.0
        for <linux-kernel@vger.kernel.org>; Fri, 18 Mar 2022 18:22:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=3z10AOteEx1l3qhsEcfSDRV+sBpD5Nt7UgyL1DLLBmU=;
        b=ZHGfgTOtoN7DM/VIkKp/QWyYI9gVP4rFHtey1iKU1pRtxy8yMz3V5kyCjwXH7us67z
         OjeMnE2mnaC+zaYuv6Tt8J+rf2E6OL4YwDqwgBF2LbyIt4li2cIZXMntTvBd4+ZTeip9
         a+KQb6zMyrQmjdSir+2XO2YZ3vFsdlkI/mBB4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=3z10AOteEx1l3qhsEcfSDRV+sBpD5Nt7UgyL1DLLBmU=;
        b=yiS+sEADZM7uQ+3LgW8Zspj3GoeI043M6CLqCylaRN4ceu6O6S+Lcl+VQGlLyro2x5
         aPQM+xr8X0hRqXsFe35D7L1sTEjnWklOV5BNQ/JqOMeOHBlRwIKLm/Wf1aky93HevSuK
         Er/nFhCWKH3/p3mFnLTTC078YCGDNuo2TfpQCKC4xd12q6qdpI69OKhtqe1/oxu/OiJI
         WzSsRwI+miArcMJ4/jWc/dwoBG878F+23gSnJJCawT+eEZenxsi9FAlUzDnG4xoQlfmJ
         jcIUHEmbN75Q3U2FFHQKxLWF9Rx4aqcbc6Rn9Ufwhe97AROtfuX3JQmFOQw0XfM1t8Mr
         b1ug==
X-Gm-Message-State: AOAM5301KGqhtvoMUSg67+WE5xqMBmUD/imK9eiMNRE36iAzcmheKTvN
        igAl/OKX3KWti/ARbv/M+3jpNA==
X-Google-Smtp-Source: ABdhPJyALygDL2SvehFfKJmpq8i+7nuAvOndJm7iIIP+BxFZZMpfmObVPfpU2NG9jkp2bwMdtX45RA==
X-Received: by 2002:a17:902:d890:b0:151:6b8b:db0a with SMTP id b16-20020a170902d89000b001516b8bdb0amr2244818plz.15.1647652935405;
        Fri, 18 Mar 2022 18:22:15 -0700 (PDT)
Received: from google.com ([2620:15c:202:201:bd64:9503:150c:fb20])
        by smtp.gmail.com with ESMTPSA id q10-20020a056a00088a00b004f7ceff389esm11376908pfj.152.2022.03.18.18.22.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Mar 2022 18:22:14 -0700 (PDT)
Date:   Fri, 18 Mar 2022 18:22:11 -0700
From:   Brian Norris <briannorris@chromium.org>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Benson Leung <bleung@chromium.org>,
        chrome-platform@lists.linux.dev, linux-kernel@vger.kernel.org,
        Daisuke Nojiri <dnojiri@chromium.org>,
        Rob Barnes <robbarnes@google.com>,
        Rajat Jain <rajatja@google.com>,
        Parth Malkan <parthmalkan@google.com>
Subject: Re: [PATCH v2] platform/chrome: Re-introduce cros_ec_cmd_xfer and
 use it for ioctls
Message-ID: <YjUwQ1kgjHF2AMBV@google.com>
References: <20220318165422.686848-1-linux@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220318165422.686848-1-linux@roeck-us.net>
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 18, 2022 at 09:54:22AM -0700, Guenter Roeck wrote:
> Commit 413dda8f2c6f ("platform/chrome: cros_ec_chardev: Use
> cros_ec_cmd_xfer_status helper") inadvertendly changed the userspace ABI.
> Previously, cros_ec ioctls would only report errors if the EC communication
> failed, and otherwise return success and the result of the EC
> communication. An EC command execution failure was reported in the EC
> response field. The above mentioned commit changed this behavior, and the
> ioctl itself would fail. This breaks userspace commands trying to analyze
> the EC command execution error since the actual EC command response is no
> longer reported to userspace.
> 
> Fix the problem by re-introducing the cros_ec_cmd_xfer() helper, and use it
> to handle ioctl messages.
> 
> Fixes: 413dda8f2c6f ("platform/chrome: cros_ec_chardev: Use cros_ec_cmd_xfer_status helper")

Probably could use a Cc: <stable@vger.kernel.org> in here, since this is
a user-space ABI regression. But these days, there's effectively no
difference vs. just a Fixes tag, because someone's bot will usually pick
it up.

> Cc: Daisuke Nojiri <dnojiri@chromium.org>
> Cc: Rob Barnes <robbarnes@google.com>
> Cc: Rajat Jain <rajatja@google.com>
> Cc: Brian Norris <briannorris@chromium.org>
> Cc: Parth Malkan <parthmalkan@google.com>
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> ---
> v2: Updated comments / return value description. No functional change.

Reviewed-by: Brian Norris <briannorris@chromium.org>
