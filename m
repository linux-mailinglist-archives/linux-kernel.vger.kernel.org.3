Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 342D94F9D88
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Apr 2022 21:10:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239199AbiDHTM2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Apr 2022 15:12:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229676AbiDHTMX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Apr 2022 15:12:23 -0400
Received: from mail-il1-x12a.google.com (mail-il1-x12a.google.com [IPv6:2607:f8b0:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB7F439B83
        for <linux-kernel@vger.kernel.org>; Fri,  8 Apr 2022 12:10:15 -0700 (PDT)
Received: by mail-il1-x12a.google.com with SMTP id x9so7113713ilc.3
        for <linux-kernel@vger.kernel.org>; Fri, 08 Apr 2022 12:10:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=uaceRjBB2mDTyHzrgasDxaH0Scftp6QF398Ljtd1+os=;
        b=s1MqjSL/CHfTdm31fAKGu57ADqPRJl+amfCgBH7Ug7pvLE5BUNP6bJxV+JLuIU+A/D
         Obhb85OpQr1/oK/tKt0m7X+fdEIS+659SBs+aLa9wa80aebBdjvGaq6Y95dEzaZq0co+
         GsilxsbjDp8i6cPlvMcHtMpdoMSR1cJ6m1dalinxWPJH+NnWKs/hGMyynI0luGSLcWKZ
         AByQkS1VlThw2+MtLwM/PWk/nbfZn/ZdFtbxPtcgWrHIPTyQ5FYNWWw+sbM7pUlg+1mO
         NDM+Heq+qsLNNuiaqpkYR28zWIPkBPs3CWLhgaZ73LLu4766+u83eVRkWU5CCHOcs7Yd
         0dxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=uaceRjBB2mDTyHzrgasDxaH0Scftp6QF398Ljtd1+os=;
        b=dk3EeHsMF6fJWGJtcBt1tdqKbi3LazhnOwjYYZSDAbBqY15jPynVALdFx4BEAKnd4w
         0o5dwE17+2uWIIbJoptFyD4or+DEc8jn6bGS6iQi2hMx/7vzkEs4IvW1rVlNfL1++HgJ
         SR1BqJLjktjyMqO3Fa8HVqLumnnzJFH16sCbvvt1Hh4XORWiIxt9pOOYmX2ySLrM2OB6
         hwyYAFeENmelkzSyDH6B3K/+S/+elSWuqA5QCv857xkRvYYraFbD+NO4ptlc9SvbI+jH
         6KvBQjEQC7ywOJWCA1HMxAMHC34mJRzgiVJ/Oi3n8PQBf/GXztOADCQ97pnOeCVujSnN
         MOwA==
X-Gm-Message-State: AOAM533S4ZGYJEr8GEDlwEry+Cb1+ERPXtHX7tZpHO42NhydwDY79+8A
        eJza+d2EEG5veSpjZFg90xacTw==
X-Google-Smtp-Source: ABdhPJxtcYltX1BnEPzh0LFo0to385E6nrfK7qi+Y+TAJR6n34lh/R0BX7OkkS0En6Ghcbwvmqedyw==
X-Received: by 2002:a05:6e02:1b83:b0:2c8:c95:a4b3 with SMTP id h3-20020a056e021b8300b002c80c95a4b3mr9256011ili.293.1649445015192;
        Fri, 08 Apr 2022 12:10:15 -0700 (PDT)
Received: from [192.168.1.172] ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id o3-20020a0566022e0300b0064ca88c0893sm16478414iow.10.2022.04.08.12.10.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 08 Apr 2022 12:10:14 -0700 (PDT)
Message-ID: <d50a0ee1-c7e2-1b99-8d3f-ce2edeea92cd@kernel.dk>
Date:   Fri, 8 Apr 2022 13:10:13 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH -next RFC v2 0/8] improve tag allocation under heavy load
Content-Language: en-US
To:     Yu Kuai <yukuai3@huawei.com>, andriy.shevchenko@linux.intel.com,
        john.garry@huawei.com, ming.lei@redhat.com
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        yi.zhang@huawei.com
References: <20220408073916.1428590-1-yukuai3@huawei.com>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20220408073916.1428590-1-yukuai3@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For this one, and other patches you send, they send up in spam because
the sender can't be verified. I would encourage you to figure out what
is going wrong here, because a lot of your patches end up getting
dropped or missed because of it.

-- 
Jens Axboe

