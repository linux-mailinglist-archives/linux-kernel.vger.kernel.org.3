Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DED7655783C
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jun 2022 12:53:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231243AbiFWKxr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jun 2022 06:53:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229575AbiFWKxp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jun 2022 06:53:45 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06C244B43F;
        Thu, 23 Jun 2022 03:53:45 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id f16so17093230pjj.1;
        Thu, 23 Jun 2022 03:53:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=PnvkAsQSRr+CilVl3+koCkcLflQp+hqVHTyDSK0aCmI=;
        b=XeRXRtt52JhGfxzXNOQkfajp4Bqb9QvJHdXfuDXGEz6gCuABtUhlCryjsmwvQA36I7
         2nghrcPOaveNCALAQ6wihdy62clsG87QE3kFHdkaw7vtKOZ4okuxJD/AUTvYcERYTrea
         zgDElUTHD6Uihta7CIOMNYJA20e4ErZHL0tre0SsqeKSnDMTFJos3YNAz7Mvvwy2Id3U
         +vKwUaFFC8f7IuxiUnFilpYJjGJWDSWenqRA2FVnX2uwnaxksmDQ+OWmpvfQ1L5PH2d8
         E0AzBRlYjlOZlyErextlMFBGQQD5mYdFJ6f1OmSLCgBx9sMzOCJg8jwHCvslfdcDM92e
         TYyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=PnvkAsQSRr+CilVl3+koCkcLflQp+hqVHTyDSK0aCmI=;
        b=0NP7JkCRHcRN2sd+gar9PmU6i8WaTmkYjLhdBBQAafdM5NqvvJaUPE6h8eSHSfi2Z2
         09tr2CYpelv1+s+/FyLfkAonN5HajZyujDkgeOO0cZ1eAA5HnTi7KPAWheb9LXBtsNo1
         K8bzTzJ8BEXbDa2gnLbYoyXbqTvLHXGBvnq3B9a+Gf7j7FBoRpIk9qIe056Bg+skUDzw
         AZVEWjLxgzlXTn6uWlDRHoNKnU/lpCswDAlAHWGQaeI5pYgOHeCEr0Xx3SK1+HpcA2rA
         vFPMWvbcgnrKauLZfV65TjsJypVy2KWXWKVnIPx53CDFYkW13Om4/UI0NYmVF0vE7uzK
         C6Wg==
X-Gm-Message-State: AJIora9M1CNMTFdCVmmnTdLJYR8iL0Q8tJgZzW6oEgS1NWM9DSYhhT+8
        PhpAx08jlC7KdcPVx7X3L8Q=
X-Google-Smtp-Source: AGRyM1sFMUDJSbkUJDlmBP09tydMqhQdXkeSUGyBSzcnguUS4pkHUTBca7eqjsPVa+59ATgrKKiWGw==
X-Received: by 2002:a17:90a:cb84:b0:1ea:ffd2:3075 with SMTP id a4-20020a17090acb8400b001eaffd23075mr3472599pju.106.1655981624500;
        Thu, 23 Jun 2022 03:53:44 -0700 (PDT)
Received: from [192.168.50.247] ([103.84.139.165])
        by smtp.gmail.com with ESMTPSA id w9-20020aa79a09000000b00525204224afsm9314834pfj.94.2022.06.23.03.53.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Jun 2022 03:53:44 -0700 (PDT)
Message-ID: <2d7eaa45-2193-7fcb-5c9b-6394bab2ae95@gmail.com>
Date:   Thu, 23 Jun 2022 18:53:41 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH] rpmsg: fix possible refcount leak in
 rpmsg_register_device_override()
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        bjorn.andersson@linaro.org, mathieu.poirier@linaro.org,
        gregkh@linuxfoundation.org
Cc:     linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220623073605.27386-1-hbh25y@gmail.com>
 <050a390d-1ede-04ee-3870-9434ffd671b8@linaro.org>
From:   Hangyu Hua <hbh25y@gmail.com>
In-Reply-To: <050a390d-1ede-04ee-3870-9434ffd671b8@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/6/23 16:15, Krzysztof Kozlowski wrote:
> On 23/06/2022 09:36, Hangyu Hua wrote:
>> [1] commit 1680939e9ecf ("rpmsg: virtio: Fix possible double free in
>> rpmsg_virtio_add_ctrl_dev()")
>> [2] commit c2eecefec5df ("rpmsg: virtio: Fix possible double free in
>> rpmsg_probe()")
>> [3] commit bb17d110cbf2 ("rpmsg: Fix calling device_lock() on
>> non-initialized device")
> 
> I think only the last [3] introduced it, because it's the commit missing
> put_device in first error path.
> 

I see. Do i need to change the commit log and then send a v2?

>>
>> The above three patches merged at the same time introduced a new bug.
>> [1] and [2] make rpmsg_ns_register_device and rpmsg_ctrldev_register_device
>> need to call the callback function internally to free vch when it fails.
>> [3] has an error return path not handled vch.
>>
>> Fix this by adding a put_device() to the error path.
>>
>> Fixes: bb17d110cbf2 ("rpmsg: Fix calling device_lock() on non-initialized device")
>> Signed-off-by: Hangyu Hua <hbh25y@gmail.com>
> 
> 
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> 
> Best regards,
> Krzysztof
