Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CEDD4ED947
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Mar 2022 14:07:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235700AbiCaMIW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Mar 2022 08:08:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235538AbiCaMHw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Mar 2022 08:07:52 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD31A3EABD
        for <linux-kernel@vger.kernel.org>; Thu, 31 Mar 2022 05:06:05 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id mr5-20020a17090b238500b001c67366ae93so2280512pjb.4
        for <linux-kernel@vger.kernel.org>; Thu, 31 Mar 2022 05:06:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:in-reply-to:references:subject:message-id:date
         :mime-version:content-transfer-encoding;
        bh=JFDL+YbHXOZXfT1eYe4XgKv9dr6pUyV1bxUS3LMlVKs=;
        b=BVkhl/wnZn20LFoc5PiYLZq2Ii7PW5AYyao3RUkUuSJu6nLDJtGtbjInoCbG7UlKn4
         YOY9//OqoITxoW1EG99CV6YEll7X0H9PlR1kgndTt3cypgTga4bTr+KTFyOJn4DmRZIE
         sItqN0ySg6F1XvCWYv5ByNQ2HTgQCDOuWQghBKo0px80GsDjx+770m6mv2H+oQzTJMJL
         s/mSXJrLyiViVYnadVgH96k0U8vsVmHHvCx1xe9+ivT9hPzv5g7wSdyzDyYhmkMiLo2C
         0eUt9s5MYlNcRli/fSmplOfiy1+PGjK0skXPhH0E6ZJ65pBvwFv0reSg+ESLn91H5Su2
         E6Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject
         :message-id:date:mime-version:content-transfer-encoding;
        bh=JFDL+YbHXOZXfT1eYe4XgKv9dr6pUyV1bxUS3LMlVKs=;
        b=yz2IPLplPX1+Hs9M7t4qnnd/i/K25VvF1EmEshEb/est1mGbRCN31sIMCJpGJILPYW
         IAee22BPild10Wal03uGLGhW+k48P3g7J03mjvVwofFiV6i8UujYTGqhwmTSisuD78Oj
         wIoxKfZIgasbQPD5LesxwgBp8GFOfooun6dUJ5T4CA1RuehwJ+ucrLnDyKeO+NzxpgpI
         qNoIi6RYE3rm7bMUJRPKIezmWmbwAEp/8GPuYIGJukfvMUhoZW4ce1Y9x65yVrcB0q9z
         PRwVKjzyUyPafWlSJU5vJBQaYpi728K61SXBDNi02znINUMIfAvErw6MmKZ0bmseD57L
         P7QA==
X-Gm-Message-State: AOAM5306B47a8byLE4tXjBAb+sdBwI1sT/kdQ73jjtBVH4mrnqRqvkls
        de18rNO4ivokWsikA8WrNiH3lw==
X-Google-Smtp-Source: ABdhPJzm4oBw1lo9Ze3zlT8Vr0B1J2Ro5YuyME4y3100hRXLcOv6/SLMJKFXM+QhPEeQ9Sso5MSINg==
X-Received: by 2002:a17:902:7fc2:b0:153:3c90:17b9 with SMTP id t2-20020a1709027fc200b001533c9017b9mr4757024plb.61.1648728365170;
        Thu, 31 Mar 2022 05:06:05 -0700 (PDT)
Received: from [127.0.1.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id k23-20020a17090a591700b001ca00b46cf9sm4844963pji.18.2022.03.31.05.06.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Mar 2022 05:06:04 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     Jakob Koschel <jakobkoschel@gmail.com>
Cc:     "Bos, H.J." <h.j.bos@vu.nl>, linux-kernel@vger.kernel.org,
        Brian Johannesmeyer <bjohannesmeyer@gmail.com>,
        Mike Rapoport <rppt@kernel.org>, linux-block@vger.kernel.org,
        Bart Van Assche <bvanassche@acm.org>,
        Cristiano Giuffrida <c.giuffrida@vu.nl>
In-Reply-To: <20220331091218.641532-1-jakobkoschel@gmail.com>
References: <20220331091218.641532-1-jakobkoschel@gmail.com>
Subject: Re: [PATCH v2] block: use dedicated list iterator variable
Message-Id: <164872836394.7852.9344079162179392052.b4-ty@kernel.dk>
Date:   Thu, 31 Mar 2022 06:06:03 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 31 Mar 2022 11:12:18 +0200, Jakob Koschel wrote:
> To move the list iterator variable into the list_for_each_entry_*()
> macro in the future it should be avoided to use the list iterator
> variable after the loop body.
> 
> To *never* use the list iterator variable after the loop it was
> concluded to use a separate iterator variable instead of a
> found boolean [1].
> 
> [...]

Applied, thanks!

[1/1] block: use dedicated list iterator variable
      commit: 4a3b666e0ea977dd40adb56c37a91370f76fa19e

Best regards,
-- 
Jens Axboe


