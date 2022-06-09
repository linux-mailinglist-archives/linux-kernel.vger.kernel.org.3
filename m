Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1636544820
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jun 2022 11:58:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234324AbiFIJ6d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jun 2022 05:58:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234128AbiFIJ6b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 05:58:31 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 187E33E64A6
        for <linux-kernel@vger.kernel.org>; Thu,  9 Jun 2022 02:58:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1654768709;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kJjbZbgVvqwcqA8FxhrXh8rs8xeBPa2CWEvot0dkkHY=;
        b=gJKMeLUFoIi5OT3s7ldTgEVUoaXguYih46fgikDks3MK2Ruh8TXRM2PqgAsVV8HvROFaum
        Sb8GUjvgStVChIL9iCmnLZy+/+REUeHgziYI2KHZtVSnXPA7YD3Q/3Al4GoH1itHdMc+5J
        cawkg5jmxGBS3IGCDii/RSH8fZDDnw4=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-356-OfgNmnA-NuqYjiTz4OH2vw-1; Thu, 09 Jun 2022 05:58:28 -0400
X-MC-Unique: OfgNmnA-NuqYjiTz4OH2vw-1
Received: by mail-ed1-f69.google.com with SMTP id o17-20020a50fd91000000b0042dbded81deso16696512edt.0
        for <linux-kernel@vger.kernel.org>; Thu, 09 Jun 2022 02:58:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=kJjbZbgVvqwcqA8FxhrXh8rs8xeBPa2CWEvot0dkkHY=;
        b=xCK6N73TcgZGfPgMh8Pif3kYx4ufJgcdsCEe2cZWJablKb4236xAuWpkhDoX0ZL6WP
         HSPIVqIT3FpHoUpbq08qPxrB/NZPOKacvzbUz+NMcL1mH/s8djwC4XUXXr5mY1lASEWp
         dqimmk41Dpsc9dJ/zXnjNFdDKHlogixCJvKbB+uA/FaNvm5bpCcVTjIHkftAz7/+ruWA
         aK01d/Yjde1KIcZraWqEGkmfqk6c4+/qyGu4jFT17llb5tXGPLg7Wb9F4DgsZre4INdC
         ux4V52RzOQ5ysSKYgjQ8DOwP4XgolijASb00/tOSVwREfftFCeA+KdAJ003YhKF9F0iF
         OfMw==
X-Gm-Message-State: AOAM533xFUNUvdlqx7BSGO0VffuTKt9KKeNxO1WoX0FB/DbjMCoWyz8S
        XBTduXMSyig/GMzX+33gEFAKopQVnODx6d6yPrdG4fHEDn/Dv/3be8hLzmKs9WHWtDA/oLcKF9q
        6Nch3kqcBUri5iLyiPA/uMwL+
X-Received: by 2002:a17:906:12d3:b0:6f5:18a2:176d with SMTP id l19-20020a17090612d300b006f518a2176dmr33553925ejb.474.1654768706913;
        Thu, 09 Jun 2022 02:58:26 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwmzHj9EHdG56c97cPTukLo1ZD24opV01TMMcDs6fA0NqGZw1UeMe2i7y36uX5lJnFCH/iDrA==
X-Received: by 2002:a17:906:12d3:b0:6f5:18a2:176d with SMTP id l19-20020a17090612d300b006f518a2176dmr33553913ejb.474.1654768706733;
        Thu, 09 Jun 2022 02:58:26 -0700 (PDT)
Received: from [192.168.0.198] (host-95-248-229-226.retail.telecomitalia.it. [95.248.229.226])
        by smtp.gmail.com with ESMTPSA id er14-20020a056402448e00b0042dd05edeedsm13883797edb.17.2022.06.09.02.58.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Jun 2022 02:58:26 -0700 (PDT)
Message-ID: <2d00e87d-9e84-2ea1-605f-ee08e8a1b467@redhat.com>
Date:   Thu, 9 Jun 2022 11:58:24 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v2] sched/deadline: Use proc_douintvec_minmax() limit
 minimum value
Content-Language: en-US
To:     Juri Lelli <juri.lelli@redhat.com>,
        Yajun Deng <yajun.deng@linux.dev>
Cc:     mingo@redhat.com, peterz@infradead.org, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, vschneid@redhat.com, linux-kernel@vger.kernel.org
References: <20220607101807.249965-1-yajun.deng@linux.dev>
 <YqGTJsf2R9hBz2bi@localhost.localdomain>
From:   Daniel Bristot de Oliveira <bristot@redhat.com>
In-Reply-To: <YqGTJsf2R9hBz2bi@localhost.localdomain>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/9/22 08:28, Juri Lelli wrote:
> Guess I'm not opposed to the change, even if, as the changelog also
> says, we should be already checking for sane values.

I share this opinion.

-- Daniel

