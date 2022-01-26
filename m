Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3BDDE49D2AD
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jan 2022 20:48:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244510AbiAZTsn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jan 2022 14:48:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232077AbiAZTsl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jan 2022 14:48:41 -0500
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com [IPv6:2607:f8b0:4864:20::72b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B343C06161C
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jan 2022 11:48:41 -0800 (PST)
Received: by mail-qk1-x72b.google.com with SMTP id 13so545173qkd.13
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jan 2022 11:48:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=cnaHKagfwHGqaznD5wm3EjdQSvy1XNpSCppZJHrSIys=;
        b=aGK97rakYCe9gtm+vNOzkSTyJolrONWbZ2NnD9qv8O+uupRm9HbODyTEdYDKGwqyfw
         eaJRbjvPqJlKnLVLWFxBfMNyyTuO+af5C/c11/hnXA/g57VtO+Y0nCxWYwFulgIoVFF7
         YxD07u+wy/R+NlTHMhpICG1UdViVU9ig95K42g31xhHuB3swuZPH9AcqL4tJBURZDmNs
         NWQA5kPDpffdLTHusFW8rrzpTCjPhMMaSYL0GBQcIbMPxS+E87YuUaTmIjD5vCURAtP8
         fZP2DLxhpLki+8DFHIpfVJwxW/A57IlJhbXvIompriWORNmJ40RTqWuXNVTc0KNHREzF
         Yf9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=cnaHKagfwHGqaznD5wm3EjdQSvy1XNpSCppZJHrSIys=;
        b=19uE2QnNHfqjwLps0/QazJNDSIHoH5oH+8z4k1UEV9jfJN9GEBJl4jE6vMGwAruwkw
         l5ZxRcIM6izb/4NFvlH5ZdiBo7vZEkkvDsUZ4cNU0kZ0GkrY9e8zw/tD9VQN2yxvf0I7
         bT/56uHpJgeAAvb7Iv6fmCCm1evQ7i6l15t+m4/v+2CnCfG+sV/peWdV+ldir6HsVqCQ
         mQOj4Dw3H/Ay1QxKlVE+ujdMqbphqm9JmaRlCOGuiceMbdcQmSeRGCLlg8d1tvCEAeLV
         o8eBO5Yz6IAZ/7kOdWWF9POZANfNXJx0s2lAo1Pw2aakv3vcjVY1Xh9ayzKNBH7gqBes
         XT6w==
X-Gm-Message-State: AOAM533z8W0e7oMRDpGWMmaOrNNejKiL0anh/HQiqDqet4I0JD7VzZ/T
        g222eIOKTt/FsdXqNOtwL+Q9nF2kIlPwkA==
X-Google-Smtp-Source: ABdhPJyt3NXcmKd1A/0E+XHc7xXKnQSpbQx+rb7XFiJW9mvwHA7ZYU1u822P32XYn5DgApDo+ociPA==
X-Received: by 2002:a37:b0c:: with SMTP id 12mr211117qkl.667.1643226520231;
        Wed, 26 Jan 2022 11:48:40 -0800 (PST)
Received: from localhost (rfs.netwinder.org. [206.248.184.2])
        by smtp.gmail.com with ESMTPSA id f2sm101432qti.61.2022.01.26.11.48.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jan 2022 11:48:39 -0800 (PST)
Date:   Wed, 26 Jan 2022 14:48:39 -0500
From:   Ralph Siemsen <ralph.siemsen@linaro.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Jiri Prchal <jiri.prchal@aksignal.cz>,
        Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH -next] eeprom: at25: Replace strncpy() with strscpy()
Message-ID: <20220126194839.GA3763384@maple.netwinder.org>
References: <20220118182047.3385295-1-keescook@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20220118182047.3385295-1-keescook@chromium.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kees,

On Tue, Jan 18, 2022 at 10:20:47AM -0800, Kees Cook wrote:
>Use strscpy() instead of strncpy(), since its use has been deprecated[1].
>
>[1] 
>https://www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings

Along with your other fix to restore the missing kzalloc(), I tested 
this change on 32-bit arm system, and it worked as expected.

Tested-by: Ralph Siemsen <ralph.siemsen@linaro.org>

Cheers,
-Ralph
