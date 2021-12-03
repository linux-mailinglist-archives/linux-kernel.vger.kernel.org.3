Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E2748467EB2
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Dec 2021 21:13:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346763AbhLCURT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Dec 2021 15:17:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236287AbhLCURS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Dec 2021 15:17:18 -0500
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F082FC061751
        for <linux-kernel@vger.kernel.org>; Fri,  3 Dec 2021 12:13:53 -0800 (PST)
Received: by mail-pj1-x1033.google.com with SMTP id k6-20020a17090a7f0600b001ad9d73b20bso1080362pjl.3
        for <linux-kernel@vger.kernel.org>; Fri, 03 Dec 2021 12:13:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=FtsnonaCgeeXWkUpbIFtCTGH3x5YEtWnSU8hsFFOFQ8=;
        b=SsVZ9j6BQy02Ew+gnV9wLOGy9oPNl0FaFw+BZgUd5tXkYIhlfS7e6CTFzNMfpQ2eM+
         QjGwT+rW3uiRnmpfyuJQh1HAkSdzXiAv245qXsSZr67iUDfDqh3CmR75voeLdeXmg9DI
         tRSmJT89JiBZycwz5nUhQIDg2KnnhAFdquI1Zl5G3KpCJrygRoH/iWXZx49WDk6YI+6q
         Hc502pkA1rGvlIr9KHviSD+Hthe3/Y5kb0B819yOOrpsRU5C8sUHwVJrE3XDbZ26dVPG
         vy4DUSzZc0xX3p7zXRtZSjL2xBtrz23CX/D+2ubBDvfE7+738QOOByfn2n1PWSoYJCwL
         A11w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=FtsnonaCgeeXWkUpbIFtCTGH3x5YEtWnSU8hsFFOFQ8=;
        b=JSaiK5+o8BzBjUSIINzpdotIf9RYVnMqu9SXZ5OkSF17HBhpomIl3RFN7D0SlMfcaB
         NIrzcIq04YKZ+AhIBnqi8mWkZ+PdLn/XdUs2q//xzO47c4gG8O1Hfy7lRU1muSHjeDWw
         rJkP9LV2rHqWrt1KDZpwx/94agjR98j+sNIqWsp+IejmVRBTY/1orGDXhsDYPa1qut9h
         bDZmmRDydcayD3hY9s+48+c5L6hcelsbbKkC0SN+pDedAiV2mEpi97Mc7aAIIOSmM1r1
         ABezp65MdIAMh7eWEP/uBMXKg2yORXeuSttwbqOR9N3dmQcmnivUdXEIaKlhBWjHOa9u
         foHQ==
X-Gm-Message-State: AOAM531bbjHXmE+OmJ0sQIFmLLkC8y+24skTzu+YdYSbpFU8EywXBKFi
        EUUI3mb6u7Hul/h9wSRxZmc=
X-Google-Smtp-Source: ABdhPJxXzVG2sYqxADlAiMxzjhZyvclvJLSUQU9jtgjb/Rp/V5rLZ4ippABPvBwsldGphgFZ3N0N4w==
X-Received: by 2002:a17:902:8346:b0:142:9e66:2f54 with SMTP id z6-20020a170902834600b001429e662f54mr24885062pln.27.1638562433416;
        Fri, 03 Dec 2021 12:13:53 -0800 (PST)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id t10sm3219849pga.6.2021.12.03.12.13.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 Dec 2021 12:13:52 -0800 (PST)
Subject: Re: [PATCH v7 02/16] firmware: arm_scmi: Set polling timeout to
 max_rx_timeout_ms
To:     Cristian Marussi <cristian.marussi@arm.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     sudeep.holla@arm.com, james.quinlan@broadcom.com,
        Jonathan.Cameron@Huawei.com, etienne.carriere@linaro.org,
        vincent.guittot@linaro.org, souvik.chakravarty@arm.com
References: <20211129191156.29322-1-cristian.marussi@arm.com>
 <20211129191156.29322-3-cristian.marussi@arm.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <83ad3a4e-c00e-a84c-15fe-1d71207a0b37@gmail.com>
Date:   Fri, 3 Dec 2021 12:13:50 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20211129191156.29322-3-cristian.marussi@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/29/21 11:11 AM, Cristian Marussi wrote:
> Use transport specific transmission timeout (max_rx_timeout_ms) also for
> polling transactions.
> 
> Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>

Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>
-- 
Florian
