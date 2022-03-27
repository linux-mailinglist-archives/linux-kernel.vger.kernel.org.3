Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 647E14E8926
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Mar 2022 19:58:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236231AbiC0R4O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Mar 2022 13:56:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236208AbiC0R4M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Mar 2022 13:56:12 -0400
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42971BF41
        for <linux-kernel@vger.kernel.org>; Sun, 27 Mar 2022 10:54:33 -0700 (PDT)
Received: by mail-lj1-x230.google.com with SMTP id 17so16391793ljw.8
        for <linux-kernel@vger.kernel.org>; Sun, 27 Mar 2022 10:54:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9RRo28ZJgxNtm0LxGk4jcyTDu6M+7JuDAPmhILttShY=;
        b=CQHKZ1HJv46CMKFC/9NHyeb8GX2/NuT7YFjHLDpMxUzWDIZMf+tV2ISipfQrhQK4jK
         IHPXlZC8p8e0aSUutE9AXbCI0I9GILAy9avHD3w0cQZ907uc67pmTfI8ojN5DFOXvUXA
         +DbZUf+cv84PYxC9stg+YgliFWxMQe1Y/V0QQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9RRo28ZJgxNtm0LxGk4jcyTDu6M+7JuDAPmhILttShY=;
        b=UEz8MbKjsIV4PepcaMRJRgUWbV1Yu7QE733zyLjnF7AB3SVf2RMQZ5+ImJmKDF1OC0
         Ry8N/B0cYo2MIOQRW06iGFjLudAxpMLDe9zj9Np0Hsn1KuHEE+BmYVRPBud2GJ1ZWvZm
         9b0NbRfQqdmnj2pGdcWqJPG7beq6/CYWk3k2W/FFpM/g0OUKUOo1iEBpgaKB87S+nTMv
         um06iYte/aGGMbUX5e6CHWJTyP8SeDI+oHsGm0GQWLFMwtQVNA+ECu5lMkKO2lmBlxDA
         aKbvgQ4Iz+Wk/atDr7jYKQAyJcpUMZ881eRKEMeD23z5zpGcxGR/oiPl/8OIojBMek5x
         ld3A==
X-Gm-Message-State: AOAM530or0a/fWy7PUJv7Uvtu8O5khUEB8LOHWAlORCOXPNVjf7Ycg6L
        dCv5nRsfZ3ttpXUyYMenCmNqW9JLG/dS4i7M/vA=
X-Google-Smtp-Source: ABdhPJwbL2wXyCg3JZTdB4yh3W2EgR9GhKvB1DxV+pF58taxNx7I9DJRzYEUyg6GtX/6OSKYOl6NjQ==
X-Received: by 2002:a2e:7217:0:b0:249:85ef:ae99 with SMTP id n23-20020a2e7217000000b0024985efae99mr16847424ljc.407.1648403671242;
        Sun, 27 Mar 2022 10:54:31 -0700 (PDT)
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com. [209.85.208.175])
        by smtp.gmail.com with ESMTPSA id d22-20020a194f16000000b0044a72c26c97sm944672lfb.150.2022.03.27.10.54.29
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 27 Mar 2022 10:54:30 -0700 (PDT)
Received: by mail-lj1-f175.google.com with SMTP id q14so16364571ljc.12
        for <linux-kernel@vger.kernel.org>; Sun, 27 Mar 2022 10:54:29 -0700 (PDT)
X-Received: by 2002:a2e:9041:0:b0:24a:ce83:dcb4 with SMTP id
 n1-20020a2e9041000000b0024ace83dcb4mr2136622ljg.291.1648403669304; Sun, 27
 Mar 2022 10:54:29 -0700 (PDT)
MIME-Version: 1.0
References: <20220327173316.315-1-kbusch@kernel.org> <CAHk-=whktuOOGYoNC=pAVX3KOMo4AD8dFsVdD_CAesMqef_9JQ@mail.gmail.com>
In-Reply-To: <CAHk-=whktuOOGYoNC=pAVX3KOMo4AD8dFsVdD_CAesMqef_9JQ@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 27 Mar 2022 10:54:13 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjrNHfwp4BM_xXNfoix4YSgkSZJ-Tq_R9NiFLqL1v0dHw@mail.gmail.com>
Message-ID: <CAHk-=wjrNHfwp4BM_xXNfoix4YSgkSZJ-Tq_R9NiFLqL1v0dHw@mail.gmail.com>
Subject: Re: [PATCH] block: move lower_48_bits() to block
To:     Keith Busch <kbusch@kernel.org>
Cc:     linux-block <linux-block@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 27, 2022 at 10:53 AM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> Because admittedly the 21st century has been all that great so far,

 *hasn't

Duh.

             Linus
