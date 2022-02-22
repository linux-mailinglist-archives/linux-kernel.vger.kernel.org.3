Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 794CF4C0462
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Feb 2022 23:11:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236014AbiBVWLX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Feb 2022 17:11:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230097AbiBVWLV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 17:11:21 -0500
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62F24106C81
        for <linux-kernel@vger.kernel.org>; Tue, 22 Feb 2022 14:10:55 -0800 (PST)
Received: by mail-wr1-x42d.google.com with SMTP id v21so814459wrv.5
        for <linux-kernel@vger.kernel.org>; Tue, 22 Feb 2022 14:10:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=9PhuirZKyrshj2xzHwCPB3sNg2460aymkJZ+uzZPvWk=;
        b=P0OXyR3tjWDnONisqSw6uveH5aNEA7juRm8wsr25YYN+lco/41Y6+NYuCev6mxb+8S
         v61wZ9UKqGk1CqH/4J8dGRpt4Jdx9GUAepLFtVSW0WxyHFSAhnxvN3XJm7pwgE6nfh8L
         Gf6LG5/OYl4ItRd81z8i+Iufoz9nYao73AdqQ9/RJd43lWGNcUhexZZURnRPO4dFr+/S
         +oSpVoRvtJpn0dPAVm4o4nO+88IlsJ676R4ZqXdgIBKd8Cb2eZPx4ljSNV+0n8Hfma3U
         RQM10X/MfKlJrc3rdipcG6qxxge4VtHrpN5sOdKkXoDV6UsVEz5hasbYcKqXI+wHHMuj
         V/UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=9PhuirZKyrshj2xzHwCPB3sNg2460aymkJZ+uzZPvWk=;
        b=hQqKeDL2yPGDybiKBt8nwoFZbRUdD5yUB4ibC/Ju9vayQEG9oZjxx5CbIgsV5LFu14
         oUCS9lHels5erZmzBzyoWWryXGlt0oaJGPvCAJVzQWMOfFP+FvFOJyu9NgOzFjUf96ye
         zRlRpG4YHpLe9e5GyuhxkL1HSR8sJtJ0iR8UMqRL/RRps/HiNWs4XlfIL95v/1EN8Kd5
         dE0cBn3OijcN9F444xCwpkSsbnPsMELK963k7irEHlnjIEqpHWQcBbWeBxUcIu20w6bo
         JCjANQQmzLmiSzsBpNtYrLmNYQxd6JEWqwwL75YdwEyDnsFYhcE6vLxND2KC1Hd6dVuE
         rXXA==
X-Gm-Message-State: AOAM530+LGi5XKN6iKOF0snm4bIXVa1fNc7ReUI7AYLDN2PC/fVFNQMc
        xex4WuyQ4mrECl6FSEu5cYMU9g==
X-Google-Smtp-Source: ABdhPJz3ulqHBA1Cr5EV+1p6FBOU7Brv4CPwBTwuB/14UXzeY8poOnZKzeZgSVOpWsEqhwudjG1+ZQ==
X-Received: by 2002:a5d:6f0b:0:b0:1ed:aac8:2853 with SMTP id ay11-20020a5d6f0b000000b001edaac82853mr277180wrb.260.1645567853818;
        Tue, 22 Feb 2022 14:10:53 -0800 (PST)
Received: from ?IPV6:2a01:e34:ed2f:f020:7f69:edd5:61dd:b18a? ([2a01:e34:ed2f:f020:7f69:edd5:61dd:b18a])
        by smtp.googlemail.com with ESMTPSA id v9sm15814953wrx.27.2022.02.22.14.10.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Feb 2022 14:10:53 -0800 (PST)
Message-ID: <a5730ce7-a24c-0738-e76f-e06d56601408@linaro.org>
Date:   Tue, 22 Feb 2022 23:10:51 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 1/2] thermal: cooling: Check Energy Model type in
 cpufreq_cooling and devfreq_cooling
Content-Language: en-US
To:     Lukasz Luba <lukasz.luba@arm.com>
Cc:     amit.kachhap@gmail.com, viresh.kumar@linaro.org, rafael@kernel.org,
        amitk@kernel.org, rui.zhang@intel.com, dietmar.eggemann@arm.com,
        Pierre.Gondois@arm.com, Matthias Kaehlcke <mka@chromium.org>,
        Doug Anderson <dianders@chromium.org>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220207073036.14901-1-lukasz.luba@arm.com>
 <20220207073036.14901-2-lukasz.luba@arm.com>
 <4e090ffe-c19b-8e2c-0396-72dc33361f35@arm.com>
 <211a3606-2f4c-227b-33aa-177ef68a49a3@arm.com>
 <3d1719ca-d4a4-f904-e284-b857414669ba@linaro.org>
 <27df4e4f-b6d7-9a58-f2dd-d6afa748e217@arm.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <27df4e4f-b6d7-9a58-f2dd-d6afa748e217@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Lukasz,

On 22/02/2022 19:31, Lukasz Luba wrote:
> 
> 
> On 2/22/22 18:12, Daniel Lezcano wrote:
>>
>> Hi Lukasz,
>>
>> I don't think it makes sense to remove the support of the energy model 
>> if the units are abstracts.
>>
>> IIUC, regarding your previous answer, we don't really know what will 
>> do the SoC vendor with these numbers and likely they will provide 
>> consistent abstract values which won't prevent a correct behavior.
>>
>> What would be the benefit of giving inconsistent abstract values which 
>> will be unusable except of giving a broken energy model?
> 
> The power values in the EM which has abstract scale, would make sense to 
> EAS, but not for IPA or DTPM. Those platforms which want to enable EAS,
> but don't need IPA, would register such '<a_good_name_here>' EM.

Sorry, but I don't understand why DTPM can not deal with abstract values?


>> Your proposed changes would be acceptable if the energy model has a 
>> broken flag IMO
> 
> That is doable. I can add that flag, so we can call it 'artificial' EM
> (when this new flag is set).

It is too soon IMO, I would like to see the numbers first so we can take 
an enlighten decision. Right now, it is unclear what the numbers will be.


> Let me craft the RFC patch with this new flag proposal then.
> Do you agree? Can I also add you as 'Suggested-by'?
> 
> Thank you for coming back to me with the comments.


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
