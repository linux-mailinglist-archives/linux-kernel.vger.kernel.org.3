Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 942545AE36B
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 10:50:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239377AbiIFIt3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 04:49:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239465AbiIFIsL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 04:48:11 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBE3579A67
        for <linux-kernel@vger.kernel.org>; Tue,  6 Sep 2022 01:45:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1662453937;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=S+CgvAd98u77997qA9EulLbAkvKOkOqUmsYi/uHKf50=;
        b=L9Da8FSok9qsFIJSrcjDJe76BDS1NYP+s1QmZx95CvJKPs+2nvl7pe+87g13DqvlYFmWGg
        qHU/6Lleo2eLuTezcJ6sXhsFWd7KA7Ruuwk5+TdtolEAb5bFHvY04L6CUa/CNZOC5txFAr
        xczMHHK94kyfnXK7hrFfLDN24Wkldc0=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-182-rhLOQcvZO0mZfwk_g65TaQ-1; Tue, 06 Sep 2022 04:45:36 -0400
X-MC-Unique: rhLOQcvZO0mZfwk_g65TaQ-1
Received: by mail-qk1-f198.google.com with SMTP id r14-20020a05620a298e00b006be796b6164so8532691qkp.19
        for <linux-kernel@vger.kernel.org>; Tue, 06 Sep 2022 01:45:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=S+CgvAd98u77997qA9EulLbAkvKOkOqUmsYi/uHKf50=;
        b=aprTNNhZ819RYbmvKAl9AGuQEjGAjQQ8cBPfpRWnuXZ+cnQoMYNdjLcjsUXKJRCAfo
         dOXjiyazmYOj5/EXE94xFXLSQxNMnrhiD5+oO3UCIQFIHb/u1Wmfu5tI8oqD24e2Dc/v
         KTVYz7jeJztkjFegcfhCz5B2OekjXYya641xH+WbPx+2Y4rEx4IjSt20mdASqX82pMkQ
         1l8xFyAesk+4UlMARQftr1PAX2HfCuEQxx2c6yzcUQTBT09m3apXqJKGezOmoqbOT8gD
         RxOxvTUaCkPDOky2RUxOZKcS3Dn+rJwp5Y40shY26cu/gr3ivKZT9fF+e8r1h4I15HaW
         DnCg==
X-Gm-Message-State: ACgBeo023A5Q39zfkBtyqypziZ/sPw5utfCHMUzfEkwi46kYL4hSMWZ4
        mr8TpzgAOgDWEjWUczy21hA3xdBVzLn8ZfTA9AKfZR9F4lYkivgBzL3GNOGJ3EXvnaVrlMFTlRO
        NnlcdBx0nvlzbyUhrIRh8k+aU
X-Received: by 2002:a05:6214:1d2a:b0:4a0:78a1:3b2 with SMTP id f10-20020a0562141d2a00b004a078a103b2mr10125899qvd.24.1662453935767;
        Tue, 06 Sep 2022 01:45:35 -0700 (PDT)
X-Google-Smtp-Source: AA6agR6exkdF0IAZ+8vKtpu5164C5FcNuILyzsIlbKtvLfHVPEW4yVqCfRfPTRgq2CvJqB7kcZJTGA==
X-Received: by 2002:a05:6214:1d2a:b0:4a0:78a1:3b2 with SMTP id f10-20020a0562141d2a00b004a078a103b2mr10125887qvd.24.1662453935558;
        Tue, 06 Sep 2022 01:45:35 -0700 (PDT)
Received: from sgarzare-redhat (host-87-11-6-69.retail.telecomitalia.it. [87.11.6.69])
        by smtp.gmail.com with ESMTPSA id fp5-20020a05622a508500b0031e9ab4e4cesm8906971qtb.26.2022.09.06.01.45.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Sep 2022 01:45:34 -0700 (PDT)
Date:   Tue, 6 Sep 2022 10:45:25 +0200
From:   Stefano Garzarella <sgarzare@redhat.com>
To:     Stefan Hajnoczi <stefanha@redhat.com>
Cc:     virtualization@lists.linux-foundation.org,
        Jason Wang <jasowang@redhat.com>, linux-kernel@vger.kernel.org,
        "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH] Documentation: add basic information on vDPA
Message-ID: <20220906084525.4b3xzemvjf5vy6xo@sgarzare-redhat>
References: <20220817221956.1149183-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20220817221956.1149183-1-stefanha@redhat.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 17, 2022 at 06:19:56PM -0400, Stefan Hajnoczi wrote:
>The vDPA driver framework is largely undocumented. Add a basic page that
>describes what vDPA is, where to get more information, and how to use
>the simulator for testing.
>
>In the future it would be nice to add an overview of the driver API as
>well as comprehensive doc comments.
>
>Cc: "Michael S. Tsirkin" <mst@redhat.com>
>Cc: Jason Wang <jasowang@redhat.com>
>Cc: Stefano Garzarella <sgarzare@redhat.com>
>Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
>---
> Documentation/driver-api/index.rst |  1 +
> Documentation/driver-api/vdpa.rst  | 40 ++++++++++++++++++++++++++++++
> 2 files changed, 41 insertions(+)
> create mode 100644 Documentation/driver-api/vdpa.rst

Thank you for this work!

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

