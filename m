Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF7EB49EECA
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jan 2022 00:23:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239525AbiA0XXH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jan 2022 18:23:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234804AbiA0XXF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jan 2022 18:23:05 -0500
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com [IPv6:2607:f8b0:4864:20::d36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C591DC06173B
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jan 2022 15:23:05 -0800 (PST)
Received: by mail-io1-xd36.google.com with SMTP id p63so4793110iod.11
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jan 2022 15:23:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=waYc1aDbhoW4JxhQYIjWfW1yuuw6mFpGE7KjHrII9Rk=;
        b=ay/3xyUZa97+9scYHi7AeKuZWhvPpjXBojyS2ih7PBquA0/4VEAG8+IzvVIam5r/rl
         CKW+Od9HemXN+i2BLAGgRnXdmZyIJ1kwbYqIvFJ2AdzoZlr2JowpR7OV+I2I4F3j6qq3
         +mEWujKMxGzAdGkNiKYdSQ+tgve8BWFspHdUk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=waYc1aDbhoW4JxhQYIjWfW1yuuw6mFpGE7KjHrII9Rk=;
        b=iAhYRlM3bb4tNi2aiAxNJONApyEer8A/BcZXyAnid1MiylPf/IcpEGBItpMcxA3MT6
         s/ZRRa4DJ/gZ6qdZMGxUw7m09z+4BfCKMGRJXsBq8k/XL1dt2IPLRFeHbIGbWktHA0ZI
         n/vNfVhXtn1PcDHCYSZVf895zaLpEpKyIy0I5fyfo/8zfzWkNbpP91Oq1fLiKAtglK3r
         2DgEriSvJHAoKI557VRLPYpwnp8M8LNlxQv3J/zXR2/WF+P2eEk699A/IRLcq9YnnmD1
         pyobLLVuS64t+cnLPXplSrfFke60LD67V+I+B6Q4MksjtiGPnX8Ll8aeQ/63PE67OotO
         gDFw==
X-Gm-Message-State: AOAM5301lcc2QhBT3o5OeWyK0WTTq51j5TT9GQZ87I9DOIz23xsFj0c4
        5bR3OglPu4r9Oe1el17ya5hXzCB01d35cg==
X-Google-Smtp-Source: ABdhPJxfAhSWrIgrxPmkv89i3NtG1TKkF8u+c0bSHPAnLc/ctPMSGOCHeplzdOiTrD7WsgclM8ACSQ==
X-Received: by 2002:a02:9713:: with SMTP id x19mr3179873jai.146.1643325785123;
        Thu, 27 Jan 2022 15:23:05 -0800 (PST)
Received: from ?IPv6:2601:282:8200:4c:fcdb:3423:ed25:a583? ([2601:282:8200:4c:fcdb:3423:ed25:a583])
        by smtp.gmail.com with ESMTPSA id w10sm4563365iow.44.2022.01.27.15.23.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Jan 2022 15:23:04 -0800 (PST)
Subject: Re: [PATCH 1/5] selftests: skip mincore.check_file_mmap when fs lacks
 needed support
To:     Cristian Marussi <cristian.marussi@arm.com>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     shuah@kernel.org,
        =?UTF-8?Q?Ricardo_Ca=c3=b1uelo?= <ricardo.canuelo@collabora.com>,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20220126102723.23300-1-cristian.marussi@arm.com>
 <20220126102723.23300-2-cristian.marussi@arm.com>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <c01f23e0-9f3a-d36e-623e-a9a5f2c3cbca@linuxfoundation.org>
Date:   Thu, 27 Jan 2022 16:23:03 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20220126102723.23300-2-cristian.marussi@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/26/22 3:27 AM, Cristian Marussi wrote:
> Report mincore.check_file_mmap as SKIP instead of FAIL if the underlying
> filesystem lacks support of O_TMPFILE or fallocate since such failures
> are not really related to mincore functionality.
> 
> Cc: Ricardo Cañuelo <ricardo.canuelo@collabora.com>
> Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
> ---

Thanks. Will apply to linux-kselftest fixes for rc3

thanks,
-- Shuah

