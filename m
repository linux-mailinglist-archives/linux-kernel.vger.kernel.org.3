Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A092E5278F4
	for <lists+linux-kernel@lfdr.de>; Sun, 15 May 2022 19:45:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237940AbiEORpQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 May 2022 13:45:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234812AbiEORpL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 May 2022 13:45:11 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A0AA6376
        for <linux-kernel@vger.kernel.org>; Sun, 15 May 2022 10:45:11 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id f10so464140pjs.3
        for <linux-kernel@vger.kernel.org>; Sun, 15 May 2022 10:45:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:from:in-reply-to:content-transfer-encoding;
        bh=f8taNCFzgqWmJinNqlV5CXwZ4zvlamb6JxVYJfeswBQ=;
        b=n4g+F1jmyEKuDjd+iqyP07z1+y+dGnMY1YMJlsackmvsXtXzh7bJUcVzw9PBKdBJeZ
         BzNAhiAtq2rAWDaTHdLbLSAPl5q3qecEN20yDPlOS6JKuIBwClZX8ZOs+tKAPN9DdgwO
         jXkyhOmavJvB29JBmavay3Q2qwGANQHmGLMOyDndihK6E7Tb33TxBD2AzAAUh5WrPGp8
         TXysgJ6i9J7P7kZqkylLkBF5Wb/HD/3hKWJZDF8zc2i6VDVLN3cPGp1OudqeGQbbZ+uk
         GJB/YaSsduiiwloJU3opzjK4/evs5Msz0FmGiFTaz1Ky1hRKjRV4y5Zq0bn4r8iRuNzG
         WFsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=f8taNCFzgqWmJinNqlV5CXwZ4zvlamb6JxVYJfeswBQ=;
        b=Kzpz356LQBWG8sG/d2TPC4Xy1KlUs8gMZpTC3lW6Gu2Qa7dZLvNIf73GGnYf/Jopmh
         LPhXnzRSompl0G6w1W/5Pu8meLS59Lx2PJMqTLOQKU/jB2oBmI5Gbtyho2DzM3S2txrg
         XAI+eGPmX64Kizn4yZAUSAyGPNUsfjZlbf+/k89H3/ZuHgXo/hZPvK8qf6DCJT0boDJi
         5HOryEbgdqTM1qDhoaxXd/+1xxXxhKQoVbpN0JJz1eaWDlp6p6Z/bWDxAJq5Tyq2DVsf
         dgpVQtwmKSa2VCvIzZzvzPSF4Kx9kx0RqtYRnvF230lIZHSJssbR8d5RrATo9pSd2JRH
         VX3g==
X-Gm-Message-State: AOAM533Ck8qHQZT6VHRDGdHu/Lk28DJwkO+pW/pZj0wFhbwF2kcZ+BGa
        2KoRexw1i6HvOmtFwiLIwJGhLA==
X-Google-Smtp-Source: ABdhPJxXNYUhyOGZ/Jk8qbxhEd+/E/HAsnv9rFDeg3xxJ9uDuX0bPk9pQBBGbp/IoQlmoDXZG8Lb5Q==
X-Received: by 2002:a17:903:110c:b0:15f:f15:30ec with SMTP id n12-20020a170903110c00b0015f0f1530ecmr14155533plh.162.1652636710585;
        Sun, 15 May 2022 10:45:10 -0700 (PDT)
Received: from [192.168.1.100] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id j15-20020a170903024f00b0015eee3ab203sm5473653plh.49.2022.05.15.10.45.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 15 May 2022 10:45:09 -0700 (PDT)
Message-ID: <556cb5e5-bfb8-9a2f-054e-e5c8c488a578@kernel.dk>
Date:   Sun, 15 May 2022 11:45:08 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [syzbot] WARNING: still has locks held in io_ring_submit_lock
Content-Language: en-US
To:     syzbot <syzbot+987d7bb19195ae45208c@syzkaller.appspotmail.com>,
        asml.silence@gmail.com, f.fainelli@gmail.com,
        io-uring@vger.kernel.org, kuba@kernel.org,
        linux-kernel@vger.kernel.org, olteanv@gmail.com,
        syzkaller-bugs@googlegroups.com, xiam0nd.tong@gmail.com
References: <000000000000873bb305df106d47@google.com>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <000000000000873bb305df106d47@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SORTED_RECIPS,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/15/22 11:42 AM, syzbot wrote:
> Hello,
> 
> syzbot has tested the proposed patch but the reproducer is still triggering an issue:
> WARNING: still has locks held in io_ring_submit_lock

Gah, might help if I actually push out the change...

#syz test: git://git.kernel.dk/linux-block.git for-next

-- 
Jens Axboe

