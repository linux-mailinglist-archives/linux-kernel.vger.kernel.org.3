Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B15414AEE28
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Feb 2022 10:41:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237066AbiBIJk6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Feb 2022 04:40:58 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:35860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234117AbiBIJho (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 04:37:44 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5F17CC1DC722
        for <linux-kernel@vger.kernel.org>; Wed,  9 Feb 2022 01:37:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1644399429;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=JCp6XE7j+JLaNG3FyXBcvvob49a1fUjDSBM8HMYml68=;
        b=DxTFU+R1RGrwsHGLHihwaMAgWx149wYs1BjylCROo/pTq1bM186efHu/8vSjEn8gftoWc/
        rvlsNsk/mM0xP/o07kG+FxAIrkzZbxvo+6+ZtkzoKYAGsqR8/Rfx0ipAXqJsaHfzZGNb48
        ZbhX0a2trdS1Uxxbeim0sZUPOQTLjWA=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-473-7Lk6-ZWfPu2IpdyoNZfTJA-1; Wed, 09 Feb 2022 04:26:51 -0500
X-MC-Unique: 7Lk6-ZWfPu2IpdyoNZfTJA-1
Received: by mail-wm1-f69.google.com with SMTP id r8-20020a7bc088000000b0037bbf779d26so239108wmh.7
        for <linux-kernel@vger.kernel.org>; Wed, 09 Feb 2022 01:26:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=JCp6XE7j+JLaNG3FyXBcvvob49a1fUjDSBM8HMYml68=;
        b=swth7r/Xv4958T9fy5hxTbfDZgSmujCX8C3UoWLdJhbqQSk+uhCZa/WWT+ILbtIgOZ
         IQgUr1moARvKdydOcCO2b3N+6iNRqvFdwJfJS+Q2kv7awz/jcA4rmQ2CAs3B4LX4eE5d
         LxZLsW4/PIajwnXnv8WbiiHko+HuKJelEbfwGMLH2eaaUpFrNHygDNjKj4bSr8LaxTN9
         d4msfofLGHPgOvrFAJcSCRBKaqP1Ob2lhKMCeSmWPuprKzHRa4+6gPqrqltpnfoXkd5l
         f4M6tRw/HP5TpV4YAjpis2JtCVs3i036wZTlYbEYNQIFeaZ224+DnNj7YAn7YSqfBmau
         TOYw==
X-Gm-Message-State: AOAM530Qo+S25s8gw9pgMOTFaiibseWr0tI/9qASQMCNmwyn4WNrStrf
        +HMwHwwPAbzlNHGLLSoVi8oH5eIYzMFMxioPnDrx3juqZ0hnP0LHDKBm7OSzJ8tiSE9PJajKCpM
        IfEmnwvW4fvf9xunv0Wa/U5hr
X-Received: by 2002:a5d:5112:: with SMTP id s18mr1264186wrt.296.1644398809815;
        Wed, 09 Feb 2022 01:26:49 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxAO4wnIGn2LFNuhtbLiD8ExuQm621fpN5xLqi0LFeQpL6SEOBzuEpEbxZ3RQGvxqNPQ7DVbw==
X-Received: by 2002:a5d:5112:: with SMTP id s18mr1264174wrt.296.1644398809597;
        Wed, 09 Feb 2022 01:26:49 -0800 (PST)
Received: from [192.168.1.102] ([92.176.231.205])
        by smtp.gmail.com with ESMTPSA id m6sm17580545wrw.54.2022.02.09.01.26.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Feb 2022 01:26:49 -0800 (PST)
Message-ID: <923c1fb9-ec5d-8b6b-96d8-3af6c1c4c8bc@redhat.com>
Date:   Wed, 9 Feb 2022 10:26:48 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH] lima: avoid error task dump attempt when not enabled
Content-Language: en-US
To:     Erico Nunes <nunes.erico@gmail.com>, Qiang Yu <yuq825@gmail.com>,
        dri-devel@lists.freedesktop.org
Cc:     David Airlie <airlied@linux.ie>, lima@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
References: <20220205185909.878643-1-nunes.erico@gmail.com>
From:   Javier Martinez Canillas <javierm@redhat.com>
In-Reply-To: <20220205185909.878643-1-nunes.erico@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Erico,

On 2/5/22 19:59, Erico Nunes wrote:
> Currently when users try to run an application with lima and that hits
> an issue such as a timeout, a message saying "fail to save task state"
> and "error task list is full" is shown in dmesg.
> 
> The error task dump is a debug feature disabled by default, so the
> error task list is usually not going to be available at all.
> The message can be misleading and creates confusion in bug reports.
> 
> We can avoid that code path and that particular message when the user
> has not explicitly set the max_error_tasks parameter to enable the
> feature.
> 
> Signed-off-by: Erico Nunes <nunes.erico@gmail.com>
> ---

Looks good to me. 

Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>

Best regards,
-- 
Javier Martinez Canillas
Linux Engineering
Red Hat

