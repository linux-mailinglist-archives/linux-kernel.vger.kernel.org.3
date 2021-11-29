Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 52813460F89
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Nov 2021 08:45:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240974AbhK2HtF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Nov 2021 02:49:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236077AbhK2HrE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Nov 2021 02:47:04 -0500
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E80AC061748;
        Sun, 28 Nov 2021 23:43:47 -0800 (PST)
Received: by mail-pj1-x1030.google.com with SMTP id j5-20020a17090a318500b001a6c749e697so11225173pjb.1;
        Sun, 28 Nov 2021 23:43:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=jBSH9BqMj+eVa+z/SQExKiI011v81dod+DkP2K0g2qk=;
        b=aaXOqK607emJ8ktpAovEAgGIt+ckwWjBoJchYAgjMwPrRk3h6CetAVhwQhNzggSoMM
         /l+A4J+KnoLE22MH/yNQT9aNLBkrmMEumV5x5VBYmdcEk+82EYFDTQUxSwgfsi4dOubL
         xhR/n1gVe3w9QqFEyIf7qR1Absk/Ty9iCq/VuZHv2yqa/juO3IDbDrnpuV0Rt8jbKW6M
         5t4435QG+YwjIFuB6UR+yX4CUS6yXjqOYB03fvGQ10yAXwKzLuiPrHzpr4ZxP/oRGAnP
         3dZ9fsu7yKpm/XutzdRMtyURhPlaV/5b/yzP7uFghOZ1Dq7Wj76qdYfNhKJSfPl6yoPX
         Xr4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=jBSH9BqMj+eVa+z/SQExKiI011v81dod+DkP2K0g2qk=;
        b=0mOiTyomgyWh2YfkT5qabZGY8z2vpoPL4Fc31VferqtQaCUtQB2IcGgPLweLfDcXKC
         DPB0KGsZvIbjEHpFNQO0bARhXoyHRGNXvAkYu/vpf3drGpbufqkW77KDe5KQwchsodNt
         K32nlD107Q6cwl7sjLS9519V3TyEHBVjxlcnAWHpUz9bnZ4lNlW6ruGlAraUwMM/2mBB
         GY7lsahy9+oRr5f1MpJwcrOsgCEeEeMtyX+jICCdg6WexQXvFrrTJtTqumyQwSuh6SeB
         jV5E9xPt/UxTf5seqQ43tUy6iCTofx0VD3oyZHPwLNLNo78ZgEIwUjHGUfTzKaeAadQ4
         plYg==
X-Gm-Message-State: AOAM533JY/xEvWcqHoimEGa15sld86NtD7noZs3ZosVpYrLjr74TNOcZ
        LUYyYSzH5wFCBVm2kyeyA1WST/+IlI4=
X-Google-Smtp-Source: ABdhPJwTBHzLp5vMylmN0QgUHmUSgfhVCqwHcYf4sxf5rV/BX80WstG+wj3poViLAvSKnU3wUQfagg==
X-Received: by 2002:a17:902:d34d:b0:143:c927:dc48 with SMTP id l13-20020a170902d34d00b00143c927dc48mr58764468plk.71.1638171826826;
        Sun, 28 Nov 2021 23:43:46 -0800 (PST)
Received: from google.com ([2620:15c:202:201:f5d5:95ab:43b1:99a9])
        by smtp.gmail.com with ESMTPSA id a13sm17997274pfv.99.2021.11.28.23.43.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Nov 2021 23:43:46 -0800 (PST)
Date:   Sun, 28 Nov 2021 23:43:43 -0800
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Takashi Iwai <tiwai@suse.de>
Cc:     linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        Fabio Estevam <festevam@gmail.com>
Subject: Re: [PATCH v2] Input: i8042 - Add deferred probe support
Message-ID: <YaSEr9qctLBXFFzd@google.com>
References: <20211117063757.11380-1-tiwai@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211117063757.11380-1-tiwai@suse.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 17, 2021 at 07:37:57AM +0100, Takashi Iwai wrote:
> We've got a bug report about the non-working keyboard on ASUS ZenBook
> UX425UA.  It seems that the PS/2 device isn't ready immediately at
> boot but takes some seconds to get ready.  Until now, the only
> workaround is to defer the probe, but it's available only when the
> driver is a module.  However, many distros, including openSUSE as in
> the original report, build the PS/2 input drivers into kernel, hence
> it won't work easily.
> 
> This patch adds the support for the deferred probe for i8042 stuff as
> a workaround of the problem above.  When the deferred probe mode is
> enabled and the device couldn't be probed, it'll be repeated with the
> standard deferred probe mechanism.
> 
> The deferred probe mode is enabled either via the new option
> i8042.probe_defer or via the quirk table entry.  As of this patch, the
> quirk table contains only ASUS ZenBook UX425UA.
> 
> The deferred probe part is based on Fabio's initial work.
> 
> BugLink: https://bugzilla.suse.com/show_bug.cgi?id=1190256
> Link: https://lore.kernel.org/r/s5ho890n1rh.wl-tiwai@suse.de
> Cc: Fabio Estevam <festevam@gmail.com>
> Signed-off-by: Takashi Iwai <tiwai@suse.de>

Applied, thank you.

-- 
Dmitry
