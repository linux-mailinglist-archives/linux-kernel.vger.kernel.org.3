Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E670049766E
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jan 2022 01:25:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240566AbiAXAZY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Jan 2022 19:25:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235008AbiAXAZV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jan 2022 19:25:21 -0500
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 896D0C06173B
        for <linux-kernel@vger.kernel.org>; Sun, 23 Jan 2022 16:25:21 -0800 (PST)
Received: by mail-pj1-x1029.google.com with SMTP id h20-20020a17090adb9400b001b518bf99ffso11531733pjv.1
        for <linux-kernel@vger.kernel.org>; Sun, 23 Jan 2022 16:25:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=axtens.net; s=google;
        h=from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=z7ejXSlc8OqC7clFdQTxKINIGsB0NXecYA0uP7W7k78=;
        b=epwX248blShsiZ0DXijFNoZpYhbWaWUbV/3I81aYCW90KS8XOZnXXHBobumzy/VxAq
         L4m1MQ4AuTZf/gwbLFjwlVJkv9Tm51iEjxXAM8hl/EJB+SAfu2YW9iCxMSBQhmSplO5D
         Yt+aaYG/9AY3+dVDQbIvphbOjBKfYZBbzBOs0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=z7ejXSlc8OqC7clFdQTxKINIGsB0NXecYA0uP7W7k78=;
        b=Lare01wdyMdJUmY6RUHTvMVr7fuCIUsg64Lv72OQJN8NJ3t0XPjkGMznY3gZpMJWqH
         0PLlOnXyAEU75d6qOZh4iMui58pTqA/sAao3FfsdkjozyshEHegDQ3GU9XxFGKpc4HTl
         otUq+doLLzQDphUMIelXqz6c3TbKl/faV3huPUhQmcF7crRwVrwlRFPk5sKPEsKZOptE
         ROlmDFVNMWiKPxBT33cAL9LwNiyqf817al/GVTTguXOXmuKVA//QnyRhm4CELpmnT74V
         Odmg4vjdtLCnUSPTxT2nylikZUC24gsFzZ2d5ET8WrWpbfon3uyuY96j+j1+P+wA8yLe
         BQyQ==
X-Gm-Message-State: AOAM530JBgMOysYVWXDs0CGNbj0T1/pQuYLB8K2mdG62RB++S9lN5tNN
        /Gcx/yV8m83idOHyV6d9LkOPAYlPrPscXg==
X-Google-Smtp-Source: ABdhPJxI6xCUpjBCqmH79kC+VS2aIykW6ObPxGxUX5LaCRPBLzK+fuG+C/VuEMqgpKAVvt/rNogj+A==
X-Received: by 2002:a17:903:22cf:b0:14b:5079:3fa7 with SMTP id y15-20020a17090322cf00b0014b50793fa7mr2562980plg.148.1642983921031;
        Sun, 23 Jan 2022 16:25:21 -0800 (PST)
Received: from localhost ([2001:4479:e300:600:c66b:6249:d8f2:7a6])
        by smtp.gmail.com with ESMTPSA id q8sm7921571pfl.143.2022.01.23.16.25.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Jan 2022 16:25:20 -0800 (PST)
From:   Daniel Axtens <dja@axtens.net>
To:     Greg KH <gregkh@linuxfoundation.org>,
        Nayna Jain <nayna@linux.ibm.com>
Cc:     linuxppc-dev@lists.ozlabs.org,
        Michael Ellerman <mpe@ellerman.id.au>,
        George Wilson <gcwilson@linux.ibm.com>,
        Douglas Miller <dougmill@linux.vnet.ibm.com>, gjoyce@ibm.com,
        linux-kernel@vger.kernel.org, mjg59@srcf.ucam.org
Subject: Re: [RFC PATCH 0/2] powerpc/pseries: add support for local secure
 storage called Platform Keystore(PKS)
In-Reply-To: <YeuyUVVdFADCuDr4@kroah.com>
References: <20220122005637.28199-1-nayna@linux.ibm.com>
 <YeuyUVVdFADCuDr4@kroah.com>
Date:   Mon, 24 Jan 2022 11:25:17 +1100
Message-ID: <87sftec74i.fsf@dja-thinkpad.axtens.net>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

> Ok, this is like the 3rd or 4th different platform-specific proposal for
> this type of functionality.  I think we need to give up on
> platform-specific user/kernel apis on this (random sysfs/securityfs
> files scattered around the tree), and come up with a standard place for
> all of this.

I agree that we do have a number of platforms exposing superficially
similar functionality. Indeed, back in 2019 I had a crack at a unified
approach: [1] [2].

Looking back at it now, I am not sure it ever would have worked because
the semantics of the underlying firmware stores are quite
different. Here are the ones I know about:

 - OpenPower/PowerNV Secure Variables:
 
   * Firmware semantics:
     - flat variable space
     - variables are fixed in firmware, can neither be created nor
        destroyed
     - variable names are ASCII
     - no concept of policy/attributes
     
   * Current kernel interface semantics:
     - names are case sensitive
     - directory per variable     


 - (U)EFI variables:
 
   * Firmware semantics:
     - flat variable space
     - variables can be created/destroyed but the semantics are fiddly
        [3]
     - variable names are UTF-16 + UUID
     - variables have 32-bit attributes

   * efivarfs interface semantics:
     - file per variable
     - attributes are the first 4 bytes of the file
     - names are partially case-insensitive (UUID part) and partially
        case-sensitive ('name' part)

   * sysfs interface semantics (as used by CONFIG_GOOGLE_SMI)
     - directory per variable
     - attributes are a separate sysfs file
     - to create a variable you write a serialised structure to
        `/sys/firmware/efi/vars/new_var`, to delete a var you write
        to `.../del_var`
     - names are case-sensitive including the UUID


 - PowerVM Partition Key Store Variables:
 
   * Firmware semantics:
     - _not_ a flat space, there are 3 domains ("consumers"): firmware,
        bootloader and OS (not yet supported by the patch set)
     - variables can be created and destroyed but the semantics are
        fiddly and fiddly in different ways to UEFI [4]
     - variable names are arbitrary byte strings: the hypervisor permits
        names to contain nul and /.
     - variables have 32-bit attributes ("policy") that don't align with
        UEFI attributes

   * No stable kernel interface yet

Even if we could come up with some stable kernel interface features
(e.g. decide if we want file per variable vs directory per variable), I
don't know how easy it would be to deal with the underlying semantic
differences - I think userspace would still need substantial
per-platform knowledge.

Or have I misunderstood what you're asking for? (If you want them all to
live under /sys/firmware, these ones all already do...)

Kind regards,
Daniel


[1]: https://lists.ozlabs.org/pipermail/linuxppc-dev/2019-May/190735.html
[2]: discussion continues at https://lists.ozlabs.org/pipermail/linuxppc-dev/2019-June/191365.html
[3]: https://lists.ozlabs.org/pipermail/linuxppc-dev/2019-June/191496.html

[4]: An unsigned variable cannot be updated, it can only be deleted
     (unless it was created with the immutable policy) and then
     re-created. A signed variable, on the other hand, can be updated
     and the only way to delete it is to submit a validly signed empty
     update.
