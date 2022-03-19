Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2D284DEAE2
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Mar 2022 21:47:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244248AbiCSUsq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Mar 2022 16:48:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244246AbiCSUsa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Mar 2022 16:48:30 -0400
X-Greylist: delayed 1975 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sat, 19 Mar 2022 13:47:04 PDT
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF05F264828
        for <linux-kernel@vger.kernel.org>; Sat, 19 Mar 2022 13:47:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
        s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
        References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=6ajcZfSkznJBpCyliSlqPagKhVWKG3TW6xOBEMsIzac=; b=pT0Adt9XqRLNv15aAKGfOgaJCl
        /3v88gNHwz7bu8M5E4XjoGp4rSJB1TZQtaJHr9PG0USx7pP7sLgB+sUIS25zRG7tiuhRA5UUmjUoF
        IMqS4CEPG4quEhWvjt4ZbwMMKOgRS6AuM1URLv3qg/1SvW/02xoV3NFD5DioprD1h9lXyCSGJmSU3
        1rTWSsop99nDq6rNMDLzs79l4JRnmatvtgYCSvPVYjMH5NnijoMmthsw3bFZEYfm6bH5CwW+kvk6T
        v0hUXsbluftG2VSsi3uObTPXsfw6qWwTgQbXCgCjT4FLWtsRDV8hfxzsd1yLKaZx1ZIr4LYyypl16
        B2EiUx/A==;
Received: from [187.39.124.208] (helo=[192.168.0.110])
        by fanzine2.igalia.com with esmtpsa 
        (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
        id 1nVfSE-00047T-NZ; Sat, 19 Mar 2022 21:13:39 +0100
Message-ID: <c06a21cc-e1c1-e627-f908-ebc2a041e29a@igalia.com>
Date:   Sat, 19 Mar 2022 17:13:21 -0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [RFC 0/4] Support kdump with LUKS encryption by reusing LUKS
 master key
Content-Language: en-US
To:     Coiby Xu <coxu@redhat.com>, kexec@lists.infradead.org
Cc:     Milan Broz <gmazyland@gmail.com>,
        Thomas Staudt <tstaudt@de.ibm.com>,
        Kairui Song <ryncsn@gmail.com>, dm-devel@redhat.com,
        Mike Snitzer <snitzer@redhat.com>, Baoquan He <bhe@redhat.com>,
        Dave Young <dyoung@redhat.com>, linux-kernel@vger.kernel.org
References: <20220318103423.286410-1-coxu@redhat.com>
From:   "Guilherme G. Piccoli" <gpiccoli@igalia.com>
In-Reply-To: <20220318103423.286410-1-coxu@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18/03/2022 07:34, Coiby Xu wrote:
> [...]
> Based on Milan's feedback [1] on Kairui's ideas to support kdump with
> LUKS encryption, this patch set addresses the above issues by
>  1) first saving the LUKS master key to kexec when opening the encrypted
>     device 
>  2) then saving the master key to the reserved memory for kdump when 
>     loading kdump kernel image.
> 
> So the LUKS master key never leaves the kernel space and once the key has
> been saved to the reserved memory for kdump, it would be wiped 
> immediately. If there is no security concern with this approach or any
> other concern, I will drop the following assumptions made for this RFC
> version in v1,
>  - only x86 is supported
>  - there is only one LUKS device for the system
> 
> to extend the support to other architectures including POWER, ARM and
> s390x and address the case of multiple LUKS devices. Any feedback will be 
> appreciated, thanks!
> 

Hi Coiby, thanks for the very interesting work!
I confess I didn't review the code as I have not much experience in
dm-crypt/key management, but I have a generic question related with the
motivation of the patch set.

My understanding is that one (the main?) motivation of this series would
be to protect the saved memory (vmcore) from being read by some
"unauthorized" entity - in order to achieve this goal, it is hereby
proposed to allow kdump kernel to access a memory-saved key and with
that, mount an encrypted volume, saving the vmcore over there correct?

So, what if instead of playing with the volume key, users with this
concern address that by reserving some *unencrypted partition* for
saving the vmcore, but then *encrypt the vmcore* itself! So, instead of
requiring saving a full-volume key, mount everything, risk data
corruption if something goes bad...we just have makedumpfile encrypting
the vmcore with some preloaded key (which might be saved inside the
kdump minimal intird, for example), and saving the encrypted file into a
clear/unencrypted volume? This way we also prevent excessive memory
consumption during kdump due to the lvm/dm-userspace paraphernalia usage.

Does it make sense or am I being silly or missing something?
Cheers,


Guilherme
