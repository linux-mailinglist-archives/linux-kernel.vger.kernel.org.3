Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9122652E136
	for <lists+linux-kernel@lfdr.de>; Fri, 20 May 2022 02:32:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344023AbiETAcq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 May 2022 20:32:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232460AbiETAco (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 20:32:44 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE7B9EAD1D
        for <linux-kernel@vger.kernel.org>; Thu, 19 May 2022 17:32:42 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id v5-20020a17090a7c0500b001df84fa82f8so6574885pjf.5
        for <linux-kernel@vger.kernel.org>; Thu, 19 May 2022 17:32:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=hK0bD57FsSw3L8bodek7cAZ5t1EEDgL383jyBNS+HSo=;
        b=cXh7+ESiMsxwif9hA6OTkuf50kMJvpO08AyPMHsd7hwvxrPExpG0vJ82jDvniWs0+2
         1Sfi+bfAY0XN07IlwLvC7zaG0QS76NerjCUCSAysalMqgMCkIe9qpJuanyOAqNMh8gEF
         Pbfm1pWZeRtJJOJStyfSBwzn35bqLg0AGoANMrKKPV5dKUzE7D6DzgjAxe6nWlnNnY0T
         SOmihJ9cNZSpdhC96IQ9Pv77SprYErNLjp33ErR+s9PBll//X97nBpKwwCgsXP8m7tEn
         1eXPH4J0hhRulw3QeWnbYUZhVc6Zk5UecXNVWo9MWf+CsjB68rkhMbBmDan21Ge83LUg
         oCgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=hK0bD57FsSw3L8bodek7cAZ5t1EEDgL383jyBNS+HSo=;
        b=EcIvKTDvtAuGtqH2O4Z1CpBw+FifJ9lviI7ZZCGYFbzrOef/DvmctNe17o7EtNZmDn
         FEr2IVjjBR+NSEoOHL/zj3fhnYuRk4LXAHYhCbKU71yeee9T7+McQgtLzRYyYMg6jMwD
         7iguH2ecPTFFthKSo8wJ6hgRXl4l7ue32XL52GMcRZh/m88KjG36fpuRqwxtUcUjzq8/
         tD1YOvfbXcI77blOUB648flsh21DnQTTLq30v6yOiZzFUB6l7PEWCmCwQ7DOgXN8/oaX
         dm+ixLmZVQhaolhSpFDwh0WN5mDwQRp1LUShE70ORF64XYtd0GGOG1SPjBWtOB7EZRF0
         GUQw==
X-Gm-Message-State: AOAM530yhDTnkgeljgLYD8bWanfvOq8koii1IT3HXoUBPraiBK6VAdUs
        zwwUMavPHtkNSezzfiktsT897g==
X-Google-Smtp-Source: ABdhPJwv0nW20fvbDWx39EtTewmoDWR4H8qeTmTTVbaH/PNpfqLLOfKhY5/rrZJXH1XduCH/65Vspw==
X-Received: by 2002:a17:902:f605:b0:154:aa89:bd13 with SMTP id n5-20020a170902f60500b00154aa89bd13mr7307700plg.112.1653006762205;
        Thu, 19 May 2022 17:32:42 -0700 (PDT)
Received: from [192.168.1.100] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id u18-20020a170903305200b00161a16f0050sm4223792pla.222.2022.05.19.17.32.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 May 2022 17:32:41 -0700 (PDT)
Message-ID: <35b87349-d60a-cc97-5dfe-1eb42ffb432b@kernel.dk>
Date:   Thu, 19 May 2022 18:32:40 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH] random: convert to using fops->write_iter()
Content-Language: en-US
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     LKML <linux-kernel@vger.kernel.org>
References: <f871a510-d262-bc98-757e-204976e1b82c@kernel.dk>
 <YobePA1M0htNbTRN@zx2c4.com>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <YobePA1M0htNbTRN@zx2c4.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/19/22 6:18 PM, Jason A. Donenfeld wrote:
> Hi Jens,
> 
> On Thu, May 19, 2022 at 05:43:15PM -0600, Jens Axboe wrote:
>> +	while (iov_iter_count(iter)) {
>> +		block_len = min(iov_iter_count(iter), sizeof(block));
> 
> Whereas get_random_bytes_user() used a separate len param, it looks like
> this function is using iov's len. Maybe that's not such a bad idea? I'll
> give a shot at fixing that up in both places, and you can tell me what
> you think.

Yes that'd be fine, it's just reading iter->count anyway. Agree that
it'd be nicer to just kill the separate 'len' as the copy advances the
iter anyway.

-- 
Jens Axboe

