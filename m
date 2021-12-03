Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C608D467EB6
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Dec 2021 21:16:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383053AbhLCUUM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Dec 2021 15:20:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1383061AbhLCUUE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Dec 2021 15:20:04 -0500
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47030C061751
        for <linux-kernel@vger.kernel.org>; Fri,  3 Dec 2021 12:16:40 -0800 (PST)
Received: by mail-pj1-x1031.google.com with SMTP id j6-20020a17090a588600b001a78a5ce46aso6059950pji.0
        for <linux-kernel@vger.kernel.org>; Fri, 03 Dec 2021 12:16:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=s1YGfoohAwJTdn17bFOYUSRwxd9UWURAma+RV0fDPFA=;
        b=B9xDbQyjmwjPmrn/9gVjQgupJqvt8whBxYfvsDnhPomJvKsLw0+hDNrHiUtXZn+kLB
         i2gZjzWzqt0fNaFe2U/5e1XgDcMt4P6oXKxcTjcK6foXolWLWxcc8CEjfBO9htega3jt
         15WLnyTp1CXlFikABDrrWagPSFqf7kveU2s1mwccid+uPuNFxAj0LqBIdSpTLfwtTX8q
         HdmPzUsIi4QRJjNrBZO1cmLEv0LX3u7EQTmldHTfyND3WqkQjMgCqkOI8057MQ7VzRAz
         Ha2ln15JPZBacSNuODchyyrJHu50JxM0le1hldpM8+f5NghClwAcaHMey9nMp9hDIlGd
         9G6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=s1YGfoohAwJTdn17bFOYUSRwxd9UWURAma+RV0fDPFA=;
        b=UrfTys48OTjEpYBJnObqX3ygSkFt3rHNRtRNv6OnOz6RiTJ4IbzGhmF1IdJ1Ylmxoz
         gcQUBOl4lqP5FBh46lLhVBQxl19oFjUL2jVxns13ShkXMLJFqmlq+tpPuXzRHxgTFQp5
         hwUsS4dLW/BmZ8Jk38B+DQGHcdf5q6BBQSyX6A1VlCzaj1jlFeeVvGMIoNJF5Fs2hsSp
         ieW0KUx83rcNQZDbnrwBd8egdXr6fJYS5atbQ3rsRwqBFJt7K0LIwiXQHHWm/UYzqoof
         JpGNziax13rDE2tBnf++LAxTCjZZ8NjobULOE+PzzIpGkWKKBif+CamlVlbNJYIJN7NT
         ibKQ==
X-Gm-Message-State: AOAM530eOLy5mZjVvPgf0fuFydOjluI2h3pWNEC38WbY4UZDVV14im4r
        4jwG0gkVPayFLnxZWi7ik0Q=
X-Google-Smtp-Source: ABdhPJweSWCIH/iBMs9GQBxCf48SxPvhjdVYztQueXVgg7ChfAfMCk6sgy6nzm2VtkaVTLSB4pK2gA==
X-Received: by 2002:a17:90b:105:: with SMTP id p5mr16911009pjz.60.1638562599813;
        Fri, 03 Dec 2021 12:16:39 -0800 (PST)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id n6sm3232109pgk.43.2021.12.03.12.16.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 Dec 2021 12:16:39 -0800 (PST)
Subject: Re: [PATCH v7 15/16] firmware: arm_scmi: Add atomic support to clock
 protocol
To:     Cristian Marussi <cristian.marussi@arm.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     sudeep.holla@arm.com, james.quinlan@broadcom.com,
        Jonathan.Cameron@Huawei.com, etienne.carriere@linaro.org,
        vincent.guittot@linaro.org, souvik.chakravarty@arm.com
References: <20211129191156.29322-1-cristian.marussi@arm.com>
 <20211129191156.29322-16-cristian.marussi@arm.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <721082b0-bba1-aaa1-058b-d4565fd592a0@gmail.com>
Date:   Fri, 3 Dec 2021 12:16:38 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20211129191156.29322-16-cristian.marussi@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/29/21 11:11 AM, Cristian Marussi wrote:
> Introduce new _atomic variant for SCMI clock protocol operations related
> to enable disable operations: when an atomic operation is required the xfer
> poll_completion flag is set for that transaction.
> 
> Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>

Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>
-- 
Florian
