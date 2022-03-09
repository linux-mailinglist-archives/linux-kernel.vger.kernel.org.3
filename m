Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DAA604D3DAA
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Mar 2022 00:43:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237001AbiCIXoV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Mar 2022 18:44:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229897AbiCIXoS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 18:44:18 -0500
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA25CDCE10
        for <linux-kernel@vger.kernel.org>; Wed,  9 Mar 2022 15:43:17 -0800 (PST)
Received: by mail-pg1-x531.google.com with SMTP id q19so3251895pgm.6
        for <linux-kernel@vger.kernel.org>; Wed, 09 Mar 2022 15:43:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=Yh83gLKF0p1HHh6qhQqRKF6fIAAp3Y2uQvxaiLyuPsU=;
        b=xoNdTgj6Ln1Fby9YRHf9Xc9g24AUqIN6pmO1h5HBqRS9ulU7ojjZYPkKArHCMfPiJN
         sLNBnWD6YYNrisE38OEqgb5UEAnBLGj0yXzUlkYCwBlxeGa8UL7hDBf6sL70YuWcyfbd
         3Q5ITx3tG/aIO6lNJMpXkB9lRHAMUR2l1eal5nMm7kJEpp2/TwZHM/whmAhP4P/MJE4i
         gHOhUndGPjMgyBJH3CQ2q54zvhhiTP4+JquA8FbQXpsXTntZykXiCW8Z8xr4YClA7QuM
         mEPF8g3jmgvDVnwkoy8cI4FIv2Vxr3jnC0ZMj1d/w5V9lbP/4jPSG4LDdBpy4W0ZvkI5
         zMNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=Yh83gLKF0p1HHh6qhQqRKF6fIAAp3Y2uQvxaiLyuPsU=;
        b=pD2tA++aXWsQJ69rT2hJd4SLVWbKcdaPSXiXQD36mMX526CNFMfny1W0MMeNSS8V33
         Nu3aGEyRQZ+tZxDFcIkPpexkc2hW5SZ1v7j1k8fnIHDOA/ilXIpgxR3dTrCMk0tiN+A4
         GQb7ZSYFH9+1PFNBRsnyPqXEH/RRQsHVDZvcgqmU6xdO3csx1Y78ihqkac9gbZ2ergW8
         /FI05u/bS1gJc2jIh6kmRHzD1beC0KcyUOjK0cfn73txjpeHF52KB+68yvdV5YCqTrPi
         NFTBc9BdIC0q5oDzPMqGyd46iCjTMuz/4Qg3R5GTxbF12kc/pvkx4YmNuv+VJvd3eWij
         e6ig==
X-Gm-Message-State: AOAM530nFxKx/3sfhjZR+oTlxfvvivcdTJtJbp3iZCNOfAx6nb9kDm1U
        LX8M52yr429Rv1pvqxpjYnHZvQ==
X-Google-Smtp-Source: ABdhPJxtyuiApdlC6vCUDN2zD1v9b70l5hGiGyrK89jPnH8X3n1cNInXybB9F7RbawZlAYomV3L+NA==
X-Received: by 2002:a63:6b42:0:b0:37c:4e5c:a903 with SMTP id g63-20020a636b42000000b0037c4e5ca903mr1683809pgc.463.1646869397195;
        Wed, 09 Mar 2022 15:43:17 -0800 (PST)
Received: from [192.168.1.100] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id k6-20020a056a00134600b004f755f386d8sm4100146pfu.87.2022.03.09.15.43.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Mar 2022 15:43:16 -0800 (PST)
Message-ID: <dc8bfa6b-5e3b-e2a9-b7b5-da5bbc70d3bc@kernel.dk>
Date:   Wed, 9 Mar 2022 16:43:15 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH v5 1/2] io_uring: minor io_cqring_wait() optimization
Content-Language: en-US
To:     Olivier Langlois <olivier@trillion01.com>,
        Pavel Begunkov <asml.silence@gmail.com>
Cc:     Hao Xu <haoxu@linux.alibaba.com>,
        io-uring <io-uring@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <cover.1646777484.git.olivier@trillion01.com>
 <84513f7cc1b1fb31d8f4cb910aee033391d036b4.1646777484.git.olivier@trillion01.com>
 <7f39095c-1070-7a70-91a0-b0ccb33c368b@kernel.dk>
 <36cd0f716bda419f477c3256769f382a31461481.camel@trillion01.com>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <36cd0f716bda419f477c3256769f382a31461481.camel@trillion01.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/8/22 10:36 PM, Olivier Langlois wrote:
> On Tue, 2022-03-08 at 17:54 -0700, Jens Axboe wrote:
>> On 3/8/22 3:17 PM, Olivier Langlois wrote:
>>> Move up the block manipulating the sig variable to execute code
>>> that may encounter an error and exit first before continuing
>>> executing the rest of the function and avoid useless computations
>>
>> I don't think this is worthwhile doing. If you're hitting an error
>> in any of them, it's by definition not the fast path.
>>
> Well, by itself it is not a big improvement but it is still an
> improvement.
> 
> but most importantly, it has to be considered in the context of the
> current patchset because in patch #2, the following step is to
> 
> 1. acquire the napi spin lock
> 2. splice the context napi list into a local one.
> 3. release the lock
> 
> If this patch is not in place before patch #2, you would need undo all
> that before returning from the sig block which would make the function
> bigger when all that is completely avoidable by accepting this patch...
> 
> Both patches were together in v1 but I decided to break them apart
> thinking that this was the right thing to do...

Yeah ok, it does make sense in the context of patch 2. Thanks!

-- 
Jens Axboe

