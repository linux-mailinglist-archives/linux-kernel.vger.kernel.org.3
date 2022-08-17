Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F484597376
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Aug 2022 18:02:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239996AbiHQP6q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Aug 2022 11:58:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238035AbiHQP6m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Aug 2022 11:58:42 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 535D95AC64
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 08:58:41 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id dc19so25285449ejb.12
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 08:58:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=U5jw3QHa+iaIPk1CEpZnETysV2acYZOZO5IcpVoLmmM=;
        b=DAPJSc/u2ev6bYXSBrTqwGZ4PaTl8WKl6DiAoyMnKBgA+8zqmrgKU4aVMESdOKZMZT
         SYoGZEdZ4zKG6vHrMZHRGM9k/zEgGqHhynaxUWM7PoNiqiL3sqU34A1ORMMSy9lm01+p
         xih4rucikfbN8PfPcI3ROoqXZHnqdlxXa7TQ8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=U5jw3QHa+iaIPk1CEpZnETysV2acYZOZO5IcpVoLmmM=;
        b=UDiZ3aV/UWkYEWtLN4b73HG21kH72A3HvDwmPKXVg0NKpKsNSrjR5HCORSTbZnS2er
         n09t/w63QkahT49K6Zbyfl0rc+y5/BLBCnQnRIeqUYZMWmG5xL8duZ65t1qk5tiIFqBf
         659FQcpYuHiT/4Tymyqijx2BBwg6mvWLumZQuBmEFbr+9hDo2a7zKNA9K84DB4LOgqPg
         tFWeMKMq1pfKCxUzIMlEDbmTStte77vKEnYkuTszRGGldrgFvarp/gbBl9n7OqALQ30l
         AAXcpHHD499aAYw5XKK9oC0DZSmrt4dovl8RTlmwhLPOXHV7iraH6TtGNtWdhcC//uH+
         JNPg==
X-Gm-Message-State: ACgBeo3iVGP0DcUi+GpARTCG6blUTU0YwZBeSKZKEynthNYkO3zfm0Ca
        nwJn03Gtl7Wb6s/GDDgvDRvgNYzstq/oVWIS8bo=
X-Google-Smtp-Source: AA6agR6TqUbVYbiZsQwcFP9z+gJXbPX7h68heFZ7JUupeQ030vGHyJGFGMycUfniN1JVP5sJ1/x2RA==
X-Received: by 2002:a17:906:cc48:b0:730:7545:bf51 with SMTP id mm8-20020a170906cc4800b007307545bf51mr16562850ejb.247.1660751919712;
        Wed, 17 Aug 2022 08:58:39 -0700 (PDT)
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com. [209.85.128.53])
        by smtp.gmail.com with ESMTPSA id o24-20020aa7dd58000000b0043d742104efsm10814789edw.19.2022.08.17.08.58.36
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Aug 2022 08:58:37 -0700 (PDT)
Received: by mail-wm1-f53.google.com with SMTP id bd26-20020a05600c1f1a00b003a5e82a6474so1144841wmb.4
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 08:58:36 -0700 (PDT)
X-Received: by 2002:a05:600c:2195:b0:3a6:b3c:c100 with SMTP id
 e21-20020a05600c219500b003a60b3cc100mr2523659wme.8.1660751916369; Wed, 17 Aug
 2022 08:58:36 -0700 (PDT)
MIME-Version: 1.0
References: <20220815113729-mutt-send-email-mst@kernel.org>
 <20220815164503.jsoezxcm6q4u2b6j@awork3.anarazel.de> <20220815124748-mutt-send-email-mst@kernel.org>
 <20220815174617.z4chnftzcbv6frqr@awork3.anarazel.de> <20220815161423-mutt-send-email-mst@kernel.org>
 <20220815205330.m54g7vcs77r6owd6@awork3.anarazel.de> <20220815170444-mutt-send-email-mst@kernel.org>
 <20220817061359.200970-1-dvyukov@google.com> <1660718191.3631961-1-xuanzhuo@linux.alibaba.com>
In-Reply-To: <1660718191.3631961-1-xuanzhuo@linux.alibaba.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 17 Aug 2022 08:58:20 -0700
X-Gmail-Original-Message-ID: <CAHk-=wghjyi5cyDY96m4LtQ_i8Rdgt9Rsmd028XoU6RU=bsy_w@mail.gmail.com>
Message-ID: <CAHk-=wghjyi5cyDY96m4LtQ_i8Rdgt9Rsmd028XoU6RU=bsy_w@mail.gmail.com>
Subject: Re: upstream kernel crashes
To:     Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc:     Dmitry Vyukov <dvyukov@google.com>,
        James.Bottomley@hansenpartnership.com, andres@anarazel.de,
        axboe@kernel.dk, c@redhat.com, davem@davemloft.net,
        edumazet@google.com, gregkh@linuxfoundation.org,
        jasowang@redhat.com, kuba@kernel.org, linux-kernel@vger.kernel.org,
        linux@roeck-us.net, martin.petersen@oracle.com,
        netdev@vger.kernel.org, pabeni@redhat.com,
        virtualization@lists.linux-foundation.org,
        kasan-dev@googlegroups.com, mst@redhat.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 16, 2022 at 11:47 PM Xuan Zhuo <xuanzhuo@linux.alibaba.com> wrote:
>
> +       BUG_ON(num != virtqueue_get_vring_size(vq));
> +

Please, no more BUG_ON.

Add a WARN_ON_ONCE() and return an  error.

           Linus
