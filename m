Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F92B510593
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 19:38:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351687AbiDZRlE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 13:41:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232694AbiDZRlA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 13:41:00 -0400
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com [IPv6:2607:f8b0:4864:20::b2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF6FD12D95D
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 10:37:50 -0700 (PDT)
Received: by mail-yb1-xb2d.google.com with SMTP id d12so15059043ybc.4
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 10:37:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=eclypsium.com; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=tH/YgBif6d6yzwmumvRLfWV+AljH646yqRcC2C5Xmag=;
        b=El35gwLQGL+3kGJERF8gp0inRfDgb8jqvTTV/IGHhywPc7DF/bR5K5hk5LRBmn1uqL
         vGL5Go4qrIdBIKDY8qV3+z0bU1A1YLWT/DGoTiV8/NEKbUTdllXwl4YUrLR5cDoSNiix
         5BzO3+o/yqTvkpGlQY7PjxOnAsG7WJJcl0Gcbc1k0C4vcro8NNETJPFo+773PN0ej84I
         tAcTq/yj0TWaXXih9rfMtTD+Cza2WtiLwjJjP25UximL75DGVuC/RNDWBH753+8WnBvl
         Ed7gzIkSgtuYjGN5NS5T+PNWhUGjiUbr2uPDA3lVTxp+/SiawFEhTZJTa5VOUnz4toOV
         yGpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=tH/YgBif6d6yzwmumvRLfWV+AljH646yqRcC2C5Xmag=;
        b=X7zLYSAZT/EWjar5F7vHkh0PQNWor2PadgrhsxRwZrk7DViT6N0hNT1PGx2bSV3+KC
         hF1yiElziM6uvwudj7uw9NbuLOvNmcnhYKI0YOdjaK46mUXgVQkO4+EwnvzQPqOWmiR+
         0p/qXaDJMeph878wrAInClqjHVJSYKbmNhgUl7LZymr19f5KC98fFL3mOgypCNYDHAgz
         7UdXZ6NbfDQaJSN+a/UzUbguU1LzItCgPN1n/5pyOQKa1VbHJ+nNfKwK6969ggRhGtdZ
         C1kn5NtdJelqhLVgoSpFO+hpe9MAKbgt7RRJlYU3qtbr1dqT0Gfb6DTddiFK9HdhFa3Y
         5AWw==
X-Gm-Message-State: AOAM531UpEh0NL0a69etk5S/i/ibNs9iADwGgeVvy+w/SS8ZjXqdisnZ
        7DwvdgNvjn1N8TFlhvKstANYw1YrVLGrx7GT1shZOA==
X-Google-Smtp-Source: ABdhPJz1HJ1Wqfc/OMXGlEWodjJTdhl+j6KWkOff8Bx0FMZco18xRQS2BiQyyC+zw/RofYtnfxABe28XP3iE3H3aNyo=
X-Received: by 2002:a05:6902:150c:b0:648:94be:2c7e with SMTP id
 q12-20020a056902150c00b0064894be2c7emr7100545ybu.601.1650994670167; Tue, 26
 Apr 2022 10:37:50 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a81:10a:0:0:0:0:0 with HTTP; Tue, 26 Apr 2022 10:37:49 -0700 (PDT)
In-Reply-To: <a02186b9-b72c-1484-2973-c59272ae0a7e@intel.com>
References: <20220425171526.44925-1-martin.fernandez@eclypsium.com>
 <20220425171526.44925-6-martin.fernandez@eclypsium.com> <a02186b9-b72c-1484-2973-c59272ae0a7e@intel.com>
From:   Martin Fernandez <martin.fernandez@eclypsium.com>
Date:   Tue, 26 Apr 2022 14:37:49 -0300
Message-ID: <CAKgze5Y1bKUAqPHEY71y_puTmuV2K02qjt0qzwO-KA3SYio0Tw@mail.gmail.com>
Subject: Re: [PATCH v7 5/8] x86/e820: Refactor e820__range_remove
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     linux-kernel@vger.kernel.org, linux-efi@vger.kernel.org,
        platform-driver-x86@vger.kernel.org, linux-mm@kvack.org,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
        ardb@kernel.org, dvhart@infradead.org, andy@infradead.org,
        gregkh@linuxfoundation.org, rafael@kernel.org, rppt@kernel.org,
        akpm@linux-foundation.org, daniel.gutson@eclypsium.com,
        hughsient@gmail.com, alex.bazhaniuk@eclypsium.com,
        alison.schofield@intel.com, keescook@chromium.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/26/22, Dave Hansen <dave.hansen@intel.com> wrote:
> On 4/25/22 10:15, Martin Fernandez wrote:
>> +/**
>> + * e820__range_remove() - Remove an address range from e820_table.
>> + * @start: Start of the address range.
>> + * @size: Size of the address range.
>> + * @old_type: Type of the entries that we want to remove.
>> + * @check_type: Bool to decide if ignore @old_type or not.
>> + *
>> + * Remove [@start, @start + @size) from e820_table. If @check_type is
>> + * true remove only entries with type @old_type.
>> + *
>> + * Return: The size removed.
>> + */
>
> The refactoring looks promising.  But, there's a *LOT* of kerneldoc
> noise, like:
>
>> + * @table: Target e820_table.
>> + * @start: Start of the range.
>> + * @size: Size of the range.
>
> and this:
>
>> + * struct e820_type_updater_data - Helper type for
>> + * __e820__range_update().
>> + * @old_type: old_type parameter of __e820__range_update().
>> + * @new_type: new_type parameter of __e820__range_update().
>
> Those are just a pure waste of bytes.  I suspect some more judicious
> function comments would also make the diffstat look more palatable.
>

I can get rid off of the kerneldocs and just put normal comments for some
functions that really need them.

> Also, in general, the naming is a bit verbose.  You might want to trim
> some of those names down, like:
>
>> +static bool __init crypto_updater__should_update(const struct e820_entry
>> *entry,
>> +						 const void *data)
>> +{
>> +	const struct e820_crypto_updater_data *crypto_updater_data =
>> +		(const struct e820_crypto_updater_data *)data;
>

Yes I agree on this. Do you have any suggestions for these kind of
functions? I want to explicitly state that these functions are in some of
namespace and are different of the other ones.

In the end I don't think this is very harmful since these functions are one-time
used (in a single place), is not the case that you have to use them everywhere..

> Those are just some high-level comments.  This also needs some really
> careful review of the refactoring to make sure that it doesn't break any
> of the existing e820 users.
>

I'm glad to hear more people's thoughts on this. Thanks for the feedback.
