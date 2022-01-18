Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 559E4492194
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jan 2022 09:46:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344964AbiARIqb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jan 2022 03:46:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344912AbiARIq3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jan 2022 03:46:29 -0500
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com [IPv6:2607:f8b0:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEAE4C061574
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jan 2022 00:46:28 -0800 (PST)
Received: by mail-oi1-x229.google.com with SMTP id g205so27436179oif.5
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jan 2022 00:46:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kali.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=rvQoDlyZQ59PJvrlQATsiWyVpyIj2xGvJPIb1Y/t7rs=;
        b=F86pb41paScuCcfq2GNBr2zkoTc3ZzbIPkvCTr+FhjFRlXsdRV60fc2+J4JoFQutNN
         V+4o53iR2jcHuiBJxkm2VIcx8L1vqSP8aPj8wadr1g+zUPNSYtTMzoXxahtAz29hFrIc
         A4Ad1JOZtsLM9z7L33U6oVGdyravbJ0uBVPBWKY//YxnGnatGf8v5yVRbmT2N+rEIFbE
         H/D9/mD4Nib0BYseZvygxGUeI2NRzmsc/V00y8KqRdelXMVlZyTKaQ9qKA0hFnTcTvvu
         3GPGCjBdWa4rA1t6tV0LHtdZB4yHH/kHUUSqZXD6+71+zhNK5o45XgJ6mB8GEnr1vB/F
         r2PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=rvQoDlyZQ59PJvrlQATsiWyVpyIj2xGvJPIb1Y/t7rs=;
        b=oAWMBPbP18w9S3jw2fIqKM0OCsE8Gf95VNKhcChO7Knl5vaHvTanaX95/KOVG31fkn
         REFVgQOQqpWEKKBrNwd91GtgKDnDeMbeoRFEH9YoXJQYgK5jsDUb3aWy67QLYFTKi5Ch
         QChu/0WscRqAqyXkhPhmvb60VznW05Oc2ofT5u+Rc/owb3I9f3ecVrFc4BeIooh9jn6V
         /4Khl27zYOHKSCGJLrJw+u62cTEQKtJj3o2vEO9R/dJdfRQ6fyeTzUZ+yn089vnFtr3+
         HD5nOx/jlqGQC54XXlGZQdMGBPqew5Pfp6486S5YOphaOG953Y2bcIqIeuQjsnUvj9US
         SN7A==
X-Gm-Message-State: AOAM533WqkBR0PyjrNccBUFYekV7bmKXRh2zfJxsofLr1vDdTUS77xWO
        2hQNFV1Na48W0xWDv65cp+nBYA==
X-Google-Smtp-Source: ABdhPJz5qXBXZndqzFFFFFPVGYrgGvdx+LKUkqcChUZPwQ13WWxc7OhMhDXwc1A7IT44xOSQ8met0Q==
X-Received: by 2002:a05:6808:23c3:: with SMTP id bq3mr6077378oib.124.1642495588144;
        Tue, 18 Jan 2022 00:46:28 -0800 (PST)
Received: from [192.168.11.55] (cpe-173-173-107-246.satx.res.rr.com. [173.173.107.246])
        by smtp.gmail.com with ESMTPSA id p23sm6628768otp.46.2022.01.18.00.46.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Jan 2022 00:46:27 -0800 (PST)
Message-ID: <7e8d2d44-23eb-1589-2b71-4661e80394e2@kali.org>
Date:   Tue, 18 Jan 2022 02:46:25 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.4.1
Subject: Re: [PATCH v10 6/6] usb: dwc3: qcom: Enable the interrupts during
 probe
Content-Language: en-US
To:     Sandeep Maheswaram <quic_c_sanm@quicinc.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Felipe Balbi <balbi@kernel.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Doug Anderson <dianders@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Mathias Nyman <mathias.nyman@intel.com>
Cc:     linux-arm-msm@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, quic_pkondeti@quicinc.com,
        quic_ppratap@quicinc.com
References: <1642398248-21753-1-git-send-email-quic_c_sanm@quicinc.com>
 <1642398248-21753-7-git-send-email-quic_c_sanm@quicinc.com>
 <93b68251-7e7e-ac92-fb47-346c410744b2@kali.org>
 <bd9992de-3cd7-d07e-f8e3-e4f7a1e37cfc@quicinc.com>
From:   Steev Klimaszewski <steev@kali.org>
In-Reply-To: <bd9992de-3cd7-d07e-f8e3-e4f7a1e37cfc@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 1/18/22 12:30 AM, Sandeep Maheswaram wrote:
> Hi Steev,
<snip>
>> Hi Sandeep,
>>
>> I was testing this series on my Lenovo Yoga C630, and with this patch 
>> in particular applied, my system will no longer boot. Unfortunately I 
>> don't get any sort of good output at all, I just get hung tasks when 
>> trying to probe things it would seem.
>>
>>
>> With the other 5 patches in the series applied, the system still 
>> boots and works correctly.
>>
>>
>> -- Steev
>>
> Will check this. Is your controller in host mode or device mode?
>
> Regards
>
> Sandeep
>
Both usb_1_dwc3 and usb_2_dwc3 are in host mode

-- Steev

