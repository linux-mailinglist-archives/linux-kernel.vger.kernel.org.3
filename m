Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7123C52B459
	for <lists+linux-kernel@lfdr.de>; Wed, 18 May 2022 10:07:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232793AbiERH5v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 May 2022 03:57:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232769AbiERH5s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 May 2022 03:57:48 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0ACCC118007;
        Wed, 18 May 2022 00:57:47 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id i19so2126166eja.11;
        Wed, 18 May 2022 00:57:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=7ktjmA9lbYY+r3k7Xl4dUBOmRn/WA+0dOC0w53gvyVI=;
        b=X0zcqKITNYv1TLoj7hswq47oFfYJ7vnsmf3gLIsQ7si/uX69O69xbpuznQyl96N2KR
         6xl+3NoBa6wa9trbSHLKUdcI/doQHK8unsfCuQHXKvz9oYTQKR+RV31uM75p30dYaQu8
         EAkBrThXrZJusSX8iicfNV1vRQQnBc81rGVtDvJdIa5EITWBcbnKBsEtPPJ1jV3MD8bU
         XQEp3gdMeslcQY8gcRFIY5A+LH35hlhCVRdPv3WIF06Kyfyzazkti9tdidslDYjaxYva
         2L1uTNvWeoRBrq3ohGmn4BKzSLH4n6Xc3T7NX1v1HrUjgoTAglis9mleel6rzIWqN5E+
         4edg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=7ktjmA9lbYY+r3k7Xl4dUBOmRn/WA+0dOC0w53gvyVI=;
        b=LfsSVB0MEIMk7pGtSiEbvhsgkYxGwxroA7nFtmNUTPCrUYZsAgspKAafMrtaZ/iP1K
         6DxVcp8r5otFu4It6GkKS3bNcAYBnrydrM/umiWB5Ey+PMZlCCNwECZwZy2xyas7K3xd
         l+EO9b29QV9nNFb/hphQN9fjrd5ELCH4uzgJSC2wGqlXJ2ykLGuL1Rlk/ZfZuf04WX9G
         allNgTLLHDW+W9osh5Tb7uk2IOX+/6f+BKdOuPa4zhHYowYgM7mD4czvnwHtDCFT++j4
         ybV/+9cndx/G7R90gki46SK6Ez5qLcLMq9RHVAq9MPICeiYX2+EFQn/mX5sVpCjBbENB
         S/Sg==
X-Gm-Message-State: AOAM533SqgPGR5jV8Pq9nTs5HqM+lsiSBMpehxeaS4aGAqhIBpjDspeR
        ceyrYaFmFwVP3XINjDZRNec=
X-Google-Smtp-Source: ABdhPJztZ+He6oZQpf5QYU8EpE4w74uBqb8gCz5K0anlddF2ScBUceeYay5gmr2N6k7sTt2XgAqIxw==
X-Received: by 2002:a17:907:7216:b0:6f4:70d4:a3c4 with SMTP id dr22-20020a170907721600b006f470d4a3c4mr22754545ejc.529.1652860665411;
        Wed, 18 May 2022 00:57:45 -0700 (PDT)
Received: from [192.168.2.27] (85-70-151-113.rcd.o2.cz. [85.70.151.113])
        by smtp.gmail.com with ESMTPSA id ee46-20020a056402292e00b0042617ba63aesm928060edb.56.2022.05.18.00.57.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 May 2022 00:57:44 -0700 (PDT)
Message-ID: <19149028-ec94-8f64-aed4-1e58f29942a8@gmail.com>
Date:   Wed, 18 May 2022 09:57:43 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [dm-devel] [PATCH v4 1/3] dm: Add verity helpers for LoadPin
Content-Language: en-US
To:     Matthias Kaehlcke <mka@chromium.org>,
        Alasdair Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        James Morris <jmorris@namei.org>,
        "Serge E . Hallyn" <serge@hallyn.com>
Cc:     dm-devel@redhat.com, Douglas Anderson <dianders@chromium.org>,
        linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org,
        Song Liu <song@kernel.org>,
        linux-security-module@vger.kernel.org
References: <20220517233457.1123309-1-mka@chromium.org>
 <20220517163437.v4.1.I3e928575a23481121e73286874c4c2bdb403355d@changeid>
From:   Milan Broz <gmazyland@gmail.com>
In-Reply-To: <20220517163437.v4.1.I3e928575a23481121e73286874c4c2bdb403355d@changeid>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18/05/2022 01:34, Matthias Kaehlcke wrote:
> LoadPin limits loading of kernel modules, firmware and certain
> other files to a 'pinned' file system (typically a read-only
> rootfs). To provide more flexibility LoadPin is being extended
> to also allow loading these files from trusted dm-verity
> devices. For that purpose LoadPin can be provided with a list
> of verity root digests that it should consider as trusted.
> 
> Add a bunch of helpers to allow LoadPin to check whether a DM
> device is a trusted verity device. The new functions broadly
> fall in two categories: those that need access to verity
> internals (like the root digest), and the 'glue' between
> LoadPin and verity. The new file dm-verity-loadpin.c contains
> the glue functions.
> 
> Signed-off-by: Matthias Kaehlcke <mka@chromium.org>

...

> +
> +	if (dm_verity_get_root_digest(ti, &root_digest, &digest_size))
> +		return false;

Almost unrelated note, but as there are more and more situations
that checks verity root digest, shouldn't we export this as read-only
sysfs attribute for DM verity devices?

Attacker can always calculate (but not change) Merkle tree, so this
is not something that need to be hidden.

It would allow userspace to easily enumerate trusted DM devices without
calling kernel ioctls...

...

> +
> +	table = dm_get_live_table(md, &srcu_idx);
> +
> +	if (dm_table_get_num_targets(table) != 1)
> +		goto out;
> +
> +	ti = dm_table_get_target(table, 0);
> +
> +	if (is_trusted_verity_target(ti))
> +		trusted = true;

What happens is someone reloads verity table later with
a different content (or even different target type)?
Does LoadPin even care here?

...

>   static struct target_type verity_target = {
>   	.name		= "verity",
>   	.version	= {1, 8, 0},

Please increase the minor version, it is very useful to detect (in logs)
that the target driver has compatible extensions.


I guess this change does not affect userspace veristysetup
(as it is used handled by different tooling), right?

Thanks,
Milan
