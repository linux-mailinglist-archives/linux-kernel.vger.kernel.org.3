Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0CC84C93AF
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Mar 2022 19:58:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237205AbiCAS7U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Mar 2022 13:59:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237184AbiCAS7L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Mar 2022 13:59:11 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id AAD8410D1
        for <linux-kernel@vger.kernel.org>; Tue,  1 Mar 2022 10:58:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1646161107;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kFGZgdXGLGnwvZ+1z11nI3m8EaJ5DlrV2FeYU+AyTr8=;
        b=GQFCwH2TKH/g3WabtuAGVHx1YgcYLBdqwEqUKUJO0Du3cJd/3eZ48aHqnBI6gYqyTuZOqE
        tVIzw75Z+M1GjdmBkUO66fm3EOM8jq6wFn0/hmbO0AoPcjSV81eFxew9EnOs+e0HUJu5n7
        bvWKkrL8YenLViXMTC2bn/QAcqMz5KA=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-613-YYwmTz9rM8-C8yNqKSyWpQ-1; Tue, 01 Mar 2022 13:58:26 -0500
X-MC-Unique: YYwmTz9rM8-C8yNqKSyWpQ-1
Received: by mail-ed1-f71.google.com with SMTP id j9-20020a056402238900b004128085d906so8224813eda.19
        for <linux-kernel@vger.kernel.org>; Tue, 01 Mar 2022 10:58:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=kFGZgdXGLGnwvZ+1z11nI3m8EaJ5DlrV2FeYU+AyTr8=;
        b=d/7RL0GF5xE0aFe0zbtzcXuW+CdaKhL1aeUoa3YGN161htrahaj+c+1GmwSbGrPxP4
         NKyEfXnQWGjS1FnJieTL6EksdZOgERMXQGkwbVwsgfNubW/8mH/gMdPFBvl/B8gSu/tL
         9OzJDBQgIkBZ0xT6nZXhg4EHHXN/YSAAT3Ca2eyBQZaVaE1IsckrFP+DWalAAqAoNzDR
         6YbAVL02lV/Hvx//COSuIcWcUii33F2HJCkidsbdcm7OcejP0WIShuhrHzjuO8rcPkMn
         3C++RezfWlqGYwAPNurah+8dNcftfvQjuGUTk4sFOZYerF1CGt0VD0S342ncJ+3qbfCA
         0TuQ==
X-Gm-Message-State: AOAM5326R2LcXdnOdBVg2ZYLNs/gcgr/o0vKE0DayPMFbGLk8Ga0WKtw
        n657/L3FZGRUw3jT0P352REK2WlCmYTtwus3XhrRfCkt3GtZq8wczIHKyrM0d3EIo5jG6hVveh2
        LmjZ0ZA7IBfm+dRYsd1GDTeNs
X-Received: by 2002:a17:906:6547:b0:6bd:e2ad:8c82 with SMTP id u7-20020a170906654700b006bde2ad8c82mr20029225ejn.693.1646161104901;
        Tue, 01 Mar 2022 10:58:24 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxoxm0y9DtCYhMH0XDokdx9OLF6FczI4F7yXrDG+1LbabKaLiDeGT+H7vClwVfb8jEpkf/C6Q==
X-Received: by 2002:a17:906:6547:b0:6bd:e2ad:8c82 with SMTP id u7-20020a170906654700b006bde2ad8c82mr20029210ejn.693.1646161104720;
        Tue, 01 Mar 2022 10:58:24 -0800 (PST)
Received: from [10.0.0.45] (host-95-232-30-176.retail.telecomitalia.it. [95.232.30.176])
        by smtp.gmail.com with ESMTPSA id k19-20020a1709062a5300b006c75a94c587sm5581585eje.65.2022.03.01.10.58.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Mar 2022 10:58:24 -0800 (PST)
Message-ID: <b823e468-3c98-44d8-ccf6-8a9ddc769fb5@redhat.com>
Date:   Tue, 1 Mar 2022 19:58:23 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v2 2/2] tracing: Avoid isolated CPUs when queueing
 fsnotify irqwork
Content-Language: en-US
To:     Nicolas Saenz Julienne <nsaenzju@redhat.com>, mingo@redhat.com,
        peterz@infradead.org, frederic@kernel.org, rostedt@goodmis.org
Cc:     tglx@linutronix.de, mtosatti@redhat.com,
        linux-kernel@vger.kernel.org
References: <20220301113053.141514-1-nsaenzju@redhat.com>
 <20220301113053.141514-2-nsaenzju@redhat.com>
From:   Daniel Bristot de Oliveira <bristot@redhat.com>
In-Reply-To: <20220301113053.141514-2-nsaenzju@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/1/22 12:30, Nicolas Saenz Julienne wrote:
> There isn't any need for this irq_work to be run locally, so avoid doing
> so when the CPU is isolated.
> 
> Note that this is especially bad as queueing it into a local isolated
> CPU might add noise to what was meant to be traced in the first place.
> 
> Signed-off-by: Nicolas Saenz Julienne <nsaenzju@redhat.com>

Reviewed-by: Daniel Bristot de Oliveira <bristot@kernel.org>

-- Daniel

