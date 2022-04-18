Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98366505D5D
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Apr 2022 19:15:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346861AbiDRRRv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Apr 2022 13:17:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346890AbiDRRRg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Apr 2022 13:17:36 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74728AE6F
        for <linux-kernel@vger.kernel.org>; Mon, 18 Apr 2022 10:14:56 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id w1so1760240lfa.4
        for <linux-kernel@vger.kernel.org>; Mon, 18 Apr 2022 10:14:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lDDzMF7def6Z3A0mNNBKl8WggzgVJx7e2B3vzhGya4k=;
        b=YCkmRSV2aipmAdUvTJ9mZvlRB7CoOQS8uhckO+ec/hsoJ1rzwQghZhWzLTkISdGBN4
         /BUZhUIi6TqLgPL4gUEd1NJCRB7bbblqthgC+tSsLvWEH/Up4TvhBQjgrm/QpfsaIQzZ
         kZ1pmCErLdIV3J1mdHtQ4pTxVWMl+NBIm08oTJkglzc37kmkj3X15wiZi1ostQBDM+4X
         iDuMIIptafWY61S6H4YdEhOQiD99od9OMyZeAqEZyDjaIPMGOjLHpchiGKy+j1X2V6aa
         WcMgJU7Ka1OTGTAc3aHNW9C8QJvdThdcNskW0Wu9LTX/JW0IH51FiWpYXPSnY3WoeG6C
         iNPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lDDzMF7def6Z3A0mNNBKl8WggzgVJx7e2B3vzhGya4k=;
        b=onUQRiIFUZf2bbnAAiarCgaKuftucY0TSps1iTQY+O0DHsTrUXv4Mjt2j8DyMU5ugH
         7Oj2CUXb8dI7YAQ5p1+fGuPDddk/O0iyznj44RYizRHaV+goQnbQsOWgMleljm9i7XMx
         /jcKYDZOrqHwXLTGTuLhD9sERgHBJOp6X12Admc6qRq7R1Jua6D5j0JFKAud9mWM4tyq
         xY+P7zHHXBKsxAFvphHWQ3W/sjB25IHtBvGchVAKZnr+esqgV34m0XaREF/g1Jdhhzcf
         /G7LwDipb6SIgAaODDcgaY+O3OQfhN/g17cqEa7Mdo74YYV3Db6Rhfj6VTUPA/wXUHlm
         318Q==
X-Gm-Message-State: AOAM531LH2Bjc/1DXUJJfU+LPGmSHlQ442lL6CiFvPIWu2mQDhELF3qg
        OL9yKYMim/B35FjPi0faZylnVJr3QUMRaBvipAkbEg==
X-Google-Smtp-Source: ABdhPJxOSRLyeRFQOklWTRHy7cXiZuJLGYvvg5iD+qxNCg1OQzXMRA8UWdanZZV6xUeHz+6I/QY9A0J3mJIJSWi9Ffc=
X-Received: by 2002:a05:6512:39c7:b0:46b:8140:fb45 with SMTP id
 k7-20020a05651239c700b0046b8140fb45mr8384160lfu.361.1650302093981; Mon, 18
 Apr 2022 10:14:53 -0700 (PDT)
MIME-Version: 1.0
References: <20220418121203.462784814@linuxfoundation.org> <20220418121212.002023130@linuxfoundation.org>
In-Reply-To: <20220418121212.002023130@linuxfoundation.org>
From:   Oliver Upton <oupton@google.com>
Date:   Mon, 18 Apr 2022 10:14:42 -0700
Message-ID: <CAOQ_QsgUrEyqLmjWPP2k_EUgp-VYv7ocT1w6EbJD=mxU+gPAfw@mail.gmail.com>
Subject: Re: [PATCH 5.17 183/219] KVM: Dont create VM debugfs files outside of
 the VM directory
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        stable@kernel.org, Marc Zyngier <maz@kernel.org>,
        Sean Christopherson <seanjc@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

On Mon, Apr 18, 2022 at 5:24 AM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> From: Oliver Upton <oupton@google.com>
>
> commit a44a4cc1c969afec97dbb2aedaf6f38eaa6253bb upstream.
>
> Unfortunately, there is no guarantee that KVM was able to instantiate a
> debugfs directory for a particular VM. To that end, KVM shouldn't even
> attempt to create new debugfs files in this case. If the specified
> parent dentry is NULL, debugfs_create_file() will instantiate files at
> the root of debugfs.
>
> For arm64, it is possible to create the vgic-state file outside of a
> VM directory, the file is not cleaned up when a VM is destroyed.
> Nonetheless, the corresponding struct kvm is freed when the VM is
> destroyed.
>
> Nip the problem in the bud for all possible errant debugfs file
> creations by initializing kvm->debugfs_dentry to -ENOENT. In so doing,
> debugfs_create_file() will fail instead of creating the file in the root
> directory.
>
> Cc: stable@kernel.org
> Fixes: 929f45e32499 ("kvm: no need to check return value of debugfs_create functions")
> Signed-off-by: Oliver Upton <oupton@google.com>
> Signed-off-by: Marc Zyngier <maz@kernel.org>
> Link: https://lore.kernel.org/r/20220406235615.1447180-2-oupton@google.com
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

Can you drop this patch from stable for the time being? There's a bug
in it because KVM does init/destroy awkwardly. Sean working on a fix
[1].

[1]: https://lore.kernel.org/kvm/20220415004622.2207751-1-seanjc@google.com/

--
Thanks,
Oliver
