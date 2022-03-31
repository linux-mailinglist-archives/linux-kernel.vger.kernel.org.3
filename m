Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1996B4ED91D
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Mar 2022 14:02:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235506AbiCaMDq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Mar 2022 08:03:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235498AbiCaMCh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Mar 2022 08:02:37 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E807530575
        for <linux-kernel@vger.kernel.org>; Thu, 31 Mar 2022 04:59:36 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id p17so23190672plo.9
        for <linux-kernel@vger.kernel.org>; Thu, 31 Mar 2022 04:59:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=KCzd1cYmD81YFpA7sO7MsSj7P6a5wWaVyEmyHM8Jq4Y=;
        b=OoI6T+guOwttwBls41pWyMV89jUSiZu+HkclfzaLZyCBwB1ptiYCLbBrOftTK5AEFV
         G91f6U0S/k+5Tq4c3tdWWf6kSa6WESuEOUEIbAomploca2YgEAOyYwQmq4q3J68Nb2J8
         NSiBvYsHlQ6ECiUIkvFvYhkjVPu1OLsVcZoBMXT/FOqPMvPbQkskNBxhvBLcx0yfbvPw
         xqjBXxixF9KCprW8EeGyazYZy3jquoD/ofsrXVTWdrYIZCxsyDMAOk27GkKrF9dd9jej
         +o+zMaPmR2JQyYip8Ve7Cz0wfEFt6TSrj/St0ueukRTVEf8Ya8YXvwelzveFdoJNvPu/
         qZLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=KCzd1cYmD81YFpA7sO7MsSj7P6a5wWaVyEmyHM8Jq4Y=;
        b=0SyfLU4EPky77cUkOSAOv63mWl0PyodLjg5OoJt8oqaJctTlizPCxKJzbm4xNgSDgM
         bwU52MITHm96ezHrI1K/COKKk6zetS6kYj5vpedHm/Jqn6y8I7NAhFJ4t71gUNqkmSxx
         gDj3eTnGSR7KNSvEpLfekk7KC+UlKK+IB3dIHfAmIjyCD8/kHv6flzLvSJpwH/bZslyc
         pz6oX7ACkhfpdE7ZbEcsdTjZV7fT5asfLYScvou7VjGq2zPasiBNM8oORE8zhT9QLvAq
         FXHqAHdqvvVuLNQPIMJ3kjSWiWD4nSUT/3DtVDTxFK/vduzWegEen1KmIQtKOzDYHwZJ
         xKpQ==
X-Gm-Message-State: AOAM531onJmEHJUNW6KlK/vyBeozG/ZS+L5TdBPujiY61K/PF4qbu8hE
        /VJwH755HqF1QXQfOp5bn9eE/A==
X-Google-Smtp-Source: ABdhPJzBYMxAps8GRFmVQoDt80yzI/kS5BlUW/Gbsw8dPIcwbpoEc3gPEZZ8sGb11FRejcmmhmmP6g==
X-Received: by 2002:a17:90b:4f41:b0:1c7:928d:196e with SMTP id pj1-20020a17090b4f4100b001c7928d196emr5707713pjb.47.1648727975265;
        Thu, 31 Mar 2022 04:59:35 -0700 (PDT)
Received: from [192.168.1.100] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id l18-20020a056a00141200b004f75395b2cesm27528667pfu.150.2022.03.31.04.59.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 31 Mar 2022 04:59:34 -0700 (PDT)
Message-ID: <a7b2fe8d-9967-2046-67a5-62d10e95a861@kernel.dk>
Date:   Thu, 31 Mar 2022 05:59:33 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v2] block: use dedicated list iterator variable
Content-Language: en-US
To:     Jakob Koschel <jakobkoschel@gmail.com>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bart Van Assche <bvanassche@acm.org>,
        Mike Rapoport <rppt@kernel.org>,
        Brian Johannesmeyer <bjohannesmeyer@gmail.com>,
        Cristiano Giuffrida <c.giuffrida@vu.nl>,
        "Bos, H.J." <h.j.bos@vu.nl>
References: <20220331091218.641532-1-jakobkoschel@gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20220331091218.641532-1-jakobkoschel@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/31/22 3:12 AM, Jakob Koschel wrote:
> To move the list iterator variable into the list_for_each_entry_*()
> macro in the future it should be avoided to use the list iterator
> variable after the loop body.
> 
> To *never* use the list iterator variable after the loop it was
> concluded to use a separate iterator variable instead of a
> found boolean [1].

Not a huge fan of doing a helper for this single use, but I guess it
does make the main function easier to code. So I guess that's fine. But
can you move the call down where the result is checked?

qe = blk_lookup_qe_pair(head, q);
if (!qe)
	return;

I prefer no distance between call and check, makes it easier to read. I
can make the edit locally and note it in the commit message so you don't
have to re-send it. Let me know, or just resend a v3.

-- 
Jens Axboe

