Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D6BBD46B22A
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Dec 2021 06:23:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233643AbhLGF0o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Dec 2021 00:26:44 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:50397 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232346AbhLGF0l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Dec 2021 00:26:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1638854590;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=nOPl6fNnDqyLc2iLRZj8llqR0D/uS4usdUmozPcKuBE=;
        b=VArzJRbL888UNQzJa+P7H1l54b+aV+xroJ47hwupvQfdu//dDRxIgCuOzFOMAtJK2WO4la
        Fjf3L0rNrniboPQf+Zt2XYe9ZqB5VrT4CUQGSRpXPsbUnlVTG02B9b9MulQ7gJtRUAjLQM
        fz8AJW39jzL+Osgnkb14i5O9hDbRDGI=
Received: from mail-ot1-f69.google.com (mail-ot1-f69.google.com
 [209.85.210.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-547-BOuJp-pxPXOQR7uwScntWA-1; Tue, 07 Dec 2021 00:23:09 -0500
X-MC-Unique: BOuJp-pxPXOQR7uwScntWA-1
Received: by mail-ot1-f69.google.com with SMTP id n13-20020a9d6f0d000000b00579e30aaa02so5264224otq.0
        for <linux-kernel@vger.kernel.org>; Mon, 06 Dec 2021 21:23:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=nOPl6fNnDqyLc2iLRZj8llqR0D/uS4usdUmozPcKuBE=;
        b=sRxVzur6kwylDYD1LVHA4TY+JvLhymHcP/FHPZJI2tThkFrai3S5Doc2IDh+BLL6JL
         rEwqZzakGOrxXpd5mqUTGupNA1raKyH52A3kVKzYaQH06zy2YTDrYjMA4cEjJt00TtuD
         iKgV0ObtpSGNUl6Yq/wy27ngc1HoBKkYrvl8r/Qii0vg0oWxJJqQcpt7Y95bN5wuMWDC
         xzLwv+Wcmud6upUkE9fzSJIzcm23JHb7KEE4k3YA/2qoDwOT3XukHORIDppv5EJ4QzFK
         jdQA0reVHOrpUE0E+nvbwsbtwRuXVuzDJ6cDt+XsSI+Dux8SMS9GG+Ip/fWuK7najHud
         h3Ig==
X-Gm-Message-State: AOAM530u8OoaMgJlwovuI1tkJiVmFT54jYjtbzqLEUf+3iKXVTGA5tGc
        WUQu2L/DQd1D3u9pZtnMJV/DfNoPG/fWdwNpkzI/G+aIrqQ6+2oTIxRsp+M2hZuMAVqb0Ta9h0B
        gXpWdbNzXBXUaxVKBS63+4fk/
X-Received: by 2002:a05:6808:15a:: with SMTP id h26mr3160607oie.36.1638854588441;
        Mon, 06 Dec 2021 21:23:08 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxeB7ysFyGExc4t3uLswmEafqkwWmLqI1VRqyDPAPC4Fj2ymiEfFyeiBEy2cjuHo8VI9/cUjQ==
X-Received: by 2002:a05:6808:15a:: with SMTP id h26mr3160593oie.36.1638854588275;
        Mon, 06 Dec 2021 21:23:08 -0800 (PST)
Received: from treble ([2600:1700:6e32:6c00::45])
        by smtp.gmail.com with ESMTPSA id x12sm2569041oom.44.2021.12.06.21.23.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Dec 2021 21:23:07 -0800 (PST)
Date:   Mon, 6 Dec 2021 21:23:04 -0800
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     linux-kernel@vger.kernel.org, Borislav Petkov <bp@alien8.de>,
        Jiri Slaby <jslaby@suse.cz>,
        Peter Zijlstra <peterz@infradead.org>, ardb@kernel.org,
        broonie@kernel.org, catalin.marinas@arm.com,
        dave.hansen@linux.intel.com, linux-arm-kernel@lists.infradead.org,
        maz@kernel.org, mingo@redhat.com, tabba@google.com,
        tglx@linutronix.de, will@kernel.org
Subject: Re: [RFC PATCH 0/6] linkage: better symbol aliasing
Message-ID: <20211207052304.pb76ofjymf7o2yyb@treble>
References: <20211206124715.4101571-1-mark.rutland@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20211206124715.4101571-1-mark.rutland@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 06, 2021 at 12:47:09PM +0000, Mark Rutland wrote:
> This avoids repetition and hopefully make it easier to ensure
> consistency (e.g. so each function has a single canonical name and
> associated metadata).
> 
> I'm sending this as an RFC since I want to check:
> 
> a) People are happy with the idea in principle.
> 
> b) People are happy with the implementation within <linux/linkage.h>.
> 
> ... and I haven't yet converted the headers under tools/, which is
> largely a copy+paste job.

Looks like a definite improvement to me.

The only suggestion I'd have would be to fix a minor naming
inconsistency: change "SYM_FUNC_LOCAL_ALIAS" to "SYM_FUNC_ALIAS_LOCAL"
to match the other "<noun>_<verb>" macros.

-- 
Josh

