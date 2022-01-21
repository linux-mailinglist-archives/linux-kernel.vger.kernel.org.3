Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 24F1C49653F
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jan 2022 19:49:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229895AbiAUStk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jan 2022 13:49:40 -0500
Received: from mail-ed1-f47.google.com ([209.85.208.47]:38553 "EHLO
        mail-ed1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbiAUStb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jan 2022 13:49:31 -0500
Received: by mail-ed1-f47.google.com with SMTP id j23so39234849edp.5;
        Fri, 21 Jan 2022 10:49:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=yd9NjM+J8IzfAOnRvRYJ89k99PztsGHb23iRbx7emk4=;
        b=55Ty3kXJQnLA6nc9w3qNnYKqiieZ1RsXfVhOhhpdlK1QzKC1laeKZ5SB2lt2LRI13r
         xs3kLt/LdPNBlndUs3tti+FYIRU0sbd0EfUooBEizKWu72MJNS/om5O+of5sS9Zv/vJd
         YbBwcSd9XzdVPjcWwJLyBeIAFysa6ZLrWMQP/stP3IMLpZoknJ64QISQWdaJiBT2SVu1
         kMRSH2lIJs7RhZH+TByImo/0GlSy+FWDcDg0Rb9735tCaJuOWws3URr35HAJG+Vig8vl
         s7qlJgSpjyK3S3RoErFcNI18h5KD3GXpOiZDlbrNte8Lxv1YnxWgQXRtDFrXBlK5vMt/
         BVXQ==
X-Gm-Message-State: AOAM532Ka7ofnZDtFAN/jL7D3mYOKJ0QALMOVIKYg19czSQQb13nYbqf
        3vAL1D0Dh4/5mZL3up2g+A0=
X-Google-Smtp-Source: ABdhPJxd9uYz8GeC6WCGv+zJnIx78tC/3nBmDpRPsOSZZdscOhAJmD2pEZbEUw9IjAZFErgZMkETEw==
X-Received: by 2002:a05:6402:11c7:: with SMTP id j7mr5549224edw.315.1642790968431;
        Fri, 21 Jan 2022 10:49:28 -0800 (PST)
Received: from [192.168.0.51] (xdsl-188-155-168-84.adslplus.ch. [188.155.168.84])
        by smtp.googlemail.com with ESMTPSA id u18sm2275416eje.37.2022.01.21.10.49.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Jan 2022 10:49:27 -0800 (PST)
Message-ID: <625e47a5-a6a6-826f-6f9d-f036732588b6@kernel.org>
Date:   Fri, 21 Jan 2022 19:49:26 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.1
Subject: Re: [Patch V3] memory: tegra: Add MC error logging on tegra186 onward
Content-Language: en-US
To:     Dmitry Osipenko <digetx@gmail.com>,
        Ashish Mhetre <amhetre@nvidia.com>, thierry.reding@gmail.com,
        jonathanh@nvidia.com, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Snikam@nvidia.com, vdumpa@nvidia.com
References: <1642763962-32129-1-git-send-email-amhetre@nvidia.com>
 <dc9b0c08-bd2a-6ffa-ad75-47afd036f3ef@gmail.com>
From:   Krzysztof Kozlowski <krzk@kernel.org>
In-Reply-To: <dc9b0c08-bd2a-6ffa-ad75-47afd036f3ef@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/01/2022 13:31, Dmitry Osipenko wrote:
> ...
>> @@ -529,12 +536,44 @@ static irqreturn_t tegra30_mc_handle_irq(int irq, void *data)
>>  		u8 id, type;
>>  		u32 value;
>>  
>> -		value = mc_readl(mc, MC_ERR_STATUS);
>> +		switch (bit) {
> 
> Again, I see that the code wasn't tested :/ Shouldn't be too difficult
> to create memory-read errors to check that at least basics work
> properly. Please always test your changes next time.
> 
> So it must be "switch(BIT(bit))" here, please write it like this:
> 
> u32 intmask = BIT(bit);
> ...
> 	switch(intmask) {
> 

Also, please build your changes with W=1... It's the second try of
sending un-tested and not-working code. This time also with a compiler
warning. This looks very bad :(

For big companies with a lot of engineers, like nVidia, it is useful if
some internal review happens. It is a nice way to offload community
reviewers which are - like maintainers - a scarce resource. Doing
internal review is not a requirement, but helps to find such mistakes
earlier, before using the community. It is simply nice to us.

Best regards,
Krzysztof
