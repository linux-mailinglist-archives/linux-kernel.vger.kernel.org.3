Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76EA94A7522
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Feb 2022 17:00:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345619AbiBBP6j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Feb 2022 10:58:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345611AbiBBP6i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Feb 2022 10:58:38 -0500
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30C7DC061714
        for <linux-kernel@vger.kernel.org>; Wed,  2 Feb 2022 07:58:38 -0800 (PST)
Received: by mail-pj1-x1030.google.com with SMTP id z10-20020a17090acb0a00b001b520826011so7241996pjt.5
        for <linux-kernel@vger.kernel.org>; Wed, 02 Feb 2022 07:58:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Eu7UtipXKhJuZYLgqyG2W5R8xjd0BRCq/AEfSVc5hGw=;
        b=hmp1nsoHocmtnFFGGz009yO4BoykxPo3j9vOnfcmIMcTHC+cuOHcKvAKDAKcs78lnh
         zmDUFUpzX0UXrYA7gDHRqHO3Y7D4nF3ECQZnAkxAE3VEYfKLgOfKYZaciZldwXAhMOLH
         SalflKwf5cGSW4A6qVMDEzhNE4BtO7jbeD7Z7DbPawuWuN5CMNF5g4zbQj/mP2l1Sy+i
         vakSEHh4WQYsFPCevjt9U0PITcoAPERscIfFRgcyUWwSckWOQ1eX3DOsifIi5pJ6V2ai
         OqtI0t6hPQbSpzDIuK0yJGcUqoDXEx9Iaqk8XtQt8bxRwo8vhHN4vbOYTjcUI6w5Adun
         phrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Eu7UtipXKhJuZYLgqyG2W5R8xjd0BRCq/AEfSVc5hGw=;
        b=HSVAPjIX46qDO+qym3nhO+DFoUNOOajUkHhUo1hSPNHDRCWfTO68I8NuJjiiLnB3JW
         wkE+r/JuTIrFqqUbIcvBfwjHKhKckN3DUoyvh42SJE4zihDIV2KJgaDQ2KZBzFESd05Z
         4+2fjRdYmcY8a8N+LgZgBruWb2ChcjMAv7HdGTw5geV80kpL1e5/2IH8okeYOm+TPZtU
         kGYvJ7fT6pubE5F+pqkUlzy7MN9dS3hG/1aIYs+FWcVId4/3UuBsdIHokwEaIgWKEp5t
         0by5lhK/wBf4N5AASS6F1c2jnmmbGE7Yn6UZJP7qNc2v6fYVGhG7NJku/irx0Mqz/K/b
         OZzQ==
X-Gm-Message-State: AOAM530d/fRRxVNW6pOj4YyoSUDEmdSAjfsNNxGF0PnRDhav1K+Vy0vf
        4WIBE/1p+XiBD10AEjMEvIrLBSWzV1A76Q==
X-Google-Smtp-Source: ABdhPJzSqoZaSZ+RrUPC3NhpZBERPaO2f8YjUHAKOavOg0CnjZksj+S47/oBnsHLxIPLmspox/I8/g==
X-Received: by 2002:a17:90b:3b52:: with SMTP id ot18mr8921394pjb.34.1643817517519;
        Wed, 02 Feb 2022 07:58:37 -0800 (PST)
Received: from google.com (157.214.185.35.bc.googleusercontent.com. [35.185.214.157])
        by smtp.gmail.com with ESMTPSA id f15sm24958295pfn.19.2022.02.02.07.58.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Feb 2022 07:58:36 -0800 (PST)
Date:   Wed, 2 Feb 2022 15:58:33 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Cc:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org, x86@kernel.org,
        mlevitsk@redhat.com, pbonzini@redhat.com, joro@8bytes.org,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        peterz@infradead.org, hpa@zytor.com, jon.grimm@amd.com
Subject: Re: [PATCH v4 0/3] svm: avic: Allow AVIC support on system w/
 physical APIC ID > 255
Message-ID: <YfqqKSARjNGx52cJ@google.com>
References: <20220202041112.273017-1-suravee.suthikulpanit@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220202041112.273017-1-suravee.suthikulpanit@amd.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 01, 2022, Suravee Suthikulpanit wrote:
> Originally, AMD SVM AVIC supports 8-bit host physical APIC ID.
> However, newer AMD systems can have physical APIC ID larger than 255,
> and AVIC hardware has been extended to support upto 12-bit host
> physical APIC ID.
> 
> This series introduces a helper function in the APIC subsystem to get
> the maximum physical APIC ID allowing the SVM AVIC driver to calculate
> the proper size to program the host physical APIC ID in the AVIC
> physical APIC ID table entry.

NAK to this version.  Please wait until discussion on the previous versions comes
to a stop.  If a reviewer is non-responsive then that's one thing, but we were
literally just discussing this yesterday.
