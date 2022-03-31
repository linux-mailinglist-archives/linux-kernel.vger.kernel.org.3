Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51CEB4EE47F
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Apr 2022 01:10:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242817AbiCaXLn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Mar 2022 19:11:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231898AbiCaXLl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Mar 2022 19:11:41 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD39D65491
        for <linux-kernel@vger.kernel.org>; Thu, 31 Mar 2022 16:09:53 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id x31so964364pfh.9
        for <linux-kernel@vger.kernel.org>; Thu, 31 Mar 2022 16:09:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=cz3GyvYVzV3EdDN6sB+1FTc+c9hwF2tdZTNimFcZLNE=;
        b=H+ydDUAE3ArEgOwqdy5OxWseMKcHyBBJkrf6rlBsJ08wAxF9Cfxer5aaRBdgBo+lBD
         7Tr10y0n0emtB4xE73WkxCkt40MOlRQBb6a3WGikOLrM+Cho5mM51lIxbW4CLargfshe
         B45zfCaSVIKHhhRW/+TdaeCB+we/UQZMTIC4MfIpodgd2jcW2O3V3rBOy7DMLx8/7FQQ
         cUoJWnYDQtTkx8IxrPIcqLPUg1uRBPf8v8PH+tKE0CM80Il166tAXfLdoV9Plju11dCo
         WAwF170/GBBWVDX2RmCp+IAFgBIG06mIP9pmIznSuBaxb/RkhFvHvz5v3Dk/8zXfggW2
         R4HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=cz3GyvYVzV3EdDN6sB+1FTc+c9hwF2tdZTNimFcZLNE=;
        b=1pEE+HtQf27gzm7l1Ze9eKiLvFbRX1aoZnG8m2Ff1GKZToL2uWcra5s793AmMebP9+
         OSk09m+i46CyY0clHUqqdJ7QInn/kv7SBxxoQKeUqc5wWBLc+kdVjA5bl46HrTuOLVpd
         9YtbCXsUcwB9l0KV0ozRlf3OlfjyR9XOZRexOPcHwfiXlax73M/cQzTOvHesMdXzItow
         v4Y93tNpPXd4XZR9ub2dZdszuKMyPVV2bY1fRh7QQ9IQMcPAnqVVlbMPQtNTAQwGljQJ
         iv4XferyG626QBib1ZVhq5ZDUpGCrPxVnwY++fPbnhYEWycax51v/WZMKd5m3dnU4T9M
         euAQ==
X-Gm-Message-State: AOAM530SmBK4RzXzHKi70gm/Fe3Gzl4gYOtZB7suu+ZsEtC9f9eZOuK8
        PMjHnZoJB82UbDDizt4rI9mMow==
X-Google-Smtp-Source: ABdhPJytWJ8U0yLRH8Kl35OBWcKwI3vz+SnWKsJfk0otE+SEsTGPONodJMMiXqpN14jZTP8fDBsXYw==
X-Received: by 2002:a63:d149:0:b0:384:b288:8704 with SMTP id c9-20020a63d149000000b00384b2888704mr12390321pgj.112.1648768193276;
        Thu, 31 Mar 2022 16:09:53 -0700 (PDT)
Received: from [192.168.1.100] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id b16-20020a056a00115000b004f6ff260c9esm516225pfm.207.2022.03.31.16.09.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 31 Mar 2022 16:09:52 -0700 (PDT)
Message-ID: <078e8084-8fea-5b69-89a6-9488a28163cf@kernel.dk>
Date:   Thu, 31 Mar 2022 17:09:51 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [Drbd-dev] [PATCH 2/2] drbd: remove check of list iterator
 against head past the loop body
Content-Language: en-US
To:     =?UTF-8?Q?Christoph_B=c3=b6hmwalder?= 
        <christoph.boehmwalder@linbit.com>,
        Jakob Koschel <jakobkoschel@gmail.com>
Cc:     linux-kernel@vger.kernel.org, "Bos, H.J." <h.j.bos@vu.nl>,
        Brian Johannesmeyer <bjohannesmeyer@gmail.com>,
        linux-block@vger.kernel.org,
        Cristiano Giuffrida <c.giuffrida@vu.nl>,
        Lars Ellenberg <lars.ellenberg@linbit.com>,
        Mike Rapoport <rppt@kernel.org>, drbd-dev@lists.linbit.com,
        Philipp Reisner <philipp.reisner@linbit.com>
References: <20220331220349.885126-1-jakobkoschel@gmail.com>
 <20220331220349.885126-2-jakobkoschel@gmail.com>
 <4dcedb78-355f-ed1a-9af1-27e9e63b5643@linbit.com>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <4dcedb78-355f-ed1a-9af1-27e9e63b5643@linbit.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/31/22 4:28 PM, Christoph B?hmwalder wrote:
> Am 01.04.22 um 00:03 schrieb Jakob Koschel:
>> When list_for_each_entry() completes the iteration over the whole list
>> without breaking the loop, the iterator value will be a bogus pointer
>> computed based on the head element.
>>
>> While it is safe to use the pointer to determine if it was computed
>> based on the head element, either with list_entry_is_head() or
>> &pos->member == head, using the iterator variable after the loop should
>> be avoided.
>>
>> In preparation to limit the scope of a list iterator to the list
>> traversal loop, use a dedicated pointer to point to the found element [1].
>>
> 
> Hi Jakob,
> 
> Both of these look good to me, thanks.
> 
> Reviewed-by: Christoph B?hmwalder <christoph.boehmwalder@linbit.com>

Applied both, but shortened title of this commit. Jakob, please keep it
within the usual 74 chars. In general, it's great to use a cover letter
for anything that's more than one patch. Just some pointers if you're
doing more of these.

-- 
Jens Axboe

