Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 260075AB52A
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Sep 2022 17:30:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236222AbiIBPaV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Sep 2022 11:30:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236609AbiIBPaD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Sep 2022 11:30:03 -0400
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com [IPv6:2607:f8b0:4864:20::82a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40780DF26
        for <linux-kernel@vger.kernel.org>; Fri,  2 Sep 2022 08:09:13 -0700 (PDT)
Received: by mail-qt1-x82a.google.com with SMTP id c20so1651770qtw.8
        for <linux-kernel@vger.kernel.org>; Fri, 02 Sep 2022 08:09:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=MgFEkju7aDa57SZcgAzeFGulkvAIZ2x+6v5qRawISdk=;
        b=ocYYfzHESRjQ7FCwHGNEZZU7NUkK29AyJijb5HJ+3OWkymojw7yEUKEX6c8UzFCDrN
         weqW4TwnZkwbOQL2AV+hX3rfITAChYAcqezgq3AtQ8z9B+N1bxbxhvvYsCpeNrTD//8m
         /BOR2K0lmHOaIq5tky2YsgjwOvPsHIKQ98hr4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=MgFEkju7aDa57SZcgAzeFGulkvAIZ2x+6v5qRawISdk=;
        b=LH9vvprDYTljNlwApNJJ6BiQTnlUN2hQBBe7dBNpaKypN6wpPN6XlCy6VbdHeq2xZN
         CV9Y5I+8pz9WJk15MsZwcOtD2ISCL+6nCE3xi9CMWThT11PKGYzaZLysirepsFP8m6Bk
         k9kc9abIztbovLodbpFwGxgEmCx4TFevoKtpMkxVnqhvbSExUDulm/rRLKYTUhG+1rZj
         KrmMIljdY/anBBsAlh8TmrJT/Z8eQDwpnmsvjDPy7MV4DrkWv9BZLiOEb2N08QWEwmeb
         DxeUkIdJsClgt5T1201mND6lTDOU8cejyxyqUmYVbDEgeSIOV155VStw/D98RS5PO7Wk
         GknA==
X-Gm-Message-State: ACgBeo35O0p7Tm5VXMf8Ukvll4dOQPgkfbbZUQNDCVtlCey3Pu5b0TNH
        FP5HbMw2u9okLbUNQYyRZL79pw==
X-Google-Smtp-Source: AA6agR54q25QXGJy3h+W0QbAKmNR68p+5BSzNjwS+rYD46HFDTfgExtB7LFixE7h/4CWmJ7+aHwkqw==
X-Received: by 2002:ac8:7d96:0:b0:344:8cb0:ae8b with SMTP id c22-20020ac87d96000000b003448cb0ae8bmr28853995qtd.628.1662131352283;
        Fri, 02 Sep 2022 08:09:12 -0700 (PDT)
Received: from [10.0.0.40] (c-73-148-104-166.hsd1.va.comcast.net. [73.148.104.166])
        by smtp.gmail.com with ESMTPSA id 2-20020ac85742000000b003434f7483a1sm1182641qtx.32.2022.09.02.08.09.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 02 Sep 2022 08:09:11 -0700 (PDT)
Message-ID: <013ca416-72de-8059-a5d5-cd63c92ef119@joelfernandes.org>
Date:   Fri, 2 Sep 2022 11:09:08 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH v5 02/18] mm/sl[au]b: rearrange struct slab fields to
 allow larger rcu_head
Content-Language: en-US
To:     Vlastimil Babka <vbabka@suse.cz>, rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, rushikesh.s.kadam@intel.com,
        urezki@gmail.com, neeraj.iitr10@gmail.com, frederic@kernel.org,
        paulmck@kernel.org, rostedt@goodmis.org, vineeth@bitbyteword.org,
        boqun.feng@gmail.com, Hyeonggon Yoo <42.hyeyoo@gmail.com>
References: <20220901221720.1105021-1-joel@joelfernandes.org>
 <20220901221720.1105021-3-joel@joelfernandes.org>
 <e84c90f2-d76f-83d4-d40b-403f894eda33@suse.cz>
 <75ad3ed3-7dcd-474c-472c-ca32c1734281@suse.cz>
From:   Joel Fernandes <joel@joelfernandes.org>
In-Reply-To: <75ad3ed3-7dcd-474c-472c-ca32c1734281@suse.cz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/2/2022 5:30 AM, Vlastimil Babka wrote:
> On 9/2/22 11:26, Vlastimil Babka wrote:
>> On 9/2/22 00:17, Joel Fernandes (Google) wrote:
>>> From: Vlastimil Babka <vbabka@suse.cz>
>>>
>>> Joel reports [1] that increasing the rcu_head size for debugging
>>> purposes used to work before struct slab was split from struct page, but
>>> now runs into the various SLAB_MATCH() sanity checks of the layout.
>>>
>>> This is because the rcu_head in struct page is in union with large
>>> sub-structures and has space to grow without exceeding their size, while
>>> in struct slab (for SLAB and SLUB) it's in union only with a list_head.
>>>
>>> On closer inspection (and after the previous patch) we can put all
>>> fields except slab_cache to a union with rcu_head, as slab_cache is
>>> sufficient for the rcu freeing callbacks to work and the rest can be
>>> overwritten by rcu_head without causing issues.
>>>
>>> This is only somewhat complicated by the need to keep SLUB's
>>> freelist+counters aligned for cmpxchg_double. As a result the fields
>>> need to be reordered so that slab_cache is first (after page flags) and
>>> the union with rcu_head follows. For consistency, do that for SLAB as
>>> well, although not necessary there.
>>>
>>> As a result, the rcu_head field in struct page and struct slab is no
>>> longer at the same offset, but that doesn't matter as there is no
>>> casting that would rely on that in the slab freeing callbacks, so we can
>>> just drop the respective SLAB_MATCH() check.
>>>
>>> Also we need to update the SLAB_MATCH() for compound_head to reflect the
>>> new ordering.
>>>
>>> While at it, also add a static_assert to check the alignment needed for
>>> cmpxchg_double so mistakes are found sooner than a runtime GPF.
>>>
>>> [1] https://lore.kernel.org/all/85afd876-d8bb-0804-b2c5-48ed3055e702@joelfernandes.org/
>>>
>>> Reported-by: Joel Fernandes <joel@joelfernandes.org>
>>> Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
>>
>> I've added patches 01 and 02 to slab tree for -next exposure before Joel's
>> full series posting, but it should be also ok if rcu tree carries them with
>> the whole patchset. I can then drop them from slab tree (there are no
>> dependencies with other stuff there) so we don't introduce duplicite commits
>> needlessly, just give me a heads up.
> 
> Ah but in that case please apply the reviews from my posting [1]
> 
> patch 1:
> Reviewed-by: Hyeonggon Yoo <42.hyeyoo@gmail.com>
> 
> patch 2
> Acked-by: Hyeonggon Yoo <42.hyeyoo@gmail.com>
> 
> [1] https://lore.kernel.org/all/20220826090912.11292-1-vbabka@suse.cz/


Sorry for injecting confusion - my main intent with including the mm patches in
this series is to make it easier for other reviewers/testers to backport the
series to their kernels in one shot. Some reviewers expressed interested in
trying out the series.

I think it is best to let the -mm patches in the series go through the slab
tree, as you also have the Acks/Reviews there and will take sure those
dependencies are out of the way.

My lesson here is to be more clear, I could have added some notes for context
below the "---" of those mm patches.

Thanks again for your help,

- Joel
