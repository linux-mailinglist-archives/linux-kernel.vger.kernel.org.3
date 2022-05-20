Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C25A452EE49
	for <lists+linux-kernel@lfdr.de>; Fri, 20 May 2022 16:36:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349965AbiETOgZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 May 2022 10:36:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233904AbiETOgV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 May 2022 10:36:21 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27AAF56779
        for <linux-kernel@vger.kernel.org>; Fri, 20 May 2022 07:36:20 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id i1so7523488plg.7
        for <linux-kernel@vger.kernel.org>; Fri, 20 May 2022 07:36:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:from:in-reply-to:content-transfer-encoding;
        bh=INFqOgoNC8M2kVfmoFeOv9h9ykovwpCyeybqDjrCvqM=;
        b=w03MvGAGC+lICJ+stSchnIesIheHXMiHhf0qrEVv67QbymHRXNbIypjXQ+EqeUnBuy
         6D4IttDBhpA9QAUnxhpVtgMsyMJGNe7NbVv6HSKeO+XC8WdgE7dBa+epExGgye/AIa8B
         csMprCAqlxRNdOB0B/WQF6ty1+oRuVpsspYWwo0OmVUGfQbVBzg+W0WFjaSr8leQBWhV
         Reb0jwJpnoBujnOIQgBFBvzScsg0CmrMOg0kw2ZyiSe1VGOAskAqE6ZlA0jdYnHyvk4v
         tgJaokan8D56Ge9H+B6Sqc1hoqJ/yB4vvlj4F8V5pUL72lvJ8aa4D3uV/3IS+X0FFhLZ
         WZ9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=INFqOgoNC8M2kVfmoFeOv9h9ykovwpCyeybqDjrCvqM=;
        b=2DfwboCzsTL0oxGqZ/TxQrgTjzno2nvZhHhzI/I80cNy9I0QA3OsedCDA2PJwasZWF
         ZsmLSFCp7kGu5TAcakOt6Z2oEgh8qhjnX446mdtQndAigBj/AFxb56uSXF/YR8Rd4ThI
         gskqk6dc3gqMxI13hVy4fzO6yo8tltZnK/OjIKNWhX7EaE4TREG0v7f/zhy9xT1XeZCQ
         69esuUgyFrnjd7FhNtg4oezuTDEmdIGkqcBSszQ2hhg0ubpMdU5Si11sFtJCoPtn2mU0
         1xizVdJCuE0hUz0y7pxtbq6r3qBDkp+QlaqZx3lcW/0ofVLOcGwrRkl1RavOshlgG6kJ
         Og6A==
X-Gm-Message-State: AOAM533U533NsH2qxJkJZYzo49cLWUOA2Swbhx1RbWjI3Ne9cRQEcrXZ
        mHV2JxCD1CFmsWRGDl5By5Hd0M9WjkbDhg==
X-Google-Smtp-Source: ABdhPJzUkmKyY1r8SzhHanCj/XsjiifTUk1pF5AJAsg0szitt8lG3Soz6+x8pP6Zf2UXY6if4UWT/g==
X-Received: by 2002:a17:90b:4f47:b0:1df:ef58:d055 with SMTP id pj7-20020a17090b4f4700b001dfef58d055mr6128568pjb.82.1653057379617;
        Fri, 20 May 2022 07:36:19 -0700 (PDT)
Received: from [192.168.1.100] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id o9-20020a170902d4c900b0015e8d4eb1dfsm5787324plg.41.2022.05.20.07.36.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 May 2022 07:36:19 -0700 (PDT)
Message-ID: <35a5ff9f-79d7-feb5-dfa7-a775b9352416@kernel.dk>
Date:   Fri, 20 May 2022 08:36:17 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH v4 1/3] random: convert to using fops->read_iter()
Content-Language: en-US
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Theodore Ts'o <tytso@mit.edu>, Christoph Hellwig <hch@lst.de>,
        LKML <linux-kernel@vger.kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>
References: <20220520094459.116240-1-Jason@zx2c4.com>
 <20220520094459.116240-2-Jason@zx2c4.com> <YoeZi94CpGW9LE/y@zx2c4.com>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <YoeZi94CpGW9LE/y@zx2c4.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/20/22 7:37 AM, Jason A. Donenfeld wrote:
> On Fri, May 20, 2022 at 11:44:57AM +0200, Jason A. Donenfeld wrote:
>>  const struct file_operations urandom_fops = {
>> -	.read = urandom_read,
>> +	.read_iter = urandom_read_iter,
> 
> One thing I noticed is that drivers/char/mem.c has both the .read and
> the .read_iter functions for /dev/zero and /dev/null and such. I wonder
> if the .read ones can be removed?

I'm not sure if we have a clear "always use this if available" set of
rules for this. Ideally we'd want it to be:

1) Use ->read_iter() if available
2) If not, use ->read()

Might require a bit of auditing to ensure that's the case, and if we
can say that it is, then we could clean that up too.

-- 
Jens Axboe

