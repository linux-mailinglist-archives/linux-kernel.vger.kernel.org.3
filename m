Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 204FB58D075
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Aug 2022 01:25:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244419AbiHHXZn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Aug 2022 19:25:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237145AbiHHXZh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Aug 2022 19:25:37 -0400
Received: from mail-yb1-xb2f.google.com (mail-yb1-xb2f.google.com [IPv6:2607:f8b0:4864:20::b2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71C58167E6
        for <linux-kernel@vger.kernel.org>; Mon,  8 Aug 2022 16:25:35 -0700 (PDT)
Received: by mail-yb1-xb2f.google.com with SMTP id e127so15946270yba.12
        for <linux-kernel@vger.kernel.org>; Mon, 08 Aug 2022 16:25:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=73cKPFgN9gZ8ltMONiXdX091+tMrsz21e0W09IrrYVM=;
        b=XD4epq/wDO2pmaef1oiInC2dvEJIqvjq3q43Jfyj+ci5MUe0R+m7gQ5gr1x+XrMC76
         LwLhtdXIbgRaVYj9MQHPhkljoWaVUbOD+Rn2R/6VQJfsCEUnZFnf0jVXFjOKLFdW6lBI
         AQd3NhDC5HNC3/vyl8bHZJAkJILyum23NniPcQLdokRSRh3BOH9Pvf+6pzNo9iHp97GO
         k+JFH6u4VVeMcZD5etwHx3zffyFTqC6FwhBiOzN9Qi+PU0a55A/i9Qsq66IR5/bRPQl6
         Wo8EHYyvtyS5q4HqsP0RoQyycONWLoK9J3yYPmOqKiFDyUUXf5a88zIoeXUvyeGRrLXP
         U/6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=73cKPFgN9gZ8ltMONiXdX091+tMrsz21e0W09IrrYVM=;
        b=Zlicn2Ro6SLqNJUW7yT0B1dR5Zm9D4f6d7FdLLVh2MRYjx0qHQkOPQfgc57NsNKfWI
         HfxuM9NqEmXaomoqzLhIxjSkVbRGZ3foX2jUJJ9r5vPsWzI3OoG2QGS7naTxnyh8poB0
         VFgSVEKSX496DpxVpRVvZOQ0wuI7iBc1v1jAdRXpafkarhKWywMuVkqIA+fsTP2QFDIW
         WNX1ekMMH5D1gCdeqR9tdtaPpu31sG43u7RmzbC2Z3Z/NVTAee/ziq20jVgcw0OrpECD
         YgPRRo5ikt7YRuaOg6bVuCQJbREKW+UDSz//3b+IDyueA+zIao/WL1TTPSDrANtpbW5e
         7s3A==
X-Gm-Message-State: ACgBeo2tX540x5en7d7jVVRi22jIR98O3y89UPMvdvJghjCqC1I6r9ya
        aaJzbZ+QHP3C9cJv0LDBHu/t7/Sh+bPVX5l5pUlmeA==
X-Google-Smtp-Source: AA6agR7NkhA/E2JJDWORK66aLcG/g1ZA5bYxFqc7io395Oy9dAKo9LEzL/8YuEkKlHfrKtLYRxQ/RoMYCYQoZ3yVrLc=
X-Received: by 2002:a05:6902:1021:b0:676:ed79:5733 with SMTP id
 x1-20020a056902102100b00676ed795733mr18366577ybt.509.1660001134604; Mon, 08
 Aug 2022 16:25:34 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1655761627.git.ashish.kalra@amd.com> <d325cb5d7961f015400999dda7ee8e08e4ca2ec6.1655761627.git.ashish.kalra@amd.com>
 <YukZFKpAO5o5MLA1@kernel.org> <CAAH4kHazh_S4zTLimL3Bch7yo3zL2wv86j=w3f2n74O-joWLQQ@mail.gmail.com>
 <a4b82687-7143-35c5-ee90-003a9f2a088c@amd.com>
In-Reply-To: <a4b82687-7143-35c5-ee90-003a9f2a088c@amd.com>
From:   Dionna Amalie Glaze <dionnaglaze@google.com>
Date:   Mon, 8 Aug 2022 16:25:23 -0700
Message-ID: <CAAH4kHYHu_FMJJiSNXbSZLn1y297FVq-LdZF7Tmq3t58nfLuLQ@mail.gmail.com>
Subject: Re: [PATCH Part2 v6 17/49] crypto: ccp: Add the SNP_{SET,GET}_EXT_CONFIG
 command
To:     Tom Lendacky <thomas.lendacky@amd.com>
Cc:     Jarkko Sakkinen <jarkko@kernel.org>,
        Ashish Kalra <Ashish.Kalra@amd.com>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "open list:X86 KVM CPUs" <kvm@vger.kernel.org>,
        linux-coco@lists.linux.dev,
        Linux Memory Management List <linux-mm@kvack.org>,
        linux-crypto@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Joerg Roedel <jroedel@suse.de>,
        hpa@zytor.com, Ard Biesheuvel <ardb@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <seanjc@google.com>, vkuznets@redhat.com,
        Jim Mattson <jmattson@google.com>,
        Andy Lutomirski <luto@kernel.org>, dave.hansen@linux.intel.com,
        slp@redhat.com, Peter Gonda <pgonda@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        srinivas.pandruvada@linux.intel.com,
        David Rientjes <rientjes@google.com>, dovmurik@linux.ibm.com,
        tobin@ibm.com, Borislav Petkov <bp@alien8.de>,
        "Roth, Michael" <michael.roth@amd.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        Andi Kleen <ak@linux.intel.com>, tony.luck@intel.com,
        Marc Orr <marcorr@google.com>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Alper Gun <alpergun@google.com>, dgilbert@redhat.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Would it be burden to supply all the certificates, both system and per-VM,
> in this KVM call? On the SNP Extended Guest Request, the hypervisor could
> just check if there is a per-VM blob and return that or else return the
> system-wide blob (if present).
>

I think that's fine by me. We can use SNP_GET_EXT_CONFIG, merge in
user space, and create an instance override with a KVM ioctl without
touching ccp.

-- 
-Dionna Glaze, PhD (she/her)
