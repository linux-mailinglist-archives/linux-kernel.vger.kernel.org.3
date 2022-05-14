Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9D9052742C
	for <lists+linux-kernel@lfdr.de>; Sat, 14 May 2022 23:24:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235218AbiENVY2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 May 2022 17:24:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229928AbiENVY0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 May 2022 17:24:26 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78AD139826
        for <linux-kernel@vger.kernel.org>; Sat, 14 May 2022 14:24:22 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id iq10so11051553pjb.0
        for <linux-kernel@vger.kernel.org>; Sat, 14 May 2022 14:24:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:in-reply-to:references:subject:message-id:date
         :mime-version:content-transfer-encoding;
        bh=FywJs009RBpZAOcBqaxGsEO9YqhF6uX15Kces+pxfJc=;
        b=pdhzZSMTCrydErUhyMAmfGNvCwzWz5N2Ja5LaQQMvnN/reusvgmq/vpkFh8OEsG2RO
         iU+t3d64NuA/dFntTdXLgMTGt/W95vsAj/k0rRtzwth6q6j8WfPPWQXbZJevFyUsJYXy
         HZKJM+jwqfPoAMgiMq/xs+EpCdmEb8CxXX7J83P5NfS9s/M7DQrBXL5dIFxaJ/L5lsfT
         bp1MUNUgN3RorcNtwekCZp3DUa7Wvr90sEDR2+NriHqj6u1XXZczhpaF+Duc+Wxgd5Gf
         LzAJJgN0S1ZH2WxYeJH7wqs8yKDsj8NgC/hdVuuFthk9izs9lH4r5XrJ86kVGenlXTR8
         YUYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject
         :message-id:date:mime-version:content-transfer-encoding;
        bh=FywJs009RBpZAOcBqaxGsEO9YqhF6uX15Kces+pxfJc=;
        b=h98XtKt/hv0leEPeAvBg6zP5l27/sFiy+eGTU4FcsLG3HXGPez15uJyoxEvCqH/hvG
         OyLDk9JkUqChqUSsqU2ZVpWqmLfh8ZcAtlGtCdOg4wmb52wfxxpg6Cv74AnvjXTbVzmj
         rOHskUxTyUsKzQjbL42FxW2RdfADxDnyKb6m4TjEo2QxJ2WNAJeMbg0Mlp2E2lFVi5Kc
         yPWO6yzIsrl5+ZYHrl9GciB0y1EDVyDtsKTtjUYWvvCSAICtJAhBqmb/L+urQJrLruFw
         J8y3ld4/hKkol44pWKg6vwtMHV6Z237uDu76p1nZswFIxax+6sSqR7vNZrW5YUPOm+Cv
         2ivA==
X-Gm-Message-State: AOAM532EujYY5S4QYcmmRgkAD1ItKW/I+W+aCFoBH/xgkeXCd6aT2FJR
        KX9nAzcX7EBxcLeYaMFSAaYgMrAPYkSBwg==
X-Google-Smtp-Source: ABdhPJwwbCHz8o4isK0umBmxTpb2X5DrYiard5QIMGvXJ9VtQVcPJ3Nnm4Z/ZSy7n9UI2BGiBA39zA==
X-Received: by 2002:a17:902:7890:b0:161:572a:2494 with SMTP id q16-20020a170902789000b00161572a2494mr3130432pll.123.1652563461826;
        Sat, 14 May 2022 14:24:21 -0700 (PDT)
Received: from [127.0.1.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id n26-20020a056a00213a00b0050dc7628167sm4014756pfj.65.2022.05.14.14.24.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 May 2022 14:24:21 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-block@vger.kernel.org,
        Vasily Averin <vasily.averin@linux.dev>
Cc:     kernel@openvz.org, linux-kernel@vger.kernel.org
In-Reply-To: <e3251f58-fd47-9b94-387b-ab641a773dd7@openvz.org>
References: <e3251f58-fd47-9b94-387b-ab641a773dd7@openvz.org>
Subject: Re: [PATCH] blk-mq: use force attribute for blk_status_t casts
Message-Id: <165256346055.208046.4012136969482600787.b4-ty@kernel.dk>
Date:   Sat, 14 May 2022 15:24:20 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 14 May 2022 13:03:54 +0300, Vasily Averin wrote:
> Fixes sparse warnings:
> block/blk-mq.c:1163:36: sparse:
>  warning: cast from restricted blk_status_t
> block/blk-mq.c:1251:17: sparse:
>  warning: cast to restricted blk_status_t
> 
> 
> [...]

Applied, thanks!

[1/1] blk-mq: use force attribute for blk_status_t casts
      commit: cb9e061e974f8a3a8f2b8c89d93f34ffa7cacafb

Best regards,
-- 
Jens Axboe


