Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B57357E656
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jul 2022 20:12:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236103AbiGVSMo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jul 2022 14:12:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235652AbiGVSMm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jul 2022 14:12:42 -0400
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AD3697482
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jul 2022 11:12:41 -0700 (PDT)
Received: by mail-pl1-f174.google.com with SMTP id z3so5220075plb.1
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jul 2022 11:12:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=94Oby05bvjJaQQASVxPlgqvgjisXx8t3hxHO3QsA8+k=;
        b=4w77B2mjBu8WO4i2q5+HqaagahVrcWFsRmyK+EYVnky+Spl/eUWtE64+KhuRZryrcv
         YI6P8fZpu8WdFtsp2A9/enzKHNuuwLGVez+vvuUapvZExPKRvW+N3gaY6euZIKwBRrWF
         FwgCw+gnMIEtjHk+mJkjbSRqVO6nX/ZmRGhdKjLkMRjaW8Loh0JscR1NRJbKxyrslaBa
         tGZndVmqR7B9x+Kqw9hj0EbFMXySfxIqW70Dhiqp9KolNV16winmqrYV12Irf9S3R4RF
         fSxhCt22G01V2Tqmpq3MEWMEoD5YLlm1IbKtNTB4ef7lNWGYOzwKljAfGRrX7iNjIH9K
         hjBA==
X-Gm-Message-State: AJIora+N2rOCXTwqVSjVdnSD7Ro8Nb60pksQr0jdHvYFz6LI4jGM1hxp
        Y35T2kXO3eenovlhPeYs+ZE=
X-Google-Smtp-Source: AGRyM1vmngp+q5tAzlDopuZuD6x6siNgfw4OExR8SHfAeKtUxThUPYuDDHzVOa8fIkfovNQQ/T66+w==
X-Received: by 2002:a17:902:aa84:b0:16d:3ec4:cfc8 with SMTP id d4-20020a170902aa8400b0016d3ec4cfc8mr1015154plr.153.1658513560961;
        Fri, 22 Jul 2022 11:12:40 -0700 (PDT)
Received: from ?IPV6:2620:15c:211:201:9cf6:7e29:d977:6fc7? ([2620:15c:211:201:9cf6:7e29:d977:6fc7])
        by smtp.gmail.com with ESMTPSA id d1-20020a170902cec100b0016cbb46806asm4104906plg.278.2022.07.22.11.12.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 Jul 2022 11:12:40 -0700 (PDT)
Message-ID: <cabd732a-9942-3ece-8141-c0bc6378faca@acm.org>
Date:   Fri, 22 Jul 2022 11:12:38 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [dm-devel] [PATCH 0/3] dm-verity: optionally use tasklets in
 dm-verity
Content-Language: en-US
To:     Christoph Hellwig <hch@infradead.org>,
        Nathan Huckleberry <nhuck@google.com>
Cc:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Mike Snitzer <snitzer@kernel.org>,
        linux-kernel@vger.kernel.org, Eric Biggers <ebiggers@kernel.org>,
        dm-devel@redhat.com, Sami Tolvanen <samitolvanen@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Alasdair Kergon <agk@redhat.com>
References: <20220722093823.4158756-1-nhuck@google.com>
 <YtrTI/CJMoLihA/1@infradead.org>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <YtrTI/CJMoLihA/1@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/22/22 09:41, Christoph Hellwig wrote:
> We've been tying to kill off task lets for about 15 years.  I don't
> think adding new users will make you a whole lot of friends..

+1 for not using tasklets. At least in Android the real-time thread 
scheduling latency is important. Tasklets are not visible to the 
scheduler and hence cause latency spikes for real-time threads. These 
latency spikes can be observed by users, e.g. if the real-time thread is 
involved in audio playback.

Bart.
