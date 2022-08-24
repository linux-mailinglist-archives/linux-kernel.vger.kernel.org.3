Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6084859FA87
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Aug 2022 14:53:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237189AbiHXMxu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Aug 2022 08:53:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232564AbiHXMxj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Aug 2022 08:53:39 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4795296753
        for <linux-kernel@vger.kernel.org>; Wed, 24 Aug 2022 05:53:38 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id x14-20020a17090a8a8e00b001fb61a71d99so1505342pjn.2
        for <linux-kernel@vger.kernel.org>; Wed, 24 Aug 2022 05:53:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=4x7rCbb98jj2MaSBdFm3SDEQp0i7SVqT+8rNiIgDvNQ=;
        b=rciuwxHpu+evpljQNfKJs+0b1dm0bOGf5k6J4GfJ8Ob2IKOQQrElCqhhYKDsCIIjl0
         h/tsTCQrEI6c4+WjnVOEhYSt42CA9ky8fTpdqnMSizqPvWuwMgXbMsOEBN4/qbQ5RJ6K
         WKaHxejxgDk5o0x3wvahIeAo8FdrxqQc9IaGT9ncDJC+6ufUu5Q2rEDXvBfUlqiTBvJo
         d2S+WEo4OjaJci8aN0GrQupoKi9P9KbiR+J2DN64lO23y+D0bY08felAedr/11/FUTP7
         AdQsPuCGg6OTPw1xE1ZDnbfobion26t++Hy4Ac9io7PbM52n6wfVNEb6NdubzgCenD4t
         jgQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=4x7rCbb98jj2MaSBdFm3SDEQp0i7SVqT+8rNiIgDvNQ=;
        b=fDi0KDhYw+6mwWmQRT/wWRKcatEnmRxl4HLYN89NgdeOushbM7lXqueRtXG1G4FacZ
         7GoqBCqRwsW5jRpY7+t9LdjT0W4v7vIFnpdlevnYq580K7jUy1hg6YAGt4TZpWOGhVd6
         AeyehgsweWESv8dSrLQixuLDqMjBx3i63UD1a6XepIthDsrAhEiRGbXfjXrd1RJVEJw4
         K6KRckDTLJVtAMCPG2Avj0PwdS/oz7w/guWe2t75SgYCcOOxIl/ISDbvNYo9saHcxu9u
         kPRDnD89YCxZvaFHY/FUtJ6GyGEmyHrnaiij0ziMen6YbpAl2utr6q5wksWWDUnDugBQ
         E6iQ==
X-Gm-Message-State: ACgBeo0CqefH/iiS8fN5HtFgd/WC1z3PyVsA0WdAcKnCs3FqikWofl2B
        MO/y1coc/84sYTjw+wJiqAgp6Q==
X-Google-Smtp-Source: AA6agR77A1nkMFGgKB89xERjp52vEWHB5SOhbqG7h6vi9MrZLvKLm1L+Fj0SrOLng6jFSwdPvfIbQA==
X-Received: by 2002:a17:903:258e:b0:173:10fb:10d6 with SMTP id jb14-20020a170903258e00b0017310fb10d6mr4172092plb.67.1661345617755;
        Wed, 24 Aug 2022 05:53:37 -0700 (PDT)
Received: from [192.168.1.136] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id s19-20020a635253000000b0040d75537824sm6722788pgl.86.2022.08.24.05.53.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Aug 2022 05:53:37 -0700 (PDT)
Message-ID: <202a2d80-5290-452e-db8e-3a0c10b79840@kernel.dk>
Date:   Wed, 24 Aug 2022 06:53:35 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.2
Subject: Re: [PATCH v2] loop: Check for overflow while configuring loop
Content-Language: en-US
To:     Siddh Raman Pant <code@siddh.me>
Cc:     linux-kernel-mentees 
        <linux-kernel-mentees@lists.linuxfoundation.org>,
        stable <stable@vger.kernel.org>,
        linux-block <linux-block@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        syzbot+a8e049cd3abd342936b6 
        <syzbot+a8e049cd3abd342936b6@syzkaller.appspotmail.com>
References: <20220823160810.181275-1-code@siddh.me>
 <166127140632.124225.483036207879834754.b4-ty@kernel.dk>
 <182cee8e2a7.5a62eb4811173.7413734946973464259@siddh.me>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <182cee8e2a7.5a62eb4811173.7413734946973464259@siddh.me>
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

On 8/24/22 2:12 AM, Siddh Raman Pant wrote:
> On Tue, 23 Aug 2022 21:46:46 +0530  Jens Axboe  wrote:
>> Applied, thanks!
>>
>> [1/1] loop: Check for overflow while configuring loop
>>       commit: f11ebc7347340d291ba032a3872e40d3283fc351
> 
> Thanks!
> 
> Though, it seems that you have used the mailing list's address
> (linux-kernel-mentees@lists.linuxfoundation.org) in the author
> field instead of the Signed-off email.

Weird! I'll let Konstantin know about this one, I've manually
fixed it up.

-- 
Jens Axboe


