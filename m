Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2511459C4E3
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Aug 2022 19:19:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237197AbiHVRSW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Aug 2022 13:18:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237194AbiHVRSU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Aug 2022 13:18:20 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 495CA63D8
        for <linux-kernel@vger.kernel.org>; Mon, 22 Aug 2022 10:18:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1661188698;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fDT0NzG0FkOZTyIfEMiwc/td94ymUGlK2/HiuIYhkVw=;
        b=NOytNCjQoTGdKqw4Sn38wuuTWykjqkxtbmT2gpgjR4o79XChLdO9odu0sZaiF4lD+RsZy6
        NwM9pLM9+foGZZgOitZMvceRV5mYkK8mPUNW3fhrLRUWhQp4BPKlEiJnFPNii6m8EhMQcL
        ARLrnCXA19fzcREBRRjTj4P3jfHTL74=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-461-2FZZ6Xi7MteDX4P7JIe-5A-1; Mon, 22 Aug 2022 13:18:15 -0400
X-MC-Unique: 2FZZ6Xi7MteDX4P7JIe-5A-1
Received: by mail-wm1-f71.google.com with SMTP id i132-20020a1c3b8a000000b003a537064611so6636773wma.4
        for <linux-kernel@vger.kernel.org>; Mon, 22 Aug 2022 10:18:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=fDT0NzG0FkOZTyIfEMiwc/td94ymUGlK2/HiuIYhkVw=;
        b=B+e0Tl0O3S5NsvtYuCVcLsLCOxMI0DLrkJfnQ/o7P77fBuG9ICyKNQF+wncNjDN+n2
         cSZW3yh4ciicI4ghqtzRM3351mzx78CXdJJytcMm/86KiIVNDy5yie2U1XG4Fk2IZaE7
         ZKGguKeGWGOjr5B1cdqdAOWeIvAmwr969A7sFuDuwD3gCikCIXHjWG0ZzT4g4lELAt+V
         oag8b4tzOKRp67PfRHW4YJ22gKW7rKOjMt536V5aFrUhYQTguxuXFrI9smnSSc+C4fxR
         gQ/YYRP79oPeLa/3XexnodoPLnwjoo6b1ThOUHoVwSTQ8jYg93Ys0wder141DWx9CP1E
         RsMw==
X-Gm-Message-State: ACgBeo0gVUk47nj4yAjIwmgoA9xSRmuiwCFB3pPJOvmgSO+R/JxnfkGy
        K4KnYbSZ5i8I6rG1KA89GxF9EnRi6+s2TFLp4zxN4VuzJRhd3+3YoEuwo5mtoRteNhyqTvg6cFJ
        xvMwBDSTbUoF52FjHIO9OAl6+
X-Received: by 2002:a05:600c:42ca:b0:3a6:3b06:92bd with SMTP id j10-20020a05600c42ca00b003a63b0692bdmr9729424wme.11.1661188694048;
        Mon, 22 Aug 2022 10:18:14 -0700 (PDT)
X-Google-Smtp-Source: AA6agR6+IYglItshBwaPPpRAzS01T43FN9+dUi4FLjFhCug7p7YEh483os0Z+YBPlQqSBN5wAQivlA==
X-Received: by 2002:a05:600c:42ca:b0:3a6:3b06:92bd with SMTP id j10-20020a05600c42ca00b003a63b0692bdmr9729415wme.11.1661188693822;
        Mon, 22 Aug 2022 10:18:13 -0700 (PDT)
Received: from ?IPV6:2001:b07:6468:f312:9af8:e5f5:7516:fa89? ([2001:b07:6468:f312:9af8:e5f5:7516:fa89])
        by smtp.googlemail.com with ESMTPSA id x2-20020adfffc2000000b0021e5bec14basm11950426wrs.5.2022.08.22.10.18.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Aug 2022 10:18:13 -0700 (PDT)
Message-ID: <aac8f6c9-c817-cde3-03ef-5c203899d269@redhat.com>
Date:   Mon, 22 Aug 2022 19:18:12 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH] mailmap: Update Oliver's email address
Content-Language: en-US
To:     Oliver Upton <oliver.upton@linux.dev>,
        Marc Zyngier <maz@kernel.org>
Cc:     kvm@vger.kernel.org, kvmarm@lists.cs.columbia.edu,
        linux-kernel@vger.kernel.org
References: <20220819190158.234290-1-oliver.upton@linux.dev>
From:   Paolo Bonzini <pbonzini@redhat.com>
In-Reply-To: <20220819190158.234290-1-oliver.upton@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/19/22 21:01, Oliver Upton wrote:
> While I'm still at Google, I've since switched to a linux.dev account
> for working upstream.
> 
> Add an alias to the new address.
> 
> Signed-off-by: Oliver Upton<oliver.upton@linux.dev>

Queued, thanks.

Paolo

