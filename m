Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D4275A2C51
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Aug 2022 18:29:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230286AbiHZQ3n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Aug 2022 12:29:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbiHZQ3k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Aug 2022 12:29:40 -0400
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45846DF679;
        Fri, 26 Aug 2022 09:29:40 -0700 (PDT)
Received: by mail-pj1-f47.google.com with SMTP id i8-20020a17090a65c800b001fd602afda2so2173732pjs.4;
        Fri, 26 Aug 2022 09:29:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=lBvvh8CMBUZ2sjFkD26Cqoc4+9rLr06nz33vMiatlKg=;
        b=zGlgpTZt7y4RuOIBm6obh5ay0lNUw1pt0yg1FMs/sfje7TG9bWtM6JBc93CxIhu8vT
         GL1ueW4b+4uuHbNXthoP4cVkE6rCb/o6cbVSQjhI95GKXsiNn053k2abZPJfuGz8tsrw
         4pyN9LlZVGxOVyrNZtbdG4fpCxuRswvGFEaCR7bk4qA9AdrAOKuxYE3L2y8ueKnztw/2
         seoDdeOpqtaorJVv+ddcsuoM5qbr1nOklg6c4zZbuyT42n//3RSbxYvZdXULo33tqxgE
         CxrZq9u6MbZd2NbJykSvghGNQcWwFL2VM7gMongl4iqI/ECpNrSUp7E9MR3zBDUCO/sr
         9Wdw==
X-Gm-Message-State: ACgBeo0NDvvK9Vz3KEQvuoevodCNXxksV9mw8vKe88bz7Gebjibc8sXU
        Vxv14akl1B3y2naYC1DL9xCoPWOpvPnjrw==
X-Google-Smtp-Source: AA6agR7vd7jE0Y5Ib+TqvdaFovHQP0nydl+a10cj01d60/tG2Hj7/bbclaJKgdJa5dhuJjDKvnN5RQ==
X-Received: by 2002:a17:902:f650:b0:172:8ee1:7f40 with SMTP id m16-20020a170902f65000b001728ee17f40mr4444648plg.101.1661531379674;
        Fri, 26 Aug 2022 09:29:39 -0700 (PDT)
Received: from ?IPV6:2620:15c:211:201:a12:b4b9:f1b3:ec63? ([2620:15c:211:201:a12:b4b9:f1b3:ec63])
        by smtp.gmail.com with ESMTPSA id x36-20020a17090a6c2700b001fa867105a3sm1939818pjj.4.2022.08.26.09.29.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 26 Aug 2022 09:29:38 -0700 (PDT)
Message-ID: <5ffb520f-d86f-be3e-4239-2f31c681ede2@acm.org>
Date:   Fri, 26 Aug 2022 09:29:36 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [syzbot] upstream boot error: BUG: unable to handle kernel paging
 request in blk_mq_map_swqueue
Content-Language: en-US
To:     Aleksandr Nogikh <nogikh@google.com>
Cc:     Dmitry Vyukov <dvyukov@google.com>,
        syzbot <syzbot+ea55456e1ff28ef7f9ff@syzkaller.appspotmail.com>,
        Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>, llvm@lists.linux.dev,
        'Aleksandr Nogikh' via syzkaller-bugs 
        <syzkaller-bugs@googlegroups.com>
References: <0000000000004c3b1405e6b7de26@google.com>
 <f70b1cf7-0291-6ebc-68f8-db9c68963255@acm.org>
 <CANp29Y7bgwDzd47E6h8gseYuu5YXF-ABRrhVXFXS-HF7PhF-Dw@mail.gmail.com>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <CANp29Y7bgwDzd47E6h8gseYuu5YXF-ABRrhVXFXS-HF7PhF-Dw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/26/22 06:15, Aleksandr Nogikh wrote:
> Syzbot would have included the USB mailing list and the USB
> maintainers if it saw that the bug might be related to this subsystem.
> The bot's guess was that it was the BLOCK LAYER subsystem, so it Cc'd
> only the general lists and linux-block@vger.kernel.org
> 
> Is there anything in this bug report that can reliably indicate that
> the bug has to do with USB? If there is, we can definitely adjust our
> guilty subsystem recognition logic.

Hi Aleksandr,
  I may have been to fast with my conclusion that the root cause is in 
the USB subsystem.

Regarding your question, can syzbot inspect the console log and scan for 
"scsi host%d: %s" strings? The text next to the colon comes from the 
SCSI host template "name" member and hence indicates which SCSI LLD 
driver is involved.

Thanks,

Bart.
