Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 253505A65D6
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 16:00:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229836AbiH3OAf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 10:00:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231341AbiH3N76 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 09:59:58 -0400
Received: from mail-il1-x132.google.com (mail-il1-x132.google.com [IPv6:2607:f8b0:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A4E8B2CCF
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 06:59:34 -0700 (PDT)
Received: by mail-il1-x132.google.com with SMTP id a9so3387266ilh.1
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 06:59:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=KUO2x6GMyJ0E32QWlRjYyOMdCN2D/9InXcZ/H9pOtPc=;
        b=tOaXpq9hQc/TYnVfkq7TPBt9SgMvSWjMwdoXvBNyYVfru9NA3E2ZQGDoQjOCIRoZuc
         vjyGTlSQRIK01ePOH5dPTrG5/0px6ZTbrPGP/IewB+UQfPCYlYjhRaBISFcruZgT/6BK
         LUcBRxtC948e7gtSInWMlBwdoEkkDLAumHkkUaK28u1g0sPNCdzkI8+sXM5230C8dgOr
         fF0K+shBY/+h/Q7lvk2B4NB2dvG6YTYbngeSnE3MtwKtRE9H0mraVSpHwDGSGvFNqELm
         RniNTGBp0zLX3z+RYq4Rfi6C5Ov8X/DY/bPg7exuyhsy5gfAZB9ypV0JhlN4kMsqRazj
         Zmbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=KUO2x6GMyJ0E32QWlRjYyOMdCN2D/9InXcZ/H9pOtPc=;
        b=w/FbofXDqOUrGOkH/cTIzZYb37Egqu1Bq4MC09gR0HkZew/4YkAsU9jx85UGvXkkXD
         MkekwQeE0gAwfsimlE8iRzkD/RRD6jYjztXzK9fqWE0EoGR414mqLOpNGBIHgs024yVp
         cDiZqVa/e/8WA+EADonOqtBPYbNstmdguINPPZ14FY6jifC8OihJNe+8jUtNGd2Xfo/O
         QJMCHOyYuKD9WmoBn78/jN5VMdWCVXqoMFG0THxC0/1AhOpGSwjV4sC0tGyFOxH1NxbH
         NIEH2RiB+pnpRreNXp//XCWYu/0y8Pukdoe0RVeUbsrX7/bux09X/UG/MlcxcBZqaRi/
         juYg==
X-Gm-Message-State: ACgBeo1Iam9addpeJ2NJfIKgU5khINiPyyTUWea7Yh1tOwTyd4+wajDa
        iu3Y4DaMzNUsTuwKOOVJtU8Gydc0avDakA==
X-Google-Smtp-Source: AA6agR42v0TIOtplOU5TgHzx+J3kxMBrfiH/yz8vc+Bl4yxoZCRoBHh/kl1SGEU+NZj6IWwIE7kajg==
X-Received: by 2002:a92:dcc2:0:b0:2e4:38f2:a9f6 with SMTP id b2-20020a92dcc2000000b002e438f2a9f6mr12641429ilr.130.1661867973804;
        Tue, 30 Aug 2022 06:59:33 -0700 (PDT)
Received: from [192.168.1.94] ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id j22-20020a02a696000000b00349da92944bsm5548637jam.176.2022.08.30.06.59.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Aug 2022 06:59:33 -0700 (PDT)
Message-ID: <908d464e-e695-3a27-56f6-1ceabd727989@kernel.dk>
Date:   Tue, 30 Aug 2022 07:59:32 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.2
Subject: Re: [RFC PATCH] blk-mq: change bio_set_ioprio to inline
Content-Language: en-US
To:     Liu Song <liusong@linux.alibaba.com>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1661852746-117244-1-git-send-email-liusong@linux.alibaba.com>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <1661852746-117244-1-git-send-email-liusong@linux.alibaba.com>
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

On 8/30/22 3:45 AM, Liu Song wrote:
> From: Liu Song <liusong@linux.alibaba.com>
> 
> Change "bio_set_ioprio" to inline to avoid calling overhead.

Let's not try to 2nd guess the compiler here. Most things that are
marked inline should not be.

-- 
Jens Axboe


