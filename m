Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80E1C4B9271
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Feb 2022 21:36:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232316AbiBPUfk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Feb 2022 15:35:40 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:55394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232068AbiBPUfh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Feb 2022 15:35:37 -0500
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 097042A417A
        for <linux-kernel@vger.kernel.org>; Wed, 16 Feb 2022 12:35:25 -0800 (PST)
Received: by mail-pl1-x62a.google.com with SMTP id w1so2890359plb.6
        for <linux-kernel@vger.kernel.org>; Wed, 16 Feb 2022 12:35:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=3ql2gW0+Kw0ifh/Z8dAvBHWaqCHWEKHJC6WLG6hOvvU=;
        b=Ipb9XZivi/4A7bTkcfycdDfQ7GITOkpq0218108fQ32mq6OVDT5GAUaR/x2WddkZno
         Q20yVJVDuJTAuooetBmhYlgagPu9Gs3NAHuwSJGAJIl4bY/98e3+MdRVnVVD3syovpSw
         zdQcmjZ3NR7i2As96r400jjWmfwMS3lVScjrY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=3ql2gW0+Kw0ifh/Z8dAvBHWaqCHWEKHJC6WLG6hOvvU=;
        b=IqaXir5CA07W/E+uYHyjAbCIvKceAwww7zbqFCFCnqq+lGc0AlsY/hclw+iqKPkW/s
         69uLj95W/OzsBOXi4hZhgBpq6f+HpzfflrF7lkj7Hh7zQhQXBNhDpGA2PGn48EdiD0pl
         XGnTuFtNg0TBeQ5Cv/Oy5v5GDcPXXHltfmsiBbQGjCYFaZJeZez44TeR6KF2wkdMYaPD
         sgxigWsCtBRzBZxEujjrvw90n8A5HOjcufymv2+fxQ4EWxlFUwDcA0yykG0oUofmDHLH
         abtzfqxqET/2z+hLVJ5+SQVfWyE3EZuOEEQ1y1BKpSkHW9k43BHWlK0inMd57y0FRLci
         1fyg==
X-Gm-Message-State: AOAM531hGG7/+kIYOyobAm844wfuzZJUGmjkikBoNj51wShb5Wt26LE2
        io6kQuIeWAZ9EIBfDZCvZuY2BA==
X-Google-Smtp-Source: ABdhPJyFwMuDz1hEGZc7wO6ulmt0RPObdJ54PcQrbFHa5HUawv1Wc7Oi4dhYMbBcBQavRZUBb5r+LA==
X-Received: by 2002:a17:902:82cc:b0:14e:d3e7:aaf2 with SMTP id u12-20020a17090282cc00b0014ed3e7aaf2mr3986109plz.66.1645043724576;
        Wed, 16 Feb 2022 12:35:24 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id u2sm47618111pfk.15.2022.02.16.12.35.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Feb 2022 12:35:24 -0800 (PST)
Date:   Wed, 16 Feb 2022 12:35:22 -0800
From:   Kees Cook <keescook@chromium.org>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     Luca Coelho <luciano.coelho@intel.com>,
        Kalle Valo <kvalo@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH][next] iwlwifi: mei: Replace zero-length array with
 flexible-array member
Message-ID: <202202161235.F3A134A9@keescook>
References: <20220216195030.GA904170@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220216195030.GA904170@embeddedor>
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 16, 2022 at 01:50:30PM -0600, Gustavo A. R. Silva wrote:
> There is a regular need in the kernel to provide a way to declare
> having a dynamically sized set of trailing elements in a structure.
> Kernel code should always use “flexible array members”[1] for these
> cases. The older style of one-element or zero-length arrays should
> no longer be used[2].
> 
> [1] https://en.wikipedia.org/wiki/Flexible_array_member
> [2] https://www.kernel.org/doc/html/v5.16/process/deprecated.html#zero-length-and-one-element-arrays
> 
> Link: https://github.com/KSPP/linux/issues/78
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
