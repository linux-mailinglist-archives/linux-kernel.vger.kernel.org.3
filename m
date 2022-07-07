Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F15A56A3D1
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jul 2022 15:37:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235991AbiGGNhw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jul 2022 09:37:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235519AbiGGNhu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jul 2022 09:37:50 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C99741EAEF
        for <linux-kernel@vger.kernel.org>; Thu,  7 Jul 2022 06:37:49 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id g1so15546957edb.12
        for <linux-kernel@vger.kernel.org>; Thu, 07 Jul 2022 06:37:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:from:in-reply-to:content-transfer-encoding;
        bh=IfZQ5gf6I0wnqhKd/NWryvEg+xuPTzb9q9RJYF/x4hI=;
        b=DR1QzbDxXP/SdV+7VElfFmnVdNSMGD70rpBpE8Ki4gmT7lATSzJZCToOknrKmCO+CX
         PyrVLj0sg8UqEHYMv0Z0WMABq3ppLWO2JP6V3UmlCDxCV2Dppnf4iSf6kPKrcfLMdvWB
         SJ8WPoH3qKlplUmD4IHLgWRME7l2fjo+TJLHK0AtdahGX7CwwmshrFAIcHCR1GbsoAmE
         zebSO7WJr8ztBjJUVtkiTRngXqNvehcH4D03qonP6flUF5tRAVaP5ayjeZVprwtamWco
         r6f8UGCMVpj7KN43eceGJjuecix5jiU22/qzRiowwl0ACmk/WEtKFKElpFuwU7//31JT
         lb+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=IfZQ5gf6I0wnqhKd/NWryvEg+xuPTzb9q9RJYF/x4hI=;
        b=fraQx+YgfGyMSgHHZxmvjt6JdVNwWvLrTJssLs41g/K58r2sSHtc13n+6yGmhfoiIf
         qUhmMHSusfgi/vK2e5EBb3JlpsNqpGOKat+TvAb3VCwKt4hBDIyNxUVYJqzNC2YvHVYB
         YmUit/AexOPzecsn1we15dLA6AQ+3THfG2Bve57VA6NV/Zfjigxo1wOtCU6+9TEI3nmq
         4uXF4SCt+K+Vit3RnABTR6/6DRf3Q0fCn4e3rDfEjHIWuLDAIRgRaaVEeoQzC93924CY
         gQGGvE8wzNWiq1hVQK9BMDNqhE4StK1Mbo4fx87+0DFTdgt2Cy4r37zJ4/pdZHBWuykR
         KCiQ==
X-Gm-Message-State: AJIora8tuoRgMph7PmhRcmvPLMd6DQbWbYmwYETrc7iZuev+0iWChq6D
        MX7vl5a3mu98xwftTqK69gs=
X-Google-Smtp-Source: AGRyM1stGUOKzLD1ycd4kXtJRDhMWSm9EKgOzNeHZ46NGDu8hpWmb7Mn7tYGrWMga94c8P9YklK2zw==
X-Received: by 2002:aa7:cd91:0:b0:438:33a1:d5aa with SMTP id x17-20020aa7cd91000000b0043833a1d5aamr56730529edv.157.1657201068450;
        Thu, 07 Jul 2022 06:37:48 -0700 (PDT)
Received: from ?IPV6:2620:10d:c096:310::2eef? ([2620:10d:c092:600::2:338f])
        by smtp.gmail.com with ESMTPSA id m11-20020a50ef0b000000b0043a6c9e50f4sm8904918eds.29.2022.07.07.06.37.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Jul 2022 06:37:47 -0700 (PDT)
Message-ID: <2041c8d8-e57d-01bf-1378-3ad2c72f69d6@gmail.com>
Date:   Thu, 7 Jul 2022 14:37:42 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [syzbot] KASAN: use-after-free Read in pty_close
Content-Language: en-US
To:     syzbot <syzbot+49950ba66096b1f0209b@syzkaller.appspotmail.com>,
        axboe@kernel.dk, gregkh@linuxfoundation.org, jirislaby@kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
References: <00000000000045b69505e33720b0@google.com>
From:   Pavel Begunkov <asml.silence@gmail.com>
In-Reply-To: <00000000000045b69505e33720b0@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/7/22 14:33, syzbot wrote:
> Hello,
> 
> syzbot tried to test the proposed patch but the build/boot failed:

#syz test: https://github.com/isilence/linux.git poll-syz


> failed to checkout kernel repo git@github.com:isilence/linux.git/poll-syz: failed to run ["git" "fetch" "--force" "eab646780d8603fd6348e6bccafebcb1c0ddc5bc" "poll-syz"]: exit status 128
> Host key verification failed.
> fatal: Could not read from remote repository.
> 
> Please make sure you have the correct access rights
> and the repository exists.
> 
> 
> 
> Tested on:
> 
> commit:         [unknown
> git tree:       git@github.com:isilence/linux.git poll-syz
> dashboard link: https://syzkaller.appspot.com/bug?extid=49950ba66096b1f0209b
> compiler:
> 
> Note: no patches were applied.

-- 
Pavel Begunkov
