Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8093501837
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Apr 2022 18:07:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233988AbiDNQGC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Apr 2022 12:06:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349398AbiDNP4s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 11:56:48 -0400
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com [IPv6:2607:f8b0:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43DA110075A
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 08:36:23 -0700 (PDT)
Received: by mail-oi1-x235.google.com with SMTP id e189so5768107oia.8
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 08:36:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=Bluv1hkXdADa/7/ZGpKxIvQTb4QNQVu1xgeDIBHpnmA=;
        b=BtHWKM9d1THYkjT+ga4YZO4bDYrhjKTpWYIt+eZu2YVKbQVbYeaC1gj6OFTiCTMcQ3
         Wzmef9FKChuZGMp0cbSCbBReu8v/CYfodfCfPs3Y/toG8PW0dm6lwO58f5fVfyFIRnAG
         3ekfqjy+hiq5ivW2bxtS15HFXjPlYSn23a1JpOKiWmDKWwkbcnITy1IIaFk1ljNW4T9U
         zy0HGngXnzWb2pv1ZnwCuuVkE+nVSAdv24mb1jm7rc3CYGzwm+JRDqneyuvLdcZf43D3
         oleo0yg1DqWl1KHkqxlxMEAMCPgbzN0j5aPN9RFYm3SIht7LJCALB18o0m7s8ExV3hJc
         66cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:message-id:date:mime-version:user-agent
         :subject:content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=Bluv1hkXdADa/7/ZGpKxIvQTb4QNQVu1xgeDIBHpnmA=;
        b=cYn2JPV+udU24fQjqMiFKoD5/Obrqm9HdnqhMyV3lUe43e/xkJNwsbiqJDiRtYxe4a
         DYgFcNSjmTFhJexBW+qLCOZ94n95e+c/S2eNeaEX7urs7M1sAkKLoOD7SWuzmoHAJ/NV
         hXVju3cp3NvYxtKfjhMYq5xQWWvXeHTcZ7ZY1ZsKB67qDB6/C5sRThW5L2HdV+FbERGr
         XTJKVQOHan1A0g32GiYCS4o7wtoFmFcPPKaexaw3MKD4CIqwcOfyY/XFrS6L7nLy4kD/
         0K5Z6t2P4mQvB/4uxfuSJkMxw4q47UL0czfLnItsezDI4KT/ZdzK38no3b4UkqcIcuLN
         JFuQ==
X-Gm-Message-State: AOAM5302m3bcIY5J2uBHeKeIiiAgMgwITT9rWf+m209NdZ9baYV89Llk
        BGKSCxcVp3gkQI8qu5bn815oOn2qbm9cxw==
X-Google-Smtp-Source: ABdhPJyWUMklqQP5SFVg65gdz6e4kSw9omemOlS3nC17dX0xheswnb462aiANRXRNTsRoHNMhYSxgQ==
X-Received: by 2002:aca:f1d4:0:b0:2ef:1fa6:3c74 with SMTP id p203-20020acaf1d4000000b002ef1fa63c74mr1812903oih.89.1649950582688;
        Thu, 14 Apr 2022 08:36:22 -0700 (PDT)
Received: from ?IPV6:2603:8090:2005:39b3::100e? (2603-8090-2005-39b3-0000-0000-0000-100e.res6.spectrum.com. [2603:8090:2005:39b3::100e])
        by smtp.gmail.com with ESMTPSA id hl26-20020a0568701b1a00b000e2ff513be1sm739212oab.55.2022.04.14.08.36.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Apr 2022 08:36:22 -0700 (PDT)
Sender: Larry Finger <larry.finger@gmail.com>
Message-ID: <80414992-a662-e884-05ca-dcc0c8b07b99@lwfinger.net>
Date:   Thu, 14 Apr 2022 10:36:20 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH 6/7] staging: r8188eu: always log firmware info
Content-Language: en-US
To:     Michael Straube <straube.linux@gmail.com>,
        gregkh@linuxfoundation.org
Cc:     phil@philpotter.co.uk, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
References: <20220414083853.3422-1-straube.linux@gmail.com>
 <20220414083853.3422-7-straube.linux@gmail.com>
From:   Larry Finger <Larry.Finger@lwfinger.net>
In-Reply-To: <20220414083853.3422-7-straube.linux@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/14/22 03:38, Michael Straube wrote:
> The local static variable log_version prevents logging the firmware
> information more than once, e.g. when the device is unplugged and
> plugged again. That is not necessary and complicates the code. Remove
> it.

I think the slight complication of the code, one static variable and one if 
statement, is worth not spamming the logs. My recollection is that there are 
other cases besides unplugging and replugging that lead to the firmware being 
reloaded.

Larry

