Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD44F4EF6D3
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Apr 2022 17:57:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351364AbiDAPoq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Apr 2022 11:44:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352776AbiDAPDr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Apr 2022 11:03:47 -0400
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com [IPv6:2607:f8b0:4864:20::d2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F76B2976C9
        for <linux-kernel@vger.kernel.org>; Fri,  1 Apr 2022 07:51:38 -0700 (PDT)
Received: by mail-io1-xd2c.google.com with SMTP id g21so3371558iom.13
        for <linux-kernel@vger.kernel.org>; Fri, 01 Apr 2022 07:51:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:from:in-reply-to:content-transfer-encoding;
        bh=D14pWmbu4syU7uJkQHRgnmv++dTH97de4155oI8GfsE=;
        b=EQFT0Jhws+NvlMFDO4cBK8+vf0xZwe0spwHwZaPLSg4VvMLB7O/3/xcGChCgFxwUDT
         WeDHcSV03eHkg/jH1HOSCi+2geSHjLXmNnPSX/kJkH39OL7XtdYiO5wMnQDkcOePvXVS
         GkyogTnrt9Ur/DBa7KVq6IJHpHn/Ktp0atNXyZDLmoCV0TMJx6/KFawzKNvzg1YAYKu5
         TEbVn0a2cGn/HNgWKylLCrvPMh4SqGx6mieBvI4hYr7UtHiMYoGbCsCFPMu0QAKzlRpt
         udKy5AXiB/YJYg7HbQF5mzHyQok2/LNQiv2Kci7T8vV15xkuTExtph5zrk6goZh+9QoT
         ia2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=D14pWmbu4syU7uJkQHRgnmv++dTH97de4155oI8GfsE=;
        b=6WoJKFVJGogHydCTGPDAdnYJUJCw2Bu5QVKwfNUAOcVl0jkbAOWJneLzBf6+3o/OuV
         5ykHoR2etIKstCyocj6Hf49d+4yEqYp6w+e0PTy0q0jtpM7NhBQz5SAmGU5YvyvqyfUS
         6n/u50OGsybg519KCO3h8NI3eaZeo6QgGVuC5MNLhYfpOFnbMkLHlaIKOCHKWwNnrkxQ
         AwHhcEnZXD9+5p806CPCl83tWIXFcV6gXVJAWO8KbJVL+M2FbX8wfe8Ixw53suYMK93T
         wpsVninF/7pTc8gVlb4SyTrawkF1+Z4ZcitNskP6vz7mquREmAdcBKDCoPNix/WawUvE
         iiYg==
X-Gm-Message-State: AOAM533mwsDJ+UnyG56OqcqX+/woXsk4a4BE6RrEPcJ49InRxrmkOskU
        PBN2DAqNkOVKGrg/WQNAjoV0BpyHa12arSdH
X-Google-Smtp-Source: ABdhPJzYbeqp+kwp8qzmr13henE1FZQIuNtACTLsPIF/1inWLvoPj0gol9ZBEuaZQ3uoKF4MM4aH0A==
X-Received: by 2002:a6b:5d19:0:b0:645:c7ca:7ca with SMTP id r25-20020a6b5d19000000b00645c7ca07camr68440iob.104.1648824697737;
        Fri, 01 Apr 2022 07:51:37 -0700 (PDT)
Received: from [192.168.1.172] ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id v2-20020a056e020f8200b002c9a9b96b67sm1445723ilo.23.2022.04.01.07.51.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 01 Apr 2022 07:51:37 -0700 (PDT)
Message-ID: <d713dcc7-cdae-0834-f10a-c3cdcb6fa301@kernel.dk>
Date:   Fri, 1 Apr 2022 08:51:36 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [syzbot] KASAN: use-after-free Read in io_poll_check_events
Content-Language: en-US
To:     syzbot <syzbot+edb9c7738ba8cbdbf197@syzkaller.appspotmail.com>,
        asml.silence@gmail.com, io-uring@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
References: <00000000000009bb4505db96e211@google.com>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <00000000000009bb4505db96e211@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/1/22 6:26 AM, syzbot wrote:
> syzbot has bisected this issue to:
> 
> commit d570aa1c4f191100f502edfc240e8d49687f62ac
> Author: Jens Axboe <axboe@kernel.dk>
> Date:   Thu Mar 31 18:38:46 2022 +0000
> 
>     io_uring: drop the old style inflight file tracking

#syz test git://git.kernel.dk/linux-block for-next

-- 
Jens Axboe

