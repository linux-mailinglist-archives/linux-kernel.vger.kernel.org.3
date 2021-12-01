Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 60711464544
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Dec 2021 04:09:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346414AbhLADMp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Nov 2021 22:12:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346403AbhLADMo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Nov 2021 22:12:44 -0500
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DA79C061746
        for <linux-kernel@vger.kernel.org>; Tue, 30 Nov 2021 19:09:24 -0800 (PST)
Received: by mail-pj1-x1036.google.com with SMTP id x7so16907615pjn.0
        for <linux-kernel@vger.kernel.org>; Tue, 30 Nov 2021 19:09:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:to:cc:references:subject
         :content-language:from:reply-to:in-reply-to
         :content-transfer-encoding;
        bh=JCdsNFesDkuuM1VR2LPSkkTD1jlcMDvQK+ffmxURn+g=;
        b=bgbM3XhbJAWBjpnSaRSKN5x9K9qNIxiC7vK0MluFkyVxwWpjK7InPC7X8JgtyS639t
         VK4p76abakz/439mKRQ+KokCvszmbJUfuMmvAotKJPK/7IXCTlITTsqFMku+26CGhrJP
         O5pany0S58DGuTfKl/h+Pxsvi3F14Cu9qVKSA6X2GbSIwACHTW+weykLsjJFwDN724Rc
         aROBbBBkFWJ8fW5aFU7ubkDai+tcGRcmV2VwfFSKu4DJQtZ1A0g/p1YkxbF3KdJkKqWJ
         LbRBPIxpzbjhEPo5Y9yzKivcrMPBK7w3uiZvx2r4tl9WLbeRQxFkwoRnYga4zZ52xx0a
         tU1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:to:cc
         :references:subject:content-language:from:reply-to:in-reply-to
         :content-transfer-encoding;
        bh=JCdsNFesDkuuM1VR2LPSkkTD1jlcMDvQK+ffmxURn+g=;
        b=VBLMixZovohtgVfOV64pi+xOPYtYMvUNrbVw3l+scz3vpLlx8qnVbIO+HzsqHVUNJb
         y1UPhGH5b1eWeUOA1kmxtkks5dIs2ckAnp5CMFxsvGb1B3naLqlhlEF6NVv4tJRDZcwH
         zaN7OXaria9jGAYRG9aY9hRFk8yHpQrplyFRWwEJ0pyCoxBdxIKcuwlmn7JQOhyMt+VF
         acyaF9eJ52i40jB2uLC1ttcpZxlIA7E8OYv4rA/mtZIH56y/XQTMuUN9t37cHaC7Ju5B
         cCkAK4dJSqIUEkJqvvZ6AbMFYLVLatntoPGLwDIXzjshs78EIY1w4nh1W4GHsaPZD7FJ
         473g==
X-Gm-Message-State: AOAM530u0NcRt8pKtb76832YaeISLLtRghQuAuMqX4Rj0fuM8W16gayh
        CfsQTrILoVPQBUJ5aylevPj9MspZajIOXndp
X-Google-Smtp-Source: ABdhPJxiUGARIFqsFxUSlvAWP1A7uyuEjb9oPxtVgNSIB1NC1DI9nd/TbQZJc8nJEFO6CJEFgKtUhQ==
X-Received: by 2002:a17:903:110c:b0:143:9edf:4985 with SMTP id n12-20020a170903110c00b001439edf4985mr655597plh.15.1638328163791;
        Tue, 30 Nov 2021 19:09:23 -0800 (PST)
Received: from [10.76.43.192] ([61.120.150.76])
        by smtp.gmail.com with ESMTPSA id 16sm9637367pgu.93.2021.11.30.19.09.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Nov 2021 19:09:23 -0800 (PST)
Message-ID: <b0d1f682-6868-c5f6-631c-2da93ee2b479@bytedance.com>
Date:   Wed, 1 Dec 2021 11:09:18 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.3.2
To:     feng.tang@intel.com
Cc:     linux-api@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
References: <1627970362-61305-1-git-send-email-feng.tang@intel.com>
Subject: Re: [PATCH v7 0/5] Introduce multi-preference mempolicy
Content-Language: en-US
From:   Gang Li <ligang.bdlg@bytedance.com>
Reply-To: 1627970362-61305-1-git-send-email-feng.tang@intel.com
In-Reply-To: <1627970362-61305-1-git-send-email-feng.tang@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Feng:

I am a little confused:
We have `MPOL_PREFERRED`, why you introduce `MPOL_PREFERRED_MANY` 
instead of making `MPOL_PREFERRED` support multiple preferred nodes?

-- 
Thanks
Gang Li

