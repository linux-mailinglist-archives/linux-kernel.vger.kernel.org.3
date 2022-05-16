Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3676527C15
	for <lists+linux-kernel@lfdr.de>; Mon, 16 May 2022 04:41:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239442AbiEPClJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 May 2022 22:41:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239434AbiEPClC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 May 2022 22:41:02 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2DAF21E39;
        Sun, 15 May 2022 19:41:00 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id n10so13161511pjh.5;
        Sun, 15 May 2022 19:41:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=aIlm/VYtdYStFNftAawGcZJShpGn68mz3cqjYcCYHws=;
        b=YmiwWn4LKW3H6BQwtwi/Pxsb1NKWvM9/Ezvmd6zY+/O1++OjIciCqRW3Y5kyESlo16
         VmNTASBq0Tcr7oNrt5H+E1/NOv/v8HClfGl5kuROaVP0fE8ylS4S3BZPg1LM/2+cSksl
         te2viXEqlxnoGqmrBfoaTAnLBy5nt+LOGOW2BL7vnKI22wCII/ckA1G0FMXMKSgmSvcn
         L80MszYZLyEgJRpAFrXWoHU3LH/EdEZPe7v01kbBBIJTipgWzX3OXhhlRQui41qi6Bjq
         W7t6QDFJ3wWBL/B2YsJBpB/A6bS33Uhnn3+5K5k9EZ4nDapCP2ocEG43PPRiig3K5pDg
         nGaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=aIlm/VYtdYStFNftAawGcZJShpGn68mz3cqjYcCYHws=;
        b=uVwa9Q0X+GzmVP29U9yEarHGRTlV39Fp3uJiKJIpK35euV8r0UDu2I1YiQmNwteG+A
         HrRFBMA30iXfqtSYBuG5f+ZnXbtfO95g+QmDfzPp2YrxhosRraMzdJq6/fQ4x7MqLPuN
         2/knyyLo5dT5TQAAJJWLl4Y/NJeAwkAEPbWAR4hO6bs/596ZxdTn0LqsIeW/QqrJnGor
         nu/raoOB5HhEVvyFqEmbuVLpiIOcaHJpnvppgUiwvx/G4ElUu9y5SoGWx3MQxhGF19Nm
         Sra1UxLfIZJYDyzD2VNdPDNq1uPg1Hoa5p+EAORP4LaDoXs1Xbx3NbzwbDisRlhMCCCP
         9bDA==
X-Gm-Message-State: AOAM531jcVk9HFtaubaR73BWtj8gI30j085MwZeWF1vKbvBFlIpQxPng
        P7dG+/niX4un/hnWvk8rvo0=
X-Google-Smtp-Source: ABdhPJzl2hay+yjqIO1bBR4EP5B/6h8hF8ITX75cQ40q4Y1pO++lfzx26n67+chXkOJsjhnzP0pNJA==
X-Received: by 2002:a17:90a:9313:b0:1df:10a1:35ef with SMTP id p19-20020a17090a931300b001df10a135efmr10392837pjo.134.1652668860207;
        Sun, 15 May 2022 19:41:00 -0700 (PDT)
Received: from [192.168.50.247] ([103.84.139.165])
        by smtp.gmail.com with ESMTPSA id v4-20020a1709029a0400b0015e8d4eb2c1sm5721198plp.267.2022.05.15.19.40.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 15 May 2022 19:40:59 -0700 (PDT)
Message-ID: <0b428595-ad3f-3b6c-484c-21b217adab7c@gmail.com>
Date:   Mon, 16 May 2022 10:40:55 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH] media: dvb_vb2: fix possible out of bound access
Content-Language: en-US
To:     Sergey Senozhatsky <senozhatsky@chromium.org>
Cc:     mchehab@kernel.org, caihuoqing@baidu.com, hverkuil-cisco@xs4all.nl,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220324080119.40133-1-hbh25y@gmail.com>
 <YjxGlIyYiULyAXy6@google.com>
From:   Hangyu Hua <hbh25y@gmail.com>
In-Reply-To: <YjxGlIyYiULyAXy6@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/3/24 18:23, Sergey Senozhatsky wrote:
> On (22/03/24 16:01), Hangyu Hua wrote:
>> vb2_core_qbuf and vb2_core_querybuf don't check the range of b->index
>> controlled by the user.
>>
>> Fix this by adding range checking code before using them.
>>
>> Signed-off-by: Hangyu Hua <hbh25y@gmail.com>
> 
> Reviewed-by: Sergey Senozhatsky <senozhatsky@chromium.org>

Hi guys,

Two other patches for this module that I submitted at the same time as 
this one have been accepted. But this bug looks much worse than the 
other two. Is this patch forgotten to merge?

Thanks.
