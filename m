Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D3444E468B
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Mar 2022 20:17:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230396AbiCVTSd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Mar 2022 15:18:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230112AbiCVTSa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Mar 2022 15:18:30 -0400
Received: from mail-il1-x12f.google.com (mail-il1-x12f.google.com [IPv6:2607:f8b0:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C764C252A6
        for <linux-kernel@vger.kernel.org>; Tue, 22 Mar 2022 12:17:02 -0700 (PDT)
Received: by mail-il1-x12f.google.com with SMTP id j15so2967390ila.13
        for <linux-kernel@vger.kernel.org>; Tue, 22 Mar 2022 12:17:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:from:in-reply-to:content-transfer-encoding;
        bh=3fa+Yc6J9FxvaVrYGbZmAuXR7+SlkzyafMy9YlzUS1Y=;
        b=mnwYcMbEhWEt1ZQDtvrtE6C5PJL52JtuOjET1yFuu4hvsaINKYn5YBI/l+cuJpUZ23
         OcJhgMRiuSM88DEAcpkV5HXwFfVXPdAmu8Q92zmu3BGyhOG1LXl99DeIJboI/XpoaD1M
         VBvHdMdjyYLW9Zjp+uYEYImDlO/rcbMPXT8vrdabcIe5Ye5xtVnyWxgNivyOABj3T+5o
         090PQRLV3FgYof0P75g1kj7MniSvqadd0kBDkHJJeHjVNcjm9sLrbqCV9nY85Y56r7c2
         KrXvkVILE4QIXXgB0EMi4HO4aVOKo+jx1u/rVCyDXweGU1LLlcwN5llvqjaTGb7O/4XF
         V6jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=3fa+Yc6J9FxvaVrYGbZmAuXR7+SlkzyafMy9YlzUS1Y=;
        b=mDO0IZgR2jNFWuCZ5eCrftM/FKGfawB6Q10vc18rPkilhVEHc+yW4r1fjttlutfbHP
         Q3GgUz2Hz264AnWd/4BKJqDMMWOHjMGI1NZJpkS/fH9BR1YWs6lUSct5oiK2DrR5fqag
         9LsG8SETPIE6xDDzGsg9vmt7NSc6WHmrHN62WhidnwahslyGq5WmmOjBhC/8QCYeOJHr
         ONiJhMjxH1c6HQ2+zkDIK5GLianBOCRC75X1BqwuroyXi2ycKC2njK+2ZaJMg5ZfwBwp
         4tL51hgJsMrg60cmVL0YLCp6P1UA7e3KxYHnXxpZVtteHHpA/QT73SZCJmTSdXo/toyA
         IVgA==
X-Gm-Message-State: AOAM532Ssy0O9jh6ndd163nojbAPXbF9EudIFsa3ls8DZQxuTsyE7KMm
        Lys4J904c6pRy7eLYNOXZKs2aQ==
X-Google-Smtp-Source: ABdhPJxexP6W39etDP0GPcNUFFmkpxISqnOw3uLuajzE/l70iX6vTuZlNV7gAnA4y2MK4QBhyqT6xA==
X-Received: by 2002:a05:6e02:1587:b0:2c2:5c48:a695 with SMTP id m7-20020a056e02158700b002c25c48a695mr12637288ilu.169.1647976622129;
        Tue, 22 Mar 2022 12:17:02 -0700 (PDT)
Received: from [192.168.1.172] ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id e17-20020a5d8ad1000000b00644d51bbffcsm10823699iot.36.2022.03.22.12.17.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Mar 2022 12:17:01 -0700 (PDT)
Message-ID: <0cd64678-f4de-0e30-87d2-01f32311ee98@kernel.dk>
Date:   Tue, 22 Mar 2022 13:17:01 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [syzbot] KASAN: use-after-free Read in tty_release
Content-Language: en-US
To:     syzbot <syzbot+09ad4050dd3a120bfccd@syzkaller.appspotmail.com>,
        asml.silence@gmail.com, gregkh@linuxfoundation.org,
        io-uring@vger.kernel.org, jirislaby@kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
References: <0000000000006a354705dad2387e@google.com>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <0000000000006a354705dad2387e@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SORTED_RECIPS,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

#syz test: git://git.kernel.dk/linux-block for-5.18/io_uring

-- 
Jens Axboe

