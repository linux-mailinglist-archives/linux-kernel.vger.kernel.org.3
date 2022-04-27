Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7832511085
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 07:28:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357857AbiD0Fba (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 01:31:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242013AbiD0Fb2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 01:31:28 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6713012194A;
        Tue, 26 Apr 2022 22:28:18 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id g23so620227edy.13;
        Tue, 26 Apr 2022 22:28:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=OmFfBKBvjXjBUi32eJz6KqWWe+VBykXhnFIMt6kZrPA=;
        b=VKF80W9fKkrHobaNWG6+jlexuZpjlYTkta79tRkZgiz1nVADhCqsm6FKiL6csRUdjz
         JSkotuedZJyK80hxkRz9g63COsSodweG1uLO9NBvJlBVZZvkud49fD2IUtgBaESQRGF/
         GW3u6yFsUXuvtNhpA5kIUtMvDEwu5eb4ZWHyqbdAms6KhRq4lfyCL5eFipL/NsHa+W0R
         LWdEwrJwdWLNRRtTAhjzcgtLHa1dShCnCPIWZZUWg7gvzxHMcFALsVjUPFNfd8qoqq0W
         ODeXIzrSIPU55JfZ19Mmx73lEKEs2ui+Fn9JwJ7ME0NrHJbkijJV+4ujLrVLj/HqUMyQ
         MTIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=OmFfBKBvjXjBUi32eJz6KqWWe+VBykXhnFIMt6kZrPA=;
        b=FOvmlOcXP5AQljbpXRq6jgmO9pJ3ZSFkem4J+Hu1n4xcLoCsOBw0lXwoxOqNWfDXXX
         lZNSBkddDpIJxdJXq4YYyM95DhnosZ61dpcBguBUCVGFRRMQBpznWsdMTwgRbe9+yi7d
         ACEqrhs8tGlb4v8r53jFgKmk0PgtxqouzWYw+ckWPEcH0LkbG8XCqdOfoH9d2If5vQO0
         GR2rGdoMWh0VmcsCb/BRi+93p4hNAKxukJpfRpNsMA6lwL8OidffFrBo98mdWX0AtzqW
         tUYArQCoDRmNv6E4x8nkdjMDMxelhA+rFp1IPJ+O9LSV9OYO2252Pi327TTElwfEEfJd
         Vcog==
X-Gm-Message-State: AOAM532/MmQ+GBskAue8gij42tY2zxRurRY7NAVLFAV3p4qMii8pLumA
        fOWyjEa6RWlMJzQ7NfKVEHE=
X-Google-Smtp-Source: ABdhPJxlWhm6y16PcnsGfzyfaskCHjeUFOul0gTxv+QCvWXYqmPxQGE4L6lNMH+wgHmtutAMMai44g==
X-Received: by 2002:aa7:de93:0:b0:418:d700:662a with SMTP id j19-20020aa7de93000000b00418d700662amr28175416edv.107.1651037296832;
        Tue, 26 Apr 2022 22:28:16 -0700 (PDT)
Received: from leap.localnet (host-79-50-86-254.retail.telecomitalia.it. [79.50.86.254])
        by smtp.gmail.com with ESMTPSA id n13-20020a170906724d00b006cedd6d7e24sm6037171ejk.119.2022.04.26.22.28.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Apr 2022 22:28:15 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     Ira Weiny <ira.weiny@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Will Deacon <will@kernel.org>,
        Peter Collingbourne <pcc@google.com>,
        Vlastimil Babka <vbabka@suse.cz>, linux-kernel@vger.kernel.org,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        outreachy@lists.linux.dev,
        "Acked-by : Mike Rapoport" <rppt@linux.ibm.com>
Subject: Re: [PATCH v2 1/4] mm/highmem: Fix kernel-doc warnings in highmem*.h
Date:   Wed, 27 Apr 2022 07:28:13 +0200
Message-ID: <2383038.jE0xQCEvom@leap>
In-Reply-To: <YmfRynAhuSWz9H+e@linutronix.de>
References: <20220425162400.11334-1-fmdefrancesco@gmail.com> <4396926.LvFx2qVVIh@leap> <YmfRynAhuSWz9H+e@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On marted=C3=AC 26 aprile 2022 13:04:42 CEST Sebastian Andrzej Siewior wrot=
e:
> On 2022-04-26 11:43:03 [+0200], Fabio M. De Francesco wrote:
>=20
> Either way, according to the code kmap_atomic() does not always disable
> preemption=20

Hi Sebastian,

In my last email (for patch 4/4) I wrote that I would add a deprecation=20
notice to kunmap_local() and would talk about thread locality in=20
kmap_local_page(). I want to confirm that I'll do these changes in v3.

Then I closed that email asking if I was still overlooking something.=20
Consider that I'm relatively new to kernel development and that it's just=20
something I do in my spare time. So I was pretty sure I was still missing=20
something :)

After reading again the code of kmap_atomic() (as you suggested - thanks!)=
=20
I noted that you correctly say that kmap_atomic() does not always disables=
=20
preemption (i.e., preemption is disabled only for !PREEMPT_RT kernel's =20
configurations).

Therefore I'll also change the first sentence of kunmap_local() to the=20
following:

"[It] Unmaps an address previously mapped by kmap_atomic() and re-enables=20
pagefaults and preemption (the latter disabled only for !PREEMP_RT=20
configurations).".

I will also be making this change in v3.

Can you please say if I'm still missing something?

Thanks,

=46abio



